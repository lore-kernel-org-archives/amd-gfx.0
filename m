Return-Path: <SRS0=z2P7=BH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA5DC433F8
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 07:50:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2110F22B3F
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 07:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="N1Jz60AF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2110F22B3F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E510E6E220;
	Tue, 28 Jul 2020 07:50:27 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72C026E220
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2020 07:50:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ka7EF5djF2DVfbXulN/GLC+XAW3iKlNQRupPFbX7lkxuTi8odaEDu+0ubmmTrPHEBVfMAdojc/f1UXNlWbtxqdFKiVoXcagfuaOJMpKXSPbl5uNQtdZ7vzw5CiZk55vfhakJrtdcpbl/PJGgww5h3FA/W4ye5jBsUAe2DWgkzy+pAGMtLBqsfTQ+obQY9LOa/+0QrVrTbHtVGeVWIdOkOhR/haAG3HslUonj387L7qHYml52mpDcNmyJ17+kTe+cYNHwsSWjRzqhghdAF9Jd0KMEf1uupkyF6HeXthnKy9opdVls9/NBrnMfd01CZj+tcwZELoWywmrOcwsJsbMnIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ht4+ey0qXDWN6mghRCadSFikwzhowKo7yYxOi878bM=;
 b=TEkwk9ipKot0ERcXP6PZlcQ/sNqDe5W84+B562lULQ0uZmih+vX+Lc8x9FmHUSM4zP0pZBn0tj+pPSErsCtGC7vEYZWv2oHeseweTPNsMqVMtFRKz/qHh7p2wq1+Fg4kfUJ91mpaHlLRIgh+Z5ewNn4xBObyKxVkGA5AViHtBeYYlVwKZ0aMQN47dnMXlmfn1iwFFeOc9NhBkaXuRVby+zhVXYqSWj3EOhKN3IczSOEJRHHmqzawPz6Cc0n09Wc9WyucxWmxRTVNN2S07IfvP3nZOff5QJ1Bj+4FcLNIHyiaXVdIOi34H4xxVf8IdJO2W3tbkps4xJ4QpbySs4aDyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ht4+ey0qXDWN6mghRCadSFikwzhowKo7yYxOi878bM=;
 b=N1Jz60AFRCOPAZ7tTGketvqTYeOife+/N4TERygXq5vQUe3XmXfOyT8xIwAW7Lo2aRE39n/RNpp/6sE7RXpFFEhDbncXrol7tvg5BVv+C9ROZwnQxCeDqU0gzZGIDLWutmXmopJ31GnhrfnqvwSYK16XS9PmXLc3LZ1yJAdePvQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1752.namprd12.prod.outlook.com (2603:10b6:903:120::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Tue, 28 Jul
 2020 07:50:25 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c%11]) with mapi id 15.20.3216.033; Tue, 28 Jul
 2020 07:50:25 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Hawking.Zhang@amd.com, Dennis.Li@amd.com, andrey.grodzovsky@amd.com,
 Tao.Zhou1@amd.com, John.Clements@amd.com, lijo.lazar@amd.com,
 christian.koenig@amd.com, stanley.yang@amd.com
Subject: [PATCH 09/12] drm/amdgpu: define one macro for RAS's sysfs/debugfs
 name
Date: Tue, 28 Jul 2020 15:49:31 +0800
Message-Id: <20200728074934.12490-10-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200728074934.12490-1-guchun.chen@amd.com>
References: <20200728074934.12490-1-guchun.chen@amd.com>
X-ClientProxiedBy: HKAPR03CA0004.apcprd03.prod.outlook.com
 (2603:1096:203:c8::9) To CY4PR12MB1287.namprd12.prod.outlook.com
 (2603:10b6:903:40::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from guchchen-System-Product-Name.amd.com (58.247.170.242) by
 HKAPR03CA0004.apcprd03.prod.outlook.com (2603:1096:203:c8::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.9 via Frontend Transport; Tue, 28 Jul 2020 07:50:22 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c7c79707-95c7-442a-19f0-08d832cae341
X-MS-TrafficTypeDiagnostic: CY4PR12MB1752:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB17529A71199F0BCDEED5CAC7F1730@CY4PR12MB1752.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3l29Hp0H1QYcAgII3t0+p5VlUN5ukts47qVlFYWKb3HJZd1vyQLkKkd5QYz0RSof2eu5353WXp9xOuckC9zmFKDnMuDQsnqkN8xXru71JEHk/wwex9TT5ZcBUJkdpVi9d074de6xncuiwT7O4RqGuFcd7awccpU6KgOUaJ6bkZ/uJ8uZ4fhwj475WJKqT3WmzMCIN16BeFSf3yji57wTFMm47YVEF54CHcnZWCGBbpTvSvVk0XiCAClKFu54uBr0PYBbPn73LuMrfb5MaAnbD4xpLag6q1UybZl6R5dMz6+1kQCsvLoDuICL8OsZeAMktub3CHunicRejVKF7s7dovS+O+kekNovyLufjaPa6vF99CeS+4jjDhl3hQ8ug6wn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(366004)(396003)(346002)(39860400002)(2906002)(956004)(2616005)(1076003)(6486002)(66476007)(66556008)(4326008)(6636002)(66946007)(52116002)(478600001)(36756003)(44832011)(86362001)(83380400001)(316002)(6666004)(16526019)(186003)(26005)(5660300002)(7696005)(8936002)(8676002)(921003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 9isVksfDhDAhS9SPfXMijjKsnETEQiLDRg3YEoeg8KzyEjCNySliBnn2fGOl1SJMw43VNmNSve/Efe+NnTN4iWPdLjR8QPD9+BB0JLpNc9+14U6F9vfjxlmDpw8NOhho/3WPiMbH4upe453gmA1D46WBU3Ha4irzOMA/hnSHri63Z0jFNUKwgzNA3XB7sWslYCuQlWE/bRLRjlaGPZgGTb+shDYxrbXhdpdQ4fPeYbd1OvDALMdBgxh0kHQ8HlLi+B14UNcnamwWQPezUF99/fu/h/XdvIEsjxRDYKpZUY7RLJVFQtX2MxLfsg1djjLFTxq8uXbfzP1CVQvNIITopY2oIJiQlp2X5MwsinDGPMHvLQ6GXNO+u27lFhYZQA0wZGbigc4aIHTT+2/u6kqsyqVWiNMHW7VQvKXLjNKsBP6DDIBhGcGkNxsjlJD5jdwB54SmGkY8Gy75Bmt58uEUv+5nHnkCSnpLTcw/4AtmuMFY6zm2ZKqQ+ddkaHR9xPii
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7c79707-95c7-442a-19f0-08d832cae341
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 07:50:25.3550 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gQugOzxPit2GzkHhSs0buPuISfXbGv3m5qS9wzzYryiRzIzw88RiKRGbcYmq98aJQGDhvuUd6RSBVYMidKROWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1752
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

Add one definition for the RAS module's FS name. It's used
in both debugfs and sysfs case.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 2cc09aa67423..c1ed0074a52b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -34,6 +34,8 @@
 #include "amdgpu_xgmi.h"
 #include "ivsrcid/nbio/irqsrcs_nbif_7_4.h"
 
+#define AMDGPU_RAS_FS_NAME "ras"
+
 const char *ras_error_string[] = {
 	"none",
 	"parity",
@@ -1037,7 +1039,7 @@ static int amdgpu_ras_sysfs_create_feature_node(struct amdgpu_device *adev)
 		NULL
 	};
 	struct attribute_group group = {
-		.name = "ras",
+		.name = AMDGPU_RAS_FS_NAME,
 		.attrs = attrs,
 #if defined(HAVE_ATTRIBUTE_GROUP_BIN_ATTRS)
 		.bin_attrs = bin_attrs,
@@ -1080,7 +1082,7 @@ static int amdgpu_ras_sysfs_remove_feature_node(struct amdgpu_device *adev)
 		NULL
 	};
 	struct attribute_group group = {
-		.name = "ras",
+		.name = AMDGPU_RAS_FS_NAME,
 		.attrs = attrs,
 #if defined(HAVE_ATTRIBUTE_GROUP_BIN_ATTRS)
 		.bin_attrs = bin_attrs,
@@ -1117,7 +1119,7 @@ int amdgpu_ras_sysfs_create(struct amdgpu_device *adev,
 
 	if (sysfs_add_file_to_group(&adev->dev->kobj,
 				&obj->sysfs_attr.attr,
-				"ras")) {
+				AMDGPU_RAS_FS_NAME)) {
 		put_obj(obj);
 		return -EINVAL;
 	}
@@ -1137,7 +1139,7 @@ int amdgpu_ras_sysfs_remove(struct amdgpu_device *adev,
 
 	sysfs_remove_file_from_group(&adev->dev->kobj,
 				&obj->sysfs_attr.attr,
-				"ras");
+				AMDGPU_RAS_FS_NAME);
 	obj->attr_inuse = 0;
 	put_obj(obj);
 
@@ -1183,7 +1185,8 @@ static void amdgpu_ras_debugfs_create_ctrl_node(struct amdgpu_device *adev)
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct drm_minor *minor = adev->ddev->primary;
 
-	con->dir = debugfs_create_dir("ras", minor->debugfs_root);
+	con->dir = debugfs_create_dir(AMDGPU_RAS_FS_NAME,
+					minor->debugfs_root);
 	debugfs_create_file("ras_ctrl", S_IWUGO | S_IRUGO, con->dir,
 				adev, &amdgpu_ras_debugfs_ctrl_ops);
 	debugfs_create_file("ras_eeprom_reset", S_IWUGO | S_IRUGO, con->dir,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
