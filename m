Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68A48C04AA5
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Aug 2022 07:48:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CE3110E037;
	Thu, 25 Aug 2022 07:48:37 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7AD810E037
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Aug 2022 07:48:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hN8/oKGh++kplOeEHwbNGsF5+wkF4rSsOkmGy4+XbbWNLeGV93jzuURDEkqQVWwhNjDA00boUkddx5550wsx0HpVBfJtakzY9yQbt3r99f02qOqC35dWrDvQTcyF2j4juMrfdKorzs4/th9Jlw1xMkBHB8bXZHA4zJg2OlWBa86ZJLkDvd25x1tzSH+DFfxftzD5Pm/Z4o4tuqX9cLHJFNaxcpmN4uvlXW8Wbqrn77oIwNLc2hB1XM0PzmOi/YzwKtPbut09v3y8nQRj7AHBGh6UM6GyrFL1IJ3DzeJXv/jBsDtArj9JZOFc7l42wyRCAO402B69IdjiBx0aN88nEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4bsGiP5N1CAjspauMxrcr815KizavG4WgYOV2lPqw2c=;
 b=FU9tZr/lsh9g9n9GQtrSK9Hy5Nqpg5Cdh6kU4KNDwF3IsbFfp+TE7NQjLHJWadJy5px9zLH7O5OU5uSQuOxsV/8OzXTZ0pr5M8yJQfP/oZm2Jydldts0yu4FG2X6tLJjjFz2ChCUXwz3jagtbMBjRqhEJWFNcA2V00PZ6y1y4bf70CDVTf3MkTVz3ZHe1iGBP07iHSVkiYi5powpkHHsHwW0Pa9G5IhVVuyqd2a1R/kT+KpYGiHsBRFZvqdxPOWtOIQ1wXACJ5Ydxj+hYyr/piW3pbuxBIL5xbiJvR4HpN7ZhUM/vX2u2T/AwsqQRSAad05CNmLelX6h/CmRMdk/hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4bsGiP5N1CAjspauMxrcr815KizavG4WgYOV2lPqw2c=;
 b=XIZquCiEB+F8ZCMgSRXpNh74rt4qjKVBYcH1gSL8DiidlD7+xS6ls3oU9IbNmQkoGvhRAk9hEST1teLKOq0z4oyawj3Hk1yNmGgyxbziT4m8Mh6/F7zULRlV0rou7RPG/KnJ3gMzM3dhXwJqahlkx3+ycmR0KEB0OmQJE9mv0gw=
Received: from DM6PR04CA0022.namprd04.prod.outlook.com (2603:10b6:5:334::27)
 by IA1PR12MB6556.namprd12.prod.outlook.com (2603:10b6:208:3a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 07:48:27 +0000
Received: from DM6NAM11FT113.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::96) by DM6PR04CA0022.outlook.office365.com
 (2603:10b6:5:334::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14 via Frontend
 Transport; Thu, 25 Aug 2022 07:48:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT113.mail.protection.outlook.com (10.13.173.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Thu, 25 Aug 2022 07:48:26 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 25 Aug 2022 02:48:24 -0500
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <hawking.zhang@amd.com>, <evan.quan@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: use adev_to_drm to get drm device
Date: Thu, 25 Aug 2022 15:48:10 +0800
Message-ID: <20220825074810.361902-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c3eafab-4556-41b2-7a87-08da866e3207
X-MS-TrafficTypeDiagnostic: IA1PR12MB6556:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I8pbOgwRs99OfwseHo8RNKR9xTWNFvc8gsTj6AtcHIIDHDSqxdmLHfIixe8Aa6MrWrYgwvhxZhvm0kvWq9ymA0/YzSeYPNVhn8/VVAULnCh26slTTgiSF4IhfWEh1Wd2fBCVYgFyEu6og/mFxrpAQ7UvfkloqNb/GlFPH8Ubo33lNi8fZOr9DsG8xiBzA5Uwc0Ej3IxFMRlg/VeQ5f8p9SBvePux/uR8CAej2IrWj1cUr0jToYm8KRgkwfYQHiqXDKf5m056uqSgVVMNBFiSm9leOJNUMolV6dpqSQ2IhEYZi/Yl224vo1FmWuSS+fb0lG0KVSPS8/vUaEpHElzGLwc4c3WAPbYbhVXqy2bv+PQx7Yo+TgQcjtdBQYdFRNnhq0+oUoqv/6nTw9gDkf1jYpDRWCyxpuQntS2mWVCOT8MCryknyD5oFLQ8J3H7vbQziywQRbgNbZ/slLHDZ9vXJ8CkyqMyEUQjkLG/4/53NxxmORbdjj06lX33ohE3gJ/Yije1hR+0VKGtHn0GUS3v4RDu4+eo8wmkAgDsAM053fKOK3oavVTIndWlJRO/my4JQ3vYscDKPQQ6cJ6ik2YKqvikl9y7JySy1E09BEB5XG0d/W27gKWmdYrB8C2Lvb2myDynIRmXusJaI/hy31OTwZ9vBwazqhPEVplmPmjcuVuo/gTqltq2aYli0V+rHwL+wqkw8mzwkUf88cx0FOV2cN871WR7U5T4jxWjNxfGHdozfCb8PqY7Wd9pQRrOUnD29qpumZ8Q/R4v2TMnLQHomEa4fssb2ETidnvE0Wz98gtnYR6GuKhu4Ta1OT83PdDJ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(136003)(376002)(346002)(39860400002)(40470700004)(36840700001)(46966006)(82740400003)(110136005)(5660300002)(70586007)(70206006)(36756003)(81166007)(356005)(86362001)(36860700001)(8676002)(4326008)(1076003)(2616005)(186003)(16526019)(336012)(7696005)(426003)(47076005)(26005)(41300700001)(6666004)(4744005)(478600001)(40460700003)(82310400005)(8936002)(40480700001)(316002)(6636002)(2906002)(83380400001)(44832011)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 07:48:26.9128 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c3eafab-4556-41b2-7a87-08da866e3207
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT113.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6556
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

adev_to_drm is used everywhere in amdgpu code, so modify
it to keep consistency.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 8ee4e8491f39..6ea8980c8ad7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -402,7 +402,7 @@ static void amdgpu_ctx_fini(struct kref *ref)
 		}
 	}
 
-	if (drm_dev_enter(&adev->ddev, &idx)) {
+	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
 		amdgpu_ctx_set_stable_pstate(ctx, ctx->stable_pstate);
 		drm_dev_exit(idx);
 	}
-- 
2.25.1

