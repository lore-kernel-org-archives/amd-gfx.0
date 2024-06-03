Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7096C27C44
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Jun 2024 01:43:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 406F410E1DB;
	Mon,  3 Jun 2024 01:43:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AcO53nA5";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C889610E1DB
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Jun 2024 01:43:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZtXFRBcfsMwMjgPfmtAu2QpvLOygaIwU2yNi15A4raOV2yYhNuuJz+aV7fnJ6EKNV0JmyyyOxkHHddlMM/RT9f7STReYpxbdmvnvejnZCnD4fnMZ954QGBFatek5RjnwgtBtdxpL1Ffe4Mr390Hl/6Ri/0NPblu5k5vN5TTR6Hysqte28FPbeotxi0FuiM7/LbhvRMLR7Ze6pPf6U5k+bVFXC8D9BY/tOzJHzm2h0oyLphWqy251ObU591//eZyWbQNA+GHCjy6DbWlwZWoKniT32R9zzdyJ5WUVf/gvPR+I1cUzAYr4OPMKYEjyh71ZGnV1E+6eGC3gd026gW3zHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aB92hj5PD1g/IygwAR0JbUjaRha888BrBFFrercBfSM=;
 b=WY+bJ5aL3LBxsCf+GrMRyLN2zgz+SWEbTBt0YwV8SQhNn+1uc6XzvgHmyMtJJKRW/UMx65iEtqkPPXx1/ggFMk5iO4hHioEgMVviD9AlGAbph3HQag49ptekpUNmWQ+X/GozpwFzV0C+a5xcLqJb4LHSt0q+zjNdvTkKudozdPP63S6zqc7viPDTquIvDU1LLTe00NYNvtWn0t8SP99PdM+9Q/O1Bm0cE4d9i7z0zz7DLN8sPW3ndSw/5T5FtcIr/anQsGKDAARGF6oldJJ+L0wIKLh02MyK8pMiitdpkmMPRgJcIktVVQ6QXVR6iLcdfKxDtC0mUpvGqpr2yxIgQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aB92hj5PD1g/IygwAR0JbUjaRha888BrBFFrercBfSM=;
 b=AcO53nA5BJvOqqZch4Mbi5YTNjmnnWs4CPdVIOrc8+jYixZOPw3UsA+lERq/3J+K+udWMmcKvQksylkLrfjl5NixyUtjugL521Wj5Mq8KEEGq95b58P0uZERgeO4u38GPngk71/wW8CCU1g0NcnTBw7nJM8+KGNRBYaAWtMBVfc=
Received: from SJ0PR13CA0177.namprd13.prod.outlook.com (2603:10b6:a03:2c7::32)
 by PH0PR12MB5646.namprd12.prod.outlook.com (2603:10b6:510:143::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Mon, 3 Jun
 2024 01:43:10 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::13) by SJ0PR13CA0177.outlook.office365.com
 (2603:10b6:a03:2c7::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.13 via Frontend
 Transport; Mon, 3 Jun 2024 01:43:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Mon, 3 Jun 2024 01:43:10 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sun, 2 Jun
 2024 20:43:01 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 15/18] drm/amdgpu: refine gfx9 firmware loading
Date: Mon, 3 Jun 2024 09:42:09 +0800
Message-ID: <20240603014212.1969546-16-kevinyang.wang@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|PH0PR12MB5646:EE_
X-MS-Office365-Filtering-Correlation-Id: c94ce02b-ae03-4f0c-0c0c-08dc836e8659
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|1800799015|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+tT1if+f8eM0V1HDUZ/zcTYwUUJ0A6xp2/eOnZ98GIWi7Xpp9nciydsusXON?=
 =?us-ascii?Q?QZKlZelYQshDRbvCUTRodZPZAqZcJE+BcunJupM8K4c9ZFOP/2CXK3tc6h8j?=
 =?us-ascii?Q?D4fcm2IpwHHyC3SAZD3x8RaoGLvECNZykSKUrsR9ywHQYifm2FepwFujpMEf?=
 =?us-ascii?Q?rpunreBda/JK4x11KrNzrTUYav/MfFQL2UyhFLyzzat6/Au0f9CcobCFU8BT?=
 =?us-ascii?Q?UHTHuTrX1n67UKa3c/Ie8KuJHf/1mvJkNzvDmujKQJVEuQQH442oKmhQJ4rG?=
 =?us-ascii?Q?PfM3iaCoAle4L8fhBPUQBx7cOlCtx4EokYeobvha9pi2sFKeZ8Qe35+hy6vI?=
 =?us-ascii?Q?7795/tzVYtYiuoIkNc9FbjJ5YV37eizELQhagqeJa4btmRKkrUq0N39yqVHp?=
 =?us-ascii?Q?jehJv4SAwfYK2/Uxe2iamScLqwFd97TYVQvCv64tzEXwFffgnjflFUEMQRP4?=
 =?us-ascii?Q?yd/z3w74Pj+jvYdq399ONkle3uF6soxlCCOSA8DO7y/I1zwe+EM8aeIOwRgE?=
 =?us-ascii?Q?t1EqirRsY16BChIxuqJgEnG28616Z3RUQMrkq0hc/hgEuE9DMjtHcmRSNdoS?=
 =?us-ascii?Q?6LqW3btTWIbMzazAqfx85zLNqINC/CIUsEa/N6CDSS4jtSByDfGrMvmmODCc?=
 =?us-ascii?Q?RTitYutjjt3n2XxW5K4/PiyamslkoX3EeH47dm2NzRk9C55NtHbbTfF/5djX?=
 =?us-ascii?Q?u1eVtNqB2iXpUFQsRCTV7aBiLSRG2eeTAMpnDcHWgWgGuE+HYPN9cpcbtFOd?=
 =?us-ascii?Q?Bzdqw9CHUUxBDqugT7B6vCjNv3nOmQuYBoP69DlqhO9uwhWLkoGisxeClTXd?=
 =?us-ascii?Q?59UuujSwVSUwDYcPJt178vIjssRzMadd4tFkqJgnQE43mMyfdp+ApuBvkOBg?=
 =?us-ascii?Q?Oa0IOdpTktjN2nC+HRxpO522uciu+XpPGOqMPnACjIZ3mBOh39efVitPDSPk?=
 =?us-ascii?Q?rRzGwbb/6pv1CiyOu0NnGGwlML/4pUxu3wCj/WbaAjfIGKqrLu0ub2A0gv4R?=
 =?us-ascii?Q?1JhTh0fu1DDsNs+AsSgi/whlp9u6SUjlz00jYQMfC3EjD1MF03/3ZIu8Fa8Q?=
 =?us-ascii?Q?QUdaGjnAArhMOnGvlRy4ZWxBxKuZA1ZZhsL82/RkU+jQnBKSdYdI/Z+M+Tnj?=
 =?us-ascii?Q?nYg0yHshlKB0+E7+yYltKVaDfnScFE91eR/apR2ivrafk9aeyJ4yvE9lhWyF?=
 =?us-ascii?Q?+NOC0sH9ZORQ8B52y0SfKUzNE2q9j1CONhHrMR1nS3ceT9xLpGSncqdNKk67?=
 =?us-ascii?Q?/hOnTM4KJXpwxwaqStNTPOKB+58s4rvi6wxYK4DIYz3Sm8w6ajqprQ2xaSx/?=
 =?us-ascii?Q?Fw43yi0fYwUf6ewEM2aPaBAHtYOZTEUw7fLS3Yb0RsUsGhc1Zq1+IkKWdfnx?=
 =?us-ascii?Q?rb7WlA5QrgyjNdFYxAlrsTkJ/dnz?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 01:43:10.2141 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c94ce02b-ae03-4f0c-0c0c-08dc836e8659
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5646
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

refine gfx9 firmware loading

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 45 ++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 11 +++---
 2 files changed, 26 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index ad99ee10fd4a..2929c8972ea7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1378,23 +1378,22 @@ static void gfx_v9_0_check_if_need_gfxoff(struct amdgpu_device *adev)
 static int gfx_v9_0_init_cp_gfx_microcode(struct amdgpu_device *adev,
 					  char *chip_name)
 {
-	char fw_name[50];
 	int err;
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_pfp.bin", chip_name);
-	err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw,
+				   "amdgpu/%s_pfp.bin", chip_name);
 	if (err)
 		goto out;
 	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_PFP);
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_me.bin", chip_name);
-	err = amdgpu_ucode_request(adev, &adev->gfx.me_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gfx.me_fw,
+				   "amdgpu/%s_me.bin", chip_name);
 	if (err)
 		goto out;
 	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_ME);
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_ce.bin", chip_name);
-	err = amdgpu_ucode_request(adev, &adev->gfx.ce_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gfx.ce_fw,
+				   "amdgpu/%s_ce.bin", chip_name);
 	if (err)
 		goto out;
 	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_CE);
@@ -1411,7 +1410,6 @@ static int gfx_v9_0_init_cp_gfx_microcode(struct amdgpu_device *adev,
 static int gfx_v9_0_init_rlc_microcode(struct amdgpu_device *adev,
 				       char *chip_name)
 {
-	char fw_name[53];
 	int err;
 	const struct rlc_firmware_header_v2_0 *rlc_hdr;
 	uint16_t version_major;
@@ -1429,20 +1427,22 @@ static int gfx_v9_0_init_rlc_microcode(struct amdgpu_device *adev,
 	if (!strcmp(chip_name, "picasso") &&
 		(((adev->pdev->revision >= 0xC8) && (adev->pdev->revision <= 0xCF)) ||
 		((adev->pdev->revision >= 0xD8) && (adev->pdev->revision <= 0xDF))))
-		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_rlc_am4.bin", chip_name);
+		err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw,
+					   "amdgpu/%s_rlc_am4.bin", chip_name);
 	else if (!strcmp(chip_name, "raven") && (amdgpu_pm_load_smu_firmware(adev, &smu_version) == 0) &&
 		(smu_version >= 0x41e2b))
 		/**
 		*SMC is loaded by SBIOS on APU and it's able to get the SMU version directly.
 		*/
-		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_kicker_rlc.bin", chip_name);
+		err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw,
+					   "amdgpu/%s_kicker_rlc.bin", chip_name);
 	else
-		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_rlc.bin", chip_name);
-	err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw, fw_name);
+		err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw,
+					   "amdgpu/%s_rlc.bin", chip_name);
 	if (err)
 		goto out;
-	rlc_hdr = (const struct rlc_firmware_header_v2_0 *)adev->gfx.rlc_fw->data;
 
+	rlc_hdr = (const struct rlc_firmware_header_v2_0 *)adev->gfx.rlc_fw->data;
 	version_major = le16_to_cpu(rlc_hdr->header.header_version_major);
 	version_minor = le16_to_cpu(rlc_hdr->header.header_version_minor);
 	err = amdgpu_gfx_rlc_init_microcode(adev, version_major, version_minor);
@@ -1466,28 +1466,27 @@ static bool gfx_v9_0_load_mec2_fw_bin_support(struct amdgpu_device *adev)
 static int gfx_v9_0_init_cp_compute_microcode(struct amdgpu_device *adev,
 					      char *chip_name)
 {
-	char fw_name[50];
 	int err;
 
 	if (amdgpu_sriov_vf(adev) && (adev->asic_type == CHIP_ALDEBARAN))
-		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_sjt_mec.bin", chip_name);
+		err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
+					   "amdgpu/%s_sjt_mec.bin", chip_name);
 	else
-		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec.bin", chip_name);
-
-	err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw, fw_name);
+		err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
+					   "amdgpu/%s_mec.bin", chip_name);
 	if (err)
 		goto out;
+
 	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_MEC1);
 	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_MEC1_JT);
 
 	if (gfx_v9_0_load_mec2_fw_bin_support(adev)) {
 		if (amdgpu_sriov_vf(adev) && (adev->asic_type == CHIP_ALDEBARAN))
-			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_sjt_mec2.bin", chip_name);
+			err = amdgpu_ucode_request(adev, &adev->gfx.mec2_fw,
+						   "amdgpu/%s_sjt_mec2.bin", chip_name);
 		else
-			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec2.bin", chip_name);
-
-		/* ignore failures to load */
-		err = amdgpu_ucode_request(adev, &adev->gfx.mec2_fw, fw_name);
+			err = amdgpu_ucode_request(adev, &adev->gfx.mec2_fw,
+						   "amdgpu/%s_mec2.bin", chip_name);
 		if (!err) {
 			amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_MEC2);
 			amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_MEC2_JT);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index aecc2bcea145..6e1598128209 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -372,15 +372,14 @@ static void gfx_v9_4_3_free_microcode(struct amdgpu_device *adev)
 static int gfx_v9_4_3_init_rlc_microcode(struct amdgpu_device *adev,
 					  const char *chip_name)
 {
-	char fw_name[30];
 	int err;
 	const struct rlc_firmware_header_v2_0 *rlc_hdr;
 	uint16_t version_major;
 	uint16_t version_minor;
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_rlc.bin", chip_name);
 
-	err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw,
+				   "amdgpu/%s_rlc.bin", chip_name);
 	if (err)
 		goto out;
 	rlc_hdr = (const struct rlc_firmware_header_v2_0 *)adev->gfx.rlc_fw->data;
@@ -409,12 +408,10 @@ static void gfx_v9_4_3_check_if_need_gfxoff(struct amdgpu_device *adev)
 static int gfx_v9_4_3_init_cp_compute_microcode(struct amdgpu_device *adev,
 					  const char *chip_name)
 {
-	char fw_name[30];
 	int err;
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec.bin", chip_name);
-
-	err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
+				   "amdgpu/%s_mec.bin", chip_name);
 	if (err)
 		goto out;
 	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_MEC1);
-- 
2.34.1

