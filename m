Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F30D3E793
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Dec 2025 05:17:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16E6710E6F3;
	Thu, 11 Dec 2025 05:17:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="r5fNYpv3";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012025.outbound.protection.outlook.com
 [40.107.200.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 451FA10E6E1
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Dec 2025 05:16:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yLlmJh0ZTZWUf7aPjjI1xrqThlKmEItKmdy1xEZkYlMpHPUA0yOzM4Ltk8k38U0F3E/PDHTnLzM/w2rZCvOJyZLRV7Fz+qmfpE9ontMPdSO+u7Sx2+ldLl+br9xfxu8eWUDEQo1K5d4b7MsxcIXP6IEAlXWXevXK7FaLEnu261X1jWINkZP65f2cXULMWsDoF854thdSkftIRTcNsGIwKgBSt2ZhhfrycA4t0V4LFe0ieeLBfFAUcSdesAdm+u+0FBNflA7AVAkKU2WysgWZSyC1xCTwAxAf+GcpDTnS56K1UGO8KhlF8ZJdvynHMdVsNkpbPlElGgccfar/sc2Jng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CsbiiQEeXIKIhyjGw1SWqngPaTTfh5GOruO0Yhzs2mw=;
 b=wsZDnxP8E6P6nLpejvrmBcg/xq4A70SifqOg4w5QY4fq9414JQOl/Jh7lx3QhuNdX7we35uP7eolhlNHDPAtJuTRz97Q9INsRtMxAdwcneZpYchHpcERcD7F+Cf2Ao7jQTQxXQI3xk4W6wwAGSw7Qs/iUcBgJG5e37OLxhKwkwbUEW9HGbqN5xLxc4nA1Gw3+/fM2FOrdPyjgkxROvJQy5Y9IqY+oZ270LMdegUBcAaz7nTlYGeXvoxG5OuMp1mJx8qjqCA7r+RDI9fFoM5JCVZn4XU4GZ+jZ27w6LfiTECudoiEVbHshYUBPSuJ48Gn+YsCI6wg0GSqr5zQiY70eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CsbiiQEeXIKIhyjGw1SWqngPaTTfh5GOruO0Yhzs2mw=;
 b=r5fNYpv3yUSRG/SmBthFxxOXRdvtfLo7Xjq5H0xw/D/ZoUdaK0wxmCj/vkeJyPknkVk4E8/MThe9DCRuU9SHgc+DULkzbbLxwqvF3b4AhI0qITmA7iQPPi5Mai0eV9NXJsaLXyviGpq7vpG5tGMlYcxkJWa3u7H9yLuyeF+/2q0=
Received: from BN9PR03CA0630.namprd03.prod.outlook.com (2603:10b6:408:106::35)
 by CH2PR12MB4231.namprd12.prod.outlook.com (2603:10b6:610:7d::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.8; Thu, 11 Dec
 2025 05:16:15 +0000
Received: from BN2PEPF000044A0.namprd02.prod.outlook.com
 (2603:10b6:408:106:cafe::1) by BN9PR03CA0630.outlook.office365.com
 (2603:10b6:408:106::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.15 via Frontend Transport; Thu,
 11 Dec 2025 05:16:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A0.mail.protection.outlook.com (10.167.243.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Thu, 11 Dec 2025 05:16:14 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 10 Dec
 2025 23:16:12 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 2/4] drm/amd/pm: fix pp_dpm_pcie wrong state issue for smu
 v14.0.2
Date: Thu, 11 Dec 2025 13:15:53 +0800
Message-ID: <20251211051555.652129-2-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251211051555.652129-1-kevinyang.wang@amd.com>
References: <20251211051555.652129-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A0:EE_|CH2PR12MB4231:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bc30e87-5354-480d-612b-08de387467e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rT40Vcb4aNFTwKWLpRGkwGkZEeEoD7twq1Y/Yo0H1DSB0rXENxK2owGkJhlX?=
 =?us-ascii?Q?ZNLWlOWW7b9BtkRa1OZDQxudw9NurLZd/mEyg7PjVkHkBNFiYz9vAW0qOYdV?=
 =?us-ascii?Q?xCtMlQimyWoAjZk03BJS13sXan7otXf5997obf34DyraJacbZgfVu/hwOnk4?=
 =?us-ascii?Q?V0nkVSLxaf466qBjpqGsN1uaapUggxpLYJY8tqshwJ2+nDkKaeAppVyDmLVw?=
 =?us-ascii?Q?0F4K3kXWrNQyxfiEAMCi7qg7hxOmeWL6lOHBleeGoVqNmDvBg//7ebuCBgZP?=
 =?us-ascii?Q?wuIMSoXl9qJ+zr7rr7muGOD1wodMED7UcD2shuQ2ZtsOGrpxR2peUFcOwkp8?=
 =?us-ascii?Q?pKCCm1RhNFCQkSu3vUKj2QeBxLRZrjhYVudQdRHJQQGFT2rf+my16QU7KH7o?=
 =?us-ascii?Q?yC7yOOeXWd4+EY0Q1mr6dac+JZXxPyDpNm0w1elZyyJZc7+6Zh/LfALOZwG0?=
 =?us-ascii?Q?1Qg+qutXVDlW2vZTF6+cUVe0cQBU1eg5eklgxtgG/VRSOIfMCA6UF+fF8ZjL?=
 =?us-ascii?Q?znrc0BdHFQ1bE0VzP6QtMzfRZ/dtXjiYW3WWcu/+hX2w2qBX5RNAg6yTtoMm?=
 =?us-ascii?Q?KzUyEyL/Puv5arttb4Md/4Em6o0gKjUB41GBRwoMXI/KRWSBoC2tYtfTBnam?=
 =?us-ascii?Q?HBQPxyKFxZmv1VTtMLY0ZGvD0omU/oRmHGpSnqXmIWE4AAQ3MRgeHhIAdG4b?=
 =?us-ascii?Q?lyliL3+7SoAmwg68+usRK8KJg5UrUZMqVMjwAtmeMKSEstW69VF7jB6Gp99w?=
 =?us-ascii?Q?W7vwtlYLvnZPaZJFC3taSCyPpmeUXxRPECqp3btTn6TZsjIzxGTfZ3S1+QxQ?=
 =?us-ascii?Q?Cg6CbxaRPNm4Wv2nKsMuD6cbM1Wzr/C7E15cledtA/UZ3WPMN8Fx/5wRZjFO?=
 =?us-ascii?Q?b34RlgZVxW1FEsemKiMAsCfZkHJbrfRgcazPdXhZQrQUyp0u6OoR+ZwT/xjZ?=
 =?us-ascii?Q?yafDvIdO65Vts+jzA1Ah+wh7QNKR4bE7iY4JcmYzsCoLHq8t4lTZfi5q4Rfu?=
 =?us-ascii?Q?u7WkcEOJYyXZQOtp+2tQ+srKt61vArAi+0Hd3Kw13W+P/bthBqhpxefoicMT?=
 =?us-ascii?Q?Mag00UYqGVPk5R7dV2Lsjz2QjXdOdcfQV87v3vwwGfkDxPAFulvfaReg8z2A?=
 =?us-ascii?Q?aiHLULUkIxCSJOKExKhXNJOdbiiMv4o3VRfCm+CjDwlesTlfgUIpKz46r0+J?=
 =?us-ascii?Q?QSgomNRvPgFXcTYNu0SHm3jfPSMyGNosRSXZ27kfaXUC/wcVO+TbTZb4imGn?=
 =?us-ascii?Q?3a+2SZqZRI0V2yB2XgDDbwK4xdhXnuADAmEIVQ6DLsjsGEzVc/Am1IOawPxq?=
 =?us-ascii?Q?A2QvKHW3J0Iq0zFiYSqwmc6G7Oomy3Z8wxUUJH7vvPKRIqzgqDFe647SmERS?=
 =?us-ascii?Q?pzRQhCd5dRptKiNSOxjtOCQZ0jN12gH+XaCjgPrpCszaPBcB18dN7/cVWmxU?=
 =?us-ascii?Q?xmL19njfWWsHtQcCe58biR57dX1M4GnVUXPinkM49PsZPuI8qQbyDwgOSM2M?=
 =?us-ascii?Q?kQgGKUCJqYoAy275+D3MBae6l6Yg8A+0CFlFxXuUoKQICD/3mkyII6lj2HN5?=
 =?us-ascii?Q?d8jnWAeThS+xzCfHdvM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 05:16:14.3302 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bc30e87-5354-480d-612b-08de387467e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4231
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

put wrong value into incorrect data into following function,
which caused it to fail to match the correct item on smu v14.0.2:
smu_cmn_print_pcie_levels()

Fixes: 55fc561a1955 ("drm/amd/pm: Use common helper for smuv14.0.2 dpm")

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index d996ff69c60a..4a2a56758bc2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -1095,8 +1095,10 @@ static int smu_v14_0_2_emit_clk_levels(struct smu_context *smu,
 			return ret;
 
 		pcie_table = &(dpm_context->dpm_tables.pcie_table);
-		return smu_cmn_print_pcie_levels(smu, pcie_table, gen_speed,
-						 lane_width, buf, offset);
+		return smu_cmn_print_pcie_levels(smu, pcie_table,
+						 SMU_DPM_PCIE_GEN_IDX(gen_speed),
+						 SMU_DPM_PCIE_WIDTH_IDX(lane_width),
+						 buf, offset);
 
 	case SMU_OD_SCLK:
 		if (!smu_v14_0_2_is_od_feature_supported(smu,
-- 
2.34.1

