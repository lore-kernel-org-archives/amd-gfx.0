Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 064F9D1D46A
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 14:49:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58A4810E75B;
	Thu,  8 Jan 2026 14:49:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="leetkNaN";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010057.outbound.protection.outlook.com [52.101.61.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB6AF10E75B
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 14:49:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ojIdWdY9FKXfBNrxVQ4zMbia1f1OKeq7sspFUOBOSUy8MiNBK6CVA3+oUkDdl6IjeBK14l+zvl6UOsGUKTsGjudRamAcY0eHVTEMby6LoImeCXj3pvPZJMrNJIHbu6XCVpQR1liiTgib+kmgVmZneAx4CVEi2QooEcxEEJbj34no10/LSlEaVbSFrVb7w2D5g+lJJziBfdRqrMMkzAJXWOclGpd65HWX7gmEOTQGVAa9yjnHk/LM8aA0NjWdsplzUeMfpJDUPV+Xqs58qV8Yb3aiqYC4skUoEobyh0E4ykcqE5R0e5Da51No4P88dmcP9s4+fJxKX7Tid04HpAtVrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tEChAF3U4+gQtdUgKiEeNq4UFjGY6OllnW0z0S6cl1U=;
 b=wE1IzBG0KDz8wV3WhOe8C0sfIc5X6Eh2wYO6N6rdyg73AZXGx85DwG+03O1NR6j5reov3UUpT0HTT//G/YtVs/b7DIxOPFpv1dxtRcYOHych4xUI8xhlzyyhj12gtkUNeQeusgmHW/p6Ozpj/Qbpp6rfU8EagKdw1zeZz/LDod+QprnAtFR4l+MLF/E260S2G0UV95z76dSRxd8QRjEFLk3N1N5IZM7B7tADI3Ctpzjx/ORwAFUj+MekMYCC06WKut/680hmTx8cU4Vyt/wm+VBmg20SBz2YCWidnnvgF0sK5aaR7pGe2l5OJSjCDAeVt7cxur5FDqKFdNEA4I/INg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tEChAF3U4+gQtdUgKiEeNq4UFjGY6OllnW0z0S6cl1U=;
 b=leetkNaNDn4GmDQuFyf2h8f8r0bTAChaBAk5hZlm8OsTXhq3zRhy5Qx1tQo+3YF6O4b7Q5482j8wub9495gsrpqdZRxJTQ3bcgsMzfcjejjt+9uLMOIJyuAaI4rBrwhDzotbChor6Y3PVHIyyBGjNg62rd84cxqMvaNDw8FZRh4=
Received: from SJ0PR03CA0354.namprd03.prod.outlook.com (2603:10b6:a03:39c::29)
 by DS4PR12MB9588.namprd12.prod.outlook.com (2603:10b6:8:282::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 14:48:53 +0000
Received: from BY1PEPF0001AE16.namprd04.prod.outlook.com
 (2603:10b6:a03:39c:cafe::bf) by SJ0PR03CA0354.outlook.office365.com
 (2603:10b6:a03:39c::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.3 via Frontend Transport; Thu, 8
 Jan 2026 14:48:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BY1PEPF0001AE16.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 14:48:53 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 8 Jan
 2026 08:48:52 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 8 Jan 2026 08:48:52 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 04/42] drm/amdgpu/vpe: switch to using job for IBs
Date: Thu, 8 Jan 2026 09:48:05 -0500
Message-ID: <20260108144843.493816-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108144843.493816-1-alexander.deucher@amd.com>
References: <20260108144843.493816-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE16:EE_|DS4PR12MB9588:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e162511-2a83-4cba-e687-08de4ec50aea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GuhwJyGBfHMKDiENYB1K9ID/SfG3KO501dQDj+aNTUb5ZAbPsoMTJZKCvg9a?=
 =?us-ascii?Q?fFyXGbgCg4WkEeYwtRCfWJW44/Kh2XdafzdgWyJGHbmY2CQ+wPFk1yEiTC/2?=
 =?us-ascii?Q?yg7lJkIgblJf1KgRktorkOdVFisNh4KXoChhBIjlDV6gbpw4y3d5POt1LF2x?=
 =?us-ascii?Q?Pd7loQUfM6qgczBb8ygZ03ef9FuiQLn4Imm7upa2ne7b9cwNk459iN3l9rkW?=
 =?us-ascii?Q?5LqlWYYoXHUNLT6WoI5V611TVPwqBPQJE0XH7fWvp5Mn4ZLOZKluNpd+UmWR?=
 =?us-ascii?Q?lZEcfXNOxvVYC+NK9XD2ZUsBgly3jr+KlFLPDozCbFTXytZ30BkEV4FQxKVQ?=
 =?us-ascii?Q?2gSeQTmyNytXOF/rHHLDkA9lRH2aakTcYo5DQsiFBT7WVLCHgmVX+M+5w01b?=
 =?us-ascii?Q?ftSVZUWC5tG6d71qWGfF+mJFkpAWZv0BFGMTzLgSpnkQRMjAXZFD8uo5m0Z3?=
 =?us-ascii?Q?LqqA0mt/ygeSUMPSqoIWzVnSro/u7fJ3uFAwGlVHcsQ7PjJI52ioupiI0he0?=
 =?us-ascii?Q?1stOkkg58xequZtLTgivUlTYpbG5Xi9oJYdoIBzThRU50Q3AqyYFF9Wx0FoW?=
 =?us-ascii?Q?S1BgkIHG9/RQbvBINZSipIfbuoevbc0/261z6ffkvbCg/wsqt/GXSxtAwT9K?=
 =?us-ascii?Q?L1BmohzdFZ/FqVsOsS9lJdl1QKtNpjpMbNGIxoV2LOp1agAWJdKjFIQ1F+tE?=
 =?us-ascii?Q?14vlBp528LksIRfR2lcoTAmDB/1OvCOPAPbFzF80m87rXXyeZIl9ejw0QrmP?=
 =?us-ascii?Q?8Jk6G9Hx6yd+/rWkqVKV3LgKyxs2A1gBN2bKvzZD1L+NJnr/4pZNJYY8mODS?=
 =?us-ascii?Q?iX7lXDkan696Ml8LS7ISx4dcC2y7bK1+jMzOBbfW9UgDBV3eoD8LQBZvvzi8?=
 =?us-ascii?Q?tkzAnr85le8KKOMWMTY4gY6GnDJGllz9AvUZ4cpuaf3NtPRnvVh0F0sryOLr?=
 =?us-ascii?Q?63RVLmhBedq84GzlHttBF7jZ71NCcp6YExDCtdoFd1n57PvyJxMf+HI2iI8v?=
 =?us-ascii?Q?8NaSldrCphZ0ytxplSzXxekKZX/5VNpxJEF6YW30ZEhtkCint0SPB46FP7FS?=
 =?us-ascii?Q?2d/3rTaXHhLrS3zXJQYGfiOTkY7MmLaEQ8qtbuxg51uclLtDAOnfk0RcrVfC?=
 =?us-ascii?Q?sxaITsB3krEjViTJupLQaFmMZrZWGepP+rsRz19/ne46vdQNLEXuBVqwTDCv?=
 =?us-ascii?Q?hPNDsx6o+AXmt4VSGWRUYKl08IkQlGpKfe03lSPpgTixq8ofT2th1iqErwm8?=
 =?us-ascii?Q?MTg2pgmvaNjQZOa8u7+6YmmhFAGudyjPxpq9+5H51l1W5vMbnaqa5Izku8Jz?=
 =?us-ascii?Q?FcVv2YRwrmN3T1YzISh55TY54FJEV2eFEta+m5YIP7XA5c3C4CeX/0G+M/6P?=
 =?us-ascii?Q?rKH+F9Biwm8s0zxLKt3EoSeYeCffOJPFLKhEGRp73+xRJgGfqxNMe3CBAKQZ?=
 =?us-ascii?Q?kBO6vCikVNVrG5CGlY09S8UtZl4yaZt8Nf3sHshwvwKxQKhgY4/7Wa4RTHMJ?=
 =?us-ascii?Q?Lwye4V/LVPMpR+1/Ka5zCFHapjDVLGw6z7NZMT2YhXFkICjczqWN/r76twun?=
 =?us-ascii?Q?JoJtIR90z1SJOzG3cQo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 14:48:53.0519 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e162511-2a83-4cba-e687-08de4ec50aea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE16.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9588
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c | 37 ++++++++++++++-----------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
index fd881388d6125..9fb1946be1ba2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
@@ -817,7 +817,8 @@ static int vpe_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
 	struct amdgpu_device *adev = ring->adev;
 	const uint32_t test_pattern = 0xdeadbeef;
-	struct amdgpu_ib ib = {};
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
 	uint32_t index;
 	uint64_t wb_addr;
@@ -832,23 +833,28 @@ static int vpe_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	adev->wb.wb[index] = 0;
 	wb_addr = adev->wb.gpu_addr + (index * 4);
 
-	ret = amdgpu_ib_get(adev, NULL, 256, AMDGPU_IB_POOL_DIRECT, &ib);
+	ret = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 256,
+				       AMDGPU_IB_POOL_DIRECT, &job,
+				       AMDGPU_KERNEL_JOB_ID_VPE_RING_TEST);
 	if (ret)
 		goto err0;
-
-	ib.ptr[0] = VPE_CMD_HEADER(VPE_CMD_OPCODE_FENCE, 0);
-	ib.ptr[1] = lower_32_bits(wb_addr);
-	ib.ptr[2] = upper_32_bits(wb_addr);
-	ib.ptr[3] = test_pattern;
-	ib.ptr[4] = VPE_CMD_HEADER(VPE_CMD_OPCODE_NOP, 0);
-	ib.ptr[5] = VPE_CMD_HEADER(VPE_CMD_OPCODE_NOP, 0);
-	ib.ptr[6] = VPE_CMD_HEADER(VPE_CMD_OPCODE_NOP, 0);
-	ib.ptr[7] = VPE_CMD_HEADER(VPE_CMD_OPCODE_NOP, 0);
-	ib.length_dw = 8;
-
-	ret = amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
-	if (ret)
+	ib = &job->ibs[0];
+
+	ib->ptr[0] = VPE_CMD_HEADER(VPE_CMD_OPCODE_FENCE, 0);
+	ib->ptr[1] = lower_32_bits(wb_addr);
+	ib->ptr[2] = upper_32_bits(wb_addr);
+	ib->ptr[3] = test_pattern;
+	ib->ptr[4] = VPE_CMD_HEADER(VPE_CMD_OPCODE_NOP, 0);
+	ib->ptr[5] = VPE_CMD_HEADER(VPE_CMD_OPCODE_NOP, 0);
+	ib->ptr[6] = VPE_CMD_HEADER(VPE_CMD_OPCODE_NOP, 0);
+	ib->ptr[7] = VPE_CMD_HEADER(VPE_CMD_OPCODE_NOP, 0);
+	ib->length_dw = 8;
+
+	ret = amdgpu_job_submit_direct(job, ring, &f);
+	if (ret) {
+		amdgpu_job_free(job);
 		goto err1;
+	}
 
 	ret = dma_fence_wait_timeout(f, false, timeout);
 	if (ret <= 0) {
@@ -859,7 +865,6 @@ static int vpe_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	ret = (le32_to_cpu(adev->wb.wb[index]) == test_pattern) ? 0 : -EINVAL;
 
 err1:
-	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err0:
 	amdgpu_device_wb_free(adev, index);
-- 
2.52.0

