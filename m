Return-Path: <SRS0=DoF4=HY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A56AC433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Feb 2021 22:31:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 199D264E07
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Feb 2021 22:31:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 199D264E07
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emersion.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 868016E5B9;
	Mon, 22 Feb 2021 22:31:03 +0000 (UTC)
Received: from mail1.protonmail.ch (mail1.protonmail.ch [185.70.40.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9C066E5B9
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Feb 2021 22:31:01 +0000 (UTC)
Date: Mon, 22 Feb 2021 22:30:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail3; t=1614033059;
 bh=SDMzlFfvc+RZm8mPchxy0GqoE37FgnhO+YG3KXWM/jY=;
 h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
 b=kqLV5Mxh7J+4028MOSqU3RGV4hBFM5YveiGS5p25sY/LrfJDTKUKGhnzpugjfn5iN
 mMBaELpW+ZFTjs2bnUWMPgE3mkuhQfWuUHjUDCBMSQpYCh+jOjAItJcgz5dGpltsoH
 ckpOy3bGTqCQ9fFT6ylk5dMZIkJFdBZjrDaRO2lKj8ANecA/FpRVYtabJge6dxKqeO
 8RwlVrQxWN3bmBlLfjCaD6I8QTPq/H5w3ZGW/9fn6st0nW0tVAQhaxAq7Y/ECA2f9k
 DS57j/bMA2xKYNbG0JpjUXwVNNiCkN8MSnF76TMB9l1xDXhfAp8RU6ixab5SR3CmsI
 GFyEeL+yVp9xw==
To: "Cornij, Nikola" <Nikola.Cornij@amd.com>
From: Simon Ser <contact@emersion.fr>
Subject: RE: Overlay issues
Message-ID: <Kdv-dXZJZAwHurjWGxke0BycsKRikMsY_omFpPVknQqoLWCweXWWMs9ET6_Ax0hIMvFKornwDJ2i5MXyspmEykuloW5IppjT-w6NT6vfIBU=@emersion.fr>
In-Reply-To: <DM5PR12MB4679C406F33E9B04BA343295EE819@DM5PR12MB4679.namprd12.prod.outlook.com>
References: <DM5PR12MB4679C807DB8DB502AC4793DCEEC60@DM5PR12MB4679.namprd12.prod.outlook.com>
 <05FNtjCma79AawCUxH3mqJ8sWHmoIXFXhQWW0N_b-mpl7QvuW3JN3AbtPUiR0y1LOf3tLhWFWv8YjuIEvJ3dci9y1EHk_D9a9L1BAyWyxRs=@emersion.fr>
 <DM5PR12MB4679F2B26887B76BC025161AEEC60@DM5PR12MB4679.namprd12.prod.outlook.com>
 <DM5PR12MB46792E5F8DF0F128FF01D79EEEDE0@DM5PR12MB4679.namprd12.prod.outlook.com>
 <Zq5awE32--JJaePI-8O0Rd-2AYVUPYgIn1PspErRR_qpQeTlX_L0M_8iQMyN6rGZPJRuBmkf6OGmeQFLYkzB9cswAhdyWbAzEXqT-0ZjFC4=@emersion.fr>
 <DM5PR12MB4679C406F33E9B04BA343295EE819@DM5PR12MB4679.namprd12.prod.outlook.com>
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

On Monday, February 22nd, 2021 at 9:59 PM, Cornij, Nikola <Nikola.Cornij@amd.com> wrote:

> [AMD Official Use Only - Approved for External Use]
>
> Hi Simon,
>
> Yes, I did have a chance to wrap this up, indeed :-)
>
> It turned out this and other similar setup was hitting a legit HW
> limitation. I added a patch (please see attached) that'd fail this
> config at validation time. The patch has been merged for upstreaming
> at the beginning of February time-frame, not sure if it made it to
> the public repo by now.

Excellent! I don't see the patch in agd5f/drm-next yet, but it'll
probably show up soon.

Thanks for fixing this!

One small nit: if possible, add some drm_dbg_atomic() calls explaining
the error right before returning -EINVAL. This is very valuable when
debugging user-space applications and trying to figure out why the
kernel rejects an atomic commit.
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
