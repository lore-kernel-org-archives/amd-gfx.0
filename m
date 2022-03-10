Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24BA4C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Mar 2022 08:14:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4F2710F4FC;
	Thu, 10 Mar 2022 08:14:33 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18BAA10F4FC
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Mar 2022 08:14:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQWkQLa+aFWCxtq+NwkejYDud/vPxjUKPmI3B42yEqh/MU/zYYOgSWa5r47Q6w3AXtxT1QNSMHVzI3p/Sh/7xXrsWwmJKW2iSqJK2kqvezR8eGj2+8ai3882JocGkD9A6ijNXDEgVZaIpzBiFQp9GZVEiEo4JLC3gom6U0ecWi6wUDRpRLMHV2FX2SHdG2EDfPQKdH6UH9oYiWW3hVINRHYBivhBQBLTq98upjay4eXJ2QtOes3Ryc5BF0sBTU1Bim0DIVO4LHzOcqVy/dhCKCvE74Xc+F+m+AVUz8LYv7gDyojEM/c741S4A6wNQsSlyCRNJ1tRt4WDhAWxKTEPnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kl1vS8fXliRBuIhuwtHO9VBF18Q2s82/LvufF+a3Nog=;
 b=CswajbELgsgl8ml1PbBpOUdaCMEOigR9P298e58HtaNMx4Gyr2w4DkmEr/7ryGIp6rLOWJ49a74NBRDmwheWI5cxfFNNo8WyVYNlqZmb1r2fMjYqOgW1vxiZ/lxooO9gjfeAIwIY//qqm/8Oa9XQA1tbycMCWzgxEBjfrGxX6LCK3gyG1YBHfiCn8X61ACmpldVyFSCGJnv3l8fFpbfMsDA+OJV0dLdJn6LNIEG+M8j3MtOjbMGnXcwJx6X0mJuTU2coS2yebM+vPzscSs373Byf3UvMuiLYPZq1cpFsjHbn4lsQBbOev/G0Bq+zG4p2NrOUIdFIlrZwc4n3wd2Lwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kl1vS8fXliRBuIhuwtHO9VBF18Q2s82/LvufF+a3Nog=;
 b=ft7siwsUfrB9z7IYHd57d1y5WVtSgHYfpkBKcSjSroTZyMd+dlBHZKSWIzHJVnrQiC9nqCJFnu+B5zz6O3jNPJno8fmaYi0Im0F9nm6SxgfMED6KW5JkaLV6NDc3YQrp7VhkAufksvxf8v2Kx1KWYgawMt9ZUtHtDEOFtJcitn4=
Received: from MW4P223CA0023.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::28)
 by DM4PR12MB5295.namprd12.prod.outlook.com (2603:10b6:5:39f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 10 Mar
 2022 08:14:31 +0000
Received: from CO1NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::fc) by MW4P223CA0023.outlook.office365.com
 (2603:10b6:303:80::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22 via Frontend
 Transport; Thu, 10 Mar 2022 08:14:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT025.mail.protection.outlook.com (10.13.175.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Thu, 10 Mar 2022 08:14:30 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 10 Mar
 2022 02:14:28 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 10 Mar
 2022 02:14:29 -0600
Received: from hawzhang-System-Product-Next-Generation.amd.com
 (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP
 Server id 15.1.2375.24 via Frontend Transport; Thu, 10 Mar 2022 02:14:28
 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: drop xmgi23 error query/reset support
Date: Thu, 10 Mar 2022 16:14:17 +0800
Message-ID: <20220310081417.21705-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca77381b-fe88-49df-9227-08da026e007f
X-MS-TrafficTypeDiagnostic: DM4PR12MB5295:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB52955670FE65BFEB1528631FFC0B9@DM4PR12MB5295.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MhtkC+EtlcPZIIGrWT0zG5N7BNK6SB3voMXyYI2KBUs6LaGEzaHNL3MAGtMdr1Qh2MvXQMBXEniPzsmbXnNmRdc9u5ZHEKIM1czlfH1vUEsJmPDYyWFHOW9p8E9XiqMtm1Iahx4fcHuiCNhLnSOWF95gr2qSQscDnPsNpHJO8HpISSbHxzW+LJzRKMytUFMkwohUK6fFMk+3CZrTlhsq0kKoghXqsINla6ZM+tTNYcTaLtPTlTus0ua234nHSyOuJ0bMaSR9rh8sl99MyAXbjJ97Wd953e1dj7v7mxK+iYDJq9wEq6z8s2Ou3GjUCfLAd+Alo+Jug/VUydcZZRzq35hurz6eMUdcLNSkQaneBbLDYNurpTaPCC29uwMGeJlOhuQ6U5HaYHPi1vkwcYATssfGEjRKbyzKg52yUXrairh4H8aol/jMgsHvuuAuA6yYHjJeGIL5j9VJCLO2BV+fTY9gALKeYqm9gw66OGA4iwLwElj7S2+ckXXqeBGuwuhnoBlyo6b2Yv2IVCZUcL738I6ed9GTGiaptP4rsqsoBQLmcTltyGeIGc6HXA5keTe2GMeizHNCArE/BmEpAnSufdyv7BhfisXk/l0AaHV3lNOGQoK6M4SvtDyULuwNvV/iTSV08Wn7LxPVRdfqzQ9f6wB9LIRxZOVOMcWm3O64oMwVVAjsn6jdnUEhGwejPlD9uZOvpumOnLQ0EWLHylabpg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(40460700003)(110136005)(426003)(1076003)(336012)(186003)(26005)(2616005)(2906002)(356005)(81166007)(36860700001)(5660300002)(86362001)(8936002)(83380400001)(47076005)(6666004)(7696005)(82310400004)(4326008)(70586007)(70206006)(8676002)(6636002)(508600001)(316002)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 08:14:30.2490 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca77381b-fe88-49df-9227-08da026e007f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5295
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

xgmi_ras is only initialized when host to GPU interface
is PCIE. in such case, xgmi23 is disabled and protected
by security firmware. Host access will results to
security violation

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 4a789c789c6c..c6e52be7e8ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -32,7 +32,6 @@
 #include "wafl/wafl2_4_0_0_smn.h"
 #include "wafl/wafl2_4_0_0_sh_mask.h"
 
-#define smnPCS_XGMI23_PCS_ERROR_STATUS   0x11a01210
 #define smnPCS_XGMI3X16_PCS_ERROR_STATUS 0x11a0020c
 #define smnPCS_GOPX1_PCS_ERROR_STATUS    0x12200210
 
@@ -67,17 +66,6 @@ static const int wafl_pcs_err_status_reg_arct[] = {
 	smnPCS_GOPX1_0_PCS_GOPX1_PCS_ERROR_STATUS + 0x100000,
 };
 
-static const int xgmi23_pcs_err_status_reg_aldebaran[] = {
-	smnPCS_XGMI23_PCS_ERROR_STATUS,
-	smnPCS_XGMI23_PCS_ERROR_STATUS + 0x100000,
-	smnPCS_XGMI23_PCS_ERROR_STATUS + 0x200000,
-	smnPCS_XGMI23_PCS_ERROR_STATUS + 0x300000,
-	smnPCS_XGMI23_PCS_ERROR_STATUS + 0x400000,
-	smnPCS_XGMI23_PCS_ERROR_STATUS + 0x500000,
-	smnPCS_XGMI23_PCS_ERROR_STATUS + 0x600000,
-	smnPCS_XGMI23_PCS_ERROR_STATUS + 0x700000
-};
-
 static const int xgmi3x16_pcs_err_status_reg_aldebaran[] = {
 	smnPCS_XGMI3X16_PCS_ERROR_STATUS,
 	smnPCS_XGMI3X16_PCS_ERROR_STATUS + 0x100000,
@@ -778,9 +766,6 @@ static void amdgpu_xgmi_reset_ras_error_count(struct amdgpu_device *adev)
 					 xgmi_pcs_err_status_reg_vg20[i]);
 		break;
 	case CHIP_ALDEBARAN:
-		for (i = 0; i < ARRAY_SIZE(xgmi23_pcs_err_status_reg_aldebaran); i++)
-			pcs_clear_status(adev,
-					 xgmi23_pcs_err_status_reg_aldebaran[i]);
 		for (i = 0; i < ARRAY_SIZE(xgmi3x16_pcs_err_status_reg_aldebaran); i++)
 			pcs_clear_status(adev,
 					 xgmi3x16_pcs_err_status_reg_aldebaran[i]);
@@ -881,13 +866,6 @@ static void amdgpu_xgmi_query_ras_error_count(struct amdgpu_device *adev,
 		}
 		break;
 	case CHIP_ALDEBARAN:
-		/* check xgmi23 pcs error */
-		for (i = 0; i < ARRAY_SIZE(xgmi23_pcs_err_status_reg_aldebaran); i++) {
-			data = RREG32_PCIE(xgmi23_pcs_err_status_reg_aldebaran[i]);
-			if (data)
-				amdgpu_xgmi_query_pcs_error_status(adev,
-						data, &ue_cnt, &ce_cnt, true);
-		}
 		/* check xgmi3x16 pcs error */
 		for (i = 0; i < ARRAY_SIZE(xgmi3x16_pcs_err_status_reg_aldebaran); i++) {
 			data = RREG32_PCIE(xgmi3x16_pcs_err_status_reg_aldebaran[i]);
-- 
2.17.1

