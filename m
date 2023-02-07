Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8255FC636CD
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Feb 2023 14:07:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF848892E4;
	Tue,  7 Feb 2023 14:07:45 +0000 (UTC)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA0FC892E4
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Feb 2023 14:07:43 +0000 (UTC)
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-1636eae256cso19202914fac.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Feb 2023 06:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7qSoBpYRr4iKfRF5SgbMs6/mds6N1gfwIeeajFOQlAw=;
 b=C4YGMJkvJE8WfCNME3W9amx0ywtjhi2MthqRXkFSxPOsBax4hNLmX8u4nlOsmWtzl1
 8A1msrQsehGKCysnD668b4zZscNK6e5LKvoSD0+xKYAvINNMXsXGZrysffLGK7YzG0pL
 pfsD/dEvCUCf51l0ZattI/jeO1nwKUj1vF36C5Q3NAmb+sJ5sjrynuImSPpzNNsToa38
 CHwPaL8f9cHQcB7mdxFuWf5GoxrXKogf/af1KNXQOEgD4f5eiXCSqPUjq6kLu4oZ55ET
 fOUfqXMaX1u760WfK03BnNBVU/K68HtIfxoDw2MH7+doTu2KB/Nu/sjkv2VLPYQjO94z
 dFcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7qSoBpYRr4iKfRF5SgbMs6/mds6N1gfwIeeajFOQlAw=;
 b=k0JRufmQ2GXKxSF63biNtcY+wtAgghD5nsAAlT93IPwGNbQ8XwRRVLs+Odul4cg2Ft
 vd000wDOT5Xho1vAC1oqsieYSwitkqP+aZWxU9xd1z5d2K4eNJyoGEoUgMBcgoCcuKm1
 uzAPlRPL/zcNKyGQGvWeJi8eZ6mSomSEUe1n58us2loMtkvl7OQTd7Xzl+/hJccHxBsq
 TnYY5pS0ibml3rLnvQlNm5348/rWl4KLcR0KEjx8XAcIUmWhssAyJNxvXiB6Bl1l4OZn
 dn2C68Rn/w/JjGz+5IWWlCcb+N0f0EXaS9zNVRIZZ6lNEYGGnSmK4vo9wxppZyC5vNX+
 yIbQ==
X-Gm-Message-State: AO0yUKXpF8yaI3fPqLpbf0O3xgNEHIhezzHKFcji9qmWYZvO09FTR57L
 /odX8JcKqHFXcmeAzyof8K9fG3yxCUqVHXo/8MI=
X-Google-Smtp-Source: AK7set+ohldm7WvXA4thwonAxTVoCv5cs9aeTXP2OP8eqHoROe8QrtjeChIYDPsO2ymq5vKISTLc4RviiYExqJ11w44=
X-Received: by 2002:a05:6870:ac0d:b0:163:a303:fe2f with SMTP id
 kw13-20020a056870ac0d00b00163a303fe2fmr460088oab.96.1675778862603; Tue, 07
 Feb 2023 06:07:42 -0800 (PST)
MIME-Version: 1.0
References: <20230203215409.2021-1-shashank.sharma@amd.com>
 <20230203215409.2021-2-shashank.sharma@amd.com>
 <CADnq5_MSMivTzo0k+wJj+bGpsQZ3HEDVt5XqzjGdBiv08fFWCQ@mail.gmail.com>
 <95ac9ea3-47c8-744c-7fd7-ddc54b19926f@amd.com>
 <CADnq5_M9q0R=d=KU8P4oVOCY0Gw97Uhzy6Mrg0GgxeROGn6xrQ@mail.gmail.com>
 <afce1a57-8007-5d1b-0715-9756d7d07153@amd.com>
 <CADnq5_P8UJYvnH_kWcPY2hfnhU3Ppo-3RoQAU5Ohf1T841kvzQ@mail.gmail.com>
 <bb992153-fa99-7b50-a188-e49a8d673439@gmail.com>
 <e5762028-238e-f317-8ba7-9c284d7a80af@amd.com>
In-Reply-To: <e5762028-238e-f317-8ba7-9c284d7a80af@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 7 Feb 2023 09:07:31 -0500
Message-ID: <CADnq5_ORm-=seDMuV8Z=c7K+zPypbvu=huzPmHSe1A44m_cTyQ@mail.gmail.com>
Subject: Re: [PATCH 1/8] drm/amdgpu: UAPI for user queue management
To: Shashank Sharma <shashank.sharma@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: alexander.deucher@amd.com,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Feb 7, 2023 at 2:38 AM Shashank Sharma <shashank.sharma@amd.com> wr=
ote:
>
>
> On 07/02/2023 08:03, Christian K=C3=B6nig wrote:
> > Am 06.02.23 um 22:03 schrieb Alex Deucher:
> >> On Mon, Feb 6, 2023 at 12:01 PM Christian K=C3=B6nig
> >> <christian.koenig@amd.com> wrote:
> >>> Am 06.02.23 um 17:56 schrieb Alex Deucher:
> >>>> On Fri, Feb 3, 2023 at 5:26 PM Shashank Sharma
> >>>> <shashank.sharma@amd.com> wrote:
> >>>>> Hey Alex,
> >>>>>
> >>>>> On 03/02/2023 23:07, Alex Deucher wrote:
> >>>>>> On Fri, Feb 3, 2023 at 4:54 PM Shashank Sharma
> >>>>>> <shashank.sharma@amd.com> wrote:
> >>>>>>> From: Alex Deucher <alexander.deucher@amd.com>
> >>>>>>>
> >>>>>>> This patch intorduces new UAPI/IOCTL for usermode graphics
> >>>>>>> queue. The userspace app will fill this structure and request
> >>>>>>> the graphics driver to add a graphics work queue for it. The
> >>>>>>> output of this UAPI is a queue id.
> >>>>>>>
> >>>>>>> This UAPI maps the queue into GPU, so the graphics app can start
> >>>>>>> submitting work to the queue as soon as the call returns.
> >>>>>>>
> >>>>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
> >>>>>>> Cc: Christian Koenig <christian.koenig@amd.com>
> >>>>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >>>>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> >>>>>>> ---
> >>>>>>>     include/uapi/drm/amdgpu_drm.h | 53
> >>>>>>> +++++++++++++++++++++++++++++++++++
> >>>>>>>     1 file changed, 53 insertions(+)
> >>>>>>>
> >>>>>>> diff --git a/include/uapi/drm/amdgpu_drm.h
> >>>>>>> b/include/uapi/drm/amdgpu_drm.h
> >>>>>>> index 4038abe8505a..6c5235d107b3 100644
> >>>>>>> --- a/include/uapi/drm/amdgpu_drm.h
> >>>>>>> +++ b/include/uapi/drm/amdgpu_drm.h
> >>>>>>> @@ -54,6 +54,7 @@ extern "C" {
> >>>>>>>     #define DRM_AMDGPU_VM                  0x13
> >>>>>>>     #define DRM_AMDGPU_FENCE_TO_HANDLE     0x14
> >>>>>>>     #define DRM_AMDGPU_SCHED               0x15
> >>>>>>> +#define DRM_AMDGPU_USERQ               0x16
> >>>>>>>
> >>>>>>>     #define DRM_IOCTL_AMDGPU_GEM_CREATE
> >>>>>>> DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union
> >>>>>>> drm_amdgpu_gem_create)
> >>>>>>>     #define DRM_IOCTL_AMDGPU_GEM_MMAP DRM_IOWR(DRM_COMMAND_BASE
> >>>>>>> + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
> >>>>>>> @@ -71,6 +72,7 @@ extern "C" {
> >>>>>>>     #define DRM_IOCTL_AMDGPU_VM DRM_IOWR(DRM_COMMAND_BASE +
> >>>>>>> DRM_AMDGPU_VM, union drm_amdgpu_vm)
> >>>>>>>     #define DRM_IOCTL_AMDGPU_FENCE_TO_HANDLE
> >>>>>>> DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_FENCE_TO_HANDLE, union
> >>>>>>> drm_amdgpu_fence_to_handle)
> >>>>>>>     #define DRM_IOCTL_AMDGPU_SCHED DRM_IOW(DRM_COMMAND_BASE +
> >>>>>>> DRM_AMDGPU_SCHED, union drm_amdgpu_sched)
> >>>>>>> +#define DRM_IOCTL_AMDGPU_USERQ DRM_IOW(DRM_COMMAND_BASE +
> >>>>>>> DRM_AMDGPU_USERQ, union drm_amdgpu_userq)
> >>>>>>>
> >>>>>>>     /**
> >>>>>>>      * DOC: memory domains
> >>>>>>> @@ -302,6 +304,57 @@ union drm_amdgpu_ctx {
> >>>>>>>            union drm_amdgpu_ctx_out out;
> >>>>>>>     };
> >>>>>>>
> >>>>>>> +/* user queue IOCTL */
> >>>>>>> +#define AMDGPU_USERQ_OP_CREATE 1
> >>>>>>> +#define AMDGPU_USERQ_OP_FREE   2
> >>>>>>> +
> >>>>>>> +#define AMDGPU_USERQ_MQD_FLAGS_SECURE  (1 << 0)
> >>>>>>> +#define AMDGPU_USERQ_MQD_FLAGS_AQL     (1 << 1)
> >>>>>>> +
> >>>>>>> +struct drm_amdgpu_userq_mqd {
> >>>>>>> +       /** Flags: AMDGPU_USERQ_MQD_FLAGS_* */
> >>>>>>> +       __u32   flags;
> >>>>>>> +       /** IP type: AMDGPU_HW_IP_* */
> >>>>>>> +       __u32   ip_type;
> >>>>>>> +       /** GEM object handle */
> >>>>>>> +       __u32   doorbell_handle;
> >>>>>>> +       /** Doorbell offset in dwords */
> >>>>>>> +       __u32   doorbell_offset;
> >>>>>> Since doorbells are 64 bit, maybe this offset should be in qwords.
> >>>>> Can you please help to cross check this information ? All the
> >>>>> existing
> >>>>> kernel doorbell calculations are keeping doorbells size as
> >>>>> sizeof(u32)
> >>>> Doorbells on pre-vega hardware are 32 bits so that is where that com=
es
> >>>> from, but from vega onward most doorbells are 64 bit.  I think some
> >>>> versions of VCN may still use 32 bit doorbells.  Internally in the
> >>>> kernel driver we just use two slots for newer hardware, but for the
> >>>> UAPI, I think we can just stick with 64 bit slots to avoid confusion=
.
> >>>> Even if an engine only uses a 32 bit one, I don't know that there is
> >>>> much value to trying to support variable doorbell sizes.
> >>> I think we can stick with using __u32 because this is *not* the size =
of
> >>> the doorbell entries.
> >>>
> >>> Instead this is the offset into the BO where to find the doorbell for
> >>> this queue (which then in turn is 64bits wide).
> >>>
> >>> Since we will probably never have more than 4GiB doorbells we should =
be
> >>> pretty save to use 32bits here.
> >> Yes, the offset would still be 32 bits, but the units would be
> >> qwords.  E.g.,
> >>
> >> +       /** Doorbell offset in qwords */
> >> +       __u32   doorbell_offset;
> >>
> >> That way you couldn't accidently specify an overlapping doorbell.
> >
> > Ah, so you only wanted to fix the comment. That was absolutely not
> > clear from the discussion.
>
> If I understand this correctly, the offset of the doorbell in the BO is
> still is 32-bit, but its width (size in bytes) is 64 bits. Am I getting
> that right ?

Right.  Each doorbell is 64 bits (8 bytes) so this value would
basically be an index into the doorbell bo.  Having it be a 64 bit
index rather than a 32 bit index would avoid the possibility of users
specifying overlapping doorbells.  E.g.,
offset in bytes
0 - doorbell
4 - doorbell
Would be incorrect, while
offset in bytes
0 - doorbell
8 - doorbell
Would be correct.

I.e., u64 doorbell_page[512] vs u32 doorbell_page[1024]

Alex

>
> - Shashank
>
> >
> > Christian.
> >
> >>
> >> Alex
> >>
> >>> Christian.
> >>>
> >>>> Alex
> >>>>
> >>>>>>> +       /** GPU virtual address of the queue */
> >>>>>>> +       __u64   queue_va;
> >>>>>>> +       /** Size of the queue in bytes */
> >>>>>>> +       __u64   queue_size;
> >>>>>>> +       /** GPU virtual address of the rptr */
> >>>>>>> +       __u64   rptr_va;
> >>>>>>> +       /** GPU virtual address of the wptr */
> >>>>>>> +       __u64   wptr_va;
> >>>>>>> +};
> >>>>>>> +
> >>>>>>> +struct drm_amdgpu_userq_in {
> >>>>>>> +       /** AMDGPU_USERQ_OP_* */
> >>>>>>> +       __u32   op;
> >>>>>>> +       /** Flags */
> >>>>>>> +       __u32   flags;
> >>>>>>> +       /** Queue handle to associate the queue free call with,
> >>>>>>> +        * unused for queue create calls */
> >>>>>>> +       __u32   queue_id;
> >>>>>>> +       __u32   pad;
> >>>>>>> +       /** Queue descriptor */
> >>>>>>> +       struct drm_amdgpu_userq_mqd mqd;
> >>>>>>> +};
> >>>>>>> +
> >>>>>>> +struct drm_amdgpu_userq_out {
> >>>>>>> +       /** Queue handle */
> >>>>>>> +       __u32   q_id;
> >>>>>> Maybe this should be queue_id to match the input.
> >>>>> Agree.
> >>>>>
> >>>>> - Shashank
> >>>>>
> >>>>>> Alex
> >>>>>>
> >>>>>>> +       /** Flags */
> >>>>>>> +       __u32   flags;
> >>>>>>> +};
> >>>>>>> +
> >>>>>>> +union drm_amdgpu_userq {
> >>>>>>> +       struct drm_amdgpu_userq_in in;
> >>>>>>> +       struct drm_amdgpu_userq_out out;
> >>>>>>> +};
> >>>>>>> +
> >>>>>>>     /* vm ioctl */
> >>>>>>>     #define AMDGPU_VM_OP_RESERVE_VMID      1
> >>>>>>>     #define AMDGPU_VM_OP_UNRESERVE_VMID    2
> >>>>>>> --
> >>>>>>> 2.34.1
> >>>>>>>
> >
