Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 476F7D37496
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Dec 2025 19:57:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF55B10E0B7;
	Fri,  5 Dec 2025 19:57:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QGZR462K";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013046.outbound.protection.outlook.com
 [40.93.201.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAD9410E0B7
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Dec 2025 19:57:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ms4jxfB3xYfRtKrN6HWYHr9iPHwTf1U/jG43F4REYhRwYDo9kYCB3eQno8ChIpxvOcWWiOPsxaRcsTWF2AHplQeu20PyAOl4meXzpYOkgavU0I06X2bp0y9nemWyrveCfofPSr2t+54tnj57hmFr1O7zeFD0QTqnyYUn9MaQHTRaaPE1POL3k09n+bNNjedvEa7BuY1dBqZ6W823QJ4QfvRaz8Gn9w3C+j31685qC7z/JmFIOJavWueDj7nvnr6OOGE9KnRkYvnIz1JRQFhvP4YpHcqsJcRhTT+19FR45gO2HMKlKDrtbJIDwdhrdWYrLxdtAzoi7z9EEGJ91CdNDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dq9iHSBOqdjJ7TQajPQekEPMxCk7J3enk0WOqxORkWA=;
 b=Y7JfrcSaeGb2AFYtBPxgngHvgJXMtJmbrTza5x8ky4Pef88pPSGxWtRDdCfphK1lXGZYIUtbNG1yeV+EIOJsk75ebUUPSeKqEdHGz0lXgytLHZbbT0J/+XqpaL6ToZB4XaHGb+JdgEuSGfcC5xrwekcyV0KPCp9LD/mDBJGzQYV6wv/tggDgw+09a2VbiUJyq1Z34DOwBkdIFS1esNfc0syN/kJvDhzpsTNCJObp5r5wwlw+oHKVEIZ2JCusdcIIWU51muE6Neq1zVFbG04hQe6KvJziGgV2g/Usx7B6LMbolPKNkMtqbNF9nm+aPcbj4k10Y2wXSJ8Yp2YULx/hRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dq9iHSBOqdjJ7TQajPQekEPMxCk7J3enk0WOqxORkWA=;
 b=QGZR462K77SYjmCN/UegjhvLWgncpliSAmyl6/GO3lKa+Iak4SpeVfBJpVIQz1d1XUR6v+hYVzOH3rCh0HkKeYCoKNMyv6f+cdt1EXFFDAARchJ/h5xV5BrdGN1EgY4RNiSOpL1aZ3jePIEIenEDBkd5iiR0biIK1xDs8n7vP/E=
Received: from BL1PR13CA0265.namprd13.prod.outlook.com (2603:10b6:208:2ba::30)
 by SJ2PR12MB8690.namprd12.prod.outlook.com (2603:10b6:a03:540::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.12; Fri, 5 Dec
 2025 19:57:42 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:208:2ba:cafe::f4) by BL1PR13CA0265.outlook.office365.com
 (2603:10b6:208:2ba::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.1 via Frontend Transport; Fri, 5
 Dec 2025 19:57:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Fri, 5 Dec 2025 19:57:41 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 5 Dec
 2025 13:57:41 -0600
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Mario.Limonciello@amd.com>, <Kent.Russell@amd.com>, Jonathan Kim
 <jonathan.kim@amd.com>
Subject: [PATCH] drm/amdkfd: bump minimum vgpr size for gfx1151
Date: Fri, 5 Dec 2025 14:57:30 -0500
Message-ID: <20251205195730.1266877-1-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|SJ2PR12MB8690:EE_
X-MS-Office365-Filtering-Correlation-Id: 07fe9c70-45e1-44df-baa8-08de34388cc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?a/rx5w/h26axstJFKABPhCauQtS6W0H310Vxl0mXBQaGcgiJceJdNYmXXMkm?=
 =?us-ascii?Q?90/Ilrzjv8D13NSC0xcwuoVLk81LARGzlUJi3N6B9ehG3NeBxY0Mf1ig2nUo?=
 =?us-ascii?Q?VcfZiBvEVScwy8Sjnc2yNqkv6lxh1EUbVc7z04wz93ypSq1Smiu/QVR3bq4O?=
 =?us-ascii?Q?v/q35FUzYe1l5OBTtwFoA0/pekVGIXDDqPFgMJobuTEyD/b5Luwaht7GrEWr?=
 =?us-ascii?Q?xdONRyUDYSsC2bCrvVZlWVDXtQPX9CsRKAjBuhOGrU48mhGO/twxjSqR8jlt?=
 =?us-ascii?Q?+X/CErpdFZ5+4j8U64dgENxGUwV1PdNjMgl9P7ZDBrttoh/ojLYECFrBrpBv?=
 =?us-ascii?Q?0V7fCY0/1jN95iMhno1ldkzqyOwOiOPRNjm24eJbWorg/w7BxFPgKcvO+5LB?=
 =?us-ascii?Q?Ae9iK0rDWdV0f3sGrmGu5KqwDpuCNlbtvdtBTbW7yzMerKthFypvCHZZhyI7?=
 =?us-ascii?Q?4NUcsZAtAp5cppEYItjDJfHllhb0wV8qd/ajq2LqJ3PXk7K6z1YbBXgqR+eP?=
 =?us-ascii?Q?nsqvXAYWbiNk/8hMrkltLUiCjKeXAnfpoqXyEr1Wop95qDdYYHTP+9XAMH0H?=
 =?us-ascii?Q?BItdQhrg6BvBh2dHBcYwuDMr16snpOf7gUuH9W2yQOKYH5gCtLu+oHeM1UpQ?=
 =?us-ascii?Q?/6Bn8dO0czy5xQdmp/Hl4ylNZcpeWQqojhofltR6KYeFY36B6IOl2ZsZCxPJ?=
 =?us-ascii?Q?GskBdcp9C61qD0dr+Sf+B1MvfxB+JstONXdURBnQkiJF5DBpOEjV5SWL5jcy?=
 =?us-ascii?Q?snSGpX6RZld16x2uzBNBTe8gxS+1jgkfxX7Ni/D+MXfebQBseoJRWigi967a?=
 =?us-ascii?Q?cOFBAPcQq4EiyXrFkq94eSGZQfYN8LRJO5740gkcq7L1hJJ8n4djVwkRgKPx?=
 =?us-ascii?Q?sRUjsI5OrDbpBzukMtUZyZIocRMSZyeKmvUQyfvZQdirZDORtJTpOwCUIPDU?=
 =?us-ascii?Q?u12Z4nIlJ2CIdEjU2n2ey0y0TTRYcAWuvrc6vb3tn37A7rxUdx4AOaNXSGCq?=
 =?us-ascii?Q?OQHfOSERkgc9tMu3JwKyFsUHXOboQ3Gugymh2zkm+A2Eb3gUZFtKy16yOSnO?=
 =?us-ascii?Q?Hkd6pUbG0Dy2AyoJNhywLjC1LyGjGBTy79QespCk7AuAtdct4cRpgwJKPFYc?=
 =?us-ascii?Q?MVDjoUK+RT/B/VhY6CcNOSmIxKraR1bVsJqQELxMZrVycMaF4cENKOZCQfiG?=
 =?us-ascii?Q?ppyI6w4J+8WktL7f+L6ti3EyJhi2xBZ/0j75j0N+d8ZSAg2m84dbzSa+YT/B?=
 =?us-ascii?Q?FBAbl9fdbs+VUlYdV+KkbZJjNQbi/Sm4pEDEglr0LJo7lOAp6YUibWjvkQpq?=
 =?us-ascii?Q?acdzOF35lM6G8JTs77kQhJVtHNbKqoneYnTlt0z3YdHTd1pa2qJIGUy5FqCu?=
 =?us-ascii?Q?eoDzO4ZFfW6O3IEORbyuzx6Uxhrm2qAeDtZHg0WK+BkdQdLsIAuS5ULmIybW?=
 =?us-ascii?Q?JqkA2recenjnizAdpnB11Y+YMtFLox2lyYKFuFoYHidZgRU5d6wHahiaqMOX?=
 =?us-ascii?Q?b10zKUK9oWKZMdRVHWptuOpXUOWE6U6YVMRFUUvuqOFlItboTlY2kBzRRnW9?=
 =?us-ascii?Q?AniLKfTf5Uv8iaupfNI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 19:57:41.7212 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07fe9c70-45e1-44df-baa8-08de34388cc3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8690
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

GFX1151 has 1.5x the number of available physical VGPRs per SIMD.
Bump total memory availability for acquire checks on queue creation.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
index f1e7583650c4..80c4fa2b0975 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
@@ -409,6 +409,7 @@ static u32 kfd_get_vgpr_size_per_cu(u32 gfxv)
 		vgpr_size = 0x80000;
 	else if (gfxv == 110000 ||		/* GFX_VERSION_PLUM_BONITO */
 		 gfxv == 110001 ||		/* GFX_VERSION_WHEAT_NAS */
+		 gfxv == 110501 ||		/* GFX_VERSION_GFX1151 */
 		 gfxv == 120000 ||		/* GFX_VERSION_GFX1200 */
 		 gfxv == 120001)		/* GFX_VERSION_GFX1201 */
 		vgpr_size = 0x60000;
-- 
2.34.1

