Return-Path: <SRS0=4FJE=CL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EDF9C43461
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 18:42:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 048022083B
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 18:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gJDV4mgn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 048022083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4D5F6E4F8;
	Wed,  2 Sep 2020 18:42:51 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49EC26E4F4
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2020 18:42:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eHELkzET+hc+FT2mMML0+JODzUrf4VGtT93dKZGeS+yayVrmhL/r7nMMpVga9nnrw1d+bI6lA8lntHaLnQ2M6sDqKOrcYfJCXoETpDzJe/8AcQ5Voua6rIi0Dq/e9xFp8qogDS+lLFAaCLhAB/WcqU6k7quM2fY8TBIJ/FKtq4+L1t4Etkmj4wiQ9gGR4Yuw1VTyYl/rOahDmRbx9SXoXZ8bzw7JrNGUPpxF5IC4CfE4yNUgL2Upw4fki6PN5hQMYVJNI0/yf+eDND00ax+wt6XAquxhiAh1tNZrkS2R21QFZpaVk+vbGE77yp2NFQ/w6ltSJQfTC9aJyQIAz30k5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OBOgpXBsCRXKvemBf0aG/78ylP8yRQMdfDBQ5TYVCuI=;
 b=Ciz+8Ot6//HkbD+ySyciS1gEiYtEFEQndnjct72xMqsRg9Wl2VxDDoTFDqqVVfd1WMAAid0tAT2pzSUx0nJW1RVkDgcHYQDejupotS+4B5jFmSybmkyYThAVnBnEg7Bl187BZjxVOvQx6oHDhm/nDd9nNAH+zHN/MmDOChYdyceJhIlpmeTMYcT1Yw5LGZ4AgpKvXyYDG3B3B+S/0BIMdkGxmwuRLehp8RBSymWyx+A+Q2hhx69PSHebwObUoJ04Tb8iLHXoyuLbHSqN/aJKOPC16RS9rIrRh6KUE2aOi38GeEIalWTT2z8Qzn3CVzpKQpezmtkymNvRbB3Urt59Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OBOgpXBsCRXKvemBf0aG/78ylP8yRQMdfDBQ5TYVCuI=;
 b=gJDV4mgnXrm6P+NrGdVRXUfppj04MhrflrcHMRJynAaEgjke52voN8+tYIKNsQ1i6BNPHF+Z6pPnncFhW9TrIu8bgu+0S81kg5ZmteEdvuXMKa6dt5QUslO/EVGNB2ORpp6yq98o7tHiqzGVV9cxfAU7KS+Ywx4O/6Jb1eL1aiw=
Received: from BN6PR03CA0055.namprd03.prod.outlook.com (2603:10b6:404:4c::17)
 by MN2PR12MB3838.namprd12.prod.outlook.com (2603:10b6:208:16c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.21; Wed, 2 Sep
 2020 18:42:42 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:4c:cafe::13) by BN6PR03CA0055.outlook.office365.com
 (2603:10b6:404:4c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend
 Transport; Wed, 2 Sep 2020 18:42:41 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3326.19 via Frontend Transport; Wed, 2 Sep 2020 18:42:41 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 2 Sep 2020
 13:42:41 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 2 Sep 2020
 13:42:40 -0500
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Wed, 2 Sep 2020 13:42:39 -0500
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>,
 <sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-pci@vger.kernel.org>
Subject: [PATCH v4 3/8] drm/amdgpu: Fix SMU error failure
Date: Wed, 2 Sep 2020 14:42:05 -0400
Message-ID: <1599072130-10043-4-git-send-email-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599072130-10043-1-git-send-email-andrey.grodzovsky@amd.com>
References: <1599072130-10043-1-git-send-email-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b65824b9-39de-4040-adb7-08d84f6ff970
X-MS-TrafficTypeDiagnostic: MN2PR12MB3838:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3838F74E8B5A947BCF291339EA2F0@MN2PR12MB3838.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AffWzmtC9hTzB4Vh0qa3WBbk39YOxdNgjh6p1yEAr72UcpK//un9LfCDXZdIW8ts/jTzsU0kxEfskhO6IbBOyCqVzrHjX4NT7M6Zyku2zHf6JBlk8T5BFR2Fz35WY8L2NIeAnlwEV+62jz73hlP4dlsDwsxnJwQE5W/F//2DrONQmbRikL4Ww5uhb3FfYsVE2D5FG81zawwCeI+KynCO7qxZZUvEZ4iFCFhYAj92rWeEvyjb0GtoKwle1mkAJJrmzlmZtqWNK22RnFZ0wA3eSJXfCCIg4dsV3TaSL8XyD8nTmDm9EAmN8P1oE6YArVkWJx/YgkNOe4lwWKEe5+ntQaPrqtXxPzP2LlHrOcBGMyykC+HOaYav36Q8oXq+A/I7Bnfc7UgkDRDx6VZh8FQ1kA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(136003)(396003)(46966005)(47076004)(82740400003)(356005)(8936002)(44832011)(70206006)(70586007)(83380400001)(2616005)(26005)(81166007)(82310400003)(86362001)(426003)(6666004)(8676002)(36756003)(186003)(336012)(7696005)(110136005)(478600001)(316002)(5660300002)(54906003)(4326008)(2906002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 18:42:41.7380 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b65824b9-39de-4040-adb7-08d84f6ff970
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3838
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

Wait for HW/PSP initiated ASIC reset to complete before
starting the recovery operations.

v2: Remove typo

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index e999f1f..412d07e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4838,14 +4838,32 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
 {
 	struct drm_device *dev = pci_get_drvdata(pdev);
 	struct amdgpu_device *adev = drm_to_adev(dev);
-	int r;
+	int r, i;
 	bool vram_lost;
+	u32 memsize;
 
 	DRM_INFO("PCI error: slot reset callback!!\n");
 
+	/* wait for asic to come out of reset */
+	msleep(500);
+
 	pci_restore_state(pdev);
 
-	adev->in_pci_err_recovery = true;
+	/* confirm  ASIC came out of reset */
+	for (i = 0; i < adev->usec_timeout; i++) {
+		memsize = amdgpu_asic_get_config_memsize(adev);
+
+		if (memsize != 0xffffffff)
+			break;
+		udelay(1);
+	}
+	if (memsize == 0xffffffff) {
+		r = -ETIME;
+		goto out;
+	}
+
+	/* TODO Call amdgpu_pre_asic_reset instead */
+	adev->in_pci_err_recovery = true;	
 	r = amdgpu_device_ip_suspend(adev);
 	adev->in_pci_err_recovery = false;
 	if (r)
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
