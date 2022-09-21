Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAC90C6FA8E
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Sep 2022 23:18:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0E0710E980;
	Wed, 21 Sep 2022 23:18:04 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE7E810E970
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Sep 2022 23:17:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JHJzhOsXt7SSsbMf/8gcasUzXnhfdB/s1sHDgeipjQGe2dQlrOjz8M2Oth8thqojeiISBUX/b1IhmbtRbXgKQE07IbXQ6otmtfzMVfCyIEW9+V1xLLlMIceb4s8W8gGUxU1+ZgCrXg21aZvzJrPONlTrcSUHYXgLIQVM4GTxQyzoa1PMAfUh5ohrXBzht24f3srvIXfQDXPgyVwr91WIyqGy+bioj5P0GYi8FkJEnimoDvPZSM4Ka71FU5ua9B1OgvarCPd9Xjx8GiUCOW9to14yMJZRkzlhv1EMTwug/ysjJDJyYShiNPWYJ/XTQjxg2XgC9mwCr6xWT/3JTpbWqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ks/PXPWoynY9ekZMnJNPjHu+frbK40X1kFK+t4D8qLE=;
 b=oHtyr5q0Ea3GH9GLFTwhxrINzt53A7XeyQFCbb2WjL080HcxBHz3sFgc6UQgmoaxLfh9CA/lfTWpz5ISn1Oad+Dt/CUHofET0wzjL2PvtvpMgqU0wrVnLPKrRQVFSPscn4bMP4DzvVGHajiM0K5oVDvyr9s9mXPRe6YW40VGEICNc+WFHCL6PsafR/zkk12+yJUmNrZrSd4EKIahqLh2fTDEELjAS9PIYa0GArMkMiigTdGHogz+qDupNeaBdKE6pbAfGBccnx6zFAgT3afEr2f05uGPHtim1nVtmxvRz/hP6Mzxla1ZFkDa17PBxBdoSaus/AB5i9wrqi8bNyNiaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ks/PXPWoynY9ekZMnJNPjHu+frbK40X1kFK+t4D8qLE=;
 b=dPk2VPf9iOSN1zYkjFNKjdi2NKrfPId0VmASh6gvz1Pob4McmSzgKxlLCpuvJbJNBkVPGcKFyUxEO79m/krlaU+iJOGwa3WT8kXuM5SKyM1X3uI/5wRKPQQ7oCvOyC8/dS88VeFhqS2+JECvpVGImlbFScIaVP/Dvhi3E+8CLjE=
Received: from MW4PR03CA0171.namprd03.prod.outlook.com (2603:10b6:303:8d::26)
 by SJ1PR12MB6338.namprd12.prod.outlook.com (2603:10b6:a03:455::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.19; Wed, 21 Sep
 2022 23:17:42 +0000
Received: from CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::e0) by MW4PR03CA0171.outlook.office365.com
 (2603:10b6:303:8d::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16 via Frontend
 Transport; Wed, 21 Sep 2022 23:17:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT047.mail.protection.outlook.com (10.13.174.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Wed, 21 Sep 2022 23:17:42 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 21 Sep 2022 18:17:40 -0500
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/31] drm/amd/display: Add explicit FIFO disable for DP blank
Date: Wed, 21 Sep 2022 19:16:50 -0400
Message-ID: <20220921231714.303727-8-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220921231714.303727-1-jdhillon@amd.com>
References: <20220921231714.303727-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT047:EE_|SJ1PR12MB6338:EE_
X-MS-Office365-Filtering-Correlation-Id: ae5a08c4-0bd9-4af5-684f-08da9c277be6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: INF4PO+gvByyzDJuvNo6zM73NMYx9dmtCBpI6fcIPGivoAJmbnAMPC8zkoAljEaCJvES3VN+CbOLNIHMcy06hvuZGOxKTviEHpv09mYHWVXoDUKi6bhlBrb0LTN7k0pBilsbLvYjCwPfe80BPsOof79wW3uCu4G0OOW64/VAHLqeFHQM6IgHzkR8Fx4SMAAZWlo1GoYcFqMbkrxvHKKuBhdzO1LeVhS8GZELLFK2uJEqiT9sEzvzD1mL6acwRb6jGeeGytPILfNh2Ze9Ll0q+nWOE5NnZspXEi7FHkBOugfCtw4vObB+LWcCnelsbR7M0XuUHPACzdU6y12q6Q/DZFUfCYTdVXMGxXAtL2akX2Xva7nkOC2FYHsB1nocaGpvrbVf+cfYoNbAfEHxFL16LQK+mOoR+EFhVhb1qcTmeJzw4bKRo3Qn+14W/S5CGKhbDIYC5h/4fJupu/n4imqJ0syQlp+W2hyQQTuSPJx1sc62LVy+QctsFoqHgNM7ABH3wwU501mPebVgvroHhjkmqB1pdpMNzOuqF6c5X3qPWaC9kVu4pGk+Lm7YMcinl2TgNgjyEA5P6eow7XDRsNuWbpp2Yh9ffKm4TKA3Sm1aCqbDQkWMpKtjVnK6U5MQCHRLqGtGr2ru2rd5dJALy8IBwKLaFXSnHaDvy9PI7t+ktW0q4N+Ut8krCU3DqqWTVzZkL19CnL5roIXPyoaRx0EBh8/I3B8hd/iyVglxEL7QHe4ClF1CZTRJ5hSvs/RAqbozKtbh8FzJjzCZbXzgi+jbeG38v2hu3Mnj98d8rXu6EuzYUfawIyJejU+Kayoypd2r
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199015)(36840700001)(40470700004)(46966006)(336012)(40480700001)(6666004)(478600001)(82310400005)(36756003)(83380400001)(316002)(426003)(82740400003)(36860700001)(54906003)(70586007)(70206006)(5660300002)(8936002)(8676002)(47076005)(4326008)(26005)(16526019)(81166007)(186003)(1076003)(2906002)(2616005)(356005)(40460700003)(6916009)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 23:17:42.0826 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae5a08c4-0bd9-4af5-684f-08da9c277be6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6338
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

