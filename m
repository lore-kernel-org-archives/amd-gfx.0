From: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdkfd: Delete unused KFD_IS_* macro
Date: Mon, 16 Sep 2019 17:48:30 +0000
Message-ID: <a9b4c968-66f2-389b-15a0-85d65f33e7c1@amd.com>
References: <20190916163252.23684-1-Yong.Zhao@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190916163252.23684-1-Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
Content-ID: <B0CBEC3444A75947AF736EFFC98DD486-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: "Zhao, Yong" <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMjAxOS0wOS0xNiAxMjozMyBwLm0uLCBaaGFvLCBZb25nIHdyb3RlOg0KPiBUaGVzZSB3ZXJl
IGRlbGV0ZWQgYmVmb3JlLCBidXQgc29tZWhvdyBzaG93ZWQgdXAgYWdhaW4uIERlbGV0ZSB0aGVt
IGFnYWluLg0KPg0KPiBDaGFuZ2UtSWQ6IEkxOWIzMDYzOTMyMzgwY2I3NGEwMWQ1MDVlOGU5MmY4
OTdhMmMyY2I3DQo+IFNpZ25lZC1vZmYtYnk6IFlvbmcgWmhhbyA8WW9uZy5aaGFvQGFtZC5jb20+
DQoNClJldmlld2VkLWJ5OiBGZWxpeCBLdWVobGluZyA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4N
Cg0KDQo+IC0tLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcml2LmggfCA0
IC0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgNCBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcml2LmggYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGtmZC9rZmRfcHJpdi5oDQo+IGluZGV4IDA2YmIyZDdhOWIzOS4uMDc3M2RjNGRm
NGZmIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJpdi5o
DQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcml2LmgNCj4gQEAgLTE3
OSwxMCArMTc5LDYgQEAgZW51bSBjYWNoZV9wb2xpY3kgew0KPiAgIAljYWNoZV9wb2xpY3lfbm9u
Y29oZXJlbnQNCj4gICB9Ow0KPiAgIA0KPiAtI2RlZmluZSBLRkRfSVNfVkkoY2hpcCkgKChjaGlw
KSA+PSBDSElQX0NBUlJJWk8gJiYgKGNoaXApIDw9IENISVBfUE9MQVJJUzExKQ0KPiAtI2RlZmlu
ZSBLRkRfSVNfREdQVShjaGlwKSAoKChjaGlwKSA+PSBDSElQX1RPTkdBICYmIFwNCj4gLQkJCSAg
IChjaGlwKSA8PSBDSElQX05BVkkxMCkgfHwgXA0KPiAtCQkJICAgKGNoaXApID09IENISVBfSEFX
QUlJKQ0KPiAgICNkZWZpbmUgS0ZEX0lTX1NPQzE1KGNoaXApICgoY2hpcCkgPj0gQ0hJUF9WRUdB
MTApDQo+ICAgDQo+ICAgc3RydWN0IGtmZF9ldmVudF9pbnRlcnJ1cHRfY2xhc3Mgew0KX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
