Return-Path: <SRS0=g3tc=CE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 093D2C433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2020 14:46:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C23BA2078D
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2020 14:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="MmjS5VlN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C23BA2078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 573026EA9D;
	Wed, 26 Aug 2020 14:46:52 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 590166EA94
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2020 14:46:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BWCIKiG3uWEyND3lXliqXpiT6ioGMAas07ckKuM96pyWvm3bLRXlQ8YNSS8REJM4qfnfP2D8sxqlP0gfx4IJ3oNrckQSZg2mi58vIf1T2u6px83vboCsAeQ6lqnIlGDY+TGyv4fxJLWjAjzcNxMnzD/zb8YYq4W068RkvTXE2uip61ZPMzsVSDzplNE2ShPe913Ta72HZF5DyAtGR6hAoZO4u/Tb6G3cgQBZUqXgWPcM7AJE3g0dC1p1qTVXoyblT3iIkgESnd0lW52U0LLqe1SGr3ZMP8CDqQ60TIR7Mtu/l4pi70SNasi91XSfaCjwNm+F54/brZBTQ8s1VW2P1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BrG+JFrmBVoyFCDE21WiXKf5ZjTSRkKmmw2hn4SLKIY=;
 b=UXMt8HyAvlBch047ERPH5nNHj1bBsQJEltOHvCIXWLN3vVbu5JEcCINdstXRxgz1T4Q9CHjm6Vt6Tn5iuDB7PXD0J9SeohARzo2QmvCp0ZtKhoNIRLdeWSV/txxxjrfP8yu0mSpVc4LeRBKHAVPaUHjG7J6R3PXQdt9plPvQaSpOzHdQHi7LJzTMczy6I9tHqGSicppfH6Gk7dAIB/J0eRE713W93pUhQsUU3XOMxfLBOnAnshZFhF23lNetZGpcEKMf44KOijeOiYpfuDVhCdOrNGz1nslyFgsAP2+3QmE8GBzc23vFCgozUJxYnQhCzMFm5rRF9BlUMTUmTqe5OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BrG+JFrmBVoyFCDE21WiXKf5ZjTSRkKmmw2hn4SLKIY=;
 b=MmjS5VlNquowSvKf8ZsTY8PpRWiVSzdKjDGW5b6QFiE26vGr1inJro8ymaBg54rs5J9CU1MdE2FYf/uPu5HoxzPuk2idl+0/bun4yQEl6uM4SaShcYF1XA3LUbkdwzeZO3CzEhXPzkJNIffUmiyIi6+/jypR0JXo/w85HQPIkTc=
Received: from MWHPR22CA0025.namprd22.prod.outlook.com (2603:10b6:300:69::11)
 by DM6PR12MB3770.namprd12.prod.outlook.com (2603:10b6:5:1c4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Wed, 26 Aug
 2020 14:46:43 +0000
Received: from CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:69:cafe::16) by MWHPR22CA0025.outlook.office365.com
 (2603:10b6:300:69::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Wed, 26 Aug 2020 14:46:42 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT033.mail.protection.outlook.com (10.13.174.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3326.19 via Frontend Transport; Wed, 26 Aug 2020 14:46:42 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 26 Aug
 2020 09:46:38 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 26 Aug
 2020 09:46:38 -0500
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Wed, 26 Aug 2020 09:46:38 -0500
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 6/7] drm/amdgpu: Trim amdgpu_pci_slot_reset by reusing code.
Date: Wed, 26 Aug 2020 10:46:21 -0400
Message-ID: <1598453182-6946-7-git-send-email-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598453182-6946-1-git-send-email-andrey.grodzovsky@amd.com>
References: <1598453182-6946-1-git-send-email-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3ac1095-947e-4b2d-3acf-08d849ced91f
X-MS-TrafficTypeDiagnostic: DM6PR12MB3770:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3770B2C8D082CB3BF910141DEA540@DM6PR12MB3770.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QYI/qxxnUrWiKL1CMWOEMW4YI/i3JLm7Ed9s8Iqsft2HHwYhlMu9Oqmk6Sv1YD2o3AqfUkZGa56N+jMwkanSsItOY7q66ee9F+rJcMDXgcZYtXOqfnbQ+PA7hC0o/uB35rYuyg5IYAaPHWCsNQEoxbRxgKft0ayyGwYdzZIR8xe6FOZFx98HpS7IuFZV++phxbOxw3n7TP/L25OOQ0UrZZ8Fj03Skv/rxaBn4Lam4LAHWHXHXtIshr0Av22EOqjubRFrwTH4KSfiqhe8ZEc8xQ4W4zZBH/LqT9RsjiiEiQ7+jdlsD8giLmwXr5q385JMBaPypfh8acbg3NOJWt+Blj0oYkM8uqgwS9vDniYlhnVUFSi+GHE/FrqlgXIWqbF5VzzPzR5YQJVqpIBn0s6U6A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(39860400002)(396003)(46966005)(4326008)(82740400003)(7696005)(356005)(54906003)(82310400002)(36756003)(81166007)(47076004)(186003)(26005)(2906002)(478600001)(86362001)(8936002)(70586007)(70206006)(2616005)(8676002)(6916009)(336012)(426003)(6666004)(316002)(5660300002)(44832011)(83380400001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2020 14:46:42.6079 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3ac1095-947e-4b2d-3acf-08d849ced91f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3770
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
 nirmodas@amd.com
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
index 2c088df..473553f 100644
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
 	adev->in_dpc = true;
-	r = amdgpu_device_ip_suspend(adev);
+	r = amdgpu_device_pre_asic_reset(adev, NULL, &need_full_reset);
 	adev->in_dpc = false;
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
-		goto out;
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
@@ -5021,4 +4972,6 @@ bool amdgpu_device_load_pci_state(struct pci_dev *pdev)
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
