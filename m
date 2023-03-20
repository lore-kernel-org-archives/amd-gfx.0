Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52664C7618A
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Mar 2023 16:08:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B26610E03C;
	Mon, 20 Mar 2023 16:08:24 +0000 (UTC)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C69110E03C
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Mar 2023 16:08:23 +0000 (UTC)
Received: by mail-oi1-x234.google.com with SMTP id e4so2201754oiy.10
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Mar 2023 09:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1679328503;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3pvYw4lXdV9LU8zjVldEhYXXvlZwT+zAqqCj8i+AzBo=;
 b=MPcPxBBo5VszsYcXVbTIpJG+YFM3tSLbFvEQH5pvh0yk+tJMKyD+6O35QAvQtVLWjk
 sBl8Y3ehk++JDhXh6K3uFC7h2HLTGtqZrgxcQViNjsqbUFiDeDxOJGx10DFdy8X3yRVc
 qw0A/SC4Dz08QIeiZX5x8CDpV+odT9GMC4fJaIMx5I66RYC0OLoZ1o/xnd5b9MAib1Cq
 Znu6rODDxpnQGBx37jS3r7OJs+h9WAE3ov9SZ3NvFvr2jYJul1JxwMrFhZtUaE5GRAov
 UjLk+7bNf4HKJ+M39V9SPQ0t1RRY1MSGTbl8KmF5HfGNSHN19OKtkEgGUDmiepEngryo
 rvOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679328503;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3pvYw4lXdV9LU8zjVldEhYXXvlZwT+zAqqCj8i+AzBo=;
 b=SOgolDtoybgMm9RmtZhWLhbH56yPwg0ePCuQHgLBD74aJZm2puWkdKVyxA6lJq2OYx
 mHaxzg1Fxh2WuJ0plWzbKm4jl/g63VDbDa03VvN+c9Wl3VtNPbENWsfnuNvUyoQ9ueMm
 L4owqjo5+9AP2yG9z4PvCj94WHIukIGG4PAI/PxHtsbOPgcE/A9jyr/rRW/B4EQsEBW4
 PBo28Rl4PUpUlYci1uc0sN6dlhidp31FUpU1f2WEBaznZeLGDWz9MCdsuwLqTv7T72ZX
 4aWPSuPdJVUK0h5UKo9/GzeJ6RXysk4oc2on3pvsVggQ/F/wdcpSOg+pHe19mcIqsem4
 Rp6A==
X-Gm-Message-State: AO0yUKV8amtihzGAsKRKfJlY0wtGn8yZnHbf8C/+5eut5cUWI0M2ytIo
 sEb6C4mSZFp1o6pCZedHWPz7gVfEbHswR0Xky18=
X-Google-Smtp-Source: AK7set8CdntnApWGph+R/PgMRh3yj8uZEy9OtjFrYtuyVqbtwGWBHe8cmqg7cSv4md1R/IytiFMB1HXuPY6PHgPrGjw=
X-Received: by 2002:a05:6808:20a8:b0:384:692c:56c9 with SMTP id
 s40-20020a05680820a800b00384692c56c9mr147928oiw.3.1679328502855; Mon, 20 Mar
 2023 09:08:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230317171748.682691-1-alexander.deucher@amd.com>
 <20230317171748.682691-5-alexander.deucher@amd.com>
 <e1f5b9a0-556c-7c6e-507a-55833937020c@gmail.com>
In-Reply-To: <e1f5b9a0-556c-7c6e-507a-55833937020c@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 20 Mar 2023 12:08:11 -0400
Message-ID: <CADnq5_MgTN36hNEs=UfPJCwZ+5GvoBQXpTY10v1wUvOLFaO5gg@mail.gmail.com>
Subject: Re: [PATCH 04/10] drm/amdgpu: add gfx11 emit shadow callback
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Mar 20, 2023 at 11:49=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 17.03.23 um 18:17 schrieb Alex Deucher:
> > From: Christian K=C3=B6nig <christian.koenig@amd.com>
> >
> > Add ring callback for gfx to update the CP firmware
> > with the new shadow information before we process the
> > IB.
> >
> > v2: add implementation for new packet (Alex)
> > v3: add current FW version checks (Alex)
> > v4: only initialize shadow on first use
> >      Only set IB_VMID when a valid shadow buffer is present
> >      (Alex)
> >
> > Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 ++
> >   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 46 ++++++++++++++++++++++++=
+
> >   drivers/gpu/drm/amd/amdgpu/nvd.h        |  5 ++-
> >   3 files changed, 52 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_gfx.h
> > index de9e7a00bb15..4ad9e225d6e6 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > @@ -364,6 +364,8 @@ struct amdgpu_gfx {
> >
> >       struct amdgpu_ring              sw_gfx_ring[AMDGPU_MAX_SW_GFX_RIN=
GS];
> >       struct amdgpu_ring_mux          muxer;
> > +
> > +     bool                            cp_gfx_shadow; /* for gfx11 */
> >   };
> >
> >   #define amdgpu_gfx_get_gpu_clock_counter(adev) (adev)->gfx.funcs->get=
_gpu_clock_counter((adev))
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/a=
md/amdgpu/gfx_v11_0.c
> > index 3bf697a80cf2..166a3f640042 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> > @@ -463,6 +463,27 @@ static int gfx_v11_0_init_toc_microcode(struct amd=
gpu_device *adev, const char *
> >       return err;
> >   }
> >
> > +static void gfx_v11_0_check_fw_cp_gfx_shadow(struct amdgpu_device *ade=
v)
> > +{
> > +     switch (adev->ip_versions[GC_HWIP][0]) {
> > +     case IP_VERSION(11, 0, 0):
> > +     case IP_VERSION(11, 0, 2):
> > +     case IP_VERSION(11, 0, 3):
> > +             /* XXX fix me! */
> > +             if ((adev->gfx.me_fw_version >=3D 1498) &&
> > +                 (adev->gfx.me_feature_version >=3D 29) &&
> > +                 (adev->gfx.pfp_fw_version >=3D 1541) &&
> > +                 (adev->gfx.pfp_feature_version >=3D 29) &&
> > +                 (adev->gfx.mec_fw_version >=3D 507) &&
> > +                 (adev->gfx.mec_feature_version >=3D 29))
> > +                     adev->gfx.cp_gfx_shadow =3D true;
> > +             break;
> > +     default:
> > +             adev->gfx.cp_gfx_shadow =3D false;
> > +             break;
> > +     }
> > +}
> > +
> >   static int gfx_v11_0_init_microcode(struct amdgpu_device *adev)
> >   {
> >       char fw_name[40];
> > @@ -539,6 +560,7 @@ static int gfx_v11_0_init_microcode(struct amdgpu_d=
evice *adev)
> >       /* only one MEC for gfx 11.0.0. */
> >       adev->gfx.mec2_fw =3D NULL;
> >
> > +     gfx_v11_0_check_fw_cp_gfx_shadow(adev);
> >   out:
> >       if (err) {
> >               amdgpu_ucode_release(&adev->gfx.pfp_fw);
> > @@ -5563,6 +5585,28 @@ static void gfx_v11_0_ring_emit_cntxcntl(struct =
amdgpu_ring *ring,
> >       amdgpu_ring_write(ring, 0);
> >   }
> >
> > +static void gfx_v11_0_ring_emit_gfx_shadow(struct amdgpu_ring *ring,
> > +                                        struct amdgpu_job *job)
>
> Better give the values to use here instead of the job structure.

Will fix it up.  Thanks!

Alex

>
> Regards,
> Christian.
>
> > +{
> > +     unsigned vmid =3D AMDGPU_JOB_GET_VMID(job);
> > +     struct amdgpu_device *adev =3D ring->adev;
> > +
> > +     if (!adev->gfx.cp_gfx_shadow)
> > +             return;
> > +
> > +     amdgpu_ring_write(ring, PACKET3(PACKET3_SET_Q_PREEMPTION_MODE, 7)=
);
> > +     amdgpu_ring_write(ring, lower_32_bits(job->shadow_va));
> > +     amdgpu_ring_write(ring, upper_32_bits(job->shadow_va));
> > +     amdgpu_ring_write(ring, lower_32_bits(job->gds_va));
> > +     amdgpu_ring_write(ring, upper_32_bits(job->gds_va));
> > +     amdgpu_ring_write(ring, lower_32_bits(job->csa_va));
> > +     amdgpu_ring_write(ring, upper_32_bits(job->csa_va));
> > +     amdgpu_ring_write(ring, job->shadow_va ?
> > +                       PACKET3_SET_Q_PREEMPTION_MODE_IB_VMID(vmid) : 0=
);
> > +     amdgpu_ring_write(ring, job->init_shadow ?
> > +                       PACKET3_SET_Q_PREEMPTION_MODE_INIT_SHADOW_MEM :=
 0);
> > +}
> > +
> >   static unsigned gfx_v11_0_ring_emit_init_cond_exec(struct amdgpu_ring=
 *ring)
> >   {
> >       unsigned ret;
> > @@ -6183,6 +6227,7 @@ static const struct amdgpu_ring_funcs gfx_v11_0_r=
ing_funcs_gfx =3D {
> >       .set_wptr =3D gfx_v11_0_ring_set_wptr_gfx,
> >       .emit_frame_size =3D /* totally 242 maximum if 16 IBs */
> >               5 + /* COND_EXEC */
> > +             9 + /* SET_Q_PREEMPTION_MODE */
> >               7 + /* PIPELINE_SYNC */
> >               SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
> >               SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
> > @@ -6209,6 +6254,7 @@ static const struct amdgpu_ring_funcs gfx_v11_0_r=
ing_funcs_gfx =3D {
> >       .insert_nop =3D amdgpu_ring_insert_nop,
> >       .pad_ib =3D amdgpu_ring_generic_pad_ib,
> >       .emit_cntxcntl =3D gfx_v11_0_ring_emit_cntxcntl,
> > +     .emit_gfx_shadow =3D gfx_v11_0_ring_emit_gfx_shadow,
> >       .init_cond_exec =3D gfx_v11_0_ring_emit_init_cond_exec,
> >       .patch_cond_exec =3D gfx_v11_0_ring_emit_patch_cond_exec,
> >       .preempt_ib =3D gfx_v11_0_ring_preempt_ib,
> > diff --git a/drivers/gpu/drm/amd/amdgpu/nvd.h b/drivers/gpu/drm/amd/amd=
gpu/nvd.h
> > index fd6b58243b03..631dafb92299 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/nvd.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/nvd.h
> > @@ -462,6 +462,9 @@
> >   #              define PACKET3_QUERY_STATUS_ENG_SEL(x)          ((x) <=
< 25)
> >   #define     PACKET3_RUN_LIST                                0xA5
> >   #define     PACKET3_MAP_PROCESS_VM                          0xA6
> > -
> > +/* GFX11 */
> > +#define      PACKET3_SET_Q_PREEMPTION_MODE                   0xF0
> > +#              define PACKET3_SET_Q_PREEMPTION_MODE_IB_VMID(x)  ((x) <=
< 0)
> > +#              define PACKET3_SET_Q_PREEMPTION_MODE_INIT_SHADOW_MEM   =
 (1 << 0)
> >
> >   #endif
>
