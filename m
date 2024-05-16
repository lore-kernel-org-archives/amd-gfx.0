Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76076C25B78
	for <amd-gfx@archiver.kernel.org>; Thu, 16 May 2024 19:27:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 006BD10EDAD;
	Thu, 16 May 2024 19:27:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="t1Y7yYW9";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41A3B10EDAD
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 May 2024 19:27:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OCio+GjhMZycOHQ/b5LaT2J3UBAYOTHTJbNQuznEtyTsTXQuXluS2Od7apeXpUyN6eQXP1cBFvfK3kPF0VOwHVnMFgYEgD982LpjJ0Lgdu1Gk9oB97xQzn3EDxSgfvSB2MQpBiOZ4HkDBy5snRaEgUpYV0oYcQxRB7//Q3b5Z7KdWZJ7GLYO32sDQ0t1T7Tlq82upiWBDfk3FZRceMTvF9YRGUGHDKT+Dywd6oUm3PTTEm5E4bidR5zCom0haMm/sUnJtBuL3Bw85UT6/G/x49ssCWxGSUJKwmWRUYr4bj3xw5j9QGUTmGDfRz55hwTWpIa1P1B8InpRyUS4X4OvTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QfryxWjrc8vZe1uV4vOt4eSyjqh6VM8kDXMO/jA2xMs=;
 b=e/YMB5xzP+xkqGV8rm664UYb1aKr8+oDkJBZfGutahCX4jc7gK00G2dsgQPfB4utj1oc999hTYdaMUvMbOj3GO6UQXkAN2M1/3lmBuswrtaVWaDHllbbY/6XrwbaAPsf/W9ZqSeW6Fvp4oDd0O98KWGP6JCHcTi1CQKX9YznsKMPf/Tbihbd0NKaLYunfyvaT/0T7MGF7FsxPHjekWNITNTRI6fFD5uN5KicGGPlJfUxFObUyGJ2YpqYrpJ7UIs0jj3Osv2mhrkSsTiNuF8dAAYRlkE5F1oNedRj/kO+wzzcqcWEQFcsakQhkXk7ZR6T3yMssQZkwZFi9OnUF+EVoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QfryxWjrc8vZe1uV4vOt4eSyjqh6VM8kDXMO/jA2xMs=;
 b=t1Y7yYW9zSffISq0U31VfXNrRJXbACgPyVo4o9TuTd7Do6EAjnpoGvkWfgmWda3EM1NUJJE3bPxiK3S08ZQs6FuVbsBBORdMSGlUl4hUuw9J1tD3ICzYTTvWAPziLYkIssBeX2q2Gw43mtTER/yKBvYD7QvCEMiO0sIJYpUb41I=
Received: from BN9PR03CA0246.namprd03.prod.outlook.com (2603:10b6:408:ff::11)
 by LV2PR12MB5848.namprd12.prod.outlook.com (2603:10b6:408:173::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Thu, 16 May
 2024 19:27:06 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:408:ff:cafe::ee) by BN9PR03CA0246.outlook.office365.com
 (2603:10b6:408:ff::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27 via Frontend
 Transport; Thu, 16 May 2024 19:27:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Thu, 16 May 2024 19:27:06 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 16 May
 2024 14:27:02 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 16 May
 2024 14:27:02 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 16 May 2024 14:27:01 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Chris Park <chris.park@amd.com>
Subject: [PATCH 12/24] drm/amd/display: Deallocate DML 2.1 Memory Allocation
Date: Thu, 16 May 2024 15:26:35 -0400
Message-ID: <20240516192647.1522729-13-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240516192647.1522729-1-Roman.Li@amd.com>
References: <20240516192647.1522729-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|LV2PR12MB5848:EE_
X-MS-Office365-Filtering-Correlation-Id: 077b4434-4d68-4e38-4b76-08dc75de2c2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|82310400017|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ycnLL1hJAR6VskhBV2Sb71kIyp0z0matK2DyqrOKz/bYa9KIakIvmYIIubiB?=
 =?us-ascii?Q?dPBLI5vldaQG/Bxdg03qHElC2El3fEB8yIC1LWWLImkz2FHpWFl62NjTgYWZ?=
 =?us-ascii?Q?GQ2iuSnLseGTskVbL1FaBaRsTgWMUtvNsYRQ5XZsaRiu1iSKyOhju7vheUiN?=
 =?us-ascii?Q?HYBQtUqwmKVVnrdyAdNMJy/NsMQNiQflRY681aFyASQ1h3erdEHszO2l2oDP?=
 =?us-ascii?Q?NB5GaJMaHiq0LFVZM5NfPliW9qRnG3RvRwb6PFMOb5zcMOoZbuCI4gqiwDS+?=
 =?us-ascii?Q?MP/VwUyTXTVcIgdz3oKSkK/KYbxddEC+LjrpSFCmYNI2zOrWXYsrG3DMIX9M?=
 =?us-ascii?Q?PyINSTLChsKXBhJaUIRpmMLOr2pKSK3cpAdkO2H3u4EhAeHwCXE2yXXcY7qq?=
 =?us-ascii?Q?Ai1PXL3W/r6hNvBJbJSoUZYoOwqhcitMgV1NT9mbWm4Snn2LMt/8pvvDfMv6?=
 =?us-ascii?Q?i6fSHhgwPVDZ1qTNeJME1XQJfINA73mgg5wPPYpydxujXYh9lr5gXK2Yutsh?=
 =?us-ascii?Q?iXXN1qn8DQUbc0b2Ek7T9t+/eWNkVzvY8690qzTP+dpTLnLGmJl+xjSWCEFW?=
 =?us-ascii?Q?JelaA8u3fRliPNPKWoKaPNt7BhWG42czNcUTwMcYl1eoEZB8xgs3qaj4f8QS?=
 =?us-ascii?Q?wnFl6Ls7m46M0367MQpsinmtZoq2RAgB09wYxGJR54ro4AYHJXGAsbFCMEuu?=
 =?us-ascii?Q?HR5gtQ0fq8CCo1zPy0Ajk1X+kLFFG1FWbT1JZzFNd5NMOW0lXa7NPzTSIY8r?=
 =?us-ascii?Q?IKVhDK8FjeBX3aBnNMfOQCXWa6KiV6N+8x76rxoVJiAcr247w7dVA4lEbooS?=
 =?us-ascii?Q?S1EBfdk861NSiQrNBQfzmi/OHi7waA1QDTDyWmPjZxnWfNYCsayk0GbpAa/g?=
 =?us-ascii?Q?o+tl0NlYEO4iRQYziZ7wq2TwyNdYpVd3wnKTfwZ/fwbSuPjTDawcvZ/JOkoh?=
 =?us-ascii?Q?llwB4bFrcfbkt0a2ArdoSxxBGGY1F2ppkFLbgODAgi8MwIpABic+JAchSglO?=
 =?us-ascii?Q?IYqlGo70wsZC777lEtScxPVPWyM+f7VMStvHG+CngWHVo6MUgXET5gUXPHgx?=
 =?us-ascii?Q?ej0kAaEntd3flb364NrdTTc+LXpFdsHl7Njeul8AKCRPYBzddJlvyonVX34k?=
 =?us-ascii?Q?rhHacOGVpP6wv6Fetbz8S5MboTuk3Qm+BvATThRfT3xd1aBO2jmprOK/WP9b?=
 =?us-ascii?Q?AjoNTWBPlpLuTN1FNBSNLDHM2R7ZmMkgpnfNEZ3JoJlOJ97fXiCz6ddqmgkU?=
 =?us-ascii?Q?LvbyrAIMXBvEeQre2TEVy+lAKOcxH2I7qc7Ypwb2gHDd/BYwxhw1LETM2pyo?=
 =?us-ascii?Q?XuLs/eeJq2da3gVy2soHgF3BEdvjxR/Y1u7qN5X/FjC4a3wI61lc2ZSknuQV?=
 =?us-ascii?Q?/X++Z/P+kc+EZPOdCgb04iofTl6C?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400017)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 19:27:06.3720 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 077b4434-4d68-4e38-4b76-08dc75de2c2e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5848
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

From: Chris Park <chris.park@amd.com>

[Why]
DML 2.1 allocates two types of memory in its ctx structure but does not
destroy them, causing memory leak whenever DML 2.1 instance is created
and destroyed.

[How]
Deallocate two instances of allocated memory whenever DML 2.1 is
destroyed.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Chris Park <chris.park@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c | 6 ++++++
 drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.h | 1 +
 drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c        | 2 ++
 3 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
index cb8b2d77a1ac..4e0b7d2d63b2 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
@@ -107,6 +107,12 @@ bool dml21_create(const struct dc *in_dc, struct dml2_context **dml_ctx, const s
 	return true;
 }
 
+void dml21_destroy(struct dml2_context *dml2)
+{
+	kfree(dml2->v21.dml_init.dml2_instance);
+	kfree(dml2->v21.mode_programming.programming);
+}
+
 static void dml21_calculate_rq_and_dlg_params(const struct dc *dc, struct dc_state *context, struct resource_context *out_new_hw_state,
 	struct dml2_context *in_ctx, unsigned int pipe_cnt)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.h b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.h
index 6708f7117fbd..b2075b8c363b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.h
@@ -27,6 +27,7 @@ struct dml2_context;
  * Return: True if dml2 is successfully created, false otherwise.
  */
 bool dml21_create(const struct dc *in_dc, struct dml2_context **dml_ctx, const struct dml2_configuration_options *config);
+void dml21_destroy(struct dml2_context *dml2);
 void dml21_copy(struct dml2_context *dst_dml_ctx,
 	struct dml2_context *src_dml_ctx);
 bool dml21_create_copy(struct dml2_context **dst_dml_ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
index 4be304ebf0b4..22f6a59d8ed2 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
@@ -782,6 +782,8 @@ void dml2_destroy(struct dml2_context *dml2)
 	if (!dml2)
 		return;
 
+	if (dml2->architecture == dml2_architecture_21)
+		dml21_destroy(dml2);
 	kfree(dml2);
 }
 
-- 
2.34.1

