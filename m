Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1DEDC3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Dec 2023 13:59:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 728EE10E5B9;
	Wed, 20 Dec 2023 13:59:04 +0000 (UTC)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 511D310E5B9
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Dec 2023 13:59:02 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3367f050e04so310318f8f.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Dec 2023 05:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703080741; x=1703685541; darn=lists.freedesktop.org;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nkYvVZq6rEziE6kWEiTKz6BMtawIDJcAE9RuI5Uatlg=;
 b=YimaH3C5Dt6v15s9L2o1cDSgE1wJLPhagcqgFX2uwvzsh8WKiNRKNyylAK36mkGGo3
 CCjpjBK0xHcSfD7pyz3Pe29koeM+GflucQ+VBscdYvsObyt0oZ1dNUeYpG4tRT6vUIen
 kzu0MLeBDJePzPiy4siRvMzmcLLG4f+7px6wd4prKaTJnOHcV1GPafPLVy6oH1DmEDB3
 CHddkA8lCoej7uVhgvSk2CLEbEB0SvqwyBaCLZeyTtgDHz6XcuTM9GDtD1WMZii+EZod
 3y7lTFVhUut4NnCYtCNRq3nChEY4Qrt+GJmOLBGbMsQoMNnqw0KJc+q5CZphHAxLFUeS
 Z7bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703080741; x=1703685541;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nkYvVZq6rEziE6kWEiTKz6BMtawIDJcAE9RuI5Uatlg=;
 b=ejllcZt3P6XeEkgCb5KZUm5ImUCiVy9UfsGzBnMmua36KQZB46YtxZPO0TkzA2+5dO
 qAoOqx0RyRkWiIsCmf+AUBxmHJayYSjq++ZJVteBM/7IXGdMgF7XZWGyvuMxFqdVkYEt
 mXoFMsfHXo+tvwHG86gZoKO2xQw66uo03/tlneHfXW6LeU9b/ez5MksFGS6QFh4R2aZu
 LxXVhJOGiu7ja8wfbJbO+9i6s9oh8rB4zQ1krK3mJ2hLEFOZe9OClzLuIlclnlJaD5ey
 dJ2fFpmZ0b8Wws1qJxZ26+xXYceqFG3cfFDm+X5hL3qYJ5pVx9LjYRE78ci1CVjp9JkR
 jDjQ==
X-Gm-Message-State: AOJu0Yyi0B3twNAL32c/su6uOe2AvYlLnIKuZ8On9YJs+177/TI8myxG
 ACzyDx+aYeTs2kPNGV+xq1A=
X-Google-Smtp-Source: AGHT+IETEwasS2gK63XtbSnlwjNYCSTM/PuMUyM9Qs2YRCMoSj1KNczY3hszDiUzlG2Cys/V0AtR6A==
X-Received: by 2002:a5d:6152:0:b0:336:808d:95e5 with SMTP id
 y18-20020a5d6152000000b00336808d95e5mr87032wrt.67.1703080740382; 
 Wed, 20 Dec 2023 05:59:00 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 v18-20020a5d6792000000b00336652fed81sm9431525wru.104.2023.12.20.05.58.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Dec 2023 05:58:59 -0800 (PST)
Content-Type: multipart/alternative;
 boundary="------------S0a2x0z4rXPqjr4WKuZGlwCp"
Message-ID: <db8e0eee-1f43-472f-b1dc-138240fbf4af@gmail.com>
Date: Wed, 20 Dec 2023 14:58:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] drm/amdgpu: Auto-validate DMABuf imports in
 compute VMs
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20231214223001.218746-1-Felix.Kuehling@amd.com>
 <fe14d738-ab23-460f-ac44-2090ef9ab4c5@gmail.com>
 <3bce0db8-9da0-4f6e-a941-e5531518c908@amd.com>
 <346c1009-2930-4424-9cd4-589e5872877e@amd.com>
 <f37e19fe-4fc9-4580-9961-ccdcf7f9b35a@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <f37e19fe-4fc9-4580-9961-ccdcf7f9b35a@amd.com>
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
Cc: xiaogang.chen@amd.com, mukul.joshi@amd.com, ramesh.errabolu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--------------S0a2x0z4rXPqjr4WKuZGlwCp
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 19.12.23 um 23:43 schrieb Felix Kuehling:
> On 2023-12-19 3:10, Christian König wrote:
>> Am 15.12.23 um 16:19 schrieb Felix Kuehling:
>>>
>>> On 2023-12-15 07:30, Christian König wrote:
>>>>> @@ -1425,11 +1451,21 @@ int amdgpu_vm_handle_moved(struct 
>>>>> amdgpu_device *adev,
>>>>>           }
>>>>>             r = amdgpu_vm_bo_update(adev, bo_va, clear);
>>>>> -        if (r)
>>>>> -            return r;
>>>>>             if (unlock)
>>>>>               dma_resv_unlock(resv);
>>>>> +        if (r)
>>>>> +            return r;
>>>>> +
>>>>> +        /* Remember evicted DMABuf imports in compute VMs for later
>>>>> +         * validation
>>>>> +         */
>>>>> +        if (vm->is_compute_context && bo_va->base.bo &&
>>>>> +            bo_va->base.bo->tbo.base.import_attach &&
>>>>> +            (!bo_va->base.bo->tbo.resource ||
>>>>> + bo_va->base.bo->tbo.resource->mem_type == TTM_PL_SYSTEM))
>>>>> +            amdgpu_vm_bo_evicted(&bo_va->base);
>>>>> +
>>>>
>>>> The change looks mostly good now. Just one thing which worries me 
>>>> is that when GFX and compute is mixed in the same VM this here 
>>>> might cause problems when we run into an error during command 
>>>> submission.
>>>>
>>>> E.g. GFX validates the VM BOs, but then the IOCTL fails before 
>>>> calling amdgpu_vm_handle_moved().
>>>>
>>>> In this case the DMA-buf wouldn't be validated any more.
>>>
>>> This code path shouldn't be relevant for command submission, but for 
>>> the amdgpu_vm_handle_moved call in amdgpu_dma_buf_move_notify. 
>>> That's where the BO is first found to be evicted and its PTEs 
>>> invalidated. That's where we need to remember it so it can be 
>>> validated in the next call to amdgpu_vm_validate.
>>>
>>> Currently the amdgpu_cs code path calls amdgpu_vm_validate with 
>>> ticket=NULL, so it won't validate these imports. The only place that 
>>> auto-validates evicted imports is amdgpu_amdkfd_restore_process_bos. 
>>> So none of this should affect amdgpu_cs command submission.
>>
>> Yeah, but ticket=NULL will result in removing those imports from the 
>> validation list.
>
> I have a comment for that in amdgpu_vm_validate:
>
>                          if (!ticket) {
>                                  /* We need to move the BO out of the evicted
>                                   * list to avoid an infinite loop. It will be
>                                   * moved back to evicted in the next
>                                   * amdgpu_vm_handle_moved.
>                                   */
>                                  amdgpu_vm_bo_invalidated(bo_base);
>                                  spin_lock(&vm->status_lock);
>                                  continue;
>                          }
>
> The net result is that the BO is still tracked as evicted.
>

Yeah, that's exactly what I mean:

What happens if amdgpu_vm_validate() is called, removes the BOs from the 
evicted list, but then an error happens (or just an interrupted system 
call) and amdgpu_vm_handle_moved is never called?

In this case the DMA-bufs would be on the moved list and 
amdgpu_vm_handle moved would have to be called once before we can 
validate them again.

Regards,
Christian.

>
>> This could potentially result in not validating them should we ever 
>> mix GFX and Compute submissions in the same VM.
>
> My eviction test does exactly this, and it's working just fine.
>
> Regards,
>   Felix
>
>
>>
>> For now that works, but we need to clean that up more thoughtfully I 
>> think.
>>
>> Christian.
>>
>>>
>>>
>>> The flow for amdgpu_amdkfd_restore_process_bos is:
>>>
>>>  * amdgpu_vm_validate validates the evicted dmabuf imports (moves the
>>>    bo_vas from "evicted" to "invalidated")
>>>  * amdgpu_vm_handle_moved iterates over invalidated bo_vas and updates
>>>    the PTEs with valid entries (moves the bo_vas to "done")
>>>
>>>
>>> Regards,
>>>   Felix
>>>
>>>
>>>>
>>>> Regards,
>>>> Christian. 
>>

--------------S0a2x0z4rXPqjr4WKuZGlwCp
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    Am 19.12.23 um 23:43 schrieb Felix Kuehling:<br>
    <blockquote type="cite"
      cite="mid:f37e19fe-4fc9-4580-9961-ccdcf7f9b35a@amd.com">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      On 2023-12-19 3:10, Christian König wrote:
      <blockquote type="cite"
        cite="mid:346c1009-2930-4424-9cd4-589e5872877e@amd.com">Am
        15.12.23 um 16:19 schrieb Felix Kuehling: <br>
        <blockquote type="cite"> <br>
          On 2023-12-15 07:30, Christian König wrote: <br>
          <blockquote type="cite">
            <blockquote type="cite">@@ -1425,11 +1451,21 @@ int
              amdgpu_vm_handle_moved(struct amdgpu_device *adev, <br>
                        } <br>
                          r = amdgpu_vm_bo_update(adev, bo_va, clear); <br>
              -        if (r) <br>
              -            return r; <br>
                          if (unlock) <br>
                            dma_resv_unlock(resv); <br>
              +        if (r) <br>
              +            return r; <br>
              + <br>
              +        /* Remember evicted DMABuf imports in compute VMs
              for later <br>
              +         * validation <br>
              +         */ <br>
              +        if (vm-&gt;is_compute_context &amp;&amp;
              bo_va-&gt;base.bo &amp;&amp; <br>
              +            bo_va-&gt;base.bo-&gt;tbo.base.import_attach
              &amp;&amp; <br>
              +            (!bo_va-&gt;base.bo-&gt;tbo.resource || <br>
              +            
              bo_va-&gt;base.bo-&gt;tbo.resource-&gt;mem_type ==
              TTM_PL_SYSTEM)) <br>
              +            amdgpu_vm_bo_evicted(&amp;bo_va-&gt;base); <br>
              + <br>
            </blockquote>
            <br>
            The change looks mostly good now. Just one thing which
            worries me is that when GFX and compute is mixed in the same
            VM this here might cause problems when we run into an error
            during command submission. <br>
            <br>
            E.g. GFX validates the VM BOs, but then the IOCTL fails
            before calling amdgpu_vm_handle_moved(). <br>
            <br>
            In this case the DMA-buf wouldn't be validated any more. <br>
          </blockquote>
          <br>
          This code path shouldn't be relevant for command submission,
          but for the amdgpu_vm_handle_moved call in
          amdgpu_dma_buf_move_notify. That's where the BO is first found
          to be evicted and its PTEs invalidated. That's where we need
          to remember it so it can be validated in the next call to
          amdgpu_vm_validate. <br>
          <br>
          Currently the amdgpu_cs code path calls amdgpu_vm_validate
          with ticket=NULL, so it won't validate these imports. The only
          place that auto-validates evicted imports is
          amdgpu_amdkfd_restore_process_bos. So none of this should
          affect amdgpu_cs command submission. <br>
        </blockquote>
        <br>
        Yeah, but ticket=NULL will result in removing those imports from
        the validation list.</blockquote>
      <p>I have a comment for that in amdgpu_vm_validate:</p>
      <pre>                        if (!ticket) {
                                /* We need to move the BO out of the evicted
                                 * list to avoid an infinite loop. It will be
                                 * moved back to evicted in the next
                                 * amdgpu_vm_handle_moved.
                                 */
                                amdgpu_vm_bo_invalidated(bo_base);
                                spin_lock(&amp;vm-&gt;status_lock);
                                continue;
                        }
</pre>
      <p>The net result is that the BO is still tracked as evicted.<br>
      </p>
    </blockquote>
    <br>
    Yeah, that's exactly what I mean:<br>
    <br>
    What happens if amdgpu_vm_validate() is called, removes the BOs from
    the evicted list, but then an error happens (or just an interrupted
    system call) and amdgpu_vm_handle_moved is never called?<br>
    <br>
    In this case the DMA-bufs would be on the moved list and
    amdgpu_vm_handle moved would have to be called once before we can
    validate them again.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote type="cite"
      cite="mid:f37e19fe-4fc9-4580-9961-ccdcf7f9b35a@amd.com">
      <p> </p>
      <p><br>
      </p>
      <blockquote type="cite"
        cite="mid:346c1009-2930-4424-9cd4-589e5872877e@amd.com"> This
        could potentially result in not validating them should we ever
        mix GFX and Compute submissions in the same VM. <br>
      </blockquote>
      <p>My eviction test does exactly this, and it's working just fine.</p>
      <p>Regards,<br>
          Felix<br>
      </p>
      <p><br>
      </p>
      <blockquote type="cite"
        cite="mid:346c1009-2930-4424-9cd4-589e5872877e@amd.com"> <br>
        For now that works, but we need to clean that up more
        thoughtfully I think. <br>
        <br>
        Christian. <br>
        <br>
        <blockquote type="cite"> <br>
          <br>
          The flow for amdgpu_amdkfd_restore_process_bos is: <br>
          <br>
           * amdgpu_vm_validate validates the evicted dmabuf imports
          (moves the <br>
             bo_vas from "evicted" to "invalidated") <br>
           * amdgpu_vm_handle_moved iterates over invalidated bo_vas and
          updates <br>
             the PTEs with valid entries (moves the bo_vas to "done") <br>
          <br>
          <br>
          Regards, <br>
            Felix <br>
          <br>
          <br>
          <blockquote type="cite"> <br>
            Regards, <br>
            Christian. </blockquote>
        </blockquote>
        <br>
      </blockquote>
    </blockquote>
    <br>
  </body>
</html>

--------------S0a2x0z4rXPqjr4WKuZGlwCp--
