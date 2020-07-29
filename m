Return-Path: <SRS0=V/Q8=BI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2184C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2020 02:57:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B80932076E
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2020 02:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="KKfqTc4y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B80932076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8262F6E43D;
	Wed, 29 Jul 2020 02:57:22 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A45236E43D
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2020 02:57:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K1Yyf7ooVP0Xkais2fWc0mBbmtPszLavb+zilYWy/Bq8E4taT28SDU8WcMNf82NGajvxE9IBeWPJlr7HgNQjN9U7U6iDwUFAbycLqntVmGNlCObixa6pOtvFVkeVuOzEd+j/KMU1/+uM2jQSemoesGXTElFtSRnt8hitsK75a23B03vdOym/2gnalI8sA3Uj6pQxGfdGDt6I/L5STjspqs4uqsEovN7WpZ3r9UU2ULB1kCK/jbbd5ChViJoIE7xnWjEowHfgE4qRCQSY7Q3WS3Cu5N6IBOfznXTKTel1Ss1kB3XcVeZjroMQrr4AX8cM3C4myf4dGry1F4BaagFD2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sT7axnBM296hL6oA2k833ygKm4cTpRglXczV/U3HZJI=;
 b=UUurVfkTd5cRuG1ewFI8wmDjcRHJ+HA2BmcTVOb6l40zATkTnASEi5h6kS4eg+9UOw92ABZs3Sdtx3Oc7q5nP3m2jPnL/UiYrX0rv/QC0YDpgOzdQQswjnXdFg2rQXGkZ361E1luu01JE9rlhZkvLvAgp+7+l8jhtoH6x9ILglRqkWcfuSXJHb9upgoVcmvNGCGfy/EEjlttUtl5FA5dhv5sd1qaNXVzNzTHi7AoAR3CTaD6GyPOPcmUdjbbVSEOh7DFr6c3uJgn0WR19D22HPY6wMCS/p6Y6Npu+yTWrqpPAHRLGhyw/kvrwDVRsuMdYGhLAf+22ag4bmA00b8dQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sT7axnBM296hL6oA2k833ygKm4cTpRglXczV/U3HZJI=;
 b=KKfqTc4y165u4y5gs4Qd0axeqC4Nu2Vfof/WnzH1HqKqTPNhj4tOhyjt5WaQ4QMcNhOKTRF6PoHTjaqIPjiyLXDgsEa1DaNDeYe6kdJNALC8hb3iiweMjMMMxiMqeXTSV/+KpX4zoplSZXAoiycnnpxkJWl+oST0oHmSnECrNqY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1285.namprd12.prod.outlook.com (2603:10b6:903:3e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.26; Wed, 29 Jul
 2020 02:57:20 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c%11]) with mapi id 15.20.3216.033; Wed, 29 Jul
 2020 02:57:20 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Hawking.Zhang@amd.com, Dennis.Li@amd.com, andrey.grodzovsky@amd.com,
 Tao.Zhou1@amd.com, John.Clements@amd.com, lijo.lazar@amd.com,
 christian.koenig@amd.com
Subject: [PATCH 09/12] drm/amdgpu: add one definition for RAS's sysfs/debugfs
 name
Date: Wed, 29 Jul 2020 10:56:26 +0800
Message-Id: <20200729025629.19355-10-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200729025629.19355-1-guchun.chen@amd.com>
References: <20200729025629.19355-1-guchun.chen@amd.com>
X-ClientProxiedBy: HK0PR01CA0066.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::30) To CY4PR12MB1287.namprd12.prod.outlook.com
 (2603:10b6:903:40::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from guchchen-System-Product-Name.amd.com (58.247.170.242) by
 HK0PR01CA0066.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17 via Frontend
 Transport; Wed, 29 Jul 2020 02:57:17 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 342cd551-63f8-4c05-e098-08d8336b1c5a
X-MS-TrafficTypeDiagnostic: CY4PR12MB1285:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB12858B792267DA7B7D913F23F1700@CY4PR12MB1285.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0JKUxNbIIstqQqsbOnbTp4XoCJwGpS9un45lQlTjKkbq0zEk/F5ngMPbpUMZUIpu5c0qHE4YjMIlYyHPdGsLYg9l0FcGsVN2dSw6TFjUFAoaOZ+gGZpVcyHZddAB1uDDVoeyCTPzwZySBar9/s3tAJUq7PCCI3E2P/iPl4tXPJVVklxDmicXD6lURTJCM+TmyDUr8MrQ5LiAF9bweHb+pDsHHZTT+C6vzEDmegI+97D3tnO44HJntl6xwP/I7Q2b09oKWUoOh/Oei19+lKJ44FGEVYWUFW6gLB4KxldAJc3hDgPR8njj4OzyMjyOE/SXRlK5mCnWV55regzMqPAAiQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(26005)(2906002)(66946007)(6636002)(52116002)(66556008)(8676002)(86362001)(66476007)(186003)(7696005)(16526019)(6666004)(44832011)(36756003)(5660300002)(4326008)(1076003)(316002)(8936002)(956004)(83380400001)(6486002)(478600001)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: TlqTciEk7VUhmZkQn/pH9K2hGaUSfdc+nY2IG1sy2UtotvbnDSviwcKprtPke5WDkWZCjjApjR/vRVdSxlX7KpjB7UPTW0dpGW0eWgEBqCKr7FhtsbkfybCbbFWDouUIKFWb9fyhI3pRKSbqsaW1d4I5YhyNQhW0JMJ9agBMaTrRWPOQOrHy5wQdeGyNLUeVA60q38+U0t5RwIK8hXHdyMrmO15PBw3v2jpDOqKaPW2DY82yiMA0aPzkMK6ilWunsiSK9ZCkbkn4y/mh/W6D+qk4hjNt1Rm3Y6+dQ1W7X1K6BIgK1zN6X9K7gqZ4nR0PZQPld6xoITXcAfgONcgeZf3eAzrTC0LMqdNzT7OzGZ0BFDUp62x5Obz6cHweG8PXhImDcYFJ6J4mYPFzomphlL9DR2kfnS2uv2uh94M/hZmvsf2WtFECiYqiDDjqdt+4Jk4lmZBf4wgJiFvtCGqR0bCu1Ba3jHK3Ih+gbxwv+DL/cO31vGeyR+2M7sEYqLVM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 342cd551-63f8-4c05-e098-08d8336b1c5a
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2020 02:57:20.5129 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: STv7LKrGnoQ+AH02/XlGXQJ8eKKcfn7FxqRLJYeS2Yg1ADwsDXi9Tf2zmIMp4xXk+lKetiTA4ga60e+2H8g4Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1285
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
in both debugfs and sysfs cases.

v2: Use static variable instead of macro definition.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index c519948ebcff..0328f7882199 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -34,6 +34,8 @@
 #include "amdgpu_xgmi.h"
 #include "ivsrcid/nbio/irqsrcs_nbif_7_4.h"
 
+static const char *RAS_FS_NAME = "ras";
+
 const char *ras_error_string[] = {
 	"none",
 	"parity",
@@ -1037,7 +1039,7 @@ static int amdgpu_ras_sysfs_create_feature_node(struct amdgpu_device *adev)
 		NULL
 	};
 	struct attribute_group group = {
-		.name = "ras",
+		.name = RAS_FS_NAME,
 		.attrs = attrs,
 #if defined(HAVE_ATTRIBUTE_GROUP_BIN_ATTRS)
 		.bin_attrs = bin_attrs,
@@ -1080,7 +1082,7 @@ static int amdgpu_ras_sysfs_remove_feature_node(struct amdgpu_device *adev)
 		NULL
 	};
 	struct attribute_group group = {
-		.name = "ras",
+		.name = RAS_FS_NAME,
 		.attrs = attrs,
 #if defined(HAVE_ATTRIBUTE_GROUP_BIN_ATTRS)
 		.bin_attrs = bin_attrs,
@@ -1117,7 +1119,7 @@ int amdgpu_ras_sysfs_create(struct amdgpu_device *adev,
 
 	if (sysfs_add_file_to_group(&adev->dev->kobj,
 				&obj->sysfs_attr.attr,
-				"ras")) {
+				RAS_FS_NAME)) {
 		put_obj(obj);
 		return -EINVAL;
 	}
@@ -1137,7 +1139,7 @@ int amdgpu_ras_sysfs_remove(struct amdgpu_device *adev,
 
 	sysfs_remove_file_from_group(&adev->dev->kobj,
 				&obj->sysfs_attr.attr,
-				"ras");
+				RAS_FS_NAME);
 	obj->attr_inuse = 0;
 	put_obj(obj);
 
@@ -1183,7 +1185,8 @@ static void amdgpu_ras_debugfs_create_ctrl_node(struct amdgpu_device *adev)
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct drm_minor *minor = adev->ddev->primary;
 
-	con->dir = debugfs_create_dir("ras", minor->debugfs_root);
+	con->dir = debugfs_create_dir(RAS_FS_NAME,
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
