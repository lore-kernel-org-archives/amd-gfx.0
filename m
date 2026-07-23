Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C1DCC531FA
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2026 20:19:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28FEE10E5F0;
	Thu, 23 Jul 2026 20:19:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="M3L7dkXQ";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012033.outbound.protection.outlook.com [52.101.53.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6F7910E5F0
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2026 20:18:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=taJxLacPdx/2GVxeW2OkmuYD/w1Sj4hlUhoROmkt9t3jITDPiFWr2Xe5kC9QWRa8Yv3VmuYTRboxPeho0jlvEy4Q+KKVgPQqj51RZfzyL2dg64EquhUgQl52kWZvObLfT62GYfm4U3WLwWtgzvCJZBman+Y00+b4nySO5HhpCIoJZpW2UNIPstUHi4X2TArQLWf6/bP8lK/3k4rmEL5qpAd3w1vURgHV2pT4V5uIO8ZrqkLQnZmXhWM3Hp+qVnNWSdwuoH/hBec5Z3Yge6vMNyTzPUv0wL9/ZH80okqxWaYXFCKG79n6qTrqnSI0copdp8KuNu1Edv7os7Pn6BTZJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OQN7BPHGqrO9tMXo8UDtTNvdfVFPGdRhv7FtS/ANI1w=;
 b=jVNmgOVtX/sgtRt2vdN9OC7M+vt/K4iajEHf3mn5wxSBt/Db5FXwSTvRqQ0QfysIx/WPhnDbXJ73Ll8iqQuxDBxizbM/TxslLuhEkNj8pCZ66hs4l3LLayd9Af3ovZxUAWkSKCLSb5JsJxvSY2L4vOg6AB75RpFJYuv0VOQtD/OxYfQGVXNT4ItrOkcW/v4dZbJnXYSKleyBmwq/Q+E44SugpkyvipORwzH8qaM5Tg0hBPxNhVS1YT9F3CpOwlpO/g7pNhueQt5MyLb7df60OG7BA3WpN3P8TRpCJ7f8imO9sG3q5c01wkzwe1UIlYKidDrf4uaEur1yJ3dGhjNAOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQN7BPHGqrO9tMXo8UDtTNvdfVFPGdRhv7FtS/ANI1w=;
 b=M3L7dkXQ/8iJfcJVAhPjZh+dWL23K0LTiTkm4BuIWx6fu3FY2tFvA76py7EIGd9xksFoBGlXlQvCXWC485T8TdmnnnoH7CfA6CtLuc2Xi8m6VQ4atQ8WqJyToCtNoDqBHOdxDRC1+ihbx8vv8TYwMO0LTpvZJhvdn8t9K1kOJb8=
Received: from MN0P223CA0014.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::26)
 by SN7PR12MB7417.namprd12.prod.outlook.com (2603:10b6:806:2a4::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 20:18:53 +0000
Received: from BL02EPF00021F6D.namprd02.prod.outlook.com
 (2603:10b6:208:52b:cafe::79) by MN0P223CA0014.outlook.office365.com
 (2603:10b6:208:52b::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Thu,
 23 Jul 2026 20:18:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6D.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 20:18:52 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 15:18:50 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Relja Vojvodic <Relja.Vojvodic@amd.com>, Chris Park
 <chris.park@amd.com>
Subject: [PATCH 03/49] drm/amd/display: Fix force FRL rate debug setting
Date: Thu, 23 Jul 2026 16:13:11 -0400
Message-ID: <20260723201908.373300-4-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723201908.373300-1-jerry.zuo@amd.com>
References: <20260723201908.373300-1-jerry.zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6D:EE_|SN7PR12MB7417:EE_
X-MS-Office365-Filtering-Correlation-Id: eac8753e-0cbd-4156-e131-08dee8f79d7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|11063799006|56012099006|10067099003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 3168jSNo4Qx0/OTW9PouqreuU9Kb1cQfA+IriTScPm0cqUDwMUffS4ZCnaw5KZ9iR0VQhqV6//RkZHNpewdhmYZRoEdXEC0stQ+WJdzBo6GaEF82eVwLnsvqjT1+W9zqpzCwocJlszkamjCTzDLeOyNa0kr80Tf7SySFyBumAHoM29xAUrnZFkriQLhOaKv0dQY4feSxRoWqCl6aIorKlMAnsWakn3Llw5ixtin27DcZsndL5oFAzRCoo3fORQ5FO2EHb/i+NAqmBBSbNKdOrv38sjJ7AJOXpQtTTl9Ci7HYJxyAzVfnynCtgoGjPa+Qh6DeGDIdJxq5MIzwJizdEGQ603j+M8oGzO53f6dOs+6x9jHJ5RiwUPc1r4rbzxoO1tRcvLFJsfqz3l/dYEdDEV4wGivVieRc9e00WCb/3PHjFFDHH0nwgvYN0tTeDHaUrAD0Xb9Us8wJ+W+QGtnl/a/K083+vldZTJlbKOJZoptTNdhJy5H+z5uwReRj+YYzOkpC65k6T8CoRWfQ2YvWWrVIUXNl+C3J8jSUTRQnGWeH+aC58tIzB6HmaZkCepDFdMEpZVXaWVByHUZqgHdJgggU+xVXwYfYZDyziBzizsGL1rr8j4MhQHtYECMKkrE9bcYRq8LvnBveXBQ2oSh284bvNBah85fMtF0loSKsxxyREdLzMyq8tS1fV0mXKEvyO2XduCwM7M1TX8f7w+wSfQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(11063799006)(56012099006)(10067099003)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DPFlp/9JKQysL8aOsxmEzkoieKRkuunaaECe62nvJeJ/uPZwWzryFAHXB99L+J+88t3Fh1h7WHScdRNoTB+LGH7f0uTMYeCJpB79HVj7TS7IA+Bj5JMINUpwIeF1Pr5bEB3yfaWyW1DuX9opuHzaMhWddiWJn8bFWqfU+FTrLNI04BHLETU7tUGEZGF+9DwoqiMoiYpxNFX0V6r0CKuCd7QZbQPfQQBEQLg4feXxCU3upil409K0ZhRKR8Umg74F24+vWGywJqHWiqO+D68GN2EsQcESCmR+/aL8E77toZopNws7YSsZXt1ad2hhGRO57Tu2Le83MJSZ0mQhZdn8sGh1XIW40lS8Rf14a1bfVk7vOV9+O2gnmpMmrnhddFpoOimEq5wXGeuiGQhBbr9tbPjpiHQt36KF4Qs1dVoecu9TbfUB2ksYI0e/6JKW0B2r
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 20:18:52.9591 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eac8753e-0cbd-4156-e131-08dee8f79d7d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7417
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

From: Relja Vojvodic <Relja.Vojvodic@amd.com>

[Why & How]
- force FRL rate debug bit was not correctly forcing requested FRL rate

Reviewed-by: Chris Park <chris.park@amd.com>
Signed-off-by: Relja Vojvodic <Relja.Vojvodic@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c               | 4 +++-
 drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 25f904eccb10..cdcf140bc1bb 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -100,7 +100,9 @@ void update_stream_signal(struct dc_stream_state *stream, struct dc_sink *sink)
 
 		if (stream->link->frl_flags.force_frl_always ||
 				stream->link->frl_flags.force_frl_max
-				|| stream->link->frl_flags.force_frl_dsc)
+				|| stream->link->frl_flags.force_frl_dsc
+				|| (stream->link->frl_flags.force_frl_rate != 0 &&
+					stream->link->frl_flags.force_frl_rate != 0xF))
 			stream->signal = SIGNAL_TYPE_HDMI_FRL;
 	}
 }
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
index c35074177a36..2afdfc113675 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
@@ -1090,7 +1090,7 @@ void hdmi_frl_decide_link_settings(struct dc_stream_state *stream,
 		&stream->link->frl_verified_link_cap);
 
 	if (stream->link->frl_flags.force_frl_rate != 0 &&
-		stream->link->frl_flags.force_frl_rate < stream->link->frl_verified_link_cap.frl_link_rate) {
+		stream->link->frl_flags.force_frl_rate <= stream->link->frl_verified_link_cap.frl_link_rate) {
 		switch (stream->link->frl_flags.force_frl_rate) {
 		case HDMI_FRL_LINK_RATE_3GBPS:
 			temp_settings.frl_link_rate = HDMI_FRL_LINK_RATE_3GBPS;
-- 
2.53.0

