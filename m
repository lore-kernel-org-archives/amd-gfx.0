Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 761FBC43219
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Oct 2022 15:48:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAB7110E431;
	Thu, 20 Oct 2022 15:47:57 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88DD910E138
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Oct 2022 15:47:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HskorPmPApVbSiF6kZ7EJFdNEX6lDVv4/M3LcC/vkRwj/c72PIaZj3e9XgupUN339xJyikP+UjLlj6vN5kDG3BTk29HzbYZ1WetAIYr6u8CnPXWt/rsrnlxCA2PbN4s0zlpDxbu6tMdvnLLPraXAIYI5bOFergfwmRbag0UC34VmtsBhLcWudTWjvtSfz0lMiZOQyjGVlqo9xLTZVl/r1V02thsPqtlRcNgH4qHKy0fGj3M5mO1Odi98Eje0FYH5QIo7OBhpANfVV8J5fl/hK18afMhdfiaZwHb9DJobiLj1E4yiEhUQSwaofhhHqABiRHWhK9koLf8wV5Q5ouWtmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Puy+UYBbF9HcyWo02+wdqajHrqb6JIAcTVqXqv2iC8=;
 b=FhSBqCiVk8zUNkyDuSdnpWzVdRtlFToJ8BnU76e++MD5wJWxQK7PZtK6MY2JAOMixTXcActRvo6CdEBAItqE3Xyc1+twjRsWdi7HyI92Is1Ghl6Q6AnCDSxNWKrsGP1RJpVCIHq4qzcekavDmcYVRrXOAl1gZXzqMtZz3nbWExg0E+y3wYWNlQtp/mWwNn27pmsolKpOCSDLU9Dn1DQ+awjHMB2xfz/0Wi4JwlQhhoDxdSuEV32wGTQqpAxtRFicz+6KYSUELbsYm/7RWyDN4cXAiZ65mvL7D6y+ZcO+EtT7f1Wi2RfCviGBMHB0sJG147ewR/uyWcdxlHowm3QK2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Puy+UYBbF9HcyWo02+wdqajHrqb6JIAcTVqXqv2iC8=;
 b=N5DJGK3ckUcCf930+G7MkZad0K/IxBAZFUWfKTgxDVyA5zobpLeLMp5spilxBXoyIoYsceX0P9ExkMhTpWLzv1qbg6w+99nWtyh4KX+aWGVZrAjQEtkCh7JPXuevGq1g/7qlBjT0MFlwtulcp70rYlYKc+5sdx2EnYUTB0d4gLI=
Received: from DM6PR21CA0004.namprd21.prod.outlook.com (2603:10b6:5:174::14)
 by BL1PR12MB5223.namprd12.prod.outlook.com (2603:10b6:208:315::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35; Thu, 20 Oct
 2022 15:47:39 +0000
Received: from DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::cc) by DM6PR21CA0004.outlook.office365.com
 (2603:10b6:5:174::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.7 via Frontend
 Transport; Thu, 20 Oct 2022 15:47:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT036.mail.protection.outlook.com (10.13.172.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Thu, 20 Oct 2022 15:47:39 +0000
Received: from atma3.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 20 Oct
 2022 10:47:37 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/33] drm/amd/display: remove audio mute control in hpo dp
Date: Thu, 20 Oct 2022 11:46:34 -0400
Message-ID: <20221020154702.503934-6-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221020154702.503934-1-Rodrigo.Siqueira@amd.com>
References: <20221020154702.503934-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT036:EE_|BL1PR12MB5223:EE_
X-MS-Office365-Filtering-Correlation-Id: 39c882df-923a-47e8-45f1-08dab2b26ae6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TtUMRtHTR8jpjxZSVeUgswptuDXQQGEhvlEquftcxuwQV/8fzTLDRJlR5HSvvIgfhbJoJUdfRBIEapUMPGuWSrmO7qPTrLHzW48V9BO6tI6vCbfsHd6RcCZ2qULHPLECduEoQNN/vzCdpVB4TK62jKjY43wRTcmB841cSyeYhkYug5GsRYfWnzUeMS9pJJ6jFs4x4YPwHwL0F3tOLZIjqZdGH0k7gMcT1WfmwpqehWsAZ0TQpJOOdOlqZdGuKpxmwoC945w9tGe+FvKx2FBz4YN09m2W3NF1e1FHBJ1PjUHJ4nvyZl+7tRURaSx+5Zulhebnu2TLMESVx6oiTgCWX9or7PCmTiaEW6OYBwEClnXRrWDaPNHKnljrcCT7WoGnE2uR929snGggJfZUMj9fVmEC2wIgziPx3kpofZRuLXObz6Q68oKu51jBsjcSXzcU8kQagVmuFBCiF0rnl+vD57/xomFIkJHMLx8AO3trh7UIZX2WS8UEAAzvvnbHlatPCbHJOc+So60CCXpmLJcBi8f3qkSwaao190ucNsAOK74KmPnw/SqH15ZIYjxrZup7hj4VcQFvsHe8VAiL2DbE0PN9m/DObPEZEZIER6DvCjLpuGSZvwrOCtSNjN5OdzQSsuFefaFgz+0wi4+hqTne/MhXFe7MfN4IDQxX6RgCWzrNxoFGLT/aDTHFBp/Mfk8xEFaoeViLjiOCVe62stL8ar0pOTvjXRiZ2QWVgUExca9vzJ7JfEQ4531ijP8PPcedQ2ruyn1nEuJ3iCVMfJb2pkWsFQpvitXu4n8ANfkDxsnqRQd/KyilI1+iDEd1izZ7
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(376002)(396003)(136003)(451199015)(36840700001)(40470700004)(46966006)(316002)(478600001)(54906003)(6916009)(6666004)(7696005)(70586007)(70206006)(8676002)(4326008)(41300700001)(356005)(8936002)(2616005)(336012)(26005)(5660300002)(16526019)(1076003)(186003)(2906002)(426003)(47076005)(83380400001)(36756003)(36860700001)(82740400003)(81166007)(40460700003)(82310400005)(86362001)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 15:47:39.3120 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39c882df-923a-47e8-45f1-08dab2b26ae6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5223
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Wenjing Liu <wenjing.liu@amd.com>,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

VPG doesn't have the ability to mute audio output by sending all 0s in
audio SDP. The existing implemention is disabling audio SDP instead.
This is same as what dp_audio_enable does. Since it is no longer
referenced by any callers, we decided to remove this interface for
simplicity.

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_apg.c      | 11 -----------
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_apg.h      |  4 ----
 .../display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c    |  9 ---------
 .../gpu/drm/amd/display/dc/inc/hw/stream_encoder.h    |  3 ---
 4 files changed, 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_apg.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_apg.c
index 2cec7131a96f..24e9ff65434d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_apg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_apg.c
@@ -136,19 +136,8 @@ static void apg31_se_audio_setup(
 	REG_UPDATE(APG_MEM_PWR, APG_MEM_PWR_FORCE, 0);
 }
 
-static void apg31_audio_mute_control(
-	struct apg *apg,
-	bool mute)
-{
-	if (mute)
-		apg31_disable(apg);
-	else
-		apg31_enable(apg);
-}
-
 static struct apg_funcs dcn31_apg_funcs = {
 	.se_audio_setup			= apg31_se_audio_setup,
-	.audio_mute_control		= apg31_audio_mute_control,
 	.enable_apg			= apg31_enable,
 	.disable_apg			= apg31_disable,
 };
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_apg.h b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_apg.h
index 24f568e120d8..1b81f6773c53 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_apg.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_apg.h
@@ -84,10 +84,6 @@ struct apg_funcs {
 		unsigned int az_inst,
 		struct audio_info *audio_info);
 
-	void (*audio_mute_control)(
-		struct apg *apg,
-		bool mute);
-
 	void (*enable_apg)(
 		struct apg *apg);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c
index 814f401db3b3..16639bd03adf 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c
@@ -600,14 +600,6 @@ static void dcn31_hpo_dp_stream_enc_map_stream_to_link(
 	}
 }
 
-static void dcn31_hpo_dp_stream_enc_mute_control(
-	struct hpo_dp_stream_encoder *enc,
-	bool mute)
-{
-	ASSERT(enc->apg);
-	enc->apg->funcs->audio_mute_control(enc->apg, mute);
-}
-
 static void dcn31_hpo_dp_stream_enc_audio_setup(
 	struct hpo_dp_stream_encoder *enc,
 	unsigned int az_inst,
@@ -726,7 +718,6 @@ static const struct hpo_dp_stream_encoder_funcs dcn30_str_enc_funcs = {
 	.stop_dp_info_packets = dcn31_hpo_dp_stream_enc_stop_dp_info_packets,
 	.dp_set_dsc_pps_info_packet = dcn31_hpo_dp_stream_enc_set_dsc_pps_info_packet,
 	.map_stream_to_link = dcn31_hpo_dp_stream_enc_map_stream_to_link,
-	.audio_mute_control = dcn31_hpo_dp_stream_enc_mute_control,
 	.dp_audio_setup = dcn31_hpo_dp_stream_enc_audio_setup,
 	.dp_audio_enable = dcn31_hpo_dp_stream_enc_audio_enable,
 	.dp_audio_disable = dcn31_hpo_dp_stream_enc_audio_disable,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h b/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
index 42afa1952890..6b3e6de374bd 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
@@ -317,9 +317,6 @@ struct hpo_dp_stream_encoder_funcs {
 			uint32_t stream_enc_inst,
 			uint32_t link_enc_inst);
 
-	void (*audio_mute_control)(
-			struct hpo_dp_stream_encoder *enc, bool mute);
-
 	void (*dp_audio_setup)(
 			struct hpo_dp_stream_encoder *enc,
 			unsigned int az_inst,
-- 
2.35.1

