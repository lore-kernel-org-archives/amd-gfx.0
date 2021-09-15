Return-Path: <SRS0=hzS6=OF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA03AC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Sep 2021 16:12:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 340A560F38
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Sep 2021 16:12:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 340A560F38
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jcline.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 799E86E976;
	Wed, 15 Sep 2021 16:12:29 +0000 (UTC)
X-Greylist: delayed 565 seconds by postgrey-1.36 at gabe;
 Wed, 15 Sep 2021 16:00:25 UTC
Received: from a8-61.smtp-out.amazonses.com (a8-61.smtp-out.amazonses.com
 [54.240.8.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F2666E972;
 Wed, 15 Sep 2021 16:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=jdcmspyxk3papgv75oy2heb62hybqlxr; d=jcline.org; t=1631721059;
 h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:Content-Type:MIME-Version:Content-Transfer-Encoding;
 bh=6cZlNTQVzgnWdijsvjqjYm5Rce0lZ5PkihJv1QJEl2s=;
 b=ES9/cjo8snKAOa36wdqVSXhWYoPfrhlJsMIlt+y5wIe7lyE455BXRcBzUHt5es9j
 QOfd9EeDvjmqaqjvujPjJWJZwHX/+6mg2Ef/wZZmQ4kPDSDrHC9eZF7zq4JFJ49rc8s
 9JDW2ass0M5nefQgH21a32YnFz4gA54cw9HpHFlM=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1631721059;
 h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:Content-Type:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
 bh=6cZlNTQVzgnWdijsvjqjYm5Rce0lZ5PkihJv1QJEl2s=;
 b=IGyNmfHUu4VEl2JW6Luzr38O0ZA/AuOzt74aTB84CND22Q1ADZuara9dbZOLRDu2
 aQVTfsWeEuTBkvfBDWVkpX+tZz5IUhZ+SEBBnRGLWNhP7YI2a51Z3A13GOtf/YtpLkf
 SC8gEJzIQvoKTX6Ifvc1Dugq5fcj94BNqm0pJjkw=
Message-ID: <0100017bea276ec1-3b320d5b-3997-4024-8339-0f39f90ee991-000000@email.amazonses.com>
Subject: Re: [RFC PATCH v3 1/6] drm/doc: Color Management and HDR10 RFC
From: Jeremy Cline <jeremy@jcline.org>
To: Pekka Paalanen <ppaalanen@gmail.com>, Harry Wentland
 <harry.wentland@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 sebastian@sebastianwick.net, mcasas@google.com, jshargo@google.com, 
 Shashank.Sharma@amd.com, Deepak.Sharma@amd.com, Shirish.S@amd.com, 
 Vitaly.Prosyak@amd.com, aric.cyr@amd.com, Bhawanpreet.Lakha@amd.com, 
 Krunoslav.Kovac@amd.com, hersenxs.wu@amd.com, Nicholas.Kazlauskas@amd.com, 
 laurentiu.palcu@oss.nxp.com, ville.syrjala@linux.intel.com, Brian Starkey
 <brian.starkey@arm.com>
Date: Wed, 15 Sep 2021 15:50:58 +0000
In-Reply-To: <20210915170127.31377385@eldfell>
References: <20210730204134.21769-1-harry.wentland@amd.com>
 <20210730204134.21769-2-harry.wentland@amd.com>
 <20210915170127.31377385@eldfell>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: 1.us-east-1.z18Isoc/FaoPOvCyJyi1mnTt8STwoRuibXVNoUcvG6g=:AmazonSES
X-SES-Outgoing: 2021.09.15-54.240.8.61
X-Mailman-Approved-At: Wed, 15 Sep 2021 16:12:27 +0000
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, 2021-09-15 at 17:01 +0300, Pekka Paalanen wrote:
> On Fri, 30 Jul 2021 16:41:29 -0400
> Harry Wentland <harry.wentland@amd.com> wrote:
> 
> > Use the new DRM RFC doc section to capture the RFC previously only
> > described in the cover letter at
> > https://patchwork.freedesktop.org/series/89506/
> > 
> > v3:
> >  * Add sections on single-plane and multi-plane HDR
> >  * Describe approach to define HW details vs approach to define SW
> > intentions
> >  * Link Jeremy Cline's excellent HDR summaries
> >  * Outline intention behind overly verbose doc
> >  * Describe FP16 use-case
> >  * Clean up links
> > 
> > v2: create this doc
> > 
> > v1: n/a
> > 
> > Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> 
> Hi Harry,
> 
> I finally managed to go through this, comments below. Excellent to
> have
> pictures included. I wrote this reply over several days, sorry if
> it's
> not quite coherent.
> 
> 
> 
> 

<snip>

> > +
> > +
> > +Overview and background
> > +=======================
> > +
> > +I highly recommend you read `Jeremy Cline's HDR primer`_
> > +
> > +Jeremy Cline did a much better job describing this. I highly
> > recommend
> > +you read it at [1]:
> > +
> > +.. _Jeremy Cline's HDR primer:
> > https://www.jcline.org/blog/fedora/graphics/hdr/2021/05/07/hdr-in-linux-p1.html
> 
> That's a nice write-up I didn't know about, thanks.
> 
> I just wish such write-ups would be somehow peer-reviewed for
> correctness and curated for proper referencing. Perhaps like we
> develop
> code: at least some initial peer review and then fixes when anyone
> notices something to improve. Like... what you are doing here! :-)
> 
> The post is perhaps a bit too narrow with OETF/EOTF terms,
> accidentally
> implying that OETF = EOTF^-1 which is not generally true, but that
> all
> depends on which O-to-E or E-to-O functions one is talking about.
> Particularly there is a difference between functions used for signal
> compression which needs an exact matching inverse function, and
> functions containing tone-mapping and artistic effects that when
> concatenated result in the (non-identity) OOTF.
> 
> Nothing in the post seems to disagree with my current understanding
> FWI'mW.

I'm more than happy to update things that are incorrect or mis-leading
since the last thing I want to do is muddy the waters. Personally, I
would much prefer that any useful content from it be peer-reviewed and
included directly in the documentation since, well, it's being hosted
out of my laundry room and the cats have a habit of turning off the
UPS...

Do let me know if I can be of any assistance there; I'm no longer
employed to do anything HDR-related, but I do like clear documentation
so I could dedicate a bit of free time to it.

- Jeremy

