Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50CA3C624D8
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2026 20:11:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2EA710EF13;
	Tue,  1 Sep 2026 20:11:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qGkuGNCS";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010044.outbound.protection.outlook.com [52.101.46.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E83DD10EF0E
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2026 20:11:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l724wj+7/2CRdwWHp0k4bFBMHfum0AP+lvaFpEk/7B68b5Dwjtto1kpyZkLsxSMR7eAsZiFWSd/92aPjhMPgmzx7nHTqahIyxQIk1JAw3Eu37YaKZEmyHGyyJOy7z/L4ecILVHSCPwMOZd2U988t4rzYDfY8SmgpxDAfXHE48Qr2dVfqncFwXZbkk4fjOxnWrUm0pMusYzDDyn+PZOKKMQtpIr+IMQMQNU39uy6dC1K5R0ZkNHZVoqLZ92SuljCuxGHoPWNsHo7jKWyEXXquanETCOVPNiZ7ux1Z6cBRwb/8ACFGQj+sMYRKdiQPKewQuk7Zg4VkXtMxJw1IVqBoSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=053jmGdbblWwKto8O4t8VxxHtKqHgofC/WpsQCmmzZg=;
 b=ad3jaKDuK1FQBQG8QVOetrXgAMrytkrrSefC4DqCVYPUmP32JOBL7b+YVq6Zm8IOIoyo6Fz1/ZQ1JkLYqEtwXv/AVgcnI1Bavgz9rGB9BoZYBup72DQAqGToNLSx/tSuXMwf4pIluOPxofR5A9tWhpavku9ylqycPnvl8B2x3T0TwBWETmmA1fdijX1X3ehbkqnMuzoFN2TADR7YbNOCyQzlAqCx3epHnrSH2T0++iyfgHdtfdOxlHOZWrpEHInBHZTW6/Gc3F8KVCJSgQPhAQBcp3JJctlKPfzqz9tpjR10HmkzZtM9FO1291um15vP6Tui8mcUFg84Bk+fEKw1TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=053jmGdbblWwKto8O4t8VxxHtKqHgofC/WpsQCmmzZg=;
 b=qGkuGNCSb9RKo9Llbji6NfVi/JxigyJcnUCSXha691bbQ97lO7lF2avqcvAjo5kBZWZU+yX6LsClIZj1Hdh9DjA0kNYwpYhNFwMlKFj646zipFxqm9c5X+1Hu+Z+p26oIWRF9F/5gSVa0DfdedEFyz7r2kb4QHudOAXODorfETY=
Received: from CH0PR13CA0049.namprd13.prod.outlook.com (2603:10b6:610:b2::24)
 by EAYPR12MB999132.namprd12.prod.outlook.com (2603:10b6:303:2c2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 20:11:09 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:610:b2:cafe::9e) by CH0PR13CA0049.outlook.office365.com
 (2603:10b6:610:b2::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 20:11:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 20:11:08 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 15:11:02 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 1 Sep 2026 15:11:02 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 27/31] drm/amdgpu/gmc10: use SDMA for pasid TLB invalidation
Date: Tue, 1 Sep 2026 16:10:30 -0400
Message-ID: <20260901201034.2960437-28-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901201034.2960437-1-alexander.deucher@amd.com>
References: <20260901201034.2960437-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|EAYPR12MB999132:EE_
X-MS-Office365-Filtering-Correlation-Id: a40c58b8-03d2-405e-e76a-08df08652974
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|10067099003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 1ADlGNK00c0hIsCanxNxM67DGDrVoY7g9bfAu0UVStoNOI/wlOkDuFyVabqP3PYE8eWe0v9UD/ovSup9lnt0Wy/37AvQleuHHKC/fo+z3m8Kc6JBzpTA7unjXgj+fYS/tEnFE5+g7EB5JaZ0GsCvlcTaek1s1fg8y2OAahNr+IpTKeTO2px68paDbniDnpjdkAd643NZ+4FqcxMw5hMSrkqETr7uao9UYWAbNVonc19ZaTo0Iyd5bK9ZjCqska0CQ8E6bbPysBOf5D9sqQN4sS9DGsATfliSSifytnqnuWVMo7+FP7ryT/YLsJCdfdQpA+X3MFs3vzhnpe13jvPK4fP5rcuFj4yqh4Tbz/M4Ddf2rUZlsDvnUZj1YuawQ0BNMEi900xYckXJYpMXNUAwkU4SgLIq0KSlBqfRc9IIL1yeHAr1FbdoOWkQeROEpBy84ASB5P0d0IrywtYPaUcbWpYZo7QXS74hntcCuWsDBnYXsU63Y40ZFx17lFr+aWFKrxCheUNASCBFDlPjXPLjcHz05DDSjZjl0EowsmyoYub1JWwXjdeE7DC3qUDKhydDqprJsExcg+e4Bkk/do0xK+sryglIepRbG/CMFrIIcokNPQ5lOCJN/0n2LASpysitq5IH/5ADfTbWDHHxrwwioDEUbxak+i3jT05/O9bnvFI3WH3livFTbOkL90/HlaFjnYIIHwNf2awGiN8sYbQ3LQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Z7zaPlBim/zfmxWU2TdAx08btlTiAyqaXJeX+lSc+qCr5C3zrBPlXGsBANTLcFCmD2rRN9St+PNencqoPHRlHLmL/7MYtNy/WCT3fidmNMmyoHFQiRFhr6CmdkmQsd9aYIHSfkgiLpXQ2lL0LYjK+oOATGhpXpYbxpnJP/Q8/kY9zB130OX0Ct79M72A9FCxM644tcqTBtoOYvdo6R5CGQLB9JeKVjIJVzPsR2Fs1LMt0kCiq6vOw4EMsXK3Qp80NWZZXawlau0lUY7O7DFHy/fEAYy8E6ZDtGHgPTSneLUaVqz6DSmftkJKirqLiKNeQkdlQpdlWJ9xZWCS0wbvafNLhiOwie8zArAZIF02PAPiI2bVhfv4bHVLZL/IpbObLOiOIPDnWBmtUGRMWtl0gVAXxAMLGTvZCA3SEFlP2JQfHfjWs3SH356dLDSy5nnm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 20:11:08.9709 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a40c58b8-03d2-405e-e76a-08df08652974
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR12MB999132
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

Use SDMA rather than MMIO.  The avoids the need to
disallow gfxoff when invalidating.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 7eb34d55565cd..e716a86ba2913 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -974,8 +974,7 @@ static int gmc_v10_0_hw_init(struct amdgpu_ip_block *ip_block)
 	int r;
 
 	adev->gmc.flush_pasid_uses_kiq = !amdgpu_emu_mode;
-	if (adev->gmc.flush_pasid_uses_kiq)
-		adev->gmc.pasid_inv_method = AMDGPU_TLB_INV_METHOD_KIQ;
+	adev->gmc.pasid_inv_method = AMDGPU_TLB_INV_METHOD_SDMA;
 	adev->gmc.gart_inv_method = AMDGPU_TLB_INV_METHOD_SDMA;
 
 	/* The sequence of these two function calls matters.*/
-- 
2.55.0

