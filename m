Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D290C55184
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Aug 2026 12:45:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B896410E636;
	Mon,  3 Aug 2026 12:45:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="C8kIdf7e";
	dkim-atps=neutral
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com
 [209.85.218.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CD3610E629
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Aug 2026 12:45:38 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-c15d3cd51b2so452023166b.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 03 Aug 2026 05:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785761136; x=1786365936; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=GbZo3n1Bu8PYg56WYRplNkDhY007XnV26rRu39dYApk=;
 b=C8kIdf7eFt04tmVkjY0gOwu1yUFUVNka7esotMNgLa/2ufwv0xoiC0yTKWfbloGP6Q
 TjHgUbg2gyt+xEeh2aN71OSu0PJOuHW9I1EvboyqRhlXdSWWOWdXCCVxMmOKi/5Nd2Yz
 YjdtN+q1QlyzSo8K0gHeJ9qwOEKqC9a+yfnt/onSdMFztB7I1HWKoqC+AAjZ8mZdGO/S
 L9wFVP2eExgY1wU3Pw3O0z9a6Or0+fGTg+yBHzJAh6HHyYezFSqo3FjKn0gG+H9I+h8x
 2z9AXLmZLnwhgRv70wvCpUBVIHUqnBhe3bCamv6GGMi/R9FC30iWmEPGydQnYeQeGPJU
 ivag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785761136; x=1786365936;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GbZo3n1Bu8PYg56WYRplNkDhY007XnV26rRu39dYApk=;
 b=DKKKi2IJZzRrdejLp2N406/pBLkLG5N3K8zs7SI5wdVOeLviWNB79vq0nkRjXL7GUV
 ygEVHpa04dWau3bQu37o5q+ubMeZi8y/RRjgCQD4PBaEyshEwxlus8Fo5hpNJU5jSNo1
 +SKKXkBDSINepyZiN2rfYNOqIhahh3OJdc8uJEsP8F/oVA5/bDnoGLJaokleo1KjAvcR
 8bOvAL2joACZUh4psCbFouYb2zGOp2rg7dJ/z9rUanqGDIPdDWVW0hCDGgMaFcUejaLh
 ZVZU5nOrHUdrwNkpogYzF45J6lEqN31fWCRbIsoMdDrvXpwwpfVNWucGxCzzkAKkZzcs
 tU3w==
X-Gm-Message-State: AOJu0Yw/Gf+usZ1egQXmd5Kh1lyaCYrs6sroXN5FLyl7MCe8rkV5B2eH
 1eJzq5kFZY7MK0Afof+2oPj6QYw9p4M91erVT1QPddlGWehPhb3rjltuMkm7MhlY
X-Gm-Gg: AR+sD12buybw+NLkdPwnRyU4QOInSE6IW6ceWbM5L0V3loXl6dzMn2MUPoGEsWbPcry
 dGesaLIlut5megtKI5wQX/y9m8Nj/w537Hq0zk5LsFNprAI0ThRfUC0XAioHLl6fdBOA0xbFUhq
 CgQuwaw42BN8J0z1UHqnaWwvs47PozVAvA4yMFW4KWBQefXLJtRPKbmLLPPxdoiPdvRF2IS6u8U
 8mKP1rg+Q9cP7CoO0KLVRf1Scr+XifVlLQ0AkWngdNjOrMhJFiO0XknGtMH9jF+gN5wj3caAKjS
 ReahWeR+i/TxTaDYXnnFdU8D6t/4S+rEcVYuTbRer46UErz1+kXmhu/LI2jI4HfXOmztlYPCZmq
 ck/dN14hO4DZNsdFq2IMvwCy7cnxgVCciaG1E3nBuWZHWIj92UhdcJJAW6nckokm3t/bqu9Z7Hh
 B3u3T0Ji0QUShcw1HOtkmBzawbddsSOVKnflSVg4tMWLhx3Jm3xvMlJ1ZEDDYLu9iACTLhTCQdl
 vTYeLYHYp96sSy3E0zeXZlvCJy4zJw=
X-Received: by 2002:a17:906:fe4d:b0:c15:f598:60c0 with SMTP id
 a640c23a62f3a-c1fe7ea3d23mr929991966b.4.1785761136120; 
 Mon, 03 Aug 2026 05:45:36 -0700 (PDT)
Received: from Timur-Hyperion.home (5401D2B5.dsl.pool.telekom.hu.
 [84.1.210.181]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1fdfd6c57bsm491589166b.17.2026.08.03.05.45.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 05:45:35 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Natalie Vock <nat@pixelcluster.dev>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu <Ray.Wu@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Alex Hung <alex.hung@amd.com>,
 Tomasz Siemek <tomasz.siemek@amd.com>, Wayne Lin <Wayne.Lin@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH] drm/amd/display: Set native cursor mode for disabled CRTCs
 again
Date: Mon,  3 Aug 2026 14:45:33 +0200
Message-ID: <20260803124533.19375-1-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
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

It was regressed by a refactor. Let's fix it again.

Always set native cursor mode when the CRTC is disabled,
to make sure it doesn't cause atomic commits to fail when
they are trying to disable the CRTC.

Fixes: 151164f96a4b ("drm/amd/display: add cursor module")
Cc: Alex Hung <alex.hung@amd.com>
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c
index ab50d58896ab..d565433ea06d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c
@@ -290,15 +290,20 @@ int amdgpu_dm_crtc_get_cursor_mode(struct amdgpu_device *adev,
 	/* Overlay cursor not supported on HW before DCN
 	 * DCN401/420 does not have the cursor-on-scaled-plane or cursor-on-yuv-plane restrictions
 	 * as previous DCN generations, so enable native mode on DCN401/420
+	 *
+	 * Always set native cursor mode when the CRTC is disabled,
+	 * to make sure it doesn't cause atomic commits to fail when
+	 * they are trying to disable the CRTC.
 	 */
 	if (amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(4, 0, 1) ||
 	    amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(4, 2, 0) ||
 #if defined(CONFIG_DRM_AMD_DC_DCN6_0)
 	    amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(4, 2, 1) ||
-	    amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(6, 0, 0)) {
+	    amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(6, 0, 0) ||
 #else
-	    amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(4, 2, 1)) {
+	    amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(4, 2, 1) ||
 #endif
+	    !dm_crtc_state->base.enable) {
 		*cursor_mode = DM_CURSOR_NATIVE_MODE;
 		return 0;
 	}
-- 
2.55.0

