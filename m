Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7570CD2593A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Jan 2026 05:28:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BCC110E285;
	Tue, 27 Jan 2026 05:28:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="I4/U1wlU";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013023.outbound.protection.outlook.com
 [40.107.201.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E71ED10E285
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Jan 2026 05:27:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CY1C/rpQNjjx9BjypEilDmR376d/SuFq5m46vpY1GkYBw2U97GwXomFob7qJ37X4KioYyTLLEQiBxoaTCH1n3Do7z9m4x8UWAHb7iWWvy34nckV7o033WzsmussfJOn7XKnRyHn4EIwTSPRarrRVKW7bAgjT3CQNGtNBI6vNl4YUPb7D9FFby1biJ5POwWeY5Ao2n8Fz3jD/ervE6zHu2jR8ML50MoihBooNXdmAU+rjFoa9mC0kMDIkpmVXpF4UgRncU6lCHgdLoLHwYSVgl7Wd10i2CkpkXnEFXnOZpJxi1MjUA3oicdUmH7HxvAHfyIRlMbNe3dnGNVWsu9OZ2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kud0lIj3dJPxtPeleXKKfLR9uJXtXqkXAVp0dkxYtPk=;
 b=TfUMukZJv6sJH6OW5RoarATx9HkiA2u+3q3yMJkJB0LOOTCknGKWC9AIrn7kqOiu+XuKU69iLuDXyi6Tb7eZEomDKKdOQZ2efqQQ5fEst5vVxg+Efj1swh73fbJsper3DUPlunfGvQqNO3R4L1ken/11ob8M55H9ueMDrxyoaAqZxlTpDTmp6D66phBhxZ4b9mzeKnqYtzx9Tygc5ni/RbZl4mdZKP2VfyzNI1EtNk8LQogbxbQ55v7tGQXuagrp4r6DdNdNk9IDpJS80/CIZzyJRLVqak8faTHBE6Glr//gACTdvDY+kC4N0AXV3nobQGRcQgo6U23iu7NnrGh6uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kud0lIj3dJPxtPeleXKKfLR9uJXtXqkXAVp0dkxYtPk=;
 b=I4/U1wlUdxE1oARWpEPTLZ6n/P5lz43DBBxoR+Rbr4K07K539DWnnregPNbEFA9GxhWtwUTRi+aeys67GDFbTe1Fl8MzUpzc7I5L8HLtmphHT9wBkG5M7OHdbccSf+bDU/4k1nuC/RamcSRydTeirNMY01XyKXxVDI2k1Awj60w=
Received: from DM6PR06CA0071.namprd06.prod.outlook.com (2603:10b6:5:54::48) by
 LV5PR12MB9756.namprd12.prod.outlook.com (2603:10b6:408:2fd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 05:27:55 +0000
Received: from CH3PEPF00000014.namprd21.prod.outlook.com
 (2603:10b6:5:54:cafe::88) by DM6PR06CA0071.outlook.office365.com
 (2603:10b6:5:54::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Tue,
 27 Jan 2026 05:27:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF00000014.mail.protection.outlook.com (10.167.244.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.0 via Frontend Transport; Tue, 27 Jan 2026 05:27:55 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 26 Jan
 2026 23:27:47 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 26 Jan 2026 21:27:47 -0800
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Fix cond_exec handling in amdgpu_ib_schedule()
Date: Tue, 27 Jan 2026 00:27:33 -0500
Message-ID: <20260127052733.54360-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000014:EE_|LV5PR12MB9756:EE_
X-MS-Office365-Filtering-Correlation-Id: b8d2621a-5d62-4aab-d955-08de5d64d30b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nprmFswI2HylWTtUIMh1FzANL6cWUKuqbrDthhBi0rqBJPNOFiYMal0klK+h?=
 =?us-ascii?Q?VppaOn/j0nXHsvjnTPIfBsWq8gXSFUpHIBAuZ98skfZqQwsl51JeeXgk6S+3?=
 =?us-ascii?Q?b/xQBxV6mVasf0f3VgTJSrU6pWzCJ4jCuuvFD/bzBB2hdY5EIcgj18kEcIeJ?=
 =?us-ascii?Q?9oxsuQxtQ4UNbU47cFD1hfSF70eJ/itcIggT5KAZW5oy3y1DwNR4ZNuUgXAS?=
 =?us-ascii?Q?GzllFM4NlwfPx32UN7XoYnWddzDpciNBM5ZUq8KzRHZhZMBXvPXuiZP1QTvs?=
 =?us-ascii?Q?Arz4eV2EZSkGF3sgvnl9wdyQsEsweKJN6karUw+ejmrBqonxBbc2zc7ASN48?=
 =?us-ascii?Q?X5ry0KNkHdQ7u1XHdxQdS+M7lBWR30xutw2MPPo9yFY4B7WekmZGSac8fjXf?=
 =?us-ascii?Q?F0EUkkHeXJGFozQkKme0UCBC5Ptb2PEwB0LpfKJh0jezbXRABFLWPenjYrHV?=
 =?us-ascii?Q?UWBMJ5s1k/NlhJVP8iQLUUQK7ShW4LiVaobjqX0s1O2AXrsgTgJyF5wgLNSu?=
 =?us-ascii?Q?DV7gGLLAIOXhJZh6tncdHQC9gfUMoTGthzeuBn0wbzXj5aPgai/cpaQcezzh?=
 =?us-ascii?Q?Uj2pEXTlAT98dzk86Amd4r5EK3lmbBAPQoajXBXRz455xSuGqwbU0h3HDYT7?=
 =?us-ascii?Q?PdeH2WyHynWdNjh3hiNJ+7yKHxFvQBdpz4LhkYA481aqLj9aOv19rgHal1ZX?=
 =?us-ascii?Q?8Fx0vQ5xoMYCMOxZz+r1DE9woEtEWmTVN/njT338mFovyp/vQ/teOnClOVSf?=
 =?us-ascii?Q?95iyRm/PdazXOqMNtPJUI2ghxfrQqy20jx8vcONnpJkcc1bVAxyaJNPe0+4Y?=
 =?us-ascii?Q?2jqTmAr2nbJ8y0wqmxwYRe/3UEHXaHMNHsiugq3qEd1Wx2sM+8laRid9/siq?=
 =?us-ascii?Q?IWGlacBmWdrjONwS2t8ffc0AIv3EcUWvK065EJWyM1thvoA0cBhV6wUicpCd?=
 =?us-ascii?Q?OCKvuA5VCa+sps/y421KABWKb2Qd+96rGmBJJw3ZB1/HTuIK7DqSboWrVcWC?=
 =?us-ascii?Q?PvlVF6xxjdosAjskRTTMyp/6sonRQ8StusukKsIC2yDacYZuq/ZRguAZ7YyB?=
 =?us-ascii?Q?ZlYuM9XHG1+GkGms8xwBWHrBwL/vghfV1VJbNqRF0Y5TTNvv6pEgzo7GamCo?=
 =?us-ascii?Q?BWEaaI0qT9EWiD+654PNZkepmsKKwRWhrLXVaWu7L/6TFBVQiC/fDbASNrpf?=
 =?us-ascii?Q?J3r+RxuNM2+RM4tasitsPr5nqPHKo9Rpjq2bv92+PeV4nPg5vgbx7xGWue9Q?=
 =?us-ascii?Q?yPXJWvlJEw4WaMF1EVQFMGlP++7yUfLHsz7xcs+j700snOqhZIeyRpOJEquX?=
 =?us-ascii?Q?S10rkIT+HewmXuPDmL7tl+kqe3wbQigQEY4v5k/9xGeqtWnUq1U0A+6z4bD3?=
 =?us-ascii?Q?u2uCMR4TW44lxeDD6+bh99Ns9ITWCxl7sLmEd0tL7YTSjgTZPOR4PvmSwbo0?=
 =?us-ascii?Q?/9fFGIsnjEoqMecjkH0IppTqmJbvulII/rXvL6isvwKCWZark8UHhEEWs1Uh?=
 =?us-ascii?Q?eEToBMP/0ouE6AD0SwdXG64cVfIjxT5+UqIN1urV/qcbNovoI1XKwPF0/2Vh?=
 =?us-ascii?Q?4I5B4Iofh22R1gpCqkz4M3VwMb1KJRynEpnk0N9JR6N+dXnUhYpFeLYWzZyl?=
 =?us-ascii?Q?y+6MG6JJJfSssIbfzi3aRd4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 05:27:55.1524 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8d2621a-5d62-4aab-d955-08de5d64d30b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000014.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9756
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

The EXEC_COUNT field must be > 0.  In the gfx shadow
handling we always emit a cond_exec packet after the gfx_shadow
packet, but the EXEC_COUNT never gets patched.  This leads
to a hang when we try and reset queues on gfx11 APUs.

Fixes: c68cbbfd54c6 ("drm/amdgpu: cleanup conditional execution")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4789
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 72ec455fa932c..44f230d67da24 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -235,7 +235,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 
 	amdgpu_ring_ib_begin(ring);
 
-	if (ring->funcs->emit_gfx_shadow)
+	if (ring->funcs->emit_gfx_shadow && adev->gfx.cp_gfx_shadow)
 		amdgpu_ring_emit_gfx_shadow(ring, shadow_va, csa_va, gds_va,
 					    init_shadow, vmid);
 
@@ -291,7 +291,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 				       fence_flags | AMDGPU_FENCE_FLAG_64BIT);
 	}
 
-	if (ring->funcs->emit_gfx_shadow && ring->funcs->init_cond_exec) {
+	if (ring->funcs->emit_gfx_shadow && ring->funcs->init_cond_exec &&
+	    adev->gfx.cp_gfx_shadow) {
 		amdgpu_ring_emit_gfx_shadow(ring, 0, 0, 0, false, 0);
 		amdgpu_ring_init_cond_exec(ring, ring->cond_exe_gpu_addr);
 	}
-- 
2.52.0

