Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0913FCA0EE6
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Aug 2025 03:22:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A900E10E382;
	Thu, 21 Aug 2025 03:22:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e1nTInfD";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A651A10E382
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Aug 2025 03:22:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ybsTqHacMbqcf9Hn9scYB9j8E/1663RmAlvZDnbtm8EzFXnuPCYG61XNs48iZZ+Lcg0PF8YI4IZ/xT6RgFt0A9fonKqQ06MDrupW3394gcu0zZ2Aw2HenRCw/pTjHPBNDj/QAbTcxpheAWyjWSsbbAmuYJNfEsMHqy1SdNV5nvD3osxy7RERjLcq0NZgD32F2G2eREcUDnJuGdkeMI04IbmCQH/Vsa8xoKmxdEdBisW/yG44Hy9Xuks5WzeIKs2VGp7pWDCQICsk+ZPMTsbm1O0LO3sGoamGYSLW78Ue7d+u2qHhkbARHjddrbtVVDTvFeiTXf21A5iT8EOZCwVrUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xqprI6aslZD6bhbEyRqB+8/486suJhP5M/Kb9k57qnI=;
 b=lHaJNVjJ3GxR/QumM68wmaflnp8v39BNij7pJEV2OIAkgdvnlrZnpw1nUfGvStyjOVtha7CIBMsWEvkLd4V7iDJCRlF67s/SzdsvH4EbDyU1mlaCDlcQH/SS3/dnFBjcnaG8HGLWz7S3FX5RFadTnieRR7nWMCw5wR5bV/vvhbIo+xfRk8m23NFyRLjVIqrJfiYV6Mz+x+Xl22jsSXCUCfelqT4JgdWo7RSekjbltGWJEUUwxo3mpZgtgBzoTrFfncSJAoOdpO7Zr85C5hw+v9zkw+fq3rI1neBTWH8uVvqI+tUlwU+cueLPHtqoF/pYRi4bAbPWEI/1AGkR37v3lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xqprI6aslZD6bhbEyRqB+8/486suJhP5M/Kb9k57qnI=;
 b=e1nTInfDGDhxgteQD8vAjtvjcfJWqbWTB1SFwv4ErmPufIabHCoZ1Y6hO8jPWLWEfyPGjPnzu/2L9K6TdaRHc5+b1o1+0SyAOe8VsIle6zHks0hAum1SBfWnRNZ+gfpC7CjqrnH3s7no5HksILX260+9lVVSsFk86rqB0DCGYj0=
Received: from CH0PR04CA0045.namprd04.prod.outlook.com (2603:10b6:610:77::20)
 by SJ2PR12MB7822.namprd12.prod.outlook.com (2603:10b6:a03:4ca::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Thu, 21 Aug
 2025 03:21:59 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:77:cafe::d7) by CH0PR04CA0045.outlook.office365.com
 (2603:10b6:610:77::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Thu,
 21 Aug 2025 03:21:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Thu, 21 Aug 2025 03:21:58 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 22:21:56 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>, Yifan Zhang
 <yifan1.zhang@amd.com>
Subject: [PATCH v2] drm/amdgpu: remove redundant AMDGPU_HAS_VRAM
Date: Thu, 21 Aug 2025 11:21:43 +0800
Message-ID: <20250821032143.3529874-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|SJ2PR12MB7822:EE_
X-MS-Office365-Filtering-Correlation-Id: d1272bf1-64bc-4fee-2d42-08dde061e356
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1a/wBXQfJzwJimi5QUFyPZ3APkMYRQcct4nKbtjrtOuFQP0w03VofCpn405D?=
 =?us-ascii?Q?fevH90b4uxFdaETikAwo1KM2NkTxo0CxAw6E2oInZFN5h/4rc6DMTViShbac?=
 =?us-ascii?Q?MstNVwF7ndoXNXE9yWsMIkE7TnkK/vO/sM7uv87TSFGgp2nIcnMNdBMAhouq?=
 =?us-ascii?Q?8vHiosLClQtc1f/uNAyjaQAWy2wZkn/5Tm8eaC4jgzQlwJuo5pHWQ79HPVec?=
 =?us-ascii?Q?VjValBtHu2jiUMwDqCyB+h5RxTVYnRWaguvZ5fSlkjyhNmxQuFKLIZVnjDDD?=
 =?us-ascii?Q?ffTp1fYbHKcpPvXYHeRYnuWP4ik/zcl1DD60LmuEXqPFMzq9TENys5wQZtuY?=
 =?us-ascii?Q?JVPchL3HXUVleD6q46PsfmTuLjRLU/Dwe8UmH71CPjnWLUFPf27ERTgTdnPf?=
 =?us-ascii?Q?/FN1jBCOFa5xiIxBRZfqSoR13KyVXPC85dMv7HPj8hZf/sOfDAfr3LbkCuA7?=
 =?us-ascii?Q?Lt67d1j6yn2clkI2yE9VetEmd1ELj2Hszi7J4q3Tctx+YgpTtWO5I6aTyy7s?=
 =?us-ascii?Q?3N+E7vUAWTdPhr9zRn+65xqz/gdGu9YQuWa2ipJfIJyD34mY4i9fr6sA+mVs?=
 =?us-ascii?Q?8CSls7erffArhprml8h5xMqhbli6Cj4NDzMZQe2MBEtNXiIaUnNa3D6DRI+q?=
 =?us-ascii?Q?8zPhDn7FD7iPMBfRuH8julu9TtChH4E6Vrtn+0L2gv3gtAO/eB8hFt9HGk7z?=
 =?us-ascii?Q?56xmHoyM3CI445N3UBDvVfhgCJZzxPejVX16S6qz9sgtXdwFSdL282GNgfqA?=
 =?us-ascii?Q?jvb+2z2QDXOdf/dap/FtuiEUw9+5AXZd8m7OOZtJS/F9EHw00orLQdIrgfXX?=
 =?us-ascii?Q?wdKMoNdOU9INih0WAzhNfzuZVJ7kdnG7icXqKmFnDKbZL+g5QFT2/gsJ8GKf?=
 =?us-ascii?Q?/jiBzknxc70JCYKXBUziMgMcrLLgeQyX8zGMVAiZsbYa/7juribQ1gCBllR2?=
 =?us-ascii?Q?Qxm2D6E+n1aLvEfvIMPd2wRsjNzp7tBf0zBmL3mkhQVykHV4KRE2XDkwGuWc?=
 =?us-ascii?Q?/X28CrhDLlOGcrebBiik2ERoWpYt9GLGx26Oqk0Bzie/QJMZpn7LICzuEXwb?=
 =?us-ascii?Q?Yzc3wbGMixW4DRGmThsBkFAn15cff1WOgmFfDZ4ymx62HnYLT4VpJe1V+sHM?=
 =?us-ascii?Q?pc7LGlksryYdoS3WvG4wDzx1NJv/JSzGmjn5m8d6zSs182rvZErG8WD2MmMg?=
 =?us-ascii?Q?Pt8APLef/4C2BE+pDSayehRd22sGY0Tr1j8RbpCRGhES7Kn1eHUBchwxPxlr?=
 =?us-ascii?Q?V50dueKvaGtkf8e8Mt6NUxTY7iFUZvp+X9GkvkmiVBbOgdoxqh2iNuuhQ8MX?=
 =?us-ascii?Q?WLUdql3M50hNmrFwjP5xD2Wp5ymmtLS1h+fNg/f54Df0IhByGxTHK/cfTMdO?=
 =?us-ascii?Q?owMfuzphavcgj33X/njH59tN9oGMcXjV8IIHSY0HllmOEmW/uwMzOtXWrD9I?=
 =?us-ascii?Q?OPRxm4ZV6t3h4t/L20jgCPb5S3cDf43FTeT0Nyzz8VwvSWYcbVYOWroGrYEX?=
 =?us-ascii?Q?N/fFrBRDdQJzd4IV1xX39mVercK0daFJnWv/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 03:21:58.6445 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1272bf1-64bc-4fee-2d42-08dde061e356
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7822
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

AMDGPU_HAS_VRAM is redundant with is_app_apu, as both refer to
APUs with no carve-out. Since AMDGPU_HAS_VRAM only occurs once,
remove AMDGPU_HAS_VRAM definition. The tmr allocation can be covered
with AMDGPU_GEM_DOMAIN_GTT | AMDGPU_GEM_DOMAIN_VRAM in both vram and
non vram ASICs.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 6 ------
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 4 +---
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index ddd472e56f69..01f53700694b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -946,12 +946,6 @@ enum amdgpu_enforce_isolation_mode {
 	AMDGPU_ENFORCE_ISOLATION_NO_CLEANER_SHADER = 3,
 };
 
-
-/*
- * Non-zero (true) if the GPU has VRAM. Zero (false) otherwise.
- */
-#define AMDGPU_HAS_VRAM(_adev) ((_adev)->gmc.real_vram_size)
-
 struct amdgpu_device {
 	struct device			*dev;
 	struct pci_dev			*pdev;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index fa3e55700ad6..d92a73e7f2a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -880,9 +880,7 @@ static int psp_tmr_init(struct psp_context *psp)
 		pptr = amdgpu_sriov_vf(psp->adev) ? &tmr_buf : NULL;
 		ret = amdgpu_bo_create_kernel(psp->adev, tmr_size,
 					      PSP_TMR_ALIGNMENT,
-					      AMDGPU_HAS_VRAM(psp->adev) ?
-					      AMDGPU_GEM_DOMAIN_VRAM :
-					      AMDGPU_GEM_DOMAIN_GTT,
+					      AMDGPU_GEM_DOMAIN_GTT | AMDGPU_GEM_DOMAIN_VRAM,
 					      &psp->tmr_bo, &psp->tmr_mc_addr,
 					      pptr);
 	}
-- 
2.43.0

