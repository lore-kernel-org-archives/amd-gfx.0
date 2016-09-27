From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/vce: take all rings into account for idle
 checks
Date: Tue, 27 Sep 2016 09:10:37 +0200
Message-ID: <acdf0073-5e8c-8aa4-48a1-e9d4a9ca1d6f@vodafone.de>
References: <1474917664-7766-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1474917664-7766-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

QW0gMjYuMDkuMjAxNiB1bSAyMToyMSBzY2hyaWViIEFsZXggRGV1Y2hlcjoKPiBTaWduZWQtb2Zm
LWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+CgpSZXZpZXdlZC1i
eTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKPiAtLS0KPiAg
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y2UuYyB8IDcgKysrKystLQo+ICAg
MSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPgo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNlLmMgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNlLmMKPiBpbmRleCAxMjFiZDZlLi4zYjAzNTU4
IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y2UuYwo+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y2UuYwo+IEBAIC0zMDUs
OSArMzA1LDEyIEBAIHN0YXRpYyB2b2lkIGFtZGdwdV92Y2VfaWRsZV93b3JrX2hhbmRsZXIoc3Ry
dWN0IHdvcmtfc3RydWN0ICp3b3JrKQo+ICAgewo+ICAgCXN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2ID0KPiAgIAkJY29udGFpbmVyX29mKHdvcmssIHN0cnVjdCBhbWRncHVfZGV2aWNlLCB2Y2Uu
aWRsZV93b3JrLndvcmspOwo+ICsJdW5zaWduZWQgaSwgY291bnQgPSAwOwo+ICAgCj4gLQlpZiAo
KGFtZGdwdV9mZW5jZV9jb3VudF9lbWl0dGVkKCZhZGV2LT52Y2UucmluZ1swXSkgPT0gMCkgJiYK
PiAtCSAgICAoYW1kZ3B1X2ZlbmNlX2NvdW50X2VtaXR0ZWQoJmFkZXYtPnZjZS5yaW5nWzFdKSA9
PSAwKSkgewo+ICsJZm9yIChpID0gMDsgaSA8IGFkZXYtPnZjZS5udW1fcmluZ3M7IGkrKykKPiAr
CQljb3VudCArPSBhbWRncHVfZmVuY2VfY291bnRfZW1pdHRlZCgmYWRldi0+dmNlLnJpbmdbaV0p
Owo+ICsKPiArCWlmIChjb3VudCA9PSAwKSB7Cj4gICAJCWlmIChhZGV2LT5wbS5kcG1fZW5hYmxl
ZCkgewo+ICAgCQkJYW1kZ3B1X2RwbV9lbmFibGVfdmNlKGFkZXYsIGZhbHNlKTsKPiAgIAkJfSBl
bHNlIHsKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
