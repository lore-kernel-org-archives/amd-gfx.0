Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDEC5C3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jan 2024 14:31:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8732E10E0AE;
	Wed,  3 Jan 2024 14:31:42 +0000 (UTC)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F19E10E0AE
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jan 2024 14:31:40 +0000 (UTC)
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-20451ecbb80so5288525fac.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 03 Jan 2024 06:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704292300; x=1704897100; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LbQ1Bat31yh1IyinMJYrf1fwn/zKqs3qi153WWFhhQA=;
 b=Yhc21t63dqH5TkDcJ6U6qbWVsmM11pXZGlXkJSVpgClSpZ2aqECSmKJASAto1YxhRQ
 ECcrp9Et8J8VTdST1eNeFsmyKBN/Pegbvhpp1VwrnWc02ws2/dmlkW3TVk6nhusmYDu8
 wxTTbtiI4whzzxkjlN+w/3WpvBzgMBtU66peV/biqQF8W2dUx+IqYZhRJ0V/wmg6CSS5
 T5V/00xKMG8lrugpocmAwMrtMlVr7fl0Lx0aqjb9IHlmXq0lrsqxHZJk4e73IP4KwmdN
 ZUZvCnRrHIvdvufCBEZthM6ufoFig4Q/d/zO2VXwo8qOqfmiPEU3d3FN8L3h+usTHhLy
 XgxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704292300; x=1704897100;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LbQ1Bat31yh1IyinMJYrf1fwn/zKqs3qi153WWFhhQA=;
 b=uIf/565L8W/MqTNM0mA/ihXDIUObkQXqMLuA9pETULaed9RxpPn35rZruRZ7T73osG
 Fkgw6IF2CZ/KZJFy0vNqdEDDa/Jra40+I7jyhQyoITWUtiMHmo8I+qU6LiTVqVvJdGL3
 vx4dTfYUy1kX4N7hYS5iI/mv0zGCaiOBriO2yvTKperDw3Y40okCirhB9anqM9VF71mv
 9IgxiqD7mSbNu7fsellVsqIa9sDIE4ubSvKjEGZb1EqrStxuVDwCAQDsLd7uU2pikgmw
 gJHCCTF5fErbI9AdNkTOuw5pEj/Js4ctdQqAqtwfyqjcwZa6GdYE7pjwgheFelENWjDa
 PVRA==
X-Gm-Message-State: AOJu0YzH1m0MJvBkazMl8FNW07sOdxQeWFB3mOdAbJRpOLRYVbGqhlP+
 DBgOOBh3x90PMuaunsgcCXozua/uDjZhhBXAGSM=
X-Google-Smtp-Source: AGHT+IH7xD7iqwBlFdmEdHzo3dfEomLmxyukxzwNexzK/bO62PFpi+907JMo13tCdHu5ccs8qjyhhS9O1BEP7AEpK3Y=
X-Received: by 2002:a05:6870:4149:b0:203:5ce2:cd41 with SMTP id
 r9-20020a056870414900b002035ce2cd41mr16831169oad.72.1704292299863; Wed, 03
 Jan 2024 06:31:39 -0800 (PST)
MIME-Version: 1.0
References: <20231229174156.1800-1-marcelomspessoto@gmail.com>
 <20231229174156.1800-2-marcelomspessoto@gmail.com>
In-Reply-To: <20231229174156.1800-2-marcelomspessoto@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 3 Jan 2024 09:31:28 -0500
Message-ID: <CADnq5_M0NSy3juxRYsw6LrS1jure0bxjkVwNZnMVcAAASnGjcA@mail.gmail.com>
Subject: Re: [PATCH 1/7] drm/amd/display: Fix hdcp1_execution.c codestyle
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
> Remove braces from single statement if expression in hdcp1_execution.c
> file
>
> Signed-off-by: Marcelo Mendes Spessoto Junior <marcelomspessoto@gmail.com=
>
> ---
>  drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c b=
/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
> index 1ddb4f5ea..182e7532d 100644
> --- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
> +++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
> @@ -63,6 +63,7 @@ static inline enum mod_hdcp_status check_hdcp_capable_d=
p(struct mod_hdcp *hdcp)
>  static inline enum mod_hdcp_status check_r0p_available_dp(struct mod_hdc=
p *hdcp)
>  {
>         enum mod_hdcp_status status;
> +
>         if (is_dp_hdcp(hdcp)) {
>                 status =3D (hdcp->auth.msg.hdcp1.bstatus &
>                                 DP_BSTATUS_R0_PRIME_READY) ?
> @@ -131,9 +132,8 @@ static inline uint8_t get_device_count(struct mod_hdc=
p *hdcp)
>  static inline enum mod_hdcp_status check_device_count(struct mod_hdcp *h=
dcp)
>  {
>         /* Avoid device count =3D=3D 0 to do authentication */
> -       if (0 =3D=3D get_device_count(hdcp)) {
> +       if (get_device_count(hdcp) =3D=3D 0)
>                 return MOD_HDCP_STATUS_HDCP1_DEVICE_COUNT_MISMATCH_FAILUR=
E;
> -       }
>
>         /* Some MST display may choose to report the internal panel as an=
 HDCP RX.
>          * To update this condition with 1(because the immediate repeater=
's internal
> --
> 2.39.2
>
