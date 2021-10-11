Return-Path: <SRS0=iyzK=O7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5390CC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Oct 2021 12:57:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1222160E9C
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Oct 2021 12:57:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1222160E9C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F9FB89D9B;
	Mon, 11 Oct 2021 12:57:49 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2063.outbound.protection.outlook.com [40.107.96.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D211F89BB3
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Oct 2021 12:57:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kbar8XFR7aTPHFrs3ez1EEuAqX87cApZHV0MleMxrnYEwBIfQ3BPrn/930259kBBQ6HFuzALFGGc2At6AGYlsMOIAyH7AUY7OoJ6ZF5xMcB9DveX4gmOV4Wq5gzUraRhyLVji2qxQ+s49sMJCqxjCH4BTZICxhA1y98TmB9EwGbCukbPJP698K/S41MjJRamK8nLErxmQSAWIMc89fpijDkdOQV4abx9jVwQx5QwmICp4RhQS7TGIlt48hwtWyeUDex0M6ihFpIbIlWV2a+FnZt2bkZPNvWtGWxT//dChogPmfuBNvrCQTFM1H07nGbBKStIDWaNlw4tdMtIaKNvqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RqLwZ13t9wK1u6KKMy5E7kBkNB2i9ui/9jMd5P3c2F8=;
 b=G69jtlBM7VLX3RpxHdU1gLaDywAbj1wHNclmXP43cQB2z1LaHJ5Lp1UovsprieYlb8Y4N+Yi1BVFQCRFFA1EzN1rHUrVaxC7cG98uLFfPfe/5o5nwkYXuT5GfNHUGD8nYHkFGmayzCW2zr1ZvVZR4uZhhFDZ8ZunQ8B3u6xDx47cAM3lHBIgcOPHx82nLNUmbCl30SYsM1CJB87xDJiTjbv/y0/zq3ktz+wm6QmYCP4GlzSv+He4MDKr+Lv3p/weRM/TUXd+xmb5xE+2z6SO4OXe+KhDLFVWd9zcOymTILg/xPbglOtbN6xssIxWOjE8B/v45xBNToAA/Dwxrx53Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RqLwZ13t9wK1u6KKMy5E7kBkNB2i9ui/9jMd5P3c2F8=;
 b=jP9IH6yF9W2YjEGwjw3BKTmwr4/+N8XENe1SjxtnnPnDfERfh3m/s38YUWMBHUlcLbC/5Uiu4hM894I+Xy25D0+vIj/CZY9qDi/BDX9tN8joZmLl6uJClPXiyUrQRqhi6BgPJZOhROI5vAulEpqvkqfkysOEKswNFDsn4PISdbs=
Received: from DM5PR22CA0023.namprd22.prod.outlook.com (2603:10b6:3:101::33)
 by CH0PR12MB5092.namprd12.prod.outlook.com (2603:10b6:610:bf::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Mon, 11 Oct
 2021 12:57:44 +0000
Received: from DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:101:cafe::72) by DM5PR22CA0023.outlook.office365.com
 (2603:10b6:3:101::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19 via Frontend
 Transport; Mon, 11 Oct 2021 12:57:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT012.mail.protection.outlook.com (10.13.173.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Mon, 11 Oct 2021 12:57:43 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 11 Oct
 2021 07:57:40 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <jamesz@amd.com>, <youling257@gmail.com>, "Yifan
 Zhang" <yifan1.zhang@amd.com>
Subject: [PATCH 1/2] drm/amdkfd: fix boot failure when iommu is disabled in
 Picasso.
Date: Mon, 11 Oct 2021 20:57:00 +0800
Message-ID: <20211011125701.2800114-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45ab92e7-1d41-408d-9e29-08d98cb6b72f
X-MS-TrafficTypeDiagnostic: CH0PR12MB5092:
X-Microsoft-Antispam-PRVS: <CH0PR12MB50920F6ECCC1565A982E4829C1B59@CH0PR12MB5092.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fiQeuKHiZDwyEwmtZ3+hwTKjA6FiYtrGIf+XQejZV808E2vJGopX35C83pf+WyGQ66Y9edkB/J5DdT9vX+FrFurWh5x6fdPucyfldvMDpMhU11t+40ePIzKmCTChKET+pruWgSUv8gEcUO+zpz5jmZDu++XXa/eFSqiAnDV+aUXbgcSp98qLw5YIY2YDfOPcSbnMItb3S2wUvsHwHtEBQntYSy3GpqmQezIMOPsuGTtnS0VUO1mUdcaWk26ns5zJOl6rXDHVUa1e6E6gVm33J42zxsFCXo+6kZJGRrTZHLqGBKMpDpwWH8dFLOiGw2afr1XX+bsY7tyC7J/w2jlgw17HvLItmLuA0TFdsHP/AF92icTg5JxG1F+JDxdOOvv13vW9mRJluYVNefkISvqBgCL1poTPDAJVmhS+S6qx5QeBdatgPsAaDpgotun2xWZUC86dFVDGoBFHytHRXsw0VLn9VS7mcDZ5UJCSeCjT0ZFdfa+v9s2vb8A8ZsGNmBqYrHAV2/3JR1H9YSCDFFtXamKaPyO9s/lvnCrsp12hRUEwe+JNGWGKYihg/xagvZYxw+u2Ya4ceOPBIURHqMvkMuuZsTDuZBW9KSx4pnqvlcrFR3p/3/uBkrpbXNQsgMzEwvSttUu/4O3avqnChPA5umCHPXaUyLDiSPlIU6KSZeLLAwQjVV+n/XwHEMOjwgkktGCWBTFsily4O3FsFjD03LwEhudqZL34aRWjdo+7pZg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(508600001)(36756003)(82310400003)(83380400001)(1076003)(8676002)(5660300002)(86362001)(8936002)(6916009)(47076005)(336012)(4326008)(426003)(2906002)(16526019)(186003)(54906003)(26005)(356005)(36860700001)(81166007)(2616005)(316002)(7696005)(6666004)(70586007)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2021 12:57:43.4104 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45ab92e7-1d41-408d-9e29-08d98cb6b72f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5092
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

When IOMMU disabled in sbios and kfd in iommuv2 path, iommuv2
init will fail. But this failure should not block amdgpu driver init.

Reported-by: youling <youling257@gmail.com>
Tested-by: youling <youling257@gmail.com>
Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ----
 drivers/gpu/drm/amd/amdkfd/kfd_device.c    | 3 +++
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index af9bdf16eefd..9dfcef2015c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2432,10 +2432,6 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 	if (!adev->gmc.xgmi.pending_reset)
 		amdgpu_amdkfd_device_init(adev);
 
-	r = amdgpu_amdkfd_resume_iommu(adev);
-	if (r)
-		goto init_failed;
-
 	amdgpu_fru_get_product_info(adev);
 
 init_failed:
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 4a416231b24c..bb652ee35c25 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -920,6 +920,9 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 		goto device_iommu_error;
 	}
 
+	if(kgd2kfd_resume_iommu(kfd))
+		goto device_iommu_error;
+
 	kfd_cwsr_init(kfd);
 
 	svm_migrate_init((struct amdgpu_device *)kfd->kgd);
-- 
2.25.1

