Return-Path: <SRS0=vd7l=OL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8641C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:07:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66E6A60527
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:07:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 66E6A60527
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C12B36EA1E;
	Tue, 21 Sep 2021 18:07:46 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E2D26EA1E
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Sep 2021 18:07:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MKTJzwOq5y9X4804BtkTkW8mUvBn++CdmbGtKM3RSybmeOqX13wBNavMilFuHLrJgPKuDiRb02epbaU3SGt3T/jknjM2DeVWlgI9X6kc7NUboeDZO5L/xo112omiBXwyx5+fY9V9W7KIW51et7svcbXvCASpFrAvA5brWJmzdWapKjwoPosC54c6Bf0excImZQvwELJKFujAqbgT7EbMCfCKxquZa7FgtgAyaGZgL2hJ8Wb34yvZ64yrzhm0wGpIbt4/NutRkG1NJJMJ3/NU/cp/drchZwZOsugdo97j1ltL6QMyKYmEh1vmVFLZLVQFQghWj14JHnuKCsV8Ex3zJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=5z65VzuTzSvECZuMZoDXKSX1JEWHIrlEAzLGuv5nEuU=;
 b=PIM/QXyxYuXyZnHPfN7BQaAfNTvs30oBhtwFkpZrY6hrQdV1+tfhe1QGJQqqV27wn3pIHnxmhD8XeffSG1q+GsadhO+040HXJiiU6J2vra+Y35MDBzNiyVADJva2m9IpOW+GM6epJnyKhDI4XuVYMr5T/GMmhv0FKGifwBvSDB/3eNC7C+9l7Q20tQPa91jTWSRX1h3F/ft6RGuzFT85j6jh2yuGyiIK8TEpbDMZGgKbFw5ZwPYtl1GXpGGQOTN1qAxAYt6aZRyQ1m7urM4DpBNndnjBllPARNKNmPetSnLpYawjRofA42A6+X3rRxvsmpqCExv2dCW7GAvNd7ijWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5z65VzuTzSvECZuMZoDXKSX1JEWHIrlEAzLGuv5nEuU=;
 b=cqw2ys0VYoMqYpd6WnXe3oTtnk5s35BXT2IfGfXNZcJiYltcn+2eG+nOtCrkO4Y2gj9lZygRbndA+P5VZVZKakdh7EgUNheG5lldgtiydhgaCbaVkOGM3hELCuww7Jau7m+AVb+1vV3i9CxOKFTv2nybBLtosmsrn9h6y9AwCY8=
Received: from DM5PR11CA0014.namprd11.prod.outlook.com (2603:10b6:3:115::24)
 by DM4PR12MB5182.namprd12.prod.outlook.com (2603:10b6:5:395::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Tue, 21 Sep
 2021 18:07:44 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:115:cafe::cd) by DM5PR11CA0014.outlook.office365.com
 (2603:10b6:3:115::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Tue, 21 Sep 2021 18:07:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Tue, 21 Sep 2021 18:07:44 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 21 Sep
 2021 13:07:43 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 07/66] drm/amdgpu: add initial IP enumeration via IP discovery
 table
Date: Tue, 21 Sep 2021 14:06:26 -0400
Message-ID: <20210921180725.1985552-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210921180725.1985552-1-alexander.deucher@amd.com>
References: <20210921180725.1985552-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4f75e13-0c80-4200-6360-08d97d2ab5ed
X-MS-TrafficTypeDiagnostic: DM4PR12MB5182:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5182FFB59E8241EE681A0AB5F7A19@DM4PR12MB5182.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sSzgvY+gPXR6G4JcgxkR1yUYidB4IltRIgYHvER/QlC8RA4FzpJmrwGtt+DgKI8sm5eQJtFERiWtqBSM6CeKkEGZHuFlRPeERWtxpDxTOg+pXhuKhv+SNF61DG+hoDkQIv6VKG5agD9pAZ76X4Nv4Ro/Iomg8NzrztxsZnD4s2pDnrthtlJvs9jdmDlsoh31r/GPEmXJkxUYiABfd6Y7v2Sn5S2vlawcd+rYTaEFm7E2TI2aJjKRgYNkGoxUkoVQgKkTXYumt1+pcQF6t70WSjjf7V7vsV4dkE/iYKZCgWeO+8KwqSvzP3fNRWhBAGqFs67c95zDbE8RFiP8aJ/GFQS3hVTUJipt6yCcsLwmKKMiJ5l9YTQuwVOAY0Nv34roMCWKxenkhMCfquEV1y1gxk3DmsiyNe4/DGnNjUFPVzFAjZRb9oub/uwAtEMtX2JQzQg4viyFURNDb968UWkXKrhqVmxTsgL/QFYMh2EwX3+EtG9G7qeza3W2tnn3kCESYjEes5VscucUerHY+vofFzoYzTVnCCct2mRSmc7T4wETYYoguBxYkvddcvsXheMCE59eNI8jvr7hgGNxq+5+HbuP8eLGpSvRt87HZDir2uwoTvSmtnnB/mHWR8HsGHOjs329aAXLrsNKiD7bnaEQ+d8quapJEyroLIAvgXIM5j9tvw7Zy92bI+/OXWIPCLEWEOom39xTesDi25btmiLfj+45nCY7eEkh32q7zblX5jw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(6916009)(316002)(83380400001)(6666004)(4326008)(2616005)(508600001)(356005)(426003)(47076005)(336012)(82310400003)(36860700001)(70206006)(8676002)(70586007)(26005)(16526019)(186003)(2906002)(8936002)(86362001)(7696005)(1076003)(5660300002)(36756003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 18:07:44.3158 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4f75e13-0c80-4200-6360-08d97d2ab5ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5182
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

Add initial support for all navi based parts.

v2: rebase

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 333 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h |   1 +
 2 files changed, 334 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 13d143c668a0..048a08d7f480 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -26,6 +26,26 @@
 #include "soc15_hw_ip.h"
 #include "discovery.h"
 
+#include "gmc_v10_0.h"
+#include "gfxhub_v2_0.h"
+#include "mmhub_v2_0.h"
+#include "nbio_v2_3.h"
+#include "nbio_v7_2.h"
+#include "hdp_v5_0.h"
+#include "nv.h"
+#include "navi10_ih.h"
+#include "gfx_v10_0.h"
+#include "sdma_v5_0.h"
+#include "sdma_v5_2.h"
+#include "vcn_v2_0.h"
+#include "jpeg_v2_0.h"
+#include "vcn_v3_0.h"
+#include "jpeg_v3_0.h"
+#include "amdgpu_vkms.h"
+#include "mes_v10_1.h"
+#include "smuio_v11_0.h"
+#include "smuio_v11_0_6.h"
+
 #define mmRCC_CONFIG_MEMSIZE	0xde3
 #define mmMM_INDEX		0x0
 #define mmMM_INDEX_HI		0x6
@@ -463,3 +483,316 @@ int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev)
 
 	return 0;
 }
+
+
+int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
+{
+	int r;
+
+	r = amdgpu_discovery_reg_base_init(adev);
+	if (r)
+		return -EINVAL;
+
+	amdgpu_discovery_harvest_ip(adev);
+
+	if (!adev->mman.discovery_bin) {
+		DRM_ERROR("ip discovery uninitialized\n");
+		return -EINVAL;
+	}
+
+	switch (adev->ip_versions[GC_HWIP]) {
+	case IP_VERSION(10, 1, 10):
+	case IP_VERSION(10, 1, 1):
+	case IP_VERSION(10, 1, 2):
+	case IP_VERSION(10, 1, 3):
+	case IP_VERSION(10, 3, 0):
+	case IP_VERSION(10, 3, 2):
+	case IP_VERSION(10, 3, 4):
+	case IP_VERSION(10, 3, 5):
+		adev->family = AMDGPU_FAMILY_NV;
+		break;
+	case IP_VERSION(10, 3, 1):
+		adev->family = AMDGPU_FAMILY_VGH;
+		break;
+	case IP_VERSION(10, 3, 3):
+		adev->family = AMDGPU_FAMILY_YC;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (adev->ip_versions[XGMI_HWIP] == IP_VERSION(4, 8, 0))
+		adev->gmc.xgmi.supported = true;
+
+	/* set NBIO version */
+	switch (adev->ip_versions[NBIO_HWIP]) {
+	case IP_VERSION(7, 2, 0):
+	case IP_VERSION(7, 2, 1):
+	case IP_VERSION(7, 5, 0):
+		adev->nbio.funcs = &nbio_v7_2_funcs;
+		adev->nbio.hdp_flush_reg = &nbio_v7_2_hdp_flush_reg;
+		break;
+	case IP_VERSION(2, 1, 1):
+	case IP_VERSION(2, 3, 0):
+	case IP_VERSION(2, 3, 1):
+	case IP_VERSION(2, 3, 2):
+	case IP_VERSION(3, 3, 0):
+	case IP_VERSION(3, 3, 1):
+	case IP_VERSION(3, 3, 2):
+	case IP_VERSION(3, 3, 3):
+		adev->nbio.funcs = &nbio_v2_3_funcs;
+		adev->nbio.hdp_flush_reg = &nbio_v2_3_hdp_flush_reg;
+		break;
+	default:
+		break;
+	}
+
+	switch (adev->ip_versions[HDP_HWIP]) {
+	case IP_VERSION(5, 0, 0):
+	case IP_VERSION(5, 0, 1):
+	case IP_VERSION(5, 0, 2):
+	case IP_VERSION(5, 0, 3):
+	case IP_VERSION(5, 0, 4):
+	case IP_VERSION(5, 2, 0):
+		adev->hdp.funcs = &hdp_v5_0_funcs;
+		break;
+	default:
+		break;
+	}
+
+	switch (adev->ip_versions[SMUIO_HWIP]) {
+	case IP_VERSION(11, 0, 0):
+	case IP_VERSION(11, 0, 4):
+	case IP_VERSION(11, 0, 7):
+	case IP_VERSION(11, 0, 8):
+		adev->smuio.funcs = &smuio_v11_0_funcs;
+		break;
+	case IP_VERSION(11, 0, 6):
+	case IP_VERSION(11, 0, 10):
+	case IP_VERSION(11, 0, 11):
+	case IP_VERSION(11, 5, 0):
+	case IP_VERSION(13, 0, 1):
+		adev->smuio.funcs = &smuio_v11_0_6_funcs;
+		break;
+	default:
+		break;
+	}
+
+	/* what IP to use for this? */
+	switch (adev->ip_versions[GC_HWIP]) {
+	case IP_VERSION(10, 1, 10):
+	case IP_VERSION(10, 1, 1):
+	case IP_VERSION(10, 1, 2):
+	case IP_VERSION(10, 1, 3):
+	case IP_VERSION(10, 3, 0):
+	case IP_VERSION(10, 3, 1):
+	case IP_VERSION(10, 3, 2):
+	case IP_VERSION(10, 3, 3):
+	case IP_VERSION(10, 3, 4):
+	case IP_VERSION(10, 3, 5):
+		amdgpu_device_ip_block_add(adev, &nv_common_ip_block);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* use GC or MMHUB IP version */
+	switch (adev->ip_versions[GC_HWIP]) {
+	case IP_VERSION(10, 1, 10):
+	case IP_VERSION(10, 1, 1):
+	case IP_VERSION(10, 1, 2):
+	case IP_VERSION(10, 1, 3):
+	case IP_VERSION(10, 3, 0):
+	case IP_VERSION(10, 3, 1):
+	case IP_VERSION(10, 3, 2):
+	case IP_VERSION(10, 3, 3):
+	case IP_VERSION(10, 3, 4):
+	case IP_VERSION(10, 3, 5):
+		amdgpu_device_ip_block_add(adev, &gmc_v10_0_ip_block);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (adev->ip_versions[OSSSYS_HWIP]) {
+	case IP_VERSION(5, 0, 0):
+	case IP_VERSION(5, 0, 1):
+	case IP_VERSION(5, 0, 2):
+	case IP_VERSION(5, 0, 3):
+	case IP_VERSION(5, 2, 0):
+	case IP_VERSION(5, 2, 1):
+		amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP)) {
+		switch (adev->ip_versions[MP0_HWIP]) {
+		case IP_VERSION(11, 0, 0):
+		case IP_VERSION(11, 0, 5):
+		case IP_VERSION(11, 0, 9):
+		case IP_VERSION(11, 0, 7):
+		case IP_VERSION(11, 0, 11):
+		case IP_VERSION(11, 0, 12):
+		case IP_VERSION(11, 0, 13):
+		case IP_VERSION(11, 5, 0):
+			amdgpu_device_ip_block_add(adev, &psp_v11_0_ip_block);
+			break;
+		case IP_VERSION(11, 0, 8):
+			amdgpu_device_ip_block_add(adev, &psp_v11_0_8_ip_block);
+			break;
+		case IP_VERSION(13, 0, 1):
+		case IP_VERSION(13, 0, 3):
+			amdgpu_device_ip_block_add(adev, &psp_v13_0_ip_block);
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP)) {
+		switch (adev->ip_versions[MP1_HWIP]) {
+		case IP_VERSION(11, 0, 0):
+		case IP_VERSION(11, 0, 9):
+		case IP_VERSION(11, 0, 7):
+		case IP_VERSION(11, 0, 8):
+		case IP_VERSION(11, 0, 11):
+		case IP_VERSION(11, 0, 12):
+		case IP_VERSION(11, 0, 13):
+		case IP_VERSION(11, 5, 0):
+			amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
+			break;
+		case IP_VERSION(13, 0, 1):
+		case IP_VERSION(13, 0, 3):
+			amdgpu_device_ip_block_add(adev, &smu_v13_0_ip_block);
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	if (adev->enable_virtual_display || amdgpu_sriov_vf(adev)) {
+		amdgpu_device_ip_block_add(adev, &amdgpu_vkms_ip_block);
+#if defined(CONFIG_DRM_AMD_DC)
+	} else {
+		switch (adev->ip_versions[DCE_HWIP]) {
+		case IP_VERSION(2, 0, 2):
+		case IP_VERSION(2, 0, 0):
+		case IP_VERSION(3, 0, 0):
+		case IP_VERSION(3, 0, 2):
+		case IP_VERSION(3, 0, 3):
+		case IP_VERSION(3, 0, 1):
+		case IP_VERSION(3, 1, 2):
+		case IP_VERSION(3, 1, 3):
+			amdgpu_device_ip_block_add(adev, &dm_ip_block);
+			break;
+		case IP_VERSION(2, 0, 3):
+			break;
+		default:
+			return -EINVAL;
+		}
+
+	}
+#endif
+	switch (adev->ip_versions[GC_HWIP]) {
+	case IP_VERSION(10, 1, 10):
+	case IP_VERSION(10, 1, 2):
+	case IP_VERSION(10, 1, 1):
+	case IP_VERSION(10, 1, 3):
+	case IP_VERSION(10, 3, 0):
+	case IP_VERSION(10, 3, 2):
+	case IP_VERSION(10, 3, 1):
+	case IP_VERSION(10, 3, 4):
+	case IP_VERSION(10, 3, 5):
+	case IP_VERSION(10, 3, 3):
+		amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (adev->ip_versions[SDMA0_HWIP]) {
+	case IP_VERSION(5, 0, 0):
+	case IP_VERSION(5, 0, 1):
+	case IP_VERSION(5, 0, 2):
+	case IP_VERSION(5, 0, 5):
+		amdgpu_device_ip_block_add(adev, &sdma_v5_0_ip_block);
+		break;
+	case IP_VERSION(5, 2, 0):
+	case IP_VERSION(5, 2, 2):
+	case IP_VERSION(5, 2, 4):
+	case IP_VERSION(5, 2, 5):
+	case IP_VERSION(5, 2, 3):
+	case IP_VERSION(5, 2, 1):
+		amdgpu_device_ip_block_add(adev, &sdma_v5_2_ip_block);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
+		switch (adev->ip_versions[MP1_HWIP]) {
+		case IP_VERSION(11, 0, 0):
+		case IP_VERSION(11, 0, 9):
+		case IP_VERSION(11, 0, 7):
+		case IP_VERSION(11, 0, 8):
+		case IP_VERSION(11, 0, 11):
+		case IP_VERSION(11, 0, 12):
+		case IP_VERSION(11, 0, 13):
+		case IP_VERSION(11, 5, 0):
+			amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
+			break;
+		case IP_VERSION(13, 0, 1):
+		case IP_VERSION(13, 0, 3):
+			amdgpu_device_ip_block_add(adev, &smu_v13_0_ip_block);
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	switch (adev->ip_versions[UVD_HWIP]) {
+	case IP_VERSION(2, 0, 0):
+	case IP_VERSION(2, 0, 2):
+		amdgpu_device_ip_block_add(adev, &vcn_v2_0_ip_block);
+		amdgpu_device_ip_block_add(adev, &jpeg_v2_0_ip_block);
+		break;
+	case IP_VERSION(2, 0, 3):
+		break;
+	case IP_VERSION(3, 0, 0):
+	case IP_VERSION(3, 0, 16):
+	case IP_VERSION(3, 1, 1):
+	case IP_VERSION(3, 0, 2):
+		amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
+		amdgpu_device_ip_block_add(adev, &jpeg_v3_0_ip_block);
+		break;
+	case IP_VERSION(3, 0, 33):
+		amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (adev->enable_mes) {
+		switch (adev->ip_versions[GC_HWIP]) {
+		case IP_VERSION(10, 1, 10):
+		case IP_VERSION(10, 1, 1):
+		case IP_VERSION(10, 1, 2):
+		case IP_VERSION(10, 1, 3):
+		case IP_VERSION(10, 3, 0):
+		case IP_VERSION(10, 3, 1):
+		case IP_VERSION(10, 3, 2):
+		case IP_VERSION(10, 3, 3):
+		case IP_VERSION(10, 3, 4):
+		case IP_VERSION(10, 3, 5):
+			amdgpu_device_ip_block_add(adev, &mes_v10_1_ip_block);
+			break;
+		default:
+			break;;
+		}
+	}
+
+	return 0;
+}
+
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
index 48e6b88cfdfe..0ea029e3b850 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
@@ -36,5 +36,6 @@ int amdgpu_discovery_get_ip_version(struct amdgpu_device *adev, int hw_id, int n
 int amdgpu_discovery_get_vcn_version(struct amdgpu_device *adev, int vcn_instance,
 				     int *major, int *minor, int *revision);
 int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev);
+int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev);
 
 #endif /* __AMDGPU_DISCOVERY__ */
-- 
2.31.1

