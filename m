Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A061FC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Mar 2022 21:49:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CD9B10E209;
	Fri, 18 Mar 2022 21:49:28 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F08210E209
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Mar 2022 21:49:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hq97wvRUxC1Y9SCbaWYuqHxEYInMN19GxeKN8RyFAzQli2eGJQyLghoV7XPX8DMuGAsbjV59mNtm12gquyFdqZnPBwPmBvBFYIQuAtdpJKHjhkoXrtjOheVJe57Uu4yvlc/14Fh8Pk4DKhdR6OU0ADbUTHqFFjNuVa3kwxiJJfbkCIY7OVpde7MtgIEEpyQCrCAzVuQ+FGuPwSmzTJGqLbFLvJSEfyskD60uKjXLgdzYKC2UgWQNnHJdlAjnQ21vW0RhA8cUnuHgcW9GBgmd//oaGa20Yubj6+CCXBhcLIo+IySZ7cylrVCOKAVslUsFz8a+XptVnbdiDVUQMoZzaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q7BwEPvlAhq+YGk5oqDXVGXa9+KIe3WJqHYY4T3F6I0=;
 b=KBNmPata9H/OJhV5plps/aufwF+RdiBvc9bDqHeaFDG45b0t1F8qViyn93rQasMiKkSzaomJVCTEYcaLd3nkrkfYH6gNCN8LkJNwRwmnjXO0y3O2nQzr7aKYZZgG9n27KLIDAaNVvxLWQ8xn1wV0b7kIr7Pr/+6kx1w0T/Qi4e4EHzyWKHsyyQhq8CkO3MjSKQhACsdl+wd6ngD5VtyctiejLtUfscA1X6K3F7+vvRb8uIKrfeCB1+AJE422MPgQbfUvecIfIMBgu8owJWLAbcE4ryx76qKzeg/1eKMYloh/qTIF4b0ypSISXFDMPxHvTgFIuobM5AKQWOpZdxY5/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7BwEPvlAhq+YGk5oqDXVGXa9+KIe3WJqHYY4T3F6I0=;
 b=bczyukfSmfw00uZetqzwHqPyZeYB5gzpHcsa87/Tlz0NgscQAYRzAKxuDnPX1L0l60wIjch/KPmgTmXr+va2iqsWRAvVbXxKakTtbV/mKLxTQd3kfO0woEcCW7Cpm4a0kQyUu/K04XNavW4LxGyrtVt0LRooli3ZaBE6oqeVVjw=
Received: from BN9PR03CA0133.namprd03.prod.outlook.com (2603:10b6:408:fe::18)
 by DM6PR12MB4498.namprd12.prod.outlook.com (2603:10b6:5:2a2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Fri, 18 Mar
 2022 21:49:23 +0000
Received: from BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::61) by BN9PR03CA0133.outlook.office365.com
 (2603:10b6:408:fe::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17 via Frontend
 Transport; Fri, 18 Mar 2022 21:49:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT046.mail.protection.outlook.com (10.13.177.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5081.14 via Frontend Transport; Fri, 18 Mar 2022 21:49:23 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 18 Mar
 2022 16:49:19 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/13] drm/amd/display: Add fSMC_MSG_SetDtbClk support
Date: Fri, 18 Mar 2022 15:47:52 -0600
Message-ID: <20220318214800.3565679-6-alex.hung@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220318214800.3565679-1-alex.hung@amd.com>
References: <20220318214800.3565679-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07de4b34-63e7-4a4e-8463-08da09292a1e
X-MS-TrafficTypeDiagnostic: DM6PR12MB4498:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB449823B245299EF66AC63080F7139@DM6PR12MB4498.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hxlvqX/pzd2+WHIZM2nJoL3Zo4KIrNlRPS8FdZXSbNZpNDVTc54pgDDZqyLEOFMC8E4g0xRhE2EqWEwsHJuZCrZyZzvcsKxPeXIsvgFPWDXQGwbLLweEmaI9Su4p1EQUFkgcnW9v5FvKi2g0bLtCZxwZA0KpYVKkM5Zmypwf72xvoIF6e9ujWObbWEVE30UV1bD0bUuBV9GOe0bj1f7EOhU6KbEwIpFE4KiSkCcD/9eUEiMCLKyiDmDBya/HWEgLQVBLGLz9DmqAOK84nE0eTxneiA4z3vAqjhOfxt141/ynTeOhjhLBXYYTWwtcsf7mqPGomndfbvE5LdZSBcmwEQpEPav5WktDFYiNjlu3XiYRitd/qHT+0oJxYFeEfNAAOuAHz8zBPuQGZZoc087+BalGt+eBvCpmLU2LrSr6sfXoXMw+sPJBlpnbrjyRljXn8Y+uzOPh3QX+kIXwVfR8fMr+CCFjmi6kvKLhJPDJEksW0lAXslcmSUA5jngrbe6i6UGVoF71LJ1fDtct7dx/ofebgSEgUaZ2VjQo8kp6HSFHsg/N2bsdLDys+PBOa1VX7vmPmKNFvPaOmp7DAO6RHSIigQ5mjLxnwVGkYVXYrIFTKJ8BA2FRespmgUz1oSxU1ML671qDaSiywrJ2jfxdtvXnn76qCxWvyliANM7Ka6RZscwfQM4TNQydA1Ze3XJ8Mh93FvM+9BgXhO5n+kFgkg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(2906002)(36860700001)(81166007)(356005)(8676002)(36756003)(70586007)(70206006)(7696005)(508600001)(4326008)(2616005)(426003)(336012)(6666004)(40460700003)(86362001)(1076003)(16526019)(82310400004)(8936002)(47076005)(44832011)(6916009)(5660300002)(316002)(19627235002)(54906003)(26005)(186003)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 21:49:23.0673 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07de4b34-63e7-4a4e-8463-08da09292a1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4498
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Oliver Logush <oliver.logush@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Alex Hung <alex.hung@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Oliver Logush <oliver.logush@amd.com>

[why]
Needed to support dcn315

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Oliver Logush <oliver.logush@amd.com>
---
 .../display/dc/clk_mgr/dcn315/dcn315_smu.c    | 19 +++++++++++++++----
 .../display/dc/clk_mgr/dcn315/dcn315_smu.h    |  4 +++-
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_smu.c
index 880ffea2afc6..2600313fea57 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_smu.c
@@ -80,8 +80,8 @@ static const struct IP_BASE NBIO_BASE = { { { { 0x00000000, 0x00000014, 0x00000D
 #define VBIOSSMC_MSG_SetDppclkFreq                0x06 ///< Set DPP clock frequency in MHZ
 #define VBIOSSMC_MSG_SetHardMinDcfclkByFreq       0x07 ///< Set DCF clock frequency hard min in MHZ
 #define VBIOSSMC_MSG_SetMinDeepSleepDcfclk        0x08 ///< Set DCF clock minimum frequency in deep sleep in MHZ
-#define VBIOSSMC_MSG_SetPhyclkVoltageByFreq       0x09 ///< Set display phy clock frequency in MHZ in case VMIN does not support phy frequency
-#define VBIOSSMC_MSG_GetFclkFrequency             0x0A ///< Get FCLK frequency, return frequemcy in MHZ
+#define VBIOSSMC_MSG_GetDtbclkFreq                0x09 ///< Get display dtb clock frequency in MHZ in case VMIN does not support phy frequency
+#define VBIOSSMC_MSG_SetDtbClk                    0x0A ///< Set dtb clock frequency, return frequemcy in MHZ
 #define VBIOSSMC_MSG_SetDisplayCount              0x0B ///< Inform PMFW of number of display connected
 #define VBIOSSMC_MSG_EnableTmdp48MHzRefclkPwrDown 0x0C ///< To ask PMFW turn off TMDP 48MHz refclk during display off to save power
 #define VBIOSSMC_MSG_UpdatePmeRestore             0x0D ///< To ask PMFW to write into Azalia for PME wake up event
@@ -324,15 +324,26 @@ int dcn315_smu_get_dpref_clk(struct clk_mgr_internal *clk_mgr)
 	return (dprefclk_get_mhz * 1000);
 }
 
-int dcn315_smu_get_smu_fclk(struct clk_mgr_internal *clk_mgr)
+int dcn315_smu_get_dtbclk(struct clk_mgr_internal *clk_mgr)
 {
 	int fclk_get_mhz = -1;
 
 	if (clk_mgr->smu_present) {
 		fclk_get_mhz = dcn315_smu_send_msg_with_param(
 			clk_mgr,
-			VBIOSSMC_MSG_GetFclkFrequency,
+			VBIOSSMC_MSG_GetDtbclkFreq,
 			0);
 	}
 	return (fclk_get_mhz * 1000);
 }
+
+void dcn315_smu_set_dtbclk(struct clk_mgr_internal *clk_mgr, bool enable)
+{
+	if (!clk_mgr->smu_present)
+		return;
+
+	dcn315_smu_send_msg_with_param(
+			clk_mgr,
+			VBIOSSMC_MSG_SetDtbClk,
+			enable);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_smu.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_smu.h
index 66fa42f8dd18..5aa3275ac7d8 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_smu.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_smu.h
@@ -37,6 +37,7 @@
 #define NUM_SOC_VOLTAGE_LEVELS  4
 #define NUM_DF_PSTATE_LEVELS    4
 
+
 typedef struct {
   uint16_t MinClock; // This is either DCFCLK or SOCCLK (in MHz)
   uint16_t MaxClock; // This is either DCFCLK or SOCCLK (in MHz)
@@ -124,5 +125,6 @@ void dcn315_smu_transfer_wm_table_dram_2_smu(struct clk_mgr_internal *clk_mgr);
 void dcn315_smu_request_voltage_via_phyclk(struct clk_mgr_internal *clk_mgr, int requested_phyclk_khz);
 void dcn315_smu_enable_pme_wa(struct clk_mgr_internal *clk_mgr);
 int dcn315_smu_get_dpref_clk(struct clk_mgr_internal *clk_mgr);
-int dcn315_smu_get_smu_fclk(struct clk_mgr_internal *clk_mgr);
+int dcn315_smu_get_dtbclk(struct clk_mgr_internal *clk_mgr);
+void dcn315_smu_set_dtbclk(struct clk_mgr_internal *clk_mgr, bool enable);
 #endif /* DAL_DC_315_SMU_H_ */
-- 
2.35.1

