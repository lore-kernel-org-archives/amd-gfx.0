Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC23ED3748E
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Oct 2024 13:21:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8FD110E830;
	Thu, 17 Oct 2024 13:21:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hM7/boIZ";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7C5710E822
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 13:21:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C0gqdyWSSaOHhBFOFLxUh/hiXwNaktdBLHQOxP4gl7Xkz876gkEyxERQEEvCtIot0djVtlvdyLIYnn9clvOF/UhmXmzA7l2yWbsMbqB0L+Fd6B1bhx0Yptq1iPRZDTFGE2jv8LiVHDTEGXpLtCLo3EblNRk5Q9TEX99kek1TeWiE/sr2LUFLQEpdeLnLGoxQ+78712H0u48Jz9H8ACtj5enzH8nvuvXkq86miztg9HzBJZHolutHtcdXc9CvA/N1ArRiBpxpEFLfs+NQ3SFgRm46vHsEHSCs4BG/Tqw6E7oLDPjxn09pbQNqOM/nd/2+SfhfQLC4IgH+kjiisf49Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UNW5+1hGdQIP/jjfRtyqMTCfrVZEtVYICTxnAklct6E=;
 b=P1Lmycmr1H6UsXO4XxKqnTOl/su9l1cJDXErbgXmARKclTLoY9kRbSpf1Q3nDRLoIQyaPI7+tFy+LkpzYUWur5r5w0qSFUuFEiLVOAFWgsoY9cRhReg7QQJFU/4PBZcFxw/9CDgjyujNeJfsCOzPqS0ZUAqweyBPjpkCB4EpIgxVC1ieP9wsd+tziRP+JsUslw2qgOnEuLux8072A9ub88XwHVfoKpSxpQy3638i2CqccNLrmz4Ku3JfbquSmAozZPsPz71L1XQDg1uPnUcjInssqdIiXN11pI5xVVJG2TIPNcRo8Xm+ntw7NemFq4xyfRT6cOSe+6unitHrgheRYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNW5+1hGdQIP/jjfRtyqMTCfrVZEtVYICTxnAklct6E=;
 b=hM7/boIZ0DoSl+J8lbK5/t965HOCjzUzZcwQEwdMgzOndHcsXsbreKqkx0YLMidfx5RYj/MvOREiUAFACc6cSnkwtOevHpJKJPxjkFncq4FBRdGry8kvwDtfwXhkC3V+2nDYfs1D1JiJ9y0p4aDQttNwEEm1FkzOvGvmjIQmGiQ=
Received: from BN9PR03CA0879.namprd03.prod.outlook.com (2603:10b6:408:13c::14)
 by LV8PR12MB9261.namprd12.prod.outlook.com (2603:10b6:408:1ed::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.20; Thu, 17 Oct
 2024 13:21:30 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:408:13c:cafe::7e) by BN9PR03CA0879.outlook.office365.com
 (2603:10b6:408:13c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18 via Frontend
 Transport; Thu, 17 Oct 2024 13:21:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 13:21:30 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 08:21:29 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 22/32] drm/amdgpu: sw_fini for each vcn instance
Date: Thu, 17 Oct 2024 09:20:43 -0400
Message-ID: <20241017132053.53214-23-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017132053.53214-1-boyuan.zhang@amd.com>
References: <20241017132053.53214-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|LV8PR12MB9261:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b2c9254-211b-4ed3-20cc-08dceeae9d1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rPFpjKPnRH2xAgUc7JmXUXPH8ZBhbIGNG715gXoHmzPAx1QeLu3KZ8Bte2p6?=
 =?us-ascii?Q?jD29zwx6TSjZxR/dnMNm9LQjFGjDKbgc0bLde4UTsEQcH1HnkdoT6TrtY0ei?=
 =?us-ascii?Q?B83Ak32IrUREMet2D+o1LplTpuP5hJX9kEg3B3txuirAMOsm9LuEVWUBRWUl?=
 =?us-ascii?Q?cKisZO58Wjmx4GFpVCGBt1RqLQMW2RHqu68x00TvdP8+i6SP2W2iOKtg4Rkl?=
 =?us-ascii?Q?ZmZ0LUZm6gP5Ws9yQUyf9ibrb6NedM5FqMGVRmCbYjWE00dcfU2HxA1GAyNb?=
 =?us-ascii?Q?WeqwkAVCnK3R8+n3LzcjLjUCEumeXLP9J4ZGmIVHK5jGtlaQlzpZ7u2oVgXt?=
 =?us-ascii?Q?V7uIPwunRwxBgHeMEoB5nZ/xaDuWja4hGMrESi9YPS3CajoZ+Kchr+LFG1mA?=
 =?us-ascii?Q?4iaFSp0g36DEeEcgZcydMtYJbkzs7CicoBWog1eZVD6KLzWPfzl4oACcT2pl?=
 =?us-ascii?Q?fBYrzoEqqCoPRPiXLIoI0fMLbpYtjPQd/XXrsYCujPXoj8JbcW8uhQN1aJHn?=
 =?us-ascii?Q?Cv2RZaFjvsKjQ0RqgDVWKvUh5GKfoLbZBlrbTb/R6CNrS7DAkbNTDo6yRlbG?=
 =?us-ascii?Q?vaM7t2cNmaQOlmpU0PidftghPfBxJnT7XbCqGQfUtYuxEceAJvGktbKMBwjE?=
 =?us-ascii?Q?8fgG/QsLlmFf7nqOMu/CtMwIWWvkHgKrh+SJHKQKwx5Q7P2E/dydJPW2bQHX?=
 =?us-ascii?Q?796mxX48Sgkz8qMgbnnX1jqczODFRF1mGkP3WibSaZ5iWQGmLmouIxtqDA8V?=
 =?us-ascii?Q?tNBctjXqocA+zNSKmIwPC9gVxVtov6zkCRaOaFXULIfcpJRGjCpi2xETB3gY?=
 =?us-ascii?Q?lT9hYjKxneL9M9kz75TGaiNkkbqqU4nwi/mtR7hGv71KnzwPRpqCL9E7le9V?=
 =?us-ascii?Q?cTKQf9Nd4+6TMOeNXTPtpdFdVmUivKHPXOM2J7oLNxwaU9P7XkYz8/zPQwPV?=
 =?us-ascii?Q?8CT3NEiDSqUaEgpn245T61GQLJDwxbqNLRl5FDH7hg08tCbAcq5QVfgG2eef?=
 =?us-ascii?Q?3wE2BfqwqckU3b+R6Ub2Alsk5OOcL6nXkeL+42Q2OYpNkwwLySDe21yCH48M?=
 =?us-ascii?Q?iheALBkzThIAJiPZgaMoyeyDfG5M8FAFcxjS2B7NdTjTQ8PugjoaLY/h8rSz?=
 =?us-ascii?Q?BbwQKlh2tpP3xrNZWJy8OqQ4d0haBQZjTU6PPPqSz/RtSaj+3v1rGgx5Y90d?=
 =?us-ascii?Q?zW8NVjRVfpcNBHS78oVrYFlHxjboRkLjm+Yjf6CFWPqjzVW2wm4Sdqv8kPBY?=
 =?us-ascii?Q?jSvCJIGL0Tu/wv4ceZKYUneBoumJMn9h6o0tDxqTyecyFBTfV16zn8DLa64J?=
 =?us-ascii?Q?wKQdvZeBCKLYhYpsGX6cwhOlYI8yYuiHd9vVP8OwZn5BfwuRoxDNeQv/tjeE?=
 =?us-ascii?Q?cYp3HRACKgGcJg3JOZR8FYsxib9CoBiKVfs6kT+V4RVygKglhg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 13:21:30.6704 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b2c9254-211b-4ed3-20cc-08dceeae9d1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9261
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

From: Boyuan Zhang <boyuan.zhang@amd.com>

Pass instance parameter to amdgpu_vcn_sw_fini(), and perform
sw fini ONLY for the given vcn instance, instead of for all
vcn instances. Modify each vcn generation accordingly.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 36 ++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   |  5 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   |  5 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 17 ++++++------
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 20 +++++++-------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 21 +++++++--------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 16 +++++------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 21 +++++++--------
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 21 +++++++--------
 10 files changed, 81 insertions(+), 83 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 791b95867ac2..307615ffeb79 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -248,33 +248,31 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev, int inst)
 	return 0;
 }
 
-int amdgpu_vcn_sw_fini(struct amdgpu_device *adev)
+int amdgpu_vcn_sw_fini(struct amdgpu_device *adev, int inst)
 {
-	int i, j;
-
-	for (j = 0; j < adev->vcn.num_vcn_inst; ++j) {
-		if (adev->vcn.harvest_config & (1 << j))
-			continue;
+	int i;
 
-		amdgpu_bo_free_kernel(
-			&adev->vcn.inst[j].dpg_sram_bo,
-			&adev->vcn.inst[j].dpg_sram_gpu_addr,
-			(void **)&adev->vcn.inst[j].dpg_sram_cpu_addr);
+	if (adev->vcn.harvest_config & (1 << inst))
+		goto done;
 
-		kvfree(adev->vcn.inst[j].saved_bo);
+	amdgpu_bo_free_kernel(
+		&adev->vcn.inst[inst].dpg_sram_bo,
+		&adev->vcn.inst[inst].dpg_sram_gpu_addr,
+		(void **)&adev->vcn.inst[inst].dpg_sram_cpu_addr);
 
-		amdgpu_bo_free_kernel(&adev->vcn.inst[j].vcpu_bo,
-					  &adev->vcn.inst[j].gpu_addr,
-					  (void **)&adev->vcn.inst[j].cpu_addr);
+	kvfree(adev->vcn.inst[inst].saved_bo);
 
-		amdgpu_ring_fini(&adev->vcn.inst[j].ring_dec);
+	amdgpu_bo_free_kernel(&adev->vcn.inst[inst].vcpu_bo,
+				  &adev->vcn.inst[inst].gpu_addr,
+				  (void **)&adev->vcn.inst[inst].cpu_addr);
 
-		for (i = 0; i < adev->vcn.num_enc_rings; ++i)
-			amdgpu_ring_fini(&adev->vcn.inst[j].ring_enc[i]);
+	amdgpu_ring_fini(&adev->vcn.inst[inst].ring_dec);
 
-		amdgpu_ucode_release(&adev->vcn.inst[j].fw);
-	}
+	for (i = 0; i < adev->vcn.num_enc_rings; ++i)
+		amdgpu_ring_fini(&adev->vcn.inst[inst].ring_enc[i]);
 
+	amdgpu_ucode_release(&adev->vcn.inst[inst].fw);
+done:
 	mutex_destroy(&adev->vcn.vcn1_jpeg1_workaround);
 	mutex_destroy(&adev->vcn.vcn_pg_lock);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 825b70a396cd..883b9f9776a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -485,7 +485,7 @@ enum vcn_ring_type {
 
 int amdgpu_vcn_early_init(struct amdgpu_device *adev, int inst);
 int amdgpu_vcn_sw_init(struct amdgpu_device *adev, int inst);
-int amdgpu_vcn_sw_fini(struct amdgpu_device *adev);
+int amdgpu_vcn_sw_fini(struct amdgpu_device *adev, int inst);
 int amdgpu_vcn_suspend(struct amdgpu_device *adev);
 int amdgpu_vcn_resume(struct amdgpu_device *adev);
 void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 70d865724463..8203f80be316 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -222,8 +222,9 @@ static int vcn_v1_0_sw_init(struct amdgpu_ip_block *ip_block)
  */
 static int vcn_v1_0_sw_fini(struct amdgpu_ip_block *ip_block)
 {
-	int r;
 	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
+	int r;
 
 	r = amdgpu_vcn_suspend(adev);
 	if (r)
@@ -231,7 +232,7 @@ static int vcn_v1_0_sw_fini(struct amdgpu_ip_block *ip_block)
 
 	jpeg_v1_0_sw_fini(ip_block);
 
-	r = amdgpu_vcn_sw_fini(adev);
+	r = amdgpu_vcn_sw_fini(adev, inst);
 
 	kfree(adev->vcn.ip_dump);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 834311e13a4c..0481a07054eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -245,9 +245,10 @@ static int vcn_v2_0_sw_init(struct amdgpu_ip_block *ip_block)
  */
 static int vcn_v2_0_sw_fini(struct amdgpu_ip_block *ip_block)
 {
-	int r, idx;
 	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 	volatile struct amdgpu_fw_shared *fw_shared = adev->vcn.inst->fw_shared.cpu_addr;
+	int r, idx;
 
 	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
 		fw_shared->present_flag_0 = 0;
@@ -260,7 +261,7 @@ static int vcn_v2_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	r = amdgpu_vcn_sw_fini(adev);
+	r = amdgpu_vcn_sw_fini(adev, inst);
 
 	kfree(adev->vcn.ip_dump);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index f6d2e3e3bf32..ed972d843f93 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -297,17 +297,18 @@ static int vcn_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
  */
 static int vcn_v2_5_sw_fini(struct amdgpu_ip_block *ip_block)
 {
-	int i, r, idx;
 	struct amdgpu_device *adev = ip_block->adev;
 	volatile struct amdgpu_fw_shared *fw_shared;
+	int inst = ip_block->instance;
+	int r, idx;
 
 	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
-		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-			if (adev->vcn.harvest_config & (1 << i))
-				continue;
-			fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
-			fw_shared->present_flag_0 = 0;
-		}
+		if (adev->vcn.harvest_config & (1 << inst))
+			goto done;
+
+		fw_shared = adev->vcn.inst[inst].fw_shared.cpu_addr;
+		fw_shared->present_flag_0 = 0;
+	done:
 		drm_dev_exit(idx);
 	}
 
@@ -319,7 +320,7 @@ static int vcn_v2_5_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	r = amdgpu_vcn_sw_fini(adev);
+	r = amdgpu_vcn_sw_fini(adev, inst);
 
 	kfree(adev->vcn.ip_dump);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 9b62296cc233..c45bebeb0aaa 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -306,19 +306,19 @@ static int vcn_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
 static int vcn_v3_0_sw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int i, r, idx;
+	int inst = ip_block->instance;
+	int r, idx;
 
 	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
-		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-			volatile struct amdgpu_fw_shared *fw_shared;
+		volatile struct amdgpu_fw_shared *fw_shared;
 
-			if (adev->vcn.harvest_config & (1 << i))
-				continue;
-			fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
-			fw_shared->present_flag_0 = 0;
-			fw_shared->sw_ring.is_enabled = false;
-		}
+		if (adev->vcn.harvest_config & (1 << inst))
+			goto done;
 
+		fw_shared = adev->vcn.inst[inst].fw_shared.cpu_addr;
+		fw_shared->present_flag_0 = 0;
+		fw_shared->sw_ring.is_enabled = false;
+	done:
 		drm_dev_exit(idx);
 	}
 
@@ -329,7 +329,7 @@ static int vcn_v3_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	r = amdgpu_vcn_sw_fini(adev);
+	r = amdgpu_vcn_sw_fini(adev, inst);
 
 	kfree(adev->vcn.ip_dump);
 	return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 79d5ef8f857c..c87b4e46f2b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -258,20 +258,19 @@ static int vcn_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
 static int vcn_v4_0_sw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int i, r, idx;
+	int inst = ip_block->instance;
+	int r, idx;
 
 	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
-		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-			volatile struct amdgpu_vcn4_fw_shared *fw_shared;
+		volatile struct amdgpu_vcn4_fw_shared *fw_shared;
 
-			if (adev->vcn.harvest_config & (1 << i))
-				continue;
-
-			fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
-			fw_shared->present_flag_0 = 0;
-			fw_shared->sq.is_enabled = 0;
-		}
+		if (adev->vcn.harvest_config & (1 << inst))
+			goto done;
 
+		fw_shared = adev->vcn.inst[inst].fw_shared.cpu_addr;
+		fw_shared->present_flag_0 = 0;
+		fw_shared->sq.is_enabled = 0;
+	done:
 		drm_dev_exit(idx);
 	}
 
@@ -282,7 +281,7 @@ static int vcn_v4_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	r = amdgpu_vcn_sw_fini(adev);
+	r = amdgpu_vcn_sw_fini(adev, inst);
 
 	kfree(adev->vcn.ip_dump);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 0932e992d088..0b55d801ae88 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -219,16 +219,16 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
 static int vcn_v4_0_3_sw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int i, r, idx;
+	int inst = ip_block->instance;
+	int r, idx;
 
 	if (drm_dev_enter(&adev->ddev, &idx)) {
-		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-			volatile struct amdgpu_vcn4_fw_shared *fw_shared;
+		volatile struct amdgpu_vcn4_fw_shared *fw_shared;
+
+		fw_shared = adev->vcn.inst[inst].fw_shared.cpu_addr;
+		fw_shared->present_flag_0 = 0;
+		fw_shared->sq.is_enabled = cpu_to_le32(false);
 
-			fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
-			fw_shared->present_flag_0 = 0;
-			fw_shared->sq.is_enabled = cpu_to_le32(false);
-		}
 		drm_dev_exit(idx);
 	}
 
@@ -239,7 +239,7 @@ static int vcn_v4_0_3_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	r = amdgpu_vcn_sw_fini(adev);
+	r = amdgpu_vcn_sw_fini(adev, inst);
 
 	kfree(adev->vcn.ip_dump);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index e551ba1d1e12..b88fdb00cc5e 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -227,20 +227,19 @@ static int vcn_v4_0_5_sw_init(struct amdgpu_ip_block *ip_block)
 static int vcn_v4_0_5_sw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int i, r, idx;
+	int inst = ip_block->instance;
+	int r, idx;
 
 	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
-		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-			volatile struct amdgpu_vcn4_fw_shared *fw_shared;
-
-			if (adev->vcn.harvest_config & (1 << i))
-				continue;
+		volatile struct amdgpu_vcn4_fw_shared *fw_shared;
 
-			fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
-			fw_shared->present_flag_0 = 0;
-			fw_shared->sq.is_enabled = 0;
-		}
+		if (adev->vcn.harvest_config & (1 << inst))
+			goto done;
 
+		fw_shared = adev->vcn.inst[inst].fw_shared.cpu_addr;
+		fw_shared->present_flag_0 = 0;
+		fw_shared->sq.is_enabled = 0;
+	done:
 		drm_dev_exit(idx);
 	}
 
@@ -251,7 +250,7 @@ static int vcn_v4_0_5_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	r = amdgpu_vcn_sw_fini(adev);
+	r = amdgpu_vcn_sw_fini(adev, inst);
 
 	kfree(adev->vcn.ip_dump);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index dc15a74bb3d8..15cdc7be9062 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -194,20 +194,19 @@ static int vcn_v5_0_0_sw_init(struct amdgpu_ip_block *ip_block)
 static int vcn_v5_0_0_sw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int i, r, idx;
+	int inst = ip_block->instance;
+	int r, idx;
 
 	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
-		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-			volatile struct amdgpu_vcn5_fw_shared *fw_shared;
-
-			if (adev->vcn.harvest_config & (1 << i))
-				continue;
+		volatile struct amdgpu_vcn5_fw_shared *fw_shared;
 
-			fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
-			fw_shared->present_flag_0 = 0;
-			fw_shared->sq.is_enabled = 0;
-		}
+		if (adev->vcn.harvest_config & (1 << inst))
+			goto done;
 
+		fw_shared = adev->vcn.inst[inst].fw_shared.cpu_addr;
+		fw_shared->present_flag_0 = 0;
+		fw_shared->sq.is_enabled = 0;
+	done:
 		drm_dev_exit(idx);
 	}
 
@@ -215,7 +214,7 @@ static int vcn_v5_0_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	r = amdgpu_vcn_sw_fini(adev);
+	r = amdgpu_vcn_sw_fini(adev, inst);
 
 	kfree(adev->vcn.ip_dump);
 
-- 
2.34.1

