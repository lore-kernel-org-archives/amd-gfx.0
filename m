Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A247BC47BE1
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jan 2026 10:13:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4333910E4C4;
	Tue,  6 Jan 2026 10:13:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Nc7ALvVT";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011027.outbound.protection.outlook.com [52.101.62.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7277E10E4C5
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jan 2026 10:13:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TCkeWHdJcclEdQ16CygON3+PaPaQLYlzajaXxawmE0vL7n6qx52SuztdgqRtN/jnnibYiy+56UvgFgxO9nF+D5nX9ePImGcpeS7pIZitJuYF/uaMp9eW5KCXRSJLj10pESvTPWrC3kMf/qeqqkyeqpjbTpTnEHkwznqDwP/jirzHWHRQbk536omCUn2WNRW18PbOLCtiu/dPEHXY5NwfwXdMJyKCvMVLoJCVefZ2ouwTbaD1xTBWfCIeMD9WDN2KrFNDPqwFy6lxv7Or0V+h4/Y9url6wew2DiPqmeJK7gRbHijw2ly54fhwL9xLGL3IHKMWrCorZWOegoIjSMrYtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oRA3YVFkffSwxSdfSs3wnvFuZbPE3D/c0uUEolQ3tRo=;
 b=rbLISGnGjKhqkiJ0Q9CkhwtGYQyJRAoTSqA1HG3pzf6AKeap2QW/UH06gIctTG9TZB+aFypUI5XwV6LLEZ+Z78rLx3M0zpVSGSnZpFP+GpjMTGmvM0NsEqbpZecUR9FYEGTs3w1n9FHcL89IUC7UMxfgDLByIQTzfkMrJqgk1THoA7QBgOAgLVE12BseLICahCzAEDBdfU9lHvmP3P1ilIbwr5x8sn7ksOI+pHG4XlbYA+QSdcbYXDCwtjSv7fi5p91UnzWs4aRZh/o+kcsFx7UJ0E6tUPtCRhwErFCnwML/rwc1KbTvS5LlBj3U2s8ubNvuKj59GSAislvWAkTvvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oRA3YVFkffSwxSdfSs3wnvFuZbPE3D/c0uUEolQ3tRo=;
 b=Nc7ALvVT9ftVFqJBEiDyQK8DzCjwla49Gf9mXUFEHNBCdG1kO2h5HAYS7VNAdDrIxGuLrsFFAUwKJwCQ2hZLAs4QkToyWvmxArIZoIoNJWuTQlI22Wt7URnlSmXoiWPTcvD8yC7OgJqzdaKZW14D5x0p0Mcl+0em9+ndbHH5XWs=
Received: from SA1P222CA0028.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:22c::30)
 by PH7PR12MB8427.namprd12.prod.outlook.com (2603:10b6:510:242::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 10:13:52 +0000
Received: from SA2PEPF00003AEB.namprd02.prod.outlook.com
 (2603:10b6:806:22c:cafe::d5) by SA1P222CA0028.outlook.office365.com
 (2603:10b6:806:22c::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Tue, 6
 Jan 2026 10:13:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AEB.mail.protection.outlook.com (10.167.248.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Tue, 6 Jan 2026 10:13:51 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 6 Jan
 2026 04:13:49 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH v2 07/21] drm/amd/pm: Add async message call support
Date: Tue, 6 Jan 2026 15:42:27 +0530
Message-ID: <20260106101317.3856153-8-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260106101317.3856153-1-lijo.lazar@amd.com>
References: <20260106101317.3856153-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEB:EE_|PH7PR12MB8427:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b967dff-1920-441e-df74-08de4d0c4a7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?I9+zZYMx8Tc36gUL0YsCQDzt5rX0RTgmQot/Kyth/Pq6aPTPFvHmgd3Ra0XA?=
 =?us-ascii?Q?7zVw7kCD3pmO2sqgrXyC0Pwq9xIZ05HnPlND4MRJasTBbTUq2+qacnfAaU3+?=
 =?us-ascii?Q?xxujOdzY8cx/17dockzAsB8owkdG8EVUQtHRwvZd9YTVvkDmNcBZAlVmR5wu?=
 =?us-ascii?Q?hdmZSCbSXf6r+c3vtlNwIrtRbrAaOSkh3wbBwcNDgeTSj1QXVOsb+GQZstX9?=
 =?us-ascii?Q?l6+mdffxvtmvGms94ATx9Zc7vYqUV+VBTzbSxMLsiHg2CinsVeBi/aSusOJ7?=
 =?us-ascii?Q?UGuuSaDHPBJRl/Yh/D8lrR5Mbwgy9ChrgeJzcjdXPpCKLI41YDCqRsp43dIQ?=
 =?us-ascii?Q?EPYXuDnjvNYFekG0ddJ6y4xrAMHxS5OaIMcRYDxTHMlmCUotauvSmZgJZPDc?=
 =?us-ascii?Q?foNHy21RnhD/jmbZQOr4b21UPhGZr/R7nA19s2bK5mTJbvVv16nfxGSX2wxy?=
 =?us-ascii?Q?87G0rJXIsJBRxD1ChoH6p5Uda7GgjO+QTxl42FDP0CqAYS5x9uDFfyDpCZ7J?=
 =?us-ascii?Q?9G8hzyTQg6mGEbRY9u+s4B8y9R2VhgHdAwY8OEWut+g//wXGcxfalzzlS/8S?=
 =?us-ascii?Q?+UtPi8bEyuoMUZJFGDZ7qr5EDdpJPcNEZo1AmEw/9GYA68ix+S/f/lAyKjST?=
 =?us-ascii?Q?r9WjPZ4fQU69RCugNxUseHXeLOmOjfrQNZSxpr9ix6fAD+NGaZgBk7rtHC4s?=
 =?us-ascii?Q?LTfDgJcmPhv6LMKpf4cE95a1kdo6i+UZ3olJRFO5nX9nPJty4fHlYVBhcOb9?=
 =?us-ascii?Q?SONxkm8NBPihgxYj5rLDD7AD90P6d6fzmvtuontPTwKlbP6weKMPLOuNv3Q2?=
 =?us-ascii?Q?Vpg8TKhEzvFiQ8l5LLV7PoCuAQB88YHz6Q5AB6hsXwG7s1qNx64Qk4emBioN?=
 =?us-ascii?Q?4I7A6pqHVqsFYwXMSoBuRzkSFrFed8o9JVn4B+6gZxkF7ip+dNCcIel/tcui?=
 =?us-ascii?Q?tuSqvhEv4LRfia2qKIzDmoyuhXOOnuwCF5VFJeeUDv41akJ2jnzVZRUIj/bO?=
 =?us-ascii?Q?d6dNNMeYl5z6CZY6mqS4/FcLfqgvbVcJxhtGwFHLtq1FZVFHo0apWOGZEvEm?=
 =?us-ascii?Q?ZDQgsV+vPuWXTUNO1VZHqcmROe5oO9XZzIYoZmFZhcxxdFHUZMpMtk3NtSsK?=
 =?us-ascii?Q?u1e71tf7VhDpjYkhX6Hf65uVt/844mSJgmW0g2LBrwiVdfKfVmAOjYpFcBqJ?=
 =?us-ascii?Q?0vu/N1aTeZks1vWreCmlzbfpOlbKqp8NSSDurX5cGXM6RVog6FGLPo0mPuIl?=
 =?us-ascii?Q?mAlmlmiplqxQ8fxyvjusUkLmzM0lRBuRuuoPB0P7mKAWwp65Klq+/UTK/Qha?=
 =?us-ascii?Q?li38+5OAQXXPDW9PAreT8M+xLXlkFb7yxeFAhzfFr1qJ8g+kU4OgyaKZFCcu?=
 =?us-ascii?Q?XZDnhNUwi8LeKQl4wMB3Qu0txyheXeUH6sKhnSHsQazjCtRaLM3eZKr02zCI?=
 =?us-ascii?Q?YTBXkpUU+nZeq+PaZ6iZdBYe69eyt4Di9Ds8g7eZ3Fs69CyzVRNseQ0t5q0w?=
 =?us-ascii?Q?HDkATn39ANShYGbdDUr7/BtJDF6S3Vs0AyZH6gvVlX5D4coB2IxDjo8ssdxd?=
 =?us-ascii?Q?hLV2tqMzWe0LMprOecA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 10:13:51.7175 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b967dff-1920-441e-df74-08de4d0c4a7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AEB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8427
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
index 3c06ac5d23fa..03cd724a0bf8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -671,6 +671,7 @@ static int smu_msg_v1_send_msg(struct smu_msg_ctl *ctl,
 	u32 reg, msg_flags;
 	int ret, index;
 	bool skip_pre_poll = false;
+	bool lock_held = args->flags & SMU_MSG_FLAG_LOCK_HELD;
 
 	/* Early exit if no HW access */
 	if (adev->no_hw_access)
@@ -695,7 +696,8 @@ static int smu_msg_v1_send_msg(struct smu_msg_ctl *ctl,
 	if (amdgpu_sriov_vf(adev) && !(msg_flags & SMU_MSG_VF_FLAG))
 		return 0;
 
-	mutex_lock(&ctl->lock);
+	if (!lock_held)
+		mutex_lock(&ctl->lock);
 
 	/* RAS priority filter */
 	ret = __smu_msg_v1_ras_filter(ctl, args->msg, msg_flags,
@@ -727,8 +729,8 @@ static int smu_msg_v1_send_msg(struct smu_msg_ctl *ctl,
 	/* Send message */
 	__smu_msg_v1_send(ctl, (u16)index, args);
 
-	/* Post-poll (skip if NO_WAIT) */
-	if (args->flags & SMU_MSG_FLAG_NO_WAIT) {
+	/* Post-poll (skip if ASYNC) */
+	if (args->flags & SMU_MSG_FLAG_ASYNC) {
 		ret = 0;
 		goto out;
 	}
@@ -775,7 +777,8 @@ static int smu_msg_v1_send_msg(struct smu_msg_ctl *ctl,
 		WARN_ON(1);
 	}
 
-	mutex_unlock(&ctl->lock);
+	if (!lock_held)
+		mutex_unlock(&ctl->lock);
 	return ret;
 }
 
@@ -812,6 +815,32 @@ int smu_msg_wait_response(struct smu_msg_ctl *ctl, u32 timeout_us)
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
index d9a37ed4e720..13a5c1320874 100644
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

