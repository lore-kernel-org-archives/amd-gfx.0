From: "Wentland, Harry" <Harry.Wentland@amd.com>
Subject: Re: [PATCH] drm/amd/display: Fix boolean expression in
 get_surf_rq_param
Date: Thu, 3 Jan 2019 21:11:21 +0000
Message-ID: <8169baae-434e-2d08-d63f-a285d1c3457e@amd.com>
References: <20190103194845.GA26175@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20190103194845.GA26175@embeddedor>
Content-Language: en-US
Content-ID: <C4E77005B6479441AD2D4820BF97ABCF@namprd12.prod.outlook.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, "Laktyushkin, Dmytro" <Dmytro.Laktyushkin@amd.com>, "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhou, David(ChunMing)" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

T24gMjAxOS0wMS0wMyAyOjQ4IHAubS4sIEd1c3Rhdm8gQS4gUi4gU2lsdmEgd3JvdGU6DQo+IEZp
eCBib29sZWFuIGV4cHJlc3Npb24gYnkgdXNpbmcgbG9naWNhbCBBTkQgb3BlcmF0b3IgJyYmJw0K
PiBpbnN0ZWFkIG9mIGJpdHdpc2Ugb3BlcmF0b3IgJyYnLg0KPiANCj4gVGhpcyBpc3N1ZSB3YXMg
ZGV0ZWN0ZWQgd2l0aCB0aGUgaGVscCBvZiBDb2NjaW5lbGxlLg0KPiANCj4gRml4ZXM6IDZkMDRl
ZTlkYzEwMSAoImRybS9hbWQvZGlzcGxheTogUmVzdHJ1Y3R1cmluZyBhbmQgY2xlYW5pbmcgdXAg
RE1MIikNCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU2lnbmVkLW9mZi1ieTogR3Vz
dGF2byBBLiBSLiBTaWx2YSA8Z3VzdGF2b0BlbWJlZGRlZG9yLmNvbT4NCg0KUmV2aWV3ZWQtYnk6
IEhhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPg0KDQphbmQgYXBwbGllZC4N
Cg0KSGFycnkNCg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kbWwv
ZG1sMV9kaXNwbGF5X3JxX2RsZ19jYWxjLmMgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvZGMvZG1sL2RtbDFfZGlzcGxheV9ycV9kbGdfY2FsYy5jIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RtbC9kbWwxX2Rpc3BsYXlfcnFfZGxnX2NhbGMu
Yw0KPiBpbmRleCBjMjAzN2RhYThlNjYuLmQzNDFiNjlmZGMxYSAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RtbC9kbWwxX2Rpc3BsYXlfcnFfZGxnX2NhbGMu
Yw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZG1sL2RtbDFfZGlzcGxh
eV9ycV9kbGdfY2FsYy5jDQo+IEBAIC04ODEsNyArODgxLDcgQEAgc3RhdGljIHZvaWQgZ2V0X3N1
cmZfcnFfcGFyYW0oDQo+ICAJLyogdGhlIGRwdGVfZ3JvdXBfYnl0ZXMgaXMgcmVkdWNlZCBmb3Ig
dGhlIHNwZWNpZmljIGNhc2Ugb2YgdmVydGljYWwNCj4gIAkgKiBhY2Nlc3Mgb2YgYSB0aWxlIHN1
cmZhY2UgdGhhdCBoYXMgZHB0ZSByZXF1ZXN0IG9mIDh4MSBwdGVzLg0KPiAgCSAqLw0KPiAtCWlm
ICghc3VyZl9saW5lYXIgJiAobG9nMl9kcHRlX3JlcV9oZWlnaHRfcHRlcyA9PSAwKSAmIHN1cmZf
dmVydCkgLypyZWR1Y2VkLCBpbiB0aGlzIGNhc2UsIHdpbGwgaGF2ZSBwYWdlIGZhdWx0IHdpdGhp
biBhIGdyb3VwICovDQo+ICsJaWYgKCFzdXJmX2xpbmVhciAmJiAobG9nMl9kcHRlX3JlcV9oZWln
aHRfcHRlcyA9PSAwKSAmJiBzdXJmX3ZlcnQpIC8qcmVkdWNlZCwgaW4gdGhpcyBjYXNlLCB3aWxs
IGhhdmUgcGFnZSBmYXVsdCB3aXRoaW4gYSBncm91cCAqLw0KPiAgCQlycV9zaXppbmdfcGFyYW0t
PmRwdGVfZ3JvdXBfYnl0ZXMgPSA1MTI7DQo+ICAJZWxzZQ0KPiAgCQkvKmZ1bGwgc2l6ZSAqLw0K
PiANCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1k
ZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
