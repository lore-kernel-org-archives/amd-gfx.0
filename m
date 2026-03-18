Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C08D7FEDA09
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 01:01:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F48610E5F5;
	Wed, 18 Mar 2026 01:01:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jwWuEO1Z";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011032.outbound.protection.outlook.com [52.101.57.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEDEA10E5F5
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 01:01:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IvIneqqKId4wemOnb1+aggea0F6qcVZr17YkGIg8MmwHNfQK5Ot+xwkmCX5E2O81NHaSHZhSJ/ndGQXWmIHdSwucSynu5lzRdKAnevxGKQbuTZTKvLRd7XdutL7kM1wf/6M375iJ02G6ZtWTl/AWwKl1Wv8JBLr5pxXBu8dliWUwInuIIGlvx1yNz7pq1xMGnF9UelpdNiDtl+hU1d463yYAtE9A9EyrTNy1mNr8uJ4G3mImvbeYaBTnbgJLWjKZn6IzJwBdsMz7CMuqnKvU7wJ/1PRsGLExUmXn7OxMUM3EYsWSBrOiG8VIDTKR7AHI5hjSDUsgEIQQvbJJa9Z/4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jQjNfuIS/+qeP55goqlyy1JP+qVk9A8N0RdQTGL8wgo=;
 b=NugQ2IQFRI5jVXvwWu+2EE9WRx1ype7VUFe/NIHql7JT9L5XHfDuMBnQ39r+VWXN5Yiolm1cb9xxR4xjj17yHo4OcM3cuZjnroV9g6qBkTnQNI9Gjt4ZdG6Hoq/BOfl2k9x3E1NDawkTLDfA8HjV6WU2DfJkX4+/0d1mMb/qHkggi3zMd0vrNiShn56sHdcp/lpXMQMQIAaqo6+oJdDGpN3bNutx4m1nSQdIHyMfWT6emKxiUqmnMH/cE5WaT4JRQAY6neDsWmkQgl6v2dsbvQPad33ibKv37lGhJkBUviFxA++sz5CHuRyw+48C0fA+JmhemCi0nFqvWBGVnbA9Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQjNfuIS/+qeP55goqlyy1JP+qVk9A8N0RdQTGL8wgo=;
 b=jwWuEO1ZCkh/7hSsXkPKYF9nUaJ9uga9VXrQcDV/s9mx1ztkx79PM8PBMO8HdUA/ipR80PBCJQo/6L/Zuq+HdJ0hXzu+GOSG5Ml4iOAW1Dv6kmmPYav6ex/seWAI8GSdbVHZeEt0o+EU9EZ0wJ/QXEnq3Ng7XHwfIhDfQMV/V+U=
Received: from SN6PR2101CA0025.namprd21.prod.outlook.com
 (2603:10b6:805:106::35) by MN2PR12MB4440.namprd12.prod.outlook.com
 (2603:10b6:208:26e::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 01:01:34 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:805:106:cafe::94) by SN6PR2101CA0025.outlook.office365.com
 (2603:10b6:805:106::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.8 via Frontend Transport; Wed,
 18 Mar 2026 01:01:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Wed, 18 Mar 2026 01:01:34 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 20:01:30 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, "Leo
 Chen" <leo.chen@amd.com>, Chuanyu Tseng <Chuanyu.Tseng@amd.com>
Subject: [PATCH 09/31] drm/amd/display: Split arbiter programming for DCN42
Date: Wed, 18 Mar 2026 08:59:18 +0800
Message-ID: <20260318010224.513094-10-ChuanYu.Tseng@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|MN2PR12MB4440:EE_
X-MS-Office365-Filtering-Correlation-Id: f7ead99a-5f30-4ba4-6c5b-08de8489e652
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 2V6P7/Gj+5ocSq2TcU0XWhKEr8THSH7dn6clct/9HabNNENzRnimoq45dRMkMpDF7xKhEoAFex5WWXBCEa/620u/OCNkiKEGUg3WVDrchpwTifnDnAzzzdVIaGXhm/DuXTb8tP8ySsEBOmvJh5OHAjstDlAheEz83j17cUdlUB1AIL9qOxhZbm9zD3sBrvqsJ6N8LMeEtvMhPNiZ16gcOpLsUU8IRwwEDUjyl/ycRO0FPwSwKOO/UoQd2j4vft4dxWczuSUuzYilYxJwyO0101QXHR9IxCZEpoM0/rWoXJN5On1ZB48sJQnDb5LFQlkIiL/gkQXBmq7v2gHsEel1TyzF1pfk5Zab+NWjluoTJp37IUwmvnjQ1lnR29phFSr8Wzz3KvVXasE5QVQMu/noQD5JWnhlvr5PuEqgAsR5cyYDwRay+MuYqrYvTHtIQCQR/iUUzlFfjLX9i51Sfo9hUksf869YcCVi6pmHD5RhXbecuJf0rRVwpGfLC3nAa9fCs0eE6BUASjo6LQHmgj4RiNMIQ6fo4GvLs4haTnMbTCafOE+Y0Wh7zbaCQgwUzI6P0WYZq5B9dPrzHTwdP0Raj6BMCXXoUBn52eppnfXLZ3Lx7zEP9cwhcEqKhi0+n4zbOT8u7LxtXLzEjOi5uGj07wB5c2DW9CKtDrCl2yKVlaOQMsy+JMAO9fUC2pqpPAubKEBIW/7COt1X2Iftj6LGCmjDdnA/UUsMkQlOggrKCQPHVOhdKH+9GyZ2kSoz4ZguJTzCHeEy/Ea2ggQLWDVAkg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kwBmoBLLOUI4tnXKaZVfe6aXZOIQ/bnosTEGVh0ArXISFtuTgITQ58DcMADRzBHhfRRMQrI1FfyiB+dJSTrDfViJDLlrGTuqwIVjVNzRQrJD3O2uDIlz8CkcqReFhWMM6nqHmbOFeNy8MRyMOhZPKbrNE6LLRJCXJBHkuj/W7iwuwqvB4nGdLfQlrM1W+2RnhOMR4RXLTl81Qu5rxhsMpJbSZktEfXoPr0jcQJo1heUjDqnZrpAWgo6lBoRUTE6niJ6MDftd553emDAegyGripF5HwZpaKQEVXd8eRziFc+CCZ8X+PIRvbr5U9SKZd75a7NeWppBp4/GNp3ACfz9J18CfqmKA5c3buYKASCpLm/yRL87VAUIFrLltWD2Bfg3RuhbuCOzPW4LLcOqbYg8bgyxoEW8IYSYzGoyEhrQs9c2nhLZ08JPtWFhpGAEYRcK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 01:01:34.2083 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7ead99a-5f30-4ba4-6c5b-08de8489e652
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4440
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

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
We don't want to update the timeout threshold for stall recovery in
firmware dynamically for DCN42 as we're not using FAMS.

Firmware should own programming of this register since the recovery
can be broken if driver updates the value to 0.

[How]
Split program_arbiter for dcn42 and skip the part that updates the
timeout threshold.

Reviewed-by: Leo Chen <leo.chen@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
Signed-off-by: Chuanyu Tseng <Chuanyu.Tseng@amd.com>
---
 .../display/dc/hubbub/dcn42/dcn42_hubbub.c    | 34 ++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn42/dcn42_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn42/dcn42_hubbub.c
index 9e4d526b6d52..8582dcab1f22 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn42/dcn42_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn42/dcn42_hubbub.c
@@ -503,6 +503,38 @@ static void hubbub42_set_request_limit(struct hubbub *hubbub, int memory_channel
 	REG_UPDATE(SDPIF_REQUEST_RATE_LIMIT, SDPIF_REQUEST_RATE_LIMIT, request_limit);
 }
 
+static bool dcn42_program_arbiter(struct hubbub *hubbub, struct dml2_display_arb_regs *arb_regs,
+				  bool safe_to_lower)
+{
+	struct dcn20_hubbub *hubbub2 = TO_DCN20_HUBBUB(hubbub);
+
+	bool wm_pending = false;
+	uint32_t temp;
+
+	/* request backpressure and outstanding return threshold (unused)*/
+	//REG_UPDATE(DCHUBBUB_TIMEOUT_DETECTION_CTRL1, DCHUBBUB_TIMEOUT_REQ_STALL_THRESHOLD, arb_regs->req_stall_threshold);
+
+	/* 401 delta: do not update P-State stall threshold (handled by fw) */
+	// REG_UPDATE(DCHUBBUB_TIMEOUT_DETECTION_CTRL2, DCHUBBUB_TIMEOUT_PSTATE_STALL_THRESHOLD, arb_regs->pstate_stall_threshold);
+
+	if (safe_to_lower || arb_regs->allow_sdpif_rate_limit_when_cstate_req > hubbub2->allow_sdpif_rate_limit_when_cstate_req) {
+		hubbub2->allow_sdpif_rate_limit_when_cstate_req = arb_regs->allow_sdpif_rate_limit_when_cstate_req;
+
+		/* only update the required bits */
+		REG_GET(DCHUBBUB_CTRL_STATUS, DCHUBBUB_HW_DEBUG, &temp);
+		if (hubbub2->allow_sdpif_rate_limit_when_cstate_req) {
+			temp |= (1 << 5);
+		} else {
+			temp &= ~(1 << 5);
+		}
+		REG_UPDATE(DCHUBBUB_CTRL_STATUS, DCHUBBUB_HW_DEBUG, temp);
+	} else {
+		wm_pending = true;
+	}
+
+	return wm_pending;
+}
+
 static const struct hubbub_funcs hubbub42_funcs = {
 	.update_dchub = hubbub2_update_dchub,
 	.init_dchub_sys_ctx = hubbub31_init_dchub_sys_ctx,
@@ -526,7 +558,7 @@ static const struct hubbub_funcs hubbub42_funcs = {
 	.program_det_segments = dcn401_program_det_segments,
 	.program_compbuf_segments = dcn401_program_compbuf_segments,
 	.wait_for_det_update = dcn401_wait_for_det_update,
-	.program_arbiter = dcn401_program_arbiter,
+	.program_arbiter = dcn42_program_arbiter,
 	.hubbub_read_reg_state = hubbub3_read_reg_state
 };
 
-- 
2.43.0

