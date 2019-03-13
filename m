From: Lauri Ehrenpreis <laurioma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Slow memory access when using OpenCL without X11
Date: Wed, 13 Mar 2019 13:28:21 +0200
Message-ID: <CAGyaPbBAxjGGHA6sxzvSqagLVhiHBDmmp3Oz0==SRhUao488ng@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1559643700=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB180985C2C8051B5BBCF7CDDDF7490-/b2+HYfkarSEx6ez0IUAagdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Cc: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1559643700==
Content-Type: multipart/alternative; boundary="0000000000000f3c040583f81b79"

--0000000000000f3c040583f81b79
Content-Type: text/plain; charset="UTF-8"

What I observe is that moving the mouse made the memory speed go up and
also it made mclk=1200Mhz in rocm-smi output.
However if I force mclk to 1200Mhz myself then memory speed is still slow.

So rocm-smi output when memory speed went fast due to mouse movement:
rocm-smi
========================        ROCm System Management Interface
========================
================================================================================================
GPU   Temp   AvgPwr   SCLK    MCLK    PCLK           Fan     Perf
PwrCap   SCLK OD   MCLK OD  GPU%
GPU[0] : WARNING: Empty SysFS value: pclk
GPU[0] : WARNING: Unable to read
/sys/class/drm/card0/device/gpu_busy_percent
0     44.0c  N/A      400Mhz  1200Mhz N/A            0%      manual  N/A
  0%        0%       N/A
================================================================================================
========================               End of ROCm SMI Log
========================

And rocm-smi output when I forced memclk=1200MHz myself:
rocm-smi --setmclk 2
rocm-smi
========================        ROCm System Management Interface
========================
================================================================================================
GPU   Temp   AvgPwr   SCLK    MCLK    PCLK           Fan     Perf
PwrCap   SCLK OD   MCLK OD  GPU%
GPU[0] : WARNING: Empty SysFS value: pclk
GPU[0] : WARNING: Unable to read
/sys/class/drm/card0/device/gpu_busy_percent
0     39.0c  N/A      400Mhz  1200Mhz N/A            0%      manual  N/A
  0%        0%       N/A
================================================================================================
========================               End of ROCm SMI Log
========================

So only difference is that temperature shows 44c when memory speed was fast
and 39c when it was slow. But mclk was 1200MHz and sclk was 400MHz in both
cases.
Can it be that rocm-smi just has a bug in reporting and mclk was not
actually 1200MHz when I forced it with rocm-smi --setmclk 2 ?
That would explain the different behaviour..

If so then is there a programmatic way how to really guarantee the high
speed mclk? Basically I want do something similar in my program what
happens if I move
the mouse in desktop env and this way guarantee the normal memory speed
each time the program starts.

--
Lauri


On Tue, Mar 12, 2019 at 11:36 PM Deucher, Alexander <
Alexander.Deucher-5C7GfCeVMHo@public.gmane.org> wrote:

> Forcing the sclk and mclk high may impact the CPU frequency since they
> share TDP.
>
> Alex
> ------------------------------
> *From:* amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of
> Lauri Ehrenpreis <laurioma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> *Sent:* Tuesday, March 12, 2019 5:31 PM
> *To:* Kuehling, Felix
> *Cc:* Tom St Denis; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Subject:* Re: Slow memory access when using OpenCL without X11
>
> However it's not only related to mclk and sclk. I tried this:
> rocm-smi  --setsclk 2
> rocm-smi  --setmclk 3
> rocm-smi
> ========================        ROCm System Management Interface
> ========================
>
> ================================================================================================
> GPU   Temp   AvgPwr   SCLK    MCLK    PCLK           Fan     Perf
> PwrCap   SCLK OD   MCLK OD  GPU%
> GPU[0] : WARNING: Empty SysFS value: pclk
> GPU[0] : WARNING: Unable to read
> /sys/class/drm/card0/device/gpu_busy_percent
> 0     34.0c  N/A      1240Mhz 1333Mhz N/A            0%      manual  N/A
>     0%        0%       N/A
>
> ================================================================================================
> ========================               End of ROCm SMI Log
> ========================
>
> ./cl_slow_test 1
> got 1 platforms 1 devices
> speed 3919.777100 avg 3919.777100 mbytes/s
> speed 3809.373291 avg 3864.575195 mbytes/s
> speed 585.796814 avg 2771.649170 mbytes/s
> speed 188.721848 avg 2125.917236 mbytes/s
> speed 188.916367 avg 1738.517090 mbytes/s
>
> So despite forcing max sclk and mclk the memory speed is still slow..
>
> --
> Lauri
>
>
> On Tue, Mar 12, 2019 at 11:21 PM Lauri Ehrenpreis <laurioma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> wrote:
>
> IN the case when memory is slow, the rocm-smi outputs this:
> ========================        ROCm System Management Interface
> ========================
>
> ================================================================================================
> GPU   Temp   AvgPwr   SCLK    MCLK    PCLK           Fan     Perf
> PwrCap   SCLK OD   MCLK OD  GPU%
> GPU[0] : WARNING: Empty SysFS value: pclk
> GPU[0] : WARNING: Unable to read
> /sys/class/drm/card0/device/gpu_busy_percent
> 0     30.0c  N/A      400Mhz  933Mhz  N/A            0%      auto    N/A
>     0%        0%       N/A
>
> ================================================================================================
> ========================               End of ROCm SMI Log
> ========================
>
> normal memory speed case gives following:
> ========================        ROCm System Management Interface
> ========================
>
> ================================================================================================
> GPU   Temp   AvgPwr   SCLK    MCLK    PCLK           Fan     Perf
> PwrCap   SCLK OD   MCLK OD  GPU%
> GPU[0] : WARNING: Empty SysFS value: pclk
> GPU[0] : WARNING: Unable to read
> /sys/class/drm/card0/device/gpu_busy_percent
> 0     35.0c  N/A      400Mhz  1200Mhz N/A            0%      auto    N/A
>     0%        0%       N/A
>
> ================================================================================================
> ========================               End of ROCm SMI Log
> ========================
>
> So there is a difference in MCLK - can this cause such a huge slowdown?
>
> --
> Lauri
>
> On Tue, Mar 12, 2019 at 6:39 PM Kuehling, Felix <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
> wrote:
>
> [adding the list back]
>
> I'd suspect a problem related to memory clock. This is an APU where
> system memory is shared with the CPU, so if the SMU changes memory
> clocks that would affect CPU memory access performance. If the problem
> only occurs when OpenCL is running, then the compute power profile could
> have an effect here.
>
> Laurie, can you monitor the clocks during your tests using rocm-smi?
>
> Regards,
>    Felix
>
> On 2019-03-11 1:15 p.m., Tom St Denis wrote:
> > Hi Lauri,
> >
> > I don't have ROCm installed locally (not on that team at AMD) but I
> > can rope in some of the KFD folk and see what they say :-).
> >
> > (in the mean time I should look into installing the ROCm stack on my
> > Ubuntu disk for experimentation...).
> >
> > Only other thing that comes to mind is some sort of stutter due to
> > power/clock gating (or gfx off/etc).  But that typically affects the
> > display/gpu side not the CPU side.
> >
> > Felix:  Any known issues with Raven and ROCm interacting over memory
> > bus performance?
> >
> > Tom
> >
> > On Mon, Mar 11, 2019 at 12:56 PM Lauri Ehrenpreis <laurioma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
> > <mailto:laurioma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>> wrote:
> >
> >     Hi!
> >
> >     The 100x memory slowdown is hard to belive indeed. I attached the
> >     test program with my first e-mail which depends only on
> >     rocm-opencl-dev package. Would you mind compiling it and checking
> >     if it slows down memory for you as well?
> >
> >     steps:
> >     1) g++ cl_slow_test.cpp -o cl_slow_test -I
> >     /opt/rocm/opencl/include/ -L /opt/rocm/opencl/lib/x86_64/  -lOpenCL
> >     2) logout from desktop env and disconnect hdmi/diplayport etc
> >     3) log in over ssh
> >     4) run the program ./cl_slow_test 1
> >
> >     For me it reproduced even without step 2 as well but less
> >     reliably. moving mouse for example could make the memory speed
> >     fast again.
> >
> >     --
> >     Lauri
> >
> >
> >
> >     On Mon, Mar 11, 2019 at 6:33 PM Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
> >     <mailto:tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>> wrote:
> >
> >         Hi Lauri,
> >
> >         There's really no connection between the two other than they
> >         run in the same package.  I too run a 2400G (as my
> >         workstation) and I got the same ~6.6GB/sec transfer rate but
> >         without a CL app running ...  The only logical reason is your
> >         CL app is bottlenecking the APUs memory bus but you claim
> >         "simply opening a context is enough" so something else is
> >         going on.
> >
> >         Your last reply though says "with it running in the
> >         background" so it's entirely possible the CPU isn't busy but
> >         the package memory controller (shared between both the CPU and
> >         GPU) is busy.  For instance running xonotic in a 1080p window
> >         on my 4K display reduced the memory test to 5.8GB/sec and
> >         that's hardly a heavy memory bound GPU app.
> >
> >         The only other possible connection is the GPU is generating so
> >         much heat that it's throttling the package which is also
> >         unlikely if you have a proper HSF attached (I use the ones
> >         that came in the retail boxes).
> >
> >         Cheers,
> >         Tom
> >
>
>

--0000000000000f3c040583f81b79
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0
ciI+PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+V2hhdCBJIG9ic2VydmUgaXMgdGhhdCBt
b3ZpbmcgdGhlIG1vdXNlIG1hZGUgdGhlIG1lbW9yeSBzcGVlZCBnbyB1cCBhbmQgYWxzbyBpdCBt
YWRlIG1jbGs9MTIwME1oeiBpbiByb2NtLXNtaSBvdXRwdXQuPGRpdj5Ib3dldmVyIGlmIEkgZm9y
Y2UgbWNsayB0byAxMjAwTWh6IG15c2VsZiB0aGVuIG1lbW9yeSBzcGVlZCBpcyBzdGlsbCBzbG93
LiA8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PlNvIHJvY20tc21pIG91dHB1dCB3aGVuIG1lbW9y
eSBzcGVlZCB3ZW50IGZhc3QgZHVlIHRvIG1vdXNlIG1vdmVtZW50OjwvZGl2PjxkaXY+cm9jbS1z
bWk8YnI+PC9kaXY+PGRpdj48ZGl2Pj09PT09PT09PT09PT09PT09PT09PT09PcKgIMKgIMKgIMKg
IFJPQ20gU3lzdGVtIE1hbmFnZW1lbnQgSW50ZXJmYWNlwqAgwqAgwqAgwqAgPT09PT09PT09PT09
PT09PT09PT09PT09PC9kaXY+PGRpdj49PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT08L2Rpdj48ZGl2PkdQVcKgIMKgVGVtcMKgIMKgQXZnUHdywqAgwqBTQ0xLwqAgwqAgTUNM
S8KgIMKgIFBDTEvCoCDCoCDCoCDCoCDCoCDCoEZhbsKgIMKgIMKgUGVyZsKgIMKgIFB3ckNhcMKg
IMKgU0NMSyBPRMKgIMKgTUNMSyBPRMKgIEdQVSU8L2Rpdj48ZGl2PkdQVVswXSA8c3BhbiBzdHls
ZT0id2hpdGUtc3BhY2U6cHJlIj4JCTwvc3Bhbj46IFdBUk5JTkc6IEVtcHR5IFN5c0ZTIHZhbHVl
OiBwY2xrPC9kaXY+PGRpdj5HUFVbMF0gPHNwYW4gc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CQk8
L3NwYW4+OiBXQVJOSU5HOiBVbmFibGUgdG8gcmVhZCAvc3lzL2NsYXNzL2RybS9jYXJkMC9kZXZp
Y2UvZ3B1X2J1c3lfcGVyY2VudDwvZGl2PjxkaXY+MMKgIMKgIMKgNDQuMGPCoCBOL0HCoCDCoCDC
oCA0MDBNaHrCoCAxMjAwTWh6IE4vQcKgIMKgIMKgIMKgIMKgIMKgIDAlwqAgwqAgwqAgbWFudWFs
wqAgTi9BwqAgwqAgwqAgMCXCoCDCoCDCoCDCoCAwJcKgIMKgIMKgIMKgTi9BwqAgwqAgwqDCoDwv
ZGl2PjxkaXY+PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PC9kaXY+PGRp
dj49PT09PT09PT09PT09PT09PT09PT09PT3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoEVuZCBvZiBS
T0NtIFNNSSBMb2fCoCDCoCDCoCDCoCDCoCDCoCDCoCA9PT09PT09PT09PT09PT09PT09PT09PT08
L2Rpdj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkFuZCByb2NtLXNtaSBvdXRwdXQgd2hlbiBJ
IGZvcmNlZCBtZW1jbGs9MTIwME1IeiBteXNlbGY6PC9kaXY+PGRpdj5yb2NtLXNtaSAtLXNldG1j
bGsgMjxicj48L2Rpdj48ZGl2PnJvY20tc21pPGJyPjwvZGl2PjxkaXY+PGRpdj49PT09PT09PT09
PT09PT09PT09PT09PT3CoCDCoCDCoCDCoCBST0NtIFN5c3RlbSBNYW5hZ2VtZW50IEludGVyZmFj
ZcKgIMKgIMKgIMKgID09PT09PT09PT09PT09PT09PT09PT09PTwvZGl2PjxkaXY+PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PC9kaXY+PGRpdj5HUFXCoCDCoFRlbXDCoCDC
oEF2Z1B3csKgIMKgU0NMS8KgIMKgIE1DTEvCoCDCoCBQQ0xLwqAgwqAgwqAgwqAgwqAgwqBGYW7C
oCDCoCDCoFBlcmbCoCDCoCBQd3JDYXDCoCDCoFNDTEsgT0TCoCDCoE1DTEsgT0TCoCBHUFUlPC9k
aXY+PGRpdj5HUFVbMF0gPHNwYW4gc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CQk8L3NwYW4+OiBX
QVJOSU5HOiBFbXB0eSBTeXNGUyB2YWx1ZTogcGNsazwvZGl2PjxkaXY+R1BVWzBdIDxzcGFuIHN0
eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgkJPC9zcGFuPjogV0FSTklORzogVW5hYmxlIHRvIHJlYWQg
L3N5cy9jbGFzcy9kcm0vY2FyZDAvZGV2aWNlL2dwdV9idXN5X3BlcmNlbnQ8L2Rpdj48ZGl2PjDC
oCDCoCDCoDM5LjBjwqAgTi9BwqAgwqAgwqAgNDAwTWh6wqAgMTIwME1oeiBOL0HCoCDCoCDCoCDC
oCDCoCDCoCAwJcKgIMKgIMKgIG1hbnVhbMKgIE4vQcKgIMKgIMKgIDAlwqAgwqAgwqAgwqAgMCXC
oCDCoCDCoCDCoE4vQcKgIMKgIMKgwqA8L2Rpdj48ZGl2Pj09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PTwvZGl2PjxkaXY+PT09PT09PT09PT09PT09PT09PT09PT09wqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBFbmQgb2YgUk9DbSBTTUkgTG9nwqAgwqAgwqAgwqAgwqAgwqAgwqAg
PT09PT09PT09PT09PT09PT09PT09PT09PC9kaXY+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5T
byBvbmx5IGRpZmZlcmVuY2UgaXMgdGhhdCB0ZW1wZXJhdHVyZSBzaG93cyA0NGMgd2hlbiBtZW1v
cnkgc3BlZWQgd2FzIGZhc3QgYW5kIDM5YyB3aGVuIGl0IHdhcyBzbG93LiBCdXQgbWNsayB3YXMg
MTIwME1IeiBhbmQgc2NsayB3YXMgNDAwTUh6IGluIGJvdGggY2FzZXMuPC9kaXY+PGRpdj5DYW4g
aXQgYmUgdGhhdCByb2NtLXNtaSBqdXN0IGhhcyBhIGJ1ZyBpbiByZXBvcnRpbmcgYW5kIG1jbGsg
d2FzIG5vdCBhY3R1YWxseSAxMjAwTUh6IHdoZW4gSSBmb3JjZWQgaXQgd2l0aCByb2NtLXNtaSAt
LXNldG1jbGsgMiA/PC9kaXY+PGRpdj5UaGF0IHdvdWxkIGV4cGxhaW4gdGhlIGRpZmZlcmVudCBi
ZWhhdmlvdXIuLjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+SWYgc28gdGhlbiBpcyB0aGVyZSBh
IHByb2dyYW1tYXRpYyB3YXkgaG93IHRvIHJlYWxseSBndWFyYW50ZWUgdGhlIGhpZ2ggc3BlZWQg
bWNsaz8gQmFzaWNhbGx5IEnCoHdhbnQgZG8gc29tZXRoaW5nIHNpbWlsYXIgaW4gbXkgcHJvZ3Jh
bSB3aGF0IGhhcHBlbnMgaWYgSSBtb3ZlwqA8L2Rpdj48ZGl2PnRoZSBtb3VzZSBpbiBkZXNrdG9w
IGVudiBhbmQgdGhpcyB3YXkgZ3VhcmFudGVlIHRoZSBub3JtYWwgbWVtb3J5IHNwZWVkIGVhY2gg
dGltZSB0aGUgcHJvZ3JhbSBzdGFydHMuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj4tLTwvZGl2
PjxkaXY+TGF1cmk8L2Rpdj48ZGl2Pjxicj48L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj48
L2Rpdj48L2Rpdj48YnI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPjxkaXYgZGlyPSJsdHIiIGNs
YXNzPSJnbWFpbF9hdHRyIj5PbiBUdWUsIE1hciAxMiwgMjAxOSBhdCAxMTozNiBQTSBEZXVjaGVy
LCBBbGV4YW5kZXIgJmx0OzxhIGhyZWY9Im1haWx0bzpBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29t
Ij5BbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPC9hPiZndDsgd3JvdGU6PGJyPjwvZGl2PjxibG9j
a3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhl
eDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4
Ij4NCg0KDQoNCg0KPGRpdiBkaXI9Imx0ciI+DQo8ZGl2IHN0eWxlPSJmb250LWZhbWlseTpDYWxp
YnJpLEFyaWFsLEhlbHZldGljYSxzYW5zLXNlcmlmO2ZvbnQtc2l6ZToxMnB0O2NvbG9yOnJnYigw
LDAsMCkiPg0KRm9yY2luZyB0aGUgc2NsayBhbmQgbWNsayBoaWdoIG1heSBpbXBhY3QgdGhlIENQ
VSBmcmVxdWVuY3kgc2luY2UgdGhleSBzaGFyZSBURFAuPC9kaXY+DQo8ZGl2IHN0eWxlPSJmb250
LWZhbWlseTpDYWxpYnJpLEFyaWFsLEhlbHZldGljYSxzYW5zLXNlcmlmO2ZvbnQtc2l6ZToxMnB0
O2NvbG9yOnJnYigwLDAsMCkiPg0KPGJyPg0KPC9kaXY+DQo8ZGl2IHN0eWxlPSJmb250LWZhbWls
eTpDYWxpYnJpLEFyaWFsLEhlbHZldGljYSxzYW5zLXNlcmlmO2ZvbnQtc2l6ZToxMnB0O2NvbG9y
OnJnYigwLDAsMCkiPg0KQWxleDxicj4NCjwvZGl2Pg0KPGRpdiBpZD0iZ21haWwtbV8tNjc5Mjg1
NTQ3MzAyMjM5NzgyYXBwZW5kb25zZW5kIj48L2Rpdj4NCjxociBzdHlsZT0iZGlzcGxheTppbmxp
bmUtYmxvY2s7d2lkdGg6OTglIj4NCjxkaXYgaWQ9ImdtYWlsLW1fLTY3OTI4NTU0NzMwMjIzOTc4
MmRpdlJwbHlGd2RNc2ciIGRpcj0ibHRyIj48Zm9udCBmYWNlPSJDYWxpYnJpLCBzYW5zLXNlcmlm
IiBzdHlsZT0iZm9udC1zaXplOjExcHQiIGNvbG9yPSIjMDAwMDAwIj48Yj5Gcm9tOjwvYj4gYW1k
LWdmeCAmbHQ7PGEgaHJlZj0ibWFpbHRvOmFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3Rv
cC5vcmciIHRhcmdldD0iX2JsYW5rIj5hbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnPC9hPiZndDsgb24gYmVoYWxmIG9mIExhdXJpIEVocmVucHJlaXMgJmx0OzxhIGhyZWY9Im1h
aWx0bzpsYXVyaW9tYUBnbWFpbC5jb20iIHRhcmdldD0iX2JsYW5rIj5sYXVyaW9tYUBnbWFpbC5j
b208L2E+Jmd0Ozxicj4NCjxiPlNlbnQ6PC9iPiBUdWVzZGF5LCBNYXJjaCAxMiwgMjAxOSA1OjMx
IFBNPGJyPg0KPGI+VG86PC9iPiBLdWVobGluZywgRmVsaXg8YnI+DQo8Yj5DYzo8L2I+IFRvbSBT
dCBEZW5pczsgPGEgaHJlZj0ibWFpbHRvOmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnIiB0
YXJnZXQ9Il9ibGFuayI+YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc8L2E+PGJyPg0KPGI+
U3ViamVjdDo8L2I+IFJlOiBTbG93IG1lbW9yeSBhY2Nlc3Mgd2hlbiB1c2luZyBPcGVuQ0wgd2l0
aG91dCBYMTE8L2ZvbnQ+DQo8ZGl2PsKgPC9kaXY+DQo8L2Rpdj4NCjxkaXY+DQo8ZGl2IGRpcj0i
bHRyIj4NCjxkaXYgZGlyPSJsdHIiPg0KPGRpdiBkaXI9Imx0ciI+DQo8ZGl2IGRpcj0ibHRyIj5I
b3dldmVyIGl0JiMzOTtzIG5vdCBvbmx5IHJlbGF0ZWQgdG8gbWNsayBhbmQgc2Nsay4gSSB0cmll
ZCB0aGlzOg0KPGRpdj4NCjxkaXY+cm9jbS1zbWnCoCAtLXNldHNjbGsgMjxicj4NCjwvZGl2Pg0K
PGRpdj5yb2NtLXNtacKgIC0tc2V0bWNsayAzPGJyPg0KPC9kaXY+DQpyb2NtLXNtaTwvZGl2Pg0K
PGRpdj4NCjxkaXY+PT09PT09PT09PT09PT09PT09PT09PT09wqAgwqAgwqAgwqAgUk9DbSBTeXN0
ZW0gTWFuYWdlbWVudCBJbnRlcmZhY2XCoCDCoCDCoCDCoCA9PT09PT09PT09PT09PT09PT09PT09
PT08L2Rpdj4NCjxkaXY+PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PC9k
aXY+DQo8ZGl2PkdQVcKgIMKgVGVtcMKgIMKgQXZnUHdywqAgwqBTQ0xLwqAgwqAgTUNMS8KgIMKg
IFBDTEvCoCDCoCDCoCDCoCDCoCDCoEZhbsKgIMKgIMKgUGVyZsKgIMKgIFB3ckNhcMKgIMKgU0NM
SyBPRMKgIMKgTUNMSyBPRMKgIEdQVSU8L2Rpdj4NCjxkaXY+R1BVWzBdIDxzcGFuIHN0eWxlPSJ3
aGl0ZS1zcGFjZTpwcmUtd3JhcCI+PC9zcGFuPjogV0FSTklORzogRW1wdHkgU3lzRlMgdmFsdWU6
IHBjbGs8L2Rpdj4NCjxkaXY+R1BVWzBdIDxzcGFuIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUtd3Jh
cCI+PC9zcGFuPjogV0FSTklORzogVW5hYmxlIHRvIHJlYWQgL3N5cy9jbGFzcy9kcm0vY2FyZDAv
ZGV2aWNlL2dwdV9idXN5X3BlcmNlbnQ8L2Rpdj4NCjxkaXY+MMKgIMKgIMKgMzQuMGPCoCBOL0HC
oCDCoCDCoCAxMjQwTWh6IDEzMzNNaHogTi9BwqAgwqAgwqAgwqAgwqAgwqAgMCXCoCDCoCDCoCBt
YW51YWzCoCBOL0HCoCDCoCDCoCAwJcKgIMKgIMKgIMKgIDAlwqAgwqAgwqAgwqBOL0HCoCDCoCDC
oMKgPC9kaXY+DQo8ZGl2Pj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PTwv
ZGl2Pg0KPGRpdj49PT09PT09PT09PT09PT09PT09PT09PT3CoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oEVuZCBvZiBST0NtIFNNSSBMb2fCoCDCoCDCoCDCoCDCoCDCoCDCoCA9PT09PT09PT09PT09PT09
PT09PT09PT08L2Rpdj4NCjwvZGl2Pg0KPGRpdj48YnI+DQo8L2Rpdj4NCjxkaXY+DQo8ZGl2Pi4v
Y2xfc2xvd190ZXN0IDE8L2Rpdj4NCjxkaXY+Z290IDEgcGxhdGZvcm1zIDEgZGV2aWNlczwvZGl2
Pg0KPGRpdj5zcGVlZCAzOTE5Ljc3NzEwMCBhdmcgMzkxOS43NzcxMDAgbWJ5dGVzL3M8L2Rpdj4N
CjxkaXY+c3BlZWQgMzgwOS4zNzMyOTEgYXZnIDM4NjQuNTc1MTk1IG1ieXRlcy9zPC9kaXY+DQo8
ZGl2PnNwZWVkIDU4NS43OTY4MTQgYXZnIDI3NzEuNjQ5MTcwIG1ieXRlcy9zPC9kaXY+DQo8ZGl2
PnNwZWVkIDE4OC43MjE4NDggYXZnIDIxMjUuOTE3MjM2IG1ieXRlcy9zPC9kaXY+DQo8ZGl2PnNw
ZWVkIDE4OC45MTYzNjcgYXZnIDE3MzguNTE3MDkwIG1ieXRlcy9zPC9kaXY+DQo8ZGl2Pjxicj4N
CjwvZGl2Pg0KPC9kaXY+DQo8ZGl2PlNvIGRlc3BpdGUgZm9yY2luZyBtYXggc2NsayBhbmQgbWNs
ayB0aGUgbWVtb3J5IHNwZWVkIGlzIHN0aWxsIHNsb3cuLjwvZGl2Pg0KPGRpdj48YnI+DQo8L2Rp
dj4NCjxkaXY+LS08L2Rpdj4NCjxkaXY+TGF1cmk8L2Rpdj4NCjxkaXY+PGJyPg0KPC9kaXY+DQo8
L2Rpdj4NCjwvZGl2Pg0KPC9kaXY+DQo8L2Rpdj4NCjxicj4NCjxkaXYgY2xhc3M9ImdtYWlsLW1f
LTY3OTI4NTU0NzMwMjIzOTc4MnhfZ21haWxfcXVvdGUiPg0KPGRpdiBkaXI9Imx0ciIgY2xhc3M9
ImdtYWlsLW1fLTY3OTI4NTU0NzMwMjIzOTc4MnhfZ21haWxfYXR0ciI+T24gVHVlLCBNYXIgMTIs
IDIwMTkgYXQgMTE6MjEgUE0gTGF1cmkgRWhyZW5wcmVpcyAmbHQ7PGEgaHJlZj0ibWFpbHRvOmxh
dXJpb21hQGdtYWlsLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmxhdXJpb21hQGdtYWlsLmNvbTwvYT4m
Z3Q7IHdyb3RlOjxicj4NCjwvZGl2Pg0KPGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsLW1fLTY3OTI4
NTU0NzMwMjIzOTc4MnhfZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44
ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFl
eCI+DQo8ZGl2IGRpcj0ibHRyIj4NCjxkaXYgZGlyPSJsdHIiPg0KPGRpdiBkaXI9Imx0ciI+SU4g
dGhlIGNhc2Ugd2hlbiBtZW1vcnkgaXMgc2xvdywgdGhlIHJvY20tc21pIG91dHB1dHMgdGhpczoN
CjxkaXY+PT09PT09PT09PT09PT09PT09PT09PT09wqAgwqAgwqAgwqAgUk9DbSBTeXN0ZW0gTWFu
YWdlbWVudCBJbnRlcmZhY2XCoCDCoCDCoCDCoCA9PT09PT09PT09PT09PT09PT09PT09PT08L2Rp
dj4NCjxkaXY+PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PC9kaXY+DQo8
ZGl2PkdQVcKgIMKgVGVtcMKgIMKgQXZnUHdywqAgwqBTQ0xLwqAgwqAgTUNMS8KgIMKgIFBDTEvC
oCDCoCDCoCDCoCDCoCDCoEZhbsKgIMKgIMKgUGVyZsKgIMKgIFB3ckNhcMKgIMKgU0NMSyBPRMKg
IMKgTUNMSyBPRMKgIEdQVSU8L2Rpdj4NCjxkaXY+R1BVWzBdIDxzcGFuIHN0eWxlPSJ3aGl0ZS1z
cGFjZTpwcmUtd3JhcCI+PC9zcGFuPjogV0FSTklORzogRW1wdHkgU3lzRlMgdmFsdWU6IHBjbGs8
L2Rpdj4NCjxkaXY+R1BVWzBdIDxzcGFuIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUtd3JhcCI+PC9z
cGFuPjogV0FSTklORzogVW5hYmxlIHRvIHJlYWQgL3N5cy9jbGFzcy9kcm0vY2FyZDAvZGV2aWNl
L2dwdV9idXN5X3BlcmNlbnQ8L2Rpdj4NCjxkaXY+MMKgIMKgIMKgMzAuMGPCoCBOL0HCoCDCoCDC
oCA0MDBNaHrCoCA5MzNNaHrCoCBOL0HCoCDCoCDCoCDCoCDCoCDCoCAwJcKgIMKgIMKgIGF1dG/C
oCDCoCBOL0HCoCDCoCDCoCAwJcKgIMKgIMKgIMKgIDAlwqAgwqAgwqAgwqBOL0HCoCDCoCDCoMKg
PC9kaXY+DQo8ZGl2Pj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PTwvZGl2
Pg0KPGRpdj49PT09PT09PT09PT09PT09PT09PT09PT3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoEVu
ZCBvZiBST0NtIFNNSSBMb2fCoCDCoCDCoCDCoCDCoCDCoCDCoCA9PT09PT09PT09PT09PT09PT09
PT09PT08L2Rpdj4NCjxkaXY+PGJyPg0KPC9kaXY+DQo8ZGl2Pm5vcm1hbCBtZW1vcnkgc3BlZWQg
Y2FzZSBnaXZlcyBmb2xsb3dpbmc6PC9kaXY+DQo8ZGl2Pj09PT09PT09PT09PT09PT09PT09PT09
PcKgIMKgIMKgIMKgIFJPQ20gU3lzdGVtIE1hbmFnZW1lbnQgSW50ZXJmYWNlwqAgwqAgwqAgwqAg
PT09PT09PT09PT09PT09PT09PT09PT09PC9kaXY+DQo8ZGl2Pj09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PTwvZGl2Pg0KPGRpdj5HUFXCoCDCoFRlbXDCoCDCoEF2Z1B3csKg
IMKgU0NMS8KgIMKgIE1DTEvCoCDCoCBQQ0xLwqAgwqAgwqAgwqAgwqAgwqBGYW7CoCDCoCDCoFBl
cmbCoCDCoCBQd3JDYXDCoCDCoFNDTEsgT0TCoCDCoE1DTEsgT0TCoCBHUFUlPC9kaXY+DQo8ZGl2
PkdQVVswXSA8c3BhbiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlLXdyYXAiPjwvc3Bhbj46IFdBUk5J
Tkc6IEVtcHR5IFN5c0ZTIHZhbHVlOiBwY2xrPC9kaXY+DQo8ZGl2PkdQVVswXSA8c3BhbiBzdHls
ZT0id2hpdGUtc3BhY2U6cHJlLXdyYXAiPjwvc3Bhbj46IFdBUk5JTkc6IFVuYWJsZSB0byByZWFk
IC9zeXMvY2xhc3MvZHJtL2NhcmQwL2RldmljZS9ncHVfYnVzeV9wZXJjZW50PC9kaXY+DQo8ZGl2
PjDCoCDCoCDCoDM1LjBjwqAgTi9BwqAgwqAgwqAgNDAwTWh6wqAgMTIwME1oeiBOL0HCoCDCoCDC
oCDCoCDCoCDCoCAwJcKgIMKgIMKgIGF1dG/CoCDCoCBOL0HCoCDCoCDCoCAwJcKgIMKgIMKgIMKg
IDAlwqAgwqAgwqAgwqBOL0HCoCDCoCDCoMKgPC9kaXY+DQo8ZGl2Pj09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PTwvZGl2Pg0KPGRpdj49PT09PT09PT09PT09PT09PT09PT09
PT3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoEVuZCBvZiBST0NtIFNNSSBMb2fCoCDCoCDCoCDCoCDC
oCDCoCDCoCA9PT09PT09PT09PT09PT09PT09PT09PT08L2Rpdj4NCjxkaXY+PGJyPg0KPC9kaXY+
DQo8ZGl2PlNvIHRoZXJlIGlzIGEgZGlmZmVyZW5jZSBpbiBNQ0xLIC0gY2FuIHRoaXMgY2F1c2Ug
c3VjaCBhIGh1Z2Ugc2xvd2Rvd24/PC9kaXY+DQo8ZGl2Pjxicj4NCjwvZGl2Pg0KPGRpdj4tLTwv
ZGl2Pg0KPGRpdj5MYXVyacKgwqA8YnI+DQo8L2Rpdj4NCjwvZGl2Pg0KPC9kaXY+DQo8L2Rpdj4N
Cjxicj4NCjxkaXYgY2xhc3M9ImdtYWlsLW1fLTY3OTI4NTU0NzMwMjIzOTc4MnhfZ21haWxfcXVv
dGUiPg0KPGRpdiBkaXI9Imx0ciIgY2xhc3M9ImdtYWlsLW1fLTY3OTI4NTU0NzMwMjIzOTc4Mnhf
Z21haWxfYXR0ciI+T24gVHVlLCBNYXIgMTIsIDIwMTkgYXQgNjozOSBQTSBLdWVobGluZywgRmVs
aXggJmx0OzxhIGhyZWY9Im1haWx0bzpGZWxpeC5LdWVobGluZ0BhbWQuY29tIiB0YXJnZXQ9Il9i
bGFuayI+RmVsaXguS3VlaGxpbmdAYW1kLmNvbTwvYT4mZ3Q7IHdyb3RlOjxicj4NCjwvZGl2Pg0K
PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsLW1fLTY3OTI4NTU0NzMwMjIzOTc4MnhfZ21haWxfcXVv
dGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlk
IHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+DQpbYWRkaW5nIHRoZSBsaXN0IGJh
Y2tdPGJyPg0KPGJyPg0KSSYjMzk7ZCBzdXNwZWN0IGEgcHJvYmxlbSByZWxhdGVkIHRvIG1lbW9y
eSBjbG9jay4gVGhpcyBpcyBhbiBBUFUgd2hlcmUgPGJyPg0Kc3lzdGVtIG1lbW9yeSBpcyBzaGFy
ZWQgd2l0aCB0aGUgQ1BVLCBzbyBpZiB0aGUgU01VIGNoYW5nZXMgbWVtb3J5IDxicj4NCmNsb2Nr
cyB0aGF0IHdvdWxkIGFmZmVjdCBDUFUgbWVtb3J5IGFjY2VzcyBwZXJmb3JtYW5jZS4gSWYgdGhl
IHByb2JsZW0gPGJyPg0Kb25seSBvY2N1cnMgd2hlbiBPcGVuQ0wgaXMgcnVubmluZywgdGhlbiB0
aGUgY29tcHV0ZSBwb3dlciBwcm9maWxlIGNvdWxkIDxicj4NCmhhdmUgYW4gZWZmZWN0IGhlcmUu
PGJyPg0KPGJyPg0KTGF1cmllLCBjYW4geW91IG1vbml0b3IgdGhlIGNsb2NrcyBkdXJpbmcgeW91
ciB0ZXN0cyB1c2luZyByb2NtLXNtaT88YnI+DQo8YnI+DQpSZWdhcmRzLDxicj4NCsKgwqAgRmVs
aXg8YnI+DQo8YnI+DQpPbiAyMDE5LTAzLTExIDE6MTUgcC5tLiwgVG9tIFN0IERlbmlzIHdyb3Rl
Ojxicj4NCiZndDsgSGkgTGF1cmksPGJyPg0KJmd0Ozxicj4NCiZndDsgSSBkb24mIzM5O3QgaGF2
ZSBST0NtIGluc3RhbGxlZCBsb2NhbGx5IChub3Qgb24gdGhhdCB0ZWFtIGF0IEFNRCkgYnV0IEkg
PGJyPg0KJmd0OyBjYW4gcm9wZSBpbiBzb21lIG9mIHRoZSBLRkQgZm9sayBhbmQgc2VlIHdoYXQg
dGhleSBzYXkgOi0pLjxicj4NCiZndDs8YnI+DQomZ3Q7IChpbiB0aGUgbWVhbiB0aW1lIEkgc2hv
dWxkIGxvb2sgaW50byBpbnN0YWxsaW5nIHRoZSBST0NtIHN0YWNrIG9uIG15IDxicj4NCiZndDsg
VWJ1bnR1IGRpc2sgZm9yIGV4cGVyaW1lbnRhdGlvbi4uLikuPGJyPg0KJmd0Ozxicj4NCiZndDsg
T25seSBvdGhlciB0aGluZyB0aGF0IGNvbWVzIHRvIG1pbmQgaXMgc29tZSBzb3J0IG9mIHN0dXR0
ZXIgZHVlIHRvIDxicj4NCiZndDsgcG93ZXIvY2xvY2sgZ2F0aW5nIChvciBnZnggb2ZmL2V0Yyku
wqAgQnV0IHRoYXQgdHlwaWNhbGx5IGFmZmVjdHMgdGhlIDxicj4NCiZndDsgZGlzcGxheS9ncHUg
c2lkZSBub3QgdGhlIENQVSBzaWRlLjxicj4NCiZndDs8YnI+DQomZ3Q7IEZlbGl4OsKgIEFueSBr
bm93biBpc3N1ZXMgd2l0aCBSYXZlbiBhbmQgUk9DbSBpbnRlcmFjdGluZyBvdmVyIG1lbW9yeSA8
YnI+DQomZ3Q7IGJ1cyBwZXJmb3JtYW5jZT88YnI+DQomZ3Q7PGJyPg0KJmd0OyBUb208YnI+DQom
Z3Q7PGJyPg0KJmd0OyBPbiBNb24sIE1hciAxMSwgMjAxOSBhdCAxMjo1NiBQTSBMYXVyaSBFaHJl
bnByZWlzICZsdDs8YSBocmVmPSJtYWlsdG86bGF1cmlvbWFAZ21haWwuY29tIiB0YXJnZXQ9Il9i
bGFuayI+bGF1cmlvbWFAZ21haWwuY29tPC9hPg0KPGJyPg0KJmd0OyAmbHQ7bWFpbHRvOjxhIGhy
ZWY9Im1haWx0bzpsYXVyaW9tYUBnbWFpbC5jb20iIHRhcmdldD0iX2JsYW5rIj5sYXVyaW9tYUBn
bWFpbC5jb208L2E+Jmd0OyZndDsgd3JvdGU6PGJyPg0KJmd0Ozxicj4NCiZndDvCoCDCoCDCoEhp
ITxicj4NCiZndDs8YnI+DQomZ3Q7wqAgwqAgwqBUaGUgMTAweCBtZW1vcnkgc2xvd2Rvd24gaXMg
aGFyZCB0byBiZWxpdmUgaW5kZWVkLiBJIGF0dGFjaGVkIHRoZTxicj4NCiZndDvCoCDCoCDCoHRl
c3QgcHJvZ3JhbSB3aXRoIG15IGZpcnN0IGUtbWFpbCB3aGljaCBkZXBlbmRzIG9ubHkgb248YnI+
DQomZ3Q7wqAgwqAgwqByb2NtLW9wZW5jbC1kZXYgcGFja2FnZS4gV291bGQgeW91IG1pbmQgY29t
cGlsaW5nIGl0IGFuZCBjaGVja2luZzxicj4NCiZndDvCoCDCoCDCoGlmIGl0IHNsb3dzIGRvd24g
bWVtb3J5IGZvciB5b3UgYXMgd2VsbD88YnI+DQomZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgc3RlcHM6
PGJyPg0KJmd0O8KgIMKgIMKgMSkgZysrIGNsX3Nsb3dfdGVzdC5jcHAgLW8gY2xfc2xvd190ZXN0
IC1JPGJyPg0KJmd0O8KgIMKgIMKgL29wdC9yb2NtL29wZW5jbC9pbmNsdWRlLyAtTCAvb3B0L3Jv
Y20vb3BlbmNsL2xpYi94ODZfNjQvwqAgLWxPcGVuQ0w8YnI+DQomZ3Q7wqAgwqAgwqAyKSBsb2dv
dXQgZnJvbSBkZXNrdG9wIGVudiBhbmQgZGlzY29ubmVjdCBoZG1pL2RpcGxheXBvcnQgZXRjPGJy
Pg0KJmd0O8KgIMKgIMKgMykgbG9nIGluIG92ZXIgc3NoPGJyPg0KJmd0O8KgIMKgIMKgNCkgcnVu
IHRoZSBwcm9ncmFtIC4vY2xfc2xvd190ZXN0IDE8YnI+DQomZ3Q7PGJyPg0KJmd0O8KgIMKgIMKg
Rm9yIG1lIGl0IHJlcHJvZHVjZWQgZXZlbiB3aXRob3V0IHN0ZXAgMiBhcyB3ZWxsIGJ1dCBsZXNz
PGJyPg0KJmd0O8KgIMKgIMKgcmVsaWFibHkuIG1vdmluZyBtb3VzZSBmb3IgZXhhbXBsZSBjb3Vs
ZCBtYWtlIHRoZSBtZW1vcnkgc3BlZWQ8YnI+DQomZ3Q7wqAgwqAgwqBmYXN0IGFnYWluLjxicj4N
CiZndDs8YnI+DQomZ3Q7wqAgwqAgwqAtLTxicj4NCiZndDvCoCDCoCDCoExhdXJpPGJyPg0KJmd0
Ozxicj4NCiZndDs8YnI+DQomZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgT24gTW9uLCBNYXIgMTEsIDIw
MTkgYXQgNjozMyBQTSBUb20gU3QgRGVuaXMgJmx0OzxhIGhyZWY9Im1haWx0bzp0c3RkZW5pczgy
QGdtYWlsLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPnRzdGRlbmlzODJAZ21haWwuY29tPC9hPjxicj4N
CiZndDvCoCDCoCDCoCZsdDttYWlsdG86PGEgaHJlZj0ibWFpbHRvOnRzdGRlbmlzODJAZ21haWwu
Y29tIiB0YXJnZXQ9Il9ibGFuayI+dHN0ZGVuaXM4MkBnbWFpbC5jb208L2E+Jmd0OyZndDsgd3Jv
dGU6PGJyPg0KJmd0Ozxicj4NCiZndDvCoCDCoCDCoCDCoCDCoEhpIExhdXJpLDxicj4NCiZndDs8
YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqBUaGVyZSYjMzk7cyByZWFsbHkgbm8gY29ubmVjdGlvbiBi
ZXR3ZWVuIHRoZSB0d28gb3RoZXIgdGhhbiB0aGV5PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgcnVu
IGluIHRoZSBzYW1lIHBhY2thZ2UuwqAgSSB0b28gcnVuIGEgMjQwMEcgKGFzIG15PGJyPg0KJmd0
O8KgIMKgIMKgIMKgIMKgd29ya3N0YXRpb24pIGFuZCBJIGdvdCB0aGUgc2FtZSB+Ni42R0Ivc2Vj
IHRyYW5zZmVyIHJhdGUgYnV0PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgd2l0aG91dCBhIENMIGFw
cCBydW5uaW5nIC4uLsKgIFRoZSBvbmx5IGxvZ2ljYWwgcmVhc29uIGlzIHlvdXI8YnI+DQomZ3Q7
wqAgwqAgwqAgwqAgwqBDTCBhcHAgaXMgYm90dGxlbmVja2luZyB0aGUgQVBVcyBtZW1vcnkgYnVz
IGJ1dCB5b3UgY2xhaW08YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAmcXVvdDtzaW1wbHkgb3Blbmlu
ZyBhIGNvbnRleHQgaXMgZW5vdWdoJnF1b3Q7IHNvIHNvbWV0aGluZyBlbHNlIGlzPGJyPg0KJmd0
O8KgIMKgIMKgIMKgIMKgZ29pbmcgb24uPGJyPg0KJmd0Ozxicj4NCiZndDvCoCDCoCDCoCDCoCDC
oFlvdXIgbGFzdCByZXBseSB0aG91Z2ggc2F5cyAmcXVvdDt3aXRoIGl0IHJ1bm5pbmcgaW4gdGhl
PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgYmFja2dyb3VuZCZxdW90OyBzbyBpdCYjMzk7cyBlbnRp
cmVseSBwb3NzaWJsZSB0aGUgQ1BVIGlzbiYjMzk7dCBidXN5IGJ1dDxicj4NCiZndDvCoCDCoCDC
oCDCoCDCoHRoZSBwYWNrYWdlIG1lbW9yeSBjb250cm9sbGVyIChzaGFyZWQgYmV0d2VlbiBib3Ro
IHRoZSBDUFUgYW5kPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgR1BVKSBpcyBidXN5LsKgIEZvciBp
bnN0YW5jZSBydW5uaW5nIHhvbm90aWMgaW4gYSAxMDgwcCB3aW5kb3c8YnI+DQomZ3Q7wqAgwqAg
wqAgwqAgwqBvbiBteSA0SyBkaXNwbGF5IHJlZHVjZWQgdGhlIG1lbW9yeSB0ZXN0IHRvIDUuOEdC
L3NlYyBhbmQ8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqB0aGF0JiMzOTtzIGhhcmRseSBhIGhlYXZ5
IG1lbW9yeSBib3VuZCBHUFUgYXBwLjxicj4NCiZndDs8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqBU
aGUgb25seSBvdGhlciBwb3NzaWJsZSBjb25uZWN0aW9uIGlzIHRoZSBHUFUgaXMgZ2VuZXJhdGlu
ZyBzbzxicj4NCiZndDvCoCDCoCDCoCDCoCDCoG11Y2ggaGVhdCB0aGF0IGl0JiMzOTtzIHRocm90
dGxpbmcgdGhlIHBhY2thZ2Ugd2hpY2ggaXMgYWxzbzxicj4NCiZndDvCoCDCoCDCoCDCoCDCoHVu
bGlrZWx5IGlmIHlvdSBoYXZlIGEgcHJvcGVyIEhTRiBhdHRhY2hlZCAoSSB1c2UgdGhlIG9uZXM8
YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqB0aGF0IGNhbWUgaW4gdGhlIHJldGFpbCBib3hlcykuPGJy
Pg0KJmd0Ozxicj4NCiZndDvCoCDCoCDCoCDCoCDCoENoZWVycyw8YnI+DQomZ3Q7wqAgwqAgwqAg
wqAgwqBUb208YnI+DQomZ3Q7PGJyPg0KPC9ibG9ja3F1b3RlPg0KPC9kaXY+DQo8L2Jsb2NrcXVv
dGU+DQo8L2Rpdj4NCjwvZGl2Pg0KPC9kaXY+DQoNCjwvYmxvY2txdW90ZT48L2Rpdj4NCg==
--0000000000000f3c040583f81b79--

--===============1559643700==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1559643700==--
