Return-Path: <SRS0=WCud=OO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D3DC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 08:37:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 615DA61100
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 08:37:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 615DA61100
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E10906E1F4;
	Fri, 24 Sep 2021 08:37:41 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B63776E1CD
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Sep 2021 08:37:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n2wKRIY92Zlkt3mRjvo6Xmlhn/j47appDofk8Pi9Hr+WwNW7Twd4A/PvrASe/WMDvBO8sMtMfwUr1bv6Wy/+FEP6xh8Zv52zFGrbDnBtcKXrgkjHs55VbsogjQU5RTUPOqSuov8fMUh5DmkwlzjBzqBvEOJi91TbDfwLbmIQfNAfRfiCduApN14IdNV0oXEpKOmY0PK6mcwjdrsBg3wNn2snEShNDUDd2Bnhmfr5qyBd43BajHOSXGBXA/jOjcQCERgWS0nC8+3y7nipzk8FqwcFcWRzCyknIIkwawqr9aaAv36WmxhuEgpEDcuyCp/6oKoLSzPioEGnUfJ04NWEJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=DwUxnkQtu1ylR/YHrG9AXYgwW2i3htJwmas+X59GDQk=;
 b=SunS2wprxIlMZnVcWyfJ7sp2SHZMdO5pMxPXhnB60T3nJg5XESlVgeTqYfKYpKqnocIzuYGEWay9VVpajnhRb0hEfajzbNc/kikU3fguSt3Sdxol35DOKn5pj6dOeo64eIWC195K1cpWBjiBp+OArtSfX6oj3D1mwJDFAwNz7STWcKOVfk/Qy7exojxwdllPH6SjSTiUuqaqsa7wB67Hht9Em9/yDU7w4reKPqvXsRp4DrFiOkZIZCcO9FIHICHR0n9pBmu1OCF2nUjNlwyQi/ur74jZZ6y4Y2TDMlQ0Uk/ESFu9f+7HsDOYZrVKYHuB02PdAfaU0fdRYyjso0WYNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DwUxnkQtu1ylR/YHrG9AXYgwW2i3htJwmas+X59GDQk=;
 b=pCI/uKUf6QdOjp2fIQ8LoqOCS0dqH5xqupF5nMtbC6B/oELAuszqQii4e7LoPyoyVmDNtVzcPY+o6luphb2G0i5pbaRN1TwewFCi02xUi31RsV3kABRuLnoxU85IV3ILW219xK6qLs0/UjndDSj+lQd26r+cry3ImtuCznPDFto=
Received: from BN9PR03CA0133.namprd03.prod.outlook.com (2603:10b6:408:fe::18)
 by BL1PR12MB5141.namprd12.prod.outlook.com (2603:10b6:208:309::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Fri, 24 Sep
 2021 08:37:39 +0000
Received: from BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::43) by BN9PR03CA0133.outlook.office365.com
 (2603:10b6:408:fe::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14 via Frontend
 Transport; Fri, 24 Sep 2021 08:37:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT064.mail.protection.outlook.com (10.13.176.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Fri, 24 Sep 2021 08:37:38 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 24 Sep
 2021 03:37:35 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <felix.kuehling@amd.com>, <mukul.joshi@amd.com>, <stanley.yang@amd.com>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH] amd/amdkfd: add ras page retirement handling for sq/sdma (v2)
Date: Fri, 24 Sep 2021 16:37:25 +0800
Message-ID: <20210924083725.17318-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d6cb640-729d-477f-5776-08d97f3690fc
X-MS-TrafficTypeDiagnostic: BL1PR12MB5141:
X-Microsoft-Antispam-PRVS: <BL1PR12MB51417C446B81A3BC41219460B0A49@BL1PR12MB5141.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QiWzB64yem4BUxNfRbqJlp22T0VkWWyYivFRORmHKUmT3f4KbRNukfj1Ybp+DnVfFHy7eQ5y8VJqJEdVfBG8Vybk7kUQgYykC06J0Db3lx0p9c1DOfr0UFvVpeRXuqnKStl4wA0WVqaw018w3CBOGiNAlbIZC4NK/tZ94EEbbm4EAGnl8BuPoQE5yPeT+unZlYqAPUAUuu6IIkPeXtUvPyIrGk1P6phPgMLXqGneQzAbmPBQQkrM3fK8g4KVhabzeFm9DtBTFy/l0KMSF8h7HfB9l3qQiYsqJn6pW0I+y+JzoNCzRHw3Mzn/c35kTKKnTwww1ZC4clpXnoakpBwGoLmeYD3I+0QqskdBSqacHu6CMPqKtBSb+2+PlEYWYOLmDFkcbHILdhYE484+qcj8MNxFXignqcicv0IL2JNaA+Xes7pATzMSXd3hwS1NavX+Td3N5dQFEBoGeKPQzZobJne+H31SpQbOxzc0eGy5IDI7CsSeVdvtrgRK7kA27CHJU5ZW9wVu8BoKcMgIfJyt/zQWCYW7FZDbTpAEHPN6Ca3EAA1IPyekLkBhJ6eZIQl5ehzHmDVYvVIhH7Aj9gAOUQCc6Y40/AyTjl+NscxfrSsr8yfRG7wGmDDEcOnJceb+KPjRNAhh09PAX29XUuCTr9kzDPU02o1XGvz+O+w/wX89Kk8ChV14OxPysYpVUrzmXePKZSd1Eq/F4FYgFUgp2PlNfclUMmd93O7Od4f9jaw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(6666004)(83380400001)(82310400003)(2616005)(2906002)(26005)(356005)(16526019)(316002)(110136005)(186003)(8936002)(81166007)(8676002)(426003)(336012)(70586007)(86362001)(70206006)(36756003)(508600001)(7696005)(47076005)(5660300002)(1076003)(4326008)(6636002)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2021 08:37:38.6624 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d6cb640-729d-477f-5776-08d97f3690fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5141
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

In ras poison mode, page retirement will be handled by the irq handler of the
module which consumes corrupted data.

v2: rename ras_process_cb to ras_poison_consumption_handler.
    move the handler's implementation from ASIC specific file to common
file.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c      | 14 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h      |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c |  4 ++--
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 1d41c2c00623..7bc4248a8d49 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -31,6 +31,8 @@
 #include <linux/dma-buf.h>
 #include "amdgpu_xgmi.h"
 #include <uapi/linux/kfd_ioctl.h>
+#include "amdgpu_ras.h"
+#include "amdgpu_umc.h"
 
 /* Total memory size in system memory and all GPU VRAM. Used to
  * estimate worst case amount of memory to reserve for page tables
@@ -780,3 +782,15 @@ bool amdgpu_amdkfd_have_atomics_support(struct kgd_dev *kgd)
 
 	return adev->have_atomics_support;
 }
+
+int amdgpu_amdkfd_ras_poison_consumption_handler(struct kgd_dev *kgd)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
+	struct ras_err_data err_data = {0, 0, 0, NULL};
+
+	/* CPU MCA will handle it if connected_to_cpu is 1 */
+	if (!adev->gmc.xgmi.connected_to_cpu)
+		return amdgpu_umc_process_ras_data_cb(adev, &err_data, NULL);
+	else
+		return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 3bc52b2c604f..d118e1dc273d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -290,6 +290,7 @@ int amdgpu_amdkfd_gpuvm_import_dmabuf(struct kgd_dev *kgd,
 				      uint64_t *mmap_offset);
 int amdgpu_amdkfd_get_tile_config(struct kgd_dev *kgd,
 				struct tile_config *config);
+int amdgpu_amdkfd_ras_poison_consumption_handler(struct kgd_dev *kgd);
 #if IS_ENABLED(CONFIG_HSA_AMD)
 void amdgpu_amdkfd_gpuvm_init_mem_limits(void);
 void amdgpu_amdkfd_gpuvm_destroy_cb(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index 12d91e53556c..543e7ea75593 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -231,7 +231,7 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,
 				if (sq_intr_err != SQ_INTERRUPT_ERROR_TYPE_ILLEGAL_INST &&
 					sq_intr_err != SQ_INTERRUPT_ERROR_TYPE_MEMVIOL) {
 					kfd_signal_poison_consumed_event(dev, pasid);
-					amdgpu_amdkfd_gpu_reset(dev->kgd);
+					amdgpu_amdkfd_ras_poison_consumption_handler(dev->kgd);
 					return;
 				}
 				break;
@@ -253,7 +253,7 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,
 			kfd_signal_event_interrupt(pasid, context_id0 & 0xfffffff, 28);
 		} else if (source_id == SOC15_INTSRC_SDMA_ECC) {
 			kfd_signal_poison_consumed_event(dev, pasid);
-			amdgpu_amdkfd_gpu_reset(dev->kgd);
+			amdgpu_amdkfd_ras_poison_consumption_handler(dev->kgd);
 			return;
 		}
 	} else if (client_id == SOC15_IH_CLIENTID_VMC ||
-- 
2.17.1

