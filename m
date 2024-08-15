Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D66EBC5320D
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Aug 2024 00:05:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1BD710E33E;
	Thu, 15 Aug 2024 00:05:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="om1yBHTI";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D91D610E326
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Aug 2024 00:05:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kO/zAVZ8XVeDrhEXsFlvpknDn8wtGMWLBrAqYYCa485k4IzYbpbEE+uUq49Cl5sglDwKmtlK/3rm5+6kzswT3JydDnT/nP/abvFSWWRXHHfAnBryN55m1gqG/LXmsI419xNKBE5O7IZgEYWjg1seeCfExo8V4/dM/qLaYebBQDjpB+bRWQtY7c8A4+rZArneaPkAekG00nVUTOhTfFkWpXhMIiQJemL0ThFR1P9TiuS+2w1KU6v4uMMeYtIn8pfIiZkHKpegdjkyxyiwgdyhBaq/u1+5DmO5AzmKFNcDRgkaJ2DMuC8nbD5lX/9SWBIdjOBHUW7PP5+LNi29JJKNWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aYltT96g3xeN5dam+45zg5TVxeOTHlhhnDckzEI5WZI=;
 b=pVRcQbScN2aR5LWsK/V4QxloFVZhmHyh5XbYNk4VEl2lAmdyAd1nBRN4UeLwRjCUId1QE2LrZpuPnKD7RNisS/hG2Ixh4YoAYLKJ8cXkEYRmycOktVnfcNaEbrot7WqR1mITc7utdlIG3C0MvCihF9l94ZCfjJm4U6Jl8PPamxnlP4SeBvz4om4gGD3hCk7F+eyb1alu7l8+0DDY879/8h/5sipVjBRLz/x7sr7ED6z3xAxIHlpcyQnO8WvIU4PYpZ1IevccgtcCyW/bn5fje8klOlnPmA0UJMOEaBEJxzBGxiadnN26rovERDwD48nLHDw/PTBOIgfHKdBJJOPb1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aYltT96g3xeN5dam+45zg5TVxeOTHlhhnDckzEI5WZI=;
 b=om1yBHTIYLhqX1cLbf7MrJ792rY4Yi7shlScKFADY+uOb5WdKCGK0ne5cdCBUSx1pC7LnTsPz+yikUGDsRzODn/0JxMjWloKuV630iyhPwLWeABwZpJDRoOBFRh9WBk2jfagUBGWV0KtF/gm6yNzd0Wth+EB2/Q6nUpN0ZNvtoE=
Received: from BN0PR04CA0063.namprd04.prod.outlook.com (2603:10b6:408:ea::8)
 by DM4PR12MB6567.namprd12.prod.outlook.com (2603:10b6:8:8e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Thu, 15 Aug
 2024 00:05:24 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:408:ea:cafe::cc) by BN0PR04CA0063.outlook.office365.com
 (2603:10b6:408:ea::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.24 via Frontend
 Transport; Thu, 15 Aug 2024 00:05:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Thu, 15 Aug 2024 00:05:24 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 Aug
 2024 19:05:23 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 10/17] drm/amdgpu/gfx9: Implement cleaner shader support for
 GFX9.4.3 hardware
Date: Wed, 14 Aug 2024 20:04:54 -0400
Message-ID: <20240815000501.1845226-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815000501.1845226-1-alexander.deucher@amd.com>
References: <20240815000501.1845226-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|DM4PR12MB6567:EE_
X-MS-Office365-Filtering-Correlation-Id: 902a78b9-5365-47f2-50ad-08dcbcbdf62d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QmlHbzJxN2NVbVZCbWZBangybE5CL3JOZW43Slg1OXFydlcxd0N5eWk1cUtF?=
 =?utf-8?B?Tm9pczZmeWhIcUIwckhYc3kyODdEQStldzhOMzFlZzdtK3hSZHg3RVVDS0lU?=
 =?utf-8?B?a2ZpL3NUUHhnNU9EMGdidDlxSTRjREpHb00wUUo1WUgxT0tYaE9jT2xsSHZn?=
 =?utf-8?B?dGYrVExOWVA2dzhHUGp3TXIwWFR1dk4wRWdNQWZpdGU0Qy9TMURwU05yNitT?=
 =?utf-8?B?ZzZ2REFhZDZXdHp6bkNoSUhGeUNidDhabEwvMllyNlZIdzV2T2ZLdnp1aVFY?=
 =?utf-8?B?a1labjI0VHlIV24wMUZYeUJCb3U2VWtGSVF0WWNOMWdKRWRvcUNMNUtXTU9I?=
 =?utf-8?B?c2kzL0t5VFhvK3IyN3NneE03cWlNUjc0NUhRTGE5dWl5TUJZRi9CSnBNODFw?=
 =?utf-8?B?ZDZiNE4zNHpiZmZLaFgvZ3VRS3ZaaTlkemdGK3hGKzFZMHZKM21lTjN3MHRv?=
 =?utf-8?B?bVdobXRleS83eEdGQkRSTE1aTHM0aVVoN25SZVZsUjVnSDhxM1V1TlJFaUR6?=
 =?utf-8?B?eGQ2YUtJUjZCQXhyTmErVlludFduaGNuYURwcFp2ZFd0a3lMSWk5L1VHZmRP?=
 =?utf-8?B?YTVsdjZDd1NFRTV5bnJHT3BtWWRKYVBwb1NPeGVEYmlBUzVVTS9qR2J0NFRl?=
 =?utf-8?B?UjZDVDBXdXkwN2hpMTE2UkZzVVlWRGt6ZHRLckVPT0VHUWR6NUpyaElsVzdP?=
 =?utf-8?B?MWk0RWNKRnMweUlrSlZiVnVaV095ZUV6YWVjODZNYnkwR3pCSFdMd1FNNWQx?=
 =?utf-8?B?TXh1dHpoTlpMS2EyaGdTWFNMbzc2NDlteUlPcTQ1eDlaVHdESXpaRUJFcnBO?=
 =?utf-8?B?ajdoZXNPd1ZqTmtnRWVZNGdIaVI3eDZoeDVUaXRuQnVBNmNSUUxFUGQ4VGFh?=
 =?utf-8?B?SHRlNWVIeHk5eTBGTVJMc3VvR2hCeSswa2hiSC9PVGZzSWU4TCtUa2VDRHVV?=
 =?utf-8?B?azhDZzhsR21hR09pRnloRFYrUVVvUHV4bTJzU3hNQ294TmlrNW82VjdoaitK?=
 =?utf-8?B?bmsxbWZjNEd3b1RvVlhqb3owNnBzYk4ySWZFWkFhUlN3V3ZySE9lNmJTS0Fr?=
 =?utf-8?B?VndrcUxqQ0tIL3c4NjgrNjhXMnpBeHJVcnk3NU9VY0ZJd2JVSEJQc2tNa29p?=
 =?utf-8?B?UWYwNVMrQ0VsdDZCVUIwSFFyLzlxVy8vb0RtMkpIWUFmWEJ0VjBaVWNkMUtU?=
 =?utf-8?B?em1NajloMXZ2NkI2emxGMTJSN1lPekZIRFROMmFJeVVXSEtWZ3dXVzRmUk80?=
 =?utf-8?B?SmY1UTg2L04zUkRKQWRmak9pRkFrd0d3SUpEZ2ducWVZOVpyeSsyMVpFdWlP?=
 =?utf-8?B?Vkd0YkQ4OXpQL1NnQjZSTVMwZngycHh2M2VLWUs1NkphYThRTlBUdU1Zamg2?=
 =?utf-8?B?bzA1TkxJZGdidGxEVGJsT2d3Y1Myc2pLSFkxeWp5VTUrVHVWd3gzOExuS012?=
 =?utf-8?B?Vk1EVkhKLzl5bG1GeG1uTnVoSDJHTkZwdFhOQTFlVzIvMnpBMHBmUmF1Q0tQ?=
 =?utf-8?B?QzhBbE5JWUs3RW42NUsrTmN0c1llZTVqeDVWdFBGNEx0bjlsUWFxZ3RCbnF2?=
 =?utf-8?B?d0VlTWQ1SWtVcXdEblZuSW81UTA1SlVmcGxtWmxWdGduZk5zY3pNTnVONlNm?=
 =?utf-8?B?eWM4UXp1WiszMXQ1WUZwSWptOG80ZjJQanhUcmdpSWdJandzbTdqNEIycTRp?=
 =?utf-8?B?eVpMaGhUOS8yWDl0WllFN2RkZi9HWmoyMDBmTUMzMlBLZ2VEeGgvVXlkMHhj?=
 =?utf-8?B?S0ZxNTBEbllMcitjTll5bU5EUUJLdjRjQW1nUkk5TXpGTVI2bFpiVzhiNVlh?=
 =?utf-8?B?VjhZTERhdUhCcHhkcmNkQTllSit5ZnZlSFNQUURVU3g0Q3dJVEJnSmdxM25O?=
 =?utf-8?B?Z1N0UEFLTUJ6b1dyTzNWVklZR003bG16M000emRDYlJzV2d4R3Rmak03WUJy?=
 =?utf-8?Q?Jr4Gi55I4bLct+tpHinkdQ/lRxvjHszp?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 00:05:24.4148 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 902a78b9-5365-47f2-50ad-08dcbcbdf62d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6567
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

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

The patch modifies the gfx_v9_4_3_kiq_set_resources function to write
the cleaner shader's memory controller address to the ring buffer. It
also adds a new function, gfx_v9_4_3_ring_emit_cleaner_shader, which
emits the PACKET3_RUN_CLEANER_SHADER packet to the ring buffer.

This patch adds support for the PACKET3_RUN_CLEANER_SHADER packet in the
gfx_v9_4_3 module. This packet is used to emit the cleaner shader, which
is used to clear GPU memory before it's reused, helping to prevent data
leakage between different processes.

Finally, the patch updates the ring function structures to include the
new gfx_v9_4_3_ring_emit_cleaner_shader function. This allows the
cleaner shader to be emitted as part of the ring's operations.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       | 57 +++++++++++++++++--
 .../amd/amdgpu/gfx_v9_4_3_cleaner_shader.h    | 26 +++++++++
 2 files changed, 78 insertions(+), 5 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3_cleaner_shader.h

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 619ff3ec2c86..28f4212a8db2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -37,6 +37,7 @@
 #include "gc/gc_9_4_3_sh_mask.h"
 
 #include "gfx_v9_4_3.h"
+#include "gfx_v9_4_3_cleaner_shader.h"
 #include "amdgpu_xcp.h"
 #include "amdgpu_aca.h"
 
@@ -169,6 +170,12 @@ static void gfx_v9_4_3_xcc_unset_safe_mode(struct amdgpu_device *adev, int xcc_i
 static void gfx_v9_4_3_kiq_set_resources(struct amdgpu_ring *kiq_ring,
 				uint64_t queue_mask)
 {
+	struct amdgpu_device *adev = kiq_ring->adev;
+	u64 shader_mc_addr;
+
+	/* Cleaner shader MC address */
+	shader_mc_addr = adev->gfx.cleaner_shader_gpu_addr >> 8;
+
 	amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_SET_RESOURCES, 6));
 	amdgpu_ring_write(kiq_ring,
 		PACKET3_SET_RESOURCES_VMID_MASK(0) |
@@ -178,8 +185,8 @@ static void gfx_v9_4_3_kiq_set_resources(struct amdgpu_ring *kiq_ring,
 			lower_32_bits(queue_mask));	/* queue mask lo */
 	amdgpu_ring_write(kiq_ring,
 			upper_32_bits(queue_mask));	/* queue mask hi */
-	amdgpu_ring_write(kiq_ring, 0);	/* gws mask lo */
-	amdgpu_ring_write(kiq_ring, 0);	/* gws mask hi */
+	amdgpu_ring_write(kiq_ring, lower_32_bits(shader_mc_addr)); /* cleaner shader addr lo */
+	amdgpu_ring_write(kiq_ring, upper_32_bits(shader_mc_addr)); /* cleaner shader addr hi */
 	amdgpu_ring_write(kiq_ring, 0);	/* oac mask */
 	amdgpu_ring_write(kiq_ring, 0);	/* gds heap base:0, gds heap size:0 */
 }
@@ -1047,6 +1054,24 @@ static int gfx_v9_4_3_sw_init(void *handle)
 	int i, j, k, r, ring_id, xcc_id, num_xcc;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+	case IP_VERSION(9, 4, 3):
+		adev->gfx.cleaner_shader_ptr = gfx_9_4_3_cleaner_shader_hex;
+		adev->gfx.cleaner_shader_size = sizeof(gfx_9_4_3_cleaner_shader_hex);
+		if (adev->gfx.mec_fw_version >= 153) {
+			adev->gfx.enable_cleaner_shader = true;
+			r = amdgpu_gfx_cleaner_shader_sw_init(adev, adev->gfx.cleaner_shader_size);
+			if (r) {
+				adev->gfx.enable_cleaner_shader = false;
+				dev_err(adev->dev, "Failed to initialize cleaner shader\n");
+			}
+		}
+		break;
+	default:
+		adev->gfx.enable_cleaner_shader = false;
+		break;
+	}
+
 	adev->gfx.mec.num_mec = 2;
 	adev->gfx.mec.num_pipe_per_mec = 4;
 	adev->gfx.mec.num_queue_per_pipe = 8;
@@ -1140,12 +1165,19 @@ static int gfx_v9_4_3_sw_init(void *handle)
 		return r;
 
 
-	if (!amdgpu_sriov_vf(adev))
+	if (!amdgpu_sriov_vf(adev)) {
 		r = amdgpu_gfx_sysfs_init(adev);
+		if (r)
+			return r;
+	}
 
 	gfx_v9_4_3_alloc_ip_dump(adev);
 
-	return r;
+	r = amdgpu_gfx_sysfs_isolation_shader_init(adev);
+	if (r)
+		return r;
+
+	return 0;
 }
 
 static int gfx_v9_4_3_sw_fini(void *handle)
@@ -1163,11 +1195,14 @@ static int gfx_v9_4_3_sw_fini(void *handle)
 		amdgpu_gfx_kiq_fini(adev, i);
 	}
 
+	amdgpu_gfx_cleaner_shader_sw_fini(adev);
+
 	gfx_v9_4_3_mec_fini(adev);
 	amdgpu_bo_unref(&adev->gfx.rlc.clear_state_obj);
 	gfx_v9_4_3_free_microcode(adev);
 	if (!amdgpu_sriov_vf(adev))
 		amdgpu_gfx_sysfs_fini(adev);
+	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
 
 	kfree(adev->gfx.ip_dump_core);
 	kfree(adev->gfx.ip_dump_compute_queues);
@@ -2308,6 +2343,9 @@ static int gfx_v9_4_3_hw_init(void *handle)
 	int r;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	amdgpu_gfx_cleaner_shader_init(adev, adev->gfx.cleaner_shader_size,
+				       adev->gfx.cleaner_shader_ptr);
+
 	if (!amdgpu_sriov_vf(adev))
 		gfx_v9_4_3_init_golden_registers(adev);
 
@@ -4565,6 +4603,13 @@ static void gfx_v9_4_3_ip_dump(void *handle)
 	amdgpu_gfx_off_ctrl(adev, true);
 }
 
+static void gfx_v9_4_3_ring_emit_cleaner_shader(struct amdgpu_ring *ring)
+{
+	/* Emit the cleaner shader */
+	amdgpu_ring_write(ring, PACKET3(PACKET3_RUN_CLEANER_SHADER, 0));
+	amdgpu_ring_write(ring, 0);  /* RESERVED field, programmed to zero */
+}
+
 static const struct amd_ip_funcs gfx_v9_4_3_ip_funcs = {
 	.name = "gfx_v9_4_3",
 	.early_init = gfx_v9_4_3_early_init,
@@ -4604,7 +4649,8 @@ static const struct amdgpu_ring_funcs gfx_v9_4_3_ring_funcs_compute = {
 		8 + 8 + 8 + /* gfx_v9_4_3_ring_emit_fence x3 for user fence, vm fence */
 		7 + /* gfx_v9_4_3_emit_mem_sync */
 		5 + /* gfx_v9_4_3_emit_wave_limit for updating regSPI_WCL_PIPE_PERCENT_GFX register */
-		15, /* for updating 3 regSPI_WCL_PIPE_PERCENT_CS registers */
+		15 + /* for updating 3 regSPI_WCL_PIPE_PERCENT_CS registers */
+		2, /* gfx_v9_4_3_ring_emit_cleaner_shader */
 	.emit_ib_size =	7, /* gfx_v9_4_3_ring_emit_ib_compute */
 	.emit_ib = gfx_v9_4_3_ring_emit_ib_compute,
 	.emit_fence = gfx_v9_4_3_ring_emit_fence,
@@ -4623,6 +4669,7 @@ static const struct amdgpu_ring_funcs gfx_v9_4_3_ring_funcs_compute = {
 	.emit_mem_sync = gfx_v9_4_3_emit_mem_sync,
 	.emit_wave_limit = gfx_v9_4_3_emit_wave_limit,
 	.reset = gfx_v9_4_3_reset_kcq,
+	.emit_cleaner_shader = gfx_v9_4_3_ring_emit_cleaner_shader,
 };
 
 static const struct amdgpu_ring_funcs gfx_v9_4_3_ring_funcs_kiq = {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3_cleaner_shader.h b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3_cleaner_shader.h
new file mode 100644
index 000000000000..042944ac75df
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3_cleaner_shader.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2024 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+/* Define the cleaner shader gfx_9_4_3 */
+static const u32 gfx_9_4_3_cleaner_shader_hex[] = {
+};
-- 
2.46.0

