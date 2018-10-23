From: "Zhang, Jerry(Junwei)" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Reverse the sequence of ctx_mgr_fini and
 vm_fini in amdgpu_driver_postclose_kms
Date: Tue, 23 Oct 2018 10:17:05 +0800
Message-ID: <c9699397-b9e6-0473-60be-928fd9d9ba85@amd.com>
References: <1540201634-4291-1-git-send-email-Rex.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1540201634-4291-1-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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
To: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Emily.Deng-5C7GfCeVMHo@public.gmane.org

T24gMTAvMjIvMjAxOCAwNTo0NyBQTSwgUmV4IFpodSB3cm90ZToKPiBjc2EgYnVmZmVyIHdpbGwg
YmUgY3JlYXRlZCBwZXIgY3R4LCB3aGVuIGN0eCBmaW5pLAo+IHRoZSBjc2EgYnVmZmVyIGFuZCB2
YSB3aWxsIGJlIHJlbGVhc2VkLiBzbyBuZWVkIHRvCj4gZG8gY3R4X21nciBmaW4gYmVmb3JlIHZt
IGZpbmkuCj4KPiBTaWduZWQtb2ZmLWJ5OiBSZXggWmh1IDxSZXguWmh1QGFtZC5jb20+ClJldmll
d2VkLWJ5OiBKdW53ZWkgWmhhbmcgPEplcnJ5LlpoYW5nQGFtZC5jb20+Cgo+IC0tLQo+ICAgZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ttcy5jIHwgMiArLQo+ICAgMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ttcy5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2ttcy5jCj4gaW5kZXggMjdkZTg0OC4uZjJlZjlhMSAxMDA2NDQKPiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfa21zLmMKPiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfa21zLmMKPiBAQCAtMTA1NCw4ICsxMDU0LDgg
QEAgdm9pZCBhbWRncHVfZHJpdmVyX3Bvc3RjbG9zZV9rbXMoc3RydWN0IGRybV9kZXZpY2UgKmRl
diwKPiAgIAlwYXNpZCA9IGZwcml2LT52bS5wYXNpZDsKPiAgIAlwZCA9IGFtZGdwdV9ib19yZWYo
ZnByaXYtPnZtLnJvb3QuYmFzZS5ibyk7Cj4gICAKPiAtCWFtZGdwdV92bV9maW5pKGFkZXYsICZm
cHJpdi0+dm0pOwo+ICAgCWFtZGdwdV9jdHhfbWdyX2ZpbmkoJmZwcml2LT5jdHhfbWdyKTsKPiAr
CWFtZGdwdV92bV9maW5pKGFkZXYsICZmcHJpdi0+dm0pOwo+ICAgCj4gICAJaWYgKHBhc2lkKQo+
ICAgCQlhbWRncHVfcGFzaWRfZnJlZV9kZWxheWVkKHBkLT50Ym8ucmVzdiwgcGFzaWQpOwoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
