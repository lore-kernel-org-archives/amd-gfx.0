Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CF63C369BA
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Apr 2025 04:46:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 492DF10E828;
	Wed, 16 Apr 2025 04:46:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vKNI8ARi";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2048.outbound.protection.outlook.com [40.107.96.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4555510E1D5
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Apr 2025 04:46:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AZPxQM1zYgPn3OAJufDMH9I+4ky9lN8Uvfg1HjmIvI3PJsE8dL3HLQdwff9s14J78vgJZskVKlPs/5Jxf/lmGzpEq7bH8atgGyL3zf89fdHgrMhWAUyFQMzNuVBCuQWI5Nc5T8lXRuPtIjn3bNXoTTxozOR7MqUjeS3SWpcE9j349QGBSykgIXa+DSUS5v7nYv7fRCAnGaVxvQAoXiiF3Abbs9/p166aCgxEugIqIj4GPLUWX1rH2OEvj5f+r4FCvLYUktWLy0ITyEbhdNCLEsj7bc/2tQgFbvNJNYAg8yRnb3VkcC+FXeWowGvW6RQNyvp0w5tCRVlrWQnLgaJj3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2le3v97w4rnE9YKhOy21BQeX+yT0KJmcqZpXKp3bfdM=;
 b=NiFiGXqELjySoDiFpHBN3Ezz5cEFxB4f4w/dqTVtvpxxSak9K9DxTKwa7yMhuU84W/kWMlaYZvhI3OBiWEXCcV2WNtCNdeWIddswXCnDJsLyASgGRh+2YM2UN5mYmmyd6vfI4caFNBcCjIiSt7RoqC3UkoC7ueCofaAo5+rVmkCwGf/5Jf6JprL9LHmPKFA+ptHQSTtkbtLJbSwA5W5LlFuFSp7YQ0kSmei57DGjCnhfOiNZme1ketx5YxQTAb23SKfVjx29bWOOaSweIm0kGL0Qq0AyNLa1myNSuA3l7WBOHy9xqA0JszMjINX73yNJ37jd+TGhU2HiXGTlJZDqXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2le3v97w4rnE9YKhOy21BQeX+yT0KJmcqZpXKp3bfdM=;
 b=vKNI8ARiqjVy90oEDF/dTSdaz5hAz2AKRawLgwhT61lTFaFf7jypBLVfcxOOi9llqTfZR3xO+OfSXR3Lv6lEbgaU1YhCJrMBFCCG7oFg0PDNkfmzEpK7pEGyqgzI8DEGDjQX3rSlmn8BQk9MAHaTC5VuRryot2Z2fmSdFhb9KAo=
Received: from MN0PR03CA0021.namprd03.prod.outlook.com (2603:10b6:208:52f::35)
 by SN7PR12MB6767.namprd12.prod.outlook.com (2603:10b6:806:269::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Wed, 16 Apr
 2025 04:45:56 +0000
Received: from BN1PEPF0000468D.namprd05.prod.outlook.com
 (2603:10b6:208:52f:cafe::f1) by MN0PR03CA0021.outlook.office365.com
 (2603:10b6:208:52f::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.36 via Frontend Transport; Wed,
 16 Apr 2025 04:45:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468D.mail.protection.outlook.com (10.167.243.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Wed, 16 Apr 2025 04:45:55 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Apr
 2025 23:45:54 -0500
From: Felix Kuehling <felix.kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <yang.su2@amd.com>, <hao.zhou@amd.com>,
 <asher.song@amd.com>, <pak.lui@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: Don't pin VRAM without DMABUF_MOVE_NOTIFY
Date: Wed, 16 Apr 2025 00:45:27 -0400
Message-ID: <20250416044529.1147595-1-felix.kuehling@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468D:EE_|SN7PR12MB6767:EE_
X-MS-Office365-Filtering-Correlation-Id: 026e8863-635e-4ed5-e51c-08dd7ca192e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sEpp/S3yS3a3mp62ndtItE/S4zDq6f8kwPNMnJRhHmNMUNgyLPzp769R25fw?=
 =?us-ascii?Q?7fW8DQsNX74l9AnMoi3JTsfIHTEJ+mCK2hwpdFL1kgANykO1cAzngnWBTeDD?=
 =?us-ascii?Q?851bAVbXinnJr+P6b5QYJJUd0rmK/dJVsGyUaLgMDltJUqmFZi/sWtp22gGR?=
 =?us-ascii?Q?oPaxEC8cfXPrDdsbW6kiekE77kkGwuDi4w/3V6aFUStUt9ZL69Bj3IQV5pNc?=
 =?us-ascii?Q?MtaAlcs3ZCMxKMq3+OGHeyxrAJskwvB00y+RPv+2jYVOEpGSlBvVYx8UFVh2?=
 =?us-ascii?Q?fL9EyB8pYyCEr8FN8rwPdj0q0WA4GXqBVh4GFvN26lzT3DLMYKEvTfrAAnWf?=
 =?us-ascii?Q?OKsGvuhzzZDbd0YXCMr0LsZxJ5BoafuQR5if2+QivjQT1PDtLPosjBWEVJjz?=
 =?us-ascii?Q?DnseFQERzW34tThce9eEvGvREkv+bVY/Ljdur/kmqc+TYYEBe7WxtKFH4/T6?=
 =?us-ascii?Q?xZgCiHN3qHNnSu5u+tbLrVkICeLxBsg+P/wVrQS3znG1N/4SKhafZyD7YOR9?=
 =?us-ascii?Q?zz25IYricPR8/kp4Pdt5SXSXb7BGDBOzPTX6hsKLcDd7DK11BYX5iZmI7fUj?=
 =?us-ascii?Q?jqfZ/zUUJmPRKxwPL6xHQMEfwtZR2YCNjtZx811weRwsCtx9BA5pKRQ3qJZi?=
 =?us-ascii?Q?/LO6OUk4Hc2lPgfO4UVoj/veTadF1t8lrsgLaehOhU+XwCVyFpc8UUh158AW?=
 =?us-ascii?Q?q2aIBoQw+NPFLmGIp0ei+VWAqVEkXeaxIfvORSg9mUkRA//+nZvOo/bfC/d2?=
 =?us-ascii?Q?svx2EMIx6RSXis/OnyV4VUzExl0lqQGl0epS1WIDjwjy6qw7mU+A6U9bMoc3?=
 =?us-ascii?Q?QUefI9rVnietCuuy0Y7+8RVdN9TmhHcFE0nlUpfLyMTCikQptpZwYgmBzLW2?=
 =?us-ascii?Q?RdGNCllk77mqWSQyxHWdbrNjEAA/v+zo7p1cCl/XWfBzIsXkQFrf+g6uj+F/?=
 =?us-ascii?Q?dbG6XSs5EGE3znevCMZczexxGZVLW+5C8SjJo0jSvCVuFpd29VFZNsZ6c44e?=
 =?us-ascii?Q?x8q9O0Efqvzr6M/HHWTHHxUCfRtJItfR906fYrx6EREiXvxOVBtIlDA5mxvw?=
 =?us-ascii?Q?78E2xjgGUHW0szHa9UbqTbMnexgS1U5dGUC5kjkU0GkdyzdRcB4r/5Tqr0Ml?=
 =?us-ascii?Q?zsl4mKp+xLY+mYNZFTZr7rTqqa7obf0jTL09+CyW7HaZ51fqcTXbIHZLNOva?=
 =?us-ascii?Q?mAVYROlL1ggyIO4DIgX6O2QU7huCBRi7/b/YqI95AvBxM80pghrQdbY182vA?=
 =?us-ascii?Q?xKUmc0vV3S7wvH87J/en2yUp76WKE1O0pVsqPVHusy2Wi3KwBWVcvQF0F7jP?=
 =?us-ascii?Q?DHViOoa/hqG2CN+n6EVGwNc7xzVID1ncWaamauM4hnxaooRxq+8THpRMtr/9?=
 =?us-ascii?Q?6T1xUMbynXiz41dNtOYcXksEIS24UksyRsgTW236OvukttqMAxQnozQAN9j/?=
 =?us-ascii?Q?rlkYTt1ON7BrRxy0PQIDoanqxluzymv/FCQynHSnxAAmPs8PJJZXzPfR8Klw?=
 =?us-ascii?Q?Vsu/ba2nLWjRJEuKlP3Ga/wGiNZ85wchWMD1?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 04:45:55.2236 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 026e8863-635e-4ed5-e51c-08dd7ca192e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6767
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

Pinning of VRAM is for peer devices that don't support dynamic attachment
and move notifiers. But it requires that all such peer devices are able to
access VRAM via PCIe P2P. Any device without P2P access requires migration
to GTT, which fails if the memory is already pinned for another peer
device.

Sharing between GPUs should not require pinning in VRAM. However, if
DMABUF_MOVE_NOTIFY is disabled in the kernel build, even DMABufs shared
between GPUs must be pinned, which can lead to failures and functional
regressions on systems where some peer GPUs are not P2P accessible.

Disable VRAM pinning if move notifiers are disabled in the kernel build
to fix regressions when sharing BOs between GPUs.

Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index 667080cc9ae1c..9abe592968ab3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -81,14 +81,21 @@ static int amdgpu_dma_buf_pin(struct dma_buf_attachment *attach)
 
 	dma_resv_assert_held(dmabuf->resv);
 
-	/*
-	 * Try pinning into VRAM to allow P2P with RDMA NICs without ODP
+	/* Try pinning into VRAM to allow P2P with RDMA NICs without ODP
 	 * support if all attachments can do P2P. If any attachment can't do
 	 * P2P just pin into GTT instead.
+	 *
+	 * To avoid with conflicting pinnings between GPUs and RDMA when move
+	 * notifiers are disabled, only allow pinning in VRAM when move
+	 * notiers are enabled.
 	 */
-	list_for_each_entry(attach, &dmabuf->attachments, node)
-		if (!attach->peer2peer)
-			domains &= ~AMDGPU_GEM_DOMAIN_VRAM;
+	if (!IS_ENABLED(CONFIG_DMABUF_MOVE_NOTIFY)) {
+		domains &= ~AMDGPU_GEM_DOMAIN_VRAM;
+	} else {
+		list_for_each_entry(attach, &dmabuf->attachments, node)
+			if (!attach->peer2peer)
+				domains &= ~AMDGPU_GEM_DOMAIN_VRAM;
+	}
 
 	if (domains & AMDGPU_GEM_DOMAIN_VRAM)
 		bo->flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
-- 
2.34.1

