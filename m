Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FC78C55172
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2026 21:16:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6BF610F42D;
	Fri, 31 Jul 2026 21:16:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Vbp6GfSq";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012021.outbound.protection.outlook.com [52.101.48.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DF5D10F40E
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2026 21:16:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sUEyNgw5DVPxaMi6xhnvgQIMrwjzwGKkScOxKSYl/OidmCqfZNSSr2PEe2iJ0jJbRgoF87Rx461oDK7e4lmgWMJndGuWtN2iTOAgKvlTAoKhCDVFnQelMzAZYGCHx9x1KAPS9ZfoZENmYV7y2aupBIiU2t/GP+B/srWUg5DKzn1mhGMVxppvEooaZhVezAD9qYZTt54WPYPalUuRMdtAKUrTBF4iECDp6LilhHooTvH7IjZbHIDYjMIfB/xGC3TTIqYAQDLf0AlcDiGm+UnsaswZn1a1mBglD2sLw8QdJJommRXoXQLdYwjU7w5BCPmHw+RnbWHR5g+j7PrT62SCrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vpgnt9+n0AlzqOpFbat8AwiXAawBuJk6/EIJGoX4miQ=;
 b=t0pfE80cj2kYArA/MbvdMugoyj69wo3bbBJFleYSmH2dtYhE098d1uiXHT87VlUDJ0t8hrMEKV9Kw/Nr7V46haRn/Gjo4NX5ZBBFl21ASg5w8npsJQ46bOYflrKq8HBT0KxouEwnkGg3I193l6S+6hbdyWtn2yGZ7C1qI9rTHry7YX8UvCKayxqCAquIxsBb+eEOpS7IyfXSIdcB+6BpVChR0MJbEVk/c9jAP4J482ePUw/siqYY/WwuANiGIdFkWyTmnB0ni5iPQpXSwVmy/t5Ql4sOKZgwfDHf1XyQGjLTbanODlqysh2xIwMtVqBr8VPHilqXvl3TFHfwXKL8FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vpgnt9+n0AlzqOpFbat8AwiXAawBuJk6/EIJGoX4miQ=;
 b=Vbp6GfSqyMEAsJ/mYg5fTrKVUCb/Y+6QTFN0utQPEkOHNTL3xto2TQ5GB/4nuqoOCaN9Hk1c5qWc4WH1olthTGcVait4URPPpSTnu1ruwCE0ykyBHpp+002aHKoc2I+iCGb5XKkw3ZBI66KmdLiFKYUcQV298Cxo/6+q8zOkS6o=
Received: from CH0PR07CA0006.namprd07.prod.outlook.com (2603:10b6:610:32::11)
 by MW3PR12MB4492.namprd12.prod.outlook.com (2603:10b6:303:57::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 21:16:20 +0000
Received: from CH2PEPF0000013F.namprd02.prod.outlook.com
 (2603:10b6:610:32:cafe::80) by CH0PR07CA0006.outlook.office365.com
 (2603:10b6:610:32::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.16 via Frontend Transport; Fri,
 31 Jul 2026 21:16:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF0000013F.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Fri, 31 Jul 2026 21:16:20 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 16:16:20 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 14:16:20 -0700
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 31 Jul 2026 16:16:19 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>, Dillon Varone
 <dillon.varone@amd.com>
Subject: [PATCH 37/41] drm/amd/display: Update BW bounding box unconditionally
 for DCN6
Date: Fri, 31 Jul 2026 17:12:58 -0400
Message-ID: <20260731211302.3040343-38-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260731211302.3040343-1-Roman.Li@amd.com>
References: <20260731211302.3040343-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013F:EE_|MW3PR12MB4492:EE_
X-MS-Office365-Filtering-Correlation-Id: 631391cd-6801-471c-ebdd-08deef48f7c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|23010399003|11063799006|56012099006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: L5oUQ0vW/6Kuw2av+hfPou5pgeyTbLjRg+UQPdrQy4k3fOsOj37cBGXspz1WPiZUnKS6YpAAgsYGeoWy7kQqsGve7vSUESOq9eacSj+uigLxNBHLf3rFysoRD7YP4WUPmG2ePXu6GcuSQLorboJNF6yEOgWnulRnd58JzQqLV8bWGEz/GHPBqLtg0LOo4LRw9V3sFzlAJokzofyA+2/4iwSqDhegFbuyaJrOcFJQRs23G7f6w1pHZCyKKjZIbIy6YDMEjSXxvxwAeDXASjZ79BRoRgsaDf8+R1Opl04F+a4C27AGuFdTEl19fPu8xVa2Euvv33C7D+2cHMNjo14w8DBAHVmgn4aa6Zhrx59yp5mlmApLHrmwbTkYYVSnrY/OrqmT1CI3QQB6W6ZK5BXoEz672Y0paW8mITPnlUmI3OxuiZZDCc1wSRPmoZmMJH9HZEKgu8oVJOCKlUjE1Tx57EC4ZG9kxTgMpx+rbGwIRI/VbV89pf5rugRaJbDAGnW0yydLvEqMQuElSAotif+CM2VqJ5hXk5rU83K5R1r3aza0ccnoKAQilR/nNpykJkrRupR9iwEdtU3kYINGPkIdArUaCsjkjvsViskK9GIKIlT32I8G0ld7o731kE1sgI4e8GVVi9tuSmnG4jwk3kkYo2m0LHCq46OuXDV1KbQREhwviFcw8l8KemjBp4ujqSuqEvLQVZU//mABa20PhVJKfg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(23010399003)(11063799006)(56012099006)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DvXOjsNdKUgZ+B1dNGnlNemycqbUZiu2iL9Y35QMuBCrAp90lUYhHsMbN2Rhvp9kiVOgVHycyapVCyde+l4EHC3iLt0VKXUfofGFlYuB+MFPsabif/ugBY2NRzrxrOXITWQJRhWWbjbhikTCzrk8hqVAVVs9n4YaWZJHjSRu+1kw26rc1v4Q7uAsIIlVeYH0TEzAput5D97e5BGHmLxuyJcFx1SrrWDi9LsVRPuAk2t6qVv2rgu08FJL6KTtczhdC2LNh0Kc01q307+qTLXNC4vk1s8QrEs/fHg+ZFefPoXevOUoVdRfATSKnAX4tGzmEj+dTkGufJIUyi0e1xU2lxQ5yeYzb2ETxWIN5nENlBLOgL5oP7B44B/EURR37pCWcFO+kV9hTxSfzRQFUfh7Xtx1/b7NJ36kCSwJL/nXNXFn0ldGKXhMXFy2OJrIit46
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 21:16:20.6536 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 631391cd-6801-471c-ebdd-08deef48f7c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4492
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
DCN6 needs to update BW bounding box in hw init in order to propagate
the Alt-Ch aperture info into DML. In this case update unconditionally
on dcn6 HW init.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c
index 05239e2f086f..72c2d3ca52f6 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c
@@ -548,7 +548,6 @@ void dcn60_init_hw(struct dc *dc)
 	unsigned int edp_num;
 	uint32_t backlight = MAX_BACKLIGHT_LEVEL;
 	uint32_t user_level = MAX_BACKLIGHT_LEVEL;
-	int current_dchub_ref_freq = 0;
 
 	if (dc->clk_mgr && dc->clk_mgr->funcs && dc->clk_mgr->funcs->init_clocks) {
 		dc->clk_mgr->funcs->init_clocks(dc->clk_mgr);
@@ -589,8 +588,6 @@ void dcn60_init_hw(struct dc *dc)
 				dc->ctx->dc_bios->fw_info.pll_info.crystal_frequency,
 				&res_pool->ref_clocks.dccg_ref_clock_inKhz);
 
-			current_dchub_ref_freq = res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000;
-
 			(res_pool->hubbub->funcs->get_dchub_ref_freq)(res_pool->hubbub,
 				res_pool->ref_clocks.dccg_ref_clock_inKhz,
 				&res_pool->ref_clocks.dchub_ref_clock_inKhz);
@@ -764,9 +761,8 @@ void dcn60_init_hw(struct dc *dc)
 		dc->caps.dmub_caps.fams_ver = dc->ctx->dmub_srv->dmub->feature_caps.fw_assisted_mclk_switch_ver;
 		dc->debug.fams2_config.bits.enable &=
 			dc->caps.dmub_caps.fams_ver == dc->debug.fams_version.ver; // sw & fw fams versions must match for support
-		if ((!dc->debug.fams2_config.bits.enable && dc->res_pool->funcs->update_bw_bounding_box)
-			|| res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000 != current_dchub_ref_freq) {
-			/* update bounding box if FAMS2 disabled, or if dchub clk has changed */
+		if (dc->res_pool->funcs->update_bw_bounding_box) {
+			/* For DCN6 re-update unconditionally to propagate Alt-Ch address info into DML */
 			if (dc->clk_mgr)
 				dc->res_pool->funcs->update_bw_bounding_box(dc, dc->clk_mgr->bw_params);
 		}
-- 
2.34.1

