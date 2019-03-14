From: Lauri Ehrenpreis <laurioma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Slow memory access when using OpenCL without X11
Date: Thu, 14 Mar 2019 18:41:14 +0200
Message-ID: <CAGyaPbCvOijB=pWe3zkMze3aT+Yr86aQYK2OP=P8qpOdCzaORg@mail.gmail.com>
References: <CAGyaPbDo4-mJhCbL1gfjgek_Z54dyREydqZc-SF=cFVQ0URyYA@mail.gmail.com>
 <CADnq5_Mtg5Brvp3Z1dMy+V4oD1DqCQ-WJm4ehSW_dFybLm1Jcw@mail.gmail.com>
 <CAGyaPbCxMxG5kbu9RhrB0vSCDQL4zaNzsUqsoWVWmRVw8Mp7Pg@mail.gmail.com>
 <CABE_ZV0MV+=9=sE2ddK6hGzrSqZXayGdGUjnMWqYFp1t1k-O=Q@mail.gmail.com>
 <CAGyaPbDGq5Z+J+c_s99vBjSUttKwsBNv+EMvdjg0aXjY52qT-g@mail.gmail.com>
 <CAAzXoRKQnmsQxPqEswAyAxQ7snW+D=L0GC+auiDsVnZQaBeAvQ@mail.gmail.com>
 <CAGyaPbCNtF_LP3jtKcm9NB=Suw+EKTY941y=QAmODcP=q83zbA@mail.gmail.com>
 <CAAzXoRJ7MBis7YYWhYcH_H=1ZPpZpTJFDm+HTD5q0p91bgTxSg@mail.gmail.com>
 <b26fcd35-9867-f716-cea8-ddf76c599fca@amd.com>
 <CAGyaPbA_z0bKC1W8gTdnx4Ot5G-45pC7029pKWrAM0Pj_BU6uw@mail.gmail.com>
 <CAGyaPbD3K3pawBS+kBOs_QSm3kB16MFRYZa98FcqHAEX_FanVg@mail.gmail.com>
 <BN6PR12MB180985C2C8051B5BBCF7CDDDF7490@BN6PR12MB1809.namprd12.prod.outlook.com>
 <CAGyaPbBAxjGGHA6sxzvSqagLVhiHBDmmp3Oz0==SRhUao488ng@mail.gmail.com>
 <8502a6bb-26b2-bd5e-c073-8e4e4405d3e2@amd.com>
 <CAGyaPbCTM8YoCuJQdD1JkDiA5FkpnMhLkQcb8Lpr8k0KYwLUWQ@mail.gmail.com>
 <CAGyaPbBwk9CZaMgrrB3edgJLDJq8djfETUBnhkZKg0+rza+Y5Q@mail.gmail.com>
 <CAD=4a=UOz-R3bcFvEgC_8a9N12Mfs_fVvK+od41k7b=Zjoj45Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1364560728=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAD=4a=UOz-R3bcFvEgC_8a9N12Mfs_fVvK+od41k7b=Zjoj45Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: =?UTF-8?Q?Ernst_Sj=C3=B6strand?= <ernstp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Kuehling,
 Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1364560728==
Content-Type: multipart/alternative; boundary="000000000000db27c50584109798"

--000000000000db27c50584109798
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yes it affects this a bit but it doesn't get the speed up to "normal"
level. I got best results with "profile_peak" - then the memcpy speed on
CPU is 1/3 of what it is without opencl initialization:

 echo "profile_peak" >
/sys/class/drm/card0/device/power_dpm_force_performance_level
./cl_slow_test 1 5
got 1 platforms 1 devices
speed 3710.360352 avg 3710.360352 mbytes/s
speed 3713.660400 avg 3712.010254 mbytes/s
speed 3797.630859 avg 3740.550537 mbytes/s
speed 3708.004883 avg 3732.414062 mbytes/s
speed 3796.403076 avg 3745.211914 mbytes/s

Without calling clCreateContext:
./cl_slow_test 0 5
speed 7299.201660 avg 7299.201660 mbytes/s
speed 9298.841797 avg 8299.021484 mbytes/s
speed 9360.181641 avg 8652.742188 mbytes/s
speed 9004.759766 avg 8740.746094 mbytes/s
speed 9414.607422 avg 8875.518555 mbytes/s

--
Lauri

On Thu, Mar 14, 2019 at 5:46 PM Ernst Sj=C3=B6strand <ernstp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wro=
te:

> Does
> echo high > /sys/class/drm/card0/device/power_dpm_force_performance_level
> or setting cpu scaling governor to performance affect it at all?
>
> Regards
> //Ernst
>
> Den tors 14 mars 2019 kl 14:31 skrev Lauri Ehrenpreis <laurioma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
> >:
> >
> > I tried also with those 2 boards now:
> > https://www.asrock.com/MB/AMD/Fatal1ty%20B450%20Gaming-ITXac/index.asp
> > https://www.msi.com/Motherboard/B450I-GAMING-PLUS-AC
> >
> > Both are using latest BIOS, ubuntu 18.10, kernel
> https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.0.2/
> >
> > There are some differences in dmesg (asrock has some amdgpu assert in
> dmesg) but otherwise results are exactly the same.
> > In desktop env cl_slow_test works fast, over ssh terminal it doesn't. I=
f
> i move mouse then it starts working fast in terminal as well.
> >
> > So one can't use OpenCL without monitor and desktop env running and thi=
s
> happens with 2 different chipsets (b350 & b450), latest bios from 3
> different vendors, latest kernel and latest rocm. This doesn't look like
> edge case with unusual setup to me..
> >
> > Attached dmesg, dmidecode, and clinfo from both boards.
> >
> > --
> > Lauri
> >
> > On Wed, Mar 13, 2019 at 10:15 PM Lauri Ehrenpreis <laurioma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> wrote:
> >>
> >> For reproduction only the tiny cl_slow_test.cpp is needed which is
> attached to first e-mail.
> >>
> >> System information is following:
> >> CPU: Ryzen5 2400G
> >> Main board: Gigabyte AMD B450 AORUS mini itx:
> https://www.gigabyte.com/Motherboard/B450-I-AORUS-PRO-WIFI-rev-10#kf
> >> BIOS: F5 8.47 MB 2019/01/25 (latest)
> >> Kernel: https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.0/  (amd64)
> >> OS: Ubuntu 18.04 LTS
> >> rocm-opencl-dev installation:
> >> wget -qO - http://repo.radeon.com/rocm/apt/debian/rocm.gpg.key | sudo
> apt-key add -
> >> echo 'deb [arch=3Damd64] http://repo.radeon.com/rocm/apt/debian/ xenia=
l
> main' | sudo tee /etc/apt/sources.list.d/rocm.list
> >> sudo apt install rocm-opencl-dev
> >>
> >> Also exactly the same issue happens with this board:
> https://www.gigabyte.com/Motherboard/GA-AB350-Gaming-3-rev-1x#kf
> >>
> >> I have MSI and Asrock mini itx boards ready as well, So far didn't get
> amdgpu & opencl working there but I'll try again tomorrow..
> >>
> >> --
> >> Lauri
> >>
> >>
> >> On Wed, Mar 13, 2019 at 8:51 PM Kuehling, Felix <Felix.Kuehling-urvtwAKJhsc@public.gmane.org=
m>
> wrote:
> >>>
> >>> Hi Lauri,
> >>>
> >>> I still think the SMU is doing something funny, but rocm-smi isn't
> >>> showing enough information to really see what's going on.
> >>>
> >>> On APUs the SMU firmware is embedded in the system BIOS. Unlike
> discrete
> >>> GPUs, the SMU firmware is not loaded by the driver. You could try
> >>> updating your system BIOS to the latest version available from your
> main
> >>> board vendor and see if that makes a difference. It may include a new=
er
> >>> version of the SMU firmware, potentially with a fix.
> >>>
> >>> If that doesn't help, we'd have to reproduce the problem in house to
> see
> >>> what's happening, which may require the same main board and BIOS
> version
> >>> you're using. We can ask our SMU firmware team if they've ever
> >>> encountered your type of problem. But I don't want to give you too mu=
ch
> >>> hope. It's a tricky problem involving HW, firmware and multiple drive=
r
> >>> components in a fairly unusual configuration.
> >>>
> >>> Regards,
> >>>    Felix
> >>>
> >>> On 2019-03-13 7:28 a.m., Lauri Ehrenpreis wrote:
> >>> > What I observe is that moving the mouse made the memory speed go up
> >>> > and also it made mclk=3D1200Mhz in rocm-smi output.
> >>> > However if I force mclk to 1200Mhz myself then memory speed is stil=
l
> >>> > slow.
> >>> >
> >>> > So rocm-smi output when memory speed went fast due to mouse movemen=
t:
> >>> > rocm-smi
> >>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D        ROCm System Management Interface
> >>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> >>> >
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>> > GPU   Temp   AvgPwr   SCLK    MCLK    PCLK      Fan     Perf
> >>> > PwrCap   SCLK OD   MCLK OD GPU%
> >>> > GPU[0] : WARNING: Empty SysFS value: pclk
> >>> > GPU[0] : WARNING: Unable to read
> >>> > /sys/class/drm/card0/device/gpu_busy_percent
> >>> > 0     44.0c  N/A      400Mhz  1200Mhz N/A       0%      manual  N/A
> >>> >   0%        0%  N/A
> >>> >
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D               End of ROCm SMI Log
> >>> >   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> >>> >
> >>> > And rocm-smi output when I forced memclk=3D1200MHz myself:
> >>> > rocm-smi --setmclk 2
> >>> > rocm-smi
> >>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D        ROCm System Management Interface
> >>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> >>> >
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>> > GPU   Temp   AvgPwr   SCLK    MCLK    PCLK      Fan     Perf
> >>> > PwrCap   SCLK OD   MCLK OD GPU%
> >>> > GPU[0] : WARNING: Empty SysFS value: pclk
> >>> > GPU[0] : WARNING: Unable to read
> >>> > /sys/class/drm/card0/device/gpu_busy_percent
> >>> > 0     39.0c  N/A      400Mhz  1200Mhz N/A       0%      manual  N/A
> >>> >   0%        0%  N/A
> >>> >
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D               End of ROCm SMI Log
> >>> >   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> >>> >
> >>> > So only difference is that temperature shows 44c when memory speed
> was
> >>> > fast and 39c when it was slow. But mclk was 1200MHz and sclk was
> >>> > 400MHz in both cases.
> >>> > Can it be that rocm-smi just has a bug in reporting and mclk was no=
t
> >>> > actually 1200MHz when I forced it with rocm-smi --setmclk 2 ?
> >>> > That would explain the different behaviour..
> >>> >
> >>> > If so then is there a programmatic way how to really guarantee the
> >>> > high speed mclk? Basically I want do something similar in my progra=
m
> >>> > what happens if I move
> >>> > the mouse in desktop env and this way guarantee the normal memory
> >>> > speed each time the program starts.
> >>> >
> >>> > --
> >>> > Lauri
> >>> >
> >>> >
> >>> > On Tue, Mar 12, 2019 at 11:36 PM Deucher, Alexander
> >>> > <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org <mailto:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>>
> wrote:
> >>> >
> >>> >     Forcing the sclk and mclk high may impact the CPU frequency sin=
ce
> >>> >     they share TDP.
> >>> >
> >>> >     Alex
> >>> >
>  ------------------------------------------------------------------------
> >>> >     *From:* amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> >>> >     <mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>> on behalf of
> Lauri
> >>> >     Ehrenpreis <laurioma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org <mailto:laurioma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>>
> >>> >     *Sent:* Tuesday, March 12, 2019 5:31 PM
> >>> >     *To:* Kuehling, Felix
> >>> >     *Cc:* Tom St Denis; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> >>> >     <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
> >>> >     *Subject:* Re: Slow memory access when using OpenCL without X11
> >>> >     However it's not only related to mclk and sclk. I tried this:
> >>> >     rocm-smi  --setsclk 2
> >>> >     rocm-smi  --setmclk 3
> >>> >     rocm-smi
> >>> >     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D        ROCm System Management Interface
> >>> >     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> >>> >
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>> >     GPU   Temp   AvgPwr   SCLK    MCLK    PCLK          Fan     Per=
f
> >>> >       PwrCap   SCLK OD  MCLK OD  GPU%
> >>> >     GPU[0] : WARNING: Empty SysFS value: pclk
> >>> >     GPU[0] : WARNING: Unable to read
> >>> >     /sys/class/drm/card0/device/gpu_busy_percent
> >>> >     0     34.0c  N/A      1240Mhz 1333Mhz N/A           0%
> >>> >     manual  N/A      0% 0%       N/A
> >>> >
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>> >     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D               End of ROCm SMI Log
> >>> >     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> >>> >
> >>> >     ./cl_slow_test 1
> >>> >     got 1 platforms 1 devices
> >>> >     speed 3919.777100 avg 3919.777100 mbytes/s
> >>> >     speed 3809.373291 avg 3864.575195 mbytes/s
> >>> >     speed 585.796814 avg 2771.649170 mbytes/s
> >>> >     speed 188.721848 avg 2125.917236 mbytes/s
> >>> >     speed 188.916367 avg 1738.517090 mbytes/s
> >>> >
> >>> >     So despite forcing max sclk and mclk the memory speed is still
> slow..
> >>> >
> >>> >     --
> >>> >     Lauri
> >>> >
> >>> >
> >>> >     On Tue, Mar 12, 2019 at 11:21 PM Lauri Ehrenpreis
> >>> >     <laurioma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org <mailto:laurioma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>> wrote:
> >>> >
> >>> >         IN the case when memory is slow, the rocm-smi outputs this:
> >>> >         =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D        ROCm System Management
> >>> >         Interface =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> >>> >
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>> >         GPU   Temp   AvgPwr   SCLK    MCLK    PCLK          Fan
> >>> >          Perf    PwrCap   SCLK OD  MCLK OD  GPU%
> >>> >         GPU[0] : WARNING: Empty SysFS value: pclk
> >>> >         GPU[0] : WARNING: Unable to read
> >>> >         /sys/class/drm/card0/device/gpu_busy_percent
> >>> >         0     30.0c  N/A      400Mhz  933Mhz  N/A           0%
> >>> >         auto    N/A      0% 0%       N/A
> >>> >
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>> >         =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D               End of ROCm SMI Log
> >>> >         =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> >>> >
> >>> >         normal memory speed case gives following:
> >>> >         =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D        ROCm System Management
> >>> >         Interface =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> >>> >
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>> >         GPU   Temp   AvgPwr   SCLK    MCLK    PCLK          Fan
> >>> >          Perf    PwrCap   SCLK OD  MCLK OD  GPU%
> >>> >         GPU[0] : WARNING: Empty SysFS value: pclk
> >>> >         GPU[0] : WARNING: Unable to read
> >>> >         /sys/class/drm/card0/device/gpu_busy_percent
> >>> >         0     35.0c  N/A      400Mhz  1200Mhz N/A           0%
> >>> >         auto    N/A      0% 0%       N/A
> >>> >
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>> >         =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D               End of ROCm SMI Log
> >>> >         =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> >>> >
> >>> >         So there is a difference in MCLK - can this cause such a hu=
ge
> >>> >         slowdown?
> >>> >
> >>> >         --
> >>> >         Lauri
> >>> >
> >>> >         On Tue, Mar 12, 2019 at 6:39 PM Kuehling, Felix
> >>> >         <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org <mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>>
> wrote:
> >>> >
> >>> >             [adding the list back]
> >>> >
> >>> >             I'd suspect a problem related to memory clock. This is =
an
> >>> >             APU where
> >>> >             system memory is shared with the CPU, so if the SMU
> >>> >             changes memory
> >>> >             clocks that would affect CPU memory access performance.
> If
> >>> >             the problem
> >>> >             only occurs when OpenCL is running, then the compute
> power
> >>> >             profile could
> >>> >             have an effect here.
> >>> >
> >>> >             Laurie, can you monitor the clocks during your tests
> using
> >>> >             rocm-smi?
> >>> >
> >>> >             Regards,
> >>> >                Felix
> >>> >
> >>> >             On 2019-03-11 1:15 p.m., Tom St Denis wrote:
> >>> >             > Hi Lauri,
> >>> >             >
> >>> >             > I don't have ROCm installed locally (not on that team
> at
> >>> >             AMD) but I
> >>> >             > can rope in some of the KFD folk and see what they sa=
y
> :-).
> >>> >             >
> >>> >             > (in the mean time I should look into installing the
> ROCm
> >>> >             stack on my
> >>> >             > Ubuntu disk for experimentation...).
> >>> >             >
> >>> >             > Only other thing that comes to mind is some sort of
> >>> >             stutter due to
> >>> >             > power/clock gating (or gfx off/etc).  But that
> typically
> >>> >             affects the
> >>> >             > display/gpu side not the CPU side.
> >>> >             >
> >>> >             > Felix:  Any known issues with Raven and ROCm
> interacting
> >>> >             over memory
> >>> >             > bus performance?
> >>> >             >
> >>> >             > Tom
> >>> >             >
> >>> >             > On Mon, Mar 11, 2019 at 12:56 PM Lauri Ehrenpreis
> >>> >             <laurioma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org <mailto:laurioma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >>> >             > <mailto:laurioma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org <mailto:laurioma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
> >>>
> >>> >             wrote:
> >>> >             >
> >>> >             >     Hi!
> >>> >             >
> >>> >             >     The 100x memory slowdown is hard to belive indeed=
.
> I
> >>> >             attached the
> >>> >             >     test program with my first e-mail which depends
> only on
> >>> >             >     rocm-opencl-dev package. Would you mind compiling
> it
> >>> >             and checking
> >>> >             >     if it slows down memory for you as well?
> >>> >             >
> >>> >             >     steps:
> >>> >             >     1) g++ cl_slow_test.cpp -o cl_slow_test -I
> >>> >             >     /opt/rocm/opencl/include/ -L
> >>> >             /opt/rocm/opencl/lib/x86_64/  -lOpenCL
> >>> >             >     2) logout from desktop env and disconnect
> >>> >             hdmi/diplayport etc
> >>> >             >     3) log in over ssh
> >>> >             >     4) run the program ./cl_slow_test 1
> >>> >             >
> >>> >             >     For me it reproduced even without step 2 as well
> but
> >>> >             less
> >>> >             >     reliably. moving mouse for example could make the
> >>> >             memory speed
> >>> >             >     fast again.
> >>> >             >
> >>> >             >     --
> >>> >             >     Lauri
> >>> >             >
> >>> >             >
> >>> >             >
> >>> >             >     On Mon, Mar 11, 2019 at 6:33 PM Tom St Denis
> >>> >             <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org <mailto:tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >>> >             >     <mailto:tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
> >>> >             <mailto:tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>>> wrote:
> >>> >             >
> >>> >             >         Hi Lauri,
> >>> >             >
> >>> >             >         There's really no connection between the two
> >>> >             other than they
> >>> >             >         run in the same package.  I too run a 2400G
> (as my
> >>> >             >         workstation) and I got the same ~6.6GB/sec
> >>> >             transfer rate but
> >>> >             >         without a CL app running ...  The only logica=
l
> >>> >             reason is your
> >>> >             >         CL app is bottlenecking the APUs memory bus b=
ut
> >>> >             you claim
> >>> >             >         "simply opening a context is enough" so
> >>> >             something else is
> >>> >             >         going on.
> >>> >             >
> >>> >             >         Your last reply though says "with it running
> in the
> >>> >             >         background" so it's entirely possible the CPU
> >>> >             isn't busy but
> >>> >             >         the package memory controller (shared between
> >>> >             both the CPU and
> >>> >             >         GPU) is busy.  For instance running xonotic i=
n
> a
> >>> >             1080p window
> >>> >             >         on my 4K display reduced the memory test to
> >>> >             5.8GB/sec and
> >>> >             >         that's hardly a heavy memory bound GPU app.
> >>> >             >
> >>> >             >         The only other possible connection is the GPU
> is
> >>> >             generating so
> >>> >             >         much heat that it's throttling the package
> which
> >>> >             is also
> >>> >             >         unlikely if you have a proper HSF attached (I
> >>> >             use the ones
> >>> >             >         that came in the retail boxes).
> >>> >             >
> >>> >             >         Cheers,
> >>> >             >         Tom
> >>> >             >
> >>> >
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--000000000000db27c50584109798
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Yes it affects this a bit but it doesn&#39;t get the speed=
 up to &quot;normal&quot; level. I got best results with &quot;profile_peak=
&quot; - then the memcpy speed on CPU is 1/3 of what it is without opencl i=
nitialization:=C2=A0<div><br></div><div><div>=C2=A0echo &quot;profile_peak&=
quot; &gt; /sys/class/drm/card0/device/power_dpm_force_performance_level<br=
></div><div><span class=3D"gmail-im" style=3D"color:rgb(80,0,80)"><div>./cl=
_slow_test 1 5</div><div>got 1 platforms 1 devices</div></span><div>speed 3=
710.360352 avg 3710.360352 mbytes/s</div><div>speed 3713.660400 avg 3712.01=
0254 mbytes/s</div><div>speed 3797.630859 avg 3740.550537 mbytes/s</div><di=
v>speed 3708.004883 avg 3732.414062 mbytes/s</div><div>speed 3796.403076 av=
g 3745.211914 mbytes/s</div></div><div><br></div><div>Without calling clCre=
ateContext:</div><div><div>./cl_slow_test 0 5</div><div>speed 7299.201660 a=
vg 7299.201660 mbytes/s</div><div>speed 9298.841797 avg 8299.021484 mbytes/=
s</div><div>speed 9360.181641 avg 8652.742188 mbytes/s</div><div>speed 9004=
.759766 avg 8740.746094 mbytes/s</div><div>speed 9414.607422 avg 8875.51855=
5 mbytes/s</div></div></div><div><br></div><div>--</div><div>Lauri</div></d=
iv><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On =
Thu, Mar 14, 2019 at 5:46 PM Ernst Sj=C3=B6strand &lt;<a href=3D"mailto:ern=
stp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">ernstp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">Does<br>
echo high &gt; /sys/class/drm/card0/device/power_dpm_force_performance_leve=
l<br>
or setting cpu scaling governor to performance affect it at all?<br>
<br>
Regards<br>
//Ernst<br>
<br>
Den tors 14 mars 2019 kl 14:31 skrev Lauri Ehrenpreis &lt;<a href=3D"mailto=
:laurioma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">laurioma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;:<br>
&gt;<br>
&gt; I tried also with those 2 boards now:<br>
&gt; <a href=3D"https://www.asrock.com/MB/AMD/Fatal1ty%20B450%20Gaming-ITXa=
c/index.asp" rel=3D"noreferrer" target=3D"_blank">https://www.asrock.com/MB=
/AMD/Fatal1ty%20B450%20Gaming-ITXac/index.asp</a><br>
&gt; <a href=3D"https://www.msi.com/Motherboard/B450I-GAMING-PLUS-AC" rel=
=3D"noreferrer" target=3D"_blank">https://www.msi.com/Motherboard/B450I-GAM=
ING-PLUS-AC</a><br>
&gt;<br>
&gt; Both are using latest BIOS, ubuntu 18.10, kernel <a href=3D"https://ke=
rnel.ubuntu.com/~kernel-ppa/mainline/v5.0.2/" rel=3D"noreferrer" target=3D"=
_blank">https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.0.2/</a><br>
&gt;<br>
&gt; There are some differences in dmesg (asrock has some amdgpu assert in =
dmesg) but otherwise results are exactly the same.<br>
&gt; In desktop env cl_slow_test works fast, over ssh terminal it doesn&#39=
;t. If i move mouse then it starts working fast in terminal as well.<br>
&gt;<br>
&gt; So one can&#39;t use OpenCL without monitor and desktop env running an=
d this happens with 2 different chipsets (b350 &amp; b450), latest bios fro=
m 3 different vendors, latest kernel and latest rocm. This doesn&#39;t look=
 like edge case with unusual setup to me..<br>
&gt;<br>
&gt; Attached dmesg, dmidecode, and clinfo from both boards.<br>
&gt;<br>
&gt; --<br>
&gt; Lauri<br>
&gt;<br>
&gt; On Wed, Mar 13, 2019 at 10:15 PM Lauri Ehrenpreis &lt;<a href=3D"mailt=
o:laurioma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">laurioma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<b=
r>
&gt;&gt;<br>
&gt;&gt; For reproduction only the tiny cl_slow_test.cpp is needed which is=
 attached to first e-mail.<br>
&gt;&gt;<br>
&gt;&gt; System information is following:<br>
&gt;&gt; CPU: Ryzen5 2400G<br>
&gt;&gt; Main board: Gigabyte AMD B450 AORUS mini itx: <a href=3D"https://w=
ww.gigabyte.com/Motherboard/B450-I-AORUS-PRO-WIFI-rev-10#kf" rel=3D"norefer=
rer" target=3D"_blank">https://www.gigabyte.com/Motherboard/B450-I-AORUS-PR=
O-WIFI-rev-10#kf</a><br>
&gt;&gt; BIOS: F5 8.47 MB 2019/01/25 (latest)<br>
&gt;&gt; Kernel: <a href=3D"https://kernel.ubuntu.com/~kernel-ppa/mainline/=
v5.0/" rel=3D"noreferrer" target=3D"_blank">https://kernel.ubuntu.com/~kern=
el-ppa/mainline/v5.0/</a>=C2=A0 (amd64)<br>
&gt;&gt; OS: Ubuntu 18.04 LTS<br>
&gt;&gt; rocm-opencl-dev installation:<br>
&gt;&gt; wget -qO - <a href=3D"http://repo.radeon.com/rocm/apt/debian/rocm.=
gpg.key" rel=3D"noreferrer" target=3D"_blank">http://repo.radeon.com/rocm/a=
pt/debian/rocm.gpg.key</a> | sudo apt-key add -<br>
&gt;&gt; echo &#39;deb [arch=3Damd64] <a href=3D"http://repo.radeon.com/roc=
m/apt/debian/" rel=3D"noreferrer" target=3D"_blank">http://repo.radeon.com/=
rocm/apt/debian/</a> xenial main&#39; | sudo tee /etc/apt/sources.list.d/ro=
cm.list<br>
&gt;&gt; sudo apt install rocm-opencl-dev<br>
&gt;&gt;<br>
&gt;&gt; Also exactly the same issue happens with this board: <a href=3D"ht=
tps://www.gigabyte.com/Motherboard/GA-AB350-Gaming-3-rev-1x#kf" rel=3D"nore=
ferrer" target=3D"_blank">https://www.gigabyte.com/Motherboard/GA-AB350-Gam=
ing-3-rev-1x#kf</a><br>
&gt;&gt;<br>
&gt;&gt; I have MSI and Asrock mini itx boards ready as well, So far didn&#=
39;t get amdgpu &amp; opencl working there but I&#39;ll try again tomorrow.=
.<br>
&gt;&gt;<br>
&gt;&gt; --<br>
&gt;&gt; Lauri<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; On Wed, Mar 13, 2019 at 8:51 PM Kuehling, Felix &lt;<a href=3D"mai=
lto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org" target=3D"_blank">Felix.Kuehling-5C7GfCeVMHo@public.gmane.org</a>&gt=
; wrote:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Hi Lauri,<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I still think the SMU is doing something funny, but rocm-smi i=
sn&#39;t<br>
&gt;&gt;&gt; showing enough information to really see what&#39;s going on.<=
br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; On APUs the SMU firmware is embedded in the system BIOS. Unlik=
e discrete<br>
&gt;&gt;&gt; GPUs, the SMU firmware is not loaded by the driver. You could =
try<br>
&gt;&gt;&gt; updating your system BIOS to the latest version available from=
 your main<br>
&gt;&gt;&gt; board vendor and see if that makes a difference. It may includ=
e a newer<br>
&gt;&gt;&gt; version of the SMU firmware, potentially with a fix.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; If that doesn&#39;t help, we&#39;d have to reproduce the probl=
em in house to see<br>
&gt;&gt;&gt; what&#39;s happening, which may require the same main board an=
d BIOS version<br>
&gt;&gt;&gt; you&#39;re using. We can ask our SMU firmware team if they&#39=
;ve ever<br>
&gt;&gt;&gt; encountered your type of problem. But I don&#39;t want to give=
 you too much<br>
&gt;&gt;&gt; hope. It&#39;s a tricky problem involving HW, firmware and mul=
tiple driver<br>
&gt;&gt;&gt; components in a fairly unusual configuration.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Regards,<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 Felix<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; On 2019-03-13 7:28 a.m., Lauri Ehrenpreis wrote:<br>
&gt;&gt;&gt; &gt; What I observe is that moving the mouse made the memory s=
peed go up<br>
&gt;&gt;&gt; &gt; and also it made mclk=3D1200Mhz in rocm-smi output.<br>
&gt;&gt;&gt; &gt; However if I force mclk to 1200Mhz myself then memory spe=
ed is still<br>
&gt;&gt;&gt; &gt; slow.<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt; So rocm-smi output when memory speed went fast due to mou=
se movement:<br>
&gt;&gt;&gt; &gt; rocm-smi<br>
&gt;&gt;&gt; &gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=C2=A0 =C2=A0 =C2=A0 =C2=A0 ROCm System Management Interface=
<br>
&gt;&gt;&gt; &gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D<br>
&gt;&gt;&gt; &gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D<br>
&gt;&gt;&gt; &gt; GPU=C2=A0 =C2=A0Temp=C2=A0 =C2=A0AvgPwr=C2=A0 =C2=A0SCLK=
=C2=A0 =C2=A0 MCLK=C2=A0 =C2=A0 PCLK=C2=A0 =C2=A0 =C2=A0 Fan=C2=A0 =C2=A0 =
=C2=A0Perf<br>
&gt;&gt;&gt; &gt; PwrCap=C2=A0 =C2=A0SCLK OD=C2=A0 =C2=A0MCLK OD GPU%<br>
&gt;&gt;&gt; &gt; GPU[0] : WARNING: Empty SysFS value: pclk<br>
&gt;&gt;&gt; &gt; GPU[0] : WARNING: Unable to read<br>
&gt;&gt;&gt; &gt; /sys/class/drm/card0/device/gpu_busy_percent<br>
&gt;&gt;&gt; &gt; 0=C2=A0 =C2=A0 =C2=A044.0c=C2=A0 N/A=C2=A0 =C2=A0 =C2=A0 =
400Mhz=C2=A0 1200Mhz N/A=C2=A0 =C2=A0 =C2=A0 =C2=A00%=C2=A0 =C2=A0 =C2=A0 m=
anual=C2=A0 N/A<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A00%=C2=A0 =C2=A0 =C2=A0 =C2=A0 0%=C2=A0 N/A<br=
>
&gt;&gt;&gt; &gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D<br>
&gt;&gt;&gt; &gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0End o=
f ROCm SMI Log<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt; And rocm-smi output when I forced memclk=3D1200MHz myself=
:<br>
&gt;&gt;&gt; &gt; rocm-smi --setmclk 2<br>
&gt;&gt;&gt; &gt; rocm-smi<br>
&gt;&gt;&gt; &gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=C2=A0 =C2=A0 =C2=A0 =C2=A0 ROCm System Management Interface=
<br>
&gt;&gt;&gt; &gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D<br>
&gt;&gt;&gt; &gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D<br>
&gt;&gt;&gt; &gt; GPU=C2=A0 =C2=A0Temp=C2=A0 =C2=A0AvgPwr=C2=A0 =C2=A0SCLK=
=C2=A0 =C2=A0 MCLK=C2=A0 =C2=A0 PCLK=C2=A0 =C2=A0 =C2=A0 Fan=C2=A0 =C2=A0 =
=C2=A0Perf<br>
&gt;&gt;&gt; &gt; PwrCap=C2=A0 =C2=A0SCLK OD=C2=A0 =C2=A0MCLK OD GPU%<br>
&gt;&gt;&gt; &gt; GPU[0] : WARNING: Empty SysFS value: pclk<br>
&gt;&gt;&gt; &gt; GPU[0] : WARNING: Unable to read<br>
&gt;&gt;&gt; &gt; /sys/class/drm/card0/device/gpu_busy_percent<br>
&gt;&gt;&gt; &gt; 0=C2=A0 =C2=A0 =C2=A039.0c=C2=A0 N/A=C2=A0 =C2=A0 =C2=A0 =
400Mhz=C2=A0 1200Mhz N/A=C2=A0 =C2=A0 =C2=A0 =C2=A00%=C2=A0 =C2=A0 =C2=A0 m=
anual=C2=A0 N/A<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A00%=C2=A0 =C2=A0 =C2=A0 =C2=A0 0%=C2=A0 N/A<br=
>
&gt;&gt;&gt; &gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D<br>
&gt;&gt;&gt; &gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0End o=
f ROCm SMI Log<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt; So only difference is that temperature shows 44c when mem=
ory speed was<br>
&gt;&gt;&gt; &gt; fast and 39c when it was slow. But mclk was 1200MHz and s=
clk was<br>
&gt;&gt;&gt; &gt; 400MHz in both cases.<br>
&gt;&gt;&gt; &gt; Can it be that rocm-smi just has a bug in reporting and m=
clk was not<br>
&gt;&gt;&gt; &gt; actually 1200MHz when I forced it with rocm-smi --setmclk=
 2 ?<br>
&gt;&gt;&gt; &gt; That would explain the different behaviour..<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt; If so then is there a programmatic way how to really guar=
antee the<br>
&gt;&gt;&gt; &gt; high speed mclk? Basically I want do something similar in=
 my program<br>
&gt;&gt;&gt; &gt; what happens if I move<br>
&gt;&gt;&gt; &gt; the mouse in desktop env and this way guarantee the norma=
l memory<br>
&gt;&gt;&gt; &gt; speed each time the program starts.<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt; --<br>
&gt;&gt;&gt; &gt; Lauri<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt; On Tue, Mar 12, 2019 at 11:36 PM Deucher, Alexander<br>
&gt;&gt;&gt; &gt; &lt;<a href=3D"mailto:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org" target=
=3D"_blank">Alexander.Deucher-5C7GfCeVMHo@public.gmane.org</a> &lt;mailto:<a href=3D"mailto:Alex=
ander.Deucher-5C7GfCeVMHo@public.gmane.org" target=3D"_blank">Alexander.Deucher-5C7GfCeVMHo@public.gmane.org</a>&gt;&=
gt; wrote:<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0Forcing the sclk and mclk high may imp=
act the CPU frequency since<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0they share TDP.<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0Alex<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0--------------------------------------=
----------------------------------<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0*From:* amd-gfx &lt;<a href=3D"mailto:=
amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd-gfx-bounces@li=
sts.freedesktop.org</a><br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd-gfx-bounces-PD4FTy7X32mMSPqsTGOZug@public.gmane.org=
esktop.org</a>&gt;&gt; on behalf of Lauri<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0Ehrenpreis &lt;<a href=3D"mailto:lauri=
oma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">laurioma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a> &lt;mailto:<a href=
=3D"mailto:laurioma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">laurioma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;=
&gt;<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0*Sent:* Tuesday, March 12, 2019 5:31 P=
M<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0*To:* Kuehling, Felix<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0*Cc:* Tom St Denis; <a href=3D"mailto:=
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org</a><br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:amd-gfx@l=
ists.freedesktop.org" target=3D"_blank">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>&g=
t;<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0*Subject:* Re: Slow memory access when=
 using OpenCL without X11<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0However it&#39;s not only related to m=
clk and sclk. I tried this:<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0rocm-smi=C2=A0 --setsclk 2<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0rocm-smi=C2=A0 --setmclk 3<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0rocm-smi<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=C2=A0 =C2=A0 =C2=A0 =C2=A0 ROCm System=
 Management Interface<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0GPU=C2=A0 =C2=A0Temp=C2=A0 =C2=A0AvgPw=
r=C2=A0 =C2=A0SCLK=C2=A0 =C2=A0 MCLK=C2=A0 =C2=A0 PCLK=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 Fan=C2=A0 =C2=A0 =C2=A0Perf<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0PwrCap=C2=A0 =C2=A0SCLK OD=C2=
=A0 MCLK OD=C2=A0 GPU%<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0GPU[0] : WARNING: Empty SysFS value: p=
clk<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0GPU[0] : WARNING: Unable to read<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0/sys/class/drm/card0/device/gpu_busy_p=
ercent<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A00=C2=A0 =C2=A0 =C2=A034.0c=C2=A0 N/A=
=C2=A0 =C2=A0 =C2=A0 1240Mhz 1333Mhz N/A=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A00%<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0manual=C2=A0 N/A=C2=A0 =C2=A0 =C2=A0 0=
% 0%=C2=A0 =C2=A0 =C2=A0 =C2=A0N/A<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0End of ROCm SMI Log<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0./cl_slow_test 1<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0got 1 platforms 1 devices<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0speed 3919.777100 avg 3919.777100 mbyt=
es/s<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0speed 3809.373291 avg 3864.575195 mbyt=
es/s<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0speed 585.796814 avg 2771.649170 mbyte=
s/s<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0speed 188.721848 avg 2125.917236 mbyte=
s/s<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0speed 188.916367 avg 1738.517090 mbyte=
s/s<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0So despite forcing max sclk and mclk t=
he memory speed is still slow..<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0--<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0Lauri<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0On Tue, Mar 12, 2019 at 11:21 PM Lauri=
 Ehrenpreis<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"mailto:laurioma@gmail.c=
om" target=3D"_blank">laurioma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a> &lt;mailto:<a href=3D"mailto:l=
aurioma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">laurioma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;&gt; wrote:<=
br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0IN the case when memory =
is slow, the rocm-smi outputs this:<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 ROCm System Management<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Interface =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GPU=C2=A0 =C2=A0Temp=C2=
=A0 =C2=A0AvgPwr=C2=A0 =C2=A0SCLK=C2=A0 =C2=A0 MCLK=C2=A0 =C2=A0 PCLK=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Fan<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Perf=C2=A0 =C2=A0 PwrCa=
p=C2=A0 =C2=A0SCLK OD=C2=A0 MCLK OD=C2=A0 GPU%<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GPU[0] : WARNING: Empty =
SysFS value: pclk<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GPU[0] : WARNING: Unable=
 to read<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/sys/class/drm/card0/dev=
ice/gpu_busy_percent<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00=C2=A0 =C2=A0 =C2=A030.=
0c=C2=A0 N/A=C2=A0 =C2=A0 =C2=A0 400Mhz=C2=A0 933Mhz=C2=A0 N/A=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A00%<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0auto=C2=A0 =C2=A0 N/A=C2=
=A0 =C2=A0 =C2=A0 0% 0%=C2=A0 =C2=A0 =C2=A0 =C2=A0N/A<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0End of ROCm SMI Log<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0normal memory speed case=
 gives following:<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 ROCm System Management<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Interface =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GPU=C2=A0 =C2=A0Temp=C2=
=A0 =C2=A0AvgPwr=C2=A0 =C2=A0SCLK=C2=A0 =C2=A0 MCLK=C2=A0 =C2=A0 PCLK=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Fan<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Perf=C2=A0 =C2=A0 PwrCa=
p=C2=A0 =C2=A0SCLK OD=C2=A0 MCLK OD=C2=A0 GPU%<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GPU[0] : WARNING: Empty =
SysFS value: pclk<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GPU[0] : WARNING: Unable=
 to read<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/sys/class/drm/card0/dev=
ice/gpu_busy_percent<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00=C2=A0 =C2=A0 =C2=A035.=
0c=C2=A0 N/A=C2=A0 =C2=A0 =C2=A0 400Mhz=C2=A0 1200Mhz N/A=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A00%<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0auto=C2=A0 =C2=A0 N/A=C2=
=A0 =C2=A0 =C2=A0 0% 0%=C2=A0 =C2=A0 =C2=A0 =C2=A0N/A<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0End of ROCm SMI Log<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0So there is a difference=
 in MCLK - can this cause such a huge<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0slowdown?<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0--<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Lauri<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0On Tue, Mar 12, 2019 at =
6:39 PM Kuehling, Felix<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"mailto:Fe=
lix.Kuehling-5C7GfCeVMHo@public.gmane.org" target=3D"_blank">Felix.Kuehling-5C7GfCeVMHo@public.gmane.org</a> &lt;mail=
to:<a href=3D"mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org" target=3D"_blank">Felix.Kuehli=
ng-5C7GfCeVMHo@public.gmane.org</a>&gt;&gt; wrote:<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[adding th=
e list back]<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0I&#39;d su=
spect a problem related to memory clock. This is an<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0APU where<=
br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0system mem=
ory is shared with the CPU, so if the SMU<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0changes me=
mory<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0clocks tha=
t would affect CPU memory access performance. If<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0the proble=
m<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0only occur=
s when OpenCL is running, then the compute power<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0profile co=
uld<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0have an ef=
fect here.<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Laurie, ca=
n you monitor the clocks during your tests using<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rocm-smi?<=
br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Regards,<b=
r>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Fe=
lix<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0On 2019-03=
-11 1:15 p.m., Tom St Denis wrote:<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; Hi La=
uri,<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; I don=
&#39;t have ROCm installed locally (not on that team at<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AMD) but I=
<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; can r=
ope in some of the KFD folk and see what they say :-).<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; (in t=
he mean time I should look into installing the ROCm<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stack on m=
y<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; Ubunt=
u disk for experimentation...).<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; Only =
other thing that comes to mind is some sort of<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stutter du=
e to<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; power=
/clock gating (or gfx off/etc).=C2=A0 But that typically<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0affects th=
e<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; displ=
ay/gpu side not the CPU side.<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; Felix=
:=C2=A0 Any known issues with Raven and ROCm interacting<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0over memor=
y<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; bus p=
erformance?<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; Tom<b=
r>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; On Mo=
n, Mar 11, 2019 at 12:56 PM Lauri Ehrenpreis<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;<a hre=
f=3D"mailto:laurioma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">laurioma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a> &l=
t;mailto:<a href=3D"mailto:laurioma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">laurioma@g=
mail.com</a>&gt;<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; &lt;m=
ailto:<a href=3D"mailto:laurioma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">laurioma@gmai=
l.com</a> &lt;mailto:<a href=3D"mailto:laurioma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank=
">laurioma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;&gt;&gt;<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0wrote:<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0=
 =C2=A0 =C2=A0Hi!<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0=
 =C2=A0 =C2=A0The 100x memory slowdown is hard to belive indeed. I<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0attached t=
he<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0=
 =C2=A0 =C2=A0test program with my first e-mail which depends only on<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0=
 =C2=A0 =C2=A0rocm-opencl-dev package. Would you mind compiling it<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0and checki=
ng<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0=
 =C2=A0 =C2=A0if it slows down memory for you as well?<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0=
 =C2=A0 =C2=A0steps:<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0=
 =C2=A0 =C2=A01) g++ cl_slow_test.cpp -o cl_slow_test -I<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0=
 =C2=A0 =C2=A0/opt/rocm/opencl/include/ -L<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/opt/rocm/=
opencl/lib/x86_64/=C2=A0 -lOpenCL<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0=
 =C2=A0 =C2=A02) logout from desktop env and disconnect<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hdmi/dipla=
yport etc<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0=
 =C2=A0 =C2=A03) log in over ssh<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0=
 =C2=A0 =C2=A04) run the program ./cl_slow_test 1<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0=
 =C2=A0 =C2=A0For me it reproduced even without step 2 as well but<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0less<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0=
 =C2=A0 =C2=A0reliably. moving mouse for example could make the<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memory spe=
ed<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0=
 =C2=A0 =C2=A0fast again.<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0=
 =C2=A0 =C2=A0--<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0=
 =C2=A0 =C2=A0Lauri<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0=
 =C2=A0 =C2=A0On Mon, Mar 11, 2019 at 6:33 PM Tom St Denis<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;<a hre=
f=3D"mailto:tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a=
> &lt;mailto:<a href=3D"mailto:tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">tstd=
enis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0=
 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"=
_blank">tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a><br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;mailto=
:<a href=3D"mailto:tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">tstdenis82@gmail=
.com</a>&gt;&gt;&gt; wrote:<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0Hi Lauri,<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0There&#39;s really no connection between the tw=
o<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0other than=
 they<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0run in the same package.=C2=A0 I too run a 2400=
G (as my<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0workstation) and I got the same ~6.6GB/sec<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0transfer r=
ate but<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0without a CL app running ...=C2=A0 The only log=
ical<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reason is =
your<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0CL app is bottlenecking the APUs memory bus but=
<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0you claim<=
br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;simply opening a context is enough&quot; =
so<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0something =
else is<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0going on.<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0Your last reply though says &quot;with it runni=
ng in the<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0background&quot; so it&#39;s entirely possible =
the CPU<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0isn&#39;t =
busy but<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0the package memory controller (shared between<b=
r>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0both the C=
PU and<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0GPU) is busy.=C2=A0 For instance running xonoti=
c in a<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01080p wind=
ow<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0on my 4K display reduced the memory test to<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A05.8GB/sec =
and<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0that&#39;s hardly a heavy memory bound GPU app.=
<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0The only other possible connection is the GPU i=
s<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0generating=
 so<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0much heat that it&#39;s throttling the package =
which<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0is also<br=
>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0unlikely if you have a proper HSF attached (I<b=
r>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0use the on=
es<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0that came in the retail boxes).<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0Cheers,<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0Tom<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;&gt;&gt; &gt;<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd=
-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=
=3D"noreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/lis=
tinfo/amd-gfx</a><br>
</blockquote></div>

--000000000000db27c50584109798--

--===============1364560728==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1364560728==--
