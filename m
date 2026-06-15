Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E79DCD98DE
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2026 23:57:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EFE410E68E;
	Mon, 15 Jun 2026 23:57:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3OM1zY2G";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012049.outbound.protection.outlook.com
 [40.93.195.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83EDC10E68E
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 23:57:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tD2t2+21R+jOihZd6+Ekxrkt3y6QwlPgqzOb+K/VdKvoQ7bv18nEfqrnFlj0CZEq797cu41X01SFiP3HeHD3LuQBOuYIFruxN+0yj4aPhMdmA/sRrKAf/ftMXkgxo7R4oyyR5O7CTv/B3usBP3SqYNKRQvyn/pyxm1qzjJnSHvYuMofy4SvToRiU4SlVSG8gU50Xe/NoAhQNgnijpBsEaIwDPLoIum9VDRMy3Y7ioM50vpFkGxgY6C+hFN3JTT3MW5SR/RCtXADSACr0/BmC9w/hla953d4HqeikUYoF5xe7PMTLqhsCRAk282820asUYcIOyNff6acgtQ/Ueig61g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=diiK2gDVN9eJFRwRqX6dH2pSpC/h9WeFYN39v4G2lhs=;
 b=dDggKmXYlb4Dt9VvoZ8RH1Rp8m+08Q1RsgBjpNK3A5wHVvkeirZ9LmHohsWvqFM6ZvoYdwDc+QRwmbQfRvvTdfahlwXL0sFRcIy76hM6nc/+NhUy9fqG3uGyIjiHpye3yFjQAD0uN4spSaoenhn3iOrK61A+v4r3+/fi/ID97uO82X+BtupieMGQFuJdUMctZ0ojhj/nUoTzOEyDi31P0IfCYAD+zhkv9n2HRfK6PuUTdQz4DsBYfcP4uHL++z1XnKGdR/23knQriZ7s429h1ntlZgSfVDxWGXDb6yd2xChgCFFFf/Ys6mBFY75FmY70910l1YGYgUaqflFF9+9kWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=diiK2gDVN9eJFRwRqX6dH2pSpC/h9WeFYN39v4G2lhs=;
 b=3OM1zY2G56BaGV/kZp0c6nsmrz29J7mQVne1mtQZoFOyhqjGLr6AUjRT6ykWqtuMJ0iBTjd6/xHizz0nG898oXWyZvKFj3sb3uMn2++lpNEBe6k3Yr6tiEZIX15gK8ml9Ev9xyRlUh3EInHmVRci40tjxTwVDGBZc3jbDoeiTD0=
Received: from SN6PR2101CA0002.namprd21.prod.outlook.com
 (2603:10b6:805:106::12) by CH3PR12MB8969.namprd12.prod.outlook.com
 (2603:10b6:610:17c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 23:57:00 +0000
Received: from SA2PEPF00003AE4.namprd02.prod.outlook.com
 (2603:10b6:805:106:cafe::50) by SN6PR2101CA0002.outlook.office365.com
 (2603:10b6:805:106::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.2 via Frontend Transport; Mon, 15
 Jun 2026 23:56:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE4.mail.protection.outlook.com (10.167.248.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 15 Jun 2026 23:56:59 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 18:56:58 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 16:56:57 -0700
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 15 Jun 2026 18:56:57 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 11/43] drm/amdgpu/sdma6.0: replace BUG_ON() with WARN_ON()
Date: Mon, 15 Jun 2026 19:56:13 -0400
Message-ID: <20260615235645.737189-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615235645.737189-1-alexander.deucher@amd.com>
References: <20260615235645.737189-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE4:EE_|CH3PR12MB8969:EE_
X-MS-Office365-Filtering-Correlation-Id: 2433f78a-a1ff-455b-5f6c-08decb39ca39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|18002099003|22082099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: YDQegevnKnL5GjDKSUi6T+b3zS0EKKlqt1osnFaOgmKgOoeOkmqluvKIlow0X8EJdw4kphQoeQJHNtiJvey2DiWQopaxoZnEa/jtHE3UJsYVF8IkWtO7avSkv4R1D85yz6m3tReoSMVJhAN36StxpJZqEOKt4JAb/6ensRjp2egc3dK0IdyiO23SUMyCiWaaVQw3XcHw/u3IaY3jCQMzz2x3FRMn5iDzkVxZ7XwHwxoM13wGMxY8M0n1z/FssumCLl0rREvNmqm1GldDZhAOmb76yt/lhV+a8KXF82o9SgVTkPjJ8/3FMkwi1ikM/zmTyHHYbTZr4RrRn5lYdiyEnJvTLM3ZC92vbuvwdsNc+BpJ3Haf9sufv/283QNdvdAFBjWkV8bb/e5edecRhd1ZqcTsj0/DCWxgahiTYdPwjL9PO1FY9qzTBKiP9g9OFJbmx34J12nxKTHXrvxyX9xHIMnQdbRzRMSxKy7JKgnJTpetn5mzw7lJOWkE49E4LsDgWLBSULiVb9WSCe63vioy+X3itQsM0Shumnr07VvVizcFulYA/gB50l4bKr2vvB52WsQrBZR9SHbo77enTAtTmgeDM10uXez97nxRJPeJYNqKRRE3vrVpZFI69IXyjXGRrgkkknkAK7GsYk+jXB5wFkYqY7fD7oAYqNJAIIohLkP5GDCfjy/DmtVi+icGLlV0Nw0VIoBUqDE/zjtZPjZ57nCTn12HfCzyqSPSKDLePEQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(18002099003)(22082099003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MRslJH4WEjzgWh8NM8avHHAgH2Cm95nzQ9DOwzY0o/tS6V8Ux7lKwIIjBK6Ujwpwx2Ps2RuQJT393j0H3nEjQA/uzsKrnP44K1aUviZNCcTV7q1dw7jdZQeAamqAGrOvZyx26mqn2P+eTTf7VCOqYFiOJnakWjwxBcmDORD12EX3T7ECeVu/RenKsyEQdY6o7GyWdL5UxvRVA455PDfhljMC/5Ue0pqIuQ7CuctpogM6iHK+gtKKjTMdE6ni8+0wZWHqsi66ZH5/AUbAWWWw6ILhZTnZOE76LPSoDoxWgikyDKCkFpV5/QKmxeKz6r7F0FAaYH2nq/wYs9BkBWVpEqUGaHe1PlqSRauZbgOB15CG1PCgX1yewMReIzUwNbLaMjeUWnOv5JmaZyzaMVWx1hBbWN1pRzCK5a+lACH0rdXM5v1b/0ZTXvzyocbUpQqq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 23:56:59.8861 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2433f78a-a1ff-455b-5f6c-08decb39ca39
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8969
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
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index d894b7599c183..d7537888e60cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -361,7 +361,7 @@ static void sdma_v6_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 se
 	amdgpu_ring_write(ring, SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP_FENCE) |
 			  SDMA_PKT_FENCE_HEADER_MTYPE(0x3)); /* Ucached(UC) */
 	/* zero in first two bits */
-	BUG_ON(addr & 0x3);
+	WARN_ON(addr & 0x3);
 	amdgpu_ring_write(ring, lower_32_bits(addr));
 	amdgpu_ring_write(ring, upper_32_bits(addr));
 	amdgpu_ring_write(ring, lower_32_bits(seq));
@@ -372,7 +372,7 @@ static void sdma_v6_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 se
 		amdgpu_ring_write(ring, SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP_FENCE) |
 				  SDMA_PKT_FENCE_HEADER_MTYPE(0x3));
 		/* zero in first two bits */
-		BUG_ON(addr & 0x3);
+		WARN_ON(addr & 0x3);
 		amdgpu_ring_write(ring, lower_32_bits(addr));
 		amdgpu_ring_write(ring, upper_32_bits(addr));
 		amdgpu_ring_write(ring, upper_32_bits(seq));
-- 
2.54.0

