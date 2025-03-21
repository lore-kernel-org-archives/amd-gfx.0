Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FFE7C35FFF
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Mar 2025 11:37:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E330510E7AE;
	Fri, 21 Mar 2025 11:37:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iS4ULlrW";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA18510E7AA
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Mar 2025 11:37:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L3hxcbmUPG6ynBG18eJaL9/MxT3KreZuqd+Pg+JID4hprWH16CH6VaNX5jmJioQBN8x/vKuqHTFuUGhuJqFcZlhCV5rlDmnZonE8EWhFXHJC/Rv5lbNWa3DYI/t4qWsb0yR8U3s9F7k/Q2zkVRS52U92Dh2h5sS7+/cHlHdlG4rFpO5Vv2vjz9rnecLTvK9CVf3s42f4hdBfwcx2RteDrv8AZeH3T/3y/PjxUtwxhEQZakSrxQ93SWSOd+ZIu90+wDmVzwAUSmUfkhAUAoUom556nAzKoxYTbP7h/Y1JPekY6+M/QU7e5EDlA+53aqiwcr3mZLxX8j2jXJiIeTYiKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EUimR9cV43LiYHU0C6OPXqby2gUfuXtEiecCwwcG124=;
 b=VeIXaTq0soZfUEDaKuY3uIdfQYBpegx0Nj/p9xlSKIugFhsgPB0tY83QdyV+T3XAe8ugYNiuAhZlWyD8SGa7VNaaoh2r08Nruc2tp5j/hJsvHOXVLuTM/t559VSlKhxTH+JvSFrRVndUJY57lSOaXE5zneMPkOC6GwbcMl//rH4JbZLazM/jgmPLr9qarcDDytdHJixQVxNgMRgx4RzkyI3u0kcKoIjYFk1CdCUJw9z1avq5lhXyYi3yP19kkYcLWS4v+FeRiDhnRoKenBuFhAx4zUmzuuAjJl/Wm/IruelH0p/HCSjPODUAAUDmgZUcDREd5PJxiWRmB0DaQTQIJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EUimR9cV43LiYHU0C6OPXqby2gUfuXtEiecCwwcG124=;
 b=iS4ULlrWF2umT4+evddP62tYojZ6Mv8DV0ypEcnYLb2kfJAH07LNgyU3R2T0BkcE/AXutc6OLjfmTqFsrzqUpDYJ8EUuHJnYPiXWdWX7HoqoVmLnJC7nzS77Lafbr9aE2kp1kHfVfcf8OFYQgyyrCmA+gdvseFak0fhsk6FnO1g=
Received: from BLAPR03CA0078.namprd03.prod.outlook.com (2603:10b6:208:329::23)
 by SJ0PR12MB7460.namprd12.prod.outlook.com (2603:10b6:a03:48d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 21 Mar
 2025 11:37:21 +0000
Received: from BL02EPF00029929.namprd02.prod.outlook.com
 (2603:10b6:208:329:cafe::d9) by BLAPR03CA0078.outlook.office365.com
 (2603:10b6:208:329::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.36 via Frontend Transport; Fri,
 21 Mar 2025 11:37:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00029929.mail.protection.outlook.com (10.167.249.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Fri, 21 Mar 2025 11:37:20 +0000
Received: from saleem-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Mar
 2025 06:37:17 -0500
From: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
To: <alexander.deucher@amd.com>, <Christian.Koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: <aurabindo.pillai@amd.com>, <mario.limonciello@amd.com>,
 <alex.hung@amd.com>, <saleemkhan.jamadar@amd.com>
Subject: [PATCH] drm/amd/display: add proper error message for vblank init
Date: Fri, 21 Mar 2025 17:07:04 +0530
Message-ID: <20250321113704.390163-1-saleemkhan.jamadar@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029929:EE_|SJ0PR12MB7460:EE_
X-MS-Office365-Filtering-Correlation-Id: c75ade67-2fc7-430f-ea84-08dd686cbd7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Z9C9P6akoWmREeJI+XJbviFdYvyzkSshKdyTJcvEJoR5xFPpoxetBYPxDpV1?=
 =?us-ascii?Q?MquAd6xx6ywE0zxc+zgMHJgq7AGnodPXEVO7dmHeAACeJxrO+d0PEBKhZVBf?=
 =?us-ascii?Q?wL9KrgymoqtP/S1caH2tVSpfWJt7+0dsKMGVAu6ym2XLRpmhrCGuen3ZNEBD?=
 =?us-ascii?Q?hGSy0aDJ0dJOj6oUpQCqbZ3JmrAyhtMn5urIAff5QSkg/0KwtUaHaYbdRD4A?=
 =?us-ascii?Q?APWmswtYRJywxkIXPNhkRth1xsCZiGUeTrknYNw/AmxvMeesJJf0JgJ00JnM?=
 =?us-ascii?Q?MO0G/L90QMFOpaLHA2A6bZMmrgUGdnjsCISG7v6x2Tls7rX/JTXp9JTyMShe?=
 =?us-ascii?Q?Phowgej5lVHBoKrMdvp7xUSzaC6U2S3A6pG5Hvn89jPf7i+laWFVlpk76WDe?=
 =?us-ascii?Q?mqm114cCJ3vspgcp18YJvFsN/cMSTxJPN+AwpM6SBF3XrwXLbtJMgg5V/ugl?=
 =?us-ascii?Q?4NjSd9cfiaLsU5M0oZreRKmQ/AnlJtbSVprqWsxx7gv3ZtcccnAxTzfKF1Vr?=
 =?us-ascii?Q?QsRvTkZ4YTMNN82VW5wGZtVNf6OLarTYHK0kQ6SQO7MZLrOC9gKvYfTh7jo+?=
 =?us-ascii?Q?tAGrmTuA8rhJWeB+UUQDo2wA7wS6eey71N4spMYuvZIknsQvnB/cpvfiI2mG?=
 =?us-ascii?Q?B/o2Zx4SxCfiITQZS9xGGFZclZuWLnbw9TR5tVq6Mm63LBBhIl6K8dw3KZEn?=
 =?us-ascii?Q?37uLzkf50ONjLTanZJauBZk/GvmbOY4Kvb0m8IczBHmn0ODnehYcLpm4Y96M?=
 =?us-ascii?Q?Cpgq+BXavC4qb6y6RLgJ8NMyEU7nm3EwGnzcpZ/HWRGvZAOfjkImu//kim+x?=
 =?us-ascii?Q?88PveuJDvZ7+Vbvr/Bx1JOFnjXH1Wc5inxo6n0JIPyK+F/1DM1eEFevZn8JA?=
 =?us-ascii?Q?Rr2u+MDR+TVgQx9lqsDbVXaUFtdFvVwv+L5gy95+vbwTAwwnC/YzOe0hh3VH?=
 =?us-ascii?Q?0hIaZP4W0gB22rk9EKP9NtUxDO5mmWj4v9ljb/RQsGt/5gULEtT1tD/FUl2c?=
 =?us-ascii?Q?fNKhgw2puDiwwEn0qJDbAMh1W7JB2W8mY6I2zhvQzkrQ9X6Uq0LYoNfVC+Az?=
 =?us-ascii?Q?WPi8IOkKsHa7vS1MdFhu+fT7qE/pBLxLSr0k9P4o1VOLbk8+KplXFGpw0Xee?=
 =?us-ascii?Q?F760MURvrHzEgcQPhMjTnzB2GKq5Zbt+D9SdHXQxvXzC07p2Rs5klBtN2k9s?=
 =?us-ascii?Q?b0ITWHpBpaBqBW0qmeKbXl2DB70IkbV71RbR3OvYTEDjqwekxy8AK6WypRr7?=
 =?us-ascii?Q?j1n/WpAc6a5h8hn4RMZvo3HiRF2SjEKjWh9+GX7GFAoRzCTxKu9aQKokypXN?=
 =?us-ascii?Q?zBnmeXPhtHitTX/n4Qmp9LxFGD+qev1PJetXioQ4ojwcyfAGWjZZnaMGCIuH?=
 =?us-ascii?Q?ZXINMqQmoUHF5f81VO/fvwI473Ak8q+OUyJHGc/S/Ari6AotWs7fRIQMxytC?=
 =?us-ascii?Q?lxbdheYQjhO4qfLJYOmXoUCFIicCp5ouAickCRxGIieTGsW5VD0LOWq1MccJ?=
 =?us-ascii?Q?JdCpYGfXnrmMy8U=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 11:37:20.0846 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c75ade67-2fc7-430f-ea84-08dd686cbd7c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00029929.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7460
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

Update message to identifiy the vblank initialization fail case

Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 8dd9bf58eac5..3decf1973c7d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2218,7 +2218,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 
 	if (drm_vblank_init(adev_to_drm(adev), adev->dm.display_indexes_num)) {
 		DRM_ERROR(
-		"amdgpu: failed to initialize sw for display support.\n");
+		"amdgpu: failed to initialize vblank sw for display support.\n");
 		goto error;
 	}
 
-- 
2.34.1

