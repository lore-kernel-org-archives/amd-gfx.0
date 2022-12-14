Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4DCBC4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Dec 2022 22:17:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BA5810E037;
	Wed, 14 Dec 2022 22:17:18 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39D6710E037
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Dec 2022 22:17:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q6Y1zrc8cMILfb3nnz70pB3H0PG6G3fsdn1SpPAsqIimHLCmw3Mppjb7fbOABhK91xjejEwRkOxzDTLL2jREJbEuqlg7dKS9KHjg130dRZDmswROBnRDyzG9ghaSSDuocxrKSYjZRa7vPAc9zzi+F5oSCq9qMMXkud5GEskdDJsWrXZhRlEYVhGidn1GBxdJmzjNnDMcfRxdy+RCCObELOomixQGIg8Syv3H2u0RNwNaigne5J93/gLpG0bc+qi6l5E7IBbGD92614ovKCPEJZW9WqBq/zAOL3UTKztpUjbHrnh/f4XxYiegqEPRkN/eiF+UWJ3ZmuM0YlIlQseRGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SzNbnk6yBRWUJ2z0AVrC2eKbfKV1jixBU6lQoAQhoQQ=;
 b=RsnAvMDmifjPYMwK77NgnR2aYHy1+r1XIYHgN+7NRVOjMaYHVSFoNI/q2tnQeLkx8qPSiWcqIQ7+QoIuIktpl2CO1IllbJVnI+4d7utJr3wFCtuPKE90JV4PBmmPjJQpUNqu/wiZ2Cfkw3821/StrzfwwstJsXD3LkeK45M28Wz4IXEET3QZKcpTBzYTjo2oXASIDmhm6uMh9R/chtU39XH95UUCrAQRWVWv44H5M2gXr57/8wGKhJeTAfCqhr/IofcjQDEJA9l6AwsbauvgDofztOF/VMpTK691hFnzkI2kVV6LXf9t4Qn3asRV+HTN78VYLpFQm03QqSXhezU51w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SzNbnk6yBRWUJ2z0AVrC2eKbfKV1jixBU6lQoAQhoQQ=;
 b=FgkGFm8MznJIUgNaPAfwVLfzM+xr+FvaUYQMCRND/1g7kcYVxRvNXHjApU+R0jl1/wFc56upA4FOI19Gfx/N9JCjQaBkkhBc1euaYScikUUvjV/hfbt8wODmlyxOnFmclQYcWzK2B7QRubZmRDqM7c2r8/6KVn5nybrSYhQ/b/Q=
Received: from DS7PR03CA0307.namprd03.prod.outlook.com (2603:10b6:8:2b::13) by
 DM6PR12MB4265.namprd12.prod.outlook.com (2603:10b6:5:211::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5924.11; Wed, 14 Dec 2022 22:17:13 +0000
Received: from DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::85) by DS7PR03CA0307.outlook.office365.com
 (2603:10b6:8:2b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11 via Frontend
 Transport; Wed, 14 Dec 2022 22:17:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT031.mail.protection.outlook.com (10.13.172.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5924.11 via Frontend Transport; Wed, 14 Dec 2022 22:17:13 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 14 Dec
 2022 16:17:11 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/7] drm/amdgpu: don't mess with SDMA clock or powergating in
 S0ix
Date: Wed, 14 Dec 2022 17:16:51 -0500
Message-ID: <20221214221654.1625194-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221214221654.1625194-1-alexander.deucher@amd.com>
References: <20221214221654.1625194-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT031:EE_|DM6PR12MB4265:EE_
X-MS-Office365-Filtering-Correlation-Id: efa7d063-5862-46cd-c203-08dade20f38d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iZXR850YQLw2CEPBmqOmxpMMwmFsmGXxp/7Ih9JVIL02l+wiGc1THXRPdy4ulQQuCtAkmhQZPYQNivvCLKK5T3VKVo7GIDHZ02joR+0WZbyEiey4/XXRLGQDyfANDJHobzeI1RLSufDkS6v3HykCphoVTGhAbLiDIC3l9iWV8AVJDYpgobMwMmsKjoFkB2MwNZEl2wRYiu9x1Me2gKdH3OsUk/ucTBaTLObNSuLi9V1US0y15AZwfC0PPWAyc8m8PnfGFppZ/fhVlVzqAgZl29geDhtYcovU935sgBOFJ31UsDEOsxI9D7qfDl+cydlG2WG/g5LhVCgcfHWxMjn1kyIQ3Kcbmar2WY/bb3eGPXejUbmA6QaWxnelWnCiyASQuYo4W4oQbkNdwgicn8uMlqIPQP0ZluE60GyXUfBjE1V52P9u2uH+Eh/WfvFPdwusq8wBbfbSyunz9ZQXAL6O3fyU+rbWe54IyzCDivIc+zeco62wkt7HeDLN0Ybz9LAbPfHAqi48x1LhmZwK3Oe1XxyhGrpjm5JNXU621NjISywU01oEbOgNUs+GE+TJc2tWYmTHJ3uGLDu6OTHzVTfDh0nxGBnXRHV9hGfpSwcTev7LP8MCOg1sYxSWfuEsrjMKGi/cuUDDs8AHj9z4g5cXKw/QBCEiFiw8c1ZzlEXhMTBwVG/xco3tuVpqGydpjuPZ6lbp/kOWXuGKJse9X9RdUypvMPmrRHrLJdAityHAyCnFwkpP9C7Ufhy8ls6J+fifWVtbm7VjlUP/DRFT5dTf5A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:CA; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(346002)(376002)(136003)(396003)(451199015)(36840700001)(46966006)(40470700004)(83380400001)(336012)(2616005)(86362001)(47076005)(81166007)(82740400003)(8936002)(36860700001)(356005)(426003)(41300700001)(1076003)(5660300002)(40460700003)(40480700001)(26005)(82310400005)(16526019)(478600001)(6666004)(7696005)(4326008)(70586007)(70206006)(8676002)(186003)(6916009)(316002)(2906002)(36756003)(32563001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 22:17:13.2038 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efa7d063-5862-46cd-c203-08dade20f38d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4265
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

It's handled by GFXOFF for SDMA 5.x and SMU saves the state on
SDMA 4.x.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 64660a41d53c..a99b327d5f09 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2581,9 +2581,10 @@ int amdgpu_device_set_cg_state(struct amdgpu_device *adev,
 		i = state == AMD_CG_STATE_GATE ? j : adev->num_ip_blocks - j - 1;
 		if (!adev->ip_blocks[i].status.late_initialized)
 			continue;
-		/* skip CG for GFX on S0ix */
+		/* skip CG for GFX, SDMA on S0ix */
 		if (adev->in_s0ix &&
-		    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GFX)
+		    (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GFX ||
+		     adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SDMA))
 			continue;
 		/* skip CG for VCE/UVD, it's handled specially */
 		if (adev->ip_blocks[i].version->type != AMD_IP_BLOCK_TYPE_UVD &&
@@ -2617,9 +2618,10 @@ int amdgpu_device_set_pg_state(struct amdgpu_device *adev,
 		i = state == AMD_PG_STATE_GATE ? j : adev->num_ip_blocks - j - 1;
 		if (!adev->ip_blocks[i].status.late_initialized)
 			continue;
-		/* skip PG for GFX on S0ix */
+		/* skip PG for GFX, SDMA on S0ix */
 		if (adev->in_s0ix &&
-		    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GFX)
+		    (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GFX ||
+		     adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SDMA))
 			continue;
 		/* skip CG for VCE/UVD, it's handled specially */
 		if (adev->ip_blocks[i].version->type != AMD_IP_BLOCK_TYPE_UVD &&
-- 
2.38.1

