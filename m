Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA0D8EB64DC
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Jul 2023 08:56:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 757EE10E1DF;
	Mon,  3 Jul 2023 08:56:11 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70E8F10E1DF
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Jul 2023 08:56:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fLh4f7pmwn1CxD1AHsK6ATvR2B7T2anRejkpEbkfX6Fv3hrp8tqaGX79aCcCgxDH215QjgBFe/kH6NSmMdvYa5K00kxUU8izKVQTQ/AwQlf+XmB8IB1Ov2S8BdUyN2/cNZiXPmDLfOMzjesmhpwOL9uyaITExkVRI3vEO4Xpe9D6hF4jDx/yow02vtpc6GsM2bE1DbQPRaeLt5Yw2QHkw21mW2rKw8YXVBAi0uIs+Ly9iMm7FcG5FuOV7ns0VxvYX8/yot53U84iq5SzTvDSrpb/GJYnV6FPo8Nrxz1X4PMcfG26LEbqcAbJwi8F4OqRZwrGqf96Vvqgk4Flruks2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dgsixzo+pPGftbfSd/Tcrv7r3e2dNmVZhpaCTt4Gk9E=;
 b=ctTEpA1cLYqO0hoTkKJ8O8nh08ZISd4Ecp7+5aFq+yoU+x0/9/0uS4+4tjgs7YYFmvlWQzh9CeNAj5qmq3M/KG8bEbSdrxfTyxtvtnnctZPp8J5H7a5EE9Pm+1yewxR5m2rN5zVAZqD2ftdZJelnRjCyh5pRsOsYhx3V/0tAIKrqyTZnG9IxfuIU4q4hL4s335O7a3LWdvl3dFv6J6T7TuC0vqF9ig1i+PkW8ArxO6LYvXKh9DPuUK3anGPB+FSkT+5oid3YtDn2wDvToSyBOaKDS/gC8VvYDB98k4Jsg+kmmDfbC93j6OeCVNGtIe01IRnldmP8HnkuaYitwnoK2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dgsixzo+pPGftbfSd/Tcrv7r3e2dNmVZhpaCTt4Gk9E=;
 b=VMuwI9E3b+oRgithc2rEISiAsPgtH8EmPfJxMjv19MhELYxS2bMPKiv9IgksUvM9MZGHDC/n0OAqdsXvjIfZx4kNiEmnGDtUuI9xze/Gg1OXDFVCM/8ecTec+W10jz7tK4Z8R+22OcqMQY+Udxcy7NfBLozgk/9CNg+ZFcpReyU=
Received: from DM6PR07CA0072.namprd07.prod.outlook.com (2603:10b6:5:74::49) by
 PH7PR12MB7308.namprd12.prod.outlook.com (2603:10b6:510:20c::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6544.24; Mon, 3 Jul 2023 08:56:05 +0000
Received: from DM6NAM11FT081.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::b8) by DM6PR07CA0072.outlook.office365.com
 (2603:10b6:5:74::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.30 via Frontend
 Transport; Mon, 3 Jul 2023 08:56:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT081.mail.protection.outlook.com (10.13.172.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.43 via Frontend Transport; Mon, 3 Jul 2023 08:56:04 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 3 Jul 2023 03:56:02 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <tao.zhou1@amd.com>, "Stanley
 Yang" <Stanley.Yang@amd.com>, Thomas Chai <YiPeng.Chai@amd.com>, Candice Li
 <Candice.Li@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: Remove gfx v11_0_3 ras_late_init call
Date: Mon, 3 Jul 2023 16:55:30 +0800
Message-ID: <20230703085531.11563-2-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230703085531.11563-1-Hawking.Zhang@amd.com>
References: <20230703085531.11563-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT081:EE_|PH7PR12MB7308:EE_
X-MS-Office365-Filtering-Correlation-Id: 4594361a-b70f-4fb9-c8fc-08db7ba3557c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9ufArwv0e+XeQA66zrWIbEO5qngRni/kDQXcK7wAKJCN8xeMi8PQJ+ZfkUn/OTiB6X+pgpJ1vDAD08EN7KY2zh2Mec8A5ZlRB/kyic6C0vpHTthfbTPTPOU47uy6w+QrqrSOGXJkwC+8ryGhIo1l1XwKvVW37CngSB22j4JXPwVBrWe/vrNRS+hGKtVuxqhpCozEeT71UX55xBJKTLfoSepdAxhc3skLbBsFdi55NYlcJXe9FvQ2J4ZfJCGbpEluCyw3fxYkLmG05bmniOyrew0w2vTBkPaGIbACXpm2F50kvYA+veKVYPA1ZeQJxZnQegY6xMPxu0Dqx69b78UhKQTpgX1wEgrifyIimEOfAw162hrdwl5YMCI6YwuhnjFsT1tidJbKitGzdAa7iofcUP0I4Le0wsKsnW1cEA2EEUyCWynUy0nBSTdUJ/LrArDnq+DCHr57XXu+6CFMFGIbcqF5RUhE9bec2E1JMm4n7JYJ8Y17Isl8+1zrrRZGMqPB9MysDukHUtFJRaoaGdydsq2pahasmhj62vPb7a2zXZ6e59zhAef+o0iOEskV6M/zNwMKGCQRrfbSSAtsayBUAnB+qcswtDFvzZ6tGqMVCHafV8Gmuo+73LOocjNoYw7JGmzkktEiX9yDMAURcfX4a8X8yrsQJYFxBJIu3YjO7uvFqia40Cjd2tZwDNLSjIcqfvQKjgFm7vGFqD3iVu7asJTFMkTKO1pg2ZFymhLD+44M47XxSCKhTTbzt4zhNOakMnKFA1kDsjpkvAv9I4vRfg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(346002)(39860400002)(396003)(451199021)(36840700001)(40470700004)(46966006)(1076003)(6636002)(81166007)(70206006)(70586007)(356005)(82740400003)(4326008)(40480700001)(478600001)(40460700003)(41300700001)(316002)(426003)(36860700001)(47076005)(2616005)(336012)(82310400005)(83380400001)(186003)(16526019)(26005)(110136005)(2906002)(5660300002)(7696005)(36756003)(86362001)(8936002)(6666004)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 08:56:04.6402 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4594361a-b70f-4fb9-c8fc-08db7ba3557c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT081.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7308
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

amdgpu_ras_late_init will invoke ras_late_init call
per IP block

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 3a7af59e83ca..66d38890d393 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4650,26 +4650,6 @@ static int gfx_v11_0_early_init(void *handle)
 	return gfx_v11_0_init_microcode(adev);
 }
 
-static int gfx_v11_0_ras_late_init(void *handle)
-{
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	struct ras_common_if *gfx_common_if;
-	int ret;
-
-	gfx_common_if = kzalloc(sizeof(struct ras_common_if), GFP_KERNEL);
-	if (!gfx_common_if)
-		return -ENOMEM;
-
-	gfx_common_if->block = AMDGPU_RAS_BLOCK__GFX;
-
-	ret = amdgpu_ras_feature_enable(adev, gfx_common_if, true);
-	if (ret)
-		dev_warn(adev->dev, "Failed to enable gfx11 ras feature\n");
-
-	kfree(gfx_common_if);
-	return 0;
-}
-
 static int gfx_v11_0_late_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
@@ -4683,12 +4663,6 @@ static int gfx_v11_0_late_init(void *handle)
 	if (r)
 		return r;
 
-	if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(11, 0, 3)) {
-		r = gfx_v11_0_ras_late_init(handle);
-		if (r)
-			return r;
-	}
-
 	return 0;
 }
 
-- 
2.17.1

