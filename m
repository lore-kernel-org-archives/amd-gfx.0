Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEF07C6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 19:18:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 521AD10EFC1;
	Thu, 30 Mar 2023 19:18:30 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BDC010E051
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 19:18:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R8r64PQ9RZbNuqsI3Vyz/0cwP7OaDE7FtUs9oFibalBVu8TJi9MxWtQF4+YnWCuehPG8J1mGuCfAIGmO80tuF5z7ZRDaYCitGm8KZ8P/CMF2aOl/5wOWkV6oIVvZP2mGbY4kgEZUoJaJ0EObTx4fKKKlpvSNpuYBbMyWy79BtAgQP3AajyAhcFdKeeNW2O9ZJAQPRhUzi2nUr5zVV2TEBnorDAB+cB1jMlobTzr48GJlpPhrQhtMc1ZWEcYZggbPV1HasFGSPTArk0DbMnHXUmTDcKeAthCDfqR28yI8VwvJVXaYZ6x0OLh4yx7ReMfmimmDWON0t46zaEfRqIDZoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eWJ5Z/aU+yOnmuaUBP2O0+l7owFFx1x+tDKzLIvxfcE=;
 b=iI6DW33dX1q9/jqKYj6JOYAptK4o6Z2qnmIlXZDIj59hptDitwXhwSUAoHhZjRn9kmFNjE3cyW96+6Y5yzVDedqJNidouv41CdinETgCZ492I6kAn1MFzy/zjzGBxyFA371Cy4THE52xOb0kJ5CpkHKHZ6vVE2SrDACwXswJf/UK8U7SF9j/Qsu+dBPRfcyOgi/IC3bISw51Z9r0X1stVhVDqdkYJBMwwr+iPBavUrG8SaWbK9apk3wqwHVVXdIID+Yytqzii659P0ADzhi03XCIMU6e/p69hjuXlpWHaSp7A6L4UOc0+eA13Zm6VCLT3PEU7Fhye/WuMhcJ/KhmZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eWJ5Z/aU+yOnmuaUBP2O0+l7owFFx1x+tDKzLIvxfcE=;
 b=LaGhcBZoyTapJXPliKazfTSEFrwS1K2zIlwtAQ6XCy8ptKoR9eYdN13F9yVQ77q0KdMO+U8J7igRrplMCCSKAPYcvcaUUOW2tUMI6x5BpKrjC5g16hcYNle7TW/RynRH0k3MCxw4Q5rXojD4c/GKTQuCgSyC3ilQCk/OqsjK1eg=
Received: from BN6PR17CA0060.namprd17.prod.outlook.com (2603:10b6:405:75::49)
 by CH2PR12MB4972.namprd12.prod.outlook.com (2603:10b6:610:69::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Thu, 30 Mar
 2023 19:18:03 +0000
Received: from BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:75:cafe::a9) by BN6PR17CA0060.outlook.office365.com
 (2603:10b6:405:75::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Thu, 30 Mar 2023 19:18:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT059.mail.protection.outlook.com (10.13.177.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.22 via Frontend Transport; Thu, 30 Mar 2023 19:18:03 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 14:18:03 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/13] drm/amdgpu/gfx11: add FW version check for new CP GFX
 shadow feature
Date: Thu, 30 Mar 2023 15:17:38 -0400
Message-ID: <20230330191750.1134210-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330191750.1134210-1-alexander.deucher@amd.com>
References: <20230330191750.1134210-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT059:EE_|CH2PR12MB4972:EE_
X-MS-Office365-Filtering-Correlation-Id: 03f04d0c-c11e-406d-aa2f-08db31537c1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4ftuqwT5D0UY+AiKRUjsHzkhF5bGcmyIulIiTscePXIsnzwCaA+nXgfkHqj8+Y/bqlZtUoMHC1Rs+14iHIiraegDgTjXsFUKztNYrmDXiqzDqD/wGSWqVJpjvcyXh95cjtqiv1ettH82WgoLi/6UdOJeaUBNa0kcK1FGfLGue7/rd9b2AFgOPMZFIiDUIo0eGkrUkEJo0RuDxT9vpQpDVEuOUaTnZjSwS8cQsa9GNWYyCiQpMfpnI1dWWx5dhHE1Xu+2pQbizb+zpjkMBFxWz1+uG5eOA7V9V0hERI83idfUq1LNo1gJly7F79mfIpiIifE4SRe9l8FKBdG5izTd5AWuYJIiBxxXtCYpbvXtgw6sZg9Wr+/0tUoMY4QCkwH8nehnU8h7FGHuHsH+6iI4ZZ1+7bmN+gZgG/uzZxpfBSpui14p2r//AjUx9QAjd8XpqiThSdx472fD4oRyMNUA6hSaLrBcSG/D1B7ZT5o416n5f1/FSay0hbS6pFY9IcJjdyUZvecAKPHBLpeu/FCzVC5gaKoXttfsifR1lfgnGld9ZUcK/vEjefDQWr5ZDyGvJ457WyzOfUQdnMnVhafSVxqzlq8R8YtuIFkMNJLmo5MXOdbw3NXqPiIGuTPeKc3UaMyXeHlA8aHAfR7Ri8CpoDINuD+iNHX02DioTHipIn82nmGa+bL7nCJkBMhIw/biRAD+9okZdRf638uGlLO3zETG1ByiO3PVVRAcFdHeRCY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(346002)(39860400002)(136003)(451199021)(40470700004)(46966006)(36840700001)(47076005)(426003)(2616005)(40460700003)(6916009)(356005)(70586007)(81166007)(4326008)(5660300002)(8936002)(86362001)(82310400005)(82740400003)(40480700001)(41300700001)(70206006)(8676002)(36756003)(83380400001)(336012)(26005)(36860700001)(2906002)(1076003)(6666004)(7696005)(186003)(316002)(478600001)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:18:03.6888 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03f04d0c-c11e-406d-aa2f-08db31537c1c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4972
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

Use this to determine if we support the new SET_Q_PREEMPTION_MODE
packet.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 13 +++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index de9e7a00bb15..4ad9e225d6e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -364,6 +364,8 @@ struct amdgpu_gfx {
 
 	struct amdgpu_ring		sw_gfx_ring[AMDGPU_MAX_SW_GFX_RINGS];
 	struct amdgpu_ring_mux          muxer;
+
+	bool				cp_gfx_shadow; /* for gfx11 */
 };
 
 #define amdgpu_gfx_get_gpu_clock_counter(adev) (adev)->gfx.funcs->get_gpu_clock_counter((adev))
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index ecf8ceb53311..a0d830dc0d01 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -463,6 +463,18 @@ static int gfx_v11_0_init_toc_microcode(struct amdgpu_device *adev, const char *
 	return err;
 }
 
+static void gfx_v11_0_check_fw_cp_gfx_shadow(struct amdgpu_device *adev)
+{
+	switch (adev->ip_versions[GC_HWIP][0]) {
+	case IP_VERSION(11, 0, 0):
+	case IP_VERSION(11, 0, 2):
+	case IP_VERSION(11, 0, 3):
+	default:
+		adev->gfx.cp_gfx_shadow = false;
+		break;
+	}
+}
+
 static int gfx_v11_0_init_microcode(struct amdgpu_device *adev)
 {
 	char fw_name[40];
@@ -539,6 +551,7 @@ static int gfx_v11_0_init_microcode(struct amdgpu_device *adev)
 	/* only one MEC for gfx 11.0.0. */
 	adev->gfx.mec2_fw = NULL;
 
+	gfx_v11_0_check_fw_cp_gfx_shadow(adev);
 out:
 	if (err) {
 		amdgpu_ucode_release(&adev->gfx.pfp_fw);
-- 
2.39.2

