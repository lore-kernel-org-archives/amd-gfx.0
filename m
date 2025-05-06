Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64588C3ABAC
	for <amd-gfx@archiver.kernel.org>; Tue,  6 May 2025 09:38:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02E2910E641;
	Tue,  6 May 2025 09:38:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sSHlxk9Z";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2078.outbound.protection.outlook.com [40.107.236.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FA2C10E640
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 May 2025 09:38:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X+VX4imAftrhALrtXQFAzsHjf9fxdFx24iAgdEh4HauHtb0PZgjQVuJp1ZmjpcGh2erWZMBELeI3duXuQRbyM5t/du9OiXBVaTUIU7XO/2qF+GZOBiKDmLdT978vF1PmBlBTGVcAjK979n9fiFEpVT/utUDLUwv1pZfvv2yl6ecLonejLFFmTAvfTGTTNW1XUHDVwderHgdzXIkSZNX92kfsAXywfvSmiH2rEHD3et2wbPeUijlwv3XQNYqDbncybWfwZA2CRay2964/o0rCCi/OvZCbCu+cG2XXDh0EbxuZUzYSB/U+dJvZcTC4na/Ghf3tWIOlgpfM2HVm7qE7yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sf7unzmxBtrDF4FbYP6K6tFkVOi7MPvMh9YYuIfajLI=;
 b=DDkUIUPnOIgvfWH3FCaI3GKBgcXDGGpH2ys5IFLffF4f2ocrBhSiBMOOfeTZ89zNWN1740x44tlQIdRhoMRJeTgO7VHOLn+GMhPl5klQ67VrAT+g5ZyWKPKFyc3XbAKItTG5zNDDMQzOiAm3aMudo7n9iOIZIodVxoj7fU/EIcog5OGFqjMR+iyRHogEXVSXK7iIUsRZ0dfX1wxPMsa3gFamHpuj/dVIT5V9gGQmrH3iMmk2GMnblhAofgdEiBg4+l3GjBbR75Rwb4QtMWYGYe6+ovID4DSQYWS3oA8OFEr28OsyYVJRJ5sTWDg1Y7SsZ+ha/onP3cKVtrqrM4ao3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sf7unzmxBtrDF4FbYP6K6tFkVOi7MPvMh9YYuIfajLI=;
 b=sSHlxk9ZvGWia67hPmP7WL6O3ttnAaSaIFwdFA2hPNH342tFjSaAZaYmPD5aUQSNRsWnCiOHxkA2bIiuFJqd+aL63d7AxPVLV2e30ENRbcJfvfbPVA3AKpYBehalOTkYB7P+pcmpAcBgi3X56Pemk2BEfbGhfBeaCtt24r4ED1c=
Received: from DM6PR10CA0030.namprd10.prod.outlook.com (2603:10b6:5:60::43) by
 DS7PR12MB6311.namprd12.prod.outlook.com (2603:10b6:8:94::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.22; Tue, 6 May 2025 09:38:22 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:5:60:cafe::a2) by DM6PR10CA0030.outlook.office365.com
 (2603:10b6:5:60::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Tue,
 6 May 2025 09:38:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Tue, 6 May 2025 09:38:22 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 May
 2025 04:38:21 -0500
Received: from hjbog-srdc-17.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 6 May 2025 04:38:19 -0500
From: Samuel Zhang <guoqing.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <victor.zhao@amd.com>, <haijun.chang@amd.com>, <guoqing.zhang@amd.com>,
 <Christian.Koenig@amd.com>, <Alexander.Deucher@amd.com>,
 <Owen.Zhang2@amd.com>, <Qing.Ma@amd.com>
Subject: [PATCH v3 6/7] drm/amdgpu: remove cached gpu addr:
 psp_context.tmr_mc_addr
Date: Tue, 6 May 2025 17:36:28 +0800
Message-ID: <20250506093629.249792-6-guoqing.zhang@amd.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250506093629.249792-1-guoqing.zhang@amd.com>
References: <20250506093629.249792-1-guoqing.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: guoqing.zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|DS7PR12MB6311:EE_
X-MS-Office365-Filtering-Correlation-Id: 066a74e2-98ce-4fbe-840b-08dd8c81be36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wi3PWuvzfw8ymPqjgG7D/CdLyccUuZ/DXpMxopSXzexEmKsREpPY4yKDcK1s?=
 =?us-ascii?Q?K+9dArUD5B4+T4noEh9V0A2BPi9jQqLEe7Y4geR4NsG4D5MLk3MbANSrPHE/?=
 =?us-ascii?Q?QYikPo8tuLWeaYIbU3/nXl+npB4VDxbkrIa3gHm3kcMtE24JOWbW7LGzmUyt?=
 =?us-ascii?Q?01KTha8RLzZEkSRG+zzUBOXGQ0KNnA8EEdiAPQQCBgUxMER/OvbFaZOTgzMC?=
 =?us-ascii?Q?Ub1OGitsXnYxKQFTWWmqqBkOC6wsVQAw8SDM5n3eIbOvWkDXWY5yQCiyf7Ee?=
 =?us-ascii?Q?5w9I/sH4iJNc8L1r7ZzKQ5NjPiFBhIs3K9lqGYS1V4XkFRchL3su9+vZ5kQT?=
 =?us-ascii?Q?sEqr9MlD2XlWUxp86UEWHf0jrupptORk9sJFahh92VWYZshFicZyqj4jbsvq?=
 =?us-ascii?Q?z9mD9Va1MwDHVIX63tzK4G1wdcsG9md4fnWjqbZ5pLg4L/tm6twCuRrV63FN?=
 =?us-ascii?Q?NaXm/Ek9KZOhHzaB12hCnkpxkFw9md8FYH4Mnv3QEth4ksYCHWOIIbKQkWZd?=
 =?us-ascii?Q?QHJUFzonDWhPisu+QXrW4A/wxdmDJxH28GovXXVMgOlMl9eVL51ZUejqknHS?=
 =?us-ascii?Q?E0jY2J9kZRcYlQXn6SY8GNHOjhnya9jymfEeHqXHKxxi73UbPlnYNVkz4WDK?=
 =?us-ascii?Q?iOVaxl6E+yAewGVkDoCRd13FIRajkTaVnaolxsbeWfgYOQrsicl58cf1IfW9?=
 =?us-ascii?Q?Jb5D9pM+KWeEHd23ZbyMsjr72xLO0KHOKDv+/ODepdtcogQPjFXlA3LkKjjW?=
 =?us-ascii?Q?Erz3OQU5IZj6uu7VFdDcutQZzLV1iak2/IRHzqaFm7ecrBnSkoedVX1AhYcg?=
 =?us-ascii?Q?8+pMKLpTI93UwkP8W1ceHg334zzqC52oRBfT4o+ebqDeZwkQ9zk0QisIzKV2?=
 =?us-ascii?Q?pNiMi2czzh6Xzodv3haYQVaFoedfgBGUbDRBgVoaOqqSA1FL+3B8XhAtoxMY?=
 =?us-ascii?Q?uQf49s+fg0xPQl2TOe3aDuwWLhEIwZoTdF1uM1UtkJiTsjGDkD0LVAl265oH?=
 =?us-ascii?Q?hAxrjtNGSKpzl0SOvzniT3ngfl9Jv+Sn9WKEQIH+pNKaXWTonQ4o4Mbg+oNN?=
 =?us-ascii?Q?4dAqHnAqCA3eEQ0+Rlq3tAtI4o/JgO54cZxRsKDkSByGj6K5yKQ2Kd/N6Yn1?=
 =?us-ascii?Q?RYo/WskQ/U0+T42wARCPYQ/Y9Zt7XMfwU5CdDGnAHihC9fQMn1awdmFpIUHF?=
 =?us-ascii?Q?hJRywsL2CHgdCJ0cJ9ZQXp+EbpKZMJq6hx9jFQba7xmUAo04dISvUAlv07os?=
 =?us-ascii?Q?b8T+/QRS5HJzFUoPn5mdYvEQuzKtfAGXsUn7YRqYJIFiJwqTHzJwZc6kD3yu?=
 =?us-ascii?Q?SgnnezD416VrScj5gU4EPSKEfNfeRPKzuv5H+TOC0FO7d8rAoc509veVche1?=
 =?us-ascii?Q?5BCykEBUupCc/ZphxsIyaJnqbJXp35cGWyNL4rFq51aLUvX2KXbrfAzQ5fS2?=
 =?us-ascii?Q?gIb3S48yqj62TLP4s6XBjXxutMOf9+9Md1v3AgG4Pb6BVNr0B8Pg2vFWrni/?=
 =?us-ascii?Q?zSo0gHYb6V/QmbDiB9V+nhH+aIomL0LJiTZD?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 09:38:22.5471 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 066a74e2-98ce-4fbe-840b-08dd8c81be36
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6311
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

When pdb0 enabled, the cached gpu addr is not compatible with SMU and
PSP. It always need to be updated. Remove the cached gpu addr and use
local variable instead.

Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 12 ++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  1 -
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 153c0c868546..3b71ff298f21 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -287,7 +287,7 @@ static void psp_free_shared_bufs(struct psp_context *psp)
 
 	/* free TMR memory buffer */
 	pptr = amdgpu_sriov_vf(psp->adev) ? &tmr_buf : NULL;
-	amdgpu_bo_free_kernel(&psp->tmr_bo, &psp->tmr_mc_addr, pptr);
+	amdgpu_bo_free_kernel(&psp->tmr_bo, NULL, pptr);
 	psp->tmr_bo = NULL;
 
 	/* free xgmi shared memory */
@@ -867,11 +867,9 @@ static int psp_tmr_init(struct psp_context *psp)
 					      AMDGPU_HAS_VRAM(psp->adev) ?
 					      AMDGPU_GEM_DOMAIN_VRAM :
 					      AMDGPU_GEM_DOMAIN_GTT,
-					      &psp->tmr_bo, &psp->tmr_mc_addr,
+					      &psp->tmr_bo, NULL,
 					      pptr);
 	}
-	if (psp->tmr_bo)
-		psp->tmr_mc_addr = amdgpu_bo_fb_aper_addr(psp->tmr_bo);
 
 	return ret;
 }
@@ -896,6 +894,7 @@ static int psp_tmr_load(struct psp_context *psp)
 {
 	int ret;
 	struct psp_gfx_cmd_resp *cmd;
+	uint64_t tmr_mc_addr;
 
 	/* For Navi12 and CHIP_SIENNA_CICHLID SRIOV, do not set up TMR.
 	 * Already set up by host driver.
@@ -905,10 +904,11 @@ static int psp_tmr_load(struct psp_context *psp)
 
 	cmd = acquire_psp_cmd_buf(psp);
 
-	psp_prep_tmr_cmd_buf(psp, cmd, psp->tmr_mc_addr, psp->tmr_bo);
+	tmr_mc_addr = amdgpu_bo_fb_aper_addr(psp->tmr_bo);
+	psp_prep_tmr_cmd_buf(psp, cmd, tmr_mc_addr, psp->tmr_bo);
 	if (psp->tmr_bo)
 		dev_info(psp->adev->dev, "reserve 0x%lx from 0x%llx for PSP TMR\n",
-			 amdgpu_bo_size(psp->tmr_bo), psp->tmr_mc_addr);
+			 amdgpu_bo_size(psp->tmr_bo), tmr_mc_addr);
 
 	ret = psp_cmd_submit_buf(psp, NULL, cmd,
 				 psp->fence_buf_mc_addr);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 106d07aaf8e1..d3f5c17ead7e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -348,7 +348,6 @@ struct psp_context {
 
 	/* tmr buffer */
 	struct amdgpu_bo		*tmr_bo;
-	uint64_t			tmr_mc_addr;
 
 	/* asd firmware */
 	const struct firmware		*asd_fw;
-- 
2.43.5

