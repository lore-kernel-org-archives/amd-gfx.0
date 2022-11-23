Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46370C433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Nov 2022 01:44:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60BDB10E4C5;
	Wed, 23 Nov 2022 01:44:42 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78E6210E4C4
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Nov 2022 01:44:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h08ZOGv0Qpeoma1SQImlBV3f5dMqHPhV7+aJxhDwS3g+4WyPMEMIb0nBJQVbmMsfNphfScgheAkN7QU7gshYjp0xIokuC3y7/h75/JhHwSB3SDryw6Wj6xECDODTxPvEKPtA+8fGv0G4ra4VUal1+KsAvOfW4a975KHjkCzGW55fVtyQ3FFY/ha0MMDsxAEnHHUxzBf84ApE9BiuZcfjwIRqz60Gr7cxCQxX4+/N2uyYm25Yglud6SBxTdT+dO3TAkF5+lFXPV12E8+YKc7+rXXx0si0WVP7VZvN924MHc+EDud8icafipMBKNj9ZzQblbvf/cns5Ae22vxU7t42Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zVxASfR3JW2hNXkBJ4lsiHAfNbmeFYvQPtOZRZzcqL0=;
 b=W3bangqldzdjY6p05T5hVa5s9FOz4wOzFg9CBGB8aDQGrlKA6yV3qiLKoRcg2izAIoWqQDTEuNqn+TpkCFTHwDwH8vs2Da6fgDmvHeAa99EJ787WlinLthXfVg7ZAZYAqVspiJCWOlVl9af+uIuWED0EKm0+Rr5i6ugkyMJ4aYEB3YxagfVdDlVGUePIZrMaJgvQgX4RJdKBn3CQK97pr84zcc6uAl1QepJeGwEKP0Y1kjxia9ICnfIXdjGuHilPUwGqC4r7YOlDYRcfzKHKMVZ/BKLu+W4MRiV/+APzl5xs+0oVW6YlkU8tcH/+sHKTiA9v2XOg+1gETm1Rn+k5sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zVxASfR3JW2hNXkBJ4lsiHAfNbmeFYvQPtOZRZzcqL0=;
 b=UYUFj0bg/DJ3fEOXEKNZBdKjfPFdG9798HKXiQO3nfi7FBPYJ9R5ZkbsRTYtBmtv2hTEmDlhmENiG5el30H4Y9BYB2yc1EbVMvz4s2S/KyVqAHI9DJd3TUR8e5T7XPmXiV4/ITjrZZONOhCspHfSB9eLmF8ad2SHYBOmPYi1vj0=
Received: from MW2PR2101CA0015.namprd21.prod.outlook.com (2603:10b6:302:1::28)
 by MN2PR12MB4406.namprd12.prod.outlook.com (2603:10b6:208:268::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 01:44:35 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::9d) by MW2PR2101CA0015.outlook.office365.com
 (2603:10b6:302:1::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.2 via Frontend
 Transport; Wed, 23 Nov 2022 01:44:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Wed, 23 Nov 2022 01:44:34 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 22 Nov 2022 19:44:21 -0600
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <hawking.zhang@amd.com>, <lijo.lazar@amd.com>, <evan.quan@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: add printing to indicate rpm completeness
Date: Wed, 23 Nov 2022 09:44:08 +0800
Message-ID: <20221123014408.263645-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT064:EE_|MN2PR12MB4406:EE_
X-MS-Office365-Filtering-Correlation-Id: 55ba3956-b8da-4974-f906-08daccf445e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zRoW4DtxfqlgdC/AC01q0PuDhHwjqeXzoD0NZu3ytSVlc627AUu3E4qpX7/trw0lLCx//PvLLLJUwq+MoKPlTae2NAw3dETwurvQDDVw3QyfyvVPRHpi5pxi16KX8QBQkIjK3C1563MkZZmIav+kGyAcGUFLsJKM80Tqiz8XYmHDQwn6yPrLKj/zEirC6RZoC7Cip1qDSCTTRLRNc8g/vK6HaK3JWCDZ3MqxEmoYGLjRWl0OZSF2CmX7K0s3J3hWvOk+OxaLwlWiSfuUWayZEulomaHX3trssdnS/kauQxyjKsJjYxe8C3+3YXhIuC9wOb9WCFvOVO8Gj29v8Qm1r4/URFlWe0dcK82pSGGHkPjy0XyRRh7XgzRhQFIjAEwvrtjuhpNYCGwKFoWsqO5Q/s/7e4Odh74TIQP7+yILHKe0zBaj5HiBR/2Bl+Zw56/JjrUuxa1zulyMnHuAGtVj6qE4xSWBFZQ0Jy76K5e7RHSERyjh613EHDDihrF2S2T0oxHHC3+VOAHd8nmhsMEak+XqQxYo7knw22wjRjNDnFwAGdvFQ2XMCTszdZKBm2srruWUTBu1KOD4oh0gFsNJr8RJltQ6QWQ1+Xn17NPEuYcWEI34B+ihah9Qqq8Bg041OyFkVVjn71QTFqqHhf8W9+J4VJjYji/x93xJ8+/PRsYLqACeyOV0jFw7p27uEEPH+zcmlMRnGxrraQkOX2ZDuGvZRHIVF08cSUP6LcRKBBa72mlW1cI20G7+QR9LqiA0
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(396003)(39860400002)(346002)(136003)(451199015)(36840700001)(46966006)(40470700004)(478600001)(82310400005)(7696005)(6666004)(356005)(40480700001)(36756003)(81166007)(1076003)(186003)(16526019)(26005)(6636002)(110136005)(86362001)(41300700001)(82740400003)(40460700003)(2906002)(83380400001)(5660300002)(70206006)(316002)(44832011)(2616005)(4326008)(36860700001)(70586007)(4744005)(426003)(8676002)(47076005)(8936002)(336012)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 01:44:34.1857 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55ba3956-b8da-4974-f906-08daccf445e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4406
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

Add an explicit printing to tell when finishing rpm execution
in amdgpu.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index bf2d50c8c92a..fa42c0fcf848 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2572,6 +2572,8 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
 		amdgpu_device_baco_enter(drm_dev);
 	}
 
+	dev_info(&pdev->dev, "amdgpu finishes runtime suspend\n");
+
 	return 0;
 }
 
-- 
2.25.1

