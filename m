Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE2EC433FE
	for <amd-gfx@archiver.kernel.org>; Sat,  5 Feb 2022 01:51:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6B4F10E414;
	Sat,  5 Feb 2022 01:51:07 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43B7F10E414
 for <amd-gfx@lists.freedesktop.org>; Sat,  5 Feb 2022 01:51:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XUhBmsIHhkmV9d6O49JkxIWMHVUoxquv0Eu+m4aSGADlWruKaxvmDcRz+MPSq/jBzUkLXPezJ6aIgQSznG9beLuMB25EAng04vudFBnJqqUO4YnKG/o5kC65ucYLOh827U0OJ9ozFQFIn7b2oV7I6xz0kBvJj3sA+aOmVbts2MjPXp6qFqBAPU7KOvCy6VP+pDD0Cc+dBQwQVh3qm5AEGFYCoifwiSSlk7WnCbxDGuJVzvO4kBn2ggG+0EI7wzRz42MJUX0SeAHV8pmGPbFaTpASfkVqDd61ku8sDiP2Id/9fJQPWHxPKWWSdHb0KTpeqYbYMndwiUutMLh8URtgVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nUMVssbPtUOOK/chGXhbNaR8hUXUXkMl1iOc6a+ycF4=;
 b=Feeq3PJIZ++nFM06mp6KVgIOrp/Ji0Kaf+AarkWmmKAqoVoidyl1k3+MPboY4JP70jYSmjfSzCUI9aDWBGGtehzfOzqHCN7Cc1n2YDj+YTrYW2wmUHdTZJiun0KDNQylfjOx4OPKCLLNFZmWKMdTC7Hnmci15ZJOzqm3w3njlbwdGC7UAjIPGE9zfRp3rD+XqcquTUm48h2W0haDjful/ryQIuJGz6cNa5oY23hx99eOe8yr/Y/POxvqHE27kUeznCK4IOAt6HPQ6q1rgQQ7RpY5xsIUpK1Aez/eTcA88uOJ3Oj372DhSrzu2a6yHb/uKh68XKDk81l6jJLs/1jKfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nUMVssbPtUOOK/chGXhbNaR8hUXUXkMl1iOc6a+ycF4=;
 b=r3INv2kphh9USdnuNZ4Ey3MAXPZXShTyguPJIPsS0ekm4K0ggaYVCGuoFgY0wghetjae2PvWCYxodALBfzkwoLjAER36kC4gsJs+Z1dSWJzXpTtu407IUABKYmyB2g/VqhNuCBp4o0YLEA/5GHfFxxzV35Ll/OPnzEogag8p7E8=
Received: from MWHPR1701CA0011.namprd17.prod.outlook.com
 (2603:10b6:301:14::21) by DM6PR12MB2779.namprd12.prod.outlook.com
 (2603:10b6:5:4f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Sat, 5 Feb
 2022 01:51:01 +0000
Received: from CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:14:cafe::1f) by MWHPR1701CA0011.outlook.office365.com
 (2603:10b6:301:14::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17 via Frontend
 Transport; Sat, 5 Feb 2022 01:51:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT035.mail.protection.outlook.com (10.13.175.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Sat, 5 Feb 2022 01:51:00 +0000
Received: from jasdeep-System-Product-Name.hitronhub.home (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Fri, 4 Feb 2022 19:50:57 -0600
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/14] drm/amd/display: keep eDP Vdd on when eDP stream is
 already enabled
Date: Fri, 4 Feb 2022 20:50:24 -0500
Message-ID: <20220205015029.143768-10-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220205015029.143768-1-jdhillon@amd.com>
References: <20220205015029.143768-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3500ac48-1648-49fe-0d80-08d9e849f63b
X-MS-TrafficTypeDiagnostic: DM6PR12MB2779:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB27790DC91D7AC31440901CA4FB2A9@DM6PR12MB2779.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HGkk5+MaGvsFjpDmHZ6BDF4YSWAV9czER6yKaJuX5UZ5Wx4FqBnIoD7XwzSA3oTKcZ1k9Shm88i2Deo4Id2wUYxmoew6HW5rkpH1JdNTXcVc2dm+jBHHx+tk6RUtBUnudKZVuVEvkvpM+JlIyUadnAwJERS5BixmguXfkk8jKnI89R7a9O5KrwiieTfhmNFIija8lP7mF9b51I3eGdj5EGPdS1QH7vUJatqCuD09ePVmUwryrtxtEqnnRrwetXesu7ekvctbdOkyawByLunRr+A7Uftdrrfl524kjMs4ElVQjs4WBfmJkFJXqY4yyYxFwkKK9pMoMpShmXqv93j0lc4nvfbNaZInXJTZZxy0M3z65wA6DtS/eFoYrQVZwLZdbtwvfLGj0XYqLNoAw4CqEblCmpP5UlMRnp2E7AFuCIIMWJ/fUkru7kM5+OLMx1skM8A8208ue9cEigGDRmqEO5HikSuBSu1KpNfzJPgHxz7kiXR5q7L8vgNbdLuMS3JKz2QmiM796zxz3WgDOChH/9G6o7ECjFE9PyzYXVESmV77Nr6QbEx+4f6DVfwZ9nYhlUREFafD6ip2Z17GQQt5h6nHxLYdlFoG/6MDH+AfrSmMvmjjgezFFZYfF+09Z2D4GgQMKkMC7Nt0bze7oK7z1S5zJYO+jWndecYHDf90afl22ndal3Gb4w+qsw0gTijG6EIDXeSNMwWTiyl6DBsDwg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(70586007)(4326008)(8936002)(356005)(70206006)(81166007)(5660300002)(16526019)(82310400004)(8676002)(36860700001)(316002)(47076005)(2906002)(54906003)(186003)(26005)(6666004)(2616005)(508600001)(36756003)(83380400001)(40460700003)(6916009)(336012)(426003)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2022 01:51:00.9082 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3500ac48-1648-49fe-0d80-08d9e849f63b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2779
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Zhan Liu <Zhan.Liu@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Jasdeep Dhillon <jdhillon@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Zhan Liu <Zhan.Liu@amd.com>

[Why]
Even if can_apply_edp_fast_boot is set to 1 at boot, this flag will
be cleared to 0 at S3 resume.

[How]
Keep eDP Vdd on when eDP stream is already enabled.

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Zhan Liu <Zhan.Liu@amd.com>
---
 .../display/dc/dce110/dce110_hw_sequencer.c   | 24 +++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 52b22a944f94..ace04e2ed34e 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1770,9 +1770,29 @@ void dce110_enable_accelerated_mode(struct dc *dc, struct dc_state *context)
 				break;
 			}
 		}
-		// We are trying to enable eDP, don't power down VDD
-		if (can_apply_edp_fast_boot)
+
+		/*
+		 * TO-DO: So far the code logic below only addresses single eDP case.
+		 * For dual eDP case, there are a few things that need to be
+		 * implemented first:
+		 *
+		 * 1. Change the fastboot logic above, so eDP link[0 or 1]'s
+		 * stream[0 or 1] will all be checked.
+		 *
+		 * 2. Change keep_edp_vdd_on to an array, and maintain keep_edp_vdd_on
+		 * for each eDP.
+		 *
+		 * Once above 2 things are completed, we can then change the logic below
+		 * correspondingly, so dual eDP case will be fully covered.
+		 */
+
+		// We are trying to enable eDP, don't power down VDD if eDP stream is existing
+		if ((edp_stream_num == 1 && edp_streams[0] != NULL) || can_apply_edp_fast_boot) {
 			keep_edp_vdd_on = true;
+			DC_LOG_EVENT_LINK_TRAINING("Keep eDP Vdd on\n");
+		} else {
+			DC_LOG_EVENT_LINK_TRAINING("No eDP stream enabled, turn eDP Vdd off\n");
+		}
 	}
 
 	// Check seamless boot support
-- 
2.25.1

