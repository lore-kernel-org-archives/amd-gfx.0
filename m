From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: Slow memory access when using OpenCL without X11
Date: Tue, 12 Mar 2019 21:36:53 +0000
Message-ID: <BN6PR12MB180985C2C8051B5BBCF7CDDDF7490@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <CAGyaPbDo4-mJhCbL1gfjgek_Z54dyREydqZc-SF=cFVQ0URyYA@mail.gmail.com>
 <CADnq5_Mtg5Brvp3Z1dMy+V4oD1DqCQ-WJm4ehSW_dFybLm1Jcw@mail.gmail.com>
 <CAGyaPbCxMxG5kbu9RhrB0vSCDQL4zaNzsUqsoWVWmRVw8Mp7Pg@mail.gmail.com>
 <CABE_ZV0MV+=9=sE2ddK6hGzrSqZXayGdGUjnMWqYFp1t1k-O=Q@mail.gmail.com>
 <CAGyaPbDGq5Z+J+c_s99vBjSUttKwsBNv+EMvdjg0aXjY52qT-g@mail.gmail.com>
 <CAAzXoRKQnmsQxPqEswAyAxQ7snW+D=L0GC+auiDsVnZQaBeAvQ@mail.gmail.com>
 <CAGyaPbCNtF_LP3jtKcm9NB=Suw+EKTY941y=QAmODcP=q83zbA@mail.gmail.com>
 <CAAzXoRJ7MBis7YYWhYcH_H=1ZPpZpTJFDm+HTD5q0p91bgTxSg@mail.gmail.com>
 <b26fcd35-9867-f716-cea8-ddf76c599fca@amd.com>
 <CAGyaPbA_z0bKC1W8gTdnx4Ot5G-45pC7029pKWrAM0Pj_BU6uw@mail.gmail.com>,
 <CAGyaPbD3K3pawBS+kBOs_QSm3kB16MFRYZa98FcqHAEX_FanVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1040315524=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAGyaPbD3K3pawBS+kBOs_QSm3kB16MFRYZa98FcqHAEX_FanVg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: Lauri Ehrenpreis <laurioma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Cc: Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1040315524==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB180985C2C8051B5BBCF7CDDDF7490BN6PR12MB1809namp_"

--_000_BN6PR12MB180985C2C8051B5BBCF7CDDDF7490BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Forcing the sclk and mclk high may impact the CPU frequency since they shar=
e TDP.

Alex
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Lauri Eh=
renpreis <laurioma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Tuesday, March 12, 2019 5:31 PM
To: Kuehling, Felix
Cc: Tom St Denis; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: Slow memory access when using OpenCL without X11

However it's not only related to mclk and sclk. I tried this:
rocm-smi  --setsclk 2
rocm-smi  --setmclk 3
rocm-smi
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D   =
     ROCm System Management Interface        =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
GPU   Temp   AvgPwr   SCLK    MCLK    PCLK           Fan     Perf    PwrCap=
   SCLK OD   MCLK OD  GPU%
GPU[0] : WARNING: Empty SysFS value: pclk
GPU[0] : WARNING: Unable to read /sys/class/drm/card0/device/gpu_busy_perce=
nt
0     34.0c  N/A      1240Mhz 1333Mhz N/A            0%      manual  N/A   =
   0%        0%       N/A
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D   =
            End of ROCm SMI Log              =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

./cl_slow_test 1
got 1 platforms 1 devices
speed 3919.777100 avg 3919.777100 mbytes/s
speed 3809.373291 avg 3864.575195 mbytes/s
speed 585.796814 avg 2771.649170 mbytes/s
speed 188.721848 avg 2125.917236 mbytes/s
speed 188.916367 avg 1738.517090 mbytes/s

So despite forcing max sclk and mclk the memory speed is still slow..

--
Lauri


On Tue, Mar 12, 2019 at 11:21 PM Lauri Ehrenpreis <laurioma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org<mailt=
o:laurioma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>> wrote:
IN the case when memory is slow, the rocm-smi outputs this:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D   =
     ROCm System Management Interface        =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
GPU   Temp   AvgPwr   SCLK    MCLK    PCLK           Fan     Perf    PwrCap=
   SCLK OD   MCLK OD  GPU%
GPU[0] : WARNING: Empty SysFS value: pclk
GPU[0] : WARNING: Unable to read /sys/class/drm/card0/device/gpu_busy_perce=
nt
0     30.0c  N/A      400Mhz  933Mhz  N/A            0%      auto    N/A   =
   0%        0%       N/A
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D   =
            End of ROCm SMI Log              =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

normal memory speed case gives following:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D   =
     ROCm System Management Interface        =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
GPU   Temp   AvgPwr   SCLK    MCLK    PCLK           Fan     Perf    PwrCap=
   SCLK OD   MCLK OD  GPU%
GPU[0] : WARNING: Empty SysFS value: pclk
GPU[0] : WARNING: Unable to read /sys/class/drm/card0/device/gpu_busy_perce=
nt
0     35.0c  N/A      400Mhz  1200Mhz N/A            0%      auto    N/A   =
   0%        0%       N/A
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D   =
            End of ROCm SMI Log              =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

So there is a difference in MCLK - can this cause such a huge slowdown?

--
Lauri

On Tue, Mar 12, 2019 at 6:39 PM Kuehling, Felix <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org<mai=
lto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>> wrote:
[adding the list back]

I'd suspect a problem related to memory clock. This is an APU where
system memory is shared with the CPU, so if the SMU changes memory
clocks that would affect CPU memory access performance. If the problem
only occurs when OpenCL is running, then the compute power profile could
have an effect here.

Laurie, can you monitor the clocks during your tests using rocm-smi?

Regards,
   Felix

On 2019-03-11 1:15 p.m., Tom St Denis wrote:
> Hi Lauri,
>
> I don't have ROCm installed locally (not on that team at AMD) but I
> can rope in some of the KFD folk and see what they say :-).
>
> (in the mean time I should look into installing the ROCm stack on my
> Ubuntu disk for experimentation...).
>
> Only other thing that comes to mind is some sort of stutter due to
> power/clock gating (or gfx off/etc).  But that typically affects the
> display/gpu side not the CPU side.
>
> Felix:  Any known issues with Raven and ROCm interacting over memory
> bus performance?
>
> Tom
>
> On Mon, Mar 11, 2019 at 12:56 PM Lauri Ehrenpreis <laurioma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org<mai=
lto:laurioma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> <mailto:laurioma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org<mailto:laurioma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>>> wrote:
>
>     Hi!
>
>     The 100x memory slowdown is hard to belive indeed. I attached the
>     test program with my first e-mail which depends only on
>     rocm-opencl-dev package. Would you mind compiling it and checking
>     if it slows down memory for you as well?
>
>     steps:
>     1) g++ cl_slow_test.cpp -o cl_slow_test -I
>     /opt/rocm/opencl/include/ -L /opt/rocm/opencl/lib/x86_64/  -lOpenCL
>     2) logout from desktop env and disconnect hdmi/diplayport etc
>     3) log in over ssh
>     4) run the program ./cl_slow_test 1
>
>     For me it reproduced even without step 2 as well but less
>     reliably. moving mouse for example could make the memory speed
>     fast again.
>
>     --
>     Lauri
>
>
>
>     On Mon, Mar 11, 2019 at 6:33 PM Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org<ma=
ilto:tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>     <mailto:tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org<mailto:tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>>> wrote:
>
>         Hi Lauri,
>
>         There's really no connection between the two other than they
>         run in the same package.  I too run a 2400G (as my
>         workstation) and I got the same ~6.6GB/sec transfer rate but
>         without a CL app running ...  The only logical reason is your
>         CL app is bottlenecking the APUs memory bus but you claim
>         "simply opening a context is enough" so something else is
>         going on.
>
>         Your last reply though says "with it running in the
>         background" so it's entirely possible the CPU isn't busy but
>         the package memory controller (shared between both the CPU and
>         GPU) is busy.  For instance running xonotic in a 1080p window
>         on my 4K display reduced the memory test to 5.8GB/sec and
>         that's hardly a heavy memory bound GPU app.
>
>         The only other possible connection is the GPU is generating so
>         much heat that it's throttling the package which is also
>         unlikely if you have a proper HSF attached (I use the ones
>         that came in the retail boxes).
>
>         Cheers,
>         Tom
>

--_000_BN6PR12MB180985C2C8051B5BBCF7CDDDF7490BN6PR12MB1809namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Forcing the sclk and mclk high may impact the CPU frequency since they shar=
e TDP.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Lauri Ehrenpreis &lt;laurioma=
@gmail.com&gt;<br>
<b>Sent:</b> Tuesday, March 12, 2019 5:31 PM<br>
<b>To:</b> Kuehling, Felix<br>
<b>Cc:</b> Tom St Denis; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: Slow memory access when using OpenCL without X11</font>
<div>&nbsp;</div>
</div>
<div>
<div dir=3D"ltr">
<div dir=3D"ltr">
<div dir=3D"ltr">
<div dir=3D"ltr">However it's not only related to mclk and sclk. I tried th=
is:
<div>
<div>rocm-smi&nbsp; --setsclk 2<br>
</div>
<div>rocm-smi&nbsp; --setmclk 3<br>
</div>
rocm-smi</div>
<div>
<div>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D&nbsp; &nbsp; &nbsp; &nbsp; ROCm System Management Interface&nbsp; &nbsp=
; &nbsp; &nbsp; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D</div>
<div>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</div>
<div>GPU&nbsp; &nbsp;Temp&nbsp; &nbsp;AvgPwr&nbsp; &nbsp;SCLK&nbsp; &nbsp; =
MCLK&nbsp; &nbsp; PCLK&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Fan&nbsp; &n=
bsp; &nbsp;Perf&nbsp; &nbsp; PwrCap&nbsp; &nbsp;SCLK OD&nbsp; &nbsp;MCLK OD=
&nbsp; GPU%</div>
<div>GPU[0] <span style=3D"white-space:pre"></span>: WARNING: Empty SysFS v=
alue: pclk</div>
<div>GPU[0] <span style=3D"white-space:pre"></span>: WARNING: Unable to rea=
d /sys/class/drm/card0/device/gpu_busy_percent</div>
<div>0&nbsp; &nbsp; &nbsp;34.0c&nbsp; N/A&nbsp; &nbsp; &nbsp; 1240Mhz 1333M=
hz N/A&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 0%&nbsp; &nbsp; &nbsp; manu=
al&nbsp; N/A&nbsp; &nbsp; &nbsp; 0%&nbsp; &nbsp; &nbsp; &nbsp; 0%&nbsp; &nb=
sp; &nbsp; &nbsp;N/A&nbsp; &nbsp; &nbsp;&nbsp;</div>
<div>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</div>
<div>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;End of ROCm SMI L=
og&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</div>
</div>
<div><br>
</div>
<div>
<div>./cl_slow_test 1</div>
<div>got 1 platforms 1 devices</div>
<div>speed 3919.777100 avg 3919.777100 mbytes/s</div>
<div>speed 3809.373291 avg 3864.575195 mbytes/s</div>
<div>speed 585.796814 avg 2771.649170 mbytes/s</div>
<div>speed 188.721848 avg 2125.917236 mbytes/s</div>
<div>speed 188.916367 avg 1738.517090 mbytes/s</div>
<div><br>
</div>
</div>
<div>So despite forcing max sclk and mclk the memory speed is still slow..<=
/div>
<div><br>
</div>
<div>--</div>
<div>Lauri</div>
<div><br>
</div>
</div>
</div>
</div>
</div>
<br>
<div class=3D"x_gmail_quote">
<div dir=3D"ltr" class=3D"x_gmail_attr">On Tue, Mar 12, 2019 at 11:21 PM La=
uri Ehrenpreis &lt;<a href=3D"mailto:laurioma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">laurioma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org=
</a>&gt; wrote:<br>
</div>
<blockquote class=3D"x_gmail_quote" style=3D"margin:0px 0px 0px 0.8ex; bord=
er-left:1px solid rgb(204,204,204); padding-left:1ex">
<div dir=3D"ltr">
<div dir=3D"ltr">
<div dir=3D"ltr">IN the case when memory is slow, the rocm-smi outputs this=
:
<div>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D&nbsp; &nbsp; &nbsp; &nbsp; ROCm System Management Interface&nbsp; &nbsp=
; &nbsp; &nbsp; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D</div>
<div>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</div>
<div>GPU&nbsp; &nbsp;Temp&nbsp; &nbsp;AvgPwr&nbsp; &nbsp;SCLK&nbsp; &nbsp; =
MCLK&nbsp; &nbsp; PCLK&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Fan&nbsp; &n=
bsp; &nbsp;Perf&nbsp; &nbsp; PwrCap&nbsp; &nbsp;SCLK OD&nbsp; &nbsp;MCLK OD=
&nbsp; GPU%</div>
<div>GPU[0] <span style=3D"white-space:pre-wrap"></span>: WARNING: Empty Sy=
sFS value: pclk</div>
<div>GPU[0] <span style=3D"white-space:pre-wrap"></span>: WARNING: Unable t=
o read /sys/class/drm/card0/device/gpu_busy_percent</div>
<div>0&nbsp; &nbsp; &nbsp;30.0c&nbsp; N/A&nbsp; &nbsp; &nbsp; 400Mhz&nbsp; =
933Mhz&nbsp; N/A&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 0%&nbsp; &nbsp; &=
nbsp; auto&nbsp; &nbsp; N/A&nbsp; &nbsp; &nbsp; 0%&nbsp; &nbsp; &nbsp; &nbs=
p; 0%&nbsp; &nbsp; &nbsp; &nbsp;N/A&nbsp; &nbsp; &nbsp;&nbsp;</div>
<div>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</div>
<div>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;End of ROCm SMI L=
og&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</div>
<div><br>
</div>
<div>normal memory speed case gives following:</div>
<div>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D&nbsp; &nbsp; &nbsp; &nbsp; ROCm System Management Interface&nbsp; &nbsp=
; &nbsp; &nbsp; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D</div>
<div>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</div>
<div>GPU&nbsp; &nbsp;Temp&nbsp; &nbsp;AvgPwr&nbsp; &nbsp;SCLK&nbsp; &nbsp; =
MCLK&nbsp; &nbsp; PCLK&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Fan&nbsp; &n=
bsp; &nbsp;Perf&nbsp; &nbsp; PwrCap&nbsp; &nbsp;SCLK OD&nbsp; &nbsp;MCLK OD=
&nbsp; GPU%</div>
<div>GPU[0] <span style=3D"white-space:pre-wrap"></span>: WARNING: Empty Sy=
sFS value: pclk</div>
<div>GPU[0] <span style=3D"white-space:pre-wrap"></span>: WARNING: Unable t=
o read /sys/class/drm/card0/device/gpu_busy_percent</div>
<div>0&nbsp; &nbsp; &nbsp;35.0c&nbsp; N/A&nbsp; &nbsp; &nbsp; 400Mhz&nbsp; =
1200Mhz N/A&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 0%&nbsp; &nbsp; &nbsp;=
 auto&nbsp; &nbsp; N/A&nbsp; &nbsp; &nbsp; 0%&nbsp; &nbsp; &nbsp; &nbsp; 0%=
&nbsp; &nbsp; &nbsp; &nbsp;N/A&nbsp; &nbsp; &nbsp;&nbsp;</div>
<div>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</div>
<div>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;End of ROCm SMI L=
og&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</div>
<div><br>
</div>
<div>So there is a difference in MCLK - can this cause such a huge slowdown=
?</div>
<div><br>
</div>
<div>--</div>
<div>Lauri&nbsp;&nbsp;<br>
</div>
</div>
</div>
</div>
<br>
<div class=3D"x_gmail_quote">
<div dir=3D"ltr" class=3D"x_gmail_attr">On Tue, Mar 12, 2019 at 6:39 PM Kue=
hling, Felix &lt;<a href=3D"mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org" target=3D"_blank=
">Felix.Kuehling-5C7GfCeVMHo@public.gmane.org</a>&gt; wrote:<br>
</div>
<blockquote class=3D"x_gmail_quote" style=3D"margin:0px 0px 0px 0.8ex; bord=
er-left:1px solid rgb(204,204,204); padding-left:1ex">
[adding the list back]<br>
<br>
I'd suspect a problem related to memory clock. This is an APU where <br>
system memory is shared with the CPU, so if the SMU changes memory <br>
clocks that would affect CPU memory access performance. If the problem <br>
only occurs when OpenCL is running, then the compute power profile could <b=
r>
have an effect here.<br>
<br>
Laurie, can you monitor the clocks during your tests using rocm-smi?<br>
<br>
Regards,<br>
&nbsp;&nbsp; Felix<br>
<br>
On 2019-03-11 1:15 p.m., Tom St Denis wrote:<br>
&gt; Hi Lauri,<br>
&gt;<br>
&gt; I don't have ROCm installed locally (not on that team at AMD) but I <b=
r>
&gt; can rope in some of the KFD folk and see what they say :-).<br>
&gt;<br>
&gt; (in the mean time I should look into installing the ROCm stack on my <=
br>
&gt; Ubuntu disk for experimentation...).<br>
&gt;<br>
&gt; Only other thing that comes to mind is some sort of stutter due to <br=
>
&gt; power/clock gating (or gfx off/etc).&nbsp; But that typically affects =
the <br>
&gt; display/gpu side not the CPU side.<br>
&gt;<br>
&gt; Felix:&nbsp; Any known issues with Raven and ROCm interacting over mem=
ory <br>
&gt; bus performance?<br>
&gt;<br>
&gt; Tom<br>
&gt;<br>
&gt; On Mon, Mar 11, 2019 at 12:56 PM Lauri Ehrenpreis &lt;<a href=3D"mailt=
o:laurioma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">laurioma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>
<br>
&gt; &lt;mailto:<a href=3D"mailto:laurioma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">lau=
rioma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;&gt; wrote:<br>
&gt;<br>
&gt;&nbsp; &nbsp; &nbsp;Hi!<br>
&gt;<br>
&gt;&nbsp; &nbsp; &nbsp;The 100x memory slowdown is hard to belive indeed. =
I attached the<br>
&gt;&nbsp; &nbsp; &nbsp;test program with my first e-mail which depends onl=
y on<br>
&gt;&nbsp; &nbsp; &nbsp;rocm-opencl-dev package. Would you mind compiling i=
t and checking<br>
&gt;&nbsp; &nbsp; &nbsp;if it slows down memory for you as well?<br>
&gt;<br>
&gt;&nbsp; &nbsp; &nbsp;steps:<br>
&gt;&nbsp; &nbsp; &nbsp;1) g&#43;&#43; cl_slow_test.cpp -o cl_slow_test -I<=
br>
&gt;&nbsp; &nbsp; &nbsp;/opt/rocm/opencl/include/ -L /opt/rocm/opencl/lib/x=
86_64/&nbsp; -lOpenCL<br>
&gt;&nbsp; &nbsp; &nbsp;2) logout from desktop env and disconnect hdmi/dipl=
ayport etc<br>
&gt;&nbsp; &nbsp; &nbsp;3) log in over ssh<br>
&gt;&nbsp; &nbsp; &nbsp;4) run the program ./cl_slow_test 1<br>
&gt;<br>
&gt;&nbsp; &nbsp; &nbsp;For me it reproduced even without step 2 as well bu=
t less<br>
&gt;&nbsp; &nbsp; &nbsp;reliably. moving mouse for example could make the m=
emory speed<br>
&gt;&nbsp; &nbsp; &nbsp;fast again.<br>
&gt;<br>
&gt;&nbsp; &nbsp; &nbsp;--<br>
&gt;&nbsp; &nbsp; &nbsp;Lauri<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;&nbsp; &nbsp; &nbsp;On Mon, Mar 11, 2019 at 6:33 PM Tom St Denis &lt;<a=
 href=3D"mailto:tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">tstdenis82-Re5JQEeQqe8@public.gmane.org=
m</a><br>
&gt;&nbsp; &nbsp; &nbsp;&lt;mailto:<a href=3D"mailto:tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" =
target=3D"_blank">tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;&gt; wrote:<br>
&gt;<br>
&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Hi Lauri,<br>
&gt;<br>
&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;There's really no connection between =
the two other than they<br>
&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;run in the same package.&nbsp; I too =
run a 2400G (as my<br>
&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;workstation) and I got the same ~6.6G=
B/sec transfer rate but<br>
&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;without a CL app running ...&nbsp; Th=
e only logical reason is your<br>
&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;CL app is bottlenecking the APUs memo=
ry bus but you claim<br>
&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&quot;simply opening a context is eno=
ugh&quot; so something else is<br>
&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;going on.<br>
&gt;<br>
&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Your last reply though says &quot;wit=
h it running in the<br>
&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;background&quot; so it's entirely pos=
sible the CPU isn't busy but<br>
&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;the package memory controller (shared=
 between both the CPU and<br>
&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;GPU) is busy.&nbsp; For instance runn=
ing xonotic in a 1080p window<br>
&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;on my 4K display reduced the memory t=
est to 5.8GB/sec and<br>
&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;that's hardly a heavy memory bound GP=
U app.<br>
&gt;<br>
&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;The only other possible connection is=
 the GPU is generating so<br>
&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;much heat that it's throttling the pa=
ckage which is also<br>
&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;unlikely if you have a proper HSF att=
ached (I use the ones<br>
&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;that came in the retail boxes).<br>
&gt;<br>
&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Cheers,<br>
&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Tom<br>
&gt;<br>
</blockquote>
</div>
</blockquote>
</div>
</div>
</body>
</html>

--_000_BN6PR12MB180985C2C8051B5BBCF7CDDDF7490BN6PR12MB1809namp_--

--===============1040315524==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1040315524==--
