Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E0FC6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 19:43:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FC3110EFFB;
	Thu, 30 Mar 2023 19:43:27 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4EAF10EFF1
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 19:43:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ALKk+SXQCiGa2QIuHJbFbGB4/9QkyiunT7yUYzw8C3UsT3ZXZ8bksb01JktvKUsJ/uSUf0PQQkvmfTKiSfPvNmxLOt0yy7eloxGL74aCXAVShlXtx/mKy1jbU6zkaFnVc19+iQ7UxL4YlrWh9WAabaqnbuKnea0bMQ6kaFcz08vgSCA9NBGvYeAjILNh6zZqJhyjIAL6mheNxpLkmD839vBnNVmNAPejIGum0b1jnV/pqZte24lhnfWECeYX0Kp5PLdO/8PKNOjR1kRgu1cSIPxJAX+USON/Jisjb4xzmZhiAi2mCVDxfK4LAP0P0leRgNeYnYfoSSFDtGd7Ueax9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ARoDoICtiFeKSAJ6VuPZTmDohIHPMqyNOQ4wT9DM5Ec=;
 b=htZXZ4Hhnwwl+A44c/7bS2RqB0Mh6ivtOd0knmtva4vecgVTPCZhQKoNgXYErzFkj51kblecsMAqxmfmIuCKzCtQ+QunfERTpJX+umLQoKCCh7bhYpRgJuYnfyAhBVW1RaIEZmgG3NybD7jgFAHV60GsXHutayc9HYL9OBCU4ZP3Fep3+4MYPxdd2UuhmWv5UbK5p3iEnRe2a0rm2dEJRwCjd/jPTD5yjjyxL35y8gL46VVQvuxb8dn9zY9tAF1k22OJwVDGZhY/qMQ/c0O/AEcIF5NnVH0huEeolxD4OA29HA0dqs4qLoYzmzruqUmVpZEZts1yHgpG2qaJkQ+thQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ARoDoICtiFeKSAJ6VuPZTmDohIHPMqyNOQ4wT9DM5Ec=;
 b=z2X2R3md/3OMJYMWoiZv52Jmp/lTZ8yskk4L0qIbE9ScezS+Pszi1sG2EDAUYdSDOGiraQBm2PUM2j8AzLSomanCp6a+Ydbp6tLEEtH9adyLoHcbaf1fTRgmaktelGe4p1AwBk8p5IeW+vUFuqN+1RhqhY3+7etAJw68sM0ksRA=
Received: from DM6PR03CA0092.namprd03.prod.outlook.com (2603:10b6:5:333::25)
 by IA0PR12MB7626.namprd12.prod.outlook.com (2603:10b6:208:438::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Thu, 30 Mar
 2023 19:42:58 +0000
Received: from DS1PEPF0000E63C.namprd02.prod.outlook.com
 (2603:10b6:5:333:cafe::46) by DM6PR03CA0092.outlook.office365.com
 (2603:10b6:5:333::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Thu, 30 Mar 2023 19:42:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E63C.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Thu, 30 Mar 2023 19:42:58 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 14:42:57 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 20/23] drm/amdgpu: Force GART page table on system memory
Date: Thu, 30 Mar 2023 15:42:31 -0400
Message-ID: <20230330194234.1135527-20-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330194234.1135527-1-alexander.deucher@amd.com>
References: <20230330194234.1135527-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E63C:EE_|IA0PR12MB7626:EE_
X-MS-Office365-Filtering-Correlation-Id: 46ba96b7-eae4-445b-f393-08db3156f6f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1eb04bqLbbkAUpFW9ZtogQfTMrBtbQC9XH6VGcKTgIZrUKm6vT4nmT8qVj98EK4CoZTezVDZxEj+dOMrvqgD05zQHNtmJ833UuDlcV0O7qdb20WXM7bO8V58mkH/vfeQQyC9t/gBuohvqku4pr+fvK4mg4lnciryXZYb1zPuirx03nHZPH7HTQA+aunHOS43X2EK4BCjP4koL6x+orARV6IE/Zzxzf4kI/xOe3tzjQnxN8Xz94nLAQL5NGpHzCO4YBODrodJeuqEfuFg6tXxRzPQKA2CbRtxD43fKIZWqN+um31MkYoLD/f/jyFacjcnSqUHCB6rsaB4Imh0Lqxgsk8fBrEGrkcXBBFCrNJ2fis+KckbuFJnK0wojUDoDy/lJ9H+0vvnlknr8T2PuJpRCGHBlgrndnO1rxKh28PR8gF5r11BSG8KD/ExLE03xGZ/6yEoI/BTndEnPDevURrmFosQh96XUv2MxvtDHppFhu+0YA6MCD54J4G/hCxZ9oOEUYpl0T3fhGLOAlQWYy5pskOXgpi1TfvDbe21rPFqFFMst0ySAKvdchySPhZP2DetuaxGE0OULOJXOHVRflejgk8+ky/tXjIgGmnLpsLA0BnytAt6Z0mh03xpkLtObt1mbNxuGj6Lpr30XBW0v4CfjywOae9g7CLn8rQ4Be7HXyKgXdhsFlvBCLJozTbLCatfpXoRzu2lsnX9JZAavRdXwAlAdIrVsAGeDp/gO0zJW+Y=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(136003)(396003)(376002)(451199021)(40470700004)(36840700001)(46966006)(83380400001)(70586007)(70206006)(356005)(5660300002)(54906003)(81166007)(2906002)(8676002)(6916009)(4326008)(41300700001)(36860700001)(8936002)(316002)(426003)(336012)(478600001)(2616005)(82740400003)(40460700003)(47076005)(7696005)(40480700001)(86362001)(1076003)(186003)(16526019)(82310400005)(6666004)(26005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:42:58.2669 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46ba96b7-eae4-445b-f393-08db3156f6f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E63C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7626
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>

[NOT FOR UPSTREAM]

For debug purpose and more test coverage, we want to enable GART in the
system memory for GFXIP9.4.3 bring up branch while we still continue to
use the APU in the carveout mode.

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Suggested-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h      | 2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  | 8 ++++++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c    | 4 ++--
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c  | 2 +-
 5 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index c894fb43786c..a0d05a7a29f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -246,6 +246,8 @@ extern int amdgpu_sg_display;
 
 extern uint amdgpu_user_partt_mode;
 
+extern int gart_ram_alloc;
+
 #define AMDGPU_VM_MAX_NUM_CTX			4096
 #define AMDGPU_SG_THRESHOLD			(256*1024*1024)
 #define AMDGPU_DEFAULT_GTT_SIZE_MB		3072ULL /* 3GB by default */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 13bcd8e955ac..d972f77b506b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -812,6 +812,14 @@ bool debug_evictions;
 module_param(debug_evictions, bool, 0644);
 MODULE_PARM_DESC(debug_evictions, "enable eviction debug messages (false = default)");
 
+/**
+ * DOC: gart_ram_alloc (int)
+ * Force the gart page table to be created in the system memory instead of VRAM
+ */
+int gart_ram_alloc = 1;
+module_param(gart_ram_alloc, int, 0644);
+MODULE_PARM_DESC(gart_ram_alloc, "Force allocate GART on system memory (1 = default)");
+
 /**
  * DOC: no_system_mem_limit(bool)
  * Disable system memory limit, to support multiple process shared memory
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
index 8901e73fd700..58f0ff1c6035 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
@@ -253,7 +253,7 @@ static void gfxhub_v1_2_xcc_init_cache_regs(struct amdgpu_device *adev,
 
 		tmp = regVM_L2_CNTL4_DEFAULT;
 		/* For AMD APP APUs setup WC memory */
-		if (adev->gmc.xgmi.connected_to_cpu || adev->gmc.is_app_apu) {
+		if (adev->gmc.xgmi.connected_to_cpu || adev->gmc.is_app_apu || gart_ram_alloc) {
 			tmp = REG_SET_FIELD(tmp, VM_L2_CNTL4, VMC_TAP_PDE_REQUEST_PHYSICAL, 1);
 			tmp = REG_SET_FIELD(tmp, VM_L2_CNTL4, VMC_TAP_PTE_REQUEST_PHYSICAL, 1);
 		} else {
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 53bd7506ff22..5c9a0f3d5581 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1670,7 +1670,7 @@ static int gmc_v9_0_gart_init(struct amdgpu_device *adev)
 	adev->gart.gart_pte_flags = AMDGPU_PTE_MTYPE_VG10(MTYPE_UC) |
 				 AMDGPU_PTE_EXECUTABLE;
 
-	if (!adev->gmc.real_vram_size) {
+	if (!adev->gmc.real_vram_size || gart_ram_alloc) {
 		dev_info(adev->dev, "Put GART in system memory for APU\n");
 		r = amdgpu_gart_table_ram_alloc(adev);
 		if (r)
@@ -1890,7 +1890,7 @@ static int gmc_v9_0_sw_fini(void *handle)
 	amdgpu_gmc_ras_fini(adev);
 	amdgpu_gem_force_release(adev);
 	amdgpu_vm_manager_fini(adev);
-	if (!adev->gmc.real_vram_size) {
+	if (!adev->gmc.real_vram_size || gart_ram_alloc) {
 		dev_info(adev->dev, "Put GART in system memory for APU free\n");
 		amdgpu_gart_table_ram_free(adev);
 	} else {
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
index a8faf66b6878..b18bb3773f77 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
@@ -258,7 +258,7 @@ static void mmhub_v1_8_init_cache_regs(struct amdgpu_device *adev)
 
 		tmp = regVM_L2_CNTL4_DEFAULT;
 		/* For AMD APP APUs setup WC memory */
-		if (adev->gmc.xgmi.connected_to_cpu || adev->gmc.is_app_apu) {
+		if (adev->gmc.xgmi.connected_to_cpu || adev->gmc.is_app_apu || gart_ram_alloc) {
 			tmp = REG_SET_FIELD(tmp, VM_L2_CNTL4,
 					    VMC_TAP_PDE_REQUEST_PHYSICAL, 1);
 			tmp = REG_SET_FIELD(tmp, VM_L2_CNTL4,
-- 
2.39.2

