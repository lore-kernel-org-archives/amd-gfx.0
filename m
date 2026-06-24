Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5E58CDE002
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2026 18:10:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B73110F0A1;
	Wed, 24 Jun 2026 18:10:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Tz1tn0IF";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011021.outbound.protection.outlook.com [52.101.52.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8366410F0AC
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 18:09:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jSXGZifzMA1Btdo3byH27OV+YL1FzLmsFJsbdekBgsj/sknH+/+osvqEokc+gXgytG+VZj6hXaBSU5pdvFMJh6fXhfhxzVXV4346rXzyCWpYf5q4+FzOWurG/+X2Zib3iU1V1jV2OPn+gYF2z1lDpXehyXKE9oxlE4Hs+5ZX7JC1R93NreTAU4m/46jUbLJR4HR11Xwhsu/CtHSVEz99Y5eYSIl64/vT0CBZNTsVOgIfPhUCLd6u/S7BFBSjaAiGjX9UAXvF58xm7Pp8EAESi2YeE9ZqInHmiMKqvRoFyLigLPCxPgc2JsJxgWdjiNv4t1DVscLY9hIvHTrv2bu70A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IZvAL9tFBio67IMiXZP9BISqD8gmy8qnhXyQpUSMRMc=;
 b=ykj0iqU4TA2dVFlQ7F6C3AXFhjktbK3cjEKHVbbvqvzIrAvseb7mcuGVyxlul12ngV7+TSzxCikT+QlSFsEwo4r1OZ83lIykarLGGN7xnFDS1oNxmAdldXzPqLWSce2A1GL9QN84T1yntkFJvJLLSxHwj3Hcn2x6n6052J5i5KioZs4/7mhQEB8f8j9uWKMEKPFI8AYaVWWd0ZzlS3ZHKogxbAxVH8zLGUcy7nS4hSM7KVW6LCCF05qHCioBz01Ln0dC3EPwctSjU/NbrjJ+E3EtGWHGcIxO+/gDQgZUsCbRz3aAwNI/EyIGk95BNBMeVNawOH8MOYVukrBzGH0IFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZvAL9tFBio67IMiXZP9BISqD8gmy8qnhXyQpUSMRMc=;
 b=Tz1tn0IFyJp8VRY6i5OZLiK37u5Ruf7HAConB1tZCiYD6/XHPe4aPol1Vd+ODffWmYYv9jVM+2qCHjoSUCE2/nrFYaFTHkZWM0H9IwBe6WaunRLCbqCy71L0pymAF6xOqtUGR7TuhiG8CyihWJ+yVTmvXQayilOxbGcBsU280Nc=
Received: from SJ0PR03CA0007.namprd03.prod.outlook.com (2603:10b6:a03:33a::12)
 by PH8PR12MB7376.namprd12.prod.outlook.com (2603:10b6:510:214::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Wed, 24 Jun
 2026 18:09:44 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a03:33a:cafe::6b) by SJ0PR03CA0007.outlook.office365.com
 (2603:10b6:a03:33a::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.14 via Frontend Transport; Wed,
 24 Jun 2026 18:09:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Wed, 24 Jun 2026 18:09:44 +0000
Received: from MKMGEORZHAN02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 24 Jun
 2026 13:09:37 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Charlene Liu <Charlene.Liu@amd.com>, "Ovidiu (Ovi)
 Bunea" <ovidiu.bunea@amd.com>, George Zhang <george.zhang@amd.com>
Subject: [PATCH 24/28] drm/amd/display: remove dead code related to forcevrr
Date: Wed, 24 Jun 2026 14:03:22 -0400
Message-ID: <20260624180829.4775-25-george.zhang@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624180829.4775-1-george.zhang@amd.com>
References: <20260624180829.4775-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|PH8PR12MB7376:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e1015c3-55ef-4993-97dc-08ded21bc511
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|56012099006|18002099003|22082099003|3023799007|11063799006;
X-Microsoft-Antispam-Message-Info: ypf5LSZP6iqNlBqY2/3voKjfpW6aQ88kJIEiZettZsisF+k1ZBqhdaOC5AT1SLg7Zkarb0/HYeY7BJbmBQogwjidsArhU7O6H12viDhXUlfmztJwevhTf9TmkJovgC5j46GA3G8q2A7mpwBehTAi3abSh6y5gLwkJdbW9lFuk477tVOqXMtVWeJ5BpL3rGOzwct7JsOYJvdf+6uyDGK8PauMcv0UnmI9WiROPeNxD5qxvgnWyywpx9DMLsO3rDbdDlMBIb7/LJpuG+2a6Sdf4Oe+AgWdb7G2By6yZyl2f89re8cKj7q2IymCqiTaKCenokJdN+8FI+rMv/9uOJ/a6YE16+SGMH2wFwEuoV9+iWz6Al1TxEU0uFtvtXSFWbZHZmppCMUg+NjK+9XA728Zosxe/tzQJq++Gd3V7j8d+CGb00JHEXqc9S5shj3njPzKDYD6Z0uz4AxReG4kdyFxXg/JKJq1l5e+hCPl/c9nCJ8uepI3gZALXkH9d6t9Guc9ybvRs1DohsK/a6yb9fio+x+NsEGETj/bkfk7p0ud9rBanIa3hoyOgwI3NeO+n9mf97YBYfRrKwFx7Rmx3PfiUA6TB0LnBoEks4civsJV2dvrWrGzJYWezYV+YpXTPHzJ50PzrAgz3C4bdPXuV2apWtdxNQaYPQrG4afmLNeOFdexwA7tZyZR4MzrVBnk6DE45lMnaArbBQumEbJHEUpygw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(56012099006)(18002099003)(22082099003)(3023799007)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NkE1pmxPVxt6uNrAm3rLLmyE9VPPtEniW41NEiIeKTRkoS4IbcWIGtG/GZ/9ZdbkH297TuN3EVJUyNIyY0hlEJntYo3bALB3V7NiTEZff1FXEL5vTya52pyfTUPHFcAywhfgAe4zJ6ESXXa7WvCBCbdxhEh9Gsv6l8akUDvQ97QAuD0ZjOSj29MBMIUIzx+SP9hJilxmIcFMCBZV+3K7nwK4ejyBMhVeIe7AefNz0Hi3eceOqHsk8J7kfNQUNyUd+sgMjhaZ2eNMxhBlUre2wP+P+N8inIN/lHQBpyDhke3hYP/IQxr/6gaPPyGopYh1B18/AIovfoG7vuiqkY2HrWtPWIko2jWLCShtaGKuh2DcA0zyFWnZdcuVP//mutSFN6hF5gIgTKEDeoYVWOZqkolCPntuKN2rh2Iw2NBJ9Ej9Wi0DuUqRS4hji1vZRzXz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 18:09:44.4577 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e1015c3-55ef-4993-97dc-08ded21bc511
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7376
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

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
remove the forcevrr related which are not used any more.

Reviewed-by: Ovidiu (Ovi) Bunea <ovidiu.bunea@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 92f84277c522..04d4eaa784ef 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1149,7 +1149,6 @@ struct dc_debug_options {
 	bool validate_dml_output;
 	bool enable_dmcub_surface_flip;
 	bool usbc_combo_phy_reset_wa;
-	bool force_vrr;
 	bool force_fva;
 	int max_frl_rate;
 	unsigned int  force_frl_rate;
-- 
2.53.0

