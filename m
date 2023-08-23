Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D50EE49AF
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Aug 2023 06:35:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AB5C10E2BD;
	Wed, 23 Aug 2023 06:35:39 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2414F10E2BD
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Aug 2023 06:35:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U+hI5HUUoyVQzqEOCSSDMjvDC0v35+i5Id5j1iw501+Ao4U0XhaTnQV5HgvLgdhk3uXw58D2lN7T3UANISUbPiaPVT+NIrnNXYRdSLG0mBXoHjc8aQIQ7ZAAo7sZJj73+XWx41MCbIeTBrwzya3xe3EyOwCJUQFyHiE9gqTvq1QJvPSEC+qOMTo9JN3ToUQPpHvwsVZvYRPfeLhbC2bcOu3n7owYa/OIHpxWhXrX1GJzFZAAD/AGu8b8vMH4uhU8UEQ7cTIXzoqPAJVj3n79D4ZQypO5XoExsImlbyCv/aDVsANNENDODg9EqAPGR0woxKF2FPG9QJhz3D++jlS9zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Ei0fRBdlKxc1wZkNsYs139mZ/BQ5JX56B1fCGDqRls=;
 b=aEDEGrVvWl8gXz/TTL1kBb2+Hi6qt9c0HnVG4urcnb20unYxtvaqqclIN/erouGyMGKSHdMA/OoRSgkiKkgUHQOz7ioceTB2cVq9Y9HINy8cCPdb6eAKSMtU6GdU7CDGLUNn3YISr2+uISWlDG7dUV4LHGeEZjf32trHXs/9d7aZG7xhRpZM6z0HI/ekbrLgrYn+eVYeV+QVQVtoYCKG4GNGx7KY69wspGPkB9yIQHREwAtOU3tyvSClnZNtyfRjn/sQSFs1ztC9XFcH5WDI70+ATdpfnkjgIhpd7cl5Exs+Vl3RlfjYk++lukMQP/IuXnJKeql3TWeZHMeYoEBdXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Ei0fRBdlKxc1wZkNsYs139mZ/BQ5JX56B1fCGDqRls=;
 b=N3XB/ppBbYa8s6cQVJGKo9FVs4lcS0etTi2RaZiv/a1GCvB40aEtEe0uCccsz6OtS0xSctzVpkRl8IhGavOJoeBpjT4InouYajHP0Xq4b1sVKtxHJXz76mdcdwifwk46waA8lLc6s5nqyl6zxr3QfV/L9eV/Nob2snAv89qRGc8=
Received: from CY5P221CA0074.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:9::11) by
 BL1PR12MB5254.namprd12.prod.outlook.com (2603:10b6:208:31e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Wed, 23 Aug
 2023 06:35:34 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2603:10b6:930:9:cafe::5c) by CY5P221CA0074.outlook.office365.com
 (2603:10b6:930:9::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26 via Frontend
 Transport; Wed, 23 Aug 2023 06:35:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.142) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 23 Aug 2023 06:35:33 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 01:35:27 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [V2 2/8] drm/amdgpu: revise the device initialization sequences
Date: Wed, 23 Aug 2023 14:34:00 +0800
Message-ID: <20230823063406.1195151-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823063406.1195151-1-evan.quan@amd.com>
References: <20230823063406.1195151-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|BL1PR12MB5254:EE_
X-MS-Office365-Filtering-Correlation-Id: b52a1e00-9d25-46b2-3c4b-08dba3a3276b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nR78ESJgBCXmTt6Xgmux+OmfChfPMBDIjEM+vAP6fSTqDTkneGYbdbeUpaX3BWbVIjPNp1cUlsybVDjIYhCC+7KHjAqYuXx45z5SZOe/MlDqsFMKk7+2pfW64ycr3hGFgTgJ674WItWoMY9jqtNfMqt9X6HKVwKI+psqnKS4zs3TPPJzbo6qWco4TWZcpLcaK7YGG2q0tk8TXct4QvLaKPs4KdRrxHB/S03p5H4rHwGHRGwdvbdySE3V4TH+OrUMSDEEbXzGF5zfTY7n7aOIdkRJCc8Auy8XnoN/zq+FbSuv9VNs7Kipi/zEzWBjjILoY6GafDQn6ug6te1JoDKFqRxqJDGu9Zf7nKfhLW3w7H/85D5is+ZHLinRftE3W2NZy4m2beCWYF0kJbCv0DYoDH25irq15qVTBb+YEqeJt2u8SuCvXoB3LUMCCHp28Srk4oda388Gwg/GSVbRWPd7kcLdqjsgU/llw1tJlvbOGWN0S4gqy3z1LMJGX8fDpa7LQL8OQ9lCZRtZJcmTrgKvm4M6w1E3oBwM3AO8RKAKNsiSr/RArk910KhVK8yoNKMyYvsw61iTL6TviC9lqRtFiLvpVEBsZ5l0BoJhtIoRclKK+Q/b1QG0diNobLzPSM1ikMk0xyd2NMdUDwr+ChUuujqJGff/nNT4m2T02y3lq//xcapCHdEYZLFXmFIhyRtryXJnFrtzzTC/YjM/qWK//ajtqd+JtGcJSzEf0u6uyjk7zWkbnRuoKKzUYRyMkNnjSX3AU3LwkgZ3jbgpDIo4IA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(136003)(39860400002)(376002)(451199024)(82310400011)(1800799009)(186009)(36840700001)(46966006)(40470700004)(40460700003)(40480700001)(478600001)(6666004)(47076005)(83380400001)(82740400003)(356005)(81166007)(70206006)(70586007)(2906002)(426003)(7696005)(26005)(16526019)(1076003)(2616005)(336012)(36860700001)(36756003)(86362001)(54906003)(8676002)(4326008)(6916009)(316002)(41300700001)(5660300002)(8936002)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 06:35:33.8455 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b52a1e00-9d25-46b2-3c4b-08dba3a3276b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5254
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

By placing the sysfs interfaces creation after `.late_int`. Since some
operations performed during `.late_init` may affect how the sysfs
interfaces should be created.

Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 37 ++++++++++++----------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 7aae2801b36e..92db80089cf4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3861,22 +3861,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	/* Get a log2 for easy divisions. */
 	adev->mm_stats.log2_max_MBps = ilog2(max(1u, max_MBps));
 
-	r = amdgpu_atombios_sysfs_init(adev);
-	if (r)
-		drm_err(&adev->ddev,
-			"registering atombios sysfs failed (%d).\n", r);
-
-	r = amdgpu_pm_sysfs_init(adev);
-	if (r)
-		DRM_ERROR("registering pm sysfs failed (%d).\n", r);
-
-	r = amdgpu_ucode_sysfs_init(adev);
-	if (r) {
-		adev->ucode_sysfs_en = false;
-		DRM_ERROR("Creating firmware sysfs failed (%d).\n", r);
-	} else
-		adev->ucode_sysfs_en = true;
-
 	/*
 	 * Register gpu instance before amdgpu_device_enable_mgpu_fan_boost.
 	 * Otherwise the mgpu fan boost feature will be skipped due to the
@@ -3905,6 +3889,27 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 		flush_delayed_work(&adev->delayed_init_work);
 	}
 
+	/*
+	 * Place those sysfs registering after `late_init`. As some of those
+	 * operations performed in `late_init` might affect the sysfs
+	 * interfaces creating.
+	 */
+	r = amdgpu_atombios_sysfs_init(adev);
+	if (r)
+		drm_err(&adev->ddev,
+			"registering atombios sysfs failed (%d).\n", r);
+
+	r = amdgpu_pm_sysfs_init(adev);
+	if (r)
+		DRM_ERROR("registering pm sysfs failed (%d).\n", r);
+
+	r = amdgpu_ucode_sysfs_init(adev);
+	if (r) {
+		adev->ucode_sysfs_en = false;
+		DRM_ERROR("Creating firmware sysfs failed (%d).\n", r);
+	} else
+		adev->ucode_sysfs_en = true;
+
 	r = sysfs_create_files(&adev->dev->kobj, amdgpu_dev_attributes);
 	if (r)
 		dev_err(adev->dev, "Could not create amdgpu device attr\n");
-- 
2.34.1

