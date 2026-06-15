Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 636B4CD98E0
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2026 23:57:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD1E610E6D2;
	Mon, 15 Jun 2026 23:57:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="p41tsi5Z";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012041.outbound.protection.outlook.com
 [40.107.200.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 573B310E6D2
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 23:57:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yZYH3dNKnLnDO1sRx7KogC3jbhpMCryiZJdDUm1/0vL+TlrD9P7TqHW9hHp2Tbs0aSRb04AO6E4wXsdbD3evWk93qQUp9mkJzifBvtPTQ1R+8ZtscH5qskcy6rLPDNA0RbGEdY/BfsBnZvRZI6O7eeXtBAmTavG1pZ3ANVtHLf7mvF7G+N1qqa7dHToHKHi1m9lYqaXPPNTP1kbH2qPS4EPiMpBzdyG4QOeHyadn/VPjDPxyBOzIbC3jdassHtiu943UwprPa4vTfAVnHxUMnd2YQXwQB7Xo1n3+m62aHNqM6mkKrrbZmg9SPelzniJuvhE7Smr1j55EmPqRdUejNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pmOrm+5XXgev2HuxaP7xsICkLjYv7/KumEXVjj0MmAY=;
 b=ZBZQ0c2Dpb5UBXmlRGFDz2bjMIYSIUR3Ktic67I0+aXW3QtKyKsXW35PYzDqsQPSld8lZcD4yLXUx2X6viZKoSGBwwCTa6QdurmAtMaKcCyP3kT1pSgzslf/0o+XWN9bZ32FZj2MHIwXiAA9IEvCDJgIUN3OzPBkg8arvMPHG4CjvcDj22WrfP1+BFtglDo+Xo9CBlF9bEIvwAfc8rnQtsCoSwh63Ykatfx2wunjy3EWQQ2s5zBhhEkCDJaOgyys9zHkTX/gs3tvN3GQjnbQTUHqItak4aH6x41No6BWp8wmyQRqAzuO6do61ybmI4aGkvEtBmw0H4t/ucOFS8MFEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pmOrm+5XXgev2HuxaP7xsICkLjYv7/KumEXVjj0MmAY=;
 b=p41tsi5ZJ2jdbeo1h/9hzeU05lmBsR9tkFGw2flzPS0m8HU3VkqUXukrNpH3BYKMYeuO4iU44psbdLHEVTkSYQPKrlQLDaNlen+5LKVIVMLf6XMnjblxY84U57bPnjPDzYnb6KjYj0iDjKfip3QNLDHg3vyoJKyJT7qoTvc+E78=
Received: from SN6PR2101CA0019.namprd21.prod.outlook.com
 (2603:10b6:805:106::29) by SN7PR12MB8001.namprd12.prod.outlook.com
 (2603:10b6:806:340::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Mon, 15 Jun
 2026 23:56:56 +0000
Received: from SA2PEPF00003AE4.namprd02.prod.outlook.com
 (2603:10b6:805:106:cafe::22) by SN6PR2101CA0019.outlook.office365.com
 (2603:10b6:805:106::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.2 via Frontend Transport; Mon, 15
 Jun 2026 23:56:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE4.mail.protection.outlook.com (10.167.248.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 15 Jun 2026 23:56:56 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 18:56:55 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 15 Jun 2026 18:56:54 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 06/43] drm/amdgpu/gfx12: replace BUG_ON() with WARN_ON()
Date: Mon, 15 Jun 2026 19:56:08 -0400
Message-ID: <20260615235645.737189-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615235645.737189-1-alexander.deucher@amd.com>
References: <20260615235645.737189-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE4:EE_|SN7PR12MB8001:EE_
X-MS-Office365-Filtering-Correlation-Id: fa9abbd0-bf3f-42f0-735e-08decb39c820
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|376014|36860700016|18002099003|22082099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: pNng35hKViaGsBfHUleScUU5rYHs1WTgn+FH++4lm93FE9xjUQBTiHAkQxOdT0TbdxaU3wmL/yD8u5ymnT016ffWo6Y7n4ETfi1aHi2f/k1A1ho0dWvu+LEi43LF/nI/J9WoSGrsrULIQqUWc0LAvnEC2824O98YnFgQjEPNuj2BnPJSx8mxxMWlJ0pO5GX6TGn54XzlcVmb13YM18rfLVR2lKAK32EIC5/HGa7I6Tz1IBiBPcrBe1hUuBLDsdOzu6PpnEnZaU7m4SUkHFy3n67kzCIMertbMimPs2/sIhzNTwE/i0if+tsTOgiJL5Sc3D98DbeqgD6m7/5iynLCKBEt0MPhPCn21JQe0CQTQJAXKjfctYT0C/lizdafNzdIyjnAJVsdN3b3CIT6du/pja1Ii7R9a9d6ls5pcwhCJyVZbKEMuQcMdyoaOwj8Hyf9ewif1JL+7OyW055Qd+Y9HYj0LfUIeRWpj9vZvE3iHVTMugEw/iSMP7YiOOCaPhNGs1sz6GPt4N7CmVWj/5lw2kQrE7QvFY/cwElLTiCge27ZRsOoLuqbil5cdzL/ZTW4AF50KdfKK8yCbuKBzSTMookbx5C0Qd36xUu7kSXKD6dtcZeE7wZu6V7+k/r28sl/tTZuxXZYyXQR6IEC9T7UUPw0A2pNpbP4qaiFqk5xrXliYQ2I/NVavOlHvlVDuGKFt9fEgEFk/ZM+/8yTIxMa5m6TDMtuE56m/Qej9+S8h7o=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(376014)(36860700016)(18002099003)(22082099003)(56012099006)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tKa+X5QkrtvgvwLFjyf8PWg6BuWbSWzmqxECWUDji1zeAQp6Gesollvq8NX9ZIRu58cnBVFoolyWY6qk/hPD1uPR55kbKwp9LhYFWHTJDlTo5rDf5nCal06j7Ipzdpb38H9VbEFlwZHU/rSOTJAVH/HPy8klQd6YuE5LqYsoLEueoSbAL7IexqyK6Rson4Wm5Mg8PCMG5nLkZQGbQfk74loV6rcpzEcPqf2lhnmFsu/g1iUj/aXIYR23nWvYQ+fYl1FzntWOR+I7X+bxbUkNcaKXDGCpdWeb38sjTBDmzg/IR0bG4AbHenvIsxmDyXRs32gkMj+K0viIcU2tsmzO1zlv8V+wjj1ax9a7Gk2AQ6fex5qLwQEwrf1KV+Bfm3byMWUCcD5nfECPDZ78NHfsb3YviqSadoWhxgFeqmIKdwjCxKHs8ArMbOgM4Y2WQTvS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 23:56:56.3673 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa9abbd0-bf3f-42f0-735e-08decb39c820
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8001
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
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 09f2ccfbf6804..a5ae91af9ef0f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -440,7 +440,7 @@ static void gfx_v12_0_wait_reg_mem(struct amdgpu_ring *ring, int eng_sel,
 			   WAIT_REG_MEM_ENGINE(eng_sel)));
 
 	if (mem_space)
-		BUG_ON(addr0 & 0x3); /* Dword align */
+		WARN_ON(addr0 & 0x3); /* Dword align */
 	amdgpu_ring_write(ring, addr0);
 	amdgpu_ring_write(ring, addr1);
 	amdgpu_ring_write(ring, ref);
@@ -4509,7 +4509,7 @@ static void gfx_v12_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
 	control |= ib->length_dw | (vmid << 24);
 
 	amdgpu_ring_write(ring, header);
-	BUG_ON(ib->gpu_addr & 0x3); /* Dword align */
+	WARN_ON(ib->gpu_addr & 0x3); /* Dword align */
 	amdgpu_ring_write(ring,
 #ifdef __BIG_ENDIAN
 		(2 << 0) |
@@ -4528,7 +4528,7 @@ static void gfx_v12_0_ring_emit_ib_compute(struct amdgpu_ring *ring,
 	u32 control = INDIRECT_BUFFER_VALID | ib->length_dw | (vmid << 24);
 
 	amdgpu_ring_write(ring, PACKET3(PACKET3_INDIRECT_BUFFER, 2));
-	BUG_ON(ib->gpu_addr & 0x3); /* Dword align */
+	WARN_ON(ib->gpu_addr & 0x3); /* Dword align */
 	amdgpu_ring_write(ring,
 #ifdef __BIG_ENDIAN
 				(2 << 0) |
@@ -4559,9 +4559,9 @@ static void gfx_v12_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
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
@@ -4609,9 +4609,6 @@ static void gfx_v12_0_ring_emit_fence_kiq(struct amdgpu_ring *ring, u64 addr,
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

