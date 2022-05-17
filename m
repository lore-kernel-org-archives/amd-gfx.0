Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07415C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 17 May 2022 17:00:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C975113279;
	Tue, 17 May 2022 17:00:43 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0454113278
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 May 2022 17:00:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gdgw945ZycITZLrJ0QUARYzqU7Aw172ewJ9v+coTraotc7f3RTIkrBfGE/OpZsjHradd24iz2MRzEP3bqOUWzz2LrCqN1o5XRec+Zu0VblKR87DSxCxTwUGqQY8MKcochs3ReqHOx1uJEX10cAToony8XIXAO8KhVoY/4lhJ0inMofBaU5QLBQCVxqfVTiXujL/v2olGJxbPy1av5AHaXu84x/BgTsTY8dgJtx9V5aJHGKfYqGf6x59IE8g7J+cyrJOXHhJPs5qVYn87gKCNNnPo8mzMxFQdjV6Htm8CFG4LUhTeEtz4+KTB1X1x1qypkYQ7QFQO5MxdUA1liOg+4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NYCSuEW7nmS30SnQsCkLbY+EhA6xHCxFQTPHZ/DqP78=;
 b=X0rOFJAt2Kc1dxToD2Bm9i3B2m+0uZE9fkbqSt5L5CWf9t/h3lgeE5RyCZgQRvhhF5LeRe1AWco2aF4MIBycA7DXIwZyQkIz6DjTpBpM5tUyNwRECyFk5WGMGYoF94Ubd4vh4UkBGmkxoPPWbsAszj6mvKP241w5OZeETRKijAlZswfhL9hOGG9cO2O2g3ktsiZLY64719RzU9e5KSVfMkRNs5YxTPO79nUDaAPz15WrLF2WeyaQLbNiA4vxtgqZ3zongnwmcs5Lk24Qoho666H9aZN1njduCx7oajLFrv34rcwlOA3qEDE6St5czAz31s3MOM9GupEMLLWHntOiuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NYCSuEW7nmS30SnQsCkLbY+EhA6xHCxFQTPHZ/DqP78=;
 b=MtQuVJBwQrEp2DZoSNKLXyv2KjGub2cKl6Tf2sMttC9sTwSiq2Ay5pwv6CZv9W1t4dcQxvPZeKcN9pbaOeXOaj1UBUlt6k1zI5kwQihhKqA3WzacrJLUNl3qi2wsu2HW/i6qLZo7SAVY/GSthwisx2olg4TbVa3BRLdKEdge3J0=
Received: from BN8PR12CA0002.namprd12.prod.outlook.com (2603:10b6:408:60::15)
 by PH7PR12MB5856.namprd12.prod.outlook.com (2603:10b6:510:1d7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Tue, 17 May
 2022 17:00:35 +0000
Received: from BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::21) by BN8PR12CA0002.outlook.office365.com
 (2603:10b6:408:60::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13 via Frontend
 Transport; Tue, 17 May 2022 17:00:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT063.mail.protection.outlook.com (10.13.177.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Tue, 17 May 2022 17:00:35 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 17 May
 2022 12:00:34 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amd: Don't reset dGPUs if the system is going to s2idle
Date: Tue, 17 May 2022 12:00:37 -0500
Message-ID: <20220517170037.6505-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b13f3f92-75b7-4a82-1c40-08da3826c2af
X-MS-TrafficTypeDiagnostic: PH7PR12MB5856:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB58565DC5009D63841F6445B3E2CE9@PH7PR12MB5856.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pa6bfgc94gpKGs5qqAVW6NC1qgcHyyoOsETvByEgzCkbZ530WEEH5svuDMVnf925Y80Pr9SnyhuWG6SivdRGpK/1qgRwjrrOCb7rc9pemHIbaueYEDSHySfy9o6ukteEIW91qZbl3080F2ZBXh7fuJRrD51i1/bZrPb6jNuR1Q6PugKfM8jjp1EIBnhsC6WKFlxWlj4VN5v4IErmMkE1qqJuA74hcV2iuXt0wNkyU/4L9e9eT0eVqB99QFEMWzDk3QJT0Y9GPUYPEAwnorLUUYiCAw+kclNRrb3j8llm39VeyXQZhtZa08R0lvC5QiNJJhD9LRn7iuBvSk0sRALWAiq+QyItFPPDm+rokj5jYynhBCNLUvV1df5GeqzsvuetpovCVMD89hCh2jzmsE9F0je/SJUXyYDZ5A4OGJEHYkLkkqFP4Bda99qKRlef1Up8WQ/nMRYfk/oIeAkGpCSRE4PuycS+cuSIy9nMiQWBsGRg3ZIbJ4STXlGmTyJr7qYiTxr8BJdo27E+Src6WUl2tiAs7x2GHbgk77Lunbgx6hxAlBjLCIR22qAOdbH/u72Id5Lni1XzzXMLc3hpKZkF8gSp2UYsYLKmx8GGz0K0p0xNnB38FpdOuMZbqB2vU8ZgjOdje+RVLtkm6Ao8+ZGmLQipMw3oyRj4uI5NFkLsp23x3cl8wLfBFQ9+4jaHlEwKfxaRzWkPF2GC6BttKMNYrw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(316002)(36860700001)(6916009)(82310400005)(26005)(36756003)(186003)(336012)(426003)(4326008)(16526019)(44832011)(40460700003)(7696005)(8936002)(966005)(70586007)(70206006)(508600001)(5660300002)(86362001)(83380400001)(47076005)(81166007)(356005)(1076003)(2616005)(2906002)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 17:00:35.1733 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b13f3f92-75b7-4a82-1c40-08da3826c2af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5856
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

An A+A configuration on ASUS ROG Strix G513QY proves that the ASIC
reset for handling aborted suspend can't work with s2idle.

This functionality was introduced in commit daf8de0874ab5b ("drm/amdgpu:
always reset the asic in suspend (v2)").  A few other commits have
gone on top of the ASIC reset, but this still doesn't work on the A+A
configuration in s2idle.

Avoid doing the reset on dGPUs specifically when using s2idle.

Fixes: daf8de0874ab5b ("drm/amdgpu: always reset the asic in suspend (v2)")
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2008
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * Add missing stub function for non CONFIG_ACPI case

 drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 14 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  |  2 +-
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 3c20c2eadf4e..76df583663c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1378,9 +1378,11 @@ static inline int amdgpu_acpi_smart_shift_update(struct drm_device *dev,
 
 #if defined(CONFIG_ACPI) && defined(CONFIG_SUSPEND)
 bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev);
+bool amdgpu_acpi_should_gpu_reset(struct amdgpu_device *adev);
 bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev);
 #else
 static inline bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev) { return false; }
+static inline bool amdgpu_acpi_should_gpu_reset(struct amdgpu_device *adev) { return false; }
 static inline bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev) { return false; }
 #endif
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index 0e12315fa0cb..98ac53ee6bb5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -1045,6 +1045,20 @@ bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev)
 		(pm_suspend_target_state == PM_SUSPEND_MEM);
 }
 
+/**
+ * amdgpu_acpi_should_gpu_reset
+ *
+ * @adev: amdgpu_device_pointer
+ *
+ * returns true if should reset GPU, false if not
+ */
+bool amdgpu_acpi_should_gpu_reset(struct amdgpu_device *adev)
+{
+	if (adev->flags & AMD_IS_APU)
+		return false;
+	return pm_suspend_target_state != PM_SUSPEND_TO_IDLE;
+}
+
 /**
  * amdgpu_acpi_is_s0ix_active
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 16871baee784..a84766c13ac5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2315,7 +2315,7 @@ static int amdgpu_pmops_suspend_noirq(struct device *dev)
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(drm_dev);
 
-	if (!adev->in_s0ix)
+	if (amdgpu_acpi_should_gpu_reset(adev))
 		return amdgpu_asic_reset(adev);
 
 	return 0;
-- 
2.25.1

