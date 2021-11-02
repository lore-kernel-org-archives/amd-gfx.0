Return-Path: <SRS0=itHt=PV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F0C8C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Nov 2021 19:23:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09D2160F02
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Nov 2021 19:23:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 09D2160F02
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 719CA73558;
	Tue,  2 Nov 2021 19:23:50 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2084.outbound.protection.outlook.com [40.107.95.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 232686E99F
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Nov 2021 19:23:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kwElRgDLoQeMkV5kXayC0fSVUHkJDY/zbuKduXC5gYqXhRdIEljPjLwOZBiblX7bH1fI5VakKtKxo1jjsVxIHkB0v/T7odNMHzo+ETJ2NHbnBCgEqrIfyxso1lhRRFoHjt86zjgSeZDoP1OeBnjCa36IWoVQ2DSmcUsrRuYsDNf839kPKDnFQYu7sCTBADgIxDxuu+Q74V8OdS+4FBhLTrWdBNxYFpqiFWu8fcLieBVKpW/M6IJj6fHuO7rwhUYu7vahb3w6WMSTE1xv5c6uu+b6I4X4qR+8G7ML1mb6Oql10qNyDhWbeUmWNLYgKVfXFI0aMagRvT1FrhLhADDQlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zq9+6O5s3KEJPNoeHrp2dKDP6HI0mRLjBqXkS1GZxrY=;
 b=RcwfxzWeMLJ/Ez41bOOMz55QfyhbcyoK1pUwv6+TyAfWtaEu45u8LWbCOY3cse3tkQFuYEwgHLG3J1sWlYWyzCLMXR4oWizZTSncGtKMujatUr8AJPlo5z4GhxTGfKjAshsNuQAx0wzw3pmqdiZ2rvifBPJQ0yxvUGy0jDmt7wbpvpHLgCVTwCazD7t+XDuucqHgNkRdYdix9HzRMT7J91n8ywDV/n4tw5DPT4z098GQG/Ez5gDmzbxQVeAIALg8V96I/8odo+fp0ruBmz1Rrh9uGQgcXMsQIG00tgtmbhPRvXgHHPaMc/SP9pJGHBRVBdGW03RlWzT975xCpOlZ3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zq9+6O5s3KEJPNoeHrp2dKDP6HI0mRLjBqXkS1GZxrY=;
 b=U3vsPuq8vpGBz1607woMWMwqD23b/twUwf3UBKICC3QBq6/pyd7pbiL9Wz/Nx4q/GQS3bM6nDNyDKnlSddoRN57kv7t+F2AA0WVomgk7NL/2bIDdrqNNu5ID5olURmoQwdHNBKEFiKWCJSrETgVHvoCtvjAa6ijGFZ4K6wSW5EM=
Received: from BN0PR10CA0020.namprd10.prod.outlook.com (2603:10b6:408:143::11)
 by MN2PR12MB2912.namprd12.prod.outlook.com (2603:10b6:208:ac::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Tue, 2 Nov
 2021 19:23:44 +0000
Received: from BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:143:cafe::2f) by BN0PR10CA0020.outlook.office365.com
 (2603:10b6:408:143::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend
 Transport; Tue, 2 Nov 2021 19:23:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT059.mail.protection.outlook.com (10.13.177.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Tue, 2 Nov 2021 19:23:43 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Tue, 2 Nov
 2021 14:23:40 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdkfd: fix boot failure when iommu is disabled in
 Picasso.
Date: Tue, 2 Nov 2021 15:23:24 -0400
Message-ID: <20211102192324.3402-2-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211102192324.3402-1-James.Zhu@amd.com>
References: <20211102192324.3402-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92470f03-f1ad-4771-5a27-08d99e3648d6
X-MS-TrafficTypeDiagnostic: MN2PR12MB2912:
X-Microsoft-Antispam-PRVS: <MN2PR12MB2912B7645A16272A21E5DBF5E48B9@MN2PR12MB2912.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hvcWgWKiCfYwpN39uLCm0DsxgSSIpMNJCYY+0F3IRK5vmFYnSILwMDgXtNOjJM2IaQlRwx0m63ZqygmPBnvD99/gACnYyk8mtPuVkr7jC8TaUxADMPigf/wFwg5G+eZVmMyVBvSRD4KKoHPXYLHEIWtbT3yr4VaL9D7kHDEyxp86STy7Ifkbtux/37aGvxq8bQP1XdQ0AJNfMrUKHEgtjjd7Mgjx4fsIfLCv/uqeCvZWICLxNmaBvTqvoXfskOMef0irP9j0uxqN3fIjB+qFgqO7WC8IGKi90nNT653mjEWMxPqRXbokcB2nakPjY94AF8AwPnf7fpdLUITYErsZ4zwjaqQvIrJuHoykoYB7gnTmst4fkPN3yGzKHfGSfCoaPAdOPP2RdwlkDqkF37D/8HC7TvbotKxxJ4xBf1mm5nLyHtcIDgM9U75WVnHPUXaSXw9FWZi/t5bNuIboC9sNHIAxbCB6daD2roWFQ349xM906vbuYVSnetSMLEGSIvgwC5DOI+MqlQFrdi/qjWogRiLu0ZXdsrYoYbdo5DEDbuVhseRkcf9AwH2w+E7UXn19MJgy92/b4cf90oQPXJDg7U1Kvbm7kV7vgHb20Nt7HCYuLj6ynIbZCxzVHqHM7mcurSd78UbBRJEeRtdM5c3TfFWZ7opLmEJU4G3Of9tKyNdqsudPeEOEnEs1lDEM/uYccNHgDOhXGgWJVGIyIbOM6HNxa3Ju1EoaZlmWOVF0gDk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(16526019)(5660300002)(70586007)(186003)(4326008)(54906003)(83380400001)(26005)(426003)(2906002)(336012)(1076003)(6666004)(316002)(70206006)(36860700001)(8936002)(7696005)(82310400003)(36756003)(356005)(86362001)(508600001)(81166007)(8676002)(47076005)(6916009)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2021 19:23:43.6626 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92470f03-f1ad-4771-5a27-08d99e3648d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2912
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
Cc: alexander.deucher@amd.com, yifan1.zhang@amd.com,
 youling <youling257@gmail.com>, jamesz@amd.com, zarniwhoop@ntlworld.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yifan Zhang <yifan1.zhang@amd.com>

When IOMMU disabled in sbios and kfd in iommuv2 path, iommuv2
init will fail. But this failure should not block amdgpu driver init.

Reported-by: youling <youling257@gmail.com>
Tested-by: youling <youling257@gmail.com>
Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Reviewed-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ----
 drivers/gpu/drm/amd/amdkfd/kfd_device.c    | 3 +++
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index e56bc925afcf..f77823ce7ae8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2398,10 +2398,6 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 	if (!adev->gmc.xgmi.pending_reset)
 		amdgpu_amdkfd_device_init(adev);
 
-	r = amdgpu_amdkfd_resume_iommu(adev);
-	if (r)
-		goto init_failed;
-
 	amdgpu_fru_get_product_info(adev);
 
 init_failed:
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index be26c4016ade..7677ced16a27 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -1031,6 +1031,9 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 
 	svm_migrate_init(kfd->adev);
 
+	if(kgd2kfd_resume_iommu(kfd))
+		goto device_iommu_error;
+
 	if (kfd_resume(kfd))
 		goto kfd_resume_error;
 
-- 
2.25.1

