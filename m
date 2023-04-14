Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94C97C77B6E
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Apr 2023 15:54:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E17FD10EDBA;
	Fri, 14 Apr 2023 15:54:07 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::614])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 104BD10EDBD
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 15:54:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mKVjbFOFbA+dMpZH4mjJmU72nFFfEOw0gsVelxDYpDwMycHSAOyA8Wk4rw70HnYq6GVTt/bQZ6U3W+mArjntHmtfTjFDEatRUlisXvGRLKUH6ve/Qhbel7Lq3kCZ17qQTKk8yiKV2qwoj+76/Twttwba5NaJeJK5cTOvdjeVbRUGQMpLv8WSz0HKKO4Gu+AGtAar8AUBrqHNgGcwJYEUIBV+HCuTxcJnnFQIF7b0sq3ZNadiz/7qegtaQWW00pmm/HhaxdA3FNV7fiVEftZ3OiDqjCzMaxNHZjnAk2F/kI4YGy4R10FnSYLtq11FHfC2n/gLjVMf30Hq9NTF4AhhEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sqe8odypAiYYSYIq/c2t6xmPhhmcxChZvm7kgQ6QuOw=;
 b=E8PU5ZHLteWhriMnQna5UARHbLWl4CHynRuE4eIia3EABuHOU4FZBl47JVyzM6tuo2QWICplMJR6ylDTPVTHjZmfVJykP3kyI2PerGqMK8F0s3ZB6HKXK+odVgnHjm/0Vt0SjVF9s9RVncnzfkme55oDO5Rbb9rgMpCTmod+BSTXkMVmdewVO1Qdc3aM0BjGE21HGCLekNyU0kbFbfIczJguDZU/Z8y6kEzR4Bk4uWh+spmGBMPL7oICk/bUNmDIflQhrFs6hdQwCnGvZx+oabAU8hFmlD88Z98yQU2fecZy3+ZnCMg7LY3a9wZgefMoYDyMT/5Ilyef01DmzDtNpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sqe8odypAiYYSYIq/c2t6xmPhhmcxChZvm7kgQ6QuOw=;
 b=pCds5ZxualxTYlOnk4a7tUcv/KbEWcCohIa69nhfVP/eHLr5cfrBSsI3TjqoLC4Qead/0yZiIq6pFqireN0cw7trVyyb0wzlrsQpNs8enqhtkIgmBT/DI/eOJB/m444c5vRtLefGJSa2CGQlwmdMHBN9/J8L0/RUE9Fsv6ACSbM=
Received: from DM6PR18CA0016.namprd18.prod.outlook.com (2603:10b6:5:15b::29)
 by CY8PR12MB8266.namprd12.prod.outlook.com (2603:10b6:930:79::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 15:54:02 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::ec) by DM6PR18CA0016.outlook.office365.com
 (2603:10b6:5:15b::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.36 via Frontend
 Transport; Fri, 14 Apr 2023 15:54:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.37 via Frontend Transport; Fri, 14 Apr 2023 15:54:02 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 14 Apr
 2023 10:54:00 -0500
From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/66] drm/amd/display: Do not set drr on pipe commit
Date: Fri, 14 Apr 2023 11:52:34 -0400
Message-ID: <20230414155330.5215-11-Qingqing.Zhuo@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT029:EE_|CY8PR12MB8266:EE_
X-MS-Office365-Filtering-Correlation-Id: 34b4440b-04fa-433c-776f-08db3d0077c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1fxcaAEBL4XFjFIM+EaJKPcXTVnYxGQyjlJYUU26ZQhyl9k5owRp0YXvFYK0XdVDd4AzbEtmpStixk0P92vca8XZTidWOIVM2+jz8U8FQTfC/3jcHo8EhdAIun2sxMldVuYdyVHTn+gAt8C+oX5BoLlexHp+ubs5IGFIb7SU36NgF92m6bKqGpYcyKWRuhqQzvgiX0uZd/C9+RpFxURMmVb8euL3eKnWLIl2Gww7sm4oPF0wBMQAwjYJJmF+y8XhcHb0bxHA9qtaocRwVIdV+wQMX9rC8z49/iBm1vICSbTS93TuScj1yZy2V9h//rK68suhbvKL8Ravvvor32VaSd4cU+SbNaPqN6U8t4EfvaMC0lew8/+9LWW6G2+3Ub7f20Bj3Aa7PctBCiBc/TrYx+NWA4ekdlgLf47C86BDBgh/BB4LTRuRnGJXh/Fw4pEt1U/LBkDv6Pm5KB8H61DVt8posVxPWuNF9HefUCYiV7v/OWKO+P2oP3JYyFI0MK51vujFE3MCsSwdfCqEmcB+YvJ4pCVNSCxJldkkwj71/k+PXZh+ZZ8qKxVV0fydsDku7ZpK+TxritQRRKt2UwfKJajybeLRR9vylS9xigZ0FrSKtMfbtzj6C8k9ohsAAkuV0Ju64lh3ksrNxhkA1TKQpLsmFU80AXl5ITn/A+sKIvJXDlrHJEmmgIG9OmYa1pWu+gc6ov2XRoYEqwSk6jmUUftjGzJRv+iy5uneIl1Old8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199021)(46966006)(36840700001)(40470700004)(26005)(336012)(426003)(1076003)(54906003)(40480700001)(186003)(47076005)(83380400001)(2616005)(16526019)(36860700001)(40460700003)(6666004)(5660300002)(41300700001)(316002)(8936002)(82740400003)(82310400005)(8676002)(356005)(86362001)(81166007)(478600001)(70586007)(36756003)(4326008)(70206006)(6916009)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 15:54:02.0934 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34b4440b-04fa-433c-776f-08db3d0077c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8266
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
Cc: stylon.wang@amd.com, Wesley Chalmers <Wesley.Chalmers@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wesley Chalmers <Wesley.Chalmers@amd.com>

[WHY]
Writing to DRR registers such as OTG_V_TOTAL_MIN on the same frame as a
pipe commit can cause underflow.

[HOW]
Move DMUB p-state delegate into optimze_bandwidth; enabling FAMS sets
optimized_required.

This change expects that Freesync requests are blocked when
optimized_required is true.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c | 6 ++++++
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c | 7 +++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 5403e9399a46..6ce10fd4bb1a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -2113,6 +2113,12 @@ void dcn20_optimize_bandwidth(
 	if (hubbub->funcs->program_compbuf_size)
 		hubbub->funcs->program_compbuf_size(hubbub, context->bw_ctx.bw.dcn.compbuf_size_kb, true);
 
+	if (context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching) {
+		dc_dmub_srv_p_state_delegate(dc,
+			true, context);
+		context->bw_ctx.bw.dcn.clk.p_state_change_support = true;
+	}
+
 	dc->clk_mgr->funcs->update_clocks(
 			dc->clk_mgr,
 			context,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index 0e071fbc9154..0411867654dd 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -985,11 +985,18 @@ void dcn30_set_disp_pattern_generator(const struct dc *dc,
 void dcn30_prepare_bandwidth(struct dc *dc,
  	struct dc_state *context)
 {
+	if (context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching) {
+		dc->optimized_required = true;
+		context->bw_ctx.bw.dcn.clk.p_state_change_support = false;
+	}
+
 	if (dc->clk_mgr->dc_mode_softmax_enabled)
 		if (dc->clk_mgr->clks.dramclk_khz <= dc->clk_mgr->bw_params->dc_mode_softmax_memclk * 1000 &&
 				context->bw_ctx.bw.dcn.clk.dramclk_khz > dc->clk_mgr->bw_params->dc_mode_softmax_memclk * 1000)
 			dc->clk_mgr->funcs->set_max_memclk(dc->clk_mgr, dc->clk_mgr->bw_params->clk_table.entries[dc->clk_mgr->bw_params->clk_table.num_entries - 1].memclk_mhz);
 
 	dcn20_prepare_bandwidth(dc, context);
+
+	dc_dmub_srv_p_state_delegate(dc, false, context);
 }
 
-- 
2.34.1

