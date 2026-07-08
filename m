Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07184C43458
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jul 2026 17:57:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7393E10F201;
	Wed,  8 Jul 2026 17:57:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TYneZesM";
	dkim-atps=neutral
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4436210F201
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jul 2026 17:57:41 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2cc7e132d3eso1465585ad.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Jul 2026 10:57:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783533461; cv=none;
 d=google.com; s=arc-20260327;
 b=TKjByD+E7zr+vKmoCD6WUQjkUrhXvXi7xm371yY8jkcred3UUOg353UA88kv3YCJtt
 xNmvP0yLrUYcB1+ZrJwg4vqpFpuRjxz0DS+J2rMuKBXFw40zEBzGundoOtV+lgrDWWie
 aG3J4UJFsltDVqd/qBeNIlKRmaFNELSNqc4fHLp0//tZpBtvFM8emYeoJgMrccFTbGpY
 ghBoxv8AUyOmXkwhA6Ks/oDWO+bY5FTTJo8M9qwYA5wUVEgNAa7y+RBq4OIQhWQtqeHr
 cXSwEPYE5iK74gCk28+dSa3Hm6VJCmogq5ftAWpWQf4AZGn3iLBId1jssQMPvk6mlwO8
 UGGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PUf7knefPDa2rYyrUw9CFxG6fNnc4WIWpriwdXbh6PU=;
 fh=xw/4MfAq5mkwaCWTPWK41pFCvYR79moo62GoVQ/OTMY=;
 b=NJLwwAUhIxHqPD2kw/o3ePPaGy4Q79BS490Wafm7qYZCN4y91jUNki23C28Df7S4Fu
 9e3zTsFHR45ow2fLS6rZJa2qeCoFWooyza5vpHJdAgt40ZfL5lTyCL4ORVXXEIihNVzc
 25x6U4DEl8yPBHC8L9+u/UmxXw92HoIWGRcC3WG6e8pspuVZNC3j4c/fu4t1lOQFFMsk
 pFo2fej+4hs8y72mQNCm1QldxhABKfZxV6JV7TKk6wZum5KGhHk9pvGPeqEGHR+eeURb
 ecrbFIZvArMEmpBKOer9974E+joLQ3VpGRulfQPGH0fq3z+py7VkNM4ZMafG8RdVxqcI
 9YGg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783533461; x=1784138261; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PUf7knefPDa2rYyrUw9CFxG6fNnc4WIWpriwdXbh6PU=;
 b=TYneZesM2l7BlX4XNXPXb8XBFohHFfhvBD/lyMUeMNL+Mgsei3TPmREtrEBrXPHjuM
 HWzFVfoV3r8T7dAfCF7Gg1TuWtGriIzDW+3dRM3MMYrxJfvKwTXEjKZ4MxFOClMuaTXx
 zZ3QaBnsA3P+ti2Rfk7VSmccLy5cYvs9WHUUjgo0D4qisCgXfBVdcQzlE5oUl5hgYEVk
 /HP7995/j7Kyh7PLFtUZ0dntz1jrVNGFx6jb/uujIWPtf/f7+h2qoCuuig4v/k6YpgUh
 R/fltRTk+UQKIph/9IfRzg1hnZEJm79znqVIp/XiaV83eKfknfBd09nFCUe+mJRL7w68
 S6Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783533461; x=1784138261;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PUf7knefPDa2rYyrUw9CFxG6fNnc4WIWpriwdXbh6PU=;
 b=kH1qiG2frGvY/0y5gwZTiLVDIIhC4JQ6QuD5P3aW4KxVVwTL6iZZfv05LgdvJ8T1yh
 OMT8J3EZ07dqhFq3sUiujNDft4j8LyEg9ancYwMuxQiadoNMYuDgT7TzzPVU8/1MBqds
 YsaU/JmhCkRKLCjRdatyZRcBVdTBaRNtlM3hrLnVjz0zt06WUup4f7aqMzrRA5pnGVbV
 s0eDVGuvPRG1ZmGLleC70wBiwNz5+P2WXx04b2G/hihNASp3zdHs6iVIrJPwP1TejwcH
 oQP5svShokqBNQRk1y3gVvuebngBAWGgDlkRsvF4DXgtXMkwyYKi20SoEWF1XBVXbGIa
 0shg==
X-Gm-Message-State: AOJu0YyFgCrtEtPOwp4glfxt/IaYWPb0LEoZHj83TrFHm6H29O9DtGWc
 LWLdrz2g1J32jrQoFclhyQd93TpipFkKEdIqVSTk82RzvS+lBJ28TCEcDdtN9HjyeGDEqq5U+2X
 lXaykPIf/qHYx6ILUa2N9+uSQNtsg0TU=
X-Gm-Gg: AfdE7cnOIrUpOs+QkGTo/U9MEu/S7lopjf1Xv4IsVFFXfQt8Kh1AM9L43HRHPM96GI+
 8Yaw3SQinQVrNGmbUSZZroDR9iNCsuurpzX8lrhijyPR2xBj5EDWd/+NJCUR1riI+SOx1uPt77N
 Iw82xuIPYcm6O2qFRcCip90HYF1ecXyLNF8EcXDOsnFmmWSRTJTylRubsfogQgY6fiPs/tNjM4U
 yLsc8Zs8MVk2urUW7DexfSwNHUbc8vRMigWwbstVyFy247aZo90ll0Wfxfu8aF1jpzLun2ywHb7
 N0Mj7Vjdx0cJS8RiwlKV/OBVAMXTDDkGKiItNEVQOLzGAceF5r64IEZ1InASONEgqvKpJg==
X-Received: by 2002:a17:903:1245:b0:2c9:d8c6:1db3 with SMTP id
 d9443c01a7336-2ccff1bc448mr3689975ad.8.1783533460673; Wed, 08 Jul 2026
 10:57:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260708174501.179428-1-Roman.Li@amd.com>
In-Reply-To: <20260708174501.179428-1-Roman.Li@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 8 Jul 2026 13:57:29 -0400
X-Gm-Features: AVVi8Cf9WMmozE5NpGUKix_3jgf_Bs3ToXIVEE5qWxpj-WpPzOLJSCbExMTf5Z8
Message-ID: <CADnq5_OgAYKtoh=FMY_XQkfY0+WeRxn-oDztg-qEJNg8mFM9vA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/discovery: Fix device family for DCN42
To: Roman.Li@amd.com
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 Kanala.RamalingeswaraReddy@amd.com, 
 Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>, Praful.Swarnakar@amd.com, 
 Ivan Lipski <ivan.lipski@amd.com>, Matthew Stewart <Matthew.Stewart2@amd.com>
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

On Wed, Jul 8, 2026 at 1:54=E2=80=AFPM <Roman.Li@amd.com> wrote:
>
> From: Roman Li <Roman.Li@amd.com>
>
> GC 11.7.0 and 11.7.1 should map to AMDGPU_FAMILY_GC_11_5_4 for DCN42.
>
> Signed-off-by: Roman Li <Roman.Li@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_discovery.c
> index f33278fcc0f4..f52566e05caa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -3368,9 +3368,11 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_d=
evice *adev)
>         case IP_VERSION(11, 5, 3):
>         case IP_VERSION(11, 5, 4):
>         case IP_VERSION(11, 5, 6):
> +               adev->family =3D AMDGPU_FAMILY_GC_11_5_0;
> +               break;
>         case IP_VERSION(11, 7, 0):
>         case IP_VERSION(11, 7, 1):
> -               adev->family =3D AMDGPU_FAMILY_GC_11_5_0;
> +               adev->family =3D AMDGPU_FAMILY_GC_11_5_4;
>                 break;
>         case IP_VERSION(12, 0, 0):
>         case IP_VERSION(12, 0, 1):
> --
> 2.34.1
>
