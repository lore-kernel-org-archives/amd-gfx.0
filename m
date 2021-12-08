Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58259C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Dec 2021 19:50:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5EC56E89B;
	Wed,  8 Dec 2021 19:50:25 +0000 (UTC)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD22D6E896
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Dec 2021 19:50:23 +0000 (UTC)
Received: by mail-oi1-x22c.google.com with SMTP id q25so5659232oiw.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Dec 2021 11:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=vfUPmP59qc+LPTBiu7Lcq7GKBBSysyuo1puz5qU/VE0=;
 b=Ziyn3hb1YnPkj6OHNBA/UxKEU5f0vSsBRptFm3Ds71BGQIKCwMAt7SWTwqbt29i0a1
 chniuu+pYf2sBNSmsztlKmAS7g/J5KGc+lPwP5ZBnUnNcRTBCIr4NK8EmhKG30DEO63a
 dsCHAVQMdqCuG2SpnuAXnaoVR4kJetHXIBUS/xTLDkoDBHs7Fz5Zr/KGlt5ijvgDdZRI
 pyBZCjZeyoGodSdBrbQUudQzH6N0gJe4R6mN9z7fC5avXUciT+Z+FZhFZRPNIzZuTAR0
 7LhJHXeHw499ZzVRahGcKC/rscVFquNHl+NFVHx6QJlfC9zWDNFp+wPLFjq6NRFRoRpO
 NwXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=vfUPmP59qc+LPTBiu7Lcq7GKBBSysyuo1puz5qU/VE0=;
 b=d2POdkyXS/XM62e3nx7Q7IIbh9RnNvGXSYAIRICPEWvo3atSctrPFpdB+2Byt5l+hS
 CzSaLxbc/kYIMtbRi0Xkh1ixmi0q9eOEZYVxjWirkTR8V7K4sVdwfr1X9AylCzHf78rN
 DZYOsokADLilBo/htreQcUNodQ6072w0zdbyjBSogtMqnftpm8q0krSKJJt/wwpb5G9x
 xA8foJIqfLTPsV1dOPZ6remI6yaxnjgGAOJCnO/2UJ81WnboF3ckLxay01Y4MgSycWNs
 FYrefadmSVQiu1h1HluVyo2eY9Kla9by8A/2R8Oh/S+jiNuLVxq2jwttVE0tyCUzwvjt
 dH3Q==
X-Gm-Message-State: AOAM5308niP4bcRwXM5xOICxCKQRvGvqjAOJuxyS/X/TeLD7WbknnlLA
 FrjY9JDrIfTqlw3vnoAnJthz3umXbXOjYSVMmb4=
X-Google-Smtp-Source: ABdhPJxi2TH3SWpXqnE1LXPjj8wJi7RAWzlTab9V33i96PS/Vk18BoGxFpE0HoiOFzzaZXeKVAcyFSdxx89GGEdSIPk=
X-Received: by 2002:a05:6808:300b:: with SMTP id
 ay11mr1480064oib.120.1638993023109; 
 Wed, 08 Dec 2021 11:50:23 -0800 (PST)
MIME-Version: 1.0
References: <20211208012529.372478-1-isabbasso@riseup.net>
 <20211208012529.372478-9-isabbasso@riseup.net>
In-Reply-To: <20211208012529.372478-9-isabbasso@riseup.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 8 Dec 2021 14:50:12 -0500
Message-ID: <CADnq5_P_iynZK2+HcpkoZe14nAsrmSNZ2BbnrmnX5LjFR-1zBA@mail.gmail.com>
Subject: Re: [PATCH 08/10] drm/amdgpu: fix location of prototype for
 amdgpu_kms_compat_ioctl
To: Isabella Basso <isabbasso@riseup.net>
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, ~lkcamp/patches@lists.sr.ht,
 Daniel Vetter <daniel@ffwll.ch>, "Deucher,
 Alexander" <alexander.deucher@amd.com>, "Wentland,
 Harry" <harry.wentland@amd.com>, Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

On Tue, Dec 7, 2021 at 10:17 PM Isabella Basso <isabbasso@riseup.net> wrote=
:
>
> This fixes the warning below by changing the prototype to a location
> that's actually included by the .c files that call
> amdgpu_kms_compat_ioctl:
>
>  warning: no previous prototype for =E2=80=98amdgpu_kms_compat_ioctl=E2=
=80=99
>  [-Wmissing-prototypes]
>  37 | long amdgpu_kms_compat_ioctl(struct file *filp, unsigned int cmd, u=
nsigned long arg)
>     |      ^~~~~~~~~~~~~~~~~~~~~~~
>
> Signed-off-by: Isabella Basso <isabbasso@riseup.net>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 2 --
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.h | 3 +++
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index c5cfe2926ca1..54c882a6b433 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1360,8 +1360,6 @@ int amdgpu_device_resume(struct drm_device *dev, bo=
ol fbcon);
>  u32 amdgpu_get_vblank_counter_kms(struct drm_crtc *crtc);
>  int amdgpu_enable_vblank_kms(struct drm_crtc *crtc);
>  void amdgpu_disable_vblank_kms(struct drm_crtc *crtc);
> -long amdgpu_kms_compat_ioctl(struct file *filp, unsigned int cmd,
> -                            unsigned long arg);
>  int amdgpu_info_ioctl(struct drm_device *dev, void *data,
>                       struct drm_file *filp);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.h
> index e3a4f7048042..8178323e4bef 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.h
> @@ -45,4 +45,7 @@
>  long amdgpu_drm_ioctl(struct file *filp,
>                       unsigned int cmd, unsigned long arg);
>
> +long amdgpu_kms_compat_ioctl(struct file *filp,
> +                            unsigned int cmd, unsigned long arg);
> +
>  #endif
> --
> 2.34.1
>
