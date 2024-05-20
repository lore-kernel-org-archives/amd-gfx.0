Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53E91C04FFE
	for <amd-gfx@archiver.kernel.org>; Mon, 20 May 2024 05:01:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD03010E2ED;
	Mon, 20 May 2024 05:01:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n8nLxtma";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F39510E203
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 May 2024 05:01:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QBUlWpJWWtu79w933H6r2NLdvpPKmH9tL4G+achl+7PZ0wjfNTZLj7RgBhRumXATy3S9i+vFW9+69jc/Hq3AQgcKXPiV31CbOy9A8YE4AESp/4d910jzzXGQntrvlruZTjHQAgoFGwuKsealwSK9wgRBS3hgOOlM4Vp4j5FTMUvIBSeeSoQ+tXFY9zrffTcWtJZP4YUwJtxXY06CClLkVUcj25QiiEYmFVXQyFQsxhra2PuxA2KDQW6zesDHJbtOTHDHb4SbPwsD+z3KF500HXTY3KdRdVil2jyIcv4AnhQRaAzHTE6/I6pGr8UvyUc3akmqDCa7FhqEBiNOBhT4Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AzqSaoDlXpIC1xzoiOl0mJ2GlA5OkPd4VE9vAhJyirI=;
 b=kUMlPv+9zTxvHV4uadGTlZgnmsDdryn8c95R1BfgCfX8vdId5CC01MmS8ZT1CJ//cHBI4XvBaZqJxdjBTbFo6mlMS4ykQqoFrFvv/lAVds3R/EDBxleEHlAHga7XP4445web6lhWgdLe0nZAMD1BYN6nZ2HgtTXNfrIysMXgLcgo9oqku2C7wZ/69xE9g7nFusGDbMBJ6CslPQ4oE1L1Ot/tvFeKksg+EGmihUoStMw9NFdQNma+77Tc/aWKMHmYX+FoEUbxllFNLpm2/zTQtP567/vL7Gm+0eOxup1bhnH3Ki9OXJEF5aoOC1LZboF6+JmbZhwpEc7RT5OF+zB1Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AzqSaoDlXpIC1xzoiOl0mJ2GlA5OkPd4VE9vAhJyirI=;
 b=n8nLxtmaEfn8EmIbkJ+naxmvLKS386JldV0bKj3s1djRDT50x3QIJbV+H+1rhROjOpVQiUAA8hYMikKoYUNfsN1bvJvdJdKPTyMuDBpyiUiJC8o/Cs/F8HIpVhMJw9LfwdJsTXHzRFdrrHVBDknpQijsqLX3QUTIW0dh0MGJ+DQ=
Received: from CH0P221CA0032.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::11)
 by PH7PR12MB7211.namprd12.prod.outlook.com (2603:10b6:510:206::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 20 May
 2024 05:01:38 +0000
Received: from CH1PEPF0000AD76.namprd04.prod.outlook.com
 (2603:10b6:610:11d:cafe::c9) by CH0P221CA0032.outlook.office365.com
 (2603:10b6:610:11d::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35 via Frontend
 Transport; Mon, 20 May 2024 05:01:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD76.mail.protection.outlook.com (10.167.244.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Mon, 20 May 2024 05:01:37 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 20 May
 2024 00:01:34 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <asad.kamal@amd.com>, <donald.cheung@amd.com>,
 <sepehr.khatir@amd.com>, <daniel.oliveira@amd.com>, <charis.poag@amd.com>,
 <Shuzhou.Liu@amd.com>
Subject: [PATCH 2/2] Revert "drm/amd/pm: Add gpu_metrics_v1_6"
Date: Mon, 20 May 2024 13:01:15 +0800
Message-ID: <20240520050115.19806-2-asad.kamal@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240520050115.19806-1-asad.kamal@amd.com>
References: <20240520050115.19806-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD76:EE_|PH7PR12MB7211:EE_
X-MS-Office365-Filtering-Correlation-Id: 186aec27-bf6a-4f5b-1807-08dc7889ee1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|82310400017|1800799015|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?C8yymUyl0LRdOCTVHZ6OSmgZofACcPePFhicaRAT1v1fHK2YyLdxa2hh0zAM?=
 =?us-ascii?Q?a2JNacZBH5CttPFCGFicFUs8IM3WHw++PkXLmy1AwACXlVXBdmRZBDMl2Hp6?=
 =?us-ascii?Q?qcZ9qFJup5PCS0FTclXZnRbRZt+Q4rvU7ZNwXDJwAMVb+cfPR6tuh/GNPlgT?=
 =?us-ascii?Q?AQLQEMfbqSLN2CMZYW8QdfOWBgVACY5yqh6t+YQ7ZmEzJHXTXljqpWxLsjwv?=
 =?us-ascii?Q?7nNzefo1ZYkPLI71YCNIc+OUt4m8Toji89wZTHa4ZCdphlt7ljek1+TJzMGi?=
 =?us-ascii?Q?ADvdMuc1sqxAi8rk7LjBpWNiQhDypM8tWd/3u1pS6PojJHpLt8kwagbltVfx?=
 =?us-ascii?Q?CpiQ94tiDbJ3M4+2ErsqXHoqzNax2EDp5mxnSVoPtc5KHbySZiDAfaUPGg8z?=
 =?us-ascii?Q?rA/uny8QlI3bvSsKJtBoBuATng1X6GhQYKmrE2/wmZOXj6CNtIWm6sWC87uH?=
 =?us-ascii?Q?iTPMYRaGwe5NJ7jCFxk6tZ4BxkwFnnY285usojBc48d7Kin9TeXkiuVn/GfC?=
 =?us-ascii?Q?g1TPq1JTNSbDYLopzrXigErcahzQGBzbd24QQnDP+Cg6TloIG9IO5Q9TbbQ3?=
 =?us-ascii?Q?JW8SHqzHMkWz5++hMG2mnOMuYHGrlfGEX62AN9EEGCU/2L+mOu5uwTHdmw3h?=
 =?us-ascii?Q?zk22428aOX4jAUVhvOpa2/ZM3VLNxLTshJ8m+wbOy+Jro4dcQXmdEoWKbY8a?=
 =?us-ascii?Q?NCgISIsRiOc7Uabc8X9yyYmAE8SSh+GHFEOGxCXIUAdtuZk4fQJH0DaqNF7X?=
 =?us-ascii?Q?tb0Zt0ISsCYHwt075bp1FKd9jUxJ4PEQruIjSWf+yg4AHd+6EbW3MDVI1Wta?=
 =?us-ascii?Q?kB/iJRf9DqPiuwQQn5IavRWEJlepP3IUtvuXlkdYMfCo5G1hZS7IV2qtEC9O?=
 =?us-ascii?Q?zfREGopcj6T08RcE1JImQz1e1tAmS/kuUHpEYh/nyNTuyq2O92+9HcexWIge?=
 =?us-ascii?Q?tpQrZ9qmlGKt6nQRl+3tJmnhP/6sOiJolaFdPAEmOmDgQAyAyaD2a/Ui2nP8?=
 =?us-ascii?Q?0mxFpCSZHCrPRqw802gDWwybP0He38JPSDNA8UHc7yT8cNZkKONdZV6GZMex?=
 =?us-ascii?Q?5HPrRW4HVfU0JMBHgEg9vkD7A8e0zDZMY0173tifokmJXJqi10jS8hpQU8Hg?=
 =?us-ascii?Q?oA1Ho6+8RajCcu0AD9OXNv2EMoNDhqpldpTDCNIwd84nE8aEf3vYufyIu0XL?=
 =?us-ascii?Q?nSi8fZGk5Bxq13ctxGAU6SMiN0E4leDBUvVAB4/zgaBWigKrRbOsivfg0NA+?=
 =?us-ascii?Q?6J3fJEGVSKJFAkS2XlvI5IdmNC4lzMHe5PaPmCkXXmNwNUZYzt5gMSWF2nts?=
 =?us-ascii?Q?0ncoIAdEyLXJMrhVyTQ7qD6cJtBBOucPYnLexGEL7AzcMQEw6gnRfEKFGxb3?=
 =?us-ascii?Q?TdVlUr2Mi8cSWAy+urmlDN56CB3f?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400017)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2024 05:01:37.9682 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 186aec27-bf6a-4f5b-1807-08dc7889ee1a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD76.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7211
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

Remove gpu_metrics_v1_6 temporarily until tool support is ready

This reverts commit d24c43b1e3193415e28c4b1f3b2908ff88b28eb3.

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    | 89 -------------------
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |  3 -
 2 files changed, 92 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index ac76bcd81a5d..4b20e2274313 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -871,95 +871,6 @@ struct gpu_metrics_v1_5 {
 	uint16_t			padding;
 };
 
-struct gpu_metrics_v1_6 {
-	struct metrics_table_header	common_header;
-
-	/* Temperature (Celsius) */
-	uint16_t			temperature_hotspot;
-	uint16_t			temperature_mem;
-	uint16_t			temperature_vrsoc;
-
-	/* Power (Watts) */
-	uint16_t			curr_socket_power;
-
-	/* Utilization (%) */
-	uint16_t			average_gfx_activity;
-	uint16_t			average_umc_activity; // memory controller
-	uint16_t			vcn_activity[NUM_VCN];
-	uint16_t			jpeg_activity[NUM_JPEG_ENG];
-
-	/* Energy (15.259uJ (2^-16) units) */
-	uint64_t			energy_accumulator;
-
-	/* Driver attached timestamp (in ns) */
-	uint64_t			system_clock_counter;
-
-	/* Accumulation cycle counter */
-	uint32_t			accumulation_counter;
-
-	/* Accumulated throttler residencies */
-	uint32_t			prochot_residency_acc;
-	uint32_t			ppt_residency_acc;
-	uint32_t			socket_thm_residency_acc;
-	uint32_t			vr_thm_residency_acc;
-	uint32_t			hbm_thm_residency_acc;
-
-	/* Throttle status */
-	uint32_t			throttle_status;
-
-	/* Clock Lock Status. Each bit corresponds to clock instance */
-	uint32_t			gfxclk_lock_status;
-
-	/* Link width (number of lanes) and speed (in 0.1 GT/s) */
-	uint16_t			pcie_link_width;
-	uint16_t			pcie_link_speed;
-
-	/* XGMI bus width and bitrate (in Gbps) */
-	uint16_t			xgmi_link_width;
-	uint16_t			xgmi_link_speed;
-
-	/* Utilization Accumulated (%) */
-	uint32_t			gfx_activity_acc;
-	uint32_t			mem_activity_acc;
-
-	/*PCIE accumulated bandwidth (Mbps) */
-	uint64_t			pcie_bandwidth_acc;
-
-	/*PCIE instantaneous bandwidth (Mbps) */
-	uint64_t			pcie_bandwidth_inst;
-
-	/* PCIE L0 to recovery state transition accumulated count */
-	uint64_t			pcie_l0_to_recov_count_acc;
-
-	/* PCIE replay accumulated count */
-	uint64_t			pcie_replay_count_acc;
-
-	/* PCIE replay rollover accumulated count */
-	uint64_t			pcie_replay_rover_count_acc;
-
-	/* PCIE NAK sent  accumulated count */
-	uint32_t			pcie_nak_sent_count_acc;
-
-	/* PCIE NAK received accumulated count */
-	uint32_t			pcie_nak_rcvd_count_acc;
-
-	/* XGMI accumulated data transfer size(KiloBytes) */
-	uint64_t			xgmi_read_data_acc[NUM_XGMI_LINKS];
-	uint64_t			xgmi_write_data_acc[NUM_XGMI_LINKS];
-
-	/* PMFW attached timestamp (10ns resolution) */
-	uint64_t			firmware_timestamp;
-
-	/* Current clocks (Mhz) */
-	uint16_t			current_gfxclk[MAX_GFX_CLKS];
-	uint16_t			current_socclk[MAX_CLKS];
-	uint16_t			current_vclk0[MAX_CLKS];
-	uint16_t			current_dclk0[MAX_CLKS];
-	uint16_t			current_uclk;
-
-	uint16_t			padding;
-};
-
 /*
  * gpu_metrics_v2_0 is not recommended as it's not naturally aligned.
  * Use gpu_metrics_v2_1 or later instead.
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index f265a449c342..5592fd825aa3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -1052,9 +1052,6 @@ void smu_cmn_init_soft_gpu_metrics(void *table, uint8_t frev, uint8_t crev)
 	case METRICS_VERSION(1, 5):
 		structure_size = sizeof(struct gpu_metrics_v1_5);
 		break;
-	case METRICS_VERSION(1, 6):
-		structure_size = sizeof(struct gpu_metrics_v1_6);
-		break;
 	case METRICS_VERSION(2, 0):
 		structure_size = sizeof(struct gpu_metrics_v2_0);
 		break;
-- 
2.42.0

