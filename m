Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53415C433FE
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Nov 2022 00:36:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3471810E095;
	Tue,  8 Nov 2022 00:36:00 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E118A10E095
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Nov 2022 00:35:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UJAbrFaQzmg8HinPZgQURlee2sEMiVZpWVPkO/VtvEPM4cXlBgXJ7UnJPnpLX9L2rRmG8z5ggjg5dxvS8NwfnEiU0psCng699XdRtpT2QD1WZzz/tMXvRSeugRQg+i0I4vs0aICq/MELBV/ecyLs7WKozc/z2OAFdsZlie4cvNJdDYTe0o3ZvOydbljxKVHLiMKVOd9YspfxskMAUKyjMeCFiS2uecpEkj8aa9Nnly3MxX/cqj72UK0ZglXnNs+Rp2VEHihRSVbJoW869TASuWnJ69n+YJmXOIgPFrsfs1ClsbQPc8vJ/eN2wM2uQBrV9D4SWdm6JinITGYSy9inUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/DR26UPxYbxz8sYr7tqASpnzVlnMP/WLvOW0tfHW2Ig=;
 b=AROzQtTg53YXZ07az7/nzYkpSWpVfvTwCv6vTYgL4LqZyZqb73nEOCY4Xme5V0RXj1qSMf4Si5qjBIW6W/ZafNkQehobJgowIKLXDLcq0uETYWcM4edzC04/NSelXolACCyZIxJZUf/VHOI1ZSW/VwYuUsi4CwTDg5AvNBQOu+dsdX2N05RfMsmUuIAev7FWa3JEWj3fpAxdLaw1r5Gm55C/2aAivrPpN8660effVOtxKdyQBCYXliUoTTKLh8caAr7c42eFlpgstB0uWjHI97Dz4Rrq/M387TDGtirmDm4P/QQYfSSzkg4m+RXdYjSYiRPsCa7eBUaQSa6nQ7MxHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/DR26UPxYbxz8sYr7tqASpnzVlnMP/WLvOW0tfHW2Ig=;
 b=tX8npe4tI/M0YZTvdpsfGe8UoMuFB4Pep0SYgCDVFvRfVYk2xW5WQ9iyBaLiixwAvlDFAjTkKgV7m4oVGluYzdJ/eLps0SsLHvVzViXDrf7YmI10lHx62Ruqe8T2uN8N9nygP2GsldKJuDVL9IatqG+WDrpc+IZlufGGSDXFZzA=
Received: from BN0PR04CA0083.namprd04.prod.outlook.com (2603:10b6:408:ea::28)
 by BL1PR12MB5945.namprd12.prod.outlook.com (2603:10b6:208:398::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Tue, 8 Nov
 2022 00:35:53 +0000
Received: from BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ea:cafe::ba) by BN0PR04CA0083.outlook.office365.com
 (2603:10b6:408:ea::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26 via Frontend
 Transport; Tue, 8 Nov 2022 00:35:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT004.mail.protection.outlook.com (10.13.176.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Tue, 8 Nov 2022 00:35:53 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 7 Nov
 2022 18:35:53 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 7 Nov
 2022 18:35:52 -0600
Received: from kenneth-u2004-vm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.31 via
 Frontend Transport; Mon, 7 Nov 2022 18:35:51 -0600
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amd/pm: enable mode1 reset on smu_v13_0_10
Date: Tue, 8 Nov 2022 08:35:43 +0800
Message-ID: <20221108003543.2912161-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT004:EE_|BL1PR12MB5945:EE_
X-MS-Office365-Filtering-Correlation-Id: 965f06e7-68e5-480b-4729-08dac121316d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e68jGI7qW1VOg7auTGJYWgA2l+/znzYHRKshVzl9lvO5Rze4Rx5yaPYcxrvnnxbD46R9zQQzbOgehm2XejbIlpD45IaCbiyBnE3ax48pxR/9oj6/HN5Zab9e5XB5p8qpS1Ac9XRHxMdUQie7vIIcT7pvuvyrJe4L0lBNWjxLV6xg2EPKYpJ3nq3CkX7tMqook9ntKcdyycwBkE7wtdmGD1QiA8Xr6bsvY/SWDRa+GuJv7cnNR5dqniay+MkbFY27ZkRCsdOOCCHWAjhcS4bfUke1jK3fvt4p+CWqxYS+gMnHUY0plNf7UwImF22S/6vGaj2if0VHq5jq6V+13ODFCW6BFAPD1wfRWepXIbhZ5deDFWS+8dWc4NgM1sakI4I+/MLw/pradboF+0KekrQKLrNYaJ8jYfT6lFCx6NXYfnFcEj7PVxu/HdyqCji61bXXsp12/Pd9IP5RCdCMNiIoVsQU4n341E8tm1mH/ugljRzvvhTPRWgF8qQjMKmVN9hhBW1jzkij9Qe/XzKPmP4mG/OZanVypj82nSyZ/PB4gNymebYqawm3Aq++wNvV9qlfz+zycJaYxPRc9O6qliR9b9zPoDTGSp+5Ee9u17UwEZ42QDaV/DnqUkHlhrlXYvkdTHsPoIVGY382G/dQywjAevKKZeFRp9us3oS+A59EPRlr1Aa5Dov4aehXH/I5rOM6GcEuohLfNDqA9bQElBfqRRpILjYardvLPlYErotdojlgboE8Ydrw07Ssg5rSaeBKv8riWv07UzWX6COnIJag71Uhy0BRqfe/IXpwcM4+lHAYUQtM0iAMwO9f+17IzO7L
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(39860400002)(136003)(346002)(451199015)(46966006)(36840700001)(40470700004)(26005)(336012)(44832011)(8676002)(6666004)(316002)(82310400005)(36860700001)(82740400003)(70206006)(86362001)(7696005)(6916009)(478600001)(70586007)(8936002)(41300700001)(81166007)(356005)(40480700001)(2906002)(1076003)(186003)(5660300002)(4326008)(40460700003)(2616005)(426003)(47076005)(36756003)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 00:35:53.3204 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 965f06e7-68e5-480b-4729-08dac121316d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5945
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
Cc: Kenneth Feng <kenneth.feng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

enable mode1 reset and prioritize debug port on msu_v13_0_10
as a more reliable message processing

v2 - move mode1 reset callback to smu_v13_0_0_ppt.c

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c            |  1 +
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  4 ++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 53 ++++++++++++++++++-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 18 +++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |  3 ++
 5 files changed, 77 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 1d4013ed0d10..b258e9aa0558 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -322,6 +322,7 @@ soc21_asic_reset_method(struct amdgpu_device *adev)
 	switch (adev->ip_versions[MP1_HWIP][0]) {
 	case IP_VERSION(13, 0, 0):
 	case IP_VERSION(13, 0, 7):
+	case IP_VERSION(13, 0, 10):
 		return AMD_RESET_METHOD_MODE1;
 	case IP_VERSION(13, 0, 4):
 		return AMD_RESET_METHOD_MODE2;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index e2fa3b066b96..1bc26e93a83c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -568,6 +568,10 @@ struct smu_context
 	u32 param_reg;
 	u32 msg_reg;
 	u32 resp_reg;
+
+	u32 debug_param_reg;
+	u32 debug_msg_reg;
+	u32 debug_resp_reg;
 };
 
 struct i2c_adapter;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 29529328152d..588527310188 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -70,6 +70,26 @@
 
 #define MP0_MP1_DATA_REGION_SIZE_COMBOPPTABLE	0x4000
 
+#define mmMP1_SMN_C2PMSG_66                                                                            0x0282
+#define mmMP1_SMN_C2PMSG_66_BASE_IDX                                                                   0
+
+#define mmMP1_SMN_C2PMSG_82                                                                            0x0292
+#define mmMP1_SMN_C2PMSG_82_BASE_IDX                                                                   0
+
+#define mmMP1_SMN_C2PMSG_90                                                                            0x029a
+#define mmMP1_SMN_C2PMSG_90_BASE_IDX                                                                   0
+
+#define mmMP1_SMN_C2PMSG_75                                                                            0x028b
+#define mmMP1_SMN_C2PMSG_75_BASE_IDX                                                                   0
+
+#define mmMP1_SMN_C2PMSG_53                                                                            0x0275
+#define mmMP1_SMN_C2PMSG_53_BASE_IDX                                                                   0
+
+#define mmMP1_SMN_C2PMSG_54                                                                            0x0276
+#define mmMP1_SMN_C2PMSG_54_BASE_IDX                                                                   0
+
+#define DEBUGSMC_MSG_Mode1Reset	2
+
 static struct cmn2asic_msg_mapping smu_v13_0_0_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(TestMessage,			PPSMC_MSG_TestMessage,                 1),
 	MSG_MAP(GetSmuVersion,			PPSMC_MSG_GetSmuVersion,               1),
@@ -1763,6 +1783,35 @@ static int smu_v13_0_0_set_df_cstate(struct smu_context *smu,
 					       NULL);
 }
 
+static int smu_v13_0_0_mode1_reset(struct smu_context *smu)
+{
+	int ret = 0;
+	struct amdgpu_device *adev = smu->adev;
+
+	if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 10))
+		ret = smu_cmn_send_debug_smc_msg(smu, DEBUGSMC_MSG_Mode1Reset);
+	else
+		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_Mode1Reset, NULL);
+
+	if (!ret)
+		msleep(SMU13_MODE1_RESET_WAIT_TIME_IN_MS);
+
+	return ret;
+}
+
+static void smu_v13_0_0_set_smu_mailbox_registers(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+
+	smu->param_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_82);
+	smu->msg_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_66);
+	smu->resp_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_90);
+
+	smu->debug_param_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_53);
+	smu->debug_msg_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_75);
+	smu->debug_resp_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_54);
+}
+
 static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
 	.get_allowed_feature_mask = smu_v13_0_0_get_allowed_feature_mask,
 	.set_default_dpm_table = smu_v13_0_0_set_default_dpm_table,
@@ -1830,7 +1879,7 @@ static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
 	.baco_enter = smu_v13_0_baco_enter,
 	.baco_exit = smu_v13_0_baco_exit,
 	.mode1_reset_is_support = smu_v13_0_0_is_mode1_reset_supported,
-	.mode1_reset = smu_v13_0_mode1_reset,
+	.mode1_reset = smu_v13_0_0_mode1_reset,
 	.set_mp1_state = smu_v13_0_0_set_mp1_state,
 	.set_df_cstate = smu_v13_0_0_set_df_cstate,
 };
@@ -1844,5 +1893,5 @@ void smu_v13_0_0_set_ppt_funcs(struct smu_context *smu)
 	smu->table_map = smu_v13_0_0_table_map;
 	smu->pwr_src_map = smu_v13_0_0_pwr_src_map;
 	smu->workload_map = smu_v13_0_0_workload_map;
-	smu_v13_0_set_smu_mailbox_registers(smu);
+	smu_v13_0_0_set_smu_mailbox_registers(smu);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index e4f8f90ac5aa..768b6e7dbd77 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -233,6 +233,18 @@ static void __smu_cmn_send_msg(struct smu_context *smu,
 	WREG32(smu->msg_reg, msg);
 }
 
+static int __smu_cmn_send_debug_msg(struct smu_context *smu,
+			       u32 msg,
+			       u32 param)
+{
+	struct amdgpu_device *adev = smu->adev;
+
+	WREG32(smu->debug_param_reg, param);
+	WREG32(smu->debug_msg_reg, msg);
+	WREG32(smu->debug_resp_reg, 0);
+
+	return 0;
+}
 /**
  * smu_cmn_send_msg_without_waiting -- send the message; don't wait for status
  * @smu: pointer to an SMU context
@@ -386,6 +398,12 @@ int smu_cmn_send_smc_msg(struct smu_context *smu,
 					       read_arg);
 }
 
+int smu_cmn_send_debug_smc_msg(struct smu_context *smu,
+			 uint32_t msg)
+{
+	return __smu_cmn_send_debug_msg(smu, msg, 0);
+}
+
 int smu_cmn_to_asic_specific_index(struct smu_context *smu,
 				   enum smu_cmn2asic_mapping_type type,
 				   uint32_t index)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index 1526ce09c399..f82cf76dd3a4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -42,6 +42,9 @@ int smu_cmn_send_smc_msg(struct smu_context *smu,
 			 enum smu_message_type msg,
 			 uint32_t *read_arg);
 
+int smu_cmn_send_debug_smc_msg(struct smu_context *smu,
+			 uint32_t msg);
+
 int smu_cmn_wait_for_response(struct smu_context *smu);
 
 int smu_cmn_to_asic_specific_index(struct smu_context *smu,
-- 
2.25.1

