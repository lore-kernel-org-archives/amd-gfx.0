Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15E29D1489F
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 04:49:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A503710E680;
	Thu,  8 Jan 2026 04:49:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Nx2mfNTP";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012034.outbound.protection.outlook.com
 [40.93.195.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA40A10E681
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 04:49:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q/sNGHSgDU4xibAPcNyUnkFC8EmnETQqW7WBP5Kc/DApOkzjI1T3dA3mUTSsvCMZ9igRWTaq1H8usUNUJYydwrZf/bqbu0zmTG3YyU7ZMY1X7s6iF40P5IF0OvV/8jy4M0x7jMybItBxY5IGpJROcsL7chDtWYH7Axi6x3dufOlkGrqyGSVlWNN36fCl6w0E6Oh9KvN5e5+nsmeuZcM6jjZzhkcplwx9Fnu0c2AZ70Czh7MrTmG3m1ZVESAKkuGW8tzD9iSMrVM1h7mgPpRxifXvhLryZ6R508yaebjYCe9cl5ZKiTWA7r27qhLEh6sN9uWLkD6lilhhphAmZ3OyKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v3y1lgpV9TBAkv1Hc5g+zgEkjofG/DjUVaIIFgULc2Y=;
 b=iNNBYGDRRHQek6buTPhFRQdbur+kh+96DKFo0fRG3qZIfE/47ZxzNVEfBB7eLbyc8l4x6/qQ9F6T2sPChc/3d2D8YYh78UP2xWdd056t9oNdjL25vZIC/xDyVs9dMtYWS93fomoG8TiVXTC54nXWhQf/00fSS975T1VIk/rfcgoetZojtVfGrBQsHj/g3xbYyB3/cOgzhFiVtTLxKYRru1ZQEIfCEMRESiy8IBzKa0IOXJndCOt9lEqfuz/Wu6w3bW0ufZKUKXKNiD98srsbELt5eHYZq/+dkZ0ITTjcv3lija7P4QipjQlmOPCZuWype0JnX5SRlI3C7QcVWcPMbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3y1lgpV9TBAkv1Hc5g+zgEkjofG/DjUVaIIFgULc2Y=;
 b=Nx2mfNTP3AQiqIRIvbUGY55SfyZvrel+Y1s8+clQ2rGx8p1ZkepW3p+l+Xv8RYsYzeJcszfoEDm1EGoTZ7yMmD75ybSGckb6+7wrKaJjIPNCq+5eKiFxK9n5Jrb8a+HaAJknT7l7Y/oXfbY7qMUeFJ7eaJCWdldRqhrtAQ1/6o0=
Received: from DS7PR03CA0018.namprd03.prod.outlook.com (2603:10b6:5:3b8::23)
 by LV8PR12MB9407.namprd12.prod.outlook.com (2603:10b6:408:1f9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 04:49:38 +0000
Received: from DS2PEPF0000343B.namprd02.prod.outlook.com
 (2603:10b6:5:3b8:cafe::44) by DS7PR03CA0018.outlook.office365.com
 (2603:10b6:5:3b8::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.2 via Frontend Transport; Thu, 8
 Jan 2026 04:49:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF0000343B.mail.protection.outlook.com (10.167.18.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Thu, 8 Jan 2026 04:49:38 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 7 Jan
 2026 22:49:35 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>, Asad Kamal
 <asad.kamal@amd.com>
Subject: [PATCH v3 11/24] drm/amd/pm: Drop legacy message fields from SMUv11
Date: Thu, 8 Jan 2026 10:17:27 +0530
Message-ID: <20260108044839.4084279-12-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343B:EE_|LV8PR12MB9407:EE_
X-MS-Office365-Filtering-Correlation-Id: c4cf59e4-fb42-4919-096c-08de4e715435
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?72F8QnisiLQLZoOQp8XjwTijdx8HVbS4VUoUXpJsf2sXzliaHW/QPz7SNtXY?=
 =?us-ascii?Q?WYb+NRgezvWiBaEbUrCrK4fYG6NERt9Jq/HatXDbWnvqiwYgtlNHzAv2ZO4H?=
 =?us-ascii?Q?27CUiIA7elHgzcXjyUs+PdrPAxCcMBpaIhQetAp16/AfE58VWoAXlKYXxT0f?=
 =?us-ascii?Q?PUa3xM4o4g7i73EA/T/64plwmdWEPMhmwzd5fv6u+bzLCldKt6f/354GJjYL?=
 =?us-ascii?Q?WTMAw5Zop29K9BRA7Uz1gBeTIvrTbffzr+790l7t1KqYMFiEXfWiHV9e4abe?=
 =?us-ascii?Q?pcfbYQLNJfoG1emVarjtxuP6zI963JPBDIghbPWc0qpcRJgIN1WQxiwx2cr0?=
 =?us-ascii?Q?YBYZMiW1vTXfdXVAH5e+LpOJn95nE6Zgsj4qw5djb18OjrHwGq2Zxit1TLOK?=
 =?us-ascii?Q?NHglgVYktoxvJPL3F2cMUifvqOXJcXIbUWuPTAMSBtH1cZXexqKnF5Nxn2rK?=
 =?us-ascii?Q?+6bC2kcCgUE+rCQqfmTLCufP97OwGBNfT33sX1i/2Mil9rn6uBO7Sncykf+d?=
 =?us-ascii?Q?IIdYjCItIVNnD8RNGDFfxV5MU7+fC01XTfAWPcbWgsKDWfNGYA0r++5S47bt?=
 =?us-ascii?Q?qq73xPO5qEEmm0PHqO3LSfXXEUj+J39QcNkHEM8UnWDiIQunOfltGqPmA/3m?=
 =?us-ascii?Q?L9y4ZIWkZE+D5VOsRwQxejWbh1BJh0JmUXg0wQnotUkONyN1UoEMS9wuxU0t?=
 =?us-ascii?Q?yNVS/BK08/IE5V7a8ic3tKUI86gkWLI5hflviPec7z4y+Otr6IRfT28QwgZn?=
 =?us-ascii?Q?nYEoX29zI+pJilTlR7KhSMqoFq8/QWSYw9+GDQffTZSL/iZLtJYrSXCK6Cp8?=
 =?us-ascii?Q?HfwbIsXfWAIWP7oHKI6YqHy8LQl+47w/LU4RTWkF/3quouqDRys0afR3TNXg?=
 =?us-ascii?Q?0WqpShnlmu98ob3YB2l4NEi52RqPzJwjvyzJSv0b6PvHWL1p69r7p/J8In/l?=
 =?us-ascii?Q?cA2T6O0oqQWJD5cNIQT1OayXB3GfEmWHpmiVgdiXqW8zc/8NrrfuB0eYdGgT?=
 =?us-ascii?Q?N+12ye87JcxtAcvn00B0ST/gwYHd7lF4qezDIZzIdwFJHU4v3oARYtlqNrIg?=
 =?us-ascii?Q?Le85vu7nWvVrynyIlQ7X9d2oSzFtlX9HbVhBMWmasmxuaLkppEXW7NpTWNOn?=
 =?us-ascii?Q?oS1Emk9JvEa3WUyFRa0NbJSQd5gs/9sWE79scnG4u7sM/5ld6393Q+poavn6?=
 =?us-ascii?Q?BFrn5aekpYe7pDvXRvaDGO3r99dXElYN4AMiOnYz8AGbvLT0s+yTvLn2SRbR?=
 =?us-ascii?Q?t1J7uTogvMnlnHnZKXDuKFfWsO2XxdZgUh5v6Dgz9K63uVojSbbUjXqfUE0E?=
 =?us-ascii?Q?vnEgZ+HD+YtzLgtomPmZCnQh45TcY4kXSUU0wtVjx+4vKltsP0uAw7ZRM8aK?=
 =?us-ascii?Q?0gMkiM1UjbWm8n8+inZiPz2irhOqthznj7qAj+TuJLJrv5vUBI1egeIi5m3Z?=
 =?us-ascii?Q?o1AyeMdUpnv/I5Sh1TqUwyvoFX/eTH+We5GjhxDIVtlpGg3sK9jxfGTsqUFi?=
 =?us-ascii?Q?dMkaPQbYJgVFFZJ//eJSsKbnFNXJ1W5K/vI644F1i9LwZTiwkvThk4CDmNpR?=
 =?us-ascii?Q?iZGA9BEbeAlmDRB7r2U=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 04:49:38.3431 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4cf59e4-fb42-4919-096c-08de4e715435
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9407
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

Remove usage of legacy message related fields from SMUv11 SOCs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h            | 1 -
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c       | 2 --
 drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c | 2 --
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c         | 2 --
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 2 --
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c          | 9 ---------
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c        | 2 --
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c                  | 4 ++--
 8 files changed, 2 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
index 97c19005952c..7c1701ed3e11 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
@@ -282,7 +282,6 @@ int smu_v11_0_handle_passthrough_sbr(struct smu_context *smu, bool enable);
 
 int smu_v11_0_restore_user_od_settings(struct smu_context *smu);
 
-void smu_v11_0_set_smu_mailbox_registers(struct smu_context *smu);
 void smu_v11_0_init_msg_ctl(struct smu_context *smu,
 			    const struct cmn2asic_msg_mapping *message_map);
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index eadd81e413aa..4de7ae6f7c8e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1959,12 +1959,10 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 void arcturus_set_ppt_funcs(struct smu_context *smu)
 {
 	smu->ppt_funcs = &arcturus_ppt_funcs;
-	smu->message_map = arcturus_message_map;
 	smu->clock_map = arcturus_clk_map;
 	smu->feature_map = arcturus_feature_mask_map;
 	smu->table_map = arcturus_table_map;
 	smu->pwr_src_map = arcturus_pwr_src_map;
 	smu->workload_map = arcturus_workload_map;
-	smu_v11_0_set_smu_mailbox_registers(smu);
 	smu_v11_0_init_msg_ctl(smu, arcturus_message_map);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
index 5ae6ee87de04..15968b057469 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
@@ -601,9 +601,7 @@ static const struct pptable_funcs cyan_skillfish_ppt_funcs = {
 void cyan_skillfish_set_ppt_funcs(struct smu_context *smu)
 {
 	smu->ppt_funcs = &cyan_skillfish_ppt_funcs;
-	smu->message_map = cyan_skillfish_message_map;
 	smu->table_map = cyan_skillfish_table_map;
 	smu->is_apu = true;
-	smu_v11_0_set_smu_mailbox_registers(smu);
 	smu_v11_0_init_msg_ctl(smu, cyan_skillfish_message_map);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 3596cb7f8adf..d7aa16681e24 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -3369,12 +3369,10 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 void navi10_set_ppt_funcs(struct smu_context *smu)
 {
 	smu->ppt_funcs = &navi10_ppt_funcs;
-	smu->message_map = navi10_message_map;
 	smu->clock_map = navi10_clk_map;
 	smu->feature_map = navi10_feature_mask_map;
 	smu->table_map = navi10_table_map;
 	smu->pwr_src_map = navi10_pwr_src_map;
 	smu->workload_map = navi10_workload_map;
-	smu_v11_0_set_smu_mailbox_registers(smu);
 	smu_v11_0_init_msg_ctl(smu, navi10_message_map);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 087b4b6ce857..90aba9adc24f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -3182,12 +3182,10 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 void sienna_cichlid_set_ppt_funcs(struct smu_context *smu)
 {
 	smu->ppt_funcs = &sienna_cichlid_ppt_funcs;
-	smu->message_map = sienna_cichlid_message_map;
 	smu->clock_map = sienna_cichlid_clk_map;
 	smu->feature_map = sienna_cichlid_feature_mask_map;
 	smu->table_map = sienna_cichlid_table_map;
 	smu->pwr_src_map = sienna_cichlid_pwr_src_map;
 	smu->workload_map = sienna_cichlid_workload_map;
-	smu_v11_0_set_smu_mailbox_registers(smu);
 	smu_v11_0_init_msg_ctl(smu, sienna_cichlid_message_map);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 579b1dbd36ac..eb1b9faf8e5c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -2168,15 +2168,6 @@ int smu_v11_0_restore_user_od_settings(struct smu_context *smu)
 	return ret;
 }
 
-void smu_v11_0_set_smu_mailbox_registers(struct smu_context *smu)
-{
-	struct amdgpu_device *adev = smu->adev;
-
-	smu->param_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_82);
-	smu->msg_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_66);
-	smu->resp_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_90);
-}
-
 void smu_v11_0_init_msg_ctl(struct smu_context *smu,
 			    const struct cmn2asic_msg_mapping *message_map)
 {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index fe1924289040..4ca211ea628f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -2557,11 +2557,9 @@ static const struct pptable_funcs vangogh_ppt_funcs = {
 void vangogh_set_ppt_funcs(struct smu_context *smu)
 {
 	smu->ppt_funcs = &vangogh_ppt_funcs;
-	smu->message_map = vangogh_message_map;
 	smu->feature_map = vangogh_feature_mask_map;
 	smu->table_map = vangogh_table_map;
 	smu->workload_map = vangogh_workload_map;
 	smu->is_apu = true;
-	smu_v11_0_set_smu_mailbox_registers(smu);
 	smu_v11_0_init_msg_ctl(smu, vangogh_message_map);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 177643df1aab..6b673eefc7b1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -584,10 +584,10 @@ int smu_cmn_to_asic_specific_index(struct smu_context *smu,
 	switch (type) {
 	case CMN2ASIC_MAPPING_MSG:
 		if (index >= SMU_MSG_MAX_COUNT ||
-		    !smu->message_map)
+		    !smu->msg_ctl.message_map)
 			return -EINVAL;
 
-		msg_mapping = smu->message_map[index];
+		msg_mapping = smu->msg_ctl.message_map[index];
 		if (!msg_mapping.valid_mapping)
 			return -EINVAL;
 
-- 
2.49.0

