Return-Path: <SRS0=i1uT=OE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA0CC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Sep 2021 14:59:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 999446103B
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Sep 2021 14:59:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 999446103B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDA376E4D7;
	Tue, 14 Sep 2021 14:59:35 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 172806E4D2
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Sep 2021 14:59:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZJUqQraoeIuJM20iM8V0Jqw7Ym9BnDUByA0j8+5MoDgm/mgDbJcD7FICIkGVVvlPJCc0A4DS2q3w5jMussUlil+Uh9qjRBndAEaxfWymWe3ncrq3NiutEzoOi9gyQJktGjH/8jA9pkUhd5JQnasPRYWT0VAYnGLN6sN3dfq4S8RB/eT5lOrcYUZsFKvADoWYacucruq4l6P5TjE87ZdaBAXrOzIWSQZTIQOTCzuhfBFkPB6iWHjKWhUs+ovPlx8CugHS4bQ02LavrbrPYQgy2oSdCIQDeGc9cxU11nYbqF5d/knBfpUwAMf7hZFBE//x4YcP7RfUAkcrJkGWzhFHbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=Zl+DQRQ1TdM+nM4cen+ere8lFHIYmyuZ3U0J0EWJIuc=;
 b=lZXqkmhZLCCt8VDsVIViPp+3BhMUtIHprEKffglE6W6zFIMAh10J5zcWUdvfTkwEBhsFSyC/lta72x4aURmy5xBiOL5SCRUQE8w4KXBr3UAhgIl+fOtTOKsEwUKrKgSvK9f7YqdEUdI2W1GwefIMNgASwND6G4xtMJNQmUqHMjEg1fZE1ij/kih87S6QDTeF8XXUhBL3su+KqVI4/10VutjyvnSDV0sQFOgxHNwtR9PwR8NBibgzpPrZu5eleMSEGTo3ptaQQWBBDgfzfVKoyl28XyIV5oAK9CtnSDsUW9pSUz9bKNfHvKDPfyoK1of3HPlVtHqEhfpUVVPOTA5YbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zl+DQRQ1TdM+nM4cen+ere8lFHIYmyuZ3U0J0EWJIuc=;
 b=fffbNg0QIXdnAeMJ07/q3wxaKK2A7gMi4wukBM5vINvhaUsNLtEtkw2A3I+YacsurMKeeqH4BZX9wNDbBVzkRgRWLU+B1VBeeRvtx2+9wGLhKMrc9XapV0VKZLGDeEhiKq6+EgqHxnFR8gTYyUHm6iLlC9ixbIydJOzbczb+ncs=
Received: from BN9PR03CA0440.namprd03.prod.outlook.com (2603:10b6:408:113::25)
 by MN2PR12MB3504.namprd12.prod.outlook.com (2603:10b6:208:d1::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Tue, 14 Sep
 2021 14:59:31 +0000
Received: from BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:113:cafe::58) by BN9PR03CA0440.outlook.office365.com
 (2603:10b6:408:113::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.15 via Frontend
 Transport; Tue, 14 Sep 2021 14:59:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT004.mail.protection.outlook.com (10.13.176.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Tue, 14 Sep 2021 14:59:30 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 14 Sep
 2021 09:59:28 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Leo Ma <hanghong.ma@amd.com>,
 Mikita Lipski <mikita.lipski@amd.com>, Aric Cyr <aric.cyr@amd.com>
Subject: [PATCH 1/2] drm/amdgpu/display: fix warning about indentation
Date: Tue, 14 Sep 2021 10:59:11 -0400
Message-ID: <20210914145912.1569716-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f1d4529-cefc-4ae3-cf07-08d977904197
X-MS-TrafficTypeDiagnostic: MN2PR12MB3504:
X-Microsoft-Antispam-PRVS: <MN2PR12MB35048ACD893D94159F61ED10F7DA9@MN2PR12MB3504.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WoX7RYbX+qKy86AKZG8V4n/BakhZ3DdVcXlnMzY96ltCHVmGoXcCUdaRG/Bp/tLij/spHqZvvD9xsAHOuIo6lDss/hFLNkmP1f6Q8OCLsH4+bFdRS+Ql3xn5NUNycxTLa1iuKvXj9R37fjV42imUtBR/MbvMRQUjMBsXfqyiZk2VwRD265DkOqM2rml/TGgGUT/QUAk0StTxxqOv39GtFGT0OjrkOPBPwgakbbdM1caD8118xGZWAb1zhwx25lcgwRaAxFQRwWHRv8LhRKU+tT6ae7piYmg43Fw8iR5FEeb+oh65THkQ8IGBrZMC8qdvZ0GSvmwzJL5XBLy+Um4HxSH5Bj4015Yv5LEC23s/hm3JDOdalA8FTb8GDhWoc9GggPfVdxtpeURqD548XC8BRDfysSrJ1+00s6rD87FGKMFeRs6fx2IS0aBHYU+0AofKD9nTn7BHm3Iy/8oGQCftrHOD62HwqE4rzhy1Tk0fxwRuTEAaXTPLTmj01UeXpQ71V1Ha65T+8cMBR9VpkLhC8k8Wp/BpHzLTNiGFy3ZHAOB+xP8aNDbOt1AXZSQpW3MD/k27wIxWVhyAvhlvFCOv9PkYJrJRIRIaBcgyNAePnTjqvMyjJIMkD+zgC2fCfR7VGaMdJ4mIJKRpbXsq/HW/DMooxo3/m/Hyeg9jKEuhEO2KiX49rkihy2HQfUtmRPaGfC94z1oZzF/IgmC4nSgYWJywLrqrb8sxlO/xYIttHjk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(39860400002)(396003)(376002)(36840700001)(46966006)(478600001)(2906002)(36860700001)(81166007)(47076005)(2616005)(1076003)(356005)(82310400003)(86362001)(316002)(36756003)(4326008)(54906003)(26005)(8676002)(6916009)(336012)(70586007)(426003)(70206006)(186003)(82740400003)(16526019)(8936002)(6666004)(83380400001)(5660300002)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 14:59:30.8600 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f1d4529-cefc-4ae3-cf07-08d977904197
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3504
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Looks like this code block was missing parens.

Fixes: c0ffd1945147 ("drm/amd/display: Add DPCD writes at key points")
Cc: Leo (Hanghong) Ma <hanghong.ma@amd.com>
Cc: Mikita Lipski <mikita.lipski@amd.com>
Cc: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index ac4896ff912c..6663cfc4eb71 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -2370,12 +2370,11 @@ bool perform_link_training_with_retries(
 	/* We need to do this before the link training to ensure the idle pattern in SST
 	 * mode will be sent right after the link training
 	 */
-#if defined(CONFIG_DRM_AMD_DC_DCN)
-	if (dp_get_link_encoding_format(&current_setting) == DP_8b_10b_ENCODING)
-#endif
+	if (dp_get_link_encoding_format(&current_setting) == DP_8b_10b_ENCODING) {
 		link_enc->funcs->connect_dig_be_to_fe(link_enc,
 							pipe_ctx->stream_res.stream_enc->id, true);
 		dp_source_sequence_trace(link, DPCD_SOURCE_SEQ_AFTER_CONNECT_DIG_FE_BE);
+	}
 
 	for (j = 0; j < attempts; ++j) {
 
-- 
2.31.1

