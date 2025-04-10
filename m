Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22066C3601E
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Apr 2025 15:21:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B27EF10E036;
	Thu, 10 Apr 2025 15:21:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WtGkDwUc";
	dkim-atps=neutral
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E480310E036
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Apr 2025 15:20:59 +0000 (UTC)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-af5f28ecbcaso159126a12.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Apr 2025 08:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744298459; x=1744903259; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WRr3AXG9wXOdKc8PJfAGvAIAN73Oi/LbNzedKG22EYs=;
 b=WtGkDwUcSupD8hf4/q1ioIOXO6+bQRNsLSI/44dYgpb6rwfwGJ0zszDKQ920cu8CQH
 iFH+IPjirx5qKzwmddFirpuwdHz+FpCAT8ztMhsFul8gneEJVlxJ5aj3xHPFdUZatZt4
 8sPGShptHL11m6jLzuC25rP4wif0IIiK+dGncbLvh+gKG+ckDjo6QrAEc1Ia9v2ljjWb
 Gl/cOJl49jRDYysZFZFpRaO1+EXTx6hNh29aCffhMTefSEs/T4O3Gxxf4Zw+JG0ynF/k
 6tZfN82I5fUYfK3HjOehzHixvJp1z/axv3noCEp+AyluP4SHFKyqO/DAVI9NIux9vhAP
 Q56A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744298459; x=1744903259;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WRr3AXG9wXOdKc8PJfAGvAIAN73Oi/LbNzedKG22EYs=;
 b=OP52Hqnb56RtHvqqCsfU6qvd6xkBZwA0QNzcryGz8uei0GLtfweUJWeDqHVaKtIvGG
 ptrRNACagTfT0Fwew+PYKRHFiOdlGG0iauCht+Ou+hhVnQnXzpmCcWMp43ec3i0QLAUF
 6kZtBGW5SGfg56/33XKDDGSipqMJWzPnNQlvwKoqNnBz3prw8qSRBIBZCbrrKJg0Omyv
 maQJVo0+XkrF9QBhBSrcXbK3c7H33IGVEGI8aZ5KuNJe9DnjC8etjzMm4zAXa7qtDclW
 ThfIt9BkgV71hizt0N63lpNhuhrsbKDlzhYXZ5YmYctlxHT8wDlRnZrlxwtoRDz3LGBR
 xoHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUD3jJcntqB1E26ysDDFxDkVGIbBau5Tnt2npCtJNWdVwHpn505saMY5YsbIGrn8mp3jdrEzLs@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzRmNUhabbTkDJfhIoFRJxUbXHGhxzd0BCLrgoPfMHjFW1qFrvx
 dAvtmGNq9zzwEu797c16HPCYMgUnRyny5JL39hpME5y3HeQB5xdYsDyXzXugDZ7meHYTwDSMIok
 1WLSTkvZV0exnojL0E3ICk+ufvkOoBw==
X-Gm-Gg: ASbGnct72RmujXwHkETJN20GLyoqTDp4aQFh82uwrA1nzmiXnjIVBHQLsJAdiTd0N2i
 L9iv8BBX+oL+6qT1Z+x9fosldeH/SXl0DXBS0vQZb4PII4kxF8UgWpn3Y1udWYqIiOHtLb5TMZy
 dHlRche+LT+E0eTCsIfVkhrw==
X-Google-Smtp-Source: AGHT+IGUYiwc0uZ0NRVlmL/NPl2noKrlh8/FfrYX0ZaPV0vfVkk+pT5lgco3zaVR/bUWUvXxIRoE31UQQG7chq3DlOc=
X-Received: by 2002:a17:902:f683:b0:21f:3e2d:7d43 with SMTP id
 d9443c01a7336-22ac2c2f9cbmr36963435ad.13.1744298459412; Thu, 10 Apr 2025
 08:20:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250410145646.51008-1-Arvind.Yadav@amd.com>
In-Reply-To: <20250410145646.51008-1-Arvind.Yadav@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 10 Apr 2025 11:20:45 -0400
X-Gm-Features: ATxdqUEvg-UvvtI41_pUd4CKBN_XZzqmHfvbpbRoROn1FAh80tavH0IHC-ayPzs
Message-ID: <CADnq5_MeKHVv8YLsxvnBKpUD74Te2K6E1aYtAHJZ+b7+_ZRj8A@mail.gmail.com>
Subject: Re: [PATCH 1/2 v2] drm/amdgpu: Add fw minimum version check for
 usermode queue
To: Arvind Yadav <Arvind.Yadav@amd.com>
Cc: Christian.Koenig@amd.com, alexander.deucher@amd.com, sunil.khatri@amd.com, 
 shashank.sharma@amd.com, amd-gfx@lists.freedesktop.org
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

On Thu, Apr 10, 2025 at 10:57=E2=80=AFAM Arvind Yadav <Arvind.Yadav@amd.com=
> wrote:
>
> This patch is load usermode queue based on FW support for gfx11.
> CP Ucode FW version: [PFP =3D 2530, ME =3D 2390, MEC =3D 2600, MES =3D 12=
0]
>
> v2: Addressed review comments from Alex.
>     - Just check the firmware versions directly.
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Shashank Sharma <shashank.sharma@amd.com>
> Cc: Sunil Khatri <sunil.khatri@amd.com>
> Signed-off-by: Arvind Yadav <Arvind.Yadav@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index 91d29f482c3c..62dcdba589cb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -1632,7 +1632,10 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_bloc=
k *ip_block)
>         case IP_VERSION(11, 0, 3):
>  #ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
>                 /* add firmware version checks here */
> -               if (0) {
> +               if (adev->gfx.me_fw_version  >=3D 2390 &&
> +                   adev->gfx.pfp_fw_version >=3D 2530 &&
> +                   adev->gfx.mec_fw_version >=3D 2600 &&
> +                   adev->mes.fw_version[0] >=3D 120) {
>                         adev->userq_funcs[AMDGPU_HW_IP_GFX] =3D &userq_me=
s_funcs;
>                         adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] =3D &user=
q_mes_funcs;
>                 }
> @@ -1646,7 +1649,10 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_bloc=
k *ip_block)
>         case IP_VERSION(11, 5, 3):
>  #ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
>                 /* add firmware version checks here */
> -               if (0) {
> +               if (adev->gfx.me_fw_version  >=3D 2390 &&
> +                   adev->gfx.pfp_fw_version >=3D 2530 &&
> +                   adev->gfx.mec_fw_version >=3D 2600 &&
> +                   adev->mes.fw_version[0] >=3D 120) {

Are you sure this is correct?  I didn't think the firmware is ready
yet for these families.

Alex

>                         adev->userq_funcs[AMDGPU_HW_IP_GFX] =3D &userq_me=
s_funcs;
>                         adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] =3D &user=
q_mes_funcs;
>                 }
> --
> 2.34.1
>
