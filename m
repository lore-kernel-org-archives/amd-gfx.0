Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79883ECAAD8
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Sep 2022 00:19:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73B8C10E9FE;
	Thu, 22 Sep 2022 00:19:56 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2060.outbound.protection.outlook.com [40.107.100.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB56310E9F2
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Sep 2022 00:18:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DunSSJRaMhVAbXVErWQjCqqIU/1Ge248ioWhNN7qFSRJ8zUXiW6zX7RD7oLDuzD4wtGyGeBhQoFqV8lYOcUO2nJwOYVLRQ2DqKEgSMlw8Xjqyah1aja96XhvdVUkU+rExT2YxUog3R+s6Htmv8To7KeLVrNqiE6A76IVtQopZ7EoWcwOdylyVdXJ8gmbKDy6xCGLymDezgcinvH8/FMMztQQbZjQA1EmQVUxqFNhu4h5l2qGQNvJU1/F2f6Q5UBJp566B18ppZzVxCQzRtlZ+KNUn8pAjcdRccVqkXcI0g/GpeW6WtaKclDdgLi/vfFmYIMe+7PReFt2v1MZ5+YDMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ks/PXPWoynY9ekZMnJNPjHu+frbK40X1kFK+t4D8qLE=;
 b=M4w8W2YLKKrbwxzr4lB+VHEZzv4xGvC9+21YTkKGR5Qkpnt/AlV81qY5EZ58DCWA8dG51LYjpqcUUztrvaR41UXzRdWj1y3wTe4/6An3ZDKSzXAwe+gpQbn/CeKtly2SkeXGanCeKBk+/HrrXrPZDwcFmOxSzDC2jIxOlAPVSLb4IahO2IYTpqki9G9zEYoUNanLlb2VPSyL70SBP4oddo1wiIFaJA7YhsFwd5J3j9bPdYhuYHPfoaQor3xzruPJPKgTQdTLFlPjedITVim6T+gwwXUWiiPygkXh/hz3R/2SsVBgVYHBYHDvjWdoW6wz51aOljOLIhrsoziwwNbcBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ks/PXPWoynY9ekZMnJNPjHu+frbK40X1kFK+t4D8qLE=;
 b=FDdhxxPt6sodYJUipo22cNiqgqYOYjX36LsxEtYIhY4RzgzCMPfyk2+N3GDTGz18YBtjWNlOZJs72lWn4SmZTkZRC+LiOrLeF56FQaqEoQClPhBdGAw5mf6r2EMH22nmZspfsIJGlT8BAafdKlNY6GotN0EVdlAi2XkCWT9ggpQ=
Received: from BN7PR06CA0042.namprd06.prod.outlook.com (2603:10b6:408:34::19)
 by PH7PR12MB6859.namprd12.prod.outlook.com (2603:10b6:510:1b5::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.19; Thu, 22 Sep
 2022 00:18:53 +0000
Received: from BN8NAM11FT073.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::fd) by BN7PR06CA0042.outlook.office365.com
 (2603:10b6:408:34::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21 via Frontend
 Transport; Thu, 22 Sep 2022 00:18:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT073.mail.protection.outlook.com (10.13.177.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Thu, 22 Sep 2022 00:18:53 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 21 Sep 2022 19:18:50 -0500
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/31] drm/amd/display: Add explicit FIFO disable for DP blank
Date: Wed, 21 Sep 2022 20:17:57 -0400
Message-ID: <20220922001821.320255-8-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220922001821.320255-1-jdhillon@amd.com>
References: <20220922001821.320255-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT073:EE_|PH7PR12MB6859:EE_
X-MS-Office365-Filtering-Correlation-Id: 51740eea-674b-4b33-c810-08da9c300804
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DkQdMNT6narX+nITY+SQx7CRGHOJi0jqzsvuGZbPSHmc/XVScowLaWMaZlD+iFA2nXRvEa8db5Ll8cggctpDRYzo71scvRkB/NxJ8xvkA5rcJNEFpwqh1uyNBkmmFMsPi5cUQ+fsJwNCE1h/gB8d31rPb1nc4TuRNM4I1JmKr6v7/nbzHJ50ih+i0gCkI1vClc94AguDe9BAQzgkImtKN2JnIR5hdzMwZ/HgVZtIQ6ivcLuiD1TvcQwAZxkFiDbrTSVR/4cYe0wJe+yNQWl5rvu7XiFpW5J3cj7gL1NoT8FV6gcRVoJlqtN8/ZQCYCDaXm1dKL2nrSRF6gJWrfKoqsZa6vA+jqszQrtHVwRTPHVBjHb6az7gWuckXY23nVEWaeAX9HlZThUalzyceZUjc19LnqfEM7DAF0GTga7aVBH0/Z4MQfaUJuApdund+6pglaf2KUDk1FqsyE6nE6Kn6IGVkaQqo3tyM4lJ1hukbUGZDT5AzqXO0eLvCNjkLp+UsgPGhmA7KIffEQv0Gfrk1AF1QgAIjMXpzggcyeWLtoaqcD0mRLDN5mCmlf7UPuSclk9NrRmPpNoYYjo3WwyIdflZ9vQTwfYgZLLqvBviIpIEbmk5ZBUr4J33ibL9tFSf/osyUnelVTCaDAo4d3701V8w1FqKaYfSDqOhxIewFDi5bC8lX/W1kfSjYYZjj5xlEyn/hOlFiMKXBaKtt7YJr5RP3k5caODOsPhhFi3lqC5X32WG9sBXaL84uaBQo7OZgiGpK+Dz0qiwS3TbrY+L1naPwu+UkEVQPmiutbKU+rX886zv6CEZAXlXei3xnDPR
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(83380400001)(1076003)(426003)(336012)(186003)(16526019)(81166007)(356005)(41300700001)(36860700001)(5660300002)(47076005)(2616005)(40480700001)(8936002)(70206006)(2906002)(82310400005)(8676002)(4326008)(70586007)(82740400003)(54906003)(26005)(40460700003)(6916009)(36756003)(478600001)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 00:18:53.2459 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51740eea-674b-4b33-c810-08da9c300804
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT073.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6859
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
 Syed Hassan <Syed.Hassan@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
We rely on DMCUB to do this when disabling the link but it should
actually come before we disable the DP VID stream.

If we don't then the FIFO can end up with underflow that persists
the next time it's enabled.

[How]
Add a DCN314 specific blank sequence that will disable the DIG FIFO
first.

Reviewed-by: Syed Hassan <Syed.Hassan@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 .../display/dc/dcn314/dcn314_dio_stream_encoder.c    | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dio_stream_encoder.c
index 914c5da737ed..eeee3107bd57 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dio_stream_encoder.c
@@ -261,6 +261,16 @@ static bool is_two_pixels_per_containter(const struct dc_crtc_timing *timing)
 	return two_pix;
 }
 
+void enc314_stream_encoder_dp_blank(
+	struct dc_link *link,
+	struct stream_encoder *enc)
+{
+	/* New to DCN314 - disable the FIFO before VID stream disable. */
+	enc314_disable_fifo(enc);
+
+	enc1_stream_encoder_dp_blank(link, enc);
+}
+
 static void enc314_stream_encoder_dp_unblank(
 		struct dc_link *link,
 		struct stream_encoder *enc,
@@ -408,7 +418,7 @@ static const struct stream_encoder_funcs dcn314_str_enc_funcs = {
 	.stop_dp_info_packets =
 		enc1_stream_encoder_stop_dp_info_packets,
 	.dp_blank =
-		enc1_stream_encoder_dp_blank,
+		enc314_stream_encoder_dp_blank,
 	.dp_unblank =
 		enc314_stream_encoder_dp_unblank,
 	.audio_mute_control = enc3_audio_mute_control,
-- 
2.25.1

