Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17055C47DAF
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jan 2024 14:24:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2536C10E79B;
	Thu, 18 Jan 2024 14:24:47 +0000 (UTC)
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com
 [209.85.210.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2BEF10E79B
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jan 2024 14:24:45 +0000 (UTC)
Received: by mail-ot1-f49.google.com with SMTP id
 46e09a7af769-6dddfdc3244so6677515a34.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jan 2024 06:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705587825; x=1706192625; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WXlynkbPc87GnTbEue1AwQndh8/ubrQM/ORwLWOh1+U=;
 b=UlhEeiJm2yV/Bx8q81hWrHezZ/UhL+pTDz+YLuHfIT4StiYdCxPZ/yyxMkikv5QQ8X
 F0uu1vYIk8kiHR18MoJuftb65YSP/2kUYbCQpc4IJkIprmCOlxDWJq6uJ+KgheFGDVkF
 n29zyUA4JfjHiubU88VMJI0V6ee+jRYDrmHeHW/ZmPHdF4QrH0YTS8kS244Qt9hk8xJf
 XmKavAYtNj4C56La835mfFxHG/MUxcIcIn2I+XeJB/c4G5UXa+h72EoFwAZVDcZ2ogFK
 zdzC0nQeTDknAjHBSYsKorUT3N/QdMrazhUStNX0Zuh19qg1+ilsM18yYU2hcThqne8B
 ++PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705587825; x=1706192625;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WXlynkbPc87GnTbEue1AwQndh8/ubrQM/ORwLWOh1+U=;
 b=SOf7TclbyoL4xwsiOekaYVMNH5z4kmv/1a3n+ovPVYqTPDKqkhBWJstW/iktytsNIk
 PCevOJk9Byf5W3gpRxZ2FpT7DcVpTr8ReUxQBTjDdVR2AuUstiQTvPkbNvGCIfiXwHfl
 Fb+rIDUV2jJ4V3ejoQhFmW86sv8kkD3GCv7XK0wzs+LxkJBmJMuBfI2ZosqC6oyVXvwL
 MQtZlCaQE8HTif12eWguqXU4FLKHWmqCLa/FQljHeXjsoJqDQUhlOfNz3YZfwzsroNxR
 oDEoTRxke7JfI9JfvXbO5YZHolvDV7TdXi/Cvg9Yb/TBF2fxPvNOhD01ARx35xB06RC6
 J8Hg==
X-Gm-Message-State: AOJu0Yx4mkXffCzw7xzuJpPW85zOlAVQXaZNXMe/X5YcqOK5s52WEbhs
 MhlfPyquhmi87YXKM7QZVotkHCV0n3Ak6NtqoyeZ13EUNFCBFAhNJ0kHiYCIe+NQMKkXW/tL0uN
 0jPOLwbeR/OEyn17vbSXH4jM0x7Q=
X-Google-Smtp-Source: AGHT+IG/e2wbVo/OBeKQTq+CaEUeHGoMf74RsGUtoSIRAdB5Ef31BnrsjURAgsJFoImz43E58RFjgt7ga7BtpCGhtSM=
X-Received: by 2002:a05:6870:523:b0:210:7ade:ae35 with SMTP id
 j35-20020a056870052300b002107adeae35mr866826oao.89.1705587824985; Thu, 18 Jan
 2024 06:23:44 -0800 (PST)
MIME-Version: 1.0
References: <20240118135459.585306-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20240118135459.585306-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 18 Jan 2024 09:23:33 -0500
Message-ID: <CADnq5_Pr24=Ug9eAWPuAQzaT5fONEAYVotHkgUgcPkV4BV1gQw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Drop kdoc markers for some Panel Replay
 functions
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
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
Cc: Leo Li <sunpeng.li@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jan 18, 2024 at 9:22=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> Fixes the below gcc with W=3D1:
> drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_replay.c:262: warning: =
This comment starts with '/**', but isn't a kernel-doc comment. Refer Docum=
entation/doc-guide/kernel-doc.rst
>  * Set REPLAY power optimization flags and coasting vtotal.
> drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_replay.c:284: warning: =
This comment starts with '/**', but isn't a kernel-doc comment. Refer Docum=
entation/doc-guide/kernel-doc.rst
>  * send Replay general cmd to DMUB.
>
> Fixes: 340b072e38d3 ("drm/amd/display: Add some functions for Panel Repla=
y")
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c b/drivers/g=
pu/drm/amd/display/dc/dce/dmub_replay.c
> index 38e4797e9476..b010814706fe 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
> @@ -258,7 +258,7 @@ static void dmub_replay_residency(struct dmub_replay =
*dmub, uint8_t panel_inst,
>                 *residency =3D 0;
>  }
>
> -/**
> +/*
>   * Set REPLAY power optimization flags and coasting vtotal.
>   */
>  static void dmub_replay_set_power_opt_and_coasting_vtotal(struct dmub_re=
play *dmub,
> @@ -280,7 +280,7 @@ static void dmub_replay_set_power_opt_and_coasting_vt=
otal(struct dmub_replay *dm
>         dc_wake_and_execute_dmub_cmd(dc, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
>  }
>
> -/**
> +/*
>   * send Replay general cmd to DMUB.
>   */
>  static void dmub_replay_send_cmd(struct dmub_replay *dmub,
> --
> 2.34.1
>
