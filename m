Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C5B7C79FA1
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 11:40:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6FE410EB5A;
	Tue,  8 Sep 2026 11:40:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X4Vl8iiB";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012053.outbound.protection.outlook.com
 [40.107.200.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9FBD10EB5A
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 11:40:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F5cYSKsH40D/1zXrjhW94ZK2A4eK811d23Uu6aj2L0lA8q4pOoOVOJCrAd0d3m9hdlRuW553n21v0KjeCiDNSJitAynOblgF+Z5tDMUzxY2PLTi1jl7tSkFeqnF2lYE7ma2RWfcUMUpqhygOpIgJjNIGqzQbN6RxE9axtK2rqyMuoxNOvP6Jk1u5vMk9B3x1Ylpson6NgfA0jKCBgE1baXDbAVj/6KpY8DiuadqeOnQQdWFchd/+6pcnwKc1tQ/uNZhOyrtg+XxcMPxKixqGQYM0bMEly7Az6KJ8u4tnw2E0XjwyKQjda6lVD7x6xIDndeZ228OgXeVf6Eh/I+LeBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UXwjPGb36k6b+abjdzt3OGZvcqea6S8/GjchAkWmBNU=;
 b=W+ahYnGoet1Fq443CnG7i8DJUF2DoGZkjIdSKXZfZmabFn3WYUQ1Hn1c/fOB0LXpLoBmM+TtneDyJY331TL3ATMKGa9ZOgc3+/DgUE0PytM/3cd6rBftUOg3O5CdCZRtaK+PnFTs7JapX/dfzY1m7xxbY+2an3fJnS5DS49NdrNCMIr5epHAtvdWuV/I2xp51DB8QkY4QXkcpNVATjyxOsdTkKYWtILfyvzR4dn2FP0WkkPOYuPOxft8CM0yepbVt5LOV8JMU/aEjh41nBE/CGG+Se/gx3Jy7H0XdiaahfGwMSL7J29fq0yIUVhaZy+SudVAzxpTJSCr+iEbaj+KYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UXwjPGb36k6b+abjdzt3OGZvcqea6S8/GjchAkWmBNU=;
 b=X4Vl8iiBUfjK4+ZeB6EPvUiBuSxiKVkyTDFG3uLgSuw4ZDZ6cDIpdxJWwMHUrVu9HWzvux5EoJkeyYCLFTN4FG44o44f+REz/0VAGr/7imsftbbPXDlGRuYyLWH/Wwu2CixoMjGb6IBnVFjLQWSn3GeXGSrkDz00FnUnUYsWt68=
Received: from MN0P223CA0021.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::25)
 by PH7PR12MB9065.namprd12.prod.outlook.com (2603:10b6:510:1f7::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 11:40:21 +0000
Received: from BN7PEPF000000A2.namprd04.prod.outlook.com
 (2603:10b6:208:52b:cafe::9) by MN0P223CA0021.outlook.office365.com
 (2603:10b6:208:52b::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 11:40:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF000000A2.mail.protection.outlook.com (10.167.248.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 11:40:21 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:40:11 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:40:10 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 06:40:02 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Gabe Teeger <gabe.teeger@amd.com>, Matthew Stewart
 <matthew.stewart2@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 43/66] drm/amd/display: Bound DSC power gating loop by num_dsc
Date: Tue, 8 Sep 2026 19:31:36 +0800
Message-ID: <20260908113338.2433445-44-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908113338.2433445-1-chen-yu.chen@amd.com>
References: <20260908113338.2433445-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF000000A2:EE_|PH7PR12MB9065:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f578c88-6d60-4187-71e4-08df0d9df6fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|23010399003|1800799024|36860700016|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: KlHuoq2WceE83S5CInsVpZ+jp+WugmUx+cwmLfG5lfpOIGmwsIr3ixVkHiuh+1l/VmQwlYOXO76HuwCoi0Yefu31vqnh2mKe2Cipe6md2gnTUTx/glx4MfrDcbyy6P/4LnvxEiL0N/6F+y6olzPQ8sab4mu+1w7FlHcIMrkHHsAQGi3il40hdTMfj5wxm0aBr5rhTe4Rc32JnunVwlXE5BBvWccZL94DXneLrXUxdcAKPGjiMXnu5wnlKuCQt6kw0bC3ABCaDMVXqFWP8JvfzwhMBvSAvVbHyvWgOwSkISWMbP76fwByvs/Sm9EQCC8livaUgdrzwgQRvLJ2MQGu/PIozkwvQF4RrPDSucrWGUHj1znOQlYOUltw/JhIYoqhS2EZxDGQHCa+MiKtbYzrbGPdT3Unx0hpqidspQHhOuEw+6YLy1GkC6Zwp1LFATBGPoolfd0wHEqoIvRTLUEqobTP8UXRn6nJIVv3QY4G1o77BH0WuvY5xVmH1FMqsPTM6GsrbD9E8iFPuBpHYxQfRH1RTs3e/gz2Ebsaej84dP0bJenpHxgjrq4MTgwM9telGj/+BUApTIFZxsd908ocnol1qFUuYpgwdKW3Pcf5sy98+0bVr+22lb0IJycSgVNFwJMWRuRyPXCU5W1VRp65fUvJ4shJHwm1Ax4JA7d0mf1jmZfA39URdenrsRLQhrTQD/S0ZCI0rS5SNhHDVad/5Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(23010399003)(1800799024)(36860700016)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Ht5UC++1hl13m9onhnxhUh8v0kEWGFejHZ97WMWZibiL402K17Cj75A5Czc2cLPsnNAe/GML3nKAzww5sMuAv7QAHtUJmUVVcF53RNY6QrOczKaO+TgqTpFdTYhiUcwqUBSyTPcVneCWZSfDvmNsBMMt5lSjPiogdA9x13rk/d0TfNbfqBKkOVSmAqPqOY3Sp1MgpP33ZJjKFM5DpuzeYE2lC2xKkJIHtbnRflIL98XOkrQMicvMcVHBRhaIOn8BY4LAUIgq21s0Rc1jUWfMl0YY6i3D1z0u8oDP2glLMuV1Hn3dJc3KywnGpw1joq9+wwJWyB8R+wSjWoYEIx3Iy3QP0nbCTemrS8yGjKSyYHjTxW3AN3CjzaM5EIAydAiIR1pqFi7sflktcCAxoJdBsrfnONGIcsBHmXCwzfFCTSs4PJJK3P7yjwfjw8yk9WLx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 11:40:21.4121 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f578c88-6d60-4187-71e4-08df0d9df6fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF000000A2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9065
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

From: Gabe Teeger <gabe.teeger@amd.com>

pg_cntl42_dsc_pg_status(i) should be bounded by the number of dsc,
which is different from the number of DPP on dcn42b.

Reviewed-by: Matthew Stewart <matthew.stewart2@amd.com>
Signed-off-by: Gabe Teeger <gabe.teeger@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/pg/dcn42/dcn42_pg_cntl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/pg/dcn42/dcn42_pg_cntl.c b/drivers/gpu/drm/amd/display/dc/pg/dcn42/dcn42_pg_cntl.c
index 78b33b2dbae8..3a0e09ab0d9f 100644
--- a/drivers/gpu/drm/amd/display/dc/pg/dcn42/dcn42_pg_cntl.c
+++ b/drivers/gpu/drm/amd/display/dc/pg/dcn42/dcn42_pg_cntl.c
@@ -6,6 +6,7 @@
 #include "core_types.h"
 #include "dcn42_pg_cntl.h"
 #include "dccg.h"
+#include "resource.h"
 
 #define TO_DCN_PG_CNTL(pg_cntl)\
 	container_of(pg_cntl, struct dcn_pg_cntl, base)
@@ -582,7 +583,10 @@ void pg_cntl42_init_pg_status(struct pg_cntl *pg_cntl)
 		block_enabled = pg_cntl42_hubp_dpp_pg_status(pg_cntl, i);
 		pg_cntl->pg_pipe_res_enable[PG_HUBP][i] = block_enabled;
 		pg_cntl->pg_pipe_res_enable[PG_DPP][i] = block_enabled;
+	}
 
+	/* DSC count can be lower than pipe count (e.g. DCN42B has 4 pipes, 3 DSCs) */
+	for (i = 0; i < (unsigned int)pg_cntl->ctx->dc->res_pool->res_cap->num_dsc; i++) {
 		block_enabled = pg_cntl42_dsc_pg_status(pg_cntl, i);
 		pg_cntl->pg_pipe_res_enable[PG_DSC][i] = block_enabled;
 	}
-- 
2.43.0

