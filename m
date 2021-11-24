Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CCE2C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Nov 2021 07:08:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97F336E4E8;
	Wed, 24 Nov 2021 07:08:13 +0000 (UTC)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A64856E4E8
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Nov 2021 07:08:12 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id o13so2288568wrs.12
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Nov 2021 23:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=X07skGQUof39L+k9uQK/uR4Vn9vwdd9hBXwB/mRa9gE=;
 b=K5WEoM3lhp3W6wizH1+hoBE6qfSOGd9wcbZT3kzT0SFOPD3gxGrt/5Jtsh2+BjB2VS
 G52iTN8U7MXh7R0pldZztJ5R/0qM4Ub6y9CoGq+fbPt5pSpx9dDoGliU0/KtunRUmzA6
 fnvb+W4qFRfU1ccYyTt41nayWPOXFSjkmcrsNdro86hr38H13skszQ9v5+oMHMOI19la
 7na5j4EH+najAyQlynDGGFkICsTJ07Ph1UZaRTZ6mCcmIyISEfM48PivwoV2ZezjRlTj
 KIItt7QcfTiqxWXICwkt/hkDVSqDrsjwIg/XWw0SPbRIHBw0N0zzwYHg5Bs3cfIeoIux
 pCfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=X07skGQUof39L+k9uQK/uR4Vn9vwdd9hBXwB/mRa9gE=;
 b=krXkUrEL+zS3clehZ3x9ZP3TyoojPIgI5q5gMrPdRPNFp5WBRCABLFQ62RRYin2ZUp
 Wm6F9hariRz1M+7za8QtPQDK7xEO4CQpUxZED11SNVMqnG3eZHtxe4ZC1ZgXJdk95hMv
 AWtos9qEN+5cHakAvDhOa0myIdxw/ejaOo+MGvELqRNBHAQialAzENRs9rc1G2hCI2En
 y1gOHo0HJ5um9OI6JF2TzOpjiEmLfwUrELXfFFAHvnOYaMjz3y4AxJvSmBwbzwsiLn+E
 HunWtVvGusG00YUUeANKWRnR7DasVPj2+AdW+GH1bVmcUP7wjcOvXcVpV/H5yCFWlyEE
 wWmw==
X-Gm-Message-State: AOAM5310NOy0jNBZKtYusyShafWDsFovHhtRmaa5ytJ5Y7cF55svr+kD
 SdK/Z3ymvBKU2D1R/e8vSs0=
X-Google-Smtp-Source: ABdhPJzxHqHQXoEGK9zAcVmxZhbryyn3l+9biPsGvKzq684FswWIhoW7lPy/tVCd9096UyFgn/1clw==
X-Received: by 2002:a5d:4b82:: with SMTP id b2mr15713596wrt.419.1637737691197; 
 Tue, 23 Nov 2021 23:08:11 -0800 (PST)
Received: from [192.168.178.21] (p57b0b77b.dip0.t-ipconnect.de.
 [87.176.183.123])
 by smtp.gmail.com with ESMTPSA id o10sm17767652wri.15.2021.11.23.23.08.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Nov 2021 23:08:08 -0800 (PST)
Subject: Re: [PATCH 1/2] drm/amdgpu: enable Navi 48-bit IH timestamp counter
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211123160352.21228-1-Philip.Yang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <c1b9c707-afc5-a490-d6e9-68af3e9e9f07@gmail.com>
Date: Wed, 24 Nov 2021 08:08:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211123160352.21228-1-Philip.Yang@amd.com>
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
Cc: alex.sierra@amd.com, Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 23.11.21 um 17:03 schrieb Philip Yang:
> By default this timestamp is 32 bit counter. It gets overflowed in
> around 10 minutes.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com> for the series.

> ---
>   drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> index 1d8414c3fadb..dafad6030947 100644
> --- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> @@ -160,6 +160,7 @@ static int navi10_ih_toggle_ring_interrupts(struct amdgpu_device *adev,
>   
>   	tmp = RREG32(ih_regs->ih_rb_cntl);
>   	tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, RB_ENABLE, (enable ? 1 : 0));
> +	tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, RB_GPU_TS_ENABLE, 1);
>   	/* enable_intr field is only valid in ring0 */
>   	if (ih == &adev->irq.ih)
>   		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, ENABLE_INTR, (enable ? 1 : 0));

