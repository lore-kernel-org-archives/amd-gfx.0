Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74DB7C4167B
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Dec 2022 20:22:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 248C810E47F;
	Wed, 14 Dec 2022 20:22:32 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2041.outbound.protection.outlook.com [40.107.95.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F92A10E47A
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Dec 2022 20:22:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oBjWbyezPAiL1U87utKPusEXniCPS48XDGiKMkRfjx7YlNZhynf7BE8SNuf62cGddqNjvgBrK8qd0nTAmEm3+x9WaCTqUytyZijNmV47Ul0Gag/TD2FzOYm87QflsvEZgguhZavZoYou1fK5fwT+JvPUvTvxRwGfe15RLZA5eMBwrYF8KQ9U20xuHu5P9F7cQY4aXKIzmmOc5Vrf0VLUfz+CEC0urBsJ27Ggwdl2q4Wve6c8CjmDZHjhu1ha+PAclFocpVu5cRHoglZBitK/Y4w29xlrHe5Xnj0XuGwOPyCq+S5/f6CD0Qp2X7MvD7j7J9VKzx+kNKBUMSOtlMMlqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1dKnRNgBf+bfSZg623/yQbJN5nn1ojvmiltTuLNMF2w=;
 b=SIZRNxEwKtwg8Xeu/1ZZm3++d97ASSl8ycJYnAJB1E73yuT816wKLb4a2prb1cmgsCd5Q/LXzGqPlWjBXBIMS8jD/w66F8wbsziRrEONdOBusGs0aSFkz0tcq52SypvucroZJG6BBfIBRANGYCsT0uL23rjmg1uFnHBSvgo0t6ksFJZxm/fCsP/CYYKwaP3ExX9CyMilfgCZ/0g94YTe0cywGLeop2OyUeP/v2mpvket6NfOugkNfmfj+I/rc56QJWtvfn2kGJUCWk25S7v/pHlPaHK/GsPoXl2MAlbAQTavCMtfDh7aLWecE4Sw69R4gw7fAm8MRC/izshAZghA9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1dKnRNgBf+bfSZg623/yQbJN5nn1ojvmiltTuLNMF2w=;
 b=bkGHxYXn+T+YsR4yUgwbEL132lj9n/j/bi+5bbyftxXFHi3LV6/vZ2+5lOql996AanyoFJ3sfbyPUs6ZFtGrv68YIYktbv3CjuAPfeMnNgRWzEDOpmoJGwAmvCugp8qZMYYLnOP11TmNcZdWJtn6fyXHKVV0MJBvlk+W8TTXo0M=
Received: from MW4PR03CA0078.namprd03.prod.outlook.com (2603:10b6:303:b6::23)
 by CH2PR12MB4168.namprd12.prod.outlook.com (2603:10b6:610:a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Wed, 14 Dec
 2022 20:22:17 +0000
Received: from CO1NAM11FT084.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::a5) by MW4PR03CA0078.outlook.office365.com
 (2603:10b6:303:b6::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11 via Frontend
 Transport; Wed, 14 Dec 2022 20:22:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT084.mail.protection.outlook.com (10.13.174.194) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5924.11 via Frontend Transport; Wed, 14 Dec 2022 20:22:17 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 14 Dec
 2022 14:22:16 -0600
Received: from aaurabin-elitedesk-arch.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Wed, 14 Dec 2022 14:22:10 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/18] drm/amd/display: set ignore msa parameter only if
 freesync is enabled
Date: Wed, 14 Dec 2022 15:21:38 -0500
Message-ID: <20221214202141.1721178-16-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221214202141.1721178-1-aurabindo.pillai@amd.com>
References: <20221214202141.1721178-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT084:EE_|CH2PR12MB4168:EE_
X-MS-Office365-Filtering-Correlation-Id: 70ac3efb-e870-4f74-3b4a-08dade10e522
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w2oUM508afYLoVosS9lKHuHehW1qgGFj/LHIYQ2ApSEBq/gors71IiA2BURcBdAk0v+Z0mELCtMFqvFvM606vWHra9rmL8hkCkmu7bOvkJrIqsc02ueivEJZzYiMMWMBdQr1PrPw0CWE8prQH6DWVDTLfYx1cJI4vepZT3bERSc7fM8pT1WpPxBk2+Og/O+Dfm+dxoJCpL5Wu6Gt7iCmUIM5yOpMK4jzfms2OChJT8OcVoavh2U/HQhTmOSVdHueW+Ea9pzHobAimgdi+jgMyUuciIP1L9+kCPeTPzEy47TsT4/HCtxvz7LRJB3qp7UfzeaSKI9RbWStxudAAHVas6Cc8gstA8kVeLsM8Dnm33P9pc3ro/cO1uv5nTRotSbeq9PocucwDtfLgvbF311Wy6tVJfH/IwymfZuJMOyTBUuSw4W0UBsLCWLm+oO66M0zpqxxmMhWFYrIIeA2SUIbFhxrVc7CNAi+dXr/qu19Onc4t/qWKtqyDkTOfKf9lS9mQ8gv8t9B985YGp2RwXk1USj65d1Do0BGcx+Pif1rL/F/n/6yvuR1ESozx+AmRt/wUd9yUB64aQr01WyCb9FuEr9QozmtXlCu0mSPd4Nfd924ZrX4WWwCI17gBCSMQHAPnJljmmi84EMxypOkY7uhW8mcVTjUnsliNGwB5bKmc/BKogipxPHGVk9/BVcyiUWuz94NKVPfvggNQ+by5rwvxSgVwblFG8OURoiiF1Yust4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:CA; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199015)(46966006)(40470700004)(36840700001)(54906003)(5660300002)(70206006)(336012)(82310400005)(4326008)(8676002)(41300700001)(70586007)(36860700001)(6916009)(316002)(36756003)(47076005)(478600001)(7696005)(82740400003)(40480700001)(356005)(26005)(81166007)(6666004)(83380400001)(1076003)(426003)(86362001)(2616005)(40460700003)(186003)(8936002)(44832011)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 20:22:17.0009 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70ac3efb-e870-4f74-3b4a-08dade10e522
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT084.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4168
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why&How]

ignore_msa_timing_param is used by SubVP logic to determine if SubVP
+ DRR is possible. Linux does not support freesync on multi display
config, which results in incorrect assumption of VRR support if we
set this parameter when VRR is supported, but not enabled.

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 6b7a0f521f1f..f9461857ac6a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8813,15 +8813,22 @@ static void get_freesync_config_for_crtc(
 	struct drm_display_mode *mode = &new_crtc_state->base.mode;
 	int vrefresh = drm_mode_vrefresh(mode);
 	bool fs_vid_mode = false;
+	bool drr_active = false;
 
 	new_crtc_state->vrr_supported = new_con_state->freesync_capable &&
 					vrefresh >= aconnector->min_vfreq &&
 					vrefresh <= aconnector->max_vfreq;
 
-	if (new_crtc_state->vrr_supported) {
+	drr_active = new_crtc_state->vrr_supported &&
+		new_crtc_state->freesync_config.state != VRR_STATE_DISABLED &&
+		new_crtc_state->freesync_config.state != VRR_STATE_INACTIVE &&
+		new_crtc_state->freesync_config.state != VRR_STATE_UNSUPPORTED;
+
+	if (drr_active)
 		new_crtc_state->stream->ignore_msa_timing_param = true;
-		fs_vid_mode = new_crtc_state->freesync_config.state == VRR_STATE_ACTIVE_FIXED;
 
+	if (new_crtc_state->vrr_supported) {
+		fs_vid_mode = new_crtc_state->freesync_config.state == VRR_STATE_ACTIVE_FIXED;
 		config.min_refresh_in_uhz = aconnector->min_vfreq * 1000000;
 		config.max_refresh_in_uhz = aconnector->max_vfreq * 1000000;
 		config.vsif_supported = true;
-- 
2.39.0

