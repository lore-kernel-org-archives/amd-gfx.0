Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE1ABC0015E
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Aug 2023 15:07:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32E1810E455;
	Wed,  9 Aug 2023 15:07:20 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EC0110E456
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Aug 2023 15:07:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ALX4aV8NnUViqXi5dbN2e31epjwXnoyp+ZQYf2jB50NB5vHMnG13LuYO5BlkdaneXuQVPevHI+pmvV9cdhngycoVcSlrBzTtHsOZggt9CPR+GeMJ3fN1fzQpCqSNbp3bVYkf+vi6VvSoA+q1SVxiWIaUL4jQyDlRvT+iQ32Rl6Cqkv1YsvZC9LEkczC+DJitCrYhz4yzLXlcAthJ0QwlaWlJgsN1ow9S+j0enx58UkJ/2JcbKr3vTMuPu+Wr7k9S1J4Va/urdGMxiMGLKditDonL+BdWT2ui1cBRiyHMHwfq64sxyM3QBaS9W5zS0v+zwHYY/jlo7ATmy/5f/VCiGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PrJtSk8OQi+pchgSiXDX2XFJsp9rGSv9I2tARf32TYQ=;
 b=T2vH7j0eJ/fFjU81HewiX++7sDEsPJJRNZUTzFiZ2lYPdZd2S0pSuOQcf79lrh/+QNrKePVLLU2RnpNIxd41MQUiHEGCem36q/GR1z+iFvWIn75j8wso4066+vleiC8NdaZJNSw49GeXzhJcpUZFQ5KNQ+Ii0TMnnid+ZuBYSYoF2jfnkodymtAK6/K18ouF+Ctna0r/ATop/lvdrkvbt6EXXQHYDF1SuNDwzJxqnePxrIkqbBLRrWVgxxhpKjW/u4Y/JiaIhpGYHwPYPMHL8UiD80d+X616BC8VEFG7pA0W12oIB+KKY0KkvrCTzt0F8fupiowyc6OSYJT8qbYKGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PrJtSk8OQi+pchgSiXDX2XFJsp9rGSv9I2tARf32TYQ=;
 b=ZQzW641qOD4xRfJ6jk7QIzAZg9mnolhIu0+vStIZSdfZIM3xADLoCTAeLzVyXEufBn5HsNPrZUw5mEdfOrQFy5mSfTv9P4EqTd/qPgB8fx2weemyzlXF36a4TPnuWWjyg3IK55TBhk7+AAPbZVYMRo8Ndc5lZLmsro00VRoSe24=
Received: from CYZPR02CA0012.namprd02.prod.outlook.com (2603:10b6:930:a1::7)
 by SN7PR12MB8789.namprd12.prod.outlook.com (2603:10b6:806:34b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Wed, 9 Aug
 2023 15:07:14 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:930:a1:cafe::26) by CYZPR02CA0012.outlook.office365.com
 (2603:10b6:930:a1::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28 via Frontend
 Transport; Wed, 9 Aug 2023 15:07:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Wed, 9 Aug 2023 15:07:14 +0000
Received: from stylon-EliteDesk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 9 Aug
 2023 10:07:10 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/15] drm/amd/display: Gamut remap only changes missed
Date: Wed, 9 Aug 2023 23:04:54 +0800
Message-ID: <20230809150620.1071566-5-stylon.wang@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809150620.1071566-1-stylon.wang@amd.com>
References: <20230809150620.1071566-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|SN7PR12MB8789:EE_
X-MS-Office365-Filtering-Correlation-Id: 110ec8f6-5e2e-4bee-077b-08db98ea50bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z6f7YXwNHkvgKdSvmU5U7tY0Dzl4zzjoq0fb5WFB90kmuHnPKUtR1n/e7NUMDoAqE+QSyH/cRKrFXXhe1YdebsZ/nlZsY9P9zzqI5wKVaD/5BtteJy3q5QBCSLceK/Bw2m5Zb36igng2hOdMaSbuOfsRkz87engLWP1ToVGlBLyhZFEOD1pfGZMr3grDxoFZIRM3mgPwmaWCJPb1CX5GUnWZAO2VsmxwT807aZGaNl4RHdmbgeTVtXa0wfeeId3+ZzpICsto9YY99YOTpSjP9BQ577+eiPfy2FA2JOB9KY77W7xksQBzddFfLsJzylPbaBHNqvPmAxmJl49h9JTvFgAvNYjYr3050VZ1x05gWhmWolv6f+PmbBXJreXrcxXGHAaRIYA1v6kFGpdxd4ZglyxHvelD/b+u7qjv0gMv/ssUOOM8D5keNE+GF23ZjlL6eWlFKDc7Snf2trjZBnuPNh3qjFYhkKlv5TEEiLyZiwyzRsBzCViBBGbGiS4Cde7l03CLax2o0kK20K4+CzGtkubTORPAL/kYuWWfuWScw2PKW5/77NwWxJVA962e3p9N7Vvdk5Kw+5qg0zdM+WjVHMpRk5I4G2a6EhufnekQzqw59czuvcO2wqyYvRh5jUiqVoA72hyOUC97B2LMnqbifjc/nhr/eixPO7VhqXVFTW8xIFpc7j8gnFRSazKiMxi9qsta4/Xwd8yvNPTPEbRzhm8bdU8Vei6n5PBkPh2H8BLr6uVJMdVpiLexftTB0l4FRAm8JLsF9+ydrr/RwR6cgQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(39860400002)(136003)(346002)(1800799006)(451199021)(82310400008)(186006)(36840700001)(40470700004)(46966006)(6666004)(40460700003)(41300700001)(81166007)(7696005)(82740400003)(356005)(47076005)(86362001)(426003)(83380400001)(16526019)(2616005)(336012)(1076003)(26005)(40480700001)(54906003)(36860700001)(316002)(478600001)(2906002)(36756003)(4326008)(6916009)(70586007)(70206006)(5660300002)(8936002)(8676002)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 15:07:14.6232 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 110ec8f6-5e2e-4bee-077b-08db98ea50bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8789
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
Cc: stylon.wang@amd.com, Krunoslav Kovac <krunoslav.kovac@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Jun Lei <jun.lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Krunoslav Kovac <krunoslav.kovac@amd.com>

[WHY&HOW]
If surface format is dynamically changed within app without changing
timing / whole plane, we don't reprogram gamut remap matrix.

Issue example:
Linear FP16 scRGB going to PQ+BT.2020 monitor.
Remap = scRGB->BT.2020

App switches swapchain format to 10-bit PQ+BT.2020.
SW calculates correctly that new Remap = bypass (in=-out=BT.2020).
But update not applied in HW.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Krunoslav Kovac <krunoslav.kovac@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index b196b7ff1a0d..65fa9e21ad9c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1638,6 +1638,7 @@ static void dcn20_update_dchubp_dpp(
 	if (pipe_ctx->update_flags.bits.enable || pipe_ctx->update_flags.bits.opp_changed
 			|| pipe_ctx->update_flags.bits.plane_changed
 			|| pipe_ctx->stream->update_flags.bits.gamut_remap
+			|| plane_state->update_flags.bits.gamut_remap_change
 			|| pipe_ctx->stream->update_flags.bits.out_csc) {
 		/* dpp/cm gamut remap*/
 		dc->hwss.program_gamut_remap(pipe_ctx);
-- 
2.41.0

