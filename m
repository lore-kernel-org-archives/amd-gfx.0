Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7AD8C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Apr 2022 11:22:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3761A10EE93;
	Wed, 27 Apr 2022 11:22:31 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B68810EE93
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Apr 2022 11:22:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e2RBFUVLskWpRu/IGzyJuNgroqDdy+13ZoNoPGdUVwRU5SrLJc/M5m1Wv8ZcF1kl6Hy1sW1vihzITCU1m6kIfGZ2Rieqz3QDWiElIyEtLNL7yfYNMgT2ooA9FWuzipu58Yspj026mBy79ObhsHnNchB7QF3Q8Xw3Kaqwf2RxlHU9vB0xGWvsjWytomGUrcbLzsdddywp+msNcPxxxoe09JVtGEl5rL1zjf+yi1X+ScW//snmf2Rd79ToPpNHJFXDsAMK8ONVuQx1EbMjV9th/6/qSIxEBEG2GfNUXcQuKvrVIjrUsGQU8F+FJyOwqPKRMMtoc9m6BEI538/0HNkeeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tP6QBCO6EeYkHXwqAd6779V1CV4l5ZL0IFRz8xYI45A=;
 b=di+yCEmp5VxwMNcMvDlfDpgMjbxav34wqNJvyT+HC9LSBPXekYWu7aMZAXavvAdU10YSRm1VOpT5moeVcESBmhUB6iYHTc0+CbXsC38zCPiYvlc8t9Ad/3lt+BgQ4O+TNU8tcdkAMqjjiKRTNfIxHWbt7TU5CecEzIHTBXQaKfIGaQGZsm9NdkkizAeugAHX6+05Jxk0B+MfK3CD80+RpaEtoNXXln1a1uP1x0R+6vplgd9IKZ5kLWY/GUtu9uSiau73gkOyVzstRTA7M54IP3Kgy6ExO5/bvYZlQKg7t6Xu6UI0gF3LlUgqR4g0K8cgWp29p647ZeE0iDX8i8tYEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tP6QBCO6EeYkHXwqAd6779V1CV4l5ZL0IFRz8xYI45A=;
 b=zUeNQDW7KubRe8IOVluVrx2BoUmzzYVOSN/E9GCGfgDZuPWHZJqbzWfc2UhvpMAUG7rytZ6j4i4sENPvj5r63/yNioxlS/z6NyOjYqpEhIPG9LevSHuYjY5GYTvQObUi1FhPdSL1BCyJhMChD7t2HY7ePAFTmMsGjUUi0YvZIT0=
Received: from DM6PR13CA0024.namprd13.prod.outlook.com (2603:10b6:5:bc::37) by
 MN2PR12MB4287.namprd12.prod.outlook.com (2603:10b6:208:1dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Wed, 27 Apr
 2022 11:22:28 +0000
Received: from DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::34) by DM6PR13CA0024.outlook.office365.com
 (2603:10b6:5:bc::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.6 via Frontend
 Transport; Wed, 27 Apr 2022 11:22:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT031.mail.protection.outlook.com (10.13.172.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Wed, 27 Apr 2022 11:22:28 +0000
Received: from canli.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 27 Apr
 2022 06:22:26 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: Fix build warning for TA debugfs interface
Date: Wed, 27 Apr 2022 19:22:13 +0800
Message-ID: <20220427112213.5176-1-candice.li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0545157a-7c33-4484-b234-08da28403681
X-MS-TrafficTypeDiagnostic: MN2PR12MB4287:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4287FAB9E782273C366F03A491FA9@MN2PR12MB4287.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P5qNaSNQSui6wCzqhkCzADikNFHo4cBB9mLDmCkv4esyrL9qtU0dlD3PYWBfSsX693ovt1jTDtubUCmllEiuHM4tBbGYFJxbfKsIHlJnQLUzpoF38/gLwkJvojPwiFXB0xFvC3waS7gAI4EJg5KHX2rMPxjVxyYjaLYphyXtPys0nC8hesjJPY9eQtoq9SgyrEavCm2XmDKg27wJAevkhUeyp4UU2yg9ukmXHO99/eYKdsjHmAsd8x7OZrt67bgmVC7BykZ/DtDSG96PzDDzHxgnNq73PyLQ7l7xqWVYw8nQ5LZJAm51sIOdUhfKeyPgS6K+B+6GnJZu8NJgfOUJVWMKnjdY93xBqFHQ5vJWdCX9Y9oQDqpqFR3gafbugE4rL9JLlrDQAVR49KmZwfvFW8i8i1L7OCaXBK/ZIt+k9tLIYyPBvM52tyDbn89/uchPuUd1l2rG68zCDIh44d6TE/n2CeS9urGvYuGrAOUvULXiuiHo3Cdy2LclabCJS8I4oXBgj2uhDbmzYwRrjsro7DIXrZvgkMzoS+wKLAKfzrOVRZfnUW57WvPC0LaG2LFT7Oy7t90z0s3lIMm9ob+jHK5SZd9uCIfju0wvbMu67w9UFQjyyPD6WvUyjXqyIy6f0he4PXUiUX+byXKD7oylpvUK5qFHgw9Em27Pc9/+qahm5pvBJ/5fUVimvc2aMWE2tOgsiR0sK0Q3JBQvy3LKPbjPqbjcFF+CS1aLjXZOSkrlsY9QaDD5EdsuqC4Ry6oG
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(1076003)(6666004)(7696005)(336012)(426003)(186003)(83380400001)(2616005)(47076005)(16526019)(82310400005)(2906002)(6916009)(316002)(86362001)(36756003)(40460700003)(508600001)(36860700001)(44832011)(5660300002)(356005)(81166007)(26005)(4326008)(70586007)(70206006)(8936002)(8676002)(461764006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 11:22:28.2896 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0545157a-7c33-4484-b234-08da28403681
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4287
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c | 43 ++++++----------------
 1 file changed, 12 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
index 6806deb098d3f7..97ea2246bc1ddb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
@@ -24,13 +24,6 @@
 #include "amdgpu.h"
 #include "amdgpu_psp_ta.h"
 
-static const char *TA_IF_FS_NAME = "ta_if";
-
-struct dentry *dir;
-static struct dentry *ta_load_debugfs_dentry;
-static struct dentry *ta_unload_debugfs_dentry;
-static struct dentry *ta_invoke_debugfs_dentry;
-
 static ssize_t ta_if_load_debugfs_write(struct file *fp, const char *buf,
 					    size_t len, loff_t *off);
 static ssize_t ta_if_unload_debugfs_write(struct file *fp, const char *buf,
@@ -38,7 +31,6 @@ static ssize_t ta_if_unload_debugfs_write(struct file *fp, const char *buf,
 static ssize_t ta_if_invoke_debugfs_write(struct file *fp, const char *buf,
 					    size_t len, loff_t *off);
 
-
 static uint32_t get_bin_version(const uint8_t *bin)
 {
 	const struct common_firmware_header *hdr =
@@ -74,19 +66,19 @@ static bool is_ta_type_valid(enum ta_type_id ta_type)
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
@@ -286,31 +278,20 @@ static ssize_t ta_if_invoke_debugfs_write(struct file *fp, const char *buf, size
 	return ret;
 }
 
-static struct dentry *amdgpu_ta_if_debugfs_create(struct amdgpu_device *adev)
+void amdgpu_ta_if_debugfs_init(struct amdgpu_device *adev)
 {
+#if defined(CONFIG_DEBUG_FS)
 	struct drm_minor *minor = adev_to_drm(adev)->primary;
 
-	dir = debugfs_create_dir(TA_IF_FS_NAME, minor->debugfs_root);
-
-	ta_load_debugfs_dentry = debugfs_create_file("ta_load", 0200, dir, adev,
-						     &ta_load_debugfs_fops);
+	struct dentry *dir = debugfs_create_dir("ta_if", minor->debugfs_root);
 
-	ta_unload_debugfs_dentry = debugfs_create_file("ta_unload", 0200, dir,
-						     adev, &ta_unload_debugfs_fops);
+	debugfs_create_file("ta_load", 0200, dir, adev,
+				     &ta_load_debugfs_fops);
 
-	ta_invoke_debugfs_dentry = debugfs_create_file("ta_invoke", 0200, dir,
-						     adev, &ta_invoke_debugfs_fops);
-	return dir;
-}
+	debugfs_create_file("ta_unload", 0200, dir,
+				     adev, &ta_unload_debugfs_fops);
 
-void amdgpu_ta_if_debugfs_init(struct amdgpu_device *adev)
-{
-#if defined(CONFIG_DEBUG_FS)
-	dir = amdgpu_ta_if_debugfs_create(adev);
+	debugfs_create_file("ta_invoke", 0200, dir,
+				     adev, &ta_invoke_debugfs_fops);
 #endif
 }
-
-void amdgpu_ta_if_debugfs_remove(void)
-{
-	debugfs_remove_recursive(dir);
-}
-- 
2.17.1

