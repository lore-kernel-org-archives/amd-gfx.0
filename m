Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF152D711CC
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Dec 2025 22:42:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DBAA10EBD9;
	Thu, 18 Dec 2025 22:42:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Qi+bsGws";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010015.outbound.protection.outlook.com [52.101.46.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 993E810EBD9
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Dec 2025 22:42:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cy1oJRUKSXYH5rvvo/iiGsWoJpTHT5LE9O4jGoikxf7V2LUqjbTsrZFwjNR5cHI6MoKzHuV2vtSXFpkEEqA0ULOOYeLwFiWGriS7fOwQgXRK0GsyBZ3bp/PpJKnO2Z4xYg17192PxI08BtAzYitnQsWSvtTGXOV9brLJ6l4E7ioIOiQQhlpkUEsrcS9Ied9ELvJVgtgtIRC7hJY5ccFxaJUqBGXJTW2xy8SivHjSEwuug0za2qfMQH68p+7pqRvAw5d4pWzNzL9w4ra3p/MZqx+pDbH52Pkn2a9XC1992or0vP6Qt4h76frWox8E5thLnN8XItlc/fvY5qTZYpiJVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M0yXBK3jqKAe2y33qzpaMcdy5b2uY0b+JxBNyj9mRAg=;
 b=gP/tNah7K9lM2Rc3y5kZXB4U7r0qRbNLteFjfODqkUx7UsKQuT70g0LXE+KUPoWxTkBZP6bpwEMEMVgk/DcN/1nHVFFT+RLA+gWeH8Xef/cvcL5+mUdOjv02Ib/RqVwGJVhWlLuBHaEAmKVL6d/6SrQYOtgYBvxuEY32OftIvp+lCwiH82q8Fr3RCBCteOb6WO15UeKrXBm0Y+xTjdRx8LHpLMPJbQOCNypF3qpDaQi7Mpflt3Jukxy27b9rcrILR4bdWmuLgVSUy3hgCIelaLrmWAAA+2MqZKOAvl/5rz/zFpoeBFW/iEX4gCC00F64CiiCNSyWBcYuHR7SXh6oEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0yXBK3jqKAe2y33qzpaMcdy5b2uY0b+JxBNyj9mRAg=;
 b=Qi+bsGwsa4BImhWnvskuwTqDWTHmmzFuTlKwF3tse97WeU3YcxhnrzbfHcZqpsPvFDbvGcd0v/7DXx2UnzOF3emEnae71vYv5nKteAw8VaJNEwhQu61o5of92fGYL4HdBXF8sX8Ggx9cthFlZWhCdkNHO8Y6YYmPYy9oXODxSPY=
Received: from MW4PR04CA0092.namprd04.prod.outlook.com (2603:10b6:303:83::7)
 by BN7PPFABD533732.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6df) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.7; Thu, 18 Dec
 2025 22:41:56 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:303:83:cafe::f8) by MW4PR04CA0092.outlook.office365.com
 (2603:10b6:303:83::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.8 via Frontend Transport; Thu,
 18 Dec 2025 22:41:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Thu, 18 Dec 2025 22:41:56 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Dec
 2025 16:41:54 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/7] drm/amdgpu: use dma_fence_get_status() for adapter reset
Date: Thu, 18 Dec 2025 17:41:37 -0500
Message-ID: <20251218224141.5841-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251218224141.5841-1-alexander.deucher@amd.com>
References: <20251218224141.5841-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|BN7PPFABD533732:EE_
X-MS-Office365-Filtering-Correlation-Id: a3133a13-e62a-4ce7-fe17-08de3e86a5cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xkRmp60I65SdZLgC8NjHptgv4NzEKvka5rMCaUKTXPnb3gpffW5F4ZJ4jQwE?=
 =?us-ascii?Q?4ekKytSEtVSZXAea8g7lHwAblYQTAnwDSYFbSdYcozHwLgy3DTXrrHp9QCrW?=
 =?us-ascii?Q?aJzhqQ2KJ/dAHRsClcB/T+nHB+yTtpJja6NN6rpsbH+rm7UqhBXR0Uw0u9GD?=
 =?us-ascii?Q?V7risHf+M19vYFhC0DB7BDgGnJ1cKVhKS4swATF8fTp1PYa6Qgg1ReZWo49e?=
 =?us-ascii?Q?/0g8y5Ho1sYsaCBWF9gXCxB/MNUfI9PdBApIF+iQbLwbBCYtIYe2KeDxSPG3?=
 =?us-ascii?Q?Wg/FosfBhKQJd8pMlxdD5gONGzoX8XpGETXrobP1uYT+VLaF9bjhJ+Vy4Pbd?=
 =?us-ascii?Q?HF/1FElrf2Vo6N07FSPWOmgKbt0xj5LyvQw02Jqc2+kyGbGPp/DEQKFGTiDS?=
 =?us-ascii?Q?o+21RgQA4XvBLHQu+Hj7FcY2X79/Tufr0Yf52gtX24LcglWdizX9JROehRQz?=
 =?us-ascii?Q?8U2bCjBfH/Dmwmv1Vs0fysjE1XB84cSHMm4sKh7geL6LXd95GjC1tIM51HoZ?=
 =?us-ascii?Q?jqoyQRfmAk7wwrOCyQAMZFbUiI6veMQi8jyB6uL6866RnaqUSQ4fVYyVZof4?=
 =?us-ascii?Q?3j+5HP4gRbsoD+6deczv0pf6bFOTyt6bXDZC14O3lRLeU4tahi7rFOU49TV7?=
 =?us-ascii?Q?mxB++6XsN9evMIhnnlA32lYTHcY3dHjMy211KGWLou8SFJq8J5/1Xs1hykJF?=
 =?us-ascii?Q?e4SaK+q5fhnWY/tNLksexZ8pa6Ki0qiYiU+Mom+AbNeocryeMhaTu92/Kemb?=
 =?us-ascii?Q?TJJ+0kI1Y9lWEXPATXfVmQgEHD2/xWZvJYzKuS/HYv4bHUGQdy3EAMS6+91d?=
 =?us-ascii?Q?ve0OPzu4iarvh5iZHPkKfZZa4Xneu5EORM/fZsRnLrhBoSE1zSYDOQ8R+I5K?=
 =?us-ascii?Q?vXyRBNcqt8Gtv290lnu3PFPLJkUaTdF8WzxvXwzGmnlyWplneotPJlxMVFvU?=
 =?us-ascii?Q?ms3Me41GQKMKUBtdz4u9V9lQ1pbrOzMtAm9jVRVyureTe/5kU9szA1lk8JR4?=
 =?us-ascii?Q?AWv6+45tR3qMbniZARmHynSwvw7HFCr1X9ZGSUeZRNEWoDcKk/nClGZLGopu?=
 =?us-ascii?Q?m/ncFSn2JbCu/ckLQT9cBGduxzEy37UMFS8u18tsS1+KmrHdv922FdznD85v?=
 =?us-ascii?Q?amne0l9JQOpgByCPEYhzPDrrPXO0hoC3OvEpkFIfsLblQ9FtERgdwr4y0kxC?=
 =?us-ascii?Q?mW0bgorXWw2MDP0DLMjDSmmGMKcUJCF2h8xiVvC0SM/G3clAOiW3yRuvPJ/P?=
 =?us-ascii?Q?TbGjTd0w+vxM4jgh9DAQ12m+uXQcePVkebQ5l88nruB0zZ2JBFfT0Q0Nzqpd?=
 =?us-ascii?Q?h1+eXkK1IvwljF5Da/24wcYCBj8nZnwFc1YJNReTGkQ1FcHnTLLOHYyDsHmW?=
 =?us-ascii?Q?4s9fpXQShwMS7HPkMVHWi3W0f/xvXhEq3ifcOmynt5sy73AcnV/NTpnzZzHx?=
 =?us-ascii?Q?7mst2k3Kta5l6VIFl2M+GpelaVD1H7blxBQ4UK7LTzFo7Zg7zuL6TVq1/VxE?=
 =?us-ascii?Q?cfLQWwME5uW2neS6a825/qRayU9DlxXpg7WHyGQAONE2GA5erb8iPEwPLHm+?=
 =?us-ascii?Q?rU7G6ZNf68TPngAiOVA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 22:41:56.0135 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3133a13-e62a-4ce7-fe17-08de3e86a5cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFABD533732
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

We need to check if the fence was signaled without an
error as the per queue resets may have signalled the fence
while attempting to reset the queue.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index cd19a896dd4c4..198d1872b9247 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6367,7 +6367,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	 *
 	 * job->base holds a reference to parent fence
 	 */
-	if (job && dma_fence_is_signaled(&job->hw_fence->base)) {
+	if (job && (dma_fence_get_status(&job->hw_fence->base) > 0)) {
 		job_signaled = true;
 		dev_info(adev->dev, "Guilty job already signaled, skipping HW reset");
 		goto skip_hw_reset;
-- 
2.52.0

