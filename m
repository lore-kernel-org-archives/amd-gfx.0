Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98EE7D65C4F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Dec 2025 13:55:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36B0310ECDE;
	Wed, 17 Dec 2025 13:55:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SNDFnKMs";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011015.outbound.protection.outlook.com [52.101.52.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9698410ECDC
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Dec 2025 13:55:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xHm/T0qG4QWRm4rjfQDiItFuF5rzgP96pUmEUUN48bgNN2HUhK9mnUj5+KiZ4PknoIYVGRCbPUGXV0HDafdGIUftzKlWqWFJS+5qw8OHqmBlIPGegVc1fsEaFV6aqR1KcDYaMy+YghlZNBYEk/XV6Noa3LKAIvXfEy8/6WwuRQoNodqPB9PWSjVtbQEfAtCVwI+FZaeZMmZTzfmyYhe+0CuPbRiGFwmxYq11oAvsKB2Dw6517SVb2a+7JIrhWOufhYZHBhcZMsURHmCxdIE2J09lqNEfR2IDbw5hqNpMEvry964P8pcnYL+92HDXixXQRBvZUa86J9HOcVh6e2RoWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cx8sJXoVT1VMMdmeKQHfBkmBugJRTKKkpHbE8NOU8Vs=;
 b=cbPNXWLlfKDnv3mK4j673ZaJiInYI299ltB7dopwBUrDnVEiYaPsQslAGPJIhYTI1bch5OZ8bhAonkFdwssLZfuQtNUaKbeKEXDeUCJzFMTuq25v4gBcl7KOQHil23pf0IULiWGB6kRjHEAfe/TMIGGQbnQUIEuHvHt33+2SVvQ22up7GO1PP4fW8NBnF1c10r0OUt8if5aJCMo6An/WwYpRegXwtyy9mx0AYSuBIkyECc+FXCQ7oHbopY0gaSZHJHrolcn6sTW0T6mUCJvv/ZQ4ONbWnK97nAn1oYnCmLcspNqZfJkO7zlcsKh+gVHGsFKAzULWXL7AfkY/wuWhIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cx8sJXoVT1VMMdmeKQHfBkmBugJRTKKkpHbE8NOU8Vs=;
 b=SNDFnKMsLJB/R/D+4r34p8kq43Yb64hiI7xK9aiRGXxfuL5pxPOE7t9O0a+iw1FMdyUAvu3z2/j65RhZcfTBu9BEo19iiU/zs3vZWSO1Q9dr/R6W4wYXjrdYLVtGIEnWx6fMetbIDjdORwdjo7gDP8GAZYBdduqZ7FCbgkDM0i4=
Received: from CH0PR03CA0087.namprd03.prod.outlook.com (2603:10b6:610:cc::32)
 by CH3PR12MB7691.namprd12.prod.outlook.com (2603:10b6:610:151::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Wed, 17 Dec
 2025 13:55:17 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:cc:cafe::c7) by CH0PR03CA0087.outlook.office365.com
 (2603:10b6:610:cc::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Wed,
 17 Dec 2025 13:55:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Wed, 17 Dec 2025 13:55:17 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 07:55:15 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH 13/21] drm/amd/pm: Drop legacy message fields from SMUv14
Date: Wed, 17 Dec 2025 19:18:06 +0530
Message-ID: <20251217135431.2943441-14-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251217135431.2943441-1-lijo.lazar@amd.com>
References: <20251217135431.2943441-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|CH3PR12MB7691:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c15cc7f-1305-44d7-ef28-08de3d73e909
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?quXTfqTRc8f0DhRp4xc1igFGUiUewIhotw5GuC/hq9toDfk2rXOxTWbzhcLt?=
 =?us-ascii?Q?SR2YlnTcIiPVZMfQapR9hMw1PMjH77f4HhN8/G0rnr693sKXNt2Q3f4j3/XD?=
 =?us-ascii?Q?vKZuWWbfFNOYd7AHvsStT5O/seNlKXwnId6MMMR4i60WMikvN2dCN7ANMBZl?=
 =?us-ascii?Q?0w1iGsv/kurHH0gPEGbM/H8g8fk6oL8ljEj0RYqGTQZBO4qOvUq2ERp0cX1y?=
 =?us-ascii?Q?gC8kOCLoQVXJSTTBfjr7qWsVLYAXlzBXTy5G52LoNSQXLzKviIpfLsEePavM?=
 =?us-ascii?Q?Tf2bF0kgvZFS/jDwKbcCwwzuVZjbxgdVrWEWxsPd9RssR+dS+XDcRF6ONPCc?=
 =?us-ascii?Q?mAshhFsW3htnsXWHb7uxCUcf3ceT59omLcvG0XY/MqwyOhWynybZhn9ResEr?=
 =?us-ascii?Q?89j51iX1UfzdmaIY2+AuTJniUSxIwxuYQgBcotDt6nkWj1cYdMv3KP1/R7T0?=
 =?us-ascii?Q?Z23pqI+TzE4eHRlSmDTAZPl8fEDriCLz/2cKrW0zUSUcIX/8XN4qN6u6jc1i?=
 =?us-ascii?Q?qsUt8AvtaDJN46wXVwGarPo9aIAGj3Wgo1BItpdCmRBsKg8A0YB0x5NZfyvn?=
 =?us-ascii?Q?V5HO5EeGpCKAkY0G7pqPxF+bDDsQ7sR3X/m8X8nSlItBZnqqUNWDQYAFiCdD?=
 =?us-ascii?Q?l7pe1uprMZ1qGp6ybRixaHGYmqi05LZBmJtKhBatFn0Hm+bGZcTwt6iCDg+v?=
 =?us-ascii?Q?SFZSr3yJJ9Vf1Z3YYQg+W1LoDRJsKnXF/FoWHA7xQ5iqXDoaGaysYDfZyVGI?=
 =?us-ascii?Q?BZxJEOnZqppMiQWPiuFV40oSq9YaXCs5uRCgEA7Y6WbiskshyhvE8ST2XGWn?=
 =?us-ascii?Q?WNtsk/eNAtqVcgCE2zhgSFNFpZhDC3H1aqEmFRnzPXX+uwKaY9P5kdfIHmpX?=
 =?us-ascii?Q?4aKzCvILNL+MGapiPzwPl1bxakGnRHuQwltD9kfG9UBKxX0yO/HQ1/ZiCYB2?=
 =?us-ascii?Q?BJHYh1b/qrLvlCV3rPqJlhMKbI5kOKSAww7hLyg1jRouLqeDrno2bPg8ruJY?=
 =?us-ascii?Q?8Jvlcaxwrq8yq1Ud+kwQyYFjcaQeh290p8Bq3/RB7d2RcSV5+on9odcmcumy?=
 =?us-ascii?Q?PzFEMvY4as4x4e7HHNzqkMcl8dBM0z+tNXgo9gwJAkqIsiE32apg7udsByYk?=
 =?us-ascii?Q?Vu4LQSX4I6hqxIzxZ94RN5zyGOSL2WQs7B/ilQKA23VGIJ8FbRuTUwfw2LHs?=
 =?us-ascii?Q?2LO4lfkdTEI9KNOwKUpJhZGdMv7txT4gBT7l1eBzTvLFBWhaxfzIgGlwrfRI?=
 =?us-ascii?Q?UkL0TRB6S9kn6EyQsh2cwJR44x/xkCVdeVTj+C2Vg5W47+8MFVn+4fu3em2j?=
 =?us-ascii?Q?1vMfQklkGY/wpfeT2x8gpecNReRI74Xm5PCpnfP+nlRcsB4ThkYS+3QIE8KB?=
 =?us-ascii?Q?eIdfK+kMphZ6t6xIgHHjihWQoUPhR8ArKbxd6hmzVSw0oJ9vyA+MBRpfutDu?=
 =?us-ascii?Q?rWdkgLV/XPyIestVlgTe2XAPkIbyjr2TaiQiut96362v+T95nER7KtzUj/5e?=
 =?us-ascii?Q?i8sEvvaNSId2Vpe4rNYcS1q6iHJHTrBwYEc5U8JjN8OdQG5OXENCHcDcm6E3?=
 =?us-ascii?Q?qGPJzwvK6/aGZaX5KPE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 13:55:17.3146 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c15cc7f-1305-44d7-ef28-08de3d73e909
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7691
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

Remove usage of legacy message related fields from SMUv14 SOCs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h         |  6 ++----
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c | 12 ------------
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c |  5 -----
 3 files changed, 2 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
index 4ecec85b8404..613d4d36f32f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
@@ -215,10 +215,8 @@ int smu_v14_0_get_pptable_from_firmware(struct smu_context *smu,
 					uint32_t pptable_id);
 
 int smu_v14_0_od_edit_dpm_table(struct smu_context *smu,
-				enum PP_OD_DPM_TABLE_COMMAND type,
-				long input[], uint32_t size);
-
-void smu_v14_0_set_smu_mailbox_registers(struct smu_context *smu);
+			enum PP_OD_DPM_TABLE_COMMAND type,
+			long input[], uint32_t size);
 
 int smu_v14_0_enable_thermal_alert(struct smu_context *smu);
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
index 9c15fccac2b8..0a509fec2180 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
@@ -1731,15 +1731,6 @@ static const struct pptable_funcs smu_v14_0_0_ppt_funcs = {
 	.set_mall_enable = smu_v14_0_common_set_mall_enable,
 };
 
-static void smu_v14_0_0_set_smu_mailbox_registers(struct smu_context *smu)
-{
-	struct amdgpu_device *adev = smu->adev;
-
-	smu->param_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_82);
-	smu->msg_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_66);
-	smu->resp_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_90);
-}
-
 static void smu_v14_0_0_init_msg_ctl(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
@@ -1758,13 +1749,10 @@ static void smu_v14_0_0_init_msg_ctl(struct smu_context *smu)
 
 void smu_v14_0_0_set_ppt_funcs(struct smu_context *smu)
 {
-
 	smu->ppt_funcs = &smu_v14_0_0_ppt_funcs;
-	smu->message_map = smu_v14_0_0_message_map;
 	smu->feature_map = smu_v14_0_0_feature_mask_map;
 	smu->table_map = smu_v14_0_0_table_map;
 	smu->is_apu = true;
 
-	smu_v14_0_0_set_smu_mailbox_registers(smu);
 	smu_v14_0_0_init_msg_ctl(smu);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 67a773253a65..a060346f5bd8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -2104,10 +2104,6 @@ static void smu_v14_0_2_set_smu_mailbox_registers(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
 
-	smu->param_reg = SOC15_REG_OFFSET(MP1, 0, regMP1_SMN_C2PMSG_82);
-	smu->msg_reg = SOC15_REG_OFFSET(MP1, 0, regMP1_SMN_C2PMSG_66);
-	smu->resp_reg = SOC15_REG_OFFSET(MP1, 0, regMP1_SMN_C2PMSG_90);
-
 	smu->debug_param_reg = SOC15_REG_OFFSET(MP1, 0, regMP1_SMN_C2PMSG_53);
 	smu->debug_msg_reg = SOC15_REG_OFFSET(MP1, 0, regMP1_SMN_C2PMSG_75);
 	smu->debug_resp_reg = SOC15_REG_OFFSET(MP1, 0, regMP1_SMN_C2PMSG_54);
@@ -2868,7 +2864,6 @@ static const struct pptable_funcs smu_v14_0_2_ppt_funcs = {
 void smu_v14_0_2_set_ppt_funcs(struct smu_context *smu)
 {
 	smu->ppt_funcs = &smu_v14_0_2_ppt_funcs;
-	smu->message_map = smu_v14_0_2_message_map;
 	smu->clock_map = smu_v14_0_2_clk_map;
 	smu->feature_map = smu_v14_0_2_feature_mask_map;
 	smu->table_map = smu_v14_0_2_table_map;
-- 
2.49.0

