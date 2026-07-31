Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 001D0C55173
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2026 21:16:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DF1210F418;
	Fri, 31 Jul 2026 21:16:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OGWo06jE";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011068.outbound.protection.outlook.com [52.101.62.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CD3110F411
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2026 21:16:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AFp8meAhN2HAg7ltCXh+m0lVot6Js7aRzrjul9gq4D1jrtWCSZmQcye820DLipUQEZh5Zv1sCQPUdix04VKYO0iVgOCiFWs59sDP4j8W9E9Eef36yoXbQpUW1phYMfFESriKoeB6rL60nZEfadWVzN86/XtqHbGCPIWYi7p6X3lvRbvWu2L2Q4awRR7fXye5xv1ckdjTTtt+DtrPZN4Xo7oyotHyznb71yMXJnB6jpmJTr2bgTmZfc/P0lB+cCd17/ZtAene5a0QI7GbpbJW0O/pbKAh8R9StWfh1c26ttwHU5MDeL9cFTptSrRKyBR/6HpJFY7XC29vGNTHjX03hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=msW5s17QCEA9eBWeCd3UUQ9r4btIvOllgTrqEQxCLQA=;
 b=g4hlTa4b0fxBesyk2uG4FFftiT8XHJht2nYyO5svB9nBhEsLiJ4k5F930g0RCthw7yF2JZImnmTWp4QJVFC6kxekgjDi9Ieyxmhtpr+Koa6tB++oewxGXmXYvkbSOHIsmGIVKrV7FEqf3Sc92ea0vKr9z0a6bp+pbLWdACwNuFLFpArRRbTX0Ju1iHAfk38IRY5M/NYcA2qTiRBwTM82A96m0n81+5xIO8OFk4dv78BDiFPCcfAn8uGFPPVg0Ed3l6IMYozQzUQotxRdCwmKE/bhqWVN6uSuUBIvCjpxToBZ0EzFQ7xtSg0prsr8r4WqDanbPg8qTDFwUjOxUd3fbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=msW5s17QCEA9eBWeCd3UUQ9r4btIvOllgTrqEQxCLQA=;
 b=OGWo06jEFcYxizCsp35UIsl3Fq31TbLyA7KSHVRpyy6t/a6YlMWHcGICITuqfdwa/zvoDEH88NNtorf7SKZAu4HuifGUSgucYtgA45kYTdEsp2HFZpMaXoU+x8AaFYrzOmy41wY0Bu5TDTvNSO779g+48cVQKV+oKtkFOKfJOCg=
Received: from CH0PR03CA0232.namprd03.prod.outlook.com (2603:10b6:610:e7::27)
 by BL3PR12MB6379.namprd12.prod.outlook.com (2603:10b6:208:3b2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 21:16:19 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:610:e7:cafe::1b) by CH0PR03CA0232.outlook.office365.com
 (2603:10b6:610:e7::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.16 via Frontend Transport; Fri,
 31 Jul 2026 21:16:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Fri, 31 Jul 2026 21:16:19 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 16:16:19 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 31 Jul 2026 16:16:18 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>
Subject: [PATCH 36/41] drm/amd/display: Fix more KUnit connector
 use-after-free bugs
Date: Fri, 31 Jul 2026 17:12:57 -0400
Message-ID: <20260731211302.3040343-37-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260731211302.3040343-1-Roman.Li@amd.com>
References: <20260731211302.3040343-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|BL3PR12MB6379:EE_
X-MS-Office365-Filtering-Correlation-Id: 40946da9-5b13-4de4-395d-08deef48f718
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|36860700016|376014|22082099003|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: SNml4iPNDJwIGagjEtpaRDoeWNc7cg9lb4KDTG0jXXQ9fhxd17oAIZDps9F4ASzunqb16DLwX8kaM3W8iWgkJ1LdMwFjqSVokaqtadYjJ2v2j2nmO14qdhryzOz7YJviZvVjjGNukYeCn7b1MmAeVlKbosv18d9Kw/LICMAtmYLY96wrYGkib0lunz2b2+FuVcn6VqLBhH78cfD54pyme5Yf3vOvTmS7E6jKJYINIf4ngdZzVew/mrJtt8yuQTxnb8kB9zO9d63ZEviRbd2BD42CLg5vuTHudg/QNstnHpV//ysyX5dTX6jDnvJA5qZbJjYyUHJrGMb/aTIUM93Pr0iiPoyFaEVb3pCuTAQVuAlqoUYJ7sfFzJoSwjs1Zels2hEJCqNEc5AWiR8tIqJLDWP7iV2HtVrDYrow+VpTVq8otfIrk2yF6pb55dvPLwmsafhPDuKh7EXcDChOZrdbIsUvyyNeP5pXo1oAXSvf8teEjqaCXvu7mpXA6VJ26OYVxhOEhNI+EtcGUCXnmUrNG4sIff1RvwzHWldOxTKZxgF4MSHCX0R0GwTHDyrcxtNKZtCS2TNyldZZBNt5uBhPLH74YGQ1+VKNPsbtG3BSYXAYhJjNH9S+lyMQH+OY+Fv6OmCVKF9nXD3AznAnfZuBu0Wdb2p1rUkp9PLeHRc1XGbxPDCsx/RN1spBKqY2/eAyseU9ecRCT1IxYP0tTfdfHg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(36860700016)(376014)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iG3yYKWtAouDrLfXAzq0445FBd53lIPCEKzBZbG7abRBfBgnlwwb/w/6QAUSMUKwN8SGlp+B3B5jnM20fthHMJnUKIt7xMYpWjTYn1rH93mRJ5MxghGUrmFdIJaye8Eihm88JcN+8r9r/Fc/RwAeGsYphR4ZALVUv4jf9UuOmHbolWZGyVsUKOhueretpQKnMZpqv12VrsiveSKnwEH3EGuPEKHqfBtWtZnPz9L+jUIr1U/m4x9RSvbSIoYqppraJhe6r+T1bbAYzCJG8MK3lUjEHEfEr0qgCNwGiD1PHO5JlApkKJlnjum5NsLgSexJ/zI0hhCfsmiOUQ4RYcTpRtCXu5hQms7NrFuvYo2SOKwrLc9/RYoD3vvIfJvAx/VBhsRXKToDCehWA25l9YfY0v69r5a8Z0cqaY4HUy0BZdwqShycbV79TdDx/SDj1MxI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 21:16:19.4881 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40946da9-5b13-4de4-395d-08deef48f718
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6379
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

From: Alex Hung <alex.hung@amd.com>

drmm_connector_init() and drmm_encoder_init() register their cleanup
(drm_connector_cleanup() / drm_encoder_cleanup()) as DRM-managed actions
tied to the drm_device lifetime. When the object memory is owned by
KUnit, it is freed before that action runs, so the cleanup touches freed
memory. Allocate these objects with drmm_kzalloc() so their lifetime
matches the cleanup action.

Signed-off-by: Alex Hung <alex.hung@amd.com>
Assisted-by: Copilot:Claude-Opus-4.8
---
 .../display/amdgpu_dm/tests/amdgpu_dm_connector_test.c    | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index 1658d4d5997a..a54fd9529dc9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -3763,7 +3763,7 @@ static struct dm_test_stream_ctx *dm_test_stream_ctx_alloc(struct kunit *test)
 						       DRIVER_MODESET);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->drm);
 
-	ctx->aconnector = kunit_kzalloc(test, sizeof(*ctx->aconnector), GFP_KERNEL);
+	ctx->aconnector = drmm_kzalloc(ctx->drm, sizeof(*ctx->aconnector), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, ctx->aconnector);
 	KUNIT_ASSERT_EQ(test,
 		drmm_connector_init(ctx->drm, &ctx->aconnector->base,
@@ -4026,7 +4026,7 @@ static void dm_test_poll_dac_load_returns_cached(struct kunit *test)
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
 	adev = drm_to_adev(drm);
 
-	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	aconnector = drmm_kzalloc(drm, sizeof(*aconnector), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, aconnector);
 	KUNIT_ASSERT_EQ(test,
 		drmm_connector_init(drm, &aconnector->base,
@@ -4073,7 +4073,7 @@ static struct amdgpu_dm_connector *dm_test_reg_connector(struct kunit *test)
 						  DRIVER_MODESET);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
 
-	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	aconnector = drmm_kzalloc(drm, sizeof(*aconnector), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, aconnector);
 	KUNIT_ASSERT_EQ(test,
 		drmm_connector_init(drm, &aconnector->base,
@@ -4528,7 +4528,7 @@ dm_test_modes_ctx_alloc(struct kunit *test, int connector_type)
 	ctx->drm = dm_test_alloc_drm(test);
 	ctx->aconnector = dm_test_add_connector(test, ctx->drm, connector_type);
 
-	ctx->aenc = kunit_kzalloc(test, sizeof(*ctx->aenc), GFP_KERNEL);
+	ctx->aenc = drmm_kzalloc(ctx->drm, sizeof(*ctx->aenc), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, ctx->aenc);
 	KUNIT_ASSERT_EQ(test,
 			drmm_encoder_init(ctx->drm, &ctx->aenc->base, NULL,
-- 
2.34.1

