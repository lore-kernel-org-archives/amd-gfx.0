Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6A94C27C50
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 06:53:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F146710E7CC;
	Fri, 31 May 2024 06:53:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="c8NSQ1/H";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A33B10F2E3
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 06:53:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MtkFWIJI7ybrYrQxitwBGoonFzLoNGqZobzPsxpuP2VaPf5YQJ3GzIWNOLXwKuNV43o2YvYE9m2f+RgbYT/cSWUY0uZEBnd5XBPYtxYAUNcTwh/ND6Mec4cO0Bj+CEjTur1gN0xvFC8On0ez5QhiOqM3i4IOcPJVztNXu9QiTQ/Lhrjt1ubGJXI1jGVCfeq9KvuglqC/DVqastfAQ9EpYA2aKQZs20NQbTaP57Of7Evwjh1EqEfyPrFuJOFyDhc3OhxI9jT1i/TWlLwe2mkzwVS3CYLj3wdsZe8ms7YPOhAgveQagbTBFvCgh7XDVpzcReXd4gnIj8dBJt0ddx4k9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/3YGVycEgCLrLlTayr+Q8g0axa2aUP4YjRww9iyKU58=;
 b=TapIRHnuQu1W5Ou4+gVz6YBsSBYhGwnru4TrNKh83VFoFJrvvyo85BzR3Tz3xRzqiBlJCW1J82J8wBOXttl1lBIWgsw0S6vvwCpl6TXv0hp1liIc5oWJEDvSRvmEFOcxgyLYbDdcW3NnCt7xiXcrbgEx12/Y4yxHg3sD3w4J+xWkHGmwuxMKgtY5fm1GbC802ppGG1hn6h82E3PJOnoOpSds8Trvv7h+35CidQ3BJfuzkm6UXvCdrLPmYM7B0KoYOiRbfacLVOCmGyXOyABK62lrld5lV6G4RBVFMUKSr8/uIuRK4Le8jFM/0jyc8ezj958JsRqjBUKCAx19Ap03ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/3YGVycEgCLrLlTayr+Q8g0axa2aUP4YjRww9iyKU58=;
 b=c8NSQ1/HahJeSM/njUbIyZT6Cpy5Q5K9Ds+v7ehuye3mztA8U6+kFpasbpV6KjP5geSl5mfWoQATFjAi1pt2SQfTtMQl5n2dMqdd91tVrpifFfsWwezya9j8vZucVvuuzqIfkx2xSVzvobN/wNqbdqjTo7EKJ/NBtRqDEUGP+U0=
Received: from SJ0PR03CA0098.namprd03.prod.outlook.com (2603:10b6:a03:333::13)
 by MN2PR12MB4304.namprd12.prod.outlook.com (2603:10b6:208:1d0::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Fri, 31 May
 2024 06:53:12 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::b7) by SJ0PR03CA0098.outlook.office365.com
 (2603:10b6:a03:333::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21 via Frontend
 Transport; Fri, 31 May 2024 06:53:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 06:53:12 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 01:53:10 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 08/18] drm/amdgpu: refine pmfw/smu firmware loading
Date: Fri, 31 May 2024 14:52:39 +0800
Message-ID: <20240531065249.1746350-8-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531065249.1746350-1-kevinyang.wang@amd.com>
References: <20240531065249.1746350-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|MN2PR12MB4304:EE_
X-MS-Office365-Filtering-Correlation-Id: 98b22163-2529-4870-1b74-08dc813e56b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|82310400017|1800799015|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?N/S94kqM168a1ISqmhvuQrA61ZS0cfXIUFnCHLzXuTS6DtPWD2KPlJ0D3miz?=
 =?us-ascii?Q?gGZsnzLoLW8Z9fkd7S7OADWnw1VMFzf4WthmcDd2TPmxhejTPkKtUXHSPwyF?=
 =?us-ascii?Q?/IHXuPXu4Dv8SkdXzpcyAdfiI7wmkOHsGiSEiItDLi2V74GRSyY0ucUaxPAP?=
 =?us-ascii?Q?VxzyDLwjHL99Gezjsyq/7oQT4eXUu2s9/+exjGr1ulljdkgalWuXjEbL+hLn?=
 =?us-ascii?Q?kznwLIT9tWTupg+QnBrpcYhQesi0YKUDPOYWxxdKgZYUtMYChUAh54Wy2bsB?=
 =?us-ascii?Q?4zbO10k00GVghVkrwKmBF6Uzil+1hOSsBF9vFPReXXm97eUWxzIYpx8Pies5?=
 =?us-ascii?Q?nPMOnz2Q6MDbjv4k3BvnLHqJvCdOim3T5/oq0g2uC24QX+P4+KeBowV5DjZF?=
 =?us-ascii?Q?MM0nvQuwBDiZckkGlsSYnCBajk7x+LeYY8sbMBmC/3U6jigbgUsqI3KfO364?=
 =?us-ascii?Q?BLj7PZQR9qoyxpbRQHPtehq7eBk5v7BhS4uqojC9gP2L97J+vJL/qDuHWza6?=
 =?us-ascii?Q?22Mm7/FCpybWKkiw1YXCaCDZtD4clSwC7EMl707ZMUM0EfDbWPxwu14x8gOw?=
 =?us-ascii?Q?s/fUVQM1YSnISPQfjoF0xf9a+QCNFcShnjumJGLKV7s9nAkEUQ8mRzn1dGiv?=
 =?us-ascii?Q?dp5SqFrWkwQ4+KzY/m7t9Kzi/vyidh0RwFswTFvYo5IhvJVOJewbkP1z5g+4?=
 =?us-ascii?Q?J2A3/X46SYYbH5IDG6T2pSXAcbgXlzJdMaFNfVCJ5XLwtDt0jUem2HGM2n2U?=
 =?us-ascii?Q?4fJJMVFmPv15gMLpkPjStCrmruAVhAuqlmaMEyLliFo3o8EMXWKTxB48pmsm?=
 =?us-ascii?Q?6WCgEx6ziAYJV1HsK3SCmvkOpCpLQIqOXEYJ1JwHvQKto+gI3OqeHcktdj3D?=
 =?us-ascii?Q?fyqRfXZZJ9gqXEiLuEw3OxbIOjk/oh8D5oiFD26Y+pHbK8kVMYq9LrisNeOz?=
 =?us-ascii?Q?ROoi/0rtl1yzYLBiWG0Ykt1RGffdA/QTCVvaHXhiVhrKEfJ1W3e/CQz7Scnr?=
 =?us-ascii?Q?Xdl+COsY8/s1SU8XngA/etwZceV61QB5zzgtT2IL2Z3KrE3TqMcoCOHulYZV?=
 =?us-ascii?Q?zp3ToTkoV7Pa6CUjG2wexQOWFS9kNlc/0ew0ZXSKKdPkFkPc9LUtld9gQQ59?=
 =?us-ascii?Q?eTKnWodAfFOVUZpjumFZeyqtXDzNMxuPH2cDVLEVhfankzG7XM742MNTrDhj?=
 =?us-ascii?Q?ZAx839doNxmtPAiOQFQps/Mdxj6HKcKQAvK86Fb+wJeaYoIZuLVT8cIXF946?=
 =?us-ascii?Q?Ym6oDWdQ+j/vXpl+L6leg1QHVNjY8WcM1l50psCpnVQR8pvFwp0mpF6AyPnq?=
 =?us-ascii?Q?T5NkfJgqJqGE369SsXJ+YcpPe4/lUlDZwWRD7/0Cb321GOMHQQKoqbjBoOQc?=
 =?us-ascii?Q?sb5L9qc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400017)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 06:53:12.1379 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98b22163-2529-4870-1b74-08dc813e56b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4304
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

refine pmfw/smu firmware loading

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c           | 8 +++-----
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c       | 6 +-----
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c       | 6 +-----
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 6 +-----
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c       | 6 +-----
 5 files changed, 7 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index 68ac01a8bc3a..c1a553a68251 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -7652,7 +7652,6 @@ static int si_dpm_late_init(void *handle)
 static int si_dpm_init_microcode(struct amdgpu_device *adev)
 {
 	const char *chip_name;
-	char fw_name[30];
 	int err;
 
 	DRM_DEBUG("\n");
@@ -7712,11 +7711,10 @@ static int si_dpm_init_microcode(struct amdgpu_device *adev)
 	default: BUG();
 	}
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_smc.bin", chip_name);
-	err = amdgpu_ucode_request(adev, &adev->pm.fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->pm.fw, "amdgpu/%s_smc.bin", chip_name);
 	if (err) {
-		DRM_ERROR("si_smc: Failed to load firmware. err = %d\"%s\"\n",
-			  err, fw_name);
+		DRM_ERROR("si_smc: Failed to load firmware. err = %d\"%s_smc.bin\"\n",
+			  err, chip_name);
 		amdgpu_ucode_release(&adev->pm.fw);
 	}
 	return err;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 9d5ab2ea643a..16fcd9dcd202 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -94,7 +94,6 @@ int smu_v11_0_init_microcode(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
 	char ucode_prefix[25];
-	char fw_name[SMU_FW_NAME_LEN];
 	int err = 0;
 	const struct smc_firmware_header_v1_0 *hdr;
 	const struct common_firmware_header *header;
@@ -106,10 +105,7 @@ int smu_v11_0_init_microcode(struct smu_context *smu)
 		return 0;
 
 	amdgpu_ucode_ip_version_decode(adev, MP1_HWIP, ucode_prefix, sizeof(ucode_prefix));
-
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);
-
-	err = amdgpu_ucode_request(adev, &adev->pm.fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->pm.fw, "amdgpu/%s.bin", ucode_prefix);
 	if (err)
 		goto out;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 3a50076e44f0..e17466cc1952 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -92,7 +92,6 @@ const int pmfw_decoded_link_width[7] = {0, 1, 2, 4, 8, 12, 16};
 int smu_v13_0_init_microcode(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
-	char fw_name[30];
 	char ucode_prefix[15];
 	int err = 0;
 	const struct smc_firmware_header_v1_0 *hdr;
@@ -104,10 +103,7 @@ int smu_v13_0_init_microcode(struct smu_context *smu)
 		return 0;
 
 	amdgpu_ucode_ip_version_decode(adev, MP1_HWIP, ucode_prefix, sizeof(ucode_prefix));
-
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);
-
-	err = amdgpu_ucode_request(adev, &adev->pm.fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->pm.fw, "amdgpu/%s.bin", ucode_prefix);
 	if (err)
 		goto out;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 15c0aa0ad443..c2b706396dfd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -272,7 +272,6 @@ static int smu_v13_0_6_init_microcode(struct smu_context *smu)
 	uint32_t p2s_table_id = P2S_TABLE_ID_A;
 	int ret = 0, i, p2stable_count;
 	char ucode_prefix[15];
-	char fw_name[30];
 
 	/* No need to load P2S tables in IOV mode */
 	if (amdgpu_sriov_vf(adev))
@@ -283,10 +282,7 @@ static int smu_v13_0_6_init_microcode(struct smu_context *smu)
 
 	amdgpu_ucode_ip_version_decode(adev, MP1_HWIP, ucode_prefix,
 				       sizeof(ucode_prefix));
-
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);
-
-	ret = amdgpu_ucode_request(adev, &adev->pm.fw, fw_name);
+	ret  = amdgpu_ucode_request(adev, &adev->pm.fw, "amdgpu/%s.bin", ucode_prefix);
 	if (ret)
 		goto out;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
index 8cce17d1f230..5ffd7144d99e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -68,7 +68,6 @@ MODULE_FIRMWARE("amdgpu/smu_14_0_3.bin");
 int smu_v14_0_init_microcode(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
-	char fw_name[30];
 	char ucode_prefix[15];
 	int err = 0;
 	const struct smc_firmware_header_v1_0 *hdr;
@@ -80,10 +79,7 @@ int smu_v14_0_init_microcode(struct smu_context *smu)
 		return 0;
 
 	amdgpu_ucode_ip_version_decode(adev, MP1_HWIP, ucode_prefix, sizeof(ucode_prefix));
-
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);
-
-	err = amdgpu_ucode_request(adev, &adev->pm.fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->pm.fw, "amdgpu/%s.bin", ucode_prefix);
 	if (err)
 		goto out;
 
-- 
2.34.1

