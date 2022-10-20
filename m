Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A2B1C4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Oct 2022 15:49:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C109910E4D3;
	Thu, 20 Oct 2022 15:48:37 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 576DD10E504
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Oct 2022 15:48:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bKb3CUpSmK5WHaPHqOgvTdTyP8EZshTust4jXdR3nWPXqVYlSyV6dmwv/8dVw00LrlqfI/9wcfpG/HCMlMCj+zL3V/vM4HL8tdMWLN7AssHLDzK2Yh9YTO8MvtV387YtHV+994yx+LN2l6atvgqW28rMGYKBLghOiwDNYB4IuYgztB2OSs/gPCa1UleZyKazQecI9ShwMn7uY1QiP0oGupl6eLyFHhUjPW3Re14h28b+By11BKZo8fNTz4n2JGRdNm4tf0PYJlE1/GwDyGPDpmR9MyPETAAtUA5PcvYuxibEhawnX/+yaSxaK8l6AUYkKm8yuGPgy/OqjOSQiXUjew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Vt/A9ap597c/aZk8ha4tmBe7+RSdPacff7lN0AKs08=;
 b=BZKNAtOvI1XzWkikU1p0qkbmhfdVztj/b09LuAmZANscIaaApT2Vh7BZDilpDLLxpXxLESQdUjZ0sS6aG/85av/yPliZFgcvHW1J/BLbTvpjm+rjfFHjdsb/Lsly1PCdUvNeW8GmHjx4aFHx1fhIpk59dNkHFfkgINNoNefn/5h1+3hPdqyg5hpQYuN8asHRDSHb94NOxpBT+TDGEeLNCz2DOJry5fO9xsOXHZY+zBlDHiSzPvNB2eeResR8xo6lDo0MxsTGc9Lwq4xwHjQuBXhJEYGa8+IqjACHJgtv1c6AEGnrPLykCZISjEg9rQt0U59BMvVeJSyBmmJ2dpJLrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Vt/A9ap597c/aZk8ha4tmBe7+RSdPacff7lN0AKs08=;
 b=2Lmsy46zLnf08ln4MmihJx4QxdxCyjitaU1LC6OpKnF2BEyCJjr/UZts5A2VwhEA3RhvHsg4q5oZXwY91dy2GyKCCriYCk0lD2LmrRFB8FB3XbU77mWavJ0CSdyg4Toe4x381OhRm2TvRfMdcTRwKOPoX/aI3A7MT1ypdk0ns2I=
Received: from DS7PR06CA0036.namprd06.prod.outlook.com (2603:10b6:8:54::14) by
 DM4PR12MB5360.namprd12.prod.outlook.com (2603:10b6:5:39f::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.34; Thu, 20 Oct 2022 15:48:11 +0000
Received: from DM6NAM11FT079.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:54:cafe::cb) by DS7PR06CA0036.outlook.office365.com
 (2603:10b6:8:54::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35 via Frontend
 Transport; Thu, 20 Oct 2022 15:48:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT079.mail.protection.outlook.com (10.13.173.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Thu, 20 Oct 2022 15:48:11 +0000
Received: from atma3.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 20 Oct
 2022 10:48:08 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 24/33] drm/amd/display: Fix SDR visual confirm
Date: Thu, 20 Oct 2022 11:46:53 -0400
Message-ID: <20221020154702.503934-25-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221020154702.503934-1-Rodrigo.Siqueira@amd.com>
References: <20221020154702.503934-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT079:EE_|DM4PR12MB5360:EE_
X-MS-Office365-Filtering-Correlation-Id: 8438e671-0422-4618-f604-08dab2b27e47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3ZqshT5D+tj7RxyMYE/jdO7P98/hTj/vSKkrSj8t5tU5VC1ecqljg/TrIA3KGMLgbnv0xC1KkGuYpN0mFxvsMmBe1mnA7kCRviEebPwEKAagjrpfPawjh7ESL1ysizfmMZze/XrkUSqFFho+GSnCY7nNLDyRIuBq0+f0WK8ixy+3vbTSRkcxV43Lk9RG/XVhfNEO8juwNH86BiDmMDoQnwWYGyNF2zeah5YB6r2IVPHzC2dBjYe94/UK37Zn8Ln2mwc1vvYRvk4v+7LFDcHJ+PRGM3gO7XO0dRUD9BgVdSiGlF1wcGJ1foHkqrkgddPKbdLHssR/wVshgXl0lnwB2YVmkhjK5eks2t87CUSEuzW2dO7MOoVFP2tYNuV6yFxE4/d2wW0cth+ZYICL+ROVi3fp+e0xhTfbGFuZH5M1FM8JMDvFLPrRnkXXJrpVT7ac/6RhKqy02JnH7Jc1RniNWllCEguzXJMS/YeSDAV5Npuu2C2nMJuo80HZZB6yfqYDARXGYnR/QDsImi34oI4mgwaZH8xzGIqxBCi01OkWcOFn7J7PQD6RQzhu/D3+M0rblHn2op/wMyVN9I+il+btWe++wLZK+gZBVII13b6e5n4KsSfeY6sYNmsq8jlpl12GdDNNy4TlK8ELntpOdlULN04iaUAzNzwcASqljKw3us9f7gFtQT7DkC/3ZeI8naeQw065G2Ofg+aJCzPyazUIPHZI6a1hQjtSzSQlApO+zrYDmFXRNiLSn+X1yWG/Z4YwCT5XLXEOL75geeejI4JfjdnAKSQXJm4TJ5tJGIiao3mmx2g7RqzK1QHrDpmymvKR
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(2906002)(186003)(356005)(2616005)(1076003)(82740400003)(81166007)(16526019)(40460700003)(478600001)(82310400005)(4326008)(8676002)(54906003)(47076005)(426003)(86362001)(6916009)(26005)(36860700001)(8936002)(40480700001)(6666004)(7696005)(36756003)(41300700001)(83380400001)(70586007)(70206006)(316002)(336012)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 15:48:11.8289 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8438e671-0422-4618-f604-08dab2b27e47
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT079.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5360
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
Cc: stylon.wang@amd.com, Aric Cyr <Aric.Cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <Aric.Cyr@amd.com>

Apply SDR visual confirm to RGB10 and FP16 formats as well when needed.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Aric Cyr <Aric.Cyr@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_hw_sequencer.c   | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 7c2e3b8dc26a..471078fc3900 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -366,6 +366,7 @@ void get_hdr_visual_confirm_color(
 		struct tg_color *color)
 {
 	uint32_t color_value = MAX_TG_COLOR_VALUE;
+	bool is_sdr = false;
 
 	/* Determine the overscan color based on the top-most (desktop) plane's context */
 	struct pipe_ctx *top_pipe_ctx  = pipe_ctx;
@@ -382,7 +383,8 @@ void get_hdr_visual_confirm_color(
 			/* FreeSync 2 ARGB2101010 - set border color to pink */
 			color->color_r_cr = color_value;
 			color->color_b_cb = color_value;
-		}
+		} else
+			is_sdr = true;
 		break;
 	case PIXEL_FORMAT_FP16:
 		if (top_pipe_ctx->stream->out_transfer_func->tf == TRANSFER_FUNCTION_PQ) {
@@ -391,14 +393,19 @@ void get_hdr_visual_confirm_color(
 		} else if (top_pipe_ctx->stream->out_transfer_func->tf == TRANSFER_FUNCTION_GAMMA22) {
 			/* FreeSync 2 HDR - set border color to green */
 			color->color_g_y = color_value;
-		}
+		} else
+			is_sdr = true;
 		break;
 	default:
+		is_sdr = true;
+		break;
+	}
+
+	if (is_sdr) {
 		/* SDR - set border color to Gray */
 		color->color_r_cr = color_value/2;
 		color->color_b_cb = color_value/2;
 		color->color_g_y = color_value/2;
-		break;
 	}
 }
 
-- 
2.35.1

