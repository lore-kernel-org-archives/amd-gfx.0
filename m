Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CAB5CF043C
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Oct 2024 03:46:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EB4610E636;
	Wed,  9 Oct 2024 03:46:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UtQL8tAZ";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BA1310E634
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Oct 2024 03:46:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oX9fX0i2eysZ6dhyFKahPaoiGQMeP6x+T6d72qQrvPfkMiPBDurHJLJtD9L62v+1BJwiTkR3e90Kh2qQcZnvh5eWOuhxh8cCqrySJR+5bi7Il8hke9MCxRgZGRBv9CHlYky1bebe8iDU/P21mu/A5JvgtjpzCKyAQXxWKlS7fJSz5U0KvQKNujFbjeMnLQcPDpi6dkTOgI5e7krK8se4xD1vFB96OvLBEkOj2zPNcQG2kWP+AygIMEaC7LV9vrPej9W8kgZnxdtUtHiBIQzt777Qp69xLkqvvTaJYn2TeO12GamKYA2lk1pf/DPx329fqD2UK4Uo619Db5m9QOpyFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KCRxbmvHukyG0Uka7dMS1YkterKu0eQQb0gIrMvFOiw=;
 b=OutqYOizYuN4+ruETRmsgELDpOgDxneN5yd1jo+UactKbE9lvtrkNIzj7F6HvojyfTegz1EtX1qVCSj98cqKwAU8QgGuAzK2kYbtWh5IQh3smDNJWZ4qrvRp+oDfH1BvsIjcXuUbFPwnQ/nwKa+BOABMCJ4505IzoBHiaaHvS725zlmdbcjnf3D9mzPULh+zGN2TPxv43H/L1+S/Bfw3muE5oL8QfpnK/NdkQS0a4CJnS9EEzNlk6YLhyU2BREUQVfaRmUMmQpmqv7pqhpnFCTpMbEQHecylZn6ZJT+1RG4ah8JGlkZjAl1gbMdvRg/8Hw4Y2J6lDLDsRCunioLMaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KCRxbmvHukyG0Uka7dMS1YkterKu0eQQb0gIrMvFOiw=;
 b=UtQL8tAZNYzpytRkUUlkpxqW4XPndTVwbV4MLsKzZ1UAFtXhUmXj7dngsANUoMCwO6hgSJXCqo2rSvKPBcucGohezqlxH+/bmjaESXhLwZBXvLrBNekf8RHn9fWHvE/1PMtuAGS18stXmHdUX+05HGfLtQhb+CUvH0WrHzAmWVI=
Received: from MN2PR03CA0020.namprd03.prod.outlook.com (2603:10b6:208:23a::25)
 by LV8PR12MB9112.namprd12.prod.outlook.com (2603:10b6:408:184::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 03:46:04 +0000
Received: from BN2PEPF000044A4.namprd02.prod.outlook.com
 (2603:10b6:208:23a:cafe::a5) by MN2PR03CA0020.outlook.office365.com
 (2603:10b6:208:23a::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.24 via Frontend
 Transport; Wed, 9 Oct 2024 03:46:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A4.mail.protection.outlook.com (10.167.243.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 03:46:04 +0000
Received: from jenkins-jiadong-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 8 Oct 2024 22:46:01 -0500
From: <jiadong.zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <lijo.lazar@amd.com>, Jiadong Zhu
 <Jiadong.Zhu@amd.com>
Subject: [PATCH v2 3/3] drm/amdgpu/sdma4.4.2: implement ring reset callback
 for sdma4.4.2
Date: Wed, 9 Oct 2024 11:45:45 +0800
Message-ID: <20241009034545.543736-3-jiadong.zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241009034545.543736-1-jiadong.zhu@amd.com>
References: <20241009034545.543736-1-jiadong.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A4:EE_|LV8PR12MB9112:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d1eb87f-19f0-499b-3cf2-08dce814e668
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?i57gvAdTp4nuwOnoNs84QD4Ed1N0eYnhzQN/e3qM1TB+eERzTILWxsxJeoBG?=
 =?us-ascii?Q?GURxRFRucGH9HhYK2E2t/brQ9puYz//gD1uc0NFC1HQKEezDo3RwzzFGVjjF?=
 =?us-ascii?Q?d087tjXVRfi+kya4/TAzTkzZMyVwRDVsXr9kF6y1lE9QUMr8Of/wln7bw6HO?=
 =?us-ascii?Q?23fv8i3sT4xdD5g+TqTdq1KYGFtCbcst7VoFcepHztuYmN/JDDGPjig6D9ed?=
 =?us-ascii?Q?5mZtZWOmM5/a4Q+tcJgQAuAEDaABQcGEcd6ftHeLJdW0lfmlTZaaw2c8BaA9?=
 =?us-ascii?Q?Q4UgNxh+7yBOIW0F2L9ShCq+3YczwmXxb9UU4x2bJt3kpvz+S7eTVlq0/vW1?=
 =?us-ascii?Q?Uk4mcAzl4gUOgsqG15qUZbv1LTJazBPA9Q/+nYIcy9ENH9NznC4sSSuHQOvn?=
 =?us-ascii?Q?4XqSnCE831kuNyRqRdsJz5F7aT9X8xIwnSgLqhGvjvWn1vg1sb7xQyeztO4c?=
 =?us-ascii?Q?cJMYMBnmFHxhpUOT/0Qn8NXcys/GN+n+6pxt0xEfv6ZjmqfgUl/2iiEoY9nn?=
 =?us-ascii?Q?3QU8S4V3ECwKAhQDkD7dlGCtKk/DSk+mxaDoE3H8tLiGE6ObAKN169QPdsuk?=
 =?us-ascii?Q?18nN31h66riN6I2EZM0+1Xlbe6klAvDp4ZjmC/iqxd+sJDac6ai21MqhPD8e?=
 =?us-ascii?Q?7y9YbSwCOCx61ULTC/LZ5pTdkKRI0GsevNPdhb7CwV9LWyGkZFwcOnCtJkuo?=
 =?us-ascii?Q?Bf+bLBtVVNeK+9xAySNmzu6du2wR+uupuKBYCYsjgfigpcT1qq+f5bmbhPsZ?=
 =?us-ascii?Q?CNbpDH0GzuhS1TAo9D90fnBA4ExBXl/ASMp2fSwcxwqCyS05pPocTUqoFp3b?=
 =?us-ascii?Q?9warSpAdGuFF90UBMcY4xRx1VD2FPFzSR+1HpIuJ00wEo57z1qsegSf9faj8?=
 =?us-ascii?Q?R97/CCGRxQtRvjXII9R0+csWCtcdCX9HSLtgOald9cDNBAAeT+kWWMMdSy7O?=
 =?us-ascii?Q?5Ichbb4gV9/7TGbXssBLHjqHP/Mo7uK9g/1mAHv/Q39RepZQ44y00lrYTjcl?=
 =?us-ascii?Q?H3EheRkhwhJLMX39EZIOmiQyiYz6oL1RlrnbQOTsWqDiDm+0I8oU0N4YjllC?=
 =?us-ascii?Q?oQm+G5+NfkeKA80f9hXaR0xlBH0NDaiEsVGGipjjJOyKj1OZgbgoedv3gwlt?=
 =?us-ascii?Q?ThvJEz5+YZpGSGBnLBr5Hfseq1fJt8c5LHJRH64cim/fb+9Hd/wZ9i3KIhdV?=
 =?us-ascii?Q?j2UAENbg9hiZ3r7PHZCU5490s77c1ueXIh/cD8DjTYQ9K/ER/bQ+YzNRQRvr?=
 =?us-ascii?Q?iZ4sHmPK36cGusyGxVUpSZl38z36IZWqwsnMmA0OhXUvhmIF4++wZyDT0NQ3?=
 =?us-ascii?Q?PnXNSSxy6edmyWkzxE/JZnbJjRelJ97VgGfJCIm/KqakraCLod9Wh7UZvXy4?=
 =?us-ascii?Q?Et9zbzVu9RTAVnVpWcvd+qgFsJ5d?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 03:46:04.1723 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d1eb87f-19f0-499b-3cf2-08dce814e668
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9112
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

Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 97 +++++++++++++++++++-----
 1 file changed, 79 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index c77889040760..3cb16af9b78e 100644
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
@@ -1390,6 +1407,7 @@ static int sdma_v4_4_2_sw_init(void *handle)
 		ring = &adev->sdma.instance[i].ring;
 		ring->ring_obj = NULL;
 		ring->use_doorbell = true;
+		ring->me = i;
 		aid_id = adev->sdma.instance[i].aid_id;
 
 		DRM_DEBUG("SDMA %d use_doorbell being set to: [%s]\n", i,
@@ -1477,7 +1495,7 @@ static int sdma_v4_4_2_hw_init(void *handle)
 	if (!amdgpu_sriov_vf(adev))
 		sdma_v4_4_2_inst_init_golden_registers(adev, inst_mask);
 
-	r = sdma_v4_4_2_inst_start(adev, inst_mask);
+	r = sdma_v4_4_2_inst_start(adev, inst_mask, false);
 
 	return r;
 }
@@ -1566,6 +1584,48 @@ static int sdma_v4_4_2_soft_reset(void *handle)
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
+		dev_err(adev->dev, "amdgpu_dpm_reset_sdma failed(%d).\n", r);
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
+		dev_err(adev->dev, "waiting for unhalt failed.\n");
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

