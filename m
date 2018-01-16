From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH libdrm] drm: fix return value
Date: Tue, 16 Jan 2018 09:49:01 +0100
Message-ID: <1a24cdfa-5741-ea22-41e7-46c742714714__6194.09582946009$1516092978$gmane$org@daenzer.net>
References: <20180116025401.18906-1-david1.zhou@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180116025401.18906-1-david1.zhou-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-CA
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
To: Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Seth.Zhu-5C7GfCeVMHo@public.gmane.org

Ck1vdmluZyBmcm9tIHRoZSBhbWQtZ2Z4IGxpc3QgdG8gZHJpLWRldmVsLCBzaW5jZSB0aGlzIGlz
bid0IGFtZGdwdSBzcGVjaWZpYy4KCgpPbiAyMDE4LTAxLTE2IDAzOjU0IEFNLCBDaHVubWluZyBa
aG91IHdyb3RlOgo+IG90aGVyd2lzZSAtRVRJTUUgaXMgbWlzc2VkLgo+IAo+IENoYW5nZS1JZDog
SWM1NTgwYTc0ZDgwMjdjYzQ2OGM2MTM1ZjhjZjJmODE4MTc5OTM0MjMKPiBTaWduZWQtb2ZmLWJ5
OiBDaHVubWluZyBaaG91IDxkYXZpZDEuemhvdUBhbWQuY29tPgo+IC0tLQo+ICB4Zjg2ZHJtLmMg
fCAyICstCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+
IAo+IGRpZmYgLS1naXQgYS94Zjg2ZHJtLmMgYi94Zjg2ZHJtLmMKPiBpbmRleCA4YTMyNzE3MC4u
Mzg4MWJkOWYgMTAwNjQ0Cj4gLS0tIGEveGY4NmRybS5jCj4gKysrIGIveGY4NmRybS5jCj4gQEAg
LTQyNDEsNyArNDI0MSw3IEBAIGludCBkcm1TeW5jb2JqV2FpdChpbnQgZmQsIHVpbnQzMl90ICpo
YW5kbGVzLCB1bnNpZ25lZCBudW1faGFuZGxlcywKPiAgCj4gIAlyZXQgPSBkcm1Jb2N0bChmZCwg
RFJNX0lPQ1RMX1NZTkNPQkpfV0FJVCwgJmFyZ3MpOwo+ICAJaWYgKHJldCA8IDApCj4gLQkJcmV0
dXJuIHJldDsKPiArCQlyZXR1cm4gLWVycm5vOwo+ICAKPiAgCWlmIChmaXJzdF9zaWduYWxlZCkK
PiAgCQkqZmlyc3Rfc2lnbmFsZWQgPSBhcmdzLmZpcnN0X3NpZ25hbGVkOwo+IAoKCi0tIApFYXJ0
aGxpbmcgTWljaGVsIETDpG56ZXIgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgaHR0cDov
L3d3dy5hbWQuY29tCkxpYnJlIHNvZnR3YXJlIGVudGh1c2lhc3QgICAgICAgICAgICAgfCAgICAg
ICAgICAgICBNZXNhIGFuZCBYIGRldmVsb3BlcgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngK
