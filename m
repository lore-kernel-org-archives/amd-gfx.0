Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8850EFD707A
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 20:13:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26CEB10E664;
	Tue, 17 Mar 2026 20:13:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IR+RJ+50";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013029.outbound.protection.outlook.com
 [40.93.201.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43BDA10E5E2
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 20:13:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sDwUgcfYJxd9W7V+PomezgMuX/vLD9x6rhyohvqPxjoekI8/5n0Li+B8v4kcy4k1ATo/t55UWKn68ZMEUw3DsghWHHStEh5gH6FgoDWvGLC/iXp7792x20QmEVGBMG0qg7DiBTcb9zL3MdpXSCuVMQkuWjvpc6+VM8M5DN8/0QOcP6a5qT1fq5tJZHI9ethXGoVDfLx/JtZQND7X/MRlTzgIxXAfki5qKQSlnQnORQSVBz/xV7Qd6Y/I/nHTL3+Gw71LWSHAz8PkkSVjpQr59LxpO8kMs4vndtsTvZxxm59/QbD1UVTYGE9JBPeItOHlO7xSK0zsqO7E0O33dB9qdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PY4okW7hLTFOfeLdO4K4X54WazPvGGwZ01hpBg4s01Y=;
 b=rdzJzSFysyunAEcQZZ7+LNfNgrok9BpWwsQJn8D5PYeEv9zaj2R6vIXJ2aLoHJgX+3FutE2hA+ozNpOJJWiBXnhaQBdL4VkJfcTEfPCNUZ2NmdpVhBdh0y6jRN+/2e/tWw+7E0HOF/jGMpUs6u2i20UdQG+GbgVF4VV6qomStsSmp9kRwX8+HHfIg5tWQ//JbiOpau7dLvk3MAw1dBeCdYDcX/MC2JlT8T5NM/gf+kpO/RKtVhq9zG/mPrCOtjL1mJlJgAad6cEgnpOojxqTOK+8PK8qGrgrTlniK9/2T+8esOZzEimwt013zpZme6/Sdf48+MA5S6B5uTTtHPLf8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PY4okW7hLTFOfeLdO4K4X54WazPvGGwZ01hpBg4s01Y=;
 b=IR+RJ+50ES8MVRZWgk9sjDM8+C42L51Gs1X9kRnvANLnSQXlue9LhtDWUIwsR1vya3DrhXrdZ2rupzUZMCJ62VLzk78lQeXl9Fwh7PdKRDjWltmuXAI07N7Zk1pVtexi8q+OEktRJpd4mPLr/zJih6zbzevBUGvPctivAaxR6bU=
Received: from PH2PEPF0000385B.namprd17.prod.outlook.com (2603:10b6:518:1::69)
 by SA1PR12MB5659.namprd12.prod.outlook.com (2603:10b6:806:236::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Tue, 17 Mar
 2026 20:13:11 +0000
Received: from CY4PEPF0000EE3A.namprd03.prod.outlook.com
 (2a01:111:f403:f910::2) by PH2PEPF0000385B.outlook.office365.com
 (2603:1036:903:48::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.24 via Frontend Transport; Tue,
 17 Mar 2026 20:13:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3A.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 20:13:09 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 15:13:04 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 13:13:03 -0700
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 17 Mar 2026 15:13:03 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Yang Wang <kevinyang.wang@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 13/25] drm/amd/pm: add set{get}_power_limit support for smu
 15.0.8
Date: Tue, 17 Mar 2026 16:12:29 -0400
Message-ID: <20260317201242.3808136-13-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317201242.3808136-1-alexander.deucher@amd.com>
References: <20260317201242.3808136-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3A:EE_|SA1PR12MB5659:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e375547-1693-44ef-404b-08de84619bf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: EQvItRGmIzxhJTEe2HncTXbBWYXnLjz3F7vNV+afItDBKY2D5Z6wUUkm/2g1d69TYg5qJELG6MaGf83TvJy2duLXdlM5xwhVVABpG9AYLqKYWDvcSLCyfKYFvksAOk9qlA7aLloaRVSjj+UaqpmbdzVDh6+4GcwLNziAwIOHx3OexyYQjzOcHSh0oamoLYHXS/i592YdYLNuZdIEucsi9Qr/PBEe8i1bynJPtsLps5495adSrX/nIX3Sn14kQ0DfCn49kjsX3ufGqmdkk9/3i25PmFPRhIT682QurBGlc5PcHSYMXTYfR9cNg1fc6SA7b56vI+8WheV1ZJdzAUtfJKlbTpThmiS8vlUeFmpmzqzvHeh0TsusJQqlUvEu8hz/F4N4mul0ax/eD00E03JGEQNMarboFI/4cbtmXXZ/M7oEAKTAk5Ioq+1jKpRKxOh2F+N/1sxdpzxTcjfEK+3CJo1bX73M5Spyvfykxadt6eUAzpSm1DcV3Bp+DQDaJHR7k6Ym72SCo8n24YBlT4ARaCL4FX5OIXi4evDXyYKL2pdrcn6Vm2CiVZGrW2ZMDx4j70PsYrw+cErnf/yFr6eeT5twpHJ71SUMyeiDSeB/upzrHcRevIq2M17NbdWDHLIKdiKxY21GlNmWau28DQ0kQQm+frovJdQhWw0GBqVFDP3HIBT4iSGJqIIrVOn6hNKQnYj/NV0/sM18isRor8+Ydpb8+g9H+SLuZ9GzjvAM7kZn4RWDfefr5PZDv63LzAyugOppA078zRSqWuxYRtRGqw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7X5doDNjTRy1XuASISnd25Wvo4WIuOLXpsQiSka36L1qT15yEpdvpDUT/+SQ0HQyQjTeRCXagu9YVMGL0KqmOyW/0P5HN+urmXD95Tm7AJnKOXsA9N6HUvIXCbkYcVuwmfN0lnWh32mhE0u7VQcho61dxD621z6wlTYjdYDwlrNPkEc46pfDFmA0Ntu0hJEy8urV03Q5Gd4YfwcVriV5hbSV5TTMaaOlTNvp+IbcGI7k3dEmUEtReKdPJKU2BiFhBvZVQnD5Y4KT07hg5Op6U2jx75nPO92qlzrZybkhg4dTao2ZXV/036UhoPk5WX89Rlkar82vSc2bGWMTEHAHBv/8XcWQyVpHrZs4Hbol7UficmFGX6wQHNNzbOz/l8UgAIfy/fpyQ3l2hrmc4eRvznT6MBVOyFxNyyFsKGDtdMNERqOzzetddgfK4TVzdCWD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 20:13:09.5034 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e375547-1693-44ef-404b-08de84619bf2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5659
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

From: Yang Wang <kevinyang.wang@amd.com>

export .set_power_limit & .get_power_limit interface for smu 15.0.8

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  1 +
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c  | 34 +++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 5a92ab9601a15..6b31b5d173e71 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2966,6 +2966,7 @@ int smu_get_power_limit(void *handle,
 			case IP_VERSION(11, 0, 11):
 			case IP_VERSION(11, 0, 12):
 			case IP_VERSION(11, 0, 13):
+			case IP_VERSION(15, 0, 8):
 				ret = smu_get_asic_power_limits(smu,
 								&smu->current_power_limit,
 								NULL, NULL, NULL);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
index 5fd22b145aea7..d7d40985b0b71 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
@@ -1147,6 +1147,38 @@ static void smu_v15_0_8_get_unique_id(struct smu_context *smu)
 	adev->unique_id = pptable->PublicSerialNumberMID;
 }
 
+static int smu_v15_0_8_get_power_limit(struct smu_context *smu,
+				       uint32_t *current_power_limit,
+				       uint32_t *default_power_limit,
+				       uint32_t *max_power_limit,
+				       uint32_t *min_power_limit)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	PPTable_t *pptable = (PPTable_t *)smu_table->driver_pptable;
+	uint32_t power_limit = 0;
+	int ret;
+
+	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GetPptLimit, &power_limit);
+	if (ret) {
+		dev_err(smu->adev->dev, "Couldn't get PPT limit");
+		return -EINVAL;
+	}
+
+	if (current_power_limit)
+		*current_power_limit = power_limit;
+
+	if (default_power_limit)
+		*max_power_limit = pptable->MaxSocketPowerLimit;
+
+	if (max_power_limit)
+		*max_power_limit = pptable->MaxSocketPowerLimit;
+
+	if (min_power_limit)
+		*min_power_limit = 0;
+
+	return 0;
+}
+
 static const struct pptable_funcs smu_v15_0_8_ppt_funcs = {
 	.init_allowed_features = smu_v15_0_8_init_allowed_features,
 	.set_default_dpm_table = smu_v15_0_8_set_default_dpm_table,
@@ -1172,6 +1204,8 @@ static const struct pptable_funcs smu_v15_0_8_ppt_funcs = {
 	.get_dpm_ultimate_freq = smu_v15_0_8_get_dpm_ultimate_freq,
 	.get_gpu_metrics = smu_v15_0_8_get_gpu_metrics,
 	.get_unique_id = smu_v15_0_8_get_unique_id,
+	.get_power_limit = smu_v15_0_8_get_power_limit,
+	.set_power_limit = smu_v15_0_set_power_limit,
 };
 
 static void smu_v15_0_8_init_msg_ctl(struct smu_context *smu,
-- 
2.53.0

