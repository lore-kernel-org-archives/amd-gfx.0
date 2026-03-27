Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D3DB10ED664
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2026 13:05:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B336510ED81;
	Fri, 27 Mar 2026 13:05:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ED6OpOHi";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010061.outbound.protection.outlook.com
 [52.101.193.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E01F210ED42
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Mar 2026 13:04:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ugKOJrzn0cV+338fAlex53JOw2psnApGTFAcMPYroWPI6Pu1z7g9fK1UdpG80pX3cdPLqWxKqHAQFbVAvwWITDAPr3fULKAB3kzJ/1RS3dZEvfOrH5rqJbr5Sl/BVER6TurNhS39b6PzwwWqgEcoOYwRSiorCC1jFOYwr/4N6lOjqgwZh3qqY6m3BwI9ig+tjqf3Yr3+2+nsuwHITXSX5s2HKhV7izUPOowIpdBLMS51m/kD/rg7K3FbyBmyAMsj6khFDAks9pL2QDH3YOyExciPTtZZDM1kI1YaB2MzFhW8XUg/5S5zY92h/tmU6bP93kqsYVmXdWeGMCmHl7VsHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jx1LXKuViQR+cDyoZOHFO91YMsvRohjMOn7saVzIHnA=;
 b=j9vpYYe2Jwc8nmEFDqffvab5TUKet9rdFmppnqKSO45Dbd6DvvssLfp9i+V19TkWaWKxFywUe3NdSrwbrlP3BSRWHorkx4N91WL9q5KtoXwHC0tMUvEPpo+Fpif4eT7dNJvtmybHDwjP4kzAFhZr2dh2JLvFtjtRoI2DORSRkijTwCNuHsro1DaJZ+VgCToHUQ8/DL+MIKw0U8lfYcZAFAWhCl6vfMmHGwnOJqUQFCst+a9UopWyjLRnErrBef9DHXcNqHpo8AxvfuhOZ2iTwbYngh07eEg8vDIEJP5QppMsx4OsYm1XzY0IIxzDe0aV79Uqwy2E/ZHU+kSeeOJL4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jx1LXKuViQR+cDyoZOHFO91YMsvRohjMOn7saVzIHnA=;
 b=ED6OpOHiEuxpuuv5icKY2Ugr/iQytYtKefSrgZ+DLsq0swsLW4daK1bSR1BckR01XHafCVfBL2HUBcygrng4CTSJ94a2TQiuPkeJWkJ/8awNbr+DUoNb8CchrLcTUH0ytbT0zV8hnDEsqRwRsgtfvY/6Z4cIEEHCyDLRcrSfD+Y=
Received: from BY1P220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::13)
 by SJ0PR12MB5636.namprd12.prod.outlook.com (2603:10b6:a03:42b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Fri, 27 Mar
 2026 13:04:45 +0000
Received: from SJ1PEPF0000231B.namprd03.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::4) by BY1P220CA0016.outlook.office365.com
 (2603:10b6:a03:5c3::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.23 via Frontend Transport; Fri,
 27 Mar 2026 13:04:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231B.mail.protection.outlook.com (10.167.242.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Fri, 27 Mar 2026 13:04:45 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 27 Mar
 2026 08:04:44 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 27 Mar
 2026 06:04:44 -0700
Received: from bencheng-dev (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 27 Mar 2026 08:04:43 -0500
From: Benjamin Cheng <benjamin.cheng@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (Ming
 Qiang) Wu" <David.Wu3@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <leo.liu@amd.com>, Ruijing Dong <ruijing.dong@amd.com>, "Benjamin
 Cheng" <benjamin.cheng@amd.com>
Subject: [PATCH v3 2/4] drm/amdgpu/vcn3: Prevent OOB reads when parsing dec msg
Date: Fri, 27 Mar 2026 09:04:23 -0400
Message-ID: <20260327130425.474166-2-benjamin.cheng@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327130425.474166-1-benjamin.cheng@amd.com>
References: <20260327130425.474166-1-benjamin.cheng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231B:EE_|SJ0PR12MB5636:EE_
X-MS-Office365-Filtering-Correlation-Id: 67f62c89-9482-48d8-8288-08de8c016b17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: FHFHg9ZH9lG4okG7NWKzFiX8+1Qi6SUG1MnI4eTSxq+6Ut3o2elmDVoaOAbggUjVhH4cEmO4sUxhxQDc1HLVnkbtiK/iF+5x1+UEI1G2N5G7hgNAf8c8r9+lEd5ep8L7yhWPTbQKhEatWPAsEAEto+GEdJfX/3DEldJ04lpf3Fh5/mJ8k+Zyu1r5FBPzPUpv1CaWXI/oAdWw2rVgh9yPzKlvwWw+AHIIZ6iONkaLfKUgCa35ZkuS4Qg9KohIVwS8x3Q+H5NKt76hGs0NvZ5gv4JBb/BawoER9GwHKZiUJOD5rQ9VeBBHn9TyM3j2FqQN6qVatFC84kBiHGbR7APFTzhqU2SBDSvtFFeMJmvHOIsBXpJ1Qb40RH5OBbRLV+i5CGTBMs78FoNMgb6pNQmQmKtjwSGPDtp595V+JPORxkS01N/ULppomMOi+vrxOCyNFdDzu8XeCPWHwwZfsERKGWfD3PJNiW6xcK4+FQGAyTNfytnTeM4iPBKM4/rsBpURgMTIaRHk7LeFg5u06itn8DMuIA0GM9wTzWmH6C8+/ezCJbRrvY4szxDO+I/07XrtHazfs1lYGvpfV9exFhz67rjBaUXRpikDbViZjY+jMjTK0Re/agxCLfpOVBKQmKKJZ5/vNpOvEUDM+pDMHoORJ7BBNEatSkZDhAqrJ4pX07cfYB6A583wWw29X0ZcEbIH+wn8ozZk0EjHGH9f5bmkn79OfcMLyQ8THK4iRlMmnjIMCC854QTKrAFphCdqF51S
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: U2l3RZElRqTPKRpHzwBFIUUm5qigPOXQLzKob0EHDOvlJKU1Z+z4cSAO1GV/PfENawJMUC6e9DX1iFyxf+snLeCDu/k0X71LwoMTp+pb1Sv7in4xPJrq96udk8nBrQ/nTASqFXOCE6NUHFJO/At6WTAclgngPRxkz27JKMlyBl8JRupeOS/HIo/sg8RReydYEX1Ofnxmqi1wPPmceQQA9UtS3wKiKUAjszgATCIaG8uTmn5iA19c5qJSK0FTAYnuncpE4/vODu1xsBTuA2l680Jv98mUhT4DSKjmFZ1XEBvmBM7GcZ1bwn9KyIVqOibuEw1vc/TS0oR6fm6SL1hBqPEQs7/tMZaqxXXL4d2TenJhWKdOfj9r1mADkBMVp2ig3u9+K0V6S6NzeTZAGtdhfmRV01xYVu2/M6GB0WMxwE+a4QivXQ6fE+/ZsnzstGJy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 13:04:45.1658 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67f62c89-9482-48d8-8288-08de8c016b17
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5636
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

Check bounds against the end of the BO whenever we access the msg.

Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 02d5c5af65f2..6fb4fcdbba4f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -1909,7 +1909,7 @@ static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
 	struct ttm_operation_ctx ctx = { false, false };
 	struct amdgpu_device *adev = p->adev;
 	struct amdgpu_bo_va_mapping *map;
-	uint32_t *msg, num_buffers;
+	uint32_t *msg, num_buffers, len_dw;
 	struct amdgpu_bo *bo;
 	uint64_t start, end;
 	unsigned int i;
@@ -1930,6 +1930,11 @@ static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
 		return -EINVAL;
 	}
 
+	if (end - addr < 16) {
+		DRM_ERROR("VCN messages must be at least 4 DWORDs!\n");
+		return -EINVAL;
+	}
+
 	bo->flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
 	amdgpu_bo_placement_from_domain(bo, bo->allowed_domains);
 	r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
@@ -1946,8 +1951,8 @@ static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
 
 	msg = ptr + addr - start;
 
-	/* Check length */
 	if (msg[1] > end - addr) {
+		DRM_ERROR("VCN message header does not fit in BO!\n");
 		r = -EINVAL;
 		goto out;
 	}
@@ -1955,7 +1960,16 @@ static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
 	if (msg[3] != RDECODE_MSG_CREATE)
 		goto out;
 
+	len_dw = msg[1] / 4;
 	num_buffers = msg[2];
+
+	/* Verify that all indices fit within the claimed length. Each index is 4 DWORDs */
+	if (num_buffers > len_dw || 6 + num_buffers * 4 > len_dw) {
+		DRM_ERROR("VCN message has too many buffers!\n");
+		r = -EINVAL;
+		goto out;
+	}
+
 	for (i = 0, msg = &msg[6]; i < num_buffers; ++i, msg += 4) {
 		uint32_t offset, size, *create;
 
@@ -1965,14 +1979,15 @@ static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
 		offset = msg[1];
 		size = msg[2];
 
-		if (offset + size > end) {
+		if (size < 4 || offset + size > end - addr) {
+			DRM_ERROR("VCN message buffer exceeds BO bounds!\n");
 			r = -EINVAL;
 			goto out;
 		}
 
 		create = ptr + addr + offset - start;
 
-		/* H246, HEVC and VP9 can run on any instance */
+		/* H264, HEVC and VP9 can run on any instance */
 		if (create[0] == 0x7 || create[0] == 0x10 || create[0] == 0x11)
 			continue;
 
-- 
2.53.0

