Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77B66CD6E50
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 15:17:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07D6A1120BF;
	Fri, 29 May 2026 15:17:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lnN3yImJ";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010061.outbound.protection.outlook.com [52.101.61.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C0AD1120BF
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 15:17:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WnwTBZhHtg04Ds1DRyOSGWvJwVuZMzpQkJP/yywnHPv7fvqKuFqplB/m560O/kKDV8nSXmLFGPzjrEyrlROJFkh9y1/oD5iY/kd3+3LUxdYBPrZQG9M2oq7nlN/R4ARRXBDWJ419q1xZqOjcd2DxbIutHrX0DRUxZYEBo32Sj6/A8Cl1nYi23pprbx+7+tYlKnOcx+kNPWKpOxBN08surh0lfB9iDEazq4rZwRhFVmd9/1yUv37uM0u3hX/i/tNNX7CIZi5xDm3qFXH+D167kxS2+cIm0Hzli8OyITtieTK2X0jAC+dOODin0fI9jZuzOEIw6tFJwgJjJtUWN+Rwfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c0Qp2tO73s3ISBeus3P+vC2SMh+yVPe0Zm2fvAqJ9sU=;
 b=pzBsGj2Zf55IPBt5du4MtcBA2o5GCyXlEAmolcQPetU3UDioas/Vw4M1ZG0fvmCU2PTLY8dEOkGmm/Trj1i3Wj9NHXY2LWlKOANd0O6cd14hltQ9BHX8m3ODpYbECgwquFy2gwIGgks204LKp0dF5R4yZE554S+eba/9hmfSYf2LPUa+xumgeImXj5zo/Se8ZRthRxc6B2fhzRd1ptj6yGAruCAKVsfEpUOcE6O28+Oxst50OUiFffchyizNYsSf3h2RlOPAnLCB58ihEyrNTOhhGDVd3vxDKtpgj0iqyxo9NHugwGaW7uARYQJ5nvTfskRGUehfPV2DBaLirjyouw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c0Qp2tO73s3ISBeus3P+vC2SMh+yVPe0Zm2fvAqJ9sU=;
 b=lnN3yImJsttjKsQCDVVON06MBYBvM7j4co2+qzvz8CJgSYq3ovo/ycI5Vu3wVg01P1S9QGJvDHqDtyayY5eEpPo3JdPM336Qp4uSodPNl2mX0eN3wHEC/Oc3avfI47ipF6QjlRxtaW18CiuoMg+7AbYuVFcYvjrLlPdsE7hax6A=
Received: from MN2PR18CA0021.namprd18.prod.outlook.com (2603:10b6:208:23c::26)
 by DM6PR12MB4284.namprd12.prod.outlook.com (2603:10b6:5:21a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Fri, 29 May
 2026 15:17:02 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:208:23c:cafe::4d) by MN2PR18CA0021.outlook.office365.com
 (2603:10b6:208:23c::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Fri, 29
 May 2026 15:17:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 29 May 2026 15:17:01 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 29 May
 2026 10:16:59 -0500
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Stanley.Yang@amd.com>,
 <YiPeng.Chai@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH 2/2] drm/amd/ras: chunk UNIRAS CPER debugfs reads
Date: Fri, 29 May 2026 23:16:24 +0800
Message-ID: <20260529151624.1144318-2-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529151624.1144318-1-xiang.liu@amd.com>
References: <20260529151624.1144318-1-xiang.liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|DM6PR12MB4284:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a7cc3ce-f162-4408-e335-08debd955551
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|11063799006|22082099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: NoN6z6rD9pPgFy9Js/RT+ghY0qNmNJCuA56sO/N4oHSE+RwDF9IUmF47EoTn2anxfKHpq6bNPpwl5cOHAA1uOUW0XJihLyXhgNgbW4bjQVxheqTRousdmcESl+MFUZLbL7vul4dnqd4Bk4c6y7PFz1F9ovDPr/Tf5RDWC55/WVdObzfoLJVCC2stuMU9MgVM1ZF/R1NUXjLbsl892qIOakMeOu1eCX418BGPLjs+DCjOI+VHJ9L48M9xJMrEYNpJrgvwlgMaHSWUf7VlqfK71E2BgfxXQhqPbL/5m58wT/82lxI8uX4xGz8g8HwIPlxyBTzfU1PB7oNpaDuVgsTL1vu9n/ePDV6h4obF+/LAiuJsy4N86jNk9HV+119oo6TmfLeuqYG/vnEZRy7wUmgMG60F1LxzxkQJrrV4jsOlJiwlCbnYegbN4mrs0VyEiYKU1iRe3Ps2WhILhyQc1gxCmzcxghxmQBqfNehhizcaSWfrN7D08+GB5pzxqaSizUutXasbEsJb9Na3GZOpAgS+K9u8Im4dPtnmSxTaQkSRKPFkcibBg41lBq5EqC6VQgFyi3fvT+wxPtQ6FxSDgT7oiiDTexe1fl33bcrJ9XbqQECdsrvKo1GIGRtBy/OCkrHzQjLryABnbfM56QpqXAwqr31XoHmYocmukmhyFFa8FNE2Pe/u8Ub2XboLtCQjLQQ0EIm9OZQEg+nVgH7FRumf+dd6jGow7w6cN6/O4ZqQw5M=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(11063799006)(22082099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xC/mVtEta8mq39p1EnvrpDymx94SeoRCCdZUH6OKM8v/rdo0Hkob4ABOBxfVpuquRQJyr81T5w7AJ4gurxn/gQk20a5XGuwLmM2yXWCdy8Z4emeMSLBKVbLG+K+IG/fRCt7zu8OpJDKjrldAaRxc3on7v+GT64gzUTR1gWIP3nVWLOn9ox7edueajch2y6/T+GAld7qabbh/n1p+WYL9ljL8xceqDjvdjS3V2Hx5Cgmqez864yttjMnuIwc3ih1oAV4JKraqJngMYueqoTuFh8CvFRhFQti3sX6hZQsPmmNdEliydph8k0xIDHLH7qNZVd3DeBkJTIYc3l4HQhnimSnSURCc+vG6XhCdZUrDJ8FTE8jbgbi1VVgLZYIW+7FRYLhQvFw6wMaUFT7kuBr6m7+1MlY1Whu+OSRW6u0ZfrDvfyllCp889Zg7IdfP/BVJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 15:17:01.1965 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a7cc3ce-f162-4408-e335-08debd955551
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4284
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

Legacy CPER ring readers can issue one debugfs read with a buffer larger
than the UNIRAS RAS command payload limit. Passing that full size to
GET_CPER_RECORD makes the command reject the request, so userspace may
only see the ring prefix and treat the CPER stream as empty.

Commit 07d0ee31a5d6 ("drm/amd/ras: bound CPER record fetch buffer
size") intentionally bounds CPER record fetch allocation by the command
buffer size. Keep the debugfs ABI as a single contiguous ring read by
splitting the internal GET_CPER_RECORD requests into
RAS_CMD_MAX_CPER_BUF_SZ chunks.

Accumulate the copied payload and update the legacy header write pointers
from the total bytes returned to userspace.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 49 ++++++++++++++++--------
 1 file changed, 33 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index e8cee3728ade..5dc00db14a32 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -501,6 +501,8 @@ static ssize_t amdgpu_ras_cper_debugfs_read(struct file *f, char __user *buf,
 	u32 total_cper_num;
 	u64 start_cper_id;
 	u64 cper_offset;
+	size_t chunk_size;
+	size_t total_data_size = 0;
 	bool read_header;
 	int r;
 
@@ -550,30 +552,45 @@ static ssize_t amdgpu_ras_cper_debugfs_read(struct file *f, char __user *buf,
 	if (!data_size)
 		return 0;
 
-	record_req->buf_ptr = (u64)(uintptr_t)data_buf;
-	record_req->buf_size = data_size;
-	record_req->cper_start_id = start_cper_id + cper_offset;
-	record_req->cper_num = total_cper_num - cper_offset;
-	r = amdgpu_ras_mgr_handle_ras_cmd(ring->adev,
-					  RAS_CMD__GET_CPER_RECORD,
-					  record_req, sizeof(struct ras_cmd_cper_record_req),
-					  record_rsp, sizeof(struct ras_cmd_cper_record_rsp));
-	if (r)
-		return r;
-	if (record_rsp->real_data_size > data_size)
-		return -EIO;
+	while (data_size && cper_offset < total_cper_num) {
+		memset(record_req, 0, sizeof(*record_req));
+		memset(record_rsp, 0, sizeof(*record_rsp));
+		chunk_size = min_t(size_t, data_size, RAS_CMD_MAX_CPER_BUF_SZ);
+
+		record_req->buf_ptr = (u64)(uintptr_t)data_buf;
+		record_req->buf_size = chunk_size;
+		record_req->cper_start_id = start_cper_id + cper_offset;
+		record_req->cper_num = total_cper_num - cper_offset;
+		r = amdgpu_ras_mgr_handle_ras_cmd(ring->adev,
+						  RAS_CMD__GET_CPER_RECORD,
+						  record_req,
+						  sizeof(struct ras_cmd_cper_record_req),
+						  record_rsp,
+						  sizeof(struct ras_cmd_cper_record_rsp));
+		if (r)
+			return r;
+
+		if (!record_rsp->real_data_size || !record_rsp->real_cper_num)
+			break;
+		if (record_rsp->real_data_size > data_size)
+			return -EIO;
+
+		data_buf += record_rsp->real_data_size;
+		data_size -= record_rsp->real_data_size;
+		total_data_size += record_rsp->real_data_size;
+		cper_offset += record_rsp->real_cper_num;
+	}
 
 	if (read_header) {
-		ring_header[1] = record_rsp->real_data_size >> 2;
+		ring_header[1] = total_data_size >> 2;
 		ring_header[2] = ring_header[1];
 
 		if (copy_to_user(buf, ring_header, ring_header_size))
 			return -EFAULT;
 	}
 
-	r = read_header ? record_rsp->real_data_size + ring_header_size :
-				record_rsp->real_data_size;
-	*offset = cper_offset + record_rsp->real_cper_num + 1;
+	r = read_header ? total_data_size + ring_header_size : total_data_size;
+	*offset = cper_offset + 1;
 
 	return r;
 }
-- 
2.34.1

