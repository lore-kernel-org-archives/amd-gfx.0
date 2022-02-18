Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D50A9C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Feb 2022 22:26:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 007C510EDDA;
	Fri, 18 Feb 2022 22:26:21 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A65610EDD7
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Feb 2022 22:26:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IvmuMCEJBhFvOUzZGKHDU5mov1EuBY7APiSNkoBkiQMKiLMmrLCYxfmG92UkZ0TYpOZeJ3IcHZwWvNMMFYtKnbflsxN3y1tRtmgn33my9WYt+7jeT6W+aWAwtJWNO6WIy0I5mMyfzhgYPhWzqjZ4Goijj1PyC6Dd0k/uoPf66gwtibL2etOYknQJN4sp5DBq8NCUpEqo83IymMIBLk8w41q/yUmw9ItsenkcPeKbqYXheQvx+xPKeihNWHxH26OgdIv6bfO6/bY8h7aO2G5m/fW8MtwxmkoOtn0MwqneaaaR6gfstVwAcpqfpYUmyTftMData7EskpZ10ytN7nSNmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rgPWVIltspsodgss+y/nxZO54axhUeQjcdnCx6zo6I4=;
 b=L+WZszINKB5t36EnIA9wT8kh/T6lh/vQ+tvjCXEUPtkFhIQIOzvXDuY7HrkEAnWs4WqC7xaU6hkdDFZ/PIgh/J/sb2Nu2oCHNeXSelkzu+Tncyx81euxqAURCnOt9n2grw54t/9LBnPbXtEXgxBSfgu0r1A670xQbM6jNjRb68sf8ogLshbbam4E6ce1zXdp1jS8bm9LdeuV0aIOyv1Sq9kuavUrp4L9ok9UWBvyI5tS4dXS7rc1L/qR298HVKkFuPTNJzWYqCq4MfHc812muoJwc5J74VnbO19kI8agFKWE2iQvX96KTu0nqYBGf5qn6qlZHkO0XmU3qP/75+lYVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rgPWVIltspsodgss+y/nxZO54axhUeQjcdnCx6zo6I4=;
 b=k3CP+OHap3hzpne8TeX1/ND4vULTWRYJjkyl4bjlvPX5jnReaOWmyuIGfB8ODt5Oqm/s4FLv2zUHiEeZ4JZSJF0LjO0GVyficz6vOynnbsl/0aUkTNCHI+WkeN/DKPVroSyn5TKYRRjptmSm7EQif1CsJavSPSVnbuNrtSdTTss=
Received: from MWHPR20CA0012.namprd20.prod.outlook.com (2603:10b6:300:13d::22)
 by BL1PR12MB5730.namprd12.prod.outlook.com (2603:10b6:208:385::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Fri, 18 Feb
 2022 22:26:16 +0000
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:13d:cafe::72) by MWHPR20CA0012.outlook.office365.com
 (2603:10b6:300:13d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.17 via Frontend
 Transport; Fri, 18 Feb 2022 22:26:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT036.mail.protection.outlook.com (10.13.174.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Fri, 18 Feb 2022 22:26:15 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 18 Feb
 2022 16:26:14 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/7] drm/amdgpu/benchmark: use dev_info rather than DRM macros
 for logging
Date: Fri, 18 Feb 2022 17:25:57 -0500
Message-ID: <20220218222603.25470-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80badb61-bfb1-4a56-9a01-08d9f32dad27
X-MS-TrafficTypeDiagnostic: BL1PR12MB5730:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB57300DF4011282B3CC5679DBF7379@BL1PR12MB5730.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:510;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JkSs/tK4/goxKcL8Ejj56uGChygLU1j9aTwKaJrrjRoSL4R/jY59O2qh0oturjrCqypRvPTf17VqlW72GXJ3FnwAv8ZDThfx9c0yGVEKvU/1EyFs74+0wGvkcMzzHsYs6LHG0aOgVEDWlOplmclaczAf6QVJ7N2xnw1F3vwPkZjyKyep3dbBJLvTAf5FLiK0TFI5/hbq5awKEnU+U8rWHHFF4IwF9iDRgHp2ugjTz1CBQ66M/YRcs1AOuwJykR1MLjAhYTXk+MHeihucLVva/YoGccSuS5t2nEhuDWRUZoGidN+rPkaC9KSUExjmLDD/4/BlziV9XNVLcRyTiHVJdbF8n5ARQG/B6SxGVquHzMJ9Yc+cwg9kLtBrPTVCRtoOI9bmuzOS8X21tD3HgmbTuBAKfZK44/+u+mLF1fxtvAkOljNYf9N2d2RlUzHRh4xi33bkjXfCX8OhAicYBMCG7CKsww9kZ6S0s48hudiSbjQsBEuW0fwH4S2NvXv+/PzMLoH0dZS2gGSBmmvAR0mgr6raHP/QlLFCJrbgn+dn+F3Xx+IZlsiUyRqSKXT2cIqYXkCxAg8RrnysqYy7EUZgUCfX8raKOsvq+4qMrLwDkkGm+8WR3nildeXQH+Y+oW7dCFnFfNQuxsDzmUg5hapE/Kw733wLqwDJ2efQ1i37Bn2OQ+HALmoFr4+Y8ngTtgr0LibduT2xMnuxWf4boi0vNg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(2906002)(26005)(1076003)(426003)(336012)(16526019)(8936002)(36860700001)(2616005)(83380400001)(5660300002)(40460700003)(47076005)(36756003)(508600001)(86362001)(4326008)(8676002)(7696005)(81166007)(6916009)(316002)(6666004)(70586007)(82310400004)(70206006)(356005)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 22:26:15.2048 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80badb61-bfb1-4a56-9a01-08d9f32dad27
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5730
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

So we can tell which output goes to which device when multiple GPUs
are present.  Also while we are here, convert DRM_ERROR to dev_info.
The error cases are not critical.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
index 313517f7cf10..b38783278a99 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
@@ -56,13 +56,15 @@ static int amdgpu_benchmark_do_move(struct amdgpu_device *adev, unsigned size,
 }
 
 
-static void amdgpu_benchmark_log_results(int n, unsigned size,
+static void amdgpu_benchmark_log_results(struct amdgpu_device *adev,
+					 int n, unsigned size,
 					 unsigned int time,
 					 unsigned sdomain, unsigned ddomain,
 					 char *kind)
 {
 	unsigned int throughput = (n * (size >> 10)) / time;
-	DRM_INFO("amdgpu: %s %u bo moves of %u kB from"
+
+	dev_info(adev->dev, "amdgpu: %s %u bo moves of %u kB from"
 		 " %d to %d in %u ms, throughput: %u Mb/s or %u MB/s\n",
 		 kind, n, size >> 10, sdomain, ddomain, time,
 		 throughput * 8, throughput);
@@ -131,14 +133,14 @@ static void amdgpu_benchmark_move(struct amdgpu_device *adev, unsigned size,
 		if (time < 0)
 			goto out_cleanup;
 		if (time > 0)
-			amdgpu_benchmark_log_results(n, size, time,
+			amdgpu_benchmark_log_results(adev, n, size, time,
 						     sdomain, ddomain, "dma");
 	}
 
 out_cleanup:
 	/* Check error value now. The value can be overwritten when clean up.*/
 	if (r) {
-		DRM_ERROR("Error while benchmarking BO move.\n");
+		dev_info(adev->dev, "Error while benchmarking BO move.\n");
 	}
 
 	if (sobj) {
@@ -239,6 +241,6 @@ void amdgpu_benchmark(struct amdgpu_device *adev, int test_number)
 		break;
 
 	default:
-		DRM_ERROR("Unknown benchmark\n");
+		dev_info(adev->dev, "Unknown benchmark\n");
 	}
 }
-- 
2.35.1

