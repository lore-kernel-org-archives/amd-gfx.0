Return-Path: <SRS0=YZDW=DB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27572C4363D
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2020 14:52:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C9ED2074B
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2020 14:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="WuWrUd1p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C9ED2074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC2DA6E488;
	Thu, 24 Sep 2020 14:52:39 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB7706EB1B
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2020 14:52:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fsmO6mcNs6w7L8IagtIOoWC45kmi73uy/xFPtl+rawW1rSATqoETfILhXEc6WzY2wA+cPWSdNn47+7LqATIcVwM3pII97kha8PdeRFdYNdEDKdf8C/SoMwM/0rVmRXFQE9IlBo4c9fhLl5OFiKmWWj3Fiyd/wohdtYHoY38jKut/tmcCIFemE+IzHTx69g5yLgwsVN2Pw70D41bz4sz6h6tj2cOAXY5CSpGCCtl7zbgx4+BOmZLKDogCGD6lf2SqzmYXGq46A1MasDO/GDgFnoxxzccFuQU88T0fDvnTShhqXtPiPbNL+Qi5NlZT2AevYrz8KfaTeay3Y893Uz119Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sCUPryF04Sxh9HvsEcOUJEaqyzMr4m18lakod+D68pY=;
 b=MDtyzxcc44UHv9Y1qWR52LKssA/NkqEAM4Tcvwa5bSjqjyXLaBRzGCYgPQzhxHd5jNWccbSimjQ/UpMIlDv6mxQ/uaZswJxuQotPXsPOAuAFF8HNWFAHspFxLuKHxg9B2ozem0L3AnmaziNfjQSZTOvkIXVes/a/Rc+i3vJ+uP90fZin3WnVBs9qj+vwS6okKzmWaMm/qtnQKAoC8x0EwRxi9wXLqJMimQB1IdVnGQlo3ii7G5aqnDAvpbgQZ81yLZwXCUt8idy1dIcGYu36vxPijLvDlRiYbwCVGY9jfXddJVbKFfv6qdjjDD1vZsqZA4TYKIdiQ+5NAzV8TmQueA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sCUPryF04Sxh9HvsEcOUJEaqyzMr4m18lakod+D68pY=;
 b=WuWrUd1pxRSXc0kIZptprbJ7CZ4rIL8QsVtRmz4uK75Dii56kbFOngXMNy3YlMrXl6F04VsqqV0cN+S7TGtSHhukc7qEwvsgKOmB1ohrziEgamGakD7upoMYd5CZLZsU3xEEbHFs2jBHUoKC4XL0Xtl1lM/W7RkeQJpBI7Lvf+0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1751.namprd12.prod.outlook.com (2603:10b6:903:121::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22; Thu, 24 Sep
 2020 14:52:37 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::ad96:acee:5c1c:d92c]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::ad96:acee:5c1c:d92c%4]) with mapi id 15.20.3412.022; Thu, 24 Sep 2020
 14:52:36 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, christian.koenig@amd.com,
 Hawking.Zhang@amd.com, Dennis.Li@amd.com, Tao.Zhou1@amd.com,
 John.Clements@amd.com, alexander.deucher@amd.com, lijo.lazar@amd.com
Subject: [PATCH] drm/amdgpu: clean up ras sysfs creation (v2)
Date: Thu, 24 Sep 2020 22:51:56 +0800
Message-Id: <20200924145156.8114-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2P15301CA0015.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::25) To CY4PR12MB1287.namprd12.prod.outlook.com
 (2603:10b6:903:40::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from guchchen-System-Product-Name.amd.com (58.247.170.242) by
 HK2P15301CA0015.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.6 via Frontend Transport; Thu, 24 Sep 2020 14:52:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 24d7cd98-451d-4136-7d5e-08d8609979f4
X-MS-TrafficTypeDiagnostic: CY4PR12MB1751:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1751E10BB437201059B27AA8F1390@CY4PR12MB1751.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:126;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aQBDgaiLRW6xgyC2i0Kt2vvUyzRHjXNm60Udu5Lcjm1z2j4UFDkiXZGoKrWjEcWYEqhH2OamrqnWkIupbyVDwxKtYrGa1Ien8oyazlGuSBihwEwXPcPG3bOsnQrQ2LhW3Uhso1dCOELZJR7WUe8bJ0BvHhfjrUsuoXSfmiWEqgDE3d8HfN5tmAMUmmIPC8mdlJOj4xjHllztnYdzERdHKT86rmWcLWT6fb8PfbA6fUZek2uqaCOGgf/FI5rLri1igguhXsIPXKhMraa+sk/xw1aqD1chXYgzCa/0aMBfahR4VfwHb/J4VyqwiYfM0kxr4rWCfc7iQWlxvW0krFlqv/B1OCMxgjt1GUZIjGb2XGGo1PsBuOKazgMEYA0Y/bOz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(39860400002)(396003)(366004)(186003)(86362001)(26005)(4326008)(66556008)(83380400001)(1076003)(6666004)(44832011)(66946007)(5660300002)(66476007)(2906002)(6486002)(2616005)(6636002)(478600001)(956004)(8676002)(16526019)(36756003)(8936002)(52116002)(7696005)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: RxYgmRZEDVKtq6cWNwdl8S7vvfWua8HuJvgjDXJIfF6ndwxX48s/uzzo3f8t7cX+PgSeBN/an0PAs4HQTLjsKUgzbYNPhu9XKEMD/fjHmsg2FFKBVbzgxyIbNgroPWU+F7ToXux+ba/BklruXbKSh3zRgmxPYtE8VomdlHQMoN/eFqUyQPpyig+ElsTd8nv8A0KVHSE0VjESiDtBt+T5cjDEUTQS5M9znMLNZV20ARjXxYsrkg+mHkZF636dXIhCBXeWNOWMnsa+aujVQXhXCFE+JZ4a5ooytB85RY+hxSlXizYxAVLU5Orz8ORCuHZwBCAjSTdVjwjvrUZNm9VnbJNCuU6tfP5F+TMhy6i2XjI2SP0idVxclZCE1eg7GQ+inLeArS2OdrEmxf5g40gxGBIuwjWgqBlXfza4279syhCtyzvoDX1ntUXP9CZ6B0RQlwKdlSsi396X6YNH7uPtV5qShex9vOdTTTENRczIRhCmVb/mYpq2c19GUZbQgkm+GxjItIbLrBhaif0GalITbtfYO1a5MLVG8ocOJPr4bC2d8jPj31DUp8/2fxg2QhwUU3MO+G5Q5odCvsIJhV1yGHMJRgAlVGsbEVcEJAl9OdGLntObNVf43y7I154gVEYaZJIQHbhKKiiXfiwcXbsAuA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24d7cd98-451d-4136-7d5e-08d8609979f4
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2020 14:52:36.8082 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DoqZRpxTBD0afJp7lah6KRGuYEEvnlBxpsszfv/6KPGFsqFpqrtM3I26Bo+7Uf4jwloGHBRRWboY/5QTHDLCCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1751
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
Cc: Guchun Chen <guchun.chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Merge ras sysfs creation together by calling sysfs_create_group
once, as sysfs_update_group may not work properly as expected.

v2: improve commit message

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 87 +++++++++----------------
 1 file changed, 31 insertions(+), 56 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index e5ea14774c0c..6c57521b21fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1027,58 +1027,6 @@ static ssize_t amdgpu_ras_sysfs_features_read(struct device *dev,
 	return scnprintf(buf, PAGE_SIZE, "feature mask: 0x%x\n", con->features);
 }
 
-static void amdgpu_ras_sysfs_add_bad_page_node(struct amdgpu_device *adev)
-{
-	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
-	struct attribute_group group;
-	struct bin_attribute *bin_attrs[] = {
-		&con->badpages_attr,
-		NULL,
-	};
-
-	con->badpages_attr = (struct bin_attribute) {
-		.attr = {
-			.name = "gpu_vram_bad_pages",
-			.mode = S_IRUGO,
-		},
-		.size = 0,
-		.private = NULL,
-		.read = amdgpu_ras_sysfs_badpages_read,
-	};
-
-	group.name = RAS_FS_NAME;
-	group.bin_attrs = bin_attrs;
-
-	sysfs_bin_attr_init(bin_attrs[0]);
-
-	sysfs_update_group(&adev->dev->kobj, &group);
-}
-
-static int amdgpu_ras_sysfs_create_feature_node(struct amdgpu_device *adev)
-{
-	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
-	struct attribute *attrs[] = {
-		&con->features_attr.attr,
-		NULL
-	};
-	struct attribute_group group = {
-		.name = RAS_FS_NAME,
-		.attrs = attrs,
-	};
-
-	con->features_attr = (struct device_attribute) {
-		.attr = {
-			.name = "features",
-			.mode = S_IRUGO,
-		},
-			.show = amdgpu_ras_sysfs_features_read,
-	};
-
-	sysfs_attr_init(attrs[0]);
-
-	return sysfs_create_group(&adev->dev->kobj, &group);
-}
-
 static void amdgpu_ras_sysfs_remove_bad_page_node(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
@@ -1300,13 +1248,40 @@ static void amdgpu_ras_debugfs_remove_all(struct amdgpu_device *adev)
 /* debugfs end */
 
 /* ras fs */
-
+static BIN_ATTR(gpu_vram_bad_pages, S_IRUGO,
+		amdgpu_ras_sysfs_badpages_read, NULL, 0);
+static DEVICE_ATTR(features, S_IRUGO,
+		amdgpu_ras_sysfs_features_read, NULL);
 static int amdgpu_ras_fs_init(struct amdgpu_device *adev)
 {
-	amdgpu_ras_sysfs_create_feature_node(adev);
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+	struct attribute_group group = {
+		.name = RAS_FS_NAME,
+	};
+	struct attribute *attrs[] = {
+		&con->features_attr.attr,
+		NULL
+	};
+	struct bin_attribute *bin_attrs[] = {
+		NULL,
+		NULL,
+	};
 
-	if (amdgpu_bad_page_threshold != 0)
-		amdgpu_ras_sysfs_add_bad_page_node(adev);
+	/* add features entry */
+	con->features_attr = dev_attr_features;
+	group.attrs = attrs;
+	sysfs_attr_init(attrs[0]);
+
+	if (amdgpu_bad_page_threshold != 0) {
+		/* add bad_page_features entry */
+		bin_attr_gpu_vram_bad_pages.private = NULL;
+		con->badpages_attr = bin_attr_gpu_vram_bad_pages;
+		bin_attrs[0] = &con->badpages_attr;
+		group.bin_attrs = bin_attrs;
+		sysfs_bin_attr_init(bin_attrs[0]);
+	}
+
+	sysfs_create_group(&adev->dev->kobj, &group);
 
 	return 0;
 }
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
