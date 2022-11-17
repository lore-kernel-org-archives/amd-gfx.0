Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5562AC433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Nov 2022 06:09:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CF3E10E53C;
	Thu, 17 Nov 2022 06:09:39 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79C7510E53A
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Nov 2022 06:09:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WpW5nCF7rMCJ98KOmdlU0uPo+XYNcTIzdYEmYa82EtfE76tGfDrjLmAUogZXloZ5wVHQwaCaGo4kdXJN3FQ3qHQnhwxt8U6HKlHnNB/VQY7cCwW974CYgjrCpoi4aXhfYgsK/CMChX5MkL6AKVMlMc7fkwW9v6Ji4xlz3RgdppWSPMcUnCBMGT/nQ18Z3McI8sxqIOL60Iq5NSwcKSqOjfg1nDsh9hqVttLCjmK7YiLruFzCCdfMPrRqsk4rabP3k++OAiwkkWkKfUjz4qpXP6sgJC4JpRbvE5OZqMdmwaIxzq2xqUkcg0tZBfjWf/8AN5YRSr1Mrzagi1BgXEkhoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zsk5CCzFPA0ubpXRgFEsCBomTfEiGMpyFJ3hhlt0mUM=;
 b=N9kKrPOtkvQUAIR0siBS4/HLMEIK/tdCt/Z2Ohq6GsGXmfeTl4XfxDZRDzda0kk060g1zbSN7S15tPJ4LCtAEp/gDVb0DG62DnhoWvwckkrUOM3j3sbf1tuCdvUd/duAnBJmibWWTKVEVv9zCueM//uq5xtfuqapYsnCdCtVjw/VHybgFIWrkHGfgvlVyJglTyUKK+ibrS4E2iPnUiiRQH2ACeRJbsDpcJ5u5e1CVZWtL3laZHvLrO1Qpu0Gzmu4YNx5S6OzVyMsR8xPzsWnJEJBywh2lxMFLtxcMQMjK3WYK0pLxX+gORBp521Wj6VzrMtDwzHM5YgO/NwMIuW9Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zsk5CCzFPA0ubpXRgFEsCBomTfEiGMpyFJ3hhlt0mUM=;
 b=3AVpDdeTOkSDQ7zcD8iBusqVyGTpU1Yk+NVD7WSUNrU/frE1G8BC7qtbFmGe9BO7fo1RgWosQx3oRFJis9tzLdqrob54p5uLpMMbjLAQlMg8uUvB2CPlhkFaHoeVoEdmVK3+32/xbNd4FbIzStNo9VjIQ8CFySOYRi2feqgEv3w=
Received: from BN6PR17CA0046.namprd17.prod.outlook.com (2603:10b6:405:75::35)
 by CY5PR12MB6552.namprd12.prod.outlook.com (2603:10b6:930:40::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Thu, 17 Nov
 2022 06:09:33 +0000
Received: from BN8NAM11FT081.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:75:cafe::c4) by BN6PR17CA0046.outlook.office365.com
 (2603:10b6:405:75::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.14 via Frontend
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
 15.20.5834.8 via Frontend Transport; Thu, 17 Nov 2022 06:09:32 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 17 Nov
 2022 00:09:27 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <Alexander.Deucher@amd.com>, <Lijo.Lazar@amd.com>
Subject: [PATCH 4/8] drm/amdgpu: add RAS query support for VCN 4.0
Date: Thu, 17 Nov 2022 14:07:51 +0800
Message-ID: <20221117060755.13655-4-tao.zhou1@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT081:EE_|CY5PR12MB6552:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a0b3f98-ab55-42cf-3fec-08dac8624bcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sH9BsDmNzBbnOWAVLy0pfk5roOR5MaiRhBotg6hAMNd+iPC65n5AxZ6JX4Rh8XQSU3UnkVShAbWE3z5Awe/WKw+fUaNoz6/68xN0q8SitqrOoyNjiVYM4wy/p9Y8OB206iyZxRTCjP/EUi57BPEtjEXqN3HOJICyb7S8LsBYk7MzPb/ZiwphJaToYE8y+LWi7/Oi9eXjiUK2V373I4VCildL725I5GBVWHw0lrXPxRz2w4vMjroOa7U2HDCEB7BOrGajBokP+Ga1+3EgjuIJjqVAYJDrysgJvtt3y0P2KMuI2cClmbdLXtz5hfQg4z6s/xTk4ig6uNJ+pzAmFSD/7+KTHXcc9sD5y6l08AYecSCgIHlCLvO+8D1Qz8W0YQE4gAMzTimluQLOJFHN+bqK92PtzDOaYEw16WYl6KcbrB3G0fRbIpZhaJqxWj/JM21bKI2mg6FUpa/5bcA4x5tqJiPIw2vR3vE5j8SS+3von6lSxhngm48fsQ+ExvyLxu40kNxyLqy9yy8UflbCV7U6i5o4eUeYQFMq5327c71CB98wlumDrIMH+Xtftmhf/wBGPaohH5wXAt9T6DorlWssFwMzhURQWBG6BzaKjFU23FH44oRXgEz4JBjDwwwbRvSGI34tiIzmIFcxsWJ2BWZiy8MEsAF22gbZf4xvgJQLulFHWtyoM65iC6ubQ+eZEVhWXOECpn4OPfJ8FtU3nzOjiPnGdvLDETCH82dXXWOM+6srDP2E3Z9qtfo7kdViFRYk
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(396003)(346002)(136003)(451199015)(40470700004)(46966006)(36840700001)(47076005)(83380400001)(81166007)(40460700003)(2616005)(1076003)(186003)(54906003)(8936002)(82740400003)(36860700001)(2906002)(336012)(426003)(356005)(16526019)(5660300002)(70586007)(478600001)(40480700001)(82310400005)(41300700001)(26005)(4326008)(6666004)(8676002)(7696005)(70206006)(110136005)(6636002)(316002)(36756003)(86362001)(36900700001)(309714004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 06:09:32.8967 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a0b3f98-ab55-42cf-3fec-08dac8624bcc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT081.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6552
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

Initialize VCN RAS structure and add RAS status query function.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 60 +++++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.h |  6 +++
 2 files changed, 66 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 897a5ce9c9da..b067fb63010e 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -31,6 +31,7 @@
 #include "soc15_hw_ip.h"
 #include "vcn_v2_0.h"
 #include "mmsch_v4_0.h"
+#include "vcn_v4_0.h"
 
 #include "vcn/vcn_4_0_0_offset.h"
 #include "vcn/vcn_4_0_0_sh_mask.h"
@@ -64,6 +65,7 @@ static int vcn_v4_0_set_powergating_state(void *handle,
 static int vcn_v4_0_pause_dpg_mode(struct amdgpu_device *adev,
         int inst_idx, struct dpg_pause_state *new_state);
 static void vcn_v4_0_unified_ring_set_wptr(struct amdgpu_ring *ring);
+static void vcn_v4_0_set_ras_funcs(struct amdgpu_device *adev);
 
 /**
  * vcn_v4_0_early_init - set function pointers
@@ -84,6 +86,7 @@ static int vcn_v4_0_early_init(void *handle)
 
 	vcn_v4_0_set_unified_ring_funcs(adev);
 	vcn_v4_0_set_irq_funcs(adev);
+	vcn_v4_0_set_ras_funcs(adev);
 
 	return 0;
 }
@@ -2001,3 +2004,60 @@ const struct amdgpu_ip_block_version vcn_v4_0_ip_block =
 	.rev = 0,
 	.funcs = &vcn_v4_0_ip_funcs,
 };
+
+static uint32_t vcn_v4_0_query_poison_by_instance(struct amdgpu_device *adev,
+			uint32_t instance, uint32_t sub_block)
+{
+	uint32_t poison_stat = 0, reg_value = 0;
+
+	switch (sub_block) {
+	case AMDGPU_VCN_V4_0_VCPU_VCODEC:
+		reg_value = RREG32_SOC15(VCN, instance, regUVD_RAS_VCPU_VCODEC_STATUS);
+		poison_stat = REG_GET_FIELD(reg_value, UVD_RAS_VCPU_VCODEC_STATUS, POISONED_PF);
+		break;
+	default:
+		break;
+	}
+
+	if (poison_stat)
+		dev_info(adev->dev, "Poison detected in VCN%d, sub_block%d\n",
+			instance, sub_block);
+
+	return poison_stat;
+}
+
+static bool vcn_v4_0_query_ras_poison_status(struct amdgpu_device *adev)
+{
+	uint32_t inst, sub;
+	uint32_t poison_stat = 0;
+
+	for (inst = 0; inst < adev->vcn.num_vcn_inst; inst++)
+		for (sub = 0; sub < AMDGPU_VCN_V4_0_MAX_SUB_BLOCK; sub++)
+			poison_stat +=
+				vcn_v4_0_query_poison_by_instance(adev, inst, sub);
+
+	return !!poison_stat;
+}
+
+const struct amdgpu_ras_block_hw_ops vcn_v4_0_ras_hw_ops = {
+	.query_poison_status = vcn_v4_0_query_ras_poison_status,
+};
+
+static struct amdgpu_vcn_ras vcn_v4_0_ras = {
+	.ras_block = {
+		.hw_ops = &vcn_v4_0_ras_hw_ops,
+	},
+};
+
+static void vcn_v4_0_set_ras_funcs(struct amdgpu_device *adev)
+{
+	switch (adev->ip_versions[VCN_HWIP][0]) {
+	case IP_VERSION(4, 0, 0):
+		adev->vcn.ras = &vcn_v4_0_ras;
+		break;
+	default:
+		break;
+	}
+
+	amdgpu_vcn_set_ras_funcs(adev);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.h b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.h
index 7c5c9d91bb52..7d3d11f40f27 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.h
@@ -24,6 +24,12 @@
 #ifndef __VCN_V4_0_H__
 #define __VCN_V4_0_H__
 
+enum amdgpu_vcn_v4_0_sub_block {
+	AMDGPU_VCN_V4_0_VCPU_VCODEC = 0,
+
+	AMDGPU_VCN_V4_0_MAX_SUB_BLOCK,
+};
+
 extern const struct amdgpu_ip_block_version vcn_v4_0_ip_block;
 
 #endif /* __VCN_V4_0_H__ */
-- 
2.35.1

