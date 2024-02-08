Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E262C48260
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Feb 2024 05:53:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78C4910E0EF;
	Thu,  8 Feb 2024 05:53:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L0tInS8J";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12C7E10E13B
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Feb 2024 05:53:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZRMvYdD1tnQk1oo5SUyTg1crA+9q/uWbQRM/7k8GpOoSxbAqG3+fEleiQJi6SiFXTlOCWBaFq7RaNEnk5Fdmug2Cy9xTLvnJ8hJehK0ce/L0r3czolZUJAqOkdvBydwAyPD8uHSMvdQalCm+yIJdntMpFGCR+h0q5/S8822dVgVtgoMQZ34dtsqD4jeow7E26+JHbAKuwWhsOojuo/3zI3GjZUmvOi7kciZFByxnuF9WVtvh6GBpUSkRJJ0qv492Ultn2+NovvPPY07mjp7uRc+8sLivV0qVQNkS1jwE40uqKOGgSDP1nPCQZZuPnlWwSN2o+Q7YZ5oz4LAgfe8Zjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WWirHPPrpLbuwLQCOy8zX+5BhnIcmOsAGcN1z1xtcQw=;
 b=PIKdajBs0TxUMdgM6rUZ7pcNGlMj7axcQtciPBvJzfRvzzU4ORciGTT4XbjIvID2SC5bEDMyOYh4ROLiSfc6GQeCEy7Plorqn2fTWk4Bn5GwHJA2Y+11p0ZaPKhNmYZKZCxKOeqi5bmYpw3ub5w2S6R47rB9Dly9zWSH5S1Y8MY/hd2YsNpsibfmDkJoylaI0t/4QS047qBfRbtKQUPkx9Q93asS/N/Tz4XuxRhMxq/stBxYsradE60AlL+xDFCYfm088tPOj5nfmM94sf8pG6bG5CIO9BAqiPgSTtrWXN5maDB0xNT/wk+IcHBF4V/y1Qqqw8MVMxUhjtRWhfTNlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WWirHPPrpLbuwLQCOy8zX+5BhnIcmOsAGcN1z1xtcQw=;
 b=L0tInS8JMqQ8tVZ2cc/Hbq4rVogf4kdqzc7gNLJLyDi5CLLYPG0d4UVK7x/3sRAnaQ6veDti71qcGiZZ3oCFFyJS16NXkOuf5wC1ar3nS6od0b9WbuJ9oIcfOjv+a3TMcXmDOJe27RYL7c4M/v2eWq3bf48L+bMcb7W9xFVA5KI=
Received: from MN2PR06CA0002.namprd06.prod.outlook.com (2603:10b6:208:23d::7)
 by DM6PR12MB4107.namprd12.prod.outlook.com (2603:10b6:5:218::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.8; Thu, 8 Feb
 2024 05:53:16 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:208:23d:cafe::97) by MN2PR06CA0002.outlook.office365.com
 (2603:10b6:208:23d::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.42 via Frontend
 Transport; Thu, 8 Feb 2024 05:53:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Thu, 8 Feb 2024 05:53:15 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 7 Feb
 2024 23:53:11 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v4 3/3] drm/amd: Drop unneeded functions to check if s3/s0ix
 active
Date: Wed, 7 Feb 2024 23:52:56 -0600
Message-ID: <20240208055256.130917-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240208055256.130917-1-mario.limonciello@amd.com>
References: <20240208055256.130917-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|DM6PR12MB4107:EE_
X-MS-Office365-Filtering-Correlation-Id: bc66bf48-dc12-4c6a-0950-08dc286a3e87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Py3wzPT65fKSe4vLhLWBRJmegroyhm2Ul4HpfnhEZmBY5iMyFHVmlY1kZF7rE7XsWFGepNZq41Nviecd0CyoPHzd11OnuyAkFF5flj8d0TuTt9THh2kN4tOl+ueP5mLS+a0kmiKada37Q6w90HLxgmyS2HLOX25Nta5jAjg36LJI1oywyRyc6O7ytq2G35012/8nGApQzHgYfylFwUO92k/QldmKFqMotaa8ereAnoieZ10VBJlapJffQNhTnqKk6gLSGvsqAIZPwXfj3zPLjYkOr7JEtuDBceL17iHtdatKE79aq/kqaIDpd0UkeEF5m0vdCOq3YLG9f9vHz+UgRTPHOEtHLOpEZEW7EdD0LIt3wn850YgWzm6YxJqnHVWhw0QFHuLzPTR3jlI+euTZ17ZX65IBgc8LKCaqRYbpUfYssXuqQO+qVrlQ+z7Id959gX61NhBmRLAYlRtcM3WJQg62BfgANVmPUvuRq/WOQkUOObuB0yFQ23urYC3Bnj6MXUVO08mMDlZgg74Y8dDCx6nosZl3QryKBaLqqvATLRVEdBxslft/4iVOyNeYjvjHj7ewnEC3hMFSxX0hWNrCb5FOKDV7viq/dGyW4Of8XC4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(136003)(376002)(396003)(230922051799003)(451199024)(186009)(64100799003)(82310400011)(1800799012)(46966006)(36840700001)(40470700004)(356005)(41300700001)(336012)(6916009)(2906002)(4326008)(5660300002)(86362001)(8936002)(82740400003)(70206006)(44832011)(70586007)(8676002)(7696005)(83380400001)(478600001)(36756003)(6666004)(426003)(316002)(16526019)(1076003)(2616005)(81166007)(26005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 05:53:15.9980 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc66bf48-dc12-4c6a-0950-08dc286a3e87
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4107
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

amdgpu_acpi_is_s0ix_active() and amdgpu_acpi_is_s0ix_active() aren't
needed to be checked multiple times in a suspend cycle.  Checking and
setting up policy one time in the prepare() callback is sufficient.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v4: New patch
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  4 ----
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c |  7 +++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  | 17 ++---------------
 3 files changed, 5 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index f6c38a974bae..53823539eba5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1545,12 +1545,8 @@ static inline int amdgpu_acpi_smart_shift_update(struct drm_device *dev,
 #endif
 
 #if defined(CONFIG_ACPI) && defined(CONFIG_SUSPEND)
-bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev);
-bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev);
 void amdgpu_choose_low_power_state(struct amdgpu_device *adev);
 #else
-static inline bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev) { return false; }
-static inline bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev) { return false; }
 static void amdgpu_choose_low_power_state(struct amdgpu_device *adev) { }
 #endif
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index cc21ed67a330..1d58728f8c3f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -1366,8 +1366,7 @@ bool amdgpu_acpi_should_gpu_reset(struct amdgpu_device *adev)
 	    adev->gfx.imu.funcs) /* Not need to do mode2 reset for IMU enabled APUs */
 		return false;
 
-	if ((adev->flags & AMD_IS_APU) &&
-	    amdgpu_acpi_is_s3_active(adev))
+	if ((adev->flags & AMD_IS_APU) && adev->in_s3)
 		return false;
 
 	if (amdgpu_sriov_vf(adev))
@@ -1472,7 +1471,7 @@ void amdgpu_acpi_release(void)
  *
  * returns true if supported, false if not.
  */
-bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev)
+static inline bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev)
 {
 	return !(adev->flags & AMD_IS_APU) ||
 		(pm_suspend_target_state == PM_SUSPEND_MEM);
@@ -1485,7 +1484,7 @@ bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev)
  *
  * returns true if supported, false if not.
  */
-bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev)
+static inline bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev)
 {
 	if (!(adev->flags & AMD_IS_APU) ||
 	    (pm_suspend_target_state != PM_SUSPEND_TO_IDLE))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 971acf01bea6..2bc4c5bb9b5a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2456,13 +2456,6 @@ static int amdgpu_pmops_prepare(struct device *dev)
 	    pm_runtime_suspended(dev))
 		return 1;
 
-	/* if we will not support s3 or s2i for the device
-	 *  then skip suspend
-	 */
-	if (!amdgpu_acpi_is_s0ix_active(adev) &&
-	    !amdgpu_acpi_is_s3_active(adev))
-		return 1;
-
 	return amdgpu_device_prepare(drm_dev);
 }
 
@@ -2476,10 +2469,6 @@ static int amdgpu_pmops_suspend(struct device *dev)
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(drm_dev);
 
-	if (amdgpu_acpi_is_s0ix_active(adev))
-		adev->in_s0ix = true;
-	else if (amdgpu_acpi_is_s3_active(adev))
-		adev->in_s3 = true;
 	if (!adev->in_s0ix && !adev->in_s3)
 		return 0;
 	return amdgpu_device_suspend(drm_dev, true);
@@ -2510,10 +2499,8 @@ static int amdgpu_pmops_resume(struct device *dev)
 		adev->no_hw_access = true;
 
 	r = amdgpu_device_resume(drm_dev, true);
-	if (amdgpu_acpi_is_s0ix_active(adev))
-		adev->in_s0ix = false;
-	else
-		adev->in_s3 = false;
+	adev->in_s0ix = adev->in_s3 = false;
+
 	return r;
 }
 
-- 
2.34.1

