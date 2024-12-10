Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8CF6E77180
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2024 03:16:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4090D10E376;
	Tue, 10 Dec 2024 03:16:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="p8cZjhE3";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BC3D10E376
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2024 03:16:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZeAW0g/dRFyS7El+JuzJZUYvxi6xRXu8hAYT/Jtx6U+EEKI4m964pYI/5X8mBK39/IyN8o8H4XWeyZjYaA0omfFzKFdQR4zyQZJYObgOmIGXz6Xh2rB0p2pcMPK+CLycTQONwzXzdB90SE6i4x+2a9zwyFDzLWF9lQRDIo6lCM7WV1CdYRYvftE8z5W3gX8gekvqLIm6PstEHn78GbRCeNxokcDFaF7C61p8JB2ZyRNKEhKXyJc4l3Y5if619NIQm85M44ANprJsiC+fM/N7KuyupYF3lSiHMqzyRYD2LpVvz4cdbZjUjVDjXaKFq+Ry6hh2eGJksTQV8CiWG9xGnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dXh3WkOmKpWfrI0V0M6DakDKnWASDuBq4fDTuirnF74=;
 b=ruLg3+j9FLriFiWjU3WBQQMWA9NrTbzQ+1FlJk7ut2zrVEtotnn8i3PDLjAuxu7gUSd106U68UzIU6QmCQT9Xh3CLONOU8qF5TuyIotMsnEraRJ61QySmC7NE1EHGhvc4dzeXvW7CC0UXpNwyg+/ItsFw9Pzh+GkK/0BzgUvQsekZBTRPeomFL5iSOftzJHykRx982xkdoT+RMpg+H82hua+HkZN/Vh6J+HE2n+ZmSb1Dsm26+RC4KCx3DoQJLUw458LktoiCYXgoxZHFHT3tBML9Y+fk/IvEp3VZnW7fp3sxeX6kQmHUVHSqo2EKhx4l79esC+S89F5H72Sl/pgVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXh3WkOmKpWfrI0V0M6DakDKnWASDuBq4fDTuirnF74=;
 b=p8cZjhE3Nd18gPOu/anuGrXyKSd4cpjNtyWRbRjR1lK/JLsh7hBT5vuYIyZKSabdl1NnX1BfmosEegC2ggaPBdqTE3PLswaU3dsSdmtkhHgxqKlFfMaa2kRND/sC/8sQUDGmjkNfgB40phBzGzUDfy6NfjDtkIhBIo46rSp9RII=
Received: from MW4PR04CA0372.namprd04.prod.outlook.com (2603:10b6:303:81::17)
 by SN7PR12MB6814.namprd12.prod.outlook.com (2603:10b6:806:266::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 10 Dec
 2024 03:16:07 +0000
Received: from MWH0EPF000A6735.namprd04.prod.outlook.com
 (2603:10b6:303:81:cafe::e5) by MW4PR04CA0372.outlook.office365.com
 (2603:10b6:303:81::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.12 via Frontend Transport; Tue,
 10 Dec 2024 03:16:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000A6735.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Tue, 10 Dec 2024 03:16:06 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 21:16:05 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 9 Dec 2024 21:16:03 -0600
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jiadong Zhu <Jiadong.Zhu@amd.com>, Prike Liang <Prike.Liang@amd.com>,
 <Tim.Huang@amd.com>, "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
Subject: [PATCH 1/5] drm/amdgpu/sdma7: Implement resume function for each
 instance
Date: Tue, 10 Dec 2024 11:15:58 +0800
Message-ID: <20241210031602.2154914-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6735:EE_|SN7PR12MB6814:EE_
X-MS-Office365-Filtering-Correlation-Id: be8837f2-135b-49a9-365f-08dd18c8fc9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XmWHGYP1cgUWh9A3sKos5B+NR/bVvNj3iQaYPYMcCV59EmM9QKfZ5TK9CAbJ?=
 =?us-ascii?Q?mFt1zLBd0LQXUT260PB3fW6yKezSur8BZF9HU7CtSTqdVryT9jYcrJxg2t9R?=
 =?us-ascii?Q?z7A4n354uwKZHwYXU0diQoPb/7nXNHvVAnFtH7Whkcse4OPaQTe6L77jOMgp?=
 =?us-ascii?Q?kasbeq/1A0sE9R7R3SzGzNkuEnVORucbRsqTWvFerkTL5sJzoujLuYJ9LFzj?=
 =?us-ascii?Q?qQI/VTV9iXLMr2DaaaKNQQL6XY+GXMWKQ6r0D2LOnjrEHV5R8+2c9CUKchvW?=
 =?us-ascii?Q?aduE8QQOEqg9qJfFn19+tUHEqh3ysi6pAE+3qxxC8zRpDnxwPDxWHNbN091E?=
 =?us-ascii?Q?0LXE/IiFYn35mr7ePZB0OCS21YawKSWlio3jeYu9Fn+B8YqdGu+icVDGkh6c?=
 =?us-ascii?Q?AQ43351viw6IFPmzPKvY5zXqRpTYJswuI3YcyjTAXffVM8Q0Di3tQ5NvgAq4?=
 =?us-ascii?Q?OEZI97fdSXkgc5K4QjtQrib4IRFfOXW8uLsCpwu9ZPS3zm/1Fg4tdtRp19yy?=
 =?us-ascii?Q?yv5CsZImKrjUjKKSZY2T3PVjNTnDN/O0+Ny6exb07f5g6gQNiSfZRzxf1ADK?=
 =?us-ascii?Q?TQAzAcnIVz7bXjHZNB5lG/72VJjVq+g0KqBJlfxuW7H91cSnxY2RkjHuYLuY?=
 =?us-ascii?Q?ko4oE9mLIOeCyhqtQ70sGcqmtQ56ZxiglrAmbW3aorzONN2F0av7k7FX1uDB?=
 =?us-ascii?Q?HGrSie8hs29hWfigOQSVGd07EiP2kJeiC48TvmxsHYI5njQJPZvIumnESr1N?=
 =?us-ascii?Q?DZfsc81XCg5jXBNfbuXvGjSJsAprzeZn2lgeKRg/oLfDu4kptkyjVTNDczeN?=
 =?us-ascii?Q?FrNYmrlVQdFXXqDyzvPEzdyuRSEjN7JRB42EB674qE3zpuqj07PDBGYdr7jJ?=
 =?us-ascii?Q?H2LmrMpvrgEibpa2KoRJynZ9JLElWu9uwQgpagbj3Xeds6Ex22Djfif/cWCr?=
 =?us-ascii?Q?/GnEr0iXTVxZwNebKjZGq+sHW8bdECAbWDu8yfkGuEFABDnSsWcoke8HKOCG?=
 =?us-ascii?Q?Qai3FGr+iTG+nko4gaAn72uyPTU90ZvrG2MNJ1VWtUTdAWiis7uSbrcsCHS+?=
 =?us-ascii?Q?sVZdFMTqz5mjKr/1+Iq337simOxZQ+17DfLEToUGOiiNOSzaVA2Uz81B26G/?=
 =?us-ascii?Q?PlfjXy1XIqRr01xmyxDKYgAdMbgDaUZ6jwwPS9gW4zkLMVlTvItSsCkNvXhV?=
 =?us-ascii?Q?KZkuWnvFVG6VKor9uqkTdhYcRATt7zproaqRTbzZnHf/OHhQMgSbH3ahobnw?=
 =?us-ascii?Q?9r/PFViGd5z9Q3sJAzMPWsxrI31CKBiyWfs0H5FYAAl36QK9gUHVpoa80IYu?=
 =?us-ascii?Q?nLu35rwj7/qji6maTaZrgQO+30zQZ2WJrxwipHKsNxgGcVt7BckSDaPy1+nn?=
 =?us-ascii?Q?xXZ7ANOTwKF7ErOOdREkAVyj7UoQR8bFzbLaTesEWUsgipJT7PAr+4WijOGA?=
 =?us-ascii?Q?pU5aIpuUkayuU9cJu11khw3V5X/le0W3?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 03:16:06.5447 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be8837f2-135b-49a9-365f-08dd18c8fc9d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6735.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6814
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

Extracts the resume sequence for per sdma instance from sdma_v7_0_gfx_resume.
This function can be used in start or restart scenarios of specific instances.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 259 ++++++++++++++-----------
 1 file changed, 141 insertions(+), 118 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 10ddf2c9e1fd..8cc8eaff0680 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -491,162 +491,185 @@ static void sdma_v7_0_enable(struct amdgpu_device *adev, bool enable)
 }
 
 /**
- * sdma_v7_0_gfx_resume - setup and start the async dma engines
+ * sdma_v7_0_gfx_resume_instance - start/restart a certain sdma engine
  *
  * @adev: amdgpu_device pointer
+ * @i: instance
+ * @restore: used to restore wptr when restart
  *
- * Set up the gfx DMA ring buffers and enable them.
- * Returns 0 for success, error for failure.
+ * Set up the gfx DMA ring buffers and enable them. On restart, we will restore wptr and rptr.
+ * Return 0 for success.
  */
-static int sdma_v7_0_gfx_resume(struct amdgpu_device *adev)
+static int sdma_v7_0_gfx_resume_instance(struct amdgpu_device *adev, int i, bool restore)
 {
 	struct amdgpu_ring *ring;
 	u32 rb_cntl, ib_cntl;
 	u32 rb_bufsz;
 	u32 doorbell;
 	u32 doorbell_offset;
-	u32 tmp;
+	u32 temp;
 	u64 wptr_gpu_addr;
-	int i, r;
-
-	for (i = 0; i < adev->sdma.num_instances; i++) {
-		ring = &adev->sdma.instance[i].ring;
+	int r;
 
-		//if (!amdgpu_sriov_vf(adev))
-		//	WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_SEM_WAIT_FAIL_TIMER_CNTL), 0);
+	ring = &adev->sdma.instance[i].ring;
 
-		/* Set ring buffer size in dwords */
-		rb_bufsz = order_base_2(ring->ring_size / 4);
-		rb_cntl = RREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_CNTL));
-		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, RB_SIZE, rb_bufsz);
+	/* Set ring buffer size in dwords */
+	rb_bufsz = order_base_2(ring->ring_size / 4);
+	rb_cntl = RREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_CNTL));
+	rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, RB_SIZE, rb_bufsz);
 #ifdef __BIG_ENDIAN
-		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, RB_SWAP_ENABLE, 1);
-		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL,
-					RPTR_WRITEBACK_SWAP_ENABLE, 1);
+	rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, RB_SWAP_ENABLE, 1);
+	rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL,
+				RPTR_WRITEBACK_SWAP_ENABLE, 1);
 #endif
-		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, RB_PRIV, 1);
-		WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_CNTL), rb_cntl);
-
-		/* Initialize the ring buffer's read and write pointers */
+	rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, RB_PRIV, 1);
+	WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_CNTL), rb_cntl);
+
+	/* Initialize the ring buffer's read and write pointers */
+	if (restore) {
+		WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_RPTR), lower_32_bits(ring->wptr << 2));
+		WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_RPTR_HI), upper_32_bits(ring->wptr << 2));
+		WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_WPTR), lower_32_bits(ring->wptr << 2));
+		WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_WPTR_HI), upper_32_bits(ring->wptr << 2));
+	} else {
 		WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_RPTR), 0);
 		WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_RPTR_HI), 0);
 		WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_WPTR), 0);
 		WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_WPTR_HI), 0);
+	}
+	/* setup the wptr shadow polling */
+	wptr_gpu_addr = ring->wptr_gpu_addr;
+	WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_WPTR_POLL_ADDR_LO),
+	       lower_32_bits(wptr_gpu_addr));
+	WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_WPTR_POLL_ADDR_HI),
+	       upper_32_bits(wptr_gpu_addr));
+
+	/* set the wb address whether it's enabled or not */
+	WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_RPTR_ADDR_HI),
+	       upper_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFF);
+	WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_RPTR_ADDR_LO),
+	       lower_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFC);
+
+	rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, RPTR_WRITEBACK_ENABLE, 1);
+	if (amdgpu_sriov_vf(adev))
+		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, WPTR_POLL_ENABLE, 1);
+	else
+		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, WPTR_POLL_ENABLE, 0);
 
-		/* setup the wptr shadow polling */
-		wptr_gpu_addr = ring->wptr_gpu_addr;
-		WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_WPTR_POLL_ADDR_LO),
-		       lower_32_bits(wptr_gpu_addr));
-		WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_WPTR_POLL_ADDR_HI),
-		       upper_32_bits(wptr_gpu_addr));
-
-		/* set the wb address whether it's enabled or not */
-		WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_RPTR_ADDR_HI),
-		       upper_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFF);
-		WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_RPTR_ADDR_LO),
-		       lower_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFC);
-
-		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, RPTR_WRITEBACK_ENABLE, 1);
-		if (amdgpu_sriov_vf(adev))
-			rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, WPTR_POLL_ENABLE, 1);
-		else
-			rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, WPTR_POLL_ENABLE, 0);
-		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, MCU_WPTR_POLL_ENABLE, 1);
+	rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, MCU_WPTR_POLL_ENABLE, 1);
 
-		WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_BASE), ring->gpu_addr >> 8);
-		WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_BASE_HI), ring->gpu_addr >> 40);
+	WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_BASE), ring->gpu_addr >> 8);
+	WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_BASE_HI), ring->gpu_addr >> 40);
 
+	if (!restore)
 		ring->wptr = 0;
 
-		/* before programing wptr to a less value, need set minor_ptr_update first */
-		WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_MINOR_PTR_UPDATE), 1);
+	/* before programing wptr to a less value, need set minor_ptr_update first */
+	WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_MINOR_PTR_UPDATE), 1);
 
-		if (!amdgpu_sriov_vf(adev)) { /* only bare-metal use register write for wptr */
-			WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_WPTR), lower_32_bits(ring->wptr) << 2);
-			WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_WPTR_HI), upper_32_bits(ring->wptr) << 2);
-		}
+	if (!amdgpu_sriov_vf(adev)) { /* only bare-metal use register write for wptr */
+		WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_WPTR), lower_32_bits(ring->wptr) << 2);
+		WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_WPTR_HI), upper_32_bits(ring->wptr) << 2);
+	}
 
-		doorbell = RREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_DOORBELL));
-		doorbell_offset = RREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_DOORBELL_OFFSET));
+	doorbell = RREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_DOORBELL));
+	doorbell_offset = RREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_DOORBELL_OFFSET));
 
-		if (ring->use_doorbell) {
-			doorbell = REG_SET_FIELD(doorbell, SDMA0_QUEUE0_DOORBELL, ENABLE, 1);
-			doorbell_offset = REG_SET_FIELD(doorbell_offset, SDMA0_QUEUE0_DOORBELL_OFFSET,
-					OFFSET, ring->doorbell_index);
-		} else {
-			doorbell = REG_SET_FIELD(doorbell, SDMA0_QUEUE0_DOORBELL, ENABLE, 0);
-		}
-		WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_DOORBELL), doorbell);
-		WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_DOORBELL_OFFSET), doorbell_offset);
-
-		if (i == 0)
-			adev->nbio.funcs->sdma_doorbell_range(adev, i, ring->use_doorbell,
-						      ring->doorbell_index,
-						      adev->doorbell_index.sdma_doorbell_range * adev->sdma.num_instances);
-
-		if (amdgpu_sriov_vf(adev))
-			sdma_v7_0_ring_set_wptr(ring);
-
-		/* set minor_ptr_update to 0 after wptr programed */
-		WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_MINOR_PTR_UPDATE), 0);
-
-		/* Set up sdma hang watchdog */
-		tmp = RREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_WATCHDOG_CNTL));
-		/* 100ms per unit */
-		tmp = REG_SET_FIELD(tmp, SDMA0_WATCHDOG_CNTL, QUEUE_HANG_COUNT,
-				    max(adev->usec_timeout/100000, 1));
-		WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_WATCHDOG_CNTL), tmp);
-
-		/* Set up RESP_MODE to non-copy addresses */
-		tmp = RREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_UTCL1_CNTL));
-		tmp = REG_SET_FIELD(tmp, SDMA0_UTCL1_CNTL, RESP_MODE, 3);
-		tmp = REG_SET_FIELD(tmp, SDMA0_UTCL1_CNTL, REDO_DELAY, 9);
-		WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_UTCL1_CNTL), tmp);
-
-		/* program default cache read and write policy */
-		tmp = RREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_UTCL1_PAGE));
-		/* clean read policy and write policy bits */
-		tmp &= 0xFF0FFF;
-		tmp |= ((CACHE_READ_POLICY_L2__DEFAULT << 12) |
-			 (CACHE_WRITE_POLICY_L2__DEFAULT << 14));
-		WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_UTCL1_PAGE), tmp);
-
-		if (!amdgpu_sriov_vf(adev)) {
-			/* unhalt engine */
-			tmp = RREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_MCU_CNTL));
-			tmp = REG_SET_FIELD(tmp, SDMA0_MCU_CNTL, HALT, 0);
-			tmp = REG_SET_FIELD(tmp, SDMA0_MCU_CNTL, RESET, 0);
-			WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_MCU_CNTL), tmp);
-		}
+	if (ring->use_doorbell) {
+		doorbell = REG_SET_FIELD(doorbell, SDMA0_QUEUE0_DOORBELL, ENABLE, 1);
+		doorbell_offset = REG_SET_FIELD(doorbell_offset, SDMA0_QUEUE0_DOORBELL_OFFSET,
+				OFFSET, ring->doorbell_index);
+	} else {
+		doorbell = REG_SET_FIELD(doorbell, SDMA0_QUEUE0_DOORBELL, ENABLE, 0);
+	}
+	WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_DOORBELL), doorbell);
+	WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_DOORBELL_OFFSET), doorbell_offset);
 
-		/* enable DMA RB */
-		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, RB_ENABLE, 1);
-		WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_CNTL), rb_cntl);
+	if (i == 0)
+		adev->nbio.funcs->sdma_doorbell_range(adev, i, ring->use_doorbell,
+					      ring->doorbell_index,
+					      adev->doorbell_index.sdma_doorbell_range * adev->sdma.num_instances);
 
-		ib_cntl = RREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_IB_CNTL));
-		ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_QUEUE0_IB_CNTL, IB_ENABLE, 1);
+	if (amdgpu_sriov_vf(adev))
+		sdma_v7_0_ring_set_wptr(ring);
+
+	/* set minor_ptr_update to 0 after wptr programed */
+	WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_MINOR_PTR_UPDATE), 0);
+
+	/* Set up sdma hang watchdog */
+	temp = RREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_WATCHDOG_CNTL));
+	/* 100ms per unit */
+	temp = REG_SET_FIELD(temp, SDMA0_WATCHDOG_CNTL, QUEUE_HANG_COUNT,
+			     max(adev->usec_timeout/100000, 1));
+	WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_WATCHDOG_CNTL), temp);
+
+	/* Set up RESP_MODE to non-copy addresses */
+	temp = RREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_UTCL1_CNTL));
+	temp = REG_SET_FIELD(temp, SDMA0_UTCL1_CNTL, RESP_MODE, 3);
+	temp = REG_SET_FIELD(temp, SDMA0_UTCL1_CNTL, REDO_DELAY, 9);
+	WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_UTCL1_CNTL), temp);
+
+	/* program default cache read and write policy */
+	temp = RREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_UTCL1_PAGE));
+	/* clean read policy and write policy bits */
+	temp &= 0xFF0FFF;
+	temp |= ((CACHE_READ_POLICY_L2__DEFAULT << 12) |
+		 (CACHE_WRITE_POLICY_L2__DEFAULT << 14));
+	WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_UTCL1_PAGE), temp);
+
+	if (!amdgpu_sriov_vf(adev)) {
+		/* unhalt engine */
+		temp = RREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_MCU_CNTL));
+		temp = REG_SET_FIELD(temp, SDMA0_MCU_CNTL, HALT, 0);
+		temp = REG_SET_FIELD(temp, SDMA0_MCU_CNTL, RESET, 0);
+		WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_MCU_CNTL), temp);
+	}
+
+	/* enable DMA RB */
+	rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, RB_ENABLE, 1);
+	WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_CNTL), rb_cntl);
+
+	ib_cntl = RREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_IB_CNTL));
+	ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_QUEUE0_IB_CNTL, IB_ENABLE, 1);
 #ifdef __BIG_ENDIAN
-		ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_QUEUE0_IB_CNTL, IB_SWAP_ENABLE, 1);
+	ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_QUEUE0_IB_CNTL, IB_SWAP_ENABLE, 1);
 #endif
-		/* enable DMA IBs */
-		WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_IB_CNTL), ib_cntl);
+	/* enable DMA IBs */
+	WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_IB_CNTL), ib_cntl);
+	ring->sched.ready = true;
 
-		ring->sched.ready = true;
+	if (amdgpu_sriov_vf(adev)) { /* bare-metal sequence doesn't need below to lines */
+		sdma_v7_0_ctx_switch_enable(adev, true);
+		sdma_v7_0_enable(adev, true);
+	}
 
-		if (amdgpu_sriov_vf(adev)) { /* bare-metal sequence doesn't need below to lines */
-			sdma_v7_0_ctx_switch_enable(adev, true);
-			sdma_v7_0_enable(adev, true);
-		}
+	r = amdgpu_ring_test_helper(ring);
+	if (r)
+		ring->sched.ready = false;
 
-		r = amdgpu_ring_test_helper(ring);
-		if (r) {
-			ring->sched.ready = false;
-			return r;
-		}
+	return r;
+}
 
+/**
+ * sdma_v7_0_gfx_resume - setup and start the async dma engines
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Set up the gfx DMA ring buffers and enable them.
+ * Returns 0 for success, error for failure.
+ */
+static int sdma_v7_0_gfx_resume(struct amdgpu_device *adev)
+{
+	int i, r;
+
+	for (i = 0; i < adev->sdma.num_instances; i++) {
+		r = sdma_v7_0_gfx_resume_instance(adev, i, false);
+		if (r)
+			return r;
 	}
 
 	return 0;
+
 }
 
 /**
-- 
2.25.1

