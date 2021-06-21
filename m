Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69268C49361
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 07:01:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C5696109E
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 07:01:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C5696109E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6BDC89C97;
	Mon, 21 Jun 2021 07:01:03 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EF7A89C97
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 07:01:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xu7mGbu9GLz2d6N9Oh2lcfm1RbK6EcxoY2imXJkm5n5gs1bR+4I5WwrTu2SceH2kRoeVKNXtNHT7MhGRHljz5W9QxRB33MbGl8wmJOq8zLYxT75/LQ+SrklfUFTrS1O0YPeZG3bxa3/JOqv7yvC71JpfHiffTJDPeL3J5pqb7D0Ctk7TwlDlgg5QOvpO+L3F93RzcT7OYmui2Hhbxk8lfH3h/gm+qoxIpecwsj6y6zRjilaELs0zdY1r8uM9tdwmhhvW2DrCvLe5LQOlXMRGy4Lp6RxqpwjNcibCOsS40+QZpz4pD2pMuPskKN/n9nQDXKLWCgv2QQQkZVHjSUf9Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xhoj06bICdwYFuINWwLveX3MDd9VddyJKHubBUSkFb4=;
 b=ZfHaf3frxlbk5Uw78EF22dV52m85xWc+6HjpbjQY+6a/4wz5ArLsDAUA8T2k4D8ArTPX237v3tQkhDBjzrZFKsEz1Nmg29pIDAOPnZtjD0O0CR3p2nvLb/ap12y5JTu88OXaosyTp8170P6aNa+Zc7bEODoNU8qbV0PpI4qlL0tKX/KEGpc8JGcqe0w9RW7qPyGnlWWcVbGgYDmCxFl1liKbKaw6ailTR/uMIRxfu12Nug8bsrZKAa1h0AU2TDuXmPY8Z5wm/1pCDF2p/Rn7kC9nG0fFAD8iVbNHkmj4dhET++VzPIXO1QQ03VphSZ2w/w9saCsFy657qCC2EoE2Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xhoj06bICdwYFuINWwLveX3MDd9VddyJKHubBUSkFb4=;
 b=p+oUns4WvYmyol4DIFy8aYim7+hwPFv1ErUUpM8XWmpNtu26XwLVS95DUiwHyEr2uTxYTvC/ZKdRiKg2ah/WUwOo1jDDLPPUChiPCRrMbrqy2wlyLERC8+b8FIkKN1b1XwbIUfbKgBpaW5PdvvWY5a5Z5VllGmmKYi8VXZLuQxg=
Received: from DM5PR1401CA0016.namprd14.prod.outlook.com (2603:10b6:4:4a::26)
 by DM4PR12MB5101.namprd12.prod.outlook.com (2603:10b6:5:390::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Mon, 21 Jun
 2021 07:00:59 +0000
Received: from DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4a:cafe::4b) by DM5PR1401CA0016.outlook.office365.com
 (2603:10b6:4:4a::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend
 Transport; Mon, 21 Jun 2021 07:00:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT067.mail.protection.outlook.com (10.13.172.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4242.16 via Frontend Transport; Mon, 21 Jun 2021 07:00:59 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 21 Jun
 2021 02:00:57 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 1/7] drm/amdgpu: correct tcp harvest setting
Date: Mon, 21 Jun 2021 15:00:34 +0800
Message-ID: <20210621070040.494336-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 912e0d4f-7733-4115-da9f-08d934825331
X-MS-TrafficTypeDiagnostic: DM4PR12MB5101:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5101EF18E0424C9270AA1757E40A9@DM4PR12MB5101.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7uwCBQn5y8QaWXQbP28/3aFiDFrA81pBJt8XTVLmYdp0MtIlTySvL8ps7jpM9nqPIQtwF4WY33ejnzRR+tyopIMS6cl1Vm8C63y5y/sBcSKFvGYUwrtCEluIpwyhpdVfqi3dKcMA3aw1k1/kVQHLZG99FoZUVcVFwpEgtrILWNzYtGEwlD0IYUd4I/UOs+XzjumUTSlLii3ozcdheVCMUtwu4TdshRfPClXSbCH1pwTSQ2Y8iBAZS2hDSoAZlmGmrK+tIia5qLghEg1Z8TsYJyKNSazSRyOlwGYr/skfqjRNF5T28GOseZ/aQOAYCMdGKuA8xe0z6EXvEZDq1egyQWgDQcFpy10A+T/5aWW4MyTJn6goOhP4jDpPcVGpe0cR47J1mWdqwCFMeForZ4BPB2bavZeuXdmxDNf0Pt1VQkR4y7BvcKgSqmvCtTxxVtmVnzz8OWsopQ/+HQclF27TM1aoB7xJcqxtLL9oPZEsdmrkvoWJrP8XVaDDZ3olyp2LQDFHC/1dFSZgf9iS3aGXcDHrthlmR98Jo+ddt+ILY5h/0kGzlnepX33Fl+Ob2bPVohSH9qFBu2lHQHql4UMHjvHcq/oYJaAliZ3VX7sbDn79nr58kIpowjWPpw1Rnf6bZwq0iUnNAm9Aj5+HAl2ObFz2hVvrYEI6EFFUVQWmdWJgckbJQOlLYu41sOPi1YT/
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(396003)(39860400002)(346002)(136003)(46966006)(36840700001)(44832011)(4326008)(6916009)(186003)(83380400001)(26005)(316002)(7696005)(6666004)(16526019)(478600001)(86362001)(70206006)(70586007)(2616005)(1076003)(81166007)(356005)(54906003)(336012)(36756003)(426003)(2906002)(82310400003)(8936002)(5660300002)(8676002)(36860700001)(47076005)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 07:00:59.4705 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 912e0d4f-7733-4115-da9f-08d934825331
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5101
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
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com,
 Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add missing settings for SQC bits. And correct some confusing logics
around active wgp bitmap calculation.

Change-Id: If4992e175fd61d5609b00328cbe21f487517d039
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
V1->V2:
  - restore correct tcp_harvest setting for NV10 and NV12
  - move asic type guard upper layer for better readability
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 103 ++++++++++++++-----------
 1 file changed, 57 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 15ae9e33b925..384b95fbad8b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -5090,47 +5090,50 @@ static void gfx_v10_0_tcp_harvest(struct amdgpu_device *adev)
 		4 + /* RMI */
 		1); /* SQG */
 
-	if (adev->asic_type == CHIP_NAVI10 ||
-	    adev->asic_type == CHIP_NAVI14 ||
-	    adev->asic_type == CHIP_NAVI12) {
-		mutex_lock(&adev->grbm_idx_mutex);
-		for (i = 0; i < adev->gfx.config.max_shader_engines; i++) {
-			for (j = 0; j < adev->gfx.config.max_sh_per_se; j++) {
-				gfx_v10_0_select_se_sh(adev, i, j, 0xffffffff);
-				wgp_active_bitmap = gfx_v10_0_get_wgp_active_bitmap_per_sh(adev);
-				/*
-				 * Set corresponding TCP bits for the inactive WGPs in
-				 * GCRD_SA_TARGETS_DISABLE
-				 */
-				gcrd_targets_disable_tcp = 0;
-				/* Set TCP & SQC bits in UTCL1_UTCL0_INVREQ_DISABLE */
-				utcl_invreq_disable = 0;
-
-				for (k = 0; k < max_wgp_per_sh; k++) {
-					if (!(wgp_active_bitmap & (1 << k))) {
-						gcrd_targets_disable_tcp |= 3 << (2 * k);
-						utcl_invreq_disable |= (3 << (2 * k)) |
-							(3 << (2 * (max_wgp_per_sh + k)));
-					}
+	mutex_lock(&adev->grbm_idx_mutex);
+	for (i = 0; i < adev->gfx.config.max_shader_engines; i++) {
+		for (j = 0; j < adev->gfx.config.max_sh_per_se; j++) {
+			gfx_v10_0_select_se_sh(adev, i, j, 0xffffffff);
+			wgp_active_bitmap = gfx_v10_0_get_wgp_active_bitmap_per_sh(adev);
+			/*
+			 * Set corresponding TCP bits for the inactive WGPs in
+			 * GCRD_SA_TARGETS_DISABLE
+			 */
+			gcrd_targets_disable_tcp = 0;
+			/* Set TCP & SQC bits in UTCL1_UTCL0_INVREQ_DISABLE */
+			utcl_invreq_disable = 0;
+
+			for (k = 0; k < max_wgp_per_sh; k++) {
+				if (!(wgp_active_bitmap & (1 << k))) {
+					gcrd_targets_disable_tcp |= 3 << (2 * k);
+					gcrd_targets_disable_tcp |= 1 << (k + (max_wgp_per_sh * 2));
+					utcl_invreq_disable |= (3 << (2 * k)) |
+						(3 << (2 * (max_wgp_per_sh + k)));
 				}
-
-				tmp = RREG32_SOC15(GC, 0, mmUTCL1_UTCL0_INVREQ_DISABLE);
-				/* only override TCP & SQC bits */
-				tmp &= 0xffffffff << (4 * max_wgp_per_sh);
-				tmp |= (utcl_invreq_disable & utcl_invreq_disable_mask);
-				WREG32_SOC15(GC, 0, mmUTCL1_UTCL0_INVREQ_DISABLE, tmp);
-
-				tmp = RREG32_SOC15(GC, 0, mmGCRD_SA_TARGETS_DISABLE);
-				/* only override TCP bits */
-				tmp &= 0xffffffff << (2 * max_wgp_per_sh);
-				tmp |= (gcrd_targets_disable_tcp & gcrd_targets_disable_mask);
-				WREG32_SOC15(GC, 0, mmGCRD_SA_TARGETS_DISABLE, tmp);
 			}
-		}
 
-		gfx_v10_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
-		mutex_unlock(&adev->grbm_idx_mutex);
+			tmp = RREG32_SOC15(GC, 0, mmUTCL1_UTCL0_INVREQ_DISABLE);
+			/* only override TCP & SQC bits */
+			if (adev->asic_type == CHIP_NAVI14)
+				tmp &= 0xff000000;
+			else
+				tmp &=0xfff00000;
+			tmp |= (utcl_invreq_disable & utcl_invreq_disable_mask);
+			WREG32_SOC15(GC, 0, mmUTCL1_UTCL0_INVREQ_DISABLE, tmp);
+
+			tmp = RREG32_SOC15(GC, 0, mmGCRD_SA_TARGETS_DISABLE);
+			/* only override TCP & SQC bits */
+			if (adev->asic_type == CHIP_NAVI14)
+				tmp &= 0xfffc0000;
+			else
+				tmp &= 0xffff8000;
+			tmp |= (gcrd_targets_disable_tcp & gcrd_targets_disable_mask);
+			WREG32_SOC15(GC, 0, mmGCRD_SA_TARGETS_DISABLE, tmp);
+		}
 	}
+
+	gfx_v10_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
+	mutex_unlock(&adev->grbm_idx_mutex);
 }
 
 static void gfx_v10_0_get_tcc_info(struct amdgpu_device *adev)
@@ -7408,7 +7411,10 @@ static int gfx_v10_0_hw_init(void *handle)
 	 * init golden registers and rlc resume may override some registers,
 	 * reconfig them here
 	 */
-	gfx_v10_0_tcp_harvest(adev);
+	if (adev->asic_type == CHIP_NAVI10 ||
+	    adev->asic_type == CHIP_NAVI14 ||
+	    adev->asic_type == CHIP_NAVI12)
+		gfx_v10_0_tcp_harvest(adev);
 
 	r = gfx_v10_0_cp_resume(adev);
 	if (r)
@@ -9328,17 +9334,22 @@ static void gfx_v10_0_set_user_wgp_inactive_bitmap_per_sh(struct amdgpu_device *
 
 static u32 gfx_v10_0_get_wgp_active_bitmap_per_sh(struct amdgpu_device *adev)
 {
-	u32 data, wgp_bitmask;
-	data = RREG32_SOC15(GC, 0, mmCC_GC_SHADER_ARRAY_CONFIG);
-	data |= RREG32_SOC15(GC, 0, mmGC_USER_SHADER_ARRAY_CONFIG);
+	u32 disabled_mask =
+		~amdgpu_gfx_create_bitmask(adev->gfx.config.max_cu_per_sh >> 1);
+	u32 efuse_setting = 0;
+	u32 vbios_setting = 0;
+
+	efuse_setting = RREG32_SOC15(GC, 0, mmCC_GC_SHADER_ARRAY_CONFIG);
+	efuse_setting &= CC_GC_SHADER_ARRAY_CONFIG__INACTIVE_WGPS_MASK;
+	efuse_setting >>= CC_GC_SHADER_ARRAY_CONFIG__INACTIVE_WGPS__SHIFT;
 
-	data &= CC_GC_SHADER_ARRAY_CONFIG__INACTIVE_WGPS_MASK;
-	data >>= CC_GC_SHADER_ARRAY_CONFIG__INACTIVE_WGPS__SHIFT;
+	vbios_setting = RREG32_SOC15(GC, 0, mmGC_USER_SHADER_ARRAY_CONFIG);
+	vbios_setting &= GC_USER_SHADER_ARRAY_CONFIG__INACTIVE_WGPS_MASK;
+	vbios_setting >>= GC_USER_SHADER_ARRAY_CONFIG__INACTIVE_WGPS__SHIFT;
 
-	wgp_bitmask =
-		amdgpu_gfx_create_bitmask(adev->gfx.config.max_cu_per_sh >> 1);
+	disabled_mask |= efuse_setting | vbios_setting;
 
-	return (~data) & wgp_bitmask;
+	return (~disabled_mask);
 }
 
 static u32 gfx_v10_0_get_cu_active_bitmap_per_sh(struct amdgpu_device *adev)
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
