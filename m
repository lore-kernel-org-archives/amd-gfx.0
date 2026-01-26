Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A32D1951A
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jan 2026 21:08:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1093510E4AD;
	Mon, 26 Jan 2026 21:08:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AnU/au5T";
	dkim-atps=neutral
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CAEF10E4AE
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jan 2026 21:08:54 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id
 5b1f17b1804b1-47ee3a63300so56255395e9.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jan 2026 13:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769461733; x=1770066533; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xGVk5HSAaWd+KHRFLr9PKxK8sL277IHKzKekR6pcCps=;
 b=AnU/au5TwCsGeTz1+tBEUrGI/8Wjv72nqT0axmq1YZRTfIcmZJH+YZINPKOROHhzRF
 EvlumeHFiU21MpXJSPzl5NZUxGxhsgNOgNf7U7tTjwhvM9JV1lLegy8bt4M3LOzv3UsF
 dsVtF2HfCd+WC6pv/SYt0PhsK0n/D7Kn9p0MEhFGeMSQASmKFbA7HEq5twyBZkKyxtC6
 fwZf+7V7NdUtWOc38Lcl5XoXjh1OxYKpMZy06Kjx2l7L8H/aUNo76PRTJg11dDmhPD1D
 8MovsG+O+iVP7aa6qDL0ME5Vr79U1qTZ4QtfX/9H88S3GHAB4VWmXLAtwb4bIEPSoTfS
 djzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769461733; x=1770066533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xGVk5HSAaWd+KHRFLr9PKxK8sL277IHKzKekR6pcCps=;
 b=dUjkUmFuWEMecXyM4LjwtLusd3/xBEp3UsQX8rRyvdHoCruZqRYmqZyh2X0T71AijU
 PI/P4zBh4LH7DNdPJPGSM4rYXfnjBIjttI901/DAe1g5JKoxF4CLZyC0cmukwfiWISZF
 uHIhrivAK/Le3IEiYeor/6tSBE+FmZEdiVpYJeZikksoSASRvnMreoRbYdcMb6yIT8t7
 /WRcI3reQPhmhB35emc64AunvOIdfoCDIv9HzAy5VElF+dLN8uZYYn0GZVhDBJAfBs33
 e5OzrdSiJL/Uv0ObQpyrpSNdQqcwQx/zQQxMr+L1tSbFhp4yVyeJS7GJB4+4p5VnZzj9
 gNzQ==
X-Gm-Message-State: AOJu0Yz6gFa66haaP0motRfLSREbukSIjYyuGbRrZAJI+0RqYuvoHN9q
 GPaaLLpQf05SUxDjH2R1D7u929S0FuZDjX5H3BM4dJomzabK3+QNBM9eOgvZ7TqP
X-Gm-Gg: AZuq6aLIjxr/HJlUqAdyWza3tMyfleevCqkKKmyFiFLi33eyQaobUVxqQM749ukRERT
 7JDMcThV263DItNwvxy+DcGoeZ8GkDQ/LnqQAdL4n+x0Mei+SGmo7BkxCLt8CdMjCckBxUvAzIV
 f/3fFE6dO59iDV2XjuZoAMaQ6r3LNO19653ZOWtPLiGNlDDe4SWyxEi2+QxUZQlTuh+ke4RZdR+
 5o+QgJD3y40eBSGCX0cPOxoL+/p6kp2Oz8JZqC2B7eTSjaXLiMrzhgOOgFfYGDw24VsCR5+cwjk
 YanZTXj9Xk9WhUZ02vKr08DgmsWzEHKm2pMvIrPTXB+HxJ0l7sZ0tkuYMaAY3FABaUiNMIM8oaM
 EuU2GEdgiG4rzew4BI+nA2kDwPNBz4R+xOTY9+30Hd/yqXig4lAQUDIV+ZwKFBUbf0kiLYrgmzb
 7RDL3OcXMrsGbP9yC99Lf4suiEjfgt4FX3mT+R1/heegqGjvUBzE4o
X-Received: by 2002:a05:6000:1846:b0:431:35a:4a7d with SMTP id
 ffacd0b85a97d-435ca155e76mr9038771f8f.58.1769461732871; 
 Mon, 26 Jan 2026 13:08:52 -0800 (PST)
Received: from Timur-Hyperion.home (54001FF2.dsl.pool.telekom.hu.
 [84.0.31.242]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c24acdsm33940275f8f.13.2026.01.26.13.08.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 13:08:52 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Christian.Koenig@amd.com, Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Alex Hung <alex.hung@amd.com>,
 Prike Liang <Prike.Liang@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Ray Wu <Ray.Wu@amd.com>, siqueira@igalia.com
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 14/14] drm/amdgpu: Use DC by default on CIK APUs
Date: Mon, 26 Jan 2026 22:08:37 +0100
Message-ID: <20260126210837.21885-15-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260126210837.21885-1-timur.kristof@gmail.com>
References: <20260126210837.21885-1-timur.kristof@gmail.com>
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

Now that DC supports external DP bridge encoders,
it has reached feature parity with the legacy non-DC display
driver on CIK APUs: Kaveri, Kabini, Mullins.

Use the DC display driver by default on SI dGPUs, unless it is
explicitly disabled using the amdgpu.dc=0 module parameter.

DC brings proper support for DP/HDMI audio, DP MST, VRR,
10-bit colors, some HDR features, atomic modesetting, etc.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 362ab2b34498..fc4656a23158 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4113,17 +4113,6 @@ bool amdgpu_device_asic_has_dc_support(struct pci_dev *pdev,
 	case CHIP_VERDE:
 	case CHIP_OLAND:
 		return amdgpu_dc != 0 && IS_ENABLED(CONFIG_DRM_AMD_DC_SI);
-	case CHIP_KAVERI:
-	case CHIP_KABINI:
-	case CHIP_MULLINS:
-		/*
-		 * We have systems in the wild with these ASICs that require
-		 * TRAVIS and NUTMEG support which is not supported with DC.
-		 *
-		 * Fallback to the non-DC driver here by default so as not to
-		 * cause regressions.
-		 */
-		return amdgpu_dc > 0;
 	default:
 		return amdgpu_dc != 0;
 #else
-- 
2.52.0

