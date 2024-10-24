Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C9C1CE8E70
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Oct 2024 13:31:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFDDC10E14A;
	Thu, 24 Oct 2024 13:31:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VLvMtOmF";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17E2910E14A
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Oct 2024 13:31:20 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-20c78a10eb3so863575ad.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Oct 2024 06:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729776679; x=1730381479; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i7uwCLQW68mlRDoQzdzm/dOFdXLqBm7ivLL2KdMbcM8=;
 b=VLvMtOmFUumNe8Lvm47K1hxa8LdUTNdHFI96ry5d9IDB5q2W37nnYwmmWbEs2iliwj
 K4iQsspbFRk0WJkkPKiQ1cTQIW3TkefKKYNB3BbmvMeQV/rHx0dXNmPDRP1XvDXBXuJ6
 GS2MIYvxQSFCqoW2wMCnLRCbodM3C4RzQiztQ4lk2w6oR1xTCft5awFvSyImC/SZkAhu
 83L5Khd8vq01fLHXFzUrP5l52KAu+ofFrGRQtX+pIfa/4HUvhRlYo8KVSDHprOM5ZqlM
 Lt92h1KRywKCieoCq0dJDMgSNouEzlRem7ZN+hvnXLQk4sbqLUSSWXML70s+V2WR+SwL
 PLEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729776679; x=1730381479;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i7uwCLQW68mlRDoQzdzm/dOFdXLqBm7ivLL2KdMbcM8=;
 b=H37gZmjx+wJmQZYW4Asn+BZh166Z0vWEiQWqYt2p4BluyqzmIZfufTK2g8NuKe//Gm
 bEFADUo2QnZRP0YfImMr9JloRyzqlaC+noTjl3fPUVOOTXfcVi8dDK78NN84u21LC2J4
 OCARQlTtw+d3dedu03fevN9VVCVixIgSnrWc+qZtyOQsrJrKTBy4Pb7dlie3lfaAJnSO
 ZDccu3UHhQirgi7acbRq5sIfcX9Q0nb9FaKl3hNL1wTK+tB8IZQXgBT9yVdgdPbWtBOg
 jJHgcT4xw0AQrFZBLI6acOniJdN2rOIb/onleU4H2JK4X9V1XHUbLa6OWGFrI3EOtan0
 XiyQ==
X-Gm-Message-State: AOJu0YzXbeq0e7L4hTiPkkP3P4wm/Uyo8kS7Ig2hRKkFsOQkRg7D1GZW
 pF+0irDRvjSOsHRZUcj/ih7JSEhnt8z0anmNA8b524AXvgEcRwSBHXiW2LSkrxX1IlYczMnvh2g
 tNqvZZ27RGkprpyuVRoB9x2auWtElYA==
X-Google-Smtp-Source: AGHT+IE433k72UGZx+K/HuKBmYpWObuhy/gnUqXCFeSCATrdEZvce0OI+IG4TlwKAZNg7MR8e2mdiu+qUD7YtAoBIoM=
X-Received: by 2002:a17:903:234c:b0:20c:ee32:7595 with SMTP id
 d9443c01a7336-20fa9dea298mr37033125ad.2.1729776679472; Thu, 24 Oct 2024
 06:31:19 -0700 (PDT)
MIME-Version: 1.0
References: <20241022021101.761054-1-shaoyun.liu@amd.com>
In-Reply-To: <20241022021101.761054-1-shaoyun.liu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 24 Oct 2024 09:31:07 -0400
Message-ID: <CADnq5_O_24Aw_EioG-Wrwg8ciiMfxBgEjgqAnxHMsMuFi0tL_A@mail.gmail.com>
Subject: Re: [PATCH] drm/amd : Update MES API header file for v11 & v12
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

On Mon, Oct 21, 2024 at 10:11=E2=80=AFPM Shaoyun Liu <shaoyun.liu@amd.com> =
wrote:
>
> New features require the new fields defines
>
> Signed-off-by: Shaoyun Liu <shaoyun.liu@amd.com>
> ---
>  drivers/gpu/drm/amd/include/mes_v11_api_def.h | 32 ++++++++++++++++-
>  drivers/gpu/drm/amd/include/mes_v12_api_def.h | 34 ++++++++++++++++++-
>  2 files changed, 64 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/include/mes_v11_api_def.h b/drivers/gpu/=
drm/amd/include/mes_v11_api_def.h
> index 21ceafce1f9b..663f368eb4f0 100644
> --- a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
> +++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
> @@ -230,13 +230,23 @@ union MESAPI_SET_HW_RESOURCES {
>                                 uint32_t disable_add_queue_wptr_mc_addr :=
 1;
>                                 uint32_t enable_mes_event_int_logging : 1=
;
>                                 uint32_t enable_reg_active_poll : 1;
> -                               uint32_t reserved       : 21;
> +                               uint32_t use_disable_queue_in_legacy_uq_p=
reemption : 1;
> +                               uint32_t send_write_data : 1;
> +                               uint32_t os_tdr_timeout_override : 1;
> +                               uint32_t use_rs64mem_for_proc_gang_ctx : =
1;
> +                               uint32_t use_add_queue_unmap_flag_addr : =
1;
> +                               uint32_t enable_mes_sch_stb_log : 1;
> +                               uint32_t limit_single_process : 1;
> +                               uint32_t is_strix_tmz_wa_enabled  :1;
> +                               uint32_t reserved : 13;
>                         };
>                         uint32_t        uint32_t_all;
>                 };
>                 uint32_t        oversubscription_timer;
>                 uint64_t        doorbell_info;
>                 uint64_t        event_intr_history_gpu_mc_ptr;
> +               uint64_t        timestamp;
> +               uint32_t        os_tdr_timeout_in_sec;

Will this change break backwards compatibility?  It changes the size
of the packet.

Alex

>         };
>
>         uint32_t        max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
> @@ -563,6 +573,11 @@ enum MESAPI_MISC_OPCODE {
>         MESAPI_MISC__READ_REG,
>         MESAPI_MISC__WAIT_REG_MEM,
>         MESAPI_MISC__SET_SHADER_DEBUGGER,
> +       MESAPI_MISC__NOTIFY_WORK_ON_UNMAPPED_QUEUE,
> +       MESAPI_MISC__NOTIFY_TO_UNMAP_PROCESSES,
> +       MESAPI_MISC__CHANGE_CONFIG,
> +       MESAPI_MISC__LAUNCH_CLEANER_SHADER,
> +
>         MESAPI_MISC__MAX,
>  };
>
> @@ -617,6 +632,20 @@ struct SET_SHADER_DEBUGGER {
>         uint32_t trap_en;
>  };
>
> +struct CHANGE_CONFIG
> +{
> +    union
> +    {
> +        struct
> +        {
> +            uint32_t limit_single_process : 1;
> +            uint32_t reserved : 31;
> +        }bits;
> +        uint32_t all;
> +    }option;
> +};
> +
> +
>  union MESAPI__MISC {
>         struct {
>                 union MES_API_HEADER    header;
> @@ -631,6 +660,7 @@ union MESAPI__MISC {
>                         struct          WAIT_REG_MEM wait_reg_mem;
>                         struct          SET_SHADER_DEBUGGER set_shader_de=
bugger;
>                         enum MES_AMD_PRIORITY_LEVEL queue_sch_level;
> +                       struct          CHANGE_CONFIG change_config;
>
>                         uint32_t        data[MISC_DATA_MAX_SIZE_IN_DWORDS=
];
>                 };
> diff --git a/drivers/gpu/drm/amd/include/mes_v12_api_def.h b/drivers/gpu/=
drm/amd/include/mes_v12_api_def.h
> index 101e2fe962c6..62df832810ca 100644
> --- a/drivers/gpu/drm/amd/include/mes_v12_api_def.h
> +++ b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
> @@ -643,6 +643,10 @@ enum MESAPI_MISC_OPCODE {
>         MESAPI_MISC__SET_SHADER_DEBUGGER,
>         MESAPI_MISC__NOTIFY_WORK_ON_UNMAPPED_QUEUE,
>         MESAPI_MISC__NOTIFY_TO_UNMAP_PROCESSES,
> +       MESAPI_MISC__QUERY_HUNG_ENGINE_ID,
> +       MESAPI_MISC__CHANGE_CONFIG,
> +       MESAPI_MISC__LAUNCH_CLEANER_SHADER,
> +       MESAPI_MISC__SETUP_MES_DBGEXT,
>
>         MESAPI_MISC__MAX,
>  };
> @@ -713,6 +717,34 @@ struct SET_GANG_SUBMIT {
>         uint32_t slave_gang_context_array_index;
>  };
>
> +enum MESAPI_MISC__CHANGE_CONFIG_OPTION
> +{
> +       MESAPI_MISC__CHANGE_CONFIG_OPTION_LIMIT_SINGLE_PROCESS =3D 0,
> +       MESAPI_MISC__CHANGE_CONFIG_OPTION_ENABLE_HWS_LOGGING_BUFFER =3D 1=
,
> +       MESAPI_MISC__CHANGE_CONFIG_OPTION_CHANGE_TDR_CONFIG    =3D 2,
> +
> +       MESAPI_MISC__CHANGE_CONFIG_OPTION_MAX =3D 0x1F
> +};
> +
> +struct CHANGE_CONFIG
> +{
> +       enum MESAPI_MISC__CHANGE_CONFIG_OPTION opcode;
> +       union {
> +               struct  {
> +                       uint32_t limit_single_process : 1;
> +                       uint32_t enable_hws_logging_buffer : 1;
> +                       uint32_t reserved : 30;
> +               }bits;
> +               uint32_t all;
> +       } option;
> +
> +       struct {
> +               uint32_t tdr_level;
> +               uint32_t tdr_delay;
> +       } tdr_config;
> +};
> +
> +
>  union MESAPI__MISC {
>         struct {
>                 union MES_API_HEADER    header;
> @@ -726,7 +758,7 @@ union MESAPI__MISC {
>                         struct WAIT_REG_MEM wait_reg_mem;
>                         struct SET_SHADER_DEBUGGER set_shader_debugger;
>                         enum MES_AMD_PRIORITY_LEVEL queue_sch_level;
> -
> +                       struct CHANGE_CONFIG change_config;
>                         uint32_t data[MISC_DATA_MAX_SIZE_IN_DWORDS];
>                 };
>                 uint64_t                timestamp;
> --
> 2.34.1
>
