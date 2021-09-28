Return-Path: <SRS0=UpsA=OS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F7FC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:43:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DD026101E
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:43:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1DD026101E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4D1F6E8AD;
	Tue, 28 Sep 2021 16:43:31 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A0B26E8AD
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Sep 2021 16:43:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hp4U+Jseag9ZvMuIep95T1lNGoHGrXS91AQiOXA30QgRuvIQo5nEWfpzwdjsV/1NPGFqHWZJfPbXwmVRTPWk3Z9PDfJQC17pjcBJIb8InUYB/WM3Btm6tW6YH4w5bYHXULU3fQN2FOpuv/ITPgGYpbQkAXV68tHg9Hi5UXn3dI3RhdWf9kg0OXHp/aW+s3S+sOmr5/Nkt0w1UOz+xwnnWlZSYCxsN5eS7YemQasRc9E187yYCwkiLnuy6LV48y9PmarHXosg6TbJReJjfRNSLHGqWVfaMJ0A5E79JZlEbHbryB72zDonJNsA0iI2jjbvFNfUUxKV70FMwOfvaE1Inw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=p5kKZXrtiG1vf/EuAitHzStmiU8TyAvP/5n5GO/orNI=;
 b=PsEEBPhheS7tpY5sdjOhcxx1+5DTfZ3To+7OD63Ba5O79XzNm4FIvyZFqIizTl+2a5K7yDJYUfbA56zZuBnwS9zPB45mHg+CP0+H/EqOswDtf+bJ+5evD9gnRSHIeugNxuOURL5yQ3iyzbnCuMa0TQdvMNHvqpGhM6eDuKW8fyzRXIeBgWC1zojtQfkey4GCwzvM2sBEhMu9YLRakc07cAU/3FJsNWdMfYKAwsa4GlGkdYTAZs0S3jPGmYtWKfYzbSzCCyvWvvggVXdLeI+hb6ZJhkIjlnszIW0jzpJ+h6QY6zvoTaFn1k94bR/oqaOmU2m8Gv9bOX2dAt39QPGptg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p5kKZXrtiG1vf/EuAitHzStmiU8TyAvP/5n5GO/orNI=;
 b=1M/swDi978lRRVKl8b5R3VKqYVWJO22u9VNeJRYPHGTxSS5V0ifdxicXHoIXehsaVQXogV/fZLateUubldm2EilgEWR4keKgootTq7z9vppTluoXUIURpJxBSc4hxkL9ej0KgLBZEafvL0dicintLZ3K6sDr7mS7+HjNdepFynE=
Received: from DS7PR03CA0219.namprd03.prod.outlook.com (2603:10b6:5:3ba::14)
 by MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Tue, 28 Sep
 2021 16:43:27 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::fa) by DS7PR03CA0219.outlook.office365.com
 (2603:10b6:5:3ba::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend
 Transport; Tue, 28 Sep 2021 16:43:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Tue, 28 Sep 2021 16:43:26 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 28 Sep
 2021 11:43:22 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 07/64] drm/amdgpu: add initial IP enumeration via IP discovery
 table
Date: Tue, 28 Sep 2021 12:41:40 -0400
Message-ID: <20210928164237.833132-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210928164237.833132-1-alexander.deucher@amd.com>
References: <20210928164237.833132-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8b8bb08-7980-4ec4-20f4-08d9829f183d
X-MS-TrafficTypeDiagnostic: MW3PR12MB4379:
X-Microsoft-Antispam-PRVS: <MW3PR12MB4379DFB45CFD834A5A21F565F7A89@MW3PR12MB4379.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JmTmbmtoX/jsyXafJl5OBGUvIU4pLBwSjYzn5k6SgFhoiOed4KE3tg6lihzGkePNUNq77+zDskyIZgZKpdaZR7VquJqKBVRaNqBO/DqKKSCvt3qwUT+4EVhsfp0ONJbuocioYSHJnvHowXcU3OGpCASMIEEu1qhhyWcDEMD/aqaxmtcbXCRkm6aUGFgfALfQk8Nh11sLQZzHgyvwMSvj085oEtqTNTUenXLge0i6ClqXKv4KL1apEgK+GZtL+9V4JS39RkZmFWhTuH3GKfoMh+gwlXO6U7zxgzLEdXKDf7fNk96CmU4okk3kCjFeIZj7dX+hTE8Jz40Pnib9dWz/e7nVmLF1M+BO2p7gA0TrakGrwt6Uz4BuKY0oawvczM9YRhlvOecZt1u4qVogOvRknsWFABuc2HCptRnb3VM80891NJrdnIP7IcA3+NN4ITh57rc2WiYFC3NxaPx74zqNMZUTECKA215ZGBjieNDx6JU6EujNraOY4yiXovMD4mybG1mbuyeB/OOxWu+pHhILmdsDf4VgXZrUx8dv9mY22zG0JX2sWOcWnU1CNGLOE9DcSb0v+SVEZqwyrmTkDU5rjIpOOyBhKrazzOzUVom21X8vKc5CMOKILG3vcuATYpr+0OStvS9agiPPg/7rsJpENh2iD4i7CmBnhkAiFqS1joLG9QpTa1Vz8mxmWVhwrbLbiaY/DQoYHSrYUYubF9PEbQFym26uOuyCcK/cLfcFlNA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(54906003)(70586007)(6916009)(70206006)(316002)(426003)(5660300002)(186003)(26005)(81166007)(7696005)(356005)(2616005)(16526019)(47076005)(336012)(508600001)(6666004)(1076003)(86362001)(4326008)(82310400003)(8676002)(2906002)(36860700001)(8936002)(83380400001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 16:43:26.6846 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8b8bb08-7980-4ec4-20f4-08d9829f183d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4379
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

Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 333 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h |   1 +
 2 files changed, 334 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 885b653f0b05..0f8e12e7bf5e 100644
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
@@ -479,3 +499,316 @@ int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev)
 
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

