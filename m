Return-Path: <SRS0=Hy8X=AR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A511C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2020 09:05:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 116FF206F5
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2020 09:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0y9isX1s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 116FF206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E8F389E26;
	Mon,  6 Jul 2020 09:05:21 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9587689E26
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jul 2020 09:05:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eBpBMq/7jyKDopCQuHRVGrqveBgqZ755LC3N41T0VaSgBRirQ0NAuCEuQqjUhRVCk/iWUyA8s4EBOPteIH/UzeJ+IhYIwMls2vZe4jE0xro9fISQd2/kVC57NrEfAEfAbK4KXnZs+8Cak+haUJhpEquqcG0Wx7mpUt6+ce3IxhAApTSUBYu8ZFsxuNuWOYffqiU5zWT1UQlneZaLO4Y/t2lfAh+7N1NZbsdb6YNaduPuQTelFPFmqrmHbfr5/G1RRBjk/SPsMjWHFU+heIyZOqoZrQd4HIY9lOZ0EHLekzDxFoERQAs7SootROhaovLy2lIB/syrOdsH4btMC262ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MhWAXvQdhiZwwFDt2/JkjR0c+iAohXcTq3GPC7s5pR8=;
 b=edEsW+IpNN6Q7kb4CYy1ELpkLQAAoSixDWGdNKYDJKOOdllTdcU6UwE8/wkfEl+ue6oCMU8LSq+eyyvCAzx/vhimgp8zWJKcm0RU6zPg1ml8SZAX8JAxvMnN9SCMgFcPXPDAm9GdMsmyrjwfAWb0Kv41vIvJlJbDoYDelA1VLIAxye2cvu5euinSoPqAiWlZAjEkpjTmSEWsYHov8hrVF6gIW4/qUEr05tbZMwmyluO9bhWkBlWdHnYsxyRuOJtKwY9i2hpoylcgfwerPQ9Gj5AA7dWNgFEMKNf2SZMRZFfmkRKxJ56B7ViUXfL852NbqeAn/RJCrYxdCF4UGCJUdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MhWAXvQdhiZwwFDt2/JkjR0c+iAohXcTq3GPC7s5pR8=;
 b=0y9isX1s5vonF1YH/SXL6UgPneyWpDSeAzyDIvywDqqG55exdziPK6GsD+ZiFiJprlBGOom2abc/3TlskeOQttARfSRrjmA28ephLo2FqqeF+CDFo/WPpQVcHWJ5L023LQ7pcUZBP1OKB1p00D6BmV7yE+AOf9/ugdzqqaJMxz8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1854.namprd12.prod.outlook.com (2603:10b6:300:114::19)
 by MW3PR12MB4507.namprd12.prod.outlook.com (2603:10b6:303:2c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23; Mon, 6 Jul
 2020 09:05:17 +0000
Received: from MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::f518:2921:b1e3:fea2]) by MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::f518:2921:b1e3:fea2%10]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 09:05:17 +0000
From: Likun Gao <likun.gao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: use RREG32_KIQ to read register when get cg state
Date: Mon,  6 Jul 2020 17:04:45 +0800
Message-Id: <20200706090445.2933057-1-likun.gao@amd.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: HKAPR03CA0015.apcprd03.prod.outlook.com
 (2603:1096:203:c8::20) To MWHPR12MB1854.namprd12.prod.outlook.com
 (2603:10b6:300:114::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lnx-glk.amd.com (58.247.170.242) by
 HKAPR03CA0015.apcprd03.prod.outlook.com (2603:1096:203:c8::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.16 via Frontend Transport; Mon, 6 Jul 2020 09:05:15 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ebc92545-2aee-4deb-d0e0-08d8218bb335
X-MS-TrafficTypeDiagnostic: MW3PR12MB4507:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW3PR12MB4507228FACDBC09E16B7A8D6EF690@MW3PR12MB4507.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-Forefront-PRVS: 04569283F9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qiyg2nNMFI+42n2Plsia+CJTfm8WSDD9u/zAgQoWxPcvInUD3biPVeNREFNpV4UcHRTqhHVh35245Dj+jxaiy++CssO9CSjFR7grDCiXa7z/wMJT4xuLuWZ78kBTsphl7EYd5nU6NwP3NvvQ627ZSNtboBvXOPastWptFG7AXSDiLxQf8l8YuJdO7wGboPnmZn1GXsLSKKec0xkWZEaflRg+aU9obqeV6+1zoSLipI78bjaUcot3IVkkMyB3GzL6qt+yKPO7L/voq9Whoz2DQr7GJMf+i8wYL+sLCj5r3enAaHZZN5TcumyZy5LDUSCG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1854.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(136003)(366004)(396003)(39860400002)(5660300002)(44832011)(478600001)(6916009)(8676002)(86362001)(16526019)(186003)(54906003)(26005)(2906002)(66476007)(36756003)(1076003)(52116002)(7696005)(6486002)(956004)(8936002)(66556008)(2616005)(66946007)(4326008)(6666004)(316002)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: T/APD5NbPkfW1O0hKVubXEwfnp1Xi+jtCsiJY1nzitjcQ0TkKdQYdQHAn+rKgkVyYKCO1JYKKxmfMUJYgO8M+CTqrcUmU0nBmbWw17mpNezwr2b0D/T0GKiCATOtXx60/qo6F6/gTt/WoUPvBiJJlh4LvspkPcoFySmVUyXJUvIMyWhtTcEf4+qDuqOqwooOg62bjLaouGMfmPLOa3EVUs+hEfOeQfpEwpXePiV/HYxyAQSNbAFBkYSdNZWPS5Tns/D3RBLNEq6wnoNcsCThq3jaigWk44MyUq3qthw3JTQmjTY/ctaYXU6Jghi9vYYfJS0MJC+QD4YjxGYFU2Y+vVkEqk8rLBxCNesR0lx8b4lzjTy7XS52hf1XU5P5zoQaWs9ELvAxLqY9oNXxLkSnhMVscjGVSmrzV9Ta8VhAHHZU/q1Q5BC9Bcbt1ThtGPFKBX1Jp/vQ9zr5tIvaMrvNsVnTe75DVQLKF6C8kBFzMxKTxTNvZcQYzkQ15GPoV5NE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebc92545-2aee-4deb-d0e0-08d8218bb335
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1854.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2020 09:05:16.9661 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W5AgHQPC0IQ9lu74zwNw/pQlLQa9+JzrT4draV8tJ3v1kazVrwaA1wujJaofGY3W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4507
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
Cc: Likun Gao <Likun.Gao@amd.com>, Kenneth Feng <Kenneth.Feng@amd.com>,
 Hawking Zhang <hawking.zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Use RREG32_KIQ to read gfx register when try to get gfx/sdma
clockgating state instead of RREG32, as it will result
to system hard hang when GPU is enter into GFXOFF state.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: I1fc5fe70831e0ec35f1e701a1646cb3e46e121bf
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 10 +++++-----
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 8366c506a8b5..b8b4cff20013 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7481,12 +7481,12 @@ static void gfx_v10_0_get_clockgating_state(void *handle, u32 *flags)
 	int data;
 
 	/* AMD_CG_SUPPORT_GFX_MGCG */
-	data = RREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE);
+	data = RREG32_KIQ(SOC15_REG_OFFSET(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE));
 	if (!(data & RLC_CGTT_MGCG_OVERRIDE__GFXIP_MGCG_OVERRIDE_MASK))
 		*flags |= AMD_CG_SUPPORT_GFX_MGCG;
 
 	/* AMD_CG_SUPPORT_GFX_CGCG */
-	data = RREG32_SOC15(GC, 0, mmRLC_CGCG_CGLS_CTRL);
+	data = RREG32_KIQ(SOC15_REG_OFFSET(GC, 0, mmRLC_CGCG_CGLS_CTRL));
 	if (data & RLC_CGCG_CGLS_CTRL__CGCG_EN_MASK)
 		*flags |= AMD_CG_SUPPORT_GFX_CGCG;
 
@@ -7495,17 +7495,17 @@ static void gfx_v10_0_get_clockgating_state(void *handle, u32 *flags)
 		*flags |= AMD_CG_SUPPORT_GFX_CGLS;
 
 	/* AMD_CG_SUPPORT_GFX_RLC_LS */
-	data = RREG32_SOC15(GC, 0, mmRLC_MEM_SLP_CNTL);
+	data = RREG32_KIQ(SOC15_REG_OFFSET(GC, 0, mmRLC_MEM_SLP_CNTL));
 	if (data & RLC_MEM_SLP_CNTL__RLC_MEM_LS_EN_MASK)
 		*flags |= AMD_CG_SUPPORT_GFX_RLC_LS | AMD_CG_SUPPORT_GFX_MGLS;
 
 	/* AMD_CG_SUPPORT_GFX_CP_LS */
-	data = RREG32_SOC15(GC, 0, mmCP_MEM_SLP_CNTL);
+	data = RREG32_KIQ(SOC15_REG_OFFSET(GC, 0, mmCP_MEM_SLP_CNTL));
 	if (data & CP_MEM_SLP_CNTL__CP_MEM_LS_EN_MASK)
 		*flags |= AMD_CG_SUPPORT_GFX_CP_LS | AMD_CG_SUPPORT_GFX_MGLS;
 
 	/* AMD_CG_SUPPORT_GFX_3D_CGCG */
-	data = RREG32_SOC15(GC, 0, mmRLC_CGCG_CGLS_CTRL_3D);
+	data = RREG32_KIQ(SOC15_REG_OFFSET(GC, 0, mmRLC_CGCG_CGLS_CTRL_3D));
 	if (data & RLC_CGCG_CGLS_CTRL_3D__CGCG_EN_MASK)
 		*flags |= AMD_CG_SUPPORT_GFX_3D_CGCG;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 318d32e2bbf6..4dbc11907bc6 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1572,7 +1572,7 @@ static void sdma_v5_2_get_clockgating_state(void *handle, u32 *flags)
 		*flags = 0;
 
 	/* AMD_CG_SUPPORT_SDMA_LS */
-	data = RREG32(sdma_v5_2_get_reg_offset(adev, 0, mmSDMA0_POWER_CNTL));
+	data = RREG32_KIQ(sdma_v5_2_get_reg_offset(adev, 0, mmSDMA0_POWER_CNTL));
 	if (data & SDMA0_POWER_CNTL__MEM_POWER_OVERRIDE_MASK)
 		*flags |= AMD_CG_SUPPORT_SDMA_LS;
 }
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
