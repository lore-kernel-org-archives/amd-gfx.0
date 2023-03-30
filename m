Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6234BC77B60
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 19:43:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00CB010EFEE;
	Thu, 30 Mar 2023 19:43:00 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2046.outbound.protection.outlook.com [40.107.101.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2278710EFEE
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 19:42:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VLcRi8IhU6mkre/G1MgE3WoBgURYvdzVyvqvw57cHM723SUG1fAEz075Ot0PxQjkO0mtL1qyUbAL5cKesdTQn+HNz4WE/x6/873KDJ2i67yTTLyL0RqD61Sezo77NVOL4XRuctSfQ9jc17H8Y9HmvhOQYi7wjI2tPJYm/UxjjtWaR5whM4MItiMVdEBbcX7aCMY4256d6XjXC23uQueUG4y+Zke8xowztwsuejGxEtqFQixlqcS138ISIT9kkelHt7MrTQKbCt5D4WzWl2Sjygc5fUB065pgh8tLQd8j9roxMMKsk85XA13tFz2E6QWMJAJvI8IOEc19URKfsztt4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E6POq9sZzU3TIi0TrUpq8DN26w+d1eFH6g3LR4/R4+Y=;
 b=PPQArqUfpX/MtouP/FS1oLecvztqOA1zHrFWuuyTFnfubJhuuPU1C7bnOhQA95EbhdfqjW/bTsqKkGIJSOR6+n1wYVoG8UyW6HJQxGktikejOZz0jn6loz63V7QG3qyqCf/37LlKHc2QFr/2nvsiM5KnXvfUbEy6LI1yvNRgOGVO7EZIOcOfdu2Qe3+DqubvWVzbhA6Bsz19P47YA7jQwLIGjLEuOyQZQ44oFKnEpxB4KO3qtm1yjKstmq5pZtVvBe4gd4dPYJpUujUQqiHOn69V2+xXmMgntKHDV543e+DllJARcg1vellGWzXgmbb9D5bOQz+4GDub7d/3z36YXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E6POq9sZzU3TIi0TrUpq8DN26w+d1eFH6g3LR4/R4+Y=;
 b=xSWsAyqcSiWdA7lTbmpvGCxl68hskCoIvJhARx6um2MIICbDM3p49ZjGEcsw1+akVlN1IJ07fpE1VGWq+cXiKRXK6vkThCYdIEGi/UNUUOt3EAGOWLEwqMD8UtGBDR9SKCapJhrKRSdEr0Bl23mw08TixSwCBgUg5n96HIpjYeg=
Received: from DM6PR03CA0079.namprd03.prod.outlook.com (2603:10b6:5:333::12)
 by SA0PR12MB7464.namprd12.prod.outlook.com (2603:10b6:806:24b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Thu, 30 Mar
 2023 19:42:54 +0000
Received: from DS1PEPF0000E63C.namprd02.prod.outlook.com
 (2603:10b6:5:333:cafe::a1) by DM6PR03CA0079.outlook.office365.com
 (2603:10b6:5:333::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Thu, 30 Mar 2023 19:42:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E63C.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Thu, 30 Mar 2023 19:42:54 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 14:42:52 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/23] drm/amdgpu: Remove unnecessary return value check
Date: Thu, 30 Mar 2023 15:42:22 -0400
Message-ID: <20230330194234.1135527-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330194234.1135527-1-alexander.deucher@amd.com>
References: <20230330194234.1135527-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E63C:EE_|SA0PR12MB7464:EE_
X-MS-Office365-Filtering-Correlation-Id: 48a37977-adc9-4059-d335-08db3156f4af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hiBPFtiLC/poa8u1v5O71LFBB9x5CuSGX8h5nIuWygjdDHAumuxZ/V143AEs29W/rgP1Vao0OSgIDVNjkOzQDgtonCE9X6eGZJ1fUu+kVYcdzNmWSUHHNXTtwoD2aZr05e0on9D2lIPVW/H0gNzAe5PphHb3aE4qLVuUvH9Wj2GdQsgYLsE9t05FpxOQOBeew6teo1i1Ln4iHMPR0wSiRZH4HwSuAUpXQnwNzdCIrDmH07abY0zeqWGK8SCZJ8anaz28ojjEa2vJU3V1gBhf/WrjB/kVf8SIrU3v36+hXVidoW3lIOfHVSl5RI6hb7cSQ+v6mfmsp6I63gPkSkjVkFIq1+M1UPLsf4LQ3NP0nKpCr1r2VKHeMw9XC5DbEjJFs5A3OL1RkF/Brbx2ORibzP4yKthYVQUTvfD/QJDhv83HPXZygWRz/L4IKcZwNcScgLPCe5Vs4FOZhkH0X3b8Z5nNhKvH4Hh3bNHDWPS3nQD1ai37sT1jb74pMVFTfD0zJaDmZ36OCrvZvZzrOyBJ/B2jz2UiPG/uAZsvKNapjdVg7NZzYSjpvhRRepAtknm4fxo5l6QDnxbec1L6kNL9zrRZA1cCXBzcJ6ZzDVcCmhtp059pfn7fXQO/WjINby1BBVtoxlQo8PlfnUUgPlrBJWPjlAssn2OMTJPknlG5niHMibIVq2lL3n4ApoYimYiGV7a+wQ+OKjx6MvL3zY7WhF3/ZW0qAoNWoKC6M/ij69w=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(47076005)(426003)(36756003)(70586007)(356005)(81166007)(4326008)(8936002)(82310400005)(70206006)(336012)(5660300002)(86362001)(41300700001)(82740400003)(40480700001)(6916009)(8676002)(83380400001)(2616005)(36860700001)(54906003)(478600001)(1076003)(26005)(40460700003)(2906002)(6666004)(316002)(7696005)(186003)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:42:54.4387 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48a37977-adc9-4059-d335-08db3156f4af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E63C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7464
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

There is no need to check return value, as the function internally
used - amdgpu_discovery_read_binary_from_vram() - returns void.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 2d31e6592587..7b176b178b06 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -201,14 +201,13 @@ static int hw_id_map[MAX_HWIP] = {
 	[PCIE_HWIP]	= PCIE_HWID,
 };
 
-static int amdgpu_discovery_read_binary_from_vram(struct amdgpu_device *adev, uint8_t *binary)
+static void amdgpu_discovery_read_binary_from_vram(struct amdgpu_device *adev, uint8_t *binary)
 {
 	uint64_t vram_size = (uint64_t)RREG32(mmRCC_CONFIG_MEMSIZE) << 20;
 	uint64_t pos = vram_size - DISCOVERY_TMR_OFFSET;
 
 	amdgpu_device_vram_access(adev, pos, (uint32_t *)binary,
 				  adev->mman.discovery_tmr_size, false);
-	return 0;
 }
 
 static int amdgpu_discovery_read_binary_from_file(struct amdgpu_device *adev, uint8_t *binary)
@@ -302,12 +301,7 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 	if (!adev->mman.discovery_bin)
 		return -ENOMEM;
 
-	r = amdgpu_discovery_read_binary_from_vram(adev, adev->mman.discovery_bin);
-	if (r) {
-		dev_err(adev->dev, "failed to read ip discovery binary from vram\n");
-		r = -EINVAL;
-		goto out;
-	}
+	amdgpu_discovery_read_binary_from_vram(adev, adev->mman.discovery_bin);
 
 	if (!amdgpu_discovery_verify_binary_signature(adev->mman.discovery_bin) || amdgpu_discovery == 2) {
 		/* ignore the discovery binary from vram if discovery=2 in kernel module parameter */
-- 
2.39.2

