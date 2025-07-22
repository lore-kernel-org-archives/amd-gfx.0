Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6522DC87FCC
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jul 2025 22:39:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A34B10E730;
	Tue, 22 Jul 2025 22:39:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GZvxswru";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C79BF10E725
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jul 2025 22:39:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=buUTX1uyogC7vHbHACMqNj8nW9EwVzq1rMiOG+6Asz2YlTC7B7ELspY3XzTmslfiQpa9suRUbgG5OcnZLO0rXgVIdVW0px9+xVt8HP9Ky18Bp4P+bzmOltcflP677GR2pUMvc/8zczU3dZ6UNRdgvTdMpJCEzjbfrqmVWukkWNp83IeXDEbGV/f65qRkDSRwQeEUiDPDdq/GAQ61yhLBgwHTRb2yXGwLr5Ql6F6GF5tb5vz52IAMRpwxyMRa0IKFLyQMPgn5wmT3XE/Zb9CXUTWq23VnEA0TSzWRwN/7wHhTPX8W8eKZLv/XTeRluADrqTZ9CzH5zoi22zmNq8bQLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5bYLLNA3GS+92Bv9y5OGsL1CrIfH2jD43ol5vzkrANU=;
 b=IZETMm0Bcud+aaop3NIseuYqyV+2UW+WjQCsuAWyubd0mwoSd8ZAAlhsjXrOpFYiLAVhSX4RJSZPl72PtslrXJb9mA7GJUgmxe56qL+sy+Th+0yEozZPNM6xyNsy0ojeoNhFfVys5BTsoMXHtZkq9gMfu7BQ1jGEywsz8WgEsTosIGytH2yjzYkYomLybFHYp6L8g7rnY+0Y12Hskd3lO1lN5/YGF46kj/ivkEGsz/3RaoUmIfETaDz6PehAan4F5SVQ71ZsWsDA6Dooby9LAQkTNt2YspdTHayUyS4wxL/yjqCnTd/xfVOV7F5zjPG6+THoVO5Y/wQ/JwthDrZeBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5bYLLNA3GS+92Bv9y5OGsL1CrIfH2jD43ol5vzkrANU=;
 b=GZvxswruBti5sb58dsLKTRhu8osbyIR0f1gAKPRABlKhDZeDi2B5JBot3b2ymzLiOiiJfyeEnue1URwmDBkydMP3jABfP8Tuv8Q4aRwayrcTuHOOQhqxcUnRLsPjzIG9+DsIa2UwM8TkDQ/sX5haGyVlldy0wn9A7pHD80N2hYA=
Received: from BYAPR05CA0058.namprd05.prod.outlook.com (2603:10b6:a03:74::35)
 by PH7PR12MB7115.namprd12.prod.outlook.com (2603:10b6:510:1ee::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Tue, 22 Jul
 2025 22:39:30 +0000
Received: from SJ1PEPF0000231A.namprd03.prod.outlook.com
 (2603:10b6:a03:74:cafe::b0) by BYAPR05CA0058.outlook.office365.com
 (2603:10b6:a03:74::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Tue,
 22 Jul 2025 22:39:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231A.mail.protection.outlook.com (10.167.242.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 22:39:29 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 17:39:29 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 17:39:28 -0500
Received: from box-0.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 22 Jul 2025 17:39:28 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>, Ivan Lipski <ivan.lipski@amd.com>
Subject: [PATCH 13/25] drm/amd/display: Only finalize atomic_obj if it was
 initialized
Date: Tue, 22 Jul 2025 18:36:19 -0400
Message-ID: <20250722223911.2655505-14-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250722223911.2655505-1-IVAN.LIPSKI@amd.com>
References: <20250722223911.2655505-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231A:EE_|PH7PR12MB7115:EE_
X-MS-Office365-Filtering-Correlation-Id: d1a865f9-61fb-4935-837c-08ddc9709f26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yjpQ9Gqjj5/5n+kfPIpQz6fEK8MMJMyAx4gXACI78YeY1JtYDYQPWtpwoRnl?=
 =?us-ascii?Q?PXDJp6EHR8qERWR4vC7bSBVMQvYZirM3CpOwRGm6uerDX1VFzo+fUtfrSqf2?=
 =?us-ascii?Q?sfSMlXkzfTHRkd0KvTOGl2LFdh1LWeBocDSIO0kaKR7B5CLBYeNEO2jfVwRi?=
 =?us-ascii?Q?cv34Ab31Enc7JNS4a4m6TrhXjf5Y7m1mSNf2jqwCZTih5sW+9AEiqVALtWUN?=
 =?us-ascii?Q?0/KsS5xcMqF5xFDS9iAH3sJ/JEW7rVXF01CoRswStuRGdCihGIMgd5Z9ZEcT?=
 =?us-ascii?Q?V4T7SubH6VdB9W4CcP/fgFB8xzEnSRqaw224Pu67d+gOu9j2VFLrx5kZdhZE?=
 =?us-ascii?Q?PypxVp86RdM126xonk+1AIMR/nVj8OuIgd7c1CvFlph/Gts8hCR9Yc/zIRRg?=
 =?us-ascii?Q?MdF1VF8SsEyF2WcDgYB5DHYkakVnFW4AnniEcabQPKwsu/YKuPTsHrKFjH1E?=
 =?us-ascii?Q?U2OiclQXnnpNtZZTwYlHf7K1qdllv3YxzOJZCkEsIPpRlMumAC7mUyR/hWuG?=
 =?us-ascii?Q?oprUiSqQls+CPmHoWIYoaIGe+QdnvBApIkiE2I/IPJHoXJTztikplm8/rWMZ?=
 =?us-ascii?Q?j1QbBHD7Q3ZlwTkDVMBRRa+cADsYxmBrQHDxUJD/xFHzxhiZAfb0NuFXfQaU?=
 =?us-ascii?Q?s+vrCz+/JAcpu84FUOiJtF8rphnf0OAnMP+bPAY4FCM9C5p3GnuiBnQ2B+CC?=
 =?us-ascii?Q?TQDvZwqjkFslq5bZ7o0PPot4s4YJM4LkzvCebxT2EnoOKWr/jD+PJIDAWvLk?=
 =?us-ascii?Q?M6Fi0H5hxaV5Rwa/rzni8TKT2wFFe1ZzwlCiRjJYoZW9prWc8gzawBVK5IGM?=
 =?us-ascii?Q?qaLQxrmMsAgRatXUsdNQ6YVQ7hmYx1k2gNbRbgAzj8CmGzdu2TSZYZS9CCYk?=
 =?us-ascii?Q?DWcc/t9dXzJZ2AmlIr57a4+4T+CCn+I6zOtTAJIzSxwYgVB2vGoMI9ViRUC4?=
 =?us-ascii?Q?NnZnEwSqFrejVUFK19RLKjhnFdrhXY4JczE+9P6JZNYdeh8yZpeFVTAjTW+L?=
 =?us-ascii?Q?PuI5lwpdpL45x9fJuxy645l0ku+1fD/y/EsfKsvbF0xPwB9D44EqsY/SoFOR?=
 =?us-ascii?Q?MXqStj/k5lZMvcexEYe77g25R0kxvhcZgHLFf/iI+2zzhnKwVz3vFJwG/Y15?=
 =?us-ascii?Q?s3eUbB3CcSs+yELvQsxoldDBhHYsF6RdWlav13zT2S1DBBgBZHlbdsFnKhRa?=
 =?us-ascii?Q?ue0HwLM3SP1e4yZTbQdHBlFjqyZrqH6OYGYIHDYY3Vm/KIU/V0N5dJAwVoT5?=
 =?us-ascii?Q?j4YEyZxpsdflfxknonBhuJW986jq8QEI/NCtNT5o+vsrXI1FcpwA43pDts02?=
 =?us-ascii?Q?zzhIkNWdkdAfoeM7PWAVn2w3ErMBM+qn82x21SrrA8U7iVr43dDQNoSuUzzB?=
 =?us-ascii?Q?4AwHcjDuRBMJPeVKAvy7CQ4EhemSq3LUy8qTwku6hc/CZ6rU5b01umodJXj0?=
 =?us-ascii?Q?aV20rhkzQkkN74fMxGe6JPli9dq9cuPgP8nuWvHyLBOGtJsiqzSxImrO6ZOV?=
 =?us-ascii?Q?ZlyNt9pICHQli4a8NAQS4nEtFQbmAcUQszHW?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 22:39:29.8737 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1a865f9-61fb-4935-837c-08ddc9709f26
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7115
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

[Why]
If amdgpu_dm failed to initalize before amdgpu_dm_initialize_drm_device()
completed then freeing atomic_obj will lead to list corruption.

[How]
Check if atomic_obj state is initialized before trying to free.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 2d9132c60bef..2113732cc97b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5397,7 +5397,8 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 
 static void amdgpu_dm_destroy_drm_device(struct amdgpu_display_manager *dm)
 {
-	drm_atomic_private_obj_fini(&dm->atomic_obj);
+	if (dm->atomic_obj.state)
+		drm_atomic_private_obj_fini(&dm->atomic_obj);
 }
 
 /******************************************************************************
-- 
2.43.0

