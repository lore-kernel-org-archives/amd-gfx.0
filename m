From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amd/display/i2c_hw_engine_dce110: Remove duplicate
 header
Date: Thu, 20 Dec 2018 11:56:11 -0500
Message-ID: <CADnq5_MGmr0Zi+QB_ha2CrEq+SF=TM17wzu9=q-RDZa_RmMuEQ@mail.gmail.com>
References: <20181220123455.GA24952@hp-pavilion-15-notebook-pc-brajeswar>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20181220123455.GA24952@hp-pavilion-15-notebook-pc-brajeswar>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Brajeswar Ghosh <brajeswar.linux@gmail.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>, Charlene Liu <charlene.liu@amd.com>, "Leo (Sunpeng) Li" <sunpeng.li@amd.com>, "Cheng, Tony" <Tony.Cheng@amd.com>, Sabyasachi Gupta <sabyasachi.linux@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, Dave Airlie <airlied@linux.ie>, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Souptick Joarder <jrdr.linux@gmail.com>, "Deucher,
 Alexander" <alexander.deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

T24gVGh1LCBEZWMgMjAsIDIwMTggYXQgOTozNiBBTSBCcmFqZXN3YXIgR2hvc2gKPGJyYWplc3dh
ci5saW51eEBnbWFpbC5jb20+IHdyb3RlOgo+Cj4gUmVtb3ZlIHJlZ19oZWxwZXIuaCB3aGljaCBp
cyBpbmNsdWRlZCBtb3JlIHRoYW4gb25jZQo+Cj4gU2lnbmVkLW9mZi1ieTogQnJhamVzd2FyIEdo
b3NoIDxicmFqZXN3YXIubGludXhAZ21haWwuY29tPgoKQXBwbGllZC4gIHRoYW5rcyEKCkFsZXgK
Cj4gLS0tCj4gIC4uLi9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2kyY2F1eC9kY2UxMTAvaTJjX2h3
X2VuZ2luZV9kY2UxMTAuYyAgfCAxIC0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgZGVsZXRpb24oLSkK
Pgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvaTJjYXV4L2Rj
ZTExMC9pMmNfaHdfZW5naW5lX2RjZTExMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2RjL2kyY2F1eC9kY2UxMTAvaTJjX2h3X2VuZ2luZV9kY2UxMTAuYwo+IGluZGV4IDljYmUxYTdh
NmJjYi4uMTM3MzUwMTQyZmIyIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlz
cGxheS9kYy9pMmNhdXgvZGNlMTEwL2kyY19od19lbmdpbmVfZGNlMTEwLmMKPiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvaTJjYXV4L2RjZTExMC9pMmNfaHdfZW5naW5lX2Rj
ZTExMC5jCj4gQEAgLTk3LDcgKzk3LDYgQEAgZW51bSBkY19pMmNfYXJiaXRyYXRpb24gewo+ICAj
ZGVmaW5lIEZOKHJlZ19uYW1lLCBmaWVsZF9uYW1lKSBcCj4gICAgICAgICBod19lbmdpbmUtPmky
Y19zaGlmdC0+ZmllbGRfbmFtZSwgaHdfZW5naW5lLT5pMmNfbWFzay0+ZmllbGRfbmFtZQo+Cj4g
LSNpbmNsdWRlICJyZWdfaGVscGVyLmgiCj4KPiAgc3RhdGljIHZvaWQgZGlzYWJsZV9pMmNfaHdf
ZW5naW5lKAo+ICAgICAgICAgc3RydWN0IGkyY19od19lbmdpbmVfZGNlMTEwICpod19lbmdpbmUp
Cj4gLS0KPiAyLjE3LjEKPgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpk
cmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
