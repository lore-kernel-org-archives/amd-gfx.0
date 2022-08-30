Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD6E3ECAAA1
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Aug 2022 18:41:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0922F10E390;
	Tue, 30 Aug 2022 18:40:50 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78D2D10E375
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Aug 2022 18:40:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LdZg5fKmOh/wa1XAIPhJG7B9UO64sNkSIIGzVnU2sFZYvd8qxbFy9LqZN7Gzcq9Vx3oXPQYqxmxclKki3HNuAoZlC6tteD9ECwcwVftgKT9nUhlcd4dco3hab2ZWp1jd75LKYiNrYOKnv9zsbLCF6Lcq4iUcxZWB0/XarsuqsJ8oLx4bMjl3cg7MhOVIIZ27BYVxgpYKTD0QZh5Zsvl6qxhhX/jLLZ0K2FJbtRlmwypEv0G9xm3Kq8MlWIp9po5opcExbtoQXHZJFD3h/VBBR1CLJDLXm90ayQoFSsKRfd8WGUhhk/+1Ze8coE8mnvjdmhop5r/87gD2KJ94pu/wwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZAzuNU5CFsKel0Ro9aSKrEXWoFcPov5uzw+LRfPLmRc=;
 b=gIqCaePxfd6kZ6PPpBbAWy2Bv97NaW+S0cDAJD0rHh5qrKQDrKKBvXwMmbj2bSvBG+Mc9Tx+fAezHgThRrYa/qjurGLnHOLjRuCI+6iN9A2/xybu8RLEU5jdFeNv7tNhW30QiEzv3NhgKCNy6YIS1oGi0XTjSqRNaj2luEU6VCUxatXt/JaZOwp38m/UTztFVQqNuI5oHqKudw8rs+uzzViQaQsaCzulAMecx+b4aN2pBDLc6m37TGGKErWYlU6v9hSznr20y44EIvfo7adtuwY56o6YyhPEWOPVAbtd1hfNcT+7QXlPtFHuRmzTdrUArh+jhnMAweFymV2jBOBWbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZAzuNU5CFsKel0Ro9aSKrEXWoFcPov5uzw+LRfPLmRc=;
 b=KhOrpEiHnwvs6skKCLLLdYTJwmiaRJIgCX072a9cKKrivbOkUgpRdAS9Qv38UB2WUbhkfa7epWJnCVso/aNQxMl/hpPxiuGRN9sZqlCfjp8nuKW1qb3hhM8ZfrVsU17RVbGgMNejNda6RBV1Eg5jY6jrlyRfzwoMv9hCncK0J1U=
Received: from DM6PR02CA0051.namprd02.prod.outlook.com (2603:10b6:5:177::28)
 by DM6PR12MB4370.namprd12.prod.outlook.com (2603:10b6:5:2aa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.19; Tue, 30 Aug
 2022 18:40:36 +0000
Received: from DM6NAM11FT096.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::7f) by DM6PR02CA0051.outlook.office365.com
 (2603:10b6:5:177::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Tue, 30 Aug 2022 18:40:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT096.mail.protection.outlook.com (10.13.173.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.10 via Frontend Transport; Tue, 30 Aug 2022 18:40:36 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 30 Aug
 2022 13:40:31 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/19] drm/amdgpu: Use RLCG to program GRBM_GFX_CNTL during
 full access time
Date: Tue, 30 Aug 2022 14:40:06 -0400
Message-ID: <20220830184012.1825313-13-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220830184012.1825313-1-alexander.deucher@amd.com>
References: <20220830184012.1825313-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05ee66e1-69b7-48d2-9b42-08da8ab7212b
X-MS-TrafficTypeDiagnostic: DM6PR12MB4370:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rOkKT5qIORM9zzF/z6csmt25ZNDysN9/j1hGlspO5mG4Lo/zNgz/W5vlPtA2cGVwyJ+YSo5R6pItWrCeGUr0udip/zd0XELkXVrzzgeOMmN0BpeZW0BaLTqJMTw6ooVWjhUM4paIQtDWx0A5ZgazKKDsxQMbB/yWKt3twWhkXzDMpt6vOuiF+46KJb8I0MMVtNZTwjQYm1MRTRTKUP4HRikLBLVwqPkCyhtjteOxRRfbb3R/8qUVQz+jbOldQqBmIv93kupcwJ1pHvNpfB0Hmc3Xb3yruUJCVmEWRU1QHGLuCSvrlFOMLMu4C7n7p1rsjtluXKW0WXfVUMVUIdIm9WlSnSk9xE5V1DPfbQFMrs8CjaO5B5UfY9bwatjmEbFCbrrQzjmZ8GxVq3npke/IddxTmgFUsPCDsbZasP2j9pBWMnsBu0KGjVLgWlYeymMiopcH67jfEFiogU5ofj8XJJLLoT4DH1LiCENfq/2PoyoTzURVzOXnvi43MDsygqTB5T+2Pi29Osn1PXEcNwXqzag022V4deGwJb2+3CcbC3mLdie6NW/ryPOWtoF/WrkWHgHWzWpoB8MXp5koyrqGjo83Ymj69oB+AkoXgHZonsaL9+fIAJbFLiqGg6B3uW+vtVuw8KBMdmlLBQHb3DHIG+riZ0QtS2It9ZZveDmbPBuYFlRtdstk/K2FTfhRKSDH+FR7eUoOhlfVkUfLVCNbW/Du660+jpypJcAW0Ar5oK1icqTfuM/xcjrN0N+e+S372Uo3o3ZpkITvNYmV23Tl6WVkJ1OXr3lbIixCNvIs63pyL8BpDDRuuuzggCnwNiQp
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(396003)(346002)(376002)(136003)(46966006)(36840700001)(40470700004)(1076003)(8936002)(316002)(8676002)(4326008)(70206006)(54906003)(70586007)(86362001)(478600001)(5660300002)(81166007)(36756003)(356005)(41300700001)(6916009)(82310400005)(7696005)(2616005)(6666004)(82740400003)(83380400001)(2906002)(26005)(36860700001)(40460700003)(47076005)(336012)(40480700001)(426003)(16526019)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 18:40:36.4625 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05ee66e1-69b7-48d2-9b42-08da8ab7212b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT096.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4370
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Yifan Zha <Yifan.Zha@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yifan Zha <Yifan.Zha@amd.com>

[Why]
KIQ register init requires GRBM_GFX_CNTL to select KIQ.

[How]
As RLCG accessing registers will save the data of GRBM_GFX_CNTL and restore it.
Use RLCG indirect accessing register method to select grbm instead of mmio directly access.

Signed-off-by: Yifan Zha <Yifan.Zha@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 54bce19a52ec..47ef671543b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -179,7 +179,7 @@ void soc21_grbm_select(struct amdgpu_device *adev,
 	grbm_gfx_cntl = REG_SET_FIELD(grbm_gfx_cntl, GRBM_GFX_CNTL, VMID, vmid);
 	grbm_gfx_cntl = REG_SET_FIELD(grbm_gfx_cntl, GRBM_GFX_CNTL, QUEUEID, queue);
 
-	WREG32(SOC15_REG_OFFSET(GC, 0, regGRBM_GFX_CNTL), grbm_gfx_cntl);
+	WREG32_SOC15(GC, 0, regGRBM_GFX_CNTL, grbm_gfx_cntl);
 }
 
 static void soc21_vga_set_state(struct amdgpu_device *adev, bool state)
-- 
2.37.1

