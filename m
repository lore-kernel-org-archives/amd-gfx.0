Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3952CC56201
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2026 06:42:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C40F010ED19;
	Wed,  5 Aug 2026 06:42:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mHZo/oXD";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012057.outbound.protection.outlook.com
 [40.93.195.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97B7410ED19
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 06:42:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iqaS3I4ykGI4WvTS30BalfFHq89GIsFWe0wp+MnZaalMgZXdbUtJPW2bxFkNmsCVrSThZD7BQMKsiYW/C5h5dvL/ju5X5EQv1mByo0RScQ4nlluzv8ppJKjgcbCSFJsBtZu9Ggg6k5b0ReF3a1CvRTrJyIdVozTD9/ICLe8iK15TPUJRhHZAN4HC8WvE00EDTOElhHxbN8YXtVgDsglSIbRu+dc+72NDNreY3EK2/T7Acme+LmPS1iYEjbySidqom3UYJ5KvQ+QzrIsAyE9Gh4l3WYffpjsup5yRZoxaUiLy2OysfcbtYfjuU/ciyzNVD7+manBIatxBGXAKtl6ikg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQy5Ul4kzxI379Uc9ZzTf7zGiRYKI80DqMO5kzCwZV4=;
 b=O5LG+qp99YAbPMiIEoAfMwT82/dDPwoY/4YTQZxqColI/kfVIqvnR7TfBrefZDnTfcqcoOOQWXMf5K1hZ6ibGhZa9CpY95wc43RUguM5lkI9mizCtv6PgLNgB/uwl9fuHNATnT8k2LmuRmu9KQrNu82Jfa48zRKNZmMnk0ZtVjAv4gRc6F4lVmYhM+6zbJEQJvkfiMssHSxArXgmD9P9qc67Hla52t81v9nLA3TNcgmQrh14we54niqh73qV2uWmkQLA4Yt8FOYaT7t4WvDeSM5FHz+eQYvTxLmHenSFNjh3XIqSo2paW8P6Z/n5auYc0y5zzxkuL/mTT7I2B8uTRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQy5Ul4kzxI379Uc9ZzTf7zGiRYKI80DqMO5kzCwZV4=;
 b=mHZo/oXDspIHQXwlLqz8VQvREIQAsTDjxcrXWjNgY2dz2RYHHVxTKZOAdxmHImAXgppwJ2F+qMxWvKRwXOR2304U3ErqXa1ptg2oe5GraKK5QVnkyWFFTiDqY3jgSHPdj3JTlasKC0yXlUORqA9Zjyk2mnI+kI16zJxzdxcIWjw=
Received: from MN2PR06CA0020.namprd06.prod.outlook.com (2603:10b6:208:23d::25)
 by DM4PR12MB6183.namprd12.prod.outlook.com (2603:10b6:8:a7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.16; Wed, 5 Aug
 2026 06:42:00 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:208:23d:cafe::b) by MN2PR06CA0020.outlook.office365.com
 (2603:10b6:208:23d::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.18 via Frontend Transport; Wed, 5
 Aug 2026 06:42:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Wed, 5 Aug 2026 06:42:00 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 5 Aug
 2026 01:42:00 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 5 Aug
 2026 01:41:59 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 5 Aug 2026 01:41:56 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>
Subject: [PATCH 31/34] drm/amd/display: restore FRL cap on non-destructive
 HDMI link verify
Date: Wed, 5 Aug 2026 14:36:43 +0800
Message-ID: <20260805063937.2145774-32-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260805063937.2145774-1-chiahsuan.chung@amd.com>
References: <20260805063937.2145774-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|DM4PR12MB6183:EE_
X-MS-Office365-Filtering-Correlation-Id: e64875ee-0328-4e74-12bd-08def2bca725
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|23010399003|22082099003|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: DTz7nsCOQL5l7+u1zs+giBE34nkFyk+bWp3LOxSkVTXbCDe2x3J/urU577g9CcPuEEA1CrI3hFHvSckYoJcPCAq1wEGSqosfTLBhOsFQV3CUg21CuGNXjpZ1FZAC8soNaAJNM95qzY/r3pE4ginD6wr/RMMzPaLs+eFrbHSjDbvLTLE0CSyOvYBePg/qmsWGZgjFpN5N0mGE+kYqw1PjtZU/kW1xoHpE35StNR2lh9yqKiqlC5S9q7lXbpdb2Gcvcl2Aqrdx9aXZFVZUnO/JnZ8faboTdgMCnTP7PBVRwZOxMOa1LOvHNSiO7Xtz7m8fFXDDiIxH7AtPuiEhpMtUXi63fJxwhEVq2BiGgy8296Te7okHZB2SdpnQkydEsmobMhzyKZIVuzwUyAPsACtLzQWfPNxle6jqBDm2kMvrfBJnwVME3T0Sur2/Lels+Ohm8AHcT5mm5v844/G1Lu1oLsxwMHNHzZOKVS4cYulWMHzwFah8bKFwW1HufIK0VYCDQr/HbFPbLeUYuM4LklNmq+AEBXJn8bhBzxjrD//kGZNkRWaiHSEB2y16iFd5n9YHlHY3mLdjAxsy/0qx281upsUXP7UqCHR+MFGXdgp2b4xbOsbq6RWulK2bw6rRRD0wqlCbePQXnpOwmQqwLU//Co/Xuhl9/76AQjgYooRxtZc21DJnbkbMPyD2gnf5HRg9nHS0M6HZo006bC0/RV5XIA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0gPf5pf74fT6c0p8i6jF14hoa4bhJm3RGyMzBeG5ru2zB31eFsJ5vppRa5JxJa5BXifT7/J1OzmBWpHYCjrgj9O5qwd5kpgtfB8W39x62gbCYr9zvH69x90YevQ+xyK7s/1EZDzpQky6hUPbge/y1TFpyDfjcCKLQBFLEypxzYjSm99BwX4DyryxqI7j0XCFsj8x79/5MltNjUlZ9ttdSXy/f64w7CfrQW8FzvqHvt9i3al8CgWGNb+VWRoRLUiLKG3w2xZhp11bLd1+9jQZrKQSysv3pG8Vl00xO6k/nfYejK/S/egXczlOPYbNfUpgUj5uN8yi37eE1HUN1wLwdEL/zRVJtOn6Y29BE6PuB5Y3A+h5xAIbVp4ElECndu6VtT6gJkrJxfj6a1lV+bPErBHo+dFrPho4mrMnpHFEhZK0tULZBI+4XrshYrw1varp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 06:42:00.4731 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e64875ee-0328-4e74-12bd-08def2bca725
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6183
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

From: Fangzhi Zuo <jerry.zuo@amd.com>

[Why&How]
Restore the FRL verified cap from the reported cap so a link whose FRL
pre-training was skipped (e.g. skip_frl_pre_training) stays on FRL across
a hotplug instead of falling back to TMDS.

On hotplug the HDMI sink is recreated as SIGNAL_TYPE_HDMI_TYPE_A and
only the destructive verify path promotes it to FRL via
hdmi_frl_verify_link_cap(). When the non-destructive path runs - which is
what the skip_frl_pre_training quirk forces on an already-active link -
the HDMI branch mistakenly assigned the DP verified_link_cap from
reported_link_cap and left frl_verified_link_cap stale. With
frl_link_rate reading back as HDMI_FRL_LINK_RATE_DISABLE, the stream
collapsed to TMDS. Assign frl_verified_link_cap from
frl_reported_link_cap (populated during detection by
hdmi_frl_retrieve_link_cap()) to match the reference DM behavior and keep
the link on FRL.

Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/link/link_detection.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index 22ad6a743038..1384197578ec 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -934,7 +934,7 @@ static void verify_link_capability_non_destructive(struct dc_link *link)
 		else
 			link->verified_link_cap = dp_get_max_link_cap(link);
 	} else if (dc_is_hdmi_signal(link->local_sink->sink_signal)) {
-		link->verified_link_cap = link->reported_link_cap;
+		link->frl_verified_link_cap = link->frl_reported_link_cap;
 
 		if (is_hdmi_frl_in_use(link)) {
 			link->local_sink->sink_signal = SIGNAL_TYPE_HDMI_TYPE_A;
-- 
2.43.0

