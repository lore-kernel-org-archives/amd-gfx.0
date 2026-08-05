Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DFBCC55822
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2026 06:40:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D946E10ED0A;
	Wed,  5 Aug 2026 06:40:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5Yr3PUz8";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013063.outbound.protection.outlook.com
 [40.93.201.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BED810ED0A
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 06:40:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jZRoFvMsuiZL1nvksv1WGfdof4Dd7olz6TUddr5dy7QSEh9EKvNhhUwBi0cSYtTjS8jvZqMC94aqOlZsNVPtUMJN3AAVgKD+Lzk+R/BDa9RAPwc81/C4iBAJzRJe41KBMcXvhLUpXJASEEQr9KcZWHzv/FBUFjW9UNdcCeGQhNF/o61s4kajwUFtw64Mk3Y9NCy1zGzWGd1WxmOTPLDDAH+nB+ziv8+lSf8YARiT/DlotpuKaKVZDqv8USxfNIT214mpu6f0M/ovdmClqpkAljC1somDqwutbxK3nBz6zf6baSO6g3IH7maU7o6HzzQ5wOtXOjDPZuC/7c/78tjZKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iTVmtz/qwd21AZt6Ds684tagW2xlzhuJUGz0JH8uqk0=;
 b=NgrLT/swcCUblQDIUyTVR8sMhjKt8Eh6NHmu2lI/nZWTEEQV4xPrywLL5vIWvsl2nXhwczhn5mE/+Gf2RKtIdx0bfGD4t9HBk6epZaEcmbcjQmv+YxZyAtdfnlCG+iE9nMjxKrSmuiWmA448DIO1jlb32S/XlAQ2aGWzJDPyIEmgnFvLeN4AM7kwMSPfTG9Ts0SzdjEDmVcLGLUlNTGs5jg+a/3fWkPfNO9kK+fB+KzXkkZGgKBfot7vLlgnqbpU4nrUXFTftlBqDALmXdgWGCpOVuOY7U4qc1PbvAXJQwamzVGILYOxgAaFpAZ0UZW4hnAGyLkUHEyJ+/1VlLwz+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iTVmtz/qwd21AZt6Ds684tagW2xlzhuJUGz0JH8uqk0=;
 b=5Yr3PUz8PUohBYazgjRKmE62+pIuRtiQ/XRvEM2fOMRUKd6rv6Z1uYXQ8tm9XxFGiw3g9qaMiJVowGjqGLir2/2rlqgxUjLVnAFma3uj8MdeSSCc/l59CJP6ljoLQnBK3Yd8UAHpUzZv9Xp93ckxSJtz8zCXB0G0jnl99qOHIJo=
Received: from MW4PR03CA0222.namprd03.prod.outlook.com (2603:10b6:303:b9::17)
 by MN6PR12MB8489.namprd12.prod.outlook.com (2603:10b6:208:474::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Wed, 5 Aug
 2026 06:40:47 +0000
Received: from MWH0EPF000C6186.namprd02.prod.outlook.com
 (2603:10b6:303:b9:cafe::6c) by MW4PR03CA0222.outlook.office365.com
 (2603:10b6:303:b9::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.16 via Frontend Transport; Wed, 5
 Aug 2026 06:40:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000C6186.mail.protection.outlook.com (10.167.249.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Wed, 5 Aug 2026 06:40:46 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 5 Aug
 2026 01:40:42 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 4 Aug
 2026 23:40:41 -0700
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 5 Aug 2026 01:40:38 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Charlene Liu <charlene.liu@amd.com>, Chris Park
 <chris.park@amd.com>
Subject: [PATCH 13/34] drm/amd/display: add a NULL pointer check
Date: Wed, 5 Aug 2026 14:36:25 +0800
Message-ID: <20260805063937.2145774-14-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260805063937.2145774-1-chiahsuan.chung@amd.com>
References: <20260805063937.2145774-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6186:EE_|MN6PR12MB8489:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a48b74f-dbb7-47f0-374d-08def2bc7af7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|23010399003|82310400026|376014|56012099006|11063799006|10067099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 7Kp3h+9RaYh8+QAXuW2/Hc6h/hwxvCQvHuYQirYziljxnDvv9arV5TS9nlqw+yfuazxCFaJTckWw2ZeISUqDGnNQJaowL57TBryiVQUm7NhZ3CifuHpyIk0lTOyF2tlzWQTzoGH9ls+uOmg4KHh3MwmvEK6nfPX3/P4J7SlKGX0iONb5OKu/CvzyfzRMU5V0tYENm9PzVDopsJFMtSqBGOb4JEEPX+iQjJp3jm+eG+fOw30qqgB+m1WNRImY+N3cDtKqSMh7mThGM4BzhDoPyZ9Yw1YnNH/EpEU9bRMicl/RlfBW3nMUsj3WYGRHQB/u6b5oNIYS6qubdo61LWCQXzv8AdVR1EMb3UcVal1C1GTDZd+1u4cflvedpi4iwUq4QgwMrSaHpudDa0biwm6mK8kU+JL70lmWy85haL7NXvuk0T4axeyReI4MJpX0IoF0OBqYHFVK/z0K1jnJsC1AcROYruSOyHjbQDHp4cCOPt+YuSGsUXIqEY6oKO1eyIJbwAJBkv5A8UyCx6tqzF0jaIZeEwsVzfJQEyXVY1Fzl3AydkePm5kzdNfULfB3yi0XWvZRT8VONTpLlu2sqd9GOOMIQ0EuOt0bjsNmZd+fnqXxpZkRS8DQZ7iaJs1R4bUJA6MPGbmW5XMRlzWOgc0WSGVqlJudESJdUkb9RVBiVN8jZR2eXnCwpnodGiDx3OIF+vNGYam9TwK77vAzwvf6iw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(23010399003)(82310400026)(376014)(56012099006)(11063799006)(10067099003)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Cj/fnu9IPLm3O7h2oLmOqqZyYl8f2vcWCwZhP+orrm37WdJZnwmvQMzLErqJWkgY4W+L7S9/pHwx1Ws+ilRPb4h3Z35xGxfRVvNEpJbPf9r3F6km1W4WqEPOZAmnFt55vGYbgq+DSvIn6oa+x08Jy7KynYqCSTs8W6dLq95s8KWP6LApm52emhmY/ZVp+pTS/tXgCZfkF827IjS93UI3sNAf6cixKY9eLMNwfnuZvUWaLYfmwWPMKVqB7Op5kaRW4lS5C9pSOmegGPAmD+Rm+Mk2cgMM6PrSMHZa6fZ3OdWoxcrvcPT69TVR7tZVZfIFVjuYGy6rCs0v4xYqXiCrJ92xC4moWEcI7w85n+3YWS9zcUrjfUsUd+rhp+3YN/TzjR0/N5df8ceM4jBBxBqBsZbiAPmgmvKt+lTOnJIhhQHX9SLH6WVq9Jg4Qw48oluy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 06:40:46.3155 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a48b74f-dbb7-47f0-374d-08def2bc7af7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6186.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8489
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

From: Charlene Liu <charlene.liu@amd.com>

[why]
a fix for a memory crash stress test

Reviewed-by: Chris Park <chris.park@amd.com>
Signed-off-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../drm/amd/display/dc/dio/dcn10/dcn10_link_encoder.c  | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_link_encoder.c
index 00e82d627d91..aee9a363e336 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_link_encoder.c
@@ -1166,6 +1166,10 @@ void dcn10_link_encoder_dp_set_phy_pattern(
 {
 	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
 
+	if (!param) {
+		ASSERT_CRITICAL(false);
+		return;
+	}
 	switch (param->dp_phy_pattern) {
 	case DP_TEST_PATTERN_TRAINING_PATTERN1:
 		dcn10_link_encoder_set_dp_phy_pattern_training_pattern(enc, 0);
@@ -1189,8 +1193,7 @@ void dcn10_link_encoder_dp_set_phy_pattern(
 		set_dp_phy_pattern_prbs7(enc10);
 		break;
 	case DP_TEST_PATTERN_80BIT_CUSTOM:
-		if (param)
-			set_dp_phy_pattern_80bit_custom(
+		set_dp_phy_pattern_80bit_custom(
 				enc10, param->custom_pattern);
 		break;
 	case DP_TEST_PATTERN_CP2520_1:
@@ -1203,8 +1206,7 @@ void dcn10_link_encoder_dp_set_phy_pattern(
 		set_dp_phy_pattern_hbr2_compliance_cp2520_2(enc10, 3);
 		break;
 	case DP_TEST_PATTERN_VIDEO_MODE: {
-		if (param)
-			set_dp_phy_pattern_passthrough_mode(
+		set_dp_phy_pattern_passthrough_mode(
 				enc10, param->dp_panel_mode);
 		break;
 	}
-- 
2.43.0

