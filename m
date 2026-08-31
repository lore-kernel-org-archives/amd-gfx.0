Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38B30C61DD3
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:29:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 779D710EA92;
	Mon, 31 Aug 2026 18:29:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2Rgy2TjT";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013019.outbound.protection.outlook.com
 [40.93.201.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70C8310EA91
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:29:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BcZnrLKFFOW9pZa2/bf0/Pdws0wDY30N+ohFqgJ3fj2wXt2AgbpLB4rsB0+G6KWCPd0hMJ5byzdezwSjU7hZgEqb8cT1up7wmP5Z5YZ59P0V6pFBiV1x78JRdve/jYUyiu2FZZD5unBoxhS395EnFLXOqTbTOzNlb+c36SSZRzkdREQfs4i36UyTInD6UfivKjXOiWWc7ZpbovAnJgU0c+EqGOh12LidWKAODs63sWHat8WEIjeY+qEBpEdQuIWVsCVJQiSBLj1NycxqCL33NBh02mk497Fj9i31Il034UNblOZMFA3nBR1mqtgT03GjUCM8L0HPeqVsVMb0bq7Odw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tgYy3Prys3wafqGpjMC5GK4Q/oJXwF5BAcOvJm3Spnw=;
 b=WQ4TrP4ZAVHnheSDEfXzqONANz51gor6bcdAiU+HWzTnygiH0B4TrH00QtXts+ig0kPj7Nsl8sphwzyghHXfyVOhVcdYdSrjSNM5WudMZwY90VnmFQTUannZMznHspWrfZG94c6qrtOphYn+0CLyGTEczrie8EgjmmzPugaNg83hkiTTOiKmZeUu48vQ2ztCmdS66YZFq8XQdoGoAtnK48j3nNk32zQN+LlGFkUbcPzG5ZVbGEzrvf4HlP2jmGEQSEuy68HASaeJ6k2q3VmfYNE14hhLwvun2hvOEe8XY0hwqUP8xOwT09X8nCb9OOBnGJchNAhiQjs7HrOpMAHPqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgYy3Prys3wafqGpjMC5GK4Q/oJXwF5BAcOvJm3Spnw=;
 b=2Rgy2TjTtozDrRPCT06jMLsVxnbsHkpRR7rh90SZGNq+00lTM7dwSz8d/Z28yEqwVror+A0w+YlLCqdy7lk0A18s8M6/7XLMBJNUQfz0hnGs/NatH1O0748twEhugwHLB2ensUV0G7MaWYLEf4Y5eiBFzQcLOXoxpyAIUVq+n+w=
Received: from BN0PR04CA0070.namprd04.prod.outlook.com (2603:10b6:408:ea::15)
 by PH7PR12MB9221.namprd12.prod.outlook.com (2603:10b6:510:2e8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:29:15 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:408:ea:cafe::61) by BN0PR04CA0070.outlook.office365.com
 (2603:10b6:408:ea::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:29:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:29:12 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:29:05 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:29:05 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:29:04 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 92/95] drm/amdgpu: Handle concurrent UALINK handle import race
Date: Mon, 31 Aug 2026 14:27:51 -0400
Message-ID: <20260831182754.1089811-93-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|PH7PR12MB9221:EE_
X-MS-Office365-Filtering-Correlation-Id: ee2c5571-2d0f-4c69-c985-08df078dc164
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|23010399003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: WDJulwAf8R3bJvalyTKr4ReTNDW62JijmHtpCC3L3CBPu93KCVgZUy/nFKwuu08qMZaDT7MflBIHtPHyQ09yZu2qdSDlWdvH0a+TabbVzL8Xj7hzrBNmdHGnS3V/NuyWKgbz53jxzecPejvYFDoxeBhjGlil6ErVhKdO9pnoWbVxOzlxM5tBBmWgm3AdqMpVGjG0diwBSfw3f8wgqByTk0myHNmy4/4dgu3IwacT+7kCXHsm9t0pPTB1AbJaTdWH011yUBAN2uycmE5FV5rM8dgyiDT2thRlCEzA+YauR2kk3A9mhzJ4PA14k8tnhKW2D4EpDghnGSEmXPU1nIGxM01EqF4sKrlFWQQqQXNtYVXzq1wuy0lKIGGtvtUbUghvzar5ZXoPLs0isgKougDMWaHcdrkuGsbNj/vfpK0PFDFsjdv8irRqKZdz3ehc0LIiIdf1Wqt2OFAoJyjx6KSCNCgUEpGBbKhV/Coi19z93s+/qxMupC7NVgV4H5N63FwSsP0q5vmPmia+OqWWFsWzL2NSUgN4758UUFiEjP/SVX9mBeW0Oujko+O86GnDiMfoDfjxByBUjBcmHOgpjnMlxO+6qFnMIm5Ke8h+HMSIhpU1Afe3OnC3aN1XClbm8g5iyDT8H7ywF6KHXPYYOaERCzLPV6eWyqaPnXrnHhkPa6I4hM50aLW9L1bxZUaPv1R8i6NC2bcsGcIDSKAOJJm/zg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(23010399003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: v7SaEZ0cghCyZSq7xj2EGZoqiCwHLVIWZWjLBmQM2iMplR24rhs3zm0UtCnvCZunKFTA7zWwZr8EY6VA543HGo+a1NKTnzaiEumPkXTkQvvI4/ADEaqXCluah9ZWoKf1Hqxdm3lO9uVZSHAiuVxRZOzT8cT5x0mRkwCYdA460jPTFGDhbq6QQ8CM6PK0X654FGtUb6xA9B5xw8kN43WoiyjBeLRqBi4lBe8bwSBrHminDjizuAKYMAGN2WInPoPyw60Hn0h8dLnt02aaLXre0PydF/TPZaGfNOrwmT/DE1CvcayJZoWlnBRzKGNwd6+RMjDvrmE1VQ/GVERFNRtlS7gyCE5H4SvQnbY/+SvQUiWi5CBBDkiI+XtrFrdJnQszTl01VsvAqBCFvsuPUvEcHf8CLNt32GGpagYKrmVbRweGsq8r0IeBwLZ4GTnazRxP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:29:12.5855 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee2c5571-2d0f-4c69-c985-08df078dc164
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9221
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

From: Mukul Joshi <mukul.joshi@amd.com>

When two threads import the same UALINK handle concurrently, the first
xa_insert() succeeds and the second gets -EBUSY. Convert -EBUSY to
-EAGAIN so user-space retries instead of seeing a spurious error.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index a5dc6a13970f2..68c156c1d281b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -3852,9 +3852,15 @@ int amdgpu_ualink_import_handle(struct drm_device *dev,
 			      imp_xa_node, GFP_KERNEL);
 		if (r) {
 			kfree(imp_xa_node);
-			dev_err(adev->dev,
-				"IMPORT: XA insert failed for handle:%llx:%llx err:%d\n",
-				handle.handle_hi, handle.handle_lo, r);
+			/* -EBUSY means another thread raced us and inserted a
+			 * node for the same handle. Ask user-space to retry.
+			 */
+			if (r == -EBUSY)
+				r = -EAGAIN;
+			else
+				dev_err(adev->dev,
+					"IMPORT: XA insert failed for handle:%llx:%llx err:%d\n",
+					handle.handle_hi, handle.handle_lo, r);
 			goto out;
 		}
 
-- 
2.55.0

