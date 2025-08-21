Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E053CA0EF8
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Aug 2025 12:48:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CC8F10E978;
	Thu, 21 Aug 2025 12:48:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eSyEk4N8";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 367AE10E978
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Aug 2025 12:48:27 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-244580692f3so1517475ad.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Aug 2025 05:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755780507; x=1756385307; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YuMDbtvnhLjPQCnvtSysb8DWbU/5bgqDYXo/HaXCIAs=;
 b=eSyEk4N8/3MqMqBrTCyLrF4mS9n4x8eQARS7PchYYx5EPAk93VxQUGkZey6mKtglTF
 7sAw/wSR/X6MWE43DScKJVfHvKM4Y7QEhZGo/R5IzzQo6Yuw8OUakp5eC9f0ojzYLoaJ
 BKXG1FnjMJOZXQq0GdH8lK1ubghUXCycLOBKa7mk40jw6N7NdGSHBOOTpx6VawHgt5TP
 x2jdABNxTNX7+iOt/mcEzzBH9AmgGIRI6uZpbRZ/DPJ9DXw0CIr+F/CH9/XijRQ2lXax
 JNtjBEkiWPJ9C6lHEjJ5MAC9mVRxeASO3YP3u1iWhgul10dfFycFTXJEobL1+F/lzQSI
 gnjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755780507; x=1756385307;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YuMDbtvnhLjPQCnvtSysb8DWbU/5bgqDYXo/HaXCIAs=;
 b=Mrnbk7jQdzkMguZbjLDVOk7MG25b0Iq34ixyeLXE7dipHe5eR+XrzIRHcl35gg1l2k
 IKmPhfbl5aST+Z9BV3+b8fcyd9P+qUBDjnVYiFqhc5Sr2ULLnEJZ6Ki5F1pHDObWBT1F
 j4JyI/8d70aSebhlSDCZvKK/7kkmWIDjVYdj5qX4MfJuBgon0fK+Zzy/Z3v/k0EI4Awz
 TTQLXFDtpim/3IQdcfhG4dhrM031VdXdF2Bw9F8lUKkd1Kyir050fo0R9xHNt7ihQKX1
 5Ks2Yz20X7DYhvVJC1ap9/pKVPQdrmU6qbbndyrHkhR9mF1sLacEBVWoAF+Oav9lebD2
 hOJg==
X-Gm-Message-State: AOJu0Yw3Pm5Qg4pObvJ8I5+uVZ/WpZcnPCKtOuPZa1UKx4xkmVr6OC+X
 CDlWXBgOgvqZhrUxjGPF0tfLoUXukNEz7qNZIMfrNSjOv2JMQ5zxXMhRtLHnb1JBP9GBThozMvd
 FEkWiZdpISFv2uwbGat7E0Tl7U7s1i3h2nA==
X-Gm-Gg: ASbGncsAo+8GocvrAI0kolwP+/HDtHaHrDcMkeYq5AAcHVyLLm0hMscl/KIEzEPhwPs
 YEsomb9vBqkkqwWZpxfRKat+/Udb/SOqlnvr4jNjscKqyEEO6Tn9nQMyMYxFQeE6Y1t+9csH0Ce
 0yUHxo1vITfN9BH6g/6f+gtFkbQmm8i7HdswRUiFmWadUVo9nR5ZgsNkenBT4/dkWO/w2THZ2Gf
 DOrfZe5exSvX+htAQ==
X-Google-Smtp-Source: AGHT+IEBYx6vwx+ziqflQFLbZ8fWRDOqox2jLKj1j9c/FzZh5gFSZ44AL6k4M1JHpi4KEZ+SodcLzcuLc8MaZ67ELTE=
X-Received: by 2002:a17:902:e74d:b0:240:52d7:e8a4 with SMTP id
 d9443c01a7336-245ff8a6df5mr16955685ad.7.1755780506591; Thu, 21 Aug 2025
 05:48:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250820184725.432071-1-shaoyun.liu@amd.com>
 <CADnq5_Mysyg77K9rGx2Himz+oixP1oUniR22CHa7-NmrEksM2g@mail.gmail.com>
 <CH0PR12MB53729FD811A04A7EC15EB132F432A@CH0PR12MB5372.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB53729FD811A04A7EC15EB132F432A@CH0PR12MB5372.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 21 Aug 2025 08:48:15 -0400
X-Gm-Features: Ac12FXwS5trr2C1qF-L94ooA5sfVdjyMR2719LhtGzo7GEF-0FceNdhaf6Xiw9g
Message-ID: <CADnq5_NryXOARRojuEhDOARDMJCdkSa=Wvry=w=or+TcZbg_8Q@mail.gmail.com>
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

On Wed, Aug 20, 2025 at 10:27=E2=80=AFPM Liu, Shaoyun <Shaoyun.Liu@amd.com>=
 wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> ou are right , the define seems different .  Originally I think we only h=
ave one gchub for the device and two  mmhub from 1 to 2 . so it seems  each=
 xcc will have one gchub which make sense to me . but for mmhub0(0-3) and  =
mmhub1(0-1)
> I'm confused of how they are mapped to hw side . MES only deal with one  =
mmhub for normal gfx12 , and two mmhub for gfx12_1 .

Some of the MI parts have multiple GC and MM hubs so we abstract them
generically the driver and then map then however we need to when
accessing the actual hw specific bits.

Alex

>
> Regards
> Shaoyun.liu
>
>
> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Wednesday, August 20, 2025 3:57 PM
> To: Liu, Shaoyun <Shaoyun.Liu@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH 2/2] drm/amd/amdgpu : Use the MES INV_TLBS API for tl=
b invalidation on gfx12
>
> On Wed, Aug 20, 2025 at 2:47=E2=80=AFPM Shaoyun Liu <shaoyun.liu@amd.com>=
 wrote:
> >
> > From MES version 0x81, it provide the new API INV_TLBS that support
> > invalidate tlbs with PASID.
> >
> > Signed-off-by: Shaoyun Liu <shaoyun.liu@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 16 ++++++++++++++++
> > drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c  | 22 ++++++++++++++++++++++
> > drivers/gpu/drm/amd/amdgpu/mes_v12_0.c  | 25 +++++++++++++++++++++++++
> >  3 files changed, 63 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> > index c0d2c195fe2e..1b6e7b4fde36 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> > @@ -280,6 +280,19 @@ struct mes_reset_queue_input {
> >         bool                               is_kq;
> >  };
> >
> > +enum amdgpu_mes_hub_id {
> > +       AMDGPU_MES_GC_HUB =3D 0,
> > +       AMDGPU_MES_MM_HUB0 =3D 1,
> > +       AMDGPU_MES_MM_HUB1 =3D 2,
> > +};
> > +
> > +struct mes_inv_tlbs_pasid_input {
> > +       uint32_t        xcc_id;
> > +       uint16_t        pasid;
> > +       uint8_t         hub_id;
> > +       uint8_t         flush_type;
> > +};
> > +
> >  enum mes_misc_opcode {
> >         MES_MISC_OP_WRITE_REG,
> >         MES_MISC_OP_READ_REG,
> > @@ -367,6 +380,9 @@ struct amdgpu_mes_funcs {
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
> > index feb92e107af8..ef58a849d67d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> > @@ -339,6 +339,28 @@ static void gmc_v12_0_flush_gpu_tlb_pasid(struct a=
mdgpu_device *adev,
> >         uint16_t queried;
> >         int vmid, i;
> >
> > +       if (adev->enable_uni_mes && adev->mes.ring[AMDGPU_MES_SCHED_PIP=
E].sched.ready &&
> > +           (adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >=3D
> > + 0x81) {
> > +
> > +               struct mes_inv_tlbs_pasid_input input =3D {0};
> > +               input.pasid =3D pasid;
> > +               input.flush_type =3D flush_type;
> > +               if (all_hub) {
> > +                       for_each_set_bit(i, adev->vmhubs_mask,
> > +                                        AMDGPU_MAX_VMHUBS) {
> > +                               /*
> > +                                * For gfx12, the index i from vmhubs_m=
ask matchs AMDGPU_MES_HUB_ID,
> > +                                * Need to convert them if they are not=
 match in future asic
> > +                                */
>
> Are you sure about this?  From above:
>
> > +       AMDGPU_MES_GC_HUB =3D 0,
> > +       AMDGPU_MES_MM_HUB0 =3D 1,
> > +       AMDGPU_MES_MM_HUB1 =3D 2,
>
> And then in amdgpu_vm.h:
>
> /*
>  * max number of VMHUB
>  * layout: max 8 GFXHUB + 4 MMHUB0 + 1 MMHUB1  */
> #define AMDGPU_MAX_VMHUBS                       13
> #define AMDGPU_GFXHUB_START                     0
> #define AMDGPU_MMHUB0_START                     8
> #define AMDGPU_MMHUB1_START                     12
> #define AMDGPU_GFXHUB(x)                        (AMDGPU_GFXHUB_START + (x=
))
> #define AMDGPU_MMHUB0(x)                        (AMDGPU_MMHUB0_START + (x=
))
> #define AMDGPU_MMHUB1(x)                        (AMDGPU_MMHUB1_START + (x=
))
>
> Alex
>
> > +                               input.hub_id =3D i;
> > +                               adev->mes.funcs->invalidate_tlbs_pasid(=
&adev->mes, &input);
> > +                       }
> > +               } else {
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
> > index 6b222630f3fa..bcaaccf28765 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> > @@ -108,6 +108,7 @@ static const char *mes_v12_0_opcodes[] =3D {
> >         "SET_SE_MODE",
> >         "SET_GANG_SUBMIT",
> >         "SET_HW_RSRC_1",
> > +       "INVALIDATE_TLBS",
> >  };
> >
> >  static const char *mes_v12_0_misc_opcodes[] =3D { @@ -879,6 +880,29 @@
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
> > +       /*The AMDGPU_MES_HUB_ID from input matchs mes expection on gfx1=
2*/
> > +       mes_inv_tlbs.invalidate_tlbs.hub_id =3D (uint32_t)input->hub_id=
;
> > +
> > +       return mes_v12_0_submit_pkt_and_poll_completion(mes, AMDGPU_MES=
_KIQ_PIPE,
> > +                       &mes_inv_tlbs, sizeof(mes_inv_tlbs),
> > +                       offsetof(union MESAPI__INV_TLBS, api_status));
> > +
> > +}
> > +
> >  static const struct amdgpu_mes_funcs mes_v12_0_funcs =3D {
> >         .add_hw_queue =3D mes_v12_0_add_hw_queue,
> >         .remove_hw_queue =3D mes_v12_0_remove_hw_queue, @@ -888,6 +912,=
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
