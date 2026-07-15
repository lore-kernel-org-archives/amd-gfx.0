Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25977C44508
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 13:47:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B57C910F099;
	Wed, 15 Jul 2026 13:47:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ozB1opJD";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013003.outbound.protection.outlook.com
 [40.107.201.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D2CE10F099
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 13:47:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nCOibufwASaVu3YAH/3alUTPN/VlqXiIB3II6No2JS2ATuJvK5OsugZ7nYmpeRQ4dQXGALEUp358eGxnBSE8t0EsSB5nPEKeGWqx9UWp48saqdka3aj2+eeYKLjNlm97AID96Qk3Qkvsmnwq9zpV30eVhnjeRh1jdtJC2FFoM0TZBECGe6SPpzFhC2LcmZqEQN0PUF8Xc05W1SSvLXZWfz5+5FFQnnFWj/KyWp1NHt0OxFusXUAvDXUt8VWgKJXn6Ug9XYmSF87V+zH+lRYAevLAyJo2dD5AeXxSbrFwU/nWzLM5OoYQr3mgKsXx8exEKvaHz2ETWBBnBBepooVeLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TjOSyuI9db07yc+DB0BteaShbzhrIlPVDWyVlSEEGoQ=;
 b=PGc/sw1o0aPKf/Gjf0Uwa8xjQluy3LNVgjK9VVHD8dW/GPCNOKPkGsp6SZOEsh1edlT6khkNYeMFrimUvPZgdk26c2+DPAh5kOMsvk5vVWTbJ06cK42AGyL+q8ZZjAVCWAcF8QWzw9AJXmoqKovitbgGXGXj371dg3bEot0n0dhfGS/L6/MumA1xj10Z8jDcQdl4MGk7pOCoPAfk6Tb0XXrnCs91hHPwxextIqLD9iBZlWWuhhhDxACImV+2sycZIUNDdvbgVXvJJsg4pmuJUKb5zNUkq3pE7n9TWtMj4oUZY4zgySztt3O3VAuStep/Dhkl4mgmS4rxvz/Ztz2D5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TjOSyuI9db07yc+DB0BteaShbzhrIlPVDWyVlSEEGoQ=;
 b=ozB1opJDMnSOEJu8rF1Ty6clFirTylaf7xjHc6xKTqTwMbO8R+Z1MWIOUfLL5W05wogrHBlm5xzM3Qqk81lXBSpLsmeTaj0hb7dIksv6XpJkcrwLqR5cKk9NI4B+p3WAm8hYdtg83nysKxtF/zOJlCB9rOjMO6ei1M3or4I6ouk=
Received: from CYZPR20CA0004.namprd20.prod.outlook.com (2603:10b6:930:a2::29)
 by CH1PR12MB9573.namprd12.prod.outlook.com (2603:10b6:610:2ae::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Wed, 15 Jul
 2026 13:46:22 +0000
Received: from CY4PEPF0000FCC4.namprd03.prod.outlook.com
 (2603:10b6:930:a2:cafe::44) by CYZPR20CA0004.outlook.office365.com
 (2603:10b6:930:a2::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Wed,
 15 Jul 2026 13:46:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000FCC4.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 13:46:22 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:46:16 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 08:46:13 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Robin Chen <robin.chen@amd.com>, ChunTao Tso
 <chuntao.tso@amd.com>
Subject: [PATCH 22/70] drm/amd/display: fix debug flags assignment in
 dmub_replay.c
Date: Wed, 15 Jul 2026 21:37:32 +0800
Message-ID: <20260715134432.1975118-23-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715134432.1975118-1-Wayne.Lin@amd.com>
References: <20260715134432.1975118-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC4:EE_|CH1PR12MB9573:EE_
X-MS-Office365-Filtering-Correlation-Id: e6ba22b6-00d5-4264-4f5c-08dee277753b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|23010399003|36860700016|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: t+72DkeeeFd5l+MhVPQS/sHBJPKfoPCvMuOkBsB6UU4lQlrENxVzPzNpuV+YaNbYQv4DO7hTsM1IlsxmG6y2lSJF3pPZop/WcX+YXVW2mPi/7U6eMMmwmP4R1xE1dGJvI7PhyT4wrf9lMHYxW2Do6SNXHnkavXmqB6T2p84zv/BgklgCrR2cwkMecvO7IQU4h6AB4uHKzlJddL+hVjFfEkbGxe4ZapJ75H6jRTovYCiZmK8M1KaNdkAQlOESyMXwrT9jLTZ33Wftdi506+fhTqK2LvWLxReahceYSVSgaN/arIA0dcbxtc9M7DVcz6f6ggefRxVoD49Qc8baph49bwwCc/JbIy0FIEFmo9COWrDFARelUmbC8h3X1W76FkNBUW/zwlac8/HGIkK6U3M6fdT1+jzqmQ9g1RjCX5Jq+DL4jcDYCswaYgMd45KZshQUHz4juM4PkGSOMQqTnCp09Ws1tYqhlZoZnAvUh6cBoH6m0ryBDnOxQLU+VtAyAuhR13UfLfqg/kPXzWwTeKYxMENHISWEtGaItooy8DMm5KNuRrDmXgjyoqtBtfRYSwN1RjV/LsjXjVOii1PlHf3GaEpHVDnv24j3z0dfBmHmgJdxT63BgNQXa+7e+GHfEkjEV/nvMzNZZ6gI+8MEtJ2ebN+KdLq8iVjk1U/03wGoDog8BUEPMjOTrwMnkqrh3p+uc/FgA7aIicpSwl9lWArr6A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(23010399003)(36860700016)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 608zrDNqSaD0Gx1MA7Pr7MiFGMrANYgVrnjeyQU6IU0tod/iqIhW5oay6HSYm4uX4gxuCtojkl/ycSHGogBGareMdswbzWboGdU/GUaf+Fv5KPyvDAuvfv4ojvtVUjO+ATmX3kuvvm0HDz6XneLAqnJbLwBH7s/IB3w2nC8mkoF67ifis6C41asBn9R1F6LYG73eCsVpobnUdXhssVF4Tt6aKbyr4HlMQQxwAwonpNxya6koA1zaFd32Txwybnzosdze62ohez9vLRRRryeRgBRdeB+s1lCzavWNEwth/Zi8MkWVcteIID67Rfnq6LPqAPGCc7KdG0lf0mEpBEFQTDlh81wkoMhSO3eIIZZWrO4kMLEH7YAu3s3j3f3+I0OmKmxbdhn4WM5osaCALBtH3WP7eLIJP+B3BivTV7QENDLEeCtbCoRWOBRIbOH6Yr5o
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:46:22.7985 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6ba22b6-00d5-4264-4f5c-08dee277753b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9573
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

From: Robin Chen <robin.chen@amd.com>

[WHY]
Fix incorrect casting of debug flags to uint16_t, which could
truncate the value.

Reviewed-by: ChunTao Tso <chuntao.tso@amd.com>
Signed-off-by: Robin Chen <robin.chen@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
index 6d19da2230ae..0f66164a3004 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
@@ -165,7 +165,7 @@ static bool dmub_replay_copy_settings(struct dmub_replay *dmub,
 	// Misc
 	copy_settings_data->line_time_in_ns			= (uint16_t)replay_context->line_time_in_ns;
 	copy_settings_data->panel_inst				= (uint16_t)panel_inst;
-	copy_settings_data->debug.u32All			= (uint16_t)link->replay_settings.config.debug_flags;
+	copy_settings_data->debug.u32All			= link->replay_settings.config.debug_flags;
 	copy_settings_data->pixel_deviation_per_line		= link->dpcd_caps.pr_info.pixel_deviation_per_line;
 	copy_settings_data->max_deviation_line			= (uint16_t)link->dpcd_caps.pr_info.max_deviation_line;
 	copy_settings_data->smu_optimizations_en		= link->replay_settings.replay_smu_opt_enable;
-- 
2.43.0

