Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF8BDC5DF93
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 16:04:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C10610F336;
	Fri, 21 Aug 2026 16:04:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zF+9MJco";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011065.outbound.protection.outlook.com
 [40.93.194.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C74BF10F336
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 16:04:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wmGn0jdY5YNj92hISNYXkMHFgVeIzQzCISeeVgK3tz7WgLqKTM/RBGWPM7zdETWf7ncHIEkMLvxczI/+BxCDv+s+xQmAD/urpHCUyE/G6mg8SEz8gec4WEvjwW/FvJPjcqpqIeeU0FFWv6Gm6VRu50uGt8tWlePWTftXBxuds2yehjkALB1XfNYHrPABIZJq7ZJVGnIaJ0uUzfs41ujGblylousrUg7KaE+HjqPctjGDEOe+KK2Z8AtX4JElvcHFX2H8MWEKFKwDJFjD5hwhahjHaJJdrJQOhj3vHLb+cbB51QSqwUYSmknaJFaaBnuQuOEGxtG7J4JjgOKBAu4b6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BESAICj1i5q7aUGjC9ywiNzz32zb3/qLLVcM0Th0A9U=;
 b=acsIM0Yqo5/WStB3uTFZSUwBd2bdnwHgG7LzEWjlmjoNn/VT8aX3b0Ixf1VqwdxgZRC2xLopjWoBgSPAE9Nnn2dBmy0TP46Arrg9ktycxoEbbAo9zWyGq7oFYbbZZpXru+uvzOH+sktnkoJvkVrkzrPzuLiDR8TqoQEyvaX6Y27PSOLDq6SnirdNX26l6gmJ5xkfUFCrdebGRp67I/kpdZwieynMapw0HMFCRGTdOXHw1vLC/4C58xFzVn2ZUoSOrOoTI64UUh+mVYVM6tNuLbBrS1gmrjfJvEroNyHNYe4F+FmAga0GkB1sqkv/XO3vYKyfuYSsgiLEndaxPNKW5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BESAICj1i5q7aUGjC9ywiNzz32zb3/qLLVcM0Th0A9U=;
 b=zF+9MJco1nPhQsmiPSd+JBTpUonf91uIs3HEqm2YUnewYqW+KPgKNV1EVPlTFpB3C/YZz9boopOg54E5ecYzjaKyyIP6p2q9qEENwXstpAGElase2ibh8iugsn2ZXz9FlEPYy+ml358kJj3TuyjeCp6x8of1hMXdRVyf7OHjaOs=
Received: from SJ0PR13CA0191.namprd13.prod.outlook.com (2603:10b6:a03:2c3::16)
 by MN0PR12MB5763.namprd12.prod.outlook.com (2603:10b6:208:376::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Fri, 21 Aug
 2026 16:04:53 +0000
Received: from CO1PEPF00012E5F.namprd05.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::96) by SJ0PR13CA0191.outlook.office365.com
 (2603:10b6:a03:2c3::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.4 via Frontend Transport; Fri, 21
 Aug 2026 16:04:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF00012E5F.mail.protection.outlook.com (10.167.249.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:04:51 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:04:50 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:04:50 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Philip Yang <Philip.Yang@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: LSDMA check PIO error status
Date: Fri, 21 Aug 2026 12:04:38 -0400
Message-ID: <20260821160438.751766-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821160438.751766-1-alexander.deucher@amd.com>
References: <20260821160438.751766-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E5F:EE_|MN0PR12MB5763:EE_
X-MS-Office365-Filtering-Correlation-Id: bf0d11d5-e733-4689-65bd-08deff9dee9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|36860700016|82310400026|11063799006|22082099003|18002099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: sPu9NXq1ZlRTzYrWIqM7KVynFPQBOJU2qsGARddzAnCvRZnTTLncmPzTWiy+mBSBDo1FsUkGf3gjNXe1e9GWD0x1wB/6OJAmY32LL0XnOn46IdTfBBXSvtpcIyUMp2+TzA1LWkL4ZEcFQ25QvzA+sWcupZped5wg9SmkCyqlR2mCsAbSovl20F61nhQd4Qa5RXcc7dtIM6MNGu163wKh6WCK3ZIiCUC8EBWjXzfBhPiwimq1t9DfIwovjNUzCv+QlrF1UhWO44yigcnbycaAFqjRV/YPOxmGAeuwA4Y+vJkc4ymNA8iBppMxR2NXfGIqVEQPeZE2CLIxhDpjCTMVWp5eAs3paD8TAKpWVXmJcHM/NR9fUn3Sw591cGYH/H21PeereAlP4BTB8mX89T7wIUyVQxzfYMwBuO10lPhJu0TNe4lvIx4r/kHkVP4T8FADzbWfOd7I9OYieboI1JNchcsCWZdIxgkB7908MtfpIzkr1aRp80cqPBAbksOOfOv6MB+d7zLZkB5TX7BMaDGm+6kDnU788RTxbz+OLbPryoc/ua+7o+T9eomqVAliJCyJVx3nvR7WiovCpLLHs7WAtHEEQ5vUg8ZwoSqsfqARD1IEYhwNhKuBrLcMVJAR5WdFJFlWxNvhkBB8MKkNSecqSH9h6/15MIH+9UogrvrfXaQLQfJLO3N89+JP9Zn1jG8u/cTUDUkm2n7wCD42pXSX0w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(11063799006)(22082099003)(18002099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cgGanhK/azQl431z3X5Jo3OVMKq2ZnjU3NtsE8kbA576t+/WfI+QVFuQ4jlvAKvkKVdopAz6AKtIp6+AEk++gobFh7qhB2z3+SuURPZ7mr7Sn339nhRl0/RgnZcm3OjBTPNdTeIxddfqBgrlrczOVvZhuNJRFPD9nsE/b8VgRQQFPiHmkFUsosEJSIMsk1NH9vvULpaLhD5FL5T3oCmSyU5n29TkMxmX6P5gyUS8NGp5NWeqswJmS1OaSYxxqfQr2xtQAlRWhFuKOjps0J0HeW0uCVFy7peL39wNvde4xKM6VP9/7k3y0JfFUFva4h9SvrT2HU11VzftbiscVPzbH/s6PpPDKsTxjBmOfBKZe/x8gE7eWfW3pZjQbm+OhLf/T5Y6bkYOE25V7oNrlfy6lmidC/pCXvOCN3LKjIhkSno/GgWJabAuOQm1zie57E6j
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:04:51.0809 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf0d11d5-e733-4689-65bd-08deff9dee9f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E5F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5763
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

From: Philip Yang <Philip.Yang@amd.com>

Check LSDMA PIO error status bits after each transfer completes to
detect silent copy failures caused by issues such as IFoE (Infinity
Fabric over Ethernet) errors.

The following error conditions are checked:
- Write return NACK / general error
- Read return NACK / general error
- Invalid address
- Zero count
- DRAM ECC error

Log the error via dev_warn() and clear only the set error bits
(write-1-to-clear) so that subsequent transfers can proceed once the
underlying issue is resolved.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/lsdma_v7_1.c | 27 ++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/lsdma_v7_1.c b/drivers/gpu/drm/amd/amdgpu/lsdma_v7_1.c
index d93a0e65ce7de..fa739b0e9ddfb 100644
--- a/drivers/gpu/drm/amd/amdgpu/lsdma_v7_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/lsdma_v7_1.c
@@ -31,9 +31,34 @@
 
 static int lsdma_v7_1_wait_pio_status(struct amdgpu_device *adev)
 {
-	return amdgpu_lsdma_wait_for(adev, SOC15_REG_OFFSET(LSDMA, 0, regLSDMA_PIO_STATUS),
+	u32 error_mask;
+	u32 reg;
+	int r;
+
+	r = amdgpu_lsdma_wait_for(adev, SOC15_REG_OFFSET(LSDMA, 0, regLSDMA_PIO_STATUS),
 			LSDMA_PIO_STATUS__PIO_IDLE_MASK | LSDMA_PIO_STATUS__PIO_FIFO_EMPTY_MASK,
 			LSDMA_PIO_STATUS__PIO_IDLE_MASK | LSDMA_PIO_STATUS__PIO_FIFO_EMPTY_MASK);
+	if (r)
+		return r;
+
+	error_mask = LSDMA_PIO_STATUS__ERROR_WRRET_NACK_GEN_ERR_MASK |
+		     LSDMA_PIO_STATUS__ERROR_RDRET_NACK_GEN_ERR_MASK |
+		     LSDMA_PIO_STATUS__ERROR_INVALID_ADDR_MASK |
+		     LSDMA_PIO_STATUS__ERROR_ZERO_COUNT_MASK |
+		     LSDMA_PIO_STATUS__ERROR_DRAM_ECC_MASK;
+
+	reg = RREG32(SOC15_REG_OFFSET(LSDMA, 0, regLSDMA_PIO_STATUS));
+	if (reg & error_mask) {
+		dev_warn(adev->dev, "LSDMA PIO error status bits 0x%x\n", reg & error_mask);
+
+		/*
+		 * write 1 to clear only the set lsdma error status bits
+		 */
+		WREG32(SOC15_REG_OFFSET(LSDMA, 0, regLSDMA_PIO_STATUS), reg & error_mask);
+		return -EIO;
+	}
+
+	return 0;
 }
 
 static int lsdma_v7_1_copy_mem(struct amdgpu_device *adev,
-- 
2.55.0

