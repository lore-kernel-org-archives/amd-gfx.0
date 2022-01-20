Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F6D5C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jan 2022 06:25:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD4D910E388;
	Thu, 20 Jan 2022 06:25:50 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2082.outbound.protection.outlook.com [40.107.95.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1ABE810E388
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jan 2022 06:25:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XsQ2gZnb/ZnK4wXzojfuj5jlVte/nMh844LlTTTFjht1n+CPh0lZbmEKyW7yfU5P80MszBcWIdeLeIA3+T/CN9+imNU5XV0ozDdlFCHHIAopUOrdDLWZughErCYcX2dYTeUXNk0qSQQmFb/Ym/6lb3wbeVHGbP2jA8s3gMWbrBu4meZDlyxl7knqJdiEt1mfLcYVRd93wRKfsbVbIZsfI5Ijeo7F9tsVtZct+f/+DfypR4Y37fA9F3UJdfvbEnb0YWxgIoFf1cgS1x/D5th4wkUbhVhiaQBco/i68geAF9AvliT8dF2mbxxjfrPygrlHhjdb9Zkb4gXhjYfodzvLnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fOFvG81V+ouy8jgnfMm3M4ktCDP8bkwGzIT1IPUjQWs=;
 b=cj7h95oUPayRiV2syeJs223OAQy/mrkUp6vaT8Hx7G7ikmDDL2UH+n3C/u0ToTfUBdQ4vZc7+H+p9g1TPOHGF2ldE1ubIc5TaLWeHp7BqWCmfaYOMYZj6gHrysUXpYzfe9ue0RSX0aQim6YQ9ncx7brjeT+rdEDutam3YCzstOaWuxCfsCNKTo00EtMCTyyeVbWIMc5/bh4+joT0cXeEYiztMf0nEFgjiKudk2awYd01onzPW+H9hxkRCL16KomNakspetwPyQrvJyiZ6CmVmG2PthzqilrlZf+Kyfu0GdRaNuYwUiXCsL7ktKQ03VsajuURgslI87cj1euAO2LK2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fOFvG81V+ouy8jgnfMm3M4ktCDP8bkwGzIT1IPUjQWs=;
 b=qouZVFkJdbGmsnDVW3duuumE+SdP+GxZIOICaJVDRqZ3qWpWzX7aDWL5IvxC5X1sa+kIFS0KyMbwB73SXMGnyDDi3ypl22t97dLBeWZKSOUlnupD2v3Q7cKg/i0eZQnffbXkiHppxQBlV9kd3wlkKQ1O3ZXe70vpLmfqG+x+mvE=
Received: from DM5PR18CA0087.namprd18.prod.outlook.com (2603:10b6:3:3::25) by
 DM6PR12MB4515.namprd12.prod.outlook.com (2603:10b6:5:2a1::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.7; Thu, 20 Jan 2022 06:25:47 +0000
Received: from DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:3:cafe::2e) by DM5PR18CA0087.outlook.office365.com
 (2603:10b6:3:3::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7 via Frontend
 Transport; Thu, 20 Jan 2022 06:25:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT067.mail.protection.outlook.com (10.13.172.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Thu, 20 Jan 2022 06:25:46 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 20 Jan
 2022 00:25:44 -0600
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: enable amdgpu_dc module parameter
Date: Thu, 20 Jan 2022 14:25:04 +0800
Message-ID: <20220120062504.565239-1-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a788e58-3d1f-402a-8134-08d9dbddb1f1
X-MS-TrafficTypeDiagnostic: DM6PR12MB4515:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4515610CFFCA67327051C45EFB5A9@DM6PR12MB4515.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:393;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +InnqLlYO2BjrErW9sQJnJQFBWcbn/8IG1otk4TX0YuNYPOxTaJEHL2y7lMls9U26s+1t+9NpA+5Hr/+QcrvSKcAE4rnn2GUkfxvYR7wIzTcroVDR8NTSwHSte6hOXR8UTHz8MdHD3ONinUqQfKBOZN4XSHmtCfBIAT7JjbnLR1WUc6yDrlsFfawD8qcvZTRG/AH3sDhKaII3g+8ZGZELgjEu/xUYNVk3zEdt9WbJV2vsPB+bDNIYSqfsH/2OCdWwzeW7qKt8ATdZ8hkP+eQErnyL+6ccWTPC1dhJq5uroTnHyK3REPKMftlHMcWFuSI5j8xJZYuNNxN8fKSM2HfegXPkBrpql0imd6S2r1DfVEFenT4W88QpibbqU5zJcUc6eLnOw5LWQaCkehMsJydD1bK/dfhYj0f6iSAVqu6SE/EiuqzW85TTWghwl3odGGk1q4qcIe1x5wIQcOC+ajO0nUtTi5abVrvXPdm9z9eude0u9KYBnN1e+ZXTvC7Jrklq5+hozXoiKXXanDHgm7Wbb+Yx9cCPiKuW79rPWgPrzDjg7mYOEopdBGbF1DVR37CBcIIqcoAUx4WFPdrHjgJxuruzo9GPEYQH2euL2UR4ysfOUv1BCOR2sFOgbMy7khU6rV86dDjDD3lZ7aFxbW7kIES1N0SJliJ+0FIRhF5X46WGihQuSUlvGQWZxdUVCNMpqMnjo+7lYvPzujgVezS+FDRvhLiR7Wh3c6rASha2DG67PolyLsKb13J5K2KZ0fa1rRJQALqOViJ7hnFu607mmv59mLa3Bpxp/QpDhx3y38=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700002)(36840700001)(46966006)(186003)(16526019)(83380400001)(2906002)(40460700001)(36756003)(86362001)(54906003)(5660300002)(1076003)(356005)(81166007)(6666004)(47076005)(8936002)(426003)(4326008)(8676002)(7696005)(2616005)(36860700001)(70206006)(26005)(82310400004)(508600001)(70586007)(316002)(336012)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 06:25:46.8348 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a788e58-3d1f-402a-8134-08d9dbddb1f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4515
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Lang Yu <Lang.Yu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It doesn't work under IP discovery mode. Make it work!

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 07965ac6381b..1ad137499e38 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -846,8 +846,14 @@ static int amdgpu_discovery_set_display_ip_blocks(struct amdgpu_device *adev)
 {
 	if (adev->enable_virtual_display || amdgpu_sriov_vf(adev)) {
 		amdgpu_device_ip_block_add(adev, &amdgpu_vkms_ip_block);
+		return 0;
+	}
+
+	if (!amdgpu_device_has_dc_support(adev))
+		return 0;
+
 #if defined(CONFIG_DRM_AMD_DC)
-	} else if (adev->ip_versions[DCE_HWIP][0]) {
+	if (adev->ip_versions[DCE_HWIP][0]) {
 		switch (adev->ip_versions[DCE_HWIP][0]) {
 		case IP_VERSION(1, 0, 0):
 		case IP_VERSION(1, 0, 1):
@@ -882,9 +888,9 @@ static int amdgpu_discovery_set_display_ip_blocks(struct amdgpu_device *adev)
 				adev->ip_versions[DCI_HWIP][0]);
 			return -EINVAL;
 		}
-#endif
 	}
 	return 0;
+#endif
 }
 
 static int amdgpu_discovery_set_gc_ip_blocks(struct amdgpu_device *adev)
-- 
2.25.1

