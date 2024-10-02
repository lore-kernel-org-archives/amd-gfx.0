Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4519CF3194
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Oct 2024 04:38:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78C6B10E688;
	Wed,  2 Oct 2024 04:38:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aZc+12Fn";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2043.outbound.protection.outlook.com [40.107.100.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F10D410E687
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Oct 2024 04:38:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RzB7ev75aCHFkRXHHWOTZw8JyvxaBPKf3WGrgFGXZOZkBpPPmA0z2hITOOT4sZ3mVyAw8PBovU0IEWCLBgZjQGKa910Zw++L0IifYKugp6tt3gXOg3Eo/wPJtZYpkexo1bFAcaHNE8VXIbIT3+YutcLzXeILBqe5piaRvjRoilrEQ77iVfbJwVO6WHkOJiD78RN5VO8S2tNsEFesJ9kjYBw2gDc+lWt4/D1m3ATCUNmR7NlnZsm0kLYeMLXVXzqtNJ7B4l8Bzwe/LQG/S/F/IWNSWOLNkioMp9PAqYZ44Cvv0XAvyHzeudaW2D2K2YurFBC44QaU8C1pHN9bYxEuaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iIFDrtJD+VL2qJOVGAQODxUTHy+JufQEwykeklJ2N2o=;
 b=q4dFCBXykgGD10aB+gtmJChJd8Zhss7bEH5IlmpsG/I35b4H62c7RPE4+fNkDwod05HnIExSdkQi5xD9OtWFmNRIATAM6QhgAF2iFWQ9zRrNsIxmHl0299pezC7tKTCZHKa7GxOzT69UaXYBRt8awm+7YaIurdoRenkhn3lHqL5qU7BeLT+IvJvR2oxSPVjdgXFMGVSI0Z46W8vS4wjM/24f0PhkSMqWm0K24cclxCrSEkfdiDHfdzQRckLL8a4Gs3E3A+jiz49CFmZjBTsGK09K3/rq9oy4DEHzf+GfcuftXnythWT22lrKW1xKkBTr1U5WLvoRTL7/weMaDj8RPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iIFDrtJD+VL2qJOVGAQODxUTHy+JufQEwykeklJ2N2o=;
 b=aZc+12Fn8jm1nDdKuhI5zYVQlhAzNTEyIVooc02e1gyvuiq9pg6uY7IaMefxqOx4nLe7/T8RzlL5H2H0fjOrsyT56VCn8MHPV2GDpMDEy0YZMveDIbyt4LspCVvewt2AFBizEbXRIDKoqoOOOhxCu7ITBdFPCo+9YdWAegCSHLQ=
Received: from MW4P222CA0015.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::20)
 by CH3PR12MB7497.namprd12.prod.outlook.com (2603:10b6:610:153::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Wed, 2 Oct
 2024 04:38:49 +0000
Received: from SJ5PEPF00000205.namprd05.prod.outlook.com
 (2603:10b6:303:114:cafe::b1) by MW4P222CA0015.outlook.office365.com
 (2603:10b6:303:114::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16 via Frontend
 Transport; Wed, 2 Oct 2024 04:38:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000205.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Wed, 2 Oct 2024 04:38:48 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Oct
 2024 23:38:45 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 03/18] drm/amd/pm: enable vcn by instance for smu v14
Date: Wed, 2 Oct 2024 00:36:12 -0400
Message-ID: <20241002043627.102414-4-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241002043627.102414-1-boyuan.zhang@amd.com>
References: <20241002043627.102414-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000205:EE_|CH3PR12MB7497:EE_
X-MS-Office365-Filtering-Correlation-Id: 24a63bdc-17bc-4656-f2c4-08dce29c1bd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uRDsNhCv83vLYBRJ+T5lw9C0gq6uv2U+81bh2zl+NQcXr4BoOgYdnswJ4xFD?=
 =?us-ascii?Q?8BKOYjZ0UxrTpSA5CtoFcXSsSXNqUx50H4PL0Z8I1ULQMmf35k6gT0B/uR6k?=
 =?us-ascii?Q?LiZO1lqR1S6crq7CviLII1LkNZBh84X9GESKvLseUQGpP0z2b1sLf5lWplOx?=
 =?us-ascii?Q?bNU/VvWGx2i4ZHp/njBJvedjRALqECf+EYtsONIGDIkFoioA9NthT9tCYAFA?=
 =?us-ascii?Q?7+VNQ6+AstlEpQTxL9D9TVXiADlaZWXcOXQS+SVGLV5H1A9ak1RLbnL4jlP0?=
 =?us-ascii?Q?jMJCvJJTVgWpFRpaLElQndGoFQaMJo+mT8JNwdJ8+3PyRJp/eq7KrZa9rlto?=
 =?us-ascii?Q?qHToycrrHtgjRXKZaHZXRT/cdKv6dVoR45Q9aideLuKpxvhBQTHbLlLLm2Ak?=
 =?us-ascii?Q?1qSOKKNbTdLUKIVazdCGlEY2o2a5AuD/guWjHelYp6ND5qR94ETG8U/j4RqP?=
 =?us-ascii?Q?ZsOm+x4D/WxKwYan8vVBRHCMM5R3DWC8jlFWrqWKYUC/EYNRHLAVvOqUzWCn?=
 =?us-ascii?Q?aqnKnTuqY6DRzC2BfyOVj3z82KlgH/llfU9lzwx3b1CbYPH3WoNpJEywdKLb?=
 =?us-ascii?Q?V4gk8B1ILItoklLF2lpk6nw4Nr2YA1MwESWSvhONUVoCKYxUP+Vr5mfnrn3q?=
 =?us-ascii?Q?16o5Tg0K0L7lX9S94TjhdUozmp1zRDyjBQiqU729lR6pOqm1vyWYUd4P/Wp0?=
 =?us-ascii?Q?JJXT3/jQRtnO8nzYbtJXooriuZnRvLqI9LypxlD/F0s6G8+peUR9/nOySG5T?=
 =?us-ascii?Q?J5tnjys/627iFh9dTWvwVesLP7LeFB8WdVcA5BGDEjDSmpi5se90Oc54JrJ1?=
 =?us-ascii?Q?gY7RPIGe+7pnoAz7l/BOoFuFmAjNlfN0WtJdx8rHpIUc72f0iZ2zJFn6Mz5F?=
 =?us-ascii?Q?VrTt7FFfR+ihSL1fvvfJKMjo+I2MzkUZnDgr53LLAkZwDEwKs2FIv3OKCbq3?=
 =?us-ascii?Q?f9Nn+bySOUeOjI1YlYkbHatFsatjcBzoWDqH4vTpEr2OAoyKfBRMxvWqTy6k?=
 =?us-ascii?Q?yl6oOqtmknd0WqTER2Gc9LD8Pak8oDr9bVxb3Ew3VFlg/Xu8jVJdbV0zXJZc?=
 =?us-ascii?Q?FdkPfiHYo7WlBWafdXMEdTymZA5HBdnci4RLfuw0aksdbwmdo2O8cl8EPz3j?=
 =?us-ascii?Q?oN4PzlvGQHdH5Z+jBvPGlmd1fdrj0f1axUyqjU8/PQaJ38Lm+c2RLvfijhu/?=
 =?us-ascii?Q?vjlPpPDH5HThplr+RtAfEpTjWn1a5CLGaPsdqR+uq3Lx36sG4X8dqJW7GTEL?=
 =?us-ascii?Q?rAbQuRSr48ntRueBA5AOeg/oAc15evRNm6P2FBHN7yLYpCsdZss2naaVdFnT?=
 =?us-ascii?Q?wAuJGFjLnxv02W3Bbh2lBBHNMH1J92vwDVaRpjXMGAHMwDIFPUQqWN3ZOYh4?=
 =?us-ascii?Q?7k8WNswdIGxJeIFi+ndcGZ1ifRGjv4arW41JFC0dNgKNpzei6oZI78lAUTCt?=
 =?us-ascii?Q?pbgBX1SuIboOggMu733ZV1juEt5cLKu7?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 04:38:48.8405 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24a63bdc-17bc-4656-f2c4-08dce29c1bd9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000205.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7497
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

From: Boyuan Zhang <boyuan.zhang@amd.com>

For smu v14, set vcn enable or disable by the given instance instead of
setting it for all vcn instances.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h  |  5 ++-
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c    | 40 +++++++++----------
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  |  2 +-
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  |  2 +-
 4 files changed, 23 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
index 46b456590a08..7d697f585443 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
@@ -209,8 +209,9 @@ int smu_v14_0_gfx_ulv_control(struct smu_context *smu,
 int smu_v14_0_wait_for_event(struct smu_context *smu, enum smu_event_type event,
 			     uint64_t event_arg);
 
-int smu_v14_0_set_vcn_enable(struct smu_context *smu,
-			     bool enable);
+int smu_v14_0_set_vcn_enable_instance(struct smu_context *smu,
+			     bool enable,
+			     int inst);
 
 int smu_v14_0_set_jpeg_enable(struct smu_context *smu,
 			      bool enable);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
index 865e916fc425..bb521d3bedf7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -1491,33 +1491,29 @@ int smu_v14_0_set_single_dpm_table(struct smu_context *smu,
 	return 0;
 }
 
-int smu_v14_0_set_vcn_enable(struct smu_context *smu,
-			     bool enable)
+int smu_v14_0_set_vcn_enable_instance(struct smu_context *smu,
+			     bool enable,
+			     int inst)
 {
 	struct amdgpu_device *adev = smu->adev;
-	int i, ret = 0;
+	int ret = 0;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return ret;
 
-		if (smu->is_apu) {
-			if (i == 0)
-				ret = smu_cmn_send_smc_msg_with_param(smu, enable ?
-								      SMU_MSG_PowerUpVcn0 : SMU_MSG_PowerDownVcn0,
-								      i << 16U, NULL);
-			else if (i == 1)
-				ret = smu_cmn_send_smc_msg_with_param(smu, enable ?
-								      SMU_MSG_PowerUpVcn1 : SMU_MSG_PowerDownVcn1,
-								      i << 16U, NULL);
-		} else {
+	if (smu->is_apu) {
+		if (inst == 0)
 			ret = smu_cmn_send_smc_msg_with_param(smu, enable ?
-							      SMU_MSG_PowerUpVcn : SMU_MSG_PowerDownVcn,
-							      i << 16U, NULL);
-		}
-
-		if (ret)
-			return ret;
+							      SMU_MSG_PowerUpVcn0 : SMU_MSG_PowerDownVcn0,
+							      inst << 16U, NULL);
+		else if (inst == 1)
+			ret = smu_cmn_send_smc_msg_with_param(smu, enable ?
+							      SMU_MSG_PowerUpVcn1 : SMU_MSG_PowerDownVcn1,
+							      inst << 16U, NULL);
+	} else {
+		ret = smu_cmn_send_smc_msg_with_param(smu, enable ?
+						      SMU_MSG_PowerUpVcn : SMU_MSG_PowerDownVcn,
+						      inst << 16U, NULL);
 	}
 
 	return ret;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
index 8798ebfcea83..9e4fadb8024a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
@@ -1648,7 +1648,7 @@ static const struct pptable_funcs smu_v14_0_0_ppt_funcs = {
 	.system_features_control = smu_v14_0_0_system_features_control,
 	.send_smc_msg_with_param = smu_cmn_send_smc_msg_with_param,
 	.send_smc_msg = smu_cmn_send_smc_msg,
-	.dpm_set_vcn_enable = smu_v14_0_set_vcn_enable,
+	.dpm_set_vcn_enable_instance = smu_v14_0_set_vcn_enable_instance,
 	.dpm_set_jpeg_enable = smu_v14_0_set_jpeg_enable,
 	.set_default_dpm_table = smu_v14_0_set_default_dpm_tables,
 	.read_sensor = smu_v14_0_0_read_sensor,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index ade3ee398e3d..00f1f1bc2652 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -2808,7 +2808,7 @@ static const struct pptable_funcs smu_v14_0_2_ppt_funcs = {
 	.system_features_control = smu_v14_0_system_features_control,
 	.set_allowed_mask = smu_v14_0_set_allowed_mask,
 	.get_enabled_mask = smu_cmn_get_enabled_mask,
-	.dpm_set_vcn_enable = smu_v14_0_set_vcn_enable,
+	.dpm_set_vcn_enable_instance = smu_v14_0_set_vcn_enable_instance,
 	.dpm_set_jpeg_enable = smu_v14_0_set_jpeg_enable,
 	.get_dpm_ultimate_freq = smu_v14_0_2_get_dpm_ultimate_freq,
 	.get_vbios_bootup_values = smu_v14_0_get_vbios_bootup_values,
-- 
2.34.1

