Return-Path: <SRS0=bpzG=HO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A947C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Feb 2021 17:57:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8FBC64E3D
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Feb 2021 17:57:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8FBC64E3D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FFC06E1E9;
	Fri, 12 Feb 2021 17:57:08 +0000 (UTC)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC5706E1E9
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Feb 2021 17:57:06 +0000 (UTC)
Received: by mail-qv1-xf29.google.com with SMTP id c25so163581qvb.4
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Feb 2021 09:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0fJhOLK8PCBo2LuKkNDhE9aQjHLhAPkkpyugjbkxC8U=;
 b=beMbbYPuDMMGaqQF01fd3kdsJtOVf3q5HqicvrZ73S+fF8Wt5PCa5aLiwpGwsrwDxK
 OCt5c1m7uMNBnl6VOg2II53lh2YBMqTPw3VtjSb3V1lzhItB6C23DSw6J/og8r+PO+l8
 0VmDbOYGGbuYOhK4shUwftm9RZR5uQzHEDkH1Xv8wdwstK72zJvY3H3DoTHtE+nn9EC4
 WBfrb52xLCB/P+KVK+k+sU5vpihDcilww61abl0yZg7ry6SHUez4yJ/ScEicXwtPEmtU
 PjmWurN1wpSKQTQTL2dAp13SdY3RdBuy9RlVlA7j1sIujie02nf9jLVfwZCDj/srOUww
 BTYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0fJhOLK8PCBo2LuKkNDhE9aQjHLhAPkkpyugjbkxC8U=;
 b=k9BFuCiRdC84E4yyBnOFQUsNDV12208yqCxMGizsvJ0o3M+rV7ClOYWda6UpV9JgHi
 gGeaMmVIvmhn81Zb9LylPfHbkRv5dnGrogSnB/L6QWzbgGOknvXK5WApdkAs5H7NvgLI
 Ca1pVmbmzCH/W89RQgC5jupkCAK+A8g6mt8G6BMwdw+yjPzHVY4N6+3ohvYEMRkSJNVC
 XbxZGhDFZxeR0dfgmXyiYET8t4uiMssYzRlIODqelTHcnxrHR5clGPZfIaGKu1QmNKeH
 dFFRP8LkHDRd4gM28pq1eOC640kTBgw0HniN7OaR71BjWWv97/PsVL9KPlzkX2Y7Echd
 TXkg==
X-Gm-Message-State: AOAM533ZVleC1j8Y19EwjOb6BeVJ3U06Vj8mFresNuS4n2W4LRx3+Qve
 m7YlbzuRgFmzWcUkdj6hRTWaXSGPQxo=
X-Google-Smtp-Source: ABdhPJy8uYj0BjKOttH8sLQjvE16TlP6pIrtzfhdit7+j48tXR8UPY48BKfBEr4ckKbJG5hCDjAoAQ==
X-Received: by 2002:a0c:fe0b:: with SMTP id x11mr3471511qvr.18.1613152625958; 
 Fri, 12 Feb 2021 09:57:05 -0800 (PST)
Received: from localhost.localdomain ([192.161.79.229])
 by smtp.gmail.com with ESMTPSA id 80sm6551966qkj.128.2021.02.12.09.57.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Feb 2021 09:57:05 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] Revert "drm/amd/display: Check lane status again after link
 training done"
Date: Fri, 12 Feb 2021 12:56:55 -0500
Message-Id: <20210212175655.458201-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Aric Cyr <Aric.Cyr@amd.com>,
 Martin Tsai <martin.tsai@amd.com>, Eryk Brol <eryk.brol@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit 3fd20292c2352660155bbc11736dd014b2fc6e98.

Fixes a display corruption issue on resume and undetected
modes on some monitors.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1424
Bug: https://bugzilla.kernel.org/show_bug.cgi?id=208947
Cc: Martin Tsai <martin.tsai@amd.com>
Cc: Aric Cyr <Aric.Cyr@amd.com>
Cc: Eryk Brol <eryk.brol@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 49 -------------------
 .../amd/display/include/link_service_types.h  |  2 -
 2 files changed, 51 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index c1391bfb7a9b..4aed57ce69e0 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -1165,44 +1165,6 @@ static inline enum link_training_result perform_link_training_int(
 	return status;
 }
 
-static enum link_training_result check_link_loss_status(
-	struct dc_link *link,
-	const struct link_training_settings *link_training_setting)
-{
-	enum link_training_result status = LINK_TRAINING_SUCCESS;
-	union lane_status lane_status;
-	uint8_t dpcd_buf[6] = {0};
-	uint32_t lane;
-
-	core_link_read_dpcd(
-			link,
-			DP_SINK_COUNT,
-			(uint8_t *)(dpcd_buf),
-			sizeof(dpcd_buf));
-
-	/*parse lane status*/
-	for (lane = 0; lane < link->cur_link_settings.lane_count; lane++) {
-		/*
-		 * check lanes status
-		 */
-		lane_status.raw = get_nibble_at_index(&dpcd_buf[2], lane);
-
-		if (!lane_status.bits.CHANNEL_EQ_DONE_0 ||
-			!lane_status.bits.CR_DONE_0 ||
-			!lane_status.bits.SYMBOL_LOCKED_0) {
-			/* if one of the channel equalization, clock
-			 * recovery or symbol lock is dropped
-			 * consider it as (link has been
-			 * dropped) dp sink status has changed
-			 */
-			status = LINK_TRAINING_LINK_LOSS;
-			break;
-		}
-	}
-
-	return status;
-}
-
 static void initialize_training_settings(
 	 struct dc_link *link,
 	const struct dc_link_settings *link_setting,
@@ -1455,9 +1417,6 @@ static void print_status_message(
 	case LINK_TRAINING_LQA_FAIL:
 		lt_result = "LQA failed";
 		break;
-	case LINK_TRAINING_LINK_LOSS:
-		lt_result = "Link loss";
-		break;
 	default:
 		break;
 	}
@@ -1616,14 +1575,6 @@ enum link_training_result dc_link_dp_perform_link_training(
 				status);
 	}
 
-	/* delay 5ms after Main Link output idle pattern and then check
-	 * DPCD 0202h.
-	 */
-	if (link->connector_signal != SIGNAL_TYPE_EDP && status == LINK_TRAINING_SUCCESS) {
-		msleep(5);
-		status = check_link_loss_status(link, &lt_settings);
-	}
-
 	/* 6. print status message*/
 	print_status_message(link, &lt_settings, status);
 
diff --git a/drivers/gpu/drm/amd/display/include/link_service_types.h b/drivers/gpu/drm/amd/display/include/link_service_types.h
index 7392a89e771f..50720bbbbaf6 100644
--- a/drivers/gpu/drm/amd/display/include/link_service_types.h
+++ b/drivers/gpu/drm/amd/display/include/link_service_types.h
@@ -66,8 +66,6 @@ enum link_training_result {
 	/* other failure during EQ step */
 	LINK_TRAINING_EQ_FAIL_EQ,
 	LINK_TRAINING_LQA_FAIL,
-	/* one of the CR,EQ or symbol lock is dropped */
-	LINK_TRAINING_LINK_LOSS,
 };
 
 struct link_training_settings {
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
