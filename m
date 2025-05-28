Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E125C5B549
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 17:28:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2044710E6AA;
	Wed, 28 May 2025 17:28:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fkZrqFw6";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CA8C10E6C2
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 17:28:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q6BjEwN6kvgOJ0EWHnlYz/ko7SIxJVAxuc0PXCIcxwj64LUDI/Ed0eQOPjMqHn3eRIHTW0zR1lIhBcS75S6dUyhDEEg6/1W5267PXBgxy6NxEs8Chtqa6uzE6M3mnla4zrm8VIJDX/HMHEEc3OSYtGFhHqd91rID1nFoI3i/l2Ja3mZxilKt4NV4qmQa0kB8mB/kRDB/fhqBoYpUJwK+qOgRi9bokPlkxrN5LG7WQEOoILTET7NcGVORmO8YefZ/yBBjDbKP2v8ZSgIiJLmmFsgyenCbZMGxtTxqJ6dbYS2R8uBUtWXNrWbXkhB/B+dCFEKIbQ3LNzzq9SpUbpSAjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=29zvxUUtpy/W+gy0AW0aBtI5N/RT5jAFNNdSTDNR4KY=;
 b=d8fa8h5QSDDS0tJybqLZLS8jDg1/zJUi9GkprF8Ch4hvKPflsqNTqe5PHqnl/yZK++Z+aBZe7tmFy75rxvVnMiqC6ZxzkTqqApDoed7m4szjpqbEijlY74oon7NzJwrJEWYoaqbtxrnjm2/tU+OXJg9xeLzQo2d6NnGv/ZEWIW31rQ1By5L+n3lpi5Q07wNMnVrYZBQiDUPqSX8ZuntKI7+QRtld0ADMy+7nYqs2fiulhYeuk6vk1U7s/WmurOu8TcAj00W9SOvEcUaox+ToRSkSQyFpsH1evzHOElhcKIbJA24/n1VAptyYGlLnSiJ431vHb1cxG02/ztO4i1FFQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=29zvxUUtpy/W+gy0AW0aBtI5N/RT5jAFNNdSTDNR4KY=;
 b=fkZrqFw6RwcXe7/Qe3MALCkQA50M4bOE2D+1iJEHaKxaOH3JyhCBBVlOUhdY3xLlERkRjeoResFwZw5iY2VElcBRsEEKiGfsOQaSSAtSxPxpLeNO8o5Q3hHS8ALP9/+Y7TFeKNSAmUwE1/x3fZM9ee250v52t6s52uJocgZcyto=
Received: from BL1P222CA0008.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::13)
 by MN2PR12MB4176.namprd12.prod.outlook.com (2603:10b6:208:1d5::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Wed, 28 May
 2025 17:28:16 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:208:2c7:cafe::a6) by BL1P222CA0008.outlook.office365.com
 (2603:10b6:208:2c7::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Wed,
 28 May 2025 17:28:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 28 May 2025 17:28:16 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 28 May
 2025 12:28:15 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 01/16] drm/amdgpu/gfx10: enable legacy enforce isolation
Date: Wed, 28 May 2025 13:27:46 -0400
Message-ID: <20250528172801.34424-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250528172801.34424-1-alexander.deucher@amd.com>
References: <20250528172801.34424-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|MN2PR12MB4176:EE_
X-MS-Office365-Filtering-Correlation-Id: 30f0c63b-6e2f-4e98-fed3-08dd9e0d085c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zpZWkrzq5zZg7X5i1W39jVUdRKSK4FVhVzybYOnFravADvgXDbPatV/3xmFF?=
 =?us-ascii?Q?r1kLnFvXIoxEPu4/MUx9kCt3Q3syuzWVz2Pa81RMjnTIrMY8/doHt2BlJW0N?=
 =?us-ascii?Q?itLV0QO8A2keJD/X3oMjaAG/HNbVathaXqfG3DZcV1m6GqE4dCO/KkIkQjzA?=
 =?us-ascii?Q?t2SpPLutrsYHht7Po1BmZv02n3iU+sAo3G9RBYpxc7POP1MJgxOMIC/x4Ocx?=
 =?us-ascii?Q?PVQ4v13ob+92giVwO/+8hq9I/kOIcQrAVPGrQGm6arvDngl6dCJw/droQEnD?=
 =?us-ascii?Q?QVu+V83VkgRXoTd8APPsKf6B2NiWK5AkuA9X+VPSw+RGOYfDAypaXfpj+Gf2?=
 =?us-ascii?Q?6+/O0fo/qNm8DoZ9GEOp6Eh2OtXByYLyd0ubDyI1sjr+lirljmqqsVfJIrJz?=
 =?us-ascii?Q?6B/LSXdM3P/o6SLmRmPjWj/VtbNXMd2QhzmeyqTMP3n1+K87dG7XzCleDxfW?=
 =?us-ascii?Q?OxOntIH3NhmUTieTLoM0M5TAgLO5S7AdrvBFEXZ6k2/6WVqZ3rhROaCrdpsO?=
 =?us-ascii?Q?M8sQbG6VruoXabuic6vj2VlgHPSe/9b4W8L6AFo7ozr/fBqiBCh/xI/Fipij?=
 =?us-ascii?Q?+mEGAjA+PidHdmRIhX/FlWC14so56SilkpOWW4Pp4T+HIQJbIAY096K30DAi?=
 =?us-ascii?Q?jEPshuLYF4ZQkI7l1qE85fQqNFQ4Fa43bOHV6rcXuE8oisR70hJ5DqY56RNB?=
 =?us-ascii?Q?oGJ6Rqr7CY+kKGaEg+o4sz1smjKmfpuZ1YF5P8glaR+vIAiy6NbB3N3VCbMv?=
 =?us-ascii?Q?TcG1C1ffZtC7akYTUuKOFy1RrnOr8dCFGfNHBXyDf8pQUwTLMwXTFZjnPAuy?=
 =?us-ascii?Q?LUMSBYaCl9nlURwe2xPwY87hOeElDRCDOBhn/ZfannDy2T2lXGg+vC8OwLJC?=
 =?us-ascii?Q?QhmPKdODnU2ChQ8oucRqfB7JDnhlaXUFctUiuz//4A++LkoCd9GoqEvLJmEb?=
 =?us-ascii?Q?cnEaZsZBRGZF1sXLEMlnSoUkhIuPZoXywcFKpbTQJ4lSOvF7LpGXkY2L1Q3v?=
 =?us-ascii?Q?kqWbS/zFcJlWybv9AUa8bGtTx4+/wKsLtAKXWjfHkHFJ5rx8UAE1A/nq3UGF?=
 =?us-ascii?Q?NyXTnJUH6njdA7P3uQoY44sVIV2FKgM+Rj/zH8dsplrgJcgv7+K8dVNJmVIp?=
 =?us-ascii?Q?DXZ/nOZAU3GfFNp5GmtvZOIQJi1YDly/lRGn7ds6GJaElyHdGQ1h10v+JRXm?=
 =?us-ascii?Q?VNSTnQKoqcrOKGAXmIDX0+g3L2ab+W2hQ8JRfOpnYr1dh/bm/zk9Ivy5Gnb9?=
 =?us-ascii?Q?gRCbOPsBXZ5FKr/mDm/DFXO2ql1sE3ns1kkNSB4EvbHvFbnbASe1HzUMWslo?=
 =?us-ascii?Q?Mxs5k7lNHrVWpLtyJasNDqARSLxBwGrG67NF7X2X3ZL6TxEz0Z8BpsPjdyq2?=
 =?us-ascii?Q?4U10QyPJPrTDxImRrKd8LvMo9qlJbROcz0iKtIMtu26cU6MQ99mczHxS94+J?=
 =?us-ascii?Q?e3PswfFYh/aiCKnWPaUjhMkk+zejsn/3n3F3IEasHazw6Y/I4r809vm1bK6w?=
 =?us-ascii?Q?pFgpG67zSuFhNh8LQ6mopYNix9GfMfoyVSNL?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 17:28:16.7909 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30f0c63b-6e2f-4e98-fed3-08dd9e0d085c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4176
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

Enable legacy enforce isolation (just serialize kernel
GC submissions).  This way we can reset a ring and
only affect the the process currently using that ring.
This mirrors what windows does.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 75ea071744eb5..3193eb88b6889 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7788,6 +7788,15 @@ static void gfx_v10_0_ring_emit_gds_switch(struct amdgpu_ring *ring,
 static int gfx_v10_0_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	int i;
+
+	if (amdgpu_enforce_isolation == -1) {
+		for (i = 0; i < MAX_XCP; i++) {
+			/* enable legacy mode by default */
+                        adev->enforce_isolation[i] =
+                                AMDGPU_ENFORCE_ISOLATION_ENABLE_LEGACY;
+		}
+	}
 
 	adev->gfx.funcs = &gfx_v10_0_gfx_funcs;
 
-- 
2.49.0

