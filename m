Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05018E6917C
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Nov 2024 16:27:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AF8310EC08;
	Fri, 22 Nov 2024 16:27:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Xvzp5yUM";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EFB110EC08
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Nov 2024 16:27:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RbZ347tX6G1WqN0kvsLGtG3PUXm2ZozdbIHRmbsqQDCmCueDxqBx6Vr1VV6lXCzVttOyRo0nrIorsooEamo+VophZrvgjZAS8grGJ9x2VmWvOz0jGYTY01DyFf284ecmK2gRuCAvHnxdZXx1knTgp/TOdDey28+UvaZh0iweo8Z82fOQC45mZfwtR4ctpeNpkmdJgravV5m0j7tRYZbMN+mQETMazEr44bfbukWdvou9hG2GSZDYtAUUN8tPWdHrfF+70QAV9E5gbwbErhe2jX5J9u2vV2e2TDi8uIWQsrby6eFnmMO11JOc7ce4WjHB9CSVk+BGcRM2AOCY6SQNwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ufX4ttw51HwNF7j8mUcES9xOI+6U4X9jZChEugYzhfg=;
 b=Elp2fTjl8pVFnNYLKZR4GwdeAKlFYxnBwKpG2mShDFughR7I5w4sxCf0KPZo/2wBVR01qY8xJ7IJx6VBBk+5O4DjsyQHBmtWT/ahBuasNC9XwFosIHf+IPu/xcg2yVO+iwIghcuUtJqDWunJJTsEMPsLquqinvujCIHJbRShLTp9XiBM9C8sRZ5XIyEWJ6Vp5zK3zBDs4a1CZ0e2GUtSk04iGQzFH/BAOJ/kF1qe2sjh/dg7sP2CY4obo3WU6kmyDD6c0sJxD9v1pi5d6XJTOnSZM1rzV6RQqSJtlnmYsK34D9i2LIuESrNrbg7MciwBnS1Gs9HAtbxq1Aeqds1pDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ufX4ttw51HwNF7j8mUcES9xOI+6U4X9jZChEugYzhfg=;
 b=Xvzp5yUMPiqK86IIYP0l4OZdmbE8OQsOgHlNcFmHjpeLTGRT+uRaAZKotmeGuSlBOXEaItPLjFYSXHkxkJIPJccZS8wDA4K0zyhCsSwQjTqFXjGLRzjdnu2GIuZQJkWyi7LQv7F8jtDMHWHs6UtN4kjsLbEIua6F+M2+U5Dxz1s=
Received: from BY1P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::11)
 by SA0PR12MB7075.namprd12.prod.outlook.com (2603:10b6:806:2d5::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.17; Fri, 22 Nov
 2024 16:27:17 +0000
Received: from SJ1PEPF00001CDC.namprd05.prod.outlook.com
 (2603:10b6:a03:59d:cafe::e8) by BY1P220CA0011.outlook.office365.com
 (2603:10b6:a03:59d::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.25 via Frontend
 Transport; Fri, 22 Nov 2024 16:27:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 SJ1PEPF00001CDC.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Fri, 22 Nov 2024 16:27:17 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Nov
 2024 10:27:16 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, David Belanger
 <david.belanger@amd.com>
Subject: [PATCH 1/5] drm/amdgpu/hdp4.0: do a posting read when flushing HDP
Date: Fri, 22 Nov 2024 11:26:53 -0500
Message-ID: <20241122162657.1056489-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDC:EE_|SA0PR12MB7075:EE_
X-MS-Office365-Filtering-Correlation-Id: 01f8fa34-f4c1-4ab7-9403-08dd0b1287f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+GxivXJB81LdoijDt+ct56YjGv9E891xVd7EVM07+AynUgL2bQFSR9zAcFov?=
 =?us-ascii?Q?Zd4xhWpioy/aPXYdVc+zq25t3rsuZdAuetuMu9CbdKtMLvTakWXJ0KUPwd/6?=
 =?us-ascii?Q?SYj89hwPforZ1bler+2r+MvzTIYmzL35AZ0oI72or30edONyZauuX6nwnwL+?=
 =?us-ascii?Q?ewwf2Xyeg3jYbAqcXG5JpIKuT9ySFKd0KzwrpBIrIYSy3xEJPjLY0IIvwDFL?=
 =?us-ascii?Q?9BCazK30h30YMftp3/a9Ji8rPQyXSPgHEVlNXpObcDnEzKFDc2Q+pWer0vMg?=
 =?us-ascii?Q?h7ytPEoM18SCtzL3Iyvy0/9foP+YtnZi74xDymITkggYqvRa4wmeKL8y2C9t?=
 =?us-ascii?Q?pQ+A409+nqswhd2sN2lDyzxIotiZdWKusgMlctPa+cgJgnNfOHImpROI9gxD?=
 =?us-ascii?Q?cd8aOur3K9aM4rXMfm6srcxa0GASOBNa0tA/DavdadoUpl8ws4bBhoUBqbO+?=
 =?us-ascii?Q?AyVKyq2WiPj6GiLZX4iCDLFXH7WupPfusJi5o8QB+QeeHdcyttrBVApMd7b8?=
 =?us-ascii?Q?OzTDr77HU9bkVzIj5AwXwZvIDuNB6Oij837rR/dNwQ14urz7hZHsw7Z26xk1?=
 =?us-ascii?Q?vWAJRI4mgKpduGr6pOZOyG8vfs92wt2vUwaY+xjWsdR7T6HYfxziS23/WU3B?=
 =?us-ascii?Q?oCJch094pNmt5S/HLdM3BjdcxdT4FJXhveM+YNNA2mWjvr8XHcQk65xKxPG3?=
 =?us-ascii?Q?L+8RMkAaBYmXwV6sb2xSHcCNwu8H5ARANONx+kVDCG3VIRIzncX9mhztWoPw?=
 =?us-ascii?Q?//fYqdV/s1PLIyEu2Fenln3UXevE941sP917LXCwICiFKkjmzcKLf9l6e5Yo?=
 =?us-ascii?Q?l08bIHrVYiGrXmbhtnIfWSPdQZ4fFZ9rdMQcIYACDYBsonfW7dYmRe+c9Xkl?=
 =?us-ascii?Q?Xlz3yrHFMFbjE5bFF6MRrrZINZic+JiLBGrz4jqdmLkHw1i7HDO3yrH8I/Tr?=
 =?us-ascii?Q?NWCn4zKAVLo0uYgh0z83E1fQu/EJi6xtbiwHuff9nZLNgTfLQsWjtgbqoyOD?=
 =?us-ascii?Q?ktphCKQpwlhtiDDvBv4A+IQbjkElDF42It1mLcJ6WDRfClhEo3zZyx3SsaHn?=
 =?us-ascii?Q?pIF2ah2TAhRWt0WeUHjsDc2d0XAlOdjMNQOSV2OeorqNkfIA9hm7Avvbqel3?=
 =?us-ascii?Q?4P8bIbwExOkRsYrCWFsfyC5BmV3V+udltP2B0M+tgvFRjsDLdetQo8lB78d1?=
 =?us-ascii?Q?kQfcxu71WqgPcVDshefS9Hrez4Yne7jABiiVrYn+LklLje41VIFLcib7wk/A?=
 =?us-ascii?Q?mlESgCJ51vTfUQjKdMTh0g0qM1M5IQXB639qqzdiESXmP6e0NabGePKdgdzG?=
 =?us-ascii?Q?5xa395CsLs7FLDWhG7WqES08vXEiOufkYd9n9d1T4mzkE2n/R1rZtTPX8uu9?=
 =?us-ascii?Q?QkPHu99WXEw3dOTLp/JUC0oH8elOyGbq32bgJZ5jnp50pC1rybwwbrWXtCtq?=
 =?us-ascii?Q?w+x7sz9D94C2+IaHmetagP+uuvXhXYW8?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 16:27:17.3160 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01f8fa34-f4c1-4ab7-9403-08dd0b1287f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7075
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

Need to read back to make sure the write goes through.

Cc: David Belanger <david.belanger@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
index e019249883fb..194026e9be33 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
@@ -40,10 +40,12 @@
 static void hdp_v4_0_flush_hdp(struct amdgpu_device *adev,
 				struct amdgpu_ring *ring)
 {
-	if (!ring || !ring->funcs->emit_wreg)
+	if (!ring || !ring->funcs->emit_wreg) {
 		WREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
-	else
+		RREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2);
+	} else {
 		amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
+	}
 }
 
 static void hdp_v4_0_invalidate_hdp(struct amdgpu_device *adev,
@@ -54,11 +56,13 @@ static void hdp_v4_0_invalidate_hdp(struct amdgpu_device *adev,
 	    amdgpu_ip_version(adev, HDP_HWIP, 0) == IP_VERSION(4, 4, 5))
 		return;
 
-	if (!ring || !ring->funcs->emit_wreg)
+	if (!ring || !ring->funcs->emit_wreg) {
 		WREG32_SOC15_NO_KIQ(HDP, 0, mmHDP_READ_CACHE_INVALIDATE, 1);
-	else
+		RREG32_SOC15_NO_KIQ(HDP, 0, mmHDP_READ_CACHE_INVALIDATE);
+	} else {
 		amdgpu_ring_emit_wreg(ring, SOC15_REG_OFFSET(
 			HDP, 0, mmHDP_READ_CACHE_INVALIDATE), 1);
+	}
 }
 
 static void hdp_v4_0_query_ras_error_count(struct amdgpu_device *adev,
-- 
2.47.0

