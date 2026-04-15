Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 771B0F43858
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Apr 2026 16:07:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 102C510E71E;
	Wed, 15 Apr 2026 16:07:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tebfTMLb";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012071.outbound.protection.outlook.com
 [40.107.200.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64ED110E71B
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Apr 2026 16:07:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y3WcSWLawzcWz4ehUlWN7554JAlprN3HcJKElk4z8C5YpYMfBDz4j+2ydTXSkzjpW+5FlbpcH41reHJMA7EHFEmzMUMCKRYRa4+ALZ5lKivLv8pJOSpklaJ+wqHPikOQuNP6izuujvHJyd3tYmoA5SqAeYOZITDUgZh46c14B94FeaW6RU7C4Ecu/0BDGSPc7dClcbXbFGAZpxizVNiao5VgcBKyLq7ddDKRVTRnJ4MePO8OgeEBYQ2zwkTxwETMS84QY06aws238q8DYi2e476F57YjQS8Zfw8Rz6Knprq3dxiPsFbfUAhpPaDvD5v2G7U/mYPI4Zfb9Uc028FoMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JTRGUydV1MDqUTx1CpnRdRYCOzOy8zP7KQgvTaUaeGU=;
 b=aLyC96xUfWY6vcbpNNfUuMp2O22Wx+o4umvGQtET1MKOQs4JQv6kwhvf2Qs3yAJzzF4YvcFgq1F6PqnWGH7CDCb9AnQVcQZ4CunE2p4rb5ef5A90hO8g7Fb0a0Dv7S7R6SY9nsFI4V4Augya7z33L+90Ckh++rfPgcJ6835N41+lVEu0Z3vveACJWx2X1Jw2sCcJaeVOgVRt0tBCmbiMzeAurWhZyzXgC4rBMizpPIrcmsKzYRbtsG0t/w4fKBFKEuqCXqC/1elsA0+EZ+vLCzp6TxegLNbx9YphAcBo2D/0glWIJrm+3UruRA5uHWFVaOOlXgJBx40HkCMtRsenfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JTRGUydV1MDqUTx1CpnRdRYCOzOy8zP7KQgvTaUaeGU=;
 b=tebfTMLb9PV1IUzxogdQSj0HRNpcLBU0mUJdTz4o3VNNTFG7ExsxsZjr1vdN4HzeVUKIJXtjawR+5f0koTs/tmw/7G5UcmEhVVWrOzEAthQl7BGXIU0olTIXFl+Nj7IR3IjaiH79p58Rky0XWkvwjPvBYL5NYBAGFL0i9wxuS8Y=
Received: from SN7PR04CA0085.namprd04.prod.outlook.com (2603:10b6:806:121::30)
 by PH8PR12MB7304.namprd12.prod.outlook.com (2603:10b6:510:217::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Wed, 15 Apr
 2026 16:07:45 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:806:121:cafe::7d) by SN7PR04CA0085.outlook.office365.com
 (2603:10b6:806:121::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.50 via Frontend Transport; Wed,
 15 Apr 2026 16:07:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 15 Apr 2026 16:07:44 +0000
Received: from rtg-navi32.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 15 Apr
 2026 11:07:43 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [RFC PATCH v3 06/10] drm/amdgpu: Add userspace condition support to
 WAIT_EVENT
Date: Wed, 15 Apr 2026 21:37:07 +0530
Message-ID: <20260415160711.261553-7-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260415160711.261553-1-srinivasan.shanmugam@amd.com>
References: <20260415160711.261553-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|PH8PR12MB7304:EE_
X-MS-Office365-Filtering-Correlation-Id: 230ee534-167a-4bb4-3863-08de9b092159
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: dW3UqAif0kyZaZIkuUvvOcCDWzmAuvOek3JiBov2wNpaZsKKlHDNAN+rAW0D5bWFhdTjHsIN4aOIvZjgIsEUsv/lNKATTiXFOeQFYcc1DEOX0inOC3ElucOqAvhDgvOqlFuJSAkQ7ujZ3+9ZAXw1Ui5rbM84SP7p9wMRUd41Lwz4HryY0J3fHMqlzhWf25B5AphuQGPJkhatUdpLqJ60VnKyvEUm+3CG2Jn3RheENyuVBDBr0/W/T8XhqT6x4ro7eQOd5sIQHRorCOLprVFc7cpnvTQkjcjrpVKg80dp9CoEoHqTsBbmMWakVsYAqEq1ojmFdetpTnzbrz8gH8hMswRbfGv3l3fo00vXX83vHcTa1B3XJoRH87RTzUM46nyt+/9JRFpTpIO2MnkVxe6N3Mgb+lTFzwbmnFmFhRZXHxTkK813T3OO1x5TUxE0QPlakspMlLKm2um5yEYvdxVN7PVpCzIHgmZy7cgtCuhRTDhODm+cTz600e5yeFJhMjZ3XApHv0wxfNv9mVgOLdVPOjE93bBr8IxeFXe2MCdjUicWFELQ8OSHad5G4+JS2fVfvsUqVvnSpeyNFnXZNpODcx2pZjSUb+Zr58ZjVhLVYEit7xiIqtzBow3UMxJIkuVpb4n6oOrSbCP+aK6s/xI3RFdreXPG+9nIRMETo5XdwXUnv3X0F8znuy7BWgXK75Rz87zAd53vbMI0u7NN0ywOvq/liUZ1AHy+Ab8W2zuINPSKhxQU5Dd6gm+XsYwUngw/sd5ESnvnj5THRZtwLYuB4w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HN1cyCgQJXBGLcg6kj24ons0CBeVmVilAqUavuIWikpswgLZnv5zob6uaSg1s430CFBoX4Mc8hzrQyp9EEeqAHXxEee/v6tMkIUUftgOJrse+2hbSD8AuMH92NEK0i5YDD/GhZVryzhb4miSYZx8pPSQiQUIjm24UCPISWSrV2zmKz6TPpT034ACE2Usso14t3dGbh5jCp+DI5PAD/FlXAoE+RassckFjeGkOWREQhsz6KbE7IAyxfPL6q8khY4YhlOBV4DjWrgyDI6C+KRfeDcZxHxFvodh79OX7lK/ABe3wJu1r06LcR+/t+HFWQvyGFCquUnEQPelAikxV9NI693LFkPx116mjgGhGw6pX6/TOcM9+xLJAcwcO7zeMST+ygFIv1dm+otHdgyqmHWJ+SgSVNclvylF6RnpR3JQGr6iRudSNOKxua2wQYzYuQ4o
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 16:07:44.9294 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 230ee534-167a-4bb4-3863-08de9b092159
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7304
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

