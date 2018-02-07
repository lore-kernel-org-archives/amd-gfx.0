From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 8/9] drm/amdgpu: init mc base address for zfb
Date: Wed, 7 Feb 2018 14:30:15 +0100
Message-ID: <f9b23fd2-a3f3-4dd7-1b88-425842a6479f@gmail.com>
References: <1518006892-14121-1-git-send-email-Feifei.Xu@amd.com>
 <1518006892-14121-9-git-send-email-Feifei.Xu@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1518006892-14121-9-git-send-email-Feifei.Xu-5C7GfCeVMHo@public.gmane.org>
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
To: Feifei Xu <Feifei.Xu-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Hawking Zhang <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>

QW0gMDcuMDIuMjAxOCB1bSAxMzozNCBzY2hyaWViIEZlaWZlaSBYdToKPiBGcm9tOiBIYXdraW5n
IFpoYW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+Cj4KPiBDaGFuZ2UtSWQ6IEk4OWI5ZmYzNmI2
MmViNjg1YTllMmQ4N2UyMDU4ZDIwMGI5MmY1MDM0Cj4gU2lnbmVkLW9mZi1ieTogSGF3a2luZyBa
aGFuZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPgo+IEFja2VkLWJ5OiBKb2huIEJyaWRnbWFuIDxq
b2huLmJyaWRnbWFuQGFtZC5jb20+Cj4gUmV2aWV3ZWQtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFu
ZGVyLmRldWNoZXJAYW1kLmNvbT4KCk5BSywgcGxlYXNlIGRvIHRoYXQgaW4gZ21jX3Y5XzBfdnJh
bV9ndHRfbG9jYXRpb24oKSBpbnN0ZWFkLiBUaGUgCmZ1bmN0aW9uIHlvdSBtb2RpZnkgaGVyZSBz
aG91bGQgb25seSByZWFkIHRoZSBwcm9ncmFtbWVkIEZCIGxvY2F0aW9uIApmcm9tIHRoZSBNTSBI
VUIuCgpDaHJpc3RpYW4uCgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbW1o
dWJfdjFfMC5jIHwgOSArKysrKystLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMo
KyksIDMgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvbW1odWJfdjFfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbW1odWJfdjFf
MC5jCj4gaW5kZXggYjUzOWZkMS4uYzU2YWI0NyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9tbWh1Yl92MV8wLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9tbWh1Yl92MV8wLmMKPiBAQCAtMzgsOSArMzgsMTIgQEAKPiAgIHU2NCBtbWh1Yl92MV8w
X2dldF9mYl9sb2NhdGlvbihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKPiAgIHsKPiAgIAl1
NjQgYmFzZSA9IFJSRUczMl9TT0MxNShNTUhVQiwgMCwgbW1NQ19WTV9GQl9MT0NBVElPTl9CQVNF
KTsKPiAtCj4gLQliYXNlICY9IE1DX1ZNX0ZCX0xPQ0FUSU9OX0JBU0VfX0ZCX0JBU0VfTUFTSzsK
PiAtCWJhc2UgPDw9IDI0Owo+ICsJaWYgKGFkZXYtPmdtYy5lbmFibGVfemZiKSB7Cj4gKwkJYmFz
ZSA9IDB4RjQwMDAwMDAwMFVMTDsKPiArCX0gZWxzZSB7Cj4gKwkJYmFzZSAmPSBNQ19WTV9GQl9M
T0NBVElPTl9CQVNFX19GQl9CQVNFX01BU0s7Cj4gKwkJYmFzZSA8PD0gMjQ7Cj4gKwl9Cj4gICAK
PiAgIAlyZXR1cm4gYmFzZTsKPiAgIH0KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeAo=
