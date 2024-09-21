Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62F1ECF9C68
	for <amd-gfx@archiver.kernel.org>; Sat, 21 Sep 2024 07:14:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E37D910E050;
	Sat, 21 Sep 2024 07:14:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bqq90sY3";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECBA810E050
 for <amd-gfx@lists.freedesktop.org>; Sat, 21 Sep 2024 07:14:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h5HbTQgfTm8bHACRad9tnukZ5tvIcI6p0G4wV39bZYfmCNgn9KzCkZYj8PumtRJhJWBxUyQ1JiG0wGrTLyJ29MaFIb77AT88BUH6XYhjtCP4Pn5nOWp3FvMFL3qUGlvGgji0cY2RjvpT8hbSLwrTOyROTCKG7tOYQioHtY68vInBIflMAD9eUNHavSHaTN2eaDGYOmWh7S50ReCDU910Wdk9gaohrJlnlyKPtk7TwzPYXAaBUyaKZu7XuvjaMNWqdsNAEXypF+7TplEdBXwHypmFJhjM6Biba/EUc/+sL19jdkArArLBnO97ZgjgMe728q5h76K0qGVzMAd7JhtjEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WMhnYgQIa+Va8CWPLIAIZQb4AkQV1aUxSEntg4DPl0c=;
 b=w6QSxHy41PBOf4uBuyl6tt8HxY5CmnXoCCO7eAj4ZEdaDBqP6JUnixXUiPhDJ51udiPBcjxwFExwfCIBuEwlrx//o9No1B2XCbsIVkrslioP5Zdwyz56hQU1wMU2aUwrXOzAegL+HhivPZzO3Cs/Bs+JI/1j6ogBbNUDPq41AgG0r+TyII3DhZj+G1Ppo3U1fydGktX6CcEma82HFhlFxM0LA6jivA+ehvGqKELQdsPR8iUkesXQMOp6Wub7JY4bKvj/n9l9tj4R2g7Lr6OooW8Cf4GFawBB1czTSxFr2Hx57bAdWAt2sgyRgZ1LZs+2s63WSXp6n9I9tZTZzBc8aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WMhnYgQIa+Va8CWPLIAIZQb4AkQV1aUxSEntg4DPl0c=;
 b=bqq90sY3H3bXqTJXb+h0xCD8lP9lXTXUbFKNUnZTEBqgW0mdDxTqMxRFk3QCnYr1yHmbD6GMJDkejadf0/bdYTnxjNkfS48x9IKCnNPIR7akDzctLNw7it0JOnywdM4fWYB9nrn2fKriWhxFgO+xR5VHgn5Hh9UpDiYCGdcC3JE=
Received: from SJ0PR03CA0035.namprd03.prod.outlook.com (2603:10b6:a03:33e::10)
 by MN0PR12MB5907.namprd12.prod.outlook.com (2603:10b6:208:37b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.23; Sat, 21 Sep
 2024 07:14:33 +0000
Received: from SJ1PEPF0000231D.namprd03.prod.outlook.com
 (2603:10b6:a03:33e:cafe::5e) by SJ0PR03CA0035.outlook.office365.com
 (2603:10b6:a03:33e::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.30 via Frontend
 Transport; Sat, 21 Sep 2024 07:14:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231D.mail.protection.outlook.com (10.167.242.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Sat, 21 Sep 2024 07:14:32 +0000
Received: from saleem-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 21 Sep
 2024 02:14:29 -0500
From: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
To: <saleemkhan.jamadar@amd.com>, <leo.liu@amd.com>, <srinath.rao@amd.com>,
 <veerabadhran.gopalakrishnan@amd.com>, <sathishkumar.sundararaju@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>
CC: <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu/vcn: enable AV1 on both instances
Date: Sat, 21 Sep 2024 12:44:12 +0530
Message-ID: <20240921071412.721113-1-saleemkhan.jamadar@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231D:EE_|MN0PR12MB5907:EE_
X-MS-Office365-Filtering-Correlation-Id: 62dc9ef8-be66-4f9d-67b7-08dcda0d0aaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?udT/LY98R7m+IVKeJ2QC0evCpIIzjwlcJyf3WhGsnNc65Q3WFoJCla3tpSE/?=
 =?us-ascii?Q?M545xvUgxR3CPIklzpF2ir6G3nFwI+VdVG/aeuOLoKUUtVjOkL1jclezNEeM?=
 =?us-ascii?Q?PeXY26jIfYWexGLxd5US9xJYD7dfZHRSrepsxvCnSVQnMwh4AF0l1CO7+/fQ?=
 =?us-ascii?Q?fgfKSuF3FbvpMh8VVBBQdHLFMAmcnMi2PogJBVtOMbJhbirXd3Bi+nONbZ/i?=
 =?us-ascii?Q?ZKUvlwdQQ5ItJ7RQfJKw1WRppnZm/ida17qCo5AnkgVhZcMd4GRqoC+QxIDb?=
 =?us-ascii?Q?136ExwEm3kkBePaA2goiHE1ypmZ0d9npJHqvJrOqD730ZwxsuMBRPhPA69Ku?=
 =?us-ascii?Q?Fq6qMkvOLv6r2foR69uY/W2QxtHtv32WP5KrYJu3PtIHHbJ0PHSBufe/pP60?=
 =?us-ascii?Q?fy5/3kLWhlrhv03Kf3Vg1GYiPOjFBYCe4C22Bc2AJYQjFW9AKEjI7vWoREvt?=
 =?us-ascii?Q?mG6v3N1xLrXSN3XTKKckTjVxWnWyEgRCgq3oFEiDzkA8GLaYsBpOsgc9KBxP?=
 =?us-ascii?Q?VtmoQIGhygUoy8bwcAPBo3qHEHycwP755uOYx01WPjHyNcfFMhC6t/BQwsVg?=
 =?us-ascii?Q?Vzj1ylqFHDOUU3OyWIQi7yH/3TdsjChEbiTBLcfMk5dsBjyqsI1heyaeabH/?=
 =?us-ascii?Q?MGHj7TK9mplBdco50RP7HMRxMXV+j+JE9dmmJJLI2t8GnOltTL2HyhNpvpej?=
 =?us-ascii?Q?racKi64xGOLwD2sSjkye6MrFtB4ssoe1taV7xQO6Mux1OClDiKaHjBE5Vg0a?=
 =?us-ascii?Q?qJ/kOpj6tAvuu49F1ACVxZKGDB7yDYvDC5Nhxqjh7xhx3R/EmCvVd/qZrTqV?=
 =?us-ascii?Q?dBK+1X45djmP8jj4oCT4qfW+E6cuXNBjbcVTDu08KV2IbH1g0hTX3MTU2cf5?=
 =?us-ascii?Q?vuMuziP/giINwu+URjpEqvlqK899B2o6xnTzUPF4R1pWkqluzEb80hNfvTsE?=
 =?us-ascii?Q?1w2Hhh0Wh0tbcfzWgqCABWgGmcxJfLTd92oEfww/pqh7nm813T4A1dDuDqUd?=
 =?us-ascii?Q?omkt4AGIXwwPKI+lihNsnxvebgxEAANHLyyn2Zbb0F/TIMghwjd0tIUMub1Q?=
 =?us-ascii?Q?d8l1EtjF7ax7eluftY3p1WDaPxU9IOTvNlAMzJL/yKnCIRaNDRloj7oljW6K?=
 =?us-ascii?Q?97UU0HMU/SE0mdcOck+LKKzGxP8m/ZGGSRuJGtiwGoZ4AXqe/zL317Dq9e0I?=
 =?us-ascii?Q?VYWWkIoroTRXBAUOC8qP6vJhSieh8GuTPpAlVe7I7M1q1RTWRfamH/+zse2F?=
 =?us-ascii?Q?CwR0kf6uw4yj+cneceilxDdmLTH9koGk3K6XxxfUsVePYKHzHi+YC+FjU9CG?=
 =?us-ascii?Q?SuUFXz/szV8kZ2CV0aQB5ZUlthVCwX8uJbYAIt3Cz2/BVgY0nZY7j0vksUbS?=
 =?us-ascii?Q?q18zGHwDbWedqjXz5p8bONO2VkdimMaK15Ovc7DtwYp9xhjJF3MFNfUTKt3+?=
 =?us-ascii?Q?9/4gQDSXN9/jR3FIe8nRKzKHFT16SXFe?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2024 07:14:32.7059 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62dc9ef8-be66-4f9d-67b7-08dcda0d0aaf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5907
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

v1 - remove cs parse code (Christian)

On VCN v4_0_6 AV1 is supported on both the instances.
Remove cs IB parse code since explict handling of AV1 schedule is
not required.

Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 165 ------------------------
 1 file changed, 165 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index b1fd226b7efb..9d4f5352a62c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -1395,170 +1395,6 @@ static void vcn_v4_0_5_unified_ring_set_wptr(struct amdgpu_ring *ring)
 	}
 }
 
-static int vcn_v4_0_5_limit_sched(struct amdgpu_cs_parser *p,
-				struct amdgpu_job *job)
-{
-	struct drm_gpu_scheduler **scheds;
-
-	/* The create msg must be in the first IB submitted */
-	if (atomic_read(&job->base.entity->fence_seq))
-		return -EINVAL;
-
-	/* if VCN0 is harvested, we can't support AV1 */
-	if (p->adev->vcn.harvest_config & AMDGPU_VCN_HARVEST_VCN0)
-		return -EINVAL;
-
-	scheds = p->adev->gpu_sched[AMDGPU_HW_IP_VCN_ENC]
-		[AMDGPU_RING_PRIO_0].sched;
-	drm_sched_entity_modify_sched(job->base.entity, scheds, 1);
-	return 0;
-}
-
-static int vcn_v4_0_5_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
-			    uint64_t addr)
-{
-	struct ttm_operation_ctx ctx = { false, false };
-	struct amdgpu_bo_va_mapping *map;
-	uint32_t *msg, num_buffers;
-	struct amdgpu_bo *bo;
-	uint64_t start, end;
-	unsigned int i;
-	void *ptr;
-	int r;
-
-	addr &= AMDGPU_GMC_HOLE_MASK;
-	r = amdgpu_cs_find_mapping(p, addr, &bo, &map);
-	if (r) {
-		DRM_ERROR("Can't find BO for addr 0x%08llx\n", addr);
-		return r;
-	}
-
-	start = map->start * AMDGPU_GPU_PAGE_SIZE;
-	end = (map->last + 1) * AMDGPU_GPU_PAGE_SIZE;
-	if (addr & 0x7) {
-		DRM_ERROR("VCN messages must be 8 byte aligned!\n");
-		return -EINVAL;
-	}
-
-	bo->flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
-	amdgpu_bo_placement_from_domain(bo, bo->allowed_domains);
-	r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
-	if (r) {
-		DRM_ERROR("Failed validating the VCN message BO (%d)!\n", r);
-		return r;
-	}
-
-	r = amdgpu_bo_kmap(bo, &ptr);
-	if (r) {
-		DRM_ERROR("Failed mapping the VCN message (%d)!\n", r);
-		return r;
-	}
-
-	msg = ptr + addr - start;
-
-	/* Check length */
-	if (msg[1] > end - addr) {
-		r = -EINVAL;
-		goto out;
-	}
-
-	if (msg[3] != RDECODE_MSG_CREATE)
-		goto out;
-
-	num_buffers = msg[2];
-	for (i = 0, msg = &msg[6]; i < num_buffers; ++i, msg += 4) {
-		uint32_t offset, size, *create;
-
-		if (msg[0] != RDECODE_MESSAGE_CREATE)
-			continue;
-
-		offset = msg[1];
-		size = msg[2];
-
-		if (offset + size > end) {
-			r = -EINVAL;
-			goto out;
-		}
-
-		create = ptr + addr + offset - start;
-
-		/* H264, HEVC and VP9 can run on any instance */
-		if (create[0] == 0x7 || create[0] == 0x10 || create[0] == 0x11)
-			continue;
-
-		r = vcn_v4_0_5_limit_sched(p, job);
-		if (r)
-			goto out;
-	}
-
-out:
-	amdgpu_bo_kunmap(bo);
-	return r;
-}
-
-#define RADEON_VCN_ENGINE_TYPE_ENCODE			(0x00000002)
-#define RADEON_VCN_ENGINE_TYPE_DECODE			(0x00000003)
-
-#define RADEON_VCN_ENGINE_INFO				(0x30000001)
-#define RADEON_VCN_ENGINE_INFO_MAX_OFFSET		16
-
-#define RENCODE_ENCODE_STANDARD_AV1			2
-#define RENCODE_IB_PARAM_SESSION_INIT			0x00000003
-#define RENCODE_IB_PARAM_SESSION_INIT_MAX_OFFSET	64
-
-/* return the offset in ib if id is found, -1 otherwise
- * to speed up the searching we only search upto max_offset
- */
-static int vcn_v4_0_5_enc_find_ib_param(struct amdgpu_ib *ib, uint32_t id, int max_offset)
-{
-	int i;
-
-	for (i = 0; i < ib->length_dw && i < max_offset && ib->ptr[i] >= 8; i += ib->ptr[i]/4) {
-		if (ib->ptr[i + 1] == id)
-			return i;
-	}
-	return -1;
-}
-
-static int vcn_v4_0_5_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
-					   struct amdgpu_job *job,
-					   struct amdgpu_ib *ib)
-{
-	struct amdgpu_ring *ring = amdgpu_job_ring(job);
-	struct amdgpu_vcn_decode_buffer *decode_buffer;
-	uint64_t addr;
-	uint32_t val;
-	int idx;
-
-	/* The first instance can decode anything */
-	if (!ring->me)
-		return 0;
-
-	/* RADEON_VCN_ENGINE_INFO is at the top of ib block */
-	idx = vcn_v4_0_5_enc_find_ib_param(ib, RADEON_VCN_ENGINE_INFO,
-			RADEON_VCN_ENGINE_INFO_MAX_OFFSET);
-	if (idx < 0) /* engine info is missing */
-		return 0;
-
-	val = amdgpu_ib_get_value(ib, idx + 2); /* RADEON_VCN_ENGINE_TYPE */
-	if (val == RADEON_VCN_ENGINE_TYPE_DECODE) {
-		decode_buffer = (struct amdgpu_vcn_decode_buffer *)&ib->ptr[idx + 6];
-
-		if (!(decode_buffer->valid_buf_flag  & 0x1))
-			return 0;
-
-		addr = ((u64)decode_buffer->msg_buffer_address_hi) << 32 |
-			decode_buffer->msg_buffer_address_lo;
-		return vcn_v4_0_5_dec_msg(p, job, addr);
-	} else if (val == RADEON_VCN_ENGINE_TYPE_ENCODE) {
-		idx = vcn_v4_0_5_enc_find_ib_param(ib, RENCODE_IB_PARAM_SESSION_INIT,
-			RENCODE_IB_PARAM_SESSION_INIT_MAX_OFFSET);
-		if (idx >= 0 && ib->ptr[idx + 2] == RENCODE_ENCODE_STANDARD_AV1)
-			return vcn_v4_0_5_limit_sched(p, job);
-	}
-	return 0;
-}
-
 static const struct amdgpu_ring_funcs vcn_v4_0_5_unified_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_ENC,
 	.align_mask = 0x3f,
@@ -1566,7 +1402,6 @@ static const struct amdgpu_ring_funcs vcn_v4_0_5_unified_ring_vm_funcs = {
 	.get_rptr = vcn_v4_0_5_unified_ring_get_rptr,
 	.get_wptr = vcn_v4_0_5_unified_ring_get_wptr,
 	.set_wptr = vcn_v4_0_5_unified_ring_set_wptr,
-	.patch_cs_in_place = vcn_v4_0_5_ring_patch_cs_in_place,
 	.emit_frame_size =
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 3 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 4 +
-- 
2.34.1

