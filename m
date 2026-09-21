Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FAC4C982FB
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 20:03:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECC3C10EA72;
	Mon, 21 Sep 2026 20:03:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Yz0Hi/IO";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012001.outbound.protection.outlook.com
 [40.107.200.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F21C10E873
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 20:03:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=od7ftDePb4+W7kGXlUYm97SJ2joCL6lbNzMmM7GVFGWmXQ1X75J0odk39QbGGpXJ8IecL+QrDyJZEmQ7G/h98Ml6GxWUYYgNC+gwPshkZsYwoLqaRv28JTlTgfNJ/Od6kRu0p/Az4dVKgQNnO+U6GCfC3nkfXA1BxevgARq93z9h/Y9ZLtpP1tuv6zTN3OCe1jtF3urvUHdXkvlS6D9IEYa4aYFBbyk9hLUECa2R6Kw5HSrL+NsO2qD0h9mcdC1pAyrzJG6+nLw3zd83VRilse6nyEthn0F7gpNtOFC55lAN9nu9aiDuHyf9a3OQh1aaNK0KHJUqy3wg2kQg8i6tEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=foWkszNOoJ9pJVfIqxcw5KiTO1ULedpH7ueYVl/j1tI=;
 b=jYs3uJ5sv6rUBcHlpAnPDXnW3FgPvwA5hZWMMFhIg8yZGlNW5juHCeo3ilJVSYM13UHUzd0H2WaGeAiU7xImH3Vnb3j8+ze9d62COADiJfMFrc9MnvsGBmsSTbVVL0Y6gxxkwLC+2FFT0qv7AASz4m3EFSJ/71Zq65PZa6aE9gZ0DbdFKS/R1FbCToG2ISwTdclBB8ogSXKYDDbx7WCiryyfoq4fn5Ps1Wpfz7Eqy3C6AQ3LUvleYYpo9jJlE+gGaNzsGiAD5R2C0waVDDtKBomAVz9Tuz88NftkfHgwdCHNqBxTDwvsioSWFN2khBZsaupibm98vVmGpJBT9D7jUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=foWkszNOoJ9pJVfIqxcw5KiTO1ULedpH7ueYVl/j1tI=;
 b=Yz0Hi/IO+ElEWw1tgMMNjscWO55hDtayywfh/8Vblx/irEdnbmtty1uJHgOVyS6ZuhcnMJdH0ERgW+vDym5X4mgvlmzr9ELnI0KAi9th+LLWBXTC2jKhHWdtpWBbVTZZGLhC9lL0fsECqrmSmRSUhkN2aBJ9eKlvRllDaz8beMo=
Received: from BN9PR03CA0448.namprd03.prod.outlook.com (2603:10b6:408:113::33)
 by DS0PR12MB7533.namprd12.prod.outlook.com (2603:10b6:8:132::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 20:03:25 +0000
Received: from BN3PEPF0000B36E.namprd21.prod.outlook.com
 (2603:10b6:408:113:cafe::31) by BN9PR03CA0448.outlook.office365.com
 (2603:10b6:408:113::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 20:03:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF0000B36E.mail.protection.outlook.com (10.167.243.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.0 via Frontend Transport; Mon, 21 Sep 2026 20:03:25 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 15:03:22 -0500
Received: from work-495456.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 15:03:22 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <Bing.Ma@amd.com>
CC: <jamesz@amd.com>, Bing Ma <bing.ma@amd.com>
Subject: [PATCH 09/12] drm/amdgpu: workaround for spm ring buffer overflow
Date: Mon, 21 Sep 2026 16:03:10 -0400
Message-ID: <20260921200313.865829-9-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260921200313.865829-1-James.Zhu@amd.com>
References: <20260921200313.865829-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36E:EE_|DS0PR12MB7533:EE_
X-MS-Office365-Filtering-Correlation-Id: 11b25f1d-59d6-4399-2b79-08df181b6530
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|10067099003|56012099006|6133799003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: rJcl0czBv1jCoFTN726ZJpBVBBuQKEA22xKkdg46jG/RObXechku319rdIc63ihV45JJepx54879mENorWWz/1SnHePEqBBZoLjyjLK7MeOGe9cUIGi5Sv9CN5k/EOqx83AktfGXa+JluaTsLRe8hy9GClrtroNBwSeNdM+xril5JKpGGIRbIB+xMfUrU/SBveMy+rnHFliFR0D9wARQVYn/QBmffsVhIFEfzDfux8n7Um2gjUTb3sHDTJ68fGetmJg8wRFKo1Nj//UMwKOrCit0koaD0hCoXF57MOMSb0aoj/OfShF/dqsySpJICbGv8pRp3hzzb/tAILi1vN0KwcbYU0MEMaUcpeg9jxdmbGgt63/gt/r4DbpzMfsDW3JeXVonPgiP/cxoxk2SGCLlwA1ewSLyRKA7CNdrcmM6/9RoC/KxTz6dxkinkTm7sehWRpy6O6+fUaxPnjHcoL5iNvhyIsplmtUTM2J6GLHkktFV04rdxcT86FhDATNPxlO5D0LnVilm3tiKNgRb0n+BmR5l0uof6fFf12Avt7trmxxb/ABjqm+iy8vZIl1ApUZU958s1b9Z4i+PVR4souG8Gl8sCL8THkO4adJPVP4MH2fL/cuFJXRcqbCoITbHshnf8u/F5uNKRVYqkgt63A4HWGNJmjHfPjV2VofpnL8e0OTk25byb6Sq36LqK3PJq2XUH0qEF0RbapevmGBr6t1uQw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(10067099003)(56012099006)(6133799003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PUnSLybwNNAvUqxhT2J6Y8uy1VnRSwbn8WPgoHAYPUeFch0cI9o4Q+70c34hH/VGmQBDS8NjApySGQpLg3H9HglLm4ns9UXBo3npppg/tE4oCmEuTg/HCKTC9IJTGP0hnC9aePwk16DSNHpQNfTcrxG1KveZyxtcSzRASmE7dWgIs84iMDiPnNSCr11UFl8A7l3li5vq7o/WRHSo/oJFtALXjdyliakURgQFqyGbahXtKagPVdFPAELi04NjNJqclULgvuDWZloXGnO+TCTMxDom2gQHiEcTYyAPGN3LadwZS987Npqb+uYWe9joqZWhjoO0T/SeX/dGfm5m1MzGQGbrXAqSqH6678QDHggHBXRYRANBqf7nTmnQyCW6zgNxVIDrnc9aC6e2dqAOCWqbGasJ8YMnJurftoLHdH6mSgtYSiA2AwEMg813Rs7uthSi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 20:03:25.0314 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11b25f1d-59d6-4399-2b79-08df181b6530
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7533
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

Pre-GFX12 SPM has a hardware bug: when the ring fills, hardware keeps
writing past the end instead of wrapping back to the start. Work around
it by reserving a region past the ring end, detecting how much of it was
written, and moving that data to where hardware should have put it.

Add spm_overflow_reserved to amdgpu_spm_mgr, 0x400 on pre-GFX12 and 0 on
GFX12+, and subtract it from spm->ring_size before
amdgpu_rlc_spm_acquire() so hardware is programmed with a shorter ring.
The reserve is carved out of the existing allocation, so the buffer
object size is unchanged.

amdgpu_spm_preset() fills the reserve with AMDGPU_SPM_OVERFLOW_MAGIC, one
sentinel per 0x20 block: acquire arms the whole region, each drain
re-arms only the part it consumed. On the wrap branch the drain scans at
the same stride for the first surviving sentinel, and that offset is the
overflow size. The data is copied to the start of the ring, which is safe
because overflow and wrap are mutually exclusive. A dma_wmb() after
re-arming keeps the sentinels visible before the read pointer hands the
space back to hardware.

Counter data matching the magic on a 0x20 boundary ends the scan early
and under-reports the overflow; this is accepted as unlikely.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Bing Ma <bing.ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c | 71 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h |  4 ++
 2 files changed, 75 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
index d17fb2963981..532d1bc34f89 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
@@ -39,6 +39,9 @@
 #define AMDGPU_SPM_RING_SIZE		(4 * 1024 * 1024)
 #define AMDGPU_SPM_META_SIZE		0x20
 
+/* used to detect SPM overflow */
+#define AMDGPU_SPM_OVERFLOW_MAGIC	0xBEEFABCDDEADABCDULL
+
 static int amdgpu_spm_acquire(struct amdgpu_spm_mgr *spm_mgr, struct drm_file *filp);
 static int amdgpu_spm_release(struct amdgpu_spm_mgr *spm_mgr, struct drm_file *filp);
 static void _amdgpu_spm_release(struct amdgpu_spm_mgr *spm_mgr, int inst, struct drm_file *filp);
@@ -51,6 +54,34 @@ static bool amdgpu_spm_is_owner(struct amdgpu_spm_mgr *spm_mgr, struct drm_file
 	return spm_mgr->file == filp;
 }
 
+/* Re-arm overflow detection region with magic values.
+ *
+ * Called with size = spm_overflow_reserved at acquire time to arm the entire
+ * reserved region. Called with size = overflow_size on each drain: the
+ * sentinel scan defines overflow_size as how far HW wrote into the reserve,
+ * so [overflow_size, spm_overflow_reserved) still holds its acquire-time
+ * magic and only the consumed portion needs re-arming.
+ */
+static void amdgpu_spm_preset(struct amdgpu_spm_base *spm, u32 size)
+{
+	u64 *overflow_ptr, *overflow_end_ptr;
+
+	overflow_ptr = (u64 *)((u8 *)spm->cpu_addr
+				+ spm->ring_size + AMDGPU_SPM_META_SIZE);
+	overflow_end_ptr = overflow_ptr + (size >> 3);
+	/* Write one magic sentinel per 0x20-byte block.
+	 * overflow_ptr is u64*, so += 4 advances 0x20 bytes (4 * 8 = 32).
+	 * Matches the 0x20 detection stride in overflow scanning.
+	 */
+	for (; overflow_ptr < overflow_end_ptr; overflow_ptr += 4)
+		*overflow_ptr = AMDGPU_SPM_OVERFLOW_MAGIC;
+
+	/* Sentinels must be globally visible before HW may write the reserve
+	 * again, i.e. before the rdptr update or the SPM enable that follows.
+	 */
+	dma_wmb();
+}
+
 static int amdgpu_spm_data_copy(struct amdgpu_spm_mgr *spm_mgr,
 				struct amdgpu_spm_cntr *spm_cntr, u32 ring_rptr,
 				u32 size_to_copy, int inst)
@@ -107,6 +138,7 @@ static int amdgpu_spm_read_ring_buffer(struct amdgpu_spm_mgr *spm_mgr,
 	struct amdgpu_spm_base *spm = &spm_cntr->spm[inst];
 	struct amdgpu_device *adev = prof_xcp_mgr->adev;
 	unsigned long flags;
+	u32 overflow_size = 0;
 	u32 size_to_copy;
 	u32 ring_wptr;
 	u32 ring_rptr;
@@ -163,6 +195,34 @@ static int amdgpu_spm_read_ring_buffer(struct amdgpu_spm_mgr *spm_mgr,
 		size_to_copy = ring_wptr - ring_rptr;
 		ret = amdgpu_spm_data_copy(spm_mgr, spm_cntr, ring_rptr, size_to_copy, inst);
 	} else {
+		u64 *ring_start, *ring_end;
+
+		ring_start = (u64 *)((u8 *)spm->cpu_addr + AMDGPU_SPM_META_SIZE);
+		ring_end = ring_start + (spm->ring_size >> 3);
+		/* Detect overflow size by scanning for first magic sentinel.
+		 * Heuristic limitation: if genuine counter data at a 0x20 boundary
+		 * equals AMDGPU_SPM_OVERFLOW_MAGIC (0xBEEFABCDDEADABCD), we stop
+		 * early and under-report overflow. Low probability, but acknowledged
+		 * trade-off.
+		 */
+		for ( ; overflow_size < spm_mgr->spm_overflow_reserved;
+		      overflow_size += AMDGPU_SPM_META_SIZE) {
+			u64 *overflow_ptr = ring_end + (overflow_size >> 3);
+
+			if (READ_ONCE(*overflow_ptr) == AMDGPU_SPM_OVERFLOW_MAGIC)
+				break;
+		}
+		if (overflow_size) {
+			dev_dbg(adev->dev, "SPM ring buffer overflow size 0x%x\n", overflow_size);
+			/* HW BUG WORKAROUND: On pre-GFX12, when the ring fills, hardware
+			 * incorrectly writes overflow data to [ring_size..ring_size+overflow_size)
+			 * instead of wrapping to [0..overflow_size). Copy it to where it should
+			 * have been. Overflow and wrap are mutually exclusive: if overflow occurs,
+			 * hardware failed to wrap, so no valid data exists at [0..overflow_size).
+			 */
+			memcpy(ring_start, ring_end, overflow_size);
+		}
+
 		/* Copy tail segment [rptr..ring_size) */
 		size_to_copy = spm->ring_size - ring_rptr;
 		ret = amdgpu_spm_data_copy(spm_mgr, spm_cntr, ring_rptr, size_to_copy, inst);
@@ -189,6 +249,7 @@ static int amdgpu_spm_read_ring_buffer(struct amdgpu_spm_mgr *spm_mgr,
 	}
 
 exit:
+	amdgpu_spm_preset(spm, overflow_size);
 	/* Read rptr under spm_irq_lock to pair with the snapshot above. */
 	spin_lock_irqsave(&spm_mgr->spm_irq_lock, flags);
 	ring_rptr = spm->ring_rptr;
@@ -302,6 +363,13 @@ int amdgpu_spm_ioctl(struct drm_device *dev, struct drm_amdgpu_spm_args *args,
 
 static void amdgpu_spm_init_device(struct amdgpu_spm_mgr *spm_mgr)
 {
+	struct amdgpu_profiler_xcp_mgr *prof_xcp_mgr = to_prof_xcp_mgr(spm_mgr, spm_mgr);
+	struct amdgpu_device *adev = prof_xcp_mgr->adev;
+
+	/* pre-gfx12 spm has a hardware bug to cause overflow */
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(12, 0, 0))
+		spm_mgr->spm_overflow_reserved = 0x400;
+
 	spm_mgr->spm_cntr = NULL;
 	spin_lock_init(&spm_mgr->spm_irq_lock);
 	/* spm_work lives for the device lifetime; initialize it once here so
@@ -334,6 +402,8 @@ static int _amdgpu_spm_acquire(struct amdgpu_spm_mgr *spm_mgr, int inst, struct
 		goto out;
 	}
 
+	/* reserve space to fix spm overflow */
+	spm->ring_size -= spm_mgr->spm_overflow_reserved;
 	ret = amdgpu_rlc_spm_acquire(adev, inst, drm_priv_to_vm(filp),
 				     spm->gpu_addr, spm->ring_size);
 	if (ret)
@@ -344,6 +414,7 @@ static int _amdgpu_spm_acquire(struct amdgpu_spm_mgr *spm_mgr, int inst, struct
 	 * the wptr there); the ring itself starts at AMDGPU_SPM_META_SIZE.
 	 */
 	spm->ring_size -= AMDGPU_SPM_META_SIZE;
+	amdgpu_spm_preset(spm, spm_mgr->spm_overflow_reserved);
 
 	goto out;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h
index 760fc04e7a6e..552c5701e08c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h
@@ -77,6 +77,10 @@ struct amdgpu_spm_mgr {
 	struct work_struct spm_work;
 	/* Protects spm_cntr publication and the SPM state read in the IRQ path */
 	spinlock_t spm_irq_lock;
+	/* 0x400 for pre-GFX12 overflow workaround, 0 for GFX12+.
+	 * Must be 0x20-aligned to match preset/scan stride.
+	 */
+	u32    spm_overflow_reserved;
 };
 
 int amdgpu_spm_ioctl(struct drm_device *dev, struct drm_amdgpu_spm_args *args,
-- 
2.34.1

