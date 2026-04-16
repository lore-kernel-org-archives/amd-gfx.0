Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04054F433DD
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2026 03:45:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 707B310E804;
	Thu, 16 Apr 2026 03:44:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nj0D+njL";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012010.outbound.protection.outlook.com
 [40.93.195.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7E7A10E803
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2026 03:44:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P4ICC/FYYU0rKdFMZah258q4zDbJbwZbd2gjkOLhhnsy78+Bj81HGKiR3S/oYtURtt680ucipDyksbbHrfdhzyZvOPbd6aCQ/Rs6gogyEPyeBIlJcvgYSIYo0Qc15Hu/PQ0E6RyHorTEFYKXJjdwtl1vPCwSbiK84yCvo+8M6er5ODCbjeSbNl5cARXBPPYcNwUyzkaVq1XOk6mi5GzpcTNysNSxcKpzGl+bAOriCcoPRI786fhJULW6L/L+2PPSc1mqJglWOZwEOzyhgKVJNrA8GDfXA4sbOxO8I52JBRIa5Agbhx4E54GgFG+54Qz8XAr35jb5/TGzlp7xPwv0JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JTRGUydV1MDqUTx1CpnRdRYCOzOy8zP7KQgvTaUaeGU=;
 b=TDbl9mZ8TlQ2/0NJYbR0w4C3350NvCqgjb4GYW/DJ+dIv/i1rG6BS3j7oFPg1u7mbWXdZhE1KuC0xbDrEfVeOWwyme9OZVqREa/n222emKS6wrKNOy0tnfXBkKqtLcIGDqK7J7cd/OGYpz/JQYtg+gv+GLPtElDum898PEAAfD++X3exOE0KRLFmGeSbQCdBCf9Cnf/6TVFJprJYmiNeXI0lAGAaLwxW3f5Bpwql6hyNWouarFoug4VHeYS09U/OLa1f0VUuEgr+4fFpCWtFELUMskoehpbqMCZHReXkACG7Q8X+fHbX4H1ot0NU6dnqNvUjSngEJ3q88r0ENvdJ5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JTRGUydV1MDqUTx1CpnRdRYCOzOy8zP7KQgvTaUaeGU=;
 b=nj0D+njLehamCHLZ52oJdfpZOwUQ6plbv8noB+HubLnMYypnOr1h8q7Rkm3ZzsvBlKSuFdXth39CPdnO75MYaTTxzZ7EwykG+zWHBSJNpi7E2gE/elxtdXxNJx1YGIC3k1yfm/kvL0JeLrtV2ckUV7Blxq+l4Gt4hCtR08tai/4=
Received: from BL1P222CA0006.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::11)
 by IA1PR12MB7735.namprd12.prod.outlook.com (2603:10b6:208:421::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Thu, 16 Apr
 2026 03:44:53 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:2c7:cafe::8b) by BL1P222CA0006.outlook.office365.com
 (2603:10b6:208:2c7::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.51 via Frontend Transport; Thu,
 16 Apr 2026 03:44:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 16 Apr 2026 03:44:52 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 15 Apr 2026 22:44:51 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [RFC PATCH v4 06/11] drm/amdgpu: Add userspace condition support to
 WAIT_EVENT
Date: Thu, 16 Apr 2026 09:14:15 +0530
Message-ID: <20260416034420.2368152-7-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260416034420.2368152-1-srinivasan.shanmugam@amd.com>
References: <20260416034420.2368152-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|IA1PR12MB7735:EE_
X-MS-Office365-Filtering-Correlation-Id: 113ba699-1498-4f4d-000a-08de9b6a84a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: rmKTY1f+FYxmo38a30Zg1nOrCtwbsY4vYrbAdAAzlu3cLyxTBBDGwIuuPkQIy3tQ993uKy/RxDS/c/QuS4dYM0wrCsLoIIX3JLMNJMOSDnQa7mJAYEKl+ccB9vKMJ5VCV10pCJSNTyWez+2yqASSalE5bfne0Mh4u/B5J4G8mABWPEIVA54EtpKBTYRd4XhsZoVFXL2+8w28OY7J261L3tKqJwcAwQSB58LcsEoxqOoJ+JKUnrOmB9atBQmLABPSfEQSmuWU43iBU9FJkKzNIa3FuLLoavjcevXlpGko2BAzdmbH+I0ZUxOP3iTNhVnLRPjfN6tSgCBMvXBrIf2Sg7rDA+2HX3SUX8k6R+kQ42VVMlOGUeL6YSajGLiQOOuBTEyuO5pVp0oOm6BjvZkUV1hrKhdnoSpM4EwbExdjlukJudoKVQ9O10r0dU3d940SNi2X8QonR6XriOg3wtad7JFhZaWhKBw1vgT3/iPME/wttvvWXvzEBnPVd3Q7vPJQ4ylNa2DclzKUwnQEXL3fgbdqle2j+UvDYYBAzYcFH3XQB0FpdpPmvlVelV2sKau8LvHbvaG0Ir5PuudGaMjZNuqha/uyBY0BwDalxrdrzXvUlR+Okgk1HuqOTKSnjyZP/WiptulYgXnEqbiMnBo3I/MUl7XcKro1p3PhrqybLied2gTBuhMfnto3QeNkoC9Lqq6UVGr+v0S/w7fgb7c1PxyAzEiqic1EW+Z6+oK3YkjrXchCSgOhxa7oDGAMnAU7gN1XyulO5afPZbT5QCkxag==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VUmC82iu81tXBwyBlT2HhEYtLkExmqX7aTfpf+rXVS7Rf4scPmaEbadh8QzGZQuvGsNCwLojPRMoayIbHH8eK1955KTROdPXc61p7BJ3PgV7AQZoJZqGPDO3NAfYrqOmyfQ4sVIHeXPN8dVlmHDUC4dHE3xXPkG2+X/ARWCFD970BklCG+mWwRgSngeZvKbmpd4f3zAf+2jSdgxHoLAwfkrKEsLAVOj/jwcmrW1U7qktoLpjqSW4zTm4ezIJ8eyYahUyyFwL8SF5gWaqHA4adpiGskWFt7q6VIkqgMlBcsoPX/MXjhNy8UIdeX4RZUgaAVytSN+uouxnHhW+Q22q2XOtz1ipOEOscAYmOI87LQacDvH5/yXYBrS5exfaNA3hcXRoQJCrAnlOgV3UVrFVpXoseqZz/GmFTHvmoImSmls8kbTuZlMyo43QddkJFxd2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 03:44:52.6796 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 113ba699-1498-4f4d-000a-08de9b6a84a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7735
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

