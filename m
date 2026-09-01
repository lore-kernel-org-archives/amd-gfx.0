Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14294C61DD3
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2026 20:11:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8ABAC10EF11;
	Tue,  1 Sep 2026 20:11:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="M/uLG0tR";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012003.outbound.protection.outlook.com
 [40.107.200.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2325D10EF16
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2026 20:11:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PIdddDOlp3R4M0d8r7mZijypeODcdJxy8Mimi5v+LPOlNMsnu6VKGxvTg60aSK350EHF84axumeRnnxJPeOehiJVIZ1AQqCRCoCgdNcxvWLj6uEZYLfvwNKAQJs6QH9PJktehqygBo0YbFuY6gk+WQp3N7eOj41JRpQ1IBh5p9Jat6f9zixnoSUnSJV3fHff1dsbeBNXaZJ2WN+BiZokdjSZM59my96sK6Fgti7xP/J5BJvnsPvnrtNNXB6oEWVdVLr+rbUfDPZPcktFll0wv799N/N72/qYHhDpTXQpC2cKqQnfRF/o/KnXsCpprvvFLx1nDD7XPh6+noWyO3Eqbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zxFQwUAY+vwe76XX53o7jmfQCkTkVUk9N0sxXwclV9w=;
 b=niU8a+bK3uBhp3YqRG6v1XhN3ctkob/4ou7JVmd7aCCJFgKAE7XzLZS+AH0sh2144yxlM8V7gh/gkUWBH+qjEiSB7XPcRTMN4vJBBWSOCdBT+UQ7D7sYicdCZeIOO/TFAkXnsHWkxI6Uvihqskib7aFNfMJIHCGjsFIW523gBvpzDAQbPg5TWbGUv7B8TCj+XwZcqRUaLX7aIIa7OwNcv2qS9yFBfUJPZogNmIfm4q4hLN3n/EPwhrj+Z4EPYLvck5dtX8wZtGVZrHZslOXrHc0rzBKp2dSCm+KlHPMQlsBA0bsLC9eq8erpO5G2bo55b9hmVELd7TeTfoHVAfWmtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zxFQwUAY+vwe76XX53o7jmfQCkTkVUk9N0sxXwclV9w=;
 b=M/uLG0tRdg0l+fsnRIHIoya1wKQcYslU3ufOG1uliDjtv/6P06Daw++xRPrv0fFj75HeQ2lROObU7OEO/FsCBxmKziZVmr28XBsI1a0dNbalwh3+n4Jl85cn6Mywb0HTDVJSH5Kp0uAYT4lmGwUedbSek+mswzRVOmK6JFfNHpg=
Received: from CH0PR03CA0091.namprd03.prod.outlook.com (2603:10b6:610:cd::6)
 by SJ2PR12MB8782.namprd12.prod.outlook.com (2603:10b6:a03:4d0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 20:11:10 +0000
Received: from BL6PEPF00022571.namprd02.prod.outlook.com
 (2603:10b6:610:cd:cafe::90) by CH0PR03CA0091.outlook.office365.com
 (2603:10b6:610:cd::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 20:11:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022571.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 20:11:07 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 15:11:00 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 1 Sep 2026 15:11:00 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 23/31] drm/amdgpu/gmc9: use SDMA for gart TLB invalidation
Date: Tue, 1 Sep 2026 16:10:26 -0400
Message-ID: <20260901201034.2960437-24-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901201034.2960437-1-alexander.deucher@amd.com>
References: <20260901201034.2960437-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022571:EE_|SJ2PR12MB8782:EE_
X-MS-Office365-Filtering-Correlation-Id: a8310d12-7d54-47df-d794-08df08652873
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|18002099003|22082099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: klHIZ7j/JSgNhuD/W2RGGpTZevQPESIy1pnXAHaAPjeSdz0Z5w8XgM7uJyEtCoUaTb9gCjLuipp/eU58d8PwhVeHPiDb/UjclK7VR+OWUm04xJkoT+8jlxU9x4awsV/lf1v2ldkyRrVqkEjpqhMfWQcafuad+22t9Dtjtr+DriEyF0B1Hkw7pRBumI9HXQfLnfqAVi/4COc1Yfq0DCaXSVwaPCGJXVs8sdB2vqbwNRXfrpZ4A8HWb0ZE9Foqsl6z2ZEThNMpnNrDy6/hENZRU8AWG1ELynPkgcId21IWbS7y/2OSTjzRV99SE93d+lg7VJt03pw9EOXKNAkF3UBrSJ6a6+0BHLR2EGxGe7LGlCUbcMlwckIZ1zZuhrPz/2rRFufTXI4dRI6oxd2aQaNrHT2j0M4262u+prU6Xr/nmpMcboalBBEvosKBYauY5wGJJWvXxPdtLRIY52MWJlqZnI/qtpuG+d74V8ctqYefNdAz+xZ2ofU2IRAuRyW+UATVy5dm3Uhy3quhtDHcrW7mmusDY/iHcL//NOlTuU+m2z37mA22xZwWQaU0PPinrhERapxjNR696JoMWih7WGRb1o7STI31996nLvqHqWqcNd1hs7IZd3LPc+gQ1dJmbXWWIVhndI8UE1Ug3iN9rA4wZ05ELXesSTpW7/tYAkymCH4Cy2XNRA05A+dN05dixbWd/Q4e8OXDZ/JehS8PmXs7Cg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8j3N6YXXuHL5S+uMaGTb9v8Osdd3n4A8qemnkXi+5SGRf+MFQ2p8/Ni6yIeuBSII8LoyML4fySdcPw8uJ0DT0ZszzgpX7tp+P2gNjtJ4c9CDHTC7bFQs3kaipuB4bjSBTj5BFFjJvKeD86HxJdqZ6dl43guAToisZE6wsrPPUzOIE4YrsQXqR9XGl4ljxes9IW1G4wjyVQ8i7THqEvHKBvcGnJMbchat1cItyW8v7iQ8P1infb/OkVS7cAyi1YN/DekeVk51s1jtBxxc026Nec62WwolFe/v8t+BXbVHWDYzY83ND6z730NUnXnHOwAWx3Gh7IddZScHCNUrAVL7dO3R0Agggqztw3LF+SogpKj7XatYRG9+Co67utm5vX9I6UnauQhZMYdYhFH0b0jm40r5B8ZlyhWyEjpmxebVmwHaK2FSWTdMYAjhk2MWvJ8a
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 20:11:07.2839 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8310d12-7d54-47df-d794-08df08652873
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022571.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8782
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

Use SDMA rather than MMIO on vega20 and older.  The avoids
the need to disallow gfxoff when invalidating.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 317b44412b5a6..ad4bb86b8ffbf 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -2164,6 +2164,8 @@ static int gmc_v9_0_hw_init(struct amdgpu_ip_block *ip_block)
 	adev->gmc.flush_pasid_uses_kiq = true;
 	if (adev->gmc.flush_pasid_uses_kiq)
 		adev->gmc.pasid_inv_method = AMDGPU_TLB_INV_METHOD_KIQ;
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) <= IP_VERSION(9, 4, 0))
+		adev->gmc.gart_inv_method = AMDGPU_TLB_INV_METHOD_SDMA;
 
 	/* Vega20+XGMI caches PTEs in TC and TLB. Add a heavy-weight TLB flush
 	 * (type 2), which flushes both. Due to a race condition with
-- 
2.55.0

