Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31BFEC282EC
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Mar 2025 14:46:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE50810E08C;
	Mon, 17 Mar 2025 14:46:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nzXftu3T";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 319EF10E08C
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Mar 2025 14:46:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HVPDuzH9WYoQ3aHskCHKepHFuMnJAXsHqHax/6CKAls5tj6knVU2AAyvijbcfbg0HiASIyi4JrmzY9jz1ZdG7rICUErRbghPpNgcmSfRCdnu8vtC+9sOZBIVDnWPMSM0gU4MT06547KpW/luFBWsUcMH0TSgjgJu0IeXxlVYE5tvHGNjIVQAx8ZYsOwHgu97kuQlhF0wpGGSyzVg+ujF6k6XwZtQpwi1q1l05aY+P8c37RgCjkjPQQks91nR2p6YpeNytVChwmzcpg0jf68dZlswGS/x6FI5Jcf1EEPbDvRTdiPm/BQBJ49PzKxvYxXTs5bMHzczmJzbJeabCuvfIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ecel4RFrSsnUI9an6uvlc/B0bGnGFNx+ibvmbuD4EGA=;
 b=HRCMXat1F8AvRzMduMtOpvR7LbPuhWHdREnceVOvOMZCsdZOSmVjfRU6+Fa4cM4+S5SAm8ugvaab6tFy/imEgDUjA7Ci7gCpGUchEFywuCr4wduKVMlef5xS14L+QLzficRfvZIurwCXidGOBdO/g83Nn05sDXDKBK4KAqF3kyX7xwTbppz7TU1+Haz2hrs7BtrCugta8oXZlT5uQ3TQIur2gFf5WnoOXIJr/932V12U/ACkx+ts24jC+v4BpSUH7h8iGxcefLqj/YfSbqpIZ0gDKvwMgjA+R9orjMiJXsAhg9u22vkQ3Ppfu91ucLoM6pnELpz6UjRiO/JtBqSmsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ecel4RFrSsnUI9an6uvlc/B0bGnGFNx+ibvmbuD4EGA=;
 b=nzXftu3TsPHQ0kLEklDH1jz1RaDy1LY3CKfojn695AaGBgtffQ16qL9FaKCjqw2V1hMll+NrcRwXXJXtYcvGhqo7KeEdSHtMdRyBhfqoF0Pj+/Sza8tIv2MffHU/jBFRL0tyqVJ6k89gVazYecaFYaySJxHubtUcWt2hqRNW9Cw=
Received: from BY3PR03CA0029.namprd03.prod.outlook.com (2603:10b6:a03:39a::34)
 by CH1PR12MB9669.namprd12.prod.outlook.com (2603:10b6:610:2af::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 14:46:19 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:39a:cafe::da) by BY3PR03CA0029.outlook.office365.com
 (2603:10b6:a03:39a::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Mon,
 17 Mar 2025 14:46:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 17 Mar 2025 14:46:19 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Mar
 2025 09:46:17 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/sdma: guilty tracking is per instance
Date: Mon, 17 Mar 2025 10:46:03 -0400
Message-ID: <20250317144603.809849-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250317144603.809849-1-alexander.deucher@amd.com>
References: <20250317144603.809849-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|CH1PR12MB9669:EE_
X-MS-Office365-Filtering-Correlation-Id: ce92471e-01ff-4055-3ee5-08dd65627ab4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?k0gdeiw3cxXADkkbJbBq3vx8TdU1YhXGadxrR6yEJEUwi7tqRTtaGvY+x+xP?=
 =?us-ascii?Q?7nbfzPft2W/3DVcSXzV2cw+hwmUYui7LbRwnv7zwD6GxiK1YEPKwpJHrg9H7?=
 =?us-ascii?Q?10ZP3q9uDKy6HM8L+fMoapJeamiw+Lo96LO6WbqdI3NcNR+UifM2aJOHKwnW?=
 =?us-ascii?Q?ls4eIufeSUyJ2yLiu8lYEsffbvUtS+f/IitvJDA+j85M38UvE+m+YKWCtrQG?=
 =?us-ascii?Q?CtfZ9qZTjCOXI2bzI8iPVZkTCrLnXkdGK6vWT0tmlzPzIiU7Ak+9Fvo6Y95o?=
 =?us-ascii?Q?kWmVpplGzZDjmVpFGfoCV7BQ06gfRaf7/IuagKH87CHbW2OqcvNojY5St66d?=
 =?us-ascii?Q?bdYlkw0lJ/x7EzBHfLwuRW/utXaYAlIYJTQYze5oq1a21odLQ7CYIIdOuZtC?=
 =?us-ascii?Q?r2VAbQDwHERvCzclxVLRCFVu7L7D705kDa2mkvA+2d4nlzfTc0IuNXlHtGtK?=
 =?us-ascii?Q?eRJW6E0tpY7u2+zltFg3HYEbU5JSelnq76SM2V0wxGA/nPKjyldtR+xKqFGH?=
 =?us-ascii?Q?UGk4sr7Wqkod0fj9yHfuF3nQ+y12sz0REAEV0vQDyG3EOTTS/fngFGac/4la?=
 =?us-ascii?Q?WssgRqKKkQTGrWNnUYlo8TXGrZHUsA7mN3+OsRxf9yS4D4sfNYz/DrHGxIyD?=
 =?us-ascii?Q?ZsewWJvfO4r5SUAa9Mpg55FFEo95pqzVqCHpr55m58foIzlkiT9aiqEPROLW?=
 =?us-ascii?Q?49hIyDAeQce0X47hYDfrk9KUAuCbmGSYNToDJSBz2s04mznSDoi9evkt2vfn?=
 =?us-ascii?Q?XdFK5KIbFGeFTTS+6xqfI+IGaJVeObnPXOPKy1bjRaQep4WuUGtcmqYtETlo?=
 =?us-ascii?Q?hJit4p3w5ILPx2o8o7XK+JcyGKG95idqy1gyHCyvvMepxOUrOZkaLv+JUeCR?=
 =?us-ascii?Q?cdRtMdIkZZWtsxTmE/57mDVXzhunu8U5RmFvq5RbD3x8bQItYQqPYg4Mu2df?=
 =?us-ascii?Q?vK7ZqnXUDC09aoljw4PAB+PoZZ0/J/3/MCDhMdyOJJ5OxGuXIL9cZiM48mIr?=
 =?us-ascii?Q?vOVlzRS7tfMANCka1EFnYkMiFFNktlacx5IfLJtBO7uJ+elODnWDgPUVhRlQ?=
 =?us-ascii?Q?LdF4p1Bp8H9ckthT+cS3aLwE8WZ4zExCnrh/x7bllZvLUr3u+AyohVQ1+g2b?=
 =?us-ascii?Q?laITvhAbDZLVY413eLeimDyqqTjlLrbmgdqQMvlpyKvcL1vhue+W/ggKcMv/?=
 =?us-ascii?Q?SFHHJ9AHxycQ+TeJbrTJeUx6ij/mqIY05Qj6dxb1gK1Uf4hW977lrEjse1RF?=
 =?us-ascii?Q?IpvX7AXPcoz1WhDpJag2Ke36x7JuvESZW4aA5qsj/kbuGNWmQQ80RBVwhq5A?=
 =?us-ascii?Q?BFfUpA25mSu9w1/ip23Ao04YmnTd+Rcd0m6RMORqfZpRrTzZWCuBz5LjYx/O?=
 =?us-ascii?Q?uBkNOC7uW7bfzBTKChfUyX3Cd8TySgSShv1glqWe6G8tfbzoO5KxQRfBo2uv?=
 =?us-ascii?Q?QWSTaQMW2RCfAlLbyvPUeJqzfvIiYLH4twd0MEXCEsdDeQUcsp9VFZicVPom?=
 =?us-ascii?Q?xoq67t/r+Whpp6w=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 14:46:19.4905 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce92471e-01ff-4055-3ee5-08dd65627ab4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9669
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

The gfx and page queues are per instance, so track them
per instance.

v2: drop extra paramter (Lijo)

Fixes: fdbfaaaae06b ("drm/amdgpu: Improve SDMA reset logic with guilty queue tracking")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  7 +++---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 27 ++++++++++++------------
 2 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index 8e7e794ff136f..dc1a81c2f9af7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -65,6 +65,10 @@ struct amdgpu_sdma_instance {
 	uint64_t		sdma_fw_gpu_addr;
 	uint32_t		*sdma_fw_ptr;
 	struct mutex		engine_reset_mutex;
+	/* track guilty state of GFX and PAGE queues */
+	bool			gfx_guilty;
+	bool			page_guilty;
+
 };
 
 enum amdgpu_sdma_ras_memory_id {
@@ -127,9 +131,6 @@ struct amdgpu_sdma {
 	uint32_t		*ip_dump;
 	uint32_t 		supported_reset;
 	struct list_head	reset_callback_list;
-	/* track guilty state of GFX and PAGE queues */
-	bool gfx_guilty;
-	bool page_guilty;
 };
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 927db7a080f0a..def68f4802089 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -672,12 +672,11 @@ static uint32_t sdma_v4_4_2_rb_cntl(struct amdgpu_ring *ring, uint32_t rb_cntl)
  * @adev: amdgpu_device pointer
  * @i: instance to resume
  * @restore: used to restore wptr when restart
- * @guilty: boolean indicating whether this queue is the guilty one (caused the timeout/error)
  *
  * Set up the gfx DMA ring buffers and enable them.
  * Returns 0 for success, error for failure.
  */
-static void sdma_v4_4_2_gfx_resume(struct amdgpu_device *adev, unsigned int i, bool restore, bool guilty)
+static void sdma_v4_4_2_gfx_resume(struct amdgpu_device *adev, unsigned int i, bool restore)
 {
 	struct amdgpu_ring *ring = &adev->sdma.instance[i].ring;
 	u32 rb_cntl, ib_cntl, wptr_poll_cntl;
@@ -714,7 +713,7 @@ static void sdma_v4_4_2_gfx_resume(struct amdgpu_device *adev, unsigned int i, b
 	/* For the guilty queue, set RPTR to the current wptr to skip bad commands,
 	 * It is not a guilty queue, restore cache_rptr and continue execution.
 	 */
-	if (guilty)
+	if (adev->sdma.instance[i].gfx_guilty)
 		rwptr = ring->wptr;
 	else
 		rwptr = ring->cached_rptr;
@@ -779,12 +778,11 @@ static void sdma_v4_4_2_gfx_resume(struct amdgpu_device *adev, unsigned int i, b
  * @adev: amdgpu_device pointer
  * @i: instance to resume
  * @restore: boolean to say restore needed or not
- * @guilty: boolean indicating whether this queue is the guilty one (caused the timeout/error)
  *
  * Set up the page DMA ring buffers and enable them.
  * Returns 0 for success, error for failure.
  */
-static void sdma_v4_4_2_page_resume(struct amdgpu_device *adev, unsigned int i, bool restore, bool guilty)
+static void sdma_v4_4_2_page_resume(struct amdgpu_device *adev, unsigned int i, bool restore)
 {
 	struct amdgpu_ring *ring = &adev->sdma.instance[i].page;
 	u32 rb_cntl, ib_cntl, wptr_poll_cntl;
@@ -803,7 +801,7 @@ static void sdma_v4_4_2_page_resume(struct amdgpu_device *adev, unsigned int i,
 	/* For the guilty queue, set RPTR to the current wptr to skip bad commands,
 	 * It is not a guilty queue, restore cache_rptr and continue execution.
 	 */
-	if (guilty)
+	if (adev->sdma.instance[i].page_guilty)
 		rwptr = ring->wptr;
 	else
 		rwptr = ring->cached_rptr;
@@ -989,9 +987,9 @@ static int sdma_v4_4_2_inst_start(struct amdgpu_device *adev,
 		uint32_t temp;
 
 		WREG32_SDMA(i, regSDMA_SEM_WAIT_FAIL_TIMER_CNTL, 0);
-		sdma_v4_4_2_gfx_resume(adev, i, restore, adev->sdma.gfx_guilty);
+		sdma_v4_4_2_gfx_resume(adev, i, restore);
 		if (adev->sdma.has_page_queue)
-			sdma_v4_4_2_page_resume(adev, i, restore, adev->sdma.page_guilty);
+			sdma_v4_4_2_page_resume(adev, i, restore);
 
 		/* set utc l1 enable flag always to 1 */
 		temp = RREG32_SDMA(i, regSDMA_CNTL);
@@ -1446,6 +1444,10 @@ static int sdma_v4_4_2_sw_init(struct amdgpu_ip_block *ip_block)
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		mutex_init(&adev->sdma.instance[i].engine_reset_mutex);
+		/* Initialize guilty flags for GFX and PAGE queues */
+		adev->sdma.instance[i].gfx_guilty = false;
+		adev->sdma.instance[i].page_guilty = false;
+
 		ring = &adev->sdma.instance[i].ring;
 		ring->ring_obj = NULL;
 		ring->use_doorbell = true;
@@ -1507,9 +1509,6 @@ static int sdma_v4_4_2_sw_init(struct amdgpu_ip_block *ip_block)
 	r = amdgpu_sdma_sysfs_reset_mask_init(adev);
 	if (r)
 		return r;
-	/* Initialize guilty flags for GFX and PAGE queues */
-	adev->sdma.gfx_guilty = false;
-	adev->sdma.page_guilty = false;
 
 	return r;
 }
@@ -1686,9 +1685,11 @@ static int sdma_v4_4_2_stop_queue(struct amdgpu_device *adev, uint32_t instance_
 		return -EINVAL;
 
 	/* Check if this queue is the guilty one */
-	adev->sdma.gfx_guilty = sdma_v4_4_2_is_queue_selected(adev, instance_id, false);
+	adev->sdma.instance[instance_id].gfx_guilty =
+		sdma_v4_4_2_is_queue_selected(adev, instance_id, false);
 	if (adev->sdma.has_page_queue)
-		adev->sdma.page_guilty = sdma_v4_4_2_is_queue_selected(adev, instance_id, true);
+		adev->sdma.instance[instance_id].page_guilty =
+			sdma_v4_4_2_is_queue_selected(adev, instance_id, true);
 
 	/* Cache the rptr before reset, after the reset,
 	* all of the registers will be reset to 0
-- 
2.48.1

