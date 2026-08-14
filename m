Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AA4FC5CFDB
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 13:57:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5E0810F5D9;
	Fri, 14 Aug 2026 13:57:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yxZ5KD5N";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010044.outbound.protection.outlook.com [52.101.61.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F24A110F5D9
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 13:57:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VEuc4AOyhf9RLY7SWMS3FIiR373Ce+oB3m5L7pmVenE7Cg/9bzrWaAH+on8SRdcR/yQcskc7VGztc3FHh4mE5GwT0DBFtDAqFK261xbf2yKo5vY0bc3NuMfXZTDv5XMMDR4u9xwgfj8CU/cdtMaoNRa2N9Gl+3M/VOY1PwogoGjRHbzme/awPHCnOexu/dH3bkh9cPCtWfT217l+azbvAjJ2Ke6kgiHE+A79X4GYnFRRk2sbdm8W3eFA6ia49GRI5gwgZmE0/tSeGApIs2jcVil/SpA4Vs47oQ6dMXzYw8QMsank04spWw8sA6NB6UuG+NrYujQDLKOlMsQ4s0NrRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WwnoFpscy1v5U8iWRImX5+D7numwHXTVpf2BwkvQS5U=;
 b=reenweZ4zlPkz0Vr/12PKI/Iybrw6yv9dm/Mfd2pGYYwFMhE4Y+kf7lAaYJ6u6XDOVXo0VSkOxmWSsba9LEDsrSyaSvSZnUqsEOfPkLJ4zTj34Ccdm4ypX2xKadae/zB5fK9yL5/t1ej8xj0H4srQFxEwiadTn2YtnghPbQtAzB3BzaIn6uDAgFhEtVxpNUY/GQcwOp/uL4Q3SpCOAutOic/Wit9RSEJa74PNwGDT5W8KbUoCoDqnUARfunpPydRo7Yt7Wkzbz9fO1mm5sYib9+bO0MO7z5hoRiU49ZGAaquXvrVNiLZDxKkRtsax3ZUKf9dGXemmTWMH4lts4TlGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WwnoFpscy1v5U8iWRImX5+D7numwHXTVpf2BwkvQS5U=;
 b=yxZ5KD5NiZDnug7wiqbhKCfdymu4KqnyUFKQD9Z9hPf/fh3MnHT9sPPQBvlYZKb8nZ9TM8K0/bgNau7pOk4ehXZjz28jRdMnMiz2vp8LTJySmBYg5sKGkTE0tR3Pf86YY6YcJuXODBSyz+meX6T11MCpafZmJm8B43wYG1GRwzo=
Received: from BLAPR03CA0151.namprd03.prod.outlook.com (2603:10b6:208:32f::15)
 by DS4PR12MB9634.namprd12.prod.outlook.com (2603:10b6:8:280::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 13:57:38 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:208:32f:cafe::3d) by BLAPR03CA0151.outlook.office365.com
 (2603:10b6:208:32f::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.15 via Frontend Transport; Fri,
 14 Aug 2026 13:57:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 13:57:37 +0000
Received: from siweihe2-Desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 08:57:36 -0500
From: Siwei He <siwei.he@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Jay.Cornwall@amd.com>, <Jonathan.Kim@amd.com>, <Lancelot.Six@amd.com>,
 <Vladimir.Indic@amd.com>, Siwei He <siwei.he@amd.com>
Subject: [PATCH] drm/amdkfd: add dynamic VGPR save/restore to the gfx12 trap
 handler
Date: Fri, 14 Aug 2026 09:57:20 -0400
Message-ID: <20260814135720.3575351-1-siwei.he@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|DS4PR12MB9634:EE_
X-MS-Office365-Filtering-Correlation-Id: 97064257-ef7e-49fa-1558-08defa0bffc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|23010399003|36860700016|18002099003|56012099006|11063799006|3023799007|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: aAcy/qf/pugbmPYhWxdkcG6isiGzgSz5lrR/C+r4Ou6XOtdMt6aruPE91+PGVkQ4LtqtyWXVNfrjL0vTRKA7BVfilyCSaJvTkaPCyUVsO3K1V4lDuFpG46SF9PK+oByE6mu/bthS4OWxH0AE4jK+26rv/IYVNOKbaPQy4/Iol5gma9LcQxIFqbsvmVNCratZRYa8CRonBCPnh6x5TOSm64ZGyYvrluHwb3vM1QDKp8M4GYOYaPbo4p21sffEgtyiVQYbVwuLtvziub1Tj48/Sv/AIAIaG4ydIkGcEbQMFRZOfVDJJJXtpAovkOq8U/hKW3ceXvLu+P82SgIwvVQOmMHm6UxBazqVYHPQm11orDdvXEqzEwJ874PObYmjNaCwmerkhtlN736NvfvAx3DNp1a84p9GUDDakMEH1mM1aU3ZIzPUTLawV/0uavbek5ubDbUWSLlPX4Os9YHp/XNvOy+n0sHlVkhUgtsZmS4YNY0/+l/9N4Y986/rbuPV8zqKm4prtj68MuhqlKWAls/WzwZPan5WYimOp71ZLGN9HEIk0bYBNL4Rl/PaKTqr4I/Ddu8Cnac4UlEP+7F2mFbkEfYA69P8GqXtEdBEcb9lMcGOCBqAv/xYP3CZvvlTiqNpNnrb3z9irrRwB0WEylmAxAGj8wGXbsyJofnscdXtqbb2mr0I2reKhmrwy+c8w/tGMwoUkDuROIYqx832qhdw0g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(23010399003)(36860700016)(18002099003)(56012099006)(11063799006)(3023799007)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Sc0s31d+kfAJRrxgzdnXk0KoO+35OKia0hVQq0kImIgqKg7CPX48Hxg0eh4ELodJnHM8emgahUanhoNfzT/H2kyLav2rPxsv9L4CFRevKgwmBPH8xid4EVzzLYzAhG0VYzKdSXX1B8yWDApulEFmpwOeFW7gpto5vCZoKTY2Ia/wIBH/NQdnQcKE70CyXRKxBlXoen6Ihz+AWDKdSHXLp39P9G9YV4ka2uycQuIpVwRHy50EZjCX3H1DyCiLFOKU2/Gy/AH3BZEyc0w2tUhjrlkRNioruKVrhxU14wpKOkG8vQd6cT8KJsFiFGCV32oGj8D45V6XeNJ6j3QhJ3cqjoN9RVfHQTehbIPNglbUATzojZvEFxMfGcB+cGVO3ETLZbdMgbmkjJ6I5qzBn6CSZc4Yfzs1KA7e+SSp3mDrWtCOzaAFJzIbO+/VV3Z0O/XH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 13:57:37.5448 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97064257-ef7e-49fa-1558-08defa0bffc5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9634
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

A gfx12 wave using dynamic VGPRs is launched with a fixed 16-VGPR block
and allocates the rest from a shared pool with s_alloc_vgpr.
 - the fixed block (WAVE_MIN_NUM_DVGPRS, 16 VGPRs) continues to go to
   the CWSR buffer;
 - the dynamic VGPRs go to the wave's scratch, which is durable per wave
   and therefore survives a restore that cannot reallocate them.

Persist wave's total VGPR count in a 4-byte per-lane
slot reserved at the front of the dynamic-VGPR scratch region, read back
through a VGPR lane since scratch is per lane.

Restore reallocates with s_alloc_vgpr once SCRATCH_BASE is available and
retries while the pool is full. If a context save becomes pending while
the allocation still cannot be satisfied, waiting would block the very
preemption that frees pool space, so the wave leaves its dynamic VGPRs
in scratch, completes the restore without resuming the shader, and
re-enters the save path at L_SAVE_BYPASS to be retried on a later
restore. Such a re-save must not overwrite the persisted count.
The live allocation has collapsed to the fixed block, and recording that would
lose the real count and strand the dynamic VGPRs in scratch. Signal the
condition in PC_HI bit 1.
---
 .../gpu/drm/amd/amdkfd/cwsr_trap_handler.h    | 356 +++++++++++-------
 .../amd/amdkfd/cwsr_trap_handler_gfx12.asm    | 217 ++++++++++-
 2 files changed, 432 insertions(+), 141 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
index 54fa76f374c9..259b2a4a1940 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
@@ -3644,7 +3644,7 @@ static const uint32_t cwsr_trap_gfx9_4_3_hex[] = {
 };
 
 static const uint32_t cwsr_trap_gfx12_hex[] = {
-	0xbfa00001, 0xbfa00239,
+	0xbfa00001, 0xbfa00273,
 	0xb0804009, 0xb8eef81a,
 	0xbf880000, 0xb980081a,
 	0x00000000, 0xb8f8f804,
@@ -3707,7 +3707,10 @@ static const uint32_t cwsr_trap_gfx12_hex[] = {
 	0x000c0000, 0x00000000,
 	0x7e000280, 0xbefe007a,
 	0xbeff007b, 0xb8fb0742,
-	0x847b997b, 0xb8fa3b05,
+	0x847b997b, 0xb8faf802,
+	0xbf0d9e7a, 0xbfa10003,
+	0xbefa00ff, 0x00000800,
+	0xbfa00007, 0xb8fa3b05,
 	0x807a817a, 0xbf0d997b,
 	0xbfa20002, 0x847a897a,
 	0xbfa00001, 0x847a8a7a,
@@ -3748,6 +3751,9 @@ static const uint32_t cwsr_trap_gfx12_hex[] = {
 	0xee0a4074, 0x010c0000,
 	0x00020000, 0xee0a4074,
 	0x018c0000, 0x00030000,
+	0xb8f0f802, 0xbf0d9e70,
+	0xbfa10003, 0xbef000ff,
+	0x00000800, 0xbfa00007,
 	0xb8f03b05, 0x80708170,
 	0xbf0d9973, 0xbfa20002,
 	0x84708970, 0xbfa00001,
@@ -3790,7 +3796,10 @@ static const uint32_t cwsr_trap_gfx12_hex[] = {
 	0xbeff0080, 0x80767074,
 	0x82778075, 0xee0a4076,
 	0x010c0000, 0x00000000,
-	0xbefe00c1, 0xb8f03b05,
+	0xbefe00c1, 0xb8f0f802,
+	0xbf0d9e70, 0xbfa10003,
+	0xbef000ff, 0x00000800,
+	0xbfa00007, 0xb8f03b05,
 	0x80708170, 0xbf0d9973,
 	0xbfa20002, 0x84708970,
 	0xbfa00001, 0x84708a70,
@@ -3859,9 +3868,12 @@ static const uint32_t cwsr_trap_gfx12_hex[] = {
 	0xbf06817d, 0xbfa20002,
 	0xbeff0080, 0xbfa00001,
 	0xbeff00c1, 0xb8fb4306,
-	0x8b7bc17b, 0xbfa10042,
+	0x8b7bc17b, 0xbfa10048,
 	0x8b7aff6d, 0x80000000,
-	0xbfa1003f, 0x847b897b,
+	0xbfa10045, 0x847b897b,
+	0xb8f0f802, 0xbf0d9e70,
+	0xbfa10003, 0xbef000ff,
+	0x00000800, 0xbfa00007,
 	0xb8f03b05, 0x80708170,
 	0xbf0d9973, 0xbfa20002,
 	0x84708970, 0xbfa00001,
@@ -3902,20 +3914,37 @@ static const uint32_t cwsr_trap_gfx12_hex[] = {
 	0xb8fb3b05, 0x807b817b,
 	0x847b827b, 0x857d9973,
 	0x8b7d817d, 0xbf06817d,
-	0xbfa2001b, 0xbefd0084,
-	0xbf0a7b7d, 0xbfa10032,
-	0x7e008700, 0x7e028701,
-	0x7e048702, 0x7e068703,
-	0x80767074, 0x82778075,
-	0xee0a4076, 0x000c0000,
-	0x00000000, 0xee0a4076,
-	0x008c0000, 0x00008000,
-	0xee0a4076, 0x010c0000,
-	0x00010000, 0xee0a4076,
-	0x018c0000, 0x00018000,
-	0x807d847d, 0x8070ff70,
-	0x00000200, 0xbf0a7b7d,
-	0xbfa2ffe9, 0xbfa0001a,
+	0xbfa2003d, 0xbefd0084,
+	0xb8faf802, 0xbf0a7b7d,
+	0xbfa10053, 0x7e008700,
+	0x7e028701, 0x7e048702,
+	0x7e068703, 0x80767074,
+	0x82778075, 0xee0a4076,
+	0x000c0000, 0x00000000,
+	0xee0a4076, 0x008c0000,
+	0x00008000, 0xee0a4076,
+	0x010c0000, 0x00010000,
+	0xee0a4076, 0x018c0000,
+	0x00018000, 0x807d847d,
+	0xbf0d9e7a, 0xbfa10002,
+	0xbf0a907d, 0xbfa10005,
+	0x8070ff70, 0x00000200,
+	0xbf0a7b7d, 0xbfa2ffe5,
+	0xbfa00037, 0xbf0d906d,
+	0xbfa20035, 0xbef00080,
+	0x7e00027b, 0xed068070,
+	0x00000000, 0x00000000,
+	0xbef00084, 0xbf097b7d,
+	0xbfa2002d, 0x7e008700,
+	0x7e028701, 0x7e048702,
+	0x7e068703, 0xed068070,
+	0x00000000, 0x00000000,
+	0xed068070, 0x00800000,
+	0x00000400, 0xed068070,
+	0x01000000, 0x00000800,
+	0xed068070, 0x01800000,
+	0x00000c00, 0x807d847d,
+	0x80709070, 0xbfa0ffeb,
 	0xbefd0084, 0xbf0a7b7d,
 	0xbfa10017, 0x7e008700,
 	0x7e028701, 0x7e048702,
@@ -3929,17 +3958,20 @@ static const uint32_t cwsr_trap_gfx12_hex[] = {
 	0x00030000, 0x807d847d,
 	0x8070ff70, 0x00000400,
 	0xbf0a7b7d, 0xbfa2ffe9,
-	0xbfa0014c, 0xbef4007e,
+	0xbfa001ab, 0xbef4007e,
 	0x8b75ff7f, 0x0000ffff,
 	0xbef1007f, 0xb8f20742,
 	0x84729972, 0x8b6eff7f,
-	0x04000000, 0xbfa10044,
+	0x04000000, 0xbfa1004a,
 	0xbefe00c1, 0x857d9972,
 	0x8b7d817d, 0xbf06817d,
 	0xbfa20002, 0xbeff0080,
 	0xbfa00001, 0xbeff00c1,
 	0xb8ef4306, 0x8b6fc16f,
-	0xbfa10039, 0x846f896f,
+	0xbfa1003f, 0x846f896f,
+	0xb8f8f802, 0xbf0d9e78,
+	0xbfa10003, 0xbef800ff,
+	0x00000800, 0xbfa00007,
 	0xb8f83b05, 0x80788178,
 	0xbf0d9972, 0xbfa20002,
 	0x84788978, 0xbfa00001,
@@ -3972,134 +4004,178 @@ static const uint32_t cwsr_trap_gfx12_hex[] = {
 	0x857d9972, 0x8b7d817d,
 	0xbf06817d, 0xbfa20002,
 	0xbeff0080, 0xbfa00001,
-	0xbeff00c1, 0xb8ef3b05,
-	0x806f816f, 0x846f826f,
-	0x857d9972, 0x8b7d817d,
-	0xbf06817d, 0xbfa2002c,
-	0xbeee0078, 0x8078ff78,
-	0x00000200, 0xbefd0084,
-	0x80767874, 0x82778075,
-	0xee0a0076, 0x000c0000,
-	0x00000000, 0xee0a0076,
-	0x000c0001, 0x00008000,
-	0xee0a0076, 0x000c0002,
-	0x00010000, 0xee0a0076,
-	0x000c0003, 0x00018000,
-	0xbf8a0000, 0x7e008500,
-	0x7e028501, 0x7e048502,
-	0x7e068503, 0x807d847d,
+	0xbeff00c1, 0xb8ecf802,
+	0xbf0d9e6c, 0xbfa10002,
+	0xbeef0090, 0xbfa00003,
+	0xb8ef3b05, 0x806f816f,
+	0x846f826f, 0x857d9972,
+	0x8b7d817d, 0xbf06817d,
+	0xbfa2002c, 0xbeee0078,
 	0x8078ff78, 0x00000200,
-	0xbf0a6f7d, 0xbfa2ffe8,
-	0x80766e74, 0x82778075,
-	0xee0a0076, 0x000c0000,
-	0x00000000, 0xee0a0076,
-	0x000c0001, 0x00008000,
-	0xee0a0076, 0x000c0002,
-	0x00010000, 0xee0a0076,
-	0x000c0003, 0x00018000,
-	0xbf8a0000, 0xbfa0002d,
-	0xbeee0078, 0x8078ff78,
-	0x00000400, 0xbefd0084,
-	0xbf0a6f7d, 0xbfa10018,
-	0x80767874, 0x82778075,
-	0xee0a0076, 0x000c0000,
-	0x00000000, 0xee0a0076,
-	0x000c0001, 0x00010000,
-	0xee0a0076, 0x000c0002,
-	0x00020000, 0xee0a0076,
-	0x000c0003, 0x00030000,
-	0xbf8a0000, 0x7e008500,
-	0x7e028501, 0x7e048502,
-	0x7e068503, 0x807d847d,
+	0xbefd0084, 0x80767874,
+	0x82778075, 0xee0a0076,
+	0x000c0000, 0x00000000,
+	0xee0a0076, 0x000c0001,
+	0x00008000, 0xee0a0076,
+	0x000c0002, 0x00010000,
+	0xee0a0076, 0x000c0003,
+	0x00018000, 0xbf8a0000,
+	0x7e008500, 0x7e028501,
+	0x7e048502, 0x7e068503,
+	0x807d847d, 0x8078ff78,
+	0x00000200, 0xbf0a6f7d,
+	0xbfa2ffe8, 0x80766e74,
+	0x82778075, 0xee0a0076,
+	0x000c0000, 0x00000000,
+	0xee0a0076, 0x000c0001,
+	0x00008000, 0xee0a0076,
+	0x000c0002, 0x00010000,
+	0xee0a0076, 0x000c0003,
+	0x00018000, 0xbf8a0000,
+	0xbfa0002d, 0xbeee0078,
 	0x8078ff78, 0x00000400,
-	0xbf0a6f7d, 0xbfa2ffe8,
-	0x80766e74, 0x82778075,
-	0xee0a0076, 0x000c0000,
-	0x00000000, 0xee0a0076,
-	0x000c0001, 0x00010000,
-	0xee0a0076, 0x000c0002,
-	0x00020000, 0xee0a0076,
-	0x000c0003, 0x00030000,
-	0xbf8a0000, 0xb8f83b05,
-	0x80788178, 0xbf0d9972,
-	0xbfa20002, 0x84788978,
-	0xbfa00001, 0x84788a78,
-	0x8078ff78, 0x00000200,
-	0x80f8ff78, 0x00000060,
-	0x80767874, 0x82778075,
-	0xbefd00ff, 0x0000006c,
-	0xf460403b, 0xf8000000,
-	0xbf8a0000, 0x80fd847d,
-	0xbf800000, 0xbe804300,
-	0xbe824302, 0x80f6a076,
-	0x82f78077, 0xf460603b,
+	0xbefd0084, 0xbf0a6f7d,
+	0xbfa10018, 0x80767874,
+	0x82778075, 0xee0a0076,
+	0x000c0000, 0x00000000,
+	0xee0a0076, 0x000c0001,
+	0x00010000, 0xee0a0076,
+	0x000c0002, 0x00020000,
+	0xee0a0076, 0x000c0003,
+	0x00030000, 0xbf8a0000,
+	0x7e008500, 0x7e028501,
+	0x7e048502, 0x7e068503,
+	0x807d847d, 0x8078ff78,
+	0x00000400, 0xbf0a6f7d,
+	0xbfa2ffe8, 0x80766e74,
+	0x82778075, 0xee0a0076,
+	0x000c0000, 0x00000000,
+	0xee0a0076, 0x000c0001,
+	0x00010000, 0xee0a0076,
+	0x000c0002, 0x00020000,
+	0xee0a0076, 0x000c0003,
+	0x00030000, 0xbf8a0000,
+	0xb8f8f802, 0xbf0d9e78,
+	0xbfa10003, 0xbef800ff,
+	0x00000800, 0xbfa00007,
+	0xb8f83b05, 0x80788178,
+	0xbf0d9972, 0xbfa20002,
+	0x84788978, 0xbfa00001,
+	0x84788a78, 0x8078ff78,
+	0x00000200, 0x80f8ff78,
+	0x00000060, 0x80767874,
+	0x82778075, 0xbefd00ff,
+	0x0000006c, 0xf460403b,
 	0xf8000000, 0xbf8a0000,
-	0x80fd887d, 0xbf800000,
+	0x80fd847d, 0xbf800000,
 	0xbe804300, 0xbe824302,
-	0xbe844304, 0xbe864306,
-	0x80f6c076, 0x82f78077,
-	0xf460803b, 0xf8000000,
-	0xbf8a0000, 0x80fd907d,
+	0x80f6a076, 0x82f78077,
+	0xf460603b, 0xf8000000,
+	0xbf8a0000, 0x80fd887d,
 	0xbf800000, 0xbe804300,
 	0xbe824302, 0xbe844304,
-	0xbe864306, 0xbe884308,
-	0xbe8a430a, 0xbe8c430c,
-	0xbe8e430e, 0xbf06807d,
-	0xbfa1ffef, 0xb980f801,
-	0x00000000, 0xb8f83b05,
-	0x80788178, 0xbf0d9972,
-	0xbfa20002, 0x84788978,
-	0xbfa00001, 0x84788a78,
-	0x8078ff78, 0x00000200,
-	0x80767874, 0x82778075,
-	0xbeff0071, 0xf4601bfb,
-	0xf8000000, 0xf4601b3b,
-	0xf8000004, 0xf4601b7b,
-	0xf8000008, 0xf4601c3b,
-	0xf800000c, 0xf4601c7b,
-	0xf8000010, 0xf4601ebb,
-	0xf8000014, 0xf4601efb,
-	0xf8000018, 0xf4601e7b,
-	0xf800001c, 0xf4601cfb,
-	0xf8000020, 0xf4601bbb,
-	0xf8000024, 0xbf8a0000,
-	0xb96ef814, 0xf4601bbb,
-	0xf8000028, 0xbf8a0000,
-	0xb96ef815, 0xf4601bbb,
-	0xf800002c, 0xbf8a0000,
-	0xb96ef812, 0xf4601bbb,
-	0xf8000030, 0xbf8a0000,
-	0xb96ef813, 0x8b6eff7f,
-	0x04000000, 0xbfa1000b,
-	0xf4601bbb, 0xf8000038,
-	0xbf8a0000, 0xbf0d806e,
-	0xbfa10006, 0x856e906e,
-	0x8b6e6e6e, 0xbfa10003,
-	0xbe804ec1, 0x816ec16e,
-	0xbfa0fffb, 0xbefd006f,
-	0xbefe0070, 0xbeff0071,
-	0xb97b2011, 0x857b867b,
-	0xb97b0191, 0x857b827b,
-	0xb97bba11, 0xb973f801,
-	0xb8ee3b05, 0x806e816e,
+	0xbe864306, 0x80f6c076,
+	0x82f78077, 0xf460803b,
+	0xf8000000, 0xbf8a0000,
+	0x80fd907d, 0xbf800000,
+	0xbe804300, 0xbe824302,
+	0xbe844304, 0xbe864306,
+	0xbe884308, 0xbe8a430a,
+	0xbe8c430c, 0xbe8e430e,
+	0xbf06807d, 0xbfa1ffef,
+	0xb980f801, 0x00000000,
+	0xb8f8f802, 0xbf0d9e78,
+	0xbfa10003, 0xbef800ff,
+	0x00000800, 0xbfa00007,
+	0xb8f83b05, 0x80788178,
 	0xbf0d9972, 0xbfa20002,
-	0x846e896e, 0xbfa00001,
-	0x846e8a6e, 0x806eff6e,
-	0x00000240, 0x806e746e,
-	0x826f8075, 0xf4605c37,
-	0xf8000010, 0xf4605d37,
-	0xf8000020, 0xf4601e77,
-	0xf8000034, 0xbf8a0000,
-	0x8b6dff6d, 0x0000ffff,
-	0x8bfe7e7e, 0x8bea6a6a,
-	0x936eff77, 0x0002001a,
-	0xb96ef81a, 0xb97af804,
+	0x84788978, 0xbfa00001,
+	0x84788a78, 0x8078ff78,
+	0x00000200, 0x80767874,
+	0x82778075, 0xbeff0071,
+	0xf4601bfb, 0xf8000000,
+	0xf4601b3b, 0xf8000004,
+	0xf4601b7b, 0xf8000008,
+	0xf4601c3b, 0xf800000c,
+	0xf4601c7b, 0xf8000010,
+	0xf4601ebb, 0xf8000014,
+	0xf4601efb, 0xf8000018,
+	0xf4601e7b, 0xf800001c,
+	0xf4601cfb, 0xf8000020,
+	0xf4601bbb, 0xf8000024,
+	0xbf8a0000, 0xb96ef814,
+	0xf4601bbb, 0xf8000028,
+	0xbf8a0000, 0xb96ef815,
+	0xf4601bbb, 0xf800002c,
+	0xbf8a0000, 0xb96ef812,
+	0xf4601bbb, 0xf8000030,
+	0xbf8a0000, 0xb96ef813,
+	0x8b6eff7f, 0x04000000,
+	0xbfa1000b, 0xf4601bbb,
+	0xf8000038, 0xbf8a0000,
+	0xbf0d806e, 0xbfa10006,
+	0x856e906e, 0x8b6e6e6e,
+	0xbfa10003, 0xbe804ec1,
+	0x816ec16e, 0xbfa0fffb,
+	0xbef80080, 0xb8f6f802,
+	0xbf0d9e76, 0xbfa10038,
+	0xbefe00c1, 0xbef80080,
+	0xed050078, 0x00000000,
+	0x00000000, 0xbfc00000,
+	0xd7600077, 0x00010100,
+	0xbef60077, 0xbe805376,
+	0xbfa20006, 0xb8f6f811,
+	0x8b76a076, 0xbf830010,
+	0xbfa1fff9, 0xbef80081,
+	0xbfa0001a, 0xbefe00c1,
+	0xbefd0090, 0xbef80084,
+	0xbf0a777d, 0xbfa10015,
+	0xed050078, 0x00000000,
+	0x00000000, 0xed050078,
+	0x00000001, 0x00000400,
+	0xed050078, 0x00000002,
+	0x00000800, 0xed050078,
+	0x00000003, 0x00000c00,
+	0xbfc00000, 0x7e008500,
+	0x7e028501, 0x7e048502,
+	0x7e068503, 0x807d847d,
+	0x80789078, 0xbf0a777d,
+	0xbfa2ffeb, 0xee0a0074,
+	0x000c0000, 0x00000000,
+	0xee0a0074, 0x000c0001,
+	0x00008000, 0xee0a0074,
+	0x000c0002, 0x00010000,
+	0xee0a0074, 0x000c0003,
+	0x00018000, 0xbf8a0000,
+	0xbefd006f, 0xbefe0070,
+	0xbeff0071, 0xb97b2011,
+	0x857b867b, 0xb97b0191,
+	0x857b827b, 0xb97bba11,
+	0xb973f801, 0xb8eef802,
+	0xbf0d9e6e, 0xbfa10003,
+	0xbeee00ff, 0x00000800,
+	0xbfa00007, 0xb8ee3b05,
+	0x806e816e, 0xbf0d9972,
+	0xbfa20002, 0x846e896e,
+	0xbfa00001, 0x846e8a6e,
+	0x806eff6e, 0x00000240,
+	0x806e746e, 0x826f8075,
+	0xf4605c37, 0xf8000010,
+	0xf4605d37, 0xf8000020,
+	0xf4601e77, 0xf8000034,
+	0xbf8a0000, 0x8b6dff6d,
+	0x0000ffff, 0x8bfe7e7e,
+	0x8bea6a6a, 0xbf068178,
+	0xbfa20007, 0x936eff77,
+	0x0002001a, 0xb96ef81a,
+	0xb97af804, 0xbe804ec2,
+	0xbf94fffe, 0xbe804a6c,
+	0xbef8007a, 0x8c6dff6d,
+	0x00010000, 0xbfa0fc47,
 	0xbe804ec2, 0xbf94fffe,
-	0xbe804a6c, 0xbe804ec2,
-	0xbf94fffe, 0xbfb10000,
+	0xbfb10000, 0xbf9f0000,
 	0xbf9f0000, 0xbf9f0000,
 	0xbf9f0000, 0xbf9f0000,
-	0xbf9f0000, 0x00000000,
 };
 
 static const uint32_t cwsr_trap_gfx9_5_0_hex[] = {
diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
index d38ff404277b..355b5175f141 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
@@ -38,6 +38,7 @@
 #define CLUSTER_BARRIER_SERIALIZE_WORKAROUND (ASIC_FAMILY == CHIP_GC_12_0_3)
 #define RELAXED_SCHEDULING_IN_TRAP (ASIC_FAMILY == CHIP_GFX12)
 #define HAVE_INSTRUCTION_FIXUP (ASIC_FAMILY == CHIP_GC_12_0_3)
+#define HAVE_DYNAMIC_VGPRS (ASIC_FAMILY == CHIP_GFX12)
 
 #define SINGLE_STEP_MISSED_WORKAROUND 1	//workaround for lost TRAP_AFTER_INST exception when SAVECTX raised
 #define HAVE_VALU_SGPR_HAZARD (ASIC_FAMILY == CHIP_GFX12)
@@ -60,16 +61,20 @@ var SQ_WAVE_STATE_PRIV_POISON_ERR_SHIFT		= 15
 var SQ_WAVE_STATUS_WAVE64_SHIFT			= 29
 var SQ_WAVE_STATUS_WAVE64_SIZE			= 1
 var SQ_WAVE_STATUS_NO_VGPRS_SHIFT		= 24
+var SQ_WAVE_STATUS_DYN_VGPR_EN_SHIFT		= 30
 var SQ_WAVE_STATUS_IN_WG_SHIFT			= 11
 var SQ_WAVE_STATE_PRIV_ALWAYS_CLEAR_MASK	= SQ_WAVE_STATE_PRIV_SYS_PRIO_MASK|SQ_WAVE_STATE_PRIV_POISON_ERR_MASK
 var S_SAVE_PC_HI_TRAP_ID_MASK			= 0xF0000000
 
 var SQ_WAVE_LDS_ALLOC_LDS_SIZE_SHIFT		= 12
 var SQ_WAVE_LDS_ALLOC_LDS_SIZE_SIZE		= 9
+var SQ_WAVE_GPR_ALLOC_VGPR_SIZE_MASK		= 0xFF000
 var SQ_WAVE_GPR_ALLOC_VGPR_SIZE_SIZE		= 8
 var SQ_WAVE_GPR_ALLOC_VGPR_SIZE_SHIFT		= 12
 
 #if ASIC_FAMILY < CHIP_GC_12_0_3
+var SQ_WAVE_LDS_ALLOC_VGPR_SHARED_SIZE_SHIFT	= 24
+var SQ_WAVE_LDS_ALLOC_VGPR_SHARED_SIZE_SIZE	= 4
 var SQ_WAVE_LDS_ALLOC_GRANULARITY		= 9
 #else
 var SQ_WAVE_LDS_ALLOC_GRANULARITY		= 10
@@ -185,6 +190,34 @@ var S_RESTORE_SPI_INIT_FIRST_WAVE_MASK		= 0x04000000
 var S_RESTORE_SPI_INIT_FIRST_WAVE_SHIFT		= 26
 var S_WAVE_SIZE					= 25
 
+#if HAVE_DYNAMIC_VGPRS
+var WAVE_MIN_NUM_DVGPRS				= 16	// Defined by SQ_DYN_VGPR.block_size.  Assume default value for now.
+
+// The total VGPR count of a DVGPR wave is persisted in the wave's own scratch, in a small
+// region reserved at the front of the dynamic-VGPR backing store (ahead of the dynamic
+// VGPRs themselves).
+//
+// NOTE: the driver-side dynamic-VGPR scratch allocation must include these reserved bytes
+// per lane in addition to the space for the dynamic VGPRs.
+var S_SAVE_DVGPR_COUNT_SCRATCH_OFFSET		= 0	// count location within the reserved region
+var S_SAVE_DVGPR_SCRATCH_RESERVE		= 4	// bytes reserved per lane at scratch offset 0
+
+// DVGPR restore-allocation bypass.  If the restore-time s_alloc_vgpr fails while a
+// context-save is pending, the wave cannot restore its dynamic VGPRs.  Rather than
+// dropping them (corruption) or spinning forever, the wave re-enters the save path
+// (L_SAVE_BYPASS) so it is re-saved and retried on a later restore when pool space frees.
+//
+// On such a re-save the live allocation has collapsed to the minimum block, so the save
+// must NOT overwrite the durable scratch count (that would lose the real count and strand
+// the dynamic VGPRs still sitting in scratch).  A freshly dispatched wave never passes
+// through restore, so a "this is a bypass re-save" marker cannot live in scratch (its first
+// save would read it uninitialized); it is instead carried for the single trap execution in
+// a free PC_HI bit.  On GFX12 the PC occupies PC_HI[15:0] (48-bit address) and there are no
+// banked-VGPR bits, so PC_HI[30:16] are free; the bit is masked off before PC_HI is written
+// to memory, so it is never persisted.
+var S_SAVE_PC_HI_DVGPR_BYPASS_SHIFT		= 16
+var S_SAVE_PC_HI_DVGPR_BYPASS_MASK		= 0x00010000
+#endif
 var s_restore_spi_init_lo			= exec_lo
 var s_restore_spi_init_hi			= exec_hi
 var s_restore_mem_offset			= ttmp12
@@ -196,6 +229,8 @@ var s_restore_mode				= ttmp7
 var s_restore_flat_scratch			= s_restore_tmp
 var s_restore_pc_lo				= ttmp0
 var s_restore_pc_hi				= ttmp1
+// Scratch register, valid only before L_RESTORE_HWREG loads the saved PC.
+var s_restore_tmp2				= s_restore_pc_lo
 var s_restore_exec_lo				= ttmp4
 var s_restore_exec_hi				= ttmp5
 var s_restore_state_priv			= ttmp14
@@ -210,6 +245,20 @@ var s_restore_ttmps_lo				= s_restore_tmp
 var s_restore_ttmps_hi				= s_restore_alloc_size
 var s_restore_spi_init_hi_save			= s_restore_exec_hi
 
+#if HAVE_DYNAMIC_VGPRS
+// Temporaries for the dynamic-VGPR restore, which runs after L_RESTORE_HWREG (scratch is not
+// addressable before SCRATCH_BASE is restored).
+var s_restore_dvgpr_tmp				= s_restore_addr_lo
+var s_restore_dvgpr_count			= s_restore_addr_hi
+
+// s_restore_mem_offset (ttmp12) is dead as a scratch offset once the dynamic-VGPR restore
+// finishes, so it is reused to carry the rfe-vs-resave decision to the end of restore:
+// 0 == resume the shader normally, 1 == bypass to the save path (re-save).  The dynamic-VGPR
+// restore loop only ever leaves the register 0 or >= S_SAVE_DVGPR_SCRATCH_RESERVE (its
+// starting offset, which it only increments), so 1 is an unambiguous marker.
+var s_restore_dvgpr_bypass			= s_restore_mem_offset
+#endif
+
 #if SAVE_TTMPS_IN_SGPR_BLOCK
 var TTMP_SR_OFFSET_FROM_HWREG			= -0x40
 #else
@@ -409,6 +458,15 @@ L_SAVE:
 	s_endpgm
 L_HAVE_VGPRS:
 	s_and_b32	s_save_pc_hi, s_save_pc_hi, ADDRESS_HI32_MASK
+#if HAVE_DYNAMIC_VGPRS
+// Re-entry point for the DVGPR restore-allocation bypass (see L_DYN_VGPR_ALLOC_LOOP).
+// On entry from restore s_save_state_priv has been populated from s_restore_state_priv and
+// the bypass marker bit (S_SAVE_PC_HI_DVGPR_BYPASS_MASK) has been set in PC_HI -- this entry
+// skips the PC_HI mask at L_HAVE_VGPRS, so the marker survives to the dynamic-VGPR save,
+// where it suppresses the durable scratch count write (the count and the dynamic VGPRs are
+// already intact in scratch from the previous save).
+L_SAVE_BYPASS:
+#endif
 	s_mov_b32	s_save_tmp, 0
 	s_setreg_b32	hwreg(HW_REG_WAVE_EXCP_FLAG_PRIV, SQ_WAVE_EXCP_FLAG_PRIV_SAVE_CONTEXT_SHIFT, 1), s_save_tmp	//clear saveCtx bit
 
@@ -798,6 +856,9 @@ L_SAVE_VGPR_NORMAL:
 
 	// VGPR store using dw burst
 	s_mov_b32	m0, 0x4							//VGPR initial index value =4
+#if HAVE_DYNAMIC_VGPRS
+	s_getreg_b32	s_save_tmp, hwreg(HW_REG_WAVE_STATUS)			//save to check DYN_VGPR_EN later
+#endif
 	s_cmp_lt_u32	m0, s_save_alloc_size
 	s_cbranch_scc0	L_SAVE_VGPR_END
 
@@ -815,12 +876,51 @@ L_SAVE_VGPR_W32_LOOP:
 	global_store_addtid_b32	v3, [s_save_addr_lo, s_save_addr_hi] scope:SCOPE_SYS offset:128*3
 
 	s_add_u32	m0, m0, 4						//next vgpr index
+#if HAVE_DYNAMIC_VGPRS
+	s_bitcmp1_b32	s_save_tmp, SQ_WAVE_STATUS_DYN_VGPR_EN_SHIFT
+	s_cbranch_scc0	L_SAVE_FIXED_VGPR_END_LOOP_CHECK
+	s_cmp_lt_u32	m0, WAVE_MIN_NUM_DVGPRS
+	s_cbranch_scc0	L_SAVE_DYN_VGPR_SAVE
+
+L_SAVE_FIXED_VGPR_END_LOOP_CHECK:
+#endif
 	s_add_u32	s_save_mem_offset, s_save_mem_offset, 128*4		//every buffer_store_dword does 128 bytes
 	s_cmp_lt_u32	m0, s_save_alloc_size					//scc = (m0 < s_save_alloc_size) ? 1 : 0
 	s_cbranch_scc1	L_SAVE_VGPR_W32_LOOP					//VGPR save is complete?
-
 	s_branch	L_SAVE_VGPR_END
 
+#if HAVE_DYNAMIC_VGPRS
+L_SAVE_DYN_VGPR_SAVE:
+	s_bitcmp1_b32	s_save_pc_hi, S_SAVE_PC_HI_DVGPR_BYPASS_SHIFT
+	s_cbranch_scc1	L_SAVE_VGPR_END
+
+	// Persist the total VGPR count in the reserved scratch slot (durable per wave).
+	// s_save_alloc_size holds the live total VGPR count (HW_REG_WAVE_GPR_ALLOC).
+	s_mov_b32	s_save_mem_offset, S_SAVE_DVGPR_COUNT_SCRATCH_OFFSET
+	v_mov_b32	v0, s_save_alloc_size
+	scratch_store_b32 off, v0, s_save_mem_offset offset: 0
+
+	// m0 already holds WAVE_MIN_NUM_DVGPRS: the fixed-VGPR loop steps by 4 and branches here
+	// on the first index at or past the block boundary (must match RESTORE).
+	s_mov_b32	s_save_mem_offset, S_SAVE_DVGPR_SCRATCH_RESERVE
+
+L_SAVE_DYN_VGPR_SAVE_LOOP:
+	s_cmp_ge_u32	m0, s_save_alloc_size
+	s_cbranch_scc1	L_SAVE_VGPR_END
+
+	v_movrels_b32	v0, v0							//v0 = v[0+m0]
+	v_movrels_b32	v1, v1							//v1 = v[1+m0]
+	v_movrels_b32	v2, v2							//v2 = v[2+m0]
+	v_movrels_b32	v3, v3							//v3 = v[3+m0]
+	scratch_store_b32 off, v0, s_save_mem_offset offset: 0
+	scratch_store_b32 off, v1, s_save_mem_offset offset: 4
+	scratch_store_b32 off, v2, s_save_mem_offset offset: 8
+	scratch_store_b32 off, v3, s_save_mem_offset offset: 12
+	s_add_u32	m0, m0, 4
+	s_add_u32	s_save_mem_offset, s_save_mem_offset, 16
+	s_branch	L_SAVE_DYN_VGPR_SAVE_LOOP
+#endif
+
 L_SAVE_VGPR_WAVE64:
 	// VGPR store using dw burst
 	s_mov_b32	m0, 0x4							//VGPR initial index value =4
@@ -934,9 +1034,23 @@ L_RESTORE_VGPR:
 L_ENABLE_RESTORE_VGPR_EXEC_HI:
 	s_mov_b32	exec_hi, 0xFFFFFFFF
 L_RESTORE_VGPR_NORMAL:
+#if HAVE_DYNAMIC_VGPRS
+	// For DVGPR waves this loop restores only the fixed VGPR block, so cap the loop bound at
+	// WAVE_MIN_NUM_DVGPRS rather than taking the live GPR_ALLOC size.  The dynamic VGPRs are
+	// restored later, from scratch, once SCRATCH_BASE has been restored (it is not yet
+	// restored at this point) and their count is known.
+	s_getreg_b32	s_restore_tmp2, hwreg(HW_REG_WAVE_STATUS)
+	s_bitcmp1_b32	s_restore_tmp2, SQ_WAVE_STATUS_DYN_VGPR_EN_SHIFT
+	s_cbranch_scc0	L_RESTORE_ALLOC_SIZE_FROM_HW  // Not DVGPR, use HW register
+	s_mov_b32	s_restore_alloc_size, WAVE_MIN_NUM_DVGPRS
+	s_branch	L_RESTORE_ALLOC_SIZE_DONE
+
+L_RESTORE_ALLOC_SIZE_FROM_HW:
+#endif
 	s_getreg_b32	s_restore_alloc_size, hwreg(HW_REG_WAVE_GPR_ALLOC,SQ_WAVE_GPR_ALLOC_VGPR_SIZE_SHIFT,SQ_WAVE_GPR_ALLOC_VGPR_SIZE_SIZE)
 	s_add_u32	s_restore_alloc_size, s_restore_alloc_size, 1
 	s_lshl_b32	s_restore_alloc_size, s_restore_alloc_size, 2		//Number of VGPRs = (vgpr_size + 1) * 4    (non-zero value)
+L_RESTORE_ALLOC_SIZE_DONE:
 	//determine it is wave32 or wave64
 	s_lshr_b32	m0, s_restore_size, S_WAVE_SIZE
 	s_and_b32	m0, m0, 1
@@ -1181,6 +1295,74 @@ L_SKIP_CLUSTER_BARRIER_RESTORE:
 	s_setreg_b32	hwreg(HW_REG_WAVE_SCHED_MODE), s_restore_tmp
 #endif
 
+#if HAVE_DYNAMIC_VGPRS
+	// Default: resume normally after restore (see s_restore_dvgpr_bypass).
+	s_mov_b32	s_restore_dvgpr_bypass, 0
+
+	// Check if dynamic VGPR is enabled
+	s_getreg_b32	s_restore_dvgpr_tmp, hwreg(HW_REG_WAVE_STATUS)
+	s_bitcmp1_b32	s_restore_dvgpr_tmp, SQ_WAVE_STATUS_DYN_VGPR_EN_SHIFT
+	s_cbranch_scc0	L_SKIP_DYN_VGPR_RESTORE
+
+	// Total VGPR count persisted in the reserved scratch slot at preempt (see
+	// L_SAVE_DYN_VGPR_SAVE).
+	s_mov_b32	exec_lo, 0xFFFFFFFF
+	s_mov_b32	s_restore_mem_offset, S_SAVE_DVGPR_COUNT_SCRATCH_OFFSET
+	scratch_load_b32 v0, off, s_restore_mem_offset offset: 0
+	s_wait_loadcnt	0
+	v_readlane_b32	s_restore_dvgpr_count, v0, 0
+
+L_DYN_VGPR_ALLOC_LOOP:
+	// s_alloc_vgpr modifies its operand, so give it a fresh copy of the count each attempt.
+	s_mov_b32	s_restore_dvgpr_tmp, s_restore_dvgpr_count
+	s_alloc_vgpr	s_restore_dvgpr_tmp
+	s_cbranch_scc1	L_DYN_VGPR_RESTORE			// allocation succeeded
+	// Allocation failed.  Keep retrying unless a context-save is pending.
+	s_getreg_b32	s_restore_dvgpr_tmp, hwreg(HW_REG_WAVE_EXCP_FLAG_PRIV)
+	s_and_b32	s_restore_dvgpr_tmp, s_restore_dvgpr_tmp, SQ_WAVE_EXCP_FLAG_PRIV_SAVE_CONTEXT_MASK
+	s_sleep		0x10
+	s_cbranch_scc0	L_DYN_VGPR_ALLOC_LOOP			// no save pending -> retry
+	// A context-save is pending and there is still no room: bypass to the save path so
+	// this wave is re-saved and retried on a later restore. The re-save does write 
+	// the fixed VGPRs back from registers, so v[0:3] must be put back first.
+	s_mov_b32	s_restore_dvgpr_bypass, 1		// re-save instead of rfe
+	s_branch	L_DYN_VGPR_RELOAD_FIXED
+
+L_DYN_VGPR_RESTORE:
+	// Enable all lanes for the v_movreld instructions below.  This path is wave32 only, so
+	// exec_lo is the entire mask.
+	s_mov_b32	exec_lo, 0xFFFFFFFF
+	// Start at the first dynamic VGPR (must match SAVE).
+	s_mov_b32	m0, WAVE_MIN_NUM_DVGPRS
+	s_mov_b32	s_restore_mem_offset, S_SAVE_DVGPR_SCRATCH_RESERVE
+	s_cmp_lt_u32	m0, s_restore_dvgpr_count
+	s_cbranch_scc0	L_DYN_VGPR_RELOAD_FIXED
+
+L_DYN_VGPR_RESTORE_LOOP:
+	scratch_load_b32 v0, off, s_restore_mem_offset offset: 0
+	scratch_load_b32 v1, off, s_restore_mem_offset offset: 4
+	scratch_load_b32 v2, off, s_restore_mem_offset offset: 8
+	scratch_load_b32 v3, off, s_restore_mem_offset offset: 12
+	s_wait_loadcnt	0
+	v_movreld_b32	v0, v0
+	v_movreld_b32	v1, v1
+	v_movreld_b32	v2, v2
+	v_movreld_b32	v3, v3
+	s_add_u32	m0, m0, 4
+	s_add_u32	s_restore_mem_offset, s_restore_mem_offset, 16
+	s_cmp_lt_u32	m0, s_restore_dvgpr_count
+	s_cbranch_scc1	L_DYN_VGPR_RESTORE_LOOP
+
+	// Put back the v[0:3] borrowed above as scratch-load staging.  The fixed VGPR block starts
+	// at CWSR offset 0, DVGPR implies wave32, hence the 128-byte stride.
+L_DYN_VGPR_RELOAD_FIXED:
+	global_load_addtid_b32	v0, [s_restore_base_addr_lo, s_restore_base_addr_hi] scope:SCOPE_SYS
+	global_load_addtid_b32	v1, [s_restore_base_addr_lo, s_restore_base_addr_hi] scope:SCOPE_SYS offset:128
+	global_load_addtid_b32	v2, [s_restore_base_addr_lo, s_restore_base_addr_hi] scope:SCOPE_SYS offset:128*2
+	global_load_addtid_b32	v3, [s_restore_base_addr_lo, s_restore_base_addr_hi] scope:SCOPE_SYS offset:128*3
+	s_wait_idle
+L_SKIP_DYN_VGPR_RESTORE:
+#endif
 	s_mov_b32	m0, s_restore_m0
 	s_mov_b32	exec_lo, s_restore_exec_lo
 	s_mov_b32	exec_hi, s_restore_exec_hi
@@ -1220,6 +1402,14 @@ L_SKIP_CLUSTER_BARRIER_RESTORE:
 	s_and_b64	exec, exec, exec					// Restore STATUS.EXECZ, not writable by s_setreg_b32
 	s_and_b64	vcc, vcc, vcc						// Restore STATUS.VCCZ, not writable by s_setreg_b32
 
+#if HAVE_DYNAMIC_VGPRS
+	// DVGPR restore-allocation bypass: if dynamic VGPRs could not be allocated while a
+	// context-save was pending (flagged in s_restore_dvgpr_bypass == 1 by
+	// L_DYN_VGPR_ALLOC_LOOP), re-enter the save path instead of resuming the shader.
+	s_cmp_eq_u32	s_restore_dvgpr_bypass, 1
+	s_cbranch_scc1	L_DYN_VGPR_BYPASS_RESAVE
+#endif
+
 #if RELAXED_SCHEDULING_IN_TRAP
 	// Assume relaxed scheduling mode after this point.
 	restore_sched_mode(s_restore_tmp)
@@ -1239,6 +1429,16 @@ L_SKIP_CLUSTER_BARRIER_RESTORE:
 
 	s_rfe_b64	s_restore_pc_lo						//Return to the main shader program and resume execution
 
+#if HAVE_DYNAMIC_VGPRS
+L_DYN_VGPR_BYPASS_RESAVE:
+	// Out of line so the resume path above ends at s_rfe_b64 with SCC untouched.  Hand the
+	// save path the state_priv it would otherwise have read at trap entry, and set the
+	// transient PC_HI bypass marker so the save skips the durable scratch count write.
+	s_mov_b32	s_save_state_priv, s_restore_state_priv
+	s_or_b32	s_save_pc_hi, s_save_pc_hi, S_SAVE_PC_HI_DVGPR_BYPASS_MASK
+	s_branch	L_SAVE_BYPASS
+#endif
+
 L_END_PGM:
 	// Make sure that no wave of the group/cluster can exit the trap handler
 	// before the group/cluster barrier state is saved.
@@ -1271,6 +1471,18 @@ function write_12sgpr_to_v2(s)
 end
 
 function get_vgpr_size_bytes(s_vgpr_size_byte, s_size)
+#if HAVE_DYNAMIC_VGPRS
+	// DVGPR waves (wave32 only) keep only the fixed VGPR block (WAVE_MIN_NUM_DVGPRS) in
+	// the CWSR buffer; the dynamic VGPRs live in scratch.  Every CWSR region placed after
+	// the VGPR block (SGPR/HWREG/LDS/TTMP) is sized off the VGPR block, so centralize the
+	// fixed-block adjustment here to keep every offset consistent.
+	s_getreg_b32	s_vgpr_size_byte, hwreg(HW_REG_WAVE_STATUS)
+	s_bitcmp1_b32	s_vgpr_size_byte, SQ_WAVE_STATUS_DYN_VGPR_EN_SHIFT
+	s_cbranch_scc0	L_GET_VGPR_SIZE_NORMAL
+	s_mov_b32	s_vgpr_size_byte, (WAVE_MIN_NUM_DVGPRS * 128)		//16 fixed VGPRs, wave32
+	s_branch	L_GET_VGPR_SIZE_DONE
+L_GET_VGPR_SIZE_NORMAL:
+#endif
 	s_getreg_b32	s_vgpr_size_byte, hwreg(HW_REG_WAVE_GPR_ALLOC,SQ_WAVE_GPR_ALLOC_VGPR_SIZE_SHIFT,SQ_WAVE_GPR_ALLOC_VGPR_SIZE_SIZE)
 	s_add_u32	s_vgpr_size_byte, s_vgpr_size_byte, 1
 	s_bitcmp1_b32	s_size, S_WAVE_SIZE
@@ -1280,6 +1492,9 @@ function get_vgpr_size_bytes(s_vgpr_size_byte, s_size)
 L_ENABLE_SHIFT_W64:
 	s_lshl_b32	s_vgpr_size_byte, s_vgpr_size_byte, (2+8)		//Number of VGPRs = (vgpr_size + 1) * 4 * 64 * 4   (non-zero value)
 L_SHIFT_DONE:
+#if HAVE_DYNAMIC_VGPRS
+L_GET_VGPR_SIZE_DONE:
+#endif
 end
 
 function get_sgpr_size_bytes
-- 
2.43.0

