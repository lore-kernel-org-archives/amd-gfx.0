Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF88FC98327
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 18:46:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5270210F739;
	Thu, 24 Sep 2026 18:46:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gTJQcseL";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011022.outbound.protection.outlook.com [52.101.52.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AE8910F72B
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 18:46:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vHq+UI5r/myKq5UK6a5nsC4tk76kZiKqW7/vB+tT+E3G2Zk+J9Xaj4lLZkgxy6/0W7b0vdTBWWmK/94Ynpx2Al5odG9b7qjRALGhcNQ8dOcCf5GqIriGeXhwE28FqigYvwLbWsKdq+BQ5+93xf4lYaFv24ofeZe0+SY2QIcICgjbaPHQy9HNdDrFl1h/CzjJXR6q0xsGx3vAaYLtKa2kGy/ubpfh+j7+dkNnyA0w+AzTwt68yFcTdlgM10CENMaPKo83t1U+4DVCqg3nP7mW40bKi47duSlyIlJlEY4VcSWq24hsteveVQELFeaSaNt6P2AUpSp+Le87CVni6vmwCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KSyo0tcw04JmWZ8oDLTbVdXix1ARfwNI5ocX6IbPJKc=;
 b=O6KgODUFHw5ObEr/4J2jq524Z4YZJIK1MqhZ5BdhedXHNqrDV2Ux4OyfMvWCeE3ioGGP68+xHQAiAJFqDK+ZlToIHQQTHgwcy7YptWRTUrf3kG8PpEqTm8BJWr23UtCDTp9j3FpJaIaNn0n9au6uf0jNJArF/DDfloVpf9GNXw1cg208NE9KwhXaY0amVZJMIiAZ8VJ3+Qo/JLiRsSYuLt3Ubt5tk5vVvABxDKIicH2IGg/3wdkaZXwlvK6yJ6xzvlKoLQhB5x9FULWyfG35bUoelOsAEcqT2uWauvX9BpUi4TNU5aK59s6osrbhIyHprrwPyDW7Ov/+BXVFnzb6oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KSyo0tcw04JmWZ8oDLTbVdXix1ARfwNI5ocX6IbPJKc=;
 b=gTJQcseLGT1gD13Tqq7gaF414MkFNob773ovZUQZG9N/DxrlXCrvVMBxQj15495q8/78akjFs6B3KTglNwEBD8hoEQvDKTbbkADCVgQIsBO2DGtGTHoV+o36zlh1qz1TGhILKnKz7Zad44jqmr3QiGbY6KmxXXd8HoPjJg162u8=
Received: from PH8P221CA0052.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:346::16)
 by CHAPR12MB999223.namprd12.prod.outlook.com (2603:10b6:610:301::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 18:46:41 +0000
Received: from SJ1PEPF00002310.namprd03.prod.outlook.com
 (2603:10b6:510:346:cafe::65) by PH8P221CA0052.outlook.office365.com
 (2603:10b6:510:346::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Thu,
 24 Sep 2026 18:46:40 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002310.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 18:46:40 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 13:46:22 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Relja Vojvodic <Relja.Vojvodic@amd.com>, George Shen
 <george.shen@amd.com>
Subject: [PATCH 29/34] drm/amd/display: Block DSC Padding on DP
Date: Thu, 24 Sep 2026 14:45:42 -0400
Message-ID: <20260924184824.596894-30-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924184824.596894-1-jerry.zuo@amd.com>
References: <20260924184824.596894-1-jerry.zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002310:EE_|CHAPR12MB999223:EE_
X-MS-Office365-Filtering-Correlation-Id: 58715c43-ff6e-4876-1245-08df1a6c2c14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|1800799024|376014|82310400026|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 7bdjS7AILI4og8QOi1MjWi0bZ9MwfczJZJvJsboDFfb5SPgqeSw/lX1v4tqAG28JHHc4m3skGck1cZ8J8vk4aElEu9Wqs5z0DXDoLIPGMHJ6s5WkbHlQr+oo4xeLveiDn8z5eg5f92L1QSn9jmUDoRIGa9nbP2bfWVgxddXh+eNss0MF8FPAfT+F77lRaNCgzh4vO8+eS/CPMjFYZhXjnwXk0KYLPJQXeUm2yW12UI5J7P2cNHvp4OQF17S0ksHD7gszIXBPmVZdeW2G9ylfDTQyEsnYqHdZkNlRZT9FZxaYE+HVk3JS4jlz1GnzIPczel11VTJdFofABD3V5ERRkZrGCl9W82prtN9nb+hvSnxV6PVMZYNwbjCnwYaqAVABgmYkO6LU4JRbNSWK7h1KDFTxnRB1z8lBaLA5a1v4/xiE2iKUVTmOgrThMc3sQr5He6VWqzcoK2NbloIJGmAnHEweDbCtFEzpzlMU7lKxYB+QJZ5aUNFdI5xzgn++rb7TsxsqewkdVq5h4wcXnc6LGOHiLNY9oxPoc8LR8tjJcYW4qOFPlse0bHmruLO+4aXhGKqI0PpSWnzEDIH7XZI/IsLduyn37eZaY4s2FFJ+oqejB1r9Bu5G1j9ltiaW8P79MxJ/XqaGNrmvlPPztHOoXzvqRGMSHpS/d5a9+6M/1MoEG3S6HWZTfV3mMfgIb9RAr4/OTulFBpbBUiAbQAdc2g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(1800799024)(376014)(82310400026)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RXHtimyV98OBje6kuiDd/GXnjhcpJDRraGu3+8Sm3/2AokShUQ1Q4KrFr4q+H9Z8bOhI8U/fjnJ9UVDNCA9RPhd23E9uox1m/y6KI/zsXySSw+CJuBDndSb64kEjXwvoQ9b80GUXs/+9E1ipENtlsfbXYf1TgyiTPSIZHHN2W9m8Y4a/PYGfKgatCBRTqp/2w7+QWLIdNEIVgQ7EPH5gKG+hamxO1wqPPJzavp7jO/AHcrbLZ0rrdUeDDD+9vYQ1s+Sdd2lZq5vi/3LPcGrIlugJJN4smhDS3GY+LXxFwwrpXgAqv4TyftKtxgy6EpyVHxmQDyM9AXgfq2LvkMWuMK7MdrZrOxCKA9oFEnGQBd7A02yD5vPeXQC6ZHRKlzK3fW+zByZLAYEuHHSPhDXZnRliTFeiVRDy0IKQfB+8ix5Q0o+OigGwdoW5x7HxAYll
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 18:46:40.7130 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58715c43-ff6e-4876-1245-08df1a6c2c14
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002310.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR12MB999223
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

From: Relja Vojvodic <Relja.Vojvodic@amd.com>

[Why & How]
- BSOD was found on a DP config due to incomplete DSC padding
implementation for DP
- Block DSC padding on DP until fully implemented

Signed-off-by: Relja Vojvodic <Relja.Vojvodic@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Reviewed-by: George Shen <george.shen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 549f9885b762..7e42790ad575 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -4886,7 +4886,7 @@ static void calculate_timing_params_for_dsc_with_padding(struct pipe_ctx *pipe_c
 #if defined(CONFIG_DRM_AMD_DC_FP)
 	uint32_t hactive;
 	uint32_t ceil_slice_width;
-	if (stream && stream->timing.flags.DSC) {
+	if (stream && stream->timing.flags.DSC && stream->signal == SIGNAL_TYPE_HDMI_FRL) {
 		hactive = stream->timing.h_addressable + stream->timing.h_border_left + stream->timing.h_border_right;
 
 		/* Assume if determined slices does not divide Hactive evenly, Hborrow is needed for padding*/
-- 
2.53.0

