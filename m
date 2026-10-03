Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E517FCA5FE6
	for <amd-gfx@archiver.kernel.org>; Sat,  3 Oct 2026 10:39:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 625D810FB13;
	Sat,  3 Oct 2026 10:39:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="f4wk1eEo";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D4BA10FB13
 for <amd-gfx@lists.freedesktop.org>; Sat,  3 Oct 2026 10:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791023994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yEazttUDpzXlqXpxwJlMZPomrWiWdlvAhL9J6+CU2p8=;
 b=f4wk1eEo9CdHqGaXqMDH9jtMslhTckkoTa4SmXzHlKiJey5wUWIth/AW9/JkuZnjSPJ8xF
 QrfKHQfjm29QywYBf622wzsSU6KDFT0wGi5oymqMeOKFsnPD0mBR3iebzPDPjs9lIm3iYN
 YRFjGjFSjvnQdY8fombqnJuG65U613A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-nR2KQuAoOMaEy4yIR939yw-1; Sat, 03 Oct 2026 06:39:51 -0400
X-MC-Unique: nR2KQuAoOMaEy4yIR939yw-1
X-Mimecast-MFC-AGG-ID: nR2KQuAoOMaEy4yIR939yw_1791023990
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4a027f2e364so3897495e9.3
 for <amd-gfx@lists.freedesktop.org>; Sat, 03 Oct 2026 03:39:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791023990; x=1791628790;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yEazttUDpzXlqXpxwJlMZPomrWiWdlvAhL9J6+CU2p8=;
 b=mx+VFNH1M93O83spqw09eK/DXDs4I0NyEJgMKCr78+l0+YtBzTPm0RC1WWAxN4N28e
 z4jZ58+MMxM9AcyWQKQFgiQWNDEUXc+hxgcQGECSLuyVyjiee0pdeCXxf82O7/MSJcjx
 /InQrunwNwOMyu6j0JcQ5s1uVDIJeajHbJhH99fl8URECGrl6qo5ahr9dTG5s9S3t6YO
 n/YvytEsrf+PZ8JsIYUZTyevHZpm84+OmtS382MZ8jynGtLG6so4ue70XeQoUizjRVNY
 ZPNtyGtb2grMtCIDIW7ctiWTb1X/jAmhME7Lh8Hlwyix0sCf2UtDn9MNUGhDuPL7QpmT
 cETw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx5nWE4wTwB3/PFSC/ZET+7r4nWrjAlNBUJil9Jk4D53KxTd9l9sJiznZeB3YEurcLzm5kRfC6H@lists.freedesktop.org
X-Gm-Message-State: AFuF++lAecXo4aQGED1JcVYAmxjizXYdLm2mBeXIN3Z7NLnqPd7dboHe
 4hLJm9p14+FVadnlOMN0Y0XGyr8ivEN9AX/fv5zW1x05T8/wQSGcdmeNJE3RVRUZYNZRixrD1Cs
 wtK4FG3vJzLaYViHcmJIQgz8RR3MnMINsJBegS7Tdr/++lPrepknXXMbpxYIAGTlyFfk=
X-Gm-Gg: AYBFou3hBTIidg5IGn4H+2QQHyeuY4rgZ/gk1vMvWUqzvhTUnn2xNZiOU0fvraoDB5K
 f3ZnTeQWwQJRqBsYMieu2dgUF/ZTrpBaZHR/G8J0DdPWiFwxEnj1TbtmMIp75At3l7uH7tMGcfu
 +ZtVOrUMTsX/zkSFKlFZX68CEZoxVXdg6Za65PsAqdm9fXr7lZ1ZQJeJZAG6VF900BLVxMM/MGy
 wclNwbKsXA/JmoJj+ycVndgGzyBTFEWL3Kw41gwPYKafox28X7msNNNsljnoAa5CcuPSxCpp7l1
 sOtAd3L7wjAikM2MIKHM9n0RXTshqtkVEzcIGfok1ju4HIScF8HfQ/kya+R1VRWp5mmt79Zxn41
 dcLXtMu/3X+mNqoxdaKvjMN7u0tT2TnXGZGkGHv8nAGX2OvUpMbE92f5/wFEjpMK5FA==
X-Received: by 2002:a05:600c:5392:b0:4a1:6991:36d7 with SMTP id
 5b1f17b1804b1-4a1699137bfmr23376285e9.10.1791023989746; 
 Sat, 03 Oct 2026 03:39:49 -0700 (PDT)
X-Received: by 2002:a05:600c:5392:b0:4a1:6991:36d7 with SMTP id
 5b1f17b1804b1-4a1699137bfmr23376055e9.10.1791023989341; 
 Sat, 03 Oct 2026 03:39:49 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a02770fe4csm168249935e9.7.2026.10.03.03.39.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Oct 2026 03:39:48 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Mario Limonciello <mario.limonciello@amd.com>,
 dri-devel@lists.freedesktop.org, harry.wentland@amd.com, Simona Vetter
 <simona@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>
Cc: Xaver Hugl <xaver.hugl@gmail.com>, amd-gfx@lists.freedesktop.org, "open
 list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-gfx@lists.freedesktop.org>, "open list:INTEL DRM DISPLAY FOR XE AND
 I915 DRIVERS" <intel-xe@lists.freedesktop.org>, Mario Limonciello
 <mario.limonciello@amd.com>
Subject: Re: [PATCH v9 21/21] drm/solomon: add SSD130x connector luminance
 support
In-Reply-To: <20261002190030.211356-22-mario.limonciello@amd.com>
References: <20261002190030.211356-1-mario.limonciello@amd.com>
 <20261002190030.211356-22-mario.limonciello@amd.com>
Date: Sat, 03 Oct 2026 12:39:47 +0200
Message-ID: <xlv1wlrz5aq4.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZGUhOvykm4_naKevnHIp-X56kl9GJ7Idtd3ifvgvVJM_1791023990
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

Mario Limonciello <mario.limonciello@amd.com> writes:

> Expose SSD130x contrast through the connector LUMINANCE property when
> DRM_LUMINANCE is enabled. Program contrast directly and retain the
> backlight class interface otherwise.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---

Actually, one more comment:

>  
> -static const struct backlight_ops ssd130xfb_bl_ops[] = {
> +static const struct backlight_ops ssd130xfb_bl_ops[] __maybe_unused = {
>  	[SSD130X_FAMILY] = {
>  		.update_status	= ssd130x_update_bl,
>  	},

I think that instead of __maybe_unused, this definition could also
be guarded by IS_ENABLED(CONFIG_BACKLIGHT_CLASS_DEVICE).

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

