Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B476C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Feb 2022 19:00:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 324AE10E468;
	Wed,  9 Feb 2022 19:00:33 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F93410E468
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Feb 2022 19:00:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SarslM0Tx1Xkt9eoCr6DaIQ4o6by8cDSnGLKKPqIxFyWArZYzNtS/NoiW/ZHcCed3ZSkHPx8QxwvKU+tVDoXfJHuZ+Dr30WsHkZVoYss+ksXcsTyyzvMTyFRZXB5Im/45K0keqOW/LVaQxg4A0imfAmM+ys0W8f7yLj6Mzu46n6n7OXbFaxN1YnLm9ayKTE/iAHMUE4DZLCSQAzVvXdUQAAAg/haYMyM0Epqw3FweWS5IDiF2x1sLOACvYuxzjZWsI8RLWEE8pVkgE4lIOpu1XG+O9qjNet9vBkljUgohBgpVcLWQxWyJIZ+I9NJHBOhpv8OP13Q2xcn9qNkotO9Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DC5JJKGHhcAWHvrYfjtP2J33w50XQHziv6YvC7P43SE=;
 b=aS/FR+dCF4u+FYfWudKjbgrF8+0TTFmkMLsLTXQN4TaTpQqgufPi77P9/cvX6IEPiE83A+hkxSWqQPTb2zDKFYJtcwBJmzxBYTEC+mzVlGZhKaJXX1CdxZhFIZWDhZuW78D5jvz6WNAwc2JnRoR7uxJrSxL0iSUcUe3KAN2hNLzF88GgptTqFkhIQKBdG/LZxvWu97SdLhUcSBXPITroo5yG6okWuJZcPz+UQU9bIeppNZnaWmdFSL1IENgj6OxkYZyAPt+XZ/6Q9r+1EgGBsiuOKw2emkxG/DNoc+XG0yeyrJrnhwY9tfTMKRX7BjvANw0RD/s25yOtOrst+CAquw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DC5JJKGHhcAWHvrYfjtP2J33w50XQHziv6YvC7P43SE=;
 b=ZHknjm0ZptwELfGIDZsF3kdFae6yW446BKZWusOoJ3Skt+XPyIha1znkJOqzyI/Uz70X0tL7Dai3is+T4rNi4XV0Ve3Rd0gmitFWUSMUEBeW9gFCPrR4PyH97B4Usg1C5Hz6HjDcxsj1URNq2gjrhHE7yzwkejSN7qaKYfe8sEY=
Received: from DM6PR11CA0016.namprd11.prod.outlook.com (2603:10b6:5:190::29)
 by DM6PR12MB3850.namprd12.prod.outlook.com (2603:10b6:5:1c3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Wed, 9 Feb
 2022 19:00:28 +0000
Received: from DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::9c) by DM6PR11CA0016.outlook.office365.com
 (2603:10b6:5:190::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Wed, 9 Feb 2022 19:00:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT058.mail.protection.outlook.com (10.13.172.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 9 Feb 2022 19:00:28 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 9 Feb
 2022 13:00:27 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/sdma5.2: Adjust the name string for firmware
Date: Wed, 9 Feb 2022 14:00:11 -0500
Message-ID: <20220209190011.603362-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 42718274-1ddf-4fe5-a1af-08d9ebfe6ff5
X-MS-TrafficTypeDiagnostic: DM6PR12MB3850:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB38505A827607D5665B68102FF72E9@DM6PR12MB3850.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:357;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H7lobbooZLu+1BuB4m8xoI/0CCB2zbCmnbBV3HGRQfEOo019kB8tbbHaiAXJrGLL0mbUDFPD139CNgYArerURolsd4MGQyBcJ85N5ZBQNPcVcRgfbzc+n56bwojGDOv2NSLWAeC9okdz69AbokMiE9mWaUx6vULILrCc9rW/dA7bvnWc0YYWpH4aJWd4vXwJU1BsKamE/UkdkqI8w0JOGyn+aHk2ESp52drjhBW7ygnACuHSKn6EGakupUZ1ZojWmhvLVc/j5JKn7uYdlOBq2RZfP2t1A6AtyWbBwNBu1xaMLJhk3gLUk0BvyZhv3y4G7/dGANAOdyHdXIPei2q+QcWALnLxVtBBUEoNi5vjHjOQLodx789Xq4Dkw8ifD6l4bo1mRiMuiy1HdE1gTzSRJOy7iZE61h5l/q8tMGj1xUHyfsq6fB/KlkfLxgWGO9VnDqxQYOAXrFzuLkTxPh/I3VSazWO2pMbGK6DVn9MZSgWy7PbBbYXEFm/KYUHoyyIQJ+j2cuhJPU2VlPvgJDZAui87uq+eABOP999OIqh5+TrHUsM27nS9S3Gbe1O/oZI1kbcfAWrcg8BjencLh7dBBDrOsPVfDBWL6agNuH08MbjOIInhtqJa84JWYBvk7aoOByvR2VHbj+GuHQNODy9CVzTeo8q9UP4RAav6q+B47hKM90rDdS338YK25rdVAg/SPIJqvN20wdNslFYfTVvxyA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(40460700003)(70586007)(70206006)(8936002)(83380400001)(8676002)(86362001)(316002)(1076003)(82310400004)(81166007)(356005)(4326008)(6916009)(2906002)(7696005)(336012)(36756003)(47076005)(36860700001)(2616005)(426003)(5660300002)(16526019)(26005)(186003)(508600001)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 19:00:28.0975 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42718274-1ddf-4fe5-a1af-08d9ebfe6ff5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3850
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

This will make it easier to add new firmwares in the future.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index d3d6d5b045b8..2c0f1e84a563 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -138,28 +138,28 @@ static int sdma_v5_2_init_microcode(struct amdgpu_device *adev)
 
 	switch (adev->ip_versions[SDMA0_HWIP][0]) {
 	case IP_VERSION(5, 2, 0):
-		chip_name = "sienna_cichlid";
+		chip_name = "sienna_cichlid_sdma";
 		break;
 	case IP_VERSION(5, 2, 2):
-		chip_name = "navy_flounder";
+		chip_name = "navy_flounder_sdma";
 		break;
 	case IP_VERSION(5, 2, 1):
-		chip_name = "vangogh";
+		chip_name = "vangogh_sdma";
 		break;
 	case IP_VERSION(5, 2, 4):
-		chip_name = "dimgrey_cavefish";
+		chip_name = "dimgrey_cavefish_sdma";
 		break;
 	case IP_VERSION(5, 2, 5):
-		chip_name = "beige_goby";
+		chip_name = "beige_goby_sdma";
 		break;
 	case IP_VERSION(5, 2, 3):
-		chip_name = "yellow_carp";
+		chip_name = "yellow_carp_sdma";
 		break;
 	default:
 		BUG();
 	}
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_sdma.bin", chip_name);
+	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", chip_name);
 
 	err = request_firmware(&adev->sdma.instance[0].fw, fw_name, adev->dev);
 	if (err)
-- 
2.34.1

