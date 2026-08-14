Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DDE4C5DF79
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:04:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E0F010F732;
	Fri, 14 Aug 2026 21:04:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g3TZrB3J";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012069.outbound.protection.outlook.com [40.107.209.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 631AD10F72B
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=riWzeIQH0v4sEMMjPtC6rLU7vaR6hxtehtadELn3QRPnLUfgMogW2m+fJQ/NLYoDeE7YDt+muNnk4THgoTxjFtPPqLiidPZzIGh7RF4kYpC7GETa+tMAzk6fJp+lQmP1sgpKR7pjAFJx2M0fJbHRA5/ovwrf6zwmZauuj1kkOOvrm0CjDMW8y9xvFBk6xQGfiWNlWEq9DBeCIWZXAErVkOljqCzhIHwDGTNGQzHjsl0oucvUNRgInFpo+Cg71cnnKYZ3++J4yFPX5H1qRGORhS+PqZwJm9zFITTE6nQSPaGT1a4z5lQ+mbsTO3TdmGVlAl6TvveVAf+cBuR+Qr8BOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xLAQokbEn8p8kc2RZdVkZaryEP4gv3WI/vYCyNWY7D0=;
 b=IkPF+Z7h1RAerX9irvxfPXoCLYEKQqTjhkI7mutbBUlbu2A7OChfl8Pso+fXWERXFdmU2pBlpdQObXvPlBfLI2F4n8p7szlhagHwp9vdyd8vHhvoiwNXx3uJ76wFBXt+Gony7Kwcc2ENkeov/Zwdt0TlJ/LtFIObDPUhZFsGS7TDz3awt5Vc7OgydMZpRTBiCpqscopB3KXuTVuBXxMAlHxCZj5wARFuygXqC/EipnQS38BBDT5uF1dgnM3XFI76tUXt6WfeuZl/BSV71jUpM+prpASJVotY+TrGBG+S5mKaiVSgIZN/1GvTQpVkpc9Fem7V6CbMwDkme16CEYCJrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xLAQokbEn8p8kc2RZdVkZaryEP4gv3WI/vYCyNWY7D0=;
 b=g3TZrB3JTtI8g4y2dUKcHMFBN7KCYVDEaXCOvi9ppN0oBZdljSxbl/kLSjZTF+YV0fAPlvTDvYd+m5EiLOyYl55HprQnjmpEC9rkTaatHuc2A8ARe58toTNqNEGwJ5/TlzX+5e+dGRauIshiSLQPntztTDQ458U68y41UueM0P8=
Received: from BN9PR03CA0338.namprd03.prod.outlook.com (2603:10b6:408:f6::13)
 by CY8PR12MB7364.namprd12.prod.outlook.com (2603:10b6:930:50::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 21:03:54 +0000
Received: from BN2PEPF0000449E.namprd02.prod.outlook.com
 (2603:10b6:408:f6:cafe::1d) by BN9PR03CA0338.outlook.office365.com
 (2603:10b6:408:f6::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.14 via Frontend Transport; Fri,
 14 Aug 2026 21:03:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000449E.mail.protection.outlook.com (10.167.243.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 21:03:53 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:50 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:50 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:49 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YiPeng Chai <YiPeng.Chai@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 087/109] drm/amd/ras: improve ras log timestamp precision
Date: Fri, 14 Aug 2026 17:02:24 -0400
Message-ID: <20260814210246.3067612-88-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449E:EE_|CY8PR12MB7364:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ae29a0b-7744-4a63-b45d-08defa478c7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|82310400026|376014|56012099006|10067099003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: JgtjfWoGmxt7bzxMxvtKNJeBu28LDCI4eIzmUEYYBxBXiRtjl4EN6MbL7EZFGO40lOKDMqbejBkCmrjozpGzluvQgvxrfCAn3v1vXGuLS9D85tFRHSVQWioZ8PxGHHJxe1XcHmMFWlIfI9qyfk879ouLppmnYhOcp1hMIPlUjWQhRQW2Zkq8mbzUTxh9JvDZCqexmCSfwP7SZm/wIVe0GWdxPZhRUddC8sY6W+B8ZoVHdOn5xmlEI1U051f0MldISZyA2TzLZkRO13NU4VtXpyN65T9dicUGQ8jOydGRGZ+WTak7VN+D6CpMnnk/HtOaH0JJJ38bDNsgj6uvgfR1WoHWIMUh6AaF6gKfurHFw1KbdJByOr00cZEH+vdX0Hi8FOsiqX3qJ53eYONEuDPsO7VhVrc3XV9ApKCiJYu4Da4el4ecm7A3K0Jq2V8yfyLgGxx0JOXO3XrLzVA9LTaq0WZ71WEUFlD0N14WMl9c98t23ZTnPGkvLpXgBLs8YccVOkkVlGy/ZPJXeZOa4s40hGcoHlJVnX+OynfhDvDilZgpwNIErk1kKLzeQTfxqcAoag6ebKcHIx5fF8omFn3EJ7yJAut7hKcjbGwgt3Qe9ApIWrhYT5dYFMz4xc1rcYFcLlAhi6DtDuuqFiGEy2YuGyrFXbgK4YI8F4X0Xcb5UKgqjKJz0/bD2EIV1W5XtIgbg1UOKN4U3H3hWo2s8l9Zug==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(82310400026)(376014)(56012099006)(10067099003)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: aw/W1e0q4XQEWySG43aT5jjiruA7HR14+w8etg4H0kPH7DOSaVL191p/I2s2C+yy99s7B2t/SiBNR2QiQEr0jEsjVFVwD+O/Cim6dyPZldzjy0lxv5BC5Mt2Mj08fHjaTTrbCbFQHAOWIsOA+wQvHG+vG1FaJT5b4MOIAnIeXzh9lWk1IUbV3hDPN4+EOenVHbRvlQOXPoWFqhIilWxXN6V0mwir7AGLeeDiJ0N++HZmUi/y9ZC9zmL3bJjqxqFW7DEF9/XwePvg77uACe+Sq87uMl0otygQaxU16dYYN/DKa13OOy1fGg0uNjyUCAa0nq1xAfGdEgmWLYqqTbU5jCuoKanDSFtPMHFwh4E14kjlVDyyWsM24PtBQaI0lsq/m8NIZgbJr/DivzANvRFfVvdkh8EEPKJgEt+a00wprxXjF7ibrHUuIWTvfz6EAZOD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:53.9470 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ae29a0b-7744-4a63-b45d-08defa478c7d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7364
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

From: YiPeng Chai <YiPeng.Chai@amd.com>

Improve ras log timestamp precision.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
(cherry picked from commit 2e5d98b306cdc6e1992bc068ce696d35d75ba26d)
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/log_ring.c   | 4 ++--
 drivers/gpu/drm/amd/ras/core/ras_cper.c   | 3 ++-
 drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h | 2 ++
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/core/log_ring.c b/drivers/gpu/drm/amd/ras/core/log_ring.c
index b57749bc63d0f..28cda7528e2bd 100644
--- a/drivers/gpu/drm/amd/ras/core/log_ring.c
+++ b/drivers/gpu/drm/amd/ras/core/log_ring.c
@@ -212,7 +212,7 @@ struct ras_log_batch_tag *ras_log_ring_create_batch_tag(struct ras_core_context
 	spin_unlock_irqrestore(&log_ring->spin_lock, flags);
 
 	batch_tag->sub_seqno = 0;
-	batch_tag->timestamp = ras_core_get_utc_second_timestamp(ras_core);
+	batch_tag->timestamp = ktime_get_real_ns();
 	return batch_tag;
 }
 
@@ -249,7 +249,7 @@ void ras_log_ring_add_log_event(struct ras_core_context *ras_core,
 
 	memset(log, 0, sizeof(*log));
 	log->timestamp =
-		batch_tag ? batch_tag->timestamp : ras_core_get_utc_second_timestamp(ras_core);
+		batch_tag ? batch_tag->timestamp : ktime_get_real_ns();
 	log->event = event;
 
 	if (data && size && size <= sizeof(log->body))
diff --git a/drivers/gpu/drm/amd/ras/core/ras_cper.c b/drivers/gpu/drm/amd/ras/core/ras_cper.c
index 4047f9b0806e2..bb60fcd283a87 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_cper.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_cper.c
@@ -25,6 +25,7 @@
 #include "core_status.h"
 #include "log_ring.h"
 #include "ras_cper.h"
+#define ns_to_seconds(ns)   div_u64(ns, NSEC_PER_SEC)
 
 static const struct ras_cper_guid MCE	= CPER_NOTIFY__MCE;
 static const struct ras_cper_guid CMC	= CPER_NOTIFY__CMC;
@@ -69,7 +70,7 @@ static void fill_section_hdr(struct ras_core_context *ras_core,
 
 	ras_core_get_device_system_info(ras_core, &dev_info);
 
-	cper_get_timestamp(ras_core, &hdr->timestamp, trace->timestamp);
+	cper_get_timestamp(ras_core, &hdr->timestamp, ns_to_seconds(trace->timestamp));
 
 	snprintf(record_id, sizeof(record_id), "%d:%llX", dev_info.socket_id,
 		    RAS_LOG_SEQNO_TO_BATCH_IDX(trace->seqno));
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h b/drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h
index 2775c7bf41b7e..de3da5571ef82 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h
@@ -28,6 +28,8 @@
 #include <linux/printk.h>
 #include <linux/dev_printk.h>
 #include <linux/mempool.h>
+#include <linux/math64.h>
+#include <linux/time.h>
 #include "amdgpu.h"
 
 /* inject address is 52 bits */
-- 
2.55.0

