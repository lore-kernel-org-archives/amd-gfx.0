Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2F07C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Apr 2022 16:47:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B41110E543;
	Fri, 22 Apr 2022 16:47:37 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2084.outbound.protection.outlook.com [40.107.236.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F8C010E540
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Apr 2022 16:47:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ycu26wbtIvUnlr007qf0ZRJK0mzwayJw4fpqkDrjri5bGFuy/4DprTDbyJivaIzmaEz3k9meRUPgzQAFhJhyCXk+BxCLEmTw7AoxJHlG0t70iKVPcZZ5EFRbTfizCw+5bqiTS/nCqV5S1bVD4yctgo52eholtQHV8ru2k8xmG9OXtzB+OBNuZ1pUPTkGkDKLjO9T+uN1Lw2zegdlPRApjmFEq59O3yjuEWkXlR1VMX7tMouTnN3zMk4/t4BneuYGJTZJWsna2Oo8xZj71xHLf/2Tc8Q7Ff8cgv9QCvl0VpQ3Ung7xHliPz2FDslqeJacEOcwOfUQoBXmSeb60Jfvzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OWTpEPReVwNOH+wrUEUYE8YXKIlNcE797QW1AwEdNsY=;
 b=FCnVto0TB9WVk/vxn2Bx9P/SWbMaE5760JSCQ5Tq8G1V/FevcyBTqiknktybL4wJ6ylunfrLev8rNGoiXxh60jo08/z7s49/wK6VjHyhcPQ+OP9mFhCg0hLLIw86GSy7r9bxSejwnYipLaiHpIRKtesLXg3WypXWrOVbsOavKREkkVBGj0ePqPTngC9ceEVMCOIvFzP0XmfDMPcur9g3U+ywbg1m02AHS2V8c+uLgY1GEeeVx4vicJ5viapzJT3ukxur+p8eW9flhTpAawhsfl466+F3RlC2mkJHh7wFzfL0g8u9PtKNXXamAdIYQ9jbiV+ZSyf1IYaE1T4PeoAnmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OWTpEPReVwNOH+wrUEUYE8YXKIlNcE797QW1AwEdNsY=;
 b=sSbel+LX4XhTDkCPbCmCEIXK6dgcaMGcQXxDswqWbOGjobL4g6+/u/QUWScajidTDxIdsCAmPcl6f6GN9GG7flP9pBOHu4qKl+txF+6kpbjMHFXjCy8SyMHsTMMnW+7VJWZ630ncgUPIziCzJ8wu2PfMiABf11ocU2kqk8yUKHQ=
Received: from MW4PR04CA0240.namprd04.prod.outlook.com (2603:10b6:303:87::35)
 by CY4PR12MB1318.namprd12.prod.outlook.com (2603:10b6:903:38::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 22 Apr
 2022 16:47:33 +0000
Received: from CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::ba) by MW4PR04CA0240.outlook.office365.com
 (2603:10b6:303:87::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Fri, 22 Apr 2022 16:47:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT041.mail.protection.outlook.com (10.13.174.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Fri, 22 Apr 2022 16:47:33 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 22 Apr
 2022 11:47:29 -0500
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Fri, 22 Apr 2022 11:47:25 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/13] drm/amd/display: Keep track of DSC packed PPS
Date: Sat, 23 Apr 2022 00:44:56 +0800
Message-ID: <20220422164457.1755751-13-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220422164457.1755751-1-chiahsuan.chung@amd.com>
References: <20220422164457.1755751-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73bf1677-33d9-49e0-94db-08da247fcc6e
X-MS-TrafficTypeDiagnostic: CY4PR12MB1318:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB13189F1AF6A599C04AE1053DE6F79@CY4PR12MB1318.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8oHy3c583IC4rT5w53mGUutsHhvqt41aUdyIUg9mAJeD/95mRrPoN3+UyO39F61K0d/ZE2N72RttnP4NlV/eR6yGpeHMkhLUyHfSK2w8dnA1SsX6y5ZVLJ+X2FSOh3Eyf3sOKO/FATB6pMo3wMiJ5u7iTqdITmVzpZxPwTUkACV6NgTE9vsASYfaNYZBIjlFt9fPHvfTdvY5e2hiNzWHe/tfM5O2IurRTxAV8wBcoaP155WZOzsuVksODbV0EWhEtiWyQZco5a57KLQGcCRMGmaaIk4ZSVzxj/hxRadzBoDly6zc+iln8Uaj1kyqs+cUYwYusmsW0ZsCoZCkN4nwDH2BhlTjuio0EjhExNFQYH3qoh7pi3+FdkEUseeQ3Mw4uuXe/vyO0qYGqhU3v2l5Pywgw02FMMEyUPuXXUuNEUC56dVp0rku5YJw8AK7SvMvvQw6x29YMbKmI69ekBDwlVanMedcJi+PNBqSBUKsU3r2nqgdHBZdbFxW5/4TxFoFoA9CLVHXdpKakSxRQIgpqZ/2WHgw7LfJSfKv53la5lYxPhRjDDZj+hF4LwRnCpmEhI3NcGeQNCXKNQALmxp4MwR2+vVcAM8W2Qlgwi3+J2H28IjOFfRtgtElZv9GYQE/PpFRw9WNk64gaMF63eGIO0fkyqfTh7NonvmEDZu3Xu8DjDzMXtCqSzX08PHVJBK0mkhioOKbHhPwoA4IuivSsA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(1076003)(2906002)(7696005)(86362001)(26005)(6666004)(356005)(81166007)(2616005)(426003)(82310400005)(186003)(47076005)(36860700001)(508600001)(70586007)(336012)(40460700003)(83380400001)(70206006)(5660300002)(36756003)(4326008)(8676002)(54906003)(8936002)(6916009)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 16:47:33.3561 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73bf1677-33d9-49e0-94db-08da247fcc6e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1318
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
Cc: stylon.wang@amd.com, Ilya <Ilya.Bakoulin@amd.com>,
 Aric Cyr <Aric.Cyr@amd.com>, Tom Chung <chiahsuan.chung@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ilya <Ilya.Bakoulin@amd.com>

[Why]
Store current packed PPS data in dc_stream_state for future use.

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Ilya Bakoulin <Ilya.Bakoulin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 2 ++
 drivers/gpu/drm/amd/display/dc/dc_stream.h       | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 50a12fd08f4a..c15c46b81111 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -7578,6 +7578,7 @@ bool dp_set_dsc_pps_sdp(struct pipe_ctx *pipe_ctx, bool enable, bool immediate_u
 
 		DC_LOG_DSC(" ");
 		dsc->funcs->dsc_get_packed_pps(dsc, &dsc_cfg, &dsc_packed_pps[0]);
+		memcpy(&stream->dsc_packed_pps[0], &dsc_packed_pps[0], sizeof(stream->dsc_packed_pps));
 		if (dc_is_dp_signal(stream->signal)) {
 			DC_LOG_DSC("Setting stream encoder DSC PPS SDP for engine %d\n", (int)pipe_ctx->stream_res.stream_enc->id);
 			if (is_dp_128b_132b_signal(pipe_ctx))
@@ -7595,6 +7596,7 @@ bool dp_set_dsc_pps_sdp(struct pipe_ctx *pipe_ctx, bool enable, bool immediate_u
 		}
 	} else {
 		/* disable DSC PPS in stream encoder */
+		memset(&stream->dsc_packed_pps[0], 0, sizeof(stream->dsc_packed_pps));
 		if (dc_is_dp_signal(stream->signal)) {
 			if (is_dp_128b_132b_signal(pipe_ctx))
 				pipe_ctx->stream_res.hpo_dp_stream_enc->funcs->dp_set_dsc_pps_info_packet(
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index 580420c3eedc..58941f4defb3 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -162,7 +162,7 @@ struct dc_stream_state {
 	struct dc_info_packet vrr_infopacket;
 	struct dc_info_packet vsc_infopacket;
 	struct dc_info_packet vsp_infopacket;
-
+	uint8_t dsc_packed_pps[128];
 	struct rect src; /* composition area */
 	struct rect dst; /* stream addressable area */
 
-- 
2.25.1

