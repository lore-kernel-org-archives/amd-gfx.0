Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BDC7C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jun 2022 19:36:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3F0C10F406;
	Fri, 17 Jun 2022 19:36:03 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFC9210F328
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jun 2022 19:35:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iCXJzGn4Kvf2deiDtXb2uVb+vYF7W/SfKILUgnslDBwzEWRi8zUhfOwi1woUbHRnYbppYg4u7cI58wNA0AEKs8AfdXL9s0B+U1tESmm2riKYDFiPqcooERWKHPc6+ES/ro2eNW/GDJwXuFy+lle2mOsG+QU+5y7TIqKnjFCIoHP8qQBrbJjd7U37djfyUlDynVN0VP4ONs88V53GUpOvlnsKJkqPBZyGiXEQEBTZUeHCgH1YywVRgAVE2inhJp0xCgzGbrdnGXch8GMSsI8rtK8dfUXxGY4cdaWJhpwrmgz9joGE2i7zO95MGQi048cIwSwZZ4qpmi27nbgwu3rjiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3l869pX8pJ20mtzCjMyydUudZKhMi/8KHqZSyy1mnIY=;
 b=OkiVP9PRoLtomgllaKFbdl4S/qUvKtyDdtjq6AxZEjmtG0INRPy+Fl6Xnn5a9GSoiCWv0leKqrIaI/wV7UDkZDICCcLHSTOnJkramRFRl3yX9PYKM74q4gsqvGVjOXfO5LNft2J1dqWFYpxCO3qLIvBfqutuursuYVwadIoHyhHd4tMj/Aelcu/zHCvZuXSzOj0Gm9QBuh26v0L4jAtB0kP73LPECzkH8ouALaiDN4J8K/ceJ3XjwXK1CX2NjYUY2LGbAeEcvreGEp66rD1mhu9AdDApH7HkaP0rQbd19cZxOEUIYKLk91dOm9v0fJcr+kPU4BkMP8vn1S/0jrQcXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3l869pX8pJ20mtzCjMyydUudZKhMi/8KHqZSyy1mnIY=;
 b=lgX7yUlHnSvhaopyu5io4Mwg8Dvti08GDv6ZxmhJK14aN+gnRWVQt3XsnJAtSA2UoLDA6Puc6Fv6c+iUDviJ/63aUD6NJNa5Lln0ik5EBMrh/dVwWKVwLDaxN/t5Ip0leOY0GEwFS4/NaPSQ/kC8IcLd/75OFRfoqa5bAZuGXhQ=
Received: from BN9PR03CA0140.namprd03.prod.outlook.com (2603:10b6:408:fe::25)
 by MWHPR1201MB0159.namprd12.prod.outlook.com (2603:10b6:301:59::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.15; Fri, 17 Jun
 2022 19:35:47 +0000
Received: from BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::1a) by BN9PR03CA0140.outlook.office365.com
 (2603:10b6:408:fe::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.17 via Frontend
 Transport; Fri, 17 Jun 2022 19:35:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT040.mail.protection.outlook.com (10.13.177.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Fri, 17 Jun 2022 19:35:47 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 17 Jun
 2022 14:35:44 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/31] drm/amd/display: Turn off internal backlight when
 plugging external monitor
Date: Fri, 17 Jun 2022 15:34:50 -0400
Message-ID: <20220617193512.3471076-10-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220617193512.3471076-1-Rodrigo.Siqueira@amd.com>
References: <20220617193512.3471076-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60cf6df2-150b-44e5-1efa-08da509893ef
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0159:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0159D89688A446A3AB3DE42498AF9@MWHPR1201MB0159.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xHakLTOT2sSv/vFr6EIVtL4zfpK1NsDO6kH4cJH1r/UlIFxoC42RqlIMWiqymcjR68qcv1Soa+2qmQKbTsU0Smp02LC1E5tHpEArjGsN8kI5yvkC/AFJPVEBTRi2MbTw/5WN90v2nMO2xt1lI0DywO80TmO9h7b3qIrPAzxe2I3wC/wVocc/BBzDk5MssTeb+SRB/uA0cH+9NnmbxIHJifIl6jXasXHzJ2bPaiuOMk3eOPfX/y6mCc3NqTdS0dGLo8B2K77JTENo2i4GtE1e7SNf5mLQTwBgNCycUMbmX0IPlsYJhJtbQw1ngCiDXrY56j5uOzls2L/PccB0otGnyG0y1KF/3KYuY5RYh9IaoZxBMm2sJJG84GYYD9cUmlu/ANiqtCge+729deaPNbCkHb0J0UnF9KWuZHr87iU5//mWUlhYj/P4dtUECuj6+c9y4b083B/FOw+621F+sjvIMo7HaSxf/HL7XaXjhxS5bDAyzRPiI3MP6XHcncNAVjSxfSDg8PdQf2yS0vCoYWxDq8qbZrQsCMnV2J28yoGD1/LkwLgYmRNyuK9Gx2l+v+fdrBH6msCzyxaVogDe8YpreYO9mhlLBQsmxBEtLG3B5CTyX/oGEm7L6QMIxBeFOvzufASb18tw2pbJCgx9SkAHZ3/bcoyqQd8MjeZkfM/RXb4RwQTp8c3DK+R7DJHYz0C0LeoyIKppy6dXasV3OQs/nA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(46966006)(36840700001)(40470700004)(356005)(86362001)(186003)(316002)(4326008)(1076003)(81166007)(8936002)(2906002)(36860700001)(5660300002)(40460700003)(82310400005)(6916009)(7696005)(8676002)(26005)(36756003)(70206006)(6666004)(426003)(336012)(47076005)(54906003)(70586007)(16526019)(498600001)(83380400001)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 19:35:47.2738 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60cf6df2-150b-44e5-1efa-08da509893ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0159
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
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, Sung Joon Kim <sungkim@amd.com>,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sung Joon Kim <sungkim@amd.com>

[why]
For VG, we want to turn off power/backlight of the intenral panel when
plugging in external monitor and going to "external monitor only" mode.

[how]
For turning off power of the internal panel, ignore the config flag whic
bypasses power sequencing for eDP panels.

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Sung Joon Kim <sungkim@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index fd95bd51988b..ef771471aa39 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -7275,8 +7275,7 @@ void dp_disable_link_phy(struct dc_link *link, const struct link_resource *link_
 			link->dc->hwss.edp_backlight_control(link, false);
 		if (link_hwss->ext.disable_dp_link_output)
 			link_hwss->ext.disable_dp_link_output(link, link_res, signal);
-		if (!link->dc->config.edp_no_power_sequencing)
-			link->dc->hwss.edp_power_control(link, false);
+		link->dc->hwss.edp_power_control(link, false);
 	} else {
 		if (dmcu != NULL && dmcu->funcs->lock_phy)
 			dmcu->funcs->lock_phy(dmcu);
-- 
2.25.1

