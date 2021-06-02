Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C5EC4708F
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 06:53:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 377A66108C
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 06:53:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 377A66108C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F27F589F06;
	Wed,  2 Jun 2021 06:53:27 +0000 (UTC)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A06F189F06
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 06:53:26 +0000 (UTC)
Received: by mail-lj1-x232.google.com with SMTP id p20so1213296ljj.8
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Jun 2021 23:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=4DlSBMy3xD6QolQPQCuyEgxu9KZg9RDvVn7NjoO490Y=;
 b=Gr9wrtP9a4QKuKV9scjkahs6AlHmzP56zv0h6W6FUtkzuyDV1xdEQAnkY1rKenDhrG
 MeX3WjegyJ6Z0dd3EUOZBuxaKgQBlv0lZSoZ4gnNMF3yDalwP12WNMZ38NXyvtm9q9M1
 Psu5pXRk4nEt5qUdBD/gRTe5cx979ABhgc7rcvwD6CJR+jZ1Td9KEujxBS2+E405ThIb
 eMDCNTXZhcVRj6ZrXpmmvi8VjcsCuo6KEn5GtiOYdvhBp9+6dYp5Vaddw/QSr7H29/8v
 vDSRARUsAzcSzg3N80UYgvfR9g+zyCIcxs6GBjzWFIBpe2UCvePRrXm8+s4g1g+aF5l0
 Z6fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=4DlSBMy3xD6QolQPQCuyEgxu9KZg9RDvVn7NjoO490Y=;
 b=kBVb3Eblq5/yhJbaZNDtSKspGdWItcgcqgnZHPFfLh1pDIZ/t6cWgi0IHG9hurp/lh
 CJoHFcLokJRod0veN5KsU27GN3xJJ5EfRKalE+zbNaOTHA6sYxoxSQasGCbXKfhP+deJ
 mdsf1JYAvbpElo/ld/6tY7kdMml4Xjy260H4F2EUltg5itCqL6ENnG1DQmHN34fpO4pG
 7AG3844y+36XDwT6LscJ2jVQpjDPIqBpJK6XNbPtdjLOAW57ZK2i7siooE3jMawz41K5
 qdMvrpMwayulPa2y+/mn4EcFU5XXG2VLlgw0zF9roLUgp8h7FrZ3yuBYOcOqq1ci/WiO
 nqDg==
X-Gm-Message-State: AOAM531SO8+e/h996PKDurp+dl/2uM2EgJmnwJMC88R6TLB8HYwBe5h4
 E3bnkt3vHYtmb1Pqq8apzIQ=
X-Google-Smtp-Source: ABdhPJzJ3UUu9DWZv4XuieM2fLXu4N5un6XidyMCMG5cnNXiKQ7AKzVBX/CanrdbXs8q1tc/5IXgdg==
X-Received: by 2002:a2e:9787:: with SMTP id y7mr24040067lji.65.1622616805114; 
 Tue, 01 Jun 2021 23:53:25 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:cd07:2759:3eec:1d00?
 ([2a02:908:1252:fb60:cd07:2759:3eec:1d00])
 by smtp.gmail.com with ESMTPSA id m4sm2422442ljp.9.2021.06.01.23.53.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Jun 2021 23:53:24 -0700 (PDT)
Subject: Re: [PATCH 1/4] drm/amdkfd: Add flush-type parameter to kfd_flush_tlb
To: Eric Huang <jinhuieric.huang@amd.com>, amd-gfx@lists.freedesktop.org,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Yang, Philip" <Philip.Yang@amd.com>
References: <20210601225907.749049-1-jinhuieric.huang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <1b688ac5-e4cd-5c8b-7972-1f120186b502@gmail.com>
Date: Wed, 2 Jun 2021 08:53:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210601225907.749049-1-jinhuieric.huang@amd.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Mostly a question for Felix and Philip:

I've been thinking for a bit about how that case happens in the first place?

I mean if we have a PDE which points to PTEs and then switch that into a 
2MiB PTE then why wasn't that range invalidated before?

In other words when the PDE points to the PTEs we should have had an 
unmap operation on that range before which should have invalidated the TLB.

Regards,
Christian.

Am 02.06.21 um 00:59 schrieb Eric Huang:
> It is to provide more tlb flush types opotion for different
> case scenario.
>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c              | 2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 6 +++---
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h                 | 2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c              | 4 ++--
>   4 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 960913a35ee4..4da8aff3df27 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1666,7 +1666,7 @@ static int kfd_ioctl_map_memory_to_gpu(struct file *filep,
>   		if (WARN_ON_ONCE(!peer_pdd))
>   			continue;
>   		if (!amdgpu_read_lock(peer->ddev, true)) {
> -			kfd_flush_tlb(peer_pdd);
> +			kfd_flush_tlb(peer_pdd, TLB_FLUSH_LEGACY);
>   			amdgpu_read_unlock(peer->ddev);
>   		}
>   	}
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 2bd621eee4e0..904b8178c1d7 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -278,7 +278,7 @@ static int allocate_vmid(struct device_queue_manager *dqm,
>   			qpd->vmid,
>   			qpd->page_table_base);
>   	/* invalidate the VM context after pasid and vmid mapping is set up */
> -	kfd_flush_tlb(qpd_to_pdd(qpd));
> +	kfd_flush_tlb(qpd_to_pdd(qpd), TLB_FLUSH_LEGACY);
>   
>   	if (dqm->dev->kfd2kgd->set_scratch_backing_va)
>   		dqm->dev->kfd2kgd->set_scratch_backing_va(dqm->dev->kgd,
> @@ -314,7 +314,7 @@ static void deallocate_vmid(struct device_queue_manager *dqm,
>   		if (flush_texture_cache_nocpsch(q->device, qpd))
>   			pr_err("Failed to flush TC\n");
>   
> -	kfd_flush_tlb(qpd_to_pdd(qpd));
> +	kfd_flush_tlb(qpd_to_pdd(qpd), TLB_FLUSH_LEGACY);
>   
>   	/* Release the vmid mapping */
>   	set_pasid_vmid_mapping(dqm, 0, qpd->vmid);
> @@ -885,7 +885,7 @@ static int restore_process_queues_nocpsch(struct device_queue_manager *dqm,
>   				dqm->dev->kgd,
>   				qpd->vmid,
>   				qpd->page_table_base);
> -		kfd_flush_tlb(pdd);
> +		kfd_flush_tlb(pdd, TLB_FLUSH_LEGACY);
>   	}
>   
>   	/* Take a safe reference to the mm_struct, which may otherwise
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index ecdd5e782b81..edce3ecf207d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -1338,7 +1338,7 @@ void kfd_signal_reset_event(struct kfd_dev *dev);
>   
>   void kfd_signal_poison_consumed_event(struct kfd_dev *dev, u32 pasid);
>   
> -void kfd_flush_tlb(struct kfd_process_device *pdd);
> +void kfd_flush_tlb(struct kfd_process_device *pdd, enum TLB_FLUSH_TYPE type);
>   
>   int dbgdev_wave_reset_wavefronts(struct kfd_dev *dev, struct kfd_process *p);
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 3995002c582b..72741f6579d3 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -2159,7 +2159,7 @@ int kfd_reserved_mem_mmap(struct kfd_dev *dev, struct kfd_process *process,
>   			       KFD_CWSR_TBA_TMA_SIZE, vma->vm_page_prot);
>   }
>   
> -void kfd_flush_tlb(struct kfd_process_device *pdd)
> +void kfd_flush_tlb(struct kfd_process_device *pdd, enum TLB_FLUSH_TYPE type)
>   {
>   	struct kfd_dev *dev = pdd->dev;
>   
> @@ -2172,7 +2172,7 @@ void kfd_flush_tlb(struct kfd_process_device *pdd)
>   							pdd->qpd.vmid);
>   	} else {
>   		amdgpu_amdkfd_flush_gpu_tlb_pasid(dev->kgd,
> -					pdd->process->pasid, TLB_FLUSH_LEGACY);
> +					pdd->process->pasid, type);
>   	}
>   }
>   

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
