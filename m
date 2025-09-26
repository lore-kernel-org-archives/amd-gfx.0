Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03538CAC5B8
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Sep 2025 18:04:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C3DD10EAC8;
	Fri, 26 Sep 2025 18:04:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DE1YNcEg";
	dkim-atps=neutral
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D74A10EAC8
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Sep 2025 18:04:10 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-b55562f3130so1784777a12.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Sep 2025 11:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758909850; x=1759514650; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z6Wt9/ruiBLWKxWXoBWOoF2hTDDmrf0baYBFObBTxhk=;
 b=DE1YNcEgMdBXbz2hhJ4FwtpksBsP3QUbaqk+bPbrB1GChlaRW3WcSbrHArFkQHsqTM
 p8ZKyiEk8ioUT+4BUh6BtolqHc6+MiZ/Ky6bnpF7KsVgQnYlEosWEO12PtT7jwfK4FF9
 DjgD7Cop04FFec2wiaqB6tTjDUCBl3EUfNsaW57V/709A4E9+PfnY1b9v1l4FyOn+XWO
 kWhtaP17uMk+iVL8tvjv19vToz6YqOc2qrjKF1C85v61qqyCFX4x8vYoJ/5jkIKhF9FN
 yQJkrdZJEQnoYDfDWM4sg36sQ8xa6LtnJr/unsiGf54P/a9kCNucGStwZTxwZABZM7Rt
 NUZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758909850; x=1759514650;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z6Wt9/ruiBLWKxWXoBWOoF2hTDDmrf0baYBFObBTxhk=;
 b=d4GftjJdchrTNcrP279Co8qH8blGhj6YkCyRsQTdVrEutccEwVAdlWgLKAA13OF1sg
 TVZ0ChQ/63C0fVI0uSrPuYSDy1diw5jyty0O+14nkXhDLSy5LlJhYHOQhYwWBUfEhfYk
 vHR+y2d5XXcEyW/KC+tjySTcMtA8w9EQXKnVXtSqEYeivGWY+ZMPMTvd87yiWa1jlFve
 K71arCW9YZWGoBnxjlKyj+X0eXcnWcVlh5JzkbFSVQmTrriDmZAelnsPOu/Wd8cQ12bj
 TTNElN84mMpr76uYgISJ4RXReyMHidiRaE9DfVx4kyVJVVrdSxWwjqYb573YBS0pxy70
 vqaw==
X-Gm-Message-State: AOJu0Yxps7Bt2batydhZ8qi/ZeB7wxFneivDXScNrNh5k1en+lhEI5yy
 qMyVYMHG/V8sMk1SqQs4HYATwh5Keie/d9a56/kYiTqBuPAGsxjKqM0yvOeglw==
X-Gm-Gg: ASbGnctgLdP7aazHuJRucY7mtfZVzfLqLmFF0voav3AbFqKh8ZLD7Stj/q8R9S2NfTF
 b+XWzsWfPmXn82IMf+GxXtwpUB5WOkX6Mm083EvtIamY5xj42vTwur3/2vD3w5k6eR3iWYcdHdE
 jcfgknlFDQDO8nsWujUVHGk0h+B/XOEf1GBIE/T5S3h8K6hh69dyrfThmc5h/gNmLOWlcDj7nAx
 QrGfBWmAS2p/+l9uVyldgRM8vcG1ydaiP0DhB6LcMYWjLTHv3R8iArkE0PAsYlOxPqmrCi9zXMI
 8uP1ZYY/ktiSzNWaG32hH/2FzlZTN5ITUDi0vzG09qaU6FJBzHObHYRwz1dRXG/xg7EWzO7lycv
 2XyPvWHc3TJUryhdtYJycejF3zXue9xsssaYLXTawxijumUPvMlzK+crOwSfmgX1WbCW47UgrUk
 xu7yaghSBAoiqPtAYUv3w=
X-Google-Smtp-Source: AGHT+IEiqC919Vac+SaQ2JU8MAy6hdOsGZQEEoqTzWLwdiiSH2ul3QytGsEixzSLy3Yxaw5FTiGpOw==
X-Received: by 2002:a17:903:2352:b0:249:44b5:d5b6 with SMTP id
 d9443c01a7336-27ed4a920b9mr91793335ad.40.1758909849763; 
 Fri, 26 Sep 2025 11:04:09 -0700 (PDT)
Received: from Timur-Hyperion
 (20014C4E24D067005D2C718B079018C4.dsl.pool.telekom.hu.
 [2001:4c4e:24d0:6700:5d2c:718b:790:18c4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27f1d2ef8c5sm22186835ad.151.2025.09.26.11.04.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 11:04:09 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, alex.hung@amd.com, harry.wentland@amd.com,
 siqueira@igalia.com, christian.koenig@amd.com,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 22/23] drm/amd/display: Don't add freesync modes to analog
 displays (v2)
Date: Fri, 26 Sep 2025 20:02:02 +0200
Message-ID: <20250926180203.16690-23-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250926180203.16690-1-timur.kristof@gmail.com>
References: <20250926180203.16690-1-timur.kristof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

VRR is not supported on analog signals.
Don't add freesync modes to analog displays or when
VRR is unsupported by DC.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 2773436d49d1..7dd8baf49460 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8532,6 +8532,10 @@ static void amdgpu_dm_connector_add_freesync_modes(struct drm_connector *connect
 	if (!(amdgpu_freesync_vid_mode && drm_edid))
 		return;
 
+	if (!amdgpu_dm_connector->dc_sink || amdgpu_dm_connector->dc_sink->edid_caps.analog ||
+		!dc_supports_vrr(amdgpu_dm_connector->dc_sink->ctx->dce_version))
+		return;
+
 	if (amdgpu_dm_connector->max_vfreq - amdgpu_dm_connector->min_vfreq > 10)
 		amdgpu_dm_connector->num_modes +=
 			add_fs_modes(amdgpu_dm_connector);
-- 
2.51.0

