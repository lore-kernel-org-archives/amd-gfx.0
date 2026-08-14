Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8038DC5CFC1
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:03:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F2B910E5CB;
	Fri, 14 Aug 2026 21:03:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AwD379pl";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013030.outbound.protection.outlook.com
 [40.93.196.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7F8C10F6D2
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H+A9CyjNx7nKOvT/DS+RGqdY5X29gXQNMqH295Aa0/TJhelSyuT2jbnDiYkkAZtA6Fx83tHVIUpgQ/gbYl2gFrg7AUMIbyaMMuU0Db+aG6O7rei6Oy+47s66VlXhNxzBGFaBPNwM5P0uuST5uJSDMmxp33jFoIjlL6vDUfc6VgSOY98TiE7wglATUnHmt44eqpyZfwf1mQwBPuaMGO30nVFa+YGbynG134l7Q3ghd40Gvi5/BhAztHtr023xhRzD6EKDj9VAIq4FqHPWgw9B8HUpJFkZ1BdJdCV6UirJ1VottG9aO2SjZEFPqm/eXbP0+rUxBKWYoForZd1ZAWvUqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OfOkTc6Rvuv9/rcZFckox6CZXwAhqL81u261RXMO1WM=;
 b=X++Lhpf2lRXx/ACzLVV/w4mMXfQ7Sa25qKYhOBm00B9qyC0QUkTOQgIBXlHsQKlR60OcGOZafczDa7mATU2BsNI+CNFEbgub0M7brGelcdhqVDYukdvzjvzPvuP9VLzal6ps+vvH/Dojuyt3enQytRiyvykSk4khmZ/MiRs/rG7/f+NjLwxvbY+WkVT+NvlyEcAZT28EwCVCq3XdSStuASBEb0RbrnHl3cCiIPfXamfxeJt8K21C8bDhCHJMpBzuZBZT5rXaqv8G10h8ORKFQCBPpuzuTbDZue8ufDNgdp944SdCzorKcYtxbFtflKS+opfVWIFf9n/1o9KSvk1sZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OfOkTc6Rvuv9/rcZFckox6CZXwAhqL81u261RXMO1WM=;
 b=AwD379plOWNnxUB4m3xgQUA3+mOys4aYt8kd0gNWBN+kkvDIV+x9bT7IRfzQkoDD07sh9JdOh3BEYZqWG3YJoCQ6i1fWfclIsUObM7CN54l8Bv1vW8rfIim45ARA4Ghq5M9gtFn+AVY5Bnx2msH3uQLU9wnXTuuINEWieQ3ucHY=
Received: from SA9PR13CA0079.namprd13.prod.outlook.com (2603:10b6:806:23::24)
 by SA1PR12MB8887.namprd12.prod.outlook.com (2603:10b6:806:386::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 21:03:03 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:23:cafe::41) by SA9PR13CA0079.outlook.office365.com
 (2603:10b6:806:23::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.6 via Frontend Transport; Fri, 14
 Aug 2026 21:03:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 21:03:03 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:02 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:02 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:01 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YiPeng Chai <YiPeng.Chai@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 008/109] drm/amd/ras: Add dedicated interface to obtain cper
 info
Date: Fri, 14 Aug 2026 17:01:05 -0400
Message-ID: <20260814210246.3067612-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|SA1PR12MB8887:EE_
X-MS-Office365-Filtering-Correlation-Id: ec7c6612-9f6d-480b-90fb-08defa476e9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|1800799024|376014|82310400026|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: SlKJoD5prc7mPWumOWU7OjID4SYu9CVPgHOEFBz3F27i/rz0EsAkozcJR8uhwW2xZKNl6f+1RVTPhQOHDiVA0yeoFU5n0vZb/IDa2aWcPKwNNYQw9lCNhWrVnyrJLfT8Cwkp50015IndEOxNMIJsSYzlFx65lqS+cqy6BwDRmONfZ8gvkck45dkC44SYlGmCCxSFzW7ek4AJsAmcXeDwQCRr/vnE9lQPEM9llI4EuKoVecu/10jQWlbtgYbDIjMVrV0dttnbtNNLgw4D7lHJrtrmUhciFZxIXQx1MRrDTKYtTb9l3IB7NFedfjaiaRP/WA+hrugCNzk+jUH4ex6rOsJCF7kPlOX28vVIoejv8EbkPEO286PWr2yUrIhIJbsMAyGizV+SLEIJhDYRNHlfERarZcpqChOmohtL6dOR4a/VHZkHZ3GbFQ1abtjbnGtEhj7LlBzfGBABoMq2ghdPtcI7/rR0+p37VALUbvheZ/u7gm1+ex0Dx7urWPnNxAVs9GjTBPEGV0s23aYITPHrD7YpMBo03IYG1fWtZmN5Q4MEy7i+VUYdRhXmam9UOdr4Ibe0jfhXnakt4rqrLpJAEfkGM5vF44i5Y6hGz+fh/dZItgX8Qmih/1S8T6Pad6LgEibsh4IIy6z2+0rEs809UHRgwFww44SdVjtK0STP5q6ocU+3uuBIsJd19k5N4Uruurvv8F2cdOCgpdRa+bn3cg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(1800799024)(376014)(82310400026)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EizNTWFMmMS1Dr7DJgzF375tglSwYEpUHNrnzhDRnXABzzYhNO3cF6h/l/u6ijYk77by9XjKYnRa9/hSbrAQZrjXPTmts/QSitA+g2+fSBq5kGJJK44JOAAoDJnYhDW5xheQZj+W8mYOPjmlCwRTwxI8pKvomX/7qp/GlFECxtGSTkdLIOgRZ64mZ4ZPyQoCj+9CnEM6HdQDbV9r76S4n7sJES1hgy49saKSvlchh6gCJKYxQ5W0v7+ytv5RJXR9i/CKFZ5+GnHSefLuvZljm2hnm0bdKR8mwyNJjln/ubJ3glQYuwCSXEJnrvkVz9uL43ybvLczAoxf2h052KgVALzkeyeoYBlkkivtw+3IMqi6V1Er7I+xXEdw/luymE9kq0YYDQxvwlZpE513gy8+sTg4dtw9HgZLJy+G9G5zSAJYo57d0U4Noyct+tVjPKWw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:03.8077 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec7c6612-9f6d-480b-90fb-08defa476e9e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8887
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

Add dedicated interface to obtain cper info.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/cmd.c            | 12 ++----
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c  | 38 +++++++++++++++++++
 2 files changed, 41 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/core/cmd.c b/drivers/gpu/drm/amd/ras/core/cmd.c
index 6c37dc519eed5..35c53f47e4500 100644
--- a/drivers/gpu/drm/amd/ras/core/cmd.c
+++ b/drivers/gpu/drm/amd/ras/core/cmd.c
@@ -207,7 +207,7 @@ static int ras_cmd_get_cper_records(struct ras_core_context *ras_core,
 	struct ras_log_batch_overview overview;
 	uint32_t offset = 0, real_data_len = 0;
 	uint64_t batch_id;
-	uint8_t *buffer = NULL;
+	uint8_t *buf_ptr = (uint8_t *)(uintptr_t)req->buf_ptr;
 	int ret = 0, i, count;
 
 	if ((cmd->input_size != sizeof(struct ras_cmd_cper_record_req)) ||
@@ -218,10 +218,6 @@ static int ras_cmd_get_cper_records(struct ras_core_context *ras_core,
 	    req->buf_size > RAS_CMD_MAX_CPER_BUF_SZ)
 		return RAS_CMD__ERROR_INVALID_INPUT_DATA;
 
-	buffer = kzalloc(req->buf_size, GFP_KERNEL);
-	if (!buffer)
-		return RAS_CMD__ERROR_GENERIC;
-
 	trace = kcalloc(trace_count, sizeof(*trace), GFP_KERNEL);
 	if (!trace) {
 		ret = RAS_CMD__ERROR_GENERIC;
@@ -238,7 +234,7 @@ static int ras_cmd_get_cper_records(struct ras_core_context *ras_core,
 					trace_count);
 		if (count > 0) {
 			ret = ras_cper_generate_cper(ras_core, trace, count,
-					&buffer[offset], req->buf_size - offset, &real_data_len);
+					&buf_ptr[offset], req->buf_size - offset, &real_data_len);
 			if (ret)
 				break;
 
@@ -246,8 +242,7 @@ static int ras_cmd_get_cper_records(struct ras_core_context *ras_core,
 		}
 	}
 
-	if ((ret && (ret != -ENOMEM)) ||
-		copy_to_user(u64_to_user_ptr(req->buf_ptr), buffer, offset)) {
+	if ((ret && (ret != -ENOMEM))) {
 		ret = RAS_CMD__ERROR_GENERIC;
 		goto out;
 	}
@@ -262,7 +257,6 @@ static int ras_cmd_get_cper_records(struct ras_core_context *ras_core,
 
 out:
 	kfree(trace);
-	kfree(buffer);
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c
index f9ee297a67450..49a17b60bf80e 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c
@@ -259,10 +259,48 @@ static int amdgpu_ras_translate_fb_address(struct ras_core_context *ras_core,
 	return RAS_CMD__SUCCESS;
 }
 
+static int amdgpu_ras_get_cper_records(struct ras_core_context *ras_core,
+			struct ras_cmd_ctx *cmd, void *data)
+{
+	struct ras_cmd_cper_record_req *req =
+		(struct ras_cmd_cper_record_req *)cmd->input_buff_raw;
+	uint64_t user_addr = 0;
+	uint8_t *buf_ptr = NULL;
+	int ret;
+
+	if (cmd->input_size != sizeof(struct ras_cmd_cper_record_req))
+		return RAS_CMD__ERROR_INVALID_INPUT_SIZE;
+
+	if (!req->buf_size || !req->buf_ptr || !req->cper_num)
+		return RAS_CMD__ERROR_INVALID_INPUT_DATA;
+
+	buf_ptr = kzalloc(req->buf_size, GFP_KERNEL);
+	if (!buf_ptr)
+		return RAS_CMD__ERROR_GENERIC;
+
+	user_addr = req->buf_ptr;
+	req->buf_ptr = (uintptr_t)buf_ptr;
+
+	ret = rascore_handle_cmd(ras_core, cmd, data);
+	if (ret) {
+		kfree(buf_ptr);
+		return ret;
+	}
+
+	if (copy_to_user((void __user *)(uintptr_t)user_addr, buf_ptr, req->buf_size))
+		ret = RAS_CMD__ERROR_GENERIC;
+
+	req->buf_ptr = user_addr;
+	kfree(buf_ptr);
+
+	return ret;
+}
+
 static struct ras_cmd_func_map amdgpu_ras_cmd_maps[] = {
 	{RAS_CMD__INJECT_ERROR, amdgpu_ras_inject_error},
 	{RAS_CMD__GET_SAFE_FB_ADDRESS_RANGES, amdgpu_ras_get_ras_safe_fb_addr_ranges},
 	{RAS_CMD__TRANSLATE_FB_ADDRESS, amdgpu_ras_translate_fb_address},
+	{RAS_CMD__GET_CPER_RECORD, amdgpu_ras_get_cper_records},
 };
 
 int amdgpu_ras_handle_cmd(struct ras_core_context *ras_core, struct ras_cmd_ctx *cmd, void *data)
-- 
2.55.0

