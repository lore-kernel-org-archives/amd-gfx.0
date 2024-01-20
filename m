Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B58CCC4725D
	for <amd-gfx@archiver.kernel.org>; Sat, 20 Jan 2024 02:21:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56BA010EACC;
	Sat, 20 Jan 2024 02:21:50 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E024710EACC
 for <amd-gfx@lists.freedesktop.org>; Sat, 20 Jan 2024 02:21:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e+PzAiEJzJSGiZLT8++r6IJeGtVARpWBNGO4LSH+gh2u9s8v2U8+li9a11jtpurp4A5x9O2kUJNdTwkT/OIevRYjocoD0Z6UISz5/mW4Z8neijiIvB8J9zr1rLyvQ0K1P4gAEM7Z5ApCcUMDfcJX9bxUBedei/URzw/W9lw2gLin05FdasrMtdK3vfqMDSPELtMG5H4W4PmI5aQyfweCNF6JGqW1aprLHgF8JpbzwnVS4ONOFaMzY+jjIDnsy/mWcbfiDG2C9398Zu2jQEaHhzsIeumG7MxUJue2jbAQ/0aAKALhRxNCZX3BF29jp+OGGfvmzSJe1MQdBHR71OJstw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EBV22CrBOoi6IyqYCPgOVthGgvjDQIbZH9NPMJLSugY=;
 b=OtHdeQNvD/b5MyZAwEmTVEOYYUi9sRBSKZjANg30DsnMTOLj4iP9SVlvg93yjuyuGRl0X7wN5hOsvd8OxcQmwx/2/wxlIK86cFCjOqN8d4a+O8apbJUlVWOtyODHb3SXjoyqb3cEUhURX88z8u1kC5mZokkAWbopO06CuElwE7E3iVoooVu+AO2PmAdFtRAD8lRlHPYdYSyPD9hBVsAl6awV5oBfnE3cAqrpgHQ5HjPB3yt2LK+ZnApzbaXKAyI2ErQh215IcefC/UqaMJpYPvL+3CXhRgGZtC8me8gAVzIspCRm9QdcTuqkW+ruCOv+CDVnQpXhBXXVQ4IirynZcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EBV22CrBOoi6IyqYCPgOVthGgvjDQIbZH9NPMJLSugY=;
 b=053oETJ8NoGF7y8dkgzzxz7ptA5K8Y76v/7GLqNjDSdYOFT9nb9FPwY4RsjY1GnaZxlsvh5J48i+v+r/BvYI2ea0O7lbbcmNjnF6qM+PTOewWeoo69EZo4cRx624mwqUoiq0aX+iTGl1R3k5L66zBO2pYZXSwpd+LRsTE7IgNPY=
Received: from BYAPR01CA0009.prod.exchangelabs.com (2603:10b6:a02:80::22) by
 MW5PR12MB5683.namprd12.prod.outlook.com (2603:10b6:303:1a0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Sat, 20 Jan
 2024 02:21:29 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:a02:80:cafe::36) by BYAPR01CA0009.outlook.office365.com
 (2603:10b6:a02:80::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.26 via Frontend
 Transport; Sat, 20 Jan 2024 02:21:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Sat, 20 Jan 2024 02:21:28 +0000
Received: from rocm-perf01.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 19 Jan
 2024 20:21:28 -0600
From: Joseph Greathouse <Joseph.Greathouse@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Add cache line sizes to KFD topology
Date: Fri, 19 Jan 2024 20:21:18 -0600
Message-ID: <20240120022118.2648843-1-Joseph.Greathouse@amd.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|MW5PR12MB5683:EE_
X-MS-Office365-Filtering-Correlation-Id: 433cbc96-0043-4f20-817d-08dc195e82b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LrW3ra5wU9CBcnjdeJhaSY8nbZQyKZs7ed3gbd+JzAP4pQpiCCjwsw+9akaWc+Mg9VBaKc5F1SvS7QD/3P16ooryG5AxQI48S2zFSlr99ScGdqXsqbJFk3cnvFscVMoIZ6VdOOJwtBc05T+wkl2XWZj0M2rTerHYo38k9IAFgzmr3q9osJi8D7veuQtSUXaB5dhsZwFSCGrqyHfLiB58ull+iHy1TkMu/2EUyqO2/yDmeCpZjgwqfdqLhY6AVwwx1cNl2YaZYwn4QzyqNL9f/rKVHFq+41W9JrOtnLDQkZOx0Y/rOJ1cDC1mgdEz1ZBop4ejGhw9DM6VEfWDhfkJdt+iUpNxaQeWit5S7CKu+zvGex8X+lG9pb1p3WThm+ieKE8fBq18XuAb2hM3W9dLIjmW8RgDaiSg3/l8Ai92VklKb8H1dSjnTptBKSrt0YXazwBiGcbXJT+t2yoy3KUcbACiB5fy2WEPepAYrJ9lSVb5K4LhxmYEYYgWi9tch7PyiVVK43iB2mGVIIz3Bz2JNT25URm6mFA5h1/6aeSWjuXbRO0GGSnMDaZLXuf4H0IjYgrOaGOGuGJ6J6PMq8K2ClABwScY/tjiTRq9mtpkpQCc4BJQJqqRwFnpZGKDyuscIM6qK7g7+XaW7VgdR749pCde4x9SxZ7Fxvvwu6EneXAT8OOVsNqRsw/UhdNhWqvpxytJMKDGOKS85QbvGKTEIUdqRapesoLEETxc/Fi+EkjK7LHJquH4Jp/BXaVrojwA+c1z9VJkk2fXy4tNwCAkTQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(39860400002)(346002)(136003)(230922051799003)(451199024)(1800799012)(186009)(82310400011)(64100799003)(40470700004)(36840700001)(46966006)(36860700001)(316002)(5660300002)(2906002)(8936002)(8676002)(86362001)(40480700001)(40460700003)(4326008)(7696005)(36756003)(6916009)(41300700001)(47076005)(70586007)(70206006)(82740400003)(356005)(81166007)(30864003)(426003)(336012)(16526019)(2616005)(26005)(1076003)(83380400001)(6666004)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2024 02:21:28.9434 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 433cbc96-0043-4f20-817d-08dc195e82b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5683
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
Cc: Joseph Greathouse <Joseph.Greathouse@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The KFD topology includes cache line size, but we have not been
filling that information out unless we are parsing a CRAT table.
Fill in this information for the devices where we have cache
information structs, and pipe this information to the topology
sysfs files.

Signed-off-by: Joseph Greathouse <Joseph.Greathouse@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c     | 93 ++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_crat.h     |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c |  2 +
 3 files changed, 94 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index cd8e459201f1..002b08fa632f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -55,6 +55,7 @@ static struct kfd_gpu_cache_info kaveri_cache_info[] = {
 		/* TCP L1 Cache per CU */
 		.cache_size = 16,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -64,6 +65,7 @@ static struct kfd_gpu_cache_info kaveri_cache_info[] = {
 		/* Scalar L1 Instruction Cache (in SQC module) per bank */
 		.cache_size = 16,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_INST_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -73,6 +75,7 @@ static struct kfd_gpu_cache_info kaveri_cache_info[] = {
 		/* Scalar L1 Data Cache (in SQC module) per bank */
 		.cache_size = 8,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -88,6 +91,7 @@ static struct kfd_gpu_cache_info carrizo_cache_info[] = {
 		/* TCP L1 Cache per CU */
 		.cache_size = 16,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -95,8 +99,9 @@ static struct kfd_gpu_cache_info carrizo_cache_info[] = {
 	},
 	{
 		/* Scalar L1 Instruction Cache (in SQC module) per bank */
-		.cache_size = 8,
+		.cache_size = 32,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_INST_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -104,8 +109,9 @@ static struct kfd_gpu_cache_info carrizo_cache_info[] = {
 	},
 	{
 		/* Scalar L1 Data Cache (in SQC module) per bank. */
-		.cache_size = 4,
+		.cache_size = 16,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -135,6 +141,7 @@ static struct kfd_gpu_cache_info vega10_cache_info[] = {
 		/* TCP L1 Cache per CU */
 		.cache_size = 16,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -144,6 +151,7 @@ static struct kfd_gpu_cache_info vega10_cache_info[] = {
 		/* Scalar L1 Instruction Cache per SQC */
 		.cache_size = 32,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_INST_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -153,6 +161,7 @@ static struct kfd_gpu_cache_info vega10_cache_info[] = {
 		/* Scalar L1 Data Cache per SQC */
 		.cache_size = 16,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -162,6 +171,7 @@ static struct kfd_gpu_cache_info vega10_cache_info[] = {
 		/* L2 Data Cache per GPU (Total Tex Cache) */
 		.cache_size = 4096,
 		.cache_level = 2,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -174,6 +184,7 @@ static struct kfd_gpu_cache_info raven_cache_info[] = {
 		/* TCP L1 Cache per CU */
 		.cache_size = 16,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -183,6 +194,7 @@ static struct kfd_gpu_cache_info raven_cache_info[] = {
 		/* Scalar L1 Instruction Cache per SQC */
 		.cache_size = 32,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_INST_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -192,6 +204,7 @@ static struct kfd_gpu_cache_info raven_cache_info[] = {
 		/* Scalar L1 Data Cache per SQC */
 		.cache_size = 16,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -201,6 +214,7 @@ static struct kfd_gpu_cache_info raven_cache_info[] = {
 		/* L2 Data Cache per GPU (Total Tex Cache) */
 		.cache_size = 1024,
 		.cache_level = 2,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -213,6 +227,7 @@ static struct kfd_gpu_cache_info renoir_cache_info[] = {
 		/* TCP L1 Cache per CU */
 		.cache_size = 16,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -222,6 +237,7 @@ static struct kfd_gpu_cache_info renoir_cache_info[] = {
 		/* Scalar L1 Instruction Cache per SQC */
 		.cache_size = 32,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_INST_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -231,6 +247,7 @@ static struct kfd_gpu_cache_info renoir_cache_info[] = {
 		/* Scalar L1 Data Cache per SQC */
 		.cache_size = 16,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -240,6 +257,7 @@ static struct kfd_gpu_cache_info renoir_cache_info[] = {
 		/* L2 Data Cache per GPU (Total Tex Cache) */
 		.cache_size = 1024,
 		.cache_level = 2,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -252,6 +270,7 @@ static struct kfd_gpu_cache_info vega12_cache_info[] = {
 		/* TCP L1 Cache per CU */
 		.cache_size = 16,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -261,6 +280,7 @@ static struct kfd_gpu_cache_info vega12_cache_info[] = {
 		/* Scalar L1 Instruction Cache per SQC */
 		.cache_size = 32,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_INST_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -270,6 +290,7 @@ static struct kfd_gpu_cache_info vega12_cache_info[] = {
 		/* Scalar L1 Data Cache per SQC */
 		.cache_size = 16,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -279,6 +300,7 @@ static struct kfd_gpu_cache_info vega12_cache_info[] = {
 		/* L2 Data Cache per GPU (Total Tex Cache) */
 		.cache_size = 2048,
 		.cache_level = 2,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -291,6 +313,7 @@ static struct kfd_gpu_cache_info vega20_cache_info[] = {
 		/* TCP L1 Cache per CU */
 		.cache_size = 16,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -300,6 +323,7 @@ static struct kfd_gpu_cache_info vega20_cache_info[] = {
 		/* Scalar L1 Instruction Cache per SQC */
 		.cache_size = 32,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_INST_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -309,6 +333,7 @@ static struct kfd_gpu_cache_info vega20_cache_info[] = {
 		/* Scalar L1 Data Cache per SQC */
 		.cache_size = 16,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -318,6 +343,7 @@ static struct kfd_gpu_cache_info vega20_cache_info[] = {
 		/* L2 Data Cache per GPU (Total Tex Cache) */
 		.cache_size = 8192,
 		.cache_level = 2,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -330,6 +356,7 @@ static struct kfd_gpu_cache_info aldebaran_cache_info[] = {
 		/* TCP L1 Cache per CU */
 		.cache_size = 16,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -339,6 +366,7 @@ static struct kfd_gpu_cache_info aldebaran_cache_info[] = {
 		/* Scalar L1 Instruction Cache per SQC */
 		.cache_size = 32,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_INST_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -348,6 +376,7 @@ static struct kfd_gpu_cache_info aldebaran_cache_info[] = {
 		/* Scalar L1 Data Cache per SQC */
 		.cache_size = 16,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -357,6 +386,7 @@ static struct kfd_gpu_cache_info aldebaran_cache_info[] = {
 		/* L2 Data Cache per GPU (Total Tex Cache) */
 		.cache_size = 8192,
 		.cache_level = 2,
+		.cache_line_size = 128,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -369,6 +399,7 @@ static struct kfd_gpu_cache_info navi10_cache_info[] = {
 		/* TCP L1 Cache per CU */
 		.cache_size = 16,
 		.cache_level = 1,
+		.cache_line_size = 128,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -378,6 +409,7 @@ static struct kfd_gpu_cache_info navi10_cache_info[] = {
 		/* Scalar L1 Instruction Cache per SQC */
 		.cache_size = 32,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_INST_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -387,6 +419,7 @@ static struct kfd_gpu_cache_info navi10_cache_info[] = {
 		/* Scalar L1 Data Cache per SQC */
 		.cache_size = 16,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -396,6 +429,7 @@ static struct kfd_gpu_cache_info navi10_cache_info[] = {
 		/* GL1 Data Cache per SA */
 		.cache_size = 128,
 		.cache_level = 1,
+		.cache_line_size = 128,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -405,6 +439,7 @@ static struct kfd_gpu_cache_info navi10_cache_info[] = {
 		/* L2 Data Cache per GPU (Total Tex Cache) */
 		.cache_size = 4096,
 		.cache_level = 2,
+		.cache_line_size = 128,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -417,6 +452,7 @@ static struct kfd_gpu_cache_info vangogh_cache_info[] = {
 		/* TCP L1 Cache per CU */
 		.cache_size = 16,
 		.cache_level = 1,
+		.cache_line_size = 128,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -426,6 +462,7 @@ static struct kfd_gpu_cache_info vangogh_cache_info[] = {
 		/* Scalar L1 Instruction Cache per SQC */
 		.cache_size = 32,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_INST_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -435,6 +472,7 @@ static struct kfd_gpu_cache_info vangogh_cache_info[] = {
 		/* Scalar L1 Data Cache per SQC */
 		.cache_size = 16,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -444,6 +482,7 @@ static struct kfd_gpu_cache_info vangogh_cache_info[] = {
 		/* GL1 Data Cache per SA */
 		.cache_size = 128,
 		.cache_level = 1,
+		.cache_line_size = 128,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -453,6 +492,7 @@ static struct kfd_gpu_cache_info vangogh_cache_info[] = {
 		/* L2 Data Cache per GPU (Total Tex Cache) */
 		.cache_size = 1024,
 		.cache_level = 2,
+		.cache_line_size = 128,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -465,6 +505,7 @@ static struct kfd_gpu_cache_info navi14_cache_info[] = {
 		/* TCP L1 Cache per CU */
 		.cache_size = 16,
 		.cache_level = 1,
+		.cache_line_size = 128,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -474,6 +515,7 @@ static struct kfd_gpu_cache_info navi14_cache_info[] = {
 		/* Scalar L1 Instruction Cache per SQC */
 		.cache_size = 32,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_INST_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -483,6 +525,7 @@ static struct kfd_gpu_cache_info navi14_cache_info[] = {
 		/* Scalar L1 Data Cache per SQC */
 		.cache_size = 16,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -492,6 +535,7 @@ static struct kfd_gpu_cache_info navi14_cache_info[] = {
 		/* GL1 Data Cache per SA */
 		.cache_size = 128,
 		.cache_level = 1,
+		.cache_line_size = 128,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -501,6 +545,7 @@ static struct kfd_gpu_cache_info navi14_cache_info[] = {
 		/* L2 Data Cache per GPU (Total Tex Cache) */
 		.cache_size = 2048,
 		.cache_level = 2,
+		.cache_line_size = 128,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -513,6 +558,7 @@ static struct kfd_gpu_cache_info sienna_cichlid_cache_info[] = {
 		/* TCP L1 Cache per CU */
 		.cache_size = 16,
 		.cache_level = 1,
+		.cache_line_size = 128,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -522,6 +568,7 @@ static struct kfd_gpu_cache_info sienna_cichlid_cache_info[] = {
 		/* Scalar L1 Instruction Cache per SQC */
 		.cache_size = 32,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_INST_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -531,6 +578,7 @@ static struct kfd_gpu_cache_info sienna_cichlid_cache_info[] = {
 		/* Scalar L1 Data Cache per SQC */
 		.cache_size = 16,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -540,6 +588,7 @@ static struct kfd_gpu_cache_info sienna_cichlid_cache_info[] = {
 		/* GL1 Data Cache per SA */
 		.cache_size = 128,
 		.cache_level = 1,
+		.cache_line_size = 128,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -549,6 +598,7 @@ static struct kfd_gpu_cache_info sienna_cichlid_cache_info[] = {
 		/* L2 Data Cache per GPU (Total Tex Cache) */
 		.cache_size = 4096,
 		.cache_level = 2,
+		.cache_line_size = 128,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -558,6 +608,7 @@ static struct kfd_gpu_cache_info sienna_cichlid_cache_info[] = {
 		/* L3 Data Cache per GPU */
 		.cache_size = 128*1024,
 		.cache_level = 3,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -570,6 +621,7 @@ static struct kfd_gpu_cache_info navy_flounder_cache_info[] = {
 		/* TCP L1 Cache per CU */
 		.cache_size = 16,
 		.cache_level = 1,
+		.cache_line_size = 128,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -579,6 +631,7 @@ static struct kfd_gpu_cache_info navy_flounder_cache_info[] = {
 		/* Scalar L1 Instruction Cache per SQC */
 		.cache_size = 32,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_INST_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -588,6 +641,7 @@ static struct kfd_gpu_cache_info navy_flounder_cache_info[] = {
 		/* Scalar L1 Data Cache per SQC */
 		.cache_size = 16,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -597,6 +651,7 @@ static struct kfd_gpu_cache_info navy_flounder_cache_info[] = {
 		/* GL1 Data Cache per SA */
 		.cache_size = 128,
 		.cache_level = 1,
+		.cache_line_size = 128,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -606,6 +661,7 @@ static struct kfd_gpu_cache_info navy_flounder_cache_info[] = {
 		/* L2 Data Cache per GPU (Total Tex Cache) */
 		.cache_size = 3072,
 		.cache_level = 2,
+		.cache_line_size = 128,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -615,6 +671,7 @@ static struct kfd_gpu_cache_info navy_flounder_cache_info[] = {
 		/* L3 Data Cache per GPU */
 		.cache_size = 96*1024,
 		.cache_level = 3,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -627,6 +684,7 @@ static struct kfd_gpu_cache_info dimgrey_cavefish_cache_info[] = {
 		/* TCP L1 Cache per CU */
 		.cache_size = 16,
 		.cache_level = 1,
+		.cache_line_size = 128,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -636,6 +694,7 @@ static struct kfd_gpu_cache_info dimgrey_cavefish_cache_info[] = {
 		/* Scalar L1 Instruction Cache per SQC */
 		.cache_size = 32,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_INST_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -645,6 +704,7 @@ static struct kfd_gpu_cache_info dimgrey_cavefish_cache_info[] = {
 		/* Scalar L1 Data Cache per SQC */
 		.cache_size = 16,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -654,6 +714,7 @@ static struct kfd_gpu_cache_info dimgrey_cavefish_cache_info[] = {
 		/* GL1 Data Cache per SA */
 		.cache_size = 128,
 		.cache_level = 1,
+		.cache_line_size = 128,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -663,6 +724,7 @@ static struct kfd_gpu_cache_info dimgrey_cavefish_cache_info[] = {
 		/* L2 Data Cache per GPU (Total Tex Cache) */
 		.cache_size = 2048,
 		.cache_level = 2,
+		.cache_line_size = 128,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -672,6 +734,7 @@ static struct kfd_gpu_cache_info dimgrey_cavefish_cache_info[] = {
 		/* L3 Data Cache per GPU */
 		.cache_size = 32*1024,
 		.cache_level = 3,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -684,6 +747,7 @@ static struct kfd_gpu_cache_info beige_goby_cache_info[] = {
 		/* TCP L1 Cache per CU */
 		.cache_size = 16,
 		.cache_level = 1,
+		.cache_line_size = 128,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -693,6 +757,7 @@ static struct kfd_gpu_cache_info beige_goby_cache_info[] = {
 		/* Scalar L1 Instruction Cache per SQC */
 		.cache_size = 32,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_INST_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -702,6 +767,7 @@ static struct kfd_gpu_cache_info beige_goby_cache_info[] = {
 		/* Scalar L1 Data Cache per SQC */
 		.cache_size = 16,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -711,6 +777,7 @@ static struct kfd_gpu_cache_info beige_goby_cache_info[] = {
 		/* GL1 Data Cache per SA */
 		.cache_size = 128,
 		.cache_level = 1,
+		.cache_line_size = 128,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -720,6 +787,7 @@ static struct kfd_gpu_cache_info beige_goby_cache_info[] = {
 		/* L2 Data Cache per GPU (Total Tex Cache) */
 		.cache_size = 1024,
 		.cache_level = 2,
+		.cache_line_size = 128,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -729,6 +797,7 @@ static struct kfd_gpu_cache_info beige_goby_cache_info[] = {
 		/* L3 Data Cache per GPU */
 		.cache_size = 16*1024,
 		.cache_level = 3,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -741,6 +810,7 @@ static struct kfd_gpu_cache_info yellow_carp_cache_info[] = {
 		/* TCP L1 Cache per CU */
 		.cache_size = 16,
 		.cache_level = 1,
+		.cache_line_size = 128,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -750,6 +820,7 @@ static struct kfd_gpu_cache_info yellow_carp_cache_info[] = {
 		/* Scalar L1 Instruction Cache per SQC */
 		.cache_size = 32,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_INST_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -759,6 +830,7 @@ static struct kfd_gpu_cache_info yellow_carp_cache_info[] = {
 		/* Scalar L1 Data Cache per SQC */
 		.cache_size = 16,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -768,6 +840,7 @@ static struct kfd_gpu_cache_info yellow_carp_cache_info[] = {
 		/* GL1 Data Cache per SA */
 		.cache_size = 128,
 		.cache_level = 1,
+		.cache_line_size = 128,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -777,6 +850,7 @@ static struct kfd_gpu_cache_info yellow_carp_cache_info[] = {
 		/* L2 Data Cache per GPU (Total Tex Cache) */
 		.cache_size = 2048,
 		.cache_level = 2,
+		.cache_line_size = 128,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -789,6 +863,7 @@ static struct kfd_gpu_cache_info gfx1037_cache_info[] = {
 		/* TCP L1 Cache per CU */
 		.cache_size = 16,
 		.cache_level = 1,
+		.cache_line_size = 128,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -798,6 +873,7 @@ static struct kfd_gpu_cache_info gfx1037_cache_info[] = {
 		/* Scalar L1 Instruction Cache per SQC */
 		.cache_size = 32,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_INST_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -807,6 +883,7 @@ static struct kfd_gpu_cache_info gfx1037_cache_info[] = {
 		/* Scalar L1 Data Cache per SQC */
 		.cache_size = 16,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -816,6 +893,7 @@ static struct kfd_gpu_cache_info gfx1037_cache_info[] = {
 		/* GL1 Data Cache per SA */
 		.cache_size = 128,
 		.cache_level = 1,
+		.cache_line_size = 128,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -825,6 +903,7 @@ static struct kfd_gpu_cache_info gfx1037_cache_info[] = {
 		/* L2 Data Cache per GPU (Total Tex Cache) */
 		.cache_size = 256,
 		.cache_level = 2,
+		.cache_line_size = 128,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -837,6 +916,7 @@ static struct kfd_gpu_cache_info gc_10_3_6_cache_info[] = {
 		/* TCP L1 Cache per CU */
 		.cache_size = 16,
 		.cache_level = 1,
+		.cache_line_size = 128,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 			  CRAT_CACHE_FLAGS_DATA_CACHE |
 			  CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -846,6 +926,7 @@ static struct kfd_gpu_cache_info gc_10_3_6_cache_info[] = {
 		/* Scalar L1 Instruction Cache per SQC */
 		.cache_size = 32,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 			  CRAT_CACHE_FLAGS_INST_CACHE |
 			  CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -855,6 +936,7 @@ static struct kfd_gpu_cache_info gc_10_3_6_cache_info[] = {
 		/* Scalar L1 Data Cache per SQC */
 		.cache_size = 16,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 			  CRAT_CACHE_FLAGS_DATA_CACHE |
 			  CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -864,6 +946,7 @@ static struct kfd_gpu_cache_info gc_10_3_6_cache_info[] = {
 		/* GL1 Data Cache per SA */
 		.cache_size = 128,
 		.cache_level = 1,
+		.cache_line_size = 128,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 			  CRAT_CACHE_FLAGS_DATA_CACHE |
 			  CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -873,6 +956,7 @@ static struct kfd_gpu_cache_info gc_10_3_6_cache_info[] = {
 		/* L2 Data Cache per GPU (Total Tex Cache) */
 		.cache_size = 256,
 		.cache_level = 2,
+		.cache_line_size = 128,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 			  CRAT_CACHE_FLAGS_DATA_CACHE |
 			  CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -885,6 +969,7 @@ static struct kfd_gpu_cache_info dummy_cache_info[] = {
 		/* TCP L1 Cache per CU */
 		.cache_size = 16,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -894,6 +979,7 @@ static struct kfd_gpu_cache_info dummy_cache_info[] = {
 		/* Scalar L1 Instruction Cache per SQC */
 		.cache_size = 32,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_INST_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -903,6 +989,7 @@ static struct kfd_gpu_cache_info dummy_cache_info[] = {
 		/* Scalar L1 Data Cache per SQC */
 		.cache_size = 16,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -912,6 +999,7 @@ static struct kfd_gpu_cache_info dummy_cache_info[] = {
 		/* GL1 Data Cache per SA */
 		.cache_size = 128,
 		.cache_level = 1,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
@@ -921,6 +1009,7 @@ static struct kfd_gpu_cache_info dummy_cache_info[] = {
 		/* L2 Data Cache per GPU (Total Tex Cache) */
 		.cache_size = 2048,
 		.cache_level = 2,
+		.cache_line_size = 64,
 		.flags = (CRAT_CACHE_FLAGS_ENABLED |
 				CRAT_CACHE_FLAGS_DATA_CACHE |
 				CRAT_CACHE_FLAGS_SIMD_CACHE),
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.h b/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
index 74c2d7a0d628..300634b9f668 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
@@ -303,6 +303,7 @@ struct kfd_node;
 struct kfd_gpu_cache_info {
 	uint32_t	cache_size;
 	uint32_t	cache_level;
+	uint32_t	cache_line_size;
 	uint32_t	flags;
 	/* Indicates how many Compute Units share this cache
 	 * within a SA. Value = 1 indicates the cache is not shared
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 83024c6bdd50..3df2a8ad86fb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1564,6 +1564,7 @@ static int fill_in_l1_pcache(struct kfd_cache_properties **props_ext,
 		pcache->processor_id_low = cu_processor_id + (first_active_cu - 1);
 		pcache->cache_level = pcache_info[cache_type].cache_level;
 		pcache->cache_size = pcache_info[cache_type].cache_size;
+		pcache->cacheline_size = pcache_info[cache_type].cache_line_size;
 
 		if (pcache_info[cache_type].flags & CRAT_CACHE_FLAGS_DATA_CACHE)
 			pcache->cache_type |= HSA_CACHE_TYPE_DATA;
@@ -1632,6 +1633,7 @@ static int fill_in_l2_l3_pcache(struct kfd_cache_properties **props_ext,
 		pcache->processor_id_low = cu_processor_id
 					+ (first_active_cu - 1);
 		pcache->cache_level = pcache_info[cache_type].cache_level;
+		pcache->cacheline_size = pcache_info[cache_type].cache_line_size;
 
 		if (KFD_GC_VERSION(knode) == IP_VERSION(9, 4, 3))
 			mode = adev->gmc.gmc_funcs->query_mem_partition_mode(adev);
-- 
2.20.1

