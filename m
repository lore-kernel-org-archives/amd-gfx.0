Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2709D38FED
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jan 2026 16:48:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C80F10E654;
	Wed, 14 Jan 2026 16:48:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="my70Ycun";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013035.outbound.protection.outlook.com
 [40.93.201.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A97F10E64E
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 16:48:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XR5RlW9xqSLXbF9iDoadTOlaibbGUqYx9fcdInhmTkzggqYeUTOuF7o47ufxNLQep9OfnNMUVG2XTsHKjEGfpGqFaXLtohcOP8tlPyvyIUdGoOvl7O+QhOubH77HTE0fJcCYhf754UQngOdVuBlLI0jgGVrstKRofDravYZWDe1uUDfsJyML6t43QA8oXg0mvhZrkKPYNESvzxU9GMw4W2rx9+M9BXJFUfGpLe3Na9Wfs+GlIIQWp5JQB+3GZ1WEb5RgFl8xhhmHT6Dncvp1aUAOO3h+whOrZr+RWJ2PsBh1s07o9JVhetWOrbzj0E3wWSVNqFDjpEag1eqQIYFhMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GiDtZYjOGSj5/xkxK7r3T40Tq927c98955ls+J80WWA=;
 b=yg0k6d3nrGVU2ABvVsibFi8527Wb4okmCMv0BO2Gp/1K8mOQkZCK7TP8MlnETet1K+WLWQeftYulhboEjSoNyMLQlvteqK8Uv0bWoQ31SAN13O5m4uuoU4dtyshDhmJMoqqdD7D4B8HKIF2FyPixSgEhgJwUa14UXgxvZBzFFZ9PIbPGEZy2euviRMqctLXpgTSsbSzuRcNc5ocLi2Q5rNeZ0QsZzofS2XHPErP8mwthn0ai6QjLoTI5k9eIJEhOMDjosG9lq2dkZruXpBsd2uI4/YWXShv7g26eJ4I5ZMZm7DU9nm/yXF24PkzA+tuGHsM1o2X7k/LxuQQfaPbGZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GiDtZYjOGSj5/xkxK7r3T40Tq927c98955ls+J80WWA=;
 b=my70YcunlQk5Ar6EvwwAGD6TP2Tom6HCystE5Gr678s8Ufuk3D7xPHoBzB3LTWSiS23x7EbA8PAgBy793s45tIT0mcq9qzvtJu7eDBkiJQfW3tBNtLGPZ8eQTraxLZ4wG76yYIuTteyX6qwiZROw4O76GMihUgP7zIL4BiKlgjU=
Received: from MN2PR18CA0028.namprd18.prod.outlook.com (2603:10b6:208:23c::33)
 by PH8PR12MB6892.namprd12.prod.outlook.com (2603:10b6:510:1bc::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 16:48:05 +0000
Received: from BL02EPF00021F6B.namprd02.prod.outlook.com
 (2603:10b6:208:23c:cafe::2c) by MN2PR18CA0028.outlook.office365.com
 (2603:10b6:208:23c::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Wed,
 14 Jan 2026 16:48:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6B.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 16:48:05 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 14 Jan
 2026 10:47:43 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 Jan
 2026 10:47:42 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 14 Jan 2026 10:47:42 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 14/42] drm/amdgpu/cik_sdma: switch to using job for IBs
Date: Wed, 14 Jan 2026 11:46:59 -0500
Message-ID: <20260114164727.15367-15-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114164727.15367-1-alexander.deucher@amd.com>
References: <20260114164727.15367-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6B:EE_|PH8PR12MB6892:EE_
X-MS-Office365-Filtering-Correlation-Id: 1024a814-3f48-464e-5f6a-08de538cb058
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/bZAFP+8Br/qo1NAX3DiNK3iq7Z6Rbz89MChPKQt5idwnkUazKMzTf/p6lDj?=
 =?us-ascii?Q?M1fRx3e0eURFBB7gNhP3V9J1TEMqoU3VnF780VjOnVjGp/P635H1kZR6r4mE?=
 =?us-ascii?Q?Dp2PWlXiVjjWXHW9aiuEAvUMntRiheWswhHSARNPswJbAHYgBOL0662olDWX?=
 =?us-ascii?Q?TD+f4uHuGEbgx4oYPhfxaXKp4JWf9X+GAqdl+wGPOU6xJkZTIyPxl0aiTkbL?=
 =?us-ascii?Q?iF8fJtC8W3EMbeDYX72MOFHOErpgbxKP6RwwTMRRuf/+uzqHzE1YXPMz/8aL?=
 =?us-ascii?Q?UAH2KqpDNG5FuF8HUp4d4nWrlPJXxffoHFc2Ixh6CTPIfnTUZtc8mSnme5j0?=
 =?us-ascii?Q?2+9+eJg5LOqE3Qr44uppe4TkFFpVXA2J6uT5YvVwES6tsn9rsi90AKeDSs9V?=
 =?us-ascii?Q?p/upgykOpH8Fgwh5c2v75DtkPp106Wllf9cWdlfGUEApaN6b+Elfvg5To3hQ?=
 =?us-ascii?Q?qReDJqougrVpAJzBED2hzCzc/mSr12wDkBBlulU1wNDZKVimCavD4VOs3xZy?=
 =?us-ascii?Q?fvGtZX3+d3KQ9Ie7RbSAytrRlOfQCI7VkrG/aEeYE7EfasmSMfhEzw1UTk4j?=
 =?us-ascii?Q?Pj+Yyc70y4FH2wOZspTAmic8zLmOMfu7f1+n9axjSJ3hXbTimN4xF9/gbO2B?=
 =?us-ascii?Q?TciR3EaFLzhhqhauEIKg10oyLyYlNAsdsc+XB0n1SbmbT/fFDtqukSrxPk4K?=
 =?us-ascii?Q?moA5hDPCXKGP5mqusGeWHSzscFLbBI1HN6EnbGWSyDvDoaq58uhY5Qom6Cr2?=
 =?us-ascii?Q?TLn7wXMctpLVDb5wQTCnJ2+HxcXt9JLGXczPeaGJm0PhYdhIDTukl3z1N/XU?=
 =?us-ascii?Q?jPwbC1u6MvkTx98SwhMAoBD1TKJVpkOe6Oi49KmP0MN+YZqInvqVjjZT7zzO?=
 =?us-ascii?Q?p4k63ApfLJbaaOmsolH9mphK7QhviIze8UxxkeVDOx9ivWGMg4YyINGn9KqV?=
 =?us-ascii?Q?9v/2/RbAbhHRzY4CtjXHWfEVIIHK2PdHj1O7/QhgZBJYD3SZVKneohhrkjC3?=
 =?us-ascii?Q?sSbWlse/0H+rednD8BdWrkKC0LwpC86AF9ed+/KXQ47ddfOK/z4PTOtTS9mb?=
 =?us-ascii?Q?Om+VL9wgSQqpOJ4kcUBF3fBHmH0eaQy42RO2O7WQfiUTymlI2NryapqoO9Hg?=
 =?us-ascii?Q?Lsb9Ktgi5M9BHfEVZLe1BtVBdS8ptk5sj2il9DreZ3dxScrQz3b5V+aZqltK?=
 =?us-ascii?Q?RdqUW1EPA1auUbqsIPBs6BWGAk5ia/IYLWo0W7NtwfJBv1s/fgE2XFXM0JzW?=
 =?us-ascii?Q?zkBh/EE007S8cMC+7Qx1++1qb0VWyg3nTEGbNbGtv//bf110nO3n5FdMucT9?=
 =?us-ascii?Q?p4H4r6+kNvy2/nzbS3l81yoftgmcnsZE3T0pdDn3TbaCBxLgFfzz7IEOo6nF?=
 =?us-ascii?Q?flUqGw8j7SgEvLBFNXsfZmM8SCzEgQKYk5+Dmu3lei9xiKwiumz0M50BZ/+s?=
 =?us-ascii?Q?vIM2JCv7j/l7m5DYdTBlrhGUmPnu/k76Mqv5ezXjZYyvd+iGk3tfUo5pos8/?=
 =?us-ascii?Q?oPllnU2IK22BD+K6UC1SQsESXy0TtT6QLwYWngDSGAd5+BcnBczPG6TqjN8j?=
 =?us-ascii?Q?Xuu5JyvTMgPRbdVqp42o0QQZohOMgHrgpFnSNg3oCBhf3a6oYWNh0zQjquev?=
 =?us-ascii?Q?Kjoxd3AdXgD0H7mb4dWOqMkpLUiKkrtS7qiiWNnmQU16XmGRekje8j0611eU?=
 =?us-ascii?Q?sijE2Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 16:48:05.1861 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1024a814-3f48-464e-5f6a-08de538cb058
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6892
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

Switch to using a job structure for IBs.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c | 31 ++++++++++++++++-----------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
index 9e8715b4739da..e2ca96f5a7cfb 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
@@ -652,7 +652,8 @@ static int cik_sdma_ring_test_ring(struct amdgpu_ring *ring)
 static int cik_sdma_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_ib ib;
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
 	unsigned index;
 	u32 tmp = 0;
@@ -666,22 +667,27 @@ static int cik_sdma_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	gpu_addr = adev->wb.gpu_addr + (index * 4);
 	tmp = 0xCAFEDEAD;
 	adev->wb.wb[index] = cpu_to_le32(tmp);
-	memset(&ib, 0, sizeof(ib));
-	r = amdgpu_ib_get(adev, NULL, 256,
-					AMDGPU_IB_POOL_DIRECT, &ib);
+
+	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 256,
+				     AMDGPU_IB_POOL_DIRECT, &job,
+				     AMDGPU_KERNEL_JOB_ID_SDMA_RING_TEST);
 	if (r)
 		goto err0;
+	ib = &job->ibs[0];
 
-	ib.ptr[0] = SDMA_PACKET(SDMA_OPCODE_WRITE,
+	ib->ptr[0] = SDMA_PACKET(SDMA_OPCODE_WRITE,
 				SDMA_WRITE_SUB_OPCODE_LINEAR, 0);
-	ib.ptr[1] = lower_32_bits(gpu_addr);
-	ib.ptr[2] = upper_32_bits(gpu_addr);
-	ib.ptr[3] = 1;
-	ib.ptr[4] = 0xDEADBEEF;
-	ib.length_dw = 5;
-	r = amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
-	if (r)
+	ib->ptr[1] = lower_32_bits(gpu_addr);
+	ib->ptr[2] = upper_32_bits(gpu_addr);
+	ib->ptr[3] = 1;
+	ib->ptr[4] = 0xDEADBEEF;
+	ib->length_dw = 5;
+
+	r = amdgpu_job_submit_direct(job, ring, &f);
+	if (r) {
+		amdgpu_job_free(job);
 		goto err1;
+	}
 
 	r = dma_fence_wait_timeout(f, false, timeout);
 	if (r == 0) {
@@ -697,7 +703,6 @@ static int cik_sdma_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 		r = -EINVAL;
 
 err1:
-	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err0:
 	amdgpu_device_wb_free(adev, index);
-- 
2.52.0

