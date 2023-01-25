Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B97FC54E94
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jan 2023 17:16:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25FBC10E7F0;
	Wed, 25 Jan 2023 17:16:39 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2073.outbound.protection.outlook.com [40.107.101.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3897710E37D
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jan 2023 17:16:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ntwaMwh8odw9agf8RrHQ8cTsWDAUt8Yls/rWhFoekCB4V2boY+aXeNcCadbaxGmzpYUENrqQoj906zQOAJuW2j7MXY2UCeaqiuyV0Ek+f+hEG4iFUXMBGJeCXQZNhm6vjS3ZqEu6+fAWBAyiDTmVhdJpXu60VAFTFLH+i/6FvTgVTjdnRBzL8TFBhe3POpe955549HRMo7lGIcdhmyjBqSCaWyH/ZogL5xYxPArmBldyJ/oP8sCnPW50GcM+AtF2WQspIwnOoB+uvPKyzPDek67/l4TzAeltvKSLEDpVjssHm5hyt+jHUXOK8I1YQNAhCfAp4oqpak8Pv1SYueAFEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w27AGW7/3Uh6GhWmcPVaN8Esglmr2CERyqukhrN41Go=;
 b=Z2MaVCXGiTUxC8joQLo2Fczlm4hS1+MqIpUxfg6TSogta3dqDMvYYCRhoF6hvivpMdf2vWShxlHjvF0eYSgA5zGmau1wJFst1VdWPT6XrtpWjGC0nLwBJqsWCTJonXagQ2RA19ZHmp7jBb5t3MIrYU3qFGXRsCElthNfhRgIqFL5WPElnBY6ZRdA8G29ONbi7DpA2qa/cJmlrpU5wCQx9BvDqZJnprYZdJAOQj2vNm4HY9AlUdzPFR7LyNZjAnN8YJfWqjAzFZ65XNP5wW7/xIU/TUWPE6ihG3cBDI6izsxGRmkImDubYIiSH7XIT/FQduWAPBYa7krP/QMQWJ3tTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w27AGW7/3Uh6GhWmcPVaN8Esglmr2CERyqukhrN41Go=;
 b=4/Q6L0QNzLPjcH7pJq3AGer5x+A3c/lrO8xi1xnKxV/Fg3KXIslafU3bnArGiJkhkS6USgtKcjTUhNO1tO+lwf1Kx25fems9DldPJvZ10J6kJTu6MDhV342g8kb5DBUDxl5LF134uzSEbiSSX8i+yVwCergI+UMB8Zkcy2qDcaI=
Received: from MW4PR03CA0243.namprd03.prod.outlook.com (2603:10b6:303:b4::8)
 by PH8PR12MB7229.namprd12.prod.outlook.com (2603:10b6:510:227::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Wed, 25 Jan
 2023 17:16:35 +0000
Received: from CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::88) by MW4PR03CA0243.outlook.office365.com
 (2603:10b6:303:b4::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.17 via Frontend
 Transport; Wed, 25 Jan 2023 17:16:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT050.mail.protection.outlook.com (10.13.174.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.17 via Frontend Transport; Wed, 25 Jan 2023 17:16:35 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 25 Jan
 2023 11:16:34 -0600
Received: from desktop-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 25 Jan 2023 11:16:33 -0600
From: <vitaly.prosyak@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <alexander.deucher@amd.com>, <yipeng.chai@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: use pci_dev_is_disconnected
Date: Wed, 25 Jan 2023 12:16:30 -0500
Message-ID: <20230125171630.112605-3-vitaly.prosyak@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230125171630.112605-1-vitaly.prosyak@amd.com>
References: <20230125171630.112605-1-vitaly.prosyak@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT050:EE_|PH8PR12MB7229:EE_
X-MS-Office365-Filtering-Correlation-Id: fc9a9843-81fc-48e6-8938-08dafef7e968
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6pZzWF0cZdU8jGZPuhMuXUDUugHalXdjOBoBUg5E+Jva8/Q/RI7Ll+LDNd4JJau7AIre0KRNeefaxk0Fm3QjVm31qPBA/wrZnKSbrqqZKi1/oPXeGcZx52xb2HawxyBX+p6i5kphqgKmDTYtNErUS8/Xgk51qc8WyHoq4UFXKtXCMZt9qw+AnZNLYkpbj10YaKCCwtCd8oVgAAjRJLXnoElBhsb3cbXu9zvgZSxfGNfjL2Wv5kZLqykQJTJXnq/0Q1lNxgY84mKChQYX29Qf+OZ76A+CWpPoYm7JzFbzQ0C6uxXQb2zDa6ansErclhQZOvCzv5ED0GSTEiedSdyhpZc8FHZwH6gqz4AN/2NLGHs+4JnHg0EuR5XBOBbTKD29VqFw9LxiTr6Uh++OloSLQNmIcxPNNrYdPFrlkYZbCmGbmmoYf7J3yctGtejWt6RnACwVrS8TdW3DvdWrWARQXX9jY/7Ahr5/EmPpr6iQrMEgpBbfTQhxdQZNdqFmz1lkLf21/1MENNxEg6klW6FPjieS5pmOiJ2rGMJXrQ5IW/fIak9DSE/tft1hhfpYcm0JacNC2HoZpy1Krq2OIkj4pv1rzl80HW4jTzeXGHJIODF3FvgPhZRWKiWMHU4kD+iQErmvFKOidOqE61t2CtAQsKwgoYoO0YsyeX6VbKFG6LHTs186+g1vzTP7Uqf2UrrPXqNhi5q7T+z5q3TQHRjT/xLvKL+JK5tia4TyqhAIEHw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(346002)(39860400002)(396003)(376002)(451199018)(46966006)(40470700004)(36840700001)(41300700001)(86362001)(8676002)(6636002)(316002)(110136005)(2616005)(82740400003)(2876002)(81166007)(186003)(478600001)(356005)(7696005)(26005)(1076003)(36860700001)(5660300002)(8936002)(40480700001)(82310400005)(83380400001)(70586007)(40460700003)(426003)(47076005)(36756003)(2906002)(336012)(70206006)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2023 17:16:35.1259 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc9a9843-81fc-48e6-8938-08dafef7e968
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7229
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
Cc: Vitaly Prosyak <vitaly.prosyak@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Vitaly Prosyak <vitaly.prosyak@amd.com>

Added condition for pci_dev_is_disconnected and keeps
drm_dev_is_unplugged to check whether we should unmap MMIO.
Suggested by Alex regarding pci_dev_is_disconnected.
Suggested by Christian keeping drm_dev_is_unplugged.

Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
Reviewed-by Alex Deucher <alexander.deucher@amd.com>
Reviewed-by Christian Koenig <christian.coenig@amd.com>
Change-Id: I618c471cd398437d4ed6dec6d22be78e12683ae6
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a10b627c8357..d3568e1ded23 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -78,6 +78,8 @@
 
 #include <drm/drm_drv.h>
 
+#include "../../../../pci/pci.h"
+
 MODULE_FIRMWARE("amdgpu/vega10_gpu_info.bin");
 MODULE_FIRMWARE("amdgpu/vega12_gpu_info.bin");
 MODULE_FIRMWARE("amdgpu/raven_gpu_info.bin");
@@ -4031,7 +4033,8 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 
 	amdgpu_gart_dummy_page_fini(adev);
 
-	if (drm_dev_is_unplugged(adev_to_drm(adev)))
+	if (pci_dev_is_disconnected(adev->pdev) &&
+		drm_dev_is_unplugged(adev_to_drm(adev)))
 		amdgpu_device_unmap_mmio(adev);
 
 }
-- 
2.25.1

