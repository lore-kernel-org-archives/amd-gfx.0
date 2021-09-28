Return-Path: <SRS0=UpsA=OS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6C2C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:45:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EB6061262
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:45:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3EB6061262
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8C926E8D1;
	Tue, 28 Sep 2021 16:44:59 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 207166E8D3
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Sep 2021 16:44:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dp1zzwfFnS22EaiqSNc3Pecxbt+lXrQY8WWkoiTX3b8BelyZTeMVRuww7YTdfQVlvTHfcG1ZZcC0+sxWAKWzOO5hGHlXk35FU7CiSBbv6Dy6DCqwfw5GjtCChnlfGzn5PKMDclf3ihd9efXR3F1D+jwmmQS6EU6tDsoUI+IIHZg0SDdfnyDKlFdYUMtuV3wLf2PQJJcenbMgjGY5TtkyCYoUkCt6sy4vAe2irrVTkoWSTsr2k+GIeDDesVxBmDpsoIDBfiJ4Sy+GN5wgl1VoGlZHC6K1IS5EVKX0/qV7jJ4JGL4zhTv3bLlsYzbXw+m4tiHne+SZjyquybUMyczMmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=EkHSGxBLeqdmEPBHdQmZt+VtZryETW9HVvmh4t4QhEI=;
 b=hFOw7fivSYCx/8qsZpdOz6mIAkcwXB28kHdIB99MV0lKiBP6I8XXP2uL80OeGO0HC/MXwS78igMqkk42Q1VPzKsq9IzsW84vTpqvb8026BnFribnvbEZve6j39OpFTYqDZk8zUNNuhI93Urb4KwW9zrkc2ZdYealpjRJDVi+lHKsUgODpoXLufYTFyvw6teR2wuLhAauW7CenXgKE37IvdudlJ8vGdUAltG5l03NZ5uezk2MaeMFyZQVrfbU+uZFJG7APQuP+YasoB6LaP0E2GZKQMkf9pPXfbmkTvy68HT9STtjheSZvhoZF5pwmExNKmKZ2chdm60eUmqTYjDM9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EkHSGxBLeqdmEPBHdQmZt+VtZryETW9HVvmh4t4QhEI=;
 b=RUhF973MPwX3BfYc2TVQkrT6sctSegWrU0JkcKRS2FH0/WgbRGgqJiHfedlpckkVxCoN5TtSPDDBXopPL1/hWcs04Jk9AT22yTyaiTnzMvci94JBv+eq+d1lno6uScjD7RoHDvcRFhObkd08iboKTtaDUH3Bzaxm39YSJRZAwVQ=
Received: from DM3PR11CA0017.namprd11.prod.outlook.com (2603:10b6:0:54::27) by
 DM6PR12MB4154.namprd12.prod.outlook.com (2603:10b6:5:21d::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.14; Tue, 28 Sep 2021 16:44:56 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:54:cafe::cc) by DM3PR11CA0017.outlook.office365.com
 (2603:10b6:0:54::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.13 via Frontend
 Transport; Tue, 28 Sep 2021 16:44:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Tue, 28 Sep 2021 16:44:55 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 28 Sep
 2021 11:44:51 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 32/64] drm/amdgpu: add initial IP discovery support for vega
 based parts
Date: Tue, 28 Sep 2021 12:42:05 -0400
Message-ID: <20210928164237.833132-33-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 906bddc7-8098-462c-e983-08d9829f4d64
X-MS-TrafficTypeDiagnostic: DM6PR12MB4154:
X-Microsoft-Antispam-PRVS: <DM6PR12MB415492AF9F960F61E240F0B9F7A89@DM6PR12MB4154.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pKv+J+QQHNg+83lXWfNOt9spT8r+tfrx9c/IRkmnlL6/osJsXcNJAjiVL+Ven3HaMRfA/Bf1uz82HaBBAp79ppzvKZ/V0ovi17z3ncQ3LopruhpjRWLG7pmSoTiOwIA1vY9zfoojjUImPjPrfS2YV9rzCYqtIoQLJwjLe26ZAVB41JDdH0zM3NtNGRfESiuYwX2A68xWYbpNAcSC2pmToVHuK6oWXa+7UolQSXPQdfsaiEHQLPraUTwrSU7yvk286R0O1PcP+NOpUZgJdBYZ3X4FjUdqIdxfvhvXRhQd5u0g3PayaDWBzlK5zkbKfqgq6c8Qbaip7GFMr68RDCiu+l5CHratENwXEFC23VCoh/zOG3R0CaS3diq/x3yK0Us40lq2JT0mbcy2Y547DOxPb2ADxkDi1H/Fyc0xEtNHpm7vskt1aj5O/Z9/nh+yovo63eUdHZYLw8t/mtEAdufxv3LHoIxWbTfyvZD6IcBMhCuQghshPCy9KH3fjrmcs51JAqS4AsRp3uK52ZA/gFysgRdHBLDEa3zJEGLjj2wqpP1Rr3te0SX6dDFtd29sDRCFSPLXaDvoqJOVnNO5l6sMcrmEdT3+aDzj/G33Uu2UTkbKDxHht0Q4OMGdg3SmP8gUZopjGQhVPHetU0Uc9HlVD7uvQuVjzRRQXc/36kJ7VtKdqbQK+u1XXXYna1oH8AWkgBREFxQw43zkoQSZ31jEebwciQ3CIkhpyrZUJZtbz38=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(508600001)(83380400001)(36860700001)(6666004)(82310400003)(47076005)(1076003)(86362001)(356005)(81166007)(316002)(186003)(16526019)(7696005)(5660300002)(2906002)(6916009)(336012)(8936002)(26005)(70206006)(30864003)(2616005)(4326008)(8676002)(426003)(54906003)(36756003)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 16:44:55.8656 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 906bddc7-8098-462c-e983-08d9829f4d64
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4154
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

Hardcode the IP versions for asics without IP discovery tables
and then enumerate the asics based on the IP versions.

TODO: fix SR-IOV support

Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 417 ++++++++++++++++--
 1 file changed, 387 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index c67edba56490..d3069841ff79 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -26,6 +26,26 @@
 #include "soc15_hw_ip.h"
 #include "discovery.h"
 
+#include "soc15.h"
+#include "gfx_v9_0.h"
+#include "gmc_v9_0.h"
+#include "df_v1_7.h"
+#include "df_v3_6.h"
+#include "nbio_v6_1.h"
+#include "nbio_v7_0.h"
+#include "nbio_v7_4.h"
+#include "hdp_v4_0.h"
+#include "vega10_ih.h"
+#include "vega20_ih.h"
+#include "sdma_v4_0.h"
+#include "uvd_v7_0.h"
+#include "vce_v4_0.h"
+#include "vcn_v1_0.h"
+#include "vcn_v2_0.h"
+#include "jpeg_v2_0.h"
+#include "vcn_v2_5.h"
+#include "jpeg_v2_5.h"
+#include "smuio_v9_0.h"
 #include "gmc_v10_0.h"
 #include "gfxhub_v2_0.h"
 #include "mmhub_v2_0.h"
@@ -45,6 +65,7 @@
 #include "mes_v10_1.h"
 #include "smuio_v11_0.h"
 #include "smuio_v11_0_6.h"
+#include "smuio_v13_0.h"
 
 #define mmRCC_CONFIG_MEMSIZE	0xde3
 #define mmMM_INDEX		0x0
@@ -501,23 +522,166 @@ int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev)
 	return 0;
 }
 
-
 int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 {
 	int r;
 
-	r = amdgpu_discovery_reg_base_init(adev);
-	if (r)
-		return -EINVAL;
+	switch (adev->asic_type) {
+	case CHIP_VEGA10:
+		vega10_reg_base_init(adev);
+		adev->ip_versions[MMHUB_HWIP] = IP_VERSION(9, 0, 0);
+		adev->ip_versions[ATHUB_HWIP] = IP_VERSION(9, 0, 0);
+		adev->ip_versions[OSSSYS_HWIP] = IP_VERSION(4, 0, 0);
+		adev->ip_versions[HDP_HWIP] = IP_VERSION(4, 0, 0);
+		adev->ip_versions[SDMA0_HWIP] = IP_VERSION(4, 0, 0);
+		adev->ip_versions[DF_HWIP] = IP_VERSION(2, 1, 0);
+		adev->ip_versions[NBIO_HWIP] = IP_VERSION(6, 1, 0);
+		adev->ip_versions[UMC_HWIP] = IP_VERSION(6, 0, 0);
+		adev->ip_versions[MP0_HWIP] = IP_VERSION(9, 0, 0);
+		adev->ip_versions[MP1_HWIP] = IP_VERSION(9, 0, 0);
+		adev->ip_versions[THM_HWIP] = IP_VERSION(9, 0, 0);
+		adev->ip_versions[SMUIO_HWIP] = IP_VERSION(9, 0, 0);
+		adev->ip_versions[GC_HWIP] = IP_VERSION(9, 0, 1);
+		adev->ip_versions[UVD_HWIP] = IP_VERSION(7, 0, 0);
+		adev->ip_versions[VCE_HWIP] = IP_VERSION(4, 0, 0);
+		adev->ip_versions[DCI_HWIP] = IP_VERSION(12, 0, 0);
+		break;
+	case CHIP_VEGA12:
+		vega10_reg_base_init(adev);
+		adev->ip_versions[MMHUB_HWIP] = IP_VERSION(9, 3, 0);
+		adev->ip_versions[ATHUB_HWIP] = IP_VERSION(9, 3, 0);
+		adev->ip_versions[OSSSYS_HWIP] = IP_VERSION(4, 0, 1);
+		adev->ip_versions[HDP_HWIP] = IP_VERSION(4, 0, 1);
+		adev->ip_versions[SDMA0_HWIP] = IP_VERSION(4, 0, 1);
+		adev->ip_versions[DF_HWIP] = IP_VERSION(2, 5, 0);
+		adev->ip_versions[NBIO_HWIP] = IP_VERSION(6, 2, 0);
+		adev->ip_versions[UMC_HWIP] = IP_VERSION(6, 1, 0);
+		adev->ip_versions[MP0_HWIP] = IP_VERSION(9, 0, 0);
+		adev->ip_versions[MP1_HWIP] = IP_VERSION(9, 0, 0);
+		adev->ip_versions[THM_HWIP] = IP_VERSION(9, 0, 0);
+		adev->ip_versions[SMUIO_HWIP] = IP_VERSION(9, 0, 1);
+		adev->ip_versions[GC_HWIP] = IP_VERSION(9, 2, 1);
+		adev->ip_versions[UVD_HWIP] = IP_VERSION(7, 0, 0);
+		adev->ip_versions[VCE_HWIP] = IP_VERSION(4, 0, 0);
+		adev->ip_versions[DCI_HWIP] = IP_VERSION(12, 0, 1);
+		break;
+	case CHIP_RAVEN:
+		vega10_reg_base_init(adev);
+		if (adev->apu_flags & AMD_APU_IS_RAVEN2) {
+			adev->ip_versions[MMHUB_HWIP] = IP_VERSION(9, 2, 0);
+			adev->ip_versions[ATHUB_HWIP] = IP_VERSION(9, 2, 0);
+			adev->ip_versions[OSSSYS_HWIP] = IP_VERSION(4, 1, 1);
+			adev->ip_versions[HDP_HWIP] = IP_VERSION(4, 1, 1);
+			adev->ip_versions[SDMA0_HWIP] = IP_VERSION(4, 1, 1);
+			adev->ip_versions[DF_HWIP] = IP_VERSION(2, 1, 1);
+			adev->ip_versions[NBIO_HWIP] = IP_VERSION(7, 0, 1);
+			adev->ip_versions[UMC_HWIP] = IP_VERSION(7, 5, 0);
+			adev->ip_versions[MP0_HWIP] = IP_VERSION(10, 0, 1);
+			adev->ip_versions[MP1_HWIP] = IP_VERSION(10, 0, 1);
+			adev->ip_versions[THM_HWIP] = IP_VERSION(10, 1, 0);
+			adev->ip_versions[SMUIO_HWIP] = IP_VERSION(10, 0, 1);
+			adev->ip_versions[GC_HWIP] = IP_VERSION(9, 2, 2);
+			adev->ip_versions[UVD_HWIP] = IP_VERSION(1, 0, 1);
+			adev->ip_versions[DCE_HWIP] = IP_VERSION(1, 0, 1);
+		} else {
+			adev->ip_versions[MMHUB_HWIP] = IP_VERSION(9, 1, 0);
+			adev->ip_versions[ATHUB_HWIP] = IP_VERSION(9, 1, 0);
+			adev->ip_versions[OSSSYS_HWIP] = IP_VERSION(4, 1, 0);
+			adev->ip_versions[HDP_HWIP] = IP_VERSION(4, 1, 0);
+			adev->ip_versions[SDMA0_HWIP] = IP_VERSION(4, 1, 0);
+			adev->ip_versions[DF_HWIP] = IP_VERSION(2, 1, 0);
+			adev->ip_versions[NBIO_HWIP] = IP_VERSION(7, 0, 0);
+			adev->ip_versions[UMC_HWIP] = IP_VERSION(7, 0, 0);
+			adev->ip_versions[MP0_HWIP] = IP_VERSION(10, 0, 0);
+			adev->ip_versions[MP1_HWIP] = IP_VERSION(10, 0, 0);
+			adev->ip_versions[THM_HWIP] = IP_VERSION(10, 0, 0);
+			adev->ip_versions[SMUIO_HWIP] = IP_VERSION(10, 0, 0);
+			adev->ip_versions[GC_HWIP] = IP_VERSION(9, 1, 0);
+			adev->ip_versions[UVD_HWIP] = IP_VERSION(1, 0, 0);
+			adev->ip_versions[DCE_HWIP] = IP_VERSION(1, 0, 0);
+		}
+		break;
+	case CHIP_VEGA20:
+		vega20_reg_base_init(adev);
+		adev->ip_versions[MMHUB_HWIP] = IP_VERSION(9, 4, 0);
+		adev->ip_versions[ATHUB_HWIP] = IP_VERSION(9, 4, 0);
+		adev->ip_versions[OSSSYS_HWIP] = IP_VERSION(4, 2, 0);
+		adev->ip_versions[HDP_HWIP] = IP_VERSION(4, 2, 0);
+		adev->ip_versions[SDMA0_HWIP] = IP_VERSION(4, 2, 0);
+		adev->ip_versions[DF_HWIP] = IP_VERSION(3, 6, 0);
+		adev->ip_versions[NBIO_HWIP] = IP_VERSION(7, 4, 0);
+		adev->ip_versions[UMC_HWIP] = IP_VERSION(6, 1, 1);
+		adev->ip_versions[MP0_HWIP] = IP_VERSION(11, 0, 2);
+		adev->ip_versions[MP1_HWIP] = IP_VERSION(11, 0, 2);
+		adev->ip_versions[THM_HWIP] = IP_VERSION(11, 0, 2);
+		adev->ip_versions[SMUIO_HWIP] = IP_VERSION(11, 0, 2);
+		adev->ip_versions[GC_HWIP] = IP_VERSION(9, 4, 0);
+		adev->ip_versions[UVD_HWIP] = IP_VERSION(7, 2, 0);
+		adev->ip_versions[VCE_HWIP] = IP_VERSION(4, 1, 0);
+		adev->ip_versions[DCI_HWIP] = IP_VERSION(12, 1, 0);
+		break;
+	case CHIP_ARCTURUS:
+		arct_reg_base_init(adev);
+		adev->ip_versions[MMHUB_HWIP] = IP_VERSION(9, 4, 1);
+		adev->ip_versions[ATHUB_HWIP] = IP_VERSION(9, 4, 1);
+		adev->ip_versions[OSSSYS_HWIP] = IP_VERSION(4, 2, 1);
+		adev->ip_versions[HDP_HWIP] = IP_VERSION(4, 2, 1);
+		adev->ip_versions[SDMA0_HWIP] = IP_VERSION(4, 2, 2);
+		adev->ip_versions[DF_HWIP] = IP_VERSION(3, 6, 1);
+		adev->ip_versions[NBIO_HWIP] = IP_VERSION(7, 4, 1);
+		adev->ip_versions[UMC_HWIP] = IP_VERSION(6, 1, 2);
+		adev->ip_versions[MP0_HWIP] = IP_VERSION(11, 0, 4);
+		adev->ip_versions[MP1_HWIP] = IP_VERSION(11, 0, 2);
+		adev->ip_versions[THM_HWIP] = IP_VERSION(11, 0, 3);
+		adev->ip_versions[SMUIO_HWIP] = IP_VERSION(11, 0, 3);
+		adev->ip_versions[GC_HWIP] = IP_VERSION(9, 4, 1);
+		adev->ip_versions[UVD_HWIP] = IP_VERSION(2, 5, 0);
+		break;
+	case CHIP_ALDEBARAN:
+		aldebaran_reg_base_init(adev);
+		adev->ip_versions[MMHUB_HWIP] = IP_VERSION(9, 4, 2);
+		adev->ip_versions[ATHUB_HWIP] = IP_VERSION(9, 4, 2);
+		adev->ip_versions[OSSSYS_HWIP] = IP_VERSION(4, 4, 0);
+		adev->ip_versions[HDP_HWIP] = IP_VERSION(4, 4, 0);
+		adev->ip_versions[SDMA0_HWIP] = IP_VERSION(4, 4, 0);
+		adev->ip_versions[DF_HWIP] = IP_VERSION(3, 6, 2);
+		adev->ip_versions[NBIO_HWIP] = IP_VERSION(7, 4, 4);
+		adev->ip_versions[UMC_HWIP] = IP_VERSION(6, 7, 0);
+		adev->ip_versions[MP0_HWIP] = IP_VERSION(13, 0, 2);
+		adev->ip_versions[MP1_HWIP] = IP_VERSION(13, 0, 2);
+		adev->ip_versions[THM_HWIP] = IP_VERSION(13, 0, 2);
+		adev->ip_versions[SMUIO_HWIP] = IP_VERSION(13, 0, 2);
+		adev->ip_versions[GC_HWIP] = IP_VERSION(9, 4, 2);
+		adev->ip_versions[UVD_HWIP] = IP_VERSION(2, 6, 0);
+		adev->ip_versions[XGMI_HWIP] = IP_VERSION(6, 1, 0);
+		break;
+	default:
+		r = amdgpu_discovery_reg_base_init(adev);
+		if (r)
+			return -EINVAL;
 
-	amdgpu_discovery_harvest_ip(adev);
+		amdgpu_discovery_harvest_ip(adev);
 
-	if (!adev->mman.discovery_bin) {
-		DRM_ERROR("ip discovery uninitialized\n");
-		return -EINVAL;
+		if (!adev->mman.discovery_bin) {
+			DRM_ERROR("ip discovery uninitialized\n");
+			return -EINVAL;
+		}
+		break;
 	}
 
 	switch (adev->ip_versions[GC_HWIP]) {
+	case IP_VERSION(9, 0, 1):
+	case IP_VERSION(9, 2, 1):
+	case IP_VERSION(9, 4, 0):
+	case IP_VERSION(9, 4, 1):
+	case IP_VERSION(9, 4, 2):
+		adev->family = AMDGPU_FAMILY_AI;
+		break;
+	case IP_VERSION(9, 1, 0):
+	case IP_VERSION(9, 2, 2):
+	case IP_VERSION(9, 3, 0):
+		adev->family = AMDGPU_FAMILY_RV;
+		break;
 	case IP_VERSION(10, 1, 10):
 	case IP_VERSION(10, 1, 1):
 	case IP_VERSION(10, 1, 2):
@@ -543,6 +707,23 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 
 	/* set NBIO version */
 	switch (adev->ip_versions[NBIO_HWIP]) {
+	case IP_VERSION(6, 1, 0):
+	case IP_VERSION(6, 2, 0):
+		adev->nbio.funcs = &nbio_v6_1_funcs;
+		adev->nbio.hdp_flush_reg = &nbio_v6_1_hdp_flush_reg;
+		break;
+	case IP_VERSION(7, 0, 0):
+	case IP_VERSION(7, 0, 1):
+	case IP_VERSION(2, 5, 0):
+		adev->nbio.funcs = &nbio_v7_0_funcs;
+		adev->nbio.hdp_flush_reg = &nbio_v7_0_hdp_flush_reg;
+		break;
+	case IP_VERSION(7, 4, 0):
+	case IP_VERSION(7, 4, 1):
+	case IP_VERSION(7, 4, 4):
+		adev->nbio.funcs = &nbio_v7_4_funcs;
+		adev->nbio.hdp_flush_reg = &nbio_v7_4_hdp_flush_reg;
+		break;
 	case IP_VERSION(7, 2, 0):
 	case IP_VERSION(7, 2, 1):
 	case IP_VERSION(7, 5, 0):
@@ -565,6 +746,15 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	}
 
 	switch (adev->ip_versions[HDP_HWIP]) {
+	case IP_VERSION(4, 0, 0):
+	case IP_VERSION(4, 0, 1):
+	case IP_VERSION(4, 1, 0):
+	case IP_VERSION(4, 1, 1):
+	case IP_VERSION(4, 2, 0):
+	case IP_VERSION(4, 2, 1):
+	case IP_VERSION(4, 4, 0):
+		adev->hdp.funcs = &hdp_v4_0_funcs;
+		break;
 	case IP_VERSION(5, 0, 0):
 	case IP_VERSION(5, 0, 1):
 	case IP_VERSION(5, 0, 2):
@@ -577,8 +767,34 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		break;
 	}
 
+	switch (adev->ip_versions[DF_HWIP]) {
+	case IP_VERSION(3, 6, 0):
+	case IP_VERSION(3, 6, 1):
+	case IP_VERSION(3, 6, 2):
+		adev->df.funcs = &df_v3_6_funcs;
+		break;
+	case IP_VERSION(2, 1, 0):
+	case IP_VERSION(2, 1, 1):
+	case IP_VERSION(2, 5, 0):
+	case IP_VERSION(3, 5, 1):
+	case IP_VERSION(3, 5, 2):
+		adev->df.funcs = &df_v1_7_funcs;
+		break;
+	default:
+		break;
+	}
+
 	switch (adev->ip_versions[SMUIO_HWIP]) {
+	case IP_VERSION(9, 0, 0):
+	case IP_VERSION(9, 0, 1):
+	case IP_VERSION(10, 0, 0):
+	case IP_VERSION(10, 0, 1):
+	case IP_VERSION(10, 0, 2):
+		adev->smuio.funcs = &smuio_v9_0_funcs;
+		break;
 	case IP_VERSION(11, 0, 0):
+	case IP_VERSION(11, 0, 2):
+	case IP_VERSION(11, 0, 3):
 	case IP_VERSION(11, 0, 4):
 	case IP_VERSION(11, 0, 7):
 	case IP_VERSION(11, 0, 8):
@@ -591,12 +807,25 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(13, 0, 1):
 		adev->smuio.funcs = &smuio_v11_0_6_funcs;
 		break;
+	case IP_VERSION(13, 0, 2):
+		adev->smuio.funcs = &smuio_v13_0_funcs;
+		break;
 	default:
 		break;
 	}
 
 	/* what IP to use for this? */
 	switch (adev->ip_versions[GC_HWIP]) {
+	case IP_VERSION(9, 0, 1):
+	case IP_VERSION(9, 1, 0):
+	case IP_VERSION(9, 2, 1):
+	case IP_VERSION(9, 2, 2):
+	case IP_VERSION(9, 3, 0):
+	case IP_VERSION(9, 4, 0):
+	case IP_VERSION(9, 4, 1):
+	case IP_VERSION(9, 4, 2):
+		amdgpu_device_ip_block_add(adev, &vega10_common_ip_block);
+		break;
 	case IP_VERSION(10, 1, 10):
 	case IP_VERSION(10, 1, 1):
 	case IP_VERSION(10, 1, 2):
@@ -615,6 +844,16 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 
 	/* use GC or MMHUB IP version */
 	switch (adev->ip_versions[GC_HWIP]) {
+	case IP_VERSION(9, 0, 1):
+	case IP_VERSION(9, 1, 0):
+	case IP_VERSION(9, 2, 1):
+	case IP_VERSION(9, 2, 2):
+	case IP_VERSION(9, 3, 0):
+	case IP_VERSION(9, 4, 0):
+	case IP_VERSION(9, 4, 1):
+	case IP_VERSION(9, 4, 2):
+		amdgpu_device_ip_block_add(adev, &gmc_v9_0_ip_block);
+		break;
 	case IP_VERSION(10, 1, 10):
 	case IP_VERSION(10, 1, 1):
 	case IP_VERSION(10, 1, 2):
@@ -632,6 +871,18 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	}
 
 	switch (adev->ip_versions[OSSSYS_HWIP]) {
+	case IP_VERSION(4, 0, 0):
+	case IP_VERSION(4, 0, 1):
+	case IP_VERSION(4, 1, 0):
+	case IP_VERSION(4, 1, 1):
+	case IP_VERSION(4, 3, 0):
+		amdgpu_device_ip_block_add(adev, &vega10_ih_ip_block);
+		break;
+	case IP_VERSION(4, 2, 0):
+	case IP_VERSION(4, 2, 1):
+	case IP_VERSION(4, 4, 0):
+		amdgpu_device_ip_block_add(adev, &vega20_ih_ip_block);
+		break;
 	case IP_VERSION(5, 0, 0):
 	case IP_VERSION(5, 0, 1):
 	case IP_VERSION(5, 0, 2):
@@ -646,7 +897,16 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 
 	if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP)) {
 		switch (adev->ip_versions[MP0_HWIP]) {
+		case IP_VERSION(9, 0, 0):
+			amdgpu_device_ip_block_add(adev, &psp_v3_1_ip_block);
+			break;
+		case IP_VERSION(10, 0, 0):
+		case IP_VERSION(10, 0, 1):
+			amdgpu_device_ip_block_add(adev, &psp_v10_0_ip_block);
+			break;
 		case IP_VERSION(11, 0, 0):
+		case IP_VERSION(11, 0, 2):
+		case IP_VERSION(11, 0, 4):
 		case IP_VERSION(11, 0, 5):
 		case IP_VERSION(11, 0, 9):
 		case IP_VERSION(11, 0, 7):
@@ -659,7 +919,12 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		case IP_VERSION(11, 0, 8):
 			amdgpu_device_ip_block_add(adev, &psp_v11_0_8_ip_block);
 			break;
+		case IP_VERSION(11, 0, 3):
+		case IP_VERSION(12, 0, 1):
+			amdgpu_device_ip_block_add(adev, &psp_v12_0_ip_block);
+			break;
 		case IP_VERSION(13, 0, 1):
+		case IP_VERSION(13, 0, 2):
 		case IP_VERSION(13, 0, 3):
 			amdgpu_device_ip_block_add(adev, &psp_v13_0_ip_block);
 			break;
@@ -670,6 +935,15 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 
 	if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP)) {
 		switch (adev->ip_versions[MP1_HWIP]) {
+		case IP_VERSION(9, 0, 0):
+		case IP_VERSION(10, 0, 0):
+		case IP_VERSION(10, 0, 1):
+		case IP_VERSION(11, 0, 2):
+			if (adev->asic_type == CHIP_ARCTURUS)
+				amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
+			else
+				amdgpu_device_ip_block_add(adev, &pp_smu_ip_block);
+			break;
 		case IP_VERSION(11, 0, 0):
 		case IP_VERSION(11, 0, 9):
 		case IP_VERSION(11, 0, 7):
@@ -680,7 +954,12 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		case IP_VERSION(11, 5, 0):
 			amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
 			break;
+		case IP_VERSION(12, 0, 0):
+		case IP_VERSION(12, 0, 1):
+			amdgpu_device_ip_block_add(adev, &smu_v12_0_ip_block);
+			break;
 		case IP_VERSION(13, 0, 1):
+		case IP_VERSION(13, 0, 2):
 		case IP_VERSION(13, 0, 3):
 			amdgpu_device_ip_block_add(adev, &smu_v13_0_ip_block);
 			break;
@@ -692,10 +971,13 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	if (adev->enable_virtual_display || amdgpu_sriov_vf(adev)) {
 		amdgpu_device_ip_block_add(adev, &amdgpu_vkms_ip_block);
 #if defined(CONFIG_DRM_AMD_DC)
-	} else {
+	} else if (adev->ip_versions[DCE_HWIP]) {
 		switch (adev->ip_versions[DCE_HWIP]) {
+		case IP_VERSION(1, 0, 0):
+		case IP_VERSION(1, 0, 1):
 		case IP_VERSION(2, 0, 2):
 		case IP_VERSION(2, 0, 0):
+		case IP_VERSION(2, 1, 0):
 		case IP_VERSION(3, 0, 0):
 		case IP_VERSION(3, 0, 2):
 		case IP_VERSION(3, 0, 3):
@@ -709,10 +991,29 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		default:
 			return -EINVAL;
 		}
-
+	} else if (adev->ip_versions[DCI_HWIP]) {
+		switch (adev->ip_versions[DCI_HWIP]) {
+		case IP_VERSION(12, 0, 0):
+		case IP_VERSION(12, 0, 1):
+		case IP_VERSION(12, 1, 0):
+			amdgpu_device_ip_block_add(adev, &dm_ip_block);
+			break;
+		default:
+			return -EINVAL;
+		}
 	}
 #endif
 	switch (adev->ip_versions[GC_HWIP]) {
+	case IP_VERSION(9, 0, 1):
+	case IP_VERSION(9, 1, 0):
+	case IP_VERSION(9, 2, 1):
+	case IP_VERSION(9, 2, 2):
+	case IP_VERSION(9, 3, 0):
+	case IP_VERSION(9, 4, 0):
+	case IP_VERSION(9, 4, 1):
+	case IP_VERSION(9, 4, 2):
+		amdgpu_device_ip_block_add(adev, &gfx_v9_0_ip_block);
+		break;
 	case IP_VERSION(10, 1, 10):
 	case IP_VERSION(10, 1, 2):
 	case IP_VERSION(10, 1, 1):
@@ -730,6 +1031,16 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	}
 
 	switch (adev->ip_versions[SDMA0_HWIP]) {
+	case IP_VERSION(4, 0, 0):
+	case IP_VERSION(4, 0, 1):
+	case IP_VERSION(4, 1, 0):
+	case IP_VERSION(4, 1, 1):
+	case IP_VERSION(4, 1, 2):
+	case IP_VERSION(4, 2, 0):
+	case IP_VERSION(4, 2, 2):
+	case IP_VERSION(4, 4, 0):
+		amdgpu_device_ip_block_add(adev, &sdma_v4_0_ip_block);
+		break;
 	case IP_VERSION(5, 0, 0):
 	case IP_VERSION(5, 0, 1):
 	case IP_VERSION(5, 0, 2):
@@ -750,6 +1061,15 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
 		switch (adev->ip_versions[MP1_HWIP]) {
+		case IP_VERSION(9, 0, 0):
+		case IP_VERSION(10, 0, 0):
+		case IP_VERSION(10, 0, 1):
+		case IP_VERSION(11, 0, 2):
+			if (adev->asic_type == CHIP_ARCTURUS)
+				amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
+			else
+				amdgpu_device_ip_block_add(adev, &pp_smu_ip_block);
+			break;
 		case IP_VERSION(11, 0, 0):
 		case IP_VERSION(11, 0, 9):
 		case IP_VERSION(11, 0, 7):
@@ -760,7 +1080,12 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		case IP_VERSION(11, 5, 0):
 			amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
 			break;
+		case IP_VERSION(12, 0, 0):
+		case IP_VERSION(12, 0, 1):
+			amdgpu_device_ip_block_add(adev, &smu_v12_0_ip_block);
+			break;
 		case IP_VERSION(13, 0, 1):
+		case IP_VERSION(13, 0, 2):
 		case IP_VERSION(13, 0, 3):
 			amdgpu_device_ip_block_add(adev, &smu_v13_0_ip_block);
 			break;
@@ -769,26 +1094,58 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		}
 	}
 
-	switch (adev->ip_versions[UVD_HWIP]) {
-	case IP_VERSION(2, 0, 0):
-	case IP_VERSION(2, 0, 2):
-		amdgpu_device_ip_block_add(adev, &vcn_v2_0_ip_block);
-		amdgpu_device_ip_block_add(adev, &jpeg_v2_0_ip_block);
-		break;
-	case IP_VERSION(2, 0, 3):
-		break;
-	case IP_VERSION(3, 0, 0):
-	case IP_VERSION(3, 0, 16):
-	case IP_VERSION(3, 1, 1):
-	case IP_VERSION(3, 0, 2):
-		amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
-		amdgpu_device_ip_block_add(adev, &jpeg_v3_0_ip_block);
-		break;
-	case IP_VERSION(3, 0, 33):
-		amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
-		break;
-	default:
-		return -EINVAL;
+	if (adev->ip_versions[VCE_HWIP]) {
+		switch (adev->ip_versions[UVD_HWIP]) {
+		case IP_VERSION(7, 0, 0):
+		case IP_VERSION(7, 2, 0):
+			amdgpu_device_ip_block_add(adev, &uvd_v7_0_ip_block);
+			break;
+		default:
+			return -EINVAL;
+		}
+		switch (adev->ip_versions[VCE_HWIP]) {
+		case IP_VERSION(4, 0, 0):
+		case IP_VERSION(4, 1, 0):
+			amdgpu_device_ip_block_add(adev, &vce_v4_0_ip_block);
+			break;
+		default:
+			return -EINVAL;
+		}
+	} else {
+		switch (adev->ip_versions[UVD_HWIP]) {
+		case IP_VERSION(1, 0, 0):
+		case IP_VERSION(1, 0, 1):
+			amdgpu_device_ip_block_add(adev, &vcn_v1_0_ip_block);
+			break;
+		case IP_VERSION(2, 0, 0):
+		case IP_VERSION(2, 0, 2):
+		case IP_VERSION(2, 2, 0):
+			amdgpu_device_ip_block_add(adev, &vcn_v2_0_ip_block);
+			amdgpu_device_ip_block_add(adev, &jpeg_v2_0_ip_block);
+			break;
+		case IP_VERSION(2, 0, 3):
+			break;
+		case IP_VERSION(2, 5, 0):
+			amdgpu_device_ip_block_add(adev, &vcn_v2_5_ip_block);
+			amdgpu_device_ip_block_add(adev, &jpeg_v2_5_ip_block);
+			break;
+		case IP_VERSION(2, 6, 0):
+			amdgpu_device_ip_block_add(adev, &vcn_v2_6_ip_block);
+			amdgpu_device_ip_block_add(adev, &jpeg_v2_6_ip_block);
+			break;
+		case IP_VERSION(3, 0, 0):
+		case IP_VERSION(3, 0, 16):
+		case IP_VERSION(3, 1, 1):
+		case IP_VERSION(3, 0, 2):
+			amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
+			amdgpu_device_ip_block_add(adev, &jpeg_v3_0_ip_block);
+			break;
+		case IP_VERSION(3, 0, 33):
+			amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
+			break;
+		default:
+			return -EINVAL;
+		}
 	}
 
 	if (adev->enable_mes) {
-- 
2.31.1

