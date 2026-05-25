Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED2B7CD5BB1
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2026 18:15:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 781FC10E223;
	Mon, 25 May 2026 18:15:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="c+uhhtGt";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012067.outbound.protection.outlook.com [52.101.43.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8F9510E223
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2026 18:15:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jcfd8kNVSwoPgnvkrypgQvi8jYeTcEjVWDCgH4yqMVsxvI64xsAxS+71Bsex7DpzUnjY1i8bYuThLUhysnldhzZb3P6G5U2NHMQbbECY6EsP+5p+lnQuw/JcP+pqqMxHKe5xUyfbKnfRGcx6whR+2JPKssc5uJdy/92oqDS+Opt+XE6Tlj7lrU+XPKpHNJJH7VAl4OLlX3aw6LAgYdYPBjtT1YeiwAzB08VIbzzz5GVsgvoFolemotHQCyDsMk7EmhuJ8tQHkQTLYnCTRSWWSqauTbEyUoYfxGmDqSPuXEQDOz+lRnpDMThSmxVM+YipmUt7QiOmi3K7ExiuRUfoPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8oLvCMCknMjkhAU1/ZpkxcYaMVG6NMaMeMreFDC5bCc=;
 b=mW+VJLSX16lKKAyeSr8AJiYDzKzIHdPFxt0kwhIRIXftCMp6BkOVHRxY8ibBzVZjemnmG7fJHlV5zoJV11wo7WSQReVUevq0wjLOkWZiN3K/JIH7COPmrSOM3vtnpUltfYH/zTlJJv0b+o6HRPKzZMkXwOj0Ut+SZZZZHHeP35Xw3/CmqU8OJ26IJyD1rwjxTcuqyfYke9zFHRdlh0AqwABOJd9Tf5RT+nHxyiE53kDvmIIUgmf7BlKXP97yBNJVQ5bCiHqn4KKc7a0+DlG9/t92yRjIusC8bBdlZi49DUqQIKlL+r+2KlBDRdnYU/7Jvh3BbQ2RDih90J0yRGx/xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8oLvCMCknMjkhAU1/ZpkxcYaMVG6NMaMeMreFDC5bCc=;
 b=c+uhhtGtrX4nAanC0/vEPE4bOG6tg2APzeJBSDbWxnyeNHbKsuCMujdqXUYZMxVEvJDBdihJZi455d3FknzQiC6Y7wzY4QizJMkMYx01dEEei1t4E57/79POZb2uHn61BUbtTueiNPAqHdEfxRQ1NS9JZFVz4F/v5WkVtg8gGUw=
Received: from MN2PR08CA0002.namprd08.prod.outlook.com (2603:10b6:208:239::7)
 by SAWPR12MB999140.namprd12.prod.outlook.com (2603:10b6:806:4e2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.16; Mon, 25 May
 2026 18:15:13 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10b6:208:239:cafe::19) by MN2PR08CA0002.outlook.office365.com
 (2603:10b6:208:239::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.20 via Frontend Transport; Mon, 25
 May 2026 18:15:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Mon, 25 May 2026 18:15:12 +0000
Received: from sclement-ThinkStation-P8.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Mon, 25 May 2026 13:15:11 -0500
From: Sunday Clement <Sunday.Clement@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <mukul.joshi@amd.com>,
 <Harish.Kasiviswanathan@amd.com>, Sunday Clement <Sunday.Clement@amd.com>
Subject: [PATCH] drm/amdkfd: Add missing SE/SH bounds checks in
 mqd_symmetrically_map_cu_mask_v12_1
Date: Mon, 25 May 2026 14:14:29 -0400
Message-ID: <20260525181429.28636-1-Sunday.Clement@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|SAWPR12MB999140:EE_
X-MS-Office365-Filtering-Correlation-Id: bb111b46-f1ac-41bb-390d-08deba899024
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|18002099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info: fNrnBd2pdveY7gD9hlJVqZv1dMqiueiuP5t+fWZT+QExL7UmdYFkZFECWeK5PRQKm9BmyAxAXBx9LhRLcIP2t0BvYZPlXpypMUkv/K0zH0XxXpE3N5t7gdpyzYVX4KcWnRd18RV7OTAaqqygc7lwsgDD04cmlLRik8rK02lh74QK8RYStuy3KRwHaQv2Vuxg7zLeFJS0z3H2FW1arnqgauX+UOBCW64b9heJcDhdEawEBfirfCBREotFVc7r8SF8KymL8uYl631GpyXcCypbeODAMO8AsE80hBgkPFzZhdOpwwQAjn9CEGUOdGl064xQrh6tZnW0kHs3n9CewTm7QihfxjEpnOHRi1uG42N2JF23+bQp0sdEGUMF8sV2Nn1zX9aRVQXZWr5mxMAuZdC5kzm1E8/hY35rZkKSelRyiR0jUNtyohOaIi806rmbPmOR7TzXCM59RlXl3RkPFx6zoKj37+ZY1zPW8xe8t0u6MOQfG8jmzsup8V4W83np1r0s3zwB2ntbrrm3aSUqj+IW1wBNoAMLQQ0t19fT4zVNySAsQR91I07B8X1xq7NJN59dApd25B+gqpVN9xyErjHcg69wGHVTmiOHJSW6yeeiXM/Glkpsj8rfOhQeiiBIUX3EstbK6Trskheqn4rimODGcu/v0NnfRpeE+ur3wu1IsH0ikJ5MkA5CrQuavGR3oHMdvlbQe8QQ/l7MBEEqjehhURGjEnp8RxxESTqg0u7n10s=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(18002099003)(56012099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4LgmaWieB8+zkdREbTAk7NIKPM6lK0gu064vwqffzoIBHSkc4Ye4PCFriUzOZiBXl1J5ll7pZFIttXdTsl2+19d0sKtF5wVzS8p7cZEoze5rjGUOoqMOPKC19j8nDL2J2x6giMIEKLU3B0mJiRvFIg5+j9xBUaWC9rHlijxPvZaHQeu+aWhWN3yH5c20+pzu8MBmp4C9r3Ql+ruTDFV8jw2BM+N6/DiUgP8LnZgmNhn5+9gF04nas1ekLNIj+2IF79LX1Zbs3ul26ZDzJ9EONafJcKUjsaVr6K4Fom/c+hp1rPsVw2ibZMkcrI+pvf+Ut7HMfHZmJN/DkJSMFXzSD9AecMiX/NEQ3E2k3uRAUdwNSFCQk8hSmB6gKaujTWIdnQwq/MHcll5AucUrPjqFmCeY8MLqDqc4hN3hStiK/MDh5vJFXYbr/RhB5+tL47jH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 18:15:12.4315 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb111b46-f1ac-41bb-390d-08deba899024
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999140
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

The function mqd_symmetrically_map_cu_mask_v12_1() indexes a fixed-size
array cu_per_sh[2][2] using hardware-reported values from
gfx_info->max_shader_engines and gfx_info->max_sh_per_se without
validating they are within array bounds.

This can cause stack buffer overflow if hardware reports more than 2
shader engines or more than 2 shader arrays per engine. The lack of
bounds checking is a risk for future hardware and is a regression from
the v12 implementation, which checks these bounds via
mqd_symmetrically_map_cu_mask() in gfx12.

Signed-off-by: Sunday Clement <Sunday.Clement@amd.com>
---
 .../drm/amd/amdkfd/kfd_mqd_manager_v12_1.c    | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
index 9014912ed82c..fb9d4fb6705f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
@@ -52,7 +52,7 @@ static void mqd_symmetrically_map_cu_mask_v12_1(struct mqd_manager *mm,
 {
 	struct amdgpu_cu_info *cu_info = &mm->dev->adev->gfx.cu_info;
 	struct amdgpu_gfx_config *gfx_info = &mm->dev->adev->gfx.config;
-	uint32_t cu_per_sh[2][2] = {0};
+	uint32_t cu_per_sh[KFD_MAX_NUM_SE][KFD_MAX_NUM_SH_PER_SE] = {0};
 	uint32_t en_mask = 0x3;
 	int i, se, sh, cu, cu_inc = 0;
 	uint32_t cu_active_per_node;
@@ -63,6 +63,23 @@ static void mqd_symmetrically_map_cu_mask_v12_1(struct mqd_manager *mm,
 	if (cu_mask_count > cu_active_per_node)
 		cu_mask_count = cu_active_per_node;
 
+	/* Exceeding these bounds corrupts the stack and indicates a coding error.
+	* Returning with no CU's enabled will hang the queue, which should be
+	* attention grabbing.
+	*/
+	if (gfx_info->max_shader_engines > KFD_MAX_NUM_SE) {
+		dev_err(mm->dev->adev->dev,
+			"Exceeded KFD_MAX_NUM_SE, chip reports %d\n",
+			gfx_info->max_shader_engines);
+		return;
+	}
+	if (gfx_info->max_sh_per_se > KFD_MAX_NUM_SH_PER_SE) {
+		dev_err(mm->dev->adev->dev,
+			"Exceeded KFD_MAX_NUM_SH, chip reports %d\n",
+			gfx_info->max_sh_per_se * gfx_info->max_shader_engines);
+		return;
+	}
+
 	/*
 	 * Count active CUs per SE/SH.
 	 */
-- 
2.43.0

