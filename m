Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 174D6C27C44
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Jun 2024 01:43:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6400810E263;
	Mon,  3 Jun 2024 01:43:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vb+16QMW";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6545710E1DB
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Jun 2024 01:43:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bHKIq5jxLHwQIpSmQZv+r//zf10w7K3gBSllR6HpKqw3gtaCgkK3Lwnvmm9EF7AVtcfzUBaiFtnEtTmXxx06ho4vwpKZCE/FAB8ZYyO3UG3zHbv572k60BtZnECcBKN4X/aLRs1/Y1ruDV/7WSfuff688CZjEZLRBI2KXG0pQYosinKYSct7EU+W1PDdo/VN0/ZBmE8TrZjJwjYllD5pd/+tPu8vWk0Tq3ltiTTIaIhHHJ6aXcOU34OyUuilKD7oXnOns7Fyw6ZF6O24KH9rTtCA7w1208i6y3/QunbUlRiqm4/5rLnRsulya1pAJsEe6kM2rAyW0eUUmgrg19l5vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nUcshEzg4T9B2uMR8I3IF9PyC6+rqBGj77H1hXAB4kY=;
 b=KUhtkRJcv25FTFBqMNq7mH5dLgdO+mjyzlCzAi/xj3w9CFuDQKJ+BcCoHE/Yfe4zXvNNC1qqQb8vqh1tXtdy6CAobHFjaeNTWF+IHmOMwqgPGEQLOVRdqKAxMop5AGidLEbG7U+Lq3+h1x/dtSTgBToKjNXNWqeps4NQv+kshGzMGH4cHe0QABVcvDutHzPTLsbwIryyK7bLsXtFOw5I03HTI/Wpt9I5DLkjfJNdSchfUsp6jo4mqRNzDBc62seEBaDt9m1ME4G7juuUFbwO33MxqDRNOQ9QWQgL6t13wVPT32f42DaXod3ZmpEQTjb0WfVhYlLEquznGnw2LgFtmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nUcshEzg4T9B2uMR8I3IF9PyC6+rqBGj77H1hXAB4kY=;
 b=vb+16QMWxF+cNFgBoIa8LH1t68AK939PC5x0MIT0AWq/4yGf6vCWjpt/ihHkaST3ZmSHZ7PXe1Va0+fvhYfPBhdFWHHyeIc2f+pbbOnTC38prOVKm3Pf3KsuS7RmeRIXc1LnQy0VCaET7DmzBXvVgcvXB7j0d9V79sBjlSI4qBc=
Received: from SJ0PR13CA0164.namprd13.prod.outlook.com (2603:10b6:a03:2c7::19)
 by SJ2PR12MB8846.namprd12.prod.outlook.com (2603:10b6:a03:549::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Mon, 3 Jun
 2024 01:42:54 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::d5) by SJ0PR13CA0164.outlook.office365.com
 (2603:10b6:a03:2c7::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.13 via Frontend
 Transport; Mon, 3 Jun 2024 01:42:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Mon, 3 Jun 2024 01:42:54 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sun, 2 Jun
 2024 20:42:52 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 09/18] drm/amdgpu: refine gmc firmware loading
Date: Mon, 3 Jun 2024 09:42:03 +0800
Message-ID: <20240603014212.1969546-10-kevinyang.wang@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|SJ2PR12MB8846:EE_
X-MS-Office365-Filtering-Correlation-Id: fddbf0f0-7704-4f1a-f305-08dc836e7cfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|1800799015|82310400017|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Z1mgtFjRFP1Lfg+Q0eX+1Nqdaj1s9BkDgqBYBtr6secZGXs0u8LZZOENnpWk?=
 =?us-ascii?Q?uwbOxzC/8vnXUoae0aJqAcML4CDu7nuCMmYh9Yo988p25Kw0Dp5K5HaMVj7x?=
 =?us-ascii?Q?/zbg1irtK+KW/TbyzH3TBrLH+B+vfJw2E2wDY5vXrLD46HkJmxVT4C+SQ5xY?=
 =?us-ascii?Q?B/gI9cBnAT1NYd/FjwThdNDBvd9zp0yyeSW9R2D1/UZFz2+n5vMJlkdAaJqP?=
 =?us-ascii?Q?5Z6u5yJ0ugkhvMfLG59vUuHO/H+5F5SPUwgqOEokns3wtthFtJMCWSYWCIy0?=
 =?us-ascii?Q?gH6O0gJgqAF1Kgpz18vF0Wing2JbYUW7YRn1xd6hsxhN0h79lnXWrAEvpUQr?=
 =?us-ascii?Q?sDfRQnjUUZZWI8sRvg8l89Mt4Whtkft+bz2JYZHdfz659YNMRTZskRzXsw6R?=
 =?us-ascii?Q?bD5xOW46zAQwx7tsvaeyLyLe7hZMlsZz+JM9lIyf1xQVbGF1n4GeKrL2ZPhV?=
 =?us-ascii?Q?tvrS5Z3i2XGOLXpwsJ80RnxdqHJFUX11EvPbyjDpN/HCLFzOhZ5RlT81bE2n?=
 =?us-ascii?Q?fEUhQLS6jICZCVAANKgNA9yl+RTPzLsHABzpuTvThuLDpSZ6GnDmoG7h5C5O?=
 =?us-ascii?Q?DpB+cMDbsfGsTQo6oxbjZp+JAqK0Wd/dWcCrJICWcdeSObUCkTDjKJ6BkFGB?=
 =?us-ascii?Q?Jguy0WrrpFfKuG0R/zTrEaxtGeOPnle91S621OQaaW216uREwzaQwvp1Lw+Q?=
 =?us-ascii?Q?DUgFistkvqZ+HUHGKGQwhHXdBojeJUWiRyB/nK+bKGFSXBeobZlp+bFZYlDz?=
 =?us-ascii?Q?rNgIKnzki+O671nHIR3xnethaqQducHn/W68tW7+trLF6xcq0XpdxBSX9NA7?=
 =?us-ascii?Q?RIWAFLANkXtlDQFxjglOb9BuWAslJC7R3ofbHiPx6Ty3lQpBKvx9HIeuA3jd?=
 =?us-ascii?Q?vTq/SFmHBNycvVEJ5bLBZFH2y496Sr2I8QKx8sNDUop+HX0NMdWKMOo9rvxc?=
 =?us-ascii?Q?bK7fAhqdf4iutUikehg47wa0B4t2Z12yXhe8baojBFUL2+wgxuqHECe3eIc4?=
 =?us-ascii?Q?uF9+tbFa+AkvFgpxr4OpV6Nm3G37qLrBkHS+Hfb274iIU6ShUmqkFH8ijH53?=
 =?us-ascii?Q?Q4+oUvpfTVBYe+oEKAyTJuMZs2ErLzGhwTcNY2VIb7Zotv6Kq9SEGhTjCaZj?=
 =?us-ascii?Q?RECKoA719n7cH549dja9hjORZtwtFY09vlX3wLxeecS+Kg+nWJtD2rxSsJcf?=
 =?us-ascii?Q?J/9zdJcLCKq+5/TKA9hfrkWgIShnWCFceJnRuW+DBpG0E7ymGhtzqSQ66bY/?=
 =?us-ascii?Q?tzLq4Ig6i/tOwwfATbkVDTwbUogTfBX6WsA0MX5T83T/ve25U9KqZhlEGT6O?=
 =?us-ascii?Q?xdUYn736qPsN9/i2UQB31PHkYLdXsKs9FFpIQaI9OrFr5EcWtlEgFgwbtcHD?=
 =?us-ascii?Q?NjJi6plA+U7APw6rct1gR5wG3Te7?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(82310400017)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 01:42:54.4485 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fddbf0f0-7704-4f1a-f305-08dc836e7cfc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8846
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

refine gmc firmware loading

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c | 14 ++++----------
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c |  7 ++-----
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c |  6 ++----
 3 files changed, 8 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index 3e38d8bfcb69..d36725666b54 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -98,9 +98,7 @@ static void gmc_v6_0_mc_resume(struct amdgpu_device *adev)
 static int gmc_v6_0_init_microcode(struct amdgpu_device *adev)
 {
 	const char *chip_name;
-	char fw_name[30];
 	int err;
-	bool is_58_fw = false;
 
 	DRM_DEBUG("\n");
 
@@ -126,17 +124,13 @@ static int gmc_v6_0_init_microcode(struct amdgpu_device *adev)
 
 	/* this memory configuration requires special firmware */
 	if (((RREG32(mmMC_SEQ_MISC0) & 0xff000000) >> 24) == 0x58)
-		is_58_fw = true;
+		chip_name = "si58";
 
-	if (is_58_fw)
-		snprintf(fw_name, sizeof(fw_name), "amdgpu/si58_mc.bin");
-	else
-		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mc.bin", chip_name);
-	err = amdgpu_ucode_request(adev, &adev->gmc.fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gmc.fw, "amdgpu/%s_mc.bin", chip_name);
 	if (err) {
 		dev_err(adev->dev,
-		       "si_mc: Failed to load firmware \"%s\"\n",
-		       fw_name);
+		       "si_mc: Failed to load firmware \"%s_mc.bin\"\n",
+		       chip_name);
 		amdgpu_ucode_release(&adev->gmc.fw);
 	}
 	return err;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index 85df8fc81065..994432fb57ea 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -130,7 +130,6 @@ static void gmc_v7_0_mc_resume(struct amdgpu_device *adev)
 static int gmc_v7_0_init_microcode(struct amdgpu_device *adev)
 {
 	const char *chip_name;
-	char fw_name[30];
 	int err;
 
 	DRM_DEBUG("\n");
@@ -153,11 +152,9 @@ static int gmc_v7_0_init_microcode(struct amdgpu_device *adev)
 		return -EINVAL;
 	}
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mc.bin", chip_name);
-
-	err = amdgpu_ucode_request(adev, &adev->gmc.fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gmc.fw, "amdgpu/%s_mc.bin", chip_name);
 	if (err) {
-		pr_err("cik_mc: Failed to load firmware \"%s\"\n", fw_name);
+		pr_err("cik_mc: Failed to load firmware \"%s_mc.bin\"\n", chip_name);
 		amdgpu_ucode_release(&adev->gmc.fw);
 	}
 	return err;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index fc97757e33d9..86488c052f82 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -212,7 +212,6 @@ static void gmc_v8_0_mc_resume(struct amdgpu_device *adev)
 static int gmc_v8_0_init_microcode(struct amdgpu_device *adev)
 {
 	const char *chip_name;
-	char fw_name[30];
 	int err;
 
 	DRM_DEBUG("\n");
@@ -255,10 +254,9 @@ static int gmc_v8_0_init_microcode(struct amdgpu_device *adev)
 		return -EINVAL;
 	}
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mc.bin", chip_name);
-	err = amdgpu_ucode_request(adev, &adev->gmc.fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gmc.fw, "amdgpu/%s_mc.bin", chip_name);
 	if (err) {
-		pr_err("mc: Failed to load firmware \"%s\"\n", fw_name);
+		pr_err("mc: Failed to load firmware \"%s_mc.bin\"\n", chip_name);
 		amdgpu_ucode_release(&adev->gmc.fw);
 	}
 	return err;
-- 
2.34.1

