Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CA81E77183
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2024 22:54:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE4CB10E9F1;
	Tue, 10 Dec 2024 22:54:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uFa5fCEr";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2049.outbound.protection.outlook.com [40.107.102.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CCBB10E9ED
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2024 22:54:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fbb0jTjgwjcQL6V0pLtUPeqkTUDquQVCpX/fUTFO9nG9Oc8vpeWBcL5ePs2hKOhqX2sbybJC0j1kqEIVGPj6gwKetfJmY9DG0gU6AOVhxuhcGXYdm0qpQKhV81rFhJ7EXy8OHfpfyR26B7gZHJBrBP7ngcZCtOsmqRA2Nx6alVhd2YO7IbPtgJ1wuY51HxIGSP07ZCF9Aap5xgoosX9AC255bzDkaka+cdcrLyNV7N1Kdgzu3dKIlXdEZVq/SMUMYRCgS/+veSTx2SQWDSpw0Mx2miNYNcICfcALO9L/ttKEYDVGVS4Dn6CRbrYeWnNbkBcApaoEB1IF+F04Jmumig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rmyZRfOtQhRglFD3MHiV1fatPybLGyc09/NCE8PMf88=;
 b=U8UWDlouV/QzGNqsU7rdcljbv/L7Si5icRMJgstqfFOugMVwPlMf8tugmm1+YCT0/QIHZvHCB10qfbjI1AUCPLJXb5ZxW4+RGcF4Y7bAbCtTkLiOyuxCLwDTUGRlJpQ0QW/8Y2r4ImeG1mdwQclJAJO1JVTAxjd16+0O0zBIPJO2oDTQnJUhWIB2EF48x8kqjmLLyRGzBGZKRFBMsbgmgselKurW3/Gde0TKqJ1qmG/Hj2DqyrhFvV9FAA33TFiOTnw6Y0F8uZbDbwhi6Z7H0OzsVBM8LgD41TaYMQWS0KJ6A7UxJxD+ZAsiWgGXqNTsfKUMnG8Ra9ecbSuU1zHLfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rmyZRfOtQhRglFD3MHiV1fatPybLGyc09/NCE8PMf88=;
 b=uFa5fCErUtpLEL17iVfpmzATXiESiKsDhL/cxxpmNcEFmpZRsnU95lljbkXStVx8n1CoIlsTWycCDgtUgJPbGuobmNkyXsTtIjdpXxhwLtC+V6g5hKHDdgTC/7RBqToSkq/woEebeBYVD4cwfTLBnYR6de3ho0pBPLmO7nQ5fw4=
Received: from MN2PR01CA0031.prod.exchangelabs.com (2603:10b6:208:10c::44) by
 IA1PR12MB6140.namprd12.prod.outlook.com (2603:10b6:208:3e8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.24; Tue, 10 Dec
 2024 22:54:14 +0000
Received: from BN2PEPF000055E1.namprd21.prod.outlook.com
 (2603:10b6:208:10c:cafe::f8) by MN2PR01CA0031.outlook.office365.com
 (2603:10b6:208:10c::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.14 via Frontend Transport; Tue,
 10 Dec 2024 22:54:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055E1.mail.protection.outlook.com (10.167.245.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8272.0 via Frontend Transport; Tue, 10 Dec 2024 22:54:14 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 16:54:10 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 34/48] drm/amdgpu/vcn1.0: use generic set_power_gating_state
 helper
Date: Tue, 10 Dec 2024 17:53:23 -0500
Message-ID: <20241210225337.75394-35-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241210225337.75394-1-alexander.deucher@amd.com>
References: <20241210225337.75394-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E1:EE_|IA1PR12MB6140:EE_
X-MS-Office365-Filtering-Correlation-Id: a36732c3-dd0f-432f-f6da-08dd196d91d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Rd+4IHuAFxAynk9D2DtJAWFxyGj9wM/Hmz751jVxYUJ8QadbHxu5NoL7Fyr6?=
 =?us-ascii?Q?aMy8kwphMm5d+S2e2VkB1roOBnBJXz40/XaEjAQvxUoFsct/QyAMNCSYpEKi?=
 =?us-ascii?Q?Ax5mYyb2PmRYRhG7eO2zP2kYOMsG4W9h8KGT0TpK8EpGCCpmMczmc4s4yytw?=
 =?us-ascii?Q?0FoyzU8clilwhIECaZPcPIqOfveLhVZVvNDkW3JR1uuu2kL/oM/nY1XoxETX?=
 =?us-ascii?Q?w1PCWN3MyLtsKRFSaZm3aRynB2VtZBe8pqAudmxjGKFjYKcN0+FgOKEYQkdj?=
 =?us-ascii?Q?os6zyO4pflWKDJHets4obljNV1IK8ekEYw5V/NaHUxdDpJxvGr7TrsvdgKMf?=
 =?us-ascii?Q?uwjrXuxTcwF8U5xATpCigH1cNJTUcIiBozbjTuxf/4WtZHBINdyktSZeXREC?=
 =?us-ascii?Q?E1nG1NsTyivksMvNOjn5wNTOi4c4NikIKwoeAOI9OIQosfLfciWpDDCRf57A?=
 =?us-ascii?Q?fpf5lKc+mFC259EhombDa6ww0+qZ9GpdIPULWn1s1MpwEA4qdw/waljrt/2r?=
 =?us-ascii?Q?uQD+w1giWBMAh33nKf6PpZaMJYgt9D++65Gyl7cjAAUdjzl4Vy2mKX45IEDZ?=
 =?us-ascii?Q?3Bz4/HXGtmAzthJ/ObPDJLolRK6Wi01q1I//aaO39xErN56UzfW+zbWQipeP?=
 =?us-ascii?Q?c8xocJJS6CTmjRjIYz5TZ0D8t65/LIUGszM3segvj2y/IWdAIa64R5SpeIvV?=
 =?us-ascii?Q?KeZqjM5ZiNvi4rufGnvEhi8ViI54M+6dxlmc2aHR18q6g9C8PvAGphu+twbK?=
 =?us-ascii?Q?eka7AxOSayI7J/Q5FplZEPoRtjyzQQB4FAX7ZglyOVng9KBBBx7Tvn1jxwZW?=
 =?us-ascii?Q?rn18z3wLiaJFtryojlkXJ6Er4GeAL5bjah0MaXPdaBFOHTqMyoSJ/ND4JfdV?=
 =?us-ascii?Q?C5f7mkuClhntO2cl4bpQk0EiyANIT12SL7bIKMv2Uyfd3VPOAObxHlW69Hvz?=
 =?us-ascii?Q?pXMSgoLX3LRh3kPs1bgSPUqv2icEZw2yNXftqco33fJpMBw0CusnltcQtehf?=
 =?us-ascii?Q?T236O5ED+Ukjf664r0HRpG2uTvy2CHPqTALBZ0zrCUF/wBloCtfoyZ+tGBdp?=
 =?us-ascii?Q?tYviUzql7IntUJsvJspNjXFEdjGfYTeWtzDuX44tcAOYO1cjY5rkal1T2Zkk?=
 =?us-ascii?Q?NMH8RrkriqjOLBGU95ohaJD5TTzPiYxQNqgxD/yl/WW9M3chTFtmm2SxY5G8?=
 =?us-ascii?Q?FRBCyP580HTQIakzALVnPuMDD7/cFoGTdILbx21uOJMj47ZLraje9yRvKSRt?=
 =?us-ascii?Q?QVkOr5hdB9k378I6IUvdFlMPVsErQOSfph7iNgedQpmifp7NqIlPAd9Y7Kpq?=
 =?us-ascii?Q?1fCL+5ksFnVhrcHV4R2SOOUX2FdiG7M73tweg5ht+rb0h+YnSVdAnd1ZnyoQ?=
 =?us-ascii?Q?hXaRV760Aq2QZXYCMF3o51Uzr4s6ysQxaJ57JXWOrUg8Dcqvcg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 22:54:14.4701 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a36732c3-dd0f-432f-f6da-08dd196d91d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055E1.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6140
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

No need for an IP specific version.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 670851166a805..f4f794f7226e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -87,8 +87,6 @@ static void vcn_v1_0_set_enc_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v1_0_set_irq_funcs(struct amdgpu_device *adev);
 static int vcn_v1_0_set_pg_state(struct amdgpu_vcn_inst *vinst,
 				 enum amd_powergating_state state);
-static int vcn_v1_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
-				enum amd_powergating_state state);
 static int vcn_v1_0_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
 				   struct dpg_pause_state *new_state);
 
@@ -1847,15 +1845,6 @@ static int vcn_v1_0_set_pg_state(struct amdgpu_vcn_inst *vinst,
 	return ret;
 }
 
-static int vcn_v1_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
-					  enum amd_powergating_state state)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-	struct amdgpu_vcn_inst *vinst = adev->vcn.inst;
-
-	return vinst->set_pg_state(vinst, state);
-}
-
 static void vcn_v1_0_idle_work_handler(struct work_struct *work)
 {
 	struct amdgpu_vcn_inst *vcn_inst =
@@ -2028,7 +2017,7 @@ static const struct amd_ip_funcs vcn_v1_0_ip_funcs = {
 	.is_idle = vcn_v1_0_is_idle,
 	.wait_for_idle = vcn_v1_0_wait_for_idle,
 	.set_clockgating_state = vcn_v1_0_set_clockgating_state,
-	.set_powergating_state = vcn_v1_0_set_powergating_state,
+	.set_powergating_state = vcn_set_powergating_state,
 	.dump_ip_state = vcn_v1_0_dump_ip_state,
 	.print_ip_state = vcn_v1_0_print_ip_state,
 };
-- 
2.47.1

