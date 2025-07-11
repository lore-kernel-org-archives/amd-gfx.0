Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA30AC83F25
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 22:40:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5875C10EAEB;
	Fri, 11 Jul 2025 22:40:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="avIA/uqp";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B515C10EAEB
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 22:40:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JFTUheIkWjmSO2b8Yd6iGAlc6c6SBkFQcgWRhOL0L+pTNdWNu3FNNsLKQgGQkgjwzsg7Gg+Jou8Wpv2WZZGb6ZM1a0sZAGL7zleCklowQMZnp0ZyQNXCD32Kky3OtzdK4LtujUSUbnKgLg85s/blKvAwkVMC+IjyIoKzqoFaeKdpmwIXB4IhpU3MMTFR1p0bUw10TCCl4XipJ4E+Mf3eGtcsnz4Xx1rjLEp6ya7uvDDvWBXwLdhsPYbrZ+3Ob1dv4CesWAwdeZTRUEL69i7Jt6a4MK95jNNryTj8pT/v0g6Gy2VCy0j3HTeKJXmdvikEOoq7ZhQ6GgRXqFAvUhMoMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o8eFJ/jVkRvKx6Ll7gObfAg3bVRNc/PMypaMrIvAxPI=;
 b=CHwChzj+juhqh45jTWDJ+ztBMEvGBfc6HdkGBMyo+8O5ewbUG4jq69JSMMdkH3tByoqmIAfQyenK6Ff6QvVnHfLjKhY9ArccgkmMu4/neAA8ziNelVlKzP9WpSe+/kljOFjEWa7BJDBPj2QtpJ8/XSduR/kS7UeI8ppSXW2b4JfkkgM5gMaZ4IJszJCsNxSYD43L2kuu6ab4DfxcfnVVLn/DuCO8cMia7Ma7FCJ63J883bYsmheGYoPFOTETI0nuQmYCWdwMzsDCWElpteD2xBgzrl0CSRg4pgrKOq3IEacUlQz+PKGgne/89yAgLWCDQsJ4q6zeCHTiDsn+po/+MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8eFJ/jVkRvKx6Ll7gObfAg3bVRNc/PMypaMrIvAxPI=;
 b=avIA/uqpB4s1mF5k6X2kVo1PEi+e+7RXlCobXI89da1OCo/oj/s/f0JX9wj+ZnoLTtviqZ2IgTMtOFf1VQXg7IFZubMeGOW3tvcKxioJ7xWpEjrOQmE7JIUJ8qVFx9aINNvPhsVe9dzQhnyl3skukmV7xKs5hLzwoSSJ3Pdyyro=
Received: from SJ0PR03CA0213.namprd03.prod.outlook.com (2603:10b6:a03:39f::8)
 by SJ0PR12MB5663.namprd12.prod.outlook.com (2603:10b6:a03:42a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Fri, 11 Jul
 2025 22:40:53 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::41) by SJ0PR03CA0213.outlook.office365.com
 (2603:10b6:a03:39f::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.23 via Frontend Transport; Fri,
 11 Jul 2025 22:40:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 22:40:53 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Jul
 2025 17:40:51 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 22/33] drm/amdgpu/jpeg4.0.3: re-emit unprocessed state on ring
 reset
Date: Fri, 11 Jul 2025 18:40:13 -0400
Message-ID: <20250711224024.410506-23-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250711224024.410506-1-alexander.deucher@amd.com>
References: <20250711224024.410506-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|SJ0PR12MB5663:EE_
X-MS-Office365-Filtering-Correlation-Id: 959efc4f-25af-43a9-f579-08ddc0cbfe22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kXcYCakgAiN9JDHlALs3si8i2LJzrzFMJkJ/0TuVYO1Oq1DGrtGjwGxlFwaW?=
 =?us-ascii?Q?W5aDL29i5hBk+jhL9jOFCLHvoMCcGTP9KnbDLyCjxY+NOfqYx0M5dXaqQJMR?=
 =?us-ascii?Q?Eb67Ir9o9zJHBZCy2MZvX6CDybPz6amZlo2XwBp1Nw9o4cBm93Lk7ytNHohu?=
 =?us-ascii?Q?27esIvTsA115/muf5j9kNW/R0/QpobYUCey6u0FR2woJwECF9hqfO4v8NjP1?=
 =?us-ascii?Q?so5qQ6mpCAR1fx4bwsSHJVkVHNu3ppdXwPb9IuKJZP5E5PvmL/cmFL+tK3c7?=
 =?us-ascii?Q?5MnrCmarxaR2jtZg2MsNpoMMwvaH1Mo+1cUTiPlDMqD7TmQgechH3O25WiUo?=
 =?us-ascii?Q?vEQuqExav50nuTpN93uGlZX1Sb/JvgJZFYYlqMRoT6WVLff9owV/Y91i4gzS?=
 =?us-ascii?Q?F1GopDH/lmZRWiTOAseHvx341ub7lP3YlnD1FYu/4kdQoxtPUOmsboe6Yv3+?=
 =?us-ascii?Q?oxGWUPj93vNglJn/VuNQjRqORy55TybFtj3DvCCpOuJ2G0hpZfZtw4LxwHW/?=
 =?us-ascii?Q?raPPwhWNQb2wASQ9ZhQGosPX3AS5V5Wmbdw55nc6y8wYiHoKG62j5uhaCkG3?=
 =?us-ascii?Q?nPeUEPgE2Fd9Vnlz5ppojSXpfj009YC5yXy4aiISiMIz9dQHqyE2eekygoGi?=
 =?us-ascii?Q?mD/6435S4/CU8ieIjxdW3OkEnKqk8TrqqT2I7J2W86mYqKtbmIuZ/trVa5ed?=
 =?us-ascii?Q?dQDV5/LO1TiNz1B79hEPFTDOOpuIENlBgczsmnGuz64xC0DF5/N+TDbsA2No?=
 =?us-ascii?Q?7ZocZ24FQHjRcRkhc/XUKrygG/3ni8oKGDhnjQ95cqFznW1MaK8ZuUpERw6E?=
 =?us-ascii?Q?rRFv6Uq1nkx+gS8ra5X+Gp+WSF07CAw75y6yikkP7PDgna5WJWRlpAG09e4R?=
 =?us-ascii?Q?mOOAYKI9tgWoaJe1gmkQeocoZXu2YBHx6Go3McGnjFHFPtNH8APRaDrp3YbU?=
 =?us-ascii?Q?N788DuUm9pMq1ivMtSrmRb9jKXD435Sb0CDdmX14Ax5Ztlw1p141xttwp7vY?=
 =?us-ascii?Q?1N6KKaCKtPufxTJD83HVHwjowA8MJ9+nWscXqtj0euV4zGqesx+8ZBgrDxBu?=
 =?us-ascii?Q?viY/QL3p1ApLSxfZ6K6TSdr/xa1h3jkCxLkL2KWeMLr8RXYw2qmhlEGXR7Yn?=
 =?us-ascii?Q?8mq60beTGZcA+0OQyatlCwPLRJfH9hoDWXJofivabgzSQMoGeHQB1z5/nBOC?=
 =?us-ascii?Q?PYQIqZj7dihhhq2aqqlcDGci+/T/zqDCitKczx1aUEu2zr+aDThRfV8v6sKh?=
 =?us-ascii?Q?z+BjLndZX4bB7nAY2za30yx5/zQANvtbDg7xBQJNmPmXp5OHvaLI+cEuYx7R?=
 =?us-ascii?Q?evzdTF7thD+Nwlii12KSxO26n0A63YNz7SKDgsBN4t3rzqctrFePJOyAiQ6q?=
 =?us-ascii?Q?S11STkZeC22WFSpJSKJPxFENGX/fS8nnoSeNRHuY38hQxcUfF4kOaNyKhmVj?=
 =?us-ascii?Q?/3T+jgZhM+eu2MxdWJUw56rMlYHM9qKc5OyhawNAPUOuBMMxyZ/BvBKNPW8G?=
 =?us-ascii?Q?YWoLpwUwzLGVT/1CsJGaerC4hwyMvvw62yRH?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 22:40:53.0200 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 959efc4f-25af-43a9-f579-08ddc0cbfe22
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5663
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

Re-emit the unprocessed state after resetting the queue.

Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index 78441f8fce972..c3f73a2a911b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -1147,20 +1147,13 @@ static int jpeg_v4_0_3_ring_reset(struct amdgpu_ring *ring,
 				  unsigned int vmid,
 				  struct amdgpu_fence *timedout_fence)
 {
-	int r;
-
 	if (amdgpu_sriov_vf(ring->adev))
 		return -EOPNOTSUPP;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 	jpeg_v4_0_3_core_stall_reset(ring);
 	jpeg_v4_0_3_start_jrbc(ring);
-	r = amdgpu_ring_test_helper(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static const struct amd_ip_funcs jpeg_v4_0_3_ip_funcs = {
-- 
2.50.0

