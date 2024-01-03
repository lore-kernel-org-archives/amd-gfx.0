Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62EE4C3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jan 2024 21:55:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2773E89089;
	Wed,  3 Jan 2024 21:55:58 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2065.outbound.protection.outlook.com [40.107.96.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CF4D10E34C
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jan 2024 21:55:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a1BNmf8nRMo2OINxY4+I5zTkP2SSdxRQimm7SunYavHfq3mHOZmjImOpGfks+c3Q1qqP/a3t+cfdZmEVJKYGyndyXcN0AnIyrDqi1AIxY+ABcRk7t6mQX84IY06ef/oOx7M9TrxgrdbF1E2iDq0qsci92HpB03VurL3MjWB9UESFZokGHmQO2MpbKvnCeTrhv7I0MUmYodFvSTDjU6lGlKdIS2CdgoYCmgOdvo08+tjoZjYCb2k97isfCWi2Vv9O82XanbizlKf7pDkhgVn7KvojUE4CY9N3OQZvsBRkEIRxk49j/aDI7N/WDWRhOb5+kCApSBA5LGC7RnI900D8rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j5aLqBiAHdVHOOx/U4xCZNdCLnvnWHf9FywB2GnGNSM=;
 b=K1BdZJCDSaJXX8KGCTb0rufNWagphSJTB0eUER1KRgQtrY9kDi7HMU9ThHZQgXg54CYuTnQ1HMSWgXvNVMI88KbTYBvX/zr0EW1rAQ5HjzL7yNIpB9ex8yJxSdsajm5+qWTA1kAVmADznF9pfh3NyMAWddTP9Sm76rJvp8YopUFcf7i6/Hp4YaGqvD2R7ZDCvXggzKrGtXKBggEOsJEWx6IgWgQ/e+/2sgH0CLPObtwkbrMH3+9/1A+zHrHAQj8Mmsyubq4jI8EL2VHBN4HwVGfOb1NtA0gU1tNcEOfIeQ7M4apq/Dq2k8yXSTgWmy5jMRwFOJaGSDOLf5xGEb4C+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j5aLqBiAHdVHOOx/U4xCZNdCLnvnWHf9FywB2GnGNSM=;
 b=XSLKtV/AKQf7UD/xr6UrhFhfK2zkHF+RA9hcyOghG2CRxcv/a9LpUcPIueHGKWJuaCXloChVhzVHlpv+qpu+sLpOFNB0LYrA05EHYZS+dIuHPg564fem5R8VwQ/6Thr0ZdCQbz7eZ5vpYR6zTLoaDC+VPAV8kNoQQaZdU4tvsWA=
Received: from MW4P222CA0006.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::11)
 by MW4PR12MB8611.namprd12.prod.outlook.com (2603:10b6:303:1ed::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Wed, 3 Jan
 2024 21:55:54 +0000
Received: from CO1PEPF000044F3.namprd05.prod.outlook.com
 (2603:10b6:303:114:cafe::d1) by MW4P222CA0006.outlook.office365.com
 (2603:10b6:303:114::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13 via Frontend
 Transport; Wed, 3 Jan 2024 21:55:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F3.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.13 via Frontend Transport; Wed, 3 Jan 2024 21:55:53 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 3 Jan
 2024 15:55:52 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdgpu/gmc9: re-enable AGP
Date: Wed, 3 Jan 2024 16:55:34 -0500
Message-ID: <20240103215536.1780386-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|MW4PR12MB8611:EE_
X-MS-Office365-Filtering-Correlation-Id: 90a325a8-dd74-4101-e119-08dc0ca6c204
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ME4yhjdpHW5VtqK//K5Zg0QUaZOzdRSFm5sqBb3fDumOWiJrneIqT5MMJ3AX8FX8z3VbtSXwu1jSjxirPhL3dqQCqXcHoDPiN8T03ZsMr7FgIr4wOfHfCvcPw7o1nUFAhnvKVMLvuCgv8cPvwGKXDIyooNRPnC1hSlg2G4dPZnL4ah/zdkWIsmaB6o2MGARX0SecyYfwMG2jMwSbgnOUGJnF2ulAb6rUO4i/ZG8AqQl379y++/n01chkrX8BGzIDyyWAjoknaue9KMGckwwQamVYo6XiUqBh1NSkkDqXehMYznTRYuHxfhxzETu+4VxgPyEqu+zXJsj3eetl9F4qWgo4aUlvHgEGkOCeQgcZbxAYfB+Boa2grV8O1nYLQl39mlSKwc33Qws9QPjBLRRTGg8D+kCpZSvcE/Cjh9phRiiyAaLcBzzxqGqyR1iUMHrn/fm2r4WGZgFi4RISuyG+rbeUkpb9nS+0+PzbLJvme9oFMLLBCp757/piKdjyRyPHr2T196ZnjYI9t0q5fOubeXrj9n5WV7bXHHU1h4Uvn83xHcCX89TVEWOOW8d92h3mYOmJ7DBXqQScPBLCOUrFQLESYebrvfGlW05lAcnbSNus2oh3uNpH5Hffi+V8NELkqUbaiyz5tb/bRPCCloYP+nJfIFudFda/t10ibmcwWNoCkCeMEm0PXXX2AE4mN0nxWTzY4W9hekRSD9OtXdiH9/rgeRt6R/gALYpsMi8TPM+lzh6PrAHHRXlyrgEAU9mbJ4pvdwUaxSE2kAOL6AOMWQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(39860400002)(346002)(396003)(230922051799003)(82310400011)(64100799003)(451199024)(1800799012)(186009)(36840700001)(40470700004)(46966006)(2906002)(356005)(81166007)(36756003)(86362001)(41300700001)(336012)(426003)(16526019)(40460700003)(8936002)(478600001)(8676002)(47076005)(83380400001)(6666004)(316002)(6916009)(70206006)(40480700001)(70586007)(36860700001)(2616005)(4744005)(5660300002)(1076003)(26005)(82740400003)(4326008)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 21:55:53.6940 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90a325a8-dd74-4101-e119-08dc0ca6c204
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB8611
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It should be fixed with
commit ca0b006939f9 ("drm/amdgpu: fix AGP addressing when GART is not at 0")
so re-enable it.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 9bff72356a37..de961bedad3b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1632,7 +1632,7 @@ static void gmc_v9_0_vram_gtt_location(struct amdgpu_device *adev,
 	} else {
 		amdgpu_gmc_vram_location(adev, mc, base);
 		amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_BEST_FIT);
-		if (!amdgpu_sriov_vf(adev) && (amdgpu_agp == 1))
+		if (!amdgpu_sriov_vf(adev) && (amdgpu_agp != 0))
 			amdgpu_gmc_agp_location(adev, mc);
 	}
 	/* base offset of vram pages */
-- 
2.42.0

