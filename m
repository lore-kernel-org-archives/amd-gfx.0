Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BF97C79FA1
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Sep 2026 02:42:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30D6D10EE52;
	Wed,  9 Sep 2026 02:42:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jMQAe7hu";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011041.outbound.protection.outlook.com [40.107.208.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E529C10EE52
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Sep 2026 02:42:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SkTb3W5Dsnafc/gTKamy+HFqyasuLoot7i9NraUS41wVknFGfdnRFIEos7itZHVMIEIuy+ty1gcg5zLG0Mp26cKcxGZzwPv8QuDnl0glkVzR1FCw7/+YKw2qcnjdhnwLuW7dIqKpYKwdB1R/16VbI9NZtkS+WHSGAgG8kdUWA8O0NuJQkOzC/B7udMGx5okF8bK4xfuk91qOSCag7bpGR6YoQMaSfayGy69IA1IzqaqeHDMiOL3EPO6TMME0NmerSY4WQVwAl1lwrew77tT8/zXkx+7b2NyN8TCvk6wZ3ThdNhHltFIA8n04ypv7iQUYtYmHxKZ0xdkYmxrijILWpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jMDjWrr3Yzv9/AucVvoNk2PROqYDEeBLIgKZPQE0g5c=;
 b=K/x9TmrkQp/CMFqKE2ta/tk6YFwbvIa/qlk7iBuOaBraBZFfNihNyhrrGA97ntZXZuOwKT/pAkB6gyNH5merMqa8A6H5JrWESvBpZ8g1fkQgX8KAS5flK3J0QyZjC9KV2lGCLhKtVY+ZdsG9z6oCGiOr7FY+YwHvt+MhOEKdqYMzpw2BukbZEcULZ+CvmTNguZo/coO+3e/jIi+qjr6DliG+qcB524ZDeKOrKEIDjfTYQhHyfDWafaLWZfUz6wjYu/IQXu+3GO/2GxOJwkxYlRMA8LW/DIHHdvZrZevWz5Zn7c5OkGj2/f6yVu1oaLhF7atZhf1B3abxEN5Z3StaYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jMDjWrr3Yzv9/AucVvoNk2PROqYDEeBLIgKZPQE0g5c=;
 b=jMQAe7hu1az5372mykeM3YkNCW5ZoC4gphZdwgGiGcNx8btcLAJtbgbsjKVD7mN25yqkLi7g2x7bfj1w/IdA4EliaMrc9RIW3Kv1keLRpvRLVHcXXuPSVkUxvVeBCQEL+zgL6oVu23oWbVjSt8xGqppKVlTD3b3amKd6knJssWg=
Received: from IA4P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:558::8)
 by DS0PR12MB999287.namprd12.prod.outlook.com (2603:10b6:8:424::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 02:42:06 +0000
Received: from BN1PEPF00005FFD.namprd05.prod.outlook.com
 (2603:10b6:208:558:cafe::75) by IA4P220CA0004.outlook.office365.com
 (2603:10b6:208:558::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Wed, 9
 Sep 2026 02:42:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00005FFD.mail.protection.outlook.com (10.167.243.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Wed, 9 Sep 2026 02:42:05 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 21:42:04 -0500
From: Kevin Wang <kevin.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amd/pm: report energy accumulator for smu 14.0.3
Date: Wed, 9 Sep 2026 10:41:49 +0800
Message-ID: <20260909024150.590580-1-kevin.wang@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFD:EE_|DS0PR12MB999287:EE_
X-MS-Office365-Filtering-Correlation-Id: f63bef68-3394-40a8-aa4d-08df0e1befc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|11063799006|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: 90icnlXN4k1qDwuccsaU8A7dXH4RE291+6brJqngrOVN5372W6fMV2ZT9pMGoPdZVTpCmoPYO5bSOeLT/VP2GaOXM/HLFQy4snYkqEUHYj5lCSShjXhrnTzJyuuSZqIUcs7AAmxhQvnoiqot5XwdYOb5gcZiShL9eyRyN2QT0mec80mlQx/J8LFpUTARk2sClM2QHpQcizLm1HHJ60yrMPTV48Y/vRy9u3dkd4pSwyo5sZUy2uctrS0estzjFQptFsD2NxllaGSkiegAu3NN/fZE4YN/2MLQlXI8vtjm/S6K0eXB9/18P48jJtodwQbj/xyAYmoOlGk07c00S1ufyqXzAZq5x0xI/5Ujdit2AOvUEVvh0mowEjtJstRPHuJYzZBtOc9ow1FowjbmSZLNhODf2JFFWL5CoZpxOxHrrJxh9AFiuFJRDM35kwMGmN9tIkFbrSX5hpcagOxNsCZ4uBXtKUUCj6xBYWNlnda5G4eRxdocGYlScn5NCRekSa2jB4nYfWb1xxKNIKUiKFdrY/jmRn5PBIVOOqKD0og6nI8A7eMDPq2P/MdiWfsx/SccTevZjfVuUjSVM1KOU72hgwaXf3CpQAJKJ+eu/f4EJF8HwuWYqkNZOjXXNjhXhVCzP12RuNeiDIkv4AZo6TgIbWe8DU2GRVQsiFnuK0P/ePPuYJSxvkpCyz0Tbu+/Qvl1JTI4HRGhN6pjHJr7JEYLOw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(11063799006)(56012099006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iXzYL7iFfAQk4snsZFAbAlOUvNIbAlVBnd0Y7kP+wv9JWTCf+p2KRYkA9gT6mHRwmcvDewxgM7XIiBQr3L+AMiAMviPl2APdi77hp+ZgDYgyeg3OgiSnMpXvVkeabUUN81QoKaxAKPN9XZ5VCMRO0MFD7+/S4a5i3eSkPuDhWudVcbV3TN+sdMte6bEagpHPQ3Hb5WYTK93ldVhDo13UW4Fv794j6zS4vEzRxvfgCdvFe2yimCQznFX3cZmK7IDLg+JTbjF+4gByRpBBjvMLe6KIelLAavLB2VO9UTVHOjG1rJ2/8vRwhx+V1pysV/sFhVFHQyua/f9ndiAqi8UFCtondZZJy5uOtBaG8dFnhmoxu6zpJdxnXwrC2Zljwo9pA2GccffqrAXxGuIok89uy2b03lUA64gYJKWR+68RN1mARcza/txlfPfKPesr/8fB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 02:42:05.9280 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f63bef68-3394-40a8-aa4d-08df0e1befc8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999287
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

add energy accumulator on pmfw 0x00685000 and above version.

Signed-off-by: Kevin Wang <kevin.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index ed5796a985b2..76a606095ae3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -2157,6 +2157,7 @@ static void smu_v14_0_2_init_msg_ctl(struct smu_context *smu)
 static ssize_t smu_v14_0_2_get_gpu_metrics(struct smu_context *smu,
 					   void **table)
 {
+	uint32_t mp1_ver = amdgpu_ip_version(smu->adev, MP1_HWIP, 0);
 	struct gpu_metrics_v1_3 *gpu_metrics =
 		(struct gpu_metrics_v1_3 *)smu_driver_table_ptr(
 			smu, SMU_DRIVER_TABLE_GPU_METRICS);
@@ -2186,6 +2187,8 @@ static ssize_t smu_v14_0_2_get_gpu_metrics(struct smu_context *smu,
 					       metrics->Vcn1ActivityPercentage);
 
 	gpu_metrics->average_socket_power = metrics->AverageSocketPower;
+	if (mp1_ver == IP_VERSION(14, 0, 3) && smu->smc_fw_version >= 0x00685000)
+	    gpu_metrics->energy_accumulator = metrics->EnergyAccumulator;
 
 	if (metrics->AverageGfxActivity <= SMU_14_0_2_BUSY_THRESHOLD)
 		gpu_metrics->average_gfxclk_frequency = metrics->AverageGfxclkFrequencyPostDs;
-- 
2.55.0

