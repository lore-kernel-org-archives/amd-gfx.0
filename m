Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17DAFC77B6E
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Apr 2023 15:53:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB1DE10EDB7;
	Fri, 14 Apr 2023 15:53:57 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BAA110EDA9
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 15:53:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f8J3X0KusbLMZe5NPS8Y6DPKt6cbc/FSjg0Nq6+IqhssIYwTIKxFVqBmzFqFBOBrTXiqvCfF6CT5nP+emHF91HQv2Cps/AG/7G0YJxj+6xSBPGt5A6po2QCFAyw3ZiRooX72ZvPizIG7s4Aw4AYEhyakKq243QPPXAjyaOnrtAKdjI/RLBivRqVCWQIA2RbmnNj3Qr7cm45nApkcXUEy1rwkB68lCZLeitthaAze0Ulhn4f0D4qus7BgFYp5/cCDUM7m/g15w1L6IXGR6xMrIB7WT8PBYxyGG/NmdIVDo0RKmWNGfVU7YGuTM1JCxvsdjJjXH2rLthb+spjzmRTj7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b/cxnEHywtqcCbcdpX6l+xo3B7YRNAth4RgA0whJHDY=;
 b=iTnQz2px+JTOoVRsfV+VQsG8sKXgn+n7MWkqgbUBHUCjbSxcYgdgB1Y21Ub6eBpejQjxsMCJvs4ppacBhklfzABo0RB3IrVJvYS6+Gm9CG8USkftUbiMXrIM/zR/NGwInRyTtII+CFG1Go3iFtifdPoP3DmyNXiSX8tG71Q3blqKcnWAG5dTW9DGkF4ec2TuFGcIWj2hN4IQIu3RzBKT4FJ9mh2D6RyqpgClLGAhel8Pmr6Qj+FdU0QPI2UjhTkZN2rzZFx01DOsJ9HlUijc4s2vwArFo0fAK0SfHgA1jqRyI8dXcSkreKvnbZd0kZunkDeQHnOnX147nnre2hLRsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/cxnEHywtqcCbcdpX6l+xo3B7YRNAth4RgA0whJHDY=;
 b=1R/qhEyAZEFhcp9kFaUiEwVJssH0kNbGhLJQOXqG0RFc62YZjrIfuQDBreQ7CpDVH68QeuNSC67bhIm/zryUcVytiei3BMmnsuk5VTCKOPWgwQjl+DJ2rj458L9VsNSMqW2ofEHe2KvvrR/JNv3sR3TtPUCMBKBQ2KkUu21S2BE=
Received: from DS7PR05CA0049.namprd05.prod.outlook.com (2603:10b6:8:2f::27) by
 PH7PR12MB5709.namprd12.prod.outlook.com (2603:10b6:510:1e0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.34; Fri, 14 Apr
 2023 15:53:53 +0000
Received: from DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2f:cafe::60) by DS7PR05CA0049.outlook.office365.com
 (2603:10b6:8:2f::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.11 via Frontend
 Transport; Fri, 14 Apr 2023 15:53:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT024.mail.protection.outlook.com (10.13.172.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.36 via Frontend Transport; Fri, 14 Apr 2023 15:53:53 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 14 Apr
 2023 10:53:51 -0500
From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/66] drm/amd/display: Set maximum VStartup if is DCN201
Date: Fri, 14 Apr 2023 11:52:28 -0400
Message-ID: <20230414155330.5215-5-Qingqing.Zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
References: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT024:EE_|PH7PR12MB5709:EE_
X-MS-Office365-Filtering-Correlation-Id: b16f1d51-fef8-45e5-9045-08db3d007285
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z6QPDqqkI+i25cJL24Hv+rn84nvXh/RTayfrK8oxOfdtV1zzC1whAIZCAzGOQQW7zy8Hmgi2DEM0PFo63E+DexF/iv7YJhrEupcAqbZUwt+y+bF1gG+Osw+aCrAmfdhWXRMqHgMYU1hX33yQvNCSgZfHOl+65Aeh0tJbmOi0re1bWxLWgXF5TBTGzcpdvhT0UWmPdrAP9Op7pM6OGgs13wEgll3nZfjygWwSZwwr//nYwXCWb5S7jIhes3qLprx3BWQSN5bMrDXvqAK34869p8Z7cjfXWLqC+crBX4D0qWcMrVKObbDNhTX4cD/PNmq1ADQLYpKzWUi8rHLCkm0OjnEhxHHGfNoV1d2Sxf4pyJg1ChdZ+TdOVA6Fnh6kmV83ZMluCBi/vDBZwJto6aZWIwgyEGRbwnP5v25IAyPBsTvhkP0T7VK1T6KKoqntUt2rzglKelTLromOdMq5mOaNgB2AAeuC4AXY1vIL4LA5C8oI/0+TcTCTgUiWCJdpudAuzObc0wPe90Jf/JClmzNo8qH0Yc9wxj3ax/dZb5EyfmgPKcnx7JYAAp8hK5qTIn3y37ZRXyr7Yo+nzTqpI7JsUDcV1NMK0wPXLpD/wyZIRsZvrrRSp4jkbG6EFm/a4by3HpaY618lMXzY70PWDMp1mp6byBWfQa2DwdzMfcxjs7iFY8SoPHPeLSeMh6ZlQjN+6wHdexnm1Lrgy/djdMKT9DGD/jS7gtOm5LCLCpQb/5g=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(136003)(39860400002)(376002)(451199021)(46966006)(40470700004)(36840700001)(86362001)(16526019)(36756003)(40460700003)(40480700001)(186003)(426003)(26005)(1076003)(47076005)(336012)(6666004)(2906002)(2616005)(478600001)(82310400005)(316002)(70206006)(8676002)(54906003)(70586007)(41300700001)(5660300002)(8936002)(6916009)(83380400001)(4326008)(356005)(82740400003)(81166007)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 15:53:53.2926 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b16f1d51-fef8-45e5-9045-08db3d007285
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5709
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
 solomon.chiu@amd.com, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
index 6e32dc68f7bc..b79014f04cef 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
@@ -1259,6 +1259,8 @@ int dcn20_populate_dml_pipes_from_context(struct dc *dc,
 
 		pipes[pipe_cnt].clks_cfg.refclk_mhz = dc->res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000.0;
 
+		pipes[pipe_cnt].pipe.dest.use_maximum_vstartup = dc->ctx->dce_version == DCN_VERSION_2_01;
+
 		pipes[pipe_cnt].dout.dsc_enable = res_ctx->pipe_ctx[i].stream->timing.flags.DSC;
 		/* todo: rotation?*/
 		pipes[pipe_cnt].dout.dsc_slices = res_ctx->pipe_ctx[i].stream->timing.dsc_cfg.num_slices_h;
-- 
2.34.1

