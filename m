Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25647FA1FFF
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2026 21:51:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9742A10EA8B;
	Wed, 22 Apr 2026 21:51:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FNYqgJyp";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013069.outbound.protection.outlook.com
 [40.93.196.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73AED10EAA0
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 21:51:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g6iOCLE0mnj7uiE9zeWs6V20Tr7DHoGyOot8zfJ/QO3pRZwNZnmQcCnVuVXNbzCOyDX7vSOdhNr6Y0wbnsLKGoruECctbbH1FrjQIWo6A7XJ6rqf+HXqN8zJIezD0x/EB8m9gAt/W2yGpaO+zqz95gr98Ah+2RtpQrVr10sfljncSXZoRycoyL46N+pnQMxOJqX5lJLPggIYObh204oCNxfdsaTndetPEGZ19bIlQXIe6Vq2GL6W9lGJDS3ZW5isE92kwIIKwuvTfQdM1uIouTDFI32uiNFDrXOqUmab9+LGiSJpaafi01JsGXyT1LOfc4AIIcCpdV0pByvYMsh0MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m5sRFUSo6eZ8S80OqMd57wY2eQkcznr/Vpds5CyXssA=;
 b=eNraUqlnsVHOUwRy6qz6qdRE1dMr/jsREnJtrsiAa5XWS3R1titl+oy0qz/3Ubzcr142kH2drKR96xgXLjJNGxaRwxJlFE527SpYhvaBqZGTSE2NOlOko71Rn8sF3pFJ6K6bp/KRBT0cSepuxdM0jvQJdwMitBTLodxjLcAVBXpUBpTHALDgNt+26/vWWaSSooSi5VSV1na7YYrlR3E0FuKmH4rrHRkrKndb78rS5oslnnOmy34UQLHYkGn0bwLbQ+VuUCcHE9skUSSkMAFw0UKZ3XxW97hgQp0J79kKf3+ymGCsGznnu5ktzHVK8XlIMkG1Vv2v80fYskPCdEurMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m5sRFUSo6eZ8S80OqMd57wY2eQkcznr/Vpds5CyXssA=;
 b=FNYqgJypEhpj1ss6goTeO9m7CTv+vkbfbo1+AgEKhEf2OHPY74/NVdNcuW4XOYjkXDNZ0sr5yB5u8XqGMyYM2zCYPHlv2jzxes55d4L+GRRkTHAlPrvPzIW580D3j22hzOuwadSRaXO2+iU1fdNoy6WUVxHvn5WdP0N23grOO8w=
Received: from BN9PR03CA0215.namprd03.prod.outlook.com (2603:10b6:408:f8::10)
 by DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.17; Wed, 22 Apr
 2026 21:51:03 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:408:f8:cafe::ba) by BN9PR03CA0215.outlook.office365.com
 (2603:10b6:408:f8::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Wed,
 22 Apr 2026 21:51:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 22 Apr 2026 21:51:02 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Apr
 2026 16:51:02 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Apr
 2026 14:51:02 -0700
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 22 Apr 2026 16:51:02 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: In GFX12.1 CU is same as WGP
Date: Wed, 22 Apr 2026 17:50:34 -0400
Message-ID: <20260422215035.2242622-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422215035.2242622-1-alexander.deucher@amd.com>
References: <20260422215035.2242622-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|DM6PR12MB4123:EE_
X-MS-Office365-Filtering-Correlation-Id: a1cb6631-1133-4e9c-4a45-08dea0b93fa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 2yOMbRKbdzAAIQsXqbLLR/uSMNETwJnDvqkpUJh5nHBonRi8c9dFa0YhvoNc3b7xLGP2CjAZk8ZTJ5Tx/unFmKkRNn18izrvbC1rGc3BjxZv13glwtLq/wmZVQImvdQ7mXApmj5sv2Er6VVbN3gWfiCxZN7KrT14JozK93YIBP1nmUkG4ZyZ05w/ruDTzXAOiG4C5eIJ6xJKL0r7S2+Mg0iiTBpR0nAuoV2JjwPTqwLViHdKWNP0h/UbgOSyFutPaM22tY0YzJ07Z81qEFwqd/zHhB79S6Wozml2+RQ1Kk/MiToompzy6kTD952DjZRBiVlfSPvbsI5RZ1DmBpheMaXriltOEdBT+uVgv++5b4tjUjKbAL1llnqVhCYCiNsiaq56SiDr2YLFtTHhbTKVteOoj0nHWzdXRuDNnmS3Zx2g7Y4fo3eTSIqMsZxIN0xfG9vGOc1UFPpxRmZT8btAzQm84oUUTnBpgXQrqifBKLWQOYHHKvdCDz2gYP4p1D9+KdUdINonjlyYDai19eAqBHOoDCnZr5uFNMxsBgoQrLOvo7FDlzAbIIDembmiUPUnJZNfWtY8xgSOOAdftT1IJyPpCjI0tA0biSJT1efD821Rw5SoFFE/8F8MejRn8VwXbTDh2yzQ4jfrYYgsKKA5WLeRQkChhFyVdcm84xfN39ZSDcG1iBPl4qoR9jsRoc3mUoDv84aCZDUim7YrtqQKMC6t/Au4aTyhQ6prDaEeZBKJTw9txw9QV7y41noiw0aqu7H0ToeTvrlYuoHbR/ilNQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9VIwYDM5cVjHZp3GmcYK5OeLPlDs4lvvik627wLivLV9UwlwER3ams/1I/xJWdZYB4CklyaGPZDjUJ6Ar6POZP7YtnSCYoo+Rs7S7WjAWtI/AWQrm+PoD2AF/ITs7ZlE0bdg4vdZ8ihI/Iyf19j8OAm+/XfOohtDv3voIR5KECHvmwoW1nsSXCiZKvGHvN1dgQV9rEZCvWPFbrdkaV5mAQ8lTQL3lxbhVGTpXeaOg0We4qizB16FqBb9qXBdw/PXh+Ye2vR2FdPgmvryCG6mWkB+Mq1RQ7okuSby76cNnG306iqvjx+kEq3e7Rllk6NrZtx2rOT71wTK9GbqHS3dvIvyHC0NkFRagtRqczm8JbahB5wsoieB6HW2jY9wlNNyQ4XqKBluUarQpKM53V0ePzFPY2njrmCwdZOR1WDcBDSUf7da8OGZ7GiFaLpQFzRO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 21:51:02.9648 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1cb6631-1133-4e9c-4a45-08dea0b93fa2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4123
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

From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

Fix this for current ip discovery table.

v2: Move the change to gfx12 file
v3: Change only for the current version of ip discovery table
v4: Squash in build fixes

Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 25 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h |  2 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c        | 10 ++++++++
 3 files changed, 37 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 193091583847b..fef90a1d69441 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -3423,3 +3423,28 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	return 0;
 }
 
+int amdgpu_discovery_get_gc_major_minor_version(struct amdgpu_device *adev,
+						uint16_t *major, uint16_t *minor)
+{
+	uint8_t *discovery_bin = adev->discovery.bin;
+	struct table_info *info;
+	union gc_info *gc_info;
+	u16 offset;
+
+	if (!discovery_bin)
+		return -EINVAL;
+	if (amdgpu_discovery_get_table_info(adev, &info, GC))
+		return -EINVAL;
+
+	offset = le16_to_cpu(info->offset);
+	if (!offset)
+		return -EINVAL;
+
+	gc_info = (union gc_info *)(discovery_bin + offset);
+
+	if (major)
+		*major = le16_to_cpu(gc_info->v1.header.version_major);
+	if (minor)
+		*minor = le16_to_cpu(gc_info->v1.header.version_minor);
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
index 0ff1a7923eedf..e0010f6a3eda5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
@@ -48,6 +48,8 @@ int amdgpu_discovery_get_nps_info(struct amdgpu_device *adev,
 				  uint32_t *nps_type,
 				  struct amdgpu_gmc_memrange *ranges,
 				  int *range_cnt, bool refresh);
+int amdgpu_discovery_get_gc_major_minor_version(struct amdgpu_device *adev,
+						uint16_t *major, uint16_t *minor);
 
 void amdgpu_discovery_dump(struct amdgpu_device *adev, struct drm_printer *p);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index f4089ab108474..6872ce3f3ebbe 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -1142,6 +1142,7 @@ static int gfx_v12_1_rlc_backdoor_autoload_enable(struct amdgpu_device *adev)
 
 static int gfx_v12_1_sw_init(struct amdgpu_ip_block *ip_block)
 {
+	uint16_t major_ver, minor_ver;
 	int i, j, k, r, ring_id = 0;
 	unsigned num_compute_rings;
 	int xcc_id, num_xcc;
@@ -1152,6 +1153,15 @@ static int gfx_v12_1_sw_init(struct amdgpu_ip_block *ip_block)
 		adev->gfx.mec.num_mec = 1;
 		adev->gfx.mec.num_pipe_per_mec = 4;
 		adev->gfx.mec.num_queue_per_pipe = 8;
+
+		if (!amdgpu_discovery_get_gc_major_minor_version(
+			    adev, &major_ver, &minor_ver)) {
+			if (major_ver == 1 && minor_ver == 3) {
+				adev->gfx.config.max_cu_per_sh /= 2;
+				dev_dbg(adev->dev, "Halving max_cu_per_sh for GC Discovery table v1:3 %d\n",
+					adev->gfx.config.max_cu_per_sh);
+			}
+		}
 		break;
 	default:
 		adev->gfx.mec.num_mec = 2;
-- 
2.53.0

