Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5874E9DE7B
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2026 09:25:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84EBA10E6D9;
	Thu,  9 Apr 2026 09:25:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QO0BGpqV";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013003.outbound.protection.outlook.com
 [40.93.196.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE85010E2E9
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Apr 2026 09:25:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xK4COkoybCTsm63SPtyZBohsXRG/JqX7j23JRSnTXWGYqf1GJLXsajkMSsXud24D7q2kz5qbvowA1qd04+yMZD2w4EShymo3JZd3gOlpMAgpAjDfSD5ko4MMvOD+ivmP8u6oM4ZOqQxj2BBuLcVvtB9r9ZWIGISLaEecCoRlAFQO0Hii5Di8jDfVooXxFMH5UXTSlRssN3CUz2i1iNCVHYvkm++wWkH9+9czR83tp6BeTFg2d+3Aji+TRJL1AX7aN+8Xixqi/Xu52xgWYKZ9rI9Uo68Fceg+P0rtdhvJIlzfRhnGfTXc7oOY+WJMjRfYJ7CWSbzRVbdaPGrF5cZkrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tvBpgo48HxTx3jk9duMHbo8+De2LxQ713mDALhabYx4=;
 b=SkCEgngHOu4xMi+Rva6/Gpadl7gSrAe0u4/rlV/bPHa3Ylqe2im8AaBKoxcCQf9102ilX+Df2e5nnm9hu3stu/rimnFT+3AE/GfIQP+oupmND2ZX+kPW7xac8wJuhEOnuNS0EwrGmbmlSWTrbJ5PBiEf8IZmDZAFBVeXvL+noGxRGUzlA6zoKVdCEzJma9XMLB20j67QgkCwW4m1ahzaAVH+3ZabjPqB7gHfA0qbN4s1qTI9W64j3fPQ70RjWiqz/8XKZo1o2j3FdK5vsxx2yS1w7wqpxQOe45LcljO2NM6NvWPtH0cw+SowqgtTs5QmcdPB9skfMZosv2EosY2T5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvBpgo48HxTx3jk9duMHbo8+De2LxQ713mDALhabYx4=;
 b=QO0BGpqV8Ji+vabRbiSlBPhSIwSqcvFxw2VYeqeN58Aj95KRfruUKX8YtoBWdXdXkE/t0BccqKBnVJYnWASdot0g9BpSngc6cfsiyRBYfuHGDjMZVMXas1hiE8PWTBLkiZdXpxNHgjeR4yiawCZSW9+eFFXAzzR9AkmcHnfZkb0=
Received: from IA1P220CA0020.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:464::13)
 by LV8PR12MB9420.namprd12.prod.outlook.com (2603:10b6:408:200::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 9 Apr
 2026 09:25:01 +0000
Received: from BN1PEPF00005FFD.namprd05.prod.outlook.com
 (2603:10b6:208:464:cafe::78) by IA1P220CA0020.outlook.office365.com
 (2603:10b6:208:464::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.42 via Frontend Transport; Thu,
 9 Apr 2026 09:25:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00005FFD.mail.protection.outlook.com (10.167.243.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 9 Apr 2026 09:25:00 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 9 Apr
 2026 04:24:59 -0500
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH] drm/amdgpu: fix CPER ring header parsing
Date: Thu, 9 Apr 2026 17:24:03 +0800
Message-ID: <20260409092403.572319-1-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFD:EE_|LV8PR12MB9420:EE_
X-MS-Office365-Filtering-Correlation-Id: 06bec14c-293e-4af2-b677-08de9619e00a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: UTt1MjFNCNNV962EgFjt4YkHm2UnN/HU+aBYgflwMzkU07xuj7qiq3DoZ7rDiQ1jHUkkJAafZr7wHRsAtgr2WT026t/4oBe/+Lzk+EkQ43zPutnmWL9lZRwrttGQNn8LCpEfx/rHgrDWePDT4nnjjotlFlHeuNcckgttggn05SRyiDBc00R6Ryil987cc3NrQ3VTAVGclRd3JQYh2PRQWoW7UXW07uOROyA3cON1wHVpTObXDKNOfuY0MpBqb8yNXKY9pY6yldP57RB5pEeJS6UPA8DL27WrFCJjsheyEhlUgOEZejWrr3FovOhyhFHzIJSvGh8oJkIAfPROC+P4zOW+hRjvT/OTGiOvBgTaVE4b6gPHWTN7uv7iYm2UKl+Vzf8FnrqczaBYZGvBk9jM+XTu47J53ZPSga9lDjGVxM2/awJGDYsE23BhBxAXFwrZJxkebJyJRMJBsWMC2jkC3gDtAfJ5+xiZj/iYurMwGA7RepxJQJvgKPzlfeVBYHw25g4KVvFJuXGAzdA+OdMZwWbfvmkftOCyqDAlxu0QrmmW/nAmqPC1xRLw5eOxrw9kjgm5rS4f1uvqhNimiIz50/3TPWrrbobANr3kU5mFZ8KapkreHySZ6F5rtxjP3Bi8Is6p5FXS9xwXQni4OIpsB+GHzHEW5FfysJLuMOH337IKFCZZjxXhMF5AuPpMO7igoMs/3fec0jWSh4OwsiB5k0uRu13+HWhtAMiPwxfTCwQ/v/NUFPSftA6UlBpOg0JP7SXbtjYyuKlh/pbRvRDEaQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KD7hQe7T/TlakyoTFFwNplESp/3hr2K9/ZZ25r146Je2sGNcRZfN9trF/NemDt1ju4CD8HgkWE26x8o4JG18ji8IViObsVcUFA0Wd+yfFXOlSPgPmz1BnSxg3HZDO02d6vZIpeKX3EE4RhurnaK/z9Hc4+8Layt/9B9PgbDBe/fK/CI0bMWD40z5DAC71WitsZYlrZ09CeMcXgd8/x0QsqCRWT3YGkQxUUGo/RtqTTc3+fBWYFFifbGc2Fcd+mdXLf4ogL6JVf1FcIP2iBQxDAkOoHY9ZtBsqa2nwmYU1NlhPrc4jPJRy3Mc0Plt6zdDtIlmkMlOScdS2zo43R8ujaOaZAWv1ODVNP2ZhHn2e/vWGWOzAPkKYxkqWdCLdHw009cjlnZ4dd2YGZZ1pMmP9yyWNsfVjsVu93HPPO4/EavGl+z9gSAUPKp8b11g9Wb9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 09:25:00.9923 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06bec14c-293e-4af2-b677-08de9619e00a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9420
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

amdgpu_cper_ring_get_ent_sz() parses CPER headers directly from the
circular ring buffer to determine the current entry size. When the ring
is full and the write pointer lands near the end of the buffer, the
header can wrap across the ring boundary.

The existing code treats the 4-byte CPER signature as a C string and
uses strcmp() on in-ring binary data, then reads record_length through a
direct struct pointer cast. Both assumptions are unsafe for wrapped
entries and can read past the end of the ring mapping.

Fix the parser by comparing the signature as raw bytes and by copying
the header into a local buffer before reading record_length, handling
wraparound explicitly in both cases. This avoids out-of-bounds reads in
amdgpu_cper_ring_get_ent_sz() when the CPER ring is full or the current
entry starts at the tail of the ring.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c | 34 +++++++++++++++++-------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
index 35fed4a05e1c..54ee4f7e7a0f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
@@ -426,23 +426,40 @@ int amdgpu_cper_generate_ce_records(struct amdgpu_device *adev,
 
 static bool amdgpu_cper_is_hdr(struct amdgpu_ring *ring, u64 pos)
 {
-	struct cper_hdr *chdr;
+	char signature[sizeof(((struct cper_hdr *)0)->signature)];
 
-	chdr = (struct cper_hdr *)&(ring->ring[pos]);
-	return strcmp(chdr->signature, "CPER") ? false : true;
+	if ((pos << 2) >= ring->ring_size)
+		return false;
+
+	if ((pos << 2) + sizeof(signature) <= ring->ring_size) {
+		memcpy(signature, &ring->ring[pos], sizeof(signature));
+	} else {
+		u32 chunk = ring->ring_size - (pos << 2);
+
+		memcpy(signature, &ring->ring[pos], chunk);
+		memcpy(signature + chunk, ring->ring, sizeof(signature) - chunk);
+	}
+
+	return !memcmp(signature, "CPER", sizeof(signature));
 }
 
 static u32 amdgpu_cper_ring_get_ent_sz(struct amdgpu_ring *ring, u64 pos)
 {
-	struct cper_hdr *chdr;
+	struct cper_hdr chdr;
 	u64 p;
 	u32 chunk, rec_len = 0;
 
-	chdr = (struct cper_hdr *)&(ring->ring[pos]);
 	chunk = ring->ring_size - (pos << 2);
 
-	if (!strcmp(chdr->signature, "CPER")) {
-		rec_len = chdr->record_length;
+	if (amdgpu_cper_is_hdr(ring, pos)) {
+		if (chunk >= sizeof(chdr)) {
+			memcpy(&chdr, &ring->ring[pos], sizeof(chdr));
+		} else {
+			memcpy(&chdr, &ring->ring[pos], chunk);
+			memcpy((u8 *)&chdr + chunk, ring->ring, sizeof(chdr) - chunk);
+		}
+
+		rec_len = chdr.record_length;
 		goto calc;
 	}
 
@@ -451,8 +468,7 @@ static u32 amdgpu_cper_ring_get_ent_sz(struct amdgpu_ring *ring, u64 pos)
 		goto calc;
 
 	for (p = pos + 1; p <= ring->buf_mask; p++) {
-		chdr = (struct cper_hdr *)&(ring->ring[p]);
-		if (!strcmp(chdr->signature, "CPER")) {
+		if (amdgpu_cper_is_hdr(ring, p)) {
 			rec_len = (p - pos) << 2;
 			goto calc;
 		}
-- 
2.34.1

