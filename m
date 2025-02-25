Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FF5DC021B8
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2025 06:37:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00B9110E56A;
	Tue, 25 Feb 2025 06:37:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DKFv6ONT";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2082.outbound.protection.outlook.com [40.107.101.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D511A10E56A
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2025 06:37:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DdIS5Br3TCaBkvkQX9y3m6Cl3JcBpD8kSG3dDAFfigSJ+lRkXM7NE7tTl05gnvrxRyPWOmIp5NpHdbfPICjdsC70NQGqRSU+pN0e3iWl441r4FF3FqnanVh602OceuSV1KPdm/791WXdAhkVi+R+8mj6Id52CyhoELza8ViyWPrKF8fLve54Br0t/rTyQekoPC0Cg5yLAyiYKARJ8Us+kNZgnqQdO/7ztq9VUiaIVpbrFflOV6plrh3zajQncWxOLI+SEhmbzlqa6AldZ7wBGgowORo8unorLTtR95V/sgCokL9R0L6j1IquX1auViAvSL8Kob7HlAIGmAwgbntA9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=383sjVqW2mIXV3zayQZ0qbUY7CnNXalXwhSUy1z2x4U=;
 b=akY2m9tOtLxNSrT69RY6C0/mHvO8splHjBr41RcDIFCNcd62OoOjIgYPf0ZFIQQzO8xTX9BUY1XEvGIDSteHWa2OfT1/lNenI2Nt2AE00eOez/OdXVSJAHgX2gO5CU3vUIYYf3562vYNU4qwsoSM/OkfUPzjwnPhvf/j+bAi27cyU29qkQ7F1YpW89x3qcoXBLUdX73dO2enOKTVEGwIXVy2Bm9Rr/dzNU8SUnhb0pkRhItDrv9uKkdAfWtSy3WvEktgq/dq0H5U9FW0jgytCUFfq1PDoXOXCw81geZdFoj7K217uC0NhPGTwECnNPzvd2vRhyML3yjozovTtMV9nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=383sjVqW2mIXV3zayQZ0qbUY7CnNXalXwhSUy1z2x4U=;
 b=DKFv6ONTdh1SmAMCH6MRfUL0KLTw1O91XApnywxQ73eP1thhsJS1cTPTdMXjJKoa08DYmvNBw4KAEvRgRPq6i6UJjAH2ZAHxZPCmxO4q0sazQe569cCTVWY8G068Ome2H4miW6h/AulPDJUIO3M/IFFS0lAbFTyW8b4viduggbU=
Received: from BYAPR21CA0005.namprd21.prod.outlook.com (2603:10b6:a03:114::15)
 by DS7PR12MB5982.namprd12.prod.outlook.com (2603:10b6:8:7d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 06:37:49 +0000
Received: from SJ5PEPF000001F6.namprd05.prod.outlook.com
 (2603:10b6:a03:114:cafe::a2) by BYAPR21CA0005.outlook.office365.com
 (2603:10b6:a03:114::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.13 via Frontend Transport; Tue,
 25 Feb 2025 06:37:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001F6.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 06:37:48 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 00:37:47 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 25 Feb 2025 00:37:42 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 15/27] drm/amd/display: Drop `ret` variable from dm_suspend()
Date: Tue, 25 Feb 2025 14:35:58 +0800
Message-ID: <20250225063610.631461-16-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20250225063610.631461-1-Wayne.Lin@amd.com>
References: <20250225063610.631461-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F6:EE_|DS7PR12MB5982:EE_
X-MS-Office365-Filtering-Correlation-Id: e0fe0160-1982-4785-40e8-08dd5566eb97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8ZfBkiXCsxebfYOoxeNrFd4CXEB/cLqKPwgcjZQMWGpiunyWxF71X9f20pKe?=
 =?us-ascii?Q?ykangHaYwsEdL/7YbuWXqwaGdVyD2DyPt5mqFcTJ0CClv8lep1ikXgyWXIZW?=
 =?us-ascii?Q?0yHuCvSOaA1PBUBl/QW7cStf90YzCj1fzz/OTl0e7UZKybP8lZVkzV4IwfiT?=
 =?us-ascii?Q?eHPS0+wONR/IblfK28tdwiifGaQivYPbHoex8xRQfuswQMBM0S3+IvtVZDzj?=
 =?us-ascii?Q?OwLQNYzRLleBwj8Kl1Qvkz6pmWOMKuy1LLxh3RTte+y8CdFxwqE/g4ogEDoq?=
 =?us-ascii?Q?goPpBUCx2WYTOQnZlx5h1NgBD1TsxFeXSORGQ+xYqqwKCQ+Jbz0JDUi7DFfE?=
 =?us-ascii?Q?TwczLhPESVJkokCoKtoSjTqAqE1IgUP8W8sKWnxhAMk7swpsjrGHgt4RFr2l?=
 =?us-ascii?Q?BoEGYxAQyMBX/+EIPAhq1Nar4ntaKvSoRb7MVch1qFBe+rCASLxthunOTy2f?=
 =?us-ascii?Q?Q2Nkl+BNozuWFP7ihkjMxOg8uKWj/1Loh5JQOfDm7pH7k3SUrlkJMJj03wNJ?=
 =?us-ascii?Q?NJDZLTuKH8a306RpdgauuSo75F5Srd+D++smG09A82XPnFtFZurG/L8cYL6g?=
 =?us-ascii?Q?qrqOaVIeHoYlfSyKAA0iZ8EuqWI8qBUJa91aTc6VJ87mTc5WURhnbwsD/0H6?=
 =?us-ascii?Q?B0GVe6VekoSIEiAZLUImoFEJ9WQwcczslC2sWRUYi0KbPys5zgrRiqw51PF1?=
 =?us-ascii?Q?Si1Hp7wQ2UMjnjdnMQzPi55OZbfdEmZ6wEcCAmXy6tfd0QnDQiNEoqr/JgpU?=
 =?us-ascii?Q?aS6QgWVyGGX1tAtDgXgZvgvjfQOsDw0yamJCT5jMcFiBF3IZ9A0jcSDqUwjs?=
 =?us-ascii?Q?uwUGHjcMX7SgXA6RStxk7CPn8lICRd2WlwE0wyxJKOBNdoIa8rHJhs+voFU0?=
 =?us-ascii?Q?ptEWTFEGY6aixlyLBoAfdzpTLB+e0CkYaFoLJDZh1Mg+fpnJ2LHNoeMTeo2h?=
 =?us-ascii?Q?m0+2Z3ZiXZaW4Ls9Za+Jp9ctV3uwBoF2YTwa0uglvBf3YuuMFjfUgaaZZNo5?=
 =?us-ascii?Q?+v6d+kopcYvcwLfvBhfUZJYCPMEoiZR0Hyedw6VLe0sosZ/ohN/YkeMB8JWX?=
 =?us-ascii?Q?TMrSdd7iwwJ/PlGGVZgKYFiHrnxV9WyaJPYF9RSBIM4ANQktUAFy+7BIlWvs?=
 =?us-ascii?Q?n+VpZ1bdFMXZWEzvdKEdRipOLR505bwwNRUfsqBUvbXB/cKuM7DHjpfdZ8zb?=
 =?us-ascii?Q?zKmwWKoilHXwUWzpsrl7F+R5x31P8YeprkZSDrdXpgacMB7MaufTdDiEDqm1?=
 =?us-ascii?Q?Vi4bgHOIdmprE9udEsA1+8Y8AoUy+qRiDxf9beMrYL/1VFkTyOhVRv423Wz2?=
 =?us-ascii?Q?ZXlNNnlqJUNQF8DjYx2KAlyXy3aOrx3rBeIVk3A7ZWxg3/+IYsw+kJKJM500?=
 =?us-ascii?Q?6ed4S5ZociWYNfA+eQ6DTWOimbOh3eGTJGdhPYrhm1bz+JzkT5E5lahL8xkO?=
 =?us-ascii?Q?8zjNE3cTWz+Fi4U3kxG0JNtXStLVjZEqfhsC3dom/WnBMuAUMTUcaGE/GkfY?=
 =?us-ascii?Q?zKZskDaldsXXwHI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 06:37:48.2343 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0fe0160-1982-4785-40e8-08dd5566eb97
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5982
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

From: Mario Limonciello <mario.limonciello@amd.com>

The `ret` variable in dm_suspend() doesn't get set and is just used
to return 0.  Drop the needless declaration.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index badd8fa2099c..6473622e2bf8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3142,7 +3142,6 @@ static int dm_suspend(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 	struct amdgpu_display_manager *dm = &adev->dm;
-	int ret = 0;
 
 	if (amdgpu_in_reset(adev)) {
 		mutex_lock(&dm->dc_lock);
@@ -3160,7 +3159,7 @@ static int dm_suspend(struct amdgpu_ip_block *ip_block)
 
 		hpd_rx_irq_work_suspend(dm);
 
-		return ret;
+		return 0;
 	}
 
 	WARN_ON(adev->dm.cached_state);
-- 
2.37.3

