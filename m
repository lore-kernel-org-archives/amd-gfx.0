Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D8E2C433EF
	for <amd-gfx@archiver.kernel.org>; Sat,  5 Feb 2022 01:50:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A13510E2CA;
	Sat,  5 Feb 2022 01:50:57 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7250110E29A
 for <amd-gfx@lists.freedesktop.org>; Sat,  5 Feb 2022 01:50:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kErCHD96eFUv7mJ3MxAcqLQrstprWfF0K+scjfvmO8K/uzH8KFwmy+vRxsLa2RUMt22pRYNWPtQaUUGNrQewyy0Rj134qxaG9VqPTMFmG3Xik3x9FdpCPYufLbBkaE2R46IAu0sg6ecRC7kFVcEhPhoJbQiLHZvyuNRb4AkY9ADWrMIhmmp1CSZAzXUnnGg5uP0ywQ+3wklviS0YNVe8absID6Wi+JLHi2ZJc3fIqIJp8HXwPY2J82ZjxACUbJxapBmOnrXCUramv36NtWsgFVqePIj9HFZP9PBlh0/NfHNQp4cpGSSYk/+c5kxwLuESAZBaVRUfV7XSq0H5pT9ZFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EmGuRFFrXq1D81Qky/IkdkDWKHBJ4+Q1Xql9ZzZCwLE=;
 b=dPlXGgzIQMYTFSTnAsLNYsbEOxxJ1Mnz+kXUP7HhVyckBS5xCR4HopjIX4lqjOs2PpwQhZSJC1T64Dd/ElZptN0YXThAfRZVZyaqjcTGT9/t58G9/il6HPh7HNmnEww+26+i3JBMAki4tOha5mWnu7RAr6OGDfL5gYCzz3MQW56pkqgLro/9s5Kqkd9cuOlIyX1JBvt2QGpyfWWxbP+VsDObQw9UN1dNS8TEBefXoaeIu7sdPALz3wJaJXu+rEH8VAWQbx6m45YKEf/vQduqm3bs8ZISW0IHOOE6LuvD0yh5b/oATDe/xA0D8YHtOmzImxNdkxs0GPUkx7VXyPL4lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EmGuRFFrXq1D81Qky/IkdkDWKHBJ4+Q1Xql9ZzZCwLE=;
 b=YgXCYr6QURka7rx0YwB8rQtaxfD2ho2vByzSh8b6MWG5P3jucZEajNrYJpGlJq/hRhjf/lgYrMqjGuU+cVc2vCayP5cf61lO4pGfPySdrZQmo3RlrKHnqnvlDN8YAeuiLwGI9ru+e1MG2Or9PQ0brlvGKafGu65/jn+tJMujz1M=
Received: from MWHPR11CA0010.namprd11.prod.outlook.com (2603:10b6:301:1::20)
 by DM6PR12MB4925.namprd12.prod.outlook.com (2603:10b6:5:1b7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Sat, 5 Feb
 2022 01:50:54 +0000
Received: from CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:1:cafe::88) by MWHPR11CA0010.outlook.office365.com
 (2603:10b6:301:1::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Sat, 5 Feb 2022 01:50:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT030.mail.protection.outlook.com (10.13.174.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Sat, 5 Feb 2022 01:50:54 +0000
Received: from jasdeep-System-Product-Name.hitronhub.home (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Fri, 4 Feb 2022 19:50:52 -0600
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/14] drm/amd/display: remove static from optc31_set_drr
Date: Fri, 4 Feb 2022 20:50:20 -0500
Message-ID: <20220205015029.143768-6-jdhillon@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5366c293-ba66-4653-df6e-08d9e849f232
X-MS-TrafficTypeDiagnostic: DM6PR12MB4925:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB492540DB7BB4AFBF9A8843FFFB2A9@DM6PR12MB4925.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:341;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wyRIAQQY9r5K/vxjkRKZHn1rvjLfMx/Iw7VPQCjEDhycKFnAh9dd/V7IuO+NrZSd//wchepue6v+E5OSW01xcIVPBgIiTdeJIKO1BzgMND5D6NyXBRpfUPL9tfpkJC5qWDSys+/nueU7Gfv02lj5hQwFx8E+gPvXsrkF1yxImrLRffWDCALl4991+eC3dRb7LZ2xazO8L1IzpkfZsvR/Zablfw3W19ik/4BzG7D7RtXCxs0UqFKmlLRfL5CogkuKJ5U18JCMeuakl3y/H8p8WkFk2anMI66vQ7NuLFjpyenBwgShD9i7dEanJHrUGTbnLtweqbmt7oFAkFFQQ1LHh+UBpZ7OCB4kg11DuQVjpsuT+A8Z+/LslbJgDn2BvNDZiVVFFXljCiw+zXhF5B0WYV7ayJfZe1GVWzVN7de2xf3bqSSLdt47zryR2dY+H+k9OpMt6n91RQvud7NWhTh71HORo3YdLzP7sInNAWwQpKdwcnToJMCdkCljrfWqDsLRN2COz8jB8TfVYt7JOTilvPjfQ+l2jWKI5+P2o0KgaMzjafvaB+mG/owFLrE413OSwOSYerrEdY6G20fq4EigtOGZy+ixgGnVaOpYiHq5Y2RopVhDPLDX7pGHl3ZznZ9tFa8sjRUc5SNx3ISGpAgay0731hu8chpxAtdUH2wm3sv6sPY9RKpG+sizvYcja+xOP6XhRGnBzLsbFwxNXEW4lw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(36860700001)(83380400001)(1076003)(26005)(16526019)(47076005)(2616005)(426003)(356005)(336012)(186003)(40460700003)(82310400004)(81166007)(54906003)(8676002)(4326008)(2906002)(36756003)(508600001)(6916009)(316002)(70206006)(70586007)(8936002)(5660300002)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2022 01:50:54.1437 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5366c293-ba66-4653-df6e-08d9e849f232
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4925
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
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Eric Bernstein <eric.bernstein@amd.com>, wayne.lin@amd.com,
 Nevenko Stupar <Nevenko.Stupar@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Eric Bernstein <eric.bernstein@amd.com>

remove static from optc31_set_drr

Reviewed-by: Nevenko Stupar <Nevenko.Stupar@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Eric Bernstein <eric.bernstein@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.c
index e8562fa11366..8afe2130d7c5 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.c
@@ -161,7 +161,7 @@ static bool optc31_immediate_disable_crtc(struct timing_generator *optc)
 	return true;
 }
 
-static void optc31_set_drr(
+void optc31_set_drr(
 	struct timing_generator *optc,
 	const struct drr_params *params)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.h b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.h
index d8ef2f0d0c95..a37b16040c1d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_optc.h
@@ -256,4 +256,6 @@
 
 void dcn31_timing_generator_init(struct optc *optc1);
 
+void optc31_set_drr(struct timing_generator *optc, const struct drr_params *params);
+
 #endif /* __DC_OPTC_DCN31_H__ */
-- 
2.25.1

