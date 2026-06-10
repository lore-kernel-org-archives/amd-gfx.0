Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 432EFCD8CB9
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2026 09:50:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D588110E87E;
	Wed, 10 Jun 2026 09:50:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2J/ga2U2";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013047.outbound.protection.outlook.com
 [40.93.201.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE8A710E87E
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2026 09:50:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CtwnRfaP1BB6+uqlJINKovhVN4THEHcQaqgzk8m0Z2hgAmBhzGJcBg4iJ9fjYapFVcC5BmRpRsXWMmivlm3n19O6aCAlMcgBmZMj0iL3PyckldCoPVh2ZuG4QImHeEpc1mdAl53oxAl6LDuyaa9tGutr+JzI3B3F4oKalSp6fDPdf8T/efhwddHQRe3s3UUu4gy3r/p02eF7BHhYKKKCdHtTrKyVWe5Yke5VAahaeuQTIBdlsKD0tVkpCXxzPi7N/V8tiwNpUdJP274KUdENA2IJHwrlHN+SjnskRygPcmUpZNEBN5FTI/ldr5jThgqgIP81D5DiNRuaNeijxRUexw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SChZcUeOsYMz1iUYymGYFwuzEfJCqLzP4NhBUOhyNgE=;
 b=l9R9stIliwuNdctR4s0OVWlCmyQQccYLZJDivMLze5qKl4FR6UdzQZ6oofdlrd29PtOjxz+02U4L1fJrUoMv18AZv39xpq/Wd8XUDBO+/+DJ0OBTbO48qIXSbtEO2MvmplICF5oFNkKDiKePUaPEJ3yHy/udbTOrnRtpX1dulOIyWau5bGXOlyejNHQWILrBT0zdjBVxoa2/Vl/Olm2S6mYwb6NlGsMzsZWhPhP9nJmjmhfDw2YAMCEpuc61KJrYYpmL9FWWMeTDPpSbZ6yxMdRtwDmu8U/VVIoLYnRoGmdS3MPQz4SjWOib+ju5eZ/onhwfaoKDQg8FaYMNp5XtWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SChZcUeOsYMz1iUYymGYFwuzEfJCqLzP4NhBUOhyNgE=;
 b=2J/ga2U2pP5H0mb5wGRkb/4lNed5B/usDdbFgkWjIi0Q6Z5s+9mQHRA6m2ZKBwIQsH05YQH0XPzrXIIHy8oNrz65y4YKQG9Vm3KDfKUb6hb83BG8YZhDY1qiaFLh/QJzn3rx0hkUZp7orya2eUzTRMcuQ0gc/KVAG4c0yRwhPOU=
Received: from PH8PR02CA0047.namprd02.prod.outlook.com (2603:10b6:510:2da::8)
 by DS7PR12MB8324.namprd12.prod.outlook.com (2603:10b6:8:ec::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.13; Wed, 10 Jun 2026 09:50:06 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:510:2da:cafe::a) by PH8PR02CA0047.outlook.office365.com
 (2603:10b6:510:2da::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.11 via Frontend Transport; Wed,
 10 Jun 2026 09:50:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 09:50:05 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 04:50:04 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 04:50:04 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 10 Jun 2026 04:49:56 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Gabe Teeger <gabe.teeger@amd.com>, Matthew Stewart
 <matthew.stewart2@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 14/32] drm/amd/display: Enable pstate for DCN4 non-emulation
 builds
Date: Wed, 10 Jun 2026 17:44:58 +0800
Message-ID: <20260610094639.1965367-15-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610094639.1965367-1-chen-yu.chen@amd.com>
References: <20260610094639.1965367-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|DS7PR12MB8324:EE_
X-MS-Office365-Filtering-Correlation-Id: 776be2b0-badf-44d3-46f5-08dec6d5a65a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|23010399003|376014|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: jSJC498g+60XTtdgVVQlVlka1WIFeDzsAKj6hG1P9lzwub9wU96Fwhd6+gKA/DZx9J2GC7dPYDuaITODbwJ7RwJAXrY/gauhHuL5y3TCdU0rdkNhBw+g/rtvXOvS9ezT9+2+7Q5dCyDx/R1LlWIAETenPXnY0JDcWijcUBpgLVJlXGTBF3tSD+pnU/I4qnBo/XusPw0TzKupmcMhOk0aDg010Ekn3MLEYdo+0tffgfLbpsMq988aU9rTUQb1G78PH+QFFJO0NgVcm5pGQ2VD4i9THu44+DPkPZ6sWPNJIcBdS2u+gS4nDIjYorJl0pqSgF/3FnBiF6uSLD6HvK1/EA5cOBiQdFQsWOfhdxLaVe5tMCyK47ZEbe46Z/LJ/wKifInaa5cZdGmATwemgsp8pHpfmtuh3gxQei6BiCrMCq87HykayNgX0yle5A+qDAIYscYAqEYnU/ZD/SaP0P7nmSAcoS2hAJ0ZYpTIjPFmsjaOXh+bSPnaYA58EB/ib8ig/sTFaoBaYSu8kjaHJdqNRRibJDtJ2oeVG80u4OYUG3VhtdR1udvZUlmKbYNI/G0TDLnPi7NNYMwNkE3ISuD11RjtYL84dhg2lWWijQzbWe/BSwF1qyTul8dFPePw38i61myydC2cb71JEEUMEn5X/6Xk8P3Ld9nLyOA1pGlopkAF/nPf1uqGW7szSLe5+CsN6iBDwcBMmiGtvoyJOy2VBJ/ReSGq4mtKcUYAx7wgkKg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mu8IqR1Sk7KHEVsFa9WvZa9ET1pRTYo+/1o9/TjSZYCfR2PCmgLbXZoAX3hsFhw7z0QwXckWO6DuotX6mwSduY8uabUlDTg0IGvKEaZimsBBO4E8UhGojy4ADEspfSiKpGIiUjRD5zydYvNFF+WwYWZIR+YDFYuYZQ5gkTa9kGaWNiObuGoFdJA10UmDTHeGB3ns6C6wKcbGRi7SIeeBIgrLhbw1kwAT4He9smxHGSzjA6ewSQ672HKga2f67r70Gos5K8/GbOWF7zz/ie+Sy8b9Sft3wcZ1HjNtNb7dnhgUpGm84VHywEAeOOdn9QDkk2xwfH1uIiih9HHy1pStIQEBQZVp9S9Dyscntq5qebQz7Xs6vc3T/5Tfp99tWaSg+kIACZ0a6/JqH7moK+QmJp68Hxcj2Rtk5+o2mj0Do94icbRvCfZUVZCEQQoL5oJf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 09:50:05.4108 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 776be2b0-badf-44d3-46f5-08dec6d5a65a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8324
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

From: Gabe Teeger <gabe.teeger@amd.com>

[Why]
Pstate was disabled during bring-up to avoid interference. Now that
bring-up is complete it can be enabled for non-emulation builds.

[How]
Set pstate_enabled to true in debug_defaults_drv for
non-emulation DCN4 builds.

Reviewed-by: Matthew Stewart <matthew.stewart2@amd.com>
Signed-off-by: Gabe Teeger <gabe.teeger@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c    | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c
index 527d17f29f3b..669bd5eb4c8f 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c
@@ -757,7 +757,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.underflow_assert_delay_us = 0xFFFFFFFF,
 	.dwb_fi_phase = -1, // -1 = disable,
 	.dmub_command_table = true,
-	.pstate_enabled = false,
+	.pstate_enabled = true,
 	.enable_mem_low_power = {
 		.bits = {
 			.vga = false,
-- 
2.43.0

