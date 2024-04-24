Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D20BC07E8E
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 08:52:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 296ED113965;
	Wed, 24 Apr 2024 08:52:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TSolquXU";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2050.outbound.protection.outlook.com [40.107.212.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90E8C113964
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 08:52:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I+4gr05vUWVZoclFURuokElYM4zxhbfTJw5LkqGYkVuwMM0QLJ+WLnOw7KC7styd+/KToWKy9Z90pVlUbInifgnDhZQWFWHN0AdjyYdvO6FdRQ7vxeVimj2jdpQoG5/E9qyi83uCEty5HOTTnm2YXJd0RrzDZEIG0nlFEHez86qmgOFD6Cw1f8wXrvcwI5qJ6N1jTYxNRnkOkov6GJOBWzyrriZ8NSe/c3CId9bPB3wt9kYbEkf8I8R4heFoGQepARBhqOeByFYPalyAiQltw53F+ilPzmLD75dI/RBBFLOlrq4yCggW/ZtVBJLYGOI1vLFf/nN925l7iYOYuW5AgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k0XnYmsOPao5EcV5BEBD3trhoD2HY9S4PA+H5PL22dg=;
 b=NlGk4tCvQSwhTcjTtYG4+cSk77TUaPXMjJChxIkS1DMYEBxkgDzqDMpZJDz4abvj7I2fDke4dFzXYDyw27SVOrMtkmBn16CHWfmg91ay82wTKgHynU1IRS6pN20NOlG+moEbHkz4ATArlDmIuesxwhb6zPsy545xzB8N14Yxj2CJOZ4AKcBYS/SVITbA34BKV0SUHsS6RJr2IuWdQqkPMgOkT5Dm77IGP9OaHNlY0aY88B/po0uD5grX8nKJ8wDWhns9KXDbgZt7PYH1j2e2WIsyqHYc3Zr2ZLHQbtLWIwaIT8yt7Q7zu27lCokHbAAQqCapbR3bpFcCECrwCHr4Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0XnYmsOPao5EcV5BEBD3trhoD2HY9S4PA+H5PL22dg=;
 b=TSolquXUiKAM8qtmBheknx4hfrWVr5tjLipx7vEFpyFInxpFmW0+BlyuT5oo5xk62Yd58TkHGTT2Ps4Lrrhy2pyWK14Zg/b1huG5bTvpHSpEekUf98hgRi+cxlsUa07E8ogBmGXlxr4TGPudXqfgQ7v88j3bmyRgNS/+pH5owM0=
Received: from BN9PR03CA0411.namprd03.prod.outlook.com (2603:10b6:408:111::26)
 by DS0PR12MB7557.namprd12.prod.outlook.com (2603:10b6:8:130::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 08:52:15 +0000
Received: from BN2PEPF000044A0.namprd02.prod.outlook.com
 (2603:10b6:408:111:cafe::1e) by BN9PR03CA0411.outlook.office365.com
 (2603:10b6:408:111::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.30 via Frontend
 Transport; Wed, 24 Apr 2024 08:52:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A0.mail.protection.outlook.com (10.167.243.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 08:52:15 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:52:12 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 01:52:12 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 24 Apr 2024 03:52:08 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>
Subject: [PATCH 19/46] drm/amd/display: Add log_color_state callback to
 multiple DCNs
Date: Wed, 24 Apr 2024 16:49:04 +0800
Message-ID: <20240424084931.2656128-20-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240424084931.2656128-1-Wayne.Lin@amd.com>
References: <20240424084931.2656128-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A0:EE_|DS0PR12MB7557:EE_
X-MS-Office365-Filtering-Correlation-Id: b2423f1e-4711-43dd-4a42-08dc643bd6e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?u+jeQLodm/oflcxuN0v3TGPYnOEHxKxmiUEdDKnzMlp3ASBg0VN87Uh0cjBg?=
 =?us-ascii?Q?/4vXko51v5EVJJ2k4cTOUNlWfVwXuiXQo0AhedUHodoMOzkrx1LvyJXkl4Gq?=
 =?us-ascii?Q?9nyhbFjmonOfru9749DbioVbYN9nTraYEiyfHOaXr/QrdWuscvv9u6/5YdTw?=
 =?us-ascii?Q?DkVXp6vEiq05vJ7rfIccjZavmuJOcNdvEBwPVnxAhgrurkQtYScU3KpfbrD9?=
 =?us-ascii?Q?OSB727eb4CpFFzK6J1H5yNJ+rkzmNO1qMkLmXk8ESVTzY42AgXoCfVoWgAvh?=
 =?us-ascii?Q?RmuuicMdinZcL+dyydJhSJ6tEPABOOy9oqRpsQ64yzkdK6fQhZnF1v9UdGaQ?=
 =?us-ascii?Q?Fs7keidsZfHWEHykRDtQMOOM2UzBVelLzF57qsZVMzbt/BT4TZCyEmszHXhA?=
 =?us-ascii?Q?YDUvkxZT/hCk0rgHtgENrFCBTeiFw9AMxbB3aT8MfIRkAzKovFU7s4GU14xq?=
 =?us-ascii?Q?OpuyVTzEFr7izHBywULggNxzK/h1HH59YKEdHjX9nJEe2hPqop0T38wMxFqS?=
 =?us-ascii?Q?1797JUYtl8kXa447ntCDV7VjTxvFEyI/q0vIJVlZKuaRh03OiW9YKlIub4jc?=
 =?us-ascii?Q?oKaoUJsiO1iD14Ic4/M3Gg4G3omI7szh0SvejUPTKLVQ3Ral0HX+96v2wpm3?=
 =?us-ascii?Q?IkEwa7qMhLpxp92KcacvRk8+hDftOXl2xC6zDcuTzRKal4nSDrbAmrs00e3e?=
 =?us-ascii?Q?mcQ6W1yidCVvTDXJYxxXhXiQgml1B0Syxj4mVvIfWb0+Yu1xJf/cjRkDmNF+?=
 =?us-ascii?Q?YLfOdTUWvsYEinFMrXxpn0oMoeoYskl4jVLJ/uPqoGbLLG1SETLxCz7BDMBQ?=
 =?us-ascii?Q?Nuc1OURyW/5/ohCtwiLZeOqgItCerBJ8evcQnT1or3TGq9/hrcCEplnAx8dO?=
 =?us-ascii?Q?2BL4/EmSFxNlwOqgKdCawSHndvRjhd1EVZIipsrX/Q1KdWoofX1O9FCQn8bT?=
 =?us-ascii?Q?NHJXohirfIYFs7AXT2BXiXljRg7TjkpWClvipVooUgSbYUzhKf7wxFPoA7rL?=
 =?us-ascii?Q?sSkXGqShZlPQUBykJggo8exNwFca0GdarODNkpwZcv5BcJN70qy10vFtjhK0?=
 =?us-ascii?Q?3g3a9m7EdmXl5OuWR/gS4JdFgFiLoEY8YkU4yz4MRUfmUWAikuxTzyt+Gd/q?=
 =?us-ascii?Q?ueor9I0CWs8AaMgvPSFHlaQdB3Uw85H7kxlN2nUBvVxX65npSBKI9Ee/cWez?=
 =?us-ascii?Q?0PsbMfRvFZSqmgQHwJ7BG7A8Ul/XwhEmQ2DdPT1O3EKq36m9KKogPKDsNznq?=
 =?us-ascii?Q?j1wr89hKhtd9daUZYo98kshHhuhlbrboAHhtbA2+Eu0mSO1cHc0h1MeDF1zF?=
 =?us-ascii?Q?oRusWjhe+gHuhX+/UnN5S6Fb8+TRJ3gu+5x90Aww9S4Xud8ddJ/hc4ZYbBrC?=
 =?us-ascii?Q?0WQ1C60=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(36860700004)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:52:15.0719 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2423f1e-4711-43dd-4a42-08dc643bd6e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7557
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

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Set up to enable log color state for multiple DCNs.

Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_init.c   | 1 +
 drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c   | 1 +
 drivers/gpu/drm/amd/display/dc/hwss/dcn301/dcn301_init.c | 1 +
 drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c   | 1 +
 drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c | 1 +
 5 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_init.c
index 18249c6b6d81..3dfac372d165 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_init.c
@@ -68,6 +68,7 @@ static const struct hw_sequencer_funcs dcn21_funcs = {
 	.set_avmute = dce110_set_avmute,
 	.log_hw_state = dcn10_log_hw_state,
 	.get_hw_state = dcn10_get_hw_state,
+	.log_color_state = dcn20_log_color_state,
 	.clear_status_bits = dcn10_clear_status_bits,
 	.wait_for_mpcc_disconnect = dcn10_wait_for_mpcc_disconnect,
 	.edp_backlight_control = dce110_edp_backlight_control,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c
index ef913445a795..4b32497c09d0 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c
@@ -68,6 +68,7 @@ static const struct hw_sequencer_funcs dcn30_funcs = {
 	.setup_stereo = dcn10_setup_stereo,
 	.set_avmute = dcn30_set_avmute,
 	.log_hw_state = dcn10_log_hw_state,
+	.log_color_state = dcn30_log_color_state,
 	.get_hw_state = dcn10_get_hw_state,
 	.clear_status_bits = dcn10_clear_status_bits,
 	.wait_for_mpcc_disconnect = dcn10_wait_for_mpcc_disconnect,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn301/dcn301_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn301/dcn301_init.c
index 0e5c037e82a6..97e33eb7ac5a 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn301/dcn301_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn301/dcn301_init.c
@@ -69,6 +69,7 @@ static const struct hw_sequencer_funcs dcn301_funcs = {
 	.setup_stereo = dcn10_setup_stereo,
 	.set_avmute = dcn30_set_avmute,
 	.log_hw_state = dcn10_log_hw_state,
+	.log_color_state = dcn30_log_color_state,
 	.get_hw_state = dcn10_get_hw_state,
 	.clear_status_bits = dcn10_clear_status_bits,
 	.wait_for_mpcc_disconnect = dcn10_wait_for_mpcc_disconnect,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c
index c06cc2c5da92..9cb7afe0e731 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c
@@ -71,6 +71,7 @@ static const struct hw_sequencer_funcs dcn31_funcs = {
 	.setup_stereo = dcn10_setup_stereo,
 	.set_avmute = dcn30_set_avmute,
 	.log_hw_state = dcn10_log_hw_state,
+	.log_color_state = dcn30_log_color_state,
 	.get_hw_state = dcn10_get_hw_state,
 	.clear_status_bits = dcn10_clear_status_bits,
 	.wait_for_mpcc_disconnect = dcn10_wait_for_mpcc_disconnect,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
index 934203ef52bb..f9120b1c1c1f 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
@@ -74,6 +74,7 @@ static const struct hw_sequencer_funcs dcn314_funcs = {
 	.set_avmute = dcn30_set_avmute,
 	.log_hw_state = dcn10_log_hw_state,
 	.get_hw_state = dcn10_get_hw_state,
+	.log_color_state = dcn30_log_color_state,
 	.clear_status_bits = dcn10_clear_status_bits,
 	.wait_for_mpcc_disconnect = dcn10_wait_for_mpcc_disconnect,
 	.edp_backlight_control = dce110_edp_backlight_control,
-- 
2.37.3

