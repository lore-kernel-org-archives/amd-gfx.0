Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C91FFC79F9E
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Sep 2026 06:12:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25EDF10E454;
	Mon,  7 Sep 2026 06:12:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LSYYT3vU";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010030.outbound.protection.outlook.com
 [40.93.198.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C48110E454
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Sep 2026 06:12:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I/XXOgoHR/Ivj/nKGD6V5ZV35mwrnDcmg3C4HayGV0gaxz85aTIRWQ+IF/t32Tk+xshjefa4qo4XwP26UfiSOz8pHFWn1+H8TrVCdgPvaybdInIl6Y0orIDofL2rVI68CyzWc3w9rvUmfRTgxgjY+cnu7Plxw9KDbIq/xYE33mUvDOdj9AH6lpeCRUjbNISCu4YobQOqH70f5aYENJq62N/CfHuQ8tQfhhwd8NNIJ7hF2MzNCxTjIYjtI8N2RuyDXoG/tJQWaCI9Ru/Sy+jyh9xIF2Jrz5fga49ZIxA0Ge57jts79UPxRcx1k8b2rL12rzpbMwgGfoLYgYuf6TH/Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ri2mccfzA4Yef6mvkZ9KVApBiucyx5i37kHihpITe0I=;
 b=I/seercI7QBkAV3/op5OI9v+ezpwiMLJhAE+LEIs8xoHKPG696B9VJy9rzwOCZl+EH28TVZIfbslUSZ7HVHRgBwiUN4Aon8O4k0cS1qGFEmCpq0DVP805iu7VnoNkd9Iz9DhLkyMUtBLXwpP6yXiKnVoq4dKjveqILKE+Hfp5cNV8lW30ZoqjWlzLjcEPCi5W25vXp8w1DxERRsQioO+CtnI31Wpnpq6JlPZUPE2vPluM0CT9OuiYJSOlVSeb4GVAIUa//CQEs4uFT4tNTCT6QNAGH4Zlw5E2viDEepqozA1y6CjPu6MZjlKg+YbrFHoeCaM2Sv5GXvZVqT8SErj+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ri2mccfzA4Yef6mvkZ9KVApBiucyx5i37kHihpITe0I=;
 b=LSYYT3vU0Krq+wiK+PGfJUNAAtSDdH5FCiIgmDOyojdIIe8YuItSJcm2z85uMkrZAkj9yWX1z0zGxd4FcVL2G0KMzG3wVdPhkb4hYJEbtPBog6w99R3gDReDuE5kwydXQ9t/vcrSwucYwjFY6ZMfNUBU83rMrBqKlnjev2ARUD0=
Received: from BN0PR04CA0202.namprd04.prod.outlook.com (2603:10b6:408:e9::27)
 by IA1PR12MB6017.namprd12.prod.outlook.com (2603:10b6:208:3d7::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 06:12:28 +0000
Received: from BN2PEPF000055DE.namprd21.prod.outlook.com
 (2603:10b6:408:e9:cafe::36) by BN0PR04CA0202.outlook.office365.com
 (2603:10b6:408:e9::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Mon, 7
 Sep 2026 06:12:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055DE.mail.protection.outlook.com (10.167.245.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.0 via Frontend Transport; Mon, 7 Sep 2026 06:12:28 +0000
Received: from 7365c4c5327e.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 7 Sep
 2026 01:12:25 -0500
From: Bin Du <Bin.Du@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Mario.Limonciello@amd.com>,
 <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>
CC: <Benjamin.Chan@amd.com>, <King.Li@amd.com>, <Pratap.Nirujogi@amd.com>,
 "Bin Du" <Bin.Du@amd.com>
Subject: [PATCH] drm/amdgpu: avoid NULL deref in isp_genpd_remove_device
Date: Mon, 7 Sep 2026 14:11:38 +0800
Message-ID: <20260907061138.59606-1-Bin.Du@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DE:EE_|IA1PR12MB6017:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a35f4d2-6b14-4c77-35a5-08df0ca6fe88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|10067099003|56012099006|11063799006|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: AcEFaPsjqVXwQ/sda1EInazy0vb2YWZHHfq0kJqz0+dyf/jGalugcDKIS03JOtd2wPDQIug00nfuxybTrf2/QD8NuGajqIJP6m+oLwRSvfb5yQMwuHTnggcmDm/L8T6hfgvIP75PGb5qQQYf1G3XogLAPRO0qf5cdu/4KIPBpIOomGJHjkMe2cEikBYF2FsWC+OxlT0A98ZJUb0RxnVo5jWwJhY6+rWF+WHgXPYKQ+dsKjefBlsdz5pxlFdRYaQ5KLbeFvpp7ANFPbab37YZmAxdKiMEKZwIaBwFMHCGnwO8NiAumanKAetH8QvZTD2UVoZ2SokFal4bNV4zFJYEzNPg21F6KIJVA5QglMk+9XiwO5JLlZuqiYo+ymfudsecUT5dewD4n7ElgrmaYtxE/vIb/n0r33T1Q6HvdPqa6YTiQymjLxT8Xit8A0eLU4AZUiHuQaGIzZpEWzxuljr+uMyUiLxKQeitiOtjViGZr4jgcfsQXZYdI+M+2H8M4lFy+dLwavhtQIGVZHCjTdRPbF5STTKZfGXJ9+zcZjKiVrXh6w9Ig1X1E/mF6jEAYI9fCl/iwhG3kGkQ2WedFYAFbl4dP76M7LIBzqfqBMpZ5qy2GwXS3nIJpMvjAi7ojDAS/QuIULRpLtm2PeezJayaUA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(10067099003)(56012099006)(11063799006)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sYz0e6uMU3EYUBn3YGVO+aXQUTO6uI3XUg7RIheipKvWvADLHPSYXQz7UdSJYFFZsGBdzsqb/hCplREWhRbQyvk1f8oQIQdX03CiaIIYwZz+O9Vxp6Ayl9illf2gCamFt95knY2qyR0VaxTt0haWnx/qFPH8LUIaBIIWJqlsDju46owfk0DWzlzXrVAPynOV9Ts6++Y5+B2iiF+1deAw5Sr7z5gqLHqhg3ynpap+iRG8nczh9JvOj5lbS2ovoL+hf7B3M4/2gHaG+jd3iMYP2V+hNrlpk2IdNRRnOUQ0tUgHyNKBDxSIdZpx2umtkZ3o5DSiXO1CTBrE0KzolIx3aFXvL7PDpYj5NDyBc81uM5vQ1bzdchyAL9VivGn+wlS7KQiQp5OqmOyKIhRB8ZCOmCPLfRz60T51aWm2UX3AZzro0GPm8CiNtbYe9woDbZVg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 06:12:28.3923 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a35f4d2-6b14-4c77-35a5-08df0ca6fe88
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DE.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6017
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

hw_fini passes NULL as device_for_each_child() data, but the callback
derived adev from that pointer for logging and oopsed on unbind. Drop
the unused genpd lookup, log against the child device, keep walking
on remove failure, and only clear syscore after a successful detach.

Fixes: fd1478607102 ("drm/amd/amdgpu: Add ISP Generic PM Domain (genpd) support")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/5746
Signed-off-by: Bin Du <Bin.Du@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c | 28 ++++++-------------------
 1 file changed, 6 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
index 485ecdec9618..26dbfe2d2739 100644
--- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
@@ -156,35 +156,19 @@ static int isp_genpd_add_device(struct device *dev, void *data)
 
 static int isp_genpd_remove_device(struct device *dev, void *data)
 {
-	struct generic_pm_domain *gpd = data;
-	struct platform_device *pdev = container_of(dev, struct platform_device, dev);
-	struct amdgpu_isp *isp = container_of(gpd, struct amdgpu_isp, ispgpd);
-	struct amdgpu_device *adev = isp->adev;
 	int ret;
 
-	if (!pdev)
-		return -EINVAL;
-
-	if (!dev->type || !dev->type->name) {
-		drm_dbg(&adev->ddev, "Invalid device type to remove\n");
-		goto exit;
-	}
-
-	if (strcmp(dev->type->name, "mfd_device")) {
-		drm_dbg(&adev->ddev, "Invalid isp mfd device %s to remove\n",
-			pdev->mfd_cell->name);
-		goto exit;
-	}
+	if (!dev->type || !dev->type->name ||
+	    strcmp(dev->type->name, "mfd_device"))
+		return 0;
 
 	ret = pm_genpd_remove_device(dev);
 	if (ret) {
-		drm_err(&adev->ddev, "Failed to remove dev from genpd %d\n", ret);
-		return -ENODEV;
+		dev_err(dev, "Failed to remove dev from genpd %d\n", ret);
+		return 0;
 	}
-	dev_pm_syscore_device(dev, false);
 
-exit:
-	/* Continue to remove */
+	dev_pm_syscore_device(dev, false);
 	return 0;
 }
 
-- 
2.53.0

