Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2ED9C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Dec 2021 20:33:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 330A46E871;
	Wed,  1 Dec 2021 20:33:48 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2042.outbound.protection.outlook.com [40.107.95.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1AF56E871
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Dec 2021 20:33:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hvzbh4JbsItq6XRiwfxQOhrwCQzkryHjm55QOhplta9JXHyz9x+e7dQpjmAKzZdzGFUMyojaO+mPhuALTXJr8bzX1wrjwcJHAK0lCgUp6Qmx8ErkwmK7xtqkzQje+kK2AzY9mlVqMT6ja96+jZSD4l7T9QDAnvlbnvKvpyHpjiLJbSoAn8E81TniyMD3wXraNy8Azd5xfw1EnZjFs3kJrbyolaJhHiO/Izx3LKicW2xS/j98bdMBUK2d5TsfkKVULCoVyzNCK+FFWBxSHZE262USn5Kwyu77DyrPzaUyq2zbQqs/GZKetyZFPlhNrjMZexe5hdfFi1jkmrds8MIi4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dmOaedNbqGjTgPHmUr2fKsqjPZy2D3f52AyrS/1InI4=;
 b=fyfyM0L3X3BDN7jS9oMTyTkNgK8kvX1p0crkBipJ8BGRUgO+3wylmtEhopPSsHV4adR5ffiEJR7VijTr4yavpXSXqOKnPL7/C9MlY/IjhfRR8qoIgEqKNzrXY6FTakDr1xvVum0lpOBQGKcDYC3hF3QSZdP44UQa8MYuxZMSq21sj96+GsH3xOCilXfNvJPRhMTJdA6pG675kuMKNigzdFpkVOqttxlk8HaFgP4nJfKG7qQELAZHFOhycigXK0ZZFU61ONal3jVENEuoa/zQWq0lbwOmRWdroehunQ1+CfPUiPU5uJ1FVmhQMVYh1YjPU4QZxFTQIsRsd55ZBZFfLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dmOaedNbqGjTgPHmUr2fKsqjPZy2D3f52AyrS/1InI4=;
 b=K2OMqM5SGs46sU+/St28S73tfhKNgTTSADJ22mjq0xTB+T5eZQwRR27Vj9PAVVGknEadB+A5NcuWt2m5BMKJN4BgxcjT/xWq1XJ2z1nnMnPhuzcjxPed2w5GbERsj/3TuL97FuFVYjJ4trMVgWv3zKM51mBHxU10J3y93ionBKw=
Received: from DM6PR11CA0037.namprd11.prod.outlook.com (2603:10b6:5:14c::14)
 by BN8PR12MB3604.namprd12.prod.outlook.com (2603:10b6:408:45::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Wed, 1 Dec
 2021 20:33:44 +0000
Received: from DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::74) by DM6PR11CA0037.outlook.office365.com
 (2603:10b6:5:14c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend
 Transport; Wed, 1 Dec 2021 20:33:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT061.mail.protection.outlook.com (10.13.173.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Wed, 1 Dec 2021 20:33:44 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 1 Dec
 2021 14:33:43 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: fix mixed declaration and code
Date: Wed, 1 Dec 2021 15:33:31 -0500
Message-ID: <20211201203331.844876-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4918cf6b-b1f7-441a-f9f9-08d9b509deab
X-MS-TrafficTypeDiagnostic: BN8PR12MB3604:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3604C3E2C9F2F3EEE0214CF6F7689@BN8PR12MB3604.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kLq6zIDPk78q5YWHIRc5bFFYRvckftOr0+m9MIHmt+xa7X71/KFuxaXPU+FmGTsPfpARtf1omkQgOBSL39jnM/Fs8MjzfEBOFiM+8znQjn0frQtPRqAH9tI5yP62wDHRJtKMWbC8hUopGLX0qkYHw1DgYbWBvmi2UmErsirHkpmPp8gF8v6bEKIA9+kIm1p2ScK4N71blsa9YDeB4cg8WouRCvCeCALFgen+wjnWRLnp8PQF3b6BZ9VleH846hDaWL4TlkGnTWwCaYlH5O6+oUY79iBn4eYwt3LQaIxnlBzHozEdmTqvw6XYOY23A+Q3zly56hvwU580nU0nKX9jBXY9TGzMcNciIUd4OagrSO7k2VjKfBe3HWyTpwwcuDtEgQxTQ/evmr+x2GhX0UmWbwOPllQYfpwIb3goveeqx6tD8yzTDST2dBGnvAYnL+YtI38OrNEvRqDooN9wtcl9vuKI45SVtwlIFGSYgQ5IF9I0El8o/OY5/Wx78gWsBZMd1B1BmQZdOGRrpIaYvFcYR/VhwG22nYe902S16KzZe2BiuDz54cordNiuymu52/D9JhxaC60dRLgQzoXpp3P3raaExEURJspagv+V2g8uVTsQ7jl3ErlLL0DOOGzNpTwTrkB7sV2ltfHzudvAK+lJkXXjC/olCpg6kqogWQdkZ+gPBlY9WMj/MTznXIZd6ReXBwufU4sAEvJR2h31mBCyQMThYru8MmGkbiRKb3UJHaRIX1O5+JHYHWrYSOeYojHnum3jh3noXrvgAt0WAZFQe6YrXK73hZtpxg8lMErX8rs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(40460700001)(316002)(4326008)(26005)(6666004)(86362001)(5660300002)(1076003)(336012)(47076005)(82310400004)(2616005)(16526019)(508600001)(70206006)(36860700001)(186003)(8936002)(356005)(81166007)(2906002)(7696005)(6916009)(70586007)(426003)(54906003)(83380400001)(36756003)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 20:33:44.3844 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4918cf6b-b1f7-441a-f9f9-08d9b509deab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3604
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Fangzhi Zuo <Jerry.Zuo@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reorder the code to fix the warning.

Fixes: 8808f3ffb14d79 ("drm/amd/display: Add DP-HDMI FRL PCON Support in DC")
Cc: Fangzhi Zuo <Jerry.Zuo@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 66dacde7a7cc..62510b643882 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -4684,12 +4684,12 @@ static void get_active_converter_info(
 
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 					if (link->dc->caps.hdmi_frl_pcon_support) {
+						union hdmi_encoded_link_bw hdmi_encoded_link_bw;
+
 						link->dpcd_caps.dongle_caps.dp_hdmi_frl_max_link_bw_in_kbps =
 								dc_link_bw_kbps_from_raw_frl_link_rate_data(
 										hdmi_color_caps.bits.MAX_ENCODED_LINK_BW_SUPPORT);
 
-						union hdmi_encoded_link_bw hdmi_encoded_link_bw;
-
 						// Intersect reported max link bw support with the supported link rate post FRL link training
 						if (core_link_read_dpcd(link, DP_PCON_HDMI_POST_FRL_STATUS,
 								&hdmi_encoded_link_bw.raw, sizeof(hdmi_encoded_link_bw)) == DC_OK) {
-- 
2.31.1

