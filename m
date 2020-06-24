Return-Path: <SRS0=jISE=AF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C15C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2020 20:31:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEA792080C
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2020 20:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="l7RASOPf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEA792080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF5766E82A;
	Wed, 24 Jun 2020 20:31:56 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F8E26E82A
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2020 20:31:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kINuYZp9JG0tgNMTaJdBPJAjoY1tO5D+MzX0EU+HSfDhWODQ/ZhjbK4Q5s/WhT7QFezcbfp2Hw18gT/QvTARQ4xwOfEuWp/BD9QkqOUvOdqkTfDqYocqCjiR33lPoGaM2k1eDiXYXJsaJkpNEDhPkky0P2sPHGaWT1JYor4aJ1Dpwqyp9fQ7dB5fXFbsKHqxgMfIFDFJ9ZhArDylxq7JV2dQtgjwHut7OYDoJuZiuKY5KLj5dbu0BcBe6IgjuT9MM2OguZTzSTWnMfbeC7pKk9ME1GWTEKbABB1k8iDvx42VS8ZSelwV7/UywoNlsJyhwmvKXowuMixwn9pUQXKLfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dwndqfYCYj50z7frYpI1Zcj+UfrEn9lWIMEJMT5n7iw=;
 b=i8DQmh1VF4E/j7nHui20Nlcrfe6S1tltF6lluxJHhIlQnuj+Kz6VdmXg41nDPq+oejL13p9A2K9Bt7LSQfp6ZnH9GAjsBZOEGkUvZYHRbsn0UNE8Cqi/K51oj6p2GNYVYcd6XROwH8nTn4jZuZwbT9+W58Bn1OBOUGkhHh6U342tA+nPFhL6NYANWtG+wtco2SVc+qoja0vCD9b9j0s7YkkJiwxfKH8cj78bIrH5q35gLnEHNF8Bgxn1buljcGxRCGwN+F02b+ndE4pOkbeLPqh7u4iDMGoM0rVZYtdbBjWPZYEkv2Ro6Mu0L6UFz3lCr3C03uZH99CIR+4/TggSlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dwndqfYCYj50z7frYpI1Zcj+UfrEn9lWIMEJMT5n7iw=;
 b=l7RASOPfP6HR82CZhI218BqVQVJNhi/keNL3ZR5m6j6eSNUIwEA0j+Kcq97V1NGAJ/R995Op+mgmdc1SQi7Xqd1NZvmQoiJ6tU6LzTKgVezRnCpkx3JODOoBTv5LBkFlc03qZgB+J+iIvmqdgoKb0hu/31W1comgmIzdTNdCRWA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2422.namprd12.prod.outlook.com (2603:10b6:4:b9::27) by
 DM5PR1201MB0172.namprd12.prod.outlook.com (2603:10b6:4:51::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22; Wed, 24 Jun 2020 20:31:54 +0000
Received: from DM5PR12MB2422.namprd12.prod.outlook.com
 ([fe80::2107:be9e:d79b:34ee]) by DM5PR12MB2422.namprd12.prod.outlook.com
 ([fe80::2107:be9e:d79b:34ee%3]) with mapi id 15.20.3109.027; Wed, 24 Jun 2020
 20:31:54 +0000
From: Alex Jivin <alex.jivin@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/3] drm/amdgpu: SI support for VCE clock control
Date: Wed, 24 Jun 2020 16:31:36 -0400
Message-Id: <20200624203137.14377-2-alex.jivin@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200624203137.14377-1-alex.jivin@amd.com>
References: <20200624203137.14377-1-alex.jivin@amd.com>
X-ClientProxiedBy: BN6PR18CA0010.namprd18.prod.outlook.com
 (2603:10b6:404:121::20) To DM5PR12MB2422.namprd12.prod.outlook.com
 (2603:10b6:4:b9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alejivin-ThinkPad-T495.amd.com (165.204.84.11) by
 BN6PR18CA0010.namprd18.prod.outlook.com (2603:10b6:404:121::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21 via Frontend
 Transport; Wed, 24 Jun 2020 20:31:53 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2c1ef93f-23d6-4505-334a-08d8187da1f9
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0172:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0172FD4F9DF830532E0385DC91950@DM5PR1201MB0172.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 0444EB1997
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ysOqalZdcIC+8ULN/jvMI4AZxTCIxIPkIYpHXkgaLEouGiGxpuPSAWGZHT30mrk4LQCyBFacw4x0BhMcYMcpr3+gYfFFc9AkvRJiORGQo//rUNAaWf/Kev1WtzLjk7iS36DrR65qBSBkGYQWB6Qeeb60A6smQMdA5ZahAs9dF7xy7Ji88I18h2tP4ZScf8XgBbOMCbedwJwn0E57QtCdmvcCM3TTHH2R7iajljjZI7/BwMipVS/cjhFA7wY9XiLtEFpHy83xVbPnFnZQj7ty1W75B21n3+oxra42y5+5/8jgsOcwVuo1MBfHO7h4GH1M
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2422.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(136003)(396003)(39860400002)(366004)(8936002)(86362001)(36756003)(8676002)(5660300002)(16526019)(186003)(2906002)(26005)(1076003)(6916009)(44832011)(956004)(6666004)(66946007)(66556008)(2616005)(66476007)(83380400001)(4326008)(478600001)(52116002)(6486002)(7696005)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: sLmqlhRq0Ut4V9fu77KmY2Yd19RdmdxD/2P9BwoG57xfeEnietpuKApfRujhGh9829enE4MfiMK9Y/hBTnbUnnW7Cp6sq2F4gCoeXJtmCyRcJoI7MTb7ef3M8aQSmM3A3oS0ZYtUKKneA3SYcktqbeHGK5sO57NReSW/pF+1rzgkwnVxTfORv59YCWDzB0CpL06JKtBE5d6wBqP8B1Jl4oHlEeWxeKwU/fPL4cHyIA7ZTLttwzF0u2fuSCNlDB3ddUIbJVL0eSqbcNYIrUV9mazweR60BO79EY8laJxBdruiS6+9/AAylhWuxwUp1/CFYr9v6IRDGuJaf+/sZv2UtIXlsEsmQMfaVGrkMtoKKTJVjAX2zh70ObZJI3+4I7804sPfvQY2kvcZKEPx2H/8zd/WdeLoBGWuBU2PLPABxmBmJ1QQlWJGlpt/bXx3ykkn7QqMW1QiNN2UIBrygWG3bWMh603UWwdEuyswVcQoPlcbHhChEIi7wDwKUAAPQAXf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c1ef93f-23d6-4505-334a-08d8187da1f9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2020 20:31:54.1906 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V47P463I4MLVWIzm7TREY3y0Pk20nKeLk0lDQY7otGl+u+s6ReHa6dihGDFMPbApovpQ9ulsiJGI4wRqMrGWXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0172
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Port functionality from the Radeon driver to support
VCE clock control.

Signed-off-by: Alex Jivin <alex.jivin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h |   9 ++
 drivers/gpu/drm/amd/amdgpu/si.c     | 126 +++++++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/sid.h    |  31 +++++++
 3 files changed, 165 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 6c7dd0a707c9..4b5a9a259a21 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1083,6 +1083,15 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
 		tmp_ |= ((val) & ~(mask));			\
 		WREG32_PLL(reg, tmp_);				\
 	} while (0)
+
+#define WREG32_SMC_P(_Reg, _Val, _Mask)                         \
+	do {                                                    \
+		u32 tmp = RREG32_SMC(_Reg);                     \
+		tmp &= (_Mask);                                 \
+		tmp |= ((_Val) & ~(_Mask));                     \
+		WREG32_SMC(_Reg, tmp);                          \
+	} while (0)
+
 #define DREG32_SYS(sqf, adev, reg) seq_printf((sqf), #reg " : 0x%08X\n", amdgpu_device_rreg((adev), (reg), false))
 #define RREG32_IO(reg) amdgpu_io_rreg(adev, (reg))
 #define WREG32_IO(reg, v) amdgpu_io_wreg(adev, (reg), (v))
diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index 93609d69eff2..a5ad48fe502e 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -1650,6 +1650,130 @@ static int si_set_uvd_clocks(struct amdgpu_device *adev, u32 vclk, u32 dclk)
 	return 0;
 }
 
+static int si_vce_send_vcepll_ctlreq(struct amdgpu_device *adev)
+{
+	unsigned i;
+
+	/* Make sure VCEPLL_CTLREQ is deasserted */
+	WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL, 0, ~UPLL_CTLREQ_MASK);
+
+	mdelay(10);
+
+	/* Assert UPLL_CTLREQ */
+	WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL, UPLL_CTLREQ_MASK, ~UPLL_CTLREQ_MASK);
+
+	/* Wait for CTLACK and CTLACK2 to get asserted */
+	for (i = 0; i < SI_MAX_CTLACKS_ASSERTION_WAIT; ++i) {
+		uint32_t mask = UPLL_CTLACK_MASK | UPLL_CTLACK2_MASK;
+
+		if ((RREG32_SMC(CG_VCEPLL_FUNC_CNTL) & mask) == mask)
+			break;
+		mdelay(10);
+	}
+
+	/* Deassert UPLL_CTLREQ */
+	WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL, 0, ~UPLL_CTLREQ_MASK);
+
+	if (i == SI_MAX_CTLACKS_ASSERTION_WAIT) {
+		DRM_ERROR("Timeout setting UVD clocks!\n");
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+static int si_set_vce_clocks(struct amdgpu_device *adev, u32 evclk, u32 ecclk)
+{
+	unsigned fb_div = 0, evclk_div = 0, ecclk_div = 0;
+	int a;
+
+	/* Bypass evclk and ecclk with bclk */
+	WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL_2,
+		     EVCLK_SRC_SEL(1) | ECCLK_SRC_SEL(1),
+		     ~(EVCLK_SRC_SEL_MASK | ECCLK_SRC_SEL_MASK));
+
+	/* Put PLL in bypass mode */
+	WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL, VCEPLL_BYPASS_EN_MASK,
+		     ~VCEPLL_BYPASS_EN_MASK);
+
+	if (!evclk || !ecclk) {
+		/* Keep the Bypass mode, put PLL to sleep */
+		WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL, VCEPLL_SLEEP_MASK,
+			     ~VCEPLL_SLEEP_MASK);
+		return 0;
+	}
+
+	a = si_calc_upll_dividers(adev, evclk, ecclk, 125000, 250000,
+				  16384, 0x03FFFFFF, 0, 128, 5,
+				  &fb_div, &evclk_div, &ecclk_div);
+	if (a)
+		return a;
+
+	/* Set RESET_ANTI_MUX to 0 */
+	WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL_5, 0, ~RESET_ANTI_MUX_MASK);
+
+	/* Set VCO_MODE to 1 */
+	WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL, VCEPLL_VCO_MODE_MASK,
+		     ~VCEPLL_VCO_MODE_MASK);
+
+	/* Toggle VCEPLL_SLEEP to 1 then back to 0 */
+	WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL, VCEPLL_SLEEP_MASK,
+		     ~VCEPLL_SLEEP_MASK);
+	WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL, 0, ~VCEPLL_SLEEP_MASK);
+
+	/* Deassert VCEPLL_RESET */
+	WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL, 0, ~VCEPLL_RESET_MASK);
+
+	mdelay(1);
+
+	a = si_vce_send_vcepll_ctlreq(adev);
+	if (a)
+		return a;
+
+	/* Assert VCEPLL_RESET again */
+	WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL, VCEPLL_RESET_MASK, ~VCEPLL_RESET_MASK);
+
+	/* Disable spread spectrum. */
+	WREG32_SMC_P(CG_VCEPLL_SPREAD_SPECTRUM, 0, ~SSEN_MASK);
+
+	/* Set feedback divider */
+	WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL_3,
+		     VCEPLL_FB_DIV(fb_div),
+		     ~VCEPLL_FB_DIV_MASK);
+
+	/* Set ref divider to 0 */
+	WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL, 0, ~VCEPLL_REF_DIV_MASK);
+
+	/* Set PDIV_A and PDIV_B */
+	WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL_2,
+		     VCEPLL_PDIV_A(evclk_div) | VCEPLL_PDIV_B(ecclk_div),
+		     ~(VCEPLL_PDIV_A_MASK | VCEPLL_PDIV_B_MASK));
+
+	/* Give the PLL some time to settle */
+	mdelay(15);
+
+	/* Deassert PLL_RESET */
+	WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL, 0, ~VCEPLL_RESET_MASK);
+
+	mdelay(15);
+
+	/* Switch from bypass mode to normal mode */
+	WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL, 0, ~VCEPLL_BYPASS_EN_MASK);
+
+	a = si_vce_send_vcepll_ctlreq(adev);
+	if (a)
+		return a;
+
+	/* Switch VCLK and DCLK selection */
+	WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL_2,
+		     EVCLK_SRC_SEL(16) | ECCLK_SRC_SEL(16),
+		     ~(EVCLK_SRC_SEL_MASK | ECCLK_SRC_SEL_MASK));
+
+	mdelay(100);
+
+	return 0;
+}
+
 static const struct amdgpu_asic_funcs si_asic_funcs =
 {
 	.read_disabled_bios = &si_read_disabled_bios,
@@ -1660,7 +1784,7 @@ static const struct amdgpu_asic_funcs si_asic_funcs =
 	.set_vga_state = &si_vga_set_state,
 	.get_xclk = &si_get_xclk,
 	.set_uvd_clocks = &si_set_uvd_clocks,
-	.set_vce_clocks = NULL,
+	.set_vce_clocks = &si_set_vce_clocks,
 	.get_pcie_lanes = &si_get_pcie_lanes,
 	.set_pcie_lanes = &si_set_pcie_lanes,
 	.get_config_memsize = &si_get_config_memsize,
diff --git a/drivers/gpu/drm/amd/amdgpu/sid.h b/drivers/gpu/drm/amd/amdgpu/sid.h
index 262da0fc8b2e..a3a966a83981 100644
--- a/drivers/gpu/drm/amd/amdgpu/sid.h
+++ b/drivers/gpu/drm/amd/amdgpu/sid.h
@@ -2461,4 +2461,35 @@
 
 #define	MC_VM_FB_OFFSET					0x81a
 
+/* Discrete VCE clocks */
+#define CG_VCEPLL_FUNC_CNTL                             0xc0030600
+#define    VCEPLL_RESET_MASK                            0x00000001
+#define    VCEPLL_SLEEP_MASK                            0x00000002
+#define    VCEPLL_BYPASS_EN_MASK                        0x00000004
+#define    VCEPLL_CTLREQ_MASK                           0x00000008
+#define    VCEPLL_VCO_MODE_MASK                         0x00000600
+#define    VCEPLL_REF_DIV_MASK                          0x003F0000
+#define    VCEPLL_CTLACK_MASK                           0x40000000
+#define    VCEPLL_CTLACK2_MASK                          0x80000000
+
+#define CG_VCEPLL_FUNC_CNTL_2                           0xc0030601
+#define    VCEPLL_PDIV_A(x)                             ((x) << 0)
+#define    VCEPLL_PDIV_A_MASK                           0x0000007F
+#define    VCEPLL_PDIV_B(x)                             ((x) << 8)
+#define    VCEPLL_PDIV_B_MASK                           0x00007F00
+#define    EVCLK_SRC_SEL(x)                             ((x) << 20)
+#define    EVCLK_SRC_SEL_MASK                           0x01F00000
+#define    ECCLK_SRC_SEL(x)                             ((x) << 25)
+#define    ECCLK_SRC_SEL_MASK                           0x3E000000
+
+#define CG_VCEPLL_FUNC_CNTL_3                           0xc0030602
+#define    VCEPLL_FB_DIV(x)                             ((x) << 0)
+#define    VCEPLL_FB_DIV_MASK                           0x01FFFFFF
+
+#define CG_VCEPLL_FUNC_CNTL_4                           0xc0030603
+
+#define CG_VCEPLL_FUNC_CNTL_5                           0xc0030604
+#define CG_VCEPLL_SPREAD_SPECTRUM                       0xc0030606
+#define    VCEPLL_SSEN_MASK                             0x00000001
+
 #endif
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
