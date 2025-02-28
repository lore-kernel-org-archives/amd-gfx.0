Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 364A8C282C6
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2025 19:54:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB44910ED35;
	Fri, 28 Feb 2025 19:54:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pXYNK0Jk";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2044.outbound.protection.outlook.com [40.107.212.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82E1A10ED35
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2025 19:54:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IAUS6XHUF5/HX/PiJG7GUY8GHTOFY6t+++7FEmYT4Y4W0KpfRoDSE1WURqaFy2U9OUFlEWK7KRthC8W2/PutIkxxn0XuhtML8lI2IPutbAn94EfOQtloDmG3BVepkbv2sUmFdQgWwdwqX2dm4yVpzH3QXAqb+IqLLFDzrwnUODM2sPiGed/r3KUTBY5hXsKYl3/rxnX/TXC7uMEynEqnUkmVNQNBP5GJd9y7fM/Ex57oJZoDcCd+J35fXZlU1RFJHYiOIWEy5GDyCbtsVOP/zYOlsiwoul4pArDhO0xF8atHuHAIrJkMHxpkswJpn+HwVi8HIEmskiD8w2twOMIKqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eSfYUie4pOzX42KXYP9GPgKzoRYgTk1tUXG6PVIiKUI=;
 b=i1CXvZcvIWqOVpgWc71hC7V1xKBHVvQLVTcOoOAJDola15/a9wUFq/Ao8hjYj4dnFDbx7NpdrRzon3zAvsQ0bIQrcdKPEk4nFoa2+DQjK1h3y8yDKu+/Z7NLqGxK0xawVHQbehz3r9+EvMsC7cPYD+WHUd0Tnh+QTNc3hALCsURBlqvQtWdrZXTiCPwfyHz6j83RcpdVO/FuRrxN2WrBKDloBmDQrGaYpAHuRODDS9oB5QTTGcNaUBRUt0GHinltaq+lAaLCnbCmvWjHiT+DdInrQy3CleT2/tXtF4mxE7mZT1AYxbRseNafW84+Oq1PMBq0585vYj5oYxOsVih+yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eSfYUie4pOzX42KXYP9GPgKzoRYgTk1tUXG6PVIiKUI=;
 b=pXYNK0JkG37Qih0MacMRPDoyuDSxVePT5EmU5PYvC9OZMLSGy9t8wu/Rt5/Sj9jVvDyF20kPaI7P0zayTH6TCRrARdsVmS5hpdoonJejekTcmKtnFpQE9mypGxWgBkBm9berKAR1Vb29yiQcjFuz9w+PxwVKRX34qToVHH4qRYU=
Received: from DM6PR17CA0012.namprd17.prod.outlook.com (2603:10b6:5:1b3::25)
 by CH3PR12MB8282.namprd12.prod.outlook.com (2603:10b6:610:124::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 19:54:27 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:1b3:cafe::3b) by DM6PR17CA0012.outlook.office365.com
 (2603:10b6:5:1b3::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.18 via Frontend Transport; Fri,
 28 Feb 2025 19:54:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 19:54:26 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Feb
 2025 13:54:25 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4/5] drm/amdgpu: add userq firmware version checks
Date: Fri, 28 Feb 2025 14:54:10 -0500
Message-ID: <20250228195411.2530147-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228195411.2530147-1-alexander.deucher@amd.com>
References: <20250228195411.2530147-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|CH3PR12MB8282:EE_
X-MS-Office365-Filtering-Correlation-Id: fbc75e49-464d-4aab-c5c6-08dd5831b4f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UO65NTfGDyNRdFuMdzXdHsVlZPWI28KMw/IU/MTg/ILmAVgH5gd36KQWBSD4?=
 =?us-ascii?Q?AupRdZTHgA2XnEqgtPFyovArWJDUXBqax4QvYeJNhlSXY8QI4UvSMnzU4eGe?=
 =?us-ascii?Q?ElT+ITBv7jDPnjD4kAunwMX07Dfl2wLGGFoh0VlsAHUJ6e4oZ0XdD6QCEaxJ?=
 =?us-ascii?Q?MYbKJzDmEFeSxXVTJ/5KrfMiSPuWqYw9LQqpPXvqi1LLr/HIPRBBjKvp5sbF?=
 =?us-ascii?Q?OIJqzxp01kesVddlGsEdxBZ2Fr83apE21QO4yv0aS6n10+4UeuiKQbuxZLj5?=
 =?us-ascii?Q?Q+xCFhEOS2mQckCAedNkOGdYGLFNcfHiYUsZzWhtHUoSd3zwODHI7TqLG3M0?=
 =?us-ascii?Q?4xF6ci/wgIre1k5L9wc917Kdciyh4yTOAazxDF9FQcOFn/VoVg9NEu7xaLTq?=
 =?us-ascii?Q?qJasoNJASkyApzrOtgdSyVOzV8C5e0b9dDMRQuMRSbjqN2ldaaAQph/om44H?=
 =?us-ascii?Q?ENba/By44LB96/h2jq2Bpkifu3n4cCD5hZ+RLp39yrYef5jgOlAI1Rh6oj72?=
 =?us-ascii?Q?6LdRuweugUq4MbHxBWPR5THW+I4vcm9idBkU6+hGe8dCtPOEY0SaO8SfqGAw?=
 =?us-ascii?Q?3mC4eEj7Mwpiq1aGdexhoIK4Uvw2FSXb2OrxcGN4N1KtltD4gVkwhly5E6fZ?=
 =?us-ascii?Q?WN3lvyz65aF76mlyIAEoT9o+G+mDVQWLuirLuAkw7M0O0PnsgzgER2RJXMIE?=
 =?us-ascii?Q?TlaMJ+2DuRiqzkoOIptEkMq4/Q0uYiZuwvcvwNVjTb+JGfCbjGz7Gh2GlgiF?=
 =?us-ascii?Q?35IxG7Ei6aHVD7jbUBU8t6G92DEqqPJL+mHwh4hzoxta6a5hat8LgWNwLHj6?=
 =?us-ascii?Q?7QkavNMOg8lw3/wwm8vuJRK3BvXJLoTXJq/wZyzaddDDKduCJX/2x2Hpfi6j?=
 =?us-ascii?Q?lRg1UcWvZpa+NNEQhj3ybyE2p8Ab+bCcOZgsyaBvXkDlgHdSUin7lyTTnefD?=
 =?us-ascii?Q?sHsWpHA+vn79cKWiwXUIsRffImBfTHlTGKpgZVD7L3+twy7qT+OfZgLEPYoy?=
 =?us-ascii?Q?QnKoLaelkWCGIU6tcRd2LZ7/B+1Cgk/0qZVKuL0fMNG9sITiuISnTwfB4ljG?=
 =?us-ascii?Q?0BfIYVyuejEUURO828RrTLxmNR635TLHpO0qA9QbJ3u9QVPWXAkg3B8tQ/0a?=
 =?us-ascii?Q?9jEhro2Lv++5Nruy/vJHG7wflrtFm5s37pFm3VlRarXHw8+Gi9cnJ3zwSrIU?=
 =?us-ascii?Q?FTOilZ9AV/F21xvxqUwesHh+xHEBKliFKtA8tWmi2sufqfomIxfYr6nKkwyZ?=
 =?us-ascii?Q?w1aHxfCkUgRDNNNNzbRzUBkVkAHW/wAGX5kkJCLXfZxoGzefG5lcQn/dwzbC?=
 =?us-ascii?Q?qugDKAYKpKw3zXcbT6E8WaA+y5e1sNp74Xsl0NNO9DgobofnDY50BHjN/+nZ?=
 =?us-ascii?Q?oBKiuZZO24kZb9+b0AR0b9HR0xUg24Ogwal7J8JzxnWtcyVtwiiFIi49lh+N?=
 =?us-ascii?Q?TeZlKGI5MM86IP6sIQcle6a1RMBHUvqfIebvC3r460xrKy0QbV/T1naXgMVb?=
 =?us-ascii?Q?rPRCc2wJvB16cUg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 19:54:26.7679 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbc75e49-464d-4aab-c5c6-08dd5831b4f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8282
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

Currently disabled until the firmwares are officially
released.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 14 ++++++++++----
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c |  7 +++++--
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c |  4 +++-
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c |  4 +++-
 4 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index a56fccd21cf6f..2cf663d25881d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1594,8 +1594,11 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 		adev->gfx.mec.num_pipe_per_mec = 4;
 		adev->gfx.mec.num_queue_per_pipe = 4;
 #ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
-		adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_funcs;
-		adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = &userq_mes_funcs;
+		/* add firmware version checks here */
+		if (0) {
+			adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_funcs;
+			adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = &userq_mes_funcs;
+		}
 #endif
 		break;
 	case IP_VERSION(11, 0, 1):
@@ -1611,8 +1614,11 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 		adev->gfx.mec.num_pipe_per_mec = 4;
 		adev->gfx.mec.num_queue_per_pipe = 4;
 #ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
-		adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_funcs;
-		adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = &userq_mes_funcs;
+		/* add firmware version checks here */
+		if (0) {
+			adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_funcs;
+			adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = &userq_mes_funcs;
+		}
 #endif
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index e763151f056d4..60d8630a05c82 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -1390,8 +1390,11 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 		adev->gfx.mec.num_pipe_per_mec = 2;
 		adev->gfx.mec.num_queue_per_pipe = 4;
 #ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
-		adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_funcs;
-		adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = &userq_mes_funcs;
+		/* add firmware version checks here */
+		if (0) {
+			adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_funcs;
+			adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = &userq_mes_funcs;
+		}
 #endif
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index d5ef20202f44a..f1a02ce844e0f 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1381,7 +1381,9 @@ static int sdma_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 		DRM_ERROR("Failed to allocated memory for SDMA IP Dump\n");
 
 #ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
-	adev->userq_funcs[AMDGPU_HW_IP_DMA] = &userq_mes_funcs;
+	/* add firmware version checks here */
+	if (0)
+		adev->userq_funcs[AMDGPU_HW_IP_DMA] = &userq_mes_funcs;
 #endif
 	r = amdgpu_sdma_sysfs_reset_mask_init(adev);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 0f9e5007d4171..f10de8e2fcae2 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -1383,7 +1383,9 @@ static int sdma_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 		DRM_ERROR("Failed to allocated memory for SDMA IP Dump\n");
 
 #ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
-	adev->userq_funcs[AMDGPU_HW_IP_DMA] = &userq_mes_funcs;
+	/* add firmware version checks here */
+	if (0)
+		adev->userq_funcs[AMDGPU_HW_IP_DMA] = &userq_mes_funcs;
 #endif
 
 	return r;
-- 
2.48.1

