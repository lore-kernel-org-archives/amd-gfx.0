Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 212ACFF8860
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2026 15:59:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 830F410E7D5;
	Mon, 27 Apr 2026 15:59:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pg01mjf4";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010066.outbound.protection.outlook.com [52.101.85.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADA2310E7D5
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 15:59:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=haqzecHNYqquRNWbdt2jWyh+SD+fNxvs9MOtCucs8nBSuYcog/NxaRU+aO9r3HnO+j4dAjLTGkkTH+v6+GUD3hDoR014bFYsYHn3NAiQRw0HfxpGM2n48S3VQ65dasUk2WqAVt7P+TN03dDsTY99Ya+jrVamWGSOUIStlD32ffjraGfdFgCBv15xopaHLxiJ1fksRhsZcoyOLB6E35HyC+kMJzll5xklFbAOEDvHOM4j8+BKGxAC5joYEBSfbCpm71h5G18b0qbMXPt3HjyYTYKId5Ni/c0YVBtoQl1+Z0snPQHJudd29Cj/1aKkty2yk4QjB/O8Nm78cJlLyqcMWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WtG1cwA1lMWej7xWdb/6/kNy39TVN8KltxpsebH6nr4=;
 b=LwS0FN+msqvM/em/2dNP+uUmwtPO776RA/ZtUJmiQPrshDPXXXXkedGga8PglsZJ+a47PVKrP8FOnTIjzPjeR28ehYD6QrTodbzjlF8rXZ+dt5ELykTPq+E9OZvV5L0Hfv8Fo7GyXnQhbdYMcekiRhnE613qTawbgI30Wx0Ht53VMcqFl/PTnox+X/xzIrarFsuV48LJICBlydYV2XdPKiml/JhdSm2111AhzYRE2gJAoW+J2QI2MucZbN/+ZaYCmYdRJtSVJpsdHQfG0HzQraHvQ8kkVngYvdnyZ7kFkiqk0/qBySUYpPPQ0KrZwHwvcrdv6TYx15rLJ+tcNZSmnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WtG1cwA1lMWej7xWdb/6/kNy39TVN8KltxpsebH6nr4=;
 b=pg01mjf4bytAJdXI+w7JIRcESDVx+S+Wix380ti1V7QKEAqAVZfSbiYEHUNAZm9DIJM7XS56PcPizd49SZVKk8VuhavnXzqB3MOLkywHLMOp1ZwB/tRhqb69fmt2gqd8Y36wjqoBIasH/nm14QIMAbKGlmL9ioXRFrmV88C3ZZ0=
Received: from BN9PR03CA0732.namprd03.prod.outlook.com (2603:10b6:408:110::17)
 by CH3PR12MB7737.namprd12.prod.outlook.com (2603:10b6:610:14d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Mon, 27 Apr
 2026 15:59:39 +0000
Received: from BN3PEPF0000B06E.namprd21.prod.outlook.com
 (2603:10b6:408:110:cafe::d2) by BN9PR03CA0732.outlook.office365.com
 (2603:10b6:408:110::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 15:59:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06E.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.0 via Frontend Transport; Mon, 27 Apr 2026 15:59:39 +0000
Received: from yinjiyao-dev24.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 27 Apr
 2026 10:59:38 -0500
From: Yinjie Yao <yinjie.yao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <leo.liu@amd.com>, <ruijing.dong@amd.com>, Yinjie Yao <yinjie.yao@amd.com>
Subject: [PATCH v2 01/19] drm/amdgpu/vcn: set no_user_fence for VCN v2.0
 enc/dec rings
Date: Mon, 27 Apr 2026 11:58:39 -0400
Message-ID: <20260427155857.1370151-1-yinjie.yao@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CADnq5_MPJG=S+B4kg6v64xD+8pDEbG5z1Q7j-2A+CfStmuejTg@mail.gmail.com>
References: <CADnq5_MPJG=S+B4kg6v64xD+8pDEbG5z1Q7j-2A+CfStmuejTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06E:EE_|CH3PR12MB7737:EE_
X-MS-Office365-Filtering-Correlation-Id: 43aa4949-01fd-480d-a097-08dea475fcb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Z26EQcv8VP2XCFekkD82Anu5epJnEDMoByXGMeV4hylqeFqgN2SKWcUkLe8iILRVnJau0jhqFtcFCEWEl9oe6CK71r0+WVmC2j32b2yfsnp+kx9wG4AKygLB17WWZLvMvKcZVYwv4+lUAhS5+QoVU0EZAYBSuFFtvmRraoGokRWAbK66MYhd5VuS40FrzaFSd7B+Bd1S2yztzNIFKhdI3xhb3V5P4R2hUJku7ml8x+TTt9ssanjBhWGF7p2TJhegKdhb36fHTaz95MTKUtKa0z33E2BMtN4rgZO3M/tYvgurWtEGYXmUrA2pCdZVtrpmnk5+ovOft/YK4PCAlDSI+FykbnAjFVwDdi/Un/Z3s45LWVw/q+/NIxsXAs17jjdj21BGeBCUcZn4Ec6YZG1yRgt3WX+6m/nR+VIw90nOSxR/SlOcTt54ZPUtj7TGtkwoD+Hv5wP5ufjE3yEQ1dDqpx7XyavD5B6nlv8dCHNGcT1kkjimM8hR/3Hs+TYOcCL0ux2MkG5e0WsG8KlXhE0crgHUdfMfboumgEYNz5+bM9S0SD6tV+4WjoCa/haIY4SZe5lYezfas7D8T4Y8lCBLaHUk4PnSlQhGdtBLIKQca5DEqDdbB6bkdLdgvRghjyszWNOGvR7PdhVS/IhDWq/S1th5xP0GYnblk4NZSbcv5Ly3+bipIiDzJSRrHUGtWu2flV/bQgJ0T5xiUQoO90Kc9dIO1Xet6i0WV3qmz5S9l05mOwQ9qFzsrnXwqx79fYgblSBYMF5Oh9iFZrpAcdooEg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tHQCBTD999Obb66wDl6ariEQtYaC0lJ30mRhFv8Dgo3yspuFyhDx3OXRp858LWlLM7ZtjwK2a67ZZlruVaANuR4HeCCLtdphdY4XsBIQoyKC024XITt7/tqCdLWP5F7nH4rgg0SW684RD+TrmjIQjAWexfuISxk1e7JTD7tiHgyoNQRo0yu+yhLp3tr6ihgf85GKz5UM9cnQK1XwZl/PP9aa/YTFoR6XOl7UJ2XZhFi50aK5dwRGa18QiWKicmVAbAYdS8pC0Z9sEYfwgP+ViW5n9HBFezAdsPG1GuJ9zeTEMI2DYbXZ+zvlXJ+h6jB2oHY9HfMSp66kUyUZIy0Kw0Lt2DO/sDbnWA8i1XNO+JfTtDEyHceIaAfWwB/DjliEKKxP98+vefCjw2wXFWbO4GY9peNfmsXpA9MZOJKR6ft5RnEx/mPAY7oPEj2O0VVv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 15:59:39.0386 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43aa4949-01fd-480d-a097-08dea475fcb1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7737
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

Fixes: 1b61de45dfaf ("drm/amdgpu: add initial VCN2.0 support (v2)")
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Yinjie Yao <yinjie.yao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index e35fae9cdaf6..0442bfcfd384 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -2113,6 +2113,7 @@ static const struct amd_ip_funcs vcn_v2_0_ip_funcs = {
 static const struct amdgpu_ring_funcs vcn_v2_0_dec_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_DEC,
 	.align_mask = 0xf,
+	.no_user_fence = true,
 	.secure_submission_supported = true,
 	.get_rptr = vcn_v2_0_dec_ring_get_rptr,
 	.get_wptr = vcn_v2_0_dec_ring_get_wptr,
@@ -2145,6 +2146,7 @@ static const struct amdgpu_ring_funcs vcn_v2_0_enc_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_ENC,
 	.align_mask = 0x3f,
 	.nop = VCN_ENC_CMD_NO_OP,
+	.no_user_fence = true,
 	.get_rptr = vcn_v2_0_enc_ring_get_rptr,
 	.get_wptr = vcn_v2_0_enc_ring_get_wptr,
 	.set_wptr = vcn_v2_0_enc_ring_set_wptr,
-- 
2.43.0

