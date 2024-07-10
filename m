Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E08CDC3DA41
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jul 2024 19:40:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84E6C88D18;
	Wed, 10 Jul 2024 19:40:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DdS1Czmm";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85C8910E8C4
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 19:40:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bm6hii5LEEt9p0xPPD+8qc2cz3nUrgZRSFiXTfDhXPLTrNql0YNpbZ4JYwucGTPTM8/lLqmynIuUQ+p1Bo91CqRXErHPaLJ73/eA8aRxbSig5XGU/7a59xgl9noGcKrkFV6hCqnIO4XTnkrvMu564ju+eS/GhhOaIWi/rsppAUkcwlQzmCSIJpHB4YyuGmF3Pv2pua97zJqpQPGrEyA/yFM8fG3XQGm0v9rJXJ3PRD/ppSLwi+Tb6QD0X64HYQhGNqAKa9qGIyb+SgB65rY5LZk4mNZIkp1kBvBSE3TajW3YcElh6Wf/ZLFaCipAp16bTOOrryopS+m6x5zL+EdseQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UZ8Mfo0Fyx0lC1Zma0UwvOKKXbIN4o3Zz4M5IVeC8W0=;
 b=Yk6l51CI4wSHRgJI4ng/7EXgi+dNZFIvq85TWNgjJboWo3fGPGNL3uNrK/vilnoqO8ESWBi5LEYStrP/yv82XTgAjdrI7syjwA5c8lxpsgcYObnvybvrSSR8D+HcrNloh1QvuZn96g+e0i4Rhok+DwdON4UAzxAmrM66OoSLp101h2ISyyQODDDchFiV6HIJ9PPJlu6KBeEe19obNBiTLfC2Wd5TkNnVdyCrMqHWBzvqKmE5BjPuUoGY/ShrGAUhd95m661dp4n22eS/C8QkPIGV7SArYlR+T3NEqO+lHxvZoqumj51o93wfv5lX7a41ddxXDtzoaNMnaCGUTA9huA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UZ8Mfo0Fyx0lC1Zma0UwvOKKXbIN4o3Zz4M5IVeC8W0=;
 b=DdS1CzmmbW1Igw8hoeQUyQq8YJgc8pbTSmo69MtcBPSWc2x2ghVX9Fff/d0MElebdOy4kmCWpzhlXP3KkBBv4LKZXNEgD7wS7oksQrRnKeMq0jxcBxXRSRjZ3hAu6hJ+fq1I4a79uhhzN1KyWqa5z/gsq8nFvt6WcdsY8A3nTL0=
Received: from MN2PR06CA0001.namprd06.prod.outlook.com (2603:10b6:208:23d::6)
 by CH2PR12MB4120.namprd12.prod.outlook.com (2603:10b6:610:7b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20; Wed, 10 Jul
 2024 19:40:14 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:23d:cafe::7f) by MN2PR06CA0001.outlook.office365.com
 (2603:10b6:208:23d::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Wed, 10 Jul 2024 19:40:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Wed, 10 Jul 2024 19:40:12 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 14:40:10 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 10 Jul 2024 14:40:05 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Alex Hung <alex.hung@amd.com>, Rodrigo Siqueira
 <rodrigo.siqueira@amd.com>
Subject: [PATCH 38/50] drm/amd/display: Increase array size of dummy_boolean
Date: Wed, 10 Jul 2024 15:36:55 -0400
Message-ID: <20240710193707.43754-39-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710193707.43754-1-Jerry.Zuo@amd.com>
References: <20240710193707.43754-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|CH2PR12MB4120:EE_
X-MS-Office365-Filtering-Correlation-Id: e8ed2063-70ca-4290-4c76-08dca1181d72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Z8Bs6GKmkd2vVAmfxm/7blAz1xLHXaVaN8W/thvJbnW2cChz1pQ94YJ9QW+a?=
 =?us-ascii?Q?1JSQHkxufLR9iHOYdB8jrYyz3602Qqxq0G6F/sinrHOBzZFKJHQgp/x/oiKl?=
 =?us-ascii?Q?3QOK2j8qEF+eqJTTWjRgdu9wamTIknPnSa9PLV7YEa8/FAq/vg0zcwZQH8tK?=
 =?us-ascii?Q?bSHa/SSt50NSEcXF9Z1IuGUTILH1UIMREcVNyjUfWK9/ii+NdOCh8/ACorNu?=
 =?us-ascii?Q?nc/4D912st6A49ubpjXkUuR5hYpzNLTRmyUf1xb2qNjeXcwDw5YJwz1zY/t/?=
 =?us-ascii?Q?JA41JN93uThMfDWhLTn3ji7bCP6TmFfZvdLZAAH27VwD3yXrwQEff9ZR5khB?=
 =?us-ascii?Q?XgZjmSVhqozzw6j0yZXK/ojYYSspuFd8bwHdhVnS8/sTP2I84D2dIL7SygcT?=
 =?us-ascii?Q?22vvUZOrhdH7IVyTKBMmXANKGvhEUoXxmY65upkFqE9CB+2uDJW91uTi0DqR?=
 =?us-ascii?Q?B2G73Jh3YsITPy4uLMWtcOgRlYrCSiV87IM0A8r/rVzhFnd+8gQqhSbORAd0?=
 =?us-ascii?Q?Exm0O4lYXYEwmN44EH0c0rMZUQREFUPpAmszBJJ3GebScB9803Mz7Cp9RIQs?=
 =?us-ascii?Q?fbtdfkZOVwIUvDm+YxaBEIPItGFidfg1lXl88P70ioZATHwx0aBMw3zwW+5c?=
 =?us-ascii?Q?tm7h6n5nFlVmfQIBl+LIMxD+DSBD3m0mf+A1NaArvLgS/4iqrXFtHsXZ0hGP?=
 =?us-ascii?Q?GpiOpK3wqM4mIs6tBNV3OYJD8Rs1sDNpUsT4wgA4ufrYtSPT8EhZblTfNOQW?=
 =?us-ascii?Q?zbyto6LBt0YTtA0YrB+whqpqjycyvKOYXDGJjSyMgGMW6w/Z9lwwCl/WOMUi?=
 =?us-ascii?Q?K0Qb2E+Twu9g/M/6fQeifStC10PKIy0qX1DN9dMuv02TOguW807mVE+MwKri?=
 =?us-ascii?Q?z+1u7NLM/f3PzyQVpfdkcpiYJ7KEqQKScpsQEtPZyPipU/Er+hVURW8c+hlj?=
 =?us-ascii?Q?SAVsEsc9k3AyA5s2sm6apfIYWqSPPggSk0hZGBUv+goqTA9FXa+abG6QA6N5?=
 =?us-ascii?Q?x+72ue9OaZSPB7hsTLmjm4lDzPjAJ8Lml6RbzkuHKQ+Bo8l4u3/HMDguV3zU?=
 =?us-ascii?Q?CLw36UIOF2zM4u5pss2fTqe5RYjQ4f9GtZyTzHewFhUTGDe1Qgb8OSglr4f6?=
 =?us-ascii?Q?Vn4t0TyOFejCcQ4qxF7Ug5Md90uyIPTh4GdS+vXiEWbjbk/Ysp9GWX8yUEVx?=
 =?us-ascii?Q?FuT4Abr7gQpaw+OvdoiRgzTe2VWCDroJylYJ5a34DpFPhK2Er3sKDFZZA9EI?=
 =?us-ascii?Q?Ph9MzZexB2c8pwu+gRBjqAK1fWNFntrS4yO84Vg6CmQTxmmKKeYdso0O5YVm?=
 =?us-ascii?Q?kWBj3mF9faIrL1ursosv6Nn8qUucMTIxJ44n8w8ckc09GyOhlYgNeqDik3wJ?=
 =?us-ascii?Q?XrqJ2I0rAE5qB1sbL2MH+fOQN3LlzprJ1cU9epzJsuzvxJgxK/QvQBuA0Ekm?=
 =?us-ascii?Q?Is+ql+9dadhwa9MGdL4ziu8QoYI/dcVO?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 19:40:12.2428 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8ed2063-70ca-4290-4c76-08dca1181d72
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4120
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

[WHY]
dml2_core_shared_mode_support and dml_core_mode_support access the third
element of dummy_boolean, i.e. hw_debug5 = &s->dummy_boolean[2], when
dummy_boolean has size of 2. Any assignment to hw_debug5 causes an
OVERRUN.

[HOW]
Increase dummy_boolean's array size to 3.

This fixes 2 OVERRUN issues reported by Coverity.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../dc/dml2/dml21/src/dml2_core/dml2_core_shared_types.h        | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared_types.h b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared_types.h
index 02498c0e3282..317008eff61b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared_types.h
@@ -866,7 +866,7 @@ struct dml2_core_calcs_mode_support_locals {
 	unsigned int dpte_row_bytes_per_row_l[DML2_MAX_PLANES];
 	unsigned int dpte_row_bytes_per_row_c[DML2_MAX_PLANES];
 
-	bool dummy_boolean[2];
+	bool dummy_boolean[3];
 	unsigned int dummy_integer[3];
 	unsigned int dummy_integer_array[36][DML2_MAX_PLANES];
 	enum dml2_odm_mode dummy_odm_mode[DML2_MAX_PLANES];
-- 
2.34.1

