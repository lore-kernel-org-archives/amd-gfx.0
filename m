Return-Path: <SRS0=z2P7=BH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A127C433FB
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 07:50:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF45B20714
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 07:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="EMtcKgRg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF45B20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B27EA6E229;
	Tue, 28 Jul 2020 07:50:31 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 165406E229
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2020 07:50:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GkCo1WhJiJ4BXBcQdLjaHPWX/+cnn2ghOyhyB7TMBQTf6o7KvkPrjBQatSx/5sVQpOPg+mjha4BOKdDmNYx1sVCbkWyzsS6ik9QNYk7ely2YowhHcBwKqjIbBM51LkfGb8xUvx7V/8XTzxsiCeWR/CoZznXsSjEH3hnTGXoLxUaKRNlwbvrpSCZB5cDodH8CJZRrL20dJxEYGVnILIRMVC7+By7bcwqIt05c9c+oGBtBJdyupy/3QgEB9M26PUBt2eztMf5JizIWjZEd4/JX2kvN1qLGvpUcFrEQJwV2o6z1CI+Cg6W27VpoFwmKbF3aMCHkLo03AXsbgQ/JC4Rg8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NmkctqS1dLnVulN+NPTsIEGGQP5c54Pz7e3ymFv9f9s=;
 b=QsB4NAD8dNuG+Bm2gV3DIbtV+FWBdJjAyZ67q0zLtDGMUoDqZA5wg+sHQclJAngGS8dE/QvqACATM+PEmNWLAnYbzO55xIo/JsuIt2Lu/e+zCulyt6U4TWYLUmhXLxpTsJZuozChFurfR+oyUBBoF/38kSXDpfdoZIH9gO2fo0c/u0FlU8MOXWAWiyOx+WZG47wEbJtZhKjeeBzji96BcBQgHlltuyf6gIABkzJA+EKsW1ITagxKOFK0GZJnBOcXeRRZS6qAL9nph7Sy+qGP7GzYf1FYDVGzHZ+v9mRJcBTOznR83RTJLrc2p/sMa/fbtc1+UFGAaoPPC2oq4FkzVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NmkctqS1dLnVulN+NPTsIEGGQP5c54Pz7e3ymFv9f9s=;
 b=EMtcKgRgTHrhpB10wAEOUtYijQj69UWbm7LiFCE3oqz/jB8EXPWwQWfKUNxUYKsEAxQW2ptaok+Awr9kSroC+KHEDjYh0TbvjS5ohk+QeLG+C3LkjbCtdIL+TqUcqrfhDIabnfAUKI/E4GU5uDkNA+AIS+wfwX0VyYY1sOkVIqg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1752.namprd12.prod.outlook.com (2603:10b6:903:120::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Tue, 28 Jul
 2020 07:50:29 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c%11]) with mapi id 15.20.3216.033; Tue, 28 Jul
 2020 07:50:29 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Hawking.Zhang@amd.com, Dennis.Li@amd.com, andrey.grodzovsky@amd.com,
 Tao.Zhou1@amd.com, John.Clements@amd.com, lijo.lazar@amd.com,
 christian.koenig@amd.com, stanley.yang@amd.com
Subject: [PATCH 10/12] drm/amdgpu: decouple sysfs creating of bad page node
Date: Tue, 28 Jul 2020 15:49:32 +0800
Message-Id: <20200728074934.12490-11-guchun.chen@amd.com>
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
 15.20.3239.9 via Frontend Transport; Tue, 28 Jul 2020 07:50:25 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e65969da-d842-4a8f-40b1-08d832cae577
X-MS-TrafficTypeDiagnostic: CY4PR12MB1752:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB17528FCC49FE1C0870DC2DF7F1730@CY4PR12MB1752.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:451;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TLHwIk7S342vBRdIsvSvpy+IhQUd7JTVqTv8+xjFsM5PMfMVh/MfSWx+7odisSs3ftXiqjmUaefuOyQMupJNAZ8hUdH/tDXbLQzGDvE7Xpv88aBMvDiIhyrjAuQmVkDtsVDXD4ecPfUvQsYdEHzc7OVWx+Od1qegGfEFraDc5i3qQ0ya0Ni6edb6ebl7XyAlGSVbGIcIGU42i8rAxkMQiof0bD8JbNyItNFC9q1FOqew7X7nixAW3K1rU6iWkpaKHB0Hf1EAoLIyK+oPfPp6XN+M4BmtOs6TZG1CeV7l93onvB1WFScQC6BQIBZo88V5v4Zdf6J/eYdvqYRKnW2F0aLpx9lxvfcguMWoxKzR2Yw6ZgaD7zqhInpMc0vqqxMv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(366004)(396003)(346002)(39860400002)(2906002)(956004)(2616005)(1076003)(6486002)(66476007)(66556008)(4326008)(6636002)(66946007)(52116002)(478600001)(36756003)(44832011)(86362001)(83380400001)(316002)(6666004)(16526019)(186003)(26005)(5660300002)(7696005)(8936002)(8676002)(921003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: kvLuXZdES/I/JVnNq/uGi+fZHJVnIhnmCkL1MVnLsC6XOXr8llmDq3nCAeampIuqei2BQk4PYO25J6MEkpCp/WgjjuMr0l7lTOgpnP9D/AHwJZoGGHjf48aYfy39aTOqVloUnkMaHUXrjo+5J2EbdBArfUyQSvT8AMQ1ec/AobP2uprbcTe56oDJG3eKH2g4N7qXt9omd9YkWMjYOAvHRO/l6Uy949M+B80H9CYObvgw4KGXdiyEcxGCvelSJnWXA59uxqTK2ZGiEjNCOo8ObE1D3boclWiecrIXTX9g5UBG91xsnqc6JMzCKh9Hp5p/BU4y9aj70If9UjaK7BBllfNgnyVa2h53F1ESyNNgfBVOQw7KibIee9CI0YktS+LuYBcXTFXawRlkZZ3UlJ/LD/IZGmneJnQrCY17J5h8pkWtLkkrnJrLiR7XUSU/FRsDXA9Pw9InC6u1Pb5t33f56s8pHGuXHo6pRjSVPdXLQjP9vAyZPx15xWAs3CopHr/+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e65969da-d842-4a8f-40b1-08d832cae577
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 07:50:28.9454 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jpi8voWzv6MnetqChAAZDLPQVzJ3hm0M5806/nxPRjk03GUK9kGab/lbddg3pXBoQGECxE/L/XBPPH52ypW5BA==
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

Bad page information should not be exposed by sysfs when
bad page retirement is disabled, so decouple it from ras
sysfs group creating, and add one guard before creating.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 71 ++++++++++++++++---------
 1 file changed, 46 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index c1ed0074a52b..ddcf2470a20b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1027,6 +1027,35 @@ static ssize_t amdgpu_ras_sysfs_features_read(struct device *dev,
 	return scnprintf(buf, PAGE_SIZE, "feature mask: 0x%x\n", con->features);
 }
 
+static void amdgpu_ras_sysfs_add_badpage_node(struct amdgpu_device *adev)
+{
+#if defined(HAVE_ATTRIBUTE_GROUP_BIN_ATTRS)
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+	struct attribute_group group;
+	struct bin_attribute *bin_attrs[] = {
+		&con->badpages_attr,
+		NULL,
+	};
+
+	con->badpages_attr = (struct bin_attribute) {
+		.attr = {
+			.name = "gpu_vram_bad_pages",
+			.mode = S_IRUGO,
+		},
+		.size = 0,
+		.private = NULL,
+		.read = amdgpu_ras_sysfs_badpages_read,
+	};
+
+	group.name = AMDGPU_RAS_FS_NAME;
+	group.bin_attrs = bin_attrs;
+
+	sysfs_bin_attr_init(bin_attrs[0]);
+
+	sysfs_update_group(&adev->dev->kobj, &group);
+#endif
+}
+
 static int amdgpu_ras_sysfs_create_feature_node(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
@@ -1034,16 +1063,9 @@ static int amdgpu_ras_sysfs_create_feature_node(struct amdgpu_device *adev)
 		&con->features_attr.attr,
 		NULL
 	};
-	struct bin_attribute *bin_attrs[] = {
-		&con->badpages_attr,
-		NULL
-	};
 	struct attribute_group group = {
 		.name = AMDGPU_RAS_FS_NAME,
 		.attrs = attrs,
-#if defined(HAVE_ATTRIBUTE_GROUP_BIN_ATTRS)
-		.bin_attrs = bin_attrs,
-#endif
 	};
 
 	con->features_attr = (struct device_attribute) {
@@ -1054,22 +1076,22 @@ static int amdgpu_ras_sysfs_create_feature_node(struct amdgpu_device *adev)
 			.show = amdgpu_ras_sysfs_features_read,
 	};
 
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
 	sysfs_attr_init(attrs[0]);
-	sysfs_bin_attr_init(bin_attrs[0]);
 
 	return sysfs_create_group(&adev->dev->kobj, &group);
 }
 
+static void amdgpu_ras_sysfs_remove_bad_page_node(struct amdgpu_device *adev)
+{
+#if defined(HAVE_ATTRIBUTE_GROUP_BIN_ATTRS)
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+
+	sysfs_remove_file_from_group(&adev->dev->kobj,
+				&con->badpages_attr.attr,
+				AMDGPU_RAS_FS_NAME);
+#endif
+}
+
 static int amdgpu_ras_sysfs_remove_feature_node(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
@@ -1077,16 +1099,9 @@ static int amdgpu_ras_sysfs_remove_feature_node(struct amdgpu_device *adev)
 		&con->features_attr.attr,
 		NULL
 	};
-	struct bin_attribute *bin_attrs[] = {
-		&con->badpages_attr,
-		NULL
-	};
 	struct attribute_group group = {
 		.name = AMDGPU_RAS_FS_NAME,
 		.attrs = attrs,
-#if defined(HAVE_ATTRIBUTE_GROUP_BIN_ATTRS)
-		.bin_attrs = bin_attrs,
-#endif
 	};
 
 	sysfs_remove_group(&adev->dev->kobj, &group);
@@ -1155,6 +1170,9 @@ static int amdgpu_ras_sysfs_remove_all(struct amdgpu_device *adev)
 		amdgpu_ras_sysfs_remove(adev, &obj->head);
 	}
 
+	if (amdgpu_bad_page_threshold != 0)
+		amdgpu_ras_sysfs_remove_bad_page_node(adev);
+
 	amdgpu_ras_sysfs_remove_feature_node(adev);
 
 	return 0;
@@ -1283,6 +1301,9 @@ static int amdgpu_ras_fs_init(struct amdgpu_device *adev)
 {
 	amdgpu_ras_sysfs_create_feature_node(adev);
 
+	if (amdgpu_bad_page_threshold != 0)
+		amdgpu_ras_sysfs_add_badpage_node(adev);
+
 	return 0;
 }
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
