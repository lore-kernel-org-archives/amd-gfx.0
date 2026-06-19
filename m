Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60421CDB46D
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2026 13:32:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAE8D10F5EB;
	Fri, 19 Jun 2026 13:32:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gL3SCCQN";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013039.outbound.protection.outlook.com
 [40.93.196.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D5F410F5EC
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2026 13:32:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KJrr0k5xDu7YjNNZVq+bEd4OuADnYrEHEBamco+k311A/TyBwPmV0HGmcQ1zH5aITZZWtBd5HBxOULZ5hBdPub75+EYY59vpN5hh2F/SuCXqrHAL4xEKW1cg/LTeHxwOtDfDGk58QkcnFKxG1/joyprCPFwZb+TRB9hAjZCZQdX9+PLux4Dw9IRqKlKHKS7woal8g+1euH35YJaHfUp1AGdR17HHVb23VutVpC2CbMTL/x/oFSUIuYrrnQzHvAgHMh9sRFjASNrxgoEr6C+XtIn56At4ArglNPXMrNsxSv2isxEXPjy87arVT8SjjYyW45LlT2KYnLiVr4SNPjBjrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rqs4LHB6htDadtNeGG7IK1YVQxwuiDXqICHrs5sP+8s=;
 b=pwliuXM96oDGb56c0DBUHYcnfASdMh0fRJArI2Edqc8UGq2oF4INa2xrV8Xad2CBJwSwfMSqM9eR7dIGl0jCmr+2l6wPsaRfJCTcwR8ROlQMwR858qB/6vHzKaUFBpEqS4j6Bk4SGoO6dCac01GaR1CHbCQwBjEXhiwsQsoh4LYUm8RxkIlJvJ/lvWAXNLyE/4l7y4HeJRI1KFw+z0CAV5PapIhaTZh+npO6Brnuh+ZSt31/qSzM2ulNUVLMsHJNnlzYepuk7j+uPMrrIpy8KtLVcVzCa5D7CvFO9vEWvzRT/fpk9wvuW6W44zwaoMbpa85zPpd8PI2RhumE9Zg4TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rqs4LHB6htDadtNeGG7IK1YVQxwuiDXqICHrs5sP+8s=;
 b=gL3SCCQNDA8MEnA9CPi77CazoBVG7M74W05oXppREFXcnWxHFGShffiEMYeb/KQfWNtUymUoY0v+GR/nZNgAuJn8Vp8huI7X40tdB3YLMoAU5sOrCEZH6Cte5tmhb/SKge0AM082uSKVb63pdTZv2yEJgzIExpdWDZCBWQ/2GP0=
Received: from BN9PR03CA0853.namprd03.prod.outlook.com (2603:10b6:408:13d::18)
 by IA1PR12MB6649.namprd12.prod.outlook.com (2603:10b6:208:3a2::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Fri, 19 Jun
 2026 13:32:33 +0000
Received: from BN2PEPF00004FBC.namprd04.prod.outlook.com
 (2603:10b6:408:13d:cafe::4c) by BN9PR03CA0853.outlook.office365.com
 (2603:10b6:408:13d::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.14 via Frontend Transport; Fri,
 19 Jun 2026 13:32:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBC.mail.protection.outlook.com (10.167.243.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Fri, 19 Jun 2026 13:32:33 +0000
Received: from georzhanmkm (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 19 Jun
 2026 08:32:30 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>, Rafal Ostrowski
 <rafal.ostrowski@amd.com>, George Zhang <george.zhang@amd.com>
Subject: [PATCH 16/24] drm/amd/display: Update LSDMA commands to explicitly
 handle DCC fields
Date: Fri, 19 Jun 2026 09:21:31 -0400
Message-ID: <20260619133154.116746-17-george.zhang@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260619133154.116746-1-george.zhang@amd.com>
References: <20260619133154.116746-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBC:EE_|IA1PR12MB6649:EE_
X-MS-Office365-Filtering-Correlation-Id: b7e89349-819b-4f10-0f40-08dece073833
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|82310400026|36860700016|22082099003|18002099003|3023799007|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 4Pesh3+qkrohgu2pJaexKh3xTzVDWV4KbxlxsS9ai9qvOLHT7qfs1Acdv1qtqIVtVQK6z8m1dbR4oFdU9ncofkvGrfjqeaQ88AseDqsRVIfZkmAMPIfT+ey+AuvaaafuMTLGRBjK4ZJ6o74+3o1glgm0qu+ach+gaUTZq1JCa+cPB918sWbFbRgjT3UIH3BJa5CNs/v4aNordAdlrQBKkIiYHi2P0q3D+VftmqxZhK/xXqv99qZskdpDAmwd7oei/CP27L2Tqviz7lpNmZe116ypDXdwayEDA3c1FwZZEYgb/NVnHNDIMlmnthyoP/xA5q4L3ZvtMnR1IQdySvjqsJy4XlruvQAYV6FgAv1gJusBo2DsjZ20D2RhZCTB/vn3Ezbw84P1BhyemO1y8ukjoYMtnutEVH2AOdXmRQpP3iAfCVizYKJ5sfIwEnDjAnsjXHW+M0cznfRJhTl6LEh8TN4SY653bGPm6s7Qsd4/mE3+54Y7a60iBXay4vQpuL/okQfz8FmNS6g11R9Cy6LmCJWOlOFYh/RC8k/cjFJn5DroxQgNLQoy0DALDdpg7/5KxVb4ecV2IQIHspS3xH0mFRo5GdrOYiJObEvdbpUaTzW3jNt4/Wbbioyk8J/eV4ZNXk9uGYxhNQj1bDhd8ZbYuwGHd8YHYH+vjEL80fYfeaeC/b+8exn696EmyCZwrfor7D1dCg0PQKPp4fQpMAqsEg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(82310400026)(36860700016)(22082099003)(18002099003)(3023799007)(6133799003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Q9/k/WRm8V6XzSs6R/kwzSJIerkL/3ru8O8+XfYgSc6mebJcXJKIrX9MVZV+QBED6JSgbWhU5Jy2XWRSrH5J5SmpaujBtIMuO5E+VWM+9QwLo86co8ZCV4Rfc3bvUR2iudOi+r9JyK+1l9xI6zfiGeIbCZzfYllt/tmHoMZAI4C8pPs8JxsLHboMbLUsyXgM6qeoT4sk7Wf/fxkD3s0eTRcO9q+pUnr/zVcRoR3TTfbS+P4yJXrYFKw80sp9GW16JJRltakKxv0bUwViRzJUOBZxoa/HOF62b29wPMYCanXvtgsDHdjPA/hos5xZU3ANMJcwgVThISI6HfmALSa7V7fYnVXrMeJXYeGo2ndzc+Jr+mvspf7DjVFRjGOktdjwber/uhX7ZGPCsKaV3wHsz3TsWBIH22FVG3q6AZxgBNAFmcEBonGZ5WB3X5TFVrTV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 13:32:33.5729 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7e89349-819b-4f10-0f40-08dece073833
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6649
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

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
- Previously linear copy commands for LSDMA assumed no DCC
- Update so that there is explicit assignment for DCC related fields
	- Caller can 0 out the fields if DCC is not used
- For linear copy command don't subtract 1 from the count - this will
  be done at a lower layer

Reviewed-by: Rafal Ostrowski <rafal.ostrowski@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c | 29 ++++++++++++-----
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h | 34 +++++++++++++++++---
 2 files changed, 51 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 66836b38d0e1..3fe30c8769d3 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -2125,9 +2125,7 @@ bool dmub_lsdma_init(struct dc_dmub_srv *dc_dmub_srv)

 bool dmub_lsdma_send_linear_copy_command(
 	struct dc_dmub_srv *dc_dmub_srv,
-	uint64_t src_addr,
-	uint64_t dst_addr,
-	uint32_t count
+	struct lsdma_linear_copy_params copy_data
 )
 {
 	struct dc_context *dc_ctx = dc_dmub_srv->ctx;
@@ -2142,11 +2140,20 @@ bool dmub_lsdma_send_linear_copy_command(
 	cmd.cmd_common.header.sub_type = DMUB_CMD__LSDMA_LINEAR_COPY;
 	wait_type                      = DM_DMUB_WAIT_TYPE_NO_WAIT;

-	lsdma_data->u.linear_copy_data.count   = count - 1; // LSDMA controller expects bytes to copy -1
-	lsdma_data->u.linear_copy_data.src_lo  = src_addr & 0xFFFFFFFF;
-	lsdma_data->u.linear_copy_data.src_hi  = (src_addr >> 32) & 0xFFFFFFFF;
-	lsdma_data->u.linear_copy_data.dst_lo  = dst_addr & 0xFFFFFFFF;
-	lsdma_data->u.linear_copy_data.dst_hi  = (dst_addr >> 32) & 0xFFFFFFFF;
+	lsdma_data->u.linear_copy_data.count   = copy_data.count;
+	lsdma_data->u.linear_copy_data.src_lo  = copy_data.src_lo;
+	lsdma_data->u.linear_copy_data.src_hi  = copy_data.src_hi;
+	lsdma_data->u.linear_copy_data.dst_lo  = copy_data.dst_lo;
+	lsdma_data->u.linear_copy_data.dst_hi  = copy_data.dst_hi;
+	lsdma_data->u.linear_copy_data.tmz     = copy_data.tmz;
+	lsdma_data->u.linear_copy_data.data_format = copy_data.data_format;
+	lsdma_data->u.linear_copy_data.num_type = copy_data.num_type;
+	lsdma_data->u.linear_copy_data.read_compress = copy_data.read_compress;
+	lsdma_data->u.linear_copy_data.write_compress = copy_data.write_compress;
+	lsdma_data->u.linear_copy_data.max_com = copy_data.max_com;
+	lsdma_data->u.linear_copy_data.max_uncom = copy_data.max_uncom;
+	lsdma_data->u.linear_copy_data.cache_policy_src = copy_data.cache_policy_src;
+	lsdma_data->u.linear_copy_data.cache_policy_dst = copy_data.cache_policy_dst;

 	result = dc_wake_and_execute_dmub_cmd(dc_ctx, &cmd, wait_type);

@@ -2191,6 +2198,12 @@ bool dmub_lsdma_send_linear_sub_window_copy_command(
 	lsdma_data->u.linear_sub_window_copy_data.rect_y           = copy_data.rect_y;
 	lsdma_data->u.linear_sub_window_copy_data.src_cache_policy = copy_data.src_cache_policy;
 	lsdma_data->u.linear_sub_window_copy_data.dst_cache_policy = copy_data.dst_cache_policy;
+	lsdma_data->u.linear_sub_window_copy_data.data_format      = copy_data.data_format;
+	lsdma_data->u.linear_sub_window_copy_data.num_type         = copy_data.num_type;
+	lsdma_data->u.linear_sub_window_copy_data.read_compress    = copy_data.read_compress;
+	lsdma_data->u.linear_sub_window_copy_data.write_compress   = copy_data.write_compress;
+	lsdma_data->u.linear_sub_window_copy_data.max_com          = copy_data.max_com;
+	lsdma_data->u.linear_sub_window_copy_data.max_uncom        = copy_data.max_uncom;

 	result = dc_wake_and_execute_dmub_cmd(dc_ctx, &cmd, wait_type);

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
index 5d399e6a8345..8bdaac0b0f98 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
@@ -203,11 +203,31 @@ void dc_dmub_srv_fams2_passthrough_flip(
 		int surface_count);

 bool dmub_lsdma_init(struct dc_dmub_srv *dc_dmub_srv);
+
+struct lsdma_linear_copy_params {
+	uint32_t src_lo;
+	uint32_t src_hi;
+
+	uint32_t dst_lo;
+	uint32_t dst_hi;
+
+	uint32_t count            : 30;
+	uint32_t read_compress    : 2;
+
+	uint32_t tmz              : 4;
+	uint32_t cache_policy_src : 3;
+	uint32_t cache_policy_dst : 3;
+	uint32_t data_format      : 6;
+	uint32_t num_type         : 3;
+	uint32_t write_compress   : 2;
+	uint32_t max_com          : 2;
+	uint32_t max_uncom        : 1;
+	uint32_t reserved0        : 8;
+};
+
 bool dmub_lsdma_send_linear_copy_command(
 	struct dc_dmub_srv *dc_dmub_srv,
-	uint64_t src_addr,
-	uint64_t dst_addr,
-	uint32_t count);
+	struct lsdma_linear_copy_params copy_data);

 struct lsdma_linear_sub_window_copy_params {
 	uint32_t src_lo;
@@ -235,7 +255,13 @@ struct lsdma_linear_sub_window_copy_params {
 	uint32_t element_size     : 3;
 	uint32_t src_cache_policy : 3;
 	uint32_t dst_cache_policy : 3;
-	uint32_t padding          : 19;
+	uint32_t data_format      : 6;
+	uint32_t num_type         : 3;
+	uint32_t read_compress    : 2;
+	uint32_t write_compress   : 2;
+	uint32_t max_com          : 2;
+	uint32_t max_uncom        : 1;
+	uint32_t reserved0        : 3;
 };

 bool dmub_lsdma_send_linear_sub_window_copy_command(
--
2.54.0

