From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amd/display/amdgpu_dm/amdgpu_dm.c: Remove duplicate
 header
Date: Wed, 21 Nov 2018 15:06:01 -0500
Message-ID: <CADnq5_NdkoPuXzJZ=2x0nO5Rfd5BnXgCg5j1+wDF=bUGaatQzQ@mail.gmail.com>
References: <20181121120913.GA2289@hp-pavilion-15-notebook-pc-brajeswar>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20181121120913.GA2289@hp-pavilion-15-notebook-pc-brajeswar>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: brajeswar.linux@gmail.com
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>, Sabyasachi Gupta <sabyasachi.linux@gmail.com>, "Leo (Sunpeng) Li" <sunpeng.li@amd.com>, "Cheng, Tony" <Tony.Cheng@amd.com>, David Francis <David.Francis@amd.com>, LKML <linux-kernel@vger.kernel.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, "S,
 Shirish" <shirish.s@amd.com>, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, Dave Airlie <airlied@linux.ie>, Souptick Joarder <jrdr.linux@gmail.com>, "Deucher, Alexander" <alexander.deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, Anthony.Koo@amd.com
List-Id: amd-gfx.lists.freedesktop.org

QXBwbGllZC4gIHRoYW5rcyEKT24gV2VkLCBOb3YgMjEsIDIwMTggYXQgOToyNSBBTSBCcmFqZXN3
YXIgR2hvc2gKPGJyYWplc3dhci5saW51eEBnbWFpbC5jb20+IHdyb3RlOgo+Cj4gUmVtb3ZlIGRt
X3NlcnZpY2VzX3R5cGVzLmggd2hpY2ggaXMgaW5jbHVkZWQgbW9yZSB0aGFuIG9uY2UKPgo+IFNp
Z25lZC1vZmYtYnk6IEJyYWplc3dhciBHaG9zaCA8YnJhamVzd2FyLmxpbnV4QGdtYWlsLmNvbT4K
PiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0u
YyB8IDEgLQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jCj4gaW5kZXggZTIy
NGYyM2UyMjE1Li42MmE5NmM2ODM1ODQgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKPiBAQCAtMzgsNyArMzgsNiBAQAo+ICAj
aW5jbHVkZSAiYW1kX3NoYXJlZC5oIgo+ICAjaW5jbHVkZSAiYW1kZ3B1X2RtX2lycS5oIgo+ICAj
aW5jbHVkZSAiZG1faGVscGVycy5oIgo+IC0jaW5jbHVkZSAiZG1fc2VydmljZXNfdHlwZXMuaCIK
PiAgI2luY2x1ZGUgImFtZGdwdV9kbV9tc3RfdHlwZXMuaCIKPiAgI2lmIGRlZmluZWQoQ09ORklH
X0RFQlVHX0ZTKQo+ICAjaW5jbHVkZSAiYW1kZ3B1X2RtX2RlYnVnZnMuaCIKPiAtLQo+IDIuMTcu
MQo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBh
bWQtZ2Z4IG1haWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWls
aW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
