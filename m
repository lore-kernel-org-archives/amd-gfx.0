Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80415CD343F
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2026 20:29:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1556810F255;
	Thu,  7 May 2026 20:29:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aPIoIumG";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010038.outbound.protection.outlook.com [52.101.201.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A91BD10F255
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 May 2026 20:29:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gt47NyYgfF6zqECsI1ELY6vtmx9rduofY98uABnMN05LupJktVGkZWUDMwTbKRvfREqbr/Ss2JY9yibZk5EQseiRwbYdUTP7C+so3dlw3x8fISyFqQnoXYswkKmEW4x1bSLb6B8/HO99zFJT3oYtcTxTvU4V2RQXv3ezrmaMzb+HN2630rtcdC+zMLvS9zV+BQrUsf9FbkNy/e84ST3lHlJ5Ooh/eXq8lt1e1j6Cv3XrJgDs1TZTL+YgsWZufC6V2kw5GHKqzJBsTpBAJZYtrVkdVZLpuhZIv3ewHbvOaYhT1zmOntxrBS36KuPZ8fZto+WE5rtU4TjxR+4LGBzJFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mbhyEl6cI86rJhTwgo3NCXuM+FG2LYPyYFuGgrzN+Ec=;
 b=JwseNEQ2mang20/JtmARSdzvQxc2K3oUo7zgCihfmLzRmWiXGr+sI4g81FPeReQXNg1vOSodxew61DDunrCOJqOz10Ubek0MzF2DThW9CHwzzYlYjGbMDNa+U+k4XXpDXiDjXQCxPRV0HD485nAwXi+tTIsZGMMkBXAg4HClMZn6J7Zp3lBQQ959nlJFzTqMltmMEO48X8uJYQIryZGW2iMqZX4KgjsHPiP5SvBrcMCfzQIe3x13A6/RCve/9WmNbD59ry8LMJK56CDnMWXY6N5vWbajCCOnt+fdFxmdX9tbP0BkRhKy8oZ3VBwWXBDLYuEKEDRMLb7Vi1PubRvlgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mbhyEl6cI86rJhTwgo3NCXuM+FG2LYPyYFuGgrzN+Ec=;
 b=aPIoIumGLk0fWgI/sk9G1glEZJDKXCKXZxUuBJ1hnE5tKo4Nh5/2FCGXo/PAOXH54Cv/IuxJwkFoJO0GCV+Pr2cSFuKGL227yxNZZlyHt1KNFCXKlzSeY/cxt68tQyjdlkOoYS3BLdSIYEAT9I//2SsZv8duQTRt5gXM7HmLyXA=
Received: from BN9PR03CA0784.namprd03.prod.outlook.com (2603:10b6:408:13f::9)
 by DS7PR12MB6333.namprd12.prod.outlook.com (2603:10b6:8:96::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.18; Thu, 7 May
 2026 20:29:35 +0000
Received: from BN1PEPF00004685.namprd03.prod.outlook.com
 (2603:10b6:408:13f:cafe::2b) by BN9PR03CA0784.outlook.office365.com
 (2603:10b6:408:13f::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.16 via Frontend Transport; Thu,
 7 May 2026 20:29:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004685.mail.protection.outlook.com (10.167.243.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Thu, 7 May 2026 20:29:35 +0000
Received: from MKM-D1-FRANKSU9.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 7 May
 2026 15:29:34 -0500
From: Chenglei Xie <Chenglei.Xie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <jeffrey.chan@amd.com>, <zhigang.luo@amd.com>,
 <alexander.deucher@amd.com>, <chenglei.xie@amd.com>
Subject: [PATCH] drm/amdgpu: fix OOB risk parsing virt RAS batch trace replies
 on the VF
Date: Thu, 7 May 2026 16:29:29 -0400
Message-ID: <20260507202929.110177-1-Chenglei.Xie@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004685:EE_|DS7PR12MB6333:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e1686cf-aaf4-4ef3-e3f0-08deac775a80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: upArQh2gMKiMXsLFO5wYyrt/amge2BGtsrOFPUZkscm/drGRGjvCBecEfy2S9OOgrMwOLiqZncdkhDc9wr39sDep07aO1T27OamB7cRi4Wwy/Vvx1MJSu+6yNeMD6wz9JQ0/ZFKEU6AMRZdbwojXS4wwPPt/xQxJrqnVjmOWYG/qUHa+vN9cJoH2ncx4ZKY/7nko/x2CHJvtnuUXb3AeuBmlRr1GF+XM0Uo+wMxmJnoeelEQdTnUCkArgb1wJKMs0e/26FzBIA5XFFr15PUNH49rvsuE/tbC5o6wzJPrnBPgJwxaraGVTvvtXENHFbtyKMryZssAzWFK4znmsqIdcUSRPljRJsHLz4DoNcFsUS3Z8HUJJgA4bfUwSrCOCbZJrnhDGyPMR3PFPVRIQUszfBV8TAajoy/Y/vtUBuRvd3yj4BqcwLV3ErrFQPZS6+5icdf4wAnLRDHwLRsN2H9KCFS/fNwW6ihbcagBX37M81QwdZcC8Uhba6vKAJDN87RH0r2EJySNPkOuAPwyrxXZ7auFQQuc3utDCVgQS2OecrUx01pa+LDYS3SDacljdLTj89WJdHGDDQVCyfEK/p9VLILEQMG45H0okqoNycKOJ19rPcGhSBslje58M9WUtIXoEoCKFL8a1n3NtjBbttBT4TkPm5bk7DPEz/9SAnMWjFfgglm+3N27TULXo0OjEVtjGfzxufhOFHpjsQ/I1MTcG/Mu61FoFNfAmgjf/t+mcLM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8OpXBxnTwiUgMpjtgHkthiBCIRDs9WtbPpyNe3szpebkwIItYigNK99BJvp6qZGDVTLWD9lrxOBbQSoDtrWTFbsPiiysL6EMrnMalDVmnip0XKJNmU2hY8zMS7IvITs6mHgyc9W2CBVPLRbn65F4WE02E0C4gHMdXF2olRXDYooqQoUKaakOrak5CkJbtiRiSDoYSlTMT3xVo4tMML478SMFW70qRTwkC4qhSaCkiaQMkbcClhTAee35ViSAEw/9/Jf68f9y+GCir4HzF+otEV92yKWos+4LO6b3jdG5/Aidjw76GA4/W9z9j7c4vDjMa1xlmmvWzuw2rlnfLa3xVl6yo0l3JkgLWROJ2Cd5wvAAYV+NbfhJGx9Qa4ucgxv16KD/923Q7ZtoaJzOjZsZflrItgjYUC0Su77e1m7thzYvQjC9ocnSREpUtQKWVpKR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 20:29:35.2243 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e1686cf-aaf4-4ef3-e3f0-08deac775a80
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004685.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6333
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

The VF copied ras_cmd_batch_trace_record_rsp from shared memory without
fully constraining real_batch_num, the cache window, or per-batch
offset/trace_num. A hostile or corrupted buffer could make
batch_id - start_batch_id index past batchs[], make start_batch_id +
real_batch_num wrap in uint64_t and confuse the refetch logic, or make
offset+trace_num walk past records[].

Validate the response like the PF path. single helper for the cache
window using subtraction and a real_batch_num cap, bounds on trace_num
and offset+trace_num, re-check after the RPC, and memset the cache when
invalid. Return -EIO for bad layout and -ENODATA for a batch_id slot
mismatch.

Signed-off-by: Chenglei Xie <Chenglei.Xie@amd.com>
Change-Id: I6455e9f14914d1b07945b7a57fcb3695435ded64
---
 .../drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c | 38 ++++++++++++++-----
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
index 838eb91aef391..fcb421d39f87d 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
@@ -192,6 +192,16 @@ static int amdgpu_virt_ras_get_cper_snapshot(struct ras_core_context *ras_core,
 	return RAS_CMD__SUCCESS;
 }
 
+/* rsp contents are copied from shared memory; validate before indexing. */
+static bool amdgpu_virt_ras_batch_trace_rsp_covers(struct ras_cmd_batch_trace_record_rsp *rsp,
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
@@ -204,27 +214,37 @@ static int amdgpu_virt_ras_get_batch_records(struct ras_core_context *ras_core,
 	struct batch_ras_trace_info *batch;
 	int ret = 0;
 	uint32_t i;
+	uint32_t idx;
 
-	if (!rsp->real_batch_num || (batch_id < rsp->start_batch_id) ||
-		(batch_id >=  (rsp->start_batch_id + rsp->real_batch_num))) {
-
+	if (!amdgpu_virt_ras_batch_trace_rsp_covers(rsp, batch_id)) {
 		memset(rsp, 0, sizeof(*rsp));
 		ret = amdgpu_virt_ras_send_remote_cmd(ras_core, RAS_CMD__GET_BATCH_TRACE_RECORD,
 			&req, sizeof(req), rsp, sizeof(*rsp));
 		if (ret)
 			return -EPIPE;
+
+		if (!amdgpu_virt_ras_batch_trace_rsp_covers(rsp, batch_id)) {
+			memset(rsp, 0, sizeof(*rsp));
+			return -EIO;
+		}
 	}
 
-	batch = &rsp->batchs[batch_id - rsp->start_batch_id];
-	if (batch_id != batch->batch_id)
+	idx = (uint32_t)(batch_id - rsp->start_batch_id);
+	batch = &rsp->batchs[idx];
+	if (batch_id != batch->batch_id) {
+		memset(rsp, 0, sizeof(*rsp));
 		return -ENODATA;
+	}
 
-	for (i = 0; i < batch->trace_num; i++) {
-		if (i >= arr_num)
-			break;
-		trace_arr[i] = &rsp->records[batch->offset + i];
+	if (batch->trace_num > MAX_RECORD_PER_BATCH ||
+	    (uint32_t)batch->offset + batch->trace_num > RAS_CMD_MAX_TRACE_NUM) {
+		memset(rsp, 0, sizeof(*rsp));
+		return -EIO;
 	}
 
+	for (i = 0; i < batch->trace_num && i < arr_num; i++)
+		trace_arr[i] = &rsp->records[batch->offset + i];
+
 	return i;
 }
 
-- 
2.34.1

