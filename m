Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDEABC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Dec 2021 19:43:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EE2F10EDB3;
	Thu, 16 Dec 2021 19:43:02 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C97710EDB3
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Dec 2021 19:43:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WCztcix5u2cr5eMnjdiKvCY3OZVyFKG1oIzlPlZwMpoWNagaW6s5KYf6HlGYMreK9Wgrg41l67ygpBrVdZ6/1648RtXBKl24SMy13b7z9/rCDoyt0+7aju3nj/RA67T0Y8BiaLytp4cFgVH/Gl3W+IUWxWoja0dziBqI5yDqowIInvH8Q1tpxo/J5hsCx2G2DWbkytgH8Lp4Q++xKF7dwjebT3fmTWwMHgbb1SE4G+DpnB57ntY9NaXZn508ewgPpU//p3A3jkLUklzwyEs5nsg2GuGT+j+LA9jH6yAVObHLARO2Ox9JKzpU8yTt9TJOxe94CADTi1pA9oiAqpNCNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ca6mpex4asvrHxLoqa1a7EIkiItILWKFMHtY4BbES0=;
 b=C1ERVoDqlzXT/YyOerju3SeICKI9w8tFDCSEIOtZOSmwkKGSIsQ7G75nivt40iXEACLFJTaP4FL56xYsgxNX3EEy6zX8II8Hiimo3r2wqRjQp02Okm5HLtRKEga16Hw1Lrq+p2B3HLqPMooTnsa7CIUb1Jg150lECKYtuU9LaK9sABMLb1ogCezxP9Ao/lblPjJMyxD3Ed8YKaNx8ouKDZBC4IyheZhxKCbR0r7dFVMd3ndNMa5etMarFoaHp+MXlNhW7CKrtSOMxGCfFw1hx0K2Y4w4ZaEL2eJeWY2OIvSBNufXJ8I4WncGlXISYCXTH+si5s/myEg8WYb6HF6uYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ca6mpex4asvrHxLoqa1a7EIkiItILWKFMHtY4BbES0=;
 b=5NImkbpl0nF4Rmbmp5YTEg/bC8Xb3+QVr8FE3qJoi7XMbpPpOhZjjAF9szDAV9/Xrw3rg/C6BgPwyIK5Y7HaxCd9e7RqUOPZCFfCXxJhugdhaMlI1VQi6wov2VBgwGp9zFQqVHPnQisMpXdscGhzQqF5LSbUz9wrjw5K3J4OojM=
Received: from DM5PR21CA0070.namprd21.prod.outlook.com (2603:10b6:3:129::32)
 by MW2PR12MB2569.namprd12.prod.outlook.com (2603:10b6:907:11::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Thu, 16 Dec
 2021 19:42:57 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:129:cafe::a6) by DM5PR21CA0070.outlook.office365.com
 (2603:10b6:3:129::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.8 via Frontend
 Transport; Thu, 16 Dec 2021 19:42:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Thu, 16 Dec 2021 19:42:57 +0000
Received: from sriov-scm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 16 Dec
 2021 13:42:55 -0600
From: Victor Skvortsov <victor.skvortsov@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Emily.Deng@amd.com>, <Monk.Liu@amd.com>, 
 <Davis.Ming@amd.com>, <Shaoyun.Liu@amd.com>, <PengJu.Zhou@amd.com>,
 <JingWen.Chen2@amd.com>, <Horace.Chen@amd.com>, <David.Nieto@amd.com>
Subject: [PATCH v3 4/5] drm/amdgpu: get xgmi info before ip_init
Date: Thu, 16 Dec 2021 19:42:32 +0000
Message-ID: <20211216194233.3839-5-victor.skvortsov@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211216194233.3839-1-victor.skvortsov@amd.com>
References: <20211216194233.3839-1-victor.skvortsov@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e36f0b16-88f7-4d24-24c1-08d9c0cc42d8
X-MS-TrafficTypeDiagnostic: MW2PR12MB2569:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB2569ACC254FF1F6E8EC8895E8B779@MW2PR12MB2569.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:792;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PEG5/jmscVaOBXfZTJspFhNZmVvPCTrlrf0e43YOfHCuuv3teoiKOtOmUAgZnX1J5Sqf9Bv+MegVAAcLTbDK5WPAj2j8fKGy7NFjqhSvmt7avImQat7CYdvXS/6RbHfVfVw/84RzCOh1bVqxzaASoSF+fWp/ZZWEaxsh9HRfAD9GbbAt7L6y/5IAisXLoF55DINyLQX/4ib8EaXxaAhU7FvD2c/ci1udnZWDDAl3UbGB6eyC7+LxaFrGcLPUnElBynZNX0UmDU+hYraTdjASh0xY0km4HOhpAAGu4jcd8RsvXu2LvwZv5qeDScQPA9XSenHMTYwAcIQDifo3vzhLKrRCaeI0zFftNk8427rCSSncblI119jTACz8O86RWSMg1o8yQegcL++MW505IchEWUFMsAvOSub96OCSITlOUxGjAIURTsQWHJAEzYzXUOn6sGbr3XcjuKVuETBxo/7IOU3i/ZriMfWJ72rRVEk2638rq7D1nAZsl2ls5YNQVb9hcYk7PPcyQYlFRm1sOfXdwoZt2eQqYfqjx9ehv+8EeFsaEfJVNj7t0Jay53NQmC6WZDvEwCSygnoiOyyp1lM4HnqLVRHoec1HEHS5e4mgTmZpOPU9Zf8gGkRNkJUJ/oA/h/jJmMwIF5GacDcPTwPO/k3n6fN4SPvOgR1EfALmWlthuoFd3u2uRTbYiGj9o7gFR+ZeIQ4Fq9pVGNWhv2xE2ns/vcr8v+UHQYUAkHvOw4ooRCDt6A3RcsOiUpyz84U9mAfyQ2WcSs766pmSgKDuhFSrtNCzTPbQR/rOyqFOEPY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(356005)(8936002)(7696005)(4326008)(6666004)(70586007)(336012)(36756003)(47076005)(26005)(44832011)(70206006)(81166007)(86362001)(110136005)(1076003)(83380400001)(8676002)(82310400004)(186003)(16526019)(426003)(36860700001)(508600001)(2616005)(2906002)(40460700001)(316002)(6636002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 19:42:57.5864 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e36f0b16-88f7-4d24-24c1-08d9c0cc42d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2569
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
Cc: Victor Skvortsov <victor.skvortsov@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Driver needs to call get_xgmi_info() before ip_init
to determine whether it needs to handle a pending hive reset.

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++++++
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c     | 6 ------
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 6 ------
 3 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5bd785cfc5ca..4fd370016834 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3576,6 +3576,13 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	if (r)
 		return r;
 
+	/* Need to get xgmi info early to decide the reset behavior*/
+	if (adev->gmc.xgmi.supported) {
+		r = adev->gfxhub.funcs->get_xgmi_info(adev);
+	if (r)
+			return r;
+	}
+
 	/* enable PCIE atomic ops */
 	if (amdgpu_sriov_vf(adev))
 		adev->have_atomics_support = ((struct amd_sriov_msg_pf2vf_info *)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index ae46eb35b3d7..3d5d47a799e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -914,12 +914,6 @@ static int gmc_v10_0_sw_init(void *handle)
 		return r;
 	}
 
-	if (adev->gmc.xgmi.supported) {
-		r = adev->gfxhub.funcs->get_xgmi_info(adev);
-		if (r)
-			return r;
-	}
-
 	r = gmc_v10_0_mc_init(adev);
 	if (r)
 		return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 2b86c63b032a..57f2729a7bd0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1628,12 +1628,6 @@ static int gmc_v9_0_sw_init(void *handle)
 	}
 	adev->need_swiotlb = drm_need_swiotlb(44);
 
-	if (adev->gmc.xgmi.supported) {
-		r = adev->gfxhub.funcs->get_xgmi_info(adev);
-		if (r)
-			return r;
-	}
-
 	r = gmc_v9_0_mc_init(adev);
 	if (r)
 		return r;
-- 
2.25.1

