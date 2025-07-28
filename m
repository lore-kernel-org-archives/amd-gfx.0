Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87EC2C87FCB
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jul 2025 17:37:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00D5410E557;
	Mon, 28 Jul 2025 17:37:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="epv1Dg1/";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC54110E0D4
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Jul 2025 17:37:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ndmWPxwTkTkcv87Ga4p9/8Uypfvo6/gCiuTq+JPNdN6eZksg2k9rlwYvOgZMq20I8rkqyHvoI6UwbA7h9of+rsX5pNpF97Qd6TKninwwRjwbnQjq4V7gQrCqBhEi/OY9ZIvy/Xf1JSmM9yN1F0DzNwTyBZJtl1q0KVn8UW0MThjGyNPx0br7mTe0LqaP4bd2erHl5ApDCXo262FiWwiK0QdNf91kQtbRH1PHd52S1lrKxoFhvz+x7sBQ59tz1k7vhVjPT3aUIBcmEsnDn/B04Iep3fCfdvG08wWJIKHQYpfq89mgRW4N6anZs33S07QrhgyFiCRrt42o1R72PISH5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ftVlvD1NP15zmAMbTjrqpeiGFB2v8sUswT+EGV7oNvA=;
 b=ma6TA7UuNs+9rgvNTA6yoXhZCZCkCib+ukh2gUfcEy0/YewJDKJR2rO8ERQ1MzqrmDi4gyoVkAR7eQk2v9x3CbE2tvlkeAv/B5D9So089KeTUQ7B9F89JxmN01QK3kuG2tMpQaLFC4bOcMK+28TUWyzZJQhD84BqKZUdufOeolCYnTxnItQFq7IfeJn6GRgVVmDiK1UE8fm4ki+DOiZth6qKAdqsTT1U8LvXbMYezV1moOc6UPno6W6MJKl295qonBM3vrbkNWUf6uWYQvISs/c/gzo3QUzL1hLsho2p50Sotj77bAVl64h/Jpftugl4lfuXUmqJxf2aCtukVDBLqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ftVlvD1NP15zmAMbTjrqpeiGFB2v8sUswT+EGV7oNvA=;
 b=epv1Dg1/wLQRH89UEOxmoug1oq81Q5Q6+7wCmr0J7C4aa1p0LE32qKJFWxid0Q6L9GLQ3lq9eCnoJj+dc84ulsob8sAae+rSgm7M8u6ZhJ/y/e5c+ipO4wpYG6QCXvFv3NFzPg3SLNMQY7sNJQ4sJ/99U/nYZzHOJ8Eus8rJ11E=
Received: from BN9PR03CA0773.namprd03.prod.outlook.com (2603:10b6:408:13a::28)
 by BY5PR12MB4035.namprd12.prod.outlook.com (2603:10b6:a03:206::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 17:37:50 +0000
Received: from BL6PEPF0001AB51.namprd04.prod.outlook.com
 (2603:10b6:408:13a:cafe::a9) by BN9PR03CA0773.outlook.office365.com
 (2603:10b6:408:13a::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.26 via Frontend Transport; Mon,
 28 Jul 2025 17:37:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB51.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Mon, 28 Jul 2025 17:37:50 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Jul
 2025 12:37:47 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/2] Documentation: add RDNA4 dGPUs
Date: Mon, 28 Jul 2025 13:37:33 -0400
Message-ID: <20250728173733.27723-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250728173733.27723-1-alexander.deucher@amd.com>
References: <20250728173733.27723-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB51:EE_|BY5PR12MB4035:EE_
X-MS-Office365-Filtering-Correlation-Id: 8eb976ea-1fb5-4e97-f260-08ddcdfd7990
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OzFoYN3eqkkqAiwGjeAKWi8Nj3MXLuMrfeNRxLCv8ZTw4Wsmd9NpXehcOYu9?=
 =?us-ascii?Q?oUss3tBkHz8GE8Lrbn+BQ3DejmUI6Z2YU78VTeFgvTLJURPh2EUw/mYrSxIX?=
 =?us-ascii?Q?owIals813D1ZX7PVrV+IMhQp9HZ9sEljotj6hfqb4X1oDB5vpOTTdhLk3uXn?=
 =?us-ascii?Q?nhBk6d1k68myl3UH85h4F+smMpTtWh2iogvc/Sompmf8f/CF3/DXYtmF6IaP?=
 =?us-ascii?Q?2nGgkExlbAZBmxw0kkuIrFZeqXlsiBCyZrfPaDf9xH/9CYDEMAUMeWi3ebFh?=
 =?us-ascii?Q?AryJ/+Y1RF0Hrc0UzNHxXozjvo8cmTBN8v4IcI2uQR1pnFcaDqBUwj7VjTop?=
 =?us-ascii?Q?Doad9/xJBrHHH+pGveL6aJq2SSLlegWBgnVZbFglGaq3Ve9KaK0KnVfTb2UO?=
 =?us-ascii?Q?XRkzT3kkFFdk4G86x3hYnIrXWKZ/0D8o1SlA2CsNpoLKQYyeEvKAb+Q79uQe?=
 =?us-ascii?Q?PsgMs0IDFEvfZhqzVuioadpCBq+UtB7k88KEwxJvHjDF2aW/kz8PfOyn7MWR?=
 =?us-ascii?Q?avB/E1eS/kORSrcR/gi2amlBlOJr4C60oh5YB5VhuoYLEZgElTBLIelaywxp?=
 =?us-ascii?Q?UlM7Y1pjHFuZhQPphAtamRWPAdyiQXY++ZnLqrLKNAHVcvAYNttPYQOgZ9v0?=
 =?us-ascii?Q?wh98NqbgxyYRNzwIkeI3ZC4q2sR90FuusUyPGMxfMntYpnOl753nE3Qnn2Mn?=
 =?us-ascii?Q?3+UbriQ+TJL47xQH2FGVCkIPFwA5brjqd8WOHU+6kNsFqwpsD4rXbspJ7fFl?=
 =?us-ascii?Q?mM3Tf5NnOmwK3fYMy10EcDyQpE0bNIxElc/rTI4dy/6ZTmWaAip57LKTfgTA?=
 =?us-ascii?Q?r8zTRKhKKMjPH5nSecujkftbTObz1kVTWFuS99I/TPGos84dnwPeoRPLCelZ?=
 =?us-ascii?Q?SXHYP6N1MN0gAOOGplNQDv9UMBbHM3MfQ+zgWzeElNghyaE7p4nHTIq8f6zZ?=
 =?us-ascii?Q?XRA7uIr7dSYJ+tpKfFE4LqQxmZqDX6mm/g8mCNkQ0EsGfgyuP6nIaxEy1YCd?=
 =?us-ascii?Q?eIqyWt7F3DV/JFB5frFY+I5Q3ohbgkzr3BAZZcA0/2Xr+Nf5otUcLyu1Pk5X?=
 =?us-ascii?Q?mGyVo9M6fT2L8Z22PRaICeahAlUWfEkYmnWiXsPDpFbTJWkF+vLWbGScpke7?=
 =?us-ascii?Q?usBf5LXv8CdA2La31mCg8S9r241NJH6Ejl3WCBiu6hkhgBc28qrOVQV57Lvl?=
 =?us-ascii?Q?biqHfptrBW593ETJT8l1tyxm/7oKMxyKjAC/+kdAHs+/tSP6C3h22WFmapHc?=
 =?us-ascii?Q?I22jy+XicFe04NcEPTnkvtlXSSK5Dse4zPiviARu+r7hVjLpDZR9Z4xrHn2X?=
 =?us-ascii?Q?VllKHQlX4VeAdywDIY5UwsptBUMmSs5Oa00HW03jE3TBkn3hA0MIbJ0joeRx?=
 =?us-ascii?Q?unDgo3ofS7lPs0s52dx5yuyvEUt/z4G/oMuWnHR+R5hynru6oaZJHnIrEeRN?=
 =?us-ascii?Q?HZ5XMXJw9DIlCkOk9Wm63qqXqElKVlrQQwFnwnlDPs/Ir3w8YzwJ/REE7JeI?=
 =?us-ascii?Q?LUlf7qFCwcRE9keX/2Dizvi51kDog5K0BBGhmwHOdIglG0ckkJZxLtkrWQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 17:37:50.6010 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eb976ea-1fb5-4e97-f260-08ddcdfd7990
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB51.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4035
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

Add RDNA4 dGPUs to the dGPU table.

https://www.amd.com/en/products/graphics/desktops/radeon/9000-series/amd-radeon-rx-9070xt.html
https://www.amd.com/en/products/graphics/desktops/radeon/9000-series/amd-radeon-rx-9070.html
https://www.amd.com/en/products/graphics/desktops/radeon/9000-series/amd-radeon-rx-9060xt.html
https://www.amd.com/en/products/graphics/desktops/radeon/9000-series/amd-radeon-rx-9060xt-8gb.html

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 Documentation/gpu/amdgpu/dgpu-asic-info-table.csv | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/gpu/amdgpu/dgpu-asic-info-table.csv b/Documentation/gpu/amdgpu/dgpu-asic-info-table.csv
index 0f822a252fcb3..a3796daec9ec3 100644
--- a/Documentation/gpu/amdgpu/dgpu-asic-info-table.csv
+++ b/Documentation/gpu/amdgpu/dgpu-asic-info-table.csv
@@ -26,3 +26,5 @@ AMD Radeon RX 6500M /6300M /W6500M /W6300M, BEIGE_GOBY, DCN 3.0.3, 10.3.5, VCN 3
 AMD Radeon RX 7900 XT /XTX, , DCN 3.2.0, 11.0.0, VCN 4.0.0, 6.0.0, 13.0.0, 13.0.0
 AMD Radeon RX 7800 XT, , DCN 3.2.0, 11.0.3, VCN 4.0.0, 6.0.3, 13.0.10, 13.0.10
 AMD Radeon RX 7600M (XT) /7700S /7600S, , DCN 3.2.1, 11.0.2, VCN 4.0.4, 6.0.2, 13.0.7, 13.0.7
+AMD Radeon RX 9070 (XT), , DCN 4.0.1, 12.0.1, VCN 5.0.0, 7.0.1, 14.0.3, 14.0.3
+AMD Radeon RX 9060 XT, , DCN 4.0.1, 12.0.0, VCN 5.0.0, 7.0.0, 14.0.2, 14.0.2
-- 
2.50.1

