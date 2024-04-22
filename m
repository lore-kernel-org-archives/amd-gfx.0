Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B3D8C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 15:29:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CA73112BEC;
	Mon, 22 Apr 2024 15:29:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MSDX+mpW";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CD0A112BEA
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 15:29:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H7WTWkiYdFgt5PGSEPtRgG9C6m03nFsCdoNHiyH7yh8euLztdxviOK3xdVEyBdZL2NQEGyY0jY080gzwiK63wJGeFDCkhJuqD45eGOa6IG6dsYbvN+m3BJN+dSDei19eUBsQ5DHo+s3+UDv5aPBnpBlo03IaBsWD2V4lX47jGtazS/BDMm44uM/NljOzvlUm3f0hGpj6yPn28/2z+KAZwD1Jl83ITvgQRlsUaOm37gMGgV4PnvUbaU/S7SM3QbuF2ltDzwZ68KXmUA6E+KXNfAjwVmph5kvggGYRfy8iNgPuYF0qNjpYx4dU+Tlyg7RW96MXlxhiB/e2DbYMS2Rv5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UATOE23nVIu4Gu4y86PJpDz8Nma9S3NxcJ0A+fTpens=;
 b=CUL34zidCoKjCjscORNPT3c9NXR9R4q21hM+RW80oeYJ+nyLLVQJEC1vk+h7IiWnAl2uZkyOfWQMOJNEg0Zq8KmEhfoTUT0c5F+2VnGOcZKbLjMWfVef7E8874bxwqCx6w3hLEsihQbZDQGldUR4PE6qFmrMfNfI7SO3fdhPnyYZgZCByVaKDM1h1ybyoTKt4tHBmrJ0P90wPfgI5k8OAvbLF6oAhnFsqcpxboR7vLKsS/P2fRILzF4Duj1GjaIjEKfS9eKW/mm+Cp+xD10nhYiSXK6cvKR1ITQXNVXPG5bLnEFg4l/2LhxD/vCiN1YHInrVtAhnOTyf3hFXuSmKvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UATOE23nVIu4Gu4y86PJpDz8Nma9S3NxcJ0A+fTpens=;
 b=MSDX+mpWRR3dSJU4iE33NCGxqcc5POeggVRv8dUnouDjw/dy1+bBR4v+bGrAnvUe9cjnFiSZq8/0uKcCZJEvxKE4TLufXk7N48WyzS66Kkl9gsgbeRRkIixjJP7EsMNjqozg4vb4lLfzivWshx1d1AleB4m1rlyAX8JgijtSgow=
Received: from PR0P264CA0224.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1e::20)
 by PH7PR12MB7353.namprd12.prod.outlook.com (2603:10b6:510:20c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 15:29:00 +0000
Received: from SN1PEPF00036F3C.namprd05.prod.outlook.com
 (2603:10a6:100:1e:cafe::7a) by PR0P264CA0224.outlook.office365.com
 (2603:10a6:100:1e::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.33 via Frontend
 Transport; Mon, 22 Apr 2024 15:28:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF00036F3C.mail.protection.outlook.com (10.167.248.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Mon, 22 Apr 2024 15:28:59 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 10:28:58 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 10:28:58 -0500
Received: from aaurabin-suse.king-squeaker.ts.net (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35
 via Frontend Transport; Mon, 22 Apr 2024 10:28:53 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 08/37] drm/amd/display: Adjust registers sequence in the DIO
 list
Date: Mon, 22 Apr 2024 11:27:17 -0400
Message-ID: <20240422152817.2765349-9-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240422152817.2765349-1-aurabindo.pillai@amd.com>
References: <20240422152817.2765349-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3C:EE_|PH7PR12MB7353:EE_
X-MS-Office365-Filtering-Correlation-Id: 38e183c9-714e-4a7d-a3bc-08dc62e0ee87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9R9HRiTcrnXGReeWECtdljYecXi9XuV3QD4x2Rulj2mHfSP6qHkoZOHtzYPP?=
 =?us-ascii?Q?gFl0ck3rbhnIkBMzoxJhnLYQrl+aJa27+ZrBLcbPstAD7tyf7Gsnxp3BKxgO?=
 =?us-ascii?Q?yPHxFe3+yoyg7yAk2s0+BziGntQWDDqNyChHXDI3QYzCvJeKLw3/5X+VMjag?=
 =?us-ascii?Q?mZzQap4ErjH2vzm+qJJ4I4/WWwN1AjzwUEioDTpRZKzoYWMQPJF3wz9TJAUr?=
 =?us-ascii?Q?e21DhCEgK4fv03EIAjahiRdQ3hj/NCfUyqJwXyXh65PcmtYl7pUYnFq7EgTW?=
 =?us-ascii?Q?Dac/DVDuSdRq6GxFUNXs//N8J46o+pDEAallHtwiw54Fz/eEuZGuO9kGu/uu?=
 =?us-ascii?Q?oFLNTQyIPtwHEQQvciPpoNhIkMVLeFRcS/jhesp1eyqIDC6CqPsD7spuTrhZ?=
 =?us-ascii?Q?Ou9sHtf+M8K8+7cghUSnPT0DuJp+9FuxlbRc4FjjQ7pJ2MpyPkCDkhiV4rHD?=
 =?us-ascii?Q?m7xDnY5+qlePvJXBiqlzCfZsd/wPys3Fp403vWwbezNiD6F0Hk4LuKRk85Me?=
 =?us-ascii?Q?Y6rwVDKuXmuz9dIy2v98xJRYjrpmWOewkPu+DSBMRM8QFj4rOHZ0C8gQN8IL?=
 =?us-ascii?Q?DcXGkvcSRy3QhBD9Vk28oyGlwX5X3zDuCeY9zEgqBWEMapI4jOOaSuo+h3+z?=
 =?us-ascii?Q?3KDoQBILx1BpAfijAP4NJsO6HEGIc62jS4ubuhnKUqZrjPDlLIsZ7/iuT/B3?=
 =?us-ascii?Q?Q4vqzTqFP3K7IuEWuwH2rzaCg1zuwgMfULDcxe5zxPfgPhFj1yvHm7AXpRMc?=
 =?us-ascii?Q?pNLUrlC7VMs/OxjnaaO7/T8vU2frUe24usor9uyOeAKtK9cUNkJ6qkmo1ri4?=
 =?us-ascii?Q?LoHc4xAiZ6Pr43OMjNJkEmj1lQTsYv9LbpNLJU62Qy5FyxFfogqRn/3qFmOj?=
 =?us-ascii?Q?IUSxKOzxReB2xpuYVZkyijyHjaS5a27i8mDiTD6m612iKCBBbMv4xj3R59QA?=
 =?us-ascii?Q?as0ypEkqCSnvzoHWDWdgzbFWg3lcCWbxPGEPV5tEjz0xVoHP0hy3WGj1bFvk?=
 =?us-ascii?Q?VFkVs8NKEOCRm5b7WFBv2BfrLnrcwyT3xE6gyQDmjWTvNKNohafadNyBLhBm?=
 =?us-ascii?Q?55QUnVpRAgcX1b90VSeP/HOd/c8xQpgMCmQsfHPtWCc5tOJxmWCN0hY2Okab?=
 =?us-ascii?Q?JKHWeF0LSU4qTqhlN2KKc14tZG/ASW6iGHQbI0vqmCmn7rGEbVL3HHF7gNDj?=
 =?us-ascii?Q?aDfrBJxnAw1LzqiUpbpYsKY6ShY66CYtYY3xPO/JzN1qhEnscFMIhYAZ5Rs3?=
 =?us-ascii?Q?vD8Sbjg/iJjsCFqwtuktvH8VEbwWs5wR2+gr36X7WiM7ecFHCy2V3SZ3W7r0?=
 =?us-ascii?Q?ymtAJVKxhbXg4/W/Y8yoLMK7PR8tUstXM36chbXmcBP/+oqeAMJXcIktlZni?=
 =?us-ascii?Q?NXPS05FmrOt22E8yAKP2h88ZQGbP?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 15:28:59.3205 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38e183c9-714e-4a7d-a3bc-08dc62e0ee87
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7353
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

This commit reorganizes the order in which some control registers are
presented to make it easier to identify the operations based on the
hardware doc.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.h  | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.h
index 1be5410cce97..ca53d39561d2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.h
@@ -177,11 +177,12 @@
 	SE_SF(DIG0_DIG_FE_CNTL, DIG_SYMCLK_FE_ON, mask_sh),\
 	SE_SF(DP0_DP_SEC_FRAMING4, DP_SST_SDP_SPLITTING, mask_sh),\
 	SE_SF(DIG0_DIG_CLOCK_PATTERN, DIG_CLOCK_PATTERN, mask_sh),\
+	SE_SF(DIG0_DIG_FIFO_CTRL0, DIG_FIFO_OUTPUT_PIXEL_MODE, mask_sh),\
 	SE_SF(DIG0_DIG_FIFO_CTRL0, DIG_FIFO_READ_START_LEVEL, mask_sh),\
 	SE_SF(DIG0_DIG_FIFO_CTRL0, DIG_FIFO_ENABLE, mask_sh),\
 	SE_SF(DIG0_DIG_FIFO_CTRL0, DIG_FIFO_RESET, mask_sh),\
-	SE_SF(DIG0_DIG_FIFO_CTRL0, DIG_FIFO_RESET_DONE, mask_sh),\
-	SE_SF(DIG0_DIG_FIFO_CTRL0, DIG_FIFO_OUTPUT_PIXEL_MODE, mask_sh)
+	SE_SF(DIG0_DIG_FIFO_CTRL0, DIG_FIFO_RESET_DONE, mask_sh)
+
 
 void dcn32_dio_stream_encoder_construct(
 	struct dcn10_stream_encoder *enc1,
-- 
2.44.0

