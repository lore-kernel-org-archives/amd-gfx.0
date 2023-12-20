Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC4BAC3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Dec 2023 16:37:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4373010E5EF;
	Wed, 20 Dec 2023 16:37:09 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2761310E5EF
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Dec 2023 16:37:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uh27/xrX10MEvD80fd7wDJCJxUcFt5+ed+sIKp09ZS7AOd5xPd85LPTUyNQ9ZTpX7tW/fCkNANOPjr8YYEvKv5GgO5KeqfCm/1uxDqlJR9GQ4xf5BUzEODYO++ZkJ7kdAgnhZZ4S/FRBUTJbdbw41BFk0OtBbXIX04NtnuHM7yvpE7TiwvygGiMQzjuJLEfh67s66scksxMKucG3z34vlj41hzh0bS+fZkdVNlpGDU1hnqDhQ4gIYNQGr2WJARzDYP39+qNvQ1J0ZkBo8TbmsClRZCeaFgZ3cKlhmkgy3Y/CRVpnKRqPc/5q46WAlBGig/nRezUMCGtAAhOrUMYaPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Prsc5vEmwMAQ04nRhmpQ0gBcgZuSKbKutnG10/lQ5g4=;
 b=QO6v5TC3g8GB52PS7upvwVSlCQUwQV838U42jFbEtEbnZKuzSQE8CT/3IMcSuP76IxL58PyPfj2mnODEnCWRO0d1iyh+JoJUAXfjs3YmqxRU6v4oNlu6LmQMQT+CTRuNRZwrIXrS9QWHU2Rxkys+eha+KQjNogZGJlCgI7eux9tEchO/9mFfK5pwkGz8ntHxjp1hiD6ph3MJOw/B/0nF0FqSPmNPGGG46tv/NTakC07NdZSEmAHyhXfB/TCb6LCaKC9FG4nYoplP3cjMDwf12AEss/3qP+/y7qYcVOX3u5DJXenmKew8hvI7B7WR0z9MCST3CfDhK6FVc9XlyvJcCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Prsc5vEmwMAQ04nRhmpQ0gBcgZuSKbKutnG10/lQ5g4=;
 b=pGpiGsMsA+zJYJmhzKxT2LL/tYrernV3PBG1XecL+yE2uBhyMRfumEZPMbSOTkx6kOeNiC0jVV9VznPgQQnszMBy60xQLMoel0DKg2WZycGrWT7M23ETNZzfK+W17lHPL8w3Ve+HDZFQMAZT+UQRVdcVx/jORyemyClQp6tmJZQ=
Received: from MN2PR16CA0061.namprd16.prod.outlook.com (2603:10b6:208:234::30)
 by MN0PR12MB6175.namprd12.prod.outlook.com (2603:10b6:208:3c4::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 16:37:02 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:208:234:cafe::34) by MN2PR16CA0061.outlook.office365.com
 (2603:10b6:208:234::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.19 via Frontend
 Transport; Wed, 20 Dec 2023 16:37:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Wed, 20 Dec 2023 16:37:02 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 20 Dec
 2023 10:36:59 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/20] drm/amd/display: Always exit DMCUB idle when called
Date: Wed, 20 Dec 2023 09:33:43 -0700
Message-ID: <20231220163538.1742834-12-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231220163538.1742834-1-Rodrigo.Siqueira@amd.com>
References: <20231220163538.1742834-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|MN0PR12MB6175:EE_
X-MS-Office365-Filtering-Correlation-Id: cbc14a8f-dbbe-4671-cc19-08dc0179e524
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d/hmBHShW+srXq5iVy170qN+RIDkGa7FAx0pbL1jA5Czg56An+66C0jD/0PI4YGOSz+vQCC2Jym89lHnz49RlmPjcu1ENnQhATJ5XCrs89wBMU7kdsfJQNiKNkDyD3WO293egqqcCJerZSjN2vWF/9YMMZVTWECiexqniwF5XWmJwONrx9MeSZTuvdnFRsVdQtXx0gvI8nIsB0de60Biixrtr11iW1+pWKTEIkWDy/aCU3BfZ0IIKIDdVLZ9osQBbKipcq6+2h7rVS4ZfBHvODV8kZ9orj/nmSYf+c3ff9vKOry+t3eonHd/xR35TIjrXnDa7CME9PATuxwaM5hIj9/iNHtZI1TWe2ZyPga7jVYsIiMFGpj3+/S/ec4X9rtcBJ9YwEC43Hn4Fj+XvgK4fOhALHflH3ZcpSXXU6aXzOLJ/rwSypJ6YWIw/OVniV9q9tlmFdhlI7OX3wZPljFBUIuB19y8Qj7hQQFA4iRARb091gc93fWow5xhjcviYEgqwjBIaJvlhBLsZlolvS+CpKXvZjnQI3vS9yYPpsspz0VM0pJA9rMBvDMgKjIDUkvwFIqDxLtEEQX/WLNGlp+TlTaVO0lqYZJjWu0S2nfjqRj/1D8J7R9y2qWI8Z+nj4QE1baPQ2NlF00Fuli2cJufab39arhRYe/jdwkTF2PInVAPtXJjm8Lzozs2MS2xJmuEiXZZNH7DauA4HsA/lVWxs6pRHCqnq3jEQl+Ydx5q9bgOtrOgeOFBLhYBE+wmLh5iFlg+qyqRilcgfREFfce6JQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(396003)(39860400002)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(82310400011)(36840700001)(46966006)(40470700004)(40460700003)(6666004)(426003)(26005)(336012)(2616005)(1076003)(16526019)(54906003)(47076005)(41300700001)(83380400001)(5660300002)(4326008)(8676002)(8936002)(2906002)(478600001)(316002)(36860700001)(6916009)(70206006)(70586007)(4744005)(86362001)(82740400003)(36756003)(356005)(81166007)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 16:37:02.6363 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbc14a8f-dbbe-4671-cc19-08dc0179e524
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6175
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
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, roman.li@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 wayne.lin@amd.com, Harry.Wentland@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 Sung joon Kim <sungjoon.kim@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
dc->idle_optimizations_allowed may be desynced with the hardware state.

[How]
Make sure we always exit out when dc_dmub_srv_exit_low_power_state is
called by removing the check.

Reviewed-by: Sung joon Kim <sungjoon.kim@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 1d315f7cdce3..4ce8ac966cc8 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -1222,9 +1222,6 @@ static void dc_dmub_srv_exit_low_power_state(const struct dc *dc)
 	if (dc->debug.dmcub_emulation)
 		return;
 
-	if (!dc->idle_optimizations_allowed)
-		return;
-
 	if (!dc->ctx->dmub_srv || !dc->ctx->dmub_srv->dmub)
 		return;
 
-- 
2.42.0

