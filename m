Return-Path: <SRS0=wluJ=EK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6A3C2D0A3
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2020 01:19:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AFBF2242A
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2020 01:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0epP6VJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AFBF2242A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C2526E923;
	Wed,  4 Nov 2020 01:19:43 +0000 (UTC)
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com
 [IPv6:2607:f8b0:4864:20::b41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32C0D6E923
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Nov 2020 01:19:42 +0000 (UTC)
Received: by mail-yb1-xb41.google.com with SMTP id a4so16565146ybq.13
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Nov 2020 17:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=D9YTLFJGfhfcWC9NHIPMurEnNFGy3/PaTeo2oAk67SI=;
 b=E0epP6VJmKTTLJLUZdK43fjeugNaiM18Ef4uEiS50mMOemM7BeXd+wIPUacv5dNbf2
 7BIPQoyPcZY3kOcoaxdiHUGO7X2Lci53e1AMMRT+dWvvnf1+QM07xZP3xsO5ssFNa2zt
 ++l+pLk7i1vboijYpFv8Yhk++rl2Qr6QN5+apecN5aCGstLT0N3Jc+ALd63VeUvLLcpo
 mTgPeiWn4vdFPIPWVepVUJdC+W13GScOrEPkEJIMEqAEsJcqYZybtw4EmDcG+JaJoMMD
 7p3IUsgfVkp+D0nzFukv45MAsr5UvB4P53IhJAmdDt/EafS4ItDhdKp2nxYqxKe9lpRg
 LbYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=D9YTLFJGfhfcWC9NHIPMurEnNFGy3/PaTeo2oAk67SI=;
 b=rk9JxuFkALbM7VlNAORixSVxacEdS4izf58ljT/8E/FlFsZ5z9V9JyLAeVM8IWPs7i
 TXCQWPN5m10AgPkzWttgHmouUSmxMisr2E/tX+UiRyV+PKX6ns2PQ0t6hhaKGr8FreMa
 HBmDJfFa2e5ydIIXfZ81xvT4QggO/ksnGkvMDhep62UdnW2jePKrFaq1ljmNLfPWMJmZ
 gISSh/gP5iZ5BEWVxtwtZeps0tdo8culZtXmLV5aApz2oG1IfByeQwE4sXZgni3OyG4L
 G0LqPqEtq1R2RQsTPn4chJyfkJcfPiiIVpZV4QICskBnxIfjUQVzqtXwnF2KHljQ1imk
 twMQ==
X-Gm-Message-State: AOAM5324/Cr1k/fYVNVZToIMdzOhAfP2b6Hee4SNt2VAtbJnEyA+lJ1x
 3LYDzuLcLYTtR3+Jj0Acewxd8Fhr97SzkdOt7jjBCXTH05I=
X-Google-Smtp-Source: ABdhPJwV0oNhzEZVl4NfJcXWSgLmExosA1YaIBejCPqvVSvk+36lPUpb1HBF/f6K4u9Y88ZK8e3eltv5QfKQQcnK8ig=
X-Received: by 2002:a25:3303:: with SMTP id z3mr32435397ybz.9.1604452781421;
 Tue, 03 Nov 2020 17:19:41 -0800 (PST)
MIME-Version: 1.0
References: <20201103232434.832933-1-alexander.deucher@amd.com>
 <DM6PR12MB261967F844E1050529EFAC71E4EF0@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB261967F844E1050529EFAC71E4EF0@DM6PR12MB2619.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 3 Nov 2020 20:19:29 -0500
Message-ID: <CADnq5_N3TiUfKNjhhg0uctgS9Bw7o81GSPgx9=pCh2DCREfiKw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/swsmu: remove duplicate call to
 smu_set_default_dpm_table
To: "Quan, Evan" <Evan.Quan@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Nov 3, 2020 at 8:12 PM Quan, Evan <Evan.Quan@amd.com> wrote:
>
> [AMD Official Use Only - Internal Distribution Only]
>
> Hi Alex,
>
> Where is the other place the smu_set_default_dpm_table get called? smu_late_init()?
> If yes, you probably need to leave the one from smu_smc_hw_setup but drop another one from smu_late_init().

Right above it.  See:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c#n1020

Alex


>
> BR
> Evan
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
> Sent: Wednesday, November 4, 2020 7:25 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amdgpu/swsmu: remove duplicate call to smu_set_default_dpm_table
>
> For kernel 5.10, this function was called twice due to what looks like a mis-merge.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 11 -----------
>  1 file changed, 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index fc4f95fa87cf..b1e5ec01527b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1029,17 +1029,6 @@ static int smu_smc_hw_setup(struct smu_context *smu)
>  return ret;
>  }
>
> -/*
> - * Set initialized values (get from vbios) to dpm tables context such as
> - * gfxclk, memclk, dcefclk, and etc. And enable the DPM feature for each
> - * type of clks.
> - */
> -ret = smu_set_default_dpm_table(smu);
> -if (ret) {
> -dev_err(adev->dev, "Failed to setup default dpm clock tables!\n");
> -return ret;
> -}
> -
>  ret = smu_notify_display_change(smu);
>  if (ret)
>  return ret;
> --
> 2.25.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7Cf1a68accb24f48fd825808d8804fa821%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637400426909200216%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=5MGn5WBff4yyAoZra9NGHILEKIWp0iH0ysL55Nj%2BFcQ%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
