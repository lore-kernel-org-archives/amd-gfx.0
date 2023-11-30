Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60923C4167B
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Nov 2023 05:09:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1CB910E6AC;
	Thu, 30 Nov 2023 05:09:39 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B077F10E6AC
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Nov 2023 05:09:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bB4wIA51ANV8xPv5HdshKYhJuIUFiWzZbgjwroWbEqk7xQAdH5GjDo8UpnFxmqVd+YGoylt/fHg88IrzTPrw4xykGdTcyOLiKxIaHHKi1RpEtRX2fX+lD9QiORr1ZfQTFi+ZOViPjcMkVENOxgVNmG7chm5ViJjyUOo0w7C1mhaGZAsU5qjLTdULyDzD4MqgZ6J3XvSRSzCbn7rcolxrfIN+2bsKWiAgRfuzkdDI3BX/u93y8NNQPJ8cvF2VATaNNW3wlFUR6GchgWHsY854LHRe2qw8cr+QZDAXvH6Qmk6MP328CJI1kVe+eLlHXysvuAVoUFOM3CBY5DD65zLrHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AluJ84CKAAp8oHcddz00EpJSwSfLFjmGXFPbmdKLOaY=;
 b=M7omQlj/ibtONOYhWTjA65V6FGrlI9LLcX1aGAw/xKNzv0mWekLMQZQxk8KnVMrAJBKhyQTbhBDgn0wCvD75lR4BYvMRqR364kHx3tPiskHjRx8We+oT1X4fYIc2OcVnqCt8oTJjROj/MxJEbKYzWzMFDm0j3ZV5ahlhruTbl2mWmNEAEFV0vvkXSKYTazK77p9w0IjwGXuz21EM5nYLY1LftNaf8bZj2H6N/cQODz68ar925KBA4hTRX+mgb97Tqdl7dfUq2qJLUEGvo3MAk/mgMk4OQfNL9ygmLX052W3JuhP+uP07bds4m5S3lZVxAEcccr0UFHRL6a/ERcCFAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AluJ84CKAAp8oHcddz00EpJSwSfLFjmGXFPbmdKLOaY=;
 b=zQTKXsXES591kXmnK7Px0dbyLRuhMSrC4vj7TAIOxLsnt5t4a5lOZMk4++RsfoCFqRvUCOLkXDaP1GnBMEuDZBVL/Bj4pex6qxgrUxlZqz/tMwiVST9zER9glCuKQBdyOg+wynfZ+9yTTlgFGqAfh6BhMAtxlEGDt0oxxvIInI8=
Received: from CY5PR15CA0148.namprd15.prod.outlook.com (2603:10b6:930:67::17)
 by PH7PR12MB7453.namprd12.prod.outlook.com (2603:10b6:510:20a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Thu, 30 Nov
 2023 05:09:34 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:930:67:cafe::80) by CY5PR15CA0148.outlook.office365.com
 (2603:10b6:930:67::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23 via Frontend
 Transport; Thu, 30 Nov 2023 05:09:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.209) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.23 via Frontend Transport; Thu, 30 Nov 2023 05:09:33 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 29 Nov
 2023 23:09:31 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix miss to create mca debugfs node issue
Date: Thu, 30 Nov 2023 13:09:19 +0800
Message-ID: <20231130050919.1283614-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|PH7PR12MB7453:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d3e0cc4-29ea-4a6c-f670-08dbf1628acc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k3OnzVLFZYEjOScgV81KY6EYn4Mfslk6u6STO5AtnHXbn5mADFd2SIESqgB/si6jEt+q6C+x4RfWQn38n7puT4+SXc27R7pT9fTLyLuAgTuJ6H953W2sXZJZvCTXgh2F33tiDg6zTTWfgoOtTIO7gIf1vb36UJblyHcnL+7I2uptcL6q5z2LU97VGPLTDAAcjdn2CRpl87tSz3ohHx9XkmgP6sAmG6wW11qPqGwsCTSJqRzL86wnTMp9Q1h72WliZJ+goEPXPH2wqgW2v55FjHddVkUd9bPbP254Ut0N2MqWCxOmYNb6uvqjfLw46GsHcmN9HN8NcViF8urA/EEQ46/giyhXHrYU/Tj0ATkLEbehohpQ7phG7d+vialuONBWBpTEGEXCoG9PmOgOeFO13+mNDJjMLaKVoWq55eB4492n4s732/+BH62f5m4pl4+FLYFaqaMgdtjTZOY1U9tIb+3cQ32fMCE+DaQHXDigq/NF0wo0xjDhGCp/YCaGhuLDLtIywMOJHWHP+MLK2c6VzHz1mHk5o3VFKFFkyTwM2TbG4l1MUZuS1mnds9uDy2wuY6L/RmdR87oyQwc9MBwlYpEvHq1o32hQRTgB4VvETSOl1h+IhAmjPr+LITtq9pAxY73dyfp4rju1ro25al4MuwMJQqF41kjzxp0wfrmprV9J9ZV45QU/5TDNav5vjo+pWy8a9eKquSgsyPBLd6zi5jLvo6/MwQcs5MML3EjXObGSx75KTVft58mFqf6FD2vsfR2gsiQvhPGtLqc0d6TgkVGuoAgJWExSnI2OVwmyux2o7I1am9eMuHpyRYi3C0tl
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(39860400002)(376002)(136003)(230922051799003)(64100799003)(451199024)(82310400011)(1800799012)(186009)(40470700004)(36840700001)(46966006)(36860700001)(70586007)(54906003)(426003)(336012)(316002)(8676002)(6916009)(70206006)(4326008)(8936002)(47076005)(40460700003)(83380400001)(2906002)(202311291699003)(36756003)(478600001)(86362001)(6666004)(7696005)(356005)(82740400003)(81166007)(41300700001)(16526019)(5660300002)(26005)(4744005)(2616005)(40480700001)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 05:09:33.9584 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d3e0cc4-29ea-4a6c-f670-08dbf1628acc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7453
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
Cc: lijo.lazar@amd.com, Yang Wang <kevinyang.wang@amd.com>,
 hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use amdgpu_ip_version() helper function to check ip version.

The ip verison contains other information,
use the helper function to avoid reading wrong value.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
index 54f2f346579e..210aea590a52 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
@@ -485,7 +485,7 @@ DEFINE_DEBUGFS_ATTRIBUTE(mca_debug_mode_fops, NULL, amdgpu_mca_smu_debug_mode_se
 void amdgpu_mca_smu_debugfs_init(struct amdgpu_device *adev, struct dentry *root)
 {
 #if defined(CONFIG_DEBUG_FS)
-	if (!root || adev->ip_versions[MP1_HWIP][0] != IP_VERSION(13, 0, 6))
+	if (!root || amdgpu_ip_version(adev, MP1_HWIP, 0) != IP_VERSION(13, 0, 6))
 		return;
 
 	debugfs_create_file("mca_debug_mode", 0200, root, adev, &mca_debug_mode_fops);
-- 
2.34.1

