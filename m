Return-Path: <SRS0=xcSd=EJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C79DC4742C
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 08:16:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1E1E206E3
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 08:16:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1E1E206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68B486EC03;
	Tue,  3 Nov 2020 08:15:04 +0000 (UTC)
X-Greylist: delayed 305 seconds by postgrey-1.36 at gabe;
 Mon, 02 Nov 2020 22:37:08 UTC
Received: from eu-smtp-delivery-151.mimecast.com
 (eu-smtp-delivery-151.mimecast.com [207.82.80.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 889766E40C
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Nov 2020 22:37:08 +0000 (UTC)
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mtapsc-3-j6bXPPu-Nl6LRhxQXu1CQQ-1; Mon, 02 Nov 2020 22:30:46 +0000
X-MC-Unique: j6bXPPu-Nl6LRhxQXu1CQQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 2 Nov 2020 22:30:45 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000; 
 Mon, 2 Nov 2020 22:30:45 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Greg KH' <gregkh@linuxfoundation.org>, Alex Deucher
 <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amdgpu: do not initialise global variables to 0 or
 NULL
Thread-Topic: [PATCH] drm/amdgpu: do not initialise global variables to 0 or
 NULL
Thread-Index: AQHWsVQzuHsYTLqYC0GrzZhKR8oU56m1aalA
Date: Mon, 2 Nov 2020 22:30:45 +0000
Message-ID: <d415d3297e1e4475adb4e1093fea5aca@AcuMS.aculab.com>
References: <20201102184147.GA42288@localhost>
 <CADnq5_OnA3T_p4pTEOpoqQ=NZyso2VFoDiOHu=+h7dKOeKHq-A@mail.gmail.com>
 <20201102201040.GA2433494@kroah.com>
In-Reply-To: <20201102201040.GA2433494@kroah.com>
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
X-Mailman-Approved-At: Tue, 03 Nov 2020 08:15:01 +0000
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
Cc: Deepak R Varma <mh12gx2825@gmail.com>, David Airlie <airlied@linux.ie>,
 Daniel
 Vetter <daniel.vetter@ffwll.ch>, LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Melissa Wen <melissa.srw@gmail.com>, Maling list
 - DRI developers <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 =?iso-8859-1?Q?Christian_K=F6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Greg KH
> Sent: 02 November 2020 20:11
> 
> On Mon, Nov 02, 2020 at 02:43:45PM -0500, Alex Deucher wrote:
> > On Mon, Nov 2, 2020 at 1:42 PM Deepak R Varma <mh12gx2825@gmail.com> wrote:
> > >
> > > Initializing global variable to 0 or NULL is not necessary and should
> > > be avoided. Issue reported by checkpatch script as:
> > > ERROR: do not initialise globals to 0 (or NULL).
> >
> > I agree that this is technically correct, but a lot of people don't
> > seem to know that so we get a lot of comments about this code for the
> > variables that are not explicitly set.  Seems less confusing to
> > initialize them even if it not necessary.  I don't have a particularly
> > strong opinion on it however.
> 
> The kernel coding style is to do it this way.  You even save space and
> time by doing it as well :)

Uninitialised globals end up as 'named common' (variables that are
their own code section - from FORTRAN) until the final link puts
them into the .bss.
Globals initialised to 0 go into the .bss of the object file
being created.

So both end up in the final .bss.

If the code goes into a module you aren't allowed 'common' data
in a module to every global must be initialised.

I'm surprised checkpatch complains.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
