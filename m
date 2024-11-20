Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 853A3D743D0
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2024 20:11:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 176E410E17F;
	Wed, 20 Nov 2024 20:11:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iX2aZeqz";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A2C210E17F
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2024 20:11:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FOcbqe/GYxLLBIYTKAVCjqs9STYh5NvAGy7oJg+3zV6oT46qvcM0UGnzRQ/GLqpw+gqQ4SniEHFD2liF1GddRrYx1VFIqP2ReMmP/Rgo7kwgGhl02CXyfWpAdKhfGtcc0TVpiGbSK+sqhTc1ZKrO3XsFSKsDZ2/fcYdhZZpw/MZusyhM41FdonB4AtUrx6212AJUQqsSeJd0Rzb5vzY4zOIUobYNp9y0z3XkrsKPiM3Mbsk0GKYpe/a1PN/jGs6S3pwKvTkgkSl0566LyurSQznwfZBvEjQ5fjOg7ecc0ExqoJxntw53nRB0lUfSAMFTCzr5W31CfTMN0ykAmR/lfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CZxHpaYG0qBVAIclXniVwWgxm94O1FcMKoY0Cx/TdFY=;
 b=fYxlDYq/3QmjVL68Xca1/WxN5/sWcjM/BRnHj48RosNjG2fGlS5I/pvmzZVHtlT/IhnyzXlsb5oyQzj4iMT4IBemQzYge2V43d0eRBEAIGRKQ3ZOaVFowZhy6LcZGLeYPdo2IUp7fErhISfCBxgyg2rUgC8iRO2yNP7BYjyA2C3NcQ3fz7WwwzxtuDWX3LBHqXAri1LQONwLk2T+IUV5/LKg9x1qc0KaATGXuXTkOMrlIcK9bvCW+mbkGowBP8FBH21q2hTh5hArfNWrmdi+7BXTghYZ2TBeN/iFu38neyaF08BQAtmoggEMmjO2DQaUrpRV4xeQ9GQQX1lm3wSjgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CZxHpaYG0qBVAIclXniVwWgxm94O1FcMKoY0Cx/TdFY=;
 b=iX2aZeqzPWbvOmHvQgjN4KUHr/fjK0oxWKnIjDtO0UWMmkL799RcOujQreTkCIp3xykl7rcbm2z1g1Q3lC8OSEekwTgCCrqSIwsUZdbgn715tNw/VOEmPlEPPpuGwNXj4yP5l4Pns4HsrEKZP+IC04e07L/GPUSSMSBU1zLtTWM=
Received: from SJ0PR13CA0206.namprd13.prod.outlook.com (2603:10b6:a03:2c3::31)
 by SJ2PR12MB9007.namprd12.prod.outlook.com (2603:10b6:a03:541::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Wed, 20 Nov
 2024 20:11:16 +0000
Received: from SJ5PEPF000001D4.namprd05.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::8a) by SJ0PR13CA0206.outlook.office365.com
 (2603:10b6:a03:2c3::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.14 via Frontend
 Transport; Wed, 20 Nov 2024 20:11:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 SJ5PEPF000001D4.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Wed, 20 Nov 2024 20:11:16 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Nov
 2024 14:11:13 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/jpeg: cancel the jpeg worker
Date: Wed, 20 Nov 2024 15:10:57 -0500
Message-ID: <20241120201057.2579253-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D4:EE_|SJ2PR12MB9007:EE_
X-MS-Office365-Filtering-Correlation-Id: be9058bd-0a05-4b37-1424-08dd099f7d8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?P6ZvuMMAfDnYAMqjwBLoUJyZ65y0g+Zf+n/WM/19PYA9w3ym2DKHTRxjokSh?=
 =?us-ascii?Q?lrIOSlWngxosByqqIvnGLXDEXHOKdmbBw/q0ovcMTJG8rX6DlBGbATZDCU+K?=
 =?us-ascii?Q?nUWOIsTQRIF49FFoFzvkjls4m7qcfQuy24J7l4bWtwCwrxEC0tzFHghBec0B?=
 =?us-ascii?Q?FZaWYTz68LPjfhx8ppeyn4n1fFejlUI8TZ37mqD1L/0X6zSn4gbUeo/XL05C?=
 =?us-ascii?Q?w4X3f2IbVyDpDMNF6HnnAb/xKB/BUz33L+KoWDC8XjnYlku2d3ig0kAmYXui?=
 =?us-ascii?Q?v6BwfQaPuDd+/XK3bDKzPGHGj2PfLNkw1SfPOSoSKMuFyi7zhpC1H1fWCMhp?=
 =?us-ascii?Q?l6b78jYtWj5px12eNu0kAmA2Aeh5NbYa+N2LVqak8JMCg044emukrJym+Yu6?=
 =?us-ascii?Q?0RhPGkb7i4/6Sz/OdKi38HgMa94Y33Cexkr4j87k6H6YNXGl3SF2SuCYoEBm?=
 =?us-ascii?Q?nuZHBC6+8uDfRbXR5imVWNQs/uxd4Fv0hxTo9GA+oVgy2V91Z00aY4so6pd9?=
 =?us-ascii?Q?lQLHjol+NUDtj7YDxFoq6gmGP6YLhmADyUtJRWj8TzkxfaNsIrp5lph0L2KO?=
 =?us-ascii?Q?9S6g9m2sL1W9dIk1KXB5oA00EnBe/Fq6qBP2ZspX4QwXlECZI6Ef+Vuvgexl?=
 =?us-ascii?Q?ItKZoLqCBiIcwS+M1teIu7b6OWE5lSgz07yQgJu8g261klMT/t9tE5GrP8JQ?=
 =?us-ascii?Q?QqRWDLcW3CCbLKxOhp3qhOO3zuhWlrhUt29+64m2InMt7WwacBGU5hS9MPul?=
 =?us-ascii?Q?c7X5YqKnExh2YQlbxzNjENg+i/0Xph4eS8GwNXPqlQuuBpbgF8fibkgI7LjY?=
 =?us-ascii?Q?jy1NFMdkUsY4KkZU7Nb1MhdA5jUJT/2+NP2J4/kwTBKcV8EVIzZb45W9Vcax?=
 =?us-ascii?Q?B61z2Xgf3xiRwwR/3SZU8wT4XXSP2kbyrvn1I7ol7KqHUvhkwrfiLHqYUOGd?=
 =?us-ascii?Q?o6m9r9JvicPWoGjnHt8Jx4XswgS0Qgf+t+STvaHK29v8Sbubc5VNXLXBL9Dk?=
 =?us-ascii?Q?6uKDYgBiDTH3+qaEj3RyVhL4DIIvxW8cEVRpNBXkFkztf++lJSQV7g3zb2j2?=
 =?us-ascii?Q?YsiDOY4hP7tJ7LXka4B9hFkDskAz3LEZenZ7E3gZcg0g9Vg/lRAevDYI/zX0?=
 =?us-ascii?Q?n9+t+PTBzax0tkjz0OgHKlshSYzgx/UDGc/znqSphWspGkQ+wPcvRArWHhBs?=
 =?us-ascii?Q?jxgxOTobs9yCoBCZASmM0k0CuXSe0L0a50PTBlFE+FthKjJaBsvhsVLtJ192?=
 =?us-ascii?Q?HfjITh2UrWol+tVtohwJaYKE39rjDXEXiv375aiUdUDgYMyaRDGDVxj8ngis?=
 =?us-ascii?Q?CFXtrpig+LN6j4AXJCbMF4Ra3g4/Xar4SgFuBdtCS/Rnf9W5ocxJdWgpl/3J?=
 =?us-ascii?Q?apdEOMavkeT68mvifl9Fa8JYogLHblbKNQvpz9nJyfoqR69GoQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 20:11:16.5698 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be9058bd-0a05-4b37-1424-08dd099f7d8c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9007
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

Looks like these got missed when jpeg was split from vcn.
Cancel the jpeg workers rather than vcn workers.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
index 03b8b7cd5229..7319299f25ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
@@ -604,7 +604,7 @@ static void jpeg_v1_0_set_irq_funcs(struct amdgpu_device *adev)
 static void jpeg_v1_0_ring_begin_use(struct amdgpu_ring *ring)
 {
 	struct	amdgpu_device *adev = ring->adev;
-	bool	set_clocks = !cancel_delayed_work_sync(&adev->vcn.idle_work);
+	bool	set_clocks = !cancel_delayed_work_sync(&adev->jpeg.idle_work);
 	int		cnt = 0;
 
 	mutex_lock(&adev->vcn.vcn1_jpeg1_workaround);
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index 1100d832abfc..7c9251c03815 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -150,7 +150,7 @@ static int jpeg_v2_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
-	cancel_delayed_work_sync(&adev->vcn.idle_work);
+	cancel_delayed_work_sync(&adev->jpeg.idle_work);
 
 	if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
 	      RREG32_SOC15(JPEG, 0, mmUVD_JRBC_STATUS))
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index 3d72e383b7df..11f6af2646e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -211,7 +211,7 @@ static int jpeg_v2_5_hw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int i;
 
-	cancel_delayed_work_sync(&adev->vcn.idle_work);
+	cancel_delayed_work_sync(&adev->jpeg.idle_work);
 
 	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
 		if (adev->jpeg.harvest_config & (1 << i))
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index 200403a07d34..4eca65ea9053 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -164,7 +164,7 @@ static int jpeg_v3_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
-	cancel_delayed_work_sync(&adev->vcn.idle_work);
+	cancel_delayed_work_sync(&adev->jpeg.idle_work);
 
 	if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
 	      RREG32_SOC15(JPEG, 0, mmUVD_JRBC_STATUS))
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index afba0eaa1500..0aef1f64afd0 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -202,7 +202,7 @@ static int jpeg_v4_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
-	cancel_delayed_work_sync(&adev->vcn.idle_work);
+	cancel_delayed_work_sync(&adev->jpeg.idle_work);
 	if (!amdgpu_sriov_vf(adev)) {
 		if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
 			RREG32_SOC15(JPEG, 0, regUVD_JRBC_STATUS))
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
index e05ca131c1e6..6b3656984957 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
@@ -227,7 +227,7 @@ static int jpeg_v4_0_5_hw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int i;
 
-	cancel_delayed_work_sync(&adev->vcn.idle_work);
+	cancel_delayed_work_sync(&adev->jpeg.idle_work);
 
 	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
 		if (adev->jpeg.harvest_config & (1 << i))
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
index 8a14108361d4..87b3f91440e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
@@ -168,7 +168,7 @@ static int jpeg_v5_0_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
-	cancel_delayed_work_sync(&adev->vcn.idle_work);
+	cancel_delayed_work_sync(&adev->jpeg.idle_work);
 
 	if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
 	      RREG32_SOC15(JPEG, 0, regUVD_JRBC_STATUS))
-- 
2.47.0

