Return-Path: <SRS0=jhpT=HR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B6B8C433E6
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Feb 2021 12:34:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C522600CF
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Feb 2021 12:34:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C522600CF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBF5E89DFA;
	Mon, 15 Feb 2021 12:34:53 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F290589D5E
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Feb 2021 12:34:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mf5pxRwEzi4q4JArNCuxFemaHUfB8zxCP6T+gjQohRSml+QLTGLAcbrMDvMryxkKvkc8l7F3wAquOV6OSy/e3/3tnaTvHaiiYS35b2n9CHVZWKG/QvAOmrd1m3yE+YEBrfyLtieaunOPoRypcjafezUURvO1fQMc8uu0oYYODR0DpPYKleyMLJK/3wUzAMkuaaA2e0gvLpID/lw9nDumS6/R8o3sTYIPKlwnct239dM5/rwbUeIRS51mxJWE/mC+ftI5nKpCjtGvISUVURmVsmhNsaw5r9zy520fYqAlm2DW66HAuK5yjTGzK3Er5Z40M/oQyHNxdp6zdRqTcIAqsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VjnqP9StvliDBSlVzmblyHtP+kLSt45AW6dj2JJIfg8=;
 b=JgsOJz9+iH+hxdsW0KDfewZj8ZaaD24P8QgqVeM6vCr5xmgGT0qMEGPRCqqzBuGyk0qFWk9n24jx61y/I440iEgMIQIivizaJxAz99DAJ7xTqZCHjbJWTnlhEfc+3x1rgH4I8YyiQVWeJkfPyaznDXRTdkNeEMzBz90bfZrTs5WsLjFgVFVnPF+kB7BpzXLYcRp/F5sVoPRxioxgJ5rfSjSy26JiWhTW81jDiMY2AxY9RuqodutK4uIPrNC/tcYULMG+QMf+ESOOypcIf1QIqZsU1NuAojPc0E5WP6S/eDT8DX/kcljDUgEIQU+Gj56PUcgWWFzAlITWS7wGUJmc0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VjnqP9StvliDBSlVzmblyHtP+kLSt45AW6dj2JJIfg8=;
 b=c+0nwNt1bq1lZX3qJOcxFNW1P2vyZ62u0pc2QTc8q5txTFt3LoVlxZ/Kl/EnYEEq++yocv437t6AKHugcyHZMwUInJzgcEdOzZ57FPS3MfeHgoo6+7UeeTv/N8XOKOBhs64Fm1yF1fXpxd7POs+FpK0BXhksz0+j6HguL0kvxlE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB4452.namprd12.prod.outlook.com (2603:10b6:5:2a4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Mon, 15 Feb
 2021 12:34:51 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::452c:77af:fea7:a633]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::452c:77af:fea7:a633%6]) with mapi id 15.20.3846.039; Mon, 15 Feb 2021
 12:34:51 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: Christian.Koenig@amd.com
Subject: [PATCH v2 2/3] drm/amd/pm: do not use drm middle layer for debugfs
Date: Mon, 15 Feb 2021 13:34:37 +0100
Message-Id: <20210215123438.85436-2-nirmoy.das@amd.com>
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
 15.20.3846.25 via Frontend Transport; Mon, 15 Feb 2021 12:34:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 357c3b7c-9840-4c7f-071e-08d8d1ae1723
X-MS-TrafficTypeDiagnostic: DM6PR12MB4452:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB44527AC9CB3040B712CC69D68B889@DM6PR12MB4452.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kk6jIgZglf4TqLipRMSFXdtjY0fhKh7fW0/p9L4DBc6Rzy+Qg83Gt+jthlVqOZ0pPs/oyjxTZUYH2hscntICCW2FaReP9fXO3KWDfWoSRSErN2/qnVnW28a6weybHYcfxnGZaeJvVes0ad99U7JDYH4V3xHWGO0WmEwCmaFi/NO6D87DbMEN9KfjaL+jmE+mCPwlgvwCJq2HlebL9qro2tSaSrjoWjKr5rGEzE4aKu4R2Zihs5lAYkD1zvSUPJ2mk+4/bxIR79vkPnGQXZIguJbjcnhudQoOyCcHLUpUo9fWBFz1WY/3LUxGmoqnRCryayuhHpwn56ssAE+24dZUhxJ2f746NRHXDhBb0ZVDgxIRlnp+bkxzAztrCp3u34nsVunMai2LNuGETvZdHP4kGmmZiTTZ2cAIxA9estGW54do5JGTFyhzwwNHEry3E286aMKT5zpWQI+F5U0aAstGrWx2jMji93l/0YLxJTrLPjo5iPtnywnKZaVHqjQrLRGSeWaICk3AYbpu0JXGpVTVrw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(376002)(366004)(136003)(346002)(4326008)(34206002)(6486002)(6512007)(36756003)(478600001)(83380400001)(6636002)(8676002)(2616005)(956004)(37006003)(316002)(2906002)(52116002)(8936002)(16526019)(26005)(66946007)(5660300002)(66556008)(66476007)(6506007)(186003)(1076003)(44832011)(86362001)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?SOIlqZ71ZPYtRzdemUtKMspuk2RWPWa+DxuvZikISn1zQY2IASC8AUwa3ZoA?=
 =?us-ascii?Q?jhdBdL2+W+JI3IH18CWhmiU5AGBlN6NVmvNUi9o05uBCz5ZBmunxUZybG9yC?=
 =?us-ascii?Q?ZH7sjEkeSAATJHCfaQGwGNKasXSnAiJeCQ4x5+5WPDTxQQlxirIrYMf/FmCi?=
 =?us-ascii?Q?B9aM/6+39zcctRLT86kNXZFiU6F/8WxpSK+nLxsvfak/flJVvIF/P+RAblw4?=
 =?us-ascii?Q?f5i6Pqcz9l2zMlGvtcaM4sRiADUJAjsytsYu4YKnSWWeB+Z068kP9DSrt4AE?=
 =?us-ascii?Q?z42sR3k3FdD2VnoIqet5jmctmjSQ5GFpVqfm1A53H9Ep8e1Zh41TWZB9ApER?=
 =?us-ascii?Q?PwwiQkz1ITa8CJQhAEvZnRKnUF3fnLjpF8GgUc0gZBI1NO17oowJaLtuLR4c?=
 =?us-ascii?Q?XZrRY9l6doe3PocpcV2rGDpoTQJF/KIdTtJ0F+XQvaEUWUrfHhbiP4OswXyN?=
 =?us-ascii?Q?6I1xnW0IXRdFOgKZoJrItY5+tGkFrLryVG6oRxYKCfBKNe8uZZwS7zIDLMNw?=
 =?us-ascii?Q?pQHRFff0LWXJOuMrWzD8nf7eJX6F+S3zAcWpDxHrDZY1H0nb548eDIiZ9CxB?=
 =?us-ascii?Q?ARpATHl2WiJPVKBM78yLrX/xWshj30+p3Uq9dmv5CTPl+Yap/J8B/JB+EFtC?=
 =?us-ascii?Q?z/zpsrfd6Vn3AYDyyyRk7jjBctLo6LGEUDfkllKq42IFJCX/8GI0GCBgqyhM?=
 =?us-ascii?Q?mP83Os0WII3uLbXlDDx9t7KjbzqjCjDZIQdxBm6XDpNM6r8dMZLkza285KmO?=
 =?us-ascii?Q?pBTlw7l3uoE6dE/0TOm4AeP3TzVsdbbRt/yczEZSmrHupy7l0loCLrm1eLjz?=
 =?us-ascii?Q?Yl9ebMY1puWpo3RKYl/z5WzoVsZmILoL46FcF1gwsiQBr0VYycmfyyMkVd6+?=
 =?us-ascii?Q?Aer7ZQi67IpvC8gLHxHYJe5KbjBMnOs9A+5GCEiIQdOSeFuXT8HFG54KjU8p?=
 =?us-ascii?Q?eOhBWPaU1popqRpnpzL/Goao0iPyW6iEhOckO9L4b8D7H9uKGLB0ZIaG+jb0?=
 =?us-ascii?Q?88JHChq77I2goPey7662HUb5vHP+66sNzPX/P6BpUOAheLNKGJM7pXl0kE7G?=
 =?us-ascii?Q?bri8GdsCz89aUZKaqsJuUgLQWQUBI6kUxB15voQmeNllZ+/EhV99Ng08pGN1?=
 =?us-ascii?Q?/vtA3LQNFeVqM1gY8I/V8bIjepcT86g0Q/vmcrtHAVsoNpaTLjasF1Rxhvlj?=
 =?us-ascii?Q?mjo2B2cvHTDeHzaBErUouwi3loVqsG3jczpo1vNCd6L8CD9Rro9zplrDdSR8?=
 =?us-ascii?Q?1ZTCA7LJPXoKeRfwEfejXTMGx3LZcASUbfR5/qlhSOjVfEc9jyxzlpDOIrQi?=
 =?us-ascii?Q?eD/HxbxVaEjYtvh6P7QykE8b?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 357c3b7c-9840-4c7f-071e-08d8d1ae1723
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2021 12:34:51.7440 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wc7rd7Kou32qKJXApEC5KfBBH8kEhsQ85qe9SrEvJNDQYU54/L/sDPSp7nYzoNWKLZ1NfgCFlbi4t0YATdueGw==
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  6 +----
 drivers/gpu/drm/amd/pm/amdgpu_pm.c          | 25 ++++++++++-----------
 drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h      |  2 +-
 3 files changed, 14 insertions(+), 19 deletions(-)

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
index 5fa65f191a37..b770dd634ab6 100644
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
 
@@ -3836,16 +3833,18 @@ static int amdgpu_debugfs_pm_info(struct seq_file *m, void *data)
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
+	struct dentry *root = minor->debugfs_root;
+
+	debugfs_create_file("amdgpu_pm_info", 0444, root, adev,
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
