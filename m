Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C863EB64DD
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jul 2023 12:49:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A09AE10E48C;
	Thu,  6 Jul 2023 12:49:27 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2060.outbound.protection.outlook.com [40.107.212.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 252AA10E484
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jul 2023 12:49:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=efJytAb5ADpgxBwQNaPQaxbPbAMxg7Yrf4oQpxWY5E/JryQ//mBvn0lVVvvuTqWxoq7+DvbwU4rLHBRF87vjst+QSOg1sbVGOEB3//HIeIPz0FImqtacCGs1lgLqKYdzhVoz3/+0vm1+bcWMpEj0dHoyPucJKgX+ioFBU21Pnx2j1Xh7Ocuc0iABCUy2b34DXazMKHR9sKKgpf+eBx4cK94Ozc10GQgJ/0OrkyzNCg+fk3lJ/MgUETNif5lSCl+OhRrCnGJhmjd7wgWFif4z9yL2mxfAf1AAFEljIXsdyabqkZrT++/brXFqbcucS2pOVcwuabVd7krym6Y87D3xAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cg0s3EEV0KuTjyZro1XdVTVvClQ6HfPSR6IZfu0hbw0=;
 b=H+OCKQOVs0v2f+aNCeUH2y2oR/rIDecBX+QI5LokmlQXqZF1SJoTiZu5tAcU/y0KlZh7sqMh4d2XISW6SaqGgeV+D0tLaSo3qpdBrQ0vHETrm4MVeYojTf2kp6dr4BBf53XtWkahixgwLnz+3eRSjAJkhmteLrKS5chs9r4MryGbxOYNfxYjaO4y0zswjFVIedEVdxqQvhp3vh4oM55oxkmhoapkuIU2CGZFjJ9uA4RrZqvB5mxFx5m7EZsk6eIYG98hviiBkrTMS4WXmsrN/y0FvflizzlZtkNz7g9yZdnYD09CTewuyWuKrqYdM6FlVnYQKc7d+7bx+jiY7eYvAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cg0s3EEV0KuTjyZro1XdVTVvClQ6HfPSR6IZfu0hbw0=;
 b=P6UIaNJTkQn3eJR+Yy7tft1QyOvPzdQXkwmNu5lW+EceNH/bWJUhUlE8s4to2z81ozFaBJeNmWSCVQAp1I/irtS9c03IXfFthKqinusYmoL8uUeuDDyIGDFPKxD335QCs6GbQEbMP7bqtii12Piqpj/gmSmETMvF6HM6wIyGk6I=
Received: from BY5PR17CA0051.namprd17.prod.outlook.com (2603:10b6:a03:167::28)
 by MW4PR12MB6900.namprd12.prod.outlook.com (2603:10b6:303:20e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 12:49:22 +0000
Received: from DM6NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:167:cafe::a1) by BY5PR17CA0051.outlook.office365.com
 (2603:10b6:a03:167::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.18 via Frontend
 Transport; Thu, 6 Jul 2023 12:49:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT091.mail.protection.outlook.com (10.13.173.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.45 via Frontend Transport; Thu, 6 Jul 2023 12:49:20 +0000
Received: from x570-ryzen9-5900x.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 6 Jul 2023 07:49:18 -0500
From: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
To: <saleemkhan.jamadar@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <christian.koenig@amd.com>, <leo.liu@amd.com>,
 <veerabadhran.gopalakrishnan@amd.com>, <sathishkumar.sundararaju@amd.com>
Subject: [PATCH v3] drm/amdgpu:update kernel vcn ring test
Date: Thu, 6 Jul 2023 18:19:01 +0530
Message-ID: <20230706124901.3638313-1-saleemkhan.jamadar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT091:EE_|MW4PR12MB6900:EE_
X-MS-Office365-Filtering-Correlation-Id: ede4d68f-3f74-4ca9-d03c-08db7e1f6b1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K2pZDfaBPbANkihq2+sZSCpa8BPjwHCU+0uiHtrKzezUy3bllQYnqXTp4dFexVOQQSFK0Mfb8sYZDEtMPeO2WbL0ckgHaN31SduppbQPE8wK3WZGQzGGBxq3uofm1eTBpqvLe3v/6U6CNQR+S+gDKu6O0odPncsHbF+LKIEmS27aO7UwwR3o9n5ReZkMqmAtHsxrCYn1OoifdQqlyk7FrV9f2o5+gJ+DeZhf2wItYxCd6gJ3y8P6MO2/VO1PioR1t/aSxWWeTAOt5u/KTfY942cOANO+Sp84GWfIdJ6ZctK8fKq8sJeXKkZ3RnQoQD9cgg11Ao48+Etvs4ipEZVQWiNGgHDRXdibtsNVHQsbwqzMYYu3c/oBtbCyJ2PeVee/I0yQGqZLnnQRw5eIl/i1DK0Gkd/tpwWS+V9eHwj8Nl/pO9ptgwittuJn3IzgbYXuFXuUm5nyb6UyfCdVB9PpBErwPCWyZjKGBMlCwRb4GElq/iTAUWJcif+6B2pj+lfykF6kUcEPYn4DeiWKryRxKnzH3t/FX+u3hC0clUqjyNnIWxfaygfQ+U3H+KrLTfXemi6nepEBNZqWyHR5TnsGvvUYe0/GR9HTDFPebXkzTv/a2YRSDhjn0VDbD/U83lOV72RCSHMnRnxeC3Qk9UDlkNaFRpljKCRS1Jh6tqhk7z+ALPBCrgdeM8k3IPhmxW8UCnw2y3SvMR8tqEFQC+FDVI4wCtyEUCInhj/Tx9Vgl50Hsp5xfe72FIsmJBzFEeJFiUMmvxPFFsEDo2OytDg/qQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(396003)(376002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(6666004)(7696005)(110136005)(478600001)(2616005)(36860700001)(426003)(40480700001)(86362001)(40460700003)(36756003)(83380400001)(6636002)(356005)(2906002)(82310400005)(47076005)(16526019)(186003)(1076003)(26005)(336012)(44832011)(316002)(81166007)(5660300002)(41300700001)(70586007)(70206006)(4326008)(8936002)(82740400003)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 12:49:20.8125 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ede4d68f-3f74-4ca9-d03c-08db7e1f6b1a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6900
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

v3 - indent and  v2 changes correction. (Christian)
v2 - put the buffer at the end of the IB (Christian)

Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
Acked-by: Leo Liu <leo.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 13 +++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  3 +++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 2d94f1b63bd6..15627fd94fbc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -573,7 +573,7 @@ static int amdgpu_vcn_dec_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
 	int r, i;
 
 	memset(ib, 0, sizeof(*ib));
-	r = amdgpu_ib_get(adev, NULL, AMDGPU_GPU_PAGE_SIZE * 2,
+	r = amdgpu_ib_get(adev, NULL, AMDGPU_GPU_PAGE_SIZE * 34,
 			AMDGPU_IB_POOL_DIRECT,
 			ib);
 	if (r)
@@ -608,7 +608,7 @@ static int amdgpu_vcn_dec_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
 	int r, i;
 
 	memset(ib, 0, sizeof(*ib));
-	r = amdgpu_ib_get(adev, NULL, AMDGPU_GPU_PAGE_SIZE * 2,
+	r = amdgpu_ib_get(adev, NULL, AMDGPU_GPU_PAGE_SIZE * 34,
 			AMDGPU_IB_POOL_DIRECT,
 			ib);
 	if (r)
@@ -700,6 +700,7 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
 	struct amdgpu_job *job;
 	struct amdgpu_ib *ib;
 	uint64_t addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
+	uint64_t session_ctx_buf_gaddr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr + 8192);
 	bool sq = amdgpu_vcn_using_unified_queue(ring);
 	uint32_t *ib_checksum;
 	uint32_t ib_pack_in_dw;
@@ -730,6 +731,14 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
 	ib->length_dw += sizeof(struct amdgpu_vcn_decode_buffer) / 4;
 	memset(decode_buffer, 0, sizeof(struct amdgpu_vcn_decode_buffer));
 
+	if (session_ctx_buf_gaddr) {
+		decode_buffer->valid_buf_flag |=
+					cpu_to_le32(AMDGPU_VCN_CMD_FLAG_SESSION_CONTEXT_BUFFER);
+		decode_buffer->session_context_buffer_address_hi =
+							cpu_to_le32(session_ctx_buf_gaddr >> 32);
+		decode_buffer->session_context_buffer_address_lo =
+							cpu_to_le32(session_ctx_buf_gaddr);
+	}
 	decode_buffer->valid_buf_flag |= cpu_to_le32(AMDGPU_VCN_CMD_FLAG_MSG_BUFFER);
 	decode_buffer->msg_buffer_address_hi = cpu_to_le32(addr >> 32);
 	decode_buffer->msg_buffer_address_lo = cpu_to_le32(addr);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index f1397ef66fd7..06f9ee91a1e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -166,6 +166,7 @@
 
 #define AMDGPU_VCN_IB_FLAG_DECODE_BUFFER	0x00000001
 #define AMDGPU_VCN_CMD_FLAG_MSG_BUFFER		0x00000001
+#define AMDGPU_VCN_CMD_FLAG_SESSION_CONTEXT_BUFFER	0x00100000
 
 #define VCN_CODEC_DISABLE_MASK_AV1  (1 << 0)
 #define VCN_CODEC_DISABLE_MASK_VP9  (1 << 1)
@@ -357,6 +358,8 @@ struct amdgpu_vcn_decode_buffer {
 	uint32_t valid_buf_flag;
 	uint32_t msg_buffer_address_hi;
 	uint32_t msg_buffer_address_lo;
+	unsigned int session_context_buffer_address_hi;
+	unsigned int session_context_buffer_address_lo;
 	uint32_t pad[30];
 };
 
-- 
2.25.1

