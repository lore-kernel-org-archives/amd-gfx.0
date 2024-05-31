Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B942C41513
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 06:53:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66044112CB4;
	Fri, 31 May 2024 06:53:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="o45BpAkm";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DEA810EA42
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 06:53:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=apv5pxmwfUtZ11004Cu1Jc9nCQabrT/ru13cRpaxT9HktVHgpmnt9onDw1LYGC5Zn1ykIO/JekDTZnw2HH+uuYIW+jyb1+ofOPam5lNNiXNGQ1ZlOCzSLZGEZy5Gm3ygyBw0+h/eeYCCjl16ONdfYoFGYlrp7CjIj6XfJVDT3CBRacmOG6DNc67IfZa3/h2xmWoZF/+mO71hB7nMMJ9MGzwy6Jl035KMbgAiMGIiM5FqAeGyjr7iWQmrFcUbsldxs1pi0CTulMvZlEtfe3tyzHrqfdxluTW7LfI4I9S3hrC5zngU3T18xNB4BE20aCL8mpo3pNQZRgtQExVwhWbNeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FgPaHU9GSzVObta4sip9ShtRgN87o8xu8KyNwRPTenk=;
 b=dyzp+Nv73yaadjpIY+VLCg5wLqVg9RtmOPQJiYzuZJz/I45N4OMid/CiWTrAugp4b6Rk9I1WFs7B86OykAGvTFedM141YnWxqTSAVFfiM5EDvqcrmIscNYHxo6zQ3iLZwZMgVTheMqecupiz3zTLPcQJbPl2HT986cB2Q68qCrxsPtAofoTWFVqwCPzvBq0oiLT5SFSD+QKMrp7n9ixZDtVe/IhbchPyG0ZhFVt4KwSoRWYArOcCDI+Du/W6fkGRW0Hfk7vtQwr0tCXq7jZf5usTmqWEu9NvpDz8CjmL5Ivzgbiy/peDFRevAtj5FhrkIqoi4VtaUK9WjBVbJfcJSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FgPaHU9GSzVObta4sip9ShtRgN87o8xu8KyNwRPTenk=;
 b=o45BpAkmH3DThF2dfaAMKcDdw9VFVd9a+9nNusWLgLpAsSgY4l284kd3odCBtWCVXV4FZCwM1zljFb3KgDbUyC4C4Bqfvz7MiINJZkoqFcG2pUDaZsnWVopk5sBHiASG4y80ItJWC3J5LJlpAw5TSlsrkTrQjunyLwjjKf4xXUg=
Received: from SJ0PR13CA0188.namprd13.prod.outlook.com (2603:10b6:a03:2c3::13)
 by DM4PR12MB5988.namprd12.prod.outlook.com (2603:10b6:8:6b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Fri, 31 May
 2024 06:53:09 +0000
Received: from SJ1PEPF00001CE3.namprd05.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::e7) by SJ0PR13CA0188.outlook.office365.com
 (2603:10b6:a03:2c3::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.9 via Frontend
 Transport; Fri, 31 May 2024 06:53:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE3.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 06:53:09 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 01:53:07 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 06/18] drm/amdgpu: refine sdma firmware loading
Date: Fri, 31 May 2024 14:52:37 +0800
Message-ID: <20240531065249.1746350-6-kevinyang.wang@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE3:EE_|DM4PR12MB5988:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fa3aeab-fc95-41ac-c850-08dc813e5501
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZGIax9f89siRWFq4g7DfZhRe/F8bMrUJQDtYxd6bhU/pr0GJ3l3+oYVPD6jr?=
 =?us-ascii?Q?4Ntv6+QEWACskRiVHs4u/X/MuQZqgGqetRRZsGFya3k1gM1xenpf2cUUw253?=
 =?us-ascii?Q?3tcTgqvyN1LGmkKPoODUC4WP6X2GGxJ+7eH1Tm7iaey4XexjfzM2IiYHiIOS?=
 =?us-ascii?Q?R8dM+z3kAlLlfdfJyyo+QWDOg4CMvBEjZIdDmR5XT1qSqTP3wojnl56SSg9O?=
 =?us-ascii?Q?3np1gd9Zq/0ZaSq6V88VYDtp/VrtxRWVleECPByo9grXLIOCIG7ACYmCzjA1?=
 =?us-ascii?Q?bLNld0AU2wpFcNOG8ElbWOlbMEizGtUTvvBSz474L67YEmJoHpSQNMl6P5Bz?=
 =?us-ascii?Q?62w7fWpJNMgV/Ekrqr+phv+TrQJ9lWWqtbae8Nfun1jxo8i1kH6RkkyoRApX?=
 =?us-ascii?Q?Y21+LV/+ixH+VDjjiHRLwNCUUjZqvIFZblGSqC1pNZWA2cAKcxnmaQaC+xRo?=
 =?us-ascii?Q?uu584z+iG/e00ocMsK65Fo1NrNasZPSIAPY5G2q2jo8+32d/uiphxJrCd61F?=
 =?us-ascii?Q?/ej58ZHsKZa64u2TKeeS7LuX2dyHHOn1daG7SzoqAEjlGf8KQHhZhu3vgiWC?=
 =?us-ascii?Q?qLqp5UMIaCRxE+i6O2M9tZehi/1iiN5KjFuy/Ru1AOdwrZd3Fx5O2lzVsiII?=
 =?us-ascii?Q?1R2hkMaUlUH207D90bDVQb+DlUZYMiVSNpDaYuihRlGSKctDXIXQrdNz0kkN?=
 =?us-ascii?Q?IJNPZcbXkfgSYuKvFT371MoGFVj3cjo42GSMAlCOuQRASt7SpYjTNaIpo9DC?=
 =?us-ascii?Q?/giVF+3lnDch0OwmkbTgYpwq+mh1bcn6pE8RybTPjp+MWiUWJCYZcdXC5E2+?=
 =?us-ascii?Q?IOt7zkHw5tUoux3pSdQVoz7yOvwqUw+Kzor2L+Y9rnSiVixvXVQugCAjPuky?=
 =?us-ascii?Q?Q2t5k9qDA/H1qbZpTM0kIyK+qYNOxDk8DA9otFvKXBaUAGM3wfLaj8Wg2NtJ?=
 =?us-ascii?Q?Jyxz8UQygzWhdiq3y/9pxUm2a/oCxNbjut3Gx6FcNQWcHuBvVQjz1HyD+CLk?=
 =?us-ascii?Q?sl8eqf2TVwAkR0dF3BBTeDzEZ8iYyK121tuO4+zbgM7C9XxhWxfkmiMcRjUi?=
 =?us-ascii?Q?gflz/UoOl1UMS2LHPNS8UpqxcGjDFzNR5BAcU4fVUK1168n2/REYUteKxHsE?=
 =?us-ascii?Q?UnRjgbYTDDD62jyJo1f1V3PuozwH4TX/Z+qbRdYxuI56HMxroeezEN19HNLm?=
 =?us-ascii?Q?+7qAJmyTdU8A4pqyq4FWRgTdtRlf3HskDj921GWvEbNtdFh7zFTampyHZZGj?=
 =?us-ascii?Q?hU2Pk/7+wU7nruLI9h+MENFYrtZTohP7h3wDjREm4HVxQN0AnDb86SzSdx9C?=
 =?us-ascii?Q?nUPvEzli9NExkDS3fABZt09OJC/tX0VhZfw6cd0Xq8sWqgUD5yOIUtYpHCcg?=
 =?us-ascii?Q?UZVGt96cNHRKuBniiQVQIY6j9rP0?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 06:53:09.2497 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fa3aeab-fc95-41ac-c850-08dc813e5501
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5988
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

refine sdma firmware loading

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c    | 11 ++++++-----
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c   | 11 ++++++-----
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c   | 11 ++++++-----
 4 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 151f83ea803b..183a976ba29d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -215,14 +215,14 @@ int amdgpu_sdma_init_microcode(struct amdgpu_device *adev,
 	const struct sdma_firmware_header_v3_0 *sdma_hv3;
 	uint16_t version_major;
 	char ucode_prefix[30];
-	char fw_name[52];
 
 	amdgpu_ucode_ip_version_decode(adev, SDMA0_HWIP, ucode_prefix, sizeof(ucode_prefix));
 	if (instance == 0)
-		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);
+		err = amdgpu_ucode_request(adev, &adev->sdma.instance[instance].fw,
+					   "amdgpu/%s.bin", ucode_prefix);
 	else
-		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s%d.bin", ucode_prefix, instance);
-	err = amdgpu_ucode_request(adev, &adev->sdma.instance[instance].fw, fw_name);
+		err = amdgpu_ucode_request(adev, &adev->sdma.instance[instance].fw,
+					   "amdgpu/%s%d.bin", ucode_prefix, instance);
 	if (err)
 		goto out;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
index 6948ebda0fa2..952737de9411 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
@@ -107,7 +107,6 @@ static void cik_sdma_free_microcode(struct amdgpu_device *adev)
 static int cik_sdma_init_microcode(struct amdgpu_device *adev)
 {
 	const char *chip_name;
-	char fw_name[30];
 	int err = 0, i;
 
 	DRM_DEBUG("\n");
@@ -133,16 +132,18 @@ static int cik_sdma_init_microcode(struct amdgpu_device *adev)
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		if (i == 0)
-			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_sdma.bin", chip_name);
+			err = amdgpu_ucode_request(adev, &adev->sdma.instance[i].fw,
+						   "amdgpu/%s_sdma.bin", chip_name);
 		else
-			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_sdma1.bin", chip_name);
-		err = amdgpu_ucode_request(adev, &adev->sdma.instance[i].fw, fw_name);
+			err = amdgpu_ucode_request(adev, &adev->sdma.instance[i].fw,
+						   "amdgpu/%s_sdma1.bin", chip_name);
 		if (err)
 			goto out;
 	}
 out:
 	if (err) {
-		pr_err("cik_sdma: Failed to load firmware \"%s\"\n", fw_name);
+		pr_err("cik_sdma: Failed to load firmware \"%s_sdma%s.bin\"\n",
+		       chip_name, i == 0 ? "" : "1");
 		for (i = 0; i < adev->sdma.num_instances; i++)
 			amdgpu_ucode_release(&adev->sdma.instance[i].fw);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
index ac8a9b9b3e52..725392522267 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
@@ -127,7 +127,6 @@ static void sdma_v2_4_free_microcode(struct amdgpu_device *adev)
 static int sdma_v2_4_init_microcode(struct amdgpu_device *adev)
 {
 	const char *chip_name;
-	char fw_name[30];
 	int err = 0, i;
 	struct amdgpu_firmware_info *info = NULL;
 	const struct common_firmware_header *header = NULL;
@@ -145,10 +144,11 @@ static int sdma_v2_4_init_microcode(struct amdgpu_device *adev)
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		if (i == 0)
-			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_sdma.bin", chip_name);
+			err = amdgpu_ucode_request(adev, &adev->sdma.instance[i].fw,
+						   "amdgpu/%s_sdma.bin", chip_name);
 		else
-			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_sdma1.bin", chip_name);
-		err = amdgpu_ucode_request(adev, &adev->sdma.instance[i].fw, fw_name);
+			err = amdgpu_ucode_request(adev, &adev->sdma.instance[i].fw,
+						   "amdgpu/%s_sdma1.bin", chip_name);
 		if (err)
 			goto out;
 		hdr = (const struct sdma_firmware_header_v1_0 *)adev->sdma.instance[i].fw->data;
@@ -169,7 +169,8 @@ static int sdma_v2_4_init_microcode(struct amdgpu_device *adev)
 
 out:
 	if (err) {
-		pr_err("sdma_v2_4: Failed to load firmware \"%s\"\n", fw_name);
+		pr_err("sdma_v2_4: Failed to load firmware \"%s_sdma%s.bin\"\n",
+		       chip_name, i == 0 ? "" : "1");
 		for (i = 0; i < adev->sdma.num_instances; i++)
 			amdgpu_ucode_release(&adev->sdma.instance[i].fw);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
index b8ebdc4ae6f6..aa637541da58 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -267,7 +267,6 @@ static void sdma_v3_0_free_microcode(struct amdgpu_device *adev)
 static int sdma_v3_0_init_microcode(struct amdgpu_device *adev)
 {
 	const char *chip_name;
-	char fw_name[30];
 	int err = 0, i;
 	struct amdgpu_firmware_info *info = NULL;
 	const struct common_firmware_header *header = NULL;
@@ -305,10 +304,11 @@ static int sdma_v3_0_init_microcode(struct amdgpu_device *adev)
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		if (i == 0)
-			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_sdma.bin", chip_name);
+			err = amdgpu_ucode_request(adev, &adev->sdma.instance[i].fw,
+						   "amdgpu/%s_sdma.bin", chip_name);
 		else
-			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_sdma1.bin", chip_name);
-		err = amdgpu_ucode_request(adev, &adev->sdma.instance[i].fw, fw_name);
+			err = amdgpu_ucode_request(adev, &adev->sdma.instance[i].fw,
+						   "amdgpu/%s_sdma1.bin", chip_name);
 		if (err)
 			goto out;
 		hdr = (const struct sdma_firmware_header_v1_0 *)adev->sdma.instance[i].fw->data;
@@ -327,7 +327,8 @@ static int sdma_v3_0_init_microcode(struct amdgpu_device *adev)
 	}
 out:
 	if (err) {
-		pr_err("sdma_v3_0: Failed to load firmware \"%s\"\n", fw_name);
+		pr_err("sdma_v3_0: Failed to load firmware \"%s_sdma%s.bin\"\n",
+		       chip_name, i == 0 ? "" : "1");
 		for (i = 0; i < adev->sdma.num_instances; i++)
 			amdgpu_ucode_release(&adev->sdma.instance[i].fw);
 	}
-- 
2.34.1

