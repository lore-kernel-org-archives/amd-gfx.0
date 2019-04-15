From: "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: Re: [PATCH 2/9] drm/syncobj: add new drm_syncobj_add_point interface
 v4
Date: Mon, 15 Apr 2019 18:56:42 +0000
Message-ID: <01c86eb6-0e76-86c7-7437-f1d88419b4ae@amd.com>
References: <20190325083224.2983-1-david1.zhou@amd.com>
 <20190325083224.2983-2-david1.zhou@amd.com>
 <1e6783f1-8db6-47b5-2083-724257a53f84@intel.com>
 <5a435812-41f9-c2a6-d2cd-0b2ee1c76e52@gmail.com>
 <5f93be6c-5038-3409-d98d-55d50a62854c@intel.com>
 <MN2PR12MB2910AAA9FDB0E827C6D0D94DB4550@MN2PR12MB2910.namprd12.prod.outlook.com>
 <f8e0e0af-c917-af05-9aa8-cecbbfcf73f9@intel.com>
 <0674a0a5-7311-55c9-3634-2e96b89e2caa@amd.com>
 <5dd6ae07-24d4-db2b-cc3f-80150e1b0ea6@intel.com>
 <617d8c52-d394-3d99-cbd8-37ede18eb9de@amd.com>
 <CAPM=9tybViaRubzO1C=s0RtUsS=Z4bKtX40Ue0yo_hXg0UySBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <CAPM=9tybViaRubzO1C=s0RtUsS=Z4bKtX40Ue0yo_hXg0UySBw@mail.gmail.com>
Content-Language: en-US
Content-ID: <6C17AC1E34625943B66D5431956A7806@namprd12.prod.outlook.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Dave Airlie <airlied@gmail.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Hector,
 Tobias" <Tobias.Hector@amd.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "jason@jlekstrand.net" <jason@jlekstrand.net>
List-Id: amd-gfx.lists.freedesktop.org

QW0gMTUuMDQuMTkgdW0gMjA6NTQgc2NocmllYiBEYXZlIEFpcmxpZToNCj4+IFdlbGwsIEkndmUg
Z290IGNvbW1pdCByaWdodHMgYXMgd2VsbC4NCj4+DQo+PiBHb2luZyB0byByZW1vdmUgdGhlIHdh
cm5pbmcsIGFkZCB5b3VyIHJiIGFuZCBwdXNoIGV2ZXJ5dGhpbmcgaWYgbm9ib2R5DQo+PiBvYmpl
Y3RzIGluIHRoZSBuZXh0IGhvdXIgb3Igc28uDQo+IFNvIHRoaXMgZ290IGNvbW1pdHRlZCBhbmQg
aXMgaW4gbXkgLW5leHQgdHJlZSwgYnV0IHdoZXJlIGlzIHRoZQ0KPiB1c2Vyc3BhY2UgYW5kIGln
dCB0ZXN0cz8NCg0KSSB3YXMgd2FpdGluZyBmb3IgdGhpcyB0byBsYW5kIGluIC1uZXh0IGJlZm9y
ZSBwdXNoaW5nIHRoZSBsaWJkcm0gDQpjaGFuZ2VzIHdpdGggYW1kZ3B1IHRlc3QgY2FzZXMuDQoN
CkFzIHNvb24gYXMgdGhvc2UgYXJlIGNvbW1pdHRlZCBMaW9uZWwgYW5kIERhdmlkIHdhbnRlZCB0
byBjb21taXQgdGhlIGlndCANCnRlc3RzLg0KDQpDaHJpc3RpYW4uDQoNCj4NCj4gVGhlcmUgbmVl
ZHMgdG8gYmUgYSBmdW5jdGlvbmFsIG1lc2EgdXNlcnNwYWNlIGFuZCBhIHNldCBvZiBJR1RzIGZv
cg0KPiB0aGlzLCBtYXliZSBJJ3ZlIG92ZXJsb29rZWQgdGhlbSBpZiBJIGhhdmVuJ3Qgd2UgY2Fu
J3Qgc2hpcCB0aGlzLg0KPg0KPiBEYXZlLg0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9kcmktZGV2ZWw=
