Return-Path: <SRS0=UpsA=OS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E32FC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:46:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E69560F23
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:46:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6E69560F23
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1239B6E8ED;
	Tue, 28 Sep 2021 16:46:47 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FBD46E8F4
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Sep 2021 16:46:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cVa0mOaXQb5GbKf4XTTyPj8EKS/yf2CM437aaFojSZZJnjpfM/aj9nxouFnEeVihiJ4rkZN9mvzcUK2+P0Ea34rIwxt9VoQ7U/K1SuqHvI6Pr+CGBQ1189hN4agDJpdl5HspeoHZmFn/cwc/BLYI5TlIlqWEvWGtX5q+107TmOI1omUKyoTlfe2Ji4F5LgS+wm/+AeaB/4NWmfVzFZvJUdCKb4566/bp0C71Gz4ct8+AUVTQkr6vH+ozxRndT5FNkAZJwXzR9bX57z/YwS13yJGfe2fAWvavCplGTitxnTwWuR/bynplVzCHzLQt3EzIwiQEHjeAKn8SSO3lRoKzXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=IphAP85ZXOHcEAZuOc2W4vEtRzqpyfuM8YL78OIQHOY=;
 b=JvEzNdcU+dtpwMFkUXTILm3PX338VQBaZ439aLi54NcTfRk2ezjgJORHjpZPK+MHOOUtTFEGDY0YoYGM0rFwSUzTo5kEznFwjgs44SE1CrIbWv6e9e9/0ua981y2i5jzF1zCz7Kh388mRxsqbF0HZ9pAUos6VoF9ciOPWB9DmvioQiQtSqK19fK8XSdTJLVpWPj7MNJQPgDIyHgN4Xf++M67xUJ3JabMZ2H5YE7MUGN2TxIV8CBbKvLHu8LyPY/Ab8xWmPAvC0FQwOVBcofWSxPzsG6coKVtC/rXCOC7qOZBRrKczOazJqP86BVUyyj6ZOG+vG6zv/frSBD/YMJ0ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IphAP85ZXOHcEAZuOc2W4vEtRzqpyfuM8YL78OIQHOY=;
 b=McmIDG6MUbCXdMEl+Z1LlbNzN7GgXwaW/vNdwF3qlJOKyWqQUSpRoCw+s0DsK5VoIDHrOr+HPM1tHkFHDyvUJoSPJ54dB/0BzdQkJwJOpPX/X74qN8vOM/h7rV6kIUpydjM/5X8vqH2HmiXsKjG2JYgbz7xRsl0BOQ6yE1Yv1IQ=
Received: from DM5PR07CA0163.namprd07.prod.outlook.com (2603:10b6:3:ee::29) by
 DM6PR12MB3514.namprd12.prod.outlook.com (2603:10b6:5:183::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.15; Tue, 28 Sep 2021 16:46:43 +0000
Received: from DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ee:cafe::5f) by DM5PR07CA0163.outlook.office365.com
 (2603:10b6:3:ee::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Tue, 28 Sep 2021 16:46:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT052.mail.protection.outlook.com (10.13.172.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Tue, 28 Sep 2021 16:46:42 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 28 Sep
 2021 11:46:38 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 62/64] drm/amdkfd: clean up parameters in kgd2kfd_probe
Date: Tue, 28 Sep 2021 12:42:35 -0400
Message-ID: <20210928164237.833132-63-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210928164237.833132-1-alexander.deucher@amd.com>
References: <20210928164237.833132-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf3a630f-5a3f-4fc4-fe5d-08d9829f8d17
X-MS-TrafficTypeDiagnostic: DM6PR12MB3514:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3514B6EC42856FE12236A86BF7A89@DM6PR12MB3514.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1091;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: swOo1KohsglXQYlgxDCa9kImytI4RhCtM1JBk2dWBV+NzjX/C0vXnZgEOwKEJy+qEK/hjIL/3zaBcnfCNuVVRxO/ZjxezxR2ssw+m0ueU8+yQFHb+G/dRt1NGPDgZD0KQ56iCovpFNvip+31SC0az8aeTjmFxAf0Ljknv873FUxwiKoKdJTMpB1MPGKTExjdGIFhRXJM/AVkP5sgAI6moFoGsFNXWOtgsphjOeHNVpB+a8+X5K3f99iYwyn8yZBmFFNg8JISdfJBpj5qVt5+bn9vnVSLuxGsihM1tjhfSAONC55EEja6I542WxN/J0GAMwYLPwDfUXSYk1VZKh+dwtbxJn7hUhOnqdua7844tNt+N2HNAS0aNJlIqUMeQ+eGppv8lSI9+qE4Zk1VPka/Z4KHmsHsLIXyU1cD8NwjMtBaAAKDIu/Hh9a7eWyfg3rHl+znTa1K2YI/sL1DIIeIh2EnlYtSKEjqxSjdoGhuC+1cXG17EkB/oPmU0B/cV5Dqgcf4RQ7qfdNEBfJFWooVS2eELeSrKMdqjIV1GeGs38nTkEmYcFl/x6a3Un+QCo3HjpOk0wJA3IIpIv5ragUmFqF/NN9+wDU6GDDIE2ND2VgIR54h5Mm5Te15yrb6bRtRn3fWyUVol3hUc+EsDiZBGGGmXVdYcETiJMdiDOmNuTJ82U0OevOPhVtRBcc5BuXUdPFC6It7mOkgvo1wXR1/xOFV6fV40qkVRK6ERDhJF3A=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(426003)(70586007)(82310400003)(83380400001)(336012)(4326008)(66574015)(508600001)(70206006)(2616005)(6666004)(356005)(8676002)(6916009)(86362001)(81166007)(47076005)(54906003)(36756003)(5660300002)(186003)(36860700001)(316002)(7696005)(8936002)(26005)(2906002)(16526019)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 16:46:42.6797 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf3a630f-5a3f-4fc4-fe5d-08d9829f8d17
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3514
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

We can get the pdev and asic type from the adev.  No need
to pass them explicitly.

Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 3 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h | 3 +--
 drivers/gpu/drm/amd/amdkfd/kfd_device.c    | 7 +++++--
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 1d41c2c00623..ce60f42647bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -70,8 +70,7 @@ void amdgpu_amdkfd_device_probe(struct amdgpu_device *adev)
 	if (!kfd_initialized)
 		return;
 
-	adev->kfd.dev = kgd2kfd_probe((struct kgd_dev *)adev,
-				      adev->pdev, adev->asic_type, vf);
+	adev->kfd.dev = kgd2kfd_probe((struct kgd_dev *)adev, vf);
 
 	if (adev->kfd.dev)
 		amdgpu_amdkfd_total_mem_size += adev->gmc.real_vram_size;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 3bc52b2c604f..1f16bd772ca8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -321,8 +321,7 @@ int kgd2kfd_schedule_evict_and_restore_process(struct mm_struct *mm,
 #if IS_ENABLED(CONFIG_HSA_AMD)
 int kgd2kfd_init(void);
 void kgd2kfd_exit(void);
-struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd, struct pci_dev *pdev,
-			      unsigned int asic_type, bool vf);
+struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd, bool vf);
 bool kgd2kfd_device_init(struct kfd_dev *kfd,
 			 struct drm_device *ddev,
 			 const struct kgd2kfd_shared_resources *gpu_resources);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index c2a4d920da40..82af344cbf10 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -32,6 +32,7 @@
 #include "amdgpu_amdkfd.h"
 #include "kfd_smi_events.h"
 #include "kfd_migrate.h"
+#include "amdgpu.h"
 
 #define MQD_SIZE_ALIGNED 768
 
@@ -691,12 +692,14 @@ static void kfd_gtt_sa_fini(struct kfd_dev *kfd);
 
 static int kfd_resume(struct kfd_dev *kfd);
 
-struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd,
-	struct pci_dev *pdev, unsigned int asic_type, bool vf)
+struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd, bool vf)
 {
 	struct kfd_dev *kfd;
 	const struct kfd_device_info *device_info;
 	const struct kfd2kgd_calls *f2g;
+	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
+	unsigned int asic_type = adev->asic_type;
+	struct pci_dev *pdev = adev->pdev;
 
 	if (asic_type >= sizeof(kfd_supported_devices) / (sizeof(void *) * 2)
 		|| asic_type >= sizeof(kfd2kgd_funcs) / sizeof(void *)) {
-- 
2.31.1

