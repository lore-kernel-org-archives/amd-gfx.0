Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1BDFCCF9F1
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 17:52:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A92510E810;
	Wed, 29 Oct 2025 17:52:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XVWx/vTk";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013026.outbound.protection.outlook.com
 [40.93.201.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B03C010E80F
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 17:52:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZwFpFWPOZG4F4nYvVcEAQbbI/sbZAHHLFThFprNvsJ6SkJ58uJz+2cFsM2YVuAtcA7ZFtg/8JLFmEOHm0frrxBXTOh/fFJhaC6I6vkuIwSu4X53wCmMWJq6cUKAceRwXlIW5MrwpM06rGWPcUGBZDjUpm4CScKApGWn7ECBSR5oDdRzjjfoazrwvB8WnEUSJjEAKOqvISSX8jKJTBlkwlkz36wC1kJI89uCuKGqJJMKS1dXF4Z+o3hEJgIu+IULrdE9lDQ6Fa3UCqCwZW4j8wiqxxp73N/5f5IFdVR5TEg/rtcmA3d5uQDentgQCU8CO03rvHUCK/9xJQIedr2hvWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m6fESEhJktlqTM6+CxK+wzo/60WBJuuSGEGOlNUNYQo=;
 b=jwLUUfkEM/z/nj7fMX/I8KZTKsYt3BIA/HaBmZdf2/JXQweq8ZgeCiHuJsDlprNj8EF3wRVO5BBjz7IonPBQayv6Yq4GEbBUqBcI4BbKqfOtKE0WaNFcR5hdA/+x5q3meGKCzEO9VNcTraAH3uIOhhKTADzcGSSqgwTyCNilx5Knt7Wtgy5IDU+dBDBefuDEDkh1p8jdv1JkdAkuR4oSVn8zIEExsjeOebseuiGnG8GBB5BwBdy45HJS5/7yRcfWwqgQM22m9IUlQYk1P+TunWi58Dza0MgKk+MV2D3ZG5RwD0X9VeiFDodwZRCMWCpGLkyfdNEdYTFatRqn0oPNxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6fESEhJktlqTM6+CxK+wzo/60WBJuuSGEGOlNUNYQo=;
 b=XVWx/vTk3fKhTIyx0wBM7FFw6WEmX+az5dsFird5fpceROpZa/qUMNd51cFdvFnF2Ueq2DlaZD4WCs8ocrQKwzdzKnd7r3tWcYDJDfYSkqhoDmJv0RTCEzvb/C6MrzXiuT3ZKd3uVcDqu8ieJTKrgrZ+ozZv4ktS5IMJo71p5OY=
Received: from BN0PR08CA0023.namprd08.prod.outlook.com (2603:10b6:408:142::17)
 by DM4PR12MB7527.namprd12.prod.outlook.com (2603:10b6:8:111::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 17:52:07 +0000
Received: from BN2PEPF00004FC1.namprd04.prod.outlook.com
 (2603:10b6:408:142:cafe::fb) by BN0PR08CA0023.outlook.office365.com
 (2603:10b6:408:142::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Wed,
 29 Oct 2025 17:52:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FC1.mail.protection.outlook.com (10.167.243.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 17:52:06 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Oct
 2025 10:52:00 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Le Ma <le.ma@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Add soc v1_0 enum header
Date: Wed, 29 Oct 2025 13:51:37 -0400
Message-ID: <20251029175137.2861556-13-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029175137.2861556-1-alexander.deucher@amd.com>
References: <20251029175137.2861556-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC1:EE_|DM4PR12MB7527:EE_
X-MS-Office365-Filtering-Correlation-Id: 2884687a-5ff1-4740-33ed-08de1713e061
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7DCbFipwRAZ7ADFFYLeXCjdQ3tBzughXnLUF8q2S5zcjmyk4Fy7dLhZV0wuh?=
 =?us-ascii?Q?CjjyiCbsWDbC9nQGS4uSWGHwmvjZsjMxdnfDaVcxNXr6t2YvGHybVYbg2A/Q?=
 =?us-ascii?Q?2D+OZGJGYp/ucAJHsqtGff/Y8X7akXxdSlEKXPIO/dAFIQrKe8jtRH7vmAuw?=
 =?us-ascii?Q?5TusHxWSK+82efLHEasbHMLKeXzskfDtqv2RCY0hvMMPoZnOzRZPqvpbuzTp?=
 =?us-ascii?Q?Dapd7ymwrxm3Mt5r7X+Vm47NAwrZ2Wd3IBf1tzq+ZGqI+slruwQm0LhZ1Bst?=
 =?us-ascii?Q?Vlf/hCR1OXDn8UCOpfBaqPg4Ux2rKkhp1EZDc+5L+oRVcMtrXgaMJBgDrFc7?=
 =?us-ascii?Q?1kREjAO5CS23VpjZ8hEeXE19oTrgm4XYx7DbhH1MoYtoTGRhjWqPuh1aO3dM?=
 =?us-ascii?Q?wD/gfhrQzYPv2HAgQ924YQWSVzGSTuq67o2bwRN3zFEpDFYpr80UHy4vYYoT?=
 =?us-ascii?Q?geowGffk1I6+FSyHNtp8I/I1DWougr+eMpiEMpDPOlDTNKl6kQpNYca8onSJ?=
 =?us-ascii?Q?Dg5ceY0dOMU6lJ4sPzUfaNv+DYnWNDzK5uWEnm+zQg3zTC/zAsZd/PeZhvfS?=
 =?us-ascii?Q?xywlzxBiZTJXHCMojtIY9MaQy/4hoOjih5c9VFqMpPSvEpfyGoT/djDPHGHF?=
 =?us-ascii?Q?XvhXazh11BmxepuSAlD5Y73KGFX5HE2z3/RLyuEr2f9m7xjnhOQC+lsz4L99?=
 =?us-ascii?Q?k+/wB8W81v+XdciA4enjvNfu1FvqqRqa+b8UE5G8sNxhBguUS8nfm3V1EBF6?=
 =?us-ascii?Q?/KsQHnStOePRr5qH8UhnHNF+Wbeph7zBEXFPgNP7IrE9d+QIyjO0A+4i1TCf?=
 =?us-ascii?Q?q5GF+cAc3Oc9EzfgX1lJVQ15Yyk9l0U/lTCh/mWIQ6ji1eHFODrsoGQu5r79?=
 =?us-ascii?Q?HD4VYJjlaqm/EcCZ5jGC3jFSFGRng5NsQB+SVjHWD/UvDbB5tYXbezPVd1x+?=
 =?us-ascii?Q?lCHC01gJ65Bl+vYMfAtqROD1Po9Lwu4b7Fi9FRvzS8kqYyM/QWcPHHlJmWkH?=
 =?us-ascii?Q?WkhD8Gbzlpaoyi88t+9VGkujcv6JCy27DnnChxLKQE3IchyAlVP81WIZBUVQ?=
 =?us-ascii?Q?PZQkmZbsxkiono0Uao/UYD9eeB3tIBf86poOQ7fUiJ5OpGPQHDsitb/FjCAV?=
 =?us-ascii?Q?myUDoIgfmJntuh0bxWVEsVuqlG+OImNbfB/Qpxi55Evnjr9x7McYpK/hPbBb?=
 =?us-ascii?Q?uDtliYDJ/+Jq64PAENYrbYdWwFNQxK34ptnIp8+uEgbal/0EV4QK6STYVebB?=
 =?us-ascii?Q?i0APOoyZrRvcKCOrrN8nTEx2fNnpy/tQTgVHmc2l6oKO0cG0pl3YjsrnicL0?=
 =?us-ascii?Q?/M3wE0M2F3FYryNRs07EnYIuzDMjRmWbOrL3aYjvqwvVpuZdqKl0a3BiyTXn?=
 =?us-ascii?Q?BN3/xeQecF3WJ61rcagq3uAMeQyUwhDPWePXluKgFg4qQlY0NRQ0niDFORzL?=
 =?us-ascii?Q?KwkZB+A5AqIwll8oTLWeuOzfArB9jBF3P3pKyb9A2M8nKkzNaGGD8erQbgkf?=
 =?us-ascii?Q?99t8HkK+WEH2MnNxMpKNq24Kd1m5wpvADMPBDpAgRbrYudISZG5jjt+O9/x4?=
 =?us-ascii?Q?8/K22YbOXxz2HmTSE0g=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 17:52:06.9053 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2884687a-5ff1-4740-33ed-08de1713e061
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7527
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

Add soc v1_0 enum header

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/include/soc_v1_0_enum.h | 33 +++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/include/soc_v1_0_enum.h

diff --git a/drivers/gpu/drm/amd/include/soc_v1_0_enum.h b/drivers/gpu/drm/amd/include/soc_v1_0_enum.h
new file mode 100644
index 0000000000000..5a0963eaf3b9a
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/soc_v1_0_enum.h
@@ -0,0 +1,33 @@
+/*
+ * Copyright 2025 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+#ifndef __SOC_V1_0_ENUM_H__
+#define __SOC_V1_0_ENUM_H__
+
+typedef enum MTYPE {
+	MTYPE_NC			= 0x00000000,
+	MTYPE_RESERVED_1		= 0x00000001,
+	MTYPE_RW			= 0x00000002,
+	MTYPE_UC			= 0x00000003,
+} MTYPE;
+
+#endif
-- 
2.51.0

