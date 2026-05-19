Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AA8ACD5BAB
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 13:42:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2774C10ED0B;
	Tue, 19 May 2026 13:42:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gkuhsxzC";
	dkim-atps=neutral
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B41410ED15
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 13:42:26 +0000 (UTC)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-2f114d129c0so204217eec.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 06:42:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779198146; cv=none;
 d=google.com; s=arc-20240605;
 b=GxtBkHHDyU93+nSGJcpgNn3fncGfhx1PX7pzpLPolJn4MFnZmSzN1/ZmOnB6sgvkN/
 B93xDs5F9zLzpRKTbfZPEFzzNd6BBamW9SZAj8VwmCBcDC2gRzeA5RtlmKTMlI3hW1G/
 i36iMPYyH0rbD/QJC31OQKcR0vDLtgpzAHpwxXjro9y18UeccurJUa0WuYp16OBRqNww
 qFjOeqoHMutwhji0pm2tC8ib+cNTqXCxt2OzyVgvwnghl3RQwmM59iSzvcbA60UAlY3k
 M4Ua53yL1DhxiIPuo7OiLf63QdGr0LcUJAynlfpLH8uKIlvOPMIYnb9RvZqTXLatEMp6
 k66A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=71RQW5pfUHXRnnnRXS0mng2QejjcGmA/JoFbS3GPQiM=;
 fh=i5wT2aHg8LGNSgxmvuikwvrBHTn1jVMc7kcpUCMLYJY=;
 b=D93GM4/mx/H2I5ERmpLHVWn66oogipJONcKOw+uvP0uQeIFTROSVC6nISVuQyLUEve
 2U0FfRW57kjso8C4ubArebLzrGVpFrbGtdOQgZAQ+WVpDFQ0qeMivXyzu/Xxm1CpubwW
 T92KjthuppKIlQqf5cVci8vrWlsSBgcohoAnXdg+zUWc591I6S8RHs8+0DisdqMLv/uN
 rhe8hEHfRCft3JAR+1v6XA5LWEOWEoNeXUnYqHeaxo4wj+PGesyVxWHQBBF112sblnJ9
 q+wLNSTMLqrtFaqBXJdVs3Fn7nBvh7pIghBNtJJ+t1p154A4bUH3JlQ+keFPTqIQW8CI
 EmoQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779198146; x=1779802946; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=71RQW5pfUHXRnnnRXS0mng2QejjcGmA/JoFbS3GPQiM=;
 b=gkuhsxzCzSLqk9l8QHWOdFTub3SoVjaEXszz1tn4hElXNYsEyza4vwQ1PCAp16VyKU
 tJen2aGf98ZIh2cjIcRBlzuqxh9dD5NKxJFubxtD9HX+l1w3l6jWPQQAj5T0pGTWbfBp
 xGvEwCbBB4Nvt7m55AbpHRS7PV7Q+t6qPX3hOMh2gWTNFrKsf03jCgeLOPT4Uvb6E/8B
 3olYB4tKNEneN3vWgCYzJF8mMu0B77wQsNyBqWpdLWgUfvQ0tcsfpKLB0uY5AL3jOkvz
 9cbqjFoYB3sE4gvKe18l5vD4C+s+5OSWrV2SZusIFajHRcmsOYRflw9riK3kDVVs7ReJ
 CFKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779198146; x=1779802946;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=71RQW5pfUHXRnnnRXS0mng2QejjcGmA/JoFbS3GPQiM=;
 b=ENw/7KaR5F8zDfcMvr7eZDKR1Yz/YWulrC6p77O7INXrbAc93c0Y2a8YFuNa40g2zv
 BGQmoT9go/uq1sIOSOz/gPnqzb7X1xMrHjAwrRNXdYQgLZ2pgPop1r1YZ7g9En0tuELO
 Est16U/dMsR7hJiKSlKoZbra7uSAV6Y+x0zdUtiqT8eXUyEzVHDAQsaT32tpAgtMPI1z
 TC+U2IU4F+0iD6Uc9W4FgiguIkca2uZ5S0PFPvqAreoelwqCTjAemWMdqcSw5tQ/xiLv
 gXDuRAW/zPhLln/4ys+E1wg5oWIjikN8L88sCTG3SADJU3ENg/t2gDh9hU0ze84fONCO
 wosw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8h2XcPfVtw7rwdS/JAp/7d9IQwVfSQWFeELlg2EVuCcorrqLCeshXVWKPnS9bxw5aL5/xMLVLk@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyZIPJ9lyssCvDhbM5BSPk1YF0onl+7Km82zIbjrako18vBKOcB
 bJmRjjK+MVvZLz5jD0ceE2fgHdALPD9gddqWxpWG4OcXBj9tWaS6CV5jQoL8RqCZFX+A1Bh0x/0
 NrCe5OI581tDz60cT2z0w65f9/jsnQRk=
X-Gm-Gg: Acq92OFBtCE5OZjFIB4kSOikVTLcu+ft6fYZjDfY5Z12Uw6dK4WQ2NDVsRdIExvpFjr
 vjVjYxVoAsGUIEJHqTvg4lHn6dWhHc+pNWp2bng9CYbujLH6FOh/yJRmgVd+xbJyhhomLLWb66W
 JLk9xjTFG3/urSJ7mIxahFtS6js3Strfhb0TlYu6Xs0y1GDSMxLiD5XHTZ5wc00bzTApRljb3ZV
 AKPybDz7cSRyyJr+16ltKQHfGXk1z8V63/b5v2t3eCTHlMEacoIZMHl+1NcxLxzZXDyxy7KCR5z
 86BaubI3cqaOoXMS/akjKlJUebx6maryo/oDRlP1pvu9HH8fXX8s/TVUCcKi7i8aK0tV0g==
X-Received: by 2002:a05:7022:327:b0:12c:20b9:80fc with SMTP id
 a92af1059eb24-13504a4d776mr3503772c88.7.1779198145570; Tue, 19 May 2026
 06:42:25 -0700 (PDT)
MIME-Version: 1.0
References: <CADnq5_PhXmCNOGz9zK8mz7Y0Jw-J9uexhVjGLRqMA4AOHsJ5TQ@mail.gmail.com>
 <20260518211409.4868-7-gilles.risch@gmail.com>
In-Reply-To: <20260518211409.4868-7-gilles.risch@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 19 May 2026 09:42:13 -0400
X-Gm-Features: AVHnY4Ky7Y3vLzKy-VmHgzIOBwHN7Me7gRyd48k7a3HIf7zj18dJ0_fyvAxPfpo
Message-ID: <CADnq5_Pq947+u3U-iVXLanuDQa_WxJKr_=DzJg1z+4rS334NqQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] drm/radeon: fix eDP resume from suspend on iMac11, 
 1 / DCE3.1 systems
To: Gilles Risch <gilles.risch@gmail.com>
Cc: alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, lkp@intel.com
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

On Tue, May 19, 2026 at 3:44=E2=80=AFAM Gilles Risch <gilles.risch@gmail.co=
m> wrote:
>
> After suspend/resume the internal eDP display on Apple iMac11,1,
> stays dark because atombios_set_edp_panel_power() skips panel
> power control for anything older than DCE4, and
> ATOM_ENCODER_CMD_DP_VIDEO_ON/OFF is required on ths iMac.
>
> Tested on iMac11,1 (Mobility Radeon HD 4850, RV770/DCE3.1).
>
> Signed-off-by: Gilles Risch <gilles.risch@gmail.com>
> ---
>  drivers/gpu/drm/radeon/atombios_encoders.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/atombios_encoders.c b/drivers/gpu/drm=
/radeon/atombios_encoders.c
> index 4e984973c043..0a699a887ee9 100644
> --- a/drivers/gpu/drm/radeon/atombios_encoders.c
> +++ b/drivers/gpu/drm/radeon/atombios_encoders.c
> @@ -1384,7 +1384,8 @@ atombios_set_edp_panel_power(struct drm_connector *=
connector, int action)
>                 goto done;
>
>         if (!ASIC_IS_DCE4(rdev))
> -               goto done;
> +           if (!dmi_match(DMI_PRODUCT_NAME, "iMac11,1"))
> +                   goto done;

This logic is harder to follow.  I would just add an additional check.  E.g=
.,

         if (!ASIC_IS_DCE4(rdev))
               goto done;

          if (!dmi_match(DMI_PRODUCT_NAME, "iMac11,1"))
                  goto done;

Other than that, looks good to me.

>
>         if ((action !=3D ATOM_TRANSMITTER_ACTION_POWER_ON) &&
>             (action !=3D ATOM_TRANSMITTER_ACTION_POWER_OFF))
> @@ -1707,7 +1708,7 @@ radeon_atom_encoder_dpms_dig(struct drm_encoder *en=
coder, int mode)
>                 if (ENCODER_MODE_IS_DP(atombios_get_encoder_mode(encoder)=
) && connector) {
>                         /* DP_SET_POWER_D0 is set in radeon_dp_link_train=
 */
>                         radeon_dp_link_train(encoder, connector);
> -                       if (ASIC_IS_DCE4(rdev))
> +                       if (ASIC_IS_DCE4(rdev) || dmi_match(DMI_PRODUCT_N=
AME, "iMac11,1"))
>                                 atombios_dig_encoder_setup(encoder, ATOM_=
ENCODER_CMD_DP_VIDEO_ON, 0);
>                 }
>                 if (radeon_encoder->devices & (ATOM_DEVICE_LCD_SUPPORT)) =
{
> @@ -1724,7 +1725,7 @@ radeon_atom_encoder_dpms_dig(struct drm_encoder *en=
coder, int mode)
>         case DRM_MODE_DPMS_SUSPEND:
>         case DRM_MODE_DPMS_OFF:
>
> -               if (ASIC_IS_DCE4(rdev)) {
> +               if (ASIC_IS_DCE4(rdev) || dmi_match(DMI_PRODUCT_NAME, "iM=
ac11,1")) {
>                         if (ENCODER_MODE_IS_DP(atombios_get_encoder_mode(=
encoder)) && connector)
>                                 atombios_dig_encoder_setup(encoder, ATOM_=
ENCODER_CMD_DP_VIDEO_OFF, 0);
>                 }
> --
> 2.47.3
>
