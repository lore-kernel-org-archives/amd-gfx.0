Return-Path: <SRS0=WKN7=HK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF71C433DB
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Feb 2021 14:10:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C9C464D9F
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Feb 2021 14:10:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C9C464D9F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A01746E8EB;
	Mon,  8 Feb 2021 14:10:35 +0000 (UTC)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FD4A6E8EB
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Feb 2021 14:10:35 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id k25so12164761otb.4
 for <amd-gfx@lists.freedesktop.org>; Mon, 08 Feb 2021 06:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AijTWPQFA+6FC1xsnWLNUlecWW5zxMiZcGMW3NPIRFw=;
 b=moZHRYNpTNlseikOcrLy+qnmAKD8ai7f37hzLxSxOAj+tlsdDtdyW49157VgoyPzX+
 VNr69Wn4pEYBZwM5npiqL0tM+EGMLKoP6jyZeIl5uKRPmxg6ltDyrU5BnETcyvayB7+6
 P39OHrHDHRcR0kXXoBIHacIwbiNrKlCFG9yT9zBJvsF+FlnI0NHHemjglZElgrdQZTRP
 ZdcVQeG3X/bM1plzhLfzSLK6mHRWSHefILUOk0I7zt/PiI14cArlaLbMk2ZUzOx4oWyM
 eYSWVai+KKbP1AV0nmtV5YNmD2QA4905IdMAP1RdqU88xOwNcAK8dZ9KTjZY1LtYudtN
 xSPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AijTWPQFA+6FC1xsnWLNUlecWW5zxMiZcGMW3NPIRFw=;
 b=i8oGUeDON4WYjLyraPGGgFYcr44Wgko8Au/c6kh7ye9wkakpcehT6g3P635NFJZn7s
 x+Nzw8KFdE4VbL+EHknbIXVy39S2cdIAkKHIRuyy8cEcFRU0wfSIIEyAWmS9Ej0hxOUE
 l8gkcHkEO1tPpNGfDSyfJiPDhZ4a+LOgdTXlGyualm7wuR4EXn6/I9yFcfSY3jslgpw0
 tXjcw7fRLdNVbNQrMLSWdOPEmum6N4r1zniwjZL4djITb61OHFPqiYbyjVfXp2xZUh6m
 djzJLqLy11X1UI2s6vR3FWJdqeN8BNOJdi/R9k4jM7GfKRfykadVcQY8mVbL8LqLZJT5
 Qj8g==
X-Gm-Message-State: AOAM533XG9ch2sEuNoH96fYdo03a5mPkDNrTF6ahNmFzFEgydvbLXsp0
 ZgEnibj4yXmwLFpXLk20600xEEifdGlPgxItJpQ=
X-Google-Smtp-Source: ABdhPJxHj3kBCA8nt4/fB2QnW6uH8EWLv3JgTI+ibTXRyjCg5kNtQXOKoyRRV2ertWATJOCvb3zzbXWYdVwelnFHRwY=
X-Received: by 2002:a9d:6003:: with SMTP id h3mr6090095otj.23.1612793434424;
 Mon, 08 Feb 2021 06:10:34 -0800 (PST)
MIME-Version: 1.0
References: <20210207031556.19436-1-kenneth.feng@amd.com>
In-Reply-To: <20210207031556.19436-1-kenneth.feng@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 8 Feb 2021 09:10:23 -0500
Message-ID: <CADnq5_MG9vCp+Sc2nFxUr8t-sgM5id8Bvi16ZhqMuGWX5Xd6aQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/pm: enable LCLK DS
To: Kenneth Feng <kenneth.feng@amd.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sat, Feb 6, 2021 at 10:16 PM Kenneth Feng <kenneth.feng@amd.com> wrote:
>
> v1:
> Enable LCLK deep sleep and it works if we enable ASPM:
> modprobe amdgpu aspm=1
>
> v2:
> Add the amdgpu_aspm flag check
>
> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index b9e47f3b0231..af73e1430af5 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -302,6 +302,9 @@ sienna_cichlid_get_allowed_feature_mask(struct smu_context *smu,
>         if (smu->dc_controlled_by_gpio)
>         *(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_ACDC_BIT);
>
> +       if (amdgpu_aspm == 1)

We should probably pull the aspm flag into adev so we can selectively
enable/disable it by default on different asics.

Alex


> +               *(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DS_LCLK_BIT);
> +
>         return 0;
>  }
>
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
