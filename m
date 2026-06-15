Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DB07CD98E0
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2026 23:57:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5F8A10E6F1;
	Mon, 15 Jun 2026 23:57:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MX88HC0x";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012040.outbound.protection.outlook.com [52.101.53.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DA3510E68E
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 23:57:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jUOlwx72Ailw2KAYesf4OXnt3FWlyJJmWJ2l0JTcmFHuakjiPhkDksZGu5aaqWtWvwcEHQz5z7uFoU0BMSPCtW+uBxeDpuSMK70tPH3urXTyCTrPqyi6UKsKePbACeHJdnL6PusxQEMQZztOpCfcLjm25bU8nJPc04rSI26UY5m2a6o6GcA9N3YPnMMbJxou3z4vPPXj+4XulgTP4/09/WjGvTgbciUZXW/eDg+8weOhmBAm8SFRm6u2DWWH0ucamfxwWYlk8AdLaedmTpWw5oqQDB1kcJVRC2BFbQUrER7EpP5F+NATK/jRcXRIKnr19SW4wugPAxbuwMY/eV6f0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YCZxXe2eB1Jw6JmU88vpv1HeNiUZjHMLG+fjKDIWeH8=;
 b=NjwM0MvkANtp/VzEwp5KogOGCh/OgWZZVWpFn4hLlYexl3wi+mrihI/wabsm7nTmpXPnwueuV4WvvMehuoxRfwR6m0RCjF1D3QSN+sqR8CBkHDwntaQeZzRhvjYdLGNOrpzwSoi3djBmbb5mpaOz8rgFNJ3yAQzAilGwGFrRn+UXsd3K1ZBweT9N50wixP0+z8j6qQF1/GLWBqRU3KCC2adN9RDx/v9HNSBHZ/FrPXTRuDJ17EAEXeSPmKYpupuZ2tyenTqQJ/LI71eHwuuO3ihOMmTYaPLhcPsYBvYNMhKYwJaj2OUUxK4spe+4As1b6vzT/B0hy2y9x+r+mXbUbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YCZxXe2eB1Jw6JmU88vpv1HeNiUZjHMLG+fjKDIWeH8=;
 b=MX88HC0xq0GPuxV9ATU19aVpyyZB5qjAhk2LW/sVE57mvxLqOl2lPylxZ8ade5GML1ygTWijHiyxzanAMX2iCt4Bjxbws8WDyXvU6/AdiE6JtVoiK8yLnyECC79qjiY8u3kwDOWyXn+FsPxJGPzIRC8I9rpXS3JhvyIz/BneRuk=
Received: from CY5PR22CA0053.namprd22.prod.outlook.com (2603:10b6:930:1d::21)
 by MW4PR12MB7360.namprd12.prod.outlook.com (2603:10b6:303:21a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 23:56:57 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:930:1d:cafe::a9) by CY5PR22CA0053.outlook.office365.com
 (2603:10b6:930:1d::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Mon,
 15 Jun 2026 23:56:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 15 Jun 2026 23:56:56 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 18:56:55 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 15 Jun 2026 18:56:55 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 07/43] drm/amdgpu/gfx12.1: replace BUG_ON() with WARN_ON()
Date: Mon, 15 Jun 2026 19:56:09 -0400
Message-ID: <20260615235645.737189-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615235645.737189-1-alexander.deucher@amd.com>
References: <20260615235645.737189-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|MW4PR12MB7360:EE_
X-MS-Office365-Filtering-Correlation-Id: 144399b5-23bf-423b-bd66-08decb39c849
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|1800799024|36860700016|376014|22082099003|18002099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: aZXX2WUAG06+OgJBh15Tk3yn11Mq8cicBWbKg/Rhu55ajqLFJj0v/UYoAzxAhd/I3MGrJBXwkR72EjsWJqwSpYXNyoDZ20phvdT6HdBMg6fyGcyTm8c+UFDpAqkouoxwkEBl/VQn3H7ztwf8globsslJnlP3pOdx3LnjcJxyItkoYo03eEU96eLvw6/LQ2rTd8xFHg/3RZIPnBunDw7al5lFR6K/hH4TSmYBXuc8gXAnK0HJFgoWwU9MhgAALBqxsHv1KuBjKAqQvD8SMYB6LvEL6aENPS/1vgKJi3WA4rHlDqI9OdxO3WibfmXLSlHkJlfbvc5EzQa7UjKPHLDOi8sT1xJHAdrnOpwkj3DcXTu2YUcpXigpPgJACE6dNVtj3CTV4+oJuvipvU8axj2FlanYU7cD/ls1+jtvQn83NN47hyMVr7QcXtWF5AVPQCNX05NGuLDlsVYJvTJuGS4C56EZI1sdAhDqWo2kUxI7BO8xdSj2Yh0AJjX/BX/NSvbkwao3iTnsoomARD3R19mCDHaAMLDq+2ju7M0ov6jEpiuSBz1REv+c9TOab6A9zgTbM0CUQTH1e+OZmc2wlXR86fb02Ow/lyBdEWA7BV8QLfvcRi9izm6QN81IfkCH7CraB000nhzEnFZUCAj8rKgRkWXfSwWYeqyflqLkUxLwRzagGhx253OKg86xVqNbGgtwaE0dnB7fobGCvXe/trmQbTeP4ach/Y5BmQ3rok/Ri3E=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(1800799024)(36860700016)(376014)(22082099003)(18002099003)(6133799003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8ZAaLtJsFpHT7tqBAGKOLyqCUos+jEQQQA/ewwZHaZGQaOnTVLjKDrfygo9cD+L3bOkckrDCMahKdfc6lW443cYRLom0KnYsMXFISa/veBDO945suphec5ekiDGjWq5H7JQ6/VCpfeBbVMECdmGwZMX4XQJ4XdaHzvvF/ojTY+s1JZd2wdx6GBKbZ6Mq81sRFoyVLLBEE6kXSGpYXXlbiWOzHRJauF9Bk0hcpSVv2V4I0H2UwaI0/RRT1OUsgPY796UxqrhRujidbeJaDeT3I4ofMWS9WMcL9SAbCJymDaDnrCvAvzFgNWYMPFIoMBxwV6Wjqmb3p4P1vPzrAfcx2yMxoYOa57C0niJEm07/aS/LSvv4zwl6o7SeCYQg8HhpiMXdUGUx9nVaG7vT3A+cn75o1pbEV5JenYCJqOXEaqffbZ8ZktcTtrYOWqOWLKTn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 23:56:56.6705 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 144399b5-23bf-423b-bd66-08decb39c849
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7360
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
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index b4382b751614c..4f090bb1f48c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -248,7 +248,7 @@ static void gfx_v12_1_wait_reg_mem(struct amdgpu_ring *ring, int eng_sel,
 			   PACKET3_WAIT_REG_MEM__FUNCTION(3)));  /* equal */
 
 	if (mem_space)
-		BUG_ON(addr0 & 0x3); /* Dword align */
+		WARN_ON(addr0 & 0x3); /* Dword align */
 	amdgpu_ring_write(ring, addr0);
 	amdgpu_ring_write(ring, addr1);
 	amdgpu_ring_write(ring, ref);
@@ -3435,7 +3435,7 @@ static void gfx_v12_1_ring_emit_ib_compute(struct amdgpu_ring *ring,
 	}
 
 	amdgpu_ring_write(ring, PACKET3(PACKET3_INDIRECT_BUFFER, 2));
-	BUG_ON(ib->gpu_addr & 0x3); /* Dword align */
+	WARN_ON(ib->gpu_addr & 0x3); /* Dword align */
 	amdgpu_ring_write(ring,
 #ifdef __BIG_ENDIAN
 				(2 << 0) |
@@ -3468,9 +3468,9 @@ static void gfx_v12_1_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
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
@@ -3517,9 +3517,6 @@ static void gfx_v12_1_ring_emit_fence_kiq(struct amdgpu_ring *ring, u64 addr,
 {
 	struct amdgpu_device *adev = ring->adev;
 
-	/* we only allocate 32bit for each seq wb address */
-	BUG_ON(flags & AMDGPU_FENCE_FLAG_64BIT);
-
 	/* write fence seq to the "addr" */
 	amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
 	amdgpu_ring_write(ring, (PACKET3_WRITE_DATA__DST_SEL(5) | PACKET3_WRITE_DATA__WR_CONFIRM(1)));
-- 
2.54.0

