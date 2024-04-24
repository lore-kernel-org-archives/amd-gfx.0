Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE1E7C4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 01:30:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8009F10FB6F;
	Wed, 24 Apr 2024 01:30:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rQJ+vYO7";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9756D10FB6F
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 01:30:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oFcLX9gq1/JxrBFGw+8QssE4ZE3fB9HWdpjOZ2WL0Iy6TE2OpSnQU8kATA/NH3Qk7s4tZfM9k6RYfPYBgVwBFsfEM5ZW9ltn0mutvNp0PH2VGRYK7KyhnKJM8pX5yejDiAXz5aavRNmRKFKQfGaqRt+mvhznX1eS3O/rvHqqfuTP5TviWmIxhTw7L0Kj3W0IArdIzA2JW/be40uRgUOFalwVqsZgF223RO2FtqXavmf6FcyZrdZdsssnw98HaOXRaLxlIi5Rz/EcayexLDfx+0m+ny/SQdDmm5QZ1oS+du3hubmeWtE6PB02J4Ta5EtJHTI07h9uINJgoVEF4o5jkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xu/kfr4o0A5fkz1U3MOlnY7KCinD3d/Fejyt5abVTag=;
 b=mk6u8wHfVo1DhPS+e4fk3Ez1kaBU1TDewpKnUZjqaKuYfdUno3yQ5pQVIBVDLoeyE+ZXGP+1C9JT9wWVEnNIBqe5QuBKo5wON9AnEgV0kzoOlQhJEpijRJiZiy7wBQbxB3NMbybv/kv1Ux/28PIP8csdVdELxLXd64wOnbTpJH1ivEWfswU7aaPeI+FII+Zd0nICNuzN1FHO60485C7u3ZAtGlKlmozldX0WosHaA/ZM689ckspKKRZJtDf625EyAcSr9LHj6VNSXTjAVjbZZ+cjO7alDoRl1YDCwy1YIToHaHUlwfjW9JSOVg7hi2Jj8cf0vpGf2GEdGqYJDzhbrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xu/kfr4o0A5fkz1U3MOlnY7KCinD3d/Fejyt5abVTag=;
 b=rQJ+vYO7fp4v9hXpyJHHzVHh+PLrMOur9V+0uHcbGxdToqBNtppGuA+YbEXJhulTzHFG71hBmR8cytG4cu4Ve7CUqPPhCIUdcIkewM2p+Jiy0GydyP3L1k83JbvZJ5tsRA7+yeRgk61SugR2WeCq5KsTMzQrjo3Mmv7KGwBV3qo=
Received: from BN8PR03CA0017.namprd03.prod.outlook.com (2603:10b6:408:94::30)
 by LV2PR12MB5824.namprd12.prod.outlook.com (2603:10b6:408:176::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 01:30:04 +0000
Received: from BN3PEPF0000B06C.namprd21.prod.outlook.com
 (2603:10b6:408:94:cafe::53) by BN8PR03CA0017.outlook.office365.com
 (2603:10b6:408:94::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22 via Frontend
 Transport; Wed, 24 Apr 2024 01:30:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06C.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.0 via Frontend Transport; Wed, 24 Apr 2024 01:30:04 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 20:30:01 -0500
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
 dcn20_set_input_transfer_func
Date: Wed, 24 Apr 2024 06:59:45 +0530
Message-ID: <20240424012946.2122315-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06C:EE_|LV2PR12MB5824:EE_
X-MS-Office365-Filtering-Correlation-Id: 267b715a-9a7f-4726-ffb3-08dc63fe1191
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fS1dbur8MzlDJIRr8ujgo/vC+sLbCsmbzw/+03FVVW+COWjPL5nX33qWepjM?=
 =?us-ascii?Q?bx/+FDJEjY2840xQBdXnhfS8FZ/Q+4dK18qGOOiJPabgFayWQdU2M6KUh/Y+?=
 =?us-ascii?Q?M7i20ZryQhCDGR10LKxyW2utTyuKbJwKX0uha/X2MMq+xQTOugtQpKCQqoNo?=
 =?us-ascii?Q?FLWwvuESEbjBdKFNrDJaMDNN2o9TE3+YjGET8dtrjqU27BdjOHw1RTMmI2ib?=
 =?us-ascii?Q?MgvQlQRd/8XfoHTffEw7nbB3DwqBlHGXZTuQBnbPsmGkUAVj2cG4WQp5tw4J?=
 =?us-ascii?Q?4LwRmhIxX0VlDOi0il9kAlL+yQBoGdzshX36hiCCLpySv5S57FmBtslhjE9K?=
 =?us-ascii?Q?5c4Es+Bvc3yFFS5Hm1LA5f9kQ379VxX6YJWm7aQ8XqR65PpjIGm4w7QhVJYc?=
 =?us-ascii?Q?6+qDx8DrQAQNhTd9qVimWgpn3Z29GtHsF/bvQFxtvt9szxxZ2z61KxOeIqzD?=
 =?us-ascii?Q?s8+yLlEqU/wxJhQHW1MeEcFDNmgK01k4jaG26vDlvQOOMVb7KzVh3zNYhxc7?=
 =?us-ascii?Q?tl2wKb/O2GpTrl+YU6C0A/MxC663ULPBDHpLqBOzxeo3lO58yxT2ReUGlpAH?=
 =?us-ascii?Q?ZSH59Cn//k4Co6HtfT6EIh29nvjIEMFx5PyZJeVTgPjcDR/+zID18PQu64Ra?=
 =?us-ascii?Q?j4w470h2dRoEcoeb0r1aZNHQefukiZnsTM1tC1jNBy4liEIhaS1bzGdiHdRt?=
 =?us-ascii?Q?tXpnHJmgmMjsGH6UxKbUAox7VfvOERg4QHBI+RhogmkuccpJy2nsmBeUq0Kv?=
 =?us-ascii?Q?+igEjdVfEKGonp/+BYINFccXC5lhw6oNAPx5yGiQqA9zm1BoCxY+yA7sVtjQ?=
 =?us-ascii?Q?cfcld/6KdLMX8oFhtP9a3CvxORU1Gd3e6dtSoCItghCu482lcfmprGB3QQr0?=
 =?us-ascii?Q?z+F8IYeug6dir3H9kWBYdKJbj4kq8tWWcWMgFIbcKpNj0QA7ltpl8VhFy7BC?=
 =?us-ascii?Q?jOzJJxpNficZxKGwp00xrjaS+jgaU1x4Ck1v1logzLwLxX8WY/FJwgxlpSKt?=
 =?us-ascii?Q?8J+9EoGrJOZ5qyPi77zO3EAvg4jSeFY4OL8OWSvJrT4yegn39eqsEqVty1+w?=
 =?us-ascii?Q?uMKgjwFDsp/6n0Fphsk07Iqa7II6L1Jyx3PXcJVAjCSjy8kxijH5KyfTz0Y1?=
 =?us-ascii?Q?7ohxvkIMXq6zk8unSV7k0+578MT+eBlUN4c0a+uaoWsGIQwELsGpJVqlajzM?=
 =?us-ascii?Q?812JuYKBgU8i5nK2jiBU0zhIs/s9xR7Dy6XQRfwGB/48QBroJ2PAp78ejzlc?=
 =?us-ascii?Q?T+JmTSt/FtaIFBdHThQKCO4h4NZA/695ZbOg7qOf9wVQkP+2sjeymspZtLsx?=
 =?us-ascii?Q?qFvl9D7dM5JPqk7F5fiebglFa5JFj8nSxA6g71vsWN9TNKmyS/j/fXsa8eW3?=
 =?us-ascii?Q?f0Qnk0q51xAOv2VYO2kzIJewCPCh?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(36860700004)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 01:30:04.6922 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 267b715a-9a7f-4726-ffb3-08dc63fe1191
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5824
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

This commit removes an unnecessary NULL check in the
`dcn10_set_input_transfer_func` function in the `dcn10_hwseq.c` file.
The variable `tf` is assigned the address of
`plane_state->in_transfer_func` unconditionally, so it can never be
`NULL`. Therefore, the check `if (tf == NULL)` is unnecessary and has
been removed.

Fixes the below smatch warning:
drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn10/dcn10_hwseq.c:1839 dcn10_set_input_transfer_func() warn: address of 'plane_state->in_transfer_func' is non-NULL

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
 drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index 36f7b19c01ca..42f4bb45180c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -1837,9 +1837,7 @@ bool dcn10_set_input_transfer_func(struct dc *dc, struct pipe_ctx *pipe_ctx,
 			&& dce_use_lut(plane_state->format))
 		dpp_base->funcs->dpp_program_input_lut(dpp_base, &plane_state->gamma_correction);
 
-	if (tf == NULL)
-		dpp_base->funcs->dpp_set_degamma(dpp_base, IPP_DEGAMMA_MODE_BYPASS);
-	else if (tf->type == TF_TYPE_PREDEFINED) {
+	if (tf->type == TF_TYPE_PREDEFINED) {
 		switch (tf->tf) {
 		case TRANSFER_FUNCTION_SRGB:
 			dpp_base->funcs->dpp_set_degamma(dpp_base, IPP_DEGAMMA_MODE_HW_sRGB);
-- 
2.34.1

