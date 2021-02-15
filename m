Return-Path: <SRS0=jhpT=HR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 685A1C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Feb 2021 12:34:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 234AA600CF
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Feb 2021 12:34:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 234AA600CF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 915E46E226;
	Mon, 15 Feb 2021 12:34:56 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B88066E1DE
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Feb 2021 12:34:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NblkpqQ3nBiWU6s2J/B5Gd/1jMpYLHetw5kpq2RinTys+a2gZz6Cf2bZxLFKK4ZaR7oy5fGJ9nUUqj+/NgA2CSkxuq5FToLV/XLLhWd2OVMdWGc2pc5nWcMIiSKYUwQtL5G7UYBcDW7yal+8672JpAVtB4ebxtQ6Yc5jJDGY5dPdNISWPlhk0hKqFj3uzjlxJguWP9Sz7ovb+dkTQyBpP1NUfcnLMCjzMGhBXAY5wXiOUqjZis3CbhFrf1CexDK67jlPgMnNPzXa4FPpCkflcj82wyZIqo0tM7ju8y3VNesODcWu1ryS+gEmuyYIJJSQHi/XkOe9BhuTYY/NOyox6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JfKICjBsbcSEJuxm6OO1Ytf0y01mkpcvSwSVYZrJdSs=;
 b=e0OJ229XmWMEPPOv2b6ehPA/4EdjsjvQMQm1H9R4D+goe7Lj0dCr05WjCYQ8G9SpUNDsotnpA9onL7Dmkkdz/+7HOYl3CbgzhUbIg8NEUa1SedQpHgbC/t0L92E7pQXsez0DOryvqYAAcCQYY5GZFSLer7gx7d1fTIaEUcEVOJmk/w6npmvMkld/omR7j/dVpyWWb7eBrk4mPPeWwoHl5zrifcWPXLmW+ilYvwu2FtQsaTcaMoYUTa0iyTWIu5atxTBi7yOYQrI+Q7wX8FOvH4lrTzz67y80KKtFWJnUb4wNTketgxmO85XDPsG205jiSqRaW4V0Ndw/2b59ggonJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JfKICjBsbcSEJuxm6OO1Ytf0y01mkpcvSwSVYZrJdSs=;
 b=HC9u9B2eu9bQ7Br9kkQI0FlP4EVSoOm8wbSwD/jpwc2cU7UwJTs1GA5dqVQv4EKGo4rPTCE+/Az6/yNfhGZKMcM+1KuOS2CICpZLpBfvksUT3gZIhjrn88ln5m5EWc1ntyCoofKZn5PvuNjOA16VFYm5RnViY7H7F+iIYyu2G+Q=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB4452.namprd12.prod.outlook.com (2603:10b6:5:2a4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Mon, 15 Feb
 2021 12:34:53 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::452c:77af:fea7:a633]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::452c:77af:fea7:a633%6]) with mapi id 15.20.3846.039; Mon, 15 Feb 2021
 12:34:53 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: Christian.Koenig@amd.com
Subject: [PATCH v2 3/3] drm/amdgpu: do not use drm middle layer for debugfs
Date: Mon, 15 Feb 2021 13:34:38 +0100
Message-Id: <20210215123438.85436-3-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210215123438.85436-1-nirmoy.das@amd.com>
References: <20210215123438.85436-1-nirmoy.das@amd.com>
X-Originating-IP: [93.229.46.81]
X-ClientProxiedBy: AM0PR03CA0015.eurprd03.prod.outlook.com
 (2603:10a6:208:14::28) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (93.229.46.81) by
 AM0PR03CA0015.eurprd03.prod.outlook.com (2603:10a6:208:14::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.25 via Frontend Transport; Mon, 15 Feb 2021 12:34:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 29a42087-cd2e-475a-f1e5-08d8d1ae17d1
X-MS-TrafficTypeDiagnostic: DM6PR12MB4452:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4452DAAECA78FFF7A4AA15678B889@DM6PR12MB4452.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:159;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jvoX96yo1jkaNM0U5wO1Pb+k1RuFUSZ/iUV07dEctZjqYUlzy9sxIWm6JXDgMgdxCExVsNp6lzjWMM1KeputMM+pQdAfBkHZjL6cZPo6vUfslNmDeim3zeD4ysOd9jx5Cx9aGW42f9HBMYMAeK1HB2Zh7BJnPYTtsbXReMkSAmpvK0xIz7uAF8pEHWQbD4I0dtGFJ9dy/ELIAzaRMrYXntRgiVBgyGq3rJLggOn+AkR/Ot0PAJeU+fSV6AcTA/c6ekyQmuXvlbVhgngnJGkFB9v/v4/3oskdUzrMTzAYF1KUf9cdcCyZc0x4hypiBrKXPF7hlq7PmBhjo6MiLrhhHrE0001p4+1xjiZzocLGDSWcoNCVVfhAY1Q+wF5Dbf3kDsZ+X8a92zujeClde9SmVLoaPg724CBIc+lLVP5AfS6QyGDX0K2BMNtacvfhGoS1UxU3Zr7Av3KDFCF5PPx1CuJi8Isknp9iLzPXprYRiH8+pPASVb+kf9zUluIkSXL1iAuSId4X+O9IBqrbUd5qxg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(376002)(366004)(136003)(346002)(4326008)(34206002)(6486002)(6512007)(36756003)(478600001)(83380400001)(6636002)(8676002)(2616005)(30864003)(956004)(37006003)(316002)(2906002)(52116002)(8936002)(16526019)(26005)(66946007)(5660300002)(66556008)(66476007)(6506007)(186003)(1076003)(44832011)(86362001)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?3X5WMQAifm/vlkf7chKcOPOrPNrLNfT+SRbAGFbEsu+ul/brf9twARpyyrNj?=
 =?us-ascii?Q?6+By4ElTkUoXvJx5lA1ToWoATdxCzq7bQ64wias1nS6s+KKw1GK+cawREVkQ?=
 =?us-ascii?Q?TmMARao3+GBOCPaRN1XK3ZgqoU5XkgX1QYbQx5G+Vs68A5lsEXvyuqkjoIfw?=
 =?us-ascii?Q?/gJOxfvtjK92mMPht91JS4CQdetSETkPi+crhxFbksCv6zvl2a8XlHJdropJ?=
 =?us-ascii?Q?+6eJexmOZoqpY5+U1TK0+ZAeSDaJ8b1SVlory0wVTsxtKoYoc9QoMCsUBJ6t?=
 =?us-ascii?Q?aPn1t+ccOl+iqLC5aiyL/2PraobiRfXRhTCPzZie46kTpoBUIv7LBUnXyh62?=
 =?us-ascii?Q?J5TKTxsEV/i0vck1zzzoJ9HTUIvm0lLjH9hSowCryhysfLqKwuxk2XmV65Rz?=
 =?us-ascii?Q?gSSd++0KohWuxvAhj/hVgEd1OfNiPZ4Hfm0xfc3jHKVEVr7B1Au7jVfCgo1J?=
 =?us-ascii?Q?rgbu6vs6tNPq8EuAiuAs623OCMrbikrBbLMnGDqjf8pFbmLHbANyacJc09VR?=
 =?us-ascii?Q?00s6TtG07++s0ClDFc05cdV2WXgMQWglGeK9NGIgH6L1ruaNGGvFCNHNv6l4?=
 =?us-ascii?Q?OfSZonntFT58cpWLsog8y1Oxq0/k6cSfq4CRfkRMhbzzDoSRnO+C/f8ICdb3?=
 =?us-ascii?Q?0/wnTcE/DX+Te987YbqLj+ECMlQPUK8e3KCL/19wk1vJdJkdCg9O+p8w89r+?=
 =?us-ascii?Q?HarwvSsQYG13wckr8Ag/YsAaBQnwSORMc9o/vkkCQ3j4pKhZaHI/NpECareJ?=
 =?us-ascii?Q?sJkyUsWcn5HEyDpaHFOjZES1YB5Eftuo0qF65LCgapTw+kSVAALtXAfxTjo5?=
 =?us-ascii?Q?07Ah5GbPwfxCC/qt6Eq6Ui4ie498YDQ6/GbxQ2/OLEF31BMcfBs2WkajxX/z?=
 =?us-ascii?Q?9UKuroYeM7UiEkQDzER8o0Re515IHuYAJU5ZzPXY+HQTV8Z5i1JXqXFsfSd3?=
 =?us-ascii?Q?wWMRfuD1cTaOLefLGm4YNsr0F7is7KuLcEUSPTm67oFBOjbIo8WwBQHwc6fS?=
 =?us-ascii?Q?WzUOLzb66Ebpk5Lr7iox2L0XiCDsDesN9xPngGJfdpr3SXX4oe2S/0BwkV0D?=
 =?us-ascii?Q?qA4RBQBEIS+jIErC01U95kitHBJRrRSc9PZsn0k6NnKQPf0Ebt3JawJulf4t?=
 =?us-ascii?Q?xJhCWlPcikhh4hq0MH1kzEKWZ5GyG+L0B4BxhXx+po1MAIyOxCGu1K0OF6HP?=
 =?us-ascii?Q?oP/TG0byWnwmQsyKtrKsqgBMJBSoqVmuh4JSMXv/CWMZpL7d/DOJI9j/tAhR?=
 =?us-ascii?Q?rg0PDknXdctWo2HIa6uYe+17qLHK0rCgEEj9lBOhvug76IKWF+ZGYpNrQDHB?=
 =?us-ascii?Q?rqJBGy/S7h1dC2KnJeeMc+gA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29a42087-cd2e-475a-f1e5-08d8d1ae17d1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2021 12:34:53.2421 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PhXMp41ymn3bSexi1DbR2Z/WSpNCAiy3vV4UuHzJrw3lM4kPNnI8wJuh/al5TLbEBmev+kxnPl0rXqpqDHXyBg==
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

This also includes following debugfs file output changes:
1 amdgpu_evict_vram/amdgpu_evict_gtt output will not contain any braces.
  e.g. (0) --> 0
2 amdgpu_gpu_recover output will print return value of
  amdgpu_device_gpu_recover() instead of not so important "gpu recover"
  message.

v2: * checkpatch.pl: use '0444' instead of S_IRUGO.
    * remove S_IFREG from mode.
    * remove mode variable.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h         |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 155 +++++++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h |  14 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   |  46 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c     |  22 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c      |  23 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c     |  24 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h  |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     | 131 +++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |   2 +-
 10 files changed, 205 insertions(+), 217 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index e3d4d2dcb3a0..9bf7f494699d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -795,8 +795,7 @@ struct amdgpu_device {
 	bool				accel_working;
 	struct notifier_block		acpi_nb;
 	struct amdgpu_i2c_chan		*i2c_bus[AMDGPU_MAX_I2C_BUS];
-	struct amdgpu_debugfs		debugfs[AMDGPU_DEBUGFS_MAX_COMPONENTS];
-	unsigned			debugfs_count;
+	struct debugfs_blob_wrapper     debugfs_vbios_blob;
 	struct amdgpu_atif		*atif;
 	struct amdgpu_atcs		atcs;
 	struct mutex			srbm_mutex;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 719ae65ad633..8d14e5129886 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -28,7 +28,6 @@
 #include <linux/uaccess.h>
 #include <linux/pm_runtime.h>
 #include <linux/poll.h>
-#include <drm/drm_debugfs.h>
 
 #include "amdgpu.h"
 #include "amdgpu_pm.h"
@@ -38,45 +37,6 @@
 #include "amdgpu_securedisplay.h"
 #include "amdgpu_fw_attestation.h"
 
-/**
- * amdgpu_debugfs_add_files - Add simple debugfs entries
- *
- * @adev:  Device to attach debugfs entries to
- * @files:  Array of function callbacks that respond to reads
- * @nfiles: Number of callbacks to register
- *
- */
-int amdgpu_debugfs_add_files(struct amdgpu_device *adev,
-			     const struct drm_info_list *files,
-			     unsigned nfiles)
-{
-	unsigned i;
-
-	for (i = 0; i < adev->debugfs_count; i++) {
-		if (adev->debugfs[i].files == files) {
-			/* Already registered */
-			return 0;
-		}
-	}
-
-	i = adev->debugfs_count + 1;
-	if (i > AMDGPU_DEBUGFS_MAX_COMPONENTS) {
-		DRM_ERROR("Reached maximum number of debugfs components.\n");
-		DRM_ERROR("Report so we increase "
-			  "AMDGPU_DEBUGFS_MAX_COMPONENTS.\n");
-		return -EINVAL;
-	}
-	adev->debugfs[adev->debugfs_count].files = files;
-	adev->debugfs[adev->debugfs_count].num_files = nfiles;
-	adev->debugfs_count = i;
-#if defined(CONFIG_DEBUG_FS)
-	drm_debugfs_create_files(files, nfiles,
-				 adev_to_drm(adev)->primary->debugfs_root,
-				 adev_to_drm(adev)->primary);
-#endif
-	return 0;
-}
-
 int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev)
 {
 #if defined(CONFIG_DEBUG_FS)
@@ -1233,16 +1193,15 @@ int amdgpu_debugfs_regs_init(struct amdgpu_device *adev)
 	return 0;
 }
 
-static int amdgpu_debugfs_test_ib(struct seq_file *m, void *data)
+static int amdgpu_debugfs_test_ib_show(struct seq_file *m, void *unused)
 {
-	struct drm_info_node *node = (struct drm_info_node *) m->private;
-	struct drm_device *dev = node->minor->dev;
-	struct amdgpu_device *adev = drm_to_adev(dev);
+	struct amdgpu_device *adev = (struct amdgpu_device *)m->private;
+	struct drm_device *dev = adev_to_drm(adev);
 	int r = 0, i;
 
 	r = pm_runtime_get_sync(dev->dev);
 	if (r < 0) {
-		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+		pm_runtime_put_autosuspend(dev->dev);
 		return r;
 	}
 
@@ -1284,30 +1243,19 @@ static int amdgpu_debugfs_test_ib(struct seq_file *m, void *data)
 	return 0;
 }
 
-static int amdgpu_debugfs_get_vbios_dump(struct seq_file *m, void *data)
-{
-	struct drm_info_node *node = (struct drm_info_node *) m->private;
-	struct drm_device *dev = node->minor->dev;
-	struct amdgpu_device *adev = drm_to_adev(dev);
-
-	seq_write(m, adev->bios, adev->bios_size);
-	return 0;
-}
-
-static int amdgpu_debugfs_evict_vram(struct seq_file *m, void *data)
+static int amdgpu_debugfs_evict_vram(void *data, u64 *val)
 {
-	struct drm_info_node *node = (struct drm_info_node *)m->private;
-	struct drm_device *dev = node->minor->dev;
-	struct amdgpu_device *adev = drm_to_adev(dev);
+	struct amdgpu_device *adev = (struct amdgpu_device *)data;
+	struct drm_device *dev = adev_to_drm(adev);
 	int r;
 
 	r = pm_runtime_get_sync(dev->dev);
 	if (r < 0) {
-		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+		pm_runtime_put_autosuspend(dev->dev);
 		return r;
 	}
 
-	seq_printf(m, "(%d)\n", amdgpu_bo_evict_vram(adev));
+	*val = amdgpu_bo_evict_vram(adev);
 
 	pm_runtime_mark_last_busy(dev->dev);
 	pm_runtime_put_autosuspend(dev->dev);
@@ -1315,11 +1263,11 @@ static int amdgpu_debugfs_evict_vram(struct seq_file *m, void *data)
 	return 0;
 }
 
-static int amdgpu_debugfs_evict_gtt(struct seq_file *m, void *data)
+
+static int amdgpu_debugfs_evict_gtt(void *data, u64 *val)
 {
-	struct drm_info_node *node = (struct drm_info_node *)m->private;
-	struct drm_device *dev = node->minor->dev;
-	struct amdgpu_device *adev = drm_to_adev(dev);
+	struct amdgpu_device *adev = (struct amdgpu_device *)data;
+	struct drm_device *dev = adev_to_drm(adev);
 	int r;
 
 	r = pm_runtime_get_sync(dev->dev);
@@ -1328,7 +1276,7 @@ static int amdgpu_debugfs_evict_gtt(struct seq_file *m, void *data)
 		return r;
 	}
 
-	seq_printf(m, "(%d)\n", ttm_bo_evict_mm(&adev->mman.bdev, TTM_PL_TT));
+	*val = ttm_bo_evict_mm(&adev->mman.bdev, TTM_PL_TT);
 
 	pm_runtime_mark_last_busy(dev->dev);
 	pm_runtime_put_autosuspend(dev->dev);
@@ -1336,10 +1284,11 @@ static int amdgpu_debugfs_evict_gtt(struct seq_file *m, void *data)
 	return 0;
 }
 
-static int amdgpu_debugfs_vm_info(struct seq_file *m, void *data)
+
+static int amdgpu_debugfs_vm_info_show(struct seq_file *m, void *unused)
 {
-	struct drm_info_node *node = (struct drm_info_node *)m->private;
-	struct drm_device *dev = node->minor->dev;
+	struct amdgpu_device *adev = (struct amdgpu_device *)m->private;
+	struct drm_device *dev = adev_to_drm(adev);
 	struct drm_file *file;
 	int r;
 
@@ -1365,13 +1314,12 @@ static int amdgpu_debugfs_vm_info(struct seq_file *m, void *data)
 	return r;
 }
 
-static const struct drm_info_list amdgpu_debugfs_list[] = {
-	{"amdgpu_vbios", amdgpu_debugfs_get_vbios_dump},
-	{"amdgpu_test_ib", &amdgpu_debugfs_test_ib},
-	{"amdgpu_evict_vram", &amdgpu_debugfs_evict_vram},
-	{"amdgpu_evict_gtt", &amdgpu_debugfs_evict_gtt},
-	{"amdgpu_vm_info", &amdgpu_debugfs_vm_info},
-};
+DEFINE_SHOW_ATTRIBUTE(amdgpu_debugfs_test_ib);
+DEFINE_SHOW_ATTRIBUTE(amdgpu_debugfs_vm_info);
+DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_evict_vram_fops, amdgpu_debugfs_evict_vram,
+			 NULL, "%lld\n");
+DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_evict_gtt_fops, amdgpu_debugfs_evict_gtt,
+			 NULL, "%lld\n");
 
 static void amdgpu_ib_preempt_fences_swap(struct amdgpu_ring *ring,
 					  struct dma_fence **fences)
@@ -1590,19 +1538,20 @@ DEFINE_SIMPLE_ATTRIBUTE(fops_sclk_set, NULL,
 
 int amdgpu_debugfs_init(struct amdgpu_device *adev)
 {
+	struct dentry *root = adev_to_drm(adev)->primary->debugfs_root;
 	struct dentry *ent;
 	int r, i;
 
-	ent = debugfs_create_file("amdgpu_preempt_ib", 0600,
-				  adev_to_drm(adev)->primary->debugfs_root, adev,
+
+
+	ent = debugfs_create_file("amdgpu_preempt_ib", 0600, root, adev,
 				  &fops_ib_preempt);
 	if (!ent) {
 		DRM_ERROR("unable to create amdgpu_preempt_ib debugsfs file\n");
 		return -EIO;
 	}
 
-	ent = debugfs_create_file("amdgpu_force_sclk", 0200,
-				  adev_to_drm(adev)->primary->debugfs_root, adev,
+	ent = debugfs_create_file("amdgpu_force_sclk", 0200, root, adev,
 				  &fops_sclk_set);
 	if (!ent) {
 		DRM_ERROR("unable to create amdgpu_set_sclk debugsfs file\n");
@@ -1610,32 +1559,17 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 	}
 
 	/* Register debugfs entries for amdgpu_ttm */
-	r = amdgpu_ttm_debugfs_init(adev);
-	if (r) {
-		DRM_ERROR("Failed to init debugfs\n");
-		return r;
-	}
-
+	amdgpu_ttm_debugfs_init(adev);
 	amdgpu_debugfs_pm_init(adev);
-
-	if (amdgpu_debugfs_sa_init(adev)) {
-		dev_err(adev->dev, "failed to register debugfs file for SA\n");
-	}
-
-	if (amdgpu_debugfs_fence_init(adev))
-		dev_err(adev->dev, "fence debugfs file creation failed\n");
-
-	r = amdgpu_debugfs_gem_init(adev);
-	if (r)
-		DRM_ERROR("registering gem debugfs failed (%d).\n", r);
+	amdgpu_debugfs_sa_init(adev);
+	amdgpu_debugfs_fence_init(adev);
+	amdgpu_debugfs_gem_init(adev);
 
 	r = amdgpu_debugfs_regs_init(adev);
 	if (r)
 		DRM_ERROR("registering register debugfs failed (%d).\n", r);
 
-	r = amdgpu_debugfs_firmware_init(adev);
-	if (r)
-		DRM_ERROR("registering firmware debugfs failed (%d).\n", r);
+	amdgpu_debugfs_firmware_init(adev);
 
 #if defined(CONFIG_DRM_AMD_DC)
 	if (amdgpu_device_has_dc_support(adev))
@@ -1654,17 +1588,26 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 	}
 
 	amdgpu_ras_debugfs_create_all(adev);
-
 	amdgpu_debugfs_autodump_init(adev);
-
 	amdgpu_rap_debugfs_init(adev);
-
 	amdgpu_securedisplay_debugfs_init(adev);
-
 	amdgpu_fw_attestation_debugfs_init(adev);
 
-	return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_list,
-					ARRAY_SIZE(amdgpu_debugfs_list));
+	debugfs_create_file("amdgpu_evict_vram", 0444, root, adev,
+			    &amdgpu_evict_vram_fops);
+	debugfs_create_file("amdgpu_evict_gtt", 0444, root, adev,
+			    &amdgpu_evict_gtt_fops);
+	debugfs_create_file("amdgpu_test_ib", 0444, root, adev,
+			    &amdgpu_debugfs_test_ib_fops);
+	debugfs_create_file("amdgpu_vm_info", 0444, root, adev,
+			    &amdgpu_debugfs_vm_info_fops);
+
+	adev->debugfs_vbios_blob.data = adev->bios;
+	adev->debugfs_vbios_blob.size = adev->bios_size;
+	debugfs_create_blob("amdgpu_vbios", 0444, root,
+			    &adev->debugfs_vbios_blob);
+
+	return 0;
 }
 
 #else
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
index 2803884d338d..141a8474e24f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
@@ -26,11 +26,6 @@
 /*
  * Debugfs
  */
-struct amdgpu_debugfs {
-	const struct drm_info_list	*files;
-	unsigned		num_files;
-};
-
 struct amdgpu_autodump {
 	struct completion		dumping;
 	struct wait_queue_head		gpu_hang;
@@ -39,10 +34,7 @@ struct amdgpu_autodump {
 int amdgpu_debugfs_regs_init(struct amdgpu_device *adev);
 int amdgpu_debugfs_init(struct amdgpu_device *adev);
 void amdgpu_debugfs_fini(struct amdgpu_device *adev);
-int amdgpu_debugfs_add_files(struct amdgpu_device *adev,
-			     const struct drm_info_list *files,
-			     unsigned nfiles);
-int amdgpu_debugfs_fence_init(struct amdgpu_device *adev);
-int amdgpu_debugfs_firmware_init(struct amdgpu_device *adev);
-int amdgpu_debugfs_gem_init(struct amdgpu_device *adev);
+void amdgpu_debugfs_fence_init(struct amdgpu_device *adev);
+void amdgpu_debugfs_firmware_init(struct amdgpu_device *adev);
+void amdgpu_debugfs_gem_init(struct amdgpu_device *adev);
 int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index d56f4023ebb3..143a14f4866f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -36,8 +36,6 @@
 #include <linux/firmware.h>
 #include <linux/pm_runtime.h>
 
-#include <drm/drm_debugfs.h>
-
 #include "amdgpu.h"
 #include "amdgpu_trace.h"
 
@@ -697,11 +695,9 @@ static const struct dma_fence_ops amdgpu_fence_ops = {
  * Fence debugfs
  */
 #if defined(CONFIG_DEBUG_FS)
-static int amdgpu_debugfs_fence_info(struct seq_file *m, void *data)
+static int amdgpu_debugfs_fence_info_show(struct seq_file *m, void *unused)
 {
-	struct drm_info_node *node = (struct drm_info_node *)m->private;
-	struct drm_device *dev = node->minor->dev;
-	struct amdgpu_device *adev = drm_to_adev(dev);
+	struct amdgpu_device *adev = (struct amdgpu_device *)m->private;
 	int i;
 
 	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
@@ -746,11 +742,10 @@ static int amdgpu_debugfs_fence_info(struct seq_file *m, void *data)
  *
  * Manually trigger a gpu reset at the next fence wait.
  */
-static int amdgpu_debugfs_gpu_recover(struct seq_file *m, void *data)
+static int gpu_recover_get(void *data, u64 *val)
 {
-	struct drm_info_node *node = (struct drm_info_node *) m->private;
-	struct drm_device *dev = node->minor->dev;
-	struct amdgpu_device *adev = drm_to_adev(dev);
+	struct amdgpu_device *adev = (struct amdgpu_device *)data;
+	struct drm_device *dev = adev_to_drm(adev);
 	int r;
 
 	r = pm_runtime_get_sync(dev->dev);
@@ -759,8 +754,7 @@ static int amdgpu_debugfs_gpu_recover(struct seq_file *m, void *data)
 		return 0;
 	}
 
-	seq_printf(m, "gpu recover\n");
-	amdgpu_device_gpu_recover(adev, NULL);
+	*val = amdgpu_device_gpu_recover(adev, NULL);
 
 	pm_runtime_mark_last_busy(dev->dev);
 	pm_runtime_put_autosuspend(dev->dev);
@@ -768,26 +762,24 @@ static int amdgpu_debugfs_gpu_recover(struct seq_file *m, void *data)
 	return 0;
 }
 
-static const struct drm_info_list amdgpu_debugfs_fence_list[] = {
-	{"amdgpu_fence_info", &amdgpu_debugfs_fence_info, 0, NULL},
-	{"amdgpu_gpu_recover", &amdgpu_debugfs_gpu_recover, 0, NULL}
-};
+DEFINE_SHOW_ATTRIBUTE(amdgpu_debugfs_fence_info);
+DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_debugfs_gpu_recover_fops, gpu_recover_get, NULL,
+			 "%lld\n");
 
-static const struct drm_info_list amdgpu_debugfs_fence_list_sriov[] = {
-	{"amdgpu_fence_info", &amdgpu_debugfs_fence_info, 0, NULL},
-};
 #endif
 
-int amdgpu_debugfs_fence_init(struct amdgpu_device *adev)
+void amdgpu_debugfs_fence_init(struct amdgpu_device *adev)
 {
 #if defined(CONFIG_DEBUG_FS)
-	if (amdgpu_sriov_vf(adev))
-		return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_fence_list_sriov,
-						ARRAY_SIZE(amdgpu_debugfs_fence_list_sriov));
-	return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_fence_list,
-					ARRAY_SIZE(amdgpu_debugfs_fence_list));
-#else
-	return 0;
+	struct drm_minor *minor = adev_to_drm(adev)->primary;
+	struct dentry *root = minor->debugfs_root;
+
+	debugfs_create_file("amdgpu_fence_info", 0444, root, adev,
+			    &amdgpu_debugfs_fence_info_fops);
+
+	if (!amdgpu_sriov_vf(adev))
+		debugfs_create_file("amdgpu_gpu_recover", 0444, root, adev,
+				    &amdgpu_debugfs_gpu_recover_fops);
 #endif
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 5b50860eece4..8e9b8a6e6ef0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -32,7 +32,6 @@
 #include <linux/dma-buf.h>
 
 #include <drm/amdgpu_drm.h>
-#include <drm/drm_debugfs.h>
 
 #include "amdgpu.h"
 #include "amdgpu_display.h"
@@ -836,10 +835,10 @@ int amdgpu_mode_dumb_create(struct drm_file *file_priv,
 }
 
 #if defined(CONFIG_DEBUG_FS)
-static int amdgpu_debugfs_gem_info(struct seq_file *m, void *data)
+static int amdgpu_debugfs_gem_info_show(struct seq_file *m, void *unused)
 {
-	struct drm_info_node *node = (struct drm_info_node *)m->private;
-	struct drm_device *dev = node->minor->dev;
+	struct amdgpu_device *adev = (struct amdgpu_device *)m->private;
+	struct drm_device *dev = adev_to_drm(adev);
 	struct drm_file *file;
 	int r;
 
@@ -877,16 +876,17 @@ static int amdgpu_debugfs_gem_info(struct seq_file *m, void *data)
 	return 0;
 }
 
-static const struct drm_info_list amdgpu_debugfs_gem_list[] = {
-	{"amdgpu_gem_info", &amdgpu_debugfs_gem_info, 0, NULL},
-};
+DEFINE_SHOW_ATTRIBUTE(amdgpu_debugfs_gem_info);
+
 #endif
 
-int amdgpu_debugfs_gem_init(struct amdgpu_device *adev)
+void amdgpu_debugfs_gem_init(struct amdgpu_device *adev)
 {
 #if defined(CONFIG_DEBUG_FS)
-	return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_gem_list,
-					ARRAY_SIZE(amdgpu_debugfs_gem_list));
+	struct drm_minor *minor = adev_to_drm(adev)->primary;
+	struct dentry *root = minor->debugfs_root;
+
+	debugfs_create_file("amdgpu_gem_info", 0444, root, adev,
+			    &amdgpu_debugfs_gem_info_fops);
 #endif
-	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 7645223ea0ef..148a3b481b12 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -30,7 +30,6 @@
 #include <linux/slab.h>
 
 #include <drm/amdgpu_drm.h>
-#include <drm/drm_debugfs.h>
 
 #include "amdgpu.h"
 #include "atom.h"
@@ -453,11 +452,9 @@ int amdgpu_ib_ring_tests(struct amdgpu_device *adev)
  */
 #if defined(CONFIG_DEBUG_FS)
 
-static int amdgpu_debugfs_sa_info(struct seq_file *m, void *data)
+static int amdgpu_debugfs_sa_info_show(struct seq_file *m, void *unused)
 {
-	struct drm_info_node *node = (struct drm_info_node *) m->private;
-	struct drm_device *dev = node->minor->dev;
-	struct amdgpu_device *adev = drm_to_adev(dev);
+	struct amdgpu_device *adev = (struct amdgpu_device *)m->private;
 
 	seq_printf(m, "--------------------- DELAYED --------------------- \n");
 	amdgpu_sa_bo_dump_debug_info(&adev->ib_pools[AMDGPU_IB_POOL_DELAYED],
@@ -471,18 +468,18 @@ static int amdgpu_debugfs_sa_info(struct seq_file *m, void *data)
 	return 0;
 }
 
-static const struct drm_info_list amdgpu_debugfs_sa_list[] = {
-	{"amdgpu_sa_info", &amdgpu_debugfs_sa_info, 0, NULL},
-};
+DEFINE_SHOW_ATTRIBUTE(amdgpu_debugfs_sa_info);
 
 #endif
 
-int amdgpu_debugfs_sa_init(struct amdgpu_device *adev)
+void amdgpu_debugfs_sa_init(struct amdgpu_device *adev)
 {
 #if defined(CONFIG_DEBUG_FS)
-	return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_sa_list,
-					ARRAY_SIZE(amdgpu_debugfs_sa_list));
-#else
-	return 0;
+	struct drm_minor *minor = adev_to_drm(adev)->primary;
+	struct dentry *root = minor->debugfs_root;
+
+	debugfs_create_file("amdgpu_sa_info", 0444, root, adev,
+			    &amdgpu_debugfs_sa_info_fops);
+
 #endif
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index e365c4fdcfe3..47ca20394d6b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -27,7 +27,6 @@
  */
 
 #include "amdgpu.h"
-#include <drm/drm_debugfs.h>
 #include <drm/amdgpu_drm.h>
 #include "amdgpu_sched.h"
 #include "amdgpu_uvd.h"
@@ -1287,11 +1286,9 @@ const int amdgpu_max_kms_ioctl = ARRAY_SIZE(amdgpu_ioctls_kms);
  */
 #if defined(CONFIG_DEBUG_FS)
 
-static int amdgpu_debugfs_firmware_info(struct seq_file *m, void *data)
+static int amdgpu_debugfs_firmware_info_show(struct seq_file *m, void *unused)
 {
-	struct drm_info_node *node = (struct drm_info_node *) m->private;
-	struct drm_device *dev = node->minor->dev;
-	struct amdgpu_device *adev = drm_to_adev(dev);
+	struct amdgpu_device *adev = (struct amdgpu_device *)m->private;
 	struct drm_amdgpu_info_firmware fw_info;
 	struct drm_amdgpu_query_fw query_fw;
 	struct atom_context *ctx = adev->mode_info.atom_context;
@@ -1497,17 +1494,18 @@ static int amdgpu_debugfs_firmware_info(struct seq_file *m, void *data)
 	return 0;
 }
 
-static const struct drm_info_list amdgpu_firmware_info_list[] = {
-	{"amdgpu_firmware_info", amdgpu_debugfs_firmware_info, 0, NULL},
-};
+DEFINE_SHOW_ATTRIBUTE(amdgpu_debugfs_firmware_info);
+
 #endif
 
-int amdgpu_debugfs_firmware_init(struct amdgpu_device *adev)
+void amdgpu_debugfs_firmware_init(struct amdgpu_device *adev)
 {
 #if defined(CONFIG_DEBUG_FS)
-	return amdgpu_debugfs_add_files(adev, amdgpu_firmware_info_list,
-					ARRAY_SIZE(amdgpu_firmware_info_list));
-#else
-	return 0;
+	struct drm_minor *minor = adev_to_drm(adev)->primary;
+	struct dentry *root = minor->debugfs_root;
+
+	debugfs_create_file("amdgpu_firmware_info", 0444, root,
+			    adev, &amdgpu_debugfs_firmware_info_fops);
+
 #endif
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index adbefd6a655d..192627d35bae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -331,7 +331,7 @@ void amdgpu_sa_bo_dump_debug_info(struct amdgpu_sa_manager *sa_manager,
 					 struct seq_file *m);
 u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct seq_file *m);
 #endif
-int amdgpu_debugfs_sa_init(struct amdgpu_device *adev);
+void amdgpu_debugfs_sa_init(struct amdgpu_device *adev);
 
 bool amdgpu_bo_support_uswc(u64 bo_flags);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index ce92768cd146..7b2db779f313 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -49,7 +49,6 @@
 #include <drm/ttm/ttm_module.h>
 #include <drm/ttm/ttm_page_alloc.h>
 
-#include <drm/drm_debugfs.h>
 #include <drm/amdgpu_drm.h>
 
 #include "amdgpu.h"
@@ -2253,30 +2252,66 @@ int amdgpu_fill_buffer(struct amdgpu_bo *bo,
 
 #if defined(CONFIG_DEBUG_FS)
 
-static int amdgpu_mm_dump_table(struct seq_file *m, void *data)
+static int amdgpu_mm_vram_table_show(struct seq_file *m, void *unused)
 {
-	struct drm_info_node *node = (struct drm_info_node *)m->private;
-	unsigned ttm_pl = (uintptr_t)node->info_ent->data;
-	struct drm_device *dev = node->minor->dev;
-	struct amdgpu_device *adev = drm_to_adev(dev);
-	struct ttm_resource_manager *man = ttm_manager_type(&adev->mman.bdev, ttm_pl);
+	struct amdgpu_device *adev = (struct amdgpu_device *)m->private;
+	struct ttm_resource_manager *man = ttm_manager_type(&adev->mman.bdev,
+							    TTM_PL_VRAM);
 	struct drm_printer p = drm_seq_file_printer(m);
 
 	man->func->debug(man, &p);
 	return 0;
 }
 
-static const struct drm_info_list amdgpu_ttm_debugfs_list[] = {
-	{"amdgpu_vram_mm", amdgpu_mm_dump_table, 0, (void *)TTM_PL_VRAM},
-	{"amdgpu_gtt_mm", amdgpu_mm_dump_table, 0, (void *)TTM_PL_TT},
-	{"amdgpu_gds_mm", amdgpu_mm_dump_table, 0, (void *)AMDGPU_PL_GDS},
-	{"amdgpu_gws_mm", amdgpu_mm_dump_table, 0, (void *)AMDGPU_PL_GWS},
-	{"amdgpu_oa_mm", amdgpu_mm_dump_table, 0, (void *)AMDGPU_PL_OA},
-	{"ttm_page_pool", ttm_page_alloc_debugfs, 0, NULL},
-#ifdef CONFIG_SWIOTLB
-	{"ttm_dma_page_pool", ttm_dma_page_alloc_debugfs, 0, NULL}
-#endif
-};
+static int amdgpu_mm_tt_table_show(struct seq_file *m, void *unused)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)m->private;
+	struct ttm_resource_manager *man = ttm_manager_type(&adev->mman.bdev,
+							    TTM_PL_TT);
+	struct drm_printer p = drm_seq_file_printer(m);
+
+	man->func->debug(man, &p);
+	return 0;
+}
+
+static int amdgpu_mm_gds_table_show(struct seq_file *m, void *unused)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)m->private;
+	struct ttm_resource_manager *man = ttm_manager_type(&adev->mman.bdev,
+							    AMDGPU_PL_GDS);
+	struct drm_printer p = drm_seq_file_printer(m);
+
+	man->func->debug(man, &p);
+	return 0;
+}
+
+static int amdgpu_mm_gws_table_show(struct seq_file *m, void *unused)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)m->private;
+	struct ttm_resource_manager *man = ttm_manager_type(&adev->mman.bdev,
+							    AMDGPU_PL_GWS);
+	struct drm_printer p = drm_seq_file_printer(m);
+
+	man->func->debug(man, &p);
+	return 0;
+}
+
+static int amdgpu_mm_oa_table_show(struct seq_file *m, void *unused)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)m->private;
+	struct ttm_resource_manager *man = ttm_manager_type(&adev->mman.bdev,
+							    AMDGPU_PL_OA);
+	struct drm_printer p = drm_seq_file_printer(m);
+
+	man->func->debug(man, &p);
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(amdgpu_mm_vram_table);
+DEFINE_SHOW_ATTRIBUTE(amdgpu_mm_tt_table);
+DEFINE_SHOW_ATTRIBUTE(amdgpu_mm_gds_table);
+DEFINE_SHOW_ATTRIBUTE(amdgpu_mm_gws_table);
+DEFINE_SHOW_ATTRIBUTE(amdgpu_mm_oa_table);
 
 /*
  * amdgpu_ttm_vram_read - Linear read access to VRAM
@@ -2478,30 +2513,62 @@ static const struct file_operations amdgpu_ttm_iomem_fops = {
 	.llseek = default_llseek
 };
 
+static int amdgpu_ttm_page_debugfs_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, ttm_page_alloc_debugfs, inode->i_private);
+}
+
+static const struct file_operations amdgpu_ttm_page_debugfs_fops = {
+	.owner = THIS_MODULE,
+	.open = amdgpu_ttm_page_debugfs_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
+#ifdef CONFIG_SWIOTLB
+static int amdgpu_ttm_dma_page_debugfs_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, ttm_dma_page_alloc_debugfs, inode->i_private);
+}
+
+static const struct file_operations amdgpu_ttm_dma_page_debugfs_fops = {
+	.owner = THIS_MODULE,
+	.open = amdgpu_ttm_dma_page_debugfs_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
 #endif
 
-int amdgpu_ttm_debugfs_init(struct amdgpu_device *adev)
+#endif
+
+void amdgpu_ttm_debugfs_init(struct amdgpu_device *adev)
 {
 #if defined(CONFIG_DEBUG_FS)
-	unsigned count;
-
 	struct drm_minor *minor = adev_to_drm(adev)->primary;
-	umode_t mode = S_IFREG | S_IRUGO;
 	struct dentry *root = minor->debugfs_root;
 
-	debugfs_create_file_size("amdgpu_vram", mode, root, adev,
+	debugfs_create_file_size("amdgpu_vram", 0444, root, adev,
 				 &amdgpu_ttm_vram_fops, adev->gmc.mc_vram_size);
-	debugfs_create_file("amdgpu_iomem", mode, root, adev,
+	debugfs_create_file("amdgpu_iomem", 0444, root, adev,
 			    &amdgpu_ttm_iomem_fops);
-	count = ARRAY_SIZE(amdgpu_ttm_debugfs_list);
-
+	debugfs_create_file("amdgpu_vram_mm", 0444, root, adev,
+			    &amdgpu_mm_vram_table_fops);
+	debugfs_create_file("amdgpu_gtt_mm", 0444, root, adev,
+			    &amdgpu_mm_tt_table_fops);
+	debugfs_create_file("amdgpu_gds_mm", 0444, root, adev,
+			    &amdgpu_mm_gds_table_fops);
+	debugfs_create_file("amdgpu_gws_mm", 0444, root, adev,
+			    &amdgpu_mm_gws_table_fops);
+	debugfs_create_file("amdgpu_oa_mm", 0444, root, adev,
+			    &amdgpu_mm_oa_table_fops);
+	debugfs_create_file("ttm_page_pool", 0444, root, adev,
+			    &amdgpu_ttm_page_debugfs_fops);
 #ifdef CONFIG_SWIOTLB
-	if (!(adev->need_swiotlb && swiotlb_nr_tbl()))
-		--count;
+	if ((adev->need_swiotlb && swiotlb_nr_tbl()))
+		debugfs_create_file("ttm_dma_page_pool", 0444, root, adev,
+				    &amdgpu_ttm_dma_page_debugfs_fops);
 #endif
-
-	return amdgpu_debugfs_add_files(adev, amdgpu_ttm_debugfs_list, count);
-#else
-	return 0;
 #endif
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index 4df4cf2fd4dd..69ba8dd4f3ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -186,6 +186,6 @@ uint64_t amdgpu_ttm_tt_pde_flags(struct ttm_tt *ttm, struct ttm_resource *mem);
 uint64_t amdgpu_ttm_tt_pte_flags(struct amdgpu_device *adev, struct ttm_tt *ttm,
 				 struct ttm_resource *mem);
 
-int amdgpu_ttm_debugfs_init(struct amdgpu_device *adev);
+void amdgpu_ttm_debugfs_init(struct amdgpu_device *adev);
 
 #endif
-- 
2.30.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
