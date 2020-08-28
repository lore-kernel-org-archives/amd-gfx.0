Return-Path: <SRS0=kQKQ=CG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E26C2C433E6
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2020 08:06:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FD702098B
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2020 08:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H6PEFzg+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FD702098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 609926EB82;
	Fri, 28 Aug 2020 08:06:15 +0000 (UTC)
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com
 [IPv6:2a00:1450:4864:20::643])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D4CC6EB82
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2020 08:06:14 +0000 (UTC)
Received: by mail-ej1-x643.google.com with SMTP id m22so329205eje.10
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2020 01:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=y/0F3gnc8p6GY+yM4uqKmPJm2IbDNAC+t23itr4rAsw=;
 b=H6PEFzg+7aXzOvCfxxydqTXuZVqTAMAUdRMJNMPTjV2vHB7fNtTHtg4amFmo4qDjOi
 ULKaYOrnuXPNh+WzGY+TqvsfqErmNQxwwgGwswJUpGiYQyEohOLncCZ/tBOZrKJswyyQ
 /p+n3zHLYTK9xY2KGzVjqvMiuvLiuOdRdQEDhHFWr9A0V2HaJf8MFgh2zhitTYMcRHwt
 K4XX762c9dnW6cksx10KD094UZTarMI7dkqo38iXdBWjNlhtPEN0UlS4A3ZDBFzcH+H+
 FcH0dQJr/lzqIXcHTJY1VsER4ZQgUSvWp6ZPsEI9AO0ITlyEtnlPyUCMXLBxI189NNxL
 AcjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=y/0F3gnc8p6GY+yM4uqKmPJm2IbDNAC+t23itr4rAsw=;
 b=SXXK/k1tU6azbeglQcX4oxltwsTKHDj3+uU8uPLMYL4oG52cmoEtDhr9nlgvI+ZLiR
 hX73JEqqFBPXhbYWL2YhgNHPrtyLNIx/jGozJI9xRk1bI7E9ZFWxELT7deXkqql5yzEq
 x0+yNerh36LNduz6viorH5Fo8lsuV37PacL9gAGP3IewVMktQkJ9zssdLNcw0oYF05PI
 +wTB56zxDN0B59AER756PwaFFKMF9eSD77KdAv4bOUGejARKfgVmlowQqCqHhwA321IW
 ELDobC2D09dFeUwvzvTm2iccP2fbCaZ8sLRfD9tOLQJSmrIG40FRsrR85hJuFA5N+1KK
 AEVQ==
X-Gm-Message-State: AOAM533AQglx0ZPhNhAVDMX861SILwTMsyGKY+/QgLn0/828D+4Uc6Ag
 hwV2WsFessyEiTvQKTgPW60=
X-Google-Smtp-Source: ABdhPJwdQ+k7/KSqeLYxfzIx9m+U7LHAL0RddQJJx97IgvfgpGl5xtuYWRRMgfAkbMCK7HOdbcbiDg==
X-Received: by 2002:a17:906:a00d:: with SMTP id
 p13mr564953ejy.535.1598601972976; 
 Fri, 28 Aug 2020 01:06:12 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id f20sm211723ejq.60.2020.08.28.01.06.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2020 01:06:12 -0700 (PDT)
Subject: Re: [PATCH 3/8] drm/amdgpu: add pre_asic_init callback for SI
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200824161527.2001591-1-alexander.deucher@amd.com>
 <20200824161527.2001591-3-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <62c44d4c-ece3-5e61-7d20-2d8da9734a1a@gmail.com>
Date: Fri, 28 Aug 2020 10:06:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200824161527.2001591-3-alexander.deucher@amd.com>
Content-Language: en-US
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
Reply-To: christian.koenig@amd.com
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 24.08.20 um 18:15 schrieb Alex Deucher:
> Nothing to do for this family.

Uff, no. Can't we just make the callback optional?

>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/si.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
> index eaa2f071b139..455d5e366c69 100644
> --- a/drivers/gpu/drm/amd/amdgpu/si.c
> +++ b/drivers/gpu/drm/amd/amdgpu/si.c
> @@ -1871,6 +1871,10 @@ static int si_set_vce_clocks(struct amdgpu_device *adev, u32 evclk, u32 ecclk)
>   	return 0;
>   }
>   
> +static void si_pre_asic_init(struct amdgpu_device *adev)
> +{
> +}
> +
>   static const struct amdgpu_asic_funcs si_asic_funcs =
>   {
>   	.read_disabled_bios = &si_read_disabled_bios,
> @@ -1892,6 +1896,7 @@ static const struct amdgpu_asic_funcs si_asic_funcs =
>   	.need_reset_on_init = &si_need_reset_on_init,
>   	.get_pcie_replay_count = &si_get_pcie_replay_count,
>   	.supports_baco = &si_asic_supports_baco,
> +	.pre_asic_init = &si_pre_asic_init,
>   };
>   
>   static uint32_t si_get_rev_id(struct amdgpu_device *adev)

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
