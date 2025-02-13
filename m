Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5169FC021A4
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Feb 2025 05:48:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0370D10E9EA;
	Thu, 13 Feb 2025 05:48:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E/dZoUbI";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1FE710E9E8
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Feb 2025 05:48:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c7lCavbRNaDrxU92Okib5LCTNQo0FQ3RuBao0VcF7RMgGicuKVmVm/FEKzFIIS48N81iNut6gZDTzvf07hYWNY5z0LXlYYVg262N5p0c0zhMvrPxKcS63xf7kOcf3Z/WWGowJloL3roqBm8opvpi+MbJa/4JvOLinRXPqrlLvXK0agsYIyIjzU/VovYfhqIrOQHxbqcnT7zEYcZfv8SH9VW2e6Mvodn6OAe9mZ4t4O9gz7fGg0SavNWbPut7n3RVJ1ovxDVSn6niTehn5SI7Xka6mqBM5a6GFRDXKg2ITGdRKySKVTh5wkdqBent85vi/aJ7pQ3hEy2tw/31gDTAWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4xVDsR4lx21U4W6U2xjXB/yVY5OLhEC5Fw0yWTfgvB4=;
 b=tS0RNc1CuKebBbDvvccdyg7y0p680xly3bep2BDGz7JDYsxChl8gBMCqFu77c+T9YNRzBfRp3BsG/C96TLXLTdtZHt6aUEizMIOvhKPMLlYHZHCLmAQ2uQsNaZzLbxRy++H2jpbzNYceTjBj4AT3UukBAVqfS8Pw3MlkIWgd8venkNxIJUxet3bUxBGjXEZXZ70nbJnSTF1XkMKNckXTm0FtcFASMV8JYcB0/mpVYG6FIkdphs1IsmR6m3evz/wOeFhz7IMvGV8+glKKZ0QkIAWUKvikfhh7DiBwNaX3vx9g1NBruKoPFpPbnbYHaAnzYdzaiP1TXpuG498A2af3gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4xVDsR4lx21U4W6U2xjXB/yVY5OLhEC5Fw0yWTfgvB4=;
 b=E/dZoUbIhg8ps22pp3hXs9uhSvdXakYZuxJlaC4VKfrmqDdFKaLIxT3NedB5+l2WuDWNmepFuAUrnAJH1pPefAxoHctJNfmaP6Vuos8+B+gltiadgrRS0cKvPFrXaT/X0mCqzQjww3Wc96V42ANX38yP638NZskpSLj4+mREzXE=
Received: from MW4PR03CA0166.namprd03.prod.outlook.com (2603:10b6:303:8d::21)
 by SJ0PR12MB6687.namprd12.prod.outlook.com (2603:10b6:a03:47a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.23; Thu, 13 Feb
 2025 05:48:31 +0000
Received: from SN1PEPF000252A4.namprd05.prod.outlook.com
 (2603:10b6:303:8d:cafe::61) by MW4PR03CA0166.outlook.office365.com
 (2603:10b6:303:8d::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Thu,
 13 Feb 2025 05:48:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000252A4.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Thu, 13 Feb 2025 05:48:30 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Feb
 2025 23:48:30 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Feb
 2025 23:48:29 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 12 Feb 2025 23:48:17 -0600
From: <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>, Jonathan Kim
 <Jonathan.Kim@amd.com>, Jiadong Zhu <Jiadong.Zhu@amd.com>,
 "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v7 6/9] drm/amdgpu/sdma: Introduce is_guilty callbacks for
 sdma GFX and PAGE rings
Date: Thu, 13 Feb 2025 13:47:12 +0800
Message-ID: <20250213054715.3121445-6-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250213054715.3121445-1-jesse.zhang@amd.com>
References: <20250213054715.3121445-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A4:EE_|SJ0PR12MB6687:EE_
X-MS-Office365-Filtering-Correlation-Id: e8de85b5-5ec6-4a23-16d5-08dd4bf20bb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DYK/9qZN55MaxBImY3qUJDjX3EcsMeVtpha/IGuIrEzqkoH+LgFlIk1jF7uQ?=
 =?us-ascii?Q?VQL1JPq1cpqslrHhRhvDml4uQYIGsdrmOHDNWGa2M1Bq4C3v2L9Z9goEgbSC?=
 =?us-ascii?Q?o9lK1KkA20mC6oiZSAMgxIigswScB5vIf/cLOdy+mzD+nIUAvv8LcABvx4kR?=
 =?us-ascii?Q?Tw0tCwuDDF8Sd7WFT/da6pGJrFlFx0ZkU+s2vFzWGiwuLPCJehCLNHl7lTyx?=
 =?us-ascii?Q?huXn1OYBldSeXYQ9y5uNnWg1thr0RqDGMK2CVTVoxjPGDM/bcnG2zsMmHmwA?=
 =?us-ascii?Q?iiABWo4CazfDYOB0M8z6buZ8g1kwqINPHql4q1ZAjRxq0I6X9f9+MYr7Vgod?=
 =?us-ascii?Q?51W6TwsT37hHemzeua5dcbXt6/bWzRptZlvqKo3LyETRvWEftUd2SXKIHNlh?=
 =?us-ascii?Q?yO568zSmRJUGAO15BC04g3O1r/EdppHbbz3uVz8aRxqmKpQg8UYOp7pINXO+?=
 =?us-ascii?Q?N4kiJUIDODhYj502qREZ9L3Nj6obcRSQPQH1FnCwefn0NlVnwLFO/zdnq0jc?=
 =?us-ascii?Q?77Qy+BMTJjEI+K91eom0vjSLv5OSlNd85KQjjoPTa3mKjVAFgvGW8/NznQI1?=
 =?us-ascii?Q?ceIdynRgJ59V+kYCOh+xvz6kcO2Lqt/yO8Eq7zeMCQkH7Dz3HJ1prWjT2Mi9?=
 =?us-ascii?Q?5SVL61NzaqoWW7ZwLWiJUZ2mSs6sv9SzTc6k5WmEnp22c5ITFJq/3AV5l83q?=
 =?us-ascii?Q?94ovNxDEPqdrllUYXQCZqEHBqcHRC93YDG0myFsX922PVjO/JTvgLFfAnUoF?=
 =?us-ascii?Q?soTcEGVVZ+X10P8BXU5nxzbUfn+J81mLYmPsD7xwP7V+i8Ll6y5izioq82Jo?=
 =?us-ascii?Q?2x4KPnDaqj2r17RB5Gk9Iq/ssJjJhbKvniHeDZxNAGh96h0waEmkj50hUhrC?=
 =?us-ascii?Q?KjftbzUE4RoioZqYmk6MftXNkdrfz5NFbLPQSzgNAparHHUJLcqx0xxs1+zV?=
 =?us-ascii?Q?AVl8KLFCrAOOqTBPrrGaH5yLHnEa3HYGq4IJvukIU17ud8ZYFZFo08KYSBKY?=
 =?us-ascii?Q?rlyZ884niOuBVCtkp+ifqREldqVPtF+fG7TbpJq8tPZh+adXYbUedJliBeDr?=
 =?us-ascii?Q?EHY7IJr7xKztvogwfPNw8RmR8OCqQ5E1NnHX4u9ri4i98YYgEvrsUlxbfqLU?=
 =?us-ascii?Q?bOrTKxKSiDu0NiZMXxfW1XdqnP0Ly07fSeBNGrlGb17Uxk34TyvdRTOn1emf?=
 =?us-ascii?Q?Lg+lhZJ9otLA2bx9f2OTC7tBbV9jLwKteEUkWywop27mH+gmH8Lv1+wFYWaR?=
 =?us-ascii?Q?RYunz8EaF2Y4ig0BCSEFDypyL8rX5cM2DKXR2DVqFTuAQaCnGHa3iILe6QSN?=
 =?us-ascii?Q?KxlcXhXAziaU8Yw+e+ANP5kzfQL8gSqPTpsK9HPzgiybRwybx6ur05CxPNjl?=
 =?us-ascii?Q?q85DfPaaVhuXMczvw/slFVrokNlCfegLGLDgJQ8woiS3ml4pyCJ1Hsls8y0R?=
 =?us-ascii?Q?znUg16UUH+KAXq1Z1fjoEiXNKYApo9fp/QZFdE0HNby+3UQlS7bqjUG10wMV?=
 =?us-ascii?Q?GtINeELS6yGln3g=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 05:48:30.6322 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8de85b5-5ec6-4a23-16d5-08dd4bf20bb8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6687
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

From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>

This patch introduces the `is_guilty` callbacks for the GFX and PAGE rings.
These callbacks check if a ring is guilty of causing a timeout or error.

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 30 ++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 50a086264792..b6de4eaf6088 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1606,6 +1606,34 @@ static int sdma_v4_4_2_soft_reset(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
+static bool sdma_v4_4_2_is_queue_selected(struct amdgpu_device *adev, uint32_t instance_id, bool is_page_queue)
+{
+       uint32_t reg_offset = is_page_queue ? regSDMA_PAGE_CONTEXT_STATUS : regSDMA_GFX_CONTEXT_STATUS;
+       uint32_t context_status = RREG32(sdma_v4_4_2_get_reg_offset(adev, instance_id, reg_offset));
+
+       /* Check if the SELECTED bit is set */
+       return (context_status & SDMA_GFX_CONTEXT_STATUS__SELECTED_MASK) != 0;
+}
+
+static bool sdma_v4_4_2_ring_is_guilty(struct amdgpu_ring *ring)
+{
+       struct amdgpu_device *adev = ring->adev;
+       uint32_t instance_id = ring->me;
+
+       return sdma_v4_4_2_is_queue_selected(adev, instance_id, false);
+}
+
+static bool sdma_v4_4_2_page_ring_is_guilty(struct amdgpu_ring *ring)
+{
+       struct amdgpu_device *adev = ring->adev;
+       uint32_t instance_id = ring->me;
+
+       if (!adev->sdma.has_page_queue)
+               return false;
+
+       return sdma_v4_4_2_is_queue_selected(adev, instance_id, true);
+}
+
 static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 {
 	struct amdgpu_device *adev = ring->adev;
@@ -2055,6 +2083,7 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_ring_funcs = {
 	.emit_reg_wait = sdma_v4_4_2_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
 	.reset = sdma_v4_4_2_reset_queue,
+	.is_guilty = sdma_v4_4_2_ring_is_guilty,
 };
 
 static const struct amdgpu_ring_funcs sdma_v4_4_2_page_ring_funcs = {
@@ -2086,6 +2115,7 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_page_ring_funcs = {
 	.emit_wreg = sdma_v4_4_2_ring_emit_wreg,
 	.emit_reg_wait = sdma_v4_4_2_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.is_guilty = sdma_v4_4_2_page_ring_is_guilty,
 };
 
 static void sdma_v4_4_2_set_ring_funcs(struct amdgpu_device *adev)
-- 
2.25.1

