Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97755C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Mar 2022 12:14:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A1B710E2FC;
	Thu, 17 Mar 2022 12:14:31 +0000 (UTC)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9827F10E2FC
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Mar 2022 12:14:30 +0000 (UTC)
Received: by mail-ej1-x633.google.com with SMTP id qx21so10224397ejb.13
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Mar 2022 05:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :references:from:in-reply-to:content-transfer-encoding;
 bh=rlmqjY1QztSqnhsIcwW7orgoCezbHXRkk8wbW+1SncM=;
 b=PnUJqPlWoOCD7NBKBYlfoFITQbzRksk6Zu69npUwVfybUX3I225fJCNxcGNzusZCt6
 hnjhjPGThtje0QAGGvBzYqtbmGPlzE6s/86zMNxesWoI0NBLtVWi/vbZoLLbBjgRZrX2
 HWYXFHZXeLhhcofFnVWDpPH9NFpytcYVvO9ffNu2adaNUfnHzMdq8GKWfOWUIh/Tm7Lx
 KWy+4n5fD9DW4CFTnb2i/0UkIC1VSUqPpy8hXs4JB9MaWQxF8A7UTizv5gLI5wEyWFVa
 o4RoUTAIiGcDSMwv3Z5qT8Unh+ESb+jwgsXJ/AYPb1ccvRj9MqAJOVurInfJtvdEw2BK
 ubkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:references:from:in-reply-to
 :content-transfer-encoding;
 bh=rlmqjY1QztSqnhsIcwW7orgoCezbHXRkk8wbW+1SncM=;
 b=45ZfZwq1oql2do14j5mg2Tt6HIeGinkWDflNHHvuQb7IgmalEcoodWakUR8TOOjUvs
 wfyCcLA4/Y8kKJw4PiBK/G1oKQ4JOJqa0AyifUAbwoLW4kKYtJIERV8+z+PsBoBmZpMy
 vOZ5V04nLJd3NgOezrU7u1oMOF2YImSju2EswmD0Q5Jh4jdmVPG5YXbxf48Xz0aihNoJ
 3LxJdEn2el4Koe/sVjknAoZSs9uUG+kgUPtuSaaumyZQstIi0XGtmTG603bmFQCP6V5e
 Ho0C57AFZpV0gbuBmxsbWYw4Ace10zZpNL0LSVGI9RKy8loSc/IH+oPpMytQGRNU9xdz
 kpRg==
X-Gm-Message-State: AOAM533no827DzyS9JpRb7hW1KXhowpz/XOz8wluXccTtm6E0XQpnz45
 gl91Q01FJD1TNjxEdmdkGnDEZGv7XCE=
X-Google-Smtp-Source: ABdhPJzp3kFaQy/LeBQ1fK1plv3Ed955zN8rdFR0F9ieQRPDWOwgXgh8No22gJUWDCFy50zIXkEX1g==
X-Received: by 2002:a17:906:478b:b0:6db:8b6e:d5de with SMTP id
 cw11-20020a170906478b00b006db8b6ed5demr4221369ejc.161.1647519268998; 
 Thu, 17 Mar 2022 05:14:28 -0700 (PDT)
Received: from [192.168.178.21] (p5b0eab60.dip0.t-ipconnect.de. [91.14.171.96])
 by smtp.gmail.com with ESMTPSA id
 gv9-20020a170906f10900b006d7128b2e6fsm2332465ejb.162.2022.03.17.05.14.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Mar 2022 05:14:28 -0700 (PDT)
Message-ID: <4b9f67aa-8cff-5e7d-7d01-a382dbfb5ae6@gmail.com>
Date: Thu, 17 Mar 2022 13:14:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/amdgpu: move PDB bo release into a generic gmc
 function
Content-Language: en-US
To: Guchun Chen <guchun.chen@amd.com>, amd-gfx@lists.freedesktop.org,
 hawking.zhang@amd.com, christian.koenig@amd.com, xinhui.pan@amd.com,
 alexander.deucher@amd.com
References: <20220317112118.7411-1-guchun.chen@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220317112118.7411-1-guchun.chen@amd.com>
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

Am 17.03.22 um 12:21 schrieb Guchun Chen:
> To pair with amdgpu_gmc_pdb0_alloc as a more generic handling
> in amdgpu_gmc.c, no functional change.
>
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 6 ++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h | 1 +
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 2 +-
>   3 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 7021e8f390bd..36f6b321438f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -136,6 +136,12 @@ uint64_t amdgpu_gmc_pd_addr(struct amdgpu_bo *bo)
>   	return pd_addr;
>   }
>   
> +/* amdgpu_gmc_pdb0_free - free pdb0 vram */
> +void amdgpu_gmc_pdb0_free(struct amdgpu_device *adev)
> +{
> +	amdgpu_bo_free_kernel(&adev->gmc.pdb0_bo, NULL, &adev->gmc.ptr_pdb0);
> +}
> +

Single line function usually doesn't look that useful to me.

Why is that any improvement?

Regards,
Christian.

>   /**
>    * amdgpu_gmc_set_pte_pde - update the page tables using CPU
>    *
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> index 032b0313f277..6f425e3a9b6e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -299,6 +299,7 @@ static inline uint64_t amdgpu_gmc_sign_extend(uint64_t addr)
>   }
>   
>   int amdgpu_gmc_pdb0_alloc(struct amdgpu_device *adev);
> +void amdgpu_gmc_pdb0_free(struct amdgpu_device *adev);
>   void amdgpu_gmc_get_pde_for_bo(struct amdgpu_bo *bo, int level,
>   			       uint64_t *addr, uint64_t *flags);
>   int amdgpu_gmc_set_pte_pde(struct amdgpu_device *adev, void *cpu_pt_addr,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 08ceabd6c853..ad600f72a51c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1721,7 +1721,7 @@ static int gmc_v9_0_sw_fini(void *handle)
>   	amdgpu_gem_force_release(adev);
>   	amdgpu_vm_manager_fini(adev);
>   	amdgpu_gart_table_vram_free(adev);
> -	amdgpu_bo_free_kernel(&adev->gmc.pdb0_bo, NULL, &adev->gmc.ptr_pdb0);
> +	amdgpu_gmc_pdb0_free(adev);
>   	amdgpu_bo_fini(adev);
>   
>   	return 0;

