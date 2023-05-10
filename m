Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53B47C77B7C
	for <amd-gfx@archiver.kernel.org>; Wed, 10 May 2023 21:25:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03FC410E54B;
	Wed, 10 May 2023 21:25:45 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B20DB10E54B
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 May 2023 21:25:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MClA3SJVgKHu/DwREN4rb/dDA0JKIF1+uYvooIEW6FAxtDqvCsMwe6lfkIECE5Ve/HynMNqs/SG29KOoCCO58CYnEO/RhR3YUSWKujoBhuMc7PGMKANtayl5wSbgv1BgpXUEa0F3M15SNYqypddG7AFfYBzQWVbcj0Nd33u3PhH8xE/1ia//YuxDAX44OQbYM9SSymE68fdJ55cxAuvdSXedPmzfilQP2gyd0LbszV2w7Won+nbM/h+xoAzYiHgbC4111z2vKz2fCHFRYpTMzOeFyVobGkg5umKRvKsa6BEKvdttzMaRwZj5fA/+5YW196kQJ6+l2EDPamJ/sGGIYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GUy2sJbT16QkZVj9XxblBrrOUptp1b5Dg3N8zAr/EgQ=;
 b=FwKhMRMQC1VPmaOPdrzm0xeoH6z3y/3vnhG5BUCU5NdMfh7oTDmgPx/erNNnkSRy2EA0OthD533BWWzVqcNTa+Xs2R0fQpKXfUpUloOcWTpAP4+O/fA54cyta3D05PWkNRdQrdYIxhXQelY0Mb9RpzOMI01Oitbce/Lo1++brLi8KTWKsVyOAwSRsCgNQdseSMxH28TVWkuu1VnHVsPFUU4+W8GSBDxBCESeiRSU16NT43Dmkqc8C8zetY39bBByMA4z3q1B8QJGFblIgGP6eyOVkjRbZaGecN6rD1t1P27ry+SwgyU9Bn6HTSfSjBS8ox6sr+qKM3xrH6EYaDSNiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GUy2sJbT16QkZVj9XxblBrrOUptp1b5Dg3N8zAr/EgQ=;
 b=ULr8ptAcCtJEoWjjI0OHXfU1fFuazQcdFLKvXkQSUOar6n7HHt+tE3eT+eRyjXug520wZVv4lTpQc49U7QbxzE3s0q3AH0z2dg6A23rVNDmqT2K3qf84QVwmc0EQTa1FaAzgmlUtvsPOCk2NGYPyH3g9rbu3SqI7+YOkPS9gM6A=
Received: from MW2PR2101CA0012.namprd21.prod.outlook.com (2603:10b6:302:1::25)
 by DS0PR12MB8366.namprd12.prod.outlook.com (2603:10b6:8:f9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Wed, 10 May
 2023 21:25:41 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::c6) by MW2PR2101CA0012.outlook.office365.com
 (2603:10b6:302:1::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.5 via Frontend
 Transport; Wed, 10 May 2023 21:25:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.21 via Frontend Transport; Wed, 10 May 2023 21:25:41 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 10 May
 2023 16:25:39 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Enable IH CAM on GFX9.4.3
Date: Wed, 10 May 2023 17:25:27 -0400
Message-ID: <20230510212527.2071647-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT027:EE_|DS0PR12MB8366:EE_
X-MS-Office365-Filtering-Correlation-Id: 91ad7147-e1b1-4148-7cb2-08db519d1b40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 59PbPk242RmtCDXvlNxu5TAXdl9TuNyjdw3eQoJytZkFfT2VaYRe10gH1oX1unwIQgy1t2fWf+RC3pqOD9pjBOBi+xmv4+4DRS7S+NXKs6h52ZFXUNw9PieKPryUTu4A1qTawDXrvHqVTASy9zRKV78pP8KnmqVzXTl96W9AF1xQvcmT+oGeOcCOA6S2Pu3RD312ANgGiOwOp4jh/iyZ3+hv3s/HcE6NbQZ5R2D8LAHoSvynOtgZTsA52ZjxsJSludFgGDF1Gtx+fmPM4ClN0verjQl3h23HsVbYml80+PVBBoRBKoJab7FVJCH4i1CO8Vv80ExkMbGCMChJ7oNZUsdftxTcWGxV587kg9s01XRpKL/2wgQVqP7mg7TbVQJFfomvWhzbj9AZg1GZkEFrIVmJa98C/vjCuT7aCi1F2ltssOffMCaH9MZpa+8VLbKwP+m3YRtjtbcapGn5begHAxgHs6DKQeORZ7/EYAv1XyIDDdoN7ut8bd0yrUBnMiYofzjW27jv7RbsDHI2s+Vjj3Yt7NgteR57lLFDZRViwrSw/OehiUqp8gQP2JaU49CXVbjmm4IxdCivpIWaoeSDSHedqs2jYXLL8nGe9Kqe31LDAsAeEsxI2+ZtVb7goytE4mr41rYv1B70ihddbQ6yyiLP8ckpX3prMXLSW3WfqeTM5ArZT2DZUIxRYGSg0mVDbMg0ta7+cIu37fLUmW1pkcwt0WL08/3Hza1NLL0QQgCW6O+pf34EGS66kDnFsbSONIyC4SE73JcUpV7P7GNQWw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199021)(46966006)(40470700004)(36840700001)(1076003)(40480700001)(16526019)(26005)(186003)(316002)(6916009)(4326008)(86362001)(54906003)(40460700003)(70206006)(70586007)(81166007)(82310400005)(356005)(478600001)(36756003)(6666004)(7696005)(5660300002)(83380400001)(41300700001)(2906002)(36860700001)(8936002)(8676002)(82740400003)(336012)(426003)(47076005)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 21:25:41.0421 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91ad7147-e1b1-4148-7cb2-08db519d1b40
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8366
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mukul Joshi <mukul.joshi@amd.com>

This patch enables IH CAM on GFX9.4.3 ASIC.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
index e1552d645308..755259e96bbc 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
@@ -265,7 +265,7 @@ static void nbio_v7_9_ih_doorbell_range(struct amdgpu_device *adev,
 		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
 				DOORBELL0_CTRL_ENTRY_0,
 				BIF_DOORBELL0_RANGE_SIZE_ENTRY,
-				0x4);
+				0x8);
 
 		ih_doorbell_ctrl = REG_SET_FIELD(ih_doorbell_ctrl,
 				S2A_DOORBELL_ENTRY_1_CTRL,
@@ -278,7 +278,7 @@ static void nbio_v7_9_ih_doorbell_range(struct amdgpu_device *adev,
 				S2A_DOORBELL_PORT1_RANGE_OFFSET, 0);
 		ih_doorbell_ctrl = REG_SET_FIELD(ih_doorbell_ctrl,
 				S2A_DOORBELL_ENTRY_1_CTRL,
-				S2A_DOORBELL_PORT1_RANGE_SIZE, 0x4);
+				S2A_DOORBELL_PORT1_RANGE_SIZE, 0x8);
 		ih_doorbell_ctrl = REG_SET_FIELD(ih_doorbell_ctrl,
 				S2A_DOORBELL_ENTRY_1_CTRL,
 				S2A_DOORBELL_PORT1_AWADDR_31_28_VALUE, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
index 17ccf02462ab..4d719df376a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
@@ -334,7 +334,8 @@ static int vega20_ih_irq_init(struct amdgpu_device *adev)
 		vega20_setup_retry_doorbell(adev->irq.retry_cam_doorbell_index));
 
 	/* Enable IH Retry CAM */
-	if (adev->ip_versions[OSSSYS_HWIP][0] == IP_VERSION(4, 4, 0))
+	if (adev->ip_versions[OSSSYS_HWIP][0] == IP_VERSION(4, 4, 0) ||
+	    adev->ip_versions[OSSSYS_HWIP][0] == IP_VERSION(4, 4, 2))
 		WREG32_FIELD15(OSSSYS, 0, IH_RETRY_INT_CAM_CNTL_ALDEBARAN,
 			       ENABLE, 1);
 	else
-- 
2.40.1

