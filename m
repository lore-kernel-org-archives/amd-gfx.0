Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28869CD5BC8
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 14:12:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A85C110E689;
	Tue, 26 May 2026 14:12:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T/9u5COQ";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011000.outbound.protection.outlook.com [52.101.57.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C0A610E68E
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 14:12:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S+feSn/eJBS8bdWb3ATXrYicMA/oQZU5lBoKFHd95ie5GETyZOJ4oaa2PWFJYBX7zCkILIKoi+cpTx6pLXUz+pcJiJ+Ae6J5Dy/68PlVFpNZhlkKnsY28Z2Y2vvNBUJ6TIpCobKT9UorTdAZJmCu+NQhFotJlSee6JV1xHq5gLd6bImzYgWe4zLhco43pqMZvWd4wgU/W89iAJaWC2DNV55LxbKvhNgYh6rmrmej64XwH5VcD1W9klOWRN4sRoGNCg3uqyA3n+1a3Aa3buvrCw8J4Yu3cDTfZ1pGqFXhjpv/ietmzp3LDTqRtqmyPDrvueptUy2bxl59D8LBgThj+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kWMFrl5AWI1SpN5BxDji6Rvc9+yORHuxW5A9xa2NZfk=;
 b=aC5q3vdFhX7tPqdmNe2acnSKvEA3R8/H3A++uX74AfVo1jIt3Wv4UulYVK77cxPN3TF+OLY/eojZ+RqOd611lV2TMwPRAvHRYbiDOu6sSto+db6wC6ABZeLfW9MCW8vjdD5xOcHPfUP2LwV6N23ndCRHawuP3UI8XnKKIwFT8mhUibhNRVwdZgsemlcY5OlLyh6WDvYqfXqLpHKcYmoqD5glgUdg5/awcFhunjeRKG3MWLu+iCSnvDR/wvMUP/2NtVs2bU7Ww7qRQoTFoeCLMQznGdNnkajqTT0L9ISrnNH3x6Aqr/OZSROaDcp+TZVQKYIRkclikP8b+0oTcv+Lmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kWMFrl5AWI1SpN5BxDji6Rvc9+yORHuxW5A9xa2NZfk=;
 b=T/9u5COQaeB1iD+gC6vPJi12QT1asScepQAn6Pyun0b62UF9ohHCC/w7NlPY+bxZfqFBKitwmNY/vD80UGs00+D5JKvWsMcCmLFmcu51PSMQIQWAD1u5kxCDxf4HbW9LDGSi/kcs4cWWVFC1Y3vdi2OkYqmiAy//ijP3U+fT5Q8=
Received: from BN9PR03CA0679.namprd03.prod.outlook.com (2603:10b6:408:10e::24)
 by BN7PPFA8145BD40.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6de) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Tue, 26 May
 2026 14:12:04 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:408:10e:cafe::86) by BN9PR03CA0679.outlook.office365.com
 (2603:10b6:408:10e::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.12 via Frontend Transport; Tue, 26
 May 2026 14:12:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 14:12:04 +0000
Received: from work-495456.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 26 May
 2026 09:11:54 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <Bing.Ma@amd.com>, <jamesz@amd.com>
Subject: [PATCH v4 14/17] drm/amdgpu: workaround for spm ring buffer overflow
Date: Tue, 26 May 2026 10:11:26 -0400
Message-ID: <20260526141129.592886-14-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260526141129.592886-1-James.Zhu@amd.com>
References: <20260526141129.592886-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|BN7PPFA8145BD40:EE_
X-MS-Office365-Filtering-Correlation-Id: b2e3de44-4f06-4af7-d9c4-08debb30c376
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|11063799006|3023799007|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: ZjO5V0ptAN8Gw2VXD700+BxmCa7GfctOZlJf9ln+tqfo0i42xJtqkI0SmXK1IMPOEF9xAM+4AmAz79xYn3Lfrb61sKZbQLsyeTpbF4uc4E0JFLktE0Ke1Nq5QNNcv7CHk4FnSDun9aYqk9k0kQQJtGNqrF8/97+cHw9TZwfui52x46ls0JN382fACMw8LlgdHnIUEPFiV4Yfaa7p/O1Lp55C4XpCt3OP/Ir44FjX7bOVsImNUrH5o7H5mUzXfle3o84dkYirXqsb47Iu0FAHfPTMRTWbJWZWh90W0y0DVV175qfX6JbqOKETIaDuJ5VsUm/j1G05zrdGu8UjE24IdVTfhE7V8sm1xsmCKHErG3MpKKxjKIXxweGpmdMv9WYEG/87H29EsDUIOYWPh0VKROxH4mOrQm2A2SNcC+pkRa0Pt/GknJe85oIKGmMnZmeb2uloKrPOTzUaznInVFwCxmvySG3pGxt43h48CND0N1r3Xs//OYv+QefubS2l2MwEF3/YA3Akiy4j4Dy1mgrzfb7phAKuA1zUdN8NaGGAdz1jU0QkiiOR70WgegIWaU6fXJ9PUa+Gu1po/8g2PRMBSf4f54rbgfNzH7GLv6QVBRPve6qQAYKpxE8x8OiDq4giXoclK0kUgrC0Wx+KZlnXR5EZUu0CN/QR+TN6FWG1PdNN7yTqqwL7wbHEvGd09EL37ORCcDhiUR+iWwKUsoqXrn3ctkB6l4maUTOpDQiLtzc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(11063799006)(3023799007)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +pn8sjd7y8863u1+3ayFx1tba0NkT7+7qfUcJAk0th111fpbKvBh90r2/gEvwoX4DVpVuPekct1jCUfH1Q57mS/aD+fpq6vtcQxNLBs/fmuqLRfiyIx6zw89FtiUsQR8e0SOk0K8TYDfaXVhNnbneHBASI/MfKDxgm+fKHdcfFtig/+14wWFjgim1Vq5674d3Y3OtIDyW8QeBuc5ZVkSpDeKLCPAl5BQq8LHwC94cRFXJoYC4h+fUCA5Mk1An5OJjSX0EQ2iELCPHRQ17XEyq7Vpcdu6X9oMPVC8H18VleeTIB2rCSLHAR61nXBxzwycGFpNbQbZgPj8BIykf+sdZZWll/b8wIF8U6S7W7fVEq2LQVGR+i3T2r5tIvhWcbLDS3sQVXzB3ob3bzaw1Obsf12eSJJb8RFakCG5djPn3T2pLwoeiR1+dmB1mIsOKZam
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 14:12:04.4941 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2e3de44-4f06-4af7-d9c4-08debb30c376
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFA8145BD40
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
Reviewed-by: Bing Ma <Bing.Ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c | 42 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h |  2 ++
 2 files changed, 44 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
index 4a04f53b3df9..cbe7a2b61bb8 100644
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

