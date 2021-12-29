Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E550EC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Dec 2021 06:33:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62D1510E449;
	Wed, 29 Dec 2021 06:33:18 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2047.outbound.protection.outlook.com [40.107.102.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0542010E405
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Dec 2021 06:33:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j8rkDnrWZXq+6v4Jn5/ni6ku27VVzSM/ITVKic6nGSMijkazsJx16Xy50dnk261dKL+blFn48pJh4cUkIPsecpiZPPxT1MW7s4UdvvaqTn995nzzKEgCbvkKOjvhRK/wp9H+SKRXCyz4vIP0SHfOOn5NVz+Z8kyzfyn+gURKdB4yUJzk/76oRDqF2TkaGDUSvqUZrTGvoPtfq5MhmFOLZyq5bHow909NKBZlzjQicowQ9fHRFpYDu8xUl0gkDJ+Ki5UljKbJOj3W34d2qV8RT97PC+pzNOn7/v/Tw8XIkiMJeqPTsYLl0eE/hcpL9nxPts8vPpYHi4xjjlp8IeQcqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7TFOyCjr5amveDjQus++trHSm4Z7CNMrbszgAe4JhTY=;
 b=PQlBMEMxpOekppyxOsE+b6eu5ViXVYqjEWZ0HczaTF8BinLsG+F+gbWWyA6a4tzx8VTcoNp6FXVp7AO+F9uVMedTRqSJLrNSQlw1FrMQv8kZBl6sG8pR+YcfqtG85QNfSLRb2Skibd9KKSbsbLN3Ab0KvmWWvSA0WohvqrY5S/5mvO0sA9fzHszUj2zI9XurEHirY30uHRRS/ZzFqlAjD3UpQiCmIgrAk+RVw/AKknmWZi28oT14kVyTxAbqTOVsvHE4Y66rUS8uJHSonp8yrsvtivfZUBOfw1xKSvCHFIu5Iu0bRfv1B576X19/Ilj/c0jenDrM7u+J+cmGZS029Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7TFOyCjr5amveDjQus++trHSm4Z7CNMrbszgAe4JhTY=;
 b=xR0qclPktT6+bVncFYsKdPqzjC4M5GzCU7QhipgctqxhaCrQQssh4mKj1g/o+ue9ANfWRGJcZzefhCuUq6mz7GsoYWIHIVGqZp6cgDTF+8figJPapiEHPLUFj8TSG6xnNRRD8ALC7Sj8+YVIjL3hVTEm6qOkjv3vxcRu2OXF6/Y=
Received: from MWHPR2201CA0053.namprd22.prod.outlook.com
 (2603:10b6:301:16::27) by MWHPR12MB1694.namprd12.prod.outlook.com
 (2603:10b6:301:11::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.21; Wed, 29 Dec
 2021 06:33:09 +0000
Received: from CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:16:cafe::60) by MWHPR2201CA0053.outlook.office365.com
 (2603:10b6:301:16::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19 via Frontend
 Transport; Wed, 29 Dec 2021 06:33:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT043.mail.protection.outlook.com (10.13.174.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4844.14 via Frontend Transport; Wed, 29 Dec 2021 06:33:08 +0000
Received: from thomas.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 29 Dec
 2021 00:33:06 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 09/12] drm/amdgpu: Modify sdma block to fit for the unified
 ras block data and ops
Date: Wed, 29 Dec 2021 14:32:08 +0800
Message-ID: <20211229063211.43840-9-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211229063211.43840-1-YiPeng.Chai@amd.com>
References: <20211229063211.43840-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7a8c8f7-e764-4453-31b6-08d9ca951465
X-MS-TrafficTypeDiagnostic: MWHPR12MB1694:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB169446013B133C93A2EEAA16FC449@MWHPR12MB1694.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZJFYSDQVXKKVfnXWo1DX5xx5Sbn5QtypDSL1WUZqnVQZdh5yzvAp7ExzkEW/YQYocHXhYdnvziguW1yiNFEnBX9RAmDN2J9eOeGdIBLrW6m0fxmuSXbrHsh/Y4y8b4yCohz13E8m81z2b0Bo3+To4KzWwlwnt3naL/IoQjUo3F/9LfakXAQmAgd3p63beHNt+s2QQC8zEc8KMfoPwWA9WlPMuA8k/KTndzT10yJZF78MUcjsKy1r6WTqSvE0uMv+Ne3+lgxuVjtXmLr0k1dWbxJwukWXFm2qpZX3Oi2yz64NVQB2tTYa3/NNgGMHupOl3P4RK1/6Wz+NbLRtmUZ72Q48/PYUiOgplcsv90UUdZZvDSvwHMif+4QAZdUxCg2OYvtkYOTW3ehTjAJpRuaRPuYpj026AtSp89cE4eTaa6Oz2E9ouLKr0QLjq8ZEh+xIkp/Ww63P9tCwi5U31NvkUOKum2NdoSgM7Xq8rvfJ5xNK864K+KWfDacFDkjnjoXHefVvEmh5xcGoNEdBMZvbaFbwZr7RPrYLxXhkeZ3zKW+UQxCqIDwj9FV4Ay9p4wrY9QphH1e3JeFru4kLoZkmJxxycbYGr28hd+dPD352O/h668C0wfISyON7DBqNWQG3mj/gkGbxCysnna+z1QMkWU0bQiKQYrTSe7/7FZGXIuyDSrpbaCovmBV0STZq5Lwx9Hy106DKkwIQ6N8VIrThA02TmVYwkmdNPy9Qm0A9VDy0IMku/KvpFI0gI4jHJMqbGbOfFgxYHDvdM7vMZ9hCxwzlbuYqkHpenTU4GIkFo0UNPw+Zehk7/IRTTDrdz/SF
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700002)(36840700001)(46966006)(16526019)(70206006)(7696005)(316002)(8676002)(4326008)(70586007)(426003)(8936002)(81166007)(186003)(82310400004)(6916009)(508600001)(2906002)(1076003)(356005)(40460700001)(47076005)(5660300002)(2616005)(36756003)(83380400001)(26005)(54906003)(336012)(86362001)(36860700001)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2021 06:33:08.9187 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7a8c8f7-e764-4453-31b6-08d9ca951465
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1694
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
Cc: Tao.Zhou1@amd.com, Hawking.Zhang@amd.com, John.Clements@amd.com,
 yipechai <YiPeng.Chai@amd.com>, yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

1.Modify sdma block to fit for the unified ras block data and ops.
2.Change amdgpu_sdma_ras_funcs to amdgpu_sdma_ras, and the corresponding variable name remove _funcs suffix.
3.Remove the const flag of sdma ras variable so that sdma ras block can be able to be inserted into amdgpu device ras block link list.
4.Invoke amdgpu_ras_register_ras_block function to register sdma ras block into amdgpu device ras block link list.
5.Remove the redundant code about sdma in amdgpu_ras.c after using the unified ras block.
6.Fill unified ras block .name .block .ras_late_init and .ras_fini for all of sdma versions. If .ras_late_init and .ras_fini had been defined by the selected sdma version, the defined functions will take effect; if not defined, default fill them with amdgpu_sdma_ras_late_init and amdgpu_sdma_ras_fini.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c  |  9 ----
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h | 12 ++---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   | 58 ++++++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4.c   | 25 ++++++++--
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4.h   |  2 +-
 5 files changed, 71 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 5a8fccfdb0bb..4ca51f623751 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -953,12 +953,6 @@ int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
 			block_obj->hw_ops->query_ras_error_address(adev, &err_data);
 		break;
 	case AMDGPU_RAS_BLOCK__SDMA:
-		if (adev->sdma.funcs->query_ras_error_count) {
-			for (i = 0; i < adev->sdma.num_instances; i++)
-				adev->sdma.funcs->query_ras_error_count(adev, i,
-									&err_data);
-		}
-		break;
 	case AMDGPU_RAS_BLOCK__GFX:
 	case AMDGPU_RAS_BLOCK__MMHUB:
 		if (!block_obj || !block_obj->hw_ops)   {
@@ -1064,9 +1058,6 @@ int amdgpu_ras_reset_error_status(struct amdgpu_device *adev,
 			block_obj->hw_ops->reset_ras_error_status(adev);
 		break;
 	case AMDGPU_RAS_BLOCK__SDMA:
-		if (adev->sdma.funcs->reset_ras_error_count)
-			adev->sdma.funcs->reset_ras_error_count(adev);
-		break;
 	case AMDGPU_RAS_BLOCK__HDP:
 		if (!block_obj || !block_obj->hw_ops)	{
 			dev_info(adev->dev, "%s doesn't config ras function \n", ras_block_str(block));
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index f8fb755e3aa6..eaee12ab6518 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -23,6 +23,7 @@
 
 #ifndef __AMDGPU_SDMA_H__
 #define __AMDGPU_SDMA_H__
+#include "amdgpu_ras.h"
 
 /* max number of IP instances */
 #define AMDGPU_MAX_SDMA_INSTANCES		8
@@ -50,13 +51,8 @@ struct amdgpu_sdma_instance {
 	bool			burst_nop;
 };
 
-struct amdgpu_sdma_ras_funcs {
-	int (*ras_late_init)(struct amdgpu_device *adev,
-			void *ras_ih_info);
-	void (*ras_fini)(struct amdgpu_device *adev);
-	int (*query_ras_error_count)(struct amdgpu_device *adev,
-			uint32_t instance, void *ras_error_status);
-	void (*reset_ras_error_count)(struct amdgpu_device *adev);
+struct amdgpu_sdma_ras {
+	struct amdgpu_ras_block_object ras_block;
 };
 
 struct amdgpu_sdma {
@@ -73,7 +69,7 @@ struct amdgpu_sdma {
 	uint32_t                    srbm_soft_reset;
 	bool			has_page_queue;
 	struct ras_common_if	*ras_if;
-	const struct amdgpu_sdma_ras_funcs	*funcs;
+	struct amdgpu_sdma_ras	*ras;
 };
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 69c9e460c1eb..5500f93f6ecd 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1898,13 +1898,13 @@ static int sdma_v4_0_late_init(void *handle)
 	sdma_v4_0_setup_ulv(adev);
 
 	if (!amdgpu_persistent_edc_harvesting_supported(adev)) {
-		if (adev->sdma.funcs &&
-		    adev->sdma.funcs->reset_ras_error_count)
-			adev->sdma.funcs->reset_ras_error_count(adev);
+		if (adev->sdma.ras && adev->sdma.ras->ras_block.hw_ops &&
+		    adev->sdma.ras->ras_block.hw_ops->reset_ras_error_count)
+			adev->sdma.ras->ras_block.hw_ops->reset_ras_error_count(adev);
 	}
 
-	if (adev->sdma.funcs && adev->sdma.funcs->ras_late_init)
-		return adev->sdma.funcs->ras_late_init(adev, &ih_info);
+	if (adev->sdma.ras && adev->sdma.ras->ras_block.ras_late_init)
+		return adev->sdma.ras->ras_block.ras_late_init(adev, &ih_info);
 	else
 		return 0;
 }
@@ -2007,8 +2007,9 @@ static int sdma_v4_0_sw_fini(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int i;
 
-	if (adev->sdma.funcs && adev->sdma.funcs->ras_fini)
-		adev->sdma.funcs->ras_fini(adev);
+	if (adev->sdma.ras && adev->sdma.ras->ras_block.hw_ops &&
+		adev->sdma.ras->ras_block.ras_fini)
+		adev->sdma.ras->ras_block.ras_fini(adev);
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		amdgpu_ring_fini(&adev->sdma.instance[i].ring);
@@ -2745,7 +2746,7 @@ static void sdma_v4_0_get_ras_error_count(uint32_t value,
 	}
 }
 
-static int sdma_v4_0_query_ras_error_count(struct amdgpu_device *adev,
+static int sdma_v4_0_query_ras_error_count_by_instance(struct amdgpu_device *adev,
 			uint32_t instance, void *ras_error_status)
 {
 	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
@@ -2767,6 +2768,18 @@ static int sdma_v4_0_query_ras_error_count(struct amdgpu_device *adev,
 	return 0;
 };
 
+static void sdma_v4_0_query_ras_error_count(struct amdgpu_device *adev,  void *ras_error_status)
+{
+	int i = 0;
+	for (i = 0; i < adev->sdma.num_instances; i++) {
+		if (sdma_v4_0_query_ras_error_count_by_instance(adev, i, ras_error_status))
+		{
+			dev_err(adev->dev, "Query ras error count failed in SDMA%d \n", i);
+			return;
+		}
+	}
+}
+
 static void sdma_v4_0_reset_ras_error_count(struct amdgpu_device *adev)
 {
 	int i;
@@ -2778,26 +2791,45 @@ static void sdma_v4_0_reset_ras_error_count(struct amdgpu_device *adev)
 	}
 }
 
-static const struct amdgpu_sdma_ras_funcs sdma_v4_0_ras_funcs = {
-	.ras_late_init = amdgpu_sdma_ras_late_init,
-	.ras_fini = amdgpu_sdma_ras_fini,
+const struct amdgpu_ras_block_hw_ops sdma_v4_0_ras_hw_ops = {
 	.query_ras_error_count = sdma_v4_0_query_ras_error_count,
 	.reset_ras_error_count = sdma_v4_0_reset_ras_error_count,
 };
 
+static struct amdgpu_sdma_ras sdma_v4_0_ras = {
+	.ras_block = {
+		.hw_ops = &sdma_v4_0_ras_hw_ops,
+	},
+};
+
 static void sdma_v4_0_set_ras_funcs(struct amdgpu_device *adev)
 {
 	switch (adev->asic_type) {
 	case CHIP_VEGA20:
 	case CHIP_ARCTURUS:
-		adev->sdma.funcs = &sdma_v4_0_ras_funcs;
+		adev->sdma.ras = &sdma_v4_0_ras;
 		break;
 	case CHIP_ALDEBARAN:
-		adev->sdma.funcs = &sdma_v4_4_ras_funcs;
+		adev->sdma.ras = &sdma_v4_4_ras;
 		break;
 	default:
 		break;
 	}
+
+	if (adev->sdma.ras) {
+		amdgpu_ras_register_ras_block(adev, &adev->sdma.ras->ras_block);
+
+		strcpy(adev->sdma.ras->ras_block.name,"sdma");
+		adev->sdma.ras->ras_block.block = AMDGPU_RAS_BLOCK__SDMA;
+
+		/* If don't define special ras_late_init function, use default ras_late_init */
+		if (!adev->sdma.ras->ras_block.ras_late_init)
+				adev->sdma.ras->ras_block.ras_late_init = amdgpu_sdma_ras_late_init;
+
+		/* If don't define special ras_fini function, use default ras_fini */
+		if (!adev->sdma.ras->ras_block.ras_fini)
+				adev->sdma.ras->ras_block.ras_fini = amdgpu_sdma_ras_fini;
+	}
 }
 
 const struct amdgpu_ip_block_version sdma_v4_0_ip_block = {
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4.c
index bf95007f0843..5c1ba1116e5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4.c
@@ -188,7 +188,7 @@ static void sdma_v4_4_get_ras_error_count(struct amdgpu_device *adev,
 	}
 }
 
-static int sdma_v4_4_query_ras_error_count(struct amdgpu_device *adev,
+static int sdma_v4_4_query_ras_error_count_by_instance(struct amdgpu_device *adev,
 					   uint32_t instance,
 					   void *ras_error_status)
 {
@@ -245,9 +245,26 @@ static void sdma_v4_4_reset_ras_error_count(struct amdgpu_device *adev)
 	}
 }
 
-const struct amdgpu_sdma_ras_funcs sdma_v4_4_ras_funcs = {
-	.ras_late_init = amdgpu_sdma_ras_late_init,
-	.ras_fini = amdgpu_sdma_ras_fini,
+static void sdma_v4_4_query_ras_error_count(struct amdgpu_device *adev,  void *ras_error_status)
+{
+	int i = 0;
+	for (i = 0; i < adev->sdma.num_instances; i++) {
+		if (sdma_v4_4_query_ras_error_count_by_instance(adev, i, ras_error_status))
+		{
+			dev_err(adev->dev, "Query ras error count failed in SDMA%d \n", i);
+			return;
+		}
+	}
+
+}
+
+const struct amdgpu_ras_block_hw_ops sdma_v4_4_ras_hw_ops = {
 	.query_ras_error_count = sdma_v4_4_query_ras_error_count,
 	.reset_ras_error_count = sdma_v4_4_reset_ras_error_count,
 };
+
+struct amdgpu_sdma_ras sdma_v4_4_ras = {
+	.ras_block = {
+		.hw_ops = &sdma_v4_4_ras_hw_ops,
+	},
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4.h b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4.h
index 74a6e5b5e949..a9f0c68359e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4.h
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4.h
@@ -23,6 +23,6 @@
 #ifndef __SDMA_V4_4_H__
 #define __SDMA_V4_4_H__
 
-extern const struct amdgpu_sdma_ras_funcs sdma_v4_4_ras_funcs;
+extern struct amdgpu_sdma_ras sdma_v4_4_ras;
 
 #endif
-- 
2.25.1

