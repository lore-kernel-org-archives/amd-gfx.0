Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28606D591AA
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Nov 2024 17:48:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE97F10E533;
	Mon, 18 Nov 2024 17:48:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vMFnHVz7";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BB5F10E533
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Nov 2024 17:48:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jsfEfrHyIOkP7fRLRkFNySLe0Qk3bl5U4+hW80AFqwMbuIGavKM13xJY9sclq/Kpsv+4xcjjV5ZPpLzLa9qEtaF4mqXEe+bxdTLguqS5V1MTCPcXt4eOeyhYubfWc9OvCESyI6JZL/9aJfyNnuMRMRcXZpmz+ExdfAEaSq5wgJoHF5q+MtIkSen/JVgbQfHdEd4oXNJIvye6JkMZ88+70LLto+3vn+/VssmClQ0N/Lxr8uzxFjMYyUin+9tChOBq4diB7oTp3DdKlzxDDB0ITn0d+wpMqgYxoUHJHKIwi3XyhuhjlvBFwGSeYoBhnqVLtK3HTG2vwISjpy450McWXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=07B+zqSITIYYFDAESGBYla8dzQXkKsFv0xEY/mJ6S9A=;
 b=P1CUs7wUguGCPUnwG+GctNra4RGQCKDk4uSvKtJwl7IRi+yb+zLsdTbDt9jkx7/9zvoJLtZFTTiMEsiFenpWiLMJqBSAAlbz24vY24Olw4tI2awgLd415PPOkcoT57E8Mb98tPlJhWIpdx+ywPz8XbgLMWgWBznahnCM/BdTttBOx9nBxJyMuct/Yt4iyFfC/0PgMOP0o8AGBLNoeQ96VVrlersBKLa+VI5KVgqaVUOPbyERNpywuBG2490uegR/reXx4vv21ja6ssYuOhEgWIMldGJ2VbLfQbPPk1dPIVVsB1s63Ic/8yGTr683R1Ib7ZeMzCasxIED8q+GD7apjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=07B+zqSITIYYFDAESGBYla8dzQXkKsFv0xEY/mJ6S9A=;
 b=vMFnHVz7R4XRubVOQAbduZsJo66Lu63Cq3DXqR1FGQVwWvDfuoLJV+s25BcQPmar8yhnYyem8ZgoZE4w2xmTqBR+Gqj/UGdsse75Y0kbRbPt1+yNWdIq0W/ZcBDGSCuTRJG4KPmpRarnlyLI3ICJ+76CWopK7IYJr04xVqUrRts=
Received: from DM6PR03CA0081.namprd03.prod.outlook.com (2603:10b6:5:333::14)
 by PH0PR12MB7862.namprd12.prod.outlook.com (2603:10b6:510:26d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Mon, 18 Nov
 2024 17:46:28 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:5:333:cafe::95) by DM6PR03CA0081.outlook.office365.com
 (2603:10b6:5:333::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23 via Frontend
 Transport; Mon, 18 Nov 2024 17:46:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 18 Nov 2024 17:46:28 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 11:46:27 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 2/2] drm/amd: Fix initialization mistake for NBIO 7.11 devices
Date: Mon, 18 Nov 2024 11:46:11 -0600
Message-ID: <20241118174611.10700-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241118174611.10700-1-mario.limonciello@amd.com>
References: <20241118174611.10700-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|PH0PR12MB7862:EE_
X-MS-Office365-Filtering-Correlation-Id: 7581a7b9-1bee-40bc-bf36-08dd07f8ee3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qVKRD0mdYC2eIGWfu9Py93nY5YUtoA5Vj118aYLghvdZA761TXZHYIPzIbh4?=
 =?us-ascii?Q?Vub/GIOSdrhSVv1K1I8dw30Fgtbmy5BB1IqL/4HpUfjEFf/E6k0//J37effa?=
 =?us-ascii?Q?UUno90hbKZ/otVrOMQcGoNIbFdGQnFoOdKlSfS9BYz0WdPRlKUjUcBce6uTh?=
 =?us-ascii?Q?w5zjIohDRx2+yAWrF7NiNv5mSHnHL8lPTt64/WqWkPdR3Mfxexydc9Z8oQnW?=
 =?us-ascii?Q?kEhuI38JVg4WdAaFIrxsl5wvEzjkpOukp9oJOLUGOpa5fUxCCrXG+BSjARHm?=
 =?us-ascii?Q?RXUSwc5l9fgq00s/OJOCxxh9PnW//i6RstKeMCY3fmHgM9sNmnhKDCBcNRXp?=
 =?us-ascii?Q?x27NIzpxpNOVOS2/1vvkliREcZ8A03WDUZ7C52Ahn+03Fzvi5GEBckTTONfN?=
 =?us-ascii?Q?mOn1LVUTUmde8N4ZXvjhNqCb6veDJWX9EAi2gwMOXxfxb8ye/8J6vCbwunJx?=
 =?us-ascii?Q?YFwhAdakbdhMwzadYT+TLi8RUyI3OwbOtgxnWDcsQcCY/dpmzSrusmEWgq+N?=
 =?us-ascii?Q?YWcoJPyxVcbXUKY6ysIXWf+oi6DcLU48J1t6ofSCFw46gnpdqZsVw+1dpU0o?=
 =?us-ascii?Q?oZFYunEOmHd2FrY6CsE7hvXMKglV3vqoM2beRm1m+2UnWxgowbky1t9R2kas?=
 =?us-ascii?Q?/o7QupvELjW1zNJn/k/EdchD3CBHIWVGUvbKw4TawohI6Ru2JSd46/b82e3+?=
 =?us-ascii?Q?a1/mcKww5Uxqn/5u9afKLXLq20r+bSx6/pxCVWuTwA+dxiu4AJGzhYrxZ9J1?=
 =?us-ascii?Q?wAv3tk9fHI2WMvnWDjWuGBWs1pCUvLfPjNb6mq6t2JKb/zSLIo4Dnx3rD1K+?=
 =?us-ascii?Q?hldGxKY/+NFcP92awDnu/0kkR3opglRpkQi8jHVVxaJRTPyKPgxrZl1Y2mW5?=
 =?us-ascii?Q?//jTwuXKgcQWZ9kI/cn27UPfx33kxWTtBsESP+rlHZGmrX2U7XEP9ZD+i82K?=
 =?us-ascii?Q?QeCcGbeSJate/4VPXUQ0k9e5n7ScPJ2liIYYG49GTdvpdBrKifMH0MAx3ihy?=
 =?us-ascii?Q?bgG+VqRghZdRfbjlGNswlHlTiXCA248IRTwa7J8BEXd3fehkZiI71IrkL1fY?=
 =?us-ascii?Q?go/7NUqgqr8f1iMKR5/tq+fCgGSoiVfJMKrdCSSTapfWpOBcUR2eHdhoFZ3L?=
 =?us-ascii?Q?1/U6c079cA9A4JSFTZ/RAHrFkxXvI+jaevVm3RYTZ63f8ImvM20NwSV8Iu4S?=
 =?us-ascii?Q?Qj4r0GCxobIfh46arQLu+Nx7ItMIfFm5ykAZjOt+U4xOc/wOwKoEJyECtiEk?=
 =?us-ascii?Q?bWclprftp4wv4wbnmccnozq4e7JpM6ABn504Ipx7EokVR1+H7mT3l5MYtKxk?=
 =?us-ascii?Q?H4Cv+zppRuR6posuFxb7z1GsHLjI8Xg0op7H5q97oEgrqDzAVIsjXRFo75oX?=
 =?us-ascii?Q?g1biNrmtOWvh6l3HckLZneB1dai4okp8WNYP53KoulvrfRgVwg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 17:46:28.5758 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7581a7b9-1bee-40bc-bf36-08dd07f8ee3e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7862
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

There is a strapping issue on NBIO 7.11.x that can lead to spurious PME
events while in the D0 state.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c
index 7a9adfda5814..814ab59fdd4a 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c
@@ -275,6 +275,15 @@ static void nbio_v7_11_init_registers(struct amdgpu_device *adev)
 	if (def != data)
 		WREG32_SOC15(NBIO, 0, regBIF_BIF256_CI256_RC3X4_USB4_PCIE_MST_CTRL_3, data);
 
+	switch (adev->ip_versions[NBIO_HWIP][0]) {
+	case IP_VERSION(7, 11, 0):
+	case IP_VERSION(7, 11, 1):
+	case IP_VERSION(7, 11, 2):
+	case IP_VERSION(7, 11, 3):
+		data = RREG32_SOC15(NBIO, 0, regRCC_DEV0_EPF5_STRAP4) & ~BIT(23);
+		WREG32_SOC15(NBIO, 0, regRCC_DEV0_EPF5_STRAP4, data);
+		break;
+	}
 }
 
 static void nbio_v7_11_update_medium_grain_clock_gating(struct amdgpu_device *adev,
-- 
2.34.1

