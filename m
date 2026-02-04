Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F4E9E8B394
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 03:06:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11C0710E350;
	Wed,  4 Feb 2026 03:06:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E3qHKl+w";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012029.outbound.protection.outlook.com [52.101.53.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AD0210E34D
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Feb 2026 03:06:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PxTiaT8Z5jX1ZT//epqCcirRc5XgCk6ak1vrSklc7wVgEEjoigwuK2FOuwspeJsOoDBU/U3AnvYo1qHylGxLmUMTskUsoO50snhL8BPSS9HnukDqo7Q9T1prGQvagBw7clJX7DoMggUENM8N9qRLSo16EqoSDAucg4sBr/Q8nb5JFOg15KtZpxGxlFLG2mKzdxFFJJZBvy4lFTabZAK7rgk4K/C0L4UopiN6kpfwdYq9Wk1o1q3H30GBoE5fc+m4rfTWTZmarrsVRgxrbFov10UVADjE2NWuH7ibinAbAXCB01z2s7wNH3yUIgxgAiyrnyYnSZ4u+zWOcNOg/HQjig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QIAZdQsST0WDNd03q7fZMiWHsMjgAgQ+uKL7UTNJ2ys=;
 b=uopnxt7gwF0pN1kwt8qwVJEhWDBn0rUc7K6VEGyf66KnLtQTSjurG2XlhN2e4/BwhyM5jAO9FJn1l4fjDVlZJ7KvWbYSLullOWzGHUfv/OlfbvBhwQKS/YgOMGdfRXqPjNPfY+u8gJJtAGt3SRpyE2zNYpF9apOB+yRHO5zin6XO4KGSo2LpXX5DOF4dgZP6A5P3D8fr07XNzwF8AdM6wEIzQOxKcaMnUkWbOdisCzVjsXHTjcN+sTDv01roGTIbYcMuLO9HFo04WSAhNktJMR8DuStKW2ZfLSsKNkCIp7aCCmOuSkHknEQ6cG5UAvqX0Wz6gk2vtE2UhEqZxNEPNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QIAZdQsST0WDNd03q7fZMiWHsMjgAgQ+uKL7UTNJ2ys=;
 b=E3qHKl+wg4GrI0fePhi7GTKNTjtPIi6q9LBQM5W2g3lwfcg3E58L05ZGGQkt/uQsz37aHV8k3pFagnFNKp5KTf20QW9SgEk2sCqquxTyTvPemA8lLU2xAh09BjGHEjfOAPjs6/RNYvJXvkOd/J/QtQdSTMasictfWGJWidZ08r8=
Received: from CH2PR18CA0020.namprd18.prod.outlook.com (2603:10b6:610:4f::30)
 by SN7PR12MB6840.namprd12.prod.outlook.com (2603:10b6:806:264::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Wed, 4 Feb
 2026 03:06:50 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:4f:cafe::7d) by CH2PR18CA0020.outlook.office365.com
 (2603:10b6:610:4f::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Wed,
 4 Feb 2026 03:06:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Wed, 4 Feb 2026 03:06:49 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 21:06:48 -0600
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Subject: [PATCH 03/13] drm/amd/swsmu: Add support for multi param send/read
Date: Wed, 4 Feb 2026 03:06:10 +0000
Message-ID: <20260204030621.33369-3-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260204030621.33369-1-Pratik.Vishwakarma@amd.com>
References: <20260204030621.33369-1-Pratik.Vishwakarma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|SN7PR12MB6840:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ae37cfd-b531-4795-5eee-08de639a7086
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Z825tSDTLEP188C6l+ZISYOmeFZebLow7nC8yneo/zbAHIGyYjEoqBa7qoFA?=
 =?us-ascii?Q?M0yIqh6Z92U79PiEhVFeiQup9Yuh3PpsVIDWS0f4u0xvx1suiBywpigcuAnR?=
 =?us-ascii?Q?tqWQwhvYYRUeWcgr1HxD2xtBVR3it/TTdfFvyAYNk2T5hs/Kjb/+hjckx4zW?=
 =?us-ascii?Q?UqBy0YgrNROIJt9iMfbUnZFw+YG9WrTlpXD9qMQsfs9LkD3q9wkqIdNdIrd9?=
 =?us-ascii?Q?X2qgdR1l3ZuxjVHmLIfNmQXQrbookp2ORBAgPmmeA/+oBJSZT4GXT1Cax968?=
 =?us-ascii?Q?jrVwkrbBjNsKXaZWn5U+Abxmdf4aIuFfDyQGsMRNScJmpOZeT6Qdw30hblgG?=
 =?us-ascii?Q?Hk0SIwJsjVHkMf5C0lptNU8nk16nzeJnH9LMGUwGjUnBZF05aj9C8CXjbH26?=
 =?us-ascii?Q?7SIefqmaJpC435WD0j0ta0hUCWKTReTSK3hrCJhSfu0Cfip0NNBI7vZWCf9p?=
 =?us-ascii?Q?olpCmtgDFdSvXujLpDmr2IfB6n/xF2bXLPUnjvhSu8CrZDhoNnTCqcLYMNrR?=
 =?us-ascii?Q?0Q4nwf0t+YISRtuM5Gp+HEn/cqDpZ+Oj+UywMx2TbyCn3qTMHvb2/mRbnJLH?=
 =?us-ascii?Q?YIR8FlKF8ksf1wDGFIUz/71ExRPa4wGCgg/e8tTtTx7CRHyt3Jw5oE04yiw+?=
 =?us-ascii?Q?wE8kSA97y6bqhO04lOmI0gLP0T5WnNa6OpXsfVILxGFWSX681r9WeyzQIdC2?=
 =?us-ascii?Q?osfQIL2virEspDG82bGiwJc1pvcSIhp3Pio0pBmMA1FSkYvKX8v7Uy8fUmkK?=
 =?us-ascii?Q?Nj5Wlj0fgPqWiVKkL0SI1O2rwi/6tfjjvQSNZMcWC4vKKeWqe3ilhSts94gw?=
 =?us-ascii?Q?2pWy6UUbZERaFe5YDt7uhrE2tk1Bf7KV3ie3jyPEjDpdNpz7fo75Su1pq5lA?=
 =?us-ascii?Q?7523XQJu4jPzZpQ82F3DngTCYKVSF+5+LpWjXD6zqRPIquniAADlyd86eisa?=
 =?us-ascii?Q?5CuITmQ+B8Gldt0JrqYOPZIz1ETb3irp26ddr6shzWwkGcG3IRg/8ZIzD0Kq?=
 =?us-ascii?Q?4rP8CFrbzbHdkzmn8OVHPHXq0TBW89ZMZYMeDWJkGvawmSBf5N4NcgP1Dd15?=
 =?us-ascii?Q?ycTRxd0UErqj5myZCe4QuclQ9GXZsP+h5DQPY/9xqrKgzlS5bQMnptupLKjM?=
 =?us-ascii?Q?UI7w1+Rs53tBM5h78tGheBKPasSbmiVXyFiuh7ya2fXZ67MAiir4FL6XBbWK?=
 =?us-ascii?Q?iLxYbUXbvPkKAakU5uBtz5UsG+RDRC+lA1cUkGGQUTHYFCsGO65GRKSk4sdd?=
 =?us-ascii?Q?DTjK2BCnIkrwijXuNQDWtE2j3rSvmU/AxBnngHaoTAGEvRMKa4vV/PgBhx0S?=
 =?us-ascii?Q?hhjTW/V1tsyYp34I0QfmWTh7yrN4b5Tl+LNwCLTTK8NQllJNDa44QgadzCE+?=
 =?us-ascii?Q?5LW9Mh84NfFBX1fx3aSu0RUNgsE0ar9FZbt1ojl0CKfV119I0E9IdI7EIPg+?=
 =?us-ascii?Q?j4GCn7VWbhitLk/RLCF570TEZKZKCj39e1Ky2BYUpsLfZKZ6rK95bv6jQvwl?=
 =?us-ascii?Q?2mKDwGpqpDd0LzLTzHxUonGIZTcKCmst9oC1BcnZan/g1hB1ZtgId5n+MHXU?=
 =?us-ascii?Q?/EjKtjlwb1iYESMgRh1OdU1Y73PaU4nlpRJpXlL8vl4N5a+GdWs4xydvPue7?=
 =?us-ascii?Q?u6CqkFUDIeRKBa3o02QrdMVz972FtfXAJjoTFtmX0SxY61vOvBetW54JpF0g?=
 =?us-ascii?Q?3n1JXg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GLoTcM3mlvtfhAtX/zgBqBwDwKqTehVn2xXxVSi34922GzKzQwDViRaf9UXhUbecLtbuIBvi2tHPo2frOqFGEFald5AOQ5IV/jQRgyS0tnPoJ74ZrG2HdPC7f/YtPOYqZrJjGO1rz6atFE6P88UCn+fT3ruEwVLwa8C8+hRCUTrTAxQuwJwSLMgd0CR+uql9m6rUAa6OzYg23FfQYF0HWekc8TbOADrJheENjzo1lBFtk8HhGzOiGdTcp/LHplY2+cLDP1NYdVAdk3fnuPCceabIzMtsDlLk8OSxaaWIFBEI+8uybQ4oTUujdoFJPEGhsHUTuQqFQ+MmWYbNeF3p5oRvG7vPfOhid9EUUngcIt0neYBvsp73JWlt5lXnOLD77810YNJtp1grHoknf9aSOE4YHqDY8jf8uXpM4949xc98JOwPRm2uTcPKUPFdD8NE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 03:06:49.6631 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ae37cfd-b531-4795-5eee-08de639a7086
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6840
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

Add new functions for sending multi param send msg
and read response

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 91 ++++++++++++++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h | 10 +++
 2 files changed, 101 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 6fd50c2fd20e..d5823f475596 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -183,6 +183,68 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
 	return ret;
 }
 
+/**
+ * smu_cmn_send_smc_msg_with_multi_param -- send a message with parameter
+ * @smu: pointer to an SMU context
+ * @msg: message to send
+ * @param: parameter arr to send to the SMU
+ * @read_arg: pointer to u32 arr to return a value from the SMU back
+ *            to the caller
+ * @num_args: number of param arguments
+ * @num_out_args: number of read_arg
+ *
+ * Send the message @msg with parameter @param to the SMU, wait for
+ * completion of the command, and return back a value from the SMU in
+ * @read_arg pointer.
+ *
+ * Return 0 on success, -errno when a problem is encountered sending
+ * message or receiving reply. If there is a PCI bus recovery or
+ * the destination is a virtual GPU which does not allow this message
+ * type, the message is simply dropped and success is also returned.
+ * See smu_msg_v1_decode_response() for details of the -errno.
+ *
+ * If we weren't able to send the message to the SMU, we also print
+ * the error to the standard log.
+ *
+ * Command completion status is printed only if the -errno is
+ * -EREMOTEIO, indicating that the SMU returned back an
+ * undefined/unknown/unspecified result. All other cases are
+ * well-defined, not printed, but instead given back to the client to
+ * decide what further to do.
+ *
+ * The return value, @read_arg is read back regardless, to give back
+ * more information to the client, which on error would most likely be
+ * @param, but we can't assume that. This also eliminates more
+ * conditionals.
+ */
+int smu_cmn_send_smc_msg_with_multi_param(struct smu_context *smu,
+				    enum smu_message_type msg,
+				    uint32_t *param,
+				    uint32_t *read_arg,
+				    uint32_t num_args,
+				    uint32_t num_out_args)
+{
+	struct smu_msg_ctl *ctl = &smu->msg_ctl;
+	struct smu_msg_args args = {
+		.msg = msg,
+		.args = param,
+		.num_args = num_args,
+		.num_out_args = read_arg ? num_out_args : 0,
+		.flags = 0,
+		.timeout = 0,
+	};
+	int ret;
+	int i;
+
+	ret = ctl->ops->send_msg(ctl, &args);
+
+	if (read_arg)
+		for (i = 0; i < args.num_out_args; i++)
+			read_arg[i] = args.out_args[i];
+
+	return ret;
+}
+
 int smu_cmn_send_smc_msg(struct smu_context *smu,
 			 enum smu_message_type msg,
 			 uint32_t *read_arg)
@@ -591,6 +653,35 @@ int smu_msg_send_async_locked(struct smu_msg_ctl *ctl,
 	return ctl->ops->send_msg(ctl, &args);
 }
 
+/**
+ * smu_msg_send_async_locked_multi_param - Send message asynchronously, caller holds lock
+ * @ctl: Message control block
+ * @msg: Message type
+ * @param: Message parameter array of len ctl->config.num_arg_regs
+ * @num_args: Number of write message parameters
+ * @num_out_args: Number of read message parameters
+ *
+ * Send an SMU message without waiting for response. Caller must hold ctl->lock
+ * and call smu_msg_wait_response() later to get the result.
+ *
+ * Return: 0 on success, negative errno on failure
+ */
+int smu_msg_send_async_locked_multi_param(struct smu_msg_ctl *ctl,
+			      enum smu_message_type msg, u32 param[],
+			      u32 num_args, u32 num_out_args)
+{
+	struct smu_msg_args args = {
+		.msg = msg,
+		.args[0] = param,
+		.num_args = num_args,
+		.num_out_args = num_out_args,
+		.flags = SMU_MSG_FLAG_ASYNC | SMU_MSG_FLAG_LOCK_HELD,
+		.timeout = 0,
+	};
+
+	return ctl->ops->send_msg(ctl, &args);
+}
+
 int smu_cmn_to_asic_specific_index(struct smu_context *smu,
 				   enum smu_cmn2asic_mapping_type type,
 				   uint32_t index)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index b7bfddc65fb2..839dd03021ae 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -30,6 +30,9 @@ extern const struct smu_msg_ops smu_msg_v1_ops;
 int smu_msg_wait_response(struct smu_msg_ctl *ctl, u32 timeout_us);
 int smu_msg_send_async_locked(struct smu_msg_ctl *ctl,
 			      enum smu_message_type msg, u32 param);
+int smu_msg_send_async_locked_multi_param(struct smu_msg_ctl *ctl,
+			      enum smu_message_type msg, u32 param[],
+			      u32 num_args, u32 num_out_args);
 
 #if defined(SWSMU_CODE_LAYER_L2) || defined(SWSMU_CODE_LAYER_L3) || defined(SWSMU_CODE_LAYER_L4)
 
@@ -115,6 +118,13 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
 				    uint32_t param,
 				    uint32_t *read_arg);
 
+int smu_cmn_send_smc_msg_with_multi_param(struct smu_context *smu,
+				    enum smu_message_type msg,
+				    uint32_t *param,
+				    uint32_t *read_arg,
+				    uint32_t num_args,
+				    uint32_t num_out_args);
+
 int smu_cmn_send_smc_msg(struct smu_context *smu,
 			 enum smu_message_type msg,
 			 uint32_t *read_arg);
-- 
2.43.0

