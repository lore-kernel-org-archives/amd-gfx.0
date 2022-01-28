Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9243BC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jan 2022 14:06:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21BD010EFA4;
	Fri, 28 Jan 2022 14:06:20 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B238810EF95
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jan 2022 14:06:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mk10gImbXIGbPZUNXKNPLorXZdGL7W6tDStqoM+iC+NuGkNlY8cbAs0A+zfPGd35OUQiDBwW+tV8mUGXZm3XCdPRlnGWOrwUucz7zDe2+Ib4lTqK/TLuv/wCXnXkgeA3zA4rBjkr7rTQTnNZf2GVVCN6HUbjcQDsPMCibfQHibzXmrAZ1P0dACcsYHqj0Q/YFoQ0wkB1VcRz3ZkRmISMh2NHfEmOCo7ovLZHoZ1QtQibVvreXd6HXe3w7JLsjiFLFZbhkorRV5tPCcQTUpGMdB6ElFAC13mHIzP69N646E6/w2ib5KQ0rONe+ug+W6iNLkhhxO4F4qWQ/AA8WLMw9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KMRBIp2m48aWtKdZkB8gyZKyfOy8ehlh+iFzvqrypIs=;
 b=amKD91tW8g74TKBp+i2MyueUfmjlZJEpAP7xFxbVlS2VSRUOyj/NrtNyUtHCgz3zywXGW3AgFsR0GoSl3ROSs+Y5TbqSx9dLy9PXgw1kxxg+PfB9CkwpnEy79t8bGsNpwp4mPWaSayWbRykuwbxgCvPZ07BHIYntaZoU4MYDMh5ssEAr8CYxoyA0X2Tx0F+8kNcKvrYnEAPGJ8DvaiZIHkDZm0Y/41fYTPyyUhoXGYObap2+icYGpqFpVLLvepPyQ7Tqp7s6TaclC3iQl5NOwb6i36pLFt7NcJyUMcEhwYxZPPu4nm62/5GPj0a7KgWgWZdif7deaKPLMSb0qtdftA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KMRBIp2m48aWtKdZkB8gyZKyfOy8ehlh+iFzvqrypIs=;
 b=CZ2XCcmjVgMu3GIvK0WV4hpA2j+Nt0F8dKjxOxmKRB1ZOhHQWmA5o7p9m88iDXvEJtFuihA3l3cY93DgiIED6Bw9194j/hneQBSi3z49+ohTHeYsjk3qvCTxuIhKWcoow8kYeKH9M1nFeCQciIkN+oqrWnInxF6w+ivwYD4skfs=
Received: from DM5PR07CA0110.namprd07.prod.outlook.com (2603:10b6:4:ae::39) by
 BL0PR12MB5539.namprd12.prod.outlook.com (2603:10b6:208:1c3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Fri, 28 Jan
 2022 14:06:16 +0000
Received: from DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::d6) by DM5PR07CA0110.outlook.office365.com
 (2603:10b6:4:ae::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17 via Frontend
 Transport; Fri, 28 Jan 2022 14:06:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT062.mail.protection.outlook.com (10.13.173.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 14:06:15 +0000
Received: from stylon-T495.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 28 Jan
 2022 08:06:10 -0600
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 17/17] drm/amd/display: Add Missing HPO Stream Encoder
 Function Hook
Date: Fri, 28 Jan 2022 22:04:11 +0800
Message-ID: <20220128140411.3683309-18-stylon.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220128140411.3683309-1-stylon.wang@amd.com>
References: <20220128140411.3683309-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36d49397-a79b-4fce-cb13-08d9e2675957
X-MS-TrafficTypeDiagnostic: BL0PR12MB5539:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB55391011A60E11E313BBDFEDFF229@BL0PR12MB5539.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iieyw5zT6//7ZdE0/5SG5UwUKDUDdHC+9MEhMSFdGimN/3h+KKBJIVflQ8dI8OFlBlmqY0Y1IpLZbeDdQuODyg8U5jajUROckTNcV4LLDWasKbyabZKqk6MGsBz62eufBJ24FcJOgusjCET+Q+dB2ZbdzZnHW6pm43PV8oqij+AiptuY88W9VZBNaeygEDwi8xh1uIH53eAn1RDrmoCiD8gGNuyZUzm1UjKGGZ+w6TEr1lOV9JjxbE11betwhFmJcIYEemK1jRq6UDYIJmQfE0KqnJEoQ4OzVgvfuIDtVL/06sXJ7WHw8SalTlth1USRnpUezxkeKZ3sn2RwPpqVfbSho4JElR/LPBGkfH1xGWval+M2n038CDiYvcfp8Gc4HjmZDuNtNBu9iBa1Aia/ZhgEQMnrMkxqV5rlgG/5KHqOLqIwmidFPdnETPTVcbnqTBSvYRM8pJvi34KthzbGZo8vRliM5hfA/pmrYTOmqNutLS3mBL8Y0DdLCqpKdO4fCrWktcYUdH4iwEcP9ijDikWk0zyDKgXtUG7SMsNC3IUejDLeXJPvQoVGWNunrHKUY7Sr1V4GXs8vAK1Uu36UWThrhoL2ft1PMbb7UhWxhTUSDCjfpBaNHvz6vUvEjSJ39uNKhRUa35qjT0IlYR5JBJGPTFKQsf+oeEO64kQ46UoyxQ9m8JsrJ81+IpbuqW6m/1mIbw8xOTvSK/KB2YQCpg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(5660300002)(508600001)(356005)(81166007)(44832011)(54906003)(26005)(316002)(186003)(40460700003)(6916009)(82310400004)(2906002)(86362001)(16526019)(1076003)(70206006)(83380400001)(426003)(336012)(2616005)(70586007)(4326008)(47076005)(8676002)(8936002)(7696005)(36860700001)(36756003)(36900700001)(20210929001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 14:06:15.6820 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36d49397-a79b-4fce-cb13-08d9e2675957
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5539
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
Cc: stylon.wang@amd.com, solomon.chiu@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Anson.Jacob@amd.com, Fangzhi Zuo <Jerry.Zuo@amd.com>,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Fangzhi Zuo <Jerry.Zuo@amd.com>

[Why]
configure_dp_hpo_throttled_vcp_size() was missing promotion before, but it was covered by
not calling the missing function hook in the old interface hpo_dp_link_encoder->funcs.

Recent refactor replaces with new caller link_hwss->set_throttled_vcp_size
which needs that hook, and that causes null ptr hang.

Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
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
2.34.1

