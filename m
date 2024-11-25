Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 698D0D58D54
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Nov 2024 14:38:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18F4F10E28C;
	Mon, 25 Nov 2024 14:38:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ySgWHKVb";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D605910E671
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Nov 2024 14:38:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dpov9GW5zPn1mWdBSTdfOPeY7cINAM4JM01A5rwRw8mP8v7rebL8VAOSeAiuZhVevrKvlMvFfVI79yWVy4WcKtJD9+p1CrGf2TauZd7k2LZfK9iDXD7ii1US0ZvVsYD/yvxMaJCGMhABRKCWHrUZb6rbMEpkbk5/NlN6SYry7Y7xxXFEKig02PZGH6rv1dusqy7LBWUNk35vqG25lKOmpXLQlKV1CrIxe8Zw9Sh1tru7rkONVtjZid+eYRBubdJ6lRSRkk0YF0rmBhlxpyxb2ykKObQ/RoYzRWJNmbfuq/H+WPfBWHURDGp6qh43EsvbDYfhW/RFbDCbSdTJUiBiZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0DNu7jlBYhE7c7wQK9AY05lUj9X37gyxtqJvIEgIfjA=;
 b=Lm4+0tA/t9OJYxZvJJ3H4xAL7msJHXGOYbKaZh8aQ4weSImsP5rQS0tkBny2BdpYTMTkrCim72pcFLHCXSTdFMcuBdkM5xPgdJuWQsBrAKxMWQZqzwQ1253HXId4zL1IZP4lyuYEBbcHCcics6SK1lcJ0cR+NgAVgs04EAu3zSHgUDVs36vWjq7fUbm/YVy3gibKsHsYu+gyasBGJOg2bT4yHdo0ZfQFlJ9B/QLUgcdlIGnPzDy28fMw2dNe+SBUyCClYsfFxqOtqbvYAUzz4ukddbz8oqw5xBwJwOW7sgtiwnPfg7LwRZKknzWUtyis/QxoMNYNuTtzy0DdzsUK5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0DNu7jlBYhE7c7wQK9AY05lUj9X37gyxtqJvIEgIfjA=;
 b=ySgWHKVbD1MQsxpvpj9LSjGNGsovHUmLehLP7t6W6Oo20VM+srVgR8bwiC7a76kjItfc5AE0hMsTqHhHnUZ/w884F7vxQr7jijF6qNpmOaoU94z/g+tVj2RmPWAfCHIhBgmnXzaGXyKlR3F+lqNdAZjY5SAE36N3UEZe4z5YKfM=
Received: from CY5PR15CA0056.namprd15.prod.outlook.com (2603:10b6:930:1b::25)
 by CH2PR12MB4088.namprd12.prod.outlook.com (2603:10b6:610:a5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.19; Mon, 25 Nov
 2024 14:38:46 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:930:1b:cafe::5b) by CY5PR15CA0056.outlook.office365.com
 (2603:10b6:930:1b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20 via Frontend
 Transport; Mon, 25 Nov 2024 14:38:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Mon, 25 Nov 2024 14:38:45 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 25 Nov
 2024 08:38:42 -0600
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <le.ma@amd.com>, <hawking.zhang@amd.com>, <shiwu.zhang@amd.com>,
 <Asad.Kamal@amd.com>, <charis.poag@amd.com>, <donald.cheung@amd.com>,
 <sepehr.khatir@amd.com>, <daniel.oliveira@amd.com>
Subject: [PATCH 2/2] drm/amd/pm: Fill max mem bw & total app clk counter
Date: Mon, 25 Nov 2024 22:38:26 +0800
Message-ID: <20241125143826.2022148-2-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241125143826.2022148-1-asad.kamal@amd.com>
References: <20241125143826.2022148-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|CH2PR12MB4088:EE_
X-MS-Office365-Filtering-Correlation-Id: 1279c08e-6264-4d9b-e9f4-08dd0d5edde0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uvGGYZeYGOrWFsuoT4RMgfJoHKWEWRsbszO+xlZyI79sAsLHlL9/e6llW5Ej?=
 =?us-ascii?Q?f5BIm7TezOWRX8cP61O4VGHoVC/MOF734SVtvxT4gxS7QtyN9uytLnOJZHSZ?=
 =?us-ascii?Q?lOjXvesek89DFhnbHe1zDlkIf3G4aHtzF36Mny3cIbhdrqxQx0J7PnwVL1Gw?=
 =?us-ascii?Q?uI6a68/5g1UPR2MsdfPjtqr5voR7L1bnjFpWVE2WbHm794Y/+UpVRJmViAys?=
 =?us-ascii?Q?VM0qMhUxsu1fJ8HCKw+G3PebSNvG8dOcoyT9MQOXNMkB7LVGw3GYtMTAEi+q?=
 =?us-ascii?Q?aj5w5vbNsCNcdrdOP13EiQ0NXQeIXdGLi6IHajcAhjARgrPXLXJUxTIq6jT9?=
 =?us-ascii?Q?32Kqq9BZdgociT4ZYaqdRbKBbiu2L361HCqEPVMhX6NdHNAjUMmJllzM0nsV?=
 =?us-ascii?Q?GlMkjhtRqZHZGk20Xkm0RPhCiEAreCMPefPYYIJme7e3feTje33dlmHb+AQa?=
 =?us-ascii?Q?VaUMDvc3v+2CK6bnb0tMAr2tA/Z6cn59jftHptlrV/Kr7DsYKXQnQIQt9JXQ?=
 =?us-ascii?Q?ye+ahue19KQFmDoa9xOJx1QZO16ApbJjAVzx59XayjeFPvDgy1Bhab1krQok?=
 =?us-ascii?Q?RU+qGLeTonm28lw36o50y+x9pv/vWf5d5tWBjkBoP6x5lZPA0ROZCELbHJrO?=
 =?us-ascii?Q?i2VHdF8H0tJnCUxPY+GIBn6g1EGrAXVhsQycbDov4hiU1CGAiDiqqTt9rLUK?=
 =?us-ascii?Q?Xvr/pzHq+hkRXuJTJ65PmhrlBfokWgD9ryIt7KvRY/ns4PcZwonjfGTgF54F?=
 =?us-ascii?Q?NsJaBmrZ1AHncW0LXXSeOnkWrG1iKR/BCc9hEOGNwojivSwyontsGt1ptzVY?=
 =?us-ascii?Q?oatPOuCZmLRuRwHET8aQUxZGkdCEYSuGMm/5BjBo3DDlnhFtmi+glVIZwB3K?=
 =?us-ascii?Q?6pK6qpWVG2PQksipM7yFNyOJY3FsOhYHxYejZ6eDJtWDB6WRwFjoANz/Y+he?=
 =?us-ascii?Q?0tRLq013kqIbJbcEhCdQ69PBvKo6vLvwNwNVvGq8jR0BhMPOKh6txmG9s0qZ?=
 =?us-ascii?Q?kPF5JcIzaJk7i8XVK9S5wyWeQAnvu9I/QgcAmGRY0g5nugP45WLGXmP18VhS?=
 =?us-ascii?Q?lG8V4UTcvhj0KYiAHH9/B8ql2q9VTAuZZFMu0yfMdN+1rpYYUftximpIXZpd?=
 =?us-ascii?Q?nBeQoXY2MJkB2P/SWHOrVV/VkkkB/upJDTw4jRKiTGIMc6TAzqas45fmoTM4?=
 =?us-ascii?Q?Q6QunJqqahS/QKwtc+TPPluXvG1nNRAaHrnvKEUjJBx23JTmJLeq0wlLob6W?=
 =?us-ascii?Q?isMVwlGcsdw9uD+fc02AsHr6O8XBeTtxmnzVUbdwQNxbPUHMa1m9ask7o+EY?=
 =?us-ascii?Q?+CekJXv0+mpg0qaTrPSmTFukV3gaCfqQxCdR385b6J+n8UwLDW8kvphCAg7/?=
 =?us-ascii?Q?PGHcJnFe20LNIqYtTv9uyIk9r+pvJ9y4Y4h1iLHvLGs6UXwWWc5JwfwOyh49?=
 =?us-ascii?Q?qDIQJESGJTW1sxSxTp/pRFil37gUaLmF?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 14:38:45.5351 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1279c08e-6264-4d9b-e9f4-08dd0d5edde0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4088
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

Fill max memory bandwidth and total app clock counter to metrics v1_7

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 34 +++++++++++++++----
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index ab3c93ddce46..e77fa9dbf404 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -119,6 +119,18 @@ static inline bool smu_v13_0_6_is_other_end_count_available(struct smu_context *
 	}
 }
 
+static inline bool smu_v13_0_6_is_blw_host_limit_available(struct smu_context *smu)
+{
+	switch (amdgpu_ip_version(smu->adev, MP1_HWIP, 0)) {
+	case IP_VERSION(13, 0, 6):
+		return smu->smc_fw_version >= 0x557900;
+	case IP_VERSION(13, 0, 14):
+		return smu->smc_fw_version >= 0x05551000;
+	default:
+		return false;
+	}
+}
+
 struct mca_bank_ipid {
 	enum amdgpu_mca_ip ip;
 	uint16_t hwid;
@@ -2318,7 +2330,7 @@ static int smu_v13_0_6_get_current_pcie_link_speed(struct smu_context *smu)
 
 static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table)
 {
-	bool per_inst, smu_13_0_6_per_inst, smu_13_0_14_per_inst, apu_per_inst;
+	bool per_inst, smu_13_0_6_per_inst, smu_13_0_14_per_inst, apu_per_inst, xcp_stats_xcd_fill;
 	struct smu_table_context *smu_table = &smu->smu_table;
 	struct gpu_metrics_v1_7 *gpu_metrics =
 		(struct gpu_metrics_v1_7 *)smu_table->gpu_metrics_table;
@@ -2356,6 +2368,9 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 	gpu_metrics->average_umc_activity =
 		SMUQ10_ROUND(GET_METRIC_FIELD(DramBandwidthUtilization, flag));
 
+	gpu_metrics->mem_max_bandwidth =
+		SMUQ10_ROUND(GET_METRIC_FIELD(MaxDramBandwidth, flag));
+
 	gpu_metrics->curr_socket_power =
 		SMUQ10_ROUND(GET_METRIC_FIELD(SocketPower, flag));
 	/* Energy counter reported in 15.259uJ (2^-16) units */
@@ -2465,6 +2480,7 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 				(smu->smc_fw_version >= 0x05550B00);
 
 	per_inst = apu_per_inst || smu_13_0_6_per_inst || smu_13_0_14_per_inst;
+	xcp_stats_xcd_fill = per_inst || smu_v13_0_6_is_blw_host_limit_available(smu);
 
 	for_each_xcp(adev->xcp_mgr, xcp, i) {
 		amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_VCN, &inst_mask);
@@ -2485,15 +2501,21 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 
 		}
 
-		if (per_inst) {
+		if (xcp_stats_xcd_fill) {
 			amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_GFX, &inst_mask);
 			idx = 0;
 			for_each_inst(k, inst_mask) {
 				inst = GET_INST(GC, k);
-				gpu_metrics->xcp_stats[i].gfx_busy_inst[idx] =
-					SMUQ10_ROUND(metrics_x->GfxBusy[inst]);
-				gpu_metrics->xcp_stats[i].gfx_busy_acc[idx] =
-					SMUQ10_ROUND(metrics_x->GfxBusyAcc[inst]);
+				if (per_inst) {
+					gpu_metrics->xcp_stats[i].gfx_busy_inst[idx] =
+						SMUQ10_ROUND(metrics_x->GfxBusy[inst]);
+					gpu_metrics->xcp_stats[i].gfx_busy_acc[idx] =
+						SMUQ10_ROUND(metrics_x->GfxBusyAcc[inst]);
+				}
+				if (smu_v13_0_6_is_blw_host_limit_available(smu))
+					gpu_metrics->xcp_stats[i].gfx_below_host_limit_acc[idx] =
+						SMUQ10_ROUND(metrics_x->GfxclkBelowHostLimitAcc
+								[inst]);
 				idx++;
 			}
 		}
-- 
2.46.0

