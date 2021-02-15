Return-Path: <SRS0=jhpT=HR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E299C433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Feb 2021 10:17:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA6AC64D73
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Feb 2021 10:17:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA6AC64D73
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 661CD89C83;
	Mon, 15 Feb 2021 10:17:13 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EC6889C83
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Feb 2021 10:17:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UtIX+s4NhoEYA/0f358vPOFiGmYZzIGUc2ophMkTrI622YL5fb6/3IA5y5Ng2RxmhwFDMBxYU25DWp8w6PJ1h+9nLfEBUdyANpx4mMLkMk11aDlAlJ2ftHCjj0bxBmsqCu0XUpMcvkhpFySjtVzV/VjeYIOAPmsNcDFgMzcPhaM1WXK0AhtvHrcrzuh8VZ5c0IMrnsHs2/yY4nO+nl1ofRnmBijM6MDCr2+5WxfEvlEsWYcCFXCLavtjhrrPaliTcK+JaVg3Ezrzsk7h+vCvzGBKVJG4WQB7BFml+xmz4Qsj0u4IldEV7TtfE6TDKc78Mo5KKlD9Q3qtz6mE67yFMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SktMLLcgFA7v5/0Vbb1fPaaDmAim8Tblk5/4NbmqOo4=;
 b=X76saIY7rWmzGzGzI9IowkngeX+E/yciKKlNpE8SCPVO5SM3mFXC+krus7dpdZMs6X4Kl0nsY4rgazvFNdQsCUjFN8+hxALd1HvYtpnqwpdR+nwSgyEBF63oQ5tcXWwL1Nw5/QPVsbTK5hBqGB8UyZ6SdT7a9k/uOMc81VL7xjsIsgS8IO1uvMTS6CfQcmnxqdxJ21uO3aEothixJn3J+MgrrVYx8xhh6KDaQCmm9fWAA4dmknqWxxhM4TOmCi497os+W9WcYTLz5UIDfpJYCHGsph50ljG5r+G54vgwvVpxrV/0hqcDcHJCTErQctqEe3MOlSvO87HTCWzH9Au6Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SktMLLcgFA7v5/0Vbb1fPaaDmAim8Tblk5/4NbmqOo4=;
 b=nHDM1n7Fseq/Yd1DyrZre/NEVnYRCu82WJlIspvjwv7sSsE+TUaikuD2B7cMc3BGyCuyrXgZoI34jnFuaNb8Kggwf8PTZXg0sc3Ao2maadmRI66kZYPymG2UW9fmRnTwgJsk3U5a5dEsumdUHq1Kc4KvqgwuqUrJnXOulaDAwHM=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB2970.namprd12.prod.outlook.com (2603:10b6:5:3b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.31; Mon, 15 Feb
 2021 10:17:09 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::452c:77af:fea7:a633]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::452c:77af:fea7:a633%6]) with mapi id 15.20.3846.039; Mon, 15 Feb 2021
 10:17:09 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: Christian.Koenig@amd.com
Subject: [PATCH 2/3] drm/amd/pm: do not use drm middle layer for debugfs
Date: Mon, 15 Feb 2021 11:16:52 +0100
Message-Id: <20210215101653.35694-2-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210215101653.35694-1-nirmoy.das@amd.com>
References: <20210215101653.35694-1-nirmoy.das@amd.com>
X-Originating-IP: [93.229.46.81]
X-ClientProxiedBy: AM0PR10CA0082.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::35) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (93.229.46.81) by
 AM0PR10CA0082.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.26 via Frontend Transport; Mon, 15 Feb 2021 10:17:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 954c2f58-9d65-4f5d-0f05-08d8d19ada7f
X-MS-TrafficTypeDiagnostic: DM6PR12MB2970:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2970D54BB6BAF5B1C8805ADC8B889@DM6PR12MB2970.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8x28PgJEH3cOXVrWBH2XerL7q3LyE9VklMbrQgvttveO01gU9l1P/Is8gNEJkIwe1ByT9MblV86IdQ4IUQ6XAwEttZVNztdm4HCf9RPHKhgJ2I4ZcNjDeTttnUrAapJFiJExrQxzu6NsxpVK/KmAuQzAikKieW5MCUuuIsNVa/2CbQh6/6d9e7SKCZibX+ZdnrBSjLyNcS5zvms+rq2jKsvunuFDqBmdK9rxngsRxO/jjH2iuX08lmI4/T4zK74vjBW44IN/tjSiSh54ZL+o9SJ0O3+uflF17bokUQ16D659ThohwFyFEtWKGGibjVQdUSsnpH1qFIAi0lXfBUrsBbvaSkYkUv6AZxo8SPxfy27iXxNEmGDB/MmUyGadBCWAQsXbiUBeQnXyi74/gtd91O+nPIdv6tQ7xbrwIot20kxU/rvQU2WCoQOW/sVZYwWc7HUQbT3bjYjIfqER2dJRZneSNI9aj1VRhpZyxFcemCkm/JHu1NHVDRc8f7O7+g3D4AU14KSiBBe1XlEMUiGGKg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(366004)(396003)(346002)(136003)(16526019)(6636002)(6512007)(2616005)(5660300002)(1076003)(186003)(44832011)(2906002)(478600001)(956004)(4326008)(26005)(34206002)(86362001)(36756003)(6486002)(66946007)(66476007)(6506007)(6666004)(8676002)(83380400001)(66556008)(316002)(52116002)(8936002)(37006003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?R24RKoCB6Q8rONfMk+ssu2/54J087zCcYKQxq6l7YuR/jQrJ7iXE1xxXFqdX?=
 =?us-ascii?Q?4gpyBhYK6+umF41C6sR8vPywdDqXyX8YOwNlC1uru5Msd1N12nzmOsFlu2I2?=
 =?us-ascii?Q?AAC40hTO90Ntn+I8rnWe9fDNsVvE81mfRwFwL6tEKcS4jgbr9hwkFsUfok77?=
 =?us-ascii?Q?Az2CwroD9ui1r9Hqau0B5XBqkaAETPyC3ak/CnY2UwRsfzQGGRgiOP64ekOr?=
 =?us-ascii?Q?MpU8e2cr9fPrgwgOi+BZ19gVFEjDxfSgJcgYZobddboTtl62OmRPHg7sY72e?=
 =?us-ascii?Q?N77xnHsYSzAQGlaZ+vyPzGY4o+ByL0rug3KzFmxerJhbNQzrKL+xyWSjlCx3?=
 =?us-ascii?Q?QXWBujD2WISLeu59agYvjz1yY2/g7Qe02As/FgzUKWAAiOjnGdPeX/+jjGL6?=
 =?us-ascii?Q?OsmQZWLxqatv/Mkp5E7qiFaLAMby5h8OXZD/6j/5kpLOeAyb5joNIeN0Lqbm?=
 =?us-ascii?Q?xdl62ivNNZYCd+Via5a73lE1EHJMQ8ipftPixUW1hfYvdGM5jv+0atwDKTtN?=
 =?us-ascii?Q?YO0k5fiR0j4iK0cudfrYEYjNdPvN8nT1HLSatqOAbRXpdrf0/9NKKNrxMcfr?=
 =?us-ascii?Q?MlYi3ZXSWszTt+8MoRt0x7WyPHqpafyOV7joiS99Lw5nz7OPzCsOMzDSpsWE?=
 =?us-ascii?Q?3bbJE6+EMVk51WKpYEWet9tPGXUqgZf93hoYf+Pb/q+svtov5K9l0Gl3Nemc?=
 =?us-ascii?Q?787+4kTRTxJjwQWatNvUIYEq0bHPd83O6Cc1tNL1n6LAC6lh2lyWZgHHlRxU?=
 =?us-ascii?Q?CjEBqiFJ8aiEiokJoRiLQM7u9IjEywEN5TkPAnkKQ2ivYZ9e+77uphdwydCi?=
 =?us-ascii?Q?dgVgzyLRvYteD+KOUYFkZmkEYaIsrIJSKh7oLPkR+2B8zY0saZXA0Uonbbyy?=
 =?us-ascii?Q?jE5BHJsbPHYhrOOVm8pRg0TZ2rxv1ah6bSDGnnA8I8i5gnsNCLw4S64y2t6w?=
 =?us-ascii?Q?G7kYIs/FtxoMSRt1sQLvS1SC1tjKw62VkovJeVq50WB175el11aNOp+QhX9r?=
 =?us-ascii?Q?No5t+sE2otivsqDRqKlD5V+RK8XEolF7RkIjcH+iAzRcNn5DyKygrcqiZM4g?=
 =?us-ascii?Q?mSZ7pd+8tPKSwaKMxEpwEk++moX2Z0y5sbilgP7y7UreK6jzIkRqMfi1O5tY?=
 =?us-ascii?Q?WmaiqIFMjIDeJ8lYCxxCctXWKEDA9yzkUIP0Gh79AKmZ35cz4Vpk9LEqCeZv?=
 =?us-ascii?Q?feaZRy0wysxCK/Fotb38SzS/P+EjhTBIHhBaZ9QV1A5m8TGXqUwVIl6G0tdv?=
 =?us-ascii?Q?kDErefz8IWsOF2OdLTjcxEjNv+gSc0m6PN4JepEkag+8uSVgEUlSTe7nn9TI?=
 =?us-ascii?Q?ZIEE6oSkdGniPCfV8ik5Lm3L?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 954c2f58-9d65-4f5d-0f05-08d8d19ada7f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2021 10:17:09.5493 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LBSwcrrT9IyY47QUpztMYvVd2k8uUa64J1BGIYCLLk4rPKAFLdBO5llGx1bhsBrW4cQsuLohJ7JLsdPp7JBVfg==
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  6 +----
 drivers/gpu/drm/amd/pm/amdgpu_pm.c          | 26 ++++++++++-----------
 drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h      |  2 +-
 3 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 60b2f2d4ca80..719ae65ad633 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1616,11 +1616,7 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 		return r;
 	}
 
-	r = amdgpu_debugfs_pm_init(adev);
-	if (r) {
-		DRM_ERROR("Failed to register debugfs file for dpm!\n");
-		return r;
-	}
+	amdgpu_debugfs_pm_init(adev);
 
 	if (amdgpu_debugfs_sa_init(adev)) {
 		dev_err(adev->dev, "failed to register debugfs file for SA\n");
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 5fa65f191a37..ded66f55cfdb 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -23,8 +23,6 @@
  *          Alex Deucher <alexdeucher@gmail.com>
  */
 
-#include <drm/drm_debugfs.h>
-
 #include "amdgpu.h"
 #include "amdgpu_drv.h"
 #include "amdgpu_pm.h"
@@ -3784,11 +3782,10 @@ static void amdgpu_parse_cg_state(struct seq_file *m, u32 flags)
 			   (flags & clocks[i].flag) ? "On" : "Off");
 }
 
-static int amdgpu_debugfs_pm_info(struct seq_file *m, void *data)
+static int amdgpu_debugfs_pm_info_show(struct seq_file *m, void *unused)
 {
-	struct drm_info_node *node = (struct drm_info_node *) m->private;
-	struct drm_device *dev = node->minor->dev;
-	struct amdgpu_device *adev = drm_to_adev(dev);
+	struct amdgpu_device *adev = (struct amdgpu_device *)m->private;
+	struct drm_device *dev = adev_to_drm(adev);
 	u32 flags = 0;
 	int r;
 
@@ -3836,16 +3833,19 @@ static int amdgpu_debugfs_pm_info(struct seq_file *m, void *data)
 	return r;
 }
 
-static const struct drm_info_list amdgpu_pm_info_list[] = {
-	{"amdgpu_pm_info", amdgpu_debugfs_pm_info, 0, NULL},
-};
+DEFINE_SHOW_ATTRIBUTE(amdgpu_debugfs_pm_info);
+
 #endif
 
-int amdgpu_debugfs_pm_init(struct amdgpu_device *adev)
+void amdgpu_debugfs_pm_init(struct amdgpu_device *adev)
 {
 #if defined(CONFIG_DEBUG_FS)
-	return amdgpu_debugfs_add_files(adev, amdgpu_pm_info_list, ARRAY_SIZE(amdgpu_pm_info_list));
-#else
-	return 0;
+	struct drm_minor *minor = adev_to_drm(adev)->primary;
+	umode_t mode = S_IFREG | S_IRUGO;
+	struct dentry *root = minor->debugfs_root;
+
+	debugfs_create_file("amdgpu_pm_info", mode, root, adev,
+			    &amdgpu_debugfs_pm_info_fops);
+
 #endif
 }
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
index 45a22e101d15..a920515e2274 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
@@ -84,6 +84,6 @@ int amdgpu_pm_virt_sysfs_init(struct amdgpu_device *adev);
 void amdgpu_pm_sysfs_fini(struct amdgpu_device *adev);
 void amdgpu_pm_virt_sysfs_fini(struct amdgpu_device *adev);
 
-int amdgpu_debugfs_pm_init(struct amdgpu_device *adev);
+void amdgpu_debugfs_pm_init(struct amdgpu_device *adev);
 
 #endif
-- 
2.30.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
