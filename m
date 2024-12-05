Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35D38E7716D
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2024 04:10:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B972910E381;
	Thu,  5 Dec 2024 04:10:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MnHmUc2U";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E0FF10E381
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Dec 2024 04:10:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ArT8RkGatMBNV5O2kmlq1f5pCv54cNuYFc03SbC7G8mMGB2yFMA86dAXev5tdqPONvL/OigSDZC3iVMFEqb6WrsVRwI5fkUODh45t7h0wnlsEJbp9deKYcVehOdrz45hO3uqNKNgCibzrLz/hHwgpK+aAPUQLbGKtZ0bc9PKwhxZhgCb0Pqix78snFafxfm58YMwTyZn/rM5koGVLGouasj1f5mFUMonbALOuvaAZ7rO8AoVDp7ngQ3IhUbKl46SnOJpnivTIo8AgGOO5yqOPGFEeLjCUWObZeeGgr8DeXyIjNEMBzVZsJHamJSq/yK6SKt7HZ4hIICcV1Q2Vc60+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QcImH0Ng4RMV+hm5WSHFXI1s1fKp814KyIrYRLclCWY=;
 b=wlUmRjjhN6K2CEx9X3xiz/DQnkgiROqRcXETOF9skdDfiW09VjcRc5Xg6167K+4iUdyfZPZnhAsZik2/dhZ5t7UCyBwymrmuGnu0GZZXT3SsdpDF9KZcF+geiKq4N9R5UqvQ2v5ngUboQQAjnrMTTpghZLGPmUsqG9F6GiuA5dllEK+v+XNaklM7EQdOCHYRwrdMpFRvth/KjOHoeY8ux5ZunNuEEnAgRhdIanYHbB15svW2L0G40dlpVT9vVTV2sckP281mEJJBjlRf0d7A4mx+EvlwKxnbM2eXpmCkNSyOFDyzknlYR2aVPaCKWgBr8qINPDIcyZhu+FYD4BTqog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QcImH0Ng4RMV+hm5WSHFXI1s1fKp814KyIrYRLclCWY=;
 b=MnHmUc2UaadE0qee+LI9QC8fawNn2i2wkv3DkvwE4we3RYXx7A81/V1KzWrhyyDrHIcn6GKBdkZ1TQC5QcS8ytaO5nPp1QQzt0Oe1vgXUGMqsmkR71UiHqGaBfJAknDTPpk0+GX6TEvXmiwdtKFYzIsl12Nvqx8B/nUY1fT2Iok=
Received: from DS7PR05CA0001.namprd05.prod.outlook.com (2603:10b6:5:3b9::6) by
 PH8PR12MB6986.namprd12.prod.outlook.com (2603:10b6:510:1bd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Thu, 5 Dec
 2024 04:10:45 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:5:3b9:cafe::53) by DS7PR05CA0001.outlook.office365.com
 (2603:10b6:5:3b9::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.9 via Frontend Transport; Thu, 5
 Dec 2024 04:10:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Thu, 5 Dec 2024 04:10:45 +0000
Received: from canli-build.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Dec
 2024 22:10:43 -0600
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Candice Li <candice.li@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Check umc ras_if init to disable gmc v12_0
 ecc_irq
Date: Thu, 5 Dec 2024 12:10:11 +0800
Message-ID: <20241205041011.3972062-2-candice.li@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241205041011.3972062-1-candice.li@amd.com>
References: <20241205041011.3972062-1-candice.li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|PH8PR12MB6986:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d94d08d-04fb-417f-6522-08dd14e2caaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?g+v8G9AEPKMlYfNtYxEkgKknW79uTdfcb9sq+Ub+Pe3X9lj9EP5sMzXHHcEG?=
 =?us-ascii?Q?F9PfOFE0XPw7KtGBDILL3C5H8QfTjz7G84ijuEOPq5sFtQ/iBpceNqaozrQQ?=
 =?us-ascii?Q?AExbPfgE+Py3pse88yhHvRFvUPFhEqv+TRcNE8ftwK9c0+zJXhkTvngrNiWH?=
 =?us-ascii?Q?j+/6CCfMoNmkzjffvgOmD2Jc6yKSENbs6R47HEqXA1BCuoOgfcYN1dc0t7Gi?=
 =?us-ascii?Q?B8MHJPwuOq2iHiojBb7hBxqTqaKw0K8YE4Iv+1JRNyLHVPyswAzp3qxoH0MG?=
 =?us-ascii?Q?gkMA6vOHqmMz335ABxdvHpUCr3wE1fG4oJ9nItxj74idU7oUrcV9lEDfa6WD?=
 =?us-ascii?Q?ozvh0I9T6OdQkCTKknnS18BpJHhMU33i693XBTpHAWhGWxrWTvNoks14bhjU?=
 =?us-ascii?Q?drYq5zGuyxUvJ6ngAFR/vvmqcejSnTz1UNz/ycb+FOGyUDeAZf/jV+9oXxAZ?=
 =?us-ascii?Q?1WQnipjeihnBrWeLkCjHrH2pPFtn8b0e2h4iSTZFutwH1CdNkm2Rfl3x+q+I?=
 =?us-ascii?Q?G0dGCEWKzmuo3TmNpRoDv7D6++u3kEDro1m7SmuFUsKdGhs4abTcAl2mM6Dw?=
 =?us-ascii?Q?BzRvl8rjnRuzyJ+qEsRCVK6R0JLC0iuLkDD+8IkscFyFVWTXroEHn9VJCs19?=
 =?us-ascii?Q?b0iWgTJ4eXkLZgzOOf6VlJPlJMH1emRcO/HyzJfPLv/0ifcsr+o314khDqOh?=
 =?us-ascii?Q?o2ldhEYjy1ZLM6SK69zn99hLLWtmIc9m0VkzicYLWAshnXFfDDdWeSojaQo7?=
 =?us-ascii?Q?ckgzeF+eZLmqEZ1ky/7+Dp/RWHde9mjIoZW6ufiXBiPj00Hrl0RiZL4Mt1Oh?=
 =?us-ascii?Q?Bh5d8Rk2KYu7C3wCeB32BietOnSF/NeJbbX2+tWBXawPyAqiRl/RaxT02v4D?=
 =?us-ascii?Q?5A6JShGFONDUXIRUPP6Vkm5u9ViGoefqfF7g2krjReVVUMEVKv8Sf11D36jL?=
 =?us-ascii?Q?0z1R8e+BCeZqVUMvcRUfh/iantzPiCZpmiec7aOq+5iXGy/RjjL9FDGGG5Ln?=
 =?us-ascii?Q?GS4C/3p6pm7ryotj5eWnAwNwwcnHjLR3jCrSW3k/rEV1d5Kqb/KzgPbYSQtE?=
 =?us-ascii?Q?f2Peb7mizfDB/snTT9UhdtOVDwhG25Xto52LNXbgsA3eDOXQFokPh2a9P160?=
 =?us-ascii?Q?vY0V28a5c3F72oYtdUjNc+Dx80zx0E8a154tkhi1TiDWdi3Ar34oyytla004?=
 =?us-ascii?Q?sGjXSBzAcEopjJEpzh84Rwd6U9OKhOkFMgDUyK5MOszageJz/zyQWYBKZHms?=
 =?us-ascii?Q?pG71Km/wrsc3gxLBJF4Y0BWssWZOaHcyMeCuMCTQnI38LDMz4kF5LG+LUOXM?=
 =?us-ascii?Q?gzseF1rl26OQcXcboIPqtD9JkV3xU7ZUm+jZss0d1tKifscXsiAQzN8gDWO3?=
 =?us-ascii?Q?XN8ASkf2pPmXR8+6bHgLHMCx2Yfz/9mxLK22vtIttvLh3eyvLbipH0dtUan/?=
 =?us-ascii?Q?0ySapeW3aieH+fWV9QZUrtuxBTIGYZC3?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 04:10:45.0713 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d94d08d-04fb-417f-6522-08dd14e2caaa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6986
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

Instead of checking umc ras supported.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 621769255ffac2..37c4644f5ebc36 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -939,8 +939,7 @@ static int gmc_v12_0_hw_fini(struct amdgpu_ip_block *ip_block)
 
 	amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
 
-	if (adev->gmc.ecc_irq.funcs &&
-		amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__UMC))
+	if (adev->gmc.ecc_irq.funcs && adev->umc.ras_if)
 		amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
 
 	gmc_v12_0_gart_disable(adev);
-- 
2.25.1

