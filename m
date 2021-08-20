Return-Path: <SRS0=vXfK=NL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4543C4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Aug 2021 13:54:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4987261131
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Aug 2021 13:54:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4987261131
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D79FF6EA95;
	Fri, 20 Aug 2021 13:54:38 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 144AC6EA96
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Aug 2021 13:54:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aX8e8ZVyU21ePlhQ0ayOYQ3aNSLVqTC3nM0TBKSrXolrOaHHm2Kyii13PfZcpWJIzLgmf9abTD5v0LHT4jMnEfnVdR+URDdUYO9EGr1FV00r8G2Y/LF8zsloMqQhIU+eb3+81Xkneo9QqsmeIQCMQbySPACi3lnwMrfOEamCsl4HZo0i2Q1nVBZ/dBwMrLHnNVEW5YK7PB7O83t1qxIoIJqu+7Zp6PKizBPNFy0gNDVI+QLgFJSwTQloolP/8gTHMcu5iZEg+qyVKCMi+HybG3rKKWE9HUSJwcV9M0VT8WZCl8HZPixwmUbNAtLdGyBYL2/2w5vltiUVFcEORqgb3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0kCdiIFr/BbiXI6viGcHQfsyowHpdaOjCxApTIBEUWs=;
 b=Qgwgro42thtNRW/k4/RdoZoM9YTSqzurSUIu0oP6e/Yhxe6N41AJIJeB5sLP3oFHnhlyac63rAwEhUbKTzQPRPo7SfBdWz3y72s+kLRh1XTm7nJbOTUrM9cPd7xq3BdtCo9EIy8TUcH8iiCzWMjm6fKn/iYc1xPhXOJu/hC0xix/rN8E+5DH9mmvYlWmUTr4vJtuDHfP0BXfli1ddjwb2S9B+D3xKEHAyNfofofOVq958yOKeNg/vzYJoFamda1exbD17/3W7ryTpvoGyJEUmZCUXpVFEQ4BCnI1fEZ3aXJpj23soo78U3Iu/Vg+I7FOOqtiPYNbLRosdDeiB/MBSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0kCdiIFr/BbiXI6viGcHQfsyowHpdaOjCxApTIBEUWs=;
 b=dxz0cx9GSFBX3Goya2BnoxQtg+7nBWqGAt/MZl5ST+BJ7204M6TF55xPnwbDTdtFwlI4HIUHqeyGQKyMl+mMxWyntk+ZD1LOjQsj0wSXkZOUm2Jq+cLv2LLn23LssA6t0S2HwPXj6oxp3d3HDoql4iqYwfJFvLQkTWlUirWe+rw=
Received: from DM5PR2201CA0003.namprd22.prod.outlook.com (2603:10b6:4:14::13)
 by DM5PR12MB2549.namprd12.prod.outlook.com (2603:10b6:4:bb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 20 Aug
 2021 13:54:35 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:14:cafe::cd) by DM5PR2201CA0003.outlook.office365.com
 (2603:10b6:4:14::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Fri, 20 Aug 2021 13:54:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 13:54:35 +0000
Received: from shashanks.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Fri, 20 Aug
 2021 08:54:32 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shashank Sharma <shashank.sharma@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, Alex Deucher <Alexander.Deucher@amd.com>, "Eddy
 Qin" <Eddy.Qin@amd.com>
Subject: [PATCH v3] drm/amdgpu/OLAND: clip the ref divider max value
Date: Fri, 20 Aug 2021 19:24:14 +0530
Message-ID: <20210820135414.982355-1-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c96ed16c-bf14-49c3-bb07-08d963e20b67
X-MS-TrafficTypeDiagnostic: DM5PR12MB2549:
X-Microsoft-Antispam-PRVS: <DM5PR12MB254975CA2E645B955C9D2DBFF2C19@DM5PR12MB2549.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nU7otwaj9r2P4ckhenM3AawTMsQ+W4bUrhWk5d/ljZCbB1NBUUrhUEHdbCwyBRZFg4ja9TrUB67s+UnXk7fm1DshpHaB8xd1XY4HxiLARtHpLbtEz29jVucSLZEUrmx4dmPM0EnvZqj/I4+IrgPbbkR++H3On16xTBOKfkHnrA/E5ZAxB5fcdtvGBxfpM2XpgFTl1GzumA/fr5o12fgUKegpn00MTgLIryOzRF59iUaCXNAUpcRB1U81Mnx1a8UhR9XcepK47DZ/J2jBQp5vVuVMu75qxU+ONue005UDKGCc651ixu3sU5LTAm09URUUpTA+5yjOdIp2XLQmExNSRGHVCqGwu/BawL7rnTewdYkYD8YaCkPFpLhlUUAOizHJoytq1nypHETF1wcqOrunW+UmoAVlzViawFQXmYFnXevmhkhQA3IH1WyUOMY3aj2heK2vP8opmeFyxQ5kKK36KIV1+eRDsX0nfzCRyo1M2z7D4P0CP0VpkGmas1+99Olt8sy2U0D2KI5M9NifSvSTLf75ZE/d27uhSaxupm6Kln1CPdVRhedRrJEdv5ZKX/0fTxUIR5VROaDKRXdW8x5UnYypFsxkDFx97Iq3jH6nIdvXVjV5SByPFHvQ70Yt/kzEPzrixGXw1JAjPJUO89vV438/5dlmHHgEUyLI5QzJqo9Et8CRPpV8yjgEliVZ9wtxtHKWEvvhyEb5XBp72q/6aQSoQqN7xvnjRgdqmZ3Wq4ZmTFrlNHXHNT7EGpDydBI03cxDhiLvCiYA09OoifjQbpLLtovW8gh6F2Ufr9ACalqoNyEi1xU2QCqELWLHi4kUziZUM66wIxNSn2suqstnlea4jjQZYDeQtln4WLOqwUs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(136003)(396003)(46966006)(36840700001)(54906003)(8676002)(4326008)(6666004)(86362001)(83380400001)(478600001)(2616005)(6916009)(7696005)(34020700004)(5660300002)(70206006)(44832011)(2906002)(1076003)(186003)(66574015)(966005)(82310400003)(70586007)(16526019)(36756003)(47076005)(356005)(81166007)(26005)(8936002)(82740400003)(316002)(336012)(36860700001)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 13:54:35.3872 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c96ed16c-bf14-49c3-bb07-08d963e20b67
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2549
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

This patch limits the ref_div_max value to 100, during the
calculation of PLL feedback reference divider. With current
value (128), the produced fb_ref_div value generates unstable
output at particular frequencies. Radeon driver limits this
value at 100.

On Oland, when we try to setup mode 2048x1280@60 (a bit weird,
I know), it demands a clock of 221270 Khz. It's been observed
that the PLL calculations using values 128 and 100 are vastly
different, and look like this:

+------------------------------------------+
|Parameter    |AMDGPU        |Radeon       |
|             |              |             |
+-------------+----------------------------+
|Clock feedback              |             |
|divider max  |  128         |   100       |
|cap value    |              |             |
|             |              |             |
|             |              |             |
+------------------------------------------+
|ref_div_max  |              |             |
|             |  42          |  20         |
|             |              |             |
|             |              |             |
+------------------------------------------+
|ref_div      |  42          |  20         |
|             |              |             |
+------------------------------------------+
|fb_div       |  10326       |  8195       |
+------------------------------------------+
|fb_div       |  1024        |  163        |
+------------------------------------------+
|fb_dev_p     |  4           |  9          |
|frac fb_de^_p|              |             |
+----------------------------+-------------+

With ref_div_max value clipped at 100, AMDGPU driver can also
drive videmode 2048x1280@60 (221Mhz) and produce proper output
without any blanking and distortion on the screen.

PS: This value was changed from 128 to 100 in Radeon driver also, here:
https://github.com/freedesktop/drm-tip/commit/4b21ce1b4b5d262e7d4656b8ececc891fc3cb806

V1:
Got acks from:
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>

V2:
- Restricting the changes only for OLAND, just to avoid any regression
  for other cards.
- Changed unsigned -> unsigned int to make checkpatch quiet.

V3: Apply the change on SI family (not only oland) (Christian)

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Eddy Qin <Eddy.Qin@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c    | 20 +++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_pll.h    |  3 ++-
 drivers/gpu/drm/amd/amdgpu/atombios_crtc.c |  2 +-
 3 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c
index f2e20666c9c1..4eaec446b49d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c
@@ -80,12 +80,17 @@ static void amdgpu_pll_reduce_ratio(unsigned *nom, unsigned *den,
  * Calculate feedback and reference divider for a given post divider. Makes
  * sure we stay within the limits.
  */
-static void amdgpu_pll_get_fb_ref_div(unsigned nom, unsigned den, unsigned post_div,
-				      unsigned fb_div_max, unsigned ref_div_max,
-				      unsigned *fb_div, unsigned *ref_div)
+static void amdgpu_pll_get_fb_ref_div(struct amdgpu_device *adev, unsigned int nom,
+				      unsigned int den, unsigned int post_div,
+				      unsigned int fb_div_max, unsigned int ref_div_max,
+				      unsigned int *fb_div, unsigned int *ref_div)
 {
+
 	/* limit reference * post divider to a maximum */
-	ref_div_max = min(128 / post_div, ref_div_max);
+	if (adev->family == AMDGPU_FAMILY_SI)
+		ref_div_max = min(100 / post_div, ref_div_max);
+	else
+		ref_div_max = min(128 / post_div, ref_div_max);
 
 	/* get matching reference and feedback divider */
 	*ref_div = min(max(DIV_ROUND_CLOSEST(den, post_div), 1u), ref_div_max);
@@ -112,7 +117,8 @@ static void amdgpu_pll_get_fb_ref_div(unsigned nom, unsigned den, unsigned post_
  * Try to calculate the PLL parameters to generate the given frequency:
  * dot_clock = (ref_freq * feedback_div) / (ref_div * post_div)
  */
-void amdgpu_pll_compute(struct amdgpu_pll *pll,
+void amdgpu_pll_compute(struct amdgpu_device *adev,
+			struct amdgpu_pll *pll,
 			u32 freq,
 			u32 *dot_clock_p,
 			u32 *fb_div_p,
@@ -199,7 +205,7 @@ void amdgpu_pll_compute(struct amdgpu_pll *pll,
 
 	for (post_div = post_div_min; post_div <= post_div_max; ++post_div) {
 		unsigned diff;
-		amdgpu_pll_get_fb_ref_div(nom, den, post_div, fb_div_max,
+		amdgpu_pll_get_fb_ref_div(adev, nom, den, post_div, fb_div_max,
 					  ref_div_max, &fb_div, &ref_div);
 		diff = abs(target_clock - (pll->reference_freq * fb_div) /
 			(ref_div * post_div));
@@ -214,7 +220,7 @@ void amdgpu_pll_compute(struct amdgpu_pll *pll,
 	post_div = post_div_best;
 
 	/* get the feedback and reference divider for the optimal value */
-	amdgpu_pll_get_fb_ref_div(nom, den, post_div, fb_div_max, ref_div_max,
+	amdgpu_pll_get_fb_ref_div(adev, nom, den, post_div, fb_div_max, ref_div_max,
 				  &fb_div, &ref_div);
 
 	/* reduce the numbers to a simpler ratio once more */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.h
index db6136f68b82..44a583d6c9b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.h
@@ -24,7 +24,8 @@
 #ifndef __AMDGPU_PLL_H__
 #define __AMDGPU_PLL_H__
 
-void amdgpu_pll_compute(struct amdgpu_pll *pll,
+void amdgpu_pll_compute(struct amdgpu_device *adev,
+			 struct amdgpu_pll *pll,
 			 u32 freq,
 			 u32 *dot_clock_p,
 			 u32 *fb_div_p,
diff --git a/drivers/gpu/drm/amd/amdgpu/atombios_crtc.c b/drivers/gpu/drm/amd/amdgpu/atombios_crtc.c
index 159a2a4385a1..afad094f84c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/atombios_crtc.c
+++ b/drivers/gpu/drm/amd/amdgpu/atombios_crtc.c
@@ -851,7 +851,7 @@ void amdgpu_atombios_crtc_set_pll(struct drm_crtc *crtc, struct drm_display_mode
 	pll->reference_div = amdgpu_crtc->pll_reference_div;
 	pll->post_div = amdgpu_crtc->pll_post_div;
 
-	amdgpu_pll_compute(pll, amdgpu_crtc->adjusted_clock, &pll_clock,
+	amdgpu_pll_compute(adev, pll, amdgpu_crtc->adjusted_clock, &pll_clock,
 			    &fb_div, &frac_fb_div, &ref_div, &post_div);
 
 	amdgpu_atombios_crtc_program_ss(adev, ATOM_DISABLE, amdgpu_crtc->pll_id,
-- 
2.25.1

