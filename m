Return-Path: <SRS0=Z3Jh=FT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A5EC4361B
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Dec 2020 07:58:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56FD122273
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Dec 2020 07:58:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56FD122273
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emersion.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE7CF6E162;
	Tue, 15 Dec 2020 07:58:29 +0000 (UTC)
Received: from mail2.protonmail.ch (mail2.protonmail.ch [185.70.40.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A30166E162
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Dec 2020 07:58:28 +0000 (UTC)
Date: Tue, 15 Dec 2020 07:58:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail2; t=1608019106;
 bh=niwfFqsi/vR9UNnFy+D7dP3u1AwVgVD7WUzyN/Wfbuk=;
 h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
 b=TzEr3xo/f2mQ2n6/EOxTYYGkIUONkDeHVkoOOHI8/wwzz8lBcVpr5HmXpw3G9PTPm
 +ZA/B9cn5m1OU8yhHhgPteN0wITiFW0e56r0G6C4S40F+fSPRnHXYY1aLnQ0kB6tGC
 FXnG6bJAxwVaoxR29yXBj1prj41mbZliIEH5DW5eBrspX8pmYfxKHt0KEsknA7kICC
 WeecSMg+pbDy9pEybGHXNWf8qrHGWXRzT5+ErOzRvKJJ6oeinrcCzToLlccfEz1F+X
 1H2TB752v3a0nnO90FJpqrOb0W+6Pe+zeNJCET262AVRV1IlmG28NLp5+lZIDQmea6
 dtMZhnMwR4ImQ==
To: "Cornij, Nikola" <Nikola.Cornij@amd.com>
From: Simon Ser <contact@emersion.fr>
Subject: Re: Overlay issues
Message-ID: <05FNtjCma79AawCUxH3mqJ8sWHmoIXFXhQWW0N_b-mpl7QvuW3JN3AbtPUiR0y1LOf3tLhWFWv8YjuIEvJ3dci9y1EHk_D9a9L1BAyWyxRs=@emersion.fr>
In-Reply-To: <DM5PR12MB4679C807DB8DB502AC4793DCEEC60@DM5PR12MB4679.namprd12.prod.outlook.com>
References: <DM5PR12MB4679C807DB8DB502AC4793DCEEC60@DM5PR12MB4679.namprd12.prod.outlook.com>
MIME-Version: 1.0
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
Reply-To: Simon Ser <contact@emersion.fr>
Cc: Alex Deucher <alexdeucher@gmail.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Kazlauskas,
 Nicholas" <Nicholas.Kazlauskas@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tuesday, December 15th, 2020 at 5:09 AM, Cornij, Nikola <Nikola.Cornij@amd.com> wrote:

> [AMD Public Use]
>
> Hi Simon,
>
> Just to keep you updated, I've reproduced issue '[1] - Overlay plane:
> position not updated when CRTC_X is negative' on Ubuntu using IGT.
> Seems to happen only with smaller FBs (so far tried 24x24 and I can
> repro, but 300x300 is OK).
>
> I'll look into fixing this.

Thanks for the update and for looking into this! Let me know if I can
help with anything. Nicholas replied on the issue tracker that overlay
planes couldn't have negative positions, so I was thinking of having a
look at the SRC_Y handling (see if we can do the same for SRC_X),
experimenting with FB sizes and SRC_W/H to figure out what's the
overlay max size still triggering the bug. If we really can't emulate
neg SRC_X we should fail atomic commits with negative SRC_X by
returning EINVAL (so that user-space can fall back to not using the
plane in this case).

Simon
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
