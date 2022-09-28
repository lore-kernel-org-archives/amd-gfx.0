Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74E47C32771
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Sep 2022 19:42:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70D2210E9BA;
	Wed, 28 Sep 2022 19:41:54 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9986310E9B7
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 19:41:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iIjVoVY8W1eXqO5o7O3+UMYTTpXBhPSr+ZwiTiNxdJLbZQjl3qu8uqlfXE2rtyiFlECxY03M9RICX3NzLaKlKjncKx7HNFeXb9NZlOLRe7wNoAixugtVhMgQ1oZycy15HQHbAJVkLOPV6Aj59vY9uljAJ6tG/5MJYjRD89wquVFfppzfgQt8gG5djDYjxbEbEeMCXFnXY7rTiOsohFPGNH0CPPhAZL0jp2ZBmUl99c5dqYLiPnEaL5001TFOHMi5k/p7okefTf18Kvx4aT76ikT5zwe+DuvFd08MMbUXldXs+7J2kFICeyN1sTxAqWP0bFV81b7BpAVxiwmT5mFkzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w9w/3KQKtb5VVjBbGiZPoLGG8FCUPwL+RuUuhKpVcdk=;
 b=AW9+W5dM0qx+aUY6ZE/aQ99gahePLrQEYQL8AaI/xseDcrdHFy6DRd1KVlABLHBpHI+iKL7eeuXdA1jmdxs4sydYAKeEel3Fhf96TVEn1fg3SkBo2K9/ld8+3i3oCYptwFQOD4eJUMKY6Xp2zPJwefpANO4fEUU4MJ3k0LGBb4Xo8YPMXFfR+HpvVfklzRDfvf97PScr/PQEad/0DjnFSLAkIMzHJcD0I2q/bN7rRPIHec0BN21SH3CXCLrJtkYL85qaKnoNlO+NPpJ7Lk1uQAXoLaCHepMLLaydX4WzsxyB1ttKjDzLOZtn9K7Tq73Uxhn3oEFNAg2MBk+hZIEScg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9w/3KQKtb5VVjBbGiZPoLGG8FCUPwL+RuUuhKpVcdk=;
 b=Vk0/sCPhXzC5+ONj2gURL6BFF7HmqXzeV0hLpuxI/zk2NOtpuM7qbCd3T7czwgAZZ5l2FaRYkcvj96AS7h1vwJaSaVVor9vKySlIg6rZn9XMlobE7bbzKlO9p1GO/sk8EUy9k3ai2L5ov939Nef/T0XgHXJLWjAwn7S+8JEP1fg=
Received: from BN9P223CA0022.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::27)
 by PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24; Wed, 28 Sep
 2022 19:41:21 +0000
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::d2) by BN9P223CA0022.outlook.office365.com
 (2603:10b6:408:10b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17 via Frontend
 Transport; Wed, 28 Sep 2022 19:41:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT054.mail.protection.outlook.com (10.13.177.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 19:41:21 +0000
Received: from hamza-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 28 Sep
 2022 14:41:19 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 20/36] drm/amd/display: Fix merging dynamic ODM+MPO configs on
 DCN32
Date: Wed, 28 Sep 2022 15:40:12 -0400
Message-ID: <20220928194028.144879-21-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220928194028.144879-1-hamza.mahfooz@amd.com>
References: <20220928194028.144879-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT054:EE_|PH7PR12MB5997:EE_
X-MS-Office365-Filtering-Correlation-Id: 94cbd0e0-e745-4132-137a-08daa1896b7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /zptuNq/ZQxpVdKOgQ2BXdjPeU0yIpu9/mkIl1L4gtktRUzdXB3V75Di6ryY/H1SsmsfFN8/RMt7UVgF+JWSn/rksIAAM5dNb+EadIb/k2Q5ylZdHSd1iQPysSCPGj2D2bPoUgW9NODU1W/HX5t9CAWovs8LF4Tn+1xDYrFCzEZRwkqCZBoa8uQ1VfKen6TmiiwEG8uWip3qFB7m4etZ0yAUvj5EG7LQbXRhEJw0PoYZWZQMj+wwhn958NRtPwS0QvwOn9J2I3zukQlApA9D1p/qsCmBKak8yZUVJld4wFJnjBEpC8M4Pqj6q1Tkpa0GJjsTUSLVRBkKGgUywPuvfHo23AHAG4Yv1YOgjE6IDd5q347CjCtsqlkSmotnEU0QOS4M91Bhz9UOIWFym1k2/m/FKfT/dCH6kPWdmyKHAdudTuxD2uYZdEhNL4eQFQ+Owl8FuSR2L2E2T6kXlOebz6V0pygwZ6YXGosOFeVnkZQbEF4NMdBUMwDKQXdu1x9JPXytDSL3TBQREFJRVK8kgcGc8s+FFqOTlPBT6lrS1g5+tunePai0XH4WroR4brs0SfvrLj6ziq/uTqy0BFQlDUYPJmuZMlyPRF9ry2Pj7wz+xuW0BjVkxo1vxKIHferE7PEKkwotKR5djMuhff80lwObf/mW5kivcOtzXO4BvnKGAUQ6xVQ2WmWf2qvNjrJgq3iiLe6bvzJeiFD+w1EQhmPHaAt8t67MTE86NaG2N4PLDAv4hlE1J3ku5zYGiKcVQulLXUrB2RnQAWxw7We6qEJFfQy3tr68z8KG37ViKmoSCxe3v0hOGFrRAFbBQMnWI7PWn818xEccgZHf8ygQxw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(39860400002)(136003)(346002)(451199015)(46966006)(36840700001)(40470700004)(316002)(26005)(478600001)(7696005)(6666004)(41300700001)(44832011)(5660300002)(6916009)(8936002)(86362001)(54906003)(83380400001)(2906002)(1076003)(336012)(426003)(186003)(16526019)(47076005)(356005)(81166007)(2616005)(36860700001)(82310400005)(70206006)(70586007)(8676002)(4326008)(40460700003)(40480700001)(36756003)(82740400003)(16060500005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 19:41:21.1672 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94cbd0e0-e745-4132-137a-08daa1896b7d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5997
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
Cc: stylon.wang@amd.com, Dillon Varone <Dillon.Varone@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Martin Leung <Martin.Leung@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Hamza Mahfooz <hamza.mahfooz@amd.com>, wayne.lin@amd.com,
 Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dillon Varone <Dillon.Varone@amd.com>

[WHY&HOW?]
When merging ODM pipes that are using MPO, we must copy the stream_res
from the new top pipe to the bottom pipe so that the overlayed plane is
not pointing to the wrong stream assets.

Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index a56ee04f7df9..f3f98e9a0ce6 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -1598,6 +1598,9 @@ bool dcn32_internal_validate_bw(struct dc *dc,
 					/*MPC split rules will handle this case*/
 					pipe->bottom_pipe->top_pipe = NULL;
 				} else {
+					/* when merging an ODM pipes, the bottom MPC pipe must now point to
+					 * the previous ODM pipe and its associated stream assets
+					 */
 					if (pipe->prev_odm_pipe->bottom_pipe) {
 						/* 3 plane MPO*/
 						pipe->bottom_pipe->top_pipe = pipe->prev_odm_pipe->bottom_pipe;
@@ -1607,6 +1610,8 @@ bool dcn32_internal_validate_bw(struct dc *dc,
 						pipe->bottom_pipe->top_pipe = pipe->prev_odm_pipe;
 						pipe->prev_odm_pipe->bottom_pipe = pipe->bottom_pipe;
 					}
+
+					memcpy(&pipe->bottom_pipe->stream_res, &pipe->bottom_pipe->top_pipe->stream_res, sizeof(struct stream_resource));
 				}
 			}
 
-- 
2.37.2

