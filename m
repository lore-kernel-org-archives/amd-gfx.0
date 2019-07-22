From: "Liu, Shaoyun" <Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdkfd/kfd_mqd_manager_v10: Fix missing break in
 switch statement
Date: Mon, 22 Jul 2019 15:14:04 +0000
Message-ID: <c735a1cc-a545-50fb-44e7-c0ad93ee8ee7@amd.com>
References: <20190721225920.GA18099@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190721225920.GA18099@embeddedor>
Content-Language: en-US
Content-ID: <EF7AB8BDCFF06A40AF540B3EE9D7DA4C-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: "Gustavo A. R. Silva" <gustavo-L1vi/lXTdts+Va1GwOuvDg@public.gmane.org>, "Cox, Philip" <Philip.Cox-5C7GfCeVMHo@public.gmane.org>, Oded Gabbay <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>
Cc: "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

VGhpcyBvbmUgcHJvcGVybHkgaW4gcHVycG9zZSAsIFRoZSBtcWQgaW5pdCBmb3IgQ1AgYW5kwqAg
Q09NUFVURSB3aWxsIA0KaGF2ZSB0aGUgc2FtZcKgIHJvdXRpbmUgLg0KDQpSZWdhcmQNCg0Kc3No
YW95dW4ubGl1DQoNCk9uIDIwMTktMDctMjEgNjo1OSBwLm0uLCBHdXN0YXZvIEEuIFIuIFNpbHZh
IHdyb3RlOg0KPiBBZGQgbWlzc2luZyBicmVhayBzdGF0ZW1lbnQgaW4gb3JkZXIgdG8gcHJldmVu
dCB0aGUgY29kZSBmcm9tIGZhbGxpbmcNCj4gdGhyb3VnaCB0byBjYXNlIEtGRF9NUURfVFlQRV9D
T01QVVRFLg0KPg0KPiBUaGlzIGJ1ZyB3YXMgZm91bmQgdGhhbmtzIHRvIHRoZSBvbmdvaW5nIGVm
Zm9ydHMgdG8gZW5hYmxlDQo+IC1XaW1wbGljaXQtZmFsbHRocm91Z2guDQo+DQo+IEZpeGVzOiAx
NDMyOGFhNThjZTUgKCJkcm0vYW1ka2ZkOiBBZGQgbmF2aTEwIHN1cHBvcnQgdG8gYW1ka2ZkLiAo
djMpIikNCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU2lnbmVkLW9mZi1ieTogR3Vz
dGF2byBBLiBSLiBTaWx2YSA8Z3VzdGF2b0BlbWJlZGRlZG9yLmNvbT4NCj4gLS0tDQo+ICAgZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21xZF9tYW5hZ2VyX3YxMC5jIHwgMSArDQo+ICAg
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbXFkX21hbmFnZXJfdjEwLmMgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGtmZC9rZmRfbXFkX21hbmFnZXJfdjEwLmMNCj4gaW5kZXggNGY4YTZmZmM1Nzc1
Li4xZDhiMTNhZDQ2ZjkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2Zk
L2tmZF9tcWRfbWFuYWdlcl92MTAuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtm
ZC9rZmRfbXFkX21hbmFnZXJfdjEwLmMNCj4gQEAgLTQzMCw2ICs0MzAsNyBAQCBzdHJ1Y3QgbXFk
X21hbmFnZXIgKm1xZF9tYW5hZ2VyX2luaXRfdjEwKGVudW0gS0ZEX01RRF9UWVBFIHR5cGUsDQo+
ICAgCXN3aXRjaCAodHlwZSkgew0KPiAgIAljYXNlIEtGRF9NUURfVFlQRV9DUDoNCj4gICAJCXBy
X2RlYnVnKCIlc0AlaVxuIiwgX19mdW5jX18sIF9fTElORV9fKTsNCj4gKwkJYnJlYWs7DQo+ICAg
CWNhc2UgS0ZEX01RRF9UWVBFX0NPTVBVVEU6DQo+ICAgCQlwcl9kZWJ1ZygiJXNAJWlcbiIsIF9f
ZnVuY19fLCBfX0xJTkVfXyk7DQo+ICAgCQltcWQtPmFsbG9jYXRlX21xZCA9IGFsbG9jYXRlX21x
ZDsNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
