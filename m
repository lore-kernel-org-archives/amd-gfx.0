Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7598BC282EC
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Mar 2025 14:42:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0598210E8E7;
	Thu, 13 Mar 2025 14:42:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5VGkGogQ";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC3A110E8C0
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Mar 2025 14:42:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZIN7/k4YbPc5IDyMKU6YvsrxdIasMXfWID6L+mokEFiJg3dvci2ICfx+2lZzvP33zGUs4pJOwQ/BlzDI4yni33SGSexlgGL4vTu53HKxB1HG+4ZPXUn9TPihCVzkDWcFRp+UMxK8F9kOSSCHsiQ2qCcU854gQmsVCxoMfyYRlmlDWoLQ5t4Soocgg189Wzmfj1oddfzehZdBXcWCrmq9QPT1VlmNup0y9XOwfWbbfaPtah9hUJQeXhsRr5TiqBrrA9EZoQjXf3YJHluqiHj+0OK7cPg1kI+ZSfWXUEa6gctm+pTgjQG0+GcrK1O4NEEO1Fc2X0K0EAqLh/1mtTRYbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Soxq0iosKZL/eikvcPKXMVGsR696YUY0L6Lt5R0MnE=;
 b=TxeohK7QZg7oRFEIptpU1b85oWKhtLdMQQFPl9JWfFVRP0tIcaXXelntuttSVG80YXSZYSvIT+ZflYwMKCcpR45tO2NK0aNXMN5hzt6XX4bot0aH6atT9H1moYxTThQwyD8wC3MgagGDQVGCKZBEBA3ODhsGKI9sMMvkwS/uLIy5ayQNnfLieRwrSGc8lbYytW8K7CnXadRgPxmrsDDgo+MeQ4LDluw4ZfbyA12eV6+aRH5YsvUpxFcVFGsCFkb8Yi5ELIz74sSx6fYNbAeES/Y8cHPB9LUlhm1xANNFEuZ/jrjOnBM2wmFAGKlCbgjUn6G+jhUoY8t98oGEoaSeKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Soxq0iosKZL/eikvcPKXMVGsR696YUY0L6Lt5R0MnE=;
 b=5VGkGogQVRWt11qQXy8rKqPMcuZBFYKInatWR5gBzsc/cVOJvqN3lzICb2ez/lvWpAoISP9eNQ1CmS9txSexqSu3rov57pzUgjH/APHOyZ2SXj8J8xYZBVYUU0DodtKWlF4uPyY9pGnvRP8TzHatdmEbTFXVI5IsvyRVit2awjI=
Received: from BL1PR13CA0360.namprd13.prod.outlook.com (2603:10b6:208:2c6::35)
 by CH3PR12MB8725.namprd12.prod.outlook.com (2603:10b6:610:170::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Thu, 13 Mar
 2025 14:41:58 +0000
Received: from BN3PEPF0000B371.namprd21.prod.outlook.com
 (2603:10b6:208:2c6:cafe::ce) by BL1PR13CA0360.outlook.office365.com
 (2603:10b6:208:2c6::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.27 via Frontend Transport; Thu,
 13 Mar 2025 14:41:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B371.mail.protection.outlook.com (10.167.243.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8558.0 via Frontend Transport; Thu, 13 Mar 2025 14:41:57 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Mar
 2025 09:41:56 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 07/11] drm/amdgpu/gfx11: add support for disable_kq
Date: Thu, 13 Mar 2025 10:41:32 -0400
Message-ID: <20250313144136.1117072-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250313144136.1117072-1-alexander.deucher@amd.com>
References: <20250313144136.1117072-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B371:EE_|CH3PR12MB8725:EE_
X-MS-Office365-Filtering-Correlation-Id: e35d11c5-11ee-44cd-989e-08dd623d351f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+SSqALkvDmg5F6oooxcAdOomQHPWxSNNaBa+VwuMOCv85R+01UDIjv8IoST6?=
 =?us-ascii?Q?+VkqRks8z1mwSGUHvWKDnPp+88t4OO8txSONEZFJaZ8rrqonJlPFaMSLvCWr?=
 =?us-ascii?Q?y1Gb7puEE5+/11Rf3sbGi81mf0aXxm1RFUA6tewfRrqjwPkZrflac015m5Zi?=
 =?us-ascii?Q?ji1J9MgmtpTaT1BfjHgyDb7E4dU6PshpMztf7r8JWFyYRu19h1O1DNoCQeoP?=
 =?us-ascii?Q?G21l50Lb9HXlj8qhJkKUjgOry2EQt3kYCM+1iK0RbGkjwh+RcQoJkzoxtpPB?=
 =?us-ascii?Q?Wh8ju1hzb45S6msb98m/n8Eow40ptrc91jDciHr0KZX2JXqLSH8XeFitUMsB?=
 =?us-ascii?Q?TKIsClODT5BAQMhnWeziTMd92ytEWBIFjofP+fAcKBeMaAL1DPpJz83sfVZE?=
 =?us-ascii?Q?39eI8CNF1lY82ZeOkP7OgF/xloLbRr9dAr83E/YYXGIpIZbeEgnJY53RIWQU?=
 =?us-ascii?Q?fRMSenLRV2jp8xv3CbwevP1YXQxir4bn9Vt4fo8yaS05Zl01XfNEXeXh7gcq?=
 =?us-ascii?Q?xzEIk1NwsETRS/SEvfw81ooeLTVzkG4ajeTNyJlfM49xzPHJklYXEbSh6tIY?=
 =?us-ascii?Q?pfBl1pFz7VnheKrjVUQIe8MnpRmPrcWM2NQwrGgilN9t8ZWdqqgRBtSIt4Lf?=
 =?us-ascii?Q?IFclblMncQPzbGO+wfTS1n38UGz10bFQDzFyQGsuh79CagYlFKIKPy2zhZD3?=
 =?us-ascii?Q?A5QwLbbS5VXa3RArr8qKnJ56X8MXtDFCfna2pSdIFdqow3vtv2WRLapyTakY?=
 =?us-ascii?Q?FlghQnkbQyZiYibdiOfKFtMhhfqxj+GZ534Mdc0HNsO0awiagYF2KS1U81Md?=
 =?us-ascii?Q?KO5ldpbSmEohvhepChtRlRIXBALsRquh33+92jpNc1plIxbrJZ4hLjblwKTg?=
 =?us-ascii?Q?BKybGeCZRzckXdySaJ4ZtaC4QFB2wjVGxAilGlImsh2k0MDw4t4PJzTFCjB0?=
 =?us-ascii?Q?h3BLnRhF07J3/1H5Ys/Y/UX/F2dBJB1Lsf25DGabHgXvNICFyWkjJfwmq1Ww?=
 =?us-ascii?Q?XenHB153g1SSxn9p/gscacDNlGOAXFoSM8KvGUAxbyl6Zrzlwgpf5eS/wiNF?=
 =?us-ascii?Q?O0lP8xKcOj51pMYila5qDP1lAi/MRkznZ9oQc20MVRost+8OM/DURF1+ic+q?=
 =?us-ascii?Q?iqr0c0Bww7RAuaV3AkomdZsQdkvbfVpUDhuSjEJTEun6euN8LVt+YFsqcWL9?=
 =?us-ascii?Q?v9qh0TJkDwEshIdLMcxN+iLrt/qO7SwcXbI+Nv5ugCn86S4SrA8KOOdAog9/?=
 =?us-ascii?Q?yQ3LWore/hYSwQM+QwFDxRDqqsIhnzSPzS/8bNhYDJDN0w+uxzmI7ZxBSyV+?=
 =?us-ascii?Q?LJcX3p8M1iMEQp6K6c+NVsX1D0mP4k26yyzhhzInFk1IQ5Zf3ezXyfkLKVLD?=
 =?us-ascii?Q?U1hRny68Ii9NHXYdbCzT9PvT1KxsiNgbNQPhj/Mx43TOIuAMZT91z6RMnFAE?=
 =?us-ascii?Q?HukE+iYL8RQkWuOmRmK6DAfhciEaHCJh9YI5kGA1G5sHabl776TyZQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 14:41:57.9956 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e35d11c5-11ee-44cd-989e-08dd623d351f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B371.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8725
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

Plumb in support for disabling kernel queues in
GFX11.  We have to bring up a GFX queue briefly in
order to initialize the clear state.  After that
we can disable it.

v2: use ring counts per Felix' suggestion
v3: fix stream fault handler, enable EOP interrupts
v4: fix MEC interrupt offset (Sunil)

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 191 ++++++++++++++++++-------
 1 file changed, 136 insertions(+), 55 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 95eefd9a40d28..fde8464cbd3b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1145,6 +1145,10 @@ static int gfx_v11_0_gfx_ring_init(struct amdgpu_device *adev, int ring_id,
 
 	ring->ring_obj = NULL;
 	ring->use_doorbell = true;
+	if (adev->gfx.disable_kq) {
+		ring->no_scheduler = true;
+		ring->no_user_submission = true;
+	}
 
 	if (!ring_id)
 		ring->doorbell_index = adev->doorbell_index.gfx_ring0 << 1;
@@ -1577,7 +1581,7 @@ static void gfx_v11_0_alloc_ip_dump(struct amdgpu_device *adev)
 
 static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
-	int i, j, k, r, ring_id = 0;
+	int i, j, k, r, ring_id;
 	int xcc_id = 0;
 	struct amdgpu_device *adev = ip_block->adev;
 
@@ -1710,37 +1714,42 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 		return r;
 	}
 
-	/* set up the gfx ring */
-	for (i = 0; i < adev->gfx.me.num_me; i++) {
-		for (j = 0; j < adev->gfx.me.num_queue_per_pipe; j++) {
-			for (k = 0; k < adev->gfx.me.num_pipe_per_me; k++) {
-				if (!amdgpu_gfx_is_me_queue_enabled(adev, i, k, j))
-					continue;
-
-				r = gfx_v11_0_gfx_ring_init(adev, ring_id,
-							    i, k, j);
-				if (r)
-					return r;
-				ring_id++;
+	if (adev->gfx.num_gfx_rings) {
+		ring_id = 0;
+		/* set up the gfx ring */
+		for (i = 0; i < adev->gfx.me.num_me; i++) {
+			for (j = 0; j < adev->gfx.me.num_queue_per_pipe; j++) {
+				for (k = 0; k < adev->gfx.me.num_pipe_per_me; k++) {
+					if (!amdgpu_gfx_is_me_queue_enabled(adev, i, k, j))
+						continue;
+
+					r = gfx_v11_0_gfx_ring_init(adev, ring_id,
+								    i, k, j);
+					if (r)
+						return r;
+					ring_id++;
+				}
 			}
 		}
 	}
 
-	ring_id = 0;
-	/* set up the compute queues - allocate horizontally across pipes */
-	for (i = 0; i < adev->gfx.mec.num_mec; ++i) {
-		for (j = 0; j < adev->gfx.mec.num_queue_per_pipe; j++) {
-			for (k = 0; k < adev->gfx.mec.num_pipe_per_mec; k++) {
-				if (!amdgpu_gfx_is_mec_queue_enabled(adev, 0, i,
-								     k, j))
-					continue;
+	if (adev->gfx.num_compute_rings) {
+		ring_id = 0;
+		/* set up the compute queues - allocate horizontally across pipes */
+		for (i = 0; i < adev->gfx.mec.num_mec; ++i) {
+			for (j = 0; j < adev->gfx.mec.num_queue_per_pipe; j++) {
+				for (k = 0; k < adev->gfx.mec.num_pipe_per_mec; k++) {
+					if (!amdgpu_gfx_is_mec_queue_enabled(adev, 0, i,
+									     k, j))
+						continue;
 
-				r = gfx_v11_0_compute_ring_init(adev, ring_id,
-								i, k, j);
-				if (r)
-					return r;
+					r = gfx_v11_0_compute_ring_init(adev, ring_id,
+									i, k, j);
+					if (r)
+						return r;
 
-				ring_id++;
+					ring_id++;
+				}
 			}
 		}
 	}
@@ -4578,11 +4587,23 @@ static int gfx_v11_0_cp_resume(struct amdgpu_device *adev)
 			return r;
 	}
 
-	for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
-		ring = &adev->gfx.gfx_ring[i];
-		r = amdgpu_ring_test_helper(ring);
-		if (r)
-			return r;
+	if (adev->gfx.disable_kq) {
+		for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
+			ring = &adev->gfx.gfx_ring[i];
+			/* we don't want to set ring->ready */
+			r = amdgpu_ring_test_ring(ring);
+			if (r)
+				return r;
+		}
+		if (amdgpu_async_gfx_ring)
+			amdgpu_gfx_disable_kgq(adev, 0);
+	} else {
+		for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
+			ring = &adev->gfx.gfx_ring[i];
+			r = amdgpu_ring_test_helper(ring);
+			if (r)
+				return r;
+		}
 	}
 
 	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
@@ -4791,6 +4812,46 @@ static int gfx_v11_0_hw_init(struct amdgpu_ip_block *ip_block)
 	return r;
 }
 
+static int gfx_v11_0_set_userq_eop_interrupts(struct amdgpu_device *adev,
+					      bool enable)
+{
+	if (adev->gfx.disable_kq) {
+		unsigned int irq_type;
+		int m, p, r;
+
+		for (m = 0; m < adev->gfx.me.num_me; m++) {
+			for (p = 0; p < adev->gfx.me.num_pipe_per_me; p++) {
+				irq_type = AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP + p;
+				if (enable)
+					r = amdgpu_irq_get(adev, &adev->gfx.eop_irq,
+							   irq_type);
+				else
+					r = amdgpu_irq_put(adev, &adev->gfx.eop_irq,
+							   irq_type);
+				if (r)
+					return r;
+			}
+		}
+
+		for (m = 0; m < adev->gfx.mec.num_mec; ++m) {
+			for (p = 0; p < adev->gfx.mec.num_pipe_per_mec; p++) {
+				irq_type = AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP
+					+ (m * adev->gfx.mec.num_pipe_per_mec)
+					+ p;
+				if (enable)
+					r = amdgpu_irq_get(adev, &adev->gfx.eop_irq,
+							   irq_type);
+				else
+					r = amdgpu_irq_put(adev, &adev->gfx.eop_irq,
+							   irq_type);
+				if (r)
+					return r;
+			}
+		}
+	}
+	return 0;
+}
+
 static int gfx_v11_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
@@ -4800,9 +4861,11 @@ static int gfx_v11_0_hw_fini(struct amdgpu_ip_block *ip_block)
 	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.bad_op_irq, 0);
+	gfx_v11_0_set_userq_eop_interrupts(adev, false);
 
 	if (!adev->no_hw_access) {
-		if (amdgpu_async_gfx_ring) {
+		if (amdgpu_async_gfx_ring &&
+		    !adev->gfx.disable_kq) {
 			if (amdgpu_gfx_disable_kgq(adev, 0))
 				DRM_ERROR("KGQ disable failed\n");
 		}
@@ -5128,11 +5191,22 @@ static int gfx_v11_0_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
+	if (amdgpu_disable_kq == 1)
+		adev->gfx.disable_kq = true;
+
 	adev->gfx.funcs = &gfx_v11_0_gfx_funcs;
 
-	adev->gfx.num_gfx_rings = GFX11_NUM_GFX_RINGS;
-	adev->gfx.num_compute_rings = min(amdgpu_gfx_get_num_kcq(adev),
-					  AMDGPU_MAX_COMPUTE_RINGS);
+	if (adev->gfx.disable_kq) {
+		/* We need one GFX ring temporarily to set up
+		 * the clear state.
+		 */
+		adev->gfx.num_gfx_rings = 1;
+		adev->gfx.num_compute_rings = 0;
+	} else {
+		adev->gfx.num_gfx_rings = GFX11_NUM_GFX_RINGS;
+		adev->gfx.num_compute_rings = min(amdgpu_gfx_get_num_kcq(adev),
+						  AMDGPU_MAX_COMPUTE_RINGS);
+	}
 
 	gfx_v11_0_set_kiq_pm4_funcs(adev);
 	gfx_v11_0_set_ring_funcs(adev);
@@ -5163,6 +5237,11 @@ static int gfx_v11_0_late_init(struct amdgpu_ip_block *ip_block)
 	r = amdgpu_irq_get(adev, &adev->gfx.bad_op_irq, 0);
 	if (r)
 		return r;
+
+	r = gfx_v11_0_set_userq_eop_interrupts(adev, true);
+	if (r)
+		return r;
+
 	return 0;
 }
 
@@ -6548,27 +6627,29 @@ static void gfx_v11_0_handle_priv_fault(struct amdgpu_device *adev,
 	pipe_id = (entry->ring_id & 0x03) >> 0;
 	queue_id = (entry->ring_id & 0x70) >> 4;
 
-	switch (me_id) {
-	case 0:
-		for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
-			ring = &adev->gfx.gfx_ring[i];
-			if (ring->me == me_id && ring->pipe == pipe_id &&
-			    ring->queue == queue_id)
-				drm_sched_fault(&ring->sched);
-		}
-		break;
-	case 1:
-	case 2:
-		for (i = 0; i < adev->gfx.num_compute_rings; i++) {
-			ring = &adev->gfx.compute_ring[i];
-			if (ring->me == me_id && ring->pipe == pipe_id &&
-			    ring->queue == queue_id)
-				drm_sched_fault(&ring->sched);
+	if (!adev->gfx.disable_kq) {
+		switch (me_id) {
+		case 0:
+			for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
+				ring = &adev->gfx.gfx_ring[i];
+				if (ring->me == me_id && ring->pipe == pipe_id &&
+				    ring->queue == queue_id)
+					drm_sched_fault(&ring->sched);
+			}
+			break;
+		case 1:
+		case 2:
+			for (i = 0; i < adev->gfx.num_compute_rings; i++) {
+				ring = &adev->gfx.compute_ring[i];
+				if (ring->me == me_id && ring->pipe == pipe_id &&
+				    ring->queue == queue_id)
+					drm_sched_fault(&ring->sched);
+			}
+			break;
+		default:
+			BUG();
+			break;
 		}
-		break;
-	default:
-		BUG();
-		break;
 	}
 }
 
-- 
2.48.1

