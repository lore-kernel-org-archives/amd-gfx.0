From: Lauri Ehrenpreis <laurioma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Slow memory access when using OpenCL without X11
Date: Tue, 12 Mar 2019 23:21:21 +0200
Message-ID: <CAGyaPbA_z0bKC1W8gTdnx4Ot5G-45pC7029pKWrAM0Pj_BU6uw@mail.gmail.com>
References: <CAGyaPbDo4-mJhCbL1gfjgek_Z54dyREydqZc-SF=cFVQ0URyYA@mail.gmail.com>
 <CADnq5_Mtg5Brvp3Z1dMy+V4oD1DqCQ-WJm4ehSW_dFybLm1Jcw@mail.gmail.com>
 <CAGyaPbCxMxG5kbu9RhrB0vSCDQL4zaNzsUqsoWVWmRVw8Mp7Pg@mail.gmail.com>
 <CABE_ZV0MV+=9=sE2ddK6hGzrSqZXayGdGUjnMWqYFp1t1k-O=Q@mail.gmail.com>
 <CAGyaPbDGq5Z+J+c_s99vBjSUttKwsBNv+EMvdjg0aXjY52qT-g@mail.gmail.com>
 <CAAzXoRKQnmsQxPqEswAyAxQ7snW+D=L0GC+auiDsVnZQaBeAvQ@mail.gmail.com>
 <CAGyaPbCNtF_LP3jtKcm9NB=Suw+EKTY941y=QAmODcP=q83zbA@mail.gmail.com>
 <CAAzXoRJ7MBis7YYWhYcH_H=1ZPpZpTJFDm+HTD5q0p91bgTxSg@mail.gmail.com>
 <b26fcd35-9867-f716-cea8-ddf76c599fca@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1218958151=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <b26fcd35-9867-f716-cea8-ddf76c599fca-5C7GfCeVMHo@public.gmane.org>
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

--===============1218958151==
Content-Type: multipart/alternative; boundary="000000000000ed64480583ec45a4"

--000000000000ed64480583ec45a4
Content-Type: text/plain; charset="UTF-8"

IN the case when memory is slow, the rocm-smi outputs this:
========================        ROCm System Management Interface
========================
================================================================================================
GPU   Temp   AvgPwr   SCLK    MCLK    PCLK           Fan     Perf
PwrCap   SCLK OD   MCLK OD  GPU%
GPU[0] : WARNING: Empty SysFS value: pclk
GPU[0] : WARNING: Unable to read
/sys/class/drm/card0/device/gpu_busy_percent
0     30.0c  N/A      400Mhz  933Mhz  N/A            0%      auto    N/A
  0%        0%       N/A
================================================================================================
========================               End of ROCm SMI Log
========================

normal memory speed case gives following:
========================        ROCm System Management Interface
========================
================================================================================================
GPU   Temp   AvgPwr   SCLK    MCLK    PCLK           Fan     Perf
PwrCap   SCLK OD   MCLK OD  GPU%
GPU[0] : WARNING: Empty SysFS value: pclk
GPU[0] : WARNING: Unable to read
/sys/class/drm/card0/device/gpu_busy_percent
0     35.0c  N/A      400Mhz  1200Mhz N/A            0%      auto    N/A
  0%        0%       N/A
================================================================================================
========================               End of ROCm SMI Log
========================

So there is a difference in MCLK - can this cause such a huge slowdown?

--
Lauri

On Tue, Mar 12, 2019 at 6:39 PM Kuehling, Felix <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
wrote:

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

--000000000000ed64480583ec45a4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+SU4gdGhlIGNhc2Ug
d2hlbiBtZW1vcnkgaXMgc2xvdywgdGhlIHJvY20tc21pIG91dHB1dHMgdGhpczo8ZGl2Pj09PT09
PT09PT09PT09PT09PT09PT09PcKgIMKgIMKgIMKgIFJPQ20gU3lzdGVtIE1hbmFnZW1lbnQgSW50
ZXJmYWNlwqAgwqAgwqAgwqAgPT09PT09PT09PT09PT09PT09PT09PT09PC9kaXY+PGRpdj49PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT08L2Rpdj48ZGl2PkdQVcKgIMKgVGVt
cMKgIMKgQXZnUHdywqAgwqBTQ0xLwqAgwqAgTUNMS8KgIMKgIFBDTEvCoCDCoCDCoCDCoCDCoCDC
oEZhbsKgIMKgIMKgUGVyZsKgIMKgIFB3ckNhcMKgIMKgU0NMSyBPRMKgIMKgTUNMSyBPRMKgIEdQ
VSU8L2Rpdj48ZGl2PkdQVVswXSA8c3BhbiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JCTwvc3Bh
bj46IFdBUk5JTkc6IEVtcHR5IFN5c0ZTIHZhbHVlOiBwY2xrPC9kaXY+PGRpdj5HUFVbMF0gPHNw
YW4gc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CQk8L3NwYW4+OiBXQVJOSU5HOiBVbmFibGUgdG8g
cmVhZCAvc3lzL2NsYXNzL2RybS9jYXJkMC9kZXZpY2UvZ3B1X2J1c3lfcGVyY2VudDwvZGl2Pjxk
aXY+MMKgIMKgIMKgMzAuMGPCoCBOL0HCoCDCoCDCoCA0MDBNaHrCoCA5MzNNaHrCoCBOL0HCoCDC
oCDCoCDCoCDCoCDCoCAwJcKgIMKgIMKgIGF1dG/CoCDCoCBOL0HCoCDCoCDCoCAwJcKgIMKgIMKg
IMKgIDAlwqAgwqAgwqAgwqBOL0HCoCDCoCDCoMKgPC9kaXY+PGRpdj49PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT08L2Rpdj48ZGl2Pj09PT09PT09PT09PT09PT09PT09PT09
PcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgRW5kIG9mIFJPQ20gU01JIExvZ8KgIMKgIMKgIMKgIMKg
IMKgIMKgID09PT09PT09PT09PT09PT09PT09PT09PTwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+
bm9ybWFsIG1lbW9yeSBzcGVlZCBjYXNlIGdpdmVzIGZvbGxvd2luZzo8L2Rpdj48ZGl2Pj09PT09
PT09PT09PT09PT09PT09PT09PcKgIMKgIMKgIMKgIFJPQ20gU3lzdGVtIE1hbmFnZW1lbnQgSW50
ZXJmYWNlwqAgwqAgwqAgwqAgPT09PT09PT09PT09PT09PT09PT09PT09PC9kaXY+PGRpdj49PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT08L2Rpdj48ZGl2PkdQVcKgIMKgVGVt
cMKgIMKgQXZnUHdywqAgwqBTQ0xLwqAgwqAgTUNMS8KgIMKgIFBDTEvCoCDCoCDCoCDCoCDCoCDC
oEZhbsKgIMKgIMKgUGVyZsKgIMKgIFB3ckNhcMKgIMKgU0NMSyBPRMKgIMKgTUNMSyBPRMKgIEdQ
VSU8L2Rpdj48ZGl2PkdQVVswXSA8c3BhbiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JCTwvc3Bh
bj46IFdBUk5JTkc6IEVtcHR5IFN5c0ZTIHZhbHVlOiBwY2xrPC9kaXY+PGRpdj5HUFVbMF0gPHNw
YW4gc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CQk8L3NwYW4+OiBXQVJOSU5HOiBVbmFibGUgdG8g
cmVhZCAvc3lzL2NsYXNzL2RybS9jYXJkMC9kZXZpY2UvZ3B1X2J1c3lfcGVyY2VudDwvZGl2Pjxk
aXY+MMKgIMKgIMKgMzUuMGPCoCBOL0HCoCDCoCDCoCA0MDBNaHrCoCAxMjAwTWh6IE4vQcKgIMKg
IMKgIMKgIMKgIMKgIDAlwqAgwqAgwqAgYXV0b8KgIMKgIE4vQcKgIMKgIMKgIDAlwqAgwqAgwqAg
wqAgMCXCoCDCoCDCoCDCoE4vQcKgIMKgIMKgwqA8L2Rpdj48ZGl2Pj09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PTwvZGl2PjxkaXY+PT09PT09PT09PT09PT09PT09PT09PT09
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBFbmQgb2YgUk9DbSBTTUkgTG9nwqAgwqAgwqAgwqAgwqAg
wqAgwqAgPT09PT09PT09PT09PT09PT09PT09PT09PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5T
byB0aGVyZSBpcyBhIGRpZmZlcmVuY2UgaW4gTUNMSyAtIGNhbiB0aGlzIGNhdXNlIHN1Y2ggYSBo
dWdlIHNsb3dkb3duPzwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+LS08L2Rpdj48ZGl2PkxhdXJp
wqDCoDxicj48L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj48YnI+PGRpdiBjbGFzcz0iZ21haWxfcXVv
dGUiPjxkaXYgZGlyPSJsdHIiIGNsYXNzPSJnbWFpbF9hdHRyIj5PbiBUdWUsIE1hciAxMiwgMjAx
OSBhdCA2OjM5IFBNIEt1ZWhsaW5nLCBGZWxpeCAmbHQ7PGEgaHJlZj0ibWFpbHRvOkZlbGl4Lkt1
ZWhsaW5nQGFtZC5jb20iPkZlbGl4Lkt1ZWhsaW5nQGFtZC5jb208L2E+Jmd0OyB3cm90ZTo8YnI+
PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAw
cHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRp
bmctbGVmdDoxZXgiPlthZGRpbmcgdGhlIGxpc3QgYmFja108YnI+DQo8YnI+DQpJJiMzOTtkIHN1
c3BlY3QgYSBwcm9ibGVtIHJlbGF0ZWQgdG8gbWVtb3J5IGNsb2NrLiBUaGlzIGlzIGFuIEFQVSB3
aGVyZSA8YnI+DQpzeXN0ZW0gbWVtb3J5IGlzIHNoYXJlZCB3aXRoIHRoZSBDUFUsIHNvIGlmIHRo
ZSBTTVUgY2hhbmdlcyBtZW1vcnkgPGJyPg0KY2xvY2tzIHRoYXQgd291bGQgYWZmZWN0IENQVSBt
ZW1vcnkgYWNjZXNzIHBlcmZvcm1hbmNlLiBJZiB0aGUgcHJvYmxlbSA8YnI+DQpvbmx5IG9jY3Vy
cyB3aGVuIE9wZW5DTCBpcyBydW5uaW5nLCB0aGVuIHRoZSBjb21wdXRlIHBvd2VyIHByb2ZpbGUg
Y291bGQgPGJyPg0KaGF2ZSBhbiBlZmZlY3QgaGVyZS48YnI+DQo8YnI+DQpMYXVyaWUsIGNhbiB5
b3UgbW9uaXRvciB0aGUgY2xvY2tzIGR1cmluZyB5b3VyIHRlc3RzIHVzaW5nIHJvY20tc21pPzxi
cj4NCjxicj4NClJlZ2FyZHMsPGJyPg0KwqDCoCBGZWxpeDxicj4NCjxicj4NCk9uIDIwMTktMDMt
MTEgMToxNSBwLm0uLCBUb20gU3QgRGVuaXMgd3JvdGU6PGJyPg0KJmd0OyBIaSBMYXVyaSw8YnI+
DQomZ3Q7PGJyPg0KJmd0OyBJIGRvbiYjMzk7dCBoYXZlIFJPQ20gaW5zdGFsbGVkIGxvY2FsbHkg
KG5vdCBvbiB0aGF0IHRlYW0gYXQgQU1EKSBidXQgSSA8YnI+DQomZ3Q7IGNhbiByb3BlIGluIHNv
bWUgb2YgdGhlIEtGRCBmb2xrIGFuZCBzZWUgd2hhdCB0aGV5IHNheSA6LSkuPGJyPg0KJmd0Ozxi
cj4NCiZndDsgKGluIHRoZSBtZWFuIHRpbWUgSSBzaG91bGQgbG9vayBpbnRvIGluc3RhbGxpbmcg
dGhlIFJPQ20gc3RhY2sgb24gbXkgPGJyPg0KJmd0OyBVYnVudHUgZGlzayBmb3IgZXhwZXJpbWVu
dGF0aW9uLi4uKS48YnI+DQomZ3Q7PGJyPg0KJmd0OyBPbmx5IG90aGVyIHRoaW5nIHRoYXQgY29t
ZXMgdG8gbWluZCBpcyBzb21lIHNvcnQgb2Ygc3R1dHRlciBkdWUgdG8gPGJyPg0KJmd0OyBwb3dl
ci9jbG9jayBnYXRpbmcgKG9yIGdmeCBvZmYvZXRjKS7CoCBCdXQgdGhhdCB0eXBpY2FsbHkgYWZm
ZWN0cyB0aGUgPGJyPg0KJmd0OyBkaXNwbGF5L2dwdSBzaWRlIG5vdCB0aGUgQ1BVIHNpZGUuPGJy
Pg0KJmd0Ozxicj4NCiZndDsgRmVsaXg6wqAgQW55IGtub3duIGlzc3VlcyB3aXRoIFJhdmVuIGFu
ZCBST0NtIGludGVyYWN0aW5nIG92ZXIgbWVtb3J5IDxicj4NCiZndDsgYnVzIHBlcmZvcm1hbmNl
Pzxicj4NCiZndDs8YnI+DQomZ3Q7IFRvbTxicj4NCiZndDs8YnI+DQomZ3Q7IE9uIE1vbiwgTWFy
IDExLCAyMDE5IGF0IDEyOjU2IFBNIExhdXJpIEVocmVucHJlaXMgJmx0OzxhIGhyZWY9Im1haWx0
bzpsYXVyaW9tYUBnbWFpbC5jb20iIHRhcmdldD0iX2JsYW5rIj5sYXVyaW9tYUBnbWFpbC5jb208
L2E+IDxicj4NCiZndDsgJmx0O21haWx0bzo8YSBocmVmPSJtYWlsdG86bGF1cmlvbWFAZ21haWwu
Y29tIiB0YXJnZXQ9Il9ibGFuayI+bGF1cmlvbWFAZ21haWwuY29tPC9hPiZndDsmZ3Q7IHdyb3Rl
Ojxicj4NCiZndDs8YnI+DQomZ3Q7wqAgwqAgwqBIaSE8YnI+DQomZ3Q7PGJyPg0KJmd0O8KgIMKg
IMKgVGhlIDEwMHggbWVtb3J5IHNsb3dkb3duIGlzIGhhcmQgdG8gYmVsaXZlIGluZGVlZC4gSSBh
dHRhY2hlZCB0aGU8YnI+DQomZ3Q7wqAgwqAgwqB0ZXN0IHByb2dyYW0gd2l0aCBteSBmaXJzdCBl
LW1haWwgd2hpY2ggZGVwZW5kcyBvbmx5IG9uPGJyPg0KJmd0O8KgIMKgIMKgcm9jbS1vcGVuY2wt
ZGV2IHBhY2thZ2UuIFdvdWxkIHlvdSBtaW5kIGNvbXBpbGluZyBpdCBhbmQgY2hlY2tpbmc8YnI+
DQomZ3Q7wqAgwqAgwqBpZiBpdCBzbG93cyBkb3duIG1lbW9yeSBmb3IgeW91IGFzIHdlbGw/PGJy
Pg0KJmd0Ozxicj4NCiZndDvCoCDCoCDCoHN0ZXBzOjxicj4NCiZndDvCoCDCoCDCoDEpIGcrKyBj
bF9zbG93X3Rlc3QuY3BwIC1vIGNsX3Nsb3dfdGVzdCAtSTxicj4NCiZndDvCoCDCoCDCoC9vcHQv
cm9jbS9vcGVuY2wvaW5jbHVkZS8gLUwgL29wdC9yb2NtL29wZW5jbC9saWIveDg2XzY0L8KgIC1s
T3BlbkNMPGJyPg0KJmd0O8KgIMKgIMKgMikgbG9nb3V0IGZyb20gZGVza3RvcCBlbnYgYW5kIGRp
c2Nvbm5lY3QgaGRtaS9kaXBsYXlwb3J0IGV0Yzxicj4NCiZndDvCoCDCoCDCoDMpIGxvZyBpbiBv
dmVyIHNzaDxicj4NCiZndDvCoCDCoCDCoDQpIHJ1biB0aGUgcHJvZ3JhbSAuL2NsX3Nsb3dfdGVz
dCAxPGJyPg0KJmd0Ozxicj4NCiZndDvCoCDCoCDCoEZvciBtZSBpdCByZXByb2R1Y2VkIGV2ZW4g
d2l0aG91dCBzdGVwIDIgYXMgd2VsbCBidXQgbGVzczxicj4NCiZndDvCoCDCoCDCoHJlbGlhYmx5
LiBtb3ZpbmcgbW91c2UgZm9yIGV4YW1wbGUgY291bGQgbWFrZSB0aGUgbWVtb3J5IHNwZWVkPGJy
Pg0KJmd0O8KgIMKgIMKgZmFzdCBhZ2Fpbi48YnI+DQomZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgLS08
YnI+DQomZ3Q7wqAgwqAgwqBMYXVyaTxicj4NCiZndDs8YnI+DQomZ3Q7PGJyPg0KJmd0Ozxicj4N
CiZndDvCoCDCoCDCoE9uIE1vbiwgTWFyIDExLCAyMDE5IGF0IDY6MzMgUE0gVG9tIFN0IERlbmlz
ICZsdDs8YSBocmVmPSJtYWlsdG86dHN0ZGVuaXM4MkBnbWFpbC5jb20iIHRhcmdldD0iX2JsYW5r
Ij50c3RkZW5pczgyQGdtYWlsLmNvbTwvYT48YnI+DQomZ3Q7wqAgwqAgwqAmbHQ7bWFpbHRvOjxh
IGhyZWY9Im1haWx0bzp0c3RkZW5pczgyQGdtYWlsLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPnRzdGRl
bmlzODJAZ21haWwuY29tPC9hPiZndDsmZ3Q7IHdyb3RlOjxicj4NCiZndDs8YnI+DQomZ3Q7wqAg
wqAgwqAgwqAgwqBIaSBMYXVyaSw8YnI+DQomZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgVGhl
cmUmIzM5O3MgcmVhbGx5IG5vIGNvbm5lY3Rpb24gYmV0d2VlbiB0aGUgdHdvIG90aGVyIHRoYW4g
dGhleTxicj4NCiZndDvCoCDCoCDCoCDCoCDCoHJ1biBpbiB0aGUgc2FtZSBwYWNrYWdlLsKgIEkg
dG9vIHJ1biBhIDI0MDBHIChhcyBteTxicj4NCiZndDvCoCDCoCDCoCDCoCDCoHdvcmtzdGF0aW9u
KSBhbmQgSSBnb3QgdGhlIHNhbWUgfjYuNkdCL3NlYyB0cmFuc2ZlciByYXRlIGJ1dDxicj4NCiZn
dDvCoCDCoCDCoCDCoCDCoHdpdGhvdXQgYSBDTCBhcHAgcnVubmluZyAuLi7CoCBUaGUgb25seSBs
b2dpY2FsIHJlYXNvbiBpcyB5b3VyPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgQ0wgYXBwIGlzIGJv
dHRsZW5lY2tpbmcgdGhlIEFQVXMgbWVtb3J5IGJ1cyBidXQgeW91IGNsYWltPGJyPg0KJmd0O8Kg
IMKgIMKgIMKgIMKgJnF1b3Q7c2ltcGx5IG9wZW5pbmcgYSBjb250ZXh0IGlzIGVub3VnaCZxdW90
OyBzbyBzb21ldGhpbmcgZWxzZSBpczxicj4NCiZndDvCoCDCoCDCoCDCoCDCoGdvaW5nIG9uLjxi
cj4NCiZndDs8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqBZb3VyIGxhc3QgcmVwbHkgdGhvdWdoIHNh
eXMgJnF1b3Q7d2l0aCBpdCBydW5uaW5nIGluIHRoZTxicj4NCiZndDvCoCDCoCDCoCDCoCDCoGJh
Y2tncm91bmQmcXVvdDsgc28gaXQmIzM5O3MgZW50aXJlbHkgcG9zc2libGUgdGhlIENQVSBpc24m
IzM5O3QgYnVzeSBidXQ8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqB0aGUgcGFja2FnZSBtZW1vcnkg
Y29udHJvbGxlciAoc2hhcmVkIGJldHdlZW4gYm90aCB0aGUgQ1BVIGFuZDxicj4NCiZndDvCoCDC
oCDCoCDCoCDCoEdQVSkgaXMgYnVzeS7CoCBGb3IgaW5zdGFuY2UgcnVubmluZyB4b25vdGljIGlu
IGEgMTA4MHAgd2luZG93PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgb24gbXkgNEsgZGlzcGxheSBy
ZWR1Y2VkIHRoZSBtZW1vcnkgdGVzdCB0byA1LjhHQi9zZWMgYW5kPGJyPg0KJmd0O8KgIMKgIMKg
IMKgIMKgdGhhdCYjMzk7cyBoYXJkbHkgYSBoZWF2eSBtZW1vcnkgYm91bmQgR1BVIGFwcC48YnI+
DQomZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgVGhlIG9ubHkgb3RoZXIgcG9zc2libGUgY29u
bmVjdGlvbiBpcyB0aGUgR1BVIGlzIGdlbmVyYXRpbmcgc288YnI+DQomZ3Q7wqAgwqAgwqAgwqAg
wqBtdWNoIGhlYXQgdGhhdCBpdCYjMzk7cyB0aHJvdHRsaW5nIHRoZSBwYWNrYWdlIHdoaWNoIGlz
IGFsc288YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqB1bmxpa2VseSBpZiB5b3UgaGF2ZSBhIHByb3Bl
ciBIU0YgYXR0YWNoZWQgKEkgdXNlIHRoZSBvbmVzPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgdGhh
dCBjYW1lIGluIHRoZSByZXRhaWwgYm94ZXMpLjxicj4NCiZndDs8YnI+DQomZ3Q7wqAgwqAgwqAg
wqAgwqBDaGVlcnMsPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgVG9tPGJyPg0KJmd0Ozxicj4NCjwv
YmxvY2txdW90ZT48L2Rpdj4NCg==
--000000000000ed64480583ec45a4--

--===============1218958151==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1218958151==--
