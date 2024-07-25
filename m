Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2794CC3DA49
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 19:50:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE4A410E300;
	Thu, 25 Jul 2024 19:50:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="M1C9FVnc";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 786D710E300
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 19:50:38 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-1fc658b6b2eso11995395ad.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 12:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721937038; x=1722541838; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t0gZ0IKHxyDL+rhOoEMBM0P5q/KUruN+QfRf6sDWNTM=;
 b=M1C9FVncnz6/ZmKyOhm78h2yePxiMnNE3E3oIJL/VXT22vmqN+sz1Y0GPEPSdshSPg
 J8BuQQUmLjZc9Ct4eI9ultQoOgyiszLCqRsCt+hrFph7L4KbOsSIkMJBynZCIh7kTOv6
 P+wSatQf2PmazOV/ZnhPEAJlU1SZTJsc/v7fGOGPgQwGq05WVud1G3WXU1QarSH0a4AK
 5l+2MSA+n9RkbMTRPcP/qeOafa6GaG1YD4Bos4ciTEK+5fFwKmlr8qxmkoHjpq5MEs3M
 i+fmNxUDld70ADyQQHzYRWs1nudPEuA9qKmsrZjJWZ7Bi/XuBAXI/P2rvjRop5Y9ToC4
 HMkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721937038; x=1722541838;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t0gZ0IKHxyDL+rhOoEMBM0P5q/KUruN+QfRf6sDWNTM=;
 b=I3Z8vxcsIfukQPYdMQLphh1N7i+nHZ6w9pj9HeE8k/Oi1YBJqdFMOrMdcHWudJ0Rly
 E28YHWYbuVRg9VWTAOij5SJ1DqOIZLJ7fZKC4fx2uebchud9DjSB3zX+OLyFUcEe5AJB
 rRTk+xGgsGOmEAtef9xWjCcqWCgMWItlefy2k8s4+PFA+Ix4vErmVYBfDPxDP7Mkf8Z5
 +9CExWBXySi1oNh8C0Qp/IbYWmfbr0S14v/v0CmdhRt4f1T7ki2aIISnfGFanH3lAUoR
 pROOJh5DDWn1XdVPaz90RXnzmI0l2oBIQh3+lU/boA/6Sz2edTLo3GtPjwgkW70x1gDV
 Qe0g==
X-Gm-Message-State: AOJu0Yx3OlmAfGKOJ5iTBa3zt31MhskEAwsZ5WvfQcDzPZR76sjaizgp
 XB/W4EkwyG2qNG5t2qg0B9PkIYjjN/ICGhEbGSIuSbv3OPYi+HO+x4QL1FlqJAGRfLvuK0Nq+UW
 4ILpoZxSXJaZEdJ5UANB6gfUrWnc=
X-Google-Smtp-Source: AGHT+IEEf7Ock2bib+pIetje0++dFFziZHfNlbWTuX9J4IVendchoNoTOK5CcrbevhcM+vpE94uL3/0tYjGvK0ElaBs=
X-Received: by 2002:a17:903:2312:b0:1fd:6581:f69f with SMTP id
 d9443c01a7336-1fed38b2103mr55183485ad.22.1721937037879; Thu, 25 Jul 2024
 12:50:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240724184616.196690-1-michael.chen@amd.com>
In-Reply-To: <20240724184616.196690-1-michael.chen@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 25 Jul 2024 15:50:26 -0400
Message-ID: <CADnq5_Pd6hb=_Li0owLejWU8Gv2FnEXko6B6xLV2vAe33tguEg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: increase mes log buffer size for gfx12
To: Michael Chen <michael.chen@amd.com>
Cc: amd-gfx@lists.freedesktop.org, felix.kuehling@amd.com, 
 alexander.deucher@amd.com
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

On Wed, Jul 24, 2024 at 2:47=E2=80=AFPM Michael Chen <michael.chen@amd.com>=
 wrote:
>
> MES firmware requires larger log buffer for gfx12. Allocate
> proper buffer respectively for gfx11 and gfx12.
>
> Signed-off-by: Michael Chen <michael.chen@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c       | 6 +++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h       | 6 +++---
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        | 2 ++
>  drivers/gpu/drm/amd/amdgpu/mes_v12_0.c        | 8 ++++++--
>  drivers/gpu/drm/amd/include/mes_v11_api_def.h | 3 +++
>  drivers/gpu/drm/amd/include/mes_v12_api_def.h | 3 +++
>  6 files changed, 20 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mes.c
> index e499d6ba306b..dac88d2dd70d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -103,7 +103,7 @@ static int amdgpu_mes_event_log_init(struct amdgpu_de=
vice *adev)
>         if (!amdgpu_mes_log_enable)
>                 return 0;
>
> -       r =3D amdgpu_bo_create_kernel(adev, AMDGPU_MES_LOG_BUFFER_SIZE, P=
AGE_SIZE,
> +       r =3D amdgpu_bo_create_kernel(adev, adev->mes.event_log_size, PAG=
E_SIZE,
>                                     AMDGPU_GEM_DOMAIN_GTT,
>                                     &adev->mes.event_log_gpu_obj,
>                                     &adev->mes.event_log_gpu_addr,
> @@ -113,7 +113,7 @@ static int amdgpu_mes_event_log_init(struct amdgpu_de=
vice *adev)
>                 return r;
>         }
>
> -       memset(adev->mes.event_log_cpu_addr, 0, PAGE_SIZE);
> +       memset(adev->mes.event_log_cpu_addr, 0, adev->mes.event_log_size)=
;
>
>         return  0;
>
> @@ -1573,7 +1573,7 @@ static int amdgpu_debugfs_mes_event_log_show(struct=
 seq_file *m, void *unused)
>         uint32_t *mem =3D (uint32_t *)(adev->mes.event_log_cpu_addr);
>
>         seq_hex_dump(m, "", DUMP_PREFIX_OFFSET, 32, 4,
> -                    mem, AMDGPU_MES_LOG_BUFFER_SIZE, false);
> +                    mem, adev->mes.event_log_size, false);
>
>         return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mes.h
> index e11051271f71..2d659c612f03 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -52,7 +52,6 @@ enum amdgpu_mes_priority_level {
>
>  #define AMDGPU_MES_PROC_CTX_SIZE 0x1000 /* one page area */
>  #define AMDGPU_MES_GANG_CTX_SIZE 0x1000 /* one page area */
> -#define AMDGPU_MES_LOG_BUFFER_SIZE 0x4000 /* Maximu log buffer size for =
MES */
>
>  struct amdgpu_mes_funcs;
>
> @@ -135,8 +134,9 @@ struct amdgpu_mes {
>         unsigned long                   *doorbell_bitmap;
>
>         /* MES event log buffer */
> -       struct amdgpu_bo                *event_log_gpu_obj;
> -       uint64_t                        event_log_gpu_addr;
> +       uint32_t                        event_log_size;
> +       struct amdgpu_bo        *event_log_gpu_obj;
> +       uint64_t                        event_log_gpu_addr;
>         void                            *event_log_cpu_addr;
>
>         /* ip specific functions */
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v11_0.c
> index 68c74adf79f1..1a5ad5be33bf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -1173,6 +1173,8 @@ static int mes_v11_0_sw_init(void *handle)
>         adev->mes.kiq_hw_init =3D &mes_v11_0_kiq_hw_init;
>         adev->mes.kiq_hw_fini =3D &mes_v11_0_kiq_hw_fini;
>
> +       adev->mes.event_log_size =3D AMDGPU_MES_LOG_BUFFER_SIZE;
> +
>         r =3D amdgpu_mes_init(adev);
>         if (r)
>                 return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v12_0.c
> index 48e01206bcc4..249e5a66205c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> @@ -561,8 +561,10 @@ static int mes_v12_0_set_hw_resources(struct amdgpu_=
mes *mes)
>         mes_set_hw_res_pkt.oversubscription_timer =3D 50;
>         mes_set_hw_res_pkt.unmapped_doorbell_handling =3D 1;
>
> -       mes_set_hw_res_pkt.enable_mes_event_int_logging =3D 0;
> -       mes_set_hw_res_pkt.event_intr_history_gpu_mc_ptr =3D mes->event_l=
og_gpu_addr;
> +       if (amdgpu_mes_log_enable) {
> +               mes_set_hw_res_pkt.enable_mes_event_int_logging =3D 1;
> +               mes_set_hw_res_pkt.event_intr_history_gpu_mc_ptr =3D mes-=
>event_log_gpu_addr;
> +       }
>
>         return mes_v12_0_submit_pkt_and_poll_completion(mes,
>                         &mes_set_hw_res_pkt, sizeof(mes_set_hw_res_pkt),
> @@ -1247,6 +1249,8 @@ static int mes_v12_0_sw_init(void *handle)
>         adev->mes.kiq_hw_init =3D &mes_v12_0_kiq_hw_init;
>         adev->mes.kiq_hw_fini =3D &mes_v12_0_kiq_hw_fini;
>
> +       adev->mes.event_log_size =3D AMDGPU_MES_LOG_BUFFER_SIZE;
> +
>         r =3D amdgpu_mes_init(adev);
>         if (r)
>                 return r;
> diff --git a/drivers/gpu/drm/amd/include/mes_v11_api_def.h b/drivers/gpu/=
drm/amd/include/mes_v11_api_def.h
> index b72d5d362251..21ceafce1f9b 100644
> --- a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
> +++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
> @@ -28,6 +28,9 @@
>
>  #define MES_API_VERSION 1
>
> +/* Maximum log buffer size for MES. Needs to be updated if MES expands M=
ES_EVT_INTR_HIST_LOG */
> +#define  AMDGPU_MES_LOG_BUFFER_SIZE  0x4000
> +
>  /* Driver submits one API(cmd) as a single Frame and this command size i=
s same
>   * for all API to ease the debugging and parsing of ring buffer.
>   */
> diff --git a/drivers/gpu/drm/amd/include/mes_v12_api_def.h b/drivers/gpu/=
drm/amd/include/mes_v12_api_def.h
> index ffd67c6ed9b3..4cf2c9f30b3d 100644
> --- a/drivers/gpu/drm/amd/include/mes_v12_api_def.h
> +++ b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
> @@ -28,6 +28,9 @@
>
>  #define MES_API_VERSION 0x14
>
> +/* Maximum log buffer size for MES. Needs to be updated if MES expands M=
ES_EVT_INTR_HIST_LOG_12 */
> +#define  AMDGPU_MES_LOG_BUFFER_SIZE  0xC000
> +
>  /* Driver submits one API(cmd) as a single Frame and this command size i=
s same for all API
>   * to ease the debugging and parsing of ring buffer.
>   */
> --
> 2.34.1
>
