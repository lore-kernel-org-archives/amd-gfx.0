Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 549E0C433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jan 2022 16:45:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CDFD10E408;
	Wed, 19 Jan 2022 16:45:44 +0000 (UTC)
X-Greylist: delayed 491 seconds by postgrey-1.36 at gabe;
 Wed, 19 Jan 2022 16:45:16 UTC
Received: from eu-smtp-delivery-151.mimecast.com
 (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1C5810E3E9
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jan 2022 16:45:16 +0000 (UTC)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-72-jhIrFXPuMueVJc9IEo4ZMw-1; Wed, 19 Jan 2022 16:38:28 +0000
X-MC-Unique: jhIrFXPuMueVJc9IEo4ZMw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Wed, 19 Jan 2022 16:38:26 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Wed, 19 Jan 2022 16:38:26 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: David Laight <David.Laight@ACULAB.COM>, 'Steven Rostedt'
 <rostedt@goodmis.org>, Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: RE: [PATCH 1/3] lib/string_helpers: Consolidate yesno() implementation
Thread-Topic: [PATCH 1/3] lib/string_helpers: Consolidate yesno()
 implementation
Thread-Index: AQHYDUVmV8sHy8JfXU2yTPkp1VbmK6xqitzAgAAAVLA=
Date: Wed, 19 Jan 2022 16:38:26 +0000
Message-ID: <9c26ca9bf75d494ea966059d9bcbc2b5@AcuMS.aculab.com>
References: <20220119072450.2890107-1-lucas.demarchi@intel.com>
 <20220119072450.2890107-2-lucas.demarchi@intel.com>
 <CAHp75Vf5QOD_UtDK8VbxNApEBuJvzUic0NkzDNmRo3Q7Ud+=qw@mail.gmail.com>
 <20220119100102.61f9bfde@gandalf.local.home>
 <06420a70f4434c2b8590cc89cad0dd6a@AcuMS.aculab.com>
In-Reply-To: <06420a70f4434c2b8590cc89cad0dd6a@AcuMS.aculab.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Mailman-Approved-At: Wed, 19 Jan 2022 16:45:43 +0000
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
Cc: Emma Anholt <emma@anholt.net>, David Airlie <airlied@linux.ie>,
 "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 Chris Wilson <chris@chris-wilson.co.uk>, Vishal Kulkarni <vishal@chelsio.com>,
 Francis Laniel <laniel_francis@privacyrequired.com>,
 Kentaro Takeda <takedakn@nttdata.co.jp>, Mikita Lipski <mikita.lipski@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Ben Skeggs <bskeggs@redhat.com>, Jakub
 Kicinski <kuba@kernel.org>, Harry Wentland <harry.wentland@amd.com>,
 Petr Mladek <pmladek@suse.com>, Sakari Ailus <sakari.ailus@linux.intel.com>,
 Leo Li <sunpeng.li@amd.com>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, Raju
 Rangoju <rajur@chelsio.com>, Lucas De Marchi <lucas.demarchi@intel.com>,
 Jani Nikula <jani.nikula@linux.intel.com>, Julia Lawall <julia.lawall@lip6.fr>,
 Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Eryk Brol <eryk.brol@amd.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>, Andrew
 Morton <akpm@linux-foundation.org>, "David S . Miller" <davem@davemloft.net>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

PiA+ID4gPiArc3RhdGljIGlubGluZSBjb25zdCBjaGFyICp5ZXNubyhib29sIHYpIHsgcmV0dXJu
IHYgPyAieWVzIiA6ICJubyI7IH0NCj4gDQo+IAlyZXR1cm4gInllc1wwbm8iICsgdiAqIDQ7DQo+
IA0KPiA6LSkNCg0KZXhjZXB0ICcibm9cMFwweWVzIiArIHYgKiA0JyB3b3JrcyBhIGJpdCBiZXR0
ZXIuDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3Vu
dCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3
Mzg2IChXYWxlcykNCg==

