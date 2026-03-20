Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4389F1099B3A
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2026 20:02:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F7EE10EBEE;
	Fri, 20 Mar 2026 20:02:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hd5fNCC1";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012004.outbound.protection.outlook.com
 [40.107.200.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A363A10EC14
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2026 20:02:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ohB3qpbDhihYOUi2BfWSGDJMNoPZpy3qs8AenK4cw0Nx/CbhN43XaRGIkNqV1y4rpc+FjvkLNBp5j2GeoQFOvEix4vmDkwhkOF+RQUEUp4xc9ztvLKXAx4YeaedXin10WDY73Aqt0Ak83e8an3lRNPocvtNpDWrFp8GrVA2PutP2vuUlCMUW+RwX3VOD4pQ1o9X8fuBiBUlTlRzYJDB52RVt9xew3FbL/e0hewj05lNtgapyE76gU3C+j32gTbntZu82xwDbRvoSKn0MAgbUR7fKvHrIwYfLs5ujSR2dOMCJe7CeOj38OVBHGbdBY0N0BOkwjgL/VdXrimc5PdqJZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3EDWdSHfc1FMj1TN99pcL67mkZkultubJmgdGM2BDe4=;
 b=YOR2gk0m+oSsDlz8/DQBGjC/FStrrupkm/rMO9rqr87hC+XM0SGW2nyS3aPMuJex8ZHwZoA9X5fbdzyuLBUaHH/BMErSmBl++Ufr1eQK6INHZ6AaMMgkncBaUYPN6Fb/HGCTFo//UlU4tACjiIa1BuQ5fUWO0M5lWHGLluobwOPG4NzPljUYq0HrzI2fJYUAT2E+lqXXVqt0a6KSWffTyFOXtOD00N+E3x3HopfHui/QOvIOha79X7jyVa4SD8bYcr1mdSTs0mACOGvOtWz4JxOLEcvkuGrdbXpk0MGqHG9lJ/iDbEFOZLQMNYHLkSYL6sew2iQgOjA+iYFNcujO6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3EDWdSHfc1FMj1TN99pcL67mkZkultubJmgdGM2BDe4=;
 b=hd5fNCC1dWrFOO53It3UzrLO80lgMtogZxrBSJ+3ujfCDOUBNXMgMPtwNdXxBKWAvRLFW4ntBdmyZsfL6wZ7UjhQQD7hmm6EIrIWqIAT6XyXyvknuprIfOuf2IGuAQW/S3JTX9rYAEfu5MOZwY2DjsZaU645qXR2NErN8jZ5ZkU=
Received: from CH2PR02CA0015.namprd02.prod.outlook.com (2603:10b6:610:4e::25)
 by DS0PR12MB8786.namprd12.prod.outlook.com (2603:10b6:8:149::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.13; Fri, 20 Mar
 2026 20:02:38 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:610:4e:cafe::3e) by CH2PR02CA0015.outlook.office365.com
 (2603:10b6:610:4e::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.23 via Frontend Transport; Fri,
 20 Mar 2026 20:02:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Fri, 20 Mar 2026 20:02:38 +0000
Received: from amberlin-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 20 Mar
 2026 15:02:37 -0500
From: Amber Lin <Amber.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Shaoyun.Liu@amd.com>, <Michael.Chen@amd.com>, <Jesse.Zhang@amd.com>,
 Amber Lin <Amber.Lin@amd.com>
Subject: [PATCH 5/8] drm/amdgpu: Missing multi-XCC support in MES
Date: Fri, 20 Mar 2026 16:02:05 -0400
Message-ID: <20260320200208.1188307-6-Amber.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260320200208.1188307-1-Amber.Lin@amd.com>
References: <20260320200208.1188307-1-Amber.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|DS0PR12MB8786:EE_
X-MS-Office365-Filtering-Correlation-Id: e417c710-2ef0-442d-3cf7-08de86bba314
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: gS0f9yb4Y+nUraRgquQhXhaZsI9ipFa+RlHBJXyLbUoFTMEPIcun3ZaICw/QTn2iJW0oR4ct9tzwV0kYdA/DV4auFqfOeiIedHsQNOJ7iXErG5w99ZWApaTYl/+pCdgITzoK2XXh9GNi2OMr8Vgqb2ouziQQFRN28iw8SFMHau4stptv2/Ttr2e6cLyzsuu2nyB2hfeS0pBpWI0nL7RO62VaCQAOS63NR+ec9Mn7GuF2MM7lmweXaf9tZTtloEeG9WKNNQJOoD8Xg6kn93OLhxsoHlH0FNmdrjjvE26v/b2psHgOZAOyAAuFv8OohxmVKszVh+8yyh1SDSksPDwxZOGAwEmvmS2qEx3AakPMQ88XeCi7utNy4FYurCmreFswHCn0TvkOI/0ZtLn7ucMQS6FXIoGnyEJMKfiEGhnhk5G+K69vlw+103o7FfB+vuc7GwL+ejeTZ6gnlNvo+KMrb4KDq7TanWEp5nQeTa3stsPHQE3mHVN6eapEBdHF4G9fhcmbnqV0FqRDA76Qpt2MkFwH75KeqZINmwVcLTFZcKJWZb7D4FmwtUazWwAP0wNlX04UuwmgH07dwuCnePHBlZaZh1n+YW0tVFwI5LnaaFzlDnkwqtiakLkoDdAskozW9zh2qfVPEUEh3TlOMCH+LGG4qy9Ng/4WfSoyf400z9YCeAKvebbL3YlP8YXEP3Fzy0Hj23W1PV61Ax84tasHU3O7Gm+JxzZAsYoU64GwIABjRdUcQrf6j+fmm02HHdoIV490S9a8T1XXlrPFkPS3Xw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2/wznlNwMYVE9z7ulRfmj5yFdZnBcDc86pgtvwKs2XzrWESd/Q/n+ARbYlgQ+YZHy6H1oGQMEo4eemms/JQZLbX7tyr76Dx1Jx6KI3jD+a2bvPvkFNouZlnIdDCsVMTsLHvXUPOHQW9GJz3le6XWeJrL5SLUQ1uRO7sMp4N1m5NkRqbelH2we8HTkNvT8CjNiVNrsqkmsylieoHdghm32kp92gmWo/mXfSkPXGhpI8lQodVursK5uJ7W4l7EqwhlaNCOZ3sqVppkwkCmzocF2frktNkEYL6Fn6bYzEACsoie04Hp6SoQ46bfXsbN8Io3FwPQ8aprS8aux/rteQPNEYd85lc38ywl0/sMlR2uXLIUqdZ3e5VPWs4JVJbICDwAPk/n5q03HBgnslxm8H7ABBjQcEf2wcVdANXRyHN5RjFAUwpYzcnFVSyNw6FIb7CD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 20:02:38.5658 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e417c710-2ef0-442d-3cf7-08de86bba314
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8786
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

In a multi-XCC GPU, pass the master XCC's ID to amdgpu_mes_suspend,
amdgpu_mes_resume, and detect_and_reset_hung_queues so the command will be
sent to the matching master MES when the compute partition mode is not
SPX.

Signed-off-by: Amber Lin <Amber.Lin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c            |  7 +++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h            |  9 +++++----
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c             |  2 +-
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c         |  2 +-
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c             | 14 +-------------
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |  4 ++--
 6 files changed, 15 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 710bca87c32b..4f44b933e373 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -300,7 +300,7 @@ void amdgpu_mes_fini(struct amdgpu_device *adev)
 	mutex_destroy(&adev->mes.mutex_hidden);
 }
 
-int amdgpu_mes_suspend(struct amdgpu_device *adev)
+int amdgpu_mes_suspend(struct amdgpu_device *adev, uint32_t xcc_id)
 {
 	struct mes_suspend_gang_input input;
 	int r;
@@ -310,6 +310,7 @@ int amdgpu_mes_suspend(struct amdgpu_device *adev)
 
 	memset(&input, 0x0, sizeof(struct mes_suspend_gang_input));
 	input.suspend_all_gangs = 1;
+	input.xcc_id = xcc_id;
 
 	/*
 	 * Avoid taking any other locks under MES lock to avoid circular
@@ -324,7 +325,7 @@ int amdgpu_mes_suspend(struct amdgpu_device *adev)
 	return r;
 }
 
-int amdgpu_mes_resume(struct amdgpu_device *adev)
+int amdgpu_mes_resume(struct amdgpu_device *adev, uint32_t xcc_id)
 {
 	struct mes_resume_gang_input input;
 	int r;
@@ -334,6 +335,7 @@ int amdgpu_mes_resume(struct amdgpu_device *adev)
 
 	memset(&input, 0x0, sizeof(struct mes_resume_gang_input));
 	input.resume_all_gangs = 1;
+	input.xcc_id = xcc_id;
 
 	/*
 	 * Avoid taking any other locks under MES lock to avoid circular
@@ -462,6 +464,7 @@ int amdgpu_mes_detect_and_reset_hung_queues(struct amdgpu_device *adev,
 		adev->mes.hung_queue_db_array_size * sizeof(u32));
 	input.queue_type = queue_type;
 	input.detect_only = detect_only;
+	input.xcc_id = xcc_id;
 
 	r = adev->mes.funcs->detect_and_reset_hung_queues(&adev->mes,
 							  &input);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 2e6ae9f84db0..643b4f8d757a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -325,8 +325,9 @@ struct mes_reset_queue_input {
 };
 
 struct mes_detect_and_reset_queue_input {
-	uint32_t                           queue_type;
-	bool                               detect_only;
+	uint32_t	queue_type;
+	bool		detect_only;
+	uint32_t	xcc_id;
 };
 
 struct mes_inv_tlbs_pasid_input {
@@ -442,8 +443,8 @@ int amdgpu_mes_init_microcode(struct amdgpu_device *adev, int pipe);
 int amdgpu_mes_init(struct amdgpu_device *adev);
 void amdgpu_mes_fini(struct amdgpu_device *adev);
 
-int amdgpu_mes_suspend(struct amdgpu_device *adev);
-int amdgpu_mes_resume(struct amdgpu_device *adev);
+int amdgpu_mes_suspend(struct amdgpu_device *adev, uint32_t xcc_id);
+int amdgpu_mes_resume(struct amdgpu_device *adev, uint32_t xcc_id);
 
 int amdgpu_mes_map_legacy_queue(struct amdgpu_device *adev,
 				struct amdgpu_ring *ring, uint32_t xcc_id);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 78d1f3eb522e..35734d34763a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -5200,7 +5200,7 @@ static int gfx_v11_0_post_soft_reset(struct amdgpu_ip_block *ip_block)
 	/**
 	 * GFX soft reset will impact MES, need resume MES when do GFX soft reset
 	 */
-	return amdgpu_mes_resume(adev);
+	return amdgpu_mes_resume(adev, 0);
 }
 
 static uint64_t gfx_v11_0_get_gpu_clock_counter(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 9508709abd49..d02a84711394 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -266,7 +266,7 @@ static int mes_userq_detect_and_reset(struct amdgpu_device *adev,
 
 	if (found_hung_queue) {
 		/* Resume scheduling after hang recovery */
-		r = amdgpu_mes_resume(adev);
+		r = amdgpu_mes_resume(adev, input.xcc_id);
 	}
 
 	return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
index 70d80c2aed52..4b279259b9d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
@@ -1888,24 +1888,12 @@ static int mes_v12_1_hw_fini(struct amdgpu_ip_block *ip_block)
 
 static int mes_v12_1_suspend(struct amdgpu_ip_block *ip_block)
 {
-	int r;
-
-	r = amdgpu_mes_suspend(ip_block->adev);
-	if (r)
-		return r;
-
 	return mes_v12_1_hw_fini(ip_block);
 }
 
 static int mes_v12_1_resume(struct amdgpu_ip_block *ip_block)
 {
-	int r;
-
-	r = mes_v12_1_hw_init(ip_block);
-	if (r)
-		return r;
-
-	return amdgpu_mes_resume(ip_block->adev);
+	return mes_v12_1_hw_init(ip_block);
 }
 
 static int mes_v12_1_early_init(struct amdgpu_ip_block *ip_block)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 18bc5ba25f8f..ec8d7f4be840 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -367,7 +367,7 @@ static int suspend_all_queues_mes(struct device_queue_manager *dqm)
 	if (!down_read_trylock(&adev->reset_domain->sem))
 		return -EIO;
 
-	r = amdgpu_mes_suspend(adev);
+	r = amdgpu_mes_suspend(adev, ffs(dqm->dev->xcc_mask) - 1);
 	up_read(&adev->reset_domain->sem);
 
 	if (r) {
@@ -387,7 +387,7 @@ static int resume_all_queues_mes(struct device_queue_manager *dqm)
 	if (!down_read_trylock(&adev->reset_domain->sem))
 		return -EIO;
 
-	r = amdgpu_mes_resume(adev);
+	r = amdgpu_mes_resume(adev, ffs(dqm->dev->xcc_mask) - 1);
 	up_read(&adev->reset_domain->sem);
 
 	if (r) {
-- 
2.43.0

