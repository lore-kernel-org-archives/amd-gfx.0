Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DCDAEA7940
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 19:23:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7F5B10E75D;
	Wed,  4 Feb 2026 19:23:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="m2GxLNxU";
	dkim-atps=neutral
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2C2D10E75D
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Feb 2026 19:23:10 +0000 (UTC)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-2b7267ff06fso7801eec.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Feb 2026 11:23:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770232990; cv=none;
 d=google.com; s=arc-20240605;
 b=hB4pYFEuJGo1hrp7lW4p6Kk5gQduE2MeRLsqBUxSRkahsimXmxCcakrrymSvQxTBx/
 DhfyXcf4/gfoF16WUA1eylYKLcMhzAEa3sC/tbdNX0ZSkcC9ftCePq+aQgth3a2W9OAl
 MVrIdKGz/BKMumNZc/adgw9+mt5WpyoAhSHkVgt5+WldZX4DfiLAz28/JUXdqfps0PNg
 pJ1IqIlaG54kU0O4MSaxOM8Mo9HR8nVZ32E6sdMDzueOJWX86xg+2HaliVYWYO2qQYkU
 WPjQhXlToqlqEOu9/MR66mYpKdUc3YoXes1EV779OE0ThfMaSkyjUaFBPXaYFv3mMQ4Z
 CYZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Fz/Xa8sTgBUtB0paXOBS9TJ+e1nUavFWVe0ctx2CAkc=;
 fh=J5RWUoMOgVfqN+Wg9jXOpgbE8dZ9jUu/AV1o2+CF4cE=;
 b=MXC1A8tI6ipYCCJqBFODJd7weoA1GxIXJF5r8M6E8DjWZyKNRVR+vj+D8h9spjg9m3
 YJWnB6/q8BuvcipwE0zK+wQunCFLB57wcryEsmOdneU+cE13uBEFDRgTLf14856wGlCH
 heBSdhuuTOJIQBeDPcdzsSHdf7Lk9zZICJLALGRqYyljpS1yVo6Q5KttIAS1KfgSv1jE
 zB+Z4uyKrq1CujX8b5mxRexEU42WNl5cbzEHl6htwdg5SNcvYcVU9TSMGWIL2M0QvU7X
 IHatI0rdelkrVjeqw+DmYuJCaYhPo8NqYBxJ1zPnCvdpqR/CK7Q/ACz82xIE7pgVG7vP
 GD+g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770232990; x=1770837790; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fz/Xa8sTgBUtB0paXOBS9TJ+e1nUavFWVe0ctx2CAkc=;
 b=m2GxLNxU2XrWHQlCldDakf+ySFZ1o4iwHt9tL6vDN2oAMJ9Nhmr3gcKEQnp6f8phmS
 0LRAQNviDPfLB09EF2ZBEeYw5JJU+BvDEn1Nc0poQozDl7U23jypverOyklSmu2xZoJd
 Dlirb1h/HxqC+jPOpcjNrc+b6g863ID5aLkAPklBTOhuD/Sc7Z62IzRCEhSYcyIPUquu
 u7MaVEs8vBsTSGXFcXgmzTk/tczsR1Zlkjaa3wnav1zbfpa/hKnrZVGwMG6wkLbPOnku
 +Jo0ukTGRAaA12AjThWPYSYyhZ871k3sVvTUGgHnvDibjR8asrq7CEsJpg/M97ffc3WZ
 hysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770232990; x=1770837790;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Fz/Xa8sTgBUtB0paXOBS9TJ+e1nUavFWVe0ctx2CAkc=;
 b=I/tWCLwBgd+Gv/VMOoeCRNeXocdS4+8x2GOaSviQgyHHFJYWGQAfaGF0gZimR/dW5+
 CZG9MDpZWUM2sJ9GkLZyJh87pvG0Na0wwyn2n7xGmbFZbdOITI7B/32sEtXOsC643NGl
 UPcdkk7q/cht5NwAVhKG/35j0Qq+Z0+/usvwR+YW6M+c2owdOaBWDLaUcwPtVHPJrCXr
 wUmMWtPqOiHe6/nG+GaFWNXPhO+mlEkyZdQmApbHFpd1OcVJELRg27g8NchRfc6zi5Uv
 JDJeFexc4cYG83jVS+YXIuoR15Aq1bAOKNxe2V8jHeG0C2n4aO3t5/tvSxOpUFjR9eQJ
 Y62w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdGuD3IbzqeilXmiiOnGEzyUZr/TL4+6cWybg5kVO25Cete+ol+maw5LY56eFeP+mAG0TueZyc@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzhLpq9ZP6g4YeRpthHPrGTY50efekew3dmb1Hf/T1slIlmZUn/
 sKRxvBKXUY/p8y6k1c2pmCgkW0/4+54cG5aqdCUY5egUeOHqTc8V7EcY9vCoKPeVppeUHdZS9TK
 3vLpq8fJLHYg4AFCoMzwPa0ORKWPqSkA=
X-Gm-Gg: AZuq6aLcxhvRYs39y8tN4kdr64dT32qP5B71l9F+jsAJPItMYzRQNtFm2a/FtE45hNe
 QRtNtVa0qQ4N7rndZbxyCaqr4RxPZdr0wvPfMwITQLexooztBdMfdn10OutNzdfB6Oc+f5IwqvV
 x/Ndhdn/i6TVDmfc1c3vFcFbPrmXBzuEUrl/tiTdMM5zSbZIGBGUsyk+JHipKdPzyvYIATcC9Va
 8AtjYqRmWoXEdfxPaT6Jiy5aDzpT2+oHbK+aetaRgPsbHoGKMzDNShbZ4xlJPmJHXHbM6f6
X-Received: by 2002:a05:7022:e981:b0:11b:862d:8031 with SMTP id
 a92af1059eb24-126f47146c5mr870956c88.0.1770232989923; Wed, 04 Feb 2026
 11:23:09 -0800 (PST)
MIME-Version: 1.0
References: <20260204044338.96093-1-Pratik.Vishwakarma@amd.com>
 <20260204044338.96093-9-Pratik.Vishwakarma@amd.com>
In-Reply-To: <20260204044338.96093-9-Pratik.Vishwakarma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 4 Feb 2026 14:22:58 -0500
X-Gm-Features: AZwV_QhHPcwsiruiS3dx_Nvtn6L_6antDlhbBrQ6yx6IC5Ve4FsMWohBpLTZJrw
Message-ID: <CADnq5_NeZxSHb=_5dpmEmdd_606433yAzBHKnCC8ARkYd4jDjw@mail.gmail.com>
Subject: Re: [PATCH v2 09/11] drm/amdgpu: enable mode2 reset for SMU IP v15.0.0
To: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Cc: Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org, 
 Kanala Ramalingeswara Reddy <Kanala.RamalingeswaraReddy@amd.com>
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

On Wed, Feb 4, 2026 at 12:02=E2=80=AFAM Pratik Vishwakarma
<Pratik.Vishwakarma@amd.com> wrote:
>
> Set the default reset method to mode2 for SMU 15.0.0.
>
> Signed-off-by: Kanala Ramalingeswara Reddy <Kanala.RamalingeswaraReddy@am=
d.com>
> Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/soc21.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amd=
gpu/soc21.c
> index d9cc649d81ad..79d132fc8ca9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
> @@ -422,6 +422,7 @@ soc21_asic_reset_method(struct amdgpu_device *adev)
>         case IP_VERSION(14, 0, 1):
>         case IP_VERSION(14, 0, 4):
>         case IP_VERSION(14, 0, 5):
> +       case IP_VERSION(15, 0, 0):
>                 return AMD_RESET_METHOD_MODE2;
>         default:
>                 if (amdgpu_dpm_is_baco_supported(adev))
> --
> 2.43.0
>
