Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4952E77180
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2024 22:54:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 842F610E9F0;
	Tue, 10 Dec 2024 22:54:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rt6yoqOJ";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2053.outbound.protection.outlook.com [40.107.102.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D44710E9EF
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2024 22:54:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ofXQdod1eLyS+WBMwOPrmmu+8nuiJ40WVNK5XER7z11PvHe7Jrn2mbxN0nfqTkRqKMWJauS+V/nzS3z2aeT+qTrsr2b6482xhsITKEtB2gPzm0tlat78Cta8JN/iAsWimlTfZZm2PuBuT9hTSFTdV7IyRgoRf08X5dhUggiCGHrhVcmFxO6mwoT1lj9bueDVwmmhsUAsx9AIhl4Xd6u6QCzPkVMOU9W5j+nOw/Ls3Ep7pLnimY3wEI1JfWo0ACHmgJS+/V0yhE3lOyPTKLgslFsdLK2fv1L0cLbsiwibN+Jb6IptVNQI18eZGrUgzwmBWoCFdnAsZxa5WH/9JGJg/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X9Xm+eOL4ZFiduMl8WmhQDmBdQj7roMhhiZRlD/IsUk=;
 b=uur6OXJ2xOhgJaWXK9FBbX/okNHB/v/3NkHvM8aRg42jLKAy1o9XfYCCYIk7+UBfDEwcsxpofntUlzkzPs2DIm98Dd2/WFPOF4vPBShheSi+4fYbqRr+clyzdVuTENUzxbg87QZ+n9+0u3chORu+uBRbwko9wibebsSuO6UUG9fQzfYPS1IPdEGacv9JuTMlVf6wezNWeA4k/jEAB8wDLgf0P0wqIvqeB2XhIasVPqdrqYVoBXKpCWnb1fPJQ013u28N4nBC94/f8h3mXBp8CqFmSSbBo8kdJs16uEZkTEI6KW/Fi4nJWSP3cVLtfDI3ofbrcKl7sx2Ns6ng1GKseA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9Xm+eOL4ZFiduMl8WmhQDmBdQj7roMhhiZRlD/IsUk=;
 b=rt6yoqOJAy5aiX1iosSOvEtXWrbNHDdCU6UFuU01YOezOn7wn+T9R65TYf7kBY32rA2F/kVLKz0LPcg4thmD2pYiqD1iOWh4x1KLYzEpExg2xQdDiBe57eR94EYGyPUhJABa/UDkDCpVXdpoVnEwEfptwQ5rXQfJtcAUVTSb+9E=
Received: from MN2PR01CA0002.prod.exchangelabs.com (2603:10b6:208:10c::15) by
 IA1PR12MB6138.namprd12.prod.outlook.com (2603:10b6:208:3ea::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.24; Tue, 10 Dec
 2024 22:54:17 +0000
Received: from BN2PEPF000055E1.namprd21.prod.outlook.com
 (2603:10b6:208:10c:cafe::f2) by MN2PR01CA0002.outlook.office365.com
 (2603:10b6:208:10c::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.23 via Frontend Transport; Tue,
 10 Dec 2024 22:54:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055E1.mail.protection.outlook.com (10.167.245.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8272.0 via Frontend Transport; Tue, 10 Dec 2024 22:54:17 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 16:54:13 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 40/48] drm/amdgpu/vcn4.0.5: use generic set_power_gating_state
 helper
Date: Tue, 10 Dec 2024 17:53:29 -0500
Message-ID: <20241210225337.75394-41-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E1:EE_|IA1PR12MB6138:EE_
X-MS-Office365-Filtering-Correlation-Id: ab47a98b-0c20-4af6-1f44-08dd196d9364
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vIi8EIrClGCuzsxJYyTAK+V3xkb9VDR7CoEEtqPOGpPWov4DV9wINeHX/+sM?=
 =?us-ascii?Q?LMx4E21MaaWCI8AmSS8tlKLLH8wNhZOTa6TheRGKZkdprY4Fm0r0eX81mhjr?=
 =?us-ascii?Q?UmM3rHqfsOjf9CsaD4/W0kMYwEPMX+9OQXfbo6a3DcH3rH/Uvo6qGmp7uxZl?=
 =?us-ascii?Q?4n7BzVjZfC8sNtm51FGs34pK7oHckopLWChm0b+9dIaI6wN99frxIbP5K154?=
 =?us-ascii?Q?9lt6FhSYE9sY04h84mTTWTriI/XwPkNpEMmXRQCEKwFvkpfzAJt5Ei7b+wmt?=
 =?us-ascii?Q?a9Vl3R8D+zIwAEO24A88xqd+Csg75dc5mgVKEpaMziVB8/bYBZUxlui/CaA5?=
 =?us-ascii?Q?Rz2Ld6IbX2LCZvmG/SqCaJCTNbvpbD28d6Y5TNveUhB7JH94c4rpLjVBVE54?=
 =?us-ascii?Q?/xbT5wcP+0nzfLS+M3yZ+a04cpSVFaoyC3ZNdpJjVE3ZUPnbYSr3fCN0YFrh?=
 =?us-ascii?Q?xhpxd5T66PrcWgfNlkz4c6A/n0moqt1S4/yANEMHwlFWvpTLIL6jOurW1gBL?=
 =?us-ascii?Q?sxUKkKOl8vc1CUfa/gti18GF4FHN8IFY9HWVPebj69t1jOsKwlZ6ATdz4P06?=
 =?us-ascii?Q?14r/bAVzwM6HDZo2RK35KYhsfK5TrdCpC+62osvdclztt+qEHjVOglVbitKl?=
 =?us-ascii?Q?fCgIHBtS4hoLYlkHwWwqaNrzwzGk8Sht1FHPBrvezjLEJAgHIHOXmjQ3KyNm?=
 =?us-ascii?Q?/ufziG95sKbOQWwcXTy9W5+d1sdSpcXfiCT3l7KXHmqsd3DW7nkTzCklWA6t?=
 =?us-ascii?Q?99DCLAo/PVF7zbp4I3gtO5wSig47QfPDNdWeR9X3nNnjFpC2IRdqKUAPL2Eh?=
 =?us-ascii?Q?LtTJ/5He5BRwBVL0COg+xthXtl1p0Uhwqkm5SvfJKtE/+ZUiQS8tIKxzYZDC?=
 =?us-ascii?Q?EsxL/90vKCZSX9YJ2nqQxxH4Zv1b5Gs/w1P/kuGEr7f/6O/8gcnhuP7rmW1H?=
 =?us-ascii?Q?2ESLYzQAME9aLV2GNtr06yKcu6EetIqM7hI0Oujzz5oonxGAfFAF5K2+T29j?=
 =?us-ascii?Q?5FI1B2PMWDAo4cGL+hUDx57N+1CfarsBOMAqL6HpgcPHJhZgQKO4LpwRivvu?=
 =?us-ascii?Q?myiufXe1/sfyhGfyHpBT1mLWav3YBo6hNXzUDSMhBqpi+S9OqKT4BrPdclgc?=
 =?us-ascii?Q?HC5xVz3vy0O/mRlS0fW4T1pqxfjMSsnZa8yu8Hio8IBYl0ROOpxbHcSC1rno?=
 =?us-ascii?Q?dX9LN4VKyBkx1qHipRyYoj46V1EXukpBwhgJ+gA6CdzoiBuuBCAvajvUEubC?=
 =?us-ascii?Q?1Ts6NEGUlslmglnHmWBptdI4PDn/+I8oZgdBT+Eqd7XCb9b7DjROVF2Hx0Mn?=
 =?us-ascii?Q?rQvu58SorBYz3VLOZ0cFXrLgyfHXgUoIlGV/TPEVjnjmlGlXuBQm6x43hLdo?=
 =?us-ascii?Q?o5xiCAkWr0m/B+nhBrPlGUQij2GXzzlGo0xOTQSD2LYeBmSivA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 22:54:17.0639 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab47a98b-0c20-4af6-1f44-08dd196d9364
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055E1.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6138
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
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 27 +------------------------
 1 file changed, 1 insertion(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 0ac41249755db..0d6a97c4bf8f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -97,8 +97,6 @@ static void vcn_v4_0_5_set_unified_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v4_0_5_set_irq_funcs(struct amdgpu_device *adev);
 static int vcn_v4_0_5_set_pg_state(struct amdgpu_vcn_inst *vinst,
 				   enum amd_powergating_state state);
-static int vcn_v4_0_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
-					    enum amd_powergating_state state);
 static int vcn_v4_0_5_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
 				     struct dpg_pause_state *new_state);
 static void vcn_v4_0_5_unified_ring_set_wptr(struct amdgpu_ring *ring);
@@ -1580,29 +1578,6 @@ static int vcn_v4_0_5_set_pg_state(struct amdgpu_vcn_inst *vinst,
 	return ret;
 }
 
-/**
- * vcn_v4_0_5_set_powergating_state - set VCN block powergating state
- *
- * @ip_block: amdgpu_ip_block pointer
- * @state: power gating state
- *
- * Set VCN block powergating state
- */
-static int vcn_v4_0_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
-					    enum amd_powergating_state state)
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
 /**
  * vcn_v4_0_5_process_interrupt - process VCN block interrupt
  *
@@ -1744,7 +1719,7 @@ static const struct amd_ip_funcs vcn_v4_0_5_ip_funcs = {
 	.is_idle = vcn_v4_0_5_is_idle,
 	.wait_for_idle = vcn_v4_0_5_wait_for_idle,
 	.set_clockgating_state = vcn_v4_0_5_set_clockgating_state,
-	.set_powergating_state = vcn_v4_0_5_set_powergating_state,
+	.set_powergating_state = vcn_set_powergating_state,
 	.dump_ip_state = vcn_v4_0_5_dump_ip_state,
 	.print_ip_state = vcn_v4_0_5_print_ip_state,
 };
-- 
2.47.1

