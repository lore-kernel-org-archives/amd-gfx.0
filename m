Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2B43C28B24
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Mar 2025 18:46:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95E5710EA7C;
	Thu,  6 Mar 2025 18:46:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C/yCQ8cz";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DB8A10E296
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Mar 2025 18:46:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c2J57lWJwDEnfFkOpJ8FWveRVKT2iC78PPBYAZ3zQvqrL2qT58sJfpYpu1DaKBl4g7qpPuHS7WU1kFL1Ii1P/n7y5PsWzd23d0lSi9vgMuivI+rdxpAEZM6ZMqZE+iB3FFMAxJVCA95a2vZJ8gZxpYLDWwGHmkFH8wxw18fDEr/xMiA3nPCL7XzaPJe1w12zy7jseAPydA+Lmgx1VRv0AEqEf6vgnJvrA2ZGFavZ/4GvPySl6AJ5KOOTKxFU+8JKN+2vUNMZCAaIxJur1Nsogyl7Z0zlawsC2fkubWgj1g+Ucs24sQ/dVq+QKM4OqwJ1rzNalvMVYbnIYPT3XFLQog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p+4znT6orinGyNDxnLfRxsY41IB6XUfdLP1dYb7kozU=;
 b=Ecqx3VhkXbVJFPBrZ05E/u1Tcw1j0IjRkDyXyNJn0FDfDEUV34eT0y9yJavMLo+3+wL7UR9+OZVEuUNO9EBIEeVlb2O6Cc/A2TmynmiLPF5Zx2Odf7G4q3PQf4pqfxdorQUajxKEAAgLQho3AuD6RB2RkvNLl8nKbvDvJxzhDuhlMwkEmyVBfJ6PNeIOovVWvEg0j6G937kFMJ3eDD/rCukn+o7wgytUQqKGeDF3B373XcWirfKQ4R/AxYxfVhGRDeaYVtEEPhbHe7X3ysQ1DOLsYsoj3waX5Wb+Buyl1m5neVsg6BWzhGBdsEqjfZ6xaw6Jd3t5uyBgLWZtFN/T7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+4znT6orinGyNDxnLfRxsY41IB6XUfdLP1dYb7kozU=;
 b=C/yCQ8czbu5WsTGr0qARuJQkUPWfKCJyvDliRcFIxZ6DNyaHnYlmJtXSjmau14iDpyc3olbhs3jKKbDGCQX5tadiqsq0/YNOWZLI6BpnNG4s43F0qRk9TMhFafBwkxcUxOOfpacr9MOht/68j61GnPyMj7ql11odPBnZ+UeRHQ4=
Received: from MN2PR01CA0059.prod.exchangelabs.com (2603:10b6:208:23f::28) by
 CH1PPF16C2BD7B0.namprd12.prod.outlook.com (2603:10b6:61f:fc00::607)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Thu, 6 Mar
 2025 18:46:33 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:208:23f:cafe::36) by MN2PR01CA0059.outlook.office365.com
 (2603:10b6:208:23f::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.17 via Frontend Transport; Thu,
 6 Mar 2025 18:46:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Thu, 6 Mar 2025 18:46:33 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Mar
 2025 12:46:30 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Sunil Khatri
 <sunil.khatri@amd.com>
Subject: [PATCH 11/11] drm/amdgpu/sdma7: add support for disable_kq
Date: Thu, 6 Mar 2025 13:46:11 -0500
Message-ID: <20250306184612.8910-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250306184612.8910-1-alexander.deucher@amd.com>
References: <20250306184612.8910-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|CH1PPF16C2BD7B0:EE_
X-MS-Office365-Filtering-Correlation-Id: 573dd137-a050-41fd-56a4-08dd5cdf3762
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Va4lxicQMzQ9DzcMdf2bKdyMZYp30ZVyd2egdPBMzpcY+KNr1O+LBKduC2KA?=
 =?us-ascii?Q?T4UICnJp4z+kX4iCuLOaniAXP9bQ9OlRR+RQI0ak5MQ3BegLc73aN9KZbKi9?=
 =?us-ascii?Q?0I5gG2PqcgEZ+kTc3Ecq5fUFDdDOlGZk59c7IsCeldeoUdcsLXkteWv0f3Kl?=
 =?us-ascii?Q?Cu1t/Bu9NBmNunBcYyR+fI5WJyo90KCejuJodEkJDL7qg2f/1gBW6zepQrcY?=
 =?us-ascii?Q?wdFf7Z/83CTEYzTqmdhfkIkEmNf8Em3xT4rQnYEt0/MNUCkZHNvgT+JRQ/qZ?=
 =?us-ascii?Q?ZPseIem89LtkwaFBBx5rt6tVlFQ/rKQngxFsIeUKuhaD6Yj4e6w9yDOv6d44?=
 =?us-ascii?Q?DckBnROxCWNUYF7l3pzel8nT9/L2W/LI7W9fCcVhEq8IZbsMKfREGHig87xs?=
 =?us-ascii?Q?/mS1aFLuO3hn2qEasP6MJeUus8NhK2WVCgJL43MqzaaNNoCPuzjBFGPWJqMk?=
 =?us-ascii?Q?Hmgw9brHyG3d9LAVta9AJEElo6tcGQKegykdSbV4xoAm+Yg1Ew3BqRUGNfit?=
 =?us-ascii?Q?hNCQi+JKodQhkdSpNexSIS6vuEFYSfZ/UyuPEkTlHTtehSwrUoNDqxSIhxlm?=
 =?us-ascii?Q?EfIMn+Ov5OZM4qJAZJoXsknqViLHKRDb5MWwXQ2bMR3fq/lNA7MpefLlVScZ?=
 =?us-ascii?Q?BSK/10MirM6O8TGrDEguYVBGHoFoBbfzc2NB/b05sXewzelNIt+M+B9PE93Z?=
 =?us-ascii?Q?L1NkzLF8s2Povvx2tTJvY86ZA/aHKbGB4WXTu1Pi4Jiq2YsagUcvcKB2BHiL?=
 =?us-ascii?Q?o9q8x/eM0rGqFg6U4NazvQ7iY3zGdjr+IgMDmEEjgXnoX6s1/5mLj/Wxts4A?=
 =?us-ascii?Q?Ja8bjCEOZ47m7z+YobW4Fm97+dIVLY/uDUf6tgAnkuNjTJ6atvkVBj4RuabH?=
 =?us-ascii?Q?Hpw6EOyyJUxzRLfLqQfQRpA+UYF95zm0XkDy3TbNeW8xNNbE5hrTD5ngiz6F?=
 =?us-ascii?Q?Zsdhd8LavFymMd8ZZq9UjeEAG5Bkhmwtj7wUuAfxffMY+ClS1snAU6DVIi9S?=
 =?us-ascii?Q?QycgN1UJYrJRbimkwWy58CminTSi0fwoGe62x/L61TEvEAyi12IhXKf3qv9h?=
 =?us-ascii?Q?crJFErtpuv8l0AIzhw6cSBPAZTtUAG2e/XOqbxq2AdaGP5mhAEpmbujueg0f?=
 =?us-ascii?Q?3+HqTPuwlEgKgG3N9XUA+QlINbth8lfJSxDfOzN/HBFnQkpzxloaAf7zH6Dg?=
 =?us-ascii?Q?0Kg5/epXJmBUvdDBRJf26pFwFKb2J2KNP55+FP7oVmYqCLA7XEbMJI7/Q1Vm?=
 =?us-ascii?Q?qBZD23/llyCgLqrC0iXqSmNzPNqXIgt0ZMgk8Yqzd/h4NyIeGlUUQ7eH2Qzb?=
 =?us-ascii?Q?995alh2FquoMDletRobkKTiTNTurLc1NetA0elPRCCc92ondGfQ2eu3LWPH8?=
 =?us-ascii?Q?MNhNbrN8WW/dyZ/+BZLQkspoH5ugEsk1KXXX0lO36+FhgOkJ4IMoEXL3w0S+?=
 =?us-ascii?Q?x9fXbc3SuRBRthYqIO7+1r2XRZefjxl3L6Zi9FDjWoitLUvfNOR6AA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 18:46:33.2663 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 573dd137-a050-41fd-56a4-08dd5cdf3762
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF16C2BD7B0
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

When the parameter is set, disable user submissions
to kernel queues.

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 92a79296708ae..40d45f738c0a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -1316,6 +1316,9 @@ static int sdma_v7_0_early_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int r;
 
+	if (amdgpu_disable_kq == 1)
+		adev->sdma.no_user_submission = true;
+
 	r = amdgpu_sdma_init_microcode(adev, 0, true);
 	if (r) {
 		DRM_ERROR("Failed to init sdma firmware!\n");
@@ -1351,6 +1354,7 @@ static int sdma_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 		ring->ring_obj = NULL;
 		ring->use_doorbell = true;
 		ring->me = i;
+		ring->no_user_submission = adev->sdma.no_user_submission;
 
 		DRM_DEBUG("SDMA %d use_doorbell being set to: [%s]\n", i,
 				ring->use_doorbell?"true":"false");
-- 
2.48.1

