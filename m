Return-Path: <SRS0=ENO8=65=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 641A2C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2020 15:48:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BF6820758
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2020 15:48:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BF6820758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E978E6ECDA;
	Fri, 15 May 2020 15:48:28 +0000 (UTC)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2855E6ECB2;
 Fri, 15 May 2020 14:15:21 +0000 (UTC)
IronPort-SDR: UG6p7PsUknkABRbwbnrzbZWRSSJw/NFP6d9ox2OAjQT3928uSIem6emtg2ypdWXYZw0AeAFBXY
 N5unSe71Q88w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2020 07:15:18 -0700
IronPort-SDR: 48D8D6N9ITJ1eakIQgSIO1hwzcC1TUMSkWaxxUqccg2fR2o9qv+mtbdlOzwHvDnYskMOhjBmm9
 Yad1wTimal7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,395,1583222400"; d="scan'208";a="252388052"
Received: from irsmsx154.ger.corp.intel.com ([163.33.192.96])
 by fmsmga007.fm.intel.com with ESMTP; 15 May 2020 07:15:11 -0700
Received: from irsmsx602.ger.corp.intel.com (163.33.146.8) by
 IRSMSX154.ger.corp.intel.com (163.33.192.96) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 15 May 2020 15:15:10 +0100
Received: from irsmsx601.ger.corp.intel.com (163.33.146.7) by
 irsmsx602.ger.corp.intel.com (163.33.146.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 15 May 2020 15:15:10 +0100
Received: from irsmsx601.ger.corp.intel.com ([163.33.146.7]) by
 irsmsx601.ger.corp.intel.com ([163.33.146.7]) with mapi id 15.01.1713.004;
 Fri, 15 May 2020 15:15:10 +0100
From: "Szwichtenberg, Radoslaw" <radoslaw.szwichtenberg@intel.com>
To: "events@lists.x.org" <events@lists.x.org>,
 "xorg-devel@lists.freedesktop.org" <xorg-devel@lists.freedesktop.org>,
 "wayland-devel@lists.freedesktop.org" <wayland-devel@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "mesa-dev@lists.freedesktop.org" <mesa-dev@lists.freedesktop.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "etnaviv@lists.freedesktop.org" <etnaviv@lists.freedesktop.org>,
 "freedreno@lists.freedesktop.org" <freedreno@lists.freedesktop.org>,
 "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
Subject: XDC 2020: Registration & Call for Proposals now open!
Thread-Topic: XDC 2020: Registration & Call for Proposals now open!
Thread-Index: AdYqwkf6xuypRettR8CslFMm+spI/w==
Date: Fri, 15 May 2020 14:15:10 +0000
Message-ID: <9a4392829de747a9a752a5b13f31f90b@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: no-action
x-originating-ip: [163.33.253.164]
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 15 May 2020 15:48:27 +0000
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
Cc: "board@foundation.x.org" <board@foundation.x.org>
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hello!

Registration & Call for Proposals are now open for XDC 2020, which will
take place at the Gda=F1sk University of Technology in Gda=F1sk, Poland on =
September 16-18, 2020.

Thanks to LWN.net for hosting the website again this year!

    https://xdc2020.x.org
    =

As usual, the conference is free of charge and open to the general public. =
If you plan on attending, please make sure to register as early as possible=
! However, don't book any travel or hotel until the organization decides if=
 we keep the conference as it is or there is any change. Please read this m=
essage on the website for more information:

https://xdc2020.x.org/event/9/page/78-covid-19

In order to register as attendee, you will therefore need to register via t=
he XDC
website. However, as XDC is sharing the same Indico infrastructure as
LPC, if you previously registered on the LPC website
(linuxplumbersconference.org) or on the XDC 2019 website (xdc2019.x.org), t=
hen you already have an active account
and can use the same username & password to login!

    https://xdc2020.x.org/event/9/registrations/7/

In addition to registration, the CfP is now open for talks, workshops
and demos at XDC 2020. While any serious proposal will be gratefully
considered, topics of interest to X.Org and freedesktop.org developers
are encouraged. The program focus is on new development, ongoing
challenges and anything else that will spark discussions among
attendees in the hallway track.

We are open to talks across all layers of the graphics stack, from the
kernel to desktop environments / graphical applications and about how
to make things better for the developers who build them. Head to the
CfP page to learn more: =


    https://xdc2020.x.org/event/9/abstracts/

The deadline for submissions is Sunday, 5 July 2020.

Notice that the event may end up being postponed, converted to a fully onli=
ne conference, or even a hybrid one (physical event + some remote talks). I=
t depends on how COVID-19 situation evolves in the different countries and =
the restrictions we will have at that time.
Also, some people may decide to skip the physical conference to avoid any r=
isk of infection. Because of that, please indicate in your talk submission =
if you prefer to give a remote talk in the case that XDC keeps being a phys=
ical event this year. Similarly, if you think that your talk makes no sense=
 if XDC ends up being a fully-virtual conference, please indicate that in t=
he notes of the talk submission.

If COVID-19 situation allows it, we are looking forward to seeing you in Gd=
a=F1sk! If you have any questions, please send me an email to radoslaw.szwi=
chtenberg@intel.com,  adding on CC the X.org board (board at foundation.x.o=
rg).

And don't forget, you can follow us on Twitter for all the latest
updates and to stay connected:

    https://twitter.com/xdc2020

Best,

Radek


_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
