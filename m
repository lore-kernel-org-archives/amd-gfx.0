Return-Path: <SRS0=MTnY=7D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E673FC433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2020 16:52:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BC0520826
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2020 16:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vb5Wa8Uq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BC0520826
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C0056E1E5;
	Thu, 21 May 2020 16:52:43 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5196B6E05C
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2020 16:52:42 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id g14so2608104wme.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2020 09:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=e/4LLzhyYwif5qyYfBzWJogZJuFab7MMH83CHljjXKc=;
 b=Vb5Wa8Uq00aw+A9lG4z2qD9iRRylJON/0FDpvW/M8jvKE6AkSh59kKhOr5mJUmKKAr
 gtfUGrpTmwtWjwpIpz+HWQMJQxOmiOMv99qyrwPLAtZFivaU4xHfnb2u5qiu0k8FgAzm
 bwzfAIPbZFZ7YRkCXamwgVdhXNuLV0dvyp5Eud18CA2USel8m6ku9vcV+vhlBhSniwkn
 dIKF1BAUkRZJJs6/y9CVEKYotA0wcV1mwQMh9fP8UFNV10ozmdPQV3XhKWKRAyEWAxBA
 0zpdTk4dJf8JMovrpX5ilZCxDUaS2PmL1NGM4X4SXqHtq8WBrqGVm1Lcycfhz60PrP9G
 OBPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=e/4LLzhyYwif5qyYfBzWJogZJuFab7MMH83CHljjXKc=;
 b=JFohVGLnFWAgd42QJCC+SEVfr2GnhpFpvyBRvKN6kQusqUhQI6wLntUGEdPPyPiOql
 +e3F3KXYszFjGnqa9RabZG+hcLwHx1YiW1tGXHrJtbGYP/TFiJ2NQIyJeygwXILYy8tP
 tvFJJM4Zu/bxDa1R9avTvPo5teqkSM9f3LJj+gQ/xQPDShlZZXD5xJ9tw6286bgM77RE
 CLb14Ftk/Inulh5LaUyCqEiNlpCVmjGVDhLhf4qEVvzxqZ7cYmOtHCsAbbYr+6SC+/VY
 I/YthXcU1kGNHFk7H7TOyE/tybyP0/fVVySkkEQLiwfcEh9PugqTtDLvppEXNjeJQvLN
 ZgDw==
X-Gm-Message-State: AOAM533v0IfgWrlQCClxg1c/BLzoHGmNS34Xl8HWzqSDin31/E+lRlmq
 tJQg35DAsAyGRLFfQH7gMOVvJDNLyuAmNUUeHcAeDg==
X-Google-Smtp-Source: ABdhPJyeJKjHWBT5k/4cTFLa9XJVaiYcsY3Mb62slfOqyNiTLPouUG7GN5dB7Lz9378CDpzTPWGLNcXrPXVNKD4pSkM=
X-Received: by 2002:a1c:9d50:: with SMTP id g77mr9778614wme.56.1590079960763; 
 Thu, 21 May 2020 09:52:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200519211006.80492-1-alexander.deucher@amd.com>
 <20200519211006.80492-2-alexander.deucher@amd.com>
In-Reply-To: <20200519211006.80492-2-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 21 May 2020 12:52:29 -0400
Message-ID: <CADnq5_P_oQgSV5tO16ZFE44b4uGq+MMOhLA+fbV8RBPzLorBng@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: drop navi pcie bw callback
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping on this series?

On Tue, May 19, 2020 at 5:10 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> It's not implemented yet so just drop it so the sysfs
> pcie bw file returns an appropriate error instead of
> garbage.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/nv.c | 8 --------
>  1 file changed, 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
> index 9c42316c47c0..6655dd2009b6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -548,13 +548,6 @@ static bool nv_need_full_reset(struct amdgpu_device *adev)
>         return true;
>  }
>
> -static void nv_get_pcie_usage(struct amdgpu_device *adev,
> -                             uint64_t *count0,
> -                             uint64_t *count1)
> -{
> -       /*TODO*/
> -}
> -
>  static bool nv_need_reset_on_init(struct amdgpu_device *adev)
>  {
>  #if 0
> @@ -629,7 +622,6 @@ static const struct amdgpu_asic_funcs nv_asic_funcs =
>         .invalidate_hdp = &nv_invalidate_hdp,
>         .init_doorbell_index = &nv_init_doorbell_index,
>         .need_full_reset = &nv_need_full_reset,
> -       .get_pcie_usage = &nv_get_pcie_usage,
>         .need_reset_on_init = &nv_need_reset_on_init,
>         .get_pcie_replay_count = &nv_get_pcie_replay_count,
>         .supports_baco = &nv_asic_supports_baco,
> --
> 2.25.4
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
