Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF05EB64D9
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jul 2023 14:48:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BFB610E41F;
	Thu,  6 Jul 2023 14:48:00 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A221A10E417
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jul 2023 14:47:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FedCtT0i4PetWGxPgOMw7ffw8y+o+0oDEbauvLpkETLXJ+0TJuepOSpc2RmOBjfWr1BJstsvvyVlIftSP92Gas8dQ+i5C4ju5nBwCDKTHhUMYgoppOe/H+nGJpk9bQNKsxDMs9skmjY2PXFjrZYMwPKjSyVK4kbcunR7/FmrgXaPKqFiOPDL5AaiquzMxvmwltr6qSfqy4r7v4CI3vThcBKib3S9UdWJlt7yk15M3LINW3dWBY5AEOhMUzik0FXyxev5qkRj7Mfr5u7yEVGcO3yATjRd+qGIhWH25h2JWFy/iQk9AihotZSJtJc2aKdeQjwWYCrmTs+qW1F6w6HjMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LGuZok2vSepVDJKhlCoDgeEAZ6bM4GH7Rq1feSqA14k=;
 b=i/CfneirP+jrvaPZlrkQzVSh//L8WtAZMH6gblf5atgtswd6OTVv7udgiorCUw26cHWBxlQjVJjEcaPKIkwohSqjyfV4geVxLQj1dau/WiTBGDpxzHR6p7NLVf46EJch+6sotUxqWI8flS32QqfwQ8oPBCOtEFaRZxQsXwO3jstqa+bRwA3VwuOzg2ZsewDD6lnao6D9ob2B5oStDJA4G9GqI0YevUsr7DAeDJvit1sI4Exzn9bn78u3Rc2jlCYkvi2Hbj+WB2zV/hAwgujjfdd+82MWCsYNf9dp362AyQ/QIpdu/UKecePbW3sCsShJ9GoFJTQJWy8CUEJuejxFGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LGuZok2vSepVDJKhlCoDgeEAZ6bM4GH7Rq1feSqA14k=;
 b=PDJeflrUfJnIN9wYHa/VJV0Nvrofu1Zrth4qFbVBM8ObHgZze3L3zET3I886hh4AdrYLOUB0ePz7M9RQbY5gWv/lA33zx4qImKfMh/9bFuEWmlTVDg0o9ZSdt28mrua82hpJt9l4pbCZ7UXzQW7iJSHsykpM7uKfAx00xBmHrFg=
Received: from MW4PR03CA0301.namprd03.prod.outlook.com (2603:10b6:303:dd::6)
 by DM4PR12MB6494.namprd12.prod.outlook.com (2603:10b6:8:ba::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 14:47:56 +0000
Received: from CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::a1) by MW4PR03CA0301.outlook.office365.com
 (2603:10b6:303:dd::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.18 via Frontend
 Transport; Thu, 6 Jul 2023 14:47:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT011.mail.protection.outlook.com (10.13.175.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.45 via Frontend Transport; Thu, 6 Jul 2023 14:47:55 +0000
Received: from x570-ryzen9-5900x.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 6 Jul 2023 09:47:52 -0500
From: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
To: <saleemkhan.jamadar@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <christian.koenig@amd.com>, <leo.liu@amd.com>,
 <veerabadhran.gopalakrishnan@amd.com>, <sathishkumar.sundararaju@amd.com>
Subject: [PATCH v4] drm/amdgpu:update kernel vcn ring test
Date: Thu, 6 Jul 2023 20:17:20 +0530
Message-ID: <20230706144720.3841607-1-saleemkhan.jamadar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT011:EE_|DM4PR12MB6494:EE_
X-MS-Office365-Filtering-Correlation-Id: ef32063d-ec6e-48af-da65-08db7e2ffbf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fmFrNVYLXa1va6P87IXxWfc+B/z2Im8snC6P7J7m9Bb1pllP1wnDiYZPIMEGdIx6vWJ77ryTgkUX/b9NrHPp7LfcUxWv1SwlGCqe/74if/7NYxVMc36j5qMYj6wcnPBcP29q9PdASy4laM+iPMEWEGjijDehkn9UZzOEvyHe5iPPhDQHe9M5KovcxoLTN4DTL27jjGPRcK6AdetOvsMmj1sM8Bbk9yj04eL43sSTAJwhjpSFD2rDeq4NL9jqazRsFSm7kRNyqXWwaSzifwAnAIZaRGx45gxkIFY8Q/sp4+Wf90dk+YLy8a6TPEq1eQNZAYkZpdNlZfdSzOcbdKwuzLgIf3Jwcg9Fxx81xkwGbdaZrOc4zisPGx4sYPzJuWrg/bQRDYyJ1qwfudVXX/MvEP/phBmDhG3SRN6rNfTAmBnnXBsMe2M4RMEcFP+OB4JQr9DGdMMGcutIFUYJlAjqrtVzF+yFuq8+4oEY71aWjeUtqkJ8MAJ9WzNd4N+7bVFA+lyyubGtXB6hmX3q5rLguGK7MNvCj/442rixGwUaFgnPf/9zG6OLBas1MXmC1KhilhaUH0p4aEYZpwrYK+Wso3CUvQUzZf4+jV05DQ32f5nkaHbgXJyJ8gF8nGLaegcr5/O0EaD5S3kIWvhq9jgW6Modcn2ftw8eXPqdP/3cU8HqrxFy/t2tNd9w69umC+l6vQkT1KBf9Mnpvz63cLk9Z0ANVlOntki6GwxqdkR0QI3RAeah+2IQd/Yf7KRKAA56ko2EMnkwnqatt1wx76kwrQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(39860400002)(346002)(396003)(451199021)(36840700001)(40470700004)(46966006)(5660300002)(36756003)(86362001)(82310400005)(2906002)(44832011)(40460700003)(40480700001)(47076005)(83380400001)(16526019)(336012)(36860700001)(186003)(426003)(26005)(1076003)(6666004)(7696005)(82740400003)(81166007)(110136005)(2616005)(4326008)(316002)(6636002)(478600001)(70206006)(356005)(70586007)(8676002)(8936002)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 14:47:55.7291 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef32063d-ec6e-48af-da65-08db7e2ffbf8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6494
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

v4 - data type, explain change of ib size change (Christian)
v3 - indent and  v2 changes correction. (Christian)
v2 - put the buffer at the end of the IB (Christian)

Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
Acked-by: Leo Liu <leo.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 11 +++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  5 ++++-
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 2d94f1b63bd6..9bdfe665f603 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -573,7 +573,8 @@ static int amdgpu_vcn_dec_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
 	int r, i;
 
 	memset(ib, 0, sizeof(*ib));
-	r = amdgpu_ib_get(adev, NULL, AMDGPU_GPU_PAGE_SIZE * 2,
+	/* 34 pages : 128KiB  session context buffer size and 8KiB ib msg */
+	r = amdgpu_ib_get(adev, NULL, AMDGPU_GPU_PAGE_SIZE * 34,
 			AMDGPU_IB_POOL_DIRECT,
 			ib);
 	if (r)
@@ -608,7 +609,8 @@ static int amdgpu_vcn_dec_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
 	int r, i;
 
 	memset(ib, 0, sizeof(*ib));
-	r = amdgpu_ib_get(adev, NULL, AMDGPU_GPU_PAGE_SIZE * 2,
+	/* 34 pages : 128KB  session context buffer size and 8KB ib msg */
+	r = amdgpu_ib_get(adev, NULL, AMDGPU_GPU_PAGE_SIZE * 34,
 			AMDGPU_IB_POOL_DIRECT,
 			ib);
 	if (r)
@@ -700,6 +702,7 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
 	struct amdgpu_job *job;
 	struct amdgpu_ib *ib;
 	uint64_t addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
+	uint64_t session_ctx_buf_gaddr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr + 8192);
 	bool sq = amdgpu_vcn_using_unified_queue(ring);
 	uint32_t *ib_checksum;
 	uint32_t ib_pack_in_dw;
@@ -730,6 +733,10 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
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

