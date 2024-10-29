Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9745D3A67D
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2024 17:43:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03C7210E6C5;
	Tue, 29 Oct 2024 17:43:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dZo0QxKy";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2071.outbound.protection.outlook.com [40.107.212.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDE9A10E6B1
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2024 17:43:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SuY5cRKM07cGVhDUAh/7sg9YmPdl+S+0sXSQqosDjdhkPfgtHlYuGfYf1LJHIcNiOWU9mYhKSYDv++vI+CwoYLujjjhjMquG5Fg0S2X7kpMm1k7tWLsFfxnUDJwx1wHRN2N+assYLb9l+Z9wK8SE5sqNsyzPIMloYbunQxvRzzn6LCzr6ktx/7f2wO/D2jKbJpB2Uf71+zjPMYL9htOiEa0BPURDXhSZXI/EqSFg9BtrjDetW2q6Hld7ATtbl9oex3sslW7WK2AqcY8Q5E2TikqHU2dwIu2j6qqDj0/7JF1CiM9xmeyYPfq6JUC7FGhHlcFhADUtLv1KY1LbVbbFFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D9+fkzQJD5r8p2/wQXBmeQDOvjCjMl5rWed0Z1TuIrg=;
 b=fE3Bs5PDxVqXYEcV2gdTMv2CqlxU/u4ixdHMkI318/yHLZwUMf49dT7EFMiSsrE19mIFM8wNtSUgnApc/+ttponLsvlxqvTrvbe4pCvcrFacNPIfpf+36Ci7EpJtQz6mHWjxdwU0G3fIjIZAE3XTVyBQxsZ3HLHgtx62fvvQJBLcAJ90Y9MfQqE/+HUaveoRJ0HWiS/I2/IbUPCHtKR58iZYZ1ltWDYnjY86dDEbZxG7KEsvT7GDhv7tmtW/bcnn7ZNZrjhFEdoWbso5OcG7ABISNhmhmZo6SNZQqrGtPS6fC9tm9mFVTKYrp3Y6TjmGyHB7iJLzQhOzQQSCsw3Jew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9+fkzQJD5r8p2/wQXBmeQDOvjCjMl5rWed0Z1TuIrg=;
 b=dZo0QxKyP/UXyloLGtO31q2MomIpTbCf4PPAVVAwykhCwk5a/y+VCRFrmVsJU1tcFbPjg+FHFiMZ5+ISlMCGQpn79aiWVRnb0oMTpFzzTquSf9SRObsEzYvnp2pgzNgxOfkCrc4A0zsYnCdOyKl+s0ECW0q0S14ZD7y+QqzkgmI=
Received: from SN6PR16CA0043.namprd16.prod.outlook.com (2603:10b6:805:ca::20)
 by BL1PR12MB5801.namprd12.prod.outlook.com (2603:10b6:208:391::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.29; Tue, 29 Oct
 2024 17:43:08 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:805:ca:cafe::a1) by SN6PR16CA0043.outlook.office365.com
 (2603:10b6:805:ca::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.17 via Frontend
 Transport; Tue, 29 Oct 2024 17:43:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Tue, 29 Oct 2024 17:43:08 +0000
Received: from atitest-Rembrandt.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 29 Oct 2024 12:43:01 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 21/29] drm/amdgpu: sw_init for each vcn instance
Date: Tue, 29 Oct 2024 13:42:32 -0400
Message-ID: <20241029174240.682928-22-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241029174240.682928-1-boyuan.zhang@amd.com>
References: <20241029174240.682928-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|BL1PR12MB5801:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fd6b2fa-a6f6-4efd-88c2-08dcf84126ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9j+tOHAo97BZUnMXZQi0Ru2ZPcKQCYR5RmzkiLBvu6CpK/U/TxzdDvMq/6Rx?=
 =?us-ascii?Q?e+KBc/Fvl1ZzA+ZS4a0EWjz9G4ApIfIlrQAXhamcGjMTYmLPkRGcJssJ6W6z?=
 =?us-ascii?Q?9h9FhtG5SWKg2SZWQmH84caWB1EnzcJPhDmyM6pQugGQfF+OMcHML3LjyBxJ?=
 =?us-ascii?Q?4llnVF/AZ6MgBgmL5tinGL5NbaUpSMhk96X4zTG64uCQHk/MalHjyVagrl/9?=
 =?us-ascii?Q?R2h3+3q4lod/GdrMRZZ+iRoXA5hQHjEhveh/1jM/tfesE2wopLz50Z2j87ce?=
 =?us-ascii?Q?hVyi9riLlbXwATrIztR+ql9t0Yy0a1zw8xUPM78/HAJIgdENbM7LvkLT0+UW?=
 =?us-ascii?Q?s/a9XGZy6bY2YiwydHSqbNKVTUZDusIgwmglE30AlmnMfkwrsLA7k78q31KB?=
 =?us-ascii?Q?08J5r1PhuQOhu7IRo2sLKfQGGHfFooLKgawlmzJoulUFXvp9VFudZbgpVeb+?=
 =?us-ascii?Q?gKe//rOI1T8sGUTXVY2KXeXN3f00iTHD4bv95XjeMb3pbVqtrkUUQ8faDFj3?=
 =?us-ascii?Q?7BDfaE+tFDXl7AjyA0dAirjYm4axL3Q2ebB+exbCjM4fuWzgJ5e+Abp8frwQ?=
 =?us-ascii?Q?21QJm0eEY2dO6D7W/O0ksx5ybcFxKZG1PkUpGP4KBIRLZdJ66eWDderr5RIG?=
 =?us-ascii?Q?K5Z9husMMoZsWlbW50BJYuhygnZDzSOW1r6HL8w4p9e6iSzawyfW/lDvdCVn?=
 =?us-ascii?Q?h8eoTKcLmTqjMov4MLrhnrSGmu5iFp9k+yBPAtJRv0ATvD3tqZl4R/11TB6Q?=
 =?us-ascii?Q?lc17svg7Pd0Qvm8YrhH9X6ta3GpFdGkkYEDCvgzuaBUSZOa20lS2uSp1cGpC?=
 =?us-ascii?Q?vPeykwkUMPFbPrCtvCh1rDvv2rnXgE+HiZHz5KL+AglLO0QGHAiOP6Dt0Hft?=
 =?us-ascii?Q?NHfna+Iqchp8ZFpCu/CNkzrfE1FY5c7GNBI7jGwq+aFZO2hChvK30iRtr4k/?=
 =?us-ascii?Q?4WKD3XxZyeu6zuLK9LKFtCcychTPd9SPnS3A7KXm73ru1H4isDmdfUov+DqP?=
 =?us-ascii?Q?3rgzq8g/y2m7l1P666l+YjTI2BppnE7+a+3yMue0tM8Ec+xyP2o/rrJJ8j82?=
 =?us-ascii?Q?w+Xns+uI4Yg5lm8vnoD/4IwIdIzgIleJhaaLPTAP74tU4sx21XfoikmR9YHf?=
 =?us-ascii?Q?Il3lWfvHxbyHuPVbwwZTva6P5P6jrf7Yy98DfcWBT8MQd+DZZsTBdRji2hKZ?=
 =?us-ascii?Q?YGTa/fhm95v4POtqwtuk3tdOtXaiJvFDlYTzGe6T+0COzkGY9FO/8GsJ+wMy?=
 =?us-ascii?Q?UlQNgAdVy4Uut9yZ+NgJ0VgoDbqUWb+7MMO+oe8OdxH1j/WAcPZxrPyqh+I3?=
 =?us-ascii?Q?2I5DYDFkhlA1yr5uqBdIXoVIEo9h2shr8xLs4Xi/aqdQfXNITYKIlb3g3bab?=
 =?us-ascii?Q?jn5gzGRd/Y1D0kv7sMo9BPyRb8qdTfBqrj5lUbHaVPCsOYtB0Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 17:43:08.5887 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fd6b2fa-a6f6-4efd-88c2-08dcf84126ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5801
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

Pass instance parameter to amdgpu_vcn_sw_init(), and perform
sw init ONLY for the given vcn instance, instead of for all
vcn instances. Modify each vcn generation accordingly.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
Acked-by: Sunil Khatri <sunil.khatri@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 83 ++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   |  5 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   |  5 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   |  6 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   |  7 ++-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   |  7 ++-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c |  5 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c |  7 ++-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c |  7 ++-
 10 files changed, 69 insertions(+), 65 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 21701738030f..2c55166e27d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -111,24 +111,23 @@ int amdgpu_vcn_early_init(struct amdgpu_device *adev, int inst)
 	return r;
 }
 
-int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
+int amdgpu_vcn_sw_init(struct amdgpu_device *adev, int inst)
 {
 	unsigned long bo_size;
 	const struct common_firmware_header *hdr;
 	unsigned char fw_check;
 	unsigned int fw_shared_size, log_offset;
-	int i, r;
+	int r;
+
+	adev->vcn.inst[inst].adev = adev;
+	adev->vcn.inst[inst].work_inst = inst;
+	INIT_DELAYED_WORK(&adev->vcn.inst[inst].idle_work, amdgpu_vcn_idle_work_handler);
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		adev->vcn.inst[i].adev = adev;
-		adev->vcn.inst[i].work_inst = i;
-		INIT_DELAYED_WORK(&adev->vcn.inst[i].idle_work, amdgpu_vcn_idle_work_handler);
-	}
 	mutex_init(&adev->vcn.vcn_pg_lock);
 	mutex_init(&adev->vcn.vcn1_jpeg1_workaround);
 	atomic_set(&adev->vcn.total_submission_cnt, 0);
-	for (i = 0; i < adev->vcn.num_vcn_inst; i++)
-		atomic_set(&adev->vcn.inst[i].dpg_enc_submission_cnt, 0);
+
+	atomic_set(&adev->vcn.inst[inst].dpg_enc_submission_cnt, 0);
 
 	if ((adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) &&
 	    (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
@@ -206,45 +205,43 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 	if (amdgpu_vcnfw_log)
 		bo_size += AMDGPU_VCNFW_LOG_SIZE;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return 0;
 
-		r = amdgpu_bo_create_kernel(adev, bo_size, PAGE_SIZE,
-					    AMDGPU_GEM_DOMAIN_VRAM |
-					    AMDGPU_GEM_DOMAIN_GTT,
-					    &adev->vcn.inst[i].vcpu_bo,
-					    &adev->vcn.inst[i].gpu_addr,
-					    &adev->vcn.inst[i].cpu_addr);
-		if (r) {
-			dev_err(adev->dev, "(%d) failed to allocate vcn bo\n", r);
-			return r;
-		}
+	r = amdgpu_bo_create_kernel(adev, bo_size, PAGE_SIZE,
+					AMDGPU_GEM_DOMAIN_VRAM |
+					AMDGPU_GEM_DOMAIN_GTT,
+					&adev->vcn.inst[inst].vcpu_bo,
+					&adev->vcn.inst[inst].gpu_addr,
+					&adev->vcn.inst[inst].cpu_addr);
+	if (r) {
+		dev_err(adev->dev, "(%d) failed to allocate vcn bo\n", r);
+		return r;
+	}
 
-		adev->vcn.inst[i].fw_shared.cpu_addr = adev->vcn.inst[i].cpu_addr +
-				bo_size - fw_shared_size;
-		adev->vcn.inst[i].fw_shared.gpu_addr = adev->vcn.inst[i].gpu_addr +
-				bo_size - fw_shared_size;
+	adev->vcn.inst[inst].fw_shared.cpu_addr = adev->vcn.inst[inst].cpu_addr +
+			bo_size - fw_shared_size;
+	adev->vcn.inst[inst].fw_shared.gpu_addr = adev->vcn.inst[inst].gpu_addr +
+			bo_size - fw_shared_size;
 
-		adev->vcn.inst[i].fw_shared.mem_size = fw_shared_size;
+	adev->vcn.inst[inst].fw_shared.mem_size = fw_shared_size;
 
-		if (amdgpu_vcnfw_log) {
-			adev->vcn.inst[i].fw_shared.cpu_addr -= AMDGPU_VCNFW_LOG_SIZE;
-			adev->vcn.inst[i].fw_shared.gpu_addr -= AMDGPU_VCNFW_LOG_SIZE;
-			adev->vcn.inst[i].fw_shared.log_offset = log_offset;
-		}
+	if (amdgpu_vcnfw_log) {
+		adev->vcn.inst[inst].fw_shared.cpu_addr -= AMDGPU_VCNFW_LOG_SIZE;
+		adev->vcn.inst[inst].fw_shared.gpu_addr -= AMDGPU_VCNFW_LOG_SIZE;
+		adev->vcn.inst[inst].fw_shared.log_offset = log_offset;
+	}
 
-		if (adev->vcn.indirect_sram) {
-			r = amdgpu_bo_create_kernel(adev, 64 * 2 * 4, PAGE_SIZE,
-					AMDGPU_GEM_DOMAIN_VRAM |
-					AMDGPU_GEM_DOMAIN_GTT,
-					&adev->vcn.inst[i].dpg_sram_bo,
-					&adev->vcn.inst[i].dpg_sram_gpu_addr,
-					&adev->vcn.inst[i].dpg_sram_cpu_addr);
-			if (r) {
-				dev_err(adev->dev, "VCN %d (%d) failed to allocate DPG bo\n", i, r);
-				return r;
-			}
+	if (adev->vcn.indirect_sram) {
+		r = amdgpu_bo_create_kernel(adev, 64 * 2 * 4, PAGE_SIZE,
+				AMDGPU_GEM_DOMAIN_VRAM |
+				AMDGPU_GEM_DOMAIN_GTT,
+				&adev->vcn.inst[inst].dpg_sram_bo,
+				&adev->vcn.inst[inst].dpg_sram_gpu_addr,
+				&adev->vcn.inst[inst].dpg_sram_cpu_addr);
+		if (r) {
+			dev_err(adev->dev, "VCN %d (%d) failed to allocate DPG bo\n", inst, r);
+			return r;
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 58fbb87e5ec4..4809da69bd1b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -484,7 +484,7 @@ enum vcn_ring_type {
 };
 
 int amdgpu_vcn_early_init(struct amdgpu_device *adev, int inst);
-int amdgpu_vcn_sw_init(struct amdgpu_device *adev);
+int amdgpu_vcn_sw_init(struct amdgpu_device *adev, int inst);
 int amdgpu_vcn_sw_fini(struct amdgpu_device *adev);
 int amdgpu_vcn_suspend(struct amdgpu_device *adev);
 int amdgpu_vcn_resume(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 6fd509e6744d..808d69ab0904 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -126,11 +126,12 @@ static int vcn_v1_0_early_init(struct amdgpu_ip_block *ip_block)
  */
 static int vcn_v1_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
+	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 	struct amdgpu_ring *ring;
 	int i, r;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_1_0);
 	uint32_t *ptr;
-	struct amdgpu_device *adev = ip_block->adev;
 
 	/* VCN DEC TRAP */
 	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_VCN,
@@ -146,7 +147,7 @@ static int vcn_v1_0_sw_init(struct amdgpu_ip_block *ip_block)
 			return r;
 	}
 
-	r = amdgpu_vcn_sw_init(adev);
+	r = amdgpu_vcn_sw_init(adev, inst);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 8f7038190a43..a86cff00d761 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -131,11 +131,12 @@ static int vcn_v2_0_early_init(struct amdgpu_ip_block *ip_block)
  */
 static int vcn_v2_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
+	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 	struct amdgpu_ring *ring;
 	int i, r;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_2_0);
 	uint32_t *ptr;
-	struct amdgpu_device *adev = ip_block->adev;
 	volatile struct amdgpu_fw_shared *fw_shared;
 
 	/* VCN DEC TRAP */
@@ -154,7 +155,7 @@ static int vcn_v2_0_sw_init(struct amdgpu_ip_block *ip_block)
 			return r;
 	}
 
-	r = amdgpu_vcn_sw_init(adev);
+	r = amdgpu_vcn_sw_init(adev, inst);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 74814370ddc9..9967ac3fc51b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -156,12 +156,12 @@ static int vcn_v2_5_early_init(struct amdgpu_ip_block *ip_block)
  */
 static int vcn_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
 {
+	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 	struct amdgpu_ring *ring;
 	int i, r;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_2_5);
 	uint32_t *ptr;
-	struct amdgpu_device *adev = ip_block->adev;
-	int inst = ip_block->instance;
 
 	if (adev->vcn.harvest_config & (1 << inst))
 		goto sw_init;
@@ -185,7 +185,7 @@ static int vcn_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 sw_init:
-	r = amdgpu_vcn_sw_init(adev);
+	r = amdgpu_vcn_sw_init(adev, inst);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index a7fb5dda51dd..e89088e3cd1d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -160,14 +160,15 @@ static int vcn_v3_0_early_init(struct amdgpu_ip_block *ip_block)
  */
 static int vcn_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
+	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 	struct amdgpu_ring *ring;
-	int inst = ip_block->instance, j, r;
 	int vcn_doorbell_index = 0;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_3_0);
 	uint32_t *ptr;
-	struct amdgpu_device *adev = ip_block->adev;
+	int j, r;
 
-	r = amdgpu_vcn_sw_init(adev);
+	r = amdgpu_vcn_sw_init(adev, inst);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index c0c2a071ea15..1b492197c2b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -168,14 +168,15 @@ static int vcn_v4_0_fw_shared_init(struct amdgpu_device *adev, int inst_idx)
  */
 static int vcn_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_ring *ring;
 	struct amdgpu_device *adev = ip_block->adev;
-	int inst = ip_block->instance, r;
+	int inst = ip_block->instance;
+	struct amdgpu_ring *ring;
+	int r;
 
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0);
 	uint32_t *ptr;
 
-	r = amdgpu_vcn_sw_init(adev);
+	r = amdgpu_vcn_sw_init(adev, inst);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 1d1ee6da7647..5b61000f3004 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -127,12 +127,13 @@ static int vcn_v4_0_3_early_init(struct amdgpu_ip_block *ip_block)
 static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 	struct amdgpu_ring *ring;
-	int inst = ip_block->instance, r, vcn_inst;
+	int r, vcn_inst;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0_3);
 	uint32_t *ptr;
 
-	r = amdgpu_vcn_sw_init(adev);
+	r = amdgpu_vcn_sw_init(adev, inst);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 81efc53e7cd3..4d944636d02b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -131,13 +131,14 @@ static int vcn_v4_0_5_early_init(struct amdgpu_ip_block *ip_block)
  */
 static int vcn_v4_0_5_sw_init(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_ring *ring;
 	struct amdgpu_device *adev = ip_block->adev;
-	int inst = ip_block->instance, r;
+	int inst = ip_block->instance;
+	struct amdgpu_ring *ring;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0_5);
 	uint32_t *ptr;
+	int r;
 
-	r = amdgpu_vcn_sw_init(adev);
+	r = amdgpu_vcn_sw_init(adev, inst);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 7873ca91da4c..8efedf943581 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -115,13 +115,14 @@ static int vcn_v5_0_0_early_init(struct amdgpu_ip_block *ip_block)
  */
 static int vcn_v5_0_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_ring *ring;
 	struct amdgpu_device *adev = ip_block->adev;
-	int inst = ip_block->instance, r;
+	int inst = ip_block->instance;
+	struct amdgpu_ring *ring;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_5_0);
 	uint32_t *ptr;
+	int r;
 
-	r = amdgpu_vcn_sw_init(adev);
+	r = amdgpu_vcn_sw_init(adev, inst);
 	if (r)
 		return r;
 
-- 
2.34.1

