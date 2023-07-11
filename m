Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2ED0EB64DC
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jul 2023 17:47:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0450810E41F;
	Tue, 11 Jul 2023 17:47:54 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9332A10E41F
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jul 2023 17:47:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lYvDczahsVTHOPTWQ3u37l2njO/Okb6OHRpGfpg9SlsHX/oQUKA+LiBFMtQEA4kzQovjHIQawvc5OYVRZvV+7JUpzhevrOpohO0S/NAYvtqLEPHa3RiySuj5cXQ/uOmbG88xbcW8lRPt8NYLRUOTbDzttiGRIO8gumuxiABpDQFM5L3KwsMI9+LN8WpeUE79X2QHWpH3KC7I267l8GBK9pYEcPCj13as5RuHgHHGRWA593ZjAJPYx7dSJI+ncSXmcRcpwxi/8UPyyfyQW6Xpyf8dDUVzDoGDPoDKc37i7dhuk3T8rk3ECLFvRUdrpsEWDtnwbgYuI3ifwz8AbrChUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qKR7+LMUugceDTJFGzcaLP/Tl7migp53BY6ikFbSepk=;
 b=lZNLgEQFiZyWopvaToecNkGLn1NMiwWhmtfK/AFPZDpk48lnkWAWeN9Onj0Tl6hxNPPOiLcL+PG67s/hsiUnngt6S6n4yjzOlSnjsCw8eAiHJb9Kj3rJcb/I3YK9vxj0brseeg2VCdeRYscCIpFJ2Zo6nwiAuRxmSfSNvlDC7aKx6oz81sPUFjrbshm2Q/OKZ7phIR5uOJaaDGInztVkNCudK1bl/BZf7R2Imid0jwzUxuibwJTifuIaAoHyvJyzkMUnSwb6R0+5CJ5ECPlXR85hvWtkWAt6Y5kCWlscEiaPgYGfAezoKbwUXKCJ6r6xzvA17Ah+QPs6H0YdqI++pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qKR7+LMUugceDTJFGzcaLP/Tl7migp53BY6ikFbSepk=;
 b=vzKxr6N5GqITIebXl/YtAAk/9FSevxHRWZxoqPn2kNpjvB76cLBMrx++9AF0yLnIpx2t8BuR1K4CDJVLD9ypxrvRWzDxkx20q/h0BMYtKw4TOyUycvdO+DdOvck8naW2KIMWu3yJOvA8iKiTTYGrahQ47gWvtPl/UkmZQ+phu4c=
Received: from BYAPR07CA0009.namprd07.prod.outlook.com (2603:10b6:a02:bc::22)
 by DS7PR12MB6240.namprd12.prod.outlook.com (2603:10b6:8:94::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Tue, 11 Jul
 2023 17:47:50 +0000
Received: from DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a02:bc:cafe::7e) by BYAPR07CA0009.outlook.office365.com
 (2603:10b6:a02:bc::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32 via Frontend
 Transport; Tue, 11 Jul 2023 17:47:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT018.mail.protection.outlook.com (10.13.172.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.20 via Frontend Transport; Tue, 11 Jul 2023 17:47:49 +0000
Received: from x570-ryzen9-5900x.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 11 Jul 2023 12:47:23 -0500
From: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
To: <saleemkhan.jamadar@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <christian.koenig@amd.com>, <leo.liu@amd.com>,
 <veerabadhran.gopalakrishnan@amd.com>
Subject: [PATCH 1/2] drm/amdgpu:update kernel vcn ring test
Date: Tue, 11 Jul 2023 23:17:04 +0530
Message-ID: <20230711174705.3945441-1-saleemkhan.jamadar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT018:EE_|DS7PR12MB6240:EE_
X-MS-Office365-Filtering-Correlation-Id: 57c5a55f-b6d3-4b89-3dbf-08db8236f196
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V7JC6IZMANF/eGWn848CP3PA3HCMvvAogfQisqSGmpjb6rWg9BvYjw/ckNXVO8KFmppO4CdBrUOWfCLSgbtRRnU9n4UQcvkl9F5pyfbdfpu/7rXiaSFOllmFbABmJnQdTOvUU6B3IwZCUJSuonPMmIyV6q8oxkq1ev4WXonUtflbvz9VHsOM3GhdhLWfbPJw9ihGF16VmiCKddOt8nzE9tJy8WtxMO07K4/p3wUjLw5GPwyIiYyKkVTMoZwumU078T+gLNKx0LJSq/9Eoma21yhAuwg7KEgLS7gFtjfp5gF7OZc9aEbcXsKDPRZH1NQFMG/OV3khXqYQ3ZSwWq+3QlRfp8PV/ETyEQXf+0Orbkm+9KcFLQuZJdKzgwXfz5GLG8DrbTkKj/RrzPD4k7lf6WfGQehnms0tJAW65SUjCkaTlCszPftWZbWqpn5JJ5UJYLHQ2LVC7BxcPIjfKQTD0Ie/LW4ZjR3MSwRkhsQgO5By1vfkUdPLCdsotdejeCR38jWPwXGs2hqoAD1XYYXc74DdG/6BP8vDzRV12qg7kYZeQOz4vrROgtthThIuRQG13dobL5AqPIjCFFxzapRihWKtkaxd6OkekffdTE0J9Ocm0Zaocmkws2Z7mgydoekWLZQ2edr+TLPB+VsZ8zg+zsfC84ExXkVUYx0m49bZSFZBbPcPdiMnGFvzCFgwVh1nZ2jx4KAY68dmSPmVf7M+x/OLArs4ikJyaU2gC5tll0mfjN5B1ESkeLX6RmAlBwOW/BbgYoX41+uOMq2dF0QDpQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(396003)(136003)(346002)(451199021)(46966006)(40470700004)(36840700001)(86362001)(40460700003)(82310400005)(8676002)(8936002)(186003)(16526019)(36756003)(36860700001)(426003)(336012)(47076005)(2616005)(2906002)(83380400001)(5660300002)(44832011)(1076003)(40480700001)(26005)(82740400003)(356005)(81166007)(6666004)(54906003)(110136005)(70206006)(70586007)(7696005)(6636002)(4326008)(478600001)(316002)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 17:47:49.5276 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57c5a55f-b6d3-4b89-3dbf-08db8236f196
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6240
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
Cc: sathishkumar.sundararaju@amd.com, srinath.rao@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

add session context buffer to decoder ring test.

v5 - clear the session ct buffer (Christian)
v4 - data type, explain change of ib size change (Christian)
v3 - indent and  v2 changes correction. (Christian)
v2 - put the buffer at the end of the IB (Christian)

Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
Acked-by: Leo Liu <leo.liu@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 13 +++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  5 ++++-
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 4e1256af80b6..8966ffb2f4a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -591,13 +591,15 @@ static int amdgpu_vcn_dec_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
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
@@ -626,13 +628,15 @@ static int amdgpu_vcn_dec_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
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
@@ -718,6 +722,7 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
 	struct amdgpu_job *job;
 	struct amdgpu_ib *ib;
 	uint64_t addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
+	uint64_t session_ctx_buf_gaddr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr + 8192);
 	bool sq = amdgpu_vcn_using_unified_queue(ring);
 	uint32_t *ib_checksum;
 	uint32_t ib_pack_in_dw;
@@ -748,6 +753,10 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
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
index 1f1d7dc94f90..ba5fefd74197 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -171,6 +171,7 @@
 
 #define AMDGPU_VCN_IB_FLAG_DECODE_BUFFER	0x00000001
 #define AMDGPU_VCN_CMD_FLAG_MSG_BUFFER		0x00000001
+#define AMDGPU_VCN_CMD_FLAG_SESSION_CONTEXT_BUFFER	0x00100000
 
 #define VCN_CODEC_DISABLE_MASK_AV1  (1 << 0)
 #define VCN_CODEC_DISABLE_MASK_VP9  (1 << 1)
@@ -366,7 +367,9 @@ struct amdgpu_vcn_decode_buffer {
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

