Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE992CA5FC4
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Oct 2026 15:34:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1110110E618;
	Fri,  2 Oct 2026 15:34:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="R5VrtwHJ";
	dkim-atps=neutral
Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com
 [74.125.229.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED09B10E618
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Oct 2026 15:34:51 +0000 (UTC)
Received: by mail-dy2-f43.google.com with SMTP id
 5a478bee46e88-33e79c06622so878704eec.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 02 Oct 2026 08:34:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790955291; cv=none;
 d=google.com; s=arc-20260327;
 b=o7lF3aAmhh1nt/uS+Pm86E0W7w/T+xUcVu9RI+2rnujRJingwVHIy+WdACByJH0+sq
 QDeA5zYTLLWIB//eu4GkCoZ+0iJhjhncASECARDNQBuGbVNvIn/oOunVFjjdBgQl256u
 sJ1d1h2ZrcR5JfsS7yhI0vOPu83INIdyX61LkcyMFR2MbmIFFJUMj8sFfHNf04SUiX/X
 MiREkl6qLpiGckfOQ8HPQdaKuBJItMa4Cm5jSkrgVuqLZf5lD/o5ReYt6kb5Lx6uYpaA
 BIZxXHS+XTV+zYplMEO6wSZfoSDyjfD7ftSvMPAHQuWbYTewytUpJ6UTosVb3jLJRvC7
 aMgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fu9f063BSay+kKUreqH5qUaqH8WP1zt+eN04ndFcmPQ=;
 fh=sjBhvESLaW/EhyR1JeRMPVrGAZEVhivFcDDWAoTEjJE=;
 b=MfOIrIzgOljSVcheWC4F1jcVDwl7irbGx6AsDXFQRXjxHnvo6qO6d3jeQC0bMzRSJH
 C+A9zb34JaSpTGQRLDuKtZY6Mt+tkFXdTLXXUkp4takgXgKNZXEDGqgZrQmgH9AyBGLh
 f063XlmpN6u85B6y62DQUVbZlQnneIku2cqqXkCPHyXDblSJROzzGIjZy7s+t1yaB0i4
 2Jr11Obab85LpEFEVGP1LwzoBG3wEZ6lnSPyw3lJxSlJ9ioJX8ko0VJxB68UDzFmVGs7
 JRvIZLfAwWzACUe5b+OyIIpdWY+P2fyqG8hXo2lg9sZaj3Ww/1l1A3/mBPgaFK0Zs+fL
 fg0w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790955291; x=1791560091; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fu9f063BSay+kKUreqH5qUaqH8WP1zt+eN04ndFcmPQ=;
 b=R5VrtwHJqBOtprC9bs8EC0cns2+i7U5mhEDrDkfGnTUzN/NIAVA++sL1bEkFVxdPyL
 CuyMHg4KbkkktSR4biRga/GFJ+kaNAOLDzLf2YZZ9KZ5UHg3cD/iUPqoZrg3IqHrXwQW
 Ey3CMC6o3+ZGcUTIH3u5dCPIq3A2PLc0QrU9tt1TnTUvJuUnsgrsKpzvlQuJ/lErr0LS
 ox3ARxu+H8tPZiH/vMHaQaSNHxQvNifOqlW+eHCE2715hFZzK/t17PulmlkqDbvQyzUv
 4ZVhTC2+TRZxxLJyeRUCEdIeHwPqdcOLRw9d9wPQYoqTNg/wGmTkOdOoYr/DlY+Q8AUx
 D3Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790955291; x=1791560091;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fu9f063BSay+kKUreqH5qUaqH8WP1zt+eN04ndFcmPQ=;
 b=y8lwz7aOPmoHml33QkJQj+zIgFPFsnBHB8qUlstlWoB7h0WxW67BlIu9yczzccaA+9
 sTEIdvrTmpJQE2jPRGCme7bDPdfTVGpdzSAgLhaRn6pn0/DcluuOb7WTcl0TStiKc9K0
 Om+yu1UOmI9mAT3isfLaRWBFO865lZNMpBxsLOHOJ4jNvfixFTr/tz4h/5LwqxUvTGPQ
 e5addQmc3pMHPisVHGz/iOhfT20z/VXdTlATQ4z7ZdcFbe2DAh95cxF7/P/IT7qYDuen
 Hzc5t0aF30kkcAYROZY9cN/En28g2M8WdBZda9NkiONcXVFyBD5zdeVBqhVFiy1uU433
 DKOw==
X-Gm-Message-State: AFq9FYJNDAdQKhozeRL/Xw4ZUCwUnWpNSsOI4fwJajCSdc7spbPLSmAZ
 CZzmGUa84i4vEwzKJMGZP7qI24UU+opNfyaZlvZGv07cw0hUfkrV9IwMIwCot2lap1dl6dGz1ke
 BBq+xBWVctFN2k+y4GvsjFCgyqcFnk9g=
X-Gm-Gg: AYBFou3Rw8qn+NV41dc9PBABm5f3KtDMl/q72df0FNyzbbjtkmm9Y+DhayncUsy9v3k
 ++EAKIRgCdNsTrW1p+pYmALvaTUtyGPE0Pw4dlqFHsHUt5Sf7TY75/KgVgJxAl02NQ/1J/aFTPT
 sYx5ZawXUPmrx11PwKT7fALtH8tcLtORSy640cEdleeG3JAfTLfoykOtDBZmGorpMVpunL18lhH
 anB8gXbfxsmwjauAYtCXSoGJOqXO9ppbZluzX9nz1tidR9gPnx4s99oTMTCRTPJ6Uk+RCP3nNm+
 w+KaYaWcEX5hL5OJVvrNe01gEsO+lSUEednYmm9/bwWfyHPzPVykYo3UBymfgzqin42FwLKeHHx
 P4k2Y8YncXs5CM5havx0LnpVCRDEb/gVYMeS2Oazw7A==
X-Received: by 2002:a05:693c:864b:10b0:33e:4e49:d08d with SMTP id
 5a478bee46e88-3510d2815f3mr1257340eec.1.1790955290989; Fri, 02 Oct 2026
 08:34:50 -0700 (PDT)
MIME-Version: 1.0
References: <20261002145248.30879-2-david.rosca@amd.com>
In-Reply-To: <20261002145248.30879-2-david.rosca@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 2 Oct 2026 11:34:38 -0400
X-Gm-Features: AclHuK-O-NzuFQokiY7qL2pN-JLf-g1GvibMSI139UDTs2kplIEC6BF3tz4040I
Message-ID: <CADnq5_NO7sDFC0m6cwfz=n4BQG7a6us0s343HRuq4nN0opDr9A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Allow VCE SEI command in IB
To: David Rosca <david.rosca@amd.com>
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

On Fri, Oct 2, 2026 at 11:31=E2=80=AFAM David Rosca <david.rosca@amd.com> w=
rote:
>
> Mesa will use it to get the slice offset in bitstream from feedback,
> which makes it possible to filter out SPS/PPS headers that VCE 1 and 2
> FW always forces on IDR frames.

You probably want a driver version bump as well so mesa knows when
it's ok to use that?

Alex

>
> Signed-off-by: David Rosca <david.rosca@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vce.c
> index 39d87f3df9e0..bfad44ec7feb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> @@ -920,6 +920,7 @@ int amdgpu_vce_ring_parse_cs(struct amdgpu_cs_parser =
*p,
>                 case 0x04000007: /* motion estimation */
>                 case 0x04000008: /* rdo */
>                 case 0x04000009: /* vui */
> +               case 0x0400000d: /* sei */
>                 case 0x05000002: /* auxiliary buffer */
>                 case 0x05000009: /* clock table */
>                         break;
> --
> 2.43.0
>
