Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8187C001B0
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Jul 2023 05:20:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A93610E06F;
	Thu, 13 Jul 2023 05:20:51 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48B3510E06F
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jul 2023 05:20:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BiRA65yxi+V/sXSfNKkX7alU3upAi0nsm2gbGqgWeoPkYAiUPFmqVhacd7QjkKlMf1OXQWSHGFMZ/Pj3zUpaRYaXp+NmjpqoCbVbd+kz9I3nVGDn+xpeL0T7fldhQzTKYFE3Sy3vb8cPVG5URu58LT4911xwKJJ2cufHnuKctV+AT+/dUth/jDx1+t6XRRB0SSpUVeCZC+vnu9ud02lpCRYMnWlwhJ1AdhC3TDB2nB9R9DgvYt2v9u46OV8E56oEBIHwuAY9ZLZISOxFj0H9aU79KN/WIjXuIxTXwu4RbZoil6UaNg2rPfJDUNkKrurvD+klNeko4mX36hQFjmuErw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n51C4E0qMdOtSXUcmYxBbiyVhEMFWuwYNUcjoYrijhg=;
 b=JKwF5dYYKR4ZtR+M3pzjmRIxIcQfT4LaLYLIOFStBlFObzXL8L6rNbrz2JF3E/BmxfoyG5EpBh0rNwQcYnLZh3cPMhMnObuFHUc6tjdgv2k2adsuQhFKChFSd4ejTIOjSLel+RKLsz5zVmw/7J9UGBwT5AN/ig+yIZMm2TLDfEobWivmYqOEyTSjlkLh/maFdnHhohDdZHopQWQOxqYb14DfhEThK+49c2MUVMnncCc8I9bgkWFIMTDCfvn6ZHmwoppH2yjR2FcF9Ma6vRZnpl+xQhhwKZZhB0zbbNx0UdG9Xt/I7ENtijwZweYWmj0z3bCH6MSf6UFL4qawAXaJnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n51C4E0qMdOtSXUcmYxBbiyVhEMFWuwYNUcjoYrijhg=;
 b=CCK9fx/4o7MgkJ8TuTOyb+/S3mBp7ULW21Rk3FmMSLeYTSxIYUa/y6LUCUJG8ODAGpCj9uxv9rPSgYgMNgrzpYe8+1Icrarwdtyb7h53xvesuOFa/NizRoZ5a7RavUGzJ6V5DwtqeAVacctESfUNJploa86puZFUO0JcFKiYei0=
Received: from MW4PR04CA0368.namprd04.prod.outlook.com (2603:10b6:303:81::13)
 by MN2PR12MB4501.namprd12.prod.outlook.com (2603:10b6:208:269::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24; Thu, 13 Jul
 2023 05:20:45 +0000
Received: from CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::d0) by MW4PR04CA0368.outlook.office365.com
 (2603:10b6:303:81::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22 via Frontend
 Transport; Thu, 13 Jul 2023 05:20:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT046.mail.protection.outlook.com (10.13.174.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.24 via Frontend Transport; Thu, 13 Jul 2023 05:20:44 +0000
Received: from x570-ryzen9-5900x.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 13 Jul 2023 00:20:41 -0500
From: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
To: <saleemkhan.jamadar@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <marek.olsak@amd.com>, <christian.koenig@amd.com>, <leo.liu@amd.com>,
 <veerabadhran.gopalakrishnan@amd.com>
Subject: [PATCH 2/2] Revert "drm/amdgpu:update kernel vcn ring test"
Date: Thu, 13 Jul 2023 10:49:48 +0530
Message-ID: <20230713051948.3952921-2-saleemkhan.jamadar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230713051948.3952921-1-saleemkhan.jamadar@amd.com>
References: <20230713051948.3952921-1-saleemkhan.jamadar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT046:EE_|MN2PR12MB4501:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e7891ac-b2a6-42f0-9648-08db8360e8d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YvXKQarK7gww5m2nl8vpLWSaHXEKc/6cRAALF3DH5g9nf5orFpOkFLWsT7X9UZ8fArDHmTJ82eWqQVRD2AXBXNgWuSI1juw8KtMsJKOBBMuvFqzJa0OIvWDQ+ba7Z1413b/wZkci4dWIuOkJrl8KXtVbD+dw5quAT4Cf7Fml8LqUSbIvavsHqtEPpRtsauf0MdR2PAeoMJwa34dT6IEKRB36b/nHzbCkA86w8b5n2p8bXepl7GdWGFoK3CZ4XH4LI10c6O5On1JN/U6fK2KrnnYWUTYAiGzgJH+ADttU6s4FwdbKGVoaZSkbA7MIvG4rC6AYeZx9HfYpxohvPaijYR834bPA2iGzS30+0kQh2eiMOOErB/CDdqhvT4mK/muE7keUuDuJOsOQPb4Agn+VD/8b4A0SFl/i1DqMkoh+oXi1jBsew0TD0bBDC2kBQE+T6Pf1mbwK7l+k/u6DFJERIK6hA9Z+DyxKAJCEk2m4J0rziF6z9Fa4LO/cSNtQpmCJeiLZynjHcNQwFzpi8JahRDaYU0P2JonvlMqgFwMPqd5XBEGwqcJI5jB3JnnrUGukWxhnVGUHg48k74CaaBdFtl3dCcBAUjOE7jio4DMAHgQIC5mG1ALTZ0reO5KMBhq9ZFOO9XQA3ig+ZRLycf+g17f9Wr8X51/Uc+5wNTsmMiXQcN9IMiR+s9qGKw1CfMu472CbR51QUDsKyO+vjEV851PLmfgasi3+egDyiwoYi1itTOjnfWtRlwPIpWRK99XcMtvM0fxiWI8Nkul3Lu3UhA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(16526019)(186003)(336012)(40460700003)(44832011)(83380400001)(86362001)(2906002)(8676002)(8936002)(478600001)(36756003)(82740400003)(81166007)(5660300002)(356005)(2616005)(426003)(7696005)(110136005)(40480700001)(316002)(82310400005)(26005)(36860700001)(41300700001)(1076003)(70586007)(70206006)(47076005)(4326008)(6636002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 05:20:44.7618 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e7891ac-b2a6-42f0-9648-08db8360e8d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4501
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
Cc: sathishkumar.sundararaju@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VCN FW depncencies revert it to unblock others

This reverts commit ce085b8068e1071b0068f9a5dee78c97ef587022.

Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 13 ++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  5 +----
 2 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 8966ffb2f4a0..4e1256af80b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -591,15 +591,13 @@ static int amdgpu_vcn_dec_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
 	int r, i;
 
 	memset(ib, 0, sizeof(*ib));
-	/* 34 pages : 128KiB  session context buffer size and 8KiB ib msg */
-	r = amdgpu_ib_get(adev, NULL, AMDGPU_GPU_PAGE_SIZE * 34,
+	r = amdgpu_ib_get(adev, NULL, AMDGPU_GPU_PAGE_SIZE * 2,
 			AMDGPU_IB_POOL_DIRECT,
 			ib);
 	if (r)
 		return r;
 
 	msg = (uint32_t *)AMDGPU_GPU_PAGE_ALIGN((unsigned long)ib->ptr);
-	memset(msg, 0, (AMDGPU_GPU_PAGE_SIZE * 34));
 	msg[0] = cpu_to_le32(0x00000028);
 	msg[1] = cpu_to_le32(0x00000038);
 	msg[2] = cpu_to_le32(0x00000001);
@@ -628,15 +626,13 @@ static int amdgpu_vcn_dec_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
 	int r, i;
 
 	memset(ib, 0, sizeof(*ib));
-	/* 34 pages : 128KiB  session context buffer size and 8KiB ib msg */
-	r = amdgpu_ib_get(adev, NULL, AMDGPU_GPU_PAGE_SIZE * 34,
+	r = amdgpu_ib_get(adev, NULL, AMDGPU_GPU_PAGE_SIZE * 2,
 			AMDGPU_IB_POOL_DIRECT,
 			ib);
 	if (r)
 		return r;
 
 	msg = (uint32_t *)AMDGPU_GPU_PAGE_ALIGN((unsigned long)ib->ptr);
-	memset(msg, 0, (AMDGPU_GPU_PAGE_SIZE * 34));
 	msg[0] = cpu_to_le32(0x00000028);
 	msg[1] = cpu_to_le32(0x00000018);
 	msg[2] = cpu_to_le32(0x00000000);
@@ -722,7 +718,6 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
 	struct amdgpu_job *job;
 	struct amdgpu_ib *ib;
 	uint64_t addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
-	uint64_t session_ctx_buf_gaddr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr + 8192);
 	bool sq = amdgpu_vcn_using_unified_queue(ring);
 	uint32_t *ib_checksum;
 	uint32_t ib_pack_in_dw;
@@ -753,10 +748,6 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
 	ib->length_dw += sizeof(struct amdgpu_vcn_decode_buffer) / 4;
 	memset(decode_buffer, 0, sizeof(struct amdgpu_vcn_decode_buffer));
 
-	decode_buffer->valid_buf_flag |=
-				cpu_to_le32(AMDGPU_VCN_CMD_FLAG_SESSION_CONTEXT_BUFFER);
-	decode_buffer->session_context_buffer_address_hi = upper_32_bits(session_ctx_buf_gaddr);
-	decode_buffer->session_context_buffer_address_lo = lower_32_bits(session_ctx_buf_gaddr);
 	decode_buffer->valid_buf_flag |= cpu_to_le32(AMDGPU_VCN_CMD_FLAG_MSG_BUFFER);
 	decode_buffer->msg_buffer_address_hi = cpu_to_le32(addr >> 32);
 	decode_buffer->msg_buffer_address_lo = cpu_to_le32(addr);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index ba5fefd74197..1f1d7dc94f90 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -171,7 +171,6 @@
 
 #define AMDGPU_VCN_IB_FLAG_DECODE_BUFFER	0x00000001
 #define AMDGPU_VCN_CMD_FLAG_MSG_BUFFER		0x00000001
-#define AMDGPU_VCN_CMD_FLAG_SESSION_CONTEXT_BUFFER	0x00100000
 
 #define VCN_CODEC_DISABLE_MASK_AV1  (1 << 0)
 #define VCN_CODEC_DISABLE_MASK_VP9  (1 << 1)
@@ -367,9 +366,7 @@ struct amdgpu_vcn_decode_buffer {
 	uint32_t valid_buf_flag;
 	uint32_t msg_buffer_address_hi;
 	uint32_t msg_buffer_address_lo;
-	uint32_t session_context_buffer_address_hi;
-	uint32_t session_context_buffer_address_lo;
-	uint32_t pad[28];
+	uint32_t pad[30];
 };
 
 #define VCN_BLOCK_ENCODE_DISABLE_MASK 0x80
-- 
2.25.1

