Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8718C87FCB
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Aug 2025 13:29:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43B6610E854;
	Fri,  1 Aug 2025 13:29:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ltt21jQZ";
	dkim-atps=neutral
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F57810E2B6
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Jul 2025 18:17:32 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2401248e4aaso16295535ad.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Jul 2025 11:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753985851; x=1754590651; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ko+E3oR4W+9XRH6XslAZTMmOJxda8PZJ1FffJrGkJ1Y=;
 b=ltt21jQZEa74QsiBRu4nSC7PgOAs4xPuCxfsUFCkm5AUwN1Q6CO2Ma3kk9AB0VvMkn
 IOpdf5bNNw74eTLxY1jg+CZI/dQKWFRuDcmkDTv1lwq/fAAWWECRyHW4p/s0qky5CjRu
 /0ku6iEALoDyIv3YYnI5aI74Mmm46p4PHfJtgmni23GAMzM8bYBPa/ENk3lyq+oIAbjl
 XZZJnbEvvybc87dy8DRmcZgeHUeoOV9K2DRD5oeTA9+Ojte6vao8LTCL0MyaSSMT48IW
 iP/UxexoLNu6X4TCot4/xlsItcNR7CIBMu5zhysZq2V3G1Gd13Zi3QXfO6S2412FyWUf
 5Edg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753985851; x=1754590651;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ko+E3oR4W+9XRH6XslAZTMmOJxda8PZJ1FffJrGkJ1Y=;
 b=XNNVgr7Dv1H5KdZ/kkN59cKn2sQvtMAJ4DhNm39GGgIxjjWFFrrfoldl9Ma7upiRRi
 sDEO11XF9qKKEBwJQD97BzT4UUcC99wsuLfu4n9jNb9KXuo9IWC2Opj1XTjE1Z8eFYX2
 tK61jU7NM4LGj9s7usO1v66QzCX/QQs5Y8PTh4gecI138lSnvD92h9Pwxk0HTQOISmVQ
 p7JHQ3cM7qy1scE+NW2btE6GORdROc8b+P+D93f6U0HOx7ybgEbUYJfjdK8VVx7g/VcL
 Y0dup5mCJAJ+z8Bgf+0uhn45zcNE8DHZ+uYCI4u8lR2J7YKbwe26PhX9zf7iIMx1ME55
 OuJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXL9QX9VELvzH/sD7fm67sspwIQww64hxobS0Hc53bK7mPS4Izw2uKgcZbS/5jVLiLRx19VZxx9@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxiYOZN+0wAYdcuMWUrBVu70tfBI7a0zQqMgaZMiPDDyKwYONqN
 g7xYVjWoDSV5pM1dhthReXW8bctBakDgftu6Nz6SLxdQ53f3r+zPQ21FUpTwq70vcNw=
X-Gm-Gg: ASbGncsGbJCJjKd7IpiwLmLt1xTzTf8LcPotvEZJVP4ONGRDDGTUg0qJkmN2eZZSb5b
 556/k4LWbHQvrNB0CeGIkKnYbREFT/ktUKptQ2Cha9yr2x5gG4MqMicjxlrKVdj9DOslXcZTfrp
 VjsEWFqwm3FloWNUoyfBPLhNkEFmtPMORSOjmn0yoYll+jreS2Gwy9EeyzDttrydQzWNWuU0fj/
 mhKIK9eYkdf9/UV6BEwOGZrU0V+St8C/SMYj5v+5uQF5u8W/9YAVbQbbpCZhBy9nZB7FgsAe5Xk
 fojxPatRbv6tmiYhIIaBgmrXLCViv5PI8eA7NTSyT48xY7EaWJRnNDhrd/rnJBjKoCw8UxWacKw
 JAdUAQZMIYNIlRoexMPZMQtj5qY8myA==
X-Google-Smtp-Source: AGHT+IFptIyiPCQAr4K9I9q2LxI/H2znEXUjIk9SB8OaIyTmC1dTpj+7408uLyZUSVSamCN8Ns2kew==
X-Received: by 2002:a17:902:e890:b0:224:910:23f0 with SMTP id
 d9443c01a7336-24096b3d823mr127116295ad.49.1753985851577; 
 Thu, 31 Jul 2025 11:17:31 -0700 (PDT)
Received: from localhost ([2405:201:c00c:2854:bfcd:fa29:9fd7:ab48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241d1f101d1sm23488235ad.62.2025.07.31.11.17.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Jul 2025 11:17:31 -0700 (PDT)
From: Naresh Kamboju <naresh.kamboju@linaro.org>
To: imre.deak@intel.com
Cc: alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org,
 broonie@kernel.org, christian.koenig@amd.com, dakr@kernel.org,
 dri-devel@lists.freedesktop.org, lyude@redhat.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tomi.valkeinen@ideasonboard.com, tzimmermann@suse.de,
 ville.syrjala@linux.intel.com,
 Linux Kernel Functional Testing <lkft@linaro.org>
Subject: [PATCH 0/3] drm: Fix initializing format info in drm_framebuffer
Date: Thu, 31 Jul 2025 23:47:05 +0530
Message-ID: <20250731181705.159893-1-naresh.kamboju@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250728101603.243788-1-imre.deak@intel.com>
References: <20250728101603.243788-1-imre.deak@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 01 Aug 2025 13:29:30 +0000
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

> This patchset fixes initializing the format info in drm_framebuffer by
> drm_helper_mode_fill_fb_struct() in the omap, nouveau, radeon drivers
> after patch [1] in patchset [2], the latter one missing the conversion
> of these 3 drivers. This patchset converts the 3 drivers similarly to
> the other drivers converted by [2].

> This patchset was only compile tested.

> [1] https://lore.kernel.org/all/20250701090722.13645-20-ville.syrjala@linux.intel.com
> [2] https://lore.kernel.org/all/20250701090722.13645-1-ville.syrjala@linux.intel.com

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

Test job,
 - https://lkft.validation.linaro.org/scheduler/job/8377982
