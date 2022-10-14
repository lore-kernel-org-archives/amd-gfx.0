Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64867C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Oct 2022 07:28:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B36110EA92;
	Fri, 14 Oct 2022 07:28:35 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDB0210EA94
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Oct 2022 07:28:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BEhiZHyXX3VRCPBKuDlmAcY3XmYQJ2jIt3W1n6BXvYDA83QGDf69cZ0vnAgYCDue+RKs8nV0U/p1Gj8PyhdsZSOhIX3AICDPIp2zjqrzEtgTug+cjwpiAJR5yd/p7g6Wz789wdY/9DM/YTU6v4nBER6714PuD1alT6uYnJSbD0RrcLFaLJGsa8HzqZIy2pBasj1mKRQDVWQw3LK+me4R85H3u1rmLhlnb9XrLOG86n239DTpDOGKvT6+YSFYPs7ausuxqgGGNdqbm6YkiNeHCIemoxXjDXv1SxlMEloBHQsEdufFQuqhOqDouGdkVbOrbC3OkqF1J1yQpWu/cTFZ9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7DR4iSH9b45NzVPlRgvCm76164WQl2tF/gcDQEWN55U=;
 b=E9LLioNfEqD8QevktTWBsnuCKLdH5uKc4SK3u0WBit7ECRgL32HX7dxX8oS5aWmTr6ZhIwwTsc9KwH55gj3MSZnjPz2Lv0UPNg1eosoBh9rVR+KrDtTuxiVI+5cIOm6jfvjiBN3Rmhp8PzEPy5r1lTBkPJfRIvIJo6B71rdo0Br+hwh6832fEcDMDXE59XM3Ei2B0l2jNd+r/N/QU1TZBCNyrVmo5eybDdb9BrFk7+ESpLHDRBAw+Yo5dJ4/9IFicaIIyg6E0KyhAQWGKV/C9e39idakW+Ssxab6HCheIT3KvNusVdHEOT+gZRXhW7OGyt5xLDqbFzHLtAmPkAZN6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7DR4iSH9b45NzVPlRgvCm76164WQl2tF/gcDQEWN55U=;
 b=GabrmGedrVqsjc+Tp0IZz8ZQy8KB6mFKHtuKz7e8pHNzwmjD+furDnLVnHxBpJEd3olmu2ADFdngy2cJcS8fsg6h0/708qFg70kmDv92eOawi7Mrwk8uFVLgw9y2dd6tCijv0ex+qusztxKsKSvVr3mIE219oL/7LcoNlaXVnNA=
Received: from MW4PR03CA0241.namprd03.prod.outlook.com (2603:10b6:303:b4::6)
 by CH0PR12MB5154.namprd12.prod.outlook.com (2603:10b6:610:b9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Fri, 14 Oct
 2022 07:28:24 +0000
Received: from CO1NAM11FT088.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::48) by MW4PR03CA0241.outlook.office365.com
 (2603:10b6:303:b4::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30 via Frontend
 Transport; Fri, 14 Oct 2022 07:28:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT088.mail.protection.outlook.com (10.13.175.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Fri, 14 Oct 2022 07:28:23 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 14 Oct
 2022 02:28:19 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 14 Oct
 2022 00:28:13 -0700
Received: from kenneth-u2004-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via
 Frontend Transport; Fri, 14 Oct 2022 02:28:13 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amd/pm: enable thermal alart on smu_v13_0_10
Date: Fri, 14 Oct 2022 15:28:08 +0800
Message-ID: <20221014072808.3712546-2-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221014072808.3712546-1-kenneth.feng@amd.com>
References: <20221014072808.3712546-1-kenneth.feng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT088:EE_|CH0PR12MB5154:EE_
X-MS-Office365-Filtering-Correlation-Id: 56c89aea-a02b-4246-f895-08daadb5ad27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EIGPx0COUpUOqVycoNrsNhsqPGQGuwntc3ir5dhihPMohJNLKdL1yJHjpw0jjbrSmlRdhGLVpKrLljHjvhawPXNfeXRBTBq9g9Yx6uXHSMqO8qNVPKQdb3tW8wcc3LuNlgtQKcLj5MaMNKkXNbDCbpyuK35LUu0P8b9NWGXpEYZ+K5T4w81vwPxzta27lCFDWgHVJNVFwayiFEK8lcgW6myPznfDBb+rKwZKPZlQ4oIGp/PPqiE64FFDirCvL73uOBzctHuI/8wrLSl7MlxmWeD+CSUvvgntjykzFRTxza7KIaUgPQvY9DBKc15Fx1h6OxV2cE5wera8W4MqsaqnrVulhmVKAiQBbnzMbfQufc8ntsdeCnmOxDXFKWtjaTXpREEA9MMt6WamyggURtQYIuW+U+glCrCVRzrzOzG7qN0MEIUUh95pk3tCNsnmFSF3iO2ipG0Odj5m31rbn+xlxPeCISlhzL58+ZRrf8j8bR28ctEZrL3NkuYOepbAJ5YDXwtURU93zmUh0xQvd6WOVl5l/bgvM71xZSee9cPeawxn5xCOBiYg9RvwBhdJQt3UYzhrZipc9Ai9Rv8EXdLny7afUkIGezyAg3ORO1X6o7LYVHIgsEGurCcrEGFFebPAB5xtCR6liOkV6YwXsczP40ZwzKgOZkV1TOjHqCuRZgE2/TM2XA2LjzH1uF7VtXeTqipjfQFERPsmGezwXrYCT+RdcX21sT4jE96+lxunY+luLwG+cMALaffw6q9FsiwItslFLQI8/x8NmYndX7f6DpLaka6XCkVj1Rx+4oVzOGcj57YuUXDQdIooIicUug2p
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(346002)(376002)(136003)(39860400002)(451199015)(36840700001)(40470700004)(46966006)(2616005)(6666004)(316002)(6916009)(70586007)(40480700001)(82310400005)(478600001)(82740400003)(36756003)(86362001)(26005)(81166007)(40460700003)(356005)(1076003)(70206006)(83380400001)(36860700001)(186003)(336012)(426003)(7696005)(2906002)(44832011)(41300700001)(8676002)(47076005)(4326008)(5660300002)(4744005)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 07:28:23.0389 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56c89aea-a02b-4246-f895-08daadb5ad27
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5154
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
Cc: Kenneth Feng <kenneth.feng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

enable thermal alart on smu_v13_0_10

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 3d436e7f6e95..4fe75dd2b329 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1312,12 +1312,10 @@ static int smu_smc_hw_setup(struct smu_context *smu)
 		return ret;
 	}
 
-	if (adev->ip_versions[MP1_HWIP][0] != IP_VERSION(13, 0, 10)) {
-		ret = smu_enable_thermal_alert(smu);
-		if (ret) {
-			dev_err(adev->dev, "Failed to enable thermal alert!\n");
-			return ret;
-		}
+	ret = smu_enable_thermal_alert(smu);
+	if (ret) {
+	  dev_err(adev->dev, "Failed to enable thermal alert!\n");
+	  return ret;
 	}
 
 	ret = smu_notify_display_change(smu);
-- 
2.25.1

