Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCD5EC02198
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2025 18:41:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F356710E394;
	Wed,  5 Feb 2025 18:41:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yaK//d5M";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2052.outbound.protection.outlook.com [40.107.236.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8E6F10E387
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2025 18:41:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jz82C+YuwaiMEAGsU6GD+jpauRYyouTvug2wNY7DHgbJiDz5K8cGMijLJ6dP607sHy8MdAiLvOTNORPORqzHZl+H73WIl0f0DKI1LkgGL8xdXKUdtRMwVn95j62DxRHhSbrF+Ii9JKAEAHBrQni2840wYlFjDA9ppFWFQ5P3Xb1dsMWJxkDbArUVKAQ3/fNN2vS0fPfjsfHnKx63XPpPTFIIxg8ttFr+6NhmieeLNkGC6/cXODaJ3SwSlDAx3+kgFVvtZSZNBr06S4M3occiDfGWebrda13h71KuipkJfD5jhAM0Uk3vSTfMB5/JqfBfp//dFjZfCwzSJyUsPcZsuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EuZa/f53oC9VwCvmQRO82MgJ+w+fd0on61UdRIXD8NE=;
 b=j1wFBDROeJlPKyl/CeRe1IMPcpx5AFAzE6ySvDlJFNyJGybupYnpPKHl70as0RAxlkXM/9N4JxzOnipKjUh94ZmtfkG2Tg8oH/+5iFAz+b5ZqxF1nmjUJLxIp8WYWtUktjPNNYRDr2KW/0ae096M2cRYMV4cES38T7rU+ruXj00wttsMdGtaNPg4ZDHzfHUtpLyZRnIHuazKqRSVa0a0v0FjWWYxwwbwYbuGt2K4Xho9NiELvlU+nHOLqBGg2BoeesdSpx0vuOfU8shl/ehSVTh5jMD4XkkeZ+QwZiadAdYWbPyZ7a0/ZSPhwjhkOgIPdwvydYSkcmY96JxE1VfWOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EuZa/f53oC9VwCvmQRO82MgJ+w+fd0on61UdRIXD8NE=;
 b=yaK//d5M3bTP+0XmwG+TpkHt350gvKTZ1VhT3FK+ZJvwzHhb6LKhcUWuYzpv80TezmFloesQ8GAif9lO0HtRAjZkAfO4+w3F+mD4iNR5+TseLB4LAVUiIVwfZDtAl31n7h+EoY7Y9cxWgI+8dxZUiTFo18LYhY3AIG5hh3LYUW8=
Received: from PH0PR07CA0056.namprd07.prod.outlook.com (2603:10b6:510:e::31)
 by CH2PR12MB4087.namprd12.prod.outlook.com (2603:10b6:610:7f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 18:40:56 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10b6:510:e:cafe::a) by PH0PR07CA0056.outlook.office365.com
 (2603:10b6:510:e::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.28 via Frontend Transport; Wed,
 5 Feb 2025 18:40:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 18:40:55 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 12:40:53 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 12:40:53 -0600
Received: from aaurabin-cachy.king-squeaker.ts.net (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 5 Feb 2025 12:40:52 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 02/14] drm/amd/display: docstring definitions MAX_SURFACES and
 MAX_PLANES
Date: Wed, 5 Feb 2025 13:39:17 -0500
Message-ID: <20250205184036.2371098-3-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205184036.2371098-1-aurabindo.pillai@amd.com>
References: <20250205184036.2371098-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|CH2PR12MB4087:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d0ad0e1-7390-4838-9495-08dd46149fec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?296ryHd1dlTcGig9pKbmisDJ6AHBMTqmKor9Q8SRqYi1fPVfScJHZBQZ4Dx+?=
 =?us-ascii?Q?Gza24BaFfedwzpqyQ8fmGvP/GuSnS8sKD1FSmOcTxatiMhQ11Hpv0mSPCYD4?=
 =?us-ascii?Q?gDGIAsBKyhYNK7ElReRPOu5qxYJ4OMgc8FLka5hbI6llIRrmTOlmipmCp1RF?=
 =?us-ascii?Q?98CLb0fzYOYJWrihcgfEIltBOYNktjiDM6nA2GK38BtHRtNWE4OO4/CjMhxB?=
 =?us-ascii?Q?F8Yv8KAXKlW3K6Y67/iWNFdkmWQoJKyi0/mPqbQnP4CEDgQnLJhnb0uxeiRa?=
 =?us-ascii?Q?ArvJ6G7GENGOBvFOA+1AIN/15MlYJdZ16FJxtjze0/qMI8fx9kkDXi0uMN5I?=
 =?us-ascii?Q?zG61KQDW7CVqV2VSzYFgoHMr5BKM2s6IHvdrZwnSKdzauGJoDdTv8id9px9g?=
 =?us-ascii?Q?NB7rFwflKL4ynf+eldiZgwFlAPbDmH1rv1W8POINr9AwTYoboITc5A7s94dt?=
 =?us-ascii?Q?qCsbPcF9wh/zFudqeUf1KyIOJm6FnJdo+IhRAZI9utlE8XQnhXh0iB1BMrV6?=
 =?us-ascii?Q?2DmcxSK+eNgmpbACssJL3gN9ztSMeVPfpPlWOjl26Ki86AdI1OH6TnO6E+3u?=
 =?us-ascii?Q?Aq7E6zn0hiakzKvTo7B0qUuhetemQ7QGreZFqHSbf+E/TFmJ1Kj4/qET6sBu?=
 =?us-ascii?Q?AFyrIymHekhIqFE3gPDXmTTqeZrqh9P1ZAEN/+fW4jWYXysX+p0p6OYpPZeu?=
 =?us-ascii?Q?plsT1RtnIvwMartAMg7MIeoKtSrtZKew5dUZwa1fdie7Mq1K1bi388zb/5Pf?=
 =?us-ascii?Q?5BVhG4V/5Nkvhl8ZJR5yMqevmEvaHprxx2aHV02BanW3lD7dcVLWqT2EXLx3?=
 =?us-ascii?Q?J0qVhzf9tW4sXrcOe/AS6zK1MSECIqppLdoeOFHcKf7SbkVefX/Xt+6Ko444?=
 =?us-ascii?Q?CnyGXtBv1OrCKzLcIz7xsfSLqZYMF4a+JgpC+1pDy3O6x6StLoAkl3hvz9Ph?=
 =?us-ascii?Q?tIRLkrQZsvwYDHKmyHegWj/Eq+reuhIaXjytfSgan+0FUcy89XMYiwp8awu3?=
 =?us-ascii?Q?5qMydXBalohaPdulbAWVYTFEuhv77jJwD5s7aHMQqGzqaG+Lj+QhSC7Us7on?=
 =?us-ascii?Q?PSKpNDPQLwqRJ5sGMGGEGYls8Mi5LKuvaEq6VGgWOLzu3T4W78sfoJ2dO0qR?=
 =?us-ascii?Q?wyIsgnqIp2Q6Px4gTYWx/y2BqPIzx5daD7xT3vFjw5gAxb8kgV1Pwsw4jh3G?=
 =?us-ascii?Q?rkYiFFIpETcSOkkM79XKkqNIFaBlPR/c1L16+AtqP2UnqblQO2jj38MiFyA7?=
 =?us-ascii?Q?dTy7h5SMNJBged80LpWNYJcvBGywKplheJ6wr0QGOJwXgt2euk5Ly2B3KfPr?=
 =?us-ascii?Q?tk8ogKuASRrqZCt6WYRiSDbW/Q5L1ySps9Dx/D6KGQLePvXDQskPjtwEAWsZ?=
 =?us-ascii?Q?GOpmn/d0++Szo7pYOtEpHEZ3lc04JSg+0bYZCinTLC5+SayZRCKAOEMr2dBB?=
 =?us-ascii?Q?ffypBphyl36FMYPJMaGHhmO7S+5qZ1/bDgMJ/tZi8piyFVTsJtRARGw0T6Q2?=
 =?us-ascii?Q?MSYWrCgDbdBJooM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 18:40:55.2069 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d0ad0e1-7390-4838-9495-08dd46149fec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4087
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

From: Zaeem Mohamed <zaeem.mohamed@amd.com>

MAX_SURFACES and MAX_PLANES now have docstrings that better show the difference between the two.

Reviewed-by: Sun peng Li <sunpeng.li@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 42ba65e785ca..e1f4f643c364 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -55,7 +55,13 @@ struct dmub_notification;
 
 #define DC_VER "3.2.319"
 
+/**
+ * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
+ */
 #define MAX_SURFACES 4
+/**
+ * MAX_PLANES - representative of the upper bound of planes that are supported by the HW
+ */
 #define MAX_PLANES 6
 #define MAX_STREAMS 6
 #define MIN_VIEWPORT_SIZE 12
-- 
2.48.1

