Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E62AC77B75
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:23:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EB5F10E435;
	Tue,  9 May 2023 22:22:59 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6ED6910E430
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:22:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oZaj8+dj/+p3NG1nxKrlHbOjE0h1xSu7HKlSbwgWOVVaLlKopeAbP7CjjK+N0jECHr2tHlhnWEZUbK8k6TbL7Gyfm27mPDyuY3QBuBFHj7f03oQzNLPluQFQRs6WqH/xW+Ep7D4E+4solASXJRkY5BAx5R/iPgKsCZe5kbaKNym72VPqPFE8QtLtukpJd/y+cITdmBkM3zxB2XSYwIGfxIiX9sI3gHGtuMrNH3nhj12YpAt1oDAjburSJ2bpVtNbZgoNuDKBOtym0AzLfNUCv1OVie7Ngl2dxc3jxBSp7HXNLRyfoqdOK7bBrE2iVnfCALTOE24WPg2WYQlBsu7V1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LwT3RGdyHr0LCk8bRQ6pTtTtg6Xf4Nj6daQgluHOgCw=;
 b=Zd2Ws1ZOi/5oyvl4bB2DdNqYa8ivf0KIRl/IppGUPxGyCH2Nwn8aXpiFDAc8AT0xN3Fk8HeG7pWmismy2yuEncecJx6SmDKn2b7mDAEfUyLOOBiQf6QucfkmZ0Faje/timUCW4oYzWhhzH9yTYMLuZQQK88TOlUIaFcwdTwv4UDYRFy/A5FYQhwP4q2ErcjUmZx5PDDgBzedzS8aElZI8xEkhv3t5fK0S7sfMTzZ7wNPiDSNjpxI7w1XBELZDBgTxFW4EQ9uL6rS+ZbQO3iKMsccI/1nQI9IoqUVT/HqHdudiPHhl9hYjO+YhekxSUeDHoWGalmyzDKzclyvMdzbkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LwT3RGdyHr0LCk8bRQ6pTtTtg6Xf4Nj6daQgluHOgCw=;
 b=Bxl2zmB5TiVjZT4tR0k9EisefVpg5XaOs6MTqON1hYAvC87GmlCdCXYd5+vkyBqnc8Ac7keONV/78Lh6nClXT866xYBHIi3d7WjS9rL0LNQqAgi1Gkftf85U7LWFvqPS8q2W5v/8LwSl4t363Pk9uXfsxolo48uxhHdpupns0gQ=
Received: from BN0PR04CA0061.namprd04.prod.outlook.com (2603:10b6:408:ea::6)
 by CH3PR12MB9169.namprd12.prod.outlook.com (2603:10b6:610:1a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 22:22:52 +0000
Received: from BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ea:cafe::99) by BN0PR04CA0061.outlook.office365.com
 (2603:10b6:408:ea::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18 via Frontend
 Transport; Tue, 9 May 2023 22:22:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT013.mail.protection.outlook.com (10.13.176.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 22:22:51 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:22:51 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/6] drm/amdgpu: Skip halting RLC on GFX v9.4.3
Date: Tue, 9 May 2023 18:22:34 -0400
Message-ID: <20230509222237.478097-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509222237.478097-1-alexander.deucher@amd.com>
References: <20230509222237.478097-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT013:EE_|CH3PR12MB9169:EE_
X-MS-Office365-Filtering-Correlation-Id: c280e9be-cfc3-4376-567b-08db50dbedb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VFJqANLWifPDDotjd2KMRwqoB0OAIhbziolSY3/Yxq+RqKYx4WBSSiWXChX8GZyD4fdrxmK5yE/WugqNclVeoBJdvge+ry191KLQZDMbI8flYCQyJ2eGYEbOMGTMgz7PRI14BhmAEvI3inQayRFd3vpPKWw2v2eSjs9erNMHrtPXVxDusWfvQqbusyvExveICAC9SZw4j65fefd8Z4Sqdl5dE3+biBwhOk+CaGuajtVi/F5FMolTcmt7oplFxmWTCMSsBu84sw24gG5xHsDNh5ClhBFK/j5owrgrkStv9Ix+g6roD9L3s52YCIhb17v26989eImw+rGLAt9djGkcC4U80FHWaYO8uKY3RCw3jdW7VOZ6vLCStSv8pcircu59uuEwjbSp2oMH5aTjBqJAtll+FHcRcDc9tK4OVeYQ44eqmDXqpsGfypg0yM7/yzwumOT44Fo9SNtAMS8s9ccHJBdQ/9jCM6IdPtTqW9/FMRbloNGk83sZ5EHwkwW4zUaA49C+aOEebGPmJFxyPpit3r5yOFtHkmHaivhAOkXVt/Xg7+fp1C06uWIuXgG2I4xPe/0bZDepQFTFND9UQOymj1BqaCHrUk6LyPP/xlwF6318jdfrvKFluiom6bfQcGgZeE+nD1jLPnRlC78MI+6qktg99lTk2liNtLpue5qd0D3A7bDaWy0K58k5WVg7/ARB54ntO8o81fY4bQmLeYAGJ1aRtcH1jtervASmaFAZw90=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(346002)(136003)(376002)(451199021)(36840700001)(40470700004)(46966006)(86362001)(36756003)(316002)(54906003)(6666004)(70206006)(4326008)(6916009)(70586007)(7696005)(478600001)(40480700001)(356005)(82740400003)(2906002)(82310400005)(5660300002)(8936002)(41300700001)(8676002)(81166007)(16526019)(186003)(2616005)(36860700001)(1076003)(26005)(83380400001)(47076005)(336012)(426003)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:22:51.8863 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c280e9be-cfc3-4376-567b-08db50dbedb7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9169
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

RLC-PMFW handshake happens periodically when GFXCLK DPM is enabled and
halting RLC may cause unexpected results. Avoid halting RLC from driver
side.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 7ef2c9b515ef..6cde05421a10 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1256,21 +1256,20 @@ static int gfx_v9_4_3_xcc_rlc_resume(struct amdgpu_device *adev, int xcc_id)
 {
 	int r;
 
-	gfx_v9_4_3_xcc_rlc_stop(adev, xcc_id);
-
-	/* disable CG */
-	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CGCG_CGLS_CTRL, 0);
-
-	gfx_v9_4_3_xcc_init_pg(adev, xcc_id);
-
 	if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP) {
+		gfx_v9_4_3_xcc_rlc_stop(adev, xcc_id);
 		/* legacy rlc firmware loading */
 		r = gfx_v9_4_3_xcc_rlc_load_microcode(adev, xcc_id);
 		if (r)
 			return r;
+		gfx_v9_4_3_xcc_rlc_start(adev, xcc_id);
 	}
 
-	gfx_v9_4_3_xcc_rlc_start(adev, xcc_id);
+	amdgpu_gfx_rlc_enter_safe_mode(adev, xcc_id);
+	/* disable CG */
+	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CGCG_CGLS_CTRL, 0);
+	gfx_v9_4_3_xcc_init_pg(adev, xcc_id);
+	amdgpu_gfx_rlc_exit_safe_mode(adev, xcc_id);
 
 	return 0;
 }
@@ -1967,14 +1966,6 @@ static void gfx_v9_4_3_xcc_fini(struct amdgpu_device *adev, int xcc_id)
 
 	gfx_v9_4_3_xcc_kcq_fini_register(adev, xcc_id);
 	gfx_v9_4_3_xcc_cp_enable(adev, false, xcc_id);
-
-	/* Skip suspend with A+A reset */
-	if (adev->gmc.xgmi.connected_to_cpu && amdgpu_in_reset(adev)) {
-		dev_dbg(adev->dev, "Device in reset. Skipping RLC halt\n");
-		return;
-	}
-
-	gfx_v9_4_3_xcc_rlc_stop(adev, xcc_id);
 }
 
 static int gfx_v9_4_3_hw_init(void *handle)
-- 
2.40.1

