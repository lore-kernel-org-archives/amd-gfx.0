Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B068BD65C49
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Dec 2025 13:56:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A88B10ECE3;
	Wed, 17 Dec 2025 13:56:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E1WpJXKe";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012044.outbound.protection.outlook.com [40.107.209.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66CB010ECE3
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Dec 2025 13:56:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C6iEsA/PutIqmHK+yR7fh3yQiIIgNkZeZhgyVhvKFMdPjwsEBEBVZ0cn9Bm3xOAjMhvr0qooEZyiibtGsnIjEqlrSHb2zY1vbPT7uGRDzni9hv+X9QiZKsmsPHKnvMTxqpSm0grjmDGm8zDQK7ziemAAelDhoddDPqxoTaFxvvnYloHTLbFvJPLgk0DwZuS8fpZo4wIuZGdOZDtMZFMRFUspp13zXnz8e9plTspI2CTnuOsZcKuXFm/R1uCywBI1/NNHEpl5yHqokQBkTmzaaB0eXvFtL9umM5WI4NZlIvm9JinzNKp88A0uzNz9z1eZUQj9d7RvffdKesOL3167Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kn3Qxek155AhsxQyr7dAKpGImSxEEY2o+fAbI8KFlwE=;
 b=P+NJr4FETduiF9ayWfvwWpw3iyVn0Q+92RXE04uk8thPVZx+tZ/ToPb9kavXKdgaXFcgvMr2L10x4JmoX56bcYGVsUUgTD63167gNve7KJgKB7FqvtJ+d32xJR5cVdMlJtHPA9XK6byuG6F3D87+lkcnoEQPTxYq9PqSGTQ8FbQ2np47mXbWzet3rxUFBZ6FVN1ggGSnqmy85EHNLPjiIlUE6lBoYOf91yPY2D4AGMlPEFJpJ2oV2gJi9h18GiF141Vt1NX+urPC4M1KEIp4E9eH+P9nR8TEhvqb89cL0GIvn0peiOtJRdc0jheF5xWJMz8z6pSibIFE2rGp065NUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kn3Qxek155AhsxQyr7dAKpGImSxEEY2o+fAbI8KFlwE=;
 b=E1WpJXKeFChaxylOwOWsCiPu+q9xd1I/Xa5rG+36T5+UaIHxecsDhOT48vzkBRGU9Ffo8J3PFrGmmsmwVlk0GOLJ96nwlbjkubOnTG/yaH8cIsdiTaBMmL6yo3adb1bnP3Z0g3C9cDnmmKE9VKgmvMxRc52ArwnxP8VWtNr/QY8=
Received: from CH5P222CA0011.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::26)
 by MN2PR12MB4374.namprd12.prod.outlook.com (2603:10b6:208:266::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 13:55:09 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:1ee:cafe::8a) by CH5P222CA0011.outlook.office365.com
 (2603:10b6:610:1ee::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.7 via Frontend Transport; Wed,
 17 Dec 2025 13:55:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Wed, 17 Dec 2025 13:55:07 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 07:55:03 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH 07/21] drm/amd/pm: Add async message call support
Date: Wed, 17 Dec 2025 19:18:00 +0530
Message-ID: <20251217135431.2943441-8-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|MN2PR12MB4374:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d80670f-2e17-49d3-5418-08de3d73e34c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+IkTKmNfKefNwv7AoeHtSTlsIic3Ffb4bRxM4DlP3m05NgepyfUORDJvLq+p?=
 =?us-ascii?Q?noNsCjlyhJ6ZDiWbg58zWBzmsM10PE3d5N9Q4skQe8fgc9NC3rjHpGtpdD4d?=
 =?us-ascii?Q?inHv10u2tP+m1cu6mW+sP7cdpXCmVFQpcjA7Y9tHZp3HtWMlNSWtlGMV7/KF?=
 =?us-ascii?Q?derbnc7IKBmGDv5M/Xl3nb6Mh4+EjTWV5PYljZudDONcwqvDJCUFsi7erv01?=
 =?us-ascii?Q?0kVTYUx94Tlnr3UeTI1udOi6mw0ZrI9KkN2sOL8rHDrhfusyLa54zjSNwxBL?=
 =?us-ascii?Q?y45AuMT/7ulllFEdn60awM1funZrBCUJ1M+LP8HZzeFGeXVI6qKcBrR/T29L?=
 =?us-ascii?Q?EPmiVQizF75JY9DsIkWVioQxvZ6rTztNR2GpG91J6zEWQOjI716TLaYESGQB?=
 =?us-ascii?Q?+pu/KkTrzKRqanDAbgbZMOMFa5OsSgCdbdlZxHvNps0s1t6rH/ZNBHqD2oD2?=
 =?us-ascii?Q?VpsONZmgbO/qvG0gnxzC+uPBLjZE2pwivv+zGnEOyzyfCJnl1HRzhIr4PISd?=
 =?us-ascii?Q?C+LgM286XVTdxGI47ShR5r/kwf8lOwKpdyJmpQvltc0B52X7OIphIJm2Bee9?=
 =?us-ascii?Q?RUCN7RTNduXsj8OWqb62XvVkeJJ5ifweV1pSXtCPeOzUxKiGPtFU99QFEHf4?=
 =?us-ascii?Q?jnVcreN8eqw1a5tR1g6wMAJtM/sQ5w15xn3CEqWu1G825ARzOTazUrAJX4N4?=
 =?us-ascii?Q?/tfYi+rF76k4xENGoaqdUohmw7i18XiTpT7bKVN63KLW9PpnlwZ7MHZpoJUA?=
 =?us-ascii?Q?zewrjMOtF31/4LmqA/PfmUXg9M+5iysNRJpu/VbQYDcdYjuEZeNyu+O7cVxd?=
 =?us-ascii?Q?yaWt25r2K/MZOZj+y/Ub65Sh47ezZcxfkw0pTEAuVNxmBVAH/qukK7TQGw5X?=
 =?us-ascii?Q?E300NYNZ5dq2uivdOLThLB+WJZGUpPs9T8qZlBAdp4zlC6bnlTIxs1DH4AM8?=
 =?us-ascii?Q?IVoOnbM5HXAEYc2uWdyQyoXlBhR64dgjy7CALLCmew3BMD+SgNiNeScCVcSj?=
 =?us-ascii?Q?D6xdXwt1vE3265CEAxbRA4mV/dVePs0fN5vImRwLCv4m2AIOUg3Qt+gUu8mM?=
 =?us-ascii?Q?CHWEH9QA2hCCwKzO/ubEDkoIn0noaCHu8lQv+waisHTjmZ613olw0ZFEciTi?=
 =?us-ascii?Q?tFtDTvk/1oYOsPWX4P0Ym9OP7Vx3pHGmdKOH0fm8NyL82L/uYCWLTwFfPB5z?=
 =?us-ascii?Q?j1/OMhNVK8PfKzGQ7MqKWJZjm8i1WxLvUz6zYkKsvQIUOrSeKMKa12yJjCzs?=
 =?us-ascii?Q?dEbU+qM9dzJ0/WjUpJIDBGTfCexIw3dM7BIqYyO9mZyuK4rzGWXdkqwkCav8?=
 =?us-ascii?Q?1dToN3O+CXOHWUn3yk0+SMskqHPmcFfRcYLAegDXdufMZvOhe/QyOCbsyARy?=
 =?us-ascii?Q?n1PYkNxYI+53+S40Nuu8tApFKLXyBK7NQFBHv9IfarDZxsRPp5L8DVPcNOOd?=
 =?us-ascii?Q?5uMj5eF9chDardxdDws460iyXEr36SPbbiv62+kttafqWrqg1LoigflRz7eL?=
 =?us-ascii?Q?XTdIsf7M3muRjIbGIk2XYHRXRq/fwefq9jSLhZpk/r5iEClWcCBtZdpB/wbu?=
 =?us-ascii?Q?LQzgKeGPJa2MQ13HyCM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 13:55:07.6631 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d80670f-2e17-49d3-5418-08de3d73e34c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4374
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

Add asynchronous messaging (message which doesn't wait for response)
using message control block.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  3 +-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 37 +++++++++++++++++--
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |  2 +
 3 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 41f27fb4af4b..e98a1e765f1c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -554,7 +554,8 @@ struct cmn2asic_mapping {
 #define SMU_MSG_MAX_ARGS 4
 
 /* Message flags for smu_msg_args */
-#define SMU_MSG_FLAG_NO_WAIT BIT(0) /* Skip post-poll (for split send/wait) */
+#define SMU_MSG_FLAG_ASYNC	BIT(0) /* Async send - skip post-poll */
+#define SMU_MSG_FLAG_LOCK_HELD	BIT(1) /* Caller holds ctl->lock */
 
 struct smu_msg_ctl;
 /**
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 1e6a8623a300..3561b388de7b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -640,6 +640,7 @@ static int smu_msg_v1_send_msg(struct smu_msg_ctl *ctl,
 	u32 reg, msg_flags;
 	int ret, index;
 	bool skip_pre_poll = false;
+	bool lock_held = args->flags & SMU_MSG_FLAG_LOCK_HELD;
 
 	/* Early exit if no HW access */
 	if (adev->no_hw_access)
@@ -660,7 +661,8 @@ static int smu_msg_v1_send_msg(struct smu_msg_ctl *ctl,
 	if (amdgpu_sriov_vf(adev) && !(msg_flags & SMU_MSG_VF_FLAG))
 		return 0;
 
-	mutex_lock(&ctl->lock);
+	if (!lock_held)
+		mutex_lock(&ctl->lock);
 
 	/* RAS priority filter */
 	ret = __smu_msg_v1_ras_filter(ctl, args->msg, msg_flags,
@@ -692,8 +694,8 @@ static int smu_msg_v1_send_msg(struct smu_msg_ctl *ctl,
 	/* Send message */
 	__smu_msg_v1_send(ctl, (u16)index, args->args[0]);
 
-	/* Post-poll (skip if NO_WAIT) */
-	if (args->flags & SMU_MSG_FLAG_NO_WAIT) {
+	/* Post-poll (skip if ASYNC) */
+	if (args->flags & SMU_MSG_FLAG_ASYNC) {
 		ret = 0;
 		goto out;
 	}
@@ -731,7 +733,8 @@ static int smu_msg_v1_send_msg(struct smu_msg_ctl *ctl,
 		WARN_ON(1);
 	}
 
-	mutex_unlock(&ctl->lock);
+	if (!lock_held)
+		mutex_unlock(&ctl->lock);
 	return ret;
 }
 
@@ -768,6 +771,32 @@ int smu_msg_wait_response(struct smu_msg_ctl *ctl, u32 timeout_us)
 	return ctl->ops->wait_response(ctl, timeout_us);
 }
 
+/**
+ * smu_msg_send_async_locked - Send message asynchronously, caller holds lock
+ * @ctl: Message control block
+ * @msg: Message type
+ * @param: Message parameter
+ *
+ * Send an SMU message without waiting for response. Caller must hold ctl->lock
+ * and call smu_msg_wait_response() later to get the result.
+ *
+ * Return: 0 on success, negative errno on failure
+ */
+int smu_msg_send_async_locked(struct smu_msg_ctl *ctl,
+			      enum smu_message_type msg, u32 param)
+{
+	struct smu_msg_args args = {
+		.msg = msg,
+		.args[0] = param,
+		.num_args = 1,
+		.num_out_args = 0,
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
index 6ba62180e544..fba813e46f7b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -28,6 +28,8 @@
 extern const struct smu_msg_ops smu_msg_v1_ops;
 
 int smu_msg_wait_response(struct smu_msg_ctl *ctl, u32 timeout_us);
+int smu_msg_send_async_locked(struct smu_msg_ctl *ctl,
+			      enum smu_message_type msg, u32 param);
 
 #if defined(SWSMU_CODE_LAYER_L2) || defined(SWSMU_CODE_LAYER_L3) || defined(SWSMU_CODE_LAYER_L4)
 
-- 
2.49.0

