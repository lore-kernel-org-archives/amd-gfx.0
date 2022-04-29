Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 716FFC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:46:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C120F10F204;
	Fri, 29 Apr 2022 17:46:54 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2041.outbound.protection.outlook.com [40.107.95.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E43EB10F237
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:46:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D12mswZRzNoAkEBkHe2a/6osfHRFKfT2mj1vVVLwFidNUNNZne4pKTERhEdHhKwCrVe/iCVWFiPaiVxkDmxIfIye7eSNL/8vfrhccMnIOeKC9Wu5uUHMwveBbJ2V7T8V6eCFPy9XGLTs29G18rblC5uNVlBoQ68XP3RdPpJKi0QxlUTGCQySC5Bf4gC0vP7XqRXa8YWzct1l3cjfBsUEfeG5H6K2ZoL7u8brDMCQqef5lIEE/YBnLpwLagYUiTbwxu6A7izq3vGUmDJiXjAQwOGTS12q7jbIxqpNhDAK9lLeMreuZpPwmKno7WuyZdXzGnBJzrrF0KtnkwW16Eg97g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9t9QbAKWiSxGGwQMpEXeq6D91SdpvSewdI9amsbvjkU=;
 b=m/xX1KACnwTcF8yNZwwCRrMmf6AqzA8I6jel9HhGQFay8aePPYf1qBFEfkxvt0Q/VX02idswSIMupYixx+Z5wyhn/Re2W8lGvbHQ46fDM3zur0Ubpeg2wIE78Theo4S4F3sIgj7Qj2sApyXVTqBfH+cy3PEd0+skMQyWYUacqHj8TMuA7gdrpMcVQL2L8LChnaFrOGQqPyJDIamWT/HiwUKRGBQhnaNAImArcCCjZXX+TIm0bZwZquybh3QcTFklglUWqGrBL3D73MJif2oLEGor3fEiVXsSoUZqzT1vxvk7AkxzoKm7WIuvFb2Mm9NaTs+PAsaHx/VA3RpO93cy5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9t9QbAKWiSxGGwQMpEXeq6D91SdpvSewdI9amsbvjkU=;
 b=nGtmd+YzmXUV8LISm5n2Kq5bgVcsXaZdWahpGQRFFESm162z0OcLbEo5/PbLoT/psFF9I07HyTfUpW7SeRHMxZCxKGeXma5fUwNz1z9xQIcPlSWImps002YL9MUE/xJdLft38THwMtVeNz2UsiKtr3DMFyxvvV2XxNhKknkDK6Q=
Received: from DM6PR12CA0009.namprd12.prod.outlook.com (2603:10b6:5:1c0::22)
 by DS7PR12MB5862.namprd12.prod.outlook.com (2603:10b6:8:79::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.14; Fri, 29 Apr 2022 17:46:46 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::77) by DM6PR12CA0009.outlook.office365.com
 (2603:10b6:5:1c0::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Fri, 29 Apr 2022 17:46:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 17:46:46 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 12:46:44 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/73] drm/amdgpu/gfx10: use INVALIDATE_TLBS to invalidate
 TLBs v2
Date: Fri, 29 Apr 2022 13:45:25 -0400
Message-ID: <20220429174624.459475-15-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429174624.459475-1-alexander.deucher@amd.com>
References: <20220429174624.459475-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9559e811-5645-4f7d-05e2-08da2a083ad9
X-MS-TrafficTypeDiagnostic: DS7PR12MB5862:EE_
X-Microsoft-Antispam-PRVS: <DS7PR12MB5862D0C76A60BCDFD1605CD7F7FC9@DS7PR12MB5862.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4aRVlRSvRhet/SxEzcV6vYCm9vtME8/mXQSa/yQEqMRLpbqEPjjLPaCEYzsKGIFx8Ta85qaX98++9cD0ksj2zM88jvcj/q48JE/GmxSNPq3bpey5KXRJleLCJm+S+3vxR0D5plVHipk86iS57ADOuUFr8DhVQFR8zPlxiQYh+3oajLSShqJW/tnswOXiL5EAw4+tPDckcnwvnYkerJfTv3JUL85wp9XEvJvD+/uCIQxXqRp/E7cdB83YkquIKEn7ou8L2ZD8Kdq3ms+YPtjsLTj4RdOlSua+nTlkrp7es66x3yYMspaxn2R7psQH1Gnm2OuORQKTHUfAt5sXJ8I7liDXsehtTox4qD53VZtCuVmRiEdcVJC+91E/In4X2lbboTMlvZJLzyfn/Bjx6fbc7aL6vgoDgDgrMXcoxcQt7sWu5nLVfdXsT7P6lwYL0IcHSbBCSUoKaSKw8xeOzVCjN0NwNaIvfDB1hDiwHcvPE/IkJuvk1EiU3DHnJzqNfyN3krSST/9SFbh95WiLKZkox/70BAi/dqKMakMeQwq38htv0HQItv3b/ovqyH9fOfKS/70Smw70mNSHcYfU1EiXKTOvOzHlLCMvpa6VZdtpTn40y/0E+LFGd8DHU4TfZNoyDocvCKm2MwSnJDStBZ3I3QuauM9WOLWNHyu4iYJutGNNUZyVNd8sdj4IzL7LRbjM38LkFq4WlVYvCAit0hvipg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(83380400001)(36860700001)(2906002)(336012)(1076003)(16526019)(47076005)(26005)(2616005)(186003)(426003)(7696005)(6666004)(66574015)(36756003)(508600001)(70586007)(5660300002)(86362001)(70206006)(8936002)(8676002)(4326008)(6916009)(54906003)(316002)(40460700003)(82310400005)(356005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:46:46.0815 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9559e811-5645-4f7d-05e2-08da2a083ad9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5862
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Jack Xiao <Jack.Xiao@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jack Xiao <Jack.Xiao@amd.com>

For MES queue VM flush, use INVALIDATE_TLBS to invalidate TLBs.
This packet can let CP firmware to determine the current vmid
and inv eng to invalidate.

v2: unify invalidate_tlbs functions

Cc: Le Ma <le.ma@amd.com>
Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 27 +++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 0d91632f563d..2ab5259c7305 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3503,6 +3503,9 @@ static void gfx_v10_0_ring_emit_frame_cntl(struct amdgpu_ring *ring, bool start,
 static u32 gfx_v10_3_get_disabled_sa(struct amdgpu_device *adev);
 static void gfx_v10_3_program_pbb_mode(struct amdgpu_device *adev);
 static void gfx_v10_3_set_power_brake_sequence(struct amdgpu_device *adev);
+static void gfx_v10_0_ring_invalidate_tlbs(struct amdgpu_ring *ring,
+					   uint16_t pasid, uint32_t flush_type,
+					   bool all_hub, uint8_t dst_sel);
 
 static void gfx10_kiq_set_resources(struct amdgpu_ring *kiq_ring, uint64_t queue_mask)
 {
@@ -3595,12 +3598,7 @@ static void gfx10_kiq_invalidate_tlbs(struct amdgpu_ring *kiq_ring,
 				uint16_t pasid, uint32_t flush_type,
 				bool all_hub)
 {
-	amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_INVALIDATE_TLBS, 0));
-	amdgpu_ring_write(kiq_ring,
-			PACKET3_INVALIDATE_TLBS_DST_SEL(1) |
-			PACKET3_INVALIDATE_TLBS_ALL_HUB(all_hub) |
-			PACKET3_INVALIDATE_TLBS_PASID(pasid) |
-			PACKET3_INVALIDATE_TLBS_FLUSH_TYPE(flush_type));
+	gfx_v10_0_ring_invalidate_tlbs(kiq_ring, pasid, flush_type, all_hub, 1);
 }
 
 static const struct kiq_pm4_funcs gfx_v10_0_kiq_pm4_funcs = {
@@ -8700,10 +8698,25 @@ static void gfx_v10_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
 			       upper_32_bits(addr), seq, 0xffffffff, 4);
 }
 
+static void gfx_v10_0_ring_invalidate_tlbs(struct amdgpu_ring *ring,
+				   uint16_t pasid, uint32_t flush_type,
+				   bool all_hub, uint8_t dst_sel)
+{
+	amdgpu_ring_write(ring, PACKET3(PACKET3_INVALIDATE_TLBS, 0));
+	amdgpu_ring_write(ring,
+			  PACKET3_INVALIDATE_TLBS_DST_SEL(dst_sel) |
+			  PACKET3_INVALIDATE_TLBS_ALL_HUB(all_hub) |
+			  PACKET3_INVALIDATE_TLBS_PASID(pasid) |
+			  PACKET3_INVALIDATE_TLBS_FLUSH_TYPE(flush_type));
+}
+
 static void gfx_v10_0_ring_emit_vm_flush(struct amdgpu_ring *ring,
 					 unsigned vmid, uint64_t pd_addr)
 {
-	amdgpu_gmc_emit_flush_gpu_tlb(ring, vmid, pd_addr);
+	if (ring->is_mes_queue)
+		gfx_v10_0_ring_invalidate_tlbs(ring, 0, 0, false, 0);
+	else
+		amdgpu_gmc_emit_flush_gpu_tlb(ring, vmid, pd_addr);
 
 	/* compute doesn't have PFP */
 	if (ring->funcs->type == AMDGPU_RING_TYPE_GFX) {
-- 
2.35.1

