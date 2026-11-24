Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45798606A31E
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2026 01:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=lIETKZS7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D406710ECD2;
	Tue, 24 Nov 2026 01:47:18 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010024.outbound.protection.outlook.com [52.101.56.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B841210ECD2
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2026 01:47:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xWNgvqgZY/mDMKa60sG5C3zMEfeV9/KTrTI9kDmPV83e8Muvgrk5CcHjDBhM9XPSvgmEsrE2FrCtwu08EPD5l5odKrlYQMOzbiCxZ8OmIqI/KY+juAbhx+2yNd/ip+iGmEaMcQv8101hbimyJmiXKdp99JMt7Waza+sUdm64cfOUbMSGPZnfIbjRFYSMj27tG+LGRA0YvOD81pMDKub0GazXsw4/pmDnTdz+S5v+zn3ogf4ZE8zYjsB5DYlDh1zK36Ua0ziFFSt+xP7VCUTi1eamNi8sv1UDw2vsEeBf9w8vBRGOAW9mBluMA1PcMf4o+xLc3JIFF5lqjpWPP2loJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f6G33Ovg+ycTR3uGAcBiFMzzRwPKzffqRtM5TqtHjvA=;
 b=XpGFnU56I18yr+s8ENJ9gElmN5JkP+g/w8MWNcpa5NW8N5EAjCQaUVWoWADgRcdDXX1ysmmZc2EBgGF+vAxrjSLz5dfNtRoz+YuPp6JbuWTzP8mbPAdf6oXJGrsDCHC8IEW+rBNPmiLb/if1tHAZg2JRHfNguAUrR0/SIHQDcI4cNjB991duw+iRMRMrzxC+pENjTwkOj3AXnvbPm9HUGR5UvIas1pIQEnae/qSSbvRS8UeNVVH/P1jkC5uigue4CqsWBLY5grJf8qXUJZUEqCMysn0Ga8gvkmnxuFXrJ7HFh2VNvRs5wBUCeLLCh6hfcoBAOBRKKscESNN4J764Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6G33Ovg+ycTR3uGAcBiFMzzRwPKzffqRtM5TqtHjvA=;
 b=lIETKZS7BFEaSImt6w3eSHbasv0oXXg7CyXXoqBie+3Yibp+9Sr7YluqAx0e7OLPBSGtbmXmnzaiG8sUjHK4r/XThP4znTYy0bHnR3Q2cJJI0jz89ZTr8G7OYhkse9/40l9cKncqkpEhEYtOxQw/hLFhzoB0WA9/UZtrc414CK4=
Received: from DS3P221CA0010.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:45e::8) by
 CH3PR12MB9252.namprd12.prod.outlook.com (2603:10b6:610:1ba::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.12; Tue, 24 Nov 2026 01:47:06 +0000
Received: from DS2PEPF00006E1F.namprd05.prod.outlook.com
 (2603:10b6:8:45e:cafe::5c) by DS3P221CA0010.outlook.office365.com
 (2603:10b6:8:45e::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.5 via Frontend Transport; Tue, 24
 Nov 2026 01:47:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF00006E1F.mail.protection.outlook.com (10.167.23.212) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Tue, 24 Nov 2026 01:47:06 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 23 Nov
 2026 19:47:05 -0600
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Mon, 23 Nov 2026 19:47:04 -0600
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>,
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v2] drm/amdkfd: only fence and flush the devices whose queues
 got suspended
Date: Tue, 24 Nov 2026 09:46:41 +0800
Message-ID: <20261124014659.1942298-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00006E1F:EE_|CH3PR12MB9252:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dbf2164-32fc-4e72-b98b-08df49ccd887
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|23010399003|82310400026|10067099003|261102123227099003|261021121427099003|11063799006|56012099006|261009223027099003|261021123027099003|18002099003;
X-Microsoft-Antispam-Message-Info: W7TebQ7S4peRFm5ZkRImYlCNjhSgEg9CiU1Vc5myhNthnzGcWwMkwZm7V2LiwR+m7kATs/LZUq0WKm0V2I2nGxSwoD78qWTD3me6wB5CTADF2GyzVvYKJ6mlsv83l/sctipOwDt6ekFRPrjA0Nk6NCQ2gatHvaWo63yYKlLZJ/r3TnQeZurhdOEtMACBKhy84GAlAymUsmLztHtjSwv90Pev5lHKUyjb7I4vadhbJxnBwfug7kZtIGi4EhcrxIskWtch85//R9SKaKELDPdhoHWFkF4f09E89XLwMSVRt/lQSbNsBeb9yLkMl7izodieAiPe/GcJndGPyhP3ok+GTKHXeXhomh2m1NH/kJD6ylriRgq/tQshyn+tRqfx8h2FsHREd2rqaNKQas/DIXx3YFhbrpi29L0D6xCYc62CzwUl0+h4xMVFlc3SDigAeSW0kPA7NKFVqvYAr+rtrSfN/ueDtA3NspK3HxlN4wHmtvPeA5ebumWbQkBnFyToIte82iozPgGKP5eGpfyhwpmgqohJcDFKnphdYwgUUPRtHxgkeVTpENnt8XwI0oxO63GuEFWmC0M9QoLylWechMZ4PYwdu2KpDrbGQ3wabESmoO5c2YwOgrvEVCDvcjPXKWG51HZfnvi8n9SATsk+DSvIv9PffUe1n6lhwjFpwpgf6TPNTFujYtF5iDNF1kyH+8XE48dojsMcR2bUQ4vS70K25Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(23010399003)(82310400026)(10067099003)(261102123227099003)(261021121427099003)(11063799006)(56012099006)(261009223027099003)(261021123027099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5IDdHF3uUN7gAarQmQPZ3f3kUAh3xUd+5LPhApS1ipYsoj9r+HzH5N9uJmmE3mbIr1xPOkFCH/uBKxyZ7LsiL/CZgZq0hXxZDUXD2gQi8sBt/RjIXukVtKyCEl0ltq2L7fW4Ic3oJZfZfpN37PdSjFZw3m6w9KTj7WZZR73cBqbjsLiW77jdT2XSGccHb5AQ75KY1FyR9xpHDldYCCdRr1Gmk+sp3VevvDGNOz6N5MqMSC1c2VzqP9gLpaUvDPhW5dx0evuYTTVLA0LkAfqY0QHeoGlTy1wnMZQR8nFkcOD6PXLVToHDGH2+kjWghLBh78GfoNP/mDdpn3/Noc0vmv3jBme2iY+CAjOszl8Y+9nLAmdsYqbauJ7pNavgu1zk1rCGb64t1vaWWt3SHKwiH0dQPL8G3USQuWuUTSEDKBDna43+8qvz1hVsI3jG0wil
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 01:47:06.3997 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dbf2164-32fc-4e72-b98b-08df49ccd887
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00006E1F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9252
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

suspend_queues() uses total_suspended to decide whether to issue the
debug memory fence and TLB flush. Once a queue has been suspended,
later devices can therefore be flushed even when none of their queues
were selected.

Use per_device_suspended for both MES and HWS, and only fence and flush
a MES device when its count is nonzero.

v2: count in per_device_suspended for MES and HWS (Felix)

Suggested-by: Felix Kuehling <Felix.Kuehling@amd.com>
Fixes: ff114e705d6a ("drm/amdkfd: Add TLB flush after MES queue eviction/suspension")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c    | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index b5d7d13f31a5..6381702e00bc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -3952,6 +3952,7 @@ int suspend_queues(struct kfd_process *p,
 		struct device *dev = dqm->dev->adev->dev;
 		struct qcm_process_device *qpd = &pdd->qpd;
 		struct queue *q;
+		bool is_mes = dqm->dev->kfd->shared_resources.enable_mes;
 		int r, per_device_suspended = 0;
 
 		mutex_lock(&p->event_mutex);
@@ -3965,7 +3966,6 @@ int suspend_queues(struct kfd_process *p,
 
 			if (q_idx != QUEUE_NOT_FOUND) {
 				int err = suspend_single_queue(dqm, pdd, q);
-				bool is_mes = dqm->dev->kfd->shared_resources.enable_mes;
 
 				if (!err) {
 					queue_ids[q_idx] &= ~KFD_DBG_QUEUE_INVALID_MASK;
@@ -3973,10 +3973,7 @@ int suspend_queues(struct kfd_process *p,
 						q->properties.exception_status &=
 							~exception_clear_mask;
 
-					if (is_mes)
-						total_suspended++;
-					else
-						per_device_suspended++;
+					per_device_suspended++;
 				} else if (err != -EBUSY) {
 					queue_ids[q_idx] |= KFD_DBG_QUEUE_ERROR_MASK;
 					break;
@@ -3984,10 +3981,11 @@ int suspend_queues(struct kfd_process *p,
 			}
 		}
 
-		if (!per_device_suspended) {
+		if (!per_device_suspended || is_mes) {
 			dqm_unlock(dqm);
 			mutex_unlock(&p->event_mutex);
-			if (total_suspended) {
+			if (per_device_suspended) {
+				total_suspended += per_device_suspended;
 				amdgpu_amdkfd_debug_mem_fence(dqm->dev->adev);
 				/* Heavy-weight TLB flush after MES suspends queues */
 				kfd_flush_tlb(pdd);
-- 
2.50.1

