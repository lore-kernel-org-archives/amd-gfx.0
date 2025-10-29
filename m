Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89BF9CCD1BF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 03:11:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30C5210E05A;
	Wed, 29 Oct 2025 03:11:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qoj4IYri";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013070.outbound.protection.outlook.com
 [40.107.201.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23F1989A88
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 03:11:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HrXE2L63GDVIbeyCOhZhXGr8NqmtIWkSWCUMXyHbNREEGv/zrGkWjlpl1Xupchqp8kcNfSMr9C18JnJFOHKhxD+0AvQ0A9gojAa3Q3CyX/mLdT7x5BKHPOStuH8t3/1UfSm6R+m9hzXfiei/B+/8nYdZ5fs9XhUuj8I6OwB/tCA6lln/wGG13yQ5ROxJIHlqWrKMdIJ9oOs/muhdD5ID5OFJ8vBvaAp2MY5WIasjYS7/bX14I+nQniqssS9y0BQrTytTXO1tMkQy1yKUBm8AwJPsQK7LrkSFJiC6OFXXJgmmJPWXvR+yUzT0dSl2NNqxqTB8KGE2/8o7C3wQvRt72Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LZXvVVRBXrhDf2JMNAYtngrcLsijF9wjRF80GEQlBQo=;
 b=Rbhzse7MK1eeAKNkLxFMNgGB3/8pwl9H+K0pUyaJRaHOigpmUhAspdPpcVPQ5Em4dsPO5+pbULWr6qXnE3BMmQaTYstZiDfP9dcssYRMQqIVVIY7VUUsK9sS7odttdIjxUMi7yT9c5IHWZ0fOQQmkybm5jaUaHC8brecCM1qUcwdvUOFevq1LeGtnXp84kBs1k5tgTmEvnfhfTsBtgM7YmyplGvCgYkaXzMMJd36C1GeQJnn1GCguHNxxjVfMb+FQ53kRIRyf1hlRMXyNZKLiqnfty5FCOF39p+4PJknsaNGMF1/+eS2MjJOxxpxzoDVXgPIK63razWqsUcUCE+1mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LZXvVVRBXrhDf2JMNAYtngrcLsijF9wjRF80GEQlBQo=;
 b=qoj4IYriKghzfZqsytjwfbG7cdxqqP2trA6DyFrBYoQ1R/YWyJPE/tunV4+hKtUCP+tGVYylyjmv0d0hYV5YmuuLV9tovp5CPJHDZnsRngIld/ybeGRTFaiKqF+kAxMa3FZxMANGcTVDreQvNLy70rB5Vy2qmd7lkNWse0HbKLs=
Received: from DS7PR05CA0021.namprd05.prod.outlook.com (2603:10b6:5:3b9::26)
 by DS0PR12MB9727.namprd12.prod.outlook.com (2603:10b6:8:226::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Wed, 29 Oct
 2025 03:11:49 +0000
Received: from DS3PEPF000099D3.namprd04.prod.outlook.com
 (2603:10b6:5:3b9:cafe::ee) by DS7PR05CA0021.outlook.office365.com
 (2603:10b6:5:3b9::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Wed,
 29 Oct 2025 03:11:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF000099D3.mail.protection.outlook.com (10.167.17.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 03:11:48 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 28 Oct
 2025 20:11:48 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 28 Oct
 2025 22:11:47 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 28 Oct 2025 20:11:39 -0700
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, =?UTF-8?q?Timur=20Krist=C3=B3f?=
 <timur.kristof@gmail.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 11/13] drm/amd/display: Fix black screen with HDMI outputs
Date: Wed, 29 Oct 2025 11:02:59 +0800
Message-ID: <20251029030935.2785560-12-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251029030935.2785560-1-ray.wu@amd.com>
References: <20251029030935.2785560-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB05.amd.com: ray.wu@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D3:EE_|DS0PR12MB9727:EE_
X-MS-Office365-Filtering-Correlation-Id: 46e6312d-ebb4-45ab-7987-08de1698e65b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Mk5Ha1dkYWwxUG5DNFpITWZzU3RXdzVFdkU2d1YwWlpDQjExejhjVmNCcnhN?=
 =?utf-8?B?NFY2SjFmUGxYb283anphTW5ZVkRFeFZIejAxSElRMmlpSmFuY1FENGFzT0JQ?=
 =?utf-8?B?UTE1ZHU3YWlFYnV4dXkrWW1sb3Q2U3JRWkpVVjVuYlc0WSt4RVNsWC9rMEFV?=
 =?utf-8?B?dkNwUUU2aHZ4dEV2QXU1a0Zkb1N3dVRva29xcG4rNW9qTGZTWC82aGpjTjgy?=
 =?utf-8?B?cUQ3QVNUNzg2NFdXVFlFT3JzVGNZL2RPalV5L2Q4enNkbUl6QTJtZE8xeWdh?=
 =?utf-8?B?YUEvOE1hZnlWT0ZrNDhTSzd5MWVURkoyT0ZxNVd4ZG0rS2UvWStuZVNCbnEx?=
 =?utf-8?B?UE40TitvakdkMzMwV25CRnZPQWhKOWd6d0JhL09OR2taTWt4Q0c4QlV5NmhK?=
 =?utf-8?B?bng4ZXB4aHpLUWdDYy9lR0Q3Wlg3K0hsTDdsc1p3N3VpY2RBSmJTZWFTNjVt?=
 =?utf-8?B?RFlNckRmVkF0cCs3RUlJdmlJMVlIVnVPY0NBR0Rrcnh5RTJjNjNqRFI4Slpx?=
 =?utf-8?B?MWR4dm5DUjdTTUZaK3F5OW8zOW8yMm9oY1RCNElCV1pzVU1BSUh6QjU5WTg2?=
 =?utf-8?B?U2lneXBjWkpHb3N6U0drV3IrWUNlcDVMandEZTV4L3c4THFsVkQzUnRoSVJY?=
 =?utf-8?B?NU1WWVU3Zmk0MlVrR3htUHZHR05RQzROcEFuZjBJWXl1MFVqaHhSR09GWi9F?=
 =?utf-8?B?RitIU29hcUdTaW1wekV4ckJUNDRRdmw1Ylh2RkppZ1d4K1E2UEE0cGhUcVBm?=
 =?utf-8?B?V3NUT3kvQ1hiQjltR1cveWdtdkRXRTd0VndjNXQvUTdOT3FIRmw2R28yM0dV?=
 =?utf-8?B?R3pBRW1IQWlVZUhsNjZYNitubWhLZk9INW9xUXF2VDFESnpVM1Fad1REYUFy?=
 =?utf-8?B?R0lqdVFwVWpEZlAwaGZ0MFFPTGIxcGJ3clpKR1JaenE2YnBNQnFQRUk5VnFC?=
 =?utf-8?B?K2FTTEx4VENiU1FCTWJJM2dJM2hKdzkvTFhObFlTOUo0d3ZKSUNEa0FiYnpy?=
 =?utf-8?B?YVc0SFFmMmNnc2JwaHdoam1HWFEzNG1OV3pxU0VnazlVSjVYQ2JDdFJ5eXV1?=
 =?utf-8?B?dDRWL09vU3g0RkQrMFdIQ1g3clFOUEN3dHR1MFUxR3FlOG5pNnV1K1h3NG4w?=
 =?utf-8?B?VlFxUWZqVytYek1VR0NoYUMxajF0bFhkMHh2RkpQMFA2S3BrekRYbEg0clhp?=
 =?utf-8?B?S1V6alUyQU9POVBTK0lMN3BjY01rakdCTFh6MEVzUGhKQ1ordHlYeHdBOUpF?=
 =?utf-8?B?Qi96N29YVGhQeWlzb21WYlFXNDBSU1FkUlY0UjJVZVVSVUU4dkYyUUt4SlE2?=
 =?utf-8?B?eEdBLy9hK0lkcFA2aU9oUlUwWHp4dnB4bW8wL1lFWHNLUHdCQ0JhNFo5V1lK?=
 =?utf-8?B?d0lMLzliMmpIcFlmY0JQa0NZU0hKd0JQRjg5b3VUZllxU2IrL0h2MTFRVFNo?=
 =?utf-8?B?aSt5ZnJtYUhKSElUYklwMjF1Q3U3UGhwVjBmdjFQQ2xXdUc0RlZJaDBERERP?=
 =?utf-8?B?OHFRdmx6L1hReFM3VC9xeVhrTkRGWXg2OHh3NlcranF0ZW16MXlTMGV4RWl0?=
 =?utf-8?B?ZFR6UHBXR05mNkdlb05kMjVaSHRkVzZLNzBvUW4rNU1UVmZpbitrWFdmMVMz?=
 =?utf-8?B?Tzd6c1ZGbzVUajEyMEx0N00vK0hSbHpIV0gzMnkvRm9FbjVuU3VXN2Uyckdx?=
 =?utf-8?B?eDcrU1FnNHhYV0crTmE2aW55Zi8rdUtMVzRjRzdNcnVMZWRHdUU1RWlBRjVn?=
 =?utf-8?B?b0tVTGNIU1V4OEtnTEh2TkVtRDcxaGFTcytUVXpwdXlPWHN2eENvK3V3VTQr?=
 =?utf-8?B?dEF0MVFxcERwMmRRWVB6T0FLRnVmWFRhektRTm9GVUxEMVlLUkM4WHQ2K3Zq?=
 =?utf-8?B?ckQ2YzQ2c2s2NWhmQ0daT1VUOHRJZFJ4L3djc3FGSStweGFIOHd6cmpaTG95?=
 =?utf-8?B?V0t0N1cwUk1neTBxQVdSZGM5TmhuVGVxNWNZdUdKcDBxODd1RzltNUFBVVFv?=
 =?utf-8?B?c1YxQ2VHcGJRY0FGSGtxZGlXQnVJWHpwNUo4VFFQcmQxYnhXTS9uYWdzdHFl?=
 =?utf-8?B?WnpYZk5hWVJTTEExZWJQcm5IcXl1akdVZ1hOMnZXcUJlN2Fodzh1SHNLQWJz?=
 =?utf-8?Q?NtFc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 03:11:48.8009 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46e6312d-ebb4-45ab-7987-08de1698e65b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9727
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

From: Alex Hung <alex.hung@amd.com>

[Why & How]
This fixes the black screen issue on certain APUs with HDMI,
accompanied by the following messages:

amdgpu 0000:c4:00.0: amdgpu: [drm] Failed to setup vendor info
                     frame on connector DP-1: -22
amdgpu 0000:c4:00.0: [drm] Cannot find any crtc or sizes [drm]
                     Cannot find any crtc or sizes

Fixes: 99ff9bc57b02 ("drm/amd/display: Fix DVI-D/HDMI adapters")
Suggested-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/link/link_detection.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index c417780f37bc..e8566a5218fc 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -1252,11 +1252,16 @@ static bool detect_link_and_local_sink(struct dc_link *link,
 			sink->edid_caps.analog)
 			sink->sink_signal = SIGNAL_TYPE_RGB;
 
+		if (sink->sink_signal != link->connector_signal)
+			DC_LOG_WARNING("sink_signal (%d) does not match connector_signal (%d)\n",
+					sink->sink_signal, link->connector_signal);
+
 		/* HDMI-DVI Dongle */
 		if (sink->sink_signal == SIGNAL_TYPE_HDMI_TYPE_A &&
 		    !sink->edid_caps.edid_hdmi)
 			sink->sink_signal = SIGNAL_TYPE_DVI_SINGLE_LINK;
 		else if (dc_is_dvi_signal(sink->sink_signal) &&
+			 dc_is_dvi_signal(link->connector_signal) &&
 			 aud_support->hdmi_audio_native &&
 			 sink->edid_caps.edid_hdmi)
 			sink->sink_signal = SIGNAL_TYPE_HDMI_TYPE_A;
-- 
2.43.0

