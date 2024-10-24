Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1140ECE8E70
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Oct 2024 13:21:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC8E510E939;
	Thu, 24 Oct 2024 13:21:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KAlhKeJW";
	dkim-atps=neutral
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
 [209.85.215.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 183BF10E939
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Oct 2024 13:21:31 +0000 (UTC)
Received: by mail-pg1-f169.google.com with SMTP id
 41be03b00d2f7-7e9f377a3c9so83046a12.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Oct 2024 06:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729776090; x=1730380890; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KuM7s1udF6HOW8oVW8jwz5QzK+h0m+0bVtWUlb4Fjd0=;
 b=KAlhKeJWsxfJI7asvss65rET2wRvGN2BBb/Hh+R4jfbxxMeIrF8FeAXpJHD7DXzEMg
 D7Up4kTToXluohluKncL22cVa3pYYKsc4cfTynXVsNwL4z4h36ZqfY0BB0T6SlYIe3IA
 7SXWRz1b2EC34YLwni1t2Lkb9ainHAaPC07Fp0fYCNli9ksS6nSDmC76bARQ4y2J6pG+
 KWI9xzHGTqtPVtzyt1lBlJHzIKo6JtyUpQ4kuRx+wpeFooy92hsmnZHgR2PQd+c4JkjA
 ahk7KqZwdhXqQi2yrqFTN+LHMNVWqjdxHsWowTQ0kX3z3j1mRw1p2Y+3L/z+GLBb8p//
 3skQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729776090; x=1730380890;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KuM7s1udF6HOW8oVW8jwz5QzK+h0m+0bVtWUlb4Fjd0=;
 b=H26idIK/YC/2bb6skK82hNM14NKrQN3wjnlmx2/lH8NI29NUT1v9L+dOVTz1erK21F
 r78qXaTMTy3eFsvVBkEOfpPVlY3phxMmBF/QCpiih2K5pskKnomlva0K8vQYAzGMIiST
 dl/wREwCD1nw7lArW5S8uCO2aTckMvbfgO4pkI+ndcVW1BYJxYLuppBT3rkcal4i3MML
 Cb3Qr7feB7YwBvgn+HZM6X7JDdwYOLRcqxApm48JdYdRnqPNzjkS4/TVXskGagxLSKGS
 8zN6Hl+3r54XcquQyN3j5rbUT3qnvRdA0RxRAaOzziS0SsH4d0xc6p6bWQdFfqX/oKsn
 YjDA==
X-Gm-Message-State: AOJu0Yy/wQupAdaX7zCaBnNTaGvevvgj+JFP5nRxLX1leYuZkCmfdkjd
 s7w+/ZZuKjC2aoTcehWa/FCuCVtaysHP1aN31b8bTOcQLxR57IVYW4HA7CazWxhh1SM75KuNWbi
 xlGoLrF9M06196bGcAq5ZaSyq6nhB0w==
X-Google-Smtp-Source: AGHT+IEHifEnWm+2izzJOFlQ68QvErgp0jZJ915yNX6RVAJDXLzzJkbIjLkY00Nzeg1PX+mbjzYJgMkmhFjSF4XLKXQ=
X-Received: by 2002:a05:6a21:32a4:b0:1cf:4bd8:3a02 with SMTP id
 adf61e73a8af0-1d978ad651cmr3895264637.3.1729776090407; Thu, 24 Oct 2024
 06:21:30 -0700 (PDT)
MIME-Version: 1.0
References: <20241024004004.1216961-1-shaoyun.liu@amd.com>
In-Reply-To: <20241024004004.1216961-1-shaoyun.liu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 24 Oct 2024 09:21:17 -0400
Message-ID: <CADnq5_MjhWC4FV_39ed+DfFeZREPZko9EzMi5NrwmSoy2j6=mA@mail.gmail.com>
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

On Wed, Oct 23, 2024 at 8:48=E2=80=AFPM Shaoyun Liu <shaoyun.liu@amd.com> w=
rote:
>
> This is for MES to limit only one process for the user queues
>
> Signed-off-by: Shaoyun Liu <shaoyun.liu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c |  2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 24 ++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 19 +++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 15 +++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/mes_v12_0.c  | 11 +++++++++++
>  5 files changed, 71 insertions(+)
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
> index bf584e9bcce4..dfc7d320fcbc 100644
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
> +               dev_err(adev->dev,"mes change config is not supported!\n"=
);
> +               r =3D -EINVAL;
> +               goto error;
> +       }
> +
> +       r =3D adev->mes.funcs->misc_op(&adev->mes, &op_input);
> +       if (r)
> +               dev_err(adev->dev, "failed to change_config.\n");
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
> index 57db0c006c8f..c621ba805433 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -644,6 +644,18 @@ static int mes_v11_0_misc_op(struct amdgpu_mes *mes,
>                                 sizeof(misc_pkt.set_shader_debugger.tcp_w=
atch_cntl));
>                 misc_pkt.set_shader_debugger.trap_en =3D input->set_shade=
r_debugger.trap_en;
>                 break;
> +       case MES_MISC_OP_CHANGE_CONFIG:
> +               if ((adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) <=
 0x63) {
> +                       dev_err(adev->dev, "MES FW versoin must be larger=
 than 0x63 to support limit single process feature.\n");
> +                       return -EINVAL;
> +               }
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
> @@ -719,6 +731,9 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_m=
es *mes)
>                                         mes->event_log_gpu_addr;
>         }
>
> +       if (enforce_isolation)
> +               mes_set_hw_res_pkt.limit_single_process =3D1;

Assuming that setting this on old firmware will not cause a problem?
If so we need a firmware check here as well.  If not, the patch is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> +
>         return mes_v11_0_submit_pkt_and_poll_completion(mes,
>                         &mes_set_hw_res_pkt, sizeof(mes_set_hw_res_pkt),
>                         offsetof(union MESAPI_SET_HW_RESOURCES, api_statu=
s));
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v12_0.c
> index 9d0e342a2f81..26d1b82721ce 100644
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
> +       if (enforce_isolation)
> +               mes_set_hw_res_pkt.limit_single_process =3D1;
> +
>         return mes_v12_0_submit_pkt_and_poll_completion(mes, pipe,
>                         &mes_set_hw_res_pkt, sizeof(mes_set_hw_res_pkt),
>                         offsetof(union MESAPI_SET_HW_RESOURCES, api_statu=
s));
> --
> 2.34.1
>
