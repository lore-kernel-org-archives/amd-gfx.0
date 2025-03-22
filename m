Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D1DEC35FFC
	for <amd-gfx@archiver.kernel.org>; Sat, 22 Mar 2025 14:17:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B4BD10E12C;
	Sat, 22 Mar 2025 14:10:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gQkFxAJn";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13D6810E11B
 for <amd-gfx@lists.freedesktop.org>; Sat, 22 Mar 2025 14:10:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dUon1ZL2ktk5FGcAnXB9Nof5PwMFXA/gPaAAqdlxxiQSQqtP0mYS1MuECUmTSR+ect41HfATgyjSshZp8f6+DLHAo8Bpc7OjAXdSBtFcdQZAZTDuTkwAyce39dZdeZDjXnvAkEAh/QPFyteVyAgQouFXG/GJeZbATfYNi35V8ZThnigWS7JJoSFXw2vlgoRDx0PpwtkpqlOOqBk7phah9N1MhD4VZBVDL027t6A9wgPIk5hAKy1sytUYujcyjkOR01ahWQLrXJG3EVMTZVBs6j/38FGtzEhA/im09LLhdBfg7sdQf1xHZcsknJTL4SWqhzCUivOyxGeg37tdgxc8Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FNWSWk0DnElRZWkCUK34zgVs3DRIFLS09ymSviOpeNg=;
 b=lqtnESdVRkjW4J/X1OQ4P0PEWlzfX8h3xgFIENwygMYg2n3OV6lmbGl0LHDg0OJVNxHOc86sd3nHWGZTonq5khJW/Go5IYAqc3tzS+eez8sMYNDbvnnm1j931trnEF9cBW/86WVRSbnUlPvzliOVgZv1uO0h8BSdR0ypSRMVfIfJHeekEGvVno9cl/RV9ClIsKe6B5qIN7UJcuM0V6M8PP5DzQy7GRD3Tmp3PA//FAjoORHm386+6IJquDnOVvKtRowjV3w/hSFRmeVhEr7p3V6T8nBiQBGhvj48UJVf4X3BLWq6QqNVJqYdIJAnXdJy0HlmDlIG/uNSv8do6KDjfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNWSWk0DnElRZWkCUK34zgVs3DRIFLS09ymSviOpeNg=;
 b=gQkFxAJnZ1nQz7t6DOHrGqAM+ZboDzMWMJAbvhoHP5TRxqEBmct4PfcpP6futg1L5XJFt4FSsTEwpxZXS/jg+x6OSo03pKJ89sz4hx5U6RST8k9/Z/Sx+4qVg+aqj171wKnrCTY7LCWjKtnMv+kgiItwOGuQ5tDxtXYOGIKvujE=
Received: from MW4P222CA0008.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::13)
 by DS0PR12MB8296.namprd12.prod.outlook.com (2603:10b6:8:f7::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.37; Sat, 22 Mar 2025 14:10:33 +0000
Received: from CO1PEPF000075F3.namprd03.prod.outlook.com
 (2603:10b6:303:114:cafe::cd) by MW4P222CA0008.outlook.office365.com
 (2603:10b6:303:114::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Sat,
 22 Mar 2025 14:10:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075F3.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Sat, 22 Mar 2025 14:10:32 +0000
Received: from jc-d.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 22 Mar
 2025 09:10:31 -0500
From: Jay Cornwall <jay.cornwall@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jay Cornwall <jay.cornwall@amd.com>, Kent Russell <kent.russell@amd.com>
Subject: [PATCH v2] drm/amdgpu: Increase KIQ invalidate_tlbs timeout
Date: Sat, 22 Mar 2025 09:10:07 -0500
Message-ID: <20250322141007.13380-1-jay.cornwall@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F3:EE_|DS0PR12MB8296:EE_
X-MS-Office365-Filtering-Correlation-Id: 46e638f6-3618-4768-be9f-08dd694b4f02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JCIjtdAtc3GDFMxQDM+tz2ecdb0XiWpSwKrENaSMelm/00Uakkgd+rEkzvQo?=
 =?us-ascii?Q?FN8n7XO0/Gv+FOuRMh4k4U3nSjG6ajvwhaD8mNROmXTRdPxdxBSzC+OHwI+C?=
 =?us-ascii?Q?xQVPvRd1JL2wUH2f6fpeHPIWDClPCJ7h+x2oEwgR/78QZqhNKhVhVyU0kSZ5?=
 =?us-ascii?Q?8TYd6Pd0IdWELEAJII3objqfJaJS5X0mh2/+iil1pPv2V++XMwHOr+O2DAG6?=
 =?us-ascii?Q?zp4paK5WBD3OhHcvomQQSCs82CTkmCPqj3rU2UJLMczcI4ko7hRO+7ohq8v0?=
 =?us-ascii?Q?0wubh14dDEEUGqFH2r5MYOi0Ijs93Hah7OQSEbwCsxBNZ06Ez+H3+u6zWybA?=
 =?us-ascii?Q?sL24uh4LK/laJZceVf0h3a9V4OIC9m/V5wNpagIdCEiF08KQCKVzf56mjr7p?=
 =?us-ascii?Q?aV4WQRPK7eYc2zClggfSHhPinAHZpULq8j8w9r4lbR9Us11KsuelP0ERvodn?=
 =?us-ascii?Q?68OmiRyUGYePZliRGtyI0u0ThnWjhuz/xOlhuaOMxYaBZEnACxsv/6XSDP6l?=
 =?us-ascii?Q?346gjJPK4aIUGeWbCsJ5sv4rABvPz4ZrVsiONP1BQsy9SOrrozFP5ZahAqgl?=
 =?us-ascii?Q?fDWywukQ0uYVrYKXOPnNPm2H2rgD7FCFg62tQlr6b2MpeYvTsR4leZRuESvH?=
 =?us-ascii?Q?XkrOyj07cDe2yHiScwat5yndZOD5hZue5+wD5fw3bMwOwq6TDJb1fMcZMir+?=
 =?us-ascii?Q?+MMHJh9ndrSFFsZhmg2HSO0Pv6usHSLYK3ab0GK+2uccwOV21xi3NxsVsLla?=
 =?us-ascii?Q?8JCFeoB05CvCfvves+ccHm+mkWwzZSjlbyYuc0x1pC0Nuz+QBO9Sbh79BplE?=
 =?us-ascii?Q?E+IFyWCixJxCUASRuSE1/5uHyv35jZZmrf/BMAN6u8J6KghazGhhbslUOBtI?=
 =?us-ascii?Q?6tUrUWwAnBTddzxIGDaf2n5gGrcRw61B2RDg1B0Xx525a0xahQvInIlKZg7x?=
 =?us-ascii?Q?CleXKjVb5/lMESzBCjjS/pKwEwgsFIjYNMKKgaL+ZxIttj7OOl2vmdQfDEFE?=
 =?us-ascii?Q?qQ2/3KAi844lzRZ+Hd2UtdjMft6DqJqp0zBMPYH8eu6tIO6DsqHOOtI/gQaD?=
 =?us-ascii?Q?1+6XdtfBEx40tbfMtoUTfP8pK+McUcLalduCn4sgXy0AdRtb87Jd7YunV4/o?=
 =?us-ascii?Q?1M9c94DQN1NNLlM0bQdTUQfImYqSYJF3u3OlVqCZ3Wb6WEmIvVgotSAqY5eX?=
 =?us-ascii?Q?GecJoPRCYDzwEKx94EL1u0cP8JcYdryOA4r5lAT1VWjPv8HTcjhQoymIl5+1?=
 =?us-ascii?Q?ZEhqw/7E4gjwSbXHTDY/Q4izYd9O3VDIfOFhjW0B0akrk13KuNoWX/6wfsTg?=
 =?us-ascii?Q?mN/OrGPjmW3GUcvR1qPTMvHud9nqAdcE3S+t97qsVQv8k4WYaYYwvW7yIKgO?=
 =?us-ascii?Q?VU7R3SUrckIlVBBQmwTZfq/FiUmBNvnh5fBWwKntt+RDTV4VadQNp85acOsm?=
 =?us-ascii?Q?pNYD7nz5Dl51wR5i55smKCKIILRDdj1gmaP67vi5wg9FZOobXRLvhhbhzTsZ?=
 =?us-ascii?Q?XKLusU7dSuqAFik=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2025 14:10:32.3959 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46e638f6-3618-4768-be9f-08dd694b4f02
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8296
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

KIQ invalidate_tlbs request has been seen to marginally exceed the
configured 100 ms timeout on systems under load.

All other KIQ requests in the driver use a 10 second timeout. Use a
similar timeout implementation on the invalidate_tlbs path.

v2: Poll once before msleep

Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
Cc: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 16 ++++++++++++----
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index f68a348dcec9..54bf8780f0b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -355,7 +355,6 @@ enum amdgpu_kiq_irq {
 	AMDGPU_CP_KIQ_IRQ_DRIVER0 = 0,
 	AMDGPU_CP_KIQ_IRQ_LAST
 };
-#define SRIOV_USEC_TIMEOUT  1200000 /* wait 12 * 100ms for SRIOV */
 #define MAX_KIQ_REG_WAIT       5000 /* in usecs, 5ms */
 #define MAX_KIQ_REG_BAILOUT_INTERVAL   5 /* in msecs, 5ms */
 #define MAX_KIQ_REG_TRY 1000
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 464625282872..c46e36a0cd9c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -699,12 +699,10 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
 				   uint32_t flush_type, bool all_hub,
 				   uint32_t inst)
 {
-	u32 usec_timeout = amdgpu_sriov_vf(adev) ? SRIOV_USEC_TIMEOUT :
-		adev->usec_timeout;
 	struct amdgpu_ring *ring = &adev->gfx.kiq[inst].ring;
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[inst];
 	unsigned int ndw;
-	int r;
+	int r, cnt = 0;
 	uint32_t seq;
 
 	/*
@@ -761,7 +759,17 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
 
 		amdgpu_ring_commit(ring);
 		spin_unlock(&adev->gfx.kiq[inst].ring_lock);
-		if (amdgpu_fence_wait_polling(ring, seq, usec_timeout) < 1) {
+
+		r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
+
+		might_sleep();
+		while (r < 1 && cnt++ < MAX_KIQ_REG_TRY &&
+		       !amdgpu_reset_pending(adev->reset_domain)) {
+			msleep(MAX_KIQ_REG_BAILOUT_INTERVAL);
+			r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
+		}
+
+		if (cnt > MAX_KIQ_REG_TRY) {
 			dev_err(adev->dev, "timeout waiting for kiq fence\n");
 			r = -ETIME;
 		}
-- 
2.34.1

