Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6953EC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jun 2022 21:48:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC147112545;
	Thu, 16 Jun 2022 21:48:34 +0000 (UTC)
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [IPv6:2a01:e0c:1:1599::12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31A65112557
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jun 2022 21:48:33 +0000 (UTC)
Received: from zimbra39-e7.priv.proxad.net (unknown [172.20.243.189])
 by smtp3-g21.free.fr (Postfix) with ESMTP id 8F6A913F879;
 Thu, 16 Jun 2022 23:48:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1655416110;
 bh=WHZVWdtt19bC4lqUQCxIZnfI4d6UvFFVJw6i2+Hsw4g=;
 h=Date:From:To:Cc:In-Reply-To:Subject:From;
 b=bm8om60OWybuDEp6X50CUwyzIx5Wex1IfK0AdqPmUHuhGqcj7FqBJFYJyjSphLRqf
 cOhi3PT4/3X6fR5cK1THc/epzsIlTKuh5ZKrfliroN7BArQpCgFhgV4Geg9/4X/wff
 oSLRWSu4kf556TQ1gqfIUquEl7BUFBaZ4C6z8eimQ0We3zsxOmYWkuooB9P7tmR3Is
 W3aUY+SfIUi0j+NFoLE6aaL6i2ngN7dQ8PF6aPE6TNJHuiYsFm4EDJg2sDCF02XW08
 QTwfezq/fUbf9AiUIurVpv/VIUS7nNARDntcHw1OtSUlhRRQLcidFKdyqo5lMb7SLa
 ifR/8HmnD4XPQ==
Date: Thu, 16 Jun 2022 23:48:30 +0200 (CEST)
From: Yann Dirson <ydirson@free.fr>
To: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
Message-ID: <1600846598.614955318.1655416110530.JavaMail.root@zimbra39-e7>
In-Reply-To: <629ce27f-2e51-0ef5-8965-06655bd1cacc@amd.com>
Subject: Re: [PATCH 1/3] Documentation/gpu: Add info table for ASICs
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [88.120.44.86]
X-Mailer: Zimbra 7.2.0-GA2598 (ZimbraWebClient - FF3.0 (Linux)/7.2.0-GA2598)
X-Authenticated-User: ydirson@free.fr
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
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Mark Yacoub <markyacoub@chromium.org>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Michel =?utf-8?Q?D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
 Alex Hung <alex.hung@amd.com>, Simon Ser <contact@emersion.fr>,
 amd-gfx@lists.freedesktop.org, maira canal <maira.canal@usp.br>,
 mwen@igalia.com, Leo Li <sunpeng.li@amd.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, Hersen Wu <hersenxs.wu@amd.com>,
 tales aparecida <tales.aparecida@gmail.com>, Sean Paul <seanpaul@chromium.org>,
 isabbasso@riseup.net, andrealmeid@riseup.net,
 Harry Wentland <harry.wentland@amd.com>,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 Pierre-Loup <pgriffais@valvesoftware.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


> 
> On 2022-06-15 10:34, Yann Dirson wrote:
> > Nice!
> > 
> >> diff --git a/Documentation/gpu/amdgpu/apu-asic-info-table.csv
> >> b/Documentation/gpu/amdgpu/apu-asic-info-table.csv
> > ...
> >> +Ryzen 3000 series / AMD Ryzen Embedded V1*/R1* with Radeon Vega
> >> Gfx,
> >> RAVEN/PICASSO, DCN 1.0, 9.1.0, VCN 1.0, 4.1.0
> > ...
> >> +Ryzen 3000 series / AMD Ryzen Embedded V1*/R1* with Radeon Vega
> >> Gfx,
> >> RAVEN2, DCN 1.0, 9.2.2, VCN 1.0.1, 4.1.1
> > 
> > Those similar-but-not-quite lines tend to confuse me :)
> 
> I guess it will be easier to visualize this data after build the
> kernel doc since the csv file will became an html table.

Possibly, though my surprise is rather that 2 different lines in the
table have the same label in their first cell.  Do RAVEN/PICASSO and
RAVEN2 really share the same product name despite different hardware
blocks ?
