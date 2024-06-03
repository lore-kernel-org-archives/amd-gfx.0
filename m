Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97F45C25B74
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Jun 2024 01:43:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1472010E242;
	Mon,  3 Jun 2024 01:43:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="K3Etv/ci";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C24810E1DB
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Jun 2024 01:43:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ptm8+f9uKqYzbcrG86mSkZRQzXuMAFoAruJ/k8kF/iAan4601m1GJJ/LSYBKWAoO5srrZf0btt6UHsJaDRPi/CXu5DWA+JWBGOVJTjGQ5VzdZhnO8NxPt7TE7EPFVyKzn0LURC/o412kNh0SiFqAtgSetRMHv4rT+RVrDKY+833qORAIhWv80nlR7vKZBwAxdbq9yUAqxFAa32AY5dEmeze1R+06vq0NNoDWG2PAWruWURv2Hi3TfUBC2S1/Sp0dXGOntpNcyjePI83u03WkJyt41FYy+8fllVTMfxcoFGoJA3psSJ5+gtxjvj+Lead4jfH0C/6YGpB0ccSKJTowkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/6n3g0Szp6ZmNwrd2AivhizWHPu/YG+MIIo+JDXLfiY=;
 b=kDvMDYOj7GeRvMMqQqXbnA08wCX6KdHu3kJI1GeLvyPCez7HEkmRUGBbs3JPP4xZSmWTc0H3eAZlGznMBNuGMUeynxWfl4LNkD1Llb8RN4xpGUNGYBPT9DBr3KrndBdEkFNz6AZZ+jf6iUDV1QAqE60zsEKUlG3E8JRgdRQRYqyIZZG25/O2nnONfTE2XFfZH2OzpSfXzbh9Ez0h4FGuvBTMDjJPsDuSnC8aMspOdUnQ8SVWu7eVs54jpr1cy5hM+0EEwPVtcIHyhiNooX9pEd7p3HtKIfd9ItfuC7Kh0Zg/U85rVo8i1hwoeRLE74Ao1H1dEwIw0O3woIkHtVZD5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/6n3g0Szp6ZmNwrd2AivhizWHPu/YG+MIIo+JDXLfiY=;
 b=K3Etv/cihS2ftUwG+A+sX6O9rAaCs5kSiC4jJYOh4jP0bYCbtITRJN+ITiyqmpiu6k96iSy6TEHpraJE7DDnC7gOk8W8VyiAIWM4GJa/mqPurt+fvqRpJwjIl35+YF4dwLGskAjDOK6mzunsyT+4gnaWk1h1nA2LxM18zSnFKSg=
Received: from SJ0PR13CA0231.namprd13.prod.outlook.com (2603:10b6:a03:2c1::26)
 by SN7PR12MB8817.namprd12.prod.outlook.com (2603:10b6:806:347::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 3 Jun
 2024 01:43:12 +0000
Received: from SJ5PEPF000001D1.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::ec) by SJ0PR13CA0231.outlook.office365.com
 (2603:10b6:a03:2c1::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.14 via Frontend
 Transport; Mon, 3 Jun 2024 01:43:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D1.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Mon, 3 Jun 2024 01:43:11 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sun, 2 Jun
 2024 20:43:04 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 17/18] drm/amdgpu: refine gfx11 firmware loading
Date: Mon, 3 Jun 2024 09:42:11 +0800
Message-ID: <20240603014212.1969546-18-kevinyang.wang@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D1:EE_|SN7PR12MB8817:EE_
X-MS-Office365-Filtering-Correlation-Id: 2edfdc21-02d7-4a8a-6779-08dc836e8734
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|36860700004|376005|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dJhHudzmBJ2Kd1wdJcgRoCQgJWhrvGuD06cuhaaPnhWLL4L8NuH8mYkp7YSN?=
 =?us-ascii?Q?ScETF8xlkIhXF9BM6a0eqQF7790D+Gx0J5vLJkkNiVwUaSI6Z9axXTSdO28z?=
 =?us-ascii?Q?mCerrxGObRhG2p3FTvuBTwHYcdWtZClkoqc/mOCozqbbEOidiR07YIr9zCSh?=
 =?us-ascii?Q?F/w2XmFBV79+Zl1K9ZeJLWGAU6PUlleu/KOhwB/W4CP6VaTkAX2AyG4k+4YF?=
 =?us-ascii?Q?5oMXUIW+LSFBgm3gavXgzCJkhVRSa0cFFz1Hbr/mgTjaMkSsLnZwtYY1C+ls?=
 =?us-ascii?Q?W+ry8K4dhiM8/wqkR+xeBp877WcANZNqnmNEKbgikcMlZnYWRTG/HB9g/V2h?=
 =?us-ascii?Q?wLwYptchloNfyU5FMecFCyePfswLz/PUx2Oh2tAjbdcnrpe8YEFb5JpeACFY?=
 =?us-ascii?Q?4u2TdyRNZKRAr+3V8b0HPsAUKUpCfLDaM5IxVIa+D6HTZIsVtIV4ob1QvbNm?=
 =?us-ascii?Q?yoZX1yso/Tum2SUO6mvTFF7iE9w+YAHF1j2njDJwW8oj/pNNf+V42c4aidb/?=
 =?us-ascii?Q?oqqQBVbWzd6wiczigRsI9Mj4OfYpf90ZEpB5YWULM9xI7FeaaSQ3hfrSEApm?=
 =?us-ascii?Q?awsA1chGkaED9OdY5hCRvxHnJNCOzYcdI2QHOgOEglyGdAhU+TsqmLz3bz/a?=
 =?us-ascii?Q?Bp6dbjPvvDvbIpNDBIIFcnuL2pHKpquRCNPkCGo4Pe21pMs/XJqNwY7NgJGw?=
 =?us-ascii?Q?/t2Pgh4BsPlEvEj75ici37tUKsZltNhpbx0yg+VuV+GeeO/hi6XnOAdpeggQ?=
 =?us-ascii?Q?lYpXzAbWGB1T07QU55p1Z1V0C4o5ozN0Ib5j0o0tcyvGJLopGEd0ExY5wBd4?=
 =?us-ascii?Q?vjwYpFOZtkO8rpJJb0z67Su/LO5wmdM+X22zWyaukvG5ktAAUTf9mlEuUDNS?=
 =?us-ascii?Q?tR5K2vzhAC1IJy3PwQAygXbu/oVHv8dECYHTEfP4iEcU3hrzziSijiPwL5NJ?=
 =?us-ascii?Q?ov4SrrDML1FIU3MlDlOyPKHODnjOM0r0sf0ng41YCyKOj6xATBnBL7k1J7Nj?=
 =?us-ascii?Q?ZUiZXoIrMnLbm4GfXVxcCHeDZmV/FzGajV/yS68KudpZAB5EFf0LKsytoQZS?=
 =?us-ascii?Q?Bz+tBqxPvzV+tSd5pr7Ndbr1Qb6XlqFUZ1fGqh1NXtPhQ2bZSbDAITvBecGW?=
 =?us-ascii?Q?gOEBq0S6HQECx/kueC8buZU1SRdO5nf8piFyTDcjahXvvh5hESACmK5CWz6R?=
 =?us-ascii?Q?O4HiQpY8hc/rL7jOeAX6l5zXQz791IEEPGLh9FJdx9oMG74/LpUaRKIKInwk?=
 =?us-ascii?Q?wRmrNOunJVVVIbwLAdm3208EcmY4hcV57y8NmS7pIiHOL8YdfNtfCTI5EtO+?=
 =?us-ascii?Q?aMcmUxQmhxes/j9/GeXNTcc4S4BN74qNmoivCsek6C/8rZG6+S0ZYkmVdQg4?=
 =?us-ascii?Q?FlpZlZ0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(36860700004)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 01:43:11.6673 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2edfdc21-02d7-4a8a-6779-08dc836e8734
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8817
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

refine gfx11 firmware loading

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 0a9cbb550194..0b51755a449d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -611,10 +611,9 @@ static int gfx_v11_0_init_toc_microcode(struct amdgpu_device *adev, const char *
 {
 	const struct psp_firmware_header_v1_0 *toc_hdr;
 	int err = 0;
-	char fw_name[40];
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_toc.bin", ucode_prefix);
-	err = amdgpu_ucode_request(adev, &adev->psp.toc_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->psp.toc_fw,
+				   "amdgpu/%s_toc.bin", ucode_prefix);
 	if (err)
 		goto out;
 
@@ -653,7 +652,6 @@ static void gfx_v11_0_check_fw_cp_gfx_shadow(struct amdgpu_device *adev)
 
 static int gfx_v11_0_init_microcode(struct amdgpu_device *adev)
 {
-	char fw_name[40];
 	char ucode_prefix[25];
 	int err;
 	const struct rlc_firmware_header_v2_0 *rlc_hdr;
@@ -663,9 +661,8 @@ static int gfx_v11_0_init_microcode(struct amdgpu_device *adev)
 	DRM_DEBUG("\n");
 
 	amdgpu_ucode_ip_version_decode(adev, GC_HWIP, ucode_prefix, sizeof(ucode_prefix));
-
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_pfp.bin", ucode_prefix);
-	err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw,
+				   "amdgpu/%s_pfp.bin", ucode_prefix);
 	if (err)
 		goto out;
 	/* check pfp fw hdr version to decide if enable rs64 for gfx11.*/
@@ -681,8 +678,8 @@ static int gfx_v11_0_init_microcode(struct amdgpu_device *adev)
 		amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_PFP);
 	}
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_me.bin", ucode_prefix);
-	err = amdgpu_ucode_request(adev, &adev->gfx.me_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gfx.me_fw,
+				   "amdgpu/%s_me.bin", ucode_prefix);
 	if (err)
 		goto out;
 	if (adev->gfx.rs64_enable) {
@@ -696,10 +693,11 @@ static int gfx_v11_0_init_microcode(struct amdgpu_device *adev)
 	if (!amdgpu_sriov_vf(adev)) {
 		if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 0, 0) &&
 		    adev->pdev->revision == 0xCE)
-			snprintf(fw_name, sizeof(fw_name), "amdgpu/gc_11_0_0_rlc_1.bin");
+			err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw,
+						   "amdgpu/gc_11_0_0_rlc_1.bin");
 		else
-			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_rlc.bin", ucode_prefix);
-		err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw, fw_name);
+			err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw,
+						   "amdgpu/%s_rlc.bin", ucode_prefix);
 		if (err)
 			goto out;
 		rlc_hdr = (const struct rlc_firmware_header_v2_0 *)adev->gfx.rlc_fw->data;
@@ -710,8 +708,8 @@ static int gfx_v11_0_init_microcode(struct amdgpu_device *adev)
 			goto out;
 	}
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec.bin", ucode_prefix);
-	err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
+				   "amdgpu/%s_mec.bin", ucode_prefix);
 	if (err)
 		goto out;
 	if (adev->gfx.rs64_enable) {
-- 
2.34.1

