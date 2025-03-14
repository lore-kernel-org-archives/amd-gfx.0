Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DF47C282EC
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Mar 2025 20:22:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1399410E240;
	Fri, 14 Mar 2025 20:22:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KDJrDZs1";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B26A410E240
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Mar 2025 20:22:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vsZIDxx8HKsBVBPMpB6QZzmgSYoQwt3lXDFzVsxwcd040e4IDza+UZ34doYPAnL//CC44h5kwmAYT4xYArls4pJEr+8NCQoob8J4pYXnJMm3gtrCZjZD/4xfbWQC2zEykAvmr+Th0Ginx//qWvvMzCV8qxhEyM/IIXVQMt0Px3hCe5Z5Hm0QNhpZM3Qx5AtqQhWeLOA+z3t8ASW5i0iWXsmtyz5EgbQ1DRL/yK618TDjMvY5S1WJ2jO3zk/jzJLECKQOMo36KRoCXJLWAz/Jw3/lRL4Ebk+BSi9YbrJw8prHkJRLswvULGc7/qMjLWUDk4PrkI1eLhpTRSP4xsxgtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mSNb7sEElB7MbwYmv6DtiwELdfdOyRY1fCwwdpc94w4=;
 b=gp1suFXuhKA1C0pZ4lK0llR4NuAqqy1hgUuMVZKcPc0Iq5CSKi9ibhli3iHc6faHnM1ur/+GJxgRCwB8xjTOXJlI/bBvIyol9Grg590fPGfaDvHAcLbSlO7Mkjd/QfVjo87QdIpDUbx/cOnhEgAUkGk5brbPubEK4EB3oaqKJV9Bos/7qS5oHfo4aDK1wNqIDZB7kuTfjpKQVhHcVA3wNdFCQC+grv1lI/ykgizRzY+5H2BtqBEc5ybSXFKxzBTDq4T9iPDykIINJWkgXgJEX2J16W4JaDZCSD4jXbsxV6Afr7zf8raN9CkSMd3eo3SIyiHtweiRRArnftXxrCgiPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSNb7sEElB7MbwYmv6DtiwELdfdOyRY1fCwwdpc94w4=;
 b=KDJrDZs1K5M4KIZi4Xmuvh3iLB1YlbhC9fCoYudYIUWB5vj7JU+qQ6jADMAxN7SQayYyTOrcyix2tugtxNF/FY11tPUCY6V9ZdWLZjNd4aGPv7I98l8SyEOVBWmxJa8H6uPzTW6Xgd+nqaA4bX6bgf6cPJR18QyfEP1kjX1jlz8=
Received: from SJ0PR05CA0006.namprd05.prod.outlook.com (2603:10b6:a03:33b::11)
 by PH7PR12MB7987.namprd12.prod.outlook.com (2603:10b6:510:27c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Fri, 14 Mar
 2025 20:22:34 +0000
Received: from SJ5PEPF000001F0.namprd05.prod.outlook.com
 (2603:10b6:a03:33b:cafe::d9) by SJ0PR05CA0006.outlook.office365.com
 (2603:10b6:a03:33b::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.24 via Frontend Transport; Fri,
 14 Mar 2025 20:22:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F0.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Fri, 14 Mar 2025 20:22:33 +0000
Received: from harish-base-compute.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 14 Mar 2025 15:22:33 -0500
From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Subject: [PATCH v2] drm/amdkfd: Update return value of
 config_dequeue_wait_counts
Date: Fri, 14 Mar 2025 16:22:11 -0400
Message-ID: <20250314202211.251641-1-Harish.Kasiviswanathan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F0:EE_|PH7PR12MB7987:EE_
X-MS-Office365-Filtering-Correlation-Id: c8282fed-b92a-485c-5173-08dd6335f45a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?j4uMBvz+RIIb8fR7BjWjyGpBlB3+KA0PxlBZgLSNgtaSLLGg8tT67BJMLnqF?=
 =?us-ascii?Q?z/gjnt9xU0baIwFQJivIl4r+toYmuyJ2GisOhcNIBrzA188fL/GyEDc1g5Yr?=
 =?us-ascii?Q?wxlDS+tQMo5OcVCsAW9syRUzqC61xEuVwQHLIzgk+SgVjM8JghXIxD9PtIZQ?=
 =?us-ascii?Q?6SC3KNJL4P7P0AEj/wLUQfPwfqFW5eL0fCkbrSU31NODnTSB/oNis6j92Lz0?=
 =?us-ascii?Q?J9eddmQGp4o+gQlaHyaorxLY0lVLyKugpq7+qxUpv583kOgLzTR/AEsoQLWo?=
 =?us-ascii?Q?hy0XgVKLWqzJ8ITIxZMMv2SxETzwwVKSuVui1V3792o7QSXiTtXq1JDUK0K6?=
 =?us-ascii?Q?lUplY4fKHSQU42aYaLNjAuIzlNKfeHM5B66pLoR3lXUhEj0IJakbx6mQ1asI?=
 =?us-ascii?Q?0Kcfy4loEjjdVMzDKDJtDdxmKb55sDv/BIYVhIDpC9TwbLx5UPPWNtFduXmo?=
 =?us-ascii?Q?ZTM+2UyHHsWu3F/nyTF7qSbBcstmjlXvjbn/2qKM+oRja0uWewt56KedMIrR?=
 =?us-ascii?Q?82ew9LRSRhMiOKwsd5J7poNG62yrDPj2pSSB+dRDWb787GuWiYBFhMP86AAd?=
 =?us-ascii?Q?p7meJl27kzyebdYACpjdv7ohVWAeq/d/Qkg9yMH0JY9PY34H3prgaKI3edby?=
 =?us-ascii?Q?HLlkxzJJuvEjTCdzHboMvw2LYuMhCchED21UXmGt2ZlPHVtfHK23Le9xTMjH?=
 =?us-ascii?Q?OAqOnd5ne5wtKNzgMSPEx8WjEFjwTmHXwHAy1kcTLHcK4XVZTehCpTI/iJF7?=
 =?us-ascii?Q?cWpmASHf86adOpulV6jWewKPVc9lp4cF6a+9ehZazS6rUcK9/G+rXsrl0Tmc?=
 =?us-ascii?Q?LrcHtE2x9mwKm7iAf4/8Ir/PUnqp07y5yQBsMKS1WgthPFza7ZWd2qMAKqQ9?=
 =?us-ascii?Q?OKp0RvYREOf8o8vQ9Txst7+KcQ9DZSsyFvgymuD2n22A91JNnyxgsK859ITB?=
 =?us-ascii?Q?9pR9ItJx8mGOh8ee3/+7jP9ARktlA/86NYfFcvolF5MpCjpn6zMnKHa/beA7?=
 =?us-ascii?Q?HbPEIN7GVAJHseDHwUcLt81OsgkfafSe4hYoptkJ6IJIFjm7VvfroJ5AVSus?=
 =?us-ascii?Q?n6f0F2gRFZ3rkvR0WVE3SVX1egQvGMiRE31JypMsTBVRCUARjtz30AULXvnt?=
 =?us-ascii?Q?fFhIkfDIcu4SfTwGA7eIA2hjnbzyJAu9jJ9UoRcZqaO8fLG4YZikjkpG9P3o?=
 =?us-ascii?Q?42NgsclCpUrCFMXArKh+PlD6LaPJlx+euQo9oud3+4YVFmys0C6FEYIrS5dU?=
 =?us-ascii?Q?zC4veuhackKcspeE2xdQfYcKVAzTgAawwsExrTc7VuNy9lvkmgQZm7CWlyWJ?=
 =?us-ascii?Q?HlEWVC37ZVz5anUOsGTHGQxdJvNHzun4Jkg7Gj7gKchELdZw1ByU+G9HQzvj?=
 =?us-ascii?Q?vEwzjWIshrkfpxdcJyX6V7r/ttPuI+nkc1E0atMo/AAAu1H2mJtLlub7hRoo?=
 =?us-ascii?Q?ZRAFvxQOI089iCPcs0q7IOveqyoSIW3hsInVpDxMe7Q9cwVQjYFBz4esC4Iv?=
 =?us-ascii?Q?1fIVXRQwOp54/l0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 20:22:33.9048 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8282fed-b92a-485c-5173-08dd6335f45a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7987
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

.config_dequeue_wait_counts returns a nop case. Modify return parameter
to reflect that since the caller also needs to ignore this condition.

v2: Removed redudant code.
    Tidy up code based on review comments

Fixes: <98a5af8103f> ("drm/amdkfd: Add pm_config_dequeue_wait_counts API")

Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
---
 .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   | 14 ++++----
 .../drm/amd/amdkfd/kfd_packet_manager_v9.c    | 36 +++++++++++--------
 2 files changed, 29 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
index 3f574d82b5fc..502b89639a9f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
@@ -436,19 +436,19 @@ int pm_config_dequeue_wait_counts(struct packet_manager *pm,
 
 		retval = pm->pmf->config_dequeue_wait_counts(pm, buffer,
 							     cmd, value);
-		if (!retval)
+		if (retval > 0) {
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
-	return retval;
+	return retval < 0 ? retval : 0;
 }
 
 int pm_send_unmap_queue(struct packet_manager *pm,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
index d440df602393..3c6134d61b2b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
@@ -310,6 +310,13 @@ static inline void pm_build_dequeue_wait_counts_packet_info(struct packet_manage
 		reg_data);
 }
 
+/* pm_config_dequeue_wait_counts_v9: Builds WRITE_DATA packet with
+ *    register/value for configuring dequeue wait counts
+ *
+ * @return: -ve for failure, 0 for nop and +ve for success and buffer is
+ *  filled in with packet
+ *
+ **/
 static int pm_config_dequeue_wait_counts_v9(struct packet_manager *pm,
 		uint32_t *buffer,
 		enum kfd_config_dequeue_wait_counts_cmd cmd,
@@ -321,24 +328,25 @@ static int pm_config_dequeue_wait_counts_v9(struct packet_manager *pm,
 
 	switch (cmd) {
 	case KFD_DEQUEUE_WAIT_INIT: {
-		uint32_t sch_wave = 0, que_sleep = 0;
-		/* Reduce CP_IQ_WAIT_TIME2.QUE_SLEEP to 0x1 from default 0x40.
+		uint32_t sch_wave = 0, que_sleep = 1;
+
+		if (KFD_GC_VERSION(pm->dqm->dev) < IP_VERSION(9, 4, 1) ||
+		    KFD_GC_VERSION(pm->dqm->dev) > IP_VERSION(10, 0, 0))
+			return 0;
+
+		/* For all other gfx9 ASICs,
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
 
@@ -377,7 +385,7 @@ static int pm_config_dequeue_wait_counts_v9(struct packet_manager *pm,
 
 	packet->data = reg_data;
 
-	return 0;
+	return sizeof(struct pm4_mec_write_data_mmio);
 }
 
 static int pm_unmap_queues_v9(struct packet_manager *pm, uint32_t *buffer,
-- 
2.34.1

