Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 011AFCD6E44
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2026 13:35:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 986AB10F1AD;
	Thu, 28 May 2026 13:35:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XrVEreua";
	dkim-atps=neutral
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30B9A10F1AD
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2026 13:35:49 +0000 (UTC)
Received: by mail-dl1-f50.google.com with SMTP id
 a92af1059eb24-134a84f0aa7so432664c88.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2026 06:35:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779975348; cv=none;
 d=google.com; s=arc-20240605;
 b=VsB8qkwaFbbQTgKUoYM9B5QDMITiYq/iJj/kAJZ/RhodstUrNM3gO1I3qJgg5+Iwih
 1il/DFNM8ferZlShESp84TiPbDhhCLn7aKuWT6UOop1Qe8+YPrjcatQbemU6BcmNtLtq
 Gg6arJ5oBh3+YfUygHh1zVOcfjUJD6WXP8aCnA9uVlmzIEFgLORB6MtMLVBJx4Tkcv5X
 aivgP7beQzdwyWF2v+hRd6+QdhRBd39w5nA3zLZ1OR72lZnUvjEEtZEl2/T2fOdawyll
 gFDWhzCEoxzyKA5EPlScheOaqDy7nowe6F9BJt/jhOgM9/iFzTsJb0iTBNXCxwdE9Xu6
 7aLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=P9OHROUjP+TT5784xM2MeRifQ1mx5BiCV/WoHPuhqgQ=;
 fh=zcF1SMSzpgsRdOFpBhsXE6ElqEJjKwHw9I6eFiyBtI4=;
 b=cGK1ItwOcpehi40q6IiNesPuY8/DmC9Y+aM0kOdnP8pmcHWvKKO04LsLUiM/rfTI1F
 /cxSbJ7/zc8wikhN+AoZch9HC4K9gc7YISHpJlPJgGWNRFohOyYLyZVrhQLwPLNbNREI
 6XOUXUJZrJxpdluCzsjaiMhKVDawNgjoYNQZ5NUt4YCxP3Ho/lwNoRxQ8A1/msq0ufdu
 Xh4wPpxtCZc03EbhfDVseoFxlR9NYG6EUbZkwezjX2H1X61LESbs2k0sMKYyY0/WacmT
 ufwr3w0v/qpmhZaoaNViRuS8oUTV0tGJRwj8306W5CRcBv6erdoIfPbkqanHtzBV0iDY
 eH0Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779975348; x=1780580148; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P9OHROUjP+TT5784xM2MeRifQ1mx5BiCV/WoHPuhqgQ=;
 b=XrVEreuaJpPaNLUhRMFCKsMyXv8NrkHQ1jwUAMxmHJ7A3ZUDVHot8YaxuiiSmjn8yH
 6Udf6ucVjhAD0oxLtYNbLmXgeuRH9gH+juMq1ry6KJ9P0jTM8nkXvqM79wlMQZ5pRtXb
 VqM9UrlU5jSSwtUHb10pQebrGW+DY/lAoWayO2VnKEwOGiCHWZ4IusYpr09rUIW9qj9y
 eHss9F9MtOlRUG1rH6gfEvdDEGRQdLwKdmhSooNgH/MVbycN5PXSx8AmMd6WOYEFc2xo
 ObPAulf1gEWu1vU8n8kQfdSB4c8kOgODic7P/YJ3PFLJ6qEStHIqxzliDQynYUWCwo1u
 Ulsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779975348; x=1780580148;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P9OHROUjP+TT5784xM2MeRifQ1mx5BiCV/WoHPuhqgQ=;
 b=bslztiXZoreAyHTOdMgNVYUKqz2ZNdRPw+T+IV2zPKcsnHLnyD87bkLcSWjsXk1SUy
 s6iQIDhxTwN8EU2rdL8BCYq29zh4rlaeNjnVAqigs4G/JSDFXLzDtan+uX7c2eScG6gh
 3nVHxFhlyFXkWtCq9wDIUQgoaryHmZOffchklE7zLZElUoavhCMOfGB/C5wUy0ieL7n3
 gRNPD9v7jHjabpbmD+PotNti1qexPD7w+KF/4PXeDLppTdcRIfwpwOltAaCKx0bxXgUP
 ytBlBzwVyTcaon/iqOLpm7poHJnKgdpG0lt8zAu5a/TqI88YsaTYI/V9nG5tR8UsDXL6
 ZzMw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9PsywTWd6QN1QDguUPFZ2HZYFHn38izPR7V0+22Kt/nYa/4pvobi9BmVjK5FwQlvnDbfiBtpyR@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxlg9Ns1d1HErahJAMuFh8SzVFaG1dqf2EjkGeaftnabtsAPJb8
 ENHvFhJkK2FEfA+tIyfd3uF8ueHdYkSOrIpNRo22hpbz7n9t4X5GPeHgQAJIds9t9RfUf6596wj
 mtAiD7NKLlxYk7XqIA1EpBI9d8sdTLxZ/dF4B
X-Gm-Gg: Acq92OGmHBw7h2ND/bK9W4LaziudOGoYSm0sFDPZSCIFzfK4U/+gqE5aYmualcqpHUO
 OnhxMV/1jeMZZpxbpTnt7GdU9rtkd0q+YjmlNArhdIm0eIQqBavYoeVW5kRGoF2YtTcAtRjX1W7
 bnUQ0MU+7YSqYz+IxPaFe3h5RKJOAmrP0xhBpvYlzVTyxXkxhxqBhu7FSdm5voGNjnKs7MKrYpQ
 Otur7DUnmoS+lPXIAlvIr8lH4RDVtqHDX2P+em6y+9tjuv8w/4HxBiUpOx7P4fSFn1chT1EzVWT
 4LH2/4RWDDAGe1LkiCj6ENPnpLtYOViif0fguW17JGpYTaU4Z8dLoRqxDQV7HCAKUmFjn1tlV86
 DvzL4
X-Received: by 2002:a05:7022:2202:b0:12c:888b:aa92 with SMTP id
 a92af1059eb24-1377c94af3fmr718781c88.1.1779975348511; Thu, 28 May 2026
 06:35:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260528064206.12358-1-Pratik.Vishwakarma@amd.com>
 <20260528064206.12358-8-Pratik.Vishwakarma@amd.com>
In-Reply-To: <20260528064206.12358-8-Pratik.Vishwakarma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 28 May 2026 09:35:37 -0400
X-Gm-Features: AVHnY4KHNy_vPbQ5VZimelEqHipXYeeub0LOgfrpFkNe-Yi88m9n6XL58j87V2c
Message-ID: <CADnq5_NtQnP7dgt5ds85W_Tz-vWjXBSecEcfYWrRS+YrxGyjhg@mail.gmail.com>
Subject: Re: [PATCH 8/8] drm/admgpu: Add support for ATHUB 3.4.2
To: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Cc: Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org, 
 Shubhankar Milind Sardeshpande <Shubhankar.MilindSardeshpande@amd.com>
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

On Thu, May 28, 2026 at 3:19=E2=80=AFAM Pratik Vishwakarma
<Pratik.Vishwakarma@amd.com> wrote:
>
> From: Shubhankar Milind Sardeshpande <Shubhankar.MilindSardeshpande@amd.c=
om>
>
> Add ATHUB 3_4_2
>
> Signed-off-by: Shubhankar Milind Sardeshpande <Shubhankar.MilindSardeshpa=
nde@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/athub_v3_0.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/athub_v3_0.c b/drivers/gpu/drm/am=
d/amdgpu/athub_v3_0.c
> index d1bba9c64e16..b42d9876e0a1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/athub_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/athub_v3_0.c
> @@ -43,6 +43,7 @@ static uint32_t athub_v3_0_get_cg_cntl(struct amdgpu_de=
vice *adev)
>                 data =3D RREG32_SOC15(ATHUB, 0, regATHUB_MISC_CNTL_V3_0_1=
);
>                 break;
>         case IP_VERSION(3, 3, 0):
> +       case IP_VERSION(3, 4, 2):
>                 data =3D RREG32_SOC15(ATHUB, 0, regATHUB_MISC_CNTL_V3_3_0=
);
>                 break;
>         default:
> @@ -59,6 +60,7 @@ static void athub_v3_0_set_cg_cntl(struct amdgpu_device=
 *adev, uint32_t data)
>                 WREG32_SOC15(ATHUB, 0, regATHUB_MISC_CNTL_V3_0_1, data);
>                 break;
>         case IP_VERSION(3, 3, 0):
> +       case IP_VERSION(3, 4, 2):
>                 WREG32_SOC15(ATHUB, 0, regATHUB_MISC_CNTL_V3_3_0, data);
>                 break;
>         default:
> @@ -112,6 +114,7 @@ int athub_v3_0_set_clockgating(struct amdgpu_device *=
adev,
>         case IP_VERSION(3, 0, 1):
>         case IP_VERSION(3, 0, 2):
>         case IP_VERSION(3, 3, 0):
> +       case IP_VERSION(3, 4, 2):
>                 athub_v3_0_update_medium_grain_clock_gating(adev,
>                                 state =3D=3D AMD_CG_STATE_GATE);
>                 athub_v3_0_update_medium_grain_light_sleep(adev,
> --
> 2.43.0
>
