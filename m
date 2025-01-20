Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E0E2C02181
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jan 2025 19:40:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9690110E47B;
	Mon, 20 Jan 2025 19:40:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RzIRwEvl";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::62d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C94A210E47C
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jan 2025 19:40:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XZMVrZ5/ItaxN4ZWt6ZT/Xu9rr5Zwwq5saoXUBKMJ881/QGOPmaM4O1emkM4YGkFqShvuyzT/AYZJ1aXaCmWtmwc+g94JVETq8wGU1dvJSGVtWR9Pvb9O8IoWOgvNX9HIpoDgXe3QdwGjSr0/U2lAUVwyS/DTJkYuMShO2kxO3qYLfrBvlj3+GIoKv6zLrkUGkkv9kz7TM9xklHZfeFjAoZJlf7a8y1vv14jlHRhmz/Z0UNvQU/jSWaRcw9gU0s8cHZwVqELtEGXV3AdnCWAqVcsbIDrlBb3d0M1CX0sou1QSmYYuNKdaAcik2AkF2jDDMI0jrUk5kzsjoVsO4PeKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XsWwrvMq0ad5pio0boB6eB77SVZfVM2pEHN9NXmwF08=;
 b=iZtCYnFXZW5E5CKqN0BRH1RaflMGPRz+fjbGK0sQgrBYaFwp/iIQ4uMrgsBFpVnOwzo8rSWv7ZQOjWK8gNVWvgk5VyjAJRn6kZpZ4tkXDnE3136TKIxn4v4qzJJdrfLG0PTc36A2MV9EtUggaVFc9UBh5h1vbf0PgAU4+j2msoPs9WZM5ktTqxIae6BakpB0xRdM4Nidh98WpGpwj7t2tytZf5YC+5kZ/k92+BXj5hKqGTG30umS1UmlkffZ6U127Zx+hvun1z3LglA6fUXzT0njWTsXQNgPyP6VdwgJZpYn5hF5I7uOi/S9g2pFmuV0xbbuDt7dfoAbOhHRfzVn8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XsWwrvMq0ad5pio0boB6eB77SVZfVM2pEHN9NXmwF08=;
 b=RzIRwEvlxx/yKpWw3PNkpFV/b9YSfIT+FZEf6SSOlJHqPXJ8J72AxSilk5jhIFhyB9D4b9SQ0kzO4Le6U2Kl7h9Q13kn28mkX6QTNupZ+eTdVxPbZYgUd4Izc2TwjCUZMduxibNVE5NNRXLj3BsFJr+cJ9hpuA1yx3ou2LVJr3c=
Received: from DM6PR04CA0025.namprd04.prod.outlook.com (2603:10b6:5:334::30)
 by SJ2PR12MB8783.namprd12.prod.outlook.com (2603:10b6:a03:4d0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Mon, 20 Jan
 2025 19:40:35 +0000
Received: from DS2PEPF0000343B.namprd02.prod.outlook.com
 (2603:10b6:5:334:cafe::35) by DM6PR04CA0025.outlook.office365.com
 (2603:10b6:5:334::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.21 via Frontend Transport; Mon,
 20 Jan 2025 19:40:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343B.mail.protection.outlook.com (10.167.18.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Mon, 20 Jan 2025 19:40:34 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 20 Jan
 2025 13:40:33 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Saurabh Verma
 <saurabh.verma@amd.com>
Subject: [PATCH] drm/amdgpu: update and cleanup PM4 headers
Date: Mon, 20 Jan 2025 14:40:17 -0500
Message-ID: <20250120194017.201218-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343B:EE_|SJ2PR12MB8783:EE_
X-MS-Office365-Filtering-Correlation-Id: c3bf265b-616d-4957-ca96-08dd398a4ecb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HJXqMdkwhtb3f2TzcpQhST5asp3fLMiSNmh9NJxnhb2lliKCEtkWDtP3jyQG?=
 =?us-ascii?Q?0XCNr56ljanzC72PgdLd+Y2ZzL/8X6cnJWgg6lLCoGxDmmHoVfuMh4PMImhX?=
 =?us-ascii?Q?tgBwvJQAahJ2MeLmorpif2EEPGxobxccL6x6DLqzh9/BRG35p3zwE+6FRgM5?=
 =?us-ascii?Q?6pPwvNnkD8+9v1cpOOK8pqjw0cNKlHdTV+di0YROcHAYIwvT4y3W154njtSC?=
 =?us-ascii?Q?giq1fuhBfe8y6hcmJiMqVKeSFbkK7CmVpL35AI8KWD6QcPWQI+iPA7eSlfAJ?=
 =?us-ascii?Q?SA8ba1HHelukD78ZUq5Scyj3mtwrsdKqXEzE+NQ4FWhasolZzH7/owJJK1Oj?=
 =?us-ascii?Q?P0G7zLq1ySSSZJaXDr+oehfVQf/D9At7/SLyFKKCfF3S1o50N7HqOtAYTa6J?=
 =?us-ascii?Q?mvD7pvMIoPMFNgKYy8wEmgaGOJvl9FUKgjObpyYQxAkXReNhrjYdSAHKzVH0?=
 =?us-ascii?Q?tXiVCi6LcTeBUS9YbgyGjpHNnwuq1rs7M0pOCeAaSvJi/CH/1lRNBlG5O5FO?=
 =?us-ascii?Q?T9lxO/u+B8Szy1THB4MwEuwNSW2hyNZhBmfQIGzIcUYeHiN1GSfadzHtUoK0?=
 =?us-ascii?Q?7yW+RbPcX0mdlGlxvcME4WkuNHXsrr9g/yfLSp7vLsdgAz96yRFTJFmsXYQm?=
 =?us-ascii?Q?SwGI+bH3M0kvLwi6C1crkXr8gH8JftsBBgXaMYUysDR+J+ybI4B1KTXRZAV4?=
 =?us-ascii?Q?HYrbAMN1ubWYWhzLoQl/y9ucLotbAkBUtNq/OO4NUBk1k8OBQmFDpbZwxthk?=
 =?us-ascii?Q?acggNjW9dkssvQxq4sjGHfw+lhVK+5B6acK7QSSj8mxaNVoLLFb1SnFpIGQl?=
 =?us-ascii?Q?SSIaR1tamx02WFk2HqSbb7CAT6eu79jRYQbK6uRUxF5ao+WSlQ/9mz/NFNh3?=
 =?us-ascii?Q?UqX9sQxGkX5CfvfQ13FuCHciiKdv/MRyRwCcMuK8D5cdV3gsDxSIX5X0yQ2k?=
 =?us-ascii?Q?Oi3zRopwo9mXhReh6SThiSB66g3kn5TDo6A7Jm2k/EGdBP5UDT0OalFUsAfd?=
 =?us-ascii?Q?I1OD2hfDVZA9ocKLezUPyEJcP5dUh5w/v4qRlZoGybVDjBAzzX/4eAIwrt8q?=
 =?us-ascii?Q?VYHcT8Ftb1C8de6HQ6jnNRux9PB9qha2NPQ07+UTF/oBGNzHit3XIgxX6s6q?=
 =?us-ascii?Q?PkL1xh5TyzGxDxOnI2zlxUWCbcNhD5XAE+f3mUqarUb0k6eLjINfysY9fUHu?=
 =?us-ascii?Q?JKcMS2ndz+nxiCl1VkGuIEKA67rhak6+o1aiYEOm+tmQO9OsdeabQpmMU8Fv?=
 =?us-ascii?Q?h8Ka1Ki7u1tULPWscNrV7pTB3JzdD84y+MP/1UWqyFcSu0UEubSR4c3fYogJ?=
 =?us-ascii?Q?RAFag1aTV53KJEEFTNfE+kvWt9qZIL07T7+Tm+pwaOaJU6BVfDXgco3Um7eu?=
 =?us-ascii?Q?ouiYPe8hsBWKG/gLyo/DbkA2yXdJ8ctbDG5DQFRW/75bVv9XR8kXM6OTpG5b?=
 =?us-ascii?Q?pezyaHdqBE9tI4yzr0t1p0iA8e5/bQsk6+q9DycFDkCNFZDENG2jzQ04EeB0?=
 =?us-ascii?Q?QMaveGLxQMuoGgE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 19:40:34.5789 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3bf265b-616d-4957-ca96-08dd398a4ecb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8783
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

Consolidate PM4 definitions.  Most of these were previously
only defined in UMDs.  Add them here as well and sync with
latest packets.  Also no need to include soc15d.h on gfx10+.

Suggested-by: Saurabh Verma <saurabh.verma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c |   1 -
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c |   1 -
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c |   1 -
 drivers/gpu/drm/amd/amdgpu/nvd.h       | 208 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/soc15d.h    | 139 +++++++++++++++++
 5 files changed, 347 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 070b4d6bd9c59..63de78060d679 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -40,7 +40,6 @@
 #include "ivsrcid/gfx/irqsrcs_gfx_10_1.h"
 
 #include "soc15.h"
-#include "soc15d.h"
 #include "soc15_common.h"
 #include "clearstate_gfx10.h"
 #include "v10_structs.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 52c571b134fd0..89d17750af04d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -42,7 +42,6 @@
 #include "ivsrcid/gfx/irqsrcs_gfx_11_0_0.h"
 
 #include "soc15.h"
-#include "soc15d.h"
 #include "clearstate_gfx11.h"
 #include "v11_structs.h"
 #include "gfx_v11_0.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 2a71998800414..e425b87078d7d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -40,7 +40,6 @@
 #include "ivsrcid/gfx/irqsrcs_gfx_11_0_0.h"
 
 #include "soc15.h"
-#include "soc15d.h"
 #include "clearstate_gfx12.h"
 #include "v12_structs.h"
 #include "gfx_v12_0.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/nvd.h b/drivers/gpu/drm/amd/amdgpu/nvd.h
index 631dafb922990..56f1bfac0b208 100644
--- a/drivers/gpu/drm/amd/amdgpu/nvd.h
+++ b/drivers/gpu/drm/amd/amdgpu/nvd.h
@@ -64,6 +64,24 @@
 #define	PACKET3_INDIRECT_BUFFER_CNST_END		0x19
 #define	PACKET3_ATOMIC_GDS				0x1D
 #define	PACKET3_ATOMIC_MEM				0x1E
+#define 	PACKET3_ATOMIC_MEM__ATOMIC(x) ((((unsigned)(x)) & 0x7F) << 0)
+#define 	PACKET3_ATOMIC_MEM__COMMAND(x) ((((unsigned)(x)) & 0xF) << 8)
+#define 	PACKET3_ATOMIC_MEM__CACHE_POLICY(x) ((((unsigned)(x)) & 0x3) << 25)
+#define 	PACKET3_ATOMIC_MEM__ADDR_LO(x) (((unsigned)(x)))
+#define 	PACKET3_ATOMIC_MEM__ADDR_HI(x) (((unsigned)(x)))
+#define 	PACKET3_ATOMIC_MEM__SRC_DATA_LO(x) (((unsigned)(x)))
+#define 	PACKET3_ATOMIC_MEM__SRC_DATA_HI(x) (((unsigned)(x)))
+#define 	PACKET3_ATOMIC_MEM__CMP_DATA_LO(x) (((unsigned)(x)))
+#define 	PACKET3_ATOMIC_MEM__CMP_DATA_HI(x) (((unsigned)(x)))
+#define 	PACKET3_ATOMIC_MEM__LOOP_INTERVAL(x) ((((unsigned)(x)) & 0x1FFF) << 0)
+#define 	PACKET3_ATOMIC_MEM__COMMAND__SINGLE_PASS_ATOMIC 0
+#define 	PACKET3_ATOMIC_MEM__COMMAND__LOOP_UNTIL_COMPARE_SATISFIED 1
+#define 	PACKET3_ATOMIC_MEM__COMMAND__WAIT_FOR_WRITE_CONFIRMATION 2
+#define 	PACKET3_ATOMIC_MEM__COMMAND__SEND_AND_CONTINUE 3
+#define 	PACKET3_ATOMIC_MEM__CACHE_POLICY__LRU 0
+#define 	PACKET3_ATOMIC_MEM__CACHE_POLICY__STREAM 1
+#define 	PACKET3_ATOMIC_MEM__CACHE_POLICY__NOA 2
+#define 	PACKET3_ATOMIC_MEM__CACHE_POLICY__BYPASS 3
 #define	PACKET3_OCCLUSION_QUERY				0x1F
 #define	PACKET3_SET_PREDICATION				0x20
 #define	PACKET3_REG_RMW					0x21
@@ -105,6 +123,38 @@
 		 * 1 - pfp
 		 * 2 - ce
 		 */
+#define 	PACKET3_WRITE_DATA__DST_SEL(x) ((((unsigned)(x)) & 0xF) << 8)
+#define 	PACKET3_WRITE_DATA__ADDR_INCR(x) ((((unsigned)(x)) & 0x1) << 16)
+#define 	PACKET3_WRITE_DATA__WR_CONFIRM(x) ((((unsigned)(x)) & 0x1) << 20)
+#define 	PACKET3_WRITE_DATA__CACHE_POLICY(x) ((((unsigned)(x)) & 0x3) << 25)
+#define 	PACKET3_WRITE_DATA__DST_MMREG_ADDR(x) ((((unsigned)(x)) & 0x3FFFF) << 0)
+#define 	PACKET3_WRITE_DATA__DST_GDS_ADDR(x) ((((unsigned)(x)) & 0xFFFF) << 0)
+#define 	PACKET3_WRITE_DATA__DST_MEM_ADDR_LO(x) ((((unsigned)(x)) & 0x3FFFFFFF) << 2)
+#define 	PACKET3_WRITE_DATA__DST_MEM_ADDR_HI(x) ((unsigned)(x))
+#define 	PACKET3_WRITE_DATA__MODE(x) ((((unsigned)(x)) & 0x1) << 21)
+#define 	PACKET3_WRITE_DATA__AID_ID(x) ((((unsigned)(x)) & 0x3) << 22)
+#define 	PACKET3_WRITE_DATA__TEMPORAL(x) ((((unsigned)(x)) & 0x3) << 24)
+#define 	PACKET3_WRITE_DATA__DST_MMREG_ADDR_LO(x) ((unsigned)(x))
+#define 	PACKET3_WRITE_DATA__DST_MMREG_ADDR_HI(x) ((((unsigned)(x)) & 0xFF) << 0)
+#define 	PACKET3_WRITE_DATA__DST_SEL__MEM_MAPPED_REGISTER 0
+#define 	PACKET3_WRITE_DATA__DST_SEL__TC_L2 2
+#define 	PACKET3_WRITE_DATA__DST_SEL__GDS 3
+#define 	PACKET3_WRITE_DATA__DST_SEL__MEMORY 5
+#define 	PACKET3_WRITE_DATA__DST_SEL__MEMORY_MAPPED_ADC_PERSISTENT_STATE 6
+#define 	PACKET3_WRITE_DATA__ADDR_INCR__INCREMENT_ADDRESS 0
+#define 	PACKET3_WRITE_DATA__ADDR_INCR__DO_NOT_INCREMENT_ADDRESS 1
+#define 	PACKET3_WRITE_DATA__WR_CONFIRM__DO_NOT_WAIT_FOR_WRITE_CONFIRMATION 0
+#define 	PACKET3_WRITE_DATA__WR_CONFIRM__WAIT_FOR_WRITE_CONFIRMATION 1
+#define 	PACKET3_WRITE_DATA__MODE__PF_VF_DISABLED 0
+#define 	PACKET3_WRITE_DATA__MODE__PF_VF_ENABLED 1
+#define 	PACKET3_WRITE_DATA__TEMPORAL__RT 0
+#define 	PACKET3_WRITE_DATA__TEMPORAL__NT 1
+#define 	PACKET3_WRITE_DATA__TEMPORAL__HT 2
+#define 	PACKET3_WRITE_DATA__TEMPORAL__LU 3
+#define 	PACKET3_WRITE_DATA__CACHE_POLICY__LRU 0
+#define 	PACKET3_WRITE_DATA__CACHE_POLICY__STREAM 1
+#define 	PACKET3_WRITE_DATA__CACHE_POLICY__NOA 2
+#define 	PACKET3_WRITE_DATA__CACHE_POLICY__BYPASS 3
 #define	PACKET3_DRAW_INDEX_INDIRECT_MULTI		0x38
 #define	PACKET3_MEM_SEMAPHORE				0x39
 #              define PACKET3_SEM_USE_MAILBOX       (0x1 << 16)
@@ -135,6 +185,42 @@
 		/* 0 - me
 		 * 1 - pfp
 		 */
+#define		PACKET3_WAIT_REG_MEM__FUNCTION(x) ((((unsigned)(x)) & 0x7) << 0)
+#define		PACKET3_WAIT_REG_MEM__MEM_SPACE(x) ((((unsigned)(x)) & 0x3) << 4)
+#define		PACKET3_WAIT_REG_MEM__OPERATION(x) ((((unsigned)(x)) & 0x3) << 6)
+#define		PACKET3_WAIT_REG_MEM__MES_INTR_PIPE(x) ((((unsigned)(x)) & 0x3) << 22)
+#define		PACKET3_WAIT_REG_MEM__MES_ACTION(x) ((((unsigned)(x)) & 0x1) << 24)
+#define		PACKET3_WAIT_REG_MEM__CACHE_POLICY(x) ((((unsigned)(x)) & 0x3) << 25)
+#define		PACKET3_WAIT_REG_MEM__TEMPORAL(x) ((((unsigned)(x)) & 0x3) << 25)
+#define		PACKET3_WAIT_REG_MEM__MEM_POLL_ADDR_LO(x) ((((unsigned)(x)) & 0x3FFFFFFF) << 2)
+#define		PACKET3_WAIT_REG_MEM__REG_POLL_ADDR(x) ((((unsigned)(x)) & 0X3FFFF) << 0)
+#define		PACKET3_WAIT_REG_MEM__REG_WRITE_ADDR1(x) ((((unsigned)(x)) & 0X3FFFF) << 0)
+#define		PACKET3_WAIT_REG_MEM__MEM_POLL_ADDR_HI(x) ((unsigned)(x))
+#define		PACKET3_WAIT_REG_MEM__REG_WRITE_ADDR2(x) ((((unsigned)(x)) & 0x3FFFF) << 0)
+#define		PACKET3_WAIT_REG_MEM__REFERENCE(x) ((unsigned)(x))
+#define		PACKET3_WAIT_REG_MEM__MASK(x) ((unsigned)(x))
+#define		PACKET3_WAIT_REG_MEM__POLL_INTERVAL(x) ((((unsigned)(x)) & 0xFFFF) << 0)
+#define		PACKET3_WAIT_REG_MEM__OPTIMIZE_ACE_OFFLOAD_MODE(x) ((((unsigned)(x)) & 0x1) << 31)
+#define 	PACKET3_WAIT_REG_MEM__FUNCTION__ALWAYS_PASS 0
+#define 	PACKET3_WAIT_REG_MEM__FUNCTION__LESS_THAN_REF_VALUE 1
+#define 	PACKET3_WAIT_REG_MEM__FUNCTION__LESS_THAN_EQUAL_TO_THE_REF_VALUE 2
+#define 	PACKET3_WAIT_REG_MEM__FUNCTION__EQUAL_TO_THE_REFERENCE_VALUE 3
+#define 	PACKET3_WAIT_REG_MEM__FUNCTION__NOT_EQUAL_REFERENCE_VALUE 4
+#define 	PACKET3_WAIT_REG_MEM__FUNCTION__GREATER_THAN_OR_EQUAL_REFERENCE_VALUE 5
+#define 	PACKET3_WAIT_REG_MEM__FUNCTION__GREATER_THAN_REFERENCE_VALUE 6
+#define 	PACKET3_WAIT_REG_MEM__MEM_SPACE__REGISTER_SPACE 0
+#define 	PACKET3_WAIT_REG_MEM__MEM_SPACE__MEMORY_SPACE 1
+#define 	PACKET3_WAIT_REG_MEM__OPERATION__WAIT_REG_MEM 0
+#define 	PACKET3_WAIT_REG_MEM__OPERATION__WR_WAIT_WR_REG 1
+#define 	PACKET3_WAIT_REG_MEM__OPERATION__WAIT_MEM_PREEMPTABLE 3
+#define 	PACKET3_WAIT_REG_MEM__CACHE_POLICY__LRU 0
+#define 	PACKET3_WAIT_REG_MEM__CACHE_POLICY__STREAM 1
+#define 	PACKET3_WAIT_REG_MEM__CACHE_POLICY__NOA 2
+#define 	PACKET3_WAIT_REG_MEM__CACHE_POLICY__BYPASS 3
+#define 	PACKET3_WAIT_REG_MEM__TEMPORAL__RT 0
+#define 	PACKET3_WAIT_REG_MEM__TEMPORAL__NT 1
+#define 	PACKET3_WAIT_REG_MEM__TEMPORAL__HT 2
+#define 	PACKET3_WAIT_REG_MEM__TEMPORAL__LU 3
 #define	PACKET3_INDIRECT_BUFFER				0x3F
 #define		INDIRECT_BUFFER_VALID                   (1 << 23)
 #define		INDIRECT_BUFFER_CACHE_POLICY(x)         ((x) << 28)
@@ -144,8 +230,94 @@
 		 */
 #define		INDIRECT_BUFFER_PRE_ENB(x)		((x) << 21)
 #define		INDIRECT_BUFFER_PRE_RESUME(x)           ((x) << 30)
+#define 	PACKET3_INDIRECT_BUFFER__IB_BASE_LO(x) ((((unsigned)(x)) & 0x3FFFFFFF) << 2)
+#define 	PACKET3_INDIRECT_BUFFER__IB_BASE_HI(x) ((unsigned)(x))
+#define 	PACKET3_INDIRECT_BUFFER__IB_SIZE(x) ((((unsigned)(x)) & 0xFFFFF) << 0)
+#define 	PACKET3_INDIRECT_BUFFER__CHAIN(x) ((((unsigned)(x)) & 0x1) << 20)
+#define 	PACKET3_INDIRECT_BUFFER__OFFLOAD_POLLING(x) ((((unsigned)(x)) & 0x1) << 21)
+#define 	PACKET3_INDIRECT_BUFFER__VALID(x) ((((unsigned)(x)) & 0x1) << 23)
+#define 	PACKET3_INDIRECT_BUFFER__VMID(x) ((((unsigned)(x)) & 0xF) << 24)
+#define 	PACKET3_INDIRECT_BUFFER__CACHE_POLICY(x) ((((unsigned)(x)) & 0x3) << 28)
+#define 	PACKET3_INDIRECT_BUFFER__TEMPORAL(x) ((((unsigned)(x)) & 0x3) << 28)
+#define 	PACKET3_INDIRECT_BUFFER__PRIV(x) ((((unsigned)(x)) & 0x1) << 31)
+#define 	PACKET3_INDIRECT_BUFFER__TEMPORAL__RT 0
+#define 	PACKET3_INDIRECT_BUFFER__TEMPORAL__NT 1
+#define 	PACKET3_INDIRECT_BUFFER__TEMPORAL__HT 2
+#define 	PACKET3_INDIRECT_BUFFER__TEMPORAL__LU 3
+#define 	PACKET3_INDIRECT_BUFFER__CACHE_POLICY__LRU 0
+#define 	PACKET3_INDIRECT_BUFFER__CACHE_POLICY__STREAM 1
+#define 	PACKET3_INDIRECT_BUFFER__CACHE_POLICY__NOA 2
+#define 	PACKET3_INDIRECT_BUFFER__CACHE_POLICY__BYPASS 3
 #define	PACKET3_COND_INDIRECT_BUFFER			0x3F
 #define	PACKET3_COPY_DATA				0x40
+#define 	PACKET3_COPY_DATA__SRC_SEL(x) ((((unsigned)(x)) & 0xF) << 0)
+#define 	PACKET3_COPY_DATA__DST_SEL(x) ((((unsigned)(x)) & 0xF) << 8)
+#define 	PACKET3_COPY_DATA__SRC_CACHE_POLICY(x) ((((unsigned)(x)) & 0x3) << 13)
+#define 	PACKET3_COPY_DATA__SRC_TEMPORAL(x) ((((unsigned)(x)) & 0x3) << 13)
+#define 	PACKET3_COPY_DATA__COUNT_SEL(x) ((((unsigned)(x)) & 0x1) << 16)
+#define 	PACKET3_COPY_DATA__WR_CONFIRM(x) ((((unsigned)(x)) & 0x1) << 20)
+#define 	PACKET3_COPY_DATA__DST_CACHE_POLICY(x) ((((unsigned)(x)) & 0x3) << 25)
+#define 	PACKET3_COPY_DATA__PQ_EXE_STATUS(x) ((((unsigned)(x)) & 0x1) << 29)
+#define 	PACKET3_COPY_DATA__SRC_REG_OFFSET(x) ((((unsigned)(x)) & 0x3FFFF) << 0)
+#define 	PACKET3_COPY_DATA__SRC_32B_ADDR_LO(x) ((((unsigned)(x)) & 0x3FFFFFFF) << 2)
+#define 	PACKET3_COPY_DATA__SRC_64B_ADDR_LO(x) ((((unsigned)(x)) & 0x1FFFFFFF) << 3)
+#define 	PACKET3_COPY_DATA__SRC_GDS_ADDR_LO(x) ((((unsigned)(x)) & 0xFFFF) << 0)
+#define 	PACKET3_COPY_DATA__IMM_DATA(x) ((unsigned)(x))
+#define 	PACKET3_COPY_DATA__SRC_MEMTC_ADDR_HI(x) ((unsigned)(x))
+#define 	PACKET3_COPY_DATA__SRC_IMM_DATA(x) ((unsigned)(x))
+#define 	PACKET3_COPY_DATA__DST_REG_OFFSET(x) ((((unsigned)(x)) & 0x3FFFF) << 0)
+#define 	PACKET3_COPY_DATA__DST_32B_ADDR_LO(x) ((((unsigned)(x)) & 0x3FFFFFFF) << 2)
+#define 	PACKET3_COPY_DATA__DST_64B_ADDR_LO(x) ((((unsigned)(x)) & 0x1FFFFFFF) << 3)
+#define 	PACKET3_COPY_DATA__DST_GDS_ADDR_LO(x) ((((unsigned)(x)) & 0xFFFF) << 0)
+#define 	PACKET3_COPY_DATA__DST_ADDR_HI(x) ((unsigned)(x))
+#define 	PACKET3_COPY_DATA__MODE(x) ((((unsigned)(x)) & 0x1) << 21)
+#define 	PACKET3_COPY_DATA__AID_ID(x) ((((unsigned)(x)) & 0x3) << 23)
+#define 	PACKET3_COPY_DATA__DST_TEMPORAL(x) ((((unsigned)(x)) & 0x3) << 25)
+#define 	PACKET3_COPY_DATA__SRC_REG_OFFSET_LO(x) ((unsigned)(x))
+#define 	PACKET3_COPY_DATA__SRC_REG_OFFSET_HI(x) ((((unsigned)(x)) & 0xFF) << 0)
+#define 	PACKET3_COPY_DATA__DST_REG_OFFSET_LO(x) ((unsigned)(x))
+#define 	PACKET3_COPY_DATA__DST_REG_OFFSET_HI(x) ((((unsigned)(x)) & 0xFF) << 0)
+#define 	PACKET3_COPY_DATA__SRC_SEL__MEM_MAPPED_REGISTER 0
+#define 	PACKET3_COPY_DATA__SRC_SEL__TC_L2_OBSOLETE 1
+#define 	PACKET3_COPY_DATA__SRC_SEL__TC_L2 2
+#define 	PACKET3_COPY_DATA__SRC_SEL__GDS 3
+#define 	PACKET3_COPY_DATA__SRC_SEL__PERFCOUNTERS 4
+#define 	PACKET3_COPY_DATA__SRC_SEL__IMMEDIATE_DATA 5
+#define 	PACKET3_COPY_DATA__SRC_SEL__ATOMIC_RETURN_DATA 6
+#define 	PACKET3_COPY_DATA__SRC_SEL__GDS_ATOMIC_RETURN_DATA0 7
+#define 	PACKET3_COPY_DATA__SRC_SEL__GDS_ATOMIC_RETURN_DATA1 8
+#define 	PACKET3_COPY_DATA__SRC_SEL__GPU_CLOCK_COUNT 9
+#define 	PACKET3_COPY_DATA__SRC_SEL__SYSTEM_CLOCK_COUNT 10
+#define 	PACKET3_COPY_DATA__DST_SEL__MEM_MAPPED_REGISTER 0
+#define 	PACKET3_COPY_DATA__DST_SEL__TC_L2 2
+#define 	PACKET3_COPY_DATA__DST_SEL__GDS 3
+#define 	PACKET3_COPY_DATA__DST_SEL__PERFCOUNTERS 4
+#define 	PACKET3_COPY_DATA__DST_SEL__TC_L2_OBSOLETE 5
+#define 	PACKET3_COPY_DATA__DST_SEL__MEM_MAPPED_REG_DC 6
+#define 	PACKET3_COPY_DATA__SRC_TEMPORAL__RT 0
+#define 	PACKET3_COPY_DATA__SRC_TEMPORAL__NT 1
+#define 	PACKET3_COPY_DATA__SRC_TEMPORAL__HT 2
+#define 	PACKET3_COPY_DATA__SRC_TEMPORAL__LU 3
+#define 	PACKET3_COPY_DATA__SRC_CACHE_POLICY__LRU 0
+#define 	PACKET3_COPY_DATA__SRC_CACHE_POLICY__STREAM 1
+#define 	PACKET3_COPY_DATA__SRC_CACHE_POLICY__NOA 2
+#define 	PACKET3_COPY_DATA__SRC_CACHE_POLICY__BYPASS 3
+#define 	PACKET3_COPY_DATA__COUNT_SEL__32_BITS_OF_DATA 0
+#define 	PACKET3_COPY_DATA__COUNT_SEL__64_BITS_OF_DATA 1
+#define 	PACKET3_COPY_DATA__WR_CONFIRM__DO_NOT_WAIT_FOR_CONFIRMATION 0
+#define 	PACKET3_COPY_DATA__WR_CONFIRM__WAIT_FOR_CONFIRMATION 1
+#define 	PACKET3_COPY_DATA__MODE__PF_VF_DISABLED 0
+#define 	PACKET3_COPY_DATA__MODE__PF_VF_ENABLED 1
+#define 	PACKET3_COPY_DATA__DST_TEMPORAL__RT 0
+#define 	PACKET3_COPY_DATA__DST_TEMPORAL__NT 1
+#define 	PACKET3_COPY_DATA__DST_TEMPORAL__HT 2
+#define 	PACKET3_COPY_DATA__DST_TEMPORAL__LU 3
+#define 	PACKET3_COPY_DATA__DST_CACHE_POLICY__LRU 0
+#define 	PACKET3_COPY_DATA__DST_CACHE_POLICY__STREAM 1
+#define 	PACKET3_COPY_DATA__DST_CACHE_POLICY__NOA 2
+#define 	PACKET3_COPY_DATA__DST_CACHE_POLICY__BYPASS 3
+#define 	PACKET3_COPY_DATA__PQ_EXE_STATUS__DEFAULT 0
+#define 	PACKET3_COPY_DATA__PQ_EXE_STATUS__PHASE_UPDATE 1
 #define	PACKET3_CP_DMA					0x41
 #define	PACKET3_PFP_SYNC_ME				0x42
 #define	PACKET3_SURFACE_SYNC				0x43
@@ -160,6 +332,23 @@
 		 * 3 - SAMPLE_STREAMOUTSTAT*
 		 * 4 - *S_PARTIAL_FLUSH
 		 */
+#define		PACKET3_EVENT_WRITE__EVENT_TYPE(x) ((((unsigned)(x)) & 0x3F) << 0)
+#define		PACKET3_EVENT_WRITE__EVENT_INDEX(x) ((((unsigned)(x)) & 0xF) << 8)
+#define		PACKET3_EVENT_WRITE__SAMP_PLST_CNTR_MODE(x) ((((unsigned)(x)) & 0x3) << 29)
+#define		PACKET3_EVENT_WRITE__OFFLOAD_ENABLE(x) ((((unsigned)(x)) & 0x1) << 0)
+#define 	PACKET3_EVENT_WRITE__ADDRESS_LO(x) ((((unsigned)(x)) & 0x1FFFFFFF) << 3)
+#define 	PACKET3_EVENT_WRITE__ADDRESS_HI(x) ((unsigned)(x))
+#define 	PACKET3_EVENT_WRITE__EVENT_INDEX__OTHER 0
+#define 	PACKET3_EVENT_WRITE__EVENT_INDEX__SAMPLE_PIPELINESTAT 2
+#define 	PACKET3_EVENT_WRITE__EVENT_INDEX__CS_PARTIAL_FLUSH 4
+#define 	PACKET3_EVENT_WRITE__EVENT_INDEX__SAMPLE_STREAMOUTSTATS 8
+#define 	PACKET3_EVENT_WRITE__EVENT_INDEX__SAMPLE_STREAMOUTSTATS1 9
+#define 	PACKET3_EVENT_WRITE__EVENT_INDEX__SAMPLE_STREAMOUTSTATS2 10
+#define 	PACKET3_EVENT_WRITE__EVENT_INDEX__SAMPLE_STREAMOUTSTATS3 11
+#define 	PACKET3_EVENT_WRITE__SAMP_PLST_CNTR_MODE__LEGACY_MODE 0
+#define 	PACKET3_EVENT_WRITE__SAMP_PLST_CNTR_MODE__MIXED_MODE1 1
+#define 	PACKET3_EVENT_WRITE__SAMP_PLST_CNTR_MODE__NEW_MODE 2
+#define 	PACKET3_EVENT_WRITE__SAMP_PLST_CNTR_MODE__MIXED_MODE3 3
 #define	PACKET3_EVENT_WRITE_EOP				0x47
 #define	PACKET3_EVENT_WRITE_EOS				0x48
 #define	PACKET3_RELEASE_MEM				0x49
@@ -304,6 +493,12 @@
 		 * 2: REVERSE
 		 */
 #define 	PACKET3_ACQUIRE_MEM_GCR_RANGE_IS_PA  (1 << 18)
+#define 	PACKET3_ACQUIRE_MEM__COHER_SIZE(x) ((unsigned)(x))
+#define 	PACKET3_ACQUIRE_MEM__COHER_SIZE_HI(x) ((((unsigned)(x)) & 0xFF) << 0)
+#define 	PACKET3_ACQUIRE_MEM__COHER_BASE_LO(x) ((unsigned)(x))
+#define 	PACKET3_ACQUIRE_MEM__COHER_BASE_HI(x) ((((unsigned)(x)) & 0xFFFFFF) << 0)
+#define 	PACKET3_ACQUIRE_MEM__POLL_INTERVAL(x) ((((unsigned)(x)) & 0xFFFF) << 0)
+#define 	PACKET3_ACQUIRE_MEM__GCR_CNTL(x) ((((unsigned)(x)) & 0x7FFFF) << 0)
 #define	PACKET3_REWIND					0x59
 #define	PACKET3_INTERRUPT				0x5A
 #define	PACKET3_GEN_PDEPTE				0x5B
@@ -330,11 +525,17 @@
 #define	PACKET3_SET_SH_REG				0x76
 #define		PACKET3_SET_SH_REG_START			0x00002c00
 #define		PACKET3_SET_SH_REG_END				0x00003000
+#define 	PACKET3_SET_SH_REG__REG_OFFSET(x) ((((unsigned)(x)) & 0xFFFF) << 0)
+#define 	PACKET3_SET_SH_REG__VMID_SHIFT(x) ((((unsigned)(x)) & 0x1F) << 23)
+#define 	PACKET3_SET_SH_REG__INDEX(x) ((((unsigned)(x)) & 0xF) << 28)
+#define 	PACKET3_SET_SH_REG__INDEX__DEFAULT 0
+#define 	PACKET3_SET_SH_REG__INDEX__INSERT_VMID 1
 #define	PACKET3_SET_SH_REG_OFFSET			0x77
 #define	PACKET3_SET_QUEUE_REG				0x78
 #define	PACKET3_SET_UCONFIG_REG				0x79
 #define		PACKET3_SET_UCONFIG_REG_START			0x0000c000
 #define		PACKET3_SET_UCONFIG_REG_END			0x0000c400
+#define 	PACKET3_SET_UCONFIG_REG__REG_OFFSET(x) ((((unsigned)(x)) & 0xFFFF) << 0)
 #define	PACKET3_SET_UCONFIG_REG_INDEX			0x7A
 #define	PACKET3_FORWARD_HEADER				0x7C
 #define	PACKET3_SCRATCH_RAM_WRITE			0x7D
@@ -369,6 +570,7 @@
 #              define PACKET3_INVALIDATE_TLBS_DST_SEL(x)     ((x) << 0)
 #              define PACKET3_INVALIDATE_TLBS_ALL_HUB(x)     ((x) << 4)
 #              define PACKET3_INVALIDATE_TLBS_PASID(x)       ((x) << 5)
+#              define PACKET3_INVALIDATE_TLBS_FLUSH_TYPE(x)  ((x) << 29)
 #define	PACKET3_AQL_PACKET				0x99
 #define	PACKET3_DMA_DATA_FILL_MULTI			0x9A
 #define	PACKET3_SET_SH_REG_INDEX			0x9B
@@ -462,6 +664,12 @@
 #              define PACKET3_QUERY_STATUS_ENG_SEL(x)          ((x) << 25)
 #define	PACKET3_RUN_LIST				0xA5
 #define	PACKET3_MAP_PROCESS_VM				0xA6
+
+#define PACKET3_RUN_CLEANER_SHADER                      0xD2
+/* 1. header
+ * 2. RESERVED [31:0]
+ */
+
 /* GFX11 */
 #define	PACKET3_SET_Q_PREEMPTION_MODE			0xF0
 #              define PACKET3_SET_Q_PREEMPTION_MODE_IB_VMID(x)  ((x) << 0)
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15d.h b/drivers/gpu/drm/amd/amdgpu/soc15d.h
index b9cbeb389edc1..a5000c171c02c 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15d.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15d.h
@@ -93,11 +93,25 @@
 #define	PACKET3_DISPATCH_INDIRECT			0x16
 #define	PACKET3_ATOMIC_GDS				0x1D
 #define	PACKET3_ATOMIC_MEM				0x1E
+#define		PACKET3_ATOMIC_MEM__ATOMIC(x) ((((unsigned)(x)) & 0x3F) << 0)
+#define		PACKET3_ATOMIC_MEM__COMMAND(x) ((((unsigned)(x)) & 0xF) << 8)
+#define		PACKET3_ATOMIC_MEM__CACHE_POLICY(x) ((((unsigned)(x)) & 0x3) << 25)
+#define		PACKET3_ATOMIC_MEM__ADDR_LO(x) (((unsigned)(x)) << 0)
+#define		PACKET3_ATOMIC_MEM__ADDR_HI(x) (((unsigned)(x)) << 0)
+#define		PACKET3_ATOMIC_MEM__SRC_DATA_LO(x) (((unsigned)(x)) << 0)
+#define		PACKET3_ATOMIC_MEM__SRC_DATA_HI(x) (((unsigned)(x)) << 0)
+#define		PACKET3_ATOMIC_MEM__CMP_DATA_LO(x) (((unsigned)(x)) << 0)
+#define		PACKET3_ATOMIC_MEM__CMP_DATA_HI(x) (((unsigned)(x)) << 0)
+#define		PACKET3_ATOMIC_MEM__LOOP_INTERVAL(x) ((((unsigned)(x)) & 0x1FFF) << 0)
+#define 	PACKET3_ATOMIC_MEM__COMMAND__SINGLE_PASS_ATOMIC	0
+#define 	PACKET3_ATOMIC_MEM__COMMAND__LOOP_UNTIL_COMPARE_SATISFIED 1
 #define	PACKET3_OCCLUSION_QUERY				0x1F
 #define	PACKET3_SET_PREDICATION				0x20
 #define	PACKET3_REG_RMW					0x21
 #define	PACKET3_COND_EXEC				0x22
 #define	PACKET3_PRED_EXEC				0x23
+#define		PACKET3_PRED_EXEC__EXEC_COUNT(x)	((((unsigned)(x)) & 0x3FFF) << 0)
+#define		PACKET3_PRED_EXEC__VIRTUAL_XCC_ID_SELECT(x)	((((unsigned)(x)) & 0xFF) << 24)
 #define	PACKET3_DRAW_INDIRECT				0x24
 #define	PACKET3_DRAW_INDEX_INDIRECT			0x25
 #define	PACKET3_INDEX_BASE				0x26
@@ -132,6 +146,28 @@
 		 * 1 - pfp
 		 * 2 - ce
 		 */
+#define		PACKET3_WRITE_DATA__DST_SEL(x) ((((unsigned)(x)) & 0xF) << 8)
+#define		PACKET3_WRITE_DATA__ADDR_INCR(x) ((((unsigned)(x)) & 0x1) << 16)
+#define		PACKET3_WRITE_DATA__RESUME_VF_MI300(x) ((((unsigned)(x)) & 0x1) << 19)
+#define		PACKET3_WRITE_DATA__WR_CONFIRM(x) ((((unsigned)(x)) & 0x1) << 20)
+#define		PACKET3_WRITE_DATA__CACHE_POLICY(x) ((((unsigned)(x)) & 0x3) << 25)
+#define		PACKET3_WRITE_DATA__DST_MMREG_ADDR(x) ((((unsigned)(x)) & 0x3FFFF) << 0)
+#define		PACKET3_WRITE_DATA__DST_GDS_ADDR(x) ((((unsigned)(x)) & 0xFFFF) << 0)
+#define		PACKET3_WRITE_DATA__DST_MEM_ADDR_LO(x) ((((unsigned)(x)) & 0x3FFFFFFF) << 2)
+#define		PACKET3_WRITE_DATA__DST_MEM_ADDR_HI(x) ((unsigned)(x))
+#define		PACKET3_WRITE_DATA__DST_SEL__MEM_MAPPED_REGISTER	0
+#define		PACKET3_WRITE_DATA__DST_SEL__TC_L2	2
+#define		PACKET3_WRITE_DATA__DST_SEL__GDS	3
+#define		PACKET3_WRITE_DATA__DST_SEL__MEMORY	5
+#define		PACKET3_WRITE_DATA__DST_SEL__MEMORY_MAPPED_ADC_PERSISTENT_STATE	6
+#define		PACKET3_WRITE_DATA__ADDR_INCR__INCREMENT_ADDRESS	0
+#define		PACKET3_WRITE_DATA__ADDR_INCR__DO_NOT_INCREMENT_ADDRESS	1
+#define		PACKET3_WRITE_DATA__WR_CONFIRM__DO_NOT_WAIT_FOR_WRITE_CONFIRMATION	0
+#define		PACKET3_WRITE_DATA__WR_CONFIRM__WAIT_FOR_WRITE_CONFIRMATION	1
+#define		PACKET3_WRITE_DATA__CACHE_POLICY__LRU	0
+#define		PACKET3_WRITE_DATA__CACHE_POLICY__STREAM	1
+#define		PACKET3_WRITE_DATA__CACHE_POLICY__NOA	2
+#define		PACKET3_WRITE_DATA__CACHE_POLICY__BYPASS	3
 #define	PACKET3_DRAW_INDEX_INDIRECT_MULTI		0x38
 #define	PACKET3_MEM_SEMAPHORE				0x39
 #              define PACKET3_SEM_USE_MAILBOX       (0x1 << 16)
@@ -160,6 +196,33 @@
 		/* 0 - me
 		 * 1 - pfp
 		 */
+#define		PACKET3_WAIT_REG_MEM__FUNCTION(x) ((((unsigned)(x)) & 0x7) << 0)
+#define		PACKET3_WAIT_REG_MEM__MEM_SPACE(x) ((((unsigned)(x)) & 0x3) << 4)
+#define		PACKET3_WAIT_REG_MEM__OPERATION(x) ((((unsigned)(x)) & 0x3) << 6)
+#define		PACKET3_WAIT_REG_MEM__MES_INTR_PIPE(x) ((((unsigned)(x)) & 0x3) << 22)
+#define		PACKET3_WAIT_REG_MEM__MES_ACTION(x) ((((unsigned)(x)) & 0x1) << 24)
+#define		PACKET3_WAIT_REG_MEM__CACHE_POLICY(x) ((((unsigned)(x)) & 0x3) << 25)
+#define		PACKET3_WAIT_REG_MEM__MEM_POLL_ADDR_LO(x) ((((unsigned)(x)) & 0x3FFFFFFF) << 2)
+#define		PACKET3_WAIT_REG_MEM__REG_POLL_ADDR(x) ((((unsigned)(x)) & 0x3FFFF) << 0)
+#define		PACKET3_WAIT_REG_MEM__REG_WRITE_ADDR1(x) ((((unsigned)(x)) & 0x3FFFF) << 0)
+#define		PACKET3_WAIT_REG_MEM__MEM_POLL_ADDR_HI(x) ((unsigned)(x))
+#define		PACKET3_WAIT_REG_MEM__REG_WRITE_ADDR2(x) ((((unsigned)(x)) & 0x3FFFF) << 0)
+#define		PACKET3_WAIT_REG_MEM__REFERENCE(x) ((unsigned)(x))
+#define		PACKET3_WAIT_REG_MEM__MASK(x) ((unsigned)(x))
+#define		PACKET3_WAIT_REG_MEM__POLL_INTERVAL(x) ((((unsigned)(x)) & 0xFFFF) << 0)
+#define		PACKET3_WAIT_REG_MEM__OPTIMIZE_ACE_OFFLOAD_MODE(x) ((((unsigned)(x)) & 0x1) << 31)
+#define		PACKET3_WAIT_REG_MEM__FUNCTION__ALWAYS_PASS	0
+#define		PACKET3_WAIT_REG_MEM__FUNCTION__LESS_THAN_REF_VALUE	1
+#define		PACKET3_WAIT_REG_MEM__FUNCTION__LESS_THAN_EQUAL_TO_THE_REF_VALUE	2
+#define		PACKET3_WAIT_REG_MEM__FUNCTION__EQUAL_TO_THE_REFERENCE_VALUE	3
+#define		PACKET3_WAIT_REG_MEM__FUNCTION__NOT_EQUAL_REFERENCE_VALUE	4
+#define		PACKET3_WAIT_REG_MEM__FUNCTION__GREATER_THAN_OR_EQUAL_REFERENCE_VALUE	5
+#define		PACKET3_WAIT_REG_MEM__FUNCTION__GREATER_THAN_REFERENCE_VALUE	6
+#define		PACKET3_WAIT_REG_MEM__MEM_SPACE__REGISTER_SPACE	0
+#define		PACKET3_WAIT_REG_MEM__MEM_SPACE__MEMORY_SPACE	1
+#define		PACKET3_WAIT_REG_MEM__OPERATION__WAIT_REG_MEM	0
+#define		PACKET3_WAIT_REG_MEM__OPERATION__WR_WAIT_WR_REG	1
+#define		PACKET3_WAIT_REG_MEM__OPERATION__WAIT_MEM_PREEMPTABLE	3
 #define	PACKET3_INDIRECT_BUFFER				0x3F
 #define		INDIRECT_BUFFER_VALID                   (1 << 23)
 #define		INDIRECT_BUFFER_CACHE_POLICY(x)         ((x) << 28)
@@ -169,7 +232,63 @@
 		 */
 #define     INDIRECT_BUFFER_PRE_ENB(x)		 ((x) << 21)
 #define     INDIRECT_BUFFER_PRE_RESUME(x)               ((x) << 30)
+#define		PACKET3_INDIRECT_BUFFER__IB_BASE_LO(x) ((((unsigned)(x)) & 0x3FFFFFFF) << 2)
+#define		PACKET3_INDIRECT_BUFFER__IB_BASE_HI(x) ((unsigned)(x))
+#define		PACKET3_INDIRECT_BUFFER__IB_SIZE(x) ((((unsigned)(x)) & 0xFFFFF) << 0)
+#define		PACKET3_INDIRECT_BUFFER__CHAIN(x) ((((unsigned)(x)) & 0x1) << 20)
+#define		PACKET3_INDIRECT_BUFFER__OFFLOAD_POLLING(x) ((((unsigned)(x)) & 0x1) << 21)
+#define		PACKET3_INDIRECT_BUFFER__VALID(x) ((((unsigned)(x)) & 0x1) << 23)
+#define		PACKET3_INDIRECT_BUFFER__VMID(x) ((((unsigned)(x)) & 0xF) << 24)
+#define		PACKET3_INDIRECT_BUFFER__CACHE_POLICY(x) ((((unsigned)(x)) & 0x3) << 28)
+#define		PACKET3_INDIRECT_BUFFER__PRIV(x) ((((unsigned)(x)) & 0x1) << 31)
+#define		PACKET3_INDIRECT_BUFFER__CACHE_POLICY__LRU	0
+#define		PACKET3_INDIRECT_BUFFER__CACHE_POLICY__STREAM	1
 #define	PACKET3_COPY_DATA				0x40
+#define		PACKET3_COPY_DATA__SRC_SEL(x) ((((unsigned)(x)) & 0xF) << 0)
+#define		PACKET3_COPY_DATA__DST_SEL(x) ((((unsigned)(x)) & 0xF) << 8)
+#define		PACKET3_COPY_DATA__SRC_CACHE_POLICY(x) ((((unsigned)(x)) & 0x3) << 13)
+#define		PACKET3_COPY_DATA__COUNT_SEL(x) ((((unsigned)(x)) & 0x1) << 16)
+#define		PACKET3_COPY_DATA__WR_CONFIRM(x) ((((unsigned)(x)) & 0x1) << 20)
+#define		PACKET3_COPY_DATA__DST_CACHE_POLICY(x) ((((unsigned)(x)) & 0x3) << 25)
+#define		PACKET3_COPY_DATA__PQ_EXE_STATUS(x) ((((unsigned)(x)) & 0x1) << 29)
+#define		PACKET3_COPY_DATA__SRC_REG_OFFSET(x) ((((unsigned)(x)) & 0x3FFFF) << 0)
+#define		PACKET3_COPY_DATA__SRC_32B_ADDR_LO(x) ((((unsigned)(x)) & 0x3FFFFFFF) << 2)
+#define		PACKET3_COPY_DATA__SRC_64B_ADDR_LO(x) ((((unsigned)(x)) & 0x1FFFFFFF) << 3)
+#define		PACKET3_COPY_DATA__SRC_GDS_ADDR_LO(x) ((((unsigned)(x)) & 0xFFFF) << 0)
+#define		PACKET3_COPY_DATA__IMM_DATA(x) ((unsigned)(x))
+#define		PACKET3_COPY_DATA__SRC_MEMTC_ADDR_HI(x) ((unsigned)(x))
+#define		PACKET3_COPY_DATA__SRC_IMM_DATA(x) ((unsigned)(x))
+#define		PACKET3_COPY_DATA__DST_REG_OFFSET(x) ((((unsigned)(x)) & 0x3FFFF) << 0)
+#define		PACKET3_COPY_DATA__DST_32B_ADDR_LO(x) ((((unsigned)(x)) & 0x3FFFFFFF) << 2)
+#define		PACKET3_COPY_DATA__DST_64B_ADDR_LO(x) ((((unsigned)(x)) & 0x1FFFFFFF) << 3)
+#define		PACKET3_COPY_DATA__DST_GDS_ADDR_LO(x) ((((unsigned)(x)) & 0xFFFF) << 0)
+#define		PACKET3_COPY_DATA__DST_ADDR_HI(x) ((unsigned)(x))
+#define		PACKET3_COPY_DATA__SRC_SEL__MEM_MAPPED_REGISTER	0
+#define		PACKET3_COPY_DATA__SRC_SEL__MEMORY	1
+#define		PACKET3_COPY_DATA__SRC_SEL__TC_L2	2
+#define		PACKET3_COPY_DATA__SRC_SEL__GDS	3
+#define		PACKET3_COPY_DATA__SRC_SEL__PERFCOUNTERS	4
+#define		PACKET3_COPY_DATA__SRC_SEL__IMMEDIATE_DATA	5
+#define		PACKET3_COPY_DATA__SRC_SEL__ATOMIC_RETURN_DATA	6
+#define		PACKET3_COPY_DATA__SRC_SEL__GDS_ATOMIC_RETURN_DATA0	7
+#define		PACKET3_COPY_DATA__SRC_SEL__GDS_ATOMIC_RETURN_DATA1	8
+#define		PACKET3_COPY_DATA__SRC_SEL__GPU_CLOCK_COUNT	9
+#define		PACKET3_COPY_DATA__DST_SEL__MEM_MAPPED_REGISTER	0
+#define		PACKET3_COPY_DATA__DST_SEL__TC_L2	2
+#define		PACKET3_COPY_DATA__DST_SEL__GDS	3
+#define		PACKET3_COPY_DATA__DST_SEL__PERFCOUNTERS	4
+#define		PACKET3_COPY_DATA__DST_SEL__MEMORY	5
+#define		PACKET3_COPY_DATA__DST_SEL__MEM_MAPPED_REG_DC	6
+#define		PACKET3_COPY_DATA__SRC_CACHE_POLICY__LRU	0
+#define		PACKET3_COPY_DATA__SRC_CACHE_POLICY__STREAM 1
+#define		PACKET3_COPY_DATA__COUNT_SEL__32_BITS_OF_DATA	0
+#define		PACKET3_COPY_DATA__COUNT_SEL__64_BITS_OF_DATA	1
+#define		PACKET3_COPY_DATA__WR_CONFIRM__DO_NOT_WAIT_FOR_CONFIRMATION	0
+#define		PACKET3_COPY_DATA__WR_CONFIRM__WAIT_FOR_CONFIRMATION	1
+#define		PACKET3_COPY_DATA__DST_CACHE_POLICY__LRU	0
+#define		PACKET3_COPY_DATA__DST_CACHE_POLICY__STREAM	1
+#define		PACKET3_COPY_DATA__PQ_EXE_STATUS__DEFAULT	0
+#define		PACKET3_COPY_DATA__PQ_EXE_STATUS__PHASE_UPDATE	1
 #define	PACKET3_PFP_SYNC_ME				0x42
 #define	PACKET3_COND_WRITE				0x45
 #define	PACKET3_EVENT_WRITE				0x46
@@ -181,6 +300,15 @@
 		 * 3 - SAMPLE_STREAMOUTSTAT*
 		 * 4 - *S_PARTIAL_FLUSH
 		 */
+#define		PACKET3_EVENT_WRITE__EVENT_TYPE(x) ((((unsigned)(x)) & 0x3F) << 0)
+#define		PACKET3_EVENT_WRITE__EVENT_INDEX(x) ((((unsigned)(x)) & 0xF) << 8)
+#define		PACKET3_EVENT_WRITE__OFFLOAD_ENABLE(x) ((((unsigned)(x)) & 0x1) << 31)
+#define		PACKET3_EVENT_WRITE__SAMP_PLST_CNTR_MODE(x) ((((unsigned)(x)) & 0x3) << 29)
+#define		PACKET3_EVENT_WRITE__ADDRESS_LO(x) ((((unsigned)(x)) & 0x1FFFFFFF) << 3)
+#define		PACKET3_EVENT_WRITE__ADDRESS_HI(x) (((unsigned)(x)) << 0)
+#define		PACKET3_EVENT_WRITE__EVENT_INDEX__OTHER	0
+#define		PACKET3_EVENT_WRITE__EVENT_INDEX__SAMPLE_PIPELINESTATS	2
+#define		PACKET3_EVENT_WRITE__EVENT_INDEX__CS_PARTIAL_FLUSH	4
 #define	PACKET3_RELEASE_MEM				0x49
 #define		EVENT_TYPE(x)                           ((x) << 0)
 #define		EVENT_INDEX(x)                          ((x) << 8)
@@ -286,6 +414,13 @@
 #define 	PACKET3_ACQUIRE_MEM_CP_COHER_CNTL_SH_ICACHE_ACTION_ENA(x) ((x) << 29)
 #define 	PACKET3_ACQUIRE_MEM_CP_COHER_CNTL_SH_KCACHE_WB_ACTION_ENA(x) ((x) << 30)
 #define	PACKET3_REWIND					0x59
+#define		PACKET3_ACQUIRE_MEM__COHER_SIZE(x) ((unsigned)(x))
+#define 	PACKET3_ACQUIRE_MEM__COHER_SIZE_HI(x) ((((unsigned)(x)) & 0xFF) << 0)
+#define 	PACKET3_ACQUIRE_MEM__COHER_SIZE_HI_VG10(x) ((((unsigned)(x)) & 0xFFFFFF) << 0)
+#define 	PACKET3_ACQUIRE_MEM__COHER_BASE_LO(x) ((unsigned)(x))
+#define 	PACKET3_ACQUIRE_MEM__COHER_BASE_HI(x) ((((unsigned)(x)) & 0xFFFFFF) << 0)
+#define 	PACKET3_ACQUIRE_MEM__POLL_INTERVAL(x) ((((unsigned)(x)) & 0xFFFF) << 0)
+#define 	PACKET3_ACQUIRE_MEM__GCR_CNTL(x) ((((unsigned)(x)) & 0x7FF) << 0)
 #define	PACKET3_LOAD_UCONFIG_REG			0x5E
 #define	PACKET3_LOAD_SH_REG				0x5F
 #define	PACKET3_LOAD_CONFIG_REG				0x60
@@ -300,12 +435,16 @@
 #define	PACKET3_SET_SH_REG				0x76
 #define		PACKET3_SET_SH_REG_START			0x00002c00
 #define		PACKET3_SET_SH_REG_END				0x00003000
+#define 	PACKET3_SET_SH_REG__REG_OFFSET(x) ((((unsigned)(x)) & 0xFFFF) << 0)
+#define 	PACKET3_SET_SH_REG__VMID_SHIFT(x) ((((unsigned)(x)) & 0x1F) << 23)
+#define 	PACKET3_SET_SH_REG__INDEX(x) ((((unsigned)(x)) & 0xF) << 28)
 #define	PACKET3_SET_SH_REG_OFFSET			0x77
 #define	PACKET3_SET_QUEUE_REG				0x78
 #define	PACKET3_SET_UCONFIG_REG				0x79
 #define		PACKET3_SET_UCONFIG_REG_START			0x0000c000
 #define		PACKET3_SET_UCONFIG_REG_END			0x0000c400
 #define		PACKET3_SET_UCONFIG_REG_INDEX_TYPE		(2 << 28)
+#define 	PACKET3_SET_UCONFIG_REG__REG_OFFSET(x) ((((unsigned)(x)) & 0xFFFF) << 0)
 #define	PACKET3_SCRATCH_RAM_WRITE			0x7D
 #define	PACKET3_SCRATCH_RAM_READ			0x7E
 #define	PACKET3_LOAD_CONST_RAM				0x80
-- 
2.48.1

