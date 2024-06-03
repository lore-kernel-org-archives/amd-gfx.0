Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D932C25B75
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Jun 2024 21:03:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6503B10E3DB;
	Mon,  3 Jun 2024 21:03:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5n51V05W";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF52A10E3DB
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Jun 2024 21:03:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bNyEiZWipyvhf5nve4/f3I9Q6gA26t6KaqmeKEWaCeKjAiAmf9O3wcbmEAm0dELz4ywQ4IxFzH4KUBjRXs5yiDV8gSbY/qMZnebLK+cx0Xk/xP+SN5ObDRvZnbzswvbUBqKPgB4sqGRRA+v4w1Qf6+E8I3TTIbgqHFT+dozpF6eaNpGSTK7Ed6Wpi3dZnvHsPfLPDvL0aM/pZXk5rKMk+gUhJsLqQjaeX5LT4Q7Z24VZGkdVMtxN5/csHhk8wHUJHnuNLauS4Jj1HUg7wCxcPqAVtt+ob/fP9GVa/4OjgdFXAPwiGBqS10+3+Vz66QlVDF75lIw+p36JeimFOqi7xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Hr7BP0qQs5LDRxAT+0zx0RupggO6BUFt4ddP5ZD6S0=;
 b=kQ06kyzy+PbeAFMr5kXkpBwIAq0KXLHGJM2mzQgN/+NYEmEJULPVv96yfLiypUsy+JwTNwpzc3Fwi/op/tJWkR0qK2oOAj0D0K1OaA2VkkYWvssLBPVVZBRy3omNAPM5albsn4h+tIut6Xpeepu8NdkUiE5qa0vev1RQGNXByfBdASnuWGB30Fn5AiIX/YyCKZUrqPAdGC9JQYGOlo/BkEfsQglCiVGKJoWSBzwgRxs4MQt1dl+Qbst29Oa+mhaHIaoCAjfARXMcbaXaYzMPe+SEeGKujS+C7jY5cyY3HGFh8nnIhigjloZn7c05r+iT9SQdwYuoLFUMToGu5NN3kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Hr7BP0qQs5LDRxAT+0zx0RupggO6BUFt4ddP5ZD6S0=;
 b=5n51V05WkdeBizeZbPIy+Q6Rd1tc+p4KAYM1g8fij1JB6SVcu2ae/wmFWlpQK7kd7mmtxPIM8JRmWXKuC942zi/RyA+rY2VO/aBdcwLHQNuk3LO6pIgGHK6JXpOyYAumAmDlR6qpHNpVIanSrAOy6uydVQmGpld6WLsPWjZQpE4=
Received: from MN2PR05CA0025.namprd05.prod.outlook.com (2603:10b6:208:c0::38)
 by SA3PR12MB9199.namprd12.prod.outlook.com (2603:10b6:806:398::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Mon, 3 Jun
 2024 21:03:20 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:208:c0:cafe::42) by MN2PR05CA0025.outlook.office365.com
 (2603:10b6:208:c0::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.13 via Frontend
 Transport; Mon, 3 Jun 2024 21:03:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Mon, 3 Jun 2024 21:03:20 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 3 Jun
 2024 16:03:19 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: cleanup MES11 command submission
Date: Mon, 3 Jun 2024 17:02:58 -0400
Message-ID: <20240603210300.31057-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|SA3PR12MB9199:EE_
X-MS-Office365-Filtering-Correlation-Id: 9755b85b-703a-4d16-3e61-08dc8410992d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|1800799015|82310400017; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?djNaeVUycU1mQ1FzMG82cDlyZWF6TGlkM2Q3WEYzY29Za2gva1BLVXJDdFBl?=
 =?utf-8?B?akhnRmsvNENYZW1EZW9tdFJpTHBGRFkxRUl6bWh2Nmw1OWJHYUs2QUdyNVFm?=
 =?utf-8?B?WFVFQ0hNdEdWa25RZXB2NkhTaVd1L1dMdi9sZ1hyRVI5N01YcDlBbEtTcm9C?=
 =?utf-8?B?TkVCSnk5WjBHS0lHMDBQL1VMd2RQb2RZL3YyRm11czdvL1RKSEdaZzFlQTc0?=
 =?utf-8?B?REtLZzBkMGZWbkpScVREOWU2WTcwc2cxZnBNVlgyeVBBblF1bm8xSE5kbkhx?=
 =?utf-8?B?RjdvbGxCM3J2MnFPMDlQanBoTWhGaVB2NFhLK0RRRmx3UGpURjJxMlVhYU9R?=
 =?utf-8?B?NVQrM2JVdVVZeUlYdUhZZGpEWjNBWk1LSUdXRGtMWmlIamZpL1B0MzNIOXo5?=
 =?utf-8?B?bHBPcXFrc2xsbzdiTjQvZTgzQk1vb3NwZi9yZnRtQVlzYkRuNTFVaXBscllt?=
 =?utf-8?B?VEs2VSthTTFTa2Jzbmp6a0JpY0pRMFppcExuTDJWdDA1STZRSEwrT1dNd3hO?=
 =?utf-8?B?R0dXMmFTQ2hsRjFxTWRHSHpScVVKSzFWYlBGS0RDaDl1aFhvUW9ISGV3QzNH?=
 =?utf-8?B?SlhPMWdodG8zeVJ6cEl6RHdPVEhkd2diYjRDR3VTSHRmK3VYV0hMSUJjRzZl?=
 =?utf-8?B?empUWkxjWmkrL0w3UUt2TC9GOW56SWJldTNhS3lOSm1JdjhFZmRXZ3M0Vmhp?=
 =?utf-8?B?bWhBc1pXcUgxZzNER1ZvUWFrS2hXQi9QSnpQbEFRV2l1NVFoK21FK1g5OXF1?=
 =?utf-8?B?Ky9BNWlFaWJ2YUpDN1hrZ1YzUUdnbFd0VHlGYmx6TTlHVHM4OVg1c1JaZ1VI?=
 =?utf-8?B?bGx5V0pvUzJQbUhYMnkybUpMVC84VUc2Ylhzd0FvaWpiQmFxdTV4dndGemxH?=
 =?utf-8?B?TXdzSWE3T2Q1TjlGeWtaeWFHSENORmlpa2lnZDNGdStvR2VqU2N6V0ZXZVZ4?=
 =?utf-8?B?Rmc3NmxKcU9OYkVnbmljMGJ0bExXSnVYRDdEOGJ5SmVOdTY0YitxOHhUKzFj?=
 =?utf-8?B?ZXptTXdjVjd6dzlPYWhZdXkrTjBFeU5YdUVIQ1NRRnB6alc2R2hwVU9FbThh?=
 =?utf-8?B?Y3RNR3F0bXVFMlFIbWZDR1hSTXhPTTdoT3FOdHdLWWNoR3ZBQ0JiU1h3N0pX?=
 =?utf-8?B?YUtpcVV2ZExTVThUdmhQSzZwVlUyMUNkRzJWQkwvRWlLMEFTWWZQb0N1KzNt?=
 =?utf-8?B?UFFCVC9ySk5JSkRzUGZaS3FHZG1sUkc0QU9BWVBOM2FuTmdUMzZnMDBmWFNv?=
 =?utf-8?B?R3BvQkp2SUVsTHhCYURQOStvTU5pQzRaZENRY25SUGYwamhqQVNIaGIyVDdX?=
 =?utf-8?B?dXh6KzBibEVyZHZ5MjBEc2hIN2lpTE8wR2xFT2dSbDcvbWpxU0FkcU80aXpx?=
 =?utf-8?B?QWQ3UmVBaHkwTnIvZDZBbjh6Q01IZHRQcHljK3o1QTBVOUwrcm1Za1FtQWdB?=
 =?utf-8?B?NkpJTUZqQ3U0VDBFTEFBM25kZjNIZ0RPb0ZZYVgyTnF4dVF6OVB1NVhPV0RW?=
 =?utf-8?B?TTdjVkRDb3k4T1hrMkR2TzhFYkd5bTRJaTV4bGxYaW1jb0RyUWk2Q1JmcUtz?=
 =?utf-8?B?VSs0VCtRWUpaS2RqQXgrYmlpY3YvV0VpdlBuRVpWK0JTM3NuUFh4R1VVMzRx?=
 =?utf-8?B?RVFCS1o0ckVPU3RpcFBEb21vb0xDRm5JRnh3QU5UVk45R3FrTjhSY3JuQjNQ?=
 =?utf-8?B?bWFNQ3VINnQrcG5IamROYjRQeDVtK0F0YURPVjVmVE14MEJXR0k0YUY3elp6?=
 =?utf-8?B?dG1nNzltTEEybDE4Tkh0QjVqZUljVVlyVW9pMVhPVlFRdW9JRlNyTGpQZ3h2?=
 =?utf-8?B?VUduRjZRZ0QvZ2RwcUpCRHdTSG1IbWJPcURITXZYMTYyeFAvWmFGK0dTZjZL?=
 =?utf-8?Q?9eNx5u8N33WE4?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(1800799015)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 21:03:20.3521 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9755b85b-703a-4d16-3e61-08dc8410992d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9199
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

From: Christian König <christian.koenig@amd.com>

The approach of having a separate WB slot for each submission doesn't
really work well and for example breaks GPU reset.

Use a status query packet for the fence update instead since those
should always succeed we can use the fence of the original packet to
signal the state of the operation.

While at it cleanup the coding style.

Fixes: eef016ba8986 ("drm/amdgpu/mes11: Use a separate fence per transaction")
Signed-off-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 76 ++++++++++++++++----------
 1 file changed, 48 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 8263b97c4466..3b1f6ad99100 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -154,18 +154,18 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 						    void *pkt, int size,
 						    int api_status_off)
 {
-	int ndw = size / 4;
-	signed long r;
-	union MESAPI__MISC *x_pkt = pkt;
-	struct MES_API_STATUS *api_status;
+	union MESAPI__QUERY_MES_STATUS mes_status_pkt;
+	signed long timeout = 3000000; /* 3000 ms */
 	struct amdgpu_device *adev = mes->adev;
 	struct amdgpu_ring *ring = &mes->ring;
-	unsigned long flags;
-	signed long timeout = 3000000; /* 3000 ms */
+	struct MES_API_STATUS *api_status;
+	union MESAPI__MISC *x_pkt = pkt;
 	const char *op_str, *misc_op_str;
-	u32 fence_offset;
-	u64 fence_gpu_addr;
-	u64 *fence_ptr;
+	unsigned long flags;
+	u64 status_gpu_addr;
+	u32 status_offset;
+	u64 *status_ptr;
+	signed long r;
 	int ret;
 
 	if (x_pkt->header.opcode >= MES_SCH_API_MAX)
@@ -177,28 +177,38 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 		/* Worst case in sriov where all other 15 VF timeout, each VF needs about 600ms */
 		timeout = 15 * 600 * 1000;
 	}
-	BUG_ON(size % 4 != 0);
 
-	ret = amdgpu_device_wb_get(adev, &fence_offset);
+	ret = amdgpu_device_wb_get(adev, &status_offset);
 	if (ret)
 		return ret;
-	fence_gpu_addr =
-		adev->wb.gpu_addr + (fence_offset * 4);
-	fence_ptr = (u64 *)&adev->wb.wb[fence_offset];
-	*fence_ptr = 0;
+
+	status_gpu_addr = adev->wb.gpu_addr + (status_offset * 4);
+	status_ptr = (u64 *)&adev->wb.wb[status_offset];
+	*status_ptr = 0;
 
 	spin_lock_irqsave(&mes->ring_lock, flags);
-	if (amdgpu_ring_alloc(ring, ndw)) {
-		spin_unlock_irqrestore(&mes->ring_lock, flags);
-		amdgpu_device_wb_free(adev, fence_offset);
-		return -ENOMEM;
-	}
+	r = amdgpu_ring_alloc(ring, (size + sizeof(mes_status_pkt)) / 4);
+	if (r)
+		goto error_unlock_free;
 
 	api_status = (struct MES_API_STATUS *)((char *)pkt + api_status_off);
-	api_status->api_completion_fence_addr = fence_gpu_addr;
+	api_status->api_completion_fence_addr = status_gpu_addr;
 	api_status->api_completion_fence_value = 1;
 
-	amdgpu_ring_write_multiple(ring, pkt, ndw);
+	amdgpu_ring_write_multiple(ring, pkt, size / 4);
+
+	memset(&mes_status_pkt, 0, sizeof(mes_status_pkt));
+	mes_status_pkt.header.type = MES_API_TYPE_SCHEDULER;
+	mes_status_pkt.header.opcode = MES_SCH_API_QUERY_SCHEDULER_STATUS;
+	mes_status_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
+	mes_status_pkt.api_status.api_completion_fence_addr =
+		ring->fence_drv.gpu_addr;
+	mes_status_pkt.api_status.api_completion_fence_value =
+		++ring->fence_drv.sync_seq;
+
+	amdgpu_ring_write_multiple(ring, &mes_status_pkt,
+				   sizeof(mes_status_pkt) / 4);
+
 	amdgpu_ring_commit(ring);
 	spin_unlock_irqrestore(&mes->ring_lock, flags);
 
@@ -206,15 +216,16 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 	misc_op_str = mes_v11_0_get_misc_op_string(x_pkt);
 
 	if (misc_op_str)
-		dev_dbg(adev->dev, "MES msg=%s (%s) was emitted\n", op_str, misc_op_str);
+		dev_dbg(adev->dev, "MES msg=%s (%s) was emitted\n", op_str,
+			misc_op_str);
 	else if (op_str)
 		dev_dbg(adev->dev, "MES msg=%s was emitted\n", op_str);
 	else
-		dev_dbg(adev->dev, "MES msg=%d was emitted\n", x_pkt->header.opcode);
+		dev_dbg(adev->dev, "MES msg=%d was emitted\n",
+			x_pkt->header.opcode);
 
-	r = amdgpu_mes_fence_wait_polling(fence_ptr, (u64)1, timeout);
-	amdgpu_device_wb_free(adev, fence_offset);
-	if (r < 1) {
+	r = amdgpu_fence_wait_polling(ring, ring->fence_drv.sync_seq, timeout);
+	if (r < 1 || !*status_ptr) {
 
 		if (misc_op_str)
 			dev_err(adev->dev, "MES failed to respond to msg=%s (%s)\n",
@@ -229,10 +240,19 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 		while (halt_if_hws_hang)
 			schedule();
 
-		return -ETIMEDOUT;
+		r = -ETIMEDOUT;
+		goto error_wb_free;
 	}
 
+	amdgpu_device_wb_free(adev, status_offset);
 	return 0;
+
+error_unlock_free:
+	spin_unlock_irqrestore(&mes->ring_lock, flags);
+
+error_wb_free:
+	amdgpu_device_wb_free(adev, status_offset);
+	return r;
 }
 
 static int convert_to_mes_queue_type(int queue_type)
-- 
2.45.1

