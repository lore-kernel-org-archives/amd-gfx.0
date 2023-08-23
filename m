Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0888DEE4993
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Aug 2023 15:51:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10C1F10E44C;
	Wed, 23 Aug 2023 15:51:34 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2054.outbound.protection.outlook.com [40.107.101.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 110A610E43B
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Aug 2023 15:51:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZG/CU2TT3IuJ4VEYBWWWjEosaBP4IuUgqvtJgjTqCRsi2yLKJiydHRdo58uXdtO/NtaWbugJlbWEEHkplhOole03pn8gqioESzksIRy+FrRqea632XA5QcWtJkVF5tn+8WOWHrZqnKYQYRzqv1ir13isYLxpJSMA8q8jbkzS8bDRoCPU2q7wADTf2OUuUZMlzUYwmpw7unnFFtRo4f/iTP4DfFi+IJsZtwl7txXphBWUdNesYSfHmjVQEnY6n1/kM9d46RXYjW0mKBtE2rf2vlTbCsH6yR71dyXKpZrUhdjj/Z3IgsguHW5hYNC+mhDZdZtMG79XGxoBPxIJHOSe+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8pX3ONi8XtprDDkZ11wWqtONFBZYccjA52kg9j7ao3s=;
 b=AqN/Xxh9aA4w8LyqMKVa8wf6FMmrX2GY3ki9h4pwYaDw2YzvzhnIKMaAPE5Ep/oTzvAOT5ismd3hSEc2JGe0DNA8afwAmJPC0UngRTDM2LB2TpU+bepcjIkaqLwCTsrvG5HsY1YnNAjhZ4RH7Cs2uNkaHGsrN8fLjPSipf6DNeMuV91RUXjC9VjYYX2bXaftSHIK5dLfRWL7kzy7lO5GltLs2dHeQsYQFutPZQDIyOohD1zCVEGwZ+6WjpWrPcynmWPeZJllVitPaMlQDBB51AhmtfT7+a7nBlpAA9rTV+NqU6622fVJGEQePXu1dSX531cWjlZ/GTP03Qyzcm4Ahw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8pX3ONi8XtprDDkZ11wWqtONFBZYccjA52kg9j7ao3s=;
 b=cXCeNM7Lpdsuvo3bgwPOhmAkcHl4w8gjzqs01dGvD4sKNs03lKKUVd39Zm0J+jqY++ZBu71/ggp6PUphojD0gD0Ngx6Il0znanT02aExyUk8/Aviuwbr284GuUKUXU6WhZWePoGOTfpyjsPR3XrvL4k8Ju+GqQmdKezJA8Lv5J4=
Received: from CY5PR18CA0059.namprd18.prod.outlook.com (2603:10b6:930:13::22)
 by SJ0PR12MB6733.namprd12.prod.outlook.com (2603:10b6:a03:477::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Wed, 23 Aug
 2023 15:51:19 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:930:13:cafe::26) by CY5PR18CA0059.outlook.office365.com
 (2603:10b6:930:13::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26 via Frontend
 Transport; Wed, 23 Aug 2023 15:51:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 23 Aug 2023 15:51:19 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 10:51:17 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 22/35] drm/amd/display: Add DCN35 HUBBUB
Date: Wed, 23 Aug 2023 11:50:35 -0400
Message-ID: <20230823155048.2526343-22-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230823155048.2526343-1-alexander.deucher@amd.com>
References: <20230823155048.2526343-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|SJ0PR12MB6733:EE_
X-MS-Office365-Filtering-Correlation-Id: 2992f184-72bf-41e6-1447-08dba3f0caed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dSKTVWQR5ypOl2EnKTnoHNqi2x/Pft1nyxcH9kbrCWgyadgegSIw8kZkz7oM7vhI7lAQxYC63NnlrOqxilfxqQ8jZU5s3PRzho7yeZ/eTzapt0gbfF8rvBNjF5XP58nWtLHphAN3Lk8nKVrVJjdviIqb0pdYRQdRFqpSq1bChw2nYbMpEkA31FdogK2jjuH9SIH8772tdimq1boA7v9LRR7Ei0VMV2aBbCJK565A/p5p2Ej8VBNqwi25/66a9JRyPy9pZOxCYp3VdZwGNhAUxjlwRBE2r4fTO1xAVdbPdBbKiNMrwKMXthldlATH76oVE5WHjwYGZnRyQQBnhbmYfk5samilG638c6BgiV511iwbgKTMmgnvgh83cb+jXLaOYfku0n/e7K/7KqS/hETuEGS0kE+kNuXP/gIYv+imJqaeEYv9zWBGTw5TBMwX3RMd+3twlWbSr2PTf/6k9FYTw6knVUkkM0TdY8wRDtcQGAmN6JQq3tDhWfsz2kTl16mHOuUTL8wCvv4Yi9p1TYfhhUafeFI12itSEhcGoiG/NNaVmYlOhKeORkuyJVTs3fYij5mKsTYMaymf51cyFmKlD+bk4OLv1kFcdinVqrkVuJT5kfy3oFfIIEJFtEh7OCuMFKCME0Dfw8nmhHjUUKpq1GE+MZRjz+p/W9ThPOrIINphdJ7D0CBjCTyoen2KA9wx7+y05cscFFjvRmHjFieDkwM8a/UUL/bw3SuX0pWtMmPBoHW163Hyrq79Ag20wYL44nGA9uDfEQuK0Pml6q/UDg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(136003)(346002)(39860400002)(186009)(1800799009)(451199024)(82310400011)(40470700004)(46966006)(36840700001)(54906003)(6916009)(316002)(70586007)(70206006)(66899024)(8676002)(8936002)(2616005)(4326008)(36756003)(40460700003)(41300700001)(1076003)(356005)(82740400003)(81166007)(478600001)(6666004)(40480700001)(83380400001)(30864003)(2906002)(47076005)(7696005)(36860700001)(86362001)(426003)(336012)(5660300002)(26005)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 15:51:19.3976 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2992f184-72bf-41e6-1447-08dba3f0caed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6733
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Qingqing Zhuo <Qingqing.Zhuo@amd.com>, Harry Wentland <Harry.Wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>

[Why & How]
Add HUBBUB handling for DCN35.

Signed-off-by: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
Acked-by: Harry Wentland <Harry.Wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/display/dc/dcn35/dcn35_hubbub.c   | 573 ++++++++++++++++++
 .../drm/amd/display/dc/dcn35/dcn35_hubbub.h   | 150 +++++
 2 files changed, 723 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubbub.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubbub.h

diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubbub.c
new file mode 100644
index 000000000000..895425e03247
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubbub.c
@@ -0,0 +1,573 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2023 Advanced Micro Devices, Inc.
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
+ */
+
+
+#include "dcn30/dcn30_hubbub.h"
+#include "dcn31/dcn31_hubbub.h"
+#include "dcn32/dcn32_hubbub.h"
+#include "dcn35_hubbub.h"
+#include "dm_services.h"
+#include "reg_helper.h"
+
+
+#define CTX \
+	hubbub2->base.ctx
+#define DC_LOGGER \
+	hubbub2->base.ctx->logger
+#define REG(reg)\
+	hubbub2->regs->reg
+
+#undef FN
+#define FN(reg_name, field_name) \
+	hubbub2->shifts->field_name, hubbub2->masks->field_name
+
+#define DCN35_CRB_SEGMENT_SIZE_KB 64
+
+static void dcn35_init_crb(struct hubbub *hubbub)
+{
+	struct dcn20_hubbub *hubbub2 = TO_DCN20_HUBBUB(hubbub);
+
+	REG_GET(DCHUBBUB_DET0_CTRL, DET0_SIZE_CURRENT,
+		&hubbub2->det0_size);
+
+	REG_GET(DCHUBBUB_DET1_CTRL, DET1_SIZE_CURRENT,
+		&hubbub2->det1_size);
+
+	REG_GET(DCHUBBUB_DET2_CTRL, DET2_SIZE_CURRENT,
+		&hubbub2->det2_size);
+
+	REG_GET(DCHUBBUB_DET3_CTRL, DET3_SIZE_CURRENT,
+		&hubbub2->det3_size);
+
+	REG_GET(DCHUBBUB_COMPBUF_CTRL, COMPBUF_SIZE_CURRENT,
+		&hubbub2->compbuf_size_segments);
+
+	REG_SET_2(COMPBUF_RESERVED_SPACE, 0,
+			COMPBUF_RESERVED_SPACE_64B, hubbub2->pixel_chunk_size / 32,
+			COMPBUF_RESERVED_SPACE_ZS, hubbub2->pixel_chunk_size / 128);
+	REG_UPDATE(DCHUBBUB_DEBUG_CTRL_0, DET_DEPTH, 0x47F);
+}
+
+static void dcn35_program_compbuf_size(struct hubbub *hubbub, unsigned int compbuf_size_kb, bool safe_to_increase)
+{
+	struct dcn20_hubbub *hubbub2 = TO_DCN20_HUBBUB(hubbub);
+	unsigned int compbuf_size_segments = (compbuf_size_kb + DCN35_CRB_SEGMENT_SIZE_KB - 1) / DCN35_CRB_SEGMENT_SIZE_KB;
+
+	if (safe_to_increase || compbuf_size_segments <= hubbub2->compbuf_size_segments) {
+		if (compbuf_size_segments > hubbub2->compbuf_size_segments) {
+			REG_WAIT(DCHUBBUB_DET0_CTRL, DET0_SIZE_CURRENT, hubbub2->det0_size, 1, 100);
+			REG_WAIT(DCHUBBUB_DET1_CTRL, DET1_SIZE_CURRENT, hubbub2->det1_size, 1, 100);
+			REG_WAIT(DCHUBBUB_DET2_CTRL, DET2_SIZE_CURRENT, hubbub2->det2_size, 1, 100);
+			REG_WAIT(DCHUBBUB_DET3_CTRL, DET3_SIZE_CURRENT, hubbub2->det3_size, 1, 100);
+		}
+		/* Should never be hit, if it is we have an erroneous hw config*/
+		ASSERT(hubbub2->det0_size + hubbub2->det1_size + hubbub2->det2_size
+				+ hubbub2->det3_size + compbuf_size_segments <= hubbub2->crb_size_segs);
+		REG_UPDATE(DCHUBBUB_COMPBUF_CTRL, COMPBUF_SIZE, compbuf_size_segments);
+		hubbub2->compbuf_size_segments = compbuf_size_segments;
+		ASSERT(REG_GET(DCHUBBUB_COMPBUF_CTRL, CONFIG_ERROR, &compbuf_size_segments) && !compbuf_size_segments);
+	}
+}
+
+static uint32_t convert_and_clamp(
+	uint32_t wm_ns,
+	uint32_t refclk_mhz,
+	uint32_t clamp_value)
+{
+	uint32_t ret_val = 0;
+
+	ret_val = wm_ns * refclk_mhz;
+
+	ret_val /= 1000;
+
+	if (ret_val > clamp_value)
+		ret_val = clamp_value;
+
+	return ret_val;
+}
+
+static bool hubbub35_program_stutter_z8_watermarks(
+		struct hubbub *hubbub,
+		struct dcn_watermark_set *watermarks,
+		unsigned int refclk_mhz,
+		bool safe_to_lower)
+{
+	struct dcn20_hubbub *hubbub2 = TO_DCN20_HUBBUB(hubbub);
+	uint32_t prog_wm_value;
+	bool wm_pending = false;
+
+	/* clock state A */
+	if (watermarks->a.cstate_pstate.cstate_enter_plus_exit_z8_ns
+			> hubbub2->watermarks.a.cstate_pstate.cstate_enter_plus_exit_z8_ns) {
+		hubbub2->watermarks.a.cstate_pstate.cstate_enter_plus_exit_z8_ns =
+				watermarks->a.cstate_pstate.cstate_enter_plus_exit_z8_ns;
+		prog_wm_value = convert_and_clamp(
+				watermarks->a.cstate_pstate.cstate_enter_plus_exit_z8_ns,
+				refclk_mhz, 0xffff);
+		REG_SET(DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_Z8_A, 0,
+				DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_Z8_A, prog_wm_value);
+		DC_LOG_BANDWIDTH_CALCS("SR_ENTER_WATERMARK_Z8_A calculated =%d\n"
+			"HW register value = 0x%x\n",
+			watermarks->a.cstate_pstate.cstate_enter_plus_exit_z8_ns, prog_wm_value);
+	} else if (watermarks->a.cstate_pstate.cstate_enter_plus_exit_z8_ns
+			< hubbub2->watermarks.a.cstate_pstate.cstate_enter_plus_exit_z8_ns)
+		wm_pending = true;
+
+	if (safe_to_lower || watermarks->a.cstate_pstate.cstate_exit_z8_ns
+			> hubbub2->watermarks.a.cstate_pstate.cstate_exit_z8_ns) {
+		hubbub2->watermarks.a.cstate_pstate.cstate_exit_z8_ns =
+				watermarks->a.cstate_pstate.cstate_exit_z8_ns;
+		prog_wm_value = convert_and_clamp(
+				watermarks->a.cstate_pstate.cstate_exit_z8_ns,
+				refclk_mhz, 0xffff);
+		REG_SET(DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_A, 0,
+				DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_A, prog_wm_value);
+		DC_LOG_BANDWIDTH_CALCS("SR_EXIT_WATERMARK_Z8_A calculated =%d\n"
+			"HW register value = 0x%x\n",
+			watermarks->a.cstate_pstate.cstate_exit_z8_ns, prog_wm_value);
+	} else if (watermarks->a.cstate_pstate.cstate_exit_z8_ns
+			< hubbub2->watermarks.a.cstate_pstate.cstate_exit_z8_ns)
+		wm_pending = true;
+
+	/* clock state B */
+
+	if (safe_to_lower || watermarks->b.cstate_pstate.cstate_enter_plus_exit_z8_ns
+			> hubbub2->watermarks.b.cstate_pstate.cstate_enter_plus_exit_z8_ns) {
+		hubbub2->watermarks.b.cstate_pstate.cstate_enter_plus_exit_z8_ns =
+				watermarks->b.cstate_pstate.cstate_enter_plus_exit_z8_ns;
+		prog_wm_value = convert_and_clamp(
+				watermarks->b.cstate_pstate.cstate_enter_plus_exit_z8_ns,
+				refclk_mhz, 0xffff);
+		REG_SET(DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_Z8_B, 0,
+				DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_Z8_B, prog_wm_value);
+		DC_LOG_BANDWIDTH_CALCS("SR_ENTER_WATERMARK_Z8_B calculated =%d\n"
+			"HW register value = 0x%x\n",
+			watermarks->b.cstate_pstate.cstate_enter_plus_exit_z8_ns, prog_wm_value);
+	} else if (watermarks->b.cstate_pstate.cstate_enter_plus_exit_z8_ns
+			< hubbub2->watermarks.b.cstate_pstate.cstate_enter_plus_exit_z8_ns)
+		wm_pending = true;
+
+	if (safe_to_lower || watermarks->b.cstate_pstate.cstate_exit_z8_ns
+			> hubbub2->watermarks.b.cstate_pstate.cstate_exit_z8_ns) {
+		hubbub2->watermarks.b.cstate_pstate.cstate_exit_z8_ns =
+				watermarks->b.cstate_pstate.cstate_exit_z8_ns;
+		prog_wm_value = convert_and_clamp(
+				watermarks->b.cstate_pstate.cstate_exit_z8_ns,
+				refclk_mhz, 0xffff);
+		REG_SET(DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_B, 0,
+				DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_B, prog_wm_value);
+		DC_LOG_BANDWIDTH_CALCS("SR_EXIT_WATERMARK_Z8_B calculated =%d\n"
+			"HW register value = 0x%x\n",
+			watermarks->b.cstate_pstate.cstate_exit_z8_ns, prog_wm_value);
+	} else if (watermarks->b.cstate_pstate.cstate_exit_z8_ns
+			< hubbub2->watermarks.b.cstate_pstate.cstate_exit_z8_ns)
+		wm_pending = true;
+
+	/* clock state C */
+	if (safe_to_lower || watermarks->c.cstate_pstate.cstate_enter_plus_exit_z8_ns
+			> hubbub2->watermarks.c.cstate_pstate.cstate_enter_plus_exit_z8_ns) {
+		hubbub2->watermarks.c.cstate_pstate.cstate_enter_plus_exit_z8_ns =
+				watermarks->c.cstate_pstate.cstate_enter_plus_exit_z8_ns;
+		prog_wm_value = convert_and_clamp(
+				watermarks->c.cstate_pstate.cstate_enter_plus_exit_z8_ns,
+				refclk_mhz, 0xffff);
+		REG_SET(DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_Z8_C, 0,
+				DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_Z8_C, prog_wm_value);
+		DC_LOG_BANDWIDTH_CALCS("SR_ENTER_WATERMARK_Z8_C calculated =%d\n"
+			"HW register value = 0x%x\n",
+			watermarks->c.cstate_pstate.cstate_enter_plus_exit_z8_ns, prog_wm_value);
+	} else if (watermarks->c.cstate_pstate.cstate_enter_plus_exit_z8_ns
+			< hubbub2->watermarks.c.cstate_pstate.cstate_enter_plus_exit_z8_ns)
+		wm_pending = true;
+
+	if (safe_to_lower || watermarks->c.cstate_pstate.cstate_exit_z8_ns
+			> hubbub2->watermarks.c.cstate_pstate.cstate_exit_z8_ns) {
+		hubbub2->watermarks.c.cstate_pstate.cstate_exit_z8_ns =
+				watermarks->c.cstate_pstate.cstate_exit_z8_ns;
+		prog_wm_value = convert_and_clamp(
+				watermarks->c.cstate_pstate.cstate_exit_z8_ns,
+				refclk_mhz, 0xffff);
+		REG_SET(DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_C, 0,
+				DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_C, prog_wm_value);
+		DC_LOG_BANDWIDTH_CALCS("SR_EXIT_WATERMARK_Z8_C calculated =%d\n"
+			"HW register value = 0x%x\n",
+			watermarks->c.cstate_pstate.cstate_exit_z8_ns, prog_wm_value);
+	} else if (watermarks->c.cstate_pstate.cstate_exit_z8_ns
+			< hubbub2->watermarks.c.cstate_pstate.cstate_exit_z8_ns)
+		wm_pending = true;
+
+	/* clock state D */
+	if (safe_to_lower || watermarks->d.cstate_pstate.cstate_enter_plus_exit_z8_ns
+			> hubbub2->watermarks.d.cstate_pstate.cstate_enter_plus_exit_z8_ns) {
+		hubbub2->watermarks.d.cstate_pstate.cstate_enter_plus_exit_z8_ns =
+				watermarks->d.cstate_pstate.cstate_enter_plus_exit_z8_ns;
+		prog_wm_value = convert_and_clamp(
+				watermarks->d.cstate_pstate.cstate_enter_plus_exit_z8_ns,
+				refclk_mhz, 0xffff);
+		REG_SET(DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_Z8_D, 0,
+				DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_Z8_D, prog_wm_value);
+		DC_LOG_BANDWIDTH_CALCS("SR_ENTER_WATERMARK_Z8_D calculated =%d\n"
+			"HW register value = 0x%x\n",
+			watermarks->d.cstate_pstate.cstate_enter_plus_exit_z8_ns, prog_wm_value);
+	} else if (watermarks->d.cstate_pstate.cstate_enter_plus_exit_z8_ns
+			< hubbub2->watermarks.d.cstate_pstate.cstate_enter_plus_exit_z8_ns)
+		wm_pending = true;
+
+	if (safe_to_lower || watermarks->d.cstate_pstate.cstate_exit_z8_ns
+			> hubbub2->watermarks.d.cstate_pstate.cstate_exit_z8_ns) {
+		hubbub2->watermarks.d.cstate_pstate.cstate_exit_z8_ns =
+				watermarks->d.cstate_pstate.cstate_exit_z8_ns;
+		prog_wm_value = convert_and_clamp(
+				watermarks->d.cstate_pstate.cstate_exit_z8_ns,
+				refclk_mhz, 0xffff);
+		REG_SET(DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_D, 0,
+				DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_D, prog_wm_value);
+		DC_LOG_BANDWIDTH_CALCS("SR_EXIT_WATERMARK_Z8_D calculated =%d\n"
+			"HW register value = 0x%x\n",
+			watermarks->d.cstate_pstate.cstate_exit_z8_ns, prog_wm_value);
+	} else if (watermarks->d.cstate_pstate.cstate_exit_z8_ns
+			< hubbub2->watermarks.d.cstate_pstate.cstate_exit_z8_ns)
+		wm_pending = true;
+
+	return wm_pending;
+}
+
+static void hubbub35_get_dchub_ref_freq(struct hubbub *hubbub,
+		unsigned int dccg_ref_freq_inKhz,
+		unsigned int *dchub_ref_freq_inKhz)
+{
+	struct dcn20_hubbub *hubbub2 = TO_DCN20_HUBBUB(hubbub);
+	uint32_t ref_div = 0;
+	uint32_t ref_en = 0;
+	unsigned int dc_refclk_khz = 24000;
+
+	REG_GET_2(DCHUBBUB_GLOBAL_TIMER_CNTL, DCHUBBUB_GLOBAL_TIMER_REFDIV, &ref_div,
+			DCHUBBUB_GLOBAL_TIMER_ENABLE, &ref_en);
+
+	if (ref_en) {
+		if (ref_div == 2)
+			*dchub_ref_freq_inKhz = dc_refclk_khz / 2;
+		else
+			*dchub_ref_freq_inKhz = dc_refclk_khz;
+
+		/*
+		 * The external Reference Clock may change based on the board or
+		 * platform requirements and the programmable integer divide must
+		 * be programmed to provide a suitable DLG RefClk frequency between
+		 * a minimum of 20MHz and maximum of 50MHz
+		 */
+		if (*dchub_ref_freq_inKhz < 20000 || *dchub_ref_freq_inKhz > 50000)
+			ASSERT_CRITICAL(false);
+
+		return;
+	} else {
+		*dchub_ref_freq_inKhz = dc_refclk_khz;
+		/*init sequence issue on bringup patch*/
+		REG_UPDATE_2(DCHUBBUB_GLOBAL_TIMER_CNTL, DCHUBBUB_GLOBAL_TIMER_REFDIV, 1,
+			DCHUBBUB_GLOBAL_TIMER_ENABLE, 1);
+		// HUBBUB global timer must be enabled.
+		ASSERT_CRITICAL(false);
+		return;
+	}
+}
+
+
+static bool hubbub35_program_watermarks(
+		struct hubbub *hubbub,
+		struct dcn_watermark_set *watermarks,
+		unsigned int refclk_mhz,
+		bool safe_to_lower)
+{
+	bool wm_pending = false;
+	struct dcn20_hubbub *hubbub2 = TO_DCN20_HUBBUB(hubbub);
+
+	if (hubbub32_program_urgent_watermarks(hubbub, watermarks, refclk_mhz, safe_to_lower))
+		wm_pending = true;
+
+	if (hubbub32_program_stutter_watermarks(hubbub, watermarks, refclk_mhz, safe_to_lower))
+		wm_pending = true;
+
+	if (hubbub32_program_pstate_watermarks(hubbub, watermarks, refclk_mhz, safe_to_lower))
+		wm_pending = true;
+
+	if (hubbub32_program_usr_watermarks(hubbub, watermarks, refclk_mhz, safe_to_lower))
+		wm_pending = true;
+
+	if (hubbub35_program_stutter_z8_watermarks(hubbub, watermarks, refclk_mhz, safe_to_lower))
+		wm_pending = true;
+
+	REG_SET(DCHUBBUB_ARB_SAT_LEVEL, 0,
+			DCHUBBUB_ARB_SAT_LEVEL, 60 * refclk_mhz);
+	REG_UPDATE(DCHUBBUB_ARB_DF_REQ_OUTSTAND,
+			DCHUBBUB_ARB_MIN_REQ_OUTSTAND, 0xFF);/*hw delta*/
+
+	hubbub1_allow_self_refresh_control(hubbub, !hubbub->ctx->dc->debug.disable_stutter);
+
+	hubbub32_force_usr_retraining_allow(hubbub, hubbub->ctx->dc->debug.force_usr_allow);
+
+	return wm_pending;
+}
+
+/* Copy values from WM set A to all other sets */
+static void hubbub35_init_watermarks(struct hubbub *hubbub)
+{
+	struct dcn20_hubbub *hubbub2 = TO_DCN20_HUBBUB(hubbub);
+	uint32_t reg;
+
+	reg = REG_READ(DCHUBBUB_ARB_DATA_URGENCY_WATERMARK_A);
+	REG_WRITE(DCHUBBUB_ARB_DATA_URGENCY_WATERMARK_B, reg);
+	REG_WRITE(DCHUBBUB_ARB_DATA_URGENCY_WATERMARK_C, reg);
+	REG_WRITE(DCHUBBUB_ARB_DATA_URGENCY_WATERMARK_D, reg);
+
+	reg = REG_READ(DCHUBBUB_ARB_FRAC_URG_BW_FLIP_A);
+	REG_WRITE(DCHUBBUB_ARB_FRAC_URG_BW_FLIP_B, reg);
+	REG_WRITE(DCHUBBUB_ARB_FRAC_URG_BW_FLIP_C, reg);
+	REG_WRITE(DCHUBBUB_ARB_FRAC_URG_BW_FLIP_D, reg);
+
+	reg = REG_READ(DCHUBBUB_ARB_FRAC_URG_BW_NOM_A);
+	REG_WRITE(DCHUBBUB_ARB_FRAC_URG_BW_NOM_B, reg);
+	REG_WRITE(DCHUBBUB_ARB_FRAC_URG_BW_NOM_C, reg);
+	REG_WRITE(DCHUBBUB_ARB_FRAC_URG_BW_NOM_D, reg);
+
+	reg = REG_READ(DCHUBBUB_ARB_REFCYC_PER_TRIP_TO_MEMORY_A);
+	REG_WRITE(DCHUBBUB_ARB_REFCYC_PER_TRIP_TO_MEMORY_B, reg);
+	REG_WRITE(DCHUBBUB_ARB_REFCYC_PER_TRIP_TO_MEMORY_C, reg);
+	REG_WRITE(DCHUBBUB_ARB_REFCYC_PER_TRIP_TO_MEMORY_D, reg);
+
+	reg = REG_READ(DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_A);
+	REG_WRITE(DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_B, reg);
+	REG_WRITE(DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_C, reg);
+	REG_WRITE(DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_D, reg);
+
+	reg = REG_READ(DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_A);
+	REG_WRITE(DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_B, reg);
+	REG_WRITE(DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_C, reg);
+	REG_WRITE(DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_D, reg);
+
+	reg = REG_READ(DCHUBBUB_ARB_USR_RETRAINING_WATERMARK_A);
+	REG_WRITE(DCHUBBUB_ARB_USR_RETRAINING_WATERMARK_B, reg);
+	REG_WRITE(DCHUBBUB_ARB_USR_RETRAINING_WATERMARK_C, reg);
+	REG_WRITE(DCHUBBUB_ARB_USR_RETRAINING_WATERMARK_D, reg);
+
+	reg = REG_READ(DCHUBBUB_ARB_UCLK_PSTATE_CHANGE_WATERMARK_A);
+	REG_WRITE(DCHUBBUB_ARB_UCLK_PSTATE_CHANGE_WATERMARK_B, reg);
+	REG_WRITE(DCHUBBUB_ARB_UCLK_PSTATE_CHANGE_WATERMARK_C, reg);
+	REG_WRITE(DCHUBBUB_ARB_UCLK_PSTATE_CHANGE_WATERMARK_D, reg);
+
+	reg = REG_READ(DCHUBBUB_ARB_FCLK_PSTATE_CHANGE_WATERMARK_A);
+	REG_WRITE(DCHUBBUB_ARB_FCLK_PSTATE_CHANGE_WATERMARK_B, reg);
+	REG_WRITE(DCHUBBUB_ARB_FCLK_PSTATE_CHANGE_WATERMARK_C, reg);
+	REG_WRITE(DCHUBBUB_ARB_FCLK_PSTATE_CHANGE_WATERMARK_D, reg);
+}
+
+static void hubbub35_wm_read_state(struct hubbub *hubbub,
+		struct dcn_hubbub_wm *wm)
+{
+	struct dcn20_hubbub *hubbub2 = TO_DCN20_HUBBUB(hubbub);
+	struct dcn_hubbub_wm_set *s;
+
+	memset(wm, 0, sizeof(struct dcn_hubbub_wm));
+
+	s = &wm->sets[0];
+	s->wm_set = 0;
+	REG_GET(DCHUBBUB_ARB_DATA_URGENCY_WATERMARK_A,
+			DCHUBBUB_ARB_DATA_URGENCY_WATERMARK_A, &s->data_urgent);
+
+	REG_GET(DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_A,
+			DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_A, &s->sr_enter);
+
+	REG_GET(DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_A,
+			DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_A, &s->sr_exit);
+
+	REG_GET(DCHUBBUB_ARB_UCLK_PSTATE_CHANGE_WATERMARK_A,
+			 DCHUBBUB_ARB_UCLK_PSTATE_CHANGE_WATERMARK_A, &s->dram_clk_change);
+
+	REG_GET(DCHUBBUB_ARB_USR_RETRAINING_WATERMARK_A,
+			 DCHUBBUB_ARB_USR_RETRAINING_WATERMARK_A, &s->usr_retrain);
+
+	REG_GET(DCHUBBUB_ARB_FCLK_PSTATE_CHANGE_WATERMARK_A,
+			 DCHUBBUB_ARB_FCLK_PSTATE_CHANGE_WATERMARK_A, &s->fclk_pstate_change);
+
+	s = &wm->sets[1];
+	s->wm_set = 1;
+	REG_GET(DCHUBBUB_ARB_DATA_URGENCY_WATERMARK_B,
+			DCHUBBUB_ARB_DATA_URGENCY_WATERMARK_B, &s->data_urgent);
+
+	REG_GET(DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_B,
+			DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_B, &s->sr_enter);
+
+	REG_GET(DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_B,
+			DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_B, &s->sr_exit);
+
+	REG_GET(DCHUBBUB_ARB_UCLK_PSTATE_CHANGE_WATERMARK_B,
+			DCHUBBUB_ARB_UCLK_PSTATE_CHANGE_WATERMARK_B, &s->dram_clk_change);
+
+	REG_GET(DCHUBBUB_ARB_USR_RETRAINING_WATERMARK_B,
+			 DCHUBBUB_ARB_USR_RETRAINING_WATERMARK_B, &s->usr_retrain);
+
+	REG_GET(DCHUBBUB_ARB_FCLK_PSTATE_CHANGE_WATERMARK_B,
+			DCHUBBUB_ARB_FCLK_PSTATE_CHANGE_WATERMARK_B, &s->fclk_pstate_change);
+
+	s = &wm->sets[2];
+	s->wm_set = 2;
+	REG_GET(DCHUBBUB_ARB_DATA_URGENCY_WATERMARK_C,
+			DCHUBBUB_ARB_DATA_URGENCY_WATERMARK_C, &s->data_urgent);
+
+	REG_GET(DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_C,
+			DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_C, &s->sr_enter);
+
+	REG_GET(DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_C,
+			DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_C, &s->sr_exit);
+
+	REG_GET(DCHUBBUB_ARB_UCLK_PSTATE_CHANGE_WATERMARK_C,
+			DCHUBBUB_ARB_UCLK_PSTATE_CHANGE_WATERMARK_C, &s->dram_clk_change);
+
+	REG_GET(DCHUBBUB_ARB_USR_RETRAINING_WATERMARK_C,
+			 DCHUBBUB_ARB_USR_RETRAINING_WATERMARK_C, &s->usr_retrain);
+
+	REG_GET(DCHUBBUB_ARB_FCLK_PSTATE_CHANGE_WATERMARK_C,
+			DCHUBBUB_ARB_FCLK_PSTATE_CHANGE_WATERMARK_C, &s->fclk_pstate_change);
+
+	s = &wm->sets[3];
+	s->wm_set = 3;
+	REG_GET(DCHUBBUB_ARB_DATA_URGENCY_WATERMARK_D,
+			DCHUBBUB_ARB_DATA_URGENCY_WATERMARK_D, &s->data_urgent);
+
+	REG_GET(DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_D,
+			DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_D, &s->sr_enter);
+
+	REG_GET(DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_D,
+			DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_D, &s->sr_exit);
+
+	REG_GET(DCHUBBUB_ARB_UCLK_PSTATE_CHANGE_WATERMARK_D,
+			DCHUBBUB_ARB_UCLK_PSTATE_CHANGE_WATERMARK_D, &s->dram_clk_change);
+
+	REG_GET(DCHUBBUB_ARB_USR_RETRAINING_WATERMARK_D,
+			 DCHUBBUB_ARB_USR_RETRAINING_WATERMARK_D, &s->usr_retrain);
+
+	REG_GET(DCHUBBUB_ARB_FCLK_PSTATE_CHANGE_WATERMARK_D,
+			DCHUBBUB_ARB_FCLK_PSTATE_CHANGE_WATERMARK_D, &s->fclk_pstate_change);
+}
+
+static void hubbub35_set_fgcg(struct dcn20_hubbub *hubbub2, bool enable)
+{
+	REG_UPDATE(DCHUBBUB_CLOCK_CNTL, DCHUBBUB_FGCG_REP_DIS, !enable);
+}
+
+static void hubbub35_init(struct hubbub *hubbub)
+{
+	struct dcn20_hubbub *hubbub2 = TO_DCN20_HUBBUB(hubbub);
+	/*Enable clock gaters*/
+	if (hubbub->ctx->dc->debug.disable_clock_gate) {
+		/*done in hwseq*/
+		/*REG_UPDATE(DCFCLK_CNTL, DCFCLK_GATE_DIS, 0);*/
+
+		REG_UPDATE_2(DCHUBBUB_CLOCK_CNTL,
+			DISPCLK_R_DCHUBBUB_GATE_DIS, 0,
+			DCFCLK_R_DCHUBBUB_GATE_DIS, 0);
+	}
+	hubbub35_set_fgcg(hubbub2,
+			  hubbub->ctx->dc->debug.enable_fine_grain_clock_gating
+				  .bits.dchubbub);
+	/*
+	ignore the "df_pre_cstate_req" from the SDP port control.
+	only the DCN will determine when to connect the SDP port
+	*/
+	REG_UPDATE(DCHUBBUB_SDPIF_CFG0,
+			SDPIF_PORT_CONTROL, 1);
+	/*Set SDP's max outstanding request
+	When set to 1: Max outstanding is 512
+	When set to 0: Max outstanding is 256
+	must set the register back to 0 (max outstanding = 256) in zero frame buffer mode*/
+	REG_UPDATE(DCHUBBUB_SDPIF_CFG1,
+			SDPIF_MAX_NUM_OUTSTANDING, 0);
+
+	REG_UPDATE_2(DCHUBBUB_ARB_DF_REQ_OUTSTAND,
+			DCHUBBUB_ARB_MAX_REQ_OUTSTAND, 256,
+			DCHUBBUB_ARB_MIN_REQ_OUTSTAND, 256);
+
+}
+
+/*static void hubbub35_set_request_limit(struct hubbub *hubbub,
+				       int memory_channel_count,
+				       int words_per_channel)
+{
+	struct dcn20_hubbub *hubbub2 = TO_DCN20_HUBBUB(hubbub);
+
+	uint32_t request_limit = 3 * memory_channel_count * words_per_channel / 4;
+
+	ASSERT((request_limit & (~0xFFF)) == 0); //field is only 24 bits long
+	ASSERT(request_limit > 0); //field is only 24 bits long
+
+	if (request_limit > 0xFFF)
+		request_limit = 0xFFF;
+
+	if (request_limit > 0)
+		REG_UPDATE(SDPIF_REQUEST_RATE_LIMIT, SDPIF_REQUEST_RATE_LIMIT, request_limit);
+}*/
+
+static const struct hubbub_funcs hubbub35_funcs = {
+	.update_dchub = hubbub2_update_dchub,
+	.init_dchub_sys_ctx = hubbub31_init_dchub_sys_ctx,
+	.init_vm_ctx = hubbub2_init_vm_ctx,
+	.dcc_support_swizzle = hubbub3_dcc_support_swizzle,
+	.dcc_support_pixel_format = hubbub2_dcc_support_pixel_format,
+	.get_dcc_compression_cap = hubbub3_get_dcc_compression_cap,
+	.wm_read_state = hubbub35_wm_read_state,
+	.get_dchub_ref_freq = hubbub35_get_dchub_ref_freq,
+	.program_watermarks = hubbub35_program_watermarks,
+	.allow_self_refresh_control = hubbub1_allow_self_refresh_control,
+	.is_allow_self_refresh_enabled = hubbub1_is_allow_self_refresh_enabled,
+	.verify_allow_pstate_change_high = hubbub1_verify_allow_pstate_change_high,
+	.force_wm_propagate_to_pipes = hubbub32_force_wm_propagate_to_pipes,
+	.force_pstate_change_control = hubbub3_force_pstate_change_control,
+	.init_watermarks = hubbub35_init_watermarks,
+	.program_det_size = dcn32_program_det_size,
+	.program_compbuf_size = dcn35_program_compbuf_size,
+	.init_crb = dcn35_init_crb,
+	.hubbub_read_state = hubbub2_read_state,
+	.force_usr_retraining_allow = hubbub32_force_usr_retraining_allow,
+	.dchubbub_init = hubbub35_init,
+};
+
+void hubbub35_construct(struct dcn20_hubbub *hubbub2,
+	struct dc_context *ctx,
+	const struct dcn_hubbub_registers *hubbub_regs,
+	const struct dcn_hubbub_shift *hubbub_shift,
+	const struct dcn_hubbub_mask *hubbub_mask,
+	int det_size_kb,
+	int pixel_chunk_size_kb,
+	int config_return_buffer_size_kb)
+{
+	hubbub2->base.ctx = ctx;
+	hubbub2->base.funcs = &hubbub35_funcs;
+	hubbub2->regs = hubbub_regs;
+	hubbub2->shifts = hubbub_shift;
+	hubbub2->masks = hubbub_mask;
+
+	hubbub2->debug_test_index_pstate = 0xB;
+	hubbub2->detile_buf_size = det_size_kb * 1024;
+	hubbub2->pixel_chunk_size = pixel_chunk_size_kb * 1024;
+	hubbub2->crb_size_segs = config_return_buffer_size_kb / DCN35_CRB_SEGMENT_SIZE_KB; /*todo*/
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubbub.h b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubbub.h
new file mode 100644
index 000000000000..013029f2e257
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubbub.h
@@ -0,0 +1,150 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2023 Advanced Micro Devices, Inc.
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
+ */
+
+#ifndef __DC_HUBBUB_DCN35_H__
+#define __DC_HUBBUB_DCN35_H__
+
+#include "dcn32/dcn32_hubbub.h"
+
+#define HUBBUB_REG_LIST_DCN35(id)\
+	SR(DCHUBBUB_ARB_DATA_URGENCY_WATERMARK_A),\
+	SR(DCHUBBUB_ARB_DATA_URGENCY_WATERMARK_B),\
+	SR(DCHUBBUB_ARB_DATA_URGENCY_WATERMARK_C),\
+	SR(DCHUBBUB_ARB_DATA_URGENCY_WATERMARK_D),\
+	SR(DCHUBBUB_ARB_WATERMARK_CHANGE_CNTL),\
+	SR(DCHUBBUB_ARB_DRAM_STATE_CNTL),\
+	SR(DCHUBBUB_ARB_SAT_LEVEL),\
+	SR(DCHUBBUB_ARB_DF_REQ_OUTSTAND),\
+	SR(DCHUBBUB_GLOBAL_TIMER_CNTL), \
+	SR(DCHUBBUB_TEST_DEBUG_INDEX), \
+	SR(DCHUBBUB_TEST_DEBUG_DATA),\
+	SR(DCHUBBUB_SOFT_RESET),\
+	SR(DCHUBBUB_CRC_CTRL), \
+	SR(DCN_VM_FB_LOCATION_BASE),\
+	SR(DCN_VM_FB_LOCATION_TOP),\
+	SR(DCN_VM_FB_OFFSET),\
+	SR(DCN_VM_AGP_BOT),\
+	SR(DCN_VM_AGP_TOP),\
+	SR(DCN_VM_AGP_BASE),\
+	HUBBUB_SR_WATERMARK_REG_LIST(), \
+	SR(DCHUBBUB_ARB_FRAC_URG_BW_NOM_A),\
+	SR(DCHUBBUB_ARB_FRAC_URG_BW_NOM_B),\
+	SR(DCHUBBUB_ARB_FRAC_URG_BW_NOM_C),\
+	SR(DCHUBBUB_ARB_FRAC_URG_BW_NOM_D),\
+	SR(DCHUBBUB_ARB_FRAC_URG_BW_FLIP_A),\
+	SR(DCHUBBUB_ARB_FRAC_URG_BW_FLIP_B),\
+	SR(DCHUBBUB_ARB_FRAC_URG_BW_FLIP_C),\
+	SR(DCHUBBUB_ARB_FRAC_URG_BW_FLIP_D),\
+	SR(DCHUBBUB_ARB_REFCYC_PER_TRIP_TO_MEMORY_A),\
+	SR(DCHUBBUB_ARB_REFCYC_PER_TRIP_TO_MEMORY_B),\
+	SR(DCHUBBUB_ARB_REFCYC_PER_TRIP_TO_MEMORY_C),\
+	SR(DCHUBBUB_ARB_REFCYC_PER_TRIP_TO_MEMORY_D),\
+	SR(DCHUBBUB_DET0_CTRL),\
+	SR(DCHUBBUB_DET1_CTRL),\
+	SR(DCHUBBUB_DET2_CTRL),\
+	SR(DCHUBBUB_DET3_CTRL),\
+	SR(DCHUBBUB_COMPBUF_CTRL),\
+	SR(COMPBUF_RESERVED_SPACE),\
+	SR(DCHUBBUB_DEBUG_CTRL_0),\
+	SR(DCHUBBUB_ARB_USR_RETRAINING_CNTL),\
+	SR(DCHUBBUB_ARB_USR_RETRAINING_WATERMARK_A),\
+	SR(DCHUBBUB_ARB_USR_RETRAINING_WATERMARK_B),\
+	SR(DCHUBBUB_ARB_USR_RETRAINING_WATERMARK_C),\
+	SR(DCHUBBUB_ARB_USR_RETRAINING_WATERMARK_D),\
+	SR(DCHUBBUB_ARB_UCLK_PSTATE_CHANGE_WATERMARK_A),\
+	SR(DCHUBBUB_ARB_UCLK_PSTATE_CHANGE_WATERMARK_B),\
+	SR(DCHUBBUB_ARB_UCLK_PSTATE_CHANGE_WATERMARK_C),\
+	SR(DCHUBBUB_ARB_UCLK_PSTATE_CHANGE_WATERMARK_D),\
+	SR(DCHUBBUB_ARB_FCLK_PSTATE_CHANGE_WATERMARK_A),\
+	SR(DCHUBBUB_ARB_FCLK_PSTATE_CHANGE_WATERMARK_B),\
+	SR(DCHUBBUB_ARB_FCLK_PSTATE_CHANGE_WATERMARK_C),\
+	SR(DCHUBBUB_ARB_FCLK_PSTATE_CHANGE_WATERMARK_D),\
+	SR(DCN_VM_FAULT_ADDR_MSB),\
+	SR(DCN_VM_FAULT_ADDR_LSB),\
+	SR(DCN_VM_FAULT_CNTL),\
+	SR(DCN_VM_FAULT_STATUS),\
+	SR(SDPIF_REQUEST_RATE_LIMIT),\
+	SR(DCHUBBUB_CLOCK_CNTL),\
+	SR(DCHUBBUB_SDPIF_CFG0),\
+	SR(DCHUBBUB_SDPIF_CFG1),\
+	SR(DCHUBBUB_MEM_PWR_MODE_CTRL),\
+	SR(DCHUBBUB_ARB_HOSTVM_CNTL),\
+	SR(DCHVM_CTRL0),\
+	SR(DCHVM_MEM_CTRL),\
+	SR(DCHVM_CLK_CTRL),\
+	SR(DCHVM_RIOMMU_CTRL0),\
+	SR(DCHVM_RIOMMU_STAT0),\
+	SR(DCHUBBUB_COMPBUF_CTRL),\
+	SR(COMPBUF_RESERVED_SPACE),\
+	SR(DCHUBBUB_DEBUG_CTRL_0),\
+	SR(DCHUBBUB_CLOCK_CNTL),\
+	SR(DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_Z8_A),\
+	SR(DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_A),\
+	SR(DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_Z8_B),\
+	SR(DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_B),\
+	SR(DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_Z8_C),\
+	SR(DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_C),\
+	SR(DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_Z8_D),\
+	SR(DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_D)
+
+#define HUBBUB_MASK_SH_LIST_DCN35(mask_sh)\
+	HUBBUB_MASK_SH_LIST_DCN32(mask_sh), \
+	HUBBUB_SF(DCHVM_CTRL0, HOSTVM_INIT_REQ, mask_sh),\
+	HUBBUB_SF(DCHVM_MEM_CTRL, HVM_GPUVMRET_PWR_REQ_DIS, mask_sh),\
+	HUBBUB_SF(DCHVM_MEM_CTRL, HVM_GPUVMRET_FORCE_REQ, mask_sh),\
+	HUBBUB_SF(DCHVM_MEM_CTRL, HVM_GPUVMRET_POWER_STATUS, mask_sh),\
+	HUBBUB_SF(DCHVM_CLK_CTRL, HVM_DISPCLK_R_GATE_DIS, mask_sh),\
+	HUBBUB_SF(DCHVM_CLK_CTRL, HVM_DISPCLK_G_GATE_DIS, mask_sh),\
+	HUBBUB_SF(DCHVM_CLK_CTRL, HVM_DCFCLK_R_GATE_DIS, mask_sh),\
+	HUBBUB_SF(DCHVM_CLK_CTRL, HVM_DCFCLK_G_GATE_DIS, mask_sh),\
+	HUBBUB_SF(DCHVM_CLK_CTRL, TR_REQ_REQCLKREQ_MODE, mask_sh),\
+	HUBBUB_SF(DCHVM_CLK_CTRL, TW_RSP_COMPCLKREQ_MODE, mask_sh),\
+	HUBBUB_SF(DCHVM_RIOMMU_CTRL0, HOSTVM_PREFETCH_REQ, mask_sh),\
+	HUBBUB_SF(DCHVM_RIOMMU_CTRL0, HOSTVM_POWERSTATUS, mask_sh),\
+	HUBBUB_SF(DCHVM_RIOMMU_STAT0, RIOMMU_ACTIVE, mask_sh),\
+	HUBBUB_SF(DCHVM_RIOMMU_STAT0, HOSTVM_PREFETCH_DONE, mask_sh),\
+	HUBBUB_SF(DCHUBBUB_COMPBUF_CTRL, COMPBUF_SIZE, mask_sh),\
+	HUBBUB_SF(DCHUBBUB_COMPBUF_CTRL, COMPBUF_SIZE_CURRENT, mask_sh),\
+	HUBBUB_SF(DCHUBBUB_COMPBUF_CTRL, CONFIG_ERROR, mask_sh),\
+	HUBBUB_SF(COMPBUF_RESERVED_SPACE, COMPBUF_RESERVED_SPACE_64B, mask_sh),\
+	HUBBUB_SF(COMPBUF_RESERVED_SPACE, COMPBUF_RESERVED_SPACE_ZS, mask_sh),\
+	HUBBUB_SF(DCHUBBUB_CLOCK_CNTL, DCHUBBUB_FGCG_REP_DIS, mask_sh),\
+	HUBBUB_SF(DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_Z8_A, DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_Z8_A, mask_sh), \
+	HUBBUB_SF(DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_Z8_B, DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_Z8_B, mask_sh), \
+	HUBBUB_SF(DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_Z8_C, DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_Z8_C, mask_sh), \
+	HUBBUB_SF(DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_Z8_D, DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_Z8_D, mask_sh), \
+	HUBBUB_SF(DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_A, DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_A, mask_sh), \
+	HUBBUB_SF(DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_B, DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_B, mask_sh), \
+	HUBBUB_SF(DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_C, DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_C, mask_sh), \
+	HUBBUB_SF(DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_D, DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_D, mask_sh)
+
+void hubbub35_construct(struct dcn20_hubbub *hubbub2,
+	struct dc_context *ctx,
+	const struct dcn_hubbub_registers *hubbub_regs,
+	const struct dcn_hubbub_shift *hubbub_shift,
+	const struct dcn_hubbub_mask *hubbub_mask,
+	int det_size_kb,
+	int pixel_chunk_size_kb,
+	int config_return_buffer_size_kb);
+#endif
-- 
2.41.0

