Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D992AC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 20 May 2022 07:52:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84B6811B76A;
	Fri, 20 May 2022 07:52:04 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8143811B765
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 May 2022 07:52:03 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id m20so14060895ejj.10
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 May 2022 00:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :references:from:in-reply-to:content-transfer-encoding;
 bh=sQ94pKnbvr+3xNdL0ajkMjzoY8s5kcu+NidMcYuwGnA=;
 b=XgvgcaHj2f54czbrpq89RltBrCSV/tWr5525NuOeJDeyJbhd5/UzkQpT2XPPG+CLAW
 30w7XOAuNwiqjmX1TYDNH43mwSZSRxf+8AX3Ub8jIHDeong60izvDgmJKgTbAZkEcsuI
 me7FfBcF+ivqgLmhDrVwsDNPY04CTD4Z2jL3smz1wKlaq+Vs1B+kkMRhg0+zjU23Yddq
 i6MkyI48U9ECR+x38bv8PmjFLR46J+NMzlbdEmqTQN1TvskTMnZINUD9B37MiInmOiyD
 IJarVkvM+Qsqd9wUGVsD1XehP4GuPT15GeaPci5vxuHiZOkQE7wHm6cHaetOqbstTLcb
 S1hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:references:from:in-reply-to
 :content-transfer-encoding;
 bh=sQ94pKnbvr+3xNdL0ajkMjzoY8s5kcu+NidMcYuwGnA=;
 b=RAsSAV6JPFIUbg7WzEXEqeBwp4u+olsnUUPKzmVagDrEsTnzXIIYhkMn1PyFb/yoea
 r01sAURMDMCVasD2+XQZHpmLK9a2zejWkB41d+UL11lo1Zm2DCqGSLRYRS9/mxEEg3AL
 9fbZqJUZVGDchS3vyYIN7/JK8X5lvhbJWJGdA9Uh3hYhb/SlSaTnH2sQMlvRiC94d69x
 BzEiA5Kl2P2V5PGFmT05nPcByhFFjLgCsOxja0tnRkN8aQKt1PsSk/qpv/4bOPRUtwp+
 +/zTmRFrVbuv+/qb4q/QGb4CclQ6pT6QjAe2ASkR/WtFkmKY0YEIHjVyjkJm/CSL1z39
 KvTA==
X-Gm-Message-State: AOAM530NwvC73heJJnAQ4gmGu5pHAgCJOAjjOmYUCwIQqHjCwbBXgR3H
 KuS/GpCRaoNZJerF3m8HIsx/pFlo1iE=
X-Google-Smtp-Source: ABdhPJzqi3YHZNqLaaw4zdSNOwPGSnS1gNeGU6iiIMchx9Qqzg64teqw5Ud8M7aZWlYTuijBPirn2Q==
X-Received: by 2002:a17:907:926:b0:6fe:9fff:fa6 with SMTP id
 au6-20020a170907092600b006fe9fff0fa6mr4634262ejc.756.1653033122017; 
 Fri, 20 May 2022 00:52:02 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:66f:9303:6022:1507?
 ([2a02:908:1256:79a0:66f:9303:6022:1507])
 by smtp.gmail.com with ESMTPSA id
 fq31-20020a1709069d9f00b006feaa22e367sm545277ejc.165.2022.05.20.00.52.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 May 2022 00:52:01 -0700 (PDT)
Message-ID: <981e5ec0-2073-3308-0f66-488300d36065@gmail.com>
Date: Fri, 20 May 2022 09:52:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] drm/amdgpu: Adjust logic around GTT size
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220519143446.74326-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220519143446.74326-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Am 19.05.22 um 16:34 schrieb Alex Deucher:
> The current somewhat strange logic is in place because certain
> GL unit tests for large textures can cause problems with the
> OOM killer since there is no way to link this memory to a
> process.  The problem is this limit is often too low for many
> modern games on systems with more memory so limit the logic to
> systems with less than 8GB of main memory.  For systems with 8
> or more GB of system memory, set the GTT size to 3/4 of system
> memory.

It's unfortunately not only the unit tests, but some games as well.

3/4 of total system memory sounds reasonable to be, but I'm 100% sure 
that this will break some tests.

Christian.

>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 25 ++++++++++++++++++++-----
>   1 file changed, 20 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 4b9ee6e27f74..daa0babcf869 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1801,15 +1801,30 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>   	/* Compute GTT size, either bsaed on 3/4th the size of RAM size
>   	 * or whatever the user passed on module init */
>   	if (amdgpu_gtt_size == -1) {
> +		const u64 eight_GB = 8192ULL * 1024 * 1024;
>   		struct sysinfo si;
> +		u64 total_memory, default_gtt_size;
>   
>   		si_meminfo(&si);
> -		gtt_size = min(max((AMDGPU_DEFAULT_GTT_SIZE_MB << 20),
> -			       adev->gmc.mc_vram_size),
> -			       ((uint64_t)si.totalram * si.mem_unit * 3/4));
> -	}
> -	else
> +		total_memory = (u64)si.totalram * si.mem_unit;
> +		default_gtt_size = total_memory * 3 / 4;
> +		/* This somewhat strange logic is in place because certain GL unit
> +		 * tests for large textures can cause problems with the OOM killer
> +		 * since there is no way to link this memory to a process.
> +		 * The problem is this limit is often too low for many modern games
> +		 * on systems with more memory so limit the logic to systems with
> +		 * less than 8GB of main memory.
> +		 */
> +		if (total_memory < eight_GB) {
> +			gtt_size = min(max((AMDGPU_DEFAULT_GTT_SIZE_MB << 20),
> +					   adev->gmc.mc_vram_size),
> +				       default_gtt_size);
> +		} else {
> +			gtt_size = default_gtt_size;
> +		}
> +	} else {
>   		gtt_size = (uint64_t)amdgpu_gtt_size << 20;
> +	}
>   
>   	/* Initialize GTT memory pool */
>   	r = amdgpu_gtt_mgr_init(adev, gtt_size);

