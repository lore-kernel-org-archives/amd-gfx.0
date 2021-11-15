Return-Path: <SRS0=ctnh=QC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F4C7C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Nov 2021 13:42:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11CCC61B2A
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Nov 2021 13:42:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 11CCC61B2A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8CC16E4AF;
	Mon, 15 Nov 2021 13:42:26 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE20C6E4AF
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Nov 2021 13:42:24 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id z200so14007463wmc.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Nov 2021 05:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=fOv3sW9sd8vLrzahKXKSo4wT9Vpic2eRjBKIJO57vv0=;
 b=V2MvYZ4zBazKA4A78HOaAHDP8IdvG3u472V7AfMwX927fXHR2KuoU3HkXBh76+aIPA
 iJMh4eObhF7YlW6FDfBouDovfEuDBbwJwJXpsnDuWMW/BkYDWDJhMy6t93PwMROWVBCu
 UExk3f9UxEtHqgZOBvCdjNA8hGbqvJcOWypD0gTmRVUalreFDL8VJLMxrzxAvoEIAYFR
 LFLlqLEqH1YPsxUreNugWdxcBEfdmdZTRYmC5fUSu2xcn5rIxNZdvnl6oAej26zMHK9c
 eACTNIfP2mV/i2daJQJ2P4eQa4eVEIfYsYIPhXtE17pmBv7FzEGUvTCQ4Nn+EB5ndei5
 wXVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=fOv3sW9sd8vLrzahKXKSo4wT9Vpic2eRjBKIJO57vv0=;
 b=OlYuHJv+NTezN6S8/ydF2yZjj63V3JgX/c+7fYU7kilXkx71JExvJayfyZzA1MEetV
 YvL72muiqcQQi5RI120b1VflAzPAJuga6jUYjzysdx129vcgQISfox9CrXCOdZxQ1y3k
 /JynNZozkLDZ1XQ27rTKfaD2Yq7wtu7zmoCYkjEonI5LTiXzjxKuUlNz526I2FzI/c9C
 iSwG2f0u7sOC9H+vpnEFgskDcryIlN31DVsUICTkzOw9186R6hcXIY6gVPQlyGuhkBEm
 fiCg95BPvInHONkJDWnHcs2+YGQ0WiEKO14T/jHsu+pLJpDqktYk8ikEPaCvlK3qNDtr
 FNow==
X-Gm-Message-State: AOAM532Jb6ZEjt4z+LBoJNwoIAl6U8K5Ul6DxNooIJmAxXp0hHoNtOik
 F1O/57uein3j0nWvQONgANU=
X-Google-Smtp-Source: ABdhPJxBnLbWm+aDTXSBVOjkRUjEoM4g86GmeHVutV/mc0RPAKY/C2wYwRdcwyfvR9AInJfSdw5mqg==
X-Received: by 2002:a1c:98ca:: with SMTP id
 a193mr42947915wme.162.1636983743552; 
 Mon, 15 Nov 2021 05:42:23 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:bf0c:d52c:6ba0:cfc6?
 ([2a02:908:1252:fb60:bf0c:d52c:6ba0:cfc6])
 by smtp.gmail.com with ESMTPSA id g4sm13987185wro.12.2021.11.15.05.42.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Nov 2021 05:42:23 -0800 (PST)
Subject: Re: [PATCH 1/2] drm/amdgpu: IH process reset count when restart
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211113000509.21407-1-Philip.Yang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <ef304329-ccdf-8a74-fb2e-52e8deae33d4@gmail.com>
Date: Mon, 15 Nov 2021 14:42:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211113000509.21407-1-Philip.Yang@amd.com>
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
Cc: Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 13.11.21 um 01:05 schrieb Philip Yang:
> Otherwise when IH process restart, count is zero, the loop will
> not exit to wake_up_all after processing AMDGPU_IH_MAX_NUM_IVS
> interrupts.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

Maybe even CC: stable?

Regards,
Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> index f3d62e196901..0c7963dfacad 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> @@ -223,7 +223,7 @@ int amdgpu_ih_wait_on_checkpoint_process(struct amdgpu_device *adev,
>    */
>   int amdgpu_ih_process(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih)
>   {
> -	unsigned int count = AMDGPU_IH_MAX_NUM_IVS;
> +	unsigned int count;
>   	u32 wptr;
>   
>   	if (!ih->enabled || adev->shutdown)
> @@ -232,6 +232,7 @@ int amdgpu_ih_process(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih)
>   	wptr = amdgpu_ih_get_wptr(adev, ih);
>   
>   restart_ih:
> +	count  = AMDGPU_IH_MAX_NUM_IVS;
>   	DRM_DEBUG("%s: rptr %d, wptr %d\n", __func__, ih->rptr, wptr);
>   
>   	/* Order reading of wptr vs. reading of IH ring data */

