Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B937FCB61E
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 15:40:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F02BC10ED64;
	Fri,  6 Mar 2026 15:40:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3nQffeyY";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010063.outbound.protection.outlook.com [52.101.56.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A82B310ED61
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 15:40:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YcVQyiSz/SIvGRgNitpXwf907y1SKP/6wDHLkmqTZWjrBMm8fbUA96QDfnwoY8rS+7s3UZqXt0Uohe3eCAo/tceKsqf2ILR/irDi7kt5sPx24MxRRTNHEwfRDG2nKxa+8SGEXltBlnKGf4APymZlaQGHETHqgiTOyP+D24MNxBLbl8yYksuN81ftKBee7xOJ+R7K6VsEWfS5bxxewSEdiNmA7zNn/QsUrjppfwP3v978NGZVYHPGYXriXETDcCefJ4Rlvk3P1dcertIZfheAnwkgftcIY7m8R0nF78PhI8Z7uP8lRIwdapy7per7pWSFzLgcuZqLJETpv7fbZu2cRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1aG6AqWKMxayn4Z2lRH3EcYirFdGCd1GFFWtwR5KODI=;
 b=h17WdVcTK55OMz/mWR/GgcuDFv+9kPliTXiBpN8XnymlIuzr7kCapZbUzInCR+RjCuvWHpFBVpH91iq8uxveINoKQkYMHA5tXWImqZtJam3DCDsU3/Gw0RyqfpDPUHfT1SXKROMQa8z2HjdC7swBNo7m58t7kVxYsqVtZ1FaoNgY6DNFnCjEIYAhRzm/llio6EECBmaiNbT6TenmJInPejL40xXidCf1DAUNYBVCbAhJPpoAHfXJb0uwBxYWlVtNNjXtjmREerkVa0zpgcFUzd4QWsevuxbvBTF4IwZ3PTiXTfHRjXfPXBglXs89yP1Ygg33GHfsft7+2Cskqx7gww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1aG6AqWKMxayn4Z2lRH3EcYirFdGCd1GFFWtwR5KODI=;
 b=3nQffeyY2zxKVBJIReHrPDSzAuoK6gJiyjz587619xyOKdne8dhgwJqoBY1dsKS8VKGkTt9bpGi8DrGDw1cwDB1GEfTZ7dYPg9r7s5o4jYzGNNo8uA0fXdcvKPQGbLop4DpxkrJFWm+gxrfp8ArnDAFkhU43BBODcaDkqKjmW44=
Received: from BN9PR03CA0885.namprd03.prod.outlook.com (2603:10b6:408:13c::20)
 by DS5PPF7B9F1F8E0.namprd12.prod.outlook.com (2603:10b6:f:fc00::656)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Fri, 6 Mar
 2026 15:40:21 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:408:13c:cafe::a6) by BN9PR03CA0885.outlook.office365.com
 (2603:10b6:408:13c::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.23 via Frontend Transport; Fri,
 6 Mar 2026 15:40:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 15:40:20 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Mar
 2026 09:40:20 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Mar
 2026 07:40:19 -0800
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 6 Mar 2026 09:40:19 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Handle IH v7_1 reg offset differences
Date: Fri, 6 Mar 2026 10:40:01 -0500
Message-ID: <20260306154012.22525-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260306154012.22525-1-alexander.deucher@amd.com>
References: <20260306154012.22525-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|DS5PPF7B9F1F8E0:EE_
X-MS-Office365-Filtering-Correlation-Id: 9df2bf1e-510d-48da-b9bf-08de7b96acc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016; 
X-Microsoft-Antispam-Message-Info: tybXHpPdv3wccavU9tYyTRVRywVsDPLWkgkbJyREDHE/E5s2xBltebAaSyKi4RjE/JfEjQf+IZKb2I3LBqJ+BE3FsS4/2AVzxzANj/vcyPd3Hi2DaxxJRNojgbKKUd5QIQEF/5N3eoQNo8IsZABvI23eiJLbA6jkGl3lFtlImJgX6jm6llEGJx27oepBQn2VKqC1f04efCmCOW9+civ1VDk2cO02yAQHYMjl+83I/gs5kX60awf8E5sofdeIZw5xDQzgWMMAHqmDS11h+P+gDveqGNy5Kl4NOe7XQ8zrJzl9JegdQ4JiUi2ei8mxkNnFqjSTeQWdx3Brrv0ZWOzPpJHjSm7FMAXHWum4EvTt32GSRuS3i0JiLBzTrPe7KmSwl7bF/qED15a1O1n3a0dc2R2owezKbfBEQzFgtzRvjzSCEoy/G0m5/vX0AVcg13oUNFJcjkBRgy4oQ1F2ZPPj3uRseO4KqvDWsZgTZVDVMjPdvGOFt5Z21L94i1U4GjG5jJRlRfCJ2GW9Rvy84TKPL3cZIBijYRjnzmZ5ZgEIRk6L+eQhJuBSuowXf7QB/+kwBbJaZMtNPK8kOPmzbaBXiKkVlGnsP+OKum6OFfI6oMzqOGIIXQNv+E/RtsAYxW9aGxSvUlPB/yh//O7d1Rgy8h3s/Qg5jiEunIjIThKEOKo+x0RCH8Jmx0K0PIetvPnoHAbrCA18G9lU3bLnBHTAvj3OxNI0X265+xWiV6wTsHi/7CV6yY6PxkTQjss7TkZGGNvsVvt3AkHscX06N7o6aA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +Dcp0cS5VGu9RnHuJXhlsHBXBu8Wuc2iV6tujLmrebKFigSRKaikLdVURgIj6fmQLHqabHO52X/NjOYb+z8RpOHGrWBe+jiumExNrrtm5xmW1H1NW8fk1prOeEyk+b+hS3/M6H0cbaeTUS0fwsNlUV7t7HZcOHQTj3cqOmknxqjgzkJa/RXMX9OwNiR6Qz1tFKGPczdAPTu1SvkHiZKSNkC8/K7l6OG6ChSzvBdXH4bnnoDOO2Zv2zkMW8p20o9FMkNecgaxgly2MmuQ7xzSC2D9ixn3fHtER8wxBkbMtUrK4ImhV2BXwt0VMkQlybRjoqMTaAhUpQ2lhnUyRRfO4nfk2L+FC7xxsnN0VOBN2x3tSz22aS0qTEKsvTZVQyh2sKmLSBGgyO+ANM9UAIUOHh3a9KiTnYudwBpHK4dAtB8wOttXL0750t2nJLnQVsm6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 15:40:20.6700 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9df2bf1e-510d-48da-b9bf-08de7b96acc5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF7B9F1F8E0
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

IH v7_1 changes the offsets of some registers relative to
IH v7_0. Introduce IH v7_1-specific register access

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/ih_v7_0.c | 36 ++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
index 451828bf583e4..1fbe904f4223b 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
@@ -289,6 +289,13 @@ static uint32_t ih_v7_0_setup_retry_doorbell(u32 doorbell_index)
 	return val;
 }
 
+#define regIH_RING1_CLIENT_CFG_INDEX_V7_1             0x122
+#define regIH_RING1_CLIENT_CFG_INDEX_V7_1_BASE_IDX    0
+#define regIH_RING1_CLIENT_CFG_DATA_V7_1              0x123
+#define regIH_RING1_CLIENT_CFG_DATA_V7_1_BASE_IDX     0
+#define regIH_CHICKEN_V7_1                            0x129
+#define regIH_CHICKEN_V7_1_BASE_IDX                   0
+
 /**
  * ih_v7_0_irq_init - init and enable the interrupt ring
  *
@@ -307,6 +314,7 @@ static int ih_v7_0_irq_init(struct amdgpu_device *adev)
 	u32 tmp;
 	int ret;
 	int i;
+	u32 reg_addr;
 
 	/* disable irqs */
 	ret = ih_v7_0_toggle_interrupts(adev, false);
@@ -318,10 +326,15 @@ static int ih_v7_0_irq_init(struct amdgpu_device *adev)
 	if (unlikely((adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) ||
 		     (adev->firmware.load_type == AMDGPU_FW_LOAD_RLC_BACKDOOR_AUTO))) {
 		if (ih[0]->use_bus_addr) {
-			ih_chicken = RREG32_SOC15(OSSSYS, 0, regIH_CHICKEN);
+			if (amdgpu_ip_version(adev, OSSSYS_HWIP, 0) == IP_VERSION(7, 1, 0))
+				reg_addr = SOC15_REG_OFFSET(OSSSYS, 0, regIH_CHICKEN_V7_1);
+			else
+				reg_addr = SOC15_REG_OFFSET(OSSSYS, 0, regIH_CHICKEN);
+			ih_chicken = RREG32(reg_addr);
+			/* The reg fields definitions are identical in ih v7_0 and ih v7_1 */
 			ih_chicken = REG_SET_FIELD(ih_chicken,
 					IH_CHICKEN, MC_SPACE_GPA_ENABLE, 1);
-			WREG32_SOC15(OSSSYS, 0, regIH_CHICKEN, ih_chicken);
+			WREG32(reg_addr, ih_chicken);
 		}
 	}
 
@@ -358,17 +371,26 @@ static int ih_v7_0_irq_init(struct amdgpu_device *adev)
 
 	/* Redirect the interrupts to IH RB1 for dGPU */
 	if (adev->irq.ih1.ring_size) {
-		tmp = RREG32_SOC15(OSSSYS, 0, regIH_RING1_CLIENT_CFG_INDEX);
+		if (amdgpu_ip_version(adev, OSSSYS_HWIP, 0) == IP_VERSION(7, 1, 0))
+			reg_addr = SOC15_REG_OFFSET(OSSSYS, 0, regIH_RING1_CLIENT_CFG_INDEX_V7_1);
+		else
+			reg_addr = SOC15_REG_OFFSET(OSSSYS, 0, regIH_RING1_CLIENT_CFG_INDEX);
+		tmp = RREG32(reg_addr);
+		/* The reg fields definitions are identical in ih v7_0 and ih v7_1 */
 		tmp = REG_SET_FIELD(tmp, IH_RING1_CLIENT_CFG_INDEX, INDEX, 0);
-		WREG32_SOC15(OSSSYS, 0, regIH_RING1_CLIENT_CFG_INDEX, tmp);
+		WREG32(reg_addr, tmp);
 
-		tmp = RREG32_SOC15(OSSSYS, 0, regIH_RING1_CLIENT_CFG_DATA);
+		if (amdgpu_ip_version(adev, OSSSYS_HWIP, 0) == IP_VERSION(7, 1, 0))
+			reg_addr = SOC15_REG_OFFSET(OSSSYS, 0, regIH_RING1_CLIENT_CFG_DATA_V7_1);
+		else
+			reg_addr = SOC15_REG_OFFSET(OSSSYS, 0, regIH_RING1_CLIENT_CFG_DATA);
+		tmp = RREG32(reg_addr);
+		/* The reg fields definitions are identical in ih v7_0 and ih v7_1 */
 		tmp = REG_SET_FIELD(tmp, IH_RING1_CLIENT_CFG_DATA, CLIENT_ID, 0xa);
 		tmp = REG_SET_FIELD(tmp, IH_RING1_CLIENT_CFG_DATA, SOURCE_ID, 0x0);
 		tmp = REG_SET_FIELD(tmp, IH_RING1_CLIENT_CFG_DATA,
 				    SOURCE_ID_MATCH_ENABLE, 0x1);
-
-		WREG32_SOC15(OSSSYS, 0, regIH_RING1_CLIENT_CFG_DATA, tmp);
+		WREG32(reg_addr, tmp);
 	}
 
 	pci_set_master(adev->pdev);
-- 
2.53.0

