Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19A33C7EE23
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Jun 2023 02:42:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E016010E60A;
	Fri,  2 Jun 2023 02:42:28 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7476910E60A
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Jun 2023 02:42:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H+9JXWJyLC4LM3ir6/mWXNWi73W4PwZk91oX34JzpJWgD8pur7OHx2xVTALoV/o9vdfsTxDp1qUcWF+5GJpkFycVhi+Lgqe++DwHoTCQNUWStFCR1jjYEdTHiTJUgonJ+PihZv21IxzSJfEl6fUTSeas0p+kASSsjHp/4PKfuRiRB9oxPHAR+LG81g7BI5na44opSkI3ZjelU2pG+k/C8Mf6I7KcXxdUkq5jz2TWZYhb8exNtYv+Y/uMv96v7u1xpOWgVV+OgGqCKDQ0KGH5B5FANG//P4RUmlWsvSzoTQsVgUzEzhaf8UUr33R+J9ggNV5WVqJan0qDHuSUi6C5ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PJ02zMNmz4NJA2+OCQahUBOhd+dDWuYS/7zMqVPITes=;
 b=Bx75ERuO4BSFqD+rDGBVp6qCETu8NHyiVW5wJgAMbk605PEskg+ls8WkV+P6wfrFeAVPYeAVPNP+Y7I/VDw6vaqT7wEkjus0MnGKw4SzP5TkAuEZY2Nl4+1P60dx0bjbVsF/3sgHpV4Uyi9IslsbF6aYQFV1r/HSexWVKtC4OEzNUo6Apw0zNPQVqmvp8mzGPteKcHH0B8B8q1Fq1D/Z0q1Z7bszxj6guNCUGWnhQaiI0Wm84n5SBczyRQofkzRFT1dqEGZ3XeB1A8gzLU+6sCXQUTSjHlSFT7q81oRd9fOvT/eeAlBve/eKS1BFpkMHslZnUbG4nVIU82k1CKxKxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJ02zMNmz4NJA2+OCQahUBOhd+dDWuYS/7zMqVPITes=;
 b=wLYKEE1OYd6ilgag2eab/wSIuj8Gd+t7kJaKopHVI14HUDmDGnU0SOzuVgd/kKLoQmYfoilvAi1iga73nAh86jMJfKqubal5v25YsRbwiuBDZRJv7/Dra8wqKYG3Ht5YwRGMjWMpGzEsZpThG4MeHWECqIjIZ4eZe+g9PGnNInM=
Received: from BN9P222CA0029.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::34)
 by IA0PR12MB8349.namprd12.prod.outlook.com (2603:10b6:208:407::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.26; Fri, 2 Jun
 2023 02:42:21 +0000
Received: from BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10c:cafe::69) by BN9P222CA0029.outlook.office365.com
 (2603:10b6:408:10c::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.26 via Frontend
 Transport; Fri, 2 Jun 2023 02:42:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT063.mail.protection.outlook.com (10.13.177.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.24 via Frontend Transport; Fri, 2 Jun 2023 02:42:21 +0000
Received: from lm-srdc-pc1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 1 Jun
 2023 21:42:18 -0500
From: Le Ma <le.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] drm/amdgpu/pm: notify driver unloading to PMFW for SMU
 v13.0.6 dGPU
Date: Fri, 2 Jun 2023 10:41:50 +0800
Message-ID: <20230602024150.1840-1-le.ma@amd.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT063:EE_|IA0PR12MB8349:EE_
X-MS-Office365-Filtering-Correlation-Id: e9f70e86-4ff8-423d-187d-08db6312fd35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 60AB1C4DnmoEyEstfdx3HIWry0fG9elurSwH5WE3ORHLupo7KSmVxEVo0FRpSSnnJSvjT+TdXCDvCKHcHZDW7VlxAm79bRqSQfUzUnw+PtwmTaHvBGhxywIuLDI7CKGh6eHoiOj/L4SdoGKUvHRIV5yZv3fzMAJ18S6m0NXFbrauH8HXaQxB+AaPXIe9prYZOz76cxieqvij+HNiFspGzp1VXQ8z2ZSBI0Ue8/9o+iJXD9AuccfV7GMPrG2zIbPvtfMxXRVkHrB8eZ0dECgbLFPCU3AtFbXZtrUnvnQYNz1xlllPd9djSz2/STUYYhzFIqCw2TKD6wAlEh6JnY2UTg04FYmEhPBymz1L+J5CmTjSdFSC6dpFbk+tOaVtqxoD2beqir6zQaaZrMm5oYhxgffzgVsu9drY947eKY+YAzK8JZPtIiGoH3zWuvbDgeFdl4guuQQXmLMAkWnniY9DysOZPQv2ahnPJYzZiGQRyxITY6Ia4NJ93rYsMDCdryL97Ox8lrI21rN7zuN1uWyM0kzLmkr7e2Cwst/1orLMedDrn7iYuakE6xSPmVrEDuaUv4OBtLI7MU3mHrUYZMn9TGv7ikz84FJz9ZvXKmBB0n3tjzC6+bWHb1XsGeTmdVPfCkO0oMCDHeI8d1J0QzOZDcGFUSQnaWdMkmi9a1Uc2CjIQkweBgOZAi0yrMbY9+gLRdV28UwcQNw7AYdtKncsYpK+XeZ7wQiJIAPz4iMJFu/mGiz1xLXpYQKMYOrU7xXJKzE5Vd6GZLJLnvwRmPji2g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(356005)(82310400005)(81166007)(82740400003)(40460700003)(86362001)(478600001)(70586007)(70206006)(6916009)(4326008)(36756003)(40480700001)(54906003)(7696005)(6666004)(16526019)(186003)(26005)(1076003)(316002)(2906002)(8676002)(8936002)(5660300002)(44832011)(2616005)(47076005)(83380400001)(36860700001)(41300700001)(336012)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 02:42:21.1108 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9f70e86-4ff8-423d-187d-08db6312fd35
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8349
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
Cc: Le Ma <le.ma@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Shiwu Zhang <shiwu.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Per requested, follow the same sequence as APU to send only
PPSMC_MSG_PrepareForDriverUnload to PMFW during driver unloading.

Change-Id: I2dc8495572b0bce6e21eafb51b215c83d94ac647
Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Shiwu Zhang <shiwu.zhang@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 3da614faf75d..392ccebc8dac 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -1409,18 +1409,16 @@ static int smu_v13_0_6_system_features_control(struct smu_context *smu,
 					      bool enable)
 {
 	struct amdgpu_device *adev = smu->adev;
-	int ret;
-
-	/* On APUs, notify FW that the device is no longer driver managed */
-	if (adev->flags & AMD_IS_APU) {
-		if (!enable)
-			smu_v13_0_6_notify_unload(smu);
+	int ret = 0;
 
-		return 0;
+	if (enable) {
+		if (!(adev->flags & AMD_IS_APU))
+			ret = smu_v13_0_system_features_control(smu, enable);
+	} else {
+		/* Notify FW that the device is no longer driver managed */
+		smu_v13_0_6_notify_unload(smu);
 	}
 
-	ret = smu_v13_0_system_features_control(smu, enable);
-
 	return ret;
 }
 
-- 
2.38.1

