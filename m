Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62823CDB483
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Oct 2023 17:44:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E844410E44B;
	Wed, 18 Oct 2023 17:44:04 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BBD110E44A
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Oct 2023 17:44:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kbbfvj/VtjTsBXj8eBeqsdt6SHnnevZaKkK7ezWIR4i/rqoh2OEpWYpTHZNOiT0Ypp1q+GFMh1CiGCLG+svM/BFtHo3Bv3EWX4asxorSKRayKnQkRuyxJidvjre/V9xQVFYUqhSyNwliEYZY2l9GLxcu2hN3eWbfgAI2qx1nWvLVGfVnoyeqsx8/p6hKHrw0787SAWC33YBc5BQvsGH5LxXov8PBsbqnXcRtrodzgDxP4vF9Dq7OPzbZ4A/mxAwQ+uCs14lVtoQM6nIHvJZQVjwQK346y/TuQxOIFM48Z9aJ3NAl45Vr9SXmvq7EV0KGvq+26lxFe1rdDl2v4dEAFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zyVOpqtWBqm3fmuLzBYsytDwOntui3cS1KPzyoJxqIs=;
 b=SpNM42+3cX/QARC9zexHry0ZxKcfXGPLhgF5ISL5jntzTwJ7iaPaM2Ml+peW9GieERVbzZk+6AtY6PL9BLbijXchusHgzmlfioHY+5F4TCf44eUcMC1yfEaXBGJ11afGP3sXyLzWu7xX1/kkTRUvROdQoRSIZiKaygGLwQ1LC81pkT21kO68wSU+I0xwMeXGbAD4mZSEoLsG68lLU2H3Ex6CGq7jP3GOi18Xu3eeW3WnJMcVX7FE3lWwJYyQrPBww16FFapLWHl5qrQqEy+bvw3bCb+jJV2Ozn9sBqjjUvhnR7VrdoLpHcH3k7XmLfirC4bJi8pVcSbjCPwcevG56A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zyVOpqtWBqm3fmuLzBYsytDwOntui3cS1KPzyoJxqIs=;
 b=Pb854XV2XVTy57ncMii22TVPmpTl/ull6nGykkdVwWHhzCM28uQHlgXbVupXP1scDwfpjP2XzsYCdFsAMqtSFieR9zZkdoau7Lw4q+V4LZlUHl0bMXlc1LF2sqvz2uq4WpHwpCOZiwd2h6rm7r2rHbblf5Ar2/nML5iAJ60xORk=
Received: from DM6PR17CA0027.namprd17.prod.outlook.com (2603:10b6:5:1b3::40)
 by LV8PR12MB9264.namprd12.prod.outlook.com (2603:10b6:408:1e8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Wed, 18 Oct
 2023 17:44:00 +0000
Received: from DS1PEPF00017092.namprd03.prod.outlook.com
 (2603:10b6:5:1b3:cafe::4c) by DM6PR17CA0027.outlook.office365.com
 (2603:10b6:5:1b3::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21 via Frontend
 Transport; Wed, 18 Oct 2023 17:44:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017092.mail.protection.outlook.com (10.167.17.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Wed, 18 Oct 2023 17:44:00 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 12:43:58 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 18 Oct 2023 12:43:37 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 26/26] drm/amd/display: add interface to query SubVP status
Date: Wed, 18 Oct 2023 13:41:33 -0400
Message-ID: <20231018174133.1613439-27-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018174133.1613439-1-Roman.Li@amd.com>
References: <20231018174133.1613439-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017092:EE_|LV8PR12MB9264:EE_
X-MS-Office365-Filtering-Correlation-Id: af087f74-df3d-448b-08ee-08dbd001cff8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NzfbGssis+LSpeznzfYSKXaxFq7qVIm6l2H+wEK+7vRxiHmXA9M0Vw6EQpIyDLl0HzAWc8RXasMW7GPRW1LoEJDxmHnFEQQXAocLTf1pCVxDkZWfcab0bQTGisx8Q1N3LMDsNkia7uox9jAbuat4VnC6h3vP+SlnOs2PYAk6YO/jIfj60AiREBdtu41DZocIR1jLRgT+8TmTxyXzU64icXppyIfk6MHizRtpOkurygW4/jHJjxglrCzb80f7faw3h+N+AFNEq6iP313xZZsyCRSwgnGOxIZndxZGEUBB4bYbObP4wgio45xTvSIz6K4rY6AqmziwzRZMo2qZiE/8SP4d9vpBJQPOMRAI07CerfrZNBDc+QalquUq9g/Iwk8w4MPwUNOVOEdaOu/7Zozsnb42OdM6/T4yqkv/eAyc48PxlV8lT7RvSMTT2xaX/ZU5ayqtkgDQ8YCb0wtl2SoxQaQRP8aSOJhawXYc6t3ppFf1suvzWeJLsISxe+NVstCNUhgeBy1lWcPyHTxZhjDnId2xNUYp2JxH106jtba7Fgs3tDFb+D6H3GHZxGQlCaE7VEALNNjL0pAWDtcfYlJpzCBFlxZvscmoAX6XOEvr5OrrbtwlsIr3MoO74y1ieP0kMfZ9ImMcKsZsB0fSnLvJCOnKbu2IIYcXDaAbk4XaS9vM7lX29llEnP3GH+OV3kZK2PTea/DkZxTJS6VC+J23w+Kosb88lpU9jnLqU9IiZMSJ26ovykVFMSVgBi+WTrcRoU3z0SnUZQCqXHD7BlRjxg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(376002)(396003)(39860400002)(230922051799003)(82310400011)(451199024)(186009)(64100799003)(1800799009)(40470700004)(46966006)(36840700001)(478600001)(8936002)(5660300002)(6666004)(7696005)(40460700003)(70586007)(54906003)(6916009)(8676002)(70206006)(41300700001)(40480700001)(4326008)(47076005)(2616005)(316002)(2906002)(1076003)(86362001)(82740400003)(26005)(2876002)(36756003)(83380400001)(426003)(36860700001)(336012)(356005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 17:44:00.4178 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af087f74-df3d-448b-08ee-08dbd001cff8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9264
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, jerry.zuo@amd.com,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, hersenxs.wu@amd.com,
 Alvin Lee <alvin.lee2@amd.com>, wayne.lin@amd.com, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com, kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[Why&How]
To enable automated testing through IGT, expose an API that is
accessible through debugfs to query current status of SubVP feature.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 4 ++++
 drivers/gpu/drm/amd/display/dc/dc.h                       | 1 +
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c     | 3 ++-
 drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c   | 3 ++-
 4 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 1259d6351c50..13a177d34376 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -3645,7 +3645,9 @@ static int capabilities_show(struct seq_file *m, void *unused)
 	struct amdgpu_device *adev = (struct amdgpu_device *)m->private;
 	struct dc *dc = adev->dm.dc;
 	bool mall_supported = dc->caps.mall_size_total;
+	bool subvp_supported = dc->caps.subvp_fw_processing_delay_us;
 	unsigned int mall_in_use = false;
+	unsigned int subvp_in_use = dc->cap_funcs.get_subvp_en(dc, dc->current_state);
 	struct hubbub *hubbub = dc->res_pool->hubbub;
 
 	if (hubbub->funcs->get_mall_en)
@@ -3653,6 +3655,8 @@ static int capabilities_show(struct seq_file *m, void *unused)
 
 	seq_printf(m, "mall supported: %s, enabled: %s\n",
 			   mall_supported ? "yes" : "no", mall_in_use ? "yes" : "no");
+	seq_printf(m, "sub-viewport supported: %s, enabled: %s\n",
+			   subvp_supported ? "yes" : "no", subvp_in_use ? "yes" : "no");
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index aa4684be1d62..e6e6377a8ce3 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -382,6 +382,7 @@ struct dc_cap_funcs {
 	bool (*get_dcc_compression_cap)(const struct dc *dc,
 			const struct dc_dcc_surface_param *input,
 			struct dc_surface_dcc_cap *output);
+	bool (*get_subvp_en)(struct dc *dc, struct dc_state *context);
 };
 
 struct link_training_settings;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index 0e1d395a9340..89b072447dba 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -1993,7 +1993,8 @@ int dcn32_populate_dml_pipes_from_context(
 }
 
 static struct dc_cap_funcs cap_funcs = {
-	.get_dcc_compression_cap = dcn20_get_dcc_compression_cap
+	.get_dcc_compression_cap = dcn20_get_dcc_compression_cap,
+	.get_subvp_en = dcn32_subvp_in_use,
 };
 
 void dcn32_calculate_wm_and_dlg(struct dc *dc, struct dc_state *context,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
index 9f6186be7cd8..be953cf8103d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -1570,7 +1570,8 @@ static void dcn321_destroy_resource_pool(struct resource_pool **pool)
 }
 
 static struct dc_cap_funcs cap_funcs = {
-	.get_dcc_compression_cap = dcn20_get_dcc_compression_cap
+	.get_dcc_compression_cap = dcn20_get_dcc_compression_cap,
+	.get_subvp_en = dcn32_subvp_in_use,
 };
 
 static void dcn321_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
-- 
2.34.1

