Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87D7AC624DB
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:29:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0965110EA84;
	Mon, 31 Aug 2026 18:29:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fMksUzvP";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013057.outbound.protection.outlook.com
 [40.93.196.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF5E810EA67
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:29:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YX4E0eth/DpIUYUcrHmmedPplA/LXUqiMXs6UZYLr9JcjoBd/GujZwcsSrO61ueVtQqHpIO65wniM9BtuZNDb24W/4A5nqaHdstWP4ZNX9JHBJujmIXv8r8oSfNW7XRmArmrdlGjybNun5hRShS9vymiSJu4wA8x7O/Et3+L7AR9/9jyf7oiRCVJ8Vpt/5JLRkY7tW7L+2vVn0/opZ8LfIqFWbOBrwJ7q1fwx/kZTZ7wRRYd9utBXxQ4aoNUwARO9e2WZSeVCdaseA0nN4YTKW1YYV01EURX4TP103pyrOCU8uwJkljQ4Q/31H5FyiGQBGJPaJ6E6Zvq888cCjuHqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L3+CrJjiNE4RYCWa9mECmpp9lb69+wEvqJruy5wxFfw=;
 b=fRVybzFRWcEtfwVwRS/l4LQfg6SUquADxWn14t5xmaFZP9XhZjXLks8w8X9q24CGLt3yKWyvWDH73lSZ+sVJ3kJTrDNHRQOFbxrrlBRtQ8LmsqirN4fdPLoX8uWxa9gJXkUaLa2lJyc+zFeG8YUtuE8UhrxNG3S+GZAxOSwWLpI1HsyvjEh/sxDmOTmKDN70PRw8gwbV7URtSBxIsVBjrOc9LFlH31jMzlDYKwDomm1SbI/hnFUahfTKxyD0sJDFfrPD10hJNyaSn0O6/7WDrxJHmFUGof1tnNZmOrwMSJLPbH2j7JqP+P1tflrVOZXEWXpRBJwb4G9WorLc3n6OOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L3+CrJjiNE4RYCWa9mECmpp9lb69+wEvqJruy5wxFfw=;
 b=fMksUzvPsM6x+sv0zRfaJsZlT8IdLH/9ZIgA4n/Z7oQpe3+8cN8IeMggcZR68KqkBG6mg7RRr/05Fnm4eHBeC+BLZX1E2IZdSWFX0+QHdLbZe9zLAaa9NGNOUkRlOsNT8ObhVclWyTcaKxLcjAGWX4RkyBfMVlMPn2Pa279bX2M=
Received: from CH0PR04CA0103.namprd04.prod.outlook.com (2603:10b6:610:75::18)
 by CH1PPF2D39B31FF.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::60a) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:29:13 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::95) by CH0PR04CA0103.outlook.office365.com
 (2603:10b6:610:75::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:29:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:29:13 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:56 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:28:56 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Lijo Lazar <lijo.lazar@amd.com>, Felix Kuehling <felix.kuehling@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 79/95] drm/amdgpu: Drop duplicate vpod check functions
Date: Mon, 31 Aug 2026 14:27:38 -0400
Message-ID: <20260831182754.1089811-80-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|CH1PPF2D39B31FF:EE_
X-MS-Office365-Filtering-Correlation-Id: 27ce8f90-da62-4a89-5735-08df078dc20e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: nkPqMLxmhhCSyn/2T9l5SUCinJVLkG8HGO6puTk/vppy3g3wjesNt6GJOzoxIZGxXpWSlAGh4iQlL6k5bKfBs4Nlcl22xaGkMcpNw76788MvFwjupy5KEHKqxqyA12WSrvX3B3TKr5scahbEEYI0hpJrp9iUeC7n95qmkj3o0a2PFt9qmBQAaT3XzbRFB1QHcuDr0L0rIbqIWgdj2OTtVPs2fSs7L0fHZApgVjBqUEdst/yiNjR7swLj2ue/B8WEDgiLD2Bpn8zHRQ5NWWQrGlXshOKrQkIihb4xa9OQ+v0Y2bAHRHUB+vch9dZ20xgM6VrMp01QztLONau6YnWsJyOjl3DjoZfYC5GuPhHMtetP1JudQYH+UWOrRkDDzodG0j0P7v+tvP4wYz84fKGIUAiIkbZUil8YPSMea5oCNt9M0B1hfRdejLm+qmzVF+pPGCneqh5HxBUsrZO+Hi2OyaFCTIGGZTHwivvgt/DbWdaXj+HMIoAUu6as+XBx3+bekwgZUZ9Ue4/Q81eEcLkmil12qlh/6izl2vRdOpgPMTzAZRz5729z9kHkX7JIm6F2+/PoEk27N89nJeRTuiecF6CHECtk9NrN6tBGBF+ySUwiLrk2C4GXtIBx24+YA097ZEbrn6q1klG00eHURLqEtlYs+RKxX5AD5F+y9tvMqfyXcY1dp5BDe6V53mgHmw/SeXWfDWz9Y22GoSJcQUFCvg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nQTf0WF2rcR0ndFvi3Xf7sP6xb9o6t8UNcX7JhKMT63pTm5/uk1c7gbSkmcyOcXgpTalCR3ld+XyyczZfSsyVXQfVfURSkEjeSsv9YNTuYJgoyrmpyVf4Fbye6DbTGPdGkW5gpr0w9+Zl+/IlKcGaTdjWOKlMOc+GywgHUr6wZPCJ0zKhANbq7FmrUhWDu7yext1yZ2cvk9BfTBs/4yNdcFWqroTd6+4B1wYJ+MRF1LYWsbRPAHFNCZrw4NWoLth7wioOxr8hy2BHE1Zaohc7P6FpD7EYjwXs8czWcB+zLtfHlKofkU81t5G93as2U2XLMySSkKu3cMrFGHTacni535/2L6zGne2Hq0w6rdCHuPG7UXhckVwcYfZ6QZ2dfqsLFjfUbrooYGa0710whWLSu+0mT6dJ9T5TP37exGhoC1iN1qAu41x5XKpeZLjujSj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:29:13.6949 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27ce8f90-da62-4a89-5735-08df078dc20e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF2D39B31FF
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

From: Lijo Lazar <lijo.lazar@amd.com>

Use __check_local_vpod_integrity and __check_vpod_info for vpod
validation checks.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 127 +--------------------
 1 file changed, 4 insertions(+), 123 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 3cae3f49bb31f..5efee75faddb2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -736,128 +736,6 @@ static bool amdgpu_ualink_is_local_accel(struct amdgpu_device *adev,
 	return false;
 }
 
-#ifdef UALINK_ENABLE_DEPRECATED_CONFIG_SYSFS
-static bool check_vpod_info(struct amdgpu_device *adev,
-			    const struct amdgpu_ualink_info *info)
-{
-	if (info->accel_state < AMDGPU_UALINK_ACCEL_STATE_PPOD_CONFIGURED) {
-		dev_dbg(adev->dev, "pPod is not yet configured\n");
-		return false;
-	}
-	return __check_vpod_info(adev, info);
-}
-
-static bool check_local_vpod_integrity(struct amdgpu_device *adev)
-{
-	struct amdgpu_ualink_info *info = adev->ualink.info;
-	struct amdgpu_ualink_info *peer_info;
-	struct amdgpu_device *peer_adev;
-	unsigned int accel_id;
-	unsigned int i;
-
-	if (!check_vpod_info(adev, info))
-		return false;
-
-	/* Check that all local accelerators listed in vpod_active_accels have
-	 * matching pod IDs
-	 */
-	for_each_set_bit(accel_id, info->vpod.active_accel_bits, AMDGPU_UALINK_ACCEL_MAX) {
-
-		if (accel_id == info->ppod.accel_id)
-			continue;
-
-		peer_adev = find_peer_adev(accel_id);
-		if (!peer_adev)
-			continue;
-		peer_info = peer_adev->ualink.info;
-
-		if (peer_info->vpod.id != info->vpod.id) {
-			dev_dbg(adev->dev, "Peer %u vpod_id doesn't match: %u != %u",
-				accel_id, peer_info->vpod.id, info->vpod.id);
-			return false;
-		}
-		if (!uuid_equal(&peer_info->ppod.id, &info->ppod.id)) {
-			dev_dbg(adev->dev, "Peer %u ppod_id doesn't match: %pU != %pU",
-				accel_id, &peer_info->ppod.id, &info->ppod.id);
-			return false;
-		}
-	}
-
-	/* Derive local accels from pod IDs of GPUs in mgpu_info */
-	info->n_local_accels = 0;
-	for (i = 0; i < mgpu_info.num_gpu &&
-		    info->n_local_accels < AMDGPU_UALINK_LOCAL_ACCELS_MAX;
-	     i++) {
-		peer_adev = mgpu_info.gpu_ins[i].adev;
-		peer_info = peer_adev->ualink.info;
-
-		if (peer_adev == adev ||
-		    (peer_info && peer_info->vpod.id == info->vpod.id &&
-		     uuid_equal(&peer_info->ppod.id, &info->ppod.id)))
-			info->local_accels[info->n_local_accels++] =
-				peer_info->ppod.accel_id;
-	}
-
-	/* Then check consistency of the vpod information on all those GPUs */
-	for (i = 0; i < info->n_local_accels; i++) {
-		unsigned int j;
-
-		for (j = i + 1; j < info->n_local_accels; j++) {
-			if (info->local_accels[j] == accel_id) {
-				dev_dbg(adev->dev,
-					"Accelerator ID %u is not unique among local GPUs\n",
-					accel_id);
-				return false;
-			}
-		}
-
-		accel_id = info->local_accels[i];
-
-		/* Skip this GPU, we are looking for our peers */
-		if (accel_id == info->ppod.accel_id)
-			continue;
-
-		peer_adev = find_peer_adev(accel_id);
-		if (WARN_ON(!peer_adev || !peer_adev->ualink.info))
-			/* info->local_accels we just built is corrupted? */
-			return false;
-		peer_info = peer_adev->ualink.info;
-
-		/* Check peer vpod info and consistency */
-		if (!check_vpod_info(peer_adev, peer_info))
-			return false;
-
-		if (peer_info->ppod.size != info->ppod.size) {
-			dev_dbg(adev->dev, "Peer %u ppod_size doesn't match: %u != %u\n",
-				accel_id, peer_info->ppod.size, info->ppod.size);
-			return false;
-		}
-		if (peer_info->vpod.size != info->vpod.size) {
-			dev_dbg(adev->dev, "Peer %u vpod_size doesn't match: %u != %u\n",
-				accel_id, peer_info->vpod.size, info->vpod.size);
-			return false;
-		}
-		if (peer_info->vpod.addr_mode != info->vpod.addr_mode) {
-			dev_dbg(adev->dev, "Peer %u addr_mode doesn't match: %u != %u\n",
-				accel_id, peer_info->vpod.addr_mode, info->vpod.addr_mode);
-			return false;
-		}
-		if (!bitmap_equal(peer_info->vpod.active_accel_bits,
-				  info->vpod.active_accel_bits, AMDGPU_UALINK_ACCEL_MAX)) {
-			dev_dbg(adev->dev, "Peer %u vpod_active_accels don't match\n",
-				accel_id);
-			return false;
-		}
-
-		/* Update peer's local accelerator array */
-		peer_info->n_local_accels = info->n_local_accels;
-		memcpy(peer_info->local_accels, info->local_accels,
-		       sizeof(info->local_accels));
-	}
-	return true;
-}
-#endif
-
 static void activate_accelerator(struct amdgpu_device *adev)
 {
 	int r;
@@ -1096,6 +974,8 @@ static ssize_t ualink_vpod_config_commit_store(struct kobject *kobj,
 	if (r)
 		return r;
 
+	if (!__check_vpod_info(adev, info))
+		return -EINVAL;
 	/* The integrity check makes sure each new GPU is consistent with the
 	 * other GPUs already in the vPod. All known local GPUs can become
 	 * "ready" at the same time.
@@ -1104,7 +984,8 @@ static ssize_t ualink_vpod_config_commit_store(struct kobject *kobj,
 	 * already in the vPod.
 	 */
 	mutex_lock(&mgpu_info.mutex);
-	if (check_local_vpod_integrity(adev))
+	r = __check_local_vpod_integrity(adev);
+	if (!r)
 		activate_local_vpod(adev);
 	else if (info->accel_state >= AMDGPU_UALINK_ACCEL_STATE_PPOD_CONFIGURED)
 		deactivate_accelerator(adev);
-- 
2.55.0

