Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E5B3C83F17
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jul 2025 21:30:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4525C10E964;
	Thu, 10 Jul 2025 21:30:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SfhRxSMf";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5841D10E964
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jul 2025 21:30:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A5voUhOtNW805x6ucJVAFSGFue6z01ibO7kBMS7w/cxBAU7xwPgf7b/vAtk9YINEWJyhcVRtkJaDNrzPHWi2tfAN2cCWqktX82Meld0hdk4RJ3+09po69XyloD4O3bmfuwXWmYIg/xifxQhGrjdnuocGxqy+k38EO6sTBV2mJMfBJ9oXPe3hJ8jhTNnOTKKGtVoT6w3OSrnKwcgo2o6XI9s3XUuvNfz+W4whYHxk4w/ebvdh7bFQYCfsazwHsqkj6XcNOfE7fMCQvmDGkfp0LCaPWXaYhEDa71j/VMAQrih4q3xpf5gxXUaqmkzMt2aYBubxOzZ2fT5VHEgRaNdOlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zRG982Drzwh+jdmWN8pJi8sZpyar1Xf5hxBKhnUP2SM=;
 b=h1C16szSlwBYbw3z7D/GxYP/9JUqQx1CdchhXsEcjCOgcQto6LcfAUNCS6OM+3f2yLfpPXaDi8vJu0n4rO6vmbGoAv16y/Og0BtBQjN29i3qWM7UJrkFbe4MMaGcLZ7yc2nksC/8OTzzSRXr50h0Us89/HPuZhd/QEgykaKqz3YjYtflFOtuI7askOZcDkHKAuZxzBemUr5uWEVdKHemPEwlQiZxv2r3Wi17dWSgIz/T2zK67MHlpcF07t5fTvOwa736hLx0HL8ICbBLB2dpF1Zqc4DRjgbVI+Oihx9Yzc8pqy75jKiw02jED2rG+YH89FBGR84hYAsGVOWMEH4INg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zRG982Drzwh+jdmWN8pJi8sZpyar1Xf5hxBKhnUP2SM=;
 b=SfhRxSMfYK6h86oxKZQ0cv1fHkAqa3zzQOot24ltKBXZ/ylpIor+Q/tF4M1giLIX547lEKNBv7st+Qaio+5PkIVIUBb0NQMiuaAZyAIh5bNoar//EfRpnNbyvPCV8ItGODCpzGdUJhthzDqFE4Ka68iPKmy+LfUHC31JMcNKaDc=
Received: from CH2PR03CA0013.namprd03.prod.outlook.com (2603:10b6:610:59::23)
 by IA0PR12MB7627.namprd12.prod.outlook.com (2603:10b6:208:437::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Thu, 10 Jul
 2025 21:30:47 +0000
Received: from CH1PEPF0000AD7A.namprd04.prod.outlook.com
 (2603:10b6:610:59:cafe::d5) by CH2PR03CA0013.outlook.office365.com
 (2603:10b6:610:59::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.21 via Frontend Transport; Thu,
 10 Jul 2025 21:30:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7A.mail.protection.outlook.com (10.167.244.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 21:30:47 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Jul
 2025 16:30:37 -0500
Received: from box-0.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 10 Jul 2025 16:30:36 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Karthi Kandasamy
 <karthi.kandasamy@amd.com>, Nevenko Stupar <nevenko.stupar@amd.com>, "Ivan
 Lipski" <ivan.lipski@amd.com>
Subject: [PATCH 02/18] drm/amd/display: Make dcn401_initialize_min_clocks()
 available to other compilation units
Date: Thu, 10 Jul 2025 17:25:35 -0400
Message-ID: <20250710212941.630259-3-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250710212941.630259-1-IVAN.LIPSKI@amd.com>
References: <20250710212941.630259-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: IVAN.LIPSKI@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7A:EE_|IA0PR12MB7627:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b75ba3a-c60c-427b-1429-08ddbff908f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XoHf6suXFT4KpqYSc2ms0xM3Q5CcPyV9wPGMfY6rxNLFNHiBpM+66+uOHrGa?=
 =?us-ascii?Q?5SDYsjMwhXvaeDWlWxq9sSc7FFgDgB+ENbfnWwweHwRw5z9eNCmkmuVl9+g7?=
 =?us-ascii?Q?wNL2AAKwtE1RG6copOkHM+LYvXhYAFswcQ0mbNOC0L9GcLcYd5iUOxfGmwgr?=
 =?us-ascii?Q?+Tpl8kZKgtJN/V+1myxxEmLDK6IHuVgjXEblMjauBQ5s7sZ932ot15LIZtXZ?=
 =?us-ascii?Q?ZSgnXysuTdqRByDWXK1NeZ+c9EdgmMxHaFdZdxiJ4MHm6O18aG2eKCNlUMkX?=
 =?us-ascii?Q?qLq6Xt+nywZZ1fYCbLPbPYIK+wGVUD6Y3nORcGxnXT12gyH4CnjtJ+P4UIu4?=
 =?us-ascii?Q?lQMJ9t0Q3s1hHleL+gjWHwxM5gCEimwmUXkljYntNtLo/Mp0J8KuSNrdjwaQ?=
 =?us-ascii?Q?dM7XsQL2WtXraE2M3zGELog22wWx1TFErWR+DKmtZbWuq51jaW7ulmwe8asb?=
 =?us-ascii?Q?QbwQgtNbs9u/EP2bzxpUzn7wxFnGFqSFFKePW+L0OEqq1BNS/gqAxr+u/ryX?=
 =?us-ascii?Q?m5RLeK6Lh3oqcJ0xWYudZwT7mz11+EX6VJNzdGHrUagnh0m5xf2yW1PHRzqC?=
 =?us-ascii?Q?7TBHflvLnW+i9X04ol/n3EpkVK4U/GsD3FFZVm/eMfqknHNZwIz2rkLU57ZT?=
 =?us-ascii?Q?yxCm/p3JAjdttXjIaKutfe9qZ6/c97rCN/f5hy9xC/Ate3Ab1p+Q+LJ1hz8U?=
 =?us-ascii?Q?cAVhIOt+kqsaC5iGfF14iQ7tjf/CkcgnTM1NAm93sH0GE49OtOPJxEYTJNO3?=
 =?us-ascii?Q?w14TV0ORm9ehaNKnTDhqRR4zuwljIYWNSDb9AmFnnqV0ycte4AQY/gaigfBd?=
 =?us-ascii?Q?CLLfGUm+R8RcOOdklpiHxY/gZqtRY65dC9iJD7+lpl+DwWObL4Irm7hSbllD?=
 =?us-ascii?Q?o3RHYJ61359hTk5j/LTqnPJTw3zgKtCc9PQOrVWeVdtgaZwNDyc9Ypp15ikM?=
 =?us-ascii?Q?Z3t4f14mr87PebcThCgwN9EKc7JQHP7zmYy2XMhy4ClT2K3NOpZcfXUELzhl?=
 =?us-ascii?Q?7VdFg+0ivE1rp+sr8oVS9pcX+kIUHeRfK2N9wCVE9kmtdwW6x+laQxIDBE1D?=
 =?us-ascii?Q?0CqTg5QsLc3dqovHMP/RIDtKrbnHwcRGsac5pT0kNVIwaTanBsnGcX7rKT/i?=
 =?us-ascii?Q?anbXI3tSQXsy+xeI10BFTk7YpBlHg1/VMmrkb50ZoQLCJJvtfzuhF6cD/NIO?=
 =?us-ascii?Q?pRWlCM6bkwpODcp8CqkF/hvMfAQH2PR5uXDpkJdPvHt9J1GLCKh+I3DugTEt?=
 =?us-ascii?Q?1vkdC68L9EtHVZswPpJYyJIdmsXZ8eL4DJ4+I38tllVxR4oNGajXWguITPUF?=
 =?us-ascii?Q?WYpxsR6dqbkW30aiM1He/nUt8ufUq94t5F9Jau1v6U0+3xLQCRs+4vaf8TBq?=
 =?us-ascii?Q?P/aatW4p1gJ032C2zGbjSfrXI81Ff+O+YIdvVyaQ0FKanQP/J1iud0v+NGap?=
 =?us-ascii?Q?oTW8qwrFzd00tvoXXLOWg7DQ2ju/tKfxGG4/MJC7wZVybTxolGQ2xN4LulVI?=
 =?us-ascii?Q?bdEEzgcY9sUOq6lUznFhVRJSF1DlNFmyELbO?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 21:30:47.4200 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b75ba3a-c60c-427b-1429-08ddbff908f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7627
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

From: Karthi Kandasamy <karthi.kandasamy@amd.com>

[Why & How]
Expose dcn401_initialize_min_clocks() for future use and add additional
check for IP register.

Reviewed-by: Nevenko Stupar <nevenko.stupar@amd.com>
Signed-off-by: Karthi Kandasamy <karthi.kandasamy@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dsc/dsc.h           |  1 +
 .../drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c  | 14 ++++++++------
 .../drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h  |  1 +
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dsc.h b/drivers/gpu/drm/amd/display/dc/dsc/dsc.h
index 1ebce5426a58..b0bd1f9425b5 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dsc.h
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dsc.h
@@ -108,6 +108,7 @@ struct dsc_funcs {
 	void (*dsc_disable)(struct display_stream_compressor *dsc);
 	void (*dsc_disconnect)(struct display_stream_compressor *dsc);
 	void (*dsc_wait_disconnect_pending_clear)(struct display_stream_compressor *dsc);
+	void (*dsc_get_single_enc_caps)(struct dsc_enc_caps *dsc_enc_caps, unsigned int max_dscclk_khz);
 };
 
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index a0d61df07f22..cc9f40d97af2 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -51,7 +51,7 @@
 #define FN(reg_name, field_name) \
 	hws->shifts->field_name, hws->masks->field_name
 
-static void dcn401_initialize_min_clocks(struct dc *dc)
+void dcn401_initialize_min_clocks(struct dc *dc)
 {
 	struct dc_clocks *clocks = &dc->current_state->bw_ctx.bw.dcn.clk;
 
@@ -2632,10 +2632,12 @@ void dcn401_plane_atomic_power_down(struct dc *dc,
 
 	DC_LOGGER_INIT(dc->ctx->logger);
 
-	REG_GET(DC_IP_REQUEST_CNTL, IP_REQUEST_EN, &org_ip_request_cntl);
-	if (org_ip_request_cntl == 0)
-		REG_SET(DC_IP_REQUEST_CNTL, 0,
-			IP_REQUEST_EN, 1);
+	if (REG(DC_IP_REQUEST_CNTL)) {
+		REG_GET(DC_IP_REQUEST_CNTL, IP_REQUEST_EN, &org_ip_request_cntl);
+		if (org_ip_request_cntl == 0)
+			REG_SET(DC_IP_REQUEST_CNTL, 0,
+				IP_REQUEST_EN, 1);
+	}
 
 	if (hws->funcs.dpp_pg_control)
 		hws->funcs.dpp_pg_control(hws, dpp->inst, false);
@@ -2646,7 +2648,7 @@ void dcn401_plane_atomic_power_down(struct dc *dc,
 	hubp->funcs->hubp_reset(hubp);
 	dpp->funcs->dpp_reset(dpp);
 
-	if (org_ip_request_cntl == 0)
+	if (org_ip_request_cntl == 0 && REG(DC_IP_REQUEST_CNTL))
 		REG_SET(DC_IP_REQUEST_CNTL, 0,
 			IP_REQUEST_EN, 0);
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
index 781cf0efccc6..2621b7725267 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
@@ -109,4 +109,5 @@ void dcn401_detect_pipe_changes(
 void dcn401_plane_atomic_power_down(struct dc *dc,
 		struct dpp *dpp,
 		struct hubp *hubp);
+void dcn401_initialize_min_clocks(struct dc *dc);
 #endif /* __DC_HWSS_DCN401_H__ */
-- 
2.43.0

