Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE101FD5310
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Feb 2026 08:53:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B3A510EA66;
	Fri, 27 Feb 2026 08:53:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H85xyZhx";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFC8210EA66
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Feb 2026 08:53:00 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-48371bb515eso24143005e9.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Feb 2026 00:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772182379; x=1772787179; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sbfjvRE5GY0XRAAbP0x2ijP5rbmrrhoq8hjiwF4ARdY=;
 b=H85xyZhx3hkIEB4VFI83oLKHUlWy4gM068hXRg+l0BUNT7aTP/kQkVGREFPA+AVaaw
 iI1bj8nCrKdmD8ThpdyTxMFvH/shYI/x8B5vvKNvw7KBGSxgY5FbpQQteRu7XAj1/14g
 TD5kK6T+Em2BdGeFqPiGcdYlGmY/BPw67/DeiIyXuiU/LaM+rz/CXt9ErIS1ALpOInfO
 JjFcG2hUg9XeGd+BlGqyxEmiZWmnwWXBojHzSBXPVqoi4vZ+qA5wQzBR6RLAs8DREHOD
 LxDYV/wuQdgN9Um0vRN+qW1BCXfs4toxUCfXhGE/iBculzKSt9yBpeybyjt69FeX2E6A
 FyAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772182379; x=1772787179;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sbfjvRE5GY0XRAAbP0x2ijP5rbmrrhoq8hjiwF4ARdY=;
 b=kha5MGKXXxExy7BuvEusVOxCJpDR71yE7b+gch/4+aro0WSmA9erHmofd/5o2IdOAf
 rbM95xqYa86tN/Ofpzq0QtRRXViguoit2X0mECtJ+QShO4er6xamJMMExtPo+g2A2IX9
 BceWxWx4LxQw5UzdkuQ/E6WoZ+G4U9Kt661Va0U49Fn2zO9kDtROERwB0sUWuvys7/IM
 /AEnq4MQ3Hk7j1JnjJ752pZJ7UA4rSRqjZUuEyQkXDp4eufPerSDORFEhaAGMOm3FzlG
 3/3r8m64pIFIS/OeAwNKObwJLj9N5hsNoo0O/xZ2gbvyNpN9ZAToN6kBOhNgQfFrk957
 /QAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWALZMR6sJZcFdBcVO4Z1Xbz7PgdY2C+LRGk6O/sjxr0GRF5Nr5khUOsTJeTO1j519HYh+7eFQM@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwNc/nB51aBqgip2um7Vcvwh8/+BBW77+ZjNFFMnNvsfCpHgyYF
 XNOgxeHRQHbxpisDHvE0tOUPtgDRIaQZamURx9VVZ4qwC/+Kco3OaU0w
X-Gm-Gg: ATEYQzxvuvVK+dLdENkyNXaBTOIMpG298NYyVEVRIeQfZMhHRGPLPF/vWubkyDPW84Y
 eyQPlCabwt9YukjG14PXwLvYC5qTBCKOQfwfKyxnqOe1lzmuRsjTlOucrLd9sbiSc7T4TUccVlq
 XGi666YuEeWuFAi+jvzE+qAgaPX576W9ZZ5Td4DPv/UVlCbwBhiPENBAP95IsnpxN+GiNv1WkVq
 S/eGRLLO8CUQbyzbT+RMtbobXZxamahXDljQtpNDx+Xd1keI0dzXjmD2QD7Wwm7kbsDcHs4JYUZ
 sZVWzXt2fGXF8G8z9tAnag549irkhmS537ckGlYCYsK/ndttPpYvME+ppWsVvI56LtpH39dv7EO
 iaA/8bzCYYfiLNXEn1HU0Ab/r75nPUZO/J/Iae+4yqVn/4heNZOhuY2Qqqa/I5u6m+kq0BBL3GE
 IC6AFeXLC0Y4SQuXLVik/riO2Iro0WKBHCKCLbU4OONMTcRa5vcsIlxJcXOdmz7RPlXydXMxdGS
 Evbgq8s
X-Received: by 2002:a05:600c:4f8b:b0:483:498f:7953 with SMTP id
 5b1f17b1804b1-483c9c21525mr24224015e9.28.1772182378989; 
 Fri, 27 Feb 2026 00:52:58 -0800 (PST)
Received: from timur-hyperion.localnet (5401D70C.dsl.pool.telekom.hu.
 [84.1.215.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483c3b89c99sm92884545e9.15.2026.02.27.00.52.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 00:52:58 -0800 (PST)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: airlied@gmail.com, alexander.deucher@amd.com, alex.hung@amd.com,
 andrzej.hajda@intel.com, christian.koenig@amd.com, harry.wentland@amd.com,
 jernej.skrabec@gmail.com, jonas@kwiboo.se, Laurent.pinchart@ideasonboard.com, 
 maarten.lankhorst@linux.intel.com, mario.limonciello@amd.com,
 mripard@kernel.org, mwen@igalia.com, neil.armstrong@linaro.org,
 rfoss@kernel.org, simona@ffwll.ch, siqueira@igalia.com, sunpeng.li@amd.com,
 tzimmermann@suse.de, Melissa Wen <mwen@igalia.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
 Michel Daenzer <michel.daenzer@mailbox.org>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, kernel-dev@igalia.com
Subject: Re: [PATCH v8 0/8] drm/amd/display: more drm_edid to AMD display
 driver (partial)
Date: Fri, 27 Feb 2026 09:52:57 +0100
Message-ID: <3856874.aCxCBeP46V@timur-hyperion>
In-Reply-To: <20260225121903.236115-1-mwen@igalia.com>
References: <20260225121903.236115-1-mwen@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

On Wednesday, February 25, 2026 1:04:29=E2=80=AFPM Central European Standar=
d Time=20
Melissa Wen wrote:
> Hi,
>=20
> This is a reduced version of `drm/amd/display: more drm_edid to AMD
> display driver` [1] sent a few months ago only with the less invasive
> changes, i.e., those changes that don't affect DC. This partial focus on
> using more drm_edid helpers instead of raw EDID helpers. Most patches
> here are already reviewed by someone and I think they can be merged
> without major concerns. They can also prevent new initiatives of keeping
> parsing raw EDID as driver specific code, which can make harder for us
> to remove `drm_edid_raw()`. They should focus on moving raw EDID
> handling to the DRM common code instead.
>=20
> Regarding code changes from previous version, here I added some r-b tags
> (from Mario and Timur), fixed commit message syntax (Mario) and
> centralized error handling (Timur). I'll follow up the changes in DC to
> accept the Linux/DRM opaque object in a separate series since those look
> more sensitive.
>=20
> [1] https://lore.kernel.org/amd-gfx/20251106165536.161662-1-mwen@igalia.c=
om/
>=20
> BR,
>=20
> Melissa
>=20

Nice work, Melissa.

Reviewed-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
=46or this series.


