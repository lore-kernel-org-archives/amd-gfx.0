Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E07ECC43334
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jul 2022 15:14:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AAFC14B795;
	Tue, 12 Jul 2022 15:14:11 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEBA614B390
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jul 2022 15:14:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JBMUBCDpBvJ3dP+oAAScjh5/VXGehdFoqadxu2+2Sjn9z6fqZfmQGiSz1IUnpnPaK4HyluqN/lXyTuXnHP24REIYQlR1RgwFfVMq5fT38Zq979KbOPevTFKhqZ32t11yBAems//rliG1Uycrx4G2gyJKUoN5Qk5xS3J+EaDOgxheOGQ1PLW1yV9SHmpuqyRbXf5PwR8DCLeCTnLguiFaaWXOjAA/iL02DggoxnmpvU8NAJJQqTJq4jy9lKK8oElQzKTCLy8x/OSbup0l7Viv2DRaOjHKHAMZtW3PRFS72Xy2779LT8ARIdTi2iiEsvzjp5TDNHq3PM2kuNuEZHagLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vqiwb1+00cu/J9gww79ULtySiorelynlm/+Hs0wDNl0=;
 b=no1KRaplpIkQFIyyM2/KWCsQD9ApZdE8mlqdInqVsx0sGdCiiPSMuHbTprlxZI/CYF2+3kJpAToVj31lQQlNSCEoJ88muTuzMGRtw9ic9KMPlIdYd75b33c0+YwcqfqfoXmBPCvtFFa+h0T1dwN7SXOr0htKAcriJ8nNUxJVzePkl5J/Ns4IYM7oNx0OsTvPkD/WH/4bm917A8M2/sY9LsfsKVfV00sC+T9d1z1hOYWbxHJ+OD7KZrHRatXdIRW2rbEVG66BRb6dcC1GR9nvhYRaKcRid5eAKeahqR5u27t9TSY6Z6bQIii5pRVe+quShX29F++1Jd2byhXzgEq4rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vqiwb1+00cu/J9gww79ULtySiorelynlm/+Hs0wDNl0=;
 b=O7e2t9o//o9pvSLdAo8843tJ/nMcYUfyumkLRpPpPh0yj1PMck/vamku/E7pfFKg+tA1oRgp0qZMqdP55uqVjeo4PQldBgGPpU9KN9ZFUdtLobl0MO0pvGYOAIBnaI7zjGbC582GgFQXgpZ4v8Azpm6I83HhaaF2E0QRTPV6wug=
Received: from BN9PR03CA0987.namprd03.prod.outlook.com (2603:10b6:408:109::32)
 by CH0PR12MB5369.namprd12.prod.outlook.com (2603:10b6:610:d4::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Tue, 12 Jul
 2022 15:14:04 +0000
Received: from BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::5c) by BN9PR03CA0987.outlook.office365.com
 (2603:10b6:408:109::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20 via Frontend
 Transport; Tue, 12 Jul 2022 15:14:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT013.mail.protection.outlook.com (10.13.176.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Tue, 12 Jul 2022 15:14:04 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 12 Jul
 2022 10:14:01 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/4] drm/amdgpu/sdma6: drop unused variable
Date: Tue, 12 Jul 2022 11:13:47 -0400
Message-ID: <20220712151348.3047904-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220712151348.3047904-1-alexander.deucher@amd.com>
References: <20220712151348.3047904-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89030a70-1541-415e-4a14-08da64192862
X-MS-TrafficTypeDiagnostic: CH0PR12MB5369:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EgG6H6b7abPV9JdcHGZsMdv2NyNk+2dJnhsxSbipYugyUQT8d0ZtVCcBrX2rgm5XYa13IVZXcuTQTjJuCA6jfvk6vXvz+BA1pITMc4voqM77CdZEnIRLFpUV/x8rqN90XH9sKkDlT2fm5/OcEcU52fPvHSs+kcqPca3bJO/tsW97dkDmJRuligrl0yo4vnq1x7CzF4FHbDcgJdm4GFbuXKYkAMNcfxvrKJ9+VjjxMOIMw8m6WksJLrcvXZF+J9ledGkakLvzL691zblLCt6lSX8wxjaJT9Wm1di8E+PDlGB4YDUWHFyIFaAYCoDxGJ9opNA/LqVf2epUJpMh/eVY7EfAkUxW88yjfypx6yPMXLBlKQJbpQUwwwwWqRBUkhVRUo/YLM6NTPHIPUvC1/P0MIeDaVFoIZaPJlwTWxQRUp2xFXqilC/aaghinim1SFqm68ta8i29LYrYDBsZzwnQllaMgiJBnqvFIHGTdMlw2p1CPKYS5gOx90WZBGzID7qrMJxPq92t3OqrM/kvDogptjgxDd3Xsp9TUd9mLWtB+tElt2mNzpmSz/dEjzH527JdIuTEWWVriOUOym3eTfgxEwidycOH945sUh9FMx4GN8p+N5xaj2XNdoCWwzS1GSpS4mcXXctGfZ1OQG88/va8xqq5acY2EtGQgX50jUI9l0QmYbn2GASd/EvnC6DrLkLEq5ioor8MUHscMw+GSOsISnoZ3gA1NOiaxsvsvpR8wzB/VreWSjF2WI2CRxD1B0H/PxOPvdaOgC9drqgYtAsJ1kxl+rvBL38FfUNEo1AyA3TOdvPjqp+eXCTaQA8TAa911+LbsmebTYdsdsD8jYivZu96LN54XmKHe1xG3xpZJos=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(136003)(346002)(376002)(39860400002)(46966006)(40470700004)(36840700001)(478600001)(82740400003)(41300700001)(426003)(2906002)(86362001)(26005)(47076005)(8676002)(186003)(70206006)(4326008)(336012)(7696005)(1076003)(70586007)(16526019)(6916009)(2616005)(36756003)(81166007)(316002)(5660300002)(8936002)(6666004)(40460700003)(4744005)(356005)(83380400001)(40480700001)(36860700001)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 15:14:04.0055 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89030a70-1541-415e-4a14-08da64192862
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5369
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

Unused so drop it.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 00ae5d65e1e4..0200cb3a31a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -843,7 +843,6 @@ static bool sdma_v6_0_check_soft_reset(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	struct amdgpu_ring *ring;
-	u64 wptr_gpu_addr;
 	int i, r;
 	long tmo = msecs_to_jiffies(1000);
 
-- 
2.35.3

