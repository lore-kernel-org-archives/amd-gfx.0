Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76FD3CA600B
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2026 13:22:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10F7D10F5B0;
	Wed,  7 Oct 2026 13:22:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hcE7D5d5";
	dkim-atps=neutral
Received: from mail-lr2-f1.google.com (mail-lr2-f1.google.com [74.125.230.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FB1C10E763
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2026 13:13:42 +0000 (UTC)
Received: by mail-lr2-f1.google.com with SMTP id
 38308e7fff4ca-3a772511049so25233951fa.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Oct 2026 06:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791378820; x=1791983620; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7raFCL+DaDHQ/Xzt3dKVl/XyqPmVrA37jhza1G8kvFU=;
 b=hcE7D5d5rY3mdBlpPcR8hqimcoL4wxmxXaYjcEkpOw+NOEVKtoex3bHIQoWba1Hlwn
 zDnLoCvAuEJaxhfYhcIQ+4Wgig/m96Hx61QBGRhQPF82hgRZJZrCMaslMJ490txTst7C
 zNCmw0DIDv5DoRXrX4RGqMJ3xyLVHjVBQeb3u8nauqydYw9MGtYmOyWyedeDWGsq0y6I
 5bsjSIkxUGb7pghWwo2FuBWZ4stQDT+S5oFB9TV+xqmPHhg0OTk/D7+HaSWEPBQqHX+O
 0WSTLVnKZZvVw4zuof5Wd69Q71Wd9RmjYMOvoz4GaB3Pzg2CujBIsaMcIJPU5JdTkVi+
 z60g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791378820; x=1791983620;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7raFCL+DaDHQ/Xzt3dKVl/XyqPmVrA37jhza1G8kvFU=;
 b=Msd2qUsWbTcLhSZqgyJmg4VBncJpuKdF+VHPfQnQEjH6skx2fN7Gj1EvORnE5nwh26
 GJb/rdn68cUAovpjFFPb6effxqnOv4ZZUwlklsfEIXMqBTf6zjQEp1BM28EKBh/UUB0A
 Tzr5tqSJsd/mux7JQtwqLq1vZLmIPvKprllEr08oYIC5+0KRWtcKqIGtPHYjTsPI7BNn
 lTKqc9IeMPqTP7ZXDyNM0lwVtVAanQIpaHbjjg/MQkD3lZVGhV1zzf22Fhsx4NtB73lS
 SQnakvLqWAUrAmfJxLDFX+HZVRS2QcRb/VFJyJwXqWDm0H0RqguKZx8fUwMRV+Gv+aUT
 /z/g==
X-Forwarded-Encrypted: i=1;
 AKwUvBz6JaVsmM5uV6NEfFvBCNlpZT9Zg3oxNpcnS3wjelEAHJmcnooW278p/t/LhwgX9HRArUuqcRwc@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLiPwgH+Oq13EyHBc7XUkQ5caVJ4BT33Xbg+Iuytcgf/PyqD7ou
 XFjR14pUHdrAR7b76MT89blEOk0U36GYIRcgde/IuqqM1PZSAaxPw03G
X-Gm-Gg: AYBFou14iaww+hpsny4rG9cP/CL8jnpml7OowPJ9eA1C+y9aeg7cEhYHVTeJ0G4voF1
 CBlXjUTeRPZHSBF89FxqqyDk1GQmj6adXCF+e43gaXdYigxmxoDYQ1TXsDwuK801fx3/cPl+hdw
 /5wIM/Ndeb3ryZ/cjrJt/cYLOKwdF0FyQXofX+lai/LQfPypNzBSExVVmx+NDJeCt2LtxkRL0NX
 6rE89XNeBXkOEEIH3gp8lep0Dria+CT3xNy3Lh9sD0dPatjAmHeWA0w4dxGr1FSRGDG5F+DVTQ8
 lpAf6tzXH1vvmzjKaklJoJpgKQQZ3Oab0HVOHVguex5vIihkUIfTPC34HEUuplQOJc6Ge88DLA9
 ycJCI1aYwSSdUIDEkAgCZdjxy7Je48mfvk90yRU7QxQ0A+tYLuuxhA4WrnRTUuZLeFUCp6lhEmh
 O2N1f8dGXlGq8mCXdAF1LlQsVkAH2wyBr9vK9/5ZOinEIwmdA385JBSwNG10aocEmkwUGhccsb2
 KsHMfcmVvKpZyJ3
X-Received: by 2002:a05:6512:4027:b0:5bc:c63f:7004 with SMTP id
 2adb3069b0e04-5bcd072ddc7mr896476e87.48.1791378820139; 
 Wed, 07 Oct 2026 06:13:40 -0700 (PDT)
Received: from localhost.localdomain ([78.40.184.2])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bcd309149asm21640e87.53.2026.10.07.06.13.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 06:13:39 -0700 (PDT)
From: Roman Demidov <roman.demidov.nn@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Roman Demidov <roman.demidov.nn@gmail.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
 Ray Wu <ray.wu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 6.1] drm/amd/display: Fix out-of-bounds read in
 dp_get_eq_aux_rd_interval()
Date: Wed,  7 Oct 2026 16:13:33 +0300
Message-ID: <20261007131333.120389-1-roman.demidov.nn@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
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

From: Harry Wentland <harry.wentland@amd.com>

commit e8b4d37eba05141ee01794fc6b7f2da808cee83b upstream.

[Why & How]
The aux_rd_interval array in struct dc_lttpr_caps is declared with
MAX_REPEATER_CNT - 1 (7) elements, indexed 0..6. However, the offset
parameter passed to dp_get_eq_aux_rd_interval() can be as large as
MAX_REPEATER_CNT (8) when a sink reports 8 LTTPR repeaters via DPCD.
This leads to an out-of-bounds read of aux_rd_interval[7] when offset
is 8.

Fix this by growing aux_rd_interval to MAX_REPEATER_CNT elements to
accommodate the full range of valid repeater counts defined by the DP
spec.

Assisted-by: GitHub Copilot:Claude claude-4-opus
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit a55a458a8df37a65ffda5cf721d554a8f74f6b04)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Roman Demidov <roman.demidov.nn@gmail.com>
---
Backport fix for CVE-2026-53330

 drivers/gpu/drm/amd/display/dc/dc_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 6050a3469a57..579a38478d0f 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -403,7 +403,7 @@ struct dc_lttpr_caps {
 	uint8_t max_ext_timeout;
 	union dp_main_link_channel_coding_lttpr_cap main_link_channel_coding;
 	union dp_128b_132b_supported_lttpr_link_rates supported_128b_132b_rates;
-	uint8_t aux_rd_interval[MAX_REPEATER_CNT - 1];
+	uint8_t aux_rd_interval[MAX_REPEATER_CNT];
 };
 
 struct dc_dongle_dfp_cap_ext {
-- 
2.53.0

