Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE1DDD3EE74
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jan 2026 15:04:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 717AC10E06E;
	Thu, 22 Jan 2026 15:04:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2Jm4O0IN";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010060.outbound.protection.outlook.com
 [40.93.198.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36DB410E9D5
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jan 2026 15:04:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U09F8n8+rivpX8AFaRD68L7V4LZ6BB5mEK0RaS25k8zk7hGHHiahvLYV9JAs5UM2Xf/bb2vA/oSykNTmJLXWHfIIvlIu/msQ7Sxl81NAkphDSJCk8tbwa3tjk8SiS+GuvSOa5HLSIUU5lXthln2YvtjWKVPy2+uG8HFm96kJKYuJH9zeDOEQJsiZwqY8+isGcuPDfipT8XOcbejq0cGxQQYCOF8UE6/I9XoqgRn1pyk1xBKphnMfhi29+dbUPEtaxJmou1NnNqvmpXLh9PMjYVxA5IpDDRdV6b5IzM1HEYEOilqa5GEfgSmflV52QC4xcxZlVa0O8RnD8+r/k138pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X7sA4xHyvijkyyT39a0PSsVHxnTFj5XbmL4QRVqcw3w=;
 b=SMOUZ/A8pOnyCsMWNftIpM9WTqr4J7DcMKUZa0Pen/B4PUP4lMsQs/qx9v7p5xt/Hz39e2ku8XSSc4phCU5Da5vnAN0zOJgvjyyuBTjlSIy97jx5fNDGWLYAxtJMZDWqWg4gu7gIxHoEBQwuJGMAM+dXe7/ILNo9QdExVpyKi1JMwjWdAJxs+H9aCpW7OvJDE+HId+PVL+hqAoPuD8HuUV2BlPR1pXZMJ5BIX+2xGlzYohCSxLyYzr4EG11893nnvnjFBwO2ZvrI+S5mtDWSd780IKC9XTZmwR5ZIYfMm+x2tuB/eFDAfA4gnh69mGO/nlxnhL/gZZPu6Lx7ywESgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X7sA4xHyvijkyyT39a0PSsVHxnTFj5XbmL4QRVqcw3w=;
 b=2Jm4O0IN1vLrhiwjK5Q1DoGuTCk5iQGN497bgcbr4oNPfCMj6HiH7EuiQn+lXtcNq3VJPYvQG4UjqCd4FAxnRQDqAXnp1dWtP4YVtb2em9MFdB6ZBzx7iX0WOyyQinxhKWBRSn4+Q2/Z2SMh6sRhHp+anxIVjCICK8OzRtdImxE=
Received: from BN0PR04CA0029.namprd04.prod.outlook.com (2603:10b6:408:ee::34)
 by BN3PR12MB9595.namprd12.prod.outlook.com (2603:10b6:408:2cb::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Thu, 22 Jan
 2026 15:04:27 +0000
Received: from BN1PEPF00004680.namprd03.prod.outlook.com
 (2603:10b6:408:ee:cafe::17) by BN0PR04CA0029.outlook.office365.com
 (2603:10b6:408:ee::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.11 via Frontend Transport; Thu,
 22 Jan 2026 15:04:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004680.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 22 Jan 2026 15:04:25 +0000
Received: from jc-d.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 22 Jan
 2026 09:04:24 -0600
From: Jay Cornwall <jay.cornwall@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jay Cornwall <jay.cornwall@amd.com>, Lancelot Six <lancelot.six@amd.com>, 
 Vladimir Indic <vladimir.indic@amd.com>, Shweta Khatri
 <shweta.khatri@amd.com>
Subject: [PATCH] drm/amdkfd: gfx12.1 trap handler instruction fixup for VOP3PX
Date: Thu, 22 Jan 2026 09:04:05 -0600
Message-ID: <20260122150405.647464-1-jay.cornwall@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004680:EE_|BN3PR12MB9595:EE_
X-MS-Office365-Filtering-Correlation-Id: 92e76674-a6e8-4e8b-044a-08de59c7884f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GTm1tfEXQWsJn4VBVZjpH3h3o+wcSpMgJ91t9braLQMV/fBInMn5q1JN/YhG?=
 =?us-ascii?Q?cAyZOazyIOSMVo+twMazgkaUPuMFcnLkD8vJeKeecOjTYRiNzFJ6qhTvz7QP?=
 =?us-ascii?Q?PY77eNjiMgVEEDUNwyrRbdnlfePvxua9QvCs/Ko2zOKc67c0GqnOteZXqO5m?=
 =?us-ascii?Q?8pwwh5xwR47m79UFIFzKZzp3kqde3iCFgB28hA8dbvbdJ2IB3r7TSFbxbmIO?=
 =?us-ascii?Q?zVOc71LyB/HoMPx9gJIfnImeSqFkR3Y4Vp43MXh4wcYIGIke4AYLfwaceRqq?=
 =?us-ascii?Q?NNrrZ8RTFiSM81jAI6WGQ43wx421h3xvdiOFYCZ3/MHQRCLxyGlbP8G46Thu?=
 =?us-ascii?Q?JBme2t0Y8ji0dEws9fklFg2AybdQE5FeXfZpOdmZh6UZn4dZHoCsLI6APHs1?=
 =?us-ascii?Q?3jLyWJFOrma88cxcdsrFI0ED7sBUZzrLQccqkMzZKm1w6pGIxDLcdMukzu66?=
 =?us-ascii?Q?h4D1Yx7uP+ER9fMEsSQdhpS29RcmhqmiZVh0D+c3h+FaG72LCH13bD010ia/?=
 =?us-ascii?Q?tVza0LS16ANZfkv2a6UShjF9aktUbb87+GOdMaM1yod/0APqH4gPKK6nAtPM?=
 =?us-ascii?Q?P81JNC9D4IcSViRaV/ImlcMABCXoGmkI7dXpNLOc9WwdF7mGOIEUwopp0S4j?=
 =?us-ascii?Q?v/Xk6fjjg5JmMV3nCrHdq1hFp1UZLKQkh8iSf9eITizhn62/ydh7eE47o5//?=
 =?us-ascii?Q?QvD7Qs+GlXG5MqKnMmCRKvauzhaUNvZUsjKyOoyl5Fxk4qPyUmO63p/jiBYH?=
 =?us-ascii?Q?B0RS/T74hZyN84j0R9S1XBjqjQ0FA69W8tZbXaJOJFymUNv97tIWe1nvpvP1?=
 =?us-ascii?Q?8vM5TH1VUqc7xYcMAcyzF9a82x/V9WXFNbIMlX3OJq9u2tInq0UkwpIYlrmF?=
 =?us-ascii?Q?KQhSyVzo6KcLTReInsDZ0VXgA+/1CLXmnx2ZXlHlIlps4dVjhEGT2FKeISX0?=
 =?us-ascii?Q?fkYxGumhAL7pCDbTp2CESWLjy7iBubpxl5WQEdoL02rFrUutvK4nhi8LOvJS?=
 =?us-ascii?Q?84pfLqdm+KmK2QyA/i8SOtLD0FIp5QHjb0UBPu3pjE4Egnpf/sXK0g9x8UiF?=
 =?us-ascii?Q?3pq+Qm7d4DiRqxIRgPn3tr3rxi36SF0vBzhB4dIB1KN0tM7ndwBnITyC85G0?=
 =?us-ascii?Q?XIvRJ6WotIp4VdsNWJUML+yLxEuItFYIu2NQa3kaDmq2e9u28HJKSuo84JHE?=
 =?us-ascii?Q?s5ge08jq0Y5sJcJGG6n9TAnvrMxHfbmE+FU/uW8n61AP4XFo4FmgU4BcGT83?=
 =?us-ascii?Q?nAZTIslmptM5KoOvd25DigRg0MZT4y6R1xSJ5DCuqNEaeWSvvPUaKQVIXWMI?=
 =?us-ascii?Q?DthhRwGzA1RfCKgPzWeP7laANEgkq3WgnbiySNr70DbEEihdE6FB8pkgV5lf?=
 =?us-ascii?Q?o2jzgCPyojRHIYw9Hu5+muy3rHsHhMRqPLWL8E6ZmdQqP9I0oi0oVjxlJxPG?=
 =?us-ascii?Q?dpSqp+0aUQgu3oJECXIX+LGWfn76PH91NOCmSsevpTs4fPH371UWPlrDqOkY?=
 =?us-ascii?Q?cyc+qinK7LXRQ5CTXwbSLZhloYqH+EZWX0/2imnlLqpzh+d+T81QKgA6jji3?=
 =?us-ascii?Q?KlCGkF0BIKgEEHDc0jIr7xdw22uPOBGl2sAcw0wA4yjs9BE2q+OuJYyqnY6J?=
 =?us-ascii?Q?oS0kt3bYlqZtmS97Nc8RkoJ6CPfYDi59s65U2Wmanceaya5AbKnOhD8SA/dz?=
 =?us-ascii?Q?JqvE2w=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 15:04:25.2996 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92e76674-a6e8-4e8b-044a-08de59c7884f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004680.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9595
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

A trap may occur in the middle of VOP3PX instruction co-issue.
The PC would be restored incorrectly if left unmodified.

Identify this case by examining the instruction opcode and
rewind the PC 8 bytes if it occurs.

Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
Cc: Lancelot Six <lancelot.six@amd.com>
Cc: Vladimir Indic <vladimir.indic@amd.com>
Cc: Shweta Khatri <shweta.khatri@amd.com>
---
 .../gpu/drm/amd/amdkfd/cwsr_trap_handler.h    | 197 +++++++++---------
 .../amd/amdkfd/cwsr_trap_handler_gfx12.asm    |  25 ++-
 2 files changed, 121 insertions(+), 101 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
index 39bdc98b8b6d..54fa76f374c9 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
@@ -4587,14 +4587,14 @@ static const uint32_t cwsr_trap_gfx9_5_0_hex[] = {
 };
 
 static const uint32_t cwsr_trap_gfx12_1_0_hex[] = {
-	0xbfa00001, 0xbfa003ac,
+	0xbfa00001, 0xbfa003be,
 	0xb0804009, 0xb8f8f804,
 	0x9178ff78, 0x00008c00,
 	0xb8fbf811, 0x8b6eff78,
 	0x00004000, 0xbfa10008,
 	0x8b6eff7b, 0x00000080,
 	0xbfa20018, 0x8b6ea07b,
-	0xbfa200d1, 0xbf830010,
+	0xbfa200da, 0xbf830010,
 	0xb8fbf811, 0xbfa0fffb,
 	0x8b6eff7b, 0x00000bd0,
 	0xbfa20010, 0xb8eef812,
@@ -4605,7 +4605,7 @@ static const uint32_t cwsr_trap_gfx12_1_0_hex[] = {
 	0xf0000000, 0xbfa20005,
 	0x8b6fff6f, 0x00000200,
 	0xbfa20002, 0x8b6ea07b,
-	0xbfa200bb, 0x9177ff77,
+	0xbfa200c4, 0x9177ff77,
 	0x007fc000, 0xb8fa04a1,
 	0x847a967a, 0x8c777a77,
 	0xb8fa0421, 0x847a957a,
@@ -4632,43 +4632,46 @@ static const uint32_t cwsr_trap_gfx12_1_0_hex[] = {
 	0xbfa00002, 0x806c846c,
 	0x826d806d, 0x8b6dff6d,
 	0x01ffffff, 0xb8fbf811,
-	0xbf0d847b, 0xbfa20078,
+	0xbf0d847b, 0xbfa20081,
 	0xf4003eb6, 0xf8000000,
 	0xbfc70000, 0xf4003bb6,
 	0xf8000008, 0x8b76ff7a,
 	0x80000000, 0xbfa20027,
 	0x9376ff7a, 0x00060019,
 	0x81f9a376, 0xbf0b8179,
-	0xbfa20068, 0x81f9ac76,
-	0xbf0b8179, 0xbfa20062,
+	0xbfa2006e, 0x81f9ac76,
+	0xbf0b8179, 0xbfa20068,
 	0x81f9b776, 0xbf0b8179,
-	0xbfa2005f, 0x8b76ff7a,
+	0xbfa20065, 0x8b76ff7a,
 	0x000001ff, 0xbf06ff76,
-	0x000000fe, 0xbfa2005d,
+	0x000000fe, 0xbfa20063,
 	0xbf06ff76, 0x000000ff,
-	0xbfa20057, 0xbf06ff76,
-	0x000000fa, 0xbfa20054,
+	0xbfa2005d, 0xbf06ff76,
+	0x000000fa, 0xbfa2005a,
 	0x81f9ff76, 0x000000e9,
-	0xbf0b8179, 0xbfa20050,
+	0xbf0b8179, 0xbfa20056,
 	0x8b76ff7b, 0xffff0000,
 	0xbf06ff76, 0xbf860000,
-	0xbfa10051, 0x9376ff7b,
+	0xbfa1005a, 0x9376ff7b,
 	0x0002000e, 0x8b79ff7b,
 	0x00003f00, 0x85798679,
 	0x8c767976, 0xb9763b01,
-	0xbfa00049, 0x8b76ff7a,
+	0xbfa00052, 0x8b76ff7a,
 	0xfc000000, 0xbf06ff76,
-	0xd4000000, 0xbfa20013,
+	0xd4000000, 0xbfa20019,
 	0xbf06ff76, 0xc8000000,
-	0xbfa20027, 0x8b76ff7a,
+	0xbfa2002d, 0x8b76ff7a,
 	0xff000000, 0xbf06ff76,
-	0xcf000000, 0xbfa20039,
+	0xcf000000, 0xbfa2003f,
 	0x8b79ff7a, 0xffff0000,
+	0xbf06ff79, 0xcc330000,
+	0xbfa2003d, 0xbf06ff79,
+	0xcc880000, 0xbfa2003a,
 	0xbf06ff79, 0xcc350000,
-	0xbfa20037, 0xbf06ff79,
-	0xcc3a0000, 0xbfa20034,
+	0xbfa2003a, 0xbf06ff79,
+	0xcc3a0000, 0xbfa20037,
 	0xbf06ff76, 0xcc000000,
-	0xbfa10031, 0x8b76ff7b,
+	0xbfa10034, 0x8b76ff7b,
 	0x000001ff, 0xbf06ff76,
 	0x000000ff, 0xbfa20029,
 	0xbf06ff76, 0x000000fa,
@@ -4691,86 +4694,92 @@ static const uint32_t cwsr_trap_gfx12_1_0_hex[] = {
 	0x000001ff, 0xbf06ff76,
 	0x000000ff, 0xbfa20003,
 	0xbfc70000, 0xbefb006e,
-	0xbfa0ffad, 0xbfc70000,
-	0xbefb006f, 0xbfa0ffaa,
-	0xbfc70000, 0x857a9677,
-	0xb97a04a1, 0x857a9577,
-	0xb97a0421, 0x857a8e77,
-	0xb97a3021, 0x8bfe7e7e,
-	0x8bea6a6a, 0x85788978,
-	0xb9783244, 0xbe804a6c,
-	0xb8faf802, 0xbf0d987a,
-	0xbfa10001, 0xbfb00000,
-	0x8b6dff6d, 0x01ffffff,
-	0xbefa0080, 0xb97a0151,
-	0x9177ff77, 0x007fc000,
-	0xb8fa04a1, 0x847a967a,
-	0x8c777a77, 0xb8fa0421,
-	0x847a957a, 0x8c777a77,
-	0xb8fa3021, 0x847a8e7a,
-	0x8c777a77, 0xb980f821,
-	0x00000000, 0xbf0d847b,
-	0xbfa20078, 0xf4003eb6,
-	0xf8000000, 0xbfc70000,
-	0xf4003bb6, 0xf8000008,
-	0x8b76ff7a, 0x80000000,
-	0xbfa20027, 0x9376ff7a,
-	0x00060019, 0x81f9a376,
+	0xbfa0ffa7, 0xbfc70000,
+	0xbefb006f, 0xbfa0ffa4,
+	0x80ec886c, 0x82ed806d,
+	0xbfa0fff7, 0xbfc70000,
+	0x857a9677, 0xb97a04a1,
+	0x857a9577, 0xb97a0421,
+	0x857a8e77, 0xb97a3021,
+	0x8bfe7e7e, 0x8bea6a6a,
+	0x85788978, 0xb9783244,
+	0xbe804a6c, 0xb8faf802,
+	0xbf0d987a, 0xbfa10001,
+	0xbfb00000, 0x8b6dff6d,
+	0x01ffffff, 0xbefa0080,
+	0xb97a0151, 0x9177ff77,
+	0x007fc000, 0xb8fa04a1,
+	0x847a967a, 0x8c777a77,
+	0xb8fa0421, 0x847a957a,
+	0x8c777a77, 0xb8fa3021,
+	0x847a8e7a, 0x8c777a77,
+	0xb980f821, 0x00000000,
+	0xbf0d847b, 0xbfa20081,
+	0xf4003eb6, 0xf8000000,
+	0xbfc70000, 0xf4003bb6,
+	0xf8000008, 0x8b76ff7a,
+	0x80000000, 0xbfa20027,
+	0x9376ff7a, 0x00060019,
+	0x81f9a376, 0xbf0b8179,
+	0xbfa2006e, 0x81f9ac76,
 	0xbf0b8179, 0xbfa20068,
-	0x81f9ac76, 0xbf0b8179,
-	0xbfa20062, 0x81f9b776,
-	0xbf0b8179, 0xbfa2005f,
-	0x8b76ff7a, 0x000001ff,
-	0xbf06ff76, 0x000000fe,
+	0x81f9b776, 0xbf0b8179,
+	0xbfa20065, 0x8b76ff7a,
+	0x000001ff, 0xbf06ff76,
+	0x000000fe, 0xbfa20063,
+	0xbf06ff76, 0x000000ff,
 	0xbfa2005d, 0xbf06ff76,
-	0x000000ff, 0xbfa20057,
+	0x000000fa, 0xbfa2005a,
+	0x81f9ff76, 0x000000e9,
+	0xbf0b8179, 0xbfa20056,
+	0x8b76ff7b, 0xffff0000,
+	0xbf06ff76, 0xbf860000,
+	0xbfa1005a, 0x9376ff7b,
+	0x0002000e, 0x8b79ff7b,
+	0x00003f00, 0x85798679,
+	0x8c767976, 0xb9763b01,
+	0xbfa00052, 0x8b76ff7a,
+	0xfc000000, 0xbf06ff76,
+	0xd4000000, 0xbfa20019,
+	0xbf06ff76, 0xc8000000,
+	0xbfa2002d, 0x8b76ff7a,
+	0xff000000, 0xbf06ff76,
+	0xcf000000, 0xbfa2003f,
+	0x8b79ff7a, 0xffff0000,
+	0xbf06ff79, 0xcc330000,
+	0xbfa2003d, 0xbf06ff79,
+	0xcc880000, 0xbfa2003a,
+	0xbf06ff79, 0xcc350000,
+	0xbfa2003a, 0xbf06ff79,
+	0xcc3a0000, 0xbfa20037,
+	0xbf06ff76, 0xcc000000,
+	0xbfa10034, 0x8b76ff7b,
+	0x000001ff, 0xbf06ff76,
+	0x000000ff, 0xbfa20029,
 	0xbf06ff76, 0x000000fa,
-	0xbfa20054, 0x81f9ff76,
-	0x000000e9, 0xbf0b8179,
-	0xbfa20050, 0x8b76ff7b,
-	0xffff0000, 0xbf06ff76,
-	0xbf860000, 0xbfa10051,
-	0x9376ff7b, 0x0002000e,
-	0x8b79ff7b, 0x00003f00,
-	0x85798679, 0x8c767976,
-	0xb9763b01, 0xbfa00049,
-	0x8b76ff7a, 0xfc000000,
-	0xbf06ff76, 0xd4000000,
-	0xbfa20013, 0xbf06ff76,
-	0xc8000000, 0xbfa20027,
-	0x8b76ff7a, 0xff000000,
-	0xbf06ff76, 0xcf000000,
-	0xbfa20039, 0x8b79ff7a,
-	0xffff0000, 0xbf06ff79,
-	0xcc350000, 0xbfa20037,
-	0xbf06ff79, 0xcc3a0000,
-	0xbfa20034, 0xbf06ff76,
-	0xcc000000, 0xbfa10031,
-	0x8b76ff7b, 0x000001ff,
-	0xbf06ff76, 0x000000ff,
-	0xbfa20029, 0xbf06ff76,
-	0x000000fa, 0xbfa20026,
-	0x81f6ff76, 0x000000e9,
-	0xbf0b8176, 0xbfa20022,
-	0x8b76ff7b, 0x0003fe00,
-	0xbf06ff76, 0x0001fe00,
-	0xbfa2001d, 0x8b76ff7b,
-	0x07fc0000, 0xbf06ff76,
-	0x03fc0000, 0xbfa20018,
-	0xbfa00014, 0x9376ff7a,
-	0x00040016, 0x81f68176,
-	0xbf0b8176, 0xbfa20012,
-	0x9376ff7a, 0x00050011,
+	0xbfa20026, 0x81f6ff76,
+	0x000000e9, 0xbf0b8176,
+	0xbfa20022, 0x8b76ff7b,
+	0x0003fe00, 0xbf06ff76,
+	0x0001fe00, 0xbfa2001d,
+	0x8b76ff7b, 0x07fc0000,
+	0xbf06ff76, 0x03fc0000,
+	0xbfa20018, 0xbfa00014,
+	0x9376ff7a, 0x00040016,
 	0x81f68176, 0xbf0b8176,
-	0xbfa2000d, 0x8b76ff7a,
-	0x000001ff, 0xbf06ff76,
-	0x000000ff, 0xbfa20008,
-	0x8b76ff7b, 0x000001ff,
+	0xbfa20012, 0x9376ff7a,
+	0x00050011, 0x81f68176,
+	0xbf0b8176, 0xbfa2000d,
+	0x8b76ff7a, 0x000001ff,
 	0xbf06ff76, 0x000000ff,
-	0xbfa20003, 0xbfc70000,
-	0xbefb006e, 0xbfa0ffad,
-	0xbfc70000, 0xbefb006f,
-	0xbfa0ffaa, 0xbfc70000,
+	0xbfa20008, 0x8b76ff7b,
+	0x000001ff, 0xbf06ff76,
+	0x000000ff, 0xbfa20003,
+	0xbfc70000, 0xbefb006e,
+	0xbfa0ffa7, 0xbfc70000,
+	0xbefb006f, 0xbfa0ffa4,
+	0x80ec886c, 0x82ed806d,
+	0xbfa0fff7, 0xbfc70000,
 	0xbeee007e, 0xbeef007f,
 	0xbefe0180, 0xbefe4d84,
 	0xbf8a0000, 0x8b7aff7f,
diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
index c33e7660d8f4..d38ff404277b 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
@@ -37,6 +37,7 @@
 #define HAVE_CLUSTER_BARRIER (ASIC_FAMILY == CHIP_GC_12_0_3)
 #define CLUSTER_BARRIER_SERIALIZE_WORKAROUND (ASIC_FAMILY == CHIP_GC_12_0_3)
 #define RELAXED_SCHEDULING_IN_TRAP (ASIC_FAMILY == CHIP_GFX12)
+#define HAVE_INSTRUCTION_FIXUP (ASIC_FAMILY == CHIP_GC_12_0_3)
 
 #define SINGLE_STEP_MISSED_WORKAROUND 1	//workaround for lost TRAP_AFTER_INST exception when SAVECTX raised
 #define HAVE_VALU_SGPR_HAZARD (ASIC_FAMILY == CHIP_GFX12)
@@ -372,9 +373,9 @@ L_TRAP_CASE:
 L_EXIT_TRAP:
 	s_and_b32	ttmp1, ttmp1, ADDRESS_HI32_MASK
 
-#if HAVE_BANKED_VGPRS
+#if HAVE_INSTRUCTION_FIXUP
 	s_getreg_b32	s_save_excp_flag_priv, hwreg(HW_REG_WAVE_EXCP_FLAG_PRIV)
-	fixup_vgpr_bank_selection()
+	fixup_instruction()
 #endif
 
 #if HAVE_XNACK
@@ -415,8 +416,8 @@ L_HAVE_VGPRS:
 	save_and_clear_xnack_state_priv(s_save_tmp)
 #endif
 
-#if HAVE_BANKED_VGPRS
-	fixup_vgpr_bank_selection()
+#if HAVE_INSTRUCTION_FIXUP
+	fixup_instruction()
 #endif
 
 	/* inform SPI the readiness and wait for SPI's go signal */
@@ -1397,8 +1398,8 @@ L_BARRIER_RESTORE_LOOP:
 L_BARRIER_RESTORE_DONE:
 end
 
-#if HAVE_BANKED_VGPRS
-function fixup_vgpr_bank_selection
+#if HAVE_INSTRUCTION_FIXUP
+function fixup_instruction
 	// PC read may fault if memory violation has been asserted.
 	// In this case no further progress is expected so fixup is not needed.
 	s_bitcmp1_b32	s_save_excp_flag_priv, SQ_WAVE_EXCP_FLAG_PRIV_MEM_VIOL_SHIFT
@@ -1477,8 +1478,13 @@ L_FIXUP_NOT_VOP12C:
 	s_cmp_eq_u32	ttmp10, 0xcf000000					// If 31:24 = 0xcf, this is VOPD3
 	s_cbranch_scc1	L_FIXUP_THREE_DWORD					// If VOPD3, 3 DWORD inst
 	// Not VOP1, VOP2, VOPC, VOP3, VOP3SD, VOPD, or VOPD3.
-	// Might be in VOP3P, but we must ensure we are not VOP3PX2
+	// Check if we are in the middle of VOP3PX.
 	s_and_b32	ttmp13, ttmp14, 0xffff0000				// Bits 31:16
+	s_cmp_eq_u32	ttmp13, 0xcc330000					// If 31:16 = 0xcc33, this is 8 bytes past VOP3PX
+	s_cbranch_scc1	L_FIXUP_VOP3PX_MIDDLE
+	s_cmp_eq_u32	ttmp13, 0xcc880000					// If 31:16 = 0xcc88, this is 8 bytes past VOP3PX
+	s_cbranch_scc1	L_FIXUP_VOP3PX_MIDDLE
+	// Might be in VOP3P, but we must ensure we are not VOP3PX2
 	s_cmp_eq_u32	ttmp13, 0xcc350000					// If 31:16 = 0xcc35, this is VOP3PX2
 	s_cbranch_scc1	L_FIXUP_DONE						// If VOP3PX2, no fixup needed
 	s_cmp_eq_u32	ttmp13, 0xcc3a0000					// If 31:16 = 0xcc3a, this is VOP3PX2
@@ -1539,6 +1545,11 @@ L_FIXUP_THREE_DWORD:
 	s_mov_b32	ttmp15, ttmp3						// Move possible S_SET_VGPR_MSB into ttmp15
 	s_branch	L_FIXUP_ONE_DWORD					// Go to common logic that checks if it is S_SET_VGPR_MSB
 
+L_FIXUP_VOP3PX_MIDDLE:
+	s_sub_co_u32	ttmp0, ttmp0, 8						// Rewind PC 8 bytes to beginning of instruction
+	s_sub_co_ci_u32	ttmp1, ttmp1, 0
+	s_branch	L_FIXUP_TWO_DWORD					// 2 DWORD inst (2nd half of a 4 DWORD inst)
+
 L_FIXUP_DONE:
 	s_wait_kmcnt	0							// Ensure load of ttmp2 and ttmp3 is done
 end
-- 
2.34.1

