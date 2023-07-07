Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB0ADEB64D9
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jul 2023 15:21:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1ABFC10E14C;
	Fri,  7 Jul 2023 15:21:22 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49F4510E5B0
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jul 2023 15:21:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eMp/Flo6eMXKOL7KgAoBWh59g+EYnwle6GqhIahtl/1UJTE7cS9y9atrD3b996CyvEu7o+t77cigKiqRbrjdu26CrvbxmOQh2ji45hI4gj8dGWPgbWnrtTZ/zma44BgfFd8+GcaAMk+qG7oWVT6GkUiDGoqwezAxWcwXxdr+8JGkbGv83ELztbx14dbiTxA+J+GSFj5DdvcxA/V6tIfi11V8uzCPX9nPc6bgUMPnqPsRLvQ1tG8SPIT920XFHGCZwswNOR32lw7uXPb3EsSVeYyHx90OiLB0gBDh8IPftVOTuZ3avfpOgeUgChqAQZ2GVbtunndsSkAwkgGbV2I+7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VbwF42dezmyITdQNvCsQBCZ7jT8oKmGe4+lGTNV/4Vo=;
 b=URPxAerZA8c1VFCEEY5QF9BpcwX/3Vzk+KWvrgTKpvtIGsmVZvlqgoyK5E7nyKZ6+BWqEoTnkmEpcnJ4iVUlGJf12cOFyfTK1wmkXLCxrmisKdkv2c+itK5iNSB4qqvWXdDfxSvU0OKNb7Mf18szMguhHGzxmJjpS+QrkypB6f1IhrFxLB8n/E+n/d1F/ZN9Jm02KhvfsuQkcO+yPDEpPJKwjV1ioY4q1p70ibxsEdcoSehmj8N9LFQYgIIYeMVlSBiUodDU9ffBxIez55g7E3/BFSm8V7OPBcQYX8xiCHs+4lzK7jjPVBRjF5lZ/NBkgIAS3KEn7ClReTQ9tmL3HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VbwF42dezmyITdQNvCsQBCZ7jT8oKmGe4+lGTNV/4Vo=;
 b=4t2MtuC77qhBtZi1HZkV+bTRvDfumERAIw7v5ImpTc+wDgpt+sUFxNjTHyRG9TBd86uk86XnY2+yRL18otZ9u+y3j71Sxfqfy+XiB941SRM1Fd78ASkRW+i6cGqFehZz0liE6YfG/IbMpyiON/LpEJ9np/0VOLUoLcp8Qb7uaB0=
Received: from MW3PR06CA0004.namprd06.prod.outlook.com (2603:10b6:303:2a::9)
 by DM6PR12MB5519.namprd12.prod.outlook.com (2603:10b6:5:1b5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 15:21:18 +0000
Received: from CO1NAM11FT116.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2a:cafe::3b) by MW3PR06CA0004.outlook.office365.com
 (2603:10b6:303:2a::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25 via Frontend
 Transport; Fri, 7 Jul 2023 15:21:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT116.mail.protection.outlook.com (10.13.174.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.45 via Frontend Transport; Fri, 7 Jul 2023 15:21:17 +0000
Received: from x570-ryzen9-5900x.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 7 Jul 2023 10:21:14 -0500
From: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
To: <saleemkhan.jamadar@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <christian.koenig@amd.com>, <leo.liu@amd.com>,
 <veerabadhran.gopalakrishnan@amd.com>, <sathishkumar.sundararaju@amd.com>
Subject: [PATCH v5] drm/amdgpu:update kernel vcn ring test
Date: Fri, 7 Jul 2023 20:50:46 +0530
Message-ID: <20230707152046.48706-1-saleemkhan.jamadar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT116:EE_|DM6PR12MB5519:EE_
X-MS-Office365-Filtering-Correlation-Id: 174ca35a-681b-4a80-72ed-08db7efdcf77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6N1Fy8SL/CbefLqfEZCyBnYc21ryn0JNLHZv6Lr64+rp/c7jhwf+Yu6LamPPd/DEj9KY6ilHnWSULqcMy5786QEpZLRVR5l4HP6evjktjMDUUZqhwDGy7MMdrgVMhYN8uTg8f3wz9c3Tq4DZN0jqkgmyj8e+hX0TA6aQCL+mqyj3HEYaLEEnW7Kj05eQmPCeFqndtSHoEO2MCUWxeFJIgfPTlmbNaDM1QaMzXnngVaLDChUXzBI/zYvttf6OlAIYpqz3y5iIryQhMG0VZSbFa5VoEJ6mxjZXUbUUzbLBMCyCW32hNbZbfOt4Fxt9qf5P6TeATFJ4QRUl+ycbPvAK2mGHDfmjI6aVQ9DuxQPRnef7ks27AbFXoCzDP2quMh174b/y2SfTbsL/OZj10zMKsUbd2gRBYF8xGKcTukONuYkLtXeYf9ecPDrVwgHJ4v4Mix4nm7H3Kwoapgu7efbp3rc0SUKSizNUvimdIT+qySvPKHOc33Av3vJswzM3xHoWuXrPVH+gUT8BFPGL8WuA1VoZfHa3FTSG39Sk0mlyd9GZYfLmbPRYgVuO08xtnmXp8wLrjJOWP2nKV0HGkQnFJkM74ljU8w6xxN33H+0fAPQJ91KdVRYno1zl+8kAnXaGWAx5KtlgO9FyxZInji1eLHLdbrc+r6NS7e+yOYDrG0xy1sP0uRr9sxzDxxlLX0MFOG7gCLqtvOQmp8HzvM+DqfR//UkP6j/84xmsbc43S8SuU0ursL59lQQpW7P6bP+fGStYE6/SkhfSpte5vkwbRw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(39860400002)(376002)(346002)(451199021)(46966006)(36840700001)(40470700004)(6666004)(7696005)(478600001)(36860700001)(83380400001)(47076005)(86362001)(82740400003)(110136005)(70206006)(70586007)(81166007)(356005)(4326008)(6636002)(1076003)(26005)(16526019)(186003)(336012)(426003)(2616005)(5660300002)(44832011)(40460700003)(2906002)(41300700001)(8676002)(8936002)(316002)(40480700001)(36756003)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 15:21:17.4032 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 174ca35a-681b-4a80-72ed-08db7efdcf77
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT116.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5519
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
Cc: srinath.rao@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

add session context buffer to decoder ring test.

v5 - clear the session ct buffer (Christian)
v4 - data type, explain change of ib size change (Christian)
v3 - indent and  v2 changes correction. (Christian)
v2 - put the buffer at the end of the IB (Christian)

Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
Acked-by: Leo Liu <leo.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 13 +++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  5 ++++-
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 2d94f1b63bd6..76e9a2418286 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -573,13 +573,15 @@ static int amdgpu_vcn_dec_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
 	int r, i;
 
 	memset(ib, 0, sizeof(*ib));
-	r = amdgpu_ib_get(adev, NULL, AMDGPU_GPU_PAGE_SIZE * 2,
+	/* 34 pages : 128KiB  session context buffer size and 8KiB ib msg */
+	r = amdgpu_ib_get(adev, NULL, AMDGPU_GPU_PAGE_SIZE * 34,
 			AMDGPU_IB_POOL_DIRECT,
 			ib);
 	if (r)
 		return r;
 
 	msg = (uint32_t *)AMDGPU_GPU_PAGE_ALIGN((unsigned long)ib->ptr);
+	memset(msg, 0, (AMDGPU_GPU_PAGE_SIZE * 34));
 	msg[0] = cpu_to_le32(0x00000028);
 	msg[1] = cpu_to_le32(0x00000038);
 	msg[2] = cpu_to_le32(0x00000001);
@@ -608,13 +610,15 @@ static int amdgpu_vcn_dec_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
 	int r, i;
 
 	memset(ib, 0, sizeof(*ib));
-	r = amdgpu_ib_get(adev, NULL, AMDGPU_GPU_PAGE_SIZE * 2,
+	/* 34 pages : 128KiB  session context buffer size and 8KiB ib msg */
+	r = amdgpu_ib_get(adev, NULL, AMDGPU_GPU_PAGE_SIZE * 34,
 			AMDGPU_IB_POOL_DIRECT,
 			ib);
 	if (r)
 		return r;
 
 	msg = (uint32_t *)AMDGPU_GPU_PAGE_ALIGN((unsigned long)ib->ptr);
+	memset(msg, 0, (AMDGPU_GPU_PAGE_SIZE * 34));
 	msg[0] = cpu_to_le32(0x00000028);
 	msg[1] = cpu_to_le32(0x00000018);
 	msg[2] = cpu_to_le32(0x00000000);
@@ -700,6 +704,7 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
 	struct amdgpu_job *job;
 	struct amdgpu_ib *ib;
 	uint64_t addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
+	uint64_t session_ctx_buf_gaddr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr + 8192);
 	bool sq = amdgpu_vcn_using_unified_queue(ring);
 	uint32_t *ib_checksum;
 	uint32_t ib_pack_in_dw;
@@ -730,6 +735,10 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
 	ib->length_dw += sizeof(struct amdgpu_vcn_decode_buffer) / 4;
 	memset(decode_buffer, 0, sizeof(struct amdgpu_vcn_decode_buffer));
 
+	decode_buffer->valid_buf_flag |=
+				cpu_to_le32(AMDGPU_VCN_CMD_FLAG_SESSION_CONTEXT_BUFFER);
+	decode_buffer->session_context_buffer_address_hi = upper_32_bits(session_ctx_buf_gaddr);
+	decode_buffer->session_context_buffer_address_lo = lower_32_bits(session_ctx_buf_gaddr);
 	decode_buffer->valid_buf_flag |= cpu_to_le32(AMDGPU_VCN_CMD_FLAG_MSG_BUFFER);
 	decode_buffer->msg_buffer_address_hi = cpu_to_le32(addr >> 32);
 	decode_buffer->msg_buffer_address_lo = cpu_to_le32(addr);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index f1397ef66fd7..2df43cd76c10 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -166,6 +166,7 @@
 
 #define AMDGPU_VCN_IB_FLAG_DECODE_BUFFER	0x00000001
 #define AMDGPU_VCN_CMD_FLAG_MSG_BUFFER		0x00000001
+#define AMDGPU_VCN_CMD_FLAG_SESSION_CONTEXT_BUFFER	0x00100000
 
 #define VCN_CODEC_DISABLE_MASK_AV1  (1 << 0)
 #define VCN_CODEC_DISABLE_MASK_VP9  (1 << 1)
@@ -357,7 +358,9 @@ struct amdgpu_vcn_decode_buffer {
 	uint32_t valid_buf_flag;
 	uint32_t msg_buffer_address_hi;
 	uint32_t msg_buffer_address_lo;
-	uint32_t pad[30];
+	uint32_t session_context_buffer_address_hi;
+	uint32_t session_context_buffer_address_lo;
+	uint32_t pad[28];
 };
 
 #define VCN_BLOCK_ENCODE_DISABLE_MASK 0x80
-- 
2.25.1

