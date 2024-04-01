Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64F9FCD1292
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Apr 2024 10:19:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B460610F026;
	Mon,  1 Apr 2024 10:19:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0CXoktY2";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2063.outbound.protection.outlook.com [40.107.95.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D2A910F026
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Apr 2024 10:19:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILQuBk3J+aNb+TmMtqWB1TKHpYrqnqUc8M9FsX9cMCUCrOQPwwU2rB+vCZQXbTfb20ts5Yl0iTkN6JLyA6YVVJMfNXvmdRdTbFhM10KldvvhW4LmHhUUXz5jqSziXQIbWHFg7u3cr7kKGoMS79wX/qe8GVZAHi9KEZ0imUk/4WKIl8ehTRq8tadCrZokEA2elQ746gfxeWYFbt2dXITelnB5IAZVfHOfk4R2F3U5oTqvTLxrXuEftHpjdU5pDh55PK31qiB+rF1V8d5IiQW9hEJXflEE6Up+auNJHMa0QEeYthkRpzrJqkq/LWNGhzMF/IKDFjzK4QpnoF8vGZJO7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VO+29mE774cUMO7rKFkLCEhGanQSvvjksE1h5t6uXEk=;
 b=Vm1eo+waoZAoVHbavvlpLOzzSbzubEI165/HKxQOm4Qy2sb84VpbjWwgdtEdiQEnmX9xwM7IQQVf0IEbSMGXcBXoKNOoLB8tVEkUH3Whqncc7hoA+lfFL58Vq6ePSO6UsZ5AqDPKyEFSQ9h3/qcvtN8AMz6zmLrIutYCHOk6h4dDAKKVIV6HeQmUF7shlguockTyihi5mEOKkt40e2xImYQc913c5nKSECWvY40u3R/X0GHqhsM4FPPbfReBj4Cj79i6bbcKSX7uCFijsveo9QtTV2fheQ2usCNCZyfm9uxa5Ij9pGzH+KAPhRWb45pU3xQIoidSM442xmsZ6ab9/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VO+29mE774cUMO7rKFkLCEhGanQSvvjksE1h5t6uXEk=;
 b=0CXoktY2NGmKvDCJC9AZ54MqVEhVXuPhkcSVk7QcfawprAP+x3lHG7i8d/EISEly7CUmgXuUZph9wzSPO6G0Ug0BlSiUmzlkhwb5raQwwJ3EPSEmXnucuPNQt74fytaeo6lGlw1cuh9sEtrkXQG5hjmmQgadB5e2QeN/BH5RAAA=
Received: from SA9PR03CA0024.namprd03.prod.outlook.com (2603:10b6:806:20::29)
 by DS0PR12MB9400.namprd12.prod.outlook.com (2603:10b6:8:1b6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 1 Apr
 2024 10:19:50 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:806:20:cafe::50) by SA9PR03CA0024.outlook.office365.com
 (2603:10b6:806:20::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Mon, 1 Apr 2024 10:19:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Mon, 1 Apr 2024 10:19:50 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 1 Apr
 2024 05:19:22 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <Alexander.Deucher@amd.com>
CC: Ma Jun <Jun.Ma2@amd.com>
Subject: [PATCH] drm/amdgpu: Fix discovery initialization failure during pci
 rescan
Date: Mon, 1 Apr 2024 18:18:47 +0800
Message-ID: <20240401101847.3113771-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|DS0PR12MB9400:EE_
X-MS-Office365-Filtering-Correlation-Id: f4d15c8e-3ffb-47c3-d074-08dc523543ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bUBWcs20lnMYVw35JlxZHqBtYGBlWUKTuAqHs+VLkxaWTJfudT//ZjCkv2U7aFS59FsQCimhklslOUTrzMiEspGk+4etpVRHx5oFMxWn4IukXaqHccUOYXqxPtb6rS5L1zYbuOepr200zb/KygqMyK1zjuEu6udyV+8n9/J6wTXPI8X+690noYlpgcePZcQx2iPlKmUipPnjALjIbS1UtoCTShkEjiZ7X6R4w1wR/+LLSzzbfOwbTRQYMe9GOCTE5fuWhoW9TSRqB3N2VYnoJ4DQFVXS0wqj9zR64stLUkwEzvnmkY4DkYFftl94Rl+rBoXj4ZQsgHU3/e9Owm6In/B7puNZPDYbijpU5oFQwsyVYWUWceK2V6ButbzXNialchX/IjT/nqz0r1Jq1jKSFUFEinYwQ1arLZANe/BiRckNumZtG2VbLaBrfynFe6d6AQr4yFEWmS+QT0pZIdnaPPu0WeJVGLMKi4md+LjZo+CFqyX8DEN6AZemGsQPQsWbWJmgXH/Tk6zmaQXDDEyVGl/9MDbxUyBGqlFBhop0Qe0ahodMcxfKLnHzq1DM9FtdXMyHb0ByiO8zfXr+8rllrE/3ruUuAWZDjX1EL+7MymBjR6E2oKFp6pJzpNM79TcINRJdAdjPofnRXT9PBi0v7YtwRGTpyxLbbd9J7tHJL4c6Rl1sWDw3qCZ0EURahqcEcXu/AZkZVnbRkqRDL7DfeCL5a+ZNLWUmySCnjUDqE8G3TOzpNwhccbcj8K5yaTrI
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 10:19:50.1220 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4d15c8e-3ffb-47c3-d074-08dc523543ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9400
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

Waiting for system ready to fix the discovery initialization
failure issue. This failure usually occurs when dGPU is
removed and then rescanned via command line.
It's caused by following two errors:
[1] vram size is 0
[2] wrong binary signature

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 07c5fca06178..ac6b2ae6414c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -276,7 +276,12 @@ static int amdgpu_discovery_read_binary_from_mem(struct amdgpu_device *adev,
 			msleep(1);
 		}
 	}
-	vram_size = (uint64_t)RREG32(mmRCC_CONFIG_MEMSIZE) << 20;
+	for (i = 0; i < 100; i++) {
+		vram_size = (uint64_t)RREG32(mmRCC_CONFIG_MEMSIZE) << 20;
+		if (vram_size)
+			break;
+		usleep_range(1000, 1100);
+	}
 
 	if (vram_size) {
 		uint64_t pos = vram_size - DISCOVERY_TMR_OFFSET;
@@ -371,6 +376,7 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 {
 	struct table_info *info;
 	struct binary_header *bhdr;
+	int error_count = 0;
 	uint16_t offset;
 	uint16_t size;
 	uint16_t checksum;
@@ -380,7 +386,7 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 	adev->mman.discovery_bin = kzalloc(adev->mman.discovery_tmr_size, GFP_KERNEL);
 	if (!adev->mman.discovery_bin)
 		return -ENOMEM;
-
+retry:
 	/* Read from file if it is the preferred option */
 	if (amdgpu_discovery == 2) {
 		dev_info(adev->dev, "use ip discovery information from file");
@@ -401,6 +407,10 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 
 	/* check the ip discovery binary signature */
 	if (!amdgpu_discovery_verify_binary_signature(adev->mman.discovery_bin)) {
+		if (error_count++ < 1) {
+			msleep(100);
+			goto retry;
+		}
 		dev_err(adev->dev,
 			"get invalid ip discovery binary signature\n");
 		r = -EINVAL;
@@ -515,7 +525,6 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 	if (0 && offset) {
 		struct mall_info_header *mhdr =
 			(struct mall_info_header *)(adev->mman.discovery_bin + offset);
-
 		if (le32_to_cpu(mhdr->table_id) != MALL_INFO_TABLE_ID) {
 			dev_err(adev->dev, "invalid ip discovery mall table id\n");
 			r = -EINVAL;
-- 
2.34.1

