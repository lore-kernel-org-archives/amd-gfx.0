Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3389CD8CA8
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jun 2026 10:44:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A8E110F430;
	Fri, 12 Jun 2026 10:44:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uhysDhuZ";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010061.outbound.protection.outlook.com [52.101.201.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6194F10F420
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 10:44:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CnACx8BqS/TT6zUVxcpLlYWuUtBM71oK3OzqE9JiO3XssKwHpbp4QsNYJGWYKKBCam5o6komLgIQN//ilyJTlGS8gweDrWaW+XNolXuqQy5YGO8LkwK9b/RC/4XGpAOXfwt3dum00gbSY0FEnyRoV7/hs3Gx1PkhBG5u1fBD46EJYtvRQZLwXEHTznXU776jJPt0D6C5JYi+wWDy19KOtwn9Fai+2TSc0uMVK7kJ+WVTJOyzic3nX6XlzOFCAv1pb345eptQuL/+zIVjZwUPs2XsmT8oqXs2XWqSUjA1Nre6aMcl1JJpERjmdM7zSamPRuJ34liRT+z7/3qGtLTYZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yhvhyOVg/s4iN2WzaJGLhLEJkWsLDH2eKAeRcTykKhQ=;
 b=It02Fu3E+bVQWxdzxpuIJ6C/TvMMD2Sf8nVStJLkmyyEmbjyExK1tNl0GaXt1/XpKgXV4u/lVaqz4N0myNCvw4fHiKmctOkREH4x3EYhwuq0EIcxz2j7ItLkb2ZaDIZLcVfPRLtoiVFYMIlXtBoDcTQloOiRT1xXmUNl/KjTyNw7eE9judmJsNNeIWZnyURkdP7HN2pNnuIQpIqjCalZN28OwG9okGzrkpMceDSl3Tx3ZS4+I66NX8+iU9rk1eRYCDR212lEBTq5YZ2sWGZcx07x92s/XKbrvco5kiOs5aNrHWoPqdqh2QO4qkr7fxr63yCTph7QMx+OwWfLF8qo/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yhvhyOVg/s4iN2WzaJGLhLEJkWsLDH2eKAeRcTykKhQ=;
 b=uhysDhuZ1kWytmVdLPpxYm/9elG/aHbe12PzrThzCMmDd+jdTrmw0ER2UI36TulQE93HAo8x2jytO+ST3p4zxpKe49IiG58PVHDr4dErSlPv2VDxPGLzBCRsrPUeYrbe8k0EFpt25+lJnfGPMJzimIYy57vDSl35VDUt+DUlfh8=
Received: from BN9P222CA0006.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::11)
 by DS0PR12MB7584.namprd12.prod.outlook.com (2603:10b6:8:13b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 10:44:34 +0000
Received: from BN2PEPF000044A0.namprd02.prod.outlook.com
 (2603:10b6:408:10c:cafe::5f) by BN9P222CA0006.outlook.office365.com
 (2603:10b6:408:10c::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.14 via Frontend Transport; Fri,
 12 Jun 2026 10:44:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A0.mail.protection.outlook.com (10.167.243.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Fri, 12 Jun 2026 10:44:33 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 12 Jun
 2026 05:44:33 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 12 Jun
 2026 05:44:32 -0500
Received: from rtg-MAPLE.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 12 Jun 2026 05:44:25 -0500
From: Priya Hosur <Priya.Hosur@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Lijo.Lazar@amd.com>,
 <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Mario.Limonciello@amd.com>, <Kenneth.Feng@amd.com>
CC: <Pratik.Vishwakarma@amd.com>, <Veerabadhran.Gopalakrishnan@amd.com>,
 <Priya.Hosur@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH v4 4/4] drm/amd/pm: smu_v14_0_0: add closest-match fallback
 for DPM level marking
Date: Fri, 12 Jun 2026 16:14:08 +0530
Message-ID: <20260612104408.9596-5-Priya.Hosur@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260612104408.9596-1-Priya.Hosur@amd.com>
References: <20260612104408.9596-1-Priya.Hosur@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A0:EE_|DS0PR12MB7584:EE_
X-MS-Office365-Filtering-Correlation-Id: b299fd6d-303f-43fb-6863-08dec86f971e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|23010399003|18002099003|22082099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: AJObUelNl85ECOn8E028likfqBmFIdaxiPatat5+3Pra0rBYEiWF06xXGo7gLdE9paJjcx7pOzRYkVfb5gmNY/yrWkaD+0PFK5yf57yZRXE/nvvTkh2RJanm3YlBLg/iBiuyZod/A7poPgz2rGssODGIt1kDpuLnLPA6+YAQmUmdrhH1vx4YyariF0M78RpFRKk5AaNHKecjnpX0dQ2oUB2F5uydgwY16Wv5NqlP7wVLmht5n1K3xPIG4K4TnM+rXmHHiKLZt7wNbvgbMP5kAbZVwJkZ4MygtM6N9M5O2hPrWMZGOOjxezDMDgcxGLxQX1OZ2KiujO3p59tYcKJZpBgLCRvAXftOgrf8OQwSje3k7bbKGnLHXVpX52mABuBvIi0XVpJHYW+7WtuAel4nPXlvdNisavWtvX2FoiTxnuWdGIt1A+mLhOrpN0PyTN/Bvo/cFl+nTuTsnH566FJZVUZaqku9MzjI9Ep1ZvF8mncJonw2WmSg5PcrNLl02jMhEn2nNWf19VqzPJ5OOqwvej4NDhJMZCvriirL27v+BalgrjAcZMo86XJ3W7nCTcddM6NEnwdjBxgFWDtWOW6MvqCMXZsXwFA02rH+qIlDwdTPtPA3DBu+N7L4RRtwtv4k7fEPPbsAcKcAUPFJPYvUemvGPYIuMXL26Y6EldopnBsdF21sIucMvyvG8WqIJSYxbVJMLRswF6jsspW/NZugj6dxvRXZFT8v7qhQO73v8+o=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(23010399003)(18002099003)(22082099003)(6133799003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tuKy7kndwLwqSQB4w01J21vHdGJtRylbcL/SJlGPyZP2ipPP3jR9CO709JejDo2SX80LusU0+GtlAswVnVfJfeEI/OLzH2D42OKcLYStm16EoI/PUX1xnPNrtnqz38mf5CBufzzSYMivn3oyaFcxSkPWVImZxjC1q6ntqlggXBltuu7VzzEWB1l6E5I9CzboFi6hkCCX2WBf2PTlU/ODv9oMZvNOlInOF62C2Ona1nXqW4To/nfg1ZTs5B7Z72rigoWagyDAjh59NCa6NjVaJ7aF436J9aBEWc6b+P/yrFdgXM2gDu9V/VJv0QvCk15KkuUjG8dSupwvJo4k2xehazqgHXbyrsH+OCJoyEE77aGQio4i83J/i5SHnZ37wyCH6zIk2mfGEgAjOVrsqKVElUT708Ta+5RpgoD9Q8SnfRJujMRuSV3KAK+8Eh2Gr0ml
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 10:44:33.5031 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b299fd6d-303f-43fb-6863-08dec86f971e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7584
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

Replace the simple exact-match loop in emit_clk_levels with a
two-pass approach: the first pass checks whether the current
frequency matches any DPM level exactly and also tracks the closest
level by absolute frequency difference. The second pass emits the
levels, marking the exact match if found, otherwise the closest
level.

The SMU reports time-filtered average frequencies that often do not
match any DPM table entry exactly. Without this fallback, MCLK,
FCLK and other clocks show DPM levels but never display the *
marker, breaking userspace tools that rely on it to identify the
active frequency.

Also uses reverse DPM index for SMU_MCLK since MemPstateTable
stores levels high-to-low.

Signed-off-by: Priya Hosur <Priya.Hosur@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  | 46 ++++++++++++++++---
 1 file changed, 39 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
index 206bfa906ad6..45b0baeb194c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
@@ -1218,14 +1218,46 @@ static int smu_v14_0_0_emit_clk_levels(struct smu_context *smu,
 		if (ret)
 			return ret;
 
-		for (i = 0; i < count; i++) {
-			idx = (clk_type == SMU_MCLK) ? (count - i - 1) : i;
-			ret = smu_v14_0_common_get_dpm_freq_by_index(smu, clk_type, idx, &value);
-			if (ret)
-				return ret;
+		/*
+		 * Try exact match first. If the SMU reports a time-averaged
+		 * frequency that doesn't match any DPM level exactly, fall
+		 * back to marking the closest DPM level.
+		 */
+		{
+			int closest_idx = 0;
+			uint32_t closest_diff = U32_MAX;
+			uint32_t diff;
+
+			for (i = 0; i < count; i++) {
+				idx = (clk_type == SMU_MCLK) ? (count - i - 1) : i;
+				ret = smu_v14_0_common_get_dpm_freq_by_index(smu, clk_type, idx, &value);
+				if (ret)
+					return ret;
+
+				if (cur_value == value) {
+					closest_idx = i;
+					break;
+				}
 
-			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i, value,
-					      cur_value == value ? "*" : "");
+				diff = abs((int)cur_value - (int)value);
+				if (diff < closest_diff) {
+					closest_diff = diff;
+					closest_idx = i;
+				} else if (diff > closest_diff) {
+					break;
+				}
+			}
+
+			for (i = 0; i < count; i++) {
+				idx = (clk_type == SMU_MCLK) ? (count - i - 1) : i;
+				ret = smu_v14_0_common_get_dpm_freq_by_index(smu, clk_type, idx, &value);
+				if (ret)
+					return ret;
+
+				size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
+						      i, value,
+						      i == closest_idx ? "*" : "");
+			}
 		}
 		break;
 	case SMU_DCEFCLK:
-- 
2.43.0

