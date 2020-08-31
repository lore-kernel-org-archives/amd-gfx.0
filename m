Return-Path: <SRS0=7vr2=CJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC8DC433E6
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2020 15:51:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A520420719
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2020 15:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="a6DAMdXu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A520420719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3168C89BFE;
	Mon, 31 Aug 2020 15:51:06 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760051.outbound.protection.outlook.com [40.107.76.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A8D689BFE
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2020 15:51:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CpJbx9IebYyKpysGFj3uXMCH95y+dGZEEx41qJnVZ/2T7zS66j33h7j8vBadTV03OF5u/1cdrj1a2WEpqYBPtSA2jhOqjzjNko3YkOlCbAD5dVwex1JR7w9nM5DmhVS25fAbZdlHSlvmlN0mnpX96f6T9V/ciF930XOvvd4pD7VLSprkr3C2b+jJ1MVE+NQmtjvnZme1AY4uv+iha9cBpZfR7A9HiInNDMDJ45bQk5iDRCiOiEPEto3+c10N+XJ2J1k93AxRSOGCIyb6szJJyBFd2wRbF+p+wGvNrIRXqAdyng1BpdreTh+eScm+bl631VO+e6rSUJSx0V3viDEDmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7y6lHIkVx+mP43GMhHby8/pQ11JMKda+IRkixvflGrI=;
 b=kTMtB77Qwu0YZIZCQ8WVkNgpfY0aabhDjvicjSWrTH5eapw326oI0Xmg1bfKsPiKE0GePcPZyunQ7v5C/wsXj+VWYhTMk1BYrpQg60g9rTA1njWVTmSFq8JwqbHwB6HW+wNyrCofIGBOxOjOA7D9Yy7S7IK9Yx/McN9lOUCm1WGACOQLZp8nSv6o2WCtOWQb+V5ZtDcMOHgVvEua/O8KjQCx/gRxHf58b96vfjpf+QXfQ3ICZirvmhRpe0sG2Zzkw0O3izJE9BXuwSdwtArDS7muoBQQQApyVqbPKywX3pQ1mzt1bo8D0ft8KTClaH6Wpv75fdlYuaPKtkRMjvAaUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7y6lHIkVx+mP43GMhHby8/pQ11JMKda+IRkixvflGrI=;
 b=a6DAMdXuwL8Ev7luOXr+B67o9SY/FiBIXiBSzlYXZG1WWtNTY8gipKQ0Sp9qOAQI5TQoXk9AzTiqZMaGgRlzvnMhiRQAZXaJc0YR0aneNi3l3bLJIyPH99ndGCnk/2SYagBsRRGf37/6dZGG2wXNU0YpDxp34pRJn+O1In3w/ZY=
Received: from DM5PR07CA0165.namprd07.prod.outlook.com (2603:10b6:3:ee::31) by
 MWHPR1201MB2557.namprd12.prod.outlook.com (2603:10b6:300:e4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Mon, 31 Aug
 2020 15:51:03 +0000
Received: from DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ee:cafe::1a) by DM5PR07CA0165.outlook.office365.com
 (2603:10b6:3:ee::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Mon, 31 Aug 2020 15:51:03 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT062.mail.protection.outlook.com (10.13.173.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3326.19 via Frontend Transport; Mon, 31 Aug 2020 15:51:03 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 31 Aug
 2020 10:50:59 -0500
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Mon, 31 Aug 2020 10:50:58 -0500
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 3/8] drm/amdgpu: Block all job scheduling activity during
 DPC recovery
Date: Mon, 31 Aug 2020 11:50:44 -0400
Message-ID: <1598889049-28321-4-git-send-email-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598889049-28321-1-git-send-email-andrey.grodzovsky@amd.com>
References: <1598889049-28321-1-git-send-email-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 873fab74-cdf4-422e-cd2d-08d84dc5aa2a
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2557:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB25579CBD3299930E116037BEEA510@MWHPR1201MB2557.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NjsMQ7EqVMXnG2ch7buPqWSG9CCZZYbvVZ6VvJrjcCmnFo7pp5fnq9bDNGzSb+Qz3SZVLcAWL5mcjwI4nJ4LblGL4Gb9OyaX98YFzoCC0Y32Bqay2oGC2jYOwq71eDBqSlfPMHx0jusB0Ais/fKv1wwW8tZOes2D9dU9XIiIW5qHjTWuXUFq9FTuV29dVkVVUzo3f3l1n2WPLyy9YL6T7xu2avRLH3o87TT2KUEEktk6ThqkoQs8/Ag1xN5kn60zCW98jCr8geJVI86ZwbrrBcgPHrZQBJYdRx7Ua+QudXzW+kcxsWb+n7tpNzcOfiXywrQlzk1J9sVZlVHEyCQEe+9iFTc9IDKexZySkhD+qoM3iBvFe9rZ3PR/x8JF/Fe9QwOvoNzhP+YvC4s0lEqkAA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(39860400002)(136003)(46966005)(82740400003)(8936002)(7696005)(316002)(2906002)(47076004)(54906003)(6666004)(4326008)(70586007)(36756003)(70206006)(83380400001)(86362001)(26005)(478600001)(6916009)(5660300002)(336012)(2616005)(81166007)(44832011)(356005)(82310400002)(186003)(426003)(8676002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2020 15:51:03.0843 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 873fab74-cdf4-422e-cd2d-08d84dc5aa2a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2557
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
SW GPU schedulers and wait on all concurrent GPU resets.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 57 +++++++++++++++++++++++++++---
 1 file changed, 53 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 43ce473..c569523 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4743,6 +4743,20 @@ int amdgpu_device_baco_exit(struct drm_device *dev)
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
@@ -4756,15 +4770,37 @@ pci_ers_result_t amdgpu_pci_error_detected(struct pci_dev *pdev, pci_channel_sta
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
+	/* Fatal error, prepare f
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
@@ -4897,8 +4933,21 @@ void amdgpu_pci_resume(struct pci_dev *pdev)
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
