Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9852C3DA62
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jul 2024 19:40:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B86289C46;
	Wed, 17 Jul 2024 19:40:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iosAoouS";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2060.outbound.protection.outlook.com [40.107.212.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D61110E3AC
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jul 2024 19:40:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gDTU3WL2RVE1DB4ph+yUx8riguC1Qgy5IGVHIFeHwEyxv5l0+aelRInHrs71oSb2KYL9VirjDmxfE4iM3AJwZWRbg5zzLoxg0JLSdgNt3ne1aHJayBQ47R/VqA6RrBeiHelYRflSlKFbP+XSK0BYJUIf91W1BjR4k53aEglZGbeXfulFICAMf/xkow21Lsglz5fh2lMhfC9HnekEwo8mBm/Mb9GzNNf1qATM765gBE09uADlEQDCshxIEAPyKcBsCEYnmcU8Bsg4OJal5a+KaJ84P4BwsUHd8qntEvhrz/jMPEdiEEAk3EcibQaE4SYp21251Q05JI87OnF8k3bCDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QY70L4eeVF4fTniba5hGkS2prf0TriGywqfSy3zfKDU=;
 b=gg8TqUcwuvcaQqkpwp+fVxT5Dz0mn4zXJT4kJGozRF8/EeuJuejRbM5Wo63/3lDJrsqY5+fi9rAtTOfK7VhIbLWdRn8Jv0fBusRbHz9EV7BdxgsYTaP+GotthfXtb5qoruxH17WCw7+TG0sTxu3IXZ2HfORdSfcYB+3vHee6/7cMkygg8MEMhG3qTnSkszN7ouUNtV8tXW3vWhqvxn+ab5TlT2fl8tkyHPI1/OSa+GrAapWpigC+Ls1zOJddDn3+Kl07ZZre5sK20VSOi39ayKjDhZwIX459OmMS3XMwSt45oizwt1zA/tBFXV2NFrqp/B0LGmd6wg3Eijw/t285Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QY70L4eeVF4fTniba5hGkS2prf0TriGywqfSy3zfKDU=;
 b=iosAoouSKVGW6btbuSLHvjbXH+OwC4dkIZ1LPGaFNerFahfT7pgbgu8i4PnzpjZTl69LQdhovJ4lW+F5eNug+h8enZXDf3a+aqDU5khkW7S77GkaqD90b1+dc/uWVgUziMTwEdCSCGfU00c/QGoyl4Frj4Kg81eQkkpJvihJ9a8=
Received: from DM6PR07CA0119.namprd07.prod.outlook.com (2603:10b6:5:330::11)
 by SA1PR12MB7245.namprd12.prod.outlook.com (2603:10b6:806:2bf::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.15; Wed, 17 Jul
 2024 19:40:12 +0000
Received: from DS3PEPF0000C37B.namprd04.prod.outlook.com
 (2603:10b6:5:330:cafe::7a) by DM6PR07CA0119.outlook.office365.com
 (2603:10b6:5:330::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16 via Frontend
 Transport; Wed, 17 Jul 2024 19:40:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF0000C37B.mail.protection.outlook.com (10.167.23.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Wed, 17 Jul 2024 19:40:11 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Jul
 2024 14:40:11 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Jul
 2024 14:40:10 -0500
Received: from debian.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 17 Jul 2024 14:40:05 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Hansen Dsouza
 <hansen.dsouza@amd.com>, Daniel Miess <daniel.miess@amd.com>, "Aurabindo
 Pillai" <aurabindo.pillai@amd.com>
Subject: [PATCH 10/22] drm/amd/display: Add source select helper functions
Date: Wed, 17 Jul 2024 19:38:49 +0000
Message-ID: <20240717193901.8821-11-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240717193901.8821-1-aurabindo.pillai@amd.com>
References: <20240717193901.8821-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37B:EE_|SA1PR12MB7245:EE_
X-MS-Office365-Filtering-Correlation-Id: 7582ba53-f155-4630-33da-08dca6984604
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?E1iIdJNghaSV5m9vo3ON3YXzP+Ikk5+6hKN4i/naqEWejhK9Rtil7TNOTp8G?=
 =?us-ascii?Q?uqY/U/nPTZPsgynsg4i1DPe7PIYoxc11VOUhqgiQtHVSUEzAJnM8+WkQi+fT?=
 =?us-ascii?Q?3c5IyQPRrjzFWoB6NyYf+SCdClgD3TH7O4U+dSIFzOn1g8BE9GJLK6G68gWO?=
 =?us-ascii?Q?suqeyacrGoz3/BU9JnPrHGFs2/Xhbm0pqrXsUi+X6QoqS38ZLfRP3gbMNHdI?=
 =?us-ascii?Q?qIksp23djqItrz/cIoyr9SN5WEPkZf4WrSj3Ljfa+1Qy64uJKt0SWixDLq2u?=
 =?us-ascii?Q?AzjZ7QjmrYvGJw6il8bVgmu6k8R/8lSuUHSUGaFaJExEVXxFGKfP462+iYu2?=
 =?us-ascii?Q?QRoR9s9TZ+2cUXw3oOnpfsZ+dRgNxdBqL13e1yV8bfbf4CnALzSN/GBwbHGi?=
 =?us-ascii?Q?sS6ByMX8qTzm5O7Y+zBgTN9I7GGNUGlnVe4GXV3fTBuGTRjb5yFN1324CL36?=
 =?us-ascii?Q?HbOV9vBrX1pi/pH8iy21ziz9o7ibLg6DoGc0S3lrEB2aHnPTeaTXUIioNIzb?=
 =?us-ascii?Q?s+C3N6nEGpA7U5budsKFCZ0egHoQHcVlE1OWV4ey33FAn7lAgDZIk7bybHMo?=
 =?us-ascii?Q?sUEWNrnnVUcxhwas8gUqXx3QLNUnwDYJs14ZBBuZ2j2ClI5pLD/CGB+7SpmF?=
 =?us-ascii?Q?CSdr9RIEkNWdmggySHP2s9EQst8bP0VS8rx2vXB0lwqeqURnODZqZrBc9DAP?=
 =?us-ascii?Q?03NAf+flzQbfXWa5vZ42v10c+pKCVbhVxK3fB91a5TH1b94P6CafpY6PmChy?=
 =?us-ascii?Q?+RhD43n53NTEvsUIanOJ8dQ/CZ4Znj0U45SpHxPJrpxX9LHJP59Us3ZkPa4d?=
 =?us-ascii?Q?HrYOqm6KKGixdLAErSWPB5F6GyQMicgIMuHnFSRTxqrqP+/iHACKmTVr53oa?=
 =?us-ascii?Q?b0+7wYJZI4ujlKhSRT0/VH5jS6M4pXDMTbiHsfT0/cF/GQM6grPNVCXKFbew?=
 =?us-ascii?Q?mohFi2fgxKqYk6Y9zvi04shbQHf8UWZ4BIdV1rSRHsv3lzNMuwizFxnKYq3S?=
 =?us-ascii?Q?eaXWRh13n4ZdLdMPx/+wPkS3SO4tsfsIqtwzZ9oQRUHgT1aYRiNuqCXXo1BY?=
 =?us-ascii?Q?pYS/emsneEFPgT5XQ4+RhCD9MiLRMeZwnRkHeI112ENzJQT46LxXAQPzvRfh?=
 =?us-ascii?Q?a/hAsfWYhAVKIC+DtZS1edUTjL+mDFgzL89BTJN8NCBNclV5M9gA8B/2Aa7E?=
 =?us-ascii?Q?RpazqVWPNn+7qO5aMMDfvxzcwpEvyeaYhZTyUJsOp3yXLYwq7bM+XWRuNuHJ?=
 =?us-ascii?Q?P4MDJdscXQha4l6pJGGd17hiDqLUDU7agicsA3UKwRveckfVVydB+YxVr5Q9?=
 =?us-ascii?Q?XgR4atE2S5/mM2I8f8H1bFz6Trn6PgHR81zauQ0uD9YJSyO6pFj+6H+52cMN?=
 =?us-ascii?Q?HCJr3Phf7O5dMBafaGkMQmZIDcevvZSIYulWt4ek6bi2LmuRKUfv3U74k7ZV?=
 =?us-ascii?Q?LnhKVoW22KVVwjvz5/n+3xYS71OuOSt9?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 19:40:11.8750 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7582ba53-f155-4630-33da-08dca6984604
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7245
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

From: Hansen Dsouza <hansen.dsouza@amd.com>

[why & how]
Add source select helpers based on DCCG spec

Reviewed-by: Daniel Miess <daniel.miess@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Hansen Dsouza <hansen.dsouza@amd.com>
---
 .../amd/display/dc/dccg/dcn35/dcn35_dccg.c    | 324 ++++++++++++++++++
 1 file changed, 324 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
index 76f069f703ef..b698b773338a 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
@@ -418,6 +418,320 @@ static void dccg35_set_smclk32_se_rcg(
 	}
 }
 
+static void dccg35_set_dsc_clk_src_new(struct dccg *dccg, int inst, enum dsc_clk_source src)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	/* DSCCLK#_EN=0 switches to refclock from functional clock */
+
+	switch (inst) {
+	case 0:
+		REG_UPDATE(DSCCLK_DTO_CTRL, DSCCLK0_EN, src);
+		break;
+	case 1:
+		REG_UPDATE(DSCCLK_DTO_CTRL, DSCCLK1_EN, src);
+		break;
+	case 2:
+		REG_UPDATE(DSCCLK_DTO_CTRL, DSCCLK2_EN, src);
+		break;
+	case 3:
+		REG_UPDATE(DSCCLK_DTO_CTRL, DSCCLK3_EN, src);
+		break;
+	default:
+		BREAK_TO_DEBUGGER();
+		return;
+	}
+}
+
+static void dccg35_set_symclk32_se_src_new(
+	struct dccg *dccg,
+	int inst,
+	enum symclk32_se_clk_source src
+	)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	switch (inst) {
+	case 0:
+		REG_UPDATE_2(SYMCLK32_SE_CNTL,
+					 SYMCLK32_SE0_SRC_SEL, (src == SYMCLK32_SE_REFCLK) ? 0 : src,
+					 SYMCLK32_SE0_EN,  (src == SYMCLK32_SE_REFCLK) ? 0 : 1);
+		break;
+	case 1:
+		REG_UPDATE_2(SYMCLK32_SE_CNTL,
+					 SYMCLK32_SE1_SRC_SEL, (src == SYMCLK32_SE_REFCLK) ? 0 : src,
+					 SYMCLK32_SE1_EN, (src == SYMCLK32_SE_REFCLK) ? 0 : 1);
+		break;
+	case 2:
+		REG_UPDATE_2(SYMCLK32_SE_CNTL,
+					 SYMCLK32_SE2_SRC_SEL, (src == SYMCLK32_SE_REFCLK) ? 0 : src,
+					 SYMCLK32_SE2_EN, (src == SYMCLK32_SE_REFCLK) ? 0 : 1);
+		break;
+	case 3:
+		REG_UPDATE_2(SYMCLK32_SE_CNTL,
+					 SYMCLK32_SE3_SRC_SEL, (src == SYMCLK32_SE_REFCLK) ? 0 : src,
+					 SYMCLK32_SE3_EN, (src == SYMCLK32_SE_REFCLK) ? 0 : 1);
+		break;
+	default:
+		BREAK_TO_DEBUGGER();
+		return;
+	}
+}
+
+static int
+dccg35_is_symclk32_se_src_functional_le_new(struct dccg *dccg, int symclk_32_se_inst, int symclk_32_le_inst)
+{
+	uint32_t en;
+	uint32_t src_sel;
+
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	REG_GET_2(SYMCLK32_SE_CNTL, SYMCLK32_SE3_SRC_SEL, &src_sel, SYMCLK32_SE3_EN, &en);
+
+	if (en == 1 && src_sel == symclk_32_le_inst)
+		return 1;
+
+	return 0;
+}
+
+
+static void dccg35_set_symclk32_le_src_new(
+	struct dccg *dccg,
+	int inst,
+	enum symclk32_le_clk_source src)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	switch (inst) {
+	case 0:
+		REG_UPDATE_2(SYMCLK32_LE_CNTL,
+					 SYMCLK32_LE0_SRC_SEL, (src == SYMCLK32_LE_REFCLK) ? 0 : src,
+					 SYMCLK32_LE0_EN, (src == SYMCLK32_LE_REFCLK) ? 0 : 1);
+		break;
+	case 1:
+		REG_UPDATE_2(SYMCLK32_LE_CNTL,
+					 SYMCLK32_LE1_SRC_SEL, (src == SYMCLK32_LE_REFCLK) ? 0 : src,
+					 SYMCLK32_LE1_EN, (src == SYMCLK32_LE_REFCLK) ? 0 : 1);
+		break;
+	default:
+		BREAK_TO_DEBUGGER();
+		return;
+	}
+}
+
+static void dcn35_set_dppclk_src_new(struct dccg *dccg,
+				 int inst, enum dppclk_clock_source src)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	switch (inst) {
+	case 0:
+		REG_UPDATE(DPPCLK_CTRL, DPPCLK0_EN, src);
+		break;
+	case 1:
+		REG_UPDATE(DPPCLK_CTRL, DPPCLK1_EN, src);
+		break;
+	case 2:
+		REG_UPDATE(DPPCLK_CTRL, DPPCLK2_EN, src);
+		break;
+	case 3:
+		REG_UPDATE(DPPCLK_CTRL, DPPCLK3_EN, src);
+		break;
+	default:
+	BREAK_TO_DEBUGGER();
+		break;
+	}
+}
+
+static void dccg35_set_dtbclk_p_src_new(
+	struct dccg *dccg,
+	enum dtbclk_source src,
+	int inst)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	/* If DTBCLK_P#_EN is 0 refclock is selected as functional clock
+	 * If DTBCLK_P#_EN is 1 functional clock is selected as DTBCLK_P#_SRC_SEL
+	 */
+
+	switch (inst) {
+	case 0:
+		REG_UPDATE_2(DTBCLK_P_CNTL,
+					 DTBCLK_P0_SRC_SEL, (src == DTBCLK_REFCLK) ? 0 : src,
+					 DTBCLK_P0_EN, (src == DTBCLK_REFCLK) ? 0 : 1);
+		break;
+	case 1:
+		REG_UPDATE_2(DTBCLK_P_CNTL,
+					 DTBCLK_P1_SRC_SEL, (src == DTBCLK_REFCLK) ? 0 : src,
+					 DTBCLK_P1_EN, (src == DTBCLK_REFCLK) ? 0 : 1);
+		break;
+	case 2:
+		REG_UPDATE_2(DTBCLK_P_CNTL,
+					 DTBCLK_P2_SRC_SEL, (src == DTBCLK_REFCLK) ? 0 : src,
+					 DTBCLK_P2_EN, (src == DTBCLK_REFCLK) ? 0 : 1);
+		break;
+	case 3:
+		REG_UPDATE_2(DTBCLK_P_CNTL,
+					 DTBCLK_P3_SRC_SEL, (src == DTBCLK_REFCLK) ? 0 : src,
+					 DTBCLK_P3_EN, (src == DTBCLK_REFCLK) ? 0 : 1);
+		break;
+	default:
+		BREAK_TO_DEBUGGER();
+		return;
+	}
+}
+
+static void dccg35_set_dpstreamclk_src_new(
+	struct dccg *dccg,
+	enum dp_stream_clk_source src,
+	int inst)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	switch (inst) {
+	case 0:
+		REG_UPDATE_2(DPSTREAMCLK_CNTL, DPSTREAMCLK0_EN,
+					 (src == DP_STREAM_REFCLK) ? 0 : 1,
+					 DPSTREAMCLK0_SRC_SEL,
+					 (src == DP_STREAM_REFCLK) ? 0 : src);
+		break;
+	case 1:
+		REG_UPDATE_2(DPSTREAMCLK_CNTL, DPSTREAMCLK1_EN,
+					 (src == DP_STREAM_REFCLK) ? 0 : 1,
+					 DPSTREAMCLK1_SRC_SEL,
+					 (src == DP_STREAM_REFCLK) ? 0 : src);
+
+		break;
+	case 2:
+		REG_UPDATE_2(DPSTREAMCLK_CNTL, DPSTREAMCLK2_EN,
+					 (src == DP_STREAM_REFCLK) ? 0 : 1,
+					 DPSTREAMCLK2_SRC_SEL,
+					 (src == DP_STREAM_REFCLK) ? 0 : src);
+
+		break;
+	case 3:
+		REG_UPDATE_2(DPSTREAMCLK_CNTL, DPSTREAMCLK3_EN,
+					 (src == DP_STREAM_REFCLK) ? 0 : 1,
+					 DPSTREAMCLK3_SRC_SEL,
+					 (src == DP_STREAM_REFCLK) ? 0 : src);
+		break;
+	default:
+		BREAK_TO_DEBUGGER();
+		return;
+	}
+}
+
+static void dccg35_set_physymclk_src_new(
+	struct dccg *dccg,
+	enum physymclk_source src,
+	int inst)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	switch (inst) {
+	case 0:
+		REG_UPDATE_2(PHYASYMCLK_CLOCK_CNTL, PHYASYMCLK_EN,
+					 (src == PHYSYMCLK_REFCLK) ? 0 : 1,
+					 PHYASYMCLK_SRC_SEL,
+					 (src == PHYSYMCLK_REFCLK) ? 0 : src);
+		break;
+	case 1:
+		REG_UPDATE_2(PHYBSYMCLK_CLOCK_CNTL, PHYBSYMCLK_EN,
+					 (src == PHYSYMCLK_REFCLK) ? 0 : 1,
+					 PHYBSYMCLK_SRC_SEL,
+					 (src == PHYSYMCLK_REFCLK) ? 0 : src);
+		break;
+	case 2:
+		REG_UPDATE_2(PHYCSYMCLK_CLOCK_CNTL, PHYCSYMCLK_EN,
+					 (src == PHYSYMCLK_REFCLK) ? 0 : 1,
+					 PHYCSYMCLK_SRC_SEL,
+					 (src == PHYSYMCLK_REFCLK) ? 0 : src);
+		break;
+	case 3:
+		REG_UPDATE_2(PHYDSYMCLK_CLOCK_CNTL, PHYDSYMCLK_EN,
+					 (src == PHYSYMCLK_REFCLK) ? 0 : 1,
+					 PHYDSYMCLK_SRC_SEL,
+					 (src == PHYSYMCLK_REFCLK) ? 0 : src);
+		break;
+	case 4:
+		REG_UPDATE_2(PHYESYMCLK_CLOCK_CNTL, PHYESYMCLK_EN,
+					 (src == PHYSYMCLK_REFCLK) ? 0 : 1,
+					 PHYESYMCLK_SRC_SEL,
+					 (src == PHYSYMCLK_REFCLK) ? 0 : src);
+		break;
+	default:
+		BREAK_TO_DEBUGGER();
+		return;
+	}
+}
+
+static int dccg35_is_symclk_fe_src_functional_be(struct dccg *dccg,
+												 int symclk_fe_inst,
+												 int symclk_be_inst)
+{
+
+	uint32_t en = 0;
+	uint32_t src_sel = 0;
+
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	switch (symclk_fe_inst) {
+	case 0:
+		REG_GET_2(SYMCLKA_CLOCK_ENABLE, SYMCLKA_FE_SRC_SEL, &src_sel, SYMCLKA_FE_EN, &en);
+		break;
+	case 1:
+		REG_GET_2(SYMCLKB_CLOCK_ENABLE, SYMCLKB_FE_SRC_SEL, &src_sel, SYMCLKB_FE_EN, &en);
+		break;
+	case 2:
+		REG_GET_2(SYMCLKC_CLOCK_ENABLE, SYMCLKC_FE_SRC_SEL, &src_sel, SYMCLKC_FE_EN, &en);
+		break;
+	case 3:
+		REG_GET_2(SYMCLKD_CLOCK_ENABLE, SYMCLKD_FE_SRC_SEL, &src_sel, SYMCLKD_FE_EN, &en);
+		break;
+	case 4:
+		REG_GET_2(SYMCLKE_CLOCK_ENABLE, SYMCLKE_FE_SRC_SEL, &src_sel, SYMCLKE_FE_EN, &en);
+		break;
+	}
+
+	if (en == 1 && src_sel == symclk_be_inst)
+		return 1;
+
+	return 0;
+}
+
+static void dccg35_set_symclk_fe_src_new(struct dccg *dccg, enum physymclk_fe_source src, int inst)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	switch (inst) {
+	case 0:
+		REG_UPDATE_2(SYMCLKA_CLOCK_ENABLE,
+					 SYMCLKA_FE_EN, (src == PHYSYMCLK_FE_REFCLK) ? 0 : 1,
+					 SYMCLKA_FE_SRC_SEL, (src == PHYSYMCLK_FE_REFCLK) ? 0 : src);
+		break;
+	case 1:
+		REG_UPDATE_2(SYMCLKB_CLOCK_ENABLE,
+					 SYMCLKB_FE_EN, (src == PHYSYMCLK_FE_REFCLK) ? 0 : 1,
+					 SYMCLKB_FE_SRC_SEL, (src == PHYSYMCLK_FE_REFCLK) ? 0 : src);
+		break;
+	case 2:
+		REG_UPDATE_2(SYMCLKC_CLOCK_ENABLE,
+					 SYMCLKC_FE_EN, (src == PHYSYMCLK_FE_REFCLK) ? 0 : 1,
+					 SYMCLKC_FE_SRC_SEL, (src == PHYSYMCLK_FE_REFCLK) ? 0 : src);
+		break;
+	case 3:
+		REG_UPDATE_2(SYMCLKD_CLOCK_ENABLE,
+					 SYMCLKD_FE_EN, (src == PHYSYMCLK_FE_REFCLK) ? 0 : 1,
+					 SYMCLKD_FE_SRC_SEL, (src == PHYSYMCLK_FE_REFCLK) ? 0 : src);
+		break;
+	case 4:
+		REG_UPDATE_2(SYMCLKE_CLOCK_ENABLE,
+					 SYMCLKE_FE_EN, (src == PHYSYMCLK_FE_REFCLK) ? 0 : 1,
+					 SYMCLKE_FE_SRC_SEL, (src == PHYSYMCLK_FE_REFCLK) ? 0 : src);
+		break;
+	}
+}
+
 static void dccg35_trigger_dio_fifo_resync(struct dccg *dccg)
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
@@ -1429,6 +1743,16 @@ struct dccg *dccg35_create(
 	(void)&dccg35_set_dppclk_rcg;
 	(void)&dccg35_set_dpstreamclk_rcg;
 	(void)&dccg35_set_smclk32_se_rcg;
+	(void)&dccg35_set_dsc_clk_src_new;
+	(void)&dccg35_set_symclk32_se_src_new;
+	(void)&dccg35_is_symclk32_se_src_functional_le_new;
+	(void)&dccg35_set_symclk32_le_src_new;
+	(void)&dcn35_set_dppclk_src_new;
+	(void)&dccg35_set_dtbclk_p_src_new;
+	(void)&dccg35_set_dpstreamclk_src_new;
+	(void)&dccg35_set_physymclk_src_new;
+	(void)&dccg35_is_symclk_fe_src_functional_be;
+	(void)&dccg35_set_symclk_fe_src_new;
 
 	base = &dccg_dcn->base;
 	base->ctx = ctx;
-- 
2.39.2

