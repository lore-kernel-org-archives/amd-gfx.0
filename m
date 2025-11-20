Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72ABDCF9C7B
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Nov 2025 18:19:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18F8510E7B5;
	Thu, 20 Nov 2025 18:19:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="M6CXif2P";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012052.outbound.protection.outlook.com [40.107.209.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3520410E7B5
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Nov 2025 18:19:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mDsmBYcauXfy2QKaI5rP/OPvfCxA4BL4jhgwOZ3TnBpJzxDe1h/2TEb+8lg7feEMvgTZ9YNatQ7wFsl2acKF/uxxgIT0MyaMsrR8THYCZRS1KWF5i+IZh/z0FP6vpuUnTn1LXKCN2Qp2en9xeUf3WYFOU+vtkn9vbzhzSyl1FW01mkaZ05wjKoOZXvR8z6ewrwd4zYukVSx43Z7IWcJEH/SSASvYuzZdOLm4U3/1Wq9wLRyVquskW10BeifueKUCp2Cui6xGWL4vU3cFbl5zVj96883lSTZmtlnhi8kaHfJgPUhx4DIqaxCzxFAEuKShVScpZQk+vcsx01bwnhNuYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fPjOgznEdSaf7PpLEND8FAnkXHO3YVSE47jOywHoaOg=;
 b=bfJlrulvcWgtRT22lRIrv9EGouLG39We6qL+66HlwjXo80G4kN69Wq8zhXY4fCc4/luGnf/VrXJAlW+KIYyHqV22jGPxqwBw+DYzPoUXDz9W77Tewim+cvQEv/1ddxKjiWcJxkKhwjBY13O86cmVyf80BC91J4ShRXS++K4hZLsKo/p082YinfhOd7CEUAwpsxylI0SVjgs+VLjiFtxEomDx/aM3XNK//2LUelKDdVCtq4GAjG7h+Aa4KtEpDJuBD/rUWiBm62JVDRcyG/MOzL4f4KLJazjaZjKhAb0lBOlermfXpHh/V+lk89naRn5SV1bN6SoET2WuNDSakGi4Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fPjOgznEdSaf7PpLEND8FAnkXHO3YVSE47jOywHoaOg=;
 b=M6CXif2PWjEMzoYXGQQQEEfnDTrrnYR0MVGyXhckH+sPpjDNMJrRuB2w4Oc7YWBwlnH0liIdHbIJqV+0Hk7PAHLP6SsADK92WkYzi7vkyLZEARceno38PWnXaxdBbpyz8DE0idyilYpZ7Z7o/+jtAgExNIUXv46JsSave3dwoIw=
Received: from DS2PEPF00004566.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::508) by PH7PR12MB7017.namprd12.prod.outlook.com
 (2603:10b6:510:1b7::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 18:19:37 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:2c:400:0:1003:0:7) by DS2PEPF00004566.outlook.office365.com
 (2603:10b6:f:fc00::508) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.4 via Frontend Transport; Thu,
 20 Nov 2025 18:19:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 18:19:37 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 20 Nov
 2025 10:19:35 -0800
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, "Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH 11/26] drm/amd/display: Improve readability of
 link_detect_sink_signal_type
Date: Thu, 20 Nov 2025 11:03:07 -0700
Message-ID: <20251120181527.317107-12-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251120181527.317107-1-alex.hung@amd.com>
References: <20251120181527.317107-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|PH7PR12MB7017:EE_
X-MS-Office365-Filtering-Correlation-Id: d32817b7-8382-4ab6-7942-08de28615d2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lzn23Mdnn3clLHPygi5tsoAzcOEKGqvIgoXBVQ8qPOmX6FcMcVya2Aw6MZV6?=
 =?us-ascii?Q?zAY1ZV615C1FSyfpun2Plp3zQUx+3CjnJuTAaKNCSKKq/fyei72QBkZng8rO?=
 =?us-ascii?Q?x5ZDQzsoAsrLyDE+3QipfKr6rMtBVVy1bdqCUHVA6Z1RUzWSvxn5O/wLt/9C?=
 =?us-ascii?Q?XwVZe5ZVQtjHkJjZLkTjxUo17eO1bNZ8zQ7Fzqu5sb67UqG+XNCALlaMGDi7?=
 =?us-ascii?Q?ouiheZWT1RnydX1aHQU0gIiQ5Lb/28PDVlxAvEDJ7FZIYxP+SWfwDRUtsC7i?=
 =?us-ascii?Q?AbZ2IpiCGqO/zKx/2orDr5nFP6Wjq9P2JnZzkEHV9zGt2k18nT46uMIvRKGw?=
 =?us-ascii?Q?XJ8QGQ3FPu9X5VNnHUiUMkykN3p98ULDtCaQeYMQ8Ve6flQh2UrCE2zAE5ly?=
 =?us-ascii?Q?zReiidGh3IiH0Ay4z9qDEYU61lcgGxwZEHOZckJKWiiMvSQwvNB74EM3+FMp?=
 =?us-ascii?Q?Q38X3wazZpAOVLufed+Dn83yZrRbvDovkPliqllbmz7Omra9e79osSOX368E?=
 =?us-ascii?Q?01h+WzRN26APQM+59Oxox8dXGjHtgfRD1Jhr0L8y2/AkWrzAbJBHVruOjsOF?=
 =?us-ascii?Q?jRUzk1udLiIFv8IiaRALzDoSTH6YCV2lIOOjFaAjjLCyhQXwcUik7mlVq4qE?=
 =?us-ascii?Q?kcaNedVsRAYU2c+lsCYpdOZ/fnaedmt+k4pwAbnSVWKPlQfusC2SFBnSA1B7?=
 =?us-ascii?Q?al9yywpjOI5sa4lkqL/XwuiFkynKPsoIhltMvQShed4FSMyX8chkNjtFwzbs?=
 =?us-ascii?Q?eOdfs70MnVyUvkb9KFQi7JEKiXk7JwstmJ6pjvc1R22o+hAELIw8Fht3l7uT?=
 =?us-ascii?Q?IUEXcboyXJQ6cjrluanTIGcCAulRPDLVzKB+rQzCV2PsDZTZl9Qkexms+dLp?=
 =?us-ascii?Q?IRqyVSLYga2Fk7hPnGIyI9E2oi0GqbYwTmFp/T9pgu7lwG3qWZ/dNFNh7Xf7?=
 =?us-ascii?Q?nEFalUV14OyqBBR2qPtZELlTrg64JIFcOZON9ESYk6OesMqvl74Vxfc+0smt?=
 =?us-ascii?Q?dLeRlHnSUkUkv+taBr8grKxV3fCngn+uP/HXA2xX3T56PzuW6/ZFkwcttAZu?=
 =?us-ascii?Q?wUcC4miqu65jbj23arWNu/AUQL9AWk1hKC+/EsKONv1Rkxi6umwvMH85CO7O?=
 =?us-ascii?Q?VtKXRaD21P2+9+ZBqh3yJ9mD/VEIsJ5O3o6lVQivZRNAePxtjGVseCL9zqDT?=
 =?us-ascii?Q?lwG0f7j7P4J3kBdgTPC5oJaYpqGGA6y1/BeCT/gIFmNdTj/4+wcjb4VkEQhp?=
 =?us-ascii?Q?vhUMpTHsdtq9GJeiyVbFnC1m87S6DUtV+69vWef0B9pLcooXK5FZoEP6vAUK?=
 =?us-ascii?Q?DVQzbmFQKVBlTkMn0VfcLAqgHM6ONu8/2pm9V5J2uXElsJyglXkukpQtdBu2?=
 =?us-ascii?Q?eFZLEDVEahvRo4gtO3WlQLOwJoWyWLr3jDoDKYweEWMoJqsPPE2suyA8sfyh?=
 =?us-ascii?Q?BFcfa9ZGNqrwq8XxridyYR1iUuiexHWLC9Nv5xDG5sAUoAqQfLPom77Lf5mE?=
 =?us-ascii?Q?g5m2YXg2EI2J262Mh0mYshFbplSxOSxqi6+hVw9vY9Tx/G4IGhsuWH2JV7uJ?=
 =?us-ascii?Q?EwPw8N8GmKGP6d8Z7ho=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 18:19:37.2650 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d32817b7-8382-4ab6-7942-08de28615d2d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7017
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

From: "Mario Limonciello (AMD)" <superm1@kernel.org>

[WHAT]
Move the break statements indentation in for the switch/case block.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/dc/link/link_detection.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index 9746bb2f6c3b..7084b1909445 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -171,6 +171,7 @@ static enum signal_type link_detect_sink_signal_type(struct dc_link *link,
 					 enum dc_detect_reason reason)
 {
 	enum signal_type result;
+	struct audio_support *aud_support;
 	struct graphics_object_id enc_id;
 
 	if (link->is_dig_mapping_flexible)
@@ -201,20 +202,18 @@ static enum signal_type link_detect_sink_signal_type(struct dc_link *link,
 	}
 
 	switch (link->link_id.id) {
-	case CONNECTOR_ID_HDMI_TYPE_A: {
+	case CONNECTOR_ID_HDMI_TYPE_A:
 		/* check audio support:
 		 * if native HDMI is not supported, switch to DVI
 		 */
-		struct audio_support *aud_support =
-					&link->dc->res_pool->audio_support;
+		aud_support = &link->dc->res_pool->audio_support;
 
 		if (!aud_support->hdmi_audio_native)
 			if (link->link_id.id == CONNECTOR_ID_HDMI_TYPE_A)
 				result = SIGNAL_TYPE_DVI_SINGLE_LINK;
-	}
-	break;
+		break;
 	case CONNECTOR_ID_DISPLAY_PORT:
-	case CONNECTOR_ID_USBC: {
+	case CONNECTOR_ID_USBC:
 		/* DP HPD short pulse. Passive DP dongle will not
 		 * have short pulse
 		 */
@@ -226,10 +225,9 @@ static enum signal_type link_detect_sink_signal_type(struct dc_link *link,
 			if (!dm_helpers_is_dp_sink_present(link))
 				result = SIGNAL_TYPE_DVI_SINGLE_LINK;
 		}
-	}
-	break;
+		break;
 	default:
-	break;
+		break;
 	}
 
 	return result;
-- 
2.43.0

