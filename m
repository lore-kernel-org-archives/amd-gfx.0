Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E51DE8536E
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2026 13:58:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C23B10E4C0;
	Fri,  3 Apr 2026 13:58:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eA0faHic";
	dkim-atps=neutral
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87DD810E336
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Apr 2026 13:58:39 +0000 (UTC)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-2cb19ddda43so144259eec.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 03 Apr 2026 06:58:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775224719; cv=none;
 d=google.com; s=arc-20240605;
 b=Bz0Hsi/3BHQjxJWTfuht4+TxpzmBV/wbEq1zRZgkvws+o0cmRobFoYK2H4DXKrVPvN
 jSF2j4HxW8NuydhqCelDkt0OHGIxvEVujUUh9w7nHGta6Aq8HR0H2uzbulPM+RIxur77
 4iCeY4Bn2338pC5E42ZEvX1a5OvbOG9y7MVUsgmDou4wP+9QfhgneofIJWTuf1ca2T3H
 D7I9JFs3RJ0yX8Rgb1xM6aXSnYrxCP9RyOiXp6pRlxs4liPZ1S5Gx3WnlXU0WCIWawXZ
 Yq4vG+FZpPwnNNC4IbA8QjAyugNmOl5hPvDjQv5cXdLNIk+CAq/0/E59hWsCMYHSWifa
 Kmwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=E/8MLjB597InPhhmW9JbLbwR8LfCAxtR7ZWCpA3gxaY=;
 fh=s222Lb767PwB4WWFm8MmZPwm2fNuW2emQPOz3qHIGAc=;
 b=FI/7wMeBuW86g7Hk5Q32Dd2Wm6kONfM//kIh7ivEvMbDUEQEwGGG0oAMO0AVsVLnwi
 7l3BCL2/0b4+8XZ36lg+Pyzt2pRkrTlarB0iOxj88m3mJHwbz/KtIKQEilSedSckpGAz
 aJFMjjf5Dn/YqzHbG6izGNiEX8lriGGkNq6fXavGnvwC9HBMG8vRTp1OflEVXV8e2l6u
 RyJIhMgVrUewvArOKrP2JKKUScWOUDF0oy0XTXe1ABIsMVQRmhZRrYcx5NcnT8rb31Wq
 ndnzrfSI9fp89SYoZyyf40ZwdD1nA6lzbgaqGulmhtC4fQKEDQYT9ZTNj9qen0LxXkVU
 J/iQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775224719; x=1775829519; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E/8MLjB597InPhhmW9JbLbwR8LfCAxtR7ZWCpA3gxaY=;
 b=eA0faHic0JBL4DRSNvoHSXH2r7SgPznK7xa3bW7pDy6Vi8lqm4yHlYIgroTYuXVZ4L
 580FvF8EyVShq08W06okh4l5jdYabSlmEqCSJFoU3fieP/I4XfV8t3bEIidFW6NholpP
 NvbBYzOS1VozbHpzZim/Xqms/fGYv3D2ePlxzro0M94Unu0hQ0KtECjTfVgw+5dxX3gz
 H4I4CbQngcw9ISIHnmaVSDMU2vZwKC5hdN+zYYNCJi/iBMxlMYOr756pFPu+Xf9Siypd
 OfxGLZMDUF2yw+bDvfZwrRT5/E92kFVM21SeOYDeWMkIqQbMMDiBe1e92RpwKIsgeJ/A
 6P4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775224719; x=1775829519;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=E/8MLjB597InPhhmW9JbLbwR8LfCAxtR7ZWCpA3gxaY=;
 b=MnENviHpClAJmicAVQskdbQxI0vsBSdAnx4SN6aIs84AxsbycAEmOv1Ksx3hdmWDxn
 0UkPbv44prYoOqV2SX6u3dhxXl6Z8elMAFK16Rf2BI2NR/nKoWBKmsIvPexv76cYE/GM
 vN+BfFg0IMmv08oQcBj2IzXvZa0iOW5+oEkzdLlPRIM/4J8nmzkOrI9hFH8NOxQkEAaM
 EIRPnY69yUgZmuMZtB2htgHmxD5bvKkrPTJkHu7TElhCwzptG0kD7kkOJq0DS8DjT6pk
 TiZNTvSPDB4SQoqCR578PHgu+tC0jRilg9t8HPSDzALJkJbIEHG6n3BPwgv6WjFh2rgq
 3Pxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFx7Q006g6oO6ZV+jOyxApG/T40gO8J4izbRY3dsUT/k8w0hRFxOkaMJ1hkty9mQaTqU+8Qr73@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz2FucUTb3Fq2c5C+L2qkWrPkheUOX3qduaDh5e9XDrLsF34tph
 PKuBtuaLe+9D+DKxOhqzGwXYgNE3nxztWb7hqpjErpCG4a5MN4egj9I2u9/cASqtBv8QxmRQThY
 6pbAaOrhBugXfM1iH9/hrCwBUXGx/Or8=
X-Gm-Gg: ATEYQzwdJ11HqVNPzen36mUw0iI+/bW6/jn42wyBuSkEJJFwQ1IOMQfkKInpUQ58WZu
 DTMN/ELwjk0q2ASnbvDoDKcCV3w24LBeiiGBprIaS7Ai22jEvcc9DPUOiskmjVYudFZyjljYHdd
 T2/aHjnUkc13+HwgmTCIv4eSlhKnu4fekmGgSnJkGhnYxdyWj4+bSVqqdSxVIqLb/r131fBwKbD
 8W0uwMFYWCsf/TIiX4Z5JqiAlKZAa4tmbUVz2T/A4h2iG8JIMIkANCKZ2qGPQrmnrMPCT4t38tG
 fnDBFWBQy22+/5patSuH5wA9oaB5pSDQ6P8KYa/WbjXFVVcPswTDYyFeHj4KzjWUAw4uTwBqZxl
 0O+Tq
X-Received: by 2002:a05:7022:90e:b0:119:e56b:c3f1 with SMTP id
 a92af1059eb24-12bfb6e47a0mr628241c88.1.1775224718662; Fri, 03 Apr 2026
 06:58:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260403082207.1533450-1-linus.probert@gmail.com>
 <20260403082207.1533450-3-linus.probert@gmail.com>
In-Reply-To: <20260403082207.1533450-3-linus.probert@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 3 Apr 2026 09:58:25 -0400
X-Gm-Features: AQROBzD4l2RuNXAWnyj10hqszozqRGOPyGhrLSo3OBrCysDjTXcQaYtTn5jK3PM
Message-ID: <CADnq5_NQPhgfuuawBQ+ZQY-aFxx7jFu16szgNE50+bbKHNx+bA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amd/display: Remove unused NUM_ELEMENTS macros
To: Linus Probert <linus.probert@gmail.com>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 "Robert P. J. Day" <rpjday@crashcourse.ca>
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

Applied the series.  Thanks!

On Fri, Apr 3, 2026 at 5:29=E2=80=AFAM Linus Probert <linus.probert@gmail.c=
om> wrote:
>
> Removes unused NUM_ELEMENTS macros. Discovered while removing cases
> where ARRAY_SIZE from the header <linus/array_size.h> can be used.
> This also aligns with the array_size.cocci coccinelle check.
>
> Suggested-by: Robert P. J. Day <rpjday@crashcourse.ca>
> Signed-off-by: Linus Probert <linus.probert@gmail.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp_cm.c   | 3 ---
>  drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c | 3 ---
>  drivers/gpu/drm/amd/display/dc/mpc/dcn20/dcn20_mpc.c      | 2 --
>  drivers/gpu/drm/amd/display/dc/mpc/dcn30/dcn30_mpc.c      | 4 ----
>  4 files changed, 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp_cm.c b/dr=
ivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp_cm.c
> index f8f6019d8304..2bdd063cc1e1 100644
> --- a/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp_cm.c
> +++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp_cm.c
> @@ -49,9 +49,6 @@
>  #define FN(reg_name, field_name) \
>         dpp->tf_shift->field_name, dpp->tf_mask->field_name
>
> -#define NUM_ELEMENTS(a) (sizeof(a) / sizeof((a)[0]))
> -
> -
>  enum dcn10_coef_filter_type_sel {
>         SCL_COEF_LUMA_VERT_FILTER =3D 0,
>         SCL_COEF_LUMA_HORZ_FILTER =3D 1,
> diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c b/=
drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c
> index 62bf7cea21d8..7b7a0c660d47 100644
> --- a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c
> +++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c
> @@ -49,9 +49,6 @@
>  #define FN(reg_name, field_name) \
>         dpp->tf_shift->field_name, dpp->tf_mask->field_name
>
> -#define NUM_ELEMENTS(a) (sizeof(a) / sizeof((a)[0]))
> -
> -
>  enum dcn401_coef_filter_type_sel {
>         SCL_COEF_LUMA_VERT_FILTER =3D 0,
>         SCL_COEF_LUMA_HORZ_FILTER =3D 1,
> diff --git a/drivers/gpu/drm/amd/display/dc/mpc/dcn20/dcn20_mpc.c b/drive=
rs/gpu/drm/amd/display/dc/mpc/dcn20/dcn20_mpc.c
> index ea73473b970a..fa600593f4c1 100644
> --- a/drivers/gpu/drm/amd/display/dc/mpc/dcn20/dcn20_mpc.c
> +++ b/drivers/gpu/drm/amd/display/dc/mpc/dcn20/dcn20_mpc.c
> @@ -43,8 +43,6 @@
>  #define FN(reg_name, field_name) \
>         mpc20->mpc_shift->field_name, mpc20->mpc_mask->field_name
>
> -#define NUM_ELEMENTS(a) (sizeof(a) / sizeof((a)[0]))
> -
>  void mpc2_update_blending(
>         struct mpc *mpc,
>         struct mpcc_blnd_cfg *blnd_cfg,
> diff --git a/drivers/gpu/drm/amd/display/dc/mpc/dcn30/dcn30_mpc.c b/drive=
rs/gpu/drm/amd/display/dc/mpc/dcn30/dcn30_mpc.c
> index 6bfd2c1294e5..ec2181d9f20b 100644
> --- a/drivers/gpu/drm/amd/display/dc/mpc/dcn30/dcn30_mpc.c
> +++ b/drivers/gpu/drm/amd/display/dc/mpc/dcn30/dcn30_mpc.c
> @@ -40,10 +40,6 @@
>  #define FN(reg_name, field_name) \
>         mpc30->mpc_shift->field_name, mpc30->mpc_mask->field_name
>
> -
> -#define NUM_ELEMENTS(a) (sizeof(a) / sizeof((a)[0]))
> -
> -
>  void mpc3_mpc_init(struct mpc *mpc)
>  {
>         struct dcn30_mpc *mpc30 =3D TO_DCN30_MPC(mpc);
> --
> 2.53.0
>
