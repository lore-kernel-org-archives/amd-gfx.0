Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC8A4C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Apr 2022 17:28:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4402B10F14F;
	Fri,  8 Apr 2022 17:28:03 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CACC10F132
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Apr 2022 17:27:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OQUkmJdi10iZF1WY8AmUI5gTY6DqmDzAu8MjejMtPcupLb7awpTO2h2c2qeiV3u9AAAvbEQIPU2FOSQP5ogFL6DA7YjRUAZQVJrIieK2lRWFPjqbxN5DOrfeQqmA2Jysl4nU9mrh+YVthICZnm1BowLQd12AbfWnonurimSiLwLNyisOjqsrRX2eoOCGT0Nce6DWzqtsq3L77Ledr7UKMklEQn91ygslolCgRKnTkzkm33H2+Qi8F2JsDEivKVJg9aFD/XmxBkfKm+e/Pr5cgNlzZZdEtcRJjgHGupgsUN54+Vq4hsDyzguzFEBi2gGAjlux1z4R0zB4lB5tdHQK5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eYe0AE7qyEZ7AxgjwxV7pseWcxqyVVF5di4l7YywHkY=;
 b=J+O4OXszbqxiKYjN5IDErsWV08DsvhrxtFPnM75Vj4AtZ16HPi7Do3HOyE9ObClrpq70wrKMoY+so+LGkLCWXcXdarT6mSqufnZyPSRCMrAsnU9aEe3zcQpH9FaQ7vtCAh5DGBzuBXMsHomvWQv9wehRAucEYlTLnirVyq0PG0o2IqkXerSlXn7/McAHVDFmfnLggXsNNXDwdVFBVy13VBWa9J/NgjhRYrLGFUZ3wcDc7EYqJJuVHiN/v0zbbx7N5ZK5Za0I2mZcMeBvtJAM2F6k82oodfR1dGiQ76E6B44OO0PV5Dw15GBTlOuzuXQE1GvrshBxaSxPnGsmgdM0OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eYe0AE7qyEZ7AxgjwxV7pseWcxqyVVF5di4l7YywHkY=;
 b=XC3s5fXM7ppmwCAIRO0xFArg58uwm0DowI6l9x+MgvZBDpkFR9TmOXipGsFq4DgEZdUJYz+eMzxFuGdFoKdpdik/eJKR8q4rdF5ZyqFxf1DvWRgDuNKxl6bokNPlTnSp2DWJNIC72e9vq/bNNAiqH0SoGgNtMg03Wa3lKG0hQzw=
Received: from DM6PR07CA0103.namprd07.prod.outlook.com (2603:10b6:5:330::35)
 by BYAPR12MB4613.namprd12.prod.outlook.com (2603:10b6:a03:a4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Fri, 8 Apr
 2022 17:27:54 +0000
Received: from DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:330:cafe::dd) by DM6PR07CA0103.outlook.office365.com
 (2603:10b6:5:330::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.26 via Frontend
 Transport; Fri, 8 Apr 2022 17:27:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT059.mail.protection.outlook.com (10.13.172.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Fri, 8 Apr 2022 17:27:53 +0000
Received: from lnxpromo.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 8 Apr
 2022 12:27:47 -0500
From: Pavle Kotarac <Pavle.Kotarac@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 18/20] drm/amd/display: Select correct DTO source
Date: Fri, 8 Apr 2022 13:19:09 -0400
Message-ID: <20220408171911.601615-19-Pavle.Kotarac@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220408171911.601615-1-Pavle.Kotarac@amd.com>
References: <20220408171911.601615-1-Pavle.Kotarac@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17eb026c-0ceb-4392-3005-08da19851d65
X-MS-TrafficTypeDiagnostic: BYAPR12MB4613:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB4613A27683117DA43C491A9AFCE99@BYAPR12MB4613.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PE7H63c/ibcptNL0IOwp/3s00mH6xW7I/azddlx/WJOXAzgBGW3kyLA5R9QxHBBvL+JSbOE3OAayjPPjEbuN8JvvomHcmlZNG9sQduQOFnhVYtR+n703CC7hoAE8AkDLMSCe/BnwaiakTH1rcgcfLsTAPQivv35v0hyUmIOGae8JDJH3okG/rBpyIIkAhIQOKqTbSns8QhaZR2BUrgEwyjHuiQghKQSkpqedTX/S/ESP+XMvkoVqjsPNHMQB+CHA/WTlKQzzD/J99ElQ4BXdwisdZrm/RDDrUaINllC152xiOfoOKsP86Y6h7Ggtk+AqOkgN+1e5HCNmxibmO7d2zOPCvnWKVzSvjUjmX0tf5guk52NlEASXO5ujDIQ8++qH6ikoJoGapfL0jLxT6q9IeSjOiQoBgzO8gYVBeTTeTnHyxl7BDemgHsI2ZXNrxei1f3RmqgES9s3oLptCIbnZsrOheu3KxOapPXLGYMKku12JQqUflIoPk21Y37SqcYzIwRJDVE7SOep5EYtEC5yRa1Vun+eVdHAlyJ+AYpz3zazBjhap1xoLFyHyNnzefm98aMSFHojIyyo1s7154tTmAce3N8mdw0vYeWVpr1eVTuoy7yAGYB5RGlXEjW3sE4561nXadl5TMBEc2QbM7Bw7N9bU2D47Vv5buSpYi3+pn4HnexV/AJzP1HfaDravmEaJalRUjyT8c4HgD6dGBuBd1A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(26005)(186003)(5660300002)(86362001)(81166007)(83380400001)(2906002)(7696005)(6666004)(356005)(426003)(16526019)(8936002)(70586007)(70206006)(336012)(1076003)(508600001)(40460700003)(8676002)(4326008)(2616005)(47076005)(36860700001)(36756003)(82310400005)(6916009)(54906003)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 17:27:53.9455 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17eb026c-0ceb-4392-3005-08da19851d65
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4613
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
Cc: stylon.wang@amd.com, Dillon Varone <dillon.varone@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Ariel Bernstein <Eric.Bernstein@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, Pavle
 Kotarac <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dillon Varone <dillon.varone@amd.com>

[WHY&HOW]
Change criteria for setting DTO source value, and always set it regardless of
the signal type.

Reviewed-by: Ariel Bernstein <Eric.Bernstein@amd.com>
Acked-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
index c36f8e829344..760653e2b607 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
@@ -985,7 +985,7 @@ static bool dcn31_program_pix_clk(
 	struct bp_pixel_clock_parameters bp_pc_params = {0};
 	enum transmitter_color_depth bp_pc_colour_depth = TRANSMITTER_COLOR_DEPTH_24;
 	// For these signal types Driver to program DP_DTO without calling VBIOS Command table
-	if (dc_is_dp_signal(pix_clk_params->signal_type)) {
+	if (dc_is_dp_signal(pix_clk_params->signal_type) || dc_is_virtual_signal(pix_clk_params->signal_type)) {
 		if (e) {
 			/* Set DTO values: phase = target clock, modulo = reference clock*/
 			REG_WRITE(PHASE[inst], e->target_pixel_rate_khz * e->mult_factor);
-- 
2.32.0

