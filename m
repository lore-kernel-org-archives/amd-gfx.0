Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 441EDCEACCE
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Nov 2025 20:49:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E383610EB17;
	Fri, 14 Nov 2025 20:49:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZtZ4FajO";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010062.outbound.protection.outlook.com
 [52.101.193.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8B3210EB17
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Nov 2025 20:49:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GO6GINOsKAatioSPv7GWkFXQaJUKvgc7GHGTYFobr4RBgIf0QiNHAnB0W9J3NjhFz5MUaPcBTU8zYTrxX0Zc3aqEgH9hUXeiee08TaD+TKDETWTKXNuE/uWAFjHnT11W4VJYEHR+FbuhD93QmLNgCmgOzwYTCyadI6kyvfsXIUKCPeOVzct6+j9raG88x1gsTONvhfROcZnboMhCRg8f9CPGfysicSH6K6G8zQyXTR9uIPxB61QkzwD2uE7cUkxHuM5Lg8Ivv7Axdg9AvnaC5g+9/InsBqG3EiuDTf46QY/VsiwEtwUimJDZrz3UmnMPy/uRj1SQmFAcOR8CuooOfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lt+EXKumGssOiMSSqf7pu95i1D4MGmHcoREKKd6O3Jg=;
 b=A4vPbDXDyp8T/lXmQcenFc3NMXf1lcNL4rIUazu9MLIa2LrLpsTlrq+k4GEoUFZwEo/PXUC6iigoFUfOypmtxnDfYsISjUfonlxA+55E2ZuhyJm04nLQ0K2TZ4jbW8Kwmp728qR2LYIxaueLvQJvfBKO0anr+isnGyZ+PiontVim0mOprK29z5CjgCv7IV9OhTB6Ff/WNIftZuzUj9BBwQOyh8zpoPsSjxi3VPnydEC0y++LDZoZvxVnz4FTAf1SXCznpLjNEXUQFKROOzHmn9yfMgRcbfoBWnue/qvZb5Mn8fyOICkNvDMteI5SaP4rRfkOQi+y9ev/E9jJcu4eNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lt+EXKumGssOiMSSqf7pu95i1D4MGmHcoREKKd6O3Jg=;
 b=ZtZ4FajOkEXyNUQjY4JN1WcW3Fniv5wrSVv1CAWFrQyYVTalFXo9L6u9CEnrvmoBEsOnp/khweO9xdvDRUuMZHwePhflQa4SrbqK0QMAKu+qHnt660qY4o2B+h0Ea+7KUowmvKNln6bG0an+5tW3KNIJZB5s5dcfyZ4D1UhMT1s=
Received: from MN2PR01CA0045.prod.exchangelabs.com (2603:10b6:208:23f::14) by
 IA1PR12MB6579.namprd12.prod.outlook.com (2603:10b6:208:3a1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 20:48:56 +0000
Received: from BN3PEPF0000B373.namprd21.prod.outlook.com
 (2603:10b6:208:23f:cafe::e5) by MN2PR01CA0045.outlook.office365.com
 (2603:10b6:208:23f::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Fri,
 14 Nov 2025 20:47:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B373.mail.protection.outlook.com (10.167.243.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.0 via Frontend Transport; Fri, 14 Nov 2025 20:48:55 +0000
Received: from jc-d.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 14 Nov
 2025 12:48:54 -0800
From: Jay Cornwall <jay.cornwall@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jay Cornwall <jay.cornwall@amd.com>, Lancelot Six <lancelot.six@amd.com>
Subject: [PATCH v3] drm/amdkfd: Trap handler support for expert scheduling mode
Date: Fri, 14 Nov 2025 14:48:40 -0600
Message-ID: <20251114204840.857161-1-jay.cornwall@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B373:EE_|IA1PR12MB6579:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c2501dc-79d3-4f4e-d03e-08de23bf3a73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8MoFBrrVkmWeYTcqewHg8hpotg5kuEsabMRmMjM1k4ixLQ80FL8YrMQ3fygz?=
 =?us-ascii?Q?DT3nULfyzKntFmrusqpkHs8FxB2S3FTvhHYdSj6W5jyLBwft2+mqwkdIlUXX?=
 =?us-ascii?Q?ngrLy3N+8YBRcqqceUkiK2J+DspOXCkNvvVLAdkQa/ylPR40OfBPgekR5L8f?=
 =?us-ascii?Q?rrPhBxrgyxBVbM4vPZL6x9gTPykFaEbBHgot+mBtPPc7TL6ycfcNSHf3KAKf?=
 =?us-ascii?Q?L2N6Xrufqtowzt6o3GlTiwBHzM/aK3JcflLqLS+/1yLCi7cq+fq/1esVYl49?=
 =?us-ascii?Q?JEbleRGDNblgapLq2+YxVwkRHxY0MKlGfgagjd7kE/hWyQ5gw0RFwmcvCaaq?=
 =?us-ascii?Q?FNMNU8gm7859uvQNaKyz/jWo5Il5s1yLZWF24Hj/2vq/HeMZqIRPhmYUrZXF?=
 =?us-ascii?Q?99aTRDZsrwNWEDfWzEkoi34G1yqcoTo5FigHXqKisgAzzI/WTv2HTaWVr5PP?=
 =?us-ascii?Q?Pk8UHZ9W4MwkkZHUjemSDo6e/HfMn0k9wDIKqd42KgTc157AtDQeNhBflkvJ?=
 =?us-ascii?Q?cOXiVgJ8qL7XHKGlBTIryB2GTVO7qGqI3pjs4+k0yLatJc5UBjG22JvL6s2M?=
 =?us-ascii?Q?5qqFKpu3Mc/Uquwu67zDJgRDRIhP4LKXIb+04oy49LLrRXbrVC9fjOSdPa7W?=
 =?us-ascii?Q?SuVy8cFYsxVS5VjnufHkhF0hFs13z/FEzageA6O8OBvBlKrfHmoztJqw3kv6?=
 =?us-ascii?Q?Livo0fBFZnsRBfZQyzysD0KWgGYhIKCR5GDXp7fn1Y4z3OpCJBLsAsD+IbgJ?=
 =?us-ascii?Q?mBwmfh+Ix4NahLctCge4uLBX5zXytSwjwk2YKJBjSsykMl6BATANtkYF8k6d?=
 =?us-ascii?Q?se1GLtPepPl/Kb7XdRwlATRVdKFHXsZpsPSEOtO04DNUJJ74lGjYBXytwu9a?=
 =?us-ascii?Q?s2CIIavgwPNUM6/pi34hRbBISafPrqHQ9V4qlCEbjTdcI4xeQhGM34QIG6ab?=
 =?us-ascii?Q?Ps7n9lg+PIwkL2KZ52PXBQzgAoYu4cQL/4PrYlK/LN5IbLhkiYsIfqYarMYo?=
 =?us-ascii?Q?WShjfMEnrloXnp69fShnlf/atVogp0fste/Q5ySFWeHzfh88oErIJaANztYT?=
 =?us-ascii?Q?2Op12F/kIiNIVS5wfYKjdrSkeMqvnXPhmv/bcHfm7BT96XxrsryyDHOxxhJw?=
 =?us-ascii?Q?rti0FDq+8DyR622JuinI/Sf/XTNWkvPeX4iEYrltFmeK0zXEeG42khGiXj/Y?=
 =?us-ascii?Q?p3dvOeNvKG2Ne7lF7Rx3DnLGK7mqHhLoiFsqdGy2PHSqpE++j2mJqm2LHpf0?=
 =?us-ascii?Q?/yW/puHgRGqAafWFXp6ei4I1V0pSFHQ42Etr45gCP1BIOQnGfVJVBEagx53F?=
 =?us-ascii?Q?cLywOJ4mei20u29NeHCgLDeeTYalk4/hjDJpdcAW63/Fb+Rz2E0Q5dig9Gcl?=
 =?us-ascii?Q?a8cun9GSK0aA1oUzCSfiRNnIfgpV7JDQdsfarJut1KbTQtQBTcWKpTJi74Dz?=
 =?us-ascii?Q?vtKeGJQPN/RD1tpXKrRCg/s2/OS1yj1IQAlzSaHbE/O1AgGs10dXtQd+97zZ?=
 =?us-ascii?Q?60YBoOcdYR7ulAwuYfiCbtAkIzwcHz+ob3d0z3az9uB7Kg9sFI8VgnyEGJcB?=
 =?us-ascii?Q?Qwf4U/wCKdD5JFu/Mt0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 20:48:55.9099 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c2501dc-79d3-4f4e-d03e-08de23bf3a73
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B373.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6579
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

The trap may be entered with dependency checking disabled.
Wait for dependency counters and save/restore scheduling mode.

v2:

Use ttmp1 instead of ttmp11. ttmp11 is not zero-initialized.
While the trap handler does zero this field before use, a user-mode
second-level trap handler could not rely on this being zero when
using an older kernel mode driver.

v3:

Use ttmp11 primarily but copy to ttmp1 before jumping to the
second level trap handler. ttmp1 is inspectable by a debugger.
Unexpected bits in the unused space may regress existing software.

Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
Cc: Lancelot Six <lancelot.six@amd.com>
---
 .../gpu/drm/amd/amdkfd/cwsr_trap_handler.h    | 62 +++++++++++--------
 .../amd/amdkfd/cwsr_trap_handler_gfx12.asm    | 37 +++++++++++
 2 files changed, 73 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
index 0320163b6e74..f98c735b2905 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
@@ -3644,14 +3644,18 @@ static const uint32_t cwsr_trap_gfx9_4_3_hex[] = {
 };
 
 static const uint32_t cwsr_trap_gfx12_hex[] = {
-	0xbfa00001, 0xbfa002a2,
-	0xb0804009, 0xb8f8f804,
+	0xbfa00001, 0xbfa002b2,
+	0xb0804009, 0xb8eef81a,
+	0xbf880000, 0xb980081a,
+	0x00000000, 0xb8f8f804,
+	0x9177ff77, 0x0c000000,
+	0x846e9a6e, 0x8c776e77,
 	0x9178ff78, 0x00008c00,
 	0xb8fbf811, 0x8b6eff78,
 	0x00004000, 0xbfa10008,
 	0x8b6eff7b, 0x00000080,
 	0xbfa20018, 0x8b6ea07b,
-	0xbfa20042, 0xbf830010,
+	0xbfa2004a, 0xbf830010,
 	0xb8fbf811, 0xbfa0fffb,
 	0x8b6eff7b, 0x00000bd0,
 	0xbfa20010, 0xb8eef812,
@@ -3662,28 +3666,32 @@ static const uint32_t cwsr_trap_gfx12_hex[] = {
 	0xf0000000, 0xbfa20005,
 	0x8b6fff6f, 0x00000200,
 	0xbfa20002, 0x8b6ea07b,
-	0xbfa2002c, 0xbefa4d82,
+	0xbfa20034, 0xbefa4d82,
 	0xbf8a0000, 0x84fa887a,
 	0xbf0d8f7b, 0xbfa10002,
 	0x8c7bff7b, 0xffff0000,
-	0xf4601bbd, 0xf8000010,
-	0xbf8a0000, 0x846e976e,
-	0x9177ff77, 0x00800000,
-	0x8c776e77, 0xf4603bbd,
-	0xf8000000, 0xbf8a0000,
-	0xf4603ebd, 0xf8000008,
-	0xbf8a0000, 0x8bee6e6e,
-	0xbfa10001, 0xbe80486e,
-	0x8b6eff6d, 0xf0000000,
-	0xbfa20009, 0xb8eef811,
-	0x8b6eff6e, 0x00000080,
-	0xbfa20007, 0x8c78ff78,
-	0x00004000, 0x80ec886c,
-	0x82ed806d, 0xbfa00002,
-	0x806c846c, 0x826d806d,
-	0x8b6dff6d, 0x0000ffff,
-	0x8bfe7e7e, 0x8bea6a6a,
-	0x85788978, 0xb9783244,
+	0x8b6eff77, 0x0c000000,
+	0x916dff6d, 0x0c000000,
+	0x8c6d6e6d, 0xf4601bbd,
+	0xf8000010, 0xbf8a0000,
+	0x846e976e, 0x9177ff77,
+	0x00800000, 0x8c776e77,
+	0xf4603bbd, 0xf8000000,
+	0xbf8a0000, 0xf4603ebd,
+	0xf8000008, 0xbf8a0000,
+	0x8bee6e6e, 0xbfa10001,
+	0xbe80486e, 0x8b6eff6d,
+	0xf0000000, 0xbfa20009,
+	0xb8eef811, 0x8b6eff6e,
+	0x00000080, 0xbfa20007,
+	0x8c78ff78, 0x00004000,
+	0x80ec886c, 0x82ed806d,
+	0xbfa00002, 0x806c846c,
+	0x826d806d, 0x8b6dff6d,
+	0x0000ffff, 0x8bfe7e7e,
+	0x8bea6a6a, 0x85788978,
+	0x936eff77, 0x0002001a,
+	0xb96ef81a, 0xb9783244,
 	0xbe804a6c, 0xb8faf802,
 	0xbf0d987a, 0xbfa10001,
 	0xbfb00000, 0x8b6dff6d,
@@ -3981,7 +3989,7 @@ static const uint32_t cwsr_trap_gfx12_hex[] = {
 	0x008ce800, 0x00000000,
 	0x807d817d, 0x8070ff70,
 	0x00000080, 0xbf0a7b7d,
-	0xbfa2fff7, 0xbfa0016e,
+	0xbfa2fff7, 0xbfa00171,
 	0xbef4007e, 0x8b75ff7f,
 	0x0000ffff, 0x8c75ff75,
 	0x00040000, 0xbef60080,
@@ -4163,12 +4171,14 @@ static const uint32_t cwsr_trap_gfx12_hex[] = {
 	0xf8000074, 0xbf8a0000,
 	0x8b6dff6d, 0x0000ffff,
 	0x8bfe7e7e, 0x8bea6a6a,
-	0xb97af804, 0xbe804ec2,
-	0xbf94fffe, 0xbe804a6c,
+	0x936eff77, 0x0002001a,
+	0xb96ef81a, 0xb97af804,
 	0xbe804ec2, 0xbf94fffe,
-	0xbfb10000, 0xbf9f0000,
+	0xbe804a6c, 0xbe804ec2,
+	0xbf94fffe, 0xbfb10000,
 	0xbf9f0000, 0xbf9f0000,
 	0xbf9f0000, 0xbf9f0000,
+	0xbf9f0000, 0x00000000,
 };
 
 static const uint32_t cwsr_trap_gfx9_5_0_hex[] = {
diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
index 5a1a1b1f897f..07999b4649de 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
@@ -78,9 +78,16 @@ var SQ_WAVE_EXCP_FLAG_PRIV_RESTORE_PART_2_SHIFT	= SQ_WAVE_EXCP_FLAG_PRIV_ILLEGAL
 var SQ_WAVE_EXCP_FLAG_PRIV_RESTORE_PART_2_SIZE	= SQ_WAVE_EXCP_FLAG_PRIV_HOST_TRAP_SHIFT - SQ_WAVE_EXCP_FLAG_PRIV_ILLEGAL_INST_SHIFT
 var SQ_WAVE_EXCP_FLAG_PRIV_RESTORE_PART_3_SHIFT	= SQ_WAVE_EXCP_FLAG_PRIV_WAVE_START_SHIFT
 var SQ_WAVE_EXCP_FLAG_PRIV_RESTORE_PART_3_SIZE	= 32 - SQ_WAVE_EXCP_FLAG_PRIV_RESTORE_PART_3_SHIFT
+
+var SQ_WAVE_SCHED_MODE_DEP_MODE_SHIFT		= 0
+var SQ_WAVE_SCHED_MODE_DEP_MODE_SIZE		= 2
+
 var BARRIER_STATE_SIGNAL_OFFSET			= 16
 var BARRIER_STATE_VALID_OFFSET			= 0
 
+var TTMP11_SCHED_MODE_SHIFT			= 26
+var TTMP11_SCHED_MODE_SIZE			= 2
+var TTMP11_SCHED_MODE_MASK			= 0xC000000
 var TTMP11_DEBUG_TRAP_ENABLED_SHIFT		= 23
 var TTMP11_DEBUG_TRAP_ENABLED_MASK		= 0x800000
 
@@ -160,8 +167,19 @@ L_JUMP_TO_RESTORE:
 	s_branch	L_RESTORE
 
 L_SKIP_RESTORE:
+	// Assume most relaxed scheduling mode is set. Save and revert to normal mode.
+	s_getreg_b32	ttmp2, hwreg(HW_REG_WAVE_SCHED_MODE)
+	s_wait_alu	0
+	s_setreg_imm32_b32	hwreg(HW_REG_WAVE_SCHED_MODE, \
+		SQ_WAVE_SCHED_MODE_DEP_MODE_SHIFT, SQ_WAVE_SCHED_MODE_DEP_MODE_SIZE), 0
+
 	s_getreg_b32	s_save_state_priv, hwreg(HW_REG_WAVE_STATE_PRIV)	//save STATUS since we will change SCC
 
+	// Save SCHED_MODE[1:0] into ttmp11[27:26].
+	s_andn2_b32	ttmp11, ttmp11, TTMP11_SCHED_MODE_MASK
+	s_lshl_b32	ttmp2, ttmp2, TTMP11_SCHED_MODE_SHIFT
+	s_or_b32	ttmp11, ttmp11, ttmp2
+
 	// Clear SPI_PRIO: do not save with elevated priority.
 	// Clear ECC_ERR: prevents SQC store and triggers FATAL_HALT if setreg'd.
 	s_andn2_b32	s_save_state_priv, s_save_state_priv, SQ_WAVE_STATE_PRIV_ALWAYS_CLEAR_MASK
@@ -238,6 +256,13 @@ L_FETCH_2ND_TRAP:
 	s_cbranch_scc0	L_NO_SIGN_EXTEND_TMA
 	s_or_b32	ttmp15, ttmp15, 0xFFFF0000
 L_NO_SIGN_EXTEND_TMA:
+#if ASIC_FAMILY == CHIP_GFX12
+	// Move SCHED_MODE[1:0] from ttmp11 to unused bits in ttmp1[27:26] (return PC_HI).
+	// The second-level trap will restore from ttmp1 for backwards compatibility.
+	s_and_b32	ttmp2, ttmp11, TTMP11_SCHED_MODE_MASK
+	s_andn2_b32	ttmp1, ttmp1, TTMP11_SCHED_MODE_MASK
+	s_or_b32	ttmp1, ttmp1, ttmp2
+#endif
 
 	s_load_dword    ttmp2, [ttmp14, ttmp15], 0x10 scope:SCOPE_SYS		// debug trap enabled flag
 	s_wait_idle
@@ -287,6 +312,10 @@ L_EXIT_TRAP:
 	// STATE_PRIV.BARRIER_COMPLETE may have changed since we read it.
 	// Only restore fields which the trap handler changes.
 	s_lshr_b32	s_save_state_priv, s_save_state_priv, SQ_WAVE_STATE_PRIV_SCC_SHIFT
+
+	// Assume relaxed scheduling mode after this point.
+	restore_sched_mode(ttmp2)
+
 	s_setreg_b32	hwreg(HW_REG_WAVE_STATE_PRIV, SQ_WAVE_STATE_PRIV_SCC_SHIFT, \
 		SQ_WAVE_STATE_PRIV_POISON_ERR_SHIFT - SQ_WAVE_STATE_PRIV_SCC_SHIFT + 1), s_save_state_priv
 
@@ -1043,6 +1072,9 @@ L_SKIP_BARRIER_RESTORE:
 	s_and_b64	exec, exec, exec					// Restore STATUS.EXECZ, not writable by s_setreg_b32
 	s_and_b64	vcc, vcc, vcc						// Restore STATUS.VCCZ, not writable by s_setreg_b32
 
+	// Assume relaxed scheduling mode after this point.
+	restore_sched_mode(s_restore_tmp)
+
 	s_setreg_b32	hwreg(HW_REG_WAVE_STATE_PRIV), s_restore_state_priv	// SCC is included, which is changed by previous salu
 
 	// Make barrier and LDS state visible to all waves in the group.
@@ -1134,3 +1166,8 @@ function valu_sgpr_hazard
 	end
 #endif
 end
+
+function restore_sched_mode(s_tmp)
+	s_bfe_u32	s_tmp, ttmp11, (TTMP11_SCHED_MODE_SHIFT | (TTMP11_SCHED_MODE_SIZE << 0x10))
+	s_setreg_b32	hwreg(HW_REG_WAVE_SCHED_MODE), s_tmp
+end
-- 
2.34.1

