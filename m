Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38196ECAAD3
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 05:13:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0ECD10E557;
	Wed, 14 Sep 2022 05:13:22 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CD1210E556
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 05:13:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eNMK8k8fAoMvzPO36t+XFihegNyq3XK2ydNNDn1130uRzBGRgM8dmWwldcHoLY7okkzR3PjPmiv8idjSZq+MehGT/p7jhTu44w/Ct6kDuGwyFe+iWexPxui6xiEzXCY7F9asyk6WskeFyDtsZHkL2oyfZBxteBAoznIQNHQ60rCy+P062jo8DmhRdANRG6RFfToQDwuOS0oT7wDyz7rVDhIRG/0Gn2yH3Fp98TyR7WgWA08VriKPpIqDQL7d4f4OFnJHm/15A1KzP21HEQfq6ffHSWlJ/bnyDgJFYn3RRkE/rvq//7b6qJnFoO36FJmrEYH626Tlw0uJ1WyGfuoywQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KJ+l6K0V3ahRsZYLA89IzNFSMTauGUR7usEpPMvvFUI=;
 b=JX6eYBH9vLIQf9dwWfHFiEVQp+Oo2ciF2Bob1utbZtq5jByWTa4beGkeJhAISqU/2DGShrgdA8q22jsGd21z8AjoK77AiYPH5mAz3wPSraApVMmp64ZVbUY+CrOiikl0FXxD2L2NeKIXrWAlUIvyDyMs4bvHRXqfkJWZRGXRbvsGYb+7PxEHVQ38ZMoESB0nb9Q8cjtgcyio/HJfhlMStLay3SylwvHLEfdiMyOCf5uLboU5aLRnlcorrgdSKrR7ol5olSKVz8p3tYyXCwNgEIW8Vupd/R3l5HFLHepRswpC15LQYWep4XF1ZmfuVc3Ox9rZfhp/GYhRkGHcFhJSjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJ+l6K0V3ahRsZYLA89IzNFSMTauGUR7usEpPMvvFUI=;
 b=H6EG6OocjsnH7npH0Tw5Pcu7O+y+ek/htOnvF7IvktSaBSlggmQ1dC56QVdrWqlZEzBYq7NfKiypD9dEVnrnzPTqpF5BegcdkPphM26QkW5uIv3uThRDh81Nw5ZqZubNSW7hI8x1eIkUUSY/YM35sZZjdzkkAT2CudNotPwOBe8=
Received: from MW4PR03CA0246.namprd03.prod.outlook.com (2603:10b6:303:b4::11)
 by MN2PR12MB4128.namprd12.prod.outlook.com (2603:10b6:208:1dd::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Wed, 14 Sep
 2022 05:13:13 +0000
Received: from CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::5e) by MW4PR03CA0246.outlook.office365.com
 (2603:10b6:303:b4::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Wed, 14 Sep 2022 05:13:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT055.mail.protection.outlook.com (10.13.175.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 05:13:12 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 14 Sep
 2022 00:13:11 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:12:53 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Wed, 14 Sep 2022 00:12:47 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 08/47] drm/amd/display: fix dcn315 memory channel count and
 width read
Date: Wed, 14 Sep 2022 13:10:07 +0800
Message-ID: <20220914051046.1131186-9-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914051046.1131186-1-Wayne.Lin@amd.com>
References: <20220914051046.1131186-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT055:EE_|MN2PR12MB4128:EE_
X-MS-Office365-Filtering-Correlation-Id: e3061417-bb0b-404e-5f9d-08da960fd2cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a3L2owUZZrIGn9ClmvYUh3RgBIvklgLdXoUciceWyi5aJXDd6sFjlGVilI1KBmPpCJQDMVVWF71S9IW4fL1Kp+FRMfy6isNqGxlS3AVcuydw+jDv4I9ESPvZvsGyTjZRtmx59kdDNZ8bD6uYWYedydWrQoPxVpmS50V9MizAdPdhcK2dov97uyJgXki96BB//xYcCVbByIgdllP8dkZOlJA2urLm/wB8gEC3xH9rvNQ/dZOEoZMEq1JeITN9GDkVz3Cr9FObYWgXSppjqk0YqA3lJbLtM39S+oS9cFnu8jlhkDSg+y1uJEx6b2Vq3EhkPE9rDJOfn1DIir31zPaVu29EvV4N6XO4q+5vk4uASTXAMgUEL/jaSb8ptXMGD+eik6hj3ir3xirsJkCPbtkiONY5yIS7eY0jUbqpvLaNrXBr7/2R0o/5RIcy4N0bUo4lsAT8xjjLB3YkDHTqTcmX4LjJdoUSpf9NehHt0+aRufCfN9FrH8zhAXgKwhBa5lHzCqruujo2OgM77x1GgKGf/A26pibN5VRwed/tMbxrQkfDqzTCCcgFs2JQg962FLezYCnylKNhmmFOtX0vAVABLJ3BXpj8drqoZ7wGEQ3RnoQPC0FCtQvoMYM8OxK6RBM/Z7wRekLKdnn0LZKGfAmCCzTC9SfrxywwyfF+F/jPeaF6vYZgwu5VlASqw72tGFMYsGzC6X9w6vawDxBc+kGqOpMIpFZ5g9mgzMmShdnIc2Zeh4JRE9k68dlajVyjpvWRVz1IgS6KKXa/OlyRnKEcowgr/qM7WCHrk2LNe3ITaKcL/7g75aTexRabDsVYgD9y
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(136003)(39860400002)(346002)(376002)(451199015)(46966006)(36840700001)(40470700004)(426003)(41300700001)(478600001)(2616005)(316002)(36756003)(47076005)(82740400003)(1076003)(6916009)(81166007)(336012)(70206006)(54906003)(26005)(70586007)(82310400005)(83380400001)(40460700003)(186003)(8676002)(356005)(6666004)(2906002)(4326008)(5660300002)(36860700001)(8936002)(7696005)(40480700001)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 05:13:12.9691 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3061417-bb0b-404e-5f9d-08da960fd2cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4128
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
Cc: stylon.wang@amd.com, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

[Why & How]
Correctly set ddr5 channel width to 8 bytes

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c | 3 +--
 drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c       | 7 ++++++-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
index 14071aef5eab..dd6abfba9253 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
@@ -561,8 +561,7 @@ static void dcn315_clk_mgr_helper_populate_bw_params(
 	ASSERT(bw_params->clk_table.entries[i-1].dcfclk_mhz);
 	bw_params->vram_type = bios_info->memory_type;
 	bw_params->num_channels = bios_info->ma_channel_number;
-	if (!bw_params->num_channels)
-		bw_params->num_channels = 2;
+	bw_params->dram_channel_width_bytes = bios_info->memory_type == 0x22 ? 8 : 4;
 
 	for (i = 0; i < WM_SET_COUNT; i++) {
 		bw_params->wm_table.entries[i].wm_inst = i;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
index 43230709bd11..b6e99eefe869 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
@@ -291,6 +291,7 @@ static struct _vcs_dpi_soc_bounding_box_st dcn3_15_soc = {
 	.do_urgent_latency_adjustment = false,
 	.urgent_latency_adjustment_fabric_clock_component_us = 0,
 	.urgent_latency_adjustment_fabric_clock_reference_mhz = 0,
+	.num_chans = 4,
 };
 
 struct _vcs_dpi_ip_params_st dcn3_16_ip = {
@@ -688,7 +689,11 @@ void dcn315_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_param
 
 	dcn3_15_ip.max_num_otg = dc->res_pool->res_cap->num_timing_generator;
 	dcn3_15_ip.max_num_dpp = dc->res_pool->pipe_count;
-	dcn3_15_soc.num_chans = bw_params->num_channels;
+
+	if (bw_params->num_channels > 0)
+		dcn3_15_soc.num_chans = bw_params->num_channels;
+	if (bw_params->dram_channel_width_bytes > 0)
+		dcn3_15_soc.dram_channel_width_bytes = bw_params->dram_channel_width_bytes;
 
 	ASSERT(clk_table->num_entries);
 
-- 
2.37.3

