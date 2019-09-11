From: "Chen, Guchun" <Guchun.Chen-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 0/4] drm/amdgpu: add pcie bif ras query functionality
Date: Wed, 11 Sep 2019 03:21:02 +0000
Message-ID: <20190911032016.10313-1-guchun.chen@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Zhang,
 Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>, "Li, Dennis" <Dennis.Li-5C7GfCeVMHo@public.gmane.org>, "Zhou1,
 Tao" <Tao.Zhou1-5C7GfCeVMHo@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Cc: "Li, Candice" <Candice.Li-5C7GfCeVMHo@public.gmane.org>, "Chen, Guchun" <Guchun.Chen-5C7GfCeVMHo@public.gmane.org>

VGhlc2UgcGF0Y2hlcyBhcmUgaW1wbGVtZW50ZWQgZm9yIHJhcyBpbmplY3QvcXVlcnkgZXJyb3Ig
aW4gUENJRSBCSUYKYmxvY2suCgpHdWNodW4gQ2hlbiAoNCk6CiAgZHJtL2FtZGdwdTogYWRkIHJh
cyBlcnJvciBxdWVyeSBjb3VudCBpbnRlcmZhY2UgZm9yIG5iaW8KICBkcm0vYW1kZ3B1OiBzdXBw
b3J0IHBjaWUgYmlmIHJhcyBxdWVyeSBhbmQgaW5qZWN0CiAgZHJtL2FtZGdwdTogYWRkIHBjaWUg
YmlmIHJhcyByZWxhdGVkIHJlZ2lzdGVycwogIGRybS9hbWRncHU6IGltcGxlbWVudCByYXMgcXVl
cnkgZnVuY3Rpb24gZm9yIHBjaWUgYmlmCgogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X25iaW8uaCAgICAgIHwgIDIgKwogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3Jhcy5jICAgICAgIHwgIDUgKysrCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9uYmlvX3Y3
XzQuYyAgICAgICAgfCAzNiArKysrKysrKysrKysrKysrCiAuLi4vaW5jbHVkZS9hc2ljX3JlZy9u
YmlvL25iaW9fN180XzBfc21uLmggICAgfCAxMiArKysrKysKIC4uLi9pbmNsdWRlL2FzaWNfcmVn
L25iaW8vbmJpb183XzRfc2hfbWFzay5oICB8IDQzICsrKysrKysrKysrKysrKysrKysKIDUgZmls
ZXMgY2hhbmdlZCwgOTggaW5zZXJ0aW9ucygrKQoKLS0gCjIuMTcuMQoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
