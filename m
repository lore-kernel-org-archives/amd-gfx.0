Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C575C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 10 May 2022 20:45:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF42910E81A;
	Tue, 10 May 2022 20:45:43 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1022E10E842
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 20:45:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L4T9+49VCGstxeEtktmkiSx0k9FVfKGkkvKc38uhXl2JH1c/8uiX2WwuJyN60mAv029oLDyB5Y8+YdZPRGay4ayLkKtr/KnC26a8talPQqOQkcUPz92Pf9/aitPZ1uUzVSjgu+Umvw35+p7yXs0spBKBWJQV9vq/j+RDcy3oo1+8jCBhBSSA4D10obEZL59vKQEop+0FH6aN0Mjw09T5sY/LKxVCde5sCFjT5wI9JVgDtxeoASMzAgxvRY2/MjaiM/Hm3B7Hblo3cFxDcyVxvlJDSeJsHtT/V51Cc+h65jGoCQmiudHJlxFU1Uk2Dvwfshti1BAdcQPt4+XgxpeUQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dtv76hlIV2IUTnh2ykvtCJPLNelPT35kJNO4BEApYWM=;
 b=lxYXgH4+J3xUOcXH7c92KTfNIndXuG6ZPo9/IxdG5n5qipH1j0kH+dkVez4URuOaYweCL3rD9c/oDss1/85fEWaSO0pGOWY6DoFhip5xtw9Z7SYg1EED7qI2wuaUghw0YNK2iZowbHDXvOgCM55BwOlPIkkgta/46n+msMqZGcco2dns485bxRMipWoAXvUClcr1VbEEbhk4nvQ6JSvKSzrJBGhyWH/bN3bqjynTygRlpugv4vl8LrSwPp5Tif/Ow8CB49XTj7iUJpg45IroVpmcdurcExTEVjfL58kd9f+4HKNqZqTMQVC62Nqo7YxcQL3cmnBLIpzpyr+xGKMc9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dtv76hlIV2IUTnh2ykvtCJPLNelPT35kJNO4BEApYWM=;
 b=F67zQZUmniX7kSuoM2jfyRAGW3Z/V7WqKmgBAyngHEvsIVY+t67l3jiWQLv31rDuC51+cUymd8zkFhFDiHR1McpsiIwexNDh+cFIVXuZH9OXP6xbFCqZvUnTAh1wOKQrnc3PD5RtyKsKnzmvCoBpsUC+BLTwU8b7AU3uDcyUOxc=
Received: from BN9PR03CA0213.namprd03.prod.outlook.com (2603:10b6:408:f8::8)
 by MWHPR12MB1629.namprd12.prod.outlook.com (2603:10b6:301:3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Tue, 10 May
 2022 20:45:40 +0000
Received: from BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f8:cafe::fb) by BN9PR03CA0213.outlook.office365.com
 (2603:10b6:408:f8::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21 via Frontend
 Transport; Tue, 10 May 2022 20:45:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT037.mail.protection.outlook.com (10.13.177.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 10 May 2022 20:45:39 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 10 May
 2022 15:45:39 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 10 May
 2022 13:45:38 -0700
Received: from xiaoT.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Tue, 10 May 2022 15:45:34 -0500
From: David Zhang <dingchen.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 04/19] drm/amd/display: update GSP1 generic info packet for
 PSRSU
Date: Tue, 10 May 2022 16:44:53 -0400
Message-ID: <20220510204508.506089-5-dingchen.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220510204508.506089-1-dingchen.zhang@amd.com>
References: <20220510204508.506089-1-dingchen.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1cfcb697-81bf-48ac-8a76-08da32c60b1b
X-MS-TrafficTypeDiagnostic: MWHPR12MB1629:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1629C4340A8EBF78892491968DC99@MWHPR12MB1629.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uv7pLZ3rQjPvVZ3IZ2kl5lBiZ8ZOvOypFEheAsTO2MsvTsz/Yhe2+Mgh8QqgUo5d4B8wt6VAu/7jawmPW1w1wIUIgfhIoCCQXh8k8WOSJ0C0BobCs5tuOoX3/VhziIrDOXihm5eEoIOpNIlSSR943GPUkmRl23Qy9b1s3QHVkJduZpON0tKbNgSgVXRjUDBpnW3dJon/mtqqZ9DcqI4jrXfKuT00drv8SkVPYu3ZEzckDXlDMWarafW2EegNLIQr924TwSJecD39M7P452zKQ4k6CzEt9/k4OgKy+qU/2Ep4S/h6l+0EUNw9YsaUEWJmeizSW/VPgOIqIEx4iIogmIiDGk6mMQeVKJ9F5Qt//7Lm8e/AUILmSCf5Ju8z1eLUBWtdDiO6ErTgcTeBTWCH4WNNzAlEG1T/diEj9Y/TgDaWywOe76NJthqRFhLOIyVwza9/Yyw5Ogrwq++3/F1KHo06Q7KmkBFb3QRWPejtxQp/mPABGFbnJwleekEW4W4Dee2tbZcH+8oRuy3WHkI18jCEd3ep9RnNfwW8kWZ9Pe3krcmSKIykJX16xblEdLv54QRrKYWiAnr73D5YuA0A/uB3GUN2xuPNv9bs10hNrcMm3CI8yLMQrmITRnSdzu42seyV56QLsAsthzWE1+gvQpM9JZdGYzjbexu02vkBawFnsPNLZrKxsqQJHZY5HkC+h7x4w/X5udBHZPS0momf+q+/EmNQXbGl6JUNU9NBDjY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(508600001)(36860700001)(6916009)(54906003)(40460700003)(356005)(81166007)(316002)(86362001)(83380400001)(26005)(4326008)(8676002)(70206006)(5660300002)(6666004)(186003)(36756003)(7696005)(336012)(2616005)(15650500001)(1076003)(82310400005)(2906002)(426003)(47076005)(8936002)(70586007)(41533002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 20:45:39.6832 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cfcb697-81bf-48ac-8a76-08da32c60b1b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1629
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
Cc: stylon.wang@amd.com, David Zhang <dingchen.zhang@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[why & how]
Based on PSRSU specification, every selective update frame need to use
two SDP to indicate the frame active range. So we occupy another GSP1
for PSRSU execution.

Signed-off-by: David Zhang <dingchen.zhang@amd.com>
---
 .../display/dc/dcn30/dcn30_dio_stream_encoder.c   | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.c
index a04ca4a98392..e40f01b596ad 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.c
@@ -419,6 +419,21 @@ static void enc3_stream_encoder_update_dp_info_packets(
 				&info_frame->vsc,
 				true);
 	}
+	/* TODO: VSC SDP at packetIndex 1 should be restricted only if PSR-SU on.
+	 * There should have another Infopacket type (e.g. vsc_psrsu) for PSR_SU.
+	 * In addition, currently the driver check the valid bit then update and
+	 * send the corresponding Infopacket. For PSR-SU, the SDP only be sent
+	 * while entering PSR-SU mode. So we need another parameter(e.g. send)
+	 * in dc_info_packet to indicate which infopacket should be enabled by
+	 * default here.
+	 */
+	if (info_frame->vsc.valid) {
+		enc->vpg->funcs->update_generic_info_packet(
+				enc->vpg,
+				1,  /* packetIndex */
+				&info_frame->vsc,
+				true);
+	}
 	if (info_frame->spd.valid) {
 		enc->vpg->funcs->update_generic_info_packet(
 				enc->vpg,
-- 
2.25.1

