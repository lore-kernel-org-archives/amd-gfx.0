Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7073D1489F
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 04:50:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55BE610E68D;
	Thu,  8 Jan 2026 04:50:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GeRVDd/r";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012020.outbound.protection.outlook.com
 [40.107.200.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D577710E68D
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 04:50:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JYDEf1zF+PPI1As/PCYdwok2etFIBZ5N9wmBHH5VC63ic7T+L8raGxrR2zSxzenP7lgdPqG2PMWm+nn3XYRoIhi59F70aZWUM9553pO/XfLvGVWOiozK3RWuWdJynVjZImwMhHeI4Qi7LsJcufxBp9gL4Ip9s3j2HiuTvfxyX+Z4ewAm2AgWzWUnapLIQOEq6O1okGn7WomiRT+CKYKpfBGVZYA3Vn+KxcIwWabXmFDmiM/HNcvn8SJyuXQh3bXto956st537A/cr1uAcIfAx/pXHRy8TOAw0hmrKv+kvrkVnqhkIVfQXHHju9vtMtT1VDWF7UjRRYtNmaOMw2oTXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AUop/NCxpElOka0hGI/kBESUsPczhDHLLzGQthjoCsM=;
 b=G3bCnXa5mOONaw/o0v9S2lhDybo2sYEeZR58xPzeiTKRKjUoTaw4ZmfW7cmPCNGrFpP5FmoV/uWR4sgEE1a6kCMy73bkxFiinvHvHUPOnsxwrIO0lorVONKuYvEhneTlAbWdTg7iBZW61jvWKd1PFuYmdnv6b1LoFYlZuwvXUrKcjSKjYZM/yDmoHqsgobX1S2r1nzx2SQHtKbrayOFa97XxZMrspUehwHKV/U6x5fwVS5rpkHmT80rCfduiHgg/989czLyhUGX8Xg56DYvd+hqXNBxX5DB7jb59YJkrszd7Te2lnVmpTO3KDO/BGD47T6i0DtQxvbkFO8Lgg1WIEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AUop/NCxpElOka0hGI/kBESUsPczhDHLLzGQthjoCsM=;
 b=GeRVDd/rBexro3uEZnJzqLDnx+Db6dGLP/zXatUzOQit9cCCrho2X1VYa4FseidNcIqsskD/xRv/LWBcEnFACGjDfUL6mUqHrlHGViu+zsd2TwnuQMu1j9lbICQHEF5wX7KqFRJkIITlhd9NZOouY2rFvcVIXWOK14D4CSaTMKQ=
Received: from CH0PR03CA0320.namprd03.prod.outlook.com (2603:10b6:610:118::25)
 by SA1PR12MB8920.namprd12.prod.outlook.com (2603:10b6:806:38e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 04:50:08 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:610:118:cafe::c8) by CH0PR03CA0320.outlook.office365.com
 (2603:10b6:610:118::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.2 via Frontend Transport; Thu, 8
 Jan 2026 04:49:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 04:50:07 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 7 Jan
 2026 22:50:04 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>, Asad Kamal
 <asad.kamal@amd.com>
Subject: [PATCH v3 23/24] drm/amd/pm: Add debug message callback
Date: Thu, 8 Jan 2026 10:17:39 +0530
Message-ID: <20260108044839.4084279-24-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260108044839.4084279-1-lijo.lazar@amd.com>
References: <20260108044839.4084279-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|SA1PR12MB8920:EE_
X-MS-Office365-Filtering-Correlation-Id: 69acb3bf-4d4f-408c-50f3-08de4e7165a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ec8U/d0uCniN7Wl5y/HTB1NL2fR8KSvSX6AbWooYQbzQPlB5oua2XvR7zEoL?=
 =?us-ascii?Q?gLFM6g50QGwoyZ9LuWrniSri5zheyWQHYxxOhR+cPPy7TpZfJ2SdhgPR4vgt?=
 =?us-ascii?Q?sjBMGzEsz5hViX4Dxuq1c4JnRQQMWj1cg3r0H3OyVEBeBTy7hFaZHHuLeLtu?=
 =?us-ascii?Q?6qbDVwnfgbkI9x9TFedRfBceisxk4ES6j3l4LFnBSRXAuE2ds+MRpTFb/7WR?=
 =?us-ascii?Q?S3zJ29BAbX48vEr19ggMCG0wvX9OVLDl2KBNTmhxZv9EdfHCFqpM/HHq2OzL?=
 =?us-ascii?Q?qRt3WeNqKqn0nlQgqHbYoHpoCCfNIHT2653xOi2OB3kn+zGXrwk0Um/l24EX?=
 =?us-ascii?Q?PM9TTkjU9/8yZ0uLmhXGWJl/sQCRn1BlhAhLnHFF72xxn+ePiPriEXOiMIeP?=
 =?us-ascii?Q?7G2/fNlrsmaNvbAvMAisZhywYzilhm9fy51b6yxPgX2+qgSMaGYYXPMV8SUc?=
 =?us-ascii?Q?RAmY+giAhctjEevPJ6ekN9FauAI1eVjfp1rE02aEDv95oPuKtxlBcdnRiO0R?=
 =?us-ascii?Q?1TOoEkFvAYeyOiOrGOTOGInFYDwdxaM8bihY0wZqJzlfP4cXY8zffVCKpJyP?=
 =?us-ascii?Q?vgUzoGPcQzp6KX5CMHlBilBxyFy5DHOZc5b/PvJrMTDnvl585bGSO8lbzbIQ?=
 =?us-ascii?Q?x5laO09JcxbVKSxRyDVbsrVwLGV5npIGXr5qJsYHhRgsqwh3OtLEsxv5iAQl?=
 =?us-ascii?Q?eols+djzLbp7FfdQXAml59/+jK5HLfAMXWNndk7o3KPoXWIOhZZJmnbg8GUR?=
 =?us-ascii?Q?T4cwBwkZ7+7ZSHexFMqhYFhwAVUW3/AEMXyxax8iWoaV6OTTV1PqANiW8gaG?=
 =?us-ascii?Q?z3dtuPDYyZeTcqnUrrCHwKvhhNP+XujJu6dcHu86CFFNSMY/Cunyj3peZy05?=
 =?us-ascii?Q?xtBk9ajJ01oNWprRmkw2eRQR2GvDHT4Et7/tTkhG2WaSg/f7+ARv+++mfzlk?=
 =?us-ascii?Q?3W84/cftdDaqKV/PCCR+9bwZAOvjDYL5hGAfOwziWlvegbIvoiLme1vCvW88?=
 =?us-ascii?Q?/juBxnTK4zK7ScVqcxYT20l+OujrrDA9iKksb6tA5tmx/8ey4iEuJUXog/CL?=
 =?us-ascii?Q?8Bw7hG+r88LNLrfma/VW2JwFKgCyPIXQaMjCjy/zpEVMeEtyuyeOp5WJVsrV?=
 =?us-ascii?Q?UFigtpNe9713zFzpiolteWeA/sVbNkwIoDi4O/PsxE0l/PDq5P1tuArsWL/z?=
 =?us-ascii?Q?C6ksoZb4E8A9A7/soPAvG9PHk9WnRoT5O6UrOcaLTa2P0exLOduSGNsDCEWd?=
 =?us-ascii?Q?j5TDmFDMPQ6mXnkSuHGPVVPmjw6F/s7F+AmtfcIDz1SbweMod1vUQjvmhs46?=
 =?us-ascii?Q?8IXb3+f9o/zVMDsy6oPpg0nhNDI19KTjfPCAboKyfeJTNbljpgNiOyvdXpUV?=
 =?us-ascii?Q?YJWY7Yu7A7dQxRryxOATyMlW5RonHiPOWx/bFhMZkpd8rHHFmOVGBywzFCQO?=
 =?us-ascii?Q?+JdJcb5/r/qiLXrKqVo29kPu0PhwvoTOh7N0m2qH4gMylPeU9GF24q9bs9Aa?=
 =?us-ascii?Q?tOr3itwEZl2B1woJFydUiMO8OsfymyljRGApSYNyGl9mY94l4mJ4npq/r6Pi?=
 =?us-ascii?Q?IXFwZZueWHtEapKqUlM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 04:50:07.5931 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69acb3bf-4d4f-408c-50f3-08de4e7165a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8920
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

Add callback in message control to send message through debug mailbox.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 12 +++++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 20 +++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index e88fdd65e1cd..84b50820a613 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -557,6 +557,9 @@ struct cmn2asic_mapping {
 #define SMU_MSG_FLAG_ASYNC	BIT(0) /* Async send - skip post-poll */
 #define SMU_MSG_FLAG_LOCK_HELD	BIT(1) /* Caller holds ctl->lock */
 
+/* smu_msg_ctl flags */
+#define SMU_MSG_CTL_DEBUG_MAILBOX	BIT(0) /* Debug mailbox supported */
+
 struct smu_msg_ctl;
 /**
  * struct smu_msg_config - IP-level register configuration
@@ -564,12 +567,18 @@ struct smu_msg_ctl;
  * @resp_reg: Response register offset
  * @arg_regs: Argument register offsets (up to SMU_MSG_MAX_ARGS)
  * @num_arg_regs: Number of argument registers available
+ * @debug_msg_reg: Debug message register offset
+ * @debug_resp_reg: Debug response register offset
+ * @debug_param_reg: Debug parameter register offset
  */
 struct smu_msg_config {
 	u32 msg_reg;
 	u32 resp_reg;
 	u32 arg_regs[SMU_MSG_MAX_ARGS];
 	int num_arg_regs;
+	u32 debug_msg_reg;
+	u32 debug_resp_reg;
+	u32 debug_param_reg;
 };
 
 /**
@@ -597,11 +606,13 @@ struct smu_msg_args {
  * @send_msg: send message protocol
  * @wait_response: wait for response (for split send/wait cases)
  * @decode_response: Convert response register value to errno
+ * @send_debug_msg: send debug message
  */
 struct smu_msg_ops {
 	int (*send_msg)(struct smu_msg_ctl *ctl, struct smu_msg_args *args);
 	int (*wait_response)(struct smu_msg_ctl *ctl, u32 timeout_us);
 	int (*decode_response)(u32 resp);
+	int (*send_debug_msg)(struct smu_msg_ctl *ctl, u32 msg, u32 param);
 };
 
 /**
@@ -617,6 +628,7 @@ struct smu_msg_ctl {
 	const struct smu_msg_ops *ops;
 	const struct cmn2asic_msg_mapping *message_map;
 	u32 default_timeout;
+	u32 flags;
 };
 
 struct stb_context {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 6b673eefc7b1..f639d3636d30 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -83,6 +83,25 @@ static const char *smu_get_message_name(struct smu_context *smu,
 
 #define SMU_RESP_UNEXP (~0U)
 
+static int smu_msg_v1_send_debug_msg(struct smu_msg_ctl *ctl, u32 msg, u32 param)
+{
+	struct amdgpu_device *adev = ctl->smu->adev;
+	struct smu_msg_config *cfg = &ctl->config;
+
+	if (!(ctl->flags & SMU_MSG_CTL_DEBUG_MAILBOX))
+		return -EOPNOTSUPP;
+
+	mutex_lock(&ctl->lock);
+
+	WREG32(cfg->debug_param_reg, param);
+	WREG32(cfg->debug_msg_reg, msg);
+	WREG32(cfg->debug_resp_reg, 0);
+
+	mutex_unlock(&ctl->lock);
+
+	return 0;
+}
+
 static int __smu_cmn_send_debug_msg(struct smu_context *smu,
 			       u32 msg,
 			       u32 param)
@@ -541,6 +560,7 @@ const struct smu_msg_ops smu_msg_v1_ops = {
 	.send_msg = smu_msg_v1_send_msg,
 	.wait_response = smu_msg_v1_wait_response,
 	.decode_response = smu_msg_v1_decode_response,
+	.send_debug_msg = smu_msg_v1_send_debug_msg,
 };
 
 int smu_msg_wait_response(struct smu_msg_ctl *ctl, u32 timeout_us)
-- 
2.49.0

