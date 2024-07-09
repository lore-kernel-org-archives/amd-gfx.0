Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79225C2BD09
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jul 2024 05:17:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBAB210E046;
	Tue,  9 Jul 2024 05:17:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZzlXUVoR";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2403E10E47A
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jul 2024 05:17:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ejcv77Om4Ne7AUu9FgnjxDui77IN0OHbGrYQ/FLpvQC6mLCQNAEkGfjFsINxxUofmTzKZcL1zX16q6Y0H5wxKnk7We6hPgBLwFgHn+IKe6guM0v9WFeGgcVE8Egb63BJWSARu1z8SwOajPbup/CAcZZpLC7j8jleF6T9dyC7xBckE/lmFVJOAmQt93u9F/nXP1x4WqL5H5PKJoDT/jHFq72KdrfVaJ6WuOhZrXW02HJb2qoqKmrEi+dRaQZ/7WEI+aX2XH59pvfAS1GlARTgAbgaracbt9Bfw535peQaKfaKzrxRZON5tD9iQVC6zug9svKxyns5VseS1JmVqe0wxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4SizMAnpgieO7K9NNx3h9NPDiMO6OtDwlKKEgMH4WLk=;
 b=e2EuV9Dg8dY+ljg7+1tUf6MLa+daf3TnG4lQf6KAMuTOugllNrQTypilmxlwjBR9+IkcaSH7bjxb3ulsoAZ3z7NWEOdjjYz47re6Aj66bL19OX9pMOp7Z2ku5RCqYV3eplnTkni4v7d4D28zdOOeXARPWdRbhHXq4XHrujo1LqvCU3SZ647KfXSD4PUcQeSUzWcMFtqgYpzPoXe2BH4an4FQBnAXK+t4LsGCO4A3kCFMXPTkAol1BLKoDJbqAYF73doxdK/CkyIaajY/LKzubA8OTh1KSCe/Ewhk5NHtmLDsEIgeYYYoE4ZJbSz68hNJG79iyMGG5DbmdEQqmX/OAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4SizMAnpgieO7K9NNx3h9NPDiMO6OtDwlKKEgMH4WLk=;
 b=ZzlXUVoRuX7D8MtWn2XPYdk7Cm7VXWs1RKnK2e9BThStnhLxRDu8lO73vOutI1AoDDzzCV/ePhxrzPzdSul88Sn7LcgmqxDyOCULhfe7xWCedZXhJVbi+yqMeWIVovLMh1puenDgFH/Stq3khqAK3fInQzYzofk3JkfQZysG7Vs=
Received: from CH3P221CA0025.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::20)
 by MW4PR12MB7216.namprd12.prod.outlook.com (2603:10b6:303:226::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.34; Tue, 9 Jul
 2024 05:17:49 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:1e7:cafe::25) by CH3P221CA0025.outlook.office365.com
 (2603:10b6:610:1e7::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Tue, 9 Jul 2024 05:17:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Tue, 9 Jul 2024 05:17:48 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 9 Jul
 2024 00:17:45 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Satya.Thadvai@amd.com>, <HaiJun.Chang@amd.com>, <Lianjie.Shi@amd.com>
Subject: [PATCH] drm/amdgpu: Initialize VF partition mode
Date: Tue, 9 Jul 2024 10:47:29 +0530
Message-ID: <20240709051729.1364475-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|MW4PR12MB7216:EE_
X-MS-Office365-Filtering-Correlation-Id: 79b4f764-e570-43fb-586e-08dc9fd67955
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?d+Xy9fsv75qRpEOcKoOzpLOkgXvCRLUtnxelexAsUQch17G36cTOiFSUk82f?=
 =?us-ascii?Q?pGH4hnXUlAqKdMsxnXF8vwbMGNWHKIiVOmFN9aHdb5v0FHXCo9TDc1fWLQnF?=
 =?us-ascii?Q?aYFQmFSxqvl0vb+q6kkLCWd8wfxWLEFdThQaPHZgk08mHMGGW2HZ0db+jtxA?=
 =?us-ascii?Q?3+9EtFrrFsx7np4t8rD5qD3R3kPZemLAdw6U/fbfqqMVTai3g59hku4OVwzi?=
 =?us-ascii?Q?YTCreMHZq0e3QkfGKWSC8kVMc4y8gecxi/9J5DofoWzvTQ8Ss/zZXl/7XcpS?=
 =?us-ascii?Q?ljokmdJdMiHwshD/Vg4jfB780K7eVYyHmmLkrkWGYAWGDJVd3+b09fXGzYc6?=
 =?us-ascii?Q?ndsOSzFW6K4fweEa+E6lVxX3nJMXCmPy5EQqpbZewnBum6UIH2uTwjle/rKs?=
 =?us-ascii?Q?W179T424vulrtau91C1hqEj7PkxiuxEpA2MlZzBuzR6abs7dDnRWsb57LC26?=
 =?us-ascii?Q?cwdB7pyUO7k0Rv1ie3SaYPUqUKOlpgPMAJ7f2CmKIwyw3jUucToPa7iq10gw?=
 =?us-ascii?Q?PXrta9YzC/fVnEJpk9fWPgPJVnrELhot/7L88xNQB0u8+p7OrMpkAYggT8vm?=
 =?us-ascii?Q?oO2Y4gh9GYRbG7EwvPb/YwxZv1kBT46uj6oI8dTeQXjuhSRFODYkY7ETTcZT?=
 =?us-ascii?Q?q2lulwvEdqWXzHqftiqh0rFWbF33qweOGoZ5BeFxtLy+YE9w+5f9efpuYyhG?=
 =?us-ascii?Q?poVAcTPAs5wcO4QUWEYW2++9yYfaqZknKDwUF/nrUaHdQLUYCibPS5IHyByt?=
 =?us-ascii?Q?fHMZW+ZYPGlmFOD9BBfK0ayi6yHXAMzlH1tXju9ELho26zHa675f09PE+4gN?=
 =?us-ascii?Q?hYbVHbC9NV/6d8TF5Cf+o9+OOJqXhU9yBh89/eVz7F2kGJmCBpy3zjDzmP6F?=
 =?us-ascii?Q?NU/VKA/q3UXcFyFWu8j5YktS9JCFaePJpgo+V3OtDRNE4uNE85sKjJ8m7YY9?=
 =?us-ascii?Q?g2g9ypkDIZbozfJT53T1bHSboYdcmH7TU7q+3NYyr4C1smUk2OplIm4EoV8f?=
 =?us-ascii?Q?wW27aSRfhDohn0Ux6+wPtAVX1nz9Xbhl0dB2CGqGrW4PvfIsBfgrEJkxfpJK?=
 =?us-ascii?Q?gpeIQdk4XlXrKwyeQ0dfDgztZLwfhFaWSgWyHmlESTcO1mM0r3vjRyII8fqM?=
 =?us-ascii?Q?Kh/J5dH8aVIliW0QUxJL+fcpiiOSdqB6pGl5JTgrOzXGGzyKG9YuZ6cn0VxY?=
 =?us-ascii?Q?QVQ5A3MrR/ifdepv6AVxXE05rGrJITdyagV4t/vgJsM1+d7DrQ0oEOQi1mQA?=
 =?us-ascii?Q?oT+8VB3MI9MlV2KSMqqhVyR0OWwkgxA/IGZW06BBMHydqenQHODkLB4+FqqC?=
 =?us-ascii?Q?kJzlFEPasY8QEptWQv8WEZY8h/udu1k7+VIHkDVQ6FZ/edpge+Q97PrXPQ0W?=
 =?us-ascii?Q?gX4XIVSd6RmmHh2hi5n1UgyDNkOXbOYRJfaMeO8gfJFAcyLwG11poWa7MDFT?=
 =?us-ascii?Q?ZfgW1y0Q+zOQIjn8peF68YeScGjC76ZU?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 05:17:48.4566 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79b4f764-e570-43fb-586e-08dc9fd67955
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7216
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

For SOCs with GFX v9.4.3, a VF may have multiple compute partitions.
Fetch the partition information during init and initialize partition
nodes. There is no support to switch partition mode in VF mode, hence
disable the same.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c    | 12 ++++--
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c | 50 +++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c    | 37 +++++++++++++---
 4 files changed, 88 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 6b0416777c5b..ddda94e49db4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -297,6 +297,7 @@ struct amdgpu_gfx_funcs {
 	int (*switch_partition_mode)(struct amdgpu_device *adev,
 				     int num_xccs_per_xcp);
 	int (*ih_node_to_logical_xcc)(struct amdgpu_device *adev, int ih_node);
+	int (*get_xccs_per_xcp)(struct amdgpu_device *adev);
 };
 
 struct sq_work {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
index 2b99eed5ba19..a6d456ec6aeb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -219,7 +219,8 @@ int amdgpu_xcp_query_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr, u32 flags)
 {
 	int mode;
 
-	if (xcp_mgr->mode == AMDGPU_XCP_MODE_NONE)
+	if (!amdgpu_sriov_vf(xcp_mgr->adev) &&
+	    xcp_mgr->mode == AMDGPU_XCP_MODE_NONE)
 		return xcp_mgr->mode;
 
 	if (!xcp_mgr->funcs || !xcp_mgr->funcs->query_partition_mode)
@@ -228,6 +229,12 @@ int amdgpu_xcp_query_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr, u32 flags)
 	if (!(flags & AMDGPU_XCP_FL_LOCKED))
 		mutex_lock(&xcp_mgr->xcp_lock);
 	mode = xcp_mgr->funcs->query_partition_mode(xcp_mgr);
+
+	/* First time query for VF, set the mode here */
+	if (amdgpu_sriov_vf(xcp_mgr->adev) &&
+	    xcp_mgr->mode == AMDGPU_XCP_MODE_NONE)
+		xcp_mgr->mode = mode;
+
 	if (xcp_mgr->mode != AMDGPU_XCP_MODE_TRANS && mode != xcp_mgr->mode)
 		dev_WARN(
 			xcp_mgr->adev->dev,
@@ -282,8 +289,7 @@ int amdgpu_xcp_mgr_init(struct amdgpu_device *adev, int init_mode,
 {
 	struct amdgpu_xcp_mgr *xcp_mgr;
 
-	if (!xcp_funcs || !xcp_funcs->switch_partition_mode ||
-	    !xcp_funcs->get_ip_details)
+	if (!xcp_funcs || !xcp_funcs->get_ip_details)
 		return -EINVAL;
 
 	xcp_mgr = kzalloc(sizeof(*xcp_mgr), GFP_KERNEL);
diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
index 2c9a0aa41e2d..228fd4dd32f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
@@ -304,13 +304,56 @@ u64 aqua_vanjaram_encode_ext_smn_addressing(int ext_id)
 	return ext_offset;
 }
 
+static enum amdgpu_gfx_partition
+__aqua_vanjaram_calc_xcp_mode(struct amdgpu_xcp_mgr *xcp_mgr)
+{
+	struct amdgpu_device *adev = xcp_mgr->adev;
+	int num_xcc, num_xcc_per_xcp = 0, mode = 0;
+
+	num_xcc = NUM_XCC(xcp_mgr->adev->gfx.xcc_mask);
+	if (adev->gfx.funcs->get_xccs_per_xcp)
+		num_xcc_per_xcp = adev->gfx.funcs->get_xccs_per_xcp(adev);
+	if ((num_xcc_per_xcp) && (num_xcc % num_xcc_per_xcp == 0))
+		mode = num_xcc / num_xcc_per_xcp;
+
+	if (num_xcc_per_xcp == 1)
+		return AMDGPU_CPX_PARTITION_MODE;
+
+	switch (mode) {
+	case 1:
+		return AMDGPU_SPX_PARTITION_MODE;
+	case 2:
+		return AMDGPU_DPX_PARTITION_MODE;
+	case 3:
+		return AMDGPU_TPX_PARTITION_MODE;
+	case 4:
+		return AMDGPU_QPX_PARTITION_MODE;
+	default:
+		return AMDGPU_UNKNOWN_COMPUTE_PARTITION_MODE;
+	}
+
+	return AMDGPU_UNKNOWN_COMPUTE_PARTITION_MODE;
+}
+
 static int aqua_vanjaram_query_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr)
 {
-	enum amdgpu_gfx_partition mode = AMDGPU_UNKNOWN_COMPUTE_PARTITION_MODE;
+	enum amdgpu_gfx_partition derv_mode,
+		mode = AMDGPU_UNKNOWN_COMPUTE_PARTITION_MODE;
 	struct amdgpu_device *adev = xcp_mgr->adev;
 
-	if (adev->nbio.funcs->get_compute_partition_mode)
+	derv_mode = __aqua_vanjaram_calc_xcp_mode(xcp_mgr);
+
+	if (amdgpu_sriov_vf(adev))
+		return derv_mode;
+
+	if (adev->nbio.funcs->get_compute_partition_mode) {
 		mode = adev->nbio.funcs->get_compute_partition_mode(adev);
+		if (mode != derv_mode)
+			dev_warn(
+				adev->dev,
+				"Mismatch in compute partition mode - reported : %d derived : %d",
+				mode, derv_mode);
+	}
 
 	return mode;
 }
@@ -624,6 +667,9 @@ static int aqua_vanjaram_xcp_mgr_init(struct amdgpu_device *adev)
 {
 	int ret;
 
+	if (amdgpu_sriov_vf(adev))
+		aqua_vanjaram_xcp_funcs.switch_partition_mode = NULL;
+
 	ret = amdgpu_xcp_mgr_init(adev, AMDGPU_UNKNOWN_COMPUTE_PARTITION_MODE, 1,
 				  &aqua_vanjaram_xcp_funcs);
 	if (ret)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index c908e585b9ec..20ea6cb01edf 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -652,6 +652,15 @@ static void gfx_v9_4_3_select_me_pipe_q(struct amdgpu_device *adev,
 	soc15_grbm_select(adev, me, pipe, q, vm, GET_INST(GC, xcc_id));
 }
 
+static int gfx_v9_4_3_get_xccs_per_xcp(struct amdgpu_device *adev)
+{
+	u32 xcp_ctl;
+
+	/* Value is expected to be the same on all, fetch from first instance */
+	xcp_ctl = RREG32_SOC15(GC, GET_INST(GC, 0), regCP_HYP_XCP_CTL);
+
+	return REG_GET_FIELD(xcp_ctl, CP_HYP_XCP_CTL, NUM_XCC_IN_XCP);
+}
 
 static int gfx_v9_4_3_switch_compute_partition(struct amdgpu_device *adev,
 						int num_xccs_per_xcp)
@@ -706,6 +715,7 @@ static const struct amdgpu_gfx_funcs gfx_v9_4_3_gfx_funcs = {
 	.select_me_pipe_q = &gfx_v9_4_3_select_me_pipe_q,
 	.switch_partition_mode = &gfx_v9_4_3_switch_compute_partition,
 	.ih_node_to_logical_xcc = &gfx_v9_4_3_ih_to_xcc_inst,
+	.get_xccs_per_xcp = &gfx_v9_4_3_get_xccs_per_xcp,
 };
 
 static int gfx_v9_4_3_aca_bank_parser(struct aca_handle *handle,
@@ -2050,18 +2060,31 @@ static int gfx_v9_4_3_xcc_cp_resume(struct amdgpu_device *adev, int xcc_id)
 
 static int gfx_v9_4_3_cp_resume(struct amdgpu_device *adev)
 {
-	int r = 0, i, num_xcc;
+	int r = 0, i, num_xcc, num_xcp, num_xcc_per_xcp;
+
+	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+	if (amdgpu_sriov_vf(adev)) {
+		enum amdgpu_gfx_partition mode;
 
-	if (amdgpu_xcp_query_partition_mode(adev->xcp_mgr,
-					    AMDGPU_XCP_FL_NONE) ==
-	    AMDGPU_UNKNOWN_COMPUTE_PARTITION_MODE)
-		r = amdgpu_xcp_switch_partition_mode(adev->xcp_mgr,
-						     amdgpu_user_partt_mode);
+		mode = amdgpu_xcp_query_partition_mode(adev->xcp_mgr,
+						       AMDGPU_XCP_FL_NONE);
+		if (mode == AMDGPU_UNKNOWN_COMPUTE_PARTITION_MODE)
+			return -EINVAL;
+		num_xcc_per_xcp = gfx_v9_4_3_get_xccs_per_xcp(adev);
+		adev->gfx.num_xcc_per_xcp = num_xcc_per_xcp;
+		num_xcp = num_xcc / num_xcc_per_xcp;
+		r = amdgpu_xcp_init(adev->xcp_mgr, num_xcp, mode);
 
+	} else {
+		if (amdgpu_xcp_query_partition_mode(adev->xcp_mgr,
+						    AMDGPU_XCP_FL_NONE) ==
+		    AMDGPU_UNKNOWN_COMPUTE_PARTITION_MODE)
+			r = amdgpu_xcp_switch_partition_mode(
+				adev->xcp_mgr, amdgpu_user_partt_mode);
+	}
 	if (r)
 		return r;
 
-	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
 	for (i = 0; i < num_xcc; i++) {
 		r = gfx_v9_4_3_xcc_cp_resume(adev, i);
 		if (r)
-- 
2.25.1

