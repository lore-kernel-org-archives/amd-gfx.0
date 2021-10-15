Return-Path: <SRS0=EPaF=PD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9DADC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 18:44:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B493361041
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 18:44:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B493361041
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CC426EDCA;
	Fri, 15 Oct 2021 18:44:08 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0776C6EDCA
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Oct 2021 18:44:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eYo1o5ectjj9F2mpp4Q5sK6ecFeZv+D39TBkq5gtLehFlIGfokAjDGcJ5Yav4e9OwARFr0IyqSZIx7ial1akoMc99PQdjOeQu7XvuqT5ZYUFKYxPaH9ay4nB7rQbUgjRHanxAUJ9upzebhwoWFSge5wIzOQ1EnriZN6phZ4trjHt7aCCO7pYhFZPnuf4LROgrDUqlWcj4ILRwby+cq+RY+Uth8tns7j1lHd7T5AebZ0zw215cfkiGor75T6fNf6v7HwTDpNugzFSkOtxSxHcMJWNZA0N5tTHfsID5dPZkrh+Y0Hul2biK7RcgtgK4QtxTeif8HvLVWNwqYwO/Zi2tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uLoDTvwLupO7zeLf1TWSRwiSrRDdj/ffa/PakcLCd9c=;
 b=WNwoOFuEu/7YWHJ6KYc/a9EqcXn7W9/5tah6HKDZgl8OESjkJdI/3krHBrzJYhBoNnujezQrdkPYC4Lx/r258qHAeQMhCEsfvP97cfmaA4lzmTN7PpHElDG+6ShuQHNL7XQUORz/7gmwOC4LVtKy4Ww53UagZA9ctlk31MLZmB+mpAXvrdAvQd85XQUByC70pMtYexMAL2gpiqH+pMDcR6wq713VMWUrHoiToaHu5nQYuvgs75VevYh/ql58qVqnsCVfCaAhjnkrschf4uhL39eZQFkvVLr2CC6ME5GcgRF4mZU4LgTifMyQZiWGw4qCP8Yvkb+MA8SSstpUwI2qSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uLoDTvwLupO7zeLf1TWSRwiSrRDdj/ffa/PakcLCd9c=;
 b=2t0nD1Rs2AxMUa9bCxHM1uoQEAb032FpxY9gmJ91vB3w0XJIzJanuF0gCo84fiam/3BcMsBdudx3RMsnhsFK22Tp1iYTN+YFfwN+Iy7sLQwoscmkE7gYfPwC02Rcjor8dU7ER1Xr0dkjvUKOe7ixh2EZ2TbRoH+9M3BlugqJWqw=
Received: from DM6PR08CA0001.namprd08.prod.outlook.com (2603:10b6:5:80::14) by
 CH2PR12MB3717.namprd12.prod.outlook.com (2603:10b6:610:24::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.16; Fri, 15 Oct 2021 18:44:00 +0000
Received: from DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::c8) by DM6PR08CA0001.outlook.office365.com
 (2603:10b6:5:80::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend
 Transport; Fri, 15 Oct 2021 18:44:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT063.mail.protection.outlook.com (10.13.172.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Fri, 15 Oct 2021 18:43:59 +0000
Received: from ubuntu.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 15 Oct
 2021 13:43:57 -0500
From: Agustin Gutierrez <agustin.gutierrez@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
 <agustin.gutierrez@amd.com>, Hansen <Hansen.Dsouza@amd.com>, "Nicholas
 Kazlauskas" <Nicholas.Kazlauskas@amd.com>
Subject: [PATCH 11/27] drm/amd/display: Fix DP2 SE and LE SYMCLK selection for
 B0 PHY
Date: Fri, 15 Oct 2021 14:43:16 -0400
Message-ID: <20211015184332.221091-12-agustin.gutierrez@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211015184332.221091-1-agustin.gutierrez@amd.com>
References: <20211015184332.221091-1-agustin.gutierrez@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3bdeac3a-9f86-4c16-7def-08d9900bc076
X-MS-TrafficTypeDiagnostic: CH2PR12MB3717:
X-Microsoft-Antispam-PRVS: <CH2PR12MB37173F87990FD46D7B47BAE3F5B99@CH2PR12MB3717.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v+DjhcPxspZOmRf8vVbOsq6jqY4cRcWzCVKnK0eMfTGCbLIMG6EznjxxO9sruLXA56Llab98SEMSgrCwGr92n/kUNzMqjCZSPnl4Ngl+1WmuYomPwNuVYIfpkQqJeJimobgYjPAvMF7ljMl8drUwhtDDosYZ8buqih1XC8O4p/MS4TyIpkgbx1NTzOCs1TC5yahQCQ8f0SgTYij2UtN4UTKxLNf9JaGf92p1ChjpxBQ0ZGW7wlbuIscYJgAXSJduFQIs8FKLQN+aTKJopF2sGBXfUlwaTrIYP5+/AVwsEa7QlreizV3mVT8ScChxoq+Qh5Fa2IWRrefcaU/4nG/zTSu4Ae1hHVVC7t+a/pK19VJysj1zGXBvDjeRa80NP29cDW1TNPh6psCBtY4GQRpj3cDPMzm0LCJ0I5FivtFO1tFJvORgayxPlr5cCXLBjVYIyDoTBrFc7TeFEJhjZE0gW/DqX38qmLTJgMlHbKiWJU63ZfWVQU8I08HwbueL+azAxjROhOTbjvOvGlepMbNFHMNzseyfIOLFYXyxQNS84RUimRLBfacyIXXtWvMGMSYvgKATDFl1AWBajlWiuKjvA/EkSpOdnxXpQukfpgpWJPPRfB8bWv3+ElZpc8698M45t/1ldWSqeR39uQe4MP9YcLcjCQZONkX6HIlbHsN7q3CE1XJmbusfXvAAE8ESTsQuycNansPbQ7auiMnwkDIKtllELGj2ztI6blNJhiIuAwA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(5660300002)(186003)(6666004)(6916009)(8676002)(16526019)(316002)(356005)(86362001)(54906003)(82310400003)(47076005)(508600001)(26005)(81166007)(4326008)(2906002)(44832011)(8936002)(2616005)(70206006)(36860700001)(70586007)(336012)(426003)(83380400001)(36756003)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 18:43:59.6853 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bdeac3a-9f86-4c16-7def-08d9900bc076
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3717
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

From: Hansen <Hansen.Dsouza@amd.com>

Remap phyd32clk to PHYF and PHYG for B0, PHYC and PHYD are unused

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Agustin Gutierrez Sanchez <agustin.gutierrez@amd.com>
Signed-off-by: Hansen <Hansen.Dsouza@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c   | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
index 582c500ecb49..152adb597d48 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
@@ -26,6 +26,7 @@
 #include "reg_helper.h"
 #include "core_types.h"
 #include "dcn31_dccg.h"
+#include "dal_asic_id.h"
 
 #define TO_DCN_DCCG(dccg)\
 	container_of(dccg, struct dcn_dccg, base)
@@ -80,6 +81,18 @@ static void dccg31_update_dpp_dto(struct dccg *dccg, int dpp_inst, int req_dppcl
 	dccg->pipe_dppclk_khz[dpp_inst] = req_dppclk;
 }
 
+static enum phyd32clk_clock_source get_phy_mux_symclk(
+		struct dcn_dccg *dccg_dcn,
+		enum phyd32clk_clock_source src)
+{
+	if (dccg_dcn->base.ctx->asic_id.hw_internal_rev == YELLOW_CARP_B0) {
+		if (src == PHYD32CLKC)
+			src = PHYD32CLKF;
+		if (src == PHYD32CLKD)
+			src = PHYD32CLKG;
+	}
+	return src;
+}
 
 void dccg31_set_dpstreamclk(
 		struct dccg *dccg,
@@ -119,6 +132,8 @@ void dccg31_enable_symclk32_se(
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 
+	phyd32clk = get_phy_mux_symclk(dccg_dcn, phyd32clk);
+
 	/* select one of the PHYD32CLKs as the source for symclk32_se */
 	switch (hpo_se_inst) {
 	case 0:
@@ -188,6 +203,8 @@ void dccg31_enable_symclk32_le(
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 
+	phyd32clk = get_phy_mux_symclk(dccg_dcn, phyd32clk);
+
 	/* select one of the PHYD32CLKs as the source for symclk32_le */
 	switch (hpo_le_inst) {
 	case 0:
-- 
2.25.1

