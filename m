Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91F66FEC11A
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2026 21:21:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21E2410E65B;
	Tue, 24 Mar 2026 21:21:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CvbEA2P/";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010026.outbound.protection.outlook.com
 [40.93.198.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E25510E5DC
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 21:21:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oidB2Tp8xVlh8T8/BNDiTFxnEPpTLib5nI7zEz34H7lV6CsELnQqxlqSI/7aNB5NrleAlQwkowWT7F0muIDgC2zJqWY8b3KtUwbUOQJVqpPBI2pB8f9L/g82fmM9KHq2ao68FCwUOKAi5mcfWBsl3B3pttn+NGJWKwEGRsdqk1iz55sYJODbiGLfA2wqdbyerdZr4zLdpG6WcbbevOeJLgWOiOQJyZshEmWxTGst1GHSCwFS/9HblwHxCHhbZ0J/n0A1X19NR6uwOGY+SjdJzPf6agKBVKT1Qz57okZ/LqBKqwTQaZqqQ7dL4QM0JPq/6h9+YTCqgnc4uXq0kvKcqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vmTn3pslxQ2fRF+HJvcxJSmcLh6/4Ljii4dEtzUIHgo=;
 b=IVyzedMkCDVwyroFTEiHO9n/08NHvK5v1N6EjbWeCluL/JqSWOTXpvbfevlM+dKEN9w9hdHNdj/kZIHLqorFpLqYGXa3HNV9/jgCa6yhppKtPjBp1Px+9AG3xYAlYpeMJX74fbeHZn7mNUAoNAQmZcUEu8G39/vL8cQXh6xQqXucJE0VaBLyK8jzwVeuHdo3KqSs7R4HIxu85Vn1EINGSylU7USmd4ERJ0gFZWYl1bHF7QiikzOJwDAOi4D/jvHwiHBLDgU0Gg799XXplG4faKRaBjq1vzjOO1hXdiH0GW73uOT0I4vdyGWz1z392ferUHsOVI0PHanZYYLLwsNFog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vmTn3pslxQ2fRF+HJvcxJSmcLh6/4Ljii4dEtzUIHgo=;
 b=CvbEA2P/3eOdYioYE/20TCW4H6qVjsdIpUA3Vy2bTitzVIkvhSP0JkAh8hY6vbUmtkcBpaHGohS2pNzk43wBRnazBKObWZq5sSJ7/0y04vZR9eCf0p6BUFOzOXD0mz2NgAUIT5z9WcHiyC3xE4vwcFAVKKaml0KJ2UNOj5dm8Cg=
Received: from SA1PR03CA0011.namprd03.prod.outlook.com (2603:10b6:806:2d3::23)
 by LV8PR12MB9449.namprd12.prod.outlook.com (2603:10b6:408:204::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 21:20:59 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:806:2d3:cafe::64) by SA1PR03CA0011.outlook.office365.com
 (2603:10b6:806:2d3::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 21:20:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 21:20:58 +0000
Received: from work-495456.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 24 Mar
 2026 16:20:47 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <Bing.Ma@amd.com>, <David.Francis@amd.com>
CC: <Jesse.Zhang@amd.com>, <Jenny-Jing.Liu@amd.com>, <jamesz@amd.com>
Subject: [PATCH v2 14/17] drm/amdgpu: workaround for spm ring buffer overflow
Date: Tue, 24 Mar 2026 17:20:27 -0400
Message-ID: <20260324212030.822932-15-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260324212030.822932-1-James.Zhu@amd.com>
References: <20260324212030.822932-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|LV8PR12MB9449:EE_
X-MS-Office365-Filtering-Correlation-Id: 60566730-dad9-41ab-664c-08de89eb3e3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: IGU0/nUMPJ/Uodz2tiuiswV8BSR1eurMbTjOToi5s7gcyk0FhjkBqCvWqxuZfJHd0Y2B0FUrrf9h6S6WtX6GIVk9EZgwhVdVAKwPRXemdBmkboLo462bBbMOMqNV98g4uHH6+6OZ2zI0/nVgqhVG6KChGMRVDEaqfS28v9NvaquVva6NhmIiXx37kJQuBeTC8ULayQxf9G8hQ4C+QWsGXB11/FkZfXPK1FRh/b0wnZHEEd8NHO1o44tDoWmYnXopL+UMI1XSKuguuA6hvKV//spnnmJPo+Jjdlbi7Ck+zS9aNVsAejHSL6qT7c9CmuAUKESxQPvmX6nQ2sLjax1GmQ9PavA/Mp2MjXzPX2CrEDmv4lZNFp91tbgDE5CQT/lFosWoypWRCXxOVzr0OTRjO+laPrrqEjYFZvVVIu2FXiSNZrRU7rpRi8h+cF1NR+oIAzYaQaczlnnb3EvPBVKlhubtiEMkqAwmqS8zb9jrIQhxww4Jh1G+CQnR2rGDqgH2FKlI+x4Jgc/ABdwQECar8FnijYnTMV4xn5hbR0/YPObkal+jJBoYbb8iy7TvJr1KrSBQib3uF/dCeUED7Qi7G+Ioz5vewtGgrToPE7FGd0L0mDJD3HBQlcAO2lkS0lLcjbCzjxXLP+37IIj4+qnP/Ng3JGeVD4hqpkBe6JyEulnVgXbVGZIjJD7VvDE9mXGhWgOsvPdvZ+nCOkdel5B5672tbvnxwLc8qeTO/9AZq3yK2E/8ak/3nmcSU0aBWO/9sxNVgB0gl2WqK6E9k0Z7hQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9IwOO9PNL/Cmvg80JF9A27VTJDVUBxq+e3TeJ+0R3yRUFOZTf8pORQ26zBDXbRHQSVZ1F5FFioVfSWC56XP+yPtOnat1OnzG5uRJSE2pWWMli1STJmuRhrGDzVt8KlbdygYJsPHA+FnVnXzanhjuRXI/KJ7+k7dBejlOGSUeeF8XryeLd0+HBKgwDFkJGzc3PYmVmYZBEiZz2f1n+QAUOPOrmVBZUKbbOI0X3Fomg1apF7e2GMONZBr3XXp2jcIZ2JP45PkHGXufIti7UCOusJJOmQdEf5FOJC7s+KXoNSaEEblGqRD+lDcieKGAVHrNJv31kRLmwl7BhTB6yKICNV1K5exm7MBkRPxRxcbmJxDCVlBxrxzm02W15f/GshIzJqAwFlidK/yMyJnacjTO9T1Hp3nnQRiUAr3raFnLokOFFiCgkP1nt/nGtsdMOB2D
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 21:20:58.7144 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60566730-dad9-41ab-664c-08de89eb3e3f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9449
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

reserve space to avoid page fault and data loss.

A hardware bug on GFX IP versions earlier than 11.0.1 causes the RLC
SPM hardware to write slightly beyond the end of the declared ring
buffer when the ring wraps around. This can corrupt adjacent memory
and cause page faults or silent data loss.

The workaround reserves an extra 0x400 bytes (1 KiB) of guard space
immediately after the ring buffer's declared end, pads it with a known
sentinel value (SPM_OVERFLOW_MAGIC = 0xBEEFABCDDEADABCDULL), and
recovers any counter data that spilled into this region before it is
overwritten by the next wrap-around. The overflow size varies, the
overflow data is valid data, and the wrap-around write starts from
cpu_addr + overflow_size + 0x20 instead of cpu_addr + 0x20.

Implementation:
amdgpu_spm_init_device():
  Detects affected hardware via ip_versions[GC_HWIP][0] <
  IP_VERSION(12, 0, 0) and sets spm_overflow_reserved = 0x400.
  This field is zero on unaffected hardware, making the entire
  workaround a no-op for GFX11+.

_amdgpu_spm_acquire():
  Before calling amdgpu_rlc_spm_acquire(), subtracts
  spm_overflow_reserved from ring_size so the hardware is told a
  smaller ring size, leaving the guard region beyond the hardware's
  declared ring end. After the 0x20-byte metadata subtraction, calls
  amdgpu_spm_preset() to fill the guard region with SPM_OVERFLOW_MAGIC.

amdgpu_spm_preset(spm, size):
  Writes SPM_OVERFLOW_MAGIC to the guard region starting at
  cpu_addr + ring_size + 0x20 for 'size' bytes. Writes are 0x20-byte
  (32-byte) stride aligned, matching the SPM hardware's fill granularity.

amdgpu_spm_read_ring_buffer() wrap-around path:
  When wptr < rptr (ring has wrapped), scans the guard region in 0x20-
  byte steps to measure how many bytes of overflow data were written by
  the hardware (overflow_size): stops at the first 64-bit word still
  containing SPM_OVERFLOW_MAGIC (unwritten). If overflow_size > 0, logs
  a debug message and copies the overflow data back to ring_start
  (cpu_addr + 0x20) via memcpy() to make it available for normal copy
  processing. After the ring drain completes, calls amdgpu_spm_preset()
  to re-arm the guard region with SPM_OVERFLOW_MAGIC for the next
  wrap-around.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c | 42 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h |  2 ++
 2 files changed, 44 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
index 9f0d1f688d5e..9b7bb15a3785 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
@@ -32,9 +32,24 @@
 #define AMDGPU_SPM_MAJOR_VERSION	0
 #define AMDGPU_SPM_MINOR_VERSION	1
 
+/* used to detect SPM overflow */
+#define SPM_OVERFLOW_MAGIC        0xBEEFABCDDEADABCDULL
+
 static int amdgpu_spm_release(struct amdgpu_spm_mgr *spm_mgr, struct drm_file *filp);
 static void _amdgpu_spm_release(struct amdgpu_spm_mgr *spm_mgr, int inst, struct drm_file *filp);
 
+static void amdgpu_spm_preset(struct amdgpu_spm_base *spm, u32 size)
+{
+	uint64_t *overflow_ptr, *overflow_end_ptr;
+
+	overflow_ptr = (uint64_t *)((uint64_t)spm->cpu_addr
+				+ spm->ring_size + 0x20);
+	overflow_end_ptr = overflow_ptr + (size >> 3);
+	/* SPM data filling is 0x20 alignment */
+	for ( ;  overflow_ptr < overflow_end_ptr; overflow_ptr += 4)
+		*overflow_ptr = SPM_OVERFLOW_MAGIC;
+}
+
 static int amdgpu_spm_data_copy(struct amdgpu_spm_mgr *spm_mgr, u32 size_to_copy, int inst)
 {
 	struct amdgpu_spm_base *spm = &(spm_mgr->spm_cntr->spm[inst]);
@@ -79,6 +94,7 @@ static int amdgpu_spm_read_ring_buffer(struct amdgpu_spm_mgr *spm_mgr, int inst)
 {
 	struct amdgpu_device *adev = mgr_to_adev(spm_mgr, spm_mgr);
 	struct amdgpu_spm_base *spm = &(spm_mgr->spm_cntr->spm[inst]);
+	u32 overflow_size = 0;
 	u32 size_to_copy;
 	int ret = 0;
 	u32 ring_wptr;
@@ -110,6 +126,22 @@ static int amdgpu_spm_read_ring_buffer(struct amdgpu_spm_mgr *spm_mgr, int inst)
 		size_to_copy = ring_wptr - spm->ring_rptr;
 		ret = amdgpu_spm_data_copy(spm_mgr, size_to_copy, inst);
 	} else {
+		uint64_t *ring_start, *ring_end;
+
+		ring_start = (uint64_t *)((uint64_t)spm->cpu_addr + 0x20);
+		ring_end = ring_start + (spm->ring_size >> 3);
+		for ( ; overflow_size < spm_mgr->spm_overflow_reserved; overflow_size += 0x20) {
+			uint64_t *overflow_ptr = ring_end + (overflow_size >> 3);
+
+			if (*overflow_ptr == SPM_OVERFLOW_MAGIC)
+				break;
+		}
+		if (overflow_size)
+			dev_dbg(adev->dev,
+				"SPM ring buffer overflow size 0x%x", overflow_size);
+		/* move overflow counters into ring buffer to avoid data loss */
+		memcpy(ring_start, ring_end, overflow_size);
+
 		size_to_copy = spm->ring_size - spm->ring_rptr;
 		ret = amdgpu_spm_data_copy(spm_mgr, size_to_copy, inst);
 
@@ -128,6 +160,7 @@ static int amdgpu_spm_read_ring_buffer(struct amdgpu_spm_mgr *spm_mgr, int inst)
 	}
 
 exit:
+	amdgpu_spm_preset(spm, overflow_size);
 	amdgpu_rlc_spm_set_rdptr(adev, inst, spm->ring_rptr);
 	return ret;
 }
@@ -169,6 +202,12 @@ static void amdgpu_spm_work(struct work_struct *work)
 
 static void amdgpu_spm_init_device(struct amdgpu_spm_mgr *spm_mgr)
 {
+	struct amdgpu_device *adev = mgr_to_adev(spm_mgr, spm_mgr);
+
+	/* pre-gfx11 spm has a hardware bug to cause overflow */
+	if (adev->ip_versions[GC_HWIP][0] < IP_VERSION(12, 0, 0))
+		spm_mgr->spm_overflow_reserved = 0x400;
+
 	spm_mgr->spm_cntr = NULL;
 }
 
@@ -194,6 +233,8 @@ static int _amdgpu_spm_acquire(struct amdgpu_spm_mgr *spm_mgr, int inst, struct
 	if (ret)
 		goto out;
 
+	/* reserve space to fix spm overflow */
+	spm->ring_size -= spm_mgr->spm_overflow_reserved;
 	ret = amdgpu_rlc_spm_acquire(adev, inst, drm_priv_to_vm(filp),
 			spm->gpu_addr, spm->ring_size);
 	if (ret)
@@ -204,6 +245,7 @@ static int _amdgpu_spm_acquire(struct amdgpu_spm_mgr *spm_mgr, int inst, struct
 	 *  and are instead part of the Meta data area.
 	 */
 	spm->ring_size -= 0x20;
+	amdgpu_spm_preset(spm, spm_mgr->spm_overflow_reserved);
 
 	goto out;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h
index 5eed6aa6482a..f00a4751643e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h
@@ -61,6 +61,8 @@ struct amdgpu_spm_mgr {
 	struct amdgpu_spm_cntr *spm_cntr;
 	struct work_struct spm_work;
 	spinlock_t spm_irq_lock;
+	/* reserve space to fix spm overflow */
+	u32    spm_overflow_reserved;
 };
 
 int amdgpu_spm_ioctl(struct drm_device *dev, void *data,
-- 
2.34.1

