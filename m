Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6591C49EA1
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 15:01:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 922F310E870;
	Thu, 25 Jul 2024 15:01:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="riLJd3hc";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2061.outbound.protection.outlook.com [40.107.101.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31A6710E856
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 15:01:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s3o/0a4XUsAorZ9iP5414fG/767Q8Ylu8JM47HMFnYVOx3yeoz7kDk+8s1r3495mHKgK+0EkZ+Xk45WfW7m883sIRpEzL88JazQ6qOVYu6yXavdBwBnUdK20zY673/1ll7pw8lWtHI4oS6up5YlD28DwCYVJ/FkMnY4z+HDXcr7bJvkXzS+lkpa3Q3j2hrIASK4rIzzF/qmCRToq0Ks9l4zWzYhxDECWUSx0XGiiP6Nu09nu0McNI3svbvozarQeUhAbj8Pr3pbNcJBmkVqBASZNpN81m2gvqJ13rXECSMsz0QI2Qryqasj3//zXJvbvUzNlJb+e9H6iWMc0QMjoeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sGKMmqHjJ9oa4mEEypLQzvxRTza1QdZ5wehCYtEcBMc=;
 b=sc4/6Zc09xuUhfIfWImpoe27ZDvVYdFvBmiys4RMpH2BIHQkn9XHopKa5e31NDxh/lgIi1GpFjjx09CNwWO66O9EbYkN1omoS+R7NlMuj3Y1mlC4ibz5RyMw4k7VooUEPYriCa+7iglW3GnfN3GqLWEPbuhRdHpeuVuqM0p+yJnq6prLM+lR/yV+jdmOVm9OcLkzXGSwn3quavBR6KrMV+ytH2oM29AQ7E9X7ft+hHWjsUIXrLA6OYE49XbAWKfZrUrjlGD70on/qP9pyGbLUmxXVwIgPHv3pv0iGG2sAJmlW+LfD67lgSZ0Rnrh87oVxsrWJovO2wUjzYNYVOy41Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sGKMmqHjJ9oa4mEEypLQzvxRTza1QdZ5wehCYtEcBMc=;
 b=riLJd3hcr9rtjRMcLBT4TzPQcAWeMFduNXO9CP/TFKNXkrsZADx14aU0uqmEUZOabv8Xkq/bAdcCi5Mnsucl2Q4TvQgJ084YpGWidicyFnvKkc65oHyFtvtk/P/C1JWvzbbuG4T5/l3TLkYtG6RJ5hi+uc3NRRk/BE4rKu0NLSw=
Received: from PH7P220CA0097.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::15)
 by CH3PR12MB8970.namprd12.prod.outlook.com (2603:10b6:610:176::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Thu, 25 Jul
 2024 15:01:36 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:510:32d:cafe::96) by PH7P220CA0097.outlook.office365.com
 (2603:10b6:510:32d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20 via Frontend
 Transport; Thu, 25 Jul 2024 15:01:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 15:01:35 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 10:01:32 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 45/53] drm/amdgpu/gfx9.4.3: use proper rlc safe mode helpers
Date: Thu, 25 Jul 2024 11:00:47 -0400
Message-ID: <20240725150055.1991893-46-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725150055.1991893-1-alexander.deucher@amd.com>
References: <20240725150055.1991893-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|CH3PR12MB8970:EE_
X-MS-Office365-Filtering-Correlation-Id: a51ab833-73a6-434b-d538-08dcacbaada8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kfv0YmXhadcnXSqZcYiZN7PzCTajL4ZyIRjoSOlc/lrd33fmKg+MwLEDut8k?=
 =?us-ascii?Q?KHEZisVHNOnBBIFrbZTO4Zb/z3qxf/2ice9Q4/M/RUyGoNYNN7Uyh6hZBaWt?=
 =?us-ascii?Q?eaWc8RCBRYgV9WrvlhYmgN//y8Mh7HMS4fvUU9BwYbRC4skCN/JtT63/CpZv?=
 =?us-ascii?Q?b/oObzpzVAe75uUtnDUGRYrtMpBya9K+dyg4ejSXWEN4hsjlAxsB6MADYpTR?=
 =?us-ascii?Q?FGaLJNaliRNe4z6DeO+Qrssmf3Ulb7jBFciwT7oQlWjHfsRQ+vPsk+OyRPni?=
 =?us-ascii?Q?Yqv5R3CZBlZy2OKirU6lfWmQDftrtJWEQu9ntP2n3D/MFK3/5sqxtAnO/Se2?=
 =?us-ascii?Q?9Fh4WIHiufFxkUIo6bcWkJCky6eLw3YgkX6gaOgpvkxMdEEfholHoDOQB7iL?=
 =?us-ascii?Q?X1XrxDjPRjwmJPcxt6wc2t9kzgvHUwkqnvXLYdqEDvXHeS9/DjHmjCKZTLPY?=
 =?us-ascii?Q?DyRuGx/kRx0/WbSfU4n9/PYwn676piigeVX3d0iNzoQWPfeqP57r4+X3e2bZ?=
 =?us-ascii?Q?icQrI87W6Wj7OcjmMCRnQgBTQr+cYPdrgr33MtkYxd0c9OZ7M1J+09ouKqVF?=
 =?us-ascii?Q?qela5UJdM/tpC539tOAZxIDqRUI7TWZFiQmuOGCwsW6pNU8LoPlTWBTWiaBj?=
 =?us-ascii?Q?X8B6QDB4lcdvJUpz8ceSjQyhy5BjNbH/WGiGOjJCnn1tohEKkZY3Xvx77IZe?=
 =?us-ascii?Q?GUKGtRCJDNdBaUlPnHrREvlU1S3HMqhuaKz77DQlYpo1npncIQG2Iv86VQmu?=
 =?us-ascii?Q?aJPUhk5E8Mx3AWgSoYbEmD0nY7Oa+1CL5s3+c9XdvSviGCvPgYXCnVsIBMvm?=
 =?us-ascii?Q?6OegWlgIEKKlEDw7kA0U0faoBQPWwM+V0aVfibU9hO1uW5qJzxGNlfnOwsdn?=
 =?us-ascii?Q?la9tb5uvpvljRvnwcmAplYopGMSup7KiCtQlORP2i7M0dGV4RRsdvVthZIxY?=
 =?us-ascii?Q?J76DmQe9knXPOg2b3vaivsKSRmCSyBrtrhWt899N1YpS5DoZKm0akhn6kR3N?=
 =?us-ascii?Q?u15s8a1GN5Z+Z0QLztne9O9w03dU0is3Va5g/EETjzYBVHPQ88B+8kxUElI2?=
 =?us-ascii?Q?bq1PWXQWILj2lPfMYlin6Bx4KjsWVfOprQS9wVWj4kzzIjQHh5g7LYjqcTuN?=
 =?us-ascii?Q?CKGLdGcH/sRnean1B63PdYQzar5zlF8fFjPkhRmQtEdiuRRQ6uGZuLp5FKcC?=
 =?us-ascii?Q?szept6j6EyoDMnQglhSKrp8kyIgY0YI3DsZmqX9GdHbzwTBFRklrvbzffBk4?=
 =?us-ascii?Q?RJIZdNi2xcZX5SHAtxTtnpmeUWTh9oaDY+73+yCpNqz7jV6JNGtMuOf2gudP?=
 =?us-ascii?Q?kKkLG6H91qoaqPZKRJ5Qzt4x04lyy5kA302cfZ5803dCQn4k2dP5n50H7vGD?=
 =?us-ascii?Q?Y5GnJYI3cmRI0PDIbXiHLpqxB8zX7T+6/t5r1IEdhGrMdgq4p9OIc2tUSiFI?=
 =?us-ascii?Q?fU9G4TN5CPTCbTMeBKjs3BsfJbEtCGKF?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 15:01:35.6247 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a51ab833-73a6-434b-d538-08dcacbaada8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8970
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

Rather than open coding it for the queue reset.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 7ac727f6b9b6..797de64cde74 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -192,7 +192,7 @@ static void gfx_v9_4_3_kiq_reset_hw_queue(struct amdgpu_ring *kiq_ring, uint32_t
 	unsigned i;
 
 	/* enter save mode */
-	gfx_v9_4_3_xcc_set_safe_mode(adev, xcc_id);
+	amdgpu_gfx_rlc_enter_safe_mode(adev, xcc_id);
 	mutex_lock(&adev->srbm_mutex);
 	soc15_grbm_select(adev, me_id, pipe_id, queue_id, 0, xcc_id);
 
@@ -214,7 +214,7 @@ static void gfx_v9_4_3_kiq_reset_hw_queue(struct amdgpu_ring *kiq_ring, uint32_t
 	soc15_grbm_select(adev, 0, 0, 0, 0, 0);
 	mutex_unlock(&adev->srbm_mutex);
 	/* exit safe mode */
-	gfx_v9_4_3_xcc_unset_safe_mode(adev, xcc_id);
+	amdgpu_gfx_rlc_exit_safe_mode(adev, xcc_id);
 }
 
 static const struct kiq_pm4_funcs gfx_v9_4_3_kiq_pm4_funcs = {
@@ -3332,7 +3332,7 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
 		return r;
 
 	/* make sure dequeue is complete*/
-	gfx_v9_4_3_xcc_set_safe_mode(adev, ring->xcc_id);
+	amdgpu_gfx_rlc_enter_safe_mode(adev, ring->xcc_id);
 	mutex_lock(&adev->srbm_mutex);
 	soc15_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0, GET_INST(GC, ring->xcc_id));
 	for (i = 0; i < adev->usec_timeout; i++) {
@@ -3344,7 +3344,7 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
 		r = -ETIMEDOUT;
 	soc15_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, ring->xcc_id));
 	mutex_unlock(&adev->srbm_mutex);
-	gfx_v9_4_3_xcc_unset_safe_mode(adev, ring->xcc_id);
+	amdgpu_gfx_rlc_exit_safe_mode(adev, ring->xcc_id);
 	if (r) {
 		dev_err(adev->dev, "fail to wait on hqd deactive\n");
 		return r;
-- 
2.45.2

