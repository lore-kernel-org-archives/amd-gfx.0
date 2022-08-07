Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1C0FC00140
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Aug 2022 07:11:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF34490748;
	Mon,  8 Aug 2022 07:11:18 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com
 (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7CE510E763
 for <amd-gfx@lists.freedesktop.org>; Sun,  7 Aug 2022 17:36:52 +0000 (UTC)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-82-FauLCPYfM4KoA62FKx-nlw-1; Sun, 07 Aug 2022 18:36:49 +0100
X-MC-Unique: FauLCPYfM4KoA62FKx-nlw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Sun, 7 Aug 2022 18:36:48 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Sun, 7 Aug 2022 18:36:48 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Arnd Bergmann' <arnd@kernel.org>, Nathan Chancellor <nathan@kernel.org>
Subject: RE: mainline build failure for x86_64 allmodconfig with clang
Thread-Topic: mainline build failure for x86_64 allmodconfig with clang
Thread-Index: AQHYqQIPfwGtm9+LUkavntQYoCiIfK2jthGw
Date: Sun, 7 Aug 2022 17:36:48 +0000
Message-ID: <cb3ea155c4e149eca30ca870e3f2546d@AcuMS.aculab.com>
References: <YuwRyQYPCb1FD+mr@debian>
 <CAHk-=whptVSSZL=wSUQJdRBeVfS+Xy_K4anQ7eQOky7XUrXhUQ@mail.gmail.com>
 <CAK8P3a2bEaExue0OtNeLa2CVzBx-1dE9w2HZ2PAV5N8Ct9G=JQ@mail.gmail.com>
 <YuwvfsztWaHvquwC@dev-arch.thelio-3990X>
 <9fb73284-7572-5703-93d3-f83a43535baf@amd.com>
 <CAK8P3a3Fv=_+GV9r=k4jP72zZOjJowL-GOue-51EhyVDBaEfEw@mail.gmail.com>
 <Yu1bMqL5tsbq1ojj@dev-arch.thelio-3990X>
 <CAK8P3a3PAxkctN6AXOsoTBTFgwHhk7_OSYwJ4Rgk7Dbs+bc0Qw@mail.gmail.com>
In-Reply-To: <CAK8P3a3PAxkctN6AXOsoTBTFgwHhk7_OSYwJ4Rgk7Dbs+bc0Qw@mail.gmail.com>
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
X-Mailman-Approved-At: Mon, 08 Aug 2022 07:11:16 +0000
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
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>, David
 Airlie <airlied@linux.ie>, Linus Torvalds <torvalds@linux-foundation.org>,
 clang-built-linux <llvm@lists.linux.dev>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 "Sudip Mukherjee \(Codethink\)" <sudipm.mukherjee@gmail.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogQXJuZCBCZXJnbWFubg0KPiBTZW50OiAwNSBBdWd1c3QgMjAyMiAyMDozMg0KLi4uDQo+
IE9uZSB0aGluZyB0byB0cnkgd291bGQgYmUgdG8gY29uZGVuc2UgYSBmdW5jdGlvbiBjYWxsIGxp
a2UNCj4gDQo+ICAgICAgICAgICAgICAgICBkbWwzMl9DYWxjdWxhdGVXYXRlcm1hcmtzTUFMTFVz
ZUFuZERSQU1TcGVlZENoYW5nZVN1cHBvcnQoDQo+IA0KLi4uDQo+ICAgICAgICAgICAgICAgICAg
ICAgICAgIC4uLi4gLyogbW9yZSBhcmd1bWVudHMgKi8pOw0KPiANCj4gaW50byBjYWxsaW5nIGNv
bnZlbnRpb25zIHRoYXQgdGFrZSBhIHBvaW50ZXIgdG8gJ21vZGVfbGliLT52YmEnIGFuZCBhbm90
aGVyDQo+IG9uZSB0byAndicsIHNvIHRoZXNlIGFyZSBubyBsb25nZXIgcGFzc2VkIG9uIHRoZSBz
dGFjayBpbmRpdmlkdWFsbHkuDQoNCk9yLCBpZiBpdCBpcyBvbmx5IGNhbGxlZCBvbmNlIChJIGNh
bid0IGZpbmQgdGhlIHNvdXJjZSkNCmZvcmNlIGl0IHRvIGJlIGlubGluZWQuDQoNCk9yIGp1c3Qg
c2hvb3QgdGhlIHNvZnR3YXJlIGVuZ2luZWVyIHdobyB0aGlua3MgMTAwIGFyZ3VtZW50cw0KaXMg
c2FuZS4gOi0pDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJy
YW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lz
dHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

