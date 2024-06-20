Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69FC7C27C79
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jun 2024 17:29:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E5C110EB8F;
	Thu, 20 Jun 2024 17:29:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IMjypz5b";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 367E510EB8F
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jun 2024 17:29:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e43HKVAJXOwDMVRLU6AS6b/j9pr4HdN7rgvOEtSHg5zp5n+mExUYoWhqYWHnOgRhtbs4Ibnp47092qez9GrzME20kARFbLFVkxRUG2Yn25525sGBx0W9XoUTSyilSZBRIIc2Dg+E+vbrTsJEfC3mG8fGKk18PN7ql0Mt43Rdqlqj5R2DOaLSuV/vN0VAhEGBbmV6fQwDzZZYsvOpvJt3DiSNSyuRsquvOnSaw2lffvX98lXoOuyJz7Dmdw00db3I+iaGdPeXtcqX+vZpqqw6MfN+Y2oXs5b847khDyoVOEEU5lzpblo4yqPKeaca1P4seNHEdY+DhDMgXU4z3WrBcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H9U0fbjG6OpfsfZcwSba0cpy8RNWHyeUUptC7B/QQ34=;
 b=G4LV/bv6ql1iKZoI5XV9ot4hyp+HWF0HefWSsw+YwjMUrQ0eNMI/pSwHArbWXLMVLsb/rscb2HNWKbv9i6sl+NnnGhNmclFymCQKXXdizphBnwYmXVvfWYByJUI4TYHg6So6It+0pzzodzdEv+9nmJBzQHrZA3owq49ctiLqLMabZRM/OUvhR+Qf8rLprVhFpbTLgfav85ArAMZsLv3yDHsAIzEJ5+5kBMvkOooUhQ5dVIsvl0ihsqhpHok15xy6oNIs9YLhKzZK8Rif0llxj1wRW6qkxKZP9RnkVD7mUd22CyEANdqDqQpjGXzWi3r+8AmaIjCfeXsCQrWVPyk/tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H9U0fbjG6OpfsfZcwSba0cpy8RNWHyeUUptC7B/QQ34=;
 b=IMjypz5b+0bjtp6d+4vo7sgcvcOUJXA+yH7JL1MsRBKN5AXo2b2DBdyL5a1vcPZufRiDxGfJJbNLfy6rEgAta74TYuiEfSUTdmqO53IEyFML/6XhAnsjindYLvl3xtKXWb24AEJV7AW8bnRT4nJhhmj8Ewng1as9x2bkHCHHwNk=
Received: from MN2PR13CA0023.namprd13.prod.outlook.com (2603:10b6:208:160::36)
 by IA1PR12MB6459.namprd12.prod.outlook.com (2603:10b6:208:3a9::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Thu, 20 Jun
 2024 17:29:30 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:208:160:cafe::c9) by MN2PR13CA0023.outlook.office365.com
 (2603:10b6:208:160::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Thu, 20 Jun 2024 17:29:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 20 Jun 2024 17:29:30 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Jun
 2024 12:29:29 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/gfx10: handle SDMA in KIQ map/unmap
Date: Thu, 20 Jun 2024 13:29:11 -0400
Message-ID: <20240620172911.3965888-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|IA1PR12MB6459:EE_
X-MS-Office365-Filtering-Correlation-Id: 460169ba-deae-41fb-1dfd-08dc914e8ad6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|376011|1800799021|36860700010|82310400023; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OWi3X8HQaW+gAtvmIhGww0fcMnAEeBlS/RO9Y0SzVaB8a/fqZYACFUsvEJjG?=
 =?us-ascii?Q?VfT3RVFggNT7MzERtqq4gHvv0+trBqPJSHPMqCavlnvxMDdhYwyK3fljIdYU?=
 =?us-ascii?Q?79e5sGvIuHso72EaEfwTlaXpsG/Ckl23eTUmEHbDDI6yZgDZSslkTu2F9/9f?=
 =?us-ascii?Q?dI8ScM10m/NBCYDYNwIggCssDCPfuqOt5gNBB+g+MmDXsE/L/jmfBtJr8Br4?=
 =?us-ascii?Q?oQnEPSp/tsj6OcSLmh2KYMwF3vE1ulIkERPJnHV9jVHGHZVh5GDR8bQ9F3K8?=
 =?us-ascii?Q?XYWDwn1DQU5QA28rI2i9kmFdle7BdHT6krEbE9yuUkQuO+xy2fFDtDFKu5fd?=
 =?us-ascii?Q?xix7ncZM2zKnVkrq6ZXTDlm7e9Mw+1Li4957uxYxvAHsTQYOVr90lJvAkiFB?=
 =?us-ascii?Q?BzDhaZRVVW06mtjsK6Sz8Vso3I9KUH7z3zS7XOCuUwgFQc677pnb7/ZDp7I8?=
 =?us-ascii?Q?jFt072d3+kcRdWv8U7j43g9TuCxJ3mEJUVyh8kfKnsy1y7ocrSie6XO2lmgA?=
 =?us-ascii?Q?PM/z1P2rJlod1FhyZXd9dNgUvzINFPYpVNm8HhXH8bXK1dDav4IXwnkQmHkk?=
 =?us-ascii?Q?0YIMwzminalXOTFunTm6bgon5MjtP84ignxwExNhsshyk1jSaTRPx4NkQBfQ?=
 =?us-ascii?Q?A6Ms9V1lUNcMQzK9s32J367vQZByNq3AoTl/3PxmV28207/AfuTEk0hI+eOp?=
 =?us-ascii?Q?RWk01+yyvUHXjMMoY5JX33XUkB3u0tSOx6N8VcuzQwlWgcFygD88u2qPLZRq?=
 =?us-ascii?Q?XMS/xVKS6SIWZjsdnQ58pBybhPTNW8EjDmXsEQgC47qUKmEX5G3Xhqw4Gah6?=
 =?us-ascii?Q?jsQ3+vSFI6WpGinrgYZe12GsTzYdtJXwUElOvFv78+3DMSj8McPOkfSMvUde?=
 =?us-ascii?Q?CV+xxAFWbSdBcRLudPljiUh9JzbSrkBotshUUcnCQmhgMnCFkMNduPVZQaC8?=
 =?us-ascii?Q?WSNU0yTr6do3BIlNU5BRqyjuoJz6pHLDJtfQj6wpIywZMc700fLRaej/t70w?=
 =?us-ascii?Q?8woFAAFIGUeEW2YqEiC3oi6+PgCSwEYvsLxA4sOQeJTSSzB1tTCZw95hfqKl?=
 =?us-ascii?Q?WV2E3DmNJFMzKSEyG20g1VocJnTaQCZUvS1tADvby4DzI210i3F7EsOgTKon?=
 =?us-ascii?Q?IYnP+qELWp3tz/vLjFYGsQ+zgZwzAQUPabi6gtqCUVeJ3syC1mVpXuOy9KUj?=
 =?us-ascii?Q?s9dp/dGQ0UylbXX0IDqpNgXKvFNTN2hQZFokSZFYBqMilJpuI7yTYq1jSEHn?=
 =?us-ascii?Q?tFLwYeFNd3GDQBWfTY+ZrTAy5Iz61FX94RVvXzNAOHs2T96wJq4IPscz2+/t?=
 =?us-ascii?Q?QFiZS7G7cVLpmkZDrhukGmFem3+7KuskfHuSlTVvx6NR25KKESH2tjPHgdvp?=
 =?us-ascii?Q?Y4wwGVT4Msty0er1B9EftwHmTZIPCGmYHXe5IaONUdLtep7ccg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(376011)(1800799021)(36860700010)(82310400023); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 17:29:30.1907 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 460169ba-deae-41fb-1dfd-08dc914e8ad6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6459
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

Add support for SMDA to the KIQ map/unmap functions.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 85 +++++++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/nvd.h       |  2 +
 2 files changed, 73 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 18488c02d1cf..abbf906496fd 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3693,25 +3693,58 @@ static void gfx10_kiq_map_queues(struct amdgpu_ring *kiq_ring,
 {
 	uint64_t mqd_addr = amdgpu_bo_gpu_offset(ring->mqd_obj);
 	uint64_t wptr_addr = ring->wptr_gpu_addr;
-	uint32_t eng_sel = 0;
+	uint32_t eng_sel, ext_eng_sel;
 
-	switch (ring->funcs->type) {
-	case AMDGPU_RING_TYPE_COMPUTE:
-		eng_sel = 0;
-		break;
-	case AMDGPU_RING_TYPE_GFX:
-		eng_sel = 4;
-		break;
-	case AMDGPU_RING_TYPE_MES:
-		eng_sel = 5;
-		break;
-	default:
-		WARN_ON(1);
+	if (amdgpu_ip_version(kiq_ring->adev, GC_HWIP, 0) < IP_VERSION(10, 3, 0)) {
+		ext_eng_sel = 0;
+		switch (ring->funcs->type) {
+		case AMDGPU_RING_TYPE_COMPUTE:
+			eng_sel = 0;
+			break;
+		case AMDGPU_RING_TYPE_GFX:
+			eng_sel = 4;
+			break;
+		case AMDGPU_RING_TYPE_MES:
+			eng_sel = 5;
+			break;
+		case AMDGPU_RING_TYPE_SDMA:
+			eng_sel = 2 + ring->me;
+			break;
+		default:
+			eng_sel = 0;
+			WARN_ON(1);
+			break;
+		}
+	} else {
+		switch (ring->funcs->type) {
+		case AMDGPU_RING_TYPE_COMPUTE:
+			ext_eng_sel = 0;
+			eng_sel = 0;
+			break;
+		case AMDGPU_RING_TYPE_GFX:
+			ext_eng_sel = 0;
+			eng_sel = 4;
+			break;
+		case AMDGPU_RING_TYPE_MES:
+			ext_eng_sel = 0;
+			eng_sel = 5;
+			break;
+		case AMDGPU_RING_TYPE_SDMA:
+			ext_eng_sel = 1;
+			eng_sel = ring->me;
+			break;
+		default:
+			eng_sel = 0;
+			ext_eng_sel = 0;
+			WARN_ON(1);
+			break;
+		}
 	}
 
 	amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_MAP_QUEUES, 5));
 	/* Q_sel:0, vmid:0, vidmem: 1, engine:0, num_Q:1*/
 	amdgpu_ring_write(kiq_ring, /* Q_sel: 0, vmid: 0, engine: 0, num_Q: 1 */
+			  PACKET3_MAP_QUEUES_EXTENDED_ENGINE_SEL(ext_eng_sel) |
 			  PACKET3_MAP_QUEUES_QUEUE_SEL(0) | /* Queue_Sel */
 			  PACKET3_MAP_QUEUES_VMID(0) | /* VMID */
 			  PACKET3_MAP_QUEUES_QUEUE(ring->queue) |
@@ -3733,11 +3766,35 @@ static void gfx10_kiq_unmap_queues(struct amdgpu_ring *kiq_ring,
 				   enum amdgpu_unmap_queues_action action,
 				   u64 gpu_addr, u64 seq)
 {
-	uint32_t eng_sel = ring->funcs->type == AMDGPU_RING_TYPE_GFX ? 4 : 0;
+	uint32_t eng_sel, ext_eng_sel;
+
+	if (amdgpu_ip_version(kiq_ring->adev, GC_HWIP, 0) < IP_VERSION(10, 3, 0)) {
+		ext_eng_sel = 0;
+		if (ring->funcs->type == AMDGPU_RING_TYPE_GFX)
+			eng_sel = 4;
+		else if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE)
+			eng_sel = 0;
+		else
+			/* SDMA */
+			eng_sel = 2 + ring->me;
+	} else {
+		if (ring->funcs->type == AMDGPU_RING_TYPE_GFX) {
+			ext_eng_sel = 0;
+			eng_sel = 4;
+		} else if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
+			ext_eng_sel = 0;
+			eng_sel = 0;
+		} else {
+			/* SDMA */
+			ext_eng_sel = 1;
+			eng_sel = ring->me;
+		}
+	}
 
 	amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_UNMAP_QUEUES, 4));
 	amdgpu_ring_write(kiq_ring, /* Q_sel: 0, vmid: 0, engine: 0, num_Q: 1 */
 			  PACKET3_UNMAP_QUEUES_ACTION(action) |
+			  PACKET3_UNMAP_QUEUES_EXTENDED_ENGINE_SEL(ext_eng_sel) |
 			  PACKET3_UNMAP_QUEUES_QUEUE_SEL(0) |
 			  PACKET3_UNMAP_QUEUES_ENGINE_SEL(eng_sel) |
 			  PACKET3_UNMAP_QUEUES_NUM_QUEUES(1));
diff --git a/drivers/gpu/drm/amd/amdgpu/nvd.h b/drivers/gpu/drm/amd/amdgpu/nvd.h
index 631dafb92299..e0fd205cdd3b 100644
--- a/drivers/gpu/drm/amd/amdgpu/nvd.h
+++ b/drivers/gpu/drm/amd/amdgpu/nvd.h
@@ -400,6 +400,7 @@
  * 7. WPTR_ADDR_HI [31:0]
  */
 /* CONTROL */
+#              define PACKET3_MAP_QUEUES_EXTENDED_ENGINE_SEL(x) ((x) << 2)
 #              define PACKET3_MAP_QUEUES_QUEUE_SEL(x)       ((x) << 4)
 #              define PACKET3_MAP_QUEUES_VMID(x)            ((x) << 8)
 #              define PACKET3_MAP_QUEUES_QUEUE(x)           ((x) << 13)
@@ -427,6 +428,7 @@
 		 * 2 - DISABLE_PROCESS_QUEUES
 		 * 3 - PREEMPT_QUEUES_NO_UNMAP
 		 */
+#              define PACKET3_UNMAP_QUEUES_EXTENDED_ENGINE_SEL(x) ((x) << 2)
 #              define PACKET3_UNMAP_QUEUES_QUEUE_SEL(x)        ((x) << 4)
 #              define PACKET3_UNMAP_QUEUES_ENGINE_SEL(x)       ((x) << 26)
 #              define PACKET3_UNMAP_QUEUES_NUM_QUEUES(x)       ((x) << 29)
-- 
2.45.2

