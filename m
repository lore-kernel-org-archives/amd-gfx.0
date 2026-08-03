Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2931FC5518F
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Aug 2026 10:24:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFE4C10E051;
	Mon,  3 Aug 2026 10:24:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E3oMPYfu";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011064.outbound.protection.outlook.com [52.101.57.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6FF910E051
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Aug 2026 10:24:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ooeKejHOiX7DJde254ZgU+NcX+jQuy7IgcKW/zIHsVCAypmppxM2N1mFo6rPE4J6feqYUNR1n7vsbVTRchCphurJvSTnhWA6DDohfqV4G5MS8jka0cpQV2e0B/v1e9H0Q6QGajXpXDXTNuLzYtre9T6UJCQQjSiThuljxXiotm7VCerqE5cL/5B2WNYkxpv8U/1pGCBtfx9kDGxjBrTQxmhi3fTeq18ctRnRcHyEmH0pVzxDMDq/pTK4mxZ/oJDYHpbMNfHtn5S/lUvKJfGQQ9y9VtO1PGnHEXczmVdXHS5Wu1QsczJbuFFGVSMzN53JrQIKprkYfd9Xf20EP/VUOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M5B+s4DW0zWGSr5/Xc7VHmhu0KDJ0iAoOX9TOd8boFs=;
 b=MhZZ0vt9bUxgwFvHjCKBjNxC28HhpuDtNvwW6li/PoCOEGvH4JTWl/RJ+8Otp1r2cRa3Y3BURMO9tbn7DK7wyvoWv0RQqUYCVL7/u6QihjYYYW5Pwp9tkr5K+qwxTjZ6HpYpvuwbG0vCQFwpQBfpTGRAbvFEXWisY7EU1JGJ9QEmJ04DdyNbnkT/U9emqSiQjuBaU/uAbHV3rM+udzPiPp07Jn+976SyHUwZs+1etraqYGmBXzDk9v9lE2SLEENuIjWuj33KqhHd2WmfA6uYZQcA/GNSX8PgokUw//hxrDfLi4as6QskUDrI3JfbfSu1l3ksMfJNRrTwa7DeDJiJXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5B+s4DW0zWGSr5/Xc7VHmhu0KDJ0iAoOX9TOd8boFs=;
 b=E3oMPYfuDeiBXLweY9QVIsGvBUzHglDrCqzBFQItNhgXF8pQyJ9937cYTCuZZMwxQTtUBQ+mtjbXx5KbOGf5C/Bk2jHXCWftYnG6KIfVAdNgfpqHbpRtBUO/tOyWBfuprnhx9Mnnx4VMCUzEkcAGVYd2M6lw7LG2nJqqyjFiGf0=
Received: from SA1P222CA0158.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::18)
 by CY5PR12MB6226.namprd12.prod.outlook.com (2603:10b6:930:22::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 10:24:32 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:806:3c3:cafe::5b) by SA1P222CA0158.outlook.office365.com
 (2603:10b6:806:3c3::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.18 via Frontend Transport; Mon, 3
 Aug 2026 10:24:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Mon, 3 Aug 2026 10:24:32 +0000
Received: from canli-build.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 3 Aug
 2026 05:24:30 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alexander Deucher <alexander.deucher@amd.com>, Candice Li
 <candice.li@amd.com>
Subject: [PATCH v2] drm/amdgpu: reject oversized IBs with per-ring packet
 limits
Date: Mon, 3 Aug 2026 18:24:16 +0800
Message-ID: <20260803102416.3776005-1-candice.li@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|CY5PR12MB6226:EE_
X-MS-Office365-Filtering-Correlation-Id: cb1ceae9-1be8-4aa2-5ef6-08def1496875
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|23010399003|82310400026|376014|56012099006|10067099003|11063799006|6133799003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: coglR/HqCGwaFBX7miHEiu2/zXdvsMGd1tizB4+pjQKOPpvhaqoEc4kjKfAxKva0rwTWzlPYVrBXppGZ2mYyZ38xxwDaLjqu6JFldQ1+hCFPTY31n1PtEM1hfrLXKNlyK2Xx7j7Y1BzQaEDKGYuxpWVEGIQ092X4T5auvr9NpA7Pec8zkangz9IoBE3bPaRd+NGHpUIOwWidNhJj8Hgj4oce3Fyjz9sBGqrrpGLPJ/WasXUTluwqVi1M0VMNYKwHEd/XWc0ohEa127murLLs1bmSsrhxAt4RovLlJHgaoYV0asgXyV5vt6hAx8a/Se+wbx3G4ws6ddlH+WvCuDL6k0sBJu0ngJMuBaGjJhOZxE4W78mj/MGhhPj8MtnNBZiTwz5KCN7DhqBi1fwxmW2BqXmxFdsmldMnoMZ27iEky9tLLcm/6yexUrg6ov3zTqXTtxWHkwjBVenGVeaOYz2ffea+wx9SyWCSXOwbkDCguawynjkJwLMltXOCgE8a1uVdu2ImwQ6+1w7rD7mQeOh1fCt3RXWS71eXG1ovEpQ+eZoKnRYbqS8zA9+L4A+aasfIw2FxPIxEMFxx7rxT2jXUYC1EfUbry+HhiFn9AC95jlWDCIFOx7jLtvhFTgaLIP/ZfLMycldwnnhHAM/rMXdNuDybdc+CgXRML0LrzWLvj189z+SqRcW0yXZsuD8+QBPLjCvASRdeQ3HRDyANZILV2g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(23010399003)(82310400026)(376014)(56012099006)(10067099003)(11063799006)(6133799003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7aSUuJpLpYJvJb29eqlT6ZFGSH1JD8wIrWLf7/2J6dTIw/9vdho2UXAEs6i8n/cLLL7WrbbJjlbybeAFdX2PHQYKGmM/y5SijbRv2VFB07knvGos4qau4e9z4eT33HURFc8ghwB4pXC4ofNdCy4Iy6eG6MSwDoVFYa5n2+JcxZM8EfkBF6vhZHQp3Ats1wKnPRiM7V28T9STxuShDps1vWedMiPootCWkvgyKEjqFtyNnxxdBAzSzmxjho1zz+VQb2szKOSadBWwyuvY408AXaKRVRxHkzRRPHlPonm2gpJQ4Hxn/DGCga7KT6zR0Mq3zAtZu39HDwHHhtmBVMGr45HnfPsHh8M8aCnJX83F+8dc9ZlYG+PVw2Sm26RQy+0MyYmLdUku1L6/gj+KwawA3mA8z7Y6cUGsgzmjBEi9sIAHt6k5XRRiyPWN8SW9jmIG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 10:24:32.0292 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb1ceae9-1be8-4aa2-5ef6-08def1496875
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6226
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

On GFX rings, amdgpu_cs_p2_ib() passed user-supplied ib_bytes through
to ib->length_dw without a limit, while ring_emit_ib() encodes length
into packet fields. Oversized values can corrupt adjacent control bits
and destabilize command submission.

Add a per-ring IB packet size limit helper and reject command
submissions exceeding the corresponding dword limit before IB
allocation. Use the documented 20-bit limit for GFX/compute/SDMA/VPE,
and apply the MM fallback limit for other ring types.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 27 +++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index afc1c631d55aa6..617f53f135f353 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -42,6 +42,26 @@
 #include "amdgpu_ras.h"
 #include "amdgpu_hmm.h"
 
+/*
+ * Maximum IB length (dwords) for rings whose emit_ib packet format
+ * documents a 20-bit size field.
+ */
+#define AMDGPU_GFX_SDMA_IB_PACKET_SIZE_MAX_DW	0xFFFFF
+#define AMDGPU_MM_IB_PACKET_SIZE_MAX_DW	0x7FFFF0
+
+static u32 amdgpu_cs_ib_packet_size_max_dw(enum amdgpu_ring_type type)
+{
+	switch (type) {
+	case AMDGPU_RING_TYPE_GFX:
+	case AMDGPU_RING_TYPE_COMPUTE:
+	case AMDGPU_RING_TYPE_SDMA:
+	case AMDGPU_RING_TYPE_VPE:
+		return AMDGPU_GFX_SDMA_IB_PACKET_SIZE_MAX_DW;
+	default:
+		return AMDGPU_MM_IB_PACKET_SIZE_MAX_DW;
+	}
+}
+
 static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p,
 				 struct amdgpu_device *adev,
 				 struct drm_file *filp,
@@ -340,7 +360,6 @@ static int amdgpu_cs_p2_ib(struct amdgpu_cs_parser *p,
 
 	job = p->jobs[r];
 	ring = amdgpu_job_ring(job);
-	ib = &job->ibs[job->num_ibs++];
 
 	/* submissions to kernel queues are disabled */
 	if (ring->no_user_submission)
@@ -369,6 +388,12 @@ static int amdgpu_cs_p2_ib(struct amdgpu_cs_parser *p,
 			return -EINVAL;
 	}
 
+	if (chunk_ib->ib_bytes / 4 >
+	    amdgpu_cs_ib_packet_size_max_dw(ring->funcs->type))
+		return -EINVAL;
+
+	ib = &job->ibs[job->num_ibs++];
+
 	if (chunk_ib->flags & AMDGPU_IB_FLAG_PREAMBLE)
 		job->preamble_status |= AMDGPU_PREAMBLE_IB_PRESENT;
 
-- 
2.50.1

