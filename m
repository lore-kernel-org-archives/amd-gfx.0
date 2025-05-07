Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B65C3ABBF
	for <amd-gfx@archiver.kernel.org>; Wed,  7 May 2025 02:44:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B085610E73D;
	Wed,  7 May 2025 02:44:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VetNTBuB";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4F3910E736
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 May 2025 02:44:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D0qiJx70/xF5HiUUH+yIN1w+9qIZ8MJ6aN5ZacsC71yp6e/DmS1QAf823VXgQBV/01xZohxP4OoC/x+Z3WYu405JGE4jvxhe0FTjXVL4xnQR5aeYvbVt9GjQbW9mxKnJBg9IpqJtIB3C2v6Kwf9HTqdj8djRpjbP25RhyhCmTM1M7IvMR8ZRHsoAEH161cKjgDfDGvwKC8AmbMbUTeayLBEYnAbpNccaojUBo2uU4UllYbkkWXN+JmOPFyoXLPDTA6U0gxzGE/326pBh4vQf2RL+Q7FWcnIi0xhKbP04sjIJg72JZdjtJya/mmqbnS5Cgrd/QGzsmudwwMjiwhxbeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mQUp6s20lWN8mAIlIoypZgiYRN17q2T6h7UI391UjwI=;
 b=Q8dDWIkjcfK6tFD1oCI8Lfwjsw453XDgvqsPzYseYrNeBVRa6VcM4nL+wOPYJDRirP2cRvz1evlGydK4SWpqyTYRjeo9LqDLevf/DBcuDCNmBar9f0FBgeD58jKYmAUusLhW4IKjS7zEkBfr6WldgwJu28nYRarCvUdHkW0qwi9WOpVn4gLGZuNLp+Kzm2+Yy/XeQHyV0jPrZzvRaoTjGelXwbYuu/yp3whQyfhsfQswMWrdvko8UE4CbW3RMfD6X3AiTzSQMmjxkHLPzeYl1F820pg08wRS6EoXF2EnaW8m+Bo+UFoEDprxTEvNvApTWWFyZGuC5/it+HXczNXzMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQUp6s20lWN8mAIlIoypZgiYRN17q2T6h7UI391UjwI=;
 b=VetNTBuBa66CvSeHuEwPu+yrYOf4gxH0bj/fyZ29obwk51dTe5jSMK2iP2kaLa5z/f7WP0/Gd1okW/uB0EoLz0WiNUmaeXeHD5Ibe+eHo5nk+Xi0fqcfT3TmvVxKZO8gF+XVuFNRFVbJpDyGNLStleD464CV6cd3eEvLQ26vtvE=
Received: from BYAPR08CA0065.namprd08.prod.outlook.com (2603:10b6:a03:117::42)
 by DS0PR12MB7704.namprd12.prod.outlook.com (2603:10b6:8:138::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.25; Wed, 7 May
 2025 02:43:55 +0000
Received: from SJ5PEPF000001E9.namprd05.prod.outlook.com
 (2603:10b6:a03:117:cafe::57) by BYAPR08CA0065.outlook.office365.com
 (2603:10b6:a03:117::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.33 via Frontend Transport; Wed,
 7 May 2025 02:43:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001E9.mail.protection.outlook.com (10.167.242.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Wed, 7 May 2025 02:43:54 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 May
 2025 21:43:50 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 6 May 2025 21:43:42 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, Wayne Lin
 <Wayne.Lin@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 09/14] drm/amd/display: Return the exact value for debugging
Date: Wed, 7 May 2025 10:34:53 +0800
Message-ID: <20250507024242.1928299-10-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250507024242.1928299-1-ray.wu@amd.com>
References: <20250507024242.1928299-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: ray.wu@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E9:EE_|DS0PR12MB7704:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ac75f50-f32e-4881-c4de-08dd8d11022b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RKfWPaGzVWbKKqUhWzbDSYbzuBpOjOwSVZoKkXw6CjqY0psPZAoYHPpc91nr?=
 =?us-ascii?Q?S86x8ia/4d146SKwsq/W0q+2Q3atj364T1hk/5ySFJqc2lZW6dylnLYUtBvq?=
 =?us-ascii?Q?mmvSpNFT8GR+CTzF0Y1HShv4c3fvl5jdG50MZtftU/e001mttG/3EsvT/hlS?=
 =?us-ascii?Q?ZBbsJKUpTCL6DwAX+GF+iDPJXGyYs3E74M9qeIKiBrzFgRHJGeoMIA7ZM2gD?=
 =?us-ascii?Q?9tuVyYw6EjO/DTn8ykczHi0e1KUqQUNguJlnCoJjtun6Dx4vFfTi9apF9wZ8?=
 =?us-ascii?Q?un/mL8UQvKafMHb9En2O5Ub3jY6rUS9Fp+ztLUofYor+c35N86i3rX3M9q32?=
 =?us-ascii?Q?VZKXDFu4WafW8MreACxG7kEdyB2J7rDv15qcTs0h9cIEdcRqMYLMOTBhJsCZ?=
 =?us-ascii?Q?kt6MJgFWxwQPWoC8OWBOIY7jG4W053G5MbCCpRKtNFGmzH0f4/DdhVNj3G7Y?=
 =?us-ascii?Q?1LjDrrda6FaZI4NmDQ6K9sfEISmDsGi3rXcH9ZRdHO10oGleDgKlNp8A/Afk?=
 =?us-ascii?Q?d8LI7nU4Zg13DM/lxhZycCFMr/KGMIUzElp+XFUOqGjFCRxPCFHEdItUtvfW?=
 =?us-ascii?Q?dycCpaPTUiMnGF+V/YFrJNhLUNSD59ZZcqy6t/uxRKkEUAcmmfDFeqxk2aDK?=
 =?us-ascii?Q?TTG7RffjavRjX6SZk46yFGRFqHQN7WXEegNZGHULJvLd8BkgW20FrdV5ydCY?=
 =?us-ascii?Q?FUJA/MVoi5VUIr/TO4oO3KtsTkSZEKTzv7LEucC5rY3BGu3nuEYH1yy24ETk?=
 =?us-ascii?Q?2+IQclDrFZAxBHtXvJb70mk1Xy/GwC1GyjF3a3IBwwlfWabH3w5tvYKCzTei?=
 =?us-ascii?Q?o4vyvigPaKWgrEJ2ARvcSC4UOPOVuiGKZxqNjLALpJJn/h/fr0rv/DEcbJS8?=
 =?us-ascii?Q?Px5H7nH/Ux13jl9GjeaECOa7hFC6d1eLioa2IfSm13ibplVFY7cKGui/DDS1?=
 =?us-ascii?Q?Mg2EM1PXEs3I5cXlS7Mh+cK+Ou1ebGS/FHKimZaXVx1278Iqan7LOk84KI2Q?=
 =?us-ascii?Q?nv7nl8F0Hg+TsRkPGZq86nuUewoQrFnqpuK1Rn9BAaCmJXplBr6sFo+JpTt1?=
 =?us-ascii?Q?J22b8/m2icdpw3toxWLFKZOJwjXEGmq4N1fibjTCTdhjhP8N/QFb2/u23GMo?=
 =?us-ascii?Q?QKZdShwvVioobXyW7KJoQaewd159yhbigIn6tFyDSILVXWnm2KS2pLAJQcXT?=
 =?us-ascii?Q?Z6WuB4zUr2YvjhDSOY1KBbIK0YP5bHA19IaKMhhgkXNryFXUFQKakRYu428u?=
 =?us-ascii?Q?iykTfz8Jo6pAUxyWd2A05ZKU8yPSau9CAiekqgYCRRBlpmGWxpfex6ki/1pc?=
 =?us-ascii?Q?YThBHBXTdrIYDgCUZqPVRP41GqlDy4UEgnR8HKY/ToDeeXRMTuEkkJknQ+qM?=
 =?us-ascii?Q?d+jgSvuJju90tcS7fh6iIpqUlTQt/tr2brJM/qVZ+9pxtjZg84rMdxBgTMdm?=
 =?us-ascii?Q?6pwLnOBMO4ZSRglqIpvxS+6osPM/sGXcUktVvXHO7jISpz3CTguTBCQ0lJil?=
 =?us-ascii?Q?ZCM0ilLtyfn+vZZb+rgdlGAEXqqsvgNKUvno?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 02:43:54.5448 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ac75f50-f32e-4881-c4de-08dd8d11022b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7704
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

From: Wayne Lin <Wayne.Lin@amd.com>

[Why]
It's unnecessary to set operation_result as invalid reply when
p_notify->result != AUX_RET_SUCCESS.

[How]
Set operation_result as p_notify->result to better understand
the reason for the error

Reviewed-by: Ray Wu <ray.wu@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 6894028a3d21..d883505e5125 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -12700,7 +12700,7 @@ int amdgpu_dm_process_dmub_aux_transfer_sync(
 					payload->address, payload->length,
 					p_notify->result);
 		}
-		*operation_result = AUX_RET_ERROR_INVALID_REPLY;
+		*operation_result = p_notify->result;
 		goto out;
 	}
 
-- 
2.43.0

