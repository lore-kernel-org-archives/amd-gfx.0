Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F6D6D1489F
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 04:49:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 433D910E2F0;
	Thu,  8 Jan 2026 04:49:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xp8q1+3z";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012009.outbound.protection.outlook.com [52.101.43.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A638410E2F0
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 04:49:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jyGsGls2Ynr5YTYUCcm84Iu5CNuyjLBkqOXAgaNveytGeYA6TmJlxSg+Rg0y8P593FwmRSHg5f4gNqEq7m6J8tYLJtUZlCzJ38MQEnX4MgF3pzyOqkmDee6irZoG0CSsRfL+ETiV6EJtNfrC8krx6+IkYdqB1BYaCLqOrVG0FIQb42EzUCVTYWtMNvFx98tJxHwdlTKJRzd7NsbyvYv1vb0jNpxJTq7Y7x02rJ0IX3NAVfOOi9+AG608VkrhhO5voWpKs2Xbf6knHCqsGyGAvejM6nzUmT9KKUafI0W3tN75l26iDyzWorEa3z6oXWsh/b1zDwZn/Di1P2QVnIQNjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+28ALM8cKAB3ITSOAlThPpIl0ifqeoR5LMF3u+2OBYY=;
 b=S3saQlvLI2jPB/02ric+XNeaqdrvhNAauZMpTH2UVoAZ3WNaqb85tlHXY9dGeFdsu2MnJpC1HXQkC42vVCvTryNYNLevIeJahFRPbr+6rwuvnmWCvzf4HIVNePckcqM9rmGsaOKp11k0WwEzSjSV3VJiMv2CL+Ve+LcxETvHK42vJ7xg7L8N9FrLggi/3IyCd7r266hbCkALMNIT459gJlz7M9a3DDsmoqO7qRg8UNlr9FGRwGClEcbpLjooyJhSjPaPS8X7z8rTYt6iN8Xp5QTipOjIazhRLSWQ/JTJaw5wPkncPUJgNcYCPT/Grj7gZFALRyVwwJm772t6vwqLzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+28ALM8cKAB3ITSOAlThPpIl0ifqeoR5LMF3u+2OBYY=;
 b=xp8q1+3zND9PXIFbYqv+zmkDgngbz9IrNDUMiCpQoN15dS4JQJTZWW99dnTGT5B9Sny2j7ZfsrH1mMVmRlO75wJW9ll8XpLYMtEbdffvHpuqD34vmriX9aurmB3RK1mUMKXUp23MBh6grM/7UmalWmSOwR8DH+lD64q+ZXEwSOk=
Received: from CH5P221CA0011.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::21)
 by DM4PR12MB6591.namprd12.prod.outlook.com (2603:10b6:8:8e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Thu, 8 Jan
 2026 04:49:14 +0000
Received: from DS2PEPF00003439.namprd02.prod.outlook.com
 (2603:10b6:610:1f2:cafe::6e) by CH5P221CA0011.outlook.office365.com
 (2603:10b6:610:1f2::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.3 via Frontend Transport; Thu, 8
 Jan 2026 04:49:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003439.mail.protection.outlook.com (10.167.18.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 04:49:13 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 7 Jan
 2026 22:49:11 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>, Asad Kamal
 <asad.kamal@amd.com>
Subject: [PATCH v3 01/24] drm/amd/pm: Add smu message control block
Date: Thu, 8 Jan 2026 10:17:17 +0530
Message-ID: <20260108044839.4084279-2-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003439:EE_|DM4PR12MB6591:EE_
X-MS-Office365-Filtering-Correlation-Id: a5f691ac-8dad-430b-0e4a-08de4e7145aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9NkFOn6wV0uOC3cNp6M1KqrIDuA0uBFCTIwPMo1eEUG6F0jer4hsOnIfVnFF?=
 =?us-ascii?Q?JBgbqphLDkyunuTSGF0UneugZJdQK/UWJquL/ODjkV4SQ7zu2gOIQR/i0idm?=
 =?us-ascii?Q?mEW6t182IzOppJWnhw2d970QaURMzy5TwCAVRIO6bg4Gq36tTAGtcPxG0bZd?=
 =?us-ascii?Q?DtfZkh5hKCNfe14to2QtOVgSKE7xrtzThEsrTGYbI8+bhYnGl6xZDN0U72/j?=
 =?us-ascii?Q?zIuzlgJvbuLdjF12sNxeM6xIK0vPXtRO9w/uNLHknEdxcHO3w1/T7VHI8rIs?=
 =?us-ascii?Q?sX8ehTw/Tmf4ljFlb/aeJ9hdy+iz8+CKYLqo70u0r4WHAfWkTp3wYdqFVrEA?=
 =?us-ascii?Q?9LOlY/S5OHutBiE1do2D2cUNHUWTebchOEZk0BF2KEke0+Qgv7+n/W8JO845?=
 =?us-ascii?Q?VtOMLUFk95LxBDpVscEirRBtqy+dNeujmuCFxyjUnnO41hCAW3+j5+obWe6r?=
 =?us-ascii?Q?2b1SpN7/WwJAbF8c4CwK3wpfurW+yKKrLRx4FkdVWOetrqjAklG+x3FCauVG?=
 =?us-ascii?Q?1czPgSysTMOswHYGw05kP/VBxBqyit2bBxwFpmFGuTo3n0J2Q0sZPkbl9vuC?=
 =?us-ascii?Q?apCaOyoFD25tAE2UZnfVLYvkSgUddox6BthfmkKQ7G6h/l61Yrj3GBWLSnVA?=
 =?us-ascii?Q?/fsB+9DmAC+tkYZT06+hJPTBdXd3yQiYqDMocatTryQznesV/NZvJfgdG5Kc?=
 =?us-ascii?Q?EZLtrA2eKY14J2RgytYHm6x00ntXJpg+Y9miEVjrY0jSKiQfVGjtEOsV/O2z?=
 =?us-ascii?Q?GR/qSND9pXyJIyfCEy+KSvXbiQ3v27AXDrKsI24dHfcE5OKAU5A0JE+8+iyl?=
 =?us-ascii?Q?HQ9VfO0RXyvBKKW1jFPm2YYDZJFFlS3GIHoHrlvY/pkv0ErNx+mMnDLmw8SJ?=
 =?us-ascii?Q?EUetjBDyBJvqa1dWwkdFek4DD/AhFBphBc+3a0VPGpwJs54PyJ58mwXHl+vK?=
 =?us-ascii?Q?i1ILml1AYaZH8orGMV4SfugNhYsNP2IMqyfkBlWaERYNy474r4N8OQ9eDn7Z?=
 =?us-ascii?Q?KNKsjEgiZyQkVb3WwkTJayJ4i36WcvatAkTBl90RkUMlkf9+u5x5DwOwOn5b?=
 =?us-ascii?Q?NbiisFJplGf7CsfG0VrIht9R6xG3qFSPdMxgLBFIb+/2hwUkOhMydoAAar3i?=
 =?us-ascii?Q?4DUNG0vg9NbBAsOVO0oYreJdiWIuQfgC1lmdqRMvWoUZ5X+bqOZRTTemmPTV?=
 =?us-ascii?Q?f1D3H4B+h7jeupD6CEZLtKCSHaA+X2dNOHcYsmK/lZB92Axo5IdoS20RBwcK?=
 =?us-ascii?Q?YSa689wWLYxBEzbWtaZhhFafSzCeyPaxSdSXjlRgJwpSrL/MnmY+kz1Aees7?=
 =?us-ascii?Q?FKwV8aY5Dv9iTJr8ZrVfA+iKQbAoMybL5R9oIPG9xG2Va7rinreWPWu/dJHF?=
 =?us-ascii?Q?lzvMLssyCePkqWbLdJchSutDW/YruCr2VB9QpE1OwKkGEoXxs4M3NVKNCTXq?=
 =?us-ascii?Q?kJRkH1iSysg4od+ZBOYGW1YTnMl5RFMOlWddh1a+QviA28AosCyt8vWF2xBx?=
 =?us-ascii?Q?5AHeSNyzzepP+mUL3bhvpRDp9bN5cenMEy6LTR6gF5GvIELYFSDk6aGHOYGO?=
 =?us-ascii?Q?+MOMP+lWaJWwNLc7IkA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 04:49:13.9415 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5f691ac-8dad-430b-0e4a-08de4e7145aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003439.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6591
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

Add message control block to abstract PMFW message protocol. Message
control block primarily carries message config which is set of register
addresses and message ops which abstracts the protocol of sending messages.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  70 ++++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 359 ++++++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |   4 +
 3 files changed, 433 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 99dd0f4d399a..842ae201a8ca 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -551,6 +551,73 @@ struct cmn2asic_mapping {
 	int	map_to;
 };
 
+#define SMU_MSG_MAX_ARGS 4
+
+/* Message flags for smu_msg_args */
+#define SMU_MSG_FLAG_NO_WAIT BIT(0) /* Skip post-poll (for split send/wait) */
+
+struct smu_msg_ctl;
+/**
+ * struct smu_msg_config - IP-level register configuration
+ * @msg_reg: Message register offset
+ * @resp_reg: Response register offset
+ * @arg_regs: Argument register offsets (up to SMU_MSG_MAX_ARGS)
+ * @num_arg_regs: Number of argument registers available
+ */
+struct smu_msg_config {
+	u32 msg_reg;
+	u32 resp_reg;
+	u32 arg_regs[SMU_MSG_MAX_ARGS];
+	int num_arg_regs;
+};
+
+/**
+ * struct smu_msg_args - Per-call message arguments
+ * @msg: Common message type (enum smu_message_type)
+ * @args: Input arguments
+ * @num_args: Number of input arguments
+ * @out_args: Output arguments (filled after successful send)
+ * @num_out_args: Number of output arguments to read
+ * @flags: Message flags (SMU_MSG_FLAG_*)
+ * @timeout: Per-message timeout in us (0 = use default)
+ */
+struct smu_msg_args {
+	enum smu_message_type msg;
+	u32 args[SMU_MSG_MAX_ARGS];
+	int num_args;
+	u32 out_args[SMU_MSG_MAX_ARGS];
+	int num_out_args;
+	u32 flags;
+	u32 timeout;
+};
+
+/**
+ * struct smu_msg_ops - IP-level protocol operations
+ * @send_msg: send message protocol
+ * @wait_response: wait for response (for split send/wait cases)
+ * @decode_response: Convert response register value to errno
+ */
+struct smu_msg_ops {
+	int (*send_msg)(struct smu_msg_ctl *ctl, struct smu_msg_args *args);
+	int (*wait_response)(struct smu_msg_ctl *ctl, u32 timeout_us);
+	int (*decode_response)(u32 resp);
+};
+
+/**
+ * struct smu_msg_ctl - Per-device message control block
+ * This is a standalone control block that encapsulates everything
+ * needed for SMU messaging. The ops->send_msg implements the complete
+ * protocol including all filtering and error handling.
+ */
+struct smu_msg_ctl {
+	struct smu_context *smu;
+	struct mutex lock;
+	struct smu_msg_config config;
+	const struct smu_msg_ops *ops;
+	const struct cmn2asic_msg_mapping *message_map;
+	u32 default_timeout;
+};
+
 struct stb_context {
 	uint32_t stb_buf_size;
 	bool enabled;
@@ -691,6 +758,9 @@ struct smu_context {
 	bool				wbrf_supported;
 	struct notifier_block		wbrf_notifier;
 	struct delayed_work		wbrf_delayed_work;
+
+	/* SMU message control block */
+	struct smu_msg_ctl msg_ctl;
 };
 
 struct i2c_adapter;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index ef5aa4e42a17..de4b7f423a76 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -53,6 +53,9 @@ static const char * const __smu_message_names[] = {
 				     -ENOTSUPP) :                              \
 			    -EINVAL)
 
+#define SMU_MSG_V1_DEFAULT_RATELIMIT_INTERVAL (5 * HZ)
+#define SMU_MSG_V1_DEFAULT_RATELIMIT_BURST 10
+
 static const char *smu_get_message_name(struct smu_context *smu,
 					enum smu_message_type type)
 {
@@ -515,6 +518,362 @@ int smu_cmn_send_debug_smc_msg_with_param(struct smu_context *smu,
 	return __smu_cmn_send_debug_msg(smu, msg, param);
 }
 
+static int smu_msg_v1_decode_response(u32 resp)
+{
+	int res;
+
+	switch (resp) {
+	case SMU_RESP_NONE:
+		/* The SMU is busy--still executing your command.
+		 */
+		res = -ETIME;
+		break;
+	case SMU_RESP_OK:
+		res = 0;
+		break;
+	case SMU_RESP_CMD_FAIL:
+		/* Command completed successfully, but the command
+		 * status was failure.
+		 */
+		res = -EIO;
+		break;
+	case SMU_RESP_CMD_UNKNOWN:
+		/* Unknown command--ignored by the SMU.
+		 */
+		res = -EOPNOTSUPP;
+		break;
+	case SMU_RESP_CMD_BAD_PREREQ:
+		/* Valid command--bad prerequisites.
+		 */
+		res = -EINVAL;
+		break;
+	case SMU_RESP_BUSY_OTHER:
+		/* The SMU is busy with other commands. The client
+		 * should retry in 10 us.
+		 */
+		res = -EBUSY;
+		break;
+	default:
+		/* Unknown or debug response from the SMU.
+		 */
+		res = -EREMOTEIO;
+		break;
+	}
+
+	return res;
+}
+
+static u32 __smu_msg_v1_poll_stat(struct smu_msg_ctl *ctl, u32 timeout_us)
+{
+	struct amdgpu_device *adev = ctl->smu->adev;
+	struct smu_msg_config *cfg = &ctl->config;
+	u32 timeout = timeout_us ? timeout_us : ctl->default_timeout;
+	u32 reg;
+
+	for (; timeout > 0; timeout--) {
+		reg = RREG32(cfg->resp_reg);
+		if ((reg & MP1_C2PMSG_90__CONTENT_MASK) != 0)
+			break;
+		udelay(1);
+	}
+
+	return reg;
+}
+
+static void __smu_msg_v1_send(struct smu_msg_ctl *ctl, u16 index,
+			      struct smu_msg_args *args)
+{
+	struct amdgpu_device *adev = ctl->smu->adev;
+	struct smu_msg_config *cfg = &ctl->config;
+	int i;
+
+	WREG32(cfg->resp_reg, 0);
+	for (i = 0; i < args->num_args; i++)
+		WREG32(cfg->arg_regs[i], args->args[i]);
+	WREG32(cfg->msg_reg, index);
+}
+
+static void __smu_msg_v1_read_out_args(struct smu_msg_ctl *ctl,
+				       struct smu_msg_args *args)
+{
+	struct amdgpu_device *adev = ctl->smu->adev;
+	int i;
+
+	for (i = 0; i < args->num_out_args; i++)
+		args->out_args[i] = RREG32(ctl->config.arg_regs[i]);
+}
+
+static void __smu_msg_v1_print_err_limited(struct smu_msg_ctl *ctl,
+					   struct smu_msg_args *args,
+					   char *err_msg)
+{
+	static DEFINE_RATELIMIT_STATE(_rs,
+				      SMU_MSG_V1_DEFAULT_RATELIMIT_INTERVAL,
+				      SMU_MSG_V1_DEFAULT_RATELIMIT_BURST);
+	struct smu_context *smu = ctl->smu;
+	struct amdgpu_device *adev = smu->adev;
+
+	if (__ratelimit(&_rs)) {
+		u32 in[SMU_MSG_MAX_ARGS];
+		int i;
+
+		dev_err(adev->dev, "%s msg_reg: %x resp_reg: %x", err_msg,
+			RREG32(ctl->config.msg_reg),
+			RREG32(ctl->config.resp_reg));
+		if (args->num_args > 0) {
+			for (i = 0; i < args->num_args; i++)
+				in[i] = RREG32(ctl->config.arg_regs[i]);
+			print_hex_dump(KERN_ERR, "in params:", DUMP_PREFIX_NONE,
+				       16, 4, in, args->num_args * sizeof(u32),
+				       false);
+		}
+	}
+}
+
+static void __smu_msg_v1_print_error(struct smu_msg_ctl *ctl,
+				     u32 resp,
+				     struct smu_msg_args *args)
+{
+	struct smu_context *smu = ctl->smu;
+	struct amdgpu_device *adev = smu->adev;
+	int index = ctl->message_map[args->msg].map_to;
+
+	switch (resp) {
+	case SMU_RESP_NONE:
+		__smu_msg_v1_print_err_limited(ctl, args, "SMU: No response");
+		break;
+	case SMU_RESP_OK:
+		break;
+	case SMU_RESP_CMD_FAIL:
+		break;
+	case SMU_RESP_CMD_UNKNOWN:
+		__smu_msg_v1_print_err_limited(ctl, args,
+					       "SMU: unknown command");
+		break;
+	case SMU_RESP_CMD_BAD_PREREQ:
+		__smu_msg_v1_print_err_limited(
+			ctl, args, "SMU: valid command, bad prerequisites");
+		break;
+	case SMU_RESP_BUSY_OTHER:
+		if (args->msg != SMU_MSG_GetBadPageCount)
+			__smu_msg_v1_print_err_limited(ctl, args,
+						       "SMU: I'm very busy");
+		break;
+	case SMU_RESP_DEBUG_END:
+		__smu_msg_v1_print_err_limited(ctl, args, "SMU: Debug Err");
+		break;
+	case SMU_RESP_UNEXP:
+		if (amdgpu_device_bus_status_check(adev)) {
+			dev_err(adev->dev,
+				"SMU: bus error for message: %s(%d) response:0x%08X ",
+				smu_get_message_name(smu, args->msg), index,
+				resp);
+			if (args->num_args > 0)
+				print_hex_dump(KERN_ERR,
+					       "in params:", DUMP_PREFIX_NONE,
+					       16, 4, args->args,
+					       args->num_args * sizeof(u32),
+					       false);
+		}
+		break;
+	default:
+		__smu_msg_v1_print_err_limited(ctl, args,
+					       "SMU: unknown response");
+		break;
+	}
+}
+
+static int __smu_msg_v1_ras_filter(struct smu_msg_ctl *ctl,
+				   enum smu_message_type msg, u32 msg_flags,
+				   bool *skip_pre_poll)
+{
+	struct smu_context *smu = ctl->smu;
+	struct amdgpu_device *adev = smu->adev;
+	bool fed_status;
+	u32 reg;
+
+	if (!(smu->smc_fw_caps & SMU_FW_CAP_RAS_PRI))
+		return 0;
+
+	fed_status = amdgpu_ras_get_fed_status(adev);
+
+	/* Block non-RAS-priority messages during RAS error */
+	if (fed_status && !(msg_flags & SMU_MSG_RAS_PRI)) {
+		dev_dbg(adev->dev, "RAS error detected, skip sending %s",
+			smu_get_message_name(smu, msg));
+		return -EACCES;
+	}
+
+	/* Skip pre-poll for priority messages or during RAS error */
+	if ((msg_flags & SMU_MSG_NO_PRECHECK) || fed_status) {
+		reg = RREG32(ctl->config.resp_reg);
+		dev_dbg(adev->dev,
+			"Sending priority message %s response status: %x",
+			smu_get_message_name(smu, msg), reg);
+		if (reg == 0)
+			*skip_pre_poll = true;
+	}
+
+	return 0;
+}
+
+/**
+ * smu_msg_proto_v1_send_msg - Complete V1 protocol with all filtering
+ * @ctl: Message control block
+ * @args: Message arguments
+ *
+ * Return: 0 on success, negative errno on failure
+ */
+static int smu_msg_v1_send_msg(struct smu_msg_ctl *ctl,
+			       struct smu_msg_args *args)
+{
+	struct smu_context *smu = ctl->smu;
+	struct amdgpu_device *adev = smu->adev;
+	const struct cmn2asic_msg_mapping *mapping;
+	u32 reg, msg_flags;
+	int ret, index;
+	bool skip_pre_poll = false;
+
+	/* Early exit if no HW access */
+	if (adev->no_hw_access)
+		return 0;
+
+	/* Message index translation */
+	if (args->msg >= SMU_MSG_MAX_COUNT || !ctl->message_map)
+		return -EINVAL;
+
+	if (args->num_args > ctl->config.num_arg_regs ||
+	    args->num_out_args > ctl->config.num_arg_regs)
+		return -EINVAL;
+
+	mapping = &ctl->message_map[args->msg];
+	if (!mapping->valid_mapping)
+		return -EINVAL;
+
+	msg_flags = mapping->flags;
+	index = mapping->map_to;
+
+	/* VF filter - skip messages not valid for VF */
+	if (amdgpu_sriov_vf(adev) && !(msg_flags & SMU_MSG_VF_FLAG))
+		return 0;
+
+	mutex_lock(&ctl->lock);
+
+	/* RAS priority filter */
+	ret = __smu_msg_v1_ras_filter(ctl, args->msg, msg_flags,
+				      &skip_pre_poll);
+	if (ret)
+		goto out;
+
+	/* FW state checks */
+	if (smu->smc_fw_state == SMU_FW_HANG) {
+		dev_err(adev->dev,
+			"SMU is in hanged state, failed to send smu message!\n");
+		ret = -EREMOTEIO;
+		goto out;
+	} else if (smu->smc_fw_state == SMU_FW_INIT) {
+		skip_pre_poll = true;
+		smu->smc_fw_state = SMU_FW_RUNTIME;
+	}
+
+	/* Pre-poll: ensure previous message completed */
+	if (!skip_pre_poll) {
+		reg = __smu_msg_v1_poll_stat(ctl, args->timeout);
+		ret = smu_msg_v1_decode_response(reg);
+		if (reg == SMU_RESP_NONE || ret == -EREMOTEIO) {
+			__smu_msg_v1_print_error(ctl, reg, args);
+			goto out;
+		}
+	}
+
+	/* Send message */
+	__smu_msg_v1_send(ctl, (u16)index, args);
+
+	/* Post-poll (skip if NO_WAIT) */
+	if (args->flags & SMU_MSG_FLAG_NO_WAIT) {
+		ret = 0;
+		goto out;
+	}
+
+	reg = __smu_msg_v1_poll_stat(ctl, args->timeout);
+	ret = smu_msg_v1_decode_response(reg);
+
+	/* FW state update on fatal error */
+	if (ret == -EREMOTEIO) {
+		smu->smc_fw_state = SMU_FW_HANG;
+		__smu_msg_v1_print_error(ctl, reg, args);
+	} else if (ret != 0) {
+		__smu_msg_v1_print_error(ctl, reg, args);
+	}
+
+	/* Read output args */
+	if (ret == 0 && args->num_out_args > 0) {
+		__smu_msg_v1_read_out_args(ctl, args);
+		dev_dbg(adev->dev, "smu send message: %s(%d) resp : 0x%08x",
+			smu_get_message_name(smu, args->msg), index, reg);
+		if (args->num_args > 0)
+			print_hex_dump_debug("in params:", DUMP_PREFIX_NONE, 16,
+					     4, args->args,
+					     args->num_args * sizeof(u32),
+					     false);
+		print_hex_dump_debug("out params:", DUMP_PREFIX_NONE, 16, 4,
+				     args->out_args,
+				     args->num_out_args * sizeof(u32), false);
+	} else {
+		dev_dbg(adev->dev, "smu send message: %s(%d), resp: 0x%08x\n",
+			smu_get_message_name(smu, args->msg), index, reg);
+		if (args->num_args > 0)
+			print_hex_dump_debug("in params:", DUMP_PREFIX_NONE, 16,
+					     4, args->args,
+					     args->num_args * sizeof(u32),
+					     false);
+	}
+
+out:
+	/* Debug halt on error */
+	if (unlikely(adev->pm.smu_debug_mask & SMU_DEBUG_HALT_ON_ERROR) &&
+	    ret) {
+		amdgpu_device_halt(adev);
+		WARN_ON(1);
+	}
+
+	mutex_unlock(&ctl->lock);
+	return ret;
+}
+
+static int smu_msg_v1_wait_response(struct smu_msg_ctl *ctl, u32 timeout_us)
+{
+	struct smu_context *smu = ctl->smu;
+	struct amdgpu_device *adev = smu->adev;
+	u32 reg;
+	int ret;
+
+	reg = __smu_msg_v1_poll_stat(ctl, timeout_us);
+	ret = smu_msg_v1_decode_response(reg);
+
+	if (ret == -EREMOTEIO)
+		smu->smc_fw_state = SMU_FW_HANG;
+
+	if (unlikely(adev->pm.smu_debug_mask & SMU_DEBUG_HALT_ON_ERROR) &&
+	    ret && (ret != -ETIME)) {
+		amdgpu_device_halt(adev);
+		WARN_ON(1);
+	}
+
+	return ret;
+}
+
+const struct smu_msg_ops smu_msg_v1_ops = {
+	.send_msg = smu_msg_v1_send_msg,
+	.wait_response = smu_msg_v1_wait_response,
+	.decode_response = smu_msg_v1_decode_response,
+};
+
+int smu_msg_wait_response(struct smu_msg_ctl *ctl, u32 timeout_us)
+{
+	return ctl->ops->wait_response(ctl, timeout_us);
+}
+
 int smu_cmn_to_asic_specific_index(struct smu_context *smu,
 				   enum smu_cmn2asic_mapping_type type,
 				   uint32_t index)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index 3a8d05afa654..d9a37ed4e720 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -25,6 +25,10 @@
 
 #include "amdgpu_smu.h"
 
+extern const struct smu_msg_ops smu_msg_v1_ops;
+
+int smu_msg_wait_response(struct smu_msg_ctl *ctl, u32 timeout_us);
+
 #if defined(SWSMU_CODE_LAYER_L2) || defined(SWSMU_CODE_LAYER_L3) || defined(SWSMU_CODE_LAYER_L4)
 
 #define FDO_PWM_MODE_STATIC  1
-- 
2.49.0

