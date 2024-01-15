Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0A5BC3DA79
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jan 2024 22:51:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84E8A10E397;
	Mon, 15 Jan 2024 22:51:28 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0B8B10E397
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jan 2024 22:51:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ClAZiGefptHmzsfLk9ng9x5bP+ntCPG50cjJs3AVgME4vD0Cx53XKMtY7Yc+2qW9gLo7WqSU4wXdSz9bZaIOwiBBIh0LEsQgKTvN1alxovGulSeWB2fpLoazwPzRb80KIHdRw5qDMG03FXm60rdY3Jf2GeTbNYcgov76qRmXFUJEQDzhoKnQB2OZ7V2b5fxM3oLZRNdAmSkSjr0oMXOT0gZxHGZdfKLV9KPJg7CA4GxeWXDVfTKteOEIXzvB/ZLHShLjHaJowB5uqN+OKG6C1LzRwC0ygTcTBSZ37A+seEzJeWzxh6n5ASyN352CsuUbCOJWx9g07fOnByjUOtdhXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V/T0W3uqjxInBiNz3I1hSdtCVJ0oUm9ZE/Du49+w1pY=;
 b=NELkyG4TJujy8zQ8jo+HaQTEKTIo5os8Tg8uJCcOUBLBRjbqhQk46ZdJVongAE2VA2TV2Vbqpm+vf3gJITdse4/nHIsrroczdsbhDDULAqnrrxqWeJk2d5XjpxugdchVB0F2XjUy1X7EB+XlxzN9GglwVAUdL3hbnxi58pVdRDGrfAXMBwctAwMK/plCzX6WPxTBDlxmPHqbPb7xwuKiVyeXP5m5Dq2JpFY/HSpviBZon297JUAHzKEw8YaJJM8BbJdsFADM6taMSw0vSjhXJzM7lCZv3xqTqmKkYosCYVJHJKq93wrmRlycbj38Wlc04reK1zFuNBS32uJFnoiL+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/T0W3uqjxInBiNz3I1hSdtCVJ0oUm9ZE/Du49+w1pY=;
 b=Ou+UMHCvAQ/T19R8DOtsV7CtmwRIo2vCsxfZgU1h854mWgJsbRuS43yFn22+tI36ou/pKiv/4aY6aB+xSZQ/s56cD1rsq2XF2eO79ngTXTGVB7CzZ9qS0ihMaKZ5GRn9kOW6EqBO9bzpV0gGSAp//Y8znONBkeT6cCh7GFXthyc=
Received: from SA9PR13CA0164.namprd13.prod.outlook.com (2603:10b6:806:28::19)
 by BL3PR12MB6524.namprd12.prod.outlook.com (2603:10b6:208:38c::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Mon, 15 Jan
 2024 22:51:21 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:806:28:cafe::4) by SA9PR13CA0164.outlook.office365.com
 (2603:10b6:806:28::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.19 via Frontend
 Transport; Mon, 15 Jan 2024 22:51:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Mon, 15 Jan 2024 22:51:21 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 15 Jan
 2024 16:51:20 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 1/7] drm/amdkfd: Add helper function
 svm_range_need_access_gpus
Date: Mon, 15 Jan 2024 17:49:44 -0500
Message-ID: <20240115224950.3300-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|BL3PR12MB6524:EE_
X-MS-Office365-Filtering-Correlation-Id: a3d5f384-4f64-4318-f317-08dc161c7e56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J0CJvKYz1dylYnXqj0Xj72amrDKAuloAPLDoiW/j6BsXb7pJYxs37Bl1RWeob3yvtt8rgI/8Q3md6bMM5jGoGNxvcaqTiIqBR6dECnnzUiyRXPul1wYxsYiJiLp9QzVsOM6Wf+cAXdAWsoyV2qRSdb1NOneLV2K8ubND5KCFhJccGwc/Euxbl9ZeHta4plqcLff3AtW/BXDcWWKyqoQCLdtNDDijUcptL7c2/4qpVM4KN4XqGj439mdkWt1T5v6wg0HZ1qZhnXDdyvdwZPRFY7o6sWe5ybkw4YzT5+aPaU994OZ6cpUjrrJ28WOKCrqBQOZfA69FRIEEWdjJVj2MMc+Mh3CplZ+DNuSriQGO42y0JGWxBPIjEPiXi0PVYKK92yXGmMFs/82lUNn8cXP7JZNluSLbQU0jAoWkNm+eXVqc+zwjKGk+kll/1rqxZwpOpJgABJDlI/3dl8oRCvy4j2nQwyLsPAIlPdL1irPnR0HLKvR1SmUzAMtji/OKGAdXOnxsMQh2hOu3+tAx1YhLiVWEHispxY5/LwM40Yv3VgooPtzDvdqbaIsKsTZENqTBE3MC+ydgyv/s3YRbdpA1n3hDkA4FXOUTiZij0zDVeKtwqY6sS2u40LrdhO/DaIN12w6LuiKzfa0MJ0mnbFLpPhCTqgMweb6cs3eyMCI4PTzPYQZELFKNNschpXnwCzaKGbOfFuSYukYL5z4N+ZLR51B1qksVXxKoAU+QDhm/hbvD1E7BrKjGsMuvWow8+Gvx4B2e6KsmtmwGMl73vJLmUw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(396003)(136003)(346002)(230922051799003)(186009)(64100799003)(82310400011)(1800799012)(451199024)(46966006)(36840700001)(40470700004)(478600001)(6916009)(6666004)(8936002)(7696005)(54906003)(8676002)(70586007)(36860700001)(47076005)(316002)(70206006)(83380400001)(1076003)(26005)(336012)(2616005)(426003)(41300700001)(2906002)(4326008)(5660300002)(16526019)(36756003)(356005)(82740400003)(81166007)(86362001)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 22:51:21.3665 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3d5f384-4f64-4318-f317-08dc161c7e56
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6524
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
Cc: Philip Yang <Philip.Yang@amd.com>, Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add the helper function to get all GPUs bitmap that need access the svm
range. This helper will be used in the following patch to check if
prange is mapped to all gpus.

Refactor svm_range_validate_and_map to use the helper function, no
functional change.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 74 ++++++++++++++++------------
 1 file changed, 43 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 18f8c82a849c..14dbc0fd51a9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1169,6 +1169,44 @@ svm_range_add_child(struct svm_range *prange, struct mm_struct *mm,
 	list_add_tail(&pchild->child_list, &prange->child_list);
 }
 
+static int
+svm_range_need_access_gpus(unsigned long *bitmap, struct svm_range *prange)
+{
+	struct kfd_process *p = container_of(prange->svms, struct kfd_process, svms);
+	u32 gpuidx;
+
+	if (p->xnack_enabled) {
+		bitmap_copy(bitmap, prange->bitmap_aip, MAX_GPU_INSTANCE);
+
+		/* If prefetch range to GPU, or GPU retry fault migrate range to
+		 * GPU, which has ACCESS attribute to the range, create mapping
+		 * on that GPU.
+		 */
+		if (prange->actual_loc) {
+			gpuidx = kfd_process_gpuidx_from_gpuid(p, prange->actual_loc);
+			if (gpuidx < 0)
+				return -EINVAL;
+
+			if (test_bit(gpuidx, prange->bitmap_access))
+				bitmap_set(bitmap, gpuidx, 1);
+		}
+
+		/*
+		 * If prange is already mapped or with always mapped flag,
+		 * update mapping on GPUs with ACCESS attribute
+		 */
+		if (bitmap_empty(bitmap, MAX_GPU_INSTANCE)) {
+			if (prange->mapped_to_gpu ||
+			    prange->flags & KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)
+				bitmap_copy(bitmap, prange->bitmap_access, MAX_GPU_INSTANCE);
+		}
+	} else {
+		bitmap_or(bitmap, prange->bitmap_access,
+			  prange->bitmap_aip, MAX_GPU_INSTANCE);
+	}
+	return 0;
+}
+
 static bool
 svm_nodes_in_same_hive(struct kfd_node *node_a, struct kfd_node *node_b)
 {
@@ -1609,38 +1647,12 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 	if (gpuidx < MAX_GPU_INSTANCE) {
 		bitmap_zero(ctx->bitmap, MAX_GPU_INSTANCE);
 		bitmap_set(ctx->bitmap, gpuidx, 1);
-	} else if (ctx->process->xnack_enabled) {
-		bitmap_copy(ctx->bitmap, prange->bitmap_aip, MAX_GPU_INSTANCE);
-
-		/* If prefetch range to GPU, or GPU retry fault migrate range to
-		 * GPU, which has ACCESS attribute to the range, create mapping
-		 * on that GPU.
-		 */
-		if (prange->actual_loc) {
-			gpuidx = kfd_process_gpuidx_from_gpuid(ctx->process,
-							prange->actual_loc);
-			if (gpuidx < 0) {
-				WARN_ONCE(1, "failed get device by id 0x%x\n",
-					 prange->actual_loc);
-				r = -EINVAL;
-				goto free_ctx;
-			}
-			if (test_bit(gpuidx, prange->bitmap_access))
-				bitmap_set(ctx->bitmap, gpuidx, 1);
-		}
-
-		/*
-		 * If prange is already mapped or with always mapped flag,
-		 * update mapping on GPUs with ACCESS attribute
-		 */
-		if (bitmap_empty(ctx->bitmap, MAX_GPU_INSTANCE)) {
-			if (prange->mapped_to_gpu ||
-			    prange->flags & KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)
-				bitmap_copy(ctx->bitmap, prange->bitmap_access, MAX_GPU_INSTANCE);
-		}
 	} else {
-		bitmap_or(ctx->bitmap, prange->bitmap_access,
-			  prange->bitmap_aip, MAX_GPU_INSTANCE);
+		r = svm_range_need_access_gpus(ctx->bitmap, prange);
+		if (r) {
+			WARN_ONCE(1, "failed get device by id 0x%x\n", prange->actual_loc);
+			goto free_ctx;
+		}
 	}
 
 	if (bitmap_empty(ctx->bitmap, MAX_GPU_INSTANCE)) {
-- 
2.35.1

