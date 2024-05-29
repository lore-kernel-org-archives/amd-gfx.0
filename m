Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6793C25B75
	for <amd-gfx@archiver.kernel.org>; Wed, 29 May 2024 19:36:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DB8410E41D;
	Wed, 29 May 2024 19:36:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h+XAkbkb";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E0A210E41D
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 May 2024 19:36:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K2VXTpnwk4H1WotGfhrg3B6yEWMqP18bZZRpEG2YP7D2/JCm/vzuUdUWDz6p1F4Ad4Hy8jmzioaDgZrcx/I4+vBBX6CQBE6ulTPYAw7/MPQHsLo/+xnTGtGtBvA18vnrHZyEkqrz+GSO2BkC3XT0FsfEWod/IE0pwQtHllcbnRgX2TivlowNCCGPMukMXBErTZcPqdSuoUM5BstMI1Aeaf4fix1kK6QFbfVNWurnO8uZo3gxSdZThakehI9vPJJ2wJqg7jTEsgU5kaFvS6VXYIuFebZZA2SQg8II7mXy/GAbQE0MfEs4e6oaJu5fyI6/Zg5lU9hPqI2WSr9LI8HksQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WmKUGftxJcaN2SXQs1AmMALUH2ru1AH69yJnrvs7W48=;
 b=btdL7K/axPITDKUznfzWzBQcC25goBpCYStN69aji4Mac/v0AhcohxfF1FdlOVbJffovUa67xQ/N52QqEY9pJ0vZYq1Y8RJrOFFQfXCMm4IyEH6X+ZESTzkkb4Knk9fQwpHTOZMXFoh0qG7anScjw0CTrqocXUDtH71jgYoYWEQw+Z1dCb36j5fTgkFfXOz8gacsaawysxiYXjSjWpGB+lQKgY8+396Ij2Fq4wwyBDaTWwj3v/WKnZPBE8Ftk5ikasIPqXKaYqb8C8zbTLCyjdcH6wNVSlTsi+rVHAV7QdpSpbnyR4fonIBznVsVm1f89MYsC1gMZRIsx5moEmzGiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WmKUGftxJcaN2SXQs1AmMALUH2ru1AH69yJnrvs7W48=;
 b=h+XAkbkb39wvMCMSY9/cb4k/mS483aCOxmYUinRsfwKzlWRLAtxtGP1qwILhVxIbSLmFHTgL6ZoSKTasPaxqSKximBkgca4tVUoy1i/XnammrLT6VPYW1Idm8+4EOnZFXl/IGs4IFHe/Hq2zz0l27f4f5eTlBFhYESMYkAnbCI8=
Received: from CYXPR03CA0071.namprd03.prod.outlook.com (2603:10b6:930:d1::12)
 by CH2PR12MB4279.namprd12.prod.outlook.com (2603:10b6:610:af::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 29 May
 2024 19:36:01 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:930:d1:cafe::e1) by CYXPR03CA0071.outlook.office365.com
 (2603:10b6:930:d1::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30 via Frontend
 Transport; Wed, 29 May 2024 19:36:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Wed, 29 May 2024 19:36:01 +0000
Received: from jc-d.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 29 May
 2024 14:36:00 -0500
From: Jay Cornwall <jay.cornwall@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jay Cornwall <jay.cornwall@amd.com>, Lancelot Six <lancelot.six@amd.com>
Subject: [PATCH v2] drm/amdkfd: Handle deallocated VPGRs in gfx11+ trap handler
Date: Wed, 29 May 2024 14:35:46 -0500
Message-ID: <20240529193546.817200-1-jay.cornwall@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|CH2PR12MB4279:EE_
X-MS-Office365-Filtering-Correlation-Id: e5d0aa66-c151-4c68-b7fe-08dc80169240
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|36860700004|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wwX2hPRz9autkD7f4N+s27omMVhucGWyyHKJPRYB8VOBBtudnn4Q0cpT5SNL?=
 =?us-ascii?Q?YIgYr7yLuekbtwLEf3215ih9hhZy+koYcHUPZl1UBQbkaHiOjr8xC3571aJX?=
 =?us-ascii?Q?ofjCNm0zC5RKCoHB5K1BqNKcwbf4ryJTNsqTlb57W9XfDDsT7g0t213NJO5u?=
 =?us-ascii?Q?5wl0K6wFzVl6U+qi3F8aAzv9G7dcpyqfBH8TU7CktkSPJM759G1AsNXI6AzQ?=
 =?us-ascii?Q?Y+OgUGikiE+gr9j9cGwo8e4IDzTnwRbeabSeoP8EuProHUlgJ4QFYCdMcIrI?=
 =?us-ascii?Q?TTrgNL/lhQGANpB7Y6xE6zzHK6EuojiKmNUfN0+KRM2E7Kxydg82XLgJs4sF?=
 =?us-ascii?Q?WPLhkIcdsRgQ0Xq1NpF96J2ybHoIihRSwyeRieEHmQ7L9NiSUF3pxL2ZhxHw?=
 =?us-ascii?Q?UaQtbcMo0UFtMX2XO6feWl0aKXfpzHhvlIE+XHKl4nKkG8A8FY9xoBCocora?=
 =?us-ascii?Q?rFaQ8K1D7q6y5fRzidWy/vMGDfO9Y5nOs8/kTt2VrMdYF2Gk1s7vz0qUGI9C?=
 =?us-ascii?Q?PGWMSqth9CbG1pS4QHhYewUvY0QW4vZsIgfhjromhO5ToMISdle1esTTa8Hc?=
 =?us-ascii?Q?FM6gGqT5NyQzIuYypXXepwOYfaYmemO+JzP7dV3TfcYDOwHzxgxVxwuhD2Dr?=
 =?us-ascii?Q?rb2QqRoch738bGMdPYZCPQL3He3PQmURmypYmXdMasj+GJUC3u7dyAqAVm2J?=
 =?us-ascii?Q?r4AO3jb206zgetEMKMXi2wkE95UuBtjdgu+Gd1zrw0OmilbSOkwjyX3jFirf?=
 =?us-ascii?Q?aGGdTETrz2YwPkZDDIpkcfqEXPpImgxI6svZPuTXBKpWWS5bhe6agjbKsRJm?=
 =?us-ascii?Q?VFwocZIjV9XD7v2YTku1PUeb1ufSqkZ3Z7tzLBsiqNCShDBZaZvkYU3IWRAS?=
 =?us-ascii?Q?VmWIxxfYXq6d3Ck+1IoQ+r0DrmhdjGOpsEhH4wJIQMIzWzpzBvtQk/Xx9b9n?=
 =?us-ascii?Q?dgmM4r0b+d85JaT3aig2DExpV9qfTDvPA3FoOiQ/6VOal3TYJouwlor8Kz41?=
 =?us-ascii?Q?JIBI8wkjgXQhuZ0KmF7XWk0bAu/sMnfvVTMPIm1g02Jvy45dKhiETphAcKyF?=
 =?us-ascii?Q?VC8b3k5mezeOtDW8+OVGraPlsVJuPpiLSwKUznGkONLHtj8ZMAcMWxKRyxax?=
 =?us-ascii?Q?iqgVJYJABVhF2EDilAyop7G5IfqUrETfw/Cc9L8/8oP04x/UiQ/zHmBBNtay?=
 =?us-ascii?Q?u+iFPOlqsRx+6BiWx/yVTfYqnl51PY+HbLoI9DI7n/7hirT/j68ZCmLbLrXu?=
 =?us-ascii?Q?f4pGqHfHCkk4aVSi2yiCzS+6/d4zxx4HqMYScCJ1Fv1PV6W4aHIm2ljeISxC?=
 =?us-ascii?Q?RCGoIJRqNQUl7V8t6pIBsmQmyN3LfhCULRn6ywKCMGaSVbJHpnWufhRpO8TC?=
 =?us-ascii?Q?Zl7ieB97YPFun5JU5FvFqUrbLBdl?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 19:36:01.0024 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5d0aa66-c151-4c68-b7fe-08dc80169240
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4279
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

A wavefront may deallocate its VGPRs at the end of a program while
waiting for memory transactions to complete. If it subsequently
receives a context save exception it will be unable to save,
since this requires VGPRs. In this case the trap handler should
terminate the wavefront.

Fixes intermittent VM faults under context switching load.

V2: Use S_ENDPGM instead of S_ENDPGM_SAVED for performance counters

Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
Cc: Lancelot Six <lancelot.six@amd.com>
---
 .../gpu/drm/amd/amdkfd/cwsr_trap_handler.h    | 695 +++++++++---------
 .../amd/amdkfd/cwsr_trap_handler_gfx10.asm    |  17 +
 2 files changed, 366 insertions(+), 346 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
index 85a41e121cce..665122d1bbbd 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
@@ -2705,7 +2705,7 @@ static const uint32_t cwsr_trap_gfx10_hex[] = {
 };
 
 static const uint32_t cwsr_trap_gfx11_hex[] = {
-	0xbfa00001, 0xbfa00224,
+	0xbfa00001, 0xbfa00227,
 	0xb0804006, 0xb8f8f802,
 	0x9178ff78, 0x00020006,
 	0xb8fbf803, 0xbf0d9e6d,
@@ -2750,399 +2750,400 @@ static const uint32_t cwsr_trap_gfx11_hex[] = {
 	0x8b6dff6d, 0x0000ffff,
 	0x8bfe7e7e, 0x8bea6a6a,
 	0xb978f802, 0xbe804a6c,
-	0x8b6dff6d, 0x0000ffff,
-	0xbefa0080, 0xb97a0283,
-	0xbeee007e, 0xbeef007f,
-	0xbefe0180, 0xbefe4d84,
-	0xbf890000, 0x8b7aff7f,
-	0x04000000, 0x847a857a,
-	0x8c6d7a6d, 0xbefa007e,
-	0x8b7bff7f, 0x0000ffff,
-	0xbefe00c1, 0xbeff00c1,
-	0xdca6c000, 0x007a0000,
-	0x7e000280, 0xbefe007a,
-	0xbeff007b, 0xb8fb02dc,
-	0x847b997b, 0xb8fa3b05,
-	0x807a817a, 0xbf0d997b,
-	0xbfa20002, 0x847a897a,
-	0xbfa00001, 0x847a8a7a,
-	0xb8fb1e06, 0x847b8a7b,
-	0x807a7b7a, 0x8b7bff7f,
-	0x0000ffff, 0x807aff7a,
-	0x00000200, 0x807a7e7a,
-	0x827b807b, 0xd7610000,
-	0x00010870, 0xd7610000,
-	0x00010a71, 0xd7610000,
-	0x00010c72, 0xd7610000,
-	0x00010e73, 0xd7610000,
-	0x00011074, 0xd7610000,
-	0x00011275, 0xd7610000,
-	0x00011476, 0xd7610000,
-	0x00011677, 0xd7610000,
-	0x00011a79, 0xd7610000,
-	0x00011c7e, 0xd7610000,
-	0x00011e7f, 0xbefe00ff,
-	0x00003fff, 0xbeff0080,
-	0xdca6c040, 0x007a0000,
-	0xd760007a, 0x00011d00,
-	0xd760007b, 0x00011f00,
+	0xbf0d9878, 0xbfa10001,
+	0xbfb00000, 0x8b6dff6d,
+	0x0000ffff, 0xbefa0080,
+	0xb97a0283, 0xbeee007e,
+	0xbeef007f, 0xbefe0180,
+	0xbefe4d84, 0xbf890000,
+	0x8b7aff7f, 0x04000000,
+	0x847a857a, 0x8c6d7a6d,
+	0xbefa007e, 0x8b7bff7f,
+	0x0000ffff, 0xbefe00c1,
+	0xbeff00c1, 0xdca6c000,
+	0x007a0000, 0x7e000280,
 	0xbefe007a, 0xbeff007b,
-	0xbef4007e, 0x8b75ff7f,
-	0x0000ffff, 0x8c75ff75,
-	0x00040000, 0xbef60080,
-	0xbef700ff, 0x10807fac,
-	0xbef1007d, 0xbef00080,
-	0xb8f302dc, 0x84739973,
-	0xbefe00c1, 0x857d9973,
-	0x8b7d817d, 0xbf06817d,
-	0xbfa20002, 0xbeff0080,
-	0xbfa00002, 0xbeff00c1,
-	0xbfa00009, 0xbef600ff,
-	0x01000000, 0xe0685080,
-	0x701d0100, 0xe0685100,
-	0x701d0200, 0xe0685180,
-	0x701d0300, 0xbfa00008,
+	0xb8fb02dc, 0x847b997b,
+	0xb8fa3b05, 0x807a817a,
+	0xbf0d997b, 0xbfa20002,
+	0x847a897a, 0xbfa00001,
+	0x847a8a7a, 0xb8fb1e06,
+	0x847b8a7b, 0x807a7b7a,
+	0x8b7bff7f, 0x0000ffff,
+	0x807aff7a, 0x00000200,
+	0x807a7e7a, 0x827b807b,
+	0xd7610000, 0x00010870,
+	0xd7610000, 0x00010a71,
+	0xd7610000, 0x00010c72,
+	0xd7610000, 0x00010e73,
+	0xd7610000, 0x00011074,
+	0xd7610000, 0x00011275,
+	0xd7610000, 0x00011476,
+	0xd7610000, 0x00011677,
+	0xd7610000, 0x00011a79,
+	0xd7610000, 0x00011c7e,
+	0xd7610000, 0x00011e7f,
+	0xbefe00ff, 0x00003fff,
+	0xbeff0080, 0xdca6c040,
+	0x007a0000, 0xd760007a,
+	0x00011d00, 0xd760007b,
+	0x00011f00, 0xbefe007a,
+	0xbeff007b, 0xbef4007e,
+	0x8b75ff7f, 0x0000ffff,
+	0x8c75ff75, 0x00040000,
+	0xbef60080, 0xbef700ff,
+	0x10807fac, 0xbef1007d,
+	0xbef00080, 0xb8f302dc,
+	0x84739973, 0xbefe00c1,
+	0x857d9973, 0x8b7d817d,
+	0xbf06817d, 0xbfa20002,
+	0xbeff0080, 0xbfa00002,
+	0xbeff00c1, 0xbfa00009,
 	0xbef600ff, 0x01000000,
-	0xe0685100, 0x701d0100,
-	0xe0685200, 0x701d0200,
-	0xe0685300, 0x701d0300,
+	0xe0685080, 0x701d0100,
+	0xe0685100, 0x701d0200,
+	0xe0685180, 0x701d0300,
+	0xbfa00008, 0xbef600ff,
+	0x01000000, 0xe0685100,
+	0x701d0100, 0xe0685200,
+	0x701d0200, 0xe0685300,
+	0x701d0300, 0xb8f03b05,
+	0x80708170, 0xbf0d9973,
+	0xbfa20002, 0x84708970,
+	0xbfa00001, 0x84708a70,
+	0xb8fa1e06, 0x847a8a7a,
+	0x80707a70, 0x8070ff70,
+	0x00000200, 0xbef600ff,
+	0x01000000, 0x7e000280,
+	0x7e020280, 0x7e040280,
+	0xbefd0080, 0xd7610002,
+	0x0000fa71, 0x807d817d,
+	0xd7610002, 0x0000fa6c,
+	0x807d817d, 0x917aff6d,
+	0x80000000, 0xd7610002,
+	0x0000fa7a, 0x807d817d,
+	0xd7610002, 0x0000fa6e,
+	0x807d817d, 0xd7610002,
+	0x0000fa6f, 0x807d817d,
+	0xd7610002, 0x0000fa78,
+	0x807d817d, 0xb8faf803,
+	0xd7610002, 0x0000fa7a,
+	0x807d817d, 0xd7610002,
+	0x0000fa7b, 0x807d817d,
+	0xb8f1f801, 0xd7610002,
+	0x0000fa71, 0x807d817d,
+	0xb8f1f814, 0xd7610002,
+	0x0000fa71, 0x807d817d,
+	0xb8f1f815, 0xd7610002,
+	0x0000fa71, 0x807d817d,
+	0xbefe00ff, 0x0000ffff,
+	0xbeff0080, 0xe0685000,
+	0x701d0200, 0xbefe00c1,
 	0xb8f03b05, 0x80708170,
 	0xbf0d9973, 0xbfa20002,
 	0x84708970, 0xbfa00001,
 	0x84708a70, 0xb8fa1e06,
 	0x847a8a7a, 0x80707a70,
-	0x8070ff70, 0x00000200,
 	0xbef600ff, 0x01000000,
-	0x7e000280, 0x7e020280,
-	0x7e040280, 0xbefd0080,
-	0xd7610002, 0x0000fa71,
-	0x807d817d, 0xd7610002,
-	0x0000fa6c, 0x807d817d,
-	0x917aff6d, 0x80000000,
-	0xd7610002, 0x0000fa7a,
-	0x807d817d, 0xd7610002,
-	0x0000fa6e, 0x807d817d,
-	0xd7610002, 0x0000fa6f,
-	0x807d817d, 0xd7610002,
-	0x0000fa78, 0x807d817d,
-	0xb8faf803, 0xd7610002,
-	0x0000fa7a, 0x807d817d,
-	0xd7610002, 0x0000fa7b,
-	0x807d817d, 0xb8f1f801,
-	0xd7610002, 0x0000fa71,
-	0x807d817d, 0xb8f1f814,
-	0xd7610002, 0x0000fa71,
-	0x807d817d, 0xb8f1f815,
-	0xd7610002, 0x0000fa71,
-	0x807d817d, 0xbefe00ff,
-	0x0000ffff, 0xbeff0080,
-	0xe0685000, 0x701d0200,
-	0xbefe00c1, 0xb8f03b05,
-	0x80708170, 0xbf0d9973,
-	0xbfa20002, 0x84708970,
-	0xbfa00001, 0x84708a70,
-	0xb8fa1e06, 0x847a8a7a,
-	0x80707a70, 0xbef600ff,
-	0x01000000, 0xbef90080,
-	0xbefd0080, 0xbf800000,
-	0xbe804100, 0xbe824102,
-	0xbe844104, 0xbe864106,
-	0xbe884108, 0xbe8a410a,
-	0xbe8c410c, 0xbe8e410e,
-	0xd7610002, 0x0000f200,
-	0x80798179, 0xd7610002,
-	0x0000f201, 0x80798179,
-	0xd7610002, 0x0000f202,
-	0x80798179, 0xd7610002,
-	0x0000f203, 0x80798179,
-	0xd7610002, 0x0000f204,
+	0xbef90080, 0xbefd0080,
+	0xbf800000, 0xbe804100,
+	0xbe824102, 0xbe844104,
+	0xbe864106, 0xbe884108,
+	0xbe8a410a, 0xbe8c410c,
+	0xbe8e410e, 0xd7610002,
+	0x0000f200, 0x80798179,
+	0xd7610002, 0x0000f201,
 	0x80798179, 0xd7610002,
-	0x0000f205, 0x80798179,
-	0xd7610002, 0x0000f206,
+	0x0000f202, 0x80798179,
+	0xd7610002, 0x0000f203,
 	0x80798179, 0xd7610002,
-	0x0000f207, 0x80798179,
-	0xd7610002, 0x0000f208,
+	0x0000f204, 0x80798179,
+	0xd7610002, 0x0000f205,
 	0x80798179, 0xd7610002,
-	0x0000f209, 0x80798179,
-	0xd7610002, 0x0000f20a,
+	0x0000f206, 0x80798179,
+	0xd7610002, 0x0000f207,
 	0x80798179, 0xd7610002,
-	0x0000f20b, 0x80798179,
-	0xd7610002, 0x0000f20c,
+	0x0000f208, 0x80798179,
+	0xd7610002, 0x0000f209,
 	0x80798179, 0xd7610002,
-	0x0000f20d, 0x80798179,
-	0xd7610002, 0x0000f20e,
+	0x0000f20a, 0x80798179,
+	0xd7610002, 0x0000f20b,
 	0x80798179, 0xd7610002,
-	0x0000f20f, 0x80798179,
-	0xbf06a079, 0xbfa10006,
-	0xe0685000, 0x701d0200,
-	0x8070ff70, 0x00000080,
-	0xbef90080, 0x7e040280,
-	0x807d907d, 0xbf0aff7d,
-	0x00000060, 0xbfa2ffbc,
-	0xbe804100, 0xbe824102,
-	0xbe844104, 0xbe864106,
-	0xbe884108, 0xbe8a410a,
-	0xd7610002, 0x0000f200,
+	0x0000f20c, 0x80798179,
+	0xd7610002, 0x0000f20d,
 	0x80798179, 0xd7610002,
-	0x0000f201, 0x80798179,
-	0xd7610002, 0x0000f202,
+	0x0000f20e, 0x80798179,
+	0xd7610002, 0x0000f20f,
+	0x80798179, 0xbf06a079,
+	0xbfa10006, 0xe0685000,
+	0x701d0200, 0x8070ff70,
+	0x00000080, 0xbef90080,
+	0x7e040280, 0x807d907d,
+	0xbf0aff7d, 0x00000060,
+	0xbfa2ffbc, 0xbe804100,
+	0xbe824102, 0xbe844104,
+	0xbe864106, 0xbe884108,
+	0xbe8a410a, 0xd7610002,
+	0x0000f200, 0x80798179,
+	0xd7610002, 0x0000f201,
 	0x80798179, 0xd7610002,
-	0x0000f203, 0x80798179,
-	0xd7610002, 0x0000f204,
+	0x0000f202, 0x80798179,
+	0xd7610002, 0x0000f203,
 	0x80798179, 0xd7610002,
-	0x0000f205, 0x80798179,
-	0xd7610002, 0x0000f206,
+	0x0000f204, 0x80798179,
+	0xd7610002, 0x0000f205,
 	0x80798179, 0xd7610002,
-	0x0000f207, 0x80798179,
-	0xd7610002, 0x0000f208,
+	0x0000f206, 0x80798179,
+	0xd7610002, 0x0000f207,
 	0x80798179, 0xd7610002,
-	0x0000f209, 0x80798179,
-	0xd7610002, 0x0000f20a,
+	0x0000f208, 0x80798179,
+	0xd7610002, 0x0000f209,
 	0x80798179, 0xd7610002,
-	0x0000f20b, 0x80798179,
-	0xe0685000, 0x701d0200,
-	0xbefe00c1, 0x857d9973,
-	0x8b7d817d, 0xbf06817d,
-	0xbfa20002, 0xbeff0080,
-	0xbfa00001, 0xbeff00c1,
-	0xb8fb4306, 0x8b7bc17b,
-	0xbfa10043, 0xbfbd0000,
-	0x8b7aff6d, 0x80000000,
-	0xbfa1003f, 0x847b887b,
-	0xbef6007b, 0xb8f03b05,
-	0x80708170, 0xbf0d9973,
-	0xbfa20002, 0x84708970,
-	0xbfa00001, 0x84708a70,
-	0xb8fa1e06, 0x847a8a7a,
-	0x80707a70, 0x8070ff70,
-	0x00000200, 0x8070ff70,
-	0x00000080, 0xbef600ff,
-	0x01000000, 0xd71f0000,
-	0x000100c1, 0xd7200000,
-	0x000200c1, 0x16000084,
+	0x0000f20a, 0x80798179,
+	0xd7610002, 0x0000f20b,
+	0x80798179, 0xe0685000,
+	0x701d0200, 0xbefe00c1,
 	0x857d9973, 0x8b7d817d,
-	0xbf06817d, 0xbefd0080,
-	0xbfa20012, 0xbe8300ff,
-	0x00000080, 0xbf800000,
+	0xbf06817d, 0xbfa20002,
+	0xbeff0080, 0xbfa00001,
+	0xbeff00c1, 0xb8fb4306,
+	0x8b7bc17b, 0xbfa10043,
+	0xbfbd0000, 0x8b7aff6d,
+	0x80000000, 0xbfa1003f,
+	0x847b887b, 0xbef6007b,
+	0xb8f03b05, 0x80708170,
+	0xbf0d9973, 0xbfa20002,
+	0x84708970, 0xbfa00001,
+	0x84708a70, 0xb8fa1e06,
+	0x847a8a7a, 0x80707a70,
+	0x8070ff70, 0x00000200,
+	0x8070ff70, 0x00000080,
+	0xbef600ff, 0x01000000,
+	0xd71f0000, 0x000100c1,
+	0xd7200000, 0x000200c1,
+	0x16000084, 0x857d9973,
+	0x8b7d817d, 0xbf06817d,
+	0xbefd0080, 0xbfa20012,
+	0xbe8300ff, 0x00000080,
 	0xbf800000, 0xbf800000,
-	0xd8d80000, 0x01000000,
-	0xbf890000, 0xe0685000,
-	0x701d0100, 0x807d037d,
-	0x80700370, 0xd5250000,
-	0x0001ff00, 0x00000080,
-	0xbf0a7b7d, 0xbfa2fff4,
-	0xbfa00011, 0xbe8300ff,
-	0x00000100, 0xbf800000,
+	0xbf800000, 0xd8d80000,
+	0x01000000, 0xbf890000,
+	0xe0685000, 0x701d0100,
+	0x807d037d, 0x80700370,
+	0xd5250000, 0x0001ff00,
+	0x00000080, 0xbf0a7b7d,
+	0xbfa2fff4, 0xbfa00011,
+	0xbe8300ff, 0x00000100,
 	0xbf800000, 0xbf800000,
-	0xd8d80000, 0x01000000,
-	0xbf890000, 0xe0685000,
-	0x701d0100, 0x807d037d,
-	0x80700370, 0xd5250000,
-	0x0001ff00, 0x00000100,
-	0xbf0a7b7d, 0xbfa2fff4,
-	0xbefe00c1, 0x857d9973,
-	0x8b7d817d, 0xbf06817d,
-	0xbfa20004, 0xbef000ff,
-	0x00000200, 0xbeff0080,
-	0xbfa00003, 0xbef000ff,
-	0x00000400, 0xbeff00c1,
-	0xb8fb3b05, 0x807b817b,
-	0x847b827b, 0x857d9973,
-	0x8b7d817d, 0xbf06817d,
-	0xbfa20017, 0xbef600ff,
-	0x01000000, 0xbefd0084,
-	0xbf0a7b7d, 0xbfa10037,
-	0x7e008700, 0x7e028701,
-	0x7e048702, 0x7e068703,
-	0xe0685000, 0x701d0000,
-	0xe0685080, 0x701d0100,
-	0xe0685100, 0x701d0200,
-	0xe0685180, 0x701d0300,
-	0x807d847d, 0x8070ff70,
-	0x00000200, 0xbf0a7b7d,
-	0xbfa2ffef, 0xbfa00025,
+	0xbf800000, 0xd8d80000,
+	0x01000000, 0xbf890000,
+	0xe0685000, 0x701d0100,
+	0x807d037d, 0x80700370,
+	0xd5250000, 0x0001ff00,
+	0x00000100, 0xbf0a7b7d,
+	0xbfa2fff4, 0xbefe00c1,
+	0x857d9973, 0x8b7d817d,
+	0xbf06817d, 0xbfa20004,
+	0xbef000ff, 0x00000200,
+	0xbeff0080, 0xbfa00003,
+	0xbef000ff, 0x00000400,
+	0xbeff00c1, 0xb8fb3b05,
+	0x807b817b, 0x847b827b,
+	0x857d9973, 0x8b7d817d,
+	0xbf06817d, 0xbfa20017,
 	0xbef600ff, 0x01000000,
 	0xbefd0084, 0xbf0a7b7d,
-	0xbfa10011, 0x7e008700,
+	0xbfa10037, 0x7e008700,
 	0x7e028701, 0x7e048702,
 	0x7e068703, 0xe0685000,
-	0x701d0000, 0xe0685100,
-	0x701d0100, 0xe0685200,
-	0x701d0200, 0xe0685300,
+	0x701d0000, 0xe0685080,
+	0x701d0100, 0xe0685100,
+	0x701d0200, 0xe0685180,
 	0x701d0300, 0x807d847d,
-	0x8070ff70, 0x00000400,
+	0x8070ff70, 0x00000200,
 	0xbf0a7b7d, 0xbfa2ffef,
-	0xb8fb1e06, 0x8b7bc17b,
-	0xbfa1000c, 0x847b837b,
-	0x807b7d7b, 0xbefe00c1,
-	0xbeff0080, 0x7e008700,
+	0xbfa00025, 0xbef600ff,
+	0x01000000, 0xbefd0084,
+	0xbf0a7b7d, 0xbfa10011,
+	0x7e008700, 0x7e028701,
+	0x7e048702, 0x7e068703,
 	0xe0685000, 0x701d0000,
-	0x807d817d, 0x8070ff70,
-	0x00000080, 0xbf0a7b7d,
-	0xbfa2fff8, 0xbfa0013f,
-	0xbef4007e, 0x8b75ff7f,
-	0x0000ffff, 0x8c75ff75,
-	0x00040000, 0xbef60080,
-	0xbef700ff, 0x10807fac,
-	0xb8f202dc, 0x84729972,
-	0x8b6eff7f, 0x04000000,
-	0xbfa10039, 0xbefe00c1,
-	0x857d9972, 0x8b7d817d,
-	0xbf06817d, 0xbfa20002,
-	0xbeff0080, 0xbfa00001,
-	0xbeff00c1, 0xb8ef4306,
-	0x8b6fc16f, 0xbfa1002e,
-	0x846f886f, 0xbef6006f,
-	0xb8f83b05, 0x80788178,
-	0xbf0d9972, 0xbfa20002,
-	0x84788978, 0xbfa00001,
-	0x84788a78, 0xb8ee1e06,
-	0x846e8a6e, 0x80786e78,
+	0xe0685100, 0x701d0100,
+	0xe0685200, 0x701d0200,
+	0xe0685300, 0x701d0300,
+	0x807d847d, 0x8070ff70,
+	0x00000400, 0xbf0a7b7d,
+	0xbfa2ffef, 0xb8fb1e06,
+	0x8b7bc17b, 0xbfa1000c,
+	0x847b837b, 0x807b7d7b,
+	0xbefe00c1, 0xbeff0080,
+	0x7e008700, 0xe0685000,
+	0x701d0000, 0x807d817d,
+	0x8070ff70, 0x00000080,
+	0xbf0a7b7d, 0xbfa2fff8,
+	0xbfa0013f, 0xbef4007e,
+	0x8b75ff7f, 0x0000ffff,
+	0x8c75ff75, 0x00040000,
+	0xbef60080, 0xbef700ff,
+	0x10807fac, 0xb8f202dc,
+	0x84729972, 0x8b6eff7f,
+	0x04000000, 0xbfa10039,
+	0xbefe00c1, 0x857d9972,
+	0x8b7d817d, 0xbf06817d,
+	0xbfa20002, 0xbeff0080,
+	0xbfa00001, 0xbeff00c1,
+	0xb8ef4306, 0x8b6fc16f,
+	0xbfa1002e, 0x846f886f,
+	0xbef6006f, 0xb8f83b05,
+	0x80788178, 0xbf0d9972,
+	0xbfa20002, 0x84788978,
+	0xbfa00001, 0x84788a78,
+	0xb8ee1e06, 0x846e8a6e,
+	0x80786e78, 0x8078ff78,
+	0x00000200, 0x8078ff78,
+	0x00000080, 0xbef600ff,
+	0x01000000, 0x857d9972,
+	0x8b7d817d, 0xbf06817d,
+	0xbefd0080, 0xbfa2000c,
+	0xe0500000, 0x781d0000,
+	0xbf890000, 0xdac00000,
+	0x00000000, 0x807dff7d,
+	0x00000080, 0x8078ff78,
+	0x00000080, 0xbf0a6f7d,
+	0xbfa2fff5, 0xbfa0000b,
+	0xe0500000, 0x781d0000,
+	0xbf890000, 0xdac00000,
+	0x00000000, 0x807dff7d,
+	0x00000100, 0x8078ff78,
+	0x00000100, 0xbf0a6f7d,
+	0xbfa2fff5, 0xbef80080,
+	0xbefe00c1, 0x857d9972,
+	0x8b7d817d, 0xbf06817d,
+	0xbfa20002, 0xbeff0080,
+	0xbfa00001, 0xbeff00c1,
+	0xb8ef3b05, 0x806f816f,
+	0x846f826f, 0x857d9972,
+	0x8b7d817d, 0xbf06817d,
+	0xbfa20024, 0xbef600ff,
+	0x01000000, 0xbeee0078,
 	0x8078ff78, 0x00000200,
-	0x8078ff78, 0x00000080,
-	0xbef600ff, 0x01000000,
-	0x857d9972, 0x8b7d817d,
-	0xbf06817d, 0xbefd0080,
-	0xbfa2000c, 0xe0500000,
-	0x781d0000, 0xbf890000,
-	0xdac00000, 0x00000000,
-	0x807dff7d, 0x00000080,
-	0x8078ff78, 0x00000080,
-	0xbf0a6f7d, 0xbfa2fff5,
-	0xbfa0000b, 0xe0500000,
-	0x781d0000, 0xbf890000,
-	0xdac00000, 0x00000000,
-	0x807dff7d, 0x00000100,
-	0x8078ff78, 0x00000100,
-	0xbf0a6f7d, 0xbfa2fff5,
-	0xbef80080, 0xbefe00c1,
-	0x857d9972, 0x8b7d817d,
-	0xbf06817d, 0xbfa20002,
-	0xbeff0080, 0xbfa00001,
-	0xbeff00c1, 0xb8ef3b05,
-	0x806f816f, 0x846f826f,
-	0x857d9972, 0x8b7d817d,
-	0xbf06817d, 0xbfa20024,
-	0xbef600ff, 0x01000000,
-	0xbeee0078, 0x8078ff78,
-	0x00000200, 0xbefd0084,
-	0xbf0a6f7d, 0xbfa10050,
+	0xbefd0084, 0xbf0a6f7d,
+	0xbfa10050, 0xe0505000,
+	0x781d0000, 0xe0505080,
+	0x781d0100, 0xe0505100,
+	0x781d0200, 0xe0505180,
+	0x781d0300, 0xbf890000,
+	0x7e008500, 0x7e028501,
+	0x7e048502, 0x7e068503,
+	0x807d847d, 0x8078ff78,
+	0x00000200, 0xbf0a6f7d,
+	0xbfa2ffee, 0xe0505000,
+	0x6e1d0000, 0xe0505080,
+	0x6e1d0100, 0xe0505100,
+	0x6e1d0200, 0xe0505180,
+	0x6e1d0300, 0xbf890000,
+	0xbfa00034, 0xbef600ff,
+	0x01000000, 0xbeee0078,
+	0x8078ff78, 0x00000400,
+	0xbefd0084, 0xbf0a6f7d,
+	0xbfa10012, 0xe0505000,
+	0x781d0000, 0xe0505100,
+	0x781d0100, 0xe0505200,
+	0x781d0200, 0xe0505300,
+	0x781d0300, 0xbf890000,
+	0x7e008500, 0x7e028501,
+	0x7e048502, 0x7e068503,
+	0x807d847d, 0x8078ff78,
+	0x00000400, 0xbf0a6f7d,
+	0xbfa2ffee, 0xb8ef1e06,
+	0x8b6fc16f, 0xbfa1000e,
+	0x846f836f, 0x806f7d6f,
+	0xbefe00c1, 0xbeff0080,
 	0xe0505000, 0x781d0000,
-	0xe0505080, 0x781d0100,
-	0xe0505100, 0x781d0200,
-	0xe0505180, 0x781d0300,
 	0xbf890000, 0x7e008500,
-	0x7e028501, 0x7e048502,
-	0x7e068503, 0x807d847d,
-	0x8078ff78, 0x00000200,
-	0xbf0a6f7d, 0xbfa2ffee,
+	0x807d817d, 0x8078ff78,
+	0x00000080, 0xbf0a6f7d,
+	0xbfa2fff7, 0xbeff00c1,
 	0xe0505000, 0x6e1d0000,
-	0xe0505080, 0x6e1d0100,
-	0xe0505100, 0x6e1d0200,
-	0xe0505180, 0x6e1d0300,
-	0xbf890000, 0xbfa00034,
-	0xbef600ff, 0x01000000,
-	0xbeee0078, 0x8078ff78,
-	0x00000400, 0xbefd0084,
-	0xbf0a6f7d, 0xbfa10012,
-	0xe0505000, 0x781d0000,
-	0xe0505100, 0x781d0100,
-	0xe0505200, 0x781d0200,
-	0xe0505300, 0x781d0300,
-	0xbf890000, 0x7e008500,
-	0x7e028501, 0x7e048502,
-	0x7e068503, 0x807d847d,
-	0x8078ff78, 0x00000400,
-	0xbf0a6f7d, 0xbfa2ffee,
-	0xb8ef1e06, 0x8b6fc16f,
-	0xbfa1000e, 0x846f836f,
-	0x806f7d6f, 0xbefe00c1,
-	0xbeff0080, 0xe0505000,
-	0x781d0000, 0xbf890000,
-	0x7e008500, 0x807d817d,
-	0x8078ff78, 0x00000080,
-	0xbf0a6f7d, 0xbfa2fff7,
-	0xbeff00c1, 0xe0505000,
-	0x6e1d0000, 0xe0505100,
-	0x6e1d0100, 0xe0505200,
-	0x6e1d0200, 0xe0505300,
-	0x6e1d0300, 0xbf890000,
+	0xe0505100, 0x6e1d0100,
+	0xe0505200, 0x6e1d0200,
+	0xe0505300, 0x6e1d0300,
+	0xbf890000, 0xb8f83b05,
+	0x80788178, 0xbf0d9972,
+	0xbfa20002, 0x84788978,
+	0xbfa00001, 0x84788a78,
+	0xb8ee1e06, 0x846e8a6e,
+	0x80786e78, 0x8078ff78,
+	0x00000200, 0x80f8ff78,
+	0x00000050, 0xbef600ff,
+	0x01000000, 0xbefd00ff,
+	0x0000006c, 0x80f89078,
+	0xf428403a, 0xf0000000,
+	0xbf890000, 0x80fd847d,
+	0xbf800000, 0xbe804300,
+	0xbe824302, 0x80f8a078,
+	0xf42c403a, 0xf0000000,
+	0xbf890000, 0x80fd887d,
+	0xbf800000, 0xbe804300,
+	0xbe824302, 0xbe844304,
+	0xbe864306, 0x80f8c078,
+	0xf430403a, 0xf0000000,
+	0xbf890000, 0x80fd907d,
+	0xbf800000, 0xbe804300,
+	0xbe824302, 0xbe844304,
+	0xbe864306, 0xbe884308,
+	0xbe8a430a, 0xbe8c430c,
+	0xbe8e430e, 0xbf06807d,
+	0xbfa1fff0, 0xb980f801,
+	0x00000000, 0xbfbd0000,
 	0xb8f83b05, 0x80788178,
 	0xbf0d9972, 0xbfa20002,
 	0x84788978, 0xbfa00001,
 	0x84788a78, 0xb8ee1e06,
 	0x846e8a6e, 0x80786e78,
 	0x8078ff78, 0x00000200,
-	0x80f8ff78, 0x00000050,
 	0xbef600ff, 0x01000000,
-	0xbefd00ff, 0x0000006c,
-	0x80f89078, 0xf428403a,
-	0xf0000000, 0xbf890000,
-	0x80fd847d, 0xbf800000,
-	0xbe804300, 0xbe824302,
-	0x80f8a078, 0xf42c403a,
-	0xf0000000, 0xbf890000,
-	0x80fd887d, 0xbf800000,
-	0xbe804300, 0xbe824302,
-	0xbe844304, 0xbe864306,
-	0x80f8c078, 0xf430403a,
-	0xf0000000, 0xbf890000,
-	0x80fd907d, 0xbf800000,
-	0xbe804300, 0xbe824302,
-	0xbe844304, 0xbe864306,
-	0xbe884308, 0xbe8a430a,
-	0xbe8c430c, 0xbe8e430e,
-	0xbf06807d, 0xbfa1fff0,
-	0xb980f801, 0x00000000,
-	0xbfbd0000, 0xb8f83b05,
-	0x80788178, 0xbf0d9972,
-	0xbfa20002, 0x84788978,
-	0xbfa00001, 0x84788a78,
-	0xb8ee1e06, 0x846e8a6e,
-	0x80786e78, 0x8078ff78,
-	0x00000200, 0xbef600ff,
-	0x01000000, 0xf4205bfa,
+	0xf4205bfa, 0xf0000000,
+	0x80788478, 0xf4205b3a,
 	0xf0000000, 0x80788478,
-	0xf4205b3a, 0xf0000000,
-	0x80788478, 0xf4205b7a,
+	0xf4205b7a, 0xf0000000,
+	0x80788478, 0xf4205c3a,
 	0xf0000000, 0x80788478,
-	0xf4205c3a, 0xf0000000,
-	0x80788478, 0xf4205c7a,
+	0xf4205c7a, 0xf0000000,
+	0x80788478, 0xf4205eba,
 	0xf0000000, 0x80788478,
-	0xf4205eba, 0xf0000000,
-	0x80788478, 0xf4205efa,
+	0xf4205efa, 0xf0000000,
+	0x80788478, 0xf4205e7a,
 	0xf0000000, 0x80788478,
-	0xf4205e7a, 0xf0000000,
-	0x80788478, 0xf4205cfa,
+	0xf4205cfa, 0xf0000000,
+	0x80788478, 0xf4205bba,
 	0xf0000000, 0x80788478,
+	0xbf890000, 0xb96ef814,
 	0xf4205bba, 0xf0000000,
 	0x80788478, 0xbf890000,
-	0xb96ef814, 0xf4205bba,
-	0xf0000000, 0x80788478,
-	0xbf890000, 0xb96ef815,
-	0xbefd006f, 0xbefe0070,
-	0xbeff0071, 0xb97bf803,
-	0xb973f801, 0xb8ee3b05,
-	0x806e816e, 0xbf0d9972,
-	0xbfa20002, 0x846e896e,
-	0xbfa00001, 0x846e8a6e,
-	0xb8ef1e06, 0x846f8a6f,
-	0x806e6f6e, 0x806eff6e,
-	0x00000200, 0x806e746e,
-	0x826f8075, 0x8b6fff6f,
-	0x0000ffff, 0xf4085c37,
-	0xf8000050, 0xf4085d37,
-	0xf8000060, 0xf4005e77,
-	0xf8000074, 0xbf890000,
-	0x8b6dff6d, 0x0000ffff,
-	0x8bfe7e7e, 0x8bea6a6a,
-	0xb8eef802, 0xbf0d866e,
-	0xbfa20002, 0xb97af802,
-	0xbe80486c, 0xb97af802,
-	0xbe804a6c, 0xbfb10000,
+	0xb96ef815, 0xbefd006f,
+	0xbefe0070, 0xbeff0071,
+	0xb97bf803, 0xb973f801,
+	0xb8ee3b05, 0x806e816e,
+	0xbf0d9972, 0xbfa20002,
+	0x846e896e, 0xbfa00001,
+	0x846e8a6e, 0xb8ef1e06,
+	0x846f8a6f, 0x806e6f6e,
+	0x806eff6e, 0x00000200,
+	0x806e746e, 0x826f8075,
+	0x8b6fff6f, 0x0000ffff,
+	0xf4085c37, 0xf8000050,
+	0xf4085d37, 0xf8000060,
+	0xf4005e77, 0xf8000074,
+	0xbf890000, 0x8b6dff6d,
+	0x0000ffff, 0x8bfe7e7e,
+	0x8bea6a6a, 0xb8eef802,
+	0xbf0d866e, 0xbfa20002,
+	0xb97af802, 0xbe80486c,
+	0xb97af802, 0xbe804a6c,
+	0xbfb10000, 0xbf9f0000,
 	0xbf9f0000, 0xbf9f0000,
 	0xbf9f0000, 0xbf9f0000,
-	0xbf9f0000, 0x00000000,
 };
 
 static const uint32_t cwsr_trap_gfx9_4_3_hex[] = {
@@ -3635,7 +3636,7 @@ static const uint32_t cwsr_trap_gfx9_4_3_hex[] = {
 };
 
 static const uint32_t cwsr_trap_gfx12_hex[] = {
-	0xbfa00001, 0xbfa00247,
+	0xbfa00001, 0xbfa0024b,
 	0xb0804009, 0xb8f8f804,
 	0x9178ff78, 0x00008c00,
 	0xb8fbf811, 0x8b6eff78,
@@ -3675,7 +3676,9 @@ static const uint32_t cwsr_trap_gfx12_hex[] = {
 	0x8b6dff6d, 0x0000ffff,
 	0x8bfe7e7e, 0x8bea6a6a,
 	0x85788978, 0xb9783244,
-	0xbe804a6c, 0x8b6dff6d,
+	0xbe804a6c, 0xb8faf802,
+	0xbf0d987a, 0xbfa10001,
+	0xbfb00000, 0x8b6dff6d,
 	0x0000ffff, 0xbefa0080,
 	0xb97a0151, 0xbeee007e,
 	0xbeef007f, 0xbefe0180,
diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
index 18e012e04493..ac3702b8e3c4 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
@@ -97,6 +97,7 @@ var S_STATUS_HALT_MASK				= SQ_WAVE_STATE_PRIV_HALT_MASK
 var S_SAVE_PC_HI_TRAP_ID_MASK			= 0xF0000000
 #endif
 
+var SQ_WAVE_STATUS_NO_VGPRS_SHIFT		= 24
 var SQ_WAVE_LDS_ALLOC_LDS_SIZE_SHIFT		= 12
 var SQ_WAVE_LDS_ALLOC_LDS_SIZE_SIZE		= 9
 var SQ_WAVE_GPR_ALLOC_VGPR_SIZE_SIZE		= 8
@@ -451,6 +452,22 @@ L_EXIT_TRAP:
 	s_rfe_b64	[ttmp0, ttmp1]
 
 L_SAVE:
+	// If VGPRs have been deallocated then terminate the wavefront.
+	// It has no remaining program to run and cannot save without VGPRs.
+#if ASIC_FAMILY == CHIP_PLUM_BONITO
+	s_bitcmp1_b32	s_save_status, SQ_WAVE_STATUS_NO_VGPRS_SHIFT
+	s_cbranch_scc0	L_HAVE_VGPRS
+	s_endpgm
+L_HAVE_VGPRS:
+#endif
+#if ASIC_FAMILY >= CHIP_GFX12
+	s_getreg_b32	s_save_tmp, hwreg(HW_REG_WAVE_STATUS)
+	s_bitcmp1_b32	s_save_tmp, SQ_WAVE_STATUS_NO_VGPRS_SHIFT
+	s_cbranch_scc0	L_HAVE_VGPRS
+	s_endpgm
+L_HAVE_VGPRS:
+#endif
+
 	s_and_b32	s_save_pc_hi, s_save_pc_hi, 0x0000ffff			//pc[47:32]
 	s_mov_b32	s_save_tmp, 0
 	s_setreg_b32	hwreg(S_TRAPSTS_HWREG, S_TRAPSTS_SAVE_CONTEXT_SHIFT, 1), s_save_tmp	//clear saveCtx bit
-- 
2.34.1

