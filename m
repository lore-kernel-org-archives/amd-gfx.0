Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02BA8D2ECE1
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jan 2026 20:36:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B4CB10E50E;
	Mon, 19 Jan 2026 20:36:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ajErDSMl";
	dkim-atps=neutral
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com
 [209.85.208.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EDDC10E50D
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 20:36:33 +0000 (UTC)
Received: by mail-ed1-f52.google.com with SMTP id
 4fb4d7f45d1cf-652fdd043f9so8713925a12.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 12:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768854992; x=1769459792; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q+x7X0GqC36A7JALRaglzYV3THoUNhm/kh6dFSxpUIw=;
 b=ajErDSMlg5OIfQSBU/Cv8Nf7Hj21LRfocO/7+8qfuSUJWpXzOhFjq+N4APN5HeMFVP
 BQSHWBcsZh3q427gQt9pjbw0zhcOHJAlwTAuR3c3NIOvCWukXvsZcWGg4lKdGeN+xo3+
 RjaKQJeb9luAP5btpiQyVQ3tbZi02o+mtys36FmTSdLQ1FCc95rMfqoMshs4O2IXt60U
 HzaNjQ/QzIEQMgCEDlNE6n/I0HWExueR7h18PJ0NbNmmJKehq9jJYe5b3cziqBr2aKFm
 XxiDTYgY+eCohveD5uQ/Xy0Uy6kcWtDDT4EBC/6qSNIIrtm+N6mNP/MRceYlaaEQ6QYs
 n3QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768854992; x=1769459792;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=q+x7X0GqC36A7JALRaglzYV3THoUNhm/kh6dFSxpUIw=;
 b=ZsoC/nphU1VYE6XqUinvkcbzbRMIJlZx5op91hY/xNEocr58JdZHn+du4Yu34Z2kOi
 6s/UE5/PbRoibtYA+dWPXkR6rCxfGnB6x7MnIv1r5OwQxSs4TQ4bwQEBL1G1liRdoxRF
 8j8POUvb8myFtsHWkTsRJg7elZXz7HYHDK8jaQHsPrCcCUGYoJ6duXG5JEAkdr80Nr4J
 uKw+P12KnzdSL/F00bykUPrIndFR5M+RtHlf4m+GSWlMqyzrRgf9BXXyh0j0BtTpujEZ
 J7AY8YvmIHC6u6/hcWuiHn8dwhKfB2hovoGplVhR5SAOxDt5znx/z8DHVEbZ7h4w8lD0
 rzFg==
X-Gm-Message-State: AOJu0Yxqp3dGOFxFR3j9NO5YXPyj4LmWfvwyyOhcgOhqv2IVPCL7h2mq
 YG01wsrQsJ6J690K8uFCzKsP5KVqBYzsSH1+A3yv3Yf5TGrX9HbEXaAjtF4TNg==
X-Gm-Gg: AZuq6aKpXyFIBGb8uQxqWEOWkNZqQqVWo3CCrPdXUBPOFkPgez+AVUewaeAnfchNmnh
 LVIptrLoDlIDDJkb5CsrYnkqPnQTbYFQEW7cLjR/vmlux75Svot9WXFVj0GK32sC8XsBTqmS73M
 2s/ImENBLjerVvG2BKacV8+7LOPihul9SvllBLy0ikA/HQBQc29edRfsD9O2uJPXXFpPQ068G8L
 SKH3DiQ62/epU7GvxepAFSkLzInxtLbZssUasaUOoddaLmtAeu2gr3tisfVE7f51HSwqauQZdZn
 hJaAjLKuknePGdsPHv+lbgeo94IrWZ8hqEslxap3l0/eLs2Y34Xi6g0Weim0yqM4QJPqW88YWdF
 M33KyXIES82576RwTqitXaVFNL3xqlbccOVx5B+/I0kx0z18yiX1EYbJjH202F7l1UjXbza+ZoB
 zici2Ilw0gdYGNB9HoQfd4/BhH4RBstfC4Htj/iNDIt1d0kRBeqLGw4FhoYJvSedN//3hMOr6cw
 eFIP3++BBU2
X-Received: by 2002:a05:6402:3514:b0:64c:fee2:1dc5 with SMTP id
 4fb4d7f45d1cf-65452ad116amr9339687a12.19.1768854991695; 
 Mon, 19 Jan 2026 12:36:31 -0800 (PST)
Received: from Timur-Hyperion
 (20014C4E24E47400AD77F2CC91C9A6FE.dsl.pool.telekom.hu.
 [2001:4c4e:24e4:7400:ad77:f2cc:91c9:a6fe])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-65452bce213sm11375492a12.2.2026.01.19.12.36.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 12:36:31 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Christian.Koenig@amd.com, Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Alex Hung <alex.hung@amd.com>,
 Prike Liang <Prike.Liang@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 1/5] drm/amd/pm: Fix si_dpm mmCG_THERMAL_INT setting
Date: Mon, 19 Jan 2026 21:36:22 +0100
Message-ID: <20260119203626.16070-2-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260119203626.16070-1-timur.kristof@gmail.com>
References: <20260119203626.16070-1-timur.kristof@gmail.com>
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

Use WREG32 to write mmCG_THERMAL_INT.
This is a direct access register.

Fixes: 841686df9f7d ("drm/amdgpu: add SI DPM support (v4)")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index 9bdcd4e2aeb2..f7c2b1d206b6 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -7600,12 +7600,12 @@ static int si_dpm_set_interrupt_state(struct amdgpu_device *adev,
 		case AMDGPU_IRQ_STATE_DISABLE:
 			cg_thermal_int = RREG32_SMC(mmCG_THERMAL_INT);
 			cg_thermal_int |= CG_THERMAL_INT__THERM_INT_MASK_HIGH_MASK;
-			WREG32_SMC(mmCG_THERMAL_INT, cg_thermal_int);
+			WREG32(mmCG_THERMAL_INT, cg_thermal_int);
 			break;
 		case AMDGPU_IRQ_STATE_ENABLE:
 			cg_thermal_int = RREG32_SMC(mmCG_THERMAL_INT);
 			cg_thermal_int &= ~CG_THERMAL_INT__THERM_INT_MASK_HIGH_MASK;
-			WREG32_SMC(mmCG_THERMAL_INT, cg_thermal_int);
+			WREG32(mmCG_THERMAL_INT, cg_thermal_int);
 			break;
 		default:
 			break;
@@ -7617,12 +7617,12 @@ static int si_dpm_set_interrupt_state(struct amdgpu_device *adev,
 		case AMDGPU_IRQ_STATE_DISABLE:
 			cg_thermal_int = RREG32_SMC(mmCG_THERMAL_INT);
 			cg_thermal_int |= CG_THERMAL_INT__THERM_INT_MASK_LOW_MASK;
-			WREG32_SMC(mmCG_THERMAL_INT, cg_thermal_int);
+			WREG32(mmCG_THERMAL_INT, cg_thermal_int);
 			break;
 		case AMDGPU_IRQ_STATE_ENABLE:
 			cg_thermal_int = RREG32_SMC(mmCG_THERMAL_INT);
 			cg_thermal_int &= ~CG_THERMAL_INT__THERM_INT_MASK_LOW_MASK;
-			WREG32_SMC(mmCG_THERMAL_INT, cg_thermal_int);
+			WREG32(mmCG_THERMAL_INT, cg_thermal_int);
 			break;
 		default:
 			break;
-- 
2.52.0

