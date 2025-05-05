Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C30FCC3ABB0
	for <amd-gfx@archiver.kernel.org>; Mon,  5 May 2025 13:05:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A259310E3FB;
	Mon,  5 May 2025 13:05:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1W812OfC";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2856F10E3DE
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 May 2025 13:05:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M+NImreAlPjmTvabq82a8lof1IOm0eVOYe1mW8WUVI8X6yKJLnPp4wDSmr2qudxDsosbgGqtNJMPNvR/8vYDHPpwrQBAUdJxLlccB63emdXFHCJsPbS5xhAvPZxdx3faCBneiwc6oe3WFntWSfjQIDYrnZZZ9+xpuvvTDy2WCYvRzPYUpTNBxn0Zpwo3AHm8HD9X9+iSbZQsnYBFk2AtmptfkA6De+2hTAWe3wSJ6v/quPc0oRingmZs5rFX+Op0L0qHcFGrCd1RsAAX+IQRzL9oB+0BziR3vrNljglLzzupt8XMqMs6vPkwh3Z1sjiUoD+NPv/7yS7WfIFBbe54hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NU2/TGpg8RIQs+Vq4a1K+IaAtjKXryWDUwW8UqU1lpY=;
 b=bYKbn9QikQJSS7lmQWKo6DXcFO2JYGPmlHqgLJBwJIrTh9LQkFMYlq/Uw0uRiKgGUpuu4ohUORMrLDSKKnO+nmNHWeSJHPfN1ruijfIjbKzQGo1qlrwaxkNtYWrPiTPxbCMkig8RGKdAvs1bm+UeeZLa2cdx0vJnUv+AA4LtckBqeanX1+nKnNjaRDEydOjGCesgJKoplF1KgTn/SpUMdIHyR6hgcznNtCO5ITWNQCRtvK+tFhwYob6A/r5ldk9B+91587UmQ1emUF7ZRIt5w6RdAeyTfiXDeZ77whC+wo46TGmkjkY+0u/AWD5CZ00jxTfzhnpVAWkFQyV4DrXecA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NU2/TGpg8RIQs+Vq4a1K+IaAtjKXryWDUwW8UqU1lpY=;
 b=1W812OfC5cExH2DRzRS8ewQy4RMxAwSi+I+bWDCCLhF6sxDw4t1bG2QI+7Pm7ChlcW4NNZ0VuchP9WpoCiOKs1wtLnxrT/Yv5kyRjMw+SuC8sigOmWEBjNWpouWNOXRVeTwoCNFLC3YS9yP5tAiTc21nDG7ggvauT8FSVvmRNuY=
Received: from CH2PR18CA0025.namprd18.prod.outlook.com (2603:10b6:610:4f::35)
 by SA3PR12MB7859.namprd12.prod.outlook.com (2603:10b6:806:305::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Mon, 5 May
 2025 13:05:17 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:610:4f:cafe::7e) by CH2PR18CA0025.outlook.office365.com
 (2603:10b6:610:4f::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.24 via Frontend Transport; Mon,
 5 May 2025 13:05:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Mon, 5 May 2025 13:05:17 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 5 May
 2025 08:05:15 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Alexey Klimov
 <alexey.klimov@linaro.org>
Subject: [PATCH 4/7] drm/amdgpu/hdp5.2: use memcfg register to post the write
 for HDP flush
Date: Mon, 5 May 2025 09:04:56 -0400
Message-ID: <20250505130459.1985637-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250505130459.1985637-1-alexander.deucher@amd.com>
References: <20250505130459.1985637-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|SA3PR12MB7859:EE_
X-MS-Office365-Filtering-Correlation-Id: 16710563-8b72-4903-72dd-08dd8bd57b6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?N2NjokGpiAJBollPkgU7xzCD1eUrAK+nzm5g1GI3ILruUPllQq02+8s3sYEL?=
 =?us-ascii?Q?LSGOb8tCUcCZqdqabPatGYyzPGtcp/ouyNyoQm4BedPFISVHc9kq3zz+ZGHd?=
 =?us-ascii?Q?wPGiqWzOoESyHPsLp55ZnWamBlylMHP/aQQ5x+KDiXZdV7+mn7ZcsQkOos08?=
 =?us-ascii?Q?RRo482rolZ8ZQ+fXp5DlPb9omxIez2Xrfuc76PHI+4xpZKjMT3kWvDo6uk1s?=
 =?us-ascii?Q?u+xJ7Mi67gmDCMMIiIAgxJY2QFuhrAGKvXZeOxiQZ+0Uq9bosbfsD7SZ4aqo?=
 =?us-ascii?Q?SBmpmlPvLWC2uH3PNoXnBXWv3o8wYgG8lU3kOi4+70LkGKQwIj57L9cWu7Mc?=
 =?us-ascii?Q?mEer3yXtUYn5KLbdA7InNSB0xeDH0bqGoEwRf8/VTb8kDDyI+1qSZy0cTK0P?=
 =?us-ascii?Q?VQr6R8ufPsHZNtmnyghyNeJLAc7jmahyJGOGsgXpu4GZppBoIxKCRmcr56lw?=
 =?us-ascii?Q?ymPBMmPKdP8wuD0mOfXmSyAMQyM5iI9W+ypeQvmtZR2h/z3xiGN7pnGS125v?=
 =?us-ascii?Q?nYMFafSMoijAjeqgEf7bx5fLDYVoQY9paJc5cmSpO5kqOqdTTfmdLVREdURN?=
 =?us-ascii?Q?sjcU7UUa9wz1ebMloI4kv2QdKLbkf37acq1thp2kJ5B7kJ3YWqGaGC02L1J6?=
 =?us-ascii?Q?sXnHjpUEeUuLCHzpurMIKIP9pvmTq7IuFVVTTdV4A3DumluGnAyazI0geVXj?=
 =?us-ascii?Q?Jz4OgzQ2Dhhfm239jJLDmWbPMm1ycSFEsr809f7MXbqvIcDToV86IEA7m3wO?=
 =?us-ascii?Q?lYEuctN9Z81obib/BOoNZDK6O7n5E7cy7tmldczZ63sdeYqa9gR+WsfluTLa?=
 =?us-ascii?Q?/1X/5HLJnxYEYEGL+80sO/x3lde/rxEGRUtHMhN24gkb3Sbdya/xYwbvvHLr?=
 =?us-ascii?Q?pRtpob+6V3taCNAsVmklmOrw/m6TgQ/SNRYFkmue29f2ALn/fAPZlWFWyilh?=
 =?us-ascii?Q?YW8YCy9IqMXQcQhKX8RDGrDbL80kX16OAwISeQfTspS/IdxyltShHunkxnF0?=
 =?us-ascii?Q?QQw5ROu4+jyD/d9v9bRGzQDZI2ycD5ZPHWkqNY7tatBy80FWsaYbYvbZKUPL?=
 =?us-ascii?Q?unqHP7E0pPhJa40/bsDoJLO7Mp/OPAPeEuZY3TBBI1Krv1kbR/OFpyUvAEJ9?=
 =?us-ascii?Q?v2HbF0IFk8MClQCZ5F0hwMxw/dBSrQC+UuL1noDd36kvYU3WP+z/vNjeF9nE?=
 =?us-ascii?Q?/S5Dmo4/KjwWj/pKvlIN5jzWiFEuqzvWMC/VDxOHeYqsxkOg1KGMzEzouXEP?=
 =?us-ascii?Q?bibzoMVuy7TTbacIaQPO5ZIin+S9rSPTA25UVoKFqlkVdmSSROuoFX3AEnw2?=
 =?us-ascii?Q?TwWTrrc+KKYA5hvhrVTeHjgssRpciNkd9qm7+eXr5VV6X37pICiCEkTO5Gdm?=
 =?us-ascii?Q?RkHSwOxgGGene073YDjLNZUAqQ74NU+AN0RfqlL1IzQzGe/tYkJOU+EB0txv?=
 =?us-ascii?Q?y81P8qFVx92P7Pn8g1nxp8/eu9PzSAJm+K+CoImZfLPD3YnQ+NmeAw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 13:05:17.0499 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16710563-8b72-4903-72dd-08dd8bd57b6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7859
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

Reading back the remapped HDP flush register seems to cause
problems on some platforms. All we need is a read, so read back
the memcfg register.

Fixes: f756dbac1ce1 ("drm/amdgpu/hdp5.2: do a posting read when flushing HDP")
Reported-by: Alexey Klimov <alexey.klimov@linaro.org>
Link: https://lists.freedesktop.org/archives/amd-gfx/2025-April/123150.html
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4119
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3908
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/hdp_v5_2.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v5_2.c b/drivers/gpu/drm/amd/amdgpu/hdp_v5_2.c
index fcb8dd2876bcc..40940b4ab4007 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v5_2.c
@@ -33,7 +33,17 @@ static void hdp_v5_2_flush_hdp(struct amdgpu_device *adev,
 	if (!ring || !ring->funcs->emit_wreg) {
 		WREG32_NO_KIQ((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2,
 			0);
-		RREG32_NO_KIQ((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2);
+		if (amdgpu_sriov_vf(adev)) {
+			/* this is fine because SR_IOV doesn't remap the register */
+			RREG32_NO_KIQ((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2);
+		} else {
+			/* We just need to read back a register to post the write.
+			 * Reading back the remapped register causes problems on
+			 * some platforms so just read back the memory size register.
+			 */
+			if (adev->nbio.funcs->get_memsize)
+				adev->nbio.funcs->get_memsize(adev);
+		}
 	} else {
 		amdgpu_ring_emit_wreg(ring,
 			(adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2,
-- 
2.49.0

