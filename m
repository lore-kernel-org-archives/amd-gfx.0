Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D78EC021B2
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2025 06:37:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B3F410E552;
	Tue, 25 Feb 2025 06:37:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dh9LjH4z";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2086.outbound.protection.outlook.com [40.107.102.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D24C10E552
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2025 06:37:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VxKYUT8OjR0tcP1ti0P9SSDgaXaxS1A7iZ4vFSfYO0+kTGv2Tt3B6aqO6ImawJkNGOz6mp7bH5QoOYw/LggJUclKQQL3xz1ltNy8/JU9gqy16ccQTplikKQJ6/vXO+D8uGAvW1yudPNQ25gxacDzlJNrd77db9WKmeBebqgt+efXil9nHA28X+xIIkNzE1YEyurykI57GaBZvzM99qztOA/cslFA0lYgDRz3kZKDQim1867BuYklFfRZZijoxzfKAg4omw5PPj2WvibhruDLs++0RpumR4I4F+tl9Sn6ITvR43BL8B5HrZWzxWY/xWEwA1gK6zy3jzFShyxX0XtGgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t8sC9nzWh56NY205NCUiMQkt/l4BMp7bRRbb50ItPck=;
 b=u16TxSkPAkosDLMQgcHBHIMQRWAYxsBrMttMtf/aonW+1WHh/mlk+zgrZGzgmkfbBALoz1qUd9CiGqiK+Pp9ijf0ASdN/qfDreEa619yuaMpCyx3spTj7wxG/N9lXPbk3AKO/tVxuJXfGpQa1eX3ztdOMuC4EEL5V75hgVP0bed57Py2b4UHx/PbWHyqmmppY4rU9kY3cPDpqU1PMZk2Tx823u88snd34en7cM67n1JvJVeexr+lLKewZ4FQpzZ0yYHIzibSUPSAHm5fYw2NVOjqMHdEjEGhuzMM4L1SX6ZJHVRN4xp1UwIgDCSaVx4EQ0MibxKde8mjmwMCk+OlnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t8sC9nzWh56NY205NCUiMQkt/l4BMp7bRRbb50ItPck=;
 b=dh9LjH4z55S8ZpRoeUHieu6QDlDsCjM5aitlBBojuznFtl/YZcdqNL2N9bQ/cw9IJoTP7WB/fSOYsMJdMgXo61K8tNtC+jA7/iy8B2DGnPzHOb4Bifzs309Y/R9UffEBesYUvklq92/b8ooB0BEzh7n8SObK9RLn/Wl81mJdLx0=
Received: from BN9PR03CA0541.namprd03.prod.outlook.com (2603:10b6:408:138::6)
 by IA0PR12MB8862.namprd12.prod.outlook.com (2603:10b6:208:48e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Tue, 25 Feb
 2025 06:37:11 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:138:cafe::35) by BN9PR03CA0541.outlook.office365.com
 (2603:10b6:408:138::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.21 via Frontend Transport; Tue,
 25 Feb 2025 06:37:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 06:37:11 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 00:37:10 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 25 Feb 2025 00:37:06 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 08/27] drm/amd/display: Check NULL connector before it is used
Date: Tue, 25 Feb 2025 14:35:51 +0800
Message-ID: <20250225063610.631461-9-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20250225063610.631461-1-Wayne.Lin@amd.com>
References: <20250225063610.631461-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|IA0PR12MB8862:EE_
X-MS-Office365-Filtering-Correlation-Id: 098dc842-2f03-4a0f-ac44-08dd5566d558
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AcCdTHCgu3zh/ZiUXUf/RrjmzndVnOhi2xXVwr/AeTPlrUdQSGA2h6t3ZYAQ?=
 =?us-ascii?Q?/6wuh664YfC6IkCaYe6twoFcEY34w4AyON/HCWwCGmFZCWu8cBiPQ2hioNRU?=
 =?us-ascii?Q?UyXwt+CqPKkwW0Lra6vxbxhFjnJ4HZ1IYgfA5dQM5LR0IXjbbgDX1L7uiQFT?=
 =?us-ascii?Q?D8a0YiUAthOnS2fs095a6WkHs1rOJ0w2hIU+5825RaW0XpxvSlu3qY+63jst?=
 =?us-ascii?Q?JU6ZeT/LBXvwr5oIMN2WVkhJeC6mfO0qj+OYTB/XTR+jBr8qvpqMKdYF/xXv?=
 =?us-ascii?Q?OqFy9SvmNVwzxVKk/DtR2av7hj/GxxNtu6T6YKSq+KzdI2O2Xx/0VyIt+ec/?=
 =?us-ascii?Q?UULdcOtzeDomiIQyh9YqWn9hAEtM/YPQzhNR7rzjYpGiwknTakpkaasLd4X0?=
 =?us-ascii?Q?rlDZFXt8SEWwB2NY6DN7g01eoJaDdqARFMy2T6FxF5paxhXpjlNCLzM5tgDD?=
 =?us-ascii?Q?BrANfTN9U0ezfZPbxwXPIWutrSXuXMji65tr6pSzSxif3rZJPOAGecolOUM1?=
 =?us-ascii?Q?OJUFbfMOft6/QiVLhzEn73rhF8XEI8+L5wyAQvEN6bPexEYiGW7hO9foGJxJ?=
 =?us-ascii?Q?zZb++v3gvQyvzT8ON4+tioVYxlKkM8MzCcBvZgj8jrwdkqNA5kDObUtxi2Nr?=
 =?us-ascii?Q?j7WWvN2vnwtp7E8NWLsEkW5E/ABnVhYI7yoEKvnUYDgxE1m7Ve6QlWQJ5BKm?=
 =?us-ascii?Q?9+c1O7C6Pf5orPCjEjD0kxpRU8+lkynDFzxrBNFU2KxvDstH4xwVTGtOysX3?=
 =?us-ascii?Q?cD9Zk50AiOcQXmN2O1tfUR+wyQvifin4JcM8xf8ScYfAN5GfdiF0jhgIUQMS?=
 =?us-ascii?Q?+2dWa/rver9DrSQ5IGRd9oPyy6vXLwwspkPb85+wnlFwtFdfCyGwHGck1izK?=
 =?us-ascii?Q?nQrJvdl2+Q7fIXOehZteRmtBmlZceE+wI1mzACXnY8Qzzv9a7cpWgcYu7qvC?=
 =?us-ascii?Q?Y3KMN0MwA7ZMUEUhcFh1nLh1FYeCqXLNWYuXjr/R5wBw46qCQ8kMhpq7HPj0?=
 =?us-ascii?Q?4G/u5svmnf5DeR+cVr8SUo2aw/n/uUTS7fsTgv76vMjArV4tafCy9eems9eP?=
 =?us-ascii?Q?bBr2M6gWQzXOx8OQRXDxmOU0dDWGPK5Nu1wz5iRyAREOqWk3q/U5ph0oSPbf?=
 =?us-ascii?Q?JGert+yXvuDEx9P2YxpxP3acHD4zyOWlAfHgHCHpkJsBo8MDwKkEtgaKrY2h?=
 =?us-ascii?Q?WJRPwiAXKap72UpVqYHVUceGZNn2J8FjMmuhU+t2MNsAw4rWs434LnLL9p0p?=
 =?us-ascii?Q?eWL7N3NGTwyPGCZYqhcJo8CFJ4WfJYP7yEtbZCiy510wdohbzLAQO/7QCl3k?=
 =?us-ascii?Q?hFR2oQ6477dZfMFtTP0sqO9dy0BT/d9QkxkFk9qVhMISMzQjgsc0/nNpJMjR?=
 =?us-ascii?Q?oDZPY14fksFWoqRM4IZ4dbj0qOeP9L6Yuz/4jaA6MFFkmaK1BIKwKo7Klt/H?=
 =?us-ascii?Q?/CUvzEoAY6NUI07Xd5gh0lvSnS1hCEfz18PFfjbrv/43clR+Na3EzA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 06:37:11.0346 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 098dc842-2f03-4a0f-ac44-08dd5566d558
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8862
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
amdgpu_dm_find_first_crtc_matching_connector can return NULL.
It is necessary to the returned connector before passing it
drm_atomic_get_new_connector_state which always assumes connector is
not NULL.

Reviewed-by: Roman Li <roman.li@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 0d14a0d5def3..5c956b9962dc 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -1631,6 +1631,9 @@ int pre_validate_dsc(struct drm_atomic_state *state,
 			connector =
 				amdgpu_dm_find_first_crtc_matching_connector(state,
 									     state->crtcs[ind].ptr);
+			if (!connector)
+				continue;
+
 			drm_new_conn_state =
 				drm_atomic_get_new_connector_state(state,
 								   connector);
-- 
2.37.3

