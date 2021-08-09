Return-Path: <SRS0=nf5+=NA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4E2C4338F
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Aug 2021 22:21:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0E6260C41
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Aug 2021 22:21:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E0E6260C41
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A89589361;
	Mon,  9 Aug 2021 22:21:41 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2076.outbound.protection.outlook.com [40.107.102.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FA3889361
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Aug 2021 22:21:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AkojMInl+AQ5t3tV/G/lNf9IUzQWbT9ABHEQnbySnA2688YqRKsl4yIeoB4YSrboVTGqstLpCN9PQzvfCEb/kNcSh0qIm5+8zTSH7RgWTt/pA5sWjPKQImKS8pepG9B8ZABbhsy3+ObiAyRv5gBDgGagmOxf2VK7txrVZyzlJKnmyN4i2pQ6XKF5dcXBoPWgHTZXHdlRZ+Jyyj1PxBzQymFAs6YLjlejTtl3kLhTuSfYtCRRGg6W/gN5UPlMXxlPL6fmDVx2+++X7DYsIDFBeWEjime3hSXX3/y9Vhu7zaZNwkxkEvpQYYhnQtRvWbXu6GawyFLWOBLzWwTXdMwwPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=skrjdXRMg8XSAK8NbgBu3Lxb7D/UJ4zr7Lkd1J/hjNg=;
 b=I89H/a5icL3lJY9mzcT5rkeQIkWeEGqyUJSCFM3s3YBDiOshxQnE/VSv3GzlK3hO6/UpdiSgf12GUr6iFvy4B4udDfOcl0lESzu6gCA3aBhfx+30VKFY9xJvYLyoIhewslB7RyvDuF5iYCJJA+iEIwaY4C4NSewPcx7g1MntSCRGNDDnKDIORD34P+gQJfnkwD7zBQRHSgK5WnBs+3N1gWXDE1dcDNd6kSWOjVIq4+qNFDhITtvfBj/yEW/ex/cmdrkVtrBPEr2gjJlPXuyUA/i7hlCppziQxlp+NA5Cqw7fi7c20hN2aFNg0RlQ5EKDNHhidVanOt+piFdht1l++A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=skrjdXRMg8XSAK8NbgBu3Lxb7D/UJ4zr7Lkd1J/hjNg=;
 b=cHRBEiW/LTy7LnvJj4deNa8cczrwN0x/iXftka5RUKcjb6n3PaLvqmilpBXg7GQeoJrd22FQce1X4nqmCxCcYzLIlLiHBYQQdCJhsB/dIwHSv9UfaLxE32mJKMEy7xzVSDkUjrl0HaVAblN7r+S8wdo0Rgkl2ofFgYw9wwE0CAc=
Received: from CO1PR15CA0098.namprd15.prod.outlook.com (2603:10b6:101:21::18)
 by DM5PR12MB1467.namprd12.prod.outlook.com (2603:10b6:4:c::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4394.17; Mon, 9 Aug 2021 22:21:37 +0000
Received: from CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:21:cafe::b1) by CO1PR15CA0098.outlook.office365.com
 (2603:10b6:101:21::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend
 Transport; Mon, 9 Aug 2021 22:21:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT058.mail.protection.outlook.com (10.13.174.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4394.16 via Frontend Transport; Mon, 9 Aug 2021 22:21:37 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Mon, 9 Aug
 2021 17:21:35 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v2] drm/amdkfd: AIP mGPUs best prefetch location for xnack on
Date: Mon, 9 Aug 2021 18:21:23 -0400
Message-ID: <20210809222123.19464-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210802162806.12631-1-Philip.Yang@amd.com>
References: <20210802162806.12631-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f952dd4a-4d15-4796-8010-08d95b840dcc
X-MS-TrafficTypeDiagnostic: DM5PR12MB1467:
X-Microsoft-Antispam-PRVS: <DM5PR12MB14673BD0D3ACA2302C415E4FE6F69@DM5PR12MB1467.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dUh1tFw2ie0CzXbFcqmf//EZ37fGCvwMwlH1aNOBzBXnZLWDnorxIo7fmRO1kLAyG7/RN3kAgw+nY99DVW9eS6m9/9L9NXjeI0yDShn13NyIxiLJNoAlAGv8TsaUfFrdSpfPBE2EmfMJK3GaH1b+gjYoLj71ZBV4+t6XebamZLgYAythq4grAwR9wbYdzGzTbR10DPB3PmYMezqN7ZDMgruflbNRywr4yydQGcG1MQ17E2rL3i9HNSQaXyVTHScCkSRmdAq79CTlef24QiORUWA3s3spXXyIOnAif0JYPDyP+LJPdgj+cZ1sZazg2iAoWF4SmuwjirwYg2Yeft9gwAdswGKyMdE36JOER9VhggZB8/iAF4fnSjnlcP1qpaFmqk7Y9p1lEJAXlL1oTj0ALQoX0XD7oydbZRUf3DNglbP6zqTUV9XGrVTGC9QieYikd4NV9sEUBj6OmnxDIg1BbfaJiVnQcJZf/mrn76Pn8OYsZgbWHi38OCtQED/VZ33b7Sii6O38Pd3BnJCPIDRztBCm5nC0apsRDslCk8xYO6HfZdzGasDhCfRWshpALI++4AWzSoCX5EJbVSfac1ANz9cB8YgSJxuvtRCyt3XJ8Vuf+yDdmi2i+qP4AhcnUS+GwE8q5IL/EqJOs8ENDlIjJ8daxfF4kukkPLDwFOd0WK4S6wRMtdy2GluTsRKtiEkuOLawEVIyh0Qv+VYApYUkatgOQW7saiATeWhN/hEsJBw899IKK51IeveDc8ts/haygBB6UUfg9Tu126rZC9E7JA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(136003)(396003)(46966006)(36840700001)(6916009)(36756003)(47076005)(356005)(2906002)(186003)(26005)(2616005)(86362001)(336012)(82740400003)(426003)(1076003)(4326008)(81166007)(16526019)(316002)(7696005)(478600001)(5660300002)(70586007)(34020700004)(6666004)(8936002)(8676002)(70206006)(82310400003)(83380400001)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2021 22:21:37.3413 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f952dd4a-4d15-4796-8010-08d95b840dcc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1467
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

For xnack on, if range ACCESS or ACCESS_IN_PLACE (AIP) by single GPU, or
range is ACCESS_IN_PLACE by mGPUs and all mGPUs connection on xgmi same
hive, the best prefetch location is prefetch_loc GPU. Otherwise, the best
prefetch location is always CPU because GPU can not map vram of other
GPUs through small bar PCIe.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 35 +++++++++++++++-------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index f811a3a24cd2..5bd51a15fb00 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2719,22 +2719,26 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 	return 0;
 }
 
-/* svm_range_best_prefetch_location - decide the best prefetch location
+/**
+ * svm_range_best_prefetch_location - decide the best prefetch location
  * @prange: svm range structure
  *
  * For xnack off:
- * If range map to single GPU, the best acutal location is prefetch loc, which
+ * If range map to single GPU, the best prefetch location is prefetch_loc, which
  * can be CPU or GPU.
  *
- * If range map to multiple GPUs, only if mGPU connection on xgmi same hive,
- * the best actual location could be prefetch_loc GPU. If mGPU connection on
- * PCIe, the best actual location is always CPU, because GPU cannot access vram
- * of other GPUs, assuming PCIe small bar (large bar support is not upstream).
+ * If range is ACCESS or ACCESS_IN_PLACE by mGPUs, only if mGPU connection on
+ * XGMI same hive, the best prefetch location is prefetch_loc GPU, othervise
+ * the best prefetch location is always CPU, because GPU can not map vram of
+ * other GPUs, assuming PCIe small bar (large bar support is not upstream).
  *
  * For xnack on:
- * The best actual location is prefetch location. If mGPU connection on xgmi
- * same hive, range map to multiple GPUs. Otherwise, the range only map to
- * actual location GPU. Other GPU access vm fault will trigger migration.
+ * If range is not ACCESS_IN_PLACE by mGPUs, the best prefetch location is
+ * prefetch_loc, other GPU access will generate vm fault and trigger migration.
+ *
+ * If range is ACCESS_IN_PLACE by mGPUs, only if mGPU connection on XGMI same
+ * hive, the best prefetch location is prefetch_loc GPU, otherwise the best
+ * prefetch location is always CPU, because GPU cannot map vram of other GPUs.
  *
  * Context: Process context
  *
@@ -2754,11 +2758,6 @@ svm_range_best_prefetch_location(struct svm_range *prange)
 
 	p = container_of(prange->svms, struct kfd_process, svms);
 
-	/* xnack on */
-	if (p->xnack_enabled)
-		goto out;
-
-	/* xnack off */
 	if (!best_loc || best_loc == KFD_IOCTL_SVM_LOCATION_UNDEFINED)
 		goto out;
 
@@ -2768,8 +2767,12 @@ svm_range_best_prefetch_location(struct svm_range *prange)
 		best_loc = 0;
 		goto out;
 	}
-	bitmap_or(bitmap, prange->bitmap_access, prange->bitmap_aip,
-		  MAX_GPU_INSTANCE);
+
+	if (p->xnack_enabled)
+		bitmap_copy(bitmap, prange->bitmap_aip, MAX_GPU_INSTANCE);
+	else
+		bitmap_or(bitmap, prange->bitmap_access, prange->bitmap_aip,
+			  MAX_GPU_INSTANCE);
 
 	for_each_set_bit(gpuidx, bitmap, MAX_GPU_INSTANCE) {
 		pdd = kfd_process_device_from_gpuidx(p, gpuidx);
-- 
2.17.1

