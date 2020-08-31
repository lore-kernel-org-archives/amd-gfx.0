Return-Path: <SRS0=7vr2=CJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DFC0C433E6
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2020 15:51:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49A4B20719
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2020 15:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HpnSQsOE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49A4B20719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3B786E3A4;
	Mon, 31 Aug 2020 15:51:16 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7691789B01
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2020 15:51:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ey6EqTjVGgN3tSrgFGxaNgjOxJaVFOa4J6m85JSatFdyA1B9AVzIlTMRSXNVXfHGud0bxwVHLFT3TY3YW/zMsP7oLaDtfI8uXdfR9rj0j6f7WlVuDgjevowWwLHdMC4GhVHDErf1Cu+7U8eIzA9F8sqsoGSsOEB2XxXd5ORDWPzC5ucO7CRMUlOnY+JUxgENu8K+GJi1aH5DbWTPucEC5jVC5zWzHjwLZ9HZm4F3HI/0jDyIBc8cZS2YxmKIPhEUsXbtJjXuQbrJh7nkt2/Avtf2GhLsGA/WVfMWfVIlbOxvX13zTG16CMEJY9fdu8j/3AzwxgkLQEri8weDbestTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=urBpwbzkpiW2CXki+9pjy0vlmTD0Z8Cg7CcjiAGurCQ=;
 b=H/C+w6mfUEzu788eGAQLlKI/D+mIQVazt+3a3Lzz+pah96A4XGd5RKMT+KF6QkHP4d7z8vhgL2U1EmLp14U3ki2t8FXaMzx3BQErRir7BvHHqxWxEuUGGjFIn4UR4Hu7r//zwZKOBz3cygDMSe7w4mxfq42oTxh13xZxwEJ7WEGm+KYCsD0E8bKTGJckzZarMIOAE8CS/vyhKniI06PICDmHIWFrsn5yTJV/aLhltxquGlXtkqzgzunChNy5N3MJ8fRs1naHJgk5MzhGju+flIhWYjVPNSIrbT5acUWYu/3PUIOpqfgsnQNRYErJLdvfAKHNDQbVgYtGcZEPuVZarg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=urBpwbzkpiW2CXki+9pjy0vlmTD0Z8Cg7CcjiAGurCQ=;
 b=HpnSQsOEYkOfrqskgqlDRDqfsLp6IW6q9sG+u+lhBtCk4RIcAgMtQd2H2TwF7C6Sf+8FcOLkECr159b8fKR6DFmLvEEEhbwcw070kgmhhgvl5cjEyyw7WsReFjot/4FYxRSuyAGnvFy/DF2XQBziH6622yn1P9A64l9toJl5uo0=
Received: from DM5PR07CA0149.namprd07.prod.outlook.com (2603:10b6:3:ee::15) by
 BN8PR12MB3092.namprd12.prod.outlook.com (2603:10b6:408:48::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.25; Mon, 31 Aug 2020 15:51:04 +0000
Received: from DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ee:cafe::11) by DM5PR07CA0149.outlook.office365.com
 (2603:10b6:3:ee::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Mon, 31 Aug 2020 15:51:04 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT062.mail.protection.outlook.com (10.13.173.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3326.19 via Frontend Transport; Mon, 31 Aug 2020 15:51:03 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 31 Aug
 2020 10:51:02 -0500
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Mon, 31 Aug 2020 10:51:02 -0500
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 6/8] drm/amdgpu: Trim amdgpu_pci_slot_reset by reusing code.
Date: Mon, 31 Aug 2020 11:50:47 -0400
Message-ID: <1598889049-28321-7-git-send-email-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598889049-28321-1-git-send-email-andrey.grodzovsky@amd.com>
References: <1598889049-28321-1-git-send-email-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5f4365e-fd58-48a7-9931-08d84dc5aaaa
X-MS-TrafficTypeDiagnostic: BN8PR12MB3092:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3092DD6DAB0C1758764F1113EA510@BN8PR12MB3092.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LFnXCT/VfXXghq3SMUaoQ0bu2Q9zERmo20UIylIlBSUjIL59csI/z9MXwDXMiCQW6VqQZoa3oVHeXjIaJVpDhfR9G7w8GAgKWHwba/alO7Is3jmHRD0FDddezDR1WldMjsxtcAsBQxpSI4WzgsDLlD8zXG/jUmJd6ul3NBUk1tgafC3z2jjfuinxeaPfTDm5AauM4xbEDnBOGOaZmhcEF1rr8Ukv5+L5p9xlOf8qQm8v+gQUQVWSaVa38nvrrFlqR4kaYwK8NAgFaJIYWdxTbyxu2rC4qycEGqyXxgyRAzSUVsoLdxo9tJ+FsrZwYKjL/oHgueN8jl6QxcnypjluXX9gdAsUsE/ed8SEeJIpSgMCDGkKCgYPzDyg32gU1M1vCIMd7pPdRJKiZEF4+MwRLQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(396003)(136003)(46966005)(8936002)(83380400001)(82740400003)(82310400002)(8676002)(6916009)(5660300002)(6666004)(316002)(186003)(70586007)(7696005)(54906003)(356005)(47076004)(2906002)(478600001)(336012)(2616005)(81166007)(36756003)(86362001)(426003)(4326008)(70206006)(44832011)(26005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2020 15:51:03.9168 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5f4365e-fd58-48a7-9931-08d84dc5aaaa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3092
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
Cc: alexander.deucher@amd.com, Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 nirmodas@amd.com, christian.koenig@amd.com, Dennis.Li@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reuse exsisting functions from GPU recovery to avoid code
duplications.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 73 +++++-------------------------
 1 file changed, 12 insertions(+), 61 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 0329b43..b31868a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4114,7 +4114,8 @@ static int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 
 static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
 			       struct list_head *device_list_handle,
-			       bool *need_full_reset_arg)
+			       bool *need_full_reset_arg,
+			       bool skip_hw_reset)
 {
 	struct amdgpu_device *tmp_adev = NULL;
 	bool need_full_reset = *need_full_reset_arg, vram_lost = false;
@@ -4124,7 +4125,7 @@ static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
 	 * ASIC reset has to be done on all HGMI hive nodes ASAP
 	 * to allow proper links negotiation in FW (within 1 sec)
 	 */
-	if (need_full_reset) {
+	if (!skip_hw_reset && need_full_reset) {
 		list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
 			/* For XGMI run all resets in parallel to speed up the process */
 			if (tmp_adev->gmc.xgmi.num_physical_nodes > 1) {
@@ -4520,7 +4521,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		if (r)
 			adev->asic_reset_res = r;
 	} else {
-		r  = amdgpu_do_asic_reset(hive, device_list_handle, &need_full_reset);
+		r  = amdgpu_do_asic_reset(hive, device_list_handle, &need_full_reset, false);
 		if (r && r == -EAGAIN)
 			goto retry;
 	}
@@ -4848,14 +4849,19 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
 	struct drm_device *dev = pci_get_drvdata(pdev);
 	struct amdgpu_device *adev = drm_to_adev(dev);
 	int r, i;
-	bool vram_lost;
+	bool need_full_reset = true;
 	u32 memsize;
+	struct list_head device_list;
 
 	DRM_INFO("PCI error: slot reset callback!!\n");
 
+	INIT_LIST_HEAD(&device_list);
+	list_add_tail(&adev->gmc.xgmi.head, &device_list);
+
 	/* wait for asic to come out of reset */
 	msleep(500);
 
+	/* Restore PCI confspace */
 	amdgpu_device_load_pci_state(pdev);
 
 	/* confirm  ASIC came out of reset */
@@ -4871,70 +4877,15 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
 		goto out;
 	}
 
-	/* TODO Call amdgpu_pre_asic_reset instead */
 	adev->in_pci_err_recovery = true;	
-	r = amdgpu_device_ip_suspend(adev);
+	r = amdgpu_device_pre_asic_reset(adev, NULL, &need_full_reset);
 	adev->in_pci_err_recovery = false;
 	if (r)
 		goto out;
 
-
-	/* post card */
-	r = amdgpu_atom_asic_init(adev->mode_info.atom_context);
-	if (r)
-		goto out;
-
-	r = amdgpu_device_ip_resume_phase1(adev);
-	if (r)
-		goto out;
-
-	vram_lost = amdgpu_device_check_vram_lost(adev);
-	if (vram_lost) {
-		DRM_INFO("VRAM is lost due to GPU reset!\n");
-		amdgpu_inc_vram_lost(adev);
-	}
-
-	r = amdgpu_gtt_mgr_recover(
-		&adev->mman.bdev.man[TTM_PL_TT]);
-	if (r)
-		goto out;
-
-	r = amdgpu_device_fw_loading(adev);
-	if (r)
-		return r;
-
-	r = amdgpu_device_ip_resume_phase2(adev);
-	if (r)
-		goto out;
-
-	if (vram_lost)
-		amdgpu_device_fill_reset_magic(adev);
-
-	/*
-	 * Add this ASIC as tracked as reset was already
-	 * complete successfully.
-	 */
-	amdgpu_register_gpu_instance(adev);
-
-	r = amdgpu_device_ip_late_init(adev);
-	if (r)
-		goto out;
-
-	amdgpu_fbdev_set_suspend(adev, 0);
-
-	/* must succeed. */
-	amdgpu_ras_resume(adev);
-
-
-	amdgpu_irq_gpu_reset_resume_helper(adev);
-	r = amdgpu_ib_ring_tests(adev);
-	if (r)
-		goto out;
-
-	r = amdgpu_device_recover_vram(adev);
+	r = amdgpu_do_asic_reset(NULL, &device_list, &need_full_reset, true);
 
 out:
-
 	if (!r) {
 		if (amdgpu_device_cache_pci_state(adev->pdev))
 			pci_restore_state(adev->pdev);
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
