Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 942511125858
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2026 17:08:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3369710E088;
	Wed, 11 Mar 2026 17:08:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KrkzrB8y";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010037.outbound.protection.outlook.com [52.101.56.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83E8610E088
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2026 17:08:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MHXz+sbH5BByYA1fO5Zp/gA7cvuRAwDNPH5F+7eGISrSrnvXNIba6GdqOBTUWqxA9AOFXGNhSvTkgqtbxwTW96jNuXxX0wJKIpG40o1jaQRet7eTxg6YcdxkTs+W3AYNAbL2zfqhSr1FVCIWdaGaYux7MDs1i8veijdwaBj8SRZfP4qp2S48PrC8qe0yUQ/LCpxfG/kR8hLpSAFiCSFbhiz8CN6P1gclLg4VAEVAi9KrYr3GlZEB4qN2Fcffjuv12CZCqYdlwCcH2gw67CbnPvMQTPPYDkNTMoBz2eThqVB0+YHAPrpQUGUxQ/BmVbcGo+wSL3+ZGp0+mgGflNMUcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j9HFKtGyrUsNPPFIwvIow72BVDeM+ZY0xR45mGJlwCo=;
 b=cTfsU7GzSok2Jf1IjJdeReMjm9U8/c02NrhLDimphi3tV3+F8e/MokeeKkj6oUUKdtjTTq6B2bP0k3LIQ05ZJNCnwNERA//raK6mT3t0UCw/dxTk16wgddCWFlM7Xkexi4Q5W3ehZP0EmVxhHidUdbombGpSn9auFezHQp1xzCRJu+Jb4Wtd/GU1vtFHlu4aC0qCxDDce3egsElRPW+aI9ocQDzIapeeJ4OgQXOW+X5eUcVQZkNQYgpXEltfa0TTmCvXWzOGw8gSnlvB34qcVMKsm3gfga7Zz3L+ygDf1k7oKim/4kBt7s8MA/E6yV73Gu4XuNAOYVGR1dbLHBd+rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9HFKtGyrUsNPPFIwvIow72BVDeM+ZY0xR45mGJlwCo=;
 b=KrkzrB8yfmG1EnVvtisl9DatYvj17kXj9EGtaXHRWENz0L8EnmOaYe+BKyqIypyZJrsX48cZ7M1s6celG1dxPr94aJQyXjrEQa9Y6Fx6bdh6h0xhEmUkfmEDmF7kbatSGbJ8k5MnOFiBXkW7O16SK9BIE53AyochXpTNOXPD6FQ=
Received: from MN2PR16CA0061.namprd16.prod.outlook.com (2603:10b6:208:234::30)
 by SN7PR12MB7300.namprd12.prod.outlook.com (2603:10b6:806:298::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 17:08:41 +0000
Received: from BN3PEPF0000B06B.namprd21.prod.outlook.com
 (2603:10b6:208:234:cafe::bc) by MN2PR16CA0061.outlook.office365.com
 (2603:10b6:208:234::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.26 via Frontend Transport; Wed,
 11 Mar 2026 17:08:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06B.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.1 via Frontend Transport; Wed, 11 Mar 2026 17:08:40 +0000
Received: from STXH3-MAPLE-10.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 11 Mar
 2026 12:08:40 -0500
From: Pratap Nirujogi <pratap.nirujogi@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <mlimonci@amd.com>,
 <alexander.deucher@amd.com>, <christian.koenig@amd.com>
CC: <rafael.j.wysocki@intel.com>, <benjamin.chan@amd.com>, <bin.du@amd.com>,
 <king.li@amd.com>, Pratap Nirujogi <pratap.nirujogi@amd.com>, Bin Du
 <Bin.Du@amd.com>
Subject: [PATCH v2] drm/amdgpu: Fix ISP segfault issue in kernel v7.0
Date: Wed, 11 Mar 2026 13:07:42 -0400
Message-ID: <20260311170828.3108696-1-pratap.nirujogi@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06B:EE_|SN7PR12MB7300:EE_
X-MS-Office365-Filtering-Correlation-Id: 548c708b-4266-4d1f-71ae-08de7f90d80b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: jEXVSmjLN00nCr9bIQMwogagBAVq+xe8MbNnr9Q7BXUoWIbAYihSP4dfY6OvEB0zi9ECjxZfZrh8ThbNEvjn1DHnCNtW99DEIPnytbTuQE3v15VJgbflLyqK2B+9m/Ger5XVeEhgH5P/mS9vUgf0rtTPHDmxq9TzK6GBFk+v15Bb+keQ8R5K1GmghTiGZCREbqf6e5baQxp1DMP8rXRYHWEj3eaJVOLnA4kfyLKpww0JVi6QltUqjb2Py28Da++THmYPgl9rYkL+RNW9EFdK8La0dKuAv8BcH4IcPI/D/yWcP3nufvyQ6mFfxzaVTTjsBT+1OaA8enqgjaS5JJ3DxTxJvqPDRNbPKMM0y0g51CBFqsz2Y7mWqYfHhLDna8n9bzoBERBNFwMTWIw2iUjBnZcdHMnC+6+IuMKwMo/7iO83NyLf9ztqJfC95nq+VmZocEos13nP7M8CNvaWcj08EUEFBPBKukcvRgbPFHNimypmJv82zcxPNGHCZr3pmDvpc3T2oNoQw0ADmBOHuawJHBnQToWM+GF7fapBLLZ5hAS5vb19FOCRlMzy18Qg4yDt0lfqMg7FpPBqPmUiP84MQ9+mLKvWsnVUh32upGvT+AFnoOe5kQRn663yPxI/38zXVQlYie/YG3TISr7kx/q6bMnYOr+k24NT7KWQbRuy5GAvP6QTuDwQtyrXc2eGQB3Hr2a32NpUmIbaEPTbiBPw8q3gHF7n76+6akqVw4O4Rv1TZEYVST0uEI6llshnm1d7N819ieVhLVcEOqbiU6Nfdw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XNaBPvChaJPtlgeTMMPLvMXLNea8QO6VAoHV/PNXOLiYWprMh6dcFIrD7gp2bqo6JawgZs1Pm+NRNI6/N/zOf1ite1hotdLSAuGCsJF48x8q7Qp631WOnmc+IGsqS5igGP0lr5vdo639VKrmVH5S9VfULIiYyQXuF4naMPaLSyH8/SmacrJnjpzYm1VuDDkU9y94wESnXC8zes6DQDdwu3lSLsVgo5jHkgkJSpPXRxcBIi0u5MPdLVSEt3vp9D01zpwfgH+Z9xNP+WZHBOgIgg1xsc2sITRESRZsC6v+9k1e/B9IUD80H6SoxrkBgCqIXO5eFeA5/Bg+Nhnj0TQ6vKmFIrIpEWoyzYHBQIXqFaigeG+bnixNDiM8mAJdUvMp+PkpXCbmY0dhJmLn161aEOqaHDgA28/giw6vCJkhUJoaDDJP2N6VHD6u/RfMtDtN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 17:08:40.9406 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 548c708b-4266-4d1f-71ae-08de7f90d80b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7300
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

Add NULL pointer checks for dev->type before accessing
dev->type->name in ISP genpd add/remove functions to
prevent kernel crashes.

This regression was introduced in v7.0 as the wakeup sources
are registered using physical device instead of ACPI device.
This led to adding wakeup source device as the first child of
AMDGPU device without initializing dev-type variable, and
resulted in segfault when accessed it in the amdgpu isp driver.

Fixes: 057edc58aa59 ("ACPI: PM: Register wakeup sources under physical devices")
Suggested-by: Bin Du <Bin.Du@amd.com>
Signed-off-by: Bin Du <Bin.Du@amd.com>
Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
---
Changes v1 -> v2:

- Fix checkpatch warnings
- Use Suggested-by tag instead of Co-developed-by

 drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
index b3590b33cab9e..485ecdec96184 100644
--- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
@@ -129,7 +129,7 @@ static int isp_genpd_add_device(struct device *dev, void *data)
 	if (!pdev)
 		return -EINVAL;
 
-	if (!dev->type->name) {
+	if (!dev->type || !dev->type->name) {
 		drm_dbg(&adev->ddev, "Invalid device type to add\n");
 		goto exit;
 	}
@@ -165,7 +165,7 @@ static int isp_genpd_remove_device(struct device *dev, void *data)
 	if (!pdev)
 		return -EINVAL;
 
-	if (!dev->type->name) {
+	if (!dev->type || !dev->type->name) {
 		drm_dbg(&adev->ddev, "Invalid device type to remove\n");
 		goto exit;
 	}
-- 
2.43.0

