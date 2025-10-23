Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91FA5CCD1BE
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Oct 2025 16:16:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AC9410E92C;
	Thu, 23 Oct 2025 16:16:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aZ4k3N4U";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012024.outbound.protection.outlook.com [52.101.53.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FCE310E92C
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Oct 2025 16:16:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FoZ8GAoHHMu+JJhi0zrCJycmn++W4EbK6A6KJM4PFrOm/hmqy3QHoRl/H2eehy0DqZwCZxPHXPSvBb5BULpygaRDes0LGeCKMHR3SAMLkE/mdctq1ZtSw8foLGx12JQI67rtgdUWaA9SQWRzLVxjyvleNRCSHzyqcaeAyIC3PfeaWIh0tcFI2el1dlQOBOpBKHNyHj0uqFGJNDCrrcrIO0gH74jwdQ53uyi1daWrZp8d/8vjv+Nbqdz7LaRr00oKOlrpL83ps+rZZJt+aGEXMCnOeE3lPVzTKKxnklE8PJyoPYVNraT30CUE7BWKHbSoRnal1NgGq5zoPIdkYVCqYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A2XUjcUxoA4vhuN3/nVx5gXDPfUUdWe+KR17gwQCgsA=;
 b=zCuojz4Q7W73cXIIZIbWrbzA/hHPrOWBfAQlTrObJMTTEHLjzj39Gg0gXrul0O2sht8BMh+YL39eT4vSGXznyfaMZO2GXTmC01WLAuGcGeUYjU8VAVpAGVRFgoC0qy7UOPLvEOgW1qgEUuO+9wuCZWRMeSEV3aGRl+/RcaCofAexf3AGAaDSy0U4l9vo5l+yPV2232UDQJe7/X3IIEycJF1RtiaESeVhhlX6vQFaAdqRKX3pFv/MB4Dkqb8U7LjKYZdz+UkxH/ZN9f60Fx55OqhlZ07tpyEXgmEF4q6dWJ/QXbz/SBLfMHqtw+R4+C0ss6ajnLon69bfcPdHFDRXYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A2XUjcUxoA4vhuN3/nVx5gXDPfUUdWe+KR17gwQCgsA=;
 b=aZ4k3N4U0L8wbzYX26YEvxVvL2rTJYk3yJiMr9Xz7ZIpS062X+drVoPABQ9DWBi9y16qBMh1PnC5Y5KgSqTgWoYdtJx+A6IHnNHkEICsYMxIG6DtobvNkUe3nIwqqbeBTkTEyAUwv4lQ3d8qQjlGDUBLbLE1LDZz4P2Lx4X/aXA=
Received: from CH0PR03CA0219.namprd03.prod.outlook.com (2603:10b6:610:e7::14)
 by BY5PR12MB4226.namprd12.prod.outlook.com (2603:10b6:a03:203::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Thu, 23 Oct
 2025 16:16:33 +0000
Received: from CH3PEPF00000011.namprd21.prod.outlook.com
 (2603:10b6:610:e7:cafe::a6) by CH0PR03CA0219.outlook.office365.com
 (2603:10b6:610:e7::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.13 via Frontend Transport; Thu,
 23 Oct 2025 16:16:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000011.mail.protection.outlook.com (10.167.244.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.0 via Frontend Transport; Thu, 23 Oct 2025 16:16:32 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 23 Oct 2025 09:16:31 -0700
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 0/2] Unwind failed suspend
Date: Thu, 23 Oct 2025 11:16:17 -0500
Message-ID: <20251023161620.270811-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000011:EE_|BY5PR12MB4226:EE_
X-MS-Office365-Filtering-Correlation-Id: 9029abf3-37ef-413e-bd74-08de124f881a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IZcKi7JdzhoX2w00yoTMOjO5T8y1kyFTBM7Za/I4lJ8DKDC0LHZKAI+saA8U?=
 =?us-ascii?Q?XeavSQRzoI90fNGqRtS3Bq1QBJxh3W63i9SV3PU7fuMTmQYxavCYTD/Cqy07?=
 =?us-ascii?Q?+5yjY28wnDFVhdcL+5rv/tEmPV0nA74AGSV9/vJHLr9uEK0Gtm1CD1bunAkN?=
 =?us-ascii?Q?Jypt8gSOlpbxxQ6OIxNc+TjOyTImPSvQp20gFH9DaiTGCAQVJj86b96GDbEL?=
 =?us-ascii?Q?hYdlt55huZO8i9BM4kCmUvT0glwZJwx7Fz68XPrMj/lvilFYSgRfKAGFBtrn?=
 =?us-ascii?Q?2yrArhQ08TakJIVyHafPffbhGzFmN2blmXavLF0JWNBxsBez/CsZd3VuSEW2?=
 =?us-ascii?Q?h7OIogFC3uPiNsAe1uO0qXPaa76/Xk3gS4h6BdDyLbHXpFDTPiFklFSLmOzq?=
 =?us-ascii?Q?4Z5XIJlWxiXG3xy8riuGxn+kuFI+uFQqCeckzCuSEWrpFD3bKeA4HFuw97rI?=
 =?us-ascii?Q?V1DSf+MipWc5cJLiMLtA5Yl84ep+HaYuvxh56upKGlO6JR85UAIj1tg1jPMj?=
 =?us-ascii?Q?1JRY37wkoOsKIm+TSvuMU/jb2PUGMk1TYkzSDyd8LL+LP2BYCTqPWeMYEQzE?=
 =?us-ascii?Q?1+VQ7glUwVhBVryNAEWwBZuBk3Ig3PeH5l/u3v8BLba+WlwEtipYvL/RBPZk?=
 =?us-ascii?Q?rFIGxQdiZNCur+N3UHwG++Kz9kwmwgHI5haiprACrnNL+jDmN7p4M3edbn9H?=
 =?us-ascii?Q?sPn2dcFmuf/R2h0dGoD2V3qCBB4GjXr+2EM76AirFZbrgYR5JkeTPVoRJ7rT?=
 =?us-ascii?Q?HHXwJaEa2tm3hxccq9m7smRscIg6i/QEjElNExt2+A4D3Jh0GUId72N4AFAQ?=
 =?us-ascii?Q?0Mm3pZ9bgYnQO8PqEBdUOtmbiir5uWlgF9oeiXISeABTE81vXBRfmUYXFqJZ?=
 =?us-ascii?Q?E6pbr2Kg+UZdXj/rCBOolt1Yef31677ISS3fvK31ZHX/a56hT90WfNc0X3sd?=
 =?us-ascii?Q?UfkcpOm0YBKTiFjG/9UbQUOAOHkbbiRRemw15Bvq4ONOx0FJxmZaF8DQtfhn?=
 =?us-ascii?Q?LiLOS67A95BNHHvBkM4KvlhJw1SKUQGcqM/UyK4ziHpPD6X7YKlaVjSoYe9Z?=
 =?us-ascii?Q?8Z3r0sjgVPh9AWz1mN2M6WR4W42IPnQgORjmruG9/CTC6jNFBdc/2avKAKaM?=
 =?us-ascii?Q?R+DgMZogDltDcyw0i/Bex5SbNyyESVYrl/yIfypP73/UHIim5sGZPir7Tj5D?=
 =?us-ascii?Q?n247kmGtRmUHYmKGoq2/M2OsSf+8UV3LavVUK4QSwPfvIdSRHQVwzsBfEQCQ?=
 =?us-ascii?Q?oqjEKDFrQW+hjUsOfMNtsbtmMktnSkAZr/ICIZYMkKSqb2T1pY8X94nXrrjy?=
 =?us-ascii?Q?wpcT7MO0nRBFKRRxNjFqrfIxb2iJutmQ3MmBOYzktFeOIsm+qYKS/0RYtGAD?=
 =?us-ascii?Q?rjGMgIA6jh0ySHp3ZxOazVs8DzvXRGNjRx+b3pEZQ/4ya6li6netyjq3hPRh?=
 =?us-ascii?Q?5PxiPSMJu3nuNOO6hDhels6PYCcjoAGMQeXni7VO/VA6BHMpL6CdiBR07/Km?=
 =?us-ascii?Q?fTid2iJ8J4Ihqpcx6HAx3YJ1n3Qcck87aBbFP7Ausq/xhtEZSB8W7NGhlBgi?=
 =?us-ascii?Q?PyHu8LsuhjAD7EX+KA4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 16:16:32.7761 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9029abf3-37ef-413e-bd74-08de124f881a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000011.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4226
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

If a suspend fails the PM core doesn't clean it up, the device
is just left in a bad state.  If this happens during memory pressure
it could be a hung system from just trying to suspend.

For all phases of suspend that return an error code, add an unwind
flow that will resume the parts that have failed.

If this fails, then reset the GPU during complete() callback.

v3:
 * rebase on amd-staging-drm-next, this got caught up with [1] which
   was on my tree too.

Mario Limonciello (2):
  drm/amd: Unwind for failed device suspend
  drm/amd: Reset the GPU if pmops failed

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 80 +++++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 11 +++
 2 files changed, 83 insertions(+), 8 deletions(-)

-- 
2.51.1

