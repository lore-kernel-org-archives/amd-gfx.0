Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 686E6C624DE
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:29:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 877CA10EA89;
	Mon, 31 Aug 2026 18:29:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FarvftCn";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013020.outbound.protection.outlook.com
 [40.107.201.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8BD710EA6A
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:29:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MGBPcXK0uxkplj/mZ2ZkfW6PiYV37VxdJ2yAVHZtWSJE6ptIBvYIUeJRTUaXLsAGyZEwfARDz4xjJqtSnfL0tfLhys3hfW3wCm2LeUg4pa3AAzBC9OgZEL9KFVnxRowpbj6nuD9JfcNuRx/uCnrw5KL23UuhiGM3c/AdSdgpvf6PwMk2szVSaWiri0/cDCLb0Hlwpq7PZI+ljqlJPLo8lAzuEhPGm/ZY1dW+oHxKI5ftGyjuwlz+QxLm2oJJRQLmDN5ota1JIfgnzYftaqzOqa4yMh9AuPxru0POBogNG3ApghRbOYWThTs0pP0P1YtR63cF+fFYLl69yHGN2PnWiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GPxCA8rMN2wU+Gif2uZCeVfsUFTE4zEETlJqVT4l1dc=;
 b=clPBD86TOH4d0um/XuB7qY7/Kc3pYzSHjAh8/gDAcjQRDgI0UAMH4+kSAFQjr2PS6qfxoKvp6qp0VmwOLc8xRylEGNQNjMsKyzyGE48EeLuvYe5AMI4BeX4sgUsR3yvWmqaVMV/PcF8BwPyscI6EKNJNBrYt5I5VHZ53q5B3EKeYNL3lavtPd3txxrddGZn5DIJDU5kjNhm/bz2EnZVGGHzq8Xw4pECz/eHCdTEz1HmisAUlMQllqysunA88UB+TtUzeTxjPDZUON5k28YBEWp9O0rj9daFt6xEF0Sa7HeEwSTuBvX/v+EnYYtJmpDAEgng38JRhpAihRE7RG4inzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GPxCA8rMN2wU+Gif2uZCeVfsUFTE4zEETlJqVT4l1dc=;
 b=FarvftCnu2Ty2wXxgt2J1/qwnZHaboqXL6tfr64fL+0QMZIBYtSUd3STWngsl4R5LxG7hl8BEiKbWJaOV/yBWD52UThgyy2NtpDbKpqZqxAAS0z23QWC9mj3C1apRruLs5awNAco5PxZQRIFdWJ+SWI5MKSnxOh/kv5265KxSmw=
Received: from BN9PR03CA0689.namprd03.prod.outlook.com (2603:10b6:408:10e::34)
 by DS0PR12MB7769.namprd12.prod.outlook.com (2603:10b6:8:138::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:29:10 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:408:10e:cafe::44) by BN9PR03CA0689.outlook.office365.com
 (2603:10b6:408:10e::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:29:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:29:09 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:29:00 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:29:00 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 85/95] drm/amdgpu: Add UALink diagnostic logging for vpod
 commit/activation
Date: Mon, 31 Aug 2026 14:27:44 -0400
Message-ID: <20260831182754.1089811-86-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|DS0PR12MB7769:EE_
X-MS-Office365-Filtering-Correlation-Id: ad8488a9-f422-422a-9063-08df078dbfb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: PSf/pk8V2bhiFxLzFZ/0JOsj59mUWQuN1PIluRC2v2rZmWlGj9EmfgQJ+YLHQ9ritOHt5B06aluGJoizjLys2AUjL2dbZPWzB7d/0N2+XKVMjYmYnjEZXYuPK43X2OXTywBhQBqT3vF6NKggioLfeAq7zKQL7VrRxhUFCyk4d8geGAwuxDfU96CGvbhkL8TwXoGDCF0gOe91fadfE71Fg2vw8gGMSTw/hvwyvQrEQPjL8JGgSEgyj7gry8rEv6sTzNkonAa2fCbd7aMILVhJrDcm2Bo9MP7n8CRBNE6+r+zEh0DxF47Q2c86z88DM/hs7hgV0hgpuIhhhY1C8tPb3nL1wLBM1TdPV8w2FE7PMMgnVQXm4x661QLp9oCa0T9tf+G6BbHFIdSTSmNAJX3SX+l6RJeh+bztz76kGZCK/amph/phD1iCVJsqZ2vX31TMxhx6Yp5UuIBGsFUc+eokLLyJSJoPz8c/VwrwVj4ZJHh+9+i+U1NuwT8JlwMo9VF1esvy4ZPUILWlHvWFKXkDefJO/pEKUYUKUrkrshsEgzwAl/42Rnw6K/OlvAlsJsxqFGvqFvwdd+l5qihK71ji8DDN1e+vuVI2d3tM089ZKJ8mExuPdfydyZQ3nvGfWD7gYR68iCeK+fzoeYS87ZTG2PcAYFFC9CSmrWmkPgIL4kN/0J5uCoekEOYyQondIoz4Zr4LxlOOmZtofuPKpbQtEw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JFcTRL0SmcaiRPQ/E/s5+ioK0PTy9mMp0fZMQGI598ATFyuCNv3q4W6MMz4GNTMobY+3LVWjSwPqxGF/m1z7cNv4XjaYjsq2wDR1G+ZW8bASj0REVwHnNU4v7Vqy3LdE/F6v18qje/zmEYmIRQP78TwGQHLFQU5b43YyiosVreE32+Jg+ychw/hboSR1HiZwgpz9LGcfmfXCXHebZ3KGSkR9L2GrUDWR2whhB5f3fXC17B5SpUZ8MwqBBpAoJs19SQuoxxSx3zzVfQ3p5tq+OUrTiOoETZmPebzZWbpcX0WKWB79w3pRya3p8Nnz5jyKbI70Z51ANrRq5Qec8ZmW7a0V6JZoOJ7xsy43OuwSpQCfxwAOHSiawvtZanRMiGvgvXmINJIcXdsfSMsRksi8SnXxvKPhJ7jwQyGMbWcEDruHr/9RBlg71lgol8o3UC+k
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:29:09.7607 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad8488a9-f422-422a-9063-08df078dbfb5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7769
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
index 2d9317db32027..7a84d8ddbf867 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -126,26 +126,29 @@ static bool __check_vpod_info(struct amdgpu_device *adev,
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
 
@@ -243,18 +246,27 @@ static int amdgpu_ualink_update_accel_state(
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
@@ -264,6 +276,9 @@ static int amdgpu_ualink_update_accel_state(
 	/* GPU joining a new vpod should be with invalid vpod id*/
 	scoped_guard(mutex, &mgpu_info.mutex) {
 		if (prev_vpod_id == AMDGPU_UALINK_VPOD_ID_INVALID) {
+			dev_info(adev->dev,
+				 "UALINK: update_accel_state: joining vpod_id=%u\n",
+				 adev->ualink.info->vpod.id);
 			amdgpu_ualink_info_set_accel_state(
 				adev, adev->ualink.info, cfg_state);
 			__amdgpu_ualink_activate_vpod_locked(adev);
@@ -910,6 +925,11 @@ static void activate_accelerator(struct amdgpu_device *adev)
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
@@ -932,6 +952,9 @@ static void activate_accelerator(struct amdgpu_device *adev)
 	}
 
 	adev->ualink.info->accel_state = AMDGPU_UALINK_ACCEL_STATE_ACTIVE;
+	dev_info(adev->dev,
+		 "UALINK: accelerator accel_id=%u is now ACTIVE\n",
+		 adev->ualink.info->ppod.accel_id);
 }
 
 static void deactivate_accelerator(struct amdgpu_device *adev)
@@ -939,6 +962,11 @@ static void deactivate_accelerator(struct amdgpu_device *adev)
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
@@ -1001,66 +1029,75 @@ static int __check_local_vpod_integrity(struct amdgpu_device *adev)
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
@@ -1099,8 +1136,16 @@ static void __amdgpu_ualink_activate_vpod_locked(struct amdgpu_device *adev)
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
 
 #ifdef UALINK_ENABLE_DEPRECATED_CONFIG_SYSFS
@@ -1130,8 +1175,16 @@ static ssize_t ualink_vpod_config_commit_store(struct kobject *kobj,
 
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
 
@@ -1139,15 +1192,34 @@ static ssize_t ualink_vpod_config_commit_store(struct kobject *kobj,
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

