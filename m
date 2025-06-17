Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0E4AC7115C
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 03:09:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46CFB10E499;
	Tue, 17 Jun 2025 03:09:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n65acfmz";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2089.outbound.protection.outlook.com [40.107.212.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63D7A10E47F
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 03:08:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rrv+Nz9bvhDDsBHgzL9DftqKbc7hfA4Y2yZWmUeBSd1L9Eu+GgSYzXMrcanGfbVNJYWojIiqtRyTGXaWs3zeVj1dJbaA0ZK15wY6djJHassSIOZ8xmo8ZdkDMZ6Fw3l/3BPBVF0/xpFJ8lSWcamd6ffyUl4DkV+M5Cgp3X34TlVCor9nNXXLwVc7yOO6nObp5mErSXTuIzz3VvSGe4lKC93UdVuyTvvG5LbhpCaLZd5TJR+Zjl1M2f7dooEMgtiGK3Qi0EFGBNrB0iooyjMek8C0uhfpO+cfMs7rwwpqY207PFqh+FIDgEs3bmBlLmcFIfpV2Pe4TdnjkkFblQUdHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uf68fowd3gvKH44/Gdc4PM8HG9JuNO72/sSGRX3VL1A=;
 b=nwN0mKQQP4rBemVbAI6EjL9j30CCkoAJch5b7t8FxbmLcDglpJPIZaq1edtqCe4tvRru2D7QIkzq7dLNEspTENjXkIffEz1duqIg0h4kgeDMTS5B0kXDoctjSyo1sO5e3JQu6/ZaHtULggDqHU57oVHbpuiSl8Nn308WqX+JyQRKfYXxPpIdddtRgyCWdApNxX9W3lgY5gDgY7VFyXivVj3FNWYMXHoHZzuZwjUGseyXybjmZIzJS1hLB9TfRkguONq3Z+y53/cQ03tooLKkQx7nieFqER59o4d4G3SkAUbMHn3z3KIEZoQm58YQTh/wTggBm+lNQNB6gtydTvixcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uf68fowd3gvKH44/Gdc4PM8HG9JuNO72/sSGRX3VL1A=;
 b=n65acfmzgm+TUGYYw+4aCDVZnjY364NnDzd/fnWIQXvinFwlJlWHrXn4VLAgUXLJY4tLaXUDVOhb/uonlMlUZh7k5EGcw+5O0GMd/uEkXFQ+9DLmACeX6xEt/oIGxpW1ECvaxfyNx5bXKVLk1mB0MzLLjwIX83r/GW3Glm9rpzg=
Received: from MW4PR03CA0174.namprd03.prod.outlook.com (2603:10b6:303:8d::29)
 by PH7PR12MB9067.namprd12.prod.outlook.com (2603:10b6:510:1f5::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Tue, 17 Jun
 2025 03:08:52 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:303:8d:cafe::c9) by MW4PR03CA0174.outlook.office365.com
 (2603:10b6:303:8d::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.19 via Frontend Transport; Tue,
 17 Jun 2025 03:08:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Tue, 17 Jun 2025 03:08:51 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Jun
 2025 22:08:49 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 31/36] drm/amdgpu/vcn4.0.5: re-emit unprocessed state on ring
 reset
Date: Mon, 16 Jun 2025 23:08:10 -0400
Message-ID: <20250617030815.5785-32-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617030815.5785-1-alexander.deucher@amd.com>
References: <20250617030815.5785-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|PH7PR12MB9067:EE_
X-MS-Office365-Filtering-Correlation-Id: 50c96567-91ce-4498-ef6b-08ddad4c49a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sdAINKLlWjC+CdfyXkoHoK70cBAw2V7IcGf9MD2YWRRiLnI2OdiVlZhcgakV?=
 =?us-ascii?Q?NJahPdSl+IvGx386SDA6QNEbDkN0lGRkOODj2mtuQWELBTsFO8GbUJuWzPPq?=
 =?us-ascii?Q?CLmwf2/kDurRt/y1rb5fS7WipIF+i2wBE/qQxI4WKmvd+YG91SN7UJFJauIq?=
 =?us-ascii?Q?CK4r0TydWGCkTnUOtVoC3M5AYkFKec6foDFYWlmb+g8D/5oiWaddGb3KAmfK?=
 =?us-ascii?Q?k4yjF4wHu7OOpfhydKUkEtJ9bUb7xB3fuBDUqifirqEUVJcX7nuJ+HtjE/Si?=
 =?us-ascii?Q?jgYmBYulRGjYmv3iaY32GhWulH4XZGlEZyA4PHedIaDneNEh0LJK/bTLmvcW?=
 =?us-ascii?Q?wsJ6xq4mtmxJ62hpdsoInqQjgBkSY4E1GxofAc+dDafq62poxXGKWgxHZdm6?=
 =?us-ascii?Q?1eCdfocQXikq1dkHk4+g/deROGRQqFWRNxD9V5qCiZzGpZOSRzccES+eCMk+?=
 =?us-ascii?Q?9x8xmsOHEW2GZIO1l05HhN2Xvq/EayWmwDErLAT9EYWfNzNpe7Q6yaOq9Beh?=
 =?us-ascii?Q?q4Ou1yzeTEKGDwKWZjWEamYWFmZ/URJtgzVKKZG7pOGIWJWKDaNhSniPPOg3?=
 =?us-ascii?Q?FZYesVp1XD50JDoQBm8A5E2yw+cIcADDsMS+ppInh2Px5vpxzHzIkgngklSh?=
 =?us-ascii?Q?lFaLpGc0KpTZ3T4xyQ8hDEN57ixyLWmSfzf3zsOtCVfNRp6DV5XgjUHP2ATb?=
 =?us-ascii?Q?RHIEGHeTlg29mI2N/we7qqGkBXBHeFdrOunb2gUz2KoQhR4qVgAzXAFAVHnD?=
 =?us-ascii?Q?9imvop+D7NYM33A/4ImazneZWI1015sof6kqgQsaJ9g9gk5ITsOh08FIs0TD?=
 =?us-ascii?Q?BvVv/4TXz/9tvXqvE/c9YvuDj+K5iPtVQBIRDUg4Wd5/mozIP2UDQn/Dg6J4?=
 =?us-ascii?Q?PxkZu7dSHgb2pbZ57CujFOY84iDT5T4/lcZU0dirRKk3CGj0adkANVSvln7V?=
 =?us-ascii?Q?JSRHRV7TtqaMjpjlpI10KtLlORQQSO/NGTG+iGE52BswweDUvUvf++TiX1ds?=
 =?us-ascii?Q?5qap7IV4Qz+mQAvZfcyQuvaJAyM2CtBGDOxX9QlR+u1GOglUC/cr4HRVAGpT?=
 =?us-ascii?Q?oI0YCVJ6/jUAMez6QCafyhql4GGsZUcL+XSU2GlNXyJrrj0SamgFhPnx43aB?=
 =?us-ascii?Q?b0ZwlM+RKcrGTPKxuOceGdSoIxgSpAtys26lTM7/Hsxzp1qVfI9fQANh0zSB?=
 =?us-ascii?Q?1rHrmfRDWw6+anoon9OSEYduxc3ClFzKwyyb5bJZySCuMawOP6CRwBtJcKjR?=
 =?us-ascii?Q?IGCLdo7FXFYytwq8r6pPWq2f3+Ph4tmmk4fSDbkbt5wicjrYb196Sd8+QRbd?=
 =?us-ascii?Q?9ftNNgQSFneVCsms2307LhgNx/lAAvPkIzWxLubVSlCTXHEBk/GSOcE86a/H?=
 =?us-ascii?Q?Kk3NHfkfHyVjVY0Ry/HcU7mvce70J94zbu5W2RMdg/q5kD6UhpsowxOnANzu?=
 =?us-ascii?Q?1Tm6BxZL0ZUh+JcNZx6o+gxaw81l4NZxrKRGdYwaWZOohqMYbD56AOJI/I1b?=
 =?us-ascii?Q?MpRqFIImPA31HxJbhGTGdhG0BTybFUn34mV4?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 03:08:51.9550 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50c96567-91ce-4498-ef6b-08ddad4c49a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9067
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

Re-emit the unprocessed state after resetting the queue.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index aefa2d77a73c4..06f2785df16f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -1471,21 +1471,14 @@ static int vcn_v4_0_5_ring_reset(struct amdgpu_ring *ring,
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
-	int r;
 
 	if (!(adev->vcn.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
 		return -EOPNOTSUPP;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, guilty_fence);
 	vcn_v4_0_5_stop(vinst);
 	vcn_v4_0_5_start(vinst);
-
-	r = amdgpu_ring_test_helper(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, guilty_fence);
 }
 
 static struct amdgpu_ring_funcs vcn_v4_0_5_unified_ring_vm_funcs = {
-- 
2.49.0

