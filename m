Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45981C982C3
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jan 2026 20:40:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2CB010E931;
	Fri, 16 Jan 2026 20:40:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XBGX25na";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012064.outbound.protection.outlook.com
 [40.93.195.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70C5410E92E
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jan 2026 20:40:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wqOi4ULUpq2zibkiZGkGZq8AKyiBF0WBIzUVYeh3sI168OeNSQuUJ0bbYcDx4ZYiwDkssV4ZgJK+UNw0FymyV4YkTjMuwwgPgu8dWWen4G54Eaa+EcDNo66gLCTDOA7vjWIqeiJyeM3J1Gk1t/tu85UQ7X5arOqpKceRYRm/lE5wfFVGGItLAtRT+QIhrm1d0tCixtHIxTVmiti8F3BF3bJba3F6kor9D9YTgXHDQuUHezxB8ihbti/dT11DejEaYowkMg5xXzzzZjna+GU5X2Ah0KAM91S8FjB3jWGtvsQkFhvLmFes72W7bCJDxbG5jz+kL9vO55DJ6AxCz9aqBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RPW6h3O6qIHEx4ADDFIY8WaP5QxXHxyTt3A9pHyHitY=;
 b=w7bI4swRX7KvVjQEAbCBkSv6IdAcaJiar1FWlDqGs7SR/JRBEZ+/dkcIc2A6yKMyljoMIc9iPULLHXWL3hl3H6ayn2VPZ5CaNKfJkM5ENwcK3W67VF1x9KB5glKQLKGIp9ybF3tiYrsH2uvbrPR13+QrD7Ruv6Hm9w+F7lXF2u+cDtuJOk6G74lIrE9xNxznmjfXA7c5OsNnnUJ46FPV1ix43zKXMne1slcfP1ONNdUNd4ZR3J8WOE8qLnW/NZ548et57A1HIyVa/KKn4OErfTfI7L8LV35dnxOuJvl4pFTBAvbG18M5wKteEcYFlfH2hRxOIpC7IWBGlE9kTIEPDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RPW6h3O6qIHEx4ADDFIY8WaP5QxXHxyTt3A9pHyHitY=;
 b=XBGX25naefmlhPXhte4ceUTBfwi9d2OCCRE3x+mMsNR9abs/P3pZRUYtClGdzQg/mhBWTj0unTMBOR2+y8QuvcFSQuSdr5YTB5FFeJ9sk6NVSTu6TM9b1qeJVnPJAEaYwPUS1m8xus0lVXCIcrCrnugxVQPjH5vx4pexzknnDnI=
Received: from BN9PR03CA0290.namprd03.prod.outlook.com (2603:10b6:408:f5::25)
 by DS7PR12MB6240.namprd12.prod.outlook.com (2603:10b6:8:94::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 20:40:18 +0000
Received: from BN1PEPF00005FFD.namprd05.prod.outlook.com
 (2603:10b6:408:f5:cafe::1) by BN9PR03CA0290.outlook.office365.com
 (2603:10b6:408:f5::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Fri,
 16 Jan 2026 20:40:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00005FFD.mail.protection.outlook.com (10.167.243.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Fri, 16 Jan 2026 20:40:18 +0000
Received: from jc-d.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 16 Jan
 2026 14:40:16 -0600
From: Jay Cornwall <jay.cornwall@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jay Cornwall <jay.cornwall@amd.com>, Lancelot Six <lancelot.six@amd.com>, 
 Joseph Greathouse <joseph.greathouse@amd.com>, Vladimir Indic
 <vladimir.indic@amd.com>
Subject: [PATCH 2/5] drm/amdkfd: Fix scalar load ordering in gfx12.1 trap
 handler
Date: Fri, 16 Jan 2026 14:39:29 -0600
Message-ID: <20260116203932.988704-3-jay.cornwall@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260116203932.988704-1-jay.cornwall@amd.com>
References: <20260116203932.988704-1-jay.cornwall@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFD:EE_|DS7PR12MB6240:EE_
X-MS-Office365-Filtering-Correlation-Id: b0a6a2a9-db2b-4f18-8888-08de553f75d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hhNw7qbSF7d9ID12l/7b1V5YAdDSKnH8ntR6Di7xOQj5o5nICfDMSUJYx1rq?=
 =?us-ascii?Q?yqzMPCg14cU81K3ljaL5KBoM5gY7dx72RekQdWbYKKd414Kp3EjmTqO8b8Kq?=
 =?us-ascii?Q?ZvoRMzfU2l5MSpauqGp3dcSQW+MMSf9799cCMZj7ftdiuKWT8ZsD+9g4WTzM?=
 =?us-ascii?Q?RIqCaqdOzc6vrDqPe7IJIfoTCL5Im8av+EWNYJKfOFuM3andcrjolQy0xU5m?=
 =?us-ascii?Q?SwF91LwTXV9m7L+15xYt2PmNaDrJGW3REuER/6MkScBFNSoDvoD3jXvm0O4g?=
 =?us-ascii?Q?4mpQYGb/dARnOgn2avjGow4Q0uY64RpMwLESxZyf242eyiiugXua52Xzqx5/?=
 =?us-ascii?Q?FBu3UKwySjoFNc1oosBrdUrDoFubSo8xP1ArxKdia7WAQRzJnvmHKoqAStQ6?=
 =?us-ascii?Q?jGaPDmJeO73rydGdD/km8a4E9LKrXHbW06sPG6FSjOkmb6upTFD8ck2Qnu1N?=
 =?us-ascii?Q?lr4+cwYYfH8ZwupomQ6ltB38TK/kY0PS32ZWuQwAVtuR9XW3VSsFiGziqXs1?=
 =?us-ascii?Q?iQyMisYbeQepsEUZTWSiIrQstgAeOBRMpqdok1+DGOjKsOV4l9pJWpg5KJbM?=
 =?us-ascii?Q?9D6PxVolCgHanqTACwu2CEsB71oWzxOtQp6TBOEwqFq8zk4pq0v2/CAGAq44?=
 =?us-ascii?Q?vPq/o/yXrqkbKWA1nVfgFxX+Nz8T/yLth6OuZ1oWvyWBFoMBglqerKvHwj4/?=
 =?us-ascii?Q?H8bnYaFoFketvVq3X+/FVcXgZ9g4gOnyFc/aC/JZ3Ppm7bOdyYAY5BfRjw3G?=
 =?us-ascii?Q?/F4ye5mAP8Os6kS41BaF8qFwQI3Z6j1X0HTIVLnxkPXJ3zGC+MMMjgLEBXCj?=
 =?us-ascii?Q?4SleB9Oy0jdiVGRAFgO2RwdyD0eo/LsPj3Gtz/12Ydc+ptftMUkgWmk+2UX3?=
 =?us-ascii?Q?9/yOjlwHCz3k4OCMXFhOiFcA/miLshyYb7YC4nLXmdtfzw2hnmP89vh8KDy5?=
 =?us-ascii?Q?JWvJWL30AK4gRGDfTdjSD3nb0dNnBq1tCbDrZgp7mlrQIk6kOyNUQbVs99lH?=
 =?us-ascii?Q?6Q3Y7ayhsoiVKOxefTtw9VKzPQnHaqr0VvsEbKzDl0S9NFkwAEhFpkJ+JbDZ?=
 =?us-ascii?Q?szD4gg6G8MtjpjCmPyZMi02wjZrv/CsLi7NxbYdou0lwZoI6WHjf3DCsgZDG?=
 =?us-ascii?Q?kA8yf9sDm1YIn88q8cbvwd/Kr29cnR+fPm6RfYRPGevTQCctN6Wj4D0FSwJt?=
 =?us-ascii?Q?ohwkSfh3GqdEFX2pLm0DfddbvbM58UO1/05CpdsUEkuvvOpQOVAax8ObYOhS?=
 =?us-ascii?Q?Nh7oXO/iwSU0wMaE86e+dxjog7bDrszFxcKZEVScDys4u0Vaspw6qtaKqszG?=
 =?us-ascii?Q?vPwan9SkWNDX9etM+QjRcj+qA732v15iPVvcyWAApWP2twIUV+5s7LHjanE3?=
 =?us-ascii?Q?fJ2uOENhfufuFkuCZQUfi/dXNTiEjX3HrbOQ5haAmvyS/F1vmaYZFG+EBK7R?=
 =?us-ascii?Q?rI1OuR77wV3M0wgUj9eBtdVDCt9KgZe5TddEMFES2cN954IXS1KUSuNOabI1?=
 =?us-ascii?Q?qYvr6PUHCnUkaDVK1AmRylowSbQuurbrUMpsAY1VBnWSU65OgMPODVoIQSyB?=
 =?us-ascii?Q?7I3F6wsswbrlRG8/WJyCDEev8OoQd/HQyeuSLtx31CR5VZJ0vUyBfZjRt7rT?=
 =?us-ascii?Q?P1eSRW/00gyuHVmtBM2AFEnIMpFYzCW/0LYIs6fISmOgkfqE7GaiRtVkLViS?=
 =?us-ascii?Q?1+w8Eg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 20:40:18.1173 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0a6a2a9-db2b-4f18-8888-08de553f75d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6240
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

Scalar loads may arrive out-of-order with respect to KMCNT.
The affected code expects the two loads to arrive in-order.

Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
Cc: Lancelot Six <lancelot.six@amd.com>
Cc: Joseph Greathouse <joseph.greathouse@amd.com>
Cc: Vladimir Indic <vladimir.indic@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h         | 8 ++++----
 drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
index 6281b2f9faee..453c08845d74 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
@@ -4638,8 +4638,8 @@ static const uint32_t cwsr_trap_gfx12_1_0_hex[] = {
 	0x01ffffff, 0xb8fbf811,
 	0xbf0d847b, 0xbfa20078,
 	0xf4003eb6, 0xf8000000,
-	0xf4003bb6, 0xf8000008,
-	0xbfc70001, 0x8b76ff7a,
+	0xbfc70000, 0xf4003bb6,
+	0xf8000008, 0x8b76ff7a,
 	0x80000000, 0xbfa20027,
 	0x9376ff7a, 0x00060019,
 	0x81f9a376, 0xbf0b8179,
@@ -4717,8 +4717,8 @@ static const uint32_t cwsr_trap_gfx12_1_0_hex[] = {
 	0xb980f821, 0x00000000,
 	0xbf0d847b, 0xbfa20078,
 	0xf4003eb6, 0xf8000000,
-	0xf4003bb6, 0xf8000008,
-	0xbfc70001, 0x8b76ff7a,
+	0xbfc70000, 0xf4003bb6,
+	0xf8000008, 0x8b76ff7a,
 	0x80000000, 0xbfa20027,
 	0x9376ff7a, 0x00060019,
 	0x81f9a376, 0xbf0b8179,
diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
index 1624a02ad0ef..7ed4b502eb22 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
@@ -1357,8 +1357,8 @@ function fixup_vgpr_bank_selection
 	// ttmp[0:1]: {7b'0} PC[56:0]
 	// ttmp2, 3, 10, 13, 14, 15: free
 	s_load_b64	[ttmp14, ttmp15], [ttmp0, ttmp1], 0 scope:SCOPE_CU	// Load the 2 instruction DW we are returning to
+	s_wait_kmcnt	0
 	s_load_b64	[ttmp2, ttmp3], [ttmp0, ttmp1], 8 scope:SCOPE_CU	// Load the next 2 instruction DW, just in case
-	s_wait_kmcnt	1
 	s_and_b32	ttmp10, ttmp14, 0x80000000				// Check bit 31 in the first DWORD
 										// SCC set if ttmp10 is != 0, i.e. if bit 31 == 1
 	s_cbranch_scc1	L_FIXUP_NOT_VOP12C					// If bit 31 is 1, we are not VOP1, VOP2, or VOP3C
-- 
2.34.1

