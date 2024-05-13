Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CECC3C25B10
	for <amd-gfx@archiver.kernel.org>; Mon, 13 May 2024 08:56:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5010E10E53D;
	Mon, 13 May 2024 08:56:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pedJ7XsC";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D46710E53D
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 May 2024 08:56:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nU/7n+DyQZKmXQ/Gjv+48OVS4v7dn3I902q7Rf15ZR0PRGqToAp6aCBv41ewjrb6NT2aB5UHhZqBBI8ofLFHUzfeiVDV3+LeFFkRZhj8KDM0yiERBCjy9xSupG8d128YtHVmYMalGoTbQ+nAbYxWl58LyyXJjyRYHo/LgpHL2ezN3X1CKoOK6NDxznB1OkRWr86qj72iu8qwq5+EwScHDhCghBAoubTjiuOgDhhtwFLzJ/+UwNKHgDFeH0JizpGD4ozzfR/6NbDBzs09XKSQdbpTxoVX0R/fJFCr+j/M5RafKTiAJLnHWD16NEUkE8o6JysfFDOuVK0Yvv8DWNS/wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bXDOGSdeJjvUg37MrukI1+I5JvRvhg8nEyIyKVS2fPc=;
 b=e0N5y2hugBJpUIKb9vjwEK7wEXrPzeix1Dao/uJg+J7ZggHuNZrzD1XUjUfPpwPNAm3XY/2UGE3BU2KT/3phZTv6pKDGgnxHakLFhv99EXfmEQTE/mr7D0uSm87hRmSQ+CzgFhNXLvh+tWe3jWpPCwbgnqKBG0bYCeBlQ9p3sZj4/aqDsAFEh6VZAt4OYJCLrNt6ZDqvh/8xdPG358YxXKqH2qf5Fh+r7EFw5YUduND0fTBnQvJe8moZtr2MkoC6cPTjeAH2wh4sE6AUL/CXMxXG/CGBnEytItyf7uIZ9VBuhJeM09DoCb2iMpFLSbp7EBOlxfPf8jEhr93TGohbfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bXDOGSdeJjvUg37MrukI1+I5JvRvhg8nEyIyKVS2fPc=;
 b=pedJ7XsCpl52Cg+5Fxk7+3Sh0wlZOAcLEdH4VeGH5PkyyxqCaw5gByDsZNcsWMEiOSCvlB9hhJqCb7cJoHWLh5r6mpwITztHgGIXfQRCMS3V//vTrIy9UGTdGW54g2RQALNDijswq8h9I9fezn7YntBBd/JuXtucZUBAcbo16tY=
Received: from DS7PR03CA0332.namprd03.prod.outlook.com (2603:10b6:8:55::19) by
 DM4PR12MB5867.namprd12.prod.outlook.com (2603:10b6:8:66::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.55; Mon, 13 May 2024 08:56:47 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:8:55:cafe::9d) by DS7PR03CA0332.outlook.office365.com
 (2603:10b6:8:55::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Mon, 13 May 2024 08:56:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Mon, 13 May 2024 08:56:47 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 13 May
 2024 03:56:44 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Kenneth.Feng@amd.com>, <Alexander.Deucher@amd.com>,
 <kevinyang.wang@amd.com>, <christian.koenig@amd.com>, Ma Jun
 <Jun.Ma2@amd.com>
Subject: [PATCH 4/5] drm/amdgpu: Fix null pointer dereference to bo
Date: Mon, 13 May 2024 16:56:15 +0800
Message-ID: <20240513085616.584249-4-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240513085616.584249-1-Jun.Ma2@amd.com>
References: <20240513085616.584249-1-Jun.Ma2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|DM4PR12MB5867:EE_
X-MS-Office365-Filtering-Correlation-Id: cfb91dd2-8797-423f-ff5b-08dc732a9ef0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|36860700004|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?q8ILImTHTixewC5NDeFl05yIb5KaYVnLCv4TYd6W0Q4DnzbxOx1rpjpXLCVQ?=
 =?us-ascii?Q?5oaFZ/q/6N+IMa8VJTMHb265+Xu9VW97OrOgIcPz4PFDIiLpgvtARrcFfEnU?=
 =?us-ascii?Q?JdpHw0GvIjNCCldi7chHXC+q5JiBnF9HJsn1U2UPYj5K6D9hbdvBXSJLipv3?=
 =?us-ascii?Q?cGcCGRnFMjd0enGFy76QHFY/Vkh8KcfiOwWXknmrF332HsH994Pf+MtXgLiz?=
 =?us-ascii?Q?uYIfuxtMsyI/5rpJcIZrcTUhiJwU63CKfyKR2W5h7zsASgtJJh0SleYlUY/W?=
 =?us-ascii?Q?yYo3CXoCyGspxrM2m9Ya4blZ+AtQl8vW2GNplgXAY1/seznngaUQ8SFyZ7ep?=
 =?us-ascii?Q?rpm9tMr7VbMZue7xcP6Z3rjxlN9WhR3t/nziAOy2sMBR+hLLKHZNftT2Jz6l?=
 =?us-ascii?Q?1YQzh/6yImdGNpnYn9X14gs+WzGKAgOCFe/rsWsO7lvCRKLdmGsFgc0H2ian?=
 =?us-ascii?Q?2AsizxVfgRYXCxXQW3zpYYDpSVCLViyPeNhyeid+DX6zsAcKeYPLQbq039sd?=
 =?us-ascii?Q?IsgZiKoZj/wkQ5ptKGhRFVamWA0ixLSv8R4woHI4bydYmgOJRlcBZrlozUI7?=
 =?us-ascii?Q?bmtJw/cGr1jl0b18QbzUu0vWhufRP90lodclF5AN2+f82XHMUU7B6RLmgcR4?=
 =?us-ascii?Q?GslbEQHxeIADWuUY+WZ9+ZOQ72FLpsdSJUAkfApRzch3B7aiZSvpU3l4O5ai?=
 =?us-ascii?Q?C/8xg1JJm+flk+2ZP9Ev+zfCRsdOIqy62oaA2hyoS3akxm7PNA3MAMDOUb33?=
 =?us-ascii?Q?tqXXdcI/FQKPzCanSPUQzoESUAPe5bVU72TC+nWSQeoJAngerhcynrg00oR4?=
 =?us-ascii?Q?z6LA4jMpFmsE0nkG/LZA6HEAm9+Cd3UFIU7sbLSkJvvjZYb6OjzE8Is47bEd?=
 =?us-ascii?Q?zwHSEYAOl1wM0NRbuqLuCsBKgObZEQSMwIqf84Z6aJtqAGPCDp/3elAp7/2S?=
 =?us-ascii?Q?Px8/QfxA/6kpUAAXMd184hXXsssQ3FuwSuVkGtFxIrBkk0n1eDnyznPGfAlJ?=
 =?us-ascii?Q?qy7pHkMZi85A0gtF3Efn4vF93VeuamlIC2bmAKRAL9qGjSX6NubqSd+VS72H?=
 =?us-ascii?Q?IUFLLq21gC24Lm6qUuYU/TyzZvF4ZY9iFzJ549q/drO/+n62jJzrju9XzMKI?=
 =?us-ascii?Q?TWsusCCbtXF4PiJlZozHloahqvjMJLsWjllW1z3gBs5tqkfs9ttkyk6Udrdy?=
 =?us-ascii?Q?GmG9cQpmzu4Xquaa6AayEMhtmqOH2sLLI6aEOA8hiVh0znr89yIeLORLvckQ?=
 =?us-ascii?Q?p2rYjJaW5Zi1Efh4DL3EkI0HlO+vAFyDZ/xZ3hrwmQuNTe1Hf/Uqd2e24ehP?=
 =?us-ascii?Q?YK9/tU3CPL8zuZUyzRpA74q99qUO00mQ8we3JnrwyclonXo+3pHUae6w9GVS?=
 =?us-ascii?Q?ziw9xmuIKRKTA0UMsTBuzh+O8twH?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 08:56:47.1245 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfb91dd2-8797-423f-ff5b-08dc732a9ef0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5867
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

Check bo before using it

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 2b7b67916c1d..8269fd6828bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -497,9 +497,8 @@ static void gmc_v12_0_get_vm_pte(struct amdgpu_device *adev,
 				 uint64_t *flags)
 {
 	struct amdgpu_bo *bo = mapping->bo_va->base.bo;
-	struct amdgpu_device *bo_adev = amdgpu_ttm_adev(bo->tbo.bdev);
-	bool coherent = bo->flags & AMDGPU_GEM_CREATE_COHERENT;
-	bool is_system = bo->tbo.resource->mem_type == TTM_PL_SYSTEM;
+	struct amdgpu_device *bo_adev;
+	bool coherent, is_system;
 
 
 	*flags &= ~AMDGPU_PTE_EXECUTABLE;
@@ -515,13 +514,20 @@ static void gmc_v12_0_get_vm_pte(struct amdgpu_device *adev,
 		*flags &= ~AMDGPU_PTE_VALID;
 	}
 
-	if (bo && bo->flags & (AMDGPU_GEM_CREATE_COHERENT |
+	if (!bo)
+		return;
+
+	if (bo->flags & (AMDGPU_GEM_CREATE_COHERENT |
 			       AMDGPU_GEM_CREATE_UNCACHED))
 		*flags = (*flags & ~AMDGPU_PTE_MTYPE_GFX12_MASK) |
 			 AMDGPU_PTE_MTYPE_GFX12(MTYPE_UC);
 
+	bo_adev = amdgpu_ttm_adev(bo->tbo.bdev);
+	coherent = bo->flags & AMDGPU_GEM_CREATE_COHERENT;
+	is_system = bo->tbo.resource->mem_type == TTM_PL_SYSTEM;
+
 	/* WA for HW bug */
-	if ((bo && is_system) || ((bo_adev != adev) && coherent))
+	if (is_system || ((bo_adev != adev) && coherent))
 		*flags |= AMDGPU_PTE_MTYPE_GFX12(MTYPE_NC);
 
 }
-- 
2.34.1

