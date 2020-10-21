Return-Path: <SRS0=buuZ=D4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24ABBC56204
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 07:56:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79CC522249
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 07:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HTLxXevZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79CC522249
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDD2B6E9B8;
	Wed, 21 Oct 2020 07:56:21 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEA756E96E
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 07:56:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fJWgO55dj4I3iZuWqz6R668toSLo3GbI2pfxbkPmgsr/zJ6ro1NS4vc5LXfUiF33aCnfPXGMQVMMPd1rpZAULU/Dy3GFLgsWR17RkcicDNNi9W61ZyHwpvLBB4hCkgbWIO8yj0Q6vWzdUSk1jyOK2PJ3+zoORZ2iHEMeYXYyetYAVNh62ulSCHmJyDuqGrtrV+w4nBfJ6x5GRbMEr1fUkyw+DCHvJ0HAb9cWaHBPTiteVbS+TuL4M/sg7cTEB3b8nWfJbLBIaHGt6+5lvgyQiatPqCFDpivYIqAsIpSEbWCd/UFS9QxZ0vweRxs2Gs6WkhVlb95mzU+R/+/nSVmJzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YfJNwv1sQGAAoRO19oEbuZ3L546O7Etv+bqIJG3WKqo=;
 b=XtGFbFTmpNdvVcY3BVF1ouGZY7CuaCqjiSDpsArL6YumfW9dihcSYoxevlgdbaADvHB6fSioPG+2YX9VX36tNMTMfq1V+qhjsppapWB5aGPnSeLNK5QnWgUlCnkVzZpf91PoFyFRmwkMI0U+SkJrBPf3FDi7sCihgeuhoFrZu705udAM3dY7Z1Wcf3UR/gHt8y9hirpV5cB9VLGvkOrY8yUkO2RweZJ6jE+bHRYNtCVvkt4m+wXPlYYCrV+iPVpfkz2mCNo5Qz2w/9Ro7okhm6x9ZdMzY0UxRvmXMJE53rJ+ijbooUCti80GlzpO/UZFQrrO5YeIL5Y8/cnCTorVfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YfJNwv1sQGAAoRO19oEbuZ3L546O7Etv+bqIJG3WKqo=;
 b=HTLxXevZu83RkzndZT8cIWJdNvKCVsGc7zn9UnwIUeen2CsotCAmD1guqArZnepPDp5bBq63McbHokIfGOOqEJiS2W62StT7DVJ0AU4PWa5pyAqgBSYd7sBjQ3VCQQ/XT6DR1wetHL9oxrM5iucJSjcogtSskN7rkUC1g0ldt20=
Received: from BN6PR14CA0037.namprd14.prod.outlook.com (2603:10b6:404:13f::23)
 by DM5PR12MB1899.namprd12.prod.outlook.com (2603:10b6:3:113::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Wed, 21 Oct
 2020 07:56:17 +0000
Received: from BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:13f:cafe::b7) by BN6PR14CA0037.outlook.office365.com
 (2603:10b6:404:13f::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Wed, 21 Oct 2020 07:56:17 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT067.mail.protection.outlook.com (10.13.177.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3499.18 via Frontend Transport; Wed, 21 Oct 2020 07:56:16 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 21 Oct
 2020 02:56:16 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 21 Oct
 2020 02:56:16 -0500
Received: from rico-code.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 21 Oct 2020 02:56:13 -0500
From: Tianci Yin <tianci.yin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdgpu: disable DCN for navi10 blockchain SKU
Date: Wed, 21 Oct 2020 15:56:07 +0800
Message-ID: <20201021075608.16785-2-tianci.yin@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201021075608.16785-1-tianci.yin@amd.com>
References: <20201021075608.16785-1-tianci.yin@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3288aaa-f0c2-4622-efb1-08d87596ca22
X-MS-TrafficTypeDiagnostic: DM5PR12MB1899:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1899B9179BDC740E07B87FE1951C0@DM5PR12MB1899.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x8xiIRA9Lcs0sVj2utpJsXM9EsRMg3dldDAJxqc+apODGKSHWWwmXBm5GMexHa/QVqJgD7B97b2TBKkWy6aSa1ozF/xGsoq0axPGCikNNZmc2Ne8llHnO100+rOzJaN0TesHefoMWP6Y+8KFLpMZuLe6qkChEG8EqAHHCtcegogL+qVAuN4kUKLdEr+LTXakR6kaVsebwVbKwLA42wGge/jPMAOBfm/U9xDvWZWDW++776zTJhZDc962rKVqxZQ6SxeenyT5GxQh8GJuORIzhkanhrDM16Uxi/lhQMVSwvvNjWNTvf1d6yjdeqX90odmQus/UNrbo0/evfqLiTYsiu/n9QEITpj7IpnKYZRa7Q75XovvlScvZtq1cw4JObU997BgDyY+nT9l06rh9zpshQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(39850400004)(376002)(136003)(346002)(46966005)(316002)(36756003)(2906002)(26005)(186003)(70586007)(70206006)(8676002)(356005)(4326008)(8936002)(82310400003)(6666004)(54906003)(44832011)(86362001)(83380400001)(478600001)(6916009)(5660300002)(81166007)(1076003)(426003)(336012)(82740400003)(2616005)(7696005)(47076004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 07:56:16.9326 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3288aaa-f0c2-4622-efb1-08d87596ca22
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1899
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
Cc: Long Gang <Gang.Long@amd.com>, Guchun
 Chen <guchun.chen@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 Tianci Yin <tianci.yin@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Flora Cui <flora.cui@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Tianci.Yin" <tianci.yin@amd.com>

The blockchain SKU has no display support, so the DCN ip
block should be disabled. Add DID/RID as display
supporting dependence, it potentially disable DCN block.

Change-Id: Ia83bef1499708dfd0113fe2dbb3eb4143452c1cd
Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 20 +++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c     |  2 +-
 4 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index f8f3e375c93e..04e906386b5b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1051,7 +1051,7 @@ void amdgpu_device_indirect_wreg64(struct amdgpu_device *adev,
 				   u32 pcie_index, u32 pcie_data,
 				   u32 reg_addr, u64 reg_data);
 
-bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type);
+bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type, struct pci_dev *pdev);
 bool amdgpu_device_has_dc_support(struct amdgpu_device *adev);
 
 int emu_soc_asic_init(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index c567f20b9d1f..fa522cffdd64 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2958,11 +2958,12 @@ static void amdgpu_device_detect_sriov_bios(struct amdgpu_device *adev)
  * amdgpu_device_asic_has_dc_support - determine if DC supports the asic
  *
  * @asic_type: AMD asic type
+ * @pdev: pointer of pci_dev instance
  *
  * Check if there is DC (new modesetting infrastructre) support for an asic.
  * returns true if DC has support, false if not.
  */
-bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type)
+bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type, struct pci_dev *pdev)
 {
 	switch (asic_type) {
 #if defined(CONFIG_DRM_AMD_DC)
@@ -2998,7 +2999,6 @@ bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type)
 	case CHIP_VEGA20:
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	case CHIP_RAVEN:
-	case CHIP_NAVI10:
 	case CHIP_NAVI14:
 	case CHIP_NAVI12:
 	case CHIP_RENOIR:
@@ -3011,6 +3011,20 @@ bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type)
 #endif
 		return amdgpu_dc != 0;
 #endif
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+	case CHIP_NAVI10:
+		if (pdev->device == 0x731E &&
+		    (pdev->revision == 0xC6 ||
+		     pdev->revision == 0xC7)) {
+			DRM_INFO("(%s 0x%04X:0x%04X 0x%04X:0x%04X 0x%02X) has no dc support.\n",
+				 amdgpu_asic_name[asic_type], pdev->vendor, pdev->device,
+				 pdev->subsystem_vendor, pdev->subsystem_device, pdev->revision);
+			return false;
+		} else {
+			return amdgpu_dc != 0;
+		}
+#endif
+
 	default:
 		if (amdgpu_dc > 0)
 			DRM_INFO("Display Core has been requested via kernel parameter "
@@ -3031,7 +3045,7 @@ bool amdgpu_device_has_dc_support(struct amdgpu_device *adev)
 	if (amdgpu_sriov_vf(adev) || adev->enable_virtual_display)
 		return false;
 
-	return amdgpu_device_asic_has_dc_support(adev->asic_type);
+	return amdgpu_device_asic_has_dc_support(adev->asic_type, adev->pdev);
 }
 
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 9e92d2a070ac..97014458d7de 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -516,7 +516,7 @@ uint32_t amdgpu_display_supported_domains(struct amdgpu_device *adev,
 	 */
 	if ((bo_flags & AMDGPU_GEM_CREATE_CPU_GTT_USWC) &&
 	    amdgpu_bo_support_uswc(bo_flags) &&
-	    amdgpu_device_asic_has_dc_support(adev->asic_type)) {
+	    amdgpu_device_asic_has_dc_support(adev->asic_type, adev->pdev)) {
 		switch (adev->asic_type) {
 		case CHIP_CARRIZO:
 		case CHIP_STONEY:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 13723914fa9f..97fda825e0d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1109,7 +1109,7 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 	bool supports_atomic = false;
 
 	if (!amdgpu_virtual_display &&
-	    amdgpu_device_asic_has_dc_support(flags & AMD_ASIC_MASK))
+	    amdgpu_device_asic_has_dc_support(flags & AMD_ASIC_MASK, pdev))
 		supports_atomic = true;
 
 	if ((flags & AMD_EXP_HW_SUPPORT) && !amdgpu_exp_hw_support) {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
