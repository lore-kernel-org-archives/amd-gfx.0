Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 202C4CA0EF5
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Aug 2025 08:31:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B58B810E25E;
	Tue, 19 Aug 2025 08:31:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gKJwBvzB";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBB4910E56C
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Aug 2025 08:31:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fReQl+RS0Ovgmg7Mt7dIOnXFkkMFOoqLSqWJ4IZYZiCt3kglnwkB872qXCOw7ywlS3KCCJ6UfcBW7/EJyoaCunVpWmH2VBGpmBYzEj6y558UfbkJ5RnYtIFNMt6vhFMD5pp7ULy5e3F9S909NYVPXMPOGBkZpgUprZ2SU9yCpGQc4MfUIS09MaNuBsfEy/lDpXFxki86r5a0jZ1Hn+hbtt8WuGSgI5IC1sx5UWudiEwE1DsetIL2/KmYxhGd2nvgQXwTvJ5p8h2guiznN+s685YG14xgkQinQN50I37pagQC/T5ShYytCzBVCLXggFu4UXdF+WUF32SeFAfiITu/4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PGWcgRtkC4SOOtotriYVEj8N4b4sawfruQfIjrox6gg=;
 b=oT3IaOuZrveaC8e0yaWS+k/0wUgc7qwyQ09LON7wcqmMprdMDLCkcpTA3Yc968xsudOipzXt4UldrlguPWS2rIfFMtid9vtwVgYnn5SHKGZMN0rURgpzw+UrtuWL1C5LAfaVbzuosrkR2nY03JqcgLf0GcEx6NKqsQPppKRv4+FmMRpBn2Dt45ph4BMvb2GykxIzyUdFDh/fDFFhmdOa21eRgtgstuV8J5Vcwndl0VgbMGWHI60qMd1Shu/7dVZNt/KCN3D4CbGjq7aPZpHYl1EGOy0UPUvDkGneMAtyPv5XjSjLHESZOQTn9I6PGZUyO+k9Dj0i3p86gzVvYRglQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PGWcgRtkC4SOOtotriYVEj8N4b4sawfruQfIjrox6gg=;
 b=gKJwBvzB8pM4dOaXE5C8D+9B6zxr5uScpzpbwQj1sMocof5U+9szwWacBJzsEgh3DVktbaVgSPn/nGVm3wt0CG3p420DKS7J9onFJTq/vkHUG/AUxF6NSC+c4aB+z5l93fS3oa61p3c0EjxBsILjUVZ429kBKXitSn+x4bBm9Y0=
Received: from BLAPR03CA0045.namprd03.prod.outlook.com (2603:10b6:208:32d::20)
 by SA0PR12MB4397.namprd12.prod.outlook.com (2603:10b6:806:93::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 08:31:32 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:208:32d:cafe::25) by BLAPR03CA0045.outlook.office365.com
 (2603:10b6:208:32d::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.20 via Frontend Transport; Tue,
 19 Aug 2025 08:31:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Tue, 19 Aug 2025 08:31:31 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 19 Aug 2025 03:31:30 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Le Ma <Le.Ma@amd.com>
CC: Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Allocate psp fw private buffer in vram
Date: Tue, 19 Aug 2025 16:31:18 +0800
Message-ID: <20250819083118.26717-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|SA0PR12MB4397:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bc52936-ee19-48a9-45de-08dddefaccfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lPVN0n6veyyFb79W4QqmvoXJCjLijcAAGUoZKAOkrlmcv55tt0EQsWrj9/ip?=
 =?us-ascii?Q?C83pP4s2onGdohm4rCT+rtsfOs9jeX8YqUIapLrZVBmFREv4Njt6mbGYiDIO?=
 =?us-ascii?Q?r7MyNdv5grRMWkqOZNeZkAqSPi+zyyZbZb18fOZlPJxOM1EBR4uZ4YU6cFOX?=
 =?us-ascii?Q?UPuQlzmfID6WKPmx4nrwCjF8aaFbJUrgDFJCknFNazKWxTSSnd7PZhE7Qtdn?=
 =?us-ascii?Q?jZmsIahnE6mlw3FtjQwzofrjFMezVkdjiOpQCD0qdtjGRjGk6V52CcqBE0l2?=
 =?us-ascii?Q?K6KOaI9oF9PuwhH4VmnLfRsEzOHv0gP1HkROOxu5kEXoTqdciZnNPFeyzhsa?=
 =?us-ascii?Q?GmErIWsyVYQAEu9o/+vZ7It+za+ct9hGaD5Rz0biBxHKJdvTX/w8Hs9JMaD8?=
 =?us-ascii?Q?XefMG+G8ZuP17utrF59X655cwGZuHsl0twd/G4z5WYQRUC9NlnhnGJnjiBNn?=
 =?us-ascii?Q?f5I89rD9o3VHAf9f2Y3QnUGoO2dPQqLASoXLVuLJfYmCDMtSmvfFqh2YgjkS?=
 =?us-ascii?Q?oi6oyJqpjyCrnEGksSgOtWZ/k71r+eiPUR7WkAXM/s8dBtCnhmKFJbeqPS3Z?=
 =?us-ascii?Q?gvexB15AN5drCTbjlbxZsC3bd/drQYOZkoU2B6a5mGXwJF6omjPUK6L7bjN8?=
 =?us-ascii?Q?HRVSkPdNPnCueU605tuV23vIZiQ+oz7XC7jREHUzE+dZZ3ogigJNuLvjKjmj?=
 =?us-ascii?Q?OCW11o9ZmcTfVi7dNqrOQYSSpgTpLYuUubfbcAPIr/3d4qRDH0ELzlvWZqwD?=
 =?us-ascii?Q?5nQhRkkQbkDXDeZEYX/hKLzzKmR2Em5rDxIoLEwJP3yDKqxk1xUKgM1ICmWW?=
 =?us-ascii?Q?8w6gM1+fBuQs0Opt322gn4AP/dvBqxas1OeVgLiZuQj+XFXwcm/nCCdjvxPT?=
 =?us-ascii?Q?1hmeoVsAJW1wUUZcAuJ8gbd2tK5AesG07bb4WQVC9VbFlMrrKcKJldSx9fX3?=
 =?us-ascii?Q?8pinqA5XEPrWw6zkEGGwjeDo6a0MWL2uerQ6AfjSGknZFkzDAyOfwz6kJKc8?=
 =?us-ascii?Q?j6hh79el4yc4v8NIv30K+qVKK3DKxJc1b0+SWsC9IiU7JeND+MzmgXTPXjY2?=
 =?us-ascii?Q?71PecWICuC5J3Wg0LmnKJuo4WbB5tJEFpk148kVe2o4GDy0sr8SrX3Ma4edq?=
 =?us-ascii?Q?6y4VFsDN+odYoV+OcAb7O6MaJDUG2h4NmMCpseknBHI/JV9IGMM3SqZ8Ndk+?=
 =?us-ascii?Q?53H92urlxP8R5R4zzpo86XQ/a3sFJEXQXR8XxZetaZkTL1UO5/nLjiofSkLb?=
 =?us-ascii?Q?RJWGddkK/2rE9cgzMlT2yqEt21HzR6jEncokNBlXZI1aGn5RJlVExt8hcG/S?=
 =?us-ascii?Q?lmaPHwFC9gjpgbHPliLurABNlKA2Wt1Mqemd+E/4UnWO0GEUx3a/wam/+kNB?=
 =?us-ascii?Q?zbHsuCCk6jlRYSEGVvY1fXUle29hk4aC/BnIIxvGxU5hup9vsaO6IZZ2UtQ2?=
 =?us-ascii?Q?+8OUcEApniVFi5S44UuwZenDE6BZa8iViZcLvZONeHevJO6qGU5Eml64eSff?=
 =?us-ascii?Q?w7ggtpIdjeYanH6K7JZMZ7V1sw7hNJzyvKSy?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 08:31:31.8265 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bc52936-ee19-48a9-45de-08dddefaccfb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4397
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

It's not necessarily to allocate psp firmware private
buffer in different memory domain in sriov and bare
metal environment

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 04dedf38eb0d..d53700c87a5e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -506,8 +506,7 @@ static int psp_sw_init(struct amdgpu_ip_block *ip_block)
 	}
 
 	ret = amdgpu_bo_create_kernel(adev, PSP_1_MEG, PSP_1_MEG,
-				      (amdgpu_sriov_vf(adev) || adev->debug_use_vram_fw_buf) ?
-				      AMDGPU_GEM_DOMAIN_VRAM : AMDGPU_GEM_DOMAIN_GTT,
+				      AMDGPU_GEM_DOMAIN_VRAM,
 				      &psp->fw_pri_bo,
 				      &psp->fw_pri_mc_addr,
 				      &psp->fw_pri_buf);
-- 
2.17.1

