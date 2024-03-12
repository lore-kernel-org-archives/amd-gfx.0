Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69A97C54E66
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Mar 2024 09:24:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB45B112CA4;
	Tue, 12 Mar 2024 09:23:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YPt4tHBT";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A469112CA4
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Mar 2024 09:23:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m8ZJhSvTZJASWwgoXeqTIq4pk5EOwxC57WgsWy4UdcwcxonWj32IZYdKHe20QkkbpErj0ih6GCSOSvc76h7S9Dwoj697j8rwVe/ACw/F8lDHPAAsFC1GhMiURQHJHKi9KC8MeTOSYYXycS0/Y6O/mO3Ps+maqphzc4FT6ruiNzmrmvPHZbf1/uUSKdMgVqnKXC95luSr1apE7T1j2Y7WEzEypeIfOkPNew27OBv/xJ5zgfCR2g9Wd3FeJFntHYEQLjxQcPEbNu2IDqLvu3R7bJogWuAJJUm4u/mV1JKFJKFcSeXirSYI2nuhePD++qUQAR9aGpSZwuID8rba7Rq7zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o8MeKR71TEbXbAx1O8UZ4zuNsimmoGLGtoiBAGGA1qY=;
 b=Co7+TkXWsYzsga4SYr48LPZytH4ukPsCFvkErhw3j+hbOq280QVHwjW5putE/2rlXIBSW9ltGZiecCEAfnYVz66wvBbZaZujSss5puZJ/zqbeDWRmS1KD3cKITn3X0yWduNFCL2PXibwr7HpppcNJOVZbCmvqVbsLS+Pv41hsNl1/BM8mR2s3WV50jliFT4GKuW40q5FPY2eySiHJ5j7+lZ0G7O3ChwJP24F8gCoka4D6+Y3R/KvL7q8MaPGhtqd47MzRtnmKmjX15uaf6orGeRQHU7uMx1wzb9MRuxfpEJeyfbb2XfbNiCKkEJJ5BSgs1TO4R67m0fgXuMmwkGcOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8MeKR71TEbXbAx1O8UZ4zuNsimmoGLGtoiBAGGA1qY=;
 b=YPt4tHBTljNsoDLzv2I/iwl6PfMvnkTFwmQVuvDnah/jiE6cPBwabePFAEilhqVG6kQ3sJRhps86j4A5azCmQwRIpzblXM3CBe7PsxtRPk/7FcXANnV7lODT9VeMYt+NrWNBLHQSGnlGIvFr29BptMie0ahHQBl73R4nmunPz3k=
Received: from CY5PR04CA0016.namprd04.prod.outlook.com (2603:10b6:930:1e::13)
 by DM6PR12MB4266.namprd12.prod.outlook.com (2603:10b6:5:21a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 09:23:55 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:930:1e:cafe::9c) by CY5PR04CA0016.outlook.office365.com
 (2603:10b6:930:1e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36 via Frontend
 Transport; Tue, 12 Mar 2024 09:23:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.81) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Tue, 12 Mar 2024 09:23:55 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 04:23:54 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 12 Mar 2024 04:23:49 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, Chris Park <chris.park@amd.com>
Subject: [PATCH 29/43] drm/amd/display: Power on VPG memory unconditionally if
 off
Date: Tue, 12 Mar 2024 17:20:22 +0800
Message-ID: <20240312092036.3283319-30-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240312092036.3283319-1-Wayne.Lin@amd.com>
References: <20240312092036.3283319-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|DM6PR12MB4266:EE_
X-MS-Office365-Filtering-Correlation-Id: 66f9e0c9-080e-41e0-b84a-08dc427623a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t/xtwbsbkYuh/TrrxJzbCg4fiXVJCTxgGAU6dIoTVA4Nor2rO5bsPCGlL3Jd2FjpomymqS0lZbKE/JkjkfNUxIU7GTnVcgDBK9V0yYvf7L+QkFR4PDDqIq2t+MX8/gNfvoIfo6F3vQklcB7ovuuNidk0SngdO6JzVEMkkcJNDfCLMbppa/yU6jFKf4Fp8xbi7NFbiLutg32Ncuj7ypNj8VcN764iMQB0kuqHd40M0vHgP5ZjA0TRRCH+JT27yOJ8uqNwaktfFnl+bMehYRzHs8pxVs8AC2P4d5SZcXHQU4tjaNImwZwCy9bq4Wg0qRCHorTyeqhO6ITVxOJSco8DcIKwE1MfNs1hmL4bp65g0sRxgVKhO5TyBjy4wam9Vm/HBK9Q+01hu7P62NUBI+BHytWiTzuaB9U0jK8Nazb/BfG2gdWAnU4f/UjOOtKY3zFGuQCdhuqt7LvrCri07W5Z1JeXiScQleSrLemHLIC7MVWd+baUNv4rxmdBXZNSVDa22Wbbx15YSpt9y0l0pWg3kcCsRSFKKUKoQW8AfXLY+PNBEJsHdzm64UbVR7Vo4iqQ71+cCtT4BRe+5O6MJ21sIDfjQgn/SBrNqylskdPMdTGLp+yjuUrRVXb+jU6TjxKLyllQHwX1ClSLbvB1SVBgImfyW40i16MRYjIjBl6JdbqryDrwkITCyTn0vW/zotvE0QdRh4CJ2Bl0kxRFA6sB6/BF+S4WIdUsAjMlCnfKlLwTnVNi0S9Qt+w0dCH7SgSB
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 09:23:55.0049 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66f9e0c9-080e-41e0-b84a-08dc427623a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4266
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

From: Dillon Varone <dillon.varone@amd.com>

[WHY&HOW]
Even if memory lower power feature policy states that it is disabled,
VPG memory should still be poweerd on if it is currently disabled when
requested.

Reviewed-by: Chris Park <chris.park@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_vpg.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_vpg.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_vpg.c
index f1deb1c3c363..cfb923d85630 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_vpg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_vpg.c
@@ -63,7 +63,12 @@ void vpg31_poweron(struct vpg *vpg)
 {
 	struct dcn31_vpg *vpg31 = DCN31_VPG_FROM_VPG(vpg);
 
-	if (vpg->ctx->dc->debug.enable_mem_low_power.bits.vpg == false)
+	uint32_t vpg_gsp_mem_pwr_state;
+
+	REG_GET(VPG_MEM_PWR, VPG_GSP_MEM_PWR_STATE, &vpg_gsp_mem_pwr_state);
+
+	if (vpg->ctx->dc->debug.enable_mem_low_power.bits.vpg == false &&
+			vpg_gsp_mem_pwr_state == 0)
 		return;
 
 	REG_UPDATE_2(VPG_MEM_PWR, VPG_GSP_MEM_LIGHT_SLEEP_DIS, 1, VPG_GSP_LIGHT_SLEEP_FORCE, 0);
-- 
2.37.3

