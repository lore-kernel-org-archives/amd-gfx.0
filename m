Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59130C4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Apr 2024 04:16:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC07410E9B7;
	Fri, 12 Apr 2024 04:16:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Rv/HuzII";
	dkim-atps=neutral
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CB7A10E9B7
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Apr 2024 04:16:21 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-5ce2aada130so380183a12.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Apr 2024 21:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712895381; x=1713500181; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QeiK1OA7s9ppiF5SBNrPlZzc7kg87iU2UAxGy6GEP9A=;
 b=Rv/HuzIIwb06VwKAePeFw3/xXxPsRPX+mwRR+nCxFMgO6ycrQsW3giHndKlGe3HXLd
 ve75M+7Bz06bLMiI1fHU6zGA8bOpTJcjrto/AfunbHPDBQrn7El2WnTkNagrvWQP9B+5
 3uVXyD4raRiJDV5KeWl5fufelF8ojDADxxVlpDaP4NGraA3//suQ0YfYmXyaps6cFIWR
 OX9wM7CDHGn2bvrQ7wsRpC3cLnsHnZmOylIQv+i9cJ/zFwCqRLC4aDp4bQbH/R9XtLrm
 xzz4bjAZuFTOBw1GyiW3HsaGByjddOQP58nzqtlLFq2mIco27hv2lZ2aPTQHS/Y3EMOk
 7c+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712895381; x=1713500181;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QeiK1OA7s9ppiF5SBNrPlZzc7kg87iU2UAxGy6GEP9A=;
 b=SRSqoOlNxTsBW32jg5l93tT5BR8AApLPGzvuihXzYxo1F2FQ5JlpbmkeNYQFy6K79B
 2iFlO6mLL1SkdXcDALsrrc7x4Zej3p/gxODnn2LssVGlZXkZwbr511MUDEy5SdIbxjeM
 p7Vvi4LXuEDbg/UBpTJJ6wiLJG/hF7/oCEanOOQbXFUXDJiXHQgg/SrgwcS9OtizgRh4
 2GB6Uwx4udHn1+PEn14xBhXszh/zpFSfC0WPmZALw226E0+g6Sc7uiJ9EZk0NutzEwb2
 dZFW4UFl5rNMA5bk79bdkPYjU5RMPZU7uI2cAjlsciSCsatonwJlG14oRc9AsT24NuuC
 TPzg==
X-Gm-Message-State: AOJu0YyOqXCKVs28wNXrHQolMjSngViT3/SRZaRcRGNvarIbz2QD3zC0
 k4E8u3ShZYng2VP2hEQGmrMLVbjEenGsAbWfg4NJ7PECwnFIWDU7lyoNZBmnJrr820nIMzF7/74
 +YRoLGBo6MJgP6+Bibo1Rp3Du7xI=
X-Google-Smtp-Source: AGHT+IEJR61S42QE9KALcJG9SNtOr+1yx2Pg+KXhDnhGFHiAdOwCgvYCWOxT6cj25uu/59dPEyJUgMUvA0O76F7QJhA=
X-Received: by 2002:a17:90b:4b45:b0:2a2:f9d:f600 with SMTP id
 mi5-20020a17090b4b4500b002a20f9df600mr1427716pjb.22.1712895380792; Thu, 11
 Apr 2024 21:16:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240408182503.364555-1-alexander.deucher@amd.com>
In-Reply-To: <20240408182503.364555-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 12 Apr 2024 00:16:09 -0400
Message-ID: <CADnq5_Mjok74uWL=bbn-E9BDr=f5D4zPfOop5L669qY9n_cOWQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/mes11: print MES opcodes rather than numbers
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

On Mon, Apr 8, 2024 at 3:02=E2=80=AFPM Alex Deucher <alexander.deucher@amd.=
com> wrote:
>
> Makes it easier to review the logs when there are MES
> errors.
>
> v2: use dbg for emitted, add helpers for fetching strings
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 78 ++++++++++++++++++++++++--
>  1 file changed, 74 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v11_0.c
> index 072c478665ade..69d39ba726e12 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -100,18 +100,72 @@ static const struct amdgpu_ring_funcs mes_v11_0_rin=
g_funcs =3D {
>         .insert_nop =3D amdgpu_ring_insert_nop,
>  };
>
> +static const char *mes_v11_0_opcodes[] =3D {
> +       "MES_SCH_API_SET_HW_RSRC",
> +       "MES_SCH_API_SET_SCHEDULING_CONFIG",
> +       "MES_SCH_API_ADD_QUEUE"
> +       "MES_SCH_API_REMOVE_QUEUE"
> +       "MES_SCH_API_PERFORM_YIELD"
> +       "MES_SCH_API_SET_GANG_PRIORITY_LEVEL"
> +       "MES_SCH_API_SUSPEND"
> +       "MES_SCH_API_RESUME"
> +       "MES_SCH_API_RESET"
> +       "MES_SCH_API_SET_LOG_BUFFER"
> +       "MES_SCH_API_CHANGE_GANG_PRORITY"
> +       "MES_SCH_API_QUERY_SCHEDULER_STATUS"
> +       "MES_SCH_API_PROGRAM_GDS"
> +       "MES_SCH_API_SET_DEBUG_VMID"
> +       "MES_SCH_API_MISC"
> +       "MES_SCH_API_UPDATE_ROOT_PAGE_TABLE"
> +       "MES_SCH_API_AMD_LOG"
> +};
> +
> +static const char *mes_v11_0_misc_opcodes[] =3D {
> +       "MESAPI_MISC__WRITE_REG",
> +       "MESAPI_MISC__INV_GART",
> +       "MESAPI_MISC__QUERY_STATUS",
> +       "MESAPI_MISC__READ_REG",
> +       "MESAPI_MISC__WAIT_REG_MEM",
> +       "MESAPI_MISC__SET_SHADER_DEBUGGER",
> +};
> +
> +static const char *mes_v11_0_get_op_string(union MESAPI__MISC *x_pkt)
> +{
> +       const char *op_str =3D NULL;
> +
> +       if (x_pkt->header.opcode < ARRAY_SIZE(mes_v11_0_opcodes))
> +               op_str =3D mes_v11_0_opcodes[x_pkt->header.opcode];
> +
> +       return op_str;
> +}
> +
> +static const char *mes_v11_0_get_misc_op_string(union MESAPI__MISC *x_pk=
t)
> +{
> +       const char *op_str =3D NULL;
> +
> +       if ((x_pkt->header.opcode =3D=3D MES_SCH_API_MISC) &&
> +           (x_pkt->opcode <=3D ARRAY_SIZE(mes_v11_0_misc_opcodes)))
> +               op_str =3D mes_v11_0_misc_opcodes[x_pkt->opcode];
> +
> +       return op_str;
> +}
> +
>  static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *m=
es,
>                                                     void *pkt, int size,
>                                                     int api_status_off)
>  {
>         int ndw =3D size / 4;
>         signed long r;
> -       union MESAPI__ADD_QUEUE *x_pkt =3D pkt;
> +       union MESAPI__MISC *x_pkt =3D pkt;
>         struct MES_API_STATUS *api_status;
>         struct amdgpu_device *adev =3D mes->adev;
>         struct amdgpu_ring *ring =3D &mes->ring;
>         unsigned long flags;
>         signed long timeout =3D adev->usec_timeout;
> +       const char *op_str, *misc_op_str;
> +
> +       if (x_pkt->header.opcode >=3D MES_SCH_API_MAX)
> +               return -EINVAL;
>
>         if (amdgpu_emu_mode) {
>                 timeout *=3D 100;
> @@ -135,13 +189,29 @@ static int mes_v11_0_submit_pkt_and_poll_completion=
(struct amdgpu_mes *mes,
>         amdgpu_ring_commit(ring);
>         spin_unlock_irqrestore(&mes->ring_lock, flags);
>
> -       DRM_DEBUG("MES msg=3D%d was emitted\n", x_pkt->header.opcode);
> +       op_str =3D mes_v11_0_get_op_string(x_pkt);
> +       misc_op_str =3D mes_v11_0_get_misc_op_string(x_pkt);
> +
> +       if (misc_op_str)
> +               dev_dbg(adev->dev, "MES msg=3D%s (%s) was emitted\n", op_=
str, misc_op_str);
> +       else if (op_str)
> +               dev_dbg(adev->dev, "MES msg=3D%s was emitted\n", op_str);
> +       else
> +               dev_dbg(adev->dev, "MES msg=3D%d was emitted\n", x_pkt->h=
eader.opcode);
>
>         r =3D amdgpu_fence_wait_polling(ring, ring->fence_drv.sync_seq,
>                       timeout);
>         if (r < 1) {
> -               DRM_ERROR("MES failed to response msg=3D%d\n",
> -                         x_pkt->header.opcode);
> +
> +               if (misc_op_str)
> +                       dev_err(adev->dev, "MES failed to respond to msg=
=3D%s (%s)\n",
> +                               op_str, misc_op_str);
> +               else if (op_str)
> +                       dev_err(adev->dev, "MES failed to respond to msg=
=3D%s\n",
> +                               op_str);
> +               else
> +                       dev_err(adev->dev, "MES failed to respond to msg=
=3D%d\n",
> +                               x_pkt->header.opcode);
>
>                 while (halt_if_hws_hang)
>                         schedule();
> --
> 2.44.0
>
