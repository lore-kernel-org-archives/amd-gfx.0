Return-Path: <SRS0=hs5v=5E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37741C4332D
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Mar 2020 03:12:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0901520773
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Mar 2020 03:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bz1jgRBS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0901520773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD9CB6E981;
	Thu, 19 Mar 2020 03:12:25 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03CF96E981
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Mar 2020 03:12:25 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id c187so429252wme.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2020 20:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=reWgl3NCiZCZNzrop4L8QcFpOwgi7TMAXzwkT2C5CcA=;
 b=bz1jgRBSZXa/pMgxPmoG0BJLCNSuE9ieLzLHb9NQGIEuPjw+4buq6h78aR1R5xkmLV
 sKVugx4R4D0RF6M2S167n6qp1qRMXuRov5vFTGnBA7qon1UL1wgsZFgcUYNoP/Nx8whP
 nk/bXSGkN9uvWKOn95pJOFbIW/efWpfaBvALErBFW/OfuEkSPzVJ8TR6rsbdkb9VAYGL
 IDRjxokqLYxD0DT2TsalCDiPFRntkFkRssrkSRX2JAI1/pWPiMqd4kW5z7BZ+Z5YUOGx
 yqqJ0WQVNqSueiwGMizeLpIQ3xCmqckBzRlYz2H6S0TFExhaPeCO/OHNF4QUruyDEXuB
 N07w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=reWgl3NCiZCZNzrop4L8QcFpOwgi7TMAXzwkT2C5CcA=;
 b=Qje/gNuGlT2EKh/x4C1Md9QpTweMyoVWdXxHMISKs22G8kv3h8gFsSLuGiFlMRDvRk
 HCNQ4hbv4g1DIYkNAL5fvYt9d/d2RdvuruMFLq4ZBeejjIJGXyntZZq+x2CFZPCTk3y+
 R1V7X9GViOS4OHUi2iQU88TalOMrRLouj+TQ5K4lCnLcajgHiUXmYPtyIKdkchXXbrPI
 Q8c8EJvkmJaaMUKe56DkSVL8Ek9FOs3DSSMTd602T55AmZ54gRIPfkozjY6gWNZhN4S0
 F+T3ia2Kg3+YF1dOxTlohXsQiZ23aExii8LSGD1Z/n0SPLIBv9uEJ7wKVQ3S1+9eWlW6
 H6vQ==
X-Gm-Message-State: ANhLgQ17d8mSigzN817LauQn89cpBpngCGl4vEJuIOzT4x6G2DSAeoDV
 M9FCyv36mQj+7F7CWFXROVoVsDg4c/nwuYRB3IM=
X-Google-Smtp-Source: ADFU+vvCej+BPydar0GxLaQN91Uh2/hYLAfdOLFvubEgVDEDaG0n3BW9uDDp0Nh4PraQEOxvcKorC5S5gFuOzplgbuU=
X-Received: by 2002:a7b:c542:: with SMTP id j2mr962515wmk.39.1584587543650;
 Wed, 18 Mar 2020 20:12:23 -0700 (PDT)
MIME-Version: 1.0
References: <1584464097-12866-1-git-send-email-shaoyun.liu@amd.com>
In-Reply-To: <1584464097-12866-1-git-send-email-shaoyun.liu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 18 Mar 2020 23:12:12 -0400
Message-ID: <CADnq5_PDj_stFK0AEpASi4bQxDbfzjG-AHB8t51WensO7ni=NQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/sriov : Don't resume RLCG for SRIOV guest
To: shaoyunl <shaoyun.liu@amd.com>
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

On Tue, Mar 17, 2020 at 12:55 PM shaoyunl <shaoyun.liu@amd.com> wrote:
>
> RLCG is enabled by host driver, no need to enable it in guest for none-PSP load path
>
> Change-Id: I2f313743bf3d492f06aaef07224da6eda3878a28
> Signed-off-by: shaoyunl <shaoyun.liu@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index d1cdcb4..e134bb2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -1940,6 +1940,11 @@ static int gfx_v10_0_rlc_resume(struct amdgpu_device *adev)
>                 if (!amdgpu_sriov_vf(adev)) /* enable RLC SRM */
>                         gfx_v10_0_rlc_enable_srm(adev);
>         } else {
> +               if (amdgpu_sriov_vf(adev)) {
> +                       gfx_v10_0_init_csb(adev);
> +                       return 0;
> +               }
> +
>                 adev->gfx.rlc.funcs->stop(adev);
>
>                 /* disable CG */
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
