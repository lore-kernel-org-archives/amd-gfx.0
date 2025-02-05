Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E59AC02194
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2025 11:51:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DCBD10E78B;
	Wed,  5 Feb 2025 11:51:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DQtHlZWN";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5ADB10E78A
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2025 11:38:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rZevpdh5D3lsLUDzgKG6OEZh/KFy6rfPQCg3JaieBH8S+VGppL5GOdcA+nbCLwSddicSjcAzcH3vVL4mc9M4Ke+Z3VrpUGQQN/SFEhvvVv8uZ1q5F3+wdBrlPG20QZIGlOoMIV1OIe1PVT5v5+d9vxWnyp3jCxMZjeOX2SeWlUg9h4zKRf4XBjDHXaKzhsrbCAOiqxvnjj2H8NbI5wchqq2LUkYVmDNrc6a3j7TfiCKJI7U2D1bkc/kcfGw/0PbfdX+oetU/RnyrMjKTG3ETSOw0r/bJGgIbCD2AzfSLHjnmokiDTsWkYwC99KksNDpyYAhXKvaUJu+TrXRNdYWcsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JsSESQoItTTy9cJF0ZHmO7oMxLHpBJ28iY/dQrE4MsY=;
 b=v5BltxnEqbDPdU+1qxh8Kx0vof+cabS5Hk6gd0hW4CQ9tg4giLTH1ZtnhKUa86/cTxXqsUflfIaUlPhbS97GpozxQhzDFnFEL1mgCMbdAAvPLz1tGUrmOXS1zW6WOA7NXIFX03Wer6oGe5rkwu+rvFyIqXlnsoHu0FQp4LY6WVHZHG9Ti8BnS4JowMbD2nI6SqUKiICNRRGoVdV/FnY//CD6S3VCaF54WQ4D/dpOS7J0mTddhTalXbovzt4OmmwUfbcj4Xi5B33/ONOd3hIt8xJffCy46wLiBV0sjSa5hmEBNMF4VSsUi/dWMuQrrW5hh+x7smQqfV50C1pOB+014w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JsSESQoItTTy9cJF0ZHmO7oMxLHpBJ28iY/dQrE4MsY=;
 b=DQtHlZWNsZXV3Ilj1RTuzISWgUPSmhmyywpuQzhGo/acOvM6z76RHZnChvmO5IblJMZQdm6gdgDafrKCquPDr9WeDAJ+KOIZ0VjxUp3UHpfIJDe89/qbJiqidfD/abss1KnqMXK8dZJMmdLWOgDOfH2zEMS/p2whv2RxD6c5R/A=
Received: from BN9PR03CA0503.namprd03.prod.outlook.com (2603:10b6:408:130::28)
 by CH3PR12MB8933.namprd12.prod.outlook.com (2603:10b6:610:17a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Wed, 5 Feb
 2025 11:38:51 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:408:130:cafe::19) by BN9PR03CA0503.outlook.office365.com
 (2603:10b6:408:130::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.23 via Frontend Transport; Wed,
 5 Feb 2025 11:38:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 11:38:50 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 05:38:49 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>
Subject: [PATCH 2/4] drm/amdgpu: Add VBIOS flags
Date: Wed, 5 Feb 2025 17:08:30 +0530
Message-ID: <20250205113832.1903614-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250205113832.1903614-1-lijo.lazar@amd.com>
References: <20250205113832.1903614-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|CH3PR12MB8933:EE_
X-MS-Office365-Filtering-Correlation-Id: f2be8531-7e53-4c5c-603a-08dd45d9a974
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sBRN2CCV7KnQSkw/U51cNRL/LK/CHTAg22k1blB2IT2IyDhrl+dyZmBcUFGz?=
 =?us-ascii?Q?kuI1qrAVSGpxaJGdSP7Bobzu/BDmxtGxIdfvidf3GL2PI9FKWMn5oaMqR7Zd?=
 =?us-ascii?Q?zj6z3UGynnkauP6XuCyv9hoco7ReHMtsKYHAHVmbH2MAzbOtLCKasb4WIwvr?=
 =?us-ascii?Q?NrRMuTZdXP/WKNdT9bvx9dmkGtpi2vorZrtqTIiVNTRY6ISFX2vEp8sm/WYp?=
 =?us-ascii?Q?rwygOg2/pwB8UihKPLlgIpou8UvzoyC7kNqrkCrfN6Rr5D5PJWRuHpyLj5sP?=
 =?us-ascii?Q?tASzPD/L5VLPdxRosgTveb0YUgHr5tYLjwteQ1+wwF8qJ17eyABhf4ftyvqn?=
 =?us-ascii?Q?pwUJDkjcY76y0pxJUgAcaLNPTN0YuxJIUxKtdf+eNxr9v5g5qRsK4ORhbvul?=
 =?us-ascii?Q?SpGKT/rxXMFsDS5T9q3y8Fx0FsHKvBHy6LNRN7IUpSzkEzQKyOICEUzlCgp/?=
 =?us-ascii?Q?cXChwly5HqN9xphMLnHYvyiux4k1hVjzk5Tvv6xvSPE5uoBFRY1GstQnwByC?=
 =?us-ascii?Q?qNhNKSVxFXMnjIWcSbpnQFlSDGe76ypaeHITwUt47TIUgkiC2eJySwiabQ3K?=
 =?us-ascii?Q?YVMuyfnOu9SZNoAJWlQeKjb1/arwkB/Qp9uBppGrjyBO2Rqx8N4zMfRd29RU?=
 =?us-ascii?Q?SPqfZkot1pzu7M6XFXkqjU8G0Oap8mG8/9GtkzZMFCmjl84cf/r9T6md6GgO?=
 =?us-ascii?Q?sY5ET8eQbHQpy4xQazQzzH2xtsjHCP70yp8+Czm4w7ZereywKIbIfns8gCBJ?=
 =?us-ascii?Q?QiKBOxr0TqttX/JHyR9wVRGeXxMDd+nOQm2HKqfQXN+prvYXb4xYCAoYKu+s?=
 =?us-ascii?Q?xSA6DjAa1P1pwgcl5QTpQzbpeQnRoUcHvxZWkE9qac9VLl0iPRXW9Fxpq3dN?=
 =?us-ascii?Q?/jX1XVx/KDiapakxRyuJlXV47kp79yCqfA/7LgwuqB1E/BrpL6s8mdznM/c7?=
 =?us-ascii?Q?MRHVecgWtt0j1tlw8okVAtfi9+4vmnGRPCS+6HVnKTFCuxF5UYUb9PTfNut6?=
 =?us-ascii?Q?VdNIA4DR3DIdzTB36cGucHjIDB48sbF4h8bBpJ5or1BqTWvFtCyFV8By9f0n?=
 =?us-ascii?Q?+OC24UwVtX7vEtjCFT2/XUBeeNxNGetYFErxIrT6nFRtZjh2/wsvg/KQy6po?=
 =?us-ascii?Q?ZoPtMlyY9VvE8o503OqtV2iKg3lYMLURtxv9HK/imLELbQABvdkR4cw0nP1e?=
 =?us-ascii?Q?8wR/JSSP4O66Y/E42KQPDUXdKHcmUoaFOPMN2N/HALmYYhUaVJcNdkL7ApjW?=
 =?us-ascii?Q?HIGE24UwvzcykxfyxX/1cwbj1kMBi5YeL9+MvbvHikwNmCtw9u/boM/NYqnq?=
 =?us-ascii?Q?6xy6aTy9bthL8tpLDeHQHYaZewmsI4W2S67moPg0BIU4zPsP0BviJjlCb0FQ?=
 =?us-ascii?Q?dYQUqG5BmJi3j3PZg98vSens7Nvjrg2pU7WyUFbxfMWu1zQsId6z/laymrXW?=
 =?us-ascii?Q?+sS04IBRhNIpZIC/mgGOWXYRFYflqczFoKNPMTcYc07zoaYHrtXSiQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 11:38:50.9049 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2be8531-7e53-4c5c-603a-08dd45d9a974
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8933
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
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index ae83e23872fa..0a3641a2bede 100644
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

