Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3AACCD3431
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Sep 2024 07:43:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4656810E6A1;
	Wed,  4 Sep 2024 07:43:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qLCV05Oa";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 976B910E69E
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Sep 2024 07:43:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PRLU5XBfe1WZbBefJbpBGJAY6R0xOBiQnmuNhT2jjfboWXZTSyGBeSdrgDTfEtHMZVJYuqmJUZXfabmvv6YVbN37Dj3+yKDK8JvPNhkgD81u03zBVNRQ5Yplm8F7Ngrv3aZMLeJMube6OoTcHe+kM9OP1Ax88dZ3MSqizjw9VkN8Yjl2zjBLrKo/gGYzxt8wRUA0Ald5giXbmCzxIwChAieMgUEyEAFJYkVGc8Gfu9vAiTM5wa1n814r5+yt5q1RAiCAdAzccZFM190h2aYPyLfpanWvSf6K9cey8VeHQntLbIw5pzvGctU0GIottcJTh4Rm7QVhuuZ2ms9fpokACw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HHRL7Boev+1MekVK98dHd83pTpGAgLKetI3Caqc7aQM=;
 b=bc0doi7n/iCYANvYDB/sKuaBbc4UorKWkDFxTut/7jJi3RrUSopAQZrxLT3ojFioBjljmWm3dX/R63aDnciQRxB3ls0khP9ADfjcCtlTdJlm1eZKDtmxXO48Thlf0WQlZFXkArBO4heBia8H9t3pGTvEN4uMnt1uVqzve2zGXgIzEKG7ySB0aMYtIqDnRcU1Rm5HZ8IpmAj10iEPpw8qp39lyS5N0rMLPvMWJETXUufITKcilwLiHS7RNTytVnXuBSMaIFjU1LrF/3kO1CD+FYoFNSR5YTea+lQkieMDXnWGCxxcfy51HbbTvCQ2B806SEuE4B7+P7bRIjvG6DB6ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HHRL7Boev+1MekVK98dHd83pTpGAgLKetI3Caqc7aQM=;
 b=qLCV05Oamy/539O+dWs3NieApZz5dCOtObg520zsE+nD+Rh3pfavTPfndQByOWI0yMmku8pi7r9+po7+bMrk3iEtN4gTyeTAoyiP5ZDh6udMhpiX4gSgtolqxapoRMFD2zNd6R3CT5wG2vwuhuh2Nsn+UOYKMv+rmw9app+9Bsg=
Received: from BL1PR13CA0369.namprd13.prod.outlook.com (2603:10b6:208:2c0::14)
 by PH8PR12MB7135.namprd12.prod.outlook.com (2603:10b6:510:22c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Wed, 4 Sep
 2024 07:43:50 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:208:2c0:cafe::cc) by BL1PR13CA0369.outlook.office365.com
 (2603:10b6:208:2c0::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14 via Frontend
 Transport; Wed, 4 Sep 2024 07:43:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 4 Sep 2024 07:43:49 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 4 Sep 2024 02:43:46 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Roman Li
 <roman.li@amd.com>, Alex Hung <alex.hung@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH] drm/amd/display: Add kdoc entry for 'program_isharp_1dlut' in
 'dpp401_dscl_program_isharp'
Date: Wed, 4 Sep 2024 13:13:31 +0530
Message-ID: <20240904074331.1733704-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|PH8PR12MB7135:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bf3d2f6-d609-4de5-c502-08dcccb550d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?I+eRHj4dgmwXPLcRbovCfnN7Ug8HOhutjJl4M5DifVTPw+YhFxNFNI7KOCGA?=
 =?us-ascii?Q?DiZfyq24Y2dNi2bKhzGkt6Eg8BXDJ8oMlxr9RlwlMPtDIib5yUOyeCm2rQB4?=
 =?us-ascii?Q?mu7L8xjkSf+MRqJmFxkeRE/xycXqgYZ+bc91fqZnue+MRd+W1e7insTpLuS/?=
 =?us-ascii?Q?q5e1QtPpSt1MfBicRjaUrWKX4uyu7FgUfGWF96t112wcAUO1JE6gKpxAsiHu?=
 =?us-ascii?Q?0qTHjN0nNh7nxpTLZOvMg9/fCscJhAL7KbB81Mx2GTXl+6FXsX5B7yS6NhyR?=
 =?us-ascii?Q?HwiQQgCjrTDI5ZVZgzVCp8No6Ne6Nw/HyLMLxaSG0HZWV4KJxoglHjb2MYOT?=
 =?us-ascii?Q?OLhIwvscf+cXRHD6U/guZ3VpH8qucLEm238J3/ulUP1TLxnKFwoCbDrVL496?=
 =?us-ascii?Q?J/fCFoyXjhi2ZO/+CSRlvW2saTkpOUTZLjqDI7IaPl3Tn172bC1VcoSPvn9v?=
 =?us-ascii?Q?zUG8jyWKX7FLF3eBZiJO4Awc4CCGB50qXh1oupP6t2o+xZ7izx1QyKNO5Q7u?=
 =?us-ascii?Q?CHZlshtoMuHWAGujpLgMUtFCYCRWlwDn2OQe6PwITjNBYgj4E0Fcy58l5IS7?=
 =?us-ascii?Q?W1i3N0M4KCWuJWk4QglhueglHPERjIDxMm4jC8bTXOhQW0RRIelaDqpN+RAP?=
 =?us-ascii?Q?NORW8t56J3PmFf5Njc7nK1s1dxIUwKrvPlBMsJoTQkA2/8WDoEqdqqrzKni+?=
 =?us-ascii?Q?eA9+iVsBSMkjVRV90iH9jqTF1/pdaxq16jZhDrLN/aMQvRDNW/6eX2RWfOfr?=
 =?us-ascii?Q?RjraOZ4klkmQMONMrO97qC0D1mMwEbMyqDcPiJ+qYpeFeILNI8fwX8uyvYwY?=
 =?us-ascii?Q?wvYKuAnDE2bIOiGrSSqL0hea5L0F/qpVgxdQRFXWdS6ZSrHpza1Xkh+tx63p?=
 =?us-ascii?Q?cFRN34a+GlLejsYhT8LQxnAzrtbdeEkAM3MUaVD1LIUh4jxuUPz5MXp92jek?=
 =?us-ascii?Q?CZwe9so4rCeIel386JvgqPLZSosyPWIVbVJ8ukjRVNK9OONKRr6+vD8aySln?=
 =?us-ascii?Q?zqlXT8i8IqBWCwnsbwei+fenVOFo+4JrzfquwgcDpyYADWgDjemobIOFDOeZ?=
 =?us-ascii?Q?FXNgFIe2OuBIc0lnDaZ02roABYu+a5rr4MHOYzrpW1gdJgEhVB6C9g7uY9sQ?=
 =?us-ascii?Q?jCMJCobBQEQOw+mYs/3T+6Y324qw30hnrCN9zh8Aj/mVDweXr/rYAKUor8HE?=
 =?us-ascii?Q?wmkZ2PhAU/2+mPsnejmkcna1gam7oy4rf3qj9OGGTkMchON94T6ol2R4THfg?=
 =?us-ascii?Q?K7QwUZNiHO5p5lgu2GejF7ZqxMmi7npv/sbw5yi4zIcbfMqGg1nwNDaK7jw2?=
 =?us-ascii?Q?cll5rucvRWosNiOdnmYzN1+aqfxN0w7XTtA7Brw5ToGaOrZVbDoAcUouMO+G?=
 =?us-ascii?Q?B1u2ZpXmEBmhFLOx4gzc86Sq8ZFxeSoqkdonfOToSjTOSS4L+PnP0gbbnWoQ?=
 =?us-ascii?Q?VEb+okJhtSPnSa3Eep9PaxFkUWiAVR11?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 07:43:49.6582 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bf3d2f6-d609-4de5-c502-08dcccb550d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7135
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

Added a descriptor for the 'program_isharp_1dlut' parameter, which is a
flag used to determine whether to program the isharp 1D LUT.

Fixes the below with gcc W=1:
drivers/gpu/drm/amd/amdgpu/../display/dc/dpp/dcn401/dcn401_dpp_dscl.c:963: warning: Function parameter or struct member 'program_isharp_1dlut' not described in 'dpp401_dscl_program_isharp'

Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c
index 8564369f09b4..5105fd580017 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c
@@ -951,6 +951,7 @@ static void dpp401_dscl_set_isharp_filter(
  *
  * @dpp_base: High level DPP struct
  * @scl_data: scalaer_data info
+ * @program_isharp_1dlut: flag to program isharp 1D LUT
  * @bs_coeffs_updated: Blur and Scale Coefficients update flag
  *
  * This is the primary function to program isharp
-- 
2.34.1

