Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81660FA1FD7
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2026 16:56:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F12A610EEF1;
	Wed, 22 Apr 2026 16:56:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kgVGYWUb";
	dkim-atps=neutral
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 515AD10EEF1
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 16:56:30 +0000 (UTC)
Received: by mail-dl1-f44.google.com with SMTP id
 a92af1059eb24-12db2e9b3bcso280798c88.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 09:56:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776876989; cv=none;
 d=google.com; s=arc-20240605;
 b=SqNN1H813V0nRP8d7ETdfggEvBlla3PZ7CMtJ2le8rP9Nofy4PgS1Cj0F/odih7VK6
 5R7vA0lhoC929ZyjiHC+Ljwa+9I4X+pzeAjIz/9N/Bf8+j8rtSzUANWcWXGt9186C+m7
 HsCjv+UWZORaUHs37XGrp/XfYYP0M3xG4aSVxLdogWdy1BN1JkaYrMyuACbq0dOWFv97
 oTnLUcl3dcTlnftRLjnMEOrxX+ZRHztAopH1CDo0DpFbnYcAwiX8xrxxn//YFKk3PWVr
 +knM1KFXEFmAH5y6F7XcZBoJ/kGOOZAkXuZLSp7qUTENiSoGWvBzZmlD0JnejnixAJhb
 +4Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=OojRBDFDIIdZR3BWENJt7a7Gu+luw6kbzdUuLsqds4Q=;
 fh=C+Wh2jdKSgjkbUsoogS5/bLUH6rJmLHvu7+yaR0jyHY=;
 b=chuaXuTYuPj8OrC6qSdPmErh8ZWbn0GMjYBrRBHi8miFRyQhfFDJTejqXVxdW+bh7h
 RUhZ8ByMGgYCFnxQlx6M8Z1vj+9pOxh1NmS8KoF8hWJ5UKV2LRg1H+c7kEiUyhUoxowu
 6PvRkR8FGbriKpL918CghCV/muYDopUANWbgr/PUAF1YYlITycubLz1HO+APCI4OIRc1
 7MF27zXVz8gmqhYoaUh1jxjTj1o8SrRXTvIJxk4i40lhTl4vZl6kvy0a3/YUxgcCAEAJ
 r9+mduJxZ5TIT0eHB6XeWNkHOpdrLd96powlCj1RRRKApirXxUuZnHZK8rjhZNsBACPq
 xlqg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776876989; x=1777481789; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OojRBDFDIIdZR3BWENJt7a7Gu+luw6kbzdUuLsqds4Q=;
 b=kgVGYWUbZQDT48i9WS4a3QdmBlUtzgN244DfJp2VnUqbHiOV1CrlOrMnJbNbuHfzD/
 cu7kR+F1ieUW0uN27hadTGvEDtr6sthuiTFG2Nd6/ebywk/mqTVTa0t/YUqI23woDKlo
 CuB4clyE9MgG8LY34bfrixBWLKsalLYErPUpCJBQGoo+2XS69bp1IDuw8cIcigNS74lf
 tb70h5Mjw4BaDej79G7lUmw94O5rFkx9wz09Eg26cpum9Uo2vjVI21Ygsn8IZiPWUmwD
 ahz9Wl+iRb9mHTDkddyMFumk1yEa6zlT65rzfa+qvUWACCrFwh+IMj7wAMbEV/PnCeOz
 SC3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776876989; x=1777481789;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OojRBDFDIIdZR3BWENJt7a7Gu+luw6kbzdUuLsqds4Q=;
 b=Y/BpeYbXAvU2oWdHczYpaalL/+mXi0Jknx285zBJ1r/S+anlkrP3aDpHUvKbGOmmHz
 b+YcQEYTUI7TxgVuaEYJUQciA0Di/6GTOSbBo8xOMlJMgvUuKDzDUWo20sbarR6xQ+a6
 upisDQ6NSHlCv8mXrIkoxhNSwNF8RogL1l9Md+JVd+e+SfM6YNqQN52gnQUJUzuReCiR
 fAWjSJgh4s8HtZH3lBj1QH8oFkTlIswFBGLFyk0akGhBwjmxOL9z1Zxn6N47mHnSnL6O
 KNTtDxHcCJZe2Qp0Cm5+iGitOPqOBrV3ro+FW9TGnzEPykMzywFOdIrziRPYD7IP4mGo
 TcJQ==
X-Gm-Message-State: AOJu0Yzs87cE9fHIYRxDZ/HqEDpGo/70BmFWDZXaXhrDY80I580t2SQb
 CKtvCnb4p0rRYHmc5KdVYzOK14oAvoJ82+4+hDP0NykZYJ1o0SpDU1lO4+f7qSapIee9p5RATuh
 yRp8ynM5j4IdTuaWPKmIza+pj56p7Ya0=
X-Gm-Gg: AeBDievltOIeYlbfT5XOVj6DW6obaB5pPzLoMXHbNiCQANwovMaKoPRQ67PgiHK1bAb
 Hf2vmRqKjh6tuFGMpCPTIIl/GFa0lbIF1ZWHNiYZuQUWgHGqxmrnv5nyCJXR1NVHI9BFfN151XH
 IN0HtyGS2pUWITdsRATXCjQhZqw75Qymp+AcN5tcWYnjeZdCf5p5B0+3LODoyjH3wecilg0GbLc
 FOvcuR5+vQwfVyBu4ldJm4i9nIKcJQGxTAm2/eThznXFKIj4tl1hFgerATH662h/7/t2Scp70Qk
 RfWOsROc6TyhOwqnMfPkSycchIRnh+DDXEhfnq3YNCJgEDoat9WA0Y9vQiq4mC1/D8P7JivI0ke
 N+i3weKELVkD/hNg=
X-Received: by 2002:a05:7022:6b97:b0:11b:ad6a:6e39 with SMTP id
 a92af1059eb24-12c73f97796mr4503914c88.5.1776876989352; Wed, 22 Apr 2026
 09:56:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260422162956.620362-1-sunpeng.li@amd.com>
In-Reply-To: <20260422162956.620362-1-sunpeng.li@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 22 Apr 2026 12:56:17 -0400
X-Gm-Features: AQROBzA8X_HznQYPthmAG1DOnYsxrf075XbF75tbmIHFKTHf3mAp6zlU5dVB72k
Message-ID: <CADnq5_OYNSoWteuXDJrCOtj4qYn2q+vyXUKZaHvgNN+5xFFg2Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Restore 5s vbl offdelay for NV3x+ DGPUs
To: sunpeng.li@amd.com
Cc: amd-gfx@lists.freedesktop.org, Harry.Wentland@amd.com, 
 Aurabindo.Pillai@amd.com, mario.limonciello@amd.com, wiagn233@outlook.com, 
 sysdadmin@m1k.cloud, stable@vger.kernel.org
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

On Wed, Apr 22, 2026 at 12:49=E2=80=AFPM <sunpeng.li@amd.com> wrote:
>
> From: Leo Li <sunpeng.li@amd.com>
>
> [Why]
>
> Rapid vblank off is causing flip-done timeouts for NV3x and newer
> family of GPUs that support more idle optimization features.
>
> A proper fix requires further investigation. In lieu of it, let's
> workaround it for now.
>
> [How]
>
> For NV3x and newer family of DGPUs, restore the old 5s vblank off timer.
>
> Fixes: 9b47278cec98 ("drm/amd/display: temp w/a for dGPU to enter idle op=
timizations")
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3787
> Link: https://lore.kernel.org/amd-gfx/20260217191632.1243826-1-sysdadmin@=
m1k.cloud/
> Signed-off-by: Leo Li <sunpeng.li@amd.com>
> Tested-by: Michele Palazzi <sysdadmin@m1k.cloud>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 3fa4dbda4517c..ce5063928413c 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -9511,9 +9511,21 @@ static void manage_dm_interrupts(struct amdgpu_dev=
ice *adev,
>         if (acrtc_state) {
>                 timing =3D &acrtc_state->stream->timing;
>
> -               if (amdgpu_ip_version(adev, DCE_HWIP, 0) <
> -                          IP_VERSION(3, 5, 0) ||
> -                          !(adev->flags & AMD_IS_APU)) {
> +               if (amdgpu_ip_version(adev, DCE_HWIP, 0) >=3D
> +                     IP_VERSION(3, 2, 0) &&
> +                     !(adev->flags & AMD_IS_APU)) {

Why only dGPUs?  Seems like this is reported as least as often on APUs
if not more.

Alex

> +                       /*
> +                        * DGPUs NV3x and newer that support idle optimiz=
ations
> +                        * experience intermittent flip-done timeouts on =
cursor
> +                        * updates. Restore 5s offdelay behavior for now.
> +                        *
> +                        * Discussion on the issue:
> +                        * https://lore.kernel.org/amd-gfx/20260217191632=
.1243826-1-sysdadmin@m1k.cloud/
> +                        */
> +                       config.offdelay_ms =3D 5000;
> +                       config.disable_immediate =3D false;
> +               } else if (amdgpu_ip_version(adev, DCE_HWIP, 0) <
> +                            IP_VERSION(3, 5, 0)) {
>                         /*
>                          * Older HW and DGPU have issues with instant off=
;
>                          * use a 2 frame offdelay.
> --
> 2.53.0
>
