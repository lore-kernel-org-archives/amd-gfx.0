Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 686AACF0431
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Oct 2024 21:16:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07E0A10E5DC;
	Tue,  8 Oct 2024 21:16:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HOI60qkV";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5841A10E5D0
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Oct 2024 21:16:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yn1LyM1bxExcnwPMmwdmPHsVHAhA4koMMHUgm93MBTMQXnQaWb7wyogJWphRnq/kp3qFzDPRzHVSLablLTG8HV4VIkDVvZEg/opNCnILrElUtaJVz4YX4NqTpGFuNSlLsrVjp6sqibOyAfrvPmVcmodJNC4dUUcJnt0WgoVtsssxNzGEe6BvFfFSbxv8D5LaxH4WpbqKMeXHZzgc/D5Cpo3Ds68tsHoGO56bRRmRQdPr1cs1J/npYJ6DdP36WB9gtyEgipZ2FzAXLEJRUhLpbbNMBWeJAGOcqyXFnUPyAWAQgGiaag9ePEuAEucjcJek4L9OzymGsOr9t/JOyuyZYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nWDN8h2Chn7QizLxGVR4E5uJFZUbDWt95xB/HlOoCDA=;
 b=MFhOgiOMvha0edPxJxkgVwobPFTR70cD0bWQiXHM6E5f7JJgAakUbRQRpQBkSbahIJ5ff9FPiHclK6z+vm3TGoxQ/weMzHahGEo0JWc89gYvy+ldtzevAtjUlGn47U5hxX1DhnrCfQWy3UHoo/excmuU8haxzEMyIBoh/iW0Xn+iPLfLzmlq4y6Vao9b1WygehlB5SnIsr8UZ/sZ+Xy7syZUAPLeYLzihjczUMhzF+h6GLR5sEiiMYyxBFcf7migEzkXYW573y4FmJKvowHW+7AgV5tVMQA0tixfxrFMZ2qtV3NtzNOnxzliOhbnOrFJXhXCc6/nGioFCVZFPe029w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nWDN8h2Chn7QizLxGVR4E5uJFZUbDWt95xB/HlOoCDA=;
 b=HOI60qkVh0ICvvFgCQVEVKKoe+jGTa4Nv60OJgrkE8r17Vdp9tjBo50INGYdkyGNZUww7+oI1xTL2PBHcw+XrLidBTCtsNsyIWy85ZLRY9Nsw825Jbd6TK7ngkgGwFLD89iT5eNhQF20pKG3EIZj70K8pSGftP1r2OqsBcFM95M=
Received: from CH2PR05CA0023.namprd05.prod.outlook.com (2603:10b6:610::36) by
 SA1PR12MB8988.namprd12.prod.outlook.com (2603:10b6:806:38e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Tue, 8 Oct
 2024 21:16:31 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:610:0:cafe::f7) by CH2PR05CA0023.outlook.office365.com
 (2603:10b6:610::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Tue, 8 Oct 2024 21:16:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 21:16:30 +0000
Received: from atitest-Rembrandt.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 8 Oct 2024 16:16:26 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 21/32] drm/amdgpu: sw_init for each vcn instance
Date: Tue, 8 Oct 2024 17:15:42 -0400
Message-ID: <20241008211553.36264-22-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241008211553.36264-1-boyuan.zhang@amd.com>
References: <20241008211553.36264-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|SA1PR12MB8988:EE_
X-MS-Office365-Filtering-Correlation-Id: efaf4e1b-0617-4aa1-968d-08dce7de7af9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Fz3F8V7ULMJkF/aZRatTVtVORSEkjGvBanGLKrznXXN3gjASc48p1BXfXBT5?=
 =?us-ascii?Q?icD5jCwzr8al9LsT/8X71evd1HlyzUU5Fe1q54zDvoNwZSWyOndT2+aO8plO?=
 =?us-ascii?Q?NuLnk+4cXgc7IAssft4FoznGMRraGPlZTZq3lvUR/0BSUHV8Y79rQelVx5rz?=
 =?us-ascii?Q?LplhER1L3bNjX0qGIOKxiDota7/l/oICIIqIMjiW0vx+Qen3P4/cTpucjuTs?=
 =?us-ascii?Q?55boCjIlmeEdCjipyIYTaQPBsYwhUhIee7ESpTMzNIbSk8TwNUerabhv5Gep?=
 =?us-ascii?Q?QZDT6NubykGOmwYntPSfGP87OyrxDd0gwKKVirPI0n6eVGn6v1on2YCVeC0g?=
 =?us-ascii?Q?h/XRNhDJ3EgGpXlmnORoNfzd1iCQPM5kT/eBRHY0p8xv7WDFYXqkkyIiUHp9?=
 =?us-ascii?Q?tY8xLkYBO43FrjMoYL89f2O4FoZQXCQZFtVO0c13BQ6X3kjqt6+kZQlQGhlE?=
 =?us-ascii?Q?RTAFHTB4q6bPqFr/zv+dEyOhI0zLBqSoYUPoTF2sRIpQwn9Q8OFNy+3+GksI?=
 =?us-ascii?Q?wdPz6PMS8Dz0FwI0gCGls1WO2U2r4OMuvoiC46fO/QcSBbYEZNvPnkrhwxyV?=
 =?us-ascii?Q?wc2e8KQWGvcERI77Lsk/rbhPMTYKE/APjopR/+jQ1nCHlycQqwQP05c+xIqN?=
 =?us-ascii?Q?f+j2yUKxFhQmYT/DbsP9ui7t0g/LSplLh0vGdynG3w2EaCHAJ2bJehCZVKDn?=
 =?us-ascii?Q?bh9qIJSJf5qGeet8CXBAhBoOkDBTYAhqm2w5nIQRvX4yagyPRPLJuUHlDAnq?=
 =?us-ascii?Q?kFd3Jhxhn0jPq/rSSWZ1rDggNEEodp4CrBFmwZ9YnvQwL296dslN0jGTvrID?=
 =?us-ascii?Q?6Noa5nQybG8RZIcP7atWG9G8CbkEWmib14bve+b/i0wCHFneqBXy7b2RkJjN?=
 =?us-ascii?Q?3iuA/PXrGQkVkvOu1dmWYrPYDMLoSMgt4wqZLcBf4rQ1407S9CCNcEhvk+lr?=
 =?us-ascii?Q?5ycdRgvflSmD2J56TMADMg1N6895H9dshuX+LLC77mD1qV6gSgoei48lmikp?=
 =?us-ascii?Q?25pL+7q0ELjhMD+b2uxynBTcUq7McZqLkK9SyEeDSQ/6+iXHSOQ2EVmIiQ1s?=
 =?us-ascii?Q?OhXzHNEaqkXLecU7hwRtQKmKxzvhFr3DjubY1k4je/z1E0Du+Yl23madjmLS?=
 =?us-ascii?Q?2FMMSmGBL2xNVOTxI5/lRwoeC61BVbqLdvqret7GMKIhyhlOSIjc1NTeG+sW?=
 =?us-ascii?Q?ubU75OcGVOcexF4k0ETQhVne+/pY3Q4/oT2Xs05l5TNloGSwEYXSloaWmAhP?=
 =?us-ascii?Q?3QpBsT1x/owQo3YkZBRLgF1F5jzOjdexfGTSGqumRla067ys5WciI/i5TK01?=
 =?us-ascii?Q?w07U0fdJKBsvZqgL9gYWc4ulfxVZQpQReqgKNQ2plCjeBnihQv/jRsrD5Lw3?=
 =?us-ascii?Q?4AxdYHBZfCXeIhDqWA1Ixwkt2Otq?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 21:16:30.9669 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efaf4e1b-0617-4aa1-968d-08dce7de7af9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8988
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
index e2986871f3a8..791b95867ac2 100644
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
index acf4b88e2797..825b70a396cd 100644
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
index 1a3907295e36..70d865724463 100644
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
index d14062e1dd31..834311e13a4c 100644
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
index 5d145adbe932..f6d2e3e3bf32 100644
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
index 464a502a7cd7..9b62296cc233 100644
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
index 58fdc07d9641..79d5ef8f857c 100644
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
index 4641534bb768..0932e992d088 100644
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
index d5ef1b0bcf54..e551ba1d1e12 100644
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
index 88248fcfa138..dc15a74bb3d8 100644
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

