Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D4CC982F0
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 20:10:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21FDB10EA8D;
	Mon, 21 Sep 2026 20:10:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XEq193pS";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011031.outbound.protection.outlook.com [40.107.208.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 029AF10EA8D
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 20:10:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AMjfiYAmy4kBaqb1DsXZJRD9U9WJ1pEApU0n7LkI2s+i9HiKJfdZ4K7Mlwa9C8WyX27xNFGeKdZa2ay/V7281HcuZAn8UweVc8rLPFm5AK6XI8j7b6Tx+YQeWNQ6nEZcdOPQVjZBieJX6erhEmF6OEXB2sKPTuJ3N7Gv1VCxSu746sW+Hsb1AFO4DMBYG1XfUnEr9/7jUbhFtWqeREcNSvK6MXAz+i2BqJW6wcpcHSL0aG9OhnUs8L7syXuSt/ERvyG6d2DdbQYVDBXWjrQ6lWEMGT8uBED7UxVmTU0lR57ogmLFCBPG2KpcQ+E5JUHAQPeQWP5OG8GurqstUXavuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/rNl8Si6SjU8WCY7rFCVE6z44v1dm7Z8csUzJjs0at8=;
 b=G2PyW+Je4bdzIBEgISFgsDsYrCDNLoAfC3KJfRmFWnskjiP+4GzDkHiVXfT4oGztl6VDhB6MLw6N7zAqVlkSHlr48UKjVIptUq/bnHJ95OmHsaGjb0b/BeTJUbFsDhRSjqR9ibIWG4dEHUpY+HebVUZOShiUNCNLhRLnKV6bYN3RCK5FuXfBv48eNWFx9YvFHozovo5534UAjX4hlmU7yPxalEe2VM5c8mONhUw9C8pUn88UmlPe0a3B5HA3yJDpSHQd7onlGiREO1g4aeAtXLYa4NiyPIx20uIfckHs24RwYEoVyyX6pKvPFtUSohL6sOVXwa05b927g2CO0X/meQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rNl8Si6SjU8WCY7rFCVE6z44v1dm7Z8csUzJjs0at8=;
 b=XEq193pSMBskBW1jHEE6WCI+OypqkvPw6QIT1tuSJEBOn5ZG4JiyxDr/4XvB+VWmphbkKN6122kKghBsHw/rzlARTwLTZPHiY0yo0v3Tmf22ScshfVFqhmN7KCM5h06TPjtBlqbFdB0MgWmj/8Is3gZ46zkluo6/V/FUm1/CcBQ=
Received: from BN9PR03CA0187.namprd03.prod.outlook.com (2603:10b6:408:f9::12)
 by LV3PR12MB9402.namprd12.prod.outlook.com (2603:10b6:408:213::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 20:10:43 +0000
Received: from BN3PEPF00022BD8.namprd03.prod.outlook.com
 (2603:10b6:408:f9:cafe::77) by BN9PR03CA0187.outlook.office365.com
 (2603:10b6:408:f9::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 20:10:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BD8.mail.protection.outlook.com (10.167.248.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 20:10:43 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 15:10:42 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 21 Sep 2026 15:10:42 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Frank Min <Frank.Min@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Add soc v2_0 ih client id table
Date: Mon, 21 Sep 2026 16:10:26 -0400
Message-ID: <20260921201026.2019083-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921201026.2019083-1-alexander.deucher@amd.com>
References: <20260921201026.2019083-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BD8:EE_|LV3PR12MB9402:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e4a5422-f9e6-40c4-2b8f-08df181c6ac0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|23010399003|36860700016|1800799024|22082099003|18002099003|11063799006|56012099006|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info: Kyp1LBMw+nKjzsgP4Rp6tbQNJl9vIP8fm/ADZZUekWujPfpOvXliRExjrEt7bCqz8TdjbPiHREanESfsDzGyuYGjgiQIot+jD8WH3WKCn/TbqsW5g3J6rPj1w3HB1Fnzq/m3iGd+3IoaPVIHyVxd4h0JoX6KXhB2WzRybzB+ZrbddnacB3RAyqe7waOrmQhU9rC7w7ePNYeuY8BRsC/F+oHNyCcL1nDgVYesGqU8GjaQL9Wlsye1lBMA08kgVfzqc+6Hoj2o5otpiXBXv3T1Al1T2m7KzbmwMMGG+4ka3dGE5YP4APdy33CZSXje2MAgpvitp2Ha299o+CEgAiqu5I7RK5ahsjCMWXqIo04WJAAvlCKGhA5vAn2dCAH0KEk9gQokHQstsUVvdZCQQMV/wGgsCyzf71vCYRV1YSfdVbAgjeaN6sFmrtRE3Mvr6vgPORAZie0aBXt1QBhnUQaYR8ffk4Cm06wlz2SoWgTs3ev3h+M0qeHfXfqNOb9RquCsEfdcTk22r35EF9PMDcKYTlX194SVbuKoqLhib5kwlnVbZC1bTGb1XRSFUxtLNgU4oXGD3odaUN14Yqo/y0QY6EMisMaW8ulM26aMGU5yWBvxINA2QlKFWamrRtl7Wq0hF607MFw27tEvxg325I88M1rsQ4feDJYk4G9pO+FbSdmxSXwouDtdfDI/jKiuoJT4It5+6pp14spbyFYNKNMYOQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(23010399003)(36860700016)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8rz5021hA1NDxFNjmTGSZbSARQ1u3wXU8uQkx55OOjZ4baTxmYDcLYUpQUo61Eozo1Ap+TFw1uJe7djTl1E/OrdllfEmWzxuY86XltT6QZFtwmbiTjDjcuJ9wz+Lz03hMfPskDAvk656lc6MRuRtW2SmkQgSRUtvCFgekA8TWwqJas8LY/rfNJ/9m8qa6cXdJ/+Q7qkF+GQzMUy9y2LQoFo0jrXQj74FMI/K7fQqfb4nkK3QNrW1ofxc5SqXE47//tVv2YBtYLORQ5dwh/uR5FnB1ZdPrxmITeRaawgCoyXyn1oYGSg5KXydsakCKAI+QiqCKr0/5ATrAgizkAKN3vmx5qd+34529MGmVAIqEyIR6sBSbqhvM4FVqEPu49uUxPcRV7/ruYx5BJPnX1pZS0otRacFXUPCsS9DVgmrCPqRTw0aNDTTUGQSnOp2Brh6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 20:10:43.8596 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e4a5422-f9e6-40c4-2b8f-08df181c6ac0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BD8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9402
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

To acommandate the specific ih client for soc v2_0

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Frank Min <Frank.Min@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c       | 35 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h       |  1 +
 .../drm/amd/include/soc_v2_0_ih_clientid.h    | 51 +++++++++++++++++++
 3 files changed, 87 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/include/soc_v2_0_ih_clientid.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index dcf90a974326d..03219ee894a28 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -134,6 +134,41 @@ const char *soc_v1_0_ih_clientid_name[] = {
 	"MP1",
 };
 
+const char *soc_v2_0_ih_clientid_name[] = {
+	"IH",
+	"Reserved",
+	"ATHUB",
+	"BIF",
+	"DCN",
+	"Reserved",
+	"Reserved",
+	"RLC",
+	"Reserved",
+	"Reserved",
+	"GFX",
+	"IMU",
+	"NVE",
+	"Reserved",
+	"Reserved",
+	"THM",
+	"UMSCH_VCN",
+	"Reserved",
+	"VMC",
+	"Reserved",
+	"GRBM_CP",
+	"Reserved",
+	"Reserved",
+	"DF",
+	"VPE",
+	"SMUIO",
+	"Reserved",
+	"GC_UTCL2",
+	"Reserved",
+	"Reserved",
+	"MPASP",
+	"MP1",
+};
+
 const int node_id_to_phys_map[NODEID_MAX] = {
 	[AID0_NODEID] = 0,
 	[XCD0_NODEID] = 0,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
index c88431471c303..5458ec3af19d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
@@ -27,6 +27,7 @@
 #include <linux/irqdomain.h>
 #include "soc15_ih_clientid.h"
 #include "soc_v1_0_ih_clientid.h"
+#include "soc_v2_0_ih_clientid.h"
 #include "amdgpu_ih.h"
 
 #define AMDGPU_MAX_IRQ_SRC_ID		0x100
diff --git a/drivers/gpu/drm/amd/include/soc_v2_0_ih_clientid.h b/drivers/gpu/drm/amd/include/soc_v2_0_ih_clientid.h
new file mode 100644
index 0000000000000..eb24e76a666f3
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/soc_v2_0_ih_clientid.h
@@ -0,0 +1,51 @@
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
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
+#ifndef __SOC_V2_0_IH_CLIENTID_H__
+#define __SOC_V2_0_IH_CLIENTID_H__
+
+extern const char *soc_v2_0_ih_clientid_name[];
+
+enum soc_v2_0_ih_clientid {
+	SOC_V2_0_IH_CLIENTID_IH 		= 0x00,
+	SOC_V2_0_IH_CLIENTID_ATHUB 		= 0x02,
+	SOC_V2_0_IH_CLIENTID_BIF		= 0x03,
+	SOC_V2_0_IH_CLIENTID_DCN		= 0x04,
+	SOC_V2_0_IH_CLIENTID_RLC		= 0x07,
+	SOC_V2_0_IH_CLIENTID_GFX		= 0x0a,
+	SOC_V2_0_IH_CLIENTID_IMU		= 0x0b,
+	SOC_v2_1_IH_CLIENTID_NVE 		= 0x0c,
+	SOC_V2_0_IH_CLIENTID_THM		= 0x0f,
+	SOC_V2_0_IH_CLIENTID_UMSCH_VCN 		= 0x10,
+	SOC_V2_0_IH_CLIENTID_VMC		= 0x12,
+	SOC_V2_0_IH_CLIENTID_GRBM_CP 		= 0x14,
+	SOC_V2_0_IH_CLIENTID_DF 		= 0x17,
+	SOC_V2_0_IH_CLIENTID_VPE		= 0x18,
+	SOC_V2_0_IH_CLIENTID_SMUIO 		= 0x19,
+	SOC_V2_0_IH_CLIENTID_GC_UTCL2 		= 0x1b,
+	SOC_V2_0_IH_CLIENTID_MPASP 		= 0x1e,
+	SOC_V2_0_IH_CLIENTID_MP1 		= 0x1f,
+	SOC_V2_0_IH_CLIENTID_MAX,
+};
+
+#endif
-- 
2.55.0

