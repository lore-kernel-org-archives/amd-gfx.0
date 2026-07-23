Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F70FC531F7
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2026 20:20:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9523D10F1F2;
	Thu, 23 Jul 2026 20:20:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1vqfHTDU";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010044.outbound.protection.outlook.com [52.101.85.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7366510F1F2
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2026 20:20:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pTvmvbp7vvezvY2e/JFY/T0Y6ilOmnvicdHhvKbcTVwfq8AvXR98BVXpPQmrCkS62La7BJPB2l6AQgaHTuULGrivMVtkQPzuyJwjhDY452VJ/JdDVKxE/4RAdLpklv0fw9tFbDLC8OecMYN39o0FkznJL1K1hpnIZgi1ToWpn2p3SVIjEpD1Wshh8pXL8t1HnpajYJGOxjZZspaButpMnhUHYuZu3nxyJxIHXyBdgN+c14GTIP2xy0+DMjuuQNiLJj5o+VJ3FEteYBvvhM/W/6MpxW5NGp92B+iho++l8SqLmmiQ9VLEBRsaV9kcl6rAdN5CJDZnemwT7MD5Rp3YpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xXlwez+r6zLRnCr5M6iuudr6P0Uze3Zpnqe+cDM+5WE=;
 b=PFOuWCIQI7S/5CQ2mxpIrgvcYMac9fMcy6taDMb41MKC/CWdXryTOb0OZaGIeRTE2rqF4U8xoA36mh9gRXGl5CaGBoFA5OBJrL4RP09issoljw/tdhjRAl86lPIrUUq1ZtlR/8SXWdRfe0WKB/k8PBKUSo3RPYdypYo/PKEk9z/Y72UxZgEsS+zzxoktKl4i9QfU4YajbxfmtlRHYMYF4GnUrqw4gTEyI7MY6jjA8AVyd9fhfSnLkB0YIeoa3GC2Jke2fwRG6hM7VvdmvCExiB6C7UpfdqngfBgBweAzVStEchZCAKYthPDIcFbZOmfpfbUHb5XNZnJD2PCPD6LHmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xXlwez+r6zLRnCr5M6iuudr6P0Uze3Zpnqe+cDM+5WE=;
 b=1vqfHTDUV9yK9/V5n0Mab7Q8JfIOZGcT6TvFEzeSZbr3xdWP5yPPQTRb556q225Jvul3CNLm+jztNObQzuj8Fr6Os7sWEiN73ZWx0lEWooBiSmv4ECJ4akcjJBXQUlYI2Z4WN3ydAPg6MFdWY3l5k1JlQncofabku3ZUnTcSGPg=
Received: from MN0P223CA0028.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::17)
 by MW4PR12MB6732.namprd12.prod.outlook.com (2603:10b6:303:1ea::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Thu, 23 Jul
 2026 20:20:00 +0000
Received: from BL02EPF00021F6F.namprd02.prod.outlook.com
 (2603:10b6:208:52b:cafe::59) by MN0P223CA0028.outlook.office365.com
 (2603:10b6:208:52b::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Thu,
 23 Jul 2026 20:20:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6F.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 20:20:00 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 15:19:21 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Justin Chen <Justin.Chen5@amd.com>, Charlene Liu
 <charlene.liu@amd.com>, Dillon Varone <dillon.varone@amd.com>, "Matthew
 Stewart" <matthew.stewart2@amd.com>
Subject: [PATCH 44/49] drm/amd/display: add DalForceMaxDisplayClock debug
 option to DML2
Date: Thu, 23 Jul 2026 16:13:52 -0400
Message-ID: <20260723201908.373300-45-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723201908.373300-1-jerry.zuo@amd.com>
References: <20260723201908.373300-1-jerry.zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6F:EE_|MW4PR12MB6732:EE_
X-MS-Office365-Filtering-Correlation-Id: f459e404-b62f-48d8-ab4a-08dee8f7c598
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|376014|36860700016|18002099003|22082099003|20052099010|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: DpumFPu43UKOLjmhGx29+ZbF7agss1X0enDY3/m0URvVboktKswpau+YrKEqK7qCusg4eQNY+1t+YqIVbwyblQZvVsHvW/o0UOklz/Apkj9N662w9eb49O7nNZH2UpiAPI6CRMUFcpYmbdbfzgd/J+lwjcKZx9K1I7a4/3QTMyMcym8YSvXkU4hTOEZhv1XPhHrefifksqd6cQ1mW1rBjPAWXD40RI8uHZ9gZpbg181A+dFE5lu+xWrg0T5itxV87VRW8HdpBuocLVkE8IqWMXHrS3pkzGiDBN1aBlM8272709pQWm5HTMynL7wi7PhmPSBwNqZBbFJJ/HChvFvfw6QfmSurVShDyiOfrVmVb0XuilUCHhc9Iz+eQ5hEuwxce/gvl997+sQZ2WkeU6qPEambUvO6RTtYH/Z8c+bwe+vPXmQ5tBVWuFMvTYDt23XZlxoOsZDvwetWtedLNIoth7dwyMxk3M2EdG4XFdHKCMtqb5InkzysfOoL3kT3SowmQTAZgMqSu8nybzxezt+YtfEswdO2qhSEXLa5tlwf3kzD2EFLoPmYaGAO1Si9AC71Vuw4NS9gtQH5hs1R2zAgPyu69tT75MrZrQ7LVX9cdqYry0oGKrW7UaFRTsR1hYVa1CYVplWPY0zAyyM8DBamPzQTKvv+W86r9Cx3jPI49EBNsxEWWRJlW6IO9AwcP/muNyB6RVcn02KGsp8J/SkEZg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(376014)(36860700016)(18002099003)(22082099003)(20052099010)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1kk2dywvcRsDa1xFToZzw586kEfRgHGohtEqpyVzKNPvtEIgJ18AoIGHgua6epHAX+2F5oJPIGvccu/F6/AsZiXfdWZqTG8vczk7h8r6F+GA8GLv362wOOzYde629kiHeTH5QBnNN8AXlFghnI5ankW0gES9h1/1knoSlpY5VM6mOysbT3eSFH4HcqAZqEZ1aOCADYjwIuo5ommGxcLzEBns1SfN2BkANEDJcF1nzMhnYzwVmlo+nTGZoRmdIh9gSSBsmTFpyi/KDct/nFjavD/rgEnXOEw8hgmoE8XROLJ/sXgbJBH+lywnI8PovAGmu6z+p9cCtpSrraR/Q58MRiUHI7GSbtLlcGixIe5UzT3BykZl4xQDoeDSJgMPPfBT8Kyytrihx0pNm3YSor0/JqfeHKfcgiRotPCB8sk+YLmbO9xHnGCykANxJaAtx3DY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 20:20:00.2512 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f459e404-b62f-48d8-ab4a-08dee8f7c598
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6732
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

From: Justin Chen <Justin.Chen5@amd.com>

[Why & How]
need to apply the debug option check for max displayclk.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Justin Chen <Justin.Chen5@amd.com>
Signed-off-by: Matthew Stewart <matthew.stewart2@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
---
 .../gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper_fpu.c  | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper_fpu.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper_fpu.c
index 4e3d54c92e32..aba7dd65c539 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper_fpu.c
@@ -155,6 +155,11 @@ static void dml21_calculate_rq_and_dlg_params(const struct dc *dc, struct dc_sta
 		context->bw_ctx.bw.dcn.clk.max_supported_dppclk_khz = in_ctx->v21.dml_init.soc_bb.clk_table.dppclk.clk_values_khz[0];
 	}
 
+	if (dc->config.forced_clocks || dc->debug.max_disp_clk) {
+		context->bw_ctx.bw.dcn.clk.bw_dispclk_khz = context->bw_ctx.bw.dcn.clk.max_supported_dispclk_khz;
+		context->bw_ctx.bw.dcn.clk.bw_dppclk_khz = context->bw_ctx.bw.dcn.clk.max_supported_dppclk_khz;
+	}
+
 	/* get global mall allocation */
 	if (dc->res_pool->funcs->calculate_mall_ways_from_bytes) {
 		context->bw_ctx.bw.dcn.clk.num_ways = dc->res_pool->funcs->calculate_mall_ways_from_bytes(dc, context->bw_ctx.bw.dcn.mall_subvp_size_bytes);
-- 
2.53.0

