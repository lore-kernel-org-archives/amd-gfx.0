Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBF64C27C44
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Jun 2024 01:43:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 069C710E21D;
	Mon,  3 Jun 2024 01:43:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="en60wzAT";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2066.outbound.protection.outlook.com [40.107.102.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA67F10E1FC
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Jun 2024 01:42:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nbh4FTrfNPdp+6eX+dW5+kLH26+kpIsDXkGMQJaFwliAZIPNtbuGrC6/2k1GFzYYK8G6x5cI4SO1Dbp/MNWATzjAxx+JCrQ0BEoY13umtAFYEazuAsXgy//hwDXltpftADltWMiN9rvV1Qx8rCLIKEYEmM9R7SeTJSc4jPUm4etF9OvbL95wjj6k+WVM3CmJsYH1neqw0WbU9duusCDs/RhrFY7NxALgD9f+gdLCYJ/IeVDFHZnD7LJrEkTdBH5BR+Lix6xIeV6lCP/vmuSUYsumzKk+598hSWwNFs3yCY8QzFQpXbJsAtvDMAbKLH1lddGKxhOjMRMzBci+TxzmUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/3YGVycEgCLrLlTayr+Q8g0axa2aUP4YjRww9iyKU58=;
 b=na5zOUhmdn4gs+AxC4RcyOIn9XWiYMZFf1OU+Lf9OA+bdeDrBrE6EhIMsRs18/R8UKP/LzYP8pABXG+u2bD2IYe6hi/XS0wSZshSJ9gSZvy/WTrqspVAgVyv+COoiMbtlyjCJrC8fYQnBNWt35kSt1KANqo4abXk4+JUwOtUl+jkOnXSLo3Bc1b5iKTUOszaL4HG7kTffaO1rn1Oz+6ALlGpHLPyqACiwdUT9H0Y8xDSXeTk+DrSKQpV6xwpJUdyBeiMj/70Za6VRf/JGt9LH/jCje41C6IQGRZJtOwkc648T9wThmk3nwfLpIHTPCZ5fYFRR4wfNKGavvwT93/mcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/3YGVycEgCLrLlTayr+Q8g0axa2aUP4YjRww9iyKU58=;
 b=en60wzAT8MMNM4EVkDcLA2Ihf8cY6uE4N0O1T4FplbkZzbT392U6e37IpAUa5McRSoEhzan9QFvXeFvDmVCm3cAlILwUJk71c12XIOlgucGfALPz1hUB0PDOn0nZguZ7zT5ZsUZ8C4U74KX0uG0IdGHr3KVM1Tn/4aBLbjd8E3E=
Received: from SJ0PR13CA0166.namprd13.prod.outlook.com (2603:10b6:a03:2c7::21)
 by DS0PR12MB7581.namprd12.prod.outlook.com (2603:10b6:8:13d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Mon, 3 Jun
 2024 01:42:53 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::c5) by SJ0PR13CA0166.outlook.office365.com
 (2603:10b6:a03:2c7::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.13 via Frontend
 Transport; Mon, 3 Jun 2024 01:42:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Mon, 3 Jun 2024 01:42:52 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sun, 2 Jun
 2024 20:42:50 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 08/18] drm/amdgpu: refine pmfw/smu firmware loading
Date: Mon, 3 Jun 2024 09:42:02 +0800
Message-ID: <20240603014212.1969546-9-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240603014212.1969546-1-kevinyang.wang@amd.com>
References: <20240603014212.1969546-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|DS0PR12MB7581:EE_
X-MS-Office365-Filtering-Correlation-Id: 15ca2e23-5320-4bbc-622e-08dc836e7bc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|82310400017|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gzlrXOu87KRwQ03iY4EB2n5ut5jTJewDSAfX3hergrBt0zPoJq6UXNjnoWvL?=
 =?us-ascii?Q?x+OG0vQVk6oCOMsRUW6ngfmZmuDy2BBbPAw4tysQbdw6dhCkMcNgHIqAfNui?=
 =?us-ascii?Q?pe9AkbZqBHwp90XesaH6yKx7f+w/DQChYVhvHnxcFEOS6MmbuJO5LqPdGnSc?=
 =?us-ascii?Q?GduqRXZaZaeoHQsHd3oIsh0acoWqZJqlSfHcAxIiUt5kDaYXC7SnMzjf6D4z?=
 =?us-ascii?Q?42XvlX/NobB2KRljTpb9OA7PPwB8m15RChouDFZZzqh6zv/dEfj5rB30irHz?=
 =?us-ascii?Q?26XpprdjhsMJcL2frviumdmWaXBEPu1guxxWm3T+iSf+9Ck29fUFUOkfY0x4?=
 =?us-ascii?Q?sHGyXkUS2eu8I/jdrEZaEciSG6yLXoeh24Zxj153j3vDOHxVfGeUL/lcsPRb?=
 =?us-ascii?Q?oFMCkImtM8OmJRRLGoT1bjGTfuq80SeMMSldAdixZs5K2ixMaRjBmgWD/qQv?=
 =?us-ascii?Q?lPHBv8PtUv+D3SfJ9sbpTacj/ldh56OZZr0uML+euA2jcrOOk4+4OI8fJKGW?=
 =?us-ascii?Q?p8LRJJ+tdFZJejf9EfWwSYv5qqqvnRupjrdMg2jklZv3QKJLdBBPA3lao5nZ?=
 =?us-ascii?Q?5gZDLnlsUzb0PaD+SFHWgx4yks7rC35EcIODVeMG2zvlWATvDjheqt3sYfuo?=
 =?us-ascii?Q?tC7P+0WFyAn3h+qM6uBiY49gz3pySXr7Au7aDBoQdXQ1WNLBTLpiaNbd9x1B?=
 =?us-ascii?Q?gKgtjrtovDzMyO/eQ+1fv2TTh3LmZs3yNLd+zp4WibJDq08YsUVgUhQcn/Jg?=
 =?us-ascii?Q?XgeyOFCev7itMziMZKRn5X9Sl6TYcOhlSscaJyM9Iyten/41l3MNmx+fZbtc?=
 =?us-ascii?Q?TT2v24cifznJaOYk1q1Zih+Wg/S7T35905ip1WnMBh1K+6Awdo8mzhoi3THy?=
 =?us-ascii?Q?B2F2BP+QnFuiym7Fxqt0+NqnPMAxaCJoBo7v93zc7mON6sq/bHXFG5ml/zfe?=
 =?us-ascii?Q?A98lU9zI/bl1Msk7TCA9Yh3V+oZR96xRiOw7AC0EOmOF55YDd79VFHagGepW?=
 =?us-ascii?Q?K/4fnyfnqymtqWcQ3x8ox1i+iFMffYmsX6+4deiIK3Uct4cLqc7itOYZiQqd?=
 =?us-ascii?Q?y8nv+bthjE3FqgyUhUw+Tguyd6fLBRfbOAazXO8mj1TWu8qO5ri/eLe0OhPb?=
 =?us-ascii?Q?3ngMdl5WF7dXTlVl3J/TbuAD0++Kzy9ODF8XtkwPhqfRFCMWxLuH09TW+de9?=
 =?us-ascii?Q?VB0MPPc2EIfPg3REGedJ1E/5OVTYhEIzUyVAFqf02npbBlYHj+BQ6qxS7g+S?=
 =?us-ascii?Q?wm0+flW6/cgGJ74oKGs6sWmMfrssIV7npdJltwCXt8v6LKaSigGsZq42p4A1?=
 =?us-ascii?Q?Q7QnE5ksRzB1rsJSvhFiyUcKA1lCRLpjp5L3btfGOVmYnSEMyOQbwubvHKut?=
 =?us-ascii?Q?xorKuOs=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400017)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 01:42:52.4954 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15ca2e23-5320-4bbc-622e-08dc836e7bc9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7581
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

