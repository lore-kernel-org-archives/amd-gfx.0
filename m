Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C64BC433F5
	for <amd-gfx@archiver.kernel.org>; Sat, 26 Feb 2022 15:41:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0405710E293;
	Sat, 26 Feb 2022 15:41:51 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3566910E293
 for <amd-gfx@lists.freedesktop.org>; Sat, 26 Feb 2022 15:41:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q0HJ4K7cbPspc9DC/Q1xW5c/8L6dV+JcIUZ3cwCFzK4h+KaDoct/llXuVvzib1JHfDW9B6Ex46Q4WfmWkzrTlGzFAHlqYz7ynyvUsDBwYvAiotBZMdsbNq/Rwp/UriGj6HmEmsIWdSvKFfubQhE/V7s9iDHvFS4IcCNYz26d+0tjFxoprM7pECtZ27Qtewi1oYevBqQOSEww3U1hdi8QorrRH1JxiJW2OTpRoUuhLUPxB0ynttBeAawRdxoLy7txo8d3+9a6dPXng4UhmNEvQSQvQnRwk57w3IfVHNmXrmKpu0HyvAKvxNk0tM2Gt/ayb5LEkb1Na2VyTO7a9FkwtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nyDdI38iRqqVnghZguomS6wxifag7kymJKU8ItfrBq4=;
 b=DuMORS7fPBEBhw7xnonMB3AmhyBL+veBItBNgX23hSQuOZXKx2h4g9FmLBhTsDRF/c5HIAq20JiIrqKGEq5YtXwL5rvFFGbrdtVn8niZMK2VyzlE4A3lwtDENvdK3udEINtIW5LC8Bicn5x9ar3VHBqiPGC/QLwEnTJLELbD0CTH5jeNGwSo+gLPURGfJ9NnINosks7OgdepHfjCP9mgZhrkFu7fVL9wY7DqL/4ug54rOzcon68keeX2BhC75xQc7tmNbPoRTAhXn1uLiAq4zKnaV0Bo9RoZS2xSlAmNjXhOrfOvWkwhFtxjrd38X5LYQDMSqy/IMX18EfA+YYAIwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nyDdI38iRqqVnghZguomS6wxifag7kymJKU8ItfrBq4=;
 b=1Twtnn58wCwTx3ZxP5cEqINF4s5Wd8pZNAY8p2FaeJF0uHnW1+cBzpUSPJ9aeji10Zba7LsSfPnYpEyH8Ut9lmUkBPwEsrqbSpaUlsL2J0Ab/x5xmrOzeYvdJcKU2AfyALvRNhMmFOCrR5RMiwc0WW1lKaCroJavLZUZNr3W8wY=
Received: from DM6PR02CA0117.namprd02.prod.outlook.com (2603:10b6:5:1b4::19)
 by BYAPR12MB2632.namprd12.prod.outlook.com (2603:10b6:a03:6c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Sat, 26 Feb
 2022 15:41:41 +0000
Received: from DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b4:cafe::9a) by DM6PR02CA0117.outlook.office365.com
 (2603:10b6:5:1b4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22 via Frontend
 Transport; Sat, 26 Feb 2022 15:41:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT014.mail.protection.outlook.com (10.13.173.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Sat, 26 Feb 2022 15:41:40 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sat, 26 Feb
 2022 09:41:40 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sat, 26 Feb
 2022 07:41:39 -0800
Received: from alan-dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Sat, 26 Feb 2022 09:41:36 -0600
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/14] drm/amd/display: Reset VIC if HDMI_VIC is present
Date: Sun, 27 Feb 2022 07:41:06 +0800
Message-ID: <20220226234117.3328151-4-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220226234117.3328151-1-HaoPing.Liu@amd.com>
References: <20220226234117.3328151-1-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79dfc8ab-42bf-4e22-e94e-08d9f93e7ba5
X-MS-TrafficTypeDiagnostic: BYAPR12MB2632:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB2632E5E902E3D501919756DCF53F9@BYAPR12MB2632.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gA3FqKWvVHXCpEt7vdz1Il3orf2DIPWUVF629fnW5uY2HJipNK0Rlmon6tyRdR6CZ6bCOtzYFwa02FGBCRCOqmxiGMQFhqLP6ibigANG05Opb+YInJC15f6MSmmgo4SyHAYs3oPCqXmc1dcb1stDMvqdafodWnpKB9Y4hLpoicH3dogSalAaM7YDCpOKD7s/aeTQbC7qIUUWRqzff0a3hfzTNDw/kF0tXgROT0E+ftgtriRA8BhTjFqzipDUu2Nxo0Sw/48A19KhEhuyme1vme2yPxPXRtXJ4fpDrSeLg2uSTBqGSAzISXnKxCKAo7hlEJPEo7kh65yEPvF3HJF81K9meGSBUP8UODCsCkcdAAb5N+4G2iHxFU7M9UQL9NJaofXodZiOyM8SUqbzUQ1Zn0hzoXIp52be2ypvymX1OgfitDMdoaiVpvvdCp83yCWtttXcLlTC+SRWAUR7xNPLvXFugE0+r2dLPYckQC5G6KypNION/VSn4uG07gQRTctfKTq8a88z7Dji/9E6wjiuc1pjzms4huf2Co9/nQQb0ubIlHTRIbZW9cPThtf38pSBbSZm3M0ONX2gksKanWjDgpQOvgUt2mYuMPeS7lavL8sl8xWAM41+qIdVb48DVFpoku51oKpEeHAc7PhC6SE0YixiWvt+ZrQtnF+2rFPazo87gzFUq/6iGCQ3XndEB7rbCoqhKqvemGtbZNH6z/AH8w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(4744005)(5660300002)(8936002)(336012)(86362001)(6916009)(2616005)(186003)(54906003)(26005)(1076003)(2906002)(81166007)(82310400004)(356005)(316002)(36756003)(36860700001)(70586007)(4326008)(8676002)(40460700003)(6666004)(7696005)(508600001)(426003)(47076005)(83380400001)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2022 15:41:40.6301 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79dfc8ab-42bf-4e22-e94e-08d9f93e7ba5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2632
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
 Chris Park <Chris.Park@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Martin Leung <Martin.Leung@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Chris Park <Chris.Park@amd.com>

[Why]
HDMI Compliance requires VIC to be set to 0
on 2D mode if HDMI_VIC is present.

[How]
When VIC and HDMI_VIC is both present,
reset VIC to 0.

Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Chris Park <Chris.Park@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 4367a6e0c224..0cdceb97766d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2615,6 +2615,8 @@ static void set_avi_info_frame(
 	hdmi_info.bits.YQ0_YQ1 = YYC_QUANTIZATION_LIMITED_RANGE;
 
 	///VIC
+	if (pipe_ctx->stream->timing.hdmi_vic != 0)
+		vic = 0;
 	format = stream->timing.timing_3d_format;
 	/*todo, add 3DStereo support*/
 	if (format != TIMING_3D_FORMAT_NONE) {
-- 
2.25.1

