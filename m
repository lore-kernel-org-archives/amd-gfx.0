Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1834CD3B7EA
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Dec 2025 18:05:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B04E210E186;
	Mon,  8 Dec 2025 18:05:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HJcgzPXi";
	dkim-atps=neutral
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 291C610E186
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Dec 2025 18:05:22 +0000 (UTC)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-bda175a2013so515596a12.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 08 Dec 2025 10:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765217121; x=1765821921; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qq4lkrrl4IC0Ie5WIg1XLdGb6iMzEHVhXn5Xjw9+fYw=;
 b=HJcgzPXiDNQ1lPYfFMjlXu1nBVV7s1MsnFm2cFNK29NOh+RUyEudGtZWv5PAb0QQmN
 NpqRE0OnQd5oiUBOopQpH3wYlFU8swS9hdACa5to1ZA9dcmIBHWP7LrZVrdbZ+YYoxrp
 /OnyrMAQrNBlIkIgr4v2FiCRy+1AKAP2jzNu3Ob9DVRJoXVaxswln/DzwquxRt1fZHPH
 Mxk+dgnn7I375DM2oz4KLP8FXB6E5Of5E25h1fHmHTc84STcofz8BNK3PZG8b5CLVbf9
 NeYY9jGEXThM+exBCk0IUiwgOMpflGaMegAqJEWxFkiN+DXq9CyI71GWVuQ7QJeHIIKP
 0AGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765217121; x=1765821921;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Qq4lkrrl4IC0Ie5WIg1XLdGb6iMzEHVhXn5Xjw9+fYw=;
 b=DrdrXdeDwug4BiVMr9VDt2v4BiCCV350yHg+stAc07eHOoTprOuvuLkWansi/TEC1X
 B/7cjmqsdEMzEHMzlos4oAPguCFmkc7dbvi5Q6P9j51I05lh7mBElXMwRqNI49gQqr2v
 mvqTAcBRSPC7HrDY9QxoOB96gp0OtPBqM+L9V2shSWKCdRPXZZmmybb+o50e/w2EJwAw
 aFZ0TCn+NigNY6BVqV3s4s4TVbAO/QNLWjX/LqKRJlsIcALbjeA7qpzFZghVtcQZUT3J
 TAFtNTIaxHT3nkdBep90WlDsOIbCX94suAQVFbNLTT8YQt9qIJRN46hO5iYdkXG2D72C
 rx6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLsLCBRc2BnHPMPUY60SX1owXvSY4Qc4P683Yg96yjMkI7vu9+I9oT735c/BRux9nolfbRqbat@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxLQhdM+nVtDC26jpZWtLqK9C8rA21kZ7+ib4Yrmia68IRIivpn
 RajOsjEaB0J1ZUDwrrARrsAK69PPb1s4vYeCWFmE2KYN/uM4pe6qzQmPWRwrP2k5r/ADcIjxcAJ
 d+sD71f4zcUw4UhOK3ommJY5POgVEXbg=
X-Gm-Gg: ASbGncso9E4eAaMSse2yXp27vkqVlNx0aSdH7sewgHLXEqQhgdldSIcHtZ2KswxPo7Q
 +bNhhpmbGpy5+MIvUfcIk+Cc2c5CFSuwczzTUuHjQrUBkklmnqPiyUQGfKaQmrYDD8BdLeujbjL
 FkG4nA8dXhCjvuo4udqHz9IeYDaQmcEkFKAv/Yufvgbt/154dCBqL334A3JQn1O5fQg2FnrAeJJ
 hxdk/Ns4gUiPNpRZx+cr+QyUbng1w/61Mim14tlHq9USN3pbz5YQ6qIqJ1t9HisU9W1r5U=
X-Google-Smtp-Source: AGHT+IHeYjD1Ebtw+AL8vxxvxzVl+vP0MlkDL0WEgN+bjJaA2DGm/b3errYMOGGdEX/mEu5M96O0Ifk3Sx492SLBWOM=
X-Received: by 2002:a05:7301:22a3:b0:2a4:3593:5fc7 with SMTP id
 5a478bee46e88-2abf31638bemr28351eec.1.1765217121393; Mon, 08 Dec 2025
 10:05:21 -0800 (PST)
MIME-Version: 1.0
References: <20251205121345.408427-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20251205121345.408427-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 8 Dec 2025 13:05:09 -0500
X-Gm-Features: AQt7F2qqjNZ6awZUP6-xANf0SXqiPCWUizr76IO84UaAXe-UGFysrnsuz8bp4VE
Message-ID: <CADnq5_NMLBZs9=o9+R+Rasdx88NRm8cwOvLiJ3LsAGnqUsd8jg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/acpi: Reduce amdgpu_acpi_detect stack usage
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Fri, Dec 5, 2025 at 11:29=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> amdgpu_acpi_detect() calls some helper functions it calls have large
> local structures.  When the compiler inlines these helpers, their local
> data adds to the amdgpu_acpi_detect() stack frame.
>
> Mark the helpers with noinline_for_stack:
> - amdgpu_atif_verify_interface()
> - amdgpu_atif_get_notification_params()
> - amdgpu_atif_query_backlight_caps()
> - amdgpu_atcs_verify_interface()
> - amdgpu_acpi_enumerate_xcc()
>
> This keeps the large temporary objects inside the helper=E2=80=99s own st=
ack
> frame instead of being inlined into the caller, preventing the caller
> from growing beyond the stack limit.
>
> Fixes the below with gcc W=3D1:
> drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c:1403:6: warning: stack frame siz=
e (1688) exceeds limit (1024) in 'amdgpu_acpi_detect' [-Wframe-larger-than]
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_acpi.c
> index d8a4e918846c..61aa0ebec63e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -241,7 +241,8 @@ static void amdgpu_atif_parse_functions(struct amdgpu=
_atif_functions *f, u32 mas
>   * (all asics).
>   * returns 0 on success, error on failure.
>   */
> -static int amdgpu_atif_verify_interface(struct amdgpu_atif *atif)
> +static noinline_for_stack
> +int amdgpu_atif_verify_interface(struct amdgpu_atif *atif)
>  {
>         union acpi_object *info;
>         struct atif_verify_interface output;
> @@ -286,7 +287,8 @@ static int amdgpu_atif_verify_interface(struct amdgpu=
_atif *atif)
>   * where n is specified in the result if a notifier is used.
>   * Returns 0 on success, error on failure.
>   */
> -static int amdgpu_atif_get_notification_params(struct amdgpu_atif *atif)
> +static noinline_for_stack
> +int amdgpu_atif_get_notification_params(struct amdgpu_atif *atif)
>  {
>         union acpi_object *info;
>         struct amdgpu_atif_notification_cfg *n =3D &atif->notification_cf=
g;
> @@ -354,7 +356,8 @@ static int amdgpu_atif_get_notification_params(struct=
 amdgpu_atif *atif)
>   *
>   * Returns 0 on success, error on failure.
>   */
> -static int amdgpu_atif_query_backlight_caps(struct amdgpu_atif *atif)
> +static noinline_for_stack
> +int amdgpu_atif_query_backlight_caps(struct amdgpu_atif *atif)
>  {
>         union acpi_object *info;
>         struct atif_qbtc_output characteristics;
> @@ -601,7 +604,8 @@ static void amdgpu_atcs_parse_functions(struct amdgpu=
_atcs_functions *f, u32 mas
>   * (all asics).
>   * returns 0 on success, error on failure.
>   */
> -static int amdgpu_atcs_verify_interface(struct amdgpu_atcs *atcs)
> +static noinline_for_stack
> +int amdgpu_atcs_verify_interface(struct amdgpu_atcs *atcs)
>  {
>         union acpi_object *info;
>         struct atcs_verify_interface output;
> @@ -1090,7 +1094,8 @@ static int amdgpu_acpi_get_xcc_info(struct amdgpu_a=
cpi_xcc_info *xcc_info,
>         return ret;
>  }
>
> -static int amdgpu_acpi_enumerate_xcc(void)
> +static noinline_for_stack
> +int amdgpu_acpi_enumerate_xcc(void)
>  {
>         struct amdgpu_acpi_dev_info *dev_info =3D NULL;
>         struct amdgpu_acpi_xcc_info *xcc_info;
> --
> 2.34.1
>
