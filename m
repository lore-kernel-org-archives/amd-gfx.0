Return-Path: <SRS0=OLwD=MI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6024FC12002
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jul 2021 16:43:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 208F0613D4
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jul 2021 16:43:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 208F0613D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8FF96E9C4;
	Fri, 16 Jul 2021 16:43:29 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A7A16E9C5
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jul 2021 16:43:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vg01S2H0bCqVqEZXordEUoCOuVdrAUIEy6r924yrXI9Oo3wSNqefSKkDylGI3Ffflyyg/hX3LSGleQvpKXIqRuYlDFkBml+AR6yFy8LzRHyqWwEzTKX8IvcRipW0CW36MBBAer3+1NiXUvLcx0SQrLi7+SF0NJlWMhAOYfnYhV3u5v+KlOFSWPsFzj61hLvpcIY2SWJa+bmnWv2pydL/mM9y/H02Bhm8SUiCwAqZUUkKq9QFamwXnItYWjEAPagtc2sFGDy7sB1/Cy2VPiXWlXnXKgC1w2PWSLBiq+v89SgzI6GUmjgVWOzEYenzf9ojx0IF9hw+L/yunqx3tq4q4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sjkK27fGjrWO2YYHTx97noNpUS6sJzkJk/KFz/yUCBQ=;
 b=Pn44YpWLJ+l55sVhHNyO72AGWDfVtJtmRmiSV7qit6w++6YYIiO/aFhhcOiTtPYK1tIUUYbRkaoVpDPdnNfPNZoHyVbD8IN3NzJXSkEZ7WQ7mfJTTv0py+RK73UjPFZ47LMKagX9yBy26vsfKjO7NZxmqXhbV1zV6AmOaahvl84+eKyoBKArGhI369/7wFmDVr9BekwK4mbIvL7f4pJE1nfil4p7u3vazRChuF8/O2y6VDARXh42Edfc98IEABqFXzTG6uDz2ITyZ4cyqn63ZereYn7n4qxhHM90mCEVE3w3rzSCiMkAgIQEK8ju0hQcb6Nu48V358877ujlTyUukw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sjkK27fGjrWO2YYHTx97noNpUS6sJzkJk/KFz/yUCBQ=;
 b=NrO7i9DEynea1FdEaHbA8PPYoDL/IaCwND1qwP+eGYVIVUwwAR1GMD+fIg0t4IgdSAyc3cp9UwjeHp6KlfUOXs3jHTTZJwO3QYnL0mQqnBPWU6tvpKrMVL4ebik9HvXAzzPwynaw/AO7qqfsyvw7rYVykZWhK3uTk19WVCF5s6Y=
Received: from DM5PR07CA0136.namprd07.prod.outlook.com (2603:10b6:3:13e::26)
 by MN2PR12MB4813.namprd12.prod.outlook.com (2603:10b6:208:1bb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22; Fri, 16 Jul
 2021 16:43:26 +0000
Received: from DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:13e:cafe::6d) by DM5PR07CA0136.outlook.office365.com
 (2603:10b6:3:13e::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Fri, 16 Jul 2021 16:43:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT018.mail.protection.outlook.com (10.13.172.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Fri, 16 Jul 2021 16:43:26 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 16 Jul
 2021 11:43:24 -0500
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdkfd: report pcie bandwidth to the kfd
Date: Fri, 16 Jul 2021 12:43:12 -0400
Message-ID: <20210716164312.896939-3-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210716164312.896939-1-jonathan.kim@amd.com>
References: <20210716164312.896939-1-jonathan.kim@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 751c5d65-4d21-41b8-6b5d-08d94878d577
X-MS-TrafficTypeDiagnostic: MN2PR12MB4813:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4813F1E34141AE05C5D9E72785119@MN2PR12MB4813.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6/dJSN1HzNTawB5JYnptdEdgO+R2A1/+dSe76SdjkQE90PyW/zjd+MnR+tmg44e251LftNGvGH7MiRG6iPqhlPJTT5JX4reRoj7TYPpWrwH/QnF3UqnXz6uCd3nM+kPH+f09Y6dBg+1O8PMjOq38N249rQrlAFv45fbrYANiFlKY2OqiN0lyj+N9pgVfm+RiG+DXeg39/8ILeadxAoViMoNs1UApiYFTp+d3VES9Qit0KplrRdX4T5LOTfZYOrnriNMvowdcljV9l8Zf/Q/WNu8K8uKdFSwIAfc2hGxI6CDxTryHJHwFF/FI/yF9trQrJWumZ/1e+xrWPhzMql74CQJNEUB6CMcnfPsBN+75TF+WGfPRKZTDDxRjFZRyqneXdbzEk3U0gfxY6IgBiBQuNBhoP5HH03gcLdgAtfgVWUmORpGJS7i6JU+wQmsAO7vDjNOJv1QIPpxxzd94+bXkw4Oq4VenIhD92BVd1SpW61+Z9C295KFx/4tUE37DoFDk4JhaHt/XASsmAflMCexXHf6zTkDtJqe6USg/aRBTe910hjOZd20B03fvKPDc1Wynu3lIaziPL7rnFAcZd9VlvmKsV9aho83PHeQi62qzgtLrRbG3MRXDzdKwNlTx+kW59mVUjjc/LVivWq1NpPYvjwqPhsIGsePf0OwAMhgdkhA0Af3CMjRJuXfSu2rJUuRkgaR7zFRGvmZgVUqesL7+jloY2lLECBEB3mfeeyFJRyg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(136003)(396003)(46966006)(36840700001)(26005)(5660300002)(82310400003)(7696005)(336012)(426003)(6916009)(4326008)(44832011)(2616005)(8676002)(8936002)(316002)(82740400003)(36756003)(478600001)(1076003)(54906003)(81166007)(6666004)(36860700001)(86362001)(70206006)(2906002)(83380400001)(16526019)(47076005)(356005)(186003)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 16:43:26.3205 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 751c5d65-4d21-41b8-6b5d-08d94878d577
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4813
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
Cc: Felix.Kuehling@amd.com, Jonathan Kim <jonathan.kim@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Similar to xGMI reporting the min/max bandwidth between direct peers, PCIe
will report the min/max bandwidth to the KFD.

v2: change to bandwidth

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 61 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c      |  4 ++
 3 files changed, 66 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 3978578a1c49..b7db52f1a9d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -21,6 +21,7 @@
  */
 
 #include "amdgpu_amdkfd.h"
+#include "amd_pcie.h"
 #include "amd_shared.h"
 
 #include "amdgpu.h"
@@ -576,6 +577,66 @@ int amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(struct kgd_dev *dst, struct kgd_dev
 	return (num_links * 16 * 25000)/BITS_PER_BYTE;
 }
 
+int amdgpu_amdkfd_get_pcie_bandwidth_mbytes(struct kgd_dev *dev, bool is_min)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)dev;
+	int num_lanes_shift = is_min ? ffs(adev->pm.pcie_mlw_mask >>
+					CAIL_PCIE_LINK_WIDTH_SUPPORT_SHIFT) - 1 :
+				fls(adev->pm.pcie_mlw_mask >>
+					CAIL_PCIE_LINK_WIDTH_SUPPORT_SHIFT) - 1;
+	int gen_speed_shift = is_min ? ffs(adev->pm.pcie_gen_mask >>
+					CAIL_PCIE_LINK_SPEED_SUPPORT_SHIFT) - 1 :
+				fls(adev->pm.pcie_gen_mask >>
+					CAIL_PCIE_LINK_SPEED_SUPPORT_SHIFT) - 1;
+	uint32_t num_lanes_mask = (1UL << num_lanes_shift) << CAIL_PCIE_LINK_WIDTH_SUPPORT_SHIFT;
+	uint32_t gen_speed_mask = (1UL << gen_speed_shift) << CAIL_PCIE_LINK_SPEED_SUPPORT_SHIFT;
+	int num_lanes_factor = 0, gen_speed_mbits_factor = 0;
+
+	switch (num_lanes_mask) {
+	case CAIL_PCIE_LINK_WIDTH_SUPPORT_X1:
+		num_lanes_factor = 1;
+		break;
+	case CAIL_PCIE_LINK_WIDTH_SUPPORT_X2:
+		num_lanes_factor = 2;
+		break;
+	case CAIL_PCIE_LINK_WIDTH_SUPPORT_X4:
+		num_lanes_factor = 4;
+		break;
+	case CAIL_PCIE_LINK_WIDTH_SUPPORT_X8:
+		num_lanes_factor = 8;
+		break;
+	case CAIL_PCIE_LINK_WIDTH_SUPPORT_X12:
+		num_lanes_factor = 12;
+		break;
+	case CAIL_PCIE_LINK_WIDTH_SUPPORT_X16:
+		num_lanes_factor = 16;
+		break;
+	case CAIL_PCIE_LINK_WIDTH_SUPPORT_X32:
+		num_lanes_factor = 32;
+		break;
+	}
+
+	switch (gen_speed_mask) {
+	case CAIL_PCIE_LINK_SPEED_SUPPORT_GEN1:
+		gen_speed_mbits_factor = 2500;
+		break;
+	case CAIL_PCIE_LINK_SPEED_SUPPORT_GEN2:
+		gen_speed_mbits_factor = 5000;
+		break;
+	case CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3:
+		gen_speed_mbits_factor = 8000;
+		break;
+	case CAIL_PCIE_LINK_SPEED_SUPPORT_GEN4:
+		gen_speed_mbits_factor = 16000;
+		break;
+	case CAIL_PCIE_LINK_SPEED_SUPPORT_GEN5:
+		gen_speed_mbits_factor = 32000;
+		break;
+	}
+
+	return (num_lanes_factor * gen_speed_mbits_factor)/BITS_PER_BYTE;
+}
+
 uint64_t amdgpu_amdkfd_get_mmio_remap_phys_addr(struct kgd_dev *kgd)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index e12fccb2d2c4..5d73f3108d13 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -227,6 +227,7 @@ uint32_t amdgpu_amdkfd_get_asic_rev_id(struct kgd_dev *kgd);
 int amdgpu_amdkfd_get_noretry(struct kgd_dev *kgd);
 uint8_t amdgpu_amdkfd_get_xgmi_hops_count(struct kgd_dev *dst, struct kgd_dev *src);
 int amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(struct kgd_dev *dst, struct kgd_dev *src, bool is_min);
+int amdgpu_amdkfd_get_pcie_bandwidth_mbytes(struct kgd_dev *dev, bool is_min);
 
 /* Read user wptr from a specified user address space with page fault
  * disabled. The memory must be pinned and mapped to the hardware when
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 40ce6239c813..eada22b9ea69 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1998,6 +1998,10 @@ static int kfd_fill_gpu_direct_io_link_to_cpu(int *avail_size,
 		}
 	} else {
 		sub_type_hdr->io_interface_type = CRAT_IOLINK_TYPE_PCIEXPRESS;
+		sub_type_hdr->minimum_bandwidth_mbs =
+				amdgpu_amdkfd_get_pcie_bandwidth_mbytes(kdev->kgd, true);
+		sub_type_hdr->maximum_bandwidth_mbs =
+				amdgpu_amdkfd_get_pcie_bandwidth_mbytes(kdev->kgd, false);
 	}
 
 	sub_type_hdr->proximity_domain_from = proximity_domain;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
