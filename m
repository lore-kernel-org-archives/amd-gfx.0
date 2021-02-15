Return-Path: <SRS0=jhpT=HR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD304C433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Feb 2021 12:34:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B85964DC3
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Feb 2021 12:34:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B85964DC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 431E189D4D;
	Mon, 15 Feb 2021 12:34:53 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D995489D4D
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Feb 2021 12:34:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fd1AuSOPQAUToYy5RhswziS2hbc1fK2lsx6oRDTXKzqWewywfT2BSO5P+4om74zpYTJP8HwGA2AS3ZcA2bEcnvB/r5HXOVKljSpx4D8U8nsPzs1H2XbWX7QoN/07PMoZxWtqq02y9e32XFWLx3iudGL5DYQ2HXyYfaxTv+Avn5o1zaSp4CMkeWBbgyHhAMSFU5Gji9niqV769a34n1BSqv86seyERXRKgTZ/6iYT28WFE3p3pVFjyNg70iQ3EP7/xQju6FmrDQqZAbPU3YmG0g0KKvJAHsdJ/mO7eSwLVCG64g3c84wqiRxgA54DCN7Kqg0sUW6dpzT50thMBySMuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bm2vqJi3fvXsDgDxjeXHRMgnGYG1kQpsegW3xeFSQTQ=;
 b=MrBLkBuuctFunaZaSANJoJbileVqeSjz5xHKmBEDzm9mPOLbO31GGqZJQBUYYSg9b9CRAFli2Q+togdmOoPYNiL5pgF1VBbsBo6piZHVGd1UmEZ+Smf4yA2EArjUZJMFPIR4PL+ViMxgwsMschvaMOpdv0dEIWq9XDo08FiumsBsIzZMxSLYTvUA8sWhZZlGS8DVuzJkEm/ZRnnEFC7zn2dIQvhkCMoPRsNUTkRd4CDTSfo9VFDuQC7bPO3E/KEtoZ2h7K9Om+6o12lRBwXXGI1bqmO/gEu2hvpnJsKXEXHf5xWfxMOlDwYHuiotIGB++oVoapSWF0bgEmpo/J478A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bm2vqJi3fvXsDgDxjeXHRMgnGYG1kQpsegW3xeFSQTQ=;
 b=daSbaT7njrsi/D8OY8rRkSQ2bpo0wtpTkYm2gOnvktb6gX253Uz28iJX+Wwf7E+LSnGd64ScdVqAuIEFPsW6/c70AjlAL90bkkM1e6QZX32c+2eIef2g8vzsXz77JC4l7FNHmmAicEGeNnciyXoxqGVUB7J83EkyrSd//l7lukg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB4452.namprd12.prod.outlook.com (2603:10b6:5:2a4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Mon, 15 Feb
 2021 12:34:50 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::452c:77af:fea7:a633]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::452c:77af:fea7:a633%6]) with mapi id 15.20.3846.039; Mon, 15 Feb 2021
 12:34:50 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: Christian.Koenig@amd.com
Subject: [PATCH v2 1/3] drm/amd/display: do not use drm middle layer for
 debugfs
Date: Mon, 15 Feb 2021 13:34:36 +0100
Message-Id: <20210215123438.85436-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.0
X-Originating-IP: [93.229.46.81]
X-ClientProxiedBy: AM0PR03CA0015.eurprd03.prod.outlook.com
 (2603:10a6:208:14::28) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (93.229.46.81) by
 AM0PR03CA0015.eurprd03.prod.outlook.com (2603:10a6:208:14::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.25 via Frontend Transport; Mon, 15 Feb 2021 12:34:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d9d24b42-9212-4c1a-e897-08d8d1ae1633
X-MS-TrafficTypeDiagnostic: DM6PR12MB4452:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB44527EAF3D45E17DEFDA1D188B889@DM6PR12MB4452.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4u1aaVFoAt5fLaoSkBIHKSj2W9eyNOsks5mHZi/0CIrTSvohJKDMiMuOM/dsp79aFMdQB588D15iiaJASVuq7b4W1o3bls2urQmiaS4iORKzh3L3nTpipj0Ph0RkfbQq61j1P+VE9/J6x6/2zEE65cMH7I7Im6W2xvnzEP21Isf1FCUnKGYDz3ISM79hHc2NbZvsjxDMfOJr20YyGgr638y7ZC32cu7kbf3Qd4avN8kNl5sKRW5K3OHw+zFl8Ar8Ph2covumoDM7Mcnx9MTWrJxnsqfumd74IoaUoHIuAZCgiPhQq5UXpHxE8irnPBNcmN2jPncxUPzFiOHm5Um8QR7UkHjXgvTMWLjH1Dls6KzkviCZ/5r/qfxxzXgS02XhHrDBzru8jY2ZYZUAKmDfLWX6dvuVe8YokXPfOYy+3tMIaOeSH3HHkB8ENUOXeDCBdaYMJO4WmTuxJMek5r525BHhyvIcXXEc4X45fKbkDIbmQJJFAEClBoAUkTHt7IG2gw9PlK2iRkd+5Tohw0mEMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(376002)(366004)(136003)(346002)(4326008)(34206002)(6486002)(6512007)(36756003)(478600001)(83380400001)(6636002)(8676002)(2616005)(956004)(37006003)(316002)(2906002)(52116002)(8936002)(16526019)(26005)(66946007)(5660300002)(66556008)(66476007)(6506007)(186003)(1076003)(44832011)(86362001)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ZNTm1j2JbBmMzOgwFo+ozYOlx7LlPdrg62YKAV3mxieoBshGYOVbWOyA8krw?=
 =?us-ascii?Q?ZPEVUFtw8APisfgdKn04fmRgPqHruQ0BnkVD4ZZAdcRYg1f4ASSO6izsrC8r?=
 =?us-ascii?Q?zm9QL0PZZ+/jxJ7f0y3Rou4crur0WXWUAyAmzoqwjne6jVBgQKHssbIqVCaA?=
 =?us-ascii?Q?VfSThBo9lyCvg9ibwHExGIjLeZyor7PI3Cmau/Z7uuDVinpq5Tz2tqx+kdtk?=
 =?us-ascii?Q?6grtfcZ8s5cAWsa1IF1K0ApWlYWN7YgaeLJxGlz6H+wLgGAARvtygpuLIYCK?=
 =?us-ascii?Q?aTxnGGQDoBzmJafArwIHvL2mc/p/RBZjUhjK9mjVETeXfqDWdCpv1KrlEhDT?=
 =?us-ascii?Q?6sC+SCQGlbIPNpxKyg/8sN+Wcz2mMXA9IKY1H3RS1pgeeBZVZPHA3A5YKP0Z?=
 =?us-ascii?Q?hX12j7HlJC2flU6P01KG8jDxdnCroU9+t43mN1OFauxdlqjVuwMAMpqb0wF7?=
 =?us-ascii?Q?1n95yHPfJgtoAKfJ7aKqc8T4KbsLIgNNOvx5NGHxOlilZWHsda2Lyk1NFfPc?=
 =?us-ascii?Q?LCJUsw3mZvx2iW+JbU/NxVEg236BLQALxU3lLRs0ISSIhVU6C3fsSQkYDOLA?=
 =?us-ascii?Q?uOF5ynq8I6YmUPOXwWi9EsgixlpOZ37K78I5+zUaQOxmNQEqUGIJ6Lcp3qzd?=
 =?us-ascii?Q?GBkZnrsexYepVcpiLPgYwU+rahjIriyv0H3r+jsB6KX01CxW1TIr8KzP8E4S?=
 =?us-ascii?Q?398PxTVQ4K/u5j9ADGEvBMbxO7faybHnBaP2DIyBHRyVvbFqPCAP4H/bvEbd?=
 =?us-ascii?Q?ybKF5ZhtAI1jQcEj/IWV9114vAcUG/w/KwbMqRLViskh+9+GUf6LOeBsa7Ah?=
 =?us-ascii?Q?pz1PAkLamDYaEcslXqQtjfpwCqGkWVu+VLT7ktT/gXecFwpvCgQM3A4HMQYE?=
 =?us-ascii?Q?GZGiU7t32ALTNbBPGelgso9a5WzeQgYUNEobdkfSF+DwnQV7Dip8ZCBKb/LJ?=
 =?us-ascii?Q?rIBlMhg9GNtmL6bZT+2Fv5AqTSUE8XqStvaQi+QoDI0666Fa84Uj4Nvc4+9w?=
 =?us-ascii?Q?L/MkLjnwSCtFex887dkakBDrW707GYTFmkcf6D8RbytkG4fn/LDEyGVP7OH5?=
 =?us-ascii?Q?GAS2zzJ4c9P/jWyehiw1VTmH/c8/6ZgY3dIfQOCqX/R5O1fY6sWV2Ydmk+XG?=
 =?us-ascii?Q?VOhWoCAHAXA/Pm572nyE2mFuGCjMutSrNwBi1YzjlNxzgYNPYZazRAWmoqJU?=
 =?us-ascii?Q?UsSo7/52rrxokTKmswFv9WCFvwe28O5RtV9i0j77OqljBk4/wiXDvyyogivb?=
 =?us-ascii?Q?lzGWxS6AfVucALZ8WCQH2O+esZ1j88HFpALTix/r0Cxk+2rZb27iIOKg/1rp?=
 =?us-ascii?Q?XUHZfYO3CjvFNzLqR49Rb/xd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9d24b42-9212-4c1a-e897-08d8d1ae1633
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2021 12:34:50.3478 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2gHlVyuiEJPo8b4HIoOtqVMWXQJZSiOeau4NuRqgDmEnzKb/KFmmsOSnvwKFdsOxZC1YKBDTFuotqiC/F4pMqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4452
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

v2: * checkpatch.pl: use '0444' instead of S_IRUGO.
    * remove S_IFREG from mode.
    * remove mode variable.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   |  6 +--
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 45 +++++++------------
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.h |  2 +-
 3 files changed, 20 insertions(+), 33 deletions(-)

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
index 360952129b6d..704aa8cb668e 100644
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
@@ -2582,13 +2573,13 @@ int dtn_debugfs_init(struct amdgpu_device *adev)
 
 	struct drm_minor *minor = adev_to_drm(adev)->primary;
 	struct dentry *root = minor->debugfs_root;
-	int ret;
-
-	ret = amdgpu_debugfs_add_files(adev, amdgpu_dm_debugfs_list,
-				ARRAY_SIZE(amdgpu_dm_debugfs_list));
-	if (ret)
-		return ret;
 
+	debugfs_create_file("amdgpu_current_backlight_pwm", 0444,
+			    root, adev, &current_backlight_fops);
+	debugfs_create_file("amdgpu_target_backlight_pwm", 0444,
+			    root, adev, &target_backlight_fops);
+	debugfs_create_file("amdgpu_mst_topology", 0444, root,
+			    adev, &mst_topo_fops);
 	debugfs_create_file("amdgpu_dm_dtn_log", 0644, root, adev,
 			    &dtn_log_fops);
 
@@ -2603,6 +2594,4 @@ int dtn_debugfs_init(struct amdgpu_device *adev)
 
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
