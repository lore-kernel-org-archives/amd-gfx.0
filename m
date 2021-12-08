Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A03BAC433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Dec 2021 09:43:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 210AF6EE8E;
	Wed,  8 Dec 2021 09:43:35 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 161E16EE8E
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Dec 2021 09:43:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TVDnmDe8kp1syJVolbiRbiKulohRqBjxXzgdkLs7iAIxuQqwgqirtQ7Cpzmof2m3gpzbuTVPcciJ3j9kexwWL5ckm+EcfuA2RRoc5gmsz1DdnfLd8rzH2V1o4li3YBDgk9X287Vs/PoemU4u9Mso+JKvAb2/04P4NWcxeb5usxLCtL7BNo50GsKPvfYiQnG+IeYfhdmX4FHYXpFoLYjnKBZ39UKhlzc6gmjkJbObo9nMP2Gy+301pwPLzYJQemmv2HsvqHdn37EA1zU/TsDGVMXM2Xm3ee5uyUFCN2e4kmg1nurOuPCNXKg5vn4E4+w+Udr8tyXooPedzyzZPPDDkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9pG/BkbaQB+jt/oRv3OLACFSWSM9VXQheaMIt00QBQw=;
 b=Sy2VdN5Ntwd7yuCG2GGOxktghjxjMH0Pqd3q+VBOZj4KUMCdv4UPIHftK/U4E5HQpxDjRp+TltBiZwZed8dqcl2kxl+KxmTV7lSTJ3qkH0Ndw46Qt4GNJSnMA+GwUbE9Uj325J6++IBxf08Lvz7Nvni10zrwz0/OwxbFh4S5S1L6VxCyjpARnWIk8ExQLpLdSbd1axP/mWxT3mDGwhD1iZfdP3GY66FyfnwUm/0YGc2McU5ypVpDydWVL3rfqmR3XUEHE2n2ZTqgjR4QsHkSp7+MgxyhqtsdeRzk0OOSuZ8DWwIQDyJeP1dbrujrpF8Ny7Iaa+xCeTmflkAYbeYmNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9pG/BkbaQB+jt/oRv3OLACFSWSM9VXQheaMIt00QBQw=;
 b=W+W74giJPhvFa9cBDeDE/L2hGxyIvfhtvOksd5g7sxn8Bn01dNc8mv3gVigvVlS07W/Kf8PqI/wbuX2MBbF+sVaVC0m+oUMf+yDV2XtfneVxygODQ4wI3bnVRBo50wk2mQGTZYx13gPBZzPhY2IZSUNN+M71JknGUqbeZnR5rcc=
Received: from MWHPR15CA0044.namprd15.prod.outlook.com (2603:10b6:300:ad::30)
 by PH0PR12MB5435.namprd12.prod.outlook.com (2603:10b6:510:ed::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Wed, 8 Dec
 2021 09:27:36 +0000
Received: from CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ad:cafe::30) by MWHPR15CA0044.outlook.office365.com
 (2603:10b6:300:ad::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend
 Transport; Wed, 8 Dec 2021 09:27:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT011.mail.protection.outlook.com (10.13.175.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Wed, 8 Dec 2021 09:27:36 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 8 Dec
 2021 03:27:33 -0600
From: Lang Yu <lang.yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: remove power on/off SDMA in SMU hw_init/fini()
Date: Wed, 8 Dec 2021 17:26:41 +0800
Message-ID: <20211208092642.173385-1-lang.yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ca31cb7-076e-4808-209e-08d9ba2cf898
X-MS-TrafficTypeDiagnostic: PH0PR12MB5435:EE_
X-Microsoft-Antispam-PRVS: <PH0PR12MB54355F089404DA6DD6B2B59FFB6F9@PH0PR12MB5435.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uBubKcYtbQXsL9k3nwforFGieBuUw/xviFbKRDiS/gO/7cQQ9siKxzQcYq7QS6ZR5YAcnAy8Wky8aV4jdbaC+pbL2H+/iz7S27tFSGbp3Q/bTvfBcYs43wwQSEBcdhu9q5+B/BudPLuyb90oVANyuCkG4Gx89p0iWshDGEHRCWOFE0VU5qLBnQps5dKLfH6JyQODwANX2pQ3x7ZPO+leVmQBDvXpYaWQmHRvOodpGVS2HIJGwD20n39IJeyHG3bA2enE59ggGRrSgCIeT4076tv6q689vmThKwi7v12+i7/AcJuv4ZUt6J8q7L4vpVw4zlfPiKNz84DYiMl8e8dMCmUUvjV9DyRkFqnn2G/UxOV8W8zheuQTDRYYxwCSwCyCrexSwPAT0CLtlLZll17tSnVkhMf04e9XrNN+dO1cgScCZG/TD8TH5mKnNrxQREhUyv/4KmxzClLLM7drHXnONUVxSsWjyUaVjsDuTYKYVmDjHjkuP2JQqlhy0B0X70hskDmcUQIo1ZJ7LDEFHR7KYFnP2M510LYYPbmFg5GIs66SKi+WhlPo43nv6HEhOR8lmyXLQlFXZ0rcgeR4mfE0JqnP/d4ikk1VmuKx0RmKVtW81LdzTm+BYYX67TJPvsREVoKqasNr3UxFaba5vCLzjZ5UOQQtfTb4+MqZl5cfBXnZWeE/VkdHnmOdUR2QDzcdVR+cPWEW/CfIcED+tTf529on6gGuAAD4dW2GNt+EHT7Eeaz5jKfKYp42OxQjvxHYxp+PzE5tkqe4irKfh5co+RgUxrCkDf3KXQ/buYpbFV8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(426003)(47076005)(26005)(36756003)(1076003)(8676002)(2616005)(86362001)(82310400004)(83380400001)(81166007)(40460700001)(6916009)(16526019)(7696005)(186003)(44832011)(356005)(336012)(70586007)(70206006)(54906003)(316002)(6666004)(508600001)(8936002)(4326008)(5660300002)(2906002)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 09:27:36.0090 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ca31cb7-076e-4808-209e-08d9ba2cf898
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5435
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lang Yu <lang.yu@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Huang Rui <ray.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Currently, we don't find some neccesities to power on/off
SDMA in SMU hw_init/fini(). It makes more sense in SDMA
hw_init/fini().

Signed-off-by: Lang Yu <lang.yu@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 5839918cb574..2d718c30c8eb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1350,7 +1350,6 @@ static int smu_hw_init(void *handle)
 	}
 
 	if (smu->is_apu) {
-		smu_powergate_sdma(&adev->smu, false);
 		smu_dpm_set_vcn_enable(smu, true);
 		smu_dpm_set_jpeg_enable(smu, true);
 		smu_set_gfx_cgpg(&adev->smu, true);
@@ -1512,10 +1511,6 @@ static int smu_hw_fini(void *handle)
 	if (amdgpu_sriov_vf(adev)&& !amdgpu_sriov_is_pp_one_vf(adev))
 		return 0;
 
-	if (smu->is_apu) {
-		smu_powergate_sdma(&adev->smu, true);
-	}
-
 	smu_dpm_set_vcn_enable(smu, false);
 	smu_dpm_set_jpeg_enable(smu, false);
 
-- 
2.25.1

