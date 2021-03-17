Return-Path: <SRS0=2fSF=IP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D9D2C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 08:29:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2249064F99
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 08:29:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2249064F99
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emersion.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B71846E4EC;
	Wed, 17 Mar 2021 08:29:24 +0000 (UTC)
Received: from mail2.protonmail.ch (mail2.protonmail.ch [185.70.40.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98A9C6E4EC
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Mar 2021 08:29:23 +0000 (UTC)
Date: Wed, 17 Mar 2021 08:29:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail3; t=1615969761;
 bh=QC4dZZ3aBbeC7Kz8+2xjUMyIqILRwvnjxiKWeBxi5ns=;
 h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
 b=A1KC/rMdtoASJ51bug1yJz+THFVc/ujxtDy1XzZMDraGBnuMr5sOgCZ3MIbWdZQny
 hO41tCEYxszNVxLK7J9EPKitf/rQq3mztvwyqftoVA3A2rt8xBOqo7tq4XTYpW0PZU
 hpPzYXZuCXGskXkpsoacGXCHc1O5QOzLzV45GoyZJwWHh56hEiCjd0E0+jyoxMRtRz
 +5U4Qyh4TRHksJNqkg0T50PgaKtrhbUZ9N7wT30++O4Pkm3AkseOHrahkaZr0P/j89
 ssL+g+MmVXlf/fsNHp21D3uvzkejqsyJI4MdlP1IF5Y1TehYrlnE+rfsbVnE6xUoVw
 p4izIvpGZqiBQ==
To: Sefa Eyeoglu <contact@scrumplex.net>
From: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH] drm/amd/display: check fb of primary plane
Message-ID: <BXflth5n3xasxoEuCG2MmbmwEVxpajiLTSqLdyoFxMsugaQUqpvAvZENKxcrhoHY1z0D0NkWBxQa83qUOm8Eg5EOLUhbWoQ7P7y5iblbLwg=@emersion.fr>
In-Reply-To: <20210316215006.18769-1-contact@scrumplex.net>
References: <20210316215006.18769-1-contact@scrumplex.net>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tuesday, March 16th, 2021 at 10:50 PM, Sefa Eyeoglu <contact@scrumplex.net> wrote:

> Sometimes the primary plane might not be initialized (yet), which
> causes dm_check_crtc_cursor to divide by zero.
> Apparently a weird state before a S3-suspend causes the aforementioned
> divide-by-zero error when resuming from S3.  This was explained in
> bug 212293 on Bugzilla.
>
> To avoid this divide-by-zero error we check if the primary plane's fb
> isn't NULL.  If it's NULL the src_w and src_h attributes will be 0,
> which would cause a divide-by-zero.
>
> This fixes Bugzilla report 212293
> https://bugzilla.kernel.org/show_bug.cgi?id=212293
>
> Fixes: 12f4849a1cfd69f3 ("drm/amd/display: check cursor scaling")
> Signed-off-by: Sefa Eyeoglu <contact@scrumplex.net>

Thanks for the fix! In theory we should return -EINVAL here, because we can't
enable the cursor plane without the primary plane. But that would break the
legacy API translation layer in DRM core, which expects that planes can always
be disabled individually.

So this is:

Reviewed-by: Simon Ser <contact@emersion.fr>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
