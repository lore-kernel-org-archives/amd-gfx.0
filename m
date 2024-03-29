Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93FE8CD128A
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Mar 2024 22:59:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BCDE10F4F8;
	Fri, 29 Mar 2024 22:59:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wJxcx+2z";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B96210F4F8
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Mar 2024 22:59:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JPTCfrod//qzvEE+LTYv0M1SOf97asEezskcAqZy+O4dMDQeMr/11nLqeV/XtCt1NuyuzmAySPHfunMMoeXA8FAaH9fuwRyIl+/tfEemSxRR311n6zRRRZDZmdnR/2GukGoCaEaK0K6yc/o+jhCEOBiozXsynBSoQbWBCheDRsO5deZkqZH0zzv/0JkTLIjYr40ikh4QrCh/uvTgU5Kw6TbzeRtdqbCoAqe5vgrrj8VqsFyLB4VZh3tdrkqIgaPh7rr7wbL7mVyKTuWQB9DKnW40lRhcUDZUQU/XotgjvwnAPQcgzp2yHKikE77ykYXZskeUdSEH40Lz1JugKHp0qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zHFo3aj0TDiCF1+BNwFj2CO0Uh4Dp+8nZYbfckQ75m4=;
 b=jH19eO1Syi5Xkuuolckz7vUIlaZWYzA7DTwN5A4Es1EHW+9dRutSQoqa/HTYdg43S3afOwLcQ1Z/hp8S0izFsHqFW2TICgxjQigK1YRVbbmMpgIoTQfHNi/ObrC0jUmRB9xPMs5J1ya/7GTtegAZnblLOHpWWSOSDvOgyPIDcXVzeSX80M7ctaFYwciicsSH9QC5XyXCguMzFHI9sENi47eFNnmsPRN3s0DYoy3Jn8at//SQsPJYZ+fzIuy6PRZTCurBZ0p5/rgsxSPWOOLl5OCjEep9bM85vHSscbHdALe0HwgQdUeq7nPYAPLDTmJlr87jTuscJ+6wMthaGOBrGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHFo3aj0TDiCF1+BNwFj2CO0Uh4Dp+8nZYbfckQ75m4=;
 b=wJxcx+2zjbEmN0Nv02fXh8SOcwNLbZS2lR+RADApR8whb/Kuw+Ej6nIF6eB2kX4vVM7g5VRaotF9iaFtW4W+mfhPUNOJF4oxLfBID21t3eAuINY9KdJyXHdXC82I0fvqtX5SG/V02hkCkvTe3ymQOKrTOdcys5DbRHdjA8Qiga0=
Received: from DS7PR03CA0061.namprd03.prod.outlook.com (2603:10b6:5:3bb::6) by
 SA1PR12MB5614.namprd12.prod.outlook.com (2603:10b6:806:228::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.41; Fri, 29 Mar 2024 22:59:08 +0000
Received: from CY4PEPF0000FCC4.namprd03.prod.outlook.com
 (2603:10b6:5:3bb:cafe::c1) by DS7PR03CA0061.outlook.office365.com
 (2603:10b6:5:3bb::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.41 via Frontend
 Transport; Fri, 29 Mar 2024 22:59:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC4.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Fri, 29 Mar 2024 22:59:08 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 29 Mar
 2024 17:59:06 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Muhammad Ahmed
 <ahmed.ahmed@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Charlene Liu
 <charlene.liu@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>, Harry Wentland
 <harry.wentland@amd.com>
Subject: [PATCH] Revert "drm/amd/display: fix USB-C flag update after enc10
 feature init"
Date: Fri, 29 Mar 2024 18:58:52 -0400
Message-ID: <20240329225852.9648-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC4:EE_|SA1PR12MB5614:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c98113d-9519-4de8-6eb6-08dc5043d725
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AP5ehUgHwA8w7w9Lb81BYmtQD9DhfPF7gnQBaLDElFLzhrpSt8RGuUxLix8yb1+H4A96hXJQLr9VusJpMRe3HimT9JvOm03cIn2bC3HlktJCrVrou5DnnlnKK57B8Ew8cQTlKSLx7VYUU/6Y2vP5xcwnyXCt4K9pmzcJlSnoL3bg1mMEL6rge6UAkXjVIrKK6c8vV7L+DYasCoHHcm/nq5pmMi7Y47XZx2bc0vPMmOo7biky3ZI4CohwPLCWI7ta0ncVbHztJkKxS/whdbxx3AnpJvoO6WYRPAOfWMfSmjS5KNOoWbJyV572iwOBNY4rs1zZMeTM7C2jKidsclEv3EOdA4jCTUHqXJa3BRSkRxRXMD1O3ytk/wpwzTbUgObA+3PhvFgC0KvkpnzF8Q0NLIfXxpmZPhekGQ68sBYlwyoxfzUr3D4+lPYa8uw2EvHriPwJGu01/vkz44t0YLLpxbNnb3EgRy5yye42NQcpSfhqByfg0In9n1jWLmVKyAGrBKpbBYQYugW11emCl5d0ph0K9ZNcXWTEAvLH3jyleCxYq86UMWrmTqHuR732QvSv9vQqqv+evduN3VXqYUhfCYUAcGQwGH/0+oX2RFNYcvHHhsAgbTvIO13lf0iLPIkHwbqBVaNfERBblNweosiVaK/QAF1W6oX3Zn8f28G5QS1EBU5hmGTwzyPcwyJYIKchw+TDAJ2JKcZDBRGDN0mAeg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 22:59:08.1415 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c98113d-9519-4de8-6eb6-08dc5043d725
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5614
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

This reverts commit b5abd7f983e14054593dc91d6df2aa5f8cc67652.

This change breaks DSC on 4k monitors at 144Hz over USB-C.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3254
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Muhammad Ahmed <ahmed.ahmed@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Charlene Liu <charlene.liu@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn32/dcn32_dio_link_encoder.c | 8 +++-----
 .../gpu/drm/amd/display/dc/dcn35/dcn35_dio_link_encoder.c | 4 ++--
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_link_encoder.c
index e224a028d68ac..8a0460e863097 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_link_encoder.c
@@ -248,14 +248,12 @@ void dcn32_link_encoder_construct(
 	enc10->base.hpd_source = init_data->hpd_source;
 	enc10->base.connector = init_data->connector;
 
-	enc10->base.preferred_engine = ENGINE_ID_UNKNOWN;
-
-	enc10->base.features = *enc_features;
 	if (enc10->base.connector.id == CONNECTOR_ID_USBC)
 		enc10->base.features.flags.bits.DP_IS_USB_C = 1;
 
-	if (enc10->base.connector.id == CONNECTOR_ID_USBC)
-		enc10->base.features.flags.bits.DP_IS_USB_C = 1;
+	enc10->base.preferred_engine = ENGINE_ID_UNKNOWN;
+
+	enc10->base.features = *enc_features;
 
 	enc10->base.transmitter = init_data->transmitter;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_link_encoder.c
index 6e6ae3de08e4c..6864b6d174370 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_link_encoder.c
@@ -184,6 +184,8 @@ void dcn35_link_encoder_construct(
 	enc10->base.hpd_source = init_data->hpd_source;
 	enc10->base.connector = init_data->connector;
 
+	if (enc10->base.connector.id == CONNECTOR_ID_USBC)
+		enc10->base.features.flags.bits.DP_IS_USB_C = 1;
 
 	enc10->base.preferred_engine = ENGINE_ID_UNKNOWN;
 
@@ -238,8 +240,6 @@ void dcn35_link_encoder_construct(
 	}
 
 	enc10->base.features.flags.bits.HDMI_6GB_EN = 1;
-	if (enc10->base.connector.id == CONNECTOR_ID_USBC)
-		enc10->base.features.flags.bits.DP_IS_USB_C = 1;
 
 	if (bp_funcs->get_connector_speed_cap_info)
 		result = bp_funcs->get_connector_speed_cap_info(enc10->base.ctx->dc_bios,
-- 
2.44.0

