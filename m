Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB3ECC47098
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 13:31:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89AE861369
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 13:31:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89AE861369
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 303AC6EC9B;
	Wed,  2 Jun 2021 13:31:35 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 067B16EC9B
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 13:31:34 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id w21so2836178edv.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 02 Jun 2021 06:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language;
 bh=qYIKSDero55huzJOooMFbbIGzjp9Gus1pr6RzDTWVuI=;
 b=eCwWV0UzfjyaCuDddrcMFaQcz/RiqjeD27EWvY0VP1Sra0Efike74Rbtmt/BQn6Zg6
 tLr6kWmBDYHLwL3kPHNrJpVSRnHT//SRUtcNlBm8dqPM/NRwHUry9mxhjzp0YefEKIwu
 XjnbdMTCRAx3bes9VYraNLXwTmKt8gAktEb7WaL8017eO9W9q8sFbjJfselMl5tQmkCM
 d0xGrWxSw6XugRxNfc82sDeXX3Eo8ZvLibW0rOSf5RjsmVxojdz3DAiumGdCXI376UJb
 h99H7Sp3WT1NQdU/+RqH+T74yNj1zbXq8odNvA90gQ3j+vcvcmNytQ+PzNl7UZe9qdoC
 cXTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language;
 bh=qYIKSDero55huzJOooMFbbIGzjp9Gus1pr6RzDTWVuI=;
 b=Hm8WxsuxyuG0s+hwDD8A+09nwGKrckJ0lp4Sa0iEZF5moDzsp2s3deT0wZ+R5f5TQU
 wHBb3UeW+KhNX0eGia+SCvFZBw6TcLpCpBazSYKN/532uejePvst0kr9EVXRNkgCSS+4
 sjGszaC6hcHoUCpNdtF93oIIAyxO4H5LByT+SFYZ/qGxgyN03AIqn3Qw0XGZpGdhX/4N
 7U87P1cnr7KNyRYLO4ob9KvXb3m3UpW4hKJBqT3Av+HShr5qryykLW0NSHVulVUs7dfM
 ZDDjDptQ8xJWEIWwFniKJGpItPAFwHnohDyW76PbR2BoE1Wd5XOo4CXL0Ml/K9cYWonz
 T23g==
X-Gm-Message-State: AOAM532/xQSnOO+k7G/OkRmf25J86DQYzzvytI1OmJs9ZQup2XrwELO7
 B7PeDjOTlX40mAtZsDDSOiI=
X-Google-Smtp-Source: ABdhPJwmWNUfbmEz+BBbtVE1JA49yokkumlJDKE1kcVvX4m3iuzPCPMooMM0QK3RngsVtuao/YnN4A==
X-Received: by 2002:a05:6402:2217:: with SMTP id
 cq23mr11484473edb.292.1622640692776; 
 Wed, 02 Jun 2021 06:31:32 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:cd07:2759:3eec:1d00?
 ([2a02:908:1252:fb60:cd07:2759:3eec:1d00])
 by smtp.gmail.com with ESMTPSA id f21sm1393453edr.45.2021.06.02.06.31.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jun 2021 06:31:31 -0700 (PDT)
Subject: Re: [PATCH 1/4] drm/amdkfd: Add flush-type parameter to kfd_flush_tlb
To: philip yang <yangp@amd.com>, Eric Huang <jinhuieric.huang@amd.com>,
 amd-gfx@lists.freedesktop.org, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Yang, Philip" <Philip.Yang@amd.com>
References: <20210601225907.749049-1-jinhuieric.huang@amd.com>
 <1b688ac5-e4cd-5c8b-7972-1f120186b502@gmail.com>
 <96d3eab3-ec3e-534b-28ae-17710b92fb80@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <fab9a173-bb8b-fcd2-dd48-d33b671e30d8@gmail.com>
Date: Wed, 2 Jun 2021 15:31:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <96d3eab3-ec3e-534b-28ae-17710b92fb80@amd.com>
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
Content-Type: multipart/mixed; boundary="===============2072454508=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--===============2072454508==
Content-Type: multipart/alternative;
 boundary="------------CEE33C43FD91797277B4415D"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------CEE33C43FD91797277B4415D
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit



Am 02.06.21 um 15:29 schrieb philip yang:
>
>
> On 2021-06-02 2:53 a.m., Christian König wrote:
>> Mostly a question for Felix and Philip:
>>
>> I've been thinking for a bit about how that case happens in the first 
>> place?
>>
>> I mean if we have a PDE which points to PTEs and then switch that 
>> into a 2MiB PTE then why wasn't that range invalidated before?
>>
>> In other words when the PDE points to the PTEs we should have had an 
>> unmap operation on that range before which should have invalidated 
>> the TLB.
>
> Because one cache line has 8 PDE0
>

Ah, of course! Yeah that makes totally sense now.

Christian.

> , after unmap flush tlb, access address on same PDE0 cache line will 
> load PDE0 back into tlb. For example:
>
> 1. map and access 0x7ffff6210000, unmap it, tlb flush
>
> 2. map and access 0x7ffff6400000, PDE0 for 0x7ffff6200000 into tlb, 
> which is P=0, V=1
>
> 3. map 0x7ffff6200000 update page table, access has vm fault because 
> tlb has PDE0 P=0,V=1, to recover this fault, map need update page 
> table and flush tlb.
>
> Regards,
>
> Philip
>
>>
>> Regards,
>> Christian.
>>
>> Am 02.06.21 um 00:59 schrieb Eric Huang:
>>> It is to provide more tlb flush types opotion for different
>>> case scenario.
>>>
>>> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c              | 2 +-
>>>   drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 6 +++---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h                 | 2 +-
>>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c              | 4 ++--
>>>   4 files changed, 7 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> index 960913a35ee4..4da8aff3df27 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> @@ -1666,7 +1666,7 @@ static int kfd_ioctl_map_memory_to_gpu(struct 
>>> file *filep,
>>>           if (WARN_ON_ONCE(!peer_pdd))
>>>               continue;
>>>           if (!amdgpu_read_lock(peer->ddev, true)) {
>>> -            kfd_flush_tlb(peer_pdd);
>>> +            kfd_flush_tlb(peer_pdd, TLB_FLUSH_LEGACY);
>>>               amdgpu_read_unlock(peer->ddev);
>>>           }
>>>       }
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>> index 2bd621eee4e0..904b8178c1d7 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>> @@ -278,7 +278,7 @@ static int allocate_vmid(struct 
>>> device_queue_manager *dqm,
>>>               qpd->vmid,
>>>               qpd->page_table_base);
>>>       /* invalidate the VM context after pasid and vmid mapping is 
>>> set up */
>>> -    kfd_flush_tlb(qpd_to_pdd(qpd));
>>> +    kfd_flush_tlb(qpd_to_pdd(qpd), TLB_FLUSH_LEGACY);
>>>         if (dqm->dev->kfd2kgd->set_scratch_backing_va)
>>> dqm->dev->kfd2kgd->set_scratch_backing_va(dqm->dev->kgd,
>>> @@ -314,7 +314,7 @@ static void deallocate_vmid(struct 
>>> device_queue_manager *dqm,
>>>           if (flush_texture_cache_nocpsch(q->device, qpd))
>>>               pr_err("Failed to flush TC\n");
>>>   -    kfd_flush_tlb(qpd_to_pdd(qpd));
>>> +    kfd_flush_tlb(qpd_to_pdd(qpd), TLB_FLUSH_LEGACY);
>>>         /* Release the vmid mapping */
>>>       set_pasid_vmid_mapping(dqm, 0, qpd->vmid);
>>> @@ -885,7 +885,7 @@ static int restore_process_queues_nocpsch(struct 
>>> device_queue_manager *dqm,
>>>                   dqm->dev->kgd,
>>>                   qpd->vmid,
>>>                   qpd->page_table_base);
>>> -        kfd_flush_tlb(pdd);
>>> +        kfd_flush_tlb(pdd, TLB_FLUSH_LEGACY);
>>>       }
>>>         /* Take a safe reference to the mm_struct, which may otherwise
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> index ecdd5e782b81..edce3ecf207d 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> @@ -1338,7 +1338,7 @@ void kfd_signal_reset_event(struct kfd_dev *dev);
>>>     void kfd_signal_poison_consumed_event(struct kfd_dev *dev, u32 
>>> pasid);
>>>   -void kfd_flush_tlb(struct kfd_process_device *pdd);
>>> +void kfd_flush_tlb(struct kfd_process_device *pdd, enum 
>>> TLB_FLUSH_TYPE type);
>>>     int dbgdev_wave_reset_wavefronts(struct kfd_dev *dev, struct 
>>> kfd_process *p);
>>>   diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> index 3995002c582b..72741f6579d3 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> @@ -2159,7 +2159,7 @@ int kfd_reserved_mem_mmap(struct kfd_dev *dev, 
>>> struct kfd_process *process,
>>>                      KFD_CWSR_TBA_TMA_SIZE, vma->vm_page_prot);
>>>   }
>>>   -void kfd_flush_tlb(struct kfd_process_device *pdd)
>>> +void kfd_flush_tlb(struct kfd_process_device *pdd, enum 
>>> TLB_FLUSH_TYPE type)
>>>   {
>>>       struct kfd_dev *dev = pdd->dev;
>>>   @@ -2172,7 +2172,7 @@ void kfd_flush_tlb(struct kfd_process_device 
>>> *pdd)
>>>                               pdd->qpd.vmid);
>>>       } else {
>>>           amdgpu_amdkfd_flush_gpu_tlb_pasid(dev->kgd,
>>> -                    pdd->process->pasid, TLB_FLUSH_LEGACY);
>>> +                    pdd->process->pasid, type);
>>>       }
>>>   }
>>


--------------CEE33C43FD91797277B4415D
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <br>
    <br>
    <div class="moz-cite-prefix">Am 02.06.21 um 15:29 schrieb philip
      yang:<br>
    </div>
    <blockquote type="cite"
      cite="mid:96d3eab3-ec3e-534b-28ae-17710b92fb80@amd.com">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <p><br>
      </p>
      <div class="moz-cite-prefix">On 2021-06-02 2:53 a.m., Christian
        König wrote:<br>
      </div>
      <blockquote type="cite"
        cite="mid:1b688ac5-e4cd-5c8b-7972-1f120186b502@gmail.com">Mostly
        a question for Felix and Philip: <br>
        <br>
        I've been thinking for a bit about how that case happens in the
        first place? <br>
        <br>
        I mean if we have a PDE which points to PTEs and then switch
        that into a 2MiB PTE then why wasn't that range invalidated
        before? <br>
        <br>
        In other words when the PDE points to the PTEs we should have
        had an unmap operation on that range before which should have
        invalidated the TLB. <br>
      </blockquote>
      <p>Because one cache line has 8 PDE0</p>
    </blockquote>
    <br>
    Ah, of course! Yeah that makes totally sense now.<br>
    <br>
    Christian.<br>
    <br>
    <blockquote type="cite"
      cite="mid:96d3eab3-ec3e-534b-28ae-17710b92fb80@amd.com">
      <p>, after unmap flush tlb, access address on same PDE0 cache line
        will load PDE0 back into tlb. For example:</p>
      <p>1. map and access 0x7ffff6210000, unmap it, tlb flush<br>
      </p>
      <p>2. map and access 0x7ffff6400000, PDE0 for 0x7ffff6200000 into
        tlb, which is P=0, V=1</p>
      <p>3. map 0x7ffff6200000 update page table, access has vm fault
        because tlb has PDE0 P=0,V=1, to recover this fault, map need
        update page table and flush tlb.<br>
      </p>
      <p>Regards,</p>
      <p>Philip<br>
      </p>
      <div>
        <div style="box-sizing: border-box; font-family: &quot;Segoe
          UI&quot;, system-ui, &quot;Apple Color Emoji&quot;,
          &quot;Segoe UI Emoji&quot;, sans-serif; font-size: 14px;
          font-style: normal; font-variant-ligatures: normal;
          font-variant-caps: normal; font-weight: 400; letter-spacing:
          normal; orphans: 2; text-align: start; text-indent: 0px;
          text-transform: none; white-space: normal; widows: 2;
          word-spacing: 0px;">
          <div data-tid="messageBodyContainer"> </div>
        </div>
      </div>
      <blockquote type="cite"
        cite="mid:1b688ac5-e4cd-5c8b-7972-1f120186b502@gmail.com"> <br>
        Regards, <br>
        Christian. <br>
        <br>
        Am 02.06.21 um 00:59 schrieb Eric Huang: <br>
        <blockquote type="cite">It is to provide more tlb flush types
          opotion for different <br>
          case scenario. <br>
          <br>
          Signed-off-by: Eric Huang <a class="moz-txt-link-rfc2396E"
            href="mailto:jinhuieric.huang@amd.com"
            moz-do-not-send="true">&lt;jinhuieric.huang@amd.com&gt;</a>
          <br>
          --- <br>
            drivers/gpu/drm/amd/amdkfd/kfd_chardev.c              | 2 +-
          <br>
            drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 6
          +++--- <br>
            drivers/gpu/drm/amd/amdkfd/kfd_priv.h                 | 2 +-
          <br>
            drivers/gpu/drm/amd/amdkfd/kfd_process.c              | 4
          ++-- <br>
            4 files changed, 7 insertions(+), 7 deletions(-) <br>
          <br>
          diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
          b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c <br>
          index 960913a35ee4..4da8aff3df27 100644 <br>
          --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c <br>
          +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c <br>
          @@ -1666,7 +1666,7 @@ static int
          kfd_ioctl_map_memory_to_gpu(struct file *filep, <br>
                    if (WARN_ON_ONCE(!peer_pdd)) <br>
                        continue; <br>
                    if (!amdgpu_read_lock(peer-&gt;ddev, true)) { <br>
          -            kfd_flush_tlb(peer_pdd); <br>
          +            kfd_flush_tlb(peer_pdd, TLB_FLUSH_LEGACY); <br>
                        amdgpu_read_unlock(peer-&gt;ddev); <br>
                    } <br>
                } <br>
          diff --git
          a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
          b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c <br>
          index 2bd621eee4e0..904b8178c1d7 100644 <br>
          --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c <br>
          +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c <br>
          @@ -278,7 +278,7 @@ static int allocate_vmid(struct
          device_queue_manager *dqm, <br>
                        qpd-&gt;vmid, <br>
                        qpd-&gt;page_table_base); <br>
                /* invalidate the VM context after pasid and vmid
          mapping is set up */ <br>
          -    kfd_flush_tlb(qpd_to_pdd(qpd)); <br>
          +    kfd_flush_tlb(qpd_to_pdd(qpd), TLB_FLUSH_LEGACY); <br>
                  if
          (dqm-&gt;dev-&gt;kfd2kgd-&gt;set_scratch_backing_va) <br>
                   
          dqm-&gt;dev-&gt;kfd2kgd-&gt;set_scratch_backing_va(dqm-&gt;dev-&gt;kgd,
          <br>
          @@ -314,7 +314,7 @@ static void deallocate_vmid(struct
          device_queue_manager *dqm, <br>
                    if (flush_texture_cache_nocpsch(q-&gt;device, qpd))
          <br>
                        pr_err("Failed to flush TC\n"); <br>
            -    kfd_flush_tlb(qpd_to_pdd(qpd)); <br>
          +    kfd_flush_tlb(qpd_to_pdd(qpd), TLB_FLUSH_LEGACY); <br>
                  /* Release the vmid mapping */ <br>
                set_pasid_vmid_mapping(dqm, 0, qpd-&gt;vmid); <br>
          @@ -885,7 +885,7 @@ static int
          restore_process_queues_nocpsch(struct device_queue_manager
          *dqm, <br>
                            dqm-&gt;dev-&gt;kgd, <br>
                            qpd-&gt;vmid, <br>
                            qpd-&gt;page_table_base); <br>
          -        kfd_flush_tlb(pdd); <br>
          +        kfd_flush_tlb(pdd, TLB_FLUSH_LEGACY); <br>
                } <br>
                  /* Take a safe reference to the mm_struct, which may
          otherwise <br>
          diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
          b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h <br>
          index ecdd5e782b81..edce3ecf207d 100644 <br>
          --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h <br>
          +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h <br>
          @@ -1338,7 +1338,7 @@ void kfd_signal_reset_event(struct
          kfd_dev *dev); <br>
              void kfd_signal_poison_consumed_event(struct kfd_dev *dev,
          u32 pasid); <br>
            -void kfd_flush_tlb(struct kfd_process_device *pdd); <br>
          +void kfd_flush_tlb(struct kfd_process_device *pdd, enum
          TLB_FLUSH_TYPE type); <br>
              int dbgdev_wave_reset_wavefronts(struct kfd_dev *dev,
          struct kfd_process *p); <br>
            diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
          b/drivers/gpu/drm/amd/amdkfd/kfd_process.c <br>
          index 3995002c582b..72741f6579d3 100644 <br>
          --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c <br>
          +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c <br>
          @@ -2159,7 +2159,7 @@ int kfd_reserved_mem_mmap(struct kfd_dev
          *dev, struct kfd_process *process, <br>
                               KFD_CWSR_TBA_TMA_SIZE,
          vma-&gt;vm_page_prot); <br>
            } <br>
            -void kfd_flush_tlb(struct kfd_process_device *pdd) <br>
          +void kfd_flush_tlb(struct kfd_process_device *pdd, enum
          TLB_FLUSH_TYPE type) <br>
            { <br>
                struct kfd_dev *dev = pdd-&gt;dev; <br>
            @@ -2172,7 +2172,7 @@ void kfd_flush_tlb(struct
          kfd_process_device *pdd) <br>
                                        pdd-&gt;qpd.vmid); <br>
                } else { <br>
                    amdgpu_amdkfd_flush_gpu_tlb_pasid(dev-&gt;kgd, <br>
          -                    pdd-&gt;process-&gt;pasid,
          TLB_FLUSH_LEGACY); <br>
          +                    pdd-&gt;process-&gt;pasid, type); <br>
                } <br>
            } <br>
            </blockquote>
        <br>
      </blockquote>
    </blockquote>
    <br>
  </body>
</html>

--------------CEE33C43FD91797277B4415D--

--===============2072454508==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2072454508==--
