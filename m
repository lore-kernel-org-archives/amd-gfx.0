Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33C2EC021A0
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2025 15:16:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C724610E8EE;
	Wed, 12 Feb 2025 15:16:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pqLEb6jk";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 240B910E8D8
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Feb 2025 15:16:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X997ar/B8LtP5SUQoXBGRRyTHGelie1LeG1dWKoFO7whLsq6vqS+vedO4wrDnFkRX/0YbrSY72c1IB44731J1IbqXAXTsdZRJi6s3ggHq2IC1T5Kjurg7oIenT1+mur+KB10PXwFfEuXuKAf24vI90bgdNyvTVllhrNjs/Cuqm0sjBfyPDqbM8zzWFurHX2aQ9SnAPq8be5qv+4i0uwFUwxbM+LVFHgSiO3xlr/diORCS8Qq9fA01JEtM6dP01oK8atW3MzAnEfU8jx8b268lLUnIuZWS7w8lSLFGQB9hWOlgLDoev0Im5kN80nk8C8pG5oz6dgOFWJkxI9DjBrgug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nNKA+aeZsn7HKf7IvfIzkhCeiOX3X0pG9vSvLivQMBw=;
 b=FSPrOGU4DEj6R6A1rqiHAmhomzvCLsUVzsqmiSrXheTdzx6lAzTUn5BdkJ8y7AkiBvn3rYfxqdN5sFI6XVf7o76NBH0z1sjrw18ZptIVFKNIXdBdyd0zxqx60xjemV88OJYVaKGeSX4efMHtF1FEm3xvQaxhtneABDFh4MY3DsCyD2/UBLq0ML5iRCgv+4pzlpxZUAYZNjriRC/Y1XDQNWUTclchya983b158NgA/BuJfRWwjZiI26tWQ1Kctb5e+UtIo3KOOblMY21IAxDoBRGr8PEG+vGcYJ2UJM62gFOxYBqed50PAHakRt/9qGaSxZ0NmnJFdfAPw+1OiN4dwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNKA+aeZsn7HKf7IvfIzkhCeiOX3X0pG9vSvLivQMBw=;
 b=pqLEb6jkgumLX/uF/PYSysJ5tek10SMXyG99ZKKHVSm4Apw/uHqalM7zvVA/Wcg1GEc3ldQgvX/elMqAxKVjskWxVADuow134LnNN+r7Fp+9dxWrVIiEhT7KvOc4ufdn2wax1+0VeVG22nqomuW27TB8pGN9La8IrvIBT3G0CUk=
Received: from SA0PR11CA0084.namprd11.prod.outlook.com (2603:10b6:806:d2::29)
 by SA1PR12MB6945.namprd12.prod.outlook.com (2603:10b6:806:24c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Wed, 12 Feb
 2025 15:16:19 +0000
Received: from SA2PEPF00003F61.namprd04.prod.outlook.com
 (2603:10b6:806:d2:cafe::3b) by SA0PR11CA0084.outlook.office365.com
 (2603:10b6:806:d2::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.12 via Frontend Transport; Wed,
 12 Feb 2025 15:16:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F61.mail.protection.outlook.com (10.167.248.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Wed, 12 Feb 2025 15:16:19 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Feb
 2025 09:16:18 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/4] drm/amdgpu/vcn5.0.1: drop dpm power helpers
Date: Wed, 12 Feb 2025 10:15:57 -0500
Message-ID: <20250212151559.2683916-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250212151559.2683916-1-alexander.deucher@amd.com>
References: <20250212151559.2683916-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F61:EE_|SA1PR12MB6945:EE_
X-MS-Office365-Filtering-Correlation-Id: b16db438-1593-4b84-e884-08dd4b7833ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7QVhmJAS6jYWGEzOidYF7zMJZ7De3RjbuJM3GYSm93gtWVWiEqu1VRZ2Yh1O?=
 =?us-ascii?Q?gbldWbj+tZ3KdyWS4QEgozVlffvWVT0zxipMZM3G38RxJHZ9x7SCYwWd2UzB?=
 =?us-ascii?Q?pBG1fprt0jBprg7ZGceMm2acpmgu61p1JO4NwaKwI13LVASfLfRiaOkjdeub?=
 =?us-ascii?Q?z4eqNviG/Q75hXuzR82fuaY5Ubho21iC8zEogf2saqAHJi9U8iR67HoDdpr9?=
 =?us-ascii?Q?d3lS9nHLdWMQAXARTo21DtKZqiRy6XABIL0pi+oOAa6HdQn5a6dYanA/aeXs?=
 =?us-ascii?Q?SAMlvDguDnf5MropQdE7+PlEveGxUpYmScows+cxeoDdnWI6swO5kWmjRNPN?=
 =?us-ascii?Q?rZ29BDPnl0C/3oDX8HAh+leu8fnzYNa5RoC9jH0n+e+1XjbpqmBtCTp93s/x?=
 =?us-ascii?Q?ReboPM0+M6bdVMfWIEvvE2RnCRUzriPRfeHZ/YhkdrmRDWNijSmV9EFQ1YDt?=
 =?us-ascii?Q?lV9dcsysvHMRtwtI5z0sd6gxkPzK2en8oUnu/hO9KK/TqdxWTbsMT8MDjv+W?=
 =?us-ascii?Q?Cz6wKCTytigdFPY5bTn7jFumG4d5q5nN0jUNNAH1KZpSBVoP+2IpSKTzNlix?=
 =?us-ascii?Q?NXOYUYyztcJCC27ymyMlh+KV9EmFxahU22h94UNr1278iUWQrPjRoKB3S4Cv?=
 =?us-ascii?Q?TNrbRkQ3foe3qLSimvtFMdUo2I/stIdPb2EYM+Ux4pUQuHAldivpjbl2XH8F?=
 =?us-ascii?Q?AIlYJww4q85k7j3r4RaBFdEh/g628AS4Qv7o0xaNxeUK7obI2ocFjVwaWysP?=
 =?us-ascii?Q?/sMzN+uTpBwJUn/4YprQgUNgmUcNzKxLB4JrxSv8GhdFO5iS2rSV6ky/n7l1?=
 =?us-ascii?Q?jTfgBi6mEoUOCPN1gSlBklbUfmX7esHmnVD4kHxKTVzjZJzpTNkLHWsX4YT7?=
 =?us-ascii?Q?A8tm2SsNL08FcVAV2ZVNVn11E4rw39rtNoFK+lAeoETIyLdga5RkYEI7S0iU?=
 =?us-ascii?Q?XKM6m3/c/Ew9YwEXiH/rf7WJ7eFmxQACwZPBGwRXIrXkL2F8pBet9UA3uEZ/?=
 =?us-ascii?Q?WQZRK5j9wS368xmmQ8EnqOVJ03B2ZZQjfBMC0aC0Yb/2xc3bExUrHQC0ZLvs?=
 =?us-ascii?Q?wxexWCqaaivjupZfI1G6xIRp/V+lLs3QgnuqrRzIUKQwmJDmoEWZxeDU6EI1?=
 =?us-ascii?Q?Ng3Rlm+G2SQS9vmqb+rvBC5RYq2wV/A67Y6W7YFy5mlK1HrP3fPULmtzXGcH?=
 =?us-ascii?Q?By0BMH/287zT3U5ff71xRTieBRlWJN/iwSz+ViTaNLqJe8iefJ1jBFtPQOA2?=
 =?us-ascii?Q?vJHq6pOt1XdFm9/ZBBMo6X42ZbMCKsEHcJzUQFWF7uUbpqBFTCvVsXcX5j/7?=
 =?us-ascii?Q?ts7J8rilumRGIMD5YQ9iHO1cVlnjk+b0bBNhnQhXO/UkZRP8xYjnXRUF4oBY?=
 =?us-ascii?Q?mlunHwDdP2lSKKhN7WNdDbXKNtSoaPq+XMQOBX467iSXowgFS+sEdVJKGKZe?=
 =?us-ascii?Q?p93vkhttUEFSKiv1HhvP56SIMK1q4ZBVfvz6uzS4UUIqSu9DsdDVqwwgHH4y?=
 =?us-ascii?Q?CbHHvlvEGh5GjBo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 15:16:19.5150 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b16db438-1593-4b84-e884-08dd4b7833ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6945
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

VCN 5.0.1 doesn't support powergating so there is
no need to call these.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index 8b0b3739a5377..288a77179036b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -575,11 +575,6 @@ static int vcn_v5_0_1_start(struct amdgpu_device *adev)
 	uint32_t tmp;
 	int i, j, k, r, vcn_inst;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->pm.dpm_enabled)
-			amdgpu_dpm_enable_vcn(adev, true, i);
-	}
-
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
 
@@ -818,11 +813,6 @@ static int vcn_v5_0_1_stop(struct amdgpu_device *adev)
 		WREG32_SOC15(VCN, vcn_inst, regUVD_STATUS, 0);
 	}
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->pm.dpm_enabled)
-			amdgpu_dpm_enable_vcn(adev, false, i);
-	}
-
 	return 0;
 }
 
-- 
2.48.1

