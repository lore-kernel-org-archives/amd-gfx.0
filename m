Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C015EC3ABCB
	for <amd-gfx@archiver.kernel.org>; Tue, 13 May 2025 03:20:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 411D110E1E8;
	Tue, 13 May 2025 03:20:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uAMdjpc8";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2063.outbound.protection.outlook.com [40.107.236.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D66CF10E1E8
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 May 2025 03:20:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IAaDa9qYqkdxzC3XEbriR/o7hBNVTkx5eFejSoGnKimNybaMQgKzkPcJfAjAVQbhPR3XE/r7smIXJsowPGofj5OXmSjvomAxUIjqRIFWcIWyQWm21gpbwOnOXZLZ4cN1KMSdLgZJGpwl0zsH8BHSzVpMoJTk6s0yZbbGhmnX9cgLyheAzzttigbSySG4IkutQq5OErzuG6jOOVNgSaytFmcJ2b4VCuyMJLA6VPURulJB7pmUTcW+54NfJwzh82pLaNJJM0EEupGAV3TP44AQeeW/Ch4GjwQjfFbiW/to2UQgL1dG+YlaLO6G0Q0J0dKEQzIihdF43nbQAxiVtzdAHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9nCia4LSlyxLcmzF3bmn313yZhlA1MQqFbk8js91hVo=;
 b=k5TCdmnsTmPaIkN7REDz3HXKsbrIcQul3jqzAk+m17gQRjWv+Hwi4OyZ9DgUrECS9o5RG6Dap3ttKCCYGpS+dGUoEVFI+1AEIPOdgbnUDVyl0J9bTife5Q6YHR9jeo11wx5NtL2iJoNeWcATcL8mz3OkZL5xJYBIz7vmw14zsBIHZHPlAWlwUJVqINMp0Rw6UOeC/iTuTsCJ+jUSR9/5Rc7y8k3mmwCFOdC8yxMyxyHIs1N8XOn7jXvtq45R/yh/8bAvXffvOuBrkXBoFcG3dMoLXCiQrjTdykhmPpmH1N/Wk8d+PA5JxnoWy/IG2gukgXkzWJqc6ge+3xTasc8UFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9nCia4LSlyxLcmzF3bmn313yZhlA1MQqFbk8js91hVo=;
 b=uAMdjpc8UtHHzrrQcGBRi1vg6RIl+zT6/nhLJUnBp198cdUsXS/CWV/rTd7KghLpVtI+HZ5MYhlZ0FndjAEG0pyp8L7OTQ7tY9FAHSdZpPzhPHoplnPzPZYDpLH5do38Ab7xLszGewOShpu2otCnPZqJUg5uPb2rxxuKTW5CL0Y=
Received: from DS7PR03CA0098.namprd03.prod.outlook.com (2603:10b6:5:3b7::13)
 by PH7PR12MB6740.namprd12.prod.outlook.com (2603:10b6:510:1ab::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Tue, 13 May
 2025 03:20:42 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:5:3b7:cafe::31) by DS7PR03CA0098.outlook.office365.com
 (2603:10b6:5:3b7::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.24 via Frontend Transport; Tue,
 13 May 2025 03:20:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Tue, 13 May 2025 03:20:41 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 12 May
 2025 22:20:38 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 12 May 2025 22:20:35 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>, Alex Deucher <alexander.deucher@amd.com>, "Wayne
 Lin" <Wayne.Lin@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH] drm/amd/display: Avoid flooding unnecessary info messages
Date: Tue, 13 May 2025 11:20:24 +0800
Message-ID: <20250513032026.838036-1-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|PH7PR12MB6740:EE_
X-MS-Office365-Filtering-Correlation-Id: ef1648c3-4043-49c0-416e-08dd91cd2436
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uIujJGufBZNwGCotSMvDPsOdwSomlSihUhici2dclEc4ZRRPdjCt8wl6Mt1r?=
 =?us-ascii?Q?/+LUpeFx65dkDLNDeIxjgi3o1uiQFJr9Z60vX7CsRgj/bCUbYqpvpNYJsSCI?=
 =?us-ascii?Q?7sZAaDZHYcHPLnwAp+2tDbqQBIqxvysUP+klofiJGO7w9MFArL04W5JertyI?=
 =?us-ascii?Q?AVESXzE8wv7cesIjWWPDSD5Ptcxr0fIDK3ixDy2TpzOKOdBy1BhiKJPKd7QA?=
 =?us-ascii?Q?Xbk3SeG2E6dw28xLbap5U3syF5v8fKa8QuA240FIVVRFdlvq2HSlNFFibd9y?=
 =?us-ascii?Q?ky9gKLbJoCP0Sr60lkmIhwfL1K1Uty5oBZrchL3yrTFbjTiuv8ZFjcg7fuAX?=
 =?us-ascii?Q?g/pybX2+aoixXtE6euBwXQC8K6s0qdJmO/bTSth3y85KzewI7G78lhmXh0DO?=
 =?us-ascii?Q?BaHLPpPw4+LIbj5Y8pz9xeXPZDd/nh0VjtJNoNb/0Zy8vdIeqUbxi9Mqx9jg?=
 =?us-ascii?Q?AAll0hFalguj2n6277B+cgtAq9KmkwAsv6BYXd9wXMluUC6/bPDpnxy6J4L+?=
 =?us-ascii?Q?r5mQ9MAq4GXAvKdIvE0jI3xTZPjGI+ZvnVF8cyrZlTs5lAS/vdyczgxZY0Pa?=
 =?us-ascii?Q?nx8egct0DFOBlQuFoL6q4Vw/ThO3wYJMaT93SdTYBa37hf7F/SwdfTtie8c7?=
 =?us-ascii?Q?Vaof22iwA2vMPkpP8fGjl2Bd0KM16bMPcgiFqefdTuSPVYUvmmsODl9vHgyJ?=
 =?us-ascii?Q?mjrPu5ATjccGLjcEVZsgZndnJ7vYtowNcItiWDq2H17Oy4bWkNw8gJcXqK67?=
 =?us-ascii?Q?2d7SlDkfSNvw9yoqk4etWhHompMw/yVCGTPpf2O4KzefwIxMgvs+dfqbWIsQ?=
 =?us-ascii?Q?lIyfsncvA0U11fPCGVXeV3O2v5IEqB/F3apzdA6nIhYc245j21VSP1OqEukK?=
 =?us-ascii?Q?LEXjnFtznSOkPLJoSeDW/2Mw7ff8MsZS5OGTpQSP2n4HgbLISyeLZeNHwH5o?=
 =?us-ascii?Q?mlGeSgAs4FajSs113bv68rP1WFFK/ms9L1D9i2OCnbGLqzu9bdS7iBRb/ufd?=
 =?us-ascii?Q?Pja02rwmdHqQt4iYHGrH2ymKmv30952OmxijEZheBtKjnYAYyjtLm3pfz+1+?=
 =?us-ascii?Q?lvX5MqDb8Tt8fV3olnu995/EutC2L2PD/h9K2vo9hFeA0VId0jKXl95Zmtjj?=
 =?us-ascii?Q?kRvHVCnudyAUsMDoN5qIPjdWB0nbEWrTSlaKU2zJmwYzo4OseAUd/l4YjC37?=
 =?us-ascii?Q?Hqp5bhP8p5FMjUZFi8zOojipXHadsGgoQlOxqiflAK+2KSo3rxmftYQCKJv5?=
 =?us-ascii?Q?+PTR2ZCSDLKVh03KK24qn/gO72QvHmTsdWF+jrw0/KwXHfS0NZg6dElU5X97?=
 =?us-ascii?Q?KB2q1ZmULxDhhrrNm0SOS11HROeWwuqft/fDjYREZ524UTWvWaqg+ovY1LkW?=
 =?us-ascii?Q?m9t40xIVmSG63dpsI0tRFWdtVFrvmTSdiooxGNQATCJBh43wd09w6Wgso13o?=
 =?us-ascii?Q?sdVaoIZfUpRl+CxiwnfzrTT/RB6mTg47ka0AFaboRTVkOJMiNjmkEj1bicPJ?=
 =?us-ascii?Q?8gdlHkyUph2M9IkVNMCx8ku09kpG7MuD8e2Z?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 03:20:41.7380 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef1648c3-4043-49c0-416e-08dd91cd2436
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6740
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

It's expected that we'll encounter temporary exceptions
during aux transactions. Adjust logging from drm_info to
drm_dbg_dp to prevent flooding with unnecessary log messages.

Fixes: 6285f12bc54c ("drm/amd/display: Fix wrong handling for AUX_DEFER case")
Cc: stable@vger.kernel.org
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 0d7b72c75802..25e8befbcc47 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -107,7 +107,7 @@ static ssize_t dm_dp_aux_transfer(struct drm_dp_aux *aux,
 	if (payload.write && result >= 0) {
 		if (result) {
 			/*one byte indicating partially written bytes*/
-			drm_info(adev_to_drm(adev), "amdgpu: AUX partially written\n");
+			drm_dbg_dp(adev_to_drm(adev), "amdgpu: AUX partially written\n");
 			result = payload.data[0];
 		} else if (!payload.reply[0])
 			/*I2C_ACK|AUX_ACK*/
@@ -133,11 +133,11 @@ static ssize_t dm_dp_aux_transfer(struct drm_dp_aux *aux,
 			break;
 		}
 
-		drm_info(adev_to_drm(adev), "amdgpu: DP AUX transfer fail:%d\n", operation_result);
+		drm_dbg_dp(adev_to_drm(adev), "amdgpu: DP AUX transfer fail:%d\n", operation_result);
 	}
 
 	if (payload.reply[0])
-		drm_info(adev_to_drm(adev), "amdgpu: AUX reply command not ACK: 0x%02x.",
+		drm_dbg_dp(adev_to_drm(adev), "amdgpu: AUX reply command not ACK: 0x%02x.",
 			payload.reply[0]);
 
 	return result;
-- 
2.43.0

