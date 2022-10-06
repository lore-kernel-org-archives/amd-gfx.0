Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 990F7C4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Oct 2022 21:28:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 230EA10E8BA;
	Thu,  6 Oct 2022 21:28:00 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B1E110E8B6
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Oct 2022 21:27:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XAzlzazkPzaN7E51wmxa4/RsCmV3TBWQ3b0RSTDIGpwBt4EZtz/1lG9WiPBukoYKVxYp1kouaJQ30mKvKgn2IyaY4ZMMvZO9Yt7ILuvyIDLoovKDC8RjmuFNuHJy8xnl7pzAPfRJNAuBhN0GCcBJy1ptHvAXlvTn3yaVBC2q4y6YrwFD88eyOYG6F/dBAt2zZWJw5oM29wgCLERijl8kUCnpvzi5lgOa5khBciuET9pmWeOMI6rUIUls7P/iXnovMppjPcTJH2F4gqxVy/VwfWwQ2wIhTDwTWz9PI/1B4NlA7C5ryRhWdv6F5xWC+MmDyRhrunVxRkcP3W1C2RXB+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2pKYso9Ek8HBhBGJ4+cV1F5yZAge1eolEuwrxrPet+o=;
 b=lKCj9yagcjJ6Le9MHP0ct+34kBSvkb6ZME0JYJO0dRJQBUPxM3YxAgLjKFkvOxgmnuMfgwY2LahrQRohsViLqaAIaUNW8bS1ZNbA5rRtni7t4TgylMi0Pqx1qWGH8SzIsS5xBKjwwD6ffh9XkdiGm/a0Lfep94fFBtP3kP0eUrT0yGBOEOr+joGZ8M/pfqUBE/PMEJ3pT9P74oEb5ttwQT1BuXyt2afMdsoWrQRF2e2a8ZcUPXwwjl5jFgq05KI1A2y+nKAYOZGz15SIsT9dYb7MUVQmFNFe+zMhC6Ax6wQENeUaXCx5PQrk2NVjCPVZ7SyRpKSZH1ZDNpL/mAhtvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2pKYso9Ek8HBhBGJ4+cV1F5yZAge1eolEuwrxrPet+o=;
 b=Uk3LMdMwo40T2TMEeU3/V6+7cGudnEETR+4LnrRUVvALQk66XkFpIS39y94KVJputNU8ZEBk8FMhvFH7kF/wg4x14uqS/kDdL3A66TADpMXRVQCYLUkqV9/0nHPRER/UsqaTHNRYVMHczRaURVomn5Bj6S54gt5rQuVVWIlk53w=
Received: from BN9PR03CA0299.namprd03.prod.outlook.com (2603:10b6:408:f5::34)
 by CH2PR12MB4168.namprd12.prod.outlook.com (2603:10b6:610:a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Thu, 6 Oct
 2022 21:27:48 +0000
Received: from BN8NAM11FT078.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::e4) by BN9PR03CA0299.outlook.office365.com
 (2603:10b6:408:f5::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24 via Frontend
 Transport; Thu, 6 Oct 2022 21:27:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT078.mail.protection.outlook.com (10.13.176.251) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Thu, 6 Oct 2022 21:27:48 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 6 Oct
 2022 16:27:47 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/23] drm/amd/display: always allow pstate change when no
 dpps are active on dcn315
Date: Thu, 6 Oct 2022 17:26:42 -0400
Message-ID: <20221006212650.561923-16-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221006212650.561923-1-qingqing.zhuo@amd.com>
References: <20221006212650.561923-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT078:EE_|CH2PR12MB4168:EE_
X-MS-Office365-Filtering-Correlation-Id: d46d4f9a-3757-491a-aea0-08daa7e19df3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7QoG8kCDcXu/KUBbAJyGzSFdYhnC+6wJOxevwlNkMblJQXvqHwvyeBatHf+i4BjJdEtwVBvAgKgTOZ1BWdK1JKszcKf62huuFbRLmvtwMYmo1+9epsdNmuqUkpHtk5gyFbRMiIk5wLOIJMQCEp6IhXB/hT/hrvSroUX2t1YC5kBuSVHtBYZQksG4GsDnPdvnI13fwwnPIJXWLekJ4iADiiPKobAcMJM/JdYlSAI0uRZdfbpLuI1ga/+ujmf1tSo6xsPziQLftJm/HTG7XXfXC7uaGv2htCC1u+Loc70oDUwKxEAtvufar8l6Kivsd3AvPkJCicMjkBZunBIqrV8phU4jwzC0FDqk/7vYbPWgG5m4gKKsGT9RUg2c6CWdWe2IyQdK5h6ASYforXt8QF3uG5HC/z60sX8WwgB+bHt30x9SaAwDhuF5y02w5lKxbchOYBFWqmndaR27fGpTjTCK2tHVYyoVWC954+8Kfbe9qvzby2pzcfUAwzSFNgsHwDvNSmbs24O2E5VAOTlTSCainDvoLV8ZlwJGA9BBoHIHS4i5FNA++wiu7vIis2L+VnwyAnI+2MLCLb23PUNNlx8Ns68cPApT3gwYQN8r+/K+j92b5klsqGdkxVT5bjqdXkgsMC1sOFtJiha76jLuQYMwszPApUThSE7XBhnqz3Eji28ensqaBcPrOrtdlzReAIRta2L6r/+W6tfEXbVq0lZarZLbKFJPvYYXBZtmYWLNdRmSoW56Xu6QIKDubbUdazpTBWkRMZKycPOkohV6pXMa0/EmeIXY8rawPSCC5B5XV34heLdK4IuCyU5qWB2sibod
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(346002)(396003)(376002)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(86362001)(6666004)(6916009)(478600001)(316002)(54906003)(40480700001)(8676002)(26005)(82740400003)(70586007)(70206006)(41300700001)(8936002)(83380400001)(2906002)(426003)(4326008)(36860700001)(2616005)(5660300002)(1076003)(44832011)(186003)(336012)(16526019)(81166007)(356005)(82310400005)(36756003)(40460700003)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 21:27:48.4100 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d46d4f9a-3757-491a-aea0-08daa7e19df3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT078.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4168
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

[Why & How]
Prevents certain configs blocking s0i3
when streams aren't completely removed

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
index 87bfc42bdaaf..7dd0845d1bd9 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
@@ -483,7 +483,7 @@ void dcn31_calculate_wm_and_dlg_fp(
 		int pipe_cnt,
 		int vlevel)
 {
-	int i, pipe_idx;
+	int i, pipe_idx, active_dpp_count = 0;
 	double dcfclk = context->bw_ctx.dml.vba.DCFCLKState[vlevel][context->bw_ctx.dml.vba.maxMpcComb];
 
 	dc_assert_fp_enabled();
@@ -528,6 +528,9 @@ void dcn31_calculate_wm_and_dlg_fp(
 		if (!context->res_ctx.pipe_ctx[i].stream)
 			continue;
 
+		if (context->res_ctx.pipe_ctx[i].plane_state)
+			active_dpp_count++;
+
 		pipes[pipe_idx].clks_cfg.dispclk_mhz = get_dispclk_calculated(&context->bw_ctx.dml, pipes, pipe_cnt);
 		pipes[pipe_idx].clks_cfg.dppclk_mhz = get_dppclk_calculated(&context->bw_ctx.dml, pipes, pipe_cnt, pipe_idx);
 
@@ -544,9 +547,9 @@ void dcn31_calculate_wm_and_dlg_fp(
 	}
 
 	dcn20_calculate_dlg_params(dc, context, pipes, pipe_cnt, vlevel);
-	/* For 31x apu pstate change is only supported if possible in vactive */
+	/* For 31x apu pstate change is only supported if possible in vactive or if there are no active dpps */
 	context->bw_ctx.bw.dcn.clk.p_state_change_support =
-			context->bw_ctx.dml.vba.DRAMClockChangeSupport[vlevel][context->bw_ctx.dml.vba.maxMpcComb] == dm_dram_clock_change_vactive;
+			context->bw_ctx.dml.vba.DRAMClockChangeSupport[vlevel][context->bw_ctx.dml.vba.maxMpcComb] == dm_dram_clock_change_vactive || !active_dpp_count;
 }
 
 void dcn31_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
-- 
2.25.1

