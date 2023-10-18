Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C371CDB482
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Oct 2023 17:44:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19D6A10E456;
	Wed, 18 Oct 2023 17:44:16 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::615])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B64FC10E44A
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Oct 2023 17:44:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oct22ZJ5/3rN4u1imRSWnj4AXeSb5Rtvr/GR+opvIDLRck4L9GXfH7jJMcTcZV+KyERUXkuD8C2cFWe4GL6n8Oad2xNTkx+1r5pzmHTHa1AgqRx2UVVmn6MNj9ENAmxP7FLng2RSl0T6UyAfXOcxvDLXFQBKdBljg+dIAMi17OVQhYnehvsYJuaPIrXQlZFmblRvyZUvN4pMgu1Dknh6rjlTgnWexZfi0f9kZYDoji2CAGEZxf+fFtn3+yv511pu/Y+V+atPZzFHYwSfZeFh6LRanCquJqbrpfAoQtcjR9sDxvHDBXA13WdbGIcceT9j3WePZ0GjF83VEEEhJczliQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RmVpHqPFS/mUL45RycBUiyWY5pVdKPg4CddLl31vYKo=;
 b=U1lN5qvzf4J3hwMdgoK3AT0BeCFBzNDZEXYIrgL5Vzl1/Won3gg+QMZKSdbv6yjcZ0CFQpGJ+jz8HjAEouBV4R4BMzeYth3stUONoZVtoDc2EfEopx/2liLR3ng61NpNLy19lRxB7rRQchf91s+Ln4FeiHPdVhKbVZ6bms73V77IxevuRBbVEmmrLsljm5k6QwwYWQLRRKLeIX2NQPxwEgM+a3YsX+Y3qYuOIOpNRC0uU1pYFvQYbfjSNU30vERMYsTpQa+ZHj5dAbP5/cy7Tm2yK/dBVfNAhVpfH8jsyHtu5P69mTU/gAa8z+3jYsHzcHuqIfFboovA5B0JTMr9KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RmVpHqPFS/mUL45RycBUiyWY5pVdKPg4CddLl31vYKo=;
 b=34QSGQmLf9AJ06X70S1R0D77xhCwmuCEMsArdbH8wg3v2mdylwCp5+v0wl6L65otP+ZhiVLd5qUZBFMUf5dtiqmm1NR4W6iTJpuen6ZF78ZHpcexCOb61bnOGyicth98pDOPWQu1Wm7a5JdcdYJPWZXVxziNxDfZ2dGucu29+qQ=
Received: from DM6PR17CA0008.namprd17.prod.outlook.com (2603:10b6:5:1b3::21)
 by PH0PR12MB8031.namprd12.prod.outlook.com (2603:10b6:510:28e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Wed, 18 Oct
 2023 17:44:03 +0000
Received: from DS1PEPF00017092.namprd03.prod.outlook.com
 (2603:10b6:5:1b3:cafe::4) by DM6PR17CA0008.outlook.office365.com
 (2603:10b6:5:1b3::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23 via Frontend
 Transport; Wed, 18 Oct 2023 17:44:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017092.mail.protection.outlook.com (10.167.17.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Wed, 18 Oct 2023 17:44:02 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 12:43:37 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 12:43:12 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 18 Oct 2023 12:43:11 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 23/26] drm/amd/display: Disable SYMCLK32_SE RCO on DCN314
Date: Wed, 18 Oct 2023 13:41:30 -0400
Message-ID: <20231018174133.1613439-24-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018174133.1613439-1-Roman.Li@amd.com>
References: <20231018174133.1613439-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017092:EE_|PH0PR12MB8031:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c3ecd7f-569c-49fb-32ab-08dbd001d167
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pt4e//odFD/OBg36gKG7EGmNSOKzvJwj/yWTT7HCHjlxuFARGpdR2Rn35sRY1zyPs/p66KuAqBk/RKyWMJNkrb3EpX/h78J76wS2xZxub2EUOsto0YVdgcT/U4/1GwaIAiiC8Rn6fIeDh3x0lPFeIv8Ve+o0JTfXaDyyFj4+pNva1l0bYelNdwvQCZF4jGd1HF4objo0QwnThghnd/Aw1ted760jJ5U+CkUkvFR/BRq/X87gGE4HT1dQzt0t+o0p10GB6yJsF/fNeKunBY3Af9u+eo0gu3LV9npo7XIBb8KUcM6g0xqFfYCkFZ+SQBajXEqmF4T5+ee+7KEI7OfHbALgWX3raZrCZLgNnwDlJq3eZp84yizEhfRIE367AS/tRAXFSbNDgfbrAQuAGO5C5E20Haz5P3b29Y/zFMOtZ6YT6dcYSEOzQjjZuuhjTLJmCPHM4rbu+wOylbK/kxcyO/p59MyggY/40O1kF7sJk2xZVsfTcp3nXKuoWrOk6lKtoqzWeKLVU94agTa9T3nlUYxX9Sa4XiVsI9HlFhHrCeuQtK6zt1cOahwY+LB6I2lE/R0x7/wrAsHl42ytKjSnIaLsLoZOG0/OXXoPkjl+mDwuUuCXTArcW7YeVMFhHJZf1QVgrH3BE+n4IZHh+qyvMun8pK95QyFSCHqXn2Hv1ySgVdqX0uh6EL3uEyCn9DL16iu6+++WgCin98yy/9OdZu379Wb4w2p6HP2tFluQUBAg9utQZ0ltDmlO+uyYwZQa95fgJ5aM0WdOx38UKyibyg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(396003)(136003)(39860400002)(230922051799003)(186009)(82310400011)(64100799003)(1800799009)(451199024)(46966006)(40470700004)(36840700001)(82740400003)(336012)(426003)(26005)(356005)(47076005)(36860700001)(40460700003)(83380400001)(1076003)(4744005)(5660300002)(41300700001)(54906003)(8936002)(70206006)(70586007)(8676002)(4326008)(2876002)(6916009)(86362001)(2906002)(40480700001)(478600001)(6666004)(7696005)(81166007)(316002)(2616005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 17:44:02.8553 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c3ecd7f-569c-49fb-32ab-08dbd001d167
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8031
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
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com, wayne.lin@amd.com,
 Michael Strauss <michael.strauss@amd.com>, Harry.Wentland@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Michael Strauss <michael.strauss@amd.com>

[WHY]
Currently causes some DP link layer failures, backing out until
the failures are root caused.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Michael Strauss <michael.strauss@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
index 2d7436f2ea82..48bd56ca729b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
@@ -916,7 +916,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 					.hdmistream = true,
 					.hdmichar = true,
 					.dpstream = true,
-					.symclk32_se = true,
+					.symclk32_se = false,
 					.symclk32_le = true,
 					.symclk_fe = true,
 					.physymclk = true,
-- 
2.34.1

