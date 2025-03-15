Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B58AAC28B2F
	for <amd-gfx@archiver.kernel.org>; Sat, 15 Mar 2025 00:44:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56ABD10E375;
	Sat, 15 Mar 2025 00:44:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Y06vD3eF";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E0BA10E373
 for <amd-gfx@lists.freedesktop.org>; Sat, 15 Mar 2025 00:44:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ohFK9C1ILpKH+4xuhK9Bf6r3yQ1nX5u6INPAkTZ0bw5pVUKC+5MKUXLDnUkmIaTLAtJTTvmfLcVDIHVSETNFE3mQR/Q5cswQKKlJIfn6ec/Y+5juvojHTTZ3oqvav0VvjuZ5ZMXFeaUDNCZJxYYms6KRy0S1w0fj16n1XI7etb8t9j+2WvpNVt18p04mWzCz0R6nr9DbkRJtvOt1yK4RTHSSor4DE2MHDCoFLTrOJnVA2NiDXq4aPP8PHEPztrV+2ZKN6eDUxeJxI0leoTxfQBQYjx+onRZl9KYXJvd8qBDnQftCcDGjQZKNCHv6HeJY2KT3Przs7nccpbtScRzITQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e3qDaGMn0LcaC18KEftyG7AUuDqQs0F8JdLy9jhkvs0=;
 b=dG3YRWoM36pWsjidjGshDI5Zrd7d6fkzhkwxHuewMREyAe5e+jOkUzmmuukjT5KOWLMSyqsegK8fpNCQdgzm1gLxIbmjbLa71Ciiv/AOm5L8Q+xCjCTjqPDc60/Bx3x0bjPK3V+IQYJHNomlE5M/6g0qMkllcymGob9HBgFezDZRf0hsmPaIjvFkW3cYuu41NDuzA9e258ExSbeUWZWesl5qc9g538z30ZWXhTtDOXsLAaIZ1pRnAFAI4GTHawpxVG4e07OQWo2umASFz02pYxnGcqQW8oihoXyoDXpY9OYEaLxX+tZEdPi6k033PfpRBl7HMi8J4PUS0zouZh0Mlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3qDaGMn0LcaC18KEftyG7AUuDqQs0F8JdLy9jhkvs0=;
 b=Y06vD3eFArskW/f9yiOqHe7VcXWiyb+xXpNisjuaumbZZK1Q2BJ1WLP6HoWv6KjPh9ETYdz6lIgGZpmnBdiKxkfWw/TJ/bqUGAzN8QYfPWf02YSUuTRPVBhN5JXtGjLYUqND3F6ZAoROjCMJV9GnpvuUK0GX2G447y8Jtau93kA=
Received: from BN0PR04CA0042.namprd04.prod.outlook.com (2603:10b6:408:e8::17)
 by CH3PR12MB9453.namprd12.prod.outlook.com (2603:10b6:610:1c9::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Sat, 15 Mar
 2025 00:44:39 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:408:e8:cafe::ef) by BN0PR04CA0042.outlook.office365.com
 (2603:10b6:408:e8::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.28 via Frontend Transport; Sat,
 15 Mar 2025 00:44:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Sat, 15 Mar 2025 00:44:38 +0000
Received: from harish-base-compute.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 14 Mar 2025 19:44:38 -0500
From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Subject: [PATCH v3] drm/amdkfd: Fix bug in config_dequeue_wait_counts
Date: Fri, 14 Mar 2025 20:44:27 -0400
Message-ID: <20250315004427.259694-1-Harish.Kasiviswanathan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|CH3PR12MB9453:EE_
X-MS-Office365-Filtering-Correlation-Id: 91b22f9f-5935-49db-1e8c-08dd635a9100
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6ynnHqOC9pqAJ30Y75JOko3mkqrMNr674tcpkV/6xRh2fWmqOOLmxRIiaPXp?=
 =?us-ascii?Q?OfaA+4s5CFEuLB5nhOYsQ4/HMSp58tmQnZgzENJ3v8Q1VLjuMq4GG1wgnhNE?=
 =?us-ascii?Q?BkmEvHnFrPkG8OdAj2FMXIDw8hYG6eWJ5PUwzdki3gP5yv4YVHu08AFmNGIh?=
 =?us-ascii?Q?aZ8qWtEE+RmITXxOV13Ud8FmdP9BHDsVIL5D9Y8cEOOzg0ANKVZVlRnoAypk?=
 =?us-ascii?Q?aaohA/J/1wGRvx82FJYmXW+YAE0IjvpxLC2t6ZFBV7QG3IQ9PKuK0CCJKp6Y?=
 =?us-ascii?Q?ZjjJWMWfW+HBpN3N05BSc+WvOd24kk1f97eIiI6Cn2Qzcks5iAAfZPhYfSil?=
 =?us-ascii?Q?krKFWiyjb35jx6EdHmf44+dg9n2bZpvknjVBAPfu2qFf6NjpJQjMLBlhdsB9?=
 =?us-ascii?Q?Gp0xK8j4KOCcmlHZTbZTXWfGUD+1Qc4oGuZizjleBfCtYpZ5Ftllm/iY0Xl8?=
 =?us-ascii?Q?cVOhX+znFjWYPR17uHIm7PFA9VMtgCEb6A7yUBOiLokbDx1WVuQViOg8o0Rz?=
 =?us-ascii?Q?C384knklK247xoxiesYLmk15dur68/30j5Cpiz7UcynF8ORoI+tFjYvmMrLc?=
 =?us-ascii?Q?ZHBPjvgrqJouveYqafQUNejE7E01Pwsk/l7m+xfdEcnL2geeQL5DTvzqhThN?=
 =?us-ascii?Q?VBpjdLNG/wuVEhwbzO86APZ+bIq1FfErU3QTl4eGsfKpxGNJOcvAY9cgG72z?=
 =?us-ascii?Q?R5hteVZU87AqNefh2jHvUb3Evfp/ULpb2PR6TqqUBrN1xtlJ+/K33b4VIXq3?=
 =?us-ascii?Q?K5sdemAjpA7OjpAvKTj09YpQ3lbRSvuGyqrlnPWJc1DI67rtkk5Z44oGjXal?=
 =?us-ascii?Q?bBi+jdUiw37tBpGbDl63/DYXc0V9mg+SLPiQOld/AbTgzr54dlp0/r1lhz3Y?=
 =?us-ascii?Q?ljIpuDFi8iwqdi6dJzPZ42pHB/8w9fq2fuUVVtOCM8/xvx7FzGQFyWiUIYvZ?=
 =?us-ascii?Q?p0l75PBqF9piwu0Baz6B4SeFocxp6cQ5tSL9F1HB3xfICSGFkIoTPKydCGE9?=
 =?us-ascii?Q?ra0hUvtLZDajC7Mvf6RfH4fNZG1YaOiLjCFRmTzxQrzKIR27cyL5I0nkLtcj?=
 =?us-ascii?Q?PaOQAmjRgNfsxRYKCWi/q9jOBWic5HoThHtaQvJ7sWUXGR+H7Fy6ys0OMf4f?=
 =?us-ascii?Q?1oCYE3lL8WaCNVclj+POQajXFsv8oXIVApmdnmQIu4i5AVIs0b/6pkL9FceO?=
 =?us-ascii?Q?xi1W62M34/Uh5oSlaL0lzmvsjdjrKxKrWRLO7s9lKYj4C38RiBH+p+9nuySV?=
 =?us-ascii?Q?ACvQ7gzBQw68gEVhE2okU/YitfquUI684rlDhnVlR7asaxxAe2/6FgE3hGtJ?=
 =?us-ascii?Q?9StxawBarpFA2X1hkiryd4Tnkd63l0+qyQzzjTAdOenmmL8lMCq1YfuByL2B?=
 =?us-ascii?Q?QheTbW3GWtseRhoAJxUSHdNn4Ovo7939mhYpsZ/oWOv3i8rSVkJx9HiJJ95t?=
 =?us-ascii?Q?yHDfPN2QZ50UwoLOcVkaEcdksqOkVpG4+N5/aTDdk/u0e0A1XPXWH2L5J9HM?=
 =?us-ascii?Q?wUtl8GF2VTvGoP4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2025 00:44:38.6920 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91b22f9f-5935-49db-1e8c-08dd635a9100
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9453
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

For certain ASICs where dequeue_wait_count don't need to be initialized,
pm_config_dequeue_wait_counts_v9 return without filling in the packet
information. However, the calling function interprets this as a success
and sends the uninitialized packet to firmware causing hang.

Fix the above bug by not calling pm_config_dequeue_wait_counts_v9 for
ASICs that don't need the value to be initialized.

v2: Removed redudant code.
    Tidy up code based on review comments
v3: Don't call pm_config_dequeue_wait_counts_v9 for certain ASICs

Fixes: <98a5af8103f> ("drm/amdkfd: Add pm_config_dequeue_wait_counts API")

Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
---
 .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   | 16 ++++++----
 .../drm/amd/amdkfd/kfd_packet_manager_v9.c    | 30 +++++++++++--------
 2 files changed, 27 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
index 3f574d82b5fc..8a47b7259a10 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
@@ -418,6 +418,10 @@ int pm_config_dequeue_wait_counts(struct packet_manager *pm,
 	    !pm->pmf->config_dequeue_wait_counts_size)
 		return 0;
 
+	if (cmd == KFD_DEQUEUE_WAIT_INIT && (KFD_GC_VERSION(pm->dqm->dev) < IP_VERSION(9, 4, 1) ||
+	   KFD_GC_VERSION(pm->dqm->dev) >= IP_VERSION(10, 0, 0)))
+		return 0;
+
 	size = pm->pmf->config_dequeue_wait_counts_size;
 
 	mutex_lock(&pm->lock);
@@ -436,16 +440,16 @@ int pm_config_dequeue_wait_counts(struct packet_manager *pm,
 
 		retval = pm->pmf->config_dequeue_wait_counts(pm, buffer,
 							     cmd, value);
-		if (!retval)
+		if (!retval) {
 			retval = kq_submit_packet(pm->priv_queue);
+
+			/* If default value is modified, cache that in dqm->wait_times */
+			if (!retval && cmd == KFD_DEQUEUE_WAIT_INIT)
+				update_dqm_wait_times(pm->dqm);
+		}
 		else
 			kq_rollback_packet(pm->priv_queue);
 	}
-
-	/* If default value is modified, cache that value in dqm->wait_times */
-	if (!retval && cmd == KFD_DEQUEUE_WAIT_INIT)
-		update_dqm_wait_times(pm->dqm);
-
 out:
 	mutex_unlock(&pm->lock);
 	return retval;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
index d440df602393..f059041902bc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
@@ -310,6 +310,13 @@ static inline void pm_build_dequeue_wait_counts_packet_info(struct packet_manage
 		reg_data);
 }
 
+/* pm_config_dequeue_wait_counts_v9: Builds WRITE_DATA packet with
+ *    register/value for configuring dequeue wait counts
+ *
+ * @return: -ve for failure and 0 for success and buffer is
+ *  filled in with packet
+ *
+ **/
 static int pm_config_dequeue_wait_counts_v9(struct packet_manager *pm,
 		uint32_t *buffer,
 		enum kfd_config_dequeue_wait_counts_cmd cmd,
@@ -321,24 +328,21 @@ static int pm_config_dequeue_wait_counts_v9(struct packet_manager *pm,
 
 	switch (cmd) {
 	case KFD_DEQUEUE_WAIT_INIT: {
-		uint32_t sch_wave = 0, que_sleep = 0;
-		/* Reduce CP_IQ_WAIT_TIME2.QUE_SLEEP to 0x1 from default 0x40.
+		uint32_t sch_wave = 0, que_sleep = 1;
+
+		/* For all gfx9 ASICs > gfx941,
+		 * Reduce CP_IQ_WAIT_TIME2.QUE_SLEEP to 0x1 from default 0x40.
 		 * On a 1GHz machine this is roughly 1 microsecond, which is
 		 * about how long it takes to load data out of memory during
 		 * queue connect
 		 * QUE_SLEEP: Wait Count for Dequeue Retry.
+		 *
+		 * Set CWSR grace period to 1x1000 cycle for GFX9.4.3 APU
 		 */
-		if (KFD_GC_VERSION(pm->dqm->dev) >= IP_VERSION(9, 4, 1) &&
-		    KFD_GC_VERSION(pm->dqm->dev) < IP_VERSION(10, 0, 0)) {
-			que_sleep = 1;
-
-			/* Set CWSR grace period to 1x1000 cycle for GFX9.4.3 APU */
-			if (amdgpu_emu_mode == 0 && pm->dqm->dev->adev->gmc.is_app_apu &&
-			(KFD_GC_VERSION(pm->dqm->dev) == IP_VERSION(9, 4, 3)))
-				sch_wave = 1;
-		} else {
-			return 0;
-		}
+		if (amdgpu_emu_mode == 0 && pm->dqm->dev->adev->gmc.is_app_apu &&
+		    (KFD_GC_VERSION(pm->dqm->dev) == IP_VERSION(9, 4, 3)))
+			sch_wave = 1;
+
 		pm_build_dequeue_wait_counts_packet_info(pm, sch_wave, que_sleep,
 			&reg_offset, &reg_data);
 
-- 
2.34.1

