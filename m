Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9506C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Nov 2022 17:01:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4410310E793;
	Fri, 18 Nov 2022 17:01:30 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D94B10E791
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Nov 2022 17:01:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lWIdRtOuw7vUQvQHfb/KI7t+2M89H255zA7YQ8Il47SAM1iv6eySicVsGlMi0j8iOuJcgV3NxMXuLIyHSQaN/y7CoCFGyk9t02DkgHwcrdWxLCm48KY8tzvaZSHBzB0qZZo/7OTMtKsj7IikCJ7RY6HQ58d8G0ZxRmKpCCYtbP4Ns2aIERRW5VJ+hzsggH6MkWhUiGgKe7GX+kJ6Z/2cpDZZMGWQT9yQMWUF0HYmWheOyJt2+ErdU7oUP6W3sFvoN3kStD3DYr+RXUKcG4p9XbN7Uhkp00UTzneie6Y+pAY/DDvheARuAWtZLJTuzpZdHZr3EP1XRZZl/6noUZhBvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gTmbDG0VkVa7Q2JoeyZ3kwhAtb1No6PrEBcXM+XfH88=;
 b=F6owpGE+1FLw/hkz3PafVq5kcB2SCX43CRGVYewdXLzjYIQWH9D+NiTK+NQQAUQZQN1ApBAw0E0Cfm2VnfRslgdhX+p5k5eCXzHR/6AYCNOavu85gzRWPSW6VMweK+/+j5d9PTLIFAxi7ajIbxpFyODok18QXoKoCwLX2B5iDx6pglmmVjri3Z61E1aIVFLhpF198hF6gIC812ODp67RMcOnum5rWaTnbB2bAA9TSpSdfPTfMeqkrq1FHrUcRnftH2nExx0yWuAFczx1mPHFkE2E2RT9L6lw4wH8KH7Zj6oKYLt3aoGDkAJY+COB5uuf5Yt3ynka6YX+RCRD3XOQjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gTmbDG0VkVa7Q2JoeyZ3kwhAtb1No6PrEBcXM+XfH88=;
 b=k1/Kt45z+ZYQHYHi5Jz5r0KEbQmn/lF6fP0mAAst4oPZhQxez1NBFqD8zKph57l/wxv1ID+4JhS20uoP/fgJ5z1D8zAtPxJ90Fid7YbOdTfcteB4h8a8m0ALiFBcyTdhAxOcjJLKejKPowTI4RrXfv32KwLomGRROhZrEviZqvM=
Received: from DS7PR05CA0072.namprd05.prod.outlook.com (2603:10b6:8:57::7) by
 MW3PR12MB4426.namprd12.prod.outlook.com (2603:10b6:303:58::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.19; Fri, 18 Nov 2022 17:01:20 +0000
Received: from DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::2d) by DS7PR05CA0072.outlook.office365.com
 (2603:10b6:8:57::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.8 via Frontend
 Transport; Fri, 18 Nov 2022 17:01:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT019.mail.protection.outlook.com (10.13.172.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Fri, 18 Nov 2022 17:01:20 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 18 Nov
 2022 11:01:15 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 18 Nov
 2022 11:01:05 -0600
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP
 Server id 15.1.2375.34 via Frontend Transport; Fri, 18 Nov 2022 11:01:01
 -0600
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/22] drm/amd/display: Add debug options for increasing
 phantom lines
Date: Fri, 18 Nov 2022 20:59:28 +0800
Message-ID: <20221118125935.4013669-16-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221118125935.4013669-1-Brian.Chang@amd.com>
References: <20221118125935.4013669-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT019:EE_|MW3PR12MB4426:EE_
X-MS-Office365-Filtering-Correlation-Id: dcf1ac46-e098-4e5b-1c34-08dac9868413
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tGUJ5fLUunU4ORPbrWO9XyuBy6gNq1FbJWZ06mdTZFdM2blc33es9IX+ZNTCxYJDjnmKZHAnfQG2Hywku8OSQASV8pRUZGN7zbNWsAorF4Wxw6+5vx1u96iZPtDtg9Yv0jfmk91KuCXKyDcQPlcf3ZQU+2nf24tUAYdP+PE52IiWMJZvQfiCk0QjoJdSq4Wxy0ZNgldF6sVeEY3ha/u6mGiyEGWkaMg0Aiou+/geTG31j5FhroMflK++HkqwaPuWSQ4eZn9G1ZbJQHrp3TVxajHhbU4t2J9AXyTPlR8+hM/osBw3JR5nHXm93xsjy54e9OjxJNfnZlSk6612PAoDFPjkm2uYBbk3hi/O0fL4NLvq/7C+2LQ1VXT97m+zuOR/euy/Nj8U84Sidm8e4uy549ITpt4ZUrPjfq/HbMrLF7Ts4JvUrMATzOQFAbDX1VqdFztEOzfLmdFXnatjemMao4kcwiZM/pk1TwANr+vqbMLqYN0PHKgjxSzu2dHyFpnKPAtnI1/Kt2FfcU1f3+TRY4GJjP+n3WfGzIpkGeMm7YIrxvBqzU0yMZAHNPYjK1erQORz99ltlJECGPLuTnR0+HCcHvAUxDLNMYYVW4kG/nWTNxJiR/tCYXvdCW5EB8pTg/TCKiXS2KjjVey2EQYNA6f42+n5/UBwBGlwLMnN381w2TLtlIirbm8QdpFVA4LQd1PMO1ST8drvcrkqo1JC7ovgCRP65+P3nPApR69FJHOPojgkY2udbPQhY2oZMddOU/xYVH2jfVEu+ARsY7Z9Bg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199015)(36840700001)(40470700004)(46966006)(36860700001)(82310400005)(40460700003)(8676002)(81166007)(86362001)(70206006)(356005)(40480700001)(478600001)(6666004)(70586007)(82740400003)(5660300002)(2616005)(54906003)(26005)(6916009)(316002)(186003)(1076003)(41300700001)(47076005)(426003)(7696005)(336012)(4326008)(36756003)(2906002)(8936002)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2022 17:01:20.4210 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcf1ac46-e098-4e5b-1c34-08dac9868413
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4426
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
Cc: stylon.wang@amd.com, Brian Chang <Brian.Chang@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Nevenko Stupar <Nevenko.Stupar@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>,
 wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
- Add debug option for increasing number of phantom lines

Reviewed-by: Nevenko Stupar <Nevenko.Stupar@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                  | 1 +
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index be2a62f4df32..e827cee94e5e 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -852,6 +852,7 @@ struct dc_debug_options {
 	unsigned int force_subvp_num_ways;
 	unsigned int force_mall_ss_num_ways;
 	bool alloc_extra_way_for_cursor;
+	uint32_t subvp_extra_lines;
 	bool force_usr_allow;
 	/* uses value at boot and disables switch */
 	bool disable_dtb_ref_clk_switch;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index c881c523c37a..4222c72f5284 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -585,6 +585,9 @@ void dcn32_set_phantom_stream_timing(struct dc *dc,
 	num_dpp = vba->NoOfDPP[vba->VoltageLevel][vba->maxMpcComb][vba->pipe_plane[pipe_idx]];
 	phantom_vactive += num_dpp > 1 ? vba->meta_row_height[vba->pipe_plane[pipe_idx]] : 0;
 
+	/* dc->debug.subvp_extra_lines 0 by default*/
+	phantom_vactive += dc->debug.subvp_extra_lines;
+
 	// For backporch of phantom pipe, use vstartup of the main pipe
 	phantom_bp = get_vstartup(&context->bw_ctx.dml, pipes, pipe_cnt, pipe_idx);
 
-- 
2.25.1

