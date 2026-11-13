Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F36D606A333
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2026 02:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=CahfpByZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2A0210E5E0;
	Fri, 13 Nov 2026 02:42:16 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013071.outbound.protection.outlook.com
 [40.93.196.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3226210E5E0
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2026 02:42:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h5z4RT9BBESiJ7AoNZuzQq3KNSyYd5O76fk7ocibPVCxmMbzkHrt2zZ5P5/US14mvsRPKhF4hqKHSsuSZ0/ogWt4/k2D4pkQgWJBAp+uwzanJiGq/811+Z2nRtYJhtFVEdVGJOh7yo2Bd880bD0shyGGyDYv6N2BcbMgfaU4mSLvidoOfIC9dcZujJBpZqkgLJ5uu+AL8MsekVqMqXZC6ldznPWw0cVh5caECdDng2nW4Cqke+3C7/1DAP2oUPvZM/MKYSOF7QucVrO3H1aNPiAk5sPFlxJbeX0K+T6knrYWdhrHpBWwPzU6tiWPcpd7Y5cb1phBxiSzla+UUjv9gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4x104TvtLBFAzxUI5Xj2Y2Y9fqzMhHuu9NlTD8R6RGY=;
 b=aVwI9Uq29oahgIrLIuXlGM5FJY/mqAvmwosiV0294fcbwAsUPwMUTqTUxU0c3h0W1xaSgFltc+tHkeGDQB1/v7ibw8/WLpSuR6iRP8JzW3ZNAS28BpdKKb7jZXECnBbQvQ8eN4tlvPUBdoyW22VSMK22f4uhJ58U6SrT2jEGrbMYL95JXqCPiM5wo8+IL6+3hLbEmVZSjEZm9WS6a1LOjZIw9boNny+czSzvRWWZfnXowfpsgmYSTEqyvyXnrMhk8b0crcYp5QyWMZXjIz+SjvInOF8SkuvAggvebvTQoi7CyhbIiCAjF3Y8pXXD0ZUh4N9H0X54jSKYJb46AnchXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4x104TvtLBFAzxUI5Xj2Y2Y9fqzMhHuu9NlTD8R6RGY=;
 b=CahfpByZzV3vYOcTrurmBvOKdnCwPucz/PKtdp2eyzJU2mV1xfl2Jfv8AQNsF8UnVZhLoaakAwis/6Fly6Jfw3QzPMDlJKiBYC4GGgk9aYpsLeIBu1GrxFNiTrOszTx/Q54pTaHZYtefJaD+eoT4Qip5sU40QJOHaRQDYAV0UuY=
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; dkim=none (message
 not signed) header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY3PR05CA0007.namprd05.prod.outlook.com (2603:10b6:a03:254::12)
 by IA3PR12MB246477.namprd12.prod.outlook.com (2603:10b6:208:70e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 02:40:06 +0000
Received: from DM3PEPF000265C4.namprd03.prod.outlook.com
 (2603:10b6:a03:254:cafe::1e) by BY3PR05CA0007.outlook.office365.com
 (2603:10b6:a03:254::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Fri, 13
 Nov 2026 02:40:01 +0000
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM3PEPF000265C4.mail.protection.outlook.com (10.167.23.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 13 Nov 2026 02:39:56 +0000
Received: from amberlin-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 12 Nov
 2026 20:34:22 -0600
From: Amber Lin <amber.lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <Shaoyun.Liu@amd.com>, Amber Lin
 <amber.lin@amd.com>
Subject: [PATCH] drm/amdkfd: Move gpu_recovery location
Date: Thu, 12 Nov 2026 21:33:37 -0500
Message-ID: <20261113023337.21214-1-amber.lin@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265C4:EE_|IA3PR12MB246477:EE_
X-MS-Office365-Filtering-Correlation-Id: bcc7828f-3c90-4f4a-ede9-08df412f6771
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|23010399003|18002099003|261009223027099003|11063799006|56012099006|10067099003|261102123227099003|261022105027099003|261026121527099003|261028144727099003|261021121427099003|261026140227099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: 4SPqDtyUpEVsVLW5MeLYbI+kRSPvER4sUTuRnNVpTWfrkgzy8lLNNhSNZB+Pcgx3SKlpHiVUYbP3kj6vEf00SIVkCF+EKdzk2HGfoxtV9b+zXl+Op9xnYNv9nRQOlqS2BsJaVrx3JFUNzgMCIu3V3n68XmzJ18BeQuDRzMLlW+WtEDGq43cpFgkXxmUlmygWd3pz1R4RVG5D300XmmZIprVhk9eUmA5bQ5/u6iyHtylX6ebBb+XO0uIjVn7DJvvw4SwgiEcZVJgKLf6dRCY9o8quZVNbKi8/UeQaNicsimUpJTDZptQb9cgAmcLaTk5dL20XWwUfiZy+R5ZHAX4j58Q4I3fn7yUs46/IYI5HvqP3B2OBudf8SeLfk7zjWU/XaKL4nJ9k11qtTkKrVG0WbtxtkqKrROM1BD3ROXkYu8u2xtHZ3MELA9XZmFTQK9A7GE4jQq1AOTHvDXGxQWeGlK9TMwEQ10m0AYOgyHdYOl2uNCQguVZOyJrouowq/xe8QcPChwj6mHnW1vTQ71kyXGfdNeCHQLi8eeFZqhmnACqf8589nS5hAqMkGe4t3Zcrwa2prDW/125iqxgMupCjuX3wmnhEq5aMpo682kqUm7EGeRcYdOlHeFyNi9YMmizORdu8hTeV7AObcISma5DrgL4sWYEawkMPmhp7Lm3gM8o=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(23010399003)(18002099003)(261009223027099003)(11063799006)(56012099006)(10067099003)(261102123227099003)(261022105027099003)(261026121527099003)(261028144727099003)(261021121427099003)(261026140227099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bxa/rh1QfQRTfiOofGObCyFVdMuD6x8d1pKRz2onssY2beKGq8H88zDJuW7EhDbWSX/juizZgZq/NC7EbrANT5RIeUJXIvgwgtAdxfcYIim5QQs2XR04uWBBIuUNMndDz/Kw/imz8RRjsCT/rpKFOYDofAOW9EPo5WMyq5Dz5bVwKAWJH2S2mLseMKN5bhFiZslpuzAe76czmMGOFMiT3VxqwytJA+z3Iml39OMFQB3YMvY4XsYHSd3xS1eCGiE0SsbhE1sn3KWuKd4cz0AICUXY4Ifimq+6436inWsmYfr/1KPfLBcNkjj2yY5BnLr4vZYsUHwnLoOcVVS88ahRNtK3yXfbhvMlS5yoBWajmeViLvlVHZhA/pUY1hoV8cEkwmw+OZWMojfvQXKdnm9iOlbjiMjB6jouu3qqewqCXLPCenOsKctSG2ncikUbr9oO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 02:39:56.3378 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcc7828f-3c90-4f4a-ede9-08df412f6771
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3PEPF000265C4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR12MB246477
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

amdgpu_gfx_reset_mes_compute combines two features into one:
1) hung queue/pipe reset - suspend all/queue reset/resume all
2) bad queue removal - suspend_all/remove_queue/resume_all
GPU recovery aims on 1)resetting hung queues/pipes. When gpu_recovery is
disabled, we need to keep 2) going. Therefore move the gpu_recovery
check from KFD's reset_queues_mes into amdgpu_gfx_reset_mes_compute
where queue reset is done.

Signed-off-by: Amber Lin <amber.lin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c               | 5 +++++
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 9 +++------
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index c5a2dcff5058..f8874c12c94b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -2602,6 +2602,10 @@ int amdgpu_gfx_reset_mes_compute(struct amdgpu_device *adev,
 		 */
 		goto fence_reset;
 	}
+
+	if (!amdgpu_gpu_recovery)
+		goto after_reset;
+
 	r = amdgpu_mes_detect_and_reset_hung_queues(adev, AMDGPU_RING_TYPE_COMPUTE,
 						    true, &num_hung, adev->gfx.mec.mes_hung_db_array, xcc_id);
 	if (r) {
@@ -2662,6 +2666,7 @@ int amdgpu_gfx_reset_mes_compute(struct amdgpu_device *adev,
 			goto out;
 	}
 
+after_reset:
 	/* MES doesn't detect any hung queue but we have a known bad queue
 	 * and it is not KCQ
 	 */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 86b70748617b..b77cfd8ba907 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -471,11 +471,6 @@ static int reset_queues_mes(struct device_queue_manager *dqm, struct queue *q)
 	if (WARN_ON(dqm->detect_hang_count > 0))
 		return 0;
 
-	if (!amdgpu_gpu_recovery) {
-		r = -ENOTRECOVERABLE;
-		goto fail;
-	}
-
 	memset(&queue_input, 0x0, sizeof(struct mes_remove_queue_input));
 	queue_input.doorbell_offset = q->properties.doorbell_off;
 	queue_input.gang_context_addr = q->gang_ctx_gpu_addr;
@@ -3609,7 +3604,9 @@ int kfd_dqm_suspend_bad_queue_mes(struct kfd_node *knode, u32 pasid, u32 doorbel
 
 		list_for_each_entry(q, &qpd->queues_list, list) {
 			if (q->doorbell_id == doorbell_id && q->properties.is_active) {
-				reset_queues_mes(dqm, q);
+				if (reset_queues_mes(dqm, q))
+					dev_dbg(knode->adev->dev,
+					"Fail to remove bad queue. doorbell_id 0x%x\n", q->doorbell_id);
 				q->properties.is_evicted = true;
 				q->properties.is_active = false;
 				decrement_queue_count(dqm, qpd, q);
-- 
2.43.0

