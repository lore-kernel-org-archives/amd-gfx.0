Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E0A3C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Jan 2022 06:25:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 976B310E876;
	Tue, 25 Jan 2022 06:25:23 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0283610E8F5
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jan 2022 06:25:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d3Cz+zyjmQus6rbVHn4rt3ktVCQ+8kJeXSbqIQDzk5PsHLUOHjqAFvLRbs0TYlh+ng/BO2KQg/WeSvyvP9161mKremO+Q5KdIJzWTW6poOTHxNgQnVVtiOv1nfA4jQ4RPLFcmbUGVTVvodJfk+xfLCJ4/AD4jmbBPuo9SdwnIQ2sBFe9Afsy5W705VbgxhPRcmuxYbQvkraxJJaPEWcINC6VM6KY6ikgyuRlA09gIH+xcWReEDTqG2IF0k8yFdMAF+2wyAgT9huep/CdWqEaI8Y3l4frcSvub+cd8asGst219/kW00pknBfRUFEtVv1ISzSmNMvikLcDHfAEWVWNeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h9s3vb9jq0OQvaDRVNG5otC+VDGqXCNm6NUzY1knPOI=;
 b=mtua1faM/esYqLhYFDBdCnAXMHBK+CYt5alVlERT2so0Rk+b9QDxdOZH9pk0B5Q+rih1A6GnLObIyiT1ntsPa/0sdQVOPivApLI85vw7Ch/XD2aatodt90Tfs6S1cutyTeBgS5Go8cKcaGk8z+t5cTet3C4QJLh+mBcxZVRo0MxBXBPcJeib8WcW9pPo5jQS1o9gw3YM5JA512jyz2Mcd5QYGnOi7W+74Sr/Ei+3EyZfaJ2JsP4q8KpGWpF6/hditSpoLgdbq5OVn6U3n2TV0X9wyE2Cn/oYwj9iOy3d3YaI719jZtT9KYMReTwKY6TRE6kxudfvszXWoRc0Y+J+OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h9s3vb9jq0OQvaDRVNG5otC+VDGqXCNm6NUzY1knPOI=;
 b=IJTj4h+CCa0CNvvFL/Jifp3yoge5R9e1/Hdk4GHmbBnlNLYzEGEch3JOPRy2qp5uo9S0supj4znX99W1Q4l2vEoLsdAU8YShC+4e2Hu/82rN473kU3o2UEgtFK9x9fohVrEIJzluWz3x/njdEV53zEcJyTU0fwxWk2uILbZ9IwE=
Received: from DM5PR12CA0059.namprd12.prod.outlook.com (2603:10b6:3:103::21)
 by SA0PR12MB4429.namprd12.prod.outlook.com (2603:10b6:806:73::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.14; Tue, 25 Jan
 2022 06:25:18 +0000
Received: from DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:103:cafe::90) by DM5PR12CA0059.outlook.office365.com
 (2603:10b6:3:103::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8 via Frontend
 Transport; Tue, 25 Jan 2022 06:25:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT008.mail.protection.outlook.com (10.13.172.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Tue, 25 Jan 2022 06:25:18 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 25 Jan
 2022 00:25:17 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 25 Jan
 2022 00:25:17 -0600
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Tue, 25 Jan 2022 00:25:16 -0600
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <harry.wentland@amd.com>,
 <nicholas.kazlauskas@amd.com>, <wayne.lin@amd.com>
Subject: [PATCH] drm/amd/display: Add Missing HPO Stream Encoder Function Hook
Date: Tue, 25 Jan 2022 01:25:07 -0500
Message-ID: <20220125062507.1569727-1-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35a97872-b395-4f8a-aab7-08d9dfcb750b
X-MS-TrafficTypeDiagnostic: SA0PR12MB4429:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB4429A70A5FADDA8D71B292A1E55F9@SA0PR12MB4429.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8qv2cy3U3fCKMw8eVd7Y63kF2pnuFcxB4YedNFotYn9t4/RSS5/J8IsEO8NP0Vi1VH6h79I8w54dVeAdIcUGvWIUmNmDrksQ8hRERBPkAeEWAQTsnNmTfvZNgpYKO+vRUmmK2DAfh6YBXUeqTytbH0P4IfYYWVirz1RfL7jEnGAvuVaMsq6i9OJGIhOa0+FjAOKZLvM9RVq1plC25w5G7SSWyIvdN/d/reQO7glWEwRKpB3jXbpUmwm6odI8Eh5WquIDalreHopPb6gXQgiDviRqdFNniPTZIS6AYtu4tyM+IQkw6BkDt4vShWJYubhUMAFB4oxgUisBm/J9NhO976wxT6vW14p8ThqNaP73Z4j3XKJ3lgU6f6LVojNzUBOW7wZAOgNgsVAEV1IZu4y6nXZFsYlaZvdhMu9976/gClpNTLd5svyNE103qRFlDGz35RYhxP8QQ0RUCqgiGa5Mxg0OnEsLOMlO1myiDqs/XKXGFrpJ4lO6tiaV/PnUZ3LEPQfrmeSGYQO8H/YJEHIErG/1WpW9MR/SRWtI8Ji/KxbNYw9AqqdD654kBWyoa+PHvyVz/SXTbNbBpYrL7LHjC6fcHEYUmB/B9n17tQNS4pCGFmpRpuSFSYEF98H+wZeXz6cmfQNEQUH+otN3P7DeK7Hr9GXcQE3wVmUdebYH4xsQOz1fizmkIfpLA02EycHvoXcrbvV5iKMUT1WWG0euAjF7CnlQ0xnnRoRPIOgBqWIRWASgUL0zOlAqP5EdJAEtVMT6WCjM2ihOK3XqfOO9wK18uFIhVn9+mWAFVA9MvPY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700004)(36840700001)(46966006)(186003)(81166007)(316002)(83380400001)(36860700001)(508600001)(70586007)(70206006)(7696005)(26005)(5660300002)(2906002)(426003)(8676002)(336012)(4326008)(2616005)(8936002)(6636002)(356005)(86362001)(82310400004)(40460700003)(110136005)(6666004)(36756003)(47076005)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 06:25:18.3752 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35a97872-b395-4f8a-aab7-08d9dfcb750b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4429
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
Cc: Fangzhi Zuo <Jerry.Zuo@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
configure_dp_hpo_throttled_vcp_size() was missing promotion before, but it was covered by
not calling the missing function hook in the old interface hpo_dp_link_encoder->funcs.

Recent refactor replaces with new caller link_hwss->set_throttled_vcp_size
which needs that hook, and that causes null ptr hang.

Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
---
 .../display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c    | 11 +++++++++++
 .../display/dc/dcn31/dcn31_hpo_dp_stream_encoder.h    |  9 ++++++---
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c
index 5065904c7833..23621ff08c90 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c
@@ -710,6 +710,16 @@ static void dcn31_hpo_dp_stream_enc_read_state(
 	}
 }
 
+static void dcn31_set_hblank_min_symbol_width(
+		struct hpo_dp_stream_encoder *enc,
+		uint16_t width)
+{
+	struct dcn31_hpo_dp_stream_encoder *enc3 = DCN3_1_HPO_DP_STREAM_ENC_FROM_HPO_STREAM_ENC(enc);
+
+	REG_SET(DP_SYM32_ENC_HBLANK_CONTROL, 0,
+			HBLANK_MINIMUM_SYMBOL_WIDTH, width);
+}
+
 static const struct hpo_dp_stream_encoder_funcs dcn30_str_enc_funcs = {
 	.enable_stream = dcn31_hpo_dp_stream_enc_enable_stream,
 	.dp_unblank = dcn31_hpo_dp_stream_enc_dp_unblank,
@@ -725,6 +735,7 @@ static const struct hpo_dp_stream_encoder_funcs dcn30_str_enc_funcs = {
 	.dp_audio_enable = dcn31_hpo_dp_stream_enc_audio_enable,
 	.dp_audio_disable = dcn31_hpo_dp_stream_enc_audio_disable,
 	.read_state = dcn31_hpo_dp_stream_enc_read_state,
+	.set_hblank_min_symbol_width = dcn31_set_hblank_min_symbol_width,
 };
 
 void dcn31_hpo_dp_stream_encoder_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.h
index 70b94fc25304..7c77c71591a0 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.h
@@ -80,7 +80,8 @@
 	SRI(DP_SYM32_ENC_SDP_GSP_CONTROL11, DP_SYM32_ENC, id),\
 	SRI(DP_SYM32_ENC_SDP_METADATA_PACKET_CONTROL, DP_SYM32_ENC, id),\
 	SRI(DP_SYM32_ENC_SDP_AUDIO_CONTROL0, DP_SYM32_ENC, id),\
-	SRI(DP_SYM32_ENC_VID_CRC_CONTROL, DP_SYM32_ENC, id)
+	SRI(DP_SYM32_ENC_VID_CRC_CONTROL, DP_SYM32_ENC, id), \
+	SRI(DP_SYM32_ENC_HBLANK_CONTROL, DP_SYM32_ENC, id)
 
 #define DCN3_1_HPO_DP_STREAM_ENC_REGS \
 	uint32_t DP_STREAM_MAPPER_CONTROL0;\
@@ -116,7 +117,8 @@
 	uint32_t DP_SYM32_ENC_SDP_GSP_CONTROL11;\
 	uint32_t DP_SYM32_ENC_SDP_METADATA_PACKET_CONTROL;\
 	uint32_t DP_SYM32_ENC_SDP_AUDIO_CONTROL0;\
-	uint32_t DP_SYM32_ENC_VID_CRC_CONTROL
+	uint32_t DP_SYM32_ENC_VID_CRC_CONTROL;\
+	uint32_t DP_SYM32_ENC_HBLANK_CONTROL
 
 
 #define DCN3_1_HPO_DP_STREAM_ENC_MASK_SH_LIST(mask_sh)\
@@ -202,7 +204,8 @@
 	type GSP_SOF_REFERENCE;\
 	type METADATA_PACKET_ENABLE;\
 	type CRC_ENABLE;\
-	type CRC_CONT_MODE_ENABLE
+	type CRC_CONT_MODE_ENABLE;\
+	type HBLANK_MINIMUM_SYMBOL_WIDTH
 
 
 struct dcn31_hpo_dp_stream_encoder_registers {
-- 
2.25.1

