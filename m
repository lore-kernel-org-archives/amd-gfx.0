Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6869FFEDA09
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 01:02:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F21AA10E658;
	Wed, 18 Mar 2026 01:02:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="j0R5EdZM";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012047.outbound.protection.outlook.com [52.101.48.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8A5510E656
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 01:02:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NlW7mVIazKK+anS8lhZ3LGbUngWmjYR9ida3GfbyEmfoIcsKYAOsMuIYCOK9OtptX1nwugk1grbuq3xmzodp1vKuh4hWl9lmJYVdVyKhKZ2UTC0aarKNGwiS36VpJUsfh6R5fZnsbEwMEe+eNLtfPbZUztcXHGASgfWOa6dtY48O01Zemk1vTAIbLI00Zk9PDclUL3J3BO5vrlgpNlJgt55kG5Su82UYIviBMa0xVGTObFPu7zBm29jXrwiAP2RQnKEjo/CMtn/d/T8MqMeTXA3NdfyFdRHfxIGH7pvBfbdiVERMDlupcVa6Rr5gkO507mWjYD0zn+FYAO+QSLHdUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EfM56ZCHVwL/5g7ybIP+E5Km4qeOezzzFi6wJEpU7cY=;
 b=wj7+Z1LLYJ3jjIX8R3UxMZgsss9llAaU2OUogJFyZV+bW6i2JdDkoXzot92jbEEdTtir+3CuJySg4CZ5uO6/T+XGZk0R0zFnOKLGJq600rfk72vbvzFsT8uSXVyRLU/Ql3YJUs76BvMX1uOyVtEp5jK85mS8qrLCxTHoC8p9OxFMFlY4fs9TrGnqCwfifVnt0BNLpoYxI03BRsBFGzZano151WFP8xucuySFZBtuwquoXURrSIrZiKTY+0gxu9+eQNlJxWn7CMVhyetbYOrGfQ/Mq3nD7OJ63yoQeExRAPscKgEKLykuy7lLSgRPs5yD2vyIIuUSGE+cZiJfL5I2pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EfM56ZCHVwL/5g7ybIP+E5Km4qeOezzzFi6wJEpU7cY=;
 b=j0R5EdZMoBPC8+yxqcW/LTluruJA41lkflSWyhz7R9vGYHOvnL3tO3c/vxq/n7I5m7XiJyDJAvyNkpfzfVht2/cfj56re5ii88IjuMQpJtE2hUQU0DQEj53pP4cM+/uRFP/CjGeI+6sjuFpiS+wM332Dx6R/83Bit99XJRcuSGY=
Received: from PH8P220CA0026.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:348::12)
 by LV3PR12MB9093.namprd12.prod.outlook.com (2603:10b6:408:19d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 01:02:38 +0000
Received: from SN1PEPF000397B3.namprd05.prod.outlook.com
 (2603:10b6:510:348:cafe::24) by PH8P220CA0026.outlook.office365.com
 (2603:10b6:510:348::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 01:02:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B3.mail.protection.outlook.com (10.167.248.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Wed, 18 Mar 2026 01:02:37 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 20:02:19 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Charlene Liu <charlene.liu@amd.com>, Dmytro Laktyushkin
 <dmytro.laktyushkin@amd.com>, Chuanyu Tseng <chuanyu.tseng@amd.com>
Subject: [PATCH 22/31] drm/amd/display: Move DPM clk read to clk_mgr_construct
 in DCN42
Date: Wed, 18 Mar 2026 08:59:31 +0800
Message-ID: <20260318010224.513094-23-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260318010224.513094-1-ChuanYu.Tseng@amd.com>
References: <20260318010224.513094-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B3:EE_|LV3PR12MB9093:EE_
X-MS-Office365-Filtering-Correlation-Id: 746f0f15-55a8-47cc-f3d4-08de848a0c2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 1Vx0ydugA1UvUfFeDwHwiLz7N/63wbejdXfOtTmkw0O88uPGN7e9gJr4U68Gxe5+tv5fiUUm4NmqojC8N7H7xPEDKizX0m3b4bzHINkY7F4IkWHzsqqQeZ2b5BHytu6Qb1GhTyimyNMoweGrRhetVY+foH20BBwYLwsVQEAN2moAB7kobXOTh7O3uJ/JazY46KN2hc7MA33njVqz+4LCKv+6ZkgrLcG4jizr3FqNHQLHu+4Ak6H4VPnqf1oukad9ZxnQfR//YOnZSpaVfV0tlDMpT+fSzSt+l3pl4mCJ5GGMxxac8fwNqpmGYeQZ9soBzBqAev+LSab/o/xApKuIEmUFIxjOrd51hwhDAsrmlpeZ/EXxW2C8iymTibViwDJt9QO9FjwnYmSmpbSKeRlvmgi91bBSt+HOU2xwpISZiiK2UjWglOo8uSdVOeCABRbl4SRa1BxSGG9aimW2Mn6f3Ex1JYuRNs/n73StI1BgEzRKH7ZaULQo9n0g1JZNvIiJr2NyO4k9IC/0h3XAFSf/yIA61vMarnLAehkCtvu8YHOLt6FnCp3iyKl9blTbb6qUxdN0Rl446VKDfCDaUbejKtYI4lgMXHmtqCYDsHKHIxlaNFLoHcCo0/GQSvs1q/mfA8VMpKzrHX2zEj2sd2xsr8a/s9PasU+t3PHvB59w0DM/ZLBMDS4VZCBJ/7NdqmEYssY2eKEjcHabBH9OX/VdfxTWF1yOvSlonM1UQH/c2R9knNIDBMMRZX99KohnUPUEndqBSXOLyJo8QoqR4vXR1A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4dSnisD+EYjcYIO04RpOmEHEGFCaH6pC75IyFcaTJ5JMYyJF3e8wv+0wbQOiKrgrG+A5iqfJ8w5K3bKAY19Bn1TED6lXGx4u0nCbIviCmTjpI4n4GYkfC+MhLm8RCTjkz+9ARBWrrVRTf90LULLKj7/TINtpYrFAbBneDOHEm1zYwI3hN1Z8U77AVF3d5Ltr6I1cO6h4uS0h5jRQhNC0nBx9NqIqn18VAW6+eLuY+yroIMBK3WLe+DDAY7l7IFpasaWfEN3KlK8scP4D3K25Z33FA0Q4YhBTthdFHWzfKX0mBOcb9jMC3JFvrCWkOuG2vjtk+8zQKQh3i/6beSW9DqEiHp5NiMKPJhqqr5O1k/PWzr7CP0jbtIxrTsu93D+NjeZ/MZxfZm+9xNj4scmy56g75id0uhag0UYPlwNUHAdz5rVVmc2MQipmrbTA6mHe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 01:02:37.7420 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 746f0f15-55a8-47cc-f3d4-08de848a0c2c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9093
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

From: Ivan Lipski <ivan.lipski@amd.com>

[Why&How]
The DPM clocks on DCN42 are currently read on every dm_resume, which can
cause in gpu memory freeing while the device is still in suspend.

Move the DPM clock read functionality to clk_mgr_construct() so it
completes once on driver enablement.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
Signed-off-by: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>
Signed-off-by: Chuanyu Tseng <chuanyu.tseng@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
index 24834f89711d..5671fe481d15 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
@@ -1146,6 +1146,11 @@ void dcn42_clk_mgr_construct(
 			dcn42_bw_params.num_channels = ctx->dc_bios->integrated_info->ma_channel_number ? ctx->dc_bios->integrated_info->ma_channel_number : 1;
 			clk_mgr->base.base.dprefclk_khz = dcn42_smu_get_dprefclk(&clk_mgr->base);
 			clk_mgr->base.base.clks.ref_dtbclk_khz = dcn42_smu_get_dtbclk(&clk_mgr->base);
+
+			clk_mgr->base.base.bw_params = &dcn42_bw_params;
+
+			if (clk_mgr->base.smu_present)
+				dcn42_get_smu_clocks(&clk_mgr->base);
 		}
 		/* in case we don't get a value from the BIOS, use default */
 		if (clk_mgr->base.base.dentist_vco_freq_khz == 0)
-- 
2.43.0

