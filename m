Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AD86C5DF70
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:04:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA65F10F730;
	Fri, 14 Aug 2026 21:04:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MjflSqgD";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013009.outbound.protection.outlook.com
 [40.107.201.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F12610F72F
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:04:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ms4kj7fE5d8vDeke1TmpMm8mn47aGKqwidRPKAALNW3ieUgVpU1YlTnj+QXHdOl7ItqMz7A/77ChjaHGecaedr3tdzKh0LlZF7vabG/SE8Ums+cM9/l44y0HKnAuLQG1lTophBk05tM+W5o6CHLRkoyMVTZ3MiWPcxBTGuAysowLalbMm/iAou0lp4DrQs+R3utKKQT1jqZVLfJSux8DZDcELZyXW1DAidAelZ2RdzyuApLU7BkeJa9J50jlTYvDtCatYNHsUiDCcli3SVpaapMS0jT13f+Uy7BLbzn8Cqw5aKT0BnfrqqNedQCnUdARL0UNlDhpZKkLJavkYSnYIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VDoX/ezUHybwcxdWcM2k4P+UVMej1nAYgLhjUtRDE/o=;
 b=m8QAW7JtyBhS4mzKZXR7g/4s1Rj6HuZLvua8+4F8CHS5CYFrwWhQjZHEq721cPQOoqz/4MMPvJWN5meO09pki5dnrwypp/566pNPEZuR/x/WU3oSXutxsS6P3uwGsw6hf7qsJ5iLnUCYmrmKp8NYGEYOWxz4dwggnFCDZ1ZwBzTCF4RcwsEZASYe1er+6NcEPIvF8FcAneRK1S2gYQuWvK+D/t36z+yeDhndH5Oac7lCUR14aMjA4u1UaJU1a6ZmlkYV8J3Jj/rrjyzPgJl3MsjOfPCYupTKfcmkpQNPaoRBuFwCK/vHPyfeQfD2uTv1XqfZdceioaCYXSupcK5VKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VDoX/ezUHybwcxdWcM2k4P+UVMej1nAYgLhjUtRDE/o=;
 b=MjflSqgDRTmRUyfCczxCPhTFdT0AWis4FzEQrIg2lR0Oc3JYmdEEoGlJfN7A0hkGLUbWL1q1d4G8OEPQs91pRGFPaEOvpG3gzidftC7gO4OoMhVYInYdpubn2/jgFku7r7DbVpwkK/z92Xd5dgTDCh/xrPil9r+od12YsdSOBeI=
Received: from BN0PR07CA0003.namprd07.prod.outlook.com (2603:10b6:408:141::15)
 by MN6PR12MB8590.namprd12.prod.outlook.com (2603:10b6:208:47c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Fri, 14 Aug
 2026 21:03:56 +0000
Received: from BN2PEPF000044A3.namprd02.prod.outlook.com
 (2603:10b6:408:141:cafe::69) by BN0PR07CA0003.outlook.office365.com
 (2603:10b6:408:141::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 21:03:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000044A3.mail.protection.outlook.com (10.167.243.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 21:03:56 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:52 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:52 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YiPeng Chai <YiPeng.Chai@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 092/109] drm/amd/ras: unify variable naming conventions
Date: Fri, 14 Aug 2026 17:02:29 -0400
Message-ID: <20260814210246.3067612-93-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A3:EE_|MN6PR12MB8590:EE_
X-MS-Office365-Filtering-Correlation-Id: 63427955-d073-4c0a-d9eb-08defa478dda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|56012099006|18002099003|22082099003|10067099003|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info: ZxYO0XR3JkDPcBQW7pMwFK7pJdIR1Zx2O3apZ992rpdaYq+kzEgXAm+HFE8tV9C4/ZZmTjRJgKN3b+gxBkTXtMYy3X+xqn/kUAZvKw276tEF/R4nsUaJUMNgmzyUXhvC3mqwSOspf9FM1oXYTGewWwRQkDkK489U7b4XbXmv3SSN2zr3Q3HzrLgDfy0DS6/ZUT1Lpbz4fVJYETg7stOgL/yr9gVl/DntXcASjJnrGdU2uii0LL4ODIPNMbXE4P/WHz0PpV8bo9zmcCQ/q1VqLnlRb2AnA9W8ipv0rlviSpqjz6ATk8M1UUVaMmieNql4Qx3FVOv5TdVKfRKBFb+Bept6jsmTi2l4m3hFmwISNsH7gO/JeenRVhiu9QyF2F0DH2M9K6F9eencG2200OLfQ/hSV3CpEYvI+499qqVfEzaoBLnKwbkY/SwDDDkz8I/Lvpdn8CLpSWZ+eKC7K4NmbdSv+CKlw6vWdAd/GC+g1frm2jSqm/PEMB2zW/sF9dAfGrtmG2mA8xBol4YKN/hh0BFPE6sO4TSRiVTjyfYW/WWXqkF/PkDRGKT6D4gkmOO7D9KJ7d6T2ncOLajz94v3xE/KNF2H7SRxpCOY123VleJ463x6WITLNHOV9z1oLVuaOrCiKzqxONiQtJ+HUfUaMRnAcznNi4ks7DDuNd0tDu9nZ3lLE9MXLZuZZqVx/1slTD3PnXHOK2wV2FHu9ceHJw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(56012099006)(18002099003)(22082099003)(10067099003)(11063799006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UlBSCutHcMxtuXpB1ezeH8xYm15jaKEsSNRl1apeIjgzkG50hlwd9VEJEpMobCivEJNyLthflV33i1cvd1rD5cvp+x6pIgkA6xUf4SocH0A/w5zVwtWoqmgGw3VtRYAcKCBlE2ANSZ0QWtsIgcKjFo3RXjQkdKuyjoE2j5GvT9n32iPF/uvYZ1WMAQRd46hZa16errYzODFWqBb/lfXj/MBSj46nqoLisOozX9jQ+1HZBQyIfWqOccP4i3Ig4teWQtq94/0AWt96f3eebUaPnAjNGM0tn/Rtp6//lFK0yDudEaiWOMUtR62D7bYKN9VafqIpu1IDATfaLPrqZO1LDLj0a7XXcENoBgznyYCwmXJxoxybWpS8rVGXJR13O49EiqPaiHuqAZads1goofLycYGiY8Oet7bJGymuyTtJzIqTB6eNmXpPymKGXsaCVFHl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:56.2275 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63427955-d073-4c0a-d9eb-08defa478dda
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8590
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

Unify variable naming conventions.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c  | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
index 9c7430aec3f3a..1e83cb5064ff6 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
@@ -273,8 +273,8 @@ static int amdgpu_virt_ras_get_cper_records(struct ras_core_context *ras_core,
 		(struct ras_cmd_cper_record_rsp *)cmd->output_buff_raw;
 	struct ras_log_batch_overview *overview = &virt_ras->batch_mgr.batch_overview;
 	struct ras_cmd_batch_trace_record_rsp *rsp_cache = &virt_ras->batch_mgr.batch_trace;
-	struct ras_log_info *trace;
-	uint32_t trace_count = MAX_RECORD_PER_BATCH;
+	struct ras_log_info *batch_logs;
+	uint32_t nr_batch_logs = MAX_RECORD_PER_BATCH;
 	uint32_t offset = 0, real_data_len = 0;
 	uint64_t batch_id;
 	uint8_t *out_buf;
@@ -288,13 +288,13 @@ static int amdgpu_virt_ras_get_cper_records(struct ras_core_context *ras_core,
 	    req->buf_size > RAS_CMD_MAX_CPER_BUF_SZ)
 		return RAS_CMD__ERROR_INVALID_INPUT_DATA;
 
-	trace = kzalloc_objs(*trace, trace_count);
-	if (!trace)
+	batch_logs = kzalloc_objs(*batch_logs, nr_batch_logs);
+	if (!batch_logs)
 		return RAS_CMD__ERROR_GENERIC;
 
 	out_buf = kzalloc(req->buf_size, GFP_KERNEL);
 	if (!out_buf) {
-		kfree(trace);
+		kfree(batch_logs);
 		return RAS_CMD__ERROR_GENERIC;
 	}
 
@@ -305,10 +305,10 @@ static int amdgpu_virt_ras_get_cper_records(struct ras_core_context *ras_core,
 		if (batch_id >= overview->last_batch_id)
 			break;
 		count = amdgpu_virt_ras_get_batch_records(ras_core, batch_id,
-							  trace, trace_count,
+							  batch_logs, nr_batch_logs,
 							  rsp_cache);
 		if (count > 0) {
-			ret = ras_cper_generate_batch_cper(ras_core, trace, count,
+			ret = ras_cper_generate_batch_cper(ras_core, batch_logs, count,
 					&out_buf[offset], req->buf_size - offset, &real_data_len);
 			if (ret)
 				break;
@@ -320,7 +320,7 @@ static int amdgpu_virt_ras_get_cper_records(struct ras_core_context *ras_core,
 	if ((ret && (ret != -ENOMEM)) ||
 	    copy_to_user(u64_to_user_ptr(req->buf_ptr), out_buf, offset)) {
 		kfree(out_buf);
-		kfree(trace);
+		kfree(batch_logs);
 		return RAS_CMD__ERROR_GENERIC;
 	}
 
@@ -332,7 +332,7 @@ static int amdgpu_virt_ras_get_cper_records(struct ras_core_context *ras_core,
 	cmd->output_size = sizeof(struct ras_cmd_cper_record_rsp);
 
 	kfree(out_buf);
-	kfree(trace);
+	kfree(batch_logs);
 
 	return RAS_CMD__SUCCESS;
 }
-- 
2.55.0

