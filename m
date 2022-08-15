Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E84BFC00140
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Aug 2022 16:47:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1371CBC08F;
	Wed, 24 Aug 2022 16:47:03 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2059.outbound.protection.outlook.com [40.107.100.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5A3E11AE60
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Aug 2022 10:05:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fwPh6L1lcILcyWh1JozT6hgHrgISNYOAUiYtCu0HkLMQG4xUtfxg+Xt687rW8AAxKOY8y5OncJj1J/DTOKB35vukzZXSaJIhLFz2GtnLpa5dJJ4MPf59ukskK9/0e6gmBNjrzQhN/utLzoxNmyZE7lbO0iV41qT3Nu6f1jmxqKbyq0PG2K9EmxyhhNN95tXH8QdnSe9HaJARr1prBGBgrblZw0WyuMC7zL7+EbgsfiyMlBffLqhtz9zl8lCZvrSSIOKPYjrnW1ThhW0kHb8ln5LBqzhxsfT0vIzmmbVFWfagzouamH+31tWmExu1S36BEzcbvfXotNyO61mQVzBcxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cDiUZwgE/Dv3uJBDAH/9v8POifiKXr0QQOmOasK6NxQ=;
 b=NbbA3ybcERrYosPS0LBUmeZtK0xd0lHPuPULB5LXAwC6nu6pjRRjIzlwQ/5On7GYJLDHsBRHzeMjC8R4eoWOWHUSa1KnJqrMfBOhoQCUyHpy8bX94FlyFiI6G/Ajtb/emFVnM6J7aFJKnfCn3p9NLg/qRbeLgr569XwED0WLUnZCGBxbtsh/Mqn31toJXwuqJrWDdGOwGW05GJuZaGmYaOHFP+Sf5uyAsLi6alX/TIbG7E6fryH7UeQlQ4s5LB3vTTOzkpRyxgBNqYvRqiBX17e6UXnCKubbpThAX2xqzTGI4iEgt4XPEs0eNWSRiFOgVFysqKr+UWTBtnJaR+VLog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cDiUZwgE/Dv3uJBDAH/9v8POifiKXr0QQOmOasK6NxQ=;
 b=hQav6OuWIBn3dx2J5xDOlWTjo4xzbHto3EsG8mavFJgtoNZhVe6RDXv7w0YC42R8DrGh6w93xLn1Ur3YKICJvVLm8JhmAyMl1ZXsBpG9FrA6y2ZPOY9bH8r7EWOJBuhxtPGGk72KEjf6RxyAwAyFuZ9WZRlUTpltn0PvcF1yKRY=
Received: from BN9PR03CA0184.namprd03.prod.outlook.com (2603:10b6:408:f9::9)
 by MW2PR12MB2428.namprd12.prod.outlook.com (2603:10b6:907:6::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Mon, 15 Aug
 2022 10:05:00 +0000
Received: from BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f9:cafe::dd) by BN9PR03CA0184.outlook.office365.com
 (2603:10b6:408:f9::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.16 via Frontend
 Transport; Mon, 15 Aug 2022 10:05:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT022.mail.protection.outlook.com (10.13.176.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Mon, 15 Aug 2022 10:05:00 +0000
Received: from canli.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 15 Aug
 2022 05:04:57 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix UBSAN shift-out-of-bounds for gfx v9_0
Date: Mon, 15 Aug 2022 18:04:37 +0800
Message-ID: <20220815100437.3207-1-candice.li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1081bccb-f24c-4412-3085-08da7ea59d85
X-MS-TrafficTypeDiagnostic: MW2PR12MB2428:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qN/WlqNPClmTwfUMbNH+b2Kutb3075tpqPTzxrZWG5IjkL8PieEbdF/W7Zmjmi4AC6RiaYQiL1wwTWS+Uyt89dpwR56psdhqFilS4yD/AJdnCUwqmp2rTmEvNAHB7TvcpqsHWsnTf95DFYJ8uVCzBeYY2iJDWe7lZpPGeve4xnmx1qda/wnbnDQveTPTICV6OdKmq5eOMo1qX0xPdQKNli5iOm4hz5TVDZyMvJsNPMktKq8Xa3dCOlAuv3pL7zc5rcIlsIfu5NZIsCKiW8zliK1ODuxHVj+JyWl8Hw8Zk9BzfXV5srg2YU7I2jhA97dk78d/j6Oy2yIF2PHD2XR2WytK/Y5HjcTys6ZP3+Pyu1wXZL1y/reUznZajK7xkHy60hKUt7lVy61soUdzxHFrAkyr3bpk6kFYtY63gI+M1RcgZetWYXIHa/DZCLoQchzOzz1L7xX+mrqLS4At/YecRPJOjWD3MzpI8CcRqk1ZS1VanHJhS9bRX3jbuL1DuUIgkXQDhyYfQCS0IWcwrTckAHU45ufeqz8My+jDFgYN8FV/6wzn2wfgcVqGFENZJzEz7/8zm0hnRJy577cjKmiqUrFexQYYsrpXLgKmUiW+D6IKNtL2ebVp+ahb3Gvww8NDsEltCMd4TcBgobYnB13Qzbw3EVI0CdJ3FpnOJWz5tR79OhbEMs9NGd8nocEUo/WT6wdDabudzieqM5AAh+hRQPgEwZk+dqQt6uTQjtl7mHP+Z3Fxt6//Rr1QHaqTXwHDyg9qW87fDl4TceBHDXB+OFp34YOcvOMSQv1VFb6iHeFoxHALC0coSLnJL90s48mX1dtqfU1sO6u2p/xvaG0R9g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(136003)(376002)(396003)(39860400002)(40470700004)(36840700001)(46966006)(44832011)(70586007)(70206006)(82740400003)(356005)(8676002)(4326008)(83380400001)(26005)(82310400005)(478600001)(6666004)(86362001)(41300700001)(16526019)(40480700001)(336012)(426003)(186003)(47076005)(7696005)(2616005)(6916009)(1076003)(316002)(40460700003)(2906002)(8936002)(5660300002)(36756003)(81166007)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 10:05:00.3020 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1081bccb-f24c-4412-3085-08da7ea59d85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2428
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
Cc: Candice Li <candice.li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Check shift number to avoid doing a shift operation when the number
of bits shifted equal to or greater than number of bits in the operand.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 7f187558220e9a..0b9215b6e4b316 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2494,7 +2494,7 @@ static u32 gfx_v9_0_get_rb_active_bitmap(struct amdgpu_device *adev)
 static void gfx_v9_0_setup_rb(struct amdgpu_device *adev)
 {
 	int i, j;
-	u32 data;
+	u32 data, shift_num;
 	u32 active_rbs = 0;
 	u32 rb_bitmap_width_per_sh = adev->gfx.config.max_backends_per_se /
 					adev->gfx.config.max_sh_per_se;
@@ -2504,8 +2504,10 @@ static void gfx_v9_0_setup_rb(struct amdgpu_device *adev)
 		for (j = 0; j < adev->gfx.config.max_sh_per_se; j++) {
 			gfx_v9_0_select_se_sh(adev, i, j, 0xffffffff);
 			data = gfx_v9_0_get_rb_active_bitmap(adev);
-			active_rbs |= data << ((i * adev->gfx.config.max_sh_per_se + j) *
-					       rb_bitmap_width_per_sh);
+			shift_num = min(((i * adev->gfx.config.max_sh_per_se + j) *
+						  rb_bitmap_width_per_sh), __builtin_clz(data));
+			if (data)
+				active_rbs |= data << shift_num;
 		}
 	}
 	gfx_v9_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
-- 
2.17.1

