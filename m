Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E2FCCD6E55
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2026 16:35:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 176061120D0;
	Wed,  3 Jun 2026 16:35:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0RFzXC82";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012033.outbound.protection.outlook.com [52.101.43.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B07C71120D4
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jun 2026 16:35:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fz8GpZtn/4qglduwp13NlxH6WQfGfDtBT7IQ128YWFxImgMoV9sW7r+nU44+squ7CvwxhcXugVqu71WDPMClttu2pFNiWDLityQ17c4SnHAr5xoaNs6WtnnXl45TLW/NoWx9Xd+FqyPNyxEKoDH+ICDOiFt4wNOdNA6bP80bsQCWEGShQbAO4uyQAnlwqyagAaBgljVsQQEmTwxLRcSlvFgr8f2jfWtDwgaCmrS/Ok3es5gGfj02aIvOFzh3qeZJzBXFwj0YQ2OskI24qqnpmqui1FCPeTIaWYJVSpaicM50IxEisdWnSXOONvLLej94j/e4pUCqktXlNQtrNPFu8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JTRGUydV1MDqUTx1CpnRdRYCOzOy8zP7KQgvTaUaeGU=;
 b=XlFALs8xzxDVjnwPAeQAi1iknV0tTlPUrK/KMKT59BVEmekKiGZAktR+y6y+ljdKXP5aLY/sKqBFzy0nO2kVSH197shnTBrZlOa9xD0KyvGmlDf2hkMLKt9CIAyf30WkFAXk6POPyQ8DjAAz0KxlXShO1sYENzUbCQCDuIJov2ksXAHLc5BwdTtgP9RmHSNnsUqEc7bsmiLXS9Cvm+58znAzTuUmeAwgAd4TdcEYXiMLlVN5JqIpJBrXxWRShnjdGtkJuaoGilekvptCBYIbtlkBvqVH1lS+l2piZoKwwvzvZnN+QhtHrf5y2r932vGVwsZH6ByUU8veotEJo/iopg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JTRGUydV1MDqUTx1CpnRdRYCOzOy8zP7KQgvTaUaeGU=;
 b=0RFzXC822Q4ntuqlwMG0DAy0sK8Uoa2hufGGWsuis6sRFdreXqSnN439nLwQ+08DY+e0Oy8BnF8UA4V4QIKkcRLF3pNyr/W69fUCSvYBYIb1od/7EDVycKN/Rg6JHru7e54apcz0Kh3vcJ2Ts017H8NA3NZQ7bt/H/BPBm/LbJc=
Received: from MN2PR03CA0007.namprd03.prod.outlook.com (2603:10b6:208:23a::12)
 by SA1PR12MB9545.namprd12.prod.outlook.com (2603:10b6:806:45b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 16:35:17 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:23a:cafe::45) by MN2PR03CA0007.outlook.office365.com
 (2603:10b6:208:23a::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 16:35:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 16:35:16 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Wed, 3 Jun 2026 11:35:15 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v6 06/11] drm/amdgpu: Add userspace condition support to
 WAIT_EVENT
Date: Wed, 3 Jun 2026 22:04:45 +0530
Message-ID: <20260603163450.2678374-7-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260603163450.2678374-1-srinivasan.shanmugam@amd.com>
References: <20260603163450.2678374-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|SA1PR12MB9545:EE_
X-MS-Office365-Filtering-Correlation-Id: f34decfe-9934-4696-f3ad-08dec18e183e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: cb/CQQnRpLNNLlNUFlwVFfmx6gUhDougr6t/A4ihhUF1KbxLAy+hM/FD5GX5aoOOsh6t08POZI+Tn2dSUWqoR24nnPuNac3LniQo9DTuhFPxctRc+NiWNVbE3NcwkCqNqNqQ3d3oifS/OZYm46cJ24iKtIFrZtlpLMP4h+QPWvLhpXqY6JPRTiqVomzy+VUhIO86vSTsPOX8cU8PXtQ2j5hLizVT80qXcv2gzDIpftMhe9Fy5FGBu6Zmv+zHrBb5s9JSIfmGSOTsLrdN1uUu3iOJ0UqnmNFxwx9w3mSAjHKoQI8hFIXWaXQr2uK+mhm9k/oVRiu4jb/XdK0bR/tT9+KE5gvoBQhL1JThPWCwIxT+0MSuzIAPX0MyIaQG18x9SdHSqRnNzacx5/BxWPJz1a2GhwDlSZU3YW0eQRbA7fbyFsSqa4FNHqfEZGimH6abtfoJyS++giHNE2iMprPjiw1jMzR3uqi5Sd0t2IZgZ4AmBt9hGXO4mls6EXeAKqO0SDMZZJqQwia80hRMbWDWVOdBmjmVw5ybdM7xy69xGbxgzz1nRKxHPb/+HvYfs+WT3/BmNaL01I3cZzfCyCiTXw0bDDdXb3zDSliB3avz4igXCZlyPk8NCMccFehHBNzivAs2sVUmM27HPpnQ5oLh5oOfP4z89N81Yu/+cJLSIHanpCWtBGq0aiPnVK+Y204Oc7THA/FR6wjLPj4PTkWy3UQI27+qOL7P/InqAxCromo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: p0CXjMIjx/gvBOG4GauE6XK0+7xq4pDMwaJ6pWxQu/xKYXcms7+C3mczYrlHYjUgShtl+ITu5mlBQ6AXLyyDouIwSrW/ku9iaKPXP+abtYwmMIBvKvTXdfUeU3zWapvXh6WYqmELbSf+5qFvCk1bQY+0dcGywmPCFmdt44cWlII7SYX24uXRdWVdrqpSL11dftcXwBWWJRLe6wqneRSLS60fc3p3EO4czF+Vdd5XT5Jmh+Xenv0SC3FpqCrCweuUBb8lyS0o8UwJ7Pz2XKA0ACxF/ID2Z47iVH07xdSnU4Rwr2Z1yOsb5pDR4mFT+BHFvX2SngjaokxjQD9QkbPigMU8M2mZ5iBJHCUHT98pkoLHiGvUQWSiIW2UpIbEQsr2uCfxsdz0gvdFrKeMyexwujsd6S6czPI+yIXjBxLBz1/d7oSzi9QwTPLnay213kL5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 16:35:16.9049 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f34decfe-9934-4696-f3ad-08dec18e183e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9545
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

