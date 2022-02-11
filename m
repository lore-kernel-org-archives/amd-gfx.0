Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74F7CC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Feb 2022 21:52:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECC8410EB3E;
	Fri, 11 Feb 2022 21:52:00 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD9C710EB3A
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Feb 2022 21:51:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cal7rJGxQccflDvvL/Uo9p997tSbkW1ZvMVo+AcjNXnRbzT1SLW22gRfiiXi1cTQdHSm5LR9uwROA3OPD/HpM6lWmjzuxrurdyLhkhHVbDcfhTUbtDV3WCm+hoE4egJWUxsaAi9cUoWZ9KmPoHpW31GBjNEBndHBBGGv3Apzs6ca7JWltikhFFCSGN6KfYQLpbCcJFFQeh3UTdB9owoYdutbFpD1+2VoRW/a+aDBnI+nDclljlPSC0/M7n1PWWPL3kZcEqLT36KbtZL/AeziFZ3W3VVHcqOlFMdxvpKJanwT/2rAUcaBhco8957l6FbrOuQMWAe/ZO9ZGE7I0kf47g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7d8S8ZaH6CLra5fWOJFnt1u3PRQw5XRuVU3bx/hLiWM=;
 b=IhV4FiNgLQaUCWONl+0tO8LCeWBCqOavAvi1fwjswcFJwc4aS+Wc9na8t2TSRXedS5+ZzaULHbYvrk+B21V1N65fA64t9mZj3IALRJnd+zMkL0M9B/JiroU+1GFCiF76WXddRYlW1RUaSCwg43eDluMkApnTMM4qItvlwp8vthaVBUVu/onQ5N6tIwhvOD6bTgsstQK+cZF0rN6NCZJqjMj4ND9ryr/F2+BjAoz2omZXncvk0dMTkGH9cA9AD6HLUe5IS3OcQPBuE34BIQgqJiH7C9JGN51sO0JOC/sePZ1jgX05m5oDo7HzBWSYhBIMUiRdKUDICHEQMoKHSTgv1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7d8S8ZaH6CLra5fWOJFnt1u3PRQw5XRuVU3bx/hLiWM=;
 b=l10+6RcIDZFZ+Spy1AoEn6vtiraW7mZtCMs5PhRdJ2Rr/73ZfOk0tKCfVr3VxrZxpRzmckDVwIydL+04RhkGuHBWOGR8M6DZb5R58kw+K67h8Sd0gO4B06rv6UljRzUmIhHO1RJhl72ocZV8di92bTJIpMUpQDNvwEGXE7975eU=
Received: from MWHPR14CA0016.namprd14.prod.outlook.com (2603:10b6:300:ae::26)
 by DS7PR12MB5813.namprd12.prod.outlook.com (2603:10b6:8:75::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Fri, 11 Feb
 2022 21:51:57 +0000
Received: from CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ae:cafe::47) by MWHPR14CA0016.outlook.office365.com
 (2603:10b6:300:ae::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.13 via Frontend
 Transport; Fri, 11 Feb 2022 21:51:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT026.mail.protection.outlook.com (10.13.175.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Fri, 11 Feb 2022 21:51:57 +0000
Received: from jasdeep-System-Product-Name.hitronhub.home (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Fri, 11 Feb 2022 15:51:54 -0600
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/11] drm/amd/display: reset lane settings after each PHY
 repeater LT
Date: Fri, 11 Feb 2022 16:51:32 -0500
Message-ID: <20220211215142.94169-2-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220211215142.94169-1-jdhillon@amd.com>
References: <20220211215142.94169-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 49894ef3-ae26-4e01-346c-08d9eda8b9ae
X-MS-TrafficTypeDiagnostic: DS7PR12MB5813:EE_
X-Microsoft-Antispam-PRVS: <DS7PR12MB5813143CCAF39D2457BCA123FB309@DS7PR12MB5813.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nG8ZD49BBr6LY7rF52YBkrkPmRxmF9C7+/LVYbDl5zUb6Wt8w9wGajxHulp8yInUQxIpm49gguWEAhk3plvamue0D6R04qhgWvpdyXGBSYML/lrOtEIzHhE08kMhazMawJT64Xu+axGqqGz8zAnreGwSHZ2zWS4v9Nf2vlXKa262rmiMP2xuNWTe8mMzRWDKPYEv/x6ow26Ltsmfp/HvzR60aW3Jzg0n1YbNb/kYOowurlR0wvhbXSU/PWS/Nt3WZG835x0e63z+E4ah1bCfqhgiwbmEgut+JRdpmTTk4+h+5G4qv/VSJwQTmnv5ohJ/BbbzaL8JuU6c0aK6MQyfOSCxxyymd2waF72tYtPwRRn6ctpptu2smUNiAtJzLqdJC3JFGvE4gY0CxNdG0HY2p3/UnDWo0Kbml5o75+gkrIIOdqyekTDvt2eioBj+bb/IsXtTRNrtHt8XXFrBsqhIr9H+xByQkbh9Mv5lvOze781CNCb6UWvWhQFHY/16p5IdSIx1eWwKPpkiPjhOjTqCCXOX2NQIeJ3Sf+UwFUeA6evo05qkCpycPvstdKjrNOT7bW2UtVUhA4zsxlCDw15Iax6z22gTmY2NPEhy+EMmuCub5HSlOi3w/wJArPlVjAbw/OdfqW9eCAVPE3ag4kFHlz7VQn9PbUu0Yrh/PVHiU/HnKmEPyjMbT1gkh8zLfExTeL1UbqcnV7tAL2FVBE07+g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(186003)(356005)(26005)(426003)(81166007)(47076005)(336012)(36756003)(4326008)(82310400004)(83380400001)(8936002)(70586007)(8676002)(16526019)(70206006)(508600001)(40460700003)(1076003)(2616005)(54906003)(316002)(36860700001)(5660300002)(2906002)(6666004)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 21:51:57.3251 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49894ef3-ae26-4e01-346c-08d9eda8b9ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5813
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
 qingqing.zhuo@amd.com, Jasdeep
 Dhillon <jdhillon@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Meenakshikumar Somasundaram <Meenakshikumar.Somasundaram@amd.com>,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 Sung Joon Kim <sungkim@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sung Joon Kim <sungkim@amd.com>

[why]
In LTTPR non-transparent mode, we need
to reset the cached lane settings before performing
link training on the next PHY repeater. Otherwise,
the cached lane settings will be used for the next
clock recovery e.g. VS = MAX (3) which should not be
the case according to the DP specs. We expect to use
minimum lane settings on each clock recovery sequence.

[how]
Reset DPCD and HW lane settings on each repeater LT.
Set training pattern to 0 for the repeater that failed LT
at the proper place.

Reviewed-by: Meenakshikumar Somasundaram <Meenakshikumar.Somasundaram@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Sung Joon Kim <sungkim@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index cd9c31b5e55d..d62b59d52ba8 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -2230,22 +2230,27 @@ static enum link_training_result dp_perform_8b_10b_link_training(
 				repeater_id--) {
 			status = perform_clock_recovery_sequence(link, link_res, lt_settings, repeater_id);
 
-			if (status != LINK_TRAINING_SUCCESS)
+			if (status != LINK_TRAINING_SUCCESS) {
+				repeater_training_done(link, repeater_id);
 				break;
+			}
 
 			status = perform_channel_equalization_sequence(link,
 					link_res,
 					lt_settings,
 					repeater_id);
 
+			repeater_training_done(link, repeater_id);
+
 			if (status != LINK_TRAINING_SUCCESS)
 				break;
 
-			repeater_training_done(link, repeater_id);
+			for (lane = 0; lane < LANE_COUNT_DP_MAX; lane++) {
+				lt_settings->dpcd_lane_settings[lane].raw = 0;
+				lt_settings->hw_lane_settings[lane].VOLTAGE_SWING = 0;
+				lt_settings->hw_lane_settings[lane].PRE_EMPHASIS = 0;
+			}
 		}
-
-		for (lane = 0; lane < (uint8_t)lt_settings->link_settings.lane_count; lane++)
-			lt_settings->dpcd_lane_settings[lane].raw = 0;
 	}
 
 	if (status == LINK_TRAINING_SUCCESS) {
-- 
2.25.1

