Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E3DFC4167B
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Dec 2023 04:23:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C96210E7D8;
	Thu,  7 Dec 2023 04:23:22 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF2C210E7D8
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Dec 2023 04:23:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GtcDFXatokjdxQ1HccfXQTscVKD84/Qp5bYuZ5xMgEndGkf/Gxm4vtPg7/xbQIv5fewgBiP7ODjG5w7bw6/WUv0lVlc49IXeMaKx83ZZtOlTm0v7qiZb9+xhi+QqKBUiDRLT/sBY4vy0OPpQCm+RaooHVF4QZDcvhDGM4gwfC6i9tP9WA+z+MpdjCjqGr/ispmNzMytqxPLNJYGT+ZpdI6VJlEdsGSEpi3cSGmee/HYyistlMa+g3UrxR5qNTp6tsZ38ceaTJSvnZjH/H0u10nhgQTpbov3d6zO8fMM4i0fAXD63JV+iqUSWghL51t12PGoUjBgHIzQwU2FDWhvWBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=klD3cQVr7YsqeFu3DhTT3me+rUyaSjr/m2rv1mj2DB0=;
 b=jiuhCvxHKJIuC169FxCmc1NE/To+KCuU6t+Ra1gQQmwg+cswZwDNJSwfKrKNjJX7GVKDfPRA0SzaL49oDMcZ2gIn3FAu8ujsMhfsGinc/39b/ukmCMjdSZ2z/gc/YaRzxKKIag6lxzdPbbpPq0nG5zi14DxCAckZotwIoyjZW+7Zi78rmCJ/YdgS0EPGG964ax2QfMKxMOlFlBACiAt8LVXoKpapFqKAq3lfQf51qRVfrQrSDF4ZAGnPnL6almRBmBMGiafa1tQkY8J+wN3YLhNb5vPzO3n2veKOLBWyD2TLysYVoMRRqT4ZR43/4XjJPcjYqpq2lMfu8uiIH/AY2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=klD3cQVr7YsqeFu3DhTT3me+rUyaSjr/m2rv1mj2DB0=;
 b=t5KNZnyodfG/H/PGu13fXlqPKiaDVMBlcK7QgU/ZFc6a3TLaWGIQkrEe8wIPZpeiRigPFwqQ/nrFQcfIfmUcWeTw7fv3BVoqzIIiO1EL9BORLwNuzJuT5cHIVQlVkHaH1NXiY62Vk+TKe+gpWN+xqBEIV4d8KkwDKKcCjyQDlp8=
Received: from MN2PR16CA0031.namprd16.prod.outlook.com (2603:10b6:208:134::44)
 by DS0PR12MB6440.namprd12.prod.outlook.com (2603:10b6:8:c8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Thu, 7 Dec
 2023 04:23:15 +0000
Received: from BL02EPF0001A100.namprd03.prod.outlook.com
 (2603:10b6:208:134:cafe::7a) by MN2PR16CA0031.outlook.office365.com
 (2603:10b6:208:134::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26 via Frontend
 Transport; Thu, 7 Dec 2023 04:23:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A100.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Thu, 7 Dec 2023 04:23:15 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 6 Dec
 2023 22:23:14 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: Use the right method to get IP version
Date: Thu, 7 Dec 2023 09:52:57 +0530
Message-ID: <20231207042257.1468251-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A100:EE_|DS0PR12MB6440:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e201846-cb56-4842-79f3-08dbf6dc3ba1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vjNGByDa2TbFAENe3iXcaMpXzRx0f+xxW0GKRmEQHjSsShN8uZDoQ8xE8h1ZiDK33e5BsvbASC+4Xo/exjG3lXuRl3lb//JUwM9P4fB3mPa3S33SM+Ego768zy8kbw5clJCo07YJ8ilKE+5xWdvNf4tt2rdOhLZqEax75iC0tstxWrm4uiINJutyy1K2P+WhSXtadwPChzX8Yd9QyasqV/FMclWr9rJ1OX5i+M7uIxvrkMwLkG62Vdpo9mJ0IIoYAKGc5+e96hfJlZ+shtbZUpGqV31AC9/p4mY34WItrRdFtNy2PxA6CnKxqHLnXebithvZHG2NgqJ/J586z3c1NNSPUHOPnylH7hiTSSC5Mipxjl/+AWiymff95xcpcOsLU1/JmZnzUomRITVZ03676cBrwfquEtmWiO++yj3JCMyBIMGYmijudRezgV6whQE8rKhfQmJ/g7tKvVeuBXnFzhvGpfyVGA70UpbFtArSQc0559fvNN2NNQcxKg1hALgL0WAuuBhdFQ1auRNrmBWgq0J6750SU0c7cfpOPk1v7IgdEskR1RbPYuNpIYGEOorgza7YzPecsuHbGoOgLSD/BLwwlcrS+snWOi0xDwuGM+NqkTUAhmEEyBzvwMne89TRaOlUvdf70ZEaLo0dG3b0OKVUP+r8gBp0x5bG5NbC/svPLm8VNq+9xIvirUvWmEaBKjIHraixvLdVJmX9wlWR5FENLa4Rb4tYKJ/7VWd/NOgsSbnDCL0V+3RqmwdFH6a0w3AOI0OelOw3x8bjpfQcuA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(136003)(396003)(346002)(230922051799003)(64100799003)(1800799012)(186009)(82310400011)(451199024)(46966006)(36840700001)(40470700004)(40480700001)(26005)(40460700003)(36860700001)(81166007)(356005)(47076005)(5660300002)(2906002)(82740400003)(336012)(426003)(83380400001)(6666004)(16526019)(2616005)(1076003)(7696005)(36756003)(70206006)(41300700001)(316002)(478600001)(6916009)(54906003)(70586007)(86362001)(4326008)(8936002)(8676002)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 04:23:15.6264 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e201846-cb56-4842-79f3-08dbf6dc3ba1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A100.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6440
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
Cc: Alexander.Deucher@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Replace direct usage of adev->ip_versions with amdgpu_ip_version.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
v2:
	Fix two more instances in amdgpu_dm.c

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c        | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c          | 3 ++-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c             | 2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 ++++---
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c    | 6 +++---
 5 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 1b73f519cfb8..f9e8341d9449 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1599,7 +1599,7 @@ bool amdgpu_device_seamless_boot_supported(struct amdgpu_device *adev)
 	if (adev->mman.keep_stolen_vga_memory)
 		return false;
 
-	return adev->ip_versions[DCE_HWIP][0] >= IP_VERSION(3, 0, 0);
+	return amdgpu_ip_version(adev, DCE_HWIP, 0) >= IP_VERSION(3, 0, 0);
 }
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 3a632c3b1a2c..0dcff2889e25 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -1099,7 +1099,8 @@ bool amdgpu_sriov_xnack_support(struct amdgpu_device *adev)
 {
 	bool xnack_mode = true;
 
-	if (amdgpu_sriov_vf(adev) && adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 2))
+	if (amdgpu_sriov_vf(adev) &&
+	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 2))
 		xnack_mode = false;
 
 	return xnack_mode;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 2ac5820e9c92..473a774294ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -883,7 +883,7 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	 * GRBM interface.
 	 */
 	if ((vmhub == AMDGPU_GFXHUB(0)) &&
-	    (adev->ip_versions[GC_HWIP][0] < IP_VERSION(9, 4, 2)))
+	    (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(9, 4, 2)))
 		RREG32_NO_KIQ(req);
 
 	for (j = 0; j < adev->usec_timeout; j++) {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index c146dc9cba92..3fd01b7b7766 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1710,7 +1710,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	init_data.clk_reg_offsets = adev->reg_offset[CLK_HWIP][0];
 
 	/* Enable DWB for tested platforms only */
-	if (adev->ip_versions[DCE_HWIP][0] >= IP_VERSION(3, 0, 0))
+	if (amdgpu_ip_version(adev, DCE_HWIP, 0) >= IP_VERSION(3, 0, 0))
 		init_data.num_virtual_links = 1;
 
 	INIT_LIST_HEAD(&adev->dm.da_list);
@@ -8908,7 +8908,7 @@ static void dm_set_writeback(struct amdgpu_display_manager *dm,
 	}
 
 	wb_info->mcif_buf_params.p_vmid = 1;
-	if (adev->ip_versions[DCE_HWIP][0] >= IP_VERSION(3, 0, 0)) {
+	if (amdgpu_ip_version(adev, DCE_HWIP, 0) >= IP_VERSION(3, 0, 0)) {
 		wb_info->mcif_warmup_params.start_address.quad_part = afb->address;
 		wb_info->mcif_warmup_params.region_size =
 			wb_info->mcif_buf_params.luma_pitch * wb_info->dwb_params.dest_height;
@@ -9860,7 +9860,8 @@ static bool should_reset_plane(struct drm_atomic_state *state,
 	 * TODO: Remove this hack for all asics once it proves that the
 	 * fast updates works fine on DCN3.2+.
 	 */
-	if (adev->ip_versions[DCE_HWIP][0] < IP_VERSION(3, 2, 0) && state->allow_modeset)
+	if (amdgpu_ip_version(adev, DCE_HWIP, 0) < IP_VERSION(3, 2, 0) &&
+	    state->allow_modeset)
 		return true;
 
 	/* Exit early if we know that we're adding or removing the plane. */
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
index d8f8ad0e7137..4894f7ee737b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -224,7 +224,7 @@ int smu_v14_0_check_fw_version(struct smu_context *smu)
 	if (smu->is_apu)
 		adev->pm.fw_version = smu_version;
 
-	switch (adev->ip_versions[MP1_HWIP][0]) {
+	switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
 	case IP_VERSION(14, 0, 2):
 		smu->smc_driver_if_version = SMU14_DRIVER_IF_VERSION_SMU_V14_0_2;
 		break;
@@ -235,7 +235,7 @@ int smu_v14_0_check_fw_version(struct smu_context *smu)
 		break;
 	default:
 		dev_err(adev->dev, "smu unsupported IP version: 0x%x.\n",
-			adev->ip_versions[MP1_HWIP][0]);
+			amdgpu_ip_version(adev, MP1_HWIP, 0));
 		smu->smc_driver_if_version = SMU14_DRIVER_IF_VERSION_INV;
 		break;
 	}
@@ -733,7 +733,7 @@ int smu_v14_0_gfx_off_control(struct smu_context *smu, bool enable)
 	int ret = 0;
 	struct amdgpu_device *adev = smu->adev;
 
-	switch (adev->ip_versions[MP1_HWIP][0]) {
+	switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
 	case IP_VERSION(14, 0, 2):
 	case IP_VERSION(14, 0, 0):
 		if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
-- 
2.25.1

