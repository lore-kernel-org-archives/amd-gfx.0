Return-Path: <SRS0=e3IM=OZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C59C4332F
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 11:59:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFB686138F
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 11:59:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CFB686138F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DE616EB6C;
	Tue,  5 Oct 2021 11:59:15 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FE4C6EB6C
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Oct 2021 11:59:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lsh5FkLrYEMfb2UCH1XnBwkth8q3upHDiy2pBtj8lVc4shAN1sN3BasEYTsJuw+5V1kGGG5+wm59jQky+Ubx7hVOEVZFvFOQpzsbFiW6+R/Bc/WPADX3Ie+6hEr09KhzFzcSN9OyK+haSR1fmn4HZ5dmOjYJReE2BZmDm/Wn8oIwhtAPCdKM2+DoW666J03Ns6eLk7HeH510DXpKBRQ3l60QAAkNfwx8xnFnFy9Yd0oj02DUdVFzeogsXLmndQWLGLBpcgPz2XjgL/4UFMmd0Np4Cu6wd40OVOoBmDkC1CRPE3tEs70v1B9TjCsPZYYMBG3Fsf9am6NarCEk3Lc9qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iJaLMncb/lJu+2tA8Ft8iHvHOhL5VFAFTh3o1rx9hoI=;
 b=BpwjNhJpD3PFmKoTwF4n0cBIRFBfGBgO73nVYPs6GZoFSt/Jt8rh1ld2rCNNNhY/sg8kQiQ/IFe90wS2DCdPauuZFGZ9aOtHH2bOxN/cNnf/5ClRT04qEVYkm+cBxwzjLiKhM6grDdOEJw62NreaN4fwNIDnfi6fbs1AQkG0Hw19SO8MJL1lguX74TCg+r04rF7gtJA2WIdK+pXRJ+7hZDvUx2XKqlU7IGzCeh+ySY7d8BpDo6SuYaPRF6oZ6CZAFrLTOwKia8IN80XWshyE7VdbEf4rK5dicTmhe43jZtT9Q9Tg4quJM2snZ41f4v5kmXwzhRR+BPQ+znFT8HUyyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJaLMncb/lJu+2tA8Ft8iHvHOhL5VFAFTh3o1rx9hoI=;
 b=KWj8Epe4BAjrUB7w6Z7Ot4gJN+rFqCWMz788XyidCl0JrsQCvHZ/nBuQWwH16kvmQaVBToOlTpNxyEMqiNExbTRI0Ny7j4TpDPuKZT+3YRo6XDqLb3+Cr8K/kXO/E3BYNBvBmXbtcYVjhU5CkblGDUh3xRmkLgJIS+tiXiAXwQA=
Received: from MWHPR1201CA0005.namprd12.prod.outlook.com
 (2603:10b6:301:4a::15) by DM6PR12MB4468.namprd12.prod.outlook.com
 (2603:10b6:5:2ac::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Tue, 5 Oct
 2021 11:59:12 +0000
Received: from CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4a:cafe::97) by MWHPR1201CA0005.outlook.office365.com
 (2603:10b6:301:4a::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend
 Transport; Tue, 5 Oct 2021 11:59:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT067.mail.protection.outlook.com (10.13.174.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Tue, 5 Oct 2021 11:59:11 +0000
Received: from brihaspati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 5 Oct 2021
 06:59:09 -0500
From: Nirmoy Das <nirmoy.das@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Christian.Koenig@amd.com>, <shashank.sharma@amd.com>, Nirmoy Das
 <nirmoy.das@amd.com>
Subject: [PATCH 1/1] drm/amdgpu: init debugfs drm driver callback
Date: Tue, 5 Oct 2021 13:58:56 +0200
Message-ID: <20211005115856.59649-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb13196b-7c30-47a3-aa65-08d987f78bb0
X-MS-TrafficTypeDiagnostic: DM6PR12MB4468:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4468597785C26FFB76FA7F178BAF9@DM6PR12MB4468.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:104;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ij3adN2TRrkT8zkNXX+orvogtkhNJsgATNO0eFqQ9QE3XgVZnP1xKcmEPF9q68dtTUi8C7yzovDBI1KnhUU+yljnGnMk0UKcqQkdcXfbnUWanPxiTlsox4KrnAE47J2JJEM6kKK8ifrNHFH+Nwgy2kz0GRWZ1OYMceJP+UNmopNVHU5xA9r7fSioZxZ5PeNQLg8mp76REiWBIyVdYfRDOr3wpj26HmeHOMs8PbjY02BLTdmdNRIyn1sqcq2WXWS96XeLPkXau/3sAnZbKxATZXzkOJ8DBorml1W3w/919bRT625lmtWRvd35ChWS8ZWLxJwNoHcDmWZcNrZWQWqzanatzTKqv5pszylNiJCSA/Ox28H/NmFMZCzbgjgcW//ztG91w5Q58ZhAZQtkvCZNT6q7il99q148JL+hieIGi2Tp3RW53RCmOB41+q3lOnOgnZTaHIRLCaK+FnY+6+2yjsOejhHIbWCDQSRaeGbCawvNFPlsIJc4YZSCQkzxr1nEpAyyojjfZxvWABsfYeZGFuNkASEXaCrA81lND58elxO21f5/Wwy1qy6kRAWzxPvxGCwZHb/LSUJBmSYqHS+LSPXHfNYDiaJNMoSfTQyLIwbA1OwfmEqxT/jKFrV7SGtHf30zrOIIf8+I8uFaWIyiDvjT+Y0/Az0JCF4PjzkjXVUdsRqFsx7zThtnUPkZSArgXLtxgly1UyxHtjMUxROQG3tHfNp8xLRrnjwSQyJAiTg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(70206006)(36860700001)(82310400003)(356005)(81166007)(70586007)(86362001)(2906002)(316002)(8936002)(5660300002)(336012)(426003)(1076003)(6666004)(508600001)(44832011)(47076005)(16526019)(83380400001)(54906003)(8676002)(2616005)(6916009)(26005)(4326008)(36756003)(7696005)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 11:59:11.8501 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb13196b-7c30-47a3-aa65-08d987f78bb0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4468
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

drm_dev_register() will try to init driver's debugfs using
drm_driver.debugfs_init call back function. Use that callback
also for amdgpu to intialize debugfs.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 10 +++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c     |  7 +++----
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 6611b3c7c149..3076742f8f85 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1611,8 +1611,9 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
 DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
 			amdgpu_debugfs_sclk_set, "%llu\n");
 
-int amdgpu_debugfs_init(struct amdgpu_device *adev)
+void amdgpu_debugfs_init(struct drm_minor *minor)
 {
+	struct amdgpu_device *adev = drm_to_adev(minor->dev);
 	struct dentry *root = adev_to_drm(adev)->primary->debugfs_root;
 	struct dentry *ent;
 	int r, i;
@@ -1621,14 +1622,14 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 				  &fops_ib_preempt);
 	if (IS_ERR(ent)) {
 		DRM_ERROR("unable to create amdgpu_preempt_ib debugsfs file\n");
-		return PTR_ERR(ent);
+		return;
 	}
 
 	ent = debugfs_create_file("amdgpu_force_sclk", 0200, root, adev,
 				  &fops_sclk_set);
 	if (IS_ERR(ent)) {
 		DRM_ERROR("unable to create amdgpu_set_sclk debugsfs file\n");
-		return PTR_ERR(ent);
+		return;
 	}
 
 	/* Register debugfs entries for amdgpu_ttm */
@@ -1682,11 +1683,10 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 	debugfs_create_blob("amdgpu_discovery", 0444, root,
 			    &adev->debugfs_discovery_blob);
 
-	return 0;
 }
 
 #else
-int amdgpu_debugfs_init(struct amdgpu_device *adev)
+void amdgpu_debugfs_init(struct drm_minor *minor)
 {
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
index 371a6f0deb29..06b68e16e35d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
@@ -27,7 +27,7 @@
  */
 
 int amdgpu_debugfs_regs_init(struct amdgpu_device *adev);
-int amdgpu_debugfs_init(struct amdgpu_device *adev);
+void amdgpu_debugfs_init(struct drm_minor *minor);
 void amdgpu_debugfs_fini(struct amdgpu_device *adev);
 void amdgpu_debugfs_fence_init(struct amdgpu_device *adev);
 void amdgpu_debugfs_firmware_init(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index df83b1f438b6..ceda650895db 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2012,10 +2012,6 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 			drm_fbdev_generic_setup(adev_to_drm(adev), 32);
 	}
 
-	ret = amdgpu_debugfs_init(adev);
-	if (ret)
-		DRM_ERROR("Creating debugfs files failed (%d).\n", ret);
-
 	return 0;
 
 err_pci:
@@ -2479,6 +2475,9 @@ static const struct drm_driver amdgpu_kms_driver = {
 	.dumb_map_offset = amdgpu_mode_dumb_mmap,
 	.fops = &amdgpu_driver_kms_fops,
 	.release = &amdgpu_driver_release_kms,
+#if defined(CONFIG_DEBUG_FS)
+	.debugfs_init = amdgpu_debugfs_init,
+#endif
 
 	.prime_handle_to_fd = drm_gem_prime_handle_to_fd,
 	.prime_fd_to_handle = drm_gem_prime_fd_to_handle,
-- 
2.32.0

