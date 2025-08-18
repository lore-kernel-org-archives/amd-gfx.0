Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07FF5CA0ED1
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Aug 2025 09:43:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A3B710E416;
	Mon, 18 Aug 2025 09:43:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HJN2/rjk";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2053.outbound.protection.outlook.com [40.107.212.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 248E110E416
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Aug 2025 09:43:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TIf++mAs8CCB4plzcHoVjriUX8J26zt/haX2nhVJF993LffgG+NcH+dkaPVJTXwetL9cWlit5JQuAmtlWW1DXXJb3jVD7e6RIWEYsk3Yj/cX5NNWP+bYC58f/cYU8dIYWBdJJHWyj/gQEfLwrw/6lzNfXe096pSOK34SG7A7KGeTZsDEQj7WYMilhCe1LW9/VSm8mxiVMN0Y+3lvjVqSyEiEjJubzR9yFrLAB8JaiSgUWhLmwqnJVpcMHtq8pAKsHArGJz+U3B9g+Qn8Voyyxk1ZcGts+BQ/EifCd4gzaLnb6epd+GS79W9RSz43Xsa1qCK0QtqOmcvFfckIJExDBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OuCkcovhMyoLSMrR0dOYiwhyRL8cx7gTTpou7eZ7C7U=;
 b=GEq3So3wpljRVlxRPhTOZPlCTXpHySxR9GC2mlQ69C8sKfkLORj6FdEm+gRxLjVkEJnOQ3DU87Du4cpYRtMCrYCFXPHMQO6tOSc+ujlNjvtsga0eVOhDSKpaOfkmwL/dvpShHKJ6V0Agpimh0KcL/5A0shVj4stW0yDLvsOtu5rnRyLrpe1UFz0cp7Veuaw1HPl++POlcDoY6aan5MMkqHDKsKaFYwQ4HvBeKn+v9En/DBIvH5QD4u+rhS1N+9vwKgIQBtDKmxyqApZxWb3OzAtXpxzStdshW73b+OpyOXDPT1z8RN0SfypuboarRqp1yrODvtO+mRrNw3iiJwYOXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OuCkcovhMyoLSMrR0dOYiwhyRL8cx7gTTpou7eZ7C7U=;
 b=HJN2/rjkxJwbPzvNvg199Vu5U7MxVh95gfKUek2PFkUx1RjBikR+2cl6H1Sv94P+dRyFvZVYP/Cv3YsfGcJS3/Gz36HGJYcv4exkuKInwebl6Ui0hZoWkA2crsDQjG+rEfsMssKe0G/nRx4dXhDIOvskdaMkCRMrOTbgPNSQQDI=
Received: from BL1PR13CA0127.namprd13.prod.outlook.com (2603:10b6:208:2bb::12)
 by BN3PR12MB9593.namprd12.prod.outlook.com (2603:10b6:408:2cb::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 09:43:10 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:208:2bb:cafe::6a) by BL1PR13CA0127.outlook.office365.com
 (2603:10b6:208:2bb::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.12 via Frontend Transport; Mon,
 18 Aug 2025 09:43:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Mon, 18 Aug 2025 09:43:08 +0000
Received: from work.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Aug
 2025 04:43:07 -0500
From: David Rosca <david.rosca@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David Rosca <david.rosca@amd.com>
Subject: [PATCH 1/2] drm/amdgpu/vcn4: Fix IB parsing with multiple engine info
 packages
Date: Mon, 18 Aug 2025 11:42:53 +0200
Message-ID: <20250818094253.10105-2-david.rosca@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|BN3PR12MB9593:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cec5f66-fae5-4b0a-9b08-08ddde3ba3d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PCEgJc6w03qjwtOJxjpuiX0vpj4Xjst2H0NguYU/fYUzObLm9l/wb3U7IK9U?=
 =?us-ascii?Q?1+rmEfJsYlIpmQ4YrbHlAhT4COw1d/4qwK3R+uLvTIUOQJ63UOgsGaNYqE/p?=
 =?us-ascii?Q?m2C10uv8688BHDngsOzWRELKRLQQqDCi1D0Qd/OwxhsM96Pv8NS3khNkRoIB?=
 =?us-ascii?Q?JSAv62yh430+fAQEErDpCwCXnXcKBKI4ey3wqrnrwAhoe8VU3yy9oQGAYgvz?=
 =?us-ascii?Q?oCRoXKLikyFGF6gkaTaKkgqJJOEoHKRv4oXxDE9ajHTMatwSNnmw3KETwa22?=
 =?us-ascii?Q?gOzfPshlo7NTishpvBGn35Zzd/sC5R+PRQBYx28zNBDnvT3LivJjIhW9eWr3?=
 =?us-ascii?Q?Ad+f5P/T4/gqtDxRYnsnKvqf+SwoVaiG8ViLzyfanZTjhE7H2OczKVhHbp22?=
 =?us-ascii?Q?w6Ax81cfG/4mQu7wmYG6DWVKazDKzEHwLpRrVq/kr2XGXzYz+deGHPvd1iHG?=
 =?us-ascii?Q?IcUyJ4XNlJjQANs7WDKdskz0dMRtjXBAw+Mat3Fw/to4vMryF7VA9c76djK6?=
 =?us-ascii?Q?VxTkS+vy8guYYJBNWEV299wcncaDU6g4TtPWJzT3DZyg2C3Ow26Uk+thVet4?=
 =?us-ascii?Q?jSMj1EvyNez17qKaYHABk2/H7giMOJAeOtF46hDT0WXdFBWBjH0+j19kHsH0?=
 =?us-ascii?Q?zXDG0NAOdsnc+bFnkg/Ppq+aCkv7Q5EzLTa27ADNqqOYc3+bSimhhc1HSYvz?=
 =?us-ascii?Q?Cs4echjM3DxwLLZ3l5e5y7oRPFW3B+ebJKbAG8TlRApaS7mJQ1537EppIUi0?=
 =?us-ascii?Q?x3KWn7MidW4OmvkN08a/epK+c4A+ULGIHpU2of9RIm2ZSFBDpm/qjk7cPD+b?=
 =?us-ascii?Q?a+7PUiZhzpZ+5dKedUrzU2KuEZ1l9bTsnQCUQbRJje78pt93h4uS+C/GhsrV?=
 =?us-ascii?Q?+sri4HstyZVrLz/juC1aRteEcRM7pJtuODkUedaJNZgIbkxROvnX2nXnUUwt?=
 =?us-ascii?Q?wod1b0Pehcx+mmmqx7IlQ5y/vscY8HT/mEWhf7rqyuxzpNafC69TmbnK6rHn?=
 =?us-ascii?Q?KWT3PDVvDUt/fRUwQjV78K8k+xTOFH66YfrOUogDVHG6sVCktdOhF6/n/3tD?=
 =?us-ascii?Q?aIRAiluU1Q6WdsheocPVdKqWrfjZIyjqi6jHjHlBLVNFQl4vhEWbbmY5VBom?=
 =?us-ascii?Q?bAmAoZgiYf+Xbok7hbmIlbkFAeqTPiqTZ4MmyfBmzCkkXwcjouixY5Wad9KQ?=
 =?us-ascii?Q?wkcHfmDVrIwq2d0ssqH+x2N2AUQTLjambGWoa4ucl4zQgGkZcEQf7nzRbVHm?=
 =?us-ascii?Q?b/wFJ4GHeTr3zdjqeFFCruApWRohRpU04rFhV2mw0lvM79X8nk41Q4hS0fK5?=
 =?us-ascii?Q?Eokq3+TVd/dgkmxAOAMB3yyjYSLM5IOZO+CG/V0VhVlnZcoBGn7RoOy4wSr3?=
 =?us-ascii?Q?704+Jv0HOYz6bGiFCWpYjj3+ho3LuG4P9VZjlPutFtUWOgGhgywWSxKW2yek?=
 =?us-ascii?Q?WrDgA+fB2khJXbHb4KyjUCiWfrX7cOzCmdJKJiP3SqzcbdwR7rvIOWKXRsaJ?=
 =?us-ascii?Q?0omyqynlGXnOYiW/aeIsvzKDT2gZ8L9bpEXk?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 09:43:08.8843 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cec5f66-fae5-4b0a-9b08-08ddde3ba3d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9593
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

There can be multiple engine info packages in one IB and the first one
may be common engine, not decode/encode.
We need to parse the entire IB instead of stopping after finding first
engine info.

Signed-off-by: David Rosca <david.rosca@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 52 +++++++++++----------------
 1 file changed, 21 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 1785786a72f8..23b98f011879 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1904,22 +1904,16 @@ static int vcn_v4_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
 
 #define RADEON_VCN_ENGINE_TYPE_ENCODE			(0x00000002)
 #define RADEON_VCN_ENGINE_TYPE_DECODE			(0x00000003)
-
 #define RADEON_VCN_ENGINE_INFO				(0x30000001)
-#define RADEON_VCN_ENGINE_INFO_MAX_OFFSET		16
-
 #define RENCODE_ENCODE_STANDARD_AV1			2
 #define RENCODE_IB_PARAM_SESSION_INIT			0x00000003
-#define RENCODE_IB_PARAM_SESSION_INIT_MAX_OFFSET	64
 
-/* return the offset in ib if id is found, -1 otherwise
- * to speed up the searching we only search upto max_offset
- */
-static int vcn_v4_0_enc_find_ib_param(struct amdgpu_ib *ib, uint32_t id, int max_offset)
+/* return the offset in ib if id is found, -1 otherwise */
+static int vcn_v4_0_enc_find_ib_param(struct amdgpu_ib *ib, uint32_t id, int start)
 {
 	int i;
 
-	for (i = 0; i < ib->length_dw && i < max_offset && ib->ptr[i] >= 8; i += ib->ptr[i]/4) {
+	for (i = start; i < ib->length_dw && ib->ptr[i] >= 8; i += ib->ptr[i]/4) {
 		if (ib->ptr[i + 1] == id)
 			return i;
 	}
@@ -1934,33 +1928,29 @@ static int vcn_v4_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
 	struct amdgpu_vcn_decode_buffer *decode_buffer;
 	uint64_t addr;
 	uint32_t val;
-	int idx;
+	int idx = 0;
 
 	/* The first instance can decode anything */
 	if (!ring->me)
 		return 0;
 
-	/* RADEON_VCN_ENGINE_INFO is at the top of ib block */
-	idx = vcn_v4_0_enc_find_ib_param(ib, RADEON_VCN_ENGINE_INFO,
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
-		return vcn_v4_0_dec_msg(p, job, addr);
-	} else if (val == RADEON_VCN_ENGINE_TYPE_ENCODE) {
-		idx = vcn_v4_0_enc_find_ib_param(ib, RENCODE_IB_PARAM_SESSION_INIT,
-			RENCODE_IB_PARAM_SESSION_INIT_MAX_OFFSET);
-		if (idx >= 0 && ib->ptr[idx + 2] == RENCODE_ENCODE_STANDARD_AV1)
-			return vcn_v4_0_limit_sched(p, job);
+	while ((idx = vcn_v4_0_enc_find_ib_param(ib, RADEON_VCN_ENGINE_INFO, idx)) >= 0) {
+		val = amdgpu_ib_get_value(ib, idx + 2); /* RADEON_VCN_ENGINE_TYPE */
+		if (val == RADEON_VCN_ENGINE_TYPE_DECODE) {
+			decode_buffer = (struct amdgpu_vcn_decode_buffer *)&ib->ptr[idx + 6];
+
+			if (!(decode_buffer->valid_buf_flag & 0x1))
+				return 0;
+
+			addr = ((u64)decode_buffer->msg_buffer_address_hi) << 32 |
+				decode_buffer->msg_buffer_address_lo;
+			return vcn_v4_0_dec_msg(p, job, addr);
+		} else if (val == RADEON_VCN_ENGINE_TYPE_ENCODE) {
+			idx = vcn_v4_0_enc_find_ib_param(ib, RENCODE_IB_PARAM_SESSION_INIT, idx);
+			if (idx >= 0 && ib->ptr[idx + 2] == RENCODE_ENCODE_STANDARD_AV1)
+				return vcn_v4_0_limit_sched(p, job);
+		}
+		idx += ib->ptr[idx] / 4;
 	}
 	return 0;
 }
-- 
2.43.0

