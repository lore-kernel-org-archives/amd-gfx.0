Return-Path: <SRS0=kQKQ=CG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC9D0C433E6
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2020 16:06:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90DC9207DF
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2020 16:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="USMxpyDC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90DC9207DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 288256E4EC;
	Fri, 28 Aug 2020 16:06:06 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 107E66E4CB
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2020 16:06:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YORhFthlR63u9RmgV1P/xn7bUN+mLBvxoBuwWbT4aTGNErdCNm+xkado5EpO2B+Jv6YucMwHh9nEJ9DsUSsI8sdsaH5mxMKe1XuB+/Lw6vOR5IeDaKaQPIe7FtnJIpUsXv2NhA3QfpMH/TBB0R256InIvOhkqJw3i3qhOsgr4y8nO/8ohOK/039OfBbBvvT0xVt6WA9TOBq+6TEOOuuyOgTlT3lc/n6eXz239c2QTw+a+fEBdShYXnwEDsF/xT1vvQC4GLnruovVN8v4d5UaBkjxTFcwvALB/grwspfrA6usjZi1tH8N6wt+MPbnsY3l69CofcpP6npqxfLiVw+R0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n70SOJcrj2gSLNmGF0nUUu0uQXfHtsIr5GMcoqQSzhA=;
 b=Tf7Q9QNRAjufL/R4lApnXbpMz1I6lJvxWQYSvWafkH8hp6GLqc+yngHWRv7MNNpWeMgUGrRpjaRrYYpRTEx3QPRZSXUS5F2MZa5uw1tBLmjrzXjk9oi+oas8uVjMw+m4rc8L6swCjAjTW+rziHv25noIULdQGoWwap7pPpPogaQpBkVNudwZq4eOZbaAB/b39jdZxEDddgBnJi+2sGJxXDx/fAFSeA3lX21wMeA1ijUyRD+VvCW3tVIlrNX/x0rqvk3Vut/WbEbD6IU2NRz7h4kKxMzBSlupNC6ctjs8+2NSDoS+6a12VHBgXEZJo1A8PTD9OTEtUNomggX2hBQ9UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n70SOJcrj2gSLNmGF0nUUu0uQXfHtsIr5GMcoqQSzhA=;
 b=USMxpyDCRFPEXCZZvSmCeE0gSNMWHPIxE1mGmmFImUGeDLld0CGGdalF5uWQPdSaCgA24iZIB9NaWcEMqUuDvmzdyygJr801pm0zXIoDpGEFMMlla1HzUW/wbo3c2RboaHXe7W5se5oIjTBqWSgsLpOVFzLUyVLw7jH60JhJtrk=
Received: from MWHPR18CA0048.namprd18.prod.outlook.com (2603:10b6:320:31::34)
 by DM6PR12MB2603.namprd12.prod.outlook.com (2603:10b6:5:49::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Fri, 28 Aug
 2020 16:05:59 +0000
Received: from CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:320:31:cafe::d8) by MWHPR18CA0048.outlook.office365.com
 (2603:10b6:320:31::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Fri, 28 Aug 2020 16:05:59 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT016.mail.protection.outlook.com (10.13.175.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3326.19 via Frontend Transport; Fri, 28 Aug 2020 16:05:59 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 28 Aug
 2020 11:05:56 -0500
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 28 Aug 2020 11:05:55 -0500
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 3/7] drm/amdgpu: Block all job scheduling activity during
 DPC recovery
Date: Fri, 28 Aug 2020 12:05:39 -0400
Message-ID: <1598630743-21155-4-git-send-email-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598630743-21155-1-git-send-email-andrey.grodzovsky@amd.com>
References: <1598630743-21155-1-git-send-email-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c18f9d34-1a50-4c82-7e54-08d84b6c4108
X-MS-TrafficTypeDiagnostic: DM6PR12MB2603:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2603852B769B8F82306ADC33EA520@DM6PR12MB2603.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +wmdSD/Ku6EHKdqS9OYce5ZxdPR+4/UM+AQkk9I8qS2+5yEGvE4rWQZxk9i4AlaEhEUDKkb455UgyXw9QcIpes2Avatxk/BaeMk2StL7y/CY8fCqNz/5ewXqh1h2zILD2p04Zt8JI3oVQ6bKlWkagXIsJHA9Rq+psF5e40A00njUgFx9GFVaWWzMDZKCP56XgLCyhjVTgVj3iJupnICXA+KbDqx/66jXvhEa5z9+JvyyWujKoxkcyDHKqU8DgZWPtWmwP8GbteMmoSBQHhwt9hyY+ofn4/eU0Vs7NuzOekqgKGiYy57wyA20ufqaLOtSTpDPUc2xOV7/6ztKXYocyRJeL5OhXceIiQ/8T8pz2SfVIKhFFAayvNOJLFmA4be0vvYgiL7ZNaBhH13j3FMQYw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(46966005)(6666004)(2616005)(36756003)(7696005)(54906003)(426003)(81166007)(336012)(356005)(4326008)(86362001)(82740400003)(316002)(83380400001)(186003)(26005)(82310400002)(8936002)(44832011)(2906002)(478600001)(8676002)(70206006)(6916009)(47076004)(70586007)(5660300002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2020 16:05:59.0982 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c18f9d34-1a50-4c82-7e54-08d84b6c4108
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2603
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
Cc: alexander.deucher@amd.com, Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 nirmodas@amd.com, christian.koenig@amd.com, Dennis.Li@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

DPC recovery involves ASIC reset just as normal GPU recovery so blosk
SW GPU scedulers and wait on all concurent GPU resets.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 57 +++++++++++++++++++++++++++---
 1 file changed, 53 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index e67cbf2..9a367a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4745,6 +4745,20 @@ int amdgpu_device_baco_exit(struct drm_device *dev)
 	return 0;
 }
 
+static void amdgpu_cancel_all_tdr(struct amdgpu_device *adev)
+{
+	int i;
+
+	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
+		struct amdgpu_ring *ring = adev->rings[i];
+
+		if (!ring || !ring->sched.thread)
+			continue;
+
+		cancel_delayed_work_sync(&ring->sched.work_tdr);
+	}
+}
+
 /**
  * amdgpu_pci_error_detected - Called when a PCI error is detected.
  * @pdev: PCI device struct
@@ -4758,16 +4772,38 @@ pci_ers_result_t amdgpu_pci_error_detected(struct pci_dev *pdev, pci_channel_sta
 {
 	struct drm_device *dev = pci_get_drvdata(pdev);
 	struct amdgpu_device *adev = drm_to_adev(dev);
+	int i;
 
 	DRM_INFO("PCI error: detected callback, state(%d)!!\n", state);
 
 	switch (state) {
 	case pci_channel_io_normal:
 		return PCI_ERS_RESULT_CAN_RECOVER;
-	case pci_channel_io_frozen: {
-		/* Fatal error, prepare for slot reset */
+	case pci_channel_io_frozen: { /* Fatal error, prepare for slot reset */
+
+		/*
+		 * Cancel and wait for all TDRs in progress if failing to
+		 * set  adev->in_gpu_reset in amdgpu_device_lock_adev
+		 *
+		 * Locking adev->reset_sem will perevent any external access
+		 * to GPU during PCI error recovery
+		 */
+		while (!amdgpu_device_lock_adev(adev, NULL))
+			amdgpu_cancel_all_tdr(adev);
+
+		/*
+		 * Block any work scheduling as we do for regualr GPU reset
+		 * for the duration of the recoveryq
+		 */
+		for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
+			struct amdgpu_ring *ring = adev->rings[i];
+
+			if (!ring || !ring->sched.thread)
+				continue;
+
+			drm_sched_stop(&ring->sched, NULL);
+		}
 
-		amdgpu_device_lock_adev(adev);
 		return PCI_ERS_RESULT_NEED_RESET;
 	}
 	case pci_channel_io_perm_failure:
@@ -4900,8 +4936,21 @@ void amdgpu_pci_resume(struct pci_dev *pdev)
 {
 	struct drm_device *dev = pci_get_drvdata(pdev);
 	struct amdgpu_device *adev = drm_to_adev(dev);
+	int i;
 
-	amdgpu_device_unlock_adev(adev);
 
 	DRM_INFO("PCI error: resume callback!!\n");
+
+	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
+		struct amdgpu_ring *ring = adev->rings[i];
+
+		if (!ring || !ring->sched.thread)
+			continue;
+
+
+		drm_sched_resubmit_jobs(&ring->sched);
+		drm_sched_start(&ring->sched, true);
+	}
+
+	amdgpu_device_unlock_adev(adev);
 }
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
