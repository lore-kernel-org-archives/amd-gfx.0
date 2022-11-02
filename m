Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EE76C433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Nov 2022 16:04:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71CF610E4EC;
	Wed,  2 Nov 2022 16:04:30 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2057.outbound.protection.outlook.com [40.107.100.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 309F910E4EC
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Nov 2022 16:04:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i0Nt4LwSAgl+MOwlZSD+cQarEJ5r3BcOmEhLtS5U70RYeAyctoWc4259HlodAAdQ7257tsz4Sxiq+D/ib01fRzqoTk7lhv92H9L/sk8hfl3WdePJ3g5q2rwxDQvVs8A1HRHX/tZirEcS439j3saiQy7MFhLARSoLSmA0yYz9gGIKn+3/aS7dlvaFuMT1yo7H1PfYf9aCgkGRQXfwU4rIC72IMeNdpd15YXHDc1nyN9alJjA5q9attQmh3OsRYf2vE9edJpHQPxqdUQ+jUBFenAjsfhGP2yim6ULP3qFm/QEN9IqZ/6xKD7gPKIWq8WLqk/0nobSDi0RtU2h6RblFgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/qxWlqTln7/PubxU0PVqTLq8UnVRVe0UvPmQNamp3XM=;
 b=YoXN9njH+C+upjg8H5Zg6yKjfmW3D+wx0K6H0eZBcPg613pHPH11IaSbLYV9Mf2WV+eGs1GmGNzhhNiohD0CorByC8JgzGzx3CVH2re7HvpjGu2T077I+LK8Tl25oAEc50tIZgq7h7ZOpmsiNRDqNgozkpbUzo1ZaI7b/r0DmaMY9O2l63elMN62J/q2J5LJwUgBhhT4pq/QcMbAMzX71rUvUoN3qHMK2EW22UBLzbj8vsK+eLri2EceNV+dGz7dr6hLsdQaxZ+azTZEcmm5Y4ZAb8eZ7fFfuiFFFTKQSzAnMVBAouEA+dilh6KFsUBvGVR9UN0wyTQQ9Lp8cMyzCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/qxWlqTln7/PubxU0PVqTLq8UnVRVe0UvPmQNamp3XM=;
 b=MfYK8TddSCQ1MNSw2MdsWZTHpY5VDb17VZN6mR7ZGzB4sBpheva8yMGBL7J8yVm7cfjCVr59fTgSA+i7JyWk0/b8oG7Uqzq+plsL8Y/uTEQTvCD+73n8MHF+ptTTZmu53UOtwHp7ExLnMHXRmTalk7D5lO4b7b/PgWzB9WNSG+w=
Received: from DM6PR03CA0089.namprd03.prod.outlook.com (2603:10b6:5:333::22)
 by DM4PR12MB6568.namprd12.prod.outlook.com (2603:10b6:8:8f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Wed, 2 Nov
 2022 16:04:22 +0000
Received: from DM6NAM11FT074.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333::4) by DM6PR03CA0089.outlook.office365.com
 (2603:10b6:5:333::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22 via Frontend
 Transport; Wed, 2 Nov 2022 16:04:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT074.mail.protection.outlook.com (10.13.173.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Wed, 2 Nov 2022 16:04:22 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 2 Nov
 2022 11:04:21 -0500
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Wed, 2 Nov 2022 11:04:17 -0500
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 19/22] drm/amd/display: Set correct EOTF and Gamut flag in VRR
 info
Date: Thu, 3 Nov 2022 00:01:14 +0800
Message-ID: <20221102160117.506511-20-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221102160117.506511-1-HaoPing.Liu@amd.com>
References: <20221102160117.506511-1-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT074:EE_|DM4PR12MB6568:EE_
X-MS-Office365-Filtering-Correlation-Id: d7abe04f-331b-41eb-0113-08dabcebe818
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +KoyL9GXUXBWXTA0fWYIRjhg/U8glSUOW37N012v5znH91WKHq4RSdYUQKdcLSDhOTVRV3yB7Nyf2prCnnKQJbC0UPlbsyWElL7bekRmil7Ol1DDly7oCFZp2WqrrvBSqFn0ChBfykQUyi7Caovs1rUo0CguLK1LxM7IzHkklp6gCJib1gWyETjBbun2otWMU7SPbVsJ00a/CqK1M+J9qN4fEVjQtImv8UiwgL/9N3dUV7C9xqDg20rXpgoHnHuGrxS8VB9N9JMq3CQm38HXElI1X02BYUCUV+BKjWFA46k3OJauGwk/rY+nmriyxhZwaXndzwKoTFBLAuMdEBXRS9tJ2c0Keb1B0NVfEHMGdXiBDxfSsHh5JWp2uIqdtBCEtz/gej55icmLbFqW657c/ydVp05ZQGWjSWP72ny9rj+K/KdDhc+VL84igXg7w5WH5lV4r2RH+9D0Vy429S4LqSkEEVSXdYLWT4CmF9QuDV0up+SZ+2ei3umZ0hyzaa6w+XzTn1WJnIzWRPTTJ3v/2SwJILc05af3PIWoA9i9eb8LfzLwKtqq15zbvUaeaVjtV/skmWzpCi0fychh78vo2lXHORfw0Z+uHbenKmIRUnBaKmWREJhcdyN3Xa3fP+bhe6D9IJkvRWn1utW/TYUHTyAsHPvkNCJgXmt/ntw3GBhBkU5xhEfqzsC054UydX1RKivh/rVZNNCZJukf3gDBQufnb8TmB/sTJUG9lxHPcLqow6VfJRQ+OPNX2dckHbtFJV6ngaZQSkE3sLG7Phzkdapr+ppojXEL98QrLwkU0JM4GPTMzQgmUziXvJHfWqzy
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(39860400002)(346002)(376002)(396003)(451199015)(46966006)(40470700004)(36840700001)(36756003)(40480700001)(81166007)(47076005)(36860700001)(70586007)(82740400003)(5660300002)(356005)(2906002)(83380400001)(426003)(86362001)(7696005)(316002)(478600001)(336012)(186003)(26005)(41300700001)(54906003)(6916009)(40460700003)(8936002)(2616005)(70206006)(4326008)(6666004)(8676002)(82310400005)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 16:04:22.2789 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7abe04f-331b-41eb-0113-08dabcebe818
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT074.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6568
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>,
 Mike Hsieh <Mike.Hsieh@amd.com>, Krunoslav Kovac <Krunoslav.Kovac@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mike Hsieh <Mike.Hsieh@amd.com>

[Why] FreeSync always use G2.2 EOTF and Native gamut
[How] Set EOTF and Gamut flags accordingly

Reviewed-by: Krunoslav Kovac <Krunoslav.Kovac@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Mike Hsieh <Mike.Hsieh@amd.com>
---
 drivers/gpu/drm/amd/display/modules/freesync/freesync.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
index 0f39ab9dc5b4..c2e00f7b8381 100644
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
@@ -688,10 +688,10 @@ static void build_vrr_infopacket_fs2_data(enum color_transfer_func app_tf,
 	if (app_tf != TRANSFER_FUNC_UNKNOWN) {
 		infopacket->valid = true;
 
-		infopacket->sb[6] |= 0x08;  // PB6 = [Bit 3 = Native Color Active]
-
-		if (app_tf == TRANSFER_FUNC_GAMMA_22) {
-			infopacket->sb[9] |= 0x04;  // PB6 = [Bit 2 = Gamma 2.2 EOTF Active]
+		if (app_tf != TRANSFER_FUNC_PQ2084) {
+			infopacket->sb[6] |= 0x08;  // PB6 = [Bit 3 = Native Color Active]
+			if (app_tf == TRANSFER_FUNC_GAMMA_22)
+				infopacket->sb[9] |= 0x04;  // PB6 = [Bit 2 = Gamma 2.2 EOTF Active]
 		}
 	}
 }
-- 
2.25.1

