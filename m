Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAB86C5DF7D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 19:52:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B15C10F458;
	Fri, 21 Aug 2026 19:52:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J+C25X8G";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012020.outbound.protection.outlook.com
 [40.107.200.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 150A310F449
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:52:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WVLqKJQQrwGYixoY6Sd6f6WJ5X/6ariMn6EpEsGZw6ldLOroY/CHIdExE7OGQTwimaB3cHfqoW3wwpZkjYro2FTeCVIhUQUNRsY91VNTHCpVaC36B6zAJwLJR0xPo9ezt5krQgeBeo8MretiQi3toIcYK/3VJu+7OMbOjiU4hq1t3qDjq/EFJUGdtglxwpbOevJzCPPVbVGNmaUqPRwIj/hsG+54QUJZvoFbmHUoNy3Q2ubn7o4EDwY1aMeXObQzr2LbOXjDAk9qk/PjtWl5TlhVkSkW5y1y2AaK/qvVF4L8UmrRAxAY1KL9whd17rmfZsnqVzJ7KmLUBfXrvGn2KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y5vxdKh/qJGxAYF6QN8NDEBFuTQdRj76yEpRL2ImEm0=;
 b=JeuBtfJEhIvP65jsF6MnxyyIzIHsH1XYOlxD01kSjKYWKJ5oau3l8qxpOA4B/moSRYAiuvj6KO6fDlvfUZFO1CfoCMnH/0vncqxaX2sUoSWqINk4BaKMKzcF8uGIrQ5+d0Tiulx1JHmnCb4g8GrYgi0kELU6uD8UF6d1FPtt3Yd+SACSu8Aais+xv1TnnE2c5Fr1O6e4U6eTB+YEox3DaOLsl+fob5v8PWdI/6H+z2Tgj1mNwqBI0hAE0Bk77mPRbGGv/nHDmG8XH6a4QU8i5tMwct0wPMi5bramY3hX2AarKy/KuIKxK4mOX/MPdukFvzdAcNgiJ0vJc6gx+DOXbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y5vxdKh/qJGxAYF6QN8NDEBFuTQdRj76yEpRL2ImEm0=;
 b=J+C25X8G2wtCzyrcnwWju/meHhgeTs0uasSzIaHSUKeOrBukz1QDTkkDgCYCNJhhHTPHLTjzTADHbNsSZij/VDjFDB+fHlZQY5+LNH9UQp482Ie6oem2B22liRlhjrW2KF9kPoIEa0esx+iVLr0nGK1hKUNn6cqkq9i3CpCOcKU=
Received: from DS1PR02CA0023.namprd02.prod.outlook.com (2603:10b6:8:44a::19)
 by CY5PR12MB6345.namprd12.prod.outlook.com (2603:10b6:930:22::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 19:36:08 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:8:44a:cafe::a1) by DS1PR02CA0023.outlook.office365.com
 (2603:10b6:8:44a::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:36:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:36:06 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:36:03 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:36:02 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:36:02 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Philip Yang <philip.yang@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>
Subject: [PATCH 84/95] drm/amdgpu: Fix GART and SDMA entity leak on vPod
 reconfiguration
Date: Fri, 21 Aug 2026 15:34:47 -0400
Message-ID: <20260821193458.808626-85-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|CY5PR12MB6345:EE_
X-MS-Office365-Filtering-Correlation-Id: ead74484-5520-4bc6-ff78-08deffbb7181
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|11063799006|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 3HhAwCUpTcYfX22ZVnAtQD/q7o8Q4TTRt1W1jhZGCc6SZkFHh4iCW+3NcuFOM2wDdW8Zfgnne+L9NNXBXtaD+dYECkb3/IUOPyI+rgjNwApmnbT8L6WJdYq6XP3zuNySVHutNiBzFvYWBMlvBTFlGTFNGo1eaYYx7qafr3uqsx8MoOfyY2+jnxGqKlH0GbivGqcuVSb8pVHFKSZzjNx/Gkt8vb9h335PTUwRKzeaBmqBVsP3m8uffhi4jsqpLdUAalL9M3YDtLiWMJ6A/BDxNuvBvuCSTUbyr2GZ4/zzR/dimX1h/CuGMbcwRGxrTksIb0bqNvw5uRD1r+5EofIAwvz5dcZo+7RMRJJetoU1AJ2hvBkcfOxQBIgdIGBTljjjC8IVTA6hdmgJy+FYzRT6cLV6+Y9IcIrzxKxRjH2muCDSOKeWFqGhHLqQxT8KjyHwgNd0KG0v4Cb2xYivziQKmO1rhG8WkMtV67BQZa9SnYnF/2+2joZwqTlo/nMFjVEJYrid8QyLW1P3w46o3OW7YnKMKowOGnSgfnJWzPFU53eOnDf7xCoCJhIXw5b+rbnKncRE+rZIus86fiw5loNCl0lzfucbT+4izlXP8EBDxYdh7gKKalv6aohgoivvsvTUdlJEG0m8u4mpIjuYC+Axm/QpX2opv7INAmKR0Wh+7K1IITk46v4ij8fcL7Gp4+2FdNNlnu7KfzZsL9/yzNtGXQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0MNegBiRIIveQn61SlD7r2dUnxzSk6QdJmCm6EVxi+1VYddQ7PbdkeXrZK6wJWwUbKmge9WYz5omYzCrBPWrRsycvnqvxngKtewLl1GfxmkOep5WqY8BQY4H5qVSllHSPi2TEXiswq/IOfMDqgslqk1Wj5Jr8twzWbA4MfnBmeKmqYeiMREKf9SWuykFlcthhvAiX/rTHqWlSn3vMKzKteYMzOqnoBsSHF2O8oGdWMX8jdj/bS7q9mYI7TshMNTbDsARAYyox/nzt3ZSXmHL1R6rJzBA9ccgOuupgzz5Mfpobv/cYKb9qjwohrwuCdmtpRITWVQCfBJEs1tZYUwBTKNFTZ6Hml2Uf4mnGIHy6+m3PHeVC3bEDAFqIfgeu7VIlGWNDwfjyeY0xe4tLiRI4ZwVv/JJKc6juFAxi2C/TvJq99J6dwdoTrYcSkpWERKx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:36:06.0863 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ead74484-5520-4bc6-ff78-08deffbb7181
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6345
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

remote->active_accel_bits aliased info->vpod.active_accel_bits, which
psp_ual_query_info() refreshes on every commit. Teardown
(peer_remote_fini / gart unmap) then iterated the new set instead of the
one sw_init mapped, orphaning drm_mm nodes in the shared GTT manager.
Make active_accel_bits an owned snapshot copied at sw_init time. Drop the
now-redundant not-initialised guard in metadata_npa_unmapping(), since the
earlier remote->ring_bo NULL-check already covers that case.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Philip Yang <philip.yang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index a70327383f5a2..8486d7b3dbe66 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -3842,8 +3842,14 @@ struct amdgpu_ualink_remote {
 	/* address alias mode alloc npa address for shared wb */
 	struct drm_mm_node		rptr_mm_node;
 
-	/* active accelator id bitmap of the pod */
-	unsigned long			*active_accel_bits;
+	/*
+	 * Owned snapshot of the vPod's active accelerator bitmap, taken at
+	 * sw_init time. Must NOT alias info->vpod.active_accel_bits, which
+	 * psp_ual_query_info() refreshes on every commit: aliasing it would let
+	 * teardown unmap a different set than setup mapped, leaking drm_mm nodes
+	 * in the shared GTT manager.
+	 */
+	DECLARE_BITMAP(active_accel_bits, AMDGPU_UALINK_ACCEL_MAX);
 	u32				num_accel;
 
 	/* remote GPUs ring buffer, read, write pointer local copy and gart mapping */
@@ -4221,8 +4227,6 @@ static void amdgpu_ualink_metadata_npa_unmapping(struct amdgpu_device *adev)
 
 	if (!remote->ring_bo)
 		return;
-	if (!remote->active_accel_bits)
-		return;
 
 	rb_size = AMDGPU_UALINK_RB_SIZE;
 	rb_size_in_pages = rb_size >> AMDGPU_GPU_PAGE_SHIFT;
@@ -4641,7 +4645,9 @@ static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
 	u32 status, accel_id;
 	int r;
 
-	remote->active_accel_bits = adev->ualink.info->vpod.active_accel_bits;
+	bitmap_copy(remote->active_accel_bits,
+		    adev->ualink.info->vpod.active_accel_bits,
+		    AMDGPU_UALINK_ACCEL_MAX);
 	dev_dbg(adev->dev, "%d active accelerators config in vpod\n",
 		bitmap_weight(remote->active_accel_bits, AMDGPU_UALINK_ACCEL_MAX));
 
-- 
2.55.0

