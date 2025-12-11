Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26C85D3E78F
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Dec 2025 05:16:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB6E510E6F1;
	Thu, 11 Dec 2025 05:16:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lrHO6sfe";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010052.outbound.protection.outlook.com [52.101.56.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 293CC10E6E7
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Dec 2025 05:16:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pfF6foHDDYH8QS+NHFj/DgGhcHaRu6MmP0LEyUKYu6qaxt0aEmMNoUyywcQr+FEYlGmzrjInSgUjiVQn/pUSQvML5wC5d82VRtWMq9oLZH2pOJV4njSIoAqF/t3xhxkK1Euy5rCT2WAwFBMWjjVniZH6x/ZW7if4cHRRqah5yYTpw+5KQ1nWgkHrsjV2kZwvmBUHvSngBMEu478cNHe7nlBlQct77G8pgXZ6eUuSoGaVa9eS7hGmrtbA3zS9aJFMj3VOr7T7RmsxMhB7yUP87q7g4dXFq2+A27p2yfdw5Q9orQlJJJDEtIVUNUZGi7WkA6imuhctpn1E9+Hux0qo4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=856GkwjxK0h95S290xRh1o4IBTzMcafGWtFrRg8aHDM=;
 b=T0HZr8McYhsoX/lxzU4clpkLhRcqvzvXUnGn3pSE9PR2x9AGjfUFMFChm3OWtkgeV/T3wI1j+otF0PA9LFzoh/z4jFA7PsNeYJmDdiWp+cBntIxRs1sfQclBgzsR+Ad+HSCJrKPVidE6q7ogjgfQ/8p1wUV0oy/sXUBEn7++oGpBLFLvDfzybSbCQAnxtLAiGNpjt1yVgevVQ7NRx55OWsVaQlVk7pSXqq/J+WRWq14Jv2luhvYjx+ekrybBMns7q4X1STpCcYClfMOv6y1Li+WwPV4J0vf9Kw/7S43rdi6QfLoD0lSfa3FioGJ+/xYWkazwxOV8pTNQUEfklulhXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=856GkwjxK0h95S290xRh1o4IBTzMcafGWtFrRg8aHDM=;
 b=lrHO6sfei9geexs+AwVos52Qw1n5T8ttEjf2DOsWWPRcq1wnZ/lLO27iuAV0uejCam9xaRtZYxlIwZ8mOCIfy0Gqut17niuUlrL1RGNn4zZn+ZmQPOLx4HjplDspaShBINdPK1FEGa2lt8CjxzJmIGbBh58+3ndGXjNhstzj3tI=
Received: from BN9PR03CA0087.namprd03.prod.outlook.com (2603:10b6:408:fc::32)
 by IA0PR12MB8982.namprd12.prod.outlook.com (2603:10b6:208:481::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.8; Thu, 11 Dec
 2025 05:16:18 +0000
Received: from BN2PEPF0000449E.namprd02.prod.outlook.com
 (2603:10b6:408:fc:cafe::9a) by BN9PR03CA0087.outlook.office365.com
 (2603:10b6:408:fc::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.15 via Frontend Transport; Thu,
 11 Dec 2025 05:16:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000449E.mail.protection.outlook.com (10.167.243.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Thu, 11 Dec 2025 05:16:18 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 10 Dec
 2025 23:16:15 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 4/4] drm/amd/pm: fix pp_dpm_pcie wrong state issue for smu
 v13.0.7
Date: Thu, 11 Dec 2025 13:15:55 +0800
Message-ID: <20251211051555.652129-4-kevinyang.wang@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449E:EE_|IA0PR12MB8982:EE_
X-MS-Office365-Filtering-Correlation-Id: 99b225be-c898-4fc5-df32-08de38746a3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?czjvv0B8+GMEID8IFIpmzNWDN80LsCHecsLj432HRWTPF+v19Gxd3hxL3w89?=
 =?us-ascii?Q?r9ZBW7mu+AsjCEQ/5LMc8HTJU6+lZslw56oo/vaV4laJT+nSskviBbyazD8q?=
 =?us-ascii?Q?KwrwBu3ymoCXRsDxRoDIokzoUEX1FrS3CZdnktU2+Ln7y8G6Uw9Wij1+NTFP?=
 =?us-ascii?Q?MD+CXboE8/ChQHE4g2AKzrFrTdMEtOfIqLzCCf/or5Yr/A1OHPN/GLn0Ws9z?=
 =?us-ascii?Q?6uU/+frkzhfovXLDLDFHDh23JKXRqGp6kLiR738creumfIBSBsO0mHphvAIP?=
 =?us-ascii?Q?cf3rNkG546s5G8wKKgy1Df8BbdPMAqcKSOoDkj/4FddXYMmtnlYwRLJ2zXSx?=
 =?us-ascii?Q?Q5UeMXO49bLQ1TPz6Qop8n+h9b1QU5X55FJlD1/slnmUS1wNdZJfTUbhoGMq?=
 =?us-ascii?Q?m3fawipGCrBEnmDCGhlXjzTacfCLhsRYFZC17vfaRXvVvYNaqkrzzamUGl27?=
 =?us-ascii?Q?E7lOqopRGy2L+EK9RRAE/uDvtUwprdWOua9Ah11myi+RrQym22pMTizmAtsK?=
 =?us-ascii?Q?gzWvHgh6kS84MCskTqQS3Ycugc8sZiI10PTdW/bgNrsetojBhXPNa+5nzw2A?=
 =?us-ascii?Q?Lp1LmepyikPI7bKT9Wp8FUofBxPbPO2fp1JqiRqpKlIHZpg3g8y/b6XDJId8?=
 =?us-ascii?Q?NglivYMjixsy6/QGXXpIu/UdBKQrV2pGQnHe3rX4grM2tpstMumDV1QIoawC?=
 =?us-ascii?Q?kIxCKympsxI1Tzg3mP4CFJIRGbEadIJ3l5cuc3y/RiEM6zqDhapnZkS2jYSI?=
 =?us-ascii?Q?pPSt//2645Wfx71Qr4JI/jimAgkvP+CzG1g05Gl39ZX0ByU55f3hz8Fmx73n?=
 =?us-ascii?Q?RY3vdGyKcQn2yVk1ID/LZY8tEXbzahF+oIxfYo/8/h7Uyj2pBhIYdMH1Kx0X?=
 =?us-ascii?Q?ye+ga8yLvrO+8ImpOydSDRyaLGnOQE8LejuZ3zUKMJmRwYr9NfB5bhIPvMD2?=
 =?us-ascii?Q?ttJvypKrLvEo+mf0/u5JSvW+SMnOF7njenT+mh+QW6Vi/xWxk/NMzPAqdZ7T?=
 =?us-ascii?Q?v/20Vh5gPJAlnywURGJt0ge9H993+7VUi50+Ft53fMVIvnGCOCcKMh+SJUVr?=
 =?us-ascii?Q?nGzPiltdB75+MOK4inRneBj2BQXZV/pnvG+pInTh4sXyg5YMnyNOAKBlRTkR?=
 =?us-ascii?Q?ynLGz4JHWUZvZiVJVaB7y4kY5I9CdhwXHe51TAkJzC+o4PhUK8VOXJfxzGGp?=
 =?us-ascii?Q?6TIW2g1ikfeOXg8DiPXlii3LZ4A8maUyGQTjBnAhg/yFpolmAZkn5pPyOoPm?=
 =?us-ascii?Q?82Fhzp9id5qztyZaZfIOb/VS08llB8FJxioCQpMT0lveXFweEXvmmT3lCgIC?=
 =?us-ascii?Q?d3xQiVhLIIvOKz9bc81uM4WOUsoifZ+3mA+YSeC1sEaUt/KGwzaUSPZhrL2e?=
 =?us-ascii?Q?J02p9MnPoxIyJtypGaa89r8PFUeoYq0kDoa+m6UrQcg2cOn7RiwZDx7Si2WI?=
 =?us-ascii?Q?MHJQz6EIP9qhdhfcDdqfDYZCuVAhGuGAk3mHEuJ9UuL0TuiFLCJmbqT7Ch3x?=
 =?us-ascii?Q?91SxkFep6OpMQS1ODQZgdcjSsvFQdXnLyQrt/7/kr3V1gYIEthS5N9inWuUC?=
 =?us-ascii?Q?vg3vCKcXHmF+K73xXYY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 05:16:18.2711 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99b225be-c898-4fc5-df32-08de38746a3f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8982
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
which caused it to fail to match the correct item on smu v13.0.7:
smu_cmn_print_pcie_levels()

Fixes: b60647c37084 ("drm/amd/pm: Use common helper for smuv13.0.7 dpm")

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 30bac969d565..135328121630 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -1223,8 +1223,10 @@ static int smu_v13_0_7_emit_clk_levels(struct smu_context *smu,
 			return ret;
 
 		pcie_table = &(dpm_context->dpm_tables.pcie_table);
-		return smu_cmn_print_pcie_levels(smu, pcie_table, gen_speed,
-						 lane_width, buf, offset);
+		return smu_cmn_print_pcie_levels(smu, pcie_table,
+						 SMU_DPM_PCIE_GEN_IDX(gen_speed),
+						 SMU_DPM_PCIE_WIDTH_IDX(lane_width),
+						 buf, offset);
 	case SMU_OD_SCLK:
 		if (!smu_v13_0_7_is_od_feature_supported(smu,
 							 PP_OD_FEATURE_GFXCLK_BIT))
-- 
2.34.1

