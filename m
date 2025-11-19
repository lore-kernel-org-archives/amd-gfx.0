Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A077CF34D3
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Nov 2025 15:06:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 141E410E65B;
	Wed, 19 Nov 2025 15:06:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BVRwvohC";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013027.outbound.protection.outlook.com
 [40.93.201.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D12E410E65A
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Nov 2025 15:06:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xs/x+LxOCJJXV0bBOMTor6RWJMdysphqlcxIXArA64gUaUOi53Qefw9VH9qubJqRaGXYhWfSIbq0ptZzX/V1PIIvUpqOwnaxdx5iWhVmkReD97lDjPfJ1FOwwygn7bbpyy3NY63jZtT5VNl98nAp4qjyNWOzX0rfeKAsLj0V1dAxIYDzeQtA/7LWlh2B6D7lFKQ1Cw49bAMlqZl9XegqWDqWQxhNk8Edg5VX/SI9PmuvpLrfHjuczV5VsEAHhMBrGDWF+avqqyqUezn26RLauyH1o3t8tu4xxuCTuDz3uucOPtusjCnthjvS6dhNIhKDyCmUokGJiZweK6DBe7qhxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yaF4YbqQ9YK2M93pGFTF6F1qj3hTLVkIsNVMPiSzVrw=;
 b=Bo1zubdbjwx9zKhXVIk0PlxgXg1UMFiat31BnHSQSvKiwCrzzwRSirVR8J90g7KWy7MdLNVeiY03LrYS6y0iGYJslx9pd5vcCWwq99OhMqIy05/MczarBoSdbl6DrFtah2aOa1FFxa38PaFxA46E6zUcbKmImULCi5LSNJ89sLaL31fhpyb7g/YVHgdkw+iA7MdG64bBhVdQkLyWgvXcfRi30XV4B+H7c50WPhiv1ez9GKxnDMh2W3gNyxjdVn6kMiX1I4ZQPRum1KprJkxd2LJ2vQ0uvNkDNGq89mCSrz42THstFZGOBgN7vRHNAdDLLSVcdKu0aEgJocYwWWQTAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yaF4YbqQ9YK2M93pGFTF6F1qj3hTLVkIsNVMPiSzVrw=;
 b=BVRwvohCi6b+AJ2r7u7cabzu3H2rwJQ/0zKn5cFQhm1Zhine5qEB7K7zi2X/iU4rP30IZI23I1kPuxwVryh9mIxbPVB3y6BSNCc8yNzxqaLM/VxIses2wxImIA3vAnLph6OiQiZeZMlYxN/1MSrF8ad2uA4p//OjdacqSMWwYUo=
Received: from BN9PR03CA0735.namprd03.prod.outlook.com (2603:10b6:408:110::20)
 by SA1PR12MB6893.namprd12.prod.outlook.com (2603:10b6:806:24c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 15:06:21 +0000
Received: from BN2PEPF00004FBD.namprd04.prod.outlook.com
 (2603:10b6:408:110:cafe::d1) by BN9PR03CA0735.outlook.office365.com
 (2603:10b6:408:110::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.19 via Frontend Transport; Wed,
 19 Nov 2025 15:06:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBD.mail.protection.outlook.com (10.167.243.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 15:06:20 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 19 Nov
 2025 07:06:17 -0800
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Le Ma <le.ma@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 7/7] drm/amdgpu: Add gmc v12_1_0 to discovery list
Date: Wed, 19 Nov 2025 10:06:00 -0500
Message-ID: <20251119150600.3663611-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251119150600.3663611-1-alexander.deucher@amd.com>
References: <20251119150600.3663611-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBD:EE_|SA1PR12MB6893:EE_
X-MS-Office365-Filtering-Correlation-Id: ebe2a8cd-d542-4577-58b9-08de277d3291
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bHWXG9koSDGsiBLGkhMua91YPJxFjeTaCQ6ZbCrU/3f66geu+PLQUnLVXR0F?=
 =?us-ascii?Q?X8vUsagiYumHOoS2AG/bbJiCl3zdN7ew9AaNPWWG2nZvNnTJpcwC/dz0McSS?=
 =?us-ascii?Q?1GfHwyCawjFn+AOPMrXD1FbuHqrcPHJiuYtGX1WQNCUx5R4J73Fwb8LLuiMr?=
 =?us-ascii?Q?awzHKD0OxlqqeAFo+5X1PkumXapfP+fucOnPDPdimpzIDRNJhcw0Nzr/huRe?=
 =?us-ascii?Q?JpcSMWUC60q9iDeWiRPTfh/Vf2FiGtF/hOqPzc4CKcUUlaDmsR/bH08TSdNU?=
 =?us-ascii?Q?TnP83RQzFDcZaVLR7KzGWrPON2upvLUFa7Jrahg2ZAbKWExW9/rUg0bXg9Gv?=
 =?us-ascii?Q?/8fsekK2IgZO95/uDq9/bK/hoVbWETk9BO5TSm3EF1KWEY88H7RCEc2ox1QG?=
 =?us-ascii?Q?v/9Uor64nJHlPKzhYNV+fx/jCDReStifx4IB60HqkZfBG8bQpFzyPmX1n1AD?=
 =?us-ascii?Q?hh7puXrgAeeUrpU01SasHgh7sj7BqB6WCEFmfrnWGEWVNZMOA9TFI3mSpmry?=
 =?us-ascii?Q?LLN+vRXi1rIcLmqBoEJQjcK+F8Yc3BOwezhWiastrctdsrbvXQDY3mfnEx6B?=
 =?us-ascii?Q?i+BX+7GBRFgyNAKJPkl/lCce77+Ta1/7FBt3FGV6++kGGkUjYpRoo2N8aMHO?=
 =?us-ascii?Q?2dfWC59CH2VzTP4N/ersjqNRO9lU6Rqe7ibTSoX0TCu76EXEkhb3pp4feY8x?=
 =?us-ascii?Q?sr/Dk/6Utvuecg4b/BI7QFOKqdxfdNq22hyYnZvWddMg4VUZXUHL1hre2JbI?=
 =?us-ascii?Q?D0m1l8AIlaTAwAEW+z7PGfMEmG8/A3P2Tbh+bNq/KmlTu8crHKV2CAnPtMox?=
 =?us-ascii?Q?P8WVGm+5GwwJxrbU65yeRPh3J/XgYWNyA/JibBSJlL7j2v11FueIND9ubqZH?=
 =?us-ascii?Q?n8YsRCOWX+lPIV1tnkWWQ24q6is75qzPZMt7xmWDh05eSE3E4lOIXHhM8SZd?=
 =?us-ascii?Q?Ba6Iz+jFITkLevzbfxM8dijuRs9fN2H0tTmUY93Zu5/JktZQxy9x2ps/tFSN?=
 =?us-ascii?Q?qohllVszDPVF6LjJZ/Z8rdBZ33ZOMqCMT9j/vxLBs3qaVSyMfJ/bx3+iB32P?=
 =?us-ascii?Q?fmPxUDGEd7Rj76aS4SYBOCzuYQLOhPt87crvAG9ZYzi65noWuB3hcSf4EqDP?=
 =?us-ascii?Q?lERTiQT/QL2JOt7ftl1j5/s2X4uF9uu8at4eY93IgcS5TPWrUs49Ak6IiMrn?=
 =?us-ascii?Q?nv7eXxJMeMx2jp2X1237id6Mm+zll+V1ddFYOA1WiI68CRG0n8+0+NTm60E1?=
 =?us-ascii?Q?VjFH4JnTGqpLK8i8zTUJACe/yKxhXUUfkHHtoarcloBcI9PCSyBTkSOLp7BR?=
 =?us-ascii?Q?aKhe/ovEphVuTqwCApqbLFoh1EGKQGeyOvPdncbB388A4vyDGl4HLvJkoRz5?=
 =?us-ascii?Q?KBm1CHuCasynKMpOyKxBVd/e80lRIYm82B6ZhLH+GkIj7Q8KPtD6/Vu0laan?=
 =?us-ascii?Q?4y/YhqOsDUraWgUKgzRfVoxdNR7bEna8w2uM3xXtjPzt8NGpo5k/0awgVZ0D?=
 =?us-ascii?Q?T0TAmb4M4/y80Zpb+Qx5P4NHMt5bhxPoazJQbMhaonzd+6/KruHd/0zS57oC?=
 =?us-ascii?Q?bWKKXGOU9aiTxaxNU0A=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 15:06:20.5545 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebe2a8cd-d542-4577-58b9-08de277d3291
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6893
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

From: Likun Gao <Likun.Gao@amd.com>

Include gmc v12_1_0 in the discovery list for
gmc IP blocks.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 6311b66259b7f..0e743f6ff90ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2044,6 +2044,7 @@ static int amdgpu_discovery_set_gmc_ip_blocks(struct amdgpu_device *adev)
 		break;
 	case IP_VERSION(12, 0, 0):
 	case IP_VERSION(12, 0, 1):
+	case IP_VERSION(12, 1, 0):
 		amdgpu_device_ip_block_add(adev, &gmc_v12_0_ip_block);
 		break;
 	default:
-- 
2.51.1

