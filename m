Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42AB8C61DD3
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:29:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 893A610EA21;
	Mon, 31 Aug 2026 18:29:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dabh/hSp";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011024.outbound.protection.outlook.com [52.101.62.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A68A10EA66
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:29:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UHvFtUAJoR9+rWPuAYX7HFM6Axw9FDBU18dsthmPTeN213FSBFU/XJow5CL7n5kpNGHx+Cqwj47hASohyFqsu9pDzKmSMIHeyvBUU1hE0q9dTM4sIrmP0Y2KX8mZ4Hjmah7WEfe5KTsx1lpnnnIDmF4EmWI5vU2/H5Q2jmNu/b5IiQ7+WcvRKGz6kI87mzvT99CwaOGOKNBMAg7zgEitQ5DGeD1Tf9/5RKuxbbM5l8nzD7OfFklK1fGl03unGlHvqQ37LC8qnQV4cpW7yeOinKcdG3U5/LeqpAVSFOxtU1tobd5jdCveXMumbsgHzuXRySqkcip2tM/iFS4IwSNDIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+75UYTskqV/5MUUphgopyj8YdXYcq3oWR7KPt4xppRM=;
 b=Pg0timVhoJ6aIsI3d+oKTW0dGZKOAVX3MGNT8lFjAmNdLSVNC9Vg9t4nt6WTV1w/7FvvkiGu6GeMD3Myc4RZUy/VslHHPENAVEBqMtDtiM3O9YzyLYd4d5XFbZWD8FICQFfWGk4babLoGPNnpTtJclT6aRBYo/8xqdX7Cm+x9n910UE4HtRkBsndnn1fOoORLaq9XPCFrGtd+TnrWIADs11waK7Eycvkl1A186Dpvgc0Lse+OoevBSKzbIriVtugJptQAeqaDqW0z0pDQnU34RFkAL5uKJuFjHUddZhv3EQYWaIlCYvEYJvPvgp9bDLOy9dOmEq2oGK3JpGn/aznRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+75UYTskqV/5MUUphgopyj8YdXYcq3oWR7KPt4xppRM=;
 b=dabh/hSpHvqpeyF184oB53+CnSLZfd8/WcUVsdV9mIjhprloEMZ5+m7adBz5v9ZvW3hVeQ2pPeNsFo3ASA3+wf6UwHqvKAE1tqs8sDOjsepeMb7C8ih4sn+XPwN77Mo/vt6cMzcycYNJTeuFbu7wZ4DxGsNADuIikmldRUuJhN0=
Received: from BN9PR03CA0669.namprd03.prod.outlook.com (2603:10b6:408:10e::14)
 by DM4PR12MB6134.namprd12.prod.outlook.com (2603:10b6:8:ad::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:28:57 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:408:10e:cafe::7) by BN9PR03CA0669.outlook.office365.com
 (2603:10b6:408:10e::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:28:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:28:57 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:45 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:28:45 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Sierra <alex.sierra@amd.com>, Harish Kasiviswanathan
 <Harish.Kasiviswanathan@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 62/95] drm/amdgpu: log remote memory MTYPE for GC 12.1.0
Date: Mon, 31 Aug 2026 14:27:21 -0400
Message-ID: <20260831182754.1089811-63-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|DM4PR12MB6134:EE_
X-MS-Office365-Filtering-Correlation-Id: 78f788e2-18e9-43d8-fc95-08df078db838
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|11063799006|10067099003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: LOxsc3p9TKSNYdWUpoHHz5coYPBs0wAHbq0YM75aKYwm7wCMNnn4L09KKLOBS79wBruR19bp6AM1G2wvIx6VXvm8mJRP/r5fu7nrriEC1yjpDAkGAId2krQo0sLFDWoWv0TbW5XCOcqv5pGkKm3tkOtNxSYOt5FWBF8jCZW5UaL2AazitBubPA4kqSbOKSoM1siZP0Mgf1sIPCvxLkUAmGTx2ZGgbuM9ta621IdispDC3yrvlHteTO3JSgRodi0dQzMnQsv1HIazZidd+c+wrHQlpPPilhcIstL2h3P4LRN0XwhAxjxIz2/pup0TM5JhS+33RI3QOvtPcqzP0D1r8oJESe1l8LdfYybC4G/RB+SgIKnNhZ3B2rEIuwNe8lae5r0mmW5QXY8AhIRfs60DbtvVgPks8xAVjWpLtq/ry1AzCiGfaUcXmpRMezj2U+LVZJ6eeHG2f6u1BOFvGbHvPulckYm0eOSCJzwXfpqPVpWs7FkuQzx31ye4ZVAyoqCHiUTASlAp1pRAa4hteVK4Q1mvSxxv7oE890btSnj+YB8auYD0V2O8VooCrzgyrA0gijG/Mpe88a2n0Lnhj4YFnYLAr1+NoP0FfP4S38iZp3EMCdZ3vaUmv0V69SNvmx3cD4INksb+eGkcNFGW0ujMkOSl2oVXEiokX0V+dKFj3RJ3BH+peVj5o/13attAeWgHSKrJdaZfEijui15HgK+Gyg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(11063799006)(10067099003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /gdDaVztAF0GNdBCZwFM7Ad8AJN0nE73ZSwHQImqoP+20K7eVDr4RrwHYRXIBjJ1/fnEudumnJwRLKOd+apQaOGMmiMNV5bBQxA3UzXdx9UdnjrxSZXkzH6FnMDCTdkq4Xa6+8BcM3D6Xm42FwJz42jtHjYfYmyHgb//WNRlUhdbLNszrcV5pq9g9tQXrbpggwDxKpZ7/LjqbJWwOlSnrWSEabxTLwIJ2gdh/MXbTwoiextHZCEaHtSLZ8TgAjgMD/0kbYY+gi4jKX2sVp7mt6dBTbJ5IPoHWsXgoDyuAoy+wpWPlIzXAI0SwE+tBz//hIMdw2IecoMs8/2KaQpH6QbOGtV3thpaGw3z+z9nb4ZXB0hwYSgCD0CoyZPSVXXKI4sIEw8eE4f88wv2Ht2CKaUkXVBMoP2yTOFbDgGpZIxPcIkOjWmj69eMzpX42ScF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:28:57.1983 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78f788e2-18e9-43d8-fc95-08df078db838
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6134
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

From: Alex Sierra <alex.sierra@amd.com>

MTYPE UC in A0 and MTYPE NC in A1 for remote memory

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
index 34d5767287d78..302ebf2f3ccd1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
@@ -649,7 +649,9 @@ static void gmc_v12_1_get_coherence_flags(struct amdgpu_device *adev,
 		} else if (amdgpu_mtype_local == 2) {
 			DRM_INFO_ONCE("MTYPE_CC not supported, using %s for local memory\n", is_aid_a1 ? "MTYPE_RW" : "MTYPE_NC");
 		} else {
-			DRM_INFO_ONCE("Using %s for local memory\n", is_aid_a1 ? "MTYPE_RW" : "MTYPE_NC");
+			DRM_INFO_ONCE("Using %s for local memory and %s for remote memory\n",
+					is_aid_a1 ? "MTYPE_RW" : "MTYPE_NC",
+					is_aid_a1 ? "MTYPE_NC" : "MTYPE_UC");
 		}
 
 		is_local = (is_vram && adev == bo_adev);
-- 
2.55.0

