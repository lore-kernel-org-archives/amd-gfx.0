Return-Path: <SRS0=jISE=AF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26FF6C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2020 22:53:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB6072073E
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2020 22:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="J7FMxv63"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB6072073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30C786E0CE;
	Wed, 24 Jun 2020 22:53:00 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 349C06E0CE
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2020 22:52:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SRfbk4XTgnpXqqr7qn5vb2fjMl8p/2V4DcBK5pijf8Qk5wCl9ZQn0AhaiOIoJCD28cEDYNqmiBbN1hekcHzY7P6YfcqINVJQpJxl6sUQR/TX8EsUh0pFt7rsMp/KvtwNysucRilqxOUPrnz38IroiRLmmhGx0xdxL4L0jk8qLn1LmnrW6/0OXl8KTMadDzM80XsV57GtisLucbENfh6H8UjfQLg/qPxgQFV3299rvlXcQ3gKvOsjygOiPxxZcAk1BStrfI26a+lRM6BO/vRBiYikp43dHdC9AKEZS8rQvFrM9GKxtowdXVcKynqVz9HOePZL5zgxfzgvTKycTtoYbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CYjhaMVio3qYPZsByAeJgntM2q7Y/nckxB+5ltuImmE=;
 b=K2vdEot4eZWW1wyOgIkuwG323b7KJzr53++zpvPr8FsKDtZstk5gtsrYf8aFLsYMe5Kptv7W6yCH70zulfiIYGmGLYJcv/Y7JzwtumOdjB0oGz4xSEJ9eA3ysoGsjbw+GhsOEb/6BI7FXMsyxTUF8Yd2IEbvQDtbTekwhkrnYOBKw7um2elXNEYj3suWopbdj6qBYuw/zObOjLszG8T9YYgjJh50y6sRgJmMt8jhNEMPBdGIxNaeDFymMu0xDcOx/yYbh3PNPRrXmoXBaGIbQ8PRBEwCgR/UX5URY+iYh7A/ZQGfXzhzOz2TAH+1SY1xAY+E0ZCBwsYMkoIeHQbPCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CYjhaMVio3qYPZsByAeJgntM2q7Y/nckxB+5ltuImmE=;
 b=J7FMxv63B10PSeJmTcQIDdit8CChuulxte4OvNfNFrzjOUi3o2fN2zVq9jni4Hb4EdvXiJHywJUtDt1s7PrtsB1h7/9P15CWaBQLOXwawEZCpTEIcC/3p16934j9hIUxecPJQsrEBJJx+vUvilV+z+qc2Uj3bSoP3gDbsTHqsZs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4101.namprd12.prod.outlook.com (2603:10b6:610:a8::22)
 by CH2PR12MB4085.namprd12.prod.outlook.com (2603:10b6:610:79::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Wed, 24 Jun
 2020 22:52:53 +0000
Received: from CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::b9c2:5b76:382a:c5d]) by CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::b9c2:5b76:382a:c5d%9]) with mapi id 15.20.3109.027; Wed, 24 Jun 2020
 22:52:53 +0000
From: "Wenhui.Sheng" <Wenhui.Sheng@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/4] drm/amdgpu: request init data in virt detection
Date: Thu, 25 Jun 2020 06:52:29 +0800
Message-Id: <20200624225232.7616-1-Wenhui.Sheng@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK2PR02CA0193.apcprd02.prod.outlook.com
 (2603:1096:201:21::29) To CH2PR12MB4101.namprd12.prod.outlook.com
 (2603:10b6:610:a8::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from HUI.amd.com (58.247.170.245) by
 HK2PR02CA0193.apcprd02.prod.outlook.com (2603:1096:201:21::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.24 via Frontend Transport; Wed, 24 Jun 2020 22:52:52 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c14d0926-1fad-49f0-22ee-08d818915402
X-MS-TrafficTypeDiagnostic: CH2PR12MB4085:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB408517D91D57989ACA0E63A08C950@CH2PR12MB4085.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:167;
X-Forefront-PRVS: 0444EB1997
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FNvpZRpSKfMcTGoE0dpUWWzz3MyZ++Beh3AZmyunCICW8w/LAAco2UYGL5wk3j0ZOKBZtIQqcwXNnCN0CGX/s3mW1ynXfwmgK3RewdqtziRr09/xwYICmsf9LUMEvSv9Sjzw+bsMpQsd40pcumEPNl4Qr4yZ+56UTgsasPYho40CX8WNOIz0twESJKUwe/9rbyI0zRQi3D+G9kPemNat7V+SPWle6Khf2ceKx1nptle90xv/Tdv+V+fEG6pvh8RDlMoYC7t7G9GFAcuYIkHFgedIZZVsr/AIOpPCgh5crLa6RGjQMJzNcP0pSTps1Yob
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(366004)(39860400002)(396003)(136003)(86362001)(66946007)(83380400001)(52116002)(7696005)(66556008)(4326008)(66476007)(2906002)(8676002)(956004)(478600001)(316002)(1076003)(2616005)(6916009)(6486002)(26005)(5660300002)(8936002)(16526019)(186003)(54906003)(36756003)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: jBRVINwLV1kqyqDHoThkHJwlte5yOXWco5vcwwhJ5TBSeLoa1HCy+t02BRRkPRWk7oNa/Cdg/Y1CXxvFfE2pzdwuJ4CYybYlpOJwFtKd7p3oZvIcdwQtGxzd0DTgz9YKT0ZI/o5NtuudLNA+8w/cIF5oePazkEC18dvhg/0aTVbe/FD7XsGWPof60Z/8riFDvQlAXC3/NBYqiAm6tB4xXMHrugbQdNdLVYYdKZGt9AKR7ztXPDGADO7M/JJVB7nrmweEQ6142ZzW0fcEoi31HwxjfPi3JkPgFD11JMmLPEm99a/Os2yAm0kPHuTB8WAYXjIyLt8EED2dNV2gA8F32qqPBaE/+NqbeMwGjpxaizj2NNJmTPn1/pUh92BOq09+IR3poR9hC47kiiGZpwnOdz1ZPa5layxbDV2ggI3KUhdaByX4D/bn6Hw4tGvx9JmxNEmcnlS00Rvq7Zc5lb8tB2ra+l9Th/uf6TeRwOuOrGhzC5GyYrGarQpotoslTqsv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c14d0926-1fad-49f0-22ee-08d818915402
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2020 22:52:53.3099 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wn4KBOD6c7npa8VoeS6UGRUgl7thW9i5AwDfB1enE1tjw9oB0xU/qJ0e4ggAPkBJKR5txVRvRoaHkjz0utpm/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4085
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
Cc: Wenhui Sheng <Wenhui.Sheng@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenhui Sheng <Wenhui.Sheng@amd.com>

Move request init data to virt detection func, so we
can insert request full access between request init data
and set ip blocks.

Signed-off-by: Wenhui Sheng <Wenhui.Sheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 28 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/nv.c          | 11 +++++-----
 drivers/gpu/drm/amd/amdgpu/nv.h          |  1 +
 drivers/gpu/drm/amd/amdgpu/soc15.c       |  8 ++++---
 drivers/gpu/drm/amd/amdgpu/soc15.h       |  1 +
 drivers/gpu/drm/amd/amdgpu/vi.c          |  8 ++++---
 drivers/gpu/drm/amd/amdgpu/vi.h          |  1 +
 7 files changed, 46 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index da233a9e429d..1203c20491e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -27,6 +27,9 @@
 
 #include "amdgpu.h"
 #include "amdgpu_ras.h"
+#include "vi.h"
+#include "soc15.h"
+#include "nv.h"
 
 bool amdgpu_virt_mmio_blocked(struct amdgpu_device *adev)
 {
@@ -513,6 +516,31 @@ void amdgpu_detect_virtualization(struct amdgpu_device *adev)
 		if (is_virtual_machine())	/* passthrough mode exclus sriov mod */
 			adev->virt.caps |= AMDGPU_PASSTHROUGH_MODE;
 	}
+
+	/* we have the ability to check now */
+	if (amdgpu_sriov_vf(adev)) {
+		switch (adev->asic_type) {
+		case CHIP_TONGA:
+		case CHIP_FIJI:
+			vi_set_virt_ops(adev);
+			break;
+		case CHIP_VEGA10:
+		case CHIP_VEGA20:
+		case CHIP_ARCTURUS:
+			soc15_set_virt_ops(adev);
+			break;
+		case CHIP_NAVI10:
+		case CHIP_NAVI12:
+		case CHIP_SIENNA_CICHLID:
+			nv_set_virt_ops(adev);
+			/* try send GPU_INIT_DATA request to host */
+			amdgpu_virt_request_init_data(adev);
+			break;
+		default: /* other chip doesn't support SRIOV */
+			DRM_ERROR("Unknown asic type: %d!\n", adev->asic_type);
+			break;
+		}
+	}
 }
 
 static bool amdgpu_virt_access_debugfs_is_mmio(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index a7cfe3ac7cb6..4b87506cb005 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -420,6 +420,11 @@ static int nv_reg_base_init(struct amdgpu_device *adev)
 	return 0;
 }
 
+void nv_set_virt_ops(struct amdgpu_device *adev)
+{
+	adev->virt.ops = &xgpu_nv_virt_ops;
+}
+
 int nv_set_ip_blocks(struct amdgpu_device *adev)
 {
 	int r;
@@ -427,12 +432,6 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 	adev->nbio.funcs = &nbio_v2_3_funcs;
 	adev->nbio.hdp_flush_reg = &nbio_v2_3_hdp_flush_reg;
 
-	if (amdgpu_sriov_vf(adev)) {
-		adev->virt.ops = &xgpu_nv_virt_ops;
-		/* try send GPU_INIT_DATA request to host */
-		amdgpu_virt_request_init_data(adev);
-	}
-
 	/* Set IP register base before any HW register access */
 	r = nv_reg_base_init(adev);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.h b/drivers/gpu/drm/amd/amdgpu/nv.h
index b6a95f0122fb..aeef50a6a54b 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.h
+++ b/drivers/gpu/drm/amd/amdgpu/nv.h
@@ -28,6 +28,7 @@
 
 void nv_grbm_select(struct amdgpu_device *adev,
 		    u32 me, u32 pipe, u32 queue, u32 vmid);
+void nv_set_virt_ops(struct amdgpu_device *adev);
 int nv_set_ip_blocks(struct amdgpu_device *adev);
 int navi10_reg_base_init(struct amdgpu_device *adev);
 int navi14_reg_base_init(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 3e406eeeaff6..0a3031fb90f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -669,6 +669,11 @@ static uint32_t soc15_get_rev_id(struct amdgpu_device *adev)
 	return adev->nbio.funcs->get_rev_id(adev);
 }
 
+void soc15_set_virt_ops(struct amdgpu_device *adev)
+{
+	adev->virt.ops = &xgpu_ai_virt_ops;
+}
+
 int soc15_set_ip_blocks(struct amdgpu_device *adev)
 {
 	int r;
@@ -722,9 +727,6 @@ int soc15_set_ip_blocks(struct amdgpu_device *adev)
 
 	adev->rev_id = soc15_get_rev_id(adev);
 
-	if (amdgpu_sriov_vf(adev))
-		adev->virt.ops = &xgpu_ai_virt_ops;
-
 	switch (adev->asic_type) {
 	case CHIP_VEGA10:
 	case CHIP_VEGA12:
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.h b/drivers/gpu/drm/amd/amdgpu/soc15.h
index b03f950c486c..8f38f047265b 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.h
@@ -90,6 +90,7 @@ struct soc15_ras_field_entry {
 
 void soc15_grbm_select(struct amdgpu_device *adev,
 		    u32 me, u32 pipe, u32 queue, u32 vmid);
+void soc15_set_virt_ops(struct amdgpu_device *adev);
 int soc15_set_ip_blocks(struct amdgpu_device *adev);
 
 void soc15_program_register_sequence(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index af8986a55354..4e5e91888d87 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -1705,11 +1705,13 @@ static const struct amdgpu_ip_block_version vi_common_ip_block =
 	.funcs = &vi_common_ip_funcs,
 };
 
-int vi_set_ip_blocks(struct amdgpu_device *adev)
+void vi_set_virt_ops(struct amdgpu_device *adev)
 {
-	if (amdgpu_sriov_vf(adev))
-		adev->virt.ops = &xgpu_vi_virt_ops;
+	adev->virt.ops = &xgpu_vi_virt_ops;
+}
 
+int vi_set_ip_blocks(struct amdgpu_device *adev)
+{
 	switch (adev->asic_type) {
 	case CHIP_TOPAZ:
 		/* topaz has no DCE, UVD, VCE */
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.h b/drivers/gpu/drm/amd/amdgpu/vi.h
index defb4aaf929a..9718f98f8533 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.h
+++ b/drivers/gpu/drm/amd/amdgpu/vi.h
@@ -28,6 +28,7 @@
 
 void vi_srbm_select(struct amdgpu_device *adev,
 		    u32 me, u32 pipe, u32 queue, u32 vmid);
+void vi_set_virt_ops(struct amdgpu_device *adev);
 int vi_set_ip_blocks(struct amdgpu_device *adev);
 
 void legacy_doorbell_index_init(struct amdgpu_device *adev);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
