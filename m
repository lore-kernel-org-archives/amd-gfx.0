Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED4CC4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Nov 2023 20:08:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4D2210E775;
	Wed,  1 Nov 2023 20:08:52 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::62d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B082010E775
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Nov 2023 20:08:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b6cgphwFZi6aN9EYB0m8LUiqP0ZbCfqymZqkEmh+VyP/6levaFDw5JFAoc9vOm2rSUxKMSKfO4X59NAlzy30wfVixkI2RxowePwxil4HrzQMK/kQU73EzPmi6X0cIZKWq+rD0NFh2s2YH0TZlA2dA3lRrJE9b8E7q93LeyxtTs5xQAux+WxKWcWVIW0osq+eLIRaSyEHKHWB0gh5MswjEUHQ+Vti2Ulf1SBYQvwQ3EGIKdQYgL0lT3YF+dc0B9cCdPT2Brab6qqH5vPvjkBtSun/vJxlbaqHS3H2Z7viLgMoWZhIoJyU9k7Wxg9jfq7dnTTQEuWn38++KuR+jBr6QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ADOVgiH1j8bYWrIO1TVmEo5IfvnU5GDrx+X7meiKNYY=;
 b=HTC5dd0HAmWprtp9u+2+enJAG2PjuYe0GgbAjLRK29dce6S+/ucbmIxgys9MdPlj430F4UBvstbVMaKDqLX7ciC9Byq18cl+djlBxqmzdNDQZARv0eDL/SqmjnhKPoiTOMN542fsBBR+vLXdRK3KFNqXgWAuXnpS/FMJfpBZmeEPJ8PzGEzJTUDFGx9DVjINdtYVXSxOC+tWjbeQD1tBw4ns6Edt/wEJk7wnhyHROkRUFsorD+3K/GDPLClEs4LzcqTK5lCsGRuhy5Jz1/O1uJF9yJsVYj0s9wAVMqyNpg+uP/wRm0M0q+62Snb6N2Le6dn2ayRMBzIpAN7QKNtFvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ADOVgiH1j8bYWrIO1TVmEo5IfvnU5GDrx+X7meiKNYY=;
 b=uLrsjV4FnwK6h1reSEscR7bYshKAJyaTAlvIgMvwSkFUZJ1uUCTwSKArtKQK2Cpw8wtNEeHDsRnz/ZL92CVgcyhbyNEmv2sSIPiTsPjiYrstLA8tz/GueXVGXRelfPgy0ZmIksB2U0Dnr58O8NHNgzSDVw4gs7whtEZ04VMFXfE=
Received: from DM6PR08CA0060.namprd08.prod.outlook.com (2603:10b6:5:1e0::34)
 by DM6PR12MB4298.namprd12.prod.outlook.com (2603:10b6:5:21e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Wed, 1 Nov
 2023 20:08:47 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:5:1e0:cafe::26) by DM6PR08CA0060.outlook.office365.com
 (2603:10b6:5:1e0::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19 via Frontend
 Transport; Wed, 1 Nov 2023 20:08:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Wed, 1 Nov 2023 20:08:47 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 1 Nov
 2023 15:08:45 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 1 Nov
 2023 15:08:44 -0500
Received: from hersenwu-Majolica-CZN.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32
 via Frontend Transport; Wed, 1 Nov 2023 15:08:43 -0500
From: Hersen Wu <hersenxs.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/12] drm/amd/display: For cursor P-State allow for SubVP
Date: Wed, 1 Nov 2023 16:08:22 -0400
Message-ID: <20231101200832.995436-3-hersenxs.wu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231101200832.995436-1-hersenxs.wu@amd.com>
References: <20231101200832.995436-1-hersenxs.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|DM6PR12MB4298:EE_
X-MS-Office365-Filtering-Correlation-Id: b9496475-c00c-48e2-e592-08dbdb165ba2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NJYhnhNx69XFgzvbjjrNLqB7Pti1IuRob7G/om09HBz9DVJqSSJ+VeNzVH45FbN75DMUqlPehhfg9RZUNAULhs5c5YpNGYuvSoVF/C5JizOcJrQ5GPiwTd7CbHADPaPtVd5vj0wZoqZF403aUrC37avHV79XJnwOg6KEQvFK71PlCfxLrvhTD0LgjW8HHl13DNnzO7PgfOqSdOTmPiGgatKMA2p+BiTeBy1Dr+EM2P7CF5diXpc6DnQJ+InLtlCxCZlxFFNx3Kf9aTmIdhmzC3yiWRiYH9Q12q84fhMLfQL88MejVRQEUiK0fBFlyDayMDA55aawP9uH0k3evNvSQuzJFfIbjsIIi7t0PgTPxz1+3fvmqgw8x2Stom/+08R23hrEP9yVzQUhkDF+8Yn3IeyugGh4umG85KqxWRqFzWP+THxcwasefBWEyHNmM5uCK+8qEiQap0A8ZM/JnhvkZhjifJniY60ZR5EpTYz0neoxty59aNlRO527bxysn7pRscQPpdctq47rOJq1TsmPq1n/GLesrlE3+XexAWzZZjNNSiPLrGgLsy0GLnK+peYcTlxxq0JCiqBqck/eKy2J/Ns++e07KhzKz1FCETqXpxbtMe9RTIvSJh81W17DZDuonTIh4V/piJW2o0iIwwzfaHkKSfBpJrf/U4CQ3PdBW8nA8rMeMirJ/+w/VLlgpKb5tUJlUxMMxcBL38mFJo+OzcU5eTKdRvg60O59ePx7kfLj0me2wQpakcPI+nAFJ5RXz/dkwaaPl7+6RFCuLyUkdQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(39860400002)(396003)(346002)(230922051799003)(82310400011)(1800799009)(451199024)(64100799003)(186009)(46966006)(36840700001)(40470700004)(47076005)(36860700001)(83380400001)(426003)(26005)(1076003)(2616005)(336012)(6666004)(36756003)(86362001)(7696005)(81166007)(82740400003)(356005)(478600001)(40460700003)(316002)(6916009)(8936002)(4326008)(8676002)(5660300002)(41300700001)(40480700001)(2906002)(54906003)(70586007)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 20:08:47.3879 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9496475-c00c-48e2-e592-08dbdb165ba2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4298
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Samson Tam <samson.tam@amd.com>,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 Alvin Lee <alvin.lee2@amd.com>, wayne.lin@amd.com, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

[Description]
- Similar to FPO, SubVP should also force cursor P-State
  allow instead of relying on natural assertion
- Implement code path to force and unforce cursor P-State
  allow for SubVP

Reviewed-by: Samson Tam <samson.tam@amd.com>
Acked-by: Hersen Wu <hersenxs.wu@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 .../drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index 1b9f21fd4f17..6a65af8c36b9 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -615,12 +615,6 @@ void dcn32_update_force_pstate(struct dc *dc, struct dc_state *context)
 		    pipe->stream->fpo_in_use)) {
 			if (hubp && hubp->funcs->hubp_update_force_pstate_disallow)
 				hubp->funcs->hubp_update_force_pstate_disallow(hubp, false);
-		}
-
-		/* Today only FPO uses cursor P-State force. Only clear cursor P-State force
-		 * if it's not FPO.
-		 */
-		if (!pipe->stream || !pipe->stream->fpo_in_use) {
 			if (hubp && hubp->funcs->hubp_update_force_cursor_pstate_disallow)
 				hubp->funcs->hubp_update_force_cursor_pstate_disallow(hubp, false);
 		}
@@ -632,17 +626,10 @@ void dcn32_update_force_pstate(struct dc *dc, struct dc_state *context)
 		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
 		struct hubp *hubp = pipe->plane_res.hubp;
 
-		if (pipe->stream && pipe->plane_state && pipe->stream->mall_stream_config.type == SUBVP_MAIN) {
+		if (pipe->stream && (pipe->stream->mall_stream_config.type == SUBVP_MAIN ||
+				pipe->stream->fpo_in_use)) {
 			if (hubp && hubp->funcs->hubp_update_force_pstate_disallow)
 				hubp->funcs->hubp_update_force_pstate_disallow(hubp, true);
-		}
-
-		if (pipe->stream && pipe->stream->fpo_in_use) {
-			if (hubp && hubp->funcs->hubp_update_force_pstate_disallow)
-				hubp->funcs->hubp_update_force_pstate_disallow(hubp, true);
-			/* For now only force cursor p-state disallow for FPO
-			 * Needs to be added for subvp once FW side gets updated
-			 */
 			if (hubp && hubp->funcs->hubp_update_force_cursor_pstate_disallow)
 				hubp->funcs->hubp_update_force_cursor_pstate_disallow(hubp, true);
 		}
-- 
2.25.1

