Return-Path: <SRS0=p2a1=3E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E01BC33C9E
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 03:48:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28941222C3
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 03:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jTsQpgfw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28941222C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A44BC6E835;
	Wed, 15 Jan 2020 03:48:38 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A8446E835
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2020 03:48:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CtCQE8weI21TTdqENRwNX308ByzzTTEJ10tUfR9Q14TKzmOJpqeWYIWx8r7DH7VXOSK7IF5gZy/Xtgdwd6zhlZyo2HTQLta0mFO0YVg28mKvn3qYlSJGP/oXlK1c1TiF21nJczy+M3XFC6OZc/heTESkB2zFD4CBDBzb9ddxpop7Lh8ROnGbcReDA2mRy3pdW6Evu9tOD+JbUfkhQcvY19l4kftYFBkaX7NsvRmjumdfhjyOcqVu8SxS3POdQb35vzHogNF0H3M49OxpJjmFpBKPYiZBihJufrtg5c6yv69zP2KW8jXAq/EFqlWLPt/DAqnzbf0KgvbErs45zkmDag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W23ZsZ5hTZwm0OV80AEXjS+WNaVDNIc4aSHTGX16Ffw=;
 b=UguAgGR5llDTRs3FDEGQlsU3xMylXHmnjZSecJljuGarEJdnUiLxQK8qCP4fohA7/kgWjDAOc/VPINcc5x2Tl2PZ+saoRwB38EWxzVZjsqgtmmaNHRFWtbEOKuo3KWu2AA1DYD4oRNc15qoEfZISmMP7oaMIHYNcDOafKuQHBMm+t8RMOMIb266mUCN+527vjln/8+n4RMcA574NwCp7ioOr89pHKbpSH/eQs9am+bDRz9L3K9n7Q/tUoQ+xe8Pu2PY3mTi0+49osMhBwjSL8/atUyy47P7HvGvQlz5N2W9y3hfhp1wsyiY6JxbCL3EsLPQschVeIBPo7vKd28WGpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W23ZsZ5hTZwm0OV80AEXjS+WNaVDNIc4aSHTGX16Ffw=;
 b=jTsQpgfwTZjkFCi3SxN3NVbtTfUVfbzQMeP0SFqfdoHnIYWdQ8U+7UZ9pUSZUvVncL4ln0OGbCm0DlvmSGbXbtD6qzHDGBtvGDxyUWmGj6KXtB5ws8g/N2w/poO6mvATIyevoKqL7seWRLd1WeOlJvNAfSjQT0kP8mKnqH+ZWeE=
Received: from DM6PR12CA0010.namprd12.prod.outlook.com (2603:10b6:5:1c0::23)
 by MWHPR1201MB0159.namprd12.prod.outlook.com (2603:10b6:301:59::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.10; Wed, 15 Jan
 2020 03:48:34 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::202) by DM6PR12CA0010.outlook.office365.com
 (2603:10b6:5:1c0::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18 via Frontend
 Transport; Wed, 15 Jan 2020 03:48:34 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2644.19 via Frontend Transport; Wed, 15 Jan 2020 03:48:33 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 14 Jan
 2020 21:48:33 -0600
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Tue, 14 Jan 2020 21:48:31 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Guchun Chen <Guchun.chen@amd.com>
Subject: [PATCH] drm/amdgpu: check if driver should try recovery in ras
 recovery path
Date: Wed, 15 Jan 2020 11:48:27 +0800
Message-ID: <20200115034827.7187-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(428003)(199004)(189003)(86362001)(7696005)(6666004)(356004)(498600001)(26005)(2616005)(2906002)(186003)(1076003)(4326008)(70206006)(70586007)(8936002)(426003)(6636002)(5660300002)(110136005)(81156014)(8676002)(336012)(36756003)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR1201MB0159; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c8a52c3-9af6-42a0-6a63-08d7996dcb79
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0159:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB01599E93A0199B9D8ED07788FC370@MWHPR1201MB0159.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 02830F0362
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PY+PxZKD6X47AHzOC5sjaMRYA3hJg9zfaklr65iKFZyMdKJzaJqrqmMxOp+maB2+N1v2lmjx5wJ1LRfjv+CwBI8Bpt6/Zuz9jXbmn1tomdAbODwfzwoo4ukP766DQ/dLaAdm3AZ9LUBQ3KXiI+lEh3iPYpf/4Y00BCM3UVvnEmxbSdCXG8HXgXRctturW/R8+uLQoQYEJPIfRPW7TOb7/l/Ev5rYnW9/dZ3ZsW5mfHDzbx8Gqh2n4uwf+kDfef8U3w7/tfwGHE1IKZJGOYtBb/f6Dqwf8EXCnYgOo99Fr7aeo4EVefte39CjaDvHvD8TyIrmq1Un/5jmUcXvsdJzB480QTChEJ1Doqm59oVT0YEMfyOMeri59ohVx2lZlxp0esPT4/4I8de3xdNd2xdzNhfncKKnCRRGIllNsZ83sA967SqZwZp5XyslNaNBTZgy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2020 03:48:33.9999 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c8a52c3-9af6-42a0-6a63-08d7996dcb79
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0159
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To allow the flexibilty for user to disable gpu recovery
in RAS recovery path by module parameter amdgpu_gpu_recovery

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 706a30e81fcc..8e2f0a380461 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3799,6 +3799,7 @@ bool amdgpu_device_should_recover_gpu(struct amdgpu_device *adev)
 		case CHIP_VEGA10:
 		case CHIP_VEGA12:
 		case CHIP_RAVEN:
+		case CHIP_ARCTURUS:
 			break;
 		default:
 			goto disabled;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index ac9926b3f9fe..492b3ba685cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1356,7 +1356,8 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
 	struct amdgpu_ras *ras =
 		container_of(work, struct amdgpu_ras, recovery_work);
 
-	amdgpu_device_gpu_recover(ras->adev, 0);
+	if (amdgpu_device_should_recover_gpu(ras->adev))
+		amdgpu_device_gpu_recover(ras->adev, 0);
 	atomic_set(&ras->in_recovery, 0);
 }
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
