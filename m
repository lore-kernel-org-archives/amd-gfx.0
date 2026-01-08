Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C18CD14893
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 04:49:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1702610E686;
	Thu,  8 Jan 2026 04:49:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FJ+b9PbU";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011061.outbound.protection.outlook.com [40.107.208.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A377610E685
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 04:49:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qY4dnngWKoyQlzq7GYqZuE8PsCmsIXhG/bg9FnvvE6MRatRSJU1IVQ68t86rpMV+tAmGlwcXGWF/BuwGrq5ZYfNzirw1ZNcyDMDlSdjMH8bTwZ5ogrXLlQVvcLzIpPNmx/olWhVZJll09HiJovfiyPbAQwb25TOslCjukzKaFzpVJNWvmj0WQ6CXGeBUsTbN53Pum8VO6vus1gC1YtmTdqPLN6UwcGeSv4oaYVEUE4EAt4lYTg+aouNuIR2KxamL+76u8ptXjPfrk/lQjpqe/GIc1KKjJ9eJfniQaevT1NFiXY5DBGGQW5etrh1KtAHzn+J0XECOcjTMZS09pqDqKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mq9A8N3H8+OZXJBEYfGOQ0cl4Sxi2pevWCblbP4ZZCw=;
 b=gaQW9HUs6i6/C5s810r3HoFsU59Ky8dpBaYQR0xlwukaFf4VcwyqC3ukxZzCm0IAGRzqPviwT+/K44HOK1PWRZ2AJbtq5du1SsGLyezqvT1PGch+mVRjmaRuuXqASI+xkbzM8F+oDn+jlRdoYzXZMthwEbIN+BN2wMsIvVehI7/QwJ+L9Gm7DpQsMUSkrwI9zayfxi0MXu8YtIbQ4mtsIIyjLPr/7wdgjUKf3VS6uUnv4f5TUsCqbzMntg4sh8l+KbrNpzYtbeD0imAziCyjBkpCBA3ownHNZgP9IRvvPtYlKnwcDLorupCAJ8UKher0qSaUrtbspvXbQrZUK6q4IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mq9A8N3H8+OZXJBEYfGOQ0cl4Sxi2pevWCblbP4ZZCw=;
 b=FJ+b9PbU91mNBauU3c/k7ATmv3d2NhxHNNxBQRkMue1o/90j/SAKwTdsAZDMvF1aBIKv/EQ+6QS8ya+okZwNixXOZ6WKJS5sF1VrcZEOt032qZ+2ryypz1wObjppIi2HlTnqPSZf6wsNXCBxb36NROZqN9kIMHPrcb3Y7THEN34=
Received: from DM6PR06CA0063.namprd06.prod.outlook.com (2603:10b6:5:54::40) by
 IA0PR12MB8894.namprd12.prod.outlook.com (2603:10b6:208:483::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Thu, 8 Jan
 2026 04:49:45 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:5:54:cafe::6c) by DM6PR06CA0063.outlook.office365.com
 (2603:10b6:5:54::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.3 via Frontend Transport; Thu, 8
 Jan 2026 04:49:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Thu, 8 Jan 2026 04:49:45 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 7 Jan
 2026 22:49:43 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>, Asad Kamal
 <asad.kamal@amd.com>
Subject: [PATCH v3 14/24] drm/amd/pm: Drop legacy message fields from SMUv14
Date: Thu, 8 Jan 2026 10:17:30 +0530
Message-ID: <20260108044839.4084279-15-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260108044839.4084279-1-lijo.lazar@amd.com>
References: <20260108044839.4084279-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|IA0PR12MB8894:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e59af49-8cd4-4579-0419-08de4e715894
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pJ24aiUVYn3lY5Jmi+ea1ReRjowX43dE1zF1kgtlSvTO/KvU6rfpCea0OzXq?=
 =?us-ascii?Q?ks45fzlXObm3nIp1HUJFPZFOzQOHgj9FtgcEHvqbw+twNW651X9VuArKZUZ9?=
 =?us-ascii?Q?PEDJ/mUFyRGEPbZv+fgs9oNgpvomzmZBqRYu1ZMFtYL0qoTb3frVZwpL11K3?=
 =?us-ascii?Q?DmBPPo0VaFV4OJ/6W53gxfamK9/4DBl7R/1EwHhpXSwt/m/RnHWCP04IwlzN?=
 =?us-ascii?Q?vy0V20bhVR4R8a+k2laV35/G+AABo0O6+V3ElsZYF7FOsoPtWqTh5zn6QO7L?=
 =?us-ascii?Q?2NhQWf9O4oNH7nHzTwwP/2/Kc4juUvNTigWBqww/lpoqTL48gZCeGBjcVDE3?=
 =?us-ascii?Q?HrrRHG08H29JKnoCOk6ImV7nNnjVMperX9cVgyrwHH0qkDr98iXo+LOPzT3B?=
 =?us-ascii?Q?ABm7O4oaU166KkpJUrWHEDf6TucvIYO5ZCUGgGpNP5qPi9y24wuXxEJvwwop?=
 =?us-ascii?Q?+sAXb9DzY0YwpYN8CYfmRnAuo+B5bhRvEuPwzO/pVS/U3FVYsubJJkcqPesh?=
 =?us-ascii?Q?9QqB+s0UvY5jm79Py6aITpb+iQtvjP5coiaOjR+QRfGsBLDyTxGCNNQpGVx6?=
 =?us-ascii?Q?uix0KNi4OAWliA7CHya0Z5vEg0zg43ooo8gTwk+Nl3BvffPbgihj7bnAUs7r?=
 =?us-ascii?Q?gWKst6qSIzi92ZoCp71ExmzX7bquVVYm5HImd2pr/mg02DR3Xyl5YoLNN/59?=
 =?us-ascii?Q?DQq//ByeYfrBY2fBFCyaK9YQ9PM851hoPj8a+gGjhW0yicGFWwptM7U0sllF?=
 =?us-ascii?Q?w6aES53DN2VW5Kg1SMRP79zbmwgwSs5xIT8EVUK9RStkcHFB3BlHINX5J3xx?=
 =?us-ascii?Q?/acRpvZAr6F2pP66uBG1AxHgD7B2Uh15fxIOBPO++2kCmhQzcVdFz7n5FgX3?=
 =?us-ascii?Q?/n3Vgyetizva8UguWAeCZq+k57W4JAK9A7Q+zOb6tfSzJ02qOw0xMmsXbc2g?=
 =?us-ascii?Q?kJL04BKSdVQ4naAWjeU9jOJd7UKffdifCdVaV0JQKYBLNiBmIBQYzQznr7bc?=
 =?us-ascii?Q?rX3Tio40jrDqt9xbmJFuraO81PiKYu49H3Vf6k8Lgn9xOJOIM1dFJMdTVNkq?=
 =?us-ascii?Q?Dexr2vKWEFknz+dYa4tvaebQb4PrA96eSb2U9SMM1Pwj0c6cFfp+QGIS6xHb?=
 =?us-ascii?Q?3t81AnvZOYQGsg0WqV7ot2E6vakVwipUtKmBVqDg7WszeE2N/Ei1XiWT94mb?=
 =?us-ascii?Q?gNs1IorBbM+STLg+X/ZEBV3cHZOBuK3Q8hKcD9agAzQz4I05/GIynBw//NeU?=
 =?us-ascii?Q?hY/JInSP7S4DWXggOXswIvQkuQe8QX7EIt0DeVgJzKHXyeHO8EjW6lfXLHrv?=
 =?us-ascii?Q?f36XVRtxQz4R85TfeaWb8cbv3s3exq7oHkVB2xou1XZONt4B1k1qNf4jg1A7?=
 =?us-ascii?Q?mthKOZc3TguKvlE7heBptQBW0+L0HvN2OW9FKs64yGFWCB4NbVypPl0GhQkB?=
 =?us-ascii?Q?pIqtOv0kZDhfRV74qqQEsqCt/BoTweXAsy3kh39UApIUNhI4SReCcwdnCqgB?=
 =?us-ascii?Q?bPH31CfgXLIGXUK3zkvNvu8e5r0T1C6lZsdMEkKqsCUpaw2cLAoaqckWikHr?=
 =?us-ascii?Q?0RdsVjNe2yRayaV1NqY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 04:49:45.6771 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e59af49-8cd4-4579-0419-08de4e715894
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8894
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
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
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
index 5bf10555effd..e414dfd6f644 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -2111,10 +2111,6 @@ static void smu_v14_0_2_set_smu_mailbox_registers(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
 
-	smu->param_reg = SOC15_REG_OFFSET(MP1, 0, regMP1_SMN_C2PMSG_82);
-	smu->msg_reg = SOC15_REG_OFFSET(MP1, 0, regMP1_SMN_C2PMSG_66);
-	smu->resp_reg = SOC15_REG_OFFSET(MP1, 0, regMP1_SMN_C2PMSG_90);
-
 	smu->debug_param_reg = SOC15_REG_OFFSET(MP1, 0, regMP1_SMN_C2PMSG_53);
 	smu->debug_msg_reg = SOC15_REG_OFFSET(MP1, 0, regMP1_SMN_C2PMSG_75);
 	smu->debug_resp_reg = SOC15_REG_OFFSET(MP1, 0, regMP1_SMN_C2PMSG_54);
@@ -2875,7 +2871,6 @@ static const struct pptable_funcs smu_v14_0_2_ppt_funcs = {
 void smu_v14_0_2_set_ppt_funcs(struct smu_context *smu)
 {
 	smu->ppt_funcs = &smu_v14_0_2_ppt_funcs;
-	smu->message_map = smu_v14_0_2_message_map;
 	smu->clock_map = smu_v14_0_2_clk_map;
 	smu->feature_map = smu_v14_0_2_feature_mask_map;
 	smu->table_map = smu_v14_0_2_table_map;
-- 
2.49.0

