Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D4FDC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Mar 2022 22:55:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4D1510E1CC;
	Fri, 25 Mar 2022 22:55:46 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EA9810E1CC
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Mar 2022 22:55:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rx5HyQH4ANKG4kj49GrczY+HxRF6fc5kmhe56SkSKucwceij6gD14auO3ro6iy8WFthRJEMPUfWcwHw4CIpR1o+RSVQT4P+M2u8C6zueSwCTZQwta/8DuPIB83v+Ys20AbtcOa9a4F+Vi4p9CeNbrCosndsNRYQBNssHFcpiXBfu7pl3b0Ud3xZgYC71uyoIIf05NCHJi2YjxazVgEoaADgCe1hYKucEUa+0a+yTWm+VIrx0RIbgJK1lTeHm5R50Nn99e3AvPi79+/Th24qWW5qBFB/0hQbDqWclVubi32UkfXSY+lVBFXK/7pTsZdBOSoZpXfeAgBghNbmLezLzTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ziDbwHVBi6Sie9Jt0UFz4H0+CF6dFMTmDzwQ/7JH7fA=;
 b=YfgHVbROLd4X5hHd8egHuz+Zjw0W8N/gUAC/7LBgxhX1nuxmghHHwPmT1lWucVewJR51CSuaZKp5ARW5ZtXAipEWBp9nNaqgAKsNARKTPa81gVJ5XKF/hfpubFnc+1QIs8L1yYB95OOqM65akhvzmEVBMV6+NeqzaAyIV9Za7AmmCPiuqmjhMvCumXVCCva49y494K2GHHDvYE9qbFTe8SDRm5uh7RJHzoXAjTNkmtaV6Rn1xYujWaeKQQUGGO51InrNN3q8pFBgLs8I5pCZJ/nQOdasrKjE4Si5IQYWsPoKxnjar0g91keK+Q/KMUpeO+fmeZQ06l+rvv0NCgu0LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ziDbwHVBi6Sie9Jt0UFz4H0+CF6dFMTmDzwQ/7JH7fA=;
 b=uN6Uj5bN6dEKAGzG/kGfu4gs4GIp2Q1Bt3q0VCIViqJ6MwTqecG6va57k4QZ9PuEoPpJ5tnWNz7/HJTp9O5DHdpmaG4ODgScVQixJd80P9qkOkHwwTON4QLIvNruY+pDSl+VSPitmT6E4nVrbD3xoPaGK4I7X/pIcxEtup6g6dQ=
Received: from MW4PR03CA0011.namprd03.prod.outlook.com (2603:10b6:303:8f::16)
 by BY5PR12MB4003.namprd12.prod.outlook.com (2603:10b6:a03:196::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Fri, 25 Mar
 2022 22:55:40 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::68) by MW4PR03CA0011.outlook.office365.com
 (2603:10b6:303:8f::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18 via Frontend
 Transport; Fri, 25 Mar 2022 22:55:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Fri, 25 Mar 2022 22:55:39 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 25 Mar
 2022 17:55:36 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/16] drm/amd/display: Enable 3-plane MPO for DCN31
Date: Fri, 25 Mar 2022 16:53:50 -0600
Message-ID: <20220325225402.469841-5-alex.hung@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220325225402.469841-1-alex.hung@amd.com>
References: <20220325225402.469841-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a13aa487-fa71-4ee5-8ce5-08da0eb29558
X-MS-TrafficTypeDiagnostic: BY5PR12MB4003:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB40037D1CB78C41DEA10E0149F71A9@BY5PR12MB4003.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6BOcc/uo1kmfCLohi1fAsrgXKrStN3PPaoqomS4XGF7GamgPyrP+DzW4kErpepwjBq5QoQC9U2nWHeh9vacWdONOKGo7Th61EkkSwUJEZXxChv0SCYz4HfmwCN0+0mlkyU/Q+2SN+jrXYr2vhYM09ES7aZdvqqKo5flw24TYuAnGURPm0a6rTD4irQ0gydbuW3QK65Ua4eejpLTw78oa+Q50+Ur9ChmYGvVqkAs78Ndo+BiS0SOoGVM+Z4Ppa0l6qO3mCpo5KLThwnqxKdSPOn+twEO9jlEwC9BZrC5NP6+F4tAwzp4QXW1mPlcm5TdWEVi68BKVekGYdpo9RWsylWpbCCr26EvAFqqeD82ZDDP6MV9+hLLRt38XWX5iDGt6EFMt5V2KkWIkhFWfjGdAWUdSG0suq/xGOGze2qlNTfYeoJeEeeXvoRpTNGr912PxWn8M4fXXaNs36/y1XiPcP7yYrR6Totpsdcn3wDQ2ZsjOphyogC/AJYT6kp2iDE/fOdlTS62bJfx+5H8CsP6wvNtU7O6UZM2p1vqIuF4Pj+HKfEUwjZPB3OQGyyNbiIbLejJIt7Khwxi1w/Di7iUEjHeEMJdvrxEqbjLimB+ejqp+0dUKaJ56ujjD87hs5mtIctVfINtymmkuqtyiYUKIP4HHWJoI046rI4b9r1qxXla388oMhH64MgfQy+gQ0kxN3c+dIwrg+sLgp/kBxhTq7Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(36860700001)(82310400004)(8936002)(5660300002)(1076003)(40460700003)(86362001)(6666004)(508600001)(2906002)(81166007)(7696005)(26005)(426003)(336012)(356005)(16526019)(44832011)(186003)(83380400001)(36756003)(316002)(2616005)(70586007)(70206006)(8676002)(4326008)(6916009)(54906003)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 22:55:39.7203 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a13aa487-fa71-4ee5-8ce5-08da0eb29558
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4003
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
Cc: stylon.wang@amd.com, Aric Cyr <Aric.Cyr@amd.com>,
 Krunoslav Kovac <Krunoslav.Kovac@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Nevenko Stupar <Nevenko.Stupar@amd.com>, wayne.lin@amd.com,
 Alex Hung <alex.hung@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Krunoslav Kovac <Krunoslav.Kovac@amd.com>

[WHY&HOW]
It can be enabled by users, but proper way is to report max_slave_planes
in DC caps for each ASIC.
Some structures use hardcoded max_plane=2, this is also addressed here.

Reviewed-by: Nevenko Stupar <Nevenko.Stupar@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Krunoslav Kovac <Krunoslav.Kovac@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index bf130b2435ab..826970f2bd0a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -1868,9 +1868,9 @@ static bool dcn31_resource_construct(
 	dc->caps.min_horizontal_blanking_period = 80;
 	dc->caps.dmdata_alloc_size = 2048;
 
-	dc->caps.max_slave_planes = 1;
-	dc->caps.max_slave_yuv_planes = 1;
-	dc->caps.max_slave_rgb_planes = 1;
+	dc->caps.max_slave_planes = 2;
+	dc->caps.max_slave_yuv_planes = 2;
+	dc->caps.max_slave_rgb_planes = 2;
 	dc->caps.post_blend_color_processing = true;
 	dc->caps.force_dp_tps4_for_cp2520 = true;
 	dc->caps.dp_hpo = true;
-- 
2.35.1

