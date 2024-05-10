Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FAECC25B75
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 02:54:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59CD710E1BA;
	Fri, 10 May 2024 02:54:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0a+R+n24";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C32610E187
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 02:53:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FG9Z15HlSqXNOrbLp0btslPIltSrk9px4ACl9ubvFX70B0K0pnLKv0qYEaD/673gd400nyTn6EPkIHuwmnPPqCdNbj5sqOP100k5rq9qMfMAlO3ipXFUiJMUaz1gXr+gwOF+zHTdJjUUNuUUnNz85D8f3QXv23zCWqwrwFI80x3fGvZHtV/eaGAjxTj9/45wYqho1Bla551vBTNKeQlTPbDbX9Fk8temSdlxpbcILeD5wKkGdsTZzf1hdWcD8CSr871j86tQTvoABLDUwbqtnrxn172g1UHWoUhWpA7ZAcUoc6SjAVNPVtUuuZZdScGigNzbLjnYLt0Ebz7fvtymyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+aLVnXQIsm9NNQh5S8xoB4l9PUTvUrfK668Yf9HPZYs=;
 b=SNEsl6lEU0PWzcujbu4e7BF5nIAr3iPqlWAMVsL8MZUWU/lqbsAN3tNkhNWxUVHQIoOpic3SguW03qJyGqEGFcyoqVG4OHRUWqm45k0x4Yjyznxs9N9MHcQAAThIvtWe5hg/K8kvgRjF3A8G6ze9LYnIU2LwE8bKyBvOWiUI4T8jmRm1DKWf7aGZQ9afQ8ebEHSkPo+vZRju+okj0snuSbaEKh1iAqy5Sti+lVrcQLpTph1iWadA72w45dXuVINn7BkaY4E5g8iyWlxmjgLXYsIlDaw7wWZx+aznphLuphBWwH7cDWSJvYbWOOaFycJuU3uOE6TXz+NgV0Gfz4nqsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+aLVnXQIsm9NNQh5S8xoB4l9PUTvUrfK668Yf9HPZYs=;
 b=0a+R+n24c32s/oFKnqppWBdiSlNIdVWQTQfcaFwJ4GTd6gTwnSR4dgrItx3nQhtBasWqoIJo/RowNL0ZXNWQM+BuVOIO+iICG8rl+aB3nA3jk5C8G/LU7eGuSBTmizPr6zEcKzUCkC5MNi3c+5hrUt+VfZ80mfdbL1YPgCPgfDs=
Received: from SJ0PR03CA0197.namprd03.prod.outlook.com (2603:10b6:a03:2ef::22)
 by LV3PR12MB9440.namprd12.prod.outlook.com (2603:10b6:408:215::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Fri, 10 May
 2024 02:53:55 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::7c) by SJ0PR03CA0197.outlook.office365.com
 (2603:10b6:a03:2ef::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.34 via Frontend
 Transport; Fri, 10 May 2024 02:53:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Fri, 10 May 2024 02:53:54 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 9 May
 2024 21:53:52 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 9 May
 2024 21:53:19 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 9 May 2024 21:53:12 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH 12/22] drm/amd/pm: remove logically dead code
Date: Fri, 10 May 2024 10:50:28 +0800
Message-ID: <20240510025038.3488381-12-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240510025038.3488381-1-jesse.zhang@amd.com>
References: <20240510025038.3488381-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|LV3PR12MB9440:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a97a59f-a0cd-4169-7ce4-08dc709c6e66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|1800799015|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wvIN1Am48ccavuNL0K2A8l1TQyYKIiHWyCK3LulMYCvYQ/T0X8Pa35nGGvtw?=
 =?us-ascii?Q?KclwoBB4O6FcJD6BtwXX5Gtsr+Q6Sx+W1EShvNmUX62kuIHlDk1QzMW80fSy?=
 =?us-ascii?Q?HZGWoxUDrem2VDdYdoaXV1szIjuLyQRA3APIQKWxDirRcP2m2fnEYMxJv8LA?=
 =?us-ascii?Q?Dh8Nt5GAY8xhsXmDYH6waUf9810xkwLhyuhsDaJOg9vKOZ5Zkv3i2UcufPLB?=
 =?us-ascii?Q?GKA0OZAEzdveMhd40iKH5tjqP8KtWu5FHS5OfUWM1TY7deQS3VSGjqn038Wp?=
 =?us-ascii?Q?xox2n0ZAzeDb0ekJt6GYfQp85JheLf6+AmxyGodTNtknPxxnuJ+A5bnfJGHu?=
 =?us-ascii?Q?0kM60pD6EVN9eQz1gPOkoeo6cTMLakyu2RAoGwYwHBGw1iWYzYD9N+n6RSlB?=
 =?us-ascii?Q?Ohtr4dKLy9yxDi4QB24joRsJPUh3vm2jp8/z96toPjEQ7mqzbrN12yTj6m8B?=
 =?us-ascii?Q?Q3PgoWXoBqH0wa/cKbxuu6U71VZBGp/DFg36DwicAuoeVC25jPuEZBrHGNjI?=
 =?us-ascii?Q?CWk8xOEgHqEHtl/Lj2y1tpP2v7bQAg7Zsa9DVUgne605iXXHMUvaS3r49Osl?=
 =?us-ascii?Q?Kd4Sm+FqgArMsBmRvuJO/JtNEyOcIWVHY+OyeyxQ3Xsg5MRJIqZouRBBpr+d?=
 =?us-ascii?Q?TJ8rXTo8IBbYTCfFrKoMtMhT0F990sWQE0FiJtsZk1oTa9c8ub3eJ3Yrhjuu?=
 =?us-ascii?Q?xb170v/PB3r8ORYboaM4i3Brk4rd9PYe2CQ/J/7JsC/oH8YmlqdWmwseTfH+?=
 =?us-ascii?Q?i9zd57Evsg3dkBW4Js88xuhq85ak8gOrRF7dkuKYTeG6YijVdRnb6yYBKaoW?=
 =?us-ascii?Q?VBJ3omCAJrLeuW8ufb5DCK/ubfP5M/WINggV3UpsX8GkGRvTLvT2BOx6rQWJ?=
 =?us-ascii?Q?YpA4xMGH7U5EQW69og7+rNKQJxm6dqrMVZv8BuS1QxCck1UJhBoIvMXlgAPU?=
 =?us-ascii?Q?mqs10pDrCVo9RzWcX8EPu1yd+i8uK5VtzJXOULJLTa0mtiKqD+TlMITeMfjS?=
 =?us-ascii?Q?Si34BwsbiZz7Ptbqw7lfXCmMh2Na9O8OAWrW7oQhGeJcEQAvS/WJvjbhpbQ4?=
 =?us-ascii?Q?zJ1KNPp3yVV0Co1dKhubCk5P/kMQh7O+MalS5/nPDCzOdxv6BFJJjTXy07G8?=
 =?us-ascii?Q?4g1jenxL7IoTuTDt4b9BP3xr3J1o+CnbDNgIGo+0bYprS0RLE8T5Pu0PbMXV?=
 =?us-ascii?Q?k6BJ77O2WACFlIafLKXJridCa7OR4wqKST0GSOSLPtQeeI6JuRbnPSOjCpHk?=
 =?us-ascii?Q?+wNvyQzgKm1bColGvafMRVlApfLXyWyOc2ZKreoQmC6+zIub6a/NzJ5Vwd8B?=
 =?us-ascii?Q?LyRD+ldQpceTQ7sLzuXgPPRic6JugIo+B46cqvinjng8EI2oQSm5UcOG5jSg?=
 =?us-ascii?Q?tE2E6aY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(1800799015)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 02:53:54.7937 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a97a59f-a0cd-4169-7ce4-08dc709c6e66
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9440
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

Execution cannot reach this statement: case POWER_STATE_TYPE_BALAN.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
index 60377747bab4..e861355ebd75 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
@@ -831,15 +831,6 @@ static struct amdgpu_ps *amdgpu_dpm_pick_power_state(struct amdgpu_device *adev,
 					return ps;
 			}
 			break;
-		case POWER_STATE_TYPE_BALANCED:
-			if (ui_class == ATOM_PPLIB_CLASSIFICATION_UI_BALANCED) {
-				if (ps->caps & ATOM_PPLIB_SINGLE_DISPLAY_ONLY) {
-					if (single_display)
-						return ps;
-				} else
-					return ps;
-			}
-			break;
 		case POWER_STATE_TYPE_PERFORMANCE:
 			if (ui_class == ATOM_PPLIB_CLASSIFICATION_UI_PERFORMANCE) {
 				if (ps->caps & ATOM_PPLIB_SINGLE_DISPLAY_ONLY) {
-- 
2.25.1

