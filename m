From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/4] drm/amdgpu: Support snooped PTE flag
Date: Sat, 24 Aug 2019 13:13:11 +0200
Message-ID: <f09e6893-347b-4ade-76e5-ad37d8e4e782@gmail.com>
References: <20190823213249.10749-1-Felix.Kuehling@amd.com>
 <20190823213249.10749-4-Felix.Kuehling@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190823213249.10749-4-Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
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
To: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Zeng, Oak" <Oak.Zeng-5C7GfCeVMHo@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>

QW0gMjMuMDguMTkgdW0gMjM6MzMgc2NocmllYiBLdWVobGluZywgRmVsaXg6Cj4gRnJvbTogT2Fr
IFplbmcgPE9hay5aZW5nQGFtZC5jb20+Cj4KPiBTZXQgc25vb3BlZCBQVEUgZmxhZyBhY2NvcmRp
bmcgdG8gbWFwcGluZyBmbGFnLiBXcml0ZSByZXF1ZXN0IHRvIGEKPiBwYWdlIHdpdGggc25vb3Bl
ZCBiaXQgc2V0LCB3aWxsIHNlbmQgb3V0IGludmFsaWRhdGUgcHJvYmUgcmVxdWVzdAo+IHRvIFRD
QyBvZiB0aGUgcmVtb3RlIEdQVSB3aGVyZSB0aGUgdnJhbSBwYWdlIHJlc2lkZXMuCj4KPiBDaGFu
Z2UtSWQ6IEk3OTlmNjhlYzdhNWExYWJmMzIwNzVmNWVmMzEwNTE2NDFhMGIzNzM2Cj4gU2lnbmVk
LW9mZi1ieTogT2FrIFplbmcgPE9hay5aZW5nQGFtZC5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jIHwgMyArKysKPiAgIDEgZmlsZSBjaGFuZ2VkLCAz
IGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9nbWNfdjlfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYwo+IGlu
ZGV4IDlhYWZjZGE2YzQ4OC4uOGE3YzRlYzY5YWU4IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9nbWNfdjlfMC5jCj4gQEAgLTYwNCw2ICs2MDQsOSBAQCBzdGF0aWMgdWludDY0X3QgZ21j
X3Y5XzBfZ2V0X3ZtX3B0ZV9mbGFncyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKPiAgIAlp
ZiAoZmxhZ3MgJiBBTURHUFVfVk1fUEFHRV9QUlQpCj4gICAJCXB0ZV9mbGFnIHw9IEFNREdQVV9Q
VEVfUFJUOwo+ICAgCj4gKwlpZiAoZmxhZ3MgJiBBTURHUFVfVk1fUEFHRV9JTlZBTElEQVRFX1BS
T0JFKQo+ICsJCXB0ZV9mbGFnIHw9IEFNREdQVV9QVEVfU05PT1BFRDsKPiArCgpUaGF0IGlzIHN0
aWxsIGEgTkFLIHdpdGhvdXQgZnVydGhlciBjaGVja3MuIFdlIG5lZWQgdG8gbWFrZSBhYnNvbHV0
ZWx5IApzdXJlIHRoYXQgd2UgZG9uJ3Qgc2V0IHRoaXMgd2hlbiBQQ0llIHJvdXRpbmcgaXMgaW4g
dXNlLgoKQ2hyaXN0aWFuLgoKPiAgIAlyZXR1cm4gcHRlX2ZsYWc7Cj4gICB9Cj4gICAKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
