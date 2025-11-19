Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 595B4CF34C0
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Nov 2025 14:51:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC9D910E64A;
	Wed, 19 Nov 2025 14:51:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ErRwploq";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010048.outbound.protection.outlook.com [52.101.201.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 684F310E64A
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Nov 2025 14:51:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j3VjH4awqqbCAJt9g2dqtEGRejfh+uJva1nMeoRgPByvWxMsaSjoeYGPUK1Mh3Q6Q3sFXyZo9aB0V1/qygovAmP839uGJEQE8WXeJ5gKjhZTMRVCz0kuQ2cevyeiaENrOmU/MCU6Dsl0kxk46cXOhsQYhz958ia5JYfDg/j5aa2eChF/hq/BiGrwU11f5RgmIgnp/oW+5tboYiqBJk/R+ev05WiHKqMFRwxmHb08iyAd+M1SP+96cp1l5ntfP5sVonwGyqhSNeH+iaCLvB6fLUdylkzcGtEAbFKMO1bDsZH3OeNMia85Ptsck6DvZ20+ZXAp5T1KsnFoOvxr9R9aRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3KsAC3c7nbvHLgeG/5kWtfuxjXHILkIWKLZggYSxj5I=;
 b=Wn2KPR168MRTLpKF/M5GsG0iZKkf030iuSGLL9h+/3NvCobshEuYGTUF3VmWCqCechbr8hAXCyBpyx5MDNSPU/j8WBw4BUCdY/rEByvv+91rH+GW76Xos23u02bCytytz301UL+rNeD0gUbfmCAXd8fPnQAxdIERQm+ne3i1TSQ9NcevG5xYPoM6U1/JEbhGeJj+QxLzFF0WINTK+LI4/r8JgQiL/JySFExX2/mtUKIX1oLqlhtWK4PctdOYUjNNaAEdvqJSc7R3cNPqx5y0bu45wNZlxSdoUxZFHSCfT/1NONmd6VxsJTB6d0e/CwYDiCmlQ31hZxwcl2ggpgKVEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3KsAC3c7nbvHLgeG/5kWtfuxjXHILkIWKLZggYSxj5I=;
 b=ErRwploqz1qrGQ0s4m6Xb2QEbzY8pvllyj1yBxfysc4Io0RE1oWiUW4K2sA2rKpnDhIOJbh65g24uO5Ul4LHewacOVgBDoE5ee9NC2r03jiW7TqKY6WcVSeFhk11b3C0QEBx2dBNVPJFFwZvMN/CxaHlUy/adqoF4YrpkDsjLFA=
Received: from BYAPR05CA0029.namprd05.prod.outlook.com (2603:10b6:a03:c0::42)
 by PH0PR12MB8149.namprd12.prod.outlook.com (2603:10b6:510:297::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 14:51:14 +0000
Received: from SJ5PEPF00000209.namprd05.prod.outlook.com
 (2603:10b6:a03:c0:cafe::71) by BYAPR05CA0029.outlook.office365.com
 (2603:10b6:a03:c0::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.4 via Frontend Transport; Wed,
 19 Nov 2025 14:51:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000209.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 14:51:13 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 19 Nov
 2025 06:51:08 -0800
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 0/2] Add MMHUB 4.2
Date: Wed, 19 Nov 2025 09:50:45 -0500
Message-ID: <20251119145046.3662996-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000209:EE_|PH0PR12MB8149:EE_
X-MS-Office365-Filtering-Correlation-Id: 7616e0e0-ffcc-49d2-a13a-08de277b162b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GjfbQeSZESdPtk4LS0uJByfwPYUt5HS6Ta5u5AKhUEFcH01FcoGYMfnToPxw?=
 =?us-ascii?Q?H8pBjVaWNSp6V1RQD2/HVyI90mpLm1z2uwPohYXmrWIxD4EfiutrXZgB3y5T?=
 =?us-ascii?Q?qnlg3lbsSx0q4gdsLtHtxVSYKoGtp9ARncn4M9gkEWz8i9S5NOUWy428vPNF?=
 =?us-ascii?Q?7e+k6MtScwkOuMgteWWtsqh0FebyzF7BbHxRnpq90dVD2S2Qio9MxiK8e7SE?=
 =?us-ascii?Q?2Ad//SU3E/EeJ974wqWwDQWvbzidA0BZwcerL2meR09FfZHdbUKkTVD0dqxw?=
 =?us-ascii?Q?7SYTabr7TSK6x7X9GrHcTAcNigHBHC07N5Lubzc5sHcbtpL9PyOuO/dlhFW2?=
 =?us-ascii?Q?lqUDvJl/yYGrpIX+QaZ1zKq833E40zCzYOc/Vv7N8kBKpWOGlqF5RwP2X/SA?=
 =?us-ascii?Q?8YzJfOQ6IRT63UiOeX5d9b2lmSZP+ypwhJeL2Y9Eg+AkwxiuV7MDbZ7TP1rw?=
 =?us-ascii?Q?LfEJbGuxPq0AIli/6pdZm56LOmcf5/pHgfAFsao/XmwlCEG4DdPvggS61h9u?=
 =?us-ascii?Q?IABqxuChjyXfn5EJscVqECT0Cr6acCjj6LUWNyBwYdwbBFjCC3zjOaVuzzPZ?=
 =?us-ascii?Q?tn3lNTEnhXSGuOyByRYss5Y2zcEeFS7my9ffjwpzzu4szji3UwQOXMEq1cjk?=
 =?us-ascii?Q?dTxgOdMMGeaJ5xk6hOZ8kYBzw9ppWvGZcAoZj5Hi5DHYHGazKHL8h3AViapK?=
 =?us-ascii?Q?X6L09Nq/ulaSJEc1iLpI/XWzbeitR1oCCrr4so4OYrm/g01WYbyLO6vCIksG?=
 =?us-ascii?Q?nTxH+SeYBtsWN+FI9n6esn3ww4aY8pnRC21YZwJxi68AEtj0vvUMEi9eEvJS?=
 =?us-ascii?Q?xrPgpIKk42L7bK64JnQEwJoZ0uarhGRZuRqUh63WX09lcRhGnuETh/1QXAgS?=
 =?us-ascii?Q?mHsAkGJ76AekAbCbKxNbpffjruCq0eo37TcKlnJYaKhrLz5GLWG3waiXjbgK?=
 =?us-ascii?Q?94SXbYpfvsYuzrIAHwewPOKz4QJkzzcb7PSv62k2rLQICt+DXc06LHq+R2Ji?=
 =?us-ascii?Q?vZpeitxvwDYftr36uF+MZBsofjpTBTFL/rxW8/V+A4WeH1Lsg2qXAu/NPHDL?=
 =?us-ascii?Q?vrEdox21RcQeQ6RekQa526PooD3upLZuFvva+LvR8ZsCsS20kRUn4O7eOJkH?=
 =?us-ascii?Q?dSsF2v0niDLSUQQy41/NCGeBuza2ifg0rdZTnr52bhYQ0kTGAFyjt96LuEES?=
 =?us-ascii?Q?06qf1iKm5Sw2Erso/xmVIbUc2DWDPMVSvlgg8MxzquMZgC6907MJcCkdvh58?=
 =?us-ascii?Q?WAwaUKtzadKuGQhmxIVeFljkOadPRr/eTrxySsfH8Bs4T8slmju7jyBiHQlo?=
 =?us-ascii?Q?isSuB9dLsq1AXT7VRKXDQ/wrYikS/HZjSRm8mqDkGd+o5hz81YX/AYv8HMfa?=
 =?us-ascii?Q?R2xgcsWcQn0EiVTsAl/NHEh2F3fgEWXUvjOfGqiCIDuzaB9g6g78dRGvcU6g?=
 =?us-ascii?Q?l6J7wUtw+zlmlhXEVd1ViVkG7dctP0zXAdY7X0K7nSvCjydqSeORMSYI+lQJ?=
 =?us-ascii?Q?2pSAmhoaAo7ef3gDjYKH/aSN/sjqxaw6BwzgAYfoEbeo9wGKKuAep0kOEP8z?=
 =?us-ascii?Q?sdhiAdP3pDulTAHfYrI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 14:51:13.8898 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7616e0e0-ffcc-49d2-a13a-08de277b162b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8149
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

Add MMHUB 4.2 support.  The first patch
adds register headers and is large for the list.

Hawking Zhang (1):
  drm/amdgpu: Add mmhub v4_2_0 ip headers v5

Likun Gao (1):
  drm/amdgpu: Add initial support for mmhub v4_2

 drivers/gpu/drm/amd/amdgpu/Makefile           |    3 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c     |  913 +++++
 drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.h     |   28 +
 .../asic_reg/mmhub/mmhub_4_2_0_offset.h       |  802 +++++
 .../asic_reg/mmhub/mmhub_4_2_0_sh_mask.h      | 3013 +++++++++++++++++
 5 files changed, 4758 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_4_2_0_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_4_2_0_sh_mask.h

-- 
2.51.1

