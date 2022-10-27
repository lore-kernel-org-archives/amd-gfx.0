Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1C46C67871
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Oct 2022 06:32:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFC8C10E0CA;
	Thu, 27 Oct 2022 06:32:56 +0000 (UTC)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86FD310E0CA
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Oct 2022 06:32:53 +0000 (UTC)
Received: by mail-lj1-x22d.google.com with SMTP id b8so978011ljf.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Oct 2022 23:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZDNdsffqdQciuXazvGIPKKu/b0B9lL4Q4veLWnXy99Q=;
 b=LZxfB4USkUpRfPGPq5remzOtpXbRx5DlcKIptqAZ3lkBPDwfAakqbtD88V+3m42H/W
 LxGlqKAKzQcJiQVs5TbtYuZCU1Z9yt/ymkP41XWr3LEP/DZazvAiOmHFXkCNCHw0v8Ww
 VEYagKG/6O+OOMVIxYqYgiyrP8Hw3DH2JRvWaAroWDNRx5tbgix47sFKTmZwZ57eF11q
 yPFeM4M2zv8KDTdh1Mzt4GaVXUF8km3Y2pLOQym2x1qQHkeXVU5rBO5ZGaA0ZiGx0rPi
 31UScEoBkOR2XKRWeeCbr/h5+blckNLPaSyYuCA+wF+HsJm+no4cq8DZ7y4YK//pa6ct
 g7fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZDNdsffqdQciuXazvGIPKKu/b0B9lL4Q4veLWnXy99Q=;
 b=hFlMflAcLKnRuFENuoe2j1d4hSzBlVhTpO/JdyNgx5q9pUvxaXJDCdTItccvUHzYYM
 WLqrvcbjHTLQEpchoXxaevnZ8bLbUjzyAiDpFHdP5LXjHuqi7kRfECLl3LkWzQEppjEn
 hdoC8nc/YkvTbbilLxws042keJ6c/JSprE7msjQR+bBKRU+VE+PC9KVEOsnGPDIAeinp
 p45MENPkySF7eYJpVOr4jhq5fGC/NE/WQTM0diPNsXvM+0RAFhZeXvhUUdON+8pwXTJF
 zyn7v7EVswslpzqYRNFmuL3IhfOrR/Y1X2CDj/oi717pkpZy6xcT4kuexz3TnPsDp62R
 6juA==
X-Gm-Message-State: ACrzQf0zB2Cmz/pUK+3r13ZN46mo6F2Y306tb79TKTHLROtJ8HYnaT7W
 EnVkRXyk6QoRhlpgFJ7LS7ppNQgJyYA=
X-Google-Smtp-Source: AMsMyM4fgQApA7ZTb/qUJDJ2zMSXKiuEFP8inj6NPnPoQjYYw4LLNKF1VwNrpOmi2DdmFJbRaSkQJA==
X-Received: by 2002:a17:907:74e:b0:74f:83d4:cf58 with SMTP id
 xc14-20020a170907074e00b0074f83d4cf58mr41399035ejb.178.1666852360777; 
 Wed, 26 Oct 2022 23:32:40 -0700 (PDT)
Received: from [192.168.178.21] (p5b0ea229.dip0.t-ipconnect.de. [91.14.162.41])
 by smtp.gmail.com with ESMTPSA id
 cd13-20020a170906b34d00b0077a1dd3e7b7sm278963ejb.102.2022.10.26.23.32.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Oct 2022 23:32:40 -0700 (PDT)
Message-ID: <33d405d9-7ee7-873e-5a71-9c48cb0e5020@gmail.com>
Date: Thu, 27 Oct 2022 08:32:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amdkfd: Cleanup kfd_dev struct
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221026193645.4132096-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20221026193645.4132096-1-alexander.deucher@amd.com>
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
Cc: Amber Lin <Amber.Lin@amd.com>, Mukul Joshi <mukul.joshi@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 26.10.22 um 21:36 schrieb Alex Deucher:
> From: Mukul Joshi <mukul.joshi@amd.com>
>
> Cleanup kfd_dev struct by removing ddev and pdev as both
> drm_device and pci_dev can be fetched from amdgpu_device.
>
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
> Tested-by: Amber Lin <Amber.Lin@amd.com>
> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

Should we go even a step further and make the kfd dev a member of the 
adev structure so that we can upcast?

Regards,
Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  3 +--
>   drivers/gpu/drm/amd/amdkfd/kfd_crat.c      | 12 ++++-----
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c    | 16 +++++-------
>   drivers/gpu/drm/amd/amdkfd/kfd_iommu.c     | 29 +++++++++++-----------
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h      |  4 +--
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c   | 12 ++++-----
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c       |  2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c  | 25 +++++++++----------
>   9 files changed, 49 insertions(+), 56 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 0561812aa0a4..e2b0f8049b9f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -195,7 +195,7 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
>   		}
>   
>   		adev->kfd.init_complete = kgd2kfd_device_init(adev->kfd.dev,
> -						adev_to_drm(adev), &gpu_resources);
> +							&gpu_resources);
>   
>   		amdgpu_amdkfd_total_mem_size += adev->gmc.real_vram_size;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 647220a8762d..f50e3ba4d7a5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -353,7 +353,6 @@ int kgd2kfd_init(void);
>   void kgd2kfd_exit(void);
>   struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf);
>   bool kgd2kfd_device_init(struct kfd_dev *kfd,
> -			 struct drm_device *ddev,
>   			 const struct kgd2kfd_shared_resources *gpu_resources);
>   void kgd2kfd_device_exit(struct kfd_dev *kfd);
>   void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm);
> @@ -381,7 +380,7 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
>   }
>   
>   static inline
> -bool kgd2kfd_device_init(struct kfd_dev *kfd, struct drm_device *ddev,
> +bool kgd2kfd_device_init(struct kfd_dev *kfd,
>   				const struct kgd2kfd_shared_resources *gpu_resources)
>   {
>   	return false;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> index 3c771d580098..acb8bc29218b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -2115,8 +2115,8 @@ static void kfd_find_numa_node_in_srat(struct kfd_dev *kdev)
>   	struct acpi_table_header *table_header = NULL;
>   	struct acpi_subtable_header *sub_header = NULL;
>   	unsigned long table_end, subtable_len;
> -	u32 pci_id = pci_domain_nr(kdev->pdev->bus) << 16 |
> -			pci_dev_id(kdev->pdev);
> +	u32 pci_id = pci_domain_nr(kdev->adev->pdev->bus) << 16 |
> +			pci_dev_id(kdev->adev->pdev);
>   	u32 bdf;
>   	acpi_status status;
>   	struct acpi_srat_cpu_affinity *cpu;
> @@ -2191,7 +2191,7 @@ static void kfd_find_numa_node_in_srat(struct kfd_dev *kdev)
>   		numa_node = 0;
>   
>   	if (numa_node != NUMA_NO_NODE)
> -		set_dev_node(&kdev->pdev->dev, numa_node);
> +		set_dev_node(&kdev->adev->pdev->dev, numa_node);
>   }
>   #endif
>   
> @@ -2252,14 +2252,14 @@ static int kfd_fill_gpu_direct_io_link_to_cpu(int *avail_size,
>   	sub_type_hdr->proximity_domain_from = proximity_domain;
>   
>   #ifdef CONFIG_ACPI_NUMA
> -	if (kdev->pdev->dev.numa_node == NUMA_NO_NODE)
> +	if (kdev->adev->pdev->dev.numa_node == NUMA_NO_NODE)
>   		kfd_find_numa_node_in_srat(kdev);
>   #endif
>   #ifdef CONFIG_NUMA
> -	if (kdev->pdev->dev.numa_node == NUMA_NO_NODE)
> +	if (kdev->adev->pdev->dev.numa_node == NUMA_NO_NODE)
>   		sub_type_hdr->proximity_domain_to = 0;
>   	else
> -		sub_type_hdr->proximity_domain_to = kdev->pdev->dev.numa_node;
> +		sub_type_hdr->proximity_domain_to = kdev->adev->pdev->dev.numa_node;
>   #else
>   	sub_type_hdr->proximity_domain_to = 0;
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index be7a0b5a2dbc..909397fdb7d8 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -228,7 +228,6 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
>   {
>   	struct kfd_dev *kfd = NULL;
>   	const struct kfd2kgd_calls *f2g = NULL;
> -	struct pci_dev *pdev = adev->pdev;
>   	uint32_t gfx_target_version = 0;
>   
>   	switch (adev->asic_type) {
> @@ -430,7 +429,6 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
>   
>   	kfd->adev = adev;
>   	kfd_device_info_init(kfd, vf, gfx_target_version);
> -	kfd->pdev = pdev;
>   	kfd->init_complete = false;
>   	kfd->kfd2kgd = f2g;
>   	atomic_set(&kfd->compute_profile, 0);
> @@ -512,12 +510,10 @@ static void kfd_smi_init(struct kfd_dev *dev)
>   }
>   
>   bool kgd2kfd_device_init(struct kfd_dev *kfd,
> -			 struct drm_device *ddev,
>   			 const struct kgd2kfd_shared_resources *gpu_resources)
>   {
>   	unsigned int size, map_process_packet_size;
>   
> -	kfd->ddev = ddev;
>   	kfd->mec_fw_version = amdgpu_amdkfd_get_fw_version(kfd->adev,
>   			KGD_ENGINE_MEC1);
>   	kfd->mec2_fw_version = amdgpu_amdkfd_get_fw_version(kfd->adev,
> @@ -542,7 +538,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>   	     kfd->mec_fw_version < kfd->device_info.no_atomic_fw_version)) {
>   		dev_info(kfd_device,
>   			 "skipped device %x:%x, PCI rejects atomics %d<%d\n",
> -			 kfd->pdev->vendor, kfd->pdev->device,
> +			 kfd->adev->pdev->vendor, kfd->adev->pdev->device,
>   			 kfd->mec_fw_version,
>   			 kfd->device_info.no_atomic_fw_version);
>   		return false;
> @@ -651,8 +647,8 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>   	kfd_smi_init(kfd);
>   
>   	kfd->init_complete = true;
> -	dev_info(kfd_device, "added device %x:%x\n", kfd->pdev->vendor,
> -		 kfd->pdev->device);
> +	dev_info(kfd_device, "added device %x:%x\n", kfd->adev->pdev->vendor,
> +		 kfd->adev->pdev->device);
>   
>   	pr_debug("Starting kfd with the following scheduling policy %d\n",
>   		kfd->dqm->sched_policy);
> @@ -677,7 +673,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>   		amdgpu_amdkfd_free_gws(kfd->adev, kfd->gws);
>   	dev_err(kfd_device,
>   		"device %x:%x NOT added due to errors\n",
> -		kfd->pdev->vendor, kfd->pdev->device);
> +		kfd->adev->pdev->vendor, kfd->adev->pdev->device);
>   out:
>   	return kfd->init_complete;
>   }
> @@ -790,7 +786,7 @@ int kgd2kfd_resume_iommu(struct kfd_dev *kfd)
>   	if (err)
>   		dev_err(kfd_device,
>   			"Failed to resume IOMMU for device %x:%x\n",
> -			kfd->pdev->vendor, kfd->pdev->device);
> +			kfd->adev->pdev->vendor, kfd->adev->pdev->device);
>   	return err;
>   }
>   
> @@ -802,7 +798,7 @@ static int kfd_resume(struct kfd_dev *kfd)
>   	if (err)
>   		dev_err(kfd_device,
>   			"Error starting queue manager for device %x:%x\n",
> -			kfd->pdev->vendor, kfd->pdev->device);
> +			kfd->adev->pdev->vendor, kfd->adev->pdev->device);
>   
>   	return err;
>   }
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c b/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
> index fbd0afe4da42..ec1bf611624e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
> @@ -49,7 +49,7 @@ int kfd_iommu_check_device(struct kfd_dev *kfd)
>   		return -ENODEV;
>   
>   	iommu_info.flags = 0;
> -	err = amd_iommu_device_info(kfd->pdev, &iommu_info);
> +	err = amd_iommu_device_info(kfd->adev->pdev, &iommu_info);
>   	if (err)
>   		return err;
>   
> @@ -71,7 +71,7 @@ int kfd_iommu_device_init(struct kfd_dev *kfd)
>   		return 0;
>   
>   	iommu_info.flags = 0;
> -	err = amd_iommu_device_info(kfd->pdev, &iommu_info);
> +	err = amd_iommu_device_info(kfd->adev->pdev, &iommu_info);
>   	if (err < 0) {
>   		dev_err(kfd_device,
>   			"error getting iommu info. is the iommu enabled?\n");
> @@ -121,7 +121,7 @@ int kfd_iommu_bind_process_to_device(struct kfd_process_device *pdd)
>   		return -EINVAL;
>   	}
>   
> -	err = amd_iommu_bind_pasid(dev->pdev, p->pasid, p->lead_thread);
> +	err = amd_iommu_bind_pasid(dev->adev->pdev, p->pasid, p->lead_thread);
>   	if (!err)
>   		pdd->bound = PDD_BOUND;
>   
> @@ -139,7 +139,8 @@ void kfd_iommu_unbind_process(struct kfd_process *p)
>   
>   	for (i = 0; i < p->n_pdds; i++)
>   		if (p->pdds[i]->bound == PDD_BOUND)
> -			amd_iommu_unbind_pasid(p->pdds[i]->dev->pdev, p->pasid);
> +			amd_iommu_unbind_pasid(p->pdds[i]->dev->adev->pdev,
> +					       p->pasid);
>   }
>   
>   /* Callback for process shutdown invoked by the IOMMU driver */
> @@ -222,7 +223,7 @@ static int kfd_bind_processes_to_device(struct kfd_dev *kfd)
>   			continue;
>   		}
>   
> -		err = amd_iommu_bind_pasid(kfd->pdev, p->pasid,
> +		err = amd_iommu_bind_pasid(kfd->adev->pdev, p->pasid,
>   				p->lead_thread);
>   		if (err < 0) {
>   			pr_err("Unexpected pasid 0x%x binding failure\n",
> @@ -282,9 +283,9 @@ void kfd_iommu_suspend(struct kfd_dev *kfd)
>   
>   	kfd_unbind_processes_from_device(kfd);
>   
> -	amd_iommu_set_invalidate_ctx_cb(kfd->pdev, NULL);
> -	amd_iommu_set_invalid_ppr_cb(kfd->pdev, NULL);
> -	amd_iommu_free_device(kfd->pdev);
> +	amd_iommu_set_invalidate_ctx_cb(kfd->adev->pdev, NULL);
> +	amd_iommu_set_invalid_ppr_cb(kfd->adev->pdev, NULL);
> +	amd_iommu_free_device(kfd->adev->pdev);
>   }
>   
>   /** kfd_iommu_resume - Restore IOMMU after resume
> @@ -302,20 +303,20 @@ int kfd_iommu_resume(struct kfd_dev *kfd)
>   
>   	pasid_limit = kfd_get_pasid_limit();
>   
> -	err = amd_iommu_init_device(kfd->pdev, pasid_limit);
> +	err = amd_iommu_init_device(kfd->adev->pdev, pasid_limit);
>   	if (err)
>   		return -ENXIO;
>   
> -	amd_iommu_set_invalidate_ctx_cb(kfd->pdev,
> +	amd_iommu_set_invalidate_ctx_cb(kfd->adev->pdev,
>   					iommu_pasid_shutdown_callback);
> -	amd_iommu_set_invalid_ppr_cb(kfd->pdev,
> +	amd_iommu_set_invalid_ppr_cb(kfd->adev->pdev,
>   				     iommu_invalid_ppr_cb);
>   
>   	err = kfd_bind_processes_to_device(kfd);
>   	if (err) {
> -		amd_iommu_set_invalidate_ctx_cb(kfd->pdev, NULL);
> -		amd_iommu_set_invalid_ppr_cb(kfd->pdev, NULL);
> -		amd_iommu_free_device(kfd->pdev);
> +		amd_iommu_set_invalidate_ctx_cb(kfd->adev->pdev, NULL);
> +		amd_iommu_set_invalid_ppr_cb(kfd->adev->pdev, NULL);
> +		amd_iommu_free_device(kfd->adev->pdev);
>   		return err;
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index bf610e3b683b..552c3ac85a13 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -254,8 +254,6 @@ struct kfd_dev {
>   	struct amdgpu_device *adev;
>   
>   	struct kfd_device_info device_info;
> -	struct pci_dev *pdev;
> -	struct drm_device *ddev;
>   
>   	unsigned int id;		/* topology stub index */
>   
> @@ -1365,7 +1363,7 @@ void kfd_dec_compute_active(struct kfd_dev *dev);
>   static inline int kfd_devcgroup_check_permission(struct kfd_dev *kfd)
>   {
>   #if defined(CONFIG_CGROUP_DEVICE) || defined(CONFIG_CGROUP_BPF)
> -	struct drm_device *ddev = kfd->ddev;
> +	struct drm_device *ddev = adev_to_drm(kfd->adev);
>   
>   	return devcgroup_check_permission(DEVCG_DEV_CHAR, DRM_MAJOR,
>   					  ddev->render->index,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 951b63677248..a26257171ab7 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1050,8 +1050,8 @@ static void kfd_process_destroy_pdds(struct kfd_process *p)
>   		 * for auto suspend
>   		 */
>   		if (pdd->runtime_inuse) {
> -			pm_runtime_mark_last_busy(pdd->dev->ddev->dev);
> -			pm_runtime_put_autosuspend(pdd->dev->ddev->dev);
> +			pm_runtime_mark_last_busy(adev_to_drm(pdd->dev->adev)->dev);
> +			pm_runtime_put_autosuspend(adev_to_drm(pdd->dev->adev)->dev);
>   			pdd->runtime_inuse = false;
>   		}
>   
> @@ -1633,9 +1633,9 @@ struct kfd_process_device *kfd_bind_process_to_device(struct kfd_dev *dev,
>   	 * pdd is destroyed.
>   	 */
>   	if (!pdd->runtime_inuse) {
> -		err = pm_runtime_get_sync(dev->ddev->dev);
> +		err = pm_runtime_get_sync(adev_to_drm(dev->adev)->dev);
>   		if (err < 0) {
> -			pm_runtime_put_autosuspend(dev->ddev->dev);
> +			pm_runtime_put_autosuspend(adev_to_drm(dev->adev)->dev);
>   			return ERR_PTR(err);
>   		}
>   	}
> @@ -1655,8 +1655,8 @@ struct kfd_process_device *kfd_bind_process_to_device(struct kfd_dev *dev,
>   out:
>   	/* balance runpm reference count and exit with error */
>   	if (!pdd->runtime_inuse) {
> -		pm_runtime_mark_last_busy(dev->ddev->dev);
> -		pm_runtime_put_autosuspend(dev->ddev->dev);
> +		pm_runtime_mark_last_busy(adev_to_drm(dev->adev)->dev);
> +		pm_runtime_put_autosuspend(adev_to_drm(dev->adev)->dev);
>   	}
>   
>   	return ERR_PTR(err);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index af4140685bf3..39fbe19b978a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -259,7 +259,7 @@ void svm_range_free_dma_mappings(struct svm_range *prange)
>   			pr_debug("failed to find device idx %d\n", gpuidx);
>   			continue;
>   		}
> -		dev = &pdd->dev->pdev->dev;
> +		dev = &pdd->dev->adev->pdev->dev;
>   		svm_range_dma_unmap(dev, dma_addr, 0, prange->npages);
>   		kvfree(dma_addr);
>   		prange->dma_addr[gpuidx] = NULL;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index 3f0a4a415907..ec8c9c10d348 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -115,7 +115,7 @@ struct kfd_dev *kfd_device_by_pci_dev(const struct pci_dev *pdev)
>   	down_read(&topology_lock);
>   
>   	list_for_each_entry(top_dev, &topology_device_list, list)
> -		if (top_dev->gpu && top_dev->gpu->pdev == pdev) {
> +		if (top_dev->gpu && top_dev->gpu->adev->pdev == pdev) {
>   			device = top_dev->gpu;
>   			break;
>   		}
> @@ -1169,13 +1169,12 @@ static uint32_t kfd_generate_gpu_id(struct kfd_dev *gpu)
>   
>   	local_mem_size = gpu->local_mem_info.local_mem_size_private +
>   			gpu->local_mem_info.local_mem_size_public;
> -
> -	buf[0] = gpu->pdev->devfn;
> -	buf[1] = gpu->pdev->subsystem_vendor |
> -		(gpu->pdev->subsystem_device << 16);
> -	buf[2] = pci_domain_nr(gpu->pdev->bus);
> -	buf[3] = gpu->pdev->device;
> -	buf[4] = gpu->pdev->bus->number;
> +	buf[0] = gpu->adev->pdev->devfn;
> +	buf[1] = gpu->adev->pdev->subsystem_vendor |
> +		(gpu->adev->pdev->subsystem_device << 16);
> +	buf[2] = pci_domain_nr(gpu->adev->pdev->bus);
> +	buf[3] = gpu->adev->pdev->device;
> +	buf[4] = gpu->adev->pdev->bus->number;
>   	buf[5] = lower_32_bits(local_mem_size);
>   	buf[6] = upper_32_bits(local_mem_size);
>   
> @@ -1269,7 +1268,7 @@ static void kfd_set_iolink_no_atomics(struct kfd_topology_device *dev,
>   	if (target_gpu_dev) {
>   		uint32_t cap;
>   
> -		pcie_capability_read_dword(target_gpu_dev->gpu->pdev,
> +		pcie_capability_read_dword(target_gpu_dev->gpu->adev->pdev,
>   				PCI_EXP_DEVCAP2, &cap);
>   
>   		if (!(cap & (PCI_EXP_DEVCAP2_ATOMIC_COMP32 |
> @@ -1688,13 +1687,13 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
>   		cu_info.num_shader_arrays_per_engine;
>   
>   	dev->node_props.gfx_target_version = gpu->device_info.gfx_target_version;
> -	dev->node_props.vendor_id = gpu->pdev->vendor;
> -	dev->node_props.device_id = gpu->pdev->device;
> +	dev->node_props.vendor_id = gpu->adev->pdev->vendor;
> +	dev->node_props.device_id = gpu->adev->pdev->device;
>   	dev->node_props.capability |=
>   		((dev->gpu->adev->rev_id << HSA_CAP_ASIC_REVISION_SHIFT) &
>   			HSA_CAP_ASIC_REVISION_MASK);
> -	dev->node_props.location_id = pci_dev_id(gpu->pdev);
> -	dev->node_props.domain = pci_domain_nr(gpu->pdev->bus);
> +	dev->node_props.location_id = pci_dev_id(gpu->adev->pdev);
> +	dev->node_props.domain = pci_domain_nr(gpu->adev->pdev->bus);
>   	dev->node_props.max_engine_clk_fcompute =
>   		amdgpu_amdkfd_get_max_engine_clock_in_mhz(dev->gpu->adev);
>   	dev->node_props.max_engine_clk_ccompute =

