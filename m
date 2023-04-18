Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E921DC77B75
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Apr 2023 18:16:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AF0110E820;
	Tue, 18 Apr 2023 18:16:14 +0000 (UTC)
Received: from mail-out.aladdin-rd.ru (mail-out.aladdin-rd.ru [91.199.251.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D22D810E813;
 Tue, 18 Apr 2023 18:13:06 +0000 (UTC)
From: Daniil Dulov <D.Dulov@aladdin.ru>
To: Andi Shyti <andi.shyti@linux.intel.com>
Subject: Re: [PATCH] drm/amdkfd: Fix potential deallocation of previously
 deallocated memory.
Thread-Topic: [PATCH] drm/amdkfd: Fix potential deallocation of previously
 deallocated memory.
Thread-Index: AQHZccLCArZBbSPlkkChgaoDf69fTK8wjvMAgAAWVoCAAHM/AIAADGSAgAA6UR8=
Date: Tue, 18 Apr 2023 18:12:48 +0000
Message-ID: <PR3P193MB052467DAA1F33E3C7A128F6EF19D9@PR3P193MB0524.EURP193.PROD.OUTLOOK.COM>
References: <20230418065521.453001-1-d.dulov@aladdin.ru>
 <ZD5ZFoEk92MNQpqD@ashyti-mobl2.lan>
 <d41669a1-9e18-defb-d0cc-d43d7be7d23e@kernel.org>
 <ZD7MgL619KVYKeTV@ashyti-mobl2.lan>,<ZD7W5aaslOXLg707@ashyti-mobl2.lan>
In-Reply-To: <ZD7W5aaslOXLg707@ashyti-mobl2.lan>
Accept-Language: ru-RU, en-US
Content-Language: ru-RU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 18 Apr 2023 18:16:12 +0000
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
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
 David Airlie <airlied@linux.ie>, Felix Kuehling <Felix.Kuehling@amd.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Oak Zeng <oak.zeng@intel.com>, Krzysztof Kozlowski <krzk@kernel.org>, Alex
 Deucher <alexander.deucher@amd.com>,
 =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhhbmsgeW91IGZvciB5b3VyIGZlZWRiYWNrISBJIHdpbGwgZG8gaXQgYXMgc29vbiBhcyBwb3Nz
aWJsZS4NCg0KRGFuaWlsDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQrQntGC
OiBBbmRpIFNoeXRpIDxhbmRpLnNoeXRpQGxpbnV4LmludGVsLmNvbT4NCtCe0YLQv9GA0LDQstC7
0LXQvdC+OiDQstGC0L7RgNC90LjQuiwgMTgg0LDQv9GA0LXQu9GPIDIwMjMg0LMuLCAyMDo0NA0K
0JrQvtC80YM6IEFuZGkgU2h5dGkgPGFuZGkuc2h5dGlAbGludXguaW50ZWwuY29tPg0K0JrQvtC/
0LjRjzogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6a0BrZXJuZWwub3JnPjsgRGFuaWlsIER1bG92
IDxELkR1bG92QGFsYWRkaW4ucnU+OyBGZWxpeCBLdWVobGluZyA8RmVsaXguS3VlaGxpbmdAYW1k
LmNvbT47IGx2Yy1wcm9qZWN0QGxpbnV4dGVzdGluZy5vcmcgPGx2Yy1wcm9qZWN0QGxpbnV4dGVz
dGluZy5vcmc+OyBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+OyBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnIDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcgPGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPjsgZHJp
LWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZyA8ZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZz47IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT47IE9hayBaZW5n
IDxvYWsuemVuZ0BpbnRlbC5jb20+OyBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmln
QGFtZC5jb20+DQrQotC10LzQsDogUmU6IFtQQVRDSF0gZHJtL2FtZGtmZDogRml4IHBvdGVudGlh
bCBkZWFsbG9jYXRpb24gb2YgcHJldmlvdXNseSBkZWFsbG9jYXRlZCBtZW1vcnkuDQoNCj4gRGFu
aWlsIHdpbGwgeW91IGxvb2sgaW50byB0aGlzPw0KDQphbmQsIGJlY2F1c2UgdGhpcyBpcyBhIGJ1
ZyBmaXgsIGlmIHlvdSBkbyB3YW50IHRvIHNlbmQgYSByZWFsDQpmaXgsIHBsYXNlIGFkZCB0byB0
aGUgY29tbWl0IG1lc3NhZ2U6DQoNCkZpeGVzOiBkMWY4ZjBkMTdkNDAgKCJkcm0vYW1ka2ZkOiBN
b3ZlIG5vbi1zZG1hIG1xZCBhbGxvY2F0aW9uIG91dCBvZiBpbml0X21xZCIpDQpDYzogT2FrIFpl
bmcgPG9hay56ZW5nQGludGVsLmNvbT4NCkNjOiA8c3RhYmxlQHZnZXIua2VybmVsLm9yZz4gIyB2
NS4zKw0KDQpBbmRpDQoNClBTOiBwbGVhc2Ugbm90ZSB0aGF0IE9haydzIGUtbWFpbCBoYXMgY2hh
bmdlZC4NCg0K
