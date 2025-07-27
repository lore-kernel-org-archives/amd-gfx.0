Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A828C87FCE
	for <amd-gfx@archiver.kernel.org>; Sun, 27 Jul 2025 16:52:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE8C310E2E6;
	Sun, 27 Jul 2025 16:52:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ogLXTFjK";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A22D10E2E6
 for <amd-gfx@lists.freedesktop.org>; Sun, 27 Jul 2025 16:52:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=viwqNhE8uwWAXDtagpTYKmx2D4vo/xYotQO+Cpl9AXxylTMpgvFe1/L5+a0SfxgnUqWgOfDPOXQpBVw767Z+D75qzJi69u2dlkw6Inysks4IAfsu3IxIhH2b94ddjWvJb7XFirqUx1iu6qKr2U2kedKoP9C2U1LLuNcvDXRmbK7wLfQnma8Ag4EB9pyPKmVebRKB5a/8ceaF/zNf4WctijlqbJKNHFfldiRAeLuKpuDfxgdlWuAtV6mQ4KeisK/eP2tmTl8Fzcn9x7HhduZ3Uw0LNK4j1WxxKteLBqVsRwoJtmuMpWEbjyKR/bw3AmhFZ0IrzPVQucQvPgvPfYYhAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qV114BlBPPY5U3qKcnTyZfMKeMO4MlR7l7q63kvcLdw=;
 b=UcURrPFHbxkPKVWwXGti1Y2AvBInBeAhbMNWUgMZdzDazPSmHcdLYpwqgdjepac/iGDN2DF6pRrxWE+dhJWK/dWyZmYRVMl1P9MXLh3hmE0hpsceZhQAj1jJkTnlxMYYo2nji6tBuDk7WIK1CWMSc46/HzIu8NNIP6/slfgwYhDO4uEMq6cmXV+luk2wXCUaVsaLG5HNeSNn3IeTbc5rg04mDkVyfw6ZAUVaFzZbaOsu1Zz1/ME0rEnMO0LJOEdq/n1heFnfyNsiLuCIbxIv9AcWq+LYZWPNxeawPQpAdL1UFEk0VERuFzs7Rkcd1qayow2Lv2u/ZvFDBCEJtLizow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qV114BlBPPY5U3qKcnTyZfMKeMO4MlR7l7q63kvcLdw=;
 b=ogLXTFjK11L2LqklP/3S8OiGRv9yZJfwln87XSQDHXuJIqniTq7Q9+QW0S1iy4fxqzM+NrQxKsS5XVYas2+XCmJDaMS0WjnC5GmcrYf5/EhWIJqd9AGMysxEdHXm3/h5Fm+RZxDDOk+HaKAK7VSUHwIkwra/V2OrQWOevVZXfNc=
Received: from SJ0PR13CA0230.namprd13.prod.outlook.com (2603:10b6:a03:2c1::25)
 by MW3PR12MB4361.namprd12.prod.outlook.com (2603:10b6:303:5a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.24; Sun, 27 Jul
 2025 16:52:33 +0000
Received: from CO1PEPF000042AB.namprd03.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::76) by SJ0PR13CA0230.outlook.office365.com
 (2603:10b6:a03:2c1::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.11 via Frontend Transport; Sun,
 27 Jul 2025 16:52:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AB.mail.protection.outlook.com (10.167.243.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Sun, 27 Jul 2025 16:52:32 +0000
Received: from dayatsin-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 27 Jul
 2025 11:52:31 -0500
From: David Yat Sin <David.YatSin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>, David Yat Sin <David.YatSin@amd.com>, "Harish
 Kasiviswanathan" <Harish.Kasiviswanathan@amd.com>, Mark Broadworth
 <mark.broadworth@amd.com>
Subject: [PATCH] drm/amdgpu: Fix incorrect PTE flags gfx12
Date: Sun, 27 Jul 2025 12:52:18 -0400
Message-ID: <20250727165218.849866-1-David.YatSin@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AB:EE_|MW3PR12MB4361:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e80e50b-656b-4c43-0516-08ddcd2dfb60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HMyNmS6Rbn+ibKcSeN+Z3QYj56+oDXKMFS5zTcbWkANTtKe6E4NMdyVb1v80?=
 =?us-ascii?Q?MMSso2M8LyqPJOE/LbYaVyzN7xU6DxCabBXGa/iBB1szlYUgRbLF7Az6GQmF?=
 =?us-ascii?Q?1SA6Lm4ZTnd66tdRmTKy0ifOaxEe5xQyub9HDaB393mpNxODpWaGKAWv65Dv?=
 =?us-ascii?Q?/FWcouDUB9gFxIEDBmwSdVcm+mq/m4gRCDWwnl8hr/v5ATDHDwiLihvWarIr?=
 =?us-ascii?Q?dNzyh1ZwKz+kTGaylasb4qcf+4XTjKfhHyrjZzGBiC1feZSCwkQfCEnrQ21P?=
 =?us-ascii?Q?uhSYeYGzmCiKkpw7SCIkmEEFSk3UXKbvlm797Eerouh/GAzuntkjLoGz5Kvs?=
 =?us-ascii?Q?lyLkwnfVzzlWiONjFy5xaBp2MCugYiYbBe1rMqgAyQGQau+purW4AufLNJUo?=
 =?us-ascii?Q?5leH6MfjSUMH5OMX3obMGcSHTt43vcpdy3aFdDeBjqU6YaxJr3LxFUg6xK6z?=
 =?us-ascii?Q?1VdEnfF2Wx++03NJvt4x182Mw5DJMhZLouHa0xu0XwWWNPR/+HedZqOcAdMM?=
 =?us-ascii?Q?0nvUr3s8o/GzL/kQVYI1U/WeeF3/wbDxhRZf/zsOCQUWb8BlB2408fm4s2LD?=
 =?us-ascii?Q?ZLKLMSJDoXl9pupONOdiDj5M8xio2judUOJA1G0EtWiNSSoJrvrTrsuF5XiI?=
 =?us-ascii?Q?ah9+bR/j7YrDnsyjRtz7Mx4fvZfNjFJ9vC43kbIwU8CSbFfRNwBVJxXYVl8E?=
 =?us-ascii?Q?x+BYG6t2ctui8DMgYJAt8KyhUAP7MRPJjrX3E4NwutrMoaHifVTN+glxivof?=
 =?us-ascii?Q?dUoezykSJYtlsdD+ql5LpxkRYDA0E7AItcngh0dz+cMWncf4IZDlYW96B3RS?=
 =?us-ascii?Q?f7U/4p9GMe/OqMdCe5sTPSYRaSAfw7Tpxly8qv0ULikTWFrXnBfK4oTEjFx2?=
 =?us-ascii?Q?7GB22OZ7ThEHPa8M7CLnPvplZ2l/Eh0ZzYUs9j+9BIzS/ISXSUlCxrtmkpOe?=
 =?us-ascii?Q?81KWVan/i9k6/yknTW3OeABx677Djad4t6xROOzFjfpvAAGfnfv1vRPsMM4v?=
 =?us-ascii?Q?N5S66SF41ZECsEpj2OPrb64akUhFKWjNe5z/l6sXYVJOpMZpgeqRT9D05VmZ?=
 =?us-ascii?Q?sapeXtaSS7+t5farqdBtdH3uUosEsVCx4VwYKuXvold0iqjqDY71Y9G6A18C?=
 =?us-ascii?Q?3U8/o6Gd6DinKQwxvbICflyuF8aGhemp0oWmZsGtd/W8to0wRQcBKsrTVH+3?=
 =?us-ascii?Q?KHD4FzuLSMkc9E/xe9xQaM7VnwYUBGF312+J2MpNoMkcsETcPJ22MfOFT+Xj?=
 =?us-ascii?Q?OZ0Sasdx2iKIVUUYXWlgnzf9WdoGBxaAAjFcIpNowAFQi68UMVaItU9LcQX/?=
 =?us-ascii?Q?6v38x0nIUldIbFKSjyjkYZ6RjKCrKDyF2q5pHjkRaPFM52gPG2uZZvxkBRoy?=
 =?us-ascii?Q?j2qS0R4WVOIZfjKfSp9GUEz+hoNdZA/6QfqkfYbwI2s4Fu/qjPECFHhhC2HE?=
 =?us-ascii?Q?mYVf5IYmePgubLQpJJ80WuZ7S3iUvyBQ8xPA4j0NyBDx3yWACZWPssHlNa++?=
 =?us-ascii?Q?n9OGmn2XZwQkCbv9H0IbO5ftegmERRvlRWbw?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2025 16:52:32.9727 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e80e50b-656b-4c43-0516-08ddcd2dfb60
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4361
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

NV10 mask used for gfx12. Fix it.
Put back DCC flag and default mtype to MTYPE_NC.

Fixes: b8c76c59987a ("drm/amdgpu: rework how PTE flags are generated")

Suggested-by: Felix Kuehling <Felix.Kuehling@amd.com>
Co-authored-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Signed-off-by: David Yat Sin <David.YatSin@amd.com>
Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Tested-by: Mark Broadworth <mark.broadworth@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index fb3fb31724a8..feb92e107af8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -514,10 +514,11 @@ static void gmc_v12_0_get_vm_pte(struct amdgpu_device *adev,
 		*flags &= ~AMDGPU_PTE_VALID;
 	}
 
-	if (bo && bo->flags & (AMDGPU_GEM_CREATE_COHERENT |
-			       AMDGPU_GEM_CREATE_EXT_COHERENT |
-			       AMDGPU_GEM_CREATE_UNCACHED))
-		*flags = AMDGPU_PTE_MTYPE_NV10(*flags, MTYPE_UC);
+	if (bo && bo->flags & AMDGPU_GEM_CREATE_GFX12_DCC)
+		*flags |= AMDGPU_PTE_DCC;
+
+	if (bo && bo->flags & AMDGPU_GEM_CREATE_UNCACHED)
+		*flags = AMDGPU_PTE_MTYPE_GFX12(*flags, MTYPE_UC);
 }
 
 static unsigned gmc_v12_0_get_vbios_fb_size(struct amdgpu_device *adev)
-- 
2.34.1

