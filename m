Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6807CD5BC9
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2026 16:05:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 116F88876A;
	Mon, 25 May 2026 16:05:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W2573rdd";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012061.outbound.protection.outlook.com
 [40.93.195.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDDCE8876A
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2026 16:05:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=agiVWwcVVwkB4Bryq987eknxdGIGVmAjMMuZQTNPqkeBYwpoSvbmjs8DJMVv2RtEcOCdRmYtTI+Sx0T3Cf1UWvdmvI/tv9LiwI8Kf+64GlbyyifzhHq7XkYBZ2oVtMFaw5Uhokt1YSU5YEmei01O+iCliqLgCQuSqFH4EP4WhbFUY12Yf1SUAmd6Nwf9OsSGyVqcht+GJ3z/MYbJvGfXbNE6zSOySK+5rBFU+wZaZg2aCWxuR0rXVsTTM8dxd8MO2Bl10s5MbSw1wdpQNwSKsvM5zF//df+8VjdH762KWb0dYo4YgnAgwMoqjt/lUkWU26RyNEZJ2DlzL+g65yRWgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vl/qv70Qd/WBTqVHhhPk6nyIYnXFKPo08yQJ+H1n5kg=;
 b=fpKEdDAl/EXy7jhgfqDmcPAX3+dx6J7CmhR6IWelghY+GdCF/JQp/O2R4e/GtLAxSJKpVWROynxt5mwuDsBdVYeEZl70iS62AktoeNbjg3dIpu5xmeZyueoEohTO8QDOgKGU0KLBVtuoilVlHiYRrUpFWPb6RZDKzNC6iVNfiOMWuZoEDUUsdA29igunn2fxPdz3NTbpLbhgXzs7g0bPOT82zTfam4IgnqPw2PsPQ+BpLKrcjCEW3MlYRW5I37w7Ei1w3vS4Sk9Q+s1iSL3E6kHArC+HYQDZNNRnCaL1YKm5ktjDeL0XmU40R+vW6PhLAnVfuHgoJDOouRDFzLLdXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vl/qv70Qd/WBTqVHhhPk6nyIYnXFKPo08yQJ+H1n5kg=;
 b=W2573rddfCRPlV5WLVmb1cTVHCEHWeWO6Xivr+x/7jBNa9y16zVriV/SnH88BMB0vuqewqHjjjvZ2qKNA8yly7/WS1hHTUZ6F5BBpc5x4xeeFxQyl/cfNvWOx3TPhzO261J0+J5UH8OR19xUJ6JIsPmLsKKu/mRdCt7RYQmQILw=
Received: from DS7PR03CA0063.namprd03.prod.outlook.com (2603:10b6:5:3bb::8) by
 LV3PR12MB9118.namprd12.prod.outlook.com (2603:10b6:408:1a1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 16:05:06 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:5:3bb:cafe::52) by DS7PR03CA0063.outlook.office365.com
 (2603:10b6:5:3bb::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.19 via Frontend Transport; Mon, 25
 May 2026 16:05:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Mon, 25 May 2026 16:05:05 +0000
Received: from atitest-Rembrandt.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Mon, 25 May 2026 11:05:04 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <leo.liu@amd.com>, Boyuan Zhang
 <boyuan.zhang@amd.com>
Subject: [PATCH] drm/amdgpu/vce: fix integer overflow in image size
Date: Mon, 25 May 2026 12:04:37 -0400
Message-ID: <20260525160448.777886-1-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|LV3PR12MB9118:EE_
X-MS-Office365-Filtering-Correlation-Id: aad0dca7-7f15-4026-d2f5-08deba7762de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|11063799006|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: Lx9gXUAt2AyFoDHRxDzEc6LLKqHUYL7X10VxnViR36HcXb8isTdtPHUb6ocXqJv2/Qdw4ZE3X9h19JWQ9n5L+g455lEMSrUAAr6eyWDZlvGD8GB8padKJFYQtOqC2Of4YvwdmKn6pyin5G7rnhIFdi8rLYzzo+4fLpq3GCRm/Jliivpi3QTPIqnZGVIG/f+Zlykn5rM8+zvkMYKdrAnghIFNbjyXV3FeOOjAZ4pvc5XrL3OqJPi4aw2GNrHINU9IH9i0sXm6UxGaP5m/A/GSTQqMW5hv7d6QJ1vie8GGl908M7xfb3TrLzYzfq10YUbM8CkmgQ+k4DcE6jMd1f/I4+FCRHiir2tfpqQ1cEFA/2F2tWfl6LFajmdPyk03m6cEKMIuvQBT2qLqEPxjKl0gnn3eJtiPt69TQa4AWxR2klwIaUm85joBZEkqgi1Ye7VuNU3Ogbl9ypSLm1+q9ftw+IY0Ws9WXeNYWZQE4YRzZZs+WPwUV9Fm088y1FtJFrE3WtPYvxtfdVCmRJouNo2u5vcqn9szYtiImODZPOrwYDdLlYJRuClnDcaNNsjaaXDW6rb3Ev1/s++k+8gk1AfO8+2pfk9Y37tTsFdVPgEZKyOJrX2ElxBqMM9ZjTmyRXFQ8d3Dhka6q0S980IcdTkbm209mt6A00S/j+QcDxBLrISJ+O7BHkfURc7Vl/r6n/iK07/j6LqMDNFmCdJXQnYC3MC4+oYg/AwxnYs+toGUnis=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(11063799006)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TFF94BZdhbxlqrOUDuEhAEozaF0rwaa/zUKkrZ2CL5/sk8xqp4jbX7GQKqWFZ4k1qEmoaoUzSKj5Bsa7xW5drB6/WrKkH28cGw/0xbIThbf4R/3xxOvw17rvHT2GV5NTuKyZ9t+WuvqZRvjuwUZF9JPqU8xB05rdHQgK73lz8kgrXv04bPZ9MMtm7iJE9Vw5kZXl0vu4SD3D5Whlt6PcEr5jvCUHBUQBk5kftK/ZefLXHRnn2xsaK5/D1t9iYk+MsSTFAZt0/D4IsfZ5Erd/h8/aPa5HdCC7UfK4Y3nGKjbl7KEBM/xMhNebUaABNIXTh201+zYOVOzcYHdfVtoPKGgkZlx/xEckW+3NEyliBc6qexHNYM/Tr2zePq5cWXTHt1KxF2wlz8jcyXf4IjnUKO3bhAAS1vakMjpohx8OQZPTlTnZkQQXK/etP7j0fzrG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 16:05:05.5075 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aad0dca7-7f15-4026-d2f5-08deba7762de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9118
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

From: Boyuan Zhang <boyuan.zhang@amd.com>

Fix a security vulnerability where malicious VCE command streams
with oversized dimensions (e.g. 65536×65536) cause 32-bit integer
overflow, wrapping the calculated buffer size to 0. This bypasses
validation and allows GPU firmware to perform out-of-bound memory
access.

The fix uses 64-bit arithmetic to detect overflow and rejects
invalid dimensions before they reach the hardware.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 26 ++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index efdebd9c0a1f..b24c968d130c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -877,9 +877,29 @@ int amdgpu_vce_ring_parse_cs(struct amdgpu_cs_parser *p,
 				goto out;
 			}
 
-			*size = amdgpu_ib_get_value(ib, idx + 8) *
-				amdgpu_ib_get_value(ib, idx + 10) *
-				8 * 3 / 2;
+			uint32_t width = amdgpu_ib_get_value(ib, idx + 8);
+			uint32_t height = amdgpu_ib_get_value(ib, idx + 10);
+			uint64_t size64;
+
+			if (width == 0 || height == 0 ||
+			    width > 4096 || height > 4096) {
+				DRM_ERROR("invalid VCE image size: %ux%u\n",
+					  width, height);
+				r = -EINVAL;
+				goto out;
+			}
+
+			size64 = (uint64_t)width * (uint64_t)height * 12ULL;
+
+			if (size64 > U32_MAX) {
+				DRM_ERROR("VCE image size overflow: %ux%u\n",
+					  width, height);
+				r = -EINVAL;
+				goto out;
+			}
+
+			*size = (uint32_t)size64;
+
 			break;
 
 		case 0x04000001: /* config extension */
-- 
2.43.0

