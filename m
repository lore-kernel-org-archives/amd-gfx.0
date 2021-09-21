Return-Path: <SRS0=vd7l=OL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 397DEC433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BED161186
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0BED161186
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06F8E6EAB3;
	Tue, 21 Sep 2021 18:08:13 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2057.outbound.protection.outlook.com [40.107.212.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CE2E6EA87
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Sep 2021 18:07:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mz2ZrceLd7sfpHOAnRCGUxfGa6o0UDFjT8ciSzaT/7Et5/Z8NMZcSdWk+1Ijjj4mtpHBIDWa+WOpzm+Li61zRKwBvxu8NlQAvsYJioX37XZ3jF2sGh6xVLJWF+Li3yDFsuABcKe/4bhlQx0GycgvTXBLj3s2dYTHAxjX7mnSdmOYBQvLkK909dJhb/39G42ZfTsafmkBxgJgWEP4Kpyv+yfz5PX6wsihwGaQdpr3JDJWCPZ5xi8plbA4nN+0RW1l7xKVuatOMCIMtftE+5kMicrN4WY+47PTnewHe6AfypW6/4lIXHU03dz3QRjLtnZEaD/6a3lg2z0Ppuw4KKz5GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=pgxOep5BiMw9nkvKgDeJQUEaBkdFCt0CtQPBwfmah9M=;
 b=ddhjlsg1a4KGPBGOlH0bep3ubB/dcDT78cSTY/eZ9yUn0QIK7k4qpnVHIHQKNSYGdOOiY/OmJmthblT1c/UIFOnRD/Qg9mTQxUWWo6WbP3qFOAIwHfw+VEUJLbFbuQ+gYrny+TrGOSmhIqU8MZqPIhFnlYBLf498YQ0KdWV4fMoIE6b5kx4LnVGSy3HWOgtTdcPQbbXqQotz8t+/Du6CW+tYUFBKLw3IDVLiNxS9MLvGusl+Ywv79UXC6O3v1nf3jQfG1UKIDQ8A/R9WY9w4dKdpZkAw7Aii+DZAeprcDjG0OmA2NibBlySCm4RFZg+pGpxSoUJ21Ryg1Q0jvZGjLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pgxOep5BiMw9nkvKgDeJQUEaBkdFCt0CtQPBwfmah9M=;
 b=pFihURkvpbiGFV+EtGN7IP4nmfS4c08XmHdtIVArzQPEE82W5Hp0MapMA/KDDvFBGQ5ZRDV8C4YgsFrc9iUq/7XsEPDkFkwxWd2YyZsZWZb5LzTVdMrpbRBzASd5bGW58XGTuVh6hdRNC88WuSZeN+s7LRh0B8HHDXXtOb+RJEU=
Received: from DM6PR03CA0102.namprd03.prod.outlook.com (2603:10b6:5:333::35)
 by MN2PR12MB4144.namprd12.prod.outlook.com (2603:10b6:208:15f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Tue, 21 Sep
 2021 18:07:55 +0000
Received: from DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::18) by DM6PR03CA0102.outlook.office365.com
 (2603:10b6:5:333::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Tue, 21 Sep 2021 18:07:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT042.mail.protection.outlook.com (10.13.173.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Tue, 21 Sep 2021 18:07:55 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 21 Sep
 2021 13:07:54 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 33/66] drm/amdgpu: add initial IP discovery support for vega
 based parts
Date: Tue, 21 Sep 2021 14:06:52 -0400
Message-ID: <20210921180725.1985552-34-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8b575828-694f-4017-b045-08d97d2abcc5
X-MS-TrafficTypeDiagnostic: MN2PR12MB4144:
X-Microsoft-Antispam-PRVS: <MN2PR12MB41446B0A7FD27DCD8DA85B52F7A19@MN2PR12MB4144.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VC85x1ZaJDpL+ltP+Uk9/v3uSxH6MQ7Akb+04mxRf/x7D5X7bkZI+IiOw7A5ll0xUwyHC7lTMTlVVSQ1QDd2CSSCgd81Qo4HVj1lWZnf+rk1ooHKNu4/7cKuLxgXKczqLaFZi82Yuy8tEpGiNzhckO+2UEgTU9MoCYAXHEflj3ozvDz/YG6FqjNAJdfZ1jYu8ohLrc2GNuEfm8jbhO+vuo0Z+nrM9xGvlqInQuL1QI3Oji4KIMorMPqAkMIw8422WXd7A4QEYzErqQuDWTT06HSoUFrKHxDPNppe/XYDKN0vz4qZapWB2lOchdcxciXx589eAlsqybWggY65yCn6+dVQxB/PYAvn0ROr+d/fRi6tsmhVeWhighMS4UF/RTacEgB4ZcJNrBoW2SxniyshuPUrLQ1Vrp4RkayhjenkAw9y8w39QIQVIB54qHE51tvlR1PI3rswjqpbFzHQFCwS+906QQ2sCdfO6hr79sIeN/NkDmViKHkFC6OKMc+DXCRRv1hhVL3tKF+RyqSTy3fmLA0qC8mU60j9KcXs3pdrZumK9NkPvHgohakVQ9ZUMOdGUFn+SBrQWyRcMjxnJ8oUEkLNV5iK4o2O70i6Awlxe0hhgH3B1m9N2ZDN1YYACtHoruNQpWqMs7/pxlMS6rVWzJ0cgR0Lz/rwyjwi0tg4axd9/81huyNLq4IlXGuZhmRmEf/2VF9MkaFHXn+oe1bly1+vXPlqY1b23UjDc6xF5Xo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(186003)(47076005)(16526019)(70586007)(81166007)(26005)(83380400001)(36860700001)(86362001)(7696005)(82310400003)(426003)(1076003)(2616005)(70206006)(30864003)(508600001)(2906002)(6916009)(356005)(4326008)(8936002)(8676002)(36756003)(5660300002)(336012)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 18:07:55.8027 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b575828-694f-4017-b045-08d97d2abcc5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4144
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

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 417 ++++++++++++++++--
 1 file changed, 387 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 6a993043badc..e3b4578872f1 100644
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
@@ -485,23 +506,166 @@ int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev)
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
@@ -527,6 +691,23 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 
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
@@ -549,6 +730,15 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
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
@@ -561,8 +751,34 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
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
@@ -575,12 +791,25 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
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
@@ -599,6 +828,16 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 
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
@@ -616,6 +855,18 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
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
@@ -630,7 +881,16 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 
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
@@ -643,7 +903,12 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
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
@@ -654,6 +919,15 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 
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
@@ -664,7 +938,12 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
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
@@ -676,10 +955,13 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
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
@@ -693,10 +975,29 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
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
@@ -714,6 +1015,16 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
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
@@ -734,6 +1045,15 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 
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
@@ -744,7 +1064,12 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
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
@@ -753,26 +1078,58 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
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

