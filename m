Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB56AC3DA49
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jul 2024 07:59:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4658710E5A4;
	Tue, 16 Jul 2024 07:59:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4H6xa+2S";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFF2810E5A4
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jul 2024 07:59:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e3BPekU7wDaiPMN5x+3KHhnKdCgcCUV7KAI41ZBWDgAVjL+kIYRHh/Q5QqnGgGCGgGkqoBrii28z3vJjAXgHTOI3uhz2RErDz2WU23OL8F2U5ucqTRAtIAY0QZBDFPdfVzigbj7HZfcANCnSZly6MqFt1M6X3XeW063Km3y6kux08rzOC93wY+sp+UwkJQa54CHSou0LyeuJRRCEXdRebu4KI8q/m0weblJfat2Dk197wl75dts0vU+qJPOriDKmgU0oUcWZh1FRL9c3OLOGCAePMFbt6EYsYKpX7MeQQITsrzv870fvf7HCI1X9Sy8HG9vwl5r0rfvx3oikwPbzYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=42HkCmBT/P2bbNGdQ9naeT7RlHvEFyYYZKQsHBoc9Co=;
 b=nimVj60ATKSwUEL2DxBzunUavR1qWoMytepxVeuBb9BHVDNuzF7dvzXXgZmxqd5HwYJpLPGCOFjiIi/kAj7qoGAI0n3HqOVlA+NRJAtpHAfLp16QkzApQo5Qm/AoqCoPedGZyjpumeGwwdyJbLAlbIrqHgm9fKhNYt1Zez8fLbcqH6p+4sWJXh4vW2RIxZ2ydYJHSiNN1AYU+rrlE7Jnb5OMjsFxA9Mm3oxQ50P9iDMLifrJg8y80CCgcRzIFI2Z2arEQpgjEXakdD3jo2Q5BKGyRAJs0KCDWaYuNtCEpMzVts79WiRi6RnQiVVdkhmUbae0UIO9l4P4n9uPGkm3Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42HkCmBT/P2bbNGdQ9naeT7RlHvEFyYYZKQsHBoc9Co=;
 b=4H6xa+2SywG5EHaQWFiVYiNQHKAPZATyY8j/0BCEmQ6yD2ajCVD9OxNG8UgHWcwaEEyhrXeurY83oRQIpyB8EIjZQyes+8USJHA5DCj1wPQsryROA6pkPIljY6VrBFLTJaMoGJVq9JA/E/L14X20nR2UHAw7aammBvZEDogvL+0=
Received: from BY3PR03CA0003.namprd03.prod.outlook.com (2603:10b6:a03:39a::8)
 by PH0PR12MB8051.namprd12.prod.outlook.com (2603:10b6:510:26d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Tue, 16 Jul
 2024 07:59:22 +0000
Received: from CO1PEPF000075F3.namprd03.prod.outlook.com
 (2603:10b6:a03:39a:cafe::61) by BY3PR03CA0003.outlook.office365.com
 (2603:10b6:a03:39a::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28 via Frontend
 Transport; Tue, 16 Jul 2024 07:59:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000075F3.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Tue, 16 Jul 2024 07:59:22 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 16 Jul
 2024 02:59:20 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 16 Jul
 2024 02:59:20 -0500
Received: from jane-sm-stand.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 16 Jul 2024 02:59:13 -0500
From: Jane Jian <Jane.Jian@amd.com>
To: <Lijo.Lazar@amd.com>, <Haijun.Chang@amd.com>, <Victor.Zhao@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Lijo Lazar <lijo.lazar@amd.com>, "Jane
 Jian" <Jane.Jian@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: Add empty HDP flush function to JPEG v4.0.3
Date: Tue, 16 Jul 2024 15:59:10 +0800
Message-ID: <20240716075912.193722-1-Jane.Jian@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F3:EE_|PH0PR12MB8051:EE_
X-MS-Office365-Filtering-Correlation-Id: a79fc390-f32c-436d-274a-08dca56d3416
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eDdfh9fFmHd0Ew6B/BpECYh0qb2QZUK+BQ4/UpGx/Ifw8Ri9CXJbPD2Fer2i?=
 =?us-ascii?Q?4v/caW2S1XayfDk4EXUjgbjxwvvxDieZLmgTD7RkN/29BFlZsG+3gcoDdlQ+?=
 =?us-ascii?Q?OavQq2kLkl4LaIG6fyVJKuESGQgl40+MkTJSKYoqEangZmbUbApDB6bLJDYM?=
 =?us-ascii?Q?kzGsxJ40d/USi/ZcFrtFSQFeso2ap/5rQG+O5lbZysEFW8wASTkuE+czEYWK?=
 =?us-ascii?Q?D2ETY2wyFRuptL6ln5j6uUkmAhLhLcLlDXmE4yIfscjT2JhL2AckT+rrSdhB?=
 =?us-ascii?Q?o5gokdpZCWPVjbfrGSvT5rVcbRHqBff2JdQ+Wm17uvi/ro2P/9l8bE+rm5v+?=
 =?us-ascii?Q?za/CAQm/F6NVcpCUXCTl7pwD/DFyBfFFDtfE3wAEL5NC/rXhEfyV4OudP3cF?=
 =?us-ascii?Q?85UGeN6NDbJQfLe0s/0rRWZiyhNAVXCLkQLHyMS5Q7h4RIbNaWc6/8BokK3N?=
 =?us-ascii?Q?AqVTWfAEuyFd1TvPHeWTCV7GoMURa51c9/pbmxHF1UMcaLmgdmxCfqzSykQ+?=
 =?us-ascii?Q?Ip6rFVsdNW2W02NAjWjb8co6O+d5EcLcv266MCcgwrLbmMKA8GwGcvRXNq70?=
 =?us-ascii?Q?IJHVxSjhuG7JJRzXiGb8Lmcmc735M+l85ZrahccTqZXv8PnMGZnpqoKrleSH?=
 =?us-ascii?Q?VnUtE48DVEg96+OtJU6sEJUXXPuvFod3Dr0HoZgTNNC+zioUGK3pmavaS6um?=
 =?us-ascii?Q?DYq20pNXIX6yPU1vdb9vywZoZKopl4Dk0s+NK/Qisq7XEg3VQtDeEyZijzCX?=
 =?us-ascii?Q?8PrD9zLn76+PmPQ3uMs06CCIIKGMgm0/DyWTZtvhRI77cYXLJb4KqQ+uMd+x?=
 =?us-ascii?Q?xcWO9I5LouNKuJAZ/M97g7wwUTno6glW2TFnViGz5ItmlDlEITqKWxbSKZ41?=
 =?us-ascii?Q?MgFVM6ANEiNLiQpcEkj/Hv4vaSDSlLICF7C4oLCFzaZl7+JpYHBT4jsiMUvk?=
 =?us-ascii?Q?n4/n5unDVE2Ai/KoIbfgWqUSo8JEY3mBepSdRBProbPOSe+QlrbdDtu5qyg4?=
 =?us-ascii?Q?r/ruRN+YrZqtHTwhpaSAYP5kE4muOlMpPyEoNwQOF7bFLnTFVTlQOAsvmk5D?=
 =?us-ascii?Q?bDSP36rVoyMg8SDHG5Yq60rPassbRzreCsjU98PbkRTuzy07z6FwbJTgCLRd?=
 =?us-ascii?Q?Dwyn5RRKeHcskSjOFc85xyz2wBqJUzdS2srG3bRbfPySx+SpP0cK1WTOhFkc?=
 =?us-ascii?Q?mAFD0pOnj6CsKAqFuD6XAu2VtljtgqfE50GjQmyHvMOOcjQTwWsEOcPlsDYa?=
 =?us-ascii?Q?wtMsPr7wf5211pPrA5y0nOHxfDS2TWOJisCpoutqglz+ejzahCo0Txfj2A1L?=
 =?us-ascii?Q?iCueu7C4kr8ECGUbaWyRFcBFYoWfFCN7JuBJjUmCOllLnk3DjRtMKGekdwLV?=
 =?us-ascii?Q?jn5uXWmsb1ffaO8n8S7/+haoj3JFnAh1rmMcek0MYvhllsyHbPjDjeq+3P8I?=
 =?us-ascii?Q?o617ednqIYasRdkQ2e9gKzpWjMVOONFg?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 07:59:22.1778 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a79fc390-f32c-436d-274a-08dca56d3416
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8051
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

From: Lijo Lazar <lijo.lazar@amd.com>

JPEG v4.0.3 doesn't support HDP flush when RRMT is enabled. Instead,
mmsch fw will do the flush.

This change is necessary for JPEG v4.0.3, no need for backward compatibility

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Jane Jian <Jane.Jian@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index 04d8966423de..30a143ab592d 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -621,6 +621,13 @@ static uint64_t jpeg_v4_0_3_dec_ring_get_wptr(struct amdgpu_ring *ring)
 			ring->pipe ? (0x40 * ring->pipe - 0xc80) : 0);
 }
 
+static void jpeg_v4_0_3_ring_emit_hdp_flush(struct amdgpu_ring *ring)
+{
+	/* JPEG engine access for HDP flush doesn't work when RRMT is enabled.
+	 * This is a workaround to avoid any HDP flush through JPEG ring.
+	 */
+}
+
 /**
  * jpeg_v4_0_3_dec_ring_set_wptr - set write pointer
  *
@@ -1072,6 +1079,7 @@ static const struct amdgpu_ring_funcs jpeg_v4_0_3_dec_ring_vm_funcs = {
 	.emit_ib = jpeg_v4_0_3_dec_ring_emit_ib,
 	.emit_fence = jpeg_v4_0_3_dec_ring_emit_fence,
 	.emit_vm_flush = jpeg_v4_0_3_dec_ring_emit_vm_flush,
+	.emit_hdp_flush = jpeg_v4_0_3_ring_emit_hdp_flush,
 	.test_ring = amdgpu_jpeg_dec_ring_test_ring,
 	.test_ib = amdgpu_jpeg_dec_ring_test_ib,
 	.insert_nop = jpeg_v4_0_3_dec_ring_nop,
-- 
2.34.1

