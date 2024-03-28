Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53CD3CD128E
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Mar 2024 19:52:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89D24112553;
	Thu, 28 Mar 2024 19:52:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RiknNqT5";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2045.outbound.protection.outlook.com [40.107.95.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17501112339
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Mar 2024 19:52:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BPndfZuSN5VCplQQIMsHtA2VMwaHeGv9C0zrQqPhfoMDNCDWzzrjMdDsmaTzEOwfSImNBWBDU/GOvHlzeXMtXH/jM5EVI2NhmvUkdENZjxN9uiGOJi8+nnb4L8Gw+W3punkjUu/Tl23PFlYViA5wpgTiCLdP5sDhG/QQFnPoF0/xYLJ7eUddWfjAShQjaRQU6C/Zp2qxslsmYMArKY+JpbqAgzlLMiLPAh7n2FKhx35sBK0QymeXEmKK6ltyhLN5AHeRdspCFeX9fOKl5n81VCQvYIkGLBFXNxO3RaW8mDGeFqBgDD7TuDWtURJno99dY+M9y+wMbqSORKjZ6OrYdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y/rKQ+7qj8V72C5EN0a3ZEdCI3wvPjz3nkzWhmI/wvE=;
 b=bDTtKEfCSWJdHQH7c203Wby6gTdSjqWkuZshj641eQ+/SGly/C4LzK3VRVfLU+euDd2eo4xcbedCX0YJIarkO9aT8gXCLnVWQrfwogRPteN0rppizclOBYqEbozCEi0SEISjeGv5m6EqBaav97F5CaiDHPkz5LDtcfjrHAs35z2JlGiflGHi3qyc9AZmigch3zIlysTiYmBb1jIAD3bi+6yr6srrgp/KXa93ccWovKS9C2ElCqTGzRVz7Khd1LoswKDYgC+un3uauXLl/DC/9kNT/wscoCQww/Fjx1LKAzqJItnATfrVBnjmLz2r/Ztbj5+tzwjKBvd7qWGaSXFbkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y/rKQ+7qj8V72C5EN0a3ZEdCI3wvPjz3nkzWhmI/wvE=;
 b=RiknNqT512eYIMG/tzGZR0U60guj5dsq6qpqbtaIhIbk5p5yeWJtMHlbGPYCS5DaZ6RapHw+2ni2lJ4f++5/X1JbMZvLgVMXP+sqVeVauOtkZBDKRa7bd5T8b4RUvovXI2pymQfJzALbPri7se2XWX9oQyqDySAgZnQoLNfoVMc=
Received: from CH5PR02CA0024.namprd02.prod.outlook.com (2603:10b6:610:1ed::6)
 by CYYPR12MB9013.namprd12.prod.outlook.com (2603:10b6:930:c2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 19:52:06 +0000
Received: from CH1PEPF0000AD76.namprd04.prod.outlook.com
 (2603:10b6:610:1ed:cafe::fc) by CH5PR02CA0024.outlook.office365.com
 (2603:10b6:610:1ed::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.38 via Frontend
 Transport; Thu, 28 Mar 2024 19:52:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD76.mail.protection.outlook.com (10.167.244.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 19:52:06 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 14:52:04 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 12:52:04 -0700
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 28 Mar 2024 14:52:03 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Daniel Wheeler <daniel.wheeler@amd.com>, <Harry.Wentland@amd.com>,
 <Sunpeng.Li@amd.com>, <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, 
 <roman.li@amd.com>, <wayne.lin@amd.com>, <solomon.chiu@amd.com>,
 <agustin.gutierrez@amd.com>, <hamza.mahfooz@amd.com>
Subject: [PATCH 30/43] drm/amd/display: Enable cur_rom_en even if cursor
 degamma is not enabled
Date: Thu, 28 Mar 2024 15:50:34 -0400
Message-ID: <20240328195047.2843715-31-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328195047.2843715-1-Roman.Li@amd.com>
References: <20240328195047.2843715-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD76:EE_|CYYPR12MB9013:EE_
X-MS-Office365-Filtering-Correlation-Id: a42f6900-983d-4161-5e2f-08dc4f608c33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N9eZbTGhdSThT5KfUD5eSwKTFm8QGlWzOWtD6mdboWcdSYeAAc4QVNszCK4HAF1Ikv00T0+X8xE7LA4YshTYCRAwh14zYAd1ZtHqI5kIaN1+VYmFZVUEkaYD103MRypzY3F+Z7zVSREgpZXJtRoQRioWUEB2iAXY99t7mSAQu1llj4ZTl9JxoxKOe3h+ZXQ7YrjMDGVTV6374Xp+XoGQN5Em9w7nlrc+pWWmJkm9Gdk0N0OZagR4LJCCG9EFZEluX1ie/zdbJ/zDPBLwQh5GppLAUhzqXTgOWjR/Ipw96BYtAz7gJHaT0TgKi87sA5wkh7BJqiiplW4bgpH3SSZgzio7QsoAgbQwQz5t+6DDHr5JevQMCoaQOqWnOU5eEJEXE2MUvR20OkCY92oTISfLT7g6sYTCh9G9WiKCID/ii8Bafc1Q5v/9iBSAyCOXIiQWw9nv/Zs3kjG6hpu0ykIP+r5/8cVWRHBJdxfCx8ogDvF416nuRRVxfFyGXxVwsjOfO748EbovAccL7JLNP1Aus4540nHPL6Jz/ZSr5LoiwWVz6dLhGWMADUWttYM+shqzkvNKu5zyWENYxumD3+00Wc4bPV7jWo9e5BzX/uIpkeM3pNcGo2F92ljg7gQb42SR6DJxQTAnowqHSrLUS/t41oNc2k7Zc1cwsjGCLeGejZCta2LIK7bXUGQqcxofXx87ibnNXL9M0sR4Xs/nsUY+VUTTXF9v6dTtcjutb08eAK0+Mpe/4PW+uKHPe39+1enu
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(36860700004)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 19:52:06.5836 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a42f6900-983d-4161-5e2f-08dc4f608c33
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD76.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9013
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
index f8c0cee34080..ed1e2f65f5b5 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
@@ -395,9 +395,7 @@ void dpp3_set_cursor_attributes(
 
 	if (color_format == CURSOR_MODE_COLOR_PRE_MULTIPLIED_ALPHA ||
 		color_format == CURSOR_MODE_COLOR_UN_PRE_MULTIPLIED_ALPHA) {
-		if (cursor_attributes->attribute_flags.bits.ENABLE_CURSOR_DEGAMMA) {
-			cur_rom_en = 1;
-		}
+		cur_rom_en = 1;
 	}
 
 	REG_UPDATE_3(CURSOR0_CONTROL,
-- 
2.34.1

