Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20E53C2D0CD
	for <amd-gfx@archiver.kernel.org>; Wed, 21 May 2025 15:29:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D35610E8B7;
	Wed, 21 May 2025 15:29:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ldQIF4v6";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06CD110EAAC
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 May 2025 15:29:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UNjA2KSe871oa5rwZi/UFRUGq/NcX9137Mp5zSx/wW8O0imh6Q1HXLexoslO24I6GAv8Nrd+TiYhWckjE6A9LABLhqSH0W5LnCgMQg3VUvnzaWpSv5VK+Sggx8EyO5qjGDqdt7Cp3CFtC5KE69wYztaayk4ObJIVrxzDsqyhVRJ70MrKWcnprlC0KF8Wmpg9vGV4a++BJCOADQ8pjp28b8pKWmE33nhTOR4I8hr4+/6UoLwllL12jt7XNEB/6yGgD64F8DtcX4STtJ+orlPp1uj2G4d0/e5gYbvjK3Ezn0Cl8IbPtip2iq2YYv5qxJfB50cJxMgqyzZtvZOOphKySA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=95DbPyH5Cek3+VLviamfyE/Zw8yT48LhyJtPUqsjGN8=;
 b=r4u/zoc+vW16K4SbTibAYB2+ZmBSoQpVn/80ZkFz/rcZVSwdpSuZJuvgEP8mN49HfTWPN3AJDND6L014Tue4yEE7p7W8XKM1HpwGS0XB9uAFVGYcgfXiDN3dNVEOoFX70f91eYDW2a9aLVwGizKOTKateo64aRXtNhPGhDqQNoeNIEFiNO1foDH+8SwabMbANY2Gy2WF7qLO3CD1GgirxPyS8Heea4S4qaMve2iAv5QuiJX85qklmDp3JogZxNP+FuA0UZI6tBz0Hp7dy91Gwt2xn2x/vjMVo9Qhum5juXPD9E8tFMLRdL4Ooc/3H4Hxa1ovr9y62A7fj+A8vrrdJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=95DbPyH5Cek3+VLviamfyE/Zw8yT48LhyJtPUqsjGN8=;
 b=ldQIF4v6AaSj43bp/yXuHdK8vHzE6uKV7C6QhzWGHYxTb68DylsUXpmd4dhuG2CoEZEAsQxZzY9ZfEf+EnMe6NnB1zuHdGNPO4GIV7VtcnpTQ6lM0obpsl5Ymn6ow94soCO1pYp0N/IqPf2hifawJ6ItP5AAYWgGj7OldI7TdEI=
Received: from PH8PR21CA0006.namprd21.prod.outlook.com (2603:10b6:510:2ce::18)
 by BL1PR12MB5778.namprd12.prod.outlook.com (2603:10b6:208:391::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.19; Wed, 21 May
 2025 15:29:46 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:510:2ce:cafe::7c) by PH8PR21CA0006.outlook.office365.com
 (2603:10b6:510:2ce::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.9 via Frontend Transport; Wed,
 21 May 2025 15:29:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 21 May 2025 15:29:45 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 May
 2025 10:29:41 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 06/10] drm/amdgpu/gfx11: adjust ring reset sequences
Date: Wed, 21 May 2025 11:29:19 -0400
Message-ID: <20250521152923.401945-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250521152923.401945-1-alexander.deucher@amd.com>
References: <20250521152923.401945-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|BL1PR12MB5778:EE_
X-MS-Office365-Filtering-Correlation-Id: 970615ea-f1f7-46e2-53f8-08dd987c50db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SoK4Tz4eSgi90mgHjmlSa4QVImu7Z1r9ffgEBpkhlrOYw2Zvy+xMoPxO1jeE?=
 =?us-ascii?Q?VlLSxaEXE6+tIz3nMEP+Nf+Sqrr7pQWmHwZROs9IsTFl6GFzWNKmijonNYRl?=
 =?us-ascii?Q?AS48yUKHBxVZPwegxIDQG9NuRC3N8Vdccmbvqsr3SLBV7mWxhtwaC5O7t5zI?=
 =?us-ascii?Q?X8PjAyIcgxErTvwYxugFuFCU35g+INP83F3QYLhSga81QULT8RBcTtg0vNa4?=
 =?us-ascii?Q?2N4qmObkJsEAivE2sTOrtXPINbdmHBS19SyzUcx9uPsMnEZfqh0zLtqifv/a?=
 =?us-ascii?Q?+CzQ5hGIzPxlaZN1WzCcMFMNSPA/NVWxD+qulYKQnRTSJXWm0gwqcsMP4Gjz?=
 =?us-ascii?Q?biRdZbxNqJ3ncoc2GGlTZW4coG6PF4bd/NTVwIaGRWx0tTrbNekrj5IvIXS5?=
 =?us-ascii?Q?KfZWCytuNdamyQ0VZa9PUGFXOY8ZBHODlPE9neGymfdGwmp9v0WiuyOYp7Iy?=
 =?us-ascii?Q?DtjK9/nd7qCpunY+V+H5Cq+v+8oBr7yJ57Z+Vks4vk6areulE+DVn/cHLJYo?=
 =?us-ascii?Q?4sdAkCmwtEy9TDBReDuk3gTTECojUMrJ/TQjJLQRai+AW0VrNWnuycrLBg+k?=
 =?us-ascii?Q?F8W849SYtV2wzLat92WsKbhDKvfFWT12MeOYErVLuhZHqwnYCExCylrj1u6O?=
 =?us-ascii?Q?L+Jt21NqNyjHVAC38Mc1oAvTxj/oHD2N1nV+087G9Bu80pMBKCLfeXWiHXp0?=
 =?us-ascii?Q?UM19woCjV8JA2P3BwMO8u4ksnZTMZ/K1IqsV2tvJHKq1JwGEOC7OlEiQlJw/?=
 =?us-ascii?Q?u8g1+lBP7bHehOSHytjLr+K3ecdDzUPK9oSqvFqZTgBNuwYuODHL8Ph7piBX?=
 =?us-ascii?Q?/y2+INLo3sykq0LDBl/wK6ayhSDtzlSUvU1/bgoouGyMu+SCBLL/ygdtGeam?=
 =?us-ascii?Q?jZCxH3foO/TCZ30eP+NHokpgGVrs8ZKrHByIGAjYzWoildB+3Ksk+Pw/SssC?=
 =?us-ascii?Q?XMbX5pCn6xUyA67ygoKI6QL+6DBqrJTCg54bZACuu7YzH0IeBklq/mGXbHON?=
 =?us-ascii?Q?HsRv/nZj1M1vVOct9a3vU5tZG+VlIors6rOWeYiwgX5J1WJ4jLr9TbpXapJy?=
 =?us-ascii?Q?Gszn/UDZ/Sj392MVmanU8JKpvElebOCYR1scmh7ICBZPdwTy3697Xa19M7vB?=
 =?us-ascii?Q?WXzwFXOb7OLQAn2fuqJFoCEotomYwsf+P/xuatwaFsiOfSPK61MTBa2SkIKg?=
 =?us-ascii?Q?R9bo/MymDOyLfiUchVXsjT27+rbTzXRrc9AukxJbahJM1zk7/7NYHLs7WGM0?=
 =?us-ascii?Q?asZmFpGNXPULMBFcpPkqteimU1B/2LluUVlP9ZtUD2IXzFq7xDhIoIf9IWdX?=
 =?us-ascii?Q?pUUvSmtpLOQ2gPhlKMK8/YgploYB09h9eyKZrGACO8gXeKlTKZMsYk/wTbCN?=
 =?us-ascii?Q?e8boW7Eht4Xifj4mjIApJEebK3nmVVp389Us3WyXILafBBS4d1X0DoKefcFx?=
 =?us-ascii?Q?4k4yoeOutCK5YK5sVx/a9GEx+s/6nZiSyQDvPICARYAoaR5Nzih5mw939djm?=
 =?us-ascii?Q?2HoCdnczBezwPoSq7EWfVyJEkjggQlfmNPNl?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 15:29:45.5397 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 970615ea-f1f7-46e2-53f8-08dd987c50db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5778
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

Write the fence after we reset the ring and use an IB
test to validate the reset.  This is safe since we
have enforce isolation legacy enabled by default.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 20 +++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/nvd.h       |  1 +
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 39374c87738b3..95f495d70704c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -5912,6 +5912,7 @@ static void gfx_v11_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
 {
 	bool write64bit = flags & AMDGPU_FENCE_FLAG_64BIT;
 	bool int_sel = flags & AMDGPU_FENCE_FLAG_INT;
+	bool exec = flags & AMDGPU_FENCE_FLAG_EXEC;
 
 	/* RELEASE_MEM - flush caches, send int */
 	amdgpu_ring_write(ring, PACKET3(PACKET3_RELEASE_MEM, 6));
@@ -5921,7 +5922,8 @@ static void gfx_v11_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
 				 PACKET3_RELEASE_MEM_GCR_GLM_WB |
 				 PACKET3_RELEASE_MEM_CACHE_POLICY(3) |
 				 PACKET3_RELEASE_MEM_EVENT_TYPE(CACHE_FLUSH_AND_INV_TS_EVENT) |
-				 PACKET3_RELEASE_MEM_EVENT_INDEX(5)));
+				 PACKET3_RELEASE_MEM_EVENT_INDEX(5) |
+				 (exec ? PACKET3_RELEASE_MEM_EXECUTE_GFX11 : 0)));
 	amdgpu_ring_write(ring, (PACKET3_RELEASE_MEM_DATA_SEL(write64bit ? 2 : 1) |
 				 PACKET3_RELEASE_MEM_INT_SEL(int_sel ? 2 : 0)));
 
@@ -6844,7 +6846,13 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 		return r;
 	}
 
-	return amdgpu_ring_test_ring(ring);
+	if (amdgpu_ring_alloc(ring, 8))
+		return -ENOMEM;
+	amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
+			       ring->fence_drv.sync_seq, 0);
+	amdgpu_ring_commit(ring);
+
+	return gfx_v11_0_ring_test_ib(ring, AMDGPU_QUEUE_RESET_TIMEOUT);
 }
 
 static int gfx_v11_0_reset_compute_pipe(struct amdgpu_ring *ring)
@@ -7004,7 +7012,13 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmid)
 		return r;
 	}
 
-	return amdgpu_ring_test_ring(ring);
+	if (amdgpu_ring_alloc(ring, 8))
+		return -ENOMEM;
+	amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
+			       ring->fence_drv.sync_seq, 0);
+	amdgpu_ring_commit(ring);
+
+	return gfx_v11_0_ring_test_ib(ring, AMDGPU_QUEUE_RESET_TIMEOUT);
 }
 
 static void gfx_v11_ip_print(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
diff --git a/drivers/gpu/drm/amd/amdgpu/nvd.h b/drivers/gpu/drm/amd/amdgpu/nvd.h
index 56f1bfac0b208..f0c3e3a870541 100644
--- a/drivers/gpu/drm/amd/amdgpu/nvd.h
+++ b/drivers/gpu/drm/amd/amdgpu/nvd.h
@@ -371,6 +371,7 @@
 		 * 3 - cache_policy__me_release_mem__bypass
 		 */
 #define		PACKET3_RELEASE_MEM_EXECUTE		(1 << 28)
+#define		PACKET3_RELEASE_MEM_EXECUTE_GFX11	(3 << 28)
 
 #define		PACKET3_RELEASE_MEM_DATA_SEL(x)		((x) << 29)
 		/* 0 - discard
-- 
2.49.0

