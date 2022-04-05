Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5174C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Apr 2022 06:01:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE48810EC38;
	Tue,  5 Apr 2022 06:01:56 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6529210EC38
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Apr 2022 06:01:55 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id q20so7267288wmq.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Apr 2022 23:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=/ZSnIDwDVsY6N8nrQWG5Om3QMekH7SN4M8O5EubAOis=;
 b=V607SjriF9tw/L/0tigKDo3rs/VjaXowbs+O/633Wq2jxcRNmgUf1ojimZsQXEPeL+
 P/LGFt69QVd/1qh8otosSnnAuXDQ2n3CcsuGQslsKTHatccUWGZI6p7Hel4u2cPGNcTF
 MaOtylq7ivoLEBAnNBxVucjHlsgGZtFOqVVRIwLmhNuXft+1gv8IsmQFEL8ZsxVrEMPF
 cHmjsvnKcpDByJQ2cEAaSZshixHM41SA2gDh6YVE+M5xlWDuwj4S+g5TBfGLdwbhO/rG
 S9/BMH5zBYGWgNDUZImscYl3D10uL0X2Qx2LQ5FjmnREmB2XR3PMz4q7ywHEPeiXsTyB
 o4HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=/ZSnIDwDVsY6N8nrQWG5Om3QMekH7SN4M8O5EubAOis=;
 b=QNmpDYXmT9BphVpjt8ofwHOh3yy0Ycgv2JKbOzKC2R/7vfrez6EhUx1ZvHRYmN2lRM
 NAwk+uz7mTSQkSCh1ZWZtwbpdMjC8UzFVlEmSg1GmE5aqe5jhIRySO07AqTi7D9D45Ma
 pbqVA+DVy9mlNA/tBlu3L49PsLi30FsXEaj1h+o4C/N4XKkG7HKut1XsGc1P2jufrPCf
 CKeABUveg3xAWLiKy0BF8Uko/ZqqI21mPpmnQ45yyAGdcUxqCgK4CGvOAxnBafHWjS6s
 072qu0F7PrCel09td7zpXUGx9pTMoJQ9XoPkbZj+caKfCmAFxGEg8oLhKcWmMY8jDSlo
 x2YQ==
X-Gm-Message-State: AOAM530J3Kqx9E3sy0XlgRD0NVcacZBEDvy6ReK0sNnt0C17C+VA1h9g
 OCPzAZcWADcCi0iV85YC67Y=
X-Google-Smtp-Source: ABdhPJw4xeCnfvSsyNDuq7MJlVtY2BVaNIOG9ceNbieEZ41T/G8d4rL3H2gw+b8mejb/sD35yi4Vlw==
X-Received: by 2002:a05:600c:3589:b0:38c:d35f:7d18 with SMTP id
 p9-20020a05600c358900b0038cd35f7d18mr1519429wmq.30.1649138513769; 
 Mon, 04 Apr 2022 23:01:53 -0700 (PDT)
Received: from [192.168.178.21] (p5b0eab60.dip0.t-ipconnect.de. [91.14.171.96])
 by smtp.gmail.com with ESMTPSA id
 v15-20020a056000144f00b002057eac999fsm11455224wrx.76.2022.04.04.23.01.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Apr 2022 23:01:52 -0700 (PDT)
Message-ID: <9a306200-b9ae-cbf7-7ca4-73a9c1f80d01@gmail.com>
Date: Tue, 5 Apr 2022 08:01:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/1] drm/amdkfd: Add missing NULL check in
 svm_range_map_to_gpu
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220404214255.11902-1-Philip.Yang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220404214255.11902-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 04.04.22 um 23:42 schrieb Philip Yang:
> bo_adev is NULL for system memory mapping to GPU.
>
> Fixes: 05fe8eeca92 (drm/amdgpu: fix TLB flushing during eviction)
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 907b02045824..d3fb2d0b5a25 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1281,7 +1281,7 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
>   					   last_start, prange->start + i,
>   					   pte_flags,
>   					   last_start - prange->start,
> -					   bo_adev->vm_manager.vram_base_offset,
> +					   bo_adev ? bo_adev->vm_manager.vram_base_offset : 0,
>   					   NULL, dma_addr, &vm->last_update);
>   
>   		for (j = last_start - prange->start; j <= i; j++)

