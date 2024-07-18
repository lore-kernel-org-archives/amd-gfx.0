Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2375AC3DA61
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 23:05:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C790810EB47;
	Thu, 18 Jul 2024 23:05:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="glSVGD7H";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC46F10EB50
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 23:05:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q3PcsR9+im4Epa4KPkDgwOCj++L6cXHq1Mta+4zplI+3e38Ve3Qbqjn8cF1s7vzup+WZhGAaWq+jvnvB9hBpEkF+KK3FU+NP0IsXlNeuIg4z7MJp8yOmnRCws/v2+3RqksqFTsGYFP1XrzDptEqZo7zLA1L/qIUrOxy6UPKFKp7F8DM0QE7ciOfzscg8oAeY3qFWnaOG6I+EIY17V1HFPprmhKOfmh8g3ju0wPf13Igy08HXMYW5pfSC5aQNOIBi3ow/XyRkOdF3vfR2ACLKOc27L5VGH/sQ9VYCSzxUvCvKt+JwQjFUdZjsY6G04J+xcieAG0kCBnT7KBnV6m1m8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UswayHfO7CZF8oIhvl/DVwiMHNHXz7ALrOWaYUwKp5E=;
 b=nfyIAB74Elij7ihnM0ctH/GhT9Nme3EQzrqQnZYgHEZDmLD1SH9IuSu3Xn/g2TytcJ3Ty+RTciwHwIfZU3buYS6MrxymxI/z5J9JqBnw7TEvWOVye1YKMSTChC62tkmU8KqtVJxR+xSpV9he08qTR4EXQ1bcNbCPOaBeLaifKP6qPqH2euxE7C9DIHTFOj8fVzbr+keuFjSw2d4ePUpmy9YrQh1euFy2Wg8890d3WQatKqiZGz73RBdfCtcMiphXv+etGsHzYB/h11QDUGu5Wkun1TDa/zLyqOOHt0bSiSIFts75XyTsLNhTvWGnU4U+M2YmaJR6WcGI7dQ1rC2ijQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UswayHfO7CZF8oIhvl/DVwiMHNHXz7ALrOWaYUwKp5E=;
 b=glSVGD7Hp64QcQtsW3WUWzM4tJ8+1jZX5MlgSrbqLH4fkXTLS0cNegw46dG8WAFEoZOZuLrrhAchEp21Tx7brMIdkDK658c2rN8zx3D/jxVN5oBTh7/LKLv1j4hr4zrwZ+lvZcGg+pYv0hAum2KO3+7Fwnn2eA/nvTKcDTQMb3Q=
Received: from DM6PR03CA0078.namprd03.prod.outlook.com (2603:10b6:5:333::11)
 by SJ0PR12MB6832.namprd12.prod.outlook.com (2603:10b6:a03:47e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18; Thu, 18 Jul
 2024 23:05:19 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:5:333:cafe::3b) by DM6PR03CA0078.outlook.office365.com
 (2603:10b6:5:333::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Thu, 18 Jul 2024 23:05:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 18 Jul 2024 23:05:18 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 18 Jul
 2024 18:05:17 -0500
From: Jonathan Kim <Jonathan.Kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jonathan Kim <Jonathan.Kim@amd.com>, Jonathan Kim <jonathan.kim@amd.com>
Subject: [PATCH] drm/amdkfd: allow users to target recommended SDMA engines
Date: Thu, 18 Jul 2024 19:05:05 -0400
Message-ID: <20240718230505.1025287-1-Jonathan.Kim@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|SJ0PR12MB6832:EE_
X-MS-Office365-Filtering-Correlation-Id: 62f72a5b-225f-4c80-7889-08dca77e1797
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?47eIAX4WJbICnQbXjA+2y81+xMbISh6dImIJgxF6M7jYf7r3wReZS94bUNAd?=
 =?us-ascii?Q?jnfQ0GdC9sEA8IfPzmkM3budLlbV2L0fogC/5tBbLLGufhd0gYWtxit23Hlo?=
 =?us-ascii?Q?Ct/WE97EjDsUtyHxxcPKvYgo3oQnwzIlFrPeMYIZsv0IghHQ+cd1PK/n47Fc?=
 =?us-ascii?Q?lofeilMGMFMV4OC6zlG8+60eG36HNPbTkQstOer6XDUAcwt/T4HXu1iA+1CK?=
 =?us-ascii?Q?/PhNTcWRIeKddN//mJYvtJ8QVNL/H1ayHN6VWEdKUsti7w1HMK5r+LrdNJ7j?=
 =?us-ascii?Q?Je2S7llSdfffm3qGnokyPB8BN4h9JFB6g1wGxey4ixtsrb8/8IJFY1nlqYER?=
 =?us-ascii?Q?JAtEVsBjHqLZr0UOwcyjWFB7kHElk9z8qFIy6HQ3Vl81Ml+mkXUWlY808WZl?=
 =?us-ascii?Q?9xL+J2bERIVfzw/obDts9rmMSGlNQ/i6198jFsJzjsblyiOfSYxFFE+adpTI?=
 =?us-ascii?Q?6tgjXnWMPSXkMQqHNJkkEwP1YMT/avKv5xfCUsAFsGK/CRaeBnYvxaCU67NI?=
 =?us-ascii?Q?o1dog5I+g6NVEQ6MQB/k3PrOyaAlxRMV3y0J9YtaR4Dl8LvEBH6K39lhahnR?=
 =?us-ascii?Q?6SvqDUPHn3/JMsljYaSrP/iBsTriw+uIIrtUduugb7B9mjrkyDQMihsQMrij?=
 =?us-ascii?Q?rckm5/JA4Oc6yXymsnJPRvhRDTBEbNwsl1kkC5tNOfgrs6W43+uFXHlrONqK?=
 =?us-ascii?Q?Js6pvYSVqrwZXB3Eb2vhZ3YupfTtdcfhEvDuo/nweMqDVsRrfzKNvqN31ipu?=
 =?us-ascii?Q?7Rx+7fIQUiU0zulyIe1hQO/JufLzmu3max2qgTUlKVlaxPlrrG+258oyVijg?=
 =?us-ascii?Q?lIU+MOUsT9q5EVeevVgl1v7LRCy4kuMEo/61jGJIPGlnzJgR2GfsFjfj1IKq?=
 =?us-ascii?Q?Nwxye2KFyWSsl2zloJwZ5S2OWoUT7QCtwFh/36PBOAuJBZkfXSwxW3DXFkNq?=
 =?us-ascii?Q?xDVao9dBnmSkEjk6rE7CiCfb4nyAQShmR8JiL2jbEgsVMEAtHJR8ILcJq2L3?=
 =?us-ascii?Q?Ya6mBtaQAVtpHQrlN0llol20Z1wWITLXCUdgGQfXaMYsQjTVNqpVmz180nU7?=
 =?us-ascii?Q?xbU55c84BLPelnAsUvSn8t1C6oKc+e9f9MOUecoPGUE3c+jDZOabLzbUbluZ?=
 =?us-ascii?Q?Aj3Md4Wa2H59MdGQgfuQsPCS0Olpzm7LGMJhKdx1i+aW53tIJmLL2ONDORgC?=
 =?us-ascii?Q?rM94aZQaevluIp3h9BC8Yo53x4ni+5heTTQU2/Rv8q0+w9plWB2AXiikaeET?=
 =?us-ascii?Q?ZUTLrutpAzUAtsU3RMgCIdVjVpnOo2eKkTIXEGOnh3upSnHuTdIT9A70v4/Y?=
 =?us-ascii?Q?q4lblYtHW2DX3va7f2+gH7vxC0j/FZmBhBpoCYb+Mv/wySESkixGHa2gFUQB?=
 =?us-ascii?Q?f8BugXVXT1VvcpB8V0DKWKvz1if1e7ttaS2qPSY5bKzSZY2FWeo7wA6bc3TB?=
 =?us-ascii?Q?Hw9wa+cilH2lqInB0gWBRzhXJ4hNUkHP?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 23:05:18.2350 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62f72a5b-225f-4c80-7889-08dca77e1797
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6832
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

Certain GPUs have better copy performance over xGMI on specific
SDMA engines depending on the source and destination GPU.
Allow users to create SDMA queues on these recommended engines.
Close to 2x overall performance has been observed with this
optimization.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 16 ++++++
 drivers/gpu/drm/amd/amdkfd/kfd_crat.h         |  3 +-
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 39 +++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  5 +-
 .../amd/amdkfd/kfd_process_queue_manager.c    |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c     | 52 +++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_topology.h     |  1 +
 include/uapi/linux/kfd_ioctl.h                |  6 ++-
 8 files changed, 119 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 32e5db509560..9610cb90a47e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -255,6 +255,7 @@ static int set_queue_properties_from_user(struct queue_properties *q_properties,
 			args->ctx_save_restore_address;
 	q_properties->ctx_save_restore_area_size = args->ctx_save_restore_size;
 	q_properties->ctl_stack_size = args->ctl_stack_size;
+	q_properties->sdma_engine_id = args->sdma_engine_id;
 	if (args->queue_type == KFD_IOC_QUEUE_TYPE_COMPUTE ||
 		args->queue_type == KFD_IOC_QUEUE_TYPE_COMPUTE_AQL)
 		q_properties->type = KFD_QUEUE_TYPE_COMPUTE;
@@ -262,6 +263,8 @@ static int set_queue_properties_from_user(struct queue_properties *q_properties,
 		q_properties->type = KFD_QUEUE_TYPE_SDMA;
 	else if (args->queue_type == KFD_IOC_QUEUE_TYPE_SDMA_XGMI)
 		q_properties->type = KFD_QUEUE_TYPE_SDMA_XGMI;
+	else if (args->queue_type == KFD_IOC_QUEUE_TYPE_SDMA_BY_ENG_ID)
+		q_properties->type = KFD_QUEUE_TYPE_SDMA_BY_ENG_ID;
 	else
 		return -ENOTSUPP;
 
@@ -334,6 +337,18 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
 		goto err_bind_process;
 	}
 
+	if (q_properties.type == KFD_QUEUE_TYPE_SDMA_BY_ENG_ID) {
+		int max_sdma_eng_id = kfd_get_num_sdma_engines(dev) +
+				      kfd_get_num_xgmi_sdma_engines(dev) - 1;
+
+		if (q_properties.sdma_engine_id > max_sdma_eng_id) {
+			err = -EINVAL;
+			pr_err("sdma_engine_id %i exceeds maximum id of %i\n",
+			       q_properties.sdma_engine_id, max_sdma_eng_id);
+			goto err_sdma_engine_id;
+		}
+	}
+
 	if (!pdd->qpd.proc_doorbells) {
 		err = kfd_alloc_process_doorbells(dev->kfd, pdd);
 		if (err) {
@@ -425,6 +440,7 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
 	if (wptr_bo)
 		amdgpu_amdkfd_free_gtt_mem(dev->adev, wptr_bo);
 err_wptr_map_gart:
+err_sdma_engine_id:
 err_bind_process:
 err_pdd:
 	mutex_unlock(&p->mutex);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.h b/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
index a8ca7ecb6d27..e880a71837bc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
@@ -259,7 +259,7 @@ struct crat_subtype_ccompute {
 #define CRAT_IOLINK_TYPE_OTHER		16
 #define CRAT_IOLINK_TYPE_MAX		255
 
-#define CRAT_IOLINK_RESERVED_LENGTH	24
+#define CRAT_IOLINK_RESERVED_LENGTH	20
 
 struct crat_subtype_iolink {
 	uint8_t		type;
@@ -276,6 +276,7 @@ struct crat_subtype_iolink {
 	uint32_t	minimum_bandwidth_mbs;
 	uint32_t	maximum_bandwidth_mbs;
 	uint32_t	recommended_transfer_size;
+	uint32_t	recommended_sdma_eng_id_mask;
 	uint8_t		reserved2[CRAT_IOLINK_RESERVED_LENGTH - 1];
 	uint8_t		weight_xgmi;
 };
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 4f48507418d2..58d7710ebb30 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1534,6 +1534,42 @@ static int allocate_sdma_queue(struct device_queue_manager *dqm,
 			q->sdma_id % kfd_get_num_xgmi_sdma_engines(dqm->dev);
 		q->properties.sdma_queue_id = q->sdma_id /
 			kfd_get_num_xgmi_sdma_engines(dqm->dev);
+	} else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_BY_ENG_ID) {
+		int i, num_queues, num_engines, eng_offset = 0;
+		bool free_bit_found = false, is_xgmi = false;
+
+		if (q->properties.sdma_engine_id < kfd_get_num_sdma_engines(dqm->dev)) {
+			num_queues = get_num_sdma_queues(dqm);
+			num_engines = kfd_get_num_sdma_engines(dqm->dev);
+			q->properties.type = KFD_QUEUE_TYPE_SDMA;
+		} else {
+			num_queues = get_num_xgmi_sdma_queues(dqm);
+			num_engines = kfd_get_num_xgmi_sdma_engines(dqm->dev);
+			eng_offset = kfd_get_num_sdma_engines(dqm->dev);
+			q->properties.type = KFD_QUEUE_TYPE_SDMA_XGMI;
+			is_xgmi = true;
+		}
+
+		/* Scan available bit based on target engine ID. */
+		for (i = 0; i < num_queues; i++) {
+			int tmp_eng_id = eng_offset + i % num_engines;
+
+			if (!(q->properties.sdma_engine_id == tmp_eng_id &&
+			    test_bit(i, is_xgmi ? dqm->xgmi_sdma_bitmap : dqm->sdma_bitmap)))
+				continue;
+
+			clear_bit(i, is_xgmi ? dqm->xgmi_sdma_bitmap : dqm->sdma_bitmap);
+			q->sdma_id = i;
+			q->properties.sdma_queue_id = q->sdma_id / num_engines;
+			free_bit_found = true;
+			break;
+		}
+
+		if (!free_bit_found) {
+			dev_err(dev, "No more SDMA queue to allocate for target ID %i\n",
+				q->properties.sdma_engine_id);
+			return -ENOMEM;
+		}
 	}
 
 	pr_debug("SDMA engine id: %d\n", q->properties.sdma_engine_id);
@@ -1786,7 +1822,8 @@ static int create_queue_cpsch(struct device_queue_manager *dqm, struct queue *q,
 	}
 
 	if (q->properties.type == KFD_QUEUE_TYPE_SDMA ||
-		q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) {
+		q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI ||
+		q->properties.type == KFD_QUEUE_TYPE_SDMA_BY_ENG_ID) {
 		dqm_lock(dqm);
 		retval = allocate_sdma_queue(dqm, q, qd ? &qd->sdma_id : NULL);
 		dqm_unlock(dqm);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 2b3ec92981e8..7d26e71dfd04 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -414,13 +414,16 @@ enum kfd_unmap_queues_filter {
  * @KFD_QUEUE_TYPE_DIQ: DIQ queue type.
  *
  * @KFD_QUEUE_TYPE_SDMA_XGMI: Special SDMA queue for XGMI interface.
+ *
+ * @KFD_QUEUE_TYPE_SDMA_BY_ENG_ID:  SDMA user mode queue with target SDMA engine ID.
  */
 enum kfd_queue_type  {
 	KFD_QUEUE_TYPE_COMPUTE,
 	KFD_QUEUE_TYPE_SDMA,
 	KFD_QUEUE_TYPE_HIQ,
 	KFD_QUEUE_TYPE_DIQ,
-	KFD_QUEUE_TYPE_SDMA_XGMI
+	KFD_QUEUE_TYPE_SDMA_XGMI,
+	KFD_QUEUE_TYPE_SDMA_BY_ENG_ID
 };
 
 enum kfd_queue_format {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 21f5a1fb3bf8..8adf20760e67 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -345,6 +345,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 	switch (type) {
 	case KFD_QUEUE_TYPE_SDMA:
 	case KFD_QUEUE_TYPE_SDMA_XGMI:
+	case KFD_QUEUE_TYPE_SDMA_BY_ENG_ID:
 		/* SDMA queues are always allocated statically no matter
 		 * which scheduler mode is used. We also do not need to
 		 * check whether a SDMA queue can be allocated here, because
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 6f89b06f89d3..f6effaabd4b0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -292,6 +292,8 @@ static ssize_t iolink_show(struct kobject *kobj, struct attribute *attr,
 			      iolink->max_bandwidth);
 	sysfs_show_32bit_prop(buffer, offs, "recommended_transfer_size",
 			      iolink->rec_transfer_size);
+	sysfs_show_32bit_prop(buffer, offs, "recommended_sdma_engine_id_mask",
+			      iolink->rec_sdma_eng_id_mask);
 	sysfs_show_32bit_prop(buffer, offs, "flags", iolink->flags);
 
 	return offs;
@@ -1265,6 +1267,55 @@ static void kfd_set_iolink_non_coherent(struct kfd_topology_device *to_dev,
 	}
 }
 
+#define REC_SDMA_NUM_GPU	8
+static const int rec_sdma_eng_map[REC_SDMA_NUM_GPU][REC_SDMA_NUM_GPU] = {
+							{ -1, 14, 12, 2, 4, 8, 10, 6 },
+							{ 14, -1, 2, 10, 8, 4, 6, 12 },
+							{ 10, 2, -1, 12, 14, 6, 4, 8 },
+							{ 2, 12, 10, -1, 6, 14, 8, 4 },
+							{ 4, 8, 14, 6, -1, 10, 12, 2 },
+							{ 8, 4, 6, 14, 12, -1, 2, 10 },
+							{ 10, 6, 4, 8, 12, 2, -1, 14 },
+							{ 6, 12, 8, 4, 2, 10, 14, -1 }};
+
+static void kfd_set_recommended_sdma_engines(struct kfd_topology_device *to_dev,
+					     struct kfd_iolink_properties *outbound_link,
+					     struct kfd_iolink_properties *inbound_link)
+{
+	struct kfd_node *gpu = outbound_link->gpu;
+	struct amdgpu_device *adev = gpu->adev;
+	int num_xgmi_nodes = adev->gmc.xgmi.num_physical_nodes;
+	bool support_rec_eng = !amdgpu_sriov_vf(adev) && to_dev->gpu &&
+		adev->aid_mask && num_xgmi_nodes &&
+		(amdgpu_xcp_query_partition_mode(adev->xcp_mgr, AMDGPU_XCP_FL_NONE) ==
+		      AMDGPU_SPX_PARTITION_MODE) &&
+		(!(adev->flags & AMD_IS_APU) && num_xgmi_nodes == 8);
+
+	if (support_rec_eng) {
+		int src_socket_id = adev->gmc.xgmi.physical_node_id;
+		int dst_socket_id = to_dev->gpu->adev->gmc.xgmi.physical_node_id;
+
+		outbound_link->rec_sdma_eng_id_mask =
+			1 << rec_sdma_eng_map[src_socket_id][dst_socket_id];
+		inbound_link->rec_sdma_eng_id_mask =
+			1 << rec_sdma_eng_map[dst_socket_id][src_socket_id];
+	} else {
+		int num_sdma_eng = kfd_get_num_sdma_engines(gpu);
+		int i, eng_offset = 0;
+
+		if (outbound_link->iolink_type == CRAT_IOLINK_TYPE_XGMI &&
+		    kfd_get_num_xgmi_sdma_engines(gpu) && to_dev->gpu) {
+			eng_offset = num_sdma_eng;
+			num_sdma_eng = kfd_get_num_xgmi_sdma_engines(gpu);
+		}
+
+		for (i = 0; i < num_sdma_eng; i++) {
+			outbound_link->rec_sdma_eng_id_mask |= (1 << (i + eng_offset));
+			inbound_link->rec_sdma_eng_id_mask |= (1 << (i + eng_offset));
+		}
+	}
+}
+
 static void kfd_fill_iolink_non_crat_info(struct kfd_topology_device *dev)
 {
 	struct kfd_iolink_properties *link, *inbound_link;
@@ -1303,6 +1354,7 @@ static void kfd_fill_iolink_non_crat_info(struct kfd_topology_device *dev)
 			inbound_link->flags = CRAT_IOLINK_FLAGS_ENABLED;
 			kfd_set_iolink_no_atomics(peer_dev, dev, inbound_link);
 			kfd_set_iolink_non_coherent(peer_dev, link, inbound_link);
+			kfd_set_recommended_sdma_engines(peer_dev, link, inbound_link);
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
index 2d1c9d771bef..43ba67890f2c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
@@ -121,6 +121,7 @@ struct kfd_iolink_properties {
 	uint32_t		min_bandwidth;
 	uint32_t		max_bandwidth;
 	uint32_t		rec_transfer_size;
+	uint32_t		rec_sdma_eng_id_mask;
 	uint32_t		flags;
 	struct kfd_node		*gpu;
 	struct kobject		*kobj;
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index 285a36601dc9..71a7ce5f2d4c 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -42,9 +42,10 @@
  * - 1.14 - Update kfd_event_data
  * - 1.15 - Enable managing mappings in compute VMs with GEM_VA ioctl
  * - 1.16 - Add contiguous VRAM allocation flag
+ * - 1.17 - Add SDMA queue creation with target SDMA engine ID
  */
 #define KFD_IOCTL_MAJOR_VERSION 1
-#define KFD_IOCTL_MINOR_VERSION 16
+#define KFD_IOCTL_MINOR_VERSION 17
 
 struct kfd_ioctl_get_version_args {
 	__u32 major_version;	/* from KFD */
@@ -56,6 +57,7 @@ struct kfd_ioctl_get_version_args {
 #define KFD_IOC_QUEUE_TYPE_SDMA			0x1
 #define KFD_IOC_QUEUE_TYPE_COMPUTE_AQL		0x2
 #define KFD_IOC_QUEUE_TYPE_SDMA_XGMI		0x3
+#define KFD_IOC_QUEUE_TYPE_SDMA_BY_ENG_ID	0x4
 
 #define KFD_MAX_QUEUE_PERCENTAGE	100
 #define KFD_MAX_QUEUE_PRIORITY		15
@@ -78,6 +80,8 @@ struct kfd_ioctl_create_queue_args {
 	__u64 ctx_save_restore_address; /* to KFD */
 	__u32 ctx_save_restore_size;	/* to KFD */
 	__u32 ctl_stack_size;		/* to KFD */
+	__u32 sdma_engine_id;		/* to KFD */
+	__u32 pad;
 };
 
 struct kfd_ioctl_destroy_queue_args {
-- 
2.34.1

