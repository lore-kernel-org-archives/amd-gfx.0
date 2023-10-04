Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15F41E7B611
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Oct 2023 13:13:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BF91891A3;
	Wed,  4 Oct 2023 13:13:45 +0000 (UTC)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B9A1891A3
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Oct 2023 13:13:44 +0000 (UTC)
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-1e1a2e26afcso1397689fac.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Oct 2023 06:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696425223; x=1697030023; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yxcQw8eUKA7ELohgummqMLiBSJJJtm1+W7xwhH9zI/U=;
 b=UpwC1igJ2/56y2xLL1Aa/FJnVzA1n89ei/U4kpVQz4VwH8JU4Dz7f7An/f1Vc6za2E
 X8Q4PLGrqexd1kxdhno4nSYhLaMjBaS0kBgsIhdXgVc9CGL6YuZGlWYY+B9z3buZbQ8+
 jRD0UyaFbN73uXj9IgnV3hrPHAjbW2UkfDrgNzrh8XSJJ1yiWuShX3ruBVvfJhMvuYiN
 YjS4hS+ZOfidBmrhgvyTh7OU95oi8kFMZ0qz+tNw3UXiZ5mffzpC2SZYTCFsT+duLDyz
 E2ghdrUzZP60nSmycBj7EQFkGdWPYyAte/oDTyr8DYaqsON3whxAUxUBwtxo9dSQhPBO
 UZXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696425223; x=1697030023;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yxcQw8eUKA7ELohgummqMLiBSJJJtm1+W7xwhH9zI/U=;
 b=RqjXwjgXpFQAW97r4btY4RncGKaIUWlJtnL22OFQxmYHHtGXnaakYdRtJScAwuCK9x
 G4UnXov0hTlrfnRLyY+nYMZriMlWroCwlGvFC7QFKYZh0eXdZ5ng3OsaFyulVgL8I3UO
 iQ6RDL06jXs47GT3lpvRF7oGJTx8z8vLsv/50Xmr00FsUkJidZEzOsANpJZNeyBxqjBj
 veiqkPBPED+72FZViv6Dv/9GGLRPBcIB4j4z7rLSY1omPBUZESi+8/cmVIJWV+8tmUj6
 jdFduSqpnBsZx/Gce8Kxzzo/aSAX19RMSAialwFTWTuBX1/vjjUgukMiKHB6tJDg/k29
 68nQ==
X-Gm-Message-State: AOJu0Yx3QusEeybqN7TfSXNd56hKMuAXrDnWlJAMPvbg2x8LJ2rC3bAy
 N/U/21vdexVzl4YOjRzrdiwgWpcvIoKQbnyr7TiltBnu
X-Google-Smtp-Source: AGHT+IEcrz1zRIP0J5Y+LnqALeqayCTeNMBN/Zh5BaK2tECfVqQG4u0VQPr8TyqBC+r5W0nZ3rG8AkckmzG2/kVKg3w=
X-Received: by 2002:a05:6870:7010:b0:1c0:5f7a:896f with SMTP id
 u16-20020a056870701000b001c05f7a896fmr2668189oae.8.1696425223405; Wed, 04 Oct
 2023 06:13:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230908160446.2188-1-shashank.sharma@amd.com>
 <20230908160446.2188-6-shashank.sharma@amd.com>
 <CADnq5_MiNtSswTycxUQu0MfbD80LNg1M0=NCJ_1Br2Ek=ir-ig@mail.gmail.com>
 <deb6a51c-3a4b-fcb5-7b5f-ff0eade3d72b@amd.com>
In-Reply-To: <deb6a51c-3a4b-fcb5-7b5f-ff0eade3d72b@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 4 Oct 2023 09:13:32 -0400
Message-ID: <CADnq5_MQxu3hy4eBkmVX8Cc0rOVQ4fBnuryKeYEHrBE=pAG03g@mail.gmail.com>
Subject: Re: [PATCH v6 5/9] drm/amdgpu: create context space for usermode queue
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
 Christian Koenig <christian.koenig@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Sep 29, 2023 at 1:50=E2=80=AFPM Shashank Sharma <shashank.sharma@am=
d.com> wrote:
>
>
> On 20/09/2023 17:21, Alex Deucher wrote:
> > On Fri, Sep 8, 2023 at 12:45=E2=80=AFPM Shashank Sharma <shashank.sharm=
a@amd.com> wrote:
> >> The FW expects us to allocate at least one page as context
> >> space to process gang, process, GDS and FW  related work.
> >> This patch creates a joint object for the same, and calculates
> >> GPU space offsets of these spaces.
> >>
> >> V1: Addressed review comments on RFC patch:
> >>      Alex: Make this function IP specific
> >>
> >> V2: Addressed review comments from Christian
> >>      - Allocate only one object for total FW space, and calculate
> >>        offsets for each of these objects.
> >>
> >> V3: Integration with doorbell manager
> >>
> >> V4: Review comments:
> >>      - Remove shadow from FW space list from cover letter (Alex)
> >>      - Alignment of macro (Luben)
> >>
> >> V5: Merged patches 5 and 6 into this single patch
> >>      Addressed review comments:
> >>      - Use lower_32_bits instead of mask (Christian)
> >>      - gfx_v11_0 instead of gfx_v11 in function names (Alex)
> >>      - Shadow and GDS objects are now coming from userspace (Christian=
,
> >>        Alex)
> >>
> >> V6:
> >>      - Add a comment to replace amdgpu_bo_create_kernel() with
> >>        amdgpu_bo_create() during fw_ctx object creation (Christian).
> >>      - Move proc_ctx_gpu_addr, gang_ctx_gpu_addr and fw_ctx_gpu_addr o=
ut
> >>        of generic queue structure and make it gen11 specific (Alex).
> >>
> >> Cc: Alex Deucher <alexander.deucher@amd.com>
> >> Cc: Christian Koenig <christian.koenig@amd.com>
> >> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> >> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 61 +++++++++++++++++=
++
> >>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |  1 +
> >>   2 files changed, 62 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/=
amd/amdgpu/gfx_v11_0.c
> >> index 6760abda08df..8ffb5dee72a9 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> >> @@ -61,6 +61,9 @@
> >>   #define regCGTT_WD_CLK_CTRL_BASE_IDX   1
> >>   #define regRLC_RLCS_BOOTLOAD_STATUS_gc_11_0_1  0x4e7e
> >>   #define regRLC_RLCS_BOOTLOAD_STATUS_gc_11_0_1_BASE_IDX 1
> >> +#define AMDGPU_USERQ_PROC_CTX_SZ   PAGE_SIZE
> >> +#define AMDGPU_USERQ_GANG_CTX_SZ   PAGE_SIZE
> >> +#define AMDGPU_USERQ_FW_CTX_SZ     PAGE_SIZE
> >>
> >>   MODULE_FIRMWARE("amdgpu/gc_11_0_0_pfp.bin");
> >>   MODULE_FIRMWARE("amdgpu/gc_11_0_0_me.bin");
> >> @@ -6424,6 +6427,56 @@ const struct amdgpu_ip_block_version gfx_v11_0_=
ip_block =3D
> >>          .funcs =3D &gfx_v11_0_ip_funcs,
> >>   };
> >>
> >> +static void gfx_v11_0_userq_destroy_ctx_space(struct amdgpu_userq_mgr=
 *uq_mgr,
> >> +                                             struct amdgpu_usermode_q=
ueue *queue)
> >> +{
> >> +       struct amdgpu_userq_obj *ctx =3D &queue->fw_obj;
> >> +
> >> +       amdgpu_bo_free_kernel(&ctx->obj, &ctx->gpu_addr, &ctx->cpu_ptr=
);
> >> +}
> >> +
> >> +static int gfx_v11_0_userq_create_ctx_space(struct amdgpu_userq_mgr *=
uq_mgr,
> >> +                                           struct amdgpu_usermode_que=
ue *queue,
> >> +                                           struct drm_amdgpu_userq_mq=
d_gfx_v11_0 *mqd_user)
> >> +{
> >> +       struct amdgpu_device *adev =3D uq_mgr->adev;
> >> +       struct amdgpu_userq_obj *ctx =3D &queue->fw_obj;
> >> +       struct v11_gfx_mqd *mqd =3D queue->mqd.cpu_ptr;
> >> +       uint64_t fw_ctx_gpu_addr;
> >> +       int r, size;
> >> +
> >> +       /*
> >> +        * The FW expects at least one page space allocated for
> >> +        * process ctx, gang ctx and fw ctx each. Create an object
> >> +        * for the same.
> >> +        */
> >> +       size =3D AMDGPU_USERQ_PROC_CTX_SZ + AMDGPU_USERQ_FW_CTX_SZ +
> >> +              AMDGPU_USERQ_GANG_CTX_SZ;
> >> +       r =3D amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
> >> +                                   AMDGPU_GEM_DOMAIN_GTT,
> >> +                                   &ctx->obj,
> >> +                                   &ctx->gpu_addr,
> >> +                                   &ctx->cpu_ptr);
> >> +       if (r) {
> >> +               DRM_ERROR("Failed to allocate ctx space bo for userque=
ue, err:%d\n", r);
> >> +               return r;
> >> +       }
> >> +
> >> +       fw_ctx_gpu_addr =3D ctx->gpu_addr + AMDGPU_USERQ_PROC_CTX_SZ +
> >> +                         AMDGPU_USERQ_GANG_CTX_SZ;
> >> +       mqd->fw_work_area_base_lo =3D lower_32_bits(fw_ctx_gpu_addr);
> >> +       mqd->fw_work_area_base_lo =3D upper_32_bits(fw_ctx_gpu_addr);
> >> +
> >> +       /* Shadow and GDS objects come directly from userspace */
> >> +       mqd->shadow_base_lo =3D lower_32_bits(mqd_user->shadow_va);
> >> +       mqd->shadow_base_hi =3D upper_32_bits(mqd_user->shadow_va);
> >> +
> >> +       mqd->gds_bkup_base_lo =3D lower_32_bits(mqd_user->gds_va);
> >> +       mqd->gds_bkup_base_hi =3D upper_32_bits(mqd_user->gds_va);
> >> +
> >> +       return 0;
> >> +}
> >> +
> >>   static int gfx_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mg=
r,
> >>                                        struct drm_amdgpu_userq_in *arg=
s_in,
> >>                                        struct amdgpu_usermode_queue *q=
ueue)
> >> @@ -6480,6 +6533,13 @@ static int gfx_v11_0_userq_mqd_create(struct am=
dgpu_userq_mgr *uq_mgr,
> >>                  goto free_mqd;
> >>          }
> >>
> >> +       /* Create BO for FW operations */
> >> +       r =3D gfx_v11_0_userq_create_ctx_space(uq_mgr, queue, &mqd_use=
r);
> >> +       if (r) {
> >> +               DRM_ERROR("Failed to allocate BO for userqueue (%d)", =
r);
> >> +               goto free_mqd;
> >> +       }
> >> +
> >>          return 0;
> >>
> >>   free_mqd:
> >> @@ -6492,6 +6552,7 @@ gfx_v11_0_userq_mqd_destroy(struct amdgpu_userq_=
mgr *uq_mgr, struct amdgpu_userm
> >>   {
> >>          struct amdgpu_userq_obj *mqd =3D &queue->mqd;
> >>
> >> +       gfx_v11_0_userq_destroy_ctx_space(uq_mgr, queue);
> >>          amdgpu_bo_free_kernel(&mqd->obj, &mqd->gpu_addr, &mqd->cpu_pt=
r);
> >>   }
> >>
> >> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/=
gpu/drm/amd/include/amdgpu_userqueue.h
> >> index 240f92796f00..34e20daa06c8 100644
> >> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> >> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> >> @@ -44,6 +44,7 @@ struct amdgpu_usermode_queue {
> >>          struct amdgpu_userq_mgr *userq_mgr;
> >>          struct amdgpu_vm        *vm;
> >>          struct amdgpu_userq_obj mqd;
> >> +       struct amdgpu_userq_obj fw_obj;
> > Since this is gfx 11 specific, I feel like this would be better stored
> > in some gfx 11 structure rather than the generic user queue structure.
> > Maybe a driver private pointer here would make more sense, then each
> > IP can hang whatever structure they want here for IP specific
> > metadata.
>
>
> I was thinking more on this, and to me it seems like it's the size of
> this FW space which is going to be specific to a IP, but some object
> space probably will always be required, as MES will always need some
> space to save its process and gang ctx. So if this is not a big concern
> for you, I would like to keep it here and see how this space requirement
> evolves over the time.

Sure.  We can revisit this later.

Alex

>
> - Shashank
>
> >
> > Alex
> >
> >
> >>   };
> >>
> >>   struct amdgpu_userq_funcs {
> >> --
> >> 2.42.0
> >>
