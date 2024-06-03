Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EADBC25B78
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Jun 2024 21:03:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76F9710E3DF;
	Mon,  3 Jun 2024 21:03:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SNhxrqRk";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2069.outbound.protection.outlook.com [40.107.102.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87A8410E3D9
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Jun 2024 21:03:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J5WRZUQyAt82BFUv3K4EGB0uBbmJIELYsiKidiuXb61m9HoktQf/MWmbM4E4MiVY3lBcfE1qgtwwWhaaULgZcoWI538FGoiALZmI8VeJzdWAo86J9z48uwiklVhKPKC58FZ9w0hF+Cnr9AUx2cfCLS1XzJuTCNwE9xMX0HOrdWlWCLAlrvGQC6EZisVgpLXjih5i6ABgx+aVjAJlbE76AQ/WrEDPOiue2VX4ixo/TOxFniyC7nYcaHith1TGq1Nr75aBLiNqT1wRzJzRSHe6FtQw3zEtmLZ3+0ZEamtsGgXREdsSBYpnqFhVzDiUhohrtSaeS73pnygOzHlC+h0Q0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fIXeQz16VswmaDlp9gNmY431rGRUlmjFkxB6e3x/A0E=;
 b=cliQ5ixLo7eP/u6YF8WmByg5POXkO0mX5pxEuwvDY0e9+qcl3eLnga3go0xKzm6xcKsradU6QpYxfoa4IK2DgfYwiWvY+TgLZsU3W1fRx47QqTsqbDZ7VIDVZt1F5b2abVOSFTVYZLIWq9rxeLhokxwuZ0xYj5YB1QUt2eLE/lald5kgARJpiScOZRaEbcflbc96IcEvXIkCR/aF3QYl/VYGivwCgxCnWhCQkbu2YOUOTmDBpEUcNQMBVce3hZ4nMinmrSfN+AJdjko6cOATtH1/j9UxFIEr5L7VZRSakjWllk1sWzgSGAt1Er/DfS7mV7ZLZPyS2TxGM0fUUnlahw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fIXeQz16VswmaDlp9gNmY431rGRUlmjFkxB6e3x/A0E=;
 b=SNhxrqRkK9lcVsHHrvwEqV6ZWz2Ar9lGz0TYa4pIVmt69hYHddOi3YcCfaqUlBXG4IyLHMECDc0BcBp6Xa4CJZA3T/oZ4/h68gicKfTj+VcNGFiYPlI0CNyyI1gYEgkhLfA33mBwn8dMsPhNyRUFQryJjxyA0Pgwm3ghE7+DXYg=
Received: from MN2PR05CA0035.namprd05.prod.outlook.com (2603:10b6:208:c0::48)
 by CH3PR12MB9283.namprd12.prod.outlook.com (2603:10b6:610:1cd::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Mon, 3 Jun
 2024 21:03:21 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:208:c0:cafe::1d) by MN2PR05CA0035.outlook.office365.com
 (2603:10b6:208:c0::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.14 via Frontend
 Transport; Mon, 3 Jun 2024 21:03:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Mon, 3 Jun 2024 21:03:21 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 3 Jun
 2024 16:03:20 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: cleanup MES12 command submission
Date: Mon, 3 Jun 2024 17:02:59 -0400
Message-ID: <20240603210300.31057-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240603210300.31057-1-alexander.deucher@amd.com>
References: <20240603210300.31057-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|CH3PR12MB9283:EE_
X-MS-Office365-Filtering-Correlation-Id: 53d64c4e-3273-4d8e-c3a3-08dc84109993
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|36860700004|376005|82310400017; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RVNWYmdRYWE2UklGODJOeEpMeEROWE02R2laY2lqMUpqUW5sazlJVjFnTCtK?=
 =?utf-8?B?dk9vVkhJcmlRamwrZ0I3UUJTSUh5aC9YWDZra2VKbHpCTVdUVVVmSk5pQ3Fl?=
 =?utf-8?B?N0dNVjI3YkNlVGlkeFdiWHBLc0pkU2J2WDQ3aWJkWE5ubTJVZU9RRFlRYlFw?=
 =?utf-8?B?NGlxcjFDeGVEMHlZSnNPKzdHWU9vTi9jQ3J1ekloRkw4U0s1SVpPN3JQLzZT?=
 =?utf-8?B?MzdYOG9uV0E0cmlIc3hGdnBldkFjZ1VBNG92bDJiUElUZ3J3Z013Y3VHVkZo?=
 =?utf-8?B?RTJDelVIMVFvVWhXcmJBalV5MndJRld2WVZTdHlnTlFiQ0RsQjFPUFEvWW9x?=
 =?utf-8?B?ZWNjaTdTd3VwK3JRb1NnK2E1d3NHdnBwbVBEM0dYeG9tRTVzbDZXaXhRSktp?=
 =?utf-8?B?V1RWRlFEeDk2TkcxYUVxNEFuZGc0NVFuMm84R0IrcExocGNIWU9SdDZ6YXQy?=
 =?utf-8?B?WjVXa1BBNURja3pjTVhSMW4yTXliQ1VVT1lXWEFYcTExZHhoMldrbDJKVE4w?=
 =?utf-8?B?R3cybEZrdk5Fa3FvblhhNXB0YVlpWWZtK3cyaG5EVWxYNi9ZWStZUzIyRGdD?=
 =?utf-8?B?aWRGVC9mcW1TeTJLeDUwQVgvZDRiSTk5eC9zTzU1NW9MQnl0NDJ6bXowdC9p?=
 =?utf-8?B?SEI2REJ6TGR1YXlLOWdkNnErRmVMZ2twTFV0d3lUM3dYTjE1VmE1azIvMXdt?=
 =?utf-8?B?MWxaU1FGaDErZnMwUXFlSFRPYlg2UWVNVXdhT1ByZjE2cjFGN2lzZFZIdHBE?=
 =?utf-8?B?aXpkZk4wSHdvZkFURndFdm1jSHUvZHBycjhDRkFSQnlWUG9XdlA2U241cEha?=
 =?utf-8?B?WU1rYWs1aUtvbEJPSTNWRTNNcjBBdG00emg5ejFiR2M3VHQ1VUVzWVlSOW0x?=
 =?utf-8?B?VWk1d3lMUzA2SE5JdmgzVDVUUlY3djluRWUwV0h3VTdMVUcwQWRCYjRiWC9l?=
 =?utf-8?B?dHdwQ0k0S3Zkd1FuVEZBa2EwMlErWUNCUmFnUVJ5M01TeHNUaE1KVmdFRzZY?=
 =?utf-8?B?L1BFa1F1NkZ5UWZUMUNBdmJzdzhWNDhPblpFVFJXaC92WEJ4Ykk5QlhKcGRR?=
 =?utf-8?B?YnF5RmhTbnUya2VPT2ROQ2JCL2k0WjEyK3VFY1FIVGg2cUlLVG9HRGptUUp5?=
 =?utf-8?B?L0NmYzJkcWhOaWZUYkF1SnczYit3Qy9hVWg0K2NRNHNPbGorbERkSm9nY1Bq?=
 =?utf-8?B?aTgvaUt1SXdCUEFFZmpuL0ZuVERYRHBGVzgvZE5DSVhPdmNIM1hzaU4rMzlY?=
 =?utf-8?B?YWdNRHdtVkxmL2Jsb3RHTkNSVmt0bExJMzlySUVML1JYUW9tWjZ0WWErWXcr?=
 =?utf-8?B?MnUyYVRERng5RlpiUTltQnhMWHhTV0NOaWFOWWlUL0Y1T2FqRkJLV1N3Tmxs?=
 =?utf-8?B?cFU3bmV3L0x3Q3YvQndUdEk0bVUzOHpEUDFmUDNWeGhzMUMrZFRuaWtKTTRv?=
 =?utf-8?B?UURlcVNIQW1vVS9NcVdTT3dRcGVNckczZHFWS0lKaGloS3NCT1NWQ3ZtRlJo?=
 =?utf-8?B?UjRYY0FtSVgrYlNGaXdyN2J1TlZ1dEcraHFNTkFuUC9QWWlLYnFZQ2FxVFZk?=
 =?utf-8?B?Q21hYVpUYlhpTWdxeGJCS21iVjlGT2MzTitOcnpWMzc3dkpkVkVqUFJmUTJE?=
 =?utf-8?B?RmFkREpEbFhJeE02SEhFR1BRN21oS0FEWnhvR3U4WW1CaEFhWDBZcE5Bbmlu?=
 =?utf-8?B?ZGdBYjRuOFE3SkJPbHhMSkdvMmoyc2lrQUlMOFovdTNUMjJNc3JWbTFpU1Zi?=
 =?utf-8?B?NlhWSXQ2NVFTbU1qeForTCtBbUpWNUVTZFZyMzBqeHRmUXlNV0Z1cHIrbC8z?=
 =?utf-8?B?TUVqNVp0Q1c3ekIxUkJBSmI1RWpPbmppTlYybk16LzBKOEttZkFabHE0cm5U?=
 =?utf-8?Q?tJ4ibS2h8Mtwr?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(376005)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 21:03:21.0240 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53d64c4e-3273-4d8e-c3a3-08dc84109993
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9283
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

The approach of having a separate WB slot for each submission doesn't
really work well and for example breaks GPU reset.

Use a status query packet for the fence update instead since those
should always succeed we can use the fence of the original packet to
signal the state of the operation.

While at it cleanup the coding style.

Fixes: ade887c63394 ("drm/amdgpu/mes12: Use a separate fence per transaction")
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 76 ++++++++++++++++----------
 1 file changed, 48 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index f18fdda023c9..106eef1ff5cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -144,18 +144,18 @@ static int mes_v12_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
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
+	struct MES_API_STATUS *api_status;
+	union MESAPI__MISC *x_pkt = pkt;
 	const char *op_str, *misc_op_str;
-	signed long timeout = 3000000; /* 3000 ms */
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
@@ -167,28 +167,38 @@ static int mes_v12_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
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
 
@@ -196,16 +206,17 @@ static int mes_v12_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 	misc_op_str = mes_v12_0_get_misc_op_string(x_pkt);
 
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
+	r = amdgpu_fence_wait_polling(ring, ring->fence_drv.sync_seq, timeout);
+	if (r < 1 || !*status_ptr) {
 
-	if (r < 1) {
 		if (misc_op_str)
 			dev_err(adev->dev, "MES failed to respond to msg=%s (%s)\n",
 				op_str, misc_op_str);
@@ -219,10 +230,19 @@ static int mes_v12_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
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

