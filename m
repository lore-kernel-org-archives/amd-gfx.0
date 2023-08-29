Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25AD5C6FA8F
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Aug 2023 14:55:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0EAC10E374;
	Tue, 29 Aug 2023 14:55:45 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FF0F10E374
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Aug 2023 14:55:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V1G+52eWrHbiGBi71N4mnHRVVglctnYiTxdVDOoqrMXzmGj1WEhNiz6NO0dNlOv9u4NnXhUBkp2B+JH5pIHnzIaWC4rw0IxaqX3a4wrhuuqt5rnMr2woue5xq80s9/RxlMZHqB5LLFL8yOs8yz8LY43nmxSA3XOt40fBtlvdPGKhBlVp/GvyQpZ9m20duPS0CR885vzk3ab7L+i+9zIXTz/bmJUGGieoXkBV0XboqHq6mNnlKUg2RP74u2r5ldmii6D+7yxbMXJ6k1giBno2Ti2+pqgMAk/a6Z43N+r790VMCvJg8UKdF/xRCKCwWLe+3Mz5zkzOaHQI9oL2mdXeuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nHfiSnOzdMXuUyi36oMqFM2xnHz6OJjtCOQTOYPcTdU=;
 b=UEwG94OXz1wRsu+ORyOXu63KhtTVCkBl6ZrmBT60J6SIAgIXCCYiWLHvkqJaTFQf95xWGdQtgULFTqWpK938E6MxDeNd/y7+LwK77TsQrJItvkmWL8nMUfDjxYHLhWD8KCyRMhF6uEd1D6lh9iAd3qnbYrBf00IILH2PQQRn/7F3zxQL5jESy8Qufy8NTg8ZffsJU6eLq0g8InuFVumqozVmiDlFCq0ZE7Cy3VoixtRSLACvGaLmmMBCSn23JCKTFIZLZZyASjeaOl7Gb7DqozyEJJjhXKjS9Ul1oAfFpy7B7gRG8+gSJ5X+wJWO0SrHHdWGoK4Gbb9oHHAtwlx0zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHfiSnOzdMXuUyi36oMqFM2xnHz6OJjtCOQTOYPcTdU=;
 b=Za0Otj7UpffJVXuaLb3B2cvRt5zI4DwJzK4i4FBz19859m+XNlFlA9nYZjIPdPNz5ZErEHDJpY7okh/v3gOSY7NXTBiJ5G9ShO8wp/ysFXMlAHxjlfrCl0IlMDhhNqiSdusVJtR51rVgngr2ircyZ7mS/hQn7zFaJlN2vFO2OgA=
Received: from CYXPR02CA0009.namprd02.prod.outlook.com (2603:10b6:930:cf::17)
 by SA1PR12MB7038.namprd12.prod.outlook.com (2603:10b6:806:24d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Tue, 29 Aug
 2023 14:55:42 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:930:cf:cafe::fa) by CYXPR02CA0009.outlook.office365.com
 (2603:10b6:930:cf::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.18 via Frontend
 Transport; Tue, 29 Aug 2023 14:55:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.79) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Tue, 29 Aug 2023 14:55:41 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 29 Aug 2023 09:55:39 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <tao.zhou1@amd.com>, "Stanley
 Yang" <Stanley.Yang@amd.com>
Subject: [PATCH] drm/amdgpu: Free ras cmd input buffer properly
Date: Tue, 29 Aug 2023 22:55:25 +0800
Message-ID: <20230829145525.30096-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|SA1PR12MB7038:EE_
X-MS-Office365-Filtering-Correlation-Id: 50f2e4e2-ea70-493a-5bc0-08dba8a003e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AkzjqGVunoLXopdl+G4K7Cm5tQ5CQdnhMLi2LdoNVkf+TSngs9QRzHPfZITT415zEGSrI0kl94or66YaVGR8BHVVf63uzo0hjv8OiPfJIU2Y7uaFR8sbgOzkav1/mY9WOiAdJaTDieD/vXvtQfbHQkNRBY+LA5hyBjm18G13sehIMLiZwZCFOciXfnmKt5BYLg4c5GxeRjYmSBqW48jYVs9Y42dWROxIshp0Uf1p8yGyCKqcFJPTHTPvzKFzMT1E7sp2Q3S2znWVO2b1ssAAva88lkQNLN2yBd8El8cjusUvSvMik7oHTK2OmTIN5X/wVl4ndHWswuGnrBr8YA6voYh3s1KV1Ff0EbATARhbP4b3DtHLehOMMulTYdMiUScSGd5Oqt7aGuhRDBUdeaB6UzcEtqsKXqGbk83y+vyLJxUgXhK0Lhuy+YqYyTr7QvE/FfnHPwGnWs2qiLVwA+ROCalwujeuRaRd9CJc63U6hgxmk9m3dhhPzMiIhrUsIlI9XTsVjxHNMLtAEMqgwO9ZjnKqFM/e/QYXNnk7izwuEVIDFZrB7mf544fkTkoGk3yovpauHMLAv0t2lQwbWX1ah9dJLrhDlm4cDdsGkGrmIThEXzOHrIr3qAB5fYQdzN8pOcTOAayMpGBPU/83o4eb7T88y2Kp8Ma5P8UY1alx/mXDknWy01pIwmho2sVbEXnSeTBjcDEFnBO6qB5HRuImjJPTYx+3F6PqwFBB9AvGjPJbwPOHDvfHBIFmCDWLSBwGCpi0KS5bfyTquBXozM1xNg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(346002)(136003)(39860400002)(1800799009)(186009)(451199024)(82310400011)(40470700004)(46966006)(36840700001)(81166007)(356005)(82740400003)(8936002)(6666004)(110136005)(70206006)(70586007)(478600001)(7696005)(6636002)(316002)(41300700001)(40460700003)(26005)(16526019)(36756003)(8676002)(1076003)(5660300002)(83380400001)(2906002)(47076005)(86362001)(2616005)(4744005)(36860700001)(40480700001)(336012)(426003)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 14:55:41.5494 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50f2e4e2-ea70-493a-5bc0-08dba8a003e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7038
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

Do not access the pointer for ras input cmd buffer
if it is even not allocated.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index e47600a8e88e..16c5fe487ea0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -804,13 +804,13 @@ int amdgpu_ras_feature_enable(struct amdgpu_device *adev,
 				amdgpu_ras_is_poison_mode_supported(adev), ret);
 			goto out;
 		}
+
+		kfree(info);
 	}
 
 	/* setup the obj */
 	__amdgpu_ras_feature_enable(adev, head, enable);
-out:
-	if (head->block == AMDGPU_RAS_BLOCK__GFX)
-		kfree(info);
+
 	return ret;
 }
 
-- 
2.17.1

