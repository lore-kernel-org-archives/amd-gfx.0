Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B266EE77186
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2024 22:54:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FF0B10EA08;
	Tue, 10 Dec 2024 22:54:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zBc/Absn";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7DD410EA07
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2024 22:54:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c+9FHo7WeqPQg5OhbPvyEYVAInJl8NN9+EsMnxFmv5OBPo8e8PQbj724hBQVoU9UEdJthmqroFO69K68YkT/z4H8tpFczWc5spwjQpp56/OSFSQnbl8itjYwHE+3PqzTk5baBut0uWruljgW76ebwh85TA/JzMLhSdgHp9uvVipO5qhAC7zxUOJMLw9Hn0WRU59MpdrJyte3rZNRlSl8OYaTjrtMF997yXGeJtoUHFaDHL07pMimm8OUC3GavSmG8jvJvqcVPAOqsca5X180uhnLCk/dlc3dTDVORXhsnlyTqtBH3RB9Icn93FfSL8JwUqRwM28helWNTYnbuC/Qow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YXROFuOLw1bys/+LsV6Sxtk6br4R1eVznzRYBpwgn/I=;
 b=Hfq5J3hn2VFGDtfa3bB/y/FR4kWe3hiZHCd3O5Mi2S4IOtjc83xiiTI5TgcZC2RvBH57/sgzsvYswAVHgPQN7v85SKtEFfVkkFc/zDvsg0gv0e6hjvZz6OmaJZmrB+GIr6J5n6rUWaE1mxz4ORIXj3dFP6rwDUekE/S/5JtrV3BIWKuBORCQ9EAWlMJRGJr/DBaas5kcNvvZ51VEbAvYNKoWWrziCRafAWrhFnTyQCphLrcQgrbrvCabGzfXetpQFdlvKzTinAFDdG90NLzu7Uue0/Jcmze3AfvAyKsXgSdbywhRGngU6JGnn5Jq9szBgSWc1PFf3k92tsM7NWbdgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YXROFuOLw1bys/+LsV6Sxtk6br4R1eVznzRYBpwgn/I=;
 b=zBc/AbsnjrWiV3mO4KeXxwm8pLv61HsA+PBqPvQLT00G+frCiD3H+3/V41Z9t+ADN3UPLjkItZAL2GKUGiS7ZLiZCOGsvaw3E7NAGkiWIgsECEM703rYoptVDFJp8BM8kIolABL1kL8zlj5MivsFf2oQkb4EIOPpnnKLJiNKl94=
Received: from MN2PR01CA0019.prod.exchangelabs.com (2603:10b6:208:10c::32) by
 PH8PR12MB7157.namprd12.prod.outlook.com (2603:10b6:510:22b::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.12; Tue, 10 Dec 2024 22:54:18 +0000
Received: from BN2PEPF000055E1.namprd21.prod.outlook.com
 (2603:10b6:208:10c:cafe::c3) by MN2PR01CA0019.outlook.office365.com
 (2603:10b6:208:10c::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.19 via Frontend Transport; Tue,
 10 Dec 2024 22:54:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055E1.mail.protection.outlook.com (10.167.245.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8272.0 via Frontend Transport; Tue, 10 Dec 2024 22:54:18 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 16:54:15 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 44/48] drm/amdgpu: use new helper to get num instances for VCN
Date: Tue, 10 Dec 2024 17:53:33 -0500
Message-ID: <20241210225337.75394-45-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241210225337.75394-1-alexander.deucher@amd.com>
References: <20241210225337.75394-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E1:EE_|PH8PR12MB7157:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b1e97aa-aca3-4c55-3d94-08dd196d9425
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ucynBH58UN1C6XlBdCbxCPoFOrRZ3zjHPXZdS2JEI6k3EnDWf7+GS6yrBVps?=
 =?us-ascii?Q?jIyQR/M6KpZqxUetSNMfVZm3vieAqmKpdPOKY3lzDW9p5Zd2Kp/bHQXL+Meb?=
 =?us-ascii?Q?zKXro9nPkgGdQfEvje5WLBE4JNffI3EWF0TTzpRTMWKGVOxEcrnce9RFjp9j?=
 =?us-ascii?Q?Fsze7+KUNiaoVa1bH/gflbScfacoAboBTlJPDaHhR0Rc3uNduqn2CF62qTWK?=
 =?us-ascii?Q?Bl+qks742kWRsc/8LjKikpWhGpqyjOV6xbtdQGOLtDmPx3N+AiXoarx7yGU0?=
 =?us-ascii?Q?1JVl0zMVpBF0W3FQuorwuY+cykEYM1J5+XXawBzRn4ayzN2HDdcUx+6pN91X?=
 =?us-ascii?Q?2DesbkBg3C+2LLg8KFHIusSGqdPbNrXJu86yLieRBqWnsrbmTXwSljm5IHEB?=
 =?us-ascii?Q?FOCDgV+Mz2+5XpbtE+HD9wEf6aASnfXmpAu9AqzfRcYhj2fxylLrUhbxcnsf?=
 =?us-ascii?Q?XSNxUt4VgOD5POpCkX9EfgEKdnbXlwQZUXZ/55mRb1ZjOTRpR94lu/IfSJjy?=
 =?us-ascii?Q?xa4IF1G2gpIMd8Krv6AI8bCiIn56vDaNtSO9BDGAqHyPTLJbMZebEPqVZRzy?=
 =?us-ascii?Q?iw2t1KXa5JNdrwIUlcTOW3yjbrNIoBVrjXWO7OWriXtoSW/hkEDpybdnwViU?=
 =?us-ascii?Q?Qe3J5ftfVVPQVYZC1XvoT5CSTYQnzfrXJ5bl6t/A92TWrr9IUKpxnbQAgh/a?=
 =?us-ascii?Q?xIEf4FHE9B08YylApcUnnVmRbQcAlKtZaVNUppyrWlCX9lUdwV+Ok2cqZfe2?=
 =?us-ascii?Q?VDjLjD1VRzNh7Kckr1PH9j2Q21WiOF9SsjxJQKr0F7XYZ4f2IPUgs/sV8Y+F?=
 =?us-ascii?Q?I1m3EzFNt+76uGThb12WTfanWOVsRwd+v6KGuejLrNWG+QATClA87lyUiHd6?=
 =?us-ascii?Q?zo612eBiKF4FaPyoKlZ5tztuANjk35maT3EFUFN61qShIJnYjmqT2E1x7mt5?=
 =?us-ascii?Q?3NezhcSs+VzqxiA0XR+AEXYMGk8CU7hXBEPM5fhXgePAxeRkmJQtWzJFjZCQ?=
 =?us-ascii?Q?6zeEWDH9mCEdZK4SlsGqdb+Ig9ympSvb6gJpwpH4LBwU5pS0J8bfjbcrgpFx?=
 =?us-ascii?Q?RMmVbOrFahzase6qW5I3AEyShCF9r2dOxt2kbdODwp+LvMh6UFezobctg6YY?=
 =?us-ascii?Q?3oNJKvWcHiiOsFi3yopLotMeB2epzRkkTGIUgYj8Al19rij2Lv47zKImbVrX?=
 =?us-ascii?Q?j4F/9Sv++bzJ5RuNbFCAbE2chtHmS0XrL/d7m6/HSbDfkDnxAHdoZB5GBC5f?=
 =?us-ascii?Q?gtj8FuFYTy0Dr+OQ/Ux20//RTzGDPmSmfE9+WBZvugRSOMQ6pgxgzXMV3OrE?=
 =?us-ascii?Q?vTZ4l4wrlQlVMsvlIB7Crwb9h5z4wPOsqOQ9VzJYggUGOceqRGFFMFEhK8XS?=
 =?us-ascii?Q?W55/7dsO90DNexIn+GkY1uhdwQ0DvjhbAkNoqt44XNvUCwHsNQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 22:54:18.3295 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b1e97aa-aca3-4c55-3d94-08dd196d9425
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055E1.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7157
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

Use the helper for all non-VCN code which queries the number
of VCN instances.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |  9 +++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  5 +++--
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c    |  8 ++++---
 drivers/gpu/drm/amd/amdgpu/nv.c               |  4 +++-
 drivers/gpu/drm/amd/amdgpu/soc21.c            |  4 +++-
 drivers/gpu/drm/amd/amdgpu/soc24.c            |  4 +++-
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  2 +-
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  6 ++++--
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 21 ++++++++++++-------
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  5 +++--
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  5 +++--
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c    |  5 +++--
 13 files changed, 52 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 49ca8c814455d..7c3719ef07070 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -2028,6 +2028,7 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
 
 int amdgpu_debugfs_init(struct amdgpu_device *adev)
 {
+	int num_vcn_inst = amdgpu_device_ip_get_num_inst(adev, AMD_IP_BLOCK_TYPE_VCN);
 	struct dentry *root = adev_to_drm(adev)->primary->debugfs_root;
 	struct dentry *ent;
 	int r, i;
@@ -2082,7 +2083,7 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 		amdgpu_debugfs_ring_init(adev, ring);
 	}
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
+	for (i = 0; i < num_vcn_inst; i++) {
 		if (!amdgpu_vcnfw_log)
 			break;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 5204d1217cec4..e1e0f80b23606 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -400,6 +400,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 	enum amd_ip_block_type type;
 	unsigned int num_rings = 0;
 	unsigned int i, j;
+	int num_inst;
 
 	if (info->query_hw_ip.ip_instance >= AMDGPU_HW_IP_INSTANCE_MAX_COUNT)
 		return -EINVAL;
@@ -464,7 +465,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 		break;
 	case AMDGPU_HW_IP_VCN_DEC:
 		type = AMD_IP_BLOCK_TYPE_VCN;
-		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
+		num_inst = amdgpu_device_ip_get_num_inst(adev, AMD_IP_BLOCK_TYPE_VCN);
+		for (i = 0; i < num_inst; i++) {
 			if (adev->vcn.harvest_config & (1 << i))
 				continue;
 
@@ -476,7 +478,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 		break;
 	case AMDGPU_HW_IP_VCN_ENC:
 		type = AMD_IP_BLOCK_TYPE_VCN;
-		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
+		num_inst = amdgpu_device_ip_get_num_inst(adev, AMD_IP_BLOCK_TYPE_VCN);
+		for (i = 0; i < num_inst; i++) {
 			if (adev->vcn.harvest_config & (1 << i))
 				continue;
 
@@ -686,7 +689,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 			count = adev->jpeg.num_jpeg_inst * adev->jpeg.num_jpeg_rings;
 			break;
 		case AMD_IP_BLOCK_TYPE_VCN:
-			count = adev->vcn.num_vcn_inst;
+			count = amdgpu_device_ip_get_num_inst(adev, AMD_IP_BLOCK_TYPE_VCN);
 			break;
 		case AMD_IP_BLOCK_TYPE_UVD:
 			count = adev->uvd.num_uvd_inst;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index db081618e85c3..66ec1a4da7343 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -358,7 +358,7 @@ static void amdgpu_ras_instance_mask_check(struct amdgpu_device *adev,
 				struct ras_debug_if *data)
 {
 	int num_xcc = adev->gfx.xcc_mask ? NUM_XCC(adev->gfx.xcc_mask) : 1;
-	uint32_t mask, inst_mask = data->inject.instance_mask;
+	uint32_t mask, inst, inst_mask = data->inject.instance_mask;
 
 	/* no need to set instance mask if there is only one instance */
 	if (num_xcc <= 1 && inst_mask) {
@@ -379,7 +379,8 @@ static void amdgpu_ras_instance_mask_check(struct amdgpu_device *adev,
 		break;
 	case AMDGPU_RAS_BLOCK__VCN:
 	case AMDGPU_RAS_BLOCK__JPEG:
-		mask = GENMASK(adev->vcn.num_vcn_inst - 1, 0);
+		inst = amdgpu_device_ip_get_num_inst(adev, AMD_IP_BLOCK_TYPE_VCN);
+		mask = GENMASK(inst - 1, 0);
 		break;
 	default:
 		mask = inst_mask;
diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
index e157d6d857b6e..ab7a2ba59a1bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
@@ -64,7 +64,9 @@ void aqua_vanjaram_doorbell_index_init(struct amdgpu_device *adev)
 
 static bool aqua_vanjaram_xcp_vcn_shared(struct amdgpu_device *adev)
 {
-	return (adev->xcp_mgr->num_xcps > adev->vcn.num_vcn_inst);
+	int num_vcn_inst = amdgpu_device_ip_get_num_inst(adev, AMD_IP_BLOCK_TYPE_VCN);
+
+	return adev->xcp_mgr->num_xcps > num_vcn_inst;
 }
 
 static void aqua_vanjaram_set_xcp_id(struct amdgpu_device *adev,
@@ -398,7 +400,7 @@ static int __aqua_vanjaram_get_xcp_ip_info(struct amdgpu_xcp_mgr *xcp_mgr, int x
 	int num_xcc_xcp, num_sdma_xcp, num_vcn_xcp;
 
 	num_sdma = adev->sdma.num_instances;
-	num_vcn = adev->vcn.num_vcn_inst;
+	num_vcn = amdgpu_device_ip_get_num_inst(adev, AMD_IP_BLOCK_TYPE_VCN);
 	num_shared_vcn = 1;
 
 	num_xcc_xcp = adev->gfx.num_xcc_per_xcp;
@@ -462,7 +464,7 @@ static int aqua_vanjaram_get_xcp_res_info(struct amdgpu_xcp_mgr *xcp_mgr,
 
 	max_res[AMDGPU_XCP_RES_XCC] = NUM_XCC(adev->gfx.xcc_mask);
 	max_res[AMDGPU_XCP_RES_DMA] = adev->sdma.num_instances;
-	max_res[AMDGPU_XCP_RES_DEC] = adev->vcn.num_vcn_inst;
+	max_res[AMDGPU_XCP_RES_DEC] = amdgpu_device_ip_get_num_inst(adev, AMD_IP_BLOCK_TYPE_VCN);
 	max_res[AMDGPU_XCP_RES_JPEG] = adev->jpeg.num_jpeg_inst;
 
 	switch (mode) {
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 47db483c35169..a14865c02d73b 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -210,7 +210,9 @@ static const struct amdgpu_video_codecs yc_video_codecs_decode = {
 static int nv_query_video_codecs(struct amdgpu_device *adev, bool encode,
 				 const struct amdgpu_video_codecs **codecs)
 {
-	if (adev->vcn.num_vcn_inst == hweight8(adev->vcn.harvest_config))
+	int num_vcn_inst = amdgpu_device_ip_get_num_inst(adev, AMD_IP_BLOCK_TYPE_VCN);
+
+	if (!num_vcn_inst)
 		return -EINVAL;
 
 	switch (amdgpu_ip_version(adev, UVD_HWIP, 0)) {
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 62ad67d0b598f..7ee3f1d2fcd24 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -150,7 +150,9 @@ static struct amdgpu_video_codecs sriov_vcn_4_0_0_video_codecs_decode_vcn1 = {
 static int soc21_query_video_codecs(struct amdgpu_device *adev, bool encode,
 				 const struct amdgpu_video_codecs **codecs)
 {
-	if (adev->vcn.num_vcn_inst == hweight8(adev->vcn.harvest_config))
+	int num_vcn_inst = amdgpu_device_ip_get_num_inst(adev, AMD_IP_BLOCK_TYPE_VCN);
+
+	if (!num_vcn_inst)
 		return -EINVAL;
 
 	switch (amdgpu_ip_version(adev, UVD_HWIP, 0)) {
diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgpu/soc24.c
index 6b8e078ee7c75..8958f1e544e04 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc24.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
@@ -74,7 +74,9 @@ static const struct amdgpu_video_codecs vcn_5_0_0_video_codecs_decode_vcn0 = {
 static int soc24_query_video_codecs(struct amdgpu_device *adev, bool encode,
 				 const struct amdgpu_video_codecs **codecs)
 {
-	if (adev->vcn.num_vcn_inst == hweight8(adev->vcn.harvest_config))
+	int num_vcn_inst = amdgpu_device_ip_get_num_inst(adev, AMD_IP_BLOCK_TYPE_VCN);
+
+	if (!num_vcn_inst)
 		return -EINVAL;
 
 	switch (amdgpu_ip_version(adev, UVD_HWIP, 0)) {
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 6a9e26905edfc..71797b06f94f8 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -81,7 +81,7 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev,
 	bool is_vcn = (block_type == AMD_IP_BLOCK_TYPE_UVD || block_type == AMD_IP_BLOCK_TYPE_VCN);
 
 	if (atomic_read(&adev->pm.pwr_state[block_type]) == pwr_state &&
-			(!is_vcn || adev->vcn.num_vcn_inst == 1)) {
+	    (!is_vcn || amdgpu_device_ip_get_num_inst(adev, AMD_IP_BLOCK_TYPE_VCN) == 1)) {
 		dev_dbg(adev->dev, "IP block%d already in the target %s state!",
 				block_type, gate ? "gate" : "ungate");
 		return 0;
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index e8ae7681bf0a3..adedad84cbb6a 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2093,7 +2093,8 @@ static int pp_dpm_clk_default_attr_update(struct amdgpu_device *adev, struct amd
 		if (!((gc_ver == IP_VERSION(10, 3, 1) ||
 		       gc_ver == IP_VERSION(10, 3, 0) ||
 		       gc_ver == IP_VERSION(11, 0, 2) ||
-		       gc_ver == IP_VERSION(11, 0, 3)) && adev->vcn.num_vcn_inst >= 2))
+		       gc_ver == IP_VERSION(11, 0, 3)) &&
+		      amdgpu_device_ip_get_num_inst(adev, AMD_IP_BLOCK_TYPE_VCN) >= 2))
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_dpm_dclk)) {
 		if (!(gc_ver == IP_VERSION(10, 3, 1) ||
@@ -2115,7 +2116,8 @@ static int pp_dpm_clk_default_attr_update(struct amdgpu_device *adev, struct amd
 		if (!((gc_ver == IP_VERSION(10, 3, 1) ||
 		       gc_ver == IP_VERSION(10, 3, 0) ||
 		       gc_ver == IP_VERSION(11, 0, 2) ||
-		       gc_ver == IP_VERSION(11, 0, 3)) && adev->vcn.num_vcn_inst >= 2))
+		       gc_ver == IP_VERSION(11, 0, 3)) &&
+		      amdgpu_device_ip_get_num_inst(adev, AMD_IP_BLOCK_TYPE_VCN) >= 2))
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_dpm_pcie)) {
 		if (gc_ver == IP_VERSION(9, 4, 2) ||
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index e5dd0bb31c386..566edfbdad17f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -788,19 +788,20 @@ static int smu_set_default_dpm_table(struct smu_context *smu)
 	struct smu_power_gate *power_gate = &smu_power->power_gate;
 	int vcn_gate[AMDGPU_MAX_VCN_INSTANCES], jpeg_gate, i;
 	int ret = 0;
+	int num_vcn_inst = amdgpu_device_ip_get_num_inst(adev, AMD_IP_BLOCK_TYPE_VCN);
 
 	if (!smu->ppt_funcs->set_default_dpm_table)
 		return 0;
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN) {
-		for (i = 0; i < adev->vcn.num_vcn_inst; i++)
+		for (i = 0; i < num_vcn_inst; i++)
 			vcn_gate[i] = atomic_read(&power_gate->vcn_gated[i]);
 	}
 	if (adev->pg_flags & AMD_PG_SUPPORT_JPEG)
 		jpeg_gate = atomic_read(&power_gate->jpeg_gated);
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN) {
-		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
+		for (i = 0; i < num_vcn_inst; i++) {
 			ret = smu_dpm_set_vcn_enable(smu, true, i);
 			if (ret)
 				return ret;
@@ -822,7 +823,7 @@ static int smu_set_default_dpm_table(struct smu_context *smu)
 		smu_dpm_set_jpeg_enable(smu, !jpeg_gate);
 err_out:
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN) {
-		for (i = 0; i < adev->vcn.num_vcn_inst; i++)
+		for (i = 0; i < num_vcn_inst; i++)
 			smu_dpm_set_vcn_enable(smu, !vcn_gate[i], i);
 	}
 
@@ -1279,6 +1280,7 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	struct smu_context *smu = adev->powerplay.pp_handle;
 	int i, ret;
+	int num_vcn_inst = amdgpu_device_ip_get_num_inst(adev, AMD_IP_BLOCK_TYPE_VCN);
 
 	smu->pool_size = adev->pm.smu_prv_buffer_size;
 	smu->smu_feature.feature_num = SMU_FEATURE_MAX;
@@ -1290,7 +1292,7 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_block)
 	atomic64_set(&smu->throttle_int_counter, 0);
 	smu->watermarks_bitmap = 0;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; i++)
+	for (i = 0; i < num_vcn_inst; i++)
 		atomic_set(&smu->smu_power.power_gate.vcn_gated[i], 1);
 	atomic_set(&smu->smu_power.power_gate.jpeg_gated, 1);
 	atomic_set(&smu->smu_power.power_gate.vpe_gated, 1);
@@ -1824,6 +1826,7 @@ static int smu_hw_init(struct amdgpu_ip_block *ip_block)
 	int i, ret;
 	struct amdgpu_device *adev = ip_block->adev;
 	struct smu_context *smu = adev->powerplay.pp_handle;
+	int num_vcn_inst = amdgpu_device_ip_get_num_inst(adev, AMD_IP_BLOCK_TYPE_VCN);
 
 	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev)) {
 		smu->pm_enabled = false;
@@ -1847,7 +1850,7 @@ static int smu_hw_init(struct amdgpu_ip_block *ip_block)
 		ret = smu_set_gfx_imu_enable(smu);
 		if (ret)
 			return ret;
-		for (i = 0; i < adev->vcn.num_vcn_inst; i++)
+		for (i = 0; i < num_vcn_inst; i++)
 			smu_dpm_set_vcn_enable(smu, true, i);
 		smu_dpm_set_jpeg_enable(smu, true);
 		smu_dpm_set_vpe_enable(smu, true);
@@ -2047,11 +2050,12 @@ static int smu_hw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	struct smu_context *smu = adev->powerplay.pp_handle;
 	int i, ret;
+	int num_vcn_inst = amdgpu_device_ip_get_num_inst(adev, AMD_IP_BLOCK_TYPE_VCN);
 
 	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
 		return 0;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
+	for (i = 0; i < num_vcn_inst; i++) {
 		smu_dpm_set_vcn_enable(smu, false, i);
 		adev->vcn.inst[i].cur_state = AMD_PG_STATE_GATE;
 	}
@@ -2995,7 +2999,7 @@ static int smu_read_sensor(void *handle,
 	struct amdgpu_device *adev = smu->adev;
 	struct smu_umd_pstate_table *pstate_table =
 				&smu->pstate_table;
-	int i, ret = 0;
+	int i, ret = 0, num_vcn_inst;
 	uint32_t *size, size_val;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
@@ -3041,8 +3045,9 @@ static int smu_read_sensor(void *handle,
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_VCN_POWER_STATE:
+		num_vcn_inst = amdgpu_device_ip_get_num_inst(adev, AMD_IP_BLOCK_TYPE_VCN);
 		*(uint32_t *)data = 0;
-		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
+		for (i = 0; i < num_vcn_inst; i++) {
 			if (!atomic_read(&smu->smu_power.power_gate.vcn_gated[i])) {
 				*(uint32_t *)data = 1;
 				break;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 19a25fdc2f5b4..5cfb68d673089 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -958,6 +958,7 @@ static int sienna_cichlid_set_default_dpm_table(struct smu_context *smu)
 	struct amdgpu_device *adev = smu->adev;
 	int i, ret = 0;
 	DpmDescriptor_t *table_member;
+	int num_vcn_inst = amdgpu_device_ip_get_num_inst(adev, AMD_IP_BLOCK_TYPE_VCN);
 
 	/* socclk dpm table setup */
 	dpm_table = &dpm_context->dpm_tables.soc_table;
@@ -1033,7 +1034,7 @@ static int sienna_cichlid_set_default_dpm_table(struct smu_context *smu)
 	}
 
 	/* vclk0/1 dpm table setup */
-	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
+	for (i = 0; i < num_vcn_inst; i++) {
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
 
@@ -1056,7 +1057,7 @@ static int sienna_cichlid_set_default_dpm_table(struct smu_context *smu)
 	}
 
 	/* dclk0/1 dpm table setup */
-	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
+	for (i = 0; i < num_vcn_inst; i++) {
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
 		dpm_table = &dpm_context->dpm_tables.dclk_table;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 7bb45ff6d5c85..e61b8c5fb9d67 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -1717,6 +1717,7 @@ int smu_v13_0_set_performance_level(struct smu_context *smu,
 	uint32_t fclk_min = 0, fclk_max = 0;
 	int ret = 0, i;
 	bool auto_level = false;
+	int num_vcn_inst = amdgpu_device_ip_get_num_inst(adev, AMD_IP_BLOCK_TYPE_VCN);
 
 	switch (level) {
 	case AMD_DPM_FORCED_LEVEL_HIGH:
@@ -1833,7 +1834,7 @@ int smu_v13_0_set_performance_level(struct smu_context *smu,
 	}
 
 	if (vclk_min && vclk_max) {
-		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
+		for (i = 0; i < num_vcn_inst; i++) {
 			if (adev->vcn.harvest_config & (1 << i))
 				continue;
 			ret = smu_v13_0_set_soft_freq_limited_range(smu,
@@ -1849,7 +1850,7 @@ int smu_v13_0_set_performance_level(struct smu_context *smu,
 	}
 
 	if (dclk_min && dclk_max) {
-		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
+		for (i = 0; i < num_vcn_inst; i++) {
 			if (adev->vcn.harvest_config & (1 << i))
 				continue;
 			ret = smu_v13_0_set_soft_freq_limited_range(smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
index 9b2f4fe1578b8..e660f4a663781 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -1211,6 +1211,7 @@ int smu_v14_0_set_performance_level(struct smu_context *smu,
 	uint32_t fclk_min = 0, fclk_max = 0;
 	int ret = 0, i;
 	bool auto_level = false;
+	int num_vcn_inst = amdgpu_device_ip_get_num_inst(adev, AMD_IP_BLOCK_TYPE_VCN);
 
 	switch (level) {
 	case AMD_DPM_FORCED_LEVEL_HIGH:
@@ -1314,7 +1315,7 @@ int smu_v14_0_set_performance_level(struct smu_context *smu,
 	}
 
 	if (vclk_min && vclk_max) {
-		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
+		for (i = 0; i < num_vcn_inst; i++) {
 			if (adev->vcn.harvest_config & (1 << i))
 				continue;
 			ret = smu_v14_0_set_soft_freq_limited_range(smu,
@@ -1330,7 +1331,7 @@ int smu_v14_0_set_performance_level(struct smu_context *smu,
 	}
 
 	if (dclk_min && dclk_max) {
-		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
+		for (i = 0; i < num_vcn_inst; i++) {
 			if (adev->vcn.harvest_config & (1 << i))
 				continue;
 			ret = smu_v14_0_set_soft_freq_limited_range(smu,
-- 
2.47.1

