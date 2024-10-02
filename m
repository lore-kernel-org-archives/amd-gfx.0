Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60313CF6D3B
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Oct 2024 17:02:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0898B10E768;
	Wed,  2 Oct 2024 17:02:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u2VnE94R";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 144A010E76C
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Oct 2024 17:02:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LyUHfzg96fzCYrrXJh5HW3taOQXlAnf8DgZIKeNRcqwYKx4btqzDTo5Fh84Sofjtbh4XngO1alcck0rSvlqlweAiTdDF619q3E3cccIhslcr9Nim2sAODiHGSLtrhrgPVrAUWsk1VjZNp/dYapbYPTZwaxLT3LOr/V2dpyadJw2U+qDIWEO0UJTZrxZ6KFt9pVMqFOCbR/R2x25bHVirjxvcuYdP6MP91tJScJbhECzvW5ohpTrbt2NyLORz873z2pljgJMHQGUW5t+dl91IdmcoMN/w0w6/a9/sak59CbAUsI1a74UrPXaeJhZJizRbqvDrKZ2+Mpii7Q1RpTlHUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GRYM22DvL9CebatbevD8Fh1uvHls4GDJ2LoGnFwC2lw=;
 b=u6kBgTv4yTXQhoePucI7mhgApGXRA9jsJmMjAtYlnNPGHf/TUzZezFJZklmVxiruA3obpdGBOd3lsr7L9AtOf1fZ1KqTFC/4CZyZvEXbQ7eG0TMbUqHa/uj7to3zQ6c+C2XxvFmzDSxxPDG27ETFa9OQMyBjm08Lrw7FtN1sW34KVEsrm/9VA5u4WLyiuxoIfqGwPtaYDXzEwUoxmhi1csvbTA2Z6NgRHDg88pyC2Tl7G7TJ0NoFLG+tGCCTljDlARbZ8/ZbH31hqdRfjyXIyyWS5GVn+td62wuDhBgkQKtShOvovN43VLNiJ7WHrLLkmvvdNd6M80AS8/GGY2H5Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GRYM22DvL9CebatbevD8Fh1uvHls4GDJ2LoGnFwC2lw=;
 b=u2VnE94RDZOjfBAHebcLC3tT3Mf3QCC8SB5aMqMnJp2Q1I8DK1Qho9pmWudwTmpkFZHU6CTTKQmaibAfnH3fVjRIrBtJnwaUDENoSBNPiIEvoWWpVfmGt866aNxd8CjNjEn6jOcTGjTleBE8c40LyLGkZBGbMxvuJV+tD3CxQ/8=
Received: from SJ0PR13CA0091.namprd13.prod.outlook.com (2603:10b6:a03:2c5::6)
 by LV2PR12MB5894.namprd12.prod.outlook.com (2603:10b6:408:174::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 17:02:14 +0000
Received: from SJ1PEPF00001CDE.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::d) by SJ0PR13CA0091.outlook.office365.com
 (2603:10b6:a03:2c5::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.9 via Frontend
 Transport; Wed, 2 Oct 2024 17:02:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDE.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Wed, 2 Oct 2024 17:02:14 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 2 Oct 2024 12:02:12 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v2 5/6] drm/amdgpu/gfx12: Implement cleaner shader support for
 GFX12 hardware
Date: Wed, 2 Oct 2024 22:32:02 +0530
Message-ID: <20241002170202.3179466-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241002043936.2960921-5-srinivasan.shanmugam@amd.com>
References: <20241002043936.2960921-5-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDE:EE_|LV2PR12MB5894:EE_
X-MS-Office365-Filtering-Correlation-Id: 9710b951-e89f-4f69-6877-08dce303f6d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d0hLTUdodGU4NUE3K0RoL3piRU52b2tmVVgwalZwbmlxQVdFYkZxcDM3MjFX?=
 =?utf-8?B?NzJmTmVBaXdyMGFadTVEZEpFVWZ6cllRbG1KUVBBaGxSMENaSFZBcVd1eVFR?=
 =?utf-8?B?WVROREx3aHNoNEd2RmhEcjVrS3hxUjV4WlZnSjBrdHRGaElnaC9rbmdYZlNX?=
 =?utf-8?B?VWdiRXZBN1JwVjgvU2tKZ0dZOGZlcUhRN1pSNlV5YzZaaWRxenFvZURteS82?=
 =?utf-8?B?ZmlrUkFsaDZXc25CNGt6TmpLMXpSN0Zvd3dCck1ZcXJIeExrNmFXVnlWUEpX?=
 =?utf-8?B?RUFFZzd0UERKR0pjb3AvenIvdnIvelpDOTJNQW1BRVdjLzhkWW1wbzl6cmpC?=
 =?utf-8?B?Y2J2SFpoMEtwdW1rczkrNUpQcy9qaGF3UHZRNlZKdVRSRzdXUmxPbzFSV3JL?=
 =?utf-8?B?Mlp4b05CTVlyR29XSVQrUHlzVGxsU1Vmanc4aStKa1BSaG1TcGdIbWMvN2VT?=
 =?utf-8?B?NEplTEIwR0ZrSUJ3ZEk1c0xwTEZKTmxXL0lQTjhnd2NCQzg2cjhza3JOVGla?=
 =?utf-8?B?WFl4NWNLWkExcXdUcytLUXF5TXVMTnM3K2FKOGFTL044WGNzM2R4Q2doNk1z?=
 =?utf-8?B?L2hCSHJxUXVTemwreHY0NjBQYldtUGtjL1JBTVFHd294ampRQ25YOUZaNCtM?=
 =?utf-8?B?anh1U29aMGtxVWE5emtWanlDRkdFczlxRzRMb3RnTlpBMGhPcUZ4ZG5JRHNi?=
 =?utf-8?B?aUtsVFQrUVdHYVpiNHlzVEJIVHVKZHFTTzVUUFJKWC9EOUhCRDVuSUJEdXMz?=
 =?utf-8?B?TUJnVlVsSHJIUGU4blJpdFBFMEZkejNyY0ZkRE5xUUNQS2hNeUhORUVZN3Nn?=
 =?utf-8?B?Tk93SHQ1WHlIOXhjTyt4dlpiTWhua29xaUNPT28wWld2WFl2UGUwUkQvWWlv?=
 =?utf-8?B?MmljRit3UTBBb3BzNWdKRjg5VG43N1JlMEhLWTRxL3lrN0JZZkt0eS9PUzRH?=
 =?utf-8?B?b1RRVzFPQUVyS2h3cTErMFhiK21UN01aTUY5a2FYdlEzdEJQbmRGZ3RmVkdN?=
 =?utf-8?B?eDRPUGtMUFZ1VDhERjRraktTcDQwWEQ0eVlhaWhDczlCbFFPMGJ1RVM2NlpI?=
 =?utf-8?B?SjZ5Wit3REJOSW1kZ1YvS0JBeHd3eHVPanpya2RRMkEzVmIrbC85ZmNNWE5o?=
 =?utf-8?B?dDA5ckZtMisyVk5qZmN5QzNLK3dTeHFpdzFqT0xNdG1hcS85dmJYaGszQlBn?=
 =?utf-8?B?dXIxdkQ1d1g0S2RRcENFcFhVUGw3bDMrcU9ON2hQekUyRnNsbjdCWTlDMXVX?=
 =?utf-8?B?WEhTazNSb2NERzhsRWk2L2dPUWJ0Uk1xSGNMeUM1UG9KTlJXV1RUdUZQZDdS?=
 =?utf-8?B?cE82M0JWejVtR2RVck1qS29TeTZxcXViWHo3cWI0YTd0dXV5ZkNGaHZlZjhu?=
 =?utf-8?B?L1B3ZG9OWlFkRVdDL09hMVdEWWxUYnlZZ29kUmVudzgxVWt1NE5VazhGYkxQ?=
 =?utf-8?B?RDdNWTVkV25uQXE0NnZmOEpnZVhQZTNWQjRUa3BLMWUvZit5SHQvQ29xaGRG?=
 =?utf-8?B?YWNxRzZqcEMvSUNxR25GbGF2YkMrYjJvcEhDRDNYM1J6SUN0NlE4M0ZmRVVo?=
 =?utf-8?B?N3NrNmhnbkhUYlNyN2FtMFdQUDBrV3dvcXczNURnV2V4TmVpVHhWZWZMWlVH?=
 =?utf-8?B?em5abnkvWGxZRldINFBhRlcrOXBzcW53MFZKR09LNWJqOG4rVG9OVi80bGFU?=
 =?utf-8?B?MnpodGZhYloyaWQwYWRtZkJodlJlclV2aFVRREtRcTBCWm5TeDJBYmp6RUhH?=
 =?utf-8?B?Y25uaThrTUUyazVyQ1ZUVmtxdDNreFFrVllhSG9FSHNUZGNITDZ1Q1Foejhv?=
 =?utf-8?Q?NDrC+bi4Mj59vu7RgrN5mt1RSl/yj2D/2PmPE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 17:02:14.3531 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9710b951-e89f-4f69-6877-08dce303f6d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5894
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
v2:
    Removed xcc mask, as it is calculated in amdgpu_discovery.c for
    devices which have an IP discovery table. (Alex)

 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 27 ++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 63e1a2803503..60d403038d6e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -1346,6 +1346,12 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
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
@@ -1460,6 +1466,10 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	gfx_v12_0_alloc_ip_dump(adev);
 
+	r = amdgpu_gfx_sysfs_isolation_shader_init(adev);
+	if (r)
+		return r;
+
 	return 0;
 }
 
@@ -1519,6 +1529,8 @@ static int gfx_v12_0_sw_fini(struct amdgpu_ip_block *ip_block)
 
 	gfx_v12_0_free_microcode(adev);
 
+	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
+
 	kfree(adev->gfx.ip_dump_core);
 	kfree(adev->gfx.ip_dump_compute_queues);
 	kfree(adev->gfx.ip_dump_gfx_queues);
@@ -5038,6 +5050,13 @@ static void gfx_v12_ring_insert_nop(struct amdgpu_ring *ring, uint32_t num_nop)
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
@@ -5297,7 +5316,8 @@ static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_gfx = {
 		3 + /* CNTX_CTRL */
 		5 + /* HDP_INVL */
 		8 + 8 + /* FENCE x2 */
-		8, /* gfx_v12_0_emit_mem_sync */
+		8 + /* gfx_v12_0_emit_mem_sync */
+		2, /* gfx_v12_0_ring_emit_cleaner_shader */
 	.emit_ib_size =	4, /* gfx_v12_0_ring_emit_ib_gfx */
 	.emit_ib = gfx_v12_0_ring_emit_ib_gfx,
 	.emit_fence = gfx_v12_0_ring_emit_fence,
@@ -5318,6 +5338,7 @@ static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_gfx = {
 	.soft_recovery = gfx_v12_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v12_0_emit_mem_sync,
 	.reset = gfx_v12_0_reset_kgq,
+	.emit_cleaner_shader = gfx_v12_0_ring_emit_cleaner_shader,
 };
 
 static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_compute = {
@@ -5336,7 +5357,8 @@ static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_compute = {
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
 		2 + /* gfx_v12_0_ring_emit_vm_flush */
 		8 + 8 + 8 + /* gfx_v12_0_ring_emit_fence x3 for user fence, vm fence */
-		8, /* gfx_v12_0_emit_mem_sync */
+		8 + /* gfx_v12_0_emit_mem_sync */
+		2, /* gfx_v12_0_ring_emit_cleaner_shader */
 	.emit_ib_size =	7, /* gfx_v12_0_ring_emit_ib_compute */
 	.emit_ib = gfx_v12_0_ring_emit_ib_compute,
 	.emit_fence = gfx_v12_0_ring_emit_fence,
@@ -5353,6 +5375,7 @@ static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_compute = {
 	.soft_recovery = gfx_v12_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v12_0_emit_mem_sync,
 	.reset = gfx_v12_0_reset_kcq,
+	.emit_cleaner_shader = gfx_v12_0_ring_emit_cleaner_shader,
 };
 
 static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_kiq = {
-- 
2.34.1

