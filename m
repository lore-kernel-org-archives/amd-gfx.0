Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D238CC87FD3
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Aug 2025 17:44:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F28510E2FA;
	Wed,  6 Aug 2025 17:44:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NyKA6rOJ";
	dkim-atps=neutral
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A01010E2FA
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Aug 2025 17:44:53 +0000 (UTC)
Received: by mail-pg1-f179.google.com with SMTP id
 41be03b00d2f7-b34b770868dso8266a12.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 06 Aug 2025 10:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754502293; x=1755107093; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1GXJVAWxaiRvwmxNrxvA4Az98f4zDPY/jmG8mqB+Z/8=;
 b=NyKA6rOJlfGbPn5ncaiJsreTnAYNk1D5BXbX9XZtI1lbw+0cVz0K4UWL/FyWnY8+dY
 CyBCRPzodwLg9xtBn6v8kAB8g2KY1hzf8YOKkyLtvq2tTefOCv3j/EDFo9iIfBM8cZkI
 qvu5nwk9mzuJSdP/5bE44wbbT8lf2WO6alI0wS/s2ybIji1vqopsbQN4OQ6cq3f1m/25
 zBaOmfqfroPfYpRwIZyaD4JyvMRkkT997rd7QeHviCsSC8QsFdQsG+i7s4Xsoc0Pemoy
 bY+KsDfxxnhZDaa6z07gnjePtTf4obpa1OwtWauEeEF41mSD32jmGe92Ka3z9aAX2iSP
 miGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754502293; x=1755107093;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1GXJVAWxaiRvwmxNrxvA4Az98f4zDPY/jmG8mqB+Z/8=;
 b=gugGP3cMPWIBhVDeKGt8U8v8zsVk2KymwXMFk0A5Q5kNVQztl91qk4VtB6HzcKlKCX
 fOqrxw4yEu/sFWx3nxWWRhasLYm9n7Po5sznsRrONrL1WXphnDndQ/tO1gQKB55ET9mI
 1woyBADZay8XFY+AA4v2lCSJOSBnqZMTSJwfoXmCA7BqR3QrdQiKYJK+O/+XRuT8VXbV
 9WU2U1IPTK12IQ+DMbyEZpVwXQaSr9wE/1p358o0F3/kUmUKY1W4wSQm8Lo+wyZPItKn
 mev8gbKMeYIfo7dpfRJb0sM9e40ZUiqmTli09cO/pwx7/kvu14zwXWo7MtdVoTdwgQwh
 V8Tw==
X-Gm-Message-State: AOJu0YxG8EHmS52OMTqgsRj6w0IW0dVHYBW9bp7NkxzWpS1ZFviLOT47
 fRgduKhQGPSItGQe/f/YIZO2DVcnPUtnqW2fCRHYgOY6sVU7HLJeBWdd+ZoDt4FI42zDoS1fv6x
 Ni30jJIx68OrRHi2BqMonRyz0/6pC+yY=
X-Gm-Gg: ASbGncvOT+59AXX30r0lhJPfD8ch1EH3Ilzqf9DFURJJuIg5X+V8CFpUpTIAsuPyPXr
 G+43SFYs7B1zOj3BiRz0ybvxpxwf8ILAM2te1D4wJM8uAHNOAv6QVfmYMo6r2bEVTtsRpPesV2a
 xiH5xmOYRBAX7tGjsdFc/KhhuW+CZGx1AbbO+P8j15Xzu39YtAVokigAHUh5+/m33HfzPR7aI9q
 zCUNHHW
X-Google-Smtp-Source: AGHT+IEVzTXshRCWRla6BClfrMnp+HwSmQhsA/DOZTt/kxbQ22SxYBKkMavQxIhwP9NT2my248t9xgkKL7ZC5fMotnk=
X-Received: by 2002:a17:902:d484:b0:240:8fd6:f798 with SMTP id
 d9443c01a7336-2429f44ffb1mr29233145ad.4.1754502292750; Wed, 06 Aug 2025
 10:44:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250730142719.7184-1-shaoyun.liu@amd.com>
In-Reply-To: <20250730142719.7184-1-shaoyun.liu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 6 Aug 2025 13:44:40 -0400
X-Gm-Features: Ac12FXx5QEro2odvNs-OQfrk_VeflJpH6aqGSynVRRVWbiaV4Lp6Uk-oug4Pg8A
Message-ID: <CADnq5_Ma7Ft1_DQ8aD9B_eGE3J1GPRhAx-U1MvVxbw12mrqM0A@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amd/amdgpu : Use the MES INV_TLBS API for tlb
 invalidation on gfx12
To: Shaoyun Liu <shaoyun.liu@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

On Wed, Jul 30, 2025 at 10:33=E2=80=AFAM Shaoyun Liu <shaoyun.liu@amd.com> =
wrote:
>
> From MES version 0x81, it provide the new API INV_TLBS that support
> invalidate tlbs with PASID.
>
> Signed-off-by: Shaoyun Liu <shaoyun.liu@amd.com>
> --->  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  9 +++++++++
>  drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c  | 15 +++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/mes_v12_0.c  | 24 ++++++++++++++++++++++++
>  3 files changed, 48 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mes.h
> index c0d2c195fe2e..f4c40f1aecd2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -280,6 +280,12 @@ struct mes_reset_queue_input {
>         bool                               is_kq;
>  };
>
> +struct mes_inv_tlbs_pasid_input {
> +       uint16_t        pasid;
> +       uint8_t         hub_id;
> +       uint8_t         flush_type;
> +};
> +
>  enum mes_misc_opcode {
>         MES_MISC_OP_WRITE_REG,
>         MES_MISC_OP_READ_REG,
> @@ -367,6 +373,9 @@ struct amdgpu_mes_funcs {
>
>         int (*reset_hw_queue)(struct amdgpu_mes *mes,
>                               struct mes_reset_queue_input *input);
> +
> +       int (*invalidate_tlbs_pasid)(struct amdgpu_mes *mes,
> +                             struct mes_inv_tlbs_pasid_input *input);
>  };
>
>  #define amdgpu_mes_kiq_hw_init(adev) (adev)->mes.kiq_hw_init((adev))
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/gmc_v12_0.c
> index feb92e107af8..323ec04094ed 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> @@ -339,6 +339,21 @@ static void gmc_v12_0_flush_gpu_tlb_pasid(struct amd=
gpu_device *adev,
>         uint16_t queried;
>         int vmid, i;
>
> +       if (adev->enable_uni_mes && adev->mes.ring[0].sched.ready &&


maybe specify the pipe index explicitly?  E.g.,,
adev->mes.ring[AMDGPU_MES_SCHED_PIPE].sched.ready
I always forget which index is KIQ and which is SCHED.


> +           (adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >=3D 0x81=
) {
> +
> +               struct mes_inv_tlbs_pasid_input input =3D {0};
> +               input.pasid =3D pasid;
> +               input.flush_type =3D flush_type;
> +               adev->mes.funcs->invalidate_tlbs_pasid(&adev->mes, &input=
);
> +               if (all_hub) {
> +                       /* hub_id =3D 1 means  for mm_hub*/
> +                       input.hub_id =3D 1;
> +                       adev->mes.funcs->invalidate_tlbs_pasid(&adev->mes=
, &input);
> +               }
> +               return;
> +       }
> +
>         for (vmid =3D 1; vmid < 16; vmid++) {
>                 bool valid;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v12_0.c
> index 6b222630f3fa..2e9191fffaf1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> @@ -108,6 +108,7 @@ static const char *mes_v12_0_opcodes[] =3D {
>         "SET_SE_MODE",
>         "SET_GANG_SUBMIT",
>         "SET_HW_RSRC_1",
> +       "INVALIDATE_TLBS",
>  };
>
>  static const char *mes_v12_0_misc_opcodes[] =3D {
> @@ -879,6 +880,28 @@ static int mes_v12_0_reset_hw_queue(struct amdgpu_me=
s *mes,
>                         offsetof(union MESAPI__RESET, api_status));
>  }
>
> +static int mes_v12_0_inv_tlbs_pasid(struct amdgpu_mes *mes,
> +                                   struct mes_inv_tlbs_pasid_input *inpu=
t)
> +{
> +       union MESAPI__INV_TLBS mes_inv_tlbs;
> +
> +       memset(&mes_inv_tlbs, 0, sizeof(mes_inv_tlbs));
> +
> +       mes_inv_tlbs.header.type =3D MES_API_TYPE_SCHEDULER;
> +       mes_inv_tlbs.header.opcode =3D MES_SCH_API_INV_TLBS;
> +       mes_inv_tlbs.header.dwsize =3D API_FRAME_SIZE_IN_DWORDS;
> +
> +       mes_inv_tlbs.invalidate_tlbs.inv_sel =3D 0;
> +       mes_inv_tlbs.invalidate_tlbs.flush_type =3D input->flush_type;
> +       mes_inv_tlbs.invalidate_tlbs.inv_sel_id =3D input->pasid;
> +       mes_inv_tlbs.invalidate_tlbs.hub_id =3D (uint32_t)input->hub_id;
> +
> +       return mes_v12_0_submit_pkt_and_poll_completion(mes, AMDGPU_MES_K=
IQ_PIPE,

Should this be  AMDGPU_MES_KIQ_PIPE or AMDGPU_MES_SCHED_PIPE?  This
seems to differ from the check above in
gmc_v12_0_flush_gpu_tlb_pasid().

Alex

> +                       &mes_inv_tlbs, sizeof(mes_inv_tlbs),
> +                       offsetof(union MESAPI__INV_TLBS, api_status));
> +
> +}
> +
>  static const struct amdgpu_mes_funcs mes_v12_0_funcs =3D {
>         .add_hw_queue =3D mes_v12_0_add_hw_queue,
>         .remove_hw_queue =3D mes_v12_0_remove_hw_queue,
> @@ -888,6 +911,7 @@ static const struct amdgpu_mes_funcs mes_v12_0_funcs =
=3D {
>         .resume_gang =3D mes_v12_0_resume_gang,
>         .misc_op =3D mes_v12_0_misc_op,
>         .reset_hw_queue =3D mes_v12_0_reset_hw_queue,
> +       .invalidate_tlbs_pasid =3D mes_v12_0_inv_tlbs_pasid,
>  };
>
>  static int mes_v12_0_allocate_ucode_buffer(struct amdgpu_device *adev,
> --
> 2.34.1
>
