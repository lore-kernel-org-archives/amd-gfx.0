Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E499DD0E6EC
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Nov 2025 15:33:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89BD210E041;
	Tue, 25 Nov 2025 15:33:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GIG/U+pS";
	dkim-atps=neutral
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com
 [209.85.218.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5828510E43F
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Nov 2025 15:33:34 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id
 a640c23a62f3a-b737502f77bso814636566b.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Nov 2025 07:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1764084812; x=1764689612;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wCZdld6CYrWFXkrUxJ5abCqUL/Pa1DX9edqJLOysax8=;
 b=GIG/U+pS5LuzNDSOwCQjy4IJqYkRzbUVp58YhxFxQg7qF+Z1jZlw4YHw6b+zy7Gufr
 BTL/XUb6BjpcSFHIqBoS+oF7ljEOOoH9JR0FV+oRe2ZNkv0umQqKIA+bJO/EizgI2Xfg
 jxUF4gzmzAuFQS5HywLIBxHWQgccuL0kjSdDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764084812; x=1764689612;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wCZdld6CYrWFXkrUxJ5abCqUL/Pa1DX9edqJLOysax8=;
 b=juacPouMXLQbyaXRAG9BnzAiXo01xEHspC1As4lN7+MIWdlH1LqX8OLOqXHdIu56ro
 kEnowiMVR9ln+n4VJJ3CS8mSBsJiiwADTUcvbH60wdqz9B7H7bODWliYf0REjm1wzSlm
 luSIsb0QLlXvTV7A6SQU4KS6cEbBVJ6y0RAvSg+HJ2z2CfzYq+5pDMn5WdetwXJajWXJ
 sLJZFCNEy/WVh/b4z3bsIPrTKPCRoCf43dv0/Jq9wyVM3m/8dHOJqTTETGO2+aw4+Ysu
 hBvFnTQujszxrW1BnGz2mbIt5AW6f5RHIlPfrzNSBcnGW7kPy+9cMBMoAtcnN2JckX2l
 hgPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpqgO9hwTBPF82VvSVl1VZLBTtT+Mv51AAtrERE10m/smkIy+hz3rhf4T/QDWWyKcfSzKRm75/@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzHyLmLrFPg95C4gGqVEPUPKT7FHUPkvMrRf7CMppkNVjFrfBdd
 xiwQmPsIxM3x3wzRJy/Sroc+9hFxQ8SiODBKzdimt21W2/cOkbsX78mh7epDkDldz0EXjchOaBg
 mptkqeVhh
X-Gm-Gg: ASbGncv7hDPumxIKdijpL8//9BrXMzQ+JPSM1fR8iECgJvWm5gzGaweWSbAgyHkS4y4
 ZCC27GO4hxA3LM7f9nvVFtET3ibebDm9hCxq0p0nZoA6L1Op066Je5/qmXBCRfKnoZHYfE/vrhz
 Cll8s7S3qaFuY8niZFOA6CnKD2UnzlxHY5ICuXAu9pfjoJbLCDujHOJothLUlL0oDjW1p0moNr6
 diyI2xMs44SInyXKAITYxi4XBj0QM6tUM3tVkvQ9mDicI0RAFAMa/E7EGHVOkBwouHs6ok6B/OL
 5aYpV2AH0jGTaJ6oouCLqAnLdvqlwUb3lTgn878vNkn7Zcxdj4ppz/dh6QDD5rgJoCguSaq1LSs
 X5Z2qtb35anZBgGjGzT/0ezCZ1zqCANmJLAhGGpC4SLOx5mYAShGNfIxdMMTnKTxKp5je3bTFKc
 yHVdCktoUJ5cDWVliMrXMyraOGNbkp4bffmeAEHrvMDi14JwNpHsxcB81mUYPA
X-Google-Smtp-Source: AGHT+IEqIgBDwpvTGJGpZ9SQ8k2rvTG8avd770F+l1RMXk5SWoYyNcMvN14nbeZ8IjgWC0xFvrBOmw==
X-Received: by 2002:a17:907:97d1:b0:b70:b661:cfcb with SMTP id
 a640c23a62f3a-b76c5514f3amr341886066b.31.1764084812423; 
 Tue, 25 Nov 2025 07:33:32 -0800 (PST)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com.
 [209.85.218.53]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b7654ff3bbesm1613513066b.51.2025.11.25.07.33.32
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Nov 2025 07:33:32 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id
 a640c23a62f3a-b737502f77bso814629166b.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Nov 2025 07:33:32 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUbbPCBSFi5XZi6O37cNYxQwml24qrKlBCTnJRreYmv7ydlZScIlwA/Ci700GhymiFHBiFO/k7V@lists.freedesktop.org
X-Received: by 2002:a05:6000:381:b0:42b:3ad7:fdd3 with SMTP id
 ffacd0b85a97d-42e0f21e953mr3395597f8f.18.1764084405547; Tue, 25 Nov 2025
 07:26:45 -0800 (PST)
MIME-Version: 1.0
References: <20251125130634.1080966-1-tzimmermann@suse.de>
In-Reply-To: <20251125130634.1080966-1-tzimmermann@suse.de>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 25 Nov 2025 07:26:33 -0800
X-Gmail-Original-Message-ID: <CAD=FV=X_-t2AF5osp7Hamoe7WYE_2YWJZCaPaOj=9seSbnwwVA@mail.gmail.com>
X-Gm-Features: AWmQ_bldhiBpRCqVYkj0GufunmE0LiqT8gw4vCTv4PiT8j1h28du9Cx4NWXFEj8
Message-ID: <CAD=FV=X_-t2AF5osp7Hamoe7WYE_2YWJZCaPaOj=9seSbnwwVA@mail.gmail.com>
Subject: Re: [PATCH 0/5] drm: Remove remaining support for kdb
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: simona@ffwll.ch, airlied@gmail.com, alexander.deucher@amd.com, 
 christian.koenig@amd.com, lyude@redhat.com, dakr@kernel.org, deller@gmx.de, 
 mripard@kernel.org, maarten.lankhorst@linux.intel.com, 
 jason.wessel@windriver.com, danielt@kernel.org, 
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, 
 nouveau@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nir Lichtman <nir@lichtman.org>
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

Hi,

On Tue, Nov 25, 2025 at 5:06=E2=80=AFAM Thomas Zimmermann <tzimmermann@suse=
.de> wrote:
>
> Remove the rest of the kbd support from DRM. Driver support has been
> broken for years without anyone complaining.
>
> Kdb cannot use regular DRM mode setting, so DRM drivers have to
> implement an additional hook to make it work (in theory). As outlined
> by Sima in commit 9c79e0b1d096 ("drm/fb-helper: Give up on kgdb for
> atomic drivers") from 2017, kdb is not compatible with DRM atomic mode
> setting. Non-atomic mode setting meanwhile has become rare.
>
> Only 3 DRM drivers implement the hooks for kdb support. Amdgpu and
> nouveau use non-atomic mode setting on older devices. But both drivers
> have switched to generic fbdev emulation, which isn't compatible with
> kdb. Radeon still runs kdb, but it doesn't work in practice. See the
> commits in this series for details
>
> Therefore remove the remaining support for kdb from the DRM drivers
> and from DRM fbdev emulation. Also remove the hooks from fbdev, as
> there are no fbdev drivers with kdb support.
>
> If we ever want to address kdb support within DRM drivers, a place to
> start would be the scanout buffers used by DRM's panic screen. These
> use the current display mode. They can be written and flushed without
> mode setting involved.
>
> Note: kdb over serial lines is not affected by this series and continues
> to work as before.
>
> Thomas Zimmermann (5):
>   drm/amdgpu: Do not implement mode_set_base_atomic callback
>   drm/nouveau: Do not implement mode_set_base_atomic callback
>   drm/radeon: Do not implement mode_set_base_atomic callback
>   drm/fbdev-helper: Remove drm_fb_helper_debug_enter/_leave()
>   fbcon: Remove fb_debug_enter/_leave from struct fb_ops

Personally, I've never worked with kdb over anything other than
serial, so this won't bother any of my normal workflows. That being
said, at least as of a year ago someone on the lists was talking about
using kdb with a keyboard and (presumably) a display. You can see a
thread here:

http://lore.kernel.org/r/20241031192350.GA26688@lichtman.org

Daniel may also have comments here?

-Doug
