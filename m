Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E330CC02194
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2025 14:44:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E1AD10EB26;
	Fri,  7 Feb 2025 14:44:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vP0N2gV0";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2082.outbound.protection.outlook.com [40.107.100.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DBD310EB26
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2025 14:44:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HwFiZgwyfxPEwY3RNYh53l7qCepqX7Gpt/cZ4AsYvJRCQznip7Bf31hn938W+XYf+EYuCbX9SpiPnJABS2x4kTh6AHb5DznsUC3kFX0Lm2fWtlZJT4rPFRXJlz+AqwsHxlt5KNM5Q8Fiz7PkqFneqypRWNoS8jLj3bC/Coe4LkqcjawzoymUeKJpI/okeGsgWnJph2T+INi0ApcpxJWp7rSwGdukZTj9KchUdAcprnmx7NP1MzWQUGPYYK7RRUwxYcoQCDjUULBZfVr7Ud59ewA9p6D1/ttoBJI30Lm+1tlgbXgK2cyWnIJR+bz5u0ZUp41Mc09Ir9NhPGhWuKSBIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ypXWkZIFWsBA4w/T9nRzyIo61IhMwxUqqOxx6LDCA0=;
 b=Fj6aEVJ3Kvfcpo2GNonjX+TuCyrb6/VKUwdAOUfatMn+1ULBeVJRISgM2ImdrlHgeneaQhea0e9ulP1F2/zw0kY1/4y0pZH+CLg5FBBEKhTLuMZeoo+akvrg6/xYeU9VJw2YGYpZlRpzkkAwnYfN0r6CmCTlA+OZx+tqKdIIGaFJCVxf6JU9L9nLG9mfDhQG/QevT/QlhZYxAZPYL1ThbooNK4idxbdqBvxTBmJvOTg+/k236FTLg0atNWt/Yzm/iY3Awd/dgpG9hqrmuApBXDg5w3O5HP5FrGqCg+DARy8Nuw2blDDn427qvrpc2D5N3kvsqx4363Vfj+Oal6AYbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ypXWkZIFWsBA4w/T9nRzyIo61IhMwxUqqOxx6LDCA0=;
 b=vP0N2gV0LMFKf6cOVDvUmd/cV0KLDDWuz0Ltf1n6QdhHhXtyXwNvi+qxHABjKsJzCd5uhfKPMYKdGBek2CS46FqGldfxod8TkBG9nN7zkTf4L/IezNTh7JWtlpTraOAFq01/UO3F8DW2nhn+hS79eUYF+0HQiNqoEPo8HBbO63Y=
Received: from PH0PR07CA0077.namprd07.prod.outlook.com (2603:10b6:510:f::22)
 by CY8PR12MB8193.namprd12.prod.outlook.com (2603:10b6:930:71::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Fri, 7 Feb
 2025 14:44:08 +0000
Received: from SJ1PEPF000026C7.namprd04.prod.outlook.com
 (2603:10b6:510:f:cafe::8f) by PH0PR07CA0077.outlook.office365.com
 (2603:10b6:510:f::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Fri,
 7 Feb 2025 14:44:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000026C7.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 7 Feb 2025 14:44:07 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Feb
 2025 08:44:06 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu/mes11: fix set_hw_resources_1 calculation
Date: Fri, 7 Feb 2025 09:43:51 -0500
Message-ID: <20250207144352.920100-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C7:EE_|CY8PR12MB8193:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a1dee4f-e285-40bd-1ab5-08dd4785e06b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WKlXlz3+rgDsagbsMx4PUotytPruxY7k9leQn2BwvOQdQHV98fPWp1/Qhe/p?=
 =?us-ascii?Q?en1TzbOIgs2XRYRMI7LQQpNfswXnfvKRloTwJkATr2f1ZZpjfXtVG6iQ/NLD?=
 =?us-ascii?Q?6XAbnWsazCv5a1533Mm2TuCOsCGdGww0zycXmybGUaQ6Y+vPWPqKM75Ua+Ws?=
 =?us-ascii?Q?xFdUmVF8MagL+oqwmJZ0WQqJKYrl58f9N6apTJ211zL9SgKvkUXaUAT6nuGE?=
 =?us-ascii?Q?ShPzYL66UaIrTp2aUz53HZMaHEfx5z/qZJ4i+gr6s2B0HicfuC7okast9T96?=
 =?us-ascii?Q?8EuxJIRxlpUEPS0hLxrkPcOtk9hFcFhq5+dTI/k5UijycYMrGfITkx/qzezL?=
 =?us-ascii?Q?Xdyf/jdKWQKNBtiSahWSOGDqGAEjg5e9fddNk4/2shE3modtsAlSNLyNoMig?=
 =?us-ascii?Q?1PR3H7b4g0NkpF/P8S0G9I5V4j6WNPHD7XmVl7UVBwwjtepEPeycNihn4eyE?=
 =?us-ascii?Q?11RlTR86e2gpBlZ6tNn0XKHNJCA1Wmy2aZTDQDftmAoh5jkEXTKDFRdJ6aB8?=
 =?us-ascii?Q?OS8lx/P0LzVTc3wNlyEQI1erfwpVpkpBGnvsCHIOeAyRjIauurzPSn7iVm9W?=
 =?us-ascii?Q?BC7ciR7Bn66FXv1rCMKcgPHD+v53Ly1UXwcaBmkvM+lr8RcVSBGvjujN6aDG?=
 =?us-ascii?Q?/OtngefBY2ArnKcKdvI7ZNsmGhLKsn6IVYWagWcfYDvWc3oI7MwxhPVXMJXy?=
 =?us-ascii?Q?MAWDOtlUpSJO0JSiQGQCvcLXx4EUhhqPu8OjGmpWkz54BbC6x3WtOq1HYeZC?=
 =?us-ascii?Q?E0hYkmyCC6hdhXvG/uZH4dgMlKGR+495CnNSc+sYqT7whbfhDKLspUAxmcPG?=
 =?us-ascii?Q?0dkIod4x2r4kpvc4FWW71sJ1vVM+idTss+bjkeXRIgSUxVBChUa+5FHaIjhI?=
 =?us-ascii?Q?a2spobSH4OMhCww/nlw5iGHvfDCKWjTvmAOej5jnEDr+IQEa+X7NnMjVJtF8?=
 =?us-ascii?Q?sudztSUF1vYXJXjm4q/njxevQrzryQZdSJhs6SivElq9uTFji6YBS3m7hTpg?=
 =?us-ascii?Q?+p56upsX9vhwLaUQqn62puifrcA9e2o+RUax2yyFjwZk0iw+Dozq/S01grR9?=
 =?us-ascii?Q?OKXAbB8AorsfqQdL5ha2CqUx34afn3j7CTmTzP403+cK9zoc9MmyyEWQou1k?=
 =?us-ascii?Q?0Z6h6K1FxlRS9m3bmsbMul3kKETaPyiWCcoV34PW8LD6d53TeP8sQ7UdmCX6?=
 =?us-ascii?Q?qi67aiY/PdJRxnTaizX8hW7WdxJci/aRamVpXHd3HiukILdFKxnMECJvJ65N?=
 =?us-ascii?Q?gVzFPoW+mdGpY+MS/clCmR2TZ3zyZeAsjuAaGbNJeXQgXzPTk7EDOVd5//bN?=
 =?us-ascii?Q?V7vUcr7xf7j1ZcfwXItoA7HlIGbo5tFlalJo3z42h4vJ2O9yu2+Uffsl/d81?=
 =?us-ascii?Q?cpYsDR6ZOWunQbmsyRbFyvIerNEqx/H5U04uqccbTy9Wic9SV8M1fdzmKopk?=
 =?us-ascii?Q?eaNZIzIUKoC4D4sknYxpj1jWfi0lDyHl8UZwuygLO+eLXZrODW0lsg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 14:44:07.6253 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a1dee4f-e285-40bd-1ab5-08dd4785e06b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8193
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

It's GPU page size not CPU page size.  In most cases they
are the same, but not always.  This can lead to overallocation
on systems with larger pages.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index bf51f3dcc130e..e862a3febe2b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -743,7 +743,7 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
 
 static int mes_v11_0_set_hw_resources_1(struct amdgpu_mes *mes)
 {
-	int size = 128 * PAGE_SIZE;
+	int size = 128 * AMDGPU_GPU_PAGE_SIZE;
 	int ret = 0;
 	struct amdgpu_device *adev = mes->adev;
 	union MESAPI_SET_HW_RESOURCES_1 mes_set_hw_res_pkt;
-- 
2.48.1

