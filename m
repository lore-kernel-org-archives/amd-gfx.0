Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99952E732D0
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Sep 2023 13:52:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 314F110E65E;
	Thu, 28 Sep 2023 13:52:21 +0000 (UTC)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BED2E10E65E
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Sep 2023 13:52:19 +0000 (UTC)
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3ae55c2e12bso2880805b6e.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Sep 2023 06:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695909139; x=1696513939; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CQ8pnXPxAY4vH8uC9RKbV+9PV4+2DLyOXMhtWCcMSWY=;
 b=HQ66Qg2moZiZ9uWEQwqs2CDJgLBiMNd5AM6JT7cWJme7cqsSrTqD7oBBYR4xgdXGmX
 6Hz3vur/FICmulsuyArBYKaVI9Yyzw5qxIe+7wavvg+V2gAzl1rT7daTvaTVTxNuJ+n4
 M8BHuFgwDMlVxId3OO7YX9FQXtClmh28N4uQWd4HobluwMIl3Hu3eDpiw1mGWnbrYdle
 fpjWF0ZuhXAOcPtso57jx0MKXae19EzwOdggIvezOmaUM8Nc/10SVm8fjJU6+GMa3E1O
 92Ii40c+qr7sAhHStgT3zs6r2WpSHNATTJ0v56moUcG/CyMOFS57SNtsoQtzstNZqGyQ
 2dsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695909139; x=1696513939;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CQ8pnXPxAY4vH8uC9RKbV+9PV4+2DLyOXMhtWCcMSWY=;
 b=niCxMv5JR3c92XTiuYt54Pxdv9pVipvqmrdzkJ8ad4L0q1zwcub6dd29erG8Z6LkDK
 PPNc/Ryt5mhbetnafFH5ft0E2swXDYBz/z8Qqs3oFtua0EH2R4scaLe3cUyy53GKQUI/
 TYpTITSjDO14hHbLsvJvXpk81RJJ5URds+4/L9p1Oe176ykID4n0+Y5DnzWb2Me3K5tQ
 OMou6HTkvzROcw8i0pHZ7ePN3HI0O7dI7iheC19UhQ9by+FjEB8nyAPs6BLYY2szip8x
 bTfWcc3Lv/1AMN8zpGaLxb31w8ulaN480AGGqraD3hdIbIrEgMcLnUqhAQW4UWiVqCF2
 x1Lw==
X-Gm-Message-State: AOJu0YyHPBEPJ7TNkHJAOsqy+sEG3QS7i1CJMpnGlBF1/7R95BCnHyT1
 SLgrUZ7E9qdvZI12NfNIJAGG26FyY6M1du1jmmUu/k/Hqzo=
X-Google-Smtp-Source: AGHT+IHCkUtQb7sI0I2bpBjdQlP3rVX76drr99Dym3Buml9elAX2j8sLTyLpv3PUScdaXYI/ji5lRd1len5smZCVNh0=
X-Received: by 2002:a05:6870:d0c1:b0:1d6:567b:79aa with SMTP id
 k1-20020a056870d0c100b001d6567b79aamr1207657oaa.56.1695909138893; Thu, 28 Sep
 2023 06:52:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230908160446.2188-1-shashank.sharma@amd.com>
 <20230908160446.2188-5-shashank.sharma@amd.com>
 <6d579492-1555-4dba-68c6-130266c011a1@amd.com>
 <009e90dd-2cf2-9838-a8c3-f18cbbd29b3d@amd.com>
 <c097f8eb-9866-d4f8-6b18-383dd9b69400@amd.com>
 <CADnq5_Od2uEzpPMGvUx-R2uDtTeymwPvk67Fvm8VW1GV2VU3nA@mail.gmail.com>
 <9789fc70-969a-285c-65ae-f33cc613f674@amd.com>
In-Reply-To: <9789fc70-969a-285c-65ae-f33cc613f674@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 28 Sep 2023 09:52:07 -0400
Message-ID: <CADnq5_NbrmBT1=82yBZYB31=e_3GOELOLZrfoevBvb2WCaV7sQ@mail.gmail.com>
Subject: Re: [PATCH v6 4/9] drm/amdgpu: create GFX-gen11 usermode queue
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
Cc: Alex Deucher <alexander.deucher@amd.com>, arvind.yadav@amd.com,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Sep 28, 2023 at 9:40=E2=80=AFAM Shashank Sharma <shashank.sharma@am=
d.com> wrote:
>
>
> On 28/09/2023 15:27, Alex Deucher wrote:
> > On Thu, Sep 28, 2023 at 9:22=E2=80=AFAM Shashank Sharma <shashank.sharm=
a@amd.com> wrote:
> >>
> >> On 14/09/2023 10:24, Shashank Sharma wrote:
> >>> On 14/09/2023 09:45, Christian K=C3=B6nig wrote:
> >>>> Am 08.09.23 um 18:04 schrieb Shashank Sharma:
> >>>>> A Memory queue descriptor (MQD) of a userqueue defines it in
> >>>>> the hw's context. As MQD format can vary between different
> >>>>> graphics IPs, we need gfx GEN specific handlers to create MQDs.
> >>>>>
> >>>>> This patch:
> >>>>> - Introduces MQD handler functions for the usermode queues.
> >>>>> - Adds new functions to create and destroy userqueue MQD for
> >>>>>     GFX-GEN-11 IP
> >>>>>
> >>>>> V1: Worked on review comments from Alex:
> >>>>>       - Make MQD functions GEN and IP specific
> >>>>>
> >>>>> V2: Worked on review comments from Alex:
> >>>>>       - Reuse the existing adev->mqd[ip] for MQD creation
> >>>>>       - Formatting and arrangement of code
> >>>>>
> >>>>> V3:
> >>>>>       - Integration with doorbell manager
> >>>>>
> >>>>> V4: Review comments addressed:
> >>>>>       - Do not create a new file for userq, reuse gfx_v11_0.c (Alex=
)
> >>>>>       - Align name of structure members (Luben)
> >>>>>       - Don't break up the Cc tag list and the Sob tag list in comm=
it
> >>>>>         message (Luben)
> >>>>> V5:
> >>>>>      - No need to reserve the bo for MQD (Christian).
> >>>>>      - Some more changes to support IP specific MQD creation.
> >>>>>
> >>>>> V6:
> >>>>>      - Add a comment reminding us to replace the
> >>>>> amdgpu_bo_create_kernel()
> >>>>>        calls while creating MQD object to amdgpu_bo_create() once
> >>>>> eviction
> >>>>>        fences are ready (Christian).
> >>>>>
> >>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
> >>>>> Cc: Christian Koenig <christian.koenig@amd.com>
> >>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> >>>>> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
> >>>>> ---
> >>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 16 ++++
> >>>>>    drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 77
> >>>>> +++++++++++++++++++
> >>>>>    .../gpu/drm/amd/include/amdgpu_userqueue.h    |  7 ++
> >>>>>    3 files changed, 100 insertions(+)
> >>>>>
> >>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> >>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> >>>>> index 44769423ba30..03fc8e89eafb 100644
> >>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> >>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> >>>>> @@ -140,12 +140,28 @@ int amdgpu_userq_ioctl(struct drm_device *dev=
,
> >>>>> void *data,
> >>>>>        return r;
> >>>>>    }
> >>>>>    +extern const struct amdgpu_userq_funcs userq_gfx_v11_funcs;
> >>>>> +
> >>>>> +static void
> >>>>> +amdgpu_userqueue_setup_gfx(struct amdgpu_userq_mgr *uq_mgr)
> >>>>> +{
> >>>>> +    int maj;
> >>>>> +    struct amdgpu_device *adev =3D uq_mgr->adev;
> >>>>> +    uint32_t version =3D adev->ip_versions[GC_HWIP][0];
> >>>>> +
> >>>>> +    /* We support usermode queue only for GFX V11 as of now */
> >>>>> +    maj =3D IP_VERSION_MAJ(version);
> >>>>> +    if (maj =3D=3D 11)
> >>>>> +        uq_mgr->userq_funcs[AMDGPU_HW_IP_GFX] =3D &userq_gfx_v11_f=
uncs;
> >>>>> +}
> >>>> That belongs into gfx_v11.c and not here.
> >>>
> >>> Agree,
> >> On a second thought, we can't move it to gfx_v11.c, as this is the pla=
ce
> >> where we are setting up the gfx_userqueue functions in fpriv->uq_mgr()
> >> for the first time, and we do not have another option but to check the
> >> IP and setup the functions here. The only other option to do this will
> >> be to move  uq_mgr->userq_funcs to adev->gfx.userq_funcs and setup the=
m
> >> with the IP init (as Alex once suggested). Please let me know your
> >> thoughts on this.
> > That seems cleaner to me.  They should be global anyway and could be
> > set as part of the individual IP init sequences.  Then the presence of
> > a pointer could be used to determine whether or not a particular IP
> > type supports user queues.
> >
> > Alex
> >
> So if I understand this correctly, this is how we are looking to arrange
> the userqueue IP functions:
>
> - Presence of adev->gfx.funcs.userqueue_funcs() will decide if this IP
> supports userqueue or not.
>
> - sw_init function of the IP will setup these fptrs like:
>
>    in gfx_v11_0_sw_init :
>
>      if (GFX_MAJ =3D=3D 11)
>
>          adev->gfx.funcs.userqueue_funcs =3D gfx_v11_0_userqueue_funcs

I was thinking something more like:

adev->userq_funcs[AMD_IP_BLOCK_TYPE_GFX] =3D gfx_v11_0_userqueue_funcs;

That way there would be one place for all of the all of the fptrs and
you could use the IP type to query the right one.

And then in the IOCTLs, you could just check if the pointer is valid.  E.g.=
,

if (!adev->userq_funcs[ip_block_type])
   return -EINVAL;

etc.

You could store any metadata relevant to each userq in the per fd user
queue manager and then just pass the state to the global userq
functions for each IP.

Alex

>
>
> In amdgpu_userqueue_ioctl:
>
>      |
>
> CASE: create:
>
>      amdgpu_userqueue_create()
>
>      if (adev->gfx.funcs.userqueue_funcs) {
>
>          adev->gfx.funcs.userqueue_funcs.create_mqd();
>
>      }
>
>
> CASE: destroy:
>
>      amdgpu_userqueue_destroy()
>
>      if (adev->gfx.funcs.userqueue_funcs) {
>
>          adev->gfx.funcs.userqueue_funcs.destroy_mqd();
>
>      }
>
> and so on ...
>
> Am I getting this right ?
>
> - Shashank
>
> >> - Shashank
> >>
> >>>>> +
> >>>>>    int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr,
> >>>>> struct amdgpu_device *adev)
> >>>>>    {
> >>>>>        mutex_init(&userq_mgr->userq_mutex);
> >>>>>        idr_init_base(&userq_mgr->userq_idr, 1);
> >>>>>        userq_mgr->adev =3D adev;
> >>>>>    +    amdgpu_userqueue_setup_gfx(userq_mgr);
> >>>>>        return 0;
> >>>>>    }
> >>>>>    diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> >>>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> >>>>> index 0451533ddde4..6760abda08df 100644
> >>>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> >>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> >>>>> @@ -30,6 +30,7 @@
> >>>>>    #include "amdgpu_psp.h"
> >>>>>    #include "amdgpu_smu.h"
> >>>>>    #include "amdgpu_atomfirmware.h"
> >>>>> +#include "amdgpu_userqueue.h"
> >>>>>    #include "imu_v11_0.h"
> >>>>>    #include "soc21.h"
> >>>>>    #include "nvd.h"
> >>>>> @@ -6422,3 +6423,79 @@ const struct amdgpu_ip_block_version
> >>>>> gfx_v11_0_ip_block =3D
> >>>>>        .rev =3D 0,
> >>>>>        .funcs =3D &gfx_v11_0_ip_funcs,
> >>>>>    };
> >>>>> +
> >>>>> +static int gfx_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_=
mgr,
> >>>>> +                      struct drm_amdgpu_userq_in *args_in,
> >>>>> +                      struct amdgpu_usermode_queue *queue)
> >>>>> +{
> >>>>> +    struct amdgpu_device *adev =3D uq_mgr->adev;
> >>>>> +    struct amdgpu_mqd *mqd_gfx_generic =3D
> >>>>> &adev->mqds[AMDGPU_HW_IP_GFX];
> >>>>> +    struct drm_amdgpu_userq_mqd_gfx_v11_0 mqd_user;
> >>>>> +    struct amdgpu_mqd_prop userq_props;
> >>>>> +    int r;
> >>>>> +
> >>>>> +    /* Incoming MQD parameters from userspace to be saved here */
> >>>>> +    memset(&mqd_user, 0, sizeof(mqd_user));
> >>>>> +
> >>>>> +    /* Structure to initialize MQD for userqueue using generic MQD
> >>>>> init function */
> >>>>> +    memset(&userq_props, 0, sizeof(userq_props));
> >>>>> +
> >>>>> +    if (args_in->mqd_size !=3D sizeof(struct
> >>>>> drm_amdgpu_userq_mqd_gfx_v11_0)) {
> >>>>> +        DRM_ERROR("MQD size mismatch\n");
> >>>>> +        return -EINVAL;
> >>>>> +    }
> >>>>> +
> >>>>> +    if (copy_from_user(&mqd_user, u64_to_user_ptr(args_in->mqd),
> >>>>> args_in->mqd_size)) {
> >>>>> +        DRM_ERROR("Failed to get user MQD\n");
> >>>>> +        return -EFAULT;
> >>>>> +    }
> >>>>> +
> >>>>> +    /*
> >>>>> +     * Create BO for actual Userqueue MQD now
> >>>>> +     * Todo: replace the calls to bo_create_kernel() with
> >>>>> bo_create() and use
> >>>>> +     * implicit pinning for the MQD buffers.
> >>>> Well not implicit pinning, but rather fencing of the BO.
> >>>>
> >>> Noted.
> >>>
> >>> - Shashank
> >>>
> >>>
> >>>> Regards,
> >>>> Christian.
> >>>>
> >>>>> +     */
> >>>>> +    r =3D amdgpu_bo_create_kernel(adev, mqd_gfx_generic->mqd_size,
> >>>>> PAGE_SIZE,
> >>>>> +                    AMDGPU_GEM_DOMAIN_GTT,
> >>>>> +                    &queue->mqd.obj,
> >>>>> +                    &queue->mqd.gpu_addr,
> >>>>> +                    &queue->mqd.cpu_ptr);
> >>>>> +    if (r) {
> >>>>> +        DRM_ERROR("Failed to allocate BO for userqueue (%d)", r);
> >>>>> +        return -ENOMEM;
> >>>>> +    }
> >>>>> +    memset(queue->mqd.cpu_ptr, 0, mqd_gfx_generic->mqd_size);
> >>>>> +
> >>>>> +    /* Initialize the MQD BO with user given values */
> >>>>> +    userq_props.wptr_gpu_addr =3D mqd_user.wptr_va;
> >>>>> +    userq_props.rptr_gpu_addr =3D mqd_user.rptr_va;
> >>>>> +    userq_props.queue_size =3D mqd_user.queue_size;
> >>>>> +    userq_props.hqd_base_gpu_addr =3D mqd_user.queue_va;
> >>>>> +    userq_props.mqd_gpu_addr =3D queue->mqd.gpu_addr;
> >>>>> +    userq_props.use_doorbell =3D true;
> >>>>> +
> >>>>> +    r =3D mqd_gfx_generic->init_mqd(adev, (void *)queue->mqd.cpu_p=
tr,
> >>>>> &userq_props);
> >>>>> +    if (r) {
> >>>>> +        DRM_ERROR("Failed to initialize MQD for userqueue\n");
> >>>>> +        goto free_mqd;
> >>>>> +    }
> >>>>> +
> >>>>> +    return 0;
> >>>>> +
> >>>>> +free_mqd:
> >>>>> +    amdgpu_bo_free_kernel(&queue->mqd.obj, &queue->mqd.gpu_addr,
> >>>>> &queue->mqd.cpu_ptr);
> >>>>> +    return r;
> >>>>> +}
> >>>>> +
> >>>>> +static void
> >>>>> +gfx_v11_0_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr, struc=
t
> >>>>> amdgpu_usermode_queue *queue)
> >>>>> +{
> >>>>> +    struct amdgpu_userq_obj *mqd =3D &queue->mqd;
> >>>>> +
> >>>>> +    amdgpu_bo_free_kernel(&mqd->obj, &mqd->gpu_addr, &mqd->cpu_ptr=
);
> >>>>> +}
> >>>>> +
> >>>>> +const struct amdgpu_userq_funcs userq_gfx_v11_funcs =3D {
> >>>>> +    .mqd_create =3D gfx_v11_0_userq_mqd_create,
> >>>>> +    .mqd_destroy =3D gfx_v11_0_userq_mqd_destroy,
> >>>>> +};
> >>>>> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> >>>>> b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> >>>>> index 55ed6512a565..240f92796f00 100644
> >>>>> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> >>>>> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> >>>>> @@ -29,6 +29,12 @@
> >>>>>      struct amdgpu_mqd_prop;
> >>>>>    +struct amdgpu_userq_obj {
> >>>>> +    void         *cpu_ptr;
> >>>>> +    uint64_t     gpu_addr;
> >>>>> +    struct amdgpu_bo *obj;
> >>>>> +};
> >>>>> +
> >>>>>    struct amdgpu_usermode_queue {
> >>>>>        int            queue_type;
> >>>>>        uint64_t        doorbell_handle;
> >>>>> @@ -37,6 +43,7 @@ struct amdgpu_usermode_queue {
> >>>>>        struct amdgpu_mqd_prop    *userq_prop;
> >>>>>        struct amdgpu_userq_mgr *userq_mgr;
> >>>>>        struct amdgpu_vm    *vm;
> >>>>> +    struct amdgpu_userq_obj mqd;
> >>>>>    };
> >>>>>      struct amdgpu_userq_funcs {
