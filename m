Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57088CD1288
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Apr 2024 19:51:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDEEA112E72;
	Wed,  3 Apr 2024 19:51:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SpicRFX7";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0F73112E72
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Apr 2024 19:51:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fvACiYJUsomAm3mWRXZwLX5LgsmXuFMgyfqathIUwTpFx8CqX7xD4uincjcNTlQevH8kJfjwEk8KT/6DoWJtYosT1L5l0QnzGm0ZiWlDxPgHhgv7PMoRiGp+EHuXdcMcLgGJB6Ucjt0Gs5wv756URDrtvKJ6VGuLiwEDXGHqVkajdWzmnAy2Y0GhS2ZSsMAo5Q0nj34CmeXLurUVudF8ZC9UBPlBq6rNSQqZuhzGNAyEF61W+Vx+nEtStNvFkYs0JVB+1A1BMy7vDJDnQxM0KXK7kK+P8IpY6VueKpMOjSCk5t1ItErbzTXnJZ26nM11JuFGqSmD1eRWHMVUE6Xclg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tPfXmBDlG5ESOxKM7YCxPCLI5dQJSxH+4QBFV1F2ypA=;
 b=jFMy/tvBjm2jPoMJkYVlwn5ZiEOz5VdLxBhPgaUQej37ny58BpMjfG+44DDe5TVYyZc4IuYIqYa3J/A5CVu8MTkz7AX2pKnyihQt+APpcyz5Dkx2YigCDT17f5OfJzRGuWsDqj2b0gHqmh3CI8bFJpjbUXqPbedNmNpkJ4/ics4Zj6thUhShjGMxkK+nw022g0TiWknJ3VDVEExsctnrTJMgZ1Sn+sdR9oSXwoFX7Q56B3g9t9hiylYMvD9R54lOo1DPSsVZ7lCMWMvF6NOrcqrvZxSHoWKyp6BchfJitbVKJLiAyhl/7D9Uaj+Ws6y5IjNc/95Yp+KuIbFmRzHMAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tPfXmBDlG5ESOxKM7YCxPCLI5dQJSxH+4QBFV1F2ypA=;
 b=SpicRFX7Zi0tXgTI12BmrjbxlmZuUgCc3VlxFl6d4pW8SColARm+I3Lg4JgPhd6t5DHOv8hqa5PKRrPy5cLr5qM62IDSbp6tgGcTUgNgzras7AXogAA+PRWNQwOKZQs9yMp1o8mhltil+HP9mqxcvqcwayrDpLZAQykmp+amkAQ=
Received: from CH0PR04CA0083.namprd04.prod.outlook.com (2603:10b6:610:74::28)
 by DS0PR12MB7509.namprd12.prod.outlook.com (2603:10b6:8:137::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 19:51:46 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:74:cafe::60) by CH0PR04CA0083.outlook.office365.com
 (2603:10b6:610:74::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Wed, 3 Apr 2024 19:51:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD74.mail.protection.outlook.com (10.167.244.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 3 Apr 2024 19:51:46 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 3 Apr
 2024 14:51:38 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Parandhaman K
 <parandhaman.k@amd.com>, Alvin Lee <alvin.lee2@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>
Subject: [PATCH 09/28] drm/amd/display: refactor vpg.h
Date: Wed, 3 Apr 2024 15:48:59 -0400
Message-ID: <20240403195116.25221-10-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403195116.25221-1-hamza.mahfooz@amd.com>
References: <20240403195116.25221-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|DS0PR12MB7509:EE_
X-MS-Office365-Filtering-Correlation-Id: dafb2d16-2222-4b39-3586-08dc54177ebf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4NHT4CDTa091je0K+csv/D4k7rjgxubDb+3RJflRdUMA6Y3Nbei35MlCSIifY2JUSoh4p/WwB3O0QlFv7v+AoQdGDhxCDO651x+lyRZjxX85/i0dtz+Dg+KbogXP4Ee7IaI0hS3O+jbVS3EesMcGIUBN2Etwxg8CnxROqfWirnuPEiKp+bluxlYtK0bpLPZ8IhVmMlKP2/I+uQbR7xxRyMAzpmeF4tvO846WtADAvNUMZOpRsFt+uTiJIZbhmmnvy7aaSMEE8Il0cRa8bPng1h/TC172LAp3Iv/LyKUufz3fiYbVc21cXKBBGGTDRSx6NNIAZm5XWb4oMqkqY2ZYRnfMYoFlsAvkDV767NynobLPc8gywoqv/7SUql1fNzuohOWZMUOaX3EVsv8wLwmm9pGu3y+Ca3iH8c7d7ym45d4AD6VKfbXb6Ss78zj8YDrAPVq4U3mAGZJL8b/oOn2NxHv2JTbsWnsQPCaCDtEBB5uZWHuUNVW5EPlSGmhFaR7L/aQIumMhSi8exez5e3I4nBFxlH8wLmTZYKeexsKlViFq0YdjUPDPYtUoo7Hd8ebGaceO0RsiFqjt2vqYvs3Umj/2ooP4zy72OYcJkDdSq/KS64usU9iEcvztIvfMP4JXiDbwF08Df4fkXJeds7QW3CC+w+y+mSe0FpmNDYXkzi3VD1tLYKwBjoqDooOd6F+ENgHFnPoGJCmPHxzG1E93/A2woqyNgxtNEgONmD5z1q8jL1tZXkmtSZDD4KGqtQWt
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 19:51:46.6584 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dafb2d16-2222-4b39-3586-08dc54177ebf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7509
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

From: Parandhaman K <parandhaman.k@amd.com>

why and how:
as part of cleanup, need to refactor vpg. It was improperly referenced
as a dcn specfic part of link. the dcn agnostic code needed was ripped out
and put into vpg.h, now in dc/inc/hw.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Parandhaman K <parandhaman.k@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn30/dcn30_vpg.h  | 23 +-------
 .../gpu/drm/amd/display/dc/dcn31/dcn31_vpg.h  |  1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/vpg.h   | 53 +++++++++++++++++++
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |  3 +-
 4 files changed, 57 insertions(+), 23 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/inc/hw/vpg.h

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_vpg.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_vpg.h
index ed9a5549c389..466ba20b9c61 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_vpg.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_vpg.h
@@ -26,6 +26,7 @@
 #ifndef __DAL_DCN30_VPG_H__
 #define __DAL_DCN30_VPG_H__
 
+#include "vpg.h"
 
 #define DCN30_VPG_FROM_VPG(vpg)\
 	container_of(vpg, struct dcn30_vpg, base)
@@ -132,28 +133,6 @@ struct dcn30_vpg_mask {
 	VPG_DCN3_REG_FIELD_LIST(uint32_t);
 };
 
-struct vpg;
-
-struct vpg_funcs {
-	void (*update_generic_info_packet)(
-		struct vpg *vpg,
-		uint32_t packet_index,
-		const struct dc_info_packet *info_packet,
-		bool immediate_update);
-
-	void (*vpg_poweron)(
-		struct vpg *vpg);
-
-	void (*vpg_powerdown)(
-		struct vpg *vpg);
-};
-
-struct vpg {
-	const struct vpg_funcs *funcs;
-	struct dc_context *ctx;
-	int inst;
-};
-
 struct dcn30_vpg {
 	struct vpg base;
 	const struct dcn30_vpg_registers *regs;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_vpg.h b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_vpg.h
index 0e76eabce441..609e58dbd056 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_vpg.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_vpg.h
@@ -26,6 +26,7 @@
 #ifndef __DAL_DCN31_VPG_H__
 #define __DAL_DCN31_VPG_H__
 
+#include "vpg.h"
 
 #define DCN31_VPG_FROM_VPG(vpg)\
 	container_of(vpg, struct dcn31_vpg, base)
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/vpg.h b/drivers/gpu/drm/amd/display/dc/inc/hw/vpg.h
new file mode 100644
index 000000000000..51da368f5c3e
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/vpg.h
@@ -0,0 +1,53 @@
+/*
+ * Copyright 2024 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ */
+
+#ifndef __DC_VPG_H__
+#define __DC_VPG_H__
+
+struct dc_context;
+struct dc_info_packet;
+
+struct vpg;
+
+struct vpg_funcs {
+	void (*update_generic_info_packet)(
+		struct vpg *vpg,
+		uint32_t packet_index,
+		const struct dc_info_packet *info_packet,
+		bool immediate_update);
+
+	void (*vpg_poweron)(
+		struct vpg *vpg);
+
+	void (*vpg_powerdown)(
+		struct vpg *vpg);
+};
+
+struct vpg {
+	const struct vpg_funcs *funcs;
+	struct dc_context *ctx;
+	int inst;
+};
+
+#endif /* DC_INC_VPG_H_ */
\ No newline at end of file
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index ce68476e69d5..938421e02770 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -55,6 +55,8 @@
 #include "dccg.h"
 #include "clk_mgr.h"
 #include "atomfirmware.h"
+#include "vpg.h"
+
 #define DC_LOGGER \
 	dc_logger
 #define DC_LOGGER_INIT(logger) \
@@ -67,7 +69,6 @@
 #define RETIMER_REDRIVER_INFO(...) \
 	DC_LOG_RETIMER_REDRIVER(  \
 		__VA_ARGS__)
-#include "dc/dcn30/dcn30_vpg.h"
 
 #define MAX_MTP_SLOT_COUNT 64
 #define LINK_TRAINING_ATTEMPTS 4
-- 
2.44.0

