Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC6B7D65C49
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Dec 2025 13:55:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C74B10ECCF;
	Wed, 17 Dec 2025 13:55:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0d9zzy0k";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012043.outbound.protection.outlook.com [52.101.43.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DEDC10ECCE
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Dec 2025 13:55:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uTZwDgn8Ew2xt/r94K2l2S9KLkS+yY9DGIZ/H9swyUSSIWGYwFjEfBddWmj3ZbZidwlERRHiLcGEKhX4TnkdMkXxOtlVwklF+qM3wqMVw0kKxSCadOk7ilNXBVdj6VO+OUrLuv1PuvD8yuaYuSAlUrVut9nDbf8c2gAxB6WqaxdpLHXyJcMXeLqfNMLF27VSjja2Vb0ILz/K1Y9koHeqTzTLkCy7OklVZ7xAJwgTziln8xBpvW4WMWizJnveOtZicLBJLiZvk7fLTFR9x2wCQWfKPGn7akQP1GksQ20HbmwOg3xTfzoB7vsZD5jx/6SIiREUVjm9fuBv4rqR+1rs1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lU3YvDtg027VzAFSdx4BUl9aT1aSBCVhYNay/OD8g8A=;
 b=a8VFAiWhCnIgnv2VaCGaSuzPg0+hRywqYtd+z5i60uJBK6CQYOfgXEXGCUw6+PNb8wlwifmmgXSHwPSR+hzs5fyTE41cYaiWs51F0/mF3yjeItNAabLAjRBwwLsANT7wH+eR7aOlyoMlvydcScTg0Raj2W0jNJa2kAZ40Xtozoxf4WvXAuDGB0PrEtex2HK/vXRY0sxk+qScpeY0uCUu5HvDgW1g241ACRdb1t5l3sAKeu8Zq46GW0xc2Cn8vSbhWjjIOjtaJY4k17TCsNS74n4eRDz7ZqHET9pXqb5jBDggA+LPcqpNFLBCfE003bhVhgCOhlUASgL6vUkTZi3/Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lU3YvDtg027VzAFSdx4BUl9aT1aSBCVhYNay/OD8g8A=;
 b=0d9zzy0kNWtHUe4cOVTkF9N0l0foHBDX4iKIANG4SRENJxv9p7qYNPuA4zFoEIbqHC9YlP+gEcmvE9pDGcct2BS+45sLEGpCKYFjoR+h3KPO2HRMDBeOErlaFtjH6kZT/4UsmAOmoM0X3ThE1egiyphXluLdc4kjM9vmTCrqSmc=
Received: from CH2PR15CA0015.namprd15.prod.outlook.com (2603:10b6:610:51::25)
 by SJ2PR12MB9210.namprd12.prod.outlook.com (2603:10b6:a03:561::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 13:54:54 +0000
Received: from CH2PEPF0000013D.namprd02.prod.outlook.com
 (2603:10b6:610:51:cafe::13) by CH2PR15CA0015.outlook.office365.com
 (2603:10b6:610:51::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.13 via Frontend Transport; Wed,
 17 Dec 2025 13:54:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000013D.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Wed, 17 Dec 2025 13:54:54 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 07:54:52 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH 01/21] drm/amd/pm: Add smu message control block
Date: Wed, 17 Dec 2025 19:17:54 +0530
Message-ID: <20251217135431.2943441-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251217135431.2943441-1-lijo.lazar@amd.com>
References: <20251217135431.2943441-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013D:EE_|SJ2PR12MB9210:EE_
X-MS-Office365-Filtering-Correlation-Id: 0deeb76f-dd73-43c7-06d7-08de3d73db44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eARN+ElkilWqixjem8f30WRkto/9phknmkFE8r5E6eylUUzoocuLarnh00xs?=
 =?us-ascii?Q?wKAoHnIVaz+TTcksfJBE5NDCPFjOFGdc7pVckBo+42N8kQhoLuRuRPzAqhZX?=
 =?us-ascii?Q?MOVsKH7RpjDczCFdsOx6jL7GRxjhkDzpTe9uWS7/wdVCSGrcmroiNwAsLB21?=
 =?us-ascii?Q?1ldkr/LlmWt1lrSi7sXj4cHyEpGPbuYr3t8s8LOtto9HoaOKbqGsnM6agjfy?=
 =?us-ascii?Q?UqwdIEpSiUFFEJ0jlJidYWslEjv14LOlAuP7q/ikxbAB0JNor87Yvo90uB/s?=
 =?us-ascii?Q?ki5aQQYOPIVrwzKoX6yyS1UPatMWoXygrhgmm6JqP9TkmpsLGhz4tHOyohU8?=
 =?us-ascii?Q?Zw6Smz+FTT2A1JaVOLT6MLu840GDJqtTLqjqibNTDe6sMutu/t20xCZ+HD7N?=
 =?us-ascii?Q?XrqccAsA+cctmjNXia14XkmxEd96/RJ5LuY3maQI3XkjZOs29vuIPTYBQdHk?=
 =?us-ascii?Q?7m/Uy8MOaf3tbEf1qbBE7Fr/FiYYYMlbuOtr1p7TaiDjkLLyngtqgTZBOTUM?=
 =?us-ascii?Q?OBcvjWL8jfKCdW1SZtNF2OZRPmvxee9Fza4NV9hJyhw0iB6ZqU6RlmUYz6wv?=
 =?us-ascii?Q?/tsOUqjeNj8hlcOTUq5kLYUM+Xcxrg5BA+l8q+rQLq46amMwiFmefLZUe8Ry?=
 =?us-ascii?Q?xQvFthZ0aPtmde3o2iY43HT7ARLDL68KaHRzIHOUEL7EQ6U3cO3I14lSiUSG?=
 =?us-ascii?Q?RWdWvGJ0hOmu1+znWSkf6lfcxfwZIOxvv4zGUWorTJS8CCRFvobbeSY+uUdU?=
 =?us-ascii?Q?182Pg7ri0X1pzYs5nqxdD3IynecZnpfrtWNGqz12etXZgA/doYtjui+YNKiR?=
 =?us-ascii?Q?Gt7J7KX13XUR0SSH4OMCak3q2VOUkFwJWsy+ci1CftlgaDRok8vCuc3dqy81?=
 =?us-ascii?Q?G9Q9IPJGijoqXBt044SAfce2qUAnyucd9uoS0f9LJKRmLNVpc3FcqFFiDskb?=
 =?us-ascii?Q?XnmrJm2xhcPAxc55aiHcjF8ZRtRslKcwVuap1z/YJsH5ySuMGc9alR9YUPZQ?=
 =?us-ascii?Q?okDixK5ciheZfAMON/7INX7V1N6WAqQa1rgqG8z1mKLKDDZcpJ/6iZManG2P?=
 =?us-ascii?Q?Zdz2U93karzMeMCS09EZZByMKPCEnPZTrjG0+62BUqEJt31dneYaPcPR/sX/?=
 =?us-ascii?Q?lYDEv/yKSLs3G+uELDk0PhjVclZ/KPEAV8koQuy5Ude1NgPth36USwdCv9ce?=
 =?us-ascii?Q?bKhYY8NBIfxaYxOhKSueUhhmY5CBOz/F8a5xDtoNZD2rsWDfkXTFObZbILWa?=
 =?us-ascii?Q?yWyN5ONAWVOaOF6+qODgwiHG5kknpX1jJ82U5da1YdMYAFKQAIiBIczqahsr?=
 =?us-ascii?Q?RHNLOD5XcOPnw4TmTFDCPCBRiNftWbH4DCQCeDK8/yIyYIXHt/6Qwc/IzbZq?=
 =?us-ascii?Q?iSv7nqv+PmTTTV5QYmWnxnqlfva7rNU9iToDU1TKSLCvsaSTgPOZKxema4AM?=
 =?us-ascii?Q?AmYTyeIhY+irdHBI7FVSGhxY4Dn2uWZkZKL1x8EYh6YpQ04zJPI997oloiQG?=
 =?us-ascii?Q?YH7a+UU7jbVPRNI3Br3uWcwfidJvK4NZ0TalCgai0LsbVUXLCHzQ5c1gquUE?=
 =?us-ascii?Q?816+TQEEn96niViU3os=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 13:54:54.1849 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0deeb76f-dd73-43c7-06d7-08de3d73db44
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9210
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
---
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  70 ++++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 315 ++++++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |   4 +
 3 files changed, 389 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 24cf25d0606b..41f27fb4af4b 100644
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
index 88e9699d9cc1..266aca5ed559 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -515,6 +515,321 @@ int smu_cmn_send_debug_smc_msg_with_param(struct smu_context *smu,
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
+static void __smu_msg_v1_send(struct smu_msg_ctl *ctl, u16 index, u32 param)
+{
+	struct amdgpu_device *adev = ctl->smu->adev;
+	struct smu_msg_config *cfg = &ctl->config;
+
+	WREG32(cfg->resp_reg, 0);
+	WREG32(cfg->arg_regs[0], param);
+	WREG32(cfg->msg_reg, index);
+}
+
+static u32 __smu_msg_v1_read_arg(struct smu_msg_ctl *ctl)
+{
+	struct amdgpu_device *adev = ctl->smu->adev;
+
+	return RREG32(ctl->config.arg_regs[0]);
+}
+
+static void __smu_msg_v1_print_error(struct smu_msg_ctl *ctl,
+				     u32 resp,
+				     struct smu_msg_args *args)
+{
+	struct smu_context *smu = ctl->smu;
+	struct amdgpu_device *adev = smu->adev;
+	const char *message = smu_get_message_name(smu, args->msg);
+	int index = ctl->message_map[args->msg].map_to;
+	u32 param = args->args[0];
+	u32 msg_idx, prm;
+
+	switch (resp) {
+	case SMU_RESP_NONE:
+		msg_idx = RREG32(ctl->config.msg_reg);
+		prm = RREG32(ctl->config.arg_regs[0]);
+		dev_err_ratelimited(adev->dev,
+			"SMU: I'm not done with your previous command: SMN_C2PMSG_66:0x%08X SMN_C2PMSG_82:0x%08X",
+			msg_idx, prm);
+		break;
+	case SMU_RESP_OK:
+		break;
+	case SMU_RESP_CMD_FAIL:
+		break;
+	case SMU_RESP_CMD_UNKNOWN:
+		dev_err_ratelimited(adev->dev,
+			"SMU: unknown command: index:%d param:0x%08X message:%s",
+			index, param, message);
+		break;
+	case SMU_RESP_CMD_BAD_PREREQ:
+		dev_err_ratelimited(adev->dev,
+			"SMU: valid command, bad prerequisites: index:%d param:0x%08X message:%s",
+			index, param, message);
+		break;
+	case SMU_RESP_BUSY_OTHER:
+		if (args->msg != SMU_MSG_GetBadPageCount)
+			dev_err_ratelimited(adev->dev,
+				"SMU: I'm very busy for your command: index:%d param:0x%08X message:%s",
+				index, param, message);
+		break;
+	case SMU_RESP_DEBUG_END:
+		dev_err_ratelimited(adev->dev, "SMU: I'm debugging!");
+		break;
+	case SMU_RESP_UNEXP:
+		if (amdgpu_device_bus_status_check(adev)) {
+			dev_err(adev->dev,
+				"SMU: response:0x%08X for index:%d param:0x%08X message:%s?",
+				resp, index, param, message);
+			break;
+		}
+		fallthrough;
+	default:
+		dev_err_ratelimited(adev->dev,
+			"SMU: response:0x%08X for index:%d param:0x%08X message:%s?",
+			resp, index, param, message);
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
+	__smu_msg_v1_send(ctl, (u16)index, args->args[0]);
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
+		args->out_args[0] = __smu_msg_v1_read_arg(ctl);
+		dev_dbg(adev->dev,
+			"smu send message: %s(%d) param: 0x%08x, resp: 0x%08x, readval: 0x%08x\n",
+			smu_get_message_name(smu, args->msg), index,
+			args->args[0], reg, args->out_args[0]);
+	} else {
+		dev_dbg(adev->dev,
+			"smu send message: %s(%d) param: 0x%08x, resp: 0x%08x\n",
+			smu_get_message_name(smu, args->msg), index,
+			args->args[0], reg);
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
index f458125e8d4e..6ba62180e544 100644
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

