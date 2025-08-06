Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D00BC87FD1
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Aug 2025 03:02:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A53E410E2D9;
	Wed,  6 Aug 2025 03:02:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="htzSfOie";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8534910E2D9
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Aug 2025 03:02:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G0Qe+WyF//VModhFqxem7smRxh0KVYJfHIgsK9R6o1VQZhhGIv70DFbah7GldQoZAaqo3yC0LGDw4JlRsfP21MMgXUEbfjg0nt3peNSYrHGSkU29khivKq+hJ7Z8gHDp6XZrGLFtvdm2TQDm2oCAox85ZfaobrLgxXFPjYdNwwVXFSreySqujTUHjKUK4AYFJXllAGaR4+irdTtZf6l+WBZu7OHi4TudDRggQ07hZhnaqKJAJm3KnhEPO+623t4TKNmtwD3CdE54HZtaY/39UuxZTjuPLgTSK2i9ONGrlYAVCoGcYBW8fejtaePvqK/BfWtMngd6vk8dJO17fbE1Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eZt8g3ZUKC606hiLxrtFbJGveVvNlxNIglta+sioPn0=;
 b=fAi7qkewUG5Qn9icMfJQ9ePQTNudkD4IhUMLU0moTNP6i4zOk3yN6SM+Ur9QsGZOGIX529G7V9UJVaDtff2RIYViZ0rsQ7llV43ZzcKTqg7zY15M94LxiqvgEkwlu1/CEhhMkUvrz5yjYXNs+b9ytF2ALUVy9q7H8Se+L6704J8fFAl/tys3U2njNOJ4Ebb4XQsj+eewKmYJIWebogB+oJGH3chw7h+R3bTUfWbBmAmOhqvgImgZ9IyMt6eXwc9qEuVIXpmieL48gGSRaXwwQUSdRpipAXGf5afMWBYAAzLh8GN3rsaFE8hP5Nk0aA65eTVKCvZgTCbb+PrDuDHPgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZt8g3ZUKC606hiLxrtFbJGveVvNlxNIglta+sioPn0=;
 b=htzSfOiexV3DF9bMdropbD7/IDNBO3Yy6hwdmj+PUF25HiJiWEgLNeeSQ/umLEJ43kU0C92A8IIuvUt1sZHkBfdrpj5uS7IcfwQ16avsN35NUGVjRWoJoXaXExHBhEVzsfINO6aG8tzUwhCUn/CuqjE/iFWHlzceKSu/5yzD+fY=
Received: from BL1PR13CA0293.namprd13.prod.outlook.com (2603:10b6:208:2bc::28)
 by LV8PR12MB9643.namprd12.prod.outlook.com (2603:10b6:408:297::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 6 Aug
 2025 03:02:46 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:208:2bc:cafe::1c) by BL1PR13CA0293.outlook.office365.com
 (2603:10b6:208:2bc::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.14 via Frontend Transport; Wed,
 6 Aug 2025 03:02:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Wed, 6 Aug 2025 03:02:45 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Aug
 2025 22:02:45 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 5 Aug 2025 22:02:42 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Danny Wang <Danny.Wang@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>
Subject: [PATCH 2/4] drm/amd/display: Reset apply_eamless_boot_optimization
 when dpms_off
Date: Wed, 6 Aug 2025 10:57:11 +0800
Message-ID: <20250806030216.21096-3-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250806030216.21096-1-chiahsuan.chung@amd.com>
References: <20250806030216.21096-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|LV8PR12MB9643:EE_
X-MS-Office365-Filtering-Correlation-Id: 70eb5de7-7e4d-4b92-53c6-08ddd495b7e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aUFIaXUxMWRucUNzQ3VRTkhxd0h5U3JRbnF2WjlxNm84Z2lFY0l4Qm1HdG04?=
 =?utf-8?B?aVNGeUJZVS9VSDNYYUN1YXUvN2h2TDByd3FQWmIxak0wMTN2SUhNc1ozV3N4?=
 =?utf-8?B?cDJtUjRWN2VwNDhxbzQrY3dxNW1JRHlDWHZRRUJRT0diL0F1alEwVXZtS21J?=
 =?utf-8?B?NVhtRDBZeU9lSU00aDR6Zy9kZG9peXlPSDc4WjVtalJweUxhUjRpekdROFhE?=
 =?utf-8?B?Z2lnMjRNb0tJL0lkMUJWMm1IUTNZR1NLdHI5TmR3Q25pUWh1T3BrTy9qN0Ju?=
 =?utf-8?B?alFWb1Q5czhpOGNGcGJHM0lVZVNTazlQVFoxWkcyZHV4OFRTNTVZeDRhRG8v?=
 =?utf-8?B?L0E1aHI4NWNWT3lOMExPZkNTUzk0dGp2eDU5YytXZzZKYnJFRWxhaFNFRVYx?=
 =?utf-8?B?SDlJVnF6cWg4MW5RRkdyek9DTzJRK0p2UExTVys2Mkd0eDFKbEQ2bXhlQXRr?=
 =?utf-8?B?akZVZmM1REV2UzZUd0hZUG5Hc1VKOEdDM3RUcnA0b2pRQlV4Wkl2TGRaa2Z6?=
 =?utf-8?B?UkZCZnh1ZW9tN1FvQ0NjSmJ5c25OVXBqVkJDdkFma0tlSldKTWg1aGxYUTNN?=
 =?utf-8?B?ZzBPUVRoMENQWUxjdDZLQUp0UG8yTXhHMkhIR25IZFVMdDMxRTI5blFwZGU4?=
 =?utf-8?B?VENCVDlxOWRIK2s5TjJkaTdBTGw4YlQvTFB5blUzdnY5cnU4QlRQdjZ0Umtj?=
 =?utf-8?B?b3djR2VNcW5HeVRkK2MyL0ZyU3NtdUMxUHV4Rll0dDQzT2hFOGo2dWJsVkpI?=
 =?utf-8?B?QVdRRVpwU2VXTnBPY2EvZDJMSG9vZjlDOFNRS3RuaitVQm1HZG9sWHJmVXQw?=
 =?utf-8?B?VlRCRzVmb2JXN0Y0WEVKTGkvTkJJQTVWYUgwSHFtR05SQkRiYXQySUFLWVJL?=
 =?utf-8?B?VWxqMkFUK3JVbDcyUnVrb3l3dFpwc3laQmlCckVMSVVTT0p4K3JJbGVwbDFX?=
 =?utf-8?B?bWV6RUp6THFzSWk2b2taRDdvcW8rWG90ODYzQU1BV3RtbmtKYUt1RmROai84?=
 =?utf-8?B?T3VvWXFXS2xDaEl2MkFQOGZHa2U4NUdVSE5Kc3Z2L1I0Rk9ZWFlsVUx0aVFW?=
 =?utf-8?B?L3NUZHZtd1B4dHhOelQ3ZE01UE1nTGc5R1hOMlFtV1N6d1JSZVRFck9HeHJp?=
 =?utf-8?B?QkNET0RjMDdyRDB1SE1ycnlqak54UGZZM2pKMnpjSmM2Smd5NkwvZEgydmZP?=
 =?utf-8?B?YXdCYllwY2NhLzlna0pZWWFBZkY3c1hVWDBVbFkrckJWL2Vyci9nSEtONmwr?=
 =?utf-8?B?S0RUNjkzeituOWo1L25zaXZRNmhjWnVwZk1mbnExUEo4UXlnaUFKOG0xM1gr?=
 =?utf-8?B?TVFFOUlCaFBibmlwSjgyMzRIQTRaMnEyNGtrcTVibldUSlNtWmZYaStpRXdu?=
 =?utf-8?B?NnRoQXJ2WGQvREJIc3Z5RkxyZG50Z0ZleC9JQzJORWZXTmM2K3dLbE01dDl0?=
 =?utf-8?B?bnZoeDZOaTdrb01VZG1iWUpLTzd5SDJncndOWE1tY2d6enhocWxyZ0JmUW9G?=
 =?utf-8?B?YlB6YzJZY0I0Mk9mMUgxSVJ6MXQyZmtTMVVkQ05NM3hEcExhR0J2RlJRSlZr?=
 =?utf-8?B?ODJvZEw5YTBCcjJ5dHBJS3l4YVUxaGw3U1EzSm1ZTG1YeHJmclBqWVJZNFRM?=
 =?utf-8?B?NkdmMFdON3lWVW1mV1BaVTBCVFlPWkl4RnFLckZnOVYrYUNSSnBET3RFSG15?=
 =?utf-8?B?MnlrU3l2LzZqNWxvb0RRVGdwK3gyY1VBbzFTRXd2b0xlZXlEbk55ZFdqNWxZ?=
 =?utf-8?B?TkhDNkVtb2tvblplNGZYVW43SENEaWFzQzhkSnlIRDV4USt2ekRuMGVrakJG?=
 =?utf-8?B?QnNxVEZNdmJEVFVoTktXM25zY2J2ZDdNNzVIaEQveEpFczBIZ241KzIvSWlu?=
 =?utf-8?B?NWlSOTVYcUdoVGhOdHNNN1Zka0VZaVhKMG1CTnhJNGxDNlVpcUl1RTUxT0VF?=
 =?utf-8?B?cVBIU2ExTS9icGNQdnd1VHpZSS9CeSs3dDNaKzNWYjRjZ2lUbnVGbUhWYm5C?=
 =?utf-8?B?d3l6Y2trK3Z4bzRyM0MvWll1WkFvYmpvclJJcjZ3a0lQOTZMSTV5eFd2VTVU?=
 =?utf-8?Q?SaOGkF?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 03:02:45.6458 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70eb5de7-7e4d-4b92-53c6-08ddd495b7e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9643
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

From: Danny Wang <Danny.Wang@amd.com>

[WHY&HOW]
The user closed the lid while the system was powering on and opened it
again before the “apply_seamless_boot_optimization” was set to false,
resulting in the eDP remaining blank.
Reset the “apply_seamless_boot_optimization” to false when dpms off.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Danny Wang <Danny.Wang@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 242bcb30dd34..5bf97d8fb34a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3391,7 +3391,7 @@ static void update_seamless_boot_flags(struct dc *dc,
 		int surface_count,
 		struct dc_stream_state *stream)
 {
-	if (get_seamless_boot_stream_count(context) > 0 && surface_count > 0) {
+	if (get_seamless_boot_stream_count(context) > 0 && (surface_count > 0 || stream->dpms_off)) {
 		/* Optimize seamless boot flag keeps clocks and watermarks high until
 		 * first flip. After first flip, optimization is required to lower
 		 * bandwidth. Important to note that it is expected UEFI will
-- 
2.43.0

