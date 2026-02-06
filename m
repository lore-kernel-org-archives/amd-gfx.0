Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67B39EE20A6
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Feb 2026 14:01:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C1E910E7A3;
	Fri,  6 Feb 2026 14:01:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="THZWnwWg";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012051.outbound.protection.outlook.com [52.101.53.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD70410E7A3
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Feb 2026 14:01:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=devkKo5aVOTzmPhGZfIIPEjN/js2Cu5PJt0tfGTTFEVxi/waKUMV9OMEBu+NPMXJA43S/Pn4Pouz4IM18Mez38mIbny6eEw2i881W2nqMIWO0AZLMs7Lu17m1lArucs500riGseBnnZ3ZCbYTp2sp63ktpsUOOTZGjRbu/dm4hERWcMXj0S4AbyVSccsienOeX94nCU2s1fa2m/I8dseCA1/F7/5lIbGOtBwGzGb3PYq542zmRiuXkuV5AtmjKNaVhnPy6wjUPvvWUesO2S27H4sPd4e7HA00b5ZG5Ab4ZAcR5YT7TbOhINFgIpjykbKSgIB5Z4+FkvdHOoip9gzBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wcGVrbDRVdWrEvndHhTk6rJo2JTibIkc81FA5rA42Fs=;
 b=j7nNVsIv4Zfl6QgNHVEeApGl8a7S58qe1evjylWMqhh2Kg+qopjBgwCl4Lg7dQa7DcbWZIUYU9Ti/L+I2IOWnkCa6SygtxsgQF/hsaVCbKVGsiAqPwDPExhQcE4n2Aj6fHyX18L61+5byrrta8HtqO2txlveT2fq2f4Kr5C6aT9OdIf96fEwFOGKsnaZ4rJTJzIftmwTV/e4QIdHJsLpPmoLUHSJYIiKjulursoD/SkGbWLAyZz16ZR2ZhJbthbkr71QkanU4B9uCKzRb5tQDsNn/7p3OwZaQ8HfZNMFpsFnw4wVxKumtD3giG8Bow/DCRtWdBQB2fMn8VGiqIu4kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wcGVrbDRVdWrEvndHhTk6rJo2JTibIkc81FA5rA42Fs=;
 b=THZWnwWg2UtTbjKmHlM9oe46XuLrgJXMIfKKBv+SiP2/ccrqDdNx7YZMHA/Ii9iW7f6p8n2CQaTfI4MMWR91xzXRvgO1kzubJ/czQH1WkTlPPvvf78xyJrWFQIOVjy62pPIVDwrnDW9oO5FO7NxejQzi1JK8NNwzHlSAZ/t2s78=
Received: from MN2PR07CA0018.namprd07.prod.outlook.com (2603:10b6:208:1a0::28)
 by PH0PR12MB8175.namprd12.prod.outlook.com (2603:10b6:510:291::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 14:01:17 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:208:1a0:cafe::d3) by MN2PR07CA0018.outlook.office365.com
 (2603:10b6:208:1a0::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.15 via Frontend Transport; Fri,
 6 Feb 2026 14:01:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 14:01:16 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Feb
 2026 08:01:15 -0600
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Subject: [PATCH v5 06/11] drm/amdgpu: Fix is_dpm_running
Date: Fri, 6 Feb 2026 14:00:43 +0000
Message-ID: <20260206140049.105294-6-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260206140049.105294-1-Pratik.Vishwakarma@amd.com>
References: <20260206140049.105294-1-Pratik.Vishwakarma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|PH0PR12MB8175:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f19cd9f-3425-45b4-2ac4-08de65883267
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6kKimLyWC9fsDeFvHbUwOf+K/iwMZA98qMAteoyVFBBi/RHLpcxep6HIDJ6o?=
 =?us-ascii?Q?q8S6kzYCebg2Z6OD3l4bcCTNlIoJ7pco4NZxRhsS5jeR7SV7qxDBWUazFNMw?=
 =?us-ascii?Q?keHPe1lzhnXwqnGxnUwJ6+Us2cDBzHIWLu0DV9YDC8SdO84Nc9DSaf7bCKE2?=
 =?us-ascii?Q?cgimxnGJXUxEoQQXU0h37fmcWz+k5DZBhqmT9J5yCZGAu0NGfWhFFKfW/nDn?=
 =?us-ascii?Q?++/doqIsojUgoRB4lhAgGP1cIZzDh1sOENDB5MiIW1QsN3cYmqx4A7DSVQKT?=
 =?us-ascii?Q?B2iMARV7gEltY2NhAgvA1LJ0IQ+JM78dt+o9lRS28S+nnac5JWXBglQYWSkp?=
 =?us-ascii?Q?5M6Sbe/nHjxBGp1qGmy7smd7RpRyYq7G3OcLkQ6rY8XsKd/Hdisx5ygH45QQ?=
 =?us-ascii?Q?Y5tmBJktoM5KvZd9EefjVFbcTLcuFnpG+3uHs2M1dNTSjbQY0uSREzxr/eW+?=
 =?us-ascii?Q?wkAldmCmMxbcCwxj6ZR1SXxHnR493ncFgR5muyAVgZrl5VIJBJcCCRgcUUTH?=
 =?us-ascii?Q?dOrBxAbn+23aOJzf15VLpgc1P8ZuU84tb1D6lKD4P6nUCmLBz5UuGeHSpxCc?=
 =?us-ascii?Q?Tc+JhclUaDQ9zxH6OxSfpeAYQKhzq5DJ0LiQWJwveA5COT8Lhhpi111bjsg6?=
 =?us-ascii?Q?7kPrXSjnhXTpQB4lngj/SBOIyyP/QZbA1sdKWnIHR4I3AzJLqlszL2DoOaOe?=
 =?us-ascii?Q?PL2T5dLa7ULbjq6Td6Ay8cwsyAoXtymoa9aYzrsicS9ue9X89TApLDV2a/Eu?=
 =?us-ascii?Q?rxEv5dcV1PWhazkHj+V5EuUWO1KhBVlj0abSDGBmYB0jP9gZ0jx8gb1qp98D?=
 =?us-ascii?Q?0r0VE/GPcwRxl6Q1R4GIIxlKoUcHOJlpULMhvEeKW2u/prBaegN/2ML2nA4n?=
 =?us-ascii?Q?xH7yMIyrQldkH1J1Rhfg47haquOBeKo5whnyotOukT4iQWVveFBcuKRZy72Q?=
 =?us-ascii?Q?rrpYhv1OvkfwEHZz2A/e2Qv1za4PzCjP7nzXDdIkkrtZUOXzmxppIhsKZsPM?=
 =?us-ascii?Q?9mXitBdzh9kNINX0hseAoY3+djEEZvLd7kH/Eoekn7wejSmry/Rc5SCi5aCT?=
 =?us-ascii?Q?dyTCO8mjjBYnWYUE+QsvSefpKC1iyQLGmupgtF5bqViiOsEcJRwT3MojqYMy?=
 =?us-ascii?Q?qR9nF3+yk+K1aFbwMvM8DH5fOFt3mbM4IjqgAHZG0qNBjc2y2wWk/OusnlC7?=
 =?us-ascii?Q?HSFXWITO/FwviY51FiFmqM2gK17xHAiHIo+FC7SZo7DX249UX499YbTgvl4V?=
 =?us-ascii?Q?WT4oXmcxrHaiX+ShwJVuUTcSGNIjmEYMphr03HuYqQtebuC9oUsbP/2r4q1v?=
 =?us-ascii?Q?gvsi25k1KEx9tsm/wRjDi2jEjjV4nEozpAtElEzDemNvs03r3uhgzVyZX8Iy?=
 =?us-ascii?Q?CZOxl9kvUAUqLt2xE8VovXdH4P2WxPQ4RpiJSRDLrbvWd21em0t8fldgyM78?=
 =?us-ascii?Q?cgJKZwo9dHzMvkqAcrwNkaZVS+MdpiOAGQZjyERoOGH68Y6UUH/iwgu8VhfT?=
 =?us-ascii?Q?7WBACKkHYuY6JvPcG52FypZsmQ1kkxQg8Ol0UCR1TBQFnWIMfcdgZfCfUVrO?=
 =?us-ascii?Q?+BV1Whz2VoSyShXauw5kpW4+4WyWLIdAa+nx0xqaDys4Eukfn/EMVoqAyMKj?=
 =?us-ascii?Q?CLj7kzNGBfio/t6a0BoTZqhAs/AJmCsKGi7ucEsMsy6zHYshsvEyVXcmcP2q?=
 =?us-ascii?Q?ckaFHg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MkqIo6SpwvLjPDDjU0fZuV7Cf8So3nnMIXDH8VWWSNvaJcgcJbzoF37P+btkgN5kCajheV6NJSAbMX1+nKWMgLMizJ5N6ansEMvH8g5pHyzFDz95arzsWg41CjDGlnSVONnyRt9qJpNuKkaJ66tpJuvtxKbYBlj+CE12O6igvivy+wqHQxMunwpF7N+ag+p+Y1o8ULD2ITsHFvbJRygAe7tBCCRFGqYE/WMkwo+5foRBH3LiTTjuN0RKGCSliTRibn18BhXg0mGLZJrwYmJNf3CC6Hn09imQSqeL/XfD4/8q15U0hp3DLETif7ANjhBAf7ZoStNhUuV4svoZOXB4638fN3mdxaQov+mKZ0jxwVgg4GULH3z2YbjMWK7YSYlL1SjJEYK2Ve8KUFivi1tx/E+lt8xubuSVsLzjkTghPM2zIiK78nUbFGix+E+IFY6l
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 14:01:16.8351 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f19cd9f-3425-45b4-2ac4-08de65883267
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8175
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

Use multi args for get_enabled_mask to fix is_dpm_running

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
---
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c  | 29 +++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
index e53201f42e40..891cdd8bc5cf 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
@@ -517,12 +517,37 @@ static int smu_v15_0_0_read_sensor(struct smu_context *smu,
 	return ret;
 }
 
+static int smu_v15_0_0_get_enabled_mask(struct smu_context *smu,
+					struct smu_feature_bits *feature_mask)
+{
+	uint32_t features[2];
+	int ret;
+	struct smu_msg_ctl *ctl = &smu->msg_ctl;
+
+	if (!feature_mask)
+		return -EINVAL;
+
+	struct smu_msg_args args = {
+		.msg = SMU_MSG_GetEnabledSmuFeatures,
+		.num_args = 0,
+		.num_out_args = 2,
+	};
+
+	ret = ctl->ops->send_msg(ctl, &args);
+
+	if (!ret)
+		smu_feature_bits_from_arr32(feature_mask, features,
+					    SMU_FEATURE_NUM_DEFAULT);
+
+	return ret;
+}
+
 static bool smu_v15_0_0_is_dpm_running(struct smu_context *smu)
 {
 	int ret = 0;
 	struct smu_feature_bits feature_enabled;
 
-	ret = smu_cmn_get_enabled_mask(smu, &feature_enabled);
+	ret = smu_v15_0_0_get_enabled_mask(smu, &feature_enabled);
 
 	if (ret)
 		return false;
@@ -1394,7 +1419,7 @@ static const struct pptable_funcs smu_v15_0_0_ppt_funcs = {
 	.is_dpm_running = smu_v15_0_0_is_dpm_running,
 	.set_watermarks_table = smu_v15_0_0_set_watermarks_table,
 	.get_gpu_metrics = smu_v15_0_0_get_gpu_metrics,
-	.get_enabled_mask = smu_cmn_get_enabled_mask,
+	.get_enabled_mask = smu_v15_0_0_get_enabled_mask,
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
 	.set_driver_table_location = smu_v15_0_set_driver_table_location,
 	.gfx_off_control = smu_v15_0_gfx_off_control,
-- 
2.43.0

