Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFBDCCA1007
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 19:05:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E01710E824;
	Tue,  2 Sep 2025 19:05:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f5E4TTRn";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61EFF10E824
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 19:05:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sg8EnbyG2mxPssiztYEBmdUB8DuuCqYS6oro4XtrCkzdn2OniYeuF70SYCDriRCNCTlOglHLASDBlJu2tLLZe2h5QOWnEKztVvKVYT+S/9JlsrtG0mgrzbo740G0zwUp+4D1btzpY+4x85PlRQH92fsITQ/d1E1zpvaOO9DyWgK78cE+9axN6m91qzQJLyjs2ckdNHN0J0er5aviTkL5oSajMVY4U5t0Wo8Zfrl68EPqDFBM4gN6PCEiJlqU8dM/UYiyf/fbAAYRjuNISr9m5QqZAe+5DPK1HaRpwf6XmQnTBA7gn4+piHFKhAPjf+/PCSmUKLWtnlYgnsPqZU8AtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OCGP0NuxfVXfadgxT103TkNa7Z9fQ/St1E58e8s22+I=;
 b=Zz4pn+zgte/6Gz6KJA0B/thyXLOylHKPB9igs9zYnTdE/HKkm77xQ39JhtwpPG2a4HOSyAS6RY0nIvCX/zLSPLvXEc8eIX3VT/yE0poP4ZT5jSqQxwhOHNInmk7RIRfsi2Pat4Zv3i2Flncer5tbkt4Z99+EkF1oQ0dSE79nwwuV9wUH18vhf5p3LUqN41UCH9lPeaq2zwnJBG6yRfrAFBjLeO81suxT0uJ1SwrdN7K5SIxg2Mt7XRCivPjZ3wnQarq1ZT1ibLQg0BYYl7FQVmK+8JxL6lWYynEWnF1nqIORk8LkFpXaLKTExBvEavOxSx0HT3HGQhNfH1k/TtN6Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCGP0NuxfVXfadgxT103TkNa7Z9fQ/St1E58e8s22+I=;
 b=f5E4TTRnjjiSAKA/EuSYsoSQVBJ1VZPfgodB6MshUUz2KJf3jfOT67xUwxx980l/OKa9EupfdL8CM69/ntWTke7rAR8eX11hX8VOST8C02ko08nS0esnRjkzz5rF8+GMQbTkvOEHO49xKtb16CZPENX8G52ovD/etq8HsPjJZvU=
Received: from BL1PR13CA0376.namprd13.prod.outlook.com (2603:10b6:208:2c0::21)
 by MN2PR12MB4336.namprd12.prod.outlook.com (2603:10b6:208:1df::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 19:05:18 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:208:2c0:cafe::68) by BL1PR13CA0376.outlook.office365.com
 (2603:10b6:208:2c0::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.14 via Frontend Transport; Tue,
 2 Sep 2025 19:05:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Tue, 2 Sep 2025 19:05:18 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Sep
 2025 14:05:18 -0500
Received: from fdavid-dev.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Tue, 2 Sep
 2025 12:05:18 -0700
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David Francis <David.Francis@amd.com>
Subject: [PATCH v2] drm/amdgpu: Increment drm driver minor version for list
 handles ioctl
Date: Tue, 2 Sep 2025 15:05:03 -0400
Message-ID: <20250902190503.1649105-1-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|MN2PR12MB4336:EE_
X-MS-Office365-Filtering-Correlation-Id: 427bf65b-913d-4255-1ea0-08ddea53a898
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JHf3sEKqGKRlKew0eYL+Hk3jaCzrUPiIhrXz+XacVvZD7Y6VYK+IQaftsLq1?=
 =?us-ascii?Q?97x+EE0fhmNdT1fbHcvAQcqNN5MoQPRcufFaMj/45y3yILleSbHnZUB5DNWA?=
 =?us-ascii?Q?tDwvf+rHNVZo9xe5a9qeNghTdMF66p/f4VDGaOmozI8ZRQSfaAU0nA/D+rmv?=
 =?us-ascii?Q?KE8uPSqX1yYfg1dQzi4eHy3148DM5EeFHFQxp2u81+kMO5iIMqSjwv1VNi5a?=
 =?us-ascii?Q?QdDb6XB2/Ab4BDdtzDoqYT/TONZQBo4ZHRqtHT4x3isafa8hCKxyZffW862g?=
 =?us-ascii?Q?4XnDvUw+fV+suljf44YHvqjj/ZP2noqmpEAKkr4g6JFAkTqUK8xDPfR7aeua?=
 =?us-ascii?Q?KLxt8AVBPDaRzOvz9XGcFWNYtqG26F8Fw3pl1/Bbuq6tsyhrrqb3csHiIfpj?=
 =?us-ascii?Q?4rhIOm6V/0r5n6PsVHEQVpwmnbCewc069FlqIKlRQg6VzFkD9MbXbzX/dyXy?=
 =?us-ascii?Q?BZPNBkkqhYSTBQy57osqtT2ZIlZ8xzJMCSU6+six/esGBNGBYnsGmB4hsM+V?=
 =?us-ascii?Q?AJ8GKBtbhpimBjkze6MPL41y3Czm+bKUm9rCsVoVWLKF1DjuA049JoG+L+kG?=
 =?us-ascii?Q?QyNgEWUSD/zdKH1Zq6CPrAVctb6H/U3VWYrTZChYlM/O5BO1l5zRFypiQKnM?=
 =?us-ascii?Q?Z/VwyujDkSOmVHXl1mazoBoY0m4+uxHYwBWz1qU5SEuTqsrJl5Cd4oKi/Q0b?=
 =?us-ascii?Q?owfFgWOSqfbNd3+Ug7CyKqKKvgc+WltqIvyKGzbHXqcyHgSG9u+VHgd//kDJ?=
 =?us-ascii?Q?pN2q+2sbTPlmB7mck+q3vqZpUkpmjoprKdqo9oekvUl7OQxyec7WaF3d0baS?=
 =?us-ascii?Q?8QKvocNpiUdYvCF5IZsi+IkYpwu9CYu4NUWz4LDmoN4MDdB9CA8nDVr0OhC/?=
 =?us-ascii?Q?16l8liHtw6V1i6SvzLY8id5pMvzimOZYVynxMhohjHcwgMvM+OsCZdC5skED?=
 =?us-ascii?Q?C6JkTWKBTzcRubeYNJU+mq5rV1/imDpfQ/9nnJXj+rozCD0Ta6UB6k4NhccZ?=
 =?us-ascii?Q?R3aSMG05I2wPrn0mQSSWzQk9NV1C4is/DhS+qPGIcL6hOECSHU3cC8CJQ+wZ?=
 =?us-ascii?Q?FUNooS32MtV0eovWL8Em1ged7XMlnA5DFaQ7dO14QuJkRTUPzL2O0e5NDRub?=
 =?us-ascii?Q?7EpUHSN+Pqk4khtURQGA6DJ5D9cIfOJdNJ9kNg3Cf3K9G8iuyxDv7Pss4CZt?=
 =?us-ascii?Q?zmRcAgcf3kplNGnNiZH3Cizu40nKuEZIy4cLSmrKND789WTpYYfouOhblsSc?=
 =?us-ascii?Q?PZZPDqVeNOMuVlPCsUmXv8YF2odi0K+ErXc7G6ENnfvW+3E7amQUXI9kGmLx?=
 =?us-ascii?Q?sG0rJnAfubIa8fGdZlRLjbwY0jZZwpIv654B7mH9p6IGGV5ZQFrJLc/Na+T1?=
 =?us-ascii?Q?NA2ll9OzL/8vIoObGMjQpezXDR21aKxTjBHVyoWfH/eVuPqidebkorZleK37?=
 =?us-ascii?Q?FJZl4Sof8QAF9oQAltAOlRsGn2gNXscJ/CSeg8LPr1gEcNdIKgfdW1lysDg3?=
 =?us-ascii?Q?m4vd50uBI/oyTz5K/HaBU8BwOmvtjdEH1jRA?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 19:05:18.7771 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 427bf65b-913d-4255-1ea0-08ddea53a898
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4336
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

With the addition of the drm ioctl
DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES,
the drm driver version should be incremented (to 65)

Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index b42a2a32b0b7..fba38e9ef92e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -126,9 +126,10 @@
  * - 3.62.0 - Add AMDGPU_IDS_FLAGS_MODE_PF, AMDGPU_IDS_FLAGS_MODE_VF & AMDGPU_IDS_FLAGS_MODE_PT
  * - 3.63.0 - GFX12 display DCC supports 256B max compressed block size
  * - 3.64.0 - Userq IP support query
+ * - 3.65.0 - Add GEM_LIST_HANDLES ioctl and mapping info option on GEM_OP ioctl
  */
 #define KMS_DRIVER_MAJOR	3
-#define KMS_DRIVER_MINOR	64
+#define KMS_DRIVER_MINOR	65
 #define KMS_DRIVER_PATCHLEVEL	0
 
 /*
-- 
2.34.1

