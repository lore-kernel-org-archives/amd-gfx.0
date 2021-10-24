Return-Path: <SRS0=f4Zr=PM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A577C433EF
	for <amd-gfx@archiver.kernel.org>; Sun, 24 Oct 2021 13:32:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8EF660724
	for <amd-gfx@archiver.kernel.org>; Sun, 24 Oct 2021 13:32:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E8EF660724
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76BAA89E3B;
	Sun, 24 Oct 2021 13:32:46 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA28A89E3B
 for <amd-gfx@lists.freedesktop.org>; Sun, 24 Oct 2021 13:32:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KH1BrfFy1QbQuFIQeMUqmC89sl2aKBz6ORYfgXXMpp/W+g7qq/h3gRlhVdwEDp33DuxX4YHxez/WphlSsqjGCyPY3FzZRH4F22ICy80VWnd86JfU8SBiUY8XEpKtdu0y5zpcP69+XmZyljY7hjE7L6I9PbdS3bSeJ0iRd2TP+53xwHDb+H4eBsVI3jtGs0GC7E4tH/dGkzLPs4mOzmkWXMOYlLG5fxzS7qggu6wXCVHLH98N3LAvnGjbLY6hy27s0KbaAqcMMJiulXb8ivnTSUEbvW9sOrE648BPkwjjvvsLuPbCD9z/JESXC/AkjuND4rpycQDxopAVVthJ6xgCkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lCM4ZEl8LczSbiA/6ZpashKk0PPnr+ldAYUzd+Kvwyw=;
 b=V7xm22j0tJQbMXJbB5kMVewc+wVI6AnGAMbz7w6Bz1Vpi17Ou9SO3gipBk8bjHLa6uMav9nOgG1bISAjb0MWBYHRpJo5XYWIGpDggOugTvsrf4p8PVWP/mGxhyw1cK6WoHkAeCxnK/hFSSugfFYxFlzdMGxF8qu4jP2aw1bHCevv4MxlbtFzu3s3AEM3T67SJA4kXG6hFp3jRyN5wBvgK/7SW7/XjtiennST9plba4XwHsOE0e7gx7JFziIbyWXL6vw+WpCTUfXDeCaOwAtco4w9VIuvqY8HLimAfVdde/WmZOPkUQRTpI62I9UGK3V8lDMtaTPfZL84DejLvMjpeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lCM4ZEl8LczSbiA/6ZpashKk0PPnr+ldAYUzd+Kvwyw=;
 b=nTAdlz1Bdidv6cHGeECEBeVqQlwgs6CqbSVw00L7JtdIVU7z+LfuaJnaxS+SoiIzoE3JBtiUTr/zkGloVdj7zx+cv3ORAraM7AkX4h3rKPnoNg7FZCyoMwDVkJfFJkzV6Xuz2RrSQk49xU37JQt71OPKd1/8GE+c+BDAypWlbps=
Received: from MW4PR04CA0084.namprd04.prod.outlook.com (2603:10b6:303:6b::29)
 by DM6PR12MB4497.namprd12.prod.outlook.com (2603:10b6:5:2a5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Sun, 24 Oct
 2021 13:32:32 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::bc) by MW4PR04CA0084.outlook.office365.com
 (2603:10b6:303:6b::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend
 Transport; Sun, 24 Oct 2021 13:32:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Sun, 24 Oct 2021 13:32:31 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Sun, 24 Oct
 2021 08:32:27 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
 <agustin.gutierrez@amd.com>, "Guo, Bing" <Bing.Guo@amd.com>, Chris Park
 <chris.park@amd.com>
Subject: [PATCH 18/33] drm/amd/display: set Layout properly for 8ch audio at
 timing validation
Date: Sun, 24 Oct 2021 09:31:26 -0400
Message-ID: <20211024133141.239861-19-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211024133141.239861-1-Rodrigo.Siqueira@amd.com>
References: <20211024133141.239861-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec1f4337-8a01-4c01-56ee-08d996f2bb61
X-MS-TrafficTypeDiagnostic: DM6PR12MB4497:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4497C5EBA4B48D6C2F37A14998829@DM6PR12MB4497.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w3ByYP0+qEtzXHsjKvJkD+Bk4kXbyVCpEJJxcNO9sMLL94O8ve2PEaCq3w9CvkiUU/nra0VQajGMBV3vD6W4XojTr/ZClOSLm3kvl4HER3571TthOvBBDWz3iy2E6UB41YJP2nLifYHWU4o8k80vEab2DUiNwIP2E+kquAYZFnJUVIQX+shYa4THa/fskGh8lUfGSd+R2qgRvAP98svNVVl65dDbqKeOmUIKV3v9ZQwAs/MQDk2KLDQ5fx7uaoOKbSGU+DtZU/NMXltTW78WnW7BtVetTuNj3h3Jir+XtGrqy7RLjPs4DQ8YkUULrzo53/sobLMOua2WZpU8Khe69JNjG+uBd3iBjk+Ta/O7FogtoBn/RdYy7E5kUhW+N1yqIAhbC7+7N2GzNYmiHFTHG0nOhnkQ2Hf2iNL/KD8EJl5iL7ghkJvavkKRvmTX7cB2+rQBJiB0KYqh0OZj4QsptjzjnWSjC+rTxBt6+ndn7BrGUfmWp1f+cLPnJV0wKNaAb5Vf5pfYjFZk4a389wfutfQXf8tnA+nfHz5zjQPpn3P+DkuaVXoQIK52+Yf1KKt2tqrvFdbmMoGv0C5U0KM/33MvpW5sBZ51gVvK4ZxpKlsuN55X6FqXImUU+zYU2lFxf3ZwDPmr5KNVJlz9gwyXZXycpbxS2m1HUzNDjbitzocMi4sTh0soPJnpWg6nKV7JZW+YcM6suEvf6K286rY8tNUOq1+TM+DhYUOrTHKDzi0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(316002)(2906002)(81166007)(83380400001)(6916009)(82310400003)(8676002)(36756003)(508600001)(36860700001)(4326008)(2616005)(356005)(86362001)(1076003)(186003)(8936002)(426003)(70206006)(47076005)(70586007)(336012)(16526019)(54906003)(26005)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2021 13:32:31.8047 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec1f4337-8a01-4c01-56ee-08d996f2bb61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4497
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

From: "Guo, Bing" <Bing.Guo@amd.com>

Why:
For audio packet type 0x02, there are 2 Layouts:
   Layout = 0 for 2 channels
and Layout = 1 for > 2 channels.
Layout will affect bandwidth check.

Currently, for HDMI FRL, Layout field isn't set and has a default value
of 0, so theoretically only 2-channel audio for audio packet type 0x02
is supported now.

How:
1. Set Layout properly according to maximum audio channel numbers for
audios with audio packet type 0x02.
2. 8ch LPCM audio is not supported for timing modes with v_active <= 576.

Reviewed-by: Chris Park <chris.park@amd.com>
Acked-by: Agustin Gutierrez <agustin.gutierrez@amd.com>
Signed-off-by: Bing Guo <Bing.Guo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_audio.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
index 7866cf2a668f..27218ede150a 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
@@ -514,13 +514,15 @@ void dce_aud_az_configure(
 			union audio_sample_rates sample_rates =
 					audio_mode->sample_rates;
 			uint8_t byte2 = audio_mode->max_bit_rate;
+			uint8_t channel_count = audio_mode->channel_count;
 
 			/* adjust specific properties */
 			switch (audio_format_code) {
 			case AUDIO_FORMAT_CODE_LINEARPCM: {
+
 				check_audio_bandwidth(
 					crtc_info,
-					audio_mode->channel_count,
+					channel_count,
 					signal,
 					&sample_rates);
 
@@ -548,7 +550,7 @@ void dce_aud_az_configure(
 
 			/* fill audio format data */
 			set_reg_field_value(value,
-					audio_mode->channel_count - 1,
+					channel_count - 1,
 					AZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR0,
 					MAX_CHANNELS);
 
-- 
2.25.1

