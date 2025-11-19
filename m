Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74F51CF34D1
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Nov 2025 15:06:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF56410E658;
	Wed, 19 Nov 2025 15:06:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RyQlttVb";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012024.outbound.protection.outlook.com
 [40.93.195.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C69FE10E656
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Nov 2025 15:06:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uqda3km3+DYHYMpebqaIufwEg7fJN1qv3ECakttZRsZQ6y5P/nX+AHgCkBqErY01F3cYGfQTDEHrL+lzhpandnXOH4kKdED1zq4DGeijZZmCHHaIGCQqvGj8jhQoIx8SMPVdT0ODbBpNKVcTxzaUVpe3YlW0AGW+j9dyw2z4nswOPA17FrgAL2W2BBETj8lhCT+AyWpzSYJcLBi3E0Hf2jbCWX37YrgZy/EiVG5263gDZHO+pA8F+jVC/j6/tBLohEEoMNkOS8mNejIc8+E0XSYla49dewlfC7MbFIXY3KMmlZPdSJksAT9GuuTlDkBXBJHH0bJP+FRQIgDtB5GNMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=93xSpHy/nlYo9QCc967RJ6PpHTelQ9rCg9JRJSpf3sY=;
 b=a0TDwfO88Ky9NEPkwugD8TOxa56Ym2XZxdvvmqv11vrBXb+ynvGbZUlX7SiVGpO/g1MKU1rS0CMycCpKr22lfGRhX7FWGMd2my2zmcZPZDyZuIcor19fdvx0T3aGvclWQ3pz6nfT3FFR+Or/+R/1PNeP2QdaXi6LQR50kZSf4sIAXy3dm260TwfpA8QLKTIvbNpxACk81OxUud0sjx1lnwgiyjqnMDfPnOM49uEKqFl0mBcfrzu5GXRSuv/QSA8lLRMiJIu5l1YqnxC9feLDZLwUGvBVUx7kvy/emraf2Mj6L+HZ2VA5FsYPJ98eyQU8jSnN4QJri5CqEHMbmz5IXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=93xSpHy/nlYo9QCc967RJ6PpHTelQ9rCg9JRJSpf3sY=;
 b=RyQlttVbUUtevDMhkwsgoeNRczc3RyS/aeLbNBwdCdUFwBOducogik2YV+C/jbIjI3B4l8BnkDLyfU3+1UOiRiFXHpIqbM642GgMvx5PinFjjJUlcii+DOmYRI2uAgC8JfmWHZ7OB+HIFZq7ON5nDMKusemUHmjP9p4j1MFClpQ=
Received: from BN9PR03CA0750.namprd03.prod.outlook.com (2603:10b6:408:110::35)
 by DM4PR12MB7741.namprd12.prod.outlook.com (2603:10b6:8:103::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Wed, 19 Nov
 2025 15:06:19 +0000
Received: from BN2PEPF00004FBD.namprd04.prod.outlook.com
 (2603:10b6:408:110:cafe::7a) by BN9PR03CA0750.outlook.office365.com
 (2603:10b6:408:110::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Wed,
 19 Nov 2025 15:06:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBD.mail.protection.outlook.com (10.167.243.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 15:06:17 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 19 Nov
 2025 07:06:14 -0800
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 3/7] drm/amdgpu: Add per-ASIC PTE init flag
Date: Wed, 19 Nov 2025 10:05:56 -0500
Message-ID: <20251119150600.3663611-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251119150600.3663611-1-alexander.deucher@amd.com>
References: <20251119150600.3663611-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBD:EE_|DM4PR12MB7741:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f6164b0-9092-4e9e-7ff2-08de277d308d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LOxypsW5zvkrctLeV7Jw3dwwUvrlVTotz+cJN7GEKIIn/Vt0ZIgH+36o1d+B?=
 =?us-ascii?Q?IEcKIRag4Sg8jS9s79oWROH78OM5SvMaQIis9v3Z1TJYZaMG/CLm8CJwV5NN?=
 =?us-ascii?Q?4CFbGZ6DIvmMQ9h9zGRMqqdeZej2BeMyz3zKEz/uYJJfZCmuFHZYqds7ohxb?=
 =?us-ascii?Q?IQZaHStaM97iVvPldanGS/yjzlya+stOjGCxT7OkGcbnIWF8YriNRv7LFQpS?=
 =?us-ascii?Q?8V8SM3srQF7HYu6889YVX12cgaWsqFlbivjk5jYAhCRKc9DLFM57FYkSxc6G?=
 =?us-ascii?Q?HJeL0tDgjqEgRhgycXgYlhXovLhr2AUejCIPo2no8Qb4Ab8PaMxSDDHfIuTf?=
 =?us-ascii?Q?qiXIhxIiuVhd5ZJ8R2j4MAunrPZS8hBo6NpfjxqYpX2ckOR3u6U0kFk1NSyg?=
 =?us-ascii?Q?X/D1lDSDQhEhuVcX0SHg9JjH8Vzd5f2OqswxxgRaijSNyytGPpxHBIoMG3gE?=
 =?us-ascii?Q?mZWGL19ulV2Dtq5BdTaLPSwzOBXlBnQTJkA8dRuBWzXSC5Gi3qjwAo6E0VPU?=
 =?us-ascii?Q?sPp0kFvrvbaFetqjMlySKwCnnUD/2XSal8ixRSoCdhItjy8nv0gjToAPL1Zc?=
 =?us-ascii?Q?zyewiB6QtUIdxH2iGe3UVmE8nmLAKagD1E/tqCJbJLxuVq4iQb+ZfznvQe+i?=
 =?us-ascii?Q?LvB79h8bS/u3BSgTrZEHGD0JDmBqn3ngSCCoP1XHHTWBsQJ4M5jay4YLE+1j?=
 =?us-ascii?Q?JmzsvaOwqQp60NRy2wShMnFYO0c2GVsR20pjKa0Q9VBtm9lcyDQrPlUHi+DW?=
 =?us-ascii?Q?QpZLysGXknm3Cyfv/Yw7WAFmg9dUtR/l50nIA9IugK++4i0WLWM682M8Brwr?=
 =?us-ascii?Q?RyVg4idBgi9bx7/cz+79aUVwV4r7cUbyX/pj0PmEdxZFAG6UKY9yHhyNPavZ?=
 =?us-ascii?Q?Afcw6ymMirlFghiUQWFgh6NH1/oxjgKe5qUZ13e3HcEYiudnNJwJk+QxTHOu?=
 =?us-ascii?Q?5E+zuuLS5Lmzp2PI/R5zH59VmlnnxzELLAqlIMwqFqN6ogcRZZDqZMnFrkUg?=
 =?us-ascii?Q?gx/hWTpf5f+ON18phLGbMmFxGu/x2/GR2K37fXKqWnoJ7DE+kKRsUxUnUcgq?=
 =?us-ascii?Q?3NWyFnK0YlwnqotH5z1CN2G2mzTDhnapJ5Jy3I6zJi7+ELWfBp1QUmKc4Fqn?=
 =?us-ascii?Q?cckpvYXwAZgPUeHY6V/WTampO0EK/AhpeAyhzj1K32E0jA08dN56uC3JhvMg?=
 =?us-ascii?Q?/cyBwovT9EIjHbhr1YwXpQQX+SdjiGhc+5VJdyC8GPlA+admntzjBFoFs6/1?=
 =?us-ascii?Q?e+8/mVAbF8jcpMDlWUFRFzerzNRvWEEY6s/TdJZYQTdBj25fKHQsk9LOhDaT?=
 =?us-ascii?Q?paYqsL3In7EQ+nYe3jkRM8bj4nuU4vLF0PhmbXDq9uxsG6LJSkNP1oF2Yqwb?=
 =?us-ascii?Q?mQ7c3EXCk5ek08v8fT8nWdluH7TYK0XmjqqpXdplQ9y0NTLXZP1Ex9NN+Nsw?=
 =?us-ascii?Q?lFJZciTA1d6VshGbijT32E6PSdEYZPL94nOD38WP/HCZMLK2e7nFT68MfNWo?=
 =?us-ascii?Q?LspC31Ydo/CBPorTPs+obAbshZaJvJNVO4qaJr94nP7A3geh5fbc12luRWcw?=
 =?us-ascii?Q?YBOr40+FPSO5oFyMCpQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 15:06:17.1738 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f6164b0-9092-4e9e-7ff2-08de277d308d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7741
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

From: Mukul Joshi <mukul.joshi@amd.com>

On GFX12.1, default PTE setup needs an additional bit to be
set. Add PTE initialization flags to handle setup default PTE
on a per-ASIC basis.
While at it, fixup the coding style too.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Philip Yang <Philip.Yang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h   | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c    | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 130310ae3c59e..98514fe0a5f68 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -351,6 +351,7 @@ struct amdgpu_gmc {
 	u64 MC_VM_MX_L1_TLB_CNTL;
 
 	u64 noretry_flags;
+	u64 init_pte_flags;
 
 	bool flush_tlb_needs_extra_type_0;
 	bool flush_tlb_needs_extra_type_2;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index f6ffc207ec2a6..8bd411ba8b218 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -366,6 +366,7 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	struct amdgpu_bo *ancestor = &vmbo->bo;
 	unsigned int entries;
 	struct amdgpu_bo *bo = &vmbo->bo;
+	uint64_t value = 0, flags = 0;
 	uint64_t addr;
 	int r, idx;
 
@@ -402,7 +403,6 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 	addr = 0;
 
-	uint64_t value = 0, flags = 0;
 	if (adev->asic_type >= CHIP_VEGA10) {
 		if (level != AMDGPU_VM_PTB) {
 			/* Handle leaf PDEs as PTEs */
@@ -411,7 +411,7 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 					      &value, &flags);
 		} else {
 			/* Workaround for fault priority problem on GMC9 */
-			flags = AMDGPU_PTE_EXECUTABLE;
+			flags = AMDGPU_PTE_EXECUTABLE | adev->gmc.init_pte_flags;
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 3cb61d2c58f95..ab7d3469c5c50 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -627,6 +627,7 @@ static int gmc_v12_0_early_init(struct amdgpu_ip_block *ip_block)
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 	case IP_VERSION(12, 1, 0):
 		gmc_v12_1_set_gmc_funcs(adev);
+		adev->gmc.init_pte_flags = AMDGPU_PTE_IS_PTE;
 		break;
 	default:
 		gmc_v12_0_set_gmc_funcs(adev);
-- 
2.51.1

