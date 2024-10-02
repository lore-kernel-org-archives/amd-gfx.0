Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B20CF3195
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Oct 2024 04:41:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCCE810E68D;
	Wed,  2 Oct 2024 04:41:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k4Xs/ZYT";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 554D510E68D
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Oct 2024 04:41:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aeUfaKpEIqs+FYcylWaF4IKY+dyhOEZzh7tW04O2oVFufucMhSUwBIoRoKjPTyDT0VyiUKA/UvTmHWQcMDOMBzLj2Zt1LQvuMyQlp7YC8bZKkOR1pZs3WZmzkk3l5b1OHdNWVpExQaSKu+yZ+qSoqjM13VGHsZg6/q9zHzVOSxgcMf0hKasXLrXwT8U7ZHVewv2zUR8WVPiEhj80Z/AkCjYIYckPhvL9KMy8AK69ZpT1zFvIzLu0meE0RJoSSrJyp0yPdRB6Ex+dx4/yYSMOA6v371Q9KZCa25q8QX4q6oHuosa3ncdMU2eFClKOq2Yaywmsu9cbQ5kPLFKD5HdXQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Geffc6/GiW445C9lsI1JsdmYmfcqXsDWHjfwX+TQ1pQ=;
 b=XJ5U8fo900QQgx7RoLTg+dUuPNG7MAjTK9vJKsgcRnFr6Z9kXhNWstcwdeFGXU4GDStJAPzCtS0Me7KkzW0up6Ki6B739zZFP0TLHSBi/YnyN8WukKBIv7LGyZBAdAgqgpRHDAjDQDOnW4gawnmJYmjF8+WzG2TfjT+oiQ1GZw+z2wWL3hQJP8XuM9UdE1mTKdN8XJK5PshfTZFNrfs0a2nDi4KX02V5rgfkZrPe5fvm8n35P+JaTOtiEgTbq+g92GNZ0ks/jqMwQCsiXO3+pVcJnV922KwGB1VtbQifjb+YohV/kCATc8OBhMvkNP4QVITTeGh/U0/GlAp+Q+Reaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Geffc6/GiW445C9lsI1JsdmYmfcqXsDWHjfwX+TQ1pQ=;
 b=k4Xs/ZYTfUpBM4j/Ll6NW9ik89V62nQYiIokuZJgIHU2V4Vo55fjzvEgDezFm4Zv1PnYnfp6bR5PgOX5QospNjRPwwWzkBVdl5amwAmTCVX7ZvGT8ZWyy1oxjz5bZMyCkaaG53HDffQdKDRGxIQ1Qp23g3VcLBYBAXbf6mfyeoo=
Received: from SN7PR04CA0151.namprd04.prod.outlook.com (2603:10b6:806:125::6)
 by PH7PR12MB6562.namprd12.prod.outlook.com (2603:10b6:510:212::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Wed, 2 Oct
 2024 04:41:33 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:125:cafe::22) by SN7PR04CA0151.outlook.office365.com
 (2603:10b6:806:125::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16 via Frontend
 Transport; Wed, 2 Oct 2024 04:41:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Wed, 2 Oct 2024 04:41:10 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 1 Oct 2024 23:41:03 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH 5/6] drm/amdgpu/gfx12: Implement cleaner shader support for
 GFX12 hardware
Date: Wed, 2 Oct 2024 10:09:35 +0530
Message-ID: <20241002043936.2960921-5-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241002043936.2960921-1-srinivasan.shanmugam@amd.com>
References: <20241002043936.2960921-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|PH7PR12MB6562:EE_
X-MS-Office365-Filtering-Correlation-Id: e8df21ec-d4e3-4dfe-5eb5-08dce29c7d87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Rkg1UHRSYkV4WUVNQnVnSm94WmJGUEZYYWNDWUlWd0o5MWxnTHJWSlEyaW1q?=
 =?utf-8?B?WUgwT2xuMDNkT3kvKzJ3YlJqMXJ6S0Y3WElMcDFxZFZwMHBrWFdHSHVCc0lZ?=
 =?utf-8?B?OFZyOFlWOWNBVmtoUHl5UUR1S1BkdDI3ZHB2U0pwNkFmc25jVFl0SGNxZnpQ?=
 =?utf-8?B?YU03SHQ4cllSamxKd2pON3dwVGY3UGZGRnZWSWF0MEZIbWtiZWNnZ2xZazJ1?=
 =?utf-8?B?ZmFQTjRBdmVJd0VVbTQ0b3FIMkxMOUtJWmZ3VFd4YlZJY090ZGNHV3ZqVkFs?=
 =?utf-8?B?WHRZOVU0VVAwaG9uZXAzL2JNZ01kSGJjRWZWL1Y2SG9LbDlhYVhqNGN1cE1k?=
 =?utf-8?B?c3prNzZUTC9EQUFrVGNoV0swM0ozUTRSYWY2UURRRkxTZG9QUExmL0ZidS9G?=
 =?utf-8?B?VU1TcUNSanhaK3hlaVpGdE5uNURpUjlwd2VRc3pTOXRtMkNPNlU0TW5ZdmFl?=
 =?utf-8?B?WWxJM2QrWjJFU0VxenQ3b3pGZmRKUCtqZzJDZzVBaU1hbEgrQWlsMS9MUHRR?=
 =?utf-8?B?ZUZLZGlyQXVhdENWUmJJWXA3NzloMlJOby9iK3pqcFhtcDFHYURsYXBXZjFQ?=
 =?utf-8?B?UWJ3dmZzNnduVlRMSEZQMnNrOFJNeGZVTHVvNGt2SGZwWjBBQm1LVjZ5WG5h?=
 =?utf-8?B?NVRrS0NPYmovVkV0ZmJJSWhoekkwbHplRlNYMTBNbU14RnUyV3BEMnBqak5l?=
 =?utf-8?B?YjJSdWRXdHJnRkRvdWpHa1IvRE5kaGZWWlRyMFpCTCtKdm8wSVJ0TnFuKzhF?=
 =?utf-8?B?OFczQ2RlWWtBVkpmb1U3ajRYMDU0c2ZGM2pEOW1veW5NeThabk5vdExlNE1z?=
 =?utf-8?B?dDRrM0tNUTQ1ZVNHUG40aUl6RDZ0d0lqQkw0QytuUUN0R0NtcVN2MTJVK1p5?=
 =?utf-8?B?QjM5enVtenBwYVg2U2pZa2UyZG91QldOWmYwcTN6KzVTb0plbWlJQXRKUUNm?=
 =?utf-8?B?Tk1pYUhyZHptSU90WTdQSFVBSy9BcWNHcWIyTHVnRGNTK1ZlZndNV3Y5S084?=
 =?utf-8?B?UXpxTmR3WWx4Ly9DRDhsdGp2N0M0UUpROGNRSENuSFhYdjhxNU12bmVQaUx6?=
 =?utf-8?B?R1RiM2JMZHBNWTdlZ0JncFAzK1p3ZG1GdHJqNTExbkljU3V1dEF0bnU1czUr?=
 =?utf-8?B?U3ZmRWhnbmVKSmIyWENpTVZmNE1PalFBUSthbHNMdEIyQjUzZVRRNWtNbmFm?=
 =?utf-8?B?UXR5WGtsUWxvSy8vSmVnZjE2OEQ3d2ZpbndKWmt5UUZwSWp2cTdhV1JpSW5l?=
 =?utf-8?B?K1dDRGlPUWI0NTkreHpEQUtTL3BCMXQxZitobjJBbXg3cG9xZjY5eWNTblZj?=
 =?utf-8?B?TElBS3QyRG1MZ1NSbmkxZ013cFpDMldLdHpKNUd4Vm92bEl1UVVnVmNsa3F6?=
 =?utf-8?B?dXFqQm9wODcySEVnMVhzS2lXUS93YUJlRlJnaW11eWQ4MzhWVXNjR0w2b245?=
 =?utf-8?B?N1I3SmNoL2szL3ZucGFSVHdOQ1VnYTlETmZFNHY5LzNpK0RRTGoxQVBQMEdw?=
 =?utf-8?B?RTZGamNBTlBvbFdLU01SZDhaeEw3RkRmNlVlZ3pQYUdYazU1eDl4dmU2U0tM?=
 =?utf-8?B?cTV4OHBNc0NWbGNURkUwQnhRM1h4aTdBaWlzUzF2UWlseUc4cjYvd2h5SVRm?=
 =?utf-8?B?aG9IYnh3aklvekNFeWJJRHB4WGRXSzB2RHFZdlI1MDVvYUlFc3BjRHVzaFp3?=
 =?utf-8?B?c3RneVBRZFg4ZlZzY1dtSFY1Ty8vbHljcDNsbDJyVWhybncyOGlsK2JNbU5N?=
 =?utf-8?B?aGsydWI0aS9YNExaZmZuMytrV0JZOTRSaDdUNWplWUo4OGpuNU9KRjJFd2Nn?=
 =?utf-8?B?UEl4UHVTUFVpTkVVTHkvdlc2L1ZDM3AraU9yRm1GTEd3R1ZiekNMYUR2S0ti?=
 =?utf-8?B?VGE3VVBQaTF2SEdEa2hEL2V2RUtIeWZvNFVYM0x0KzVOOWdBY01rZHhWK3Iz?=
 =?utf-8?Q?YUteHm8nHNdtzM6e5e36byIkBVD2QjPK?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 04:41:10.0126 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8df21ec-d4e3-4dfe-5eb5-08dce29c7d87
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6562
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

This patch adds support for the PACKET3_RUN_CLEANER_SHADER packet in the
gfx_v12_0 module. This packet is used to emit the cleaner shader, which
is used to clear GPU memory before it's reused, helping to prevent data
leakage between different processes.

Finally, the patch updates the ring function structures to include the
new gfx_v12_0_ring_emit_cleaner_shader function. This allows the
cleaner shader to be emitted as part of the ring's operations.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 28 ++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 63e1a2803503..df4a30f8a205 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -886,6 +886,7 @@ static int gfx_v12_0_gpu_early_init(struct amdgpu_device *adev)
 		BUG();
 		break;
 	}
+	adev->gfx.xcc_mask = 1;
 
 	return 0;
 }
@@ -1346,6 +1347,12 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 		break;
 	}
 
+	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+	default:
+		adev->gfx.enable_cleaner_shader = false;
+		break;
+	}
+
 	/* recalculate compute rings to use based on hardware configuration */
 	num_compute_rings = (adev->gfx.mec.num_pipe_per_mec *
 			     adev->gfx.mec.num_queue_per_pipe) / 2;
@@ -1460,6 +1467,10 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	gfx_v12_0_alloc_ip_dump(adev);
 
+	r = amdgpu_gfx_sysfs_isolation_shader_init(adev);
+	if (r)
+		return r;
+
 	return 0;
 }
 
@@ -1519,6 +1530,8 @@ static int gfx_v12_0_sw_fini(struct amdgpu_ip_block *ip_block)
 
 	gfx_v12_0_free_microcode(adev);
 
+	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
+
 	kfree(adev->gfx.ip_dump_core);
 	kfree(adev->gfx.ip_dump_compute_queues);
 	kfree(adev->gfx.ip_dump_gfx_queues);
@@ -5038,6 +5051,13 @@ static void gfx_v12_ring_insert_nop(struct amdgpu_ring *ring, uint32_t num_nop)
 		amdgpu_ring_write(ring, ring->funcs->nop);
 }
 
+static void gfx_v12_0_ring_emit_cleaner_shader(struct amdgpu_ring *ring)
+{
+	/* Emit the cleaner shader */
+	amdgpu_ring_write(ring, PACKET3(PACKET3_RUN_CLEANER_SHADER, 0));
+	amdgpu_ring_write(ring, 0);  /* RESERVED field, programmed to zero */
+}
+
 static void gfx_v12_ip_print(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
 {
 	struct amdgpu_device *adev = ip_block->adev;
@@ -5297,7 +5317,8 @@ static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_gfx = {
 		3 + /* CNTX_CTRL */
 		5 + /* HDP_INVL */
 		8 + 8 + /* FENCE x2 */
-		8, /* gfx_v12_0_emit_mem_sync */
+		8 + /* gfx_v12_0_emit_mem_sync */
+		2, /* gfx_v12_0_ring_emit_cleaner_shader */
 	.emit_ib_size =	4, /* gfx_v12_0_ring_emit_ib_gfx */
 	.emit_ib = gfx_v12_0_ring_emit_ib_gfx,
 	.emit_fence = gfx_v12_0_ring_emit_fence,
@@ -5318,6 +5339,7 @@ static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_gfx = {
 	.soft_recovery = gfx_v12_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v12_0_emit_mem_sync,
 	.reset = gfx_v12_0_reset_kgq,
+	.emit_cleaner_shader = gfx_v12_0_ring_emit_cleaner_shader,
 };
 
 static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_compute = {
@@ -5336,7 +5358,8 @@ static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_compute = {
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
 		2 + /* gfx_v12_0_ring_emit_vm_flush */
 		8 + 8 + 8 + /* gfx_v12_0_ring_emit_fence x3 for user fence, vm fence */
-		8, /* gfx_v12_0_emit_mem_sync */
+		8 + /* gfx_v12_0_emit_mem_sync */
+		2, /* gfx_v12_0_ring_emit_cleaner_shader */
 	.emit_ib_size =	7, /* gfx_v12_0_ring_emit_ib_compute */
 	.emit_ib = gfx_v12_0_ring_emit_ib_compute,
 	.emit_fence = gfx_v12_0_ring_emit_fence,
@@ -5353,6 +5376,7 @@ static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_compute = {
 	.soft_recovery = gfx_v12_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v12_0_emit_mem_sync,
 	.reset = gfx_v12_0_reset_kcq,
+	.emit_cleaner_shader = gfx_v12_0_ring_emit_cleaner_shader,
 };
 
 static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_kiq = {
-- 
2.34.1

