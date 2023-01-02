Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE16EC46467
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Jan 2023 11:27:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3387610E30D;
	Mon,  2 Jan 2023 11:27:53 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0E4610E30D
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Jan 2023 11:27:50 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 b24-20020a05600c4a9800b003d21efdd61dso20379939wmp.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Jan 2023 03:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kEFNAB30LdAq+hyJ3Uoy9gVxCZc6CDHMHpDyQnqjsW4=;
 b=SMSZMF+wmUEjQ6gtWu8axSWIykm1GlFfdV77CWOB2Mqa7YYWNNqXjdGcCBWkkWFEve
 YzNtbtkqwM6n6OdQU/2OyfzmU0GbqbaheHtrQK00SdU8mNHgf4OCRZeh8ztQECiekuz4
 vP4zwdG6X93WXQKwKNG64ivH2UPCcoHa6g6ZrohY90gtw0W3ZN1p8FUMgTu4Lb/nFggk
 EToQyjSKggmd9g+WZkVvZjn9Ksdcn+8qSjIMkCiVBZ5AHAjyIxF9oJTeN5wGowkdHDko
 c0Q0IcSXZZuKbrh+uJqv/9sG3afcCJK1HKUojntAv/L2Lli9IKKowmn36lB6R7RdG4qs
 B3tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kEFNAB30LdAq+hyJ3Uoy9gVxCZc6CDHMHpDyQnqjsW4=;
 b=04pVYoQZlz7NToB6TobaQ5f0HFr+06Yt3GrVcr2cS8TVFknCjNyXUNW6voaIj8qcVM
 /r81S10ZBPuOaIGWt6Z+3UTRgX/AH+uBCvICpbIbD2T2Je6fDkYLhYH38MvdhCDC3jNo
 q7qvBr2g1VenhmTzj3fGy7IuZnv1VuVYYfhxvLk3p7s5WCLXsMaevha4afxazVYHzsIc
 ld00/cS6YZBHI10Ec6zNRK4CiZvcmVkMvnHfbsv8z6OWuUiVN0R6mG4QnHe0htICqdwg
 lgrZ2PJW7iFVktpItc6DmlroKvig8g1CU/vionRZajEL6NI+AY0eRDB7NYFyZHOIGxn1
 vfSw==
X-Gm-Message-State: AFqh2kqbUdymSp0gkHLQDydFULRu1okUlH5Ez7NUWRBqc76/1vr+alWV
 Z6rqBGgQETf6XJUVsBhLNdQ=
X-Google-Smtp-Source: AMrXdXuEk823+iLCzz0hvFGbMFOabfdLJE7TqXjqpqKTwWJDu1i5J75gwWlFBWuv5wGbeTeiPDWRRQ==
X-Received: by 2002:a05:600c:4e4f:b0:3cf:9d32:db67 with SMTP id
 e15-20020a05600c4e4f00b003cf9d32db67mr28398803wmq.3.1672658869344; 
 Mon, 02 Jan 2023 03:27:49 -0800 (PST)
Received: from ?IPV6:2a02:908:1256:79a0:6c4c:f88:9138:4eca?
 ([2a02:908:1256:79a0:6c4c:f88:9138:4eca])
 by smtp.gmail.com with ESMTPSA id
 t17-20020a05600c199100b003d99da8d30asm16443519wmq.46.2023.01.02.03.27.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Jan 2023 03:27:48 -0800 (PST)
Message-ID: <360e4d69-1608-727e-3144-be6e53feec0c@gmail.com>
Date: Mon, 2 Jan 2023 12:27:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [RFC 1/7] drm/amdgpu: UAPI for user queue management
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
References: <20221223193655.1972-1-shashank.sharma@amd.com>
 <20221223193655.1972-2-shashank.sharma@amd.com>
 <CAP+8YyGPy5oXpOcuWfaS1vNhGajG1VGZc4p_QiUxaLAFCtt5KQ@mail.gmail.com>
 <CADnq5_MpGojmU3WTNvvOiYie_c5WWAXbMp5W+dWx7_SHKDn9+g@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CADnq5_MpGojmU3WTNvvOiYie_c5WWAXbMp5W+dWx7_SHKDn9+g@mail.gmail.com>
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
Cc: Shashank Sharma <shashank.sharma@amd.com>, arunpravin.paneerselvam@amd.com,
 arvind.yadav@amd.com, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 27.12.22 um 17:58 schrieb Alex Deucher:
> On Sat, Dec 24, 2022 at 3:21 PM Bas Nieuwenhuizen
> <bas@basnieuwenhuizen.nl> wrote:
>> On Fri, Dec 23, 2022 at 8:37 PM Shashank Sharma <shashank.sharma@amd.com> wrote:
>>> From: Alex Deucher <alexander.deucher@amd.com>
>>>
>>> This patch intorduces new UAPI/IOCTL for usermode graphics
>>> queue. The userspace app will fill this structure and request
>>> the graphics driver to add a graphics work queue for it. The
>>> output of this UAPI is a queue id.
>>>
>>> This UAPI maps the queue into GPU, so the graphics app can start
>>> submitting work to the queue as soon as the call returns.
>>>
>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>> ---
>>>   include/uapi/drm/amdgpu_drm.h | 52 +++++++++++++++++++++++++++++++++++
>>>   1 file changed, 52 insertions(+)
>>>
>>> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
>>> index 0d93ec132ebb..a3d0dd6f62c5 100644
>>> --- a/include/uapi/drm/amdgpu_drm.h
>>> +++ b/include/uapi/drm/amdgpu_drm.h
>>> @@ -54,6 +54,7 @@ extern "C" {
>>>   #define DRM_AMDGPU_VM                  0x13
>>>   #define DRM_AMDGPU_FENCE_TO_HANDLE     0x14
>>>   #define DRM_AMDGPU_SCHED               0x15
>>> +#define DRM_AMDGPU_USERQ               0x16
>>>
>>>   #define DRM_IOCTL_AMDGPU_GEM_CREATE    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>>>   #define DRM_IOCTL_AMDGPU_GEM_MMAP      DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
>>> @@ -71,6 +72,7 @@ extern "C" {
>>>   #define DRM_IOCTL_AMDGPU_VM            DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_VM, union drm_amdgpu_vm)
>>>   #define DRM_IOCTL_AMDGPU_FENCE_TO_HANDLE DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_FENCE_TO_HANDLE, union drm_amdgpu_fence_to_handle)
>>>   #define DRM_IOCTL_AMDGPU_SCHED         DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_SCHED, union drm_amdgpu_sched)
>>> +#define DRM_IOCTL_AMDGPU_USERQ         DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ, union drm_amdgpu_userq)
>>>
>>>   /**
>>>    * DOC: memory domains
>>> @@ -288,6 +290,56 @@ union drm_amdgpu_ctx {
>>>          union drm_amdgpu_ctx_out out;
>>>   };
>>>
>>> +/* user queue IOCTL */
>>> +#define AMDGPU_USERQ_OP_CREATE 1
>>> +#define AMDGPU_USERQ_OP_FREE   2
>>> +
>>> +#define AMDGPU_USERQ_MQD_FLAGS_SECURE  (1 << 0)
>>> +#define AMDGPU_USERQ_MQD_FLAGS_AQL     (1 << 1)
>> Can we document what AQL means here?
> AQL is the packet format used by KFD/ROCm.  The idea is to be able to
> create queues that support either format (AQL or PM4).

Could we make that a separate queue type? E.g. like SDMA, GFX, Compute?

It's not really a flag which can be applied independent of the queue.

Regards,
Christian.

>
>>
>>> +
>>> +struct drm_amdgpu_userq_mqd {
>>> +       /** Flags: AMDGPU_USERQ_MQD_FLAGS_* */
>>> +       __u32   flags;
>>> +       /** IP type: AMDGPU_HW_IP_* */
>>> +       __u32   ip_type;
>>> +       /** GEM object handle */
>>> +       __u32   doorbell_handle;
>>> +       /** Doorbell offset in dwords */
>>> +       __u32   doorbell_offset;
>> What are the doorbell handle/offset for? I don't see any of them used
>> in the rest of the series (we only check the handle isn't 0, which
>> isn't enough validation for a GEM handle to consider it valid), and
>> the kernel seems to allocate some kind of doorbell index in patch 4.
>> Does userspace need to know about that one? (similarly use_doorbell in
>> that patch seems like it is never explicitly written to)
> The doorbell is how you trigger the engine to start processing the
> user queue.  The idea is that each user process allocates a page of
> doorbell space (one of the PCI BARs) and then each 64 bit segment in
> that page could be used for a user mode queue.  So the UMD writes its
> data to the queue, updates the wptr, and then writes to the doorbell
> to tell the firmware to start processing the queue.
>
>> The other questions I have are about how this interacts with memory
>> management. Does this have access to all BOs allocated with
>> AMDGPU_GEM_CREATE_VM_ALWAYS_VALID? What about imported BOs? How does
>> this interact with VA unmap/map operations? (AFAICT we have no way to
>> tell if pagetable modifying operations are complete from userspace for
>> now). What happens if we need to spill BOs from VRAM due to
>> (cross-process) memory pressure?
> Effectively everything you map on the GPU would be valid.  If there is
> memory pressure, the kernel driver will behave similarly to KFD.  It
> will unmap the queues (which preempts all work on the engines), do any
> memory migrations, and then map the queues again.
>
> Alex
>
>>> +       /** GPU virtual address of the queue */
>>> +       __u64   queue_va;
>>> +       /** Size of the queue in bytes */
>>> +       __u64   queue_size;
>>> +       /** GPU virtual address of the rptr */
>>> +       __u64   rptr_va;
>>> +       /** GPU virtual address of the wptr */
>>> +       __u64   wptr_va;
>>> +};
>>> +
>>> +struct drm_amdgpu_userq_in {
>>> +       /** AMDGPU_USERQ_OP_* */
>>> +       __u32   op;
>>> +       /** Flags */
>>> +       __u32   flags;
>>> +       /** Context handle to associate the queue with */
>>> +       __u32   ctx_id;
>>> +       __u32   pad;
>>> +       /** Queue descriptor */
>>> +       struct drm_amdgpu_userq_mqd mqd;
>>> +};
>>> +
>>> +struct drm_amdgpu_userq_out {
>>> +       /** Queue handle */
>>> +       __u32   q_id;
>>> +       /** Flags */
>>> +       __u32   flags;
>>> +};
>>> +
>>> +union drm_amdgpu_userq {
>>> +       struct drm_amdgpu_userq_in in;
>>> +       struct drm_amdgpu_userq_out out;
>>> +};
>>> +
>>>   /* vm ioctl */
>>>   #define AMDGPU_VM_OP_RESERVE_VMID      1
>>>   #define AMDGPU_VM_OP_UNRESERVE_VMID    2
>>> --
>>> 2.34.1
>>>

