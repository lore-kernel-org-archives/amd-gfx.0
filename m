Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 850F2C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Apr 2022 08:26:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECD6610F82A;
	Thu, 28 Apr 2022 08:26:10 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA81410F82A
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Apr 2022 08:26:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KLFhLv4TDs9I1TPceRALe0zJEDxAc5oicfhxuJGzvU7wyoq2CF/lpQrkd/NzK6lhRms53eKWThDrIDRVllqRTDPgSn7vB5sNkUBX0C6v9ngRVHcZA0PdcWDrh++IeQ579OEjNz+9AwOAPfozaDffWEKhPFKnGSZH1WQWx/ch3BQtTvnOAVI/53Enbb2PAc+w701QvMVslrlIF9CEGV0bSdx8RfvXz++Ikvyx7wRL3g0Y8IdmzdS+ucdnR5pKpFo0djRdSKrSkhS7LgSHOdHV0rtYs+LwllULVISF7P++98p9EMSwCpMPnsqEVEKo0ykZs3W9GCOK2iolchM1ut0eig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wCjdQgJKRVog8BxAmLFpE9w6wCgUwQxdHXOIZQ1aHAY=;
 b=m2Ve4TdVeB2WOrt/mTwA4tmf3TcBdFzfewqprbyb6K+NgxwrU9h/3MFQebE6YG/IasuWWzlTSzXgdRGYje2VI+hGJeRtKI6QpJbu6lWAJLs6i9YjkEV/xhLj3woV9t5yyuV9nVNQuEu5o3QwXDh9O1VN+i07Am6lripR4eW5ddkhFPVu8sWMeL63kKznnlwqLOTHjEg3ncTd35MEL8sFywlmrirp/R9TTpxQaC5B5gxz/hrqnL/U215MLEaS98Uq2HndFA4XmGhesjP4J3Y42UhkDXKln6oj92y3PIVAaXm/uFoHBnP2YZxrI/dPjALoq/OHs6jT1JJx5yZqGYbo7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCjdQgJKRVog8BxAmLFpE9w6wCgUwQxdHXOIZQ1aHAY=;
 b=v2+kv0rQhZZ043vGecZg8k8XGpn/lOpeOJEwkuITciUMs1+cAyf5aYzwrg18furAT3xKSCDKOVSVTN0yyE0t1HFt/+uupJVC6ZvdDI0tqHTbHRPn1Wq8VFP67FKeqvFepukbBDf3Sf3wICFs7XhGeEeM1Pbsd0zY/HoOs4eUpqo=
Received: from BN9PR03CA0845.namprd03.prod.outlook.com (2603:10b6:408:13d::10)
 by BL0PR12MB4611.namprd12.prod.outlook.com (2603:10b6:208:8e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.18; Thu, 28 Apr
 2022 08:26:08 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13d:cafe::3e) by BN9PR03CA0845.outlook.office365.com
 (2603:10b6:408:13d::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Thu, 28 Apr 2022 08:26:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Thu, 28 Apr 2022 08:26:07 +0000
Received: from canli.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 28 Apr
 2022 03:26:03 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3] drm/amdgpu: Fix build warning for TA debugfs interface
Date: Thu, 28 Apr 2022 16:25:24 +0800
Message-ID: <20220428082524.32450-1-candice.li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab2883ea-7243-4705-b6f3-08da28f0be57
X-MS-TrafficTypeDiagnostic: BL0PR12MB4611:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB461133BE0AF874C1B087D4BF91FD9@BL0PR12MB4611.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LX8S5ZO8HN03UhhaHPprWLh0tX3rrVCioxPMMtl1mBs1ZWNFyOSsd+xBZsVEaxWIe9ZC0Xo1IRIKiC8mwy03uVxsC+tukuv4+F9xrZqg7yO0nP6KaH/Vx5H7FwyWE4Ey31vyBfHq63B0r0j+FGkayJK44pW5gSafocKKLkSSQJ/Ot6N3/Rl8+sIv8F+phFcpWQBaG/u3+Tn9s9GKIBqx4JZqxmFhxw4SmLMV3t56gHvmIErxkNaqv57TvnFEoyKzrFdfKBhaYB3AslMSY18dPvVRKgeKYRXOZHflyGK62TBBTPahVf0NG+qa9EYbjMkN+hCjBL69VsF7gT4xIU0HpywaGaJntq5/zxabfTklitJQEttY6KnkiONW7B86Ks4eE/X5kOA3O2TSRye9rMGQLTmYaqh1g6G+qJ0A3McOnaD5kcx3N/uOAY2KXOWJZ6CRZPub5Zpcpga0hcLKGbjOApdbyDmkeNmSrINFdSrdz4iPrlqL9AVcvXW4JAxuBGYfBUKblcwxtnvFxBmlD4Ps/d5xyHY+AW857qlK3cbmOK9c8UkhLRvXfrmgz12f1S4MVPe8VbcYyAYjglSqL4KcghNB38As/mjBDMnyIEDpounYpQsl84mWN/7KbbAdOYMdA8ZypkctJcZV5d0A0pEE3/k3TryOZKajH+togP7o1rEV3LH+kGGFA7kmHVKJxWHyBQBtJ0dzuZ5sgd4WNGl87Nm45UHSv3V6B45LlCVKivCz7YeAm5N/x1pTXfQ+/WHL
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(36860700001)(83380400001)(36756003)(426003)(336012)(40460700003)(16526019)(186003)(47076005)(2616005)(1076003)(82310400005)(2906002)(44832011)(316002)(5660300002)(26005)(6916009)(356005)(6666004)(8936002)(81166007)(70206006)(70586007)(8676002)(4326008)(508600001)(86362001)(7696005)(461764006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 08:26:07.6403 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab2883ea-7243-4705-b6f3-08da28f0be57
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4611
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
Cc: Candice Li <candice.li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove the redundant codes to fix build warning
when CONFIG_DEBUG_FS is disabled.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c | 40 ++++++++--------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.h |  1 -
 2 files changed, 14 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
index 6806deb098d3f7..0988e00612e515 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
@@ -24,12 +24,7 @@
 #include "amdgpu.h"
 #include "amdgpu_psp_ta.h"
 
-static const char *TA_IF_FS_NAME = "ta_if";
-
-struct dentry *dir;
-static struct dentry *ta_load_debugfs_dentry;
-static struct dentry *ta_unload_debugfs_dentry;
-static struct dentry *ta_invoke_debugfs_dentry;
+#if defined(CONFIG_DEBUG_FS)
 
 static ssize_t ta_if_load_debugfs_write(struct file *fp, const char *buf,
 					    size_t len, loff_t *off);
@@ -38,7 +33,6 @@ static ssize_t ta_if_unload_debugfs_write(struct file *fp, const char *buf,
 static ssize_t ta_if_invoke_debugfs_write(struct file *fp, const char *buf,
 					    size_t len, loff_t *off);
 
-
 static uint32_t get_bin_version(const uint8_t *bin)
 {
 	const struct common_firmware_header *hdr =
@@ -74,19 +68,19 @@ static bool is_ta_type_valid(enum ta_type_id ta_type)
 }
 
 static const struct file_operations ta_load_debugfs_fops = {
-	.write   = ta_if_load_debugfs_write,
+	.write  = ta_if_load_debugfs_write,
 	.llseek = default_llseek,
 	.owner  = THIS_MODULE
 };
 
 static const struct file_operations ta_unload_debugfs_fops = {
-	.write   = ta_if_unload_debugfs_write,
+	.write  = ta_if_unload_debugfs_write,
 	.llseek = default_llseek,
 	.owner  = THIS_MODULE
 };
 
 static const struct file_operations ta_invoke_debugfs_fops = {
-	.write   = ta_if_invoke_debugfs_write,
+	.write  = ta_if_invoke_debugfs_write,
 	.llseek = default_llseek,
 	.owner  = THIS_MODULE
 };
@@ -286,31 +280,25 @@ static ssize_t ta_if_invoke_debugfs_write(struct file *fp, const char *buf, size
 	return ret;
 }
 
-static struct dentry *amdgpu_ta_if_debugfs_create(struct amdgpu_device *adev)
+void amdgpu_ta_if_debugfs_init(struct amdgpu_device *adev)
 {
 	struct drm_minor *minor = adev_to_drm(adev)->primary;
 
-	dir = debugfs_create_dir(TA_IF_FS_NAME, minor->debugfs_root);
+	struct dentry *dir = debugfs_create_dir("ta_if", minor->debugfs_root);
 
-	ta_load_debugfs_dentry = debugfs_create_file("ta_load", 0200, dir, adev,
-						     &ta_load_debugfs_fops);
+	debugfs_create_file("ta_load", 0200, dir, adev,
+				     &ta_load_debugfs_fops);
 
-	ta_unload_debugfs_dentry = debugfs_create_file("ta_unload", 0200, dir,
-						     adev, &ta_unload_debugfs_fops);
+	debugfs_create_file("ta_unload", 0200, dir,
+				     adev, &ta_unload_debugfs_fops);
 
-	ta_invoke_debugfs_dentry = debugfs_create_file("ta_invoke", 0200, dir,
-						     adev, &ta_invoke_debugfs_fops);
-	return dir;
+	debugfs_create_file("ta_invoke", 0200, dir,
+				     adev, &ta_invoke_debugfs_fops);
 }
 
+#else
 void amdgpu_ta_if_debugfs_init(struct amdgpu_device *adev)
 {
-#if defined(CONFIG_DEBUG_FS)
-	dir = amdgpu_ta_if_debugfs_create(adev);
-#endif
-}
 
-void amdgpu_ta_if_debugfs_remove(void)
-{
-	debugfs_remove_recursive(dir);
 }
+#endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.h
index 883f89d57616d0..cfc1542f63ef94 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.h
@@ -25,6 +25,5 @@
 #define __AMDGPU_PSP_TA_H__
 
 void amdgpu_ta_if_debugfs_init(struct amdgpu_device *adev);
-void amdgpu_ta_if_debugfs_remove(void);
 
 #endif
-- 
2.17.1

