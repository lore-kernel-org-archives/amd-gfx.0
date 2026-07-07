Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E0A9C44501
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2026 18:00:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6FD610EEC5;
	Tue,  7 Jul 2026 18:00:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kU0DXAP/";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011027.outbound.protection.outlook.com [40.107.208.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02F0A10EEB7
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2026 18:00:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=htA1+WtneZoYA9BDXqNKI/MB2QlC01uKP3oQg2/kTsKwmdFbyu+UdyOgdVeoTQKn6v9/Pd7TJNxd1U6CyJXi7thd1b9mpowb//m/z/tLBNRfEBiWvyWyxNRIa95XudeBzjXgAX4nW/JgisOlvDX3xLCNitsvLRFd8cXH+CJkvJsaDN4zwKPkLP+tl0CyWlGPXHeH2ES0LUR7uSvspuKslq5lxB3aYgO+qtJ2k13wwtzIrqYKsnm36e/2DKXurvNkUX63UoY0QBUHczFajU3cPOwi9bkjHoxtAgx+wuwZFZNC6GzHeZWAxdMoXHzsb33pnlbTGdt1lfII11yBhECYvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oBUnw5kNEbFOqQwZdfOQW+RLMSu2tYKiSawI3L0Qaig=;
 b=cpWsFJEtKd9/s0iiJg8/lcXurkzk/aTmePpurkAFQMDCdYJ2mAtN0ERX1KZa0PD0AS+jS5UpxBL09TynbZ2q5NqZSrQvSa4y2gNE1dabxcyDL9tE6OEhfBVOjQj+2PV4BAe2nvxkRGeeukW859KUVfOInEkmYmlZHe42wf9sxZChNE8E6aovcimBs95m+eemkJNvhMgV4q597pOKIVCe3SI8DtO7xKprwqguukfNzl418IMQc7GQ/8GYozvs1zbWSc0FiKLhjG0gtfQuZ58ACarcchNCxaL3VhuCDFcs5e5DoX40X65LtJPtpSFRY6CqgE6TSfYYtKniBOpcW5K/Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBUnw5kNEbFOqQwZdfOQW+RLMSu2tYKiSawI3L0Qaig=;
 b=kU0DXAP/3EWHfI5z8uWa5j6myma73kN1V77tNF/iAI+DzS7hmAdJgTUJyOKjusRHJ0cfzuNhjUAdRTBB8OT1NJkyt8oxHvJdpTH613CqmJyYUg95BH4arbaP++M9pokEmsex9DBUs8afh5PqCHjDDhM9Ct4etvVDe7RI+69M82w=
Received: from SJ0PR03CA0155.namprd03.prod.outlook.com (2603:10b6:a03:338::10)
 by DS7PR12MB6046.namprd12.prod.outlook.com (2603:10b6:8:85::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 18:00:35 +0000
Received: from CO1PEPF00012E61.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::4) by SJ0PR03CA0155.outlook.office365.com
 (2603:10b6:a03:338::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Tue, 7
 Jul 2026 18:00:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E61.mail.protection.outlook.com (10.167.249.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 18:00:34 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 13:00:30 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 13:00:30 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 7 Jul 2026 13:00:29 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4/5] drm/amdgpu/gfx12: fix IP dump alloc ordering
Date: Tue, 7 Jul 2026 14:00:20 -0400
Message-ID: <20260707180021.2642432-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260707180021.2642432-1-alexander.deucher@amd.com>
References: <20260707180021.2642432-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E61:EE_|DS7PR12MB6046:EE_
X-MS-Office365-Filtering-Correlation-Id: 080b1037-ecd5-4d78-3c2d-08dedc51a49d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|82310400026|1800799024|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: yzJbkI8x5UVyxTxal3LWesxtqp+P+dkKFl01YwVhRAqBrg8xeZY7gaMpAK7ekq7PSE6K+9jmgP3i9NkqTwZJH1bvnITQQpYCMwkBU76VuMibDX68Lh2FT+1ZT2Y65dxb/Uqt1EDJK8qqWBLW9fXVyxX0bs/dvkWowS1H20KTcO0LXxSFUw+rSiCXrtKDr2VCCxPmuWrrflattNVowpq3alJDCybrMk/6MKz/LJTD2EZnlXfAYpPKo2k2df2MbGOOHAYZ7oilYAjNj745Q6LaRJ+BqxPb8HwvXVqyLNxbihh2wc77vLdMMkgq0Txb3q/2m9rMO5I1/9PUPRShmPhFf2+qFyFoCLeelsAR1P1Imv/jv0+QhMrxawvSX5PdXNuD8R54RBxZ0gnGpSKHugRDyegCKiNdYIDEBNX5A8pP/vwsNiZtTO+B1KthMbObGS16Yyd3vM3vLX0FkC1wWCnAE8g+wQ7cCYmdKMhuivGCQ6tFE/gxp3guX71ulXr4ItrxcXdVi6ruJX0bw5TEKZelzj49IV6HBSsG3JGfG3tg++rCYKo582xsGozs6voHUI7xRYAvFeqdRKOhMyTQZarMaEbK2xkyvVGsuoeh2p2mhQj124RWd7rFhqxGcgrSs7QaZgiNu9C0flm5e05jGNuB2AVbA0JpdXPfsAB8kw0oSxj652x9569Gw4beAzpw4xBi08pMWLwZax5lFecxV7UH2Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(82310400026)(1800799024)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: V9hu9Y5wuKEx4WykO+enPK36hKF6RBZAdhfQsZP/XJh0y+PTfXXkyVc92TX7f5iwMvwjHZlA/uJUmWAWYeKmLjTmOkD/R4yvbU85Jc9p1vVJMz3ua/y1bvNDhpAnCyjAePatbgi/moAU63JZ0si+7cQzRL8i9iBdmQtP3J+FH7U9QB61cZkSViB2aiVjrsStijat3tnECnGO3oZrqo5xI9BR5ejG3yyps5LfdYD6m6LT5kN2yELa0kQWZMUgFYJAKKC9VxeHRXQKSPWonU2S8rNIYZyf0hAHYM7BZ+7UE253aSF97JlgzNYN6ZiAv/xuqTSZ6gdYqBM1BcLhUGNqH2l5OhevwGB+jCZkZCiwXh9iW7IO10+5VQlsZtvv9Ta4R3ZM4AwrbxmtjO0op8OzEwxKkX0NYtSifCmtKT9YnKZd/G3jLoALRK/973QyM5RA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 18:00:34.4065 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 080b1037-ecd5-4d78-3c2d-08dedc51a49d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E61.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6046
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

If gfx sysfs init fails, we may leak the ip dump
allocations.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index a1aaf49d3bf84..d62826a0932e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -1596,12 +1596,12 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	gfx_v12_0_alloc_ip_dump(adev);
-
 	r = amdgpu_gfx_sysfs_init(adev);
 	if (r)
 		return r;
 
+	gfx_v12_0_alloc_ip_dump(adev);
+
 	adev->gfx.me.use_mmio_for_reset = false;
 	adev->gfx.mec.use_mmio_for_reset = true;
 
-- 
2.55.0

