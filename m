Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ED89C77B7C
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jun 2025 17:36:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12ABB10E04B;
	Mon, 23 Jun 2025 17:36:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FLUDIUR1";
	dkim-atps=neutral
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A929C10E04B
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jun 2025 17:36:19 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-31305ee3281so517510a91.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jun 2025 10:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750700179; x=1751304979; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K7dC/fYc+bzfsKK15HQiFCQ3dcWzvji1m5hzEYWFOL0=;
 b=FLUDIUR1pcifZFFDXfjxkQ5dgHCg90FRgx/ddsJFPNKgSUyi+D8d+gCdXrb2f9dG/B
 Kos6wcS3M7zEAdLmymyzse2hCgcYk+heQOVm/ZwgznJ5+zqxZBFFdQko+TdvTMJwhYmn
 i36vUIl6BuPxFPnx6WBIg15dn2BLpZN4xcyZtxwxpiFKrU+XQorng6CRDAgqpcpGdupp
 ahZkbqEqBDVeTsEXltlDiQKy0VXTO11pH95T/vdmVeRiZoIGMeQLk48zxypS0PT0pBY2
 TbKnOa+tpaxSpdPuICIVbfCiZnh6FEcn6tsPReg8eOe1PM7UPpCqc2gMUEFn1em5KyGE
 KS0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750700179; x=1751304979;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K7dC/fYc+bzfsKK15HQiFCQ3dcWzvji1m5hzEYWFOL0=;
 b=bi4PhVoA8Mx54qVkMexpvq7XUBImZrpWMLfHv3HJehAjM1XstZqqtHaBeM8w9kTjcO
 jIxPVjP+4+tihO63/zeNIY5DIES6X0MPOs9nVD7M9Co7xhJvJlgfwnJ9jsA7iBz2UGuy
 4Cysuxj+AXHIro8BH5dYJH0wRv/Qu0zgocKrDQAuRE8hbKFCa3RnSlpRzIBqMlI7PFEl
 2FVlAaTLM0Uw2S2SCDZzrQ9Kts7XAbGhwh9gjLilPCtjAB3rmt2zvouom0H0WZVd1yq4
 ToLUIA2FtpkiHwldnqNOgWE6qJJ9AgoO/pWFsb3su+S9eg3kVd5fYrDUoarmKmwziYb+
 x3Qw==
X-Gm-Message-State: AOJu0YyWl3NwhGnQsDJf7BZcWx8Ivn0Tdlv8Ds3q3WVY+w8AW4chae33
 7VRUU7w4wm4pPmFkFmG2ABI1P2E0y3Wq7oQyou+2LN1sdM8bNzbnXXuXQn5QNEEBXawm6zS75Vg
 hgjvjxxeefSwJQNKhE4isYGpCOeE/cw4=
X-Gm-Gg: ASbGncvSvn+e0MskF6PHdKNSZlNM+kt/E1wW65rWzJTFGSLbYjWHE61juvYIJ56ayre
 8N0raU90XbET2qxsUGp3Wo/0fJB1JnFe2Tnwzys0ic4RrT6FbGB1RH/WydmcLsUhX78Bvr3gRIZ
 6Q1yrAkKtSjIoUOBca0QEWe9LVMA4fr3mSU9hLJ7mTCQ2/
X-Google-Smtp-Source: AGHT+IEEvJkMZPs7YrR1Rcnq6OHptlS0SAgy/1QnZE5YhwqfxejINs/wRSa2PZEj5tQilH0SiBKGv4cwNBbxtAnPTX8=
X-Received: by 2002:a17:90b:57ee:b0:312:ec:411a with SMTP id
 98e67ed59e1d1-3159d8c6488mr7699361a91.3.1750700178930; Mon, 23 Jun 2025
 10:36:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250623171114.1156451-1-mario.limonciello@amd.com>
In-Reply-To: <20250623171114.1156451-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 23 Jun 2025 13:36:06 -0400
X-Gm-Features: AX0GCFv_H0mChX2Ifr3JeSeSEqEoJdzj2J2EuVy0pTB9Jkhq1X8L7jzSJflcefE
Message-ID: <CADnq5_NtPxegonFFA_Q5GKdo_59LaEMsoyQS8P4G0205LLNpjQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm/amd/display: Fix AMDGPU_MAX_BL_LEVEL value
To: Mario Limonciello <mario.limonciello@amd.com>
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

On Mon, Jun 23, 2025 at 1:12=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> [Why]
> commit 16dc8bc27c2aa ("drm/amd/display: Export full brightness range to
> userspace") adjusted the brightness range to scale to larger values, but
> missed updating AMDGPU_MAX_BL_LEVEL which is needed to make sure that
> scaling works properly with custom brightness curves.
>
> [How]
> As the change for max brightness of 0xFFFF only applies to devices
> supporting DC, use existing DC define MAX_BACKLIGHT_LEVEL.
>
> Fixes: 16dc8bc27c2aa ("drm/amd/display: Export full brightness range to u=
serspace")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
> v2:
>  * Use DC define instead
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index a139da1c47af..77302caaf24a 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -4689,7 +4689,7 @@ static int amdgpu_dm_mode_config_init(struct amdgpu=
_device *adev)
>  }
>
>  #define AMDGPU_DM_DEFAULT_MIN_BACKLIGHT 12
> -#define AMDGPU_DM_DEFAULT_MAX_BACKLIGHT 255
> +#define AMDGPU_DM_DEFAULT_MAX_BACKLIGHT MAX_BACKLIGHT_LEVEL
>  #define AMDGPU_DM_MIN_SPREAD ((AMDGPU_DM_DEFAULT_MAX_BACKLIGHT - AMDGPU_=
DM_DEFAULT_MIN_BACKLIGHT) / 2)
>  #define AUX_BL_DEFAULT_TRANSITION_TIME_MS 50
>
> @@ -4751,16 +4751,16 @@ static int get_brightness_range(const struct amdg=
pu_dm_backlight_caps *caps,
>         return 1;
>  }
>
> -/* Rescale from [min..max] to [0..AMDGPU_MAX_BL_LEVEL] */
> +/* Rescale from [min..max] to [0..MAX_BACKLIGHT_LEVEL] */
>  static inline u32 scale_input_to_fw(int min, int max, u64 input)
>  {
> -       return DIV_ROUND_CLOSEST_ULL(input * AMDGPU_MAX_BL_LEVEL, max - m=
in);
> +       return DIV_ROUND_CLOSEST_ULL(input * MAX_BACKLIGHT_LEVEL, max - m=
in);
>  }
>
> -/* Rescale from [0..AMDGPU_MAX_BL_LEVEL] to [min..max] */
> +/* Rescale from [0..MAX_BACKLIGHT_LEVEL] to [min..max] */
>  static inline u32 scale_fw_to_input(int min, int max, u64 input)
>  {
> -       return min + DIV_ROUND_CLOSEST_ULL(input * (max - min), AMDGPU_MA=
X_BL_LEVEL);
> +       return min + DIV_ROUND_CLOSEST_ULL(input * (max - min), MAX_BACKL=
IGHT_LEVEL);
>  }
>
>  static void convert_custom_brightness(const struct amdgpu_dm_backlight_c=
aps *caps,
> @@ -4980,7 +4980,7 @@ amdgpu_dm_register_backlight_device(struct amdgpu_d=
m_connector *aconnector)
>                 drm_dbg(drm, "Backlight caps: min: %d, max: %d, ac %d, dc=
 %d\n", min, max,
>                         caps->ac_level, caps->dc_level);
>         } else
> -               props.brightness =3D props.max_brightness =3D AMDGPU_MAX_=
BL_LEVEL;
> +               props.brightness =3D props.max_brightness =3D MAX_BACKLIG=
HT_LEVEL;
>
>         if (caps->data_points && !(amdgpu_dc_debug_mask & DC_DISABLE_CUST=
OM_BRIGHTNESS_CURVE))
>                 drm_info(drm, "Using custom brightness curve\n");
> --
> 2.49.0
>
