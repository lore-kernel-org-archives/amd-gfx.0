From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH 11/11] drm: remove unused and redundant
	callbacks
Date: Thu, 22 Jun 2017 09:13:36 +0200
Message-ID: <20170622091336.3ef46ba5@bbrezillon>
References: <1497986735-14418-12-git-send-email-peda@axentia.se>
 <201706220036.6WxRju5X%fengguang.wu@intel.com>
 <20170622063755.3bfwybkotacyn4p7@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <20170622063755.3bfwybkotacyn4p7@phenom.ffwll.local>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Daniel Vetter <daniel@ffwll.ch>
Cc: kbuild-all@01.org, Gerd Hoffmann <kraxel@redhat.com>, Philippe Cornu <philippe.cornu@st.com>, nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, virtualization@lists.linux-foundation.org, Yannick Fertre <yannick.fertre@st.com>, dri-devel@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>, Alex Deucher <alexander.deucher@amd.com>, Daniel Vetter <daniel.vetter@intel.com>, Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>, Vincent Abriou <vincent.abriou@st.com>, Peter Rosin <peda@axentia.se>, Ben Skeggs <bskeggs@redhat.com>
List-Id: amd-gfx.lists.freedesktop.org

T24gVGh1LCAyMiBKdW4gMjAxNyAwODozNzo1NSArMDIwMApEYW5pZWwgVmV0dGVyIDxkYW5pZWxA
ZmZ3bGwuY2g+IHdyb3RlOgoKPiBPbiBUaHUsIEp1biAyMiwgMjAxNyBhdCAxMjozNDozNkFNICsw
ODAwLCBrYnVpbGQgdGVzdCByb2JvdCB3cm90ZToKPiA+IEhpIFBldGVyLAo+ID4gCj4gPiBbYXV0
byBidWlsZCB0ZXN0IEVSUk9SIG9uIGRybS9kcm0tbmV4dF0KPiA+IFthbHNvIGJ1aWxkIHRlc3Qg
RVJST1Igb24gbmV4dC0yMDE3MDYyMV0KPiA+IFtjYW5ub3QgYXBwbHkgdG8gdjQuMTItcmM2XQo+
ID4gW2lmIHlvdXIgcGF0Y2ggaXMgYXBwbGllZCB0byB0aGUgd3JvbmcgZ2l0IHRyZWUsIHBsZWFz
ZSBkcm9wIHVzIGEgbm90ZSB0byBoZWxwIGltcHJvdmUgdGhlIHN5c3RlbV0KPiA+IAo+ID4gdXJs
OiAgICBodHRwczovL2dpdGh1Yi5jb20vMGRheS1jaS9saW51eC9jb21taXRzL1BldGVyLVJvc2lu
L2ltcHJvdmUtdGhlLWZiX3NldGNtYXAtaGVscGVyLzIwMTcwNjIxLTIwNTQ0MQo+ID4gYmFzZTog
ICBnaXQ6Ly9wZW9wbGUuZnJlZWRlc2t0b3Aub3JnL35haXJsaWVkL2xpbnV4LmdpdCBkcm0tbmV4
dAo+ID4gY29uZmlnOiBhcm0tYWxsbW9kY29uZmlnIChhdHRhY2hlZCBhcyAuY29uZmlnKQo+ID4g
Y29tcGlsZXI6IGFybS1saW51eC1nbnVlYWJpLWdjYyAoRGViaWFuIDYuMS4xLTkpIDYuMS4xIDIw
MTYwNzA1Cj4gPiByZXByb2R1Y2U6Cj4gPiAgICAgICAgIHdnZXQgaHR0cHM6Ly9yYXcuZ2l0aHVi
dXNlcmNvbnRlbnQuY29tLzAxb3JnL2xrcC10ZXN0cy9tYXN0ZXIvc2Jpbi9tYWtlLmNyb3NzIC1P
IH4vYmluL21ha2UuY3Jvc3MKPiA+ICAgICAgICAgY2htb2QgK3ggfi9iaW4vbWFrZS5jcm9zcwo+
ID4gICAgICAgICAjIHNhdmUgdGhlIGF0dGFjaGVkIC5jb25maWcgdG8gbGludXggYnVpbGQgdHJl
ZQo+ID4gICAgICAgICBtYWtlLmNyb3NzIEFSQ0g9YXJtIAo+ID4gCj4gPiBBbGwgZXJyb3JzIChu
ZXcgb25lcyBwcmVmaXhlZCBieSA+Pik6Cj4gPiAgIAo+ID4gPj4gZHJpdmVycy9ncHUvL2RybS9h
cm1hZGEvYXJtYWRhX2ZiZGV2LmM6MTIxOjI6IGVycm9yOiB1bmtub3duIGZpZWxkICdnYW1tYV9z
ZXQnIHNwZWNpZmllZCBpbiBpbml0aWFsaXplciAgCj4gPiAgICAgIC5nYW1tYV9zZXQgPSBhcm1h
ZGFfZHJtX2NydGNfZ2FtbWFfc2V0LCAgCj4gCj4gTG9va3MgbGlrZSB5b3UndmUgbWlzc2VkIGF0
IGxlYXN0IHRoZSBhcm1hZGEgZHJpdmVyIGluIHlvdXIgY29udmVyc2lvbj8KCkFscmVhZHkgZml4
ZWQgaW4gdjIgOy0pLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpJbnRlbC1nZnggbWFpbGluZyBsaXN0CkludGVsLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9pbnRlbC1n
ZngK
