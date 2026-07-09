Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89DC5C43458
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 21:02:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28A5210F6BB;
	Thu,  9 Jul 2026 21:02:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S5aSXwgQ";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010005.outbound.protection.outlook.com [52.101.46.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDF3810F6BB
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 21:02:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AjgDwrHWPNRlbjO/w9aS+DAx4Q4lU5Ngcn9ZGo58Hw/WtO07fscs2zBUnds6ewEL3p+keK8T7sdGhwCiaIeP2EbmzGlbyOvEd8G8SFWqRAzHN2ttaMFOaveW4Ka8+zpqFtdu+XAQ+9m0UW3k8j2NqcyqD3oHc+UAXn155GAUzqTwJu/80O+FMsAZc42+KYdp7VvIs1H5HgBBbUkbwC0e0mNfyFOgGclVbJx+XhFwmVLMPo6PwGngQdgtdbmMzzxA8bRNi/aDi0/Yq5jpPm2D3KO7iS8pjYLXJErVOBgX70wS9a5GCclE1ib6S/0C4zzqn8UpFQkHkSsYeyxq9YBuqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lRpXt3SIDtx+XSYCk2HQCxXUGMdAiwK8ww7gAZeJHSM=;
 b=laxTKOlvOivt3aughpdMmKyENG3hv2DoVwCe3AhhR1Tzxl4HBvVm9VztTr48Eial7neNz7J94wcy96brwEl2nEquz4jMUbGCQhast2S33zFlB1nFKPMrlT6F+sWUEjlTOj8uG0XeUxPVLlI4X/ZBHP829fdysW1UHScuGtaAU3OO4w8D0INX2u8kRQVprTQa9uhZm8kuspVP3RPtw5oYoHhnOe7+407ZIQbRBE5RHbtw+Bf1dI0+VNPShxuA2M7tyDGF9Dnh/5Vv1XLE8nlSZDLR8WR09fnmmra8cz6HgdtFcdg2V+sFY0HSPZywb2pDJ8rAzC5kuGCe9YR0c5pTIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lRpXt3SIDtx+XSYCk2HQCxXUGMdAiwK8ww7gAZeJHSM=;
 b=S5aSXwgQZXC/FSFczHNbcgU+H0A2u4EPUlHeus0i8eZ+TOD44CqhGeTT00bJZuaz2aENDIPVSMHAyY1FPwcrlgm0QUZh7OUkjCxyMTzqMWBP0RUW5Din+jTmYYFk1RErktFdbSWoakYan9xZVSDpCQ7Lz8f3E2jJus24kvn3Yho=
Received: from PH7PR10CA0011.namprd10.prod.outlook.com (2603:10b6:510:23d::12)
 by CH3PR12MB7524.namprd12.prod.outlook.com (2603:10b6:610:146::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 21:01:52 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2603:10b6:510:23d:cafe::4) by PH7PR10CA0011.outlook.office365.com
 (2603:10b6:510:23d::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.12 via Frontend Transport; Thu, 9
 Jul 2026 21:01:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 21:01:47 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 16:01:41 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Dan Carpenter <error27@gmail.com>, George Zhang <george.zhang@amd.com>
Subject: [PATCH 09/80] drm/amd/display: Check dc_link before applying DSC
 policy
Date: Thu, 9 Jul 2026 16:47:37 -0400
Message-ID: <20260709205936.5719-10-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709205936.5719-1-george.zhang@amd.com>
References: <20260709205936.5719-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|CH3PR12MB7524:EE_
X-MS-Office365-Filtering-Correlation-Id: 86950076-f026-40b2-07f1-08deddfd49fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|376014|82310400026|18002099003|22082099003|11063799006|56012099006|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: oA32Zx9IFI0jZ093gMCutSHOGksCgJUqLd1kO6Jw8POripcOy3NXxM8erTMLrfWHBk8Y8uhyzy9OjPcdgwEKfmj5EYYI/JThMJsdk2o4c1Z4RxB0+KboT6pqtkwRJZB2Cs9eIGAFYfQn67VVdrqSIUCMIxuIQqdczaqYy7XV8SfMSrLM2YaCh5RxnkXPzzt5WHqTgn8kQ+UgvZYmX2IFazEWanf0o/aM7YBcBEcskwxKKDSZ3RlsBSs3pg46YRLxKYg8dsnP5SoeBewOpn/shi+eCIhcgHquDiXDWbSVTErYU51LA9/dAflLt6RVoZl4LroGS4+lYO2J9LY27nTp0oniQE6C3rOpedV64MtNC29jP6f0YvZ4H949t07WtVa3vAYixacqJPiP2Hv8T6F9C8J8bIvJNv47nius088U6DDqTvGl2TIx4Dcs22qnbxGsJP5AeBnZcRVP3b/FaT6G424m3mBYG41+mULuw/hBFr9J/9Eki8ZB0qD/n3T7255acUHtkT3LBbleuokFODbJUv4KQ6TgbCPS+0TWK1rh4VNmOwKp3Xz9KdIQh/tCTbijlGPMogriZieEXY9kjJirepnZMCVlvv6B3sSzGRmnt3eOSCeqAWqTY5mPxUDA77hW9So986N62cx2A0LsNujmZp61Va09s8SP33afzuaNhtIJXUDhl1Fqmc/En8F61hQV49Emsfzee6+jmhLRxQA0Ig==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(376014)(82310400026)(18002099003)(22082099003)(11063799006)(56012099006)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: p1pjvth2KNILyY2TPkRVE3uyAgp2SeErqTPJtCYVh8RnpOZdpZWfDuZEhBC/5H2AKq1qW+mwORHD/mMXEPTq4/QwCTj8Jw4RgnLzj/ATcTld+XCFmEhj1oF9dhDydp12Xy0Qyw6Qa29GMHfY1p++Oy+ClvFWa2X0KKmBXYfs5db+c+wXCMz+NaDJ/ChesnIEWon/0B4W04e7TVKh9wP5H5BbWG3tdMDyS/1D89JAYQIXFuR/PTeY9YNOrwe8b1zb/fTtmYco/+HEaRtbJkLrS1/3IQjB21olQWOsWG9MlIq9SG05e7r43dikGGRK3qFQMGbgRPv8u8AgN9vyq5xwhu/CSe3HFonFL+AmrUAEip4iYOtFmZYVgq3vvCgb21E5vgzjm+YlQXb6Y9tbbhnBAKBt08ryuEYNaNo+Xd+RAbtLlblFeiMdJMq7Z6pPnDyP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 21:01:47.0531 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86950076-f026-40b2-07f1-08deddfd49fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7524
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

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

apply_dsc_policy_for_stream() decides whether Display Stream Compression
(DSC) should be enabled for a display stream based on display
capabilities, link bandwidth and user overrides.

Smatch reports that apply_dsc_policy_for_stream() dereferences
aconnector->dc_link before checking whether it is NULL.

Add an early NULL check for aconnector->dc_link before the first
dereference and remove the later redundant NULL check in the HDMI_FRL
path.

Fixes: 5903cc8da891 ("drm/amd/display: Extract connector and encoder code to amdgpu_dm_connector")
Reported-by: Dan Carpenter <error27@gmail.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Reviewed-by: George Zhang <george.zhang@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index 2d10ae5e7616..b9a3c8aa611e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -1238,6 +1238,9 @@ static void apply_dsc_policy_for_stream(struct amdgpu_dm_connector *aconnector,
 		drm_connector->display_info.max_dsc_bpp;
 	struct dc_dsc_config_options dsc_options = {0};

+	if (!aconnector->dc_link)
+		return;
+
 	dc_dsc_get_default_config_option(dc, &dsc_options);
 	dsc_options.max_target_bpp_limit_override_x16 = max_dsc_target_bpp_limit_override * 16;

@@ -1299,7 +1302,7 @@ static void apply_dsc_policy_for_stream(struct amdgpu_dm_connector *aconnector,
 							(dsc_caps->is_frl == 1) ? "HDMI FRL RX" : "DP-HDMI PCON");
 				}
 		}
-	} else if (aconnector->dc_link && sink->sink_signal == SIGNAL_TYPE_HDMI_FRL) {
+	} else if (sink->sink_signal == SIGNAL_TYPE_HDMI_FRL) {
 		frl_verified_link_cap = dc_link_get_frl_link_cap(stream->link);
 		timing_bw_in_kbps = dc_bandwidth_in_kbps_from_timing(&stream->timing, DC_LINK_ENCODING_HDMI_FRL);
 		link_bandwidth_kbps = dc_link_frl_bandwidth_kbps(stream->link, frl_verified_link_cap->frl_link_rate);
--
2.55.0

