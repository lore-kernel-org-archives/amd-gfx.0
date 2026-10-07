Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B8F5CA600C
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2026 13:22:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8158610F5B4;
	Wed,  7 Oct 2026 13:22:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dC8boC35";
	dkim-atps=neutral
Received: from mail-lr2-f7.google.com (mail-lr2-f7.google.com [74.125.230.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C99D010F59F
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2026 13:20:15 +0000 (UTC)
Received: by mail-lr2-f7.google.com with SMTP id
 38308e7fff4ca-3a9a51919baso3200531fa.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Oct 2026 06:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791379214; x=1791984014; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=FPdX/wtfrIoJuU3T/PjxExDIh/LQdp4FgVNwlqulZuM=;
 b=dC8boC3565ZhI1LLRMLwyQxtklo8Y/xFvIzHDszvNW9t0PNeb0RkvA6UBHudvzZlrK
 7M5jWZrwIuNEw67c9SoRO/xfadvbGO+nm46Pp4xtgnSh7KmLLTWzQcIf5PRCEtk1bu4X
 6+J/sbG1R8cW8iN8e6K6hZ6JORdebd3EBWk/+1jiDk1Pq0q9z25yPYtLVMuJexOI+iNJ
 HPs+46sxl2HsHV/z7sPH0DXDhqxyTETrELMMYkBs/79hFm18ca2KzJrPmjzDhB8B6XDg
 jmar9LdlDThNwe4w8jweJwP2+bwbb8cR8P02hE87Iu3iSrdXlMiGq0MFvltzkj2qW4BQ
 F19g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791379214; x=1791984014;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FPdX/wtfrIoJuU3T/PjxExDIh/LQdp4FgVNwlqulZuM=;
 b=zHUvWp6wLwHlnp+iBh5OYoTO0xDekoRFkJ72CHa6xvuRVtewlS/2U9aoRy/W5B1/8S
 7brELyNG85uOnGHwWcNNQcRxdw8h9z65yAw7rxI82LBlhA/gQqcPkGm/cWp7I15UXshA
 Yu8oTInmPg8AsfCUk44ErugWBubxE29sPwkOF3GgKo3DOa2+/GhIp/Ey1T6gh/H7WMkI
 cKommK9UFrDCxAsaZA8nr9qdMAv4ElcYEZhWlqJ57WBjbA+OzhADK8FikrPz4RTW/F1B
 oRuuXHjO4Mst6CyYLLUxTk2zDlPoU5djeaCb6O//pnjuqkjLMulXSM3oGvSITbv1UJtO
 c3Gw==
X-Forwarded-Encrypted: i=1;
 AKwUvBybi71wOTxoZU3rrwDOi5C9y/VcBCJeyRD1J31OZzCDDG2ynrJuOBcESqXpNb0n6swnDCAUgaPe@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLOZVqAaj4/rwND4KUxk45QfseSe9Vw9X+eIbZcwEgDKDOyycHk
 wlbfQhvcRnjGcXR8wjnXuuxpxwOYXyFIELJohofPfKn7KGJPVkTkws8LjhrdZ8er
X-Gm-Gg: AYBFou2UHocp75UmD/6I259ispnpeCieTdYkiHJdaz9PNe2iHDIHrtBLRa5c4WanFdT
 KAeEj1rTwPFEwvSTyecIYwwqC3ZOkEsa2AtL7e/ktA3sDvJ5Kk/d1JDLPlCEHUWDVLOcszgm7dD
 Sfqi3Sgr33WSq5OrHO4Oha2kVilprv3VS4o1Y+hjKro1rnCUBexphifF1R53MqcsBwHGDcvBKQ5
 gcoM/LvAmjO3xEM7OVR9g/6t1ZQlTZeQwZ+w+3EhQHu91c3M9CJsylolu0qep5JfLWshRHoKZHD
 UzS7L80H0xwaYt8AXiCpNNR97iYsFLDEd7hbhO/Ef7Md7HBjMkDbpnOlvQE3lFAT7n50Tp+OCt2
 LA5/jW+U5Id4WqEGOqWmLHSIfyBf5k2lQzqR2dRFssGPNzkyfBQzuEQ2Ed0RLK7lXhc0A7TbGNO
 2cvktnC2bWen9EoVBHlOCDX3u9GQTRMdYcrZgGgXVjGzxx+bqmErNZImH5tK9ZvCpocaHk4wmro
 61Einl74qDvKnw+mQ==
X-Received: by 2002:a05:651c:553:b0:3a2:f233:5c6e with SMTP id
 38308e7fff4ca-3a9a2c65959mr5044541fa.6.1791379213808; 
 Wed, 07 Oct 2026 06:20:13 -0700 (PDT)
Received: from localhost.localdomain ([78.40.184.2])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a9a1a9c423sm6097951fa.0.2026.10.07.06.20.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 06:20:06 -0700 (PDT)
From: Roman Demidov <roman.demidov.nn@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Roman Demidov <roman.demidov.nn@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 Leo Liu <leo.liu@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org, Yinjie Yao <yinjie.yao@amd.com>,
 Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10/5.15/6.1] drm/amdgpu/jpeg: set no_user_fence for JPEG
 v2.0 ring
Date: Wed,  7 Oct 2026 16:19:36 +0300
Message-ID: <20261007131939.120898-1-roman.demidov.nn@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 07 Oct 2026 13:22:26 +0000
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

From: Yinjie Yao <yinjie.yao@amd.com>

commit e5f612dc91650561fe2b5b76dd6d2898ec9ad480 upstream.

JPEG rings do not support 64-bit user fence writes, reject CS
submissions with user fences.

Fixes: 6ac27241106b ("drm/amdgpu: add JPEG v2.0 function supports")
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Yinjie Yao <yinjie.yao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 96179da0c6b059eb31706a0abe8dd6381c533143)
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Roman Demidov <roman.demidov.nn@gmail.com>
---
Backport fix for CVE-2026-63848

 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index 3301ad980f28..af8f244e9c94 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -762,6 +762,7 @@ static const struct amd_ip_funcs jpeg_v2_0_ip_funcs = {
 static const struct amdgpu_ring_funcs jpeg_v2_0_dec_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_JPEG,
 	.align_mask = 0xf,
+	.no_user_fence = true,
 	.vmhub = AMDGPU_MMHUB_0,
 	.get_rptr = jpeg_v2_0_dec_ring_get_rptr,
 	.get_wptr = jpeg_v2_0_dec_ring_get_wptr,
-- 
2.53.0

