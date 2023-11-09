Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C052C4167D
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Nov 2023 20:51:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD4D710E917;
	Thu,  9 Nov 2023 20:51:49 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 293D510E912
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Nov 2023 20:51:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aDk8xPlvjaxEB7f3skDC69S2ISoCEHVUr3FHit1w/pcLjn8pDLUUHJTB6NR7rO4LErShChuuiA0FBvtmmMS7mVSaLtx6CybJKEvLHUHdQBzBNev9Y8Zph92e38d728UQbRkqF3fsHtWLYbm2Q2Ak/bZ0vKKny6ZpM0J2Bwpbhuk+NDUdVLHNpl+VviFn7MSU0wSBlIEiL1GfTDQzLnNbmd+WG1OPXSyRNFVNaivirZPh67HRJPpTDpS+L6ANLWUxm+uNyh7jr7dwCpe/EygAbFDMtZN0Jv0ALfrtgKbgansNiPUzOnIwldCPEDYTavWIHE9LfU4NorH12KUwZb3B+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LZ5nfa/MOB5QviojDpLKN5FnVsFthmhGSnEHs58MkxA=;
 b=nhxJatynS+4Bth6a4SZT1jcDJUfGwPTnHCYBa9ZaLCrIDDbaacf7tfVxdtN4jfJNI5uVRwq0ZJbFTgm/GWqPVVdIkIEqTBJLMk2Uj4kyi2mdyvle1++bPnPXkkGGoJmzuH3f/T8lYcCB2YvbjKzCQLiw8nEi4DkhJ3Ynd8mxok9WOlB1Rpy3oxgzKm3hAYdB3aoI4Htw0+k9dtHIKfJC41IqE8XMZ0Vh44gJEQlmA8qAmKTWPxcKgcteP8W6tnNu8UQaMOhXI+jv4Y1MLGvAMqQGnDzpuUB6lkYjgK31yepB4f+R7kH2kWRhsHjj+PnQJw9w+ADi1986QWEoqB3l1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LZ5nfa/MOB5QviojDpLKN5FnVsFthmhGSnEHs58MkxA=;
 b=piCYwxRcch07Z00k68wuh7zJvkSqwh1BqrLBpUi6WWhmZg1qqnVKwgLAlU0YE4TMaew9kPZN/2lh20qg5bcr8Vl7KW8mBfqdcEtQqi/YWPu/RM48/MZefxEVfuHAGRjFAIzst0MkuGilRFjl7q/L+lwAagxEQGR195yJHAQzzGo=
Received: from DM6PR02CA0084.namprd02.prod.outlook.com (2603:10b6:5:1f4::25)
 by DM8PR12MB5398.namprd12.prod.outlook.com (2603:10b6:8:3f::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.28; Thu, 9 Nov 2023 20:51:41 +0000
Received: from DS1PEPF0001709D.namprd05.prod.outlook.com
 (2603:10b6:5:1f4:cafe::6) by DM6PR02CA0084.outlook.office365.com
 (2603:10b6:5:1f4::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19 via Frontend
 Transport; Thu, 9 Nov 2023 20:51:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709D.mail.protection.outlook.com (10.167.18.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Thu, 9 Nov 2023 20:51:40 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 9 Nov
 2023 14:51:39 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/5] drm/amdgpu/gmc10: disable AGP aperture
Date: Thu, 9 Nov 2023 15:51:24 -0500
Message-ID: <20231109205125.513643-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231109205125.513643-1-alexander.deucher@amd.com>
References: <20231109205125.513643-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709D:EE_|DM8PR12MB5398:EE_
X-MS-Office365-Filtering-Correlation-Id: 103d3e50-d1dc-4dc5-e3af-08dbe165aca4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8lAw4Fkkdm3tiP1EqVIh4D2AcNftL+2rZvRX/wUdQVxEDoCC4hjftdGXrPKc08AOjyIpLkuL3SwEB9Ia3qnsFeP2DV3xDmaC+6nvaACLJwn/1gqet9fhDi8WZ3Gm0nuRrAQwaqGrStg+Bie7gU0PV5z8CJfR9F5AXntFwOGNPqi7PpkCiEVqClc4QMCc3/bFeWKZKvSmZJQXcP1s9IDclgHG8oAKdxVccjNv7hbCkHKygfsizl2+5tMdnBBZ1Fzusl1qmjzxyfZfFdsDg/2qfM5YzvWD0FatZsR6VpKEnnRzUYOrJw5/6qK4Q+VPMCTcXDvMImXpgVCs84v5orEcqA4bfVLCE0BtoHHDse/xS1omHk6/hwyPe73VlbQCRZFyik2xUfLkLjE2PFBcycpF0qF56m8IyUrjaX0TSVsSDs+/8Wf/UjIK4n8cHABiJm3Lvbl+cuFzkHtaoUtO9CxG/tztg2aZ2A7cDnrgs6umpCcXI+X+sKEQfTCGA2spDoSU+havpfyRq0Y3DQAinQXpdNuJatQRe/nrQSUjAU3uSQNrxWwseXZjAzumdp2aN4U0izj0cKzao7PEXSxPZSxrKAduN25Mp+LK8c7VlDeavml7+Ax9E2xNRtp1+4DWrP/JMHB8O0EdyVuuifxkaFJzvMZTtPP0i4cmvyaL7/oeolrHwWj5SrhVYrEqBN68Am3Ez89ixbm4wwufcRDfpqofgTMak05eoFnUKUNJ9HpsxnyRDg9LBYBZp8LCEt8dUbztgYYB2l2vkC0of6NTuaaFqw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(39860400002)(376002)(136003)(230922051799003)(82310400011)(64100799003)(1800799009)(451199024)(186009)(46966006)(36840700001)(40470700004)(1076003)(16526019)(26005)(2616005)(47076005)(40480700001)(83380400001)(336012)(426003)(6666004)(478600001)(36860700001)(40460700003)(7696005)(316002)(81166007)(70206006)(6916009)(2906002)(356005)(70586007)(82740400003)(54906003)(5660300002)(86362001)(4326008)(41300700001)(8936002)(8676002)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 20:51:40.6397 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 103d3e50-d1dc-4dc5-e3af-08dbe165aca4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5398
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Yang Wang <kevinyang.wang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We've had misc reports of random IOMMU page faults when
this is used.  It's just a rarely used optimization anyway, so
let's just disable it.  It can still be toggled via the
module parameter for testing.

v2: leave it configurable via module parameter

Reviewed-by: Yang Wang <kevinyang.wang@amd.com> (v1)
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 23483bffa1c7..a5a05c16c10d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -675,7 +675,7 @@ static void gmc_v10_0_vram_gtt_location(struct amdgpu_device *adev,
 	amdgpu_gmc_set_agp_default(adev, mc);
 	amdgpu_gmc_vram_location(adev, &adev->gmc, base);
 	amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_BEST_FIT);
-	if (!amdgpu_sriov_vf(adev) && (amdgpu_agp != 0))
+	if (!amdgpu_sriov_vf(adev) && (amdgpu_agp == 1))
 		amdgpu_gmc_agp_location(adev, mc);
 
 	/* base offset of vram pages */
-- 
2.41.0

