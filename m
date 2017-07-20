From: "Zhang, Jerry (Junwei)" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: fix the incorrect scratch reg number on gfx v9
Date: Thu, 20 Jul 2017 10:46:32 +0800
Message-ID: <59701988.2020808@amd.com>
References: <1500517276-13243-1-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1500517276-13243-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
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
To: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

Ck9uIDA3LzIwLzIwMTcgMTA6MjEgQU0sIEh1YW5nIFJ1aSB3cm90ZToKPiBUaGVyZSBhcmUgOCBz
Y3JhdGNoIHJlZ2lzdGVycyBvbiBnZnggdjkgKHNjcmFjaF9yZWcwIC0+IHNjcmF0Y2hfcmVnNyku
CgpZZWFoLCBuaWNlIGNhdGNoLgpSZXZpZXdlZC1ieTogSnVud2VpIFpoYW5nIDxKZXJyeS5aaGFu
Z0BhbWQuY29tPgoKQWRkaXRpb25hbGx5IGl0IGxvb2tzIGluY29ycmVjdCBmcm9tIGdmeCB2NiB0
aWxsIGdmeDkuCkNvdWxkIHlvdSBmaXggdGhlbSBhbGw/CgpKZXJyeQoKPgo+IFNpZ25lZC1vZmYt
Ynk6IEh1YW5nIFJ1aSA8cmF5Lmh1YW5nQGFtZC5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jIHwgMiArLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92
OV8wLmMKPiBpbmRleCA0OGI0M2VhLi40ZDdmMDQyIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9nZnhfdjlfMC5jCj4gQEAgLTIxMSw3ICsyMTEsNyBAQCBzdGF0aWMgdm9pZCBnZnhfdjlf
MF9pbml0X2dvbGRlbl9yZWdpc3RlcnMoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4KPiAg
IHN0YXRpYyB2b2lkIGdmeF92OV8wX3NjcmF0Y2hfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldikKPiAgIHsKPiAtCWFkZXYtPmdmeC5zY3JhdGNoLm51bV9yZWcgPSA3Owo+ICsJYWRldi0+
Z2Z4LnNjcmF0Y2gubnVtX3JlZyA9IDg7Cj4gICAJYWRldi0+Z2Z4LnNjcmF0Y2gucmVnX2Jhc2Ug
PSBTT0MxNV9SRUdfT0ZGU0VUKEdDLCAwLCBtbVNDUkFUQ0hfUkVHMCk7Cj4gICAJYWRldi0+Z2Z4
LnNjcmF0Y2guZnJlZV9tYXNrID0gKDF1IDw8IGFkZXYtPmdmeC5zY3JhdGNoLm51bV9yZWcpIC0g
MTsKPiAgIH0KPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
