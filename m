Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21BEDCDB465
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Oct 2023 13:33:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7E7410E4E3;
	Thu, 19 Oct 2023 13:33:08 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2078.outbound.protection.outlook.com [40.107.100.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA55410E4E2
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Oct 2023 13:33:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KTt7tnUGN/SWUta9gyFEQsh64ALH2/x/5fiAsDRhKNInAJk3r6ut3bYN58a9YwM38Qs5rBGv8tPxhFUS1kzwX//76ZrTbCtqPpKE4MA6YFpKzxgz28GGnGWa8ojqsMqRbEFvMg/AvI90P7oGcM93K0v/Mt+Gv51HxNAR+MsOr4JzOl7pqmSbCSp2vKb/10UB5XyQhjA6MUjNJVWqyL8SkeG/DHr+6+ZyStqD6GU6m9A1jPDrwKdSWLgVy+ROygTAa55yJDPzYYHxm7YP4W27GDz6ODKvmak9UnHxjxR6MNigkuOkK2CrzLeVtA4tCWz5Y5GqNEDMJt96RA+KC1VZkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EGX1fjf26Z/gmlEXRGexcT1put7rNxW6JyzTSsp7y0s=;
 b=mh6Ap8iaAegS5ZutZwbVY5JZCgpKG//acvZiX13rNDvBPDzdjQqh0mgqqM1vGOH9c45qHF5zKYP6n61cK0maKYzzxHY/LsUmVa3GVG0BWuKpLGme/vSGTSJt+340lJPoNtZMXZ8crQ1xO1mLHt1KR7KthxRtGGADW6OT9H95ytDGdtsRTpZTDmmtv27C0Aqrm0pel1u9IgFGhJTnG9ET60l+03N7TArNBFZCbmoX5OCFyLrQRUL91z+A09X5j0ZPMu+d1eHs8/F4YvfMK01+7JUrHqk1ecqn0cKGf3y2e3S5atPGfv5LBOQgw58SB6Skt3Tw9KNZIA0pdVyMIueK0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EGX1fjf26Z/gmlEXRGexcT1put7rNxW6JyzTSsp7y0s=;
 b=AcDNIHEAGg9+d1hTa62IqWNir3T4OGKPmwdJA6RsrXqB6i79h5Q1KAhBTF1GvH9QVH0JHdpHhrD+Dm+Ks9U4Gs6PNMNlFRFoYkg4n6Zjtvbpk+RnlC24oZcXbsQb/BecPoZDZtlHsPzwTKuQ7IfZ+IvrRW4H4KmscvzNw3rIHrs=
Received: from BL1PR13CA0092.namprd13.prod.outlook.com (2603:10b6:208:2b9::7)
 by PH0PR12MB7094.namprd12.prod.outlook.com (2603:10b6:510:21d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Thu, 19 Oct
 2023 13:33:02 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:208:2b9:cafe::f5) by BL1PR13CA0092.outlook.office365.com
 (2603:10b6:208:2b9::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.7 via Frontend
 Transport; Thu, 19 Oct 2023 13:33:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Thu, 19 Oct 2023 13:33:02 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 19 Oct
 2023 08:32:59 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 19 Oct
 2023 08:32:41 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 19 Oct 2023 08:32:40 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 06/24] drm/amd/display: Update SDP VSC colorimetry from DP
 test automation request
Date: Thu, 19 Oct 2023 09:32:04 -0400
Message-ID: <20231019133222.1633077-7-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019133222.1633077-1-Roman.Li@amd.com>
References: <20231019133222.1633077-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|PH0PR12MB7094:EE_
X-MS-Office365-Filtering-Correlation-Id: a74b5cfb-8410-45d8-5c1a-08dbd0a7eacd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F5dPtyrGC6dmJ2uTubJs7daTYHGKEgmu1RI699EgJZC4Z03Ddn7lpA4YbXKx+lcewab3xqse9fjz/foWqMuSbcPO7ArMzCnBYsmrGYno5tA5g2JFId/dwvt43EPeGIZSIcVAxdcZ4PtuJwgXzbqm4fIg/0WJbZziby2LjsSE+2DZg2ce1BYERC0MgD14kz7QhA2bnft7TF/P4znvSJvMgmJENPKmw3bgHGaTLT6DAVxmrqffOfYNChSdS7ISrCM/puygb6EIPyUzJ8qp/SOInSe35oymybLiE6ofuVSqHAPxHeSuQ+fAo13lkw4pKhQQZX+5/SOFvDyHFIJcQ9vrYTxFACpIxaBdnYBWC76jzV2l8hSyryZHBNR9SPIa+RFOl8nG5EAWi8n0qzNGtHbP5baWptcs5jYGrtGvovu2urzHQFqYs9JOKCHavNM5Y4Vv84SFT54jV0wsfQoX21sLDhOLh581SBVLid47zM+P+dE/EL6TEgygLZiiY+aJQALQzqe6JMlhJrtq01cN6HRGtYAmuVDmm+EyHfujQCrnSbdU6m43Byj6kSoO7hVVZtogTP2e8i4ow5L45/hTz8JycONcuQGL62SGUMMrRo9eL5g9hP4YEiYkLSW6hClU8/sS7ZRUEpAzfBJvUlbLb0F30kBl/B1TnADi16xLvF5S/TrGq6puAmHXlZ7+SanY6uiO173tW6VgK1dpSWUTTUPKR8s3fnuTS6BmNCkNFCvtJkqcRcMJlih2euDXh7gDNuNdAjhXIycY58SGpDKmHH7wog==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(396003)(39860400002)(136003)(230922051799003)(451199024)(82310400011)(186009)(64100799003)(1800799009)(36840700001)(46966006)(40470700004)(40460700003)(7696005)(1076003)(83380400001)(6666004)(426003)(4326008)(336012)(70206006)(8936002)(316002)(2616005)(36860700001)(8676002)(5660300002)(2876002)(41300700001)(15650500001)(2906002)(82740400003)(478600001)(47076005)(54906003)(6916009)(26005)(86362001)(81166007)(356005)(70586007)(36756003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 13:33:02.0187 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a74b5cfb-8410-45d8-5c1a-08dbd0a7eacd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7094
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
 Wenjing Liu <wenjing.liu@amd.com>, George Shen <george.shen@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com, wayne.lin@amd.com,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: George Shen <george.shen@amd.com>

[Why]
Certain test equipment vendors check the SDP VSC for colorimetry against
the value from the test request during certain DP link layer tests for
YCbCr test cases.

[How]
Update SDP VSC with colorimetry from test automation request.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
---
 .../gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c   | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
index 0894e6aef3dd..21a39afd274b 100644
--- a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
+++ b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
@@ -839,6 +839,12 @@ bool dp_set_test_pattern(
 				pipe_ctx->stream->vsc_infopacket.sb[17] |= (1 << 7); // sb17 bit 7 Dynamic Range: 0 = VESA range, 1 = CTA range
 			else
 				pipe_ctx->stream->vsc_infopacket.sb[17] &= ~(1 << 7);
+
+			if (color_space == COLOR_SPACE_YCBCR601_LIMITED)
+				pipe_ctx->stream->vsc_infopacket.sb[16] &= 0xf0;
+			else if (color_space == COLOR_SPACE_YCBCR709_LIMITED)
+				pipe_ctx->stream->vsc_infopacket.sb[16] |= 1;
+
 			resource_build_info_frame(pipe_ctx);
 			link->dc->hwss.update_info_frame(pipe_ctx);
 		}
-- 
2.34.1

