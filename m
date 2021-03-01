Return-Path: <SRS0=hzAD=H7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF5ACC433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Mar 2021 17:11:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CD9D65197
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Mar 2021 17:11:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CD9D65197
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 491C889F2A;
	Mon,  1 Mar 2021 17:11:17 +0000 (UTC)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2155189F2A
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Mar 2021 17:11:16 +0000 (UTC)
Received: by mail-oi1-x22b.google.com with SMTP id l133so18778808oib.4
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Mar 2021 09:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ooPecabIamTjt8rNhVB8aqjfKtHfdDDXc4/DaxYYnok=;
 b=mw/KYSqHezNs2UQJOiir8zUrXQP5DRxTuVrpPogXHKKOHnXdDH8ZjDVlZL8Y2w3Dg+
 NFzpQKIexSnxAIRyksgeY98zDeiZ+B6TiZcf4ZuDqz8RHkDetpGH0+ichDN+M1Tfe1w2
 mjrxjTn33g65yhodoeSdwyKQPcf9XWeg65C7mwFzgvaWeoIIZQfp4EPCRZKyFjkVy0Zh
 eR8cbV6y1CGxBfvRbKrDe+48vyU73YCDhxlfgNGMPYoAXfDWaAAsSC7YNW7vDq2C82TN
 hTBtJ4sMtE7Vzb+nEyfAJtuYS5lnn2qMoJm3fbdhNFLa/GOtSCCy9ubdGJRgqS+gcq3+
 s+Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ooPecabIamTjt8rNhVB8aqjfKtHfdDDXc4/DaxYYnok=;
 b=IU/bTndGhTB3C2O2sHfQGPiizawWOWMjkWQXogSvtgGEEj9PXdoPqhFjo9FtsUS161
 g4Ku8pIgE+1AWigO2HEuYhU0GQLWGqI7Str/GMtG3TQg1BDt2wfpEgzVfnooy1RyBNh5
 pEgSfiQRBMVn3x1YmWWq2RDZNG/1aEpdDGuMRsOKnMgJvOsqo3cpCpn4NU/XPSHIPgke
 xJzJ1Odg/tAvsX+CEj4CMblWHGq9RjmXvHsIhFYo0nrShXdJWGiwEDuad2A6bGxuCw/J
 y1bOHbJuksCmxrFrJBs1/F6DLp6RqSxN/h/DgLFj/DfkRWNN8gKEGyUjcOMBr4vqfCQA
 HRKQ==
X-Gm-Message-State: AOAM531F3qvZjF6KnswmhXME91ekJmijHpXHCFdj7mb/ISggdtK/ysc5
 OGP6THCUUmqCawiPCrNZzX3Hc9ffH/yWVueNzJA=
X-Google-Smtp-Source: ABdhPJyRzr3GHDMSrpmRQts5q1BlGHLnCkpV47cn0lgyVFbh724Pllk6KWUaQkEfnN+9KY+om1CjATzlyc06AFrr4LY=
X-Received: by 2002:a05:6808:f15:: with SMTP id
 m21mr12243878oiw.123.1614618675491; 
 Mon, 01 Mar 2021 09:11:15 -0800 (PST)
MIME-Version: 1.0
References: <20210301170631.94988-1-bindu.r@amd.com>
In-Reply-To: <20210301170631.94988-1-bindu.r@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 1 Mar 2021 12:11:04 -0500
Message-ID: <CADnq5_PzWASCbTnF7AnyY+QkjcccMcMFOwTReyBe8mce18pm2g@mail.gmail.com>
Subject: Re: [PATCH 0/2] Fix for 64 bit divisions on 32-bit platform.
To: Bindu Ramamurthy <bindu.r@amd.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Mar 1, 2021 at 12:06 PM Bindu Ramamurthy <bindu.r@amd.com> wrote:
>
> This patch set fixes 64 bit divisions for the display
> synchronization code that caused a regression on 32-bit platform.
>
> Vladimir Stempen (2):
>   SWDEV-266369 - dc: Fix 64 bit divisions on 32 bit platforms by using
>     div64 API
>   SWDEV-266369 - dc: Fix 64 bit modulus operation using div64 API

Fix the patch subjects to be something like:

drm/amd/display/dc: Fix 64 bit divisions on 32 bit platforms by using

No need to put the internal ticket number in the subject for upstream.
With that fixed, the patches are:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Alex



>
>  .../gpu/drm/amd/display/dc/core/dc_resource.c | 14 +++++++-------
>  .../drm/amd/display/dc/dce/dce_clock_source.c |  6 +++---
>  .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 19 ++++++++++++-------
>  .../gpu/drm/amd/display/dc/dcn20/dcn20_optc.c | 13 +++++++------
>  4 files changed, 29 insertions(+), 23 deletions(-)
>
> --
> 2.25.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
