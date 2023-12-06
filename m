Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C8CBC4167B
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Dec 2023 12:41:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E81510E709;
	Wed,  6 Dec 2023 12:41:29 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::61c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9C2B10E709
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Dec 2023 12:41:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ghEUeUj9+8epGac/KFYs2tBB7Wpkow+Luvn+sCaFjrH8JcUj8ANezP5wnc9ZBlCwhqIws34UZoCGfatriAER/YyHCaaWtfafMLIUasmcyudiARaVj3DmttAWRQkGRvBTamY8FlQ3aBxzQgK7Sjuc1X+pOIFmjDDfPJkdwaz+HcpDWBs8xzewEzuzUybUreiSAZhc3WcPjQ+8GbHZFCGyrWIeV597GXMRnwfXrThm0IcKSZvpGJVEym4Zx6JL3q5GPx10hTKOtPuQkoEnPWFY49W/QBS8bRiBMjJA2ytK0HVaJuNqdO2R5wbsbc4RK0p6wd0p2I+ug6VkZflBRQ5tBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJLxwTU92TKOWsxbcS3Ea+4NHkHToWEJruHswZQCZ2g=;
 b=jVggcvi82o9fXB5bOt7LK5635aIaU8uCdGSiC+VRi8AYOEBtGiwiFLsxXuKqhOO1MDJ/81ZqbA397UDhtd/24YUxz3PxTMwbDLkb62zH4d5oZs5UDAwdrRIoBkJiQmdzLXIW5WVIs4eCwJiSPgDHKIzAuXK6oH4WJn9HuI7At6Rfab2NfZ1WB61+CkTS0vHvLFoii6a/NFD52cgOwYIQjfMh56xALqoN8J9Rf1MVouBrduKApDLCqaiOHiIh/T7ZEjzJNqAzSA0+Zd63lLyIc3ZUprtBMVFxgNnrWQ4WNC/eQzOU9B9VyEJu32fCzvqtg4PivMexpWVHte3yoLkCGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJLxwTU92TKOWsxbcS3Ea+4NHkHToWEJruHswZQCZ2g=;
 b=u5JAGOQbxx9qUV2zukjyqqj3g5BEVB5++ACnqw77vUus8sfp4cqCSgK8mQf873buBFhH9CSR1dYuRHrGrT2slzC0zuhloHIgtxtxy+NrEnlrCMpoOydlhBJvp+Wu6xTUHhPQMoewwnEl4FTVKmq3sgh6a+W0vw4dWAdA5vYTyLI=
Received: from PH8PR15CA0015.namprd15.prod.outlook.com (2603:10b6:510:2d2::23)
 by CH2PR12MB4167.namprd12.prod.outlook.com (2603:10b6:610:7a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.36; Wed, 6 Dec
 2023 12:41:24 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:510:2d2:cafe::7e) by PH8PR15CA0015.outlook.office365.com
 (2603:10b6:510:2d2::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25 via Frontend
 Transport; Wed, 6 Dec 2023 12:41:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Wed, 6 Dec 2023 12:41:23 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 6 Dec
 2023 06:41:22 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Use the right method to get IP version
Date: Wed, 6 Dec 2023 18:11:07 +0530
Message-ID: <20231206124107.1462461-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|CH2PR12MB4167:EE_
X-MS-Office365-Filtering-Correlation-Id: b20636d8-2c15-4985-acd4-08dbf658a7f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Fd0okSUm6QJel2vAfPXjT/uvLclxiVEEkHf5Oaan9XHNsCfOX197+xT5JETg/phvXO0vy3HEIRV9rogqSMtfYz07ZCgEFjnDrVGh7ejcBtGVyEnLahfRqevTDRjsHetxv6tn77hqfbxYBJwBQ7pxBEbb4IPy6DxdP7RCLOPX/WwflZov04Rrcy+nz+umOHaP4KbZX2j+tslguRScJ/8xodExCGE1bl7X/5uheGKkRq5YtIj4wLLbvhFtI/V0/ApcKKdcZvX0wsz+y5nYe5CwUHDoSZcHfK7Y34p0ifysgBjpLTdN3i5FXuAJxjACNh6doQWu7HtWlbk+DJZnH+XuZlZVUebwxDKA+o0QGuKYlnPLJFedBSC0/WwKMgejgdGcl2Acsui1AZ1L4ODlZLPEIOv8j+PkE5DG6icmAp7Yn31Oi5g0yQpWU0c9wmvpTSn6cfV+JemdSe4GN+hWNlRdtKLQTHJYETT/ruu2dx6t6eGnKVnxl2Vjn0KVCRYLUIiTT/KZyEeP5z8Y107tViB0ZonriFY7la13iAtyxgpcOMA967wa4eKMPSeNj0nbSVl+EDsXlUJh3o7/GFnSHmYCrSYFhnwucOfiKoLZ7tIdsi+1PEeowUq7S+DH10NY64sR/CDROfu1BSte40LUWH7DqfVEwey5Apv5yNY3Z4XexjqbBF9Lz2I5Q2qkawXis3n8lG1pHVuwXggvmJbv8wRpmOcqnqyrGJ6olISVygeOpnPLSv/L2un4GHi//LmKUI1+YFTPaTuMnYe5uTDSxZKZQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(136003)(346002)(396003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(82310400011)(46966006)(40470700004)(36840700001)(36860700001)(47076005)(356005)(81166007)(7696005)(26005)(336012)(426003)(16526019)(40480700001)(54906003)(6916009)(70206006)(70586007)(316002)(82740400003)(83380400001)(2616005)(6666004)(478600001)(1076003)(4326008)(8936002)(8676002)(86362001)(40460700003)(5660300002)(2906002)(36756003)(41300700001)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 12:41:23.7948 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b20636d8-2c15-4985-acd4-08dbf658a7f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4167
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c        | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c          | 3 ++-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c             | 2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c    | 6 +++---
 5 files changed, 9 insertions(+), 7 deletions(-)

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
index c146dc9cba92..394142cf72bc 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
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

