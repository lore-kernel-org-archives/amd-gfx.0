Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB68EC7EE23
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:06:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E10E10E3DD;
	Tue,  9 May 2023 22:06:06 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6147810E3E2
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:06:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ECJeUSnV0xV+bF8Q0hpQo6k30H9m1O8UclBMFBhsBViCSMx2tHko0f5PjEKm+Mo6Ks1e3J+TJ6gGOqlsPmN6YklxbbmnwBDg1hSxhNC4spOfa9JrILF+PXvNLGFQd8A0cFhqfEXd8ZZSqD9br0kpfrLliLQwDnWfc3CouXOekj517RvJq+VKHv7W3kxJuABmuBDahnEFc4AQ97IXCVITuONcHSODssmg+zSCJlqOImKMIOPWZ5QuySpgRKqoPx/3zlf4QAADqt6rhRkgsdmliNtxfjffVJYjLPwRf6mnDgECbc5dUnNMnkYNQq2DwMpPqy33tjPupQ54LegOku0cFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k/rmFbBcuv2DQIuRX8/Xgi+RAF/d1NYP9YkHCfgtPi8=;
 b=CmjEphmeJWg4hVv9cbIYhQlaPaozdrpJO+pOTxi3wLvD90M0iCS2rNdLYr8opnSWicBYHAtQoHO8ozKHmsxEm+I2f73f7CIWjfQ2hwH2vJt0ouOus9suBHbahWLIXjN/bV8EJgDxr5sEvsocVOi6UlbcwVmMR75RVsk5TVXlu+0XVTro0788iEbInMvHDoP3/7mE11O7F9MWSeXw7Ir2eDLmkNfgZgArSHWTb3h73pRI0nzP4B0GCj7za0Ga/+TbLTS3bMoM6c4mB3FSt7h+6Nycyo3YYgm6H4vYbGvz0rsSnBsLdwLgqRgHOFJbwoteTNDPfPozqlyZyDbN/j9RUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/rmFbBcuv2DQIuRX8/Xgi+RAF/d1NYP9YkHCfgtPi8=;
 b=tZ/ea4lSfiNmoaOkQTTA4iKrtlqjcPEC3uCNqbfA8+5PFElgdpTZqip8rayqOrGvwAuE/jNA5xEYbUFllh9eEJFB2FZVmSi7rLBKGzWCADfR8MFJZIcbc3BrQfvvTRfdBTyLiEdClc2UjunhynKRrM3AHdKm3ce/DkFpfXg9jQE=
Received: from BN0PR04CA0082.namprd04.prod.outlook.com (2603:10b6:408:ea::27)
 by SN7PR12MB7812.namprd12.prod.outlook.com (2603:10b6:806:329::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 22:06:02 +0000
Received: from BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ea:cafe::5f) by BN0PR04CA0082.outlook.office365.com
 (2603:10b6:408:ea::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33 via Frontend
 Transport; Tue, 9 May 2023 22:06:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT027.mail.protection.outlook.com (10.13.177.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 22:06:01 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:06:00 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix sdma instance
Date: Tue, 9 May 2023 18:05:44 -0400
Message-ID: <20230509220545.474998-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509220545.474998-1-alexander.deucher@amd.com>
References: <20230509220545.474998-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT027:EE_|SN7PR12MB7812:EE_
X-MS-Office365-Filtering-Correlation-Id: 43911e16-b575-4560-28a9-08db50d993a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kZfhPXYY4IyC8jLUbZ+KyoOgNqCSQD05qf5A6bsU1Tqbhw/e4RozldTaNwbK0C0AgEfdaMzuPRl3rB6izAMCcRaNio5sqcU3uJf3ErNuBVPo1IgZA7fxr1a7GiZHqmaIvyUtC+4I6k9fk1VWGuggFGjMtUEMTNYFZFush7qMSxz1f74sosrOGqEyQcqkY3sBbFmT5OikFtTyQRy0KGX3rJQyk3ewjnsplswbKruGF8EbQhGIEg2ltbiS/DFJS6WOVXWLCEMwKvBKLRbEF5n/UjDMUk+23T1I/yx19qddYHcRjJaEbi6Zg+H5N5hRMKT+s0ZLWSi6wSLE7CBxCm+mcE4fKZqNSjAZ98Anyb1Trfbo60Yzf0mZ6L3aXfMIyKracIIafBlpKHgORIz4fp9rld3KM6Lh5wYbJ4PCLgq+XVaKUg0W/o5wdiM3PnjZ7MkolEI4CWmkQirWTOKK+MtGwbCVhopVpDoRvEZq0lL/yLxCJ/Kf5indokBEDmKRPI+1arpIdLOtkwteW/H9eFz43tpEwJXXR5B60KHPUDcRLO6xLN5LaahMcIIHrRFSHu8G9a3RAwsp3IkT34Ss1Eq9WmbNwcOe/1gG18/beqXsuYlcwYDIvz3mzGNTRQ5sFSH3gLZmx+o874dTiapitqqMRkbyWBfI033xNw7X0Naa8IFs0F3DKhhfvkTRu5RWug1PAHN93lWhTxxQeoBOzLam+2D2mL9tA7jZTA9LYhbrfpc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(39860400002)(346002)(136003)(451199021)(40470700004)(46966006)(36840700001)(36860700001)(36756003)(40460700003)(6916009)(2906002)(426003)(70206006)(5660300002)(40480700001)(316002)(8936002)(86362001)(8676002)(356005)(70586007)(81166007)(41300700001)(82740400003)(336012)(47076005)(83380400001)(186003)(16526019)(1076003)(26005)(6666004)(2616005)(4326008)(478600001)(7696005)(82310400005)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:06:01.7682 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43911e16-b575-4560-28a9-08db50d993a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7812
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 "Stanley.Yang" <Stanley.Yang@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Stanley.Yang" <Stanley.Yang@amd.com>

It should change logical instance to device instance
to query ras info

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 570ea68c521f..bf47eb33c12e 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -2123,6 +2123,7 @@ static void sdma_v4_4_2_inst_query_ras_error_count(struct amdgpu_device *adev,
 						   void *ras_err_status)
 {
 	struct ras_err_data *err_data = (struct ras_err_data *)ras_err_status;
+	uint32_t sdma_dev_inst = GET_INST(SDMA0, sdma_inst);
 
 	/* sdma v4_4_2 doesn't support query ce counts */
 	amdgpu_ras_inst_query_ras_error_count(adev,
@@ -2130,7 +2131,7 @@ static void sdma_v4_4_2_inst_query_ras_error_count(struct amdgpu_device *adev,
 					ARRAY_SIZE(sdma_v4_2_2_ue_reg_list),
 					sdma_v4_4_2_ras_memory_list,
 					ARRAY_SIZE(sdma_v4_4_2_ras_memory_list),
-					sdma_inst,
+					sdma_dev_inst,
 					AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE,
 					&err_data->ue_count);
 }
@@ -2153,10 +2154,12 @@ static void sdma_v4_4_2_query_ras_error_count(struct amdgpu_device *adev,
 static void sdma_v4_4_2_inst_reset_ras_error_count(struct amdgpu_device *adev,
 						   uint32_t sdma_inst)
 {
+	uint32_t sdma_dev_inst = GET_INST(SDMA0, sdma_inst);
+
 	amdgpu_ras_inst_reset_ras_error_count(adev,
 					sdma_v4_2_2_ue_reg_list,
 					ARRAY_SIZE(sdma_v4_2_2_ue_reg_list),
-					sdma_inst);
+					sdma_dev_inst);
 }
 
 static void sdma_v4_4_2_reset_ras_error_count(struct amdgpu_device *adev)
-- 
2.40.1

