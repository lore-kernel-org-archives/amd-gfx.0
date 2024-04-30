Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E374C19F4F
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Apr 2024 20:34:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 872B0112F28;
	Tue, 30 Apr 2024 20:34:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="t/PmWyJH";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58463112F27
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 20:34:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L/TRQbmVkexbc7PP+z/xlTmX4bvcB5a7gaw48jh2j1p57e/3Z96h9Mnc2Yw8ZCiFOf8DaoSELINKKTJMLw3g34Hs3mfCSIiEvFe0+oPaR2cTxfcXC2b+3sy7qOsfcQqDqFEhua+LBzNcpH2dd3CzqgKhWnnyY7lblUcJT412iNn36K60j+0TDvSi5rtFGrxJ46Sor1RTBmQx7Wm+IkVUIDL6mJoPbMA3l6BGIICsj7P1ifWuQLKMFhI0z1t0CHV/pLvLNArBXTPp1qkAc60o/gbFJVZ4KZ2VXXjX62gPtQ1jVbrMIUfSdyAm/ECUkCdPxt9UFGg1VFVT/pFPRreAHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V/m+Kfdq/A976Y9NqMbb6JI+dh1BZ7GJTJvl3ojwXK4=;
 b=dJpX07V7zbDlYw5VnxOyruikZKSl38IAg8XllZY/vNR0vmwfaFbNzvyCbsRSwBGeIXosVYqLo4H5xUapLWzPmg3KmCL/cPi/6gbyWyaB/y0IzaDATKad6Fg1F7y2Bbzv06Ti5Uds8ufrBM5lfe2oknhMDbDpiBavVCkVEKdoaBHFuvy0Rg4kkvYIu5rceoYQPG1mBnL6Lyey81wgkmjceJhPHmpVrP8TAHYqwClGEXt6bt6MsZmw1a6iA/w1Lr2Lt5X+JfJLSNKqcAwOgp/RJGKnNDl3T9uAjavqozyZyj+T3KwmG7uyFTlgtdpdYlXjPYGRc83uKRtQ0r1HJtqs1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/m+Kfdq/A976Y9NqMbb6JI+dh1BZ7GJTJvl3ojwXK4=;
 b=t/PmWyJHnRYbceMR8HOr2eRMRzwDOVWWVRMZmTzZF1NauRRJntv0+nLai8b7sc3wb/Vy51wxNN8sH7pEQxqtw1vSDemkFYr6LXHewN2X/RiN4aXg7yiTfJwyXNcPNWt0IcfiYGB4hFaUEkEvq8etJWMjChWrl2C8EFQeoXoEf+0=
Received: from BN9P221CA0008.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::30)
 by DS0PR12MB8525.namprd12.prod.outlook.com (2603:10b6:8:159::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32; Tue, 30 Apr
 2024 20:34:23 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:408:10a:cafe::85) by BN9P221CA0008.outlook.office365.com
 (2603:10b6:408:10a::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.25 via Frontend
 Transport; Tue, 30 Apr 2024 20:34:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Tue, 30 Apr 2024 20:34:23 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 30 Apr
 2024 15:34:19 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Kenneth Feng <kenneth.feng@amd.com>, Likun Gao <Likun.Gao@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 4/7] drm/amd/amdgpu: enable perfcounter mgcg and repeater fgcg
Date: Tue, 30 Apr 2024 16:34:02 -0400
Message-ID: <20240430203405.798798-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430203405.798798-1-alexander.deucher@amd.com>
References: <20240430203405.798798-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|DS0PR12MB8525:EE_
X-MS-Office365-Filtering-Correlation-Id: 1102f253-e43a-4030-172a-08dc6954eb9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400014|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nH4i+QtudtY7NzLt6ewOi/PKyhHyGfRqliYOzaMjXfUbaBdEY9mo5baJ/Dtt?=
 =?us-ascii?Q?GuxYiiRu2pV0OrQQtyfj9K238QhXNzIRLKowE8CRlP3u8qpr7To2OxSOwFlY?=
 =?us-ascii?Q?2d1pC0ix6Nc0NeowcmXYMjYskZUwe52jXw70nTFKrCxpUO/itsIaXyB3nfOQ?=
 =?us-ascii?Q?8ZwVrccp7W5U2+PWeFWyIcHG0kayUhdtPiILYDIkRv48QZQEKFYAL9lfqFM/?=
 =?us-ascii?Q?rd8veWFG+DlMM2ugm60zRNLUFr104QqZLybP2+an0c4nf9JUXuKHcaPA0w8E?=
 =?us-ascii?Q?SupVPA46fkJk4QaYdwxfn2yuBN+IdTQmj9Mlg4niflvQdtBGjKlfHN9KU3Q0?=
 =?us-ascii?Q?i8HlqmddOwppqLr38CLipm4LKu3F9Y1l6Yi2ppG2wxlUxEISeg1qtHZ17vWx?=
 =?us-ascii?Q?bXYmWwDvvIALuAvxkT/RqpmDeXzKGca3zNgMyWJ7dpDMuKRlHl/j4Gv8/2/I?=
 =?us-ascii?Q?T0YbgiS6ZU774e4jQfVZ4cheW+VlZxt4afg6qYHb3iFFt3zMqM/Z9Epc5Syg?=
 =?us-ascii?Q?4nEfrYtAdXs2E260YgesKwUYFxQkEIev3RPwOUgAO+JI7/zMFP0qLR6/NR9U?=
 =?us-ascii?Q?MjIBZZ1f/pomvsZxDYI1OfQ2bl6FWT6Vw4b4rmF9O61TB1KAS7zrvyaafqSW?=
 =?us-ascii?Q?2zhEz6QlSWXS4xPROYi8g7cVbuxhqQXYnpJiIdC89DOd4/YsM7aZLz+F2I2o?=
 =?us-ascii?Q?OfDsRey2kB9yBU22r3sbalFjpNhBXxn/ktMBQjlZ3AwiVp6ckZr4Ix13p/Q6?=
 =?us-ascii?Q?TlbbKymdZaWtNXWGZqZofLnerwuBGAjCQYmHX48np2nkoq5RIxEIs8UgLKgM?=
 =?us-ascii?Q?w/lTHv1x1A1WAXefLHtK7Rn01nYzrcTZOjirMKKbhsZtHt9zUTRlQJskizlk?=
 =?us-ascii?Q?GMe4JFtaQEF24eDJPtnthpuinecwbYhpA4yoa6VtUrOZCP6ruu+m6Q7sIlCF?=
 =?us-ascii?Q?+jRq9/yM8FaH+Hyh3THCiYqir9QiIw+Ac45Xiimc0kTNxlP4jMpuLziT9nqH?=
 =?us-ascii?Q?5QSirgps9aiDJp21Jcr/TnPHuuc6losw8+RahUp6v/XxIblSirWWE4w97Byg?=
 =?us-ascii?Q?BqR3kaT4z+f5n4euIdWhAq+buW6qKB78OTXlPwuz8VpbpZhUSnHONoik9i9i?=
 =?us-ascii?Q?z5W7Qo1FtoR++D9ny+xrdr7PWD9XgIWyBkvq4QG1zlmwWWCcUIoXwHsjnejy?=
 =?us-ascii?Q?YdrO87AY5WOmG3pc5dvlqqDxqp8lRu93eKKt5+CTVZt9/styhzBdo7LTignj?=
 =?us-ascii?Q?7o9m1xo7EmJac5OBV4VaT0TsNWw4Xud47ODBFwUeF0rNyom46T35NfJxYRG+?=
 =?us-ascii?Q?c9MOren7XholCVGQJfajyGM+J3TE27DMDaF2XGAIBFnE66/w+zUmkhsv5ECh?=
 =?us-ascii?Q?cIom9lU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 20:34:23.0343 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1102f253-e43a-4030-172a-08dc6954eb9c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8525
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

From: Kenneth Feng <kenneth.feng@amd.com>

enable perfcounter mgcg and repeater fgcg on gc 12.0.1

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 32 ++++++++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/soc24.c     |  4 +++-
 2 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index f7c5b10c753dd..9aeced9d31616 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -3532,7 +3532,20 @@ static void gfx_v12_0_unset_safe_mode(struct amdgpu_device *adev,
 static void gfx_v12_0_update_perf_clk(struct amdgpu_device *adev,
 				      bool enable)
 {
-	/* TODO */
+	uint32_t def, data;
+
+	if (!(adev->cg_flags & AMD_CG_SUPPORT_GFX_PERF_CLK))
+		return;
+
+	def = data = RREG32_SOC15(GC, 0, regRLC_CGTT_MGCG_OVERRIDE);
+
+	if (enable)
+		data &= ~RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK;
+	else
+		data |= RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK;
+
+	if (def != data)
+		WREG32_SOC15(GC, 0, regRLC_CGTT_MGCG_OVERRIDE, data);
 }
 
 static void gfx_v12_0_update_spm_vmid(struct amdgpu_device *adev,
@@ -3763,7 +3776,22 @@ static void gfx_v12_0_update_medium_grain_clock_gating(struct amdgpu_device *ade
 static void gfx_v12_0_update_repeater_fgcg(struct amdgpu_device *adev,
 					   bool enable)
 {
-	/* TODO */
+	uint32_t def, data;
+
+	if (!(adev->cg_flags & AMD_CG_SUPPORT_REPEATER_FGCG))
+		return;
+
+	def = data = RREG32_SOC15(GC, 0, regRLC_CGTT_MGCG_OVERRIDE);
+
+	if (enable)
+		data &= ~(RLC_CGTT_MGCG_OVERRIDE__GFXIP_REPEATER_FGCG_OVERRIDE_MASK |
+				  RLC_CGTT_MGCG_OVERRIDE__RLC_REPEATER_FGCG_OVERRIDE_MASK);
+	else
+		data |= RLC_CGTT_MGCG_OVERRIDE__GFXIP_REPEATER_FGCG_OVERRIDE_MASK |
+				RLC_CGTT_MGCG_OVERRIDE__RLC_REPEATER_FGCG_OVERRIDE_MASK;
+
+	if (def != data)
+		WREG32_SOC15(GC, 0, regRLC_CGTT_MGCG_OVERRIDE, data);
 }
 
 static void gfx_v12_0_update_sram_fgcg(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgpu/soc24.c
index 780e54b74979a..701056a865a4c 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc24.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
@@ -405,7 +405,9 @@ static int soc24_common_early_init(void *handle)
 			AMD_CG_SUPPORT_GFX_CGLS |
 			AMD_CG_SUPPORT_GFX_MGCG |
 			AMD_CG_SUPPORT_GFX_3D_CGCG |
-			AMD_CG_SUPPORT_GFX_3D_CGLS;
+			AMD_CG_SUPPORT_GFX_3D_CGLS |
+			AMD_CG_SUPPORT_REPEATER_FGCG |
+			AMD_CG_SUPPORT_GFX_PERF_CLK;
 		adev->pg_flags = AMD_PG_SUPPORT_VCN |
 			AMD_PG_SUPPORT_JPEG |
 			AMD_PG_SUPPORT_VCN_DPG;
-- 
2.44.0

