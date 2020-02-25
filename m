Return-Path: <SRS0=Kz8i=4N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9AA8C35E01
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 20:32:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADCF021744
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 20:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HddmFmZb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADCF021744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DA616E909;
	Tue, 25 Feb 2020 20:32:35 +0000 (UTC)
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06AD66E8E7
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2020 20:32:33 +0000 (UTC)
Received: by mail-qt1-x842.google.com with SMTP id j34so622704qtk.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2020 12:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wimofHPSlfd4nz0ukRpRm+xjmm3kRO5KxhatcIZiayQ=;
 b=HddmFmZbMumtxVmA/RwhzfJ/p3t+MuNX301nX9O9EXGhLyori/YMcLz5DRYwzsEzt5
 9ZEkN5+NGCr0PJdmyTxSm+1bGsl7sdJV49g26wbVKcrTnmgAbR7hJdfwgLsHKVsTuCFs
 fYm6uWtn7C5rDa9QGUco3SQ3ZgdmMVF0cmo85RvmtReJ6gYiCeHs972OTKAUspGlAucL
 mACXYeByH5vaCf0b4KTNl74zXvXVzhW6hva4Ytv5y84npZtV6PnHliXmN+JP/mPWfgOL
 841yZcTqTriJZE+SIyJeo5eCCKMV+hryqcnl5rtbT3nIglkD+2w7JKNpXdMz+WUPJv3T
 gvOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wimofHPSlfd4nz0ukRpRm+xjmm3kRO5KxhatcIZiayQ=;
 b=QLiQyrGOJPaJjumBhskcOOzPIwOf2ltDA0tC2oXSFS2q6EL3El1XYN/X4b/zi6+At6
 Qj59jWJQ/XBAFf8IcHSnYn5WUSuAt0FUQKfkIHsteSQ1NgrX6u7jQ3bbf8gvCa8nS61G
 UmRrwKTZmzk/UiB3DiX4UFPOVStD5R/f37Fvq+IXZQidRTSYOPp9Bat/bDYc+Qiax5Lk
 mC30Xb5E4cMhfJi5vFFgexxhET5q+TbcfpqSeWVgFIJpNKhwfv24l5i9CSBMbs2OCG50
 yrmmBi6AX3s0Iz25X1jVACJhGzsJ5U9Ii0FNEHunWjgqAaRtghWWRyI/uEl8B3r0KhtX
 5oVw==
X-Gm-Message-State: APjAAAX7gTB8uMhMQ6jTl/pCSI5dIVZeeUbKzSgMxN9jSHcWQmdpSmjl
 MzuE2AaLsKrcwUR/pkzs0FLwmge6
X-Google-Smtp-Source: APXvYqyRt1sLPefEPe1XFfXbP7BrFFL2RU7zjYp9oLp4H+oO+zW7TEE6Skj0aRb95NWrF1HYCaVsQw==
X-Received: by 2002:ac8:2fd4:: with SMTP id m20mr479133qta.313.1582662751886; 
 Tue, 25 Feb 2020 12:32:31 -0800 (PST)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id h34sm8219530qtc.62.2020.02.25.12.32.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 12:32:31 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu/display: Fix Pollock Variant Detection
Date: Tue, 25 Feb 2020 15:32:24 -0500
Message-Id: <20200225203224.1129396-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200225203224.1129396-1-alexander.deucher@amd.com>
References: <20200225203224.1129396-1-alexander.deucher@amd.com>
MIME-Version: 1.0
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Aly-Tawfik <altawfik@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aly-Tawfik <altawfik@amd.com>

Problem Description:
Currently we are checking internal fused rev id with pci rev id. However, fused
internal rev id is the same on all raven2 parts (in which Dali and Pollock were
based on too), thus Pollock detection fails

Fix:
use the pci rev to preform the detection for bandwidth calculations.

Signed-off-by: Aly-Tawfik <altawfik@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c |  5 +++++
 .../gpu/drm/amd/display/include/dal_asic_id.h    | 16 ++++++----------
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c b/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c
index f0f07b160152..3960a8db94cb 100644
--- a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c
@@ -712,6 +712,11 @@ unsigned int get_highest_allowed_voltage_level(uint32_t hw_internal_rev, uint32_
 		case PRID_DALI_DF:
 		case PRID_DALI_E3:
 		case PRID_DALI_E4:
+		case PRID_POLLOCK_94:
+		case PRID_POLLOCK_95:
+		case PRID_POLLOCK_E9:
+		case PRID_POLLOCK_EA:
+		case PRID_POLLOCK_EB:
 			return 0;
 		default:
 			break;
diff --git a/drivers/gpu/drm/amd/display/include/dal_asic_id.h b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
index ea7015f869c9..8a87d0ed90ae 100644
--- a/drivers/gpu/drm/amd/display/include/dal_asic_id.h
+++ b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
@@ -134,11 +134,6 @@
 #define PICASSO_A0 0x41
 /* DCN1_01 */
 #define RAVEN2_A0 0x81
-#define RAVEN2_15D8_REV_94 0x94
-#define RAVEN2_15D8_REV_95 0x95
-#define RAVEN2_15D8_REV_E9 0xE9
-#define RAVEN2_15D8_REV_EA 0xEA
-#define RAVEN2_15D8_REV_EB 0xEB
 #define RAVEN1_F0 0xF0
 #define RAVEN_UNKNOWN 0xFF
 #ifndef ASICREV_IS_RAVEN
@@ -149,16 +144,17 @@
 #define PRID_DALI_E3 0xE3
 #define PRID_DALI_E4 0xE4
 
+#define PRID_POLLOCK_94 0x94
+#define PRID_POLLOCK_95 0x95
+#define PRID_POLLOCK_E9 0xE9
+#define PRID_POLLOCK_EA 0xEA
+#define PRID_POLLOCK_EB 0xEB
+
 #define ASICREV_IS_PICASSO(eChipRev) ((eChipRev >= PICASSO_A0) && (eChipRev < RAVEN2_A0))
 #ifndef ASICREV_IS_RAVEN2
 #define ASICREV_IS_RAVEN2(eChipRev) ((eChipRev >= RAVEN2_A0) && (eChipRev < RENOIR_A0))
 #endif
 #define ASICREV_IS_RV1_F0(eChipRev) ((eChipRev >= RAVEN1_F0) && (eChipRev < RAVEN_UNKNOWN))
-#define ASICREV_IS_POLLOCK(eChipRev) (eChipRev == RAVEN2_15D8_REV_94 \
-		|| eChipRev == RAVEN2_15D8_REV_95 \
-			|| eChipRev == RAVEN2_15D8_REV_E9 \
-				|| eChipRev == RAVEN2_15D8_REV_EA \
-					|| eChipRev == RAVEN2_15D8_REV_EB)
 
 #define FAMILY_RV 142 /* DCN 1*/
 
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
