Return-Path: <SRS0=iyzK=O7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292EAC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Oct 2021 08:28:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA7D560EB1
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Oct 2021 08:28:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EA7D560EB1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B91C6E43F;
	Mon, 11 Oct 2021 08:28:47 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2072.outbound.protection.outlook.com [40.107.100.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC4116E43F
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Oct 2021 08:28:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PMZkWd4M7gMEunpK3mqQY2DXuclzpPrLmWPBnpe/O9in0oRcPlJArk0AhjlmIKL7b2sQSVpW9x7+qDrGPjiJTouYbKOwVi8ENfGIoISVzaLWdd0LoEylVsVlMGRk2AhMoHUPO59pYYZ3D1w/O+CVEuWYwjCD3DKkgzoQURUgNDzs1S3NLkmkiGCzj36K/Wi130CTOA2llO2M+uX7PWk62W3FEKi5VB1sJoBCCkcVJUWKkMlN2CXyFIDOHDTteS2fabFNuyYobXLSiQl5WA+NUgOUn7jAaTvWYB9I9D+RYCuVXRRjO3WLI5XOveWXm8XVXXhP/1gQbTGxpOLfrDoffw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N5Rw6dTP1F73h+uz4izNBFQIn3NTARRRLQxz90bTJRI=;
 b=FuE3IVwLuwZs59XCDQElHcjaVY6i6FNu7hFU8HyDzxTgjS2RhiWTfXwvT4SH1zg1jOaNcCXXjIP4Mzl2i+KiUqJctGVugaaivPpxEJQzJNX3pGZdEy8DiS6+7zcO3hN6YdHKqyrIj+U13MOYd7X5zwkQOr9Q/txVogoO4IP4fm89RitzTAuzofeK3kWStlowT5wLQHcuCbnApn5W9FNtql3y0XUBg7JR2JEGFXvLWvZtQH48axoI26uS17qer1Bn+3boG9Cspf2dYZMk+8OLKS0dXOckPn8BW9NNdy/E39nOB1L9+66g1zwJGpbPPgZ3YsWGzVYbzwDuUujf/VxR+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N5Rw6dTP1F73h+uz4izNBFQIn3NTARRRLQxz90bTJRI=;
 b=4fn1cqCHEqzIsLVOmDz1ReVoNdSflmKuUSAvhenxBBxy8+3K5wzYrygxiQWNwDhDfraGUYEnVOrXrsqDiHd/Behi1swjwKdH8cMj1mUQwAPSHWsLUA4HD0C9dE0ekJsU+72m9GN6uWGqyYKpQVMJqp1K1q+q/RbFZXIl3W0fFOQ=
Received: from MW4PR04CA0361.namprd04.prod.outlook.com (2603:10b6:303:81::6)
 by BN8PR12MB3442.namprd12.prod.outlook.com (2603:10b6:408:43::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.20; Mon, 11 Oct
 2021 08:28:42 +0000
Received: from CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::3) by MW4PR04CA0361.outlook.office365.com
 (2603:10b6:303:81::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25 via Frontend
 Transport; Mon, 11 Oct 2021 08:28:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT045.mail.protection.outlook.com (10.13.175.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Mon, 11 Oct 2021 08:28:41 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 11 Oct
 2021 03:28:39 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <andrey.grodzovsky@amd.com>, Evan Quan
 <evan.quan@amd.com>
Subject: [PATCH] drm/amdgpu: fix Polaris12 uvd crash on driver unload
Date: Mon, 11 Oct 2021 16:28:12 +0800
Message-ID: <20211011082812.742688-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a767268-c2b6-4278-3e58-08d98c9121eb
X-MS-TrafficTypeDiagnostic: BN8PR12MB3442:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3442B17F5311070B9E4BA4D7E4B59@BN8PR12MB3442.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 02DL8nSGE7V2SEGCFMMGe+vjuKivjHCBKp7YeC6toXBiBz3hsq9isf/FFZ7xoLKv+UABPZ1cGPn2c7j8/5nQaBeIfFItybnYOcD/UJE+7qd65Lbvd1CGyZqwwwIv7v32FNXOGhjl5qTFmb+NHuW+vFZHMUYF0YBqueA2r0frWY6F4rf1xbY5coFyuyiD/KfE/QdZeZGwe/t+fxC9YxovsaVgArsaiGaGWspRTSGXnQUUoHBCQc/DWrASd9Rp1fgb7UMEl2XbHzb/3+zjeY4bJu6meePerzIAcZ3a4x6a6DJrfDFEowfFI1n46PWDolJwEwypWULsx4IFzLfVJN3j7GlaXuS1/l/bRcFDukchtbfsDDct+tfdF/3YcFwqkczzLK8hINkwtSiuWrmd7z13E4+UuNL1eDxBEY1c3v9/+DtTx01pP6rxK7xwnH5x2wJDJQ1RvPtiLb2RzYmEg7nwCimIp7VDB1pQkYw+sy3XSLIgeUgD1ssX0RfH8xE4Xr3V2OuLILLw6qoArsiUBYCOM+jExvpeaU0JoCanPEHsZTZYaNy3jDi1qaeVTLtecVsjK26qFTu5LHiJcuya60iAQvAy57qsv+Q3049o4M8nKCqv/G1MSERe58oJhpBfjlPnayYXC0CEShhVKiAf82IKpPjQY2dVPiEbWrRRL+pngeGAqsMGEW+bkk1nLeJkh47lwJVBiXm+B8LHs0LCsOTLSrZ+CS6gnL/wtRCY6RInIJg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(81166007)(16526019)(5660300002)(54906003)(2616005)(6916009)(1076003)(316002)(86362001)(186003)(4326008)(356005)(26005)(6666004)(83380400001)(7696005)(47076005)(82310400003)(336012)(426003)(2906002)(36860700001)(8676002)(70206006)(44832011)(508600001)(36756003)(70586007)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2021 08:28:41.5235 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a767268-c2b6-4278-3e58-08d98c9121eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3442
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

This is a supplement for the change below:
cdccf1ffe1a3 drm/amdgpu: Fix crash on device remove/driver unload

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: Iedc25e2f572f04772511d56781b01b481e22fd00
---
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
index d5d023a24269..2d558c2f417d 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
@@ -534,6 +534,19 @@ static int uvd_v6_0_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	cancel_delayed_work_sync(&adev->uvd.idle_work);
+
+	if (RREG32(mmUVD_STATUS) != 0)
+		uvd_v6_0_stop(adev);
+
+	return 0;
+}
+
+static int uvd_v6_0_suspend(void *handle)
+{
+	int r;
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
 	/*
 	 * Proper cleanups before halting the HW engine:
 	 *   - cancel the delayed idle work
@@ -558,17 +571,6 @@ static int uvd_v6_0_hw_fini(void *handle)
 						       AMD_CG_STATE_GATE);
 	}
 
-	if (RREG32(mmUVD_STATUS) != 0)
-		uvd_v6_0_stop(adev);
-
-	return 0;
-}
-
-static int uvd_v6_0_suspend(void *handle)
-{
-	int r;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-
 	r = uvd_v6_0_hw_fini(adev);
 	if (r)
 		return r;
-- 
2.29.0

