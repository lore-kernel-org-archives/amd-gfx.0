Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3606DCEE35A
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Nov 2025 22:07:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5571910E20A;
	Tue, 18 Nov 2025 22:06:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TEJvxicg";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012052.outbound.protection.outlook.com
 [40.107.200.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0A0D10E162
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Nov 2025 22:06:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Df0iY2MY9nenKHy6poTgDY4jujjiy6Geyi3PDkKjgXWtUF8LweJBCXFuFcR1AoPnDa8BhbEzbPs0cn0nthhkPUaWi1KF5dlEx08XPyvlMdarqvQqHz6yQ9Y1lCHIWzaoeNdzu5ia1Fi4pRhYecvRf2xviSoQID8YRqWM3gsUZje6YBPxu/QP6QWSwn/DGOLdn30df1YtRpUtX1Rz8gA+A31mpe+pVVLEL6hdAUdvbzrD2CY/Yc3PHkkCnSl3dAzJcng6MxZgdM7FN/gtB0KD3ZKWaYbK2DARQKHjIciyzq+jRT0MxDy6pl5RtzsMVDSLV99/RAdJ7CyhJBLKUWZyFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/kjbv6EQ42eIs7+f+Oa+GEu6tyQGll2md2khBbB8y/c=;
 b=CWmw5F6BK3JubXVBhQnQZPuPmK+h/iKNHa9Y2fNHSqNLZ+WNWH7rSqkk7HJ8jLFZ0xxmM81nIBiLW4P8blmHIPxZUt5TswUYKgDgiASnzKGNRMGcGl+DAXr5J9W3kj+ijF5jXdQk0f3JbJSTzorK0HOOtGsexUFEOkwOtyG6d2sOB8M9TLBSyvjdjly4pB6zcPHDQgdw7Tld/HO4jcLVGV68OrJty9o2NGZ43TUPZ3AeVd10mK5EccAe+wtv1mJCr8UtggVIptjBcVw398FN8i0P4dIxdDeJgQGTfwRZN5j6x8tgIydErEFHtqQF2fRDCxkZ/3P3tTiL5UPnKpqrlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/kjbv6EQ42eIs7+f+Oa+GEu6tyQGll2md2khBbB8y/c=;
 b=TEJvxicg5KiljOJcH0GhkafznJodmQMeADhASWohxaHtB3btHB9BwwnjmL09bTi9l3w/x+nXLOXR0ZmyFOL4xToN8i/De2NPcKZ0ouIGG48/tcn5kXDBCqrF0W2dteLDyZx6S4njsczw6KaSBFQGyR48TIdSWLuS8pMKFVsjM3s=
Received: from BN0PR04CA0092.namprd04.prod.outlook.com (2603:10b6:408:ec::7)
 by MW6PR12MB7088.namprd12.prod.outlook.com (2603:10b6:303:238::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 18 Nov
 2025 22:06:54 +0000
Received: from BN1PEPF00004680.namprd03.prod.outlook.com
 (2603:10b6:408:ec:cafe::b7) by BN0PR04CA0092.outlook.office365.com
 (2603:10b6:408:ec::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Tue,
 18 Nov 2025 22:06:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004680.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Tue, 18 Nov 2025 22:06:54 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 18 Nov
 2025 14:06:51 -0800
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: use common defines for HUB faults
Date: Tue, 18 Nov 2025 17:06:37 -0500
Message-ID: <20251118220637.3594610-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251118220637.3594610-1-alexander.deucher@amd.com>
References: <20251118220637.3594610-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004680:EE_|MW6PR12MB7088:EE_
X-MS-Office365-Filtering-Correlation-Id: d05c17a6-3f72-4ad5-f7d9-08de26eec8a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lWukrJopJTKV5AKWDI2xbnaVT8AvDlkKw6jp9xkFqWZWBCBd3L4dM1h90kD8?=
 =?us-ascii?Q?0GS02822WJ16bmIyoUR4waJr+nIVIqXez+l/6iwypnBJ1LxpzQarwRtJiFyk?=
 =?us-ascii?Q?sVSfGeVhhvRsOg+KtpfH3FRTj85plu0u1uJSgBlZ3UqnXJ+84btTL5d9droR?=
 =?us-ascii?Q?o3rcbnLS9LmxjSXNYbfo5WI+2FTEyNmpxLOgxgEPNZH4td/kVo7ds/ITq/IG?=
 =?us-ascii?Q?F0+z0KpQDhkBiYlNS7vRyqIKFmO9e4YQ/e+EisaGDdMnus7Cqm//E3IBiyW7?=
 =?us-ascii?Q?f39YSzmT/kGQWywjDItnfybxVGA64Y3t9MMEFY6279buJ1H34re4iu4FonCH?=
 =?us-ascii?Q?fm9GqYJhswhu3yhIOlM2/TSvqjq9yGUQvyVB2jl9e70v9bSx3nlqJ0GppGMm?=
 =?us-ascii?Q?KAD+BqOwWiDAacob1TtphK2vdlM/KQp9Qlw9XKZO2j4fvQjkB89/6xRq+C7g?=
 =?us-ascii?Q?NLLJfZA3RWiGKDMbFxngc/eOwv9kJrZwHGwLRon3FZyG18pse+VvWC56tPmN?=
 =?us-ascii?Q?PeaU/uNONxAeZWNP0pUjr53WHpujYM0DpR+mNb5wbztAT1TGXmWsufZ/5lX0?=
 =?us-ascii?Q?fQ0n6RjbpuqDKppbiRVFeNGOryPurYqwMXyDFYblX8/gnV3m/kDb8GmdojB6?=
 =?us-ascii?Q?zXvrwksuMYP288mKXdDslPnZ/t1flPZIW5ABaMigIaa4IewbkjfGkwlPAMad?=
 =?us-ascii?Q?WupsiGw6+ayEiKDUgrQir6uv7WDuy0bncQWRUQJ9hu2xYQLpXVQte+yBM/ph?=
 =?us-ascii?Q?0c6HQKMfJ4s6z0+hXaj2RVwdkfCsu8OjyS6yvf1rr7KWE0GlIvGNw4CJu4rx?=
 =?us-ascii?Q?5Jx+aCo3tA4gGpKIkEfSzH1m9U+58q+Cf5ttJz/dubiVrsL4Hpd7qay6P9MV?=
 =?us-ascii?Q?5YnNrEbKVKtftMCAhGajlydx4TemWIiGlH7CwAidHBc7po7x3RPbdPBMZGj9?=
 =?us-ascii?Q?oVKXI58Cqy7E8hxo8t0pDpisO3oZnVILa4HYS7W0qRD5y3ZFddbThi/qnkDH?=
 =?us-ascii?Q?0d8kp83tEObZ5jVbuhF5gk+ruyfFZh/8A7apfKhrmbFKIMV8cYxUWT4fJJwV?=
 =?us-ascii?Q?qt1eIQqKyZkhTXf5LGwa1GRaHjAqM2Lz9+TFV68ThCSg8qR7VQCr2fhXn5Mt?=
 =?us-ascii?Q?5rBve97KSZLMUC9mpQx+6EcwhY27uDpWoEzu1oN+B2VSslvUGtLcGbP7GETJ?=
 =?us-ascii?Q?SQiSPLxLdP/HixIPHof3Cl5m/j6XcfQaULKMl1C/gkmqXt80GCDIK3CcHrjF?=
 =?us-ascii?Q?e6WcKeocqs19iotzC8rAkIPjPqz6dabcMKC54kVYP5iYNjJOtMCQ9FQb9Pfk?=
 =?us-ascii?Q?e+RncXVx8G2/tB01Ijor8WbdH4du2xgrynBBpGRdCJgy/+iI6NP4YcArb62G?=
 =?us-ascii?Q?pF4yQk5kcjsHLHvEpvO3Nr1nthrFOTvOGXsfVyA39dk8hqZpHu9mobfPZoXc?=
 =?us-ascii?Q?hc7zBLHDJ8r5isXwUZmoTA1jzHaHFjoqSR5XHN6gzzfWPw3Zs9i2w4nBqlg4?=
 =?us-ascii?Q?UQx4LSCW8/V7quSYAWzFmxtOTlIMtPByKcp3TOa9/YHKCU5rQ5NoBXRsXdck?=
 =?us-ascii?Q?VGuqReUbpGitqWxUZGc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 22:06:54.2835 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d05c17a6-3f72-4ad5-f7d9-08de26eec8a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004680.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7088
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

Use common definitions for the fault bits in the IH sourc
data for the gmc9-12 memory hub faults

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h | 5 +++++
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 6 ++++--
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  | 6 ++++--
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c  | 6 ++++--
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 6 ++++--
 5 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 55097ca107382..727342689d4ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -86,6 +86,11 @@ enum amdgpu_memory_partition {
 
 #define AMDGPU_MAX_MEM_RANGES 8
 
+#define AMDGPU_GMC9_FAULT_SOURCE_DATA_RETRY 0x80
+#define AMDGPU_GMC9_FAULT_SOURCE_DATA_READ  0x40
+#define AMDGPU_GMC9_FAULT_SOURCE_DATA_WRITE 0x20
+#define AMDGPU_GMC9_FAULT_SOURCE_DATA_EXE   0x10
+
 /*
  * GMC page fault information
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index d7499be8c4bfc..ce6e04242c522 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -103,8 +103,10 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
 	uint32_t vmhub_index = entry->client_id == SOC15_IH_CLIENTID_VMC ?
 			       AMDGPU_MMHUB0(0) : AMDGPU_GFXHUB(0);
 	struct amdgpu_vmhub *hub = &adev->vmhub[vmhub_index];
-	bool retry_fault = !!(entry->src_data[1] & 0x80);
-	bool write_fault = !!(entry->src_data[1] & 0x20);
+	bool retry_fault = !!(entry->src_data[1] &
+			      AMDGPU_GMC9_FAULT_SOURCE_DATA_RETRY);
+	bool write_fault = !!(entry->src_data[1] &
+			      AMDGPU_GMC9_FAULT_SOURCE_DATA_WRITE);
 	struct amdgpu_task_info *task_info;
 	uint32_t status = 0;
 	u64 addr;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 25cdcb850416c..b36abb3f664d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -103,8 +103,10 @@ static int gmc_v11_0_process_interrupt(struct amdgpu_device *adev,
 	uint32_t vmhub_index = entry->client_id == SOC21_IH_CLIENTID_VMC ?
 			       AMDGPU_MMHUB0(0) : AMDGPU_GFXHUB(0);
 	struct amdgpu_vmhub *hub = &adev->vmhub[vmhub_index];
-	bool retry_fault = !!(entry->src_data[1] & 0x80);
-	bool write_fault = !!(entry->src_data[1] & 0x20);
+	bool retry_fault = !!(entry->src_data[1] &
+			      AMDGPU_GMC9_FAULT_SOURCE_DATA_RETRY);
+	bool write_fault = !!(entry->src_data[1] &
+			      AMDGPU_GMC9_FAULT_SOURCE_DATA_WRITE);
 	uint32_t status = 0;
 	u64 addr;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 43f8e96d3fe53..c2947415359ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -91,8 +91,10 @@ static int gmc_v12_0_process_interrupt(struct amdgpu_device *adev,
 				       struct amdgpu_iv_entry *entry)
 {
 	struct amdgpu_vmhub *hub;
-	bool retry_fault = !!(entry->src_data[1] & 0x80);
-	bool write_fault = !!(entry->src_data[1] & 0x20);
+	bool retry_fault = !!(entry->src_data[1] &
+			      AMDGPU_GMC9_FAULT_SOURCE_DATA_RETRY);
+	bool write_fault = !!(entry->src_data[1] &
+			      AMDGPU_GMC9_FAULT_SOURCE_DATA_WRITE);
 	uint32_t status = 0;
 	u64 addr;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index e716097dfde48..8ad7519f7b581 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -544,8 +544,10 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 				      struct amdgpu_irq_src *source,
 				      struct amdgpu_iv_entry *entry)
 {
-	bool retry_fault = !!(entry->src_data[1] & 0x80);
-	bool write_fault = !!(entry->src_data[1] & 0x20);
+	bool retry_fault = !!(entry->src_data[1] &
+			      AMDGPU_GMC9_FAULT_SOURCE_DATA_RETRY);
+	bool write_fault = !!(entry->src_data[1] &
+			      AMDGPU_GMC9_FAULT_SOURCE_DATA_WRITE);
 	uint32_t status = 0, cid = 0, rw = 0, fed = 0;
 	struct amdgpu_task_info *task_info;
 	struct amdgpu_vmhub *hub;
-- 
2.51.1

