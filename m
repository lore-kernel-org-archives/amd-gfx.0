Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E6BAD637CB
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2024 21:45:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4070210E74B;
	Wed, 13 Nov 2024 21:45:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rAanDeAK";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2698410E742
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2024 21:45:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IVC/+qaUf+3Dy1yRkd2TODMPjHkSjawdJWjf4yKbSLGRfK4LdLPrJYNpZa7q3CJhQ4ls5QGpp7P1reSDxgL9K6wvsbAtfWqp96Lbi4wjTGyLJt5egYSn57gwQxq/AlaICIZsQrVX8G+Stp+xAWnUxFVQeSDkkbDoQIlzhnr0GHZN9er3BKYuy83Tq4lGXigtcsURtww6gBBeMXuo98XneEorhT94/UC0UyTJ2HSAJEPz5y+udlBCc/RqI5Ja7+cOe1b6UMlLN82JO11Fa864inV7DaOEt6ww7ViG3Xabitmd5dZjDSucf2/QcLbFQhu8SM1ezrXx+sZkmbWgE67GBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WfqYe2rr2BqJVbl1RLOuRj7lkdSdCxsZLcWwvz3Q08k=;
 b=CglqjyZWQxA9SIRzta1gL2yKH5/ipp0rk2v7ni5DcI7XCRSqNq00B/VVYIMD0cYYw5z9RkuoPtHOZp0GjahnVUw6Q6yqzyDbyAW+VABaSfvIqtqlx5EfxaLg4OZLiAfVTLGqb13yiArLW7WDye6RMiSqWE+FuvP1mHaWwBMsBytRMxIJmtvJtFSWOxPd4t8DhYoCXMfhZUZFEIUfm+dAOBwTbCqyJsqb3e6Nb4NyQnm5uTmCGWpbhuRYSiAAjrBJ4co81g3UAdBIeZuCSaUD5hBjGnDlZYfprYQJPKxstugFwrs11VncD/BnxUkGAMVFqoNdQfU1MuI/zG4xV8D6nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WfqYe2rr2BqJVbl1RLOuRj7lkdSdCxsZLcWwvz3Q08k=;
 b=rAanDeAK2yVrmsib8nF1HF9HD5na1yUxoQfwetTiz5ci7e14MM0q99iNwh+DIsoIQuvkBToSxZMUnZbaGabw9jvkCr9itP7ZvTkByEmYPxDdErZPoMB+AdIRNhJEQzD7wNBd1w2mi2ywG1ydJWjoTFmR8WNpHGB/fNfy17zJ26Q=
Received: from SN7PR04CA0115.namprd04.prod.outlook.com (2603:10b6:806:122::30)
 by LV8PR12MB9184.namprd12.prod.outlook.com (2603:10b6:408:18f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Wed, 13 Nov
 2024 21:45:22 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:122:cafe::4e) by SN7PR04CA0115.outlook.office365.com
 (2603:10b6:806:122::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17 via Frontend
 Transport; Wed, 13 Nov 2024 21:45:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Wed, 13 Nov 2024 21:45:22 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Nov
 2024 15:45:14 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 15/15] drm/amdgpu/vcn: update work handler for per instance
 powergating
Date: Wed, 13 Nov 2024 16:44:51 -0500
Message-ID: <20241113214453.17081-16-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241113214453.17081-1-alexander.deucher@amd.com>
References: <20241113214453.17081-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|LV8PR12MB9184:EE_
X-MS-Office365-Filtering-Correlation-Id: b908f88d-1468-4402-c5e5-08dd042c79cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?slc0Q1AGukuoF+WyuiOyU4bnMxpzgxwQfqEadCnF3c24JL/FyxSMmpjk9jjy?=
 =?us-ascii?Q?k//O70yBqa4sJAUKyNGiFQ1f2KkCze1EGnZOdCGOnvQ9B+gEjk1/UHvgflDt?=
 =?us-ascii?Q?vSjZfnnI900BLj+kWjErSb34wqj9ekgTo7YVnxHVgdXxfdZz5H4IsGf8F9S3?=
 =?us-ascii?Q?RfZOhiFmcwePyRysd/Sx+voVQYLQr3D3Xsr5MSNfo2WVI9BMpMQUXoGws4eO?=
 =?us-ascii?Q?AGiJavm3fJfVYGHLyFWAa0ewuTCuzrCzfvXdHTngLAVvnY0wikx8HaXCxCbd?=
 =?us-ascii?Q?MALPvTLj9lzoKz3a0uWXcvoOOwzkSw/wDXYucfT9tfEW7/t8tiIls+3w2Qwz?=
 =?us-ascii?Q?Y/tTlTuBzlmt9dgnxM41YOsiMfGG+aMSKXXkVcN/r41MtR5niJO0gc2MOO5f?=
 =?us-ascii?Q?XQqqQiwJ1ax8TCWmsbXhWUJ9/bclSIbvLotddjNnHUFG+8ol3BHW+YgTPo6Q?=
 =?us-ascii?Q?S5Dq28E58txyRI0y/JfEwK6s+t7t3nXTek8fqBhP5NmuKFDFKXLqwi2uqJaT?=
 =?us-ascii?Q?4iQfSJmxZeJCohV0kde9Mt1CzwXosztRku6+2awNzw9lKmCNSYK0a7BGMT+z?=
 =?us-ascii?Q?iJLSsLNt7z4yD1QOZT5laSse4NQDUS6OKRhCpeSFaAbBScTdOsacHf8/89Bx?=
 =?us-ascii?Q?SW0ev8kyEx0d7BndG6fwY/iLMHlk06yOeQxJGvwoZjP0Vz0WrN35PE+JS9Cb?=
 =?us-ascii?Q?1UtZWVyrtid5aE80b8yqom56+W8oCldh8OvGRyJLQt6lPT0wwJkO6yOsHvgm?=
 =?us-ascii?Q?981LQr0+5aZqmAW5Q5HozIS+vYH5Xp1IGW5tywWhRnpnJ/aeJbSOBAn8oBOe?=
 =?us-ascii?Q?t0wQvLy1h+kv4zEk+g4DtcAlot4T54O6rjaxRmUH8A1TWBfN/SvembNKVxXn?=
 =?us-ascii?Q?lN5CaTu6dc5UTfnb9WGB++PQMcjper5AiuB45i0ppyztiB5rva/ZlDbCOLQg?=
 =?us-ascii?Q?hlu8Wo0jWXrdha5tjGglf5d8JeVGtTKdIxuEOsIremBiAqUTf72lqMQH1uuK?=
 =?us-ascii?Q?Vli7BAQxWQ+EfaY94SZoZzErd7BvrAIMsjEqEvy/pKs2P9dvjYheUwZC0J6G?=
 =?us-ascii?Q?wBT+YuffIF9C2oO/z1vULTJR52A/sCWl6D908EFFLOlven2RSEZ0+9gxhTp6?=
 =?us-ascii?Q?wNIS7lJ0ykz6u9KkeyZEjXUq0V1wL12PYRK88Yi0WtCG7aZKM4tphshAry0s?=
 =?us-ascii?Q?jaV7Q84K1iyE6iXqGI4AHU0+u7TlJmrs5l4QZXvT/vuBp1I0HxHsFVIEo1Gh?=
 =?us-ascii?Q?x9vwhIonczRm03og8u+00prsdRlCuKLZjmAR9AdxNp++qhuM5CzQfD32OhEN?=
 =?us-ascii?Q?8F/yM3Tmgm9JjyRY/dBXTUt5/jpBjuQuXxs+81wQZwtaH8xbzZC+uOEoW3ef?=
 =?us-ascii?Q?AYWSx7QtOzQvwnQl2wDQWVZ2Ih6EI4UnE0ZDmi6XPhuXsNT5Zw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 21:45:22.2357 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b908f88d-1468-4402-c5e5-08dd042c79cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9184
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

Only gate/ungate the relevant instances.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 3383e4146c6a..24e9a3126763 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -418,8 +418,8 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 	fences += fence[i];
 
 	if (!fences && !atomic_read(&vcn_inst->total_submission_cnt)) {
-		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
-						       AMD_PG_STATE_GATE);
+		amdgpu_device_ip_set_powergating_state_inst(adev, AMD_IP_BLOCK_TYPE_VCN,
+							    AMD_PG_STATE_GATE, i);
 		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
 						    false);
 		if (r)
@@ -444,8 +444,8 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 	}
 
 	mutex_lock(&adev->vcn.inst[ring->me].vcn_pg_lock);
-	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
-					       AMD_PG_STATE_UNGATE);
+	amdgpu_device_ip_set_powergating_state_inst(adev, AMD_IP_BLOCK_TYPE_VCN,
+						    AMD_PG_STATE_UNGATE, ring->me);
 
 	/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
-- 
2.47.0

