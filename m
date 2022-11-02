Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2399C4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Nov 2022 16:03:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2468810E4D9;
	Wed,  2 Nov 2022 16:03:03 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2043.outbound.protection.outlook.com [40.107.212.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B60D810E4D9
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Nov 2022 16:02:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eXMAoYURCeJnYmmz8aSU5urPoPBYaDiFl9If9WYUlngcWBXRHlFXiITGxYu161kaqCS/sZA9eFClvupQF2REh8ijka7bfExu2dVw0fBO2s7aqI3J5kaLTTV/73uIjmEe8KtDYDMzy5bXwH/alssHZaUKviXPpIiUNAZC0vCrLkkV+KaW/Vf275LHqqGD5M4iZWevUcOQvBc9ZY+2sDBIYVDkuDfZR7kRlrEa9VNsQa8R6X6GxRS0WRvUwIvOGaEhgxtAAltz8oFEy5icZrkbnxRvAF99iByvCL+fYN8V4xrvigv7pm1UAFwP6M9ii7mHZJ51gT04a0bCgn5VeK2Tvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=msOPALV52j9xl9b667f8Ua1276gfYnqHfxvyVaP3IMo=;
 b=KXG8Y2455O/WegxBbpkYuEv01Jcx5YUFUJTKdwiNG40hVsYHqhSzcRLy5G4NBTBkMtHT2S1aT/v3SSFqoAhyz3bI7oP5fW58hD38HdQovipe9eiKoNzpSqHpilEAyH+RAKEmQaaGj6F+mQMOMzrTm5j+YgZm82yRSEHcow7jlsmTJj0Amjq2MIIjVNgAyomqvPjmA+Ux9/Z8mhAkBU+kXv5OMy5qZrWKw1JeBf4VddA5Kt+UQukFxwZy/25+cfi91uJcv1j8yyahHYJKVxUIvkG+qbpnelXCE+OR7PKDvRDqnGeyH6/W90chhke2XIgwM53KeN0ToaWTdBsDztdJbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=msOPALV52j9xl9b667f8Ua1276gfYnqHfxvyVaP3IMo=;
 b=r6GxatPZAVITW8ZyQBM06ePUpHN958ldgQYMEqDwRd61Zj8mh+ITgg8MoG1iXKgZn1xNxaKK2L38Tk48tPIRZjIln1M8qLVGN0x1KGGgHSRmrrh6TsitAvZeNysZFnMDz+Zl5iEKVck6ULsD9lQRTO8WkU94R3sv7k4ZVoL9Dqs=
Received: from DM6PR04CA0027.namprd04.prod.outlook.com (2603:10b6:5:334::32)
 by DM4PR12MB7501.namprd12.prod.outlook.com (2603:10b6:8:113::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Wed, 2 Nov
 2022 16:02:56 +0000
Received: from DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::68) by DM6PR04CA0027.outlook.office365.com
 (2603:10b6:5:334::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21 via Frontend
 Transport; Wed, 2 Nov 2022 16:02:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT041.mail.protection.outlook.com (10.13.172.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Wed, 2 Nov 2022 16:02:56 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 2 Nov
 2022 11:02:56 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 2 Nov
 2022 09:02:55 -0700
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Wed, 2 Nov 2022 11:02:52 -0500
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/22] drm/amd/display: Wait for VBLANK during pipe programming
Date: Thu, 3 Nov 2022 00:00:56 +0800
Message-ID: <20221102160117.506511-2-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221102160117.506511-1-HaoPing.Liu@amd.com>
References: <20221102160117.506511-1-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT041:EE_|DM4PR12MB7501:EE_
X-MS-Office365-Filtering-Correlation-Id: aae82cef-fcfe-4e58-dd81-08dabcebb4d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mSCIvwEr6OHIcdQR9chasPix3DWA0oLGS0KC3Y3kPj+yafhPj7OVXjhfGUu4SNMcADUXXxVqOFdr+R2+d7QEMca+J4YzqqmtH48bqoZzrag6/bLlVe7lCKHe50pQ2rAsLz9FFyIyp1JF5hpN8989ECm6UtTF/M3rjPG8d0psWoWUkw3HtrjhXIO/IlnkYxCBBePQRLI4f4e/qfKsDkqDeDx5uJkLQTSHo+ddozCsBtS4uj9jvb31KDOQIWb1A4Evc8fxNyyk/VH1xLQZ0UCD3Dgvt4SfYtSt5Ctd9Ek3Y4rnye27M7FjHvfVJryRLfAsAmTLtq6MGrRZfm73FNaFKHtn0QbMvorbfbGFlZUOFpaajFwJtchEE95wfI+HtTPwm6N58RZzQds0R+S0jLmZ3az1qRO53bjclXYPzqYDGCZLuc5ajKARRfYuzZXw/LAhsfgrZ4dNCWytfQD9HrBIDQ++cFWt4iZG495/uwwtHpzw+Yw99L0TYamO2D2kduy/MZyQNfW3tYtpmlHB3AhfuCiLBdmhnAbExCnntSKDWx4Ggn7mQDdCggKjDreUcAUpxjs40pn1kDfSKGTg6/fyS0MO2UrWvwziutOL0SkD1bZamIQEYkyczzf5Tu9X6GBWvF9HalFKiCM0SOqS9jndUJ+0RlsVJXtnr7ajjSRlDmSLNxsjyYKVnhK623sleN5uoJQeW70861YTpcUpeooO5GqI3tHGy2sMaohrJWsykdvIDEFb9RzKNLIh6p96Ve9aXyPR7ICXOaY3ud5SiqhnyKKIigBhxT6cO+zm1Tn89876XnX2XR9vq/0aGs2Bxaho
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(336012)(82310400005)(2906002)(70586007)(36756003)(5660300002)(356005)(8676002)(4326008)(81166007)(7696005)(86362001)(82740400003)(316002)(54906003)(6916009)(70206006)(40480700001)(8936002)(41300700001)(26005)(47076005)(426003)(1076003)(40460700003)(186003)(83380400001)(478600001)(2616005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 16:02:56.2619 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aae82cef-fcfe-4e58-dd81-08dabcebb4d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7501
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Martin Leung <Martin.Leung@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
- Wait for vblank during front end programming
  for global sync to ensure all double buffer
  updates take.
- This prevents underflow in some cases.

Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index f3334f513eb4..b465a83bde6f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1663,6 +1663,7 @@ static void dcn20_program_pipe(
 				pipe_ctx->pipe_dlg_param.vupdate_width);
 
 		if (pipe_ctx->stream->mall_stream_config.type != SUBVP_PHANTOM) {
+			pipe_ctx->stream_res.tg->funcs->wait_for_state(pipe_ctx->stream_res.tg, CRTC_STATE_VBLANK);
 			pipe_ctx->stream_res.tg->funcs->wait_for_state(pipe_ctx->stream_res.tg, CRTC_STATE_VACTIVE);
 		}
 
-- 
2.25.1

