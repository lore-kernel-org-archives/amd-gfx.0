From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: Fix use of interruptible waiting 1. The
 signal interrupt can affect the expected behaviour. 2. There is no good
 mechanism to handle the corresponding error. When signal interrupt happens,
 unpin is not called. As a result, inside AMDGPU, the statistic of pin size
 will be wrong.
Date: Tue, 25 Apr 2017 10:02:14 +0200
Message-ID: <6a8fdba1-3d74-4cee-fc5e-524a016fb489@vodafone.de>
References: <1493062478-12753-1-git-send-email-AlexBin.Xie@amd.com>
 <1493062478-12753-2-git-send-email-AlexBin.Xie@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1493062478-12753-2-git-send-email-AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>
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
To: Alex Xie <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

WW91IHNvbWVob3cgbWVzc2VkIHVwIHRoZSBjb21taXQgbWVzc2FnZS4gRXZlcnl0aGluZyBnb3Qg
bWFuZ2xlZCBpbnRvIAp0aGUgc3ViamVjdCBsaW5lIHdoaWxlIHNlbmRpbmcgdGhlIG1haWxzLgoK
QXBhcnQgZnJvbSB0aGF0IHRoZSBjaGFuZ2UgbG9va3MgZ29vZCB0byBtZSBhbmQgd2l0aCB0aGUg
Y29tbWl0IG1lc3NhZ2UgCmZpeGVkIGlzIFJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxj
aHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CgpSZWdhcmRzLApDaHJpc3RpYW4uCgpBbSAyNC4wNC4y
MDE3IHVtIDIxOjM0IHNjaHJpZWIgQWxleCBYaWU6Cj4gQ2hhbmdlLUlkOiBJNjg4OWE0ZDlkZDI3
MDNiY2Y1ZDQ0OGQxOGY2YWY1MWM0OTZhOTNjOQo+IFNpZ25lZC1vZmYtYnk6IEFsZXggWGllIDxB
bGV4QmluLlhpZUBhbWQuY29tPgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2JlbmNobWFyay5jIHwgNCArKy0tCj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRp
b25zKCspLCAyIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9iZW5jaG1hcmsuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9iZW5jaG1hcmsuYwo+IGluZGV4IDc2YmUyZDIuLjc1YmQ3NmYgMTAwNjQ0Cj4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2JlbmNobWFyay5jCj4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2JlbmNobWFyay5jCj4gQEAgLTEyMyw3
ICsxMjMsNyBAQCBzdGF0aWMgdm9pZCBhbWRncHVfYmVuY2htYXJrX21vdmUoc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYsIHVuc2lnbmVkIHNpemUsCj4gICAJfQo+ICAgCj4gICAJaWYgKHNvYmop
IHsKPiAtCQlyID0gYW1kZ3B1X2JvX3Jlc2VydmUoc29iaiwgZmFsc2UpOwo+ICsJCXIgPSBhbWRn
cHVfYm9fcmVzZXJ2ZShzb2JqLCB0cnVlKTsKPiAgIAkJaWYgKGxpa2VseShyID09IDApKSB7Cj4g
ICAJCQlhbWRncHVfYm9fdW5waW4oc29iaik7Cj4gICAJCQlhbWRncHVfYm9fdW5yZXNlcnZlKHNv
YmopOwo+IEBAIC0xMzEsNyArMTMxLDcgQEAgc3RhdGljIHZvaWQgYW1kZ3B1X2JlbmNobWFya19t
b3ZlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCB1bnNpZ25lZCBzaXplLAo+ICAgCQlhbWRn
cHVfYm9fdW5yZWYoJnNvYmopOwo+ICAgCX0KPiAgIAlpZiAoZG9iaikgewo+IC0JCXIgPSBhbWRn
cHVfYm9fcmVzZXJ2ZShkb2JqLCBmYWxzZSk7Cj4gKwkJciA9IGFtZGdwdV9ib19yZXNlcnZlKGRv
YmosIHRydWUpOwo+ICAgCQlpZiAobGlrZWx5KHIgPT0gMCkpIHsKPiAgIAkJCWFtZGdwdV9ib191
bnBpbihkb2JqKTsKPiAgIAkJCWFtZGdwdV9ib191bnJlc2VydmUoZG9iaik7CgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
