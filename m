Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 560D7CC6B03
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 11:20:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E094810F78D;
	Tue, 13 Oct 2026 11:20:47 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012045.outbound.protection.outlook.com [52.101.43.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A639E10F78F
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 11:20:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gQv/ye0OTECX96fvzOsLjhsG5xuCs3ix6O7XjW7qD5B4iOVdsMqkipQ1qw7c2En6DgnOCxfeRrQOkFOnIMou/WpZlV+Ln07doorewyxoOQWfgr1bDsEoLUjlzZaC6rWv21mFzAlglyEtBCUx+AlnGGMI31GZdl+04xPu4Brtf+fk9kJgapJ2sGEND6hAtHheazyeAh8GsMPP7uOQUoXEyH8u+PXTJiCmiXc57wkhhUnFjHcgkRWqU61dQnnSegu+AZ9bSSLScz0BIM0ippdpbI6t+luUGhoOxVO+CmuSR0VZkgldwz/g2KYMTz/dzSf5ZDW4shSarELIB+gfPPvn7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qYS4cqzBmgBas4RsOI2M2uuE3AL8Mhg9gjOJkquAPf8=;
 b=VnhPNFPgAHBUwIWynjeKGnb0RNNaHFxfx67D2MB4yy/5Iyllme/VsgKqsa9lIZD6mBMC23sLwRh9b/yVItTQsnf/0p4/q72/lwFvTBMDi7rYqOKzCx0hz1YXhjiWTXsCdTx8kqOg0B0NX3PKd6+OVV9YNW7wyQpCr6ojqLtoLRRSUlp0Wjr27FMLgGK05fLvONobJtfnmzVLQv7bBls8IaCwHAEmkWf0S6dm6A2L1cezsqV18fHBFeqZeN9ratFXLjTblQMlYcyGl3GboGANzqcg+3RFzzh0sO8NCPSaodvGRs12HsfUFQrnAdYFosV/SGW6lSeHvOGOSNFSzp/NwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qYS4cqzBmgBas4RsOI2M2uuE3AL8Mhg9gjOJkquAPf8=;
 b=v5UGxNOlWeSA8dJQWzWZJg6AzR8zKL8onVBs9/HG85CAVrBMiTFpIzgtUwZdWRibt1ySwVFYMHZbXUNQyRIpcz+BcKkMZ7LWu8vjgVrCXiRJFxxka96xmNYZnbV+BMcp4z3lMuQcb0POnuWrDvGQdBTM9SHcIrMUqtG9ypxzUD8=
Received: from CH2PR02CA0017.namprd02.prod.outlook.com (2603:10b6:610:4e::27)
 by SJ0PR12MB7475.namprd12.prod.outlook.com (2603:10b6:a03:48d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 11:20:37 +0000
Received: from DM3PEPF000265C6.namprd03.prod.outlook.com
 (2603:10b6:610:4e:cafe::a5) by CH2PR02CA0017.outlook.office365.com
 (2603:10b6:610:4e::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 13
 Oct 2026 11:20:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DM3PEPF000265C6.mail.protection.outlook.com (10.167.23.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 11:20:36 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 06:20:30 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 13 Oct 2026 06:20:21 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>, Ray Wu
 <ray.wu@amd.com>
Subject: [PATCH 30/30] drm/amd/display: Promote DC to 3.2.403
Date: Tue, 13 Oct 2026 19:08:17 +0800
Message-ID: <20261013111616.2267344-31-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013111616.2267344-1-ray.wu@amd.com>
References: <20261013111616.2267344-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265C6:EE_|SJ0PR12MB7475:EE_
X-MS-Office365-Filtering-Correlation-Id: ef98dea5-c875-43ca-c050-08df291c013f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|1800799024|82310400026|376014|10067099003|261009223027099003|11063799006|6133799003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: 7tz75ULbX3QiK8ub7cSHl6m/s+I8jdcn3cKECpHsMw+/kMK4qOs0JQPcMsxVl6HssxKl4ZQ6pYmGnTpRkwZFB/eCTgDPOWsCboeFktdhQDjXHi0RsNfdxGz1bXMPy1Fx0s/oQOcKnx1ghlEWH+cydycbr6TRumExXcz4xIj4jy06l3nJT16SOTNtHRrqvMOMbvQGDp0MJ6xttMFKY2mK8KaIaa6IhslKo75oKcMkWl9/iFCmauDuII3U/Xawgy0vpYnVo3+0wVtgIVw8uQpmC3Ei8jSREOWDETaDwvuR+FU9J+kAppSmQqYjdomead7ROnt4TQQjWlqT00A5nKE9AQaTNC9JqQQcHyMNnD3ffCshe9wCxOS4rMjNPzXrB6LxtH88aejEhHKH5pViFmq8sbrRVgVWWOj1mHNhVXlS2NHRRo7qjIN1xwyKLXAHmziF/sV4Bzgg6vUH0hzUTWQnWhVczi1dLz5W6uJu5L4vSYEpFQzQSfITkeU4PQJ4G7zrIO3FvEpdPqX+xoMszg12Tz3mq+fS12iGPgBu5IOrxnH1g4cU522eJ44FCGLjGlEo2HmN23q23oEkXfzbmCw65VgTp8x22SF9/ULM6T1Lgo9nq7NBFqVKheZNMe5iKUTXyO2dNVfG/OIE5qrQ7cSOKZkJmp61QnvtjGztO/rh5jzQIn+ySzmFZG4K0B93i6Of7k+WvuTxon/eIQbkFJ8LzA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(1800799024)(82310400026)(376014)(10067099003)(261009223027099003)(11063799006)(6133799003)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /z2U+vsjcuP5ofCgzCHWB052W8PAq3TtD+wS+DjzAp5zCEtyr6zWfXHrvOihfwkRn+tM+KXGLQPj/8TlOAjwEKYynBRHBypi1a5kMp+SDWC7RhwYO561t4suZeEACbSqq+3qT4e1oIMoJa6B+QIE5ZMx6qJiteeGBzKhs9k33GdzBu1srAVcquxONk8sneRRX8tYzAtJRM3HpME5mNKLWNpFTkNirsVwU9xbIzgne+rpB68zUBTXYb70vUvsqF/5ibym3heuBaPxqz+Y/hmQb4MfO2Ya5sYal6vGx9l8qSL/ZvSVn8TALu/pvI+poAEIdTEmmVCaA6qOGjLvVyISwg0YWCLenemoBLtHNtSuN3UiDuNbkGgSz96YYql5jHsrRLX54hYemrEGsrMzGdsR4qunf7A3WnhliNz87/4ileSrbTxX1N+oiHRULHV3TdIe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 11:20:36.5874 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef98dea5-c875-43ca-c050-08df291c013f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3PEPF000265C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7475
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

From: Taimur Hassan <Syed.Hassan@amd.com>

This version brings along the following updates:
 - Fix HDMI FRL FFE compliance test and adjust FRL LT timeout.
 - Align eDP DSC link policy to minimize lane count.
 - Add AS-SDP V3 support for VESA Panel Replay.
 - Add DPG force-on-flip support.
 - Log PSR/Replay status and exit PSR/Replay on non-modeset full updates.
 - Reject invalid per-mode FreeSync timing and set VRR_EN state.
 - Align VRR timing gate with FreeSync module.
 - Warn on unadvertised modes without scaling.
 - Use DMUB to notify PME and update DMU cmd header.
 - Do not allow vbios version of dmubfw in the driver.
 - Use picoseconds for line time and correct next frame calculation.
 - Fix YUV422 semi-planar color blurring and UPSP chroma upsampling.
 - Reset UPSP and pre-CSC registers on DCN6 DPP reset.
 - Handle exit LS in second ISHARP programming block.
 - Remove hard-coded min dcfclk for AC.
 - Do not WARN when removing an unallocated MST payload.
 - Various cleanups, KUnit test fixes and debug flag gating.

Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 5bd990138f20..f4fefa7c9ab8 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -68,7 +68,7 @@ struct dcn_dsc_reg_state;
 struct dcn_optc_reg_state;
 struct dcn_dccg_reg_state;
 
-#define DC_VER "3.2.402"
+#define DC_VER "3.2.403"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.43.0

