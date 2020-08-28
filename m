Return-Path: <SRS0=kQKQ=CG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF31C433E2
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2020 16:06:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03207207DF
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2020 16:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bPnBFWl2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03207207DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5EB46E4F8;
	Fri, 28 Aug 2020 16:06:09 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 938CA6E4F8
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2020 16:06:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C+iHmi2STEaxgPaPiKAJ11vAeCYgdxfX/Ah4qBjFZoIXh8lzesEj/hSbYN85igcwcFjAA0QyADYHHfBYI9KlhOwHvdmHRxY2iY/RhAnUrvJt5wWKrqsU+tYgAcMZYyv/k6ErdJaso6aCTfZkz9TBVE00B4bVsejQRkj621oLlXwNWNDs6yCexdK+nEqwiw+rOWanwKK8cXirMKK7iuoHPIEC0EdNXEACaerP/sNlr7DfT1nGrUlh35l+jy9J763sptoA0M9Bg6009vElM+N2T87PVNErdYWFBW0UZ2CKnn9BqnukxVtX1g6b/ukgTx6+Y8bya8TT/F25dqMCv+8kkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OiWQCf2DX2LVBDSLjIRhY5TjaRT+gVtfuVMu9biOVSQ=;
 b=HUmIVD9+6jr70d/yCg4yB3Tq1VOgK5zVpwK2wzcWa3gnaEBCJY24ncMzYnce5tMJgNj1D6AOXY5FISPpWS61MglKyc7htY81HScVxRJ3pE5NEZ/ywEGM7p5sExrmMbuWdFPrER66iKDKrKnFvZtrjh1AmWMaiF2OC88oPf8kbrxaBd/rmYexNNPfdhHva2zhmHorjnLCnXAtPztjySr/Ww1WTD3oiDe3J7GOt1OGfNAH2lImMyrlNmIOKgsV+lsHWb8YFZ9tkjmu2oMggCjg1BmMeFyG42xK8LV8CuskvWt4JzIU4gWyChpxUgjN+yjGi7W/fria9chlG5P5JkbwKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OiWQCf2DX2LVBDSLjIRhY5TjaRT+gVtfuVMu9biOVSQ=;
 b=bPnBFWl2za2/hmRa6ZxLVSldj/JwHMh0YaeHHp997hlfJgA22BaKWKkQ1txjjcuMnlsqhzXbQEg7Y4TJiQ035f6Wtx+4IKH4xJ3ZSB1UX4WKzqKcWw8yb90Y0ksK6t9WvKG4Uzq0QpJJwLU7bO7SPswuEeOYWaTKbRinghvoqe0=
Received: from MWHPR18CA0025.namprd18.prod.outlook.com (2603:10b6:320:31::11)
 by DM6PR12MB4204.namprd12.prod.outlook.com (2603:10b6:5:212::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.21; Fri, 28 Aug
 2020 16:06:03 +0000
Received: from CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:320:31:cafe::94) by MWHPR18CA0025.outlook.office365.com
 (2603:10b6:320:31::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Fri, 28 Aug 2020 16:06:03 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT016.mail.protection.outlook.com (10.13.175.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3326.19 via Frontend Transport; Fri, 28 Aug 2020 16:06:03 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 28 Aug
 2020 11:05:59 -0500
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 28 Aug 2020 11:05:58 -0500
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 6/7] drm/amdgpu: Trim amdgpu_pci_slot_reset by reusing code.
Date: Fri, 28 Aug 2020 12:05:42 -0400
Message-ID: <1598630743-21155-7-git-send-email-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598630743-21155-1-git-send-email-andrey.grodzovsky@amd.com>
References: <1598630743-21155-1-git-send-email-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f82fa46a-ef8b-4423-851e-08d84b6c4381
X-MS-TrafficTypeDiagnostic: DM6PR12MB4204:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4204499FC3347CDAE25F69D4EA520@DM6PR12MB4204.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 53lAQQ+Y2eKak4r4qwCIDLJKRWq2Za2UxDqVZf/Phu/+H+EiXwsQI9eg4SmLP6AD3TRDw23Z8wq/JkLbHMWnelBiuwT03WjEWZ2SwpcS6GkghwDXHdVC8oU/MpRZoCVw1i72BLqfJGfO3fRyFgd+jrwEw3gZeZF7EB8OrNXSOConEBeNBsWRGbHKQI7mOx3Q+hkrlWpI28OIDhVw02Qvpj8/2wcq4mslkucdYMA+4tDSF9W9+mjdRV816i91ijwD0crF8xHaP75IEa77Q+eI+pzUwS6aLTm5Np/s+UN/gk/hUBBtbvqrEs3NwEyFarmlk4xZ15DiiWlEmx1DcuXw4TnWE+iVc77XZafSZvXi4Vlv0Sst268cVjF9cwXROM8DAbNqRyexPbqd4doUYjmYwA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(39860400002)(396003)(46966005)(8676002)(356005)(44832011)(81166007)(7696005)(316002)(4326008)(82310400002)(70586007)(83380400001)(186003)(70206006)(8936002)(426003)(86362001)(478600001)(26005)(47076004)(6916009)(2906002)(82740400003)(336012)(36756003)(2616005)(5660300002)(6666004)(54906003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2020 16:06:03.2458 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f82fa46a-ef8b-4423-851e-08d84b6c4381
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4204
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
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 75 ++++++------------------------
 1 file changed, 14 insertions(+), 61 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 7f1b970..429167b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4115,7 +4115,8 @@ static int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 
 static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
 			       struct list_head *device_list_handle,
-			       bool *need_full_reset_arg)
+			       bool *need_full_reset_arg,
+			       bool skip_hw_reset)
 {
 	struct amdgpu_device *tmp_adev = NULL;
 	bool need_full_reset = *need_full_reset_arg, vram_lost = false;
@@ -4125,7 +4126,7 @@ static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
 	 * ASIC reset has to be done on all HGMI hive nodes ASAP
 	 * to allow proper links negotiation in FW (within 1 sec)
 	 */
-	if (need_full_reset) {
+	if (!skip_hw_reset && need_full_reset) {
 		list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
 			/* For XGMI run all resets in parallel to speed up the process */
 			if (tmp_adev->gmc.xgmi.num_physical_nodes > 1) {
@@ -4521,7 +4522,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		if (r)
 			adev->asic_reset_res = r;
 	} else {
-		r  = amdgpu_do_asic_reset(hive, device_list_handle, &need_full_reset);
+		r  = amdgpu_do_asic_reset(hive, device_list_handle, &need_full_reset, false);
 		if (r && r == -EAGAIN)
 			goto retry;
 	}
@@ -4850,14 +4851,19 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
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
@@ -4873,70 +4879,15 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
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
 		amdgpu_device_cache_pci_state(adev->pdev);
 		DRM_INFO("PCIe error recovery succeeded\n");
@@ -5022,4 +4973,6 @@ bool amdgpu_device_load_pci_state(struct pci_dev *pdev)
 		DRM_WARN("Failed to load PCI state, err:%d\n", r);
 		return false;
 	}
+
+	return true;
 }
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
