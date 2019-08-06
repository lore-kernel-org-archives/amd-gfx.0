From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: fix compile error about readq/writeq on arm
 ARCH
Date: Tue, 6 Aug 2019 15:45:44 -0400
Message-ID: <CADnq5_Pv8xqexv_gv4F1jBis2RPuTgHfr4wb39OpFR6kJF9KcQ@mail.gmail.com>
References: <20190806103156.3778-1-tao.zhou1@amd.com>
 <a19ac490-a803-84c0-5598-e78edbb3447b@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <a19ac490-a803-84c0-5598-e78edbb3447b-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: Christian Koenig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Cc: linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, kernel-build-reports-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, Tao Zhou <tao.zhou1-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linux-Next Mailing List <linux-next-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Deucher,
 Alexander" <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Dennis Li <dennis.li-5C7GfCeVMHo@public.gmane.org>, Hawking Zhang <hawking.zhang-5C7GfCeVMHo@public.gmane.org>

T24gVHVlLCBBdWcgNiwgMjAxOSBhdCA3OjI2IEFNIENocmlzdGlhbiBLw7ZuaWcKPGNrb2VuaWcu
bGVpY2h0enVtZXJrZW5AZ21haWwuY29tPiB3cm90ZToKPgo+IEFtIDA2LjA4LjE5IHVtIDEyOjMx
IHNjaHJpZWIgVGFvIFpob3U6Cj4gPiByZWFkcS93cml0ZXEgY2FuJ3QgYmUgZm91bmQgb24gYXJt
IGFyY2hpdGVjdHVyZSwgaW1wbGVtZW50IHRoZW0KPiA+IHdpdGggMzIgYml0cyBvcGVyYXRpb25z
Cj4KPiBNaG0sIHdhc24ndCB0aGUgd2hvbGUgcG9pbnQgYWJvdXQgdXNpbmcgcmVhZHEvd3JpdGVx
IHRoYXQgd2UgbmVlZGVkCj4gNjRiaXQgYXRvbWljIG9wZXJhdGlvbnM/CgpJdCBtaWdodCBiZSBi
ZXR0ZXIgdG8gdXNlIGF0b21pYzY0X3JlYWQvYXRvbWljNjRfc2V0IGxpa2Ugd2UgZG8gZm9yIGRv
b3JiZWxscy4KCkFsZXgKCj4KPiBDaHJpc3RpYW4uCj4KPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBU
YW8gWmhvdSA8dGFvLnpob3UxQGFtZC5jb20+Cj4gPiAtLS0KPiA+ICAgZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIHwgMSArCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKQo+ID4KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfZGV2aWNlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
ZGV2aWNlLmMKPiA+IGluZGV4IGY2MmQ0ZjMwZTgxMC4uYWFmN2YzMWNmOGRmIDEwMDY0NAo+ID4g
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCj4gPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKPiA+IEBAIC0yOSw2
ICsyOSw3IEBACj4gPiAgICNpbmNsdWRlIDxsaW51eC9rdGhyZWFkLmg+Cj4gPiAgICNpbmNsdWRl
IDxsaW51eC9jb25zb2xlLmg+Cj4gPiAgICNpbmNsdWRlIDxsaW51eC9zbGFiLmg+Cj4gPiArI2lu
Y2x1ZGUgPGxpbnV4L2lvLTY0LW5vbmF0b21pYy1sby1oaS5oPgo+ID4gICAjaW5jbHVkZSA8ZHJt
L2RybVAuaD4KPiA+ICAgI2luY2x1ZGUgPGRybS9kcm1fYXRvbWljX2hlbHBlci5oPgo+ID4gICAj
aW5jbHVkZSA8ZHJtL2RybV9wcm9iZV9oZWxwZXIuaD4KPgo+IF9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZng=
