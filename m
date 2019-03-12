From: Lauri Ehrenpreis <laurioma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Slow memory access when using OpenCL without X11
Date: Tue, 12 Mar 2019 23:31:03 +0200
Message-ID: <CAGyaPbD3K3pawBS+kBOs_QSm3kB16MFRYZa98FcqHAEX_FanVg@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1440907774=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAGyaPbA_z0bKC1W8gTdnx4Ot5G-45pC7029pKWrAM0Pj_BU6uw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
Cc: Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1440907774==
Content-Type: multipart/alternative; boundary="0000000000009caa9b0583ec68e2"

--0000000000009caa9b0583ec68e2
Content-Type: text/plain; charset="UTF-8"

However it's not only related to mclk and sclk. I tried this:
rocm-smi  --setsclk 2
rocm-smi  --setmclk 3
rocm-smi
========================        ROCm System Management Interface
========================
================================================================================================
GPU   Temp   AvgPwr   SCLK    MCLK    PCLK           Fan     Perf
PwrCap   SCLK OD   MCLK OD  GPU%
GPU[0] : WARNING: Empty SysFS value: pclk
GPU[0] : WARNING: Unable to read
/sys/class/drm/card0/device/gpu_busy_percent
0     34.0c  N/A      1240Mhz 1333Mhz N/A            0%      manual  N/A
  0%        0%       N/A
================================================================================================
========================               End of ROCm SMI Log
========================

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


On Tue, Mar 12, 2019 at 11:21 PM Lauri Ehrenpreis <laurioma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
wrote:

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
>> [adding the list back]
>>
>> I'd suspect a problem related to memory clock. This is an APU where
>> system memory is shared with the CPU, so if the SMU changes memory
>> clocks that would affect CPU memory access performance. If the problem
>> only occurs when OpenCL is running, then the compute power profile could
>> have an effect here.
>>
>> Laurie, can you monitor the clocks during your tests using rocm-smi?
>>
>> Regards,
>>    Felix
>>
>> On 2019-03-11 1:15 p.m., Tom St Denis wrote:
>> > Hi Lauri,
>> >
>> > I don't have ROCm installed locally (not on that team at AMD) but I
>> > can rope in some of the KFD folk and see what they say :-).
>> >
>> > (in the mean time I should look into installing the ROCm stack on my
>> > Ubuntu disk for experimentation...).
>> >
>> > Only other thing that comes to mind is some sort of stutter due to
>> > power/clock gating (or gfx off/etc).  But that typically affects the
>> > display/gpu side not the CPU side.
>> >
>> > Felix:  Any known issues with Raven and ROCm interacting over memory
>> > bus performance?
>> >
>> > Tom
>> >
>> > On Mon, Mar 11, 2019 at 12:56 PM Lauri Ehrenpreis <laurioma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
>> > <mailto:laurioma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>> wrote:
>> >
>> >     Hi!
>> >
>> >     The 100x memory slowdown is hard to belive indeed. I attached the
>> >     test program with my first e-mail which depends only on
>> >     rocm-opencl-dev package. Would you mind compiling it and checking
>> >     if it slows down memory for you as well?
>> >
>> >     steps:
>> >     1) g++ cl_slow_test.cpp -o cl_slow_test -I
>> >     /opt/rocm/opencl/include/ -L /opt/rocm/opencl/lib/x86_64/  -lOpenCL
>> >     2) logout from desktop env and disconnect hdmi/diplayport etc
>> >     3) log in over ssh
>> >     4) run the program ./cl_slow_test 1
>> >
>> >     For me it reproduced even without step 2 as well but less
>> >     reliably. moving mouse for example could make the memory speed
>> >     fast again.
>> >
>> >     --
>> >     Lauri
>> >
>> >
>> >
>> >     On Mon, Mar 11, 2019 at 6:33 PM Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
>> >     <mailto:tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>> wrote:
>> >
>> >         Hi Lauri,
>> >
>> >         There's really no connection between the two other than they
>> >         run in the same package.  I too run a 2400G (as my
>> >         workstation) and I got the same ~6.6GB/sec transfer rate but
>> >         without a CL app running ...  The only logical reason is your
>> >         CL app is bottlenecking the APUs memory bus but you claim
>> >         "simply opening a context is enough" so something else is
>> >         going on.
>> >
>> >         Your last reply though says "with it running in the
>> >         background" so it's entirely possible the CPU isn't busy but
>> >         the package memory controller (shared between both the CPU and
>> >         GPU) is busy.  For instance running xonotic in a 1080p window
>> >         on my 4K display reduced the memory test to 5.8GB/sec and
>> >         that's hardly a heavy memory bound GPU app.
>> >
>> >         The only other possible connection is the GPU is generating so
>> >         much heat that it's throttling the package which is also
>> >         unlikely if you have a proper HSF attached (I use the ones
>> >         that came in the retail boxes).
>> >
>> >         Cheers,
>> >         Tom
>> >
>>
>

--0000000000009caa9b0583ec68e2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0
ciI+SG93ZXZlciBpdCYjMzk7cyBub3Qgb25seSByZWxhdGVkIHRvIG1jbGsgYW5kIHNjbGsuIEkg
dHJpZWQgdGhpczo8ZGl2PjxkaXY+cm9jbS1zbWnCoCAtLXNldHNjbGsgMjxicj48L2Rpdj48ZGl2
PnJvY20tc21pwqAgLS1zZXRtY2xrIDM8YnI+PC9kaXY+cm9jbS1zbWk8L2Rpdj48ZGl2PjxkaXY+
PT09PT09PT09PT09PT09PT09PT09PT09wqAgwqAgwqAgwqAgUk9DbSBTeXN0ZW0gTWFuYWdlbWVu
dCBJbnRlcmZhY2XCoCDCoCDCoCDCoCA9PT09PT09PT09PT09PT09PT09PT09PT08L2Rpdj48ZGl2
Pj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PTwvZGl2PjxkaXY+R1BVwqAg
wqBUZW1wwqAgwqBBdmdQd3LCoCDCoFNDTEvCoCDCoCBNQ0xLwqAgwqAgUENMS8KgIMKgIMKgIMKg
IMKgIMKgRmFuwqAgwqAgwqBQZXJmwqAgwqAgUHdyQ2FwwqAgwqBTQ0xLIE9EwqAgwqBNQ0xLIE9E
wqAgR1BVJTwvZGl2PjxkaXY+R1BVWzBdIDxzcGFuIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgkJ
PC9zcGFuPjogV0FSTklORzogRW1wdHkgU3lzRlMgdmFsdWU6IHBjbGs8L2Rpdj48ZGl2PkdQVVsw
XSA8c3BhbiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JCTwvc3Bhbj46IFdBUk5JTkc6IFVuYWJs
ZSB0byByZWFkIC9zeXMvY2xhc3MvZHJtL2NhcmQwL2RldmljZS9ncHVfYnVzeV9wZXJjZW50PC9k
aXY+PGRpdj4wwqAgwqAgwqAzNC4wY8KgIE4vQcKgIMKgIMKgIDEyNDBNaHogMTMzM01oeiBOL0HC
oCDCoCDCoCDCoCDCoCDCoCAwJcKgIMKgIMKgIG1hbnVhbMKgIE4vQcKgIMKgIMKgIDAlwqAgwqAg
wqAgwqAgMCXCoCDCoCDCoCDCoE4vQcKgIMKgIMKgwqA8L2Rpdj48ZGl2Pj09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PTwvZGl2PjxkaXY+PT09PT09PT09PT09PT09PT09PT09
PT09wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBFbmQgb2YgUk9DbSBTTUkgTG9nwqAgwqAgwqAgwqAg
wqAgwqAgwqAgPT09PT09PT09PT09PT09PT09PT09PT09PC9kaXY+PC9kaXY+PGRpdj48YnI+PC9k
aXY+PGRpdj48ZGl2Pi4vY2xfc2xvd190ZXN0IDE8L2Rpdj48ZGl2PmdvdCAxIHBsYXRmb3JtcyAx
IGRldmljZXM8L2Rpdj48ZGl2PnNwZWVkIDM5MTkuNzc3MTAwIGF2ZyAzOTE5Ljc3NzEwMCBtYnl0
ZXMvczwvZGl2PjxkaXY+c3BlZWQgMzgwOS4zNzMyOTEgYXZnIDM4NjQuNTc1MTk1IG1ieXRlcy9z
PC9kaXY+PGRpdj5zcGVlZCA1ODUuNzk2ODE0IGF2ZyAyNzcxLjY0OTE3MCBtYnl0ZXMvczwvZGl2
PjxkaXY+c3BlZWQgMTg4LjcyMTg0OCBhdmcgMjEyNS45MTcyMzYgbWJ5dGVzL3M8L2Rpdj48ZGl2
PnNwZWVkIDE4OC45MTYzNjcgYXZnIDE3MzguNTE3MDkwIG1ieXRlcy9zPC9kaXY+PGRpdj48YnI+
PC9kaXY+PC9kaXY+PGRpdj5TbyBkZXNwaXRlIGZvcmNpbmcgbWF4IHNjbGsgYW5kIG1jbGsgdGhl
IG1lbW9yeSBzcGVlZCBpcyBzdGlsbCBzbG93Li48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pi0t
PC9kaXY+PGRpdj5MYXVyaTwvZGl2PjxkaXY+PGJyPjwvZGl2PjwvZGl2PjwvZGl2PjwvZGl2Pjwv
ZGl2Pjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGRpdiBkaXI9Imx0ciIgY2xhc3M9Imdt
YWlsX2F0dHIiPk9uIFR1ZSwgTWFyIDEyLCAyMDE5IGF0IDExOjIxIFBNIExhdXJpIEVocmVucHJl
aXMgJmx0OzxhIGhyZWY9Im1haWx0bzpsYXVyaW9tYUBnbWFpbC5jb20iPmxhdXJpb21hQGdtYWls
LmNvbTwvYT4mZ3Q7IHdyb3RlOjxicj48L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVv
dGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlk
IHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+PGRpdiBkaXI9Imx0ciI+PGRpdiBk
aXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+SU4gdGhlIGNhc2Ugd2hlbiBtZW1vcnkgaXMgc2xvdywg
dGhlIHJvY20tc21pIG91dHB1dHMgdGhpczo8ZGl2Pj09PT09PT09PT09PT09PT09PT09PT09PcKg
IMKgIMKgIMKgIFJPQ20gU3lzdGVtIE1hbmFnZW1lbnQgSW50ZXJmYWNlwqAgwqAgwqAgwqAgPT09
PT09PT09PT09PT09PT09PT09PT09PC9kaXY+PGRpdj49PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT08L2Rpdj48ZGl2PkdQVcKgIMKgVGVtcMKgIMKgQXZnUHdywqAgwqBTQ0xL
wqAgwqAgTUNMS8KgIMKgIFBDTEvCoCDCoCDCoCDCoCDCoCDCoEZhbsKgIMKgIMKgUGVyZsKgIMKg
IFB3ckNhcMKgIMKgU0NMSyBPRMKgIMKgTUNMSyBPRMKgIEdQVSU8L2Rpdj48ZGl2PkdQVVswXSA8
c3BhbiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlLXdyYXAiPgkJPC9zcGFuPjogV0FSTklORzogRW1w
dHkgU3lzRlMgdmFsdWU6IHBjbGs8L2Rpdj48ZGl2PkdQVVswXSA8c3BhbiBzdHlsZT0id2hpdGUt
c3BhY2U6cHJlLXdyYXAiPgkJPC9zcGFuPjogV0FSTklORzogVW5hYmxlIHRvIHJlYWQgL3N5cy9j
bGFzcy9kcm0vY2FyZDAvZGV2aWNlL2dwdV9idXN5X3BlcmNlbnQ8L2Rpdj48ZGl2PjDCoCDCoCDC
oDMwLjBjwqAgTi9BwqAgwqAgwqAgNDAwTWh6wqAgOTMzTWh6wqAgTi9BwqAgwqAgwqAgwqAgwqAg
wqAgMCXCoCDCoCDCoCBhdXRvwqAgwqAgTi9BwqAgwqAgwqAgMCXCoCDCoCDCoCDCoCAwJcKgIMKg
IMKgIMKgTi9BwqAgwqAgwqDCoDwvZGl2PjxkaXY+PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PC9kaXY+PGRpdj49PT09PT09PT09PT09PT09PT09PT09PT3CoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoEVuZCBvZiBST0NtIFNNSSBMb2fCoCDCoCDCoCDCoCDCoCDCoCDCoCA9PT09
PT09PT09PT09PT09PT09PT09PT08L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pm5vcm1hbCBtZW1v
cnkgc3BlZWQgY2FzZSBnaXZlcyBmb2xsb3dpbmc6PC9kaXY+PGRpdj49PT09PT09PT09PT09PT09
PT09PT09PT3CoCDCoCDCoCDCoCBST0NtIFN5c3RlbSBNYW5hZ2VtZW50IEludGVyZmFjZcKgIMKg
IMKgIMKgID09PT09PT09PT09PT09PT09PT09PT09PTwvZGl2PjxkaXY+PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PC9kaXY+PGRpdj5HUFXCoCDCoFRlbXDCoCDCoEF2Z1B3
csKgIMKgU0NMS8KgIMKgIE1DTEvCoCDCoCBQQ0xLwqAgwqAgwqAgwqAgwqAgwqBGYW7CoCDCoCDC
oFBlcmbCoCDCoCBQd3JDYXDCoCDCoFNDTEsgT0TCoCDCoE1DTEsgT0TCoCBHUFUlPC9kaXY+PGRp
dj5HUFVbMF0gPHNwYW4gc3R5bGU9IndoaXRlLXNwYWNlOnByZS13cmFwIj4JCTwvc3Bhbj46IFdB
Uk5JTkc6IEVtcHR5IFN5c0ZTIHZhbHVlOiBwY2xrPC9kaXY+PGRpdj5HUFVbMF0gPHNwYW4gc3R5
bGU9IndoaXRlLXNwYWNlOnByZS13cmFwIj4JCTwvc3Bhbj46IFdBUk5JTkc6IFVuYWJsZSB0byBy
ZWFkIC9zeXMvY2xhc3MvZHJtL2NhcmQwL2RldmljZS9ncHVfYnVzeV9wZXJjZW50PC9kaXY+PGRp
dj4wwqAgwqAgwqAzNS4wY8KgIE4vQcKgIMKgIMKgIDQwME1oesKgIDEyMDBNaHogTi9BwqAgwqAg
wqAgwqAgwqAgwqAgMCXCoCDCoCDCoCBhdXRvwqAgwqAgTi9BwqAgwqAgwqAgMCXCoCDCoCDCoCDC
oCAwJcKgIMKgIMKgIMKgTi9BwqAgwqAgwqDCoDwvZGl2PjxkaXY+PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PC9kaXY+PGRpdj49PT09PT09PT09PT09PT09PT09PT09PT3C
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoEVuZCBvZiBST0NtIFNNSSBMb2fCoCDCoCDCoCDCoCDCoCDC
oCDCoCA9PT09PT09PT09PT09PT09PT09PT09PT08L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PlNv
IHRoZXJlIGlzIGEgZGlmZmVyZW5jZSBpbiBNQ0xLIC0gY2FuIHRoaXMgY2F1c2Ugc3VjaCBhIGh1
Z2Ugc2xvd2Rvd24/PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj4tLTwvZGl2PjxkaXY+TGF1cmnC
oMKgPGJyPjwvZGl2PjwvZGl2PjwvZGl2PjwvZGl2Pjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90
ZSI+PGRpdiBkaXI9Imx0ciIgY2xhc3M9ImdtYWlsX2F0dHIiPk9uIFR1ZSwgTWFyIDEyLCAyMDE5
IGF0IDY6MzkgUE0gS3VlaGxpbmcsIEZlbGl4ICZsdDs8YSBocmVmPSJtYWlsdG86RmVsaXguS3Vl
aGxpbmdAYW1kLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPkZlbGl4Lkt1ZWhsaW5nQGFtZC5jb208L2E+
Jmd0OyB3cm90ZTo8YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHls
ZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0
LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPlthZGRpbmcgdGhlIGxpc3QgYmFja108YnI+DQo8
YnI+DQpJJiMzOTtkIHN1c3BlY3QgYSBwcm9ibGVtIHJlbGF0ZWQgdG8gbWVtb3J5IGNsb2NrLiBU
aGlzIGlzIGFuIEFQVSB3aGVyZSA8YnI+DQpzeXN0ZW0gbWVtb3J5IGlzIHNoYXJlZCB3aXRoIHRo
ZSBDUFUsIHNvIGlmIHRoZSBTTVUgY2hhbmdlcyBtZW1vcnkgPGJyPg0KY2xvY2tzIHRoYXQgd291
bGQgYWZmZWN0IENQVSBtZW1vcnkgYWNjZXNzIHBlcmZvcm1hbmNlLiBJZiB0aGUgcHJvYmxlbSA8
YnI+DQpvbmx5IG9jY3VycyB3aGVuIE9wZW5DTCBpcyBydW5uaW5nLCB0aGVuIHRoZSBjb21wdXRl
IHBvd2VyIHByb2ZpbGUgY291bGQgPGJyPg0KaGF2ZSBhbiBlZmZlY3QgaGVyZS48YnI+DQo8YnI+
DQpMYXVyaWUsIGNhbiB5b3UgbW9uaXRvciB0aGUgY2xvY2tzIGR1cmluZyB5b3VyIHRlc3RzIHVz
aW5nIHJvY20tc21pPzxicj4NCjxicj4NClJlZ2FyZHMsPGJyPg0KwqDCoCBGZWxpeDxicj4NCjxi
cj4NCk9uIDIwMTktMDMtMTEgMToxNSBwLm0uLCBUb20gU3QgRGVuaXMgd3JvdGU6PGJyPg0KJmd0
OyBIaSBMYXVyaSw8YnI+DQomZ3Q7PGJyPg0KJmd0OyBJIGRvbiYjMzk7dCBoYXZlIFJPQ20gaW5z
dGFsbGVkIGxvY2FsbHkgKG5vdCBvbiB0aGF0IHRlYW0gYXQgQU1EKSBidXQgSSA8YnI+DQomZ3Q7
IGNhbiByb3BlIGluIHNvbWUgb2YgdGhlIEtGRCBmb2xrIGFuZCBzZWUgd2hhdCB0aGV5IHNheSA6
LSkuPGJyPg0KJmd0Ozxicj4NCiZndDsgKGluIHRoZSBtZWFuIHRpbWUgSSBzaG91bGQgbG9vayBp
bnRvIGluc3RhbGxpbmcgdGhlIFJPQ20gc3RhY2sgb24gbXkgPGJyPg0KJmd0OyBVYnVudHUgZGlz
ayBmb3IgZXhwZXJpbWVudGF0aW9uLi4uKS48YnI+DQomZ3Q7PGJyPg0KJmd0OyBPbmx5IG90aGVy
IHRoaW5nIHRoYXQgY29tZXMgdG8gbWluZCBpcyBzb21lIHNvcnQgb2Ygc3R1dHRlciBkdWUgdG8g
PGJyPg0KJmd0OyBwb3dlci9jbG9jayBnYXRpbmcgKG9yIGdmeCBvZmYvZXRjKS7CoCBCdXQgdGhh
dCB0eXBpY2FsbHkgYWZmZWN0cyB0aGUgPGJyPg0KJmd0OyBkaXNwbGF5L2dwdSBzaWRlIG5vdCB0
aGUgQ1BVIHNpZGUuPGJyPg0KJmd0Ozxicj4NCiZndDsgRmVsaXg6wqAgQW55IGtub3duIGlzc3Vl
cyB3aXRoIFJhdmVuIGFuZCBST0NtIGludGVyYWN0aW5nIG92ZXIgbWVtb3J5IDxicj4NCiZndDsg
YnVzIHBlcmZvcm1hbmNlPzxicj4NCiZndDs8YnI+DQomZ3Q7IFRvbTxicj4NCiZndDs8YnI+DQom
Z3Q7IE9uIE1vbiwgTWFyIDExLCAyMDE5IGF0IDEyOjU2IFBNIExhdXJpIEVocmVucHJlaXMgJmx0
OzxhIGhyZWY9Im1haWx0bzpsYXVyaW9tYUBnbWFpbC5jb20iIHRhcmdldD0iX2JsYW5rIj5sYXVy
aW9tYUBnbWFpbC5jb208L2E+IDxicj4NCiZndDsgJmx0O21haWx0bzo8YSBocmVmPSJtYWlsdG86
bGF1cmlvbWFAZ21haWwuY29tIiB0YXJnZXQ9Il9ibGFuayI+bGF1cmlvbWFAZ21haWwuY29tPC9h
PiZndDsmZ3Q7IHdyb3RlOjxicj4NCiZndDs8YnI+DQomZ3Q7wqAgwqAgwqBIaSE8YnI+DQomZ3Q7
PGJyPg0KJmd0O8KgIMKgIMKgVGhlIDEwMHggbWVtb3J5IHNsb3dkb3duIGlzIGhhcmQgdG8gYmVs
aXZlIGluZGVlZC4gSSBhdHRhY2hlZCB0aGU8YnI+DQomZ3Q7wqAgwqAgwqB0ZXN0IHByb2dyYW0g
d2l0aCBteSBmaXJzdCBlLW1haWwgd2hpY2ggZGVwZW5kcyBvbmx5IG9uPGJyPg0KJmd0O8KgIMKg
IMKgcm9jbS1vcGVuY2wtZGV2IHBhY2thZ2UuIFdvdWxkIHlvdSBtaW5kIGNvbXBpbGluZyBpdCBh
bmQgY2hlY2tpbmc8YnI+DQomZ3Q7wqAgwqAgwqBpZiBpdCBzbG93cyBkb3duIG1lbW9yeSBmb3Ig
eW91IGFzIHdlbGw/PGJyPg0KJmd0Ozxicj4NCiZndDvCoCDCoCDCoHN0ZXBzOjxicj4NCiZndDvC
oCDCoCDCoDEpIGcrKyBjbF9zbG93X3Rlc3QuY3BwIC1vIGNsX3Nsb3dfdGVzdCAtSTxicj4NCiZn
dDvCoCDCoCDCoC9vcHQvcm9jbS9vcGVuY2wvaW5jbHVkZS8gLUwgL29wdC9yb2NtL29wZW5jbC9s
aWIveDg2XzY0L8KgIC1sT3BlbkNMPGJyPg0KJmd0O8KgIMKgIMKgMikgbG9nb3V0IGZyb20gZGVz
a3RvcCBlbnYgYW5kIGRpc2Nvbm5lY3QgaGRtaS9kaXBsYXlwb3J0IGV0Yzxicj4NCiZndDvCoCDC
oCDCoDMpIGxvZyBpbiBvdmVyIHNzaDxicj4NCiZndDvCoCDCoCDCoDQpIHJ1biB0aGUgcHJvZ3Jh
bSAuL2NsX3Nsb3dfdGVzdCAxPGJyPg0KJmd0Ozxicj4NCiZndDvCoCDCoCDCoEZvciBtZSBpdCBy
ZXByb2R1Y2VkIGV2ZW4gd2l0aG91dCBzdGVwIDIgYXMgd2VsbCBidXQgbGVzczxicj4NCiZndDvC
oCDCoCDCoHJlbGlhYmx5LiBtb3ZpbmcgbW91c2UgZm9yIGV4YW1wbGUgY291bGQgbWFrZSB0aGUg
bWVtb3J5IHNwZWVkPGJyPg0KJmd0O8KgIMKgIMKgZmFzdCBhZ2Fpbi48YnI+DQomZ3Q7PGJyPg0K
Jmd0O8KgIMKgIMKgLS08YnI+DQomZ3Q7wqAgwqAgwqBMYXVyaTxicj4NCiZndDs8YnI+DQomZ3Q7
PGJyPg0KJmd0Ozxicj4NCiZndDvCoCDCoCDCoE9uIE1vbiwgTWFyIDExLCAyMDE5IGF0IDY6MzMg
UE0gVG9tIFN0IERlbmlzICZsdDs8YSBocmVmPSJtYWlsdG86dHN0ZGVuaXM4MkBnbWFpbC5jb20i
IHRhcmdldD0iX2JsYW5rIj50c3RkZW5pczgyQGdtYWlsLmNvbTwvYT48YnI+DQomZ3Q7wqAgwqAg
wqAmbHQ7bWFpbHRvOjxhIGhyZWY9Im1haWx0bzp0c3RkZW5pczgyQGdtYWlsLmNvbSIgdGFyZ2V0
PSJfYmxhbmsiPnRzdGRlbmlzODJAZ21haWwuY29tPC9hPiZndDsmZ3Q7IHdyb3RlOjxicj4NCiZn
dDs8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqBIaSBMYXVyaSw8YnI+DQomZ3Q7PGJyPg0KJmd0O8Kg
IMKgIMKgIMKgIMKgVGhlcmUmIzM5O3MgcmVhbGx5IG5vIGNvbm5lY3Rpb24gYmV0d2VlbiB0aGUg
dHdvIG90aGVyIHRoYW4gdGhleTxicj4NCiZndDvCoCDCoCDCoCDCoCDCoHJ1biBpbiB0aGUgc2Ft
ZSBwYWNrYWdlLsKgIEkgdG9vIHJ1biBhIDI0MDBHIChhcyBteTxicj4NCiZndDvCoCDCoCDCoCDC
oCDCoHdvcmtzdGF0aW9uKSBhbmQgSSBnb3QgdGhlIHNhbWUgfjYuNkdCL3NlYyB0cmFuc2ZlciBy
YXRlIGJ1dDxicj4NCiZndDvCoCDCoCDCoCDCoCDCoHdpdGhvdXQgYSBDTCBhcHAgcnVubmluZyAu
Li7CoCBUaGUgb25seSBsb2dpY2FsIHJlYXNvbiBpcyB5b3VyPGJyPg0KJmd0O8KgIMKgIMKgIMKg
IMKgQ0wgYXBwIGlzIGJvdHRsZW5lY2tpbmcgdGhlIEFQVXMgbWVtb3J5IGJ1cyBidXQgeW91IGNs
YWltPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgJnF1b3Q7c2ltcGx5IG9wZW5pbmcgYSBjb250ZXh0
IGlzIGVub3VnaCZxdW90OyBzbyBzb21ldGhpbmcgZWxzZSBpczxicj4NCiZndDvCoCDCoCDCoCDC
oCDCoGdvaW5nIG9uLjxicj4NCiZndDs8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqBZb3VyIGxhc3Qg
cmVwbHkgdGhvdWdoIHNheXMgJnF1b3Q7d2l0aCBpdCBydW5uaW5nIGluIHRoZTxicj4NCiZndDvC
oCDCoCDCoCDCoCDCoGJhY2tncm91bmQmcXVvdDsgc28gaXQmIzM5O3MgZW50aXJlbHkgcG9zc2li
bGUgdGhlIENQVSBpc24mIzM5O3QgYnVzeSBidXQ8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqB0aGUg
cGFja2FnZSBtZW1vcnkgY29udHJvbGxlciAoc2hhcmVkIGJldHdlZW4gYm90aCB0aGUgQ1BVIGFu
ZDxicj4NCiZndDvCoCDCoCDCoCDCoCDCoEdQVSkgaXMgYnVzeS7CoCBGb3IgaW5zdGFuY2UgcnVu
bmluZyB4b25vdGljIGluIGEgMTA4MHAgd2luZG93PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgb24g
bXkgNEsgZGlzcGxheSByZWR1Y2VkIHRoZSBtZW1vcnkgdGVzdCB0byA1LjhHQi9zZWMgYW5kPGJy
Pg0KJmd0O8KgIMKgIMKgIMKgIMKgdGhhdCYjMzk7cyBoYXJkbHkgYSBoZWF2eSBtZW1vcnkgYm91
bmQgR1BVIGFwcC48YnI+DQomZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgVGhlIG9ubHkgb3Ro
ZXIgcG9zc2libGUgY29ubmVjdGlvbiBpcyB0aGUgR1BVIGlzIGdlbmVyYXRpbmcgc288YnI+DQom
Z3Q7wqAgwqAgwqAgwqAgwqBtdWNoIGhlYXQgdGhhdCBpdCYjMzk7cyB0aHJvdHRsaW5nIHRoZSBw
YWNrYWdlIHdoaWNoIGlzIGFsc288YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqB1bmxpa2VseSBpZiB5
b3UgaGF2ZSBhIHByb3BlciBIU0YgYXR0YWNoZWQgKEkgdXNlIHRoZSBvbmVzPGJyPg0KJmd0O8Kg
IMKgIMKgIMKgIMKgdGhhdCBjYW1lIGluIHRoZSByZXRhaWwgYm94ZXMpLjxicj4NCiZndDs8YnI+
DQomZ3Q7wqAgwqAgwqAgwqAgwqBDaGVlcnMsPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgVG9tPGJy
Pg0KJmd0Ozxicj4NCjwvYmxvY2txdW90ZT48L2Rpdj4NCjwvYmxvY2txdW90ZT48L2Rpdj4NCg==
--0000000000009caa9b0583ec68e2--

--===============1440907774==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1440907774==--
