Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC7A4D116EA
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Nov 2025 07:13:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43DE510E109;
	Fri, 28 Nov 2025 07:13:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AtFtKKFc";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012021.outbound.protection.outlook.com [52.101.43.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1D2810E109
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Nov 2025 07:13:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pOtyJqL+DWcpbWAvO8nyfCFp4A8c79705s+Lkyh+Ojy4nWEcOKBvnc7ftsTY8mrVjrhMHNtjxDjZQoadPfaDoZnSk9F/vIRQA9Em4XeE64Yjhx4mU8RR5AD6n3YClzoVoLfJSaNjQKo3GKnaagLnO+6PNm9SuEhvn8bEpDFFGBbl4tgCFtDHsw1m6aZWY5Ca8kIiHYK2JglSBhY8klgA7mL+vYXAgeoXomoeNI5Q8dtv4BrUqH4eW0O1R4lePBr1GwwltOKiG6ZfidMbXHXGAylL5hbQagffNDQqPQR9yb4kYYD0XhbLRFK6Mj6Hby8qmYgEJiO+4KtxOnZLiHmkGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k4vaH0KITUpRmWp//178t9l09WAxG4RiJAKE+Rvjf3A=;
 b=GmbEijtazj589sKv1OInc9/geYGQP5ChIzwl/lLdEdymfUIf/MxTj1PLZK5dF3ar/E1QXFIajOnrVoBVqSyB6Yybwl5moSMRqdOLQm7YRHwFWjEL9su23FheTEzQ27dxGRLPcs666+a484wjbU+PMB2SUWfVcPRdiqcost4rJ5iM8ksiE9VwhZyOhHcTp0RqOX+xnDEh9Rx1xGhCbm0mqOBm0R+iFEdYFfZaFABK/4mgLn36X45qJeuMHpuQUuxUBLYj0pnSuyRFxbUscRZbukIkB7dU//+R2mWk4jqgOIbKW2ytSoospm5veJarldmRz++C/9a9zsWpnZHOsawDPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k4vaH0KITUpRmWp//178t9l09WAxG4RiJAKE+Rvjf3A=;
 b=AtFtKKFcFyQqZQHFWmjVGCXSlJvC3ZSfSICSmJlbTAJ91ZwrSH1sQ1BFm9L9DdEhcj9aOsuQvMyCdFKr58/a/u2AttD6fv9Dh6lGX6G1SkU53EyDI1jC+3Z5QDqVKLT1mgbUfiV+I6XRAhy4ALPkbMWmmt9c+cIgYsbys02PaF8=
Received: from MN0PR03CA0007.namprd03.prod.outlook.com (2603:10b6:208:52f::6)
 by BY5PR12MB4131.namprd12.prod.outlook.com (2603:10b6:a03:212::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.16; Fri, 28 Nov
 2025 07:13:01 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:208:52f:cafe::2c) by MN0PR03CA0007.outlook.office365.com
 (2603:10b6:208:52f::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.16 via Frontend Transport; Fri,
 28 Nov 2025 07:12:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Fri, 28 Nov 2025 07:13:01 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 28 Nov
 2025 01:12:59 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amdgpu: Make pre_asic_init optional
Date: Fri, 28 Nov 2025 12:42:33 +0530
Message-ID: <20251128071233.3582000-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|BY5PR12MB4131:EE_
X-MS-Office365-Filtering-Correlation-Id: 3df4da28-4fd5-4c1f-bf51-08de2e4d90d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?86LcN9CokxfwMMCOXvlpp7Us1P5eZCktYStzrkDTKgKwFstVHnjT4zZDMqQ/?=
 =?us-ascii?Q?3wPHn313NDXSQBnlme7SpHOdFEyUT9QGf8wJu3XbJPl54OVGUTAhxaLPOkDW?=
 =?us-ascii?Q?4rwC1vfFfUy4V8gFx3zSBx+sBcxBuSDFRIAalC3ZbD8vaSYoKWJ5rdhdJbuT?=
 =?us-ascii?Q?US7atZRziba4k4NlBZO85QawMYv45Pj8yqUUUZgp/kCo4lXIrEVM3kytaTy4?=
 =?us-ascii?Q?6+LVEHdEu9+aRZMGqhfoN4OUJ7cf27ummtQVVIQjYjcdPs26D1qEi7B48a0p?=
 =?us-ascii?Q?Cv9KJwR/Ypb322DmrB13bCNybGOaHfVAJ7ccelyn/CxpfQJ+opvBfAvmvdMt?=
 =?us-ascii?Q?M+wTUBGRp78gHZwPQT13Hjz+ys5xzB8u6oK1qCkFRirU/iXt5s6p5cUnA3S3?=
 =?us-ascii?Q?x3pLLeEE+YTH0gkkI7HV8PbOATMOzYUrQUzG7pu3sM9oS5vk/eJuV2tV/peb?=
 =?us-ascii?Q?QK1h7V4CghwjgQCqgKQeOEzQOmEVRtkoRhmrZFVYthtR5ElzbLygJ3/y5wC/?=
 =?us-ascii?Q?xcSht9x0mxlVu120S4G7G9tC3JFV3GKNT7GHN7bTziTogrcb71wIr+utj1nb?=
 =?us-ascii?Q?I5GeuBsVUf0VEYQ0web741j5jpvhT08HQI0/LASYsXdSuoyocXvJAdtLoWlG?=
 =?us-ascii?Q?9HH3AJofCjPMei828GHI+GxIWEWxseNDFS2jjZdzBjNCpWGz8AOxLyJYDqFH?=
 =?us-ascii?Q?gDpqZzrFrqZfhOpOXLxClKvv4fKpMWoPfYpffT6UN+fWq+ew9Kekw0mPRSgg?=
 =?us-ascii?Q?m6L4W2YUy38JrZkQGaDmSiPYNI5NKrovW84tzPAvn7+eCsdHmfd9CyKuv779?=
 =?us-ascii?Q?xVA6qXn3oTCxDFa6qVnij055juQUmIp56W8Tjsz2mdngjevc2Zwummn+AkTc?=
 =?us-ascii?Q?v7Shjbt4x4/E7i23lfzgbD29AltcW417TphN1YxLlm02jBNOyz20RCdyBfRk?=
 =?us-ascii?Q?RqRU4Vep4PwntsK3z7a2Sdqsk9jIJRdWpgYjyEAYTIv86tHhsjMbf2xzk6nN?=
 =?us-ascii?Q?Vi+xi9Am4KvDlPB29OIX6PCscNChAsln31JiqL9NNhbGzLAsO7O9koBh67ls?=
 =?us-ascii?Q?q/MI+qYirj6GEmNlXCtpgHAMzhGY+FQZ416bmgSeeQDVc6hTD+LgiWAM7xmF?=
 =?us-ascii?Q?aF+wKFF50znr18KPVEhRO4qoFtKbj4d/hWcuBvQf4yTgMshPPebkhcV6UIOO?=
 =?us-ascii?Q?Hbb/LueBUkz8SdAadtyf8YW30EaCCxT7Ox+xDTyORqEZOjhlvjf0kgCGFlgi?=
 =?us-ascii?Q?8mCRcSM1utZAMTinK6OJxZCkbJkcPoLJCA3aUpuOilHUQR0CnxHYpbyzFcCr?=
 =?us-ascii?Q?WoAoiIvFZjg+I90xqRzQgXT3qDWiFT4OG5w9UiFHSImlflDiY5N1MpGjEWu9?=
 =?us-ascii?Q?cKel5f7V0ncFRb4bX72h8h0K5vvLAClppdx4sPfnYocP4nqXGbeSR0vf/jAT?=
 =?us-ascii?Q?0ktWKQsdOgv22CdEPfa8JqBAC4Ej9Hzb4aQ7+PwBcoe9iOGpG6Gl2ixKQJe3?=
 =?us-ascii?Q?lb9jiAJPgv5VgWdi9ezCOn1lRkDjJcnV5L0Xh5ANX4GrLPTrB+DokUSPW2I9?=
 =?us-ascii?Q?BDPWB4Fbow5r8HiUWW8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 07:13:01.0043 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3df4da28-4fd5-4c1f-bf51-08de2e4d90d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4131
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

pre_asic_init is not required for all SOCs. Make it optional and remove
empty implementations.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 5 ++++-
 drivers/gpu/drm/amd/amdgpu/cik.c    | 5 -----
 drivers/gpu/drm/amd/amdgpu/nv.c     | 5 -----
 drivers/gpu/drm/amd/amdgpu/si.c     | 5 -----
 drivers/gpu/drm/amd/amdgpu/soc15.c  | 1 -
 drivers/gpu/drm/amd/amdgpu/soc21.c  | 5 -----
 drivers/gpu/drm/amd/amdgpu/soc24.c  | 5 -----
 drivers/gpu/drm/amd/amdgpu/vi.c     | 5 -----
 8 files changed, 4 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 790e84fec949..ad1e536ed849 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1549,7 +1549,10 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
 #define amdgpu_asic_get_pcie_replay_count(adev) ((adev)->asic_funcs->get_pcie_replay_count((adev)))
 #define amdgpu_asic_supports_baco(adev) \
     ((adev)->asic_funcs->supports_baco ? (adev)->asic_funcs->supports_baco((adev)) : 0)
-#define amdgpu_asic_pre_asic_init(adev) (adev)->asic_funcs->pre_asic_init((adev))
+#define amdgpu_asic_pre_asic_init(adev)                              \
+	(((adev)->asic_funcs && (adev)->asic_funcs->pre_asic_init) ? \
+		 (adev)->asic_funcs->pre_asic_init((adev)) :         \
+		 0)
 #define amdgpu_asic_update_umd_stable_pstate(adev, enter) \
 	((adev)->asic_funcs->update_umd_stable_pstate ? (adev)->asic_funcs->update_umd_stable_pstate((adev), (enter)) : 0)
 #define amdgpu_asic_query_video_codecs(adev, e, c) (adev)->asic_funcs->query_video_codecs((adev), (e), (c))
diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
index 9cd63b4177bf..fc0d2524b16f 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c
@@ -1957,10 +1957,6 @@ static uint64_t cik_get_pcie_replay_count(struct amdgpu_device *adev)
 	return (nak_r + nak_g);
 }
 
-static void cik_pre_asic_init(struct amdgpu_device *adev)
-{
-}
-
 static const struct amdgpu_asic_funcs cik_asic_funcs =
 {
 	.read_disabled_bios = &cik_read_disabled_bios,
@@ -1981,7 +1977,6 @@ static const struct amdgpu_asic_funcs cik_asic_funcs =
 	.need_reset_on_init = &cik_need_reset_on_init,
 	.get_pcie_replay_count = &cik_get_pcie_replay_count,
 	.supports_baco = &cik_asic_supports_baco,
-	.pre_asic_init = &cik_pre_asic_init,
 	.query_video_codecs = &cik_query_video_codecs,
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 50e77d9b30af..f17c3839aea1 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -593,10 +593,6 @@ static void nv_init_doorbell_index(struct amdgpu_device *adev)
 	adev->doorbell_index.sdma_doorbell_range = 20;
 }
 
-static void nv_pre_asic_init(struct amdgpu_device *adev)
-{
-}
-
 static int nv_update_umd_stable_pstate(struct amdgpu_device *adev,
 				       bool enter)
 {
@@ -630,7 +626,6 @@ static const struct amdgpu_asic_funcs nv_asic_funcs = {
 	.need_reset_on_init = &nv_need_reset_on_init,
 	.get_pcie_replay_count = &amdgpu_nbio_get_pcie_replay_count,
 	.supports_baco = &amdgpu_dpm_is_baco_supported,
-	.pre_asic_init = &nv_pre_asic_init,
 	.update_umd_stable_pstate = &nv_update_umd_stable_pstate,
 	.query_video_codecs = &nv_query_video_codecs,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index f7288372ee61..70e9ba9d927c 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -2003,10 +2003,6 @@ static int si_set_vce_clocks(struct amdgpu_device *adev, u32 evclk, u32 ecclk)
 	return 0;
 }
 
-static void si_pre_asic_init(struct amdgpu_device *adev)
-{
-}
-
 static const struct amdgpu_asic_funcs si_asic_funcs =
 {
 	.read_disabled_bios = &si_read_disabled_bios,
@@ -2028,7 +2024,6 @@ static const struct amdgpu_asic_funcs si_asic_funcs =
 	.need_reset_on_init = &si_need_reset_on_init,
 	.get_pcie_replay_count = &si_get_pcie_replay_count,
 	.supports_baco = &si_asic_supports_baco,
-	.pre_asic_init = &si_pre_asic_init,
 	.query_video_codecs = &si_query_video_codecs,
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 42f5d9c0e3af..54b14751fd7a 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -951,7 +951,6 @@ static const struct amdgpu_asic_funcs aqua_vanjaram_asic_funcs =
 	.need_reset_on_init = &soc15_need_reset_on_init,
 	.get_pcie_replay_count = &amdgpu_nbio_get_pcie_replay_count,
 	.supports_baco = &soc15_supports_baco,
-	.pre_asic_init = &soc15_pre_asic_init,
 	.query_video_codecs = &soc15_query_video_codecs,
 	.encode_ext_smn_addressing = &aqua_vanjaram_encode_ext_smn_addressing,
 	.get_reg_state = &aqua_vanjaram_get_reg_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index ad36c96478a8..55c3781fc730 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -513,10 +513,6 @@ static void soc21_init_doorbell_index(struct amdgpu_device *adev)
 	adev->doorbell_index.sdma_doorbell_range = 20;
 }
 
-static void soc21_pre_asic_init(struct amdgpu_device *adev)
-{
-}
-
 static int soc21_update_umd_stable_pstate(struct amdgpu_device *adev,
 					  bool enter)
 {
@@ -546,7 +542,6 @@ static const struct amdgpu_asic_funcs soc21_asic_funcs = {
 	.need_reset_on_init = &soc21_need_reset_on_init,
 	.get_pcie_replay_count = &amdgpu_nbio_get_pcie_replay_count,
 	.supports_baco = &amdgpu_dpm_is_baco_supported,
-	.pre_asic_init = &soc21_pre_asic_init,
 	.query_video_codecs = &soc21_query_video_codecs,
 	.update_umd_stable_pstate = &soc21_update_umd_stable_pstate,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgpu/soc24.c
index 972b449ab89f..ecb6c3fcfbd1 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc24.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
@@ -327,10 +327,6 @@ static void soc24_init_doorbell_index(struct amdgpu_device *adev)
 	adev->doorbell_index.sdma_doorbell_range = 20;
 }
 
-static void soc24_pre_asic_init(struct amdgpu_device *adev)
-{
-}
-
 static int soc24_update_umd_stable_pstate(struct amdgpu_device *adev,
 					  bool enter)
 {
@@ -357,7 +353,6 @@ static const struct amdgpu_asic_funcs soc24_asic_funcs = {
 	.need_reset_on_init = &soc24_need_reset_on_init,
 	.get_pcie_replay_count = &soc24_get_pcie_replay_count,
 	.supports_baco = &amdgpu_dpm_is_baco_supported,
-	.pre_asic_init = &soc24_pre_asic_init,
 	.query_video_codecs = &soc24_query_video_codecs,
 	.update_umd_stable_pstate = &soc24_update_umd_stable_pstate,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index a611a7345125..6a574b6c8e63 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -1424,10 +1424,6 @@ static bool vi_need_reset_on_init(struct amdgpu_device *adev)
 	return false;
 }
 
-static void vi_pre_asic_init(struct amdgpu_device *adev)
-{
-}
-
 static const struct amdgpu_asic_funcs vi_asic_funcs =
 {
 	.read_disabled_bios = &vi_read_disabled_bios,
@@ -1447,7 +1443,6 @@ static const struct amdgpu_asic_funcs vi_asic_funcs =
 	.need_reset_on_init = &vi_need_reset_on_init,
 	.get_pcie_replay_count = &vi_get_pcie_replay_count,
 	.supports_baco = &vi_asic_supports_baco,
-	.pre_asic_init = &vi_pre_asic_init,
 	.query_video_codecs = &vi_query_video_codecs,
 };
 
-- 
2.49.0

