Return-Path: <SRS0=f4Zr=PM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210CBC433F5
	for <amd-gfx@archiver.kernel.org>; Sun, 24 Oct 2021 13:32:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D77F460724
	for <amd-gfx@archiver.kernel.org>; Sun, 24 Oct 2021 13:32:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D77F460724
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B12C16E135;
	Sun, 24 Oct 2021 13:32:48 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2088.outbound.protection.outlook.com [40.107.96.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E75156E14B
 for <amd-gfx@lists.freedesktop.org>; Sun, 24 Oct 2021 13:32:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DTlnfR10JEjvJhD/Aborv8+BDJ/Y6JJNlf+ZasLo0HdEjEFe9kDz8XPb9ni4ztV4nLk1ftVLZUc1gCcoP05DMb02FfSmur5ffha/0NG/FDLZ5nemymJRfmFEyBJX2MpEpBoyQODNw6Z8J7TqYDfqBgRotOtJj++B404HBzuQb1OW92eMMw+cK0H/KReSPgmdLbkkvEtlwphNZ0KZbEO00/hnDfy6adjl/tE12t7lhP+e/ri4TPggkVPVf8A9qHOxa2sIse7hNNQdXx8n7Uaz99m51ia2noc93z1KdXPcrwO1ncQNmLnOCWPU15MX2JksmkOIdAOazmc1Xlu906jl7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wRgIUKPpDsH5jTxQGZJwONEDSF9JgN0CbKiCBFap/rg=;
 b=POOnfYzpUKdsbftdPL1zwcjA+XgUgKEhj+FjZh+A8petncEH9rIfaOSr4R4cvbzynsRRQbIASXvOejyYViPeT9BT3p5C9z3Un9hwh1BBtnCwccXiu11IMyuu9s4f8l0295KGgJ2B4c3smN468vElMaRKN1aQFx0cFLGcSEjPS5cTzLuxXgmnQU1A1257FBDkSh4XfCKO/jmUg7RRU07v7VyLSTFZsCj8AuVL4mnInehsYmolFobGkZOlLxMZxU5kSk/Zfq88dE1RaEDekNvnG4D+5ys21ayr2MlIbm9uNuI/Gpqoc5UWbF0WbBr2uYBVl+DvtNGKLhOqFbwo68coiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wRgIUKPpDsH5jTxQGZJwONEDSF9JgN0CbKiCBFap/rg=;
 b=g+dX1+xWLUMkV6wrooNylMR/8BtZbncerTAotZhgbQ0NIMqED718noBupBlAQB/kRLQ2I78t/IPK0ZMi4R+sgdtDAoH5vyVo3dzXFbE7dkFkBZNnI9ZTEqJXgc25NYiRWnc+PVhQ3N+NB+xQOiDrOq9IgJ9WuutrKqC2ZpTZj9k=
Received: from MW4P223CA0019.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::24)
 by DM6PR12MB4778.namprd12.prod.outlook.com (2603:10b6:5:167::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Sun, 24 Oct
 2021 13:32:36 +0000
Received: from CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::c7) by MW4P223CA0019.outlook.office365.com
 (2603:10b6:303:80::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.22 via Frontend
 Transport; Sun, 24 Oct 2021 13:32:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT029.mail.protection.outlook.com (10.13.174.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Sun, 24 Oct 2021 13:32:35 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Sun, 24 Oct
 2021 08:32:34 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
 <agustin.gutierrez@amd.com>, Hansen <Hansen.Dsouza@amd.com>, Charlene Liu
 <Charlene.Liu@amd.com>
Subject: [PATCH 24/33] drm/amd/display: Set phy_mux_sel bit in dmub scratch
 register
Date: Sun, 24 Oct 2021 09:31:32 -0400
Message-ID: <20211024133141.239861-25-Rodrigo.Siqueira@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: f195af08-0b97-4120-d0ce-08d996f2bdca
X-MS-TrafficTypeDiagnostic: DM6PR12MB4778:
X-Microsoft-Antispam-PRVS: <DM6PR12MB47789E50CC1AEE77719928D098829@DM6PR12MB4778.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B2dNjT7KZ1hml1+9PpgRChdBx44SDfSxoPqQPqbd+5gWl4+BMFTwl3IUzsU1CebSbSTKxyMZSTTmjLiyY7FZkCqBhQlng6SvRFLw055NxpT5NnPRqsCfskZC2CrVKXs21kOCdVJNSOz0ypXogpBlsic4/WTncMkOsKFa0zJiixbg1RpaSTL/QJOzcSYy0rWOfCwPFR3JsnsdnCBh8ULEyqImT3qHsgYVHKkGDzCFhK//LceE7VVQeqK5mBlhVPfaZsxRhwrN2sm5rq6Z/nI1pqamhsx1P9YkT0GYMt9+Q9QPlKXgPG5c0ZgDTMhiTi4E+qAFTelGcSp9PHMCMdP5qXUSqs4Qxkf5jVmpGlLZCekqNS5n6ULKviclnrX7WUrGor3gECPxZLyYOQakwQl6BuAi2RpRTWRgRO7f5Nw0CxMMR6ZAxssvsRdnmfTt1FxmDFPWoP+6Js1a17vB517mOFbyW/SPw2FKs0G3GiHXvtuLf5Uy0hq0lERJIA4/dNZP5rOeaoYSE7esBAXyVAftfxtsf7UpGOTMCrk/qXbagYmD6Pn1IQ5HOJuQTfjI6NM40kO1VdbK/mGvPaH7OT5BaF7K3I/r+EpFbbPj04MVVvWDdZk/wy3VyJ8UNuVqljqlHadVI5qs9nML02QhQWLe0tq7IWnePpz1f8ZiHfW3BkzU+EWTfuTo2/dvZSb1I8z6JLeEYkVpEbg3guN5g9S4De7bzEjrKdlfp2HhX52i+Vg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(81166007)(86362001)(5660300002)(6916009)(70206006)(356005)(70586007)(2616005)(316002)(8936002)(2906002)(36860700001)(47076005)(36756003)(8676002)(26005)(508600001)(426003)(83380400001)(4326008)(54906003)(336012)(82310400003)(1076003)(186003)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2021 13:32:35.8554 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f195af08-0b97-4120-d0ce-08d996f2bdca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4778
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

[Why]
B0 has pipe mux for DIGC and DIGD which can be connected to PHYF/PHYG or
PHYC/PHY D.

[How]
Based on chip internal hardware revision id determine it is B0 and set
DMUB scratch register so DMUBFW can connect the display pipe is
connected correctly to the dig.

Cc: Wayne Lin <wayne.lin@amd.com>
Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Hansen <Hansen.Dsouza@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h       | 1 +
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 4 ++--
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c | 2 ++
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c   | 1 +
 5 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e56f73e299ef..8a8a5ace1040 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1792,7 +1792,7 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
 		break;
 	case IP_VERSION(3, 1, 2):
 	case IP_VERSION(3, 1, 3):
-		dmub_asic = DMUB_ASIC_DCN31;
+		dmub_asic = (adev->external_rev_id == YELLOW_CARP_B0) ? DMUB_ASIC_DCN31B : DMUB_ASIC_DCN31;
 		fw_name_dmub = FIRMWARE_YELLOW_CARP_DMUB;
 		break;
 
diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index 365fbc4758e1..6c4f0ada163f 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -97,6 +97,7 @@ enum dmub_asic {
 	DMUB_ASIC_DCN302,
 	DMUB_ASIC_DCN303,
 	DMUB_ASIC_DCN31,
+	DMUB_ASIC_DCN31B,
 	DMUB_ASIC_MAX,
 };
 
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index e0bbfd1b7a2d..7e22293e78f6 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -374,8 +374,8 @@ union dmub_fw_boot_options {
 		uint32_t reserved_unreleased2: 1; /**< reserved for an unreleased feature */
 		uint32_t root_clock_gating: 1; /**< 1 if all root clock gating is enabled */
 		uint32_t diag_env: 1; /* 1 if diagnostic environment */
-
-		uint32_t reserved : 19; /**< reserved */
+		uint32_t sel_mux_phy_c_d_phy_f_g: 1; /**< 1 if PHYF/PHYG should be enabled */
+		uint32_t reserved : 21; /**< reserved */
 	} bits; /**< boot bits */
 	uint32_t all; /**< 32-bit access to bits */
 };
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
index 3988f65f1ea4..5df990277dd4 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
@@ -340,6 +340,8 @@ void dmub_dcn31_enable_dmub_boot_options(struct dmub_srv *dmub, const struct dmu
 	boot_options.bits.z10_disable = params->disable_z10;
 	boot_options.bits.enable_dpia = params->disable_dpia ? 0 : 1;
 
+	boot_options.bits.sel_mux_phy_c_d_phy_f_g = (dmub->asic == DMUB_ASIC_DCN31B) ? 1 : 0;
+
 	REG_WRITE(DMCUB_SCRATCH14, boot_options.all);
 }
 
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index 77c67222cabd..56d400ffa7ac 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -208,6 +208,7 @@ static bool dmub_srv_hw_setup(struct dmub_srv *dmub, enum dmub_asic asic)
 		break;
 
 	case DMUB_ASIC_DCN31:
+	case DMUB_ASIC_DCN31B:
 		dmub->regs_dcn31 = &dmub_srv_dcn31_regs;
 		funcs->reset = dmub_dcn31_reset;
 		funcs->reset_release = dmub_dcn31_reset_release;
-- 
2.25.1

