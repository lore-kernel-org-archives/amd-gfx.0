Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F484C61DC4
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 20:22:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE66F10E339;
	Wed, 26 Aug 2026 20:22:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qsnFsVGy";
	dkim-atps=neutral
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8414610E339
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 20:22:15 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-381f03d7be0so184473a91.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 13:22:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787775735; cv=none;
 d=google.com; s=arc-20260327;
 b=pbcyEK31cbR/gWdaOra2fqDpE75K5roBZUJvu+c1t5WJnSkvdwvuL2Yp9tdGZ88fp0
 OUwvEfIAmvzVFf/fAjB7G+AD/o9kN1//CxFPAPSDfVYWd+ja9mEFAd0lYtqcyoX9ecja
 EX0VYU5sYEixfibv4haC/ZndVZ+sBsHcvxKQ7r88V9/hy1cAhjBvUg/3hKJdTRltx+Ij
 rEYJaHj6YWC4zwOFw61MM34zfx3zcugT6wAiO3Zt68L1v1U5A7//KCdZOSUamD1UUFpv
 eaU2OLFtoER8Rmlkms3LC6MQqC3kKO++XfIcybCEVFjYtA53yie6+jMJqs+0G70LQwfe
 6jQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BEAHXUxB2VWuC97VageNwTEoOJOcxIW3TPD295GmCv4=;
 fh=ZKSYetlztaw6MtCqim8VNAWmOwy/uAV7uAU6XiQzmJ8=;
 b=Ybr3Av+A5r5OyQfekLWE21B36nD96bNWYmMbxIPblYqcnFuyMEBWaB44hhNxORNQHX
 Xi2y9dkNHd70AqJdD8pNi38UWJxG2XsPxePE+/X5kUr87hkHJD5pj2EWImmMp56XlqmX
 DxAmM/Vjl5RbKOCYYTC7VpH/7dW7CqCyA6OnoA1/PlI33aqJc3HqIOKgBmdtnCBI1c/i
 dIGi902GDL7lLrDUNXYD1VYkIa4ep8BeLwKCbA8lEQ7JanjP55eULNMFhCG+VlAcWZvO
 03/16kFv2FOTY945udq97+6lLwLyk1DKfd6qlNK4BkBNOPkYFzIebjyxZT4GVVFyOoyL
 wd6Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787775735; x=1788380535; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BEAHXUxB2VWuC97VageNwTEoOJOcxIW3TPD295GmCv4=;
 b=qsnFsVGyYqB5i8putfUBTw3VAV0m6/QOYKVd+fRUXUOB93GnAkSlg4fUwN3l0u4ZhD
 RBnZk++L2tGKydsVPipCILwEU2FbeVDhANoyBC2l6UlqjV2baERo0YMM3ErhUhhTY6dI
 EDntMBOYoux7cuMXXYCM1EbFE014vAugI/PeXwHKfG7mnU44SwUnX+lguHvmiJJjbVpY
 3wj3Wl9IeUvV++kxXF2kPhWC++AUWFu7uoKabI3vMxZ+K1VRO1gN2d5F54F2p/fpbA8f
 yaQ2+OIlM88hvK5/E9d9LY3kFLHYbDb9FQ0ncptNg0XGikChgaSbUqOXwaj0YOgYgApP
 xpKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787775735; x=1788380535;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BEAHXUxB2VWuC97VageNwTEoOJOcxIW3TPD295GmCv4=;
 b=BzkwuQFYhi5Mm6TAQ0WQIR6id6YN3pB1LDXekcpHITVIfFk31epGI7TqoZ/itLR8HG
 NRnpyxZBN3qcE0k+RItZ/p27Dig3eMwJiKp1gV2Y7BtvL5fVTG5O7L5jss38Aa0jU69e
 WjpnQktnh5R6cYSNfQDo/I3pWX8CYo4q1LdMuna+MjYQnH6ki0bsVkP2/sLa4ZMvuH/y
 H2mhydZ/sB5b6RoHTRSCMXOMbkWXzKsz31ort+v7rpQF5vrqpr0Cxr1Ffc/g4+bOQMKh
 q38UmpvK8NDFOCdvFe/OTc2tYun7r2+lx8Pa6jAIsn3rIAx9iYvqbbE04Y96+fZiKduQ
 xY+w==
X-Gm-Message-State: AFuF++n3HURiTn3KpeWb4PKSQ2UpdKlgEE3SNK9UpGYDZGGSrTS+ieRd
 x2v++VFY5to7kAjeBiGDECG3uP8vdfNpKGy/THLV8TW0QBzSLZqW2uiZfmJw7OQUS0jpKfJ12Y1
 aVqkHeIok9cJ9NdSRqOjDFRniSotGINU=
X-Gm-Gg: AR+sD12KkO1vpFrUlDj/3HcEfwBq2Tpl/EL/NZzuAjIjpGGJEADNN6yk+ecqTHiqh7p
 gtEzdo3qX8qRCsSyS4+OUmEw4K6/XboBBMbFLLYMRoc57CXasvuPyozD5kg4zkhV+doRKehc8QS
 KpT4Uu+mECn01Mh4qbAUTZ96EUWBPX4+QrjMI3IuNqGLBphUPbCYhG+ES4UFis9eGcnWQk9lKXH
 0mZQ5zgz4uf9149D9w06tu6jZAEVNWXUcxbFSq5GJReCx3uDzjY+pknGnvN+g6AY1Wlg/eOT430
 UpWhzMeD5ihmWgBXJQt2edEs8DezIyWhnpqoDbcYooWOFfR2WAR6Lh8rU6D771QHqai9IC5S3nr
 lvvjBrWQZ+ovYBIY9CkvZrBdht1iZVPY=
X-Received: by 2002:a17:90a:ec8b:b0:396:54a9:8d87 with SMTP id
 98e67ed59e1d1-396976a3e62mr2440677a91.1.1787775734966; Wed, 26 Aug 2026
 13:22:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260826185102.2269511-1-mario.limonciello@amd.com>
In-Reply-To: <20260826185102.2269511-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 26 Aug 2026 16:22:02 -0400
X-Gm-Features: AcwNN1Xv4Dw5HMxryl0YtcgdqHYDqXKXfb2-Aic9flqetBfAx3wECFQmD2BdJPY
Message-ID: <CADnq5_NFjs_i_bgjKjsk1atzZ2VKvoyH9Lx8CagEzSkOxgfsqg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: restrict BAR0 fallback read to SR-IOV VFs only
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, stable@vger.kernel.org, gloveless@jqluv.com
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

On Wed, Aug 26, 2026 at 4:10=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> The BAR0 fallback read path was introduced as a workaround for SR-IOV VFs
> where the VRAM aperture is not available during early init. Restrict this
> workaround to only SR-IOV VFs where it's needed.
>
> Cc: stable@vger.kernel.org
> Reported-by: gloveless@jqluv.com
> Fixes: ea8ac194077d ("drm/amdgpu: reduce early full GPU access during SR-=
IOV init")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 3603f7109703c..251c4aea013fc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -765,6 +765,9 @@ static int amdgpu_device_read_fb_via_bar0(struct amdg=
pu_device *adev,
>         if (!buf || !size)
>                 return -EINVAL;
>
> +       if (!amdgpu_sriov_vf(adev))
> +               return -EINVAL;
> +
>         flags =3D pci_resource_flags(adev->pdev, 0);
>         if ((flags & IORESOURCE_UNSET) || !(flags & IORESOURCE_MEM))
>                 return -EINVAL;
> --
> 2.43.0
>
