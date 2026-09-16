Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E65B0C982D4
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 17:53:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF4AA10ECC7;
	Wed, 16 Sep 2026 17:53:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tGy0Y92Z";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010014.outbound.protection.outlook.com [52.101.85.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB21810EC90
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 17:53:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KtjzKYzeHP1xK60OQ5rjTA1gFnvO9YFdzKdC9hRBg0rXFsVX4M0k8iraLD2V3XtOR0lXZr591UacM/2mngot6Pk/s3/JkofD0xzQTv4/sfzdvKBM/i8Y218fWneBeUW41jIFqoO3XDRWy7c8+XBFBsO2U0mfRQe7IMAEWLOYm6QSsa0QroVXBiItUL5gv4JZtL0tp7HVuej/xHIa4MtT3MrDw+65W2pAnOWNJXu/MTcGL9CW0v505O81c0tArTyYjU9NgEpIIfVmiq52S40YKhLAIYBRLF2RgAWubpRxdklgPQciRgm2kq4hpWX3oBbsCnPehb0fzU/+etfR/7OOtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aWZc59iRY76eFaWPVQA7TBVazuUH2m/OGA1HcPNObh0=;
 b=vuQWxUbalE1dXiiLT0XAfDdHDug/rkr/NT45V1QQ+gocCOcrTNRLHvDGSEzX9RWRHI+LdmxobXlbqomJ9ggAb2MBLThWexZrWGpFpbKDlCwKelp8fw28Fu43sC1eHAKNTq8UtEA9M9GgB4VJKfJI49kDChFzIYl2diodie95o0SIwELaA6QO7gq7zflDqGtGzKqMi8hRjO323zZTFLM4a34uZN6oTZgPNm7MKJKhoP5lSj2d6O+gWT8IJoWlBZHOl2dWTmgCAcDjR+QHAyygrVGjnOqA/GMEOKKI+BWyaUu/XiNT3D0WkiZ2SBz0XC4pn7RlMJIF5My1kEp/Ah99ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aWZc59iRY76eFaWPVQA7TBVazuUH2m/OGA1HcPNObh0=;
 b=tGy0Y92ZEvUE33JtBUsr9lgaKRCw8gVbweMR2bx22FR0lKtdxZNiUsVzC89uEGlts7Af2LCwanD7DXGvXuPQQI681WKFSww7WB7i3CO1fRdLI4QItAfAXzg2fqem38CwXD6DEoIQv3HT4jcFTfV6e18kKVGikwGtVckrWBjop1M=
Received: from CH5P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::15)
 by LV0PR12MB136056.namprd12.prod.outlook.com (2603:10b6:408:3b5::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Wed, 16 Sep
 2026 17:52:56 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:610:1ef:cafe::16) by CH5P220CA0014.outlook.office365.com
 (2603:10b6:610:1ef::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 17:52:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 17:52:56 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 12:52:43 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Tony Cheng <Tony.Cheng@amd.com>, Jun Lei
 <jun.lei@amd.com>, George Zhang <george.zhang@amd.com>
Subject: [PATCH 38/64] drm/amd/display: Add inst field to encoder structs
Date: Wed, 16 Sep 2026 13:51:53 -0400
Message-ID: <20260916175301.368306-39-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916175301.368306-1-george.zhang@amd.com>
References: <20260916175301.368306-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|LV0PR12MB136056:EE_
X-MS-Office365-Filtering-Correlation-Id: f0a811c9-7c95-4bdd-7c29-08df141b56e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|36860700016|376014|10067099003|11063799006|5023799004|3023799007|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: dEEjLUzEGvezb23PmZhKQaRruBcKLAlCTib4/tA6+rP6SXvdv11Ea3yFCkwWuMffZVWOUPnMaMnHCTKGPrWxR9J2MjnG5Gq4QAVyGh7bcxDl8TKR5XjBwTn1dHWcLJNb/ejcZjJx5dyg0XREauJqTbMLWtH1vXq4NQfWPuAbdzGjF7dbPE9osOU0/a5+Qm5Ja1IuVW5uxI/v7QumvuC9rjat3GZMMyRFxqTRyIwOljGoZLvPumtiYVikjVZSZu11k5qOViqzBLL2jXYCvIDF46wr87rMPcV4tjrBQrmt+7Kmvpsv2Y1H/U9j+Nl9XxZzKcWWGzVXKjzW0jmUOf0BVhqao/Lu+/hL1DdhUJ9zpKwk3hCbqUOV+aSjDGslz+KZQyVOkEGZlAcmIScwWUVYM0lhZOd/zSrSnYsCaxjDTGo3/PjXxRZAKG7lmRggyNx/7GDt/noohOvtm8BDWZH+X5jfO0wfqOdzwUNjq9d3EBZ3yzWBPhndYazY6FfRSPLRx2lM9lN7fXltvSkV1jYB8zAQ9aGjczamHxqtCHRAvtLhDcEWBckbNSeKfZzlVMeVBrvS1qBHKWIBf1mDVW3g5Hc5IZqhrVtIai11qwJJspTO37GZoUhrtKfsDDqp1MkDveWTMj6EBgK+K6M4m0zJIWg591VXMa/Yt5ZOs8KVAdJ5VSPOkX3+KjIoY02VsEcAuJXkQQiouW5Tz35Jipz+8w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(36860700016)(376014)(10067099003)(11063799006)(5023799004)(3023799007)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OBKLKYe6d1QALxUR0ttovTGv+oXxZE40eJIbrRMgQ9HIg70Zd1yEFAZy1HbOPDYnwW5qX3/rkFvvZuCxjMJ2CVUIPc2STV1RYfudk2q2uPI5/T+/Lg7LdXrKnGFbsnZwltSoheF4uUroJUcRwovE8Itm5/6G8fyr9D8GoPFh4+oCV73aNsT4Pv+cHeqpwTVh1BFhMS2EpgxPtjqPIzXXYYhMvWHOW/5S/C1spuPjaSJoLil8Ss5f2wuS1QEIUiC/XhTskLqeCx1t62wYN1NQHKX03Or32VL54l8gQ358C70ILoSYyHVWCD473piC8e4XihZYSvU2bEqULY2Skc7E/kcJHDq28njhcNfmfrfIh5CQpUDqKO39GDmSSv2lOdeE3bJooJ7IoZqbc/hmRVKQiKnCNEFqHhPj/RMlPBWNxXZoChrH1iUsqjwsbWDv/Utz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 17:52:56.3539 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0a811c9-7c95-4bdd-7c29-08df141b56e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB136056
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

From: Tony Cheng <Tony.Cheng@amd.com>

Add an inst member to struct link_encoder, struct stream_encoder and
struct hpo_frl_stream_encoder, and populate it in the DCN10 through
DCN60 construct paths.

No functional change; the field has no readers yet.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Tony Cheng <Tony.Cheng@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_link_encoder.c  | 2 ++
 .../gpu/drm/amd/display/dc/dio/dcn10/dcn10_stream_encoder.c    | 2 ++
 drivers/gpu/drm/amd/display/dc/dio/dcn20/dcn20_link_encoder.c  | 2 ++
 .../gpu/drm/amd/display/dc/dio/dcn20/dcn20_stream_encoder.c    | 2 ++
 .../gpu/drm/amd/display/dc/dio/dcn30/dcn30_dio_link_encoder.c  | 2 ++
 .../drm/amd/display/dc/dio/dcn30/dcn30_dio_stream_encoder.c    | 2 ++
 .../drm/amd/display/dc/dio/dcn301/dcn301_dio_link_encoder.c    | 2 ++
 .../gpu/drm/amd/display/dc/dio/dcn31/dcn31_dio_link_encoder.c  | 2 ++
 .../drm/amd/display/dc/dio/dcn314/dcn314_dio_stream_encoder.c  | 2 ++
 .../gpu/drm/amd/display/dc/dio/dcn32/dcn32_dio_link_encoder.c  | 2 ++
 .../drm/amd/display/dc/dio/dcn32/dcn32_dio_stream_encoder.c    | 2 ++
 .../drm/amd/display/dc/dio/dcn321/dcn321_dio_link_encoder.c    | 2 ++
 .../gpu/drm/amd/display/dc/dio/dcn35/dcn35_dio_link_encoder.c  | 2 ++
 .../drm/amd/display/dc/dio/dcn35/dcn35_dio_stream_encoder.c    | 2 ++
 .../drm/amd/display/dc/dio/dcn401/dcn401_dio_link_encoder.c    | 2 ++
 .../drm/amd/display/dc/dio/dcn401/dcn401_dio_stream_encoder.c  | 1 +
 .../gpu/drm/amd/display/dc/dio/dcn42/dcn42_dio_link_encoder.c  | 2 ++
 .../drm/amd/display/dc/dio/dcn42/dcn42_dio_stream_encoder.c    | 2 ++
 .../gpu/drm/amd/display/dc/dio/dcn60/dcn60_dio_link_encoder.c  | 2 ++
 .../drm/amd/display/dc/dio/dcn60/dcn60_dio_stream_encoder.c    | 2 ++
 .../gpu/drm/amd/display/dc/dio/virtual/virtual_link_encoder.c  | 3 +++
 .../drm/amd/display/dc/dio/virtual/virtual_stream_encoder.c    | 1 +
 .../amd/display/dc/hpo/dcn30/dcn30_hpo_frl_stream_encoder.c    | 2 ++
 .../amd/display/dc/hpo/dcn401/dcn401_hpo_frl_stream_encoder.c  | 2 ++
 .../amd/display/dc/hpo/dcn42/dcn42_hpo_frl_stream_encoder.c    | 2 ++
 .../amd/display/dc/hpo/dcn60/dcn60_hpo_frl_stream_encoder.c    | 2 ++
 drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h           | 1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h         | 2 ++
 28 files changed, 54 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_link_encoder.c
index aee9a363e336..32e12d894e31 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_link_encoder.c
@@ -781,6 +781,8 @@ void dcn10_link_encoder_construct(
 	if (enc10->base.ctx->dc->debug.hdmi20_disable) {
 		enc10->base.features.flags.bits.HDMI_6GB_EN = 0;
 	}
+
+	enc10->base.inst = (unsigned int)enc10->base.preferred_engine;
 }
 
 bool dcn10_link_encoder_validate_output_with_stream(
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_stream_encoder.c
index d913f065ecca..c937788d0763 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_stream_encoder.c
@@ -1625,5 +1625,7 @@ void dcn10_stream_encoder_construct(
 	enc1->se_shift = se_shift;
 	enc1->se_mask = se_mask;
 	enc1->base.stream_enc_inst = eng_id - ENGINE_ID_DIGA;
+	enc1->base.inst = enc1->base.stream_enc_inst;
+
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn20/dcn20_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn20/dcn20_link_encoder.c
index 3bd35f3392dc..dbd4c534c5c3 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn20/dcn20_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn20/dcn20_link_encoder.c
@@ -502,4 +502,6 @@ void dcn20_link_encoder_construct(
 	if (enc10->base.ctx->dc->debug.hdmi20_disable) {
 		enc10->base.features.flags.bits.HDMI_6GB_EN = 0;
 	}
+
+	enc10->base.inst = (unsigned int)enc10->base.preferred_engine;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn20/dcn20_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn20/dcn20_stream_encoder.c
index bec0b4aaeb2b..ac6ca7771d2f 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn20/dcn20_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn20/dcn20_stream_encoder.c
@@ -657,5 +657,7 @@ void dcn20_stream_encoder_construct(
 	enc1->se_shift = se_shift;
 	enc1->se_mask = se_mask;
 	enc1->base.stream_enc_inst = eng_id - ENGINE_ID_DIGA;
+	enc1->base.inst = enc1->base.stream_enc_inst;
+
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn30/dcn30_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn30/dcn30_dio_link_encoder.c
index 8c4010c5b2e7..5fd5158482ea 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn30/dcn30_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn30/dcn30_dio_link_encoder.c
@@ -456,6 +456,8 @@ void dcn30_link_encoder_construct(
 		enc10->base.features.flags.bits.IS_FRL_10G_CAPABLE = 1;
 		enc10->base.features.flags.bits.IS_FRL_12G_CAPABLE = 1;
 	}
+
+	enc10->base.inst = (unsigned int)enc10->base.preferred_engine;
 }
 
 #define AUX_REG(reg)\
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn30/dcn30_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn30/dcn30_dio_stream_encoder.c
index c14fb51c2611..9757d3bcdf32 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn30/dcn30_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn30/dcn30_dio_stream_encoder.c
@@ -899,5 +899,7 @@ void dcn30_dio_stream_encoder_construct(
 	enc1->se_shift = se_shift;
 	enc1->se_mask = se_mask;
 	enc1->base.stream_enc_inst = vpg->inst;
+	enc1->base.inst = enc1->base.stream_enc_inst;
+
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn301/dcn301_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn301/dcn301_dio_link_encoder.c
index 02fb844670f9..7106669eab5b 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn301/dcn301_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn301/dcn301_dio_link_encoder.c
@@ -209,4 +209,6 @@ void dcn301_link_encoder_construct(
 		enc10->base.features.flags.bits.IS_FRL_10G_CAPABLE = 1;
 		enc10->base.features.flags.bits.IS_FRL_12G_CAPABLE = 1;
 	}
+
+	enc10->base.inst = (unsigned int)enc10->base.preferred_engine;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn31/dcn31_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn31/dcn31_dio_link_encoder.c
index f57f3ba68a02..1b9ba0e9f068 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn31/dcn31_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn31/dcn31_dio_link_encoder.c
@@ -509,6 +509,8 @@ void dcn31_link_encoder_construct(
 		enc10->base.features.flags.bits.IS_FRL_10G_CAPABLE = 1;
 		enc10->base.features.flags.bits.IS_FRL_12G_CAPABLE = 1;
 	}
+
+	enc10->base.inst = (unsigned int)enc10->base.preferred_engine;
 }
 
 void dcn31_link_encoder_construct_minimal(
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn314/dcn314_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn314/dcn314_dio_stream_encoder.c
index d1fd5462dca5..482c52c1d7d6 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn314/dcn314_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn314/dcn314_dio_stream_encoder.c
@@ -504,5 +504,7 @@ void dcn314_dio_stream_encoder_construct(
 	enc1->se_shift = se_shift;
 	enc1->se_mask = se_mask;
 	enc1->base.stream_enc_inst = vpg->inst;
+	enc1->base.inst = enc1->base.stream_enc_inst;
+
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn32/dcn32_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn32/dcn32_dio_link_encoder.c
index 68e0dc93ae7d..63990c47ac14 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn32/dcn32_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn32/dcn32_dio_link_encoder.c
@@ -551,4 +551,6 @@ void dcn32_link_encoder_construct(
 		enc10->base.features.flags.bits.IS_FRL_10G_CAPABLE = 1;
 		enc10->base.features.flags.bits.IS_FRL_12G_CAPABLE = 1;
 	}
+
+	enc10->base.inst = (unsigned int)enc10->base.preferred_engine;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn32/dcn32_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn32/dcn32_dio_stream_encoder.c
index edafa3808455..3dd8fe423232 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn32/dcn32_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn32/dcn32_dio_stream_encoder.c
@@ -491,5 +491,7 @@ void dcn32_dio_stream_encoder_construct(
 	enc1->se_shift = se_shift;
 	enc1->se_mask = se_mask;
 	enc1->base.stream_enc_inst = vpg->inst;
+	enc1->base.inst = enc1->base.stream_enc_inst;
+
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn321/dcn321_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn321/dcn321_dio_link_encoder.c
index 4108fd0f4380..67d6050d5163 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn321/dcn321_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn321/dcn321_dio_link_encoder.c
@@ -210,4 +210,6 @@ void dcn321_link_encoder_construct(
 		enc10->base.features.flags.bits.IS_FRL_10G_CAPABLE = 1;
 		enc10->base.features.flags.bits.IS_FRL_12G_CAPABLE = 1;
 	}
+
+	enc10->base.inst = (unsigned int)enc10->base.preferred_engine;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn35/dcn35_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn35/dcn35_dio_link_encoder.c
index 8fa9b8c500f2..9375c9b939be 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn35/dcn35_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn35/dcn35_dio_link_encoder.c
@@ -290,6 +290,8 @@ void dcn35_link_encoder_construct(
 		enc10->base.features.flags.bits.IS_FRL_12G_CAPABLE = 1;
 	}
 
+
+	enc10->base.inst = (unsigned int)enc10->base.preferred_engine;
 }
 
 /* DPIA equivalent of link_transmitter_control. */
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn35/dcn35_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn35/dcn35_dio_stream_encoder.c
index de24dcd27e6c..dabcb45840a7 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn35/dcn35_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn35/dcn35_dio_stream_encoder.c
@@ -517,5 +517,7 @@ void dcn35_dio_stream_encoder_construct(
 	enc1->se_shift = se_shift;
 	enc1->se_mask = se_mask;
 	enc1->base.stream_enc_inst = vpg->inst;
+	enc1->base.inst = enc1->base.stream_enc_inst;
+
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_link_encoder.c
index dad4ef565168..6594fbb3fa43 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_link_encoder.c
@@ -557,4 +557,6 @@ void dcn401_link_encoder_construct(
 		enc10->base.features.flags.bits.IS_FRL_10G_CAPABLE = 1;
 		enc10->base.features.flags.bits.IS_FRL_12G_CAPABLE = 1;
 	}
+
+	enc10->base.inst = (unsigned int)enc10->base.preferred_engine;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_stream_encoder.c
index 79d0c2896d29..4616b6f76aeb 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_stream_encoder.c
@@ -793,6 +793,7 @@ void dcn401_dio_stream_encoder_construct(
 	enc1->se_shift = se_shift;
 	enc1->se_mask = se_mask;
 	enc1->base.stream_enc_inst = vpg->inst;
+	enc1->base.inst = enc1->base.stream_enc_inst;
 }
 
 void enc401_set_dynamic_metadata(struct stream_encoder *enc,
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn42/dcn42_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn42/dcn42_dio_link_encoder.c
index 50174aded6aa..3b11be9991c3 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn42/dcn42_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn42/dcn42_dio_link_encoder.c
@@ -223,4 +223,6 @@ void dcn42_link_encoder_construct(
 		enc10->base.features.flags.bits.IS_FRL_10G_CAPABLE = 1;
 		enc10->base.features.flags.bits.IS_FRL_12G_CAPABLE = 1;
 	}
+
+	enc10->base.inst = (unsigned int)enc10->base.preferred_engine;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn42/dcn42_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn42/dcn42_dio_stream_encoder.c
index 35845e6dd5aa..b7671d41ea24 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn42/dcn42_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn42/dcn42_dio_stream_encoder.c
@@ -581,4 +581,6 @@ void dcn42_dio_stream_encoder_construct(
 	enc1->se_shift = se_shift;
 	enc1->se_mask = se_mask;
 	enc1->base.stream_enc_inst = vpg->inst;
+	enc1->base.inst = enc1->base.stream_enc_inst;
+
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn60/dcn60_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn60/dcn60_dio_link_encoder.c
index 6fe15324ea50..f65326a0f6d2 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn60/dcn60_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn60/dcn60_dio_link_encoder.c
@@ -370,4 +370,6 @@ void dcn60_link_encoder_construct(
 		enc10->base.features.flags.bits.IS_FRL_20G_CAPABLE = 1;
 		enc10->base.features.flags.bits.IS_FRL_24G_CAPABLE = 0;
 	}
+
+	enc10->base.inst = (unsigned int)enc10->base.preferred_engine;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn60/dcn60_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn60/dcn60_dio_stream_encoder.c
index b76cc891857d..b645914c1c71 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn60/dcn60_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn60/dcn60_dio_stream_encoder.c
@@ -535,4 +535,6 @@ void dcn60_dio_stream_encoder_construct(
 	enc1->se_shift = se_shift;
 	enc1->se_mask = se_mask;
 	enc1->base.stream_enc_inst = vpg->inst;
+	enc1->base.inst = enc1->base.stream_enc_inst;
+
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dio/virtual/virtual_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/virtual/virtual_link_encoder.c
index 5b2bba0eff0e..f847fef069c9 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/virtual/virtual_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/virtual/virtual_link_encoder.c
@@ -27,6 +27,7 @@
 #include "dm_services_types.h"
 
 #include "virtual_link_encoder.h"
+#include "stream_encoder.h"
 
 static bool virtual_link_encoder_validate_output_with_stream(
 	struct link_encoder *enc,
@@ -167,5 +168,7 @@ bool virtual_link_encoder_construct(
 
 	enc->preferred_engine = ENGINE_ID_VIRTUAL;
 
+	enc->inst = 0;
+
 	return true;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dio/virtual/virtual_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/virtual/virtual_stream_encoder.c
index 27448f2b2467..f6b1e2a42baa 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/virtual/virtual_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/virtual/virtual_stream_encoder.c
@@ -190,6 +190,7 @@ bool virtual_stream_encoder_construct(
 	struct dc_context *ctx,
 	struct dc_bios *bp)
 {
+	enc->inst = 0;
 	if (!enc)
 		return false;
 	if (!bp)
diff --git a/drivers/gpu/drm/amd/display/dc/hpo/dcn30/dcn30_hpo_frl_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/hpo/dcn30/dcn30_hpo_frl_stream_encoder.c
index f4c21998d845..f0128c5bf993 100644
--- a/drivers/gpu/drm/amd/display/dc/hpo/dcn30/dcn30_hpo_frl_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/hpo/dcn30/dcn30_hpo_frl_stream_encoder.c
@@ -1040,4 +1040,6 @@ void dcn30_hpo_frl_stream_encoder_construct(
 	enc3->hpo_se_shift = hpo_se_shift;
 	enc3->hpo_se_mask = hpo_se_mask;
 	enc3->base.stream_enc_inst = vpg->inst;
+	enc3->base.inst = enc3->base.stream_enc_inst;
+
 }
diff --git a/drivers/gpu/drm/amd/display/dc/hpo/dcn401/dcn401_hpo_frl_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/hpo/dcn401/dcn401_hpo_frl_stream_encoder.c
index 85b7a44c0a11..4b14a3bfe56d 100644
--- a/drivers/gpu/drm/amd/display/dc/hpo/dcn401/dcn401_hpo_frl_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/hpo/dcn401/dcn401_hpo_frl_stream_encoder.c
@@ -904,4 +904,6 @@ void dcn401_hpo_frl_stream_encoder_construct(
 	enc401->hpo_se_shift = hpo_se_shift;
 	enc401->hpo_se_mask = hpo_se_mask;
 	enc401->base.stream_enc_inst = vpg->inst;
+	enc401->base.inst = enc401->base.stream_enc_inst;
+
 }
diff --git a/drivers/gpu/drm/amd/display/dc/hpo/dcn42/dcn42_hpo_frl_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/hpo/dcn42/dcn42_hpo_frl_stream_encoder.c
index 43870d84ca2f..1aed194b58bd 100644
--- a/drivers/gpu/drm/amd/display/dc/hpo/dcn42/dcn42_hpo_frl_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/hpo/dcn42/dcn42_hpo_frl_stream_encoder.c
@@ -209,4 +209,6 @@ void dcn42_hpo_frl_stream_encoder_construct(
 	enc42->hpo_se_shift = hpo_se_shift;
 	enc42->hpo_se_mask = hpo_se_mask;
 	enc42->base.stream_enc_inst = vpg->inst;
+	enc42->base.inst = enc42->base.stream_enc_inst;
+
 }
diff --git a/drivers/gpu/drm/amd/display/dc/hpo/dcn60/dcn60_hpo_frl_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/hpo/dcn60/dcn60_hpo_frl_stream_encoder.c
index b5397d6760b1..de42f8c5f7f0 100644
--- a/drivers/gpu/drm/amd/display/dc/hpo/dcn60/dcn60_hpo_frl_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/hpo/dcn60/dcn60_hpo_frl_stream_encoder.c
@@ -231,4 +231,6 @@ void dcn60_hpo_frl_stream_encoder_construct(
 	enc401->hpo_se_shift = hpo_se_shift;
 	enc401->hpo_se_mask = hpo_se_mask;
 	enc401->base.stream_enc_inst = vpg->inst;
+	enc401->base.inst = enc401->base.stream_enc_inst;
+
 }
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h b/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
index 70545df981ef..f3ef5bbfad81 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
@@ -100,6 +100,7 @@ struct link_encoder {
 	struct graphics_object_id connector;
 	uint32_t output_signals;
 	enum engine_id preferred_engine;
+	unsigned int inst;
 	enum engine_id analog_engine;
 	struct encoder_feature_support features;
 	enum transmitter transmitter;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h b/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
index 2b95cb11eede..5b8688b3aaef 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
@@ -126,6 +126,7 @@ struct stream_encoder {
 	struct dc_bios *bp;
 	enum engine_id id;
 	uint32_t stream_enc_inst;
+	unsigned int inst;
 	struct vpg *vpg;
 	struct afmt *afmt;
 	struct apg *apg;
@@ -319,6 +320,7 @@ struct hpo_frl_stream_encoder {
 	 * @stream_enc_inst: Instance ID reference.
 	 */
 	uint32_t stream_enc_inst;
+	unsigned int inst;
 
 	/**
 	 * @ctx: DC context.
-- 
2.55.0

