Return-Path: <SRS0=S25v=LM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5034C49361
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jun 2021 17:35:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FEF3613BA
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jun 2021 17:35:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FEF3613BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 581636EA4B;
	Fri, 18 Jun 2021 17:35:34 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2053.outbound.protection.outlook.com [40.107.100.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58EAD6EA4A
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Jun 2021 17:35:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b0RXCmom0WGiA7PqKZKuMiHQLX+IKaJnxSuZdQWhi+GHIzQocRyohH3JVcCH5VvOJqKTSclYpYYn/xfEDrAJzaBVLBUsSPvuPSB5xvRdmQ8pEdzB62Wqrwk6L73+K+tSRb8PouCYHdw4X1MyZC3d2Q/qciC1qH+kN1CR5OVX531d1iPX4GvFWL/Yo1eHGckifvyaibrScpJewiccD7WGh16+UdmMC4gFtWR+Xm3kqr1z8uAU5rsBZP2/XUuThBn/ln/7bZmZgeVgYA4P8Gn6VeB15gaGY13BKptZFnpV5BDpkgAhKOM2pTryshFil0LkhPF7xTkwH/DTZDAKBu8eyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6U5lO8//QslXzABE7L2ltpu3jDUHnYHkZ7GGFR04HHU=;
 b=bXk4S+gIINxH3V7Xs6EqYS2ZtIh9Oey8aGztKJ/MnDs6Axv6yyOk+pijG1EubzhnCJT2Dvafsf5Ji1D6wcWgyRNQ/7TbQBY5u+dMy3ZJuQ+tv8XHpNM1NZfGqxbWy1gQu8gCjCXVIUNXk/ocLt83D0aNqOZC0i7D8bsckQVTVBYyzglRj9VqS0y6ufYIoMTo0VA4lF5atvIStsU/enDOCOMiv/AAbFCoZmMHdNPVjpbXtGUJY7i0wH+6yWqobkv14cGyhx90GX2NWu0+KlYoWHrePA4dowfS9DOK0JdXnNPD3zEORRG4E7V7dzFLRMs2YfwT/Eg8Xltw64FHdb5vxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6U5lO8//QslXzABE7L2ltpu3jDUHnYHkZ7GGFR04HHU=;
 b=D1N2Vv8syFzWy4LcOItycaMknoTtwZ0ZCO5ViAPPjiwmcfhIy3QbQ3bZpvM/TXlzIVC2O5AuwkiR7FpZf2LiTUJr32zLFDjz3+fjKzCyq0b0TbeTbcDR5dsepzeoPuVGOIALNQk0dQtNYoV658cwM4KCmMxwcBOX2PwXDoYJRII=
Received: from BN0PR04CA0181.namprd04.prod.outlook.com (2603:10b6:408:e9::6)
 by MN2PR12MB3950.namprd12.prod.outlook.com (2603:10b6:208:16d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Fri, 18 Jun
 2021 17:35:28 +0000
Received: from BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e9:cafe::cb) by BN0PR04CA0181.outlook.office365.com
 (2603:10b6:408:e9::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19 via Frontend
 Transport; Fri, 18 Jun 2021 17:35:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT030.mail.protection.outlook.com (10.13.177.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4242.16 via Frontend Transport; Fri, 18 Jun 2021 17:35:28 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 18 Jun
 2021 12:35:27 -0500
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Fri, 18 Jun 2021 12:35:26 -0500
From: Bindu Ramamurthy <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/12] drm/amd/display: Multiplane cursor position incorrect
 when plane rotated
Date: Fri, 18 Jun 2021 13:35:03 -0400
Message-ID: <20210618173514.430647-2-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210618173514.430647-1-bindu.r@amd.com>
References: <20210618173514.430647-1-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae303e4f-45fd-4bab-0d38-08d9327f76c1
X-MS-TrafficTypeDiagnostic: MN2PR12MB3950:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3950E0F2CB4BE2AA6877DBB9F50D9@MN2PR12MB3950.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5cMMmvcIU56cKAgcNMVGt1vmjM9hJOWvGrawP8BqrGGJCK26qEe2zehi4ZQSj/fcMT4JfVfC48eVOGIuYzenwQ9Ez6Sy/9YHi/ftQq8IR2JHCoVif+XOsRGmzAy9Hwizwt7M0UrePfXxBsm7XU4s3hnwHnMXM/uAQg1mlfkZ+HFcBXha3Pmbrq++P8MbZsgnTk7bZBTUkYurHZ3cUp9OaZcVDBKFjFZtYyeHM1ZtxR5g4HcaiG+LDQvOajWw/BIgOfe5EXObEsE6B4JZyz7zjhfXHYrs19ORKRHIcHuwDKWr3olnrBk5owod7wwCy/UBIQQ0F191tZh928w7LzT+tZviIpC/p7lFLSe0Xwu17TmPBiOG4i+7gKp+Mj7TlA2D+tgzF6XMXP022L/jrq5+Fp7zwUF3EQnW3tH6eTcXnnmYfM9WXeCXkkOiFTzjzzgv/seLsvos8aNSm1V+D7+uJSJG6Ize6+D2xt7uHLUtv9oLozSEDamvuD44epP59xupLjMEoGilkoO53zdHVV2DwhngzCs19DHNxFUx/n8KZDL8D1Uj0gnOAXaqyvJfuqXZ1ggP/fIAkHlQNYjPmen11oIKiB1H//qDZqcQBlZmw3s46vW5eJIelzlV4QCvGy8j3SfoV9LsAmyevattNYEUCNN4oxfIdJIcyUAp2J0JUm1T8dpqddNfWL5dg/nn2SF9
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(54906003)(6916009)(336012)(8676002)(2616005)(5660300002)(426003)(8936002)(47076005)(6666004)(186003)(86362001)(83380400001)(26005)(36860700001)(7696005)(36756003)(498600001)(82310400003)(70206006)(4326008)(70586007)(2906002)(81166007)(356005)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2021 17:35:28.3804 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae303e4f-45fd-4bab-0d38-08d9327f76c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3950
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
Cc: Aric Cyr <aric.cyr@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Jun
 Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

[Why]
When video plane is rotate the cursor position is incorrect and not
matching the desktop location.

[How]
When a plane is rotated 90 or 270 degrees, the src_rect.width and height
should be swapped when determining the scaling factor compared to the
dst_rect.

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Bindu Ramamurthy <bindu.r@amd.com>
---
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 5d54900f7b61..c545eddabdcc 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -3245,10 +3245,17 @@ void dcn10_set_cursor_position(struct pipe_ctx *pipe_ctx)
 	 * about the actual size being incorrect, that's a limitation of
 	 * the hardware.
 	 */
-	x_pos = (x_pos - x_plane) * pipe_ctx->plane_state->src_rect.width /
-			pipe_ctx->plane_state->dst_rect.width;
-	y_pos = (y_pos - y_plane) * pipe_ctx->plane_state->src_rect.height /
-			pipe_ctx->plane_state->dst_rect.height;
+	if (param.rotation == ROTATION_ANGLE_90 || param.rotation == ROTATION_ANGLE_270) {
+		x_pos = (x_pos - x_plane) * pipe_ctx->plane_state->src_rect.height /
+				pipe_ctx->plane_state->dst_rect.width;
+		y_pos = (y_pos - y_plane) * pipe_ctx->plane_state->src_rect.width /
+				pipe_ctx->plane_state->dst_rect.height;
+	} else {
+		x_pos = (x_pos - x_plane) * pipe_ctx->plane_state->src_rect.width /
+				pipe_ctx->plane_state->dst_rect.width;
+		y_pos = (y_pos - y_plane) * pipe_ctx->plane_state->src_rect.height /
+				pipe_ctx->plane_state->dst_rect.height;
+	}
 
 	/**
 	 * If the cursor's source viewport is clipped then we need to
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
