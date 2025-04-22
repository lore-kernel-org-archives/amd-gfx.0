Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF31BC369AB
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Apr 2025 02:11:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A53910E0AC;
	Tue, 22 Apr 2025 02:11:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dJHntk1B";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 990B410E0AC
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Apr 2025 02:11:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uY5EaDOxSKDyOttMiKZjxidx69qsHT7EaFNMCHS5ayPD0mMcmmnAvI9A66Vjsx6xm0W8vG9cj1kIMuy0txJda49VmVpj+XFzmNyULPshBKUHyssOnVk99NJKOD1JhSlLilH+du5uAWK9UElSJXB4wPewy47gjbxSvudH4/gtq2JwfRGqejIubSiqnETvgDw1R2IY/uG8h8RGwhUHzFSfL/wOWMueox9qR3DgIysknGH8wX6txItgf1WUxWZrD6Fu+eLzAJTSY3v0e9bJ3VR1ZCNV9ukkqQgfU1h1sMAFmrGXCtOLswQcZ4DurcsxrNRw4IKki3rqFiC9NX/P7Ci3pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cYK2CPaOv7ji582T58n2PExpCeIjbR9DI90QrqQXpho=;
 b=qyTouws6L1AOtehKMIAvwzsnfzhdCGGpJjj9ktn4kJLrB0L6lFdhKibnLG54m0qSKulQLXJCbFi4MgIM0LQodD+j+orLsToaaXky9/wymGRpjrx0VKxxDLok75kQ5osrZ5a4+ROn0e0fmPBs+w/LS7g2CAmqS8JMuF/3Tik8EjEkXvcwySeoyloyuHoW2FWNxdspjD6zQET77QodsksaALMYg/AgLAuTvHO6qnLfHRVz34eqRRhF90Li2MtiSbEtucd/AZZqqOj39tlM+rkz3kzvN+OKXrUMeywRWxF4VulU25TnZe/1MwLViNzikoFTmJeDRQCLZWZS5YgD6I0uiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cYK2CPaOv7ji582T58n2PExpCeIjbR9DI90QrqQXpho=;
 b=dJHntk1Bof4wohEQeLWPas5FrHzk45ehiSEMx7dC6vVDvyYfpAUfDHk/alxDU09dZ78UWeH6SINnpFfAMX6SWdXmrWqJ2Bi590ywwr11W4sT6Gf7p7tgR1ucMZsqPnzQHwsmCweKXoDhqVuysg2pnokEe00lfwvP7HbPOuItB9Y=
Received: from SJ0PR13CA0032.namprd13.prod.outlook.com (2603:10b6:a03:2c2::7)
 by SJ0PR12MB6879.namprd12.prod.outlook.com (2603:10b6:a03:484::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Tue, 22 Apr
 2025 02:11:09 +0000
Received: from SJ5PEPF00000204.namprd05.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::d8) by SJ0PR13CA0032.outlook.office365.com
 (2603:10b6:a03:2c2::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.16 via Frontend Transport; Tue,
 22 Apr 2025 02:11:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF00000204.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 22 Apr 2025 02:11:08 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Apr
 2025 21:11:07 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Apr
 2025 21:11:06 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 21 Apr 2025 21:11:05 -0500
From: Yifan Zha <Yifan.Zha@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Hawking.Zhang@amd.com>, <Dennis.Li@amd.com>, <christian.koenig@amd.com>
CC: <ZhenGuo.Yin@amd.com>, <haijun.chang@amd.com>, Yifan Zha
 <Yifan.Zha@amd.com>
Subject: [PATCH] drm/amdgpu: refine MES register print for devices of hive
Date: Tue, 22 Apr 2025 10:10:52 +0800
Message-ID: <20250422021051.1377427-1-Yifan.Zha@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000204:EE_|SJ0PR12MB6879:EE_
X-MS-Office365-Filtering-Correlation-Id: c0e03b97-317d-4621-e2cd-08dd8142f23b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?76w/v6HFnFT1c3LJNRQoq0yetcPVS6TtI8wQa2UcKwciUiF3JGCx/9cdO3RK?=
 =?us-ascii?Q?Bl0BX0svx2UjQEENrYsYXj0VNzbkm0PdtBq1ZU1JvHjYN8t7njmnXPBPdf/u?=
 =?us-ascii?Q?YEl/BVkbhVvo+hDlD3KaSVUup8YdM5v6U0DqDz2hNWTWrt9XLJ7RD6IzZ538?=
 =?us-ascii?Q?v6tNV6NuXcItIDYPpX6QrzUFcuE56XM+vzNHhfX09u3gSJPo/rkc/d4e9LV9?=
 =?us-ascii?Q?2tXp+FAGef/ReIeKL4FRWletgjN7O6iF57dqpQCgJN08AvKAUl+Ka74XEQl4?=
 =?us-ascii?Q?9aeS4tSf944grhzB7j6+rf8/QciVzX4TSqnoIsmMt5J4z6VU2wDN/h1mwsFQ?=
 =?us-ascii?Q?z4v6MapiAxPPDSOASXaLAI7VmXMSd/zxPUvefLWlGUnXw+fpKQAKKwFHFPP7?=
 =?us-ascii?Q?q6ZV9gDFIyghLLPpzrjqY4chJzFyqpFSE7DW7RlxBh3Mfj6y1x4jmrcKZUXN?=
 =?us-ascii?Q?BLBlxlEDCJ6QnZo97Jpht5b9NDHecJnc09fyN0KeFqrNde3Ykk5QG7zR6uWt?=
 =?us-ascii?Q?jxDAEE0HMMNurRQH+/xhkMD1dHxHZu7/hPyzr0mX2SbrxgJOsPEuP4qHojN7?=
 =?us-ascii?Q?M6/MbkvfrliJmSF/fDbbZ9h4aiE8cfB7n9V+S48wFP7gwcpseeQPJNEOvlLa?=
 =?us-ascii?Q?mfAXwaYjH8gNPnYt2+5LdJaOYq2NiLiWaz00CRPWXjCavyEEsSX2uHgenpwO?=
 =?us-ascii?Q?G40S4cMNojDmsYeUm0MutxuH2uAUrd0gLcV+pulDbi6w7DBaAlLDaTPdhVBT?=
 =?us-ascii?Q?vnKgULi4XeUIfZSF1kDlNUSXVzCGVnGAi/qYlPf2BMNNXXAkZRn6wbOv1h2L?=
 =?us-ascii?Q?If1CSFPWHotjTHbSTzFzRL8ulUAFhwJLhrITeHlzLlbKggPyFMqZZedwL5+/?=
 =?us-ascii?Q?vy/U3tVvEGyYI4Zlj4EPsGjv8U7SpNBJDJKousWrK3Q6PKUf5xovZrxG8o1T?=
 =?us-ascii?Q?arBrJ2N5cSL1vuFqTRAYcHbx1Vjt9KisNcxe0f54hl0NH3ZvkFfpaX0Enbte?=
 =?us-ascii?Q?ASZrbeyFUiXvp23Oz/kHSSTx7clldaXgAF0+iYhG7bHl59lYhJS5xfCOESUC?=
 =?us-ascii?Q?zl9iVUTWoJydGX+gZN5RLb2CkAHCM3/QgL0ZPVoAvquU6I8ZsPyyOiNXM8Sg?=
 =?us-ascii?Q?mOM3rG4ABivAlpqQmtu5FPcM3c+z5w8AVWBRj0IXYQ4Mc6u+pujg5nneZUJz?=
 =?us-ascii?Q?zVsLXafP0Bt7/I65braQSvQpH4yXqy51ty1WA9ckZUtGKgTAdP9e3f+QLZ5I?=
 =?us-ascii?Q?YNS5FsyVhiAuKMPFYKiVaeMMNZOkWhnBOYxhCvK6Yy79E6sYggQ4awB/CC+9?=
 =?us-ascii?Q?cS8gzpV0u3LweMIrupKoOxg0s1ZCXa2qS0euCdG0VPSCfQ2t3rrbfspRJPsj?=
 =?us-ascii?Q?vFadIYvwmZPI7hCrJoJkaAgSOxjWiG9XrQXVVWCN+e2EylRDliXJFnKuwcqX?=
 =?us-ascii?Q?xBu2LaaFisPgNguMC+q1NNNw9eJb/PKreqszwh9JXNRDmiahY7RwYqfgWwHE?=
 =?us-ascii?Q?h2DplInLJ7OsA2TnyEOdkLXS9ANM2J7bukDk?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 02:11:08.6907 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0e03b97-317d-4621-e2cd-08dd8142f23b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000204.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6879
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Register access print missed device info.

[How]
Using dev_xxx instead of DRM_xxx to indicate which device
of a hive is the message for.

Signed-off-by: Yifan Zha <Yifan.Zha@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 72e5677cd545..aeabe3c52bb2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -907,7 +907,7 @@ uint32_t amdgpu_mes_rreg(struct amdgpu_device *adev, uint32_t reg)
 	uint32_t *read_val_ptr;
 
 	if (amdgpu_device_wb_get(adev, &addr_offset)) {
-		DRM_ERROR("critical bug! too many mes readers\n");
+		dev_err(adev->dev, "critical bug! too many mes readers\n");
 		goto error;
 	}
 	read_val_gpu_addr = adev->wb.gpu_addr + (addr_offset * 4);
@@ -917,13 +917,13 @@ uint32_t amdgpu_mes_rreg(struct amdgpu_device *adev, uint32_t reg)
 	op_input.read_reg.buffer_addr = read_val_gpu_addr;
 
 	if (!adev->mes.funcs->misc_op) {
-		DRM_ERROR("mes rreg is not supported!\n");
+		dev_err(adev->dev, "mes rreg is not supported!\n");
 		goto error;
 	}
 
 	r = adev->mes.funcs->misc_op(&adev->mes, &op_input);
 	if (r)
-		DRM_ERROR("failed to read reg (0x%x)\n", reg);
+		dev_err(adev->dev, "failed to read reg (0x%x)\n", reg);
 	else
 		val = *(read_val_ptr);
 
@@ -944,14 +944,14 @@ int amdgpu_mes_wreg(struct amdgpu_device *adev,
 	op_input.write_reg.reg_value = val;
 
 	if (!adev->mes.funcs->misc_op) {
-		DRM_ERROR("mes wreg is not supported!\n");
+		dev_err(adev->dev, "mes wreg is not supported!\n");
 		r = -EINVAL;
 		goto error;
 	}
 
 	r = adev->mes.funcs->misc_op(&adev->mes, &op_input);
 	if (r)
-		DRM_ERROR("failed to write reg (0x%x)\n", reg);
+		dev_err(adev->dev, "failed to write reg (0x%x)\n", reg);
 
 error:
 	return r;
@@ -971,14 +971,14 @@ int amdgpu_mes_reg_write_reg_wait(struct amdgpu_device *adev,
 	op_input.wrm_reg.mask = mask;
 
 	if (!adev->mes.funcs->misc_op) {
-		DRM_ERROR("mes reg_write_reg_wait is not supported!\n");
+		dev_err(adev->dev, "mes reg_write_reg_wait is not supported!\n");
 		r = -EINVAL;
 		goto error;
 	}
 
 	r = adev->mes.funcs->misc_op(&adev->mes, &op_input);
 	if (r)
-		DRM_ERROR("failed to reg_write_reg_wait\n");
+		dev_err(adev->dev, "failed to reg_write_reg_wait\n");
 
 error:
 	return r;
@@ -996,14 +996,14 @@ int amdgpu_mes_reg_wait(struct amdgpu_device *adev, uint32_t reg,
 	op_input.wrm_reg.mask = mask;
 
 	if (!adev->mes.funcs->misc_op) {
-		DRM_ERROR("mes reg wait is not supported!\n");
+		dev_err(adev->dev, "mes reg wait is not supported!\n");
 		r = -EINVAL;
 		goto error;
 	}
 
 	r = adev->mes.funcs->misc_op(&adev->mes, &op_input);
 	if (r)
-		DRM_ERROR("failed to reg_write_reg_wait\n");
+		dev_err(adev->dev, "failed to reg_write_reg_wait\n");
 
 error:
 	return r;
-- 
2.25.1

