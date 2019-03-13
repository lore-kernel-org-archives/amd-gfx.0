From: Lauri Ehrenpreis <laurioma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Slow memory access when using OpenCL without X11
Date: Wed, 13 Mar 2019 22:15:16 +0200
Message-ID: <CAGyaPbCTM8YoCuJQdD1JkDiA5FkpnMhLkQcb8Lpr8k0KYwLUWQ@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0970067520=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <8502a6bb-26b2-bd5e-c073-8e4e4405d3e2-5C7GfCeVMHo@public.gmane.org>
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
To: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0970067520==
Content-Type: multipart/alternative; boundary="0000000000007564280583ff77b2"

--0000000000007564280583ff77b2
Content-Type: text/plain; charset="UTF-8"

For reproduction only the tiny cl_slow_test.cpp is needed which is attached
to first e-mail.

System information is following:
CPU: Ryzen5 2400G
Main board: Gigabyte AMD B450 AORUS mini itx:
https://www.gigabyte.com/Motherboard/B450-I-AORUS-PRO-WIFI-rev-10#kf
BIOS: F5 8.47 MB 2019/01/25 (latest)
Kernel: https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.0/  (amd64)
OS: Ubuntu 18.04 LTS
rocm-opencl-dev installation:
wget -qO - http://repo.radeon.com/rocm/apt/debian/rocm.gpg.key | sudo
apt-key add -
echo 'deb [arch=amd64] http://repo.radeon.com/rocm/apt/debian/ xenial main'
| sudo tee /etc/apt/sources.list.d/rocm.list
sudo apt install rocm-opencl-dev

Also exactly the same issue happens with this board:
https://www.gigabyte.com/Motherboard/GA-AB350-Gaming-3-rev-1x#kf

I have MSI and Asrock mini itx boards ready as well, So far didn't get
amdgpu & opencl working there but I'll try again tomorrow..

--
Lauri


On Wed, Mar 13, 2019 at 8:51 PM Kuehling, Felix <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
wrote:

> Hi Lauri,
>
> I still think the SMU is doing something funny, but rocm-smi isn't
> showing enough information to really see what's going on.
>
> On APUs the SMU firmware is embedded in the system BIOS. Unlike discrete
> GPUs, the SMU firmware is not loaded by the driver. You could try
> updating your system BIOS to the latest version available from your main
> board vendor and see if that makes a difference. It may include a newer
> version of the SMU firmware, potentially with a fix.
>
> If that doesn't help, we'd have to reproduce the problem in house to see
> what's happening, which may require the same main board and BIOS version
> you're using. We can ask our SMU firmware team if they've ever
> encountered your type of problem. But I don't want to give you too much
> hope. It's a tricky problem involving HW, firmware and multiple driver
> components in a fairly unusual configuration.
>
> Regards,
>    Felix
>
> On 2019-03-13 7:28 a.m., Lauri Ehrenpreis wrote:
> > What I observe is that moving the mouse made the memory speed go up
> > and also it made mclk=1200Mhz in rocm-smi output.
> > However if I force mclk to 1200Mhz myself then memory speed is still
> > slow.
> >
> > So rocm-smi output when memory speed went fast due to mouse movement:
> > rocm-smi
> > ========================        ROCm System Management Interface
> > ========================
> >
> ================================================================================================
> > GPU   Temp   AvgPwr   SCLK    MCLK    PCLK      Fan     Perf
> > PwrCap   SCLK OD   MCLK OD GPU%
> > GPU[0] : WARNING: Empty SysFS value: pclk
> > GPU[0] : WARNING: Unable to read
> > /sys/class/drm/card0/device/gpu_busy_percent
> > 0     44.0c  N/A      400Mhz  1200Mhz N/A       0%      manual  N/A
> >   0%        0%  N/A
> >
> ================================================================================================
> > ========================               End of ROCm SMI Log
> >   ========================
> >
> > And rocm-smi output when I forced memclk=1200MHz myself:
> > rocm-smi --setmclk 2
> > rocm-smi
> > ========================        ROCm System Management Interface
> > ========================
> >
> ================================================================================================
> > GPU   Temp   AvgPwr   SCLK    MCLK    PCLK      Fan     Perf
> > PwrCap   SCLK OD   MCLK OD GPU%
> > GPU[0] : WARNING: Empty SysFS value: pclk
> > GPU[0] : WARNING: Unable to read
> > /sys/class/drm/card0/device/gpu_busy_percent
> > 0     39.0c  N/A      400Mhz  1200Mhz N/A       0%      manual  N/A
> >   0%        0%  N/A
> >
> ================================================================================================
> > ========================               End of ROCm SMI Log
> >   ========================
> >
> > So only difference is that temperature shows 44c when memory speed was
> > fast and 39c when it was slow. But mclk was 1200MHz and sclk was
> > 400MHz in both cases.
> > Can it be that rocm-smi just has a bug in reporting and mclk was not
> > actually 1200MHz when I forced it with rocm-smi --setmclk 2 ?
> > That would explain the different behaviour..
> >
> > If so then is there a programmatic way how to really guarantee the
> > high speed mclk? Basically I want do something similar in my program
> > what happens if I move
> > the mouse in desktop env and this way guarantee the normal memory
> > speed each time the program starts.
> >
> > --
> > Lauri
> >
> >
> > On Tue, Mar 12, 2019 at 11:36 PM Deucher, Alexander
> > <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org <mailto:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>> wrote:
> >
> >     Forcing the sclk and mclk high may impact the CPU frequency since
> >     they share TDP.
> >
> >     Alex
> >
>  ------------------------------------------------------------------------
> >     *From:* amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> >     <mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>> on behalf of Lauri
> >     Ehrenpreis <laurioma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org <mailto:laurioma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>>
> >     *Sent:* Tuesday, March 12, 2019 5:31 PM
> >     *To:* Kuehling, Felix
> >     *Cc:* Tom St Denis; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> >     <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
> >     *Subject:* Re: Slow memory access when using OpenCL without X11
> >     However it's not only related to mclk and sclk. I tried this:
> >     rocm-smi  --setsclk 2
> >     rocm-smi  --setmclk 3
> >     rocm-smi
> >     ========================        ROCm System Management Interface
> >     ========================
> >
>  ================================================================================================
> >     GPU   Temp   AvgPwr   SCLK    MCLK    PCLK          Fan     Perf
> >       PwrCap   SCLK OD  MCLK OD  GPU%
> >     GPU[0] : WARNING: Empty SysFS value: pclk
> >     GPU[0] : WARNING: Unable to read
> >     /sys/class/drm/card0/device/gpu_busy_percent
> >     0     34.0c  N/A      1240Mhz 1333Mhz N/A           0%
> >     manual  N/A      0% 0%       N/A
> >
>  ================================================================================================
> >     ========================               End of ROCm SMI Log
> >     ========================
> >
> >     ./cl_slow_test 1
> >     got 1 platforms 1 devices
> >     speed 3919.777100 avg 3919.777100 mbytes/s
> >     speed 3809.373291 avg 3864.575195 mbytes/s
> >     speed 585.796814 avg 2771.649170 mbytes/s
> >     speed 188.721848 avg 2125.917236 mbytes/s
> >     speed 188.916367 avg 1738.517090 mbytes/s
> >
> >     So despite forcing max sclk and mclk the memory speed is still slow..
> >
> >     --
> >     Lauri
> >
> >
> >     On Tue, Mar 12, 2019 at 11:21 PM Lauri Ehrenpreis
> >     <laurioma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org <mailto:laurioma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>> wrote:
> >
> >         IN the case when memory is slow, the rocm-smi outputs this:
> >         ========================        ROCm System Management
> >         Interface ========================
> >
>  ================================================================================================
> >         GPU   Temp   AvgPwr   SCLK    MCLK    PCLK          Fan
> >          Perf    PwrCap   SCLK OD  MCLK OD  GPU%
> >         GPU[0] : WARNING: Empty SysFS value: pclk
> >         GPU[0] : WARNING: Unable to read
> >         /sys/class/drm/card0/device/gpu_busy_percent
> >         0     30.0c  N/A      400Mhz  933Mhz  N/A           0%
> >         auto    N/A      0% 0%       N/A
> >
>  ================================================================================================
> >         ========================               End of ROCm SMI Log
> >         ========================
> >
> >         normal memory speed case gives following:
> >         ========================        ROCm System Management
> >         Interface ========================
> >
>  ================================================================================================
> >         GPU   Temp   AvgPwr   SCLK    MCLK    PCLK          Fan
> >          Perf    PwrCap   SCLK OD  MCLK OD  GPU%
> >         GPU[0] : WARNING: Empty SysFS value: pclk
> >         GPU[0] : WARNING: Unable to read
> >         /sys/class/drm/card0/device/gpu_busy_percent
> >         0     35.0c  N/A      400Mhz  1200Mhz N/A           0%
> >         auto    N/A      0% 0%       N/A
> >
>  ================================================================================================
> >         ========================               End of ROCm SMI Log
> >         ========================
> >
> >         So there is a difference in MCLK - can this cause such a huge
> >         slowdown?
> >
> >         --
> >         Lauri
> >
> >         On Tue, Mar 12, 2019 at 6:39 PM Kuehling, Felix
> >         <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org <mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>> wrote:
> >
> >             [adding the list back]
> >
> >             I'd suspect a problem related to memory clock. This is an
> >             APU where
> >             system memory is shared with the CPU, so if the SMU
> >             changes memory
> >             clocks that would affect CPU memory access performance. If
> >             the problem
> >             only occurs when OpenCL is running, then the compute power
> >             profile could
> >             have an effect here.
> >
> >             Laurie, can you monitor the clocks during your tests using
> >             rocm-smi?
> >
> >             Regards,
> >                Felix
> >
> >             On 2019-03-11 1:15 p.m., Tom St Denis wrote:
> >             > Hi Lauri,
> >             >
> >             > I don't have ROCm installed locally (not on that team at
> >             AMD) but I
> >             > can rope in some of the KFD folk and see what they say :-).
> >             >
> >             > (in the mean time I should look into installing the ROCm
> >             stack on my
> >             > Ubuntu disk for experimentation...).
> >             >
> >             > Only other thing that comes to mind is some sort of
> >             stutter due to
> >             > power/clock gating (or gfx off/etc).  But that typically
> >             affects the
> >             > display/gpu side not the CPU side.
> >             >
> >             > Felix:  Any known issues with Raven and ROCm interacting
> >             over memory
> >             > bus performance?
> >             >
> >             > Tom
> >             >
> >             > On Mon, Mar 11, 2019 at 12:56 PM Lauri Ehrenpreis
> >             <laurioma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org <mailto:laurioma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >             > <mailto:laurioma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org <mailto:laurioma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>>>
> >             wrote:
> >             >
> >             >     Hi!
> >             >
> >             >     The 100x memory slowdown is hard to belive indeed. I
> >             attached the
> >             >     test program with my first e-mail which depends only on
> >             >     rocm-opencl-dev package. Would you mind compiling it
> >             and checking
> >             >     if it slows down memory for you as well?
> >             >
> >             >     steps:
> >             >     1) g++ cl_slow_test.cpp -o cl_slow_test -I
> >             >     /opt/rocm/opencl/include/ -L
> >             /opt/rocm/opencl/lib/x86_64/  -lOpenCL
> >             >     2) logout from desktop env and disconnect
> >             hdmi/diplayport etc
> >             >     3) log in over ssh
> >             >     4) run the program ./cl_slow_test 1
> >             >
> >             >     For me it reproduced even without step 2 as well but
> >             less
> >             >     reliably. moving mouse for example could make the
> >             memory speed
> >             >     fast again.
> >             >
> >             >     --
> >             >     Lauri
> >             >
> >             >
> >             >
> >             >     On Mon, Mar 11, 2019 at 6:33 PM Tom St Denis
> >             <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org <mailto:tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >             >     <mailto:tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
> >             <mailto:tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>>> wrote:
> >             >
> >             >         Hi Lauri,
> >             >
> >             >         There's really no connection between the two
> >             other than they
> >             >         run in the same package.  I too run a 2400G (as my
> >             >         workstation) and I got the same ~6.6GB/sec
> >             transfer rate but
> >             >         without a CL app running ...  The only logical
> >             reason is your
> >             >         CL app is bottlenecking the APUs memory bus but
> >             you claim
> >             >         "simply opening a context is enough" so
> >             something else is
> >             >         going on.
> >             >
> >             >         Your last reply though says "with it running in the
> >             >         background" so it's entirely possible the CPU
> >             isn't busy but
> >             >         the package memory controller (shared between
> >             both the CPU and
> >             >         GPU) is busy.  For instance running xonotic in a
> >             1080p window
> >             >         on my 4K display reduced the memory test to
> >             5.8GB/sec and
> >             >         that's hardly a heavy memory bound GPU app.
> >             >
> >             >         The only other possible connection is the GPU is
> >             generating so
> >             >         much heat that it's throttling the package which
> >             is also
> >             >         unlikely if you have a proper HSF attached (I
> >             use the ones
> >             >         that came in the retail boxes).
> >             >
> >             >         Cheers,
> >             >         Tom
> >             >
> >
>

--0000000000007564280583ff77b2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0
ciI+PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGRpdj5Gb3Ig
cmVwcm9kdWN0aW9uIG9ubHkgdGhlIHRpbnkgY2xfc2xvd190ZXN0LmNwcCBpcyBuZWVkZWQgd2hp
Y2ggaXMgYXR0YWNoZWQgdG8gZmlyc3QgZS1tYWlsLjwvZGl2PjxkaXYgZGlyPSJsdHIiPjxicj48
L2Rpdj48ZGl2IGRpcj0ibHRyIj5TeXN0ZW0gaW5mb3JtYXRpb24gaXMgZm9sbG93aW5nOjxkaXY+
Q1BVOiBSeXplbjUgMjQwMEc8L2Rpdj48ZGl2Pk1haW4gYm9hcmQ6IEdpZ2FieXRlwqBBTUQgQjQ1
MCBBT1JVUyBtaW5pIGl0eDrCoDxhIGhyZWY9Imh0dHBzOi8vd3d3LmdpZ2FieXRlLmNvbS9Nb3Ro
ZXJib2FyZC9CNDUwLUktQU9SVVMtUFJPLVdJRkktcmV2LTEwI2tmIj5odHRwczovL3d3dy5naWdh
Ynl0ZS5jb20vTW90aGVyYm9hcmQvQjQ1MC1JLUFPUlVTLVBSTy1XSUZJLXJldi0xMCNrZjwvYT48
YnI+PC9kaXY+PGRpdj5CSU9TOiBGNTxzcGFuIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3Nw
YW4+OC40NyBNQjxzcGFuIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+MjAxOS8wMS8y
NSAobGF0ZXN0KTwvZGl2PjxkaXY+S2VybmVsOsKgPGEgaHJlZj0iaHR0cHM6Ly9rZXJuZWwudWJ1
bnR1LmNvbS9+a2VybmVsLXBwYS9tYWlubGluZS92NS4wLyI+aHR0cHM6Ly9rZXJuZWwudWJ1bnR1
LmNvbS9+a2VybmVsLXBwYS9tYWlubGluZS92NS4wLzwvYT7CoCAoYW1kNjQpPC9kaXY+PGRpdj5P
UzogVWJ1bnR1IDE4LjA0IExUUzwvZGl2PjxkaXY+cm9jbS1vcGVuY2wtZGV2IGluc3RhbGxhdGlv
bjo8L2Rpdj48ZGl2PndnZXQgLXFPIC0gPGEgaHJlZj0iaHR0cDovL3JlcG8ucmFkZW9uLmNvbS9y
b2NtL2FwdC9kZWJpYW4vcm9jbS5ncGcua2V5Ij5odHRwOi8vcmVwby5yYWRlb24uY29tL3JvY20v
YXB0L2RlYmlhbi9yb2NtLmdwZy5rZXk8L2E+IHwgc3VkbyBhcHQta2V5IGFkZCAtPC9kaXY+PGRp
dj5lY2hvICYjMzk7ZGViIFthcmNoPWFtZDY0XSA8YSBocmVmPSJodHRwOi8vcmVwby5yYWRlb24u
Y29tL3JvY20vYXB0L2RlYmlhbi8iPmh0dHA6Ly9yZXBvLnJhZGVvbi5jb20vcm9jbS9hcHQvZGVi
aWFuLzwvYT4geGVuaWFsIG1haW4mIzM5OyB8IHN1ZG8gdGVlIC9ldGMvYXB0L3NvdXJjZXMubGlz
dC5kL3JvY20ubGlzdDwvZGl2PjxkaXY+c3VkbyBhcHQgaW5zdGFsbCByb2NtLW9wZW5jbC1kZXY8
L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkFsc28gZXhhY3RseSB0aGUgc2FtZSBpc3N1ZSBoYXBw
ZW5zIHdpdGggdGhpcyBib2FyZDrCoDxhIGhyZWY9Imh0dHBzOi8vd3d3LmdpZ2FieXRlLmNvbS9N
b3RoZXJib2FyZC9HQS1BQjM1MC1HYW1pbmctMy1yZXYtMXgja2YiPmh0dHBzOi8vd3d3LmdpZ2Fi
eXRlLmNvbS9Nb3RoZXJib2FyZC9HQS1BQjM1MC1HYW1pbmctMy1yZXYtMXgja2Y8L2E+PC9kaXY+
PGRpdj7CoDwvZGl2PjxkaXY+SSBoYXZlIE1TSSBhbmQgQXNyb2NrIG1pbmkgaXR4IGJvYXJkcyBy
ZWFkeSBhcyB3ZWxsLCBTbyBmYXIgZGlkbiYjMzk7dCBnZXQgYW1kZ3B1ICZhbXA7IG9wZW5jbCB3
b3JraW5nIHRoZXJlIGJ1dCBJJiMzOTtsbCB0cnkgYWdhaW4gdG9tb3Jyb3cuLjwvZGl2PjxkaXY+
PGJyPjwvZGl2PjxkaXY+LS08L2Rpdj48ZGl2PkxhdXJpPC9kaXY+PGRpdj48YnI+PC9kaXY+PC9k
aXY+PC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+PGJyPjxkaXYgY2xh
c3M9ImdtYWlsX3F1b3RlIj48ZGl2IGRpcj0ibHRyIiBjbGFzcz0iZ21haWxfYXR0ciI+T24gV2Vk
LCBNYXIgMTMsIDIwMTkgYXQgODo1MSBQTSBLdWVobGluZywgRmVsaXggJmx0OzxhIGhyZWY9Im1h
aWx0bzpGZWxpeC5LdWVobGluZ0BhbWQuY29tIj5GZWxpeC5LdWVobGluZ0BhbWQuY29tPC9hPiZn
dDsgd3JvdGU6PGJyPjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9
Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwy
MDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij5IaSBMYXVyaSw8YnI+DQo8YnI+DQpJIHN0aWxsIHRo
aW5rIHRoZSBTTVUgaXMgZG9pbmcgc29tZXRoaW5nIGZ1bm55LCBidXQgcm9jbS1zbWkgaXNuJiMz
OTt0IDxicj4NCnNob3dpbmcgZW5vdWdoIGluZm9ybWF0aW9uIHRvIHJlYWxseSBzZWUgd2hhdCYj
Mzk7cyBnb2luZyBvbi48YnI+DQo8YnI+DQpPbiBBUFVzIHRoZSBTTVUgZmlybXdhcmUgaXMgZW1i
ZWRkZWQgaW4gdGhlIHN5c3RlbSBCSU9TLiBVbmxpa2UgZGlzY3JldGUgPGJyPg0KR1BVcywgdGhl
IFNNVSBmaXJtd2FyZSBpcyBub3QgbG9hZGVkIGJ5IHRoZSBkcml2ZXIuIFlvdSBjb3VsZCB0cnkg
PGJyPg0KdXBkYXRpbmcgeW91ciBzeXN0ZW0gQklPUyB0byB0aGUgbGF0ZXN0IHZlcnNpb24gYXZh
aWxhYmxlIGZyb20geW91ciBtYWluIDxicj4NCmJvYXJkIHZlbmRvciBhbmQgc2VlIGlmIHRoYXQg
bWFrZXMgYSBkaWZmZXJlbmNlLiBJdCBtYXkgaW5jbHVkZSBhIG5ld2VyIDxicj4NCnZlcnNpb24g
b2YgdGhlIFNNVSBmaXJtd2FyZSwgcG90ZW50aWFsbHkgd2l0aCBhIGZpeC48YnI+DQo8YnI+DQpJ
ZiB0aGF0IGRvZXNuJiMzOTt0IGhlbHAsIHdlJiMzOTtkIGhhdmUgdG8gcmVwcm9kdWNlIHRoZSBw
cm9ibGVtIGluIGhvdXNlIHRvIHNlZSA8YnI+DQp3aGF0JiMzOTtzIGhhcHBlbmluZywgd2hpY2gg
bWF5IHJlcXVpcmUgdGhlIHNhbWUgbWFpbiBib2FyZCBhbmQgQklPUyB2ZXJzaW9uIDxicj4NCnlv
dSYjMzk7cmUgdXNpbmcuIFdlIGNhbiBhc2sgb3VyIFNNVSBmaXJtd2FyZSB0ZWFtIGlmIHRoZXkm
IzM5O3ZlIGV2ZXIgPGJyPg0KZW5jb3VudGVyZWQgeW91ciB0eXBlIG9mIHByb2JsZW0uIEJ1dCBJ
IGRvbiYjMzk7dCB3YW50IHRvIGdpdmUgeW91IHRvbyBtdWNoIDxicj4NCmhvcGUuIEl0JiMzOTtz
IGEgdHJpY2t5IHByb2JsZW0gaW52b2x2aW5nIEhXLCBmaXJtd2FyZSBhbmQgbXVsdGlwbGUgZHJp
dmVyIDxicj4NCmNvbXBvbmVudHMgaW4gYSBmYWlybHkgdW51c3VhbCBjb25maWd1cmF0aW9uLjxi
cj4NCjxicj4NClJlZ2FyZHMsPGJyPg0KwqDCoCBGZWxpeDxicj4NCjxicj4NCk9uIDIwMTktMDMt
MTMgNzoyOCBhLm0uLCBMYXVyaSBFaHJlbnByZWlzIHdyb3RlOjxicj4NCiZndDsgV2hhdCBJIG9i
c2VydmUgaXMgdGhhdCBtb3ZpbmcgdGhlIG1vdXNlIG1hZGUgdGhlIG1lbW9yeSBzcGVlZCBnbyB1
cCA8YnI+DQomZ3Q7IGFuZCBhbHNvIGl0IG1hZGUgbWNsaz0xMjAwTWh6IGluIHJvY20tc21pIG91
dHB1dC48YnI+DQomZ3Q7IEhvd2V2ZXIgaWYgSSBmb3JjZSBtY2xrIHRvIDEyMDBNaHogbXlzZWxm
IHRoZW4gbWVtb3J5IHNwZWVkIGlzIHN0aWxsIDxicj4NCiZndDsgc2xvdy48YnI+DQomZ3Q7PGJy
Pg0KJmd0OyBTbyByb2NtLXNtaSBvdXRwdXQgd2hlbiBtZW1vcnkgc3BlZWQgd2VudCBmYXN0IGR1
ZSB0byBtb3VzZSBtb3ZlbWVudDo8YnI+DQomZ3Q7IHJvY20tc21pPGJyPg0KJmd0OyA9PT09PT09
PT09PT09PT09PT09PT09PT3CoCDCoCDCoCDCoCBST0NtIFN5c3RlbSBNYW5hZ2VtZW50IEludGVy
ZmFjZSA8YnI+DQomZ3Q7ID09PT09PT09PT09PT09PT09PT09PT09PTxicj4NCiZndDsgPT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PGJyPg0KJmd0OyBHUFXCoCDCoFRlbXDC
oCDCoEF2Z1B3csKgIMKgU0NMS8KgIMKgIE1DTEvCoCDCoCBQQ0xLIMKgIMKgIMKgRmFuwqAgwqAg
wqBQZXJmwqAgwqAgPGJyPg0KJmd0OyBQd3JDYXDCoCDCoFNDTEsgT0TCoCDCoE1DTEsgT0QgR1BV
JTxicj4NCiZndDsgR1BVWzBdIDogV0FSTklORzogRW1wdHkgU3lzRlMgdmFsdWU6IHBjbGs8YnI+
DQomZ3Q7IEdQVVswXSA6IFdBUk5JTkc6IFVuYWJsZSB0byByZWFkIDxicj4NCiZndDsgL3N5cy9j
bGFzcy9kcm0vY2FyZDAvZGV2aWNlL2dwdV9idXN5X3BlcmNlbnQ8YnI+DQomZ3Q7IDDCoCDCoCDC
oDQ0LjBjwqAgTi9BwqAgwqAgwqAgNDAwTWh6wqAgMTIwME1oeiBOL0EgwqAgwqAgwqAgMCXCoCDC
oCDCoCBtYW51YWzCoCBOL0HCoCDCoCA8YnI+DQomZ3Q7IMKgIDAlwqAgwqAgwqAgwqAgMCUgwqBO
L0E8YnI+DQomZ3Q7ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PTxicj4N
CiZndDsgPT09PT09PT09PT09PT09PT09PT09PT09wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBFbmQg
b2YgUk9DbSBTTUkgTG9nwqAgwqAgwqAgwqAgwqAgwqAgPGJyPg0KJmd0OyDCoCA9PT09PT09PT09
PT09PT09PT09PT09PT08YnI+DQomZ3Q7PGJyPg0KJmd0OyBBbmQgcm9jbS1zbWkgb3V0cHV0IHdo
ZW4gSSBmb3JjZWQgbWVtY2xrPTEyMDBNSHogbXlzZWxmOjxicj4NCiZndDsgcm9jbS1zbWkgLS1z
ZXRtY2xrIDI8YnI+DQomZ3Q7IHJvY20tc21pPGJyPg0KJmd0OyA9PT09PT09PT09PT09PT09PT09
PT09PT3CoCDCoCDCoCDCoCBST0NtIFN5c3RlbSBNYW5hZ2VtZW50IEludGVyZmFjZSA8YnI+DQom
Z3Q7ID09PT09PT09PT09PT09PT09PT09PT09PTxicj4NCiZndDsgPT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PGJyPg0KJmd0OyBHUFXCoCDCoFRlbXDCoCDCoEF2Z1B3csKg
IMKgU0NMS8KgIMKgIE1DTEvCoCDCoCBQQ0xLIMKgIMKgIMKgRmFuwqAgwqAgwqBQZXJmwqAgwqAg
PGJyPg0KJmd0OyBQd3JDYXDCoCDCoFNDTEsgT0TCoCDCoE1DTEsgT0QgR1BVJTxicj4NCiZndDsg
R1BVWzBdIDogV0FSTklORzogRW1wdHkgU3lzRlMgdmFsdWU6IHBjbGs8YnI+DQomZ3Q7IEdQVVsw
XSA6IFdBUk5JTkc6IFVuYWJsZSB0byByZWFkIDxicj4NCiZndDsgL3N5cy9jbGFzcy9kcm0vY2Fy
ZDAvZGV2aWNlL2dwdV9idXN5X3BlcmNlbnQ8YnI+DQomZ3Q7IDDCoCDCoCDCoDM5LjBjwqAgTi9B
wqAgwqAgwqAgNDAwTWh6wqAgMTIwME1oeiBOL0EgwqAgwqAgwqAgMCXCoCDCoCDCoCBtYW51YWzC
oCBOL0HCoCDCoCA8YnI+DQomZ3Q7IMKgIDAlwqAgwqAgwqAgwqAgMCUgwqBOL0E8YnI+DQomZ3Q7
ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PTxicj4NCiZndDsgPT09PT09
PT09PT09PT09PT09PT09PT09wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBFbmQgb2YgUk9DbSBTTUkg
TG9nwqAgwqAgwqAgwqAgwqAgwqAgPGJyPg0KJmd0OyDCoCA9PT09PT09PT09PT09PT09PT09PT09
PT08YnI+DQomZ3Q7PGJyPg0KJmd0OyBTbyBvbmx5IGRpZmZlcmVuY2UgaXMgdGhhdCB0ZW1wZXJh
dHVyZSBzaG93cyA0NGMgd2hlbiBtZW1vcnkgc3BlZWQgd2FzIDxicj4NCiZndDsgZmFzdCBhbmQg
MzljIHdoZW4gaXQgd2FzIHNsb3cuIEJ1dCBtY2xrIHdhcyAxMjAwTUh6IGFuZCBzY2xrIHdhcyA8
YnI+DQomZ3Q7IDQwME1IeiBpbiBib3RoIGNhc2VzLjxicj4NCiZndDsgQ2FuIGl0IGJlIHRoYXQg
cm9jbS1zbWkganVzdCBoYXMgYSBidWcgaW4gcmVwb3J0aW5nIGFuZCBtY2xrIHdhcyBub3QgPGJy
Pg0KJmd0OyBhY3R1YWxseSAxMjAwTUh6IHdoZW4gSSBmb3JjZWQgaXQgd2l0aCByb2NtLXNtaSAt
LXNldG1jbGsgMiA/PGJyPg0KJmd0OyBUaGF0IHdvdWxkIGV4cGxhaW4gdGhlIGRpZmZlcmVudCBi
ZWhhdmlvdXIuLjxicj4NCiZndDs8YnI+DQomZ3Q7IElmIHNvIHRoZW4gaXMgdGhlcmUgYSBwcm9n
cmFtbWF0aWMgd2F5IGhvdyB0byByZWFsbHkgZ3VhcmFudGVlIHRoZSA8YnI+DQomZ3Q7IGhpZ2gg
c3BlZWQgbWNsaz8gQmFzaWNhbGx5IEnCoHdhbnQgZG8gc29tZXRoaW5nIHNpbWlsYXIgaW4gbXkg
cHJvZ3JhbSA8YnI+DQomZ3Q7IHdoYXQgaGFwcGVucyBpZiBJIG1vdmU8YnI+DQomZ3Q7IHRoZSBt
b3VzZSBpbiBkZXNrdG9wIGVudiBhbmQgdGhpcyB3YXkgZ3VhcmFudGVlIHRoZSBub3JtYWwgbWVt
b3J5IDxicj4NCiZndDsgc3BlZWQgZWFjaCB0aW1lIHRoZSBwcm9ncmFtIHN0YXJ0cy48YnI+DQom
Z3Q7PGJyPg0KJmd0OyAtLTxicj4NCiZndDsgTGF1cmk8YnI+DQomZ3Q7PGJyPg0KJmd0Ozxicj4N
CiZndDsgT24gVHVlLCBNYXIgMTIsIDIwMTkgYXQgMTE6MzYgUE0gRGV1Y2hlciwgQWxleGFuZGVy
IDxicj4NCiZndDsgJmx0OzxhIGhyZWY9Im1haWx0bzpBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29t
IiB0YXJnZXQ9Il9ibGFuayI+QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbTwvYT4gJmx0O21haWx0
bzo8YSBocmVmPSJtYWlsdG86QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbSIgdGFyZ2V0PSJfYmxh
bmsiPkFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb208L2E+Jmd0OyZndDsgd3JvdGU6PGJyPg0KJmd0
Ozxicj4NCiZndDvCoCDCoCDCoEZvcmNpbmcgdGhlIHNjbGsgYW5kIG1jbGsgaGlnaCBtYXkgaW1w
YWN0IHRoZSBDUFUgZnJlcXVlbmN5IHNpbmNlPGJyPg0KJmd0O8KgIMKgIMKgdGhleSBzaGFyZSBU
RFAuPGJyPg0KJmd0Ozxicj4NCiZndDvCoCDCoCDCoEFsZXg8YnI+DQomZ3Q7wqAgwqAgwqAtLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS08YnI+DQomZ3Q7wqAgwqAgwqAqRnJvbToqIGFtZC1nZnggJmx0OzxhIGhyZWY9
Im1haWx0bzphbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnIiB0YXJnZXQ9Il9i
bGFuayI+YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZzwvYT48YnI+DQomZ3Q7
wqAgwqAgwqAmbHQ7bWFpbHRvOjxhIGhyZWY9Im1haWx0bzphbWQtZ2Z4LWJvdW5jZXNAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnIiB0YXJnZXQ9Il9ibGFuayI+YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZzwvYT4mZ3Q7Jmd0OyBvbiBiZWhhbGYgb2YgTGF1cmk8YnI+DQomZ3Q7wqAg
wqAgwqBFaHJlbnByZWlzICZsdDs8YSBocmVmPSJtYWlsdG86bGF1cmlvbWFAZ21haWwuY29tIiB0
YXJnZXQ9Il9ibGFuayI+bGF1cmlvbWFAZ21haWwuY29tPC9hPiAmbHQ7bWFpbHRvOjxhIGhyZWY9
Im1haWx0bzpsYXVyaW9tYUBnbWFpbC5jb20iIHRhcmdldD0iX2JsYW5rIj5sYXVyaW9tYUBnbWFp
bC5jb208L2E+Jmd0OyZndDs8YnI+DQomZ3Q7wqAgwqAgwqAqU2VudDoqIFR1ZXNkYXksIE1hcmNo
IDEyLCAyMDE5IDU6MzEgUE08YnI+DQomZ3Q7wqAgwqAgwqAqVG86KiBLdWVobGluZywgRmVsaXg8
YnI+DQomZ3Q7wqAgwqAgwqAqQ2M6KiBUb20gU3QgRGVuaXM7IDxhIGhyZWY9Im1haWx0bzphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZyIgdGFyZ2V0PSJfYmxhbmsiPmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnPC9hPjxicj4NCiZndDvCoCDCoCDCoCZsdDttYWlsdG86PGEgaHJlZj0i
bWFpbHRvOmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnIiB0YXJnZXQ9Il9ibGFuayI+YW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc8L2E+Jmd0Ozxicj4NCiZndDvCoCDCoCDCoCpTdWJq
ZWN0OiogUmU6IFNsb3cgbWVtb3J5IGFjY2VzcyB3aGVuIHVzaW5nIE9wZW5DTCB3aXRob3V0IFgx
MTxicj4NCiZndDvCoCDCoCDCoEhvd2V2ZXIgaXQmIzM5O3Mgbm90IG9ubHkgcmVsYXRlZCB0byBt
Y2xrIGFuZCBzY2xrLiBJIHRyaWVkIHRoaXM6PGJyPg0KJmd0O8KgIMKgIMKgcm9jbS1zbWnCoCAt
LXNldHNjbGsgMjxicj4NCiZndDvCoCDCoCDCoHJvY20tc21pwqAgLS1zZXRtY2xrIDM8YnI+DQom
Z3Q7wqAgwqAgwqByb2NtLXNtaTxicj4NCiZndDvCoCDCoCDCoD09PT09PT09PT09PT09PT09PT09
PT09PcKgIMKgIMKgIMKgIFJPQ20gU3lzdGVtIE1hbmFnZW1lbnQgSW50ZXJmYWNlPGJyPg0KJmd0
O8KgIMKgIMKgPT09PT09PT09PT09PT09PT09PT09PT09PGJyPg0KJmd0O8KgIMKgIMKgPT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PGJyPg0KJmd0O8KgIMKgIMKgR1BVwqAg
wqBUZW1wwqAgwqBBdmdQd3LCoCDCoFNDTEvCoCDCoCBNQ0xLwqAgwqAgUENMSyDCoCDCoCDCoCDC
oCDCoEZhbsKgIMKgIMKgUGVyZsKgPGJyPg0KJmd0O8KgIMKgIMKgwqAgUHdyQ2FwwqAgwqBTQ0xL
IE9EIMKgTUNMSyBPRMKgIEdQVSU8YnI+DQomZ3Q7wqAgwqAgwqBHUFVbMF0gOiBXQVJOSU5HOiBF
bXB0eSBTeXNGUyB2YWx1ZTogcGNsazxicj4NCiZndDvCoCDCoCDCoEdQVVswXSA6IFdBUk5JTkc6
IFVuYWJsZSB0byByZWFkPGJyPg0KJmd0O8KgIMKgIMKgL3N5cy9jbGFzcy9kcm0vY2FyZDAvZGV2
aWNlL2dwdV9idXN5X3BlcmNlbnQ8YnI+DQomZ3Q7wqAgwqAgwqAwwqAgwqAgwqAzNC4wY8KgIE4v
QcKgIMKgIMKgIDEyNDBNaHogMTMzM01oeiBOL0EgwqAgwqAgwqAgwqAgwqAgMCXCoCDCoCDCoDxi
cj4NCiZndDvCoCDCoCDCoG1hbnVhbMKgIE4vQcKgIMKgIMKgIDAlIDAlwqAgwqAgwqAgwqBOL0E8
YnI+DQomZ3Q7wqAgwqAgwqA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT08
YnI+DQomZ3Q7wqAgwqAgwqA9PT09PT09PT09PT09PT09PT09PT09PT3CoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoEVuZCBvZiBST0NtIFNNSSBMb2c8YnI+DQomZ3Q7wqAgwqAgwqA9PT09PT09PT09PT09
PT09PT09PT09PT08YnI+DQomZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgLi9jbF9zbG93X3Rlc3QgMTxi
cj4NCiZndDvCoCDCoCDCoGdvdCAxIHBsYXRmb3JtcyAxIGRldmljZXM8YnI+DQomZ3Q7wqAgwqAg
wqBzcGVlZCAzOTE5Ljc3NzEwMCBhdmcgMzkxOS43NzcxMDAgbWJ5dGVzL3M8YnI+DQomZ3Q7wqAg
wqAgwqBzcGVlZCAzODA5LjM3MzI5MSBhdmcgMzg2NC41NzUxOTUgbWJ5dGVzL3M8YnI+DQomZ3Q7
wqAgwqAgwqBzcGVlZCA1ODUuNzk2ODE0IGF2ZyAyNzcxLjY0OTE3MCBtYnl0ZXMvczxicj4NCiZn
dDvCoCDCoCDCoHNwZWVkIDE4OC43MjE4NDggYXZnIDIxMjUuOTE3MjM2IG1ieXRlcy9zPGJyPg0K
Jmd0O8KgIMKgIMKgc3BlZWQgMTg4LjkxNjM2NyBhdmcgMTczOC41MTcwOTAgbWJ5dGVzL3M8YnI+
DQomZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgU28gZGVzcGl0ZSBmb3JjaW5nIG1heCBzY2xrIGFuZCBt
Y2xrIHRoZSBtZW1vcnkgc3BlZWQgaXMgc3RpbGwgc2xvdy4uPGJyPg0KJmd0Ozxicj4NCiZndDvC
oCDCoCDCoC0tPGJyPg0KJmd0O8KgIMKgIMKgTGF1cmk8YnI+DQomZ3Q7PGJyPg0KJmd0Ozxicj4N
CiZndDvCoCDCoCDCoE9uIFR1ZSwgTWFyIDEyLCAyMDE5IGF0IDExOjIxIFBNIExhdXJpIEVocmVu
cHJlaXM8YnI+DQomZ3Q7wqAgwqAgwqAmbHQ7PGEgaHJlZj0ibWFpbHRvOmxhdXJpb21hQGdtYWls
LmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmxhdXJpb21hQGdtYWlsLmNvbTwvYT4gJmx0O21haWx0bzo8
YSBocmVmPSJtYWlsdG86bGF1cmlvbWFAZ21haWwuY29tIiB0YXJnZXQ9Il9ibGFuayI+bGF1cmlv
bWFAZ21haWwuY29tPC9hPiZndDsmZ3Q7IHdyb3RlOjxicj4NCiZndDs8YnI+DQomZ3Q7wqAgwqAg
wqAgwqAgwqBJTiB0aGUgY2FzZSB3aGVuIG1lbW9yeSBpcyBzbG93LCB0aGUgcm9jbS1zbWkgb3V0
cHV0cyB0aGlzOjxicj4NCiZndDvCoCDCoCDCoCDCoCDCoD09PT09PT09PT09PT09PT09PT09PT09
PcKgIMKgIMKgIMKgIFJPQ20gU3lzdGVtIE1hbmFnZW1lbnQ8YnI+DQomZ3Q7wqAgwqAgwqAgwqAg
wqBJbnRlcmZhY2UgPT09PT09PT09PT09PT09PT09PT09PT09PGJyPg0KJmd0O8KgIMKgIMKgIMKg
IMKgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PGJyPg0KJmd0O8KgIMKg
IMKgIMKgIMKgR1BVwqAgwqBUZW1wwqAgwqBBdmdQd3LCoCDCoFNDTEvCoCDCoCBNQ0xLwqAgwqAg
UENMSyDCoCDCoCDCoCDCoCDCoEZhbsKgIMKgPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgwqBQZXJm
wqAgwqAgUHdyQ2FwwqAgwqBTQ0xLIE9EIMKgTUNMSyBPRMKgIEdQVSU8YnI+DQomZ3Q7wqAgwqAg
wqAgwqAgwqBHUFVbMF0gOiBXQVJOSU5HOiBFbXB0eSBTeXNGUyB2YWx1ZTogcGNsazxicj4NCiZn
dDvCoCDCoCDCoCDCoCDCoEdQVVswXSA6IFdBUk5JTkc6IFVuYWJsZSB0byByZWFkPGJyPg0KJmd0
O8KgIMKgIMKgIMKgIMKgL3N5cy9jbGFzcy9kcm0vY2FyZDAvZGV2aWNlL2dwdV9idXN5X3BlcmNl
bnQ8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAwwqAgwqAgwqAzMC4wY8KgIE4vQcKgIMKgIMKgIDQw
ME1oesKgIDkzM01oesKgIE4vQSDCoCDCoCDCoCDCoCDCoCAwJcKgIMKgIMKgPGJyPg0KJmd0O8Kg
IMKgIMKgIMKgIMKgYXV0b8KgIMKgIE4vQcKgIMKgIMKgIDAlIDAlwqAgwqAgwqAgwqBOL0E8YnI+
DQomZ3Q7wqAgwqAgwqAgwqAgwqA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT08YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqA9PT09PT09PT09PT09PT09PT09PT09PT3CoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoEVuZCBvZiBST0NtIFNNSSBMb2c8YnI+DQomZ3Q7wqAgwqAgwqAgwqAg
wqA9PT09PT09PT09PT09PT09PT09PT09PT08YnI+DQomZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgIMKg
IMKgbm9ybWFsIG1lbW9yeSBzcGVlZCBjYXNlIGdpdmVzIGZvbGxvd2luZzo8YnI+DQomZ3Q7wqAg
wqAgwqAgwqAgwqA9PT09PT09PT09PT09PT09PT09PT09PT3CoCDCoCDCoCDCoCBST0NtIFN5c3Rl
bSBNYW5hZ2VtZW50PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgSW50ZXJmYWNlID09PT09PT09PT09
PT09PT09PT09PT09PTxicj4NCiZndDvCoCDCoCDCoCDCoCDCoD09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PTxicj4NCiZndDvCoCDCoCDCoCDCoCDCoEdQVcKgIMKgVGVtcMKg
IMKgQXZnUHdywqAgwqBTQ0xLwqAgwqAgTUNMS8KgIMKgIFBDTEsgwqAgwqAgwqAgwqAgwqBGYW7C
oCDCoDxicj4NCiZndDvCoCDCoCDCoCDCoCDCoMKgUGVyZsKgIMKgIFB3ckNhcMKgIMKgU0NMSyBP
RCDCoE1DTEsgT0TCoCBHUFUlPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgR1BVWzBdIDogV0FSTklO
RzogRW1wdHkgU3lzRlMgdmFsdWU6IHBjbGs8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqBHUFVbMF0g
OiBXQVJOSU5HOiBVbmFibGUgdG8gcmVhZDxicj4NCiZndDvCoCDCoCDCoCDCoCDCoC9zeXMvY2xh
c3MvZHJtL2NhcmQwL2RldmljZS9ncHVfYnVzeV9wZXJjZW50PGJyPg0KJmd0O8KgIMKgIMKgIMKg
IMKgMMKgIMKgIMKgMzUuMGPCoCBOL0HCoCDCoCDCoCA0MDBNaHrCoCAxMjAwTWh6IE4vQSDCoCDC
oCDCoCDCoCDCoCAwJcKgIMKgIMKgPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgYXV0b8KgIMKgIE4v
QcKgIMKgIMKgIDAlIDAlwqAgwqAgwqAgwqBOL0E8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqA9PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT08YnI+DQomZ3Q7wqAgwqAgwqAgwqAg
wqA9PT09PT09PT09PT09PT09PT09PT09PT3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoEVuZCBvZiBS
T0NtIFNNSSBMb2c8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqA9PT09PT09PT09PT09PT09PT09PT09
PT08YnI+DQomZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgU28gdGhlcmUgaXMgYSBkaWZmZXJl
bmNlIGluIE1DTEsgLSBjYW4gdGhpcyBjYXVzZSBzdWNoIGEgaHVnZTxicj4NCiZndDvCoCDCoCDC
oCDCoCDCoHNsb3dkb3duPzxicj4NCiZndDs8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAtLTxicj4N
CiZndDvCoCDCoCDCoCDCoCDCoExhdXJpPGJyPg0KJmd0Ozxicj4NCiZndDvCoCDCoCDCoCDCoCDC
oE9uIFR1ZSwgTWFyIDEyLCAyMDE5IGF0IDY6MzkgUE0gS3VlaGxpbmcsIEZlbGl4PGJyPg0KJmd0
O8KgIMKgIMKgIMKgIMKgJmx0OzxhIGhyZWY9Im1haWx0bzpGZWxpeC5LdWVobGluZ0BhbWQuY29t
IiB0YXJnZXQ9Il9ibGFuayI+RmVsaXguS3VlaGxpbmdAYW1kLmNvbTwvYT4gJmx0O21haWx0bzo8
YSBocmVmPSJtYWlsdG86RmVsaXguS3VlaGxpbmdAYW1kLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPkZl
bGl4Lkt1ZWhsaW5nQGFtZC5jb208L2E+Jmd0OyZndDsgd3JvdGU6PGJyPg0KJmd0Ozxicj4NCiZn
dDvCoCDCoCDCoCDCoCDCoCDCoCDCoFthZGRpbmcgdGhlIGxpc3QgYmFja108YnI+DQomZ3Q7PGJy
Pg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgSSYjMzk7ZCBzdXNwZWN0IGEgcHJvYmxlbSByZWxh
dGVkIHRvIG1lbW9yeSBjbG9jay4gVGhpcyBpcyBhbjxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDC
oCDCoEFQVSB3aGVyZTxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoHN5c3RlbSBtZW1vcnkg
aXMgc2hhcmVkIHdpdGggdGhlIENQVSwgc28gaWYgdGhlIFNNVTxicj4NCiZndDvCoCDCoCDCoCDC
oCDCoCDCoCDCoGNoYW5nZXMgbWVtb3J5PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgY2xv
Y2tzIHRoYXQgd291bGQgYWZmZWN0IENQVSBtZW1vcnkgYWNjZXNzIHBlcmZvcm1hbmNlLiBJZjxi
cj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoHRoZSBwcm9ibGVtPGJyPg0KJmd0O8KgIMKgIMKg
IMKgIMKgIMKgIMKgb25seSBvY2N1cnMgd2hlbiBPcGVuQ0wgaXMgcnVubmluZywgdGhlbiB0aGUg
Y29tcHV0ZSBwb3dlcjxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoHByb2ZpbGUgY291bGQ8
YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqBoYXZlIGFuIGVmZmVjdCBoZXJlLjxicj4NCiZn
dDs8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqBMYXVyaWUsIGNhbiB5b3UgbW9uaXRvciB0
aGUgY2xvY2tzIGR1cmluZyB5b3VyIHRlc3RzIHVzaW5nPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKg
IMKgIMKgcm9jbS1zbWk/PGJyPg0KJmd0Ozxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoFJl
Z2FyZHMsPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgwqDCoCBGZWxpeDxicj4NCiZndDs8
YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqBPbiAyMDE5LTAzLTExIDE6MTUgcC5tLiwgVG9t
IFN0IERlbmlzIHdyb3RlOjxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCZndDsgSGkgTGF1
cmksPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgJmd0Ozxicj4NCiZndDvCoCDCoCDCoCDC
oCDCoCDCoCDCoCZndDsgSSBkb24mIzM5O3QgaGF2ZSBST0NtIGluc3RhbGxlZCBsb2NhbGx5IChu
b3Qgb24gdGhhdCB0ZWFtIGF0PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgQU1EKSBidXQg
STxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCZndDsgY2FuIHJvcGUgaW4gc29tZSBvZiB0
aGUgS0ZEIGZvbGsgYW5kIHNlZSB3aGF0IHRoZXkgc2F5IDotKS48YnI+DQomZ3Q7wqAgwqAgwqAg
wqAgwqAgwqAgwqAmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgJmd0OyAoaW4gdGhl
IG1lYW4gdGltZSBJIHNob3VsZCBsb29rIGludG8gaW5zdGFsbGluZyB0aGUgUk9DbTxicj4NCiZn
dDvCoCDCoCDCoCDCoCDCoCDCoCDCoHN0YWNrIG9uIG15PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKg
IMKgIMKgJmd0OyBVYnVudHUgZGlzayBmb3IgZXhwZXJpbWVudGF0aW9uLi4uKS48YnI+DQomZ3Q7
wqAgwqAgwqAgwqAgwqAgwqAgwqAmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgJmd0
OyBPbmx5IG90aGVyIHRoaW5nIHRoYXQgY29tZXMgdG8gbWluZCBpcyBzb21lIHNvcnQgb2Y8YnI+
DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqBzdHV0dGVyIGR1ZSB0bzxicj4NCiZndDvCoCDCoCDC
oCDCoCDCoCDCoCDCoCZndDsgcG93ZXIvY2xvY2sgZ2F0aW5nIChvciBnZnggb2ZmL2V0YykuwqAg
QnV0IHRoYXQgdHlwaWNhbGx5PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgYWZmZWN0cyB0
aGU8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAmZ3Q7IGRpc3BsYXkvZ3B1IHNpZGUgbm90
IHRoZSBDUFUgc2lkZS48YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAmZ3Q7PGJyPg0KJmd0
O8KgIMKgIMKgIMKgIMKgIMKgIMKgJmd0OyBGZWxpeDrCoCBBbnkga25vd24gaXNzdWVzIHdpdGgg
UmF2ZW4gYW5kIFJPQ20gaW50ZXJhY3Rpbmc8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqBv
dmVyIG1lbW9yeTxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCZndDsgYnVzIHBlcmZvcm1h
bmNlPzxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCZndDs8YnI+DQomZ3Q7wqAgwqAgwqAg
wqAgwqAgwqAgwqAmZ3Q7IFRvbTxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCZndDs8YnI+
DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAmZ3Q7IE9uIE1vbiwgTWFyIDExLCAyMDE5IGF0IDEy
OjU2IFBNIExhdXJpIEVocmVucHJlaXM8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAmbHQ7
PGEgaHJlZj0ibWFpbHRvOmxhdXJpb21hQGdtYWlsLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmxhdXJp
b21hQGdtYWlsLmNvbTwvYT4gJmx0O21haWx0bzo8YSBocmVmPSJtYWlsdG86bGF1cmlvbWFAZ21h
aWwuY29tIiB0YXJnZXQ9Il9ibGFuayI+bGF1cmlvbWFAZ21haWwuY29tPC9hPiZndDs8YnI+DQom
Z3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAmZ3Q7ICZsdDttYWlsdG86PGEgaHJlZj0ibWFpbHRvOmxh
dXJpb21hQGdtYWlsLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmxhdXJpb21hQGdtYWlsLmNvbTwvYT4g
Jmx0O21haWx0bzo8YSBocmVmPSJtYWlsdG86bGF1cmlvbWFAZ21haWwuY29tIiB0YXJnZXQ9Il9i
bGFuayI+bGF1cmlvbWFAZ21haWwuY29tPC9hPiZndDsmZ3Q7Jmd0Ozxicj4NCiZndDvCoCDCoCDC
oCDCoCDCoCDCoCDCoHdyb3RlOjxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCZndDs8YnI+
DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqBIaSE8YnI+DQomZ3Q7wqAgwqAg
wqAgwqAgwqAgwqAgwqAmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgJmd0O8KgIMKg
IMKgVGhlIDEwMHggbWVtb3J5IHNsb3dkb3duIGlzIGhhcmQgdG8gYmVsaXZlIGluZGVlZC4gSTxi
cj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoGF0dGFjaGVkIHRoZTxicj4NCiZndDvCoCDCoCDC
oCDCoCDCoCDCoCDCoCZndDvCoCDCoCDCoHRlc3QgcHJvZ3JhbSB3aXRoIG15IGZpcnN0IGUtbWFp
bCB3aGljaCBkZXBlbmRzIG9ubHkgb248YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAmZ3Q7
wqAgwqAgwqByb2NtLW9wZW5jbC1kZXYgcGFja2FnZS4gV291bGQgeW91IG1pbmQgY29tcGlsaW5n
IGl0PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgYW5kIGNoZWNraW5nPGJyPg0KJmd0O8Kg
IMKgIMKgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgaWYgaXQgc2xvd3MgZG93biBtZW1vcnkgZm9y
IHlvdSBhcyB3ZWxsPzxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCZndDs8YnI+DQomZ3Q7
wqAgwqAgwqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqBzdGVwczo8YnI+DQomZ3Q7wqAgwqAgwqAg
wqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAxKSBnKysgY2xfc2xvd190ZXN0LmNwcCAtbyBjbF9zbG93
X3Rlc3QgLUk8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAvb3B0L3Jv
Y20vb3BlbmNsL2luY2x1ZGUvIC1MPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgL29wdC9y
b2NtL29wZW5jbC9saWIveDg2XzY0L8KgIC1sT3BlbkNMPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKg
IMKgIMKgJmd0O8KgIMKgIMKgMikgbG9nb3V0IGZyb20gZGVza3RvcCBlbnYgYW5kIGRpc2Nvbm5l
Y3Q8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqBoZG1pL2RpcGxheXBvcnQgZXRjPGJyPg0K
Jmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgMykgbG9nIGluIG92ZXIgc3NoPGJy
Pg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgNCkgcnVuIHRoZSBwcm9ncmFt
IC4vY2xfc2xvd190ZXN0IDE8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAmZ3Q7PGJyPg0K
Jmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgRm9yIG1lIGl0IHJlcHJvZHVjZWQg
ZXZlbiB3aXRob3V0IHN0ZXAgMiBhcyB3ZWxsIGJ1dDxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDC
oCDCoGxlc3M8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqByZWxpYWJs
eS4gbW92aW5nIG1vdXNlIGZvciBleGFtcGxlIGNvdWxkIG1ha2UgdGhlPGJyPg0KJmd0O8KgIMKg
IMKgIMKgIMKgIMKgIMKgbWVtb3J5IHNwZWVkPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKg
Jmd0O8KgIMKgIMKgZmFzdCBhZ2Fpbi48YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAmZ3Q7
PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgLS08YnI+DQomZ3Q7wqAg
wqAgwqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqBMYXVyaTxicj4NCiZndDvCoCDCoCDCoCDCoCDC
oCDCoCDCoCZndDs8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAmZ3Q7PGJyPg0KJmd0O8Kg
IMKgIMKgIMKgIMKgIMKgIMKgJmd0Ozxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCZndDvC
oCDCoCDCoE9uIE1vbiwgTWFyIDExLCAyMDE5IGF0IDY6MzMgUE0gVG9tIFN0IERlbmlzPGJyPg0K
Jmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgJmx0OzxhIGhyZWY9Im1haWx0bzp0c3RkZW5pczgyQGdt
YWlsLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPnRzdGRlbmlzODJAZ21haWwuY29tPC9hPiAmbHQ7bWFp
bHRvOjxhIGhyZWY9Im1haWx0bzp0c3RkZW5pczgyQGdtYWlsLmNvbSIgdGFyZ2V0PSJfYmxhbmsi
PnRzdGRlbmlzODJAZ21haWwuY29tPC9hPiZndDs8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAg
wqAmZ3Q7wqAgwqAgwqAmbHQ7bWFpbHRvOjxhIGhyZWY9Im1haWx0bzp0c3RkZW5pczgyQGdtYWls
LmNvbSIgdGFyZ2V0PSJfYmxhbmsiPnRzdGRlbmlzODJAZ21haWwuY29tPC9hPjxicj4NCiZndDvC
oCDCoCDCoCDCoCDCoCDCoCDCoCZsdDttYWlsdG86PGEgaHJlZj0ibWFpbHRvOnRzdGRlbmlzODJA
Z21haWwuY29tIiB0YXJnZXQ9Il9ibGFuayI+dHN0ZGVuaXM4MkBnbWFpbC5jb208L2E+Jmd0OyZn
dDsmZ3Q7IHdyb3RlOjxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCZndDs8YnI+DQomZ3Q7
wqAgwqAgwqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqBIaSBMYXVyaSw8YnI+DQomZ3Q7
wqAgwqAgwqAgwqAgwqAgwqAgwqAmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgJmd0
O8KgIMKgIMKgIMKgIMKgVGhlcmUmIzM5O3MgcmVhbGx5IG5vIGNvbm5lY3Rpb24gYmV0d2VlbiB0
aGUgdHdvPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgb3RoZXIgdGhhbiB0aGV5PGJyPg0K
Jmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgcnVuIGluIHRoZSBzYW1l
IHBhY2thZ2UuwqAgSSB0b28gcnVuIGEgMjQwMEcgKGFzIG15PGJyPg0KJmd0O8KgIMKgIMKgIMKg
IMKgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgd29ya3N0YXRpb24pIGFuZCBJIGdvdCB0aGUgc2Ft
ZSB+Ni42R0Ivc2VjPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgdHJhbnNmZXIgcmF0ZSBi
dXQ8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqB3aXRob3V0
IGEgQ0wgYXBwIHJ1bm5pbmcgLi4uwqAgVGhlIG9ubHkgbG9naWNhbDxicj4NCiZndDvCoCDCoCDC
oCDCoCDCoCDCoCDCoHJlYXNvbiBpcyB5b3VyPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKg
Jmd0O8KgIMKgIMKgIMKgIMKgQ0wgYXBwIGlzIGJvdHRsZW5lY2tpbmcgdGhlIEFQVXMgbWVtb3J5
IGJ1cyBidXQ8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqB5b3UgY2xhaW08YnI+DQomZ3Q7
wqAgwqAgwqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAmcXVvdDtzaW1wbHkgb3Blbmlu
ZyBhIGNvbnRleHQgaXMgZW5vdWdoJnF1b3Q7IHNvPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKg
IMKgc29tZXRoaW5nIGVsc2UgaXM8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAmZ3Q7wqAg
wqAgwqAgwqAgwqBnb2luZyBvbi48YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAmZ3Q7PGJy
Pg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgWW91ciBsYXN0IHJl
cGx5IHRob3VnaCBzYXlzICZxdW90O3dpdGggaXQgcnVubmluZyBpbiB0aGU8YnI+DQomZ3Q7wqAg
wqAgwqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqBiYWNrZ3JvdW5kJnF1b3Q7IHNvIGl0
JiMzOTtzIGVudGlyZWx5IHBvc3NpYmxlIHRoZSBDUFU8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAg
wqAgwqBpc24mIzM5O3QgYnVzeSBidXQ8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAmZ3Q7
wqAgwqAgwqAgwqAgwqB0aGUgcGFja2FnZSBtZW1vcnkgY29udHJvbGxlciAoc2hhcmVkIGJldHdl
ZW48YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqBib3RoIHRoZSBDUFUgYW5kPGJyPg0KJmd0
O8KgIMKgIMKgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgR1BVKSBpcyBidXN5LsKgIEZv
ciBpbnN0YW5jZSBydW5uaW5nIHhvbm90aWMgaW4gYTxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDC
oCDCoDEwODBwIHdpbmRvdzxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCZndDvCoCDCoCDC
oCDCoCDCoG9uIG15IDRLIGRpc3BsYXkgcmVkdWNlZCB0aGUgbWVtb3J5IHRlc3QgdG88YnI+DQom
Z3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqA1LjhHQi9zZWMgYW5kPGJyPg0KJmd0O8KgIMKgIMKgIMKg
IMKgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgdGhhdCYjMzk7cyBoYXJkbHkgYSBoZWF2eSBtZW1v
cnkgYm91bmQgR1BVIGFwcC48YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAmZ3Q7PGJyPg0K
Jmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgVGhlIG9ubHkgb3RoZXIg
cG9zc2libGUgY29ubmVjdGlvbiBpcyB0aGUgR1BVIGlzPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKg
IMKgIMKgZ2VuZXJhdGluZyBzbzxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCZndDvCoCDC
oCDCoCDCoCDCoG11Y2ggaGVhdCB0aGF0IGl0JiMzOTtzIHRocm90dGxpbmcgdGhlIHBhY2thZ2Ug
d2hpY2g8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqBpcyBhbHNvPGJyPg0KJmd0O8KgIMKg
IMKgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgdW5saWtlbHkgaWYgeW91IGhhdmUgYSBw
cm9wZXIgSFNGIGF0dGFjaGVkIChJPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgdXNlIHRo
ZSBvbmVzPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgdGhh
dCBjYW1lIGluIHRoZSByZXRhaWwgYm94ZXMpLjxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDC
oCZndDs8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqBDaGVl
cnMsPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgVG9tPGJy
Pg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgJmd0Ozxicj4NCiZndDs8YnI+DQo8L2Jsb2NrcXVv
dGU+PC9kaXY+DQo=
--0000000000007564280583ff77b2--

--===============0970067520==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0970067520==--
