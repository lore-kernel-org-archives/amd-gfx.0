Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2178C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 12 May 2022 03:23:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC10210F122;
	Thu, 12 May 2022 03:23:11 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5394310EFCC
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 May 2022 03:23:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VUfDetT0WX3xla9y48v/tkFKVlSp9r2BscZwIwSHE1QZao1AYgcQfIBC8OFT+5UBNcDIBwzFT3WGnZPAk1yffdwIyItrXmKhlUj935VNs8gu3nVsFz6sMw4FXh4B3HWvAR2z0yrTka5ac4FVc8DgoGF9si827rmtoikwpCXUuYJwwLnBjgq7p3QE0kVKoZtna9xLMZUc3x0r9fg9xq5WDy+gHqFzJp4EAkyKD9/LYEwN6zDwOY7jkpTqFi9TaBtoLv0WU/dZkcrfDcov+yQsnkLkwC+beVfL2rxg/KcwmEJH3TFLL85UrwY9ilIyreNWjjYG6k1oFo2U/+X378wdVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wd4iLIHk952JQ/wuZSmDUU5Mdp9NF51rBXSca+Q9Bt8=;
 b=R7pFPysvYURt5lUq/FPKO7ykO9EaLUTg9Alzqo+GkbdyHSNNjE3+pHm+fL53jkk6rPkCjoYmnbRf3aUhy9SmzX7YqgUSTCNzod8tXfmX28OdKa76QC+GZP181MYm/4rmKuG+cJKDR1pByMDu/xkmVzfD16VqjjcYeiMgjQs5ZOTpBxOz72ZR3X7r1oztAhWtjAL7uTxBNhGgSCXHwzsRSYxgF66B3whmGNxKJRJ/X0NqfWnjDoN0+4POJmm0ttpifCjO2GzoSBVFn/jBMvH+slqopCQUqgr7V7CsmCLFC7WJpVA+GDTYzn2ohWHU4Dc+nkEaaOMUXj1hgE2ptrd0zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wd4iLIHk952JQ/wuZSmDUU5Mdp9NF51rBXSca+Q9Bt8=;
 b=eInsJU0VqjUOiqLASpMaMJNzCN4RSaQhgurYLnPA4bfZqE+1C/lARmNlBtJOzi+6hVHuW7LTWePGanM8Hv+eNslrKYx8nOPeYG7DNadlJZwdROPu5OHvBAb8v3BzK5kqWuz8T5w/CdNYKmb0/S7iniMRGXoGOw215oxIPj6A8Ak=
Received: from DM6PR11CA0067.namprd11.prod.outlook.com (2603:10b6:5:14c::44)
 by DM5PR12MB1529.namprd12.prod.outlook.com (2603:10b6:4:3::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.22; Thu, 12 May 2022 03:23:08 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::4b) by DM6PR11CA0067.outlook.office365.com
 (2603:10b6:5:14c::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23 via Frontend
 Transport; Thu, 12 May 2022 03:23:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Thu, 12 May 2022 03:23:08 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 11 May
 2022 22:23:06 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 8/8] drm/amdgpu/soc21: add mode2 asic reset for SMU IP v13.0.4
Date: Wed, 11 May 2022 23:22:47 -0400
Message-ID: <20220512032247.528556-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220512032247.528556-1-alexander.deucher@amd.com>
References: <20220512032247.528556-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d41e600f-1e50-49ae-a3eb-08da33c6bc74
X-MS-TrafficTypeDiagnostic: DM5PR12MB1529:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1529852046EDA5747D617E05F7CB9@DM5PR12MB1529.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K4E84AKtJtWztERNsmLd5YFOC7nIB8ZIH8JQJs4OBtx/SJ1VrXQpF7NpduRnZy05E61xVqtVkPgm+XZ9D+0XZL321BWSVTGXvq/R5wOSnjtS4SgNSkL2as5Dk4YZ1bVoSizKg6aJ+nc0RU86HEvG6340qkN9ZH8A8dobFyz99BDzllo5OSxElEA0fGmSaTnMlvDRwsjPCGv1AICgQQRBWB4Dhs771p1NDXa6nx3RKnYPwCzGAaJobA3DngvhUF5c7jxOWMj5T16a13W7Ou5aXZyfzc5Bc2xnbEGlqiNyGvJg8lEPXq2OICQFElqElnyB8TJ/I+LkH4H1SfK8McNIvdQJFPvMoadW0qzE+BrPUH5wUXkg2vcQ8qIGXsUjiokrbCgHAQHaf5Rakzgrta3qPUkShBeP3aN0zeLRdJEn3y8WM/Ja6/94ec+gSAzKA6Rr3b6Ranvx9sZhM6tcNHfhvx0x8wGvRO7zcrfF3JAt7iUVib3brmT3G4zHtx9D+e1PAvFcB82+4UMeQ2PkX+cZ+CqCtS5MKHp44eyf8zLJwZB/UACyW4ejMzJuKSO0E+2h02tk6l3qGE5V4Pf8u4BaUoAjbPdAOJT04U/7wmreZFgUI1QVT7mwHLMJgJxBRllliAwsVhh9HsHluIwhoBv1eRx4ne0NJq2dx71natdHzN93ErPGSjnYrFH2nkPFabfy+/i5MyR3MjBUthK50xQSvw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(2616005)(5660300002)(426003)(336012)(1076003)(6916009)(16526019)(316002)(8676002)(70206006)(4326008)(2906002)(186003)(86362001)(70586007)(36756003)(8936002)(26005)(7696005)(40460700003)(508600001)(356005)(6666004)(81166007)(82310400005)(36860700001)(54906003)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 03:23:08.3710 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d41e600f-1e50-49ae-a3eb-08da33c6bc74
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1529
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tim Huang <tim.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Set the default reset method to mode2 for SMU IP v13.0.4

Signed-off-by: Tim Huang <tim.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index c6a8520053bb..a4e23a7b3d63 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -309,6 +309,7 @@ static enum amd_reset_method
 soc21_asic_reset_method(struct amdgpu_device *adev)
 {
 	if (amdgpu_reset_method == AMD_RESET_METHOD_MODE1 ||
+	    amdgpu_reset_method == AMD_RESET_METHOD_MODE2 ||
 	    amdgpu_reset_method == AMD_RESET_METHOD_BACO)
 		return amdgpu_reset_method;
 
@@ -319,6 +320,8 @@ soc21_asic_reset_method(struct amdgpu_device *adev)
 	switch (adev->ip_versions[MP1_HWIP][0]) {
 	case IP_VERSION(13, 0, 0):
 		return AMD_RESET_METHOD_MODE1;
+	case IP_VERSION(13, 0, 4):
+		return AMD_RESET_METHOD_MODE2;
 	default:
 		if (amdgpu_dpm_is_baco_supported(adev))
 			return AMD_RESET_METHOD_BACO;
@@ -340,6 +343,10 @@ static int soc21_asic_reset(struct amdgpu_device *adev)
 		dev_info(adev->dev, "BACO reset\n");
 		ret = amdgpu_dpm_baco_reset(adev);
 		break;
+	case AMD_RESET_METHOD_MODE2:
+		dev_info(adev->dev, "MODE2 reset\n");
+		ret = amdgpu_dpm_mode2_reset(adev);
+		break;
 	default:
 		dev_info(adev->dev, "MODE1 reset\n");
 		ret = amdgpu_device_mode1_reset(adev);
-- 
2.35.3

