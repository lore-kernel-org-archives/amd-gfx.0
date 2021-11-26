Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 367DFC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Nov 2021 13:26:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A888A6EE56;
	Fri, 26 Nov 2021 13:26:00 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 298C56EE56
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Nov 2021 13:25:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IgNjm5lV/ofY4oRsxvkidhVIzowW1DHfy+gBLEbgx3uie5iAVZUKBgTCtqVJX3xULJX85A/1Zr6m0EjDar/+LdOO0wZRzSgx4e5+uyvN2718sRdhonUsgXgHxz6Ls7YxA/ZX8VXxbUpMHTJR1HO/Nn5CwKL5CgWRoLN1Qev9bwLKco48nzkdIHHNTveR2Aeza2SpbBi/s5sDWlHoFFbLRt8a4ulZiOSqeLwcho6cWgD1Rs+waFDOSqSSMospZnGyCg27Va6w7qKgDHhHKH0Btl1kHrKua7ucq8CbCBaVy4B46QWeUQn51c5sWYbmXH+uctsMx3nsR3Un+8/55nA8/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=euqRjGvRxPy4o7Ou7KMHFmlhos/cjHazS7C+52PSxDY=;
 b=LwozzSOSMPcUGOyOteAOPsDDuuXJ5KYrndsAMgrQd/3oaTEB62c3EXtX4fVteGUSvEB8UQtoCALPauLk+NAGO85Df1tJ/l/daNifU2xP2h/Id8Xf78Kv32KnvtA5fMdfIPqBWZSXWVJKBo//KHBVdhhpK31jE/UJH7VVj+XJE505Tr/rP8y269VKJg9KVpwzz2WoE2eTuISOZhFnmdSr8OgdN7+I/B8aB1eD1Atg4lIEHENt/gSHc3+Cce5SHBKAD1DSiyqiRgQZdq1hW2V6aGyzo8NR81R9pi62I8OhdZD0pivWpG6X80hwTi+9Al8hfkQbMcLNoAk07Ph3/d5L7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=euqRjGvRxPy4o7Ou7KMHFmlhos/cjHazS7C+52PSxDY=;
 b=mdgMqbVk6eT51Sw3ePPeZwBvGU5xdEkdpCUKqG/BUcOl9xUfeC3nU3Gw3F3h+OaSwo0rktiIue7mSphbpamlPJuWOr784iTZBoZyWbY+w6089E7FK17FTLzgg98yg36xKPSuSuy+UGk+QlV233LUHSa+hdG4f7JTyzgVqxxURNg=
Received: from MWHPR22CA0020.namprd22.prod.outlook.com (2603:10b6:300:ef::30)
 by BY5PR12MB3796.namprd12.prod.outlook.com (2603:10b6:a03:1ae::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20; Fri, 26 Nov
 2021 13:25:55 +0000
Received: from CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ef:cafe::9c) by MWHPR22CA0020.outlook.office365.com
 (2603:10b6:300:ef::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.21 via Frontend
 Transport; Fri, 26 Nov 2021 13:25:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT042.mail.protection.outlook.com (10.13.174.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Fri, 26 Nov 2021 13:25:54 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 26 Nov
 2021 07:25:54 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 26 Nov
 2021 05:25:53 -0800
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 26 Nov 2021 07:25:51 -0600
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>,
 <John.Clements@amd.com>, <tao.zhou1@amd.com>, <candice.li@amd.com>,
 <yipeng.chai@amd.com>
Subject: [PATCH Review 1/1] drm/amdgpu: fix disable ras feature failed when
 unload drvier v2
Date: Fri, 26 Nov 2021 21:25:49 +0800
Message-ID: <20211126132549.15175-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 90c2fc45-268a-4f56-04c3-08d9b0e04670
X-MS-TrafficTypeDiagnostic: BY5PR12MB3796:
X-Microsoft-Antispam-PRVS: <BY5PR12MB37962A0712DCA94A4CEFC3DA9A639@BY5PR12MB3796.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:267;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: heLDpTg98BOaWKdlI+GCjau327t+wbZcxAvz4Ze+Mw+e6989qtd7KOz9D2mrzEQX+RnWOjPlI8Ga7UJP1oLX8yErCZuz8z71cqetxuYt59JVOeDaKEh1mvXqM9sJDseiB9HM47RvWoq8dzqxyiVnJ6cvngiMkJXKs00vyE86gpmRtp/j8W7BjnqLcHOsOAdch1dR8KT5emum6TUE8JDc+CwtEJfHjf/DYDIqAmr6DQb97KQIpZlKLVFgHO9C6FSxYbHAmc2B0CFH9wfh8wBEoq3OlX/XOoi8tRU4iFz8Oxvz24vAyAXvYEo72uVC5ZMdvdZ94zPZubJL2BTAoM42+pqL9Ep7tA7JcIvLBKJRwEy7nEeaRSc/nUtSUGGqr7Vd/mJ+qSazwIUdKhDWmbbR8KPBPGlUOhl1sw1HdxRha7R+ExYVCYDOYGqAnpO3KrByVhp5FbDTsyGAA80iAo/Up34GggcyzPgLBUfLlzmEGfkFY1r4rj5SbrWMbAAzgbpM1RcyzldgcZgH4vLlvcaRGsLcc8La8QvkButcIFcUpJ2o/N8Wec82Adyslh5DSV0gbWMkcbH6bBtI6Zm+SX4ZJIo+bEjBiv3d0UScCPlrqtId1T0IX+hMU4i0ty1vq1Ya4Cknnsc/o+TJxlFECwZ0JPQgxrVUGJKpPY8RkigUShJDoG7vaMLPugWC62l2CYwIy/mDoezERhH1uRdSDU0jGukAzqVzwADUBBBKxXPCPuM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(7696005)(2906002)(2616005)(70586007)(6636002)(356005)(1076003)(186003)(426003)(4326008)(70206006)(26005)(8936002)(81166007)(83380400001)(8676002)(86362001)(316002)(47076005)(336012)(82310400004)(110136005)(508600001)(36756003)(5660300002)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2021 13:25:54.8966 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90c2fc45-268a-4f56-04c3-08d9b0e04670
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3796
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
Cc: "Stanley.Yang" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

v2:
    still need call ras_disable_all_featrures to handle
    ras initilization failure case.

Function amdgpu_device_fini_hw is called before amdgpu_device_fini_sw,
so ras ta will unload before send ras disable command, ras dsiable operation
must before hw fini.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    | 1 -
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 73ec46140d68..d5e642e90010 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2838,8 +2838,6 @@ static int amdgpu_device_ip_fini(struct amdgpu_device *adev)
 	if (amdgpu_sriov_vf(adev) && adev->virt.ras_init_done)
 		amdgpu_virt_release_ras_err_handler_data(adev);
 
-	amdgpu_ras_pre_fini(adev);
-
 	if (adev->gmc.xgmi.num_physical_nodes > 1)
 		amdgpu_xgmi_remove_device(adev);
 
@@ -3959,6 +3957,9 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 
 	amdgpu_fbdev_fini(adev);
 
+	/* disable ras feature must before hw fini */
+	amdgpu_ras_pre_fini(adev);
+
 	amdgpu_device_ip_fini_early(adev);
 
 	amdgpu_irq_fini_hw(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 39dfd4d59881..9400029ac3bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2484,7 +2484,6 @@ void amdgpu_ras_late_fini(struct amdgpu_device *adev,
 	amdgpu_ras_sysfs_remove(adev, ras_block);
 	if (ih_info->cb)
 		amdgpu_ras_interrupt_remove_handler(adev, ih_info);
-	amdgpu_ras_feature_enable(adev, ras_block, 0);
 }
 
 /* do some init work after IP late init as dependence.
-- 
2.17.1

