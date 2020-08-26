Return-Path: <SRS0=g3tc=CE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5DCC433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2020 14:46:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 922732078D
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2020 14:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="2ygUtvPf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 922732078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35A556EA85;
	Wed, 26 Aug 2020 14:46:46 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB2DC6EA85
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2020 14:46:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VaJWoMfFmsfTK0P83vF2tu2j1l5XZUfOuZduaHuzLdZ2gSlczZXJMV0021mRxIT5+qW8jVSB0GHEvp607RmPTBG69/Z/k9WMM55+InXAgzPq5TDA0MNOWz2a6/FMD1sQQuphoqetdyjGeQ0nFc9gOnDzIe4e+iM751jc/AbiVarxJ7YgJrkdMydv6oNO5PykgYBh5OV+YTWhNbwbq4OH1ShMB7IqyuccbdRJI5GdSnsDMQBTRCYniM7d23saKOs3m03bdovGGoSeD551OdO7zw7ge+qMiAdfkDixALOhADoEnw66HrxzDXqz2LEJvSSkqXXsa3W60WxCcPQA1YWo9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sNY662QEMh0iiqQidmzhwo8OGfaOnDp6Svz7y9Efh2Q=;
 b=XlDQ/rSTqbcV8Yq7cSQiu8WxIz1UlMVviE/EEWKSqValKr2+WARTMkxbqoJAfUbFi9QB6Pz1+a3p40ZmvPGFuKkRt65J84g9FQG/qb6VR0tCHsY0m6SY/qCPFFazITQzaNuraPPz2nouKoLBZpANYpVvVYmL5cfe29EtpyNWPiQ0iJMyqsm/mcngykJj2c21607Dksrcpyd9aGQf0NrpIORTBz8plRyVffj/JO8N5kRN1vZdyqwHCP3ejsTYHDwWI9C627Yj+O+6bYVqFvWndgDUyUt4/79ymYYtIlDDRVlYeTeNg0q2q0rdbRnkDhYLim0XHYZxyP8BV4PMJ9wx/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sNY662QEMh0iiqQidmzhwo8OGfaOnDp6Svz7y9Efh2Q=;
 b=2ygUtvPfLebPcXk/wwvuE/ON3cFe/ZLs9zpiqMPes9agm8ON4GQXR1aIgyMr7aSkwEiIjn3ZcD70O1rudUdUIn1BipldituHoV61heYGd4rtp8YRACqKmvblZ1+Tga5CrDWo+VRjq1ki+IIbX/B6llkh/TK4/ybKquSkBeR/WyE=
Received: from MWHPR14CA0061.namprd14.prod.outlook.com (2603:10b6:300:81::23)
 by DM6PR12MB3674.namprd12.prod.outlook.com (2603:10b6:5:1c4::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Wed, 26 Aug
 2020 14:46:42 +0000
Received: from CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:81:cafe::32) by MWHPR14CA0061.outlook.office365.com
 (2603:10b6:300:81::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Wed, 26 Aug 2020 14:46:41 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT066.mail.protection.outlook.com (10.13.175.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3326.19 via Frontend Transport; Wed, 26 Aug 2020 14:46:41 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 26 Aug
 2020 09:46:34 -0500
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Wed, 26 Aug 2020 09:46:34 -0500
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/7] drm/amdgpu: Block all job scheduling activity during DPC
 recovery
Date: Wed, 26 Aug 2020 10:46:18 -0400
Message-ID: <1598453182-6946-4-git-send-email-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598453182-6946-1-git-send-email-andrey.grodzovsky@amd.com>
References: <1598453182-6946-1-git-send-email-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62b7bcf0-0349-4025-0625-08d849ced892
X-MS-TrafficTypeDiagnostic: DM6PR12MB3674:
X-Microsoft-Antispam-PRVS: <DM6PR12MB36747DACB5BE30DA0A5981E4EA540@DM6PR12MB3674.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: COAMXwyvkUZ3kZI8r9kxpl8LvawQbb8Y5jf6amf9PjsSLCXOvUSSBTECq+jaII5ITDvxzGTPK+Pfde3p4ZsY1js4cdBFADJoCAZizHjUoAWhzIthiaHojS03miduAA1BlICejKzkj5saEB7tgaVXTJiUTm4HUFReW4Oa1xTtYDsYwkK2veqe0BSsKaZPw9tGDY/f4DUB0raegKYLyr1khd2Q0J5x3r8WQ1xtx6DK264ekd9Na/T7uoXQwZz2xi3zOhdWTNFLgQXjWcRXuP14F3V7kjfkGAKEQYhTkEAsS1E8SmaUn3TZYb2i/ZtIiWiN9kg7y+v+94MC50Tz+3wBMCbz3xgU/tYB9lNuMVZBEmiAZWyGvhHJEurDYaXhaRzlPtYYerEyxhsz5/eiHnxTmA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(396003)(136003)(346002)(46966005)(26005)(356005)(4326008)(2616005)(478600001)(44832011)(83380400001)(7696005)(5660300002)(186003)(6666004)(8676002)(82740400003)(86362001)(54906003)(70586007)(336012)(47076004)(82310400002)(36756003)(70206006)(426003)(2906002)(6916009)(81166007)(8936002)(316002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2020 14:46:41.6905 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62b7bcf0-0349-4025-0625-08d849ced892
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3674
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
 nirmodas@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

DPC recovery involves ASIC reset just as normal GPU recovery so block
SW GPU shcedulers and wait on all concurent GPU resets.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 57 +++++++++++++++++++++++++++---
 1 file changed, 53 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index e1bbefd..0a2130b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4747,6 +4747,20 @@ int amdgpu_device_baco_exit(struct drm_device *dev)
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
@@ -4760,16 +4774,38 @@ pci_ers_result_t amdgpu_pci_error_detected(struct pci_dev *pdev, pci_channel_sta
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
@@ -4902,8 +4938,21 @@ void amdgpu_pci_resume(struct pci_dev *pdev)
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
