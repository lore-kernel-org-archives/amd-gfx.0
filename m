Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 083DEC4167B
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Dec 2023 19:52:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C3BA10E630;
	Wed,  6 Dec 2023 19:52:45 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C726B10E5F2
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Dec 2023 19:52:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZLlwd1nQhf2kSwUygZ2wMJPl2PUuffFrq32FM1dCexQ7U3z/TiT8UFjrlZXxW8XVVio4h3XEvgYyV98Kds1/QOSOK6dRVUKOjay5qGwfqTRE/asZVrm8fWFstDze4/Qd2xb/FccnY7HPTnHI39BsiOHT11B88MwE3Ai0mqZ72b8EJ1PEMoAGjud755RQ5VNZ63t6/dEco+BIZn6XtSStfyUdXy5LprLSeA5GCmnRZNQMu0fkAgSqrI9/iPFA9RinMoZEwAbU1c8Ltpvlfyai04PuDekIrI/lkckAUezPtvpic21XqWDEMM0je2JIcY06ckrf0Ji0/nZ3RjDF84xr3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NMth5wQro/HKjRP4mpqjUdrPGuY7XY8Dj/NgKGKZ7f4=;
 b=AXpuV7ENcpJOM507c7l440pfOXxJvKXjE85BHIyC5uLImlnuF3jQ/JUCKMsJkN2iHUtPB2voxynbTspZifp62EzIR3f+wd3Jubaht+Fpl4okQ7qUDYgLdbEEwpoopGj2sGPOJFqPqQh47tudZpDiROl4nmqXhFNxy8FBBLMz1yv6JzhOOJX02Pstet1cnez/4zsSpJABwmO7/9c0wTT6zKOUuPB6pX6+Dq0BN+fz+tzIiddfUprySkxrcl66gepeUZyjHGJXhHS8mzZc6BJdpganSxYTSONbYrbgzybGmXr3F+7J9/leSPdLS/Tbx2oCHdAzR6yzpoqrXv5NlZi3eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NMth5wQro/HKjRP4mpqjUdrPGuY7XY8Dj/NgKGKZ7f4=;
 b=JyfzT2hXrVl5mxBYl13WbcBukm5767d9FC9UW+Dh6DMsyQjxchMUEhtYiZGp4TlpdMVezTvutMq2tdxGXmMeU3bWqejdlB0RkjwHWcyXNWg4koEflTsHhsNMwmvemzf/V8YQMpWaGn7B7YANgVckEHkYM7P++C1WVRGmDcTrFVo=
Received: from DS7PR03CA0029.namprd03.prod.outlook.com (2603:10b6:5:3b8::34)
 by PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 19:52:39 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:5:3b8:cafe::d3) by DS7PR03CA0029.outlook.office365.com
 (2603:10b6:5:3b8::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17 via Frontend
 Transport; Wed, 6 Dec 2023 19:52:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Wed, 6 Dec 2023 19:52:38 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 6 Dec
 2023 13:52:38 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 6 Dec
 2023 13:52:37 -0600
Received: from debaura-ryzen.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 6 Dec 2023 13:52:37 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/13] drm/amd/display: allow DP40 cables to do UHBR13.5
Date: Wed, 6 Dec 2023 14:52:24 -0500
Message-ID: <20231206195234.182989-4-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231206195234.182989-1-aurabindo.pillai@amd.com>
References: <20231206195234.182989-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|PH7PR12MB8796:EE_
X-MS-Office365-Filtering-Correlation-Id: 659536b6-6bc4-4716-7a98-08dbf694e693
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HB+iQ8j1r1nQInXAdN+hgICw3vUgYJdGYm0oEGDmXUHOCGu7FBlCZpLiQMqTXut6HfV0NFr2axlsiM08ccz0hXme80c3xo5IAuoT1+000VI3lOQg0XSPLvCbZPR2dnLI1wurGQiVlWhxD3AZVscqk0DyQM/pyLuvwMg3q3U/tZV2/uGpxdHhZP6kDavSz9HZXQ2/bUsJ43uwPQpls6+kVyjENdS+6rFWlrYhE+XU6QZsriC0NVFz/76xEr9ZZLektxiRc65FCwUzTfqbhXjx4ocHeMcU1Kq1H9lTcAOBwny4VsUYn+1KavvCi8k82i3bZzzXHHb6GidqBkLrBriDm+hizPsBpaIIBqAktCxl7dGk9TLDWOlyHVGzsmIiKgyvdlvmjfC7bVC3PyhhtPV+vzLu9I5qHd4Ihb+rUwgQSYDTSrO/ahbjzfNUUrxKXwjmQGt5GEIZ+aH6j63/tn54XFim+8YkQrIq2rZo8ZcjNXTWzVbj92EplZCkzqnXLhkZRt8YriJV+5uw3Q2tGTqPjHsLW+vs6hvNw058nOW9jobzSNlLMWYKi2wNSGP3YFFYSDGGccvbbS1JNG+EOjqOYW3BwrrOkk9QdzHSGhfxBjqEn8WAuI6PQ15FRU+8QQ32YE2NNDFBXCpQQd63WscWURK34ypGFD6dsLq/Pi5OzEFrIY74e9Wsz9AgcYAfCy52jDruUvd0luGAi9kRCqFGp5AXt550c1hxan4FLq1prJbieexZBTTPbOe2rjtrkgOe9VD2J/G5t5qiVEFjpVIuMA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(376002)(39860400002)(396003)(230922051799003)(451199024)(186009)(1800799012)(82310400011)(64100799003)(46966006)(40470700004)(36840700001)(2906002)(6666004)(40460700003)(478600001)(8676002)(8936002)(4326008)(44832011)(86362001)(54906003)(70206006)(70586007)(316002)(6916009)(5660300002)(47076005)(40480700001)(336012)(426003)(1076003)(26005)(81166007)(82740400003)(356005)(36860700001)(83380400001)(41300700001)(36756003)(2616005)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 19:52:38.6137 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 659536b6-6bc4-4716-7a98-08dbf694e693
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8796
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
 George Shen <george.shen@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 wayne.lin@amd.com, Ran
 Shi <ran.shi@amd.com>, Harry.Wentland@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ran Shi <ran.shi@amd.com>

why:
With DP2.1a expansion we are allowing DP40 cables to do UHBR13.5

how:
Assume UHBR10 means UHBR13.5 also for unknown cable type and
passive cable type.

Reviewed-by: George Shen <george.shen@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Ran Shi <ran.shi@amd.com>
---
 .../display/dc/link/protocols/link_dp_capability.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index db87aa7b5c90..3c5334cdb3fb 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -412,12 +412,18 @@ static enum dc_link_rate get_cable_max_link_rate(struct dc_link *link)
 {
 	enum dc_link_rate cable_max_link_rate = LINK_RATE_UNKNOWN;
 
-	if (link->dpcd_caps.cable_id.bits.UHBR10_20_CAPABILITY & DP_UHBR20)
+	if (link->dpcd_caps.cable_id.bits.UHBR10_20_CAPABILITY & DP_UHBR20) {
 		cable_max_link_rate = LINK_RATE_UHBR20;
-	else if (link->dpcd_caps.cable_id.bits.UHBR13_5_CAPABILITY)
+	} else if (link->dpcd_caps.cable_id.bits.UHBR13_5_CAPABILITY) {
 		cable_max_link_rate = LINK_RATE_UHBR13_5;
-	else if (link->dpcd_caps.cable_id.bits.UHBR10_20_CAPABILITY & DP_UHBR10)
-		cable_max_link_rate = LINK_RATE_UHBR10;
+	} else if (link->dpcd_caps.cable_id.bits.UHBR10_20_CAPABILITY & DP_UHBR10) {
+		// allow DP40 cables to do UHBR13.5 for passive or unknown cable type
+		if (link->dpcd_caps.cable_id.bits.CABLE_TYPE < 2) {
+			cable_max_link_rate = LINK_RATE_UHBR13_5;
+		} else {
+			cable_max_link_rate = LINK_RATE_UHBR10;
+		}
+	}
 
 	return cable_max_link_rate;
 }
-- 
2.39.2

