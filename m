Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76E80FF8868
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2026 15:59:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFE4B10E7D4;
	Mon, 27 Apr 2026 15:59:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DLKHeYT2";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012043.outbound.protection.outlook.com [40.107.209.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D086810E7D4
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 15:59:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JE+Rde8QslC4e4BdKQ+rihRQ9AUJkIX5mje8gg1ypkX3QSnFGIRBE/Py6i05frAucYdkyhEi6retLBKmq/30/8q0KTuwBwKMx7BYj+/wzRs5/SjgDnntRmVManoLfZMO2qGuHlKiMNsNF4kWtE3BMPX/L8kzB61xk/rIc/+zyH0yuhxkEIDU9zyDL7cEEGMtq5B0GCGgvCosiNVEASBBY/U8n1pueStbhxKqfMgYu+dMpgRPTIX5qEba6d1eHIsafXcaVhdB4vIWHFn7T4xlR9FJyOtsVMdk82ZRx/fR3p1D6fQYdaDo8YLqroUUY1jkf7rCGDPc7c7DFV90YSKt5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KVjuMFtl8f/V5WJEAYl4oQcEY/SVNqnrGvgkQaMvn7k=;
 b=ab0xFbWhQ10gLmc0Hx5ufBVSSDxTMc95ut3UjAYscKlbO2FzVBejanh0D8tFjr9lRgiZoZYBzlT6qbQA0NypO448hKtYkvBcHwyihTX6Fo9EpE4DPFPo2Stw+poA6cMSg23LkpDWPNJFLzss9Lj7WS9pUJiM4GpbdKYmgMJCLqYNpRsDa9i6rCR3vSS8j1umHQMzj8WCW48X75IM8SBn6U4FjGkUJO+C+M0PipeDaaZHRr59qNp+LAX0BE9cR4UtYCeW8D+TROPvBjQ5JXAwCHOmNTptiSGEZTQSHCfXm8vRJDQjH1Asz6ed4n3jADe7Ag6364TVabHNmzvxTdApZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KVjuMFtl8f/V5WJEAYl4oQcEY/SVNqnrGvgkQaMvn7k=;
 b=DLKHeYT2GA6pys5iLs6TQkWXyrW0INtr8Tblcndb9TQDshk87MhLt67amGpAIkjCDMFMD7zJFLrtkWi7ExcD9LHIBVtENoHQjePm4XDBqoECMWQW8nNx7a/s9X+XiW6FZVrOa8hmTyNO8VcmsmKcm4o+/iWqz+ZzxF/0ZqTutHU=
Received: from MN2PR20CA0061.namprd20.prod.outlook.com (2603:10b6:208:235::30)
 by LV3PR12MB9401.namprd12.prod.outlook.com (2603:10b6:408:21c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Mon, 27 Apr
 2026 15:59:41 +0000
Received: from BN3PEPF0000B070.namprd21.prod.outlook.com
 (2603:10b6:208:235:cafe::f6) by MN2PR20CA0061.outlook.office365.com
 (2603:10b6:208:235::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 15:59:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B070.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.0 via Frontend Transport; Mon, 27 Apr 2026 15:59:40 +0000
Received: from yinjiyao-dev24.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 27 Apr
 2026 10:59:40 -0500
From: Yinjie Yao <yinjie.yao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <leo.liu@amd.com>, <ruijing.dong@amd.com>, Yinjie Yao <yinjie.yao@amd.com>
Subject: [PATCH v2 02/19] drm/amdgpu/vcn: set no_user_fence for VCN v2.5
 enc/dec rings
Date: Mon, 27 Apr 2026 11:58:40 -0400
Message-ID: <20260427155857.1370151-2-yinjie.yao@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427155857.1370151-1-yinjie.yao@amd.com>
References: <CADnq5_MPJG=S+B4kg6v64xD+8pDEbG5z1Q7j-2A+CfStmuejTg@mail.gmail.com>
 <20260427155857.1370151-1-yinjie.yao@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B070:EE_|LV3PR12MB9401:EE_
X-MS-Office365-Filtering-Correlation-Id: aada1ccb-9dc2-4ed8-25e9-08dea475fdcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: UYJY74WOiIdD30yhzLPDj+Sqy8jYVGFd5S5aKbCN4tyI9K5ThpU0/cFJAntgn2QxDlSd4DCViAAZqzmUugeGrPizBTSnDgpb8nGt5+AOxq9HfpwJCJogbrE9PAF+JjRXrYGGnoDMv/3dXY/f9M+33iQFT3YY5YEBLlsB8EUrmqJ99wd+KdYGDKrJntyxmpKg4L9lG2CYOlDICqMBxtxGqxgymPz8SRcowyuubhuhlBP7DZeODZiW446G97WM2iWnDm8bDcPziQF5kHWXUv6DZeByp2Q6Msun1p/0l9ybzYSV1EZmG6OgfOUawtzCwUpu/B6n4IS9KpLGet+I3uf2BTRu6S2UV4JFPb3xyPttgbGrXYmh/VZVz6jYBM1VnqvwbUuUQNI5isJ9Jrn1sCMENecn456r06s3bZk964OYtOCdzGbhrJD6DUDWcFkMpVbGkuSZlRydfpJ1EJayZaK393jJxGHm/X2Wr8eLWQ90SzSsCu7YKn4Vv06c1cGTCdJHzQtSoyBjbcd3T0WVmVlw3Ej+NZJAnO9Gjkt4jJiIloxrzRgR5zzg/y49L3ELdaoNY0oU81qzBwQMMe7RDV4cf5GAzGDwC52fHpu+yDjDF31xWtTW7zprYkQOHIZUdbu3sQ/AUBgYW5XxXE9vg3kYNGx/kVdDMI327/twSiiSCuX9weUfyC2w1xUc40t0CNfjbSzPy3TVmBBV9UFEjuHuU/XyCPISFpqFW2KL/qbXMNwSnQVBI+GmtFkIu/5/R6aSeC06m3LGMzr0VDIVyx28PQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ovJsfTTKu/ibKgG2EyxgoESxz+qz7Ogp/WQlZIWWCJUoqxX7Pm2N6dcRGiwnvmf5g6r6MnR65MZMWMFy+uwtOeoQfVDhUmw+ztkc7f4zOb7CIcLLoAEghS+s3RgNnaF8pMZkDZAfgVDQs3BJLaLvlB3lovXdD+jTwdd4fMFRxIzcPRq6SxCo+goxK68xn6nx1gLQ8v6EvRKPXXjMBd4FShpnKM0CcpMjU2+JdYn2aqhy0jIf3JKWZ3RiIO71VK7mk8iJUrjS+b0zfFbpV0LmgCz78LcpPbghR/dlw+Oo/s6miTNeWcvA1OK7D58klezWEOXhvkQl0B+NkrwSUuqfE2rtcafPO2pHxI3njuccQctkLVw16efr1WqrV6BesYHAH1pIjlY/pxT/9YY1nqapemP2fAVf2t9CegkI5VPgCq/QskwU0KssNSIeNFJZdlJd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 15:59:40.8974 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aada1ccb-9dc2-4ed8-25e9-08dea475fdcd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B070.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9401
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

VCN encoder and decoder rings do not support 64-bit user fence writes,
reject CS submissions with user fences.

Fixes: 28c17d72072b ("drm/amdgpu: add VCN2.5 basic supports")
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Yinjie Yao <yinjie.yao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 006a15451197..8b8184fe6764 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -1778,6 +1778,7 @@ static void vcn_v2_5_dec_ring_set_wptr(struct amdgpu_ring *ring)
 static const struct amdgpu_ring_funcs vcn_v2_5_dec_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_DEC,
 	.align_mask = 0xf,
+	.no_user_fence = true,
 	.secure_submission_supported = true,
 	.get_rptr = vcn_v2_5_dec_ring_get_rptr,
 	.get_wptr = vcn_v2_5_dec_ring_get_wptr,
@@ -1879,6 +1880,7 @@ static const struct amdgpu_ring_funcs vcn_v2_5_enc_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_ENC,
 	.align_mask = 0x3f,
 	.nop = VCN_ENC_CMD_NO_OP,
+	.no_user_fence = true,
 	.get_rptr = vcn_v2_5_enc_ring_get_rptr,
 	.get_wptr = vcn_v2_5_enc_ring_get_wptr,
 	.set_wptr = vcn_v2_5_enc_ring_set_wptr,
-- 
2.43.0

