Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF236C77B61
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Apr 2023 02:36:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40D5710E004;
	Tue, 11 Apr 2023 02:36:13 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B633D10E004
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Apr 2023 02:36:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q09b6Rhw/3cmrreS1D/2yT2WZ4H/7DC5ckU5Xp7aqzTx5JRCCiDTD8jyKgMUmnVRzD2QvM3OsTRYjVfcPIIar1Ljkp7VWxN5blaTcfulMspUCPJh6/zIvhF0QMdbGqPJtEM+bAKq8MJdxNm2aKHQEHvn2r5KJxiGE+aAekDhJy6t4RtQpyNpTQwLn54HEuGltmCwWUjd86esguO5bS0w6fKsg1zwHwyZJGCQJffhDA7NxxszOcNTJY0R2cWv6f71mHMl4wfUX7rhQEgjaJFWNXLYXVm8umdac8zS6xuYzKuHKUKjotEgF6G4Assv+dMyfIN08yavAfwuOMjfsPiJDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AVW+q7HZe4s6blqg0Tf1aJiqgbbJSjIBWv2+44I8Wgo=;
 b=HSgP0EKgqUBoxKXRPfLu6D+jrp2MQWiLioDHropUS0znmKLNaEkAGXvtIbzNV2Da+6jfZKgEp0zGwYj7ZJI+9FoT7e04TYggg2n46tFSLuTn+o5Z5meQ/O982I7TRqjLHD8FaYuvnOQHrYpzA9OWKzbKXZFEA+hOMNNmgF06kkh1fxPuH4PkRmAEwRFWZz7WFnvVRqxEnVtc4tcwqruHWHWlNxWCg9iTHDKKglAVyPhSlaQvZFp5Bb/YsluGSEEQ/4U+wbqJ6wia1WLcHu9IOddmHcMEZpwa00c3z6wE38rwaIJq7EIZBeK5zksfXxrZuTL7Fg8tLMJMTAxrkS0Mug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AVW+q7HZe4s6blqg0Tf1aJiqgbbJSjIBWv2+44I8Wgo=;
 b=mvyCvjlyxyv1auJ/q9AJxz0tkSo2nt3KjHG6zNgQVtpXqxpg4ANfQSkFvHJ9sdW7KxMN95sloab4snJRmb4v1GMdRQ9RN7kbTNqLkNINcCwQAt/0rvig6vg4r3QipYIgmo2JwVCrXCskTi+7oOGTObOmtKtKxsp8Qf5kOlDqvqE=
Received: from MW4PR04CA0224.namprd04.prod.outlook.com (2603:10b6:303:87::19)
 by BY5PR12MB4194.namprd12.prod.outlook.com (2603:10b6:a03:210::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35; Tue, 11 Apr
 2023 02:36:07 +0000
Received: from CO1NAM11FT105.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::92) by MW4PR04CA0224.outlook.office365.com
 (2603:10b6:303:87::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.40 via Frontend
 Transport; Tue, 11 Apr 2023 02:36:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT105.mail.protection.outlook.com (10.13.175.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.28 via Frontend Transport; Tue, 11 Apr 2023 02:36:06 +0000
Received: from jenkins-mali-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 10 Apr
 2023 21:36:00 -0500
From: Li Ma <li.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix introduce gc_*_mes_2.bin v2
Date: Tue, 11 Apr 2023 10:35:35 +0800
Message-ID: <20230411023534.2439943-1-li.ma@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT105:EE_|BY5PR12MB4194:EE_
X-MS-Office365-Filtering-Correlation-Id: 56832921-8bde-4c82-456d-08db3a3580b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 65FckD9whV33yLIixD0i0wdCXSg1E4XcWUfIjmtGQUijdUqOP6w+rdkZHIJfRP+4LuzN/jpkl3fKfv2Qwrk87GG/mcSAGbzDxPHaf/hNhs/L4hxC916egSjhTSLOK5OCUdWq3/bgmX7yvcBtdksEUvadxFtXR4dd6C78ZBlsQ9dgiq4SNLHjiQ7cIaRXYTFvDZAlGxATpe5pvrHIG89GfeAmaGYcRiDwnUWPKKz5c4s5tTX7ndxrQGEHzlV8sO6slZc0IS578ifUhFF0S7BmfvDKxqmNur7WDoW+RRM9cvLl0e+R4SJWTSWDzbord1/z6pPDQ9c/cdZmnTaU9RmcK/OtzgP1NnKkfrFHXY+bKPKwwG5ls9uTajhi8jm7qwbPJcr30b9XFtgdRCuvKgTUhNnxvDec7fecvPDptPUf7ER2BQ9yQ+P9OBLvIhyzYQCvFzPld1n7J9bd8EAtiSOv03Z1iOxkZnwmBiEgZ8d98HzUtdX6SXyamE8XLPrhO0Ag+GE4zP0rH0sxSkNZmCJ/KnNtQpF3KJ1Ja4DdgkudUW6b5BcFpXVCHWCvFZJsiT0Ih1IhcBTMRbYwoRSfna5xWfGWeL/6j6mIrDFjCKmQiZExILZIUEX1aHNBI5EudB3Y1fS5brvylEZqVTO+Z+f6sCzImX/dtNBZSapk6pXyHsXH90hOFa7UFG8/IOI8aIoJBIT4/CgxULpQbz6VJ36s1yWCfLwO9yP+qGJAcrGwnxU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(39860400002)(346002)(376002)(451199021)(40470700004)(46966006)(36840700001)(70586007)(478600001)(7696005)(1076003)(26005)(16526019)(54906003)(186003)(6666004)(316002)(2906002)(4744005)(44832011)(70206006)(4326008)(8936002)(5660300002)(6916009)(41300700001)(8676002)(82310400005)(356005)(81166007)(82740400003)(40480700001)(86362001)(47076005)(40460700003)(83380400001)(36756003)(2616005)(336012)(426003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 02:36:06.8248 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56832921-8bde-4c82-456d-08db3a3580b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT105.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4194
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
Cc: Alexander.Deucher@amd.com, yifan1.zhang@amd.com, Li Ma <li.ma@amd.com>,
 xiaojian.du@amd.com, tim.huang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rename MODULE_FIRMWARE declaration of gc_11_0_4_mes to gc_11_0_4_mes_2

Signed-off-by: Li Ma <li.ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 67f7557d545d..7e8c15cd8dc2 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -40,7 +40,7 @@ MODULE_FIRMWARE("amdgpu/gc_11_0_2_mes_2.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_2_mes1.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_3_mes_2.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_3_mes1.bin");
-MODULE_FIRMWARE("amdgpu/gc_11_0_4_mes.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_0_4_mes_2.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_4_mes1.bin");
 
 static int mes_v11_0_hw_fini(void *handle);
-- 
2.25.1

