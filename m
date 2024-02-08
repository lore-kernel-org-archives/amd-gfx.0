Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E378C48260
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Feb 2024 20:03:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C827210EC6E;
	Thu,  8 Feb 2024 20:03:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Vq41fND4";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6947110EC6A
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Feb 2024 20:03:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kgrr7725hSK+iFcQhLZ4xkyG5EazVGLIQahpNdcSI3bT3Qkp4MoEqCyro9N1Q3WMrLUZ2Awz1SHieUZNE28i74Y9D1xk7hdCYW9ZL1sfIVUzESSPP6OQOQqNs73KUMJvYeChMiBJsJhL8KRRtuCDjECIJKP7ruejo+CQIllkDfRXLeWPrU9K1z9A6gFCBMUBtIR8/fpLYd2wYAtT3b1HdB9bzDqD4KqNdZhMFW3/3noMYor2CbTst+UA1KhfJ3QwaxYhhhveeDRblZ0sTupEQNHYL0zjhwS0UR5NWvQApnQqeBXjAKuyhOh626MXbzQAqN+z58WGhYP+Q4OnoAwmVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xwod7g+ZH9gDtHkB0+uYNl9cZDetQjbjb5K1bf++0hk=;
 b=Wg1VM8os9si4Ch7RGZQuIznuavUpOHvqEX4LVrtrfGGyuXNoeI9fooPZl/6YaceJIbRlxVzqo8NCuWSiNIoiLSTFuDXgbjkylS7gujfhzICeqNJhUXeTMbt8yPayHe+jeDAvTpGCkAF2J6kUDl49XJ6yS4RG4eO4Rzv8qhJzIxTHVj7Zzz6kjeiS3+vmbp4NyVLf794WDk3n90lYtBFMljzig4rb+Owvm29cEiLu3NOlEsZhCJvfJHYeNsQqFw9CLUpgbZLs8R3pzkokh4dMwnWrjy/lShVwR7YKV3M27E85aZMcsmWuqwdV9lWrbHzsKJUeVtjB/3dXFUfApJ4gHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xwod7g+ZH9gDtHkB0+uYNl9cZDetQjbjb5K1bf++0hk=;
 b=Vq41fND46WZ4srl5RM8omaE9eF24h7MRmwm6YvsluuUWcqAn5EmrGRE1bS5kZ/oqN1LgWS2woz04VZ4Ykezq/c5iQ9yo6sSZucBMBQsC4SkPfWBnUtmbvuPlu4l5rVUIXenZHE4vZogslai7kgNjZzguG5q3pYnvivRkn6sgaF4=
Received: from DS7PR03CA0131.namprd03.prod.outlook.com (2603:10b6:5:3b4::16)
 by SA1PR12MB8643.namprd12.prod.outlook.com (2603:10b6:806:387::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Thu, 8 Feb
 2024 20:03:15 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:5:3b4:cafe::8b) by DS7PR03CA0131.outlook.office365.com
 (2603:10b6:5:3b4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.24 via Frontend
 Transport; Thu, 8 Feb 2024 20:03:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.13 via Frontend Transport; Thu, 8 Feb 2024 20:03:15 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 8 Feb
 2024 14:03:08 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Sonny Jiang <sonny.jiang@amd.com>, Leo Liu <leo.liu@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 3/4] drm/amdgpu/jpeg5: Enable doorbell
Date: Thu, 8 Feb 2024 15:02:52 -0500
Message-ID: <20240208200253.409130-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240208200253.409130-1-alexander.deucher@amd.com>
References: <20240208200253.409130-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|SA1PR12MB8643:EE_
X-MS-Office365-Filtering-Correlation-Id: 87c27c9d-ae47-40ea-6529-08dc28e0fc63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BsgyJXY3A6Y0u1bhILbP02cdn2DnQ7l8TGboCXzreDBuIht7av4dyBfZ3F6RCd5Uja1tXZnKtvrcAIAk6LUYAeORdqFt2RFkWKsrrhVIyc7oIx/+wnZkt8bvxU7r32hNUgazZQ0YneQuofeJ3CvW7BR6XaG8VuuxPJ3zXzxJRFkEr1b3/LiXU6XYMfo5Lan//1R55i8X7RKlqDeWBuU42Gd0MjykThi6IJpORTkoWVmRhxWyxICMismxfYVuqFmZMiHht2TsIUUJALvXPTO7NFaXtxCoVY8JbDru8TB/Ai8ScF1Rkz8O4oTU8263R3K+K5MwsheiNfsNOUJTjXGjnrdt8lErbh9tssVjvPOtTqcfgESI2bR1CsRledme2vPNPPdT7eDuj5ACGi0OxEfaG8eHmqi2SU06EI6/Z3UyP36CrHvM0hlD1kzbEjd2AH7pVStzHsKE8zXXbWrFYrdrwy5sm3VCySSWdBMTkhSyqxyNyAdDefbMoJYtHrFHCd2LtbTI/hGp0jCqM3aPLzFAD5+GWxqBEBKe68ry4cvWPHZWtEYiJAPwLFvLBSX89lJUj3effdr9JluprShCfFLSzXMqOd7loltx80T3EpoBh4c=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(376002)(136003)(346002)(230922051799003)(451199024)(186009)(82310400011)(64100799003)(1800799012)(46966006)(36840700001)(40470700004)(86362001)(41300700001)(54906003)(478600001)(336012)(70586007)(6916009)(426003)(81166007)(36756003)(2616005)(83380400001)(82740400003)(16526019)(1076003)(356005)(5660300002)(6666004)(316002)(8676002)(26005)(70206006)(2906002)(4326008)(7696005)(8936002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 20:03:15.0831 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87c27c9d-ae47-40ea-6529-08dc28e0fc63
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8643
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

From: Sonny Jiang <sonny.jiang@amd.com>

Add doorbell for JPEG5

Signed-off-by: Sonny Jiang <sonny.jiang@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
index 71c28cc06605..e70200f97555 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
@@ -85,7 +85,7 @@ static int jpeg_v5_0_0_sw_init(void *handle)
 		return r;
 
 	ring = adev->jpeg.inst->ring_dec;
-	ring->use_doorbell = false;
+	ring->use_doorbell = true;
 	ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 1;
 	ring->vm_hub = AMDGPU_MMHUB0(0);
 
@@ -134,6 +134,13 @@ static int jpeg_v5_0_0_hw_init(void *handle)
 	struct amdgpu_ring *ring = adev->jpeg.inst->ring_dec;
 	int r;
 
+	adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
+			(adev->doorbell_index.vcn.vcn_ring0_1 << 1), 0);
+
+	WREG32_SOC15(VCN, 0, regVCN_JPEG_DB_CTRL,
+			ring->doorbell_index << VCN_JPEG_DB_CTRL__OFFSET__SHIFT |
+			VCN_JPEG_DB_CTRL__EN_MASK);
+
 	r = amdgpu_ring_test_helper(ring);
 	if (r)
 		return r;
-- 
2.42.0

