Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AF1FCD37A7
	for <amd-gfx@archiver.kernel.org>; Fri,  8 May 2026 14:48:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B35610F52E;
	Fri,  8 May 2026 14:48:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="x/7a9bs7";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010047.outbound.protection.outlook.com
 [40.93.198.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A671010F52E
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 May 2026 14:48:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wCYTXd/qIEIWJ7pKI2ozq8a8oo54xmYkvV/NbNiLnprtif/WjX178tSUAo+QeoGpzkXfUDU9MHIK5j90Qn2BImbEGVsUB97RP8kbsHQurFQpKVn2xduizwTADzZp5UvJq5KiNVE3JI2MrK6IHmiLW07BdQxwRZ/Auj0fp0e5ke1cmHOWqpekNtA/YCvVrZOmlMdZGYpwU0XgnWAsADjExwjhXoKkUMcIfnft6Bh7JnLAPtnCB8EdBKdArVqbzm5lyFMhiywRn+iO5DdBr5hSW8Vy6OQP7y6c0Wz+JMCY0z9pardPihWwBxCbJlAeZiy5xrfrt/837NOTnuxABmowng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BEvK8YLwhOhTSHlMsLTusZHQmLaG7k+Tx+rD15gyy24=;
 b=kHDFw42yyzoDJ+411DfcpN6/bB89fN2yyN2Cm4/2a3/7YYowLbIUXl4z3nBMr9bf49JUC1nfRg+pnkI3SZsvUSISPtcvxelBgJws23CpfFBYdJtxDBkhStmZmmo95xoFYQFkHp28pR1jtYpUHRV4BLjfRhi3aLumuYdIAVAZ5WbZUQGecZbKNL6j2E7A2bgzZnpF0humSHLDpTBcIW70auu+3q7sELaAyHGkVRoMkaYwa2tZ2VXXXzwCY8hWBOgeRaV59MjmQxWmqCoLCmWiMJ//EZxJAnTa8yikQ0uxJqZVnoRf0LsrockOFi8OfeRpzA6bWuc+ayCW/xvAvIo6KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BEvK8YLwhOhTSHlMsLTusZHQmLaG7k+Tx+rD15gyy24=;
 b=x/7a9bs7rwpdJee8gIK3zNAPTppIoerJyp+P5iioobc91yQk0ScE1rUBb39c335oKXoyBqi/oMM8FUJPwUAy0wwmY08JOvRbQ9EJJ/9zmzNCl7ba3/ZjA48cO5C0K5dbwabrarMSm+/4lLMmJe1zSek2wIqVIHT0/ASmyqecRAk=
Received: from SJ0PR13CA0124.namprd13.prod.outlook.com (2603:10b6:a03:2c6::9)
 by DM3PR12MB9391.namprd12.prod.outlook.com (2603:10b6:0:3d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Fri, 8 May
 2026 14:48:37 +0000
Received: from MWH0EPF000C6194.namprd02.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::98) by SJ0PR13CA0124.outlook.office365.com
 (2603:10b6:a03:2c6::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.10 via Frontend Transport; Fri, 8
 May 2026 14:48:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6194.mail.protection.outlook.com (10.167.249.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Fri, 8 May 2026 14:48:36 +0000
Received: from MKM-D1-FRANKSU9.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 8 May
 2026 09:48:35 -0500
From: Chenglei Xie <Chenglei.Xie@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <yipeng.chai@amd.com>
CC: <jeffrey.chan@amd.com>, <zhigang.luo@amd.com>,
 <alexander.deucher@amd.com>, <chenglei.xie@amd.com>
Subject: [PATCH v2] drm/amdgpu: fix OOB risk parsing virt RAS batch trace
 replies on the VF
Date: Fri, 8 May 2026 10:48:30 -0400
Message-ID: <20260508144830.215417-1-Chenglei.Xie@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <BN9PR12MB5306BCE04148F44EA9212B34FC3D2@BN9PR12MB5306.namprd12.prod.outlook.com>
References: <BN9PR12MB5306BCE04148F44EA9212B34FC3D2@BN9PR12MB5306.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6194:EE_|DM3PR12MB9391:EE_
X-MS-Office365-Filtering-Correlation-Id: b167d50c-2d84-444f-3b72-08dead10e2e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: BKX+KuZCqRStFaO+dkxjvdjVNeyciXLAfMz6Rg9MlIwWGukf582gDGuaReZa+4zmzdRIK1WY0liwj/z6a7uQOI3YncZDKL/NqgdXQ6r98RC32P+888mETg58YBx99dC+llZ76Aij+NNRXCV/qRxr+JXy6YAZRqbIpztD0HnaCJsIfQK+JthDhE0lvypDDiLtqhcchzE2z571JV0odyHuK4bKoQ+ZdDowzPyoHq//+kV/XrJ6He2t1C+XtZ55QDG0VN3kC++wBp1DJyE1QOgjHjSK7FYpNWPwIx+nUIKQwRKMqaeVM9j1KWZCPJ86VgakNrPV8A7nsIAL+tdc1ZCjVk1yTuKNgMYEPEtBDpG0fgF5plUGqxNn2c5Xsa50rY9c+lfMfboJjLxRNwJlZGPen4ZJ1GLZQrxuS8x6EZZ+0esorooshIoxE1is9XPuHydzL06qAmBHtoWcWLWylp8NX8YeCPExW5xL1faMpKKxjAzL/d8oDu0c6TuGVHD2gzqkza2aLnwTg4EdRxxEyJ5642PMymu0+if5H5WhGB+Siva9EfbyOeq/g6qEFFS0Go+1/geuGi0xGlwgDvB/FGYPKXGTc/AynJivuXyFVCkJGToBWszVLGsDii2wazzjYT5S/VYUPyLauDPcvGlqwhB250ywhcWZobyfsI6ikOn170vwMZfM7ul9Sk4vIoQ2skAneUWKDO198Wr6DkZjW6pOgeId9Xre0Jut9yMmspOqJgw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AIWUW1eb8j4yH5COjsjMH6fYNNohBzpYOjRbXXmqaapNOMEEv8bfXGyrpo40GZlfocQP0jacluO9ov02x8qZVroBaqfdTjb09mQ7dophvojXXPpvUfJUXpdLoa5BrctcHHkjAR1Y939SssOqTDtznPcHA45D/85Z14qywonNcIvvsEF7T610rpy4VMa7duPQiQ9OtKPwct/J1WF6xEJ8U4hZH4FemzD8KiXpDCz6EgiJ0qe0mFO97IKxBzQQdkoDfn/2miR6Bg0T5UsBidLehPoHzPgKHShUd3EmgzdwIAWI+W6xaLneGzFlvyQjFNSr9t9FLRx3eFDiuOQY0kO+4SR1WZHuZ1TvJZK60f2eOCcUwZzwarKe0HIYB+T1HRKcLG7szniXtcAqRt8/cTiGxrknscxHDkp30RWHrq38o+qK5pK6Fy5Dq2I6kfOzAS2G
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 14:48:36.9336 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b167d50c-2d84-444f-3b72-08dead10e2e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6194.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9391
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

amdgpu_virt_ras_get_batch_records() indexed batchs[] and records[]
from ras_cmd_batch_trace_record_rsp copied out of shared memory without
fully bounding the cache window or per-batch offset/trace_num. A
tampered or corrupted buffer could set real_batch_num past the array,
make a naive start_batch_id + real_batch_num comparison wrap in
uint64_t, or point offset+trace_num past records[].

Add amdgpu_virt_ras_check_batch_cached() for a subtraction-based window
with a real_batch_num cap, re-run it after GET_BATCH_TRACE_RECORD, and
use an explicit batch index into batchs[]. Consolidate batch_id,
trace_num, and offset+trace_num checks; on any failure memset the cache
and return -EIO so the next call refetches.

Signed-off-by: Chenglei Xie <Chenglei.Xie@amd.com>
Change-Id: I6455e9f14914d1b07945b7a57fcb3695435ded64
---
 .../drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c | 35 +++++++++++++------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
index 838eb91aef391..7ec5287daf7f1 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
@@ -192,6 +192,15 @@ static int amdgpu_virt_ras_get_cper_snapshot(struct ras_core_context *ras_core,
 	return RAS_CMD__SUCCESS;
 }
 
+static bool amdgpu_virt_ras_check_batch_cached(struct ras_cmd_batch_trace_record_rsp *rsp,
+				       uint64_t batch_id)
+{
+	return rsp->real_batch_num &&
+	       rsp->real_batch_num <= RAS_CMD_MAX_BATCH_NUM &&
+	       batch_id >= rsp->start_batch_id &&
+	       (batch_id - rsp->start_batch_id) < rsp->real_batch_num;
+}
+
 static int amdgpu_virt_ras_get_batch_records(struct ras_core_context *ras_core, uint64_t batch_id,
 			struct ras_log_info **trace_arr, uint32_t arr_num,
 			struct ras_cmd_batch_trace_record_rsp *rsp_cache)
@@ -204,26 +213,32 @@ static int amdgpu_virt_ras_get_batch_records(struct ras_core_context *ras_core,
 	struct batch_ras_trace_info *batch;
 	int ret = 0;
 	uint32_t i;
+	uint32_t idx;
 
-	if (!rsp->real_batch_num || (batch_id < rsp->start_batch_id) ||
-		(batch_id >=  (rsp->start_batch_id + rsp->real_batch_num))) {
-
+	if (!amdgpu_virt_ras_check_batch_cached(rsp, batch_id)) {
 		memset(rsp, 0, sizeof(*rsp));
 		ret = amdgpu_virt_ras_send_remote_cmd(ras_core, RAS_CMD__GET_BATCH_TRACE_RECORD,
 			&req, sizeof(req), rsp, sizeof(*rsp));
 		if (ret)
 			return -EPIPE;
+
+		if (!amdgpu_virt_ras_check_batch_cached(rsp, batch_id)) {
+			memset(rsp, 0, sizeof(*rsp));
+			return -EIO;
+		}
 	}
 
-	batch = &rsp->batchs[batch_id - rsp->start_batch_id];
-	if (batch_id != batch->batch_id)
-		return -ENODATA;
+	idx = (uint32_t)(batch_id - rsp->start_batch_id);
+	batch = &rsp->batchs[idx];
+	if (batch_id != batch->batch_id ||
+	    batch->trace_num > MAX_RECORD_PER_BATCH ||
+	    (uint32_t)batch->offset + batch->trace_num > RAS_CMD_MAX_TRACE_NUM) {
+		memset(rsp, 0, sizeof(*rsp));
+		return -EIO;
+	}
 
-	for (i = 0; i < batch->trace_num; i++) {
-		if (i >= arr_num)
-			break;
+	for (i = 0; i < batch->trace_num && i < arr_num; i++)
 		trace_arr[i] = &rsp->records[batch->offset + i];
-	}
 
 	return i;
 }
-- 
2.34.1

