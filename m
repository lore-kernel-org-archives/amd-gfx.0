Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E3F3C9830E
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 18:46:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEE2210F733;
	Thu, 24 Sep 2026 18:46:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="McphSna1";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012014.outbound.protection.outlook.com [52.101.53.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D70410F72B
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 18:46:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P/B4VsqZnR71b/17eVvcW9646pSwvHgcJ/yN1o6k1J1DMHrMvktYiIA9wMhQdWEexUJjJAAxDZDPx04GNo/uSQA30HP0gwi5S3aUR0ujdeAX/n5KVZsLdSz2/mAJX0nGcgk4kzjsRlXsb+gwQOotFSU9A2cq61XfAHTJ+1sRpuZmc0bQ0o+lH+Z6Wm56VSjsdGtCw/NZJEqw8uY2SFGzjFEwRKiK5/w/QpB4QBSzEgRmY88FiXyqy/sQDW93MF495583tmvzfUOnSy0z4mTgI3q3ai4xYrHGDlKn1xdpg5tMExZ0toVHDb1C0RJTSNFz0quCq3j/oyN8jbbO+1IwJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J1D9DpRFxo8K/99E9UkWhfuNg8N+zXgUEUeAgZlpbn0=;
 b=QllZ/T5R1QjyB3KFAL+UfOhamIXoXI444+z6PK5zH3FcYVfifsRJaqfpG0K2cBg3Z2q2FdVOp5APLGZCewggOSdFh+E/UiKObhVs5WDFn4Y8DC2Bg9axp0/JQ1r0iRii6r8Ee0sFVFwQyrgeWTszDfIvWtFwljfJ5og3ekmokDGTkwl6KqPJINu4BkSvynm69Cxi15SsHmEtjjV2GX/Pi917a0En8St0kRAII3RsppXUhfgSHOy0hHUNmXwfuJU6/ZV9kWZC+ZAHv42d4Q+gAkQqgMAkSCn3AOEYsxQ4QpRgnYYX2hjHFVxVvKywgf9igJcjTuqauQjDA1PysJfRZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J1D9DpRFxo8K/99E9UkWhfuNg8N+zXgUEUeAgZlpbn0=;
 b=McphSna1TxDAksdjZSXppc7VAKzkDDDuBHAZf5ZwDLrVcw7rs7IWHmwR2XwfLC9BokH44aTGm428wkp+SLKkTlH2LG6FKeNwulbCB9u+6yv1n2Cjcox4q8YWccTZXQ6IL5j/1K8sleCni9e8PT4tC59HC+cmeRABL52oWqKwTiE=
Received: from SJ0P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::25)
 by BY5PR12MB4082.namprd12.prod.outlook.com (2603:10b6:a03:212::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 18:46:21 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:41b:cafe::94) by SJ0P220CA0009.outlook.office365.com
 (2603:10b6:a03:41b::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Thu,
 24 Sep 2026 18:46:21 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 18:46:20 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 13:46:10 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Jackson He <Jackson.He@amd.com>, Samson Tam
 <samson.tam@amd.com>
Subject: [PATCH 13/34] drm/amd/display: Remove unused copyright notice
Date: Thu, 24 Sep 2026 14:45:26 -0400
Message-ID: <20260924184824.596894-14-jerry.zuo@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|BY5PR12MB4082:EE_
X-MS-Office365-Filtering-Correlation-Id: b31c5531-cac7-4422-8e10-08df1a6c204c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 2ZmFF0JmjReGD7ZcVhtSzASUIVrCGQtGAOrEhXKHp5V1Rlz3Fw6YrThaT8pEal1EFN4YN2BwIwqFeKtWMcAnl/9iC+k4pNULZbccODoAQwGciPDSwREqP6GLZukawG/wFvACFKAdBJQJwVOKmgDg0sfxJDfEtB4pTDykwGY68tbuIaOjCwIEC2An6a6IWVdx1RKVKfIAWBYk6QjAIo6e6MLC/yXtvEc7DOnCUVuCqVHl1SZq5OvF0Knq8P4HkkyF9C4jS8MhJQ5g7/uxeGcIlmq1az+yYxIL/GA71262HIgSBXd1Zbs9WJ8nmyEdhjtIOc+GauaEbxW+k5Yt8Iikb9ae1TFJ9Ir0p8G/FycyakoQOARZHALMLCa71NXdVn3QEcWRN5sBZJE0PlvLi8qku3boUK1XAiNXWkCBY3ncBCEqG78iViT59ZBuIWVtFC0EgpPrW+2DfAvB8LQT2Kpv0GNDrlOpLwFKUyrhYrOh9z2//MPUGdnlPSfkvV5AnUksY4R+/LPtcJdhm2LvPogWdnnEQ8f71Vs9Ysz//Alt/mmhKAMglIAu6BzIgaqDUFAxOf63/SCZvTF8JFLEILsmP95Ut5crhihpllPdHnXvMF8uRgNFgGPO0zHh2z5ArMmmaFvJ24dml03iqeWcflJ1r0Rwj9mpPKVJpm2U1Atcq5lpI5EryyaJ3+pIDaPOo/r0E89jdJPM30nJLOO9bFGJYw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wVyonxEjo1+IsiFEHyaatQWwvtDPnPwrYwGZzwPTFtbioxM+17A7gtbWc6oVY5TDtvDy/14kGAoCm+Lc+4CL4gbSWnRerjsfurJ2H7LbfQQtFJbxDQXVrEnZ4hJRawXXGcooW8b+KGm2uUUf7kVsz4wlydXI1zkYK2Hm6DjQTb7Sm0qMmNnWCTrKNFtgxeDwNuFGjQSYyfbcXT8l9f/inEOTkZVbjVB2O7ar92Cq7dWkVb4OtNvEBegNu4tXx9uJQMhHM7429fY0ZCT1KOVVLQ5tXt2MF8o7gCDfc5AuV+vKDRHA6sHEMLqMHg9TIJzy4Jl7dZQxO/MpMa0PXXY01WvYSWbQUIOB+AhTbAMRFww8rgz4gW5S9T42en2ngstMCYkf39oMzJdGp6TzAVUa/TPkYVzBoBefY0k335A4rnNBF/yCFbc0s+LnHt4cMXXA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 18:46:20.9316 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b31c5531-cac7-4422-8e10-08df1a6c204c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4082
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

From: Jackson He <Jackson.He@amd.com>

[Why & How]
The copyright notice was carried over from code related to kernel
floating-point support. The associated DC_FP_START() and DC_FP_END() macros
are not present in SPL, so the notice is no longer applicable.

Remove the unused copyright notice from spl_os_types.h.

Signed-off-by: Jackson He <Jackson.He@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Reviewed-by: Samson Tam <samson.tam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/sspl/spl_os_types.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/sspl/spl_os_types.h b/drivers/gpu/drm/amd/display/dc/sspl/spl_os_types.h
index 26553cd6890f..75ccf00f4389 100644
--- a/drivers/gpu/drm/amd/display/dc/sspl/spl_os_types.h
+++ b/drivers/gpu/drm/amd/display/dc/sspl/spl_os_types.h
@@ -1,7 +1,6 @@
 /* SPDX-License-Identifier: MIT */
 
 /* Copyright 2024 Advanced Micro Devices, Inc. */
-/* Copyright 2019 Raptor Engineering, LLC */
 
 #ifndef _SPL_OS_TYPES_H_
 #define _SPL_OS_TYPES_H_
-- 
2.53.0

