Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58205C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Dec 2021 01:34:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA33D10E724;
	Tue, 14 Dec 2021 01:34:52 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD33A10E724
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Dec 2021 01:34:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LAlLR+9zsj7SnJqKPknre9ScYHV1NlhBzq3WpKABWcCCt8gnuhfL/UITDTLfStwyA64aRxKjNeJQYddTlbbQB3Ca3HI6/+NcLmu0hADKxWBaSGRW5geFX6ZPptrvMzLcGFOrfDcl8/6BEeYLF0gA554eBGLhH+FPHkn+GGHtjRwNoU2tNJ7xYwkG9P/eyppnw9/rgXMc7yVipVHX1AYuFaUt/FD30YNriXNBcHOR/F7Xl4aJt4BOm5ETkTkcWDFOlWgqwkowOp6rvMJW0mqtonLkM22YFS51djpWR6VPwaa00sITgZ45RUQjp7rdz5moqakKw+zRhp28vjNoxm+PYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Acvx60hF8fNcQm2sLAK2mbSDCZ5uUG5yclGfUfFfIKc=;
 b=gxrhFHPZ6LYONP5Khg51MRA/ZbAoHn2InZWYvOZeDZBIbPcA5sov7opuvD/ZhDU6+TupKFacFkrk/9BwRiHn1zto1fRBK52z7dt+iD3lb/9HPQPPoygEEvfOfTD4XxlbcGxtT7a/uFB/jTtM+NsRlyTpsFq8qU2srHic0pcdgysaVZdOXsBGvyDL+nQiJazdkQJTmjggojPpoY6AR7/2lB3s+FGHbvbz3OdE/18cPPmLQUrbtzVqW388+ZZgcG1SR6JoX8V1DhAgReIefQvK2h938jHjIxjLPm9A3u/ShwsqZu7a3u+Z6k8lUKxGKLDZZpYZyigBBWqgN0+zJKDoAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Acvx60hF8fNcQm2sLAK2mbSDCZ5uUG5yclGfUfFfIKc=;
 b=IBHB5H6ruUNB0aL6RVN4ERgQsmYiZLsAFZNZWsCj+voNobA0W8xp6CPKBmTOXFq/cmYAGWRtkuQ2dtEr7obU5UQYT+uxq9i7Vq0/Yw2iWJDghG41l9iYEbHRL/npeTjvTzdZMkMf/FGn8E8pDxLAMBy07qI0Olpt9irVf7RoL4w=
Received: from DS7PR06CA0052.namprd06.prod.outlook.com (2603:10b6:8:54::30) by
 CH2PR12MB4262.namprd12.prod.outlook.com (2603:10b6:610:af::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.14; Tue, 14 Dec 2021 01:34:49 +0000
Received: from DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:54:cafe::5) by DS7PR06CA0052.outlook.office365.com
 (2603:10b6:8:54::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12 via Frontend
 Transport; Tue, 14 Dec 2021 01:34:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT012.mail.protection.outlook.com (10.13.173.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Tue, 14 Dec 2021 01:34:48 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 13 Dec
 2021 19:34:46 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: correct the wrong cached state for GMC on PICASSO
Date: Tue, 14 Dec 2021 09:34:23 +0800
Message-ID: <20211214013423.801735-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6ebcb4f-933e-4347-4cb8-08d9bea1eac2
X-MS-TrafficTypeDiagnostic: CH2PR12MB4262:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4262F72E792C0E7BF90C28BAE4759@CH2PR12MB4262.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fY3FB5E2vW7WI789glQJdvSLPpvKEtWKYga7M3IS/ZJ+AHoT1yfVw4mfimUJgFQd+F1OXxJoa1yrimeAkoiuykV0bsxBkS248ShqaNWabwDpIR0ki3sUSJ8sVbJFC1CjcYpWtzjvOnjc9IcwM2kEai0d9Nu8jpldoOojj2oRxoBXcZyTfKVaAfvhVmORtuB7ElW7aLfo5QJmA8ThpUx0C1raJMAby6QcYkCpv1jQ3P8vgSLiZiCJWTNdaL0z0KZRPZp/8Inao4FunBLtbouE2KMfZNS/VvQLY2UuYU16T8ZvSEZWrItxpbgsEouJRp33uIfRZfG4QEeA5pTqMU0Q5dz5g9Yj+TZKbP6L1kWvDQGinlVMtSdOwSp9FHL5OYZdnSL1nsAcmFY+27s6iYyJaadGWDcuVgr87b4RjjocZ4NhikVzGd7GK1/HMC1KeXGj79ISSqsgUnT+of6xPLlA2RoQxnexQ3bWVsUT6M4SphSOLt+8uDoG0iEqtHFDLTqbkfZwFGdOsbFHC2IpTqvGysBwVn8BsRfdXSzfUhpHFqkbKJObgAMvOFrPBsjsE171TIvvO/LT/SpauCTgumnChD6fevxaCUgd2wLYV8tUrafFFtxGkiMajaxI5jLuzBwXareyA+3mN1/pKQynLMv1ilgsTs9Z/JLcm/OjRcVbqdE7fLJaP/JOiJmjEaLTDQD8Bs74RG9JzenkzBlsUas9v/Gv/CiTDrbaenYKO5qy/0MiaE0KD1OiDww4HPHOpCYZ8z+1YCAlJ7aPs63A2mvZ3nVNg2iRu0NtbIaRGY34RU4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(16526019)(186003)(36860700001)(7696005)(26005)(6916009)(83380400001)(426003)(508600001)(1076003)(316002)(966005)(2906002)(47076005)(44832011)(8936002)(86362001)(70586007)(5660300002)(36756003)(70206006)(81166007)(82310400004)(8676002)(2616005)(336012)(54906003)(356005)(40460700001)(6666004)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 01:34:48.6511 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6ebcb4f-933e-4347-4cb8-08d9bea1eac2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4262
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>,
 Mario.Limonciello@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Pair the operations did in GMC ->hw_init and ->hw_fini. That
can help to maintain correct cached state for GMC and avoid
unintention gate operation dropping due to wrong cached state.

BUG: https://gitlab.freedesktop.org/drm/amd/-/issues/1828

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I9976672a64464b86bb45eed0c25c9599d3bb4c06
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c            | 8 ++++++++
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c          | 8 ++++----
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c | 7 ++++++-
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index db2ec84f7237..c7492db3e189 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1809,6 +1809,14 @@ static int gmc_v9_0_hw_fini(void *handle)
 		return 0;
 	}
 
+	/*
+	 * Pair the operations did in gmc_v9_0_hw_init and thus maintain
+	 * a correct cached state for GMC. Otherwise, the "gate" again
+	 * operation on S3 resuming will fail due to wrong cached state.
+	 */
+	if (adev->mmhub.funcs->update_power_gating)
+		adev->mmhub.funcs->update_power_gating(adev, false);
+
 	amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
 	amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
index b3bede1dc41d..1da2ec692057 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
@@ -301,10 +301,10 @@ static void mmhub_v1_0_update_power_gating(struct amdgpu_device *adev,
 	if (amdgpu_sriov_vf(adev))
 		return;
 
-	if (enable && adev->pg_flags & AMD_PG_SUPPORT_MMHUB) {
-		amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_GMC, true);
-
-	}
+	if (adev->pg_flags & AMD_PG_SUPPORT_MMHUB)
+		amdgpu_dpm_set_powergating_by_smu(adev,
+						  AMD_IP_BLOCK_TYPE_GMC,
+						  enable);
 }
 
 static int mmhub_v1_0_gart_enable(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index 3656a77baea4..9953a77cb987 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -1167,7 +1167,12 @@ static int pp_set_powergating_by_smu(void *handle,
 		pp_dpm_powergate_vce(handle, gate);
 		break;
 	case AMD_IP_BLOCK_TYPE_GMC:
-		pp_dpm_powergate_mmhub(handle);
+		/*
+		 * For now, this is only used on PICASSO.
+		 * And only "gate" operation is supported.
+		 */
+		if (gate)
+			pp_dpm_powergate_mmhub(handle);
 		break;
 	case AMD_IP_BLOCK_TYPE_GFX:
 		ret = pp_dpm_powergate_gfx(handle, gate);
-- 
2.29.0

