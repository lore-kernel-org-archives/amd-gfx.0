Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3C92F9D0CE
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2026 12:44:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9231110E5EE;
	Tue, 14 Apr 2026 12:44:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1igsDUxe";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011048.outbound.protection.outlook.com [52.101.57.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBEBE10E5ED
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2026 12:44:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mXxVCo9+Iuhet1ts10SvAjtJwH1xvv6VBo+edEaNGs1QFJUAgT9yi80sndBu60QDe/ONH4I/vJrAM7jok3U9lFJ5nUsH4KlET4P7XX/AKekI+MI0MFFNZTx1GsPMa6E1C/U6AfBKHFsXvh4sYl5rVitK3RDMU9Dinuq+F0e5etbWr3iOBskD8hniOOPtY9+MryWYE3uVVagjbSqpDE22BaO0Y8hZhFwAE6C+G7ziCXrP4GkkW+bh/zQ08XYqLYE5K/3Bv1/24t0UbOOerNQQ8xRBagaGQjwfXrJ4dHX4gq5Fb+6/pL6MLWj2xhswFtODbxgCBDbiL/aLcX1Eku5zKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xIt3hxzEACaQKCAlhxspW89ZP5GKpYfqf3IXW5tsgxE=;
 b=t3/4JrGCNcVMy/gRkhmkFCIaXn5yI3G37Shr00fAGucXzv85fo3aDBEF0C3xvbmF4eGYBVd+eMDJSmAqaviOCeSR5yrzcy71EQpzd4xZvHXqf2EXbyV25fQlSyNkN+istjs8j/fj0OJlJNNzaVk8KAdTMXOBOz/rKfo3oh19EQY2B5/tcFFxcvr41RPJGTK7j3fDefaZ81/r6N1lS74eRho8ppQYDiIbaf6fxAa5jT8xm3w/8mZMGvq8JtmjYHZA7i+vEHmY+gM1qr9mNQhwZLMacPXP6Qwvnw/s+JuAmraOeaYv5UK/Seq7kqAQEjWWYIkWzObHzmVe2ldb8RFiHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xIt3hxzEACaQKCAlhxspW89ZP5GKpYfqf3IXW5tsgxE=;
 b=1igsDUxe/j5V4bxS87cCpi6J1xIzxBvYO9WRnEQGOnDew8Mr2URsZPI91TJDunzCttCiDLdYh6n2qcZeId7sqMSfsRwH+1ydTOhOp9PBz0mA7CoeAZgZjkb4J8JG1PY0ZdUm5jWvLiwHsC4AgCTDBYXnUX/Qqwpk3ivrCo7fgF8=
Received: from CH0PR04CA0063.namprd04.prod.outlook.com (2603:10b6:610:74::8)
 by LV3PR12MB9355.namprd12.prod.outlook.com (2603:10b6:408:216::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 12:43:58 +0000
Received: from CH1PEPF0000A34C.namprd04.prod.outlook.com
 (2603:10b6:610:74:cafe::e4) by CH0PR04CA0063.outlook.office365.com
 (2603:10b6:610:74::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Tue,
 14 Apr 2026 12:43:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A34C.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 14 Apr 2026 12:43:58 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 14 Apr 2026 07:43:56 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [RFC PATCH v2 6/7] drm/amdgpu: Add userspace condition support to
 WAIT_EVENT
Date: Tue, 14 Apr 2026 18:13:21 +0530
Message-ID: <20260414124322.2335906-7-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260414124322.2335906-1-srinivasan.shanmugam@amd.com>
References: <20260414124322.2335906-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34C:EE_|LV3PR12MB9355:EE_
X-MS-Office365-Filtering-Correlation-Id: e5d6be81-184a-4362-f97c-08de9a237f2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: P4mu6i86ljPYoqyF8Uexm+dc5MFj+DqxcTS0pO79n3LLJUDOAvESPvV24mcyesvxWIod/Q7O3/0OjgS1m72XkjPLkAAVCblSI1R0y/yldWPLbiyRBNTpIEA9TO6WRCjFo1nPOs2OwP2+xyWyKt1v1lVXNbPKMuv+cxRnFbo1w3SO9AuqMTDFkbDSDrqI907hXNMFluaH43cxkIe9keZ3yt2oim5FlBrtguuzmb7FBhPJXt3V9FliQ+sQNpncz2vxjF9VG9Oajub9AQ4I1oJpWBaE9kF8DhY1eF64cy89NEdncPgb0qm7b+7RytE2acfCF1dGJmDh5k2Ri5VUp4FMAJVE7FNvNX5DNkIXmQOxqIT59bEENr6qV5u51+sxujq2CcoL8Dwa+h5MmB4FtSQHXYp50DIRvK1ZXJNgY76pZeXz5YA1DBLqw//GlqrsmiibmOQADpfckhRM/HIJlnRfekF1PHBNqp3aDb23st321kg8ko5HfwdGdaOh6T08iGavx1JpDAsw4bPdMtuHbYWr+DQrHX7El7Mygxn9g1c/SvbmSO5bZHy6xl2RoeBguTNa3LGvgv+mA93clZHfQGye0Rngbr/tZ1QPCr+fCxpPXmo60R3wuCMBbkazsJHBQyyLFa3lDaRIEpkcp2QnVgL7uPC0wc+jVnT5m+CvLLZZ6JgfUcABuY8cUwG40ygg6MJJMXmKHroMWZGGnJsVWoO3u+NINnRLG0DJ95SeBYTYToO6eX1tF8n93eJmMV4iIEIUUWR57CstqM0PkCxQGlbpiA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4predecWMIHdwiQ/m7fOZV/rMZA6xZP5GG6NwT6ACzS2mw0nwfZFW25mmwxHiogq2X9F4rz4EnseJwm7TX0zcHMIDfq2N4a3hSwT8g5XcZpQgYJktkSPtcKivtjGrwh0iXdt8Ke+PGTXPIMBEue9ExpqDP61SQBwkuMlh7Bpe046W6OyaWQ1XUf4ESsXozf8nSzEkWTrUokzWGCm78PU9e1cIZ/NkgEEhFXz5FNb3rPSB/WbCd0Gj+JgJp3h3nKf3zwYEq1eJfQi7nuC4oa3sEPN8tA6XRn+R7e8YTxLCMSch5rtOdXD9SpDpYwvD6q6+nLTLmIYND2J5OXaDmFjLZPQAwFSQZW4WiuLoYZwgX8imnj8v8JTW8paKWI9Jn7bHBm0fr+a+JlvFLteuCS3r7dLx5i+AfiEAmSQNl5IF8xIaAthhh6qqW+wtBirF6Ka
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 12:43:58.0838 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5d6be81-184a-4362-f97c-08de9a237f2c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9355
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
index a87c75f0ca48..2dbed1bc2977 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.c
@@ -7,6 +7,43 @@
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
@@ -77,6 +114,25 @@ amdgpu_wait_event_pop_match(struct amdgpu_wait_event_mgr *mgr,
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
@@ -207,6 +263,18 @@ int amdgpu_wait_event_drm_ioctl(struct drm_device *dev, void *data,
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
@@ -219,9 +287,22 @@ int amdgpu_wait_event_drm_ioctl(struct drm_device *dev, void *data,
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
@@ -229,8 +310,25 @@ int amdgpu_wait_event_drm_ioctl(struct drm_device *dev, void *data,
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

