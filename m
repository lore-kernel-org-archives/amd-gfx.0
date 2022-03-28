Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB19FC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Mar 2022 06:25:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F077410E5FF;
	Mon, 28 Mar 2022 06:25:26 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 580BD10E5E9
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Mar 2022 06:25:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gNELMu1CbLJlNJGq35s695pFFSTSf2E7PBF9DBQ4C3oUp5HgeU3Wg1bINm/D16qMZZTwhhJrv9iE3AJ+DdO4eT7iFjqLBbaTPkOVNwdYGt0SOtOI6Ko32ElUV3Lt8Q8kDHT3uoave61sFwIozP+OUHclQ/+WFUM1SACU16upYOEEtkoi8LKyP/Yf6bCnBD6wfBz6Ob3YV30BTgUGKR1onreLnmacDks+9JyADwTsMgReUyCqN2qmQHEGNV+mMdCA55AJaRHS48vnod5Pyq4F0R605jOtUDxohytVk01Hlkit0uSgHcn/PZLsSXilb9Gb+dhg0bkxlAa3PCzWsmZ0Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cBregNP5xs8n8vswpfzTRtVCvu3iieAtQiQtpm9MtL0=;
 b=a5wDRS7p8uR3OdPfMZeEY07VYGqKE8YdfuAUqDVzZ+qCf5aXjPT3gl7QDYQNHXlKUJl2AC/GYmY07j95T9TJo6Oj/440tPU2ZRDYq/zDnB60xDMmBDYvhDW4c7DMgbbQ75a451yTrERw54I+61KVhUscg1twmFteYIwK8+4q9PHX7UCj4cy3hf27CNF7JjlPJxSwGFlOdZgx17/+uTm+Wu7Z+gMbme2FXYXAYwuJ7vxylREbVYHc2noLal+vggCWRxMMY5E7iXsN84Ijt5BWBlm2wvGjRE16T2ee4t8djopAkV8HW7UAUrYXeh6a9ANgdgs6SgNkclXG0Wepd541dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cBregNP5xs8n8vswpfzTRtVCvu3iieAtQiQtpm9MtL0=;
 b=xlIXKiP+GIN3v4Wt3FU8jl0R+pDB56EJBY+E2WqhDNHrjjAedWWVfyLwUNZ5tclq05lTlFVneve9ZIHpnFSIG8WW6FzhpCZt1rodOwwnhNeORUKuyfaQ+MMUqOP1lLDKHbvwayUe20a9RR6cff0AiH4CXj7ggYDCaCbi1lspYH0=
Received: from DM5PR21CA0042.namprd21.prod.outlook.com (2603:10b6:3:ed::28) by
 MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.16; Mon, 28 Mar 2022 06:25:22 +0000
Received: from DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ed:cafe::17) by DM5PR21CA0042.outlook.office365.com
 (2603:10b6:3:ed::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.16 via Frontend
 Transport; Mon, 28 Mar 2022 06:25:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT017.mail.protection.outlook.com (10.13.172.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Mon, 28 Mar 2022 06:25:21 +0000
Received: from zafar-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 28 Mar
 2022 01:25:19 -0500
From: Mohammad Zafar Ziya <Mohammadzafar.ziya@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 5/6] drm/amdgpu/vcn: VCN ras error query support
Date: Mon, 28 Mar 2022 14:24:52 +0800
Message-ID: <20220328062453.4156191-6-Mohammadzafar.ziya@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220328062453.4156191-1-Mohammadzafar.ziya@amd.com>
References: <20220328062453.4156191-1-Mohammadzafar.ziya@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21d084fd-2a76-4e0a-bc07-08da1083bc9c
X-MS-TrafficTypeDiagnostic: MW2PR12MB2524:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB25246B0B53DEF6DC7AC0FDC3981D9@MW2PR12MB2524.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PKo6ge4LdH5A7UtWUsV/T7K77n5uAYj2ztgZ9TeB0psAzzVif7GQA5i6atZUnVUReUZr8QVgRDkmFUnYajgIS0x8nr6RlLCvnr8rDm6lBE6VnIvXDX4bi0/la9I7AM9e1nWkjdSMsFlYobiaaXEf33im/m6aFtW2hGTyUKVdNmhuyoKdvZJ49u8AJpdXNDgVjL76MpeqG2w2MBTw3mAqIsC8HsMLGhifLMUgROcTI3bcESl3m9BBvfOSyaHIEkWll+CAeG+OPQ/n0iOgbotHVW9+XOUVly4pMs8zOn2hRGLCFcoCFiy8kPdt+AqxjLUSqXY4jdtPh0bIZzqMdvRYsYrROd4OQrWe6USyfkJHsM027EQhNA3E+mcW+/cZbltuWpst28EQsetTBtc9tS5cn3gru78AjOFrMUTvs3NJZcH8cGGHZfyDsafFFeIPtz3lAZe0NtNt4/zeejkB6xBpAozuYxUcOeN1AK4/dqoCF3bx5YEx4/eZdZAtn/5qXYisnCiSJ4U79MWZcr5gSUStq1hyF3lDMWupiGq4TB6UPhs3sxFYdbvP2Nur8jfJeih2o/rnsW+rvhUvYYBcbYGbtXwFCmfpbJMnhuAmV/YbaLcljZcIregE/yCrIH7nIsRzDdqQwSZmrm3ggw9ETzTSIBfyxkh3RGFwOvHYS5kZrwh6Gd9w7wyfcnow6mM5C5C3mlPZffSpuX6fDIMZT70QMQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(36860700001)(36756003)(40460700003)(86362001)(2906002)(316002)(47076005)(70206006)(508600001)(1076003)(82310400004)(2616005)(7696005)(426003)(26005)(83380400001)(81166007)(336012)(8676002)(8936002)(5660300002)(356005)(70586007)(186003)(4326008)(54906003)(6666004)(16526019)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 06:25:21.6401 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21d084fd-2a76-4e0a-bc07-08da1083bc9c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2524
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
Cc: Tao.Zhou1@amd.com, lijo.lazar@amd.com,
 Mohammad Zafar Ziya <Mohammadzafar.ziya@amd.com>, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RAS error query support addition for VCN 2.6

V2: removed unused option and corrected comment format
Moved the register definition under header file

V3: poison query status check added.
Removed error query interface

V4: MMSCH poison check option removed, return true/false refactored.

Signed-off-by: Mohammad Zafar Ziya <Mohammadzafar.ziya@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 71 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.h   |  6 +++
 3 files changed, 78 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 1e1a3b736859..606df8869b89 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -508,6 +508,7 @@ struct amdgpu_ras_block_hw_ops {
 	void (*query_ras_error_address)(struct amdgpu_device *adev, void *ras_error_status);
 	void (*reset_ras_error_count)(struct amdgpu_device *adev);
 	void (*reset_ras_error_status)(struct amdgpu_device *adev);
+	bool (*query_poison_status)(struct amdgpu_device *adev);
 };
 
 /* work flow
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 1869bae4104b..3988fc647741 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -31,6 +31,7 @@
 #include "soc15d.h"
 #include "vcn_v2_0.h"
 #include "mmsch_v1_0.h"
+#include "vcn_v2_5.h"
 
 #include "vcn/vcn_2_5_offset.h"
 #include "vcn/vcn_2_5_sh_mask.h"
@@ -59,6 +60,7 @@ static int vcn_v2_5_set_powergating_state(void *handle,
 static int vcn_v2_5_pause_dpg_mode(struct amdgpu_device *adev,
 				int inst_idx, struct dpg_pause_state *new_state);
 static int vcn_v2_5_sriov_start(struct amdgpu_device *adev);
+static void vcn_v2_5_set_ras_funcs(struct amdgpu_device *adev);
 
 static int amdgpu_ih_clientid_vcns[] = {
 	SOC15_IH_CLIENTID_VCN,
@@ -100,6 +102,7 @@ static int vcn_v2_5_early_init(void *handle)
 	vcn_v2_5_set_dec_ring_funcs(adev);
 	vcn_v2_5_set_enc_ring_funcs(adev);
 	vcn_v2_5_set_irq_funcs(adev);
+	vcn_v2_5_set_ras_funcs(adev);
 
 	return 0;
 }
@@ -1930,3 +1933,71 @@ const struct amdgpu_ip_block_version vcn_v2_6_ip_block =
 		.rev = 0,
 		.funcs = &vcn_v2_6_ip_funcs,
 };
+
+static uint32_t vcn_v2_6_query_poison_by_instance(struct amdgpu_device *adev,
+			uint32_t instance, uint32_t sub_block)
+{
+	uint32_t poison_stat = 0, reg_value = 0;
+
+	switch (sub_block) {
+	case AMDGPU_VCN_V2_6_VCPU_VCODEC:
+		reg_value = RREG32_SOC15(VCN, instance, mmUVD_RAS_VCPU_VCODEC_STATUS);
+		poison_stat = REG_GET_FIELD(reg_value, UVD_RAS_VCPU_VCODEC_STATUS, POISONED_PF);
+		break;
+	default:
+		break;
+	};
+
+	if (poison_stat)
+		dev_info(adev->dev, "Poison detected in VCN%d, sub_block%d\n",
+			instance, sub_block);
+
+	return poison_stat;
+}
+
+static bool vcn_v2_6_query_poison_status(struct amdgpu_device *adev)
+{
+	uint32_t inst, sub;
+	uint32_t poison_stat = 0;
+
+	for (inst = 0; inst < adev->vcn.num_vcn_inst; inst++)
+		for (sub = 0; sub < AMDGPU_VCN_V2_6_MAX_SUB_BLOCK; sub++)
+			poison_stat +=
+			vcn_v2_6_query_poison_by_instance(adev, inst, sub);
+
+	return poison_stat ? true : false;
+}
+
+const struct amdgpu_ras_block_hw_ops vcn_v2_6_ras_hw_ops = {
+	.query_poison_status = vcn_v2_6_query_poison_status,
+};
+
+static struct amdgpu_vcn_ras vcn_v2_6_ras = {
+	.ras_block = {
+		.hw_ops = &vcn_v2_6_ras_hw_ops,
+	},
+};
+
+static void vcn_v2_5_set_ras_funcs(struct amdgpu_device *adev)
+{
+	switch (adev->ip_versions[VCN_HWIP][0]) {
+	case IP_VERSION(2, 6, 0):
+		adev->vcn.ras = &vcn_v2_6_ras;
+		break;
+	default:
+		break;
+	}
+
+	if (adev->vcn.ras) {
+		amdgpu_ras_register_ras_block(adev, &adev->vcn.ras->ras_block);
+
+		strcpy(adev->vcn.ras->ras_block.ras_comm.name, "vcn");
+		adev->vcn.ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__VCN;
+		adev->vcn.ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__POISON;
+		adev->vcn.ras_if = &adev->vcn.ras->ras_block.ras_comm;
+
+		/* If don't define special ras_late_init function, use default ras_late_init */
+		if (!adev->vcn.ras->ras_block.ras_late_init)
+			adev->vcn.ras->ras_block.ras_late_init = amdgpu_ras_block_late_init;
+	}
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.h b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.h
index e72f799ed0fd..1c19af74e4fd 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.h
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.h
@@ -24,6 +24,12 @@
 #ifndef __VCN_V2_5_H__
 #define __VCN_V2_5_H__
 
+enum amdgpu_vcn_v2_6_sub_block {
+	AMDGPU_VCN_V2_6_VCPU_VCODEC = 0,
+
+	AMDGPU_VCN_V2_6_MAX_SUB_BLOCK,
+};
+
 extern const struct amdgpu_ip_block_version vcn_v2_5_ip_block;
 extern const struct amdgpu_ip_block_version vcn_v2_6_ip_block;
 
-- 
2.25.1

