Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F0BC4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Nov 2023 19:02:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F71710E81E;
	Wed,  8 Nov 2023 19:02:12 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1070310E820
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Nov 2023 19:02:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EcGajyccjna8yI4xAwisbW+mGg81oZNZRGA2d6hvA8A7NM3sK1M4DGNYIaDcviuTLvUOiI+M0/o/eZWcUEUfHasnDt+1Z0l/oRejvdrFMaeBz0y/Nd043ecDFrSVUg82S90Mhf9ZUFfDAW86crqyOwGYLOdyn5yFd3puv3Vg0yVA4wae5g9yXSEMIBHskqTJXZcc18rtixLqvRERc1YCQv4rhPlDy1kXeXflvyGEYmT4WbS0DYgocko0C3VLAwTPmCAkmuwv84C0WDkOG5uLlv2lxdSBPJn4EXKD5epcS3SjUoWcWsjmtUtvphkPgzoX99N/Wh+B0ZMlsvrpCK96mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JgDSUJ20CUf7t9SZjwVeDvVVHPBm6YSvTPYKoCmPe+0=;
 b=jpHbEjcu57bdOMYK1x2ApoMU7c1Yw1wXgTlbC7BJRe/7Ck0GPKK8lhY3dxduUFENGDvCHeev5f3o7yWNSc/Ewuw6Clz/mwLYbir2h4sZzpDjaLD/E7x2jpZwuy7XcnGf3Cbqx3M8P67qFH1lPRjr9LqqaHNB5ukld3e6DuTH0rVrsdpNv4ewMZLjh1bDHMYwdMPgM+zU/pHZT/mSO511527othzInDLz9udbmcJyCxWtehKdjyDDBJOG3ZtShAXsqVflSl/mmTObC9YHlLh+bCGqkdVFHg5xMEqUQ0LkyBYEoQNm4dPqmgbaE27VAJxvBY5PeX1l3c0r7DHkP1bYJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JgDSUJ20CUf7t9SZjwVeDvVVHPBm6YSvTPYKoCmPe+0=;
 b=BdsAwgkzzD2B+hFoi/ueBAtAKOfS7mgrnISmX2ZMY42J96GUPv9ADASSIcdnk4dNZzR9AeHOMTxJWLTg3fzeJEfmJby2pRIFB8PSDql/XNxJGZlg/Y08671qhlyv7ZN0uyRoIpi7D01djCQf+IJbuGxfYnSrnTDBQINJh8Qd/9Y=
Received: from MN2PR01CA0051.prod.exchangelabs.com (2603:10b6:208:23f::20) by
 SN7PR12MB8170.namprd12.prod.outlook.com (2603:10b6:806:32c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Wed, 8 Nov
 2023 19:02:00 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:23f:cafe::1f) by MN2PR01CA0051.outlook.office365.com
 (2603:10b6:208:23f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19 via Frontend
 Transport; Wed, 8 Nov 2023 19:02:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Wed, 8 Nov 2023 19:02:00 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 8 Nov
 2023 13:01:57 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/20] drm/amd/display: Enable CM low mem power optimization
Date: Wed, 8 Nov 2023 11:44:17 -0700
Message-ID: <20231108185501.45359-3-alex.hung@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231108185501.45359-1-alex.hung@amd.com>
References: <20231108185501.45359-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|SN7PR12MB8170:EE_
X-MS-Office365-Filtering-Correlation-Id: 54064466-0d87-4144-d1a6-08dbe08d2fe8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5oHA47egd8Mdrn/qPF/SBFFPIsccm9nK1oxanFxfzlugEzkffbW/4i2dH8ADe3LJAtPVhLeGOKdzIiWXqw+OPUC9atn9+0+VlVV2DDHWGeKcK9HCES+Q1NnZzWFEU4rlbxRLHIBveqH9EsRlIXOErfnMzDOOB2+//flWb7WBVsrYHmAtqxJl4pZ71ynrFYiX8f9oXwi0TYenvuC4Lh+bjzyI0fJA4KtOf4Z1/sJJTjNpHjaGUx9Qzqx8cefdY/QYqV8MLg+npwjMlvPXtHOj7mfAs96rOnA+zdieJXt9lEPjhWlRz0MAmsk/8DQz8zfFcyVTiME+SuXwXly6S5TqAzegv1WE6u6v/PrTkldaiSt+5m00Wo3QSy6mCnXdv/774XnadlMC117quVEG9iEsvUzBPEmpCp9V1LxRPCd7x63b1Jxau57Ngl16+ziLPsRPxyr7AFcNK9yS2fc6oWbrFwaPFcQTegGBLMKxUzaZbpYC8H2YHsGnITSYzlNCHfEabSbRnJuve/7b1hdx6gI/EdHLfOkiwD+IEc7RDRpyJsAGPMoNw+l1wtludr0d0x0bpML98Q6jeIouUtdzhyh3+AdMAp2W+pfcyhJzdJ6wuLxVdhuY1Ku3m53lKfWIFGt2xNml04nWJy60LEzYoMyk3vYNBb8I9eoo4jZV+O+0hSCyMv6344XQn8qkl/MK4Nn7wmdYiXPDMNpvoRS7rwcUXtAb9X26tm57JGqeJmg1W2LD8cyAUfJibSNSW7tYquBJtktN53rS0vmcGXaswMtQ+w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(136003)(39860400002)(376002)(230922051799003)(82310400011)(186009)(1800799009)(64100799003)(451199024)(36840700001)(40470700004)(46966006)(1076003)(44832011)(426003)(336012)(2616005)(40460700003)(70586007)(70206006)(82740400003)(16526019)(26005)(36756003)(478600001)(6916009)(54906003)(316002)(6666004)(7696005)(4326008)(8936002)(5660300002)(40480700001)(2906002)(36860700001)(47076005)(8676002)(41300700001)(83380400001)(86362001)(81166007)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 19:02:00.1386 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54064466-0d87-4144-d1a6-08dbe08d2fe8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8170
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
Cc: stylon.wang@amd.com, Yihan
 Zhu <yihan.zhu@amd.com>, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Alex Hung <alex.hung@amd.com>,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 wayne.lin@amd.com, Harry.Wentland@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yihan Zhu <yihan.zhu@amd.com>

[WHY & HOW]
MPC MCM low mem power optimization still causes color distortion on
first SCE enablement, only forces light sleep for it.

DPP low memory power optimization still needs this bit to save power.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Yihan Zhu <yihan.zhu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c    | 13 ++++++++-----
 .../gpu/drm/amd/display/dc/dcn35/dcn35_resource.c   |  2 +-
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c
index 994b21ed272f..1a2adb354718 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c
@@ -71,21 +71,24 @@ void mpc32_power_on_blnd_lut(
 {
 	struct dcn30_mpc *mpc30 = TO_DCN30_MPC(mpc);
 
+/*
 	if (mpc->ctx->dc->debug.enable_mem_low_power.bits.cm) {
 		if (power_on) {
 			REG_UPDATE(MPCC_MCM_MEM_PWR_CTRL[mpcc_id], MPCC_MCM_1DLUT_MEM_PWR_FORCE, 0);
 			REG_WAIT(MPCC_MCM_MEM_PWR_CTRL[mpcc_id], MPCC_MCM_1DLUT_MEM_PWR_STATE, 0, 1, 5);
 		} else if (!mpc->ctx->dc->debug.disable_mem_low_power) {
-			ASSERT(false);
-			/* TODO: change to mpc
-			 *  dpp_base->ctx->dc->optimized_required = true;
-			 *  dpp_base->deferred_reg_writes.bits.disable_blnd_lut = true;
-			 */
+			//TODO: change to mpc
+			dpp_base->ctx->dc->optimized_required = true;
+			dpp_base->deferred_reg_writes.bits.disable_blnd_lut = true;
 		}
 	} else {
 		REG_SET(MPCC_MCM_MEM_PWR_CTRL[mpcc_id], 0,
 				MPCC_MCM_1DLUT_MEM_PWR_FORCE, power_on == true ? 0 : 1);
 	}
+*/
+
+	REG_SET(MPCC_MCM_MEM_PWR_CTRL[mpcc_id], 0,
+			MPCC_MCM_1DLUT_MEM_PWR_FORCE, power_on == true ? 0 : 1);
 }
 
 static enum dc_lut_mode mpc32_get_post1dlut_current(struct mpc *mpc, uint32_t mpcc_id)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
index c7e011d26d41..7a3faf2b1f06 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
@@ -724,7 +724,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 			.i2c = true,
 			.dmcu = false, // This is previously known to cause hang on S3 cycles if enabled
 			.dscl = true,
-			.cm = false,
+			.cm = true,
 			.mpc = true,
 			.optc = true,
 			.vpg = true,
-- 
2.42.0

