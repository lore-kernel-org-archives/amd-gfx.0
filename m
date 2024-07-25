Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12C79C3DA5D
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 15:01:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC13010E1DD;
	Thu, 25 Jul 2024 15:01:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Yzhioy2p";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A3FA10E1DD
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 15:01:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K6PpNIVcWFZINMLN40S3VOAyZrQKGH3j21Lpbt8zExX5Tm2u84w/Y3RKVmW7tGVww4tq9iHyyftF8lpiRPD1xih/p7sWFiwZLbNUwjp76dCSEKyzmvOgncTt6Lz9MVMI/c84JhZmtVB5qITUKBqoF7BMg0SwgRfC0CPIMS5Ou6D5YTwxdGmWOw4m9alBYRvUKh7u7iZdTCcNfLQCVkEwTbTNwBrYBbd3g7StRq2/VoZqYCxwAnMVOQv771H3ZV/+TDZ1kt+/8XBEu86VV+bU0CjCBRLItNfx55hgHDHvWJjd/FsvoEyBQH2ot0pHdCLo0t47pAoalNGdUqJOiPcm+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PsnSbnf8KaUGwkLq4A8/vf+26hPjlJOVXMaA4yhsGZk=;
 b=vmnC204D6He3IXTIj12y/RdaUKOWnlOgKCxBQ4g4b/BqyGerDAgH+FWEH2LuldyHxTfjhPQ4s3FK2mfQ1DKkS6veP4EA0CRRVgpVV7RYezk4gMDQzuPXy2JPAmABJ5e8Qo1WMZK0+0Aj+vvY0yResbzoiK36NfbABf5S1RYJRsyCr1AV8elPUYb+sH8msB9gX8aPn6KrxnbUIZAn+ny1TPtAmVXAqAqqKAnavMULcGtwv9yt7zliwfmYRv1j3+VK5Vct3bdtcB8VC/sSD4Ys0u4HdW6Sic0lX4gkwyvmQEAHuB0xg7vpehbAkivu6ISgZWRcHS11yRNq2mFqARWrwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PsnSbnf8KaUGwkLq4A8/vf+26hPjlJOVXMaA4yhsGZk=;
 b=Yzhioy2pOaXHv9xSQIPGU+/LxOeV13XLSzgJzoW7Adciy4LT4nmlXAyhJ5B/xkTQ/aukU865NFmT7IlGlrMBNQ1i0dWIJbgazoE7DE36bVdKEaya3BpxmmLPAjZG8n5/PzhX/D1KqbObxUEuLJ6x0K3CojgYpz4WCJquVPJIrVc=
Received: from SJ0PR05CA0026.namprd05.prod.outlook.com (2603:10b6:a03:33b::31)
 by SJ0PR12MB6968.namprd12.prod.outlook.com (2603:10b6:a03:47b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.27; Thu, 25 Jul
 2024 15:01:12 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::97) by SJ0PR05CA0026.outlook.office365.com
 (2603:10b6:a03:33b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20 via Frontend
 Transport; Thu, 25 Jul 2024 15:01:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 15:01:12 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 10:01:08 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 01/53] drm/amdgpu/gfx10: handle SDMA in KIQ map/unmap
Date: Thu, 25 Jul 2024 11:00:03 -0400
Message-ID: <20240725150055.1991893-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725150055.1991893-1-alexander.deucher@amd.com>
References: <20240725150055.1991893-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|SJ0PR12MB6968:EE_
X-MS-Office365-Filtering-Correlation-Id: 98e16bdb-e21d-497c-af21-08dcacba9fd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hOFuWz0iSId2ga5IGJZbxFhpKYNf4E0CA2/DZ8jihA3vkfnF5hmit/CYfiH2?=
 =?us-ascii?Q?7K0WZjrjwB9iUZhAFDSUMmT0AQm/wBGtXwVt9QnwPIbv3f6gcw3XIMfIBabD?=
 =?us-ascii?Q?y2v+DHkROKA/1mHHwy8OHL/YQzAmffNy6R6jd132IgJY/6CatgtORRzyK1ib?=
 =?us-ascii?Q?2RCGsxB+25kI0n6vdNm/THfZPyA5AemfpZq+h/xwNtCFlCOyR9ePQUWetOi9?=
 =?us-ascii?Q?fZOdm5Xa/KTPYGI7yovCJ8H3R7GpDSHut3XN1nGiJk5o6lvVdcftJIGIgAft?=
 =?us-ascii?Q?zvCYDyONGiVmBwQMQKB9hs58m3XgRT4u4JecohIez/0DqvW/WTtMdoFjWg30?=
 =?us-ascii?Q?VjiTADbjjcUp8W9vwytA2DENL7eNOGSAutRJtTAmHsOMVF2Qi9HOfEjFlvfJ?=
 =?us-ascii?Q?1Rvxl5JC3z9+ytoJ/Vavt3EytrKvlTstzaB0MeH7Kr5o0J0eaITLPw4/WIf7?=
 =?us-ascii?Q?8fK+8EBYbgdL9ayh2fcJBp01XbIYFFHeqm6TAqDcRrQYSSXFZYznOVUZ/Z8R?=
 =?us-ascii?Q?+a1O/58LaxBfJM0jTp+ent7AZ1sZxtE83LmW2wl9mO+nI4+GVhCpUvGU0J5Z?=
 =?us-ascii?Q?jDafiHOljoi+EG8akEJE+q1y2O6wLz0rBIBGm4/nkPKnZt7qrpYEP3uVH6Lw?=
 =?us-ascii?Q?X2W9wxLRaAwHXQS+2ThOy4W+0Y+r2Y8jnhrDbf5K1kDrXCxLDZWvpBdt3/34?=
 =?us-ascii?Q?0fTGaa7B3mz7CDeVYzcA3j/DMow+4+XmnyRc1F4uQGWlgBbd7E0lEcEFGy91?=
 =?us-ascii?Q?qDjV6bQvxk0q3k+dFkcCvTLxN4Cx/0PIKh0BG4TW0sCjliChyqwPUpJaPjgz?=
 =?us-ascii?Q?W07kO7MngLAif5MlrEe9kEu35d7jHbPAK/TniqvrVnUy0EIQf0ovkcqb8VUM?=
 =?us-ascii?Q?8nPBnGrzGv42s95FRDqBIWeYmNzEpREny7bOMueqQAbOxSPCWD512GrZtU+O?=
 =?us-ascii?Q?rD18SjmlLYa/TNiMg6Ov2i2uIxV6ueLLcl1TAXSSUjMTkJmXo06SzpNiuw0w?=
 =?us-ascii?Q?ae3VThHNBvV0o3Is2zwSAuws5BYhVQ0LoziqphEOvIsltKQ+/UOR8qzzQTFc?=
 =?us-ascii?Q?+8omiIZ9TUUWWi1OFgg54Ozftx2YWQmv81xCkF4U+5uxp+9SA2mMcbyHajY4?=
 =?us-ascii?Q?EeVj/aOZwAhI0NMgqVNYJ1wYSUWCvbn+Gry+VHIIxEknFnWjlnNfCHZb/QWT?=
 =?us-ascii?Q?wzrrYFr6q9N12VhixiJQK20DUYxlaut/h7kuTLA2nBrRh1uWbqyQYGKuMl+Y?=
 =?us-ascii?Q?Qn8bTfKW4m/d/WOJ2mTUnqLxXfo4MxsN5v5XU2ixenRUrit+WrwvVy+hHmja?=
 =?us-ascii?Q?HCMXhBySQGbcR3RU1iyCrU9uu2z7hzBZfBCftKaG6LmBJwVJMN+ZrBXFXYuk?=
 =?us-ascii?Q?gxHyF0JplsH4n2HpwYOatudj0K/3UgvcTe7hoAE/v1g12Miv+vRU06K4WbEL?=
 =?us-ascii?Q?5J5hWuMusd54hfbJ4YJJdgTS6aE8Uxxz?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 15:01:12.4149 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98e16bdb-e21d-497c-af21-08dcacba9fd5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6968
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
index 853084a2ce7f..e3f9a5fb4151 100644
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

