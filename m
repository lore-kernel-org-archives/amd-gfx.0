Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FDD9C5DF7D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 19:53:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0D5F10F4A0;
	Fri, 21 Aug 2026 19:53:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kybzU1/Q";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010055.outbound.protection.outlook.com
 [52.101.193.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94F3810F4A0
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:53:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XhX1yhtxc3pIZuctKPU3kUZkwV6G5B2uhj0KCFg0E/VloMuYZmTVXsso/Vnp9vlES/fObUKfh9arMPK31IVrIa4DxOs4GnxOAYeoGv2sQLgmZFmZOAmgWkGapBuu+wLCrqYYIGIpeLwsXQBuG9RcOqbrRvcJNVklAwghEpqhBHL61CdAUNN8SN0wXyx4zOUTWUSCZXXKDnGH2TI7lH8Nk25wjzKNnbOTyUsZvnKCchO0K3ZgM5h7PnLtIcu9F4wa748xHFBWgdg3/+Ol+Lg/taNZ0PdHHBlSi4VpZgZ2TQ2ohnzL9gvNEehSwXUfaJMEYdqoeKKqHK1rIkhZ7gQXIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E1g/eShgkQy2l+HaosSJkwzSG3OjMcG5M0mqHLTqFrU=;
 b=p3VYKNWijcZMDg6KucB5XbrsxUbON3vPJ97FqD9Kj7wqqhJ8+AUQLPCegmsLJiu7o062c6+YvqM2V6TpfFNxrmbPRMWhJTagZ07/CxDMcRXtrSODrw6P7o/sNPXfErWjDUMfZtvII73CvUAW6EIE0oAVkkLPcDQ6XB0kW1M/IrpM/gTFEeLJoBsaxhJ8Lb0myAtz2XHlV3Wut26v+s7wUs6puZXSHKP3uQIr5Q3HSpZUtRn2t47n7ZqP/xV+uCxxXNecdRfZFhdcCo2f2sJIwLKkwHBBe8ByZNfdZ5SN75nkNz/HSQU94GPOkr0/mdJG3h4DQ2rtY9BHpsZlQhsexA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E1g/eShgkQy2l+HaosSJkwzSG3OjMcG5M0mqHLTqFrU=;
 b=kybzU1/Q6W1vo+gizL1FKca6OQ/zfCo0QvsSuD7rTpKKgqE8jqeBDBcvyTiNorkW6I6LxIJimiE45WGHwhTQEqwbV/P7Q7z6dXlRAhWqiN10SGdmC/gxG0u9twV0p1pkyXpFTcdcWSdL4q7XRI4YdbVuceSdvT3GLvS808H45N0=
Received: from CY5PR19CA0067.namprd19.prod.outlook.com (2603:10b6:930:69::11)
 by SJ2PR12MB8740.namprd12.prod.outlook.com (2603:10b6:a03:53f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 19:36:11 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:930:69:cafe::5c) by CY5PR19CA0067.outlook.office365.com
 (2603:10b6:930:69::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:36:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:36:11 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:36:06 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:36:04 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:36:03 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 86/95] drm/amdgpu: Handle UALink vPod reconfiguration while
 ACTIVE
Date: Fri, 21 Aug 2026 15:34:49 -0400
Message-ID: <20260821193458.808626-87-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|SJ2PR12MB8740:EE_
X-MS-Office365-Filtering-Correlation-Id: a1c7cc3e-365b-4f77-ddff-08deffbb7485
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|22082099003|18002099003|56012099006|6133799003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: iX4bEquHaFyRwoo1c34SXbRnTfaZo9k73DCSYGcELlnKyW+t32C0ReL/uiRVoTXU/fst5hkrE9kuxm44fMYIGpKDF9/3m2A5UOVqb5P6en4MEwOt0RBw88G8FcqpUGMGOfKKDrnXoeClELVolf75JcNqcgfhmkdus/doOuQYMUZNlKLa0/0bEZLKEpPMt2l2kfFrQvv/eeuGCCQK2sj7kPN6o3dGbKftPjok70pR8JoF9w9DAXBMKKJXnqJXi3b8AzVt+fXco/r/JkyASEt/SbAtXy9YDuP5C7t0Wmz+oXsSfu/chR0GXEG8XIs9xx5uzXZtRPfRFMiZi6ZfcVMBo8xWGhxqjUQZBcMGMYS1jJUeEUWAHIhfCmef2wn8otZ4ovr7aF4HNZdW8IUZ+FZ0xuA66rM5O6vJ1dMOcwlwX6W1S11x7FvlBT76DDfEdnCduuUezlyxreSlgwGh0f4Dduhd4xALy//kT/iRgcGG1lLkzL2UF7ScnSWTxBVV9CbvzbdIjGI4iZuHf4/8RnqA1ASMsPvIPe7YFaRGnnIX+5+81hH0YuDxd+g3Unmdw7AGpBmCNr8QUg0zKBM9vnHzeB4d5SMEYSJWYqGomnH0NMjKUyzm9uTduoTTBmlQPo6TyWGihgF47oXrrx8Td8T5yO4/eyvxpMvzXxKCv7mhY8wM0521NmS0JvBomMUKRrPcheyKUhYidJFLRCDey9b5Ug==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(6133799003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xYCIzL4gtWSWRfCrt9O3yF4nzrdtNxVVZ60vHL4p4a62tROM+WHqoetyD5eFlfPLEjxOTJfgow/qMBMNG1AajghcePmtvjM+ty5K/XSTROGgR/IU/ZAtVPpdFC6r3KJLkVKmfMhMp0w4/kC4Ly+D/XYbDuiZLWKHZeJj6ItrcMS77bGtnPgTu7W/0kJ93kXL1/5ji9UEr7kFLQZufzyoYuesJnJ3LpHmwvvqgm5LLQFmRDzqC9ah+NY1+gVpGc/z8v3IblGsqJpgG8NlbffiIr0AK91E6Owl7GfI/9EYZ/S93oSnBO+9plbjZpyse7qQz3fXFWZsnLVQVvAopv82Cm/8+hzdfIwh4HBoH7jsFmwo19uRetgKGFHB5NpKhU95vsqNOaolSeKlUg/gTPHwNodS2p0xoP+x6G2cElyPXsr0QxqwGKqV8oc4+zXBmW6f
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:36:11.1245 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1c7cc3e-365b-4f77-ddff-08deffbb7485
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8740
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

An already-ACTIVE accelerator with an unchanged vpod_id skipped
re-activation, so growing or shrinking a live vPod left staying GPUs
with links/GART built for the old member set. Detect membership changes
(owned snapshot vs firmware read-back) and bounce affected ACTIVE peers
once the integrity check passes. Firmware requires a full metadata
reload while halted, so a full deactivate/activate is needed rather than
per-peer deltas.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 60 ++++++++++++++++++++--
 1 file changed, 57 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 5d5df0a288803..c4f253a7cb417 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -53,6 +53,7 @@ static int amdgpu_ualink_remote_shootdown(struct amdgpu_device *adev,
 					  u32 remote_accel_id, u64 addr,
 					  u32 size_in_pages, u32 flush_type);
 static void __amdgpu_ualink_activate_vpod_locked(struct amdgpu_device *adev);
+static bool amdgpu_ualink_vpod_membership_changed(struct amdgpu_device *adev);
 
 #define STRIP_NPA(addr)						\
 	(((u64)(addr) & ~AMDGPU_UALINK_NPA_ADDR_GPUID_MASK))
@@ -256,9 +257,24 @@ static int amdgpu_ualink_update_accel_state(
 	 */
 	if (prev_state == AMDGPU_UALINK_ACCEL_STATE_ACTIVE &&
 	    adev->ualink.info->vpod.id == prev_vpod_id) {
-		dev_info(adev->dev,
-			 "UALINK: update_accel_state: already ACTIVE, vpod_id unchanged\n");
 		amdgpu_ualink_update_vpod_config(adev);
+
+		/* Same vpod_id, but the member set may have changed (vPod grown
+		 * or shrunk while this GPU stayed ACTIVE). If so, run the local
+		 * vpod activation path: once every local peer has committed the
+		 * new config (integrity passes), it bounces the affected ACTIVE
+		 * peers to rebuild links/GART for the new member set.
+		 */
+		if (amdgpu_ualink_vpod_membership_changed(adev)) {
+			dev_info(adev->dev,
+				 "UALINK: update_accel_state: ACTIVE vpod_id=%u membership changed, reconfiguring\n",
+				 adev->ualink.info->vpod.id);
+			scoped_guard(mutex, &mgpu_info.mutex)
+				__amdgpu_ualink_activate_vpod_locked(adev);
+		} else {
+			dev_info(adev->dev,
+				 "UALINK: update_accel_state: already ACTIVE, vpod_id/membership unchanged\n");
+		}
 		return 0;
 	}
 
@@ -980,7 +996,24 @@ static void activate_local_vpod(struct amdgpu_device *adev)
 			/* info->local_accels is corrupted? */
 			continue;
 
-		activate_accelerator(peer_adev);
+		/* Bring the peer up to match the current vPod membership.
+		 *
+		 * A peer that is not yet ACTIVE (or whose ACTIVE membership
+		 * changed on a grow/shrink) has its remote metadata, links and
+		 * GART mappings built for a stale member set (or none at all).
+		 * Firmware only accepts a full metadata reload while halted, so
+		 * surgical per-peer deltas are not possible: fully bounce the
+		 * accelerator. deactivate_accelerator() is a no-op when the peer
+		 * is not ACTIVE, so this handles first-time bring-up too.
+		 * Unchanged ACTIVE peers are left untouched.
+		 */
+		if (amdgpu_ualink_vpod_membership_changed(peer_adev)) {
+			dev_info(peer_adev->dev,
+				 "UALINK: (re)configuring vpod for accel_id=%u\n",
+				 peer_adev->ualink.info->ppod.accel_id);
+			deactivate_accelerator(peer_adev);
+			activate_accelerator(peer_adev);
+		}
 	}
 }
 
@@ -3936,6 +3969,27 @@ static inline struct amdgpu_ualink_remote *to_remote(struct amdgpu_device *adev)
 	return adev->ualink.remote;
 }
 
+/*
+ * Returns true if the vPod membership most recently reported by firmware
+ * (info->vpod.active_accel_bits, read back via psp_ual_query_info() on the
+ * committing GPU) differs from the owned snapshot captured when this
+ * accelerator was last activated (remote->active_accel_bits). Used to
+ * decide whether an accelerator must be (re)built to match the new member
+ * set. A NULL remote means the accelerator has never been activated (no
+ * snapshot yet), which also counts as "changed" so it gets brought up.
+ */
+static bool amdgpu_ualink_vpod_membership_changed(struct amdgpu_device *adev)
+{
+	struct amdgpu_ualink_remote *remote = to_remote(adev);
+
+	if (!remote)
+		return true;
+
+	return !bitmap_equal(remote->active_accel_bits,
+			     adev->ualink.info->vpod.active_accel_bits,
+			     AMDGPU_UALINK_ACCEL_MAX);
+}
+
 static inline u32 ualink_accel_id(struct amdgpu_device *adev)
 {
 	return adev->ualink.info->ppod.accel_id;
-- 
2.55.0

