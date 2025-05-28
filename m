Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2F59C5B54E
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 02:54:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B78510E565;
	Wed, 28 May 2025 02:54:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Bjno2hgM";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 380BA10E565
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 02:54:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lCsNe2mG4RZeP3yKwgTERpzLNOHxOyp0q89mSBSh5vBk62pDgf+bV6w+ZYjcnXoc3dCTdCD9hN9r+ITUl4SolGYiT1OCnzti64XR1mp4iIXxNRLM4uFear6N8ZZUx3BY26YzqY1GB9h6R+dLWWWWByI9OUMOTd6On9zZvouOlC4I9aQ0+3K5nGV8PgVVDcplTx/yxuYiDLdJ4uSlW2LbBWpqqFCzomFs9dKsIqZ1xQYCOOEfoWUQeAoOrGBck0GsfPAx3M2Wqg1jiGWNlq+IWRKWGMJ3UClQ+o/YBMwkrL7nZpmMn2FXiPspDIgcHs5QEWIFN0QnOE/S9tVjW/Hl2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xSVqtzY16AvLg6w/yU/ScuyN+RmgPBR8uJ++1w/ifs4=;
 b=pd2koHILmal24xbSKGkbjA6OzYhgmbVShXiYDiTTu7j4gPLVwzD2AN10uGLwcbTDK1ifVKY3ritkhb68LFEXwdh5kLpHkKq7a/LTc1F3eCrvu3bm3rut047uhBwgQrjZAApdwp4iT+wO15zVZ9XQLwuZlCQpuh1RbrVnJI0ilw0ENorfAnHRx2Ag2dAugWvMj12BEnk6d2YuNR3qSc+30Ip8HEPZWeLsCQ8FN8MwmS1ghiNhewEEve+IpPIlpSQVNm1KUBPIrNF4XHK6Aq2u+5sppsP8tec0UNwYN7XZvtPjZi7K+3h/XJHrcVwwkciHgKLQxauPymrYJBFEGOu9Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xSVqtzY16AvLg6w/yU/ScuyN+RmgPBR8uJ++1w/ifs4=;
 b=Bjno2hgMjRKzgUfk2WxH2TEYvTK2USEhWkpM4EWfF2Mk5DYQXwzs47TGwtottYcDeMyJj9XnePn+40/8UVJ4c5JIz85YKsswGc4oRQJRK+no+voAuJEoXQEswI9x651WbzWS9C+ShLAw+Hmh+W1N2ZHLlV8XEeHiaAu49oCmbYM=
Received: from BN9PR03CA0685.namprd03.prod.outlook.com (2603:10b6:408:10e::30)
 by LV2PR12MB5822.namprd12.prod.outlook.com (2603:10b6:408:179::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Wed, 28 May
 2025 02:54:12 +0000
Received: from BN1PEPF00005FFD.namprd05.prod.outlook.com
 (2603:10b6:408:10e:cafe::cf) by BN9PR03CA0685.outlook.office365.com
 (2603:10b6:408:10e::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Wed,
 28 May 2025 02:54:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00005FFD.mail.protection.outlook.com (10.167.243.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 28 May 2025 02:54:12 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 21:54:11 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 21:54:11 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 27 May 2025 21:54:07 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Cruise Hung
 <Cruise.Hung@amd.com>, Wenjing Liu <wenjing.liu@amd.com>
Subject: [PATCH 21/24] drm/amd/display: Use DC log instead of using DM error
 msg
Date: Wed, 28 May 2025 10:49:16 +0800
Message-ID: <20250528025204.79578-22-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528025204.79578-1-Wayne.Lin@amd.com>
References: <20250528025204.79578-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFD:EE_|LV2PR12MB5822:EE_
X-MS-Office365-Filtering-Correlation-Id: 16370677-88fc-4b15-dbcb-08dd9d92ece8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2idYoXcOwtlaV4eLOJYENimPujMVIEx27QyfEpZZDCJC40r2XOrlR1/b4xo1?=
 =?us-ascii?Q?AOAi4du314fl339H8T2vhBzGZCspfz+51h6aQE0RKlhVq1sxCvjMDaaY+fSn?=
 =?us-ascii?Q?TDWniBwjjWprfRwrOFwsujDxfmT733rJXwiHFmlLyWAstLprYPRbrCY+jMY5?=
 =?us-ascii?Q?yzGTCcVBEHv8/aDUwzl5GgY3xugm4iOB/tRHd3IbUMr1eqIil/9jXerVclD5?=
 =?us-ascii?Q?hoyR53btol1qFnKz0NgfpZ5sMTNlIQ1A4+N0qqbvdH/ExujiCq6ce67yFhFw?=
 =?us-ascii?Q?586vtIJhgdfrZ5Xv4SW/DGIN5qn8Zb358V0W8eIekhlD0HOcR8nL//JtIR+b?=
 =?us-ascii?Q?GG1zE6TiOJCBovmV4kuzOL3Hl4a3lFpObKw0YTDZ77gBa2FxjkqoY//gnWBs?=
 =?us-ascii?Q?sf31aoTpjf+WiFjF39wi963+IJCH51T3dZp9fZFgTIupF5MqcQZeB0VPiXnQ?=
 =?us-ascii?Q?dcwdJeaktTm8UVVV8w/p/eQKrAPH6RzEm/FMqkcwyK22ZZApo+X/bXLxLA9V?=
 =?us-ascii?Q?Lj5h7ZMXY34r0eZUvoyBIHsm0j6nA0VdHuIlmG8R275LZLO1F4fv51Yuz1Ko?=
 =?us-ascii?Q?ZERYwQ6sG04KaPa8uXa5WRFAHY322m5ox8mKcwWBmF5qcuZtofvLJM9WMx1S?=
 =?us-ascii?Q?Zx+1+glIH8gX5ahX6tP5GgSfuPooO9A7W0jFSNf35YktYZiA7vjHJk4KmVtL?=
 =?us-ascii?Q?QF3oQABBbJIzWhPmxDVY0Djgi0AGod87n5UPqv9WwYitj/vDh3UMGEa6rLZ8?=
 =?us-ascii?Q?tEdJ7cNY9RKHpGUG0R7Oz1riPbKKuy8fO2QuMi0JEJtov1OETcbOBWGQU3xP?=
 =?us-ascii?Q?ZGsHzohZGCiL+EV25c3sIUASvE98i6YJU290Zberz/bbeC1XB1Dk+mIE55XQ?=
 =?us-ascii?Q?O6oK6gO89JjTZURyEr5Sc6opVgf/+DEctvUoL6HqA/HpWiVaqvqgbIOlpXYQ?=
 =?us-ascii?Q?4hj+IIUi+5ZbKvF46wZ2jLJDxyPwQudRskqYCsjDdBFPdwV3FNdKC4pMAhZp?=
 =?us-ascii?Q?Geoi+GEo52O8yfV+7f3pnOD32oaMLblQintjiOyfEQHePValuuZGbGHonAlr?=
 =?us-ascii?Q?1UkLVkM/+g5vyQsN3dAF/K2vYALhu4D4I4zJ5zCjy6mk7aE+GjnPecyg+t/4?=
 =?us-ascii?Q?y/72Nt9TiEk0/5gP02Dz3d09N0KNTYqtdBS03RKxQeAsrygwkEBnfamNP81Y?=
 =?us-ascii?Q?5mwsO1J6S6M2VITYNug/28VqbcyWKtGbKXnFCocea5L3OKijPDEj+SLH+xzB?=
 =?us-ascii?Q?M6Wnu+/1Ydu9cs9/MBuHogCaQySlwGXKTmYlPaI/ioesSC831Ez8+/5UFTNx?=
 =?us-ascii?Q?CsD8yBOTFFERmH3XPOsa8WPiVFAHOHtIl5XadhMpb2A3SOsRNc0RxWej3wGc?=
 =?us-ascii?Q?1a5zPGUUvm/iEuhumkfMhp7GrSVFUekZL8KTCLQ2m81zCCt2/NQUN66PALTR?=
 =?us-ascii?Q?+JgHt8mFb9pYT4CtmplAonrGZOYl4D4xg0cHEXInX4elp+x0xVXgVKxK7px6?=
 =?us-ascii?Q?BuudWNLZV5rYYUZ1ha4JGNSQsgd3IPA/o/6x?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 02:54:12.1523 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16370677-88fc-4b15-dbcb-08dd9d92ece8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5822
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

From: Cruise Hung <Cruise.Hung@amd.com>

[Why & How]
It sent an error msg when it failed to read the DP tunneling DPCD field.
This should just be a warning msg. Use a DC log instead of a DM error msg.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Cruise Hung <Cruise.Hung@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c  | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index 8f79881ad9f1..a5127c2d47ef 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -2023,7 +2023,7 @@ static bool retrieve_link_cap(struct dc_link *link)
 	/* Read DP tunneling information. */
 	status = dpcd_get_tunneling_device_data(link);
 	if (status != DC_OK)
-		dm_error("%s: Read DP tunneling device data failed.\n", __func__);
+		DC_LOG_DP2("%s: Read DP tunneling device data failed.\n", __func__);
 
 	retrieve_cable_id(link);
 	dpcd_write_cable_id_to_dprx(link);
-- 
2.43.0

