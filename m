Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 557DDD116E3
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Oct 2024 02:36:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D56BA10E9E8;
	Fri, 25 Oct 2024 02:36:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yZUSobqr";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2054.outbound.protection.outlook.com [40.107.100.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F32D10E9DE
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Oct 2024 02:36:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZpfUnf15nMmALFjcG6VnNr1lxRJ1dp6t8eGEXhfw5eQ0ihWszMKhXFFzUdcNSBeUmOf3BcFZRmBxcOKtl5Gv/+4FLHcRHKeEOagS7MHbsvuKePTD7iv+MJv4QZAXw5nwj13sZtsg8pqV8lxNrno2TvV+ghxsoezwF/5s1lEVKXzhiwgu0fGUv3ZhooLdamYyck2t7ci6iuxDrchAnN8nMq3ktk4xqGxZaweUPqkGZraqMALcoA2yzYLCNg4KcTDtR0dJr05C+pgtN0zUVZnaRSWggY6NeKA7ODzULEiUlpENy+/FIjoAwxqcoUie8zLLG5CftgnAMIVr0MksK67UgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jEsjUDYwn3dwQwBCtgGpQlP/NmOHm4rELsO3DiTXskM=;
 b=oOvsTggJU3S33IrW9znPbv48jWTefdHKUKuD3J0rJE+ezRymIPlmhL+u54/44zkJCRgu02jIQPLvH7VQx2GcFjRX1G6wEPLSAFejy7L+xTZnPwdDEXd+5VTv8kKzPaq7G93DZEUzkHXMoaykyTADAmy9yXoToSjIrhjIzFwKijzX/4otr4TU/BttrAWuBitNB0KrU+koeDbgkTmNvFvLjbqJ96qjhv0Lvs/u58lzBHs6yeW6ajdKh45mq59EBtlgKsN2ZHuppnYQBD5ZwRUt0IXtZ9v9NeCHsxvrD71XghicP3pYdq5idf/P2Y9djF5Ja96PEYb89kdD7mbW6qWAYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEsjUDYwn3dwQwBCtgGpQlP/NmOHm4rELsO3DiTXskM=;
 b=yZUSobqrP1vgYT7/5Q0VuCwwLuyXE84X/r459rsHlh87sCeqqC3rQWd4iHeo0gocCXe6nDLCQiTlUgS6uVVLkKzSfm8WscTWlhKnoPHKpyKesPiBqN1r9ma2wJ6/XcpURLXc+P+xra5MAoqwvQHl4Xf0R59ZsuZZ/i7Ga7sAutM=
Received: from DM6PR18CA0019.namprd18.prod.outlook.com (2603:10b6:5:15b::32)
 by IA1PR12MB6282.namprd12.prod.outlook.com (2603:10b6:208:3e6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 02:36:22 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:5:15b:cafe::75) by DM6PR18CA0019.outlook.office365.com
 (2603:10b6:5:15b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20 via Frontend
 Transport; Fri, 25 Oct 2024 02:36:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 02:36:21 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Oct
 2024 21:36:18 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 22/29] drm/amdgpu: sw_fini for each vcn instance
Date: Thu, 24 Oct 2024 22:35:38 -0400
Message-ID: <20241025023545.465886-23-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025023545.465886-1-boyuan.zhang@amd.com>
References: <20241025023545.465886-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|IA1PR12MB6282:EE_
X-MS-Office365-Filtering-Correlation-Id: fae4961d-b0bb-4cdb-782e-08dcf49dd03b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?T5WxGZ5g3CNuJEuSXJf5fiwRKstxmrxxqvmV5rRsQ1uh0bVIGJc5uMPXUrjk?=
 =?us-ascii?Q?VhgHFQ2JXue40ybwT17n+++0/R+TcUyGZluXqyr0HvyCP4jQOHaStEht9lQw?=
 =?us-ascii?Q?iabgAAS3Fm/TqdhNF5f0IuBKKf8g0VKl8QYDzyjGRDDG0wu9+azLoy5Y5xag?=
 =?us-ascii?Q?1rX70RXT759rDR7PFfaByhbGdIM+HopInH3rsY8icfp5mKBDRHZhHRRgXZV8?=
 =?us-ascii?Q?JCqg/udntbnZLoPcBY7SDJUAbdtHfLFhfm8g9DDFWSQsmg5oXzaIz+IJ+VBR?=
 =?us-ascii?Q?Srr/i5XHaZlRDat+Qc0ewNoVrKoZ42x6qHvtf/hbuRpHgziZT0/BCSyB+HEw?=
 =?us-ascii?Q?L9cteq1kvDSy+Z5tV0n9Hruc9iELxuGnbXS0CFhQ/qqHS0lZekeJVV3KKE+k?=
 =?us-ascii?Q?dKtkQAA29lXAaCkQWx5ZVAzk5FqzF8D/DMNQ/XZ5O769+uIiU+IcYs1ev5Hi?=
 =?us-ascii?Q?OnyYPxW/ruTwYIr+b4m3rAVOlbyED2y5lPwoTf06QVoNeyy5dLII+LVc+YXd?=
 =?us-ascii?Q?BsumyHSjW/Kuyvnwqgsh36GdMghiMjzeAKVbqN95HCJDhuzVn1amlt68kSQN?=
 =?us-ascii?Q?BtGheWE5x9TwodKt5tIA2HQoLEtlmBo4ttgd9Kyon+CxTvt55bbUhzLIoiw0?=
 =?us-ascii?Q?6KKXIBITalawfyCYBhQ/gCtobc80wp+IrjPmK8llBiLJbcVBp15A2k/080aT?=
 =?us-ascii?Q?WeBjn2dd0sFXdIdZ40yFsd2ZRbpo14lxKaJ7bgiQfAiYMnZIEWjLEylalZf+?=
 =?us-ascii?Q?ix80Pie/e/FdBJcyqXtGgdO/orMq2YechZuRK1c8jrkZ73sppnzFw+kyiTk5?=
 =?us-ascii?Q?Vsl/GtV6noOTY5i87ABR2MgEv75pbU3mhcKGKoK4GeXPMLqHOLu+NsTSyoiO?=
 =?us-ascii?Q?a8iPPpG3ntvCzJkEPOAt0DHM8XKnVpXbVaJxCQ/h66Z1tdOOJpm1bJZcLwrU?=
 =?us-ascii?Q?esENjr/3dQz47HVLDtSPAEcMUFvjp6wyhFt8LzIPNWX/kLe5OVNQfUOgLylb?=
 =?us-ascii?Q?yuq/HYx+mpMlm+9ClkZjMViJueaTMxPi0EinFZYQQPDjUAMTdutMtNY7ErBP?=
 =?us-ascii?Q?rmEpfv4J1M6F+i2fvFmdlZcueVEiXLzI4OHU5EAVCwWgD6w45HBFz0laK5MO?=
 =?us-ascii?Q?hVNXh7eAHyRmwEDbICZNDCpg7o90JeTMLx86Qol5C9i8B5EHS09T0T1p7d+c?=
 =?us-ascii?Q?8KzYkU6ZC8TrMVLhUnr4zmyB8CZP3d1fgZxaR7FUlrtkw0QMAkQJX2O2PJbj?=
 =?us-ascii?Q?XbT548/QcOv8eTBw5TcsJB+TOngakz4D7WMHXgJgsH5vih2qal0bT/HeSqoF?=
 =?us-ascii?Q?D7cTZabO4UGMT7kNnXXPClZDQ2rF/hgXNawmKA9xqL5/fSDV/O7Z2+ABFVgb?=
 =?us-ascii?Q?qcLm5eUrmIc3mED3zY29hG0B5XHIrP4qNTNU3gXI2b3HvRArYA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 02:36:21.8493 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fae4961d-b0bb-4cdb-782e-08dcf49dd03b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6282
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
index 2c55166e27d9..d515cfd2da79 100644
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
index 4809da69bd1b..ce8000ca11ef 100644
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
index 808d69ab0904..44370949fa57 100644
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
index a86cff00d761..7b5f2696e60d 100644
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
index 9967ac3fc51b..d135e63e7301 100644
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
index e89088e3cd1d..d00b7a7cbdce 100644
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
index 1b492197c2b7..7c3a62f84707 100644
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
index 5b61000f3004..5a3de3dbc3c9 100644
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
index 4d944636d02b..2c9f863c40b1 100644
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
index 8efedf943581..9d67e884952a 100644
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

