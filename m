Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5F94C54E41
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Feb 2024 15:38:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3335B10E4B1;
	Thu, 29 Feb 2024 15:38:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Kn88UUnq";
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93DA410E4B1
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Feb 2024 15:38:48 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-2997cb49711so523703a91.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Feb 2024 07:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709221128; x=1709825928; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JO4UjiYgg73kiOA06HsjlDA4OZJ/9f1/ECjxpc6uWsk=;
 b=Kn88UUnq9nxmJZzIP3wZFlXdG30ruUCAOnL7HFRB09V3MRa/XARtHY14H7zR/MBCiV
 4zLNL3IDwN9IhrEAHhzqUwiW96qCVfgnZUPrKfYObnpDPHTmgczIDKJkuE3qSD4dnlcX
 BQy50UaWPoIImgLJ9zXRCeyxJrGX2SmVpgYgBYVUqSMhzKkcrbVEI+TlZyFo0d2A3XC4
 cE1frdBqmRw8iYNmmli4JkNosj+0BQRGbvsL5zLTsAIVT8U9I0bfqRWlXlLRPzB58gPq
 IFP+Gmw/dI101FwnVMFUsPW156xTVpKiFP0w9nAEdvLIcn7HKG95aP2ufjG7NwPqxmWy
 M3vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709221128; x=1709825928;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JO4UjiYgg73kiOA06HsjlDA4OZJ/9f1/ECjxpc6uWsk=;
 b=NRwbbUC/oBngUmMIC1FFlM2YftbC4GvY5OFnvFgalkBlOB/2KvfjyP5nXNyQMRaax2
 HmApEkke+KXbLNiKeznnuXPZkQp+z9RYDOFQxlLZltA5Ft9zHUKVJV5k5sUiFCSzfwcD
 54nK8Zl1Mx/LnuVMyZqtspIlLtQmjfuzMsxqb+7lZiIcF48qXcZNlsatmmwpgcVF1lAv
 34acV+gxhsBMZ5YK+KrZT3p9IicQ+e7z6jbsobMHArH922bbAjq7VpPxy1HAjxcuXfoU
 kRbVUQAxb/2UX3RWK9fwEtPLeXUtZ2Dzhkh8CfMz2Z6faQj45A5oTWF3XX7Xul0YjEPP
 prvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGq390XTzbXhKsqM4JXdeyr0D/UcsOLd55VlkmH42Cp9JdVr5DlZFHYdhMkcBCOGdo5WgEqq9ivYN/NBPAI3QFcrt8Qb8pOpcEqz4ndg==
X-Gm-Message-State: AOJu0YwY60IPd2GoEPttwLcYs7pG3yL6prS+FM22d/+GVRSHqnx7DFb9
 4QEBreOidZBFBkkVRz02cdBFwrvXGHptZeJIeugqq4wuNvog8c6z11kSCCGXVB8p6gx+vClFKKl
 MtUwmnTgluMNw7MigiF0915OrO9ud7+Ax
X-Google-Smtp-Source: AGHT+IGAVA1Q2h1gKoftoBscmtJZlYAMIuhTkiSD0Ct8oJj+OtNTVjfXpZLHNnWxrI4p9X33oWrMmn/4Xv0JjkOea0A=
X-Received: by 2002:a17:90a:bf0c:b0:29b:1c89:3770 with SMTP id
 c12-20020a17090abf0c00b0029b1c893770mr385945pjs.4.1709221127777; Thu, 29 Feb
 2024 07:38:47 -0800 (PST)
MIME-Version: 1.0
References: <20240229144925.97165-1-christian.koenig@amd.com>
 <20240229144925.97165-2-christian.koenig@amd.com>
In-Reply-To: <20240229144925.97165-2-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 29 Feb 2024 10:38:35 -0500
Message-ID: <CADnq5_M_myT1R-WU+hiVNUaH4wMfFY28iA7Mem5FCyqn-Pdckw@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: workaround to avoid SET_Q_MODE packets
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org
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

On Thu, Feb 29, 2024 at 9:58=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> It turned out that executing the SET_Q_MODE packet on every submission
> creates to much overhead.
>
> Implement a workaround which allows skipping the SET_Q_MODE packet if
> subsequent submissions all use the same parameters.
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |   3 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   | 104 +++++++++++++++++++----
>  2 files changed, 92 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_ring.h
> index 756330767909..582053f1cd56 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -285,6 +285,9 @@ struct amdgpu_ring {
>         unsigned                cond_exe_offs;
>         u64                     cond_exe_gpu_addr;
>         volatile u32            *cond_exe_cpu_addr;
> +       unsigned int            set_q_mode_offs;
> +       volatile u32            *set_q_mode_ptr;
> +       u64                     set_q_mode_token;
>         unsigned                vm_hub;
>         unsigned                vm_inv_eng;
>         struct dma_fence        *vmid_wait;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index 2ccbdee570cf..6e6b6eff48e2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -5461,6 +5461,11 @@ static void gfx_v11_0_ring_emit_vm_flush(struct am=
dgpu_ring *ring,
>                 amdgpu_ring_write(ring, PACKET3(PACKET3_PFP_SYNC_ME, 0));
>                 amdgpu_ring_write(ring, 0x0);
>         }
> +
> +       /* Make sure that we can't skip the SET_Q_MODE packets when the V=
M
> +        * changed in any way.
> +        */
> +       ring->set_q_mode_ptr =3D NULL;
>  }
>
>  static void gfx_v11_0_ring_emit_fence_kiq(struct amdgpu_ring *ring, u64 =
addr,
> @@ -5510,16 +5515,81 @@ static void gfx_v11_0_ring_emit_cntxcntl(struct a=
mdgpu_ring *ring,
>         amdgpu_ring_write(ring, 0);
>  }
>
> +static unsigned gfx_v11_0_ring_emit_init_cond_exec(struct amdgpu_ring *r=
ing,
> +                                                  uint64_t addr)
> +{
> +       unsigned ret;
> +
> +       amdgpu_ring_write(ring, PACKET3(PACKET3_COND_EXEC, 3));
> +       amdgpu_ring_write(ring, lower_32_bits(addr));
> +       amdgpu_ring_write(ring, upper_32_bits(addr));
> +       /* discard following DWs if *cond_exec_gpu_addr=3D=3D0 */
> +       amdgpu_ring_write(ring, 0);
> +       ret =3D ring->wptr & ring->buf_mask;
> +       /* patch dummy value later */
> +       amdgpu_ring_write(ring, 0);
> +
> +       return ret;
> +}
> +
>  static void gfx_v11_0_ring_emit_gfx_shadow(struct amdgpu_ring *ring,
>                                            u64 shadow_va, u64 csa_va,
>                                            u64 gds_va, bool init_shadow,
>                                            int vmid)
>  {
>         struct amdgpu_device *adev =3D ring->adev;
> +       unsigned int offs, end;
>
>         if (!adev->gfx.cp_gfx_shadow)
>                 return;
>
> +       /*
> +        * The logic here isn't easy to understand because we need to kee=
p state
> +        * accross multiple executions of the function as well as between=
 the
> +        * CPU and GPU. The general idea is that the newly written GPU co=
mmand
> +        * has a condition on the previous one and only executed if reall=
y
> +        * necessary.
> +        */
> +
> +       /*
> +        * The dw in the NOP controls if the next SET_Q_MODE packet shoul=
d be
> +        * executed or not. Reserve 64bits just to be on the save side.
> +        */
> +       amdgpu_ring_write(ring, PACKET3(PACKET3_NOP, 1));
> +       offs =3D ring->wptr & ring->buf_mask;
> +
> +       /*
> +        * We start with skipping the prefix SET_Q_MODE and always execut=
ing
> +        * the postfix SET_Q_MODE packet. This is changed below with a
> +        * WRITE_DATA command when the postfix executed.
> +        */
> +       amdgpu_ring_write(ring, shadow_va ? 1 : 0);
> +       amdgpu_ring_write(ring, 0);
> +
> +       if (ring->set_q_mode_offs) {
> +               uint64_t addr;
> +
> +               addr =3D amdgpu_bo_gpu_offset(ring->ring_obj);
> +               addr +=3D ring->set_q_mode_offs << 2;
> +               end =3D gfx_v11_0_ring_emit_init_cond_exec(ring, addr);
> +       }
> +
> +       /*
> +        * When the postfix SET_Q_MODE packet executes we need to make su=
re that the
> +        * next prefix SET_Q_MODE packet executes as well.
> +        */
> +       if (!shadow_va) {
> +               uint64_t addr;
> +
> +               addr =3D amdgpu_bo_gpu_offset(ring->ring_obj);
> +               addr +=3D offs << 2;
> +               amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
> +               amdgpu_ring_write(ring, WRITE_DATA_DST_SEL(5) | WR_CONFIR=
M);
> +               amdgpu_ring_write(ring, lower_32_bits(addr));
> +               amdgpu_ring_write(ring, upper_32_bits(addr));
> +               amdgpu_ring_write(ring, 0x1);
> +       }
> +
>         amdgpu_ring_write(ring, PACKET3(PACKET3_SET_Q_PREEMPTION_MODE, 7)=
);
>         amdgpu_ring_write(ring, lower_32_bits(shadow_va));
>         amdgpu_ring_write(ring, upper_32_bits(shadow_va));
> @@ -5531,23 +5601,26 @@ static void gfx_v11_0_ring_emit_gfx_shadow(struct=
 amdgpu_ring *ring,
>                           PACKET3_SET_Q_PREEMPTION_MODE_IB_VMID(vmid) : 0=
);
>         amdgpu_ring_write(ring, init_shadow ?
>                           PACKET3_SET_Q_PREEMPTION_MODE_INIT_SHADOW_MEM :=
 0);
> -}
>
> -static unsigned gfx_v11_0_ring_emit_init_cond_exec(struct amdgpu_ring *r=
ing,
> -                                                  uint64_t addr)
> -{
> -       unsigned ret;
> +       if (ring->set_q_mode_offs)
> +               amdgpu_ring_patch_cond_exec(ring, end);
>
> -       amdgpu_ring_write(ring, PACKET3(PACKET3_COND_EXEC, 3));
> -       amdgpu_ring_write(ring, lower_32_bits(addr));
> -       amdgpu_ring_write(ring, upper_32_bits(addr));
> -       /* discard following DWs if *cond_exec_gpu_addr=3D=3D0 */
> -       amdgpu_ring_write(ring, 0);
> -       ret =3D ring->wptr & ring->buf_mask;
> -       /* patch dummy value later */
> -       amdgpu_ring_write(ring, 0);
> +       if (shadow_va) {
> +               uint64_t token =3D shadow_va ^ csa_va ^ gds_va ^ vmid;
>
> -       return ret;
> +               /*
> +                * If the tokens match try to skip the last postfix SET_Q=
_MODE
> +                * packet to avoid saving/restoring the state all the tim=
e.
> +                */
> +               if (ring->set_q_mode_ptr && ring->set_q_mode_token =3D=3D=
 token)
> +                       *ring->set_q_mode_ptr =3D 0;
> +
> +               ring->set_q_mode_token =3D token;
> +       } else {
> +               ring->set_q_mode_ptr =3D &ring->ring[ring->set_q_mode_off=
s];
> +       }
> +
> +       ring->set_q_mode_offs =3D offs;
>  }
>
>  static int gfx_v11_0_ring_preempt_ib(struct amdgpu_ring *ring)
> @@ -6114,7 +6187,7 @@ static const struct amdgpu_ring_funcs gfx_v11_0_rin=
g_funcs_gfx =3D {
>         .emit_frame_size =3D /* totally 247 maximum if 16 IBs */
>                 5 + /* update_spm_vmid */
>                 5 + /* COND_EXEC */
> -               9 + /* SET_Q_PREEMPTION_MODE */
> +               22 + /* SET_Q_PREEMPTION_MODE */
>                 7 + /* PIPELINE_SYNC */
>                 SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
>                 SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
> @@ -6127,6 +6200,7 @@ static const struct amdgpu_ring_funcs gfx_v11_0_rin=
g_funcs_gfx =3D {
>                 31 + /* DE_META */
>                 3 + /* CNTX_CTRL */
>                 5 + /* HDP_INVL */
> +               22 + /* SET_Q_PREEMPTION_MODE */
>                 8 + 8 + /* FENCE x2 */
>                 8, /* gfx_v11_0_emit_mem_sync */
>         .emit_ib_size =3D 4, /* gfx_v11_0_ring_emit_ib_gfx */
> --
> 2.34.1
>
