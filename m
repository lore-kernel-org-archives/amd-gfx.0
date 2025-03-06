Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B23BC282EC
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Mar 2025 15:05:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC66310E9D0;
	Thu,  6 Mar 2025 15:05:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PqJXFLj4";
	dkim-atps=neutral
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0088C10E9D0
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Mar 2025 15:05:17 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-2f74e6c6cbcso188974a91.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Mar 2025 07:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741273517; x=1741878317; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xVil8qwajumZpSuWiGyiMzUVSDSYbWv5pZvs5bSSmHI=;
 b=PqJXFLj4QeL2hENwiihdUq39DR1vPBFhS29YEeRoh0mkWqT2ZWPqaIv5O6KvsiUthS
 7P4V0/qk8t/yTji5i8wTQVISUth9u7Mt8hPodOThjPl0TovoIuJFkwtM8HVTW/83TCRi
 o6V4lVkl/Zw03WfmMTeMryi2kuSCXxSB8i8y3uhKiy1PRt/tJw9Yg46GcUB64myLNjrg
 f3wfVLSxl9DbrQq0GvOETKpOKv8MQymNdXuM/pUXyBiAiHAL9aJoP7YsagZas/qLbjmJ
 +IGJ0T8z2qyJgYHiLgjRgqkjvHWUA8faD56NAPTF0R8vdEbPjEmFtC3Viw5Qdz+CoFmw
 8/fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741273517; x=1741878317;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xVil8qwajumZpSuWiGyiMzUVSDSYbWv5pZvs5bSSmHI=;
 b=Xfn46g8oBHFrQTHqVRg7ub5SX/e2fg3MNKuJbcAdE8+r8miQ7S+3ml9ECLLV3TTpZz
 t8LDnD1gXBXwbpDb/VjM/1h5VDYrG2IVWsd3xh7h9TS6onzeqg/MC95uvUGwWBBO6RWQ
 aEWLx5RUxQT3UojTah/zDt5vMLmef+psU5A2iUdWJIsckS6h3vExvrerUpOrcPy50+JH
 IZ7bu3N1TrPHroBlB/tHrsgOHybaP2HywVTcE8PD8DVLYKtbsMQ9SJLbvcw0drCEhgIx
 pIGqcE723Mks/0qdohLaNq4iaYifQv7eeVNYdJ9k6TOpfa5ZA8zXeNpswHnBziEBpuey
 DhBA==
X-Gm-Message-State: AOJu0YxkfUo/IQ4h7gUB66OzG3L4J8BXAS6U6U7udgK1Q7ENhu1Nddih
 eOcfnOoc1DHJUgrYL88Xo9uZXNEhdFKZ2pCfg1Dp/nRd75UOjwFflrktqCyzHhq64kzt9d4uJID
 4PCeo/E+IhXPVITdMNGRF/HTLfMnOxQ==
X-Gm-Gg: ASbGncuA0GkZXODPc8f7n/yZF2LnwUYveAa8JeuiBHJXkYs8Wlrjy9HS3JLMO1AvWEd
 QxWJVXOPB6VtiCwsofRvlrSo0PerEr0eeSL4hIpvDzaE+vVv1tLgI1wNOS1jCqeo0RGAJy9OFQE
 Qh+hTvk88SFcflefstmJlgIqgKqw==
X-Google-Smtp-Source: AGHT+IGqeYqunqwf1jqoVjcASYWUfKYPOFwDB6GhoXYDXupXPqpFHcROVw8OrdqW0gHiSn6UJrQEJiFbp8/Sk7T8+sA=
X-Received: by 2002:a17:90b:4d05:b0:2fe:7f51:d2ec with SMTP id
 98e67ed59e1d1-2ff496a2863mr4967488a91.0.1741273517520; Thu, 06 Mar 2025
 07:05:17 -0800 (PST)
MIME-Version: 1.0
References: <20250305191756.1132583-1-alexander.deucher@amd.com>
In-Reply-To: <20250305191756.1132583-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 6 Mar 2025 10:05:06 -0500
X-Gm-Features: AQ5f1JpBhg2GbXS3Mv_sPYAAkImDRIQH_3E7nm92i-2OUlZzP6aDxnvPefdItF8
Message-ID: <CADnq5_P87L_tMvKaRgE9Mj70BYLtao=6QJRSUpqiyJUVyvLP=w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/vcn: fix idle work handler for VCN 2.5
To: Alex Deucher <alexander.deucher@amd.com>
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

Ping?

Thanks,

Alex

On Wed, Mar 5, 2025 at 2:42=E2=80=AFPM Alex Deucher <alexander.deucher@amd.=
com> wrote:
>
> VCN 2.5 uses the PG callback to enable VCN DPM which is
> a global state.  As such, we need to make sure all instances
> are in the same state.
>
> v2: switch to a ref count (Lijo)
> v3: switch to its own idle work handler
> v4: fix logic in DPG handling
>
> Fixes: 4ce4fe27205c ("drm/amdgpu/vcn: use per instance callbacks for idle=
 work handler")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 120 +++++++++++++++++++++++++-
>  1 file changed, 116 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v2_5.c
> index dff1a88590363..ff03436698a4f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -107,6 +107,115 @@ static int amdgpu_ih_clientid_vcns[] =3D {
>         SOC15_IH_CLIENTID_VCN1
>  };
>
> +static void vcn_v2_5_idle_work_handler(struct work_struct *work)
> +{
> +       struct amdgpu_vcn_inst *vcn_inst =3D
> +               container_of(work, struct amdgpu_vcn_inst, idle_work.work=
);
> +       struct amdgpu_device *adev =3D vcn_inst->adev;
> +       unsigned int fences =3D 0, fence[AMDGPU_MAX_VCN_INSTANCES] =3D {0=
};
> +       unsigned int i, j;
> +       int r =3D 0;
> +
> +       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> +               struct amdgpu_vcn_inst *v =3D &adev->vcn.inst[i];
> +
> +               if (adev->vcn.harvest_config & (1 << i))
> +                       continue;
> +
> +               for (j =3D 0; j < v->num_enc_rings; ++j)
> +                       fence[i] +=3D amdgpu_fence_count_emitted(&v->ring=
_enc[j]);
> +
> +               /* Only set DPG pause for VCN3 or below, VCN4 and above w=
ill be handled by FW */
> +               if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
> +                   !v->using_unified_queue) {
> +                       struct dpg_pause_state new_state;
> +
> +                       if (fence[i] ||
> +                           unlikely(atomic_read(&v->dpg_enc_submission_c=
nt)))
> +                               new_state.fw_based =3D VCN_DPG_STATE__PAU=
SE;
> +                       else
> +                               new_state.fw_based =3D VCN_DPG_STATE__UNP=
AUSE;
> +
> +                       v->pause_dpg_mode(v, &new_state);
> +               }
> +
> +               fence[i] +=3D amdgpu_fence_count_emitted(&v->ring_dec);
> +               fences +=3D fence[i];
> +
> +       }
> +
> +       if (!fences && !atomic_read(&adev->vcn.inst[0].total_submission_c=
nt)) {
> +               amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK=
_TYPE_VCN,
> +                                                      AMD_PG_STATE_GATE)=
;
> +               r =3D amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_=
PROFILE_VIDEO,
> +                                                   false);
> +               if (r)
> +                       dev_warn(adev->dev, "(%d) failed to disable video=
 power profile mode\n", r);
> +       } else {
> +               schedule_delayed_work(&adev->vcn.inst[0].idle_work, VCN_I=
DLE_TIMEOUT);
> +       }
> +}
> +
> +static void vcn_v2_5_ring_begin_use(struct amdgpu_ring *ring)
> +{
> +       struct amdgpu_device *adev =3D ring->adev;
> +       struct amdgpu_vcn_inst *v =3D &adev->vcn.inst[ring->me];
> +       int r =3D 0;
> +
> +       atomic_inc(&adev->vcn.inst[0].total_submission_cnt);
> +
> +       if (!cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work)) {
> +               r =3D amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_=
PROFILE_VIDEO,
> +                                                   true);
> +               if (r)
> +                       dev_warn(adev->dev, "(%d) failed to switch to vid=
eo power profile mode\n", r);
> +       }
> +
> +       mutex_lock(&adev->vcn.inst[0].vcn_pg_lock);
> +       amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VC=
N,
> +                                              AMD_PG_STATE_UNGATE);
> +
> +       /* Only set DPG pause for VCN3 or below, VCN4 and above will be h=
andled by FW */
> +       if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
> +           !v->using_unified_queue) {
> +               struct dpg_pause_state new_state;
> +
> +               if (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_VCN_ENC) {
> +                       atomic_inc(&v->dpg_enc_submission_cnt);
> +                       new_state.fw_based =3D VCN_DPG_STATE__PAUSE;
> +               } else {
> +                       unsigned int fences =3D 0;
> +                       unsigned int i;
> +
> +                       for (i =3D 0; i < v->num_enc_rings; ++i)
> +                               fences +=3D amdgpu_fence_count_emitted(&v=
->ring_enc[i]);
> +
> +                       if (fences || atomic_read(&v->dpg_enc_submission_=
cnt))
> +                               new_state.fw_based =3D VCN_DPG_STATE__PAU=
SE;
> +                       else
> +                               new_state.fw_based =3D VCN_DPG_STATE__UNP=
AUSE;
> +               }
> +               v->pause_dpg_mode(v, &new_state);
> +       }
> +       mutex_unlock(&adev->vcn.inst[0].vcn_pg_lock);
> +}
> +
> +static void vcn_v2_5_ring_end_use(struct amdgpu_ring *ring)
> +{
> +       struct amdgpu_device *adev =3D ring->adev;
> +
> +       /* Only set DPG pause for VCN3 or below, VCN4 and above will be h=
andled by FW */
> +       if (ring->adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
> +           ring->funcs->type =3D=3D AMDGPU_RING_TYPE_VCN_ENC &&
> +           !adev->vcn.inst[ring->me].using_unified_queue)
> +               atomic_dec(&adev->vcn.inst[ring->me].dpg_enc_submission_c=
nt);
> +
> +       atomic_dec(&adev->vcn.inst[0].total_submission_cnt);
> +
> +       schedule_delayed_work(&adev->vcn.inst[0].idle_work,
> +                             VCN_IDLE_TIMEOUT);
> +}
> +
>  /**
>   * vcn_v2_5_early_init - set function pointers and load microcode
>   *
> @@ -201,6 +310,9 @@ static int vcn_v2_5_sw_init(struct amdgpu_ip_block *i=
p_block)
>                 if (r)
>                         return r;
>
> +               /* Override the work func */
> +               adev->vcn.inst[j].idle_work.work.func =3D vcn_v2_5_idle_w=
ork_handler;
> +
>                 amdgpu_vcn_setup_ucode(adev, j);
>
>                 r =3D amdgpu_vcn_resume(adev, j);
> @@ -1661,8 +1773,8 @@ static const struct amdgpu_ring_funcs vcn_v2_5_dec_=
ring_vm_funcs =3D {
>         .insert_start =3D vcn_v2_0_dec_ring_insert_start,
>         .insert_end =3D vcn_v2_0_dec_ring_insert_end,
>         .pad_ib =3D amdgpu_ring_generic_pad_ib,
> -       .begin_use =3D amdgpu_vcn_ring_begin_use,
> -       .end_use =3D amdgpu_vcn_ring_end_use,
> +       .begin_use =3D vcn_v2_5_ring_begin_use,
> +       .end_use =3D vcn_v2_5_ring_end_use,
>         .emit_wreg =3D vcn_v2_0_dec_ring_emit_wreg,
>         .emit_reg_wait =3D vcn_v2_0_dec_ring_emit_reg_wait,
>         .emit_reg_write_reg_wait =3D amdgpu_ring_emit_reg_write_reg_wait_=
helper,
> @@ -1759,8 +1871,8 @@ static const struct amdgpu_ring_funcs vcn_v2_5_enc_=
ring_vm_funcs =3D {
>         .insert_nop =3D amdgpu_ring_insert_nop,
>         .insert_end =3D vcn_v2_0_enc_ring_insert_end,
>         .pad_ib =3D amdgpu_ring_generic_pad_ib,
> -       .begin_use =3D amdgpu_vcn_ring_begin_use,
> -       .end_use =3D amdgpu_vcn_ring_end_use,
> +       .begin_use =3D vcn_v2_5_ring_begin_use,
> +       .end_use =3D vcn_v2_5_ring_end_use,
>         .emit_wreg =3D vcn_v2_0_enc_ring_emit_wreg,
>         .emit_reg_wait =3D vcn_v2_0_enc_ring_emit_reg_wait,
>         .emit_reg_write_reg_wait =3D amdgpu_ring_emit_reg_write_reg_wait_=
helper,
> --
> 2.48.1
>
