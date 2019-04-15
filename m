From: Dave Airlie <airlied@gmail.com>
Subject: Re: [PATCH 2/9] drm/syncobj: add new drm_syncobj_add_point interface
 v4
Date: Tue, 16 Apr 2019 04:54:38 +1000
Message-ID: <CAPM=9tybViaRubzO1C=s0RtUsS=Z4bKtX40Ue0yo_hXg0UySBw@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <617d8c52-d394-3d99-cbd8-37ede18eb9de@amd.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: "Koenig, Christian" <Christian.Koenig@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Hector,
 Tobias" <Tobias.Hector@amd.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "jason@jlekstrand.net" <jason@jlekstrand.net>
List-Id: amd-gfx.lists.freedesktop.org

PiBXZWxsLCBJJ3ZlIGdvdCBjb21taXQgcmlnaHRzIGFzIHdlbGwuCj4KPiBHb2luZyB0byByZW1v
dmUgdGhlIHdhcm5pbmcsIGFkZCB5b3VyIHJiIGFuZCBwdXNoIGV2ZXJ5dGhpbmcgaWYgbm9ib2R5
Cj4gb2JqZWN0cyBpbiB0aGUgbmV4dCBob3VyIG9yIHNvLgoKU28gdGhpcyBnb3QgY29tbWl0dGVk
IGFuZCBpcyBpbiBteSAtbmV4dCB0cmVlLCBidXQgd2hlcmUgaXMgdGhlCnVzZXJzcGFjZSBhbmQg
aWd0IHRlc3RzPwoKVGhlcmUgbmVlZHMgdG8gYmUgYSBmdW5jdGlvbmFsIG1lc2EgdXNlcnNwYWNl
IGFuZCBhIHNldCBvZiBJR1RzIGZvcgp0aGlzLCBtYXliZSBJJ3ZlIG92ZXJsb29rZWQgdGhlbSBp
ZiBJIGhhdmVuJ3Qgd2UgY2FuJ3Qgc2hpcCB0aGlzLgoKRGF2ZS4KX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmkt
ZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs
