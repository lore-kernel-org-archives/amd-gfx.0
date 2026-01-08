Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2CBFD1489F
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 04:49:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7048310E67F;
	Thu,  8 Jan 2026 04:49:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TjLxrsVQ";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011019.outbound.protection.outlook.com [52.101.62.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E19F10E67F
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 04:49:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eYgJySMfw0FSu0ftJEkwr+jcc7lWwTLLDy4Kx+s/Up+okBk3qcZiqpw2jdY5rEVbsYjXbmsxD1h2msvZczugobDuVfxzvLupxc4dBx9OgQi1MWwbwgTYij9RYTrPTcN1+9ACHzIa+3ktlypbNNyfwahj1PpneMJxzMwedQpcKSlk2GrK22WLLzkagSlZQXUNAKZIwIAmZCqbX9sYYoE9sIGLevlO9LERkC2q8fWEDZ4o/H1JF/qrkP/9obvFxQdgAVdxyFoOhEs0qbSeQrFs1QzCwNVk/87ZjRjiVJCTOQ5Q1greM9C3wXvsTblulr/+xkaF2KnmZkB5SgxOZgvNlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7yM9d+NovfdnshamcSTutMiTYrt3gNJtcEKUqKVEFmU=;
 b=NI3Y058AQjW6H53mO5rVXuEESGHRFzynDk3lg6qKgadCgajSah87QTGffpw4yzC7eJaVbCUGrJBbPO1NyHmWbQwvVbDwyTnnTt5i4SaAeh6W0shAP4Lixnc5oXuDt+PhxLDEWAzJS1B56HD8Iq4pR0xFu7EBHbuPds82NybGAwOBSMw1Y2c0QRuDEnEoIHET4DxgiLLyrR+7Pz5HUgR9M5Ztye7cflhWEPG07gIm6RR2SiAXX+nGPNs1xGZSyEyPXYyeBeJ9gwdvo/8xUUHhEikG5XSCE6Ci5Le0ZLTNcGAZAUe1od/HmfP4KQ7M52cmt5pPc3BOxT2TdO7H7DAObw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7yM9d+NovfdnshamcSTutMiTYrt3gNJtcEKUqKVEFmU=;
 b=TjLxrsVQPMzzrRQRF4SVz94rWDEvEgOoy28H21s2YKQD/Srr0bU4UlSt2juAXmtnJ2fMQHfGRqlglvs5Op8X67aUmWyucFu0pp0agT4e81QsesiFiJOgOm0bP7PnQaAHtgg1HhyMXxvaq5XPlrjrS9+6Hd1s+YMq+DvItn8mLM8=
Received: from DM6PR11CA0001.namprd11.prod.outlook.com (2603:10b6:5:190::14)
 by CH1PR12MB9623.namprd12.prod.outlook.com (2603:10b6:610:2b3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 04:49:30 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:5:190:cafe::39) by DM6PR11CA0001.outlook.office365.com
 (2603:10b6:5:190::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.2 via Frontend Transport; Thu, 8
 Jan 2026 04:49:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 04:49:30 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 7 Jan
 2026 22:49:28 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>, Asad Kamal
 <asad.kamal@amd.com>
Subject: [PATCH v3 08/24] drm/amd/pm: Add async message call support
Date: Thu, 8 Jan 2026 10:17:24 +0530
Message-ID: <20260108044839.4084279-9-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|CH1PR12MB9623:EE_
X-MS-Office365-Filtering-Correlation-Id: b564f8b7-6030-4410-ae3f-08de4e714fb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tQ9Y//HaiJkhi1czfXC+V0FjnuqrJIQDEPTiU68Rd/GYJOiNxnoCVEMRDTD8?=
 =?us-ascii?Q?MfPyA5jOSoNhMEg/6iASnqnUIROuAuy5d/O9rtT7DDUICTA1Ql7NjJy3zqRA?=
 =?us-ascii?Q?28eaMjF7tFSt0qd7BUQcz8J69/G2jPI4ZzmdsdPQmGKOUxHXft7kgIEkgZ5Z?=
 =?us-ascii?Q?k9C6LL3qNKqex6w7l6lqvedrgVpDlhpwzlVmQXkyoUSRlE+bYupY53qmBuFD?=
 =?us-ascii?Q?oquSPr/imYYfDmjrfrtXZ1SCvlarrkuwynKPwUnG4zc/BRiixsL5fTm/w4Je?=
 =?us-ascii?Q?cbTYe+k5JVSDYHEo/KK0+ItOmp1gYM0lipBxUIOs0arR8WPnuzQKMxogqmie?=
 =?us-ascii?Q?iQJSUaoM9/I59HkYYIqVTYvLZsI0NCalg67X6KdxOx4CBk++kcgsHqScoT5Z?=
 =?us-ascii?Q?CE98eu9APIJmGFLsQ7fw/yfWTSpUoJ4jTdQONlU3HQasottNT7xMf781Ymh3?=
 =?us-ascii?Q?zpRqtD7OTtQLAk06gcBDLAay1Ivc/4glJb242Zv41v4rKJkfxR5zFIH3Pp1g?=
 =?us-ascii?Q?37VgEP1IETIsC0cp4aWUxoDYEptVOqgtVXMNcGsdCMzHDahrBiRloHfEjnpN?=
 =?us-ascii?Q?TzGKE3L0yPnHnJsAUsD9b++5OSZCDtgrM0IEv3w9nGhkiqazvtc8cl7J2l55?=
 =?us-ascii?Q?sTyYMcP2xPpW4lDGJHhUjuWF2+fYkdkhSk9FlUWR8GLn1t8VN8EwzvhnvXR0?=
 =?us-ascii?Q?I0tZDzF5p1dkfhjdIPPJfe4yAX/5u5ZzcJttI1279h+y10JlapnKRxInt2a6?=
 =?us-ascii?Q?aHTyjWZeQfOD6vBqvq23jGxWvfv1Qkg5z+JezIopEYUW43KwjcUtlzN4XR+z?=
 =?us-ascii?Q?e99CCLwbiXUbUmXcjROVsq5s7wwF+OkH3WRJrceY4hr1xQ8FZexa+SgQgUrn?=
 =?us-ascii?Q?VIw64UKmW6i/MJiJLxZAGRYh3zbYJSf4NIijZOQdFS780VNLev9goYhC0coS?=
 =?us-ascii?Q?Sy+EvKj2xAPg2K/QOMB56Dw28y3D8lG9L4nO2ONaOelkP5BvyiBJ7GumZB8H?=
 =?us-ascii?Q?CAYRKFG9GtTkC4cMo5BnCeYuiJYqST7sTlniNSHB0qjDSZXkb0DefobmoRRb?=
 =?us-ascii?Q?EIpxQEwzOsEUblNXCZ2vNm5MYM19vEjC3oSTFk+Ukhc4L4knlQllU2nplhXh?=
 =?us-ascii?Q?tz9p2k66P3odpIrKv13EuiYGdD496aAQPDImEB35YnPn8TG149uPgPyO3z2G?=
 =?us-ascii?Q?AL9RK4UFtct7M0mCJTyJHZyNNnOXi0IwFyOW9lTF0WRm307Lupk5lDdQkKsV?=
 =?us-ascii?Q?/3WBDmf6aZkae4/Pdb203ACxWe5TtWe+6+ub9CU2PFRL549MUSva7jCplx/e?=
 =?us-ascii?Q?GPFxsXB54tnyBiHjpFb14mnNyps59ZV0rPi2/d72L/KkODR7UC3M6tparSRu?=
 =?us-ascii?Q?F+eLbVvXU5dSF29SHWWGYGYX4mbvL6UoGR/HnRRZ+oKmOr9liJLaovSw1UHn?=
 =?us-ascii?Q?qvWU2/zgoFfU1UQPopi6cyZv+kFrEIECgkUWZql3xrWxU9Dj3pgdfUFMwmO3?=
 =?us-ascii?Q?UOWtLoK3r3nWyq4OWxA1dVr9bmLP8hBipkWqI4PRWqjd26wgKanSuHL2QhPR?=
 =?us-ascii?Q?V1VM7jGA6YPZnlV1zeU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 04:49:30.8309 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b564f8b7-6030-4410-ae3f-08de4e714fb9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9623
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
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  3 +-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 37 +++++++++++++++++--
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |  2 +
 3 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 842ae201a8ca..3b2937c07cad 100644
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
index ef603a4d57f6..ce2986276a81 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -546,6 +546,7 @@ static int smu_msg_v1_send_msg(struct smu_msg_ctl *ctl,
 	u32 reg, msg_flags;
 	int ret, index;
 	bool skip_pre_poll = false;
+	bool lock_held = args->flags & SMU_MSG_FLAG_LOCK_HELD;
 
 	/* Early exit if no HW access */
 	if (adev->no_hw_access)
@@ -570,7 +571,8 @@ static int smu_msg_v1_send_msg(struct smu_msg_ctl *ctl,
 	if (amdgpu_sriov_vf(adev) && !(msg_flags & SMU_MSG_VF_FLAG))
 		return 0;
 
-	mutex_lock(&ctl->lock);
+	if (!lock_held)
+		mutex_lock(&ctl->lock);
 
 	/* RAS priority filter */
 	ret = __smu_msg_v1_ras_filter(ctl, args->msg, msg_flags,
@@ -602,8 +604,8 @@ static int smu_msg_v1_send_msg(struct smu_msg_ctl *ctl,
 	/* Send message */
 	__smu_msg_v1_send(ctl, (u16)index, args);
 
-	/* Post-poll (skip if NO_WAIT) */
-	if (args->flags & SMU_MSG_FLAG_NO_WAIT) {
+	/* Post-poll (skip if ASYNC) */
+	if (args->flags & SMU_MSG_FLAG_ASYNC) {
 		ret = 0;
 		goto out;
 	}
@@ -650,7 +652,8 @@ static int smu_msg_v1_send_msg(struct smu_msg_ctl *ctl,
 		WARN_ON(1);
 	}
 
-	mutex_unlock(&ctl->lock);
+	if (!lock_held)
+		mutex_unlock(&ctl->lock);
 	return ret;
 }
 
@@ -687,6 +690,32 @@ int smu_msg_wait_response(struct smu_msg_ctl *ctl, u32 timeout_us)
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

