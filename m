Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6571CDB474
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Oct 2023 02:40:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84B5610E359;
	Wed, 18 Oct 2023 02:40:21 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2078.outbound.protection.outlook.com [40.107.101.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF2B110E359
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Oct 2023 02:40:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iZxD3lPCA+Z3Y+EINmSyC1d45o6dRZaKVF+hQYeQntcKzwK3JVwNaMn2DBEOpuuoe1jeH5j2xU2RYk1AINOIZWocJIO+dSss3vISFVSO6/3YBD6buJVpsmstX+Gmnjf+/YwhO3ffEDFs+uNO4Xhb/8+JdkAd9+t8aIoSHzaXtFYdBwOXNbFoDOs08mWIGC9fWZ7+Mp6JiGi+JzBwhoJD+Te5Ohz3YIzF2GP3hGU5l+IL71n1relfJjSgR4b+9OMGr+NvZbg2nEDvtguwIRplIgliRWgUcMM6iEPU/ISK9VcmOWf15KilhTH59OBJtgjsS6DWS1XSLy0p42WBIBVdSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+fAzRZ6BorVBHOf8bCWydloTBAs02NP6Ex+zaatL2Y8=;
 b=I6tMWaWTzsz0z6rpatB6SJokEF0I4LvFiXfAIJNZYJz0zTNiRuOxQi6o/xRptZztsfFuZjt4YYqdsq/rYLFV122XI7d0zs5SrY+Nzl/tCin+aF3A3XdCHaZOiX9S3tWdl5hCFPqhCcjjZOz0tW6e1lYFfwiY26XK6kE9aBaZpymHwNI2Z555jHrZ01jXoP3QSguXwW91HkxLGfMJV0AvHFZfta7pRd3N/gq4pT744GV8+10vYK9/nbp6ja6VCM+YsBUIZadQCaflyrmyw0uOeo/aCkOANetvXZ19v0mnmGGDiICTlOYlw8btcf5wnm5LR+/cU6CaF6gFJ6i8tGXfWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+fAzRZ6BorVBHOf8bCWydloTBAs02NP6Ex+zaatL2Y8=;
 b=raP7sJF6VQHfg3vp650nyjXItoIDDc1501E0Vgb/6NhtkjTMEWBP1+NxQscVM2yrOgC1YJg/e45+1QkrvFq7xdyzHmwOQeu/tH2jgXM3mXLpJi6bcGi1CR90p3yBZ+p2QH+d/0eb2+HCZTELM9nCDTkoF/OQkioaTVepboYiCXI=
Received: from CH0PR03CA0057.namprd03.prod.outlook.com (2603:10b6:610:b3::32)
 by PH0PR12MB7077.namprd12.prod.outlook.com (2603:10b6:510:21d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Wed, 18 Oct
 2023 02:40:18 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:610:b3:cafe::b1) by CH0PR03CA0057.outlook.office365.com
 (2603:10b6:610:b3::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21 via Frontend
 Transport; Wed, 18 Oct 2023 02:40:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Wed, 18 Oct 2023 02:40:17 +0000
Received: from primary-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 17 Oct
 2023 21:40:14 -0500
From: Lin.Cao <lincao12@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu remove restriction of sriov max_pfn on Vega10
Date: Wed, 18 Oct 2023 10:39:27 +0800
Message-ID: <20231018023927.56093-1-lincao12@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|PH0PR12MB7077:EE_
X-MS-Office365-Filtering-Correlation-Id: fc9e4349-3ab5-40fd-3d5c-08dbcf83905d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rkmkxdP6Xoxttf7Mhwch/8GNJQ3mmnlVjJ+MgTDvK0NYhJVKz7zNV9PI9Vdq/oE0JD4jWE+z9jJ+1KLThqMReB0hroDhmO/9D4tD5ndWktOKI2ZVqy9mNfrnO5pQYnc/n37XMrlXyYD1UAlgCkK2/zLowChYndyjJ5ITyB3gE7hBuMIBHEg2cZyyZX7/33IxC9I3lIpgEB2aqg/C9BinuquXb+DIJAEy67f9eBvRx/E4b6IEVoxgdoBGP6FpJjf6LhmpyrUdwbj036QPRbnefVQmqGyN/cY1fpuGt5O5KCSKO34v5HRHWIhWA+l7KthjovmMd4eIwXul9iveo6a5DFwnOkhOORoOGsWmpQDB2TVzx+gIC7iKGmZ766ers0ePAzRU7n0R0zf0D8FXBqccaziHixx1rvDPOsD54VSNh3dQwODiOPFIazWNAQAb69rnPrBNCG+CCWTA7FJR6Qb+bz/oc2hu7svi4WDRj21frqtdG6hLxHHEa1nRU1jP9y9moOYw/Lbt93izOn+jA8r0bDhEPaUjDtgPi3xbIkIr/4M54BQkFTwVjov3j5VK5F/QrhvdHPZGLQwkXQPHwoYS0UB/YNuybbL27oKP5dODCt+j74EG5RelQBJOafi8mpubrwjuz/Gzq9bP8Gk/xNrgHxDdwjKBlvZq35P1HjnGy5x65nv+2aZYd3v10Bw5qgWH9pqEuC1CYxpaHoFJK3zbsGZkloM66FMq8VeX3hxZn0H1yp/XmzfhLhC532GU0UvLHz47FI6qtUhBNEpHfJclvw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(376002)(346002)(136003)(230922051799003)(451199024)(82310400011)(64100799003)(1800799009)(186009)(46966006)(36840700001)(40470700004)(336012)(26005)(2906002)(5660300002)(41300700001)(8936002)(8676002)(4326008)(6916009)(40460700003)(70206006)(70586007)(316002)(478600001)(6666004)(7696005)(54906003)(426003)(83380400001)(36756003)(16526019)(1076003)(40480700001)(82740400003)(2616005)(36860700001)(356005)(47076005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 02:40:17.1970 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc9e4349-3ab5-40fd-3d5c-08dbcf83905d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7077
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
Cc: zhenguo.yin@amd.com, horace.chen@amd.com, jingwen.chen2@amd.com,
 lincao12@amd.com, haijun.chang@amd.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 monk.liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove restriction of sriov max_pfn so that TBA and TMA can move to high
47 bits address.

Regression test: change range alloc flag of libdrm as
AMDGPU_VA_RANGE_HIGH and there is no flr occur when testing amdgpu_test
of drm.

Signed-off-by: Lin.Cao <lincao12@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 3a1050344b59..b1eb81ca64bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -2023,11 +2023,8 @@ static int gmc_v9_0_sw_init(void *handle)
 		 * vm size is 256TB (48bit), maximum size of Vega10,
 		 * block size 512 (9bit)
 		 */
-		/* sriov restrict max_pfn below AMDGPU_GMC_HOLE */
-		if (amdgpu_sriov_vf(adev))
-			amdgpu_vm_adjust_size(adev, 256 * 1024, 9, 3, 47);
-		else
-			amdgpu_vm_adjust_size(adev, 256 * 1024, 9, 3, 48);
+
+		amdgpu_vm_adjust_size(adev, 256 * 1024, 9, 3, 48);
 		if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 2))
 			adev->gmc.translate_further = adev->vm_manager.num_level > 1;
 		break;
-- 
2.25.1

