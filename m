Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FDF7D10F4F
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Nov 2025 13:29:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD3A910E5FE;
	Wed, 26 Nov 2025 13:29:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wuHxpMZ/";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010017.outbound.protection.outlook.com
 [52.101.193.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDF5A10E5FF
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 13:29:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gnqRl5+ZA7URauLjtdJd2oS99ipdTDhbbYys7g//2Vu+7Hojr+OFkNZMFg0cL2Ymn/AhLx8iA6XNstHoH8rywwEVYx2EIBmiRthtk90RZx8HyrPUjE2TAu7sT4OF4LUvdBKxUlQkJgESdFmplYCtD2HgXChD9rD/XjTBOK722QWZeZIL0k2vfCxPKdKjT7uehAGRHigHtDPrvjqPY0/QjvCZdrozqPXhjY36egSm62LBjYLLM5xVvV+TQtGM53f48lr1O1SS1mKzSmKa9OSlbuXrJmefjmV46NwcjS1NlkTCB+lq26y0ncZhwrDnEiukC6Rj3A8Si2pwFKULI7YqEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+3UitNtk3uwA5EMn2ZMv2Hvh8DWStu2Hj4HUVdxY0n8=;
 b=PBt/cyl33LEHDvRbi9rddqkrv06U2o+dGcNn4G25vw6DKuc3+eijREy/VrdPEX4d8AaBBVdMD3e4hVk+JgMdDLsXl8lhH96JSS18hwza6kTEXS0d2khLpD24m6hldqlikU0gIbCIpyen2Om5liLpfrOpWdFCLlFAr6PyBleFH/FR/uAAjF8hVNjfm98QXwCzeG0SFZD9G2yYz0h9TtK4mCXkgkyNpyxPcnUEmR6bBtRi1csffEwFGNH4IzsOTzP+wB59+ji3sjsJkZw8uzbn7LnSJ3btj9uIDNrACJTeDY3ipEyMaCQvmVZbBtm6DmIskZW30ZGTHdvLzvhzmhuAAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+3UitNtk3uwA5EMn2ZMv2Hvh8DWStu2Hj4HUVdxY0n8=;
 b=wuHxpMZ/SuQL4W1qjdEQjz5tfUrec/93jJk2zO6G2oEiC8/rMGwK6ZJYRvZn6x+5RRsEEsFNt/NpnMPhoDy5dnH4Wtlt99DoUVV0J29SH1hXL5Dnq5v2ENGXVWEgPEMFtbPIdy50Uw0pP1J8BHNpud1LuDUVH2bGwb2CuT+bAYY=
Received: from SJ0P220CA0030.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::6)
 by MW3PR12MB4348.namprd12.prod.outlook.com (2603:10b6:303:5f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Wed, 26 Nov
 2025 13:29:07 +0000
Received: from SJ1PEPF00002313.namprd03.prod.outlook.com
 (2603:10b6:a03:41b:cafe::fd) by SJ0P220CA0030.outlook.office365.com
 (2603:10b6:a03:41b::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.12 via Frontend Transport; Wed,
 26 Nov 2025 13:29:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002313.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Wed, 26 Nov 2025 13:29:07 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 26 Nov
 2025 07:29:05 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Jesse.Zhang@amd.com>
Subject: [PATCH 15/20] drm/amd/pm: Use emit_clock_levels in SMUv8.0
Date: Wed, 26 Nov 2025 18:54:02 +0530
Message-ID: <20251126132822.3266730-16-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251126132822.3266730-1-lijo.lazar@amd.com>
References: <20251126132822.3266730-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002313:EE_|MW3PR12MB4348:EE_
X-MS-Office365-Filtering-Correlation-Id: 620e339a-c32f-4805-db93-08de2cefc68f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/NDhLnfXKYfMVmJOvbMlyi/t+EiNeLUOB3V61Kclh8R1pq+KSbVPPY/k6R4s?=
 =?us-ascii?Q?jEhcTiMErlgMvx0wa6QygQ/JK/IPBIjB26s9SY6SoSxSOYJJWElcnsmKfAe/?=
 =?us-ascii?Q?CY4tsyHWcd6s/MCHgsv52jNZxwn8hci0N23wgVxeW0LCSZc9/DyQpPAjiqpO?=
 =?us-ascii?Q?3/eADWR0YQ8LvwQ8eVew1BunRdaanQO/9POCr8hhls20qRYY9LwjIvQp12dj?=
 =?us-ascii?Q?YZ2kIpEBmKkaY+dIlqThEIyPg0KmwETAdLkvONEXlMSZXoeSwCuRFA9BveMc?=
 =?us-ascii?Q?pjI4hyJwc3gNgEyWYyVPWIfBS17sRbx1SRwf8E8RaRNYQ3Cx/tbhwWG/yzJw?=
 =?us-ascii?Q?3y5nUc1qqOls/6ud1wv49Ayr8IGtXaz4uYD5aEyJ9WE3fFFGqU0f/2Q+JSM1?=
 =?us-ascii?Q?Qetha3LN80wMeC6x8hrsGRN7pncgXHyWaxy30/vM8+a3NFw9kSMA5UlzrgLv?=
 =?us-ascii?Q?JxdROvXyQMLEabcVWH2IIm4w6jxpoUxDvk8GW/05LA0TvdTIPt48ln/jd52N?=
 =?us-ascii?Q?0JLKlIUeVQskNvbcuipTA0TwZpMxVfS4eo0qnAdGnaB9sTgWgOI09e9TVfv6?=
 =?us-ascii?Q?ENe8Ywsu4nb05d8j6KDCHSXJS5LGwQHKqnp7IabQR/6/x8QNdpk7j8QvxQZT?=
 =?us-ascii?Q?cJL9JP9nt11XO1X+bbk4l9+KcpL/FxIAADGzh/LmFwsCk/9mJkddQjTX+4/o?=
 =?us-ascii?Q?8chbZiup8YNV65gopkNmuRBYAH1G/kbfqAUMcKYRb0mBZFm10+LifFYFpK2V?=
 =?us-ascii?Q?wMrJaV1qLPCHCXAKWileLV9jxCD3QUsz/yxBTLrlwRbg578x+DY9631rK6+v?=
 =?us-ascii?Q?qucBmCo7/IlVGxBQ4ef8Lqnwg06e3j/FlVjsvJhfqqcaRTZVcd7VMc0BdDKu?=
 =?us-ascii?Q?MTZewheZOq49mF5mUCJwp2k4tI80dBxh+NK1Tw+pm7iVldq+wnc8CCkc+rtK?=
 =?us-ascii?Q?1WusK95etjyga00Go8IoiHg+lBHQD2Fz4PauZvpxtzAgT+iy66wPqlMAucWc?=
 =?us-ascii?Q?paqA1kuhVFoaKjUHZMZzNwIcc3f9XoA2MOAPEN9eKlyVn8J2fx2Gh6ApVB7O?=
 =?us-ascii?Q?BrdezDXgeVyU0d4UHRpsDmCCw9oKx/Vt0a6/KKxlFxtFz3UWRIml0k/gJC2N?=
 =?us-ascii?Q?Z1IVtwjVHlb4dPI2FSfL4/Y/zxoQ23Lzn17mHz8iJ3R8T1L5P+l95F29xj9m?=
 =?us-ascii?Q?DF6acI9vvuRr6ivOx5eX1NyyZkCnDJaKTSR6a6Q/qAcx/j29B1i8c2Hpauyd?=
 =?us-ascii?Q?mzqRboEoIsTseBjs+8TEnPiIfmA67EZxgGU8N9MD8zpbLiFjn3Inf+If8bmZ?=
 =?us-ascii?Q?oMIb60PEoPa8O14CxTgvwnFMmIJEj7r+RUosbOVGVF/IdfCBCy4JQlB9mbng?=
 =?us-ascii?Q?k9a4lVz375gLPIEudKXKYJPIKKiEo/At64k2qoUB54KZhnw4XKzfdTRJpT+J?=
 =?us-ascii?Q?w/yer9uxClYxf0E4IYvf5xLK7G+p2XsYR5t/Ck4LthxssnXL1rXfNeqX8K/H?=
 =?us-ascii?Q?/fGfTP2MQ5zf1Y+DdoRZXs5XQnYo9yW/abIFoMoMUAUxIztV0qtUBHRzo3o9?=
 =?us-ascii?Q?/8vykbeQwuKgPR+i5Wc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 13:29:07.2538 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 620e339a-c32f-4805-db93-08de2cefc68f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002313.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4348
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

Move to emit_clock_levels from print_clock_levels

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c   | 29 ++++++++++++-------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
index 9b20076e26c0..736e5a8af477 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
@@ -1564,14 +1564,15 @@ static int smu8_force_clock_level(struct pp_hwmgr *hwmgr,
 	return 0;
 }
 
-static int smu8_print_clock_levels(struct pp_hwmgr *hwmgr,
-		enum pp_clock_type type, char *buf)
+static int smu8_emit_clock_levels(struct pp_hwmgr *hwmgr,
+				  enum pp_clock_type type, char *buf,
+				  int *offset)
 {
 	struct smu8_hwmgr *data = hwmgr->backend;
 	struct phm_clock_voltage_dependency_table *sclk_table =
 			hwmgr->dyn_state.vddc_dependency_on_sclk;
 	uint32_t i, now;
-	int size = 0;
+	int size = *offset;
 
 	switch (type) {
 	case PP_SCLK:
@@ -1582,9 +1583,9 @@ static int smu8_print_clock_levels(struct pp_hwmgr *hwmgr,
 				CURR_SCLK_INDEX);
 
 		for (i = 0; i < sclk_table->count; i++)
-			size += sprintf(buf + size, "%d: %uMhz %s\n",
-					i, sclk_table->entries[i].clk / 100,
-					(i == now) ? "*" : "");
+			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i,
+					      sclk_table->entries[i].clk / 100,
+					      (i == now) ? "*" : "");
 		break;
 	case PP_MCLK:
 		now = PHM_GET_FIELD(cgs_read_ind_register(hwmgr->device,
@@ -1594,14 +1595,20 @@ static int smu8_print_clock_levels(struct pp_hwmgr *hwmgr,
 				CURR_MCLK_INDEX);
 
 		for (i = SMU8_NUM_NBPMEMORYCLOCK; i > 0; i--)
-			size += sprintf(buf + size, "%d: %uMhz %s\n",
-					SMU8_NUM_NBPMEMORYCLOCK-i, data->sys_info.nbp_memory_clock[i-1] / 100,
-					(SMU8_NUM_NBPMEMORYCLOCK-i == now) ? "*" : "");
+			size += sysfs_emit_at(
+				buf, size, "%d: %uMhz %s\n",
+				SMU8_NUM_NBPMEMORYCLOCK - i,
+				data->sys_info.nbp_memory_clock[i - 1] / 100,
+				(SMU8_NUM_NBPMEMORYCLOCK - i == now) ? "*" :
+								       "");
 		break;
 	default:
 		break;
 	}
-	return size;
+
+	*offset = size;
+
+	return 0;
 }
 
 static int smu8_get_performance_level(struct pp_hwmgr *hwmgr, const struct pp_hw_power_state *state,
@@ -2055,7 +2062,7 @@ static const struct pp_hwmgr_func smu8_hwmgr_funcs = {
 	.set_cpu_power_state = smu8_set_cpu_power_state,
 	.store_cc6_data = smu8_store_cc6_data,
 	.force_clock_level = smu8_force_clock_level,
-	.print_clock_levels = smu8_print_clock_levels,
+	.emit_clock_levels = smu8_emit_clock_levels,
 	.get_dal_power_level = smu8_get_dal_power_level,
 	.get_performance_level = smu8_get_performance_level,
 	.get_current_shallow_sleep_clocks = smu8_get_current_shallow_sleep_clocks,
-- 
2.49.0

