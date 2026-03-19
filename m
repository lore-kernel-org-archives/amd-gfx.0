Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9400B1088E64
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Mar 2026 02:09:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 300FC10E7ED;
	Thu, 19 Mar 2026 02:09:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HFVdq/ZH";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011068.outbound.protection.outlook.com [52.101.62.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B71FA10E7ED
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Mar 2026 02:09:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LqK87OZdZdJ+D77u6lauuXiQqs7bfTp9+doCZNlIJpzS6xQPrR1kNNsxRAvkirzoKZLxPgqbErZ2VxkRIFBEmBJZ712ytHGCM2oytzZfDsQ9ipwWRcng/E45U8+2AjYkX2tWMMySO9fxqpZHFNE9YRCH5HGIuQ7dg4RQizaK508nOyKraC/Qy/5qtxr+eaMBgZScyg3VCP2JzV42eZBaTf/DnYprGBR9gBsD7/Tey497cCl4geMI+ccM6vJobAVacsk4GA+midGqCN95HsX64tvt+aXBEWSIT1NocLvcWQNlamshQNqLjz/sO8IgFmzToSNJaG43JdVs5OZ/ttYkvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s85129RY8674eIBDMSgBDSSXWDY3w9hZbb3X/XBn1Yc=;
 b=j2ijeKXPE4NDfGnrlu0tkxPzV99TtnOj0XNptfkVrqGrF9hEdiiDL9hKzKctb9OJ8mvErqROAGxJWvC0GGvMtu8cgG+PeZ9C/EGBZ28bbtt/lWh4D4+7soKGds0Rh6qkgM9qgi+cQlCXZWU/gMEjBqr2MFhARl1J9iBlDbMTVznlnhMJcqDqDCIucOcu1CVouD/ZpBzOsrVlumDFf/kmoh9RVSlXy0SgzITKP+1rORPgdHjKBj7gwupGBxTxP94r4DuWkhwSKtfTnrDpw/ZtH5EOmG8gUQF96smTxAOhqHHqt0TKKbVlNvJB9880Pg/211TICZdHlPYOLwuRZhS8Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s85129RY8674eIBDMSgBDSSXWDY3w9hZbb3X/XBn1Yc=;
 b=HFVdq/ZH16G6hRCx0vPhoRyG2O4QmRYxYoA3ltmDhT2mZSx+6hcE5ZWou3MlZ6buag/y1We1uK60AlaowPbQPrxVuwpK/U6Sbu7QP31E9rehlI0KlsZ/fbzN8fEzg7HlzcrUN+gxLmweq6HO78EwDj/nSPYqKKFM0I5oYzH2+/s=
Received: from CH2PR10CA0009.namprd10.prod.outlook.com (2603:10b6:610:4c::19)
 by BY5PR12MB4210.namprd12.prod.outlook.com (2603:10b6:a03:203::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 02:09:27 +0000
Received: from CH1PEPF0000AD7A.namprd04.prod.outlook.com
 (2603:10b6:610:4c:cafe::f6) by CH2PR10CA0009.outlook.office365.com
 (2603:10b6:610:4c::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Thu,
 19 Mar 2026 02:08:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7A.mail.protection.outlook.com (10.167.244.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Thu, 19 Mar 2026 02:09:27 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Mar
 2026 21:09:25 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH 1/3] drm/amd/pm: add variant func smu_cmn_send_msg() to unify
 msg sending logic
Date: Wed, 18 Mar 2026 22:09:08 -0400
Message-ID: <20260319020910.2620721-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7A:EE_|BY5PR12MB4210:EE_
X-MS-Office365-Filtering-Correlation-Id: b821abe9-eec4-4dff-76ed-08de855c8c85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 6Kaft82PhvldF+x0/stoN6MPrThp5+0lEdC+FCxnrhZO6rPlJgQFzg20A9MseIqFIaqyp3klGk/ZetE6Vwgn0giZE1wLZ4iSfSao+6CGdc40y8RgJ1sjI3k+DxF9tmH3BA/97+2lbr02LX6i2xfq0qukFxctBFfv17zafebFEKVQK3euAWg+fhCW3FHJcMmrNXaBVJrUQ9Jbv8YKN1y6ihMmlr8lOM3/h1IZ5GBEMkrcxfT5rbGgaIzpvcsY/RdObFMfROU0ubC4V4e1/HBRm0CTgzh1RTQy+YsdPZnB9ojVoi5+S9qQ/emOjgociPoLu/aKQFKHarAN0yhTzsM1wtLLnk2ht4bzm7YNkiQ6Yt0JOHI/TtJ/zALuwztu7XwNIET/gXViwFivL5M1X2a1YQT8nkPRC1ZquzKHEhZzNVOlv/oyybjWe8F6FvEZSN2cyHgohdp8Ldg2LmgZj7vJaav1YBv4tK9PUCguRKoIjb4jGMjlx7dXPyifXnkE5uNnR9pyRrQdx4fAwxGRLuH9r+bvMIfyvyoRYSZ+BUVa4w+j6Nq5EQeMnXLgZcj7pQFhWYkpoExTHYj3d/ywhPWeiYvq/lChqJr7w2cxAifzNzR31itpUM7prpzR7IzZ3PBo3DcsyGgIh6oiv1wxQN4+sZjdbeXu7IFsp4cy0wlgCxW8djgAMOogztLlcZ5p1XjTxlSl7/s+ukWs81RaaIS3PkcqyIMX/UEVMiEoMe917w8f/XmPPJ8bbWp+r9SGWAvaBsJTch9YtwsGVBAaHOoq8g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WY9RqMUWj0yoWOEekXy5wCDclSeUTRviTLF9uP1oA8D9efR2JMDlpu4Dg9FqPuAmsKytHPv0dDbiS0xGsh/QhKEHa9SuEDwEtVHfGnnYm39GtXkkCiapPPoZds1fRkoSNPvRoItZA61/BTpRFz0gfMwd8xqpf8kLcCZcAojI+0m2nD9MdwEBYk+6/UtEZzBXKfhJ08/IVyUs4eYAuE9Rk0jKCi55yKE0eqD7S4M8vQDrT0RI+sY96RI8E2x7OYlM7DkllKjfd25I4OJcj8uuW2+hVh+XQSW+/RiqxFGF+iAJtd2oN4seV4+vxJlxEM/GZaeWnz6wTyWlfiXitFlBWbNxxUzDj/WNObw/h3cEVDfTzyGKo9nsgXQk91b/HA9PiWobGkY+SbyP7WDDDLie/j7V1MCCqo+rtgLEv4LS/IUFyPofnaTIs2UaBP1LOfG0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 02:09:27.3994 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b821abe9-eec4-4dff-76ed-08de855c8c85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4210
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

add variant func smu_cmn_send_msg() to unify smu message sending logic,
and enabling support for newer ASIC interfaces such as SMU v15 and upcoming devices.
(support multi-param/multi-response, standardize code across all smu code layers)

The smu_cmn_send_msg() API will expand to the following prototypes based on the number of input parameters.
e.g:
1. r = smu_cmn_send_msg(smu, msg_id);
2. r = smu_cmn_send_msg(smu, msg_id, &read_arg);
3. r = smu_cmn_send_msg(smu, msg_id, param, &read_arg);
4. r = smu_cmn_send_msg(smu, msg_id,
			num_param, [param0, param1, ...],
			num_response, [arg0, arg1, ...]

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 79 ++++++++++++++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h | 22 +++++++
 2 files changed, 101 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index a644579903f4..bc2ac5ae6a48 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -193,6 +193,85 @@ int smu_cmn_send_smc_msg(struct smu_context *smu,
 					       read_arg);
 }
 
+static inline int smu_cmn_send_msg_internal(struct smu_context *smu, enum smu_message_type msg,
+					    int num_in_args, u32 *in_args,
+					    int num_out_args, u32 *out_args)
+{
+	struct smu_msg_ctl *ctl = &smu->msg_ctl;
+	struct smu_msg_args args = { 0 };
+	int ret;
+
+	if (msg >= SMU_MSG_MAX_COUNT)
+		return -EINVAL;
+
+	if ((num_in_args >= ARRAY_SIZE(args.args) || num_in_args < 0) ||
+	    (num_out_args >= ARRAY_SIZE(args.out_args) || num_out_args < 0))
+		return -EINVAL;
+
+	if ((num_in_args > 0 && !in_args) || (num_out_args > 0 && !out_args))
+		return -EINVAL;
+
+	if (!ctl->ops || !ctl->ops->send_msg)
+		return -EOPNOTSUPP;
+
+	args.msg = msg;
+	args.num_args = num_in_args;
+	args.num_out_args = num_out_args;
+	args.flags = 0;
+	args.timeout = 0;
+
+	if (num_in_args)
+		memcpy(&args.args[0], in_args, num_in_args * sizeof(u32));
+
+	ret = ctl->ops->send_msg(ctl, &args);
+	if (ret)
+		return ret;
+
+	if (num_out_args)
+		memcpy(out_args, &args.out_args[0], num_out_args * sizeof(u32));
+
+	return ret;
+}
+
+/*
+ * NOTE: To ensure compatibility with the behavioral logic of the legacy API,
+ * it is required to explicitly set the parameter "param" to 0 when invoking
+ * the msg_0 and msg_1 functions.
+ * */
+
+int __smu_cmn_send_msg_0(struct smu_context *smu, enum smu_message_type msg)
+{
+	return __smu_cmn_send_msg_2(smu, msg, 0, NULL);
+}
+
+int __smu_cmn_send_msg_1(struct smu_context *smu, enum smu_message_type msg,
+			 u32 *read_arg)
+{
+	return __smu_cmn_send_msg_2(smu, msg, 0, read_arg);
+}
+
+int __smu_cmn_send_msg_2(struct smu_context *smu, enum smu_message_type msg,
+			 u32 param, u32 *read_arg)
+{
+	int ret;
+
+	if (read_arg)
+		ret = smu_cmn_send_msg_internal(smu, msg, 1, &param, 1, read_arg);
+	else
+		ret = smu_cmn_send_msg_internal(smu, msg, 1, &param, 0, NULL);
+
+	return ret;
+}
+
+int __smu_cmn_send_msg_4(struct smu_context *smu, enum smu_message_type msg,
+			 int num_in_args, u32 *in_args,
+			 int num_out_args, u32 *out_args)
+{
+	return smu_cmn_send_msg_internal(smu, msg,
+					 num_in_args, in_args,
+					 num_out_args, out_args);
+}
+
 int smu_cmn_send_debug_smc_msg(struct smu_context *smu,
 			 uint32_t msg)
 {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index e4d282d8bcae..f48356c22dbb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -209,6 +209,28 @@ int smu_cmn_dpm_pcie_gen_idx(int gen);
 int smu_cmn_dpm_pcie_width_idx(int width);
 int smu_cmn_check_fw_version(struct smu_context *smu);
 
+int __smu_cmn_send_msg_0(struct smu_context *smu, enum smu_message_type msg);
+int __smu_cmn_send_msg_1(struct smu_context *smu, enum smu_message_type msg,
+			 u32 *read_arg);
+int __smu_cmn_send_msg_2(struct smu_context *smu, enum smu_message_type msg,
+			 u32 param, u32 *read_arg);
+int __smu_cmn_send_msg_4(struct smu_context *smu, enum smu_message_type msg,
+			 int num_in_args, u32 *in_args,
+			 int num_out_args, u32 *out_args);
+
+/*
+* The smu_cmn_send_msg() API will expand to the following prototypes based on the number of input parameters.
+* e.g:
+* 1. r = smu_cmn_send_msg(smu, msg_id);
+* 2. r = smu_cmn_send_msg(smu, msg_id, &read_arg);
+* 3. r = smu_cmn_send_msg(smu, msg_id, param, &read_arg);
+* 4. r = smu_cmn_send_msg(smu, msg_id,
+*			  num_param, [param0, param1, ...],
+*			  num_response, [arg0, arg1, ...]
+*/
+#define smu_cmn_send_msg(smu, msg, ...) \
+	CONCATENATE(__smu_cmn_send_msg_, COUNT_ARGS(__VA_ARGS__))(smu, msg, ##__VA_ARGS__)
+
 /*SMU gpu metrics */
 
 /* Attribute ID mapping */
-- 
2.47.3

