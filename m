From: Samuel Li <samuel.li-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: add kernel DOC for ioctls in amdgpu_cs.c file
Date: Fri, 1 Jun 2018 17:09:35 -0400
Message-ID: <4d5dac06-d400-af89-f224-9b5920407460@amd.com>
References: <20180530184251.6314-1-leo.liu@amd.com>
 <4df023fd-bac7-8369-43d7-db329ecb980a@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <4df023fd-bac7-8369-43d7-db329ecb980a-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, Leo Liu <leo.liu-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

CgpPbiAyMDE4LTA1LTMxIDEyOjMwIFBNLCBNaWNoZWwgRMOkbnplciB3cm90ZToKPiBPbiAyMDE4
LTA1LTMwIDA4OjQyIFBNLCBMZW8gTGl1IHdyb3RlOgo+PiBUaGVyZSBhcmUgZm91ciBpb2N0bHMg
aW4gdGhpcyBmaWxlcywgYW5kIERPQyBnaXZlcyBkZXRhaWxzIG9mCj4+IGRhdGEgc3RydWN0dXJl
cyBmb3IgZWFjaCBvZiBpb2N0bHMsIGFuZCB0aGVpciBmdW5jdGlvbmFsaXRpZXMuCj4+Cj4+IFNp
Z25lZC1vZmYtYnk6IExlbyBMaXUgPGxlby5saXVAYW1kLmNvbT4KPiAKPiBUaGlzIGlzbid0IGVu
b3VnaCB0byBhY3R1YWxseSBtYWtlIHRoaXMgcGFydCBvZiB0aGUgZ2VuZXJhdGVkCj4gZG9jdW1l
bnRhdGlvbi4gSXQgbmVlZHMgdG8gYmUgaG9va2VkIHVwIHRvIGEgKi5yc3QgZmlsZSBmb3IgdGhh
dC4KPiAKPiBJJ20gYWRkaW5nIGFuIGFtZGdwdS5yc3QgZmlsZSBpbgo+IGh0dHBzOi8vcGF0Y2h3
b3JrLmZyZWVkZXNrdG9wLm9yZy9zZXJpZXMvNDQwMzUvICwgd2hlcmUgeW91IGNvdWxkIGhvb2sK
PiBpdCB1cCBhY2NvcmRpbmdseS4KTWljaGVsLCBoYXZlIHlvdSBzdWJtaXR0ZWQgdGhpcyBvbmU/
IFNvIHdlIGNhbiBob29rIHVwIHRoZSBmaWxlcyBncmFkdWFsbHkuCkkgZG8gbm90IHNlZSB0aGUg
cGF0Y2hlcyBpbiB0aGlzIGxpc3QuCgpTYW0KCj4gCj4gUGxlYXNlIGNoZWNrIHRoYXQgZ2VuZXJh
dGluZyB0aGUgZG9jdW1lbnRhdGlvbiAoZS5nLiB3aXRoIG1ha2UgaHRtbGRvY3MpCj4gZG9lc24n
dCBwcm9kdWNlIGFueSB3YXJuaW5ncyBhYm91dCBhbWRncHVfY3MuYywgYW5kIHRoYXQgdGhlIHJl
c3VsdAo+IGxvb2tzIGdvb2QgaW4gRG9jdW1lbnRhdGlvbi9vdXRwdXQvZ3B1L2FtZGdwdS5odG1s
IC4gVGhlIGRvY3VtZW50YXRpb24KPiBmb3JtYXQgaXRzZWxmIGlzIGRvY3VtZW50ZWQgaW4gRG9j
dW1lbnRhdGlvbi9vdXRwdXQvZG9jLWd1aWRlL2luZGV4Lmh0bWwgLgo+IAo+IAoKClsuLi5dCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
