Return-Path: <SRS0=2AtA=PH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FE1C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 21:15:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C359760F8F
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 21:15:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C359760F8F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DE206E97D;
	Tue, 19 Oct 2021 21:15:07 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBD956E8E9
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Oct 2021 21:15:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K5RWoBMXP5HbHIoM3bi4U6t7rbeS9FEl/qL15srWEkhbG5MQ/UaTiVGAN7uleNC5VncQ+YrvjhFVBH9osV8mt9qM0BgibtQWYNbCuBtan3b+SZRsKJ6zZgIjAtBEaoBfwfDKQNSWBjeiEA6/Y0ZiNluEMLMl9gw8Rt24TCmzk0La9+rnsCAOV4sDcg30x888FyvgEXx94hu5CWIpI/oinj8fEf+BhLhuSxC6bDXSWkWptWfb2mR1zsTq4w3SSKkeLNCZ1Bo93yGeMf072dl1AtrYutWz7rdAzD83191vj7Nv9WQgDe4NRoSFR6M79s1k7Bqt4AkER+rEeeRFQ334MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mMjBjrWFus1Q8oTqaDqygQJKJIo9zmUKdKLGHy9CNlc=;
 b=Vtme21ctuFtbpF1PAC7AQ5VKRqmyzPIDpSBZofVQ0Hh64eE3jE/Ma09t8yPNL8A/sAI8Y+xMn4S+dixCtEn5vvnabhRNENu7hGlLk4OjjcLaXlJG6/sj8e+7AJ6qlhUFX3cUX6fnom/IrlNv7WziCuofK4djS2aZbLO6j3gY0L8DwG2CPSFhvtctr4M1QSc4J0vxawWmgN3O8xSF/koRoRYzUQS9UIFBQppNW+e9gAMyI9U/T1cdCb5rW3JKcpdupEAHR84BmIWfQIR5GhRBqcpnPhSGdxNbaTbB0h30WIv8eTu4SsaKP1ijR4B1ozTde22AK6hmRW26oRjRmC38xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mMjBjrWFus1Q8oTqaDqygQJKJIo9zmUKdKLGHy9CNlc=;
 b=C8diF0oh2QjnlgbKuBytsu4Y+6X8ggyohOKPu2BdAQ2jLXOzIUH0bizF5zhciYJ2ilVxRYqTs94ErjwEpozU16JchjInzvqtdjNDwmN2qBp668yo7gk7cTvX7XGQV59XAhx4RmI4dmANksKMD7VpAotSenne5cH47H9rFLXmFkw=
Received: from BN9PR03CA0305.namprd03.prod.outlook.com (2603:10b6:408:112::10)
 by BL1PR12MB5128.namprd12.prod.outlook.com (2603:10b6:208:316::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Tue, 19 Oct
 2021 21:15:03 +0000
Received: from BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::11) by BN9PR03CA0305.outlook.office365.com
 (2603:10b6:408:112::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend
 Transport; Tue, 19 Oct 2021 21:15:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT020.mail.protection.outlook.com (10.13.176.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Tue, 19 Oct 2021 21:15:03 +0000
Received: from mkgs-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Tue, 19 Oct
 2021 16:15:01 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <mukul.joshi@amd.com>, Graham Sider
 <Graham.Sider@amd.com>
Subject: [PATCH 13/13] drm/amdkfd: remove kgd_dev declaration and
 initialization
Date: Tue, 19 Oct 2021 17:13:34 -0400
Message-ID: <20211019211334.1552825-13-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211019211334.1552825-1-Graham.Sider@amd.com>
References: <20211019211334.1552825-1-Graham.Sider@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dfb8cbf4-a343-4bbe-9a6b-08d9934584ae
X-MS-TrafficTypeDiagnostic: BL1PR12MB5128:
X-Microsoft-Antispam-PRVS: <BL1PR12MB51283BAF99FEEA8E6F4A8F138ABD9@BL1PR12MB5128.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:127;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L8dmfm21mfzAJSq70ILUaTNwPken640y9AeTF2QwHxxYOCy1rIS9T18NVozijoorLpL6qESYmbGaEqDK/oP86xFl5ZPdDQJJWUBIqM/IXfUNwva5eQz5X7oCSWoL/jnxPX1kRhKYpj2ifNmQHf6vl1I7Ux9EBWChAgrWBYID9B48iVC+wwiH/wfrn1bn76d0kfrnxBsr4zh+CjwwVVn5yHKBthoc8vy02208TufFVYoPyLEoJyZWroEzJxSx1tEB++T0tuKcaGuL2+4iGllHUjfjMhDt3Ra/1WqnwFy35Wt1V5u4+oQaOz2tOOPOcIwxFcSSlfix+nNftubqxxO33+nA9auIvCv8GL27Rwtpxl9owAS5aJzbnLG2z0IpVbC8WtDHIXdYQLWYszdowr+idqwA1osrce9NjI1savZM/stst90kk7NkJ6dTs1w2MhuwjOHDUzDfhs71d4r5wQkx8cmnTWxQGZwlS4jGJcDmKRnvFrZ3p5o0MjJzeD8tZYpVTt8MWvaFZOvD4XjmrG0HpNnIJuJcvn9GOVhlS1K82/j3xPYMeVbeq+H2Fq8YQM7uTq3MYqVarQ/bSWQ20Xbdqo50JBXvTRkiZsaCaMp4JlaEaoHQUCyT8AVwxPTiHSTT7FyIp2yQ6pXOqOnM3Pcew1QUwewW/Zr9LyuFd2jYAFHf1r4XnMIry2e8u2relaeqCAfxHWBFaZfoPVaho6GwYtV1sQIauRVvCXOeheug4xs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(8676002)(86362001)(36860700001)(8936002)(36756003)(82310400003)(316002)(26005)(83380400001)(1076003)(54906003)(70586007)(70206006)(16526019)(186003)(81166007)(2616005)(336012)(426003)(5660300002)(7696005)(6916009)(508600001)(4326008)(47076005)(2906002)(6666004)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 21:15:03.7277 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfb8cbf4-a343-4bbe-9a6b-08d9934584ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5128
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

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c      | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h      | 4 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_device.c         | 4 +---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h           | 1 -
 drivers/gpu/drm/amd/include/kgd_kfd_interface.h | 2 --
 5 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 79a2e37baa59..83f863dca7af 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -72,7 +72,7 @@ void amdgpu_amdkfd_device_probe(struct amdgpu_device *adev)
 	if (!kfd_initialized)
 		return;
 
-	adev->kfd.dev = kgd2kfd_probe((struct kgd_dev *)adev, vf);
+	adev->kfd.dev = kgd2kfd_probe(adev, vf);
 
 	if (adev->kfd.dev)
 		amdgpu_amdkfd_total_mem_size += adev->gmc.real_vram_size;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 35f703dda034..8c1ba8f258c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -331,7 +331,7 @@ int kgd2kfd_schedule_evict_and_restore_process(struct mm_struct *mm,
 #if IS_ENABLED(CONFIG_HSA_AMD)
 int kgd2kfd_init(void);
 void kgd2kfd_exit(void);
-struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd, bool vf);
+struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf);
 bool kgd2kfd_device_init(struct kfd_dev *kfd,
 			 struct drm_device *ddev,
 			 const struct kgd2kfd_shared_resources *gpu_resources);
@@ -355,7 +355,7 @@ static inline void kgd2kfd_exit(void)
 }
 
 static inline
-struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd, bool vf)
+struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
 {
 	return NULL;
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 402891a02a01..7677ced16a27 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -627,12 +627,11 @@ static void kfd_gtt_sa_fini(struct kfd_dev *kfd);
 
 static int kfd_resume(struct kfd_dev *kfd);
 
-struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd, bool vf)
+struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
 {
 	struct kfd_dev *kfd;
 	const struct kfd_device_info *device_info;
 	const struct kfd2kgd_calls *f2g;
-	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
 	struct pci_dev *pdev = adev->pdev;
 
 	switch (adev->asic_type) {
@@ -824,7 +823,6 @@ struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd, bool vf)
 	if (!kfd)
 		return NULL;
 
-	kfd->kgd = kgd;
 	kfd->adev = adev;
 	kfd->device_info = device_info;
 	kfd->pdev = pdev;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 1fbc28c34c4c..32307b9f1ec2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -228,7 +228,6 @@ struct kfd_vmid_info {
 };
 
 struct kfd_dev {
-	struct kgd_dev *kgd;
 	struct amdgpu_device *adev;
 
 	const struct kfd_device_info *device_info;
diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
index 8f4f3a1700e8..ac941f62cbed 100644
--- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
@@ -38,8 +38,6 @@ struct amdgpu_device;
 #define KGD_MAX_QUEUES 128
 
 struct kfd_dev;
-struct kgd_dev;
-
 struct kgd_mem;
 
 enum kfd_preempt_type {
-- 
2.25.1

