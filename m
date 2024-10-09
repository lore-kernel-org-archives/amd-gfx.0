Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59DF9CED619
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Oct 2024 07:24:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7EE310E253;
	Wed,  9 Oct 2024 07:24:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tJr7fVQg";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC6CF10E253
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Oct 2024 07:24:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VfdEIPMWgQXchuYm3IR0kMmDhSwCKRtv0u5VzdGyknVY3lY26iCZB7gjUhnBMowspB/OxGQYjaLMdK94ajCMtE6U5OHX1jRGt0SwfDS2G6Br0sRzwdBAATxV/Va+e4QJQduKo+ZsNsW/4z625kEDoZhORbZOIucqUwjMUU4CJxKX8oGKE8TZV4G4Q+BTUr21U2p2B0+TNDjvxvNRcHRdCoMAgGORcNLLUaZeZwVwPTtdNvUHlN+Imuh1KEsaY9IrNObSZbWBOZBlOb7WnijHtetYyMMJcFzMosmiU6daAwPoJJq+iNIvaa1kX9+ZycAxgiLzc6CY5Ahd5UnCOpsxKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FjHDd0clWxB5oJovld9/Rjj6UKDHUkjsBVRpgvbHRsk=;
 b=ggV/sf5IziW8gB1qJbv8ACB5UA7MjkvuEsT1HQmzB0K4g7Hsh1O/XQ5cysi4cRA9gs1Pbeb4/lf+p8qLmTkuBmy084Q2fQ2kh4hU8SCz6pzjuI42iwnlN31Pir3nuFsKd3BTLpymk4LG+evql4rdEJnrNHDccI8mBe6ZwASkeF4y0W0vGXEOwY4UJDvc2SbuzYf+Ktwto+bKAnJBijVevWfHyd7nhuUxRNMNkdKZuG5H+728FXLMyiJ7jbZtWEfnsiItBW8ysoFq8xakMJmNkQGp6B6vD/uQeSJeYP8nZRPwkonLxNvBhXfxkDaN/zXOo99TvtquVrjzgFC+ZWG6Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FjHDd0clWxB5oJovld9/Rjj6UKDHUkjsBVRpgvbHRsk=;
 b=tJr7fVQgJd5+iDB5LKSSINVJd4A176PFBxmllICVz8dILDi1Tn5vc5XFylK4y6HbKVMostuEGBnhRjFDYEVOzPv4VS9f/n4UcLXYYfU9bSkcqWQQWuqEVR7OIEunQqJ55cPPdDobYk2Oa7EUZmWrmOcQucHD8q7VPVVXSwxXi78=
Received: from CH0P221CA0038.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::24)
 by SA0PR12MB7461.namprd12.prod.outlook.com (2603:10b6:806:24b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 07:23:57 +0000
Received: from CH1PEPF0000AD7A.namprd04.prod.outlook.com
 (2603:10b6:610:11d:cafe::d4) by CH0P221CA0038.outlook.office365.com
 (2603:10b6:610:11d::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Wed, 9 Oct 2024 07:23:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7A.mail.protection.outlook.com (10.167.244.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 07:23:57 +0000
Received: from jenkins-jiadong-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 9 Oct 2024 02:23:56 -0500
From: <jiadong.zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <lijo.lazar@amd.com>, Jiadong Zhu
 <Jiadong.Zhu@amd.com>
Subject: [PATCH v3 3/3] drm/amdgpu/sdma4.4.2: implement ring reset callback
 for sdma4.4.2
Date: Wed, 9 Oct 2024 15:22:49 +0800
Message-ID: <20241009072249.546857-3-jiadong.zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241009072249.546857-1-jiadong.zhu@amd.com>
References: <20241009072249.546857-1-jiadong.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7A:EE_|SA0PR12MB7461:EE_
X-MS-Office365-Filtering-Correlation-Id: 3393f0aa-ea11-41c8-985c-08dce83356e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nLmoztuF9wNvciQ3xRTwF4r9O+vqIL3U8oiJXwHZA0eN0c/ie4UaJa56ScYN?=
 =?us-ascii?Q?DmW6FcSav1zV6ajWk+M6zHtZhoNX6NsZIJ/BGyu7U1UM2YaBZXcZ179ZwXA1?=
 =?us-ascii?Q?AS9RmeYTDTEvbXRzT4HeX1G5CCjrgHMShFNyvswR8SuNH0a9kDRaqRpQfDuj?=
 =?us-ascii?Q?e5HZ2AsCuOsMQzHyqxynCOjMqnF5F7tVl8XnmTfqOG0Q3rN86VDBfPM30tid?=
 =?us-ascii?Q?QAct2HQ1XK+w7IqOhiBqtwECLRll4201y2DgwTKEGq5ayvY/wRyrX8dZWwdu?=
 =?us-ascii?Q?5JePQm9dhVZ3Uiszie+qVn0bIwklHNBzV2/15i6XqFDzNzjdBrgfN69EGjie?=
 =?us-ascii?Q?hdZoUx3Fdk2YWODPfr+8ZY+W7EIW3raNrMq+rnRgCBP28dMbvofRtjABeSCh?=
 =?us-ascii?Q?RQjM/mhb4oVQIW1Xtpy79O6ol/PWHCSZKogqqpsK9EQMS+32Mw3FLhO1XuLk?=
 =?us-ascii?Q?K3ypWzhNoyRcPCA6kpvHjYs0d2nUGMwrRC27wAvrT3gwxUhN0nabitbCQOeG?=
 =?us-ascii?Q?MBEnHBaviuh2Oe6nzMVXhmMkGJIfIWu2iXoShCfBqSzrPeKQ14vuALDLQuXp?=
 =?us-ascii?Q?oT20BMrk5qRmQ00cwlFOkDd7XAEdK4zJHtLdVFY/wZKV6+8yqlcyUonXYntp?=
 =?us-ascii?Q?ldYtc3KhwfdQQWKrjnKIA/crz75tj9PnSfYwEJKhb6TSHK8XFdfjscoZGQcS?=
 =?us-ascii?Q?EVaR1EF3C8+36JgqZ/0SwbVKkOPaG0ht/z3g8fg3tC+b28dY4My775dOScg0?=
 =?us-ascii?Q?6tnK05lIowWz3trRXCv50PAHr+RfYcsH4OIW0tpqWy/kejFJ1n6i7hn0qF18?=
 =?us-ascii?Q?lMvBC6zot4sD3HEWYH1I0Ggj8R18PrOoQQBA2gLTRc6m+Ob9I1oaVPqjn+jo?=
 =?us-ascii?Q?a2PZKJfC1UC4sw/AfRQHyuw9fkM5SO3ga24Sdve9DQ3U+bfPRJPUoMSNSnMB?=
 =?us-ascii?Q?T+OM4JM4rLc7wVkQRaFfHVGVopQvTMKe7nLGqUXl3VzJBRSxe9tthceCQ4LP?=
 =?us-ascii?Q?Kqp+rZJepIraIFjvQ5T7K38pDEjxdsUqOBMf/MciHXRpRHFCh75NiI5Yh9zD?=
 =?us-ascii?Q?m+9Id1DHqaCIjsOnRQiXrEWu83C3NHSu2hAlDxVfMqE0FPfRezfmIH4A8Tgq?=
 =?us-ascii?Q?Uobifr+s/of6yzFpZn02bu3oel9I4wrHM3cXBt+hWU6bGhwq7roW+GbsGBD3?=
 =?us-ascii?Q?jvpe3BKNt79HmkgOtOorPUK3Gyg8rKikctYWPwWiJlSzVaEFXmWPLQnyRNuC?=
 =?us-ascii?Q?IF2PgiE3XZhAEgnHIELfB4N4osBJTMwycTna1Psq8M7ADiVRgKddcca7PxGn?=
 =?us-ascii?Q?TaK28rxYBeQ5dhOHLnpASuP7NdihicMPhOeAn/m/fSVSTgJhKtVm2CCIVy8s?=
 =?us-ascii?Q?veFTdAjOhU1l1gvMSlQxtZ3zXSRr?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 07:23:57.7915 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3393f0aa-ea11-41c8-985c-08dce83356e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7461
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

From: Jiadong Zhu <Jiadong.Zhu@amd.com>

Implement sdma queue reset callback via SMU interface.

v2: Leverage inst_stop/start functions in reset sequence.
    Use GET_INST for physical SDMA instance.
    Disable apu for sdma reset.
v3: Rephrase error prints.

Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 97 +++++++++++++++++++-----
 1 file changed, 79 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index c77889040760..9a970a3cb908 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -667,11 +667,12 @@ static uint32_t sdma_v4_4_2_rb_cntl(struct amdgpu_ring *ring, uint32_t rb_cntl)
  *
  * @adev: amdgpu_device pointer
  * @i: instance to resume
+ * @restore: used to restore wptr when restart
  *
  * Set up the gfx DMA ring buffers and enable them.
  * Returns 0 for success, error for failure.
  */
-static void sdma_v4_4_2_gfx_resume(struct amdgpu_device *adev, unsigned int i)
+static void sdma_v4_4_2_gfx_resume(struct amdgpu_device *adev, unsigned int i, bool restore)
 {
 	struct amdgpu_ring *ring = &adev->sdma.instance[i].ring;
 	u32 rb_cntl, ib_cntl, wptr_poll_cntl;
@@ -698,16 +699,24 @@ static void sdma_v4_4_2_gfx_resume(struct amdgpu_device *adev, unsigned int i)
 	WREG32_SDMA(i, regSDMA_GFX_RB_BASE, ring->gpu_addr >> 8);
 	WREG32_SDMA(i, regSDMA_GFX_RB_BASE_HI, ring->gpu_addr >> 40);
 
-	ring->wptr = 0;
+	if (!restore)
+		ring->wptr = 0;
 
 	/* before programing wptr to a less value, need set minor_ptr_update first */
 	WREG32_SDMA(i, regSDMA_GFX_MINOR_PTR_UPDATE, 1);
 
 	/* Initialize the ring buffer's read and write pointers */
-	WREG32_SDMA(i, regSDMA_GFX_RB_RPTR, 0);
-	WREG32_SDMA(i, regSDMA_GFX_RB_RPTR_HI, 0);
-	WREG32_SDMA(i, regSDMA_GFX_RB_WPTR, 0);
-	WREG32_SDMA(i, regSDMA_GFX_RB_WPTR_HI, 0);
+	if (restore) {
+		WREG32_SDMA(i, regSDMA_GFX_RB_RPTR, lower_32_bits(ring->wptr << 2));
+		WREG32_SDMA(i, regSDMA_GFX_RB_RPTR_HI, upper_32_bits(ring->wptr << 2));
+		WREG32_SDMA(i, regSDMA_GFX_RB_WPTR, lower_32_bits(ring->wptr << 2));
+		WREG32_SDMA(i, regSDMA_GFX_RB_WPTR_HI, upper_32_bits(ring->wptr << 2));
+	} else {
+		WREG32_SDMA(i, regSDMA_GFX_RB_RPTR, 0);
+		WREG32_SDMA(i, regSDMA_GFX_RB_RPTR_HI, 0);
+		WREG32_SDMA(i, regSDMA_GFX_RB_WPTR, 0);
+		WREG32_SDMA(i, regSDMA_GFX_RB_WPTR_HI, 0);
+	}
 
 	doorbell = RREG32_SDMA(i, regSDMA_GFX_DOORBELL);
 	doorbell_offset = RREG32_SDMA(i, regSDMA_GFX_DOORBELL_OFFSET);
@@ -759,7 +768,7 @@ static void sdma_v4_4_2_gfx_resume(struct amdgpu_device *adev, unsigned int i)
  * Set up the page DMA ring buffers and enable them.
  * Returns 0 for success, error for failure.
  */
-static void sdma_v4_4_2_page_resume(struct amdgpu_device *adev, unsigned int i)
+static void sdma_v4_4_2_page_resume(struct amdgpu_device *adev, unsigned int i, bool restore)
 {
 	struct amdgpu_ring *ring = &adev->sdma.instance[i].page;
 	u32 rb_cntl, ib_cntl, wptr_poll_cntl;
@@ -775,10 +784,17 @@ static void sdma_v4_4_2_page_resume(struct amdgpu_device *adev, unsigned int i)
 	WREG32_SDMA(i, regSDMA_PAGE_RB_CNTL, rb_cntl);
 
 	/* Initialize the ring buffer's read and write pointers */
-	WREG32_SDMA(i, regSDMA_PAGE_RB_RPTR, 0);
-	WREG32_SDMA(i, regSDMA_PAGE_RB_RPTR_HI, 0);
-	WREG32_SDMA(i, regSDMA_PAGE_RB_WPTR, 0);
-	WREG32_SDMA(i, regSDMA_PAGE_RB_WPTR_HI, 0);
+	if (restore) {
+		WREG32_SDMA(i, regSDMA_GFX_RB_RPTR, lower_32_bits(ring->wptr << 2));
+		WREG32_SDMA(i, regSDMA_GFX_RB_RPTR_HI, upper_32_bits(ring->wptr << 2));
+		WREG32_SDMA(i, regSDMA_GFX_RB_WPTR, lower_32_bits(ring->wptr << 2));
+		WREG32_SDMA(i, regSDMA_GFX_RB_WPTR_HI, upper_32_bits(ring->wptr << 2));
+	} else {
+		WREG32_SDMA(i, regSDMA_PAGE_RB_RPTR, 0);
+		WREG32_SDMA(i, regSDMA_PAGE_RB_RPTR_HI, 0);
+		WREG32_SDMA(i, regSDMA_PAGE_RB_WPTR, 0);
+		WREG32_SDMA(i, regSDMA_PAGE_RB_WPTR_HI, 0);
+	}
 
 	/* set the wb address whether it's enabled or not */
 	WREG32_SDMA(i, regSDMA_PAGE_RB_RPTR_ADDR_HI,
@@ -792,7 +808,8 @@ static void sdma_v4_4_2_page_resume(struct amdgpu_device *adev, unsigned int i)
 	WREG32_SDMA(i, regSDMA_PAGE_RB_BASE, ring->gpu_addr >> 8);
 	WREG32_SDMA(i, regSDMA_PAGE_RB_BASE_HI, ring->gpu_addr >> 40);
 
-	ring->wptr = 0;
+	if (!restore)
+		ring->wptr = 0;
 
 	/* before programing wptr to a less value, need set minor_ptr_update first */
 	WREG32_SDMA(i, regSDMA_PAGE_MINOR_PTR_UPDATE, 1);
@@ -916,7 +933,7 @@ static int sdma_v4_4_2_inst_load_microcode(struct amdgpu_device *adev,
  * Returns 0 for success, error for failure.
  */
 static int sdma_v4_4_2_inst_start(struct amdgpu_device *adev,
-				  uint32_t inst_mask)
+				  uint32_t inst_mask, bool restore)
 {
 	struct amdgpu_ring *ring;
 	uint32_t tmp_mask;
@@ -927,7 +944,7 @@ static int sdma_v4_4_2_inst_start(struct amdgpu_device *adev,
 		sdma_v4_4_2_inst_enable(adev, false, inst_mask);
 	} else {
 		/* bypass sdma microcode loading on Gopher */
-		if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP &&
+		if (!restore && adev->firmware.load_type != AMDGPU_FW_LOAD_PSP &&
 		    adev->sdma.instance[0].fw) {
 			r = sdma_v4_4_2_inst_load_microcode(adev, inst_mask);
 			if (r)
@@ -946,9 +963,9 @@ static int sdma_v4_4_2_inst_start(struct amdgpu_device *adev,
 		uint32_t temp;
 
 		WREG32_SDMA(i, regSDMA_SEM_WAIT_FAIL_TIMER_CNTL, 0);
-		sdma_v4_4_2_gfx_resume(adev, i);
+		sdma_v4_4_2_gfx_resume(adev, i, restore);
 		if (adev->sdma.has_page_queue)
-			sdma_v4_4_2_page_resume(adev, i);
+			sdma_v4_4_2_page_resume(adev, i, restore);
 
 		/* set utc l1 enable flag always to 1 */
 		temp = RREG32_SDMA(i, regSDMA_CNTL);
@@ -1477,7 +1494,7 @@ static int sdma_v4_4_2_hw_init(void *handle)
 	if (!amdgpu_sriov_vf(adev))
 		sdma_v4_4_2_inst_init_golden_registers(adev, inst_mask);
 
-	r = sdma_v4_4_2_inst_start(adev, inst_mask);
+	r = sdma_v4_4_2_inst_start(adev, inst_mask, false);
 
 	return r;
 }
@@ -1566,6 +1583,49 @@ static int sdma_v4_4_2_soft_reset(void *handle)
 	return 0;
 }
 
+static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
+{
+	struct amdgpu_device *adev = ring->adev;
+	int i, r;
+	u32 preempt, inst_mask;
+
+	if ((adev->flags & AMD_IS_APU) || amdgpu_sriov_vf(adev))
+		return -EINVAL;
+
+	/* stop queue */
+	inst_mask = 1 << ring->me;
+	sdma_v4_4_2_inst_gfx_stop(adev, inst_mask);
+	if (adev->sdma.has_page_queue)
+		sdma_v4_4_2_inst_page_stop(adev, inst_mask);
+
+	/* soft reset SDMA_GFX_PREEMPT.IB_PREEMPT = 0*/
+	preempt = RREG32_SDMA(ring->me, regSDMA_GFX_PREEMPT);
+	preempt = REG_SET_FIELD(preempt, SDMA_GFX_PREEMPT, IB_PREEMPT, 0);
+	WREG32_SDMA(ring->me, regSDMA_GFX_PREEMPT, preempt);
+
+	r = amdgpu_dpm_reset_sdma(adev, 1 << GET_INST(SDMA0, ring->me));
+	if (r) {
+		dev_err(adev->dev, "SDMA%d reset failed\n", ring->me);
+		return r;
+	}
+
+	udelay(50);
+
+	for (i = 0; i < adev->usec_timeout; i++) {
+		if (!REG_GET_FIELD(RREG32_SDMA(ring->me, regSDMA_F32_CNTL), SDMA_F32_CNTL, HALT))
+			break;
+		udelay(1);
+	}
+
+	if (i == adev->usec_timeout) {
+		dev_err(adev->dev, "timed out waiting for SDMA%d unhalt after reset\n",
+			ring->me);
+		return -ETIMEDOUT;
+	}
+
+	return sdma_v4_4_2_inst_start(adev, inst_mask, true);
+}
+
 static int sdma_v4_4_2_set_trap_irq_state(struct amdgpu_device *adev,
 					struct amdgpu_irq_src *source,
 					unsigned type,
@@ -1948,6 +2008,7 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_ring_funcs = {
 	.emit_wreg = sdma_v4_4_2_ring_emit_wreg,
 	.emit_reg_wait = sdma_v4_4_2_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = sdma_v4_4_2_reset_queue,
 };
 
 static const struct amdgpu_ring_funcs sdma_v4_4_2_page_ring_funcs = {
@@ -2160,7 +2221,7 @@ static int sdma_v4_4_2_xcp_resume(void *handle, uint32_t inst_mask)
 	if (!amdgpu_sriov_vf(adev))
 		sdma_v4_4_2_inst_init_golden_registers(adev, inst_mask);
 
-	r = sdma_v4_4_2_inst_start(adev, inst_mask);
+	r = sdma_v4_4_2_inst_start(adev, inst_mask, false);
 
 	return r;
 }
-- 
2.25.1

