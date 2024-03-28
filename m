Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C09ACD11DF
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Mar 2024 19:51:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D85710F775;
	Thu, 28 Mar 2024 19:51:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5oTpClIl";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D3C810F775
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Mar 2024 19:51:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ruw7F0lO1TVo5aawdHzmhVTA4AV8UB3fZYeTp8huL2XqV1WY7o8sqQbXdsmwxaOL3J9/mTyuWGP32bVHZY6hghMoxK6vL6lQ6UJL/XthcqCDUxhVmcAPM1STA8ho/8KPY5aAc5kWO5Adof+dsJ0wtx5Gtuly6qj35UKjsLnzUgjoT2IUnqESbxOxoDISdZ5HMo5AeG3H914IJoSBUnamxB4LNR+TmvWa/KgMw0t8qCWKk6/beZP8jcZ6O8ykfQeUFBRAYW9O1Sxxvra+r2bUaKyvMnxkQ61hsp89kgVq2ewJuyOa+TW41X7+895lBUDs5Nubs+LSKEnG3kNfiRB/jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wg07sNxIrv58TTDMh/CRHrrHckoomJRf4/LvHtBCyk0=;
 b=nVz0vjqGGx2GQp1npxJv+UpRjg6tXuD226QYpnYu9TogaWjbOHT1wurmw4ZZKXWSaaDJidLX6KFeW1a6CZADlpjbN4AyuVt7psMrm5h6mHF3wAqBTSD2ILbN1oUMGf47vuMjqh4HmZbt8Z0U4nNRZQrv3BtpnXw08X+lINwfW0G4iGwjJwz/R9PL5e/xvex15RFssQqgI355FTqtEg9UauvpYG/TYHmh0sW6xcsnZqunNV4s8byvl9G0IewpIs8miifzn8nvBQadfTEUqdCH4X/75ttOjn5EHbEPWplwF0PKReDdhfJGRmh5r0de6LkXgq5eygC3w47U/vP5Qr53gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wg07sNxIrv58TTDMh/CRHrrHckoomJRf4/LvHtBCyk0=;
 b=5oTpClIlyFRgCql86QcGqZBq79VRRZpI8LdxmbVDkzDCC4wSXTQhRDWKvREHPW2MmhV86egYPajQWyFsx+7i6gzIYoNSXMRCM2hgJrUavfmSeZMV6O3Hcc5pmbhCS4B9S6z5z7cw2LwQ8HTfnEmQcgROJqJr/YCWiAk9/fG0ZHY=
Received: from CH2PR11CA0026.namprd11.prod.outlook.com (2603:10b6:610:54::36)
 by DM4PR12MB7599.namprd12.prod.outlook.com (2603:10b6:8:109::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 19:51:52 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:54:cafe::e9) by CH2PR11CA0026.outlook.office365.com
 (2603:10b6:610:54::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27 via Frontend
 Transport; Thu, 28 Mar 2024 19:51:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 19:51:52 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 14:51:52 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 14:51:51 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 28 Mar 2024 14:51:51 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Daniel Wheeler <daniel.wheeler@amd.com>, <Harry.Wentland@amd.com>,
 <Sunpeng.Li@amd.com>, <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, 
 <roman.li@amd.com>, <wayne.lin@amd.com>, <solomon.chiu@amd.com>,
 <agustin.gutierrez@amd.com>, <hamza.mahfooz@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>, Samson Tam <samson.tam@amd.com>
Subject: [PATCH 18/43] drm/amd/display: Add extra logging for HUBP and OTG
Date: Thu, 28 Mar 2024 15:50:22 -0400
Message-ID: <20240328195047.2843715-19-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328195047.2843715-1-Roman.Li@amd.com>
References: <20240328195047.2843715-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|DM4PR12MB7599:EE_
X-MS-Office365-Filtering-Correlation-Id: f628e585-a74a-47a5-d235-08dc4f6083d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iAHjvoVv1rgsa/7LruTlO+0XSzYRHXJYE4uZkzU1Wra+ze43sL0vGhjwQVVuvyYIMsdX1G48UEgnq4NnWHkOi+qYN5jM9AKGL8KnsSuJzoVmfyXdm9CbGfPuLzdMvi+uoltza5WHj2DAozKCdfAViRxHm+HA35S4ubDmVy23Q+KT65kfnjkO4rt0y16uhOYWCr8P7OQXmkuEib3EpwjOk5VVH57sNouCRL8nTHIBq3zVcHYANY+wE7v+Bb2dCciaH8gQFkbke/U5IAXacpz4jPMxXBVMXj1PAzlCkdaq8vQ2r8TAurYCH3ZYbvVAiK7gadNIwOA9J4EMnzkPKdLTK6cRFKjBBxG4jDahOdChbLsIMJ5Tpg5bb4rC2wIeCQCHZLMKSH9U6BNG+QhLO7earFHpYh3irFFgYpBbXTCVlUcAKU6WSSqMybKRo45N03caeWU73NZPaKekfD7nGf2oVc5Ya3S3+RZppZx5gVQKcV1uuFdhUv82CRqYqjSSp4bhrkJKNulf9UN+txMoV5xyq2iSv9Tq8TfeSkM24xNciabX8BbTd4aQzuwGxIT500x3JJtPKoO1BiJ45q3ORqqcaxdCofWPUomLK59I6spCutbFW631pQ/PT6Gas6dMEil0hrFUweA/QmstqJ45w0r8GboUtS3R42evuq18rlV5qMmM8UI/w2HXQxvm2qVQut9YEzlWabGoMyDb+hz7H09tN+FUG59JByaRen57lzcdBvteFqGfqU3eqEwuJZnrCqcY
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 19:51:52.5866 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f628e585-a74a-47a5-d235-08dc4f6083d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7599
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

From: Alvin Lee <alvin.lee2@amd.com>

[Description]
Add extra logging for DCSURF_FLIP_CNTL, DCHUBP_CNTL,
OTG_MASTER_EN, and OTG_DOUBLE_BUFFER_CONTROL for more
debuggability for a system crash.

Reviewed-by: Samson Tam <samson.tam@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.h      | 1 +
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c      | 6 ++++++
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubp.c      | 3 +++
 drivers/gpu/drm/amd/display/dc/inc/hw/optc.h           | 2 ++
 drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c | 3 +++
 5 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.h
index 09784222cc03..69119b2fdce2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.h
@@ -692,6 +692,7 @@ struct dcn_hubp_state {
 	uint32_t primary_meta_addr_hi;
 	uint32_t uclk_pstate_force;
 	uint32_t hubp_cntl;
+	uint32_t flip_control;
 };
 
 struct dcn10_hubp {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
index 89c3bf0fe0c9..6bba020ad6fb 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
@@ -1331,6 +1331,12 @@ void hubp2_read_state(struct hubp *hubp)
 		SWATH_HEIGHT_C, &rq_regs->rq_regs_c.swath_height,
 		PTE_ROW_HEIGHT_LINEAR_C, &rq_regs->rq_regs_c.pte_row_height_linear);
 
+	if (REG(DCHUBP_CNTL))
+		s->hubp_cntl = REG_READ(DCHUBP_CNTL);
+
+	if (REG(DCSURF_FLIP_CONTROL))
+		s->flip_control = REG_READ(DCSURF_FLIP_CONTROL);
+
 }
 
 static void hubp2_validate_dml_output(struct hubp *hubp,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubp.c
index 75547ce86c09..60a64d290352 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubp.c
@@ -455,6 +455,9 @@ void hubp3_read_state(struct hubp *hubp)
 	if (REG(DCHUBP_CNTL))
 		s->hubp_cntl = REG_READ(DCHUBP_CNTL);
 
+	if (REG(DCSURF_FLIP_CONTROL))
+		s->flip_control = REG_READ(DCSURF_FLIP_CONTROL);
+
 }
 
 void hubp3_setup(
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/optc.h b/drivers/gpu/drm/amd/display/dc/inc/hw/optc.h
index 9a8bf6ec70ea..8d32e525f05a 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/optc.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/optc.h
@@ -93,6 +93,8 @@ struct dcn_otg_state {
 	uint32_t vertical_interrupt1_line;
 	uint32_t vertical_interrupt2_en;
 	uint32_t vertical_interrupt2_line;
+	uint32_t otg_master_update_lock;
+	uint32_t otg_double_buffer_control;
 };
 
 void optc1_read_otg_state(struct optc *optc1, struct dcn_otg_state *s);
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c
index 0e8f4f36c87c..f109a101d84f 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c
@@ -1383,6 +1383,9 @@ void optc1_read_otg_state(struct optc *optc1,
 
 	REG_GET(OTG_VERTICAL_INTERRUPT2_POSITION,
 			OTG_VERTICAL_INTERRUPT2_LINE_START, &s->vertical_interrupt2_line);
+
+	s->otg_master_update_lock = REG_READ(OTG_MASTER_UPDATE_LOCK);
+	s->otg_double_buffer_control = REG_READ(OTG_DOUBLE_BUFFER_CONTROL);
 }
 
 bool optc1_get_otg_active_size(struct timing_generator *optc,
-- 
2.34.1

