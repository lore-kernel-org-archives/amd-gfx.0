Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1BA1C0015E
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Aug 2023 15:08:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FD0210E454;
	Wed,  9 Aug 2023 15:08:15 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7690710E454
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Aug 2023 15:08:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZU/IVbtLpVguapGS2s1wlMZtEh5O0I1uL3mTSBFb2/WeyjA345+rlbFdK827c9VcV+E/mj6/lRq2NPs/U4/jnKE/ed1o9KCOXlhJ8hhZGbtCtP22e/+GAn7tuZ6XqUhrBsW2Pr6FsOVy32bI8JLVa8fwPTYQ3RpkEIPozxNgXmK8caM1zsHV6HOMFE8+cpRbrOtr0VucWhGGC/0cobmjNIM778RvOvdflcg4NtIfd9Sa/o7ZCujdJ6EWG4lZM8jufwNlDC90t+m+sYo7RK4tef8z9zY6zJtosnOOef2F6fwuYE8696N4ventJQugWq+CctU1KazKi4biVdklqt8Mhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mnDu0lEcV7V7ViEKBkbzpJjAD5j7oBUkZGuJQSDFbsg=;
 b=MPhP6glNkrhS6OpLcvF2OWxZaIATzjKUnaicZ+c2xv5o9c2inuPbyN5CUomVIZjovs8Akz72fHWi73l3hkoA3r821HjNecIUtJvAGe+/dNcGE/cAYb98XM4xsluo/W58WOinkQEfnZZ0HlbBWTjtI3OriBfEmRf56W4+fFzlURdWXyiGZbT8hNt5oGZiAJ+V23c8+a/LseWWHdu6KbPjoHJ6Zmv87LT8XDFc43jhoLq4y4T4Y2YilQTcSSvWUcF+w5+1TqjkFboqc3NPAAcFwMjUxB3yNR668QMvkRnj9L3YVp6T2iUmyCu9dYqVrN/V2y8MZDEWywPlHZqpXUo7dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mnDu0lEcV7V7ViEKBkbzpJjAD5j7oBUkZGuJQSDFbsg=;
 b=RqODH0Lkq1g5Amaq132YFse6Iw/eNfMPQC231VDAXdQdudKV+8KvEFkWgzvlfEXn2yEMG9SsDwv/4Je/noL6PPGFzeJvl/3t4vfyut61lgjD+oGKvjFtqJ80CynUNQytlL6j1GmpHhUb643jusMFy1l3wbdxdi+rDWqPRAEl8m0=
Received: from DS7PR03CA0334.namprd03.prod.outlook.com (2603:10b6:8:55::11) by
 DM4PR12MB5817.namprd12.prod.outlook.com (2603:10b6:8:60::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.27; Wed, 9 Aug 2023 15:08:10 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:8:55:cafe::f) by DS7PR03CA0334.outlook.office365.com
 (2603:10b6:8:55::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28 via Frontend
 Transport; Wed, 9 Aug 2023 15:08:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Wed, 9 Aug 2023 15:08:10 +0000
Received: from stylon-EliteDesk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 9 Aug
 2023 10:07:14 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/15] drm/amd/display: Enable subvp high refresh up to 175hz
Date: Wed, 9 Aug 2023 23:04:55 +0800
Message-ID: <20230809150620.1071566-6-stylon.wang@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|DM4PR12MB5817:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f92ec15-46a7-4eeb-f603-08db98ea7221
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LEotGVifhxhjI+s1Yt9KK5EpiDFz6zDEcvbi/3Nm+uZfPQtugc3kVn+sSI9p5NPtNeK+YePG7y2NnvP3fmp6qVSDGCxCITX6IfSH3NBuBsy7rRpo/P5gLYIQd0BV/iI4XXFFE06+W1vl6gyUaI06n001xpj1PO0G2sV8f2p6J7sBTHhJy5jYk9w9A8QOHqf26KTSWI5yDQeC5W0cIMWedbgr0CvkxzpfHmVdefD+tOhuUifQfAJYRdQcnyYPyBGovgQqFTqZP5c4d13kA8Vw387Rf6Ya5Ou5ACNkOQT7rUxtrDWJ0R47KgTBvB/DtJjOjab4o5u+nBM7V+F0YRQ5WRVQ7kTjrv9sJRcl7IXfJW1mol8Y+sJN4TJ8FUnMnsqMWwlTsoK7JNnQ80qHf31IIzQOK9Y5HGcrh9vnyUVMk0XwL0ar+eQdJ977XsTcd/Vk68BCRXEDohUq4WQtN4HLppqFY59uHtftn4mJj+PAOUz+V761Crqd4cofmn3nPoNbB1yk9NbPh8GCGQpYiHwfLcQgOrKYvRTIpF2REY9VQUSgfo+0BvmQcmQKskWDGA6Xlv6oGazslElA2oYGNKnOR22l0bSEJ0VPAGgZH4Jchbi5kLwQrBXeKFHg4lH0f6oLq69aO+7zuUB2HrarMc+F9E7/tAzrSaL0wX4jQOEPFxI9RXRTn/kdFs/FGxf9hfbr5Wo7qtf+fK3xSnrakkpR4/PF+dyZozhWInL5jLznSXyr1aEfU2xp+LpvetS60qi1qSnvHojvAIuIv2EjYvGtvg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(346002)(136003)(39860400002)(1800799006)(451199021)(82310400008)(186006)(36840700001)(40470700004)(46966006)(44832011)(8676002)(8936002)(5660300002)(4326008)(316002)(426003)(41300700001)(47076005)(83380400001)(40480700001)(86362001)(40460700003)(36860700001)(2906002)(6916009)(336012)(6666004)(7696005)(26005)(1076003)(16526019)(2616005)(36756003)(70206006)(70586007)(478600001)(356005)(81166007)(82740400003)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 15:08:10.6560 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f92ec15-46a7-4eeb-f603-08db98ea7221
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5817
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
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alvin Lee <alvin.lee2@amd.com>,
 wayne.lin@amd.com, Chaitanya Dhere <chaitanya.dhere@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

[Description]
Expand the SubVP policy to include up to 175hz displays
for better power saving on more display configs.

Reviewed-by: Chaitanya Dhere <chaitanya.dhere@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c      | 2 +-
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index ea3d4b328e8e..cd5243c59d2d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -322,7 +322,7 @@ static bool is_subvp_high_refresh_candidate(struct dc_stream_state *stream)
 	 * remain in HW cursor mode if there's no cursor update which will
 	 * then cause corruption.
 	 */
-	if ((refresh_rate >= 120 && refresh_rate <= 165 &&
+	if ((refresh_rate >= 120 && refresh_rate <= 175 &&
 			stream->timing.v_addressable >= 1440 &&
 			stream->timing.v_addressable <= 2160) &&
 			(dc->current_state->stream_count > 1 ||
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 0f882b879b0d..6d60ae0133ee 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -37,7 +37,7 @@
 
 static const struct subvp_high_refresh_list subvp_high_refresh_list = {
 			.min_refresh = 120,
-			.max_refresh = 165,
+			.max_refresh = 175,
 			.res = {
 				{.width = 3840, .height = 2160, },
 				{.width = 3440, .height = 1440, },
@@ -1064,7 +1064,8 @@ static bool subvp_subvp_admissable(struct dc *dc,
 	}
 
 	if (subvp_count == 2 && ((min_refresh < 120 && max_refresh < 120) ||
-		(min_refresh >= 120 && max_refresh <= 165)))
+		(min_refresh >= subvp_high_refresh_list.min_refresh &&
+				max_refresh <= subvp_high_refresh_list.max_refresh)))
 		result = true;
 
 	return result;
-- 
2.41.0

