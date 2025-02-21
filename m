Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88625C021AA
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 13:00:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1302810E82E;
	Fri, 21 Feb 2025 13:00:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UoqrIZv3";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 448EF10EA63
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 13:00:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G6kL7vgCeQkVx3kdlqTBKXjAUkh153pUVuIqqa10cwPhQuCepd55Y3b9557Vv0LFoqrhcgIPOKTlSAHbtWi8HGmSNeal6R8vOZzv2V9YBIJSJ/1LIhxC7PiG/GrYs0ziSmwfY8f61HI1ieY740p7rVmdv6OQql5EgYBWEpgVCVbWlGeSE4dsT8QzO52D49NPV5HmVztPemPGc8hbEpMO4I69fDx4/WNQrDsKe9uAIklcKDFjComFPJj1VpN++/Lfmy7X0IE8z0U+e1rkxniQftaWyIqkG2lkENp9+7X978zo/rU0SDCsidnrwzyC78gW495p/FWz0wO4g4YtXAGh4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6VJOH+uOzarD0yCDiacWYED9Ta9knE6EorDphGvYDHs=;
 b=cr8TKRXpkiSLCBhjXMq+qoA5fERRkXOmQaw/FkbwqgvCWv0q5l3IT7LXZXZluPL9KJ2xm2pfUWHwacaLnjQBDL/WrBdqAN0GNbbVMaV0pd2cRYz89UwFgPEWasdsvnThDLpCBulo0A7IHeOvnuePVUKdQpNa/FrqibTntfW2j4ZjNncabsaBJm/MzghfzvbIbSnNnnm1pwyfgVGzaTi9Waeo4DDBXSq10Yz8sMjzLAoJATbB+m7agHGmCiBNtOYIfYZDM3Q65UDzL9bf/4laVsf3ZbiX49a6JtFw/l8aLWHppOPlQeQLitiL4nK3X3nukOtw5Z1OhHDzlsQaxhSBlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6VJOH+uOzarD0yCDiacWYED9Ta9knE6EorDphGvYDHs=;
 b=UoqrIZv35iBfaZ86rOhzFiGMip8psoewrwj+wMwEpPIbf25gtFRn+sXSucn2Rez4s5iZyUgLHWf9grcrzQDMa9sWMOzT4E1ZCkxxmrWfX99/bJGJJHsN+TjF/sJMh4m3VX8hPq14n3PgPpkrsHoVZp5GCFAGaaFhvGUVE8Zt7Wo=
Received: from PH0P220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::15)
 by PH7PR12MB8825.namprd12.prod.outlook.com (2603:10b6:510:26a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Fri, 21 Feb
 2025 13:00:47 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::b) by PH0P220CA0006.outlook.office365.com
 (2603:10b6:510:d3::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Fri,
 21 Feb 2025 13:00:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 13:00:47 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 07:00:44 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH v2 4/4] drm/amdgpu/gfx12: Implement the GFX12 KCQ pipe reset
Date: Fri, 21 Feb 2025 21:00:30 +0800
Message-ID: <20250221130030.3703750-4-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221130030.3703750-1-Prike.Liang@amd.com>
References: <20250221130030.3703750-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|PH7PR12MB8825:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d947940-178e-49d4-f1d2-08dd5277c260
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OwTEWa2+YKL37HpOYMlglVvT9jdRztsR5EESlLJU0nL0lQHVTgalKDf8hLjK?=
 =?us-ascii?Q?vobkWBeCZh8Ns2B9W0S61/GxJkf/7KZHQVTpJM4PD6ALpn0D2HhNUv8wM4Pw?=
 =?us-ascii?Q?3SfTBt5geHKLkX+8rQEumYNMm9XLsui3agzn7vA9aQueAprRwviYG+bWE9v6?=
 =?us-ascii?Q?eKO0reqBlzQxHlxCbM8IbXO03HYMukSOiGD7WuYPuyDzfTeu0QnFGwjmdyur?=
 =?us-ascii?Q?KCLA3TscofCRefX6c4H7Hd4ulion2NYqzWXVEQBN+fpfbqGLKpMkRJUdDBLj?=
 =?us-ascii?Q?CbodwVioH/xBygh7JS/HcLb2/iQ63Sg3njNZ7pKkyqVSsONz4k5Y1WijAA8T?=
 =?us-ascii?Q?9Hsfj8jXvEmuEHEE5YPnYvmSYU5EejGuC3WW6XLxILAtc5goFxJPyjNfqzLq?=
 =?us-ascii?Q?IPeiMurAwJ6wfTOGqAOBlDoH1YMCVZtMU5AN10M0jn8r0yjrGqLTcmKVOc7R?=
 =?us-ascii?Q?M9R/yK5LpDo6fN2bjkrWJx6OXKni1CbxrucHhqZm4d9ctmExHrEmlaTkTWlT?=
 =?us-ascii?Q?5up2hT8i1TtsAaPrJxnuvoxMENmvYyR7uku9ESeDsaVgXFan3bhKs6zPOiMj?=
 =?us-ascii?Q?EA5dqQ11PaQv3WnXr7y3NuLmPxLVh9rVZ7KIIL1rxkXj3m/sxFgci5T+zxDg?=
 =?us-ascii?Q?r2NrtWcja0oHLTytN6KvWpwn4ahFmjEhuIC9+GImvsE/Yt8+FQhYvWQwGWtJ?=
 =?us-ascii?Q?Dqo8YWVwaTe9L4DVGxPZ7COJEQt9JzF4komoM19K9pkdxgIqiQWlz2DKc91M?=
 =?us-ascii?Q?J5pnRwzrAjD5/XegcMpXf5b4LEhCFL/89+jhIR74fsw/4JrUDNLLyjU+4awE?=
 =?us-ascii?Q?YjtRpEhYOFgTFxC3z1uXM8SCyTwmR2HIHDmEemTCJaq399srbArVc1FtY1I+?=
 =?us-ascii?Q?eg/OIu5DTaQO+bCNEKeR4+gXaKqt/9tv3uEXL9G9qfk+sMXPQI27dOCaZwp+?=
 =?us-ascii?Q?AXRAxxVnpCbmppjPpxyTROeDtLtJAL1DC1cMcgKxXpwZS9dw6vFYA4hwRz8Z?=
 =?us-ascii?Q?f3hvd/CD/9j4zy6c7gPr1H6EWdQV2fpL4tH2bxwJmRvRCJIx9c2DFAK0saww?=
 =?us-ascii?Q?9qh3W+11irW6WdaJl7mh/OuyIrCHxj9uUb1yLC1QxF9GxVSYErP3p4DV+CIX?=
 =?us-ascii?Q?Fb7qj6bxHt+DIoyb9mgxO7qw+eSWTdQQBoW/ONXmxzg/srVHwM53UNKYvIK5?=
 =?us-ascii?Q?Xy78dun0FGP4kbWg0FrSbaygjGs2B/amZCI44bhAvn+mN4IpUDYxV3N1kOvN?=
 =?us-ascii?Q?SxnOlDgxSnJSdm/v3bN0Rm8GcwzeSS/cpDsrjsWbsFXsvaqJ4s5lkByYQoep?=
 =?us-ascii?Q?SHaeROJuukn64Imt2UYhuL1HFMfDGHA2nhA+Zj+FmCZBVdeOywosor4thba9?=
 =?us-ascii?Q?oNBUUF8OFsGC49w3K3bEMw2gkdj8h7qNimbOR4sW6agmGpHfVl47FRppr3M+?=
 =?us-ascii?Q?a3m1Knln5TRI08MYW+OCC+yBhFcaHsJXVizptC6TGieOd++kx+Qi99Lsu4t3?=
 =?us-ascii?Q?DLmGAe/AvRcUAx8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 13:00:47.0478 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d947940-178e-49d4-f1d2-08dd5277c260
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8825
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

Implement the GFX12 KCQ pipe reset, and disable the GFX12
kernel compute queue until the CPFW fully supports it.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 90 +++++++++++++++++++++++++-
 1 file changed, 88 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 79ae7d538844..103298938d22 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -5352,6 +5352,90 @@ static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 	return amdgpu_ring_test_ring(ring);
 }
 
+static int gfx_v12_0_reset_compute_pipe(struct amdgpu_ring *ring)
+{
+
+	struct amdgpu_device *adev = ring->adev;
+	uint32_t reset_pipe = 0, clean_pipe = 0;
+	int r;
+
+	if (!gfx_v12_pipe_reset_support(adev))
+		return -EOPNOTSUPP;
+
+	gfx_v12_0_set_safe_mode(adev, 0);
+	mutex_lock(&adev->srbm_mutex);
+	soc24_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
+
+	reset_pipe = RREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL);
+	clean_pipe = reset_pipe;
+
+	if (adev->gfx.rs64_enable) {
+
+		switch (ring->pipe) {
+		case 0:
+			reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_RS64_CNTL,
+						   MEC_PIPE0_RESET, 1);
+			clean_pipe = REG_SET_FIELD(clean_pipe, CP_MEC_RS64_CNTL,
+						   MEC_PIPE0_RESET, 0);
+			break;
+		case 1:
+			reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_RS64_CNTL,
+						   MEC_PIPE1_RESET, 1);
+			clean_pipe = REG_SET_FIELD(clean_pipe, CP_MEC_RS64_CNTL,
+						   MEC_PIPE1_RESET, 0);
+			break;
+		case 2:
+			reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_RS64_CNTL,
+						   MEC_PIPE2_RESET, 1);
+			clean_pipe = REG_SET_FIELD(clean_pipe, CP_MEC_RS64_CNTL,
+						   MEC_PIPE2_RESET, 0);
+			break;
+		case 3:
+			reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_RS64_CNTL,
+						   MEC_PIPE3_RESET, 1);
+			clean_pipe = REG_SET_FIELD(clean_pipe, CP_MEC_RS64_CNTL,
+						   MEC_PIPE3_RESET, 0);
+			break;
+		default:
+			break;
+		}
+		WREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL, reset_pipe);
+		WREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL, clean_pipe);
+		r = (RREG32_SOC15(GC, 0, regCP_MEC_RS64_INSTR_PNTR) << 2) - RS64_FW_UC_START_ADDR_LO;
+	} else {
+		switch (ring->pipe) {
+		case 0:
+			reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_CNTL,
+							   MEC_ME1_PIPE0_RESET, 1);
+			clean_pipe = REG_SET_FIELD(clean_pipe, CP_MEC_CNTL,
+							   MEC_ME1_PIPE0_RESET, 0);
+			break;
+		case 1:
+			reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_CNTL,
+							   MEC_ME1_PIPE1_RESET, 1);
+			clean_pipe = REG_SET_FIELD(clean_pipe, CP_MEC_CNTL,
+							   MEC_ME1_PIPE1_RESET, 0);
+			break;
+		default:
+		break;
+		}
+		WREG32_SOC15(GC, 0, regCP_MEC_CNTL, reset_pipe);
+		WREG32_SOC15(GC, 0, regCP_MEC_CNTL, clean_pipe);
+		/* Doesn't find the F32 MEC instruction pointer register, and suppose
+		 * the driver won't run into the F32 mode.
+		 */
+	}
+
+	soc24_grbm_select(adev, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+	gfx_v12_0_unset_safe_mode(adev, 0);
+
+	dev_info(adev->dev,"The ring %s pipe resets: %s\n", ring->name,
+			r == 0 ? "successfully" : "failed");
+	/* Need the ring test to verify the pipe reset result.*/
+	return 0;
+
+}
 static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmid)
 {
 	struct amdgpu_device *adev = ring->adev;
@@ -5362,8 +5446,10 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmid)
 
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, true);
 	if (r) {
-		dev_err(adev->dev, "reset via MMIO failed %d\n", r);
-		return r;
+		dev_warn(adev->dev,"fail(%d) to reset kcq  and try pipe reset\n", r);
+		r = gfx_v12_0_reset_compute_pipe(ring);
+		if (r)
+			return r;
 	}
 
 	r = amdgpu_bo_reserve(ring->mqd_obj, false);
-- 
2.34.1

