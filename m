Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 987C7C982C9
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 17:52:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E84710E73B;
	Wed, 16 Sep 2026 17:52:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="p+Rnxe9S";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010067.outbound.protection.outlook.com
 [52.101.193.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34C0710E73B
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 17:52:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nc+MCjkVOH7ImbIH/x3Wfmj6yqcNOtzQnVDPlr+kdOvGuNvWULebmKQv+UGBShWDsdSo+mEkAhjU/qwaLfAlzFEm7DCqZMeYCr69lZABrIoVh1DiqIupYsGG1dtY9GnbuW0zkr4P9kHDBGxsy3thHtMr7XX4RZi5hIrasubsq09UVMi+YCLAwO4QGJyIMyVtDWTSKLCUvRXZqLC4aPgd9WQIjaTcurCGLi2IIcG+gu4Bp/AQ3Op7D6t369a8ekc1X+A8MOHlj3BdK5hG9qTmv83HvU4Xmo0bZKxhWU5loE7Uya7O7juTMh/oMPopA/bbeqw/1/6sdspeUPldqeh+VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4kXfUIcqYSBG4G305WjQMTlvazBgpt0LQSluc9fKDmg=;
 b=SwY13lQD81zjAL5iwYoMJQCG1ZCNvdC9Am7Xhhlp99ahBw/LM9XcEEGyAIFM0MAsgllX3LFTGtzoZgrMsAejQMJ6WOZnQI3pOd76BI0vCdUrsX8UYKgQmnQ3ti+OhgVOoSvbz7t5XXbVXzSwQbygKKR4bZPv0/Qw1unEnUabwWv1+Q5FzoYcN6pEpCBG3UrAj1jJ7441G54ZXCHI/4DYqt0zw5h4u4uDvWNc9t29CjFNlfWo+CHR8XmUt7c3KF8KLleZmTpDMlnh+ls3lTpJAJa4wk5MbBMBKTiXQZZCOr3bv2J//uYnl6om8FvRX8pbeelHIIDBOUPrtpKajGt4aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4kXfUIcqYSBG4G305WjQMTlvazBgpt0LQSluc9fKDmg=;
 b=p+Rnxe9SsFrbCN3wCkGdEoSIWB+miQLcRS9lHC9Bt9pZEn2w8r81wQg8H+SeckffCWVCEcgriJxag7PFqgLz76ipUGO/rRvwZt+PNSftX9j322+eXmn+HNMeGFq7d1kFfKcPAFXZjvAH7IJ1iv+kRwPVeTnKbEbGnD7QY/K9JeM=
Received: from CH2PR10CA0025.namprd10.prod.outlook.com (2603:10b6:610:4c::35)
 by DM6PR12MB4058.namprd12.prod.outlook.com (2603:10b6:5:21d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 17:52:23 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:4c:cafe::91) by CH2PR10CA0025.outlook.office365.com
 (2603:10b6:610:4c::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.11 via Frontend Transport; Wed,
 16 Sep 2026 17:52:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 17:52:23 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 12:52:17 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Tony Cheng <Tony.Cheng@amd.com>, Jun Lei
 <jun.lei@amd.com>, George Zhang <george.zhang@amd.com>
Subject: [PATCH 08/64] drm/amd/display: Add inst field to struct abm
Date: Wed, 16 Sep 2026 13:51:23 -0400
Message-ID: <20260916175301.368306-9-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916175301.368306-1-george.zhang@amd.com>
References: <20260916175301.368306-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|DM6PR12MB4058:EE_
X-MS-Office365-Filtering-Correlation-Id: 25beb1cb-2e8a-4bc6-6863-08df141b4318
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|82310400026|36860700016|376014|11063799006|56012099006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: f3/pwcJbHSN0G+ZGZA/3gxLT8O2c+h5nYqSbgaPi3rBj1zF7Ax9ezpOpb+Sx687uQkqqDuBwS9XbfMr4MwD3lz2gTImqEWp+4KRFxS6ZMkBLVJzPFrpKLkhGvb/7JQcRuJCfqTJPzZOP/EAuAqCCSshaaTy+FF/y8tIZLBexPQ6A1gq4ZU2DFmlmr5zxHHi/ZRJAw1WXzZ/paQi2ZQ2mCULsugO72JgkZgDhEwrVJywH/Dtl4yNDIJXhLHHewv8CPWh6A7h11jkwZvOnN4TNAd9SwJ+FzsTTHoTmBancBdOzr//nigqvwVdAo8/VlY4JqrQbLvyJcr+Muv/f1l6GtUz10Fa5nf3DwoXKhwUIFATk+QDuH7+QlgriIhOZXeRGEKz6LB+BUbT7mZO36NigcHQWyv/WryRjukzPwu8UaEcxn4cupIlT5B+WjDYL11Sm54vfXhyQ8nsGcQy7Sm2trkM7oKCtlp9yJJs4zBn0YwRWt8ZCfCpzUv4+Ir+ZZqxP0InAl7JSA/d1AzAWuwzgfxGixsnARmkskbCuQvGc3Ptaf+k45HhhruZpS3mgVCDNqZXuhEo9Y0sRrrnblTwyfXrL1LCy5aivR0kkxAMGRwYACoYGLdFGU7G714+QJhiDqeFgIV0zzJiJxDtxMuSxvSoNSL3qb/aITJYZ+Dyiakks9coArgMeUe9BlomlDpTTz9dXP+slJQH8UryQazBjgw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(82310400026)(36860700016)(376014)(11063799006)(56012099006)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OxCtxD99hGZMYmu3DH43DJhmtP5U0RNA5xRy4pXg/6J8oHbD0Q2FCdIdQ00Hz6N2DBByNKkzCrqgr392zPqI5niV7Z7y/ErbR7PqxdT6q/ZiQ4Dxsp5nav6C4Mzx/mbvbv8s3yyeT2v+1/XaY31SSOPg+tCGGoRy9G/rObrV8fxRaw3Z9J4alkuz60FuBdgyX2zKK5IS6l27TsJQulRKSBe50+efY+ugWNvA5rqy53BE8nb5QkzWf4tlxeV6ixCbOIMd6H9U3DSv13diNEoL4BCI1eDEBBc0gC5Aq31HOSV0kBcUAcUSkDl1Udbiocj8GLutFBENVnOttkyhRTjmI3GlxeZzIKbxnVzHvHCcRgMUxXnz3ywQ+lVBNaCqV0mcYDfEBmm1kz0ANDiSg12CHpxHSbiMDQTtN9vSY2WpMTEGAMTPXJaw5TfJpEeXKsM+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 17:52:23.1657 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25beb1cb-2e8a-4bc6-6863-08df141b4318
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4058
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

From: Tony Cheng <Tony.Cheng@amd.com>

Add an inst member to struct abm and set it to 0 in dce_abm_construct()
and dmub_abm_construct(), since ABM is a singleton.

No functional change; the field has no readers yet.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Tony Cheng <Tony.Cheng@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_abm.c  | 2 ++
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c | 1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/abm.h   | 1 +
 3 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c b/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c
index 469b4b8f88a3..bd9e0173ff9d 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c
@@ -220,6 +220,7 @@ static bool dce_abm_set_level(struct abm *abm, uint32_t level)
 
 static bool dce_abm_immediate_disable(struct abm *abm, uint32_t panel_inst)
 {
+
 	if (abm->dmcu_is_running == false)
 		return true;
 
@@ -272,6 +273,7 @@ static void dce_abm_construct(
 	base->ctx = ctx;
 	base->funcs = &dce_funcs;
 	base->dmcu_is_running = false;
+	base->inst = 0;
 
 	abm_dce->regs = regs;
 	abm_dce->abm_shift = abm_shift;
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
index 2df6e82b794f..8cca8599b917 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
@@ -280,6 +280,7 @@ static void dmub_abm_construct(
 	base->ctx = ctx;
 	base->funcs = &abm_funcs;
 	base->dmcu_is_running = false;
+	base->inst = 0;
 
 	abm_dce->regs = regs;
 	abm_dce->abm_shift = abm_shift;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/abm.h b/drivers/gpu/drm/amd/display/dc/inc/hw/abm.h
index 6ae7cf109565..e3fa987304da 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/abm.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/abm.h
@@ -33,6 +33,7 @@ struct abm {
 	struct dc_context *ctx;
 	const struct abm_funcs *funcs;
 	bool dmcu_is_running;
+	unsigned int inst;
 };
 
 struct abm_funcs {
-- 
2.55.0

