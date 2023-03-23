Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54E94C6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Mar 2023 12:57:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4CD310E07B;
	Thu, 23 Mar 2023 12:57:56 +0000 (UTC)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B99FF10E07B
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Mar 2023 12:57:54 +0000 (UTC)
Received: by mail-ot1-x331.google.com with SMTP id
 d22-20020a9d5e16000000b0069b5252ced7so12038581oti.13
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Mar 2023 05:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1679576274;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/wf8Iy3Iqo/d/ZTIuAxufDQksnZikwyH/2IL6Wnxz6U=;
 b=Bymf+FslQgAuSjSqqmidT40Ne6i6HG5dl5yIqgRjnlIb+w24qFvOMRf6PSWNlLGDQ4
 Bhm7CraClAWfYx1y0IDA/a6ju4aciXd62vvjaH1GXD8DAeb5gcNDbQcQmKxtJctms5Yo
 930lO1HcY6+VUANYOETg4yHq62KY+jQrthwAd/FP/CN8lmvDZSBNBgLzD7e5ufWnlZe6
 suC2Mvt/P1kH/ixVfFTFmAnJZphmmFRuHIe6WzIh6OGqBqeAgOcEtWRs8Vmsd//rjVyZ
 3qn+YdwStD4P7s9uDP7OHzrgj1aGwpkwy0IDFlHLZeAPgJBMuleG1x50yyyDRtPLxpax
 Wfyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679576274;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/wf8Iy3Iqo/d/ZTIuAxufDQksnZikwyH/2IL6Wnxz6U=;
 b=HI6LpXhgmGZawMviSqRGr64YvdTmyEx81I6QAc4DriNAqLcSu3oBbY4edYiPH/1eVm
 dYZYs7k6Y9BdB925WDC+8sToOgsdeqaUaXN8fmCLs2BB23d3mNfJc3g8UK6Cqw2FHtFt
 ByAXv41y79jgBNAIjp+Ljm7WRAb4teYeXsCawaAju8cDJUp/JlqHnDqdG/E4rLN0kA30
 bVSOU4ILqGduoxIudxr/uRR/ZmduywpVdOe+uuRI8fQ+rzTkrYQQ32QBUtEXfrIA30pr
 ZRs0gDno5Ms1rGHpm8KHj2S88NW8SDVP6wjcD8f+7bUdeVIGjgTHA3gYUhhazf6TJllD
 Q61A==
X-Gm-Message-State: AO0yUKWS+gB4+8to/8K4Gejp1yvKEtS1M5muEIKfk9iHVTIcJw5jAYdD
 4fsfd5OY0al29B2U9pU8B7sGUP8iL/xC2b5GHHo=
X-Google-Smtp-Source: AK7set8dE6CjMdwyf/KMShDDmsKZWiKe3uQIX1EQCIPK151nb1c7ICoeWWJkZdynrHKEw0ySlHSj1Jlhq0CAcdswmMc=
X-Received: by 2002:a05:6830:1e63:b0:69d:dde8:8e12 with SMTP id
 m3-20020a0568301e6300b0069ddde88e12mr2242489otr.3.1679576274007; Thu, 23 Mar
 2023 05:57:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230323060529.270869-1-luben.tuikov@amd.com>
 <20230323060529.270869-2-luben.tuikov@amd.com>
In-Reply-To: <20230323060529.270869-2-luben.tuikov@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 23 Mar 2023 08:57:43 -0400
Message-ID: <CADnq5_PJsn0CKm6enbLAV4gfsVMkpeWfkkpVT=U0pMzmfngBgw@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: Return from switch early for EEPROM I2C
 address
To: Luben Tuikov <luben.tuikov@amd.com>
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>, Candice Li <candice.li@amd.com>,
 Kent Russell <kent.russell@amd.com>,
 AMD Graphics <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Thu, Mar 23, 2023 at 2:06=E2=80=AFAM Luben Tuikov <luben.tuikov@amd.com>=
 wrote:
>
> As soon as control->i2c_address is set, return; remove the "break;" from =
the
> switch--it is unnecessary. This mimics what happens when for some cases i=
n the
> switch, we call helper functions with "return <helper function>".
>
> Remove final function "return true;" to indicate that the switch is final=
 and
> terminal, and that there should be no code after the switch.
>
> Cc: Candice Li <candice.li@amd.com>
> Cc: Kent Russell <kent.russell@amd.com>
> Cc: Alex Deucher <Alexander.Deucher@amd.com>
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index 5c21480fff9c8b..3106fa8a15efef 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -181,14 +181,14 @@ static bool __get_eeprom_i2c_addr(struct amdgpu_dev=
ice *adev,
>         switch (adev->asic_type) {
>         case CHIP_VEGA20:
>                 control->i2c_address =3D EEPROM_I2C_MADDR_0;
> -               break;
> +               return true;
>
>         case CHIP_ARCTURUS:
>                 return __get_eeprom_i2c_addr_arct(adev, control);
>
>         case CHIP_SIENNA_CICHLID:
>                 control->i2c_address =3D EEPROM_I2C_MADDR_0;
> -               break;
> +               return true;
>
>         case CHIP_ALDEBARAN:
>                 if (strnstr(atom_ctx->vbios_version, "D673",
> @@ -196,7 +196,7 @@ static bool __get_eeprom_i2c_addr(struct amdgpu_devic=
e *adev,
>                         control->i2c_address =3D EEPROM_I2C_MADDR_4;
>                 else
>                         control->i2c_address =3D EEPROM_I2C_MADDR_0;
> -               break;
> +               return true;
>
>         case CHIP_IP_DISCOVERY:
>                 return __get_eeprom_i2c_addr_ip_discovery(adev, control);
> @@ -204,8 +204,6 @@ static bool __get_eeprom_i2c_addr(struct amdgpu_devic=
e *adev,
>         default:
>                 return false;
>         }
> -
> -       return true;
>  }
>
>  static void
> --
> 2.40.0
>
