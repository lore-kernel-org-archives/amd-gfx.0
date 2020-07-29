Return-Path: <SRS0=V/Q8=BI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B56C433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2020 02:57:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA42E2076E
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2020 02:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HxvmQ9WZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA42E2076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 588AB6E43C;
	Wed, 29 Jul 2020 02:57:26 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4A606E43F
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2020 02:57:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ANQnH43wI/9MUFO8yx6kS4cHio/iVQptbrBR3c/KMbMcykQ/zrnRzEZemc28I7RFJlzSPQ53JhXUgUa9MtMkkXhE1Q+KhzWUoZTCFJjATvuAZ0AJ3IiZQkR4dpmMGWqj3libQta3Ks07evN7hquhlZBcvU/cKL1t039JmJjgMZU1BaKvof5d5mm9olKDanuWjZvO56kMPP9JSxsh8H9cY9pBIyUkcKIwz9L/rOMDh5xZ/Jb7S2JB4fCaWHX+yMOv48fZHWbKVopqlAjA/XnAy5SHPsE0fJFDdsjFyPJ9oGb0Ik+eFIYCT69G1A8AL+49k8znoER+KSWH2ApbzbdLtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YwXvrVCtFqap6/kI8/T6znz92+5f9++eW7bBhUMnsng=;
 b=G4l/mia4FvuqcelhuLO28TpguoUHbWuIdUtjbnEczW9IqzXPAsBj8hE/I1uXhlXH7ttohukq/CQTw44tmV+7Mmdz69XMA393rLLyr6kF0BVq25cEIBJFpZvd4MyoFsnQA5GXrLoHKE67TLZM8RrKS+mayZnqkEJAk1yNuhObFjZU8mgOGOul+ciWh0b9qoWLNs0FnGU0a83eZw3ZoacbhM5etDA51wPXojr/8vEBoiH3WBFttcj8R3soVi+5evAuVT24TMDA+dJMw6MIlXUVaW4rqYohsOM6BNjPCnHM4OSGhnHUaZbARj3OpVoxeDPLdR7FKmA6Va3dGG3HNxPwmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YwXvrVCtFqap6/kI8/T6znz92+5f9++eW7bBhUMnsng=;
 b=HxvmQ9WZMuepBFdx9Mejn9MdQDQ6Di+TH7gF6a1fpYWE4GCkvx9o0I3ZhKuSsysEMSxCzxE1Vp05iETFF7VfO4f5TiGrwRD/FNesj79uOZOYjW37zIel+VJG7msrcna+0VeRSdU5l/jVpw26DyZBMUnIcYPIyNjkY0W8b/aLLe8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1285.namprd12.prod.outlook.com (2603:10b6:903:3e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.26; Wed, 29 Jul
 2020 02:57:23 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c%11]) with mapi id 15.20.3216.033; Wed, 29 Jul
 2020 02:57:23 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Hawking.Zhang@amd.com, Dennis.Li@amd.com, andrey.grodzovsky@amd.com,
 Tao.Zhou1@amd.com, John.Clements@amd.com, lijo.lazar@amd.com,
 christian.koenig@amd.com
Subject: [PATCH 10/12] drm/amdgpu: decouple sysfs creating of bad page node
Date: Wed, 29 Jul 2020 10:56:27 +0800
Message-Id: <20200729025629.19355-11-guchun.chen@amd.com>
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
 Transport; Wed, 29 Jul 2020 02:57:20 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 417e708b-2a58-4194-d8a3-08d8336b1e18
X-MS-TrafficTypeDiagnostic: CY4PR12MB1285:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1285C441E845BF43F1222B4EF1700@CY4PR12MB1285.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:451;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H6i3PFQAS8rblANqcgVx5kz1FVbAjA8Ebwr8Uk2tLneFvMG3hqQ86VmrfM+UBZKA9b0I/QaCkCZd1dl0r6Gbr8I/zn1UWWvO4eGEWLK7oyH7PUmdIvRSYk/anW/VWnkSpCrJen37sYDCIo1GisE4BIukLG8awxetUm6VTaSquTkun+dfoDzoTXME/RkrvOuXUClK0rd+8ELySnYFAb+1p9SxyJ9a0CFbLR9IjK0x1QoiRFfA30TtiNnNVd1D0xh1DIOW9IeZ9JdP0EbQy5r9WULgFfEoihNvysjQhqV8praMnRxq+E5QaYes7UkH9wy369epjiRjbjj3lWvtd0cXrA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(26005)(2906002)(66946007)(6636002)(52116002)(66556008)(8676002)(86362001)(66476007)(186003)(7696005)(16526019)(44832011)(36756003)(5660300002)(4326008)(1076003)(316002)(8936002)(956004)(83380400001)(6486002)(478600001)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: AOKsosQSKur3TxiDCa1d5orpXMXliUwMdlGLg2q/t8sCD97rsMK4mFVBHnQKD92wxYVcLWkiW+g51NkjoUT7LVv7RrOU4AMUpwo9nlYhnJqkXqPnBp44y7GphEsq/Y1JvTOqPgCByEKPvGg3TK0QaI2mtr57XMHNYedkZXfy6Vo+Og5Hy2ltSK8XfWNMk0FPnJ6ijFWmL7y0pyrWCVG9YUi9s6ZmfkPO1PhuUx0IX8GsKXeCI1kv3s8XgCv0xKfBfJOS2ywi0d/fbWIPnvWchkXYoXxRIBR0/P8hHePmftpBqRDz1FUH+8nT0hyXoI8L40teg6dP4Ou/cFoGaJj5wNwL9Qfubn5Oe1Rsav8qamUrcoRGVs05Px2IHmNBog8h3dq8OZl1mJRzbjzUtui+0d3dVKnmmYPlPh8ir7U5PhCitqDzbEjCqhoVgiknuKQlB1hzxx7sc+8GXHveiaXY3tvMA432AD7winvzcfKSky2OAj0BfNER5mZtiKxHB+Ul
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 417e708b-2a58-4194-d8a3-08d8336b1e18
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2020 02:57:23.4586 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d6GuIz9mc8hNYFy0eaANAlc/D5xn/j9f0G/AIMaYstG1NKlXfrpCp1pBJmqC6XvJJTkWUMRkbBwAYmpuLCPSmg==
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

Bad page information should not be exposed by sysfs when
bad page retirement is disabled, so decouple it from ras
sysfs group creating, and add one guard before creating.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 71 ++++++++++++++++---------
 1 file changed, 46 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 0328f7882199..0b7317349bde 100644
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
+	group.name = RAS_FS_NAME;
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
 		.name = RAS_FS_NAME,
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
+				RAS_FS_NAME);
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
 		.name = RAS_FS_NAME,
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
