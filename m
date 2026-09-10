Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B34DDC88E42
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2026 15:21:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23EAD10E226;
	Thu, 10 Sep 2026 15:21:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="aChmc/P4";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DB9710E289
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2026 15:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789053660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TGTcVsbKXWwTCeMkJNtHiSzNSuqMoQpOMre/SaY0nig=;
 b=aChmc/P4UlOCRReh3fCUEVT93u33fpjHAWTRqT51ng+rMRFpU0jDq0JppqhitkGIPpraXV
 h/nMepCtLPWv1BtC7lOHqaopa2rLaO4OoHHt0+WxIp2WxKEFgKsRKvtmei0NIPIwDty0JG
 PIhVooyih8Fzz2asr8DsnXxLMY3pMrU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-iPpgIBPlMcuPF1FONoCM8Q-1; Thu, 10 Sep 2026 11:20:59 -0400
X-MC-Unique: iPpgIBPlMcuPF1FONoCM8Q-1
X-Mimecast-MFC-AGG-ID: iPpgIBPlMcuPF1FONoCM8Q_1789053658
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49d1a778b9dso32926645e9.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2026 08:20:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789053658; x=1789658458;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TGTcVsbKXWwTCeMkJNtHiSzNSuqMoQpOMre/SaY0nig=;
 b=SOw/SZ0yddQBHfeTX0/wBZ5f8oGWzoYkGYdTckpZ6y5m2VWuG7TeUrPjLe0e67ELsP
 V+jiIZUmVstf0NCLcWqBh6Rqk7z//Q4n4Z6SD2wEhPtt9vPBnnNF+f6DhI0qPzDTrCFK
 ThHLW5DGq5EqW24XQ94HaZBcEikwLhPd0VpfOawADEvxU4Ep21Z7uYxNEgpci5BT/RqK
 32nDhNRb/N43s7p2pPZPpj9CdlMHUBA1HRf71sN3dfbFVrB4G8xGqKfMwPIXQj21Ngxr
 idZQ/xsdBYG6smS87up5UDAjGALWZ89hPybMrcNSxFbM6pzjpHrH73X/xjLDlcfNSjrH
 veIw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz83u/j2kXBnNMYA9U0tRZAb5Ik6LUgrxGELcHJvxM2TLQj1guju8yWON6dnDzmJzxorh5h+0RH@lists.freedesktop.org
X-Gm-Message-State: AFuF++m27MF9ToCqK5G1MSJueVtRCrfL6YrEKpxGCJysAL0PfxmGZ10E
 dy4VW1iWOfthqcBQfBocbHizWexFUEp6KGx5mIxf6oClL8Kcat3zbByEDta5NGRsbVYYqGfWL0m
 2EJIhjsa0LODillIl7kSxwsIwp9+yT5hbZz+ig9Moi4vCL+DVK0P3I4NtvxmDQKY6Uu8=
X-Gm-Gg: AYBFou3ESAAijG3i2no1VXLnBN9zVFc2K8ljhI51cYAOH+s3kjTyXCCrbQJacK2lAOx
 bjoB3umZZluE0VHFRLJtZVkbSMVuau6hm2ZOZPsLPdAWGon2LW4uobZJ7KugANR4IntGOPitBcF
 VDKL4/b430nclihXTGlPZ4CLH3tFqkAYIwKo0JuDo/6ADtSWpqTzC7WLwF/Ve9E7v7IENzjjnMq
 Bnbakxl4UfnU6yQsBjNcTGMxkRH7dAVtUTcCXJ+Ynd2tEsr44AnGfU10FYQRzFXyn08THrDSvGr
 C0FL98rwf2ridffLjcGzvapLJ5U2sQ2WeiHhu36jSMyakReTbEyQbCYXPLYSNlUgSI1GeFPUtpS
 1nkPy6otI4Tu36RUclQxsFE+RpTAbMIGfJgJBRS9x6gPHSfQab+7RXDG4gg==
X-Received: by 2002:a05:600c:a315:b0:499:a277:e8b5 with SMTP id
 5b1f17b1804b1-49d258cefc8mr136421265e9.3.1789053657905; 
 Thu, 10 Sep 2026 08:20:57 -0700 (PDT)
X-Received: by 2002:a05:600c:a315:b0:499:a277:e8b5 with SMTP id
 5b1f17b1804b1-49d258cefc8mr136419855e9.3.1789053657327; 
 Thu, 10 Sep 2026 08:20:57 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e5765152asm28116795e9.11.2026.09.10.08.20.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 08:20:56 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Maxime Ripard <mripard@kernel.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>,
 Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, Paul
 Kocialkowski <paulk@sys-base.io>, Jyri Sarha <jyri.sarha@iki.fi>, Tomi
 Valkeinen <tomi.valkeinen@ideasonboard.com>, Harry Wentland
 <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira
 <siqueira@igalia.com>, Huacai Chen <chenhuacai@kernel.org>, Icenowy Zheng
 <zhengxingda@iscas.ac.cn>, Jianmin Lv <lvjianmin@loongson.cn>, Mingcong
 Bai <jeffbai@aosc.io>, Qianhai Wu <wuqianhai@loongson.cn>, Xi Ruoyao
 <xry111@xry111.site>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Chun-Kuang Hu
 <chunkuang.hu@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Iker Pedrosa
 <ikerpedrosam@gmail.com>, Dmitry Baryshkov
 <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH v3 00/13] drm/crtc: Convert all drivers to
 atomic_create_state and remove reset
In-Reply-To: <20260904-drm-no-more-crtc-reset-v3-0-27d9891512ce@kernel.org>
References: <20260904-drm-no-more-crtc-reset-v3-0-27d9891512ce@kernel.org>
Date: Thu, 10 Sep 2026 17:20:55 +0200
Message-ID: <87y0d916aw.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: m6s45bjzWPlc4VYa8lZYfqPOsGSufVxyjV-onORiQ_Y_1789053658
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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

Maxime Ripard <mripard@kernel.org> writes:

Hello,

> This is a follow-up to the plane reset removal series, and part of a
> larger effort to remove the reset hook from all KMS objects.
>
> The CRTC reset hook is overloaded: it is called both at probe time to
> create the initial software state and during suspend/resume to reset
> hardware and software state. These two roles have different
> requirements, and the reset hook is not fallible, making error
> handling difficult for the initial state allocation path.
>
> While reset has the semantics to reset both the software and hardware
> state, the vast majority of implementations and all the helpers only
> reset the software state, making them equivalent to
> atomic_create_state in practice. The atomic_create_state hook makes
> this explicit: it only allocates and initializes a pristine state
> without any side effect, and returns the state pointer or an ERR_PTR
> on failure.
>
> This series converts all CRTC drivers tree-wide from the reset hook to
> atomic_create_state, then removes the reset hook from struct
> drm_crtc_funcs entirely. Two drivers (tilcdc and loongson) had actual
> hardware reset logic mixed into their reset hook; those are moved to
> CRTC creation instead. The conversions were done using a combination of
> Coccinelle semantic patches and manual adjustments.
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---

I went through all this series and the patches look good to me.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

