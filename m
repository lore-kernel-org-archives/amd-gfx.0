Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23FC6C71136
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Jun 2025 08:01:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C059E10E787;
	Thu, 12 Jun 2025 08:01:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="REwpb3z7";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2AE010E787
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Jun 2025 08:01:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B7olnF54zLIyCdhCUvKPMH7+mIVgP9Ss8tvQZza9i5T2rxFcieBxnANP0K5pz1HEMJHOjV6OpofJVvTUrXvvo6MFgH+nJYFY8CVeAUJ5ME93AM+zNKqAwqkaI20Asbw6X9JJL47Ot1EgsLttHoFXHPVEESfbhy8LilRxrTVe4ee9Qub6PQtyYpUFe5D+97DoosTW2T+wtJXOipL7nYbdOk+a2pzcQd2U7GDMq6pt7EZvEGLuBue9N9A/bl19jld8fSnr0eTD0o215EwFn07zbLAjtIv0Lupq0tFZDxkeqtr8zEVQRJOqTwi+SzqkpFbtYHJV88hQ98x9VJsrs7oAGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l2V2ACLRX7je8G/2rQXiOj5lP+KhSl2qX44Pa+D1K14=;
 b=EmaiuafQuASDt8jc/ESbZs8GP9O2zrN/n/xx6IEyIcqhA9uRJmsAn/qfDLr/d/DKvgdub+AfTWPQGY7f6hh0GYJqSxNBxjuxzTjgPd+WN0HaNLLmcbd6sPl49jU++nm/BNBr/ioUGZU/mdkdGJWAyL8LMmIP+0Jnr3teZgts+K0hzVMFYz/k0VvySS/AD1jE4ugXTdz/Zu7kVWiTHfzL5ZGDBxHH4jZto8n+mHTWShC8L+7H5G5Cq3Jy80CgtRDCHyV/6SnC+fycT3zMswfnYBCm4HhMqY/T7JvGCOrwF/cTucW43ip9FMVxebqgvjl7zuhfIl1Uz1Inp0eY7H38vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l2V2ACLRX7je8G/2rQXiOj5lP+KhSl2qX44Pa+D1K14=;
 b=REwpb3z782prhSdhGCAgkYYMXw6XzqgVV36A+f2JbSlgtzZAzDYtFdCPmrtPq4/58Me3voNcakTF57MOn8xqxDASFzE4wATrFlnhv4ZPmnEgBfFHGHOpVox++Ewd4oXnz/1RwYf8VfV9ycwg8nthyZg3Tcb8ejNc3ij+a+rH+CY=
Received: from CH2PR18CA0043.namprd18.prod.outlook.com (2603:10b6:610:55::23)
 by LV2PR12MB5775.namprd12.prod.outlook.com (2603:10b6:408:179::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Thu, 12 Jun
 2025 08:01:37 +0000
Received: from CH2PEPF0000013D.namprd02.prod.outlook.com
 (2603:10b6:610:55:cafe::f7) by CH2PR18CA0043.outlook.office365.com
 (2603:10b6:610:55::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.22 via Frontend Transport; Thu,
 12 Jun 2025 08:01:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013D.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Thu, 12 Jun 2025 08:01:36 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Jun
 2025 03:01:35 -0500
Received: from kenneth-mlse-vm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Thu, 12 Jun 2025 03:01:34 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <KevinYang.Wang@amd.com>, Kenneth Feng <kenneth.feng@amd.com>
Subject: [PATCH 1/2] drm/amd/pm: override pcie dpm parameters only if it is
 necessary
Date: Thu, 12 Jun 2025 16:01:31 +0800
Message-ID: <20250612080132.433434-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: kenneth.feng@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013D:EE_|LV2PR12MB5775:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c934405-df0c-428c-5cde-08dda9875aa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?noeTAKaPqXxHIvBXFqJivxWJkOrRN85V7JiZxjk4GbaO4+AUCp5gwvwWVMEb?=
 =?us-ascii?Q?CzDTRSg5YmqJgwX8ivEiSGqinDN9uEzCVYgYpcKRqj7GlylMglGJEhsEdZUt?=
 =?us-ascii?Q?9Z6A4ikLTsFB61jbp1j8yzliOALaAIzhqdR1FiWfjtqaQ+nqwJCdIldraVCU?=
 =?us-ascii?Q?MlanE4y5GUbDr46rehsa0fj+ni6gKLRutVr1if1atVReNgB1WMfFBqi/RSCF?=
 =?us-ascii?Q?jcUIVCSdjkTVz6rzvai5axSzMVMr/QdLHpz88giMhoy85EHGmQzjOJ7rDiCx?=
 =?us-ascii?Q?zAT3s/U9+7wSj9X2dhP4rwx/baxq/kROK7HFkjBy9VVHMZAoefAJLrQyHOrP?=
 =?us-ascii?Q?6kISGeH97azTQmtSNgK9RNO2yqaZDyT0dMQlp+va3zwvkLN2HCcjWATOhRxb?=
 =?us-ascii?Q?A/bm5HPR2//00/8tRnCQcZ7gsYFiwTA9hXWcLj0SzMwM38tNMgYPcfJPShqk?=
 =?us-ascii?Q?IscmgW2tmrXLfFDfE9vZac8QC4jJA2BdFT9dp0eSKv84xV7ietAE5ItKqvB6?=
 =?us-ascii?Q?/LwhpKv8g1FPAeTZqwDaWwrLrQH7AgKnApMS0q0WporthXQuCnORRnGjA/aR?=
 =?us-ascii?Q?ST2v28Z5zVkn0XAc11D7gooqGAdyiuDh1SKmOsGSjVcnEy4sjrzeHEtHRtVQ?=
 =?us-ascii?Q?enveEZ0afkD23ff9M64R5Ic2KO9KgNqwdl0X3jw044zk9S+6eeU+QAWNRHDy?=
 =?us-ascii?Q?bhniVdxhKAd8J9T2h0E2MoJWZrXlNVKc27ah0E4eQXucyVcuGSTk2gF20D9d?=
 =?us-ascii?Q?6z7ASSdgO9t6rWuBm+S16qjAE0nb+HMyGKDqoie/X7YOzXpaWA5tTpaZwyak?=
 =?us-ascii?Q?GnXCTW7OhjZstutNpxiH/vYy9XuIjITVYtlQ5VAuli6pAV37J+B99NP5v0EA?=
 =?us-ascii?Q?rWJfDvNB6dCCXDQrGjyEv7EYGf5pF4A44JNj8GJ4qnJ6OLRdFLLd1YuTGxXk?=
 =?us-ascii?Q?Aliqa3IN4mMkc7G+FZn/yYMQJ0+4MfjM75DzvxBsuQQDN0w0DXBPg1wkDkF/?=
 =?us-ascii?Q?L//tSojWEmkHDMmWHbHva2fM05AIeTwRvB5a8OJ8bm3jyqF2gokwcI1SltTF?=
 =?us-ascii?Q?L2xVcHTUDpc2Hh8PPI0NakQBGXvMWRjC6/tiiXjhdgysGNKhLtB5XuRaMfl/?=
 =?us-ascii?Q?lLKN9e18BWSrLJVVlNsdyDOjk24MTszWz1lxiT4x0c4SN8zT6oJsdFt8bqPz?=
 =?us-ascii?Q?sk9tJkMfOvF3Ogw8uHbTpgOHAFMZs5eTXEjpwL0no0ZvmQiJaU4iGtMYgnWU?=
 =?us-ascii?Q?lCPSxcnoWkGe7g/Y1j1DG61WTpRVeWpCOvt6JOJs/ka9VzC8TfKhvMFNoMVe?=
 =?us-ascii?Q?w/fV+CgANY7FmUG+zu2TKGSxLXHTSrLx2IYTelFvozz/m9u7VepCVpgsd8xt?=
 =?us-ascii?Q?1wMtWzUJzbaAPdTEdd8s2rihsL8vmN/PW4Mya28Qem85+I/SyBHYDFU/LUpw?=
 =?us-ascii?Q?frxFu7YjFAwnFkYmE4kx70BB4chvzkfupku/XtXAJ8vBr40sE6NMkJFT9riu?=
 =?us-ascii?Q?XPTLmoLJoID7NjhGG0ZubFHwXu7L4W/Bs0HO?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 08:01:36.2532 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c934405-df0c-428c-5cde-08dda9875aa7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5775
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

override pcie dpm parameters only if it is necessary

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 31 +++++++------
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 22 ++++++----
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 43 +++++++++++--------
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 37 ++++++++++------
 4 files changed, 77 insertions(+), 56 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 7fad5dfb39c4..d7d5ec247624 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2444,7 +2444,8 @@ static int navi10_update_pcie_parameters(struct smu_context *smu,
 	struct smu_11_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
 	PPTable_t *pptable = smu->smu_table.driver_pptable;
 	uint32_t smu_pcie_arg;
-	int ret, i;
+	int ret = 0;
+	int i;
 
 	/* lclk dpm table setup */
 	for (i = 0; i < MAX_PCIE_CONF; i++) {
@@ -2453,25 +2454,23 @@ static int navi10_update_pcie_parameters(struct smu_context *smu,
 	}
 
 	for (i = 0; i < NUM_LINK_LEVELS; i++) {
-		smu_pcie_arg = (i << 16) |
-			((pptable->PcieGenSpeed[i] <= pcie_gen_cap) ? (pptable->PcieGenSpeed[i] << 8) :
-				(pcie_gen_cap << 8)) | ((pptable->PcieLaneCount[i] <= pcie_width_cap) ?
-					pptable->PcieLaneCount[i] : pcie_width_cap);
-		ret = smu_cmn_send_smc_msg_with_param(smu,
-					  SMU_MSG_OverridePcieParameters,
-					  smu_pcie_arg,
-					  NULL);
-
-		if (ret)
-			return ret;
-
-		if (pptable->PcieGenSpeed[i] > pcie_gen_cap)
+		if (pptable->PcieGenSpeed[i] > pcie_gen_cap ||
+			pptable->PcieLaneCount[i] > pcie_width_cap) {
 			dpm_context->dpm_tables.pcie_table.pcie_gen[i] = pcie_gen_cap;
-		if (pptable->PcieLaneCount[i] > pcie_width_cap)
 			dpm_context->dpm_tables.pcie_table.pcie_lane[i] = pcie_width_cap;
+			smu_pcie_arg = i << 16;
+			smu_pcie_arg |= pcie_gen_cap << 8;
+			smu_pcie_arg |= pcie_width_cap;
+			ret = smu_cmn_send_smc_msg_with_param(smu,
+							SMU_MSG_OverridePcieParameters,
+							smu_pcie_arg,
+							NULL);
+			if (ret)
+				break;
+		}
 	}
 
-	return 0;
+	return ret;
 }
 
 static inline void navi10_dump_od_table(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 115e3fa456bc..d57591509aed 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -2145,7 +2145,8 @@ static int sienna_cichlid_update_pcie_parameters(struct smu_context *smu,
 	uint8_t min_gen_speed, max_gen_speed;
 	uint8_t min_lane_width, max_lane_width;
 	uint32_t smu_pcie_arg;
-	int ret, i;
+	int ret = 0;
+	int i;
 
 	GET_PPTABLE_MEMBER(PcieGenSpeed, &table_member1);
 	GET_PPTABLE_MEMBER(PcieLaneCount, &table_member2);
@@ -2170,19 +2171,22 @@ static int sienna_cichlid_update_pcie_parameters(struct smu_context *smu,
 	pcie_table->pcie_lane[1] = max_lane_width;
 
 	for (i = 0; i < NUM_LINK_LEVELS; i++) {
-		smu_pcie_arg = (i << 16 |
+		if (!(smu->adev->pm.pp_feature & PP_PCIE_DPM_MASK) ||
+			table_member1[i] > pcie_gen_cap || table_member2[i] > pcie_width_cap) {
+			smu_pcie_arg = (i << 16 |
 				pcie_table->pcie_gen[i] << 8 |
 				pcie_table->pcie_lane[i]);
 
-		ret = smu_cmn_send_smc_msg_with_param(smu,
-				SMU_MSG_OverridePcieParameters,
-				smu_pcie_arg,
-				NULL);
-		if (ret)
-			return ret;
+			ret = smu_cmn_send_smc_msg_with_param(smu,
+						SMU_MSG_OverridePcieParameters,
+						smu_pcie_arg,
+						NULL);
+			if (ret)
+				break;
+		}
 	}
 
-	return 0;
+	return ret;
 }
 
 static int sienna_cichlid_get_dpm_ultimate_freq(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 1c7235935d14..1a1f2a6b2e52 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -2386,7 +2386,8 @@ int smu_v13_0_update_pcie_parameters(struct smu_context *smu,
 				&dpm_context->dpm_tables.pcie_table;
 	int num_of_levels = pcie_table->num_of_link_levels;
 	uint32_t smu_pcie_arg;
-	int ret, i;
+	int ret = 0;
+	int i;
 
 	if (!num_of_levels)
 		return 0;
@@ -2402,30 +2403,38 @@ int smu_v13_0_update_pcie_parameters(struct smu_context *smu,
 		for (i = 0; i < num_of_levels; i++) {
 			pcie_table->pcie_gen[i] = pcie_gen_cap;
 			pcie_table->pcie_lane[i] = pcie_width_cap;
+			smu_pcie_arg = i << 16;
+			smu_pcie_arg |= pcie_table->pcie_gen[i] << 8;
+			smu_pcie_arg |= pcie_table->pcie_lane[i];
+
+			ret = smu_cmn_send_smc_msg_with_param(smu,
+								SMU_MSG_OverridePcieParameters,
+								smu_pcie_arg,
+								NULL);
+			if (ret)
+				break;
 		}
 	} else {
 		for (i = 0; i < num_of_levels; i++) {
-			if (pcie_table->pcie_gen[i] > pcie_gen_cap)
+			if (pcie_table->pcie_gen[i] > pcie_gen_cap ||
+				pcie_table->pcie_lane[i] > pcie_width_cap) {
 				pcie_table->pcie_gen[i] = pcie_gen_cap;
-			if (pcie_table->pcie_lane[i] > pcie_width_cap)
 				pcie_table->pcie_lane[i] = pcie_width_cap;
+				smu_pcie_arg = i << 16;
+				smu_pcie_arg |= pcie_table->pcie_gen[i] << 8;
+				smu_pcie_arg |= pcie_table->pcie_lane[i];
+
+				ret = smu_cmn_send_smc_msg_with_param(smu,
+									SMU_MSG_OverridePcieParameters,
+									smu_pcie_arg,
+									NULL);
+				if (ret)
+					break;
+			}
 		}
 	}
 
-	for (i = 0; i < num_of_levels; i++) {
-		smu_pcie_arg = i << 16;
-		smu_pcie_arg |= pcie_table->pcie_gen[i] << 8;
-		smu_pcie_arg |= pcie_table->pcie_lane[i];
-
-		ret = smu_cmn_send_smc_msg_with_param(smu,
-						      SMU_MSG_OverridePcieParameters,
-						      smu_pcie_arg,
-						      NULL);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
+	return ret;
 }
 
 int smu_v13_0_disable_pmfw_state(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 82c2db972491..d5a4abd60d06 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -1489,7 +1489,8 @@ static int smu_v14_0_2_update_pcie_parameters(struct smu_context *smu,
 				&dpm_context->dpm_tables.pcie_table;
 	int num_of_levels = pcie_table->num_of_link_levels;
 	uint32_t smu_pcie_arg;
-	int ret, i;
+	int ret = 0;
+	int i;
 
 	if (!num_of_levels)
 		return 0;
@@ -1505,30 +1506,38 @@ static int smu_v14_0_2_update_pcie_parameters(struct smu_context *smu,
 		for (i = 0; i < num_of_levels; i++) {
 			pcie_table->pcie_gen[i] = pcie_gen_cap;
 			pcie_table->pcie_lane[i] = pcie_width_cap;
+			smu_pcie_arg = i << 16;
+			smu_pcie_arg |= pcie_table->pcie_gen[i] << 8;
+			smu_pcie_arg |= pcie_table->pcie_lane[i];
+
+			ret = smu_cmn_send_smc_msg_with_param(smu,
+						      SMU_MSG_OverridePcieParameters,
+						      smu_pcie_arg,
+						      NULL);
+			if (ret)
+				break;
 		}
 	} else {
 		for (i = 0; i < num_of_levels; i++) {
-			if (pcie_table->pcie_gen[i] > pcie_gen_cap)
+			if (pcie_table->pcie_gen[i] > pcie_gen_cap ||
+				pcie_table->pcie_lane[i] > pcie_width_cap) {
 				pcie_table->pcie_gen[i] = pcie_gen_cap;
-			if (pcie_table->pcie_lane[i] > pcie_width_cap)
 				pcie_table->pcie_lane[i] = pcie_width_cap;
-		}
-	}
-
-	for (i = 0; i < num_of_levels; i++) {
-		smu_pcie_arg = i << 16;
-		smu_pcie_arg |= pcie_table->pcie_gen[i] << 8;
-		smu_pcie_arg |= pcie_table->pcie_lane[i];
+				smu_pcie_arg = i << 16;
+				smu_pcie_arg |= pcie_table->pcie_gen[i] << 8;
+				smu_pcie_arg |= pcie_table->pcie_lane[i];
 
-		ret = smu_cmn_send_smc_msg_with_param(smu,
+				ret = smu_cmn_send_smc_msg_with_param(smu,
 						      SMU_MSG_OverridePcieParameters,
 						      smu_pcie_arg,
 						      NULL);
-		if (ret)
-			return ret;
+				if (ret)
+					break;
+			}
+		}
 	}
 
-	return 0;
+	return ret;
 }
 
 static const struct smu_temperature_range smu14_thermal_policy[] = {
-- 
2.34.1

