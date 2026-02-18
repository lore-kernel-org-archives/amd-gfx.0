Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFAE4E9A047
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Feb 2026 16:30:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C1CE10E5EE;
	Wed, 18 Feb 2026 16:30:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LB1IUrlC";
	dkim-atps=neutral
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com
 [209.85.217.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C512310E5EE
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Feb 2026 16:30:28 +0000 (UTC)
Received: by mail-vs1-f44.google.com with SMTP id
 ada2fe7eead31-5fdea9f293eso223930137.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Feb 2026 08:30:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771432227; cv=none;
 d=google.com; s=arc-20240605;
 b=d7KF3HdCMyIltYbIlerGR5xMLicn9tDHXddWBVrMamYouMXNMKqvIWdLRaN/DMMKz7
 tSNYLyGcid109zldstib3ObszGD9RqKIKyPO+X+islPeLi1ueoQmJ1lKDxkJLY4S5jKN
 1BWd6+4FOAbsI7YGxzKI4D4v44KzfrFu2hAS0swLse/SiiK4F99RK/bFh85pQm2aRp3B
 NdwqJybYImCeakALL4yMdWhpwWgbNGwN+fiqa834y1XgS02N+M5VQJEV+CFqjbY3jaru
 zm0MDV9bpyDG2MDOgcoJ3r/A7XKTagZ3BiCHTuTEll3Ef+H3gewIx0pnpZoeErxmpnOa
 EPTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PZOiITdYmyZf0GPtnjV2dqfINh5ONOmyyWnifZNg6Bw=;
 fh=uzPxZJgndvSFkcCEY13r0np122d0Y5sU3RaqMGNdv14=;
 b=AJQDKcmBfioJuKjy+VixpRciMCrgiZZeBvXVYRPmzerunulxclnLtq+oZ13LSWwcCO
 BfPHMrD19jcLSEwB/BPE921DLy9kDV0KRFmxOrbwFiNAa7xSIlEvqPh+rk4lomuo+5Vd
 8IkfVA3B4IQHQh8RYgfVzN2heJ2pDYZrtj2ecQuA1KEUli+agyMdmZkk64XV7av+q9GQ
 lmoC87qLVCjCTPqKLA0bmrz7GLz+fGj4+iZkMn8UIGJ5aqjbldDVKwYFJTkpiYi8Y1H+
 Z5sMY7X09k3UtJQY8iEwp0Q6jF5GKc/Sce74yjxQT9HUJi3v4fOG3GgoKFANAZfnQr/8
 HTFg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771432227; x=1772037027; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PZOiITdYmyZf0GPtnjV2dqfINh5ONOmyyWnifZNg6Bw=;
 b=LB1IUrlCbPgs/GlnbHb59qitY/kPFdqrAA7P34IjQ/4IPg+nS6iVRwsWmrId5iQEI+
 oaABQpsoz3mcMBwZR0bvBxJoIG1bER9g0/yj2bCRPgXyiAWxelYnISVtxxsScwqKq8D6
 L9raTmrCp5URX7LpMp1XS5KlVuSbISQHgEayP8/Vvnj5qlx94vycVDy6Qsk9STNFCBaA
 G0QZ1L37dKP33T4pda4HiFET7fYaFvgMJfdrmFlaj1GOuwy/4QVkRD8TU83mZkhtOiyr
 1RMWEd95j3SZ0VC7sikNX1Yv4y5A9tKuP0ha+jIVV+QLS30utULXJ6HXqSdEU7pLFJt2
 hY8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771432227; x=1772037027;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PZOiITdYmyZf0GPtnjV2dqfINh5ONOmyyWnifZNg6Bw=;
 b=roT/YJXad8OiIsaoHmDjxo8czlyjgmRxe59NKdGesErJbiPSqQAoXeqFJoJjBGuavO
 wwVAjs0YOWBeUFIZc9coCvvwRseZbFbWqQ6qFa0d1tNdLSSc2lauPfK1iTpjlMrcS1fn
 I+WOb5ebAFIE9y6QSEQtN5cpmMnYuOMiXP4EKodq7YC2yOUsypsZinwoNOv+jz9oi/2k
 vlIqZzp6ynA2mALpLDOWkQFN+wjotPk6oX0CUZDtlG3oEiAWwbdU1rxxvaP4AdzNIRz6
 HGOl0DzNQIJ4eFz8i/9jV0O1YTRv+OBdhbHU8EAYKU4t/pYtlGIBxNS89R7kDg7833ru
 C4ew==
X-Gm-Message-State: AOJu0Yx6LMWCCKYB7NC634MZCQVD2E6cnYBtKp6K650jRZyauwH2pAww
 QEU4aHVR6mEFMMJjqtwI51DuwgdGspJl0P199hkmIFGaOQNNIIQIlUokof8lvQkzXCBH46wsn3U
 U3Jq6lXgAETW6KiGtNXI8waFfpz3Jd3k=
X-Gm-Gg: AZuq6aIjYdkaViXeqqVNrSG8T8qBtMDtEjVhlZGw2h6A1uvXS6ulUwrmixRbzpa8EbY
 Gte6hBq3NBJeAA98WHjpRKbycxCR+aTWk7yRpkjekWTAL9wdoLz2IzsIL+BG0k5VR3zcTGmkVVG
 SAP0/FZcvfATGl3KIjj2w2ZO4sl8F1DEU1V2IrZkQQgIndXsg/gq3Gpn0rAuj30ydcfphgZteMr
 Ma4lvPjvx1R6XkeovyqbxYSQfcT2W5f2CwKuzqby8Mj4ym0A9bpDBpR9MqEw1z/3uUcEzjdGeCr
 s5aUzme7KycRb2JYX0yhE+HiaTEFuj+em49LHDkPAKfscvvh8VWoG0U7sLOnrDwIzAFN2A==
X-Received: by 2002:a05:6102:6ca:b0:5f5:45e6:760f with SMTP id
 ada2fe7eead31-5fe16be3462mr3330567137.1.1771432227352; Wed, 18 Feb 2026
 08:30:27 -0800 (PST)
MIME-Version: 1.0
References: <20260218161135.803653-1-Roman.Li@amd.com>
In-Reply-To: <20260218161135.803653-1-Roman.Li@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 18 Feb 2026 11:30:13 -0500
X-Gm-Features: AaiRm53CJeJ2vNk4L3hzLTgMbdNl3Dvp2howsHbQLY2iymfyOc2n-CVU82V-8WM
Message-ID: <CADnq5_OV8h5V2owUTCFDwW-dQ-L0sUL1Y2480FSAgNTshVAdug@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/discovery: Enable DM for DCN42
To: Roman.Li@amd.com
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 Tim Huang <Tim.Huang@amd.com>
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

On Wed, Feb 18, 2026 at 11:29=E2=80=AFAM <Roman.Li@amd.com> wrote:
>
> From: Roman Li <Roman.Li@amd.com>
>
> Add DM ipblock for 4.2.0 DCE_HWIP
>
> Signed-off-by: Roman Li <Roman.Li@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_discovery.c
> index fc8c1f36be58..2f032a7d8e82 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -2301,6 +2301,7 @@ static int amdgpu_discovery_set_display_ip_blocks(s=
truct amdgpu_device *adev)
>                 case IP_VERSION(3, 5, 1):
>                 case IP_VERSION(3, 6, 0):
>                 case IP_VERSION(4, 1, 0):
> +               case IP_VERSION(4, 2, 0):
>                         /* TODO: Fix IP version. DC code expects version =
4.0.1 */
>                         if (adev->ip_versions[DCE_HWIP][0] =3D=3D IP_VERS=
ION(4, 1, 0))
>                                 adev->ip_versions[DCE_HWIP][0] =3D IP_VER=
SION(4, 0, 1);
> --
> 2.34.1
>
