Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 548EBC3DA61
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jul 2024 07:20:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0029D10E4B4;
	Tue, 30 Jul 2024 07:20:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sBMIwBD4";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA21D10E4B8
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jul 2024 07:20:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lmP3HURnASCZuVfpu/1Ngazr9ehDgHZ4smBHNCKNj7E36TPmoJ9adngoOpvJdjW6VO31S5ujTxDpeUDim07dEM7ZSFmmbr4NJrM/RCP/Hc7kxWU8aWKsOidkizarQtymlflBBt16ifIePIEHUKY4sF1TY3I/rqpNukyXzt0tYDm1hyDjp09JLmG7C98J2T3Z5Zsh9/RntFK8WPBABQfcoUodYrDkfSKpcMCJJIBPizUbiWel5d/OnupMH5oTEHD5JEK+BaArd5I8fyhcvAbtVm2kZiFLpfU6+HMGq4aogA1bQs26zrUGbfMxd0yLMPDS4mD3j10dw8f2ZNmVuOqJ7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fnan953VF0O9QLv054A70MQtmz9QU2wTlx8ol2kFC5s=;
 b=mJ0SVmIqXDZlYMHP+4OuPU+69rudetKayPcKufQh0YyyCIivAABNncbq+cf1iVWWJpvBunz16ks0HFF+D6A/J0zj+/DmuMb7o6IujQfy1dCoK6g74duDMpqfYg2PTQ9cvCYjn/cIoyXPwc9sedApY2u6mSUt9+A1xLlo2M3F/Lr7wlnHaOiTbjkxVN4m5tyn1KZXnOKEpIvRNl6m72vA9xRb34uNtpb5BNLNZH8WRCPiEiVLu2E3zJkduUC65yonGxyTxYTlXiNHTcj5NwwGICbMQBOBIfdlR0XXJketjWrOVrgLmvMCLbZVBZ/Of2wmlryLvRKnTIaUPczUjBoPtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fnan953VF0O9QLv054A70MQtmz9QU2wTlx8ol2kFC5s=;
 b=sBMIwBD48VpYPw0gN5E/BBIIolK1xHOT4Tfp833RGZI0co6DrFyJn93GDxeFDXP5c6zXlI/fF6T/5JAUIn0p5vCPx5dd36MMq8bfLpJZrfoetkVvxKKHTu2ziupoUi7g7T4mlG0PTXEx9vTSjAU2UQVfDU9nH/JcSuvAgMNp2I4=
Received: from CH0PR08CA0002.namprd08.prod.outlook.com (2603:10b6:610:33::7)
 by PH0PR12MB7983.namprd12.prod.outlook.com (2603:10b6:510:28e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Tue, 30 Jul
 2024 07:19:56 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:33:cafe::de) by CH0PR08CA0002.outlook.office365.com
 (2603:10b6:610:33::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.35 via Frontend
 Transport; Tue, 30 Jul 2024 07:19:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 07:19:56 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Jul
 2024 02:19:55 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Jul
 2024 02:19:54 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 30 Jul 2024 02:19:49 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>
Subject: [PATCH 06/22] drm/amd/display: Add missing program DET segment call
 to pipe init
Date: Tue, 30 Jul 2024 15:18:27 +0800
Message-ID: <20240730071843.880430-7-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240730071843.880430-1-Wayne.Lin@amd.com>
References: <20240730071843.880430-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|PH0PR12MB7983:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d025f3f-a60e-442f-f432-08dcb0680375
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wWFIEDFP/NVe854oRyhlCNW4PQSZFwReqGh/epdkr7MFBb+fqnqOO/6AXHib?=
 =?us-ascii?Q?GfZXNb9PBaBZw15IMS9MlyykL7m5dIMSbfsij1jGXKOGB7ZzanZz4ARNKAnj?=
 =?us-ascii?Q?+6tiMTYIYcT7JQMFUw9FfawdTAApemjwOIRQvoTiYJ5GOoQTK7C/Vd/P0o4p?=
 =?us-ascii?Q?ZhxsIaA8DxiOp7MNHNgVqOERtKSj+hIp/T/YovIkMnTDidDdy69lx3XhAy+N?=
 =?us-ascii?Q?mZECUTYZXao2YUaCHkbtjOqbIdOXInOU7lI/2ZCeAU3MNfDyZI6Dr898vBoC?=
 =?us-ascii?Q?2BCp37hT+nLAe1hXcDlpnE4Ytu3P6ts1FseN1cQ7MG98ZGRxKTtwU4XcZuLt?=
 =?us-ascii?Q?iCUp3fg7eDwNrp8mW3z7Wejj5GaC5nWKpM8SVgrGI5O1EtL5sT1Yg8+e2ldY?=
 =?us-ascii?Q?GOmt2hXge6PC3GoXCyadpk3YtflAOjl9nrE0P2DxVFtEtnbXPLTl9QthMUrd?=
 =?us-ascii?Q?CH8v9PcFCgW3/wzi2Q2lI1I2HWsdXPSUo3JSdvW/945fNG84MmtSdCPDcRAV?=
 =?us-ascii?Q?uO6xA131diJzD1qtdM7XSVsvFeYQfa+AblvJ+L0uD+W+Kyi4Xa4QU3uawTDn?=
 =?us-ascii?Q?K5C7BPbW/kH3PbbXcpQmV/k5qfRZn0fLvb1EgTMRBbe9e+BxGfjVTOeg+gWA?=
 =?us-ascii?Q?MXCVXiNAu5nakq9pplL95rJHbXxo4O2lqk5o7ce07FiLbP3O6y8ju7RgGrhb?=
 =?us-ascii?Q?R6HQIrbh4ER64s5xhlt8Mre382Qclr6460oRFagKsGHyxz4VeAfIU9Wte4oY?=
 =?us-ascii?Q?GpnPG1agr57vBEFxHc8eQzGEtHfjqwtZcAsWyTXahLd6IuUETiBn1MDTG9q5?=
 =?us-ascii?Q?Z0e2aFNaiOijrmhhO5X6QUm39acXaPtc7WDT+SX7uTXmcQdn3zEdttS7WaZi?=
 =?us-ascii?Q?oxayc53i4A34eyBYNPuEu4hH4yLIib7GmchtiHm0ihPI0jh9+AHFAy7CNSNh?=
 =?us-ascii?Q?cPqUL2ZESPf5w8XE57q1Hd+SiUR+0ECdPRf5TwmwsNiKArZleRdLoDspUGA7?=
 =?us-ascii?Q?p4OBcwTAEyKxwnjCZ9yj4QOEn/MrP0SZOnvx5hbRr++E9E0rjDRzJaXkKXK0?=
 =?us-ascii?Q?Eiwlj8l+gX5qE4Xi8/H+IcPxoPFif81G4SoHMixP6viup5ft6N1997a6eUR+?=
 =?us-ascii?Q?0ZKeSaA8VVlMoOoZUl+zGwwH6PsXX1fek945nWwoip6yP3rGjvDPS90Nt9zd?=
 =?us-ascii?Q?zZlobldqLzsL7HX9HEL7IubrfDng21BAXwCQkpBhPG6fIoKvG8Iw3ixLTQr/?=
 =?us-ascii?Q?HIxPoJERW9ZdEYQ4ubgKpfAu3yS08V6NmBYZtfg3UN1InSuS4axMcjPZ11Bv?=
 =?us-ascii?Q?tpCUaT/mOWrG7raGcAle8aC5ML0yelXyrGR86Znx7SyPG9ypIAfrYAWyC0Rt?=
 =?us-ascii?Q?9ZcfpuEEKHfH8DOYJU7lrGO1wPqzBcdiosk3AR0BgQdDy1Ibt9Wo8YlJRt32?=
 =?us-ascii?Q?q+lorl0vL9hLDlTxnz5HubpqwwzqFJbF?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 07:19:56.0135 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d025f3f-a60e-442f-f432-08dcb0680375
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7983
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

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Add a callback that program the DET segment when initializing pipes.

Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index e31249d1dd22..3cd584419b88 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -1403,6 +1403,8 @@ void dcn10_init_pipes(struct dc *dc, struct dc_state *context)
 		if (hubbub && hubp) {
 			if (hubbub->funcs->program_det_size)
 				hubbub->funcs->program_det_size(hubbub, hubp->inst, 0);
+			if (hubbub->funcs->program_det_segments)
+				hubbub->funcs->program_det_segments(hubbub, hubp->inst, 0);
 		}
 	}
 
-- 
2.37.3

