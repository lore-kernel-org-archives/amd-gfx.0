Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FC33C5DF7D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 19:53:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB99B10F4B7;
	Fri, 21 Aug 2026 19:53:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SvMVSYab";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012025.outbound.protection.outlook.com
 [40.107.200.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27A0A10F4A4
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:53:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I4YICJxkoxHKjMkY/baMfo3oSnHHPQ18oeEc7RcxvabsVwrDcJctemkEkQ0j838YKpE1rr4zWfuQbVohsPQqgV+5Pb3fWYme4NweIJKwwp94UNMBc9MuprWa7sFf9f0AIiTy9N8FvIUipFgXQhnqSfbKu9blPztp5gI6rbwoEX416Ph+EquYBa+pZuDu9+S2llR2qqNakVGr8LORMHIFxfZbf6ymo0zezmTs0sFWfgTLshm7nr2KW6lAiYD5RBBgaP/E/ozapMtLyTkv78gnoJievaTIDkKMHaAeuvfpZQ4MYtdqjpZhgXvP071QVR18cmAntOMWkNH1AyYW0LDgRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c5Blsef4kE/AY3vWCdRUkFglz2NN5/curzwPLWLM2kQ=;
 b=Eec4F6zusUtOa4QLK7r6pkgSLWUTy0Lt/cU+0LPDZrE/pL/SXa/B/ETVcTEUYTHiyVlaau0ylbxad6TMsa2ndyG6hpOBVoMuw54vZsT4CT1f8zhqRkjmApP6zn2VJGQ12fPWZv/PMrzeTrgjoKYFDCwSD6KhwuADttQ4gqdjtIu101ze+TMd9slaWbACCn0pKJ6jgL8YajQQM8dFWUL+JqpUaqqheLuKjdW8zQ44TWDosVElpeN+iWs3IAurrbrdBe5johxAx5vKqo4WgeCXPdPsofq9xteEgK15/QnXK5rY7KVp0F9wpjXM2xArDFiKLLJfLotnVZG1NPlN2zvlDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c5Blsef4kE/AY3vWCdRUkFglz2NN5/curzwPLWLM2kQ=;
 b=SvMVSYabsCN1KNKvZQ9jgSva9/o9d8YZMN37+ESIZvLHdzwrUpWJH2ly4jV1ssB6VazlVbXgAD8BYIjiTzkSSnFQT9+/q7v6Qi8F/NlVX75xKxZxFDT0rV9Mn9QXdoH8jUeX+PLuC4rozGemc28jkt/dU3zLqPImNG76QodO5CU=
Received: from PH5P222CA0002.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:34b::9)
 by DS4PR12MB999076.namprd12.prod.outlook.com (2603:10b6:8:2fa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 19:36:12 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:510:34b:cafe::5f) by PH5P222CA0002.outlook.office365.com
 (2603:10b6:510:34b::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:36:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:36:10 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:36:05 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:36:03 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:36:03 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 85/95] drm/amdgpu: Add UALink diagnostic logging for vpod
 commit/activation
Date: Fri, 21 Aug 2026 15:34:48 -0400
Message-ID: <20260821193458.808626-86-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|DS4PR12MB999076:EE_
X-MS-Office365-Filtering-Correlation-Id: aa5ecd32-5b79-4524-94a7-08deffbb741f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|1800799024|36860700016|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: W/ZybXT+PZ9mGG20U6gEYrBFE3OMyMiCVhiZ2ETN3NGa+LC+OjVmbp8CS3/YzRaV9obFx9AUfd6Jh7BadapE0bV/CRCzBrZpvnBDpa0VWWErGmmnPkJQduIda/bSJIAsmo9VBY1Gs5gehtXqkEahWCDBkLujUon9s1829jEgABA7y+Rq7QMw23fK1BkftWL/XJYYAGJLL5vnSgO1oRFIt3Ka7Ktz4E0RXC8xxtWZyasjDq/PHcOizgruxz5x2MlQ4pMKZ+O4KLp24l5BHbk/q4sAIwgCSWr/GH1C2m2LvxdZ3HyFt7YG1fZjnRDXB/zeVoqVXYayITlvgtpHssiklWZhlsejZoRGTwNUzb3JcZ/PP5AR4VORhzBS/CLu5Gt8nJ44l8QczouaYjwcmNmEVVOg+z23uK8vTcBRIRduqRnOJE9G44sPuqrUvmkArXUsUBB75p5B8+MZgVhQEu+A0aSarDxC/c85q3SJcAFi1czQgx1LVgzUhPMvhr9c1YlmZl9e/CDqre1wdfjWa4hSvkIhP/grd0wuyKvUoWqecLNKMmCcaT/UyfdG0obC+wSRlUdLohoWdfT+Wn2n5siv++2pKgo6hmX76sbELPz+k71ikUWCLHapmS2P7yb0P3hF+G48rko16N3MfnIyNGKFuKecsyBQVj1C/L4mGJoSYBmQee0huR0imWQdcX4p3w0QSy1cSQ22ywHBZUol+EJP8A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(1800799024)(36860700016)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IWu/+pj2+Yw1R57DOCADlUR2q6r3W0OT+QgYPNZfn+P21GZuVHslX+Iye3hMcs1DzWiHoyXmFEt/W3S1zVtOPT7r70Ci7u1OO2coBbiZK5uRFSbI0lqe48b/wvWUpBvUX5GYKyVvYOtMV7s8gJuWvnPZGGfugX0tGcxoBAUWjdF63i/LVZ5OxgjGvI3O2aA4O+45x7opMfKOBqT8DSxIsnRm7j7j+Xbbjfwtn7jOH0ZETCH2GpNBMhummY0S6+wrwMXvqQ9vkpqWNS9NKSg05S0wE/HCr4KMMoFaiQUx93nOHl6phYBQwpw/Taq5pKFlmhEa2+vsoDkYEL30JINjXj59ganJOtFOnnc1mIJXgPfj2vUsvwIOHCuEqp9fkEtkNjPJxkPyTAv2GhEksSXANK2+UA8riKidGzyzeNkjXaFuJUVhRC5CetSeSjEKW5sm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:36:10.4701 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa5ecd32-5b79-4524-94a7-08deffbb741f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB999076
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

From: Mukul Joshi <mukul.joshi@amd.com>

Add UALINK:-tagged dev_info/dev_warn logging along the vpod commit ->
update_accel_state -> integrity -> activate path so failing and -EAGAIN
peer-wait cases are visible without dynamic debug. Also fix a wrong
print arg (vpod->id -> vpod->addr_mode) in the invalid addr mode
message.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 156 +++++++++++++++------
 1 file changed, 114 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 8486d7b3dbe66..5d5df0a288803 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -125,26 +125,29 @@ static bool __check_vpod_info(struct amdgpu_device *adev,
 	unsigned int weight;
 
 	if (vpod->size == 0 || vpod->size > ppod->size) {
-		dev_dbg(adev->dev, "vPod size %u out of range [1..%u]\n",
-			vpod->size, ppod->size);
+		dev_warn(adev->dev,
+			 "UALINK: vPod size %u out of range [1..%u]\n",
+			 vpod->size, ppod->size);
 		return false;
 	}
 	if (vpod->addr_mode >= AMDGPU_UALINK_ADDR_MODE_MAX) {
-		dev_dbg(adev->dev, "Invalid addr mode %u\n", vpod->id);
+		dev_warn(adev->dev,
+			 "UALINK: invalid addr mode %u\n",
+			 vpod->addr_mode);
 		return false;
 	}
 	weight =
 		bitmap_weight(vpod->active_accel_bits, AMDGPU_UALINK_ACCEL_MAX);
 	if (weight != vpod->size) {
-		dev_dbg(adev->dev,
-			"vPod size doesn't match vpod_active_accels list: %u != %u\n",
-			vpod->size, weight);
+		dev_warn(adev->dev,
+			 "UALINK: vPod size doesn't match vpod_active_accels list: %u != %u\n",
+			 vpod->size, weight);
 		return false;
 	}
 	if (!test_bit(ppod->accel_id, vpod->active_accel_bits)) {
-		dev_dbg(adev->dev,
-			"Accelerator ID %u not listed in vpod_active_accels\n",
-			ppod->accel_id);
+		dev_warn(adev->dev,
+			 "UALINK: accelerator ID %u not listed in vpod_active_accels\n",
+			 ppod->accel_id);
 		return false;
 	}
 
@@ -242,18 +245,27 @@ static int amdgpu_ualink_update_accel_state(
 	struct amdgpu_device *adev, enum amdgpu_ualink_accel_state prev_state,
 	u32 prev_vpod_id, enum psp_gfx_ual_config_state cfg_state)
 {
+	dev_info(adev->dev,
+		 "UALINK: update_accel_state: prev_state=%d prev_vpod_id=%u new_vpod_id=%u cfg_state=%d\n",
+		 prev_state, prev_vpod_id, adev->ualink.info->vpod.id,
+		 cfg_state);
+
 	/* If the device is already active and its vpod_id is unchanged, the
 	 * update does not affect vpod membership. Skip the local vpod
 	 * integrity check and re-activation.
 	 */
 	if (prev_state == AMDGPU_UALINK_ACCEL_STATE_ACTIVE &&
 	    adev->ualink.info->vpod.id == prev_vpod_id) {
+		dev_info(adev->dev,
+			 "UALINK: update_accel_state: already ACTIVE, vpod_id unchanged\n");
 		amdgpu_ualink_update_vpod_config(adev);
 		return 0;
 	}
 
 	/* A new vpod_id of 0 means this GPU was removed from the vPod. */
 	if (adev->ualink.info->vpod.id == AMDGPU_UALINK_VPOD_ID_INVALID) {
+		dev_info(adev->dev,
+			 "UALINK: update_accel_state: vpod_id=0, removing accelerator from vPod\n");
 		amdgpu_ualink_update_vpod_config(adev);
 		scoped_guard(mutex, &mgpu_info.mutex)
 			deactivate_accelerator(adev);
@@ -263,6 +275,9 @@ static int amdgpu_ualink_update_accel_state(
 	/* GPU joining a new vpod should be with invalid vpod id*/
 	scoped_guard(mutex, &mgpu_info.mutex) {
 		if (prev_vpod_id == AMDGPU_UALINK_VPOD_ID_INVALID) {
+			dev_info(adev->dev,
+				 "UALINK: update_accel_state: joining vpod_id=%u\n",
+				 adev->ualink.info->vpod.id);
 			amdgpu_ualink_info_set_accel_state(
 				adev, adev->ualink.info, cfg_state);
 			__amdgpu_ualink_activate_vpod_locked(adev);
@@ -897,6 +912,11 @@ static void activate_accelerator(struct amdgpu_device *adev)
 	if (adev->ualink.info->accel_state >= AMDGPU_UALINK_ACCEL_STATE_ACTIVE)
 		return;
 
+	dev_info(adev->dev,
+		 "UALINK: activating accelerator accel_id=%u (accel_state=%d)\n",
+		 adev->ualink.info->ppod.accel_id,
+		 adev->ualink.info->accel_state);
+
 	/* Enable incoming NPA address translation with NPA VMID */
 	r = psp_ual_set_npa_config(&adev->psp, adev->ualink.psp_if_ver,
 				   adev->vm_manager.npa_vmid, true);
@@ -919,6 +939,9 @@ static void activate_accelerator(struct amdgpu_device *adev)
 	}
 
 	adev->ualink.info->accel_state = AMDGPU_UALINK_ACCEL_STATE_ACTIVE;
+	dev_info(adev->dev,
+		 "UALINK: accelerator accel_id=%u is now ACTIVE\n",
+		 adev->ualink.info->ppod.accel_id);
 }
 
 static void deactivate_accelerator(struct amdgpu_device *adev)
@@ -926,6 +949,11 @@ static void deactivate_accelerator(struct amdgpu_device *adev)
 	if (adev->ualink.info->accel_state < AMDGPU_UALINK_ACCEL_STATE_ACTIVE)
 		return;
 
+	dev_info(adev->dev,
+		 "UALINK: deactivating accelerator accel_id=%u (accel_state=%d -> PPOD_CONFIGURED)\n",
+		 adev->ualink.info->ppod.accel_id,
+		 adev->ualink.info->accel_state);
+
 	/* Disable incoming NPA address translation with NPA VMID */
 	psp_ual_set_npa_config(&adev->psp, adev->ualink.psp_if_ver,
 			       adev->vm_manager.npa_vmid, false);
@@ -988,66 +1016,75 @@ static int __check_local_vpod_integrity(struct amdgpu_device *adev)
 		peer_info = peer_adev->ualink.info;
 		/* peer device ppod not configured */
 		if (peer_info->accel_state <
-		    AMDGPU_UALINK_ACCEL_STATE_PPOD_CONFIGURED)
+		    AMDGPU_UALINK_ACCEL_STATE_PPOD_CONFIGURED) {
+			dev_info(adev->dev,
+				 "UALINK: integrity EAGAIN: peer accel_id=%u not ppod-configured (accel_state=%d)\n",
+				 peer_info->ppod.accel_id,
+				 peer_info->accel_state);
 			return -EAGAIN;
+		}
 
 		accel_id = peer_info->ppod.accel_id;
 		if (!test_bit(accel_id, info->vpod.active_accel_bits))
 			continue;
 		/* peer device vpod not configured */
 		if (peer_info->accel_state <
-		    AMDGPU_UALINK_ACCEL_STATE_VPOD_CONFIGURED)
+		    AMDGPU_UALINK_ACCEL_STATE_VPOD_CONFIGURED) {
+			dev_info(adev->dev,
+				 "UALINK: integrity EAGAIN: vpod peer accel_id=%u not vpod-configured (accel_state=%d)\n",
+				 accel_id, peer_info->accel_state);
 			return -EAGAIN;
+		}
 
 		if (!uuid_equal(&peer_info->ppod.id, &info->ppod.id)) {
-			dev_dbg(adev->dev,
-				"Peer %u ppod_id doesn't match: %pU != %pU",
-				peer_info->ppod.accel_id, &peer_info->ppod.id,
-				&info->ppod.id);
+			dev_warn(adev->dev,
+				 "UALINK: integrity fail: peer %u ppod_id doesn't match: %pU != %pU\n",
+				 peer_info->ppod.accel_id, &peer_info->ppod.id,
+				 &info->ppod.id);
 			return -EINVAL;
 		}
 
 		if (peer_info->ppod.size != info->ppod.size) {
-			dev_dbg(adev->dev,
-				"Peer %u ppod_size doesn't match: %u != %u\n",
-				accel_id, peer_info->ppod.size,
-				info->ppod.size);
+			dev_warn(adev->dev,
+				 "UALINK: integrity fail: peer %u ppod_size doesn't match: %u != %u\n",
+				 accel_id, peer_info->ppod.size,
+				 info->ppod.size);
 			return -EINVAL;
 		}
 
 		if (peer_info->vpod.id != info->vpod.id) {
-			dev_dbg(adev->dev,
-				"Peer %u vpod_id doesn't match: %u != %u",
-				accel_id, peer_info->vpod.id, info->vpod.id);
+			dev_warn(adev->dev,
+				 "UALINK: integrity fail: peer %u vpod_id doesn't match: %u != %u\n",
+				 accel_id, peer_info->vpod.id, info->vpod.id);
 			return -EINVAL;
 		}
 		if (peer_info->vpod.size != info->vpod.size) {
-			dev_dbg(adev->dev,
-				"Peer %u vpod_size doesn't match: %u != %u\n",
-				accel_id, peer_info->vpod.size,
-				info->vpod.size);
+			dev_warn(adev->dev,
+				 "UALINK: integrity fail: peer %u vpod_size doesn't match: %u != %u\n",
+				 accel_id, peer_info->vpod.size,
+				 info->vpod.size);
 			return -EINVAL;
 		}
 		if (peer_info->vpod.addr_mode != info->vpod.addr_mode) {
-			dev_dbg(adev->dev,
-				"Peer %u addr_mode doesn't match: %u != %u\n",
-				accel_id, peer_info->vpod.addr_mode,
-				info->vpod.addr_mode);
+			dev_warn(adev->dev,
+				 "UALINK: integrity fail: peer %u addr_mode doesn't match: %u != %u\n",
+				 accel_id, peer_info->vpod.addr_mode,
+				 info->vpod.addr_mode);
 			return -EINVAL;
 		}
 		if (!bitmap_equal(peer_info->vpod.active_accel_bits,
 				  info->vpod.active_accel_bits,
 				  AMDGPU_UALINK_ACCEL_MAX)) {
-			dev_dbg(adev->dev,
-				"Peer %u vpod_active_accels don't match\n",
-				accel_id);
+			dev_warn(adev->dev,
+				 "UALINK: integrity fail: peer %u vpod_active_accels don't match\n",
+				 accel_id);
 			return -EINVAL;
 		}
 
 		if (__test_and_set_bit(accel_id, local_accel_ids)) {
-			dev_dbg(adev->dev,
-				"Duplicate accel_id %u among local vpod peers\n",
-				accel_id);
+			dev_warn(adev->dev,
+				 "UALINK: integrity fail: duplicate accel_id %u among local vpod peers\n",
+				 accel_id);
 			return -EINVAL;
 		}
 		local_accels[n_local_accels++] = accel_id;
@@ -1086,8 +1123,16 @@ static void __amdgpu_ualink_activate_vpod_locked(struct amdgpu_device *adev)
 			"Local vpod integrity check failed: %d\n", ret);
 		return;
 	}
-	if (!ret)
-		activate_local_vpod(adev);
+	if (ret == -EAGAIN) {
+		dev_info(adev->dev,
+			 "UALINK: activate deferred, waiting for local vpod peers to reach VPOD_CONFIGURED\n");
+		return;
+	}
+
+	dev_info(adev->dev,
+		 "UALINK: integrity OK, applying local vpod (%u local accels)\n",
+		 adev->ualink.info->n_local_accels);
+	activate_local_vpod(adev);
 }
 
 static ssize_t ualink_vpod_config_commit_store(struct kobject *kobj,
@@ -1105,8 +1150,16 @@ static ssize_t ualink_vpod_config_commit_store(struct kobject *kobj,
 
 	if (!sysfs_streq(buf, "true"))
 		return -EINVAL;
+
+	dev_dbg(adev->dev,
+		"UALINK: vpod-commit enter: accel_state=%d staged vpod_id=%u vpod_size=%u addr_mode=%u\n",
+		info->accel_state, config->vpod.id, config->vpod.size,
+		config->vpod.addr_mode);
+
 	if (info->accel_state < AMDGPU_UALINK_ACCEL_STATE_PPOD_CONFIGURED) {
-		dev_dbg(adev->dev, "Ualink ppod is not yet configured\n");
+		dev_warn(adev->dev,
+			 "UALINK: vpod-commit rejected, ppod not configured (accel_state=%d)\n",
+			 info->accel_state);
 		return -EINVAL;
 	}
 
@@ -1114,15 +1167,34 @@ static ssize_t ualink_vpod_config_commit_store(struct kobject *kobj,
 	prev_vpod_id = info->vpod.id;
 	r = psp_ual_set_vpod_config(&adev->psp, adev->ualink.psp_if_ver,
 				    config);
-	if (r)
+	if (r) {
+		dev_warn(adev->dev,
+			 "UALINK: vpod-commit psp_ual_set_vpod_config failed: %d\n",
+			 r);
 		return r;
+	}
+
 	r = psp_ual_query_info(&adev->psp, adev->ualink.psp_if_ver, info, NULL);
-	if (r)
+	if (r) {
+		dev_warn(adev->dev,
+			 "UALINK: vpod-commit psp_ual_query_info failed: %d\n",
+			 r);
 		return r;
+	}
+
+	dev_dbg(adev->dev,
+		"UALINK: vpod-commit fw read-back: vpod_id=%u vpod_size=%u accel_id=%u ppod.size=%u addr_mode=%u\n",
+		info->vpod.id, info->vpod.size, info->ppod.accel_id,
+		info->ppod.size, info->vpod.addr_mode);
 
 	if (info->vpod.id != AMDGPU_UALINK_VPOD_ID_INVALID &&
-	    !__check_vpod_info(adev, info))
+	    !__check_vpod_info(adev, info)) {
+		dev_err(adev->dev,
+			"UALINK: vpod-commit __check_vpod_info() failed: %d\n",
+			r);
 		return -EINVAL;
+	}
+
 	/* The integrity check makes sure each new GPU is consistent with the
 	 * other GPUs already in the vPod. All known local GPUs can become
 	 * "ready" at the same time.
-- 
2.55.0

