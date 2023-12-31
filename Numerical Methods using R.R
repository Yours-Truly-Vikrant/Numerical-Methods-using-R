#Bisection Method
#1)x^3-2x-5=0
f=function(x){return(x^3-2*x-5)}
a=1
b=3
x=(a+b)/2
df=data.frame(a,b,x,f(a),f(b),f(a)*f(x))
df
## a b x f.a. f.b. f.a....f.x.
## 1 1 3 2 -6 16 6
#`colnames<-`(df,c("a","b","x","F(a)","F(b)","F(a)*F(x)"))
for(i in seq(2,15))
{
  if(f(a)*f(x)<=0){b=x}else{a=x}
  x=(a+b)/2
  df=rbind(df,data.frame(a,b,f(a),f(b),x,f(a)*f(x)))
}
df


#2)xtan(x)+1=0
f=function(x){return(x*tan(x)+1)}
a=2
b=3
x=(a+b)/2
df=data.frame(a,b,x,f(a),f(b),f(a)*f(x))
df
for(i in seq(2,3))
{
  if(f(a)*f(x)<=0){b=x}else{a=x}
  x=(a+b)/2
  df=rbind(df,data.frame(a,b,f(a),f(b),x,f(a)*f(x)))
}
df

c(x,f(x))


#or
f=function(x){return(x*tan(x)+1)}
a=2
b=3
x=(a+b)/2
err=1
df=data.frame(a,b,f(a),f(b),x,f(x))
while(err>=0.00001){
  x0=x
  if(f(a)*f(x)<=0){b=x}else{a=x}
  x=(a+b)/2
  df=rbind(df,data.frame(a,b,f(a),f(b),x,f(x)))
  err=abs(x-x0)
}
df
cat("x=",x,"f(x)=",f(x))


#Regula Falsi Method
#x^3-5x+1=0 
f=function(x){return(x^3-5*x+1)}
x0=0
x1=1
x2=x1-((x1-x0)/(f(x1)-f(x0)))*f(x1)
err=1
df=data.frame(x2,f(x2))
while(err>=0.00001){
  err=abs(x2-x1)
  x0=x1
  x1=x2
  x2=x1-(x1-x0)*f(x1)/(f(x1)-f(x0))
  df=rbind(df,data.frame(x2,f(x2)))
}
df
cat("x=",x2,"f(x)=",f(x2))





#Newton Raphson Method
f=function(x){return(x^2-4*x-7)}
f1=function(x){return(2*x-4)}
x=rep(0,100)
x[1]=5
err1=1
i=1
while(err1>=0.0001){x[i+1]=x[i]-(f(x[i])/f1(x[i]));
err1=abs(x[i+1]-x[i]);
i=i+1;
}
x[1:i]
data.frame("x"=x[1:i],"fx"=f(x[1:i]))




##Linear System of Algebraic Equations
#Direct Method
# 1)Gauss Elimination Method
A=matrix(c(0,2,5,7,1,-2,2,3,8), nrow=3,byrow=T)
b=c(7,6,13)
A=cbind(A,b)
if(min(diag(A))==0){A=A[c(2,1,3),]} 
A
if(A[2,1]!=0){A[2,]=A[2,]-A[2,1]*A[1,]/A[1,1]}
if(A[3,1]!=0){A[3,]=A[3,]-A[3,1]*A[1,]/A[1,1]}
A
if(A[3,2]!=0){A[3,]=A[3,]-A[3,2]*A[2,]/A[2,2]}
A 
x=c(0,0,0)
x[3]=A[3,4]/A[3,3]
x[2]=(A[2,4]-A[2,3]*x[3])/A[2,2]
x[1]=(A[1,4]-A[1,2]*x[2]-A[1,3]*x[3])/A[1,1] 
x

#2)Gauss Jordan Method 
A=matrix(c(1,1,1,4,3,-1,3,5,3), nrow=3,byrow=T)
b=diag(3)
A=cbind(A,b)
print(A)
if(A[1,1]!=0){
  A[2,]=A[2,]-A[2,1]/A[1,1]*A[1,]
  A[3,]=A[3,]-A[3,1]/A[1,1]*A[1,]
  print(A)}
if(A[2,2]!=0){
  A[3,]=A[3,]-A[3,2]/A[2,2]*A[2,]
  A[1,]=A[1,]-A[1,2]/A[2,2]*A[2,]
  print(A)}
if(A[3,3]!=0){
  A[2,]=A[2,]-A[2,3]/A[3,3]*A[3,]
  A[1,]=A[1,]-A[1,3]/A[3,3]*A[3,]
  print(A)}
A=A/diag(A)
print(A)

## Iterative Methods
### Gauss Jacobi Iterative Method:
A=matrix(c(4,1,1,1,5,2,1,2,3),nrow=3,ncol=3,byrow=T)
b=matrix(c(2,-6,-4),nrow=3)
x0=c(0,0,0)
x1=c(0,0,0)
err=1
m=x0
while(err>0.00001)
{
  x1[1]=(b[1]-A[1,2]*x0[2]-A[1,3]*x0[3])/A[1,1]
  x1[2]=(b[2]-A[2,1]*x0[1]-A[2,3]*x0[3])/A[2,2]
  x1[3]=(b[3]-A[3,1]*x0[1]-A[3,2]*x0[2])/A[3,3]
  err=max(abs(x0-x1))
  x0=x1
  m=rbind(m,x0)
}
m=data.frame(m)
row.names(m)=seq(0,nrow(m)-1,1)
m



#Gauss-Seidel Iteration Method or Method of successive displacement.
A=matrix(c(45,2,3,-3,22,2,5,1,20),nrow=3,ncol=3,byrow=T)
b=matrix(c(58,47,67),nrow=3)
x0=c(0,0,0)
err=1
m=x0
for(j in 1:10){
  for(i in 1:3){
    x0[i]=(b[i]-(A[i,]%*%x0-A[i,i]*x0[i]))/A[i,i]
  }
  m=rbind(m,x0)
}
m=data.frame(m)
row.names(m)=seq(0,nrow(m)-1,1)
m

#Trapezoidal Rule
a=1;b=2;
f=function(x){return (1/(5+3*x))}
f_int=integrate(f,a,b);f_int
## 0.1061512 with absolute error < 1.2e-15
for(i in seq(2,20,2))
{
  n=i
  h=(b-a)/n
  x=seq(a,b,h)
  s1=h/2*(f(x[1])+f(x[n+1])+2*sum(f(x[2:n])))
  cat("\nApprox Value of integration by n =",i,"is",s1,' and Absolute Error 
:',abs(f_int$value-s1))
  
}


## Simpsonâs 1/3 Rule
f=function(x){return(1/(1+x))}
a=0;b=1;n=6;h=(b-a)/n
x=seq(a,b,h)
y=f(x)
print(y)
s1=y[1]+y[n+1]
s1=(h/3)*(s1+4*sum(y[seq(2,n,2)])+2*sum(y[seq(3,n,2)]))
s1
## Composite Simpsonâs 3/8 Rule
f=function(x){return(1/(5+3*x))}
a=1;b=2;n=6;h=(b-a)/n
x=seq(a,b,h)
y=f(x)
s1=y[1]+y[n+1]
s1=(3*h/8)*(s1+3*sum(y[seq(2,n)])+2*sum(y[seq(4,n,3)]))
s1


#Probability Distribution:
#A) Find the probability that he plays more than four times in one day.
#B) Find the probability that one day leaves the game having win RS600
#C) Calculate the expected winnings per day.
p=0.5
#A) P(X>4)
p1=1-pgeom(4,0.5)
#B) P(X=6)
p2=dgeom(6,0.5)
#C)
Exp=(1/p)*100



#Que2)Find the value of K for following PDF f(x)=k*x^5/5 0<x<1
f=function(x){x^5/5}
k=1/(integrate(f,0,1)$value);k
curve(30*x^5/5)



#Point Estimation:
#Que: Generate 1000 random sample of size n=7 from a population of size N=25,
#where the items in the population are sequentially numbered from 1 to N,What are the method of moments and maximum likelihood estimate of N for these sample.
N=25;n=7
a=matrix(sample(1:N,7000,replace=TRUE),nrow=1000);head(a)
T1=(2*apply(a,1,mean))-1;
T2=apply(a,1,max);
MSE1=mean((T1-N)*(T1-N))
MSE2=mean((T2-N)*(T2-N)) 
plot(density(T1))
lines(density(T2))


#Que: Generate 1000 samples from exponential distribution with mean theta of size 3 
#and find the following estimators of theta: 1)theta1_hat= X1 
# 2)theta2_hat=(X1+X2)/2 
# 3)theta3_hat=Xbar 
# 4)theta4_hat=min{X1,X2,X3}
#A)Find the mean and variance of each estimator.Are any of the estimator efficient?
#B)Which estimator is the MLE?Which estimator is an unbiased estimator of theta?
theta=0.5
s=matrix(rexp(3000,1/theta),nrow=1000)
t1=s[,1]
t2=(s[,1]+s[,2])/2
t3=apply(s,1,mean)
t4=apply(s,1,min)
t=cbind(t1,t2,t3,t4)
Mean=apply(t,2,mean)
Var=apply(t,2,var)
MSE=apply((t-theta)^2,2,mean)
rbind("EST_Mean"=Mean,"Var"=Var,"MSE"=MSE)

names(which.min(MSE))
plot(density(t1,ylim=c(0,5),col=1))
lines(density(t2),col=2)
lines(density(t3),col=3)
lines(density(t4),col=4)









