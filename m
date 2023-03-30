Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90A8AC6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 08:58:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFF2E10ED5D;
	Thu, 30 Mar 2023 08:58:50 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59A7F10ED4E
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 08:58:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bstVR3GjKUSVpFQ92OoxqXm5ewC8qOtrs2h2mQClaUMaDG+gX9Gia4peKj4fT43ywHGf92ph8Dy7Lr87mzZ3x2fU8nBvk2UnvScwjYydN5Mj3E9J7OTFH884FszsWkGWw0+ZPxlF7DR0NrtNOOUzEyV3oMZhUV2KTdvWGAaMF7HGUpXbCpx8sN/jW3pAYUhC8Qo2MH7NH8OCydeA+z8iRD3PIFG5X7S96RjZl8nCKHjHMLGMH/LHAnIi/wo8tx5NSUrHz9hX6rXaC9+gOcRNZ6DqbK50mbPTBhvkTJ6jLQNa37xialbfMdDG7LvuZ3lGZHJHFhZ+D8YQTgVgzgfDxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IPHajTDa/tNpq+OdX+3uJk2512zqKiJCNpkQur7clJ0=;
 b=PBWvXhFHA0YM9iNJ9wB0Noa7U+o6RVq+ylfyylyNiMWdT8FocTaXpnRZ1aRJsmXGtXtjTG4646ncB5hGirFTmFeyPmqkwY+982phylE41FYyphtLkL24KqweJHuecHfIHjnXM5XQMWlP/flrcG41ijkpY0p0pkNvZ/k7uj/EbFqqwA2L7JZK7YOgflAaKY/23BBZHGylFcxwTbBzpw2jpfxegKqBgpIvNVnDXZ+IXpZs5VPToNWPzuWDXvf/hIgw3fAMBYelaz5Z4RPN5DOwK7OlIKltC0cGRFNAXgvEV9KGbxj9CRKfZpxP4T//ZUNO9/ZQnT23fra6kQJLsNUjJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPHajTDa/tNpq+OdX+3uJk2512zqKiJCNpkQur7clJ0=;
 b=b8WgDeWkEbUgeA8IgFBgqdD3Af+7pn1t6VgTNt3zq1P/93WkujXD+rjvAUgplAqkhY3k+NsbqveQeNxfMIyQ7Owcy1eKkXtAHjZJzGYazQGMtOZeNs+2T//VavashZIOKgx2iGqrpQH40saYf3c2UaWCIlsX8MQ4zCNoKrrQlm4=
Received: from MW4PR04CA0357.namprd04.prod.outlook.com (2603:10b6:303:8a::32)
 by SN7PR12MB7417.namprd12.prod.outlook.com (2603:10b6:806:2a4::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.32; Thu, 30 Mar
 2023 08:58:47 +0000
Received: from CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::d9) by MW4PR04CA0357.outlook.office365.com
 (2603:10b6:303:8a::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Thu, 30 Mar 2023 08:58:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT033.mail.protection.outlook.com (10.13.174.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.22 via Frontend Transport; Thu, 30 Mar 2023 08:58:46 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 03:58:11 -0500
From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/10] drm/amd/display: Clear FAMS flag if FAMS doesn't reduce
 vlevel
Date: Thu, 30 Mar 2023 04:57:11 -0400
Message-ID: <20230330085720.3863-2-Qingqing.Zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230330085720.3863-1-Qingqing.Zhuo@amd.com>
References: <20230330085720.3863-1-Qingqing.Zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT033:EE_|SN7PR12MB7417:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fc94365-6e0a-4a13-92bc-08db30fcf8d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AZZpTmpcM1fm0V9C9O/DU2OddScsJkyhGN4ARCWhlPcpl4ChP3sCSxLofhoxn6N4OJRydT9A6X9FYjwwQtNlLdZarOpVE99kCHGeXODKyGm6OK6W3pR+WYlvN2aRL+vYc4sh3cb8vnlCvRk0/LbjiGfHtaf2V8VDruwf9GHbhx0Qg7evsz3rRFlDUSj3DGZjYC2kfHc/xS82LwcOdZxGz0Chy68q0d7YPUIXPHngBhiVHb2ai3/9RtF9hiApc7WpWYgOubaaoQ7vj8FIqy+gH+bIxu4NhyOmyx8+3/7F0SwK1aMQBFy8DBWSwmV6fvQGwM1XIZM05L1ddgcBgBY7+4dnZskcFe0HDhvBgKFJc0ppAETStGyh9oD9WOXruHDeK+7/m7KSZ9F7Rt9bLJKyOx86EL2BSrFmEzgFFSFMbik/3Fvqu3hM+4DQhtUTkBkLJ1xqV1HOEn+SX+rGOATJmRmnxERK0SXG+d+tXypMpdZaxOT4MZ8/crszKuSRvse+LAUToxZTVMhmZfP8LxXKViKDgsWtfssEihmP+0ZoOqjWy1k3D1nj7rhFB2OMd1lodbdNa40asGq9dV1HXNEDaqs+m0SPYO7j+cWfWxPd4lR1bUb4UsyYvTMcuNIF+X/hAIzXAHmjqWD8kjfscAJUOcynCr0QJwRnhLg/Otn0qyKNO0LE7KRbsK4DRTl9CXpxRxJV6AwQEECMpeWwaQl34nxSfcgEouIw87ZuE1mSyEw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(376002)(346002)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(36756003)(86362001)(2906002)(82310400005)(40480700001)(478600001)(83380400001)(47076005)(426003)(40460700003)(2616005)(316002)(70206006)(81166007)(4326008)(336012)(6916009)(8676002)(186003)(70586007)(26005)(8936002)(82740400003)(54906003)(16526019)(1076003)(36860700001)(41300700001)(356005)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 08:58:46.6551 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fc94365-6e0a-4a13-92bc-08db30fcf8d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7417
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
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>,
 wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
- If we find that applying FAMS doesn't reduce the voltage level,
  we will not use it
- Ensure to clear the stream flags indicating FAMS if we hit this
  case

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 1e26adf987cc..c252fdf2c0e8 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -2002,6 +2002,10 @@ void dcn32_calculate_wm_and_dlg_fpu(struct dc *dc, struct dc_state *context,
 				 * voltage level)
 				 */
 				context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching = false;
+				for (i = 0; i < context->stream_count; i++) {
+					if (context->streams[i])
+						context->streams[i]->fpo_in_use = false;
+				}
 				context->bw_ctx.dml.soc.fclk_change_latency_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].dml_input.fclk_change_latency_us;
 				dcn32_internal_validate_bw(dc, context, pipes, &pipe_cnt, &vlevel, false);
 			}
-- 
2.34.1

