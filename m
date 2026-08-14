Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C388C5B572
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:03:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAFC710F6C6;
	Fri, 14 Aug 2026 21:03:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="myMJqkOd";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012015.outbound.protection.outlook.com
 [40.93.195.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69DAB10E5CB
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ebd+UqQzyqP3rakXo1ZakarLheAk1GtYLbAD1EixoSNEScChhdJbyyeM5Y9H5mMcvtwV8Xqfyu0APkAolB06Qb4HSIxsC7OUy6Fm52BhNc3RH/yirVfbgVb/IQ1AWUt3WHAXllGJvFack9WV29hmmh38fk6GSMANdCr20HNK90CdnAG0mS2JCMf4av0uNVHE64PRUhHT5m3cm4OalR3ZijBjRaMjmUbtQvV7u+L5ClIG0couc2KmO7sjdJq4djxN4rN+nv2pc3eG5G5phqSi99siV2DhW1EsUvIijcV+pm0CKaSpmSbNEhDIa4Pkobbdc43WTF/Fs5FGpaCTvZw6hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9fXU42Y+HA7q1aJYrxIzx6VIPO5kE5PzRluWr4g//qg=;
 b=Tmvk5zHMtUqvKHLbqphYht6O3so/xgCvNEsAxwpQNHNf99yIEw8D0IfMUr1DJpFW1XZxVMvS+J+Q/krxuG1uZ5Bk9E7MgKbmfwfloSNORzbxOqRrbw/l0ddwnVBG4oapSZi9cSLUmLPb4cJeuSOIJRcE22o9Pp2zEjDsY3qiSq29nPOPW9w72WjdVpl/9U4b+x1kOI6/WCCceGU5zA2PCmeMc50/ui7hTGG1yvcRmQMxIlbbV105QKQ6o87jFlwk+eRaTtgsiE3k9isv+hBOrokSCZKsSBk0qr0Na8jdu1iqe+iIskSwD5K31wkkCTxZfSPC0jkRjEo04RBERMdSzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9fXU42Y+HA7q1aJYrxIzx6VIPO5kE5PzRluWr4g//qg=;
 b=myMJqkOdsnQnYJONKnPUHsmx5j4srysWm2edbktddFXkeDqxecY4PygeuVanOcCJN4ffUm1mRaDuYukSAwL6IXv0C7ErUfqH6qBnY+UYPKRaFMl+Swx7EK8ylIENjOJ7Y1ilFaTCi7v22ueXPYtOCCHfva3YY/Px4XozciYnLpU=
Received: from SA9PR13CA0069.namprd13.prod.outlook.com (2603:10b6:806:23::14)
 by CY8PR12MB7586.namprd12.prod.outlook.com (2603:10b6:930:99::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 21:02:59 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:23:cafe::2a) by SA9PR13CA0069.outlook.office365.com
 (2603:10b6:806:23::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.5 via Frontend Transport; Fri, 14
 Aug 2026 21:02:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 21:02:58 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:02:58 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:02:58 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:02:57 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Xiang Liu <xiang.liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>
Subject: [PATCH 002/109] drm/amd/ras: Rename CPER section descriptor struct
Date: Fri, 14 Aug 2026 17:00:59 -0400
Message-ID: <20260814210246.3067612-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|CY8PR12MB7586:EE_
X-MS-Office365-Filtering-Correlation-Id: e812d673-d44a-4b3b-dbff-08defa476bbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|1800799024|82310400026|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 3PzBfBXUFej3rAcHru3X91VWjUgW56rNXLm6nc+MJQG/drDfGPkMTt0/YKbhqZ38GV1xWv3ScnzjsvodLmdfDC0vbIrM7kOhhB5wYIT8iD+i7rtJWDhHOodZ+I9zncA3cpUOWEqDmgl2vnxTlAv11mmCiGDxC2+GLzimLNs1XWWCFPRCCf1OuWE0wFXj3XiXlVDQYn4pDSrZuIOWJM0huxNSZr3AVbf1ZuVA887kREiY09dzpvXNfQ0cIAXeGiMiURzmQGCG7ZUkwL2kMCypNvzeKcwDXRpiGh3LkMoGKC4g5pkjtxoQEarvCRT+L7Qn6GwFqCSqqqmOIbPQWTk9ukN2TuJdp29tjWafQHW2Lpdg+Mbd6KG6pO5h9t+aJzaUfF6IhW4EjqN1poOQeJJqBjHytbGG1iqMZTBvO5hk8wD3Dh0VvOno30SgT3gNEOzZRLuEQJbWApbIRbR7w0gtdY2/MhuWbG2eRatqfHYnoVhNvDLLdr19i3PzwvL6NVYjMcWBAsmpFKbJ0HS0FDaUfM/qm0Mib7gPbIVYSY4Ekz/6c/BZowuXarfzc3HCe2h9ESdy/BDN2K/kBf9ulM/kuoZolfw8wag2T8oU2vZl7DKP/prRqWQrR/MLFemmcb9tQlrZkx7xbc0xAjIbwkDZHXLD2A2XhjatPbH4mPfnvCQVT/w7MISSINQRlzSSKhSJIUAvMEyL2rEqxjvnu1XZYQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(1800799024)(82310400026)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gmhbefDjAP56WlgMvMcZyxcTzmyiuJbUUgNhGnSd5eXef50IyUhlKtrg+q2dH1sGHwm0uExGNhDx626i5KIkIfyN/HhWGt2HzlsEOAfL7xl9wUHM6Y0GNWrsJI0NDrY+YjoS01YlWQ1btZjtvkSkQoRS3G7s+9/IKtFaeeP8NtDevsQOhTJOgSi3+I3f6yb/skpHVMDBOKsAKmbO/Yc6w+lru3RHkzHzci7a7fzPVJ+1z7UigPJhGak1ctxXE2i6P1QZqWnpGX6RRkQntmXNoC912eL9Bb4OgfqUiqKIXAJaYiLlz/a4pqIFuQs+lT0TfeTWLd0weR7itZBu9kYF3dCBoukbhJD3myU9FJXok1nqexXteEzlEvwVzht9rqiPJjLsjB3wE2KdSBh4W7oT+yaQH+j/3Yco9x7e806S6SGiAM6uwE0lYx3wzgBAudjQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:02:58.9860 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e812d673-d44a-4b3b-dbff-08defa476bbe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7586
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

From: Xiang Liu <xiang.liu@amd.com>

Rename CPER section descriptor struct to avoid conflicting with UEFI
definition.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/ras_cper.c | 6 +++---
 drivers/gpu/drm/amd/ras/core/ras_cper.h | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/core/ras_cper.c b/drivers/gpu/drm/amd/ras/core/ras_cper.c
index 4ffac4289dbdb..dd95e6891bcf2 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_cper.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_cper.c
@@ -101,7 +101,7 @@ static void fill_section_hdr(struct ras_core_context *ras_core,
 }
 
 static int fill_section_descriptor(struct ras_core_context *ras_core,
-					struct cper_section_descriptor *descriptor,
+					struct cper_section_desc *descriptor,
 					enum ras_cper_severity sev,
 					struct ras_cper_guid sec_type,
 					uint32_t section_offset,
@@ -178,7 +178,7 @@ static int cper_generate_runtime_record(struct ras_core_context *ras_core,
 	struct cper_section_hdr *hdr, struct ras_log_info *trace_arr, uint32_t arr_num,
 		enum ras_cper_severity sev)
 {
-	struct cper_section_descriptor *descriptor;
+	struct cper_section_desc *descriptor;
 	struct cper_section_runtime *runtime;
 	int i;
 
@@ -186,7 +186,7 @@ static int cper_generate_runtime_record(struct ras_core_context *ras_core,
 	hdr->record_length =  RAS_HDR_LEN + ((RAS_SEC_DESC_LEN + RAS_NONSTD_SEC_LEN) * arr_num);
 	hdr->sec_cnt = arr_num;
 	for (i = 0; i < arr_num; i++) {
-		descriptor = (struct cper_section_descriptor *)((uint8_t *)hdr +
+		descriptor = (struct cper_section_desc *)((uint8_t *)hdr +
 			     RAS_SEC_DESC_OFFSET(i));
 		runtime = (struct cper_section_runtime *)((uint8_t *)hdr +
 			  RAS_NONSTD_SEC_OFFSET(hdr->sec_cnt, i));
diff --git a/drivers/gpu/drm/amd/ras/core/ras_cper.h b/drivers/gpu/drm/amd/ras/core/ras_cper.h
index e4e3615ecc2e0..8bfbeb7d78e01 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_cper.h
+++ b/drivers/gpu/drm/amd/ras/core/ras_cper.h
@@ -137,7 +137,7 @@ struct cper_section_hdr {
 	uint8_t			reserved[12];     /* Reserved */
 };
 
-struct cper_section_descriptor {
+struct cper_section_desc {
 	uint32_t sec_offset;     /* Offset from the start of CPER entry */
 	uint32_t sec_length;
 	uint8_t  revision_minor; /* CPER_SEC_MINOR_REV_1 */
@@ -275,7 +275,7 @@ struct cper_section_boot {
 
 struct ras_cper_fatal_record {
 	struct cper_section_hdr hdr;
-	struct cper_section_descriptor descriptor;
+	struct cper_section_desc descriptor;
 	struct cper_section_fatal fatal;
 };
 #pragma pack(pop)
-- 
2.55.0

