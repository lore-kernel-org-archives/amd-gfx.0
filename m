Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88F78C77B61
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Apr 2023 15:27:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB76710E621;
	Thu, 27 Apr 2023 15:27:41 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9529410E35B
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Apr 2023 15:27:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V8+fsJIE7JwDMSv0ilirfRvliFG/ud6lNcEU69tGh6i7o5LyWbn9ZaQoEjRNVtsbhuqvbklKpKv0qF86cszbI5eQA1AX0qbE1PYJo+y+3ou3DlYAfiOlINis9SUxRxHLFkpF56LSb1JlgFsF56pts2uurLxloB8pdaYgnLhcQoQvYoYjxMIfxE+mZ5hTmIhXPT5pqUV7dLq9YVDDiTEcmaHCh85ggWTs9t3O0G5s/HBv5kk5XFF9eqMnqdNTe2+5QEV3c7UduRA0CojoszxHKodFtgcbytd2OlS4XJxMHgWJQXta052nCpcjorw7IJVN3TSrPkMQ9lly+7DMW7yaSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2LNx7E1Yjd9y6yzuTCzav5qvReFec8Bt19f4ubwkV7g=;
 b=G5xOQEHfCga3h4JsvRuCjcL+Se6Br3qX1gAmpBxwNQCVDcv+lEfsRuefpc3kKwQnoX2mPEJzuh/FXQWgLgI2AYwUhcOF9g9jHT2SeXAKsiYnovW7+Y/hpzHeOtjWXEq1gG5QW/dSuRvc2rc9rE0+FxroUbHGusMikZzvWrSotN9tZ5DVOsUK28FGkxoVj4gALt7Dw8Bp9AYHptK6ez23UAHZPJVeOAxCBMhHBFw88+VP066JSXZ8xPuGQt7B7poKyF/UZrmJDc0RoypNCtdGHxeJhOhnOQN1gVgP67tEXvoJspEyGCjezLLVlJ1energ4mNlQS3e+JPl68VuZHWrpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2LNx7E1Yjd9y6yzuTCzav5qvReFec8Bt19f4ubwkV7g=;
 b=g3Cvtg5m/N76nkJaCxrWjpN1mxmNPg0xckRimOOaTFx3bPwfiVB2GpPlOoRy1jf+4adzn9RVkazuBNHXJUBUO/Mi+VURB9/HK13o5htEsz+BbglYlPatLYqrKYilVP8PWW5bQ66Yw2imC1DGSUY465Yectj2u0GPnrMhHrTIZ/A=
Received: from BL1P221CA0021.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::17)
 by PH7PR12MB5877.namprd12.prod.outlook.com (2603:10b6:510:1d5::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Thu, 27 Apr
 2023 15:27:37 +0000
Received: from BL02EPF00010209.namprd05.prod.outlook.com
 (2603:10b6:208:2c5:cafe::72) by BL1P221CA0021.outlook.office365.com
 (2603:10b6:208:2c5::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22 via Frontend
 Transport; Thu, 27 Apr 2023 15:27:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00010209.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.16 via Frontend Transport; Thu, 27 Apr 2023 15:27:36 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 27 Apr
 2023 10:27:32 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/12] drm/amdgpu/gfx10: drop unused variable
Date: Thu, 27 Apr 2023 11:27:03 -0400
Message-ID: <20230427152709.7612-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230427152709.7612-1-alexander.deucher@amd.com>
References: <20230427152709.7612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00010209:EE_|PH7PR12MB5877:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d82a3f7-786e-45a9-8edf-08db4733edf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZODI1KQ7YXy7N7h2s0AAMkq29S8YFiL0GHiIHxvi/rOveKgN0qCxIexgcd8Okz3cAgBuu15yNlNMHtA0h1KLuqHxR21YPgdCgE37bOHhBMjgGro5Cq7Sy0qwm5PBawLw/mp32mpFrX4sAnGMNNY07+ro+eZzvzQsmiacwOP83FcjA+8QPBiU8yrGDqdyUEWuOee81J1HnfAkcyBgtGf5HDXZbN7Md8FNz22hktV6XEbKYTNIRDLVMg8CEbrbl0rg5Jv8fx7cat1JCwA0y6qN4plk3jLCBtW704LSnjh78t0EXVa83gH2AsNGs0PZr3SnTw1l7KH8Arb5LNf6OScClHecFRYEO+sNBSBSetVxK26J8ocMRbNR4213M+Xvbrdq4PrXcHhS0u2zwlem/qNz7JRV/ZMrVjQb335+SNnIk034WvDH6CDQOTE7ynLyItpJ/pr5WmSAdwTYiw3BygPsjZnf9i6dHlspwvg9K2Z4Ec5tqsLD7n7rbRTtlnZSFl4j2pqau92W9IEKWIXAw7ELZ4H8ydcwVXxgyzuWjb3Tvn8wNwBKTgQEYYqhSer6HhqC8MXOsgEtPBwMucPhpaYCnjqoUEVZ8WDTm+XB7PTzF53rPQP7v4K6Yb3LLgTVktROCLTLPKgHP9OD1hr4mEOzxM4jQlIJcxGYhI+YfH3gTtQvXBkYbO7fnLb6e02kU1ltWoXfXFr0BOKAKhe3zpWRir9f5hjTP6M+n4dnrdzQjG0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199021)(36840700001)(40470700004)(46966006)(40460700003)(5660300002)(70206006)(70586007)(8936002)(8676002)(6916009)(356005)(41300700001)(81166007)(316002)(86362001)(82740400003)(4326008)(40480700001)(26005)(186003)(16526019)(7696005)(36756003)(6666004)(1076003)(83380400001)(36860700001)(47076005)(336012)(2616005)(82310400005)(2906002)(4744005)(426003)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 15:27:36.3785 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d82a3f7-786e-45a9-8edf-08db4733edf5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00010209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5877
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

Just check the return value directly.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 24d7134228b0..5c67c91c4297 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7159,15 +7159,13 @@ static int gfx_v10_0_hw_init(void *handle)
 static int gfx_v10_0_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	int r;
 
 	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
 
 	if (!adev->no_hw_access) {
 		if (amdgpu_async_gfx_ring) {
-			r = amdgpu_gfx_disable_kgq(adev, 0);
-			if (r)
+			if (amdgpu_gfx_disable_kgq(adev, 0))
 				DRM_ERROR("KGQ disable failed\n");
 		}
 
-- 
2.40.0

