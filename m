Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58500C3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jan 2024 14:36:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04FDC10E29B;
	Wed,  3 Jan 2024 14:36:20 +0000 (UTC)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FDBF10E29B
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jan 2024 14:36:18 +0000 (UTC)
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-2044ecf7035so5320174fac.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 03 Jan 2024 06:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704292577; x=1704897377; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mu3pDjy0Byjz+gBRKkBi0nBPeMmEouchXEnYU5yPVFs=;
 b=mE0fxgJJ07CRmQXwOiDjK4y5DCvHrf60TOienwOwOzuVtck3ePy09xpfb4VKr4Gelp
 uHk7h+xk3RtIRPCkUxEPWAjYW2VOUkdScxl+sTWc0iUB+M10mBKxCjRtsxSyA1hEhKiI
 ljcnIfqEBUtkCFfwIZBfTO2XB1Q1Jp0YqaTspw6by3LO+W8WzjxcEJO95hd2iGbeD5C+
 HOHrEOG9h4cS0uDSjzutnNolKEaMnydAmtG6OplnZ9gIOMFev4PryoxXhpb3o/yDQoCx
 k8p+eTcFbeMd5ykbO9t9HtXZDOMUtigCiG2xO6V/5IZObDBKWK8NOiTNgNV7fxSE+5gZ
 Zx7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704292577; x=1704897377;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mu3pDjy0Byjz+gBRKkBi0nBPeMmEouchXEnYU5yPVFs=;
 b=DqRgMbtkWl/TXEaZh4jLmfeuPX3+1rlQnVt6Z+g9DJdcvXWn8UXDGiKEgDbjq/MLI/
 N1iFgfiePTK5gejUcnhUZAeP6giYZvZp9k83YELk5u6bZVdq+CC1sK/WUcdEoQBmOQQe
 xwdPp+J2Lk85hIJNxbGUZGLyekJWS6BY9A2t9cJcgasdTvEvxfLhojRGFSni9uvKd3Zq
 8+AcNMHP3oleXbjfZouAiqRj1YGaMoWf8jY28ioV3HMunSjU5XP7HJ+sIylWRynrqThX
 J4eAyP5ixrYZCqAuReHlutP3C0V74JyAOLatY+d4qkytip7RkwOoTN0yLb+c4/LoStq/
 qlOA==
X-Gm-Message-State: AOJu0YydjdwcnW8ThuCC7flX3BSc4QRGeEBT7HjcQzNTtVdcjWy+nTCr
 D2BJzBFR95dcdI4NmeGOSkCeDWNqqCUctR8IsNGjzqZd
X-Google-Smtp-Source: AGHT+IG6PuCYV3bTxwSfzpRerywe0joHKYcVKI9YC7DLiUIMAjOi6QqfbjU1G2L6sf9Nrer7PjC1b56Frld5+F76vD8=
X-Received: by 2002:a05:6870:7f10:b0:203:bc5d:cf06 with SMTP id
 xa16-20020a0568707f1000b00203bc5dcf06mr23363603oab.72.1704292577540; Wed, 03
 Jan 2024 06:36:17 -0800 (PST)
MIME-Version: 1.0
References: <20231229174156.1800-1-marcelomspessoto@gmail.com>
 <20231229174156.1800-6-marcelomspessoto@gmail.com>
In-Reply-To: <20231229174156.1800-6-marcelomspessoto@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 3 Jan 2024 09:36:05 -0500
Message-ID: <CADnq5_N20+rQDTCG1dEgHgWgUuxiXvqy74t1kQuKQXQU2NFrdQ@mail.gmail.com>
Subject: Re: [PATCH 5/7] drm/amd/display: Fix hdcp2_execution.c codestyle
To: Marcelo Mendes Spessoto Junior <marcelomspessoto@gmail.com>
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
Cc: sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com, harry.wentland@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

On Fri, Dec 29, 2023 at 12:43=E2=80=AFPM Marcelo Mendes Spessoto Junior
<marcelomspessoto@gmail.com> wrote:
>
> Remove braces for single statement if expressions and change comparison
> order for hdcp2_execution.c file
>
> Signed-off-by: Marcelo Mendes Spessoto Junior <marcelomspessoto@gmail.com=
>
> ---
>  drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c b=
/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c
> index 91c22b96e..733f22bed 100644
> --- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c
> +++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c
> @@ -208,9 +208,8 @@ static inline uint8_t get_device_count(struct mod_hdc=
p *hdcp)
>  static enum mod_hdcp_status check_device_count(struct mod_hdcp *hdcp)
>  {
>         /* Avoid device count =3D=3D 0 to do authentication */
> -       if (0 =3D=3D get_device_count(hdcp)) {
> +       if (get_device_count(hdcp) =3D=3D 0)
>                 return MOD_HDCP_STATUS_HDCP1_DEVICE_COUNT_MISMATCH_FAILUR=
E;
> -       }
>
>         /* Some MST display may choose to report the internal panel as an=
 HDCP RX.   */
>         /* To update this condition with 1(because the immediate repeater=
's internal */
> @@ -689,9 +688,8 @@ static enum mod_hdcp_status validate_stream_ready(str=
uct mod_hdcp *hdcp,
>         if (is_hdmi_dvi_sl_hdcp(hdcp)) {
>                 if (!process_rxstatus(hdcp, event_ctx, input, &status))
>                         goto out;
> -               if (event_ctx->rx_id_list_ready) {
> +               if (event_ctx->rx_id_list_ready)
>                         goto out;
> -               }
>         }
>         if (is_hdmi_dvi_sl_hdcp(hdcp))
>                 if (!mod_hdcp_execute_and_set(check_stream_ready_availabl=
e,
> --
> 2.39.2
>
