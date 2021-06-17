Return-Path: <SRS0=/AY/=LL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D373EC2B9F4
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Jun 2021 08:39:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92EDE611CE
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Jun 2021 08:39:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92EDE611CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3934A6E8C2;
	Thu, 17 Jun 2021 08:39:59 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2075.outbound.protection.outlook.com [40.107.100.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 393786E8C1
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Jun 2021 08:39:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LJD7ThThEOK7DOO+Wr/KPiAmn6I+DAlqO2zuv8qQZCDWvUNvcvRjD6XvQJcv3hk5WEoUGRx29vUv3H2ZuDLt0/iAbs3Irh6C73qzHhy2G0se4KK+bVJ9N0+CiZrR05cvefTlwqIZXkT1s4GYzMBGLzh2DGMCEyeKpwteO2fNUdXCE8EnerBHLNY+VCJpG7ZeQ0LGPpx4sHkFvB6dlBcfiuHxleWz8HhtvNBUfIYtv0BeXKFSaI5w/eSEgB4quKJFz2djnPUfIaM8OnTx3U3FK00bwJ34E0TceNLVqIqXXGM/ar4sYmmLhLTOorJn5JndaRJPvgWhQ3VVYXPT5vMwOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQ+5YmfBtLmY/ACuLdkDsXC6FUWKWs5esIjt15q1FXA=;
 b=OuFaHagnByhnqg3cLJyqFV9AYbS6koZTa/ostw8Jo+aCWUIks56sIoNL8bv+d3NYF3tdPT/nG+dX2IzeGFTIQjXPKEuxJR83e7Q5LU/x4n4iDamxRkMzQyVDyBwM012tXDguKlxFQh+8OyCQbopp/uLGCfBGKPM64oufjoAQWwqZ/v9M6ruSsu2wwpHF40hJIWc3/xWYsLdt4A3ywvpXcBHAY7oVIEAOVfYtxAT+fnPPAHYTnM193isxbAovbg7C4AX//T7zq+3LLfeelmF6Q+jAqQ05ttBHeZzI7amjAcv+BgamiJ6G7lVcVilR/CqQc+7EZAbLmO8Z4nOZgN1J9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQ+5YmfBtLmY/ACuLdkDsXC6FUWKWs5esIjt15q1FXA=;
 b=bVtg2QDsFLKOkJnLuNqF0n8s1jngAlmUzV09/RPq+4DDCgQ49VyoIyYXLmUIkf/xASQdG3VQdpFQ5MYvr1du25RQJZFllu3tsOqbBgXPcJ5NMl/eG6LnH+DQa9nQ69HGBb2J4XSDDAIrh+yCVAOWAYWE3mcAVa83CXO1PEsORfU=
Received: from BN9PR03CA0591.namprd03.prod.outlook.com (2603:10b6:408:10d::26)
 by BYAPR12MB2871.namprd12.prod.outlook.com (2603:10b6:a03:13d::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Thu, 17 Jun
 2021 08:39:55 +0000
Received: from BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10d:cafe::80) by BN9PR03CA0591.outlook.office365.com
 (2603:10b6:408:10d::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend
 Transport; Thu, 17 Jun 2021 08:39:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT007.mail.protection.outlook.com (10.13.177.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4242.16 via Frontend Transport; Thu, 17 Jun 2021 08:39:54 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 17 Jun
 2021 03:39:53 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 3/7] drm/amdgpu: fix NAK-G generation during PCI-e link
 width switch
Date: Thu, 17 Jun 2021 16:39:19 +0800
Message-ID: <20210617083923.421052-3-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210617083923.421052-1-evan.quan@amd.com>
References: <20210617083923.421052-1-evan.quan@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bdc7ec9c-03a1-4bbe-b04c-08d9316b7b32
X-MS-TrafficTypeDiagnostic: BYAPR12MB2871:
X-Microsoft-Antispam-PRVS: <BYAPR12MB287167987EFA7911B36470CCE40E9@BYAPR12MB2871.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jhBb9nE6d0S5kuN3YmDfOyTX7QOlGUb/CQZPIAmbwW8kpl81tWzNa449GdceHCKoVgFUQQEDvWSIOiEFiiI9KepfqEqQIEODRMFPSCB9Z5r8qngiZP0lFxTescPO8y59TIx/kD1z6gPS4vu9j5jObpdW2cIiv3b2Q10zhHxfOsjo/5Vc72cHdLGf1VqQcXczqGKLEGKO8UNMJlXcd6Zo4p0piPRPRLwhofrU8wT922f5REbrXjmKWjjNZMwlunvtYwfbqOhQZNVqoBEYVL4um1oRvFCLCon8ENk4GAcRttN43FJetnsmSKwflo5ngos23l6n9g3T97RWOOSpd0+YqzMbqiHMIZBsWh6b97AyktZ3PfsteK67Hp2Fjr4eWhoQDivRaFaYjt5bHujSo+wq5Y1qM+Z+4Nd2UODZfS3DeHYABnnZeAjaKFgXkM7q+hA0g/wNOKaYbaAi7+dO/o6+535QiDX/DMlm1s0Mh2Ffh1x60c5plqo7nU+UPV5mQ834S2XANym3SA4kFk/4YYp+2RKi0Gva3yF8/BaMraBUzFzBDBfyirBafHdHTxVtG2vLNLWmoDSETvFc7By2ojIuX+Cq0FMKhTxCO6aWOzzJbpxB6sK8gHJJnNUwAG/WUVHwHaYj+gNDkl4vvb3mJmVws4LiY9Jz+HCiXhW5FOF63VufVtBcLiqf1LQN75x9NLBC
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(376002)(346002)(36840700001)(46966006)(356005)(83380400001)(478600001)(6666004)(186003)(8936002)(26005)(82310400003)(81166007)(7696005)(70206006)(36860700001)(70586007)(5660300002)(44832011)(8676002)(1076003)(2906002)(47076005)(36756003)(316002)(54906003)(86362001)(82740400003)(336012)(16526019)(6916009)(2616005)(426003)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 08:39:54.7377 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdc7ec9c-03a1-4bbe-b04c-08d9316b7b32
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2871
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

A lot of NAK-G being generated when link widht switching is happening.
WA for this issue is to program the SPC to 4 symbols per clock during
bootup when the native PCIE width is x4.

Change-Id: I7a4d751e44bddc4bd1e97860cb4f53dfadc02a2c
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 455d0425787c..2e1d12369cec 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -63,6 +63,10 @@
 #include "mxgpu_nv.h"
 #include "smuio_v11_0.h"
 #include "smuio_v11_0_6.h"
+#include "nbio/nbio_2_3_sh_mask.h"
+
+#define smnPCIE_LC_LINK_WIDTH_CNTL        0x11140288
+#define smnPCIE_LC_CNTL6                  0x111402ec
 
 static const struct amd_ip_funcs nv_common_ip_funcs;
 
@@ -1407,10 +1411,35 @@ static int nv_common_sw_fini(void *handle)
 	return 0;
 }
 
+static void nv_apply_lc_spc_mode_wa(struct amdgpu_device *adev)
+{
+	uint32_t reg_data = 0;
+	uint32_t link_width = 0;
+
+	reg_data = RREG32_PCIE(smnPCIE_LC_LINK_WIDTH_CNTL);
+	link_width = (reg_data & PCIE_LC_LINK_WIDTH_CNTL__LC_LINK_WIDTH_RD_MASK)
+		>> PCIE_LC_LINK_WIDTH_CNTL__LC_LINK_WIDTH_RD__SHIFT;
+
+	/*
+	 * Program PCIE_LC_CNTL6.LC_SPC_MODE_8GT to 0x2 (4 symbols per clock data)
+	 * if link_width is 0x3 (x4)
+	 */
+	if (0x3 == link_width) {
+		reg_data = RREG32_PCIE(smnPCIE_LC_CNTL6);
+		reg_data &= ~PCIE_LC_CNTL6__LC_SPC_MODE_8GT_MASK;
+		reg_data |= (0x2 << PCIE_LC_CNTL6__LC_SPC_MODE_8GT__SHIFT);
+		WREG32_PCIE(smnPCIE_LC_CNTL6, reg_data);
+	}
+}
+
 static int nv_common_hw_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	if ((adev->asic_type >= CHIP_NAVI10) &&
+	     (adev->asic_type <= CHIP_NAVI12))
+		nv_apply_lc_spc_mode_wa(adev);
+
 	/* enable pcie gen2/3 link */
 	nv_pcie_gen3_enable(adev);
 	/* enable aspm */
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
