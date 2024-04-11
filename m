Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54CF4CD128A
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Apr 2024 11:11:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D9B610F00B;
	Thu, 11 Apr 2024 11:11:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oWrxRf/M";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DCA510F00B
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Apr 2024 11:11:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yy7wwHPjBxNHNVJAGsw0ntARssbwvS4AjwOS8b9f4JSVDshEsuIX3ZaoPbPyMk1ld5rFTX9BtL7hpdrn1vhaigYcmt36bb8hLMp2paXemTIqSAgEqfxJkxWrcwmbKr9Clz08la6z5EECorHg6nY4a6tzslN4mp03S/2tPddMlRmOnhut7HFw6fghLzuGRfISRPTtcHQATBwoOlREwskzUxDqjgDikc8ekrFrUz/ecDZgdFTcpSh9zhy7nS/smzrnqgd/ivAlBm2R78kgWoiiK1NtM4KMAwHTYKcdkgHf62m0XmmzV4zSHwMJFReN6awSK0GGNxW2D1AKvnJCwtEGnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z6gsXoJfL7b43XOTIS9DRHFQn6raoCtY3RK4bD5/r8g=;
 b=Di4nOhMJ5fRrDRgFqtXYL3tcBjYaxOtDh9GgafT5bnNr6puNQQP9a0sgvbIKi+EBSxDlw2ikLdrbCxeuGuAcb18ICeUWrJgx9lpBUjodynV1k4VyLBF3QDzwJXWE8kK404jjTEXiLlvK1kI6Wu22VbIUdzW1q7sBNY1IhRJWgkRzAWGO85OrSAD9ho/ya8YJwBlqGda/5WBD+4iiQkD5wXSmNsI+QotVtc61f+xOXAyHaGwKJv+g0hlTiaOa/XIrB+LkGmVln5Q5uCJsESzLrBsjzve0MQ/B/0L1CeM/RVm9U30irw5+/cShzFZRyEAhfqOMmOyiNmy91mb/P8hiVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z6gsXoJfL7b43XOTIS9DRHFQn6raoCtY3RK4bD5/r8g=;
 b=oWrxRf/MG5w6vpiSv/JhRRXClcidzoMOEM5jd4TbQBFGHAl25+3z/UjEDIATPXfl/bhd5uzJAYmHodipU/LmowD1AouUgPdFCxmXXqNYcUOstjx4RxakQzP6milBIvI8vdQTkdR4E+qlJCytc4alQ7JwELOA0HQj+/JMThhrS8Q=
Received: from DS7PR06CA0024.namprd06.prod.outlook.com (2603:10b6:8:2a::8) by
 MN2PR12MB4408.namprd12.prod.outlook.com (2603:10b6:208:26c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 11 Apr
 2024 11:11:23 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:8:2a:cafe::b7) by DS7PR06CA0024.outlook.office365.com
 (2603:10b6:8:2a::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.22 via Frontend
 Transport; Thu, 11 Apr 2024 11:11:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 11 Apr 2024 11:11:23 +0000
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 11 Apr
 2024 06:11:22 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Stanley.Yang <Stanley.Yang@amd.com>
Subject: [PATCH Review 1/1] drm/amdgpu: Support setting recover method
Date: Thu, 11 Apr 2024 19:11:08 +0800
Message-ID: <20240411111108.3571355-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|MN2PR12MB4408:EE_
X-MS-Office365-Filtering-Correlation-Id: 974b6a10-70d1-43e2-8527-08dc5a181fac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KGADCykc3rrA9Bb2/SpuusTajpIseq2OFfXAU/t5wIfKDwlu3qktPAytOyFnADzu7omzjlhocYhFcuZY5gDIg1PccMP6qoh9eE827kb4Xp6DAKKKuejXMBupn10XsXk3UKSDh2/Sadm9xhzbR9+Bdqq+wX2HMIONRmqnsMBk5KNoeYSpfKHQqQGcdlL5Egx4Nzgb3bqHrdbRr148SpjA1yMksMv+Bk0x95Pqf7aZxyRWNR73evIijfqA5o/2YqmM9xDn/pSzygOnB2AGkqUI6QSW2jlaEjHnsqnCMUBF7z8GU+PJ/j6PJroX1bGwiU8qlKePgP1Ir/B8lYhIfzXGYO6UImVhK1ZcAPvI01ef+G1ZxWxQeOD2mBgC4tB1gZUZxUTUrT8pU7Pj6NoYiqw1crjElGTHwdenUioHX7v4Pk8F6Kib07+jJeZJmNMScgcN+0xw0tRK6axDc4FiIRe8uy9jDkw/OifFJkGd5S7yMjAkSOlfoMjVMhdr1IY/121rmAxzuvwE05QOESMoBVdw6+ZsGtvM0OyhgAsk2SZHratsYbxwPF8kb9/JoHP/MibDBNsfMJv3hLXtvzJyP70RLdfvCNiK2qOcjagZCx20NrBV3gDbaaPR2ZK2ST2xeImkCggjM98dk8ht9rTq6InYGHEyXr0noXws1BotMh5IYz5vR+ExiJJp2UkdaNsXZloYYAZRUqtvCZbZS6inwCphGfQYZ0dkM0CSp6zdHy3gMnJfNFYxda63LJJLm6RK+dJh
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 11:11:23.5945 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 974b6a10-70d1-43e2-8527-08dc5a181fac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4408
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

Don't modify amdgpu gpu recover get operation,
add amdgpu gpu recover set operation to select
reset method, only support mode1 and mode2 currently.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  3 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  | 37 +++++++++++++++++++---
 3 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 9c62552bec34..c82976b2b977 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1151,6 +1151,9 @@ struct amdgpu_device {
 	bool                            debug_largebar;
 	bool                            debug_disable_soft_recovery;
 	bool                            debug_use_vram_fw_buf;
+
+	/* Used to set gpu reset method */
+	int                             recover_method;
 };
 
 static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 3204b8f6edeb..8411a793be18 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3908,6 +3908,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	else
 		adev->asic_type = flags & AMD_ASIC_MASK;
 
+	adev->recover_method = AMD_RESET_METHOD_NONE;
 	adev->usec_timeout = AMDGPU_MAX_USEC_TIMEOUT;
 	if (amdgpu_emu_mode == 1)
 		adev->usec_timeout *= 10;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 10832b470448..e388a50d11d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -965,9 +965,37 @@ static int gpu_recover_get(void *data, u64 *val)
 	return 0;
 }
 
+static int gpu_recover_set(void *data, u64 val)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)data;
+	struct drm_device *dev = adev_to_drm(adev);
+	int r;
+
+	/* TODO: support mode1 and mode2 currently */
+	if (val == AMD_RESET_METHOD_MODE1 ||
+		val == AMD_RESET_METHOD_MODE2)
+		adev->recover_method = val;
+	else
+		adev->recover_method = AMD_RESET_METHOD_NONE;
+
+	r = pm_runtime_get_sync(dev->dev);
+	if (r < 0) {
+		pm_runtime_put_autosuspend(dev->dev);
+		return 0;
+	}
+
+	if (amdgpu_reset_domain_schedule(adev->reset_domain, &adev->reset_work))
+		flush_work(&adev->reset_work);
+
+	pm_runtime_mark_last_busy(dev->dev);
+	pm_runtime_put_autosuspend(dev->dev);
+
+	return 0;
+}
+
 DEFINE_SHOW_ATTRIBUTE(amdgpu_debugfs_fence_info);
-DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_debugfs_gpu_recover_fops, gpu_recover_get, NULL,
-			 "%lld\n");
+DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_debugfs_gpu_recover_fops, gpu_recover_get,
+			 gpu_recover_set, "%lld\n");
 
 static void amdgpu_debugfs_reset_work(struct work_struct *work)
 {
@@ -978,9 +1006,10 @@ static void amdgpu_debugfs_reset_work(struct work_struct *work)
 
 	memset(&reset_context, 0, sizeof(reset_context));
 
-	reset_context.method = AMD_RESET_METHOD_NONE;
+	reset_context.method = adev->recover_method;
 	reset_context.reset_req_dev = adev;
 	set_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
+	adev->recover_method = AMD_RESET_METHOD_NONE;
 
 	amdgpu_device_gpu_recover(adev, NULL, &reset_context);
 }
@@ -999,7 +1028,7 @@ void amdgpu_debugfs_fence_init(struct amdgpu_device *adev)
 	if (!amdgpu_sriov_vf(adev)) {
 
 		INIT_WORK(&adev->reset_work, amdgpu_debugfs_reset_work);
-		debugfs_create_file("amdgpu_gpu_recover", 0444, root, adev,
+		debugfs_create_file("amdgpu_gpu_recover", 0666, root, adev,
 				    &amdgpu_debugfs_gpu_recover_fops);
 	}
 #endif
-- 
2.25.1

