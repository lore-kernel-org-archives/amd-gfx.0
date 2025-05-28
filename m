Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2D94C5AE59
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 04:19:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4190D10E161;
	Wed, 28 May 2025 04:19:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SaKLMrJL";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1207B10E55B
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 04:19:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L3WpAXl0XTkUbc06+2UNa25EKWIwAV9m15m5zC27WVAFwPjoT2VUNUBTFx2XA0hnTXDvbWHeQ2xB079FM+T3fok1UaeSh1zVSpWry7UKKpkishyypy/atl7xZ8VqPu28Lazpi5XuFrx/Qqq0vMWqbAtCkhFHleI1rWySL1caVvDpS8kGF8vpGy5yL4pL0MyaydVoKwlBNwpfw3LC9QE+jhva/HcbYVRQ84V9iNvaBwua1kiyAxGaWiQ1/uP8j2RP1x/LpnGsTOVCFOZT5LN+/vSQz779EsqPlnkHuqoBx3FYgT+RS3nwepqp8MJITvhwxm2xO8uFz0zuQQdb1B2hZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sb5Hroo/OstM5PMnCpF7/FrNlSo91RoUqBaoGGJjmbo=;
 b=kOHKONGPqlNjQMIabCdYzmO1pIGuIRYOPOnO11AfWlIQ05i12Kv6XEK/yUv7z5kbmTGkqhUbOe2HPnnOcK4xu67nu6bIhTDJwJSiPwQhiqzUFExuK0V8DjTbpY+gCdWZUAsPkapz4NN11V6W6Bfa0Dn3itSWLJZXh/4w2YhdrY3bRW+1RcUijBrk7mOBIlME+JlwWRsN1j4AFwHYHaHvNZxjq/vL3VGxgNwt4j1d4x16wU5lUMi/8MVGMUaf9f15HjZeYwsbLgKgcbNbQYwBzcNWx8mYqPYQVFay+wqAKiTaiz2owXiLupvSCr1X8LPOyUBFB/Es61qAdF+Uf503xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sb5Hroo/OstM5PMnCpF7/FrNlSo91RoUqBaoGGJjmbo=;
 b=SaKLMrJLG00ekEGEc5ffmYihbZoBJxqZP/g8VPA6THYxK884bKkBHQJdKOZ+u6t/2ISOSDWuqgYC/YIuEuWXwfVWurmHfu/Q7ONZBowe184b5ZgUms2u9xg47NJBP7Z/qi3oBmggr1JPrvVjMT7pi3ZIYR88BU/2NKwthDGpsUY=
Received: from DS7PR05CA0051.namprd05.prod.outlook.com (2603:10b6:8:2f::12) by
 CH3PR12MB7523.namprd12.prod.outlook.com (2603:10b6:610:148::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Wed, 28 May
 2025 04:19:35 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:8:2f:cafe::c) by DS7PR05CA0051.outlook.office365.com
 (2603:10b6:8:2f::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.15 via Frontend Transport; Wed,
 28 May 2025 04:19:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 28 May 2025 04:19:35 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 23:19:33 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 08/19] drm/amdgpu: add AMDGPU_QUEUE_RESET_TIMEOUT
Date: Wed, 28 May 2025 00:19:03 -0400
Message-ID: <20250528041914.5844-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250528041914.5844-1-alexander.deucher@amd.com>
References: <20250528041914.5844-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|CH3PR12MB7523:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c729807-bbbe-4ad0-31d0-08dd9d9eda82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mHu40kvKMTKLv7fQY4/ORAy0xPNfalX8PBbP2Qd3kDaQG/pjEOTkaXqmNO7M?=
 =?us-ascii?Q?s6Cm4EmGmqj0T7pGpoK9byV9wS/fSApTInPQynVoTIvsFnV5F1CzahzIlLor?=
 =?us-ascii?Q?3SUJPfke38FADXkbth2AonAi5TAmQa8IQbwH+xfzy4CvDfRhNWQYHQUpi8jG?=
 =?us-ascii?Q?7m579AOJxzcTsUBL6YwAJoY3Lk39/QgGvEAnICXryiN9PhRD4mPfmeWLzmhO?=
 =?us-ascii?Q?D/0W4FApp7GnyhMAMolnD+AApnSTjhlpEaPjs2N2EL2WLzWvewkyGKE7+w8g?=
 =?us-ascii?Q?q9AIXpdFtbY77F9LzRtJ+yVaUwpsO4IrfGHa7Np0t6EeJSozi6YxcvRRbjn+?=
 =?us-ascii?Q?UoPXGigWESb3o+Ml0lH+DRfBVbztqxPWPRVaphR2ASDhi1L8cLh1qJPaSvrE?=
 =?us-ascii?Q?7+BTfVZMALt3cMVO0lc/Je4l+2FUgFo77C2tk24W3roS4LEBQ8qqDao9/93r?=
 =?us-ascii?Q?6iXpOXaBuZ7uj405cOjOqDAfevAWsHv59I4OPxVMM//6ko0dzafo4lYmEeuB?=
 =?us-ascii?Q?GIVS46S8bG+IIsYRe41gu1vRtha/OV/YBHsgXBy1LyTZBkx3QQt/RUrtTI7Q?=
 =?us-ascii?Q?CsrZZ844VEmRvfd9aDBN9AeXUfAKW2Nt3abMZPMS8DdEk1f4t5OvUMr+YU9m?=
 =?us-ascii?Q?J3gc8XzwKbQpuD73bqvHmbeZm+QcE+OR2v68ejSJcSOoe9xaCjB8BLqq+AGM?=
 =?us-ascii?Q?j4eV3eptWwGzU3Cd1GS2Ol4+cX02uP1BzOpHX2a5NqxfrVQnclCegv2PDzm0?=
 =?us-ascii?Q?qW+oiqbeJa4WPloib5CL4DmG/DlClq1qaPgI5+uT+7nqIemevxiace6lDO6l?=
 =?us-ascii?Q?ov5irOxmuPo6hRpFK5/H/+uKBa5+x1Y3sTvhIy79B+22ssU1fUiqVfIWieSr?=
 =?us-ascii?Q?7qtuSfsUsQ30hTW/uoSu+9gVs3nysN5Xkk+saF4xhqyn+GiNAQHTP413WnkG?=
 =?us-ascii?Q?NyS1DMZD05wXRM1zdtOO4iRU4ZmMoORUII/+3puN7mw3/kjOwMcB3jP6xZXS?=
 =?us-ascii?Q?uW7pRN85n6+xzCjGk3BCGsHHwLc6MjF2Gmm4ZSbqz/gddhLzAehN9YQ6ZRUK?=
 =?us-ascii?Q?V27VsqOBHf291naqQU0u9SjVz7T/iW0L+J40wa53DOPjqc3RaMGnZEp50pZZ?=
 =?us-ascii?Q?tAx3m2eP0v39UmLKYYsNGwRZudPznHxdF0L4VM+hLVNW6/0YF44Q3gFNC2mo?=
 =?us-ascii?Q?5XGZdNCVq8vfmYa2k91xjNWP+aA2oUnmAA2CYUAbRfyoRiPwBv0RDuN0sDmo?=
 =?us-ascii?Q?LXXUgqA16GPhqboA6fgiy2xYfmKwUdqjHgpHjgy3qOW09/1p7wmZi/UVveUJ?=
 =?us-ascii?Q?YFl5tDlONfk121sPZBlN9rGLvBX4iHHPjvUVT/Rf1rdWkitRYWvo1YpJzINR?=
 =?us-ascii?Q?83ooGvCAyf6zIAJU/OaLh48jC2Glf3/ydVKl8rKH1Vxp3gPxe/w5JxXYtgKm?=
 =?us-ascii?Q?f7xsKsCmYWa/N4FpzAnmnDfkY1Bcw8J2ggzGrUKXFtPqrN4f+c4aU9WwK6ls?=
 =?us-ascii?Q?+gaSv9hpxcPYp7xGmTcp5GruXkQtmFAFAyaR?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 04:19:35.2031 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c729807-bbbe-4ad0-31d0-08dd9d9eda82
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7523
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

Add a new define for queue reset timeout.  This will
be used for the IB tests used when validating ring resets.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 836ea081088af..2a5e3a0a543dc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -278,6 +278,7 @@ extern int amdgpu_user_queue;
 #define AMDGPU_WAIT_IDLE_TIMEOUT_IN_MS	        3000
 #define AMDGPU_MAX_USEC_TIMEOUT			100000	/* 100 ms */
 #define AMDGPU_FENCE_JIFFIES_TIMEOUT		(HZ / 2)
+#define AMDGPU_QUEUE_RESET_TIMEOUT		msecs_to_jiffies(1000)
 #define AMDGPU_DEBUGFS_MAX_COMPONENTS		32
 #define AMDGPUFB_CONN_LIMIT			4
 #define AMDGPU_BIOS_NUM_SCRATCH			16
-- 
2.49.0

