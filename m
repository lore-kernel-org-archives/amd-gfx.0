Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBC2EC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Dec 2021 06:33:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E57310E3B3;
	Wed, 29 Dec 2021 06:33:03 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2088.outbound.protection.outlook.com [40.107.100.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8453510E3B3
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Dec 2021 06:33:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LWCR1L5qY6lrsXC4wWD1oYH3Uk9MgdE8oqlwcJNlfx2zTDD6ELcZbfnD2G5JS9VLYPt31RLI75SMq7EgkbokBEW0/+e+bwbh3HZtGyRKE39E8Rv8h2h9wklFTqGds74bSvHe0Vf0crMHejO1zw/b3vlafZL4xM0m1e+Seq+cCxqKWxu+wvnUtiF7ufw8WotpPh50HiTfNHisyN2J3nv5yzGllOZwEwlaCqEP2J5kWcONGmECj8Ge8mhkU+qdIzWkND13WQshaLA9d07zcvwNhA8l9qrFluU3llZx6zXsNB6cG1TI8t2VwR4hn28MXykdjQtEeAJJH7DbCeomYQcZWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2RxYhgUWwqK2fh1kE2Ny+t9OM9Iva5AS/LoaODr29Yk=;
 b=A+hFj8dx1ABs1B+xsqP6btfnAlq0WN6iU6uELL+6zpwtusynrkIiTPg1dpbsi0MQeQdoG75limSlgK7MxBIpsIxSIQmVHt/TKVEdBKulloR526L+GgPIHVK1FMzoJ7VBqI/mo/jtaXk16MTmrIBxjJk2sCbB2PY/WgWRJ8p8HHkwYoBR7k3aXl9am8r2s4hDnhkj3od8h4ZhLInpaYbdG4dIEFPDFkf6SZVRZ4ZvhQgE2KK2GmfXKURUpIfv/OoGXJRk+lLFors+O88wuynQoOSqUdcZPY73tGY8BhbJfA9LOJUp27NNnDyXrzPC7kBMNNyiFuoCPx6fjDqOKymx3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2RxYhgUWwqK2fh1kE2Ny+t9OM9Iva5AS/LoaODr29Yk=;
 b=H7wS7wB6zf70B76QUX3VlphlVZZcx5yHkBlJhLMDuyBXjIS6v9Frer2Y/VssLgDPEVG+jbkXrE654srLL/NlcFyeQjRPn6hJW4aKO1+kt/27AiAzL4lDHBfgJWoF/nEHGJLRnjB1ufW2361rjvcnq62ee9WuqjM84kTIkCHQ/Sk=
Received: from MWHPR22CA0050.namprd22.prod.outlook.com (2603:10b6:300:12a::12)
 by BY5PR12MB4918.namprd12.prod.outlook.com (2603:10b6:a03:1df::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19; Wed, 29 Dec
 2021 06:32:59 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:12a:cafe::63) by MWHPR22CA0050.outlook.office365.com
 (2603:10b6:300:12a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14 via Frontend
 Transport; Wed, 29 Dec 2021 06:32:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4844.14 via Frontend Transport; Wed, 29 Dec 2021 06:32:59 +0000
Received: from thomas.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 29 Dec
 2021 00:32:56 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 04/12] drm/amdgpu: Modify xgmi block to fit for the unified
 ras block data and ops
Date: Wed, 29 Dec 2021 14:32:03 +0800
Message-ID: <20211229063211.43840-4-YiPeng.Chai@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3e8814db-d8cb-48ea-670b-08d9ca950e98
X-MS-TrafficTypeDiagnostic: BY5PR12MB4918:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB491892D9635D0EFE8CB47645FC449@BY5PR12MB4918.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zmuoGcN36i77sQfkcBOXzcttUMAuakIPJw7fc2q9rLyJYNkW/vcO4r0VxDxt9dzF2vx8/vPtFEQB8Kz7uwjeSDPhraaQrfqHzRX73TMlkWZqHR1u/yI2Qlhi+Zm7vXJNTULo5tbc/+c6Hvk+n7pyPPV+aDg2cx9xrru37L8jRDdQTTeeRcDWYVfJaNY4IW9Aw3R88gupVNKKnRNxoncjUwJF4oYCF7H6rBLVJ8XLjc7d+nzXuQpk1yv16O0yTXGk9au1FVGWaLFlICI4GRyOV2EdvERIwweeK3HtBvmdREzCCc34w2Tlmh/x0yUDbJvESB+ix0nt7AMVN+Tqip7lGza8KLl1pkI7Bqe4g5G4B6CzYteqczsO3uH+LKN+pbo4ozr+lf146s51cvXHqerZX6A1xwafs/yazSAVMiOvse1eHY/d1Nc2E4rFxVkwKkBQkYLU/CQK+eZBawRHV3IB3adDqC3V0NzuzDqPEAQ7eUu5UoRzWLeJV9tlr6vzNyFCL281TnkQg28ElOmqBncXIJ3X7JeHWbvqAEuM+QWTGDFRMoRvd2cPUXFQlWE/3QfeXnWDVdBH97DHIEP9Vkjrn5nbcSLd88DUVkwrKXxorEPxK7dcflZL8nRwj/+y1J0qyn/qbaIZQ3rue9jb99APJ6GaGFeE+HusqXrI/kzbD4NOn1P9UTuIUR9qq65iOSCrKxCncmTzv0CpMnGrPv49syOSPMipkxls2j+Cz5+Kosc9dZRwnTgBVKE4gu3foatBZBYpC9FTkohLyplnb8BJxGSJND4Z3DGXweFtKFEvejlivzqq3DDe6TVUavR4QPWlDCd7sGS8Ud7EJIzOlT4hrg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(40470700002)(36840700001)(47076005)(7696005)(6916009)(82310400004)(40460700001)(26005)(36756003)(316002)(8676002)(426003)(16526019)(2616005)(86362001)(5660300002)(1076003)(356005)(70586007)(186003)(508600001)(6666004)(83380400001)(8936002)(36860700001)(2906002)(336012)(4326008)(81166007)(70206006)(54906003)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2021 06:32:59.1723 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e8814db-d8cb-48ea-670b-08d9ca950e98
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4918
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

1.Modify gmc block to fit for the unified ras block data and ops.
2.Change amdgpu_xgmi_ras_funcs to amdgpu_xgmi_ras, and the corresponding variable name remove _funcs suffix.
3.Remove the const flag of gmc ras variable so that gmc ras block can be able to be inserted into amdgpu device ras block link list.
4.Invoke amdgpu_ras_register_ras_block function to register gmc ras block into amdgpu device ras block link list.
5.Remove the redundant code about gmc in amdgpu_ras.c after using the unified ras block.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c  | 16 +++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h  | 11 ++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c  | 10 ++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 26 +++++++++++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h |  4 ++--
 5 files changed, 37 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 83f26bca7dac..af65ec46f783 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -448,12 +448,13 @@ int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev)
 			return r;
 	}
 
-	if (!adev->gmc.xgmi.connected_to_cpu)
-		adev->gmc.xgmi.ras_funcs = &xgmi_ras_funcs;
+	if (!adev->gmc.xgmi.connected_to_cpu) {
+		adev->gmc.xgmi.ras = &xgmi_ras;
+		amdgpu_ras_register_ras_block(adev, &adev->gmc.xgmi.ras->ras_block);
+	}
 
-	if (adev->gmc.xgmi.ras_funcs &&
-	    adev->gmc.xgmi.ras_funcs->ras_late_init) {
-		r = adev->gmc.xgmi.ras_funcs->ras_late_init(adev);
+	if (adev->gmc.xgmi.ras && adev->gmc.xgmi.ras->ras_block.ras_late_init) {
+		r = adev->gmc.xgmi.ras->ras_block.ras_late_init(adev, NULL);
 		if (r)
 			return r;
 	}
@@ -499,9 +500,8 @@ void amdgpu_gmc_ras_fini(struct amdgpu_device *adev)
 	    adev->mmhub.ras_funcs->ras_fini)
 		adev->mmhub.ras_funcs->ras_fini(adev);
 
-	if (adev->gmc.xgmi.ras_funcs &&
-	    adev->gmc.xgmi.ras_funcs->ras_fini)
-		adev->gmc.xgmi.ras_funcs->ras_fini(adev);
+	if (adev->gmc.xgmi.ras && adev->gmc.xgmi.ras->ras_block.ras_fini)
+		adev->gmc.xgmi.ras->ras_block.ras_fini(adev);
 
 	if (adev->hdp.ras_funcs &&
 	    adev->hdp.ras_funcs->ras_fini)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index e55201134a01..923db5ff5859 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -29,6 +29,7 @@
 #include <linux/types.h>
 
 #include "amdgpu_irq.h"
+#include "amdgpu_ras.h"
 
 /* VA hole for 48bit addresses on Vega10 */
 #define AMDGPU_GMC_HOLE_START	0x0000800000000000ULL
@@ -135,12 +136,8 @@ struct amdgpu_gmc_funcs {
 	unsigned int (*get_vbios_fb_size)(struct amdgpu_device *adev);
 };
 
-struct amdgpu_xgmi_ras_funcs {
-	int (*ras_late_init)(struct amdgpu_device *adev);
-	void (*ras_fini)(struct amdgpu_device *adev);
-	int (*query_ras_error_count)(struct amdgpu_device *adev,
-				     void *ras_error_status);
-	void (*reset_ras_error_count)(struct amdgpu_device *adev);
+struct amdgpu_xgmi_ras {
+	struct amdgpu_ras_block_object ras_block;
 };
 
 struct amdgpu_xgmi {
@@ -159,7 +156,7 @@ struct amdgpu_xgmi {
 	struct ras_common_if *ras_if;
 	bool connected_to_cpu;
 	bool pending_reset;
-	const struct amdgpu_xgmi_ras_funcs *ras_funcs;
+	struct amdgpu_xgmi_ras *ras;
 };
 
 struct amdgpu_gmc {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 8ca1f294c202..8b0d11bb8186 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -982,9 +982,13 @@ int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
 			adev->nbio.ras_funcs->query_ras_error_count(adev, &err_data);
 		break;
 	case AMDGPU_RAS_BLOCK__XGMI_WAFL:
-		if (adev->gmc.xgmi.ras_funcs &&
-		    adev->gmc.xgmi.ras_funcs->query_ras_error_count)
-			adev->gmc.xgmi.ras_funcs->query_ras_error_count(adev, &err_data);
+		if (!block_obj || !block_obj->hw_ops)	{
+			dev_info(adev->dev, "%s doesn't config ras function \n",
+				get_ras_block_str(&info->head));
+			return -EINVAL;
+		}
+		if (block_obj->hw_ops->query_ras_error_count)
+			block_obj->hw_ops->query_ras_error_count(adev, &err_data);
 		break;
 	case AMDGPU_RAS_BLOCK__HDP:
 		if (adev->hdp.ras_funcs &&
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 0d149f5f000e..e3c6898c5d13 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -725,7 +725,7 @@ int amdgpu_xgmi_remove_device(struct amdgpu_device *adev)
 	return psp_xgmi_terminate(&adev->psp);
 }
 
-static int amdgpu_xgmi_ras_late_init(struct amdgpu_device *adev)
+static int amdgpu_xgmi_ras_late_init(struct amdgpu_device *adev, void *ras_info)
 {
 	int r;
 	struct ras_ih_if ih_info = {
@@ -739,7 +739,7 @@ static int amdgpu_xgmi_ras_late_init(struct amdgpu_device *adev)
 	    adev->gmc.xgmi.num_physical_nodes == 0)
 		return 0;
 
-	adev->gmc.xgmi.ras_funcs->reset_ras_error_count(adev);
+	adev->gmc.xgmi.ras->ras_block.hw_ops->reset_ras_error_count(adev);
 
 	if (!adev->gmc.xgmi.ras_if) {
 		adev->gmc.xgmi.ras_if = kmalloc(sizeof(struct ras_common_if), GFP_KERNEL);
@@ -859,7 +859,7 @@ static int amdgpu_xgmi_query_pcs_error_status(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int amdgpu_xgmi_query_ras_error_count(struct amdgpu_device *adev,
+static void amdgpu_xgmi_query_ras_error_count(struct amdgpu_device *adev,
 					     void *ras_error_status)
 {
 	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
@@ -868,7 +868,7 @@ static int amdgpu_xgmi_query_ras_error_count(struct amdgpu_device *adev,
 	uint32_t ue_cnt = 0, ce_cnt = 0;
 
 	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__XGMI_WAFL))
-		return -EINVAL;
+		return ;
 
 	err_data->ue_count = 0;
 	err_data->ce_count = 0;
@@ -934,17 +934,23 @@ static int amdgpu_xgmi_query_ras_error_count(struct amdgpu_device *adev,
 		break;
 	}
 
-	adev->gmc.xgmi.ras_funcs->reset_ras_error_count(adev);
+	adev->gmc.xgmi.ras->ras_block.hw_ops->reset_ras_error_count(adev);
 
 	err_data->ue_count += ue_cnt;
 	err_data->ce_count += ce_cnt;
-
-	return 0;
 }
 
-const struct amdgpu_xgmi_ras_funcs xgmi_ras_funcs = {
-	.ras_late_init = amdgpu_xgmi_ras_late_init,
-	.ras_fini = amdgpu_xgmi_ras_fini,
+struct amdgpu_ras_block_hw_ops  xgmi_ras_hw_ops = {
 	.query_ras_error_count = amdgpu_xgmi_query_ras_error_count,
 	.reset_ras_error_count = amdgpu_xgmi_reset_ras_error_count,
 };
+
+struct amdgpu_xgmi_ras xgmi_ras = {
+	.ras_block = {
+		.name = "xgmi",
+		.block = AMDGPU_RAS_BLOCK__XGMI_WAFL,
+		.hw_ops = &xgmi_ras_hw_ops,
+		.ras_late_init = amdgpu_xgmi_ras_late_init,
+		.ras_fini = amdgpu_xgmi_ras_fini,
+	},
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
index d2189bf7d428..0afca51c3c0c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
@@ -24,7 +24,7 @@
 
 #include <drm/task_barrier.h>
 #include "amdgpu_psp.h"
-
+#include "amdgpu_ras.h"
 
 struct amdgpu_hive_info {
 	struct kobject kobj;
@@ -50,7 +50,7 @@ struct amdgpu_pcs_ras_field {
 	uint32_t pcs_err_shift;
 };
 
-extern const struct amdgpu_xgmi_ras_funcs xgmi_ras_funcs;
+extern struct amdgpu_xgmi_ras  xgmi_ras;
 struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct amdgpu_device *adev);
 void amdgpu_put_xgmi_hive(struct amdgpu_hive_info *hive);
 int amdgpu_xgmi_update_topology(struct amdgpu_hive_info *hive, struct amdgpu_device *adev);
-- 
2.25.1

