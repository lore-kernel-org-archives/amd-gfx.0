Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D7E0C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Mar 2022 07:55:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4B4610E27E;
	Tue, 15 Mar 2022 07:55:24 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 957F410E27E
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Mar 2022 07:55:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=An1OefmTYb1IL3ZYBkme1UFf+Mg6GzoUR9Ckk91y1yOAAkBKpcJ6i94CKE1GnejanWOplurD2Bib98qe33Q1DNkIy33txmHUBsZI7GSt2H+yL8DdHhkrt5aykJk6MZdOF26oms3niJgqciJPJ+mrjDnulXTMBEF6ajCTdH9fiQV7OHaLjZVh0/1bvmY9g2y7iK5+slU1AfedHICkcZPCLS5xC89/lubgMPhWy0cOXOKli6TqGRrAAx7a9A5YuzCytbi/INWH+NE7+OKSnt2Os9znSawICO1N6xTgy+4abH76dIi1g7ejbYzk9tdgEMgifblgSTthyfv8jJSB5ona6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xsI2Wc/5zEvekLHyThjLT86Ukhk8EtAaOJBrJpt0lg8=;
 b=chVmp/ftkrFBYMhppWV+6V/JDPAGfJ0hjwOc5KgGGuIdVLYyJo1MBnnneAiwOe+d3KFrnbrQvKO4DNEWercHR+t58qPLKOoYci+m6Zt+stKK3MX13BRS50TIDym+bf+jC11pL96Fb8RV44cnvc9tviPjprxk75IY2R0R7/yMsJ3stoTIvDr+hAjVHif1U3sJlxidtwt/u99mYS3VH2iVgLRol6MpSsvQzZHEzNcpUPjtwlmfb+jBgHUpTxpL1zTXkbb36cbeAFhlRHkVleFceAWYmVitp5/zfjbAVlsO4iuGTxqQl/ODpwKSf9viYWxU48yuRVCC7bCZmRS8wetbDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xsI2Wc/5zEvekLHyThjLT86Ukhk8EtAaOJBrJpt0lg8=;
 b=gyUDJaXAcW5gbwXLB/OS0Y58UDDbn9VJO2+d9hs357ZiT9A8PYINHHQx8TKRIXQw7o4IijJmAmQv1bGmzIwPPz/Atau89bo7lE3ykqYZCGtXRKDHUfA4puiqZAeDhUrONrzzQoH4JNSnnAVJun1GEOYNTPZCwqEFqjBfGCsWaNY=
Received: from BN9PR03CA0651.namprd03.prod.outlook.com (2603:10b6:408:13b::26)
 by DM5PR12MB1596.namprd12.prod.outlook.com (2603:10b6:4:d::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5061.24; Tue, 15 Mar 2022 07:55:19 +0000
Received: from BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13b:cafe::79) by BN9PR03CA0651.outlook.office365.com
 (2603:10b6:408:13b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.23 via Frontend
 Transport; Tue, 15 Mar 2022 07:55:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT057.mail.protection.outlook.com (10.13.177.49) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Tue, 15 Mar 2022 07:55:19 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 15 Mar 2022 02:55:17 -0500
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <christian.koenig@amd.com>, <xinhui.pan@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: conduct a proper cleanup of PDB bo
Date: Tue, 15 Mar 2022 15:55:04 +0800
Message-ID: <20220315075504.25827-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe99efde-c4f4-4a54-1d19-08da06592657
X-MS-TrafficTypeDiagnostic: DM5PR12MB1596:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1596FF73ACBC55BDD2B7B502F1109@DM5PR12MB1596.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fu7aqg0oZlQ3QHBk8/UatLtIyUNex3FjIDJ9pFus7T49ew0xACnOYUh+2XyPGvQTeysKX+dKrg5cheoWbQm3tvdX6l8OC6NNtZlLk5iEw8A7fgjtsrXKncp1H7bQ6Zm1goKGXenKQotna7GSIYe64QnXoSj+7PW4JNEjhm0EFVuJ+n5lW67GGbGmoka30H6B4hSt1mxxln9CqPmG5jCq1R5XtOh81VAY/JV3FthcOO2V6q2j02HNuKj4EqkPBdg0kzqIN7uwhH7yhm2zKow33R1l0ClAQMSn54yo+0ZwRDDh2MaWEl6GKzElH11q4RyFbqG7kaAuhJGEBv7F2sNjwMCxCxpRI0pNkxb4+zr6rTkGDXvqpT1IjeyEDcBn5VayiHLJygR2+hv/flhB99WWhg6DrWhsLOtwFFI33bXxH89M01SFepStq5JJB6J4WfbE5905hB6U3X1eqZ21Aj/XbtqTOpd7YrHKmsrrLn4F2UJHfn+3Rf82TYthhykhLVwhPvOj93Vha7pD5dilFEAW/4rtkIHduzWjmdA/k4pcF71d5Qd64mmmLT9N1SCCmh7bsyK9QVFZDGi0GaO7sK5ml60oR/xRDWNJu5i0fuIdR0YAWrhuqWg2WqzjZB6pRePbxGcTZeR7pPmjnocPKdIvKGtx9Vm2/yfaQ2O4bQBiVmCLL/zu4PvMHL19G1wC6ZYn/w6yaMe0qeH9OVoZZjZVTA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(66574015)(186003)(16526019)(1076003)(426003)(2616005)(83380400001)(86362001)(47076005)(356005)(81166007)(26005)(336012)(82310400004)(40460700003)(36860700001)(6636002)(70206006)(2906002)(70586007)(110136005)(4326008)(36756003)(316002)(8676002)(5660300002)(8936002)(4744005)(44832011)(508600001)(7696005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 07:55:19.0820 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe99efde-c4f4-4a54-1d19-08da06592657
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1596
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
Cc: Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use amdgpu_bo_free_kernel instead of amdgpu_bo_unref to
perform a proper cleanup of PDB bo.

v2: update subject to be more accurate

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 431742eb7811..e4e7e6dbc6fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1721,7 +1721,7 @@ static int gmc_v9_0_sw_fini(void *handle)
 	amdgpu_gem_force_release(adev);
 	amdgpu_vm_manager_fini(adev);
 	amdgpu_gart_table_vram_free(adev);
-	amdgpu_bo_unref(&adev->gmc.pdb0_bo);
+	amdgpu_bo_free_kernel(&adev->gmc.pdb0_bo, NULL, adev->gmc.ptr_pdb0);
 	amdgpu_bo_fini(adev);
 
 	return 0;
-- 
2.17.1

