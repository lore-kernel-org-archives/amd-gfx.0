Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39E41C5DF94
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 16:05:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC8C110F344;
	Fri, 21 Aug 2026 16:05:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jxjofVCf";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010018.outbound.protection.outlook.com
 [40.93.198.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39DAF10F341
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 16:05:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tg3ZF5PpPjJIydKPkc/UKSCMP9CSm48oGtoZPSJsIUBQvcd5esowDnLT7CSHAwPzhQZ21ESbQOXa6cVvJJ0PFcuTQASf4XOxHFEgTXMiezK019x9ozxP5ZvLEPf/qBahj2viNOOPy4Ew78726W3xtciuB6ZjinHiRNl/FhvB9NkruNy+099SrTXd9EB5RgS1cJ5GyzrTE4IMzsxlK7iwWiQRz0wnWwiWZvKWA3PbYKvaAjunWqMtszA4DiqZZQb4s3Wv6rmVCPc2A58Rh7jVKkjG5ruoqy5rCuShqUObUm6kZ6Sioh1tCNipgRpfY7ojVt3EG7FOVN6T3wDPOWNR0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G+sWp9QqgI5FILvxBQHIA4lAvr2jmhATXOkq/w1MKUA=;
 b=Vx1Giz5gPdHoipJ0K58aEQMfgz0S65xuAlbwB2WHJmw8JFAfdy9g6kRFtqhNSz8GcttyahyisAKlReWfGsVDzJTNP+Zi71zrhe2Ea5/f8LdeyUMFuGyfy92cbAROPPI20QKjAqlsvVwIPP06JrSZs1snfWV2jQtHOUiOPJFrPoLxeaJRNISrrz05dBlEOAg3un9PrpkHxVtMf3bPs911pz3P73FZFyTJxNbCsW4WTVWtb/t0SP1QO9DsK9Jqy2vOwAiCYWV1AoqZPPoqtuQBIVVvDQAYgORMpSRcBxRBuiXBPdV9hpo6+2PoanzVSq5YNWpCOdMoFbYeNexRhJqrSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G+sWp9QqgI5FILvxBQHIA4lAvr2jmhATXOkq/w1MKUA=;
 b=jxjofVCfSjy7LXC3bqM4lXlib6E6V95gSnjPCgkkOMmBR5D+Tj4S8LQSaTzg8zwa7sHyJJjpdeKIfn1BjuLsEleYDs7zpsKVnSENDNac0G4uFdLdyLpKBSR44gXj/I1UhG2KZ5b3HoodE1fFFwerVW6YD6n/BsDZj90vx2qO+eY=
Received: from SJ0PR05CA0029.namprd05.prod.outlook.com (2603:10b6:a03:33b::34)
 by DS2PR12MB9663.namprd12.prod.outlook.com (2603:10b6:8:27a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Fri, 21 Aug
 2026 16:05:51 +0000
Received: from SJ5PEPF00000209.namprd05.prod.outlook.com
 (2603:10b6:a03:33b:cafe::3c) by SJ0PR05CA0029.outlook.office365.com
 (2603:10b6:a03:33b::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Fri, 21
 Aug 2026 16:05:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000209.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:05:50 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:05:49 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:05:49 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mangesh Gadre <Mangesh.Gadre@amd.com>, Asad Kamal <asad.kamal@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4/7] drm/amdgpu: Updated compute partition validation
Date: Fri, 21 Aug 2026 12:05:38 -0400
Message-ID: <20260821160541.752029-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821160541.752029-1-alexander.deucher@amd.com>
References: <20260821160541.752029-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000209:EE_|DS2PR12MB9663:EE_
X-MS-Office365-Filtering-Correlation-Id: bff60160-186f-4cda-fad0-08deff9e11e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|23010399003|10067099003|56012099006|22082099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: ZPuYwqnHOccOLfe0j0RQImPTLHDK2nf63xEmm5vR59VwO749CCR0CY1uecaxwi0CZG6aQbxN8JThAqKAw/HCcJlg8PtvXnpprEzPMMTlvjvZjD4fECgkGQbsmgVmP9P1liKw4zT3ark+Gi0XrF+6+wG5OThoGzmBRp9kE7uwwgeTF1O1kqjz8ZWwUz2dTv/HdswyLiCAzqHzm/RL9zzd+D6HU2ehn1i12sbNS2Yltn2bu+DSITBv00cUQLZMwL4Vc212uHrpu4h38T5BmsDBw4qwRmTo2n6oEWpFpO4wbVWXKaZoVKHfQcfVjKjJWkKjmK1WgM4zFnhE+8f3f7jeN+MkuK3ksfexEu3e0iy+zotbLx1TMJkAO1I0djNiFYzv7malJDHGRH2vQOLc2OnuFlaVv66wlYDWg1lIeSIdrTteDRbIlAwHS5ZbWno/oOZ7faF7tsyhfCF+naL6jBfh7EWve7ONy9fmfbGD2b2OZwLoxeT2/IoWEnIjp4xYcEjJDKoVaJsA91wht4Pdinvj1S8SVNuI+TpktfJBz3RwOXLsVE1F61KBKdvK/3hFE9+zE4a5GWC7HHQn9WEgDjC99f6SYTTRV9zjRT9tWCxgzh/CDv8XoESil9fk/yLsU7xtKdW9WpKlHZUTVFKFOls9nJesscv5ZNsZ3N8JjKCtrJgZbJb0Zq80dgkq2doa7dJX2NmRLfuKLun/5sRGDMDbXQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(23010399003)(10067099003)(56012099006)(22082099003)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BBjZoZOpqagjoDdK7yV92xX7IxyXb6Os0xryPDfeK7PSI7M73VoxrgMZrMDfFZawd2//emchdHBwT4HRLOVoUHHwFXWzv9Px9AYcbjmhDYni/ciLZJUxBW3kAXqw7H2butMvzUWW8q2dHoA93boZ7MckigsG2fmTGuLH2zo5yA5gsKWMG3BirOQ7J/GO+hbyUS+Dda3CYJwTl18IuMJWrXPqHrYbnyqRYEAtGZ3+JjD3nP3zvbgTqWzsdwLfVHry08Bi0GY/14laxXNNOEKMVZT4RSOjMpxphpvLp4nK0H1SJ+OB7njePEkg/kkuIuU2k1L/db/LvGYqq1XB+u5NsAoUJ7wqU5upKgOoErGTSJ3vlEW5qx5u2Z58e5maC1+SiUjLRRPGW7bs/dEVsHVVQhlBbUMBhHMXCcoV1LONVs4bFxoTjLfUAEH/NqpO1csR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:05:50.2172 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bff60160-186f-4cda-fad0-08deff9e11e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9663
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

From: Mangesh Gadre <Mangesh.Gadre@amd.com>

DPX is only valid partition mode in NPS2.
Updated check which was making CPX as
available compute partition mode instead of DPX

Signed-off-by: Mangesh Gadre <Mangesh.Gadre@amd.com>
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
index 3f0b73f468fe2..15923d2e05a54 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
@@ -632,7 +632,7 @@ static bool __soc_v1_0_is_valid_mode(struct amdgpu_xcp_mgr *xcp_mgr,
 	case AMDGPU_SPX_PARTITION_MODE:
 		return adev->gmc.num_mem_partitions == 1 && num_xcc > 0;
 	case AMDGPU_DPX_PARTITION_MODE:
-		return adev->gmc.num_mem_partitions <= 2 && (num_xcc % 4) == 0;
+		return adev->gmc.num_mem_partitions <= 2 && (num_xcc % 2) == 0;
 	case AMDGPU_TPX_PARTITION_MODE:
 		return (adev->gmc.num_mem_partitions == 1 ||
 			adev->gmc.num_mem_partitions == 3) &&
@@ -647,8 +647,10 @@ static bool __soc_v1_0_is_valid_mode(struct amdgpu_xcp_mgr *xcp_mgr,
 		 * (num_xcc % adev->gmc.num_mem_partitions) == 0 because
 		 * num_compute_partitions can't be less than num_mem_partitions
 		 */
-		return ((num_xcc > 1) &&
-		       (num_xcc % adev->gmc.num_mem_partitions) == 0);
+		return (adev->gmc.num_mem_partitions == 1 ||
+			adev->gmc.num_mem_partitions == 4) &&
+		       (num_xcc > 1) &&
+		       (num_xcc % adev->gmc.num_mem_partitions) == 0;
 	default:
 		return false;
 	}
-- 
2.55.0

