Return-Path: <SRS0=UpsA=OS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75359C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 08:28:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16B98611CA
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 08:28:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 16B98611CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2D576E87E;
	Tue, 28 Sep 2021 08:28:45 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2077.outbound.protection.outlook.com [40.107.95.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8122A6E87D
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Sep 2021 08:28:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lb+JHzjm+tLWgR+RDQc3bw6lFnhx8FEsR+4TN8EacTb92XRyGJgAiupbbr8i6UlfsNEDQWs5J3aGonnqXDmGwkconujE2lBUkAmE8sTwAPv8gZjsjMMQUlJ9TrKBVm1mC0urGdZbY77Ze5UT0Eq3ZUuokuiMXFykFVRUYkGorrnMqZddY6bF6GjBw1pRn3ie7SsCG5K339YOJQWZgtkIV2pelzejUYnB5RzQfA/3SiosxgZL1M+i8bQW0+wl5uJiGoiSXCM1jtncXjrttVWb8pMvkM5ISloFwex7u0Q40+uAudUTWD47nnEzPGj1qK6WMfBpRrnKtSDNU44tttObAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=a7CtOUCFTLrxpidJ04pZ+HdIWJxfaCMwICMrH9UJh2s=;
 b=banb4w9KktMDfhrTMe5a4eM0MzdihU8YWTjubaBW91CPchXdEp3ztyQwQZl1bf32MXfCF+VH28aPUiSmATpBYF/aO846kb7eRs8oU/vDabnFDZNn8Jb8rOQf6Y/fCrf8CMWRre7XoJl0ZJnShzq9G1oJw5OT11GPj0zkjjsB+i4m/tnhx6aGfREC7ft17SHMCTqFFSPTn80vKAMvdkLk78C/e7NJQOBRJDvMUeJ3zao85yzwqr2RVTmkI2YzOFOVNj2u3o20NexT0qHZ5w95x5KQ2SMphQ6tt0TVJmozs4s3x0zaJX8T7zQUX93F7MP6/75HKl3A+rqQrmDQ5/8eng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a7CtOUCFTLrxpidJ04pZ+HdIWJxfaCMwICMrH9UJh2s=;
 b=phnrf90D1024dW+iLrqsRIXS9wazYAy3sXBw87ckbyqwW9CzF0s4SKWbQflqFpH+SzOHuZfviR1dqiILadHImli+iaBjAH4ro1FRB6DuIibFerB9cwGpxynNiIjzRtxxiAAAKEpuINNcR/ZO8zxs/sRusPk5+OAakgkACqO4eWw=
Received: from DM3PR12CA0102.namprd12.prod.outlook.com (2603:10b6:0:55::22) by
 CY4PR12MB1573.namprd12.prod.outlook.com (2603:10b6:910:d::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.13; Tue, 28 Sep 2021 08:28:41 +0000
Received: from DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:55:cafe::83) by DM3PR12CA0102.outlook.office365.com
 (2603:10b6:0:55::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Tue, 28 Sep 2021 08:28:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT046.mail.protection.outlook.com (10.13.172.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Tue, 28 Sep 2021 08:28:41 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 28 Sep
 2021 03:28:39 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, Yifan Zhang <yifan1.zhang@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: init iommu after amdkfd device init
Date: Tue, 28 Sep 2021 16:28:19 +0800
Message-ID: <20210928082819.205231-2-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210928082819.205231-1-yifan1.zhang@amd.com>
References: <20210928082819.205231-1-yifan1.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82e32405-7f88-4dc3-51ad-08d98259fa3f
X-MS-TrafficTypeDiagnostic: CY4PR12MB1573:
X-Microsoft-Antispam-PRVS: <CY4PR12MB15730962261C57F7BF6DD586C1A89@CY4PR12MB1573.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K3bn7clWQOB8tGIQy4ZYDL4YUwkyeXc1fcYzCwwq7LP0BI9uMkCdJkZsdx4hS9KMB//xSl9qTqgD/jTHoxnBMQJJW8WbUfSeskHv2gpGql3RjbNMdG1iT988DZ3K+UMZ1+FoS101WKIAgQ53u7mxYbHBuzanJAaMeAvcr5bdPov2fQqfnuklIPOBFCimcj+TSdy5M90W0hrhEAT27qjm9sutYnqqu3J3yMWj8Kmc7+5bZdPrs87SdbNA0vG9J2mxzXE0U5ISrtKunW0yg5VtSjr1PZxTJ1LcycQEnaz9/mCB4rHFoWbOKIyDgKHNW8G65cI4vysGl+h2Z+bgGcDvls5JG1inQQ9e1LAvpn1ZmbkxyFOXQ7jKgGdzrurs6G9NXglBQTQO0uWA4bGn3HftPCqeMZa6cV1AXHWOcyfEgTH1fyVE+NRaCYmL1xjx+sraL1BtVYENlFXoVmn1ePgBz46SSwsWbcM3EbjZZR2JObeQPfrhiMu0ue8JT3Vn5R48g6vSF8CbYORNgLo8PrC0fIV4OlqhqlP6kKTrvCd1/Wsq9pumdGSGU4UCC3tkP5pNTJvC8rgAmQM7Eg8tb9LA5HbuH5hJEmfqu0FW2gQ1ROgwuL5i2kRRIkTtAV5D1GhS/MPKm2gIY9OgCmMH6OgfiSsO6KnDmoSGawozOCJg/TEZy7c5XUFxXxcKMH4F0ZgGwyDeftTqKTtXkeGI3xki1TYp+suQwW2jQVfb0HDi9rE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(316002)(336012)(83380400001)(16526019)(508600001)(47076005)(36756003)(36860700001)(186003)(26005)(2906002)(54906003)(8936002)(6666004)(82310400003)(7696005)(8676002)(81166007)(356005)(2616005)(86362001)(70206006)(70586007)(6916009)(426003)(1076003)(4326008)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 08:28:41.0980 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82e32405-7f88-4dc3-51ad-08d98259fa3f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1573
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch is to fix clinfo failure in Raven/Picasso:

Number of platforms: 1
  Platform Profile: FULL_PROFILE
  Platform Version: OpenCL 2.2 AMD-APP (3364.0)
  Platform Name: AMD Accelerated Parallel Processing
  Platform Vendor: Advanced Micro Devices, Inc.
  Platform Extensions: cl_khr_icd cl_amd_event_callback

  Platform Name: AMD Accelerated Parallel Processing Number of devices: 0

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 4c8f2f4647c0..89ed9b091386 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2393,10 +2393,6 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 	if (r)
 		goto init_failed;
 
-	r = amdgpu_amdkfd_resume_iommu(adev);
-	if (r)
-		goto init_failed;
-
 	r = amdgpu_device_ip_hw_init_phase1(adev);
 	if (r)
 		goto init_failed;
@@ -2435,6 +2431,10 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 	if (!adev->gmc.xgmi.pending_reset)
 		amdgpu_amdkfd_device_init(adev);
 
+	r = amdgpu_amdkfd_resume_iommu(adev);
+	if (r)
+		goto init_failed;
+
 	amdgpu_fru_get_product_info(adev);
 
 init_failed:
-- 
2.25.1

