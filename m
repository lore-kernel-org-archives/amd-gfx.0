Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24035C4345F
	for <amd-gfx@archiver.kernel.org>; Wed,  1 May 2024 07:18:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C03D910EF81;
	Wed,  1 May 2024 07:18:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e5+UbO1f";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6CA710EF81
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 May 2024 07:18:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SEOBuDAYjz7OjXMW2a5/59GwDSqYi/lg6ykbu1L3e6MgfiJPwv4/jXimkUvIoxMK7PqgkrZfQLKI3ixKaIbMfWq6mSaXjbKGkJDdItMOLqRJUQGDDiEbiehKzaDdJJmJWrXx38OrYIQ8H04Hxr9nUAl6IJcGNtra1q19dVVsfAiW6Uzznn31OudCSCUYQMOU5TqjFnf2vVpC+bYkVZcyKckOZiLnpZ0uRqvDkk7P+SQGigoM4L+JRR1a/C2YyAdnesIkGsX08topJo0nXXTuJouKO5W9/ajaN5fDP0TpurLauiQynru/wKUKlY9dMjjJTOabIBNx2ui4GgrElp7eQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aa3pj2GoHcdKcOtddM6NvF5lz3/eU+k7YUUhFNa0i+I=;
 b=Ww8BF8FJoyVjo60GkR2LBAp1DVht8el1Gtv8Wr1jEYzr3vlhjJUc8MH2ckkNXUV1ZiMFzufAbqExNmS5LisEKEybtm1D9nigF9loCu60OgmSt+MI5NxLumV3FyfY1JyuuzDNn0Qpi0XBCkK7whY/e614l6r99kAfx4kESTzyGeT5/Vt/lfzEh6jYf7xaHJPXBCoAOp9RxKY4MVfzqDWMoXrdu0nBRaiUC9VeBHXBl611yoFg6j2wwtze0nl91PeLP56IhJfCxjscfieuTcks5GNwNeFGJ36sENhIzy3sDbr9osPBfmOfArgq07EPncs+XHo3yzOfVveQZFf8qJaL1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aa3pj2GoHcdKcOtddM6NvF5lz3/eU+k7YUUhFNa0i+I=;
 b=e5+UbO1fbT2Ri/ZXzGjHIdVK5ZPD/cvVqB/dCrHUCnUj+5iX2eNoHi5vPSlPYQ7QXjOExfke79ukkGkjkQuQGAMBE/DJHjgUTdUfXoGudEDthhIBrzNaoIJ4jakN3/J/Y+fbKU3YBNl6lulqEO2Gz20xH5vKK4JBNQrZL11Cxzc=
Received: from CH2PR14CA0041.namprd14.prod.outlook.com (2603:10b6:610:56::21)
 by DS7PR12MB6359.namprd12.prod.outlook.com (2603:10b6:8:94::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Wed, 1 May
 2024 07:18:24 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:56:cafe::de) by CH2PR14CA0041.outlook.office365.com
 (2603:10b6:610:56::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.37 via Frontend
 Transport; Wed, 1 May 2024 07:18:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 1 May 2024 07:18:24 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 1 May
 2024 02:18:22 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 1 May 2024 02:18:20 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Swapnil Patel
 <swapnil.patel@amd.com>
Subject: [PATCH 15/45] drm/amd/display: Fix DSC-re-computing
Date: Wed, 1 May 2024 15:16:21 +0800
Message-ID: <20240501071651.3541919-16-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
References: <20240501071651.3541919-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|DS7PR12MB6359:EE_
X-MS-Office365-Filtering-Correlation-Id: 44f84c03-c9cc-4907-d906-08dc69aee383
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|1800799015|82310400014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2MhYMI5FeMFEjF2AxvBO2+08PeaEjBOQj+nXLWsZJGz7iFGT//K3+fzEvHHS?=
 =?us-ascii?Q?g9Eq7/Rv44iT13tpWPtxGiEAphnY0ySMlStabAModk7UgiNj5btbmnJ72Tks?=
 =?us-ascii?Q?nRGedyDHsM0x0mNVe9wKA7kF+nDsagqC4SCId6Xa/RBXMFAJYoml0Qp9YRBi?=
 =?us-ascii?Q?EdI0Enmn+Db1e1K2qBquMhSMJmzFrWG3EdEf2KZRXG3o0P6sNLHyfgXSN6h4?=
 =?us-ascii?Q?3kwn8WWJEI1GDsYOmlWlG7GcqZ4aIhx7pj2T8z5LMfvOUJKj/JSJS4URF9UN?=
 =?us-ascii?Q?NSPaOAKqAZhXifPjg6kWDDnveKTWRXAwL9GPjgPUM+4wUrfdlrzFH6h3cuof?=
 =?us-ascii?Q?MMXGiQSt0CpBaAnABUKxkgSzvZNdvpBHrL82eRHLfzLOziqM7sPawc75QAPG?=
 =?us-ascii?Q?FjqnoTkpO4CYGg0l/oG+LQy9Lf+kJRTjaqbASDhx1fCNTIXuH6RCgboE42zV?=
 =?us-ascii?Q?5IAXix+EH2x7oJEXdMUjAU8Iu0CFFEErBkXD09Z7mNrtIXMQjHPoYegNuo5h?=
 =?us-ascii?Q?3gKM72CSmkSCTHW4Ju11o7i6u9TElxmaYeXRMJjDVR87C+hSbLeiMtHJOFLT?=
 =?us-ascii?Q?ZKOSXkZq6up4p2q70Y8+8dATtGq4u0jbb7JQYcsqMtt1zlyZSMy0f5oZ56GM?=
 =?us-ascii?Q?wBTLI0iBev3RRFbnWwg6xlCB2VFiNm658ARrCVSBVp3nB6nGRxZKmctAw1gJ?=
 =?us-ascii?Q?hk5PCfX7kUNYKpvRKSFlPXW61IZHbqBgTvOXqS6bUxGeaMTbgv5iiFiE3TkO?=
 =?us-ascii?Q?LTIGc+jG0ks9GFyzgcbUd+rHVEDtk2f/q03BCPPf2gFJrpP/+slmh0IPmGZL?=
 =?us-ascii?Q?uYRRxzab+Dun92d8PcDhz/1BKdbkK5+FF4deCLFVCtOLjizC6nSTz2gkhD6M?=
 =?us-ascii?Q?cvgrm++PMEmYOifhCq+sRIKU+Qz3cf5lZF7+BPvf4uCuwa5TBsiYTTflngSr?=
 =?us-ascii?Q?fUfeVsSthoOtTi/zGYcwyaL9QLNZBVhSgiinW3yqcybEeNKmcskU0gyLwi8f?=
 =?us-ascii?Q?YU80jKoHfVhWh2FhNpXqKLwpnkgEmp+wJ52hSiJp1/eclPnPQLvZ3U3wTabC?=
 =?us-ascii?Q?JAoRu8+p4dfQSf7Hnqq9e8aLVNsmc9mAwVjUIJ5vY9gxvpJEIOacVir5Acpv?=
 =?us-ascii?Q?V2U+KjQ7fyPphEHVPn4+Idtk0siKsTW46xb9xnHgMxOos1ZmmK3/Aw8HYXnG?=
 =?us-ascii?Q?YNvZ5m47M/ldkTzJfSdEJ6la0CMIevJK4iWSP/878128/vQYs5yhQPpUsdDa?=
 =?us-ascii?Q?xW3kCKtDlIgJfYE1uMgAXugV4ewdh2OkcSBZKHFa12YldlpJaX3PC5GKuvAU?=
 =?us-ascii?Q?ebfgNsRsizIZJMnHHvw0VvHZKfxnwPx5+XF7hSetrtxdfjmzkBfmVierL/xp?=
 =?us-ascii?Q?JCQnxScft7du/LpQxRUEbfZUH3q7?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 07:18:24.1437 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44f84c03-c9cc-4907-d906-08dc69aee383
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6359
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

From: Agustin Gutierrez <agustin.gutierrez@amd.com>

[Why]
This fixes a bug introduced by change: c5365554514 "drm/amd/display: dsc
mst re-compute pbn for changes on hub".
The change caused light-up issues with a second display that required
DSC on some MST docks.

[How]
Use Virtual DPCD for DSC caps in MST case.

[Limitations]
This change only affects MST DSC devices that follow specifications
additional changes are required to check for old MST DSC devices such as
ones which do not check for Virtual DPCD registers.

Reviewed-by: Swapnil Patel <swapnil.patel@amd.com>
Reviewed-by: Hersen Wu <hersenxs.wu@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Agustin Gutierrez <agustin.gutierrez@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c    | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 9469cc831597..5542e7d63b81 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -1209,10 +1209,6 @@ static bool is_dsc_need_re_compute(
 	if (dc_link->type != dc_connection_mst_branch)
 		return false;
 
-	if (!(dc_link->dpcd_caps.dsc_caps.dsc_basic_caps.fields.dsc_support.DSC_SUPPORT ||
-		dc_link->dpcd_caps.dsc_caps.dsc_basic_caps.fields.dsc_support.DSC_PASSTHROUGH_SUPPORT))
-		return false;
-
 	for (i = 0; i < MAX_PIPES; i++)
 		stream_on_link[i] = NULL;
 
@@ -1230,7 +1226,19 @@ static bool is_dsc_need_re_compute(
 			continue;
 
 		aconnector = (struct amdgpu_dm_connector *) stream->dm_stream_context;
-		if (!aconnector)
+		if (!aconnector || !aconnector->dsc_aux)
+			continue;
+
+		/*
+		 *	Check if cached virtual MST DSC caps are available and DSC is supported
+		 *	this change takes care of newer MST DSC capable devices that report their
+		 *	DPCD caps as per specifications in their Virtual DPCD registers.
+
+		 *	TODO: implement the check for older MST DSC devices that do not conform to
+		 *	specifications.
+		*/
+		if (!(aconnector->dc_sink->dsc_caps.dsc_dec_caps.is_dsc_supported ||
+			aconnector->dc_link->dpcd_caps.dsc_caps.dsc_basic_caps.fields.dsc_support.DSC_PASSTHROUGH_SUPPORT))
 			continue;
 
 		stream_on_link[new_stream_on_link_num] = aconnector;
-- 
2.34.1

