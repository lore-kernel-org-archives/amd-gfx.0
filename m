Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 680A2EB64D8
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jun 2023 21:10:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C63BE10E68B;
	Fri, 16 Jun 2023 21:10:32 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 112F210E68B
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jun 2023 21:10:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ks50cCL6DMnIogjABH6I1vAtkj4Gc15JY4v6DSDoibncr7dsZanhADlwHQoXd+VQaGMQNrAuiFd79rSJ5H6gOPTf2gD5JFgs04t+md2bXxgd/EqOnIZzw1fM4yddTgu5FoOXL/ey7YUg+h3LyGovIEvPhwZ/Gq/DD8PMBbRwdh3/enwDVjynC2q614zGc3P5TdOEDzaMo94WHoFtTpLLDb/EccRzzd4tjwdz2MPIZb4p/ZZa6qY5W6TQy/6oiV2GEk2bCuA9Glcb7na3s0PfVkCBy8TdTAx6000ywqFVaxe5QoQpjxBCnW5walkBCJRiT+yN2cklrdwnRzGWDCRqlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=osgs4+5EqdOY+i+rEHO8aX9FOftB1F+zcfYVEvYP+5E=;
 b=gzBTzN8BXR4FYRM4icoVhuY4/lVqQ1vkTziVn4PyUMknXV68Lxh4kkOrl+eS3OQtMHVObyz9aDut4rzmsBS7kOv59w4PsmsBbWF/7P7FDNTTi7Q1teyVylP7pdK2fsqngro3dn8KKOx71USuzusofEInT8qIx/lEMrclzlLmQ0f8k/JSaA4jmDmcV6RwnDcxpXHJufaPa+StR66WqPIVb5jkJnI+QG+InRPouIeELe0A8uFys6nbsQBU6cRZFCue2HOsQYum+cAsJdHWiUlxjoKNKH+UjDYt+xl3oGU8vi7iOvfFArN1dboURGcMKEiW40Z3OzuZlNxf1P3+8ibQzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=osgs4+5EqdOY+i+rEHO8aX9FOftB1F+zcfYVEvYP+5E=;
 b=LPhqYXahURD0hobpmPbFwJ+83TcazTZdepwMJRCfAUtEiq2tTKcLVHCN1DLFHELmxIWP0NvlQ672DBeUfF99CtYczeCdq95blGs1njLMBDSgKPE+2/DBNHCOslO0MCP87MgNmyAp4hFci0CsBJ2XbgQduW+ml/yzzno3F0MX8pg=
Received: from DM5PR07CA0099.namprd07.prod.outlook.com (2603:10b6:4:ae::28) by
 BY5PR12MB4164.namprd12.prod.outlook.com (2603:10b6:a03:207::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27; Fri, 16 Jun
 2023 21:10:26 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:4:ae:cafe::21) by DM5PR07CA0099.outlook.office365.com
 (2603:10b6:4:ae::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29 via Frontend
 Transport; Fri, 16 Jun 2023 21:10:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.211) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.27 via Frontend Transport; Fri, 16 Jun 2023 21:10:25 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 16 Jun
 2023 16:10:24 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: make mcbp a per device setting
Date: Fri, 16 Jun 2023 17:10:10 -0400
Message-ID: <20230616211011.31578-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|BY5PR12MB4164:EE_
X-MS-Office365-Filtering-Correlation-Id: e5558a56-cf67-4ddf-cfa0-08db6eae1ad9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xVoecbxy/jPfkISiR/un0Ba0GVd4Q1iKOlZVIGJvG/TTw3XcmweZ0A3UinzGWT8fTHnPEzqjN0v0RTKItkgT4HkV9wVzHJLp15A2LIDo4PSYtTvvXea2tGi2xXnf9d3X0vfkNxO0eBn6JaKz8f8v4yZRCXFmY9Cp16zGy3AVSc1bmxYhaOCJJsA6yThy1iMskLsRw9ky39gcPzsxDdpFzkIArOOUDbsOtIHvwrIRzVAnnY3r0o8zBk+Dm1h+BGvS8Y+ZHpmc4ZtFveFyKxmf4JlrGtn2aNobp2FQyvqsTUixdhjK7YANQ733kK5Tg6zORrJfTQPyK4pUnSOF/WYPcUyKF1fAw9V0/a4Lgs14y1b+UvA4vvPLH+TniW+ouVl6v1jcHpQMRlQhsLZxrd7U0JLMIBqwEfGwmz8NV6lF9+rA2SKPBTEDSa1DABovO6EZpY0Vf+PvrNKyjLQhGEgJ+W+Nu1egNxvVbHsb0KYQk8XZdbLiM+04x5OrEPMJTJOp8Qru9l3dBjw1i45gt+n1qNMgBsJXo3f3tcJmHVoPcGsAIz7ulyzWY2q+Spp55gzIqjmLiJj7oGZUTC9qPcR+6fcJHuHKy8+vdp023YxaTggrZO4+G+Hvod8ql9qs7wAtOK5iKav9bsJtkDZISdiy261S4MbGz3Zzllycvlu56MBo9LAkKp388EPAjhT2KPN/21Tq3Gvf/3eJR2m/92PuMKng1aikLYZGBtctIj7SRXSaNR15Ybry/s04hgrSE9EkXPMu6brZemJBkbnnXZz5oA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(396003)(346002)(376002)(451199021)(40470700004)(36840700001)(46966006)(26005)(83380400001)(82740400003)(5660300002)(81166007)(2616005)(336012)(2906002)(1076003)(426003)(186003)(356005)(16526019)(36860700001)(47076005)(478600001)(40480700001)(40460700003)(6666004)(70206006)(316002)(6916009)(8936002)(7696005)(86362001)(41300700001)(82310400005)(8676002)(4326008)(36756003)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 21:10:25.5810 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5558a56-cf67-4ddf-cfa0-08db6eae1ad9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4164
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

So we can selectively enable it on certain devices.  No
intended functional change.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 19 +++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   |  3 ---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     |  2 +-
 7 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index f39db4a2c2cf..78c6265fe79b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2551,7 +2551,7 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 			adev->ip_blocks[i].status.hw = true;
 
 			/* right after GMC hw init, we create CSA */
-			if (amdgpu_mcbp) {
+			if (adev->gfx.mcbp) {
 				r = amdgpu_allocate_static_csa(adev, &adev->virt.csa_obj,
 							       AMDGPU_GEM_DOMAIN_VRAM |
 							       AMDGPU_GEM_DOMAIN_GTT,
@@ -3672,6 +3672,18 @@ static const struct attribute *amdgpu_dev_attributes[] = {
 	NULL
 };
 
+static void amdgpu_device_set_mcbp(struct amdgpu_device *adev)
+{
+	if (amdgpu_mcbp == 1)
+		adev->gfx.mcbp = true;
+
+	if (amdgpu_sriov_vf(adev))
+		adev->gfx.mcbp = true;
+
+	if (adev->gfx.mcbp)
+		DRM_INFO("MCBP is enabled\n");
+}
+
 /**
  * amdgpu_device_init - initialize the driver
  *
@@ -3823,9 +3835,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	DRM_INFO("register mmio base: 0x%08X\n", (uint32_t)adev->rmmio_base);
 	DRM_INFO("register mmio size: %u\n", (unsigned)adev->rmmio_size);
 
-	if (amdgpu_mcbp)
-		DRM_INFO("MCBP is enabled\n");
-
 	/*
 	 * Reset domain needs to be present early, before XGMI hive discovered
 	 * (if any) and intitialized to use reset sem and in_gpu reset flag
@@ -3851,6 +3860,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	if (r)
 		return r;
 
+	amdgpu_device_set_mcbp(adev);
+
 	/* Get rid of things like offb */
 	r = drm_aperture_remove_conflicting_pci_framebuffers(adev->pdev, &amdgpu_kms_driver);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index ce0f7a8ad4b8..a4ff515ce896 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -434,6 +434,7 @@ struct amdgpu_gfx {
 	uint16_t 			xcc_mask;
 	uint32_t			num_xcc_per_xcp;
 	struct mutex			partition_mutex;
+	bool				mcbp; /* mid command buffer preemption */
 };
 
 struct amdgpu_gfx_ras_reg_entry {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index e3531aa3c8bd..cca5a495611f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -805,7 +805,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		dev_info->ids_flags = 0;
 		if (adev->flags & AMD_IS_APU)
 			dev_info->ids_flags |= AMDGPU_IDS_FLAGS_FUSION;
-		if (amdgpu_mcbp)
+		if (adev->gfx.mcbp)
 			dev_info->ids_flags |= AMDGPU_IDS_FLAGS_PREEMPTION;
 		if (amdgpu_is_tmz(adev))
 			dev_info->ids_flags |= AMDGPU_IDS_FLAGS_TMZ;
@@ -1247,7 +1247,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 		goto error_vm;
 	}
 
-	if (amdgpu_mcbp) {
+	if (adev->gfx.mcbp) {
 		uint64_t csa_addr = amdgpu_csa_vaddr(adev) & AMDGPU_GMC_HOLE_MASK;
 
 		r = amdgpu_map_static_csa(adev, &fpriv->vm, adev->virt.csa_obj,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 78ec3420ef85..dacf281d2b21 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -72,7 +72,7 @@ uint64_t amdgpu_sdma_get_csa_mc_addr(struct amdgpu_ring *ring,
 	int r;
 
 	/* don't enable OS preemption on SDMA under SRIOV */
-	if (amdgpu_sriov_vf(adev) || vmid == 0 || !amdgpu_mcbp)
+	if (amdgpu_sriov_vf(adev) || vmid == 0 || !adev->gfx.mcbp)
 		return 0;
 
 	if (ring->is_mes_queue) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 25b4d7f0bd35..41aa853a07d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -66,9 +66,6 @@ void amdgpu_virt_init_setting(struct amdgpu_device *adev)
 	adev->cg_flags = 0;
 	adev->pg_flags = 0;
 
-	/* enable mcbp for sriov */
-	amdgpu_mcbp = 1;
-
 	/* Reduce kcq number to 2 to reduce latency */
 	if (amdgpu_num_kcq == -1)
 		amdgpu_num_kcq = 2;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index be984f8c71c7..44af8022b89f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -8307,7 +8307,7 @@ static void gfx_v10_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
 
 	control |= ib->length_dw | (vmid << 24);
 
-	if (amdgpu_mcbp && (ib->flags & AMDGPU_IB_FLAG_PREEMPT)) {
+	if (ring->adev->gfx.mcbp && (ib->flags & AMDGPU_IB_FLAG_PREEMPT)) {
 		control |= INDIRECT_BUFFER_PRE_ENB(1);
 
 		if (flags & AMDGPU_IB_PREEMPTED)
@@ -8482,7 +8482,7 @@ static void gfx_v10_0_ring_emit_cntxcntl(struct amdgpu_ring *ring,
 {
 	uint32_t dw2 = 0;
 
-	if (amdgpu_mcbp)
+	if (ring->adev->gfx.mcbp)
 		gfx_v10_0_ring_emit_ce_meta(ring,
 				    (!amdgpu_sriov_vf(ring->adev) && flags & AMDGPU_IB_PREEMPTED) ? true : false);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 690e121d9dda..3a7af59e83ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -5311,7 +5311,7 @@ static void gfx_v11_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
 
 	control |= ib->length_dw | (vmid << 24);
 
-	if (amdgpu_mcbp && (ib->flags & AMDGPU_IB_FLAG_PREEMPT)) {
+	if (ring->adev->gfx.mcbp && (ib->flags & AMDGPU_IB_FLAG_PREEMPT)) {
 		control |= INDIRECT_BUFFER_PRE_ENB(1);
 
 		if (flags & AMDGPU_IB_PREEMPTED)
-- 
2.40.1

