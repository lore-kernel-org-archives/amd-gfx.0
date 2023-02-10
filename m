Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 258C3C636D4
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Feb 2023 06:35:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 951BC10E25D;
	Sat, 11 Feb 2023 06:35:09 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com
 (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF95C10E2A8
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Feb 2023 22:52:47 +0000 (UTC)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-322-_dDriQfgMmGpxT3zQV6kYQ-1; Fri, 10 Feb 2023 22:52:43 +0000
X-MC-Unique: _dDriQfgMmGpxT3zQV6kYQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.45; Fri, 10 Feb
 2023 22:52:41 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.045; Fri, 10 Feb 2023 22:52:41 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Hans de Goede' <hdegoede@redhat.com>, Orlando Chamberlain
 <orlandoch.dev@gmail.com>, "platform-driver-x86@vger.kernel.org"
 <platform-driver-x86@vger.kernel.org>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "alsa-devel@alsa-project.org"
 <alsa-devel@alsa-project.org>
Subject: RE: [RFC PATCH 1/9] apple-gmux: use cpu_to_be32 instead of manual
 reorder
Thread-Topic: [RFC PATCH 1/9] apple-gmux: use cpu_to_be32 instead of manual
 reorder
Thread-Index: AQHZPYayA1ivfjGBOEq1WtvynnRGNq7IyMig
Date: Fri, 10 Feb 2023 22:52:41 +0000
Message-ID: <6d733fa367e24462bf679b59e790ba4b@AcuMS.aculab.com>
References: <20230210044826.9834-1-orlandoch.dev@gmail.com>
 <20230210044826.9834-2-orlandoch.dev@gmail.com>
 <3af65b5e-1f52-79f6-4130-03901ce76d2f@redhat.com>
 <990b254c-b55f-539d-d6b5-fa4499078527@redhat.com>
In-Reply-To: <990b254c-b55f-539d-d6b5-fa4499078527@redhat.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Mailman-Approved-At: Sat, 11 Feb 2023 06:35:05 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>, Lijo
 Lazar <lijo.lazar@amd.com>, Rander Wang <rander.wang@intel.com>,
 YiPeng Chai <YiPeng.Chai@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 David Airlie <airlied@gmail.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Evan
 Quan <evan.quan@amd.com>, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Yong Zhi <yong.zhi@intel.com>, Aun-Ali Zaidi <admin@kodeit.net>,
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 Bokun Zhang <Bokun.Zhang@amd.com>, Mark Gross <markgross@kernel.org>,
 Kerem Karabay <kekrby@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Jack Xiao <Jack.Xiao@amd.com>, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Somalapuram
 Amaranath <Amaranath.Somalapuram@amd.com>, Takashi Iwai <tiwai@suse.com>,
 Aditya Garg <gargaditya08@live.com>, Daniel Vetter <daniel@ffwll.ch>,
 =?utf-8?B?QW1hZGV1c3ogU8WCYXdpxYRza2k=?= <amadeuszx.slawinski@linux.intel.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogSGFucyBkZSBHb2VkZQ0KPiBTZW50OiAxMCBGZWJydWFyeSAyMDIzIDE5OjMzDQo+IA0K
PiBIaSwNCj4gDQo+IE9uIDIvMTAvMjMgMjA6MDksIEhhbnMgZGUgR29lZGUgd3JvdGU6DQo+ID4g
SGksDQo+ID4NCj4gPiBPbiAyLzEwLzIzIDA1OjQ4LCBPcmxhbmRvIENoYW1iZXJsYWluIHdyb3Rl
Og0KPiA+PiBDdXJyZW50bHkgaXQgbWFudWFsbHkgZmxpcHMgdGhlIGJ5dGUgb3JkZXIsIGJ1dCB3
ZSBjYW4gaW5zdGVhZCB1c2UNCj4gPj4gY3B1X3RvX2JlMzIodmFsKSBmb3IgdGhpcy4NCj4gPj4N
Cj4gPj4gU2lnbmVkLW9mZi1ieTogT3JsYW5kbyBDaGFtYmVybGFpbiA8b3JsYW5kb2NoLmRldkBn
bWFpbC5jb20+DQo+ID4+IC0tLQ0KPiA+PiAgZHJpdmVycy9wbGF0Zm9ybS94ODYvYXBwbGUtZ211
eC5jIHwgMTggKystLS0tLS0tLS0tLS0tLS0tDQo+ID4+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNl
cnRpb25zKCspLCAxNiBkZWxldGlvbnMoLSkNCj4gPj4NCj4gPj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvcGxhdGZvcm0veDg2L2FwcGxlLWdtdXguYyBiL2RyaXZlcnMvcGxhdGZvcm0veDg2L2FwcGxl
LWdtdXguYw0KPiA+PiBpbmRleCA5MzMzZjgyY2ZhOGEuLmU4Y2IwODRjYjgxZiAxMDA2NDQNCj4g
Pj4gLS0tIGEvZHJpdmVycy9wbGF0Zm9ybS94ODYvYXBwbGUtZ211eC5jDQo+ID4+ICsrKyBiL2Ry
aXZlcnMvcGxhdGZvcm0veDg2L2FwcGxlLWdtdXguYw0KPiA+PiBAQCAtOTQsMTMgKzk0LDcgQEAg
c3RhdGljIHUzMiBnbXV4X3Bpb19yZWFkMzIoc3RydWN0IGFwcGxlX2dtdXhfZGF0YSAqZ211eF9k
YXRhLCBpbnQgcG9ydCkNCj4gPj4gIHN0YXRpYyB2b2lkIGdtdXhfcGlvX3dyaXRlMzIoc3RydWN0
IGFwcGxlX2dtdXhfZGF0YSAqZ211eF9kYXRhLCBpbnQgcG9ydCwNCj4gPj4gIAkJCSAgICAgdTMy
IHZhbCkNCj4gPj4gIHsNCj4gPj4gLQlpbnQgaTsNCj4gPj4gLQl1OCB0bXB2YWw7DQo+ID4+IC0N
Cj4gPj4gLQlmb3IgKGkgPSAwOyBpIDwgNDsgaSsrKSB7DQo+ID4+IC0JCXRtcHZhbCA9ICh2YWwg
Pj4gKGkgKiA4KSkgJiAweGZmOw0KPiA+PiAtCQlvdXRiKHRtcHZhbCwgZ211eF9kYXRhLT5pb3N0
YXJ0ICsgcG9ydCArIGkpOw0KPiA+PiAtCX0NCj4gPj4gKwlvdXRsKGNwdV90b19iZTMyKHZhbCks
IGdtdXhfZGF0YS0+aW9zdGFydCArIHBvcnQpOw0KPiA+PiAgfQ0KPiA+Pg0KPiA+PiAgc3RhdGlj
IGludCBnbXV4X2luZGV4X3dhaXRfcmVhZHkoc3RydWN0IGFwcGxlX2dtdXhfZGF0YSAqZ211eF9k
YXRhKQ0KPiA+DQo+ID4gVGhlIGlvcG9ydCAvIGluZGV4ZWQtaW9wb3J0IGFjY2Vzc2VkIGFwcGxl
X2dtdXgtZXMgbGlrZWx5IGFyZSAocGFydCBvZj8pDQo+ID4gTFBDIGJ1cyBkZXZpY2VzIC4gTG9v
a2luZyBhdCB0aGUgYnVzIGxldmVsIHlvdSBhcmUgbm93IGNoYW5naW5nIDQgaW8NCj4gPiBhY2Nl
c3NlcyB3aXRoIGEgc2l6ZSBvZiAxIGJ5dGUsIHRvIDEgMzIgYml0IGlvLWFjY2Vzcy4NCj4gDQo+
IENvcnJlY3Rpb24gdG8gbXlzZWxmLCByZS1yZWFkaW5nIHRoZSBMUEMgc3BlY2lmaWNhdGlvbiwg
dGhlbg0KPiBpZiBJJ20gcmlnaHQgYW5kIHRoaXMgaXMgYSBMUEMgZGV2aWNlIHRoZW4gYWxsIElP
IGluL291dCBhY2Nlc3Nlcw0KPiBhcmUgYWx3YXlzIDEgYnl0ZSBhY2Nlc3Nlcy4gU2luY2UgdGhl
IExQQyBidXMgb25seSBzdXBwb3J0cyAxNiAvIDMyDQo+IGJpdCBhY2Nlc3NlcyBmb3IgRE1BIGN5
Y2xlcy4NCj4gDQo+IFNvIHByZXN1bWFibHkgdGhlIG91dGwoKSB3b3VsZCBnZXQgc3BsaXQgaW50
byA0IHNlcGFyYXRlIDggYml0DQo+IChwb3J0KSBJTyBhY2Nlc3Nlcy4NCg0KSSB3b25kZXIgaWYg
dGhlcmUgaXMgc29tZXRoaW5nIG9ic2N1cmUgYW5kIHRoZSBvcmRlciBvZiB0aGUNCjQgYnl0ZXMg
d3JpdGVzIG1hdHRlcnM/DQoNCkluIGFueSBjYXNlIHdyaXRpbmcgYXM6DQoJeHh4eCBpb3N0YXJ0
ID0gZ211eF9kYXRhLT5pb3N0YXJ0ICsgcG9ydDsNCg0KCW91dGIodmFsLCBpb3N0YXJ0KTsNCglv
dXRiKHZhbCA+PiA4LCBpb3N0YXJ0ICsgMSk7DQoJb3V0Yih2YWwgPj4gMTYsIGlvc3RhcnQgKyAy
KTsNCglvdXRiKHZhbCA+PiAyNCwgaW9jdGFydCArIDMpOw0KYWxtb3N0IGNlcnRhaW5seSBnZW5l
cmF0ZXMgYmV0dGVyIGNvZGUuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFr
ZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwg
VUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

