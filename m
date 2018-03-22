From: Tom St Denis <tstdenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: amdgpu hangs on boot or shutdown on AMD Raven Ridge CPU (Engineer
 Sample)
Date: Thu, 22 Mar 2018 16:35:23 -0400
Message-ID: <3350cfd0-5852-9d24-2788-3f7b8e5d42ef@amd.com>
References: <CAB4CAweUBN=8pd8x4AfMHor3D-C+1HRgAiG=1Vc1ne8M-cV-og@mail.gmail.com>
 <d2de9e60-239c-86a5-16af-bf74fe20a53a@amd.com>
 <CAB4CAwfv6RYRRCbf886+j-omPcwqjbCLC-hxVy=y=Sc1q18-kQ@mail.gmail.com>
 <CAB4CAweBvmuCYat8fjczbUFO-qg8=rEpSi+SbYPwQ=Rqb9fncw@mail.gmail.com>
 <CAD8Lp44hREd-ttStnttbN_gJ1vbYbV8HtEEfAn0f6V7=dHdWwA@mail.gmail.com>
 <CADnq5_MLCJjdiJsa9xCYEf9wB9WN7Y=kPDs-eN9hDdFb+FNS8w@mail.gmail.com>
 <CAD8Lp44vfd59L0UVMUuWRn7JNuib__E=NwWULc-3QPBk8W-GEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAD8Lp44vfd59L0UVMUuWRn7JNuib__E=NwWULc-3QPBk8W-GEA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

SSBoYXZlIGEgcmV0YWlsIFJ5emVuIDI0MDBHIGluIGFuIEFTVVMgQjM1MC1UVUYgbW90aGVyYm9h
cmQgYW5kIGl0IHdvcmtzIApmaW5lICh3ZWxsIGJldHRlciB0aGFuIHRoaXMpIG9uIHRoZSBhbWQt
c3RhZ2luZy1kcm0tbmV4dCBrZXJuZWwuCgpUb20KCgoKT24gMDMvMjIvMjAxOCAwNTowOSBBTSwg
RGFuaWVsIERyYWtlIHdyb3RlOgo+IEhpIEFsZXgsCj4gCj4gT24gVHVlLCBGZWIgMjAsIDIwMTgg
YXQgMTA6MTggUE0sIEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJAZ21haWwuY29tPiB3cm90ZToK
Pj4+IEl0IHNlZW1zIHRoYXQgd2UgYXJlIG5vdCBhbG9uZSBzZWVpbmcgYW1kZ3B1LWluZHVjZWQg
c3RhYmlsaXR5Cj4+PiBwcm9ibGVtcyBvbiBtdWx0aXBsZSBSYXZlbiBSaWRnZSBwbGF0Zm9ybXMu
Cj4+PiBodHRwczovL3d3dy5waG9yb25peC5jb20vc2Nhbi5waHA/cGFnZT1uZXdzX2l0ZW0mcHg9
QU1ELVJhdmVuLVJpZGdlLU1vYm8tTGludXgKPj4+Cj4+PiBBTUQsIHdoYXQgY2FuIHdlIGRvIHRv
IGhlbHA/Cj4+Cj4+IFBsZWFzZSBmaWxlIGJ1Z3M6Cj4+IGh0dHBzOi8vYnVncy5mcmVlZGVza3Rv
cC5vcmcKPiAKPiBTb3JyeSBmb3IgdGhlIGRlbGF5ZWQgcmVzcG9uc2UuIFdlJ3JlIHN0aWxsIHNl
ZWluZyBzZXJpb3VzIGluc3RhYmlsaXR5Cj4gaGVyZSBldmVuIG9uIHRoZSBsYXRlc3Qga2VybmVs
LiBGaWxlZAo+IGh0dHBzOi8vYnVncy5mcmVlZGVza3RvcC5vcmcvc2hvd19idWcuY2dpP2lkPTEw
NTY4NAo+IAo+IFRoYW5rcywKPiBEYW5pZWwKPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwo+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngKPiAKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4Cg==
