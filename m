Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD6FD35663
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jan 2026 02:00:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 482B510E5F8;
	Wed, 28 Jan 2026 02:00:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YBLo0taL";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011028.outbound.protection.outlook.com
 [40.93.194.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0901B10E5FA
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jan 2026 02:00:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ocn9rf6eB5xUV50h764pWTFbGzAUNLuoLuv2SDd+IwsvRbBxHEfT+qFY8WOHQdd58MC6+duCAChyNl2W8jNdZ9ul0r3Gjqj/JOyzqbbxVbZ9dPAxObTCB2/ghZ042RUQ3SaTwMXvlvRwl8xAxVjmzKhzSIInI8hWG1/jc7qih9/bfilSQnR0kAlX1PVRpyNhukyKPgmLHvgg9IjKF6MN+OKUcfmDIm2JrogfoWZ8aPlbRr8gTu1TrWVdEoyQiQF2le/JNtBxPt04JrWle6UEat7O8ZJyiH5mx3xv0PiDhsGDIFB6G2tF7bMUnZmSR964ZNc7X7DUa0nPW+WaXeiMUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gj8aaxM11o6GR8hdFhPRO3WKC26bZ17bWIJv1ltLzrM=;
 b=XuQ7E17MqXMfgiCHgcu02B86i6Rg3L+ZaVcwNh8j+o0WxPBZFWaVuBcUNkxvS01TKXDF9USP57wKFmmGHVZD8KbyFgWV3gTKLLBqsBOF4Xr3XHAXcvmVXTqKojl/MRcbjyo8eWd6kHmo/q+g+73hKE0lid1Pb+9CVzEpTJiOJNyKky3AEEvbPtEiJCrDRiy6wwWPpCWkVoIYkIrCNI7kAV0MR5DGQasqf5lqX0sIJGXuw8LXK/X8lBPNjbhIkJkL/yY9g/UVbBWMguXxGw9WscOFSk6Btb81upF5u0b+z022+2YPhNjIUsu6r9gNYXnkJwAgbxolvOc7pggJebuxZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gj8aaxM11o6GR8hdFhPRO3WKC26bZ17bWIJv1ltLzrM=;
 b=YBLo0taLYZD5EEyAo6QPDa0vVZ/ixLWsKyAor5Cl0seCUm+60zYpUhfXgy2X72rsWZUDO2970KaaGuLVgvAXPJS/a/I1ZswbUfLx6RRV+eCg2W2R8Jwf6mfOU8FJA5OcajADXJLY2WgEJbjLWwQnCAEPk6C8UH9FJRUiWlwJmJA=
Received: from SJ0PR03CA0083.namprd03.prod.outlook.com (2603:10b6:a03:331::28)
 by CH3PR12MB8545.namprd12.prod.outlook.com (2603:10b6:610:163::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Wed, 28 Jan
 2026 02:00:00 +0000
Received: from SJ5PEPF000001E9.namprd05.prod.outlook.com
 (2603:10b6:a03:331:cafe::c0) by SJ0PR03CA0083.outlook.office365.com
 (2603:10b6:a03:331::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Wed,
 28 Jan 2026 01:59:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001E9.mail.protection.outlook.com (10.167.242.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Wed, 28 Jan 2026 01:59:59 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 27 Jan
 2026 19:59:58 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 27 Jan
 2026 17:59:58 -0800
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 27 Jan 2026 19:59:50 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 11/21] drm/amd/display: Fix IGT ILR link training failure on
 Replay panel
Date: Wed, 28 Jan 2026 09:51:36 +0800
Message-ID: <20260128015538.568712-12-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260128015538.568712-1-Wayne.Lin@amd.com>
References: <20260128015538.568712-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E9:EE_|CH3PR12MB8545:EE_
X-MS-Office365-Filtering-Correlation-Id: 96e7df78-d9e9-4694-6d93-08de5e10f1b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?I5tzE50hAfdcbdZTRHExWhd+PKkNPC4x3Xn5mRWPfxQj8p9DkUJaL3lK33qQ?=
 =?us-ascii?Q?t/JmBR/osvW8qGHNF1C82yUOqGiQD0AsVOuglcVWsew0FF92it2+tmPM2Eb0?=
 =?us-ascii?Q?P7k/ErZpZOFw4+Z8+uG5lUMhhzqp2yTn8w56HRo9kFEfuZX/br4C7kxcip8S?=
 =?us-ascii?Q?nPdkiRIK6ktl+gnAOnrHH6Rd8lgaSvsULLQKp8FKYvfBZksffRZQJSKMCh5A?=
 =?us-ascii?Q?IV8npqSLKf/r8K5zXZjTZLlgrmxGi845Ka6LkW1vcWL6M5vN39eVMoSJ19ov?=
 =?us-ascii?Q?ix4qppsmCCsIwDoD+VnurDYwaRPE9DXDFzacbCHa5kVOWbbUw3xXB9qtcP86?=
 =?us-ascii?Q?pLmBuIEcWjyv5Mg1JLvrM1Lg8iBB5exQPbgzfingkzUAlPqA5zWKJWH72LMe?=
 =?us-ascii?Q?1JOfLG4aydidYGri4I+CYbO3vNlpgCLslmRWVdWRfXNbnUVWrqAhOZmEdhx5?=
 =?us-ascii?Q?bv+qE4GUMRLXN0FosZ0Xyv5K9pa5xXXMxyCEOO4dW9pZuZidNDnMExCQ4Xlf?=
 =?us-ascii?Q?y/OKMWUjk5zn9aMpm2gs4yWovf3xM2bTqkjpbsF76mvs6jcKefHQvD0ABsJI?=
 =?us-ascii?Q?3qzktd0fQWZZuN57kWqgXFrEztm7krOZAcIgukbKB789XE+mqiJ9n2yIlVUc?=
 =?us-ascii?Q?J/xOhNieuwzlgfr01xDh1YlT4Xr7RwtsVCYXYtzPEjOLyUBnhEgL+vI1Pjda?=
 =?us-ascii?Q?9WNmOUnSe9iZkl+BDQjuTUN3t4j1TIbd57oOgpFXp3yRmD2E3giLbioAdY8Q?=
 =?us-ascii?Q?3C2cPFX/ejWT6LL2Ttr/kpkApc/yiGtWuu+0B0M6pCQHleCA4ONrbd+zvPqk?=
 =?us-ascii?Q?3r7RAwbf9pv+nYplRamspX3yWngBOzFfcbpNYqup0VcZ/t+h/gkVBPBAWwAk?=
 =?us-ascii?Q?JfQXKOyK4h0DExFeHy6ESb2yRoYYjQimcxNpEKVrLW+htZIljvSDX8jNhAN5?=
 =?us-ascii?Q?zLaktRcS38Ht21XTKuZm2RtCA890obLEksjRDJoHUotKvbetSt/7vLi/dfct?=
 =?us-ascii?Q?DFwhoR5uzBGz5d6wPiZQf0WZ5sT4sP7GDXd83ZI2zzIZGSXvofyrir2MC2l2?=
 =?us-ascii?Q?ywnXcVbLAjYcFFUEWSvgUl2slkmuKn2J1SyOcdyJX3RK3HV0FKYD5+OcJibq?=
 =?us-ascii?Q?WB+JcgNjkAuuQkY2dJHlgjK/lClxX3ns42w63op8n4mM6mXACuMFyZItazTE?=
 =?us-ascii?Q?AbvN+it+zQPznejYHKMuBbBHZnKfJG1L69wdeE8fAqH3RFHLxScFdhcYSDUq?=
 =?us-ascii?Q?OHfS3ozitme44Ogu85G3ZJKZSXzymUpSKQZEQgMadI/ChrY3f4sZcD2Azh67?=
 =?us-ascii?Q?/ZOW5X2msPQGPSZ+EdOvuihkj1KK+m1m0qIch06hHpiQgpfhnt81vGEcPq6N?=
 =?us-ascii?Q?Lp3KiDjue4ztK4rTjvvfVJijSmWqtojxIFCoPymv7DdaDaDKC8khYej8gdX3?=
 =?us-ascii?Q?EqKaFeRH0S2eIaSTevh4TkfvkrJLQicJboa5IsZTJc0wFSZGFzMLhA4NTzZv?=
 =?us-ascii?Q?wbQ+wcyXi5xqZ7JB+rXIP7n0kZRx+/X7IKjrNG9EQUDm8T0+Eowd1wzUMKBK?=
 =?us-ascii?Q?RAHTRB1dlIqmuyaSy7DzxKzTwYU9HHSGBy4JlRo5GglI89SQ2juY2pj4LIg0?=
 =?us-ascii?Q?6++ZdQWgEpRs3ihwOuiGtgUpTvmhfViu9x6kd2zNudQ0PwQonBOBAk6uHNhI?=
 =?us-ascii?Q?Tg45nw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 01:59:59.9931 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96e7df78-d9e9-4694-6d93-08de5e10f1b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8545
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

From: Ray Wu <ray.wu@amd.com>

[Why & How]
Fix the IGT ilr_link-training-configs test failure
by directly using the supported link rates from DPCD.

Reviewed-by: ChiaHsuan Chung <chiahsuan.chung@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 21 ++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 5fb573214f18..cfe35442dfcb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -46,6 +46,7 @@
 #include "amdgpu_dm_psr.h"
 #endif
 
+#define MULTIPLIER_TO_LR 270000
 struct dmub_debugfs_trace_header {
 	uint32_t entry_count;
 	uint32_t reserved[3];
@@ -3507,6 +3508,10 @@ static ssize_t edp_ilr_write(struct file *f, const char __user *buf,
 	uint8_t param_nums = 0;
 	long param[2];
 	bool valid_input = true;
+	uint8_t supported_link_rates[16] = {0};
+	uint32_t entry = 0;
+	uint32_t link_rate_in_khz = 0;
+	uint8_t dpcd_rev = 0;
 
 	if (size == 0)
 		return -EINVAL;
@@ -3551,6 +3556,20 @@ static ssize_t edp_ilr_write(struct file *f, const char __user *buf,
 		return size;
 	}
 
+	if (!dm_helpers_dp_read_dpcd(link->ctx, link, DP_SUPPORTED_LINK_RATES,
+		supported_link_rates, sizeof(supported_link_rates)))
+		return -EINVAL;
+
+	dpcd_rev = link->dpcd_caps.dpcd_rev.raw;
+	if (dpcd_rev < DP_DPCD_REV_13 ||
+		(supported_link_rates[entry + 1] == 0 && supported_link_rates[entry] == 0)) {
+		return size;
+	}
+
+	entry = param[1] * 2;
+	link_rate_in_khz = (supported_link_rates[entry + 1] * 0x100 +
+						supported_link_rates[entry]) * 200;
+
 	/* save user force lane_count, link_rate to preferred settings
 	 * spread spectrum will not be changed
 	 */
@@ -3558,7 +3577,7 @@ static ssize_t edp_ilr_write(struct file *f, const char __user *buf,
 	prefer_link_settings.lane_count = param[0];
 	prefer_link_settings.use_link_rate_set = true;
 	prefer_link_settings.link_rate_set = param[1];
-	prefer_link_settings.link_rate = link->dpcd_caps.edp_supported_link_rates[param[1]];
+	prefer_link_settings.link_rate = link_rate_in_khz / MULTIPLIER_TO_LR;
 
 	mutex_lock(&adev->dm.dc_lock);
 	dc_link_set_preferred_training_settings(dc, &prefer_link_settings,
-- 
2.43.0

