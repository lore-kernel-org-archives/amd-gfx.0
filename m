Return-Path: <SRS0=jhpT=HR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2AE0C433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Feb 2021 10:17:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 505BA64D73
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Feb 2021 10:17:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 505BA64D73
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE4648907C;
	Mon, 15 Feb 2021 10:17:10 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E95E98907C
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Feb 2021 10:17:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BDLtfFPb8FHFpS/6TGBbcEs2k2v5y5QJ73yupgaookL8HR/xk3nEoLiaxhWlQPMmOz9/sAIwTRoPBNgdABTTsGBsV53+xQ+0LJwb8J7DQVgvDVaMO+W2MHENl75zY3uk8I4g0ZRlr1R7AW8rU6zfrOz4t9M0RPRJdiujtPo5NNWqoOU61d1ouy2zdKxfmEboIpQsPwh2KRkqxnyXn5XCQ1Q8Re8NFT7ceZRzhbS3TjjUjfDVWtbAkbDKze0y1EIbjIG5BgfEt5yx8laAO0XepC050ZtveVCcNZy/LmvoQ2gauAVFsh0QyOPFM3rPL0JLaCyNp+ojGZiNv5RQtMl9uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UWTMkjAMoJYifXLSBFHhZCU0VWfJxLv4HMg1DpGWxsY=;
 b=eHulj/ol8MIJlktVMupr2o8zpc6b/qkRqpnDEjLokkQBxV9/8pcxGP25JgfEsse/TohI61J1lB75+nV7DTJH0BzOX0XRucBnwgVPqOlHM3xGWmr4SF3wqLeHj6mG7MU1OSjiyw7cLJ93j2qgUZul6tQoP7SdWkVmTCSfscD2Tk0J3qsRp74dErd/LoDEDSQT6TWEs8sKMDMaRQvDsL2RjvtDTZVv0wzqAYslNQhaL0DOMHd7h8jSH9hHWEBzvmwRWLyIWU8vzED/NpGezFR3szoI5kwm1dgY2/jcvvumTcXiTfJR6KZ5FdWPXzapXhbVvNvacOPM2gN2GmYRt/YoAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UWTMkjAMoJYifXLSBFHhZCU0VWfJxLv4HMg1DpGWxsY=;
 b=A1bZYymN26wIFZao7QweAs8/Hct1V4035wz0zFAyPFf5Zx6D5jgH9G4zV2e3FobDBTA9SBNlgo1VDmL41y9aaO9iE1Bu4jE4MJ/tpQGHEQDi5GvT8/mI+g/YXXYoNNUPtD0YlZY/iPs2kV2QTwufVtHLPS7mYaohXXmhXwV8+18=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB2970.namprd12.prod.outlook.com (2603:10b6:5:3b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.31; Mon, 15 Feb
 2021 10:17:08 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::452c:77af:fea7:a633]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::452c:77af:fea7:a633%6]) with mapi id 15.20.3846.039; Mon, 15 Feb 2021
 10:17:07 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: Christian.Koenig@amd.com
Subject: [PATCH 1/3] drm/amd/display: do not use drm middle layer for debugfs
Date: Mon, 15 Feb 2021 11:16:51 +0100
Message-Id: <20210215101653.35694-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.0
X-Originating-IP: [93.229.46.81]
X-ClientProxiedBy: AM0PR10CA0082.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::35) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (93.229.46.81) by
 AM0PR10CA0082.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.26 via Frontend Transport; Mon, 15 Feb 2021 10:17:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7f992ab5-00df-4552-55a1-08d8d19ad97d
X-MS-TrafficTypeDiagnostic: DM6PR12MB2970:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB29704FE52CED28D7C9E69C478B889@DM6PR12MB2970.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MClaW6JLgUWWb1dd+Nn80QJizwUFYskSzfqr/pmAYi6X6KQCkeMRA7PqBgyRr7I3pXuCiCAI+U6jnNKp0BQDuXZSGnBWjxAYBtQrBRJAt8Hyz91CKriRYodkddNbRNH/kQ6PlriryTBlbTql5nSI4i087BThsKDH2xIfXChp3CS6u9OV/aJWkGhEZFFNg5Au03C7atJVXXqgSEZCso2a+x43c5GBQivkAFokzQiJaLdclwBHvEkoUSNtgZWUoInV6//LugK8yZb5NCi+HxjlB6f6GaT4nsbCoYFh3jtz7xObb3vUFYXFOHfloTBK2Dr8W2ZnYqIBF3WGaKoo8TE6SLcgfNIrUh6KmoDAINaOltuyFaWLrR2VoiUeCJ/lZnybbqVAAgluZCkLIGQcgaf0fxe81GLDyoZzlNWkrSuFuf2Sw54lLEKy22+ciml9LkvXRlyXzd82I5zxjSfmWukWaRNmxQGhJX83m1aUq5151TDPF7DGeMJ560DQ9vxQExD8uZcrC/6nA+5DxgRinvcvjA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(366004)(396003)(346002)(136003)(16526019)(6636002)(6512007)(2616005)(5660300002)(1076003)(186003)(44832011)(2906002)(478600001)(956004)(4326008)(26005)(34206002)(86362001)(36756003)(6486002)(66946007)(66476007)(6506007)(6666004)(8676002)(83380400001)(66556008)(316002)(52116002)(8936002)(37006003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?OA1ztjRh42lUfsmb8s1YUNV0P4O7tB7OQCGMzEj30vcUMYS5FDRjgVcuQz09?=
 =?us-ascii?Q?tA3GssIiDZCDfS19w0AN0WaWLJnoB3vlA//gJ4/zgeQdSFQXwedXZTMbNAYZ?=
 =?us-ascii?Q?Wk0EPGo5n7NfDWukidcjXbpU5U3AmkwUBn9XHhVXDrP6m3m4BNP8dOlcvdPj?=
 =?us-ascii?Q?oyZFWcjMDo32huaRCFXawXF1aSh9G7f16E4vdqQqWQ/LEH4oX7EqgGrPOtrY?=
 =?us-ascii?Q?APuryM/I6nwokZifiyIeWWu41af/ytGVOM4hPzu87jldaM2hghNW/9GhiKv9?=
 =?us-ascii?Q?v0nWlABS6or16a26VmyG1hdxU1dDHBYmFm0ix77SJu1fOXBJbNNxjilaXPkS?=
 =?us-ascii?Q?i8HBfHMmt9esw1BoaY/mze/ag0s/1rrdvsMnvaafrywYterYaeL5CJyzvPhb?=
 =?us-ascii?Q?CIerBprEJRL/heX6TRHm/B0NFHxczW946aJ3eHBirreAi1rapM5oYpHRSXGc?=
 =?us-ascii?Q?WfZwLd/Cqt17XG4rlYgHDo8Nk6KRi9eeau/iOK/qdUiIyztPcgdYkKwlzWIi?=
 =?us-ascii?Q?N7sbNf65HHBLJgPJG6htrZ3i78lfMQfQjZAvWXmQc0S0PQi7FsSJng2cNjtG?=
 =?us-ascii?Q?SHnXbxIilLiELVNn6RAqeFwBSZC1Lsj01SwlD2ip7ztUOeY6AG5rliWQ4NNA?=
 =?us-ascii?Q?d7g50peR2PjtpQ2yfrnoquB5U8vm9H8pPWBZiYtyLBErYEe/YVuatt1aMW36?=
 =?us-ascii?Q?AlHXeVHodDmcF+u9Ci9ySYIQOt9QKsy3POLV6GCm/i9ISh8GgGqEgo/Pojpq?=
 =?us-ascii?Q?iYvD/6Hqsj8cdV3kLPD10YCnyl8ugp5REdLE1wOeeO/sxehevpMIecZib5Hn?=
 =?us-ascii?Q?y9M+bUIZ1Pf8WsJ9bl7p/puvOoP1doMEBjHi9jXSfEwJlK0EvvnCPuaTiGsc?=
 =?us-ascii?Q?xZ/v95PQeqZzXduSB27p91Bh4g9ez9y7HcfRxJuv+8Pf+a05sr/yI5px4bI+?=
 =?us-ascii?Q?TSKE7vZfor7Zn7C5oc+YMJReiez2IZXR6zQnT2JMmDWj7le2IgPgZZLsTiji?=
 =?us-ascii?Q?kgD3DZ/ERrvPYzpNFFjiBJLifhYAeU8XufIXi1+rtOZnA1jVMu0ClmbYLutQ?=
 =?us-ascii?Q?lvxQ8zkYLH8ABZOokWJmOL0R/JvdyCKqvIJ6PxZrnT+tNE4gR++9LXPdyp6N?=
 =?us-ascii?Q?qd7mqF8pNBOtLGK2dIlGhTr4iy5PmdIjuMKILHdMoRWpk58CvZVOXmp1i2Ln?=
 =?us-ascii?Q?ciam99CnbNqq9RqVQO4k6brq4gNdd5Xjd3L4wxfYgCYd1oRh9F+I9dpGQIFW?=
 =?us-ascii?Q?USOK7MZ8RK3SWwlYznUhaeMrlSNpOMAi24nEwjEdUhcK7kRzRJspDHPNroVa?=
 =?us-ascii?Q?yvJHb3LxQkjDOGbtctQMH0Yk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f992ab5-00df-4552-55a1-08d8d19ad97d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2021 10:17:07.8622 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PKd9YrMfEoT8JupcXmOvzSoAaW/btX6wQ6wjHtG4uSovhUe6e+P7/rGtUXaDh/uuqGOf9aPFI891XEsMrB8coQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2970
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
Cc: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use debugfs API directly instead of drm middle layer.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   |  6 +--
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 46 ++++++++-----------
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.h |  2 +-
 3 files changed, 21 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 55db646d0ba4..60b2f2d4ca80 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1642,10 +1642,8 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 		DRM_ERROR("registering firmware debugfs failed (%d).\n", r);
 
 #if defined(CONFIG_DRM_AMD_DC)
-	if (amdgpu_device_has_dc_support(adev)) {
-		if (dtn_debugfs_init(adev))
-			DRM_ERROR("amdgpu: failed initialize dtn debugfs support.\n");
-	}
+	if (amdgpu_device_has_dc_support(adev))
+		dtn_debugfs_init(adev);
 #endif
 
 	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 360952129b6d..9a5f119a834f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -25,8 +25,6 @@
 
 #include <linux/uaccess.h>
 
-#include <drm/drm_debugfs.h>
-
 #include "dc.h"
 #include "amdgpu.h"
 #include "amdgpu_dm.h"
@@ -2450,11 +2448,9 @@ static ssize_t dtn_log_write(
  * As written to display, taking ABM and backlight lut into account.
  * Ranges from 0x0 to 0x10000 (= 100% PWM)
  */
-static int current_backlight_read(struct seq_file *m, void *data)
+static int current_backlight_show(struct seq_file *m, void *unused)
 {
-	struct drm_info_node *node = (struct drm_info_node *)m->private;
-	struct drm_device *dev = node->minor->dev;
-	struct amdgpu_device *adev = drm_to_adev(dev);
+	struct amdgpu_device *adev = (struct amdgpu_device *)m->private;
 	struct amdgpu_display_manager *dm = &adev->dm;
 
 	unsigned int backlight = dc_link_get_backlight_level(dm->backlight_link);
@@ -2468,11 +2464,9 @@ static int current_backlight_read(struct seq_file *m, void *data)
  * As written to display, taking ABM and backlight lut into account.
  * Ranges from 0x0 to 0x10000 (= 100% PWM)
  */
-static int target_backlight_read(struct seq_file *m, void *data)
+static int target_backlight_show(struct seq_file *m, void *unused)
 {
-	struct drm_info_node *node = (struct drm_info_node *)m->private;
-	struct drm_device *dev = node->minor->dev;
-	struct amdgpu_device *adev = drm_to_adev(dev);
+	struct amdgpu_device *adev = (struct amdgpu_device *)m->private;
 	struct amdgpu_display_manager *dm = &adev->dm;
 
 	unsigned int backlight = dc_link_get_target_backlight_pwm(dm->backlight_link);
@@ -2481,10 +2475,10 @@ static int target_backlight_read(struct seq_file *m, void *data)
 	return 0;
 }
 
-static int mst_topo(struct seq_file *m, void *unused)
+static int mst_topo_show(struct seq_file *m, void *unused)
 {
-	struct drm_info_node *node = (struct drm_info_node *)m->private;
-	struct drm_device *dev = node->minor->dev;
+	struct amdgpu_device *adev = (struct amdgpu_device *)m->private;
+	struct drm_device *dev = adev_to_drm(adev);
 	struct drm_connector *connector;
 	struct drm_connector_list_iter conn_iter;
 	struct amdgpu_dm_connector *aconnector;
@@ -2504,12 +2498,6 @@ static int mst_topo(struct seq_file *m, void *unused)
 	return 0;
 }
 
-static const struct drm_info_list amdgpu_dm_debugfs_list[] = {
-	{"amdgpu_current_backlight_pwm", &current_backlight_read},
-	{"amdgpu_target_backlight_pwm", &target_backlight_read},
-	{"amdgpu_mst_topology", &mst_topo},
-};
-
 /*
  * Sets the force_timing_sync debug optino from the given string.
  * All connected displays will be force synchronized immediately.
@@ -2568,10 +2556,13 @@ static int visual_confirm_get(void *data, u64 *val)
 	return 0;
 }
 
+DEFINE_SHOW_ATTRIBUTE(current_backlight);
+DEFINE_SHOW_ATTRIBUTE(target_backlight);
+DEFINE_SHOW_ATTRIBUTE(mst_topo);
 DEFINE_DEBUGFS_ATTRIBUTE(visual_confirm_fops, visual_confirm_get,
 			 visual_confirm_set, "%llu\n");
 
-int dtn_debugfs_init(struct amdgpu_device *adev)
+void dtn_debugfs_init(struct amdgpu_device *adev)
 {
 	static const struct file_operations dtn_log_fops = {
 		.owner = THIS_MODULE,
@@ -2581,14 +2572,15 @@ int dtn_debugfs_init(struct amdgpu_device *adev)
 	};
 
 	struct drm_minor *minor = adev_to_drm(adev)->primary;
+	umode_t mode = S_IFREG | S_IRUGO;
 	struct dentry *root = minor->debugfs_root;
-	int ret;
-
-	ret = amdgpu_debugfs_add_files(adev, amdgpu_dm_debugfs_list,
-				ARRAY_SIZE(amdgpu_dm_debugfs_list));
-	if (ret)
-		return ret;
 
+	debugfs_create_file("amdgpu_current_backlight_pwm", mode, root, adev,
+			    &current_backlight_fops);
+	debugfs_create_file("amdgpu_target_backlight_pwm", mode, root, adev,
+			    &target_backlight_fops);
+	debugfs_create_file("amdgpu_mst_topology", mode, root, adev,
+			    &mst_topo_fops);
 	debugfs_create_file("amdgpu_dm_dtn_log", 0644, root, adev,
 			    &dtn_log_fops);
 
@@ -2603,6 +2595,4 @@ int dtn_debugfs_init(struct amdgpu_device *adev)
 
 	debugfs_create_file_unsafe("amdgpu_dm_force_timing_sync", 0644, root,
 				   adev, &force_timing_sync_ops);
-
-	return 0;
 }
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.h
index 5e5b2b2afa31..32f85c2b608f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.h
@@ -30,6 +30,6 @@
 #include "amdgpu_dm.h"
 
 void connector_debugfs_init(struct amdgpu_dm_connector *connector);
-int dtn_debugfs_init(struct amdgpu_device *adev);
+void dtn_debugfs_init(struct amdgpu_device *adev);
 
 #endif
-- 
2.30.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
