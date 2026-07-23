Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B33CDC531CC
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2026 20:19:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3457310F1EB;
	Thu, 23 Jul 2026 20:19:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U3J0EycK";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011042.outbound.protection.outlook.com [52.101.62.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 228C310F1EA
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2026 20:19:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=otJrNmmSVWkZbJmkJCi3QsPlRxwRfrqhlFIjyA3z1rZMFJEK3QDKotf1njfIPf7VxPei56AVNWPORfW3X82ZWryIjQ3D4yMLyulPhdyeRz6b5nrFVV7UWjhLIrD2FRDAeyVwqcpDJjvyTDf9I8GPtCK5wd68OVC1/gDV1z9Y5mTLUzgkqtJixYFE3nP0pjNONmSSFB9JP23eHW+gKQR2N0ln9j7Ztxa1I6R1mtnEcX56llbEk1zhmoosIXYYr8lICOqaX4GuV5l0Cm3uymXUJm35N1KRUItNZUZtSZs+iIsnoP39SZzAramx0BcNQQVbQO5uNuk+VvZZykUKCPiw6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ALcvL/UiQSq4WXGkRGRfBO3P5IFv6FMVywLcqSmFu3g=;
 b=CkdYhgZyesWr5ygSkuFRvFQR4ZcCJidkrgnZ3O6Xq4ZldWowlmUGePtQVAGQn4GUrBeypLUeGaIM9ZgfQANl4iMU3iCAj6G/t5XE4Q3w/0mu0QYl+zI+xmB0H7CLlTcMzfG7kVMos12HQ1FNIWbpTEO3imwD5UUn+qvL1U09kvwccYh4pNSf2XurCMK7PSkoWfEjVGhdWHa6Dc8OT6f5nagmZHkTWCZ2vzx7ATN79W+TfQnF7SQU+ZRQcPo3NV8hki+LaqJWOoDLy9nCQQWV1xdjiG0+UDjDBh7YN7j+EKL94UZqP2E7cOZVAiVImM7Tj4ef9bSJUfPX0vsRmbfVsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ALcvL/UiQSq4WXGkRGRfBO3P5IFv6FMVywLcqSmFu3g=;
 b=U3J0EycKaWYJ5WS6qOdvOzUxV5ozPZnFmxoMvO30Cthtm9pKoMhgnpJawMAnJ9ibmfZHSIKAcktcOaCBxmOtpA71Y7g3FLcZlCJHedTH3mjf85iqgMiN0uZ3nySnRF0LbjCyCrhhfwHFDm7KL5vmau8HzVvlhx/mpuNeizGZjqo=
Received: from BL1PR13CA0362.namprd13.prod.outlook.com (2603:10b6:208:2c0::7)
 by SA1PR12MB999254.namprd12.prod.outlook.com (2603:10b6:806:4dd::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 20:19:49 +0000
Received: from BL02EPF00021F6A.namprd02.prod.outlook.com
 (2603:10b6:208:2c0:cafe::97) by BL1PR13CA0362.outlook.office365.com
 (2603:10b6:208:2c0::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Thu,
 23 Jul 2026 20:19:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6A.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 20:19:49 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 15:19:19 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Alex Deucher <alexander.deucher@amd.com>, "Dillon
 Varone" <dillon.varone@amd.com>
Subject: [PATCH 41/49] drm/amd/display: check if dml21_add_phantom_plane() is
 successful
Date: Thu, 23 Jul 2026 16:13:49 -0400
Message-ID: <20260723201908.373300-42-jerry.zuo@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6A:EE_|SA1PR12MB999254:EE_
X-MS-Office365-Filtering-Correlation-Id: 011eb196-c356-4310-6a4b-08dee8f7bf2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|23010399003|1800799024|82310400026|11063799006|56012099006|10067099003|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info: uAWE27rmfWDycsOI3oP4nUI+nat62kP11KGp05HyaOZYADuvWlijF9I0hFGY94SaXbCR41VuHZCpCoinl/6MB6EyJV6StN6ZzC5qhtHOuAbq+WvAppt9xuQQlHanjCWB5pWN2UNTwvbOkMDTrJdKD0o/30PRLT4nzvwFQwOV2ZSqqjHMp9flGTc2NG1w1tPg0iCLPTj551YNdf8ceAKcKxJ7Z1ZOSWc3MhDpGFqXEh75lY4gbIe7GK37xoc4kmyIBFyT0pkZH/EUAavO3GdbbqTCpHVGgTISIRmGescsoM+9FDhYK1hNjWWWNJ7j9Pno7Z6cdCZPxnMAXWUybc8rnUh67jHbcNpF7EmZHKOProiCxe9KRtp+NLQiGxj13iyR5TeiFYDLUtEMqHdLadQXLlgfSmbtvWpys9NXSUfFnT2xBIFqDJV+R3cZLYBV07HDM2rInSCID0DNJhEuT88W4d+gMOHbnX/fhxF49AGYNcm5dV03gYNrf5M337KzLu1XKdc3QuXRw9KAco5t4qqal7KJY7T5PJM200g3MDlc8ivO6K/ld5FyGmH+EKkUJ6WuzinTfb6/nIgRCwtcQ4hIwaUASAXwUqUmvlEosE2aPhufLV13IcPKsjkKoCPoBsWAwMOuLZ0iWzaqa8PFzA4Org==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(23010399003)(1800799024)(82310400026)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2O8HUBqSzZ6+LiYtFsiryzSIiTGF8EPxP5eW0rj04lghf/nCTDNzixLOyFHYOv/Qv5V83wnNiXdfyWCn3GW+F/Q7CX49YMPlfbI/1ixKHFUgzgnPMdIdOaGcGxgURNMuh25ry2Kace+8RutFYz9zF4UWf4H6e9ZMWXXNYEnHd3aHUBU+qwSlBdNyJooDLcKQuisYPFQZqRIAwAw8caPWXPjtfnBHBGXXLI5v+IE8qSBuy2aVyoSJ/mVqmc3WWHG2N4dumlRkoJYM1rwbULLVGAZIjJ0l4ttqUic9Bx9SumvI633dMIJxHVqqVwbki+RhyxSg525Dk6VkPHYFrHLlo9zJLIcmne9D+XoIcaP3fnCpVzNu2jZ6DbdLaGH2N4NfjRNNxSSHiQWcxrVhJAWsTcvnPVnXMOFFrrq0iN45sSG/vyY3DkNQAfBk7WayRZjx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 20:19:49.4870 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 011eb196-c356-4310-6a4b-08dee8f7bf2f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999254
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

From: Alex Deucher <alexander.deucher@amd.com>

Verify that the phantom plane was allocated to avoid a later
segfault.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4970

Fixes: 70839da63605 ("drm/amd/display: Add new DCN401 sources")
Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
---
 .../drm/amd/display/dc/dml2_0/dml21/dml21_utils.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_utils.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_utils.c
index 16e1315da2fa..012dff4cf3fa 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_utils.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_utils.c
@@ -359,14 +359,13 @@ void dml21_handle_phantom_streams_planes(const struct dc *dc, struct dc_state *c
 					main_plane = main_stream_status->plane_states[dc_plane_index];
 
 					/* create phantom planes for subvp enabled plane */
-					dml21_add_phantom_plane(dml_ctx,
-							dc,
-							context,
-							phantom_stream,
-							main_plane,
-							&dml_ctx->v21.mode_programming.programming->plane_programming[dml_plane_index]);
-
-					phantoms_added = true;
+					if (dml21_add_phantom_plane(dml_ctx,
+								    dc,
+								    context,
+								    phantom_stream,
+								    main_plane,
+								    &dml_ctx->v21.mode_programming.programming->plane_programming[dml_plane_index]))
+						phantoms_added = true;
 				}
 			}
 		}
-- 
2.53.0

