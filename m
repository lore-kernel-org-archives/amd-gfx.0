Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BA94C47074
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jan 2024 21:56:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D73089CA4;
	Wed,  3 Jan 2024 21:55:58 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E121310E34C
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jan 2024 21:55:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kBv+gYe01bwi4xIoGNiSV37mLl9ly75dEFo/DrPSTtysqcctKkoQFukCZ1kci/AHGrL/NBt1BB1wtfSZEv3el87aW9HBiYDOsceizbfMKYvI0s+UVYNuA1u146nYhuV/SPtMmqzjj2ynA4KVlyHsBEssrSJ4lpp9Nv8sEZVPojZqQ9WQg7YvEJQkPtIHblPU5JrHCV1u1wBGd1lmDRPq5ZQWix4oVXZ56FlAVCgY3OkYsqhd1qoDlG/M0n3Y0hAErBe6gCY9EFKLt4zm5MZeCeQIyUPb6fByNlmxWkq7g/k7XVhkgXh/E7QkZRpiu3bZTqbsdgn+RU211ZW7F6NXYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s+1zPc0hodLFj6DqHjg1o88nWv7bqz+yQM8C+lUi/wg=;
 b=OeXuiUGYWGh/IOPMoLPEtq8Dg/o6xyavvFIy1XZZHo9d6IhU5KTjF0YGtrhKP3x2MNhKbnShZ18mnn9qTRFJIcVyG6mu0e7lI8WjFnY8GVzq3bFfMwinpA+m3aPM3bhJZc2nH+DBd/7OuQeE4XAHuO8PpxozgcrZXpU23GHwg9EkftKGWYugRYXwKcAvTlet2zzI40Fl/uyz4g7//0Xkk68r6cp7HcCplQHGsDsp7qVxNbqt7QxDaH0Yi/6CHqFY8mwnCFqzncAm7g5+r3MPUuTUa30sNZKvnzfPpqi9CQ1sB+gA4ahFB+sJIdksjO4llCJ1X9UTgDb9472QoYEZgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s+1zPc0hodLFj6DqHjg1o88nWv7bqz+yQM8C+lUi/wg=;
 b=ibtP8XK05miwlNTPTLz6EdT9BZjqnsyfrBozRe0oMKGY6IVVYDokTNds+Az/k72GRSHCUeuuKOF3Ba1pMqUbBV8yTmd0NFsH2GXS2cOsW05pbMKIrFgORMlthT+FWoIjtx+KF2+watG5Lb8DeD0CBUVbvPnx46C7Z91UV71CFhE=
Received: from MW4P222CA0012.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::17)
 by IA1PR12MB6089.namprd12.prod.outlook.com (2603:10b6:208:3ef::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Wed, 3 Jan
 2024 21:55:54 +0000
Received: from CO1PEPF000044F3.namprd05.prod.outlook.com
 (2603:10b6:303:114:cafe::31) by MW4P222CA0012.outlook.office365.com
 (2603:10b6:303:114::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25 via Frontend
 Transport; Wed, 3 Jan 2024 21:55:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F3.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.13 via Frontend Transport; Wed, 3 Jan 2024 21:55:54 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 3 Jan
 2024 15:55:52 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdgpu/gmc10: re-enable AGP
Date: Wed, 3 Jan 2024 16:55:35 -0500
Message-ID: <20240103215536.1780386-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240103215536.1780386-1-alexander.deucher@amd.com>
References: <20240103215536.1780386-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|IA1PR12MB6089:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cc17aed-7fa2-4583-03de-08dc0ca6c269
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7sDs1FSoWnIe2E2w/1Mjkk72tgHIQIdCUwt9cga/tSFwwjeOpDwHlpw5KPiH8jOjqgHn/8fRIiuf8VZzTA6UvPyWmq/RIR63Diui9xRk/YrOV4K/bj0fU3x6rNZ9NvZIiWjc+BwNn6z6yAdMaLf0TYInv2nscngeWtQ4NWwtaehZIYjFOn16BU5q4CAZ9d6QQZczAHfX68AFeBLIUI+oE+1utbid4GEPX2q/oVQZkadpEiSsJxz4+EcKsneLZSISLnJOZzVGd/THGzNB9IsghaKnF22N9zEp45qo72vjlUeSYWEAZkF2JuHEdm0GomC2SE4iqgAeoNYqbjVWkaaLSZXbbcBRDvGmp/h7gEO4fPx2J7eVN95xe6VJi1+/W5/ddDYvaTH0CGQc7bjjLBEjECCPWy7CWzrB8+ZVwnt09o2J+i7L5DccQZckfEgA+aKPz9vxDfb6V2YL3Tr0QiudMH/5n7LSxFb5A57eupPF9XLcWlBy1xMWq+RjdFmpUuXiTV78Xu6bi1P6hXamW5e4vGsnB9yJ8tMmDH7IQHumjxvqwItLmNiLgAeK2XIO1JVYTsCw1gEKDDQ23Rq+rn+U+QPj98xSa/rCQUnZWsOuujEyUCfSQEgwEeemdyznAGRx/+ThlDVIQqg5Hvd2bmWArhmXqpjXeQC3i3quUwtKk2XKZAlpcyvL7LLt6MuTkm+8Q5kGJa7ymPKHj26i0qKQlEp3mZjh+7sEg/XRWZEOME6IU1jLqWhGUXNUB9FMg/E7yPGmqoQTO2h5ZojXNIgXBA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(346002)(136003)(376002)(230922051799003)(1800799012)(82310400011)(186009)(64100799003)(451199024)(40470700004)(36840700001)(46966006)(336012)(426003)(1076003)(26005)(2616005)(16526019)(7696005)(6666004)(36860700001)(47076005)(5660300002)(4744005)(4326008)(8936002)(41300700001)(2906002)(83380400001)(478600001)(6916009)(316002)(70586007)(8676002)(70206006)(356005)(86362001)(81166007)(82740400003)(36756003)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 21:55:54.3815 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cc17aed-7fa2-4583-03de-08dc0ca6c269
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6089
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

It should be fixed with
commit ca0b006939f9 ("drm/amdgpu: fix AGP addressing when GART is not at 0")
so re-enable it.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index db89d13bd80d..bb04cb8c80f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -676,7 +676,7 @@ static void gmc_v10_0_vram_gtt_location(struct amdgpu_device *adev,
 	amdgpu_gmc_set_agp_default(adev, mc);
 	amdgpu_gmc_vram_location(adev, &adev->gmc, base);
 	amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_BEST_FIT);
-	if (!amdgpu_sriov_vf(adev) && (amdgpu_agp == 1))
+	if (!amdgpu_sriov_vf(adev) && (amdgpu_agp != 0))
 		amdgpu_gmc_agp_location(adev, mc);
 
 	/* base offset of vram pages */
-- 
2.42.0

