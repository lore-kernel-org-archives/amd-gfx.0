Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32DD8C54E49
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Mar 2024 15:25:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A294D112BB0;
	Tue,  5 Mar 2024 15:25:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3TBWrBqM";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E523112BAF
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Mar 2024 15:25:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SKx0bTeUt47G9vlv/BbuiwwqKcMbi8rKsoEijDN8qvGtevrFHcOY1ANBLXDIdRG2P/jEWKxVQDMD3+S8D4irpdOzzS/zrGwelS6ELBE8GdzAqOshcIv+ugt0oCX8Ml/Sy7JBna80zuGG77fmCw+TvBn84EZ47Pk42sgyQBpQm8wUzyBvLbYQAext/UQ2sQRROqQkPytP56LnXOUFvigZx9uFJkpdfmibcRuez1j91ULeAz19exz2qz68fegON6DL4EQi28e4Wfrmsq8ckoO9zTkCLatr0VzKOA+N7+1bhQj2F/qFQ45xJH0lYPBHaENVjdfwixC+A1b66eM9qoVOxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4/u1Tzn9jUC1UpRc/MxjJ4Dc9sFmkPCWlnpJct+7v4s=;
 b=CWQx+pvKgFKX4CXZtkYtSI2bzS7Oor8L57NrZgDuoapYekZLZdJVcn21QXoyg5Vx1QH6nQHI9CkD14sC0nYf3DYwog/DYYoXW1No29i2wSEr4OaAd7Yo8L6ozdjPG9TbqeULQerL14PFWD7gtDCXLYEm00EdKT+2E+FOqwrQiLwtaZudVq9NRsi53zVNH1GJwDtTQHmUuHA+4kv8wxWku0Cj5+1/lqqqFPUG9Wpj8Qn47IEkR99t4Hrtrlqhq+Rf/HMViaDjTtLg9Bq0TXAZjYLL1uyUpn5CwuhlfGuH0f2Q8o7ISUoozR9hsCOu3r+S2mIENSGio2zQsHEhfZ/qLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/u1Tzn9jUC1UpRc/MxjJ4Dc9sFmkPCWlnpJct+7v4s=;
 b=3TBWrBqMSoOnIWsd36QI20Dj/FT1d8hjBiaWUpZ5nBuhrdjC9sUnCWZCSWrQp7HtvK4yYgjtJ35j+OaoVkaoMQ6aME1GiwK2Am4hZHJnkGd9MzfvD2ZNQuVWDFVy1jx+n+vxg2UNA15PyKhvwa9sWBmFiR/klIBXh+8/qPmVXgQ=
Received: from CY5PR15CA0242.namprd15.prod.outlook.com (2603:10b6:930:66::18)
 by PH0PR12MB7862.namprd12.prod.outlook.com (2603:10b6:510:26d::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 15:25:04 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:930:66:cafe::f6) by CY5PR15CA0242.outlook.office365.com
 (2603:10b6:930:66::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24 via Frontend
 Transport; Tue, 5 Mar 2024 15:25:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Tue, 5 Mar 2024 15:25:03 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 5 Mar
 2024 09:25:02 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Yifan Zhang <yifan1.zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: add smu 14.0.1 support
Date: Tue, 5 Mar 2024 10:24:44 -0500
Message-ID: <20240305152446.1268829-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|PH0PR12MB7862:EE_
X-MS-Office365-Filtering-Correlation-Id: e749e513-e1e3-4adf-a444-08dc3d286e38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f0m/wyjzMdrV/TK6HB2z+wEYUoCt9fV3WIayQk/jRwG1i9TnYnEuSVIChgvjk4W/qGm0ptiJ5pEJKmFCso7XbWky6JgbZWJerSeQDsx61ywUXO0dMwLh0MG/sedOAENs99cQZd13jCNPySN7IDOI6TiUle3jag02Yx31W7KHw/I2PsAkAgy/ZVrl3bx8ZrEjFn2Empl8tCwNAQyf61+ogdes6h1eIU9Uja3COWtWAbbINOIUzCSDASIEJsnwBWDGZK8soCdQ7zGYOFzq1nD2DTdx1jQEIzHnvu0xTkzZItUYPKKWBmSMU6DnTwQ/B0B3ZCDVoVf5ltHS74z6GO2ZPZBQNizo7qcdRlGUelckrE5kLfo81qcl6WiNcfmojpPSs8g+p0BSjlF6ZkcHhgej23oX3aBBnG1jOKK7vxl907yIV8129FtvmPMWPiMJWC/DOFHRxUTAebd8NhFTe6VKDl9ba3tdacvPKMv++0D1wQzONL7ob0LPqw78I0mTV4VV7fHmPbdnnY2fTLLfxDrHv8kz6cHlq/OrzQY6xR5qeo236E0jJ3Azs7tgC9Fb4kp14Kv0hvvKJe7iMfv5wV1ftUokdQrTt2wmVbeSv8ISpwdkH8LT1phXgNApmPRIqfIRdFNnJifutJ+RfHC7v6LzV+Ju7/UVPB8EHrxie1pfYFim+JBgsspMfsD9dbZvtA3Kea8bSYA2l2LaIZO6NtCLjCRROm6Sk9FTOGESg5DVcSEoIL4ilRdGcSIuWhomnT1X
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(376005); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 15:25:03.5866 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e749e513-e1e3-4adf-a444-08dc3d286e38
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7862
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

From: Yifan Zhang <yifan1.zhang@amd.com>

This patch to add smu 14.0.1 support.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c      | 2 ++
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index eedb9a4f7e2d6..246b211b1e85f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -712,6 +712,7 @@ static int smu_set_funcs(struct amdgpu_device *adev)
 		smu_v13_0_7_set_ppt_funcs(smu);
 		break;
 	case IP_VERSION(14, 0, 0):
+	case IP_VERSION(14, 0, 1):
 		smu_v14_0_0_set_ppt_funcs(smu);
 		break;
 	default:
@@ -1895,6 +1896,7 @@ static int smu_disable_dpms(struct smu_context *smu)
 		case IP_VERSION(13, 0, 4):
 		case IP_VERSION(13, 0, 11):
 		case IP_VERSION(14, 0, 0):
+		case IP_VERSION(14, 0, 1):
 			return 0;
 		default:
 			break;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
index 7ac9bc0df8fd7..a65c618c2f98e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -231,6 +231,10 @@ int smu_v14_0_check_fw_version(struct smu_context *smu)
 	case IP_VERSION(14, 0, 0):
 		smu->smc_driver_if_version = SMU14_DRIVER_IF_VERSION_SMU_V14_0_0;
 		break;
+	case IP_VERSION(14, 0, 1):
+		smu->smc_driver_if_version = SMU14_DRIVER_IF_VERSION_SMU_V14_0_0;
+		break;
+
 	default:
 		dev_err(adev->dev, "smu unsupported IP version: 0x%x.\n",
 			amdgpu_ip_version(adev, MP1_HWIP, 0));
@@ -734,6 +738,7 @@ int smu_v14_0_gfx_off_control(struct smu_context *smu, bool enable)
 	switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
 	case IP_VERSION(14, 0, 2):
 	case IP_VERSION(14, 0, 0):
+	case IP_VERSION(14, 0, 1):
 		if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
 			return 0;
 		if (enable)
-- 
2.44.0

