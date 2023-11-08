Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49C2AC4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Nov 2023 12:58:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3A8910E0B4;
	Wed,  8 Nov 2023 12:58:06 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::609])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27CAE10E737
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Nov 2023 12:58:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pq/uP9Rr4QNgA43L8clVGCcRfUdlfF5JpwRxarHuqIWyJYgxePwEJYY3RwwLq1KQ5KkHAUFej6ROTG3Smie6B02RSJPdujTGuGYPN5h1G5u2Dnv2km+u9+qL7/xTuZSBE0uypBbli0vEvhZ31YhJvjt6+/6pugmusH8Dqmr37G12i9D1ehBaxiga1SDvdzUYKOtd56eV2yXCd9NOynW4yJeZ/4FePYnGl6Fz9676cGfl6lvOQQXFw9mjWu7ZVc887HPeyscmN5okB8tKbdXQFvD54hEk/Hd2+Fw4Y4hxVI+Dwhp8zpgjBpuy+8rd9x3En5UHVLr/1nSSQQKk1QGmlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WTYhPRfL12cR4QPUS0Cd9Fvscst54RxCgbk8fmcdJOA=;
 b=Z0xFOfrAxFR5ZAgKB9q+6VaaV4bLclQpj8L/tpcIxW/cLqh9vDxqkZcectpUfppoQYSq7IrDwhuyJERTRvp+x6FLTMi1EAKAigMEmxS6Cn0EtaogvBmWN2HKJiKvGUVpi7qsjqzCoCnpniV8gBFoC9raoPBeUQDRVMNI879rv+gym6Wk7q9ZlruhG52cBew3YMOjN8/WNAaYbiqNhjN/0pwGek3wp65X2Myh34Li0ihg7kbOPKNjttW9GeaB8WXn6oo/bha6w1SIZnUADep42al47jo9RBvkufg8mUo5k5cccnCbUly+i2oTLlOcgJX+qWC9g0piMw9+iqvsybR2zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WTYhPRfL12cR4QPUS0Cd9Fvscst54RxCgbk8fmcdJOA=;
 b=fE9Z8+sd/qteVnPHH/VEhFJ48sbj8OEBlm5RcC6ckCZphGVUsFax5+niTOVxz7QwbdiVogBEZhCiTdsG481D4Z7lXE5E5RV4u0DpK15Ol2otAfIk4RRaEp0IMB0GT994wcYU0EeiK7HBKFAUOk/xtpHoDHbCrA12iY2wjdFRvqI=
Received: from SN4PR0501CA0124.namprd05.prod.outlook.com
 (2603:10b6:803:42::41) by BN9PR12MB5212.namprd12.prod.outlook.com
 (2603:10b6:408:11d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Wed, 8 Nov
 2023 12:58:00 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:803:42:cafe::7a) by SN4PR0501CA0124.outlook.office365.com
 (2603:10b6:803:42::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18 via Frontend
 Transport; Wed, 8 Nov 2023 12:58:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Wed, 8 Nov 2023 12:58:00 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 8 Nov
 2023 06:57:58 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/7] drm/amdgpu: correct smu v13.0.6 umc ras error check
Date: Wed, 8 Nov 2023 20:57:29 +0800
Message-ID: <20231108125735.2497856-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|BN9PR12MB5212:EE_
X-MS-Office365-Filtering-Correlation-Id: b0a25c43-b53e-4428-a03b-08dbe05a5636
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oiZyIKZpraNj3zp+fIBF0Cs+rZBAtGx3fOlgWBQrwoH6QWUkmY0DXiQGhm9Bbs6PJdLfk9Ve0FkQT8fuNK1yrRC0nUk6Gdn/D96pB6rI5VxArQ+AAU0ioHPJB3feBgsgQbqrJFeUmNpG1BLUD/pHXplAsvwXilakG2FHhWTO+WYWtspjKdun10k1xWBpZRbMohOlgRKy7Tc3iR5F8GLQXvr/aCaRP1Kc45uPeOvjCjB9dSFfJi+CkFNWw2xBFP/oFffQRPadnxG0erG3XnPjYJ51N7iDqS+aLvLmVkVXGFkEIQc5HHmCau+nituzRwsvDsxN3W6iuX167fkIeppjy/p9N5JwxMcMbGKBGjRbHwLIz37qkY+lcyGEMTihH5zM9CXGazR+iZWxVpfH30RmsotGITUrO7URtxlzAz5pC0xAWtyyI12/NdN/2w6/YvrJIN+jHjNzd5cQcbbKXTn6vpO4LvphOMysFsbVRg5Cq1uiUpR8SSbHmLL/8t1LON7Spr/lx8xYJwI0FGTQqe7QECNCFZUnmFLG5Nt4eKKj89fgXVxDeqm54OWEQBEhHyevMf88Y7JSI61OMzysGZUoHvO1G9ih6hQZ6f5oFfvjtFdSKm29YksBZ4/D52cH7oR8hdBmlqmI71gJiJKs+59Ztboq/484OCimK70Le1rbXTPKr0TsVxMTq67q6BZG0Q2yoAOiVfUkKkZOsXRTO4vd9y3ezbO2ynYJZGZc0LE9toLYj4FncpUNB1fwXJVJYiL6SI7N7pC0LJ1U7L1duvqT3g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(376002)(396003)(39860400002)(230922051799003)(64100799003)(451199024)(1800799009)(82310400011)(186009)(40470700004)(36840700001)(46966006)(47076005)(8676002)(4326008)(40460700003)(8936002)(70206006)(316002)(70586007)(54906003)(6916009)(41300700001)(2906002)(86362001)(5660300002)(83380400001)(81166007)(336012)(426003)(356005)(2616005)(16526019)(26005)(82740400003)(1076003)(36860700001)(40480700001)(36756003)(478600001)(7696005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 12:58:00.0687 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0a25c43-b53e-4428-a03b-08dbe05a5636
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5212
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
Cc: Yang Wang <kevinyang.wang@amd.com>, hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

correct smu v13.0.0 umc ras error check

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c           |  4 ++--
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.h           |  3 +++
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 16 +++++++++++-----
 3 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index 770b4b4e3138..e9c2ff74f0bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -88,7 +88,7 @@ static void umc_v12_0_reset_error_count(struct amdgpu_device *adev)
 		umc_v12_0_reset_error_count_per_channel, NULL);
 }
 
-static bool umc_v12_0_is_uncorrectable_error(uint64_t mc_umc_status)
+bool umc_v12_0_is_uncorrectable_error(uint64_t mc_umc_status)
 {
 	return ((REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1) &&
 		(REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, PCC) == 1 ||
@@ -96,7 +96,7 @@ static bool umc_v12_0_is_uncorrectable_error(uint64_t mc_umc_status)
 		REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, TCC) == 1));
 }
 
-static bool umc_v12_0_is_correctable_error(uint64_t mc_umc_status)
+bool umc_v12_0_is_correctable_error(uint64_t mc_umc_status)
 {
 	return (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1 &&
 		(REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, CECC) == 1 ||
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
index 4885b9fff272..b34b1e358f8b 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
@@ -117,6 +117,9 @@
 		(pa) |= (UMC_V12_0_CHANNEL_HASH_CH6(channel_idx, pa) << UMC_V12_0_PA_CH6_BIT); \
 	} while (0)
 
+bool umc_v12_0_is_uncorrectable_error(uint64_t mc_umc_status);
+bool umc_v12_0_is_correctable_error(uint64_t mc_umc_status);
+
 extern const uint32_t
 	umc_v12_0_channel_idx_tbl[]
 			[UMC_V12_0_UMC_INSTANCE_NUM]
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 7b99750528d8..a7edd3798a6f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -48,6 +48,7 @@
 #include "smu_cmn.h"
 #include "mp/mp_13_0_6_offset.h"
 #include "mp/mp_13_0_6_sh_mask.h"
+#include "umc_v12_0.h"
 
 #undef MP1_Public
 #undef smnMP1_FIRMWARE_FLAGS
@@ -2478,7 +2479,7 @@ static int mca_decode_mca_ipid(struct amdgpu_device *adev, enum amdgpu_mca_error
 	return 0;
 }
 
-static int mca_normal_mca_get_err_count(const struct mca_ras_info *mca_ras, struct amdgpu_device *adev,
+static int mca_umc_mca_get_err_count(const struct mca_ras_info *mca_ras, struct amdgpu_device *adev,
 					enum amdgpu_mca_error_type type, int idx, uint32_t *count)
 {
 	uint64_t status0;
@@ -2488,10 +2489,15 @@ static int mca_normal_mca_get_err_count(const struct mca_ras_info *mca_ras, stru
 	if (ret)
 		return ret;
 
-	if (REG_GET_FIELD(status0, MCMP1_STATUST0, Val))
-		*count = 1;
-	else
+	if (!REG_GET_FIELD(status0, MCMP1_STATUST0, Val)) {
 		*count = 0;
+		return 0;
+	}
+
+	if (type == AMDGPU_MCA_ERROR_TYPE_UE && umc_v12_0_is_uncorrectable_error(status0))
+		*count = 1;
+	else if (type == AMDGPU_MCA_ERROR_TYPE_CE && umc_v12_0_is_correctable_error(status0))
+		*count = 1;
 
 	return 0;
 }
@@ -2605,7 +2611,7 @@ static const struct mca_ras_info mca_ras_table[] = {
 	{
 		.blkid = AMDGPU_RAS_BLOCK__UMC,
 		.ip = AMDGPU_MCA_IP_UMC,
-		.get_err_count = mca_normal_mca_get_err_count,
+		.get_err_count = mca_umc_mca_get_err_count,
 	}, {
 		.blkid = AMDGPU_RAS_BLOCK__GFX,
 		.ip = AMDGPU_MCA_IP_MP5,
-- 
2.34.1

