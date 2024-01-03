Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D209C3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jan 2024 14:35:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9131910E322;
	Wed,  3 Jan 2024 14:35:03 +0000 (UTC)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99E4A10E322
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jan 2024 14:35:01 +0000 (UTC)
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-2041ed74956so197372fac.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 03 Jan 2024 06:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704292501; x=1704897301; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EFR76oXnrZWDGXmZ0jD3l+s1ps9ds+8hCmbsQW4GcK8=;
 b=jYJ7ZmfmFQ1ZC2+EpIn7jNH647/edhOLTWV9Md1MR7UJ/YB9l3irCWZ3HfcgcnuW6A
 Yey/IEBE14kWTK+ZN6u/+uoqK8/JXZY2U506sGm6tPlUF5TE1Bg6WckfWfDKmcPKzFuc
 AwGKr+MWETTLuynDCsfV43fj3sxtWJGRyHOLlUCV/JQS11qmbkEPJ4+fEbKqOcw/WTqq
 5UGqnsKUfWC8kLzWqle2QBzd5kvY0zA8ws33T4uVhYSGPlYr5jlzVqtJduxsCGoLu6MZ
 81Jxz1mbxy8Zt6nenWXY0hc9vAJ1lVjJWH5FixgIEge1TU2JKK9lwiBL4C1WfopUzvrV
 0BWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704292501; x=1704897301;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EFR76oXnrZWDGXmZ0jD3l+s1ps9ds+8hCmbsQW4GcK8=;
 b=OwQEyEZssIljfmOX0HBaAoCXjG1klVj/V5aqQrnagEFCkDRHzUQrK8tDwUzdXcFbf/
 3LncsO3z2MiM9ozfK6Ziojim/wZr0hxOweV/jGjCQF8x2dvmnRvuyB4DsiHHR9rEeWM6
 SyZItbXNXDldC1ECNTgiOASxq5W/2rtHurEEnTORMoODc6WzCjAgBzrV9OVxus4iKf/f
 4QxhaXj6lugZmE3E7H2MynY2nkDm5RPr95Vt/SMTyByGmYIcO1M5E+1iHzYC/PjQfkN6
 CTRGKtg11UqXCE2ZsUfa5QATcYFRxydirulXNqJGdHHIjfeUui0Qk7PqCNKv6E9NuA+3
 seUw==
X-Gm-Message-State: AOJu0YyM8LyN3rITw+ufJv1tBg1IooceaEztw5BTM+uU6qDIVqway9aw
 uAc12b/KbRUoTkygSiYI02ez+MkgzZts5n3awXI=
X-Google-Smtp-Source: AGHT+IEyQxn3iX3a6mzyOfvCnabRLPl/3TLl/97Nk08xEMEwCdL3Ox9LXx44cvm9B6XLvX9MNnnHhD1pnAb5Z+3eUrg=
X-Received: by 2002:a05:6871:3321:b0:204:2624:2827 with SMTP id
 nf33-20020a056871332100b0020426242827mr452616oac.43.1704292500800; Wed, 03
 Jan 2024 06:35:00 -0800 (PST)
MIME-Version: 1.0
References: <20231229174156.1800-1-marcelomspessoto@gmail.com>
 <20231229174156.1800-5-marcelomspessoto@gmail.com>
In-Reply-To: <20231229174156.1800-5-marcelomspessoto@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 3 Jan 2024 09:34:49 -0500
Message-ID: <CADnq5_PHZw26UfgPfODu7hS25KS16dtC9yES_LsjKw1dfR+8JQ@mail.gmail.com>
Subject: Re: [PATCH 4/7] drm/amd/display: Fix hdcp_psp.h codestyle
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
> Fix identation inside enum and place expressions in define macros inside
> () for hdcp_psp.h file
>
> Signed-off-by: Marcelo Mendes Spessoto Junior <marcelomspessoto@gmail.com=
>
> ---
>  drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.h b/driver=
s/gpu/drm/amd/display/modules/hdcp/hdcp_psp.h
> index 5b71bc96b..7844ea916 100644
> --- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.h
> +++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.h
> @@ -98,9 +98,9 @@ enum ta_dtm_encoder_type {
>   * This enum defines software value for dio_output_type
>   */
>  typedef enum {
> -    TA_DTM_DIO_OUTPUT_TYPE__INVALID,
> -    TA_DTM_DIO_OUTPUT_TYPE__DIRECT,
> -    TA_DTM_DIO_OUTPUT_TYPE__DPIA
> +       TA_DTM_DIO_OUTPUT_TYPE__INVALID,
> +       TA_DTM_DIO_OUTPUT_TYPE__DIRECT,
> +       TA_DTM_DIO_OUTPUT_TYPE__DPIA
>  } ta_dtm_dio_output_type;
>
>  struct ta_dtm_topology_update_input_v3 {
> @@ -237,11 +237,11 @@ enum ta_hdcp2_hdcp2_msg_id_max_size {
>  #define TA_HDCP__HDCP1_KSV_LIST_MAX_ENTRIES 127
>  #define TA_HDCP__HDCP1_V_PRIME_SIZE 20
>  #define TA_HDCP__HDCP2_TX_BUF_MAX_SIZE                                  =
                                               \
> -       TA_HDCP_HDCP2_MSG_ID_MAX_SIZE__AKE_NO_STORED_KM + TA_HDCP_HDCP2_M=
SG_ID_MAX_SIZE__AKE_STORED_KM + 6
> +       (TA_HDCP_HDCP2_MSG_ID_MAX_SIZE__AKE_NO_STORED_KM + TA_HDCP_HDCP2_=
MSG_ID_MAX_SIZE__AKE_STORED_KM + 6)
>
>  // 64 bits boundaries
>  #define TA_HDCP__HDCP2_RX_BUF_MAX_SIZE                                  =
                                               \
> -       TA_HDCP_HDCP2_MSG_ID_MAX_SIZE__AKE_SEND_CERT + TA_HDCP_HDCP2_MSG_=
ID_MAX_SIZE__AKE_RECEIVER_INFO + 4
> +       (TA_HDCP_HDCP2_MSG_ID_MAX_SIZE__AKE_SEND_CERT + TA_HDCP_HDCP2_MSG=
_ID_MAX_SIZE__AKE_RECEIVER_INFO + 4)
>
>  enum ta_hdcp_status {
>         TA_HDCP_STATUS__SUCCESS =3D 0x00,
> --
> 2.39.2
>
