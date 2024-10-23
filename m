Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A75FCFA460
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Oct 2024 19:32:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC79B10E21E;
	Wed, 23 Oct 2024 19:32:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T+iPd855";
	dkim-atps=neutral
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E72A710E21E
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Oct 2024 19:32:16 +0000 (UTC)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-7ea85fa4f45so17682a12.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Oct 2024 12:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729711936; x=1730316736; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=41AZEO0VfzeOjKqhw7zL9i9AuRboa9+3g4WuEsZnVEg=;
 b=T+iPd855kFOJR7sICQ/qD1yZu/px7ctIiThGpaY6+nsUk5dsUaVoO/OtglTA6Os0aR
 fAWdkwhyxdNlACwxvsW5AYCs5ppEzTJ0Dx5XEUOTsWdTPG21InzxuOuOiPPUZDE5NXmK
 TIvhmPGy2oHYC6rkHTzuD3DKgmj0fC+q10pIWXqNcPj3Hf/BUEpzxr9Vmg6h71ESmc6Q
 CgJlCEglo8mWWSlwUP6ywg04dmotALoX3QiFb9RLLPnMmPjJcjVt8uiQKsOEHSyp2yDP
 ITfncs3Q5lEFpC61llu7feWqGR3js07jawBYGPLmCp42n7UIu1lmz8iw/aRFQpIw+Y0u
 EvWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729711936; x=1730316736;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=41AZEO0VfzeOjKqhw7zL9i9AuRboa9+3g4WuEsZnVEg=;
 b=el6ZaA/W6iIjtqKmPjw7taPXjzWq6M3tk7NbebvFJ4QHMMcIRTpqhIxGR18VnmrbR6
 RxUQ8I2ezCpiHZFBd12QXH9V3dVKuNTiRie4guKxmikvwi0iNIfdX4FiLURi8szYSV58
 kRrbkBd2jejt3Mju1jwWmY54Ykl1ReZIBUHphvDIGDYwyZcpSVIJiPndQjw3PohKit3O
 3W2zUMiodGzsfsrCTgxhUpekLdQ1gv2Y/k2qn7I7g4jqEn0smYHT7oOguD3JCspXjpWi
 M/0MKgCPXuizfoJd3ViSetQBBtYSJhOOx7RXtG7Wo6HO0OZ+o5mnJVVHX1o9X7oBfbMI
 zIng==
X-Gm-Message-State: AOJu0YxtBQGMmBpnTgtLZGeHNvJ40UWzysPV3mVSNVXb+R2mJLBzGPYs
 53mC5FnCvda87CBV1elHsoSCJPSQWiUNY4H3TaPfFlZe2Gafp0YuBmdRSSQ72pOGCQ2FjcMH/e0
 qx3VK4lkflN303X8LM4KFSn6mrRA=
X-Google-Smtp-Source: AGHT+IHbYJubWCO7ns+aEY1F362bCDbOhgLCNzs9s/IUeDdu8BUb+8vxqzJDObBcwe2241f6hs1G6pXxw7Ijsq+i2e4=
X-Received: by 2002:a05:6a21:78a3:b0:1cf:43e0:d75f with SMTP id
 adf61e73a8af0-1d978ba8e0fmr2328685637.7.1729711936105; Wed, 23 Oct 2024
 12:32:16 -0700 (PDT)
MIME-Version: 1.0
References: <20241023174059.1215976-1-shaoyun.liu@amd.com>
In-Reply-To: <20241023174059.1215976-1-shaoyun.liu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 23 Oct 2024 15:32:04 -0400
Message-ID: <CADnq5_ONhkN0GjeUUQ=Gf1nPJPKzTWwkvkFimtrWh=FYpqdfaQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: limit single process inside MES
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

On Wed, Oct 23, 2024 at 2:08=E2=80=AFPM Shaoyun Liu <shaoyun.liu@amd.com> w=
rote:
>
> This is for MES to limit only one process for the user queues
>
> Signed-off-by: Shaoyun Liu <shaoyun.liu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c |  2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 24 ++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 19 +++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 11 +++++++++++
>  drivers/gpu/drm/amd/amdgpu/mes_v12_0.c  | 11 +++++++++++
>  5 files changed, 67 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.c
> index e96984c53e72..72e38d621a29 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1576,9 +1576,11 @@ static ssize_t amdgpu_gfx_set_enforce_isolation(st=
ruct device *dev,
>                 if (adev->enforce_isolation[i] && !partition_values[i]) {
>                         /* Going from enabled to disabled */
>                         amdgpu_vmid_free_reserved(adev, AMDGPU_GFXHUB(i))=
;
> +                       amdgpu_mes_set_enforce_isolation(adev, i, false);
>                 } else if (!adev->enforce_isolation[i] && partition_value=
s[i]) {
>                         /* Going from disabled to enabled */
>                         amdgpu_vmid_alloc_reserved(adev, AMDGPU_GFXHUB(i)=
);
> +                       amdgpu_mes_set_enforce_isolation(adev, i, true);
>                 }
>                 adev->enforce_isolation[i] =3D partition_values[i];
>         }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mes.c
> index bf584e9bcce4..29b6a2baae4d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -1674,6 +1674,30 @@ bool amdgpu_mes_suspend_resume_all_supported(struc=
t amdgpu_device *adev)
>         return is_supported;
>  }
>
> +/* Fix me -- node_id is used to identify the correct MES instances in th=
e future */
> +int amdgpu_mes_set_enforce_isolation(struct amdgpu_device *adev, uint32_=
t node_id, bool enable)
> +{
> +       struct mes_misc_op_input op_input =3D {0};
> +       int r;
> +
> +       op_input.op =3D MES_MISC_OP_CHANGE_CONFIG;
> +       op_input.change_config.option.limit_single_process =3D enable ? 1=
 : 0;
> +
> +       if (!adev->mes.funcs->misc_op) {
> +               DRM_ERROR("mes change config is not supported!\n");

Please use dev_err() so it's clear which GPU the error is coming from
in a multi-GPU system.

> +               r =3D -EINVAL;
> +               goto error;
> +       }
> +
> +       r =3D adev->mes.funcs->misc_op(&adev->mes, &op_input);
> +       if (r)
> +               DRM_ERROR("failed to change_config.\n");

dev_err()

> +
> +error:
> +       return r;
> +
> +}
> +
>  #if defined(CONFIG_DEBUG_FS)
>
>  static int amdgpu_debugfs_mes_event_log_show(struct seq_file *m, void *u=
nused)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mes.h
> index 79f13d7e5e16..91bff6443c05 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -311,6 +311,7 @@ enum mes_misc_opcode {
>         MES_MISC_OP_WRM_REG_WAIT,
>         MES_MISC_OP_WRM_REG_WR_WAIT,
>         MES_MISC_OP_SET_SHADER_DEBUGGER,
> +       MES_MISC_OP_CHANGE_CONFIG,
>  };
>
>  struct mes_misc_op_input {
> @@ -349,6 +350,21 @@ struct mes_misc_op_input {
>                         uint32_t tcp_watch_cntl[4];
>                         uint32_t trap_en;
>                 } set_shader_debugger;
> +
> +               struct {
> +                       union {
> +                               struct {
> +                                       uint32_t limit_single_process : 1=
;
> +                                       uint32_t enable_hws_logging_buffe=
r : 1;
> +                                       uint32_t reserved : 30;
> +                               };
> +                               uint32_t all;
> +                       } option;
> +                       struct {
> +                               uint32_t tdr_level;
> +                               uint32_t tdr_delay;
> +                       } tdr_config;
> +               } change_config;
>         };
>  };
>
> @@ -519,4 +535,7 @@ static inline void amdgpu_mes_unlock(struct amdgpu_me=
s *mes)
>  }
>
>  bool amdgpu_mes_suspend_resume_all_supported(struct amdgpu_device *adev)=
;
> +
> +int amdgpu_mes_set_enforce_isolation(struct amdgpu_device *adev, uint32_=
t node_id, bool enable);
> +
>  #endif /* __AMDGPU_MES_H__ */
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v11_0.c
> index 57db0c006c8f..1d6de7bced48 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -644,6 +644,14 @@ static int mes_v11_0_misc_op(struct amdgpu_mes *mes,
>                                 sizeof(misc_pkt.set_shader_debugger.tcp_w=
atch_cntl));
>                 misc_pkt.set_shader_debugger.trap_en =3D input->set_shade=
r_debugger.trap_en;
>                 break;
> +       case MES_MISC_OP_CHANGE_CONFIG:
> +               misc_pkt.opcode =3D MESAPI_MISC__CHANGE_CONFIG;
> +               misc_pkt.change_config.opcode =3D
> +                               MESAPI_MISC__CHANGE_CONFIG_OPTION_LIMIT_S=
INGLE_PROCESS;
> +               misc_pkt.change_config.option.bits.limit_single_process =
=3D
> +                               input->change_config.option.limit_single_=
process;

We should add a firmware version check here and and return an error if
the fw version is too old to support this packet.


> +               break;
> +
>         default:
>                 DRM_ERROR("unsupported misc op (%d) \n", input->op);
>                 return -EINVAL;
> @@ -719,6 +727,9 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_m=
es *mes)
>                                         mes->event_log_gpu_addr;
>         }
>
> +       if(enforce_isolation)

missing space between if and (.

> +               mes_set_hw_res_pkt.limit_single_process =3D1;
> +
>         return mes_v11_0_submit_pkt_and_poll_completion(mes,
>                         &mes_set_hw_res_pkt, sizeof(mes_set_hw_res_pkt),
>                         offsetof(union MESAPI_SET_HW_RESOURCES, api_statu=
s));
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v12_0.c
> index 9d0e342a2f81..85eff9b777c2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> @@ -531,6 +531,14 @@ static int mes_v12_0_misc_op(struct amdgpu_mes *mes,
>                                 sizeof(misc_pkt.set_shader_debugger.tcp_w=
atch_cntl));
>                 misc_pkt.set_shader_debugger.trap_en =3D input->set_shade=
r_debugger.trap_en;
>                 break;
> +       case MES_MISC_OP_CHANGE_CONFIG:
> +               misc_pkt.opcode =3D MESAPI_MISC__CHANGE_CONFIG;
> +               misc_pkt.change_config.opcode =3D
> +                               MESAPI_MISC__CHANGE_CONFIG_OPTION_LIMIT_S=
INGLE_PROCESS;
> +               misc_pkt.change_config.option.bits.limit_single_process =
=3D
> +                               input->change_config.option.limit_single_=
process;
> +               break;
> +
>         default:
>                 DRM_ERROR("unsupported misc op (%d) \n", input->op);
>                 return -EINVAL;
> @@ -633,6 +641,9 @@ static int mes_v12_0_set_hw_resources(struct amdgpu_m=
es *mes, int pipe)
>                 mes_set_hw_res_pkt.event_intr_history_gpu_mc_ptr =3D mes-=
>event_log_gpu_addr + pipe * AMDGPU_MES_LOG_BUFFER_SIZE;
>         }
>
> +       if(enforce_isolation)

missing space between if and (.

Other than that, looks good to me.

Alex

> +               mes_set_hw_res_pkt.limit_single_process =3D1;
> +
>         return mes_v12_0_submit_pkt_and_poll_completion(mes, pipe,
>                         &mes_set_hw_res_pkt, sizeof(mes_set_hw_res_pkt),
>                         offsetof(union MESAPI_SET_HW_RESOURCES, api_statu=
s));
> --
> 2.34.1
>
