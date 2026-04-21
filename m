Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE977F94CA5
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2026 18:07:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B24A10E921;
	Tue, 21 Apr 2026 18:07:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EJjpXU4D";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010056.outbound.protection.outlook.com [52.101.46.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8821610E912
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2026 18:07:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PmUrLQCTYGTLLNvephAba86zO1UExEE2Kgk2NF4a8/SoRt5bqIfmaoGT+SaxLQ23P6UMIdToxxMaWPxl8FGtNqRMLiPB/QUuXtSZ8hHNh6oZhn0P+xe7xJr19lFr7PKxHQbBdIyPNPO3RlNmO4WkJxqiCQFhZJ6CUj6R5rukl79Om8S2fBe99WdmDCYbyXJyJyImKT97rAsudXR8PFfyHEQOQ+zYwY2NrK/TPTtsgHJ4ecP2G1sNs5zKxa1np4peqgIYQ/LIBGZMVazb0nzbaVbOckUm8lhmm9mRtDkHnDz8RFUqN9Vk9U4PsufFxTyH+kHSs6V0f6DTRH9vPIspTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JTRGUydV1MDqUTx1CpnRdRYCOzOy8zP7KQgvTaUaeGU=;
 b=UAKMtmLV/944x6TFa//lUdBdzOlxslKS52ho3+7hILw6QPLHj5YZUCElbR/YkNZU2v6YPG7d4trENPcOx/RH+XrMnHlmDBWlpH6Mtgj1kImFPMJv4AvgSEJWbzx+u7Q2+rVBcxgbzxMe62jUfbOH6m8reKaL+u4STTlgi/+nzf1UKAmShquWb8Y4sUFTQiCFw2jOCONyiJkYK4G9QNFUoc0Xs0L+/rbuDDsbawVdkQyWdG4v9/oatdDs9DXX6u8q5zmnvW8SAnSIUUtTIMqz4/JzynBNvdXfhU6tAzSQ80uHQStBDSZDD9K4y1tZ4W7QlQikM/kyTBK5kFXEFZLdYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JTRGUydV1MDqUTx1CpnRdRYCOzOy8zP7KQgvTaUaeGU=;
 b=EJjpXU4DjM4JtBAFE9Z7+v7WtXMPNUsvTZBqngyiktV0aHR/VMPIAQ2MklV2ynghyIqtqkRZsNKoEp+DebF40hykECrNorIWc+AyFYdOzRNgODy8squfruEJ7Tq2CLlvDgyRQBmSKL0qjUWPkNmvMTKiPB4zQBzLAwqYAUMpXxo=
Received: from BN0PR08CA0006.namprd08.prod.outlook.com (2603:10b6:408:142::26)
 by IA1PR12MB9465.namprd12.prod.outlook.com (2603:10b6:208:593::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 18:07:47 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:408:142:cafe::1c) by BN0PR08CA0006.outlook.office365.com
 (2603:10b6:408:142::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Tue,
 21 Apr 2026 18:07:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 21 Apr 2026 18:07:47 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 21 Apr 2026 13:07:45 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v5 06/11] drm/amdgpu: Add userspace condition support to
 WAIT_EVENT
Date: Tue, 21 Apr 2026 23:36:22 +0530
Message-ID: <20260421180627.2402093-7-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260421180627.2402093-1-srinivasan.shanmugam@amd.com>
References: <20260421180627.2402093-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|IA1PR12MB9465:EE_
X-MS-Office365-Filtering-Correlation-Id: 7db524f4-e4dd-4f86-449b-08de9fd0e4cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 6djPtt6+VTvCpbdCLVmjZ0s3RdS8wJowOiEPwd68a6Exjy6X8CS2EiGOKLjkzxaQq+luBJktF6kUf7N+xmUTXHmZZS4ttOft0e07H0IEiVH4oKZGIJ4zKSqcJW8hJkgdpLyhXIAPjbbAHXIi5xQx94c/D/QTcKzNbPzHcepCtTal4V8S4GolAbExrXJEWGmQJiBB6sEl7tD6YzFWQKBRsc71LmaMwd/xqeFXRi1EeA5JWfMsbNHixNemMjuj5IR09VBTDf047oq58ZMPQDudkIucODSXPvvr3Lqg06IUIEK10XyrWwlMYIuD00Wd/KXpyC9PLsLdto3OzxmK/xH48jHwoR/VcAIX+i6Cg6cFlPJZUmuetTHLn5h6iZxzuAV6qnNezw7e0R/4bY0LF/JQsLf1nyngLJrgYuIZLrE8yIgVxQVdph62tByfF9gsXMK2IG6OT5UkyRUNX7/qii1FBC0hiewGFQFdyYtk+HnpM0XHSzTpwBEdMccI7fDyy0LsnvVT5yHyQwWZLy5XZ82GeaXNEUezQ5soTbIZ+WDglQMcK+0jaiAGvc+/C5CuiyN6bRi9Sx5Kr1Vui1Y+m4usenu3m6CZ+7nfLW/UnztcU7i8JJlwvLPOYQqkFC4tGUUxMxyOk2PMJrb0aCkGirmPFLg+2/ZNvLnfPQhbZA3qZyhYYO5fygSUW5TehkXGo8EkE/Yix1DhRK+MK/eKa+tPIIwvsm3TvP2Chwbcki1PGaeQWnTCcbWHDJD46Pd4Qxx7wQllBVIqwa+giLoCWJPPkQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gJVjJyv+/h4kxx+xPxhH8O0NTSsYF5XQI+Iux4H2CFaRW7Ya5Vdf1e+8R7wuOY/M3vcRmJU+dRFVsNjHSo8chrxX9kNhMndbFI6zuzgg4A9XUAnOC9GRjQmlsxMv6mg4hO7DOzIs/0GQJNJAqMh2QLxN4mmz6iT2Fnc/p+NFP04igvjE5eTPMgvcArWAr38gm2Gme35ZSiWw9NurcvtUXZ6euDnoxCiGlRvcvCIrzAkio+LypmVwzKbDjcRDB4/bsuNbEbJhH3/I51TUI1oF4orOwQ+0IeoydjTSulRuqsTjUe7Cv9UE0bZf9Mg/Z0unnSeu14F3OtROMnqYnEK5+gwSDx48zPd9k8zvVJJ9PoU29QTPeJd7RSwoQUU1m7Qh1feJWS6if5PunWj4OZUGJ4yAQL5n7A+AOEKdZvkrZH+4puiV301XQ9cVDieRecx8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 18:07:47.3366 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7db524f4-e4dd-4f86-449b-08de9fd0e4cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9465
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

Extend the WAIT_EVENT wait loop with optional userspace condition
evaluation.

When condition fields are provided, WAIT_EVENT only completes when both
a matching event record exists and the userspace condition passes.

The condition is evaluated with copy_from_user() in the WAIT_EVENT path
before consuming the matching event record.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_wait_event.c    | 106 +++++++++++++++++-
 1 file changed, 102 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.c
index c055b201c428..f900a7f5f90e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.c
@@ -29,6 +29,43 @@
 #include "amdgpu.h"
 #include "amdgpu_wait_event.h"
 
+static int amdgpu_wait_event_do_compare(u64 addr, u64 value, u64 mask, u16 op)
+{
+	u64 rvalue;
+	bool passed;
+
+	if (op == DRM_AMDGPU_WAIT_COND_NONE)
+		return 0;
+
+	if (copy_from_user(&rvalue, u64_to_user_ptr(addr), sizeof(rvalue)))
+		return -EFAULT;
+
+	switch (op) {
+	case DRM_AMDGPU_WAIT_COND_EQ:
+		passed = (rvalue & mask) == (value & mask);
+		break;
+	case DRM_AMDGPU_WAIT_COND_NEQ:
+		passed = (rvalue & mask) != (value & mask);
+		break;
+	case DRM_AMDGPU_WAIT_COND_GT:
+		passed = (rvalue & mask) > (value & mask);
+		break;
+	case DRM_AMDGPU_WAIT_COND_GTE:
+		passed = (rvalue & mask) >= (value & mask);
+		break;
+	case DRM_AMDGPU_WAIT_COND_LT:
+		passed = (rvalue & mask) < (value & mask);
+		break;
+	case DRM_AMDGPU_WAIT_COND_LTE:
+		passed = (rvalue & mask) <= (value & mask);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return passed ? 0 : 1;
+}
+
 static long amdgpu_wait_event_to_jiffies(__s64 timeout_ns)
 {
 	unsigned long long t;
@@ -99,6 +136,25 @@ amdgpu_wait_event_pop_match(struct amdgpu_wait_event_mgr *mgr,
 	return found;
 }
 
+static struct amdgpu_wait_event_record *
+amdgpu_wait_event_peek_match(struct amdgpu_wait_event_mgr *mgr,
+			     const struct drm_amdgpu_wait_event *args)
+{
+	struct amdgpu_wait_event_record *rec, *found = NULL;
+	unsigned long flags;
+
+	spin_lock_irqsave(&mgr->lock, flags);
+	list_for_each_entry(rec, &mgr->pending, node) {
+		if (amdgpu_wait_event_match(args, rec)) {
+			found = rec;
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&mgr->lock, flags);
+
+	return found;
+}
+
 static int amdgpu_wait_event_push_common(struct amdgpu_wait_event_mgr *mgr,
 					 struct drm_amdgpu_wait_event_data *data)
 {
@@ -245,6 +301,18 @@ int amdgpu_wait_event_drm_ioctl(struct drm_device *dev, void *data,
 	if (args->out_size < sizeof(struct drm_amdgpu_wait_event_data))
 		return -EINVAL;
 
+	if (args->cond_op > DRM_AMDGPU_WAIT_COND_LTE)
+		return -EINVAL;
+
+	if (args->reserved0 || args->reserved1)
+		return -EINVAL;
+
+	if (args->cond_addr & 0x7)
+		return -EINVAL;
+
+	if (args->cond_op != DRM_AMDGPU_WAIT_COND_NONE && !args->cond_addr)
+		return -EINVAL;
+
 	if (amdgpu_wait_event_type_is_queue_scoped(args->event_type)) {
 		if (!args->queue_id)
 			return -EINVAL;
@@ -257,9 +325,22 @@ int amdgpu_wait_event_drm_ioctl(struct drm_device *dev, void *data,
 	timeout = amdgpu_wait_event_to_jiffies(args->timeout_ns);
 
 	for (;;) {
-		rec = amdgpu_wait_event_pop_match(mgr, args);
-		if (rec)
-			break;
+		rec = amdgpu_wait_event_peek_match(mgr, args);
+		if (rec) {
+			ret = amdgpu_wait_event_do_compare(args->cond_addr,
+							   args->cond_value,
+							   args->cond_mask,
+							   args->cond_op);
+			if (ret < 0)
+				return ret;
+
+			if (ret == 0) {
+				rec = amdgpu_wait_event_pop_match(mgr, args);
+				if (rec)
+					break;
+				continue;
+			}
+		}
 
 		if (READ_ONCE(mgr->dead))
 			return -EIO;
@@ -267,8 +348,25 @@ int amdgpu_wait_event_drm_ioctl(struct drm_device *dev, void *data,
 		if (signal_pending(current))
 			return -ERESTARTSYS;
 
-		if (!timeout)
+		if (!timeout) {
+			rec = amdgpu_wait_event_peek_match(mgr, args);
+			if (rec) {
+				ret = amdgpu_wait_event_do_compare(args->cond_addr,
+								   args->cond_value,
+								   args->cond_mask,
+								   args->cond_op);
+				if (ret < 0)
+					return ret;
+
+				if (ret == 0) {
+					rec = amdgpu_wait_event_pop_match(mgr, args);
+					if (rec)
+						break;
+					continue;
+				}
+			}
 			return -ETIME;
+		}
 
 		timeout = wait_event_interruptible_timeout(
 			mgr->wq,
-- 
2.34.1

