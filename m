Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E28C5C282EC
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Mar 2025 16:17:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84A0E10E20D;
	Fri, 14 Mar 2025 16:17:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k0na8tGn";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2198610EA10
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Mar 2025 16:17:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yXtyLD/ERWNdJL5Q/50iJ49yMaXjMeTKQChuvyqfL8LMh6MxRGjMTCsgjr6dj0BCF0CbwRqY1XH0VcGHb7YX4jpIdHBG/G6uLdsD7aY/twSyQ+nJ3u9EIfk+6tcMSRYzFrVJ38YDzwAyqojOuBZl070AzKOyqpK5+05Ax7F5NTnpqmZRhVP+EoT2LUgXQVmSCxgI/VyW40KOqL+LW2RRy2CsfFm8LIgYiJ0SiyUTFZCm5DPcSeZgouB5DoJLParbWurvi5+EpY1qCK0SP3GtBHyCBU4c2cmuVH0h8n6vU1H3lzg4hEhOpt2QLXfn7Y4ZvUE1HIQ9YqZ7Cc41OQxkkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Kkee4BPMBYLX61rDt3+H3vhMvQ6kJqQrog2/YzV9qk=;
 b=mXqoUUAy+vDWo6nLMUr8FH3VFR1S2GBWTWYhvuDi4ssKt+vSnUKHoh4zvJUd91MLnmu3ShWiUu4P2Ib7byirvfC3Ih4JmC6PfPoF91a9XeeOkkO2MYBzrCz1QTlDinMMOnDZUH7s76pW7Ko0yIfQeV3BeNXcCol+TrHShwWJA0XpVQSFSfm2SY7zxUiCbV0gFNAfmE4aOit8W/6Fvpgz6OUXdQiHWA63N22QrB4HFXu/Wr2ttC/13hepy2YWOQkSQCD/I/DLPQFOyyC++/jkiA0mHWe+c1iy4ZIfZQ32ZrcACo20HgQ+nGKlKq5zCGgpWqeAF5wSOzMD5sl8sxHXFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Kkee4BPMBYLX61rDt3+H3vhMvQ6kJqQrog2/YzV9qk=;
 b=k0na8tGnCvbvBetOCn6cJUHX356FzirAmIn50cQ8aDjcJ7+5wAq3iijCZ1eDISCgZfPJ6aptc+I18jsBSJqP6i+0TZBoHAi+QMY0oS/C8cGYzLdirAK+SMNDaPKh0nR0Cr3VsTnPwFP40HbaQxtoHiTaoRg11oAxXB5/jW6+tBA=
Received: from SN6PR08CA0027.namprd08.prod.outlook.com (2603:10b6:805:66::40)
 by IA1PR12MB8586.namprd12.prod.outlook.com (2603:10b6:208:44e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.29; Fri, 14 Mar
 2025 16:17:08 +0000
Received: from SA2PEPF00003F68.namprd04.prod.outlook.com
 (2603:10b6:805:66:cafe::d6) by SN6PR08CA0027.outlook.office365.com
 (2603:10b6:805:66::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.27 via Frontend Transport; Fri,
 14 Mar 2025 16:17:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F68.mail.protection.outlook.com (10.167.248.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Fri, 14 Mar 2025 16:17:07 +0000
Received: from harish-base-compute.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 14 Mar 2025 11:17:07 -0500
From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Subject: [PATCH] drm/amdkfd: Update return value of config_dequeue_wait_counts
Date: Fri, 14 Mar 2025 12:16:54 -0400
Message-ID: <20250314161654.235110-1-Harish.Kasiviswanathan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F68:EE_|IA1PR12MB8586:EE_
X-MS-Office365-Filtering-Correlation-Id: afe196c2-8c53-4069-8aa7-08dd6313aaea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?psFGvwNb4ePvy91DvGOUksD+lVF7zXQTUID0tFZoarmxQ5zshBdem79E0e23?=
 =?us-ascii?Q?E86q52ANRTYAvVC0KpiygXMxC4sS1CfftyQfCXVPTGhFufwftJYYB3i30tqU?=
 =?us-ascii?Q?Re0952/fgE/blEs2gTwA0EnhAHXLuAEOi5OQpIpAzAAyUwU0iSfB4/72PQp3?=
 =?us-ascii?Q?gp6cpx9j20IaUnKAYaLBZz7zu8UCMQmMNLX1mhHtd5mZeQS/ii/wLoBUG/qc?=
 =?us-ascii?Q?+lUDIO33GJc4RAel6MUysYUfMmc2mmGdmW5THlLAi9OwTXAPIoizJ8BouQaB?=
 =?us-ascii?Q?dwwEni+JCiltP6IiQUeTr9rgIs8sRxEz09rK2SKvJ+TCsaYvRNF5rDhjBec7?=
 =?us-ascii?Q?ET0j3mknIsjKA4seLo3P7KNovyckXtVQGwlSqtnefaxpqoi4Elr61TG9kc9J?=
 =?us-ascii?Q?TiH7y1fiHa4XrLMJRjk1mjQi7PaYb1b9zC3J6IJSiOIGu3q6GQ7fj8NKQg4Y?=
 =?us-ascii?Q?R7Sv5PpdS1wV5Y26ksqbQeZlR7NeO6udte5cxNVK/SGDc8HwrVtXpxy5wUFf?=
 =?us-ascii?Q?zB6aCmaAiqgRiFdasQP5hBzgC5brha/ufpfGaOj61kNzLa0E5B/pk8tMs+jX?=
 =?us-ascii?Q?JMrC5QLhcIkfEmneGksK5SvFpfWb9m2Gt8BluIHYileL+up8fItyyawb3B8S?=
 =?us-ascii?Q?wNuNxco5oaLaW1WF4Rwqew6QmPkalLkcmsBWKYmwyGN6xqG9wCN6XCfFX/WJ?=
 =?us-ascii?Q?24UlrY/SW9NZ2d8J6ZbELvLYwqyHAq7gATtfOOf9fwZ5b2clXihfkwN9yVfs?=
 =?us-ascii?Q?bQdg+/lCtcJXo9ahdqfArkJO13M+CrA17dYixpNr8o3uxT8IoX5NO4gnemw8?=
 =?us-ascii?Q?rPxgy7u0JJkoTCszseFSNMqPPY1BcdHvMlWjGmrrbemnCQBvKLNhtWcKV8Ap?=
 =?us-ascii?Q?xaoDLYmkaZnkmVEusksJuOKojtteum6GZjZOKhpzfeI6u/GLG8ju68n43Z4B?=
 =?us-ascii?Q?ffPn9VOERchVkruR9HrWMLn+ZDPzNGk1IKkgxe5HbH5TNHpib0rWG3zwlBHv?=
 =?us-ascii?Q?euMyu8vV2b0wW8A8fVNaFI69W01iziqnpH6U+sXR2fOgyadluvR8ZWPT+V0W?=
 =?us-ascii?Q?g359ERxIom74lOCl2VNBdaSYu3oZ0XdbWnsu/vlIoYcvgKBAU2EYncggA1O0?=
 =?us-ascii?Q?S+WQsels59WsmBdb77imkbrVglFP0HT+cQ9E76TG8zLX3vJeNImSJ9qSDhBp?=
 =?us-ascii?Q?1kd1snOODLoNSzXbDxbMZXK3cM8eEEj+s98Y6hKTnUJz4J6OD++x5NkQ+A4H?=
 =?us-ascii?Q?Z6zJDVjkk/fhL64TYPS3i3tmj9lF0yxR7JWmfrTBRNOb3Ax/IBo2m39rTDQ5?=
 =?us-ascii?Q?96q0lv/uxUcTMFQujRBekxDPJ2LVI0No1q9frMXfAA0drL10jVtvIp9qDaGC?=
 =?us-ascii?Q?+1z5dEOCTcFtAGUzrrya0fo1n8Cqzn1JoVN5gOQrb0WfFcTdMtatmGlWI1Y4?=
 =?us-ascii?Q?/ybdcSz+MkkkQ93NHoPJoPfXJxeX84g3xOG8/xt3pTOJe8gsdV55obpZcc+u?=
 =?us-ascii?Q?7Km8JQ85y0bgzxs=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 16:17:07.9035 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afe196c2-8c53-4069-8aa7-08dd6313aaea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F68.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8586
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

Fixes: <98a5af8103f> ("drm/amdkfd: Add pm_config_dequeue_wait_counts API")

Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c    | 11 ++++++++---
 drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c |  9 ++++++++-
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
index 3f574d82b5fc..47de572741e7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
@@ -436,19 +436,24 @@ int pm_config_dequeue_wait_counts(struct packet_manager *pm,
 
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
 
 	/* If default value is modified, cache that value in dqm->wait_times */
-	if (!retval && cmd == KFD_DEQUEUE_WAIT_INIT)
+	if (retval > 0 && cmd == KFD_DEQUEUE_WAIT_INIT)
 		update_dqm_wait_times(pm->dqm);
 
 out:
 	mutex_unlock(&pm->lock);
-	return retval;
+	return retval < 0 ? retval : 0;
 }
 
 int pm_send_unmap_queue(struct packet_manager *pm,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
index d440df602393..af3a18d81900 100644
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
@@ -377,7 +384,7 @@ static int pm_config_dequeue_wait_counts_v9(struct packet_manager *pm,
 
 	packet->data = reg_data;
 
-	return 0;
+	return sizeof(struct pm4_mec_write_data_mmio);
 }
 
 static int pm_unmap_queues_v9(struct packet_manager *pm, uint32_t *buffer,
-- 
2.34.1

