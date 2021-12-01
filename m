Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E557C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Dec 2021 10:54:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AF216FA2A;
	Wed,  1 Dec 2021 10:53:59 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2062.outbound.protection.outlook.com [40.107.101.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F6B96FA28
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Dec 2021 10:53:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h59SVm6tRBqCOUINz0DIBbp4TzRIL7osTJbqvgW3aG0MOZdN4CX5GntpAkPXfvxVak9nfIb9zivcafldIvIZpAPWE0bYVN3L9g682nZ2zk3Z9fs/R+pN3TOQmDgI3ooNNrlPdw3tzJq3tMJXy1gLik1LQTwX52auEq+IngB5j00REEecWKW3T5VQYagoKcRD8H182m5nvGqFr/OWfFzQnK9Kzx9PjOJdslJqJAvHp1WlMHiehrBUVLc8sZhLAo8N8LJRj1N34g2mnqwlDglU3tbHWmgdlWfCqEFB7HSRiO9GAsFap6DWucb/uiGaB1yXn2US1ONAE6f0NzBhuhEPWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SUyhkNJhS49qUo9CNRXFmbfiIhSnlUnmb4K0YyIeG+c=;
 b=ezOJrnB4LWO53x0GrcD3BkgDQ3kgNBY+xNUk5w98slT2liMAs4EDVWnxtU1SrX0GhsQhqoBytpfFq6leWfdumEcWisKDPZldlWOSMHTNxtgAJZx+B9Bs6VHrK3KcBFZ4WHuQ30ryk9pyk/PdbXTK8ncimXO2cfLYsh/3HUSk1DraW2r0lQIgvEyu17+FDLNqWq0ngbuY/R7bYdd0yYjtY3AYRCbcHDP0UsXm+FE++Op/BN6LKtUb4xz7ybrO+ubTKIuMly6onrSGJu8hTrjqVUy9Aj/auV2KBusSH53S8NzQ/nWxYFv1H1XHaiILJPOLNrddOkaZSUu74vVv4+NBxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SUyhkNJhS49qUo9CNRXFmbfiIhSnlUnmb4K0YyIeG+c=;
 b=WnsL2mES3ClM+/F8dJdCN5K1OTDqzU8etoR3Kds2RFq3pDTOZ5hK/pT6XYpLxbPlqsUVihcX1v+i0rT+yp89REvf8USdJGUs/4N95Md5cX3Z3YNCmD/lksH3kakJ596acL7WufBdPeYdMYmJQH3HsU7Nq+OSVEGI3eq3Y3pcqFA=
Received: from BN9PR03CA0380.namprd03.prod.outlook.com (2603:10b6:408:f7::25)
 by BN8PR12MB2913.namprd12.prod.outlook.com (2603:10b6:408:9c::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.14; Wed, 1 Dec
 2021 10:53:49 +0000
Received: from BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f7:cafe::2d) by BN9PR03CA0380.outlook.office365.com
 (2603:10b6:408:f7::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24 via Frontend
 Transport; Wed, 1 Dec 2021 10:53:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT056.mail.protection.outlook.com (10.13.177.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Wed, 1 Dec 2021 10:53:49 +0000
Received: from thomas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 1 Dec
 2021 04:53:47 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 09/11] drm/amdgpu: Modify sdma block to fit for the unified
 ras block data and ops
Date: Wed, 1 Dec 2021 18:52:48 +0800
Message-ID: <20211201105250.298525-9-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211201105250.298525-1-YiPeng.Chai@amd.com>
References: <20211201105250.298525-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6e005f7-e423-4425-6062-08d9b4b8db23
X-MS-TrafficTypeDiagnostic: BN8PR12MB2913:
X-Microsoft-Antispam-PRVS: <BN8PR12MB2913F8510468F973863A0FADFC689@BN8PR12MB2913.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2QBLdyqkPJNtmpATo8lSAbrxsOUCjRN0bDhywDmv4Os4OgGAE3mEbTUT8dP9kzlOk/4VOxFl6w4uqFH+f5Qkzqj3GSrSFIQ/wgaqX8LIqOOP6fKU+0Eo6V8Gt5TX/Ok9GHbpVjZzzRG60Dr6Wd9aHo/nfF0DrKdUXutJ+f29gZWFX/xn0syDuYdG37xdbupr/rG58HM1VZQm0/f7NOkbH6ni1AlLEtG4bOot4wsqSxJjxnT/N0O3jUjeRSraFyEE4dLipJrwlschd+e8jkmAqM3bGGwdVAA6HiZ88GAD6k5OGRawSHO04tB9uN5J4HJAEgg+lW1Z+3MQE8oKQDW4onXp9e0GgG874OkF4kF388p4OW9/69i9kJs+3ecQVjXp2TdSbIXc+sd3fAGBzjjvU2M6NR43XTPn7A0+cZPhcJEquubtqcaXz9CKJASZK+rSfJ2IKmFHeflxRHxrdOCT5/S8CynU32E0R75DgWiBVdlQl11UIy0nUI4o/5XyW5NB2ux2VRTRET5397G+N6RiF4fLLaIc5X86x3uwF7JtgaWcPrbLA4KYg+3rpH8LMZm10PxkUNjOGgjdstcdUkadm4asVkoWWTe9N3V2A/MZR9WSPLmPjyLudYnaqqMxr0XUJkqTP2zeIQ8fAPjADnAS7/2aATiO446BhtzMXhdjhv1JmaxbCgmQTP1ask2m0n4jiaSMzPv2CPyVJPxkBmi7g2oj+MD6cjo0DX3/K3BYmEndl4k3rWZnpL+JpWVdGgYaH5TKZ9TCA0mn7QlHjGDXCOjjGJleEPZp4Y/T3Cxs3HrqMLyD2Jyp1arA+CYvW3xM
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(8676002)(5660300002)(47076005)(36860700001)(2906002)(83380400001)(7696005)(336012)(82310400004)(4326008)(426003)(508600001)(16526019)(86362001)(186003)(81166007)(26005)(54906003)(1076003)(316002)(6916009)(36756003)(8936002)(70586007)(70206006)(40460700001)(356005)(2616005)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 10:53:49.2697 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6e005f7-e423-4425-6062-08d9b4b8db23
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2913
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
Cc: Tao.Zhou1@amd.com, Hawking.Zhang@amd.com, yipechai <YiPeng.Chai@amd.com>,
 yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

1.Modify sdma block to fit for the unified ras block data and ops.
2.Implement .ras_block_match function pointer for sdma block to identify itself.
3.Change amdgpu_sdma_ras_funcs to amdgpu_sdma_ras, and the corresponding variable name remove _funcs suffix.
4.Remove the const flag of sdma ras variable so that sdma ras block can be able to be insertted into amdgpu device ras block link list.
5.Invoke amdgpu_ras_register_ras_block function to register sdma ras block into amdgpu device ras block link list.
6.Remove the redundant code about sdma in amdgpu_ras.c after using the unified ras block.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c  |  9 ----
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h | 13 ++---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   | 61 +++++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4.c   | 40 ++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4.h   |  2 +-
 5 files changed, 92 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 7d050afd7e2e..6a145d0e0032 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -939,12 +939,6 @@ int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
 			block_obj->ops->query_ras_error_address(adev, &err_data);
 		break;
 	case AMDGPU_RAS_BLOCK__SDMA:
-		if (adev->sdma.funcs->query_ras_error_count) {
-			for (i = 0; i < adev->sdma.num_instances; i++)
-				adev->sdma.funcs->query_ras_error_count(adev, i,
-									&err_data);
-		}
-		break;
 	case AMDGPU_RAS_BLOCK__GFX:
 	case AMDGPU_RAS_BLOCK__MMHUB:
 		if (!block_obj || !block_obj->ops)	{
@@ -1049,9 +1043,6 @@ int amdgpu_ras_reset_error_status(struct amdgpu_device *adev,
 			block_obj->ops->reset_ras_error_status(adev);
 		break;
 	case AMDGPU_RAS_BLOCK__SDMA:
-		if (adev->sdma.funcs->reset_ras_error_count)
-			adev->sdma.funcs->reset_ras_error_count(adev);
-		break;
 	case AMDGPU_RAS_BLOCK__HDP:
 		if (!block_obj || !block_obj->ops)	{
 			dev_info(adev->dev, "%s don't config ras function \n", ras_block_str(block));
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index f8fb755e3aa6..a0761cf50ae0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -23,6 +23,7 @@
 
 #ifndef __AMDGPU_SDMA_H__
 #define __AMDGPU_SDMA_H__
+#include "amdgpu_ras.h"
 
 /* max number of IP instances */
 #define AMDGPU_MAX_SDMA_INSTANCES		8
@@ -50,13 +51,9 @@ struct amdgpu_sdma_instance {
 	bool			burst_nop;
 };
 
-struct amdgpu_sdma_ras_funcs {
-	int (*ras_late_init)(struct amdgpu_device *adev,
-			void *ras_ih_info);
-	void (*ras_fini)(struct amdgpu_device *adev);
-	int (*query_ras_error_count)(struct amdgpu_device *adev,
-			uint32_t instance, void *ras_error_status);
-	void (*reset_ras_error_count)(struct amdgpu_device *adev);
+struct amdgpu_sdma_ras {
+	struct amdgpu_ras_block_object ras_block;
+	int (*sdma_ras_late_init)(struct amdgpu_device *adev, void *ras_ih_info);
 };
 
 struct amdgpu_sdma {
@@ -73,7 +70,7 @@ struct amdgpu_sdma {
 	uint32_t                    srbm_soft_reset;
 	bool			has_page_queue;
 	struct ras_common_if	*ras_if;
-	const struct amdgpu_sdma_ras_funcs	*funcs;
+	struct amdgpu_sdma_ras	*ras;
 };
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 69c9e460c1eb..30a651613776 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1898,13 +1898,13 @@ static int sdma_v4_0_late_init(void *handle)
 	sdma_v4_0_setup_ulv(adev);
 
 	if (!amdgpu_persistent_edc_harvesting_supported(adev)) {
-		if (adev->sdma.funcs &&
-		    adev->sdma.funcs->reset_ras_error_count)
-			adev->sdma.funcs->reset_ras_error_count(adev);
+		if (adev->sdma.ras && adev->sdma.ras->ras_block.ops &&
+		    adev->sdma.ras->ras_block.ops->reset_ras_error_count)
+			adev->sdma.ras->ras_block.ops->reset_ras_error_count(adev);
 	}
 
-	if (adev->sdma.funcs && adev->sdma.funcs->ras_late_init)
-		return adev->sdma.funcs->ras_late_init(adev, &ih_info);
+	if (adev->sdma.ras && adev->sdma.ras->sdma_ras_late_init)
+		return adev->sdma.ras->sdma_ras_late_init(adev, &ih_info);
 	else
 		return 0;
 }
@@ -2007,8 +2007,9 @@ static int sdma_v4_0_sw_fini(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int i;
 
-	if (adev->sdma.funcs && adev->sdma.funcs->ras_fini)
-		adev->sdma.funcs->ras_fini(adev);
+	if (adev->sdma.ras && adev->sdma.ras->ras_block.ops &&
+		adev->sdma.ras->ras_block.ops->ras_fini)
+		adev->sdma.ras->ras_block.ops->ras_fini(adev);
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		amdgpu_ring_fini(&adev->sdma.instance[i].ring);
@@ -2745,7 +2746,7 @@ static void sdma_v4_0_get_ras_error_count(uint32_t value,
 	}
 }
 
-static int sdma_v4_0_query_ras_error_count(struct amdgpu_device *adev,
+static int sdma_v4_0_query_ras_error_count_by_instance(struct amdgpu_device *adev,
 			uint32_t instance, void *ras_error_status)
 {
 	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
@@ -2767,6 +2768,18 @@ static int sdma_v4_0_query_ras_error_count(struct amdgpu_device *adev,
 	return 0;
 };
 
+static void sdma_v4_0_query_ras_error_count(struct amdgpu_device *adev,  void *ras_error_status)
+{
+	int i = 0;
+	for (i = 0; i < adev->sdma.num_instances; i++) {
+		if (sdma_v4_0_query_ras_error_count_by_instance(adev, i, ras_error_status))
+		{
+			dev_err(adev->dev, "Query ras error count failed in SDMA%d \n", i);
+			return;
+		}
+	}
+}
+
 static void sdma_v4_0_reset_ras_error_count(struct amdgpu_device *adev)
 {
 	int i;
@@ -2778,26 +2791,50 @@ static void sdma_v4_0_reset_ras_error_count(struct amdgpu_device *adev)
 	}
 }
 
-static const struct amdgpu_sdma_ras_funcs sdma_v4_0_ras_funcs = {
-	.ras_late_init = amdgpu_sdma_ras_late_init,
+static int sdma_v4_0_ras_block_match(struct amdgpu_ras_block_object* block_obj, enum amdgpu_ras_block block, uint32_t sub_block_index)
+{
+	if(!block_obj)
+		return -EINVAL;
+
+	if(block_obj->block == block) {
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+const struct amdgpu_ras_block_ops sdma_v4_0_ras_ops = {
+	.ras_block_match = sdma_v4_0_ras_block_match,
 	.ras_fini = amdgpu_sdma_ras_fini,
 	.query_ras_error_count = sdma_v4_0_query_ras_error_count,
 	.reset_ras_error_count = sdma_v4_0_reset_ras_error_count,
 };
 
+static struct amdgpu_sdma_ras sdma_v4_0_ras = {
+	.ras_block = {
+		.name = "sdma",
+		.block = AMDGPU_RAS_BLOCK__SDMA,
+		.ops = &sdma_v4_0_ras_ops,
+	},
+	.sdma_ras_late_init = amdgpu_sdma_ras_late_init,
+};
+
 static void sdma_v4_0_set_ras_funcs(struct amdgpu_device *adev)
 {
 	switch (adev->asic_type) {
 	case CHIP_VEGA20:
 	case CHIP_ARCTURUS:
-		adev->sdma.funcs = &sdma_v4_0_ras_funcs;
+		adev->sdma.ras = &sdma_v4_0_ras;
 		break;
 	case CHIP_ALDEBARAN:
-		adev->sdma.funcs = &sdma_v4_4_ras_funcs;
+		adev->sdma.ras = &sdma_v4_4_ras;
 		break;
 	default:
 		break;
 	}
+
+	if(adev->sdma.ras)
+		amdgpu_ras_register_ras_block(adev, &adev->sdma.ras->ras_block);
 }
 
 const struct amdgpu_ip_block_version sdma_v4_0_ip_block = {
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4.c
index bf95007f0843..8c165bcb0ffa 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4.c
@@ -188,7 +188,7 @@ static void sdma_v4_4_get_ras_error_count(struct amdgpu_device *adev,
 	}
 }
 
-static int sdma_v4_4_query_ras_error_count(struct amdgpu_device *adev,
+static int sdma_v4_4_query_ras_error_count_by_instance(struct amdgpu_device *adev,
 					   uint32_t instance,
 					   void *ras_error_status)
 {
@@ -245,9 +245,43 @@ static void sdma_v4_4_reset_ras_error_count(struct amdgpu_device *adev)
 	}
 }
 
-const struct amdgpu_sdma_ras_funcs sdma_v4_4_ras_funcs = {
-	.ras_late_init = amdgpu_sdma_ras_late_init,
+static void sdma_v4_4_query_ras_error_count(struct amdgpu_device *adev,  void *ras_error_status)
+{
+	int i = 0;
+	for (i = 0; i < adev->sdma.num_instances; i++) {
+		if (sdma_v4_4_query_ras_error_count_by_instance(adev, i, ras_error_status))
+		{
+			dev_err(adev->dev, "Query ras error count failed in SDMA%d \n", i);
+			return;
+		}
+	}
+
+}
+
+static int sdma_v4_4_ras_block_match(struct amdgpu_ras_block_object* block_obj, enum amdgpu_ras_block block, uint32_t sub_block_index)
+{
+	if(!block_obj)
+		return -EINVAL;
+
+	if(block_obj->block == block) {
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+const struct amdgpu_ras_block_ops sdma_v4_4_ras_ops = {
+	.ras_block_match = sdma_v4_4_ras_block_match,
 	.ras_fini = amdgpu_sdma_ras_fini,
 	.query_ras_error_count = sdma_v4_4_query_ras_error_count,
 	.reset_ras_error_count = sdma_v4_4_reset_ras_error_count,
 };
+
+struct amdgpu_sdma_ras sdma_v4_4_ras = {
+	.ras_block = {
+		.name = "sdma",
+		.block = AMDGPU_RAS_BLOCK__SDMA,
+		.ops = &sdma_v4_4_ras_ops,
+	},
+	.sdma_ras_late_init = amdgpu_sdma_ras_late_init,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4.h b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4.h
index 74a6e5b5e949..a9f0c68359e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4.h
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4.h
@@ -23,6 +23,6 @@
 #ifndef __SDMA_V4_4_H__
 #define __SDMA_V4_4_H__
 
-extern const struct amdgpu_sdma_ras_funcs sdma_v4_4_ras_funcs;
+extern struct amdgpu_sdma_ras sdma_v4_4_ras;
 
 #endif
-- 
2.25.1

