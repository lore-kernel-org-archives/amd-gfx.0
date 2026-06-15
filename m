Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49EF7CD98DA
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2026 23:57:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC40910E76E;
	Mon, 15 Jun 2026 23:57:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ea5+voOK";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012035.outbound.protection.outlook.com [52.101.53.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62CE210E6DA
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 23:57:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vd58X/79qAHEy1FR3WDF52cFXk/QUTpalHD6AYDAp030fbYxhh4abZsm2cl5fVX0vLeCMMFZa9AUTmufh79CzQ7lSGG3ikCcy/KBfJGGbhmPrr0CXDE1Ly4ctMdshYxQQ7+okw3vZXQqJ1HSV3phaZt1JmBV8Sa59TzAPS/Zq9nnsX6DEJbSwxqgqRxXrItpMAUlY4bLSzRUgku4/uAwnBkh5XfIlk3trDah51uaXx5KdvEwJx5/9XTGKyYpCsV+ORq71P9OLHSjQfDWjd/FaXXZ+aDlrAHAgHM8Pe0FW1ELXvwBdVvxAYuGg09jhSYTO/RxGlgJ0q5MBlpkB4lPIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jToYtDcNLaaEvyXUMMPLUCd+2+8yoi5H89SOABuwyDI=;
 b=UtFz0/fPdlcodVQI1tdT7sOfPbBWvOr1oDATQQCAv4lP3y2KtVctQwiCkIfNEtzdokjZJKf5O49op+8Bj6ymgrWJpGeqyDz8spFqH9ytYyGwTuDSr2Bh3Dpvg83xsJWzor3pqFg2yx3782aRAuk7S9fLg2H/oCSQNRo3nOsRehFLNVzvjbJzXw3T9etCDpei+0Gkufj87igVw8ZK8yx4TWIYGACahNvhhLsP/9Pln/rK/Y6STusIXdZJ/8l99FHLAfctcNwXd7PttTbXZF5pD1enAdfEppPdQ+2hjhZISTW7Fxnvem8mZAVAJmTaSTXLd+3Mu6ySLzOhjThOl/O45A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jToYtDcNLaaEvyXUMMPLUCd+2+8yoi5H89SOABuwyDI=;
 b=ea5+voOKwlASGgdAA8WWGtP1oBzLiGfmh9oAN+XBYQaN9g5sReg4Gr6dgb+52ewi8x1uH2yKFB5XAi6DWmTopAXrZQoWeuwAWaaRuZRw2WOmD1h1ZiQtfp9/P9xucvaWDmk+p/rJffri1nsYZeRRZ5BwZnaWKIT67baZ6Cg9wFc=
Received: from CH0PR03CA0064.namprd03.prod.outlook.com (2603:10b6:610:cc::9)
 by DS5PPF4ACC15C0E.namprd12.prod.outlook.com (2603:10b6:f:fc00::64c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.16; Mon, 15 Jun
 2026 23:56:59 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::23) by CH0PR03CA0064.outlook.office365.com
 (2603:10b6:610:cc::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Mon,
 15 Jun 2026 23:56:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 15 Jun 2026 23:56:58 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 18:56:58 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 18:56:58 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 15 Jun 2026 18:56:58 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 12/43] drm/amdgpu/sdma7.0: replace BUG_ON() with WARN_ON()
Date: Mon, 15 Jun 2026 19:56:14 -0400
Message-ID: <20260615235645.737189-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615235645.737189-1-alexander.deucher@amd.com>
References: <20260615235645.737189-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|DS5PPF4ACC15C0E:EE_
X-MS-Office365-Filtering-Correlation-Id: 0df1928e-c606-4aae-507f-08decb39c9a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|82310400026|36860700016|18002099003|22082099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: taiMolgoKhh/L2usY07gi4qgeMcXGAQAGF2MjZGw6IGeELI6MRSxwwGoHHY9BrBg3F1Ghfzr/DcO3+eUvDjsSicK7UqEsdZAEaIO7QcWk2Op77+VEnG4CRaDBZs7nzjWMgOteKz71AoRXgUYiC1ZbhwIQJFjqTz7mWCRB/zfSpwIkwlzGkBuoRlIYFA8iTNrVSIpdk0uQMF+eDQGIbnAunNMWyX/Qd7AcKOQX2WMeCzudMM6pm5hkppMzNvLaqqM6W/6wkw2KBNDz4j9zoUuXvOyE9RX704IDyOY0t+gJn2fMmsjEFi/KRfn15IrDLwlKlzZ7zz8cHUkEhP/cOaRXuFp5MdfQxFum+CeOJ1C4oaf8jd7O8HObsLsd5o58fedAeKapvFDkiH3JUhwclgSDPlvRIaCBxUYPPKa0PW9jy70vl/59jK/DbVfmZ+4TYcA3jaueiM4+9RsWBFbVmPNiqhr4bK+dpIc8FQhkPRG7w0zBMP6xES7XAE+YP/TMMYhT7p7qM61pZGFbHJ8zwoE6O6dWdSGmTuJMInxMbko10zru+u7AG2AOH3KJwgksZn21E8LckoxkNsjCtAZEx9s+EJCpRCMwLH5Wb4p5LD4USVlnz0m7tumaX8AnQovO/ipz8qfwbfzGrKDgU+0z8JZW+UQrNfGSeTzsLKzM/dpKkZtdMHr85afL2XQejAEEDc98GUvm4Wl+fItQY7TAubpegfHebWOZbGuHLrmsaD+Ees=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(36860700016)(18002099003)(22082099003)(6133799003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wjbJHzAOPwQOHWocCpq/dDZl87qx0DnnPrr+ST4zsDu+VvY+a4sxZ1H9asxFttiMne9RTQYwnZyhXpsGcpTpF++C73C6on5nUkHpdo0oRemChfeij31q22BUFlYn7qlOCGkeAR6LMIU0IPN50gsgcXox+03zr6eF3GQ670aensSZQGFbln17Jp7rfXYCt4Ai0/cyNmBEQB0o/xxTzphM81tGjsMXwEHYmimD5b13kq9TQV2cLwEsWno5KrwPyEqzKzmmDPunse6wO6R2ZEL5ErimqB1t9BxaCRkR1yfHwxbyFZZM08kXamKf98n0HlCwC0JNCLcwoTjKY+Z7jEXXLeinGIQj8QpuynlmXmRzIjg78aI7N7wG6544+tA3PzMLFGrODJoxXLag7fNQ0sOINmqi2uKlVgnli4E1mgvLwNAs9cnykOkCjc4kPZBC8gvo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 23:56:58.9415 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0df1928e-c606-4aae-507f-08decb39c9a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF4ACC15C0E
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
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index f154b68dda701..49c57a38151bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -363,7 +363,7 @@ static void sdma_v7_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 se
 	amdgpu_ring_write(ring, SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP_FENCE) |
 			  SDMA_PKT_FENCE_HEADER_MTYPE(0x3)); /* Ucached(UC) */
 	/* zero in first two bits */
-	BUG_ON(addr & 0x3);
+	WARN_ON(addr & 0x3);
 	amdgpu_ring_write(ring, lower_32_bits(addr));
 	amdgpu_ring_write(ring, upper_32_bits(addr));
 	amdgpu_ring_write(ring, lower_32_bits(seq));
@@ -374,7 +374,7 @@ static void sdma_v7_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 se
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

