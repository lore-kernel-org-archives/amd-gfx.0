Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB1DACD5BD1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 05:54:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90701112DD2;
	Mon,  1 Jun 2026 05:54:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mxjz/w/5";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010019.outbound.protection.outlook.com [52.101.46.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC0A0112DD2
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 05:54:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jGY4dnn3+q0Bb/MH/IPE4iEX3DmdjWnujMHfyWeI7WIOLKvJGhP4ILnKr/YVWvycyJ2Tpj2EFZwVgul05xuZ1LUEa6AVBspXoQCcPpFy7M3LyF0bqjzIgPHVVP56Lyuu5uHq4uTOmS9Go3jt1vHMdjcQihJGsOpqWBE0oqL/l7bTnNm0YFl0rzvo/jNBJTbmH2gsPq16TqMZ5WAtY9i24zW0YFc47R4GcmwjH0q2cDklMjqxFAwYtRjsyIA3zzwVuRVHcfeu2tl+b9em6xRvIk+5HsufXzCqwbOiKGRTPmMSuSc1Wj1C6t/hsP7vhxWEcy9ycAiuiFDVrAt9vdZkZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rwRYXlUnO0GsYjNGtPaVJhW+205UEuq9NVxRko7Lr+U=;
 b=oNigCIzd/DXXnmMfJfMWliFA0chEh1MvQ17IFhe9iRWpU9SZLzsGj1EEEpmKheP2ToMJ0kZV5DiBh8IBrxxzt85gtc7pTmlrsUa88St+0ZWc7eFvHXnrcNO0JKWzITUTOjBSzhhZbmR75tpPeCxSOllR8rF2QAckhWlgBc8TqFZkLw3mZZREyRrVdJSX0XsXNZHVq4UAh5dT+XrHvc9wikvniUDciphtX7Djt05sIuoZeBdqddktL99y6rwWbIMWcs7bh/0YOG75wy0vCYaQ7My8QBFnnOWP3Z1Bka9ZqwgQdvRi91iY7LcguC80xZZ8wHD1Q5AQCz+sb/mCuRxFpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rwRYXlUnO0GsYjNGtPaVJhW+205UEuq9NVxRko7Lr+U=;
 b=mxjz/w/53JUby+8TKOTtSDD8Lpxjeb5T3EBc8c8iaQLL7iBuWJLbcBkfT0Nzu9JBNQaoHUl9heUpKTNz2m9FeSDhif6P3vG3p25oxZ5jqW6N8hxKtNGGjMKMOBPc8nwnm8EWZ6amKjGi9jvIuI0dd77HeY+C2mric6SQYgJrClY=
Received: from DS7PR03CA0032.namprd03.prod.outlook.com (2603:10b6:5:3b5::7) by
 DS4PR12MB9588.namprd12.prod.outlook.com (2603:10b6:8:282::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.13; Mon, 1 Jun 2026 05:54:07 +0000
Received: from DS3PEPF0000C37E.namprd04.prod.outlook.com
 (2603:10b6:5:3b5:cafe::5b) by DS7PR03CA0032.outlook.office365.com
 (2603:10b6:5:3b5::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.12 via Frontend Transport; Mon, 1
 Jun 2026 05:54:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF0000C37E.mail.protection.outlook.com (10.167.23.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 05:54:07 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 00:54:06 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 1 Jun 2026 00:54:00 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v2 28/42] drm/amdgpu/gfx11: use the new MQD helper for queue
 reset
Date: Mon, 1 Jun 2026 13:49:14 +0800
Message-ID: <20260601055034.3700921-28-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
References: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37E:EE_|DS4PR12MB9588:EE_
X-MS-Office365-Filtering-Correlation-Id: f67bf2a2-a20a-4694-d1fd-08debfa231ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: A4NlZC0QXQSRpEXKX0bU7PSN6pXq83RS77xRxwpBpMvPsPD6jVIdTsShcXPVis9sUliT8R/7OMC/itBdqczR6Q6rIekHuR02BNmksK5bdaIauDXPScXCX1o+voxsiBa3gD9iW4RsfOKuPwKdzggTferOegMoPYW7+yDWvE+OLw9s3Q9dscssrrH/wyvO/6Z2wjX7utUEW57eomUQMJmPJsK7qRB4kY6RNrgEoMcPl2iOxf6p/r3ViIpLgxMFnAHxBjJtfQPlDn3MwRxQ3T26NOzWrZbTjv5vQG0Hs/8YuQTW6EGf/RlwgI9ds7cxaWuIqY96b7OCDlfdS9aW1xvFKjLu7RwRYlPJALC9WJzOmT9BDgU9DiM4+3M9EoD4rI2wHKerHUqcr5Rp5TJalX4nzZ+qYSuEfxEm2zJK5d3M5X2slKeU9CPa124CGgDVYNXN4A5eaONptcFv+Gz4J+vRXqkIpMwQt1S4FpQYceAccY6pIKX9BDQieQldmuEJjLuE+ZtWseXDPXUvhNZuhbVpEVApONgd42QxvmTSGKX+ctRiia3+VfdYh6v6FdLBLPUJx/lx5zjkvJx1iZbPmz/eI8i4nV/3j3yW3x+vhpzNrYnwnvOR62H8iv03dRApuJe45TlEdmWXJsg0ZwrwQqSm8RtvvtedJWLBsBrnjpAJAFnpA0ipatsKDmDCfq3Ynp1+WTHsdTkyeleUKr+znqbAe7dYcFf4QsUanpUPELxzXVI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YUOhiRPf03Tmd3XCVkRuwLVF74zVZ+ppjJFUuqBcsXm7TbHzsICCRDy1rCn7enDGGF8MZLfUw+HbSLPh5Z5ViG9yg4MgohcOdkJ0BoQs1Ibbep3vpOpTngyMUHxa9oE8AQ8BwKi5/6XFMxSXC7RZHwgxRILmIXlQ3uRIbD6sy9jYRhz5y+8Ch04tYaJutj4b2GoAoCfeedgoRo1P3B4/Fqh5YmuJ30OCWGyGFYpb0SeHZxJnvzf+GiyGSjCmSg4xB75EfOqIf7Ejs+2P/cN3+enbjx9OamKtSO7d1+0C7Bi4hDvopuKPRIqWRe0haX93mmVNS36HSMgay3xRicZjE1SfTb16WdRx2Cke/QOkdcNDwexw8hDP3lcTfWTZiFtd+HEuqNzLUNZ6cJuxFTgV6onFKSgx1oTeUf7dNKysaemAjbrsvM4XolQXMJkGpLry
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 05:54:07.5849 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f67bf2a2-a20a-4694-d1fd-08debfa231ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9588
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

From: Alex Deucher <alexander.deucher@amd.com>

And while we are at it remove the reset parameter as it's
no longer needed.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index f268d46e0759..1dd35aa6199d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4212,13 +4212,13 @@ static int gfx_v11_0_gfx_mqd_init(struct amdgpu_device *adev, void *m,
 	return 0;
 }
 
-static int gfx_v11_0_kgq_init_queue(struct amdgpu_ring *ring, bool reset)
+static int gfx_v11_0_kgq_init_queue(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct v11_gfx_mqd *mqd = ring->mqd_ptr;
 	int mqd_idx = ring - &adev->gfx.gfx_ring[0];
 
-	if (!reset && !amdgpu_in_reset(adev) && !adev->in_suspend) {
+	if (!amdgpu_in_reset(adev) && !adev->in_suspend) {
 		memset((void *)mqd, 0, sizeof(*mqd));
 		mutex_lock(&adev->srbm_mutex);
 		soc21_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
@@ -4245,7 +4245,7 @@ static int gfx_v11_0_cp_async_gfx_ring_resume(struct amdgpu_device *adev)
 	int r, i;
 
 	for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
-		r = gfx_v11_0_kgq_init_queue(&adev->gfx.gfx_ring[i], false);
+		r = gfx_v11_0_kgq_init_queue(&adev->gfx.gfx_ring[i]);
 		if (r)
 			return r;
 	}
@@ -4582,13 +4582,13 @@ static int gfx_v11_0_kiq_init_queue(struct amdgpu_ring *ring)
 	return 0;
 }
 
-static int gfx_v11_0_kcq_init_queue(struct amdgpu_ring *ring, bool reset)
+static int gfx_v11_0_kcq_init_queue(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct v11_compute_mqd *mqd = ring->mqd_ptr;
 	int mqd_idx = ring - &adev->gfx.compute_ring[0];
 
-	if (!reset && !amdgpu_in_reset(adev) && !adev->in_suspend) {
+	if (!amdgpu_in_reset(adev) && !adev->in_suspend) {
 		memset((void *)mqd, 0, sizeof(*mqd));
 		mutex_lock(&adev->srbm_mutex);
 		soc21_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
@@ -4625,7 +4625,7 @@ static int gfx_v11_0_kcq_resume(struct amdgpu_device *adev)
 		gfx_v11_0_cp_compute_enable(adev, true);
 
 	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
-		r = gfx_v11_0_kcq_init_queue(&adev->gfx.compute_ring[i], false);
+		r = gfx_v11_0_kcq_init_queue(&adev->gfx.compute_ring[i]);
 		if (r)
 			return r;
 	}
@@ -6790,11 +6790,7 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
 		return r;
 
 	if (use_mmio) {
-		r = gfx_v11_0_kgq_init_queue(ring, true);
-		if (r) {
-			dev_err(adev->dev, "failed to init kgq\n");
-			return r;
-		}
+		amdgpu_gfx_mqd_reset_restore(ring);
 
 		r = amdgpu_mes_map_legacy_queue(adev, ring, 0);
 		if (r) {
@@ -6821,11 +6817,8 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
 		return r;
 
 	if (use_mmio) {
-		r = gfx_v11_0_kcq_init_queue(ring, true);
-		if (r) {
-			dev_err(adev->dev, "fail to init kcq\n");
-			return r;
-		}
+		amdgpu_gfx_mqd_reset_restore(ring);
+
 		r = amdgpu_mes_map_legacy_queue(adev, ring, 0);
 		if (r) {
 			dev_err(adev->dev, "failed to remap kcq\n");
-- 
2.49.0

