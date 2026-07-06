Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 525A3C43458
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2026 18:15:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD9EF10E1CB;
	Mon,  6 Jul 2026 18:15:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="boGUhcMM";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010069.outbound.protection.outlook.com [52.101.56.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E54E610E1CB
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jul 2026 18:15:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F7mB6KmnqajHfQ4vhEbzMtoLTTrpKJS48IUJyWcdM2jhKRCGR/kCVe52r4zABhnTn6wRG1JvF7egKOVzWENLmWFGsPgt8BOp6ziAps9wUvQwp23VysLrrL35f7JF34vTMllVKOP8dkwLX912GkZoUVhPweY0BqlbC3Zu3Uvle1FQ5sq7pu2sevUmGL/Ftrmsji4RB47znPsAOA9/AhuQZHzSmSThOl9kOvMPFsiKidm8LOvrhpFAe5YNP3oaYhwiaSud5NX/EJgz+nFk2hFxT1MQIzZBnmY4upfROtkMzpoLCQ0HpvcDAF535Uu93Iuc71qVcuwC6O43nZoEOt3m3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Q1be/vhbRasnbQTuKikT9c4IZjkN9ud4QjrHrufpCE=;
 b=LJa53xObcnWDHKwY5YQJKJesqe/JlQKBaXQ7fY3cba69ak3M2ASak7SPZNeqQ8depNyoV4JfMJVvipHIR/V1D6TeYosBAqXImijTOk7cu61F6m70K1v2nHU/ipcKQrVJqcEYie39tVWjIwYRpVmZo7b6XNwM8OyRtvZ7VCSEry8UOaybr9w/OG6k7Yte/j3bYdOLNyvJVyoo87Fy3QahQcpjhZgG3zVcOBjtkkRx6aGECVLGZKkAcAZYP/lIv5UpCXyZxdHHqAanvhVFBZjNrgKX9NoDZNTrDbEaARsJKadScwCeHRTWZG7GvbR200bevWraYPnt84AZLTMJZE1LNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Q1be/vhbRasnbQTuKikT9c4IZjkN9ud4QjrHrufpCE=;
 b=boGUhcMMtka+DZfXqnxFzsEwb/QrvCKfxam8uMUofVizER2ub0oUrI/PHE7Ko+FE4LRuRZWp6eZqWRQC7mqrYn5d3cgUfhu9G2GBYC+SNbW6Mt+sOtf2X0XlY3LNETpp+mjyDsfra9JZhqWipAm5hl8GH/TH70jqPh7MnL7jEnM=
Received: from DS1PR03CA0010.namprd03.prod.outlook.com (2603:10b6:8:450::8) by
 DS5PPF7B9F1F8E0.namprd12.prod.outlook.com (2603:10b6:f:fc00::656)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Mon, 6 Jul
 2026 18:15:08 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:8:450:cafe::a0) by DS1PR03CA0010.outlook.office365.com
 (2603:10b6:8:450::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.13 via Frontend Transport; Mon, 6
 Jul 2026 18:15:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 6 Jul 2026 18:15:08 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 6 Jul
 2026 13:15:07 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David Francis <David.Francis@amd.com>
Subject: [PATCH] drm/amdkfd: Check bounds on CRIU restore queue type and mqd
 size
Date: Mon, 6 Jul 2026 14:14:51 -0400
Message-ID: <20260706181451.3388067-1-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|DS5PPF7B9F1F8E0:EE_
X-MS-Office365-Filtering-Correlation-Id: 57489df6-b175-4d5e-a8dd-08dedb8a82e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|82310400026|36860700016|18002099003|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: Pi3Uw+fCfXlifQb7z+etlosb7tzVuYgSu5sy34KR8wmW7+8bd6qoFggrOydSjtt1ojlBUDBemT+1vjGDM+dfWvP1HzABGpeJ8KAs6w5nc7E+8xuSFgTXARziyFjiEfIby8nWbgjevpNYgSipDDEETz5TuLhs1/eNU5jVo8kBEC1hk8b8txkPZ9Yn1Sx8bMUUqdaj/1YnJ1Z7esjbBE07WCFWXPMpF6Pbeajf0n6yY504FUT4YnxRgn8E1/RVvcgvVhLUcXXVAglMs4Yy6JQeQtzSLygnIRx6RG+O1j0ktE+N2tsLK5f5Tg1Pvq1E6x+N6S/42XKboQgpflSUw/FB4wSvB3YVO1kY9Ygh4NEv4qNfi0KaP496NgGqBo3JgdviTyp3qO22IYpwnRF66QlNGlmfQC4covZ/ZtJpwhWt6ja4mbEYMvTfjHeig7wOWrtdlY0GuW4zS21aXS+ehgFicX7h2wMkY8aQfwRRViSsU9uIv99aE9UgqiBdWF//LQN6v2ynTaW/n0s2p48RRyCunzVq/dmkAf4WjltCgdY+In8Gn5jEVVpdjftGt3DwyBZ+PV+FXKvuuTgv89PT1MN7WzCbo1iq71iInA9kTyXSEFnXRQrD/jeHhfF57i3J1t3Z5a5n3yNL+3YTJicemA7FaV6tI3QH9QzUYRfww+CnfF/a4Ybdy+8FIiPg7Vl+kHPi5RoPYKfczd6pVNmr9qHa1w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(18002099003)(11063799006)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0y5191CB8T2S0klMpTr361Qm5ApmsLiagpFUavn4pXDEAJXKk1nLUU6fsR3z9coYCmXX2TLMvSb5a5vQ0cXGH1nyy9N+YBcGixuEAh9p1N4bijHL1suUcYTrk8AufFq6WWsZYDPJPulEzTMipWex25EHnZ+hmUg1Lo/Tu2ucl3CgnNIhuKu3nhxraOz5vL2+IZ5UMnIRee4IKRKe0WVD0Vou+vnL36ggYrLnHvLq+T8uG/VGE8uMpozwgP1jz7vv6r0Cx1E4zDYxpKZrivnTSN44b8TTeeRu5wMxsmzJIDNaWUpuh7BMaQyxTUok97jxzp4zKw3GAtmzpkjm5n5X/4PTFQi7cbgHGLDvGM5gf94pHeSbThkusCzV2XL5GFFeNtNsioQMaI1vezNQTun0zptd1+j9kMOW22cm7i0XR6AP2uW+AZkBUKOIsnt/8+61
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 18:15:08.0878 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57489df6-b175-4d5e-a8dd-08dedb8a82e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF7B9F1F8E0
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

We weren't checking whether the values provided in the private
data in kfd CRIU restore were within bounds.

For queue type, add a KFD_QUEUE_TYPE_MAX and ensure the provided
type is less than it.

For mqd_size, add new function mqd_size_from_queue_type and confirm
that the provided mqd_size matches expectations.

Signed-off-by: David Francis <David.Francis@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |  6 +++++
 .../drm/amd/amdkfd/kfd_device_queue_manager.h |  2 ++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  3 ++-
 .../amd/amdkfd/kfd_process_queue_manager.c    | 24 +++++++++++++------
 4 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index f6a749fbdd8e..0419fe869d4b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -3777,6 +3777,12 @@ bool kfd_dqm_is_queue_in_process(struct device_queue_manager *dqm,
 	dqm_unlock(dqm);
 	return r;
 }
+
+size_t mqd_size_from_queue_type(struct device_queue_manager *dqm, enum kfd_queue_type type)
+{
+	return dqm->mqd_mgrs[get_mqd_type_from_queue_type(type)]->mqd_size;
+}
+
 #if defined(CONFIG_DEBUG_FS)
 
 static void seq_reg_dump(struct seq_file *m,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index 2229f8b2f446..c9f9f7a87111 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -335,6 +335,8 @@ bool kfd_dqm_is_queue_in_process(struct device_queue_manager *dqm,
 				 int doorbell_off, u32 *queue_format);
 int kfd_reset_queue_mes(struct device_queue_manager *dqm, int queue_type,
 			int pipe, int queue, unsigned int db);
+size_t mqd_size_from_queue_type(struct device_queue_manager *dqm,
+				enum kfd_queue_type type);
 
 static inline unsigned int get_sh_mem_bases_32(struct kfd_process_device *pdd)
 {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 6e559aab4009..6c1b8255435f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -441,7 +441,8 @@ enum kfd_queue_type  {
 	KFD_QUEUE_TYPE_SDMA,
 	KFD_QUEUE_TYPE_HIQ,
 	KFD_QUEUE_TYPE_SDMA_XGMI,
-	KFD_QUEUE_TYPE_SDMA_BY_ENG_ID
+	KFD_QUEUE_TYPE_SDMA_BY_ENG_ID,
+	KFD_QUEUE_TYPE_MAX,
 };
 
 enum kfd_queue_format {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 0a7276eadf79..3131f1e46d50 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -1003,6 +1003,23 @@ int kfd_criu_restore_queue(struct kfd_process *p,
 		goto exit;
 	}
 
+	pdd = kfd_process_device_data_by_id(p, q_data->gpu_id);
+	if (!pdd) {
+		pr_err("Failed to get pdd\n");
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	if (q_data->type >= KFD_QUEUE_TYPE_MAX) {
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	if (q_data->mqd_size != mqd_size_from_queue_type(pdd->dev->dqm, q_data->type)) {
+		ret = -EINVAL;
+		goto exit;
+	}
+
 	*priv_data_offset += sizeof(*q_data);
 	q_extra_data_size = (uint64_t)q_data->ctl_stack_size + q_data->mqd_size;
 
@@ -1025,13 +1042,6 @@ int kfd_criu_restore_queue(struct kfd_process *p,
 
 	*priv_data_offset += q_extra_data_size;
 
-	pdd = kfd_process_device_data_by_id(p, q_data->gpu_id);
-	if (!pdd) {
-		pr_err("Failed to get pdd\n");
-		ret = -EINVAL;
-		goto exit;
-	}
-
 	/*
 	 * data stored in this order:
 	 * mqd[xcc0], mqd[xcc1],..., ctl_stack[xcc0], ctl_stack[xcc1]...
-- 
2.34.1

