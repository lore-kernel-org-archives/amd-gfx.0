Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D8C0C282DE
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Mar 2025 13:23:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C243110E424;
	Mon, 10 Mar 2025 13:23:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PHmw83Ab";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2044.outbound.protection.outlook.com [40.107.102.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F264310E424
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Mar 2025 13:23:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZHPySzg8eeOjYV+/XAKBJ4SXdBN/IUW+WXmTwq4l4TduzmoKDdKwud+GauTQCNCA/JIQBJ3blBBACgsUHSz1sIvbki/Jt5BU+QmFgLfGHsK/GwP+M2YwEb9+Ny+1iOhaXZLLDkVPj2M8Yi2XxbrfPouhE6aSbJlvArwyYyUBHimtGJtkwh8rgSFYogaXB4CUWQI+Ve+8OX08RqU+Xko7YUrXOPqE1zV2tNgftyBgTnl9fxGLDC0fl+P7OUQwrASwHLwblhyRoC53O0pxHmuDEBPHaQd4dgkMs74ydv24cqj1dGbm3cdXlC/Vrmw71IAtuKg7pe5qDgAV3NYpXV0bsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BYosWlcs4ymr5SHF4GCGM3dtI1Afvwm+L51UnCrSy2I=;
 b=yfoGR9Tl8j2vzF+jrtQmSZRyIq1oh4Csb2jyxNYd0cbZpiQ/acLpJOL5T/lBWnS2qwYzkdpVpivRGWrQ7TKUkCW2C+Hsg+uO0e4u6cS09pL9o7Gmt07FrB9+fxqVI/S/JAkZdWHFIVqsgC8Osg9B/yXU101GsOZKmzdCI7E9GKtCfkRRz/0k+KQhBSkEFX0X2bhC2AlP5ZcmFGeTmZpEjzCfimUTAYuAhjxrOCngjKUO4aCst7uYyuh23232ZVnRs2msPhg50Kz51+7CEySaLXm83kYFuLrcaNx6sTb4y2Kauob38p3B3Ubo3bX+w+wC09fECWDRYU8dwnaiT3W1EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BYosWlcs4ymr5SHF4GCGM3dtI1Afvwm+L51UnCrSy2I=;
 b=PHmw83AbbQF5rO+P6B7qBJLZVflggARLUml77SwBRZTkl2hYbsOEMHvXt7GqXqR19jluLCz8PeDk9RP5SXaiFzJY8dsN/JDpPxNbeK4aVJK9pCMjG8oXpvkYtshW+keg15Sv7BItBiUZRtD6u6KWZ8e8XWdeSqBwE/KGaz0o7g8=
Received: from CH0PR03CA0185.namprd03.prod.outlook.com (2603:10b6:610:e4::10)
 by PH8PR12MB7421.namprd12.prod.outlook.com (2603:10b6:510:22b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 13:23:47 +0000
Received: from CH1PEPF0000A349.namprd04.prod.outlook.com
 (2603:10b6:610:e4:cafe::88) by CH0PR03CA0185.outlook.office365.com
 (2603:10b6:610:e4::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Mon,
 10 Mar 2025 13:23:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A349.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 13:23:46 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 08:23:45 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH] drm/amdgpu: correct the runtime deference for
 mes_userq_mqd_create()
Date: Mon, 10 Mar 2025 21:23:35 +0800
Message-ID: <20250310132335.440011-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A349:EE_|PH8PR12MB7421:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e8ecf5a-f88f-491b-b0a2-08dd5fd6c9ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Tno5OyFe86EMgRAzuVcwgTJ+/88czm9PfWgQqS1eaDD9oEbG1S/4g0Cf90Ze?=
 =?us-ascii?Q?+lw3f/KNKBD+YIMhBBQvT5qioTJFHpXyde7lMyZXZ+99rs4nqHwwf8teJ6L4?=
 =?us-ascii?Q?TUysvQLbYNAJKWH4+89k3binjBOmCAUMltYO0GIxnPKUQykhoff7BeUb5N/y?=
 =?us-ascii?Q?i+7JUJcORjkJUPoAGyD/yhQcKRH+UXT3xwIrupyheZ2eRaFyc4JytLVm10Wd?=
 =?us-ascii?Q?BIwjvlA2dVuATPXvh6lZOAJ1cu7xkHFgla7t2Yb4tk0lwX4YkZky1vMi+9FD?=
 =?us-ascii?Q?q28MGWwieSQRd47p0b6FT7ChirgBEvIEvVH81oDBakEDBC3Mp5XeGYdA+vh4?=
 =?us-ascii?Q?7LyYXdI1JnshBKuBk+GGu3lzEAWdfaYmhxboEWd+GjSsxdz2GZOZbc3qg8ng?=
 =?us-ascii?Q?p+XxtKrD++JG3zfzHoSkYbFmXwUv7s8lDRnBeV87naH2NFi1PymkHg8QIfWw?=
 =?us-ascii?Q?ucFl9bC2MSYxmAoviRveFqMLC33TcF2HmV3MaUslIqSq1QbQgoEb13eswmZ2?=
 =?us-ascii?Q?qHhXID/RvL+m3kkrb4Ca8Vua8NBYcpRsyt0Hhp36Y3I80TZRNVXBJ5slIT6R?=
 =?us-ascii?Q?SRQpZOHsgmHwVAY6VNb8Oe6L9ERiQaLa0mDldGMDGTEvGd+MrFbx4+UGIDK1?=
 =?us-ascii?Q?m4ze61VyYKV2G79VQ+7geS7Fn7QM5qfin15eXy9qLMCrYPtoTznWeONnyBgK?=
 =?us-ascii?Q?nEzi7XNEAKyPFNnfl8yW1DWaHOr24fvZWy1LJEX4475/vLRO+0qdCurRUX29?=
 =?us-ascii?Q?au2QmOkQO2bjIk50hYuBDr6Ja62vUGKQtg7vOQBP1KIjJCOHeuDozJxMfI73?=
 =?us-ascii?Q?AhssW98zD71pcFj95FdonO8g/gBY76rjNxpLev/Mp8LLk7JG/xVdFLRZrY/A?=
 =?us-ascii?Q?gV3H3perDD8xEC2eN37JdU6e2wtGYkF+bjhkPsq2CefX2UaVaaeaaQxwAelA?=
 =?us-ascii?Q?ibjV/kNgvvmNS972sPrrb/79iWvjcW8aWdcpEx3Gw54FCtaTAcCloiMPv1ln?=
 =?us-ascii?Q?EK2DVCcTDG4wmlV6CbXKnAptWbpxkTlb/x0Pe40FLRFFwbROURnOee/jTCV3?=
 =?us-ascii?Q?/WECXsJi1yrU77FiHgSgheE7+kabGXCriaMs4fMsGNykgHD87AfED3R66d+M?=
 =?us-ascii?Q?CmB9mf/HS2p1dnRCJz/bEBxPR9r5RW03+mFH4yswEHavK5+uNa8OvMZ4Anm1?=
 =?us-ascii?Q?ISJMWRTVi9N1wimuRWu1+tDzqS+N6O5q3opjB4rJB1wBOvbDQFItiprpV4EE?=
 =?us-ascii?Q?aUoCFmFf2fYj+QDqIhfsjN/Z/RtWi8etF540QMuQ6uCSB2PNkhCxlWVTK8bl?=
 =?us-ascii?Q?yhgKIxqGKLZdo5CUwSE9aKVdWWNhHQ01UTn/gNQPmXv8qK+EUx0VSnlI9NVA?=
 =?us-ascii?Q?uI/+hL2g/3UI8v5Ynv9NeWlNV6un7qRgsYhxs+Coay4aP9enFbF/nxO/meTX?=
 =?us-ascii?Q?81rtiuHgHV1h+eyuUcCQOTxQ/UtyKOi5md35VERcXS6zv8XM4gFETJ1rX7wN?=
 =?us-ascii?Q?Emcd84O5UwmqdA4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 13:23:46.7031 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e8ecf5a-f88f-491b-b0a2-08dd5fd6c9ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A349.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7421
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

When the runtime resume failed, then the runtime uage decreased at
free_mqd. So the runtime resume error handler doesn't need to decrease
the runtime usage separately.

Fixes: 4baa0dcac737 ("drm/amdgpu: validate return value of pm_runtime_get_sync")
Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 35ae4125cd83..b469b800119f 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -291,8 +291,7 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (r < 0) {
 		dev_err(adev->dev, "pm_runtime_get_sync() failed for userqueue mqd create\n");
-		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
-		goto free_mqd;
+		goto deference_pm;
 	}
 
 	r = mqd_hw_default->init_mqd(adev, (void *)queue->mqd.cpu_ptr, userq_props);
@@ -330,6 +329,7 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 free_mqd:
 	amdgpu_userqueue_destroy_object(uq_mgr, &queue->mqd);
 	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
+deference_pm:
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
 
 free_props:
-- 
2.34.1

