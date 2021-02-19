Return-Path: <SRS0=jKCf=HV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6639C433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Feb 2021 17:30:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AA0164E60
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Feb 2021 17:30:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AA0164E60
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emersion.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAE556EB8C;
	Fri, 19 Feb 2021 17:30:11 +0000 (UTC)
Received: from mail1.protonmail.ch (mail1.protonmail.ch [185.70.40.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D82666EB82
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Feb 2021 17:30:09 +0000 (UTC)
Date: Fri, 19 Feb 2021 17:29:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail3; t=1613755807;
 bh=9EHiTNOlWr+Se8r9FZ8yRy1CerUqi3kzj+AsInywRJ4=;
 h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
 b=mAhujq/JJvcDu3mGUawYFdzlLZICT/k7ZpqqqpfdFEXYVpr605SLQbidPgB3hUQUN
 G/gFtNahPYIyR0kUgPl/xvS4G2WvgXU3GOlSo4DVnKVI1aHW4ZqGV2IzdWYd6Xre2I
 lwHA/+bk9+t75O/p6Kf4NUUc0LWeUg3Eh9V+Ab/DOVbKYPd2gOVCb89FLr+dKYAAMP
 +AqFKDfuSDeqE7B15np3I+LOS1YPY+nTa7Ce4qwv5qUTe+uYQ1d7HelIy98+OAvwtF
 b7JX9oK+EKRUz1V8uIc6qqTMTxHt7WgiTIvFEw98MiGioxN/SFJDMGHLZTv04Qhmqb
 t41j9O/11lm3Q==
To: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
From: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH 2/2] amd/display: add cursor check for YUV primary plane
Message-ID: <ooUUHOVWdFJnq4EBspGdEXyMzibYzwXlW-O4boMFyLeCi50oPl8CIYOk_RF8Z22KL2QvzQs47McGU3xebwAyq0358jJJzkADAe79peNYMMM=@emersion.fr>
In-Reply-To: <2feadc71-19b0-d1af-6302-1ad20e81aa79@amd.com>
References: <GKIJ9isuno0PKWRz4qj5CSIfRao35EWMYjtLGdiDIk@cp3-web-020.plabs.ch>
 <2feadc71-19b0-d1af-6302-1ad20e81aa79@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Harry Wentland <hwentlan@amd.com>,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Friday, February 19th, 2021 at 6:22 PM, Kazlauskas, Nicholas <nicholas.kazlauskas@amd.com> wrote:

> We can support cursor plane, but only if we have an overlay plane
> enabled that's using XRGB/ARGB.
>
> This is what we do on Chrome OS for video playback:
>
> Cursor Plane - ARGB8888
> Overlay Plane - ARGB8888 Desktop/UI with cutout for video
> Primary Plane - NV12 video
>
> So this new check would break this usecase. It needs to check that there
> isn't an XRGB/ARGB plane at the top of the blending chain instead.

Oh, interesting. I'll adjust the patch.

Related: how does this affect scaling? Right now there is a check that makes
sure the cursor plane scaling matches the primary plane's. Should we instead
check that the cursor plane scaling matches the top-most XRGB/ARGB plane's?
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
