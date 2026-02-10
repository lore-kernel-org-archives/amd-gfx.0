Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B61FEEA8118
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Feb 2026 13:55:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 433BC10E589;
	Tue, 10 Feb 2026 13:55:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fQAeAFUG";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011029.outbound.protection.outlook.com [52.101.52.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30E8A10E592
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 13:55:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w4+fm1ABZrP5AGLE0LEcJ5N11pYcMKZrjqEKuGdZlAr3bmfjJLzGGbz0IyPxocJpbxsZiIvEeBDgy1h62RVxhQJ93mgrh4fgViQnQlbdql2TWd6w6lE6Dkj7iru8/rmSbiHsa5IYCOtAnSsihpFnVndxNqaoHmq3m3SVO6RF6ExIDKOnpH7xwj8DR52lpeQ/m5xchsBSwSZkayBZjxHearMoaIpvYahpn26NnARbAkBM3tDL8/hkg4WDtEc2CogNeyTlWMAWgU+OsPfn7qCYbunWDpn2EGPyNfxSzBfV3quBO4h0jc1hoYza0+/hZ3seCb3rMa19U+NtdvYiEogWxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ipckr9hM7M8n5bjGXlBSXZPulPlQdNOMgm5Ieood0CA=;
 b=xeXsyTe5s2niVIN9eBLaxN/D4ibK02Zg0yxyKvnGrAU8gyRt+5NPZ2vKjUhI8rC20n2jUCX1W4JqQsu7UZn8/vuUg61lrHwuh0WUPEHe0lz7Lek/J6+viBdc5mi9N19tO0c+QkvCU/az5xpSrlbO5yoIRMg/1Ezgt79BugJ1eii0amI2RP8Y8odEmKMKxLihkxYm6m8CzKAXJ6zTpUr/XFBdrVv1xR9cxiaWTZXv/RMK19J8SMy04fVVb9i739/J8C+4VpPPN2qF0GsQSg7uCN5skL70cM4yE5E0ffzU3fzcFFgi3/M0OL/b1nEJUAQplOtM8s8poQ3FSgGMJeXLRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ipckr9hM7M8n5bjGXlBSXZPulPlQdNOMgm5Ieood0CA=;
 b=fQAeAFUGqMLvL2ZN5hhz1CyusQTlOIvjdfeWFgEBoeaKXiR45I5x+u+PRqL5xDKVJcgaiFtirLa0l3oRogl4XLdEiU6tjsWqkvkzUpSy8Mto/687y7K5QdmT0ZAUV/J22Ermpaq2b8LejlT5LlWeDGvv7oSTm1dqkFK5X/3p2d0=
Received: from CH0PR04CA0103.namprd04.prod.outlook.com (2603:10b6:610:75::18)
 by MW4PR12MB7358.namprd12.prod.outlook.com (2603:10b6:303:22b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Tue, 10 Feb
 2026 13:55:28 +0000
Received: from DS3PEPF0000C381.namprd04.prod.outlook.com
 (2603:10b6:610:75:cafe::21) by CH0PR04CA0103.outlook.office365.com
 (2603:10b6:610:75::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.19 via Frontend Transport; Tue,
 10 Feb 2026 13:55:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C381.mail.protection.outlook.com (10.167.23.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Tue, 10 Feb 2026 13:55:28 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Feb
 2026 07:55:25 -0600
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 10 Feb 2026 07:55:17 -0600
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Bhuvanachandra Pinninti
 <BhuvanaChandra.Pinninti@amd.com>, Martin Leung <Martin.Leung@amd.com>, "Ray
 Wu" <ray.wu@amd.com>
Subject: [PATCH 08/18] drm/amd/display: Migrate DCCG registers access from
 hwseq to dccg component.
Date: Tue, 10 Feb 2026 21:50:01 +0800
Message-ID: <20260210135353.848421-9-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260210135353.848421-1-ray.wu@amd.com>
References: <20260210135353.848421-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C381:EE_|MW4PR12MB7358:EE_
X-MS-Office365-Filtering-Correlation-Id: bc5b2818-aed2-4cc1-d8a8-08de68ac0c4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GEe+qBppHw6agNoZOkMATnc3aVhPPqoIQ9WIeNyvLeLoJIyGMmQP5vO3HYOB?=
 =?us-ascii?Q?XUOP8AGbJrZ7IPBWPtBGjBgnZpBsyK04fWEFP/XxMJD+8viCHVR2Pa5Yvwbn?=
 =?us-ascii?Q?hRFw5fHNgHEpS7zttzkuWUNBtOSkQvQadOCsa76fa3A6iYdBMNs9evLqw8Nd?=
 =?us-ascii?Q?xqgW/78pDn8zEE0bJroYzaws+9ZyO689a5bXDAxgm9uU8Lzr3aSin6KifpG7?=
 =?us-ascii?Q?wq6wpvsFagiKoSSA2/Gf4NbbgxBN5wxFsA2flvmHu0NkPsF7Hx6MDGwggpvT?=
 =?us-ascii?Q?dmC9vpr8deSztgFgwnNyNut/qTEk8duFrGIjZDBybWQUKMPtP87WkyCc3iDx?=
 =?us-ascii?Q?NtQLh61ouIcGDMNOOo/wUMKZpPUm3TpkyYw9j1t6drR+e+1yfu9OYZKwXSgq?=
 =?us-ascii?Q?m4/BKJxbU0S/KJ2C3GoI/tX+QVNqPZZum8RFSYP5R803n0+4IUpWLQgB3fd2?=
 =?us-ascii?Q?Xerauz3osi6yTEcICWkdpJLtrBt7RHzXovRN+y+a711OjWlTQ1MGCORQ+Fmw?=
 =?us-ascii?Q?d4uJj88CBIPqMoRoFaC3CEXWOArvlyTt36ur19QPhiSGnUn9C+M2Inf0S2Lk?=
 =?us-ascii?Q?IotVgfUm1eDKTg2Zij2KtfbHDs8rF3R38SP7bPa7l+ZzY9lOWkl77CF1p4am?=
 =?us-ascii?Q?yGJRbNR+uwkWKB0WvPA+HZwUzEeWCT0sUneDgt9imjczJh1RzELxsjuCf7zj?=
 =?us-ascii?Q?oOqukLNddSf3Oaz8FUMP6jIs01pOrLGybrv25Y+Xorg59kjvOpGd4p3Dt059?=
 =?us-ascii?Q?VVqro9Vj6wyPaI6eW6q+5gFKVbhsWB63nVz2Rw62kSxHgbt9eNG29Nmrjn1f?=
 =?us-ascii?Q?QlHSj3lPJlFsjBrdaljJ9JnaTaCMZv4Lz7B8j2WJW2NZ0q75L0AwhWBvy1b5?=
 =?us-ascii?Q?YC8rgjk2c393dpZlHeWiLDifq1lslJ0eXkLGNaMMVxY2aCzYeJ7gVuqq8pm+?=
 =?us-ascii?Q?1e3ezSsNztSID//zlQ/ox+7K+l9B/OZz1CDu31IyRdbTSb4GMX/fIYS/jWfC?=
 =?us-ascii?Q?gZSTPwURP+uJha38qhv2zQyRKa4XdjEshWL5iOcMaKavx8J0diSQbJId5t82?=
 =?us-ascii?Q?8x48oFFjJxKZsmjMAH0jOaGKFKkWcvZHnFBmRRV30sF06KHco+kh2AsgMGE8?=
 =?us-ascii?Q?sXAoGQcQ7BnrTNQiLj/RjCYSLFVGuPiMPQYIFjBnP5u1v5JqRxS+YXjKxTub?=
 =?us-ascii?Q?7PZANJU0XGnr8voCXqdTmyP2baFKqWnhWxBa3r2WWYL9PXuyypLVee0I3+Ik?=
 =?us-ascii?Q?qR2rIOWaEliFsIgK6HJUOOGibQRgmNTTH2uvjCxePbnNNdFBR3/bXTw/xb2R?=
 =?us-ascii?Q?pSHp4I2AyY4Bu64iRYpjPz6esjtzUIgnK69jIeYELa6iWYCm/0WZumE2FYx2?=
 =?us-ascii?Q?DfTFlixbfTwxOlyCeQkhwlpwEjrCQD1fIOpMW54avns0lro7fSb1E1aNMLnM?=
 =?us-ascii?Q?LeJIuCp5nof0FBXkFatR/XFSOSByHmTqBw+XwnXWKnaBVPNoH97P02um1kZB?=
 =?us-ascii?Q?BahdCODFcxt2/Tq7FOohmtJhc77xyjsXCMFy3oeqqilE76r8t7Mxu0blmw1r?=
 =?us-ascii?Q?zoszppYGaSKVoJofEHPik2NkFoHceNyeK1hzBCz1lYMNQAd+7v0dU0PXZ/xi?=
 =?us-ascii?Q?ZkAreVn92VjmbbBrQ5U7dX42Q4N6ifTgGe9ywgLzaKrgguZGH30KAaB3P3Nx?=
 =?us-ascii?Q?hBBNxg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jc+libm7B60WcBs81QAzHpQDDsNgi26h1XJjKrBaET7sdeG4/1/uNzn+n5eCvzZhCTn2Eqjd731iwsdHC3XrzImY0rp4RpP0ewKG6R4/DQLmey+6vLp2uTQrX2cVVAEHLA0EuvJMXAQGkqXADzspshgLycKTFeGxg/GWXqPLxbN6lXCI2Rhww4W7GV9j9b7G4daeAWvBM4wIAdlOsMO/G9O7S3W76SPG/bITo0PcfK+FgfnViaboIPwUlgvSXj4/5fLom/FkynEaBp7qHo4rb1IVkuDdMSrsTu9AZQPz/hVmuuJLmqaVO8ebFm/leU8wAN1BMFXDSUF+UbuXnysaTpCWDP6DkXwF1V6vTxtd+gmQU9deKfHTKMzkJQDHe8KFulQrdHxRZKnP/66v9Qmpq3+KpCCSiicImkEBX1GPqKWX7IJn5n148eXmZCNNj+8w
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 13:55:28.2936 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc5b2818-aed2-4cc1-d8a8-08de68ac0c4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C381.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7358
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

From: Bhuvanachandra Pinninti <BhuvanaChandra.Pinninti@amd.com>

[Why]
Direct DCCG register access in hwseq layer was creating register conflicts.

[How]
Migrated DCCG registers from hwseq-dccg component.

Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Signed-off-by: Bhuvanachandra Pinninti <BhuvanaChandra.Pinninti@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../amd/display/dc/dccg/dcn20/dcn20_dccg.c    | 54 ++++++++++++++++++-
 .../amd/display/dc/dccg/dcn20/dcn20_dccg.h    | 14 +++--
 .../amd/display/dc/dccg/dcn201/dcn201_dccg.c  |  7 ++-
 .../amd/display/dc/dccg/dcn21/dcn21_dccg.c    |  6 ++-
 .../amd/display/dc/dccg/dcn30/dcn30_dccg.c    |  6 ++-
 .../amd/display/dc/dccg/dcn301/dcn301_dccg.c  |  6 ++-
 .../amd/display/dc/dccg/dcn31/dcn31_dccg.c    |  5 ++
 .../amd/display/dc/dccg/dcn314/dcn314_dccg.c  |  7 ++-
 .../amd/display/dc/dccg/dcn32/dcn32_dccg.c    |  5 ++
 .../amd/display/dc/dccg/dcn35/dcn35_dccg.c    | 11 +++-
 .../amd/display/dc/dccg/dcn401/dcn401_dccg.c  |  2 +
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |  5 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   | 29 +++-------
 .../amd/display/dc/hwss/dcn201/dcn201_hwseq.c |  5 +-
 .../amd/display/dc/hwss/dcn21/dcn21_hwseq.c   |  9 ++--
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |  5 +-
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |  5 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |  5 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  3 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  5 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |  4 ++
 21 files changed, 143 insertions(+), 55 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.c
index 33d8bd91cb01..733b85d450d9 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.c
@@ -131,6 +131,54 @@ void dccg2_otg_drop_pixel(struct dccg *dccg,
 
 void dccg2_init(struct dccg *dccg)
 {
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	/* Hardcoded register values for DCN20
+	 * These are specific to 100Mhz refclk
+	 * Different ASICs with different refclk may override this in their own init
+	 */
+	REG_WRITE(MICROSECOND_TIME_BASE_DIV, 0x00120264);
+	REG_WRITE(MILLISECOND_TIME_BASE_DIV, 0x001186a0);
+	REG_WRITE(DISPCLK_FREQ_CHANGE_CNTL, 0x0e01003c);
+
+	if (REG(REFCLK_CNTL))
+		REG_WRITE(REFCLK_CNTL, 0);
+}
+
+void dccg2_refclk_setup(struct dccg *dccg)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	/* REFCLK programming that must occur after hubbub initialization */
+	if (REG(REFCLK_CNTL))
+		REG_WRITE(REFCLK_CNTL, 0);
+}
+
+bool dccg2_is_s0i3_golden_init_wa_done(struct dccg *dccg)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	return REG_READ(MICROSECOND_TIME_BASE_DIV) == 0x00120464;
+}
+
+void dccg2_allow_clock_gating(struct dccg *dccg, bool allow)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	if (allow) {
+		REG_WRITE(DCCG_GATE_DISABLE_CNTL, 0);
+		REG_WRITE(DCCG_GATE_DISABLE_CNTL2, 0);
+	} else {
+		REG_WRITE(DCCG_GATE_DISABLE_CNTL, 0xFFFFFFFF);
+		REG_WRITE(DCCG_GATE_DISABLE_CNTL2, 0xFFFFFFFF);
+	}
+}
+
+void dccg2_enable_memory_low_power(struct dccg *dccg, bool enable)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	REG_UPDATE(DC_MEM_GLOBAL_PWR_REQ_CNTL, DC_MEM_GLOBAL_PWR_REQ_DIS, enable ? 0 : 1);
 }
 
 static const struct dccg_funcs dccg2_funcs = {
@@ -139,7 +187,11 @@ static const struct dccg_funcs dccg2_funcs = {
 	.set_fifo_errdet_ovr_en = dccg2_set_fifo_errdet_ovr_en,
 	.otg_add_pixel = dccg2_otg_add_pixel,
 	.otg_drop_pixel = dccg2_otg_drop_pixel,
-	.dccg_init = dccg2_init
+	.dccg_init = dccg2_init,
+	.refclk_setup = dccg2_refclk_setup, /* Deprecated - for backward compatibility only */
+	.allow_clock_gating = dccg2_allow_clock_gating,
+	.enable_memory_low_power = dccg2_enable_memory_low_power,
+	.is_s0i3_golden_init_wa_done = dccg2_is_s0i3_golden_init_wa_done /* Deprecated - for backward compatibility only */
 };
 
 struct dccg *dccg2_create(
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.h b/drivers/gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.h
index 8bdffd9ff31b..3711d400773a 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.h
@@ -37,7 +37,8 @@
 	SR(REFCLK_CNTL),\
 	DCCG_SRII(PIXEL_RATE_CNTL, OTG, 0),\
 	DCCG_SRII(PIXEL_RATE_CNTL, OTG, 1),\
-	SR(DISPCLK_FREQ_CHANGE_CNTL)
+	SR(DISPCLK_FREQ_CHANGE_CNTL),\
+	SR(DC_MEM_GLOBAL_PWR_REQ_CNTL)
 
 #define DCCG_REG_LIST_DCN2() \
 	DCCG_COMMON_REG_LIST_DCN_BASE(),\
@@ -81,7 +82,8 @@
 	DCCG_SFII(OTG, PIXEL_RATE_CNTL, OTG, ADD_PIXEL, 0, mask_sh),\
 	DCCG_SFII(OTG, PIXEL_RATE_CNTL, OTG, ADD_PIXEL, 1, mask_sh),\
 	DCCG_SFII(OTG, PIXEL_RATE_CNTL, OTG, DROP_PIXEL, 0, mask_sh),\
-	DCCG_SFII(OTG, PIXEL_RATE_CNTL, OTG, DROP_PIXEL, 1, mask_sh)
+	DCCG_SFII(OTG, PIXEL_RATE_CNTL, OTG, DROP_PIXEL, 1, mask_sh),\
+	DCCG_SF(DC_MEM_GLOBAL_PWR_REQ_CNTL, DC_MEM_GLOBAL_PWR_REQ_DIS, mask_sh)
 
 
 
@@ -130,7 +132,8 @@
 	type DISPCLK_CHG_FWD_CORR_DISABLE;\
 	type DISPCLK_FREQ_CHANGE_CNTL;\
 	type OTG_ADD_PIXEL[MAX_PIPES];\
-	type OTG_DROP_PIXEL[MAX_PIPES];
+	type OTG_DROP_PIXEL[MAX_PIPES];\
+	type DC_MEM_GLOBAL_PWR_REQ_DIS;
 
 #define DCCG3_REG_FIELD_LIST(type) \
 	type HDMICHARCLK0_EN;\
@@ -515,6 +518,11 @@ void dccg2_otg_drop_pixel(struct dccg *dccg,
 
 void dccg2_init(struct dccg *dccg);
 
+void dccg2_refclk_setup(struct dccg *dccg);
+void dccg2_allow_clock_gating(struct dccg *dccg, bool allow);
+void dccg2_enable_memory_low_power(struct dccg *dccg, bool enable);
+bool dccg2_is_s0i3_golden_init_wa_done(struct dccg *dccg);
+
 struct dccg *dccg2_create(
 	struct dc_context *ctx,
 	const struct dccg_registers *regs,
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn201/dcn201_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn201/dcn201_dccg.c
index 9a3402148fde..79d14ce19393 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn201/dcn201_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn201/dcn201_dccg.c
@@ -24,6 +24,7 @@
  */
 
 #include "dcn201_dccg.h"
+#include "dcn20/dcn20_dccg.h"
 
 #include "reg_helper.h"
 #include "core_types.h"
@@ -56,7 +57,11 @@ static const struct dccg_funcs dccg201_funcs = {
 	.set_fifo_errdet_ovr_en = dccg2_set_fifo_errdet_ovr_en,
 	.otg_add_pixel = dccg2_otg_add_pixel,
 	.otg_drop_pixel = dccg2_otg_drop_pixel,
-	.dccg_init = dccg2_init
+	.dccg_init = dccg2_init,
+	.refclk_setup = dccg2_refclk_setup, /* Deprecated - for backward compatibility only */
+	.allow_clock_gating = dccg2_allow_clock_gating,
+	.enable_memory_low_power = dccg2_enable_memory_low_power,
+	.is_s0i3_golden_init_wa_done = dccg2_is_s0i3_golden_init_wa_done /* Deprecated - for backward compatibility only */
 };
 
 struct dccg *dccg201_create(
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn21/dcn21_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn21/dcn21_dccg.c
index d07c04458d31..b48dcafbae66 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn21/dcn21_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn21/dcn21_dccg.c
@@ -103,7 +103,11 @@ static const struct dccg_funcs dccg21_funcs = {
 	.set_fifo_errdet_ovr_en = dccg2_set_fifo_errdet_ovr_en,
 	.otg_add_pixel = dccg2_otg_add_pixel,
 	.otg_drop_pixel = dccg2_otg_drop_pixel,
-	.dccg_init = dccg2_init
+	.dccg_init = dccg2_init,
+	.refclk_setup = dccg2_refclk_setup, /* Deprecated - for backward compatibility only */
+	.allow_clock_gating = dccg2_allow_clock_gating,
+	.enable_memory_low_power = dccg2_enable_memory_low_power,
+	.is_s0i3_golden_init_wa_done = dccg2_is_s0i3_golden_init_wa_done /* Deprecated - for backward compatibility only */
 };
 
 struct dccg *dccg21_create(
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn30/dcn30_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn30/dcn30_dccg.c
index d445dfefc047..adec7c3c2d49 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn30/dcn30_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn30/dcn30_dccg.c
@@ -49,7 +49,11 @@ static const struct dccg_funcs dccg3_funcs = {
 	.set_fifo_errdet_ovr_en = dccg2_set_fifo_errdet_ovr_en,
 	.otg_add_pixel = dccg2_otg_add_pixel,
 	.otg_drop_pixel = dccg2_otg_drop_pixel,
-	.dccg_init = dccg2_init
+	.dccg_init = dccg2_init,
+	.refclk_setup = dccg2_refclk_setup, /* Deprecated - for backward compatibility only */
+	.allow_clock_gating = dccg2_allow_clock_gating,
+	.enable_memory_low_power = dccg2_enable_memory_low_power,
+	.is_s0i3_golden_init_wa_done = dccg2_is_s0i3_golden_init_wa_done /* Deprecated - for backward compatibility only */
 };
 
 struct dccg *dccg3_create(
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn301/dcn301_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn301/dcn301_dccg.c
index 97e9be87afd9..fc9bddd94b50 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn301/dcn301_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn301/dcn301_dccg.c
@@ -48,7 +48,11 @@ static const struct dccg_funcs dccg301_funcs = {
 	.set_fifo_errdet_ovr_en = dccg2_set_fifo_errdet_ovr_en,
 	.otg_add_pixel = dccg2_otg_add_pixel,
 	.otg_drop_pixel = dccg2_otg_drop_pixel,
-	.dccg_init = dccg2_init
+	.dccg_init = dccg2_init,
+	.refclk_setup = dccg2_refclk_setup, /* Deprecated - for backward compatibility only */
+	.allow_clock_gating = dccg2_allow_clock_gating,
+	.enable_memory_low_power = dccg2_enable_memory_low_power,
+	.is_s0i3_golden_init_wa_done = dccg2_is_s0i3_golden_init_wa_done /* Deprecated - for backward compatibility only */
 };
 
 struct dccg *dccg301_create(
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn31/dcn31_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn31/dcn31_dccg.c
index 97df04b7e39d..c647dff5234a 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn31/dcn31_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn31/dcn31_dccg.c
@@ -26,6 +26,7 @@
 #include "reg_helper.h"
 #include "core_types.h"
 #include "dcn31_dccg.h"
+#include "dcn20/dcn20_dccg.h"
 #include "dal_asic_id.h"
 
 #define TO_DCN_DCCG(dccg)\
@@ -850,6 +851,10 @@ static const struct dccg_funcs dccg31_funcs = {
 	.disable_dsc = dccg31_disable_dscclk,
 	.enable_dsc = dccg31_enable_dscclk,
 	.dccg_read_reg_state = dccg31_read_reg_state,
+	.refclk_setup = dccg2_refclk_setup, /* Deprecated - for backward compatibility only */
+	.allow_clock_gating = dccg2_allow_clock_gating,
+	.enable_memory_low_power = dccg2_enable_memory_low_power,
+	.is_s0i3_golden_init_wa_done = dccg2_is_s0i3_golden_init_wa_done /* Deprecated - for backward compatibility only */
 };
 
 struct dccg *dccg31_create(
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn314/dcn314_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn314/dcn314_dccg.c
index ef3db6beba25..2e9c4b13988a 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn314/dcn314_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn314/dcn314_dccg.c
@@ -29,6 +29,7 @@
 
 #include "dcn31/dcn31_dccg.h"
 #include "dcn314_dccg.h"
+#include "dcn20/dcn20_dccg.h"
 
 #define TO_DCN_DCCG(dccg)\
 	container_of(dccg, struct dcn_dccg, base)
@@ -378,7 +379,11 @@ static const struct dccg_funcs dccg314_funcs = {
 	.trigger_dio_fifo_resync = dccg314_trigger_dio_fifo_resync,
 	.set_valid_pixel_rate = dccg314_set_valid_pixel_rate,
 	.set_dtbclk_p_src = dccg314_set_dtbclk_p_src,
-	.dccg_read_reg_state = dccg31_read_reg_state
+	.dccg_read_reg_state = dccg31_read_reg_state,
+	.refclk_setup = dccg2_refclk_setup, /* Deprecated - for backward compatibility only */
+	.allow_clock_gating = dccg2_allow_clock_gating,
+	.enable_memory_low_power = dccg2_enable_memory_low_power,
+	.is_s0i3_golden_init_wa_done = dccg2_is_s0i3_golden_init_wa_done /* Deprecated - for backward compatibility only */
 };
 
 struct dccg *dccg314_create(
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn32/dcn32_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn32/dcn32_dccg.c
index 21a6ca5ca192..ce697c3249fb 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn32/dcn32_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn32/dcn32_dccg.c
@@ -26,6 +26,7 @@
 #include "reg_helper.h"
 #include "core_types.h"
 #include "dcn32_dccg.h"
+#include "dcn20/dcn20_dccg.h"
 
 #define TO_DCN_DCCG(dccg)\
 	container_of(dccg, struct dcn_dccg, base)
@@ -347,6 +348,10 @@ static const struct dccg_funcs dccg32_funcs = {
 	.get_pixel_rate_div = dccg32_get_pixel_rate_div,
 	.trigger_dio_fifo_resync = dccg32_trigger_dio_fifo_resync,
 	.set_dtbclk_p_src = dccg32_set_dtbclk_p_src,
+	.refclk_setup = dccg2_refclk_setup, /* Deprecated - for backward compatibility only */
+	.allow_clock_gating = dccg2_allow_clock_gating,
+	.enable_memory_low_power = dccg2_enable_memory_low_power,
+	.is_s0i3_golden_init_wa_done = dccg2_is_s0i3_golden_init_wa_done /* Deprecated - for backward compatibility only */
 };
 
 struct dccg *dccg32_create(
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
index 838c6617c029..943ec1983076 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
@@ -26,6 +26,7 @@
 #include "core_types.h"
 #include "resource.h"
 #include "dcn35_dccg.h"
+#include "dcn20/dcn20_dccg.h"
 
 #define TO_DCN_DCCG(dccg)\
 	container_of(dccg, struct dcn_dccg, base)
@@ -2411,6 +2412,10 @@ static const struct dccg_funcs dccg35_funcs_new = {
 	.enable_symclk_se = dccg35_enable_symclk_se_cb,
 	.disable_symclk_se = dccg35_disable_symclk_se_cb,
 	.set_dtbclk_p_src = dccg35_set_dtbclk_p_src_cb,
+	.refclk_setup = dccg2_refclk_setup, /* Deprecated - for backward compatibility only */
+	.allow_clock_gating = dccg2_allow_clock_gating,
+	.enable_memory_low_power = dccg2_enable_memory_low_power,
+	.is_s0i3_golden_init_wa_done = dccg2_is_s0i3_golden_init_wa_done /* Deprecated - for backward compatibility only */
 };
 
 static const struct dccg_funcs dccg35_funcs = {
@@ -2442,8 +2447,12 @@ static const struct dccg_funcs dccg35_funcs = {
 	.enable_symclk_se = dccg35_enable_symclk_se,
 	.disable_symclk_se = dccg35_disable_symclk_se,
 	.set_dtbclk_p_src = dccg35_set_dtbclk_p_src,
+	.refclk_setup = dccg2_refclk_setup, /* Deprecated - for backward compatibility only */
+	.allow_clock_gating = dccg2_allow_clock_gating,
+	.enable_memory_low_power = dccg2_enable_memory_low_power,
+	.is_s0i3_golden_init_wa_done = dccg2_is_s0i3_golden_init_wa_done, /* Deprecated - for backward compatibility only */
 	.dccg_root_gate_disable_control = dccg35_root_gate_disable_control,
-	.dccg_read_reg_state = dccg31_read_reg_state,
+	.dccg_read_reg_state = dccg31_read_reg_state
 };
 
 struct dccg *dccg35_create(
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c
index 3063b6ab32e5..f1d394560892 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c
@@ -27,6 +27,7 @@
 #include "core_types.h"
 #include "dcn401_dccg.h"
 #include "dcn31/dcn31_dccg.h"
+#include "dcn20/dcn20_dccg.h"
 
 /*
 #include "dmub_common.h"
@@ -861,6 +862,7 @@ static const struct dccg_funcs dccg401_funcs = {
 	.update_dpp_dto = dccg401_update_dpp_dto,
 	.get_dccg_ref_freq = dccg401_get_dccg_ref_freq,
 	.dccg_init = dccg401_init,
+	.allow_clock_gating = dccg2_allow_clock_gating,
 	.set_dpstreamclk = dccg401_set_dpstreamclk,
 	.enable_symclk32_se = dccg31_enable_symclk32_se,
 	.disable_symclk32_se = dccg31_disable_symclk32_se,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index 9613d1ceb5dc..5243177c1faa 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -1887,9 +1887,8 @@ void dcn10_init_hw(struct dc *dc)
 
 	if (!dc->debug.disable_clock_gate) {
 		/* enable all DCN clock gating */
-		REG_WRITE(DCCG_GATE_DISABLE_CNTL, 0);
-
-		REG_WRITE(DCCG_GATE_DISABLE_CNTL2, 0);
+		if (dc->res_pool->dccg && dc->res_pool->dccg->funcs && dc->res_pool->dccg->funcs->allow_clock_gating)
+			dc->res_pool->dccg->funcs->allow_clock_gating(dc->res_pool->dccg, true);
 
 		REG_UPDATE(DCFCLK_CNTL, DCFCLK_GATE_DIS, 0);
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index 0ee3a0041c61..307e8f8060e6 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -357,26 +357,10 @@ void dcn20_enable_power_gating_plane(
 
 void dcn20_dccg_init(struct dce_hwseq *hws)
 {
-	/*
-	 * set MICROSECOND_TIME_BASE_DIV
-	 * 100Mhz refclk -> 0x120264
-	 * 27Mhz refclk -> 0x12021b
-	 * 48Mhz refclk -> 0x120230
-	 *
-	 */
-	REG_WRITE(MICROSECOND_TIME_BASE_DIV, 0x120264);
-
-	/*
-	 * set MILLISECOND_TIME_BASE_DIV
-	 * 100Mhz refclk -> 0x1186a0
-	 * 27Mhz refclk -> 0x106978
-	 * 48Mhz refclk -> 0x10bb80
-	 *
-	 */
-	REG_WRITE(MILLISECOND_TIME_BASE_DIV, 0x1186a0);
+	struct dc *dc = hws->ctx->dc;
 
-	/* This value is dependent on the hardware pipeline delay so set once per SOC */
-	REG_WRITE(DISPCLK_FREQ_CHANGE_CNTL, 0xe01003c);
+	if (dc->res_pool->dccg && dc->res_pool->dccg->funcs && dc->res_pool->dccg->funcs->dccg_init)
+		dc->res_pool->dccg->funcs->dccg_init(dc->res_pool->dccg);
 }
 
 void dcn20_disable_vga(
@@ -3156,8 +3140,11 @@ void dcn20_fpga_init_hw(struct dc *dc)
 
 	dcn10_hubbub_global_timer_enable(dc->res_pool->hubbub, true, 2);
 
-	if (REG(REFCLK_CNTL))
-		REG_WRITE(REFCLK_CNTL, 0);
+	if (hws->funcs.dccg_init)
+		hws->funcs.dccg_init(hws);
+
+	if (dc->res_pool->dccg && dc->res_pool->dccg->funcs && dc->res_pool->dccg->funcs->refclk_setup)
+		dc->res_pool->dccg->funcs->refclk_setup(dc->res_pool->dccg);
 	//
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_hwseq.c
index 6298bd87a18b..ce18d75fd991 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_hwseq.c
@@ -367,9 +367,8 @@ void dcn201_init_hw(struct dc *dc)
 
 	if (!dc->debug.disable_clock_gate) {
 		/* enable all DCN clock gating */
-		REG_WRITE(DCCG_GATE_DISABLE_CNTL, 0);
-
-		REG_WRITE(DCCG_GATE_DISABLE_CNTL2, 0);
+		if (dc->res_pool->dccg && dc->res_pool->dccg->funcs && dc->res_pool->dccg->funcs->allow_clock_gating)
+			dc->res_pool->dccg->funcs->allow_clock_gating(dc->res_pool->dccg, true);
 
 		REG_UPDATE(DCFCLK_CNTL, DCFCLK_GATE_DIS, 0);
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
index e2269211553c..062745389d9a 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
@@ -33,6 +33,7 @@
 #include "vmid.h"
 #include "reg_helper.h"
 #include "hw/clk_mgr.h"
+#include "hw/dccg.h"
 #include "dc_dmub_srv.h"
 #include "abm.h"
 #include "link_service.h"
@@ -87,12 +88,10 @@ int dcn21_init_sys_ctx(struct dce_hwseq *hws, struct dc *dc, struct dc_phy_addr_
 
 bool dcn21_s0i3_golden_init_wa(struct dc *dc)
 {
-	struct dce_hwseq *hws = dc->hwseq;
-	uint32_t value = 0;
+	if (dc->res_pool->dccg && dc->res_pool->dccg->funcs && dc->res_pool->dccg->funcs->is_s0i3_golden_init_wa_done)
+		return !dc->res_pool->dccg->funcs->is_s0i3_golden_init_wa_done(dc->res_pool->dccg);
 
-	value = REG_READ(MICROSECOND_TIME_BASE_DIV);
-
-	return value != 0x00120464;
+	return false;
 }
 
 void dcn21_exit_optimized_pwr_state(
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
index 333275088a6c..d04cfd403b7e 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
@@ -801,9 +801,8 @@ void dcn30_init_hw(struct dc *dc)
 
 	if (!dc->debug.disable_clock_gate) {
 		/* enable all DCN clock gating */
-		REG_WRITE(DCCG_GATE_DISABLE_CNTL, 0);
-
-		REG_WRITE(DCCG_GATE_DISABLE_CNTL2, 0);
+		if (dc->res_pool->dccg && dc->res_pool->dccg->funcs && dc->res_pool->dccg->funcs->allow_clock_gating)
+			dc->res_pool->dccg->funcs->allow_clock_gating(dc->res_pool->dccg, true);
 
 		REG_UPDATE(DCFCLK_CNTL, DCFCLK_GATE_DIS, 0);
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
index fa35d538a10a..db2f7cbb12ff 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
@@ -247,9 +247,8 @@ void dcn31_init_hw(struct dc *dc)
 
 	if (!dc->debug.disable_clock_gate) {
 		/* enable all DCN clock gating */
-		REG_WRITE(DCCG_GATE_DISABLE_CNTL, 0);
-
-		REG_WRITE(DCCG_GATE_DISABLE_CNTL2, 0);
+		if (dc->res_pool->dccg && dc->res_pool->dccg->funcs && dc->res_pool->dccg->funcs->allow_clock_gating)
+			dc->res_pool->dccg->funcs->allow_clock_gating(dc->res_pool->dccg, true);
 
 		REG_UPDATE(DCFCLK_CNTL, DCFCLK_GATE_DIS, 0);
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index 01fa459ae7b0..2767d3a97812 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -963,9 +963,8 @@ void dcn32_init_hw(struct dc *dc)
 
 	if (!dc->debug.disable_clock_gate) {
 		/* enable all DCN clock gating */
-		REG_WRITE(DCCG_GATE_DISABLE_CNTL, 0);
-
-		REG_WRITE(DCCG_GATE_DISABLE_CNTL2, 0);
+		if (dc->res_pool->dccg && dc->res_pool->dccg->funcs && dc->res_pool->dccg->funcs->allow_clock_gating)
+			dc->res_pool->dccg->funcs->allow_clock_gating(dc->res_pool->dccg, true);
 
 		REG_UPDATE(DCFCLK_CNTL, DCFCLK_GATE_DIS, 0);
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index d757a0fdc62c..726aca9f9b82 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -287,7 +287,8 @@ void dcn35_init_hw(struct dc *dc)
 	}
 
 	if (dc->debug.disable_mem_low_power) {
-		REG_UPDATE(DC_MEM_GLOBAL_PWR_REQ_CNTL, DC_MEM_GLOBAL_PWR_REQ_DIS, 1);
+		if (dc->res_pool->dccg && dc->res_pool->dccg->funcs && dc->res_pool->dccg->funcs->enable_memory_low_power)
+			dc->res_pool->dccg->funcs->enable_memory_low_power(dc->res_pool->dccg, false);
 	}
 	if (!dcb->funcs->is_accelerated_mode(dcb) && dc->res_pool->hubbub->funcs->init_watermarks)
 		dc->res_pool->hubbub->funcs->init_watermarks(dc->res_pool->hubbub);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index d1515039e824..b91517b9fedc 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -326,9 +326,8 @@ void dcn401_init_hw(struct dc *dc)
 
 	if (!dc->debug.disable_clock_gate) {
 		/* enable all DCN clock gating */
-		REG_WRITE(DCCG_GATE_DISABLE_CNTL, 0);
-
-		REG_WRITE(DCCG_GATE_DISABLE_CNTL2, 0);
+		if (dc->res_pool->dccg && dc->res_pool->dccg->funcs && dc->res_pool->dccg->funcs->allow_clock_gating)
+			dc->res_pool->dccg->funcs->allow_clock_gating(dc->res_pool->dccg, true);
 
 		REG_UPDATE(DCFCLK_CNTL, DCFCLK_GATE_DIS, 0);
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
index 1e6ffd86a4c0..d6f5e01a0b66 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
@@ -224,6 +224,10 @@ struct dccg_funcs {
 	void (*otg_drop_pixel)(struct dccg *dccg,
 			uint32_t otg_inst);
 	void (*dccg_init)(struct dccg *dccg);
+	void (*refclk_setup)(struct dccg *dccg); /* Deprecated - for backward compatibility only */
+	void (*allow_clock_gating)(struct dccg *dccg, bool allow);
+	void (*enable_memory_low_power)(struct dccg *dccg, bool enable);
+	bool (*is_s0i3_golden_init_wa_done)(struct dccg *dccg);
 	void (*set_dpstreamclk_root_clock_gating)(
 			struct dccg *dccg,
 			int dp_hpo_inst,
-- 
2.43.0

