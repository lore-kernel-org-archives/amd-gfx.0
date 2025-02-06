Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3773BC02198
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2025 04:23:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9B2610E421;
	Thu,  6 Feb 2025 04:23:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="otXkxvz4";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D79D110E420
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2025 04:23:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IrN18epR5DwcWH2RF34HeduBQGrI4r0CTZeijN0Pgqq3yFurKG54ThGbOJjVZh+EajHud+CV1AeHZI8r6/tJLNs5JSzsE9b3ibwU6WBvTgdz0KK3c+rCYOOVWZQem+/pSGPPBybVaRpfiLi2UlBgifn7sP0YL1KTFTgWBedTO8Cer0/5riJbZM2aJ/MBUZzHTUAoFOqW3qz8Ypzr+tRcbHjPcqi7Jyi7GxFRhtFrxh2HWXG74QVfUhME7UEH0SoIWUv1rZYsij/thcIad8gG9405cJVm+08IjULUDjzd1zbvJQBHUkO4KMZyce+5x5obbxkqtdT6KzKfUOtSTinfWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tCI4w7Ga7WdM+rBXPCOifVJaPcLPOaLPEiKpOmvMytk=;
 b=OhHhqcxCSaw62j4y04gZdHwSFPKha6Y3o6t1lrrz6JNysJtj/rubxImOxJGEMB7ZjzAk94qTaleWOaYGsW9zHGfmEQxzwGUdAdIHsjF6Y67wjfyT+yOjYLwTw48rT4HgriucwwGYa5Jd874t8ZEq388F6Bs3VHXtn1a/1ww0ehiS3ZDWTbw9rE5DNTZTdkk3+tAjXa/2w8ir6qXwfG1e00HAHlwjCkdR/YoqgrUHBwOfnQWuMyXHO4rcSpzooca+SVAzBsovfTrAywnrnNVi5UHJ452susn8w4CEDDVo9gyQomt98Ulo8PqGn8/3hRArpvjRN4vGQW+JZIwLA74jBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tCI4w7Ga7WdM+rBXPCOifVJaPcLPOaLPEiKpOmvMytk=;
 b=otXkxvz4hAUuO1nyg4/4T29KxCi5/ij1pnw+BiEI3phEd2+R+fO1yAn9eJXJyy0WkGL0Pgvce3rgp/JSCOb71YzxHuFo/iMPvooxZamT4uftdGxoWjV+7Lth1MZ0pEE8D8OrCGViN4VmNJiHETcJa36oz3eXD876FwvfpozKUA4=
Received: from MW4PR03CA0171.namprd03.prod.outlook.com (2603:10b6:303:8d::26)
 by MW3PR12MB4346.namprd12.prod.outlook.com (2603:10b6:303:58::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Thu, 6 Feb
 2025 04:23:42 +0000
Received: from SJ1PEPF0000231D.namprd03.prod.outlook.com
 (2603:10b6:303:8d:cafe::50) by MW4PR03CA0171.outlook.office365.com
 (2603:10b6:303:8d::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.23 via Frontend Transport; Thu,
 6 Feb 2025 04:23:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231D.mail.protection.outlook.com (10.167.242.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Thu, 6 Feb 2025 04:23:42 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 22:23:30 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Lijo.Lazar@amd.com>
CC: <Hawking.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v2 2/4] drm/amdgpu: Add VBIOS flags
Date: Thu, 6 Feb 2025 09:52:57 +0530
Message-ID: <20250206042259.1927200-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250206042259.1927200-1-lijo.lazar@amd.com>
References: <20250206042259.1927200-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231D:EE_|MW3PR12MB4346:EE_
X-MS-Office365-Filtering-Correlation-Id: ec1327c2-697e-4245-61b2-08dd466609d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?e2O/VagzwNo/1CWalSayNfiIoy0n5Dw0aeJTG419246wwslYbV+1crlsHtMy?=
 =?us-ascii?Q?jsrmSwUgkbihn0bzae+yyEW/nVkI6Fi6uHD+/eJ/nOeGyd6Gns2B7kIGgXb/?=
 =?us-ascii?Q?pNsyAPwff7+FjawRz7v6xfAE/sERPbKkS83vkc89IEzRMtJgCTgqmVYSnqNZ?=
 =?us-ascii?Q?pmHPuEzhcgDxqKLXfEwaFv3gI/AHjTXgB9B+q1BhSUjHbgGGYMhOcFywZCge?=
 =?us-ascii?Q?U63+LgV2MltNZi0UvcDvaO/qYv9Wv72AjDRQowBA2phSxTWvwmGq+beXTmSG?=
 =?us-ascii?Q?8JyH7Yt8Mjw2qStp5kTMYlepanNElzvg/8AIFyG3M/H8eQtuxNh3mBCQ08hx?=
 =?us-ascii?Q?7sc4wSpt4qz0d4LCieX9P2TeiL/QC4aRfYbBFbd/rg0T55HLdceRkhWbCOJb?=
 =?us-ascii?Q?T99As6QrR6pvxY7mG9CHxMPwJF+QB8GDPffas86K+RUOOgEJIfLg69AmlE+S?=
 =?us-ascii?Q?vhc/TTdzYM2EXX/lVMFgwIxeX9ONsCd/iT6xq/NBOF8GZlUekFp/d4ONccaz?=
 =?us-ascii?Q?bA3mo40cp7SWymu+C7CluhnAFqX376cQCbxr/WgMm1zcuG2rlK0wWYXQys03?=
 =?us-ascii?Q?Nk7CmorEqnBTjSuFsDsb9Gc3MImEGfSBA1fozERejZY3HQQdBn78nlpaYYmO?=
 =?us-ascii?Q?IJew8ejJDltVsulF/jCXKgZied5xG3kCUT5BSDdjHTEGFVayIvGR5Px8qJlX?=
 =?us-ascii?Q?jrWBXhacNLL6OlSK/PIxCo/Oncu5AfT0MFa8YqI0HkO/pZqWJmctEuAQzLYl?=
 =?us-ascii?Q?I1SDEbkSDgmMrDDhVASLNb+W/UPyNuP1sSngsI/Mb7Z9VAV9ubg7Uwy8KhtU?=
 =?us-ascii?Q?r3Pji9DWDfBgrapksUXjHRbdc2gEGI2kw332RfJMUwCtY6Ctu7QFosmtjlf5?=
 =?us-ascii?Q?znhZl7fpXlRjJb2sxNf9v2dzr1g9xzMO9VSMThXRFpv540gAQ9QL8e2h4eAr?=
 =?us-ascii?Q?a4avWaqW9t9YpDbHEN634ajNpz+1VOZfl3znnzA8h8nNEQRIbvyG8UqJ2EXn?=
 =?us-ascii?Q?ZbH9xVP1WITmGdk5Veicxe7C4FsXRZbcxyOw3M+MNuwlP4XEjO0WNf3ySm1u?=
 =?us-ascii?Q?hgwXKoBDtQFZ6AjthMRSNe/rxqPJMohmNWXz1Dokm5z2AesGNDQvyVWg4GFR?=
 =?us-ascii?Q?oiya7yxrF6e+6dir9vw7carnVQgD6cU9YP64RFKd/vAoGbiO7iO9oE2o2P4j?=
 =?us-ascii?Q?J6pIOnLG2ev8gJgHz+QNhXxRDPgkqFi3Oazkb7HrixW+kITpnjWqaxCIviyI?=
 =?us-ascii?Q?/5Oj1e4TS4mnTSe33WDHQZNPvDSzTUqH7PKBMggeLHElN9QIWpMkdrWlvpW+?=
 =?us-ascii?Q?1g2h8gZGVMmX/dNgfY4cYz+kup/9hLaaBkc+FTMxz51UkzJwKKxd4zmTZ2N9?=
 =?us-ascii?Q?plIWns/frGwuqKegs4y4EYGsgTGlcE4z6/xRxJp2nIyVuIcMmNRzLjSSsg3s?=
 =?us-ascii?Q?FVpmHuC3mY71lgP2tq4Nf8UvJ2t0BZaI5k+Hyoy9f8hSP9MRCRcdDA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 04:23:42.0085 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec1327c2-697e-4245-61b2-08dd466609d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4346
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

Instead of read_bios, use get_bios_flags to get various options around
reading VBIOS.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 38679e3d5209..8549a9477dc9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -102,6 +102,8 @@ MODULE_FIRMWARE("amdgpu/navi12_gpu_info.bin");
 #define AMDGPU_PCIE_INDEX_HI_FALLBACK (0x44 >> 2)
 #define AMDGPU_PCIE_DATA_FALLBACK (0x3C >> 2)
 
+#define AMDGPU_VBIOS_SKIP (1U << 0)
+
 static const struct drm_driver amdgpu_kms_driver;
 
 const char *amdgpu_asic_name[] = {
@@ -1698,12 +1700,12 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
 	return 0;
 }
 
-static bool amdgpu_device_read_bios(struct amdgpu_device *adev)
+static uint32_t amdgpu_device_get_vbios_flags(struct amdgpu_device *adev)
 {
 	if (hweight32(adev->aid_mask) && (adev->flags & AMD_IS_APU))
-		return false;
+		return AMDGPU_VBIOS_SKIP;
 
-	return true;
+	return 0;
 }
 
 /*
@@ -1720,12 +1722,13 @@ static bool amdgpu_device_read_bios(struct amdgpu_device *adev)
  */
 bool amdgpu_device_need_post(struct amdgpu_device *adev)
 {
-	uint32_t reg;
+	uint32_t reg, flags;
 
 	if (amdgpu_sriov_vf(adev))
 		return false;
 
-	if (!amdgpu_device_read_bios(adev))
+	flags = amdgpu_device_get_vbios_flags(adev);
+	if (flags & AMDGPU_VBIOS_SKIP)
 		return false;
 
 	if (amdgpu_passthrough(adev)) {
@@ -2578,8 +2581,9 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_ip_block *ip_block;
 	struct pci_dev *parent;
+	bool total, skip_bios;
+	uint32_t bios_flags;
 	int i, r;
-	bool total;
 
 	amdgpu_device_enable_virtual_display(adev);
 
@@ -2692,8 +2696,10 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 			if (r)
 				return r;
 
+			bios_flags = amdgpu_device_get_vbios_flags(adev);
+			skip_bios = !!(bios_flags & AMDGPU_VBIOS_SKIP);
 			/* Read BIOS */
-			if (amdgpu_device_read_bios(adev)) {
+			if (!skip_bios) {
 				if (!amdgpu_get_bios(adev))
 					return -EINVAL;
 
-- 
2.25.1

