Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14962E71072
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Sep 2023 14:13:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B16210E135;
	Thu, 21 Sep 2023 14:13:26 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8569E10E135
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Sep 2023 14:13:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WDX9rAzUr2kA4SuECgyVX0ihZWCtKXT18gjxP+xYkd0tjdOyut07hUxU7MG1Tn4NPsboUXXnspbGljDqeFPGeBVua/uq6Zw4dydC2EG+He/nAJviwS31oR0SSNkQOfPkP5O0aotCVsIBFWZKumJzv+QRxXaxauyJEithH6yA7WimzuJFNK9XbTa02rHRsJ2/t0dydwCRQiVZJ848jhhF0bl16MmB00mdPNSeK8Z8dfsiB4bbWXO/eAsiK+vgpXoshiFhRcbrCu53bc7tS+dp/FuJL3Gvw47i8kwYOXavScb/K1V1Gj2CNd3g788UwMWsmkmdDPLUUGBwe9PcgINm5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kC5Y5y3IZ0lhv301ltLGCdJkfwrf0BMV+iPdGILABFE=;
 b=dq8LCeyikZ7JQR9hErFS4a7Cqmy+sy6t9+ezOE8n01agH2Mz5eMsUD53WDLb8GLiHitnVbce4+Aox9NO2uW248XkaC2d9uVY1e4rrj8VgMOkAv3X3BpdITMrJsyD38fDf4VeyB6tfIQgqDbQ6hyk377ElTJdEgwQkw/9eTvNdQVPy3PvbOgQK1jB5VYPea0Is1xHRcrx64cwVQ/6F3pLMx9DV4Wr5lx5cFsjlBfHb1ck7j2+DLs1Q20DW234dC05rX+GAdWvJV9ubE5cHEE4MJoV4HNWh9cnb2t/L87WPnMRRAgpQsKTJAPT+XWVr0Zqm+F9Uu/BKLD7+iR4U/J2cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kC5Y5y3IZ0lhv301ltLGCdJkfwrf0BMV+iPdGILABFE=;
 b=U8oxgneJZ8Ik3mTiy/DB8lYPkuZHrbdSiYUNcwC1j+gIvQT8LOrpO+j8Ui4RiHKb7cRExSKzZJYBTxgn2Qb1JPfbCYG4lZmAS4oCkluuzFxmX8tvx9d2BZlYs6ofnJcH1k2KOFjMHTOmVrxpBnBmPqV2pfAb9qxvIAI4GY6bHkU=
Received: from BY5PR13CA0012.namprd13.prod.outlook.com (2603:10b6:a03:180::25)
 by SA0PR12MB4397.namprd12.prod.outlook.com (2603:10b6:806:93::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Thu, 21 Sep
 2023 14:13:19 +0000
Received: from CO1PEPF000044F3.namprd05.prod.outlook.com
 (2603:10b6:a03:180:cafe::c5) by BY5PR13CA0012.outlook.office365.com
 (2603:10b6:a03:180::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20 via Frontend
 Transport; Thu, 21 Sep 2023 14:13:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F3.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Thu, 21 Sep 2023 14:13:19 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 21 Sep
 2023 09:13:13 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu/gmc11: disable AGP on GC 11.5
Date: Thu, 21 Sep 2023 10:13:00 -0400
Message-ID: <20230921141300.415876-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230921141300.415876-1-alexander.deucher@amd.com>
References: <20230921141300.415876-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|SA0PR12MB4397:EE_
X-MS-Office365-Filtering-Correlation-Id: c905e87c-269b-4e23-0e59-08dbbaace7ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KhegDXr7ewpL9/qWYv5Dc+qCsR0rSLvzQ8sr4ssWqy30KLIM2HaPWgklLMJ67CwPcgz2Zkj/Hsyavx9rb717fk6fo5BLrmZUedI/cZQnXnA617yjZlh+C2AH6ggzHGGR44gtC6j9lX+Nko0Fuy9lCeQMbkfcYgU1S74eynE+4NSkrgWcsEXPPpQSUAGwkilASeQpBEkMQZk/Kcs5TQfaVK2aYXaRY0qT3340Njo5ybOmNuKZkIOr0Cx9gYCq1YoN3+YNjHW+smC3KpSOap/cs2ookCI8BifU0zutzVePTBjCr8VxDJTL4/WY5SJpEoSBXHrFfrYs8hVeHc3nA7wfiZATpdmQoOj7tweSTkVFAAGWWVlZbVPY/GTG3gOVb2RAnv8W0qzsctANmiewROXCAmmLAIt2PmaxiA2E8cbUV2N6wf8ih9gVdRdz/HCdhWtecPikhfJEvpr6SlchgFvJyQp0jOViJxoU1VfmpFYwTEs9aHYxjtGaoCPv98+lHz03yLaoUAiw3Co0Oipmh4QGOa1N5dY8jGcqC7kZAGMuHHLHQVXOy8ALRU50BljcWeCIQ1SR3fAF2ZG2MHAeEGpfczrENZbVUIaJIqWDisnRwDhE3LlAARgqj/KktgiTaGEh9/iUtDeFFMOcuMbxBAW11M6eghODSvNWxa8lYd0HFftt402Didm+gHcyp86PCC/jgKj4q1hwNIPKNBBq+mX+USXYdgCaSMVDCkJU6QNU97e5qg3jIRF+z9mgTF9+Or9K38Bgl/vPLPEqZCyq+KpFHA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(136003)(346002)(396003)(186009)(451199024)(82310400011)(1800799009)(46966006)(36840700001)(40470700004)(316002)(36756003)(41300700001)(70586007)(70206006)(86362001)(4744005)(478600001)(6916009)(5660300002)(47076005)(4326008)(8676002)(8936002)(2906002)(83380400001)(36860700001)(426003)(336012)(16526019)(26005)(1076003)(40460700003)(2616005)(82740400003)(81166007)(7696005)(40480700001)(356005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 14:13:19.1044 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c905e87c-269b-4e23-0e59-08dbbaace7ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4397
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

AGP aperture is deprecated and no longer functional.

v2: fix typo (Alex)
v3: just skip the agp setup call
v4: revert back to the original model
v5: back to v3

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 0bd7de1488f2..5b457297d468 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -689,7 +689,8 @@ static void gmc_v11_0_vram_gtt_location(struct amdgpu_device *adev,
 
 	amdgpu_gmc_vram_location(adev, &adev->gmc, base);
 	amdgpu_gmc_gart_location(adev, mc);
-	if (!amdgpu_sriov_vf(adev))
+	if (!amdgpu_sriov_vf(adev) ||
+	    (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(11, 5, 0)))
 		amdgpu_gmc_agp_location(adev, mc);
 
 	/* base offset of vram pages */
-- 
2.41.0

