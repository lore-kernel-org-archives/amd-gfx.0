Return-Path: <SRS0=4FJE=CL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D73F1C433E2
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 18:42:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE7072083B
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 18:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="OzAfwI1t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE7072083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 766B86E047;
	Wed,  2 Sep 2020 18:42:43 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8FAE6E047
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2020 18:42:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RG1uA62vwsbER5ebHLI+bo8a+FrO3Y/oH+Fst6a216ZN7veYWmI6aYiGURROxeYXYGB1K1VkPDo4tdj2UC6k8SORSCwHpUslHU5qaFtN/pQ5ae6pSD+NMTTL1QBN+HyP7DI5tEPmiqxV8fDzqbtEtAIGe/IdL4WvMY1rvZYnvebI9giIDxJmssIGDxqV/8dn99BUakLQF6vsfoTZY4XWejQ64rA5+FRQBTPYrawBVw7pV5RwNlMLa0O8P5nU+q8H2flNvwAx0YNLACON3zB2YEEfBnVnKArHD1RHkhKcYw9T0Uvg11KQelGzt5FGjpvaAH9fmNlrmdgtTDbmMkfhzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NTnxDBdCjMml7DsteqWxDUwBtEIOI8fXmdrjUFclBps=;
 b=Ty2oaHtOsCOa9hVTBDp8gRoQq76EMrA7LGPy6qXXffUqglvaQiPncYTDmFOT78JtJlbD/tHu0VpM7cNJ9PJ1C/DgaKIVM21q1phtsAxmKoSB0k82jr+JUKCk+NZ6+WqXf3L9gPnq5NhyHhlWtg1BZP+hOMnFJE2ojAPq8/ermhvbNCTa/NrFhCeCRRDk0IehEUJ7BRYyPEyQovMtvh+i2MJwPVXFGF8Eu6vf8FFSgxcNd/hyb22KK+lSWzxj3eWXZDxawp07uIScMTLU4mAKSWfEgB9ctKLKiaryXIFIIx/beojynaP74njP7PnDC9fEMmA7biJ+cuKpqKzmZdB7Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NTnxDBdCjMml7DsteqWxDUwBtEIOI8fXmdrjUFclBps=;
 b=OzAfwI1tpgaNjDMrvdfcSnQWMmVyO3yMIcTBlamtyKYWP54WT09PLSYIdb8y4kckip5YSVcapuEqfnI1oSwiXo5M8HQpQt1byWgT9WXf9mfELGAIlW8KoW6YZRU+l/HHoD3TA87/AHZKu8wLTYn2Tz+kyubGjXEwxu3roxW/ps0=
Received: from BN6PR10CA0035.namprd10.prod.outlook.com (2603:10b6:404:109::21)
 by BY5PR12MB4307.namprd12.prod.outlook.com (2603:10b6:a03:20c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Wed, 2 Sep
 2020 18:42:40 +0000
Received: from BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:109:cafe::87) by BN6PR10CA0035.outlook.office365.com
 (2603:10b6:404:109::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend
 Transport; Wed, 2 Sep 2020 18:42:40 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT030.mail.protection.outlook.com (10.13.177.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3326.19 via Frontend Transport; Wed, 2 Sep 2020 18:42:39 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 2 Sep 2020
 13:42:39 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 2 Sep 2020
 13:42:39 -0500
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Wed, 2 Sep 2020 13:42:38 -0500
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>,
 <sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-pci@vger.kernel.org>
Subject: [PATCH v4 2/8] drm/amdgpu: Block all job scheduling activity during
 DPC recovery
Date: Wed, 2 Sep 2020 14:42:04 -0400
Message-ID: <1599072130-10043-3-git-send-email-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599072130-10043-1-git-send-email-andrey.grodzovsky@amd.com>
References: <1599072130-10043-1-git-send-email-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e175e72-182d-4cbc-b4f2-08d84f6ff831
X-MS-TrafficTypeDiagnostic: BY5PR12MB4307:
X-Microsoft-Antispam-PRVS: <BY5PR12MB430744C2172539D46A886F0AEA2F0@BY5PR12MB4307.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tnkp9fJ6uy+sv6ff8L02bB0Dyk7Crz65YxvsDehzyFLQN5GqgighmcRUZMnvU25E1Tw+ParZmRBGVN57t9/Lx556aIGPANVoAFMcuKu5e3lM6aXdz/WGVtA+Fi2gU0tlteFFlmSwUEh3N+/XnbI8SmHCsYX0YfBDSzoJUyQjCr0zL3wSMrq3jPBkAuaOX1HK9cklDjTzghgdVUO2mOax2u64pmyMsbBGeOQ6iOQ5oUS2mU+VoZs7bkEwyz6+hcjf/OGPW8SMTA1jvsza55KxtiBe1yBffU+OqY5X9rWAEP7jNps2/L054MHwIgn4n9njYE+vA/mFHlPI14iAZR2NHZeNz5sX/wHF/aeWz3kS3asmy32UWZc0rT9bpCLg0jv/LkSVJySceYdRO2ZcndFomw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(396003)(346002)(39860400002)(376002)(46966005)(336012)(7696005)(186003)(316002)(26005)(81166007)(356005)(6666004)(47076004)(426003)(82740400003)(44832011)(478600001)(86362001)(70586007)(5660300002)(70206006)(36756003)(82310400003)(2906002)(110136005)(54906003)(8936002)(2616005)(4326008)(83380400001)(8676002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 18:42:39.6466 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e175e72-182d-4cbc-b4f2-08d84f6ff831
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4307
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
Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>, nirmodas@amd.com,
 bhelgaas@google.com, luben.tuikov@amd.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, Dennis.Li@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

DPC recovery involves ASIC reset just as normal GPU recovery so block
SW GPU schedulers and wait on all concurrent GPU resets.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 57 +++++++++++++++++++++++++++---
 1 file changed, 53 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 1fbf8a1..e999f1f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4740,6 +4740,20 @@ int amdgpu_device_baco_exit(struct drm_device *dev)
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
@@ -4753,15 +4767,37 @@ pci_ers_result_t amdgpu_pci_error_detected(struct pci_dev *pdev, pci_channel_sta
 {
 	struct drm_device *dev = pci_get_drvdata(pdev);
 	struct amdgpu_device *adev = drm_to_adev(dev);
+	int i;
 
 	DRM_INFO("PCI error: detected callback, state(%d)!!\n", state);
 
 	switch (state) {
 	case pci_channel_io_normal:
 		return PCI_ERS_RESULT_CAN_RECOVER;
-	case pci_channel_io_frozen:
-		/* Fatal error, prepare for slot reset */
-		amdgpu_device_lock_adev(adev);
+	/* Fatal error, prepare for slot reset */
+	case pci_channel_io_frozen:		
+		/*		
+		 * Cancel and wait for all TDRs in progress if failing to
+		 * set  adev->in_gpu_reset in amdgpu_device_lock_adev
+		 *
+		 * Locking adev->reset_sem will prevent any external access
+		 * to GPU during PCI error recovery
+		 */
+		while (!amdgpu_device_lock_adev(adev, NULL))
+			amdgpu_cancel_all_tdr(adev);
+
+		/*
+		 * Block any work scheduling as we do for regular GPU reset
+		 * for the duration of the recovery
+		 */
+		for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
+			struct amdgpu_ring *ring = adev->rings[i];
+
+			if (!ring || !ring->sched.thread)
+				continue;
+
+			drm_sched_stop(&ring->sched, NULL);
+		}
 		return PCI_ERS_RESULT_NEED_RESET;
 	case pci_channel_io_perm_failure:
 		/* Permanent error, prepare for device removal */
@@ -4894,8 +4930,21 @@ void amdgpu_pci_resume(struct pci_dev *pdev)
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
