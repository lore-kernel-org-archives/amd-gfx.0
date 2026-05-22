Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 307A4CD5BAB
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2026 00:21:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B18C310E1EE;
	Fri, 22 May 2026 00:21:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2gjJBm0I";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013024.outbound.protection.outlook.com
 [40.93.196.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7845E10E1EE
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2026 00:21:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dj5Bf7fHgkH8SjraGHaWRXJhc4pF2B+OXG4B1idLQtI1Ii5ig7oI3NFd+xzS01HgmM1PUA77wxVVwr/OWilbu8iaUXyvXDqrxcIRLmV4DYf+Le1M8BB6jqe/9LE4pODsgJH+bTvoZd37e1xae6+FHZGUSciXWpLSyKVBHlGCHyxNVCwSn3RtO3kvzYYRe4NcP6sJA/yFb4Wf04Q+9AKcDONVKXnwXnFVlx9XEPYDadGZwADyUCQKnkIYSQWNVA1VCz0fS6IoVOUfOG+ri8b8Z2aP4+lB+hddpmhqNxFA/VapIyE3MEuvI6jBtGLovSc5nYVHmqsfiMmTM9vQQ/INaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fjcFZzCeDNdYH6Ql2zeOktonVVUVRkgo9mT8Tqmkizo=;
 b=MtlIYPgow7eIfYTbuAwEit6v/cGzZNEDEcg04XObWDDL7qigisjj7iE/lC54MGVUiSX125AlA6G7uZS8Y36n4/1sxeeWkHdWcFVxA6gT6EzZjM2bFNfcNJljoAMxNKmO2L2FGmQtTCBxCvORsrf6XTFPVSV3IvCdGQWHil6kGNjHJKcOn3RP7b7APYzi8lIIUW2jn0I4QzQ9yKtK/dakN1O5OSMTiKAKw/n+p0jO6P2ioIsFPr6l5+T37NihwS1kQZmKQUNOboYhLN5Juai85nVnRnobh+AnhAMzshapjf6K/M8Dfe/4eaTjwyzUWIkxU+P0sFECSMUCUUijlsj4ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fjcFZzCeDNdYH6Ql2zeOktonVVUVRkgo9mT8Tqmkizo=;
 b=2gjJBm0Il6wWnX9pktCtB1ByDIzqn0gZ+HsH4SRZDRa/HyrT1oEOwgsbE0fwoZz8fpQcKA/6NXasoIFrYKPdLe78/nWNMfrUhyPv/4lHIWJb9l9UuteJyAAn64rlDj59fnVo9/5bOJFn6HuUDMBcdRZ/h6rvN/EBf1Zy61cw38c=
Received: from MW4P222CA0004.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::9)
 by MN0PR12MB6029.namprd12.prod.outlook.com (2603:10b6:208:3cf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Fri, 22 May
 2026 00:21:11 +0000
Received: from SJ1PEPF00002319.namprd03.prod.outlook.com
 (2603:10b6:303:114:cafe::b7) by MW4P222CA0004.outlook.office365.com
 (2603:10b6:303:114::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Fri, 22
 May 2026 00:21:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002319.mail.protection.outlook.com (10.167.242.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Fri, 22 May 2026 00:21:10 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 21 May
 2026 19:21:10 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 21 May
 2026 17:21:09 -0700
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 21 May 2026 19:21:09 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sunil.khatri@amd.com>, <Amber.Lin@amd.com>, <Jesse.Zhang@amd.com>,
 <Shaoyun.Liu@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 01/42] drm/amdkfd: always resume_all after suspend_all
Date: Thu, 21 May 2026 20:20:07 -0400
Message-ID: <20260522002048.98506-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522002048.98506-1-alexander.deucher@amd.com>
References: <20260522002048.98506-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002319:EE_|MN0PR12MB6029:EE_
X-MS-Office365-Filtering-Correlation-Id: ade7fb99-6c12-4802-fb5f-08deb7980687
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|22082099003|18002099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info: 0LuqMLoxXVS3250N+dFPwvEi3RXevOud2UlCq2qeSh3+NVZ/Vhjan/TxcQ8/g6a2SmGvEC+FllpVwszRALb51FyV/5MthKTvh7yEDFcpjRuSSELCp5gaufjNADpyshs3YA3pL0bierGHeH4aQgmTKIzNoqiNOB23vIVMLjwE42TSn+Ke838uq8msyc2iV6KZQmq7nL/+NoGR3eUj/mHfViuV6pf1Mav5Fb8XZXbIhUyaLrl95Ch/dviPr0AlxBaYFLKmBzSLs+O8i2L2zkp4MsmAXZH1jqldKcbLRGiORjBjw6MxD6ydTTrPIDHf2e5+Z7hzpY62pqKpFQ1aHtc+OTFYa7BoHjaIqs4Nb/WCvWqQRgmols+xuK2JoJ+LQ4nND8rccamzgpNRfruoD0hU7P76GWz714v7ekgEJS06WravflIwaRE4wOkN4gDATPe22J6FdeBx37JHCnAdUp/YmwU9lJ1O1eji848NqqRym2IS+oxHX739Cm9wcBjzCIbQWgvBF8CPdX5Ko5F7hfRsUvu3SPigJgvWZwok9C02TQDUeacur8u0xYOvjmMNJ64oNvGDVnvr9akDsqC5X29JnyJTPCIiFiXqmxYVUUcHjCGdcgUUtc0UzVLF07e6sfPhJYYN43pfx2Igfqy4mQ6f+pIzsHC/yWK2/MoYF8vGJm7tBxn7Ab0xbnrZcNRVmBPDWolpyfziWtV1mzj+5woXh/pQ7aqBnrHWNWWf8Txs3SY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(22082099003)(18002099003)(56012099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: agDs6ratR3hra5Ux9UxmyVDUHW1dNDQL2Kvuqa/zrq5tzzh7esOFy5bBdFYKUD5BIsUHMrrQTJ2A7cNuc1tQUiJkP4WG2CoznmwOWbGmTmyr19wf0SiMsJQ+pJ6sFRP/fuAzRRqDnRbnpqEWsgFeCNnhWJ0u1d+kVFW+kWCBxQY5ZDbcjO7F6ZFOe+NmfZh2oU7B7X6nP6XXEoRGKhi8se+oVraBRdBN0gmEmKP4/uDWBK3MSwHxBF0Y1hZ38uR5AugqdzAmQH6QysoiSbUp/sxXOaJ9VECnIpqbiXWg/QwXgdA87DzzQM4wRtpjTx0xmeBBATFfjZubv1pRMkVy8NGf/PPkHR5F3iGC5XMnefWM2nL7+o3MXZm4IsZ99vlV+bhP7+8W9PG63i44zjAcxD6QXeQyLtiDYGed56WDxATG2PV/hg5BRzvUD/RS/eWM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 00:21:10.4558 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ade7fb99-6c12-4802-fb5f-08deb7980687
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002319.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6029
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

Need to restore any good queues even if the suspend_all
failed for some.  Always run remove_queue as that will
schedule a GPU reset is removing the queue fails.

v2: move resume_all after remove

Fixes: eb067d65c33e ("drm/amdkfd: Update BadOpcode Interrupt handling with MES")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 20 ++++++-------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index c351f7cff0553..08006ce8126c9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -3258,32 +3258,24 @@ int kfd_dqm_suspend_bad_queue_mes(struct kfd_node *knode, u32 pasid, u32 doorbel
 
 		list_for_each_entry(q, &qpd->queues_list, list) {
 			if (q->doorbell_id == doorbell_id && q->properties.is_active) {
-				ret = suspend_all_queues_mes(dqm);
-				if (ret) {
-					dev_err(dev, "Suspending all queues failed");
-					goto out;
-				}
+				/* suspend all queues will save any good queues and mark the rest as bad */
+				suspend_all_queues_mes(dqm);
 
 				q->properties.is_evicted = true;
 				q->properties.is_active = false;
 				decrement_queue_count(dqm, qpd, q);
 
+				/* this will remove the bad queue and sched a GPU reset if needed */
 				ret = remove_queue_mes(dqm, q, qpd);
-				if (ret) {
-					dev_err(dev, "Removing bad queue failed");
-					goto out;
-				}
-
-				ret = resume_all_queues_mes(dqm);
 				if (ret)
-					dev_err(dev, "Resuming all queues failed");
-
+					dev_err(dev, "Removing bad queue failed");
+				/* resume the good queues */
+				resume_all_queues_mes(dqm);
 				break;
 			}
 		}
 	}
 
-out:
 	dqm_unlock(dqm);
 	kfd_unref_process(p);
 	return ret;
-- 
2.54.0

