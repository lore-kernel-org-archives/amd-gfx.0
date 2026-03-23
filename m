Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEA7FD58CBF
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 23:12:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61EA210E046;
	Mon, 23 Mar 2026 23:12:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aXokHi87";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012035.outbound.protection.outlook.com [40.107.209.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D77D310E046
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 23:12:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RTmUsBanT0Jj/dVlXpwN3TtO2z1kCZAFOW53WTRrnLZMsmZOS9+9MbCvORr45BsAv89KCSEli9evD3bYfTYq0ZuGlnlV1+AHy+qQ22fFozWLZb+t4LRSYuEA4A51n8M1/4ddOSsj4s+4RHjlL4aGrtDffImPBXUcm5s22ZVQMvX2EVkjk0//kHGEU4+TXTpul4XFJisIA3N0WQA9hwTUuTtsV0d63X18+JQ496mprlD2TG2lj+TKC/Lgbzd5mH6FkPc5tEGwX5bKZyiOau908WegOEDwolEeNaW1/WbSgl135UwovDsFXWiqX5XWp8dFgmLhvNBWDGid8jtDQ2aaGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DPwVyIWSp0zbagwhQatQATzWW+PxN8Dy5ZeLef9DaaY=;
 b=X5PFnbyN69ybYPqKWaAx5TvIl1uhZ3HBhUIWYw5xKx0MyTJkHnkJ+TkmcQO9uWVo9+cK6boBYcO58IwlsBfXYKOBQ2T16p+/u1uXE18s4JEor7wlUXJsyehU0QadjNWuWLlwIShfnedN7Zhu7uQ1+7M69CIM11NwyVOCZAm3ICPiUjcH60+m7ly1xBdfb+BKjfd2HNnJt9RL5otjR3vIJQutQ8/pUK3LiEpNX7M6sPSTa1WUCbsEXwIma9HjT4vOdLmw+CDTeVCC4rQ32Yy6epzxedNeTWiVYGacXlwm1oK3AYpUUAUZbu4gSNokXdZZvrDPEUI61yaUebxSxpNUYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DPwVyIWSp0zbagwhQatQATzWW+PxN8Dy5ZeLef9DaaY=;
 b=aXokHi87Sm4pMzWNv3KkI5iVXkm9vAOUzOd2eqSa/OhhUdUixxugv/hL3zMiAA/mly9GNCZbdMmB1UbCnh+U6/vvb3bXhQ6Y8/Q7YhRCFL2T4GFUv9QHmGGYdhAXWmngvbVejlwrUFEkqC7+uU9bboLEn2JOmhAuugFWu36fhjg=
Received: from SJ0PR03CA0215.namprd03.prod.outlook.com (2603:10b6:a03:39f::10)
 by BN7PPF9E4583E15.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6dc) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.12; Mon, 23 Mar
 2026 23:12:22 +0000
Received: from SJ5PEPF000001ED.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::aa) by SJ0PR03CA0215.outlook.office365.com
 (2603:10b6:a03:39f::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 23:12:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001ED.mail.protection.outlook.com (10.167.242.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 23:12:19 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 18:12:17 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH 1/4] drm/amd/pm: add variant func smu_cmn_send_msg() to unify
 msg sending logic
Date: Mon, 23 Mar 2026 19:12:03 -0400
Message-ID: <20260323231206.722067-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001ED:EE_|BN7PPF9E4583E15:EE_
X-MS-Office365-Filtering-Correlation-Id: f6e604d3-cb49-4981-c8bb-08de8931a217
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: AgA1nbKC9bHUslH8gavWo6ZfXWyoUb+eEyJ7pKaGAI9G1qBu+mwJ2r59kZ0H+MW3bMBsyNkh4n7Ct3z6qPApnAK+ZCYJUXE3kbVpkEsryUd49j0PgCTurPTfnYfyCCXBTi+bEaJdXYEt8/+7dbsg4hssp0n5oOL/a4hndJkntxlUDy38ecKK5elc8DKHZ6r7J8OFeSLkBL/c30jyvcgIsNY/uOsZQVrtUlrxR3RkeitT41n/1+pYzUA07QAEz0Sz3UGSWrNay/3IoXb0chdyIcrVDqYqKm79sxgVkVkUnEin1mh0wPHgI78dBp5VCNOUWBIaDfh6ua8iK9e4Wj9qVmNPE7JlYruF5JYgdCVX21+JRVVbMp3PsUSQpc1SziVDO9Z0qrCzdjeLkuL4gRxil1dbqe1pF+fFOV8XG1QC38qRwKnhHO3d4vwLXSD2aOs2c262Ayg56Xakk3BdXolW7jviucS2wi/3+yExgSbsrQsd/s1YJ0fKIaemLCNZwillhbLI/L8sdW694r57BZa5SD73k2t8FsYwF8qVfXdnhL2wiZnBbQQb7V6brqLZgLkWUL8wlqVOMibgksY+jcp6qWYvr9H9/+qrm8HoDIYwyj9EZXT7Pc+3rNrca0thhsZ0VCx4kWI+3oEnfJuCGvGLjoklq+aFBde0TL13LbSZ1tGOKpF5+ImOD21OOsYAsJ3OlHr+JxsIVmCvArmDRg0LYb0iBUQdFmSG2c+2NrlXE9vyCu+/UeJZySQQPkuZbEGrXfAsj2rgvOUgtDef0tF5ng==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iienYPH2Ppfs4BMxwlUi4Yr2y6Cr/hwdKfe5fYXkUqgpPiDPArav687mGDOKiucMMVmWvf6pyhxyP6JcQchN309Mh0+HVTgMZK0zXhI9zb0FLBCxo1vxAt/eGfK8CP485KZtL3LRQH6VQt/3puuoFTgJxNGZdhD+TeKQzXJHfpcascQAa+5bGR9E2fLEcQYS9mYUdg/EZF1qb5z6Bs31cKXmixELKMIIP6Xc5ZJFtOinIJg4G0ofN7KR2gt+WcQp7CvdnSKaB4PqtKweZEIXMmZ0W23cQb33JnhPjMr3sdrr2qWyoejASshYzPIGb70c3Z2AGzGINjb7F/FLM1Mm3sa/YMmm5NAedcZDP3sq7FoRYTCa2e7fL1liMcBvb/urS3laPgiqPsbfX8JT5PSS+D9T81Z5bJd+1SPOLpgBpAdcrYc3yrM1QOASa2wVH8U5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 23:12:19.8262 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6e604d3-cb49-4981-c8bb-08de8931a217
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF9E4583E15
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
index 7bd8c435466a..480d91d88957 100644
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
index b76e86df5da7..5c14ed9ed9b4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -210,6 +210,28 @@ int smu_cmn_dpm_pcie_gen_idx(int gen);
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

