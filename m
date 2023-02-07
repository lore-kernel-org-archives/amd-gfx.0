Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B232C636D4
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Feb 2023 07:03:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70B7510E1D0;
	Tue,  7 Feb 2023 07:03:24 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1008710E1D0
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Feb 2023 07:03:22 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 bg5-20020a05600c3c8500b003e00c739ce4so1993853wmb.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Feb 2023 23:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YJjs14SAmMvaZin7zj0PaF0an715D1mcQeiiain7At4=;
 b=Mk/0j6yt+AIMVj1kdHJhDXRckUuXvKXVYroNDtJ1Xca18CNV36wvTOLmQ4nHqmmO71
 35sbujsUYKJZwiu+D/gUPWTGkebfNunquiEgAc95UlX1JQhiCLFIAcbZeCA2vqEK7+EP
 UvDyYJ8WWNprrWagDHxeRqcLH8ThpdBLGSaKdnCJ0OCCqoMGPkiI7876yW5jxLOdFv32
 TxwPhP7UJMx2434f9QoxIyRpb9G/LZwwFVX9UWjHCmUA+zg9bOAbt+tDTQvs/LNpmNpB
 pkc7TdeNXeqrLvV46C3TlB9WWgKb6eCpHv2uEG0AhlmBBsLI5NmZB1HhLIJ0R4jjHdVi
 9E6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YJjs14SAmMvaZin7zj0PaF0an715D1mcQeiiain7At4=;
 b=V11oztnQLp2HYVD06+PiGQgR1YtJfp/OpFOlo/scWhmyQrDcfY2kjXm+XtGlW36WAe
 fi1K9rN+GXm6tezNpbvgvyo5uX1k/ucDq9ofER/ePP8YOSTzVpBLpiFqEgkQjlsySJup
 /16LMpa1foN3xRasS49biILGMygSbN/w3rHJ0qyCAHpgihCrhzlsPdVeOeM98KQWUHH9
 IQjOqsjTA+7/C2oXZjVV/Ha/JezUVNwgqMp5nO3JPWc0R0TY7BzbbZCZ6Sy7Xwnq+C68
 qV2mcm+Rs14MtXOewaURxlaPo6YJr/NrXBIp+p+iMOAx7WoumAaIxaq88uqRF8rAwrra
 t8tA==
X-Gm-Message-State: AO0yUKVijS6WTP00xWaJb5BkTp9NrUgMjpyUXaFP5SZH2EC34oGzH6fa
 6dTU5qeEQHOH41zSH/AZFzY=
X-Google-Smtp-Source: AK7set/V3idCrNOJLVAzWovHYqvUliLYdPyO2aQmlhM+sMJyVWd7HdsU5ACxYpmFbSc4n4v1UMiMtQ==
X-Received: by 2002:a05:600c:4d21:b0:3dc:561a:79e7 with SMTP id
 u33-20020a05600c4d2100b003dc561a79e7mr2103896wmp.2.1675753400230; 
 Mon, 06 Feb 2023 23:03:20 -0800 (PST)
Received: from [192.168.178.21] (p5b0ea2e7.dip0.t-ipconnect.de.
 [91.14.162.231]) by smtp.gmail.com with ESMTPSA id
 c12-20020a5d4ccc000000b002bddac15b3dsm10364909wrt.33.2023.02.06.23.03.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Feb 2023 23:03:19 -0800 (PST)
Message-ID: <bb992153-fa99-7b50-a188-e49a8d673439@gmail.com>
Date: Tue, 7 Feb 2023 08:03:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/8] drm/amdgpu: UAPI for user queue management
To: Alex Deucher <alexdeucher@gmail.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20230203215409.2021-1-shashank.sharma@amd.com>
 <20230203215409.2021-2-shashank.sharma@amd.com>
 <CADnq5_MSMivTzo0k+wJj+bGpsQZ3HEDVt5XqzjGdBiv08fFWCQ@mail.gmail.com>
 <95ac9ea3-47c8-744c-7fd7-ddc54b19926f@amd.com>
 <CADnq5_M9q0R=d=KU8P4oVOCY0Gw97Uhzy6Mrg0GgxeROGn6xrQ@mail.gmail.com>
 <afce1a57-8007-5d1b-0715-9756d7d07153@amd.com>
 <CADnq5_P8UJYvnH_kWcPY2hfnhU3Ppo-3RoQAU5Ohf1T841kvzQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CADnq5_P8UJYvnH_kWcPY2hfnhU3Ppo-3RoQAU5Ohf1T841kvzQ@mail.gmail.com>
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
Cc: alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org,
 Shashank Sharma <shashank.sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 06.02.23 um 22:03 schrieb Alex Deucher:
> On Mon, Feb 6, 2023 at 12:01 PM Christian König
> <christian.koenig@amd.com> wrote:
>> Am 06.02.23 um 17:56 schrieb Alex Deucher:
>>> On Fri, Feb 3, 2023 at 5:26 PM Shashank Sharma <shashank.sharma@amd.com> wrote:
>>>> Hey Alex,
>>>>
>>>> On 03/02/2023 23:07, Alex Deucher wrote:
>>>>> On Fri, Feb 3, 2023 at 4:54 PM Shashank Sharma <shashank.sharma@amd.com> wrote:
>>>>>> From: Alex Deucher <alexander.deucher@amd.com>
>>>>>>
>>>>>> This patch intorduces new UAPI/IOCTL for usermode graphics
>>>>>> queue. The userspace app will fill this structure and request
>>>>>> the graphics driver to add a graphics work queue for it. The
>>>>>> output of this UAPI is a queue id.
>>>>>>
>>>>>> This UAPI maps the queue into GPU, so the graphics app can start
>>>>>> submitting work to the queue as soon as the call returns.
>>>>>>
>>>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>>>> ---
>>>>>>     include/uapi/drm/amdgpu_drm.h | 53 +++++++++++++++++++++++++++++++++++
>>>>>>     1 file changed, 53 insertions(+)
>>>>>>
>>>>>> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
>>>>>> index 4038abe8505a..6c5235d107b3 100644
>>>>>> --- a/include/uapi/drm/amdgpu_drm.h
>>>>>> +++ b/include/uapi/drm/amdgpu_drm.h
>>>>>> @@ -54,6 +54,7 @@ extern "C" {
>>>>>>     #define DRM_AMDGPU_VM                  0x13
>>>>>>     #define DRM_AMDGPU_FENCE_TO_HANDLE     0x14
>>>>>>     #define DRM_AMDGPU_SCHED               0x15
>>>>>> +#define DRM_AMDGPU_USERQ               0x16
>>>>>>
>>>>>>     #define DRM_IOCTL_AMDGPU_GEM_CREATE    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>>>>>>     #define DRM_IOCTL_AMDGPU_GEM_MMAP      DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
>>>>>> @@ -71,6 +72,7 @@ extern "C" {
>>>>>>     #define DRM_IOCTL_AMDGPU_VM            DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_VM, union drm_amdgpu_vm)
>>>>>>     #define DRM_IOCTL_AMDGPU_FENCE_TO_HANDLE DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_FENCE_TO_HANDLE, union drm_amdgpu_fence_to_handle)
>>>>>>     #define DRM_IOCTL_AMDGPU_SCHED         DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_SCHED, union drm_amdgpu_sched)
>>>>>> +#define DRM_IOCTL_AMDGPU_USERQ         DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ, union drm_amdgpu_userq)
>>>>>>
>>>>>>     /**
>>>>>>      * DOC: memory domains
>>>>>> @@ -302,6 +304,57 @@ union drm_amdgpu_ctx {
>>>>>>            union drm_amdgpu_ctx_out out;
>>>>>>     };
>>>>>>
>>>>>> +/* user queue IOCTL */
>>>>>> +#define AMDGPU_USERQ_OP_CREATE 1
>>>>>> +#define AMDGPU_USERQ_OP_FREE   2
>>>>>> +
>>>>>> +#define AMDGPU_USERQ_MQD_FLAGS_SECURE  (1 << 0)
>>>>>> +#define AMDGPU_USERQ_MQD_FLAGS_AQL     (1 << 1)
>>>>>> +
>>>>>> +struct drm_amdgpu_userq_mqd {
>>>>>> +       /** Flags: AMDGPU_USERQ_MQD_FLAGS_* */
>>>>>> +       __u32   flags;
>>>>>> +       /** IP type: AMDGPU_HW_IP_* */
>>>>>> +       __u32   ip_type;
>>>>>> +       /** GEM object handle */
>>>>>> +       __u32   doorbell_handle;
>>>>>> +       /** Doorbell offset in dwords */
>>>>>> +       __u32   doorbell_offset;
>>>>> Since doorbells are 64 bit, maybe this offset should be in qwords.
>>>> Can you please help to cross check this information ? All the existing
>>>> kernel doorbell calculations are keeping doorbells size as sizeof(u32)
>>> Doorbells on pre-vega hardware are 32 bits so that is where that comes
>>> from, but from vega onward most doorbells are 64 bit.  I think some
>>> versions of VCN may still use 32 bit doorbells.  Internally in the
>>> kernel driver we just use two slots for newer hardware, but for the
>>> UAPI, I think we can just stick with 64 bit slots to avoid confusion.
>>> Even if an engine only uses a 32 bit one, I don't know that there is
>>> much value to trying to support variable doorbell sizes.
>> I think we can stick with using __u32 because this is *not* the size of
>> the doorbell entries.
>>
>> Instead this is the offset into the BO where to find the doorbell for
>> this queue (which then in turn is 64bits wide).
>>
>> Since we will probably never have more than 4GiB doorbells we should be
>> pretty save to use 32bits here.
> Yes, the offset would still be 32 bits, but the units would be qwords.  E.g.,
>
> +       /** Doorbell offset in qwords */
> +       __u32   doorbell_offset;
>
> That way you couldn't accidently specify an overlapping doorbell.

Ah, so you only wanted to fix the comment. That was absolutely not clear 
from the discussion.

Christian.

>
> Alex
>
>> Christian.
>>
>>> Alex
>>>
>>>>>> +       /** GPU virtual address of the queue */
>>>>>> +       __u64   queue_va;
>>>>>> +       /** Size of the queue in bytes */
>>>>>> +       __u64   queue_size;
>>>>>> +       /** GPU virtual address of the rptr */
>>>>>> +       __u64   rptr_va;
>>>>>> +       /** GPU virtual address of the wptr */
>>>>>> +       __u64   wptr_va;
>>>>>> +};
>>>>>> +
>>>>>> +struct drm_amdgpu_userq_in {
>>>>>> +       /** AMDGPU_USERQ_OP_* */
>>>>>> +       __u32   op;
>>>>>> +       /** Flags */
>>>>>> +       __u32   flags;
>>>>>> +       /** Queue handle to associate the queue free call with,
>>>>>> +        * unused for queue create calls */
>>>>>> +       __u32   queue_id;
>>>>>> +       __u32   pad;
>>>>>> +       /** Queue descriptor */
>>>>>> +       struct drm_amdgpu_userq_mqd mqd;
>>>>>> +};
>>>>>> +
>>>>>> +struct drm_amdgpu_userq_out {
>>>>>> +       /** Queue handle */
>>>>>> +       __u32   q_id;
>>>>> Maybe this should be queue_id to match the input.
>>>> Agree.
>>>>
>>>> - Shashank
>>>>
>>>>> Alex
>>>>>
>>>>>> +       /** Flags */
>>>>>> +       __u32   flags;
>>>>>> +};
>>>>>> +
>>>>>> +union drm_amdgpu_userq {
>>>>>> +       struct drm_amdgpu_userq_in in;
>>>>>> +       struct drm_amdgpu_userq_out out;
>>>>>> +};
>>>>>> +
>>>>>>     /* vm ioctl */
>>>>>>     #define AMDGPU_VM_OP_RESERVE_VMID      1
>>>>>>     #define AMDGPU_VM_OP_UNRESERVE_VMID    2
>>>>>> --
>>>>>> 2.34.1
>>>>>>

