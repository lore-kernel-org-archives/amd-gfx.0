Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19864C001DE
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jul 2023 18:34:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B53E410E4E3;
	Wed, 19 Jul 2023 18:34:48 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 039D110E4E3
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jul 2023 18:34:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V5twkNx8X1KiJ4943uPVm8t1Q+U4uOdSFMUF9LlzhsYCeaYzOqfIcvoj6L5j/dI1qn5tdOTL/E+HFnvxvRRL6HD6f78H/Ri4Jgf+ABoQd0E9+Lx8Og4OKhrk0wwYNUACRV6Zmezc0uwHZ+gfTYlKVjE+zHNjHd8u51WUXK1JWw8UEhl/Qx1NwXiEoEBvKTrFo8s2n9hrdvvX7d66AB8DK41I/moGF+N/kzVJAJEWRZhoe1yKpGdOzF5lPvx8KutBDF8R51Ott5AK9IgsfPhZqjsA2Ju/aFZ/NEhOOoaqAAluOOqeiXHmljhmVEpvBtkP+bLZ06FfY07fkbe8EoW3lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ds13MLTK1ccAAz3KISZ2FRUoSLOmNIXXA4Uc6PsyB+w=;
 b=SKG2kBUq6l/XlCVnsvAnUPvSXFuqw6gOqse0kuyqGDHYrxQvegSa8auWKzloXRvIQJb/AKoTpoU4geaN/8nqGEYJGuGpgzwz0YgeukRSONKNxncEEzLdK4Rh0mp8zYJOZeqEqnlKZIP9aaQXDhySt1gQIdoZbD1QiOZgOiv+wo5ouG28Tnyh5nMjQ6crOKlHNKcCejGfEwiT9DWIc4JYFaf1m6nhGkUiJ4TfZfpDeIFSREhBGKVPew7HZYPohphDlartuHQNjy2XLN9PB63NwmkGIULmErKfFH3S2PXR+t2vOVX2IVP7iwQ6NWzErYhE43xOROV/mDdf3yKD4s4LGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ds13MLTK1ccAAz3KISZ2FRUoSLOmNIXXA4Uc6PsyB+w=;
 b=Y5zlDPOspcih0DhszFWfhGZodB4f+QaJ0/EEfUnu35otJoHnNwJJeW0gU3D9+mT0Y/OVvuUUJ+DxaaV7WXbW3PeWEVAr0FyXNUNvR2lbxGE3fwRpvicrYns3gjZ9D5avE1uw8Bz26Suvg9YSNS+WMX/risQC9UiHMoWU3j6xaPU=
Received: from BN0PR02CA0017.namprd02.prod.outlook.com (2603:10b6:408:e4::22)
 by DM4PR12MB7672.namprd12.prod.outlook.com (2603:10b6:8:103::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Wed, 19 Jul
 2023 18:34:42 +0000
Received: from BN8NAM11FT080.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e4:cafe::cd) by BN0PR02CA0017.outlook.office365.com
 (2603:10b6:408:e4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23 via Frontend
 Transport; Wed, 19 Jul 2023 18:34:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT080.mail.protection.outlook.com (10.13.176.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.34 via Frontend Transport; Wed, 19 Jul 2023 18:34:42 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 19 Jul
 2023 13:34:39 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/16] drm/amd/display: Exit idle optimizations before attempt
 to access PHY
Date: Wed, 19 Jul 2023 12:27:58 -0600
Message-ID: <20230719183211.153690-9-alex.hung@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230719183211.153690-1-alex.hung@amd.com>
References: <20230719183211.153690-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT080:EE_|DM4PR12MB7672:EE_
X-MS-Office365-Filtering-Correlation-Id: e9df9724-40a8-4a12-e64c-08db8886d16d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zwQkyOATVDtwp5KL/F+n6wPvg4VGImuj0Enm+SbGx/6WCJeGw+wt/t69xXmXC0bm4ol3lT0ODOmOwmshHQvMeM2Rml5Krx+W47Q/BC7rzdg6yRg7GC8f17Pz2hPY6M4aW4gIopcx/RV3TlPK9UEkVvCJt83qIO44idq/4Ozi5ZrSEsEfFQuegiGf7dss0KW1QIKrGR9D1slXFPvuhkrhnS6Px+js4ksGsK2JvLR2w38LhhX/1PRhbUEX3VHvJhpQNVIzLnPIoB4OhGsrgt87vQPRorAN8gqqYGRYjvKlRZadyXgJfvX5N7/5jDlkGNW7LiKz5q/8y+OeRZK6S2TEWfCfE2T4L8Zy18LhF4YoTvr+0Q5INavXC29tX35eG7Arn4Wo6ALDDb2X3J1PI49vk6A0iwSaI3/PRt0PBz19rtFjo99UobiRDkcSVoQIaGoP8rnhFbdzhjC7qhrODEZSrRv6SMVfttfGCTaw/A5dfg5bqMklFXcGEuTPhJ50W45ubyQZiF/ixaMXFNriVCWamh5sfzA9eP3rsYxlFs3clKCLD5P2gsRBCtfXdJImxjAQi54FiwU6/yjXLHsCMYnMjVtj7fmWWbdqAkR+0LlzsjDUKOM8EROBWiPKI6BkYOoXKgGTNAzkC3yW1GO/xlHihWMEunxtG3KWlDTz1+JSUKwUz34eP/kU0xM1w+tDSAfw4K1/BHz9PzQsQRhVvymp/c8gdaRImgyEm+XjRJqSPVRs9WtfptzCsgzX+97yumSAAr9gJc9+vnLUXvrXOztiZw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(39860400002)(376002)(136003)(82310400008)(451199021)(36840700001)(40470700004)(46966006)(2906002)(478600001)(7696005)(6666004)(8936002)(8676002)(44832011)(36756003)(54906003)(41300700001)(70206006)(70586007)(316002)(6916009)(4326008)(356005)(336012)(47076005)(83380400001)(426003)(81166007)(86362001)(82740400003)(186003)(16526019)(5660300002)(40460700003)(36860700001)(1076003)(26005)(2616005)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 18:34:42.2755 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9df9724-40a8-4a12-e64c-08db8886d16d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT080.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7672
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alex
 Hung <alex.hung@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Leo Chen <sancchen@amd.com>, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Leo Chen <sancchen@amd.com>

[Why & How]
DMUB may hang when powering down pixel clocks due to no dprefclk.

It is fixed by exiting idle optimization before the attempt to access PHY.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Leo Chen <sancchen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 6c9ca43d1040..20d4d08a6a2f 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1792,10 +1792,13 @@ void dce110_enable_accelerated_mode(struct dc *dc, struct dc_state *context)
 			hws->funcs.edp_backlight_control(edp_link_with_sink, false);
 		}
 		/*resume from S3, no vbios posting, no need to power down again*/
+		clk_mgr_exit_optimized_pwr_state(dc, dc->clk_mgr);
+
 		power_down_all_hw_blocks(dc);
 		disable_vga_and_power_gate_all_controllers(dc);
 		if (edp_link_with_sink && !keep_edp_vdd_on)
 			dc->hwss.edp_power_control(edp_link_with_sink, false);
+		clk_mgr_optimize_pwr_state(dc, dc->clk_mgr);
 	}
 	bios_set_scratch_acc_mode_change(dc->ctx->dc_bios, 1);
 }
-- 
2.41.0

