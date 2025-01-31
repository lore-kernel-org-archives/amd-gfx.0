Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78250C0219C
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2025 16:58:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34CF610E3F0;
	Fri, 31 Jan 2025 16:58:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="34ckFk/b";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B701210E3DC
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2025 16:58:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=md6LTJU2WiFiZFFZuz2IDL8+vYTBwP589lZ6l4Jb2B9fK8+rDzpIKOfJ+Urz7lsqhUzU4Rr6Y2+nN/dzGXGGKkfhckOIbOiqCGb7AAyjkPSyqaXltlmBHYNgkNCeh59ks33FHE3RndFhD5TYASRlQc7FPRQCCHI4nheBhevvvzh86fMHJ5n/KofU4WyaQFvd+eeSsXxumFXO+nowCk+bmhIZ+Wq5YKeyhfoiF1nIDhSn0l+q5CjqL1J52aion///nZOrmSbwFQManfv1UqbRat2gIvU/XIQT1rD8t+GoQrDzB63mA36ot2xwEQeGyIXKmN50wbEz6v1gmUcC0zA5QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zhiVpKzXzQxrA44Y3+13JoCh/noSUEhSjVvItlufRtk=;
 b=grqUWKTx372kJjWR7FieBasiCrpPNH9kU/650fI3kB17ehQTs7+XRP7JDFET0kVoALNWJnaSVvcK7/X1muZDrsZRi4eThXBcQNo/9k2li4djZ+TA1N0Hz930AzhxrN5AfzDIcDDfbETFwlkc6CHUT1cTEL63I3D1hO4iZSCKt5rkdyVV35FubhjCM1NZwIKBsFeSmoO3NMCMaYxqIILid/hN4DhPMh4vtUxTUnNgoAEzq9XvW9SiH6SDCir49B1u1Ug4KgxsVa5ZFli3guwsQ8FTnFiO+Gwi6XpkCJgScuy2a5JKywqyAyUY0m4hZGTRgBUHFIB0nGwXgYnccyas8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zhiVpKzXzQxrA44Y3+13JoCh/noSUEhSjVvItlufRtk=;
 b=34ckFk/bZ/dwH7Dhmp/XYw8tpJtcR89Huo6erjCT2glCJb6TBX3jWtyRWmkxSNEAkWH2HlTgPGvHyJKP4LayYzFw3+llCVOw+BpBWqezYVxeggRiOzKRHqV/a/ypdgWAKajfDoyZ2apaGN4o+zDk9sb8Z1hLq4nv1hmYfnmEPQM=
Received: from DM6PR05CA0049.namprd05.prod.outlook.com (2603:10b6:5:335::18)
 by PH0PR12MB7861.namprd12.prod.outlook.com (2603:10b6:510:26e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.21; Fri, 31 Jan
 2025 16:58:26 +0000
Received: from DS2PEPF0000343E.namprd02.prod.outlook.com
 (2603:10b6:5:335:cafe::a7) by DM6PR05CA0049.outlook.office365.com
 (2603:10b6:5:335::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.21 via Frontend Transport; Fri,
 31 Jan 2025 16:58:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343E.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 31 Jan 2025 16:58:25 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 31 Jan
 2025 10:58:21 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 36/44] drm/amdgpu/vcn2.5: use generic set_power_gating_state
 helper
Date: Fri, 31 Jan 2025 11:57:32 -0500
Message-ID: <20250131165741.1798488-37-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250131165741.1798488-1-alexander.deucher@amd.com>
References: <20250131165741.1798488-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343E:EE_|PH0PR12MB7861:EE_
X-MS-Office365-Filtering-Correlation-Id: 13b3763d-46a3-46e4-ab46-08dd42187a68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OVf56EzhiO6pxj2jRS1jy3RN+/RiiM8A8rrMSFHay5xKx9w03VyD6DUB2BFO?=
 =?us-ascii?Q?p6b5mdGRFkSmcxhnvvQDfozB7ykQvtu67cixy1GZR0j6MTwKlStTiCsCuiOz?=
 =?us-ascii?Q?h0hb6EBAhDz4USCuSE9iK6HI00PxUtnuq/lgSy6VrT/goOj8OkREk+1A5X//?=
 =?us-ascii?Q?RDNIR5Eb+ckxbp3DZJS7BBKOsj9wvjs7iudu75DVJOme7pXcaoCY+Mn3pDa7?=
 =?us-ascii?Q?nNraZWXtIleo9UDTYLOOyE+eaylE6C6bH/5QzXzS87UfvqHaMUfmOmSxieu4?=
 =?us-ascii?Q?nD/DXI/mU713eXU1LaleyTDl/EwwOw9DerwOgPdHAZpWNfKR3w7q20FNYmqB?=
 =?us-ascii?Q?Da2TUQKO2oJyAV+0EF8kugOPybZe/mKg6oss/9fJG2okr2b2QZJKhuo2r0r/?=
 =?us-ascii?Q?Fc6u7G7KXEzJi09AyQkhtmYPdc+IJ3H5qy0Q8xiW8CMnJK3UBTEutxB7FZwd?=
 =?us-ascii?Q?amqW58YMxCP8Iqk1Eh9nEvh7s1BbL4euRf0a4EudkwLanXugfPL3s7/UqSM/?=
 =?us-ascii?Q?Od9o1FcNeCv3Dcicd9QqcO4ItEqO8E3fAM6fi5gxiz+xBj0H0jbuY6e6W0YL?=
 =?us-ascii?Q?iF8TGdaDeAWUVO9jiehBMMLn7whagQA+L0BNxFqGTCFett7j0aH1SgzrM6Nr?=
 =?us-ascii?Q?CgfwXI8QH01wG4TnHbM9MV3gptB8kZsWzDYOZ+t9AFXkFq6lGVhrYfmL+xOC?=
 =?us-ascii?Q?Ipjhlv6ubFWNReg4zAJ0VBWE4n0Vs2MIpbQ6jr7yr2sUDmiHmpO9d9/eCMPy?=
 =?us-ascii?Q?MLT6QAcm+zkZrmv4yNfI+eKKl/E1Z82iP5extjkO1kHf9SEFjXAQxl2FHbRy?=
 =?us-ascii?Q?C1gQ7TVa7rBehn0hUrFQZB2UHzIkl/5aUBhQF1ptlVzk8qcz1qkUpdeE/UPt?=
 =?us-ascii?Q?uRBjaf7Py9msHybKy8zwAcJX40woNL6ht8kJ4xWNLCHwPqIdYdWVzOXnD9Ek?=
 =?us-ascii?Q?cXU1GbBUUL63Tpv5tdo6/I1+3HqYPDMl14kBu3IRlN9mER9Ea5hy0cgD6pNY?=
 =?us-ascii?Q?Dr/o34PEG+49uFVdNJO+192/9BthuRbctOU3TGdUa633cShJ7VNQZwAajwyM?=
 =?us-ascii?Q?1qFbM4n1Cl4HE0V1uDjxrttBXe1c3KLEBapArBqRRCX2GNds43W1lTckXUYI?=
 =?us-ascii?Q?OfSb+LilrobM1UDcWqny8WuGwopX3UjKCRyhIOszwcyrLuCSQbi31YvmLnUL?=
 =?us-ascii?Q?ZrRQfb7ccXKia9vdOUlC5xaZxzAT/WribaqaPdPRJ55wHzqafgneKk1cXwa+?=
 =?us-ascii?Q?1k8/gejkEmkvRe8pqCNucgCJi7iCCgt5bDUxl4jgGV8SCr+pPOrOnsYV0Gpi?=
 =?us-ascii?Q?tJFeSV/motb++S+ilPdel0RFji4bX0XlrceVHvmOcnv2y/iFyCxw6TTvogEE?=
 =?us-ascii?Q?jEqE0g5f5pWxwP131lpdk05XJrVzXP5BAkQ+Eo6Fsx6dUhh3MklrB2RFdWA3?=
 =?us-ascii?Q?51mtxv3ftfb5riHLfH7gVAq42BzjMv4HEinp9a+2AGE+XuFJDzKxqg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 16:58:25.5712 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13b3763d-46a3-46e4-ab46-08dd42187a68
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7861
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
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index f5889d1bd0d4c..9229b6dadbe32 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -97,8 +97,6 @@ static void vcn_v2_5_set_enc_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v2_5_set_irq_funcs(struct amdgpu_device *adev);
 static int vcn_v2_5_set_pg_state(struct amdgpu_vcn_inst *vinst,
 				 enum amd_powergating_state state);
-static int vcn_v2_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
-					  enum amd_powergating_state state);
 static int vcn_v2_5_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
 				   struct dpg_pause_state *new_state);
 static int vcn_v2_5_sriov_start(struct amdgpu_device *adev);
@@ -1870,21 +1868,6 @@ static int vcn_v2_5_set_pg_state(struct amdgpu_vcn_inst *vinst,
 	return ret;
 }
 
-static int vcn_v2_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
-					  enum amd_powergating_state state)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-	int ret = 0, i;
-
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
-
-		ret |= vinst->set_pg_state(vinst, state);
-	}
-
-	return ret;
-}
-
 static int vcn_v2_5_set_interrupt_state(struct amdgpu_device *adev,
 					struct amdgpu_irq_src *source,
 					unsigned type,
@@ -2037,7 +2020,7 @@ static const struct amd_ip_funcs vcn_v2_5_ip_funcs = {
 	.is_idle = vcn_v2_5_is_idle,
 	.wait_for_idle = vcn_v2_5_wait_for_idle,
 	.set_clockgating_state = vcn_v2_5_set_clockgating_state,
-	.set_powergating_state = vcn_v2_5_set_powergating_state,
+	.set_powergating_state = vcn_set_powergating_state,
 	.dump_ip_state = vcn_v2_5_dump_ip_state,
 	.print_ip_state = vcn_v2_5_print_ip_state,
 };
@@ -2054,7 +2037,7 @@ static const struct amd_ip_funcs vcn_v2_6_ip_funcs = {
         .is_idle = vcn_v2_5_is_idle,
         .wait_for_idle = vcn_v2_5_wait_for_idle,
         .set_clockgating_state = vcn_v2_5_set_clockgating_state,
-        .set_powergating_state = vcn_v2_5_set_powergating_state,
+        .set_powergating_state = vcn_set_powergating_state,
 	.dump_ip_state = vcn_v2_5_dump_ip_state,
 	.print_ip_state = vcn_v2_5_print_ip_state,
 };
-- 
2.48.1

