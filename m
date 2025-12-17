Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FFD0D65C4F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Dec 2025 13:55:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D6BC10ECE2;
	Wed, 17 Dec 2025 13:55:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Qd/ykGbP";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012062.outbound.protection.outlook.com
 [40.93.195.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F5B510ECE2
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Dec 2025 13:55:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LpdlnQPx2xdHxbLA2JzLZpA8brzd+1wwxskeG94Ppqq3vZXmzZiuWXiT3A39M7MN+GWAmJNDT0nnWgiN8rCZBFBZRcU7s7FH3x+itKb42hqTmxvCIa/Q5gHUq+DEIN4BoZQLohbG4Bz2SvpsggitewXlOzaLK2VG7Iy5MfMkiTzFJflCox6yO1km7Pgk2k1XCVSFhrfo+47FuPDqI0CBXxvIJAnqvA9Vm3GGweVCozg1QG4ev2Bc3+3/6QQI4QztIew3WIUsoXb3/jRu7yK4DCMxC4oAd1iieW/oA+ahZA0hxS7p1PAWoI0YJ+COvYuw3lo0L6+ScFKoxuKZXzW3zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rdyjNrnb7UM963ijUM5WbmSVNkRgbak4WlxyMPDj+58=;
 b=H6ul/l5ER1n3/l5PywjxzANAqtidXQnYfvycTSfso/mbQKnWfVokiCDbitiZJNxQh9lZofjgAD9In9FO2iTQH8auWPrLu3MnSA6u3pLmhq4uL1wISG5CaLCmyLTJfJW+Qk1QBRz9KF8hKdtFQBo5NzkQ2a03jMFy6uaTvCimFPc7DnpX42cgPoScXZs8hcZVQd2RxuqfPcgDTBzqWvvLYNHvbm6I3msUQ5UOJBwBU3rHI2YvwlwDj1tehCL5fptEOJ1fPEMRE5FL+ZL0OaO5gaJYmTGwpnNmtXUNGfe6QuW/RYrNX7MT21IkBW9KIvIHI/prXRcjRDB1kgOEXces2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rdyjNrnb7UM963ijUM5WbmSVNkRgbak4WlxyMPDj+58=;
 b=Qd/ykGbPLYf2FujMwKc++d0IHE7J0aM0bFyDMscP8JlOxz04PZ/pRnlRjL+pET5okrf8JAd4huIry4Z5ZsCPWCNmVHiSbSqwrJvGf3LcDJ5++VDYt9VZ1j9KBl8XQ06UdBPfAF9MOJIOfDceVkEtxM2D69C/7E3h77KFaL39lMc=
Received: from CH0P221CA0024.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::20)
 by SA3PR12MB8023.namprd12.prod.outlook.com (2603:10b6:806:320::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 13:55:33 +0000
Received: from CH2PEPF0000013F.namprd02.prod.outlook.com
 (2603:10b6:610:11c:cafe::7d) by CH0P221CA0024.outlook.office365.com
 (2603:10b6:610:11c::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.7 via Frontend Transport; Wed,
 17 Dec 2025 13:55:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000013F.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Wed, 17 Dec 2025 13:55:32 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 07:55:29 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH 20/21] drm/amd/pm: Add debug message callback
Date: Wed, 17 Dec 2025 19:18:13 +0530
Message-ID: <20251217135431.2943441-21-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013F:EE_|SA3PR12MB8023:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e814503-7bc3-48a1-1040-08de3d73f226
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LvfQMGD+SXGdCoYzZ9gFBdfvFyjAnGh8QrSiQF2UJwJQyiYhKsHGfnK5lsv0?=
 =?us-ascii?Q?T7q8FPQS7/BfXgO5rjc3HMY727OiPUPyVva6w8xODgAKXVLlgWIsDTQBTv/d?=
 =?us-ascii?Q?ZhQ68+TDNIdgOTs+iTqqyHIOmR1jdGaokIKMZBtLiQnBkAkn7PSAmMUQB2H1?=
 =?us-ascii?Q?3PRgQu9qmbc5tEXuJbokocCJw1fDsRp2P08NuiF/wZSS1rtt+NpPPkfgRDmx?=
 =?us-ascii?Q?9YUd/uKDp8DkqBnis1fm9fOts4+FYkQdOg0gcrAZACfsxEkHd0/3rmAlQuAE?=
 =?us-ascii?Q?9hnlcWyS2+L/nNaLiiIcjY5Uf5Whyfub/p3n6Xg1Bejz4VpBT/I1xf/CCpSa?=
 =?us-ascii?Q?q98QPzBPLcUW9YVCd4ScAwE8zRQJN/2IQKsgpiMe/NbTtqB130ya3zFeNHfs?=
 =?us-ascii?Q?7i3tIEZsWjMebGD4eU6eBtuV7dpxXTyQ1q96S2izt2AFydQdK6XFKNj5jRTt?=
 =?us-ascii?Q?Ebb1uWTE8bXJwMbyFUUzoznpMRIi0lpJNsNnqhNvLsLVhGxZ2EmZSExdN2FH?=
 =?us-ascii?Q?wmcLtspXYbPwNWoiWW6GRV1Uyls/20bOPboi5jOXJuP5Csh3anr72Yq8M0sc?=
 =?us-ascii?Q?o4CISAnyAYkqQ/cxlrxnKY5oGOgB6zy40kNC9yBHjmSkMkXehdqDjM2mpXvD?=
 =?us-ascii?Q?txNCoQmbxsS6wkAfby8a4Y5K6WjD8BU9hPTXMkRBq2LXtRrWYH3Vq/pbQ9xV?=
 =?us-ascii?Q?sh3Ipzm3XRazBzhPvXm0WBTq0OslWpzBTu+mJj9dXcyfYQrZzrEW0O3hmutD?=
 =?us-ascii?Q?3LpuS7VuoITF5eHb7XUGZeGmzblqUeSN11Gh/ZsXZD5SeZ36J43qLLgTfz3r?=
 =?us-ascii?Q?ijS0/kP/2eqURIixvhxfq2TIOunWthStSeDBoy1/LNcmY08eYvpHR6lIvT8H?=
 =?us-ascii?Q?I2+z/RINCTPFLVQ/yuxseSuSdbrBO4aY8XKkBoh39TAsFolyQFPBQ+LNvKNP?=
 =?us-ascii?Q?xL6Hd2bn4Bf2tKSFto4rN2uNzUePki/fPm0XXApzI3FaGSki63s0qt4ptvZ4?=
 =?us-ascii?Q?ENlgFMqSy53M0mO0gtgBi9G9qlUnOQr7Bmx47FU+yNb/dVFT6u0nd6kAUji/?=
 =?us-ascii?Q?CQ4TfWlRnbECPDKa7WIKA89N/X52J4tBztBye6cSmrTh7He+Q0G6fFTPySXE?=
 =?us-ascii?Q?fsU2yM96Phqk9dc77UC6zNLU8YowKuoDwne3RjOZyCM7CpexA5yWk5RfHq5b?=
 =?us-ascii?Q?V4w+BAvSAd3FkVSNgyh5ZB21kb8sY0EO6F1IimjWxcIyGToTP8RpCdtBbhr6?=
 =?us-ascii?Q?KetdtJ0yRgP/EIdcPaBfrohrDtVJpb3VYIGhy1RQ0QnB0TphoSpS/GELO1/d?=
 =?us-ascii?Q?vZwgBtf/H1w2xv3YoRSPdTOGnWc4hDPDBTKksNsUaLDa4yI76IQY95M8U4c0?=
 =?us-ascii?Q?EBXzrmCoTpXMlIRNuOYH7hL9XNGSS/ploITTaGa2RiZZNpcroPx9GJabs0nT?=
 =?us-ascii?Q?d9m7qYWageUYYgOrTUxgEcaehqQjTart4iY0MQoNcT7vzUgZp/+wTTZ8cHkP?=
 =?us-ascii?Q?GGytG4r1qYkfNmeQPnx6S4d9lrls/RtkhAiRu+LJb3Maau/QD1LIYmD29CZb?=
 =?us-ascii?Q?5siE9dIs/5X44bp9hSo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 13:55:32.5682 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e814503-7bc3-48a1-1040-08de3d73f226
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8023
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
---
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 12 +++++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 20 +++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 93c943151721..9b151425feb6 100644
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
index 65115ef19fa1..5890526f1278 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -80,6 +80,25 @@ static const char *smu_get_message_name(struct smu_context *smu,
 
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
@@ -497,6 +516,7 @@ const struct smu_msg_ops smu_msg_v1_ops = {
 	.send_msg = smu_msg_v1_send_msg,
 	.wait_response = smu_msg_v1_wait_response,
 	.decode_response = smu_msg_v1_decode_response,
+	.send_debug_msg = smu_msg_v1_send_debug_msg,
 };
 
 int smu_msg_wait_response(struct smu_msg_ctl *ctl, u32 timeout_us)
-- 
2.49.0

