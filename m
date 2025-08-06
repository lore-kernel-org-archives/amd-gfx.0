Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 778B0C87FD1
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Aug 2025 03:02:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE6A510E2DF;
	Wed,  6 Aug 2025 03:02:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xTmjJuN0";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D04D10E2D9
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Aug 2025 03:02:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GKMqLyx09kqQlN/ZkIE6WY8DhUBq7rdiGj2UZ+PfnMphA+ICVyF8wacjwrn2mn3qaJfDdVH5AlLWX+/0wPHBakhzHfpKlJJyai+pTK52gn93CTVrr1czjm06NAxyv5YpvSG8Wtg6m2U/hgn3Jjn8IKtlNYEUkY50VeCr+znSCPavv/PyNwud48pzHM2ceEJOMdZQyfilmfqL5RH4wnL/72YKhtO9QO5IzE6KiR1Myt3B9q8vXReX2td20UixSN8HlPgd/8JOF73YStVIX+D8QatPkACXHw/VseoGjWsYk2onAgG+SV3N1UcO31pcqg3ELBM1sLckx6DH6H88goHOeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CDljUVICCJNG+E+4LtINkGg2a8inTgGz8xrKovofdi4=;
 b=bdZQ70ERC8Y3t7y1E+YP5MdmADLv7meWhFraqcIxdOWaGiSkD3dMeM/SSf++d6xMFxBo3QdgrC/8ZX4h/DaEu5i+3gh84Qmfh2Nn4d3oVLsK5pm+DN4VtudEonFeTehtQA5QAxrU7aGNvToNpD/Lg5PT0Xz1ht/O3Fc++YA6y/lwpfuVDKevi+x7PkwKKD4WLsG3RVQTrjSSp7o++EbDnanAtS7Sq7sL+jNygTKv48Ixs0KHOJG6v4yUvzKBeTYYtziGvC/Kig7T7vlsnoQj0tC2K6dkMbQWp2sFSNsbGYszk/bnJp8oEHyPpOsXlUchnUmtNTiBzxFkQN98S+TaAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CDljUVICCJNG+E+4LtINkGg2a8inTgGz8xrKovofdi4=;
 b=xTmjJuN0UxYKrLeBuoausu+fyPIzzup8Uslc6Xb4LRDf5NjHQKUnWgRMmiKlxOnFhi6TQENS59lnWjK7TLCy5Mm3nLDSIyzicaLjMZ9ook+oilW+XC4xPyZvxiZqkjtYl8/mBJR9P/K0l6U2szyCCTlms3E8q5vFBgkz91R2nlg=
Received: from MN2PR11CA0008.namprd11.prod.outlook.com (2603:10b6:208:23b::13)
 by CH3PR12MB7668.namprd12.prod.outlook.com (2603:10b6:610:14d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Wed, 6 Aug
 2025 03:02:43 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:208:23b:cafe::4a) by MN2PR11CA0008.outlook.office365.com
 (2603:10b6:208:23b::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.13 via Frontend Transport; Wed,
 6 Aug 2025 03:02:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Wed, 6 Aug 2025 03:02:42 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Aug
 2025 22:02:42 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Aug
 2025 22:02:41 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 5 Aug 2025 22:02:38 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, TungYu Lu <tungyu.lu@amd.com>, Dillon Varone
 <dillon.varone@amd.com>
Subject: [PATCH 1/4] drm/amd/display: Wait until OTG enable state is cleared
Date: Wed, 6 Aug 2025 10:57:10 +0800
Message-ID: <20250806030216.21096-2-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250806030216.21096-1-chiahsuan.chung@amd.com>
References: <20250806030216.21096-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|CH3PR12MB7668:EE_
X-MS-Office365-Filtering-Correlation-Id: 6efa846a-c737-4253-f73b-08ddd495b5f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FrZRueeajUoN7lYxr3gVmMYTqpvhZfnelkIq8QMD0O1bOEsno1AcpkC8VVax?=
 =?us-ascii?Q?8huwOdanN56oYAIPjEwi/VsqfIhGMgnyySCtknydMsGD8zI7+WzKh7yRlYBQ?=
 =?us-ascii?Q?Arw5gNw962Z+VZp5fN73NbgSrODrEyPD/iKgyQJd48VZ1bVFtTPtzAfshF/f?=
 =?us-ascii?Q?KNR3t8jmJfxmBIsWeZGyAy4GeQXecA4fvISRiT1spwVfihyo7tEM+FKVgsui?=
 =?us-ascii?Q?eBJWfkq198HN64UpJi8HqUBMgxBz7LBr1CH7RJJ76KRHlyL3VWXToV9G3w1I?=
 =?us-ascii?Q?jqTmv1bLH20eBS9TThnQ0ckKiVBqp9YsLQLozIYiqe7oFGC7w4Gpk6jvFDot?=
 =?us-ascii?Q?V6bNIIAVuOl4mtPBjeY+t2IMHuD2UaXzIt+3ukp3MVMyRn0v3fZHokh0TaNN?=
 =?us-ascii?Q?UcGmBPjcAfotKDe84aZ8v5VJ8uAHKcj5dXWp2qnySy03+WxtRExW8wBgZxmN?=
 =?us-ascii?Q?5XBv1wH7pf+6Q2u4M2JaDlk2exTco/CdDyfYhcAizc/s8k8uVLoKBfBXB3Ki?=
 =?us-ascii?Q?HmUhU1kphi3x5sI8Nk3TPGI3aFBT38/M75M8gQb/DIiXdkGN2B2LiZ9kOYIF?=
 =?us-ascii?Q?4bCLI82cKtqpOBfpS2Q5odTZbH1lKYM++51PjfhWzzz4I5EK8sBDKGpUmQcr?=
 =?us-ascii?Q?Ks9wYfFxJefrWO9HuEDRtMuikw4VfVWIkh1unP8/0Z1s6fg/PLNUAfNIixkE?=
 =?us-ascii?Q?XeufAHHC6Tf3AaFlXou17JphnF8pI0/Lqt/oLxu0Pkqxsv3eCAmrguqqINM5?=
 =?us-ascii?Q?XfQGsfatnxt965KB3nVijGKhI2zDZUUoxrkkmvJR+vPyOWzjXUuB56a0ds7/?=
 =?us-ascii?Q?DhQRUGW/BrD+o9iGTETQjNugU4GS3TzhOiCZn8KgpqUDF2dnp/Sk7YKGQu/x?=
 =?us-ascii?Q?bJOG+BbVdSn3PQ0yK0iFoi32nlpSMtzYl9pUr2TKf3soqgkcUMtJ0MXL7n5K?=
 =?us-ascii?Q?xgI8ePR8egsRVUsHQ4s/EKivFGmIPGhTYzc41f/btiNXaRhzXrbC3NfU5A11?=
 =?us-ascii?Q?WnQ3gcbqQfNV2D/QbvlUQTahA6R240JcKogoH5ZSOVtixIiYLWMUA12EpFu7?=
 =?us-ascii?Q?9yOmCciYpS/a2wUcQCEekCINjJJQIuOKTdsj++sOB6ao5uvZQPDKcl1pxmih?=
 =?us-ascii?Q?SZ7v3+r65hQDMV6HjCunb0OZrAsEUM6pHn9e2BU+lMyHJ2MpstNWCxaC/vI0?=
 =?us-ascii?Q?DXx9w+JqJgxzFwFAlUUKI6Rfoip7TR/mt+jrZLwCFE0lpcvblDpooM6Ns7YJ?=
 =?us-ascii?Q?mbB1Wtn7MN70XjuMLK/syhpidL3fgd5Wvg9VVIl/7C1wnw5KRjCTXOaPqsqe?=
 =?us-ascii?Q?Kc2QvW/UUh+CU4EOut4GnLQgn3yY1IYzMy/pQt0zQyW1COhYvkDylDFJPVw0?=
 =?us-ascii?Q?yaU399WSlhx/HZwQgoBAggVRukXtKPp4lHQTSv10lPH3jIi+bhiVStM+slvP?=
 =?us-ascii?Q?8PUZyVfalgqzomBY2jG0E0a6o+8/pekCTsS2G6HMsuBcBtDMmWFEbNl+GPKT?=
 =?us-ascii?Q?42xh2qnQlPSn8AsgblYLG3IXVXs6sefruAeN?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 03:02:42.3922 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6efa846a-c737-4253-f73b-08ddd495b5f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7668
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

From: TungYu Lu <tungyu.lu@amd.com>

[Why]
Customer reported an issue that OS starts and stops device multiple times
during driver installation. Frequently disabling and enabling OTG may
prevent OTG from being safely disabled and cause incorrect configuration
upon the next enablement.

[How]
Add a wait until OTG_CURRENT_MASTER_EN_STATE is cleared as a short term
solution.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: TungYu Lu <tungyu.lu@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c
index ff79c38287df..5af13706e601 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c
@@ -226,6 +226,11 @@ bool optc401_disable_crtc(struct timing_generator *optc)
 	REG_UPDATE(CONTROL,
 			VTG0_ENABLE, 0);
 
+	// wait until CRTC_CURRENT_MASTER_EN_STATE == 0
+	REG_WAIT(OTG_CONTROL,
+			 OTG_CURRENT_MASTER_EN_STATE,
+			 0, 10, 15000);
+
 	/* CRTC disabled, so disable  clock. */
 	REG_WAIT(OTG_CLOCK_CONTROL,
 			OTG_BUSY, 0,
-- 
2.43.0

