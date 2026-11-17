Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F84606A32A
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 22:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GRTViG4X
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF31610E52D;
	Tue, 17 Nov 2026 22:47:00 +0000 (UTC)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com
 [209.85.222.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FEDA10E5A1
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 22:46:54 +0000 (UTC)
Received: by mail-qk1-f173.google.com with SMTP id
 af79cd13be357-949657a20d7so43677985a.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 14:46:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794955613; cv=none;
 d=google.com; s=arc-20260327;
 b=X3RD1KXN5ccYHUvfqCyKXa49zGP5OYsjqONm+muvVXH9s8WVxwxXDIR3gf1Fv/fis0
 0yyepYt0MFjyhYz545HVtZcEzuzQuCuGfnqiSlzdb2qOylCJ89Z7ALkEimEnf0B3knVg
 38NBPsl0w5LwJt/3QigbelNfn8BALTJ/tpmdxg4u7jKod+b2dS+4wqdsTHeKWRnmljXT
 NIfBctjez2ffz54qubtKIxZ0ywr5UeNS5TXmvXtPLbFPxIR02/Lwmx0c0Q2kMYkS5jB1
 ToKR6Lkzo3INgmOu0coI4GrSlHyckakD+jv+yaNFw4VTAfsIjxkR0nRzWF0j+75OpIhL
 hArA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1hZsbSvYzSmLFEJ0qev10mPTktbA5RBsuqmPE4u2bw8=;
 fh=DIV/YsRnacEWVMlUStyOg0tat6nyKsE4MId8wxobA9U=;
 b=YHbPJdDpNelBQT/K/m5h/TcZxB8RnrBKFH3xenTz3qw9rFssyJlT2x0aX4u4K9mDjE
 RIF10V4YQF57nxOA/ld3cb10MTZf66RkP+2hAyhThfdYlr6FiM0REd7Pa+DF3GRNdzb5
 9Fuv1qj7l96ZnOI/P55gA4xGumd7e8j71qov+cYZmi5t5kDLX/v2JE95CJSq4jGjp30f
 zpVqCknEaEFvlTtIRkJMr2MNHx6sNejBr5KRS2ncP779ha9Cnp/hWDYXC1oJalFa60rC
 4cv9v8uSuvNAl2gvSwSbhF8dZrNZ9+TZ0dZ+zsuvcL2Xs23NE/e42JE4fvirR0X7glH/
 OTCw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794955613; x=1795560413; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=1hZsbSvYzSmLFEJ0qev10mPTktbA5RBsuqmPE4u2bw8=;
 b=GRTViG4XW4DKST+v1I1ccgQX8EzmvWy6L+IgBVfHvmCb6CS4NPTZr89lVbhDc11IZE
 FGgDFmDAu4aLE4/jXGWibQlGadEOlm/sysGqR2/n+nI7VEi8KLwSBmGewVM+vgbXfsf9
 AapygQRSyo5j4Kj27dzyQt/lFsiVhAdnkWS6QDpxFB2AehzIRTUCW/znO9onEYYVy+kf
 Edw2EVJMz7tPT8fKmInFdG+nq5tkKJe2B8aPaqFYPYaLLosmCQ4B74tqZMd6AG1949th
 2HOvhEs8o0tFBrcGYYbHhnhov4TnY9mOj8pCAmkvhfqT4vxFYE3LmE5Oqqr3JsC2JfoJ
 CeTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794955613; x=1795560413;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=1hZsbSvYzSmLFEJ0qev10mPTktbA5RBsuqmPE4u2bw8=;
 b=tQYAXmaTGnGoaD+6ik8mCCfPxxNGBhprhR72JFZJqrp5Uq9h5NWsfWdllBrHKzrtTh
 p0K5UB8vbTmnpnKOgvaFdRRVX/vqpv8gLnIt6lm9dpHf1LicOs0XyalpVWrtTiYPEnN2
 jFgDJ08LprjCOcTZMLisO77bUQbCeLmMXO6x+ESIYj3Pgah15xyUAK6/2aR2mYgrE/E9
 oczmfckcNgpdP6sB1TknWHWrSIya1aNiBlnPX+vb39By7fy3IpBU3lYaIl74Cgf3kZiC
 1MEymXGNAt+RCPw6owrTW2BbrbOwQw01XOu5fK+PrC+95MOSpnElj4bZbMgpraLm/jOb
 KPYw==
X-Forwarded-Encrypted: i=1;
 AL+hErEgDJenLsvN+MDCnLUIyfvspsIWWABL/P0MAQ6GUsQR5QP4P4NBYbqa7rhDn70Cn4X84+MtFOT7@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9z0PRyEFw4nhv3MQiWSXmBo6W2uVtLU9al/+YKStCon3YBt2B1
 QWlMluPJRUZRpHoooKBI/i4fikyuKYB7tlq7QV4YEgkcAEICjn/jJYAJlZU0nNqeuTaIOhxmclf
 6+hmXsQMYpM3WQfSk3j8/GuURZmKJbSk=
X-Gm-Gg: AYBFou1KaGqQFxS8m4ri945WwrlxH2Pk8dZoa32xA6FTmlAAnttoyBcL9qYmCzfQmmq
 q3o8nniWxPuJ//Y2SPqd25o5lFbw47rUX2VgeIu+raXezl70jevnRvXOU+EaCGULGbT1CV83cdd
 Kuf9a9v+andQhhZGBG1yEGozVYtYRckyhX3coH3pmTUhqLoL2Sc0t30JQwluQRIQo5lrLA+wm4Q
 PyX/NqyRqlw4k5Dp7E1OHdw8GN9rAEMkoWMfRM1TwQfSeJguY+bjVMg4oFRtUg9PrMRyn8n1NKu
 QYjyooGG+OX+UoEBFCie+8eAvTc91kkfrT4/WzaRS6AndGCznTlFdoTlBc2/LPGL1OFbBweMrKx
 wWkz3tZMAxgUkKfXDYsj2XkjZvZ9tOXFP9bMvy2EjSOcBbcVefsAu5bZyd0nb9UFWXA/6gy1ztd
 SI0trwWwv1FrqFsErP1zwHXg==
X-Received: by 2002:a05:620a:8005:b0:944:941:c060 with SMTP id
 af79cd13be357-9499957e979mr176328385a.15.1794955613294; Tue, 17 Nov 2026
 14:46:53 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261117-prt-explicit-sync-v2-0-bb3851cb6a0c@pixelcluster.dev>
 <20261117-prt-explicit-sync-v2-9-bb3851cb6a0c@pixelcluster.dev>
In-Reply-To: <20261117-prt-explicit-sync-v2-9-bb3851cb6a0c@pixelcluster.dev>
From: Dave Airlie <airlied@gmail.com>
Date: Wed, 18 Nov 2026 08:46:41 +1000
X-Gm-Features: AclHuK_8M3T-tzOgRWG-WLJiHvR1_KsaG1vlYb1skLjroWFOoHVsoG0QIuOvmDM
Message-ID: <CAPM=9tzeLEgavoAwjp2H0Y55STxRr6P8_LHHM5YWLkr9qJ2Lwg@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] drm/amdgpu: Add new AMDGPU_GEM_VA2 ioctl
To: Natalie Vock <nat@pixelcluster.dev>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 17 Nov 2026 at 22:50, Natalie Vock <nat@pixelcluster.dev> wrote:
>
> This new ioctl is a modernized version of AMDGPU_GEM_VA, with the
> main changes being support for many operations batched in one ioctl,
> and a better sync model that allows passing multiple syncobjs for
> both wait and signal. Timeline syncobj are now properly supported in
> both wait and signal cases.
>
> One breaking change compared to AMDGPU_GEM_VA is that
> synchronization is now explicit (where possible), meaning that
> previous submissions are not necessarily waited on.
>
> Using this ioctl allows applications that hammer lots of sparse
> operations, particularly some games running under Proton, to see
> significant reductions in stuttering.
>
> Signed-off-by: Natalie Vock <nat@pixelcluster.dev>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |   3 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 348 +++++++++++++++++++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h |   2 +
>  include/uapi/drm/amdgpu_drm.h           |  46 +++++
>  4 files changed, 396 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 72b3710462824..188c8ec234c02 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -3124,7 +3124,8 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
>         DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>         DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES, amdgpu_gem_list_handles_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>         DRM_IOCTL_DEF_DRV(AMDGPU_PROC_OPTIONS, amdgpu_proc_options_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> -       DRM_IOCTL_DEF_DRV(AMDGPU_UALINK_HANDLE, amdgpu_gem_ualink_handle_ioctl, DRM_AUTH|DRM_RENDER_ALLOW)
> +       DRM_IOCTL_DEF_DRV(AMDGPU_UALINK_HANDLE, amdgpu_gem_ualink_handle_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> +       DRM_IOCTL_DEF_DRV(AMDGPU_GEM_VA2, amdgpu_gem_va2_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>  };

Can we just call it VM_BIND for consistency with xe and nouveau?

Ideally of course we'd use gpuvm for amd, but even without that it
would be good to at least have somewhat consistent naming just so
grepping find things.

Dave.
