Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31855C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Dec 2021 03:17:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C54410E3E5;
	Fri, 24 Dec 2021 03:17:07 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CA5D10E3E5
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Dec 2021 03:17:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NOLwG31FBggC3WajNIkTibOyW5FR7hNpiLm1tS2+t07G4uW2Jkj7JNOtjrr3GzIy26T6/CrpFSgmdstZgg0tAY9rYstgdcpYYukWpzblJL7bOvJqpockMXM85Q+V3If9FuwK2mx0xVqGUJk20spH2VL+KM5x1VakFvMAceaYtDhmK6agmPMN1OUpPIvd1wcuRBXLH1YRwZK0LE7qbiSkvDcHaveH41dEAvLX1CIP347g1OS7JOcMgPCDtKo10K7PFm0sRrrrn5wY7Eg6YYRKxl0T0Z1/B1G0SvB3SU2/GpUTpOPy4WUm0C3dkyaYzexvcdaKmjaWwFxQhF/R1hW6sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vzG/BFIW45DVntpR9WZEwqX8G/mQ3RFWTlkJXeNlSDg=;
 b=FXA3292o7yOXho9ugqXsyFDBGR0DxSQKBbuqm/P/3BhHlqM9rHJQBOJg6pRws9Csxv3E+qEtlwDyX4tSKBkKsPa3qGsukFGgH9aeB85y9MY9jzwd7Y2pXXqYJDZnUCkfwlk4Ruw7Ux1KNds+YAzQwRS4279gvrinA19pfV/cRgmhlnTOzPch3Z9r9js56zAKGvXGlMd3e1IHLuLeOu2x0IWHGo/6Zt5gzCQ3abZWYFkEo+6LfP5si6nMimKresrjcs9Z7kSwmr9X32O7tfSYaJ0oJ0yhEjk803/1FG4QsZr9Rawa9z3huZU+eQfrMC/iFUXFe5UdKJAYRQkeWg0OQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vzG/BFIW45DVntpR9WZEwqX8G/mQ3RFWTlkJXeNlSDg=;
 b=O9cfrTFmrX2bT0cIYsjedRRwPzpOi5fi+E8zcdWAR92dfskWAma2mVbDoOqXn77qqxXY7aSuq/ch18oXohw+rUtrbO/B+wwI1d6Eb+hgOJ+MxTNIHrHI8qzflRUw2LgsFJxqDo9cH61lFsKH6de9UKqKiIskL4PnGO5SQQ9lg+4=
Received: from BN6PR19CA0097.namprd19.prod.outlook.com (2603:10b6:404:a0::11)
 by PH0PR12MB5498.namprd12.prod.outlook.com (2603:10b6:510:d6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.17; Fri, 24 Dec
 2021 03:17:04 +0000
Received: from BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:a0:cafe::24) by BN6PR19CA0097.outlook.office365.com
 (2603:10b6:404:a0::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.21 via Frontend
 Transport; Fri, 24 Dec 2021 03:17:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT009.mail.protection.outlook.com (10.13.176.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4823.18 via Frontend Transport; Fri, 24 Dec 2021 03:17:04 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 23 Dec
 2021 21:17:01 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: put SMU into proper state on runpm suspending for
 BOCO capable platform
Date: Fri, 24 Dec 2021 11:16:44 +0800
Message-ID: <20211224031644.2555373-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56f99dfe-cd11-4a3d-6473-08d9c68bdbd8
X-MS-TrafficTypeDiagnostic: PH0PR12MB5498:EE_
X-Microsoft-Antispam-PRVS: <PH0PR12MB5498C35D712761D9ACEF4328E47F9@PH0PR12MB5498.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rYSIPMM5dCLDtYddRttexFPH7NiRrLgxHZZHRoPnx0Uw8AwewG5Ty+lcR7+n/xV7KbBWXgI69M8yqNcGCNfrjeJVMGzB/iPVY3cOSCo45tynHYR4wvoZAS14TarlsS5ncc9auiUEwp4XJFUljM6lyFUMrPL9zcpS8OxeqT9kci0k/AwaXsHxsmlOFJoEASn/KPY7r7Itbh85h274i8J4fdfTPjTDCvdypgkq9ZtU+ZDUpbD7HX/pWPm5tTS1uqfKdDo0ZT+IJc8ysXE27pD00NwSKLQOh4hrbNd8vIFpJn39uvSSprWKN1M4qnFfxa+HKqSrpxWKkqDhd/oMsAaZQCEPqIjmqRGpmrejyUylYd9B0LdxbsbvQuhNRVZFVYRdUfQ6uGnow9OD3fYDnN+UbEohyMawujsalF5S/GTsS2+urdpIQFc4BtUwNtkFLaJpVR4zbB6oS6QkwtH9Vsy4nl8GvMIGwGVNzXPFAL+rNddQm16LwW1GuUCnnVEg39P7u3RnFnqbjsS5F95+8UtzAXqCLcn14ZyiZS4dviQcoWbrpMr9xVoxl/xoXq5xDOrTzx4MbOs8yO2gBKNj9FxDoQV+nBrA1ZKjtfPbMA2ozilkeYquyHftShEchpL/t9z0FCftRJYUX3LYET7qFXAn+T+Gbv4wHplVbYD9womAV1iJiZf9w/CZ+NP4xZcC11JA2H8gmFMq+sbDF+3DIDVYu0WH3i6XYbaQChFXG0MO5Ucih2bTKx5aEuxvk4bWkRsozmj4eT2ScwRBmgG9vgc9zRlUqpXZvGECiSQw8vVRADg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700002)(44832011)(508600001)(426003)(2616005)(4326008)(47076005)(8936002)(26005)(16526019)(186003)(336012)(5660300002)(83380400001)(356005)(82310400004)(40460700001)(2906002)(6916009)(36756003)(1076003)(81166007)(70206006)(70586007)(316002)(8676002)(86362001)(6666004)(7696005)(36860700001)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2021 03:17:04.0312 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56f99dfe-cd11-4a3d-6473-08d9c68bdbd8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5498
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>,
 Guchun.Chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

By setting mp1_state as PP_MP1_STATE_UNLOAD, MP1 will do some proper cleanups and
put itself into a state ready for PNP(which fits the scenario BOCO stands for).
That can address some random resuming failure observed on BOCO capable platforms.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I9804c4f04b6d2ef737b076cabf85d2880179efe2
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index e431c7f10755..ad8370b41e74 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2235,12 +2235,27 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
 	if (amdgpu_device_supports_px(drm_dev))
 		drm_dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
 
+	/*
+	 * By setting mp1_state as PP_MP1_STATE_UNLOAD, MP1 will do some
+	 * proper cleanups and put itself into a state ready for PNP. That
+	 * can address some random resuming failure observed on BOCO capable
+	 * platforms.
+	 * TODO: this may be also needed for PX capable platform.
+	 */
+	if (amdgpu_device_supports_boco(drm_dev))
+		adev->mp1_state = PP_MP1_STATE_UNLOAD;
+
 	ret = amdgpu_device_suspend(drm_dev, false);
 	if (ret) {
 		adev->in_runpm = false;
+		if (amdgpu_device_supports_boco(drm_dev))
+			adev->mp1_state = PP_MP1_STATE_NONE;
 		return ret;
 	}
 
+	if (amdgpu_device_supports_boco(drm_dev))
+		adev->mp1_state = PP_MP1_STATE_NONE;
+
 	if (amdgpu_device_supports_px(drm_dev)) {
 		/* Only need to handle PCI state in the driver for ATPX
 		 * PCI core handles it for _PR3.
-- 
2.29.0

