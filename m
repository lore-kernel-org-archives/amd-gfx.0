Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F2B4CD343F
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2026 20:31:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0F5010E387;
	Fri, 15 May 2026 20:31:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4UyRZVu1";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011051.outbound.protection.outlook.com [52.101.52.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0575F10E387
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 May 2026 20:31:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oXPWSAnLeSI8jiWggPYtD02VURKC05x6dDbKQIAOhOtvKLYJ7W+BSiH2Phi943YfccmnM9OeucF2YaJ+rfpCAyGlImu73Q2dl8h+XsGItR3AvuViqkyZKwQNJxRLVGDIC07KBOJ3yLtstDyQra1xtQb68SP3KbNEUxP+tAphvaSgYTNDLn7xlq22z08BnSChL/2nMIF0qXmowoRdMHe0+5WfZpjiSVaiCJNL42LQHA/aTs9ZTUL+Krak0CchDUKME74SHs7JT+icFK15YmW2SdsSk+Jkia43IHiwZZlDS6U5iIiCfdQwL2xbFEdgUX7AljeEORGMwkEv4SxVIdToSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=myauAy6HvIWIyZSafEaiWMw63f4hpHyQP8PatBERmGI=;
 b=TYUml2K6Gl0bCdhw0saTollFevR5dnBEjjpNjyuInFH1BhuYsZVn48gtKvOT8tHFJIpSrOFruI4wGliQcpO4GBeLcLF9J1WPt98bCJzXNeq7FJqtvYrDwGVk+XNgkO546IkA7Stak/dOeoelxLJC2SB7W1CwmZNEHLYeuNMsrr26UY78a1VYg9iGKOR5v108JIJuPoegyMY2UbKZKukEJIxBZS6kzB9BYAgq0HArpxd4QCb9iayw/+swKkMEsR3LA9rBrkWD1am5J1rsFrdk/wE4/2abXFRKdhT/2q30+7Vw1xnVjdURdI/aYpfwMCKbYVhbqxg2ZlC1T5aedRJgvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=myauAy6HvIWIyZSafEaiWMw63f4hpHyQP8PatBERmGI=;
 b=4UyRZVu1TyFqAKIzzTIOLAaOW89Ho99ncgDwlKEFbeRSDfRqlJvfcQIBZ/EB8k/rm68KoyRa9+bir/VMhqffQ6h/QWNKJT+XNwMcDQ8scvicgGM+GacFfKb5Bu4aYsrYJwvoFmlfjYitOfCwqz6DFKS5EaFZMSOtpVSGet9VbD4=
Received: from CYXPR02CA0018.namprd02.prod.outlook.com (2603:10b6:930:cf::11)
 by PH8PR12MB6916.namprd12.prod.outlook.com (2603:10b6:510:1bd::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Fri, 15 May
 2026 20:31:08 +0000
Received: from CH2PEPF0000009D.namprd02.prod.outlook.com
 (2603:10b6:930:cf:cafe::98) by CYXPR02CA0018.outlook.office365.com
 (2603:10b6:930:cf::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.18 via Frontend Transport; Fri, 15
 May 2026 20:31:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009D.mail.protection.outlook.com (10.167.244.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Fri, 15 May 2026 20:31:06 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 15 May
 2026 15:31:06 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] drm/amd: Reduce code duplication in runtime PM
Date: Fri, 15 May 2026 15:30:57 -0500
Message-ID: <20260515203057.134339-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009D:EE_|PH8PR12MB6916:EE_
X-MS-Office365-Filtering-Correlation-Id: 913d2e9d-d274-4374-1000-08deb2c0e42f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|11063799003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: x9zjUAwEf+KYpjauPWF35nkv1X0WwzVjtUZPUtZZG3sPFU6SxXtiu5hKTCrVIsGc4yBSd9/nANKpJp+2U8aS6kMFLL+vw3mSYz8SKSyzms6n1qbmbKnVwVIVr6VVMZ03H5UeK8IwX7IYXhtUcSw8gkZ0FFFqeOcD5mazG0fEHCsKTUtRozOcqASbnVhhFYQWsm+z9vi3JilXqDdl5AimLgl4vcBh8MZIc4iGs+Ns/I52a0fVAON8VGH2ulr4Uqc1JEPsLgKkbknuY3s98XkFGDdGBSoUG2BeAtGeiuNBDUqKNrRw9puZgVmz6Q0/0jt0ayWIUvVra8GP5FaX2P3nUInwvP4HQ5p0e10Kbj+3lbb7nf+jTtevciNuXOr43gwvmGjSDPKrmMAtVvZcUidkAUwz0IJr66fWvNT5nTr3LiccrnLc7+by7u4EshHKYq6ZkK+7MNrTP7e8pPT2FBFSQvqjp1z593CnMn15+pRz8m3vhYw2A5DeryvV52n0O2fefIyvmb5x1GZ2VKAKd3f4hVNqVb8IU4E7NJ7PPnES4gAYtqMOiQiVjbDOD5AA++vxtz36iDfm3CF4u4hRsCfWIjSQmrqdjZgXS2g+GERngB1+E56MfxWGwiNEWqqqH4atHmJJPzrhpV5KpSK6QTqhkD0bb/MOB3dmqahxbkLKRgkPrl60ZkOIZ8yUMagzF7vOFM5k3fyrU5cDk98zg2XYVSJE1cZS3MuHVlDjRRumrb8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(11063799003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cn6zcZPaT6NfRIsCZe6+vJchq5ZillNdXwZiIT1Lu7DUFJoNzwcflsyrnh6VxWDT6KTMVCtXABm3NxBQmnA51gDd3p1voLl7DSZ1ZoI32v9NAjZK50eRyk6G+B/jSli7Y7UnLF9gmEIqgpYMJMqygChMs8c+XhR8yFu3XtTkhLX4D0zw/Zov9gW6JhqLLuBD/LUDbPSrt7TIa8s9RcekHPnP07KSTYRE5QaMzhH2h68X7YiVPhvga3qcwT/jeVX5USyEwdhGMXRGKBiz71NMbOR8Bhrb3PIao9Zx2D539n9nWJ9IrAQ/9n7cNmrEJKDkCY3ina2IwP9fTFi6IL3TWSRgIiih56OdoNAMvhOtdWkBwh+PoK484sKFdVZbWa5QLJrtUw18w3FNpmVvNNNAKWskwvYZ8tzZkCE5B6JwH8c/FqZSZOqKD7Xp5zKASJJe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 20:31:06.4671 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 913d2e9d-d274-4374-1000-08deb2c0e42f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6916
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

[Why]
amdgpu_pmops_runtime_suspend() runs almost the same code  that
amdgpu_pmops_runtime_idle() runs. That is there is pointless code
duplication.

[How]
Move amdgpu_pmops_runtime_idle() up, extract common code and then
call from both functions.  No intended functional changes.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 50 ++++++++++++-------------
 1 file changed, 24 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index b422513fe3793..15a2dddede2a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2797,12 +2797,11 @@ static int amdgpu_runtime_idle_check_userq(struct device *dev)
 	return xa_empty(&adev->userq_doorbell_xa) ? 0 : -EBUSY;
 }
 
-static int amdgpu_pmops_runtime_suspend(struct device *dev)
+static int amdgpu_pmops_runtime_checks(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct drm_device *drm_dev = pci_get_drvdata(pdev);
+	struct drm_device *drm_dev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(drm_dev);
-	int ret, i;
+	int ret;
 
 	if (adev->pm.rpm_mode == AMDGPU_RUNPM_NONE) {
 		pm_runtime_forbid(dev);
@@ -2812,7 +2811,27 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
 	ret = amdgpu_runtime_idle_check_display(dev);
 	if (ret)
 		return ret;
-	ret = amdgpu_runtime_idle_check_userq(dev);
+
+	return amdgpu_runtime_idle_check_userq(dev);
+}
+
+static int amdgpu_pmops_runtime_idle(struct device *dev)
+{
+	int ret;
+
+	ret = amdgpu_pmops_runtime_checks(dev);
+	pm_runtime_autosuspend(dev);
+	return ret;
+}
+
+static int amdgpu_pmops_runtime_suspend(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct drm_device *drm_dev = pci_get_drvdata(pdev);
+	struct amdgpu_device *adev = drm_to_adev(drm_dev);
+	int ret, i;
+
+	ret = amdgpu_pmops_runtime_checks(dev);
 	if (ret)
 		return ret;
 
@@ -2924,27 +2943,6 @@ static int amdgpu_pmops_runtime_resume(struct device *dev)
 	return 0;
 }
 
-static int amdgpu_pmops_runtime_idle(struct device *dev)
-{
-	struct drm_device *drm_dev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = drm_to_adev(drm_dev);
-	int ret;
-
-	if (adev->pm.rpm_mode == AMDGPU_RUNPM_NONE) {
-		pm_runtime_forbid(dev);
-		return -EBUSY;
-	}
-
-	ret = amdgpu_runtime_idle_check_display(dev);
-	if (ret)
-		goto done;
-
-	ret = amdgpu_runtime_idle_check_userq(dev);
-done:
-	pm_runtime_autosuspend(dev);
-	return ret;
-}
-
 static int amdgpu_drm_release(struct inode *inode, struct file *filp)
 {
 	struct drm_file *file_priv = filp->private_data;
-- 
2.43.0

