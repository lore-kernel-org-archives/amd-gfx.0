Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07430C4167B
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Dec 2023 23:34:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A487B10E640;
	Tue,  5 Dec 2023 23:34:27 +0000 (UTC)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24C3B10E640
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Dec 2023 23:34:26 +0000 (UTC)
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3b8412723c4so3540185b6e.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 05 Dec 2023 15:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701819265; x=1702424065; darn=lists.freedesktop.org;
 h=in-reply-to:autocrypt:from:references:cc:to:content-language
 :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=q4Uc+o6B0ouw+3fu8dG0ab0+rDcDdoHva8Me5Ha06KI=;
 b=Vvi2JvrWnr76AJ0h2OGxpT4alpOdRbzOyZGRJcbr+15cNhYOTPvBFyjiQlGmEv//SR
 h31WP6KIaQtTJJNDWBFonQ3QbfQO7uU1chnolDLN0EOZD2VYBjCUzNmecNznLVhDYHej
 l8mjaLgwneCoGs+DQ3d8kyv7oEAaaFmsBznKmMY7kV108EoplLNGj3qrkTmm6giwD7Rz
 Brl0xATZgIFAtNmOJrCkVNYtTn/sPpto001JmA5qWK9CoIB4h4t/B9/pmY5DdDn+03F+
 SNaOFR/045BVjkCOh63ObEOOaIyqovXnRnOCKtKxCTihblIPUXAU8Q7PA306hgc8+1Vc
 7qlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701819265; x=1702424065;
 h=in-reply-to:autocrypt:from:references:cc:to:content-language
 :subject:user-agent:mime-version:date:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=q4Uc+o6B0ouw+3fu8dG0ab0+rDcDdoHva8Me5Ha06KI=;
 b=DGZBq01Dmu9JFb7cJSaf3jK9PKrtxdVEppM6qZJjk9egGufwGCvDauqLgB3nxl4w7N
 EWdOqHvlcFuxeyLYWiR1qduQ9qBO5nBFCvkkwUVbxtuHV7srJSk8/W9/1xa34oXvur3s
 MU5FMxPTeYMppjQFqlDdCUb/cw4XezLteD6TNXXSifq/mj4N1HoKpwmoVOIM4AbjHUlc
 h7/nbi7YTaZ5lvjeB58LFxdPhDbkMHm/9w25Hdavhvqc7smQAj6kJXd+e2+jvLNmdA1m
 NQyVlJo9a3dOgGLiuhrzVxsWCUg5yu7eI+dnxBn2STTZ0hJe/pQTrItEvL6PVLXx0WOr
 9wJg==
X-Gm-Message-State: AOJu0YwPEmXO3rpFrlUkJ4EAKO0LyMVqLPmVrr2aZfzsV8GqN0mrPZhc
 GakgdC7iZZLZaPNRDqM58Zc=
X-Google-Smtp-Source: AGHT+IGT/2Tkzo2tV+PVNroJouMJz3q4EZPF0LbL9hvlD6o+7HRpbPzDoHRrB5RB7IvoswvMigZxAQ==
X-Received: by 2002:a05:6808:bce:b0:3b9:bd28:624f with SMTP id
 o14-20020a0568080bce00b003b9bd28624fmr52978oik.8.1701819265278; 
 Tue, 05 Dec 2023 15:34:25 -0800 (PST)
Received: from [192.168.2.14] ([76.65.20.140])
 by smtp.gmail.com with ESMTPSA id
 qr13-20020a05620a390d00b0077d5e1e4edesm5399354qkn.57.2023.12.05.15.34.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Dec 2023 15:34:24 -0800 (PST)
Message-ID: <c603a160-8847-45c0-8be2-6a8025ba0fdb@gmail.com>
Date: Tue, 5 Dec 2023 18:34:15 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:115.0) Gecko/20100101
 Thunderbird/115.5.1
Subject: Re: [PATCH] drm/amdgpu: fix buffer funcs setting order on suspend
Content-Language: en-CA, en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231204141307.20647-1-alexander.deucher@amd.com>
From: Luben Tuikov <ltuikov89@gmail.com>
Autocrypt: addr=ltuikov89@gmail.com; keydata=
 xjMEZTohOhYJKwYBBAHaRw8BAQdAWSq76k+GsENjDTMVCy9Vr4fAO9Rb57/bPT1APnbnnRHN
 Ikx1YmVuIFR1aWtvdiA8bHR1aWtvdjg5QGdtYWlsLmNvbT7CmQQTFgoAQRYhBJkj7+VmFO9b
 eaAl10wVR5QxozSvBQJlOiE6AhsDBQkJZgGABQsJCAcCAiICBhUKCQgLAgQWAgMBAh4HAheA
 AAoJEEwVR5QxozSvSm4BAOwCpX53DTQhE20FBGlTMqKCOQyJqlMcIQ9SO1qPWX1iAQCv3vfy
 JwktF7REl1yt7IU2Sye1qmQMfJxdt9JMbMNNBs44BGU6IToSCisGAQQBl1UBBQEBB0BT9wSP
 cCE8uGe7FWo8C+nTSyWPXKTx9F0gpEnlqReRBwMBCAfCfgQYFgoAJhYhBJkj7+VmFO9beaAl
 10wVR5QxozSvBQJlOiE6AhsMBQkJZgGAAAoJEEwVR5QxozSvSsYA/2LIFjbxQ2ikbU5S0pKo
 aMDzO9eGz69uNhNWJcvIKJK6AQC9228Mqc1JeZMIyjYWr2HKYHi8S2q2/zHrSZwAWYYwDA==
In-Reply-To: <20231204141307.20647-1-alexander.deucher@amd.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------3heohFdnvAJnNlA9EqnDRBIC"
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
Cc: Phillip Susi <phill@thesusis.net>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------3heohFdnvAJnNlA9EqnDRBIC
Content-Type: multipart/mixed; boundary="------------5Rer1E62cfJ4WUIFNatcw9vW";
 protected-headers="v1"
From: Luben Tuikov <ltuikov89@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Phillip Susi <phill@thesusis.net>
Message-ID: <c603a160-8847-45c0-8be2-6a8025ba0fdb@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix buffer funcs setting order on suspend
References: <20231204141307.20647-1-alexander.deucher@amd.com>
In-Reply-To: <20231204141307.20647-1-alexander.deucher@amd.com>

--------------5Rer1E62cfJ4WUIFNatcw9vW
Content-Type: multipart/mixed; boundary="------------JlVvR7KcFeT30Mw3k15VQPoD"

--------------JlVvR7KcFeT30Mw3k15VQPoD
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2023-12-04 09:13, Alex Deucher wrote:
> We need to disable this after the last eviction
> call, but before we disable the SDMA IP.
>=20
> Fixes: b70438004a14 ("drm/amdgpu: move buffer funcs setting up a level"=
)
> Link: https://lore.kernel.org/r/87edgv4x3i.fsf@vps.thesusis.net
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Phillip Susi <phill@thesusis.net>
> Cc: Luben Tuikov <ltuikov89@gmail.com>

Thank you Alex for this patch and thank you Phillip for testing it!
(Let's also add a Tested-by tag.)

Reviewed-by: Luben Tuikov <ltuikov89@gmail.com>

Regards,
Luben

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_device.c
> index f29d0faf956e..b76ec5ec04c5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4593,8 +4593,6 @@ int amdgpu_device_suspend(struct drm_device *dev,=
 bool fbcon)
> =20
>  	amdgpu_ras_suspend(adev);
> =20
> -	amdgpu_ttm_set_buffer_funcs_status(adev, false);
> -
>  	amdgpu_device_ip_suspend_phase1(adev);
> =20
>  	if (!adev->in_s0ix)
> @@ -4604,6 +4602,8 @@ int amdgpu_device_suspend(struct drm_device *dev,=
 bool fbcon)
>  	if (r)
>  		return r;
> =20
> +	amdgpu_ttm_set_buffer_funcs_status(adev, false);
> +
>  	amdgpu_fence_driver_hw_fini(adev);
> =20
>  	amdgpu_device_ip_suspend_phase2(adev);

--------------JlVvR7KcFeT30Mw3k15VQPoD
Content-Type: application/pgp-keys; name="OpenPGP_0x4C15479431A334AF.asc"
Content-Disposition: attachment; filename="OpenPGP_0x4C15479431A334AF.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xjMEZTohOhYJKwYBBAHaRw8BAQdAWSq76k+GsENjDTMVCy9Vr4fAO9Rb57/bPT1A
PnbnnRHNIkx1YmVuIFR1aWtvdiA8bHR1aWtvdjg5QGdtYWlsLmNvbT7CmQQTFgoA
QRYhBJkj7+VmFO9beaAl10wVR5QxozSvBQJlOiE6AhsDBQkJZgGABQsJCAcCAiIC
BhUKCQgLAgQWAgMBAh4HAheAAAoJEEwVR5QxozSvSm4BAOwCpX53DTQhE20FBGlT
MqKCOQyJqlMcIQ9SO1qPWX1iAQCv3vfyJwktF7REl1yt7IU2Sye1qmQMfJxdt9JM
bMNNBs44BGU6IToSCisGAQQBl1UBBQEBB0BT9wSPcCE8uGe7FWo8C+nTSyWPXKTx
9F0gpEnlqReRBwMBCAfCfgQYFgoAJhYhBJkj7+VmFO9beaAl10wVR5QxozSvBQJl
OiE6AhsMBQkJZgGAAAoJEEwVR5QxozSvSsYA/2LIFjbxQ2ikbU5S0pKoaMDzO9eG
z69uNhNWJcvIKJK6AQC9228Mqc1JeZMIyjYWr2HKYHi8S2q2/zHrSZwAWYYwDA=3D=3D
=3DqCaZ
-----END PGP PUBLIC KEY BLOCK-----

--------------JlVvR7KcFeT30Mw3k15VQPoD--

--------------5Rer1E62cfJ4WUIFNatcw9vW--

--------------3heohFdnvAJnNlA9EqnDRBIC
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSZI+/lZhTvW3mgJddMFUeUMaM0rwUCZW+zeAUDAAAAAAAKCRBMFUeUMaM0r+wP
APwMyf1+TaBKFjRl86hsC/RIh/57tQFdExNFx8qIJe7j+QEAy4g8quJ+QUMKXmfMtla/KiTQVVXb
PiCrVDctJ4jp2gI=
=FwEs
-----END PGP SIGNATURE-----

--------------3heohFdnvAJnNlA9EqnDRBIC--
