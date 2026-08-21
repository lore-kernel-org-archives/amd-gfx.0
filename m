Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35B5AC5DF7D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 19:54:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C02BF10F4BD;
	Fri, 21 Aug 2026 19:54:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pM09Ax4e";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010033.outbound.protection.outlook.com [52.101.201.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A357A10F4BD
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:54:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GyQE6qm+3AhrbGBy54Oyheg9QBzpyF8Q7uF/7GDq2XAXT2TXJpPNHUwrVSCEkN3SoUwjlCzu7dfbs2w7RfAU+FaaCEEiCbFR/aymeJ1fgo1iIOWpqEf8KALnsfiAGJnYCbXQnRgcb5pdTmMizF+jFaVdgQ2zhrbjkB2mW15gW4Bu2QbhIJABrkbo23l981btjS/uDHv9zxi7NPQrZ/ePELZcOe0iwXC1jeS8UQ8Mei9yff3WeTHLi+7FauibT7LZdeMZByCERTPNOac46MM6tMthm3RCpSY+EyaM3NMvHUhAa84xQsKXCnXQV2dPnrbwvbY6sza4ddeDZGshZRhIvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C+VySEDEi0JIMx0IA6I/5n/zqbH+lhr7+YWsQtDII7E=;
 b=YsU8oOOGpQxmYaX3wHYpk8srmDFxSNRKy4jM/tVXLuugoapWdLLczKLeSh6taCfTuXp1dVdBf1ifVEWhWVC1eyl5vrEPPNnagqujg/wMSobqKlatL7zOmIwKZsRGwQG5xSBHH0p1Bmd/IsnZHmNiF57dm4XQg46FDetVVi8GyIfui/MmazfTUF5p43DfXsHNR0ZSrsEvAlLZmUNe9/A8c9Qz4z3Z8w1Z/J4rq7q1xtLO+Y4qKMbs46lZjIxN7W7+6z8AbmtAgmGCml8cWKLXqakg5zLLMy8h+Tp2n6QFnCnLTCIJ2TIvS2XLBDAXzdnWUhSkFYUuUhgsMXC4ehJR2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+VySEDEi0JIMx0IA6I/5n/zqbH+lhr7+YWsQtDII7E=;
 b=pM09Ax4eVSLx0BAIZo6IsrNYYEBvd873a1w4ojL17UAplOsQ3L9/PkIrYE3igRxakUovAiAFPQmf/UItxzgdPZsVWwZC/ObmVYfT1s9swX98IBkTLU7fh5/wdmHCHWob2JI8OeIFF3Dcpn2fPAAs6TcWt/SruNqsw+f4tutbM04=
Received: from CH5PR02CA0013.namprd02.prod.outlook.com (2603:10b6:610:1ed::27)
 by IA1PR12MB6260.namprd12.prod.outlook.com (2603:10b6:208:3e4::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 19:36:04 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:1ed:cafe::70) by CH5PR02CA0013.outlook.office365.com
 (2603:10b6:610:1ed::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:36:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:36:03 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:59 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:35:59 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Lijo Lazar <lijo.lazar@amd.com>, Felix Kuehling <felix.kuehling@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 79/95] drm/amdgpu: Drop duplicate vpod check functions
Date: Fri, 21 Aug 2026 15:34:42 -0400
Message-ID: <20260821193458.808626-80-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|IA1PR12MB6260:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a616feb-965c-490e-00d8-08deffbb703b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|23010399003|1800799024|36860700016|11063799006|56012099006|18002099003|10067099003|22082099003;
X-Microsoft-Antispam-Message-Info: bH4Js0HlpzlwnH7xoepAlqvppClSkfgFrLfJCQEYL4iun/6gTiYBk1XreaaU7BDhQLBwanZq68u8+3VNgN9XhFx4RnajQBMvI/RM1gFqjjcWEHRcXBOUDUrkYj+KPtjVGKfD4Or2TY90q+EXYf3tvoEasKp90+Vo0yEKWM3OhNtD/fsjSK603SnHI6IdBWQL2ep87eugChk3jCRdsKLoeSkIt+jpIEWawX2OdtnjgFtqYDnxDOgxCgXORrn1YHDUHO6iSWqk+yvxVCmWstRrO/Bo83rdzSh8jWz318cHqJVfXjc+eGzup4Yg3eQ8ZkUYbBFWM2LcNXh6m7e5kG7ksWBiCnm5Xv+SB8UgnEKJkCwt4hOL9OVYzGE0CMCoKGyv8CKKInns0Z1b1FCZOs2DBISjQhog3EFR2Tzd2ePnQzL7NkJXA5falCpUxubgM+c/u5Jj7+P7FvimDQd0uUK6YcOUy8I/4zrBmL+y4bl+NmV8FrdPEH/tyuR/PxI3kt03daliZFT5KAzy2wbldhAUQLrVpYCDXQqTTruTOlUxuQHD4XY9Nfni1IbRBTUPsT/rMd61Xlq7dxLIG0lbepR7yD2TQYnO+fMeBg8eOiL4e20t3XrWErl8OW94FFzie8qa+c1SVi3VwiGiD6NbdMEIyTx9GlSrYGk+AgV4kcuD5QAFeGdD5hJGpJGwZL79APuQI1k+1L6XiYPD+ov70kI6gQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(23010399003)(1800799024)(36860700016)(11063799006)(56012099006)(18002099003)(10067099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Lt7gsEhNBFrh04esg8l+tnyhe9y5dGkxqplop2jV8Vzv+0ZIC5tuHv4ueqKOpA4Eu/23v0yYXx2QW7wCTULk1N9H13lBDzLH1eKjhQzBArfyuANC+en7uTBczGwuCapGHnyzOnNBrBvjEJZ8K2fAGHoIeseNqC+QpCdcvnA0W68UrmuzpMOrMjn0ugAr//enPcSdIeCF8uc8ZzfA2Vc0j5pY9ROjYpvjrZPu4eTDT0LCR0o0TrE8OzffPgFYMO91iME4p5IpduNJKSKPkvEPmA7hTG5DBxKc8+a7OYwhQcrjTy4ku73W/kz6sHun2NOI/oOwidTlBPvgdHPBMoQWvKTI1hlN6TJw2h+0etOHoeQeOj3UObzxMk5Zj5+xVLPWpf/mAZkmCw6TPov1JBmlXBt1YG+LSZz+4ajNbxGjfBQu3qLHxqoYjtQEqmzXl56e
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:36:03.9496 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a616feb-965c-490e-00d8-08deffbb703b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6260
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 125 +--------------------
 1 file changed, 4 insertions(+), 121 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index a3758c55c0b73..4c923f907f275 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -691,16 +691,6 @@ UALINK_IDBITS_STORE(vpod_config, vpod_active_accels, vpod.active_accel_bits,
 		    AMDGPU_UALINK_ACCEL_MAX);
 UALINK_ENUM_STORE(vpod_config, addr_mode, vpod.addr_mode);
 
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
 static struct amdgpu_device *find_peer_adev(unsigned int accel_id)
 {
 	unsigned int i;
@@ -732,116 +722,6 @@ static bool amdgpu_ualink_is_local_accel(struct amdgpu_device *adev,
 	return false;
 }
 
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
-
 static void activate_accelerator(struct amdgpu_device *adev)
 {
 	int r;
@@ -1066,6 +946,8 @@ static ssize_t ualink_vpod_config_commit_store(struct kobject *kobj,
 	if (r)
 		return r;
 
+	if (!__check_vpod_info(adev, info))
+		return -EINVAL;
 	/* The integrity check makes sure each new GPU is consistent with the
 	 * other GPUs already in the vPod. All known local GPUs can become
 	 * "ready" at the same time.
@@ -1074,7 +956,8 @@ static ssize_t ualink_vpod_config_commit_store(struct kobject *kobj,
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

