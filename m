Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC970C4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 01:30:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29B60112243;
	Wed, 24 Apr 2024 01:30:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qsrNp7rz";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2088.outbound.protection.outlook.com [40.107.96.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00C291121C6
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 01:30:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Osm887OCfx3ltoBymFkK6i9FuvJnQg2JxDuG6ZVXBSY7dsdu8N0LsGKF3KlBCwDh3n1dUV4HJ2gSDujE9I/sxZGEm66rYHgsTCFWcMXm6ss7sPPHZX4ZqwQ9gjyQsM+228rgiFp4VqQakNwE+xGjN5hPqgkP2OesNrbL8PrapCoh6EfNHAi6shsRx+HbITgVh786UDVkAGzCf3UbJp7TfBf5kNsCb+MTLq44xxv6QBSi9i0L35DmKym+G5saxM+TjUIhDCBZ01MMssLrVEpsdvYPt7V/W80AoMwq/UMfDUs6MeWmKlr/ADffP5LwtWMpIi4v9JiTgz139gs0K4cdDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oX5qNZgztg6uu9bAxu0CA7j3dxS0Nw1jG9/0A8L7kJU=;
 b=nbRNb7776heZ6cbU6o4/iqvAPeV3zHj4RozfRGWBwVTQIERAHMsiY45zlgdAOzYBgRA5rpWrX1JP7GWhS76BXivZosCFX/JgYKCzdiygw8YZ6IfboPkdO87BF+E0IsNPPpM+l2MzXzXf8YoRCjkbwtfwpSTuVxox+2LsqabqtwKB0vY2EhOxI+sjsP/7m6au1FXLRiImCZA44YdcQvlMXO/+FImiQGgrG+ZrU1Du1SJBPfE5L8tG4VY5M+zx7sjt3FRsNhEi9XCcALVzdL8p4KYeYfEB/o65eG2ZBwgTWO277gioyZ7tuaKU6CmkloyZfYKGWuxrpv+umMs00VwnGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oX5qNZgztg6uu9bAxu0CA7j3dxS0Nw1jG9/0A8L7kJU=;
 b=qsrNp7rzKjbNJkhkzLKO/vJUJh7KOGNlkNjjMpr6Hphrw0uwAeaeuuipAq/0SkXPmeoPkKUX42DdVK6fD17URTwTKEJdSNAuzdcK5jB2QdFjRwExX3WFn9LtrnE+AZE3iwmHDd4Z+jCQLmNJ4XLaZs8aR1Jmkx5NimTNA1YrF6A=
Received: from BN0PR04CA0136.namprd04.prod.outlook.com (2603:10b6:408:ed::21)
 by CH0PR12MB8532.namprd12.prod.outlook.com (2603:10b6:610:191::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 01:30:14 +0000
Received: from BN3PEPF0000B070.namprd21.prod.outlook.com
 (2603:10b6:408:ed:cafe::f9) by BN0PR04CA0136.outlook.office365.com
 (2603:10b6:408:ed::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.33 via Frontend
 Transport; Wed, 24 Apr 2024 01:30:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B070.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.0 via Frontend Transport; Wed, 24 Apr 2024 01:30:13 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 20:30:04 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Alvin Lee <alvin.lee2@amd.com>, Roman Li
 <roman.li@amd.com>, Hersen Wu <hersenxs.wu@amd.com>, Alex Hung
 <alex.hung@amd.com>, Harry Wentland <harry.wentland@amd.com>, Dan Carpenter
 <dan.carpenter@linaro.org>
Subject: [PATCH] drm/amd/display: Remove redundant NULL check in
 dce110_set_input_transfer_func
Date: Wed, 24 Apr 2024 06:59:46 +0530
Message-ID: <20240424012946.2122315-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424012946.2122315-1-srinivasan.shanmugam@amd.com>
References: <20240424012946.2122315-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B070:EE_|CH0PR12MB8532:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c9ecb1e-8351-461c-31f7-08dc63fe1710
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bsGciz1Hpw6LhqTzPf11a6mdnoeLyhRmHW0HX5vUIxz6H9cUXIQOEr+nRbtk?=
 =?us-ascii?Q?MkTsP5b5KcQ3ZNUxNropLg3m+VV9Eyj0smZUBlBkJ89+tjTKnYmX9izsMyhN?=
 =?us-ascii?Q?uBKrs+dfTQZFO2EPD6QWMrRBn7WGjykS/NERjuwjhfZI44BdX4gM9F8O2w4x?=
 =?us-ascii?Q?B9Yu/XaK6seYK2JUA6f+q/fs5lQNLRljoEsvUVspYYx+Zqiiyhia0TCtlUJ9?=
 =?us-ascii?Q?kmxaNh1J2P6cdkFwJFr22k+eMvP9Pv6ISRO3+18z7j17KGhhpoKv7wiHGCg/?=
 =?us-ascii?Q?pQpqKiIqyUpnV5vRWU1h5Bd0uCWtCOlfejULZzT1vZq+NcUCWRZoJRJgWBBr?=
 =?us-ascii?Q?Jy3azQt6ApbDjmxAriY//rWssSuO/KDKgv9/vtgrN60sSwNTsacmLPLSOXIk?=
 =?us-ascii?Q?jwSKpSR+MGqsh6+7x09jyfYtmp8Dz6xdHHqy97AaLdgr2Ue4hn/VHdIipXVu?=
 =?us-ascii?Q?X9Kt7ZxffMUnnxVhb2nrcJdYqlJzns1XqN5eTX7Vtdm7sial8FbodcflRyax?=
 =?us-ascii?Q?1Y+UIlLB4gbUNwGNdMpvp6AKw1NQVEbc1NXs7PZH6PXKprlF3CgodHhxdqr6?=
 =?us-ascii?Q?V0S2FTA+XK8XdHEZzvbski0qbwfXksGjCJ/kg66lr2a/PSQn+osxGJohdbnp?=
 =?us-ascii?Q?CQO4bv6y1Drewd5tVehylfgmGwisoZ5QkoVsmOv7rxhBFWTr5mRNdIZ7KPpH?=
 =?us-ascii?Q?y2QXNkPVLjSQ5u9ZCVRDJo+mVMx1fAXVF2eEPEOtr7V1mHgrCbA0JZzmHLjb?=
 =?us-ascii?Q?RESwRFCeJNf48HOwogVb+zUqsKF7J2JKZyN0dTGd8qvGPNS1H3s64wPiJ6LC?=
 =?us-ascii?Q?FbNSokbfLS2msDMA2GEmeCoD6aPVtHSEaYqLCWCP6EST+jBxhuhvZR0RuU40?=
 =?us-ascii?Q?6u6wQYptuCkXOahOJViJVG9HHCqW7j8bAzm5QR7T8ACfu67vKWubbSb3e6qq?=
 =?us-ascii?Q?BCIXUL57diCG/TU0vweQUPfarLrPymxbAodXpMc5Gen6+pA9gG6DQn6bRjGa?=
 =?us-ascii?Q?wpVCZA2pwYcptOQqDldP0/CijTLIXb4MzxICZ7n1iErfi30IRgjreOjeUhOa?=
 =?us-ascii?Q?wDCi6mYRXvtxDpjDN0SxoU2OpYJpdNwG7zulLnIGM6+P0oWA/xSEMUAMbePM?=
 =?us-ascii?Q?MAKvk9WJHv9Iq1uJfVES6o4SJgB/ovTxbyloa4R5LTryFiamvJgRTSwmGTVO?=
 =?us-ascii?Q?q0mBqGrGX3mW9flxIOKpD08OpsXNbf4UX4ojguO96sqlZZjsv47ijlMuQSGL?=
 =?us-ascii?Q?oKwsorgNKjZfYxy2Mbbx2aQQAOdF6YePoCcdSc4kyD/ukhuv3I0EaQ7CDl5O?=
 =?us-ascii?Q?NhoKB4WJxEZgafETccMWgnJANblkIwPPJ8IJBeLsQ5qicvy/s45H2OhMhDzY?=
 =?us-ascii?Q?oYVC32u+moIXTCM7pcj3MyhXqWJW?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 01:30:13.9079 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c9ecb1e-8351-461c-31f7-08dc63fe1710
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B070.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8532
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

This commit removes a redundant NULL check in the
`dce110_set_input_transfer_func` function in the `dce110_hwseq.c` file.
The variable `tf` is assigned the address of
`plane_state->in_transfer_func` unconditionally, so it can never be
`NULL`. Therefore, the check `if (tf == NULL)` is unnecessary and has
been removed.

Fixes the below smatch warning:
drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dce110/dce110_hwseq.c:301 dce110_set_input_transfer_func() warn: address of 'plane_state->in_transfer_func' is non-NULL

Fixes: 285a7054bf81 ("drm/amd/display: Remove plane and stream pointers from dc scratch")
Cc: Wenjing Liu <wenjing.liu@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Alvin Lee <alvin.lee2@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Hersen Wu <hersenxs.wu@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 5920d1825a4c..8e50a5432d33 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -298,10 +298,7 @@ dce110_set_input_transfer_func(struct dc *dc, struct pipe_ctx *pipe_ctx,
 			dce_use_lut(plane_state->format))
 		ipp->funcs->ipp_program_input_lut(ipp, &plane_state->gamma_correction);
 
-	if (tf == NULL) {
-		/* Default case if no input transfer function specified */
-		ipp->funcs->ipp_set_degamma(ipp, IPP_DEGAMMA_MODE_HW_sRGB);
-	} else if (tf->type == TF_TYPE_PREDEFINED) {
+	if (tf->type == TF_TYPE_PREDEFINED) {
 		switch (tf->tf) {
 		case TRANSFER_FUNCTION_SRGB:
 			ipp->funcs->ipp_set_degamma(ipp, IPP_DEGAMMA_MODE_HW_sRGB);
-- 
2.34.1

