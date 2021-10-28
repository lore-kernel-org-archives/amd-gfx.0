Return-Path: <SRS0=JMr/=PQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85845C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Oct 2021 07:07:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DC8A60C4B
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Oct 2021 07:07:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4DC8A60C4B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6E536E7DD;
	Thu, 28 Oct 2021 07:07:13 +0000 (UTC)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55E4F6E7DD
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Oct 2021 07:07:12 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id s13so1169657wrb.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Oct 2021 00:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=uYmQlxE/xW6rKz+sdgRM5bjE9KWY7Nn0WVmByqn2t0w=;
 b=l/91zkDiXEucdnzUjEln9OCZd4f7h7WMVZw2Yl/1Dh2XgYlTLLlV7axg9dzlHjMPko
 GiNy1Cgsrl19J6KA2iT5GqknZnyTo9Wrvia9syTlJ+Af+esNgfwnMHYCNq9EX1A47NZT
 LyZAMGvWRoHpUPEOwwxZAtoAwE2njnhHVkTKLUm6Z0TPftQE5Vl6CaGj9wFVVYhlNXMy
 vRZWyPh4n2YOsX4/u2Nj4Kau9hqU8zFU/q/tMhQ2jqbabdU8AGuQr5NLAmlK/WP3fONt
 zyLzK2Lvi+xcjsDFUl1b53/O5Bb/WLDrTcxcH/nbKxD6yPocYupoVsiIb7g6omntqcDD
 S7XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=uYmQlxE/xW6rKz+sdgRM5bjE9KWY7Nn0WVmByqn2t0w=;
 b=4x4AEIChlC8KLV55M4Wy6KH7o2p1EKKJwyl9nFHIx/xEKyyEVbBt4G9WCzGxXAyI61
 C9Fhk43DgOYdSRKfk3h4ibXzmwpg0sNAzClrnofctVHDevJHcWa0MY+ymkGz/bWOk56N
 bBqUzZJlTVawVbpeUw8BdbrBh4wJ3GNA4tXD1SG25HUBrK41mEAVXPmfLs4GrVO0gSz9
 TNS2FfMaMyynIvaG4EOwAmusBiJFy58hzycF6Yz2Qs/XkyDPoiatF9HVI1PWXBwy+pFC
 RsSbQCKdGYGLWh5e/sIK6+u80NwUYIw2+Sto95AzrKB8hXUGEFd9ApxKkiQXxOvOTOvt
 PWIQ==
X-Gm-Message-State: AOAM533nH7KFZHserdMkWBgNCtQoQHCCXJTmgVufbsCAob6Z/DMzZf32
 EGVBf++tGZJQ7HLzklB6Xw7Y9S7WKh0=
X-Google-Smtp-Source: ABdhPJzrQWfIRgT2H1Cc+qUUN4sw3vhxocMHKQjVPiGvLdUcgtlUr2vG1Sycj77Bh2Qwsk6jF2pYBg==
X-Received: by 2002:a5d:64e2:: with SMTP id g2mr3307568wri.253.1635404830813; 
 Thu, 28 Oct 2021 00:07:10 -0700 (PDT)
Received: from [192.168.178.21] (p5b0ea1b5.dip0.t-ipconnect.de.
 [91.14.161.181])
 by smtp.gmail.com with ESMTPSA id b6sm2427810wrd.85.2021.10.28.00.07.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Oct 2021 00:07:10 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu/gmc6: fix DMA mask
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211027182212.1484689-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <761d06e0-c8f7-02da-2c87-9105af0e426a@gmail.com>
Date: Thu, 28 Oct 2021 09:07:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211027182212.1484689-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 27.10.21 um 20:22 schrieb Alex Deucher:
> The DMA mask on SI parts is 40 bits not 44.  Looks like a copy
> paste typo.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> index 0e81e03e9b49..a9354cb2d639 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> @@ -841,7 +841,7 @@ static int gmc_v6_0_sw_init(void *handle)
>   
>   	adev->gmc.mc_mask = 0xffffffffffULL;
>   
> -	r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(44));
> +	r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(40));
>   	if (r) {
>   		dev_warn(adev->dev, "No suitable DMA available.\n");
>   		return r;

