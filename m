Return-Path: <SRS0=jISE=AF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2955C433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2020 20:31:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B03DB2080C
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2020 20:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="X5S/07ga"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B03DB2080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EDD36E457;
	Wed, 24 Jun 2020 20:31:56 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5590F6E457
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2020 20:31:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kiIsZMSYLl4IpyFWKp7pVroBKTeMFXICQIyowvWjDZP1Hhgq7butILbsu2Elblx/10ZTlsWyechPIk6qzl0vmy+31voHJbgLPib4LTzT9w/oxpd5pkdbzSm51TKEqob+P7cWAZ1B4rCvqy/lbRbPFazfSSd+duCeZd7pERbDxZpdx7LwQ6rEx3g0eko1Bj044Z+WOowqbBQxlC3fn7ySL9b0cdP1UJDuBlu1QIJUn47nQ6+xoIalWbNaqa91zQ4B423KoKo+lG7/Nm5O9GxYpEv1NGMg0D+EmrzPWijUYUNvgI1cfeEC4T5ptiq0YHDXOVrHZcPYEe4rUWmb1FDQ/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wWypo8JuGhFPugcOzsMrujm8/nCdmqsvUG9UyXAUr44=;
 b=ZA/zCXZLbDZlJiDAvCvx20tv6XMzc+Z9SYDsGPrAgDKw6Vwfks5kdRDHpDhmXK8/Gt7QQRrW9bmwHR9XCmObQEn5j2MzEgTw5Sn7xjXcihmhqDDMM4ffCMn7g8iEWF36/rVkDmSWJBBOAP0kFYAFyrKkJ+eWT048vQ225Via0w1OGapJ5Lv6pOw+nk70FwN5mdOtUa7YABwoouivudbsL13J0iAzPUcnkBOT+8yewEaN4nmqd9nV2LtJLCsrBD1x7AVpCM6/H5QXSqAhWv5ajj/2Mb21FDe3x7bxCIlIGTU9YyrBQxWzeiXlkfhC1thz0E1CcTyMSbGJ9cD384tkhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wWypo8JuGhFPugcOzsMrujm8/nCdmqsvUG9UyXAUr44=;
 b=X5S/07gabPHzarhRQRjQRtAzXM4+lb4kMN1tw+MU6jYWnaU7nXuJJzphdgbeMHFW0MXxSYRLRKuKEsqxX9s/VxJ7RE/a0LKFzYaBX35RAHdAdpjYS1vUUlvRXN8QivJcdbSvzfMX34wVsJNQzjXwakr2HP7A5+Xv8/foCYy6Q8Y=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2422.namprd12.prod.outlook.com (2603:10b6:4:b9::27) by
 DM5PR1201MB0172.namprd12.prod.outlook.com (2603:10b6:4:51::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22; Wed, 24 Jun 2020 20:31:53 +0000
Received: from DM5PR12MB2422.namprd12.prod.outlook.com
 ([fe80::2107:be9e:d79b:34ee]) by DM5PR12MB2422.namprd12.prod.outlook.com
 ([fe80::2107:be9e:d79b:34ee%3]) with mapi id 15.20.3109.027; Wed, 24 Jun 2020
 20:31:53 +0000
From: Alex Jivin <alex.jivin@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/3] drm/amdgpu: SI support for UVD clock control
Date: Wed, 24 Jun 2020 16:31:35 -0400
Message-Id: <20200624203137.14377-1-alex.jivin@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: BN6PR18CA0010.namprd18.prod.outlook.com
 (2603:10b6:404:121::20) To DM5PR12MB2422.namprd12.prod.outlook.com
 (2603:10b6:4:b9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alejivin-ThinkPad-T495.amd.com (165.204.84.11) by
 BN6PR18CA0010.namprd18.prod.outlook.com (2603:10b6:404:121::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21 via Frontend
 Transport; Wed, 24 Jun 2020 20:31:52 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3639ccbc-fc37-435f-cf4f-08d8187da17f
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0172:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0172C20914A86053E87A40CD91950@DM5PR1201MB0172.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0444EB1997
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zGL5xtvpmR49iGmDY9/jf0LaYAp+VWd/YmXczD7+PMYI/aTuU1wB5edAmYAIczUq0ArtuoTXEcaAVHR+EcUMWZaAnQrRCRMeSgyorNZJghpY0zfxr1GWFV3oRqwSXrmY6BjMbPgZ3mGt65dJ1cDajf+gkS1lJ5p5gP6vM/MitJ/5AUKv91oPAJhedh5b3300+wf8QQ0oflvYaDL9at71hc2j+k0b22Za1pzSngrOjrEKPaIYyTZmlcap7ap7Rn0tUnbA2OHu3saNL/Ea9MWPadIcdfjOu4+s7rAl7HYpLmlX375WxOhR6zWKFzrxPEkdm65ZK9qShfUG4qWUrnPVkVHME2x5KgZomoywSxX1ondoi4vXQxYqndQyE+cSnxk8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2422.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(136003)(396003)(39860400002)(366004)(8936002)(86362001)(36756003)(8676002)(5660300002)(16526019)(186003)(2906002)(26005)(1076003)(6916009)(44832011)(956004)(6666004)(66946007)(66556008)(2616005)(66476007)(83380400001)(4326008)(478600001)(52116002)(6486002)(7696005)(316002)(21314003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: FRdKn9/Dx4KLJw09IvCBAgoqKUx8RXrmgutE/OYqr2tgt1rA5vJk8TNiY+Wb7r5DmeYb6DD928niLAtAA7PjCVw6cMd40f5c0ZXm/EaMRNnHzYjAEVEjEXdXysRsXM8su4Tcx96IxGleVVBC+JIv6xuKAv24a22rG1DhIvamaWatKjV7/XUNpuaH+NMkLfM4xNaqT8ZoT4ltwE++AB2Ex+E+rSEdwTIrFflLZt7kQA3rdZj5zieWMAkYP10/1J248xpAMqzVg0D6Y4ZlviSF6ssS8Kr6FNxeWpRGFMySRXILTexiaVzyTQQLNHDVLyR0D9etNLstIsexdOy0g4hkdzzySgdIfySfyutcW+FhaB8CbI/WFH7xF4G2tghYW3q8IobGLZROUwtSIHovVut0uOAehaX4slVKcG3dZnx76OqSOhc6npJVcIT83KJT7ISTjFXQqiIM8urhW7EsMcr+52XgTIamVjzu7Z3hCmLVn9ZSqWAYy3dtOUvpPJF5AfhT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3639ccbc-fc37-435f-cf4f-08d8187da17f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2020 20:31:53.4160 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jVauz8hHAQY/+0sCLYesDqUxg6b1V58ru2SczoQf2LbG0h6CLhnnhck9FMSD1UxCGiMW6GrTN46615nod1jlPg==
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
UVD clock control.

Signed-off-by: Alex Jivin <alex.jivin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/si.c  | 234 ++++++++++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/sid.h |   1 +
 2 files changed, 229 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index 9b12285177e3..93609d69eff2 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -1267,12 +1267,6 @@ static u32 si_get_xclk(struct amdgpu_device *adev)
 	return reference_clock;
 }
 
-//xxx:not implemented
-static int si_set_uvd_clocks(struct amdgpu_device *adev, u32 vclk, u32 dclk)
-{
-	return 0;
-}
-
 static void si_flush_hdp(struct amdgpu_device *adev, struct amdgpu_ring *ring)
 {
 	if (!ring || !ring->funcs->emit_wreg) {
@@ -1428,6 +1422,234 @@ static uint64_t si_get_pcie_replay_count(struct amdgpu_device *adev)
 	return (nak_r + nak_g);
 }
 
+static int si_uvd_send_upll_ctlreq(struct amdgpu_device *adev,
+				   unsigned cg_upll_func_cntl)
+{
+	unsigned i;
+
+	/* Make sure UPLL_CTLREQ is deasserted */
+	WREG32_P(cg_upll_func_cntl, 0, ~UPLL_CTLREQ_MASK);
+
+	mdelay(10);
+
+	/* Assert UPLL_CTLREQ */
+	WREG32_P(cg_upll_func_cntl, UPLL_CTLREQ_MASK, ~UPLL_CTLREQ_MASK);
+
+	/* Wait for CTLACK and CTLACK2 to get asserted */
+	for (i = 0; i < SI_MAX_CTLACKS_ASSERTION_WAIT; ++i) {
+		uint32_t mask = UPLL_CTLACK_MASK | UPLL_CTLACK2_MASK;
+
+		if ((RREG32(cg_upll_func_cntl) & mask) == mask)
+			break;
+		mdelay(10);
+	}
+
+	/* Deassert UPLL_CTLREQ */
+	WREG32_P(cg_upll_func_cntl, 0, ~UPLL_CTLREQ_MASK);
+
+	if (i == SI_MAX_CTLACKS_ASSERTION_WAIT) {
+		DRM_ERROR("Timeout setting UVD clocks!\n");
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+static unsigned si_uvd_calc_upll_post_div(unsigned vco_freq,
+					  unsigned target_freq,
+					  unsigned pd_min,
+					  unsigned pd_even)
+{
+	unsigned post_div = vco_freq / target_freq;
+
+	/* Adjust to post divider minimum value */
+	if (post_div < pd_min)
+		post_div = pd_min;
+
+	/* We alway need a frequency less than or equal the target */
+	if ((vco_freq / post_div) > target_freq)
+		post_div += 1;
+
+	/* Post dividers above a certain value must be even */
+	if (post_div > pd_even && post_div % 2)
+		post_div += 1;
+
+	return post_div;
+}
+
+/**
+ * si_calc_upll_dividers - calc UPLL clock dividers
+ *
+ * @adev: amdgpu_device pointer
+ * @vclk: wanted VCLK
+ * @dclk: wanted DCLK
+ * @vco_min: minimum VCO frequency
+ * @vco_max: maximum VCO frequency
+ * @fb_factor: factor to multiply vco freq with
+ * @fb_mask: limit and bitmask for feedback divider
+ * @pd_min: post divider minimum
+ * @pd_max: post divider maximum
+ * @pd_even: post divider must be even above this value
+ * @optimal_fb_div: resulting feedback divider
+ * @optimal_vclk_div: resulting vclk post divider
+ * @optimal_dclk_div: resulting dclk post divider
+ *
+ * Calculate dividers for UVDs UPLL (except APUs).
+ * Returns zero on success; -EINVAL on error.
+ */
+static int si_calc_upll_dividers(struct amdgpu_device *adev,
+				 unsigned vclk, unsigned dclk,
+				 unsigned vco_min, unsigned vco_max,
+				 unsigned fb_factor, unsigned fb_mask,
+				 unsigned pd_min, unsigned pd_max,
+				 unsigned pd_even,
+				 unsigned *optimal_fb_div,
+				 unsigned *optimal_vclk_div,
+				 unsigned *optimal_dclk_div)
+{
+	unsigned vco_freq, ref_freq = adev->clock.spll.reference_freq;
+
+	/* Start off with something large */
+	unsigned optimal_score = ~0;
+
+	/* Loop through vco from low to high */
+	vco_min = max(max(vco_min, vclk), dclk);
+	for (vco_freq = vco_min; vco_freq <= vco_max; vco_freq += 100) {
+		uint64_t fb_div = (uint64_t)vco_freq * fb_factor;
+		unsigned vclk_div, dclk_div, score;
+
+		do_div(fb_div, ref_freq);
+
+		/* fb div out of range ? */
+		if (fb_div > fb_mask)
+			break; /* It can oly get worse */
+
+		fb_div &= fb_mask;
+
+		/* Calc vclk divider with current vco freq */
+		vclk_div = si_uvd_calc_upll_post_div(vco_freq, vclk,
+						     pd_min, pd_even);
+		if (vclk_div > pd_max)
+			break; /* vco is too big, it has to stop */
+
+		/* Calc dclk divider with current vco freq */
+		dclk_div = si_uvd_calc_upll_post_div(vco_freq, dclk,
+						     pd_min, pd_even);
+		if (dclk_div > pd_max)
+			break; /* vco is too big, it has to stop */
+
+		/* Calc score with current vco freq */
+		score = vclk - (vco_freq / vclk_div) + dclk - (vco_freq / dclk_div);
+
+		/* Determine if this vco setting is better than current optimal settings */
+		if (score < optimal_score) {
+			*optimal_fb_div = fb_div;
+			*optimal_vclk_div = vclk_div;
+			*optimal_dclk_div = dclk_div;
+			optimal_score = score;
+			if (optimal_score == 0)
+				break; /* It can't get better than this */
+		}
+	}
+
+	/* Did we found a valid setup ? */
+	if (optimal_score == ~0)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int si_set_uvd_clocks(struct amdgpu_device *adev, u32 vclk, u32 dclk)
+{
+	unsigned fb_div = 0, vclk_div = 0, dclk_div = 0;
+	int a;
+
+	/* Bypass vclk and dclk with bclk */
+	WREG32_P(CG_UPLL_FUNC_CNTL_2,
+		 VCLK_SRC_SEL(1) | DCLK_SRC_SEL(1),
+		 ~(VCLK_SRC_SEL_MASK | DCLK_SRC_SEL_MASK));
+
+	/* Put PLL in bypass mode */
+	WREG32_P(CG_UPLL_FUNC_CNTL, UPLL_BYPASS_EN_MASK, ~UPLL_BYPASS_EN_MASK);
+
+	if (!vclk || !dclk) {
+		/* Keep the Bypass mode */
+		return 0;
+	}
+
+	a = si_calc_upll_dividers(adev, vclk, dclk, 125000, 250000,
+				  16384, 0x03FFFFFF, 0, 128, 5,
+				  &fb_div, &vclk_div, &dclk_div);
+	if (a)
+		return a;
+
+	/* Set RESET_ANTI_MUX to 0 */
+	WREG32_P(CG_UPLL_FUNC_CNTL_5, 0, ~RESET_ANTI_MUX_MASK);
+
+	/* Set VCO_MODE to 1 */
+	WREG32_P(CG_UPLL_FUNC_CNTL, UPLL_VCO_MODE_MASK, ~UPLL_VCO_MODE_MASK);
+
+	/* Disable sleep mode */
+	WREG32_P(CG_UPLL_FUNC_CNTL, 0, ~UPLL_SLEEP_MASK);
+
+	/* Deassert UPLL_RESET */
+	WREG32_P(CG_UPLL_FUNC_CNTL, 0, ~UPLL_RESET_MASK);
+
+	mdelay(1);
+
+	a = si_uvd_send_upll_ctlreq(adev, CG_UPLL_FUNC_CNTL);
+	if (a)
+		return a;
+
+	/* Assert UPLL_RESET again */
+	WREG32_P(CG_UPLL_FUNC_CNTL, UPLL_RESET_MASK, ~UPLL_RESET_MASK);
+
+	/* Disable spread spectrum. */
+	WREG32_P(CG_UPLL_SPREAD_SPECTRUM, 0, ~SSEN_MASK);
+
+	/* Set feedback divider */
+	WREG32_P(CG_UPLL_FUNC_CNTL_3, UPLL_FB_DIV(fb_div), ~UPLL_FB_DIV_MASK);
+
+	/* Set ref divider to 0 */
+	WREG32_P(CG_UPLL_FUNC_CNTL, 0, ~UPLL_REF_DIV_MASK);
+
+	if (fb_div < 307200)
+		WREG32_P(CG_UPLL_FUNC_CNTL_4, 0, ~UPLL_SPARE_ISPARE9);
+	else
+		WREG32_P(CG_UPLL_FUNC_CNTL_4,
+			 UPLL_SPARE_ISPARE9,
+			 ~UPLL_SPARE_ISPARE9);
+
+	/* Set PDIV_A and PDIV_B */
+	WREG32_P(CG_UPLL_FUNC_CNTL_2,
+		 UPLL_PDIV_A(vclk_div) | UPLL_PDIV_B(dclk_div),
+		 ~(UPLL_PDIV_A_MASK | UPLL_PDIV_B_MASK));
+
+	/* Give the PLL some time to settle */
+	mdelay(15);
+
+	/* Deassert PLL_RESET */
+	WREG32_P(CG_UPLL_FUNC_CNTL, 0, ~UPLL_RESET_MASK);
+
+	mdelay(15);
+
+	/* Switch from bypass mode to normal mode */
+	WREG32_P(CG_UPLL_FUNC_CNTL, 0, ~UPLL_BYPASS_EN_MASK);
+
+	a = si_uvd_send_upll_ctlreq(adev, CG_UPLL_FUNC_CNTL);
+	if (a)
+		return a;
+
+	/* Switch VCLK and DCLK selection */
+	WREG32_P(CG_UPLL_FUNC_CNTL_2,
+		 VCLK_SRC_SEL(2) | DCLK_SRC_SEL(2),
+		 ~(VCLK_SRC_SEL_MASK | DCLK_SRC_SEL_MASK));
+
+	mdelay(100);
+
+	return 0;
+}
+
 static const struct amdgpu_asic_funcs si_asic_funcs =
 {
 	.read_disabled_bios = &si_read_disabled_bios,
diff --git a/drivers/gpu/drm/amd/amdgpu/sid.h b/drivers/gpu/drm/amd/amdgpu/sid.h
index 5f660f0c819f..262da0fc8b2e 100644
--- a/drivers/gpu/drm/amd/amdgpu/sid.h
+++ b/drivers/gpu/drm/amd/amdgpu/sid.h
@@ -47,6 +47,7 @@
 #define SI_MAX_LDS_NUM           	0xFFFF
 #define SI_MAX_TCC               	16
 #define SI_MAX_TCC_MASK          	0xFFFF
+#define SI_MAX_CTLACKS_ASSERTION_WAIT   100
 
 #define AMDGPU_NUM_OF_VMIDS 		8
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
