Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E149EC28B30
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Mar 2025 20:47:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 193D010E7E8;
	Wed,  5 Mar 2025 20:47:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QmpNoOca";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB3E910E795
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Mar 2025 20:47:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k7Dc1TF3ijmyI27RhV04QpjLptz2GrWmNRTHMbg1N18KyeIhhyxVNeElyG22CSNoOZBsTYSRdRS0t3gFqxDXhFhLq0tap/JFyAyNHnbSA4IsvJYKV9cr/rrpYQhsVvnmZ6YWCkl2B/kR4lk42bs/Pa4fPJPkr1GSXta71XK5iln1YrVBbf0E3btjlkvhxSKQpAdgdbgCUVP8zmhHx19x9rp1tp2rI0ZqWj2AfaYZzYk9dZaSN5CA/kqEjDpees79L8S0yxdrXqGmutlrFrz5uHXOMIwRSBHjmrsX5Ro6hd2vrqUTNWEuwcNCmrFFit0BpYroacQ7GdM9/Uw8gz6W6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=halRkxt1SoLNnC8JPgTrMPqGysbjHwTdVhkxkb2OLC8=;
 b=DIZ6BzO6UHZK3qvStQytqywDugfRe7wCNe7AQTktCSVs6+kbmkjX9Sq5UulGC6g5dySj6cIHhVcOu+RWa93lPzN19ot9E1lecsEzgqtwCy9GQrIEFtq1YIZla1U0X2c5ts+hM4R6oIeu9AW1p2qaU1NMDy6pjuSzsglEpf+ySp5+YMJCAVB3NkhmXkU5AVuOEXElBgcK7diJUeYVep0jPDanExQ0KxwiIa9CeDHnDUFaFSVj3JTGx9i8OLW3fgU+0YAuthOvtJ8rQhlfsjGTNWIJwNe9KZZ9Iv0JAI7ymXfxwYfSpZCMTstV/aBVfHmjnlUs7Q1cg6Z1pN3ruZGNFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=halRkxt1SoLNnC8JPgTrMPqGysbjHwTdVhkxkb2OLC8=;
 b=QmpNoOcagj+dEAwlXT1ATOvEDGOnFIXUYUOdNy725F9bkWrH4sgywfAg5fu6Bgu7BKwHGlm5Og3Mzuvrq0zj3gu4SSGMuSaBrJX/URyE8Pu4xGulhW1r8gtEqcdHToMRAUe3qTTn1GKil46rEiWLhnXFREvDpmWy+vuX0LhZSLc=
Received: from BY3PR04CA0004.namprd04.prod.outlook.com (2603:10b6:a03:217::9)
 by MN2PR12MB4391.namprd12.prod.outlook.com (2603:10b6:208:269::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Wed, 5 Mar
 2025 20:47:43 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::a7) by BY3PR04CA0004.outlook.office365.com
 (2603:10b6:a03:217::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.29 via Frontend Transport; Wed,
 5 Mar 2025 20:47:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 20:47:42 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Mar
 2025 14:47:38 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 10/11] drm/amdgpu/sdma6: add support for disable_kq
Date: Wed, 5 Mar 2025 15:47:20 -0500
Message-ID: <20250305204721.1213836-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305204721.1213836-1-alexander.deucher@amd.com>
References: <20250305204721.1213836-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|MN2PR12MB4391:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ab5fb75-bfc3-4c20-e6d3-08dd5c26fa0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IkTPj74mpC3fzN8BAluy8VOqyeaw+9VMoWg9Iowa9+rhdwRAkjfm5MSDFKDI?=
 =?us-ascii?Q?+ZXjrRIXBrG87TF47y3JVrTG9gLYmKppO18nzMGXgKtmR5MJ0q2AjOWU3qza?=
 =?us-ascii?Q?f1fPj56uDBLQATSpw8Al5vQxL3Ti2+1GBtwGP0v0JxGDbRLzRMJ9/ahY9O0P?=
 =?us-ascii?Q?8lKcjx+BlMPYPLYG4rGHvLUu/I27To4Mwpi5yljDCbmTfsWd+TlosQp8rrow?=
 =?us-ascii?Q?mhslPmJxMSp8XnLEOl3PZ50WGbmctAnPDIVL55jrOkYyBtif3i1H5nUZ+nMt?=
 =?us-ascii?Q?yB7qJ1Fynua8JHFXfIsB9QA4rUY0XLjwxBwsBAe7hvyxM9FOndGQ1Fy2nmsh?=
 =?us-ascii?Q?q596jsmOYswe49Ojba1xp0qe3kDPDZl4xw/M0UjE9gdqFMLlpoa8MfNJ56jr?=
 =?us-ascii?Q?+350tMeMNPvzGfsj3iFVPUUh+TwhZ6sLBcdSNkrxMBoJccY+rk1Xka/1Idrs?=
 =?us-ascii?Q?C7f1153IrnZvjjgoTvLU6gzC727LjiRyhn59jghlF/id2ZrHzEl+z5E2xH0p?=
 =?us-ascii?Q?mJ4+loh82T7uzveqojNrXufRpKtIwiVY6tL7aEfE4sTaIwR4Zny+Kbqalfj1?=
 =?us-ascii?Q?ciVtoBF7p7SKKTkH6BUh/p6eryhuFuXlnGxbs18FTmPlcvP3yyXD+HGDm5JP?=
 =?us-ascii?Q?j4vc1xAM1TKsvyzOcH4c1qrdbas5pSvkbdpm482i+wVvTIS/Jrx8OQO6bYmS?=
 =?us-ascii?Q?Db6k5GtI4b7qSE/PYAXNduEZ+toODcymTkMHNGCLj3uSJKSs48DEciIlEYAi?=
 =?us-ascii?Q?MTlENv6DL1MMR91ZYYtuevSSzvIzV+A50I5dk/73Ow1Mey0KBbK7DqlOnAcS?=
 =?us-ascii?Q?dqW6HnudZEkkKueq47aQYKpDRJMkmLBQoHZIZ5mFhZTDwHVYmsdzpM9iLgVC?=
 =?us-ascii?Q?uRmiRmbtOsY85uYbOxzM+FIGYYCllV6eAZhmpgB1xSfSpYBiCh9V/1BvIsry?=
 =?us-ascii?Q?AA4evLVdDQmsZwRW+Yic9gouJmyuk74a32H3rLmEgghhUw1uEpoxXFUhOt8P?=
 =?us-ascii?Q?u+CWbsrGGr8SFxNUGMIHWQ2Wv6upJuULKcegB2tK39KF2/7mOtvLP9RAPMop?=
 =?us-ascii?Q?YayYb87gutqn3e72qAkecLGoV6MILXBKQ8eWIFLSvrGiYfKAKPUgYQ1mJe6U?=
 =?us-ascii?Q?m7fWLZAEEbJFl7vDe4d9Ayr9EiHsOXUDxgPMwIUyRyRSsu+yfSoKHmMZ14fg?=
 =?us-ascii?Q?AXhv+8kQWbnkjztXQW/q4lQk6xX7Zbmm4DeUUrOuojIDU+tEsddreD0AzJqg?=
 =?us-ascii?Q?bZ3Zd3u5fyz+ZYVnl0lbVQi2Ak0udV86dsWKMVIDtH0U3azouVDL76xcwDzY?=
 =?us-ascii?Q?PLoeD5QnenikTU2tl5RJSwge3iutGOC7AuzjmKzeFepzygNG/cO+iKGbPTdb?=
 =?us-ascii?Q?L7pX1ISpCd9cmuJd7xew6EIjb5/lb0m0hvdvMVQKZJ1mHASZXzewOyQPF8Ze?=
 =?us-ascii?Q?BMvqFFtFvFnr2pvQAD0Ko06MdG27+3H4Xtex4rfI8AL1IQaOv5rlTg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 20:47:42.8134 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ab5fb75-bfc3-4c20-e6d3-08dd5c26fa0a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4391
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

When the parameter is set, disable user submissions
to kernel queues.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 3aa4fec4d9e4a..bcc72737f8084 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1304,6 +1304,9 @@ static int sdma_v6_0_early_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int r;
 
+	if (amdgpu_disable_kq == 1)
+		adev->sdma.no_user_submission = true;
+
 	r = amdgpu_sdma_init_microcode(adev, 0, true);
 	if (r)
 		return r;
@@ -1338,6 +1341,7 @@ static int sdma_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 		ring->ring_obj = NULL;
 		ring->use_doorbell = true;
 		ring->me = i;
+		ring->no_user_submission = adev->sdma.no_user_submission;
 
 		DRM_DEBUG("SDMA %d use_doorbell being set to: [%s]\n", i,
 				ring->use_doorbell?"true":"false");
-- 
2.48.1

