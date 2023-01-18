Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D434C38147
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Jan 2023 17:51:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFBBE10E7CE;
	Wed, 18 Jan 2023 17:51:39 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4C5510E7CE
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Jan 2023 17:51:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SFqZeID85y30wbZSDYc3FFZpWfhyIgxcgVKgGllT9Ptka+boJZVrUSmAQrBs1jhgMk3qMAIK9V2sZohJEZE6eLLqY1Q/+2ZNddOcKHqK/hwZXsYE+/myZBKXF0DEFHhbpE54Lna6EsjBA/Q/rSCuBwLf+w4dhztLedrASonE6pDtltJHIqESTOObJ7I2XhEobffWNV3NoPsCVjI9VpG87yWMTG95GqF7X5hsKvljlFyWE0S0n3zUQK8KDFAJyoP4dsvLFkr0QCCFQOWtBtyqHCNFbNrWPkMrgnlVcICJCgqwe5wnqcaWiYFK4rppXZ/6a2aNpWN56IqFhY3fTFT0Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RM+uT5w7InDtSWv+f68C0U2AFgNHNd/aEBJ1AtDexlw=;
 b=GMTf64Sp3PlySFk61LmnMlnX1nt9ZCWDEwgcnEK0YzPMjJVsrzSC8vGF3WE+52Sphql5SrUn9HV0VxoCwqYnqSkQ3/12bbaSH/T2uYxH/ffL/fZYSpJeHzmJTwAuJekH+2dA314yFGjDiCp6QBaEj3XyrP3Ox4LhDDfrRsKblNHxd8cyCZhmrZ6jcMJ/o2xyPS7gG8PsCiEgc7qg0ZPCD3/ICFQwotioc5LNVpfntD3MRtoOtWJY7XDa52w40C/ra9sEaIl6Af023/Zp9Q9zv6XMdsVfn8DXk8J6t8pqVr048ulTqGbYfNG01ufQo5vOflBhjTkF+Gzyd8meSaBNxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RM+uT5w7InDtSWv+f68C0U2AFgNHNd/aEBJ1AtDexlw=;
 b=14/ZUppRNWNncr2UynPHFbQ1c6zeb7x9laqRFejFSpBVCYTSFcXQGWgYmibr3yZT9eoPe6C7gYHBPOpMXG4rPrue5Cp7iGwgH2COvFBkAj6Nm6bSLc+QltXP9APgWTH2xa8jLa5pL1fH7URV8tS74jjllkSVLULQr0xVQFKSwn8=
Received: from BN9PR03CA0485.namprd03.prod.outlook.com (2603:10b6:408:130::10)
 by CY8PR12MB7658.namprd12.prod.outlook.com (2603:10b6:930:9e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Wed, 18 Jan
 2023 17:51:35 +0000
Received: from BN8NAM11FT101.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::c0) by BN9PR03CA0485.outlook.office365.com
 (2603:10b6:408:130::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Wed, 18 Jan 2023 17:51:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT101.mail.protection.outlook.com (10.13.177.126) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Wed, 18 Jan 2023 17:51:34 +0000
Received: from david-X399-DESIGNARE-EX.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 18 Jan 2023 11:51:34 -0600
From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Christian.Koenig@amd.com>
Subject: [PATCH] drm/amdgpu: limit AV1 to the first instance on VCN4 encode
Date: Wed, 18 Jan 2023 12:51:19 -0500
Message-ID: <20230118175119.202898-1-David.Wu3@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT101:EE_|CY8PR12MB7658:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e63462e-06c5-47d8-8519-08daf97ca3ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nmoyG4Z6ivSAFPMPSvMzdCHIToa2Iqcs6+vOG2emtbYk01MlCUVt7pKsp2b3rO3RlRcQF9IpzFAVkR5XfDYTYK2nd+pVVytsspQpck1yIzOHQ6nbms14uSsPhF8yFbTgHE4BSgu9kJAYCYiDUosTKPaaaxm1WR8ZVw5nLyg2GwrUMpgX3PKNumh8HFPoykIMVUYWN0jLhCgseyIx0D+cV97n7IAC3OnRFSFWBXVkxjDAZoagznEy3tHE3xxbpeKAL+iLy/v7gpkP3s1fEURmmld39W/hi8jPA5uboHVWQ1ZXmJUgTrxoNFYPRZ3EXRSISyQriZm+DDoceBLkZwPPE4/mDdLC0qMcJ5+rLrTWpAFGJ854aAtLKWGKCc3SOeEqxh6aNWvkVn9dDChm2+nlrvXy/y2jqOqv3T4/BpUvJZrozpue/Wv9rtItYe4EnxIkSL5PfzJlKXourriXtB7vLoM1n1hiFd+bfnUEA7cVj/Ps9kIYcfBf8yHrmyvHPVjZQ3x/4YFWk7f/ntEMh4WxC0IBtkahsuCMdL2d2YNA9VGzfNf54ImORjxRa/qz7xJAwJO4ZwbAiD+JVDse2F0/wozrjvGA4mdajdTSmz2EI/ABxN/DV92Q4HN8rxC9DClltAEwhK9fDVBgXIyxiaLzTi4XCId7EWX1S79Z0cEsATOufk7LqeIhXD/yUgLsYMkkh3wFBLo2Fnv8/M1L8XTNRGvivlxv3cMSsNY3m709lzY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(136003)(346002)(376002)(451199015)(36840700001)(40470700004)(46966006)(6666004)(36860700001)(1076003)(478600001)(186003)(26005)(7696005)(16526019)(316002)(6636002)(110136005)(54906003)(2616005)(40460700003)(4326008)(8676002)(70206006)(36756003)(336012)(70586007)(41300700001)(47076005)(426003)(5660300002)(82310400005)(8936002)(83380400001)(2906002)(40480700001)(82740400003)(86362001)(81166007)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 17:51:34.7391 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e63462e-06c5-47d8-8519-08daf97ca3ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT101.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7658
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
Cc: alexander.deucher@amd.com, ruijing.dong@amd.com, leo.liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

AV1 is only supported on the first instance.
Added vcn_v4_0_enc_find_ib_param() to help search for an IB param.

Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
Reviewed-by: Ruijing Dong <ruijing.dong@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 62 ++++++++++++++++++++-------
 1 file changed, 46 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index a79b6088374b..7ab719221ae5 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1706,7 +1706,7 @@ static int vcn_v4_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
 
 		create = ptr + addr + offset - start;
 
-		/* H246, HEVC and VP9 can run on any instance */
+		/* H264, HEVC and VP9 can run on any instance */
 		if (create[0] == 0x7 || create[0] == 0x10 || create[0] == 0x11)
 			continue;
 
@@ -1720,7 +1720,29 @@ static int vcn_v4_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
 	return r;
 }
 
-#define RADEON_VCN_ENGINE_TYPE_DECODE                                 (0x00000003)
+#define RADEON_VCN_ENGINE_TYPE_ENCODE			(0x00000002)
+#define RADEON_VCN_ENGINE_TYPE_DECODE			(0x00000003)
+
+#define RADEON_VCN_ENGINE_INFO				(0x30000001)
+#define RADEON_VCN_ENGINE_INFO_MAX_OFFSET		16
+
+#define RENCODE_ENCODE_STANDARD_AV1			2
+#define RENCODE_IB_PARAM_SESSION_INIT			0x00000003
+#define RENCODE_IB_PARAM_SESSION_INIT_MAX_OFFSET	64
+
+/* return the offset in ib if id is found, -1 otherwise
+ * to speed up the searching we only search upto max_offset
+ */
+static int vcn_v4_0_enc_find_ib_param(struct amdgpu_ib *ib, uint32_t id, int max_offset)
+{
+	int i;
+
+	for (i = 0; i < ib->length_dw && i < max_offset && ib->ptr[i] >= 8; i += ib->ptr[i]/4) {
+		if (ib->ptr[i + 1] == id)
+			return i;
+	}
+	return -1;
+}
 
 static int vcn_v4_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
 					   struct amdgpu_job *job,
@@ -1730,27 +1752,35 @@ static int vcn_v4_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
 	struct amdgpu_vcn_decode_buffer *decode_buffer;
 	uint64_t addr;
 	uint32_t val;
+	int idx;
 
 	/* The first instance can decode anything */
 	if (!ring->me)
 		return 0;
 
-	/* unified queue ib header has 8 double words. */
-	if (ib->length_dw < 8)
-		return 0;
-
-	val = amdgpu_ib_get_value(ib, 6); //RADEON_VCN_ENGINE_TYPE
-	if (val != RADEON_VCN_ENGINE_TYPE_DECODE)
-		return 0;
-
-	decode_buffer = (struct amdgpu_vcn_decode_buffer *)&ib->ptr[10];
-
-	if (!(decode_buffer->valid_buf_flag  & 0x1))
+	/* RADEON_VCN_ENGINE_INFO is at the top of ib block */
+	idx = vcn_v4_0_enc_find_ib_param(ib, RADEON_VCN_ENGINE_INFO,
+			RADEON_VCN_ENGINE_INFO_MAX_OFFSET);
+	if (idx < 0) /* engine info is missing */
 		return 0;
 
-	addr = ((u64)decode_buffer->msg_buffer_address_hi) << 32 |
-		decode_buffer->msg_buffer_address_lo;
-	return vcn_v4_0_dec_msg(p, job, addr);
+	val = amdgpu_ib_get_value(ib, idx + 2); /* RADEON_VCN_ENGINE_TYPE */
+	if (val == RADEON_VCN_ENGINE_TYPE_DECODE) {
+		decode_buffer = (struct amdgpu_vcn_decode_buffer *)&ib->ptr[idx + 6];
+
+		if (!(decode_buffer->valid_buf_flag  & 0x1))
+			return 0;
+
+		addr = ((u64)decode_buffer->msg_buffer_address_hi) << 32 |
+			decode_buffer->msg_buffer_address_lo;
+		return vcn_v4_0_dec_msg(p, job, addr);
+	} else if (val == RADEON_VCN_ENGINE_TYPE_ENCODE) {
+		idx = vcn_v4_0_enc_find_ib_param(ib, RENCODE_IB_PARAM_SESSION_INIT,
+			RENCODE_IB_PARAM_SESSION_INIT_MAX_OFFSET);
+		if (idx >= 0 && ib->ptr[idx + 2] == RENCODE_ENCODE_STANDARD_AV1)
+			return vcn_v4_0_limit_sched(p, job);
+	}
+	return 0;
 }
 
 static const struct amdgpu_ring_funcs vcn_v4_0_unified_ring_vm_funcs = {
-- 
2.34.1

