Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C90FAC5CFC1
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:04:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 841E910F754;
	Fri, 14 Aug 2026 21:04:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LwUqqkxX";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010015.outbound.protection.outlook.com
 [40.93.198.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71BB710F741
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:04:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QYHAPKaMpf+8bhkfSgbnySxcSt/yHDVum8A1XdbCurovdaBjsDhAGBVDRqDxeQjE0dRMCKp+H6HGEzJrT2W+Uf+LII9Oh7cDIjMMea8FzgK53igE6OSkuEvocqFIZa0N+MWnCYK3n/rRQ6LkMlgKDah8KSQZ4jhoutfMKm5BQeYq9sb23AAe8p/7LSA9OoKHNFgDBogm3cCzhiDHAg+/q9g9mITX6mLjqHBE8lo+D2x5vMaNA4/8UKzboyagVUFdByn8q3lYdzVzxAvxoWbYpq3RP/cdPXOpiiW8JBOehh3CQlLSV4Z9Z9bqu4sHmax5vdubVpMdbA+EW8C+3RAxxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tu4cJyZmmaXRS3UEoDEk3rR3dXhbMw3mq4aYSMGLwB8=;
 b=BvMSIWKhncUWW4rBT/AdFWwQzdnL4Xf2AT+SeHPg8kTSlZB2VrKv5D7G1Y6TQlhgEqW0htBSJLErnPsdsufGxPVlc4mLZtm6Be6qgmNrwkLAF6BMNThL2aS2ozp8yTWjTY7PUqJugq8cDHdWQwUDtwooXkWQGHkXMCzZbbA+47168l0ctZ5f5gvlnJj2vH9rFgtS+rwuufe1gXa1wDDAjmoKLOjLoPWxJz3LYaf3CI+9/JVfDRsNulvpEt2i9dBmKGNcW9sfUdvtRIwJUqCqi4yt+uUBaIhy+ka3C7+K5wjtV3kngA9qpwPkLnURSEXEuNzaCHiOCjQUfA05jEYiOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tu4cJyZmmaXRS3UEoDEk3rR3dXhbMw3mq4aYSMGLwB8=;
 b=LwUqqkxXuJdGoC7/f6lVyeaSOoDv/RldtT8Lt3CvLO4h24lhozQ2NqI0wkkZ2Xr01zaqzPCuHfKXL4RHzS1EPoPpXyReYlrjGPC3rwIOHv90UHorPF4VS8jp5EaNKFa7iKSFx8hjKY/Kyl9W3PYZXFZ8SGwk3jJl9FvEaejETRk=
Received: from BN9PR03CA0357.namprd03.prod.outlook.com (2603:10b6:408:f6::32)
 by CH3PR12MB8233.namprd12.prod.outlook.com (2603:10b6:610:129::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Fri, 14 Aug
 2026 21:03:59 +0000
Received: from BN2PEPF0000449E.namprd02.prod.outlook.com
 (2603:10b6:408:f6:cafe::72) by BN9PR03CA0357.outlook.office365.com
 (2603:10b6:408:f6::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.14 via Frontend Transport; Fri,
 14 Aug 2026 21:03:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000449E.mail.protection.outlook.com (10.167.243.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 21:03:56 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:53 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:53 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YiPeng Chai <YiPeng.Chai@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 093/109] drm/amd/ras: add interface and improve extensibility
Date: Fri, 14 Aug 2026 17:02:30 -0400
Message-ID: <20260814210246.3067612-94-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449E:EE_|CH3PR12MB8233:EE_
X-MS-Office365-Filtering-Correlation-Id: 88a3a63e-9576-47e5-d9e9-08defa478dfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|1800799024|376014|11063799006|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: gfVqsx0L9uh/fFFGPZQxSwoKWvTIX1+/I7cIfV8M6p9EdgEpb03kwoRkVHOMRyu69+hWEoVT8ZLp/BZu/32Pe4FI7jFU+oe+RRJNbMe10mXHze8r7kS0bNdLxfa0ZtUg31B3u92gqgCnWpZTUpnmtCh9xQYIsCUT5Cv/REKSJKNAfxhGZW78O3TWtcZMrCA2Omw2T3TRwnkEF1aof7e68XUZM0w84CrfRRpBlW5/TWaR8RubErDqSrUPUrK5PF2y7niiRIQGAiyx0xdeKr1e+lc8K555IXtNjP9NtdKH4IvM7tnP4cz5lc2wz5ve6ZGvkYGPETwwwmFBp7iPMTV/qWB6dW1dVs4N8/kG1tmMuFvAURxrBrCYKLdTmr8f+GVZ919F84LoJy3pnktzUa27pELpkd8k2bLXXBUDE6wVv3pw56aaynGqXsRhZyjiTOatm/cPnU8krK6rw4OHkHxFAIdUkvosRh/1i+pGoYzjxF+bQVHoooQ3cINRaw5+478QJNgJ55gC8lbid0xdhBSt06wiZtV/NYY2im9BrOW2mG1x4rVe2l+dZBgJMDkXm9JMIzJTOOGvrxHtBygNLuEjfIXMgXkCQbSEM2yELuA43ksTvyhqAyTCGSqqFIFS8u888r80HX2dFZZvVhbg6fh9HvCahAgU6fhlbeiHoVT42k118rH5+99oZnoBFFLNUCzu6JyaNgQVTUWxC2naxQDXkA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(1800799024)(376014)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qtQACFwH+agqDy0VR1jaBc0/wfD77laXqwXAzYT/PjNkiDF4aKc3cMEx2IKjDfLom1oYGIO2FIdsiB/y/n9DJ1vVhDVyDSuqKs2tCnTWagf+L8Cfs66eAdrL3ka6YgiKG6aMbaSctrRl0HkwE06U6fHh8sqc5kuOc1d5120CDNJuDUiwr8Eu0TCu8dvPJiuVa7OE+LEISV9hFTJ3sg2gPW7iUz4f+SUT6pYczA/icSuLB+lo3yNxF0EPvgJ6yygd1iXVVRt2Cham6dl1x36HXWuDg2MnVg33TkDPMSNa9T+TFbdcwHbjJfeQRWvhDrim3TDyodLOS5kXck0hSyc/9NqYe3UT61CtLiJUUB5I7vdyksqvAtd8WGyhjIAbuQ4cxenRbUvRqb8kb/U6HrhC9L0zglsuTOJPS/LMD9kyQCjerRovjktrjWbfZPbkbSdM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:56.4544 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88a3a63e-9576-47e5-d9e9-08defa478dfc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8233
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

Add interface and improve extensibility.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/core.c     | 11 +++++++++++
 drivers/gpu/drm/amd/ras/core/log_ring.c | 17 +++++++++++++----
 drivers/gpu/drm/amd/ras/core/log_ring.h |  3 ++-
 drivers/gpu/drm/amd/ras/core/ras.h      |  2 ++
 4 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/core/core.c b/drivers/gpu/drm/amd/ras/core/core.c
index d833e7de16d9e..b668c2cc1554e 100644
--- a/drivers/gpu/drm/amd/ras/core/core.c
+++ b/drivers/gpu/drm/amd/ras/core/core.c
@@ -848,3 +848,14 @@ int ras_core_get_module_param(struct ras_core_context *ras_core,
 
 	return 0;
 }
+
+int ras_core_add_log_event(struct ras_core_context *ras_core,
+		uint32_t event, void *data, uint32_t data_sz)
+{
+	if (event >= RAS_LOG_EVENT_COUNT_MAX) {
+		RAS_DEV_ERR(ras_core->dev, "Invalid ras log event(0x%x)!\n", event);
+		return -EINVAL;
+	}
+
+	return ras_log_ring_add_log_event(ras_core, event, data, data_sz, NULL);
+}
diff --git a/drivers/gpu/drm/amd/ras/core/log_ring.c b/drivers/gpu/drm/amd/ras/core/log_ring.c
index 28cda7528e2bd..fb42449fbd6c4 100644
--- a/drivers/gpu/drm/amd/ras/core/log_ring.c
+++ b/drivers/gpu/drm/amd/ras/core/log_ring.c
@@ -222,7 +222,7 @@ void ras_log_ring_destroy_batch_tag(struct ras_core_context *ras_core,
 	kfree(batch_tag);
 }
 
-void ras_log_ring_add_log_event(struct ras_core_context *ras_core,
+int ras_log_ring_add_log_event(struct ras_core_context *ras_core,
 		enum ras_log_event event,
 		void *data, uint32_t size, struct ras_log_batch_tag *batch_tag)
 {
@@ -232,6 +232,12 @@ void ras_log_ring_add_log_event(struct ras_core_context *ras_core,
 	uint64_t socket_id;
 	void *obj;
 
+	if (size > sizeof(union ras_log_body)) {
+		RAS_DEV_ERR(ras_core->dev,
+			"Log event(0x%x) data size exceeded buffer!\n", event);
+		return -EINVAL;
+	}
+
 	obj = mempool_alloc_preallocated(log_ring->ras_log_mempool);
 	if (!obj ||
 	   (ras_log_ring_get_logged_ecc_count(ras_core) >= RAS_LOG_MEMPOOL_SIZE)) {
@@ -242,7 +248,7 @@ void ras_log_ring_add_log_event(struct ras_core_context *ras_core,
 
 	if (!obj) {
 		RAS_DEV_ERR(ras_core->dev, "ERROR: Failed to alloc ras log buffer!\n");
-		return;
+		return -ENOMEM;
 	}
 
 	log = (struct ras_log_info *)obj;
@@ -252,8 +258,10 @@ void ras_log_ring_add_log_event(struct ras_core_context *ras_core,
 		batch_tag ? batch_tag->timestamp : ktime_get_real_ns();
 	log->event = event;
 
-	if (data && size && size <= sizeof(log->body))
+	if (data && size && size <= sizeof(log->body)) {
 		memcpy(&log->body, data, size);
+		log->size = size;
+	}
 
 	if (event == RAS_LOG_EVENT_RMA) {
 		memcpy(&log->body.aca_reg, ras_rma_aca_reg, sizeof(log->body.aca_reg));
@@ -261,9 +269,10 @@ void ras_log_ring_add_log_event(struct ras_core_context *ras_core,
 		socket_id = dev_info.socket_id;
 		log->body.aca_reg.regs[ACA_REG_IDX__IPID] |= ((socket_id / 4) & 0x01);
 		log->body.aca_reg.regs[ACA_REG_IDX__IPID] |= (((socket_id % 4) & 0x3) << 44);
+		log->size = sizeof(log->body.aca_reg);
 	}
 
-	ras_log_ring_add_data(ras_core, log, batch_tag);
+	return ras_log_ring_add_data(ras_core, log, batch_tag);
 }
 
 static int ras_log_ring_lookup_data(struct ras_core_context *ras_core,
diff --git a/drivers/gpu/drm/amd/ras/core/log_ring.h b/drivers/gpu/drm/amd/ras/core/log_ring.h
index bcefd228aad3c..ed68664bf3c68 100644
--- a/drivers/gpu/drm/amd/ras/core/log_ring.h
+++ b/drivers/gpu/drm/amd/ras/core/log_ring.h
@@ -65,6 +65,7 @@ struct ras_log_info {
 	uint64_t seqno;
 	uint64_t timestamp;
 	enum ras_log_event event;
+	uint32_t size;
 	union ras_log_body body;
 };
 
@@ -97,7 +98,7 @@ int ras_log_ring_sw_fini(struct ras_core_context *ras_core);
 struct ras_log_batch_tag *ras_log_ring_create_batch_tag(struct ras_core_context *ras_core);
 void ras_log_ring_destroy_batch_tag(struct ras_core_context *ras_core,
 			struct ras_log_batch_tag *tag);
-void ras_log_ring_add_log_event(struct ras_core_context *ras_core,
+int ras_log_ring_add_log_event(struct ras_core_context *ras_core,
 		enum ras_log_event event,
 		void *data, uint32_t size, struct ras_log_batch_tag *batch_tag);
 
diff --git a/drivers/gpu/drm/amd/ras/core/ras.h b/drivers/gpu/drm/amd/ras/core/ras.h
index 464ad7381c5c0..6509bd798e48e 100644
--- a/drivers/gpu/drm/amd/ras/core/ras.h
+++ b/drivers/gpu/drm/amd/ras/core/ras.h
@@ -490,4 +490,6 @@ bool ras_core_early_init_service_enabled(struct ras_core_context *ras_core);
 int ras_core_eeprom_early_init_service(struct ras_core_context *ras_core);
 int ras_core_get_module_param(struct ras_core_context *ras_core,
 		struct ras_module_param *param);
+int ras_core_add_log_event(struct ras_core_context *ras_core,
+		uint32_t event, void *data, uint32_t data_sz);
 #endif
-- 
2.55.0

