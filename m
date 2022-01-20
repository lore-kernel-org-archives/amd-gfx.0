Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C29C5C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jan 2022 19:09:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0129210E1D4;
	Thu, 20 Jan 2022 19:09:58 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com
 (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E467810E7E1
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jan 2022 09:12:07 +0000 (UTC)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-19-bOMb94O0NjOs2-b-Mij-8A-1; Thu, 20 Jan 2022 09:12:03 +0000
X-MC-Unique: bOMb94O0NjOs2-b-Mij-8A-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Thu, 20 Jan 2022 09:12:00 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Thu, 20 Jan 2022 09:12:00 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Petr Mladek' <pmladek@suse.com>, Jani Nikula <jani.nikula@linux.intel.com>
Subject: RE: [PATCH 0/3] lib/string_helpers: Add a few string helpers
Thread-Topic: [PATCH 0/3] lib/string_helpers: Add a few string helpers
Thread-Index: AQHYDdkRJfmi1u3vzker6akA52hdRqxrnz8Q
Date: Thu, 20 Jan 2022 09:12:00 +0000
Message-ID: <d63b56112a2249c6b6cdce003dec4967@AcuMS.aculab.com>
References: <20220119072450.2890107-1-lucas.demarchi@intel.com>
 <YegPiR7LU8aVisMf@alley> <87tudzbykz.fsf@intel.com> <YekfbKMjOP9ecc5v@alley>
In-Reply-To: <YekfbKMjOP9ecc5v@alley>
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
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 20 Jan 2022 19:09:46 +0000
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
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rasmus
 Villemoes <linux@rasmusvillemoes.dk>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 Chris Wilson <chris@chris-wilson.co.uk>, Vishal
 Kulkarni <vishal@chelsio.com>,
 Francis Laniel <laniel_francis@privacyrequired.com>,
 Kentaro Takeda <takedakn@nttdata.co.jp>, Mikita
 Lipski <mikita.lipski@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>, Ben Skeggs <bskeggs@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Harry Wentland <harry.wentland@amd.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, Leo Li <sunpeng.li@amd.com>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
 Raju Rangoju <rajur@chelsio.com>, Lucas De Marchi <lucas.demarchi@intel.com>,
 Steven Rostedt <rostedt@goodmis.org>, Julia Lawall <julia.lawall@lip6.fr>,
 Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Eryk Brol <eryk.brol@amd.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 =?iso-8859-1?Q?Christian_K=F6nig?= <christian.koenig@amd.com>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>, Andrew
 Morton <akpm@linux-foundation.org>, "David S . Miller" <davem@davemloft.net>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

...
> Yeah, and I am sorry for bikeshedding. Honestly, I do not know what is
> better. This is why I do not want to block this series when others
> like this.
>=20
> My main motivation is to point out that:
>=20
>     enabledisable(enable)
>=20
> might be, for some people, more eye bleeding than
>=20
>     enable ? "enable" : "disable"

Indeed - you need to look the former up, wasting brain time.

> The problem is not that visible with yesno() and onoff(). But as you said=
,
> onoff() confliscts with variable names. And enabledisable() sucks.
> As a result, there is a non-trivial risk of two mass changes:
>=20
> now:
>=20
> - contition ? "yes" : "no"
> + yesno(condition)
>=20
> a few moths later:
>=20
> - yesno(condition)
> + str_yes_no(condition)

Followed by:
- str_yes_no(x)
+ no_yes_str(x)

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)

