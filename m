Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A652C47077
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jan 2024 15:58:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C81C010E972;
	Thu, 11 Jan 2024 15:58:55 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2077.outbound.protection.outlook.com [40.107.101.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C6FE10E972
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jan 2024 15:58:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i1qC0f8xaRhDBs3LLUGrG3n9mDQmaub5RbtJF3xJsGVli6pCRqticTICsKlJTiM5kvkw9yBGN056089z7AVCklu9PwjruLJkk/EGUQrrnOQ9vQ1bqnl5RwWkctDSTXxOyLBzzLkguHt8WKftcFWspyBr+uUcFM/vbo985bpaJTbcU1tffBDTHouXeId1x5la/WRS4BOXnLXS7B9wrKtx5bnL5JqK/L51s3r8zrzujoSu7bJfAN37HZEVkC80P+R9WkA3+t/Pjg5f/HYQHKT6AHARtv9bvDf/WwQeo/WMMDk7UmW+WRyu/iqBh1XnQ9someVYAuU4HuO1Lb8vDLHJKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cLe2VeQ6b7PAb+TlSpRUkt869rpfNN1BaysUY2zJDCE=;
 b=mFmc2AQXuHkjRyoyWMpSG8+0c1iDrept6AzxPYGIxfRiF3xqOlLGSTwmFZqLsjHsSzZ4CujcdlpCf84lwYEOkoAD+cAJTipK6KIyXQmid6PH0HaMr0xzwT10xyCTwDdr+WWAnj7olAza4WWpm9MYaj1QklFyMF2KYphLch773mc2NyVMLF84aVgmNqtqXLO7kvbiVa9NW/2i2nnyFk3Yn2/qUJRbcvwWZ4xx338yLW40zkH9nnbMp977lYZl5w5ia9U1i8RycxMqMicKYVRfe33tU6W5a89Tvl+pOlqQOE+4sQQBuew5g1C8IYyjaz39NNVVIENF5lkMBWYpkOU6uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cLe2VeQ6b7PAb+TlSpRUkt869rpfNN1BaysUY2zJDCE=;
 b=JVGvkj6cT7z+Ky/8WFkAao/lyGA0ridwo31rbbOh/E5hyp0zfeMxMvpqLfzNO0cKgtdiFpwv1o/dOu7QNLsG0PjYnrmUMTOI7lymLloMZiXLNewX1QUeGRUqAqhO5dHj51plVm4TEoZ52fFVTyNI3M417B+jQfGG5biEgVyPswc=
Received: from SJ0PR03CA0236.namprd03.prod.outlook.com (2603:10b6:a03:39f::31)
 by MN6PR12MB8492.namprd12.prod.outlook.com (2603:10b6:208:472::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Thu, 11 Jan
 2024 15:58:53 +0000
Received: from SJ1PEPF00001CE3.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::7a) by SJ0PR03CA0236.outlook.office365.com
 (2603:10b6:a03:39f::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19 via Frontend
 Transport; Thu, 11 Jan 2024 15:58:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE3.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Thu, 11 Jan 2024 15:58:52 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 11 Jan
 2024 09:58:51 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix typo in parameter description
Date: Thu, 11 Jan 2024 10:58:36 -0500
Message-ID: <20240111155837.3460096-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE3:EE_|MN6PR12MB8492:EE_
X-MS-Office365-Filtering-Correlation-Id: 557eb4d9-9e21-446a-3cd3-08dc12be356d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tlinSYfJm8Z/gLnyYSY462gOmzNSOhFXqAqIiHSS8eN3fhbJ+f8X7aD41OkNBnvQgrFDg2laTAPniP0ymI+JYcZeHXnqJ+xr7rtyB3uMZXi49+mipGx2h6bgeoodRC2wzZ7n9bRGGTIg7PfXdVcx4gxj4THVwd5aInma6ImnruY0sYKx/9gje5C8905jz+Hl4EIzMKmYmMIn9rPeM5smDth34w2/kNmmP+yI9BCw4CUcByd8wD4D8v9MbQ/DxzERsdR3ubucH5U9qBuOL5oTP3AgBa1TIIeIEeDjjrcmzMxTIz81tIeEtAMf647BQEcPfPA99ZuuC2gu4MT83eAKXNjhm9jLgeUBGf81YqdYuTDiusj59XVOiTgYBBQjbjWxNn2RIioqvl+JH5Flft9gJaZQYequKpofGJAj59o0hZx47IpJxXyp99vVSpU00+tQDXLZxnSgBiFvUuTm8+bGa9mgNQ2WLa3gHGukwhzj7F8H3UNKOdk5tKvUNtP2yGrUoNyCQ/+EDkb9BLWa4NPSGRRlGtutUNTnktpS9P5xm/pUmXd5YzXLYHUR8rOus07f5vvj8fgcTfhSiwr/OUwMQdAhWGq+of7hgRr+SDqjzHmYd/OoZ0duUitl6qTDWiGOF5RWE/zLku1FPtgU5uMsRn3xCyad72cgWEaD7DZwoMr281k36+NdQmU4LnVveeYNLPUHhJV7JuuQ2MfwO8qwgAUSwyVhpeC+2NP//wLzMsfE0MOpxtp56CR6sMH4dz0cLi1FVyd59eKUO/dcP1QNLQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(396003)(39860400002)(346002)(230922051799003)(186009)(64100799003)(82310400011)(1800799012)(451199024)(40470700004)(36840700001)(46966006)(426003)(83380400001)(2616005)(26005)(1076003)(16526019)(82740400003)(36860700001)(6666004)(47076005)(336012)(4326008)(8676002)(8936002)(4744005)(2906002)(6916009)(7696005)(5660300002)(478600001)(70206006)(41300700001)(70586007)(81166007)(316002)(86362001)(36756003)(356005)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 15:58:52.8111 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 557eb4d9-9e21-446a-3cd3-08dc12be356d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8492
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

Missing space.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 5c9caf5fa075..0712d5867849 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -366,7 +366,7 @@ module_param_named(aspm, amdgpu_aspm, int, 0444);
  * Setting the value to 0 disables this functionality.
  * Setting the value to -2 is auto enabled with power down when displays are attached.
  */
-MODULE_PARM_DESC(runpm, "PX runtime pm (2 = force enable with BAMACO, 1 = force enable with BACO, 0 = disable, -1 = auto, -2 = autowith displays)");
+MODULE_PARM_DESC(runpm, "PX runtime pm (2 = force enable with BAMACO, 1 = force enable with BACO, 0 = disable, -1 = auto, -2 = auto with displays)");
 module_param_named(runpm, amdgpu_runtime_pm, int, 0444);
 
 /**
-- 
2.42.0

