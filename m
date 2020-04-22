Return-Path: <SRS0=Hoyj=6G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84222C38A30
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 04:31:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 272872064C
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 04:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1fK/PBad"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 272872064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD6156E4E3;
	Wed, 22 Apr 2020 04:31:37 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 986E26E0EB
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2020 04:31:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jilw7f2YtBsPBXkHkQlBJWsi/y5icWmU3K1fHGieJPrVwvdt+YvzLl8f2bdLdIdayRKX+pH/0ST6fZ+EAzNeACma2H/WGZmgwsuP4yEVFvSyVFnJQ1A3SYy9XbN9zuCPvh9aoLhB4K9IyWqEWJUf+eBvyV/oGoq8PAhe3DzDfoCpp12L/m1c4Mp7G9TkcUUwRZEoznHmsM1EC07hAS1rm8rLDVMtAcmZmn1hLgtpPfysW6mFZtUQlWSna8ZNSX1cwR+kdLR4Y9C7JyHfEAPWsDEW2NYbEwgCMvwRhIayYNIGzRotf03ajoUkPKtNqRNrh+puE8EAj+nbMOVCN414kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FlnBdgjBvsLa7zH2N/N4RvgH5GlLM8sd7JAZ6VeKjok=;
 b=GmutQaBEKFGpspwJPwciAwKvbybHERo1WHMLNmjiJu3IZql0eG4iJ859dsezLX9voQNFqNvwrO9wBMkMvipZFyR1XOmKLC+F/L9OCeXGg/+K1c1+UPg1Y3josYgLT4H9B8exM/IpZ9En+TPui5zsBeu8a96Sg1bxA+0o/zr8ViUw9NrufblGuj6XaKRoKPE3eMyiL3XTVqAM7aYe6N4lq46HTpnI/yHoSgTBwIGC8ZAT8jgS8NjlpLvAIRr8rm7H8rB3DMGAmp+TwlRb/bMk7mZYuqhiqyy7VRyAQSBquO6ANUSM32WVDvJhLs98csQLgB7uiqUZld+JqljasXzvWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FlnBdgjBvsLa7zH2N/N4RvgH5GlLM8sd7JAZ6VeKjok=;
 b=1fK/PBadvIKgRjGZDy4b8LHSxKba2cqKtEwEOP3+yGMCRBCJMUlvta99fB2aYiED3U+2Wc0s1KT2krABkxPulp9Xo+FmuESs5rTjlk6HtDR19r1p0NYnUfrs8BLdVgWqIe09N9V6HjltAsyShUcvQIRSEyFkW/0IXKzjGPTNFSY=
Received: from DM5PR07CA0108.namprd07.prod.outlook.com (2603:10b6:4:ae::37) by
 BL0PR12MB2484.namprd12.prod.outlook.com (2603:10b6:207:4e::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.29; Wed, 22 Apr 2020 04:31:34 +0000
Received: from DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::74) by DM5PR07CA0108.outlook.office365.com
 (2603:10b6:4:ae::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27 via Frontend
 Transport; Wed, 22 Apr 2020 04:31:34 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT020.mail.protection.outlook.com (10.13.172.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2937.15 via Frontend Transport; Wed, 22 Apr 2020 04:31:33 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 21 Apr
 2020 23:31:32 -0500
Received: from yajunl-gv.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Tue, 21 Apr 2020 23:31:31 -0500
From: Dennis Li <Dennis.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Tao.Zhou1@amd.com>, <Hawking.Zhang@amd.com>, <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amd/amdgpu: set error query ready after all IPs late init
Date: Wed, 22 Apr 2020 12:31:22 +0800
Message-ID: <20200422043122.20601-1-Dennis.Li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(396003)(376002)(346002)(136003)(39850400004)(428003)(46966005)(336012)(5660300002)(478600001)(426003)(6636002)(4326008)(2616005)(2906002)(1076003)(26005)(8676002)(110136005)(36756003)(316002)(6666004)(81156014)(86362001)(7696005)(81166007)(82740400003)(70586007)(356005)(82310400002)(8936002)(47076004)(70206006)(186003)(2101003);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00d66e56-ddba-45fc-c5e2-08d7e676098a
X-MS-TrafficTypeDiagnostic: BL0PR12MB2484:
X-Microsoft-Antispam-PRVS: <BL0PR12MB24843D4ED1B38EA278199432EDD20@BL0PR12MB2484.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-Forefront-PRVS: 03818C953D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Umso1cb2dKpTNYPI/mxeJqvCsS6If8GYN5d9JjDwL3hqNq8PY2zlaiRp9mjrt9g21+ttCvY2hSIEtLn0B9a1D/4vRZtVzZVd/3vS/kGd5CqgX8W+pVFRouUCuL3NYLk1yjRkaAfX36cNaHKBzlSMk2OOzVZm08t5eDi8fZzuSc3+0oJH1e9LZrGW9hpnR7+43yO0KmhIjtoSBxxM3mdRm+c5UoFU4HiqiHzPKHvw5vTX+qNk31D+7gDZdPNmH76EPamUVoODFR0rmGA+f6k6WbVldiIi9CNZE+3Udx6FcmAthkaCWTwONPs54w7ZXv9DrtcDf1M8YaREcy8wZYr3wU8s0MKR3eaHWxIU4yIirHGZF6NpzQEKhDt1G1ryN1387Gw3p9+64RjkhSyJHkVGSGsGR80b8NKucWKABenX2YMBo1jj9K+7Zr9KEYM+Jp/Z4r/XRHMnRcmpUXD5dU3eBl9A/zSeExoizAhzKH9QNDk5eVfb4nWn7xaaxg9u8HqL0x1pnJvSrblyDGT2r6ctIOupMIQJpwW7octX+V6WHY8=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2020 04:31:33.5934 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00d66e56-ddba-45fc-c5e2-08d7e676098a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2484
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
Cc: Dennis Li <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If set error query ready in amdgpu_ras_late_init, which will
cause some IP blocks aren't initialized, but their error query
is ready.

Change-Id: I5087527261cb1b462afd82ad7592cf1ef73b15bd
Signed-off-by: Dennis Li <Dennis.Li@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
old mode 100644
new mode 100755
index 423eed223aa5..e37e0982cd46
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2218,6 +2218,8 @@ static int amdgpu_device_ip_late_init(struct amdgpu_device *adev)
 		adev->ip_blocks[i].status.late_initialized = true;
 	}
 
+	amdgpu_ras_set_error_query_ready(adev, true);
+
 	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_GATE);
 	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_GATE);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 68b82f7b0b80..060866d372a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1922,7 +1922,6 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev,
 
 	/* in resume phase, no need to create ras fs node */
 	if (adev->in_suspend || adev->in_gpu_reset) {
-		amdgpu_ras_set_error_query_ready(adev, true);
 		return 0;
 	}
 
@@ -1936,8 +1935,6 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev,
 	if (r)
 		goto sysfs;
 
-	amdgpu_ras_set_error_query_ready(adev, true);
-
 	return 0;
 cleanup:
 	amdgpu_ras_sysfs_remove(adev, ras_block);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
