Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F7DACF6D3E
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Oct 2024 17:02:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD74610E765;
	Wed,  2 Oct 2024 17:02:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u5gfhA+u";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 703F210E765
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Oct 2024 17:02:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LuYFc/0OfJTEWHFjo+bRnFhZVPRZLT0aiHgxm8rY5+9CSOuN/41JG3PmN8NgnBbh1lDtaeKPBFsMZ9pcfZL0xeqdVke1rp7wnUCEXexh0aDC0SBsxeebNCrMTpl0EYb2TD9zvpQumATZzeO2oCvKIKum82Z8tLiyfTAeTXzlV8I+l0lKazlkRszsYJV7IzvxxMXxFrbgIfyAH7Km+OLNUk9j68zDL7IfySX27Ll1x27Y3OnVl6LU5P5pBg6I5bb5fsn5x5DusGTOiiMD7CBZQW/Zdoo10ZDpMPxSjSCOtRMsL7QaEl/ulNwlcTudZUCtRRu+gyc5/ukx54wTcfCRgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6rmLKV2yTMfdo9XoxRO4gW/vxO/IfyCXYL8t1H5qc1o=;
 b=dkoHsWk9M6lLPeZRGEGs5JVpmkV3c5lHiYIYFiWL+J/J9GUDeDPsXyBLPNOxdR9ovcB0oVd/+4+fHsSrpdG0h/8Qwydo82IpY2XO3dMQsSHZfjgDf4h3fL4B1yUODTXF0EpeYvXcZR+z6Yc9mS8TwKdmTwdyAzID2T0vf0PG0t5HBuEVMji+9MveXppYouJrnge/78ldJomPuL8N/wtVT/TgoMPQoQg0CrCrvVcAI6IAZ+/2w8/4zJ3ijrix3ETlY9+7IEQxx1xXeY2uFalwcknn0Pd03Gex/YdSovSR7obciVTKcTEb+dh421lAdHGAx4n2PXP0jxc9+7mBgPaT7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rmLKV2yTMfdo9XoxRO4gW/vxO/IfyCXYL8t1H5qc1o=;
 b=u5gfhA+uR03+wLM8qiX5vbh9NcaFXn5VRW3Fz01VBRopwk+oD1UP40SsOCy9mj2TeWy69yXVqZzxBG7c83kNdqIX61U1U8ILQQKIiD6HZPaqhZyNiuxN1Epapags3xl98IAqcLDENmfeDsLyZx3sQ/WscwQorf0lAjJw67L0tdo=
Received: from MW4PR03CA0086.namprd03.prod.outlook.com (2603:10b6:303:b6::31)
 by DM4PR12MB7648.namprd12.prod.outlook.com (2603:10b6:8:104::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Wed, 2 Oct
 2024 17:01:54 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:303:b6:cafe::88) by MW4PR03CA0086.outlook.office365.com
 (2603:10b6:303:b6::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16 via Frontend
 Transport; Wed, 2 Oct 2024 17:01:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Wed, 2 Oct 2024 17:01:54 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 2 Oct 2024 12:01:52 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v2 3/6] drm/amdgpu/gfx11: Implement cleaner shader support for
 GFX11 hardware
Date: Wed, 2 Oct 2024 22:31:43 +0530
Message-ID: <20241002170143.3179374-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241002043936.2960921-3-srinivasan.shanmugam@amd.com>
References: <20241002043936.2960921-3-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|DM4PR12MB7648:EE_
X-MS-Office365-Filtering-Correlation-Id: b0de8825-36ce-43b2-819c-08dce303eabc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R2RtZEJ6MGJqTzN4UWI1d1doOEdWYldWdWtOdWFFajNWeXRUQkwxa1RYQjBw?=
 =?utf-8?B?Z2MwY2hVVm16bWhTN3pPeVFnRVB0TlB5TlFnMlAwTkMrMStvSWx3S0UzQmhm?=
 =?utf-8?B?Mm9sNU9CYXhWZElLY0dEN05MeXdUeDMvMDJpeVk3a0ZNMWNsTXQvNGFMVUdL?=
 =?utf-8?B?b3plUjNzQ0VteE1oZkpWaWJ2bWpVdU5ZZStGTHlmRnZTNzYwb0VCaCttVlhI?=
 =?utf-8?B?UmgxeU4rd2ZXNTRxT2M3SkthQ3ZIOW5oNDBUd0NObk10Y3dOVDlaUmc3dzVV?=
 =?utf-8?B?cGNTRUhsVTVWTzdQTFhPaW5wYVBOaFM0VkJka044eEY0SW5meFhITmRDeVVW?=
 =?utf-8?B?b3g0YkhTUmFkZVVBM1FxK0dZSkNpZE5yVk00Unl6TlpyWTNmcWVkQmJXSW1J?=
 =?utf-8?B?TFltRjNHaFh0dGVSSFUwcTJuQTdQUC9VTFBGTnJpK2gwbDNmTHQwUU9qL1Va?=
 =?utf-8?B?WEkxbVlKTnVtYmF3dC9ZcEZ2S2o1MTVuRmVLd291N2xWb09KcnNTS05ZdXM4?=
 =?utf-8?B?K0J1NkhjRFA4ZGc4MnBqbUY0Mnlpek9zS1Rvb0V1NUlRR1l3dzlXVUNIb0tR?=
 =?utf-8?B?NHJ4SXdMVS9xQkpDNklwcmF5bEQ3cmxKbWJ3ZWNDKzUxL2hVKzJaL3gzVDhW?=
 =?utf-8?B?dVRDakNISHZLRnNaZE9udlpiaDhqbWF1SXlqSTVlRCs5NEhXZHhmMzkwZnZo?=
 =?utf-8?B?K0pFNy9Yd3pYeEtUY2VTcVFJWXlJQkNmQ1BLdnlxeVBoTll1TG50U2RidzI2?=
 =?utf-8?B?aUFCYUswQXhabWpjaW9GZlJ2MnhyMURoc3lLcnlWUGFJZnlxZ3BkRHJqeDA5?=
 =?utf-8?B?SjJEL0RIRXJCMDFGWG1zSHF0eXZDZEh3OExSNmNPOG9HZzhZNjNzcUlxR0lZ?=
 =?utf-8?B?WFNmUktna3VIL0YrVHp3aEpUOUtTUmY0WUloZWp6T1NIK3p1K3llM1NKcHFW?=
 =?utf-8?B?aVBUck5mTXBiWno1R2F6WlQvSUMzTnZub2t3VG1hd3VwNlJPeXBjSGhSeEo3?=
 =?utf-8?B?V0svbTcyc1V0YURHS1VmS1YzR01JVlN6TE1DYlUxZU5oSUVMSml6QkNQRUZs?=
 =?utf-8?B?L25QRlp0Sml4QkNrK3k0M1JOSHNYblJ2eTAzdThVd0sxcURXODR0SzdJbERB?=
 =?utf-8?B?clE1R2MybFdDaE9rZGozZkVqcjdqZFZjcjlzZGpvdDV5aTFLVG1uYjA2b3Bp?=
 =?utf-8?B?N3IydWxWSElOb0RJd3VtRnpMV1pKa216OWhxUEZXWFdvdVIwN3VNNDg5bG1P?=
 =?utf-8?B?OFFyMVE0US9Wb29KWGxlZGZ0cTVqbW1oU2hPamdkV1JodXJUbVhWTnE3eXFo?=
 =?utf-8?B?L2NZemNPeTJqeUcrWWRKeW5ReTROdFZyaXhieGRiNW9DWWdhdnF5dXVXR1NQ?=
 =?utf-8?B?OHJ3UUZ2M2EwV0ZpNmpiR2Z4b1ZKUVo3V29BWEZzQ3daUEo4OUNocGZ4Q2ZO?=
 =?utf-8?B?SXVHcnFSRjFqMkh5N09xK3IreEQxSGlxbm01YzdOL05JSUN2ZWlYZ2gwTnRU?=
 =?utf-8?B?aVlEVWo2MDVwMDk0andpQzA4VHhqYk96RnFub2tFVXVDbmZyTCtMS0U2aUU1?=
 =?utf-8?B?RVc5M0JwaStEL1B6Yk1xQTRjVFc3S2pJejFCYjVGQWJ5WU90ZXd6L1U4cXMy?=
 =?utf-8?B?SWZVNkozWWRHb1BEK1BaUWRpTEZhSm16djlDSlh4N1FweURhQUVUNlllS2Yy?=
 =?utf-8?B?eHlLQlptOUZoSEZkZlJGVTFDWG1uMXZRb0pjSjFHTHVsR05KZVJCK0FGRm9u?=
 =?utf-8?B?cUJQYUN0YXY5TUxYRDZvak0xQzF5eFZVczFBQWRYYVNBSXFUVVhCZ3g5MEFr?=
 =?utf-8?Q?DJwQVpR+372/hZUiLWZnvuT/D7XWAuc6BfXbA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 17:01:54.0834 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0de8825-36ce-43b2-819c-08dce303eabc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7648
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

The patch modifies the gfx_v11_0_kiq_set_resources function to write
the cleaner shader's memory controller address to the ring buffer. It
also adds a new function, gfx_v11_0_ring_emit_cleaner_shader, which
emits the PACKET3_RUN_CLEANER_SHADER packet to the ring buffer.

This patch adds support for the PACKET3_RUN_CLEANER_SHADER packet in the
gfx_v11_0 module. This packet is used to emit the cleaner shader, which
is used to clear GPU memory before it's reused, helping to prevent data
leakage between different processes.

Finally, the patch updates the ring function structures to include the
new gfx_v11_0_ring_emit_cleaner_shader function. This allows the
cleaner shader to be emitted as part of the ring's operations.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
v2:
    Removed xcc mask, as it is calculated in amdgpu_discovery.c for
    devices which have an IP discovery table. (Alex)

 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 39 +++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index a0f80cc993cf..9db7876c87ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -293,14 +293,20 @@ static void gfx_v11_0_update_perf_clk(struct amdgpu_device *adev,
 
 static void gfx11_kiq_set_resources(struct amdgpu_ring *kiq_ring, uint64_t queue_mask)
 {
+	struct amdgpu_device *adev = kiq_ring->adev;
+	u64 shader_mc_addr;
+
+	/* Cleaner shader MC address */
+	shader_mc_addr = adev->gfx.cleaner_shader_gpu_addr >> 8;
+
 	amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_SET_RESOURCES, 6));
 	amdgpu_ring_write(kiq_ring, PACKET3_SET_RESOURCES_VMID_MASK(0) |
 			  PACKET3_SET_RESOURCES_UNMAP_LATENTY(0xa) | /* unmap_latency: 0xa (~ 1s) */
 			  PACKET3_SET_RESOURCES_QUEUE_TYPE(0));	/* vmid_mask:0 queue_type:0 (KIQ) */
 	amdgpu_ring_write(kiq_ring, lower_32_bits(queue_mask));	/* queue mask lo */
 	amdgpu_ring_write(kiq_ring, upper_32_bits(queue_mask));	/* queue mask hi */
-	amdgpu_ring_write(kiq_ring, 0);	/* gws mask lo */
-	amdgpu_ring_write(kiq_ring, 0);	/* gws mask hi */
+	amdgpu_ring_write(kiq_ring, lower_32_bits(shader_mc_addr)); /* cleaner shader addr lo */
+	amdgpu_ring_write(kiq_ring, upper_32_bits(shader_mc_addr)); /* cleaner shader addr hi */
 	amdgpu_ring_write(kiq_ring, 0);	/* oac mask */
 	amdgpu_ring_write(kiq_ring, 0);	/* gds heap base:0, gds heap size:0 */
 }
@@ -1574,6 +1580,11 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 		adev->gfx.mec.num_queue_per_pipe = 8;
 		break;
 	}
+	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+	default:
+		adev->gfx.enable_cleaner_shader = false;
+	}
+
 
 	/* Enable CG flag in one VF mode for enabling RLC safe mode enter/exit */
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 0, 3) &&
@@ -1700,6 +1711,9 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	gfx_v11_0_alloc_ip_dump(adev);
 
+	r = amdgpu_gfx_sysfs_isolation_shader_init(adev);
+	if (r)
+		return r;
 	return 0;
 }
 
@@ -1749,6 +1763,8 @@ static int gfx_v11_0_sw_fini(struct amdgpu_ip_block *ip_block)
 		amdgpu_gfx_kiq_fini(adev, 0);
 	}
 
+	amdgpu_gfx_cleaner_shader_sw_fini(adev);
+
 	gfx_v11_0_pfp_fini(adev);
 	gfx_v11_0_me_fini(adev);
 	gfx_v11_0_rlc_fini(adev);
@@ -1758,6 +1774,7 @@ static int gfx_v11_0_sw_fini(struct amdgpu_ip_block *ip_block)
 		gfx_v11_0_rlc_autoload_buffer_fini(adev);
 
 	gfx_v11_0_free_microcode(adev);
+	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
 
 	kfree(adev->gfx.ip_dump_core);
 	kfree(adev->gfx.ip_dump_compute_queues);
@@ -4575,6 +4592,9 @@ static int gfx_v11_0_hw_init(void *handle)
 	int r;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	amdgpu_gfx_cleaner_shader_init(adev, adev->gfx.cleaner_shader_size,
+				       adev->gfx.cleaner_shader_ptr);
+
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_RLC_BACKDOOR_AUTO) {
 		if (adev->gfx.imu.funcs) {
 			/* RLC autoload sequence 1: Program rlc ram */
@@ -6772,6 +6792,13 @@ static void gfx_v11_ip_dump(struct amdgpu_ip_block *ip_block)
 	amdgpu_gfx_off_ctrl(adev, true);
 }
 
+static void gfx_v11_0_ring_emit_cleaner_shader(struct amdgpu_ring *ring)
+{
+	/* Emit the cleaner shader */
+	amdgpu_ring_write(ring, PACKET3(PACKET3_RUN_CLEANER_SHADER, 0));
+	amdgpu_ring_write(ring, 0);  /* RESERVED field, programmed to zero */
+}
+
 static const struct amd_ip_funcs gfx_v11_0_ip_funcs = {
 	.name = "gfx_v11_0",
 	.early_init = gfx_v11_0_early_init,
@@ -6821,7 +6848,8 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_gfx = {
 		5 + /* HDP_INVL */
 		22 + /* SET_Q_PREEMPTION_MODE */
 		8 + 8 + /* FENCE x2 */
-		8, /* gfx_v11_0_emit_mem_sync */
+		8 + /* gfx_v11_0_emit_mem_sync */
+		2, /* gfx_v11_0_ring_emit_cleaner_shader */
 	.emit_ib_size =	4, /* gfx_v11_0_ring_emit_ib_gfx */
 	.emit_ib = gfx_v11_0_ring_emit_ib_gfx,
 	.emit_fence = gfx_v11_0_ring_emit_fence,
@@ -6844,6 +6872,7 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_gfx = {
 	.soft_recovery = gfx_v11_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v11_0_emit_mem_sync,
 	.reset = gfx_v11_0_reset_kgq,
+	.emit_cleaner_shader = gfx_v11_0_ring_emit_cleaner_shader,
 };
 
 static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_compute = {
@@ -6864,7 +6893,8 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_compute = {
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
 		2 + /* gfx_v11_0_ring_emit_vm_flush */
 		8 + 8 + 8 + /* gfx_v11_0_ring_emit_fence x3 for user fence, vm fence */
-		8, /* gfx_v11_0_emit_mem_sync */
+		8 + /* gfx_v11_0_emit_mem_sync */
+		2, /* gfx_v11_0_ring_emit_cleaner_shader */
 	.emit_ib_size =	7, /* gfx_v11_0_ring_emit_ib_compute */
 	.emit_ib = gfx_v11_0_ring_emit_ib_compute,
 	.emit_fence = gfx_v11_0_ring_emit_fence,
@@ -6882,6 +6912,7 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_compute = {
 	.soft_recovery = gfx_v11_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v11_0_emit_mem_sync,
 	.reset = gfx_v11_0_reset_kcq,
+	.emit_cleaner_shader = gfx_v11_0_ring_emit_cleaner_shader,
 };
 
 static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_kiq = {
-- 
2.34.1

