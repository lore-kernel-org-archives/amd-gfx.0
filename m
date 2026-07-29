Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85E4DC53200
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2026 12:02:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CA3B10EBB9;
	Wed, 29 Jul 2026 12:02:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sE4ptkIa";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012025.outbound.protection.outlook.com
 [40.93.195.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0163210EBB9
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2026 12:02:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NesMfNZl59k8JnuqiVQRTgF2nlSlllIG2lzvVMXSwyTrQ6f1/i4tmbpg1W/G6Qje2mKOEQEOlfT6qGzHtgg22bIV1w7TjT1sHveF/sHODohJmIMVAazqKXNBhNvrivn/RPO8gEKu8c5uA0M8oXatDz7FDmJWqS8Jxay++jlKSVQHCkFCUMaJ6V0zExSov96Z5Czz+YrdVAqcfRfJ2fjmYf0A6rIiqSXsWH16udVjy01b5sx6hWb/E6lEivyBqgAqt8vAK1TT95j5K9b2auO3aMaAhfoSdlBIEl1GektVjkYvmOB6JOVaUD9Y+0OeV04Wg6IDSBv4d1/pZfuoRjD0xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WsP9BHtwGa8XcJnEtqYR/NT18wjW9QJ5eO1vlWIxfT4=;
 b=VswKD3OvCQs17dhL4Hng2QyhAD0tamrSWpp/sX0CkQaTgop4/RSGshEWkzBAapttQ4IBkOFZXl3wo4onbPSo3YV/0GE+QKonFuMiABFzUdkOp+oK3jdtKVez3rHEPKI5WKaKEwZ1hexVZJtQMtn7pDBa1+DT8SuoH296Vz42YjVQu/clStpzYsZ0Ut5xy+6OZaQ2LTH/BPgThbZqzcXeyl0L5LQ+EjWZGHfqgkWoACJJb82tUtSj75SXvk+A9m9gXVxSx5N0mj0o+RK3HBzfJZbrO2MKIG6ZoeUZJy4mk+FXFosHm8zvvHG18UdWjSigeEDLEfrp5XhPo0Se696IMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WsP9BHtwGa8XcJnEtqYR/NT18wjW9QJ5eO1vlWIxfT4=;
 b=sE4ptkIaYdjLMxlTHlHm8rx68ftP9AbDbJVuWPI78gARGtTqTVhb4ICqrZp74WNnh9VU9vW3eph/SFDjczOUHD5Ki+0rzP079PXAwuKwOmOFaukYK4IIqz9+mh6Diz5EQliTmKxApCL79x/jU/lLE/DrPSVKfSfzAhghmx/Ox3Q=
Received: from BN9P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::9)
 by MN2PR12MB4287.namprd12.prod.outlook.com (2603:10b6:208:1dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.13; Wed, 29 Jul
 2026 12:02:06 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:408:13e:cafe::60) by BN9P220CA0004.outlook.office365.com
 (2603:10b6:408:13e::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.12 via Frontend Transport; Wed,
 29 Jul 2026 12:02:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A1.mail.protection.outlook.com (10.167.243.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Wed, 29 Jul 2026 12:02:06 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 29 Jul
 2026 07:01:42 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <pierre-eric.pelloux-prayer@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Use virtual alloc during coredump
Date: Wed, 29 Jul 2026 17:31:17 +0530
Message-ID: <20260729120118.1659135-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|MN2PR12MB4287:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ab74737-7e4d-4370-ad35-08deed6935e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|6133799003|56012099006|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: pQaTGR528JmSKFqFF4MboHVCr7jAtUnGASA5+dfKg440KjGh2O84VkW2ENVYPi44Kvh5oulg8V4O/Pzrz0w7nfj5X0NPMfneVVd2QU21djgFMLTw3HCTEYcPbvs8jyCjfWJ59fsEfWdAMlai0tAV+D74798OV/Ya4nuQkV4sKCXB14387WWrrSvf15n1tY0E+T8LXtxHGM/CXSK5WyhRKbY3bzRy9Ki0inGKXIj7Jc+4p7otBuaKcMVUq+HAjXotfgSVmike9M/Mb0iV83rkLKddKVOjFbpv7TfO0pKM/q3EMFdzvJ+811VLYmmdsD8pvDdesJLWS+EM8TmBUKs00CRF3a5K8lcfCXaPmpHMD7sEJy9WBQf+sa2VH63MdkESJWh34t+fHWAf6yeK2gSdbvBhKJ3oIoYxHs/aNal1K99SjiZs3mhyebqPnRHw+1J7H/HgZuVxvOyIIHQlXEg1lA7FpKpnvuGvM9cPBwJvNSqsPu5X1WeKUBmd24Lw8wsFFEym3ppiqLJ4vDJ1cCMNJmRm3uUNtJvjpegwbVtjTXQdBdXRmgsyCmp7w475czyFjogmJEmWjpoo061bk0vEoRn9pY741ZlJjCoXbrWkk6I8J9q+ytIkP6lhUreVZ7exyxXRwrKqjM7vzSKy3JMjVfH+nb0BXrAmPjseOp8OAY7dXg7CB4JttQ0V3wQVTo/CFhLe0eI6Jwd53CJhSKh5Jg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(6133799003)(56012099006)(11063799006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iEk2NTXTuiTmma5PXWqyz+CMyiwOEGV9fY00N7tVhpl6WyrD41fSuuKh+eN0P6qx1s6GOIaZn/zZslBirVvWqQ6CuERQM9X+g2aYu71Vc0XNl54VWdEXqFRAVJWoivNiE6RD+2zh4n3wcAAvpFPVbt7CUTlfMQ6f60+rdTSPhFvixHtc/tJQFP1XEyWlKsgEACm3PfP+IqWFQB4ao0DIf8KgIfj+Ea0FmeYgierV1KWGqmhNOkQtOvMPDLnSPi8UfcPnnF6Kim4qqCtFLekzDqtL0SStFKoZWyHQKQnCl9VXbpkhgmDOkSAImfd1RwOYloLrYPXCJEKbdnMUco0erBckKXj80G6SVgg1GuGb47L7V+/0MPhsSlPktBC8eYOmexYzIHVrJppH26z6YEOo49hZJ3J0QrADpd7Tn57p+oNgdup1I0WVdXz8e9d3gp6u
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 12:02:06.2310 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ab74737-7e4d-4370-ad35-08deed6935e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4287
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

The number of rings with outstanding fences can be large, requiring a
bigger allocation. Such allocations don't need to be physically
contiguous, so use kvzalloc/kvcalloc which fall back to vmalloc when
contiguous memory isn't available. This also matches the existing
kvfree used to free these allocations.

Also guard the allocation with ring_count to avoid passing 0 size to
allocation routines.

Fixes: eea85914d15b ("drm/amdgpu: save ring content before resetting the device")

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
index 39b2a4c0e011..4dfea36997d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
@@ -554,7 +554,7 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool skip_vram_check,
 	if (job && job->pasid)
 		size += sizeof(struct amdgpu_coredump_ib_info) * job->num_ibs;
 
-	coredump = kzalloc(size, GFP_NOWAIT);
+	coredump = kvzalloc(size, GFP_NOWAIT);
 	if (!coredump)
 		return;
 
@@ -597,8 +597,12 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool skip_vram_check,
 		total_ring_size += ring->ring_size;
 		ring_count++;
 	}
-	coredump->rings_dw = kzalloc(total_ring_size, GFP_NOWAIT);
-	coredump->rings = kcalloc(ring_count, sizeof(struct amdgpu_coredump_ring), GFP_NOWAIT);
+	if (ring_count) {
+		coredump->rings_dw = kvzalloc(total_ring_size, GFP_NOWAIT);
+		coredump->rings = kvcalloc(ring_count,
+					   sizeof(struct amdgpu_coredump_ring),
+					   GFP_NOWAIT);
+	}
 	if (coredump->rings && coredump->rings_dw) {
 		for (i = 0, off = 0, idx = 0; i < adev->num_rings && idx < ring_count; i++) {
 			ring = adev->rings[i];
-- 
2.49.0

