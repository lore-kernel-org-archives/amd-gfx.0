Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 654B3C9EC82
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Jan 2026 12:55:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF24C10E03C;
	Mon, 12 Jan 2026 12:55:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dOLylwJR";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011030.outbound.protection.outlook.com
 [40.93.194.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D694510E03C
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jan 2026 12:55:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nvxurGOXdfG8s6nxauWRtuc7FLXSeaBcM1kajVy6npOty/gSRAK/3aHlo5XjwRBZ9JYuXCzWl5y9o6OCVMoA19zDILuxldRWm9khGjotmITsOniTr078HDXSxtTzZC4eNcbaD4LXZE2XqD2+/2MOpqI/Zf43SIKZwRD+TkOn7GzQozebY3G3gf7Mpm+nFOJ0JscwPr2wInqXlZBIBHmIxVifAdxdPl95U9vW+6+YNHmYv+O1Ap6FI2i0+N4rN4fLxlPZlcW5nfpaas9hAPffX0DWzXq70WcdWCdybZeMBP88wm69BKzKGDMV42f4Acu4ZgKc8CimOPU8yFReDdAWag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vVL0Pai53fkH+d1OBQ2FQnznVDQrsMYw4qRIZnYZMAo=;
 b=usUKmiN9Iuw8/Hy1jNkoRNohrRz/OeH2fTpVso9SGCBmj/EVfYo8F0vLz27PfO0yZhB+ALK2qVw0+KiSmC54h7TpAenscbNVFG5DPNWuuGfemeKS13qEAMjK7eE65DzSjpoGyvrvgsGod4W0V1O709VgTawi3RTjhuy5vYKB3dRW9tEVTSsxVLpMHBnjkNSqS7VZaxMHIo3a+gjNwihPVuOS7vJNBMwL0lCg17vq3K7gt1i/wapIQMUtMQ8ACKTmq/EHkiWinVH91U0VR6SvAgnp16LoJxvHuXfChjutY9nRY0kGpw6/4/ApkxzvRiFYhr7qQLYssds+r/qSFEl0oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vVL0Pai53fkH+d1OBQ2FQnznVDQrsMYw4qRIZnYZMAo=;
 b=dOLylwJRviOGSZjMY5D2flrRr+Fi0cXmqVvzmGko87c/Zp4AJtLXIM5Tz1hhw9DzlT8q2Cul654Qqc7qQQufLQc7RlU3/FFIUkmCSZVPWltlNhwmqnRYeiZwRNgL0/vkk1uQzKcT/X5uTU8lqpLN2KQ7xxG+0TFOEY2fy48we88=
Received: from SJ0PR13CA0107.namprd13.prod.outlook.com (2603:10b6:a03:2c5::22)
 by LV8PR12MB9690.namprd12.prod.outlook.com (2603:10b6:408:296::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 12:55:02 +0000
Received: from SJ1PEPF000023CB.namprd02.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::b3) by SJ0PR13CA0107.outlook.office365.com
 (2603:10b6:a03:2c5::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.4 via Frontend Transport; Mon,
 12 Jan 2026 12:54:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023CB.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Mon, 12 Jan 2026 12:55:01 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 12 Jan
 2026 06:54:59 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH 1/2] drm/amd/pm: Use emit clock levels in SMU v15.0.0
Date: Mon, 12 Jan 2026 18:24:41 +0530
Message-ID: <20260112125442.198976-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CB:EE_|LV8PR12MB9690:EE_
X-MS-Office365-Filtering-Correlation-Id: a4b8eee1-f221-431e-98a3-08de51d9cceb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NXyqfmQpLWTvPuAK37mud7+glHplbjiz6rmjhUVn5vy5vJT6KWKD5C4sryFN?=
 =?us-ascii?Q?IFMsBx32UQJm5KAwtxdrqUl8Vg9v4B58wT/8Nr0Zw8xdWDK+I9klhBOJoRcQ?=
 =?us-ascii?Q?jDIqXakye4pRP94SctMdlzs4AzteP6Nh4iobTbyzU6fDvB9uyYTiuV1D4hbh?=
 =?us-ascii?Q?xsw3uMqnATzRchsuf4WlxVSXY4yWiNfFNFH/RgXRvv1rO+ftROr4mzFC5OyV?=
 =?us-ascii?Q?KRztO6w7104r2Q8pi9mJjx5e+7K3x7FG8v+9vXfcJYzQizYwu15sWBh+w1XR?=
 =?us-ascii?Q?MzR0LyZNTh21s7ognNY73X9VupeAtjtgfxOTxnzYw+Qs6NYoXHLN+viVXgMc?=
 =?us-ascii?Q?vo6rl4rnTga1Zu/yx7X5a0hESIcO+mEbFMVEUY2evOQ2Xj6EtA4TtskiwDQ7?=
 =?us-ascii?Q?dQV31L2SsZ0F8UWK4UmyHKJBdyKomeJy1k612QJlXmDFs+ejQ3eqAlUqvNHO?=
 =?us-ascii?Q?RnxNXzackQ6PQ3hKG/J8yVmy+R745+Cj2zPURUfTyjPJ4FyCz7d/pTOBdV2Y?=
 =?us-ascii?Q?o9Pi+j1vI6uJZag34OJ0gsXeBa9O0PRSn5pbIXsICd++O+mr8tezY07kd9zi?=
 =?us-ascii?Q?LOm9vhHJ67hfMgQdRSTieNJ1qFzwUSQG27ykgslXF9zmb3iwz3jTiHelBAYa?=
 =?us-ascii?Q?9kIZEhBXbeM74SjMo9dE9Lhac49tkNJXGR5eDJgLO0eaagCxMnjsXtc0cGQU?=
 =?us-ascii?Q?ItklU7Yzw8obZ4Qjigleywau2iCszXkl7ehbj/wtuwztN48UqVaQi2R6DRU5?=
 =?us-ascii?Q?RSFEq3oJVjp0aB5p2aqh+ICzL4qRxvwxMgTS20FXQYYW2IpvVrKPoWzX0+vH?=
 =?us-ascii?Q?4TwHKcWgtaQ4hrrUQOv3ykU/M0zgYaQ1k2EnceSQA9584MTsyNpeZlmIpd65?=
 =?us-ascii?Q?LYSe0cet1BaMg1PWWV31y3V95Pmm7DNOEAlXTUN3ufxa14+jH0GqwRpg06ND?=
 =?us-ascii?Q?rapLUbCdbKx0CEVpr148WJdTZBpQ/CcGRXvBhLlPX9IIjjkLYv4jmpnVUJ9O?=
 =?us-ascii?Q?TJhxWarorFuSx11VbCpL/HmSkxGcYW0a4Kx6jV+w3zDc9yBt2g4YZOs/z5yO?=
 =?us-ascii?Q?JQ6RtyE26mm3759M/vdt+lEgKXawokaCuH2d6OnIPJLiXB86Y92cVvle80Yw?=
 =?us-ascii?Q?rqwcuAvG7jFqAMrm9NwW+LFUfGQ5bT9DN5p5t3YsHO9rkhWshDGs8YBFCWMS?=
 =?us-ascii?Q?KnuQSNT5TU7uA8VXo7VQfg/hphmudNh5meDRd0vHFdvWEWuqhwgQEk5z2yZw?=
 =?us-ascii?Q?/HXQ1jZGEK7DbpnFmLfUigTfOTNg0TqpmdzT3Q44992AhlIgpsL5EIUn96xD?=
 =?us-ascii?Q?1gQq+oUGHd0UA/n9SnowO1N22mrY9eD9XIt+h0U4xnx1/A3hpRkWjY4sspuI?=
 =?us-ascii?Q?541uNdGJpG3pMz/Mf7+RoNKq744UVo0FUMa/tmh/i9vV8b2RdrTxDVIwavIP?=
 =?us-ascii?Q?NpX/SUpAC8v1Edle/HSdJMoMfsKPs6cORTum9LBrZJ6VKL2LCy3HPOghW31p?=
 =?us-ascii?Q?aLLxg4d6tEZrCgJCiKF5r3muFVwCPojFZ+MxBDlTmoeEi3/agLYbOSU9W2Eh?=
 =?us-ascii?Q?GhA+YrJjJqkC9HdaqkA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 12:55:01.9587 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4b8eee1-f221-431e-98a3-08de51d9cceb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9690
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

print_clk_levels is no longer used, use emit_clk_levels instead.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c  | 33 ++++++++++---------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
index 95a693a4557c..b48444706c1e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
@@ -883,15 +883,14 @@ static int smu_v15_0_common_get_dpm_level_count(struct smu_context *smu,
 	return 0;
 }
 
-static int smu_v15_0_0_print_clk_levels(struct smu_context *smu,
-					enum smu_clk_type clk_type, char *buf)
+static int smu_v15_0_0_emit_clk_levels(struct smu_context *smu,
+				       enum smu_clk_type clk_type, char *buf,
+				       int *offset)
 {
-	int i, idx, ret = 0, size = 0;
+	int i, idx, ret = 0, size = *offset;
 	uint32_t cur_value = 0, value = 0, count = 0;
 	uint32_t min, max;
 
-	smu_cmn_get_sysfs_buf(&buf, &size);
-
 	switch (clk_type) {
 	case SMU_OD_SCLK:
 		size += sysfs_emit_at(buf, size, "%s:\n", "OD_SCLK");
@@ -915,19 +914,20 @@ static int smu_v15_0_0_print_clk_levels(struct smu_context *smu,
 	case SMU_FCLK:
 		ret = smu_v15_0_0_get_current_clk_freq(smu, clk_type, &cur_value);
 		if (ret)
-			break;
+			return ret;
 
 		ret = smu_v15_0_common_get_dpm_level_count(smu, clk_type, &count);
 		if (ret)
-			break;
+			return ret;
 
 		for (i = 0; i < count; i++) {
 			idx = (clk_type == SMU_MCLK) ? (count - i - 1) : i;
 			ret = smu_v15_0_common_get_dpm_freq_by_index(smu, clk_type, idx, &value);
 			if (ret)
-				break;
+				return ret;
 
-			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i, value,
+			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i,
+					      value,
 					      cur_value == value ? "*" : "");
 		}
 		break;
@@ -935,7 +935,7 @@ static int smu_v15_0_0_print_clk_levels(struct smu_context *smu,
 	case SMU_SCLK:
 		ret = smu_v15_0_0_get_current_clk_freq(smu, clk_type, &cur_value);
 		if (ret)
-			break;
+			return ret;
 		min = (smu->gfx_actual_hard_min_freq > 0) ? smu->gfx_actual_hard_min_freq : smu->gfx_default_hard_min_freq;
 		max = (smu->gfx_actual_soft_max_freq > 0) ? smu->gfx_actual_soft_max_freq : smu->gfx_default_soft_max_freq;
 		if (cur_value  == max)
@@ -946,9 +946,10 @@ static int smu_v15_0_0_print_clk_levels(struct smu_context *smu,
 			i = 1;
 		size += sysfs_emit_at(buf, size, "0: %uMhz %s\n", min,
 				      i == 0 ? "*" : "");
-		size += sysfs_emit_at(buf, size, "1: %uMhz %s\n",
-				      i == 1 ? cur_value : 1100, /* UMD PSTATE GFXCLK 1100 */
-				      i == 1 ? "*" : "");
+		size += sysfs_emit_at(
+			buf, size, "1: %uMhz %s\n",
+			i == 1 ? cur_value : 1100, /* UMD PSTATE GFXCLK 1100 */
+			i == 1 ? "*" : "");
 		size += sysfs_emit_at(buf, size, "2: %uMhz %s\n", max,
 				      i == 2 ? "*" : "");
 		break;
@@ -956,7 +957,9 @@ static int smu_v15_0_0_print_clk_levels(struct smu_context *smu,
 		break;
 	}
 
-	return size;
+	*offset = size;
+
+	return 0;
 }
 
 static int smu_v15_0_0_set_soft_freq_limited_range(struct smu_context *smu,
@@ -1321,7 +1324,7 @@ static const struct pptable_funcs smu_v15_0_0_ppt_funcs = {
 	.mode2_reset = smu_v15_0_0_mode2_reset,
 	.get_dpm_ultimate_freq = smu_v15_0_common_get_dpm_ultimate_freq,
 	.od_edit_dpm_table = smu_v15_0_od_edit_dpm_table,
-	.print_clk_levels = smu_v15_0_0_print_clk_levels,
+	.emit_clk_levels = smu_v15_0_0_emit_clk_levels,
 	.force_clk_levels = smu_v15_0_0_force_clk_levels,
 	.set_performance_level = smu_v15_0_common_set_performance_level,
 	.set_fine_grain_gfx_freq_parameters = smu_v15_0_common_set_fine_grain_gfx_freq_parameters,
-- 
2.49.0

