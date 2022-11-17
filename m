Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1EE1C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Nov 2022 06:09:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34CB510E539;
	Thu, 17 Nov 2022 06:09:37 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6678510E539
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Nov 2022 06:09:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F/2Da0KYC5PMmn+qmocoehtD0EVs4gtPPO3M3GBb4ofP0Zbdf4vMGwg4WhqCESiymJAqKiSDCmbKbN85Jj2v/g+JDARnP74UnnaJ5fC1PmohMiVNFnRggB3NvnUMA32DtetMphtVKxIGIxd0Y06uj23wPjito0IwsPLL9chYcR0tlP2HQI8j69U2zCYJo/bSJ2M7neokTQFmZFB0PriPz1ffpDMTyG/1VsCU6nEXs47k/5U2CNsyts/AJOsPTkdLx+cux/S8OBUaY1zsrgNIYhZC4br1Ittzn1I3/sdmelcW69zmj0J2Zn4RLQERQka4nu6Tb2tOrwkQaOw4vp0HjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kD5OfVpEIiknGtwhh59ZVf+Br2XTBPlnx3eCrgjTcoo=;
 b=Z5AwYpSpq9zH1sUN3c/ESOqsX4m6jWmk7UX6AnGMzGzQBvHmYuMycN3Slm2ugkS6O1FWAJDzf2lgy1elSUay7WyNkABQdxbDwnWx/dEeyauLSQGPn1cMWefKyHFNI7kx87uxMZmGYOj10nWH3fnCUpIIhV6CnRfuy0unWm7fCtmuygeH4wFwGNsBo3cgIUWbJGuzOp+vVuB2CO2YSvTVtpN+ZXPhX+Glo39SkaDeZpjeJa0Yq0vxqkOeFmUnPFUguyQUFoStVQvuRmkeCJXcBZAyl/LrFz1D0ZX2Zhfj9ioTKBBuwmbTsa+WOogzL78JytdaSSjQZbQdUt9Lyfs9pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kD5OfVpEIiknGtwhh59ZVf+Br2XTBPlnx3eCrgjTcoo=;
 b=1sQcbofvi1jUdCbTzFln5ivLPktY8vLhXqvIZdpRXZwvnc4RTpksIPBo4S3b1v2GhrCnG4hfjULWbE/y2ZNK0VgNNFxMuzGErfOKymvgX9hjNgr96qid0DX3hx6QU3gn/NBpwf5WnPLD4aTPkk3kEQBLJ59wdlWHkd5Kva96S20=
Received: from BN6PR17CA0042.namprd17.prod.outlook.com (2603:10b6:405:75::31)
 by DM4PR12MB5374.namprd12.prod.outlook.com (2603:10b6:5:39a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Thu, 17 Nov
 2022 06:09:33 +0000
Received: from BN8NAM11FT081.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:75:cafe::ce) by BN6PR17CA0042.outlook.office365.com
 (2603:10b6:405:75::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.12 via Frontend
 Transport; Thu, 17 Nov 2022 06:09:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT081.mail.protection.outlook.com (10.13.177.233) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Thu, 17 Nov 2022 06:09:33 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 17 Nov
 2022 00:09:29 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <Alexander.Deucher@amd.com>, <Lijo.Lazar@amd.com>
Subject: [PATCH 5/8] drm/amdgpu: add RAS error query for JPEG 4.0
Date: Thu, 17 Nov 2022 14:07:52 +0800
Message-ID: <20221117060755.13655-5-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221117060755.13655-1-tao.zhou1@amd.com>
References: <20221117060755.13655-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT081:EE_|DM4PR12MB5374:EE_
X-MS-Office365-Filtering-Correlation-Id: db9e39d1-8761-4b6c-8985-08dac8624c18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kVz5XdFps6gpnv6JbMJeMaVTqar3bYRRMRSPJnAn6hB4XIhLTahB/ExLR6FAvbUR3tTrQRtMmg4ulZbVoAuybd+EwGVodONuPXN85BvjXrmu1EpPuk27s+Z4vqYDEMW0UNsu7VDas99uWEQGClxT7+0Ftrt4/KbjQBLsbuRHFL2zjKJiAvLEr5IVBdxPsqV0E4GjAUB69po/kmuFIuLM1WefFo3Ehd9rLutmGKEsCr1r7gDd1pv/43Pg0VBe7zGJPkrZNbCepFnv8WukKdwVpySB0ZRjm664ovdYpgtPjccvWWChi7BzAZH5wFNNkpSXGAZ14vvrgaG92rh8eWy6gOTdIyRTG2yNBaLk+T8Yks+EdCSYiSbu85Xl7NnrhYqc+wGb6S3F3DjaoCvH6WJno6ZkbvWHcduDGOBdq/Qb06yJd7/q74JI+Solv8GRumRVpke3X99c4MbOQypN5qvg94BccvZqhKrRRAd7gqSyK0N8MXEv1+hWWVBOZwI1/Y+GB3Bx+pPthX3uNfleCZP86cmmzSpRwUUIZ1pYvsg/FzgNwUxXCMr78xZTDGU+hTN9c9On5VzW30/51pbiQ2v8vaFCuDVwbFFdFxC89qqHxX0qAuazYK/frpBUUa3ySu5JkeFnjM3fDM4P90Vn8drxMqxz2G4GcfvEQhgC1pmUOVj9EKv0h/4arLW66g8lb6Au5I4ByMiZPqX7tLg9DyI+3i4ArUo4R/tNTKScdJd/MDMlO8I3IfnRoeyEfk9tWyjE
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(376002)(39860400002)(396003)(451199015)(36840700001)(46966006)(40470700004)(4326008)(70206006)(8676002)(83380400001)(86362001)(70586007)(16526019)(5660300002)(8936002)(41300700001)(36860700001)(26005)(1076003)(2616005)(186003)(82740400003)(478600001)(356005)(81166007)(82310400005)(7696005)(40480700001)(426003)(316002)(110136005)(54906003)(47076005)(6666004)(40460700003)(336012)(6636002)(36756003)(2906002)(36900700001)(309714004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 06:09:33.4748 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db9e39d1-8761-4b6c-8985-08dac8624c18
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT081.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5374
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
Cc: Tao Zhou <tao.zhou1@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Initialize JPEG RAS structure and add error query interface.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c | 63 ++++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.h |  7 +++
 2 files changed, 70 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index 63b0d0b810ec..aa5323c9f481 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -27,6 +27,7 @@
 #include "soc15.h"
 #include "soc15d.h"
 #include "jpeg_v2_0.h"
+#include "jpeg_v4_0.h"
 
 #include "vcn/vcn_4_0_0_offset.h"
 #include "vcn/vcn_4_0_0_sh_mask.h"
@@ -38,6 +39,7 @@ static void jpeg_v4_0_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void jpeg_v4_0_set_irq_funcs(struct amdgpu_device *adev);
 static int jpeg_v4_0_set_powergating_state(void *handle,
 				enum amd_powergating_state state);
+static void jpeg_v4_0_set_ras_funcs(struct amdgpu_device *adev);
 
 /**
  * jpeg_v4_0_early_init - set function pointers
@@ -55,6 +57,7 @@ static int jpeg_v4_0_early_init(void *handle)
 
 	jpeg_v4_0_set_dec_ring_funcs(adev);
 	jpeg_v4_0_set_irq_funcs(adev);
+	jpeg_v4_0_set_ras_funcs(adev);
 
 	return 0;
 }
@@ -607,3 +610,63 @@ const struct amdgpu_ip_block_version jpeg_v4_0_ip_block = {
 	.rev = 0,
 	.funcs = &jpeg_v4_0_ip_funcs,
 };
+
+static uint32_t jpeg_v4_0_query_poison_by_instance(struct amdgpu_device *adev,
+		uint32_t instance, uint32_t sub_block)
+{
+	uint32_t poison_stat = 0, reg_value = 0;
+
+	switch (sub_block) {
+	case AMDGPU_JPEG_V4_0_JPEG0:
+		reg_value = RREG32_SOC15(JPEG, instance, regUVD_RAS_JPEG0_STATUS);
+		poison_stat = REG_GET_FIELD(reg_value, UVD_RAS_JPEG0_STATUS, POISONED_PF);
+		break;
+	case AMDGPU_JPEG_V4_0_JPEG1:
+		reg_value = RREG32_SOC15(JPEG, instance, regUVD_RAS_JPEG1_STATUS);
+		poison_stat = REG_GET_FIELD(reg_value, UVD_RAS_JPEG1_STATUS, POISONED_PF);
+		break;
+	default:
+		break;
+	}
+
+	if (poison_stat)
+		dev_info(adev->dev, "Poison detected in JPEG%d sub_block%d\n",
+			instance, sub_block);
+
+	return poison_stat;
+}
+
+static bool jpeg_v4_0_query_ras_poison_status(struct amdgpu_device *adev)
+{
+	uint32_t inst = 0, sub = 0, poison_stat = 0;
+
+	for (inst = 0; inst < adev->jpeg.num_jpeg_inst; inst++)
+		for (sub = 0; sub < AMDGPU_JPEG_V4_0_MAX_SUB_BLOCK; sub++)
+			poison_stat +=
+				jpeg_v4_0_query_poison_by_instance(adev, inst, sub);
+
+	return !!poison_stat;
+}
+
+const struct amdgpu_ras_block_hw_ops jpeg_v4_0_ras_hw_ops = {
+	.query_poison_status = jpeg_v4_0_query_ras_poison_status,
+};
+
+static struct amdgpu_jpeg_ras jpeg_v4_0_ras = {
+	.ras_block = {
+		.hw_ops = &jpeg_v4_0_ras_hw_ops,
+	},
+};
+
+static void jpeg_v4_0_set_ras_funcs(struct amdgpu_device *adev)
+{
+	switch (adev->ip_versions[JPEG_HWIP][0]) {
+	case IP_VERSION(4, 0, 0):
+		adev->jpeg.ras = &jpeg_v4_0_ras;
+		break;
+	default:
+		break;
+	}
+
+	jpeg_set_ras_funcs(adev);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.h b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.h
index f1ed6ccfedca..07d36c2abd6b 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.h
@@ -24,6 +24,13 @@
 #ifndef __JPEG_V4_0_H__
 #define __JPEG_V4_0_H__
 
+enum amdgpu_jpeg_v4_0_sub_block {
+	AMDGPU_JPEG_V4_0_JPEG0 = 0,
+	AMDGPU_JPEG_V4_0_JPEG1,
+
+	AMDGPU_JPEG_V4_0_MAX_SUB_BLOCK,
+};
+
 extern const struct amdgpu_ip_block_version jpeg_v4_0_ip_block;
 
 #endif /* __JPEG_V4_0_H__ */
-- 
2.35.1

