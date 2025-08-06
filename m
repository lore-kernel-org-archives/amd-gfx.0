Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B23EFC87FD3
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Aug 2025 18:05:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 481FA10E2FC;
	Wed,  6 Aug 2025 18:05:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dlV/oJId";
	dkim-atps=neutral
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F8F610E2FC
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Aug 2025 18:05:54 +0000 (UTC)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-b34b770868dso10907a12.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 06 Aug 2025 11:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754503553; x=1755108353; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lHJF+scpHWabcy+3GRU3PMxJmlxd7RRyyyeaVATCPyE=;
 b=dlV/oJIdppt/uootvBxvAp540KMFn9s2X/+Z8KG7SMSwoThyG8yfdZ951FV3G8aNgX
 oOwPV6n+80BxZtcbvWhMY314ct2TYsu5+vWRiQVzuwxM33j1sk6VPEibfND/HaYZECWw
 mwxUI6Tqw/BtBtfFzKUvL5/8Z46j+tXH/vLmQeY8nkZ5ExEDeZ1aVDkq4Aw+D73hDH19
 U0pk4Dq8fY6hT3JC5RfgnbN/LPtQrIWq5+c0QqTPWntDKnbBi+SszT4sHtsw+V4N20d4
 d8Y/ORWK5dBF/3t7aFOqnJA4Ar3gNs+RngONTAOw26RXgR/KP+zlatUQKrJRr6ftxRNn
 vj3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754503553; x=1755108353;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lHJF+scpHWabcy+3GRU3PMxJmlxd7RRyyyeaVATCPyE=;
 b=EOyI7riKHM1PywLqBX/5XX7h13DFvmAPwsg+m7nRgDoBumBdT91wUJftO6svHm3FmS
 dQoEkS/5OD9bxOUGnPLRKzPXZbFGirFRoaT76muBD3hTNe+BZ6+iyboupMqjDssdBDM7
 2MQUerpwvTAQQDT12sZnZfm0w3aNHnM+RLEsB65hKK6WbuDan+TcUtbECbqun++YhVFM
 nc+NxRzLiuG/vJOQChTTXLoNIoTWBnSRnXfbPqs8dueHpga0MoDpdcj+eSLOHgUW2KUP
 adc/LjsWSbmZp7DW2U9pjGnof+QkiTMOws5/+Ki4IdxFro5YJbV9gn7jll07ufQ60Nab
 +e8A==
X-Gm-Message-State: AOJu0Yw056R/x4P2e+5AUWK1Z1vhyGQ0A4MynsZukEe9rJRwDV3ELDVL
 XQtYcvlax/AqWGK1YG8aN2fwQPVk3nL5j5UHDehK7phwXuVPNGeVARk9l+O8gTMaxFVDm6exi++
 TeHIChSg3llaBTSKkUN4jcVIg7pQQN/U=
X-Gm-Gg: ASbGnctPfqa3hH0oxQXSFniVsTnE070pXfIU3/FABO2V8yoVqCIXJ0KovCbNADiG1R2
 v5plyuUj0z2TxDcRXIzWhcIGQ804CnSCP8uhS/U1GuHowjQ9ipTR+lApZirxHupF06YkuYych4x
 Gpt+tlGLtYbIMLq1Qz1q6pV/ORxzh2AW4DlEMjk6+0vO6NiPaPqGOkhm9igrjJz/aZgc3SXkr7Y
 MK2BWcV6BheYkiX6512qmUxhpXBGA==
X-Google-Smtp-Source: AGHT+IHrBoND25rHtxzv1fJYRj1yIUy0iK8bkmMBoXhDIePmg6JEdNX3+WPGLDPIgTLsUOmoxzjzQPOYVb81XR34R70=
X-Received: by 2002:a17:902:f691:b0:240:4d65:508f with SMTP id
 d9443c01a7336-2429f559670mr24791275ad.6.1754503553443; Wed, 06 Aug 2025
 11:05:53 -0700 (PDT)
MIME-Version: 1.0
References: <20250730142719.7184-1-shaoyun.liu@amd.com>
 <CADnq5_Ma7Ft1_DQ8aD9B_eGE3J1GPRhAx-U1MvVxbw12mrqM0A@mail.gmail.com>
 <CH0PR12MB5372F959293B08C0EB9D25C0F42DA@CH0PR12MB5372.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB5372F959293B08C0EB9D25C0F42DA@CH0PR12MB5372.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 6 Aug 2025 14:05:41 -0400
X-Gm-Features: Ac12FXy_7mEVRfnsy_Rx2l3D8VPONWJZcEjWGgTkz_row6jnyac6Q2FfML22WPw
Message-ID: <CADnq5_PYLEiqb+zzE9a_K9U5ZvUpXfhgkEHzmJ61QnkBZC86BQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amd/amdgpu : Use the MES INV_TLBS API for tlb
 invalidation on gfx12
To: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Aug 6, 2025 at 2:02=E2=80=AFPM Liu, Shaoyun <Shaoyun.Liu@amd.com> w=
rote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex D=
eucher
> Sent: Wednesday, August 6, 2025 1:45 PM
> To: Liu, Shaoyun <Shaoyun.Liu@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH 2/2] drm/amd/amdgpu : Use the MES INV_TLBS API for tl=
b invalidation on gfx12
>
> On Wed, Jul 30, 2025 at 10:33=E2=80=AFAM Shaoyun Liu <shaoyun.liu@amd.com=
> wrote:
> >
> > From MES version 0x81, it provide the new API INV_TLBS that support
> > invalidate tlbs with PASID.
> >
> > Signed-off-by: Shaoyun Liu <shaoyun.liu@amd.com>
> > --->  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  9 +++++++++
> >  drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c  | 15 +++++++++++++++
> > drivers/gpu/drm/amd/amdgpu/mes_v12_0.c  | 24 ++++++++++++++++++++++++
> >  3 files changed, 48 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> > index c0d2c195fe2e..f4c40f1aecd2 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> > @@ -280,6 +280,12 @@ struct mes_reset_queue_input {
> >         bool                               is_kq;
> >  };
> >
> > +struct mes_inv_tlbs_pasid_input {
> > +       uint16_t        pasid;
> > +       uint8_t         hub_id;
> > +       uint8_t         flush_type;
> > +};
> > +
> >  enum mes_misc_opcode {
> >         MES_MISC_OP_WRITE_REG,
> >         MES_MISC_OP_READ_REG,
> > @@ -367,6 +373,9 @@ struct amdgpu_mes_funcs {
> >
> >         int (*reset_hw_queue)(struct amdgpu_mes *mes,
> >                               struct mes_reset_queue_input *input);
> > +
> > +       int (*invalidate_tlbs_pasid)(struct amdgpu_mes *mes,
> > +                             struct mes_inv_tlbs_pasid_input *input);
> >  };
> >
> >  #define amdgpu_mes_kiq_hw_init(adev) (adev)->mes.kiq_hw_init((adev))
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> > b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> > index feb92e107af8..323ec04094ed 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> > @@ -339,6 +339,21 @@ static void gmc_v12_0_flush_gpu_tlb_pasid(struct a=
mdgpu_device *adev,
> >         uint16_t queried;
> >         int vmid, i;
> >
> > +       if (adev->enable_uni_mes && adev->mes.ring[0].sched.ready &&
>
>
> maybe specify the pipe index explicitly?  E.g.,,
> adev->mes.ring[AMDGPU_MES_SCHED_PIPE].sched.ready
> I always forget which index is KIQ and which is SCHED.
>
> [shaoyunl] ok .
>
> > +           (adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >=3D
> > + 0x81) {
> > +
> > +               struct mes_inv_tlbs_pasid_input input =3D {0};
> > +               input.pasid =3D pasid;
> > +               input.flush_type =3D flush_type;
> > +               adev->mes.funcs->invalidate_tlbs_pasid(&adev->mes, &inp=
ut);
> > +               if (all_hub) {
> > +                       /* hub_id =3D 1 means  for mm_hub*/
> > +                       input.hub_id =3D 1;
> > +                       adev->mes.funcs->invalidate_tlbs_pasid(&adev->m=
es, &input);
> > +               }
> > +               return;
> > +       }
> > +
> >         for (vmid =3D 1; vmid < 16; vmid++) {
> >                 bool valid;
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> > b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> > index 6b222630f3fa..2e9191fffaf1 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> > @@ -108,6 +108,7 @@ static const char *mes_v12_0_opcodes[] =3D {
> >         "SET_SE_MODE",
> >         "SET_GANG_SUBMIT",
> >         "SET_HW_RSRC_1",
> > +       "INVALIDATE_TLBS",
> >  };
> >
> >  static const char *mes_v12_0_misc_opcodes[] =3D { @@ -879,6 +880,28 @@
> > static int mes_v12_0_reset_hw_queue(struct amdgpu_mes *mes,
> >                         offsetof(union MESAPI__RESET, api_status));  }
> >
> > +static int mes_v12_0_inv_tlbs_pasid(struct amdgpu_mes *mes,
> > +                                   struct mes_inv_tlbs_pasid_input
> > +*input) {
> > +       union MESAPI__INV_TLBS mes_inv_tlbs;
> > +
> > +       memset(&mes_inv_tlbs, 0, sizeof(mes_inv_tlbs));
> > +
> > +       mes_inv_tlbs.header.type =3D MES_API_TYPE_SCHEDULER;
> > +       mes_inv_tlbs.header.opcode =3D MES_SCH_API_INV_TLBS;
> > +       mes_inv_tlbs.header.dwsize =3D API_FRAME_SIZE_IN_DWORDS;
> > +
> > +       mes_inv_tlbs.invalidate_tlbs.inv_sel =3D 0;
> > +       mes_inv_tlbs.invalidate_tlbs.flush_type =3D input->flush_type;
> > +       mes_inv_tlbs.invalidate_tlbs.inv_sel_id =3D input->pasid;
> > +       mes_inv_tlbs.invalidate_tlbs.hub_id =3D (uint32_t)input->hub_id=
;
> > +
> > +       return mes_v12_0_submit_pkt_and_poll_completion(mes,
> > + AMDGPU_MES_KIQ_PIPE,
>
> Should this be  AMDGPU_MES_KIQ_PIPE or AMDGPU_MES_SCHED_PIPE?  This seems=
 to differ from the check above in gmc_v12_0_flush_gpu_tlb_pasid().
>
> Alex
>
> [Shaoyun.liu] What I want is submit to the  kiq pipe when unified MES is =
ready , the above  check is for MES is ready or not. We would like all none=
 running-list related operation  been submitted to KIQ so it won't create a=
ny unnecessary delay or impact on process schedule decision . It's like ori=
ginal driver usage for KIQ . The  sched pipe (HIQ) will be  used for all us=
er queues.
>

In that case, should we check if both pipes are ready in
gmc_v12_0_flush_gpu_tlb_pasid()?

Alex

>
> > +                       &mes_inv_tlbs, sizeof(mes_inv_tlbs),
> > +                       offsetof(union MESAPI__INV_TLBS, api_status));
> > +
> > +}
> > +
> >  static const struct amdgpu_mes_funcs mes_v12_0_funcs =3D {
> >         .add_hw_queue =3D mes_v12_0_add_hw_queue,
> >         .remove_hw_queue =3D mes_v12_0_remove_hw_queue, @@ -888,6 +911,=
7
> > @@ static const struct amdgpu_mes_funcs mes_v12_0_funcs =3D {
> >         .resume_gang =3D mes_v12_0_resume_gang,
> >         .misc_op =3D mes_v12_0_misc_op,
> >         .reset_hw_queue =3D mes_v12_0_reset_hw_queue,
> > +       .invalidate_tlbs_pasid =3D mes_v12_0_inv_tlbs_pasid,
> >  };
> >
> >  static int mes_v12_0_allocate_ucode_buffer(struct amdgpu_device
> > *adev,
> > --
> > 2.34.1
> >
