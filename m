Return-Path: <SRS0=f4Zr=PM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B7DC4332F
	for <amd-gfx@archiver.kernel.org>; Sun, 24 Oct 2021 13:32:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7622B600D4
	for <amd-gfx@archiver.kernel.org>; Sun, 24 Oct 2021 13:32:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7622B600D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6748C6E11F;
	Sun, 24 Oct 2021 13:32:35 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9E0D6E114
 for <amd-gfx@lists.freedesktop.org>; Sun, 24 Oct 2021 13:32:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UTB5cu89b8KIoLiDz/AAtAhVa1VFdK7daRx7/x6CFIv894GIYEDFb1T8GLPAQQ37M8PFIQsbYhaLM5zoaHKmhl/mWT17LDssvDO5YvDKjMcjiuafTt3weu/8Ij6mDON5zymP0dnCWiP/Mco8fKjt+XaVhsxb3CmKQ3WCUP2kEMtNFj79xDhWSpKX6Zf4WJjmImkorkgvoSAKPtbU2RD1Q1wlpfZMItsRn+jq9oRAefIkFX28vmXwf6BLnpuTzaCpc2Ksiaokh0pYu+bDOwqBNY5PTeGIZ2bHZcZHgbnNUMkmRaGK3xJSqir39ewcLEOjXbZJODj/+3VLPI+p01AI4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NJu6pIJwvq66rXSpzo4DVmd0QscaFsUYRf78aSuVWh0=;
 b=L5vVEnFVEduEQNvBtTcoV7GxDMJaOOpUxL9UDYpBP1K5bLWoIkdOlSIeVr26eut920o+oAszNG4U2b8AFI7iti2R+jwA27PRJdNLrRQ6unqIJsgImUYSov0dYj0iT+9OGa0qUsund1QCYk0zFhUu2d//13rlyBkjFtxL6Eggrs+eDGLWqub1RPd6JLDyjgKcVtQGNVE0a6z3c4VIns4jbUsUydxLSz5rvNrmSZKtoSM5Sx2722I5nTdI59jCaQIkblwCNDlBJHa/cLmlA1+jeA6S/oMym7YYmOUQ8iR3EVl9abq5Tu9saXN31IO+lIGxDTiBislIF+WP+Oz/kBxA4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJu6pIJwvq66rXSpzo4DVmd0QscaFsUYRf78aSuVWh0=;
 b=iynX9Bq0n1ANETBfmW3EwyVQUar7HhNnG4hGTaAI+bPd8memq0XuaitwKIKuQ4cmDHH0HhgTBVWKCy3ecJKUzZETAALJTB6W+eIRt3xktYSjjuAnbHWmSVIHgdpEZb6Lbx5f9OxlZoSC+OoT1t0dydk1sp1OF7MYoIcvaPbujVs=
Received: from MWHPR1401CA0015.namprd14.prod.outlook.com
 (2603:10b6:301:4b::25) by BL0PR12MB4994.namprd12.prod.outlook.com
 (2603:10b6:208:1ca::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15; Sun, 24 Oct
 2021 13:32:31 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4b:cafe::38) by MWHPR1401CA0015.outlook.office365.com
 (2603:10b6:301:4b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
 Transport; Sun, 24 Oct 2021 13:32:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Sun, 24 Oct 2021 13:32:30 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Sun, 24 Oct
 2021 08:32:24 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
 <agustin.gutierrez@amd.com>, Anthony Koo <Anthony.Koo@amd.com>
Subject: [PATCH 15/33] drm/amd/display: [FW Promotion] Release 0.0.89
Date: Sun, 24 Oct 2021 09:31:23 -0400
Message-ID: <20211024133141.239861-16-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211024133141.239861-1-Rodrigo.Siqueira@amd.com>
References: <20211024133141.239861-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1a882b7-728d-4bfc-0260-08d996f2ba92
X-MS-TrafficTypeDiagnostic: BL0PR12MB4994:
X-Microsoft-Antispam-PRVS: <BL0PR12MB499497ABD5F2142B6CC8ADE798829@BL0PR12MB4994.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t3zpvGGroauvOZymZhpB1TMOltz8PQUUGk0SSfYm18oqT4Rv9QU6uFihei7uIJ78MnmgqgBBIj97foRDeeHhBu+7h/Yif0ni926fKOMCwdJH2dAmpd4CZqlRpVCkAdFbA9OTFxlUjmpXgK9NfvTKNI9SO30XiGGdduIcwD7Txiny3nzcgSq1PK0Y4a2cW8U7aNG+I0k4NlHgEXDLNtSMLA4tYeBpdYollvmEbkpbFTyTi00wX5pAWYwChvmOxskrS+cHTpgpa6iKQWrHguf+MU8kWWygYbli3/LvnkUTBFqppUfxSW6Fr9EVkP02HGzyxBfK/mbjVit1hFMz7gRWeD2XIrPPh/JbHitzXYCTW/7J7IC19BWoW2SiOMDGyQ33fqrQKgGiNswMGqhfGm0c+RepeyhEYCiaB5cS5w9S3X9MmR9qYDKFp5u89gP7lc+ASIpO6Lupa9WfapCY0bd2Mnpv6YNdJ9mscv6gGs9bwnnWUczct+WJ4Ms+KjzBbstuP8W6NsMZV5kXO4UbKfPOCe7oGhvLeHVdh3UJtJxX6H/22Jw2SLj4rWDphHb5d1v5q81BI8/XrFTLWwPcHTZvKncGgPz0/smz5VFcdG2LnS7LI55hNX2c5fBq4ec7btYHEf88GNncMnf0S1IC9jqVLoRLm7e1dA31dUdAEWlgbAUnxDCdSnFIm+QI51m/lHwZ5Vj8ddIaPryB16RaujwnuLmbEVNZa2Lh/iK5z6sTx/Y=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(6916009)(47076005)(86362001)(316002)(81166007)(82310400003)(356005)(36860700001)(26005)(36756003)(508600001)(5660300002)(186003)(83380400001)(8936002)(54906003)(70206006)(4326008)(70586007)(8676002)(1076003)(426003)(336012)(2906002)(2616005)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2021 13:32:30.4469 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1a882b7-728d-4bfc-0260-08d996f2ba92
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4994
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

From: Anthony Koo <Anthony.Koo@amd.com>

- Add flag to control root clock gating in init_hw
- Add flag to indicate a diags environment is being used

Acked-by: Agustin Gutierrez <agustin.gutierrez@amd.com>
Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index f4bd9ece2af2..9e8ffbf47e63 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -47,10 +47,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0xd146258f
+#define DMUB_FW_VERSION_GIT_HASH 0xdd808d7b
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 88
+#define DMUB_FW_VERSION_REVISION 89
 #define DMUB_FW_VERSION_TEST 0
 #define DMUB_FW_VERSION_VBIOS 0
 #define DMUB_FW_VERSION_HOTFIX 0
@@ -372,7 +372,10 @@ union dmub_fw_boot_options {
 		uint32_t enable_dpia: 1; /**< 1 if DPIA should be enabled */
 		uint32_t invalid_vbios_data: 1; /**< 1 if VBIOS data table is invalid */
 		uint32_t reserved_unreleased2: 1; /**< reserved for an unreleased feature */
-		uint32_t reserved : 22; /**< reserved */
+		uint32_t root_clock_gating: 1; /**< 1 if all root clock gating is enabled */
+		uint32_t diag_env: 1; /* 1 if diagnostic environment */
+
+		uint32_t reserved : 19; /**< reserved */
 	} bits; /**< boot bits */
 	uint32_t all; /**< 32-bit access to bits */
 };
-- 
2.25.1

