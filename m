From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: use VCN firmware offset for cache window
Date: Fri, 19 Jul 2019 09:32:30 +0200
Message-ID: <ebd4bfbf-2c08-8a54-fba4-2a8bf347fc0f@gmail.com>
References: <20190718154616.14841-1-leo.liu@amd.com>
 <20190718154945.15004-1-leo.liu@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190718154945.15004-1-leo.liu-5C7GfCeVMHo@public.gmane.org>
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
To: "Liu, Leo" <Leo.Liu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

QW0gMTguMDcuMTkgdW0gMTc6NDkgc2NocmllYiBMaXUsIExlbzoKPiBTaW5jZSB3ZSBhcmUgdXNp
bmcgdGhlIHNpZ25lZCBGVyBub3csIGFuZCBhbHNvIHVzaW5nIFBTUCBmaXJtd2FyZSBsb2FkaW5n
LAo+IGJ1dCBpdCdzIHN0aWxsIHBvdGVudGlhbCB0byBicmVhayBkcml2ZXIgd2hlbiBsb2FkaW5n
IEZXIGRpcmVjdGx5Cj4gaW5zdGVhZCBvZiBQU1AsIHNvIHdlIHNob3VsZCBhZGQgb2Zmc2V0Lgo+
Cj4gU2lnbmVkLW9mZi1ieTogTGVvIExpdSA8bGVvLmxpdUBhbWQuY29tPgoKQWNrZWQtYnk6IENo
cmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KCj4gLS0tCj4gICBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjJfMC5jIHwgMyAtLS0KPiAgIDEgZmlsZSBjaGFu
Z2VkLCAzIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L3Zjbl92Ml8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjJfMC5j
Cj4gaW5kZXggM2NiNjJlNDQ4YTM3Li44OGUzZGVkY2Y5MjYgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvdmNuX3YyXzAuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L3Zjbl92Ml8wLmMKPiBAQCAtMzc5LDExICszNzksOCBAQCBzdGF0aWMgdm9pZCB2
Y25fdjJfMF9tY19yZXN1bWUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4gICAJCVdSRUcz
Ml9TT0MxNShVVkQsIDAsIG1tVVZEX0xNSV9WQ1BVX0NBQ0hFXzY0QklUX0JBUl9ISUdILAo+ICAg
CQkJdXBwZXJfMzJfYml0cyhhZGV2LT52Y24uaW5zdC0+Z3B1X2FkZHIpKTsKPiAgIAkJb2Zmc2V0
ID0gc2l6ZTsKPiAtCQkvKiBObyBzaWduZWQgaGVhZGVyIGZvciBub3cgZnJvbSBmaXJtd2FyZQo+
ICAgCQlXUkVHMzJfU09DMTUoVVZELCAwLCBtbVVWRF9WQ1BVX0NBQ0hFX09GRlNFVDAsCj4gICAJ
CQlBTURHUFVfVVZEX0ZJUk1XQVJFX09GRlNFVCA+PiAzKTsKPiAtCQkqLwo+IC0JCVdSRUczMl9T
T0MxNShVVkQsIDAsIG1tVVZEX1ZDUFVfQ0FDSEVfT0ZGU0VUMCwgMCk7Cj4gICAJfQo+ICAgCj4g
ICAJV1JFRzMyX1NPQzE1KFVWRCwgMCwgbW1VVkRfVkNQVV9DQUNIRV9TSVpFMCwgc2l6ZSk7Cgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
