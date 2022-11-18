Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B026EC433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Nov 2022 17:02:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 288FF10E796;
	Fri, 18 Nov 2022 17:02:27 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E749310E796
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Nov 2022 17:02:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bs/azy6Kzl+hp2S3BYFNtiYHWRjgDlYD/++2ATgM6KW85IPC4sLoQM/Aq4RuO/9hbcSFuIVjzlT93WGiYAJTwHQctkZ1Sa8cmnvi6+jRImima4NFuQAXigXXqW1ddpS6WgYswQg2s32Tn4jrNv/5Zl1QTF4n0wKfsj4KJ0y9y7WFLc+7lH2qMDv+RA3BxbIQkZJDdlRgtWjlCGPZpO+P62YLq8HNIMqM3OM2IGbDfoY0lnetj5fL+C0BU/2dvVMKsnGAJf3oLUXjqLt65AzmXV//CFvwB0qOt6mvNEpcisV6AaHgVUxu6mNd6LIdmljsBtVfys7DWzp6FW7I9/b4aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iR/89LSdfUtAgjNwZZIExomjjcBgezKZT57dSGuEL2I=;
 b=dmdyflKW8lMCmXRAfhKpkrFb4GelZjKWA7gMNcEkVcYmX5RE5zm5P645CbWAlE6QNqo2PXH3n2dEL8SCJbi5H2HZ/wul0dvq8E0Nd6+AQv4ZDKsw+kYvi/RoUZH2q5d4cIyprC3hYR2onVfuj7AIN/+UUAh5DFWDzU/gc0ZLbm4/rdIuhgA98VcxYzf3PgapK8K0OGSCk4ClpHFfSMmpRkv0nnQCnsnPiovxDg+TB+/Of3ZW6kbqe/VAELS9wrSRCYqWxhgL4hO/pjEZwzWlYOUgnzaMg0SFRIsjrCBy6vfql0NY66Pn+vMa7JKYRCKF2zn4h0IafbvkWY7crXmtNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iR/89LSdfUtAgjNwZZIExomjjcBgezKZT57dSGuEL2I=;
 b=q+jtWeIl/mpOqWfBbxM9Sdbd8f/RKFIYoBjsW62Xcl6jEHVMMi2BvmvqMk00p+Z/ofeANclpDHeTWs5aiI4LhxaJxanv2IpXo4XxgPnPN1GJQJLNhtSFphVJHGRhK5e2tRvwQzwfwk4J3imWkp0X4m1W/gIQoPnjFrslVI5RTd8=
Received: from DS7PR03CA0088.namprd03.prod.outlook.com (2603:10b6:5:3bb::33)
 by CY8PR12MB8068.namprd12.prod.outlook.com (2603:10b6:930:75::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Fri, 18 Nov
 2022 17:02:20 +0000
Received: from DM6NAM11FT104.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3bb:cafe::c4) by DS7PR03CA0088.outlook.office365.com
 (2603:10b6:5:3bb::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9 via Frontend
 Transport; Fri, 18 Nov 2022 17:02:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT104.mail.protection.outlook.com (10.13.173.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Fri, 18 Nov 2022 17:01:57 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 18 Nov
 2022 11:01:52 -0600
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP
 Server id 15.1.2375.34 via Frontend Transport; Fri, 18 Nov 2022 11:01:20
 -0600
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 19/22] drm/amd/display: Use new num clk levels struct for max
 mclk index
Date: Fri, 18 Nov 2022 20:59:32 +0800
Message-ID: <20221118125935.4013669-20-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221118125935.4013669-1-Brian.Chang@amd.com>
References: <20221118125935.4013669-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT104:EE_|CY8PR12MB8068:EE_
X-MS-Office365-Filtering-Correlation-Id: 52776d7e-50bb-459b-b47a-08dac986a778
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3FOhb1UL7nDzn/7pq9MhqYz4+g1AA3HtapY4f7q3zUWjnK1Chy5OgI8aUmhqK0OGFbHj5DmrqenBvxBYM/GSN9to9Tb7Tv1+BOkdqxVPksxbd34XsofXzGOSs0mmB3uU76GqYTBxnf+t+5Tg4m/Mi44TItAa+cyuVJrPh7k0odyVwaFOKsD9LLPA5qr4Jrf/FioH5JUsdgdjbGT2ndTWHUojbhN1GyH5sa/8Tg2QKscpOVJvj7k3UAEDSJq42ZFW7Kfm9MeC/lsBL7hwRAyiYi+NGrU35CZT3amumJ0lMeFf5bwW9LqHYfNAmSG0hq19wtD8AEMOr3Q7m2iiXWt1EF6a8lmZ4G4Ov+EZ+7HZ164P3BMzg6pHrKmkXwaEfwAqqntYXeE+vs/7sDs7cxb2V0KGxYJOpadnhZSRilnzsrMebKwa07b1c3U5hWO+5YPu90B6pgDY7RzWYWOlCiQ4L9rCz+iKELaENmphrVZH7vNKjvQ8at0MZxIq5eHv+K5wM/cxleWX+kFLmLXt2otYzsNKl5j+62cUU3M1Aev9z4UYGsYHlK01TCsqUHlcwfX4xsyVjm1QAZENNW219o4lnlWcJpE8O4u7Ni1o6rFXuJHV7rKotW0iN2qzX2nUVsg6EZ+kwX7WTCmk46yhTNG9Rh80AhMbtsXJNClXi3D6H8G6rP7eIXANL0KsA6aGDlNlyduoUyhR8WlvlT76QwRtCu1Cotx6MZsvDfPAaSXkQZTvUbCXjxwpiJxKkATO/0aD7msNspa59gxllzVxIMQRUw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199015)(46966006)(40470700004)(36840700001)(82740400003)(356005)(81166007)(40480700001)(86362001)(40460700003)(36756003)(82310400005)(6916009)(426003)(316002)(186003)(336012)(54906003)(2616005)(1076003)(70586007)(47076005)(8676002)(70206006)(4326008)(26005)(478600001)(41300700001)(7696005)(6666004)(2906002)(36860700001)(8936002)(5660300002)(83380400001)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2022 17:01:57.8088 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52776d7e-50bb-459b-b47a-08dac986a778
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT104.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8068
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
Cc: stylon.wang@amd.com, Brian Chang <Brian.Chang@amd.com>,
 Dillon Varone <Dillon.Varone@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dillon Varone <Dillon.Varone@amd.com>

[WHY?]
When calculating watermark and dlg values, the max mclk level index and
associated speed are needed to find the correlated dummy latency value.
Currently the incorrect index is given due to a clock manager refactor.

[HOW?]
Use num_memclk_level from num_entries_per_clk struct for getting the correct max
mem speed.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 4222c72f5284..f8260d4d075a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -1988,7 +1988,7 @@ void dcn32_calculate_wm_and_dlg_fpu(struct dc *dc, struct dc_state *context,
 
 		if (context->bw_ctx.dml.vba.DRAMClockChangeSupport[vlevel][maxMpcComb] ==
 			dm_dram_clock_change_unsupported) {
-			int min_dram_speed_mts_offset = dc->clk_mgr->bw_params->clk_table.num_entries - 1;
+			int min_dram_speed_mts_offset = dc->clk_mgr->bw_params->clk_table.num_entries_per_clk.num_memclk_levels - 1;
 
 			min_dram_speed_mts =
 				dc->clk_mgr->bw_params->clk_table.entries[min_dram_speed_mts_offset].memclk_mhz * 16;
-- 
2.25.1

