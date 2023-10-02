Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F991E7849A
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Oct 2023 10:24:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB17C10E278;
	Mon,  2 Oct 2023 10:24:52 +0000 (UTC)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3333010E278
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Oct 2023 10:24:49 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3226cc3e324so15180483f8f.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Oct 2023 03:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696242287; x=1696847087; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Q8F671rQmTT1y5HFjhWw6BNpg6a9AlEc41bJK1LrTBI=;
 b=ikhV4PFc7GOcXFmA58gO7mKJH0N+dDrgIhhfaK0IPsHLfXeX6NXxXgGASiu31/c8Gg
 p4l5LLUAv1z6PaeZgBZ+OElUhirrd1MJx4QeSJJGTGkAxl7f5p2roTKO3Y17sroruRG0
 6uqe8cweDZFsIrOgVwURX/tfFN42ndbOYiKzBdyDRpKru2pHbSRc9J3BZF6kyZXmx3pX
 5LsQxMStOLgeDb4TUxNpnp66b2LEpandc+Mu06p0VnLGcPEQW+8Plj1Ok/pbFna39yvT
 qIJntQ8QRbTTie8hpti+JzgU6XX6RC2G+1P/KeGed+Gbs+8JkcDStD/i7+Ugi11+1Us+
 fJHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696242287; x=1696847087;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q8F671rQmTT1y5HFjhWw6BNpg6a9AlEc41bJK1LrTBI=;
 b=UDfPfLbuvEwb4BkDkw6wpxoRqnS3qcCVIzqbnr1HI/TWocneuU2Bs8ZIii7EcBIQu0
 OPXHueGkkzK5iKamKZi4xyJyyQQyzrrPrbqtrCbxRUJD7FcJqEJRJ42t8liCtv45CC5I
 yJmIQNL5oNnzX1OC6gSuafQdfojMumkM7nqvkdgU9gqoNWWmMBoVXs7qp5k0fXdiwMzV
 QqTYT5yRli8sMTmfQMgQh6vaHgR6QhUJvBV76M63BUHg1fW6AoSBW91eeFGMqFoie5Na
 Fx9kuid/8ncbPSTSF0Pc+ThS6Zg+PzHTg+4lwpIecc6b7V2s9559NFxmkAAn/gw/0SBE
 XhgQ==
X-Gm-Message-State: AOJu0Yx0WHsHrIaooXmEpkINckUtBDGpxldXP4r4am4I868dk5jhfuhe
 hmYzHG1OX/4a1sd59girtQk=
X-Google-Smtp-Source: AGHT+IHMEzXmy72QEYcA7HTYduq102KMGwYzsEcXRWCB+314aFHcyAgHlBUjwEkiqL3QjGdqsSi7bA==
X-Received: by 2002:a5d:6942:0:b0:316:f3cf:6f12 with SMTP id
 r2-20020a5d6942000000b00316f3cf6f12mr9550573wrw.48.1696242287253; 
 Mon, 02 Oct 2023 03:24:47 -0700 (PDT)
Received: from [10.254.108.106] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 e9-20020adfe7c9000000b003197efd1e7bsm13775969wrn.114.2023.10.02.03.24.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Oct 2023 03:24:46 -0700 (PDT)
Message-ID: <82d52efe-0daa-e086-dabf-df19d4e95dc3@gmail.com>
Date: Mon, 2 Oct 2023 12:24:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] drm/amdkfd: ratelimited override pte flags messages
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230928222212.17006-1-Philip.Yang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230928222212.17006-1-Philip.Yang@amd.com>
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
Cc: Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 29.09.23 um 00:22 schrieb Philip Yang:
> Use ratelimited version of dev_dbg to avoid flooding dmesg log. No
> functional change.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c |  2 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c     | 16 ++++++++--------
>   2 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index 96d601e209b8..6d2878684287 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -848,7 +848,7 @@ static void amdgpu_vm_pte_update_flags(struct amdgpu_vm_update_params *params,
>   			amdgpu_gmc_override_vm_pte_flags(adev, params->vm,
>   							 addr, &flags);
>   		else
> -			dev_dbg(adev->dev,
> +			dev_dbg_ratelimited(adev->dev,
>   				"override_vm_pte_flags skipped: non-contiguous\n");

I don't see any value in this in the first place. We should probably 
drop the message altogether.

Christian.

>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 6b15677c0314..ad0d63472e17 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1244,7 +1244,7 @@ static void gmc_v9_0_override_vm_pte_flags(struct amdgpu_device *adev,
>   	 * the DMA address.
>   	 */
>   	if (!adev->ram_is_direct_mapped) {
> -		dev_dbg(adev->dev, "RAM is not direct mapped\n");
> +		dev_dbg_ratelimited(adev->dev, "RAM is not direct mapped\n");
>   		return;
>   	}
>   
> @@ -1253,7 +1253,7 @@ static void gmc_v9_0_override_vm_pte_flags(struct amdgpu_device *adev,
>   	 */
>   	if ((*flags & AMDGPU_PTE_MTYPE_VG10_MASK) !=
>   	    AMDGPU_PTE_MTYPE_VG10(MTYPE_NC)) {
> -		dev_dbg(adev->dev, "MTYPE is not NC\n");
> +		dev_dbg_ratelimited(adev->dev, "MTYPE is not NC\n");
>   		return;
>   	}
>   
> @@ -1264,7 +1264,7 @@ static void gmc_v9_0_override_vm_pte_flags(struct amdgpu_device *adev,
>   	if (adev->gmc.is_app_apu && vm->mem_id >= 0) {
>   		local_node = adev->gmc.mem_partitions[vm->mem_id].numa.node;
>   	} else {
> -		dev_dbg(adev->dev, "Only native mode APU is supported.\n");
> +		dev_dbg_ratelimited(adev->dev, "Only native mode APU is supported.\n");
>   		return;
>   	}
>   
> @@ -1272,12 +1272,12 @@ static void gmc_v9_0_override_vm_pte_flags(struct amdgpu_device *adev,
>   	 * page or NUMA nodes.
>   	 */
>   	if (!page_is_ram(addr >> PAGE_SHIFT)) {
> -		dev_dbg(adev->dev, "Page is not RAM.\n");
> +		dev_dbg_ratelimited(adev->dev, "Page is not RAM.\n");
>   		return;
>   	}
>   	nid = pfn_to_nid(addr >> PAGE_SHIFT);
> -	dev_dbg(adev->dev, "vm->mem_id=%d, local_node=%d, nid=%d\n",
> -		vm->mem_id, local_node, nid);
> +	dev_dbg_ratelimited(adev->dev, "vm->mem_id=%d, local_node=%d, nid=%d\n",
> +			    vm->mem_id, local_node, nid);
>   	if (nid == local_node) {
>   		uint64_t old_flags = *flags;
>   		unsigned int mtype_local = MTYPE_RW;
> @@ -1289,8 +1289,8 @@ static void gmc_v9_0_override_vm_pte_flags(struct amdgpu_device *adev,
>   
>   		*flags = (*flags & ~AMDGPU_PTE_MTYPE_VG10_MASK) |
>   			 AMDGPU_PTE_MTYPE_VG10(mtype_local);
> -		dev_dbg(adev->dev, "flags updated from %llx to %llx\n",
> -			old_flags, *flags);
> +		dev_dbg_ratelimited(adev->dev, "flags updated from %llx to %llx\n",
> +				    old_flags, *flags);
>   	}
>   }
>   

