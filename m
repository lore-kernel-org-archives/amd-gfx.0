Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9383CC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Apr 2022 19:10:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17A3310E20F;
	Mon, 25 Apr 2022 19:10:30 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 991E210E20F
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Apr 2022 19:10:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eSk6RMymGnrH9DDESZgDNsdHTlbK6AOLspSsQaEgxt31sKPJ6OFUvHxkP+037UzcsXRxd2CtIXcCeXDEaWOO3Ji+KLE+GN6lqdYrk+BtAhDjOQpO/1gwHHIfQV7+8al/5cyosxrKo3G27bkXfk/UJbHSEEo+A/yZxtfNRvGxygFgYDOjZS0ih/RDAyoQ8abwYWK8wcLQta1FmBrtivx8VRZVAeXDAFFsSU5r/R6oqdQtyWe3CGW6Ro6SDxvlKE0MBl5mnSrGcno5I+2BAKTndbt5A07Imiyn8ZMtV4zQvXqGSGXDJJ3hRjD9O1yUHUfN2nBjLVFz1/mcDmOZ9+nWIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Lk5t76X8irelNoRqEohDTCnJAMo0Q21DwmyqNvYulk=;
 b=X4QmV3ha1nGUvteSbX8ZUm65BvyTxQBSrol3EdEk3pz/79cZCEB1qxLfVOxy5RU8mCUYXOY7V4T4XityjK+kPJEHHbryBa2Gk4TFpSi0hZsoMKGTLwR83U4oK9TXE1+NKvShfcaZiV80mUMAo2ucpF3WDLaexria3RJL1J0F9lIv1soOGcRiTrStD2KfUT16QTLkFacGKV9e8kDYwBGlVz7lfcKKpw7AqELf8UrXaaUcpeLmmAz2m1q70MU5a/I0uvLMGv4/tK0vy2Zs6TMtcgX3X2MKROitn+qRsDelSGgr8PaUp/yR4Y1yEd+2hQGijh0QXlxKWFfVzr49piguAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Lk5t76X8irelNoRqEohDTCnJAMo0Q21DwmyqNvYulk=;
 b=JW3MT1mVNUb/E++ellNl5rVyH6pQ7CvgllJSwzHLDCqef+ybyLvD781HUh3xNogMt5t/4WIXa6Y7IfquQ7HaICIfkn8QF3y0NjpHEKjDSA3FR3ra3+D+8Js8tRmhUlMr4FC5icErCN/pONAEuk00AWoqb4ycajIIliyW3CmZ9Ek=
Received: from BN9PR03CA0552.namprd03.prod.outlook.com (2603:10b6:408:138::17)
 by SN6PR12MB2765.namprd12.prod.outlook.com (2603:10b6:805:77::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Mon, 25 Apr
 2022 19:10:25 +0000
Received: from BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:138:cafe::47) by BN9PR03CA0552.outlook.office365.com
 (2603:10b6:408:138::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13 via Frontend
 Transport; Mon, 25 Apr 2022 19:10:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT012.mail.protection.outlook.com (10.13.177.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5164.19 via Frontend Transport; Mon, 25 Apr 2022 19:10:24 +0000
Received: from Gundam.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 25 Apr
 2022 14:10:21 -0500
From: David Zhang <dingchen.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd: add dc feature mask flags for PSR allow smu and
 multi-display optimizations
Date: Mon, 25 Apr 2022 15:10:08 -0400
Message-ID: <20220425191008.775902-1-dingchen.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76f4f1a6-95a7-4c4b-c62b-08da26ef4064
X-MS-TrafficTypeDiagnostic: SN6PR12MB2765:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB2765307982D92AD195BB858C8DF89@SN6PR12MB2765.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: toPOpTrHni95mABJpi5aVEdPubimggrrbx1RJcYA3cZf8kIU2P+igz0YtphZX47fuy9joFzON0lsESdNQT5mi+e6ZZ/D4Q5ehY/5BbyWqtqZuFu2mVOh9/ZVVpJjIOBW99/pigT0BsbN/i04q8YbCGnMQ//fHBfEVmxJwYjakiZrljA8GD97V8N4JPNAc0q48Hw4mgrAf6nnP7K6j5nFvriMhwiiudo5bV6sSY3m74aLLcufZ+Cp8K8TXbkq7tQHNSxyG6k+A9OlfgAXAHxw0auzuODChjYQL3VrWULp52e7qibGCJ79Hz/0nic0APhFqqWgTTVr8/9K8pVhIY+HxXYxPjZBLCxnQtOQfoWqo7RjHLZtIZ2jmYGG3nsnHl99BPJp9dCxkE9Yrj39YYHLLKu68X3NT70o9NIRP/hFRLo0kzd3LGZWNh3Zm3rUP61C+qvtpcXoqFrV/i4cZSiqtJCC0c9cFXW0YjQKcS723BTNWdt+h5XVQvamnMv5/I/3cAKADByYXnwrsgjeQzfqM43STWXc1b7yefCkK6sv2zpZjASA1AYcEZQU1yBj8T1X7NaC2SoqZ90hX0EQYv7CO5gPmmmfqxJ2vHJJTxd0M+ElFpCVO3wzCvnNlCrynbZTZ6MnGSFdMLK8mHBk+atLCtkYZYgU5ONkas269O/th81rfcPy8OXknPDyr8Rmg+byizFh0UwBSC5J2Bzk3liFgw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(26005)(36860700001)(40460700003)(47076005)(6666004)(36756003)(8676002)(7696005)(6916009)(5660300002)(1076003)(426003)(70586007)(70206006)(2906002)(4326008)(2616005)(336012)(316002)(186003)(16526019)(4744005)(508600001)(86362001)(83380400001)(8936002)(81166007)(82310400005)(54906003)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 19:10:24.5106 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76f4f1a6-95a7-4c4b-c62b-08da26ef4064
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2765
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
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Allow for PSR SMU optimization and PSR multiple display optimization.

[How]
Add feature flags of PSR smu optimization and PSR multiple display
optimiztaion, and set them during init sequence. By default, flags
are disabled.

Signed-off-by: David Zhang <dingchen.zhang@amd.com>
---
 drivers/gpu/drm/amd/include/amd_shared.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index 741dae17562a..06f21e9008c6 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -234,6 +234,8 @@ enum DC_FEATURE_MASK {
 	DC_EDP_NO_POWER_SEQUENCING = (1 << 4), //0x10, disabled by default
 	DC_DISABLE_LTTPR_DP1_4A = (1 << 5), //0x20, disabled by default
 	DC_DISABLE_LTTPR_DP2_0 = (1 << 6), //0x40, disabled by default
+	DC_PSR_ALLOW_SMU_OPT = (1 << 7), //0x80, disabled by default
+	DC_PSR_ALLOW_MULTI_DISP_OPT = (1 << 8), //0x100, disabled by default
 };
 
 enum DC_DEBUG_MASK {
-- 
2.25.1

