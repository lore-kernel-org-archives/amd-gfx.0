Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B88F5D5CCAC
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 09:58:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E0D110E6BE;
	Tue, 16 Dec 2025 09:58:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nKUdRO2v";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010004.outbound.protection.outlook.com [52.101.46.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9E0210E6BE
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 09:58:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P1e221Dn2SG7NuWEAzdMdt6nDoBIJ6yTCf7zFCLo4RAuQ/9adKxVARjzqVpTJtzIQzzPvGZBv5Si81KPIPGgfbUVjJ/W33rBCt2rgy4V5L7s5ly0xUAODx5uVTZumUVT7GCRk6PlRPN1xs5JPF3rHjpox+XNRSgPeYYvgzTxoodL6aSUUp/2sIj6hIaUHWvxyArlfzK8FtzE5DF6ytP1+LqtPmZ4AaisSveG0oOBC+6sqJrczJOl8QQlC8n/lsLXcDAC4Oive/WXSGQG2xR3Kx/FyRneRxiIUj7x0pEQWPo2viSNOhLXVtrbdMxrH4CDKQ7i1vS82dheOCCW3P995Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KhCB1+C9geta44B1zhkfO8bV6vfaOgxZPauurrFLi3s=;
 b=FCyWTe8EBBxlM3AFbl/cPHrgdwwP9dRXhWkHrciubOAdtWJZvmchNyOWgEyHYMXSrcoTa67CJSfkPs4qL+jayH006JcQ/uD1zGD+Wc5l6zy45gK2CnPUoPFQTeFUtvhD1qaCUnFrhFbJxPhA6DR4nN/5MzzG7jLK/BD3vtLHei0P2R2iJB1JtWXuzCOMjhxidk2y/yDOJHWE6WigvwryAjkhKxS3u+Ew1HvCbJHcrC/nnC6slU3YXKIhkf4d2djxXonZyKYlSrB9B/tfrcUqD+QgkYsUm6gNwzt9+49uUdZQYItIE30+q3mQ/VBAfkAAmXnxUDhH7XXn5Fqog5cojA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KhCB1+C9geta44B1zhkfO8bV6vfaOgxZPauurrFLi3s=;
 b=nKUdRO2vCQgxRgDHmv10DAs5LSemZckGcVCuRwtGhc+/z/xHl8Y3D72rmyNZoNJl8ZPBPKutVgFJboBYyeog1hVivLT+px1M+HIAMXwyYVNpvRkfZ8TCpGVec3f2aZYJ0wTrfIpJknIFt16aFzh8+wVfJ/qQoR8xutGITVkDC0E=
Received: from CH0PR03CA0365.namprd03.prod.outlook.com (2603:10b6:610:119::13)
 by CH1PPFF5B95D789.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::62a) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Tue, 16 Dec
 2025 09:58:18 +0000
Received: from CH3PEPF00000014.namprd21.prod.outlook.com
 (2603:10b6:610:119:cafe::c2) by CH0PR03CA0365.outlook.office365.com
 (2603:10b6:610:119::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Tue,
 16 Dec 2025 09:58:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF00000014.mail.protection.outlook.com (10.167.244.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.0 via Frontend Transport; Tue, 16 Dec 2025 09:58:17 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 16 Dec
 2025 03:58:17 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 16 Dec
 2025 03:58:16 -0600
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 16 Dec 2025 01:58:14 -0800
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 13/16] drm/amd/display: Update dc_connection_dac_load to
 dc_connection_analog_load
Date: Tue, 16 Dec 2025 17:56:13 +0800
Message-ID: <20251216095723.39018-14-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251216095723.39018-1-chen-yu.chen@amd.com>
References: <20251216095723.39018-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: chen-yu.chen@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000014:EE_|CH1PPFF5B95D789:EE_
X-MS-Office365-Filtering-Correlation-Id: b76e3160-902b-4620-63fb-08de3c89a30b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xNtDYlk487MYoXDV9qqOSB6zDjurL48BRc43A4jF9FRegi2vz6ARKDXEycG1?=
 =?us-ascii?Q?koBqK6p0jQ4Hs+9jdTuKsb7TKUjnPUbLsHbEi+ZBOE2zTmFd1/C6jaqEJ870?=
 =?us-ascii?Q?ZOmCADsQ/NfztrhmRBJvLkY/MhYr7l3BD477kg5r/V1ce+K24G0ukTZox6NC?=
 =?us-ascii?Q?XSQ0ZPWmjtDZHSk18UdLyBZs7n3piBqHjvr3nVFolRsDJEdDlCW+nU2dg0m/?=
 =?us-ascii?Q?ifTbRgQAtxzhDywkEyf3NOBhYEKHVBe1hQmsBWzp6lVNYIKkAjb2U0HpR9cx?=
 =?us-ascii?Q?ssk2a7sySGGRt2rEbyav+UHWFG4FfBvtQwO5eRYp2U0h4vWiMSOJi74D1XT1?=
 =?us-ascii?Q?ftJJojlGoT8BN9PrivfCxppEmXIG3q6XaAedXbK9yTPQVwSDk2P2ZCX1EaXS?=
 =?us-ascii?Q?u5RXtOW4k49jVtMLuC7oeHjhpBQykt7mso4W3NusJt/zEtQXy4BjAaxjW2Uw?=
 =?us-ascii?Q?Cx02nSbW/Y5CNuils1ZFY8f0UyioMm/+N/FxQaQDlaeR18UK/u0FsZ0htcEN?=
 =?us-ascii?Q?haV9dgvA6Kcg66hIhUEaq7SrLv2QxfV98UdH38Bys8KesoyG2fp0m6OIG3+A?=
 =?us-ascii?Q?U5JkkKPW5xHMJ51rUx4a18K7uIMNvq106agWeKH/SwY1bxjWjvbWSFtTvrAE?=
 =?us-ascii?Q?xslTAZCyEs5y5fQJQU0J/1S0gpVKrapKWfKmHQwzUV+hwD2cmVBdtRaMUpgB?=
 =?us-ascii?Q?9VnzX2Oh7i9x98CMzP+wBVvIZ70BPNU2o6CJeg2UN0ZYiG5etAhKCXzgDD5A?=
 =?us-ascii?Q?7Uo0d/xwD86LC+jpqa0E6Q5UoXEwFj9XkeTcSDftcKtZqPVvChnkdBQamGeS?=
 =?us-ascii?Q?V2UFzEEqRMTDYZ0faCdKnUWmXBya2kzTrY21Jku2fcA1OfSzdmZU8MyoYOh1?=
 =?us-ascii?Q?bVdUmL67koBZEZk0XKTylJgkyM4tvM2LIi88FsIQFMFUX+e6ileAhXHa47un?=
 =?us-ascii?Q?tc/SCMwS5EDdYpFTT7U8vEGa1pBvhFGmRiQp3kqvGcrc+Qzh8tr76EGFkali?=
 =?us-ascii?Q?a329yB6WiT2bfkTsQCvPtxz8CZG75OejiMzbmyzaaeGD/RKg/emBAulyvBdf?=
 =?us-ascii?Q?BWDnJAFosZ3MS1JeYtJGfLEoBOvjYsx26FZRuQknnL/UdZCPqKYJI4eM7mNg?=
 =?us-ascii?Q?fJHlzWU9W8gh4zR2qIAoorJUohCHES21b+ccoAhrujBib55iUCoyRW8N15lk?=
 =?us-ascii?Q?iZvZpdcFvwX2chWV9zpIQ0TW/PrXqEO+9F8+6oobQ1wegh8jKIuDwukXSd8E?=
 =?us-ascii?Q?ChKq6jjXbySWUkcxuVhgkGK2QzBnw2Mh+uxXf6z8OfJGosGzmHN0F73CyRfn?=
 =?us-ascii?Q?pe70CQpQFDMOynt9tt9Woc9y6kI1JQEq6syOa73GwbAMaCErROD/q7eKkTUF?=
 =?us-ascii?Q?wc28vHVrEMNWSiarZVD2KzU4zJ2kSatTZ9QibJsOirkR0Q4hlYjrVEGAKDDh?=
 =?us-ascii?Q?FkAi/MWiKGu6IMaWaGspRjRqswqOQGTJFpT5uq03BLDeHlmggvZ9q09ohOzh?=
 =?us-ascii?Q?QJDaA6m6/eqBSMw/fnEAm/MJdHJ0PNQ3omz+LduFSq0tErVn94WEbAgIrJSO?=
 =?us-ascii?Q?bz7QOf4VzilsAdpl0tc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 09:58:17.6492 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b76e3160-902b-4620-63fb-08de3c89a30b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000014.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFF5B95D789
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

Update to a more accurate name dc_connection_analog_load.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    | 2 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h            | 2 +-
 drivers/gpu/drm/amd/display/dc/link/link_detection.c | 8 ++++----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index d66854e7f18f..0c88175e1a22 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7403,7 +7403,7 @@ amdgpu_dm_connector_poll(struct amdgpu_dm_connector *aconnector, bool force)
 	 *
 	 * Only allow to poll such a connector again when forcing.
 	 */
-	if (!force && link->local_sink && link->type == dc_connection_dac_load)
+	if (!force && link->local_sink && link->type == dc_connection_analog_load)
 		return connector->status;
 
 	mutex_lock(&aconnector->hpd_lock);
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 3e924ee0811d..b3b785f1897d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -355,7 +355,7 @@ enum dc_connection_type {
 	dc_connection_single,
 	dc_connection_mst_branch,
 	dc_connection_sst_branch,
-	dc_connection_dac_load
+	dc_connection_analog_load
 };
 
 struct dc_csc_adjustments {
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index bfb5c1c886a5..af1b456ac94e 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -1174,7 +1174,7 @@ static bool detect_link_and_local_sink(struct dc_link *link,
 				/* If we didn't do DAC load detection yet, do it now
 				 * to verify there really is a display connected.
 				 */
-				if (link->type != dc_connection_dac_load &&
+				if (link->type != dc_connection_analog_load &&
 					!link_detect_dac_load_detect(link)) {
 					if (prev_sink)
 						dc_sink_release(prev_sink);
@@ -1183,7 +1183,7 @@ static bool detect_link_and_local_sink(struct dc_link *link,
 				}
 
 				DC_LOG_INFO("%s detected analog display without EDID\n", __func__);
-				link->type = dc_connection_dac_load;
+				link->type = dc_connection_analog_load;
 				sink->edid_caps.analog = true;
 				break;
 			}
@@ -1370,7 +1370,7 @@ static bool detect_link_and_local_sink(struct dc_link *link,
  * @link: DC link to evaluate (must support analog signalling).
  * @type: Updated with the detected connection type:
  *        dc_connection_single (analog via DDC),
- *        dc_connection_dac_load (via load-detect),
+ *        dc_connection_analog_load (via load-detect),
  *        or dc_connection_none.
  *
  * Return: true if detection completed.
@@ -1386,7 +1386,7 @@ static bool link_detect_connection_type_analog(struct dc_link *link, enum dc_con
 	}
 
 	if (link_detect_dac_load_detect(link)) {
-		*type = dc_connection_dac_load;
+		*type = dc_connection_analog_load;
 		return true;
 	}
 
-- 
2.43.0

