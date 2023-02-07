Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7972DC636CC
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Feb 2023 14:17:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CE3710E50A;
	Tue,  7 Feb 2023 14:17:16 +0000 (UTC)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA09410E50A
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Feb 2023 14:17:13 +0000 (UTC)
Received: by mail-oi1-x236.google.com with SMTP id s66so12721143oib.7
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Feb 2023 06:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6gxUzkwCXzD7NAdd+xw2tKyZs0qUH0lPMAiWTC1NNSo=;
 b=OT2kQIGOSgUSpTOtHgRNAtxkXdUZWkgAaFetVKP4xs4VbRJ/MVOoRMihGqsLczn9i6
 M1iz7VbJbKLFuXKy1WKlpVWyZZmPjYOMiBiGVVUgAvzOgFFO07RUc3FBu/pldBQv39NP
 +dZJTd3RVRocMmTMeF9BzSRtpbhBAwpFDU/n55/yhrgI8unBEaAoWU3NsWtAmLUevbvq
 O50sf0yy4GxB1uHnJEBEkGd999mvL2oRJN9pDX8SdyhjpLm0rilD2VaUlQvTz3X5K82H
 1m1zcw7eujvItS4t9o9HU9+WcrVAWGSyLRzcc5c69aPRb4DJeYpk1dw4evKq3eYG3P+L
 sorw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6gxUzkwCXzD7NAdd+xw2tKyZs0qUH0lPMAiWTC1NNSo=;
 b=kcRpgO0jG2hxiGqSngS+pbmguaQZFPL9e2Wj1nseH4N6Wxhw4bVU0k93N6BB5/1hRA
 zz5gbXx1b9xMARZf5HA9HPLga6IL7YpJK0NZPG4FUAzAQFZA3rG5eTobt0cOu319PX1s
 EBf87We0IqC62bsDxI5JMD+hTB10Dz1+8LleVbZKQrouek5VXLvdCEEK1WVNTM7FQP6Z
 gx+A2UtPf+Z2OYPHpO27L5Eew6/NoX4nnYWgVIRDWq4XlkTj8N7jzRjFbWVEMxQ05UPR
 wO6TLx+eL+1B67z+spJs9DLW4420FiauZyA3Y+PYzpdNPpHsxG09qcU7E+Ae5xBfttDd
 QZsw==
X-Gm-Message-State: AO0yUKVgHK/GzY0G+Xtwp1kWqCfaxPb8rotGJoL3BFJODOmf9tvbuRev
 RYdiVADHzlNna8WNFi+fDE8i2J9fjFwM0vf4Xljw4StX
X-Google-Smtp-Source: AK7set+kAKqSrU9/EZf2v9w8oowt3OPYBbfQXwEbWdbcZFSI5WZLeHhyYaQulY8DqTzlvOH8avbsfpkLqjRCNQZqqGM=
X-Received: by 2002:a05:6808:6242:b0:378:4edd:a89c with SMTP id
 dt2-20020a056808624200b003784edda89cmr1600701oib.46.1675779432949; Tue, 07
 Feb 2023 06:17:12 -0800 (PST)
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
 <CADnq5_ORm-=seDMuV8Z=c7K+zPypbvu=huzPmHSe1A44m_cTyQ@mail.gmail.com>
 <7cde3170-49c3-9b15-4289-df754ca4804e@gmail.com>
In-Reply-To: <7cde3170-49c3-9b15-4289-df754ca4804e@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 7 Feb 2023 09:17:01 -0500
Message-ID: <CADnq5_Pw6hjpSce1Oy+Y4O_CQxdmqurNSbTHK6tuhzKPzx=ucA@mail.gmail.com>
Subject: Re: [PATCH 1/8] drm/amdgpu: UAPI for user queue management
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, Shashank Sharma <shashank.sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Feb 7, 2023 at 9:11 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 07.02.23 um 15:07 schrieb Alex Deucher:
> > On Tue, Feb 7, 2023 at 2:38 AM Shashank Sharma <shashank.sharma@amd.com=
> wrote:
> >>
> >> On 07/02/2023 08:03, Christian K=C3=B6nig wrote:
> >>> Am 06.02.23 um 22:03 schrieb Alex Deucher:
> >>>> On Mon, Feb 6, 2023 at 12:01 PM Christian K=C3=B6nig
> >>>> <christian.koenig@amd.com> wrote:
> >>>>> Am 06.02.23 um 17:56 schrieb Alex Deucher:
> >>>>>> On Fri, Feb 3, 2023 at 5:26 PM Shashank Sharma
> >>>>>> <shashank.sharma@amd.com> wrote:
> >>>>>>> Hey Alex,
> >>>>>>>
> >>>>>>> On 03/02/2023 23:07, Alex Deucher wrote:
> >>>>>>>> On Fri, Feb 3, 2023 at 4:54 PM Shashank Sharma
> >>>>>>>> <shashank.sharma@amd.com> wrote:
> >>>>>>>>> From: Alex Deucher <alexander.deucher@amd.com>
> >>>>>>>>>
> >>>>>>>>> This patch intorduces new UAPI/IOCTL for usermode graphics
> >>>>>>>>> queue. The userspace app will fill this structure and request
> >>>>>>>>> the graphics driver to add a graphics work queue for it. The
> >>>>>>>>> output of this UAPI is a queue id.
> >>>>>>>>>
> >>>>>>>>> This UAPI maps the queue into GPU, so the graphics app can star=
t
> >>>>>>>>> submitting work to the queue as soon as the call returns.
> >>>>>>>>>
> >>>>>>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
> >>>>>>>>> Cc: Christian Koenig <christian.koenig@amd.com>
> >>>>>>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >>>>>>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> >>>>>>>>> ---
> >>>>>>>>>      include/uapi/drm/amdgpu_drm.h | 53
> >>>>>>>>> +++++++++++++++++++++++++++++++++++
> >>>>>>>>>      1 file changed, 53 insertions(+)
> >>>>>>>>>
> >>>>>>>>> diff --git a/include/uapi/drm/amdgpu_drm.h
> >>>>>>>>> b/include/uapi/drm/amdgpu_drm.h
> >>>>>>>>> index 4038abe8505a..6c5235d107b3 100644
> >>>>>>>>> --- a/include/uapi/drm/amdgpu_drm.h
> >>>>>>>>> +++ b/include/uapi/drm/amdgpu_drm.h
> >>>>>>>>> @@ -54,6 +54,7 @@ extern "C" {
> >>>>>>>>>      #define DRM_AMDGPU_VM                  0x13
> >>>>>>>>>      #define DRM_AMDGPU_FENCE_TO_HANDLE     0x14
> >>>>>>>>>      #define DRM_AMDGPU_SCHED               0x15
> >>>>>>>>> +#define DRM_AMDGPU_USERQ               0x16
> >>>>>>>>>
> >>>>>>>>>      #define DRM_IOCTL_AMDGPU_GEM_CREATE
> >>>>>>>>> DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union
> >>>>>>>>> drm_amdgpu_gem_create)
> >>>>>>>>>      #define DRM_IOCTL_AMDGPU_GEM_MMAP DRM_IOWR(DRM_COMMAND_BAS=
E
> >>>>>>>>> + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
> >>>>>>>>> @@ -71,6 +72,7 @@ extern "C" {
> >>>>>>>>>      #define DRM_IOCTL_AMDGPU_VM DRM_IOWR(DRM_COMMAND_BASE +
> >>>>>>>>> DRM_AMDGPU_VM, union drm_amdgpu_vm)
> >>>>>>>>>      #define DRM_IOCTL_AMDGPU_FENCE_TO_HANDLE
> >>>>>>>>> DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_FENCE_TO_HANDLE, union
> >>>>>>>>> drm_amdgpu_fence_to_handle)
> >>>>>>>>>      #define DRM_IOCTL_AMDGPU_SCHED DRM_IOW(DRM_COMMAND_BASE +
> >>>>>>>>> DRM_AMDGPU_SCHED, union drm_amdgpu_sched)
> >>>>>>>>> +#define DRM_IOCTL_AMDGPU_USERQ DRM_IOW(DRM_COMMAND_BASE +
> >>>>>>>>> DRM_AMDGPU_USERQ, union drm_amdgpu_userq)
> >>>>>>>>>
> >>>>>>>>>      /**
> >>>>>>>>>       * DOC: memory domains
> >>>>>>>>> @@ -302,6 +304,57 @@ union drm_amdgpu_ctx {
> >>>>>>>>>             union drm_amdgpu_ctx_out out;
> >>>>>>>>>      };
> >>>>>>>>>
> >>>>>>>>> +/* user queue IOCTL */
> >>>>>>>>> +#define AMDGPU_USERQ_OP_CREATE 1
> >>>>>>>>> +#define AMDGPU_USERQ_OP_FREE   2
> >>>>>>>>> +
> >>>>>>>>> +#define AMDGPU_USERQ_MQD_FLAGS_SECURE  (1 << 0)
> >>>>>>>>> +#define AMDGPU_USERQ_MQD_FLAGS_AQL     (1 << 1)
> >>>>>>>>> +
> >>>>>>>>> +struct drm_amdgpu_userq_mqd {
> >>>>>>>>> +       /** Flags: AMDGPU_USERQ_MQD_FLAGS_* */
> >>>>>>>>> +       __u32   flags;
> >>>>>>>>> +       /** IP type: AMDGPU_HW_IP_* */
> >>>>>>>>> +       __u32   ip_type;
> >>>>>>>>> +       /** GEM object handle */
> >>>>>>>>> +       __u32   doorbell_handle;
> >>>>>>>>> +       /** Doorbell offset in dwords */
> >>>>>>>>> +       __u32   doorbell_offset;
> >>>>>>>> Since doorbells are 64 bit, maybe this offset should be in qword=
s.
> >>>>>>> Can you please help to cross check this information ? All the
> >>>>>>> existing
> >>>>>>> kernel doorbell calculations are keeping doorbells size as
> >>>>>>> sizeof(u32)
> >>>>>> Doorbells on pre-vega hardware are 32 bits so that is where that c=
omes
> >>>>>> from, but from vega onward most doorbells are 64 bit.  I think som=
e
> >>>>>> versions of VCN may still use 32 bit doorbells.  Internally in the
> >>>>>> kernel driver we just use two slots for newer hardware, but for th=
e
> >>>>>> UAPI, I think we can just stick with 64 bit slots to avoid confusi=
on.
> >>>>>> Even if an engine only uses a 32 bit one, I don't know that there =
is
> >>>>>> much value to trying to support variable doorbell sizes.
> >>>>> I think we can stick with using __u32 because this is *not* the siz=
e of
> >>>>> the doorbell entries.
> >>>>>
> >>>>> Instead this is the offset into the BO where to find the doorbell f=
or
> >>>>> this queue (which then in turn is 64bits wide).
> >>>>>
> >>>>> Since we will probably never have more than 4GiB doorbells we shoul=
d be
> >>>>> pretty save to use 32bits here.
> >>>> Yes, the offset would still be 32 bits, but the units would be
> >>>> qwords.  E.g.,
> >>>>
> >>>> +       /** Doorbell offset in qwords */
> >>>> +       __u32   doorbell_offset;
> >>>>
> >>>> That way you couldn't accidently specify an overlapping doorbell.
> >>> Ah, so you only wanted to fix the comment. That was absolutely not
> >>> clear from the discussion.
> >> If I understand this correctly, the offset of the doorbell in the BO i=
s
> >> still is 32-bit, but its width (size in bytes) is 64 bits. Am I gettin=
g
> >> that right ?
> > Right.  Each doorbell is 64 bits (8 bytes) so this value would
> > basically be an index into the doorbell bo.  Having it be a 64 bit
> > index rather than a 32 bit index would avoid the possibility of users
> > specifying overlapping doorbells.  E.g.,
> > offset in bytes
> > 0 - doorbell
> > 4 - doorbell
> > Would be incorrect, while
> > offset in bytes
> > 0 - doorbell
> > 8 - doorbell
> > Would be correct.
> >
> > I.e., u64 doorbell_page[512] vs u32 doorbell_page[1024]
>
> Well I usually prefer just straight byte offsets, but I think the main
> question is what does the underlying hw/fw use?
>
> If that's a dword index we should probably stick with that in the UAPI
> as well. If it's in qword then stick to that, if it's in bytes than use
> that.

The MQD takes a dword offset from the start of the BAR, but the
doorbell is 64 bits wide so we have to be careful that we check for
overlapping doorbells.

Alex

>
> Otherwise we will just confuse people when we convert between the
> different API levels.
>
> Christian.
>
> >
> > Alex
> >
> >> - Shashank
> >>
> >>> Christian.
> >>>
> >>>> Alex
> >>>>
> >>>>> Christian.
> >>>>>
> >>>>>> Alex
> >>>>>>
> >>>>>>>>> +       /** GPU virtual address of the queue */
> >>>>>>>>> +       __u64   queue_va;
> >>>>>>>>> +       /** Size of the queue in bytes */
> >>>>>>>>> +       __u64   queue_size;
> >>>>>>>>> +       /** GPU virtual address of the rptr */
> >>>>>>>>> +       __u64   rptr_va;
> >>>>>>>>> +       /** GPU virtual address of the wptr */
> >>>>>>>>> +       __u64   wptr_va;
> >>>>>>>>> +};
> >>>>>>>>> +
> >>>>>>>>> +struct drm_amdgpu_userq_in {
> >>>>>>>>> +       /** AMDGPU_USERQ_OP_* */
> >>>>>>>>> +       __u32   op;
> >>>>>>>>> +       /** Flags */
> >>>>>>>>> +       __u32   flags;
> >>>>>>>>> +       /** Queue handle to associate the queue free call with,
> >>>>>>>>> +        * unused for queue create calls */
> >>>>>>>>> +       __u32   queue_id;
> >>>>>>>>> +       __u32   pad;
> >>>>>>>>> +       /** Queue descriptor */
> >>>>>>>>> +       struct drm_amdgpu_userq_mqd mqd;
> >>>>>>>>> +};
> >>>>>>>>> +
> >>>>>>>>> +struct drm_amdgpu_userq_out {
> >>>>>>>>> +       /** Queue handle */
> >>>>>>>>> +       __u32   q_id;
> >>>>>>>> Maybe this should be queue_id to match the input.
> >>>>>>> Agree.
> >>>>>>>
> >>>>>>> - Shashank
> >>>>>>>
> >>>>>>>> Alex
> >>>>>>>>
> >>>>>>>>> +       /** Flags */
> >>>>>>>>> +       __u32   flags;
> >>>>>>>>> +};
> >>>>>>>>> +
> >>>>>>>>> +union drm_amdgpu_userq {
> >>>>>>>>> +       struct drm_amdgpu_userq_in in;
> >>>>>>>>> +       struct drm_amdgpu_userq_out out;
> >>>>>>>>> +};
> >>>>>>>>> +
> >>>>>>>>>      /* vm ioctl */
> >>>>>>>>>      #define AMDGPU_VM_OP_RESERVE_VMID      1
> >>>>>>>>>      #define AMDGPU_VM_OP_UNRESERVE_VMID    2
> >>>>>>>>> --
> >>>>>>>>> 2.34.1
> >>>>>>>>>
>
