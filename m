Return-Path: <SRS0=oPsV=PA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A5FDC433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 11:58:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26DFC61076
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 11:58:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 26DFC61076
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9229B6E8FA;
	Tue, 12 Oct 2021 11:58:43 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61F666E8FA
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Oct 2021 11:58:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eTmvqVRJNy7pW3eSVgDJT9EVJJt3PaEL5Ptec38rB6iJ0ingft4eO0+MKeAxame72FAHyxsfsOl/OptMwzx4Q10WiFEZ/I6h5wcTiQR205/odpSZPsofGh0pOkwKI/n6bInjuRqaIggr/ohgBmwCl72dLytWBTCF5sNawqEDn7j11pjpfbNRJeodZeWiWPRTcOJtdRd5CRHV7FnPsF06owz994x98q9oqfeufzaTUhGrRox//NjCwuuY0P0WRXiI9gNnwVPEGS1SkLzqUspGNu2p56YEBdhQImaXwIFGAXcvmG9vuvUJaZMfsIdnH4zJsgcKkgOkUc4FoynaUfzITg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rYQ5CAyBs1MLk4ibiopOBIj+nn0pRtg556ajr8GQeSk=;
 b=LvsmsMXkJX9YWtZhOogE4FeGszhVidibUL84lbutKO6n3ZLavavWCfUQ2KdZ0/yAWMoTcPBB+WniXch0SKzcETZxuN6bedih2fZaFlHLPWOKs8XqxCm+Bi+ZYHgArCHM0Glz+cM66ffRONt1s+swQ8P8kzmK6LGCIj3u+OleDX+NfqIJ9+22WzhYe3Q841RChVAW8o3txCX5ip2pX8kewEL9dyGDQaTNa3nOaHbPYp1JGUzSISnpOSqwkfykS0pzji4lAFphTPLRCgu5ejooiTZ4A+tDa8KqUtiCvqQRMUgyRqN4RJhvX9Pax6YffOSSxfY1evqhY0cVtOH4QQX3dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rYQ5CAyBs1MLk4ibiopOBIj+nn0pRtg556ajr8GQeSk=;
 b=Klxgn0aAgfEqKqq5A/cv1ZyNjejgoqyP+EO5XYtZ80Zc4CMlcAAham6s/kUYK4xZACIs+i5uricqGh9TkL0N2gv9PGWyi8wlTnnDyFkOToVdr5G6ZPcEoFUXRTlktP/rknZUzTZYbyw57uld0VUyVz+S7bFF7+6sxTcyyotvK7E=
Received: from MWHPR01CA0026.prod.exchangelabs.com (2603:10b6:300:101::12) by
 DM5PR1201MB0236.namprd12.prod.outlook.com (2603:10b6:4:57::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.19; Tue, 12 Oct 2021 11:58:39 +0000
Received: from CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:101:cafe::87) by MWHPR01CA0026.outlook.office365.com
 (2603:10b6:300:101::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.14 via Frontend
 Transport; Tue, 12 Oct 2021 11:58:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT056.mail.protection.outlook.com (10.13.175.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Tue, 12 Oct 2021 11:58:38 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 12 Oct
 2021 06:58:38 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 12 Oct
 2021 04:58:37 -0700
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2308.8 via Frontend
 Transport; Tue, 12 Oct 2021 06:58:36 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, Stanley.Yang <Stanley.Yang@amd.com>
Subject: [PATCH Review 1/1] drm/ttm: fix debugfs node create failed
Date: Tue, 12 Oct 2021 19:58:34 +0800
Message-ID: <20211012115834.19577-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd545e67-6bf4-40f6-5715-08d98d77a0e9
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0236:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB023651D0816B62ED10C4D2109AB69@DM5PR1201MB0236.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g+X/j9VdkFki/GN63Vht95QlxsdudpuD8ZPpQagN8ULXQaZ55y1JAYYy4juIv3geIlLhs9oEVQc9NhQH3zdIhV7B+Y/2DF/4kVne5IrlEqnJ0rCfE5OPzRoufeXSQviYCqZWqCvK0QaxkvOCw5vbv92+Zk0N4316rzh40OfP5NbcUhrcxE+gb0uy6ZwhUouzrTigqr4l5wY0RbxzKLFwl1iR2IafcjwMX200hXlBoCG1qWRL7VeWFxVcvC4XeiQGJNqOvXf1z5ihOVUn/TsKEH4ttXfR27j+PPLpMTErekOHY26T6TdY3vBwIErOy73NxVie6PZRiKuRiA0FOkTkDPS+txbMLAS0FgPXymxQ/LdToMSIuLUQbkAKWdRM3qp8ISvq9gfifmkNW9AHY/JDEFo6rdxbqB0uKet9hk0BnqYcuxzDOhNxg8mWxvREMaxGGmG4qtu750zs8YyGqhVFY7e1lKkDzTrmZ8GHXmvnF4wL4Fw+hIxjFqu2pOGnrxpSRd0HQ+bpdGcod0x+oXXXV51xX2p2/1IYsaPoBMkTcpiuLNgv20PZWncGeVZcVmCeGaGIEl2FiVnPY7AClM9rPzT6JdXu4Lrpz5xppYlk0/axq5EvRFdELBdImQoBhAzoSp40jpOYTtCTB6HZG41pTZ9BQyW2WewUhNgMsYWEqBndsNRID70nPsYF791Z79mBg1vW5Hk7hz93W7aj8bX78EP90uqQG9FlZL97ayvlgQs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(81166007)(70586007)(36860700001)(316002)(186003)(54906003)(356005)(26005)(2906002)(336012)(70206006)(7696005)(426003)(2616005)(4326008)(82310400003)(36756003)(86362001)(8676002)(5660300002)(508600001)(47076005)(83380400001)(8936002)(1076003)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2021 11:58:38.8258 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd545e67-6bf4-40f6-5715-08d98d77a0e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0236
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

Test scenario:
    modprobe amdgpu -> rmmod amdgpu -> modprobe amdgpu
Error log:
    [   54.396807] debugfs: File 'page_pool' in directory 'amdttm' already present!
    [   54.396833] debugfs: File 'page_pool_shrink' in directory 'amdttm' already present!
    [   54.396848] debugfs: File 'buffer_objects' in directory 'amdttm' already present!
Reason:
    page_pool, page_pool_shrink and buffer_objects can be removed when
    rmmod amdttm, in the above test scenario only rmmod amdgpu, so those
    debugfs node will not be removed, this caused file create failed.
Soultion:
    create ttm_page directory under ttm_root directory when insmod amdgpu,
    page_pool, page_pool_shrink and buffer_objects are stored in ttm_page directiry,
    remove ttm_page directory when do rmmod amdgpu, this can fix above issue.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/ttm/ttm_device.c | 12 +++++++++++-
 drivers/gpu/drm/ttm/ttm_module.c |  1 +
 drivers/gpu/drm/ttm/ttm_module.h |  1 +
 drivers/gpu/drm/ttm/ttm_pool.c   |  4 ++--
 4 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_device.c b/drivers/gpu/drm/ttm/ttm_device.c
index 1de23edbc182..ad170328f0c8 100644
--- a/drivers/gpu/drm/ttm/ttm_device.c
+++ b/drivers/gpu/drm/ttm/ttm_device.c
@@ -55,6 +55,10 @@ static void ttm_global_release(void)
 
 	ttm_pool_mgr_fini();
 
+#ifdef CONFIG_DEBUG_FS
+	debugfs_remove(ttm_debugfs_page);
+#endif
+
 	__free_page(glob->dummy_read_page);
 	memset(glob, 0, sizeof(*glob));
 out:
@@ -85,6 +89,10 @@ static int ttm_global_init(void)
 		>> PAGE_SHIFT;
 	num_dma32 = min(num_dma32, 2UL << (30 - PAGE_SHIFT));
 
+#ifdef CONFIG_DEBUG_FS
+	ttm_debugfs_page = debugfs_create_dir("ttm_page", ttm_debugfs_root);
+#endif
+
 	ttm_pool_mgr_init(num_pages);
 	ttm_tt_mgr_init(num_pages, num_dma32);
 
@@ -98,8 +106,10 @@ static int ttm_global_init(void)
 	INIT_LIST_HEAD(&glob->device_list);
 	atomic_set(&glob->bo_count, 0);
 
-	debugfs_create_atomic_t("buffer_objects", 0444, ttm_debugfs_root,
+#ifdef CONFIG_DEBUG_FS
+	debugfs_create_atomic_t("buffer_objects", 0444, ttm_debugfs_page,
 				&glob->bo_count);
+#endif
 out:
 	mutex_unlock(&ttm_global_mutex);
 	return ret;
diff --git a/drivers/gpu/drm/ttm/ttm_module.c b/drivers/gpu/drm/ttm/ttm_module.c
index 88970a6b8e32..66595e6e7087 100644
--- a/drivers/gpu/drm/ttm/ttm_module.c
+++ b/drivers/gpu/drm/ttm/ttm_module.c
@@ -38,6 +38,7 @@
 #include "ttm_module.h"
 
 struct dentry *ttm_debugfs_root;
+struct dentry *ttm_debugfs_page;
 
 static int __init ttm_init(void)
 {
diff --git a/drivers/gpu/drm/ttm/ttm_module.h b/drivers/gpu/drm/ttm/ttm_module.h
index d7cac5d4b835..6007dc66f44e 100644
--- a/drivers/gpu/drm/ttm/ttm_module.h
+++ b/drivers/gpu/drm/ttm/ttm_module.h
@@ -36,5 +36,6 @@
 struct dentry;
 
 extern struct dentry *ttm_debugfs_root;
+extern struct dentry *ttm_debugfs_page;
 
 #endif /* _TTM_MODULE_H_ */
diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index 8be7fd7161fd..ecb33daad7b5 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -709,9 +709,9 @@ int ttm_pool_mgr_init(unsigned long num_pages)
 	}
 
 #ifdef CONFIG_DEBUG_FS
-	debugfs_create_file("page_pool", 0444, ttm_debugfs_root, NULL,
+	debugfs_create_file("page_pool", 0444, ttm_debugfs_page, NULL,
 			    &ttm_pool_debugfs_globals_fops);
-	debugfs_create_file("page_pool_shrink", 0400, ttm_debugfs_root, NULL,
+	debugfs_create_file("page_pool_shrink", 0400, ttm_debugfs_page, NULL,
 			    &ttm_pool_debugfs_shrink_fops);
 #endif
 
-- 
2.17.1

