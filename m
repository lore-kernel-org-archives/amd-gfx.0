Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A7DCA5FA5
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2026 12:02:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E17E10E8A6;
	Tue, 29 Sep 2026 12:02:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AZjUTcxx";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012013.outbound.protection.outlook.com
 [40.107.200.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 722F410EE6E
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2026 12:02:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vJyMjKMDgig8USLEftkD+GoMDeyqE3GYMfEh2TW6QrkOTbOfq8y66SGo0zgTDsFf076ualBFNqp1tcVGBbtpd4saXJvcDS5OnOaQ5vsZFuvLyIipJ6RX3RUxXd0o5iphxbbUINsU2/RbEeWCbRTGtQsm+VsxqYXKwCYESZj2NMIh8a0S+2+pm3sWoEsUdZlXBAnjhM2F2AtBjvAlhtW4seFx/Y7TUe1KJLrEECvmfYflIIqXh2zxocAazKBPudEOzKsKONzm+bmxTg9G16VAnVM094X/S2+BoSDOseEKEsAKvvL1wbNsAhW61D34fFZVh7QW7p0/JvESzyeJuJdriA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0rDaI1zzlipfhzAwiL6MXNLlntbvmDlnd+aKpdrQa/k=;
 b=eDB0jFY3FyDu5YaXdxxTwbyFKmGx60ftHxBoua+p3ROnXczZEaioMrRka7HSQz3YGUpxv3UtCBPJUMz+27ErG6/fh4XOby9vmpYHAiSDJV605yMynO3/71BBkWpCSTZ8Y+rUvHBYpWVJB1/XaY6EFWYaDZTC3usxm65L/ICGUaJlqJrKBuafIUHwt5UTC1IbJ33cTsgSEwGUJ1mzuDeyX+pdr4KdSTjhSaB88OZ9frz6UdpvW6hBYYDt0F4T1+f/9QUQyoAT0rOJobLP/GcGB9NHrgc8/un1kSt4+bTYm7mrDNR8lI8kicu/JpMs5ixczNXf4ByBwRXTLvPB69hyxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0rDaI1zzlipfhzAwiL6MXNLlntbvmDlnd+aKpdrQa/k=;
 b=AZjUTcxxe9cWXRaY/nVJzFSgEtfeZEeadbEmNipPjykCXBEEB8LLr3VRRK392u1JzN2UwDcD2NHCB3Yvw2vE7+uIYkjUyQv1L3PqQi4U5WqZsC6hohENv0zusizcV6FWIadpTcnjYHb6WR+gXmAUBVs+ekcTp7odmbHBoE1w820=
Received: from BN9PR03CA0332.namprd03.prod.outlook.com (2603:10b6:408:f6::7)
 by PH8PR12MB8432.namprd12.prod.outlook.com (2603:10b6:510:25b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 12:02:43 +0000
Received: from BN7PEPF000000A4.namprd05.prod.outlook.com
 (2603:10b6:408:f6:cafe::31) by BN9PR03CA0332.outlook.office365.com
 (2603:10b6:408:f6::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.24 via Frontend Transport; Tue,
 29 Sep 2026 12:02:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF000000A4.mail.protection.outlook.com (10.167.245.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 12:02:42 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 07:02:40 -0500
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Stanley.Yang@amd.com>,
 <YiPeng.Chai@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH 2/3] drm/amd/ras: report the bad page threshold in every work
 mode
Date: Tue, 29 Sep 2026 20:02:15 +0800
Message-ID: <20260929120216.1230237-2-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260929120216.1230237-1-xiang.liu@amd.com>
References: <20260929120216.1230237-1-xiang.liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF000000A4:EE_|PH8PR12MB8432:EE_
X-MS-Office365-Filtering-Correlation-Id: 39f0e68a-cd2f-4edb-2f18-08df1e21911a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|36860700016|1800799024|10067099003|56012099006|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: lNOolyAH4aP/GynfbuIk3RBhLZHMCNVT+UWzQQL0X2yjZU3Nrma8Ada3KzFOVI49UQELbwyGg70I0VSzzohlsSvoxTMFD7Vo6cnFJqM0KAP4VvCXznsUti2pZBEGe4c3PKFtrXkDJSK8Qtd4hIGaTmfl1xukYioMzzsTIDteN97yCIMOjwZORxnG4PeLnPsAFRGZx/Cr6BFMsrE7r+Dz3zY/r5wh8k1l9g/jIUB6eIbnd8BqUEWh0E1pHB291QofJVFRKU/FyLyY04OAnKg7WU7+lNJHpS4O1nxw5D5EPCI7SpEaRzvF8xFKcRoaAeEs5gfKIYIt5I7eufheqL61K8Y5VCv9SV9GrS48LZLrfduA4HWKbdwSsWn/ODAJCpD0Gh0BA7qfFP+l2qvqWQjao6EarhxsSb2FTpInLNRsLPwN/X3SyakDyxPGAxljC3cKq8UY8HRoA11rOzCQ35a8ddXA4h4DRBFgYg1F472tgUTTFNEFpQHpPpnmCNk14UX9jKN0DRcwOTuEuUQapl4GeWdZxSd4OF0asc8wAKzPIuYE88KFNV2dwnywQ2yKmetZ5pr9tYNj8gnUuDSDZ+oAuJA4Atgx/UROtNdiKy9n6bi9et1FNf6P58QUa1g5OheyfYUm7ig3AkF97LNM4vSnxfUguUBrjgCOoQ3n0+G57aFYQ4WP53Cc8SNxolpPVfpHl7JVws9lEC9ZiGfNh6phZA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(36860700016)(1800799024)(10067099003)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: l/m8C+4EONvD2XDgVdYB/zXoUmG5dokFMxdOY7vPupQzi/QHzkqIjy6aIqTR6YthSsFCX40j24TpFQpy7C4wsytXSNb6xG54f0xJFLh8/KNX6SWSbRaYZU50v32qbJUHBkP8hVdxdmO4tXf6mWSdZFhgQkxu5ClrY3FAtCqjB/CljKLH8GFI4nptqH1WVSxYTYcTQnv3ENbQDy6+9m3m/Rq3+5Ycmxu9iFGvV9mY48UtKq3cwzB78HzZ6f3DAbv7GneX1yNKBDGt8gPSzakvVAh5hGQmxL60vodcPUYBG5RYq6VTexHy/VF8Al1fMqvBsTHJWyaYAlTetkXJe4uNt40OOA/5UC3LJPj37FOgbHzNVjPrQtdW7Y+gerHiLKagDYwAqLLQ/wsq88sU+/VVUV+9nif2aTq1qiYycd4ME6SnjzdXJ0AagM1XXKpuqjv/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 12:02:42.6669 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39f0e68a-cd2f-4edb-2f18-08df1e21911a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF000000A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8432
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

Only the mode that halts runtime services flags the device once the bad
page threshold is reached, so on a default or warn-only threshold the
in-band CPER record and the out-of-band RMA reason are not emitted even
though the table records that the threshold was hit.

Track the threshold condition separately from the halt decision and use
it to drive the report, so every mode except the debug one tells the
host that the device reached its bad page budget.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/ras/core/ras.h            | 1 +
 drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c | 4 ++++
 drivers/gpu/drm/amd/ras/core/ras_umc.c        | 2 +-
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/ras/core/ras.h b/drivers/gpu/drm/amd/ras/core/ras.h
index fcea457d5cbe..8c6e8ab89c58 100644
--- a/drivers/gpu/drm/amd/ras/core/ras.h
+++ b/drivers/gpu/drm/amd/ras/core/ras.h
@@ -415,6 +415,7 @@ struct ras_core_context {
 	bool poison_supported;
 
 	bool is_rma;
+	bool bad_page_over_threshold;
 	bool is_initialized;
 	bool in_early_init;
 	bool early_init_service_enabled;
diff --git a/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c b/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c
index 1781d037ef13..2f33e3132f76 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c
@@ -294,6 +294,9 @@ int ras_eeprom_mgr_check_and_report_status(struct ras_core_context *ras_core, bo
 				RAS_DEV_ERR(ras_core->dev, "RAS records:%d exceed threshold:%d",
 					valid_err_count, mgr->ras_err_threshold);
 
+			if (mgr->work_mode_over_thresh != RAS_WORK_MODE_OVER_THRESH_DEBUG)
+				ras_core->bad_page_over_threshold = true;
+
 			if (mgr->work_mode_over_thresh == RAS_WORK_MODE_OVER_THRESH_STRICT) {
 				RAS_DEV_WARN(ras_core->dev,
 				"Please consult AMD Service Action Guide (SAG) for appropriate service procedures\n");
@@ -315,6 +318,7 @@ int ras_eeprom_mgr_check_and_report_status(struct ras_core_context *ras_core, bo
 				RAS_DEV_ERR(ras_core->dev, "Failed to resize RAS table\n");
 			} else {
 				ras_core->is_rma = false;
+				ras_core->bad_page_over_threshold = false;
 				RAS_DEV_INFO(ras_core->dev,
 					"records:%d threshold:%d, resetting RAS table header signature",
 					valid_err_count, mgr->ras_err_threshold);
diff --git a/drivers/gpu/drm/amd/ras/core/ras_umc.c b/drivers/gpu/drm/amd/ras/core/ras_umc.c
index c2663f84a883..6af41c68d83b 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_umc.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_umc.c
@@ -701,7 +701,7 @@ void ras_umc_report_badpage_info(struct ras_core_context *ras_core)
 			&ras_umc->last_channel_bitmap);
 	}
 
-	if (ras_core->is_rma)
+	if (ras_core->is_rma || ras_core->bad_page_over_threshold)
 		ras_core_event_notify(ras_core, RAS_EVENT_ID__DEVICE_RMA, NULL);
 }
 
-- 
2.34.1

