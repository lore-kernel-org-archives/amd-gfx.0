Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D46FFC636D3
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Feb 2023 21:03:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09D9110E439;
	Mon,  6 Feb 2023 21:03:40 +0000 (UTC)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C07B10E439
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Feb 2023 21:03:37 +0000 (UTC)
Received: by mail-oi1-x22c.google.com with SMTP id s66so10883396oib.7
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Feb 2023 13:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=azhL1zqqJPEMbXwMB/3dsU7MC1WJNYHFFzgqWQISxXg=;
 b=lS0ARvowfa9aLGWriPkXAr3UzyJEzejkWtQBSPkTuvAISsnxMc7OI6pfbe4Ya1iyJa
 as2aLc/p9Dfv5l4QrwDD2l7OiOJUDXpq0h7B1sxL8bW4EXWfSLI5nmy8bWgbI4egJYAe
 y8mhKwCBWXPIqLjZE8tqNoQlcLQd4/nOvBwqLDnGfMM/7ntEBYy1Gdho1tGMVh28Fadc
 B4vhoWWRlZjN0xwfLqyEvMaVGIts15L6UsLnoh3SLkmtk/jx4Hru/pLekqboSVSPvZ0T
 Uk139S0WgTmYwM8EqYCDV3qLyRo8xWtecttJ2fWaxkL/g2XzztKXOdaEUNfw5pUnxLDU
 fhWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=azhL1zqqJPEMbXwMB/3dsU7MC1WJNYHFFzgqWQISxXg=;
 b=VrZS5iPIYOUk6Jhfyr+qgX+miT3WqwFAToRL78YjRWPH2Mnnay408ygmpaLnJYQwdf
 WVM04HFKNQbF//NbBSQ8v8R+mQDGwLVIbAkb2nvtSRo0b15v2D4HefmrRrq2qn7B4nk9
 b0WobrSaHVTgoGyaVAm7O6+c9fBsd7aNFhMjfhMGgEgryzybcrNzY9cx6CfEdc6Z8Zu3
 PMGYPFOPcwuPiGGp/NnlhQn8wLoElqk+66jtx8KHqeDAKwT9uYh+1nKPJN6QRix5Ye4h
 Neg/As1vzD1lp1WIi32YSumVtwogukwRpAdqtBFpX/CiAKK/C0t/lueeyus0Aazy0c4I
 A8fw==
X-Gm-Message-State: AO0yUKUHbEA75dqMmWG5w9xA8EExesFQ0kQqlZNOsP+711sIiXNncZ54
 Qcn1RkRLTJNlsKFWKAXnhpt4+YLoAvF2YRagJcs=
X-Google-Smtp-Source: AK7set9o5sXgPRMbRz+DrFfKHGnXL/VV4Qot6Z441OhiWY7MJTW8Cm6Hi3DqBfuPLsxXUqqDQd3gFfpYYpRl6DM2XjY=
X-Received: by 2002:aca:654d:0:b0:35b:d93f:cbc4 with SMTP id
 j13-20020aca654d000000b0035bd93fcbc4mr80363oiw.96.1675717416821; Mon, 06 Feb
 2023 13:03:36 -0800 (PST)
MIME-Version: 1.0
References: <20230203215409.2021-1-shashank.sharma@amd.com>
 <20230203215409.2021-2-shashank.sharma@amd.com>
 <CADnq5_MSMivTzo0k+wJj+bGpsQZ3HEDVt5XqzjGdBiv08fFWCQ@mail.gmail.com>
 <95ac9ea3-47c8-744c-7fd7-ddc54b19926f@amd.com>
 <CADnq5_M9q0R=d=KU8P4oVOCY0Gw97Uhzy6Mrg0GgxeROGn6xrQ@mail.gmail.com>
 <afce1a57-8007-5d1b-0715-9756d7d07153@amd.com>
In-Reply-To: <afce1a57-8007-5d1b-0715-9756d7d07153@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 6 Feb 2023 16:03:24 -0500
Message-ID: <CADnq5_P8UJYvnH_kWcPY2hfnhU3Ppo-3RoQAU5Ohf1T841kvzQ@mail.gmail.com>
Subject: Re: [PATCH 1/8] drm/amdgpu: UAPI for user queue management
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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
Cc: alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org,
 Shashank Sharma <shashank.sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Feb 6, 2023 at 12:01 PM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 06.02.23 um 17:56 schrieb Alex Deucher:
> > On Fri, Feb 3, 2023 at 5:26 PM Shashank Sharma <shashank.sharma@amd.com=
> wrote:
> >> Hey Alex,
> >>
> >> On 03/02/2023 23:07, Alex Deucher wrote:
> >>> On Fri, Feb 3, 2023 at 4:54 PM Shashank Sharma <shashank.sharma@amd.c=
om> wrote:
> >>>> From: Alex Deucher <alexander.deucher@amd.com>
> >>>>
> >>>> This patch intorduces new UAPI/IOCTL for usermode graphics
> >>>> queue. The userspace app will fill this structure and request
> >>>> the graphics driver to add a graphics work queue for it. The
> >>>> output of this UAPI is a queue id.
> >>>>
> >>>> This UAPI maps the queue into GPU, so the graphics app can start
> >>>> submitting work to the queue as soon as the call returns.
> >>>>
> >>>> Cc: Alex Deucher <alexander.deucher@amd.com>
> >>>> Cc: Christian Koenig <christian.koenig@amd.com>
> >>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> >>>> ---
> >>>>    include/uapi/drm/amdgpu_drm.h | 53 ++++++++++++++++++++++++++++++=
+++++
> >>>>    1 file changed, 53 insertions(+)
> >>>>
> >>>> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu=
_drm.h
> >>>> index 4038abe8505a..6c5235d107b3 100644
> >>>> --- a/include/uapi/drm/amdgpu_drm.h
> >>>> +++ b/include/uapi/drm/amdgpu_drm.h
> >>>> @@ -54,6 +54,7 @@ extern "C" {
> >>>>    #define DRM_AMDGPU_VM                  0x13
> >>>>    #define DRM_AMDGPU_FENCE_TO_HANDLE     0x14
> >>>>    #define DRM_AMDGPU_SCHED               0x15
> >>>> +#define DRM_AMDGPU_USERQ               0x16
> >>>>
> >>>>    #define DRM_IOCTL_AMDGPU_GEM_CREATE    DRM_IOWR(DRM_COMMAND_BASE =
+ DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
> >>>>    #define DRM_IOCTL_AMDGPU_GEM_MMAP      DRM_IOWR(DRM_COMMAND_BASE =
+ DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
> >>>> @@ -71,6 +72,7 @@ extern "C" {
> >>>>    #define DRM_IOCTL_AMDGPU_VM            DRM_IOWR(DRM_COMMAND_BASE =
+ DRM_AMDGPU_VM, union drm_amdgpu_vm)
> >>>>    #define DRM_IOCTL_AMDGPU_FENCE_TO_HANDLE DRM_IOWR(DRM_COMMAND_BAS=
E + DRM_AMDGPU_FENCE_TO_HANDLE, union drm_amdgpu_fence_to_handle)
> >>>>    #define DRM_IOCTL_AMDGPU_SCHED         DRM_IOW(DRM_COMMAND_BASE +=
 DRM_AMDGPU_SCHED, union drm_amdgpu_sched)
> >>>> +#define DRM_IOCTL_AMDGPU_USERQ         DRM_IOW(DRM_COMMAND_BASE + D=
RM_AMDGPU_USERQ, union drm_amdgpu_userq)
> >>>>
> >>>>    /**
> >>>>     * DOC: memory domains
> >>>> @@ -302,6 +304,57 @@ union drm_amdgpu_ctx {
> >>>>           union drm_amdgpu_ctx_out out;
> >>>>    };
> >>>>
> >>>> +/* user queue IOCTL */
> >>>> +#define AMDGPU_USERQ_OP_CREATE 1
> >>>> +#define AMDGPU_USERQ_OP_FREE   2
> >>>> +
> >>>> +#define AMDGPU_USERQ_MQD_FLAGS_SECURE  (1 << 0)
> >>>> +#define AMDGPU_USERQ_MQD_FLAGS_AQL     (1 << 1)
> >>>> +
> >>>> +struct drm_amdgpu_userq_mqd {
> >>>> +       /** Flags: AMDGPU_USERQ_MQD_FLAGS_* */
> >>>> +       __u32   flags;
> >>>> +       /** IP type: AMDGPU_HW_IP_* */
> >>>> +       __u32   ip_type;
> >>>> +       /** GEM object handle */
> >>>> +       __u32   doorbell_handle;
> >>>> +       /** Doorbell offset in dwords */
> >>>> +       __u32   doorbell_offset;
> >>> Since doorbells are 64 bit, maybe this offset should be in qwords.
> >> Can you please help to cross check this information ? All the existing
> >> kernel doorbell calculations are keeping doorbells size as sizeof(u32)
> > Doorbells on pre-vega hardware are 32 bits so that is where that comes
> > from, but from vega onward most doorbells are 64 bit.  I think some
> > versions of VCN may still use 32 bit doorbells.  Internally in the
> > kernel driver we just use two slots for newer hardware, but for the
> > UAPI, I think we can just stick with 64 bit slots to avoid confusion.
> > Even if an engine only uses a 32 bit one, I don't know that there is
> > much value to trying to support variable doorbell sizes.
>
> I think we can stick with using __u32 because this is *not* the size of
> the doorbell entries.
>
> Instead this is the offset into the BO where to find the doorbell for
> this queue (which then in turn is 64bits wide).
>
> Since we will probably never have more than 4GiB doorbells we should be
> pretty save to use 32bits here.

Yes, the offset would still be 32 bits, but the units would be qwords.  E.g=
.,

+       /** Doorbell offset in qwords */
+       __u32   doorbell_offset;

That way you couldn't accidently specify an overlapping doorbell.

Alex

>
> Christian.
>
> >
> > Alex
> >
> >>>> +       /** GPU virtual address of the queue */
> >>>> +       __u64   queue_va;
> >>>> +       /** Size of the queue in bytes */
> >>>> +       __u64   queue_size;
> >>>> +       /** GPU virtual address of the rptr */
> >>>> +       __u64   rptr_va;
> >>>> +       /** GPU virtual address of the wptr */
> >>>> +       __u64   wptr_va;
> >>>> +};
> >>>> +
> >>>> +struct drm_amdgpu_userq_in {
> >>>> +       /** AMDGPU_USERQ_OP_* */
> >>>> +       __u32   op;
> >>>> +       /** Flags */
> >>>> +       __u32   flags;
> >>>> +       /** Queue handle to associate the queue free call with,
> >>>> +        * unused for queue create calls */
> >>>> +       __u32   queue_id;
> >>>> +       __u32   pad;
> >>>> +       /** Queue descriptor */
> >>>> +       struct drm_amdgpu_userq_mqd mqd;
> >>>> +};
> >>>> +
> >>>> +struct drm_amdgpu_userq_out {
> >>>> +       /** Queue handle */
> >>>> +       __u32   q_id;
> >>> Maybe this should be queue_id to match the input.
> >> Agree.
> >>
> >> - Shashank
> >>
> >>> Alex
> >>>
> >>>> +       /** Flags */
> >>>> +       __u32   flags;
> >>>> +};
> >>>> +
> >>>> +union drm_amdgpu_userq {
> >>>> +       struct drm_amdgpu_userq_in in;
> >>>> +       struct drm_amdgpu_userq_out out;
> >>>> +};
> >>>> +
> >>>>    /* vm ioctl */
> >>>>    #define AMDGPU_VM_OP_RESERVE_VMID      1
> >>>>    #define AMDGPU_VM_OP_UNRESERVE_VMID    2
> >>>> --
> >>>> 2.34.1
> >>>>
>
