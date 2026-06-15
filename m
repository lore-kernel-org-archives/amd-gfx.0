Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 425BBCD98E7
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2026 23:57:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4ADF310E75E;
	Mon, 15 Jun 2026 23:57:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Lvd6/rKE";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012036.outbound.protection.outlook.com [52.101.53.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 323C810E6D2
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 23:57:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F8BEh4V2D1tiCJXc/4C4tZAvrvIwNTTbDa9YA1N34jXrdmdZvAwhsbgUyCLYPdDv/k5J4pOyTIp/yHhKnpuTvMQYqHYWLuLkHUKKCA/sOYprl0o8IYJ50FxzwB3eAjWG99HT4AsTzWc+kFNh+EDfirLgguu9d1LRm3wklygK/9gYRL9qfXsUUGy3O0FJq7SjzCUdi2L4WKF9ODrudUNac/ej5GMEivsscSKgNagWxNSAp+m9gmLxEKWdG7Y52umgX+yGSUeifPHUzf8ZaxWFhORvGYgbY1bOc8f8Kw3vhWnLggwJp7cgnCjibAPwqvSGkad8oe86P3len91fClmE7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=75jstdugtKLaQkQjGB1BkCD56WJMV0apyuaMRA14rYE=;
 b=sbXUvlM0Zmg4IqjEncos9NJvdDUm0f7rop5/bVHI1dDQcZ99SZCZaCSl8tYRormjmwerZflkxp24gsgPr4EktnSG12LYJicWoHO7enkWHocN1/vBmyPOib/Wdtvts0xcUN1Q00sT7mTQ5w+zQiBPlWRYy6b4ZxLbYarf01NWbpLAB6z0/YkVvdCmOlVdqgP+lRPWq39dCuORougLL+XQEhOmuQYgyzA3lEadgWSqg5VvHWH52vkWBO1qnFLoaE7Ju51unYidNIFtyv1mEl7gtxQZXw61PlkpvpS0urmn9hFC1eQAyBqEsg23qa05R0hS//ZAmucXpUCV2L2fO0LRiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75jstdugtKLaQkQjGB1BkCD56WJMV0apyuaMRA14rYE=;
 b=Lvd6/rKElG+ghHR5CgAUBz60SA/kuT1Y7g4MP4uCGoY3wfJYJGgwcxF5EwXQChe5uf9IZliG9iro3L3PVRYifTnxEq7Q+GS8Wk4eQolDggp0Zpy1IVkSPrn+fcfBXL9gL8MJ09d6NdMsl//6xUM6QpjHvsgVfB9cJOq9XB6HWDs=
Received: from CY5PR22CA0031.namprd22.prod.outlook.com (2603:10b6:930:1d::15)
 by MW6PR12MB7087.namprd12.prod.outlook.com (2603:10b6:303:238::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 23:56:55 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:930:1d:cafe::93) by CY5PR22CA0031.outlook.office365.com
 (2603:10b6:930:1d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Mon,
 15 Jun 2026 23:56:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 15 Jun 2026 23:56:55 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 18:56:53 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 15 Jun 2026 18:56:53 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 03/43] drm/amdgpu/gfx9.4.3: replace BUG_ON() with WARN_ON()
Date: Mon, 15 Jun 2026 19:56:05 -0400
Message-ID: <20260615235645.737189-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615235645.737189-1-alexander.deucher@amd.com>
References: <20260615235645.737189-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|MW6PR12MB7087:EE_
X-MS-Office365-Filtering-Correlation-Id: 595e666c-47ab-42c6-d08b-08decb39c755
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|18002099003|22082099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 52HvZ9C8WmJa3swW3dU1tbvyEf7mrwc9K7j8p6o8+Kizb77SdMoTnk9IP0uehbsa2Tio2LEbpVssJrp29E0ehOgi0V2idw1Fu1UHTZa+5toAEg+N7cLEOOo/+tX+6Jc/Ec791XZH77WvRvwGoMOdk9IIN2hhsl4Ak70GtYZey/9INCHc98N8MUojVD/nSaQGtqtmAK4F/HmXpipvocIPi/LuY1mjPdMgCzMAZ/MPWXkb71lHuE05NfDFOiGGs4QxitQJaKuoFd/Ha+oI+wfWfnmyGuVMlG789BnfKtFWrcg8zxjddj25mVIGzk0vfTjESbHTeAEbGRoRHS2+khNbXi9nFzHocwt3kCO9j8/U8/ibysj3nRPy1PoxpzGlrCvJGL2U3yR+vRjmbwHL+T15rx+pV55H5Jm9UnVCQ0kDqSZOrEZqceIORoLN3JfKOfyCDTthqXJjNG+C6b4zLoX5lqQTy79JjTGzNgSD4zk/LEyZGfMcRWQXTi5dnT8o9mWlV3jbIpsABO7pkDrQI3kc0CFRrrhOJy31kaQoOC35tOn8Nrof2Vsqo3aqliTWmRPo9qrvGS7/emwrrC7zUR/DJU1gN217Q7vlm/V8YqDIb2VxUsiDmlzcgenGrf+l/QmZVLpc6DQg9PfGZinhkqqk5KO081Msy6WSOoEQPkarCiMRblAsQ679/md0wsxpeZ+QJRywkjNVCc9P+nKhXqeZW9jRSOoPAOGgng0/fwOS6NI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(18002099003)(22082099003)(6133799003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LuSLpYXJQRfOyW3Q6AuA+DzWO37ZPuHHS4g1yuxGhc6k7l88M1W2Z7cvHzZtw8HkDMCSwF7g0s/Jz0+ETYreEKBavHBjFpOODybzASklUgFv0vilWxHWi0EhLW4w/TkNJ9uAxJdebG59i5YnOSHfY4TSPga3LJ/PtLhMo56fw+6gmTA5nqJwn1WD9s9/CbgLEBqUIyTinQ4u6iYbxZXB4WwNv1ITNgyx7oGIqhUWE2zee8STzAbrsrCiXgv2ZRUq9138FQq9qgV0h+3IV0OoNWiaRdjx3h99wTLJvsXOIdkYRABiEOBiGQy7SNbFuWvxKZQw3siXQatNL4FvY4hJ/CyWbuaFRwxOytgzvyZpNREd/MbiNcDFJCQt0DoKdSfllYlZfb5C9/UccEJqkHQlG2KeLrsCn3hInvX9lzauKhwtKwSdmLR3V3exWbiiNHQ/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 23:56:55.0505 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 595e666c-47ab-42c6-d08b-08decb39c755
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7087
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

There's no need to crash the kernel for these cases.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 510266ba0c388..2a36647b975a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -405,7 +405,7 @@ static void gfx_v9_4_3_wait_reg_mem(struct amdgpu_ring *ring, int eng_sel,
 				 WAIT_REG_MEM_ENGINE(eng_sel)));
 
 	if (mem_space)
-		BUG_ON(addr0 & 0x3); /* Dword align */
+		WARN_ON(addr0 & 0x3); /* Dword align */
 	amdgpu_ring_write(ring, addr0);
 	amdgpu_ring_write(ring, addr1);
 	amdgpu_ring_write(ring, ref);
@@ -2944,7 +2944,7 @@ static void gfx_v9_4_3_ring_emit_ib_compute(struct amdgpu_ring *ring,
 	}
 
 	amdgpu_ring_write(ring, PACKET3(PACKET3_INDIRECT_BUFFER, 2));
-	BUG_ON(ib->gpu_addr & 0x3); /* Dword align */
+	WARN_ON(ib->gpu_addr & 0x3); /* Dword align */
 	amdgpu_ring_write(ring,
 #ifdef __BIG_ENDIAN
 				(2 << 0) |
@@ -2978,9 +2978,9 @@ static void gfx_v9_4_3_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
 	 * aligned if only send 32bit data low (discard data high)
 	 */
 	if (write64bit)
-		BUG_ON(addr & 0x7);
+		WARN_ON(addr & 0x7);
 	else
-		BUG_ON(addr & 0x3);
+		WARN_ON(addr & 0x3);
 	amdgpu_ring_write(ring, lower_32_bits(addr));
 	amdgpu_ring_write(ring, upper_32_bits(addr));
 	amdgpu_ring_write(ring, lower_32_bits(seq));
@@ -3040,9 +3040,6 @@ static void gfx_v9_4_3_ring_emit_fence_kiq(struct amdgpu_ring *ring, u64 addr,
 {
 	struct amdgpu_device *adev = ring->adev;
 
-	/* we only allocate 32bit for each seq wb address */
-	BUG_ON(flags & AMDGPU_FENCE_FLAG_64BIT);
-
 	/* write fence seq to the "addr" */
 	amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
 	amdgpu_ring_write(ring, (WRITE_DATA_ENGINE_SEL(0) |
-- 
2.54.0

