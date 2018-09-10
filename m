From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Init correct fb region for none XGMI
 configuration
Date: Mon, 10 Sep 2018 19:52:47 +0200
Message-ID: <113398fc-a99e-cd69-c107-95cdf2ae91e5@gmail.com>
References: <1536601738-27982-1-git-send-email-Shaoyun.Liu@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1536601738-27982-1-git-send-email-Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org>
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
To: shaoyunl <Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMTAuMDkuMjAxOCB1bSAxOTo0OCBzY2hyaWViIHNoYW95dW5sOgo+IEZpeCA6IDVjNzc3YTUg
J0FkanVzdCBHQVJUIGFuZCBBR1AgbG9jYXRpb24gd2l0aCB4Z21pIG9mZnNldCcKPgo+IENoYW5n
ZS1JZDogSTJkNzgwMjRmYmU0NGEzN2Y0NmEzNWQzNGMxZTY0ZGJkMzkzN2ZkZjEKPiBTaWduZWQt
b2ZmLWJ5OiBzaGFveXVubCA8U2hhb3l1bi5MaXVAYW1kLmNvbT4KClJldmlld2VkLWJ5OiBDaHJp
c3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cgo+IC0tLQo+ICAgZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5jIHwgNSArKysrKwo+ICAgMSBmaWxlIGNo
YW5nZWQsIDUgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9nbWMuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9nbWMuYwo+IGluZGV4IGNmOTdjMWMuLmFlNDQ2NzEgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2dtYy5jCj4gQEAgLTEyMSw2ICsxMjEsMTEgQEAgdm9pZCBhbWRncHVf
Z21jX3ZyYW1fbG9jYXRpb24oc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHN0cnVjdCBhbWRn
cHVfZ21jICptYywKPiAgIAltYy0+dnJhbV9lbmQgPSBtYy0+dnJhbV9zdGFydCArIG1jLT5tY192
cmFtX3NpemUgLSAxOwo+ICAgCWlmIChsaW1pdCAmJiBsaW1pdCA8IG1jLT5yZWFsX3ZyYW1fc2l6
ZSkKPiAgIAkJbWMtPnJlYWxfdnJhbV9zaXplID0gbGltaXQ7Cj4gKwo+ICsJaWYgKG1jLT54Z21p
Lm51bV9waHlzaWNhbF9ub2RlcyA9PSAwKSB7Cj4gKwkJbWMtPmZiX3N0YXJ0ID0gbWMtPnZyYW1f
c3RhcnQ7Cj4gKwkJbWMtPmZiX2VuZCA9IG1jLT52cmFtX2VuZDsKPiArCX0KPiAgIAlkZXZfaW5m
byhhZGV2LT5kZXYsICJWUkFNOiAlbGx1TSAweCUwMTZsbFggLSAweCUwMTZsbFggKCVsbHVNIHVz
ZWQpXG4iLAo+ICAgCQkJbWMtPm1jX3ZyYW1fc2l6ZSA+PiAyMCwgbWMtPnZyYW1fc3RhcnQsCj4g
ICAJCQltYy0+dnJhbV9lbmQsIG1jLT5yZWFsX3ZyYW1fc2l6ZSA+PiAyMCk7CgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
