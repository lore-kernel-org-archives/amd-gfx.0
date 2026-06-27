Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B263C43458
	for <amd-gfx@archiver.kernel.org>; Sat, 27 Jun 2026 04:38:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE56D10E43E;
	Sat, 27 Jun 2026 04:38:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Y7chqoNa";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010034.outbound.protection.outlook.com [52.101.46.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E5B010E43E
 for <amd-gfx@lists.freedesktop.org>; Sat, 27 Jun 2026 04:38:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O2KXJ/l45dxFlNr+ExiDNJdgyDYskbRlDYFUgr9+ataqQn2HTok2Tn8bGmV6DHGZsx1K5mLQRAXJWAFJ9FHGGFeFESViKo8n11tWoq/4Xy4K0pHuBE5KQ4NkGsgZBburVlvXW0tz/+Qz0wchLYfDj+HkNe1t+Gm4L2nElczyJzUZdCmKRr0sjc2/KeyXXnzgXhhC+DQ8G8L6rtL8+D1Z1SfsOp9F05LcXL1x/ZjSgNo6FCd3o3K7j+yD+AizJJrvuyXEj6raIITVzpBv23EJ6s3iPyqBFx/lKjxgAlA5M2qHsczqMjDhnQdFoWTVKfKwI+OROwU8d4Pn4Ve94CPUeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b3ZdwZkXZJ0GmlA6An8YXZafizElJU98UhVP4agh7fs=;
 b=bcKZEhPsRFYbjCA57E30RhhsiMAd31nBQFuWlfPE9T6zhN4/Fum3oKrSVEF/EW8r6dJKDzLEFkeJRCADD2SlpdQ3iAx4Nehsr+l1cf3TxmTmHolUxuSiBiQ+Y5OeeOuKn/AFVNtOpKGIqqFyzWNJ1A6a3xbEAu+4jDOp7PBI9Z3pki4TVS5WwknTcj0eDHOxz2WW4wdkE9MHwF9DEmjILGw6YsbmYh65kMykQB8db2MLHRv9ZvHb2mrCO6s07Kh8WpKGm5BRORqUxrSD5VRX+Qcj2OslPDiEqk6RTA+pIP0eHbTKu3kzCCM5jldTi8UG2lHatcTu+wNZKXpywAhuzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3ZdwZkXZJ0GmlA6An8YXZafizElJU98UhVP4agh7fs=;
 b=Y7chqoNaUJghKHaqMR0FcJw05dj2jw31TA00/QJlXTXcfJz5jeRvFjQO6xAa0DLYNyqQXPHiPa0VL/jnVb5b4Dj8QTnmdjyLDPqnktibw/cBwDTh1QnNyVbr9q/EQIOuNICWTXmijssB4UQJ7pjwDSmfSULTOLL5PrN8jyVM3Js=
Received: from BY3PR04CA0006.namprd04.prod.outlook.com (2603:10b6:a03:217::11)
 by SA3PR12MB7857.namprd12.prod.outlook.com (2603:10b6:806:31e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Sat, 27 Jun
 2026 04:38:18 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::3d) by BY3PR04CA0006.outlook.office365.com
 (2603:10b6:a03:217::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.18 via Frontend Transport; Sat,
 27 Jun 2026 04:38:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Sat, 27 Jun 2026 04:38:18 +0000
Received: from amd.com (10.180.168.240) by satlexmb07.amd.com (10.181.42.216)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 26 Jun
 2026 23:38:15 -0500
From: Geoffrey McRae <geoffrey.mcrae@amd.com>
To: <alexander.deucher@amd.com>
CC: <christian.koenig@amd.com>, <amd-gfx@lists.freedesktop.org>, "Geoffrey
 McRae" <geoffrey.mcrae@amd.com>
Subject: [PATCH] drm/amdgpu: remove gfx sysfs files on device unbind
Date: Sat, 27 Jun 2026 14:38:01 +1000
Message-ID: <20260627043801.1025055-1-geoffrey.mcrae@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|SA3PR12MB7857:EE_
X-MS-Office365-Filtering-Correlation-Id: b655c7ef-9ac0-4446-4e0f-08ded405e92a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: T/cUzyTI+ZT/VddW4HaNOr4endvx/ez9E3vroV+dIx6yCIy+TEArduMF720MDLqphF5u5LST3HZ4HNV6bDE5n2nmVuE5DW+H7AHyjoE79zissFs6SgcFnV5sQ18VifgxCJ6gwJ5pcp0TFbSogCprNjsKy45tmyPeIm0m3SttGkhC06XVRp7H7+UhtHjf64WfJJRi7ZqGyxvb8eKjHtLWH+biaMEygGaUuYJwfU/aOw0PV5cTY7uECJFrS3CwjusL4xG0MguDzEMBwZxBEaf2olBOYA/weTfopJBImWUPz5o7RJu/lZTshbcCTg59ijd4tWbGcrUfnep9Oxr/jJ3Re09cNZzvO+cR8TxpoFnnowak0IGZ4eWI1AW1CkoZKLBjySbaokhX6AKCmvWHqNFJ4lHjm44y5MpOjMVkuuHHYX5BRzSMiSEczuzp5uONhbO0AnOzacOjEerDJ2uKdE0Dyd2RkyLZLFJRKhwhxftP1oJEeBLtmL+aDAyuW714AmJVbccujVXefFBWsjTgNy3YQQ83FKP1cnth/sxXjKNDR+AgEBCuRmKzI54xLo6AOsJ6ozslw052Vt06TYTRmQjTpCCNhX7MXQ4JVHTdXnXm3Puet3N+UsuaOQ1tUUKkj62TaMSwO9ZvSx+iDFyo+yM5cWgnPwDZuwbiYm7zBeeHG1/CgCHFPk052Stf9XDICR6UuiPnGab18Dd2/vCPWrnmIA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WNtW84rZIn07NAbIBAHVIDsWfjzhyjsJRcn8poR/ML5N5/vQKwXyBTiT37yhIUqDYx8rhKlPvHuTFpf/4aVcQfbRnPrzYEJ1k3eZRMWWPcF0IWuU6aYhE8BX8qDWxv73eYaUMFOzsNQvktznmcdJ8yv1zEcYyv7+QMEPLg50vZxEFoFrT19uLWlgWYNLAerPSp4Eojn/YPXPXjqFZt3sw6vYvBtcWHmZP6YDisxlbB58Uu0/RGF0bp+9rSLtGWcWV8NeDtph/SbdQv1/yyqgUVtU4mcEWfOLkBeRtH9qO/8aEOVs2ewaR4Qr8ZhxubFJ69v8WSMTVE/nUVe+pNmBmLlfwUtTrtAXczoZjTUpfVqUX8D/H8VJWLhI/zNSHnJiKK9eSVm4GrkfRR+5v+iZBwUH3Ka5heaGbAyZeOC3V6j2s58z0Y6Rmkp5qFKDqltn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2026 04:38:18.4207 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b655c7ef-9ac0-4446-4e0f-08ded405e92a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7857
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

Fix another sysfs duplication error when reinitializing the device:

  sysfs: cannot create duplicate filename '.../enforce_isolation'

Fix this by:
  - improve amdgpu_gfx_sysfs_init error unwinding so partially-created
    gfx sysfs files are removed on registration failure.
  - added adev->gfx.sysfs_registered tracking so gfx sysfs cleanup is
    idempotent when harware teardown runs before the existing software
    teardown cleanup path.
  - calling amdgpu_gfx_sysfs_fini from amdgpu_device_fini_hw before the
    general device sysfs cleanup.

Signed-off-by: Geoffrey McRae <geoffrey.mcrae@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 32 +++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    |  2 ++
 3 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5442a1fc1c37..7278d68f8021 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4242,6 +4242,7 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 	}
 	amdgpu_fence_driver_hw_fini(adev);

+	amdgpu_gfx_sysfs_fini(adev);
 	amdgpu_device_sys_interface_fini(adev);

 	/* disable ras feature must before hw fini */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index a5b835d0c166..a4616d54adcc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -2195,6 +2195,8 @@ int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev)
 {
 	int r;

+	adev->gfx.sysfs_registered = false;
+
 	r = amdgpu_gfx_sysfs_xcp_init(adev);
 	if (r) {
 		dev_err(adev->dev, "failed to create xcp sysfs files");
@@ -2202,23 +2204,39 @@ int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev)
 	}

 	r = amdgpu_gfx_sysfs_isolation_shader_init(adev);
-	if (r)
+	if (r) {
 		dev_err(adev->dev, "failed to create isolation sysfs files");
+		goto err_isolation_shader;
+	}

 	r = amdgpu_gfx_sysfs_reset_mask_init(adev);
-	if (r)
+	if (r) {
 		dev_err(adev->dev, "failed to create reset mask sysfs files");
+		goto err_reset_mask;
+	}

+	adev->gfx.sysfs_registered = true;
+
+	return 0;
+
+err_reset_mask:
+	amdgpu_gfx_sysfs_reset_mask_fini(adev);
+	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
+err_isolation_shader:
+	amdgpu_gfx_sysfs_xcp_fini(adev);
 	return r;
 }

 void amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev)
 {
-	if (adev->dev->kobj.sd) {
-		amdgpu_gfx_sysfs_xcp_fini(adev);
-		amdgpu_gfx_sysfs_isolation_shader_fini(adev);
-		amdgpu_gfx_sysfs_reset_mask_fini(adev);
-	}
+	if (!adev->gfx.sysfs_registered)
+		return;
+
+	amdgpu_gfx_sysfs_xcp_fini(adev);
+	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
+	amdgpu_gfx_sysfs_reset_mask_fini(adev);
+
+	adev->gfx.sysfs_registered = false;
 }

 static void amdgpu_gfx_reset_start_compute_scheds(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 9432107c96a1..64cb1c1e51fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -477,6 +477,8 @@ struct amdgpu_gfx {
 	struct amdgpu_irq_src		rlc_poison_irq;
 	struct sq_work			sq_work;

+	bool				sysfs_registered;
+
 	/* gfx status */
 	uint32_t			gfx_current_status;
 	/* ce ram size*/
--
2.43.0

