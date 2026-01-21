Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4286DC44500
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jan 2026 22:33:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA05510E1D4;
	Wed, 21 Jan 2026 22:33:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZQtn9eb+";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012055.outbound.protection.outlook.com
 [40.107.200.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BAE010E1D4
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jan 2026 22:33:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dgHtl1akk0xdlluas2z5bDKiqkecMGfurzuAaYCN9v8SaWq5QC5l3oKZCB391KAZgPVVbj0FmNaHwRopsY85olzC3Ho/iPcZh+WHvxaDgy0sry9yxuhJ03QTPgk/Ku/4O8tKeBKfKirlz8I6GqQjYvF/DQriTIpKF/OyTskV4Su4AwZQuhdDZkapEgZ+dtagRb9OWL8DPU2Y8VKJxZzQVxWmN+m+AkerdifQUeYWYqsb7t4/FvkZn+39hr0AlAJe0uCoC5Nru3tavzA04/LPR1uppbO9lcd6Eny8mwGHNmGx7E1n29DIb6Sqt972bktfiSgPcucobi4xNQHROun7Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dvcTuKh50KYb3L2bpqRE4SH91DToGwHAzFI7P1Jt/28=;
 b=f1LrUVPIlnXkmKi3bORZz7JRnZTMsDa6+skiUTbU356JlvNPjruprvRLhWS5cu5hAdSGbJXD9byzXugMazkoT08Adwz/ooQikckh+NR0rmDW/atzLtwJeJdDk0muQ8lsxqdE9XTv7WvgmguNPnab8+iQKDtcdmM+qCCOcqYcisrDYrPWusTZQuV6ycC/znsAqJ02e571TcQri4X6OUSkMEFipRFtxKLz1Byn0VzLYugD4SPsqklYhdqb2Kyjut8joLb0eiS5N/5p2n75pO2OW1MYL/L7RlcKRfJIlsES2uwkCD3+1sjhv/po/UY5vPkGS6OOZ5cZhkzrN2rgWW5AwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dvcTuKh50KYb3L2bpqRE4SH91DToGwHAzFI7P1Jt/28=;
 b=ZQtn9eb+sg8KRem9KuIcg1akufE1R6s/p/CqvZwoWkVWg2Xr8gQZ1Izv7MXLK31mn7f84lLbs1g5fWXWeA64GdCMC3SIQGDO1E6Rnl53dqqCpsr2urkbBq9abnwW4IBjmcjzqU05sCzWyXbvmVcbIefTqKQzGEiHj8EpVmHuSi4=
Received: from SA9PR03CA0027.namprd03.prod.outlook.com (2603:10b6:806:20::32)
 by PH7PR12MB9128.namprd12.prod.outlook.com (2603:10b6:510:2f7::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 22:32:55 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2603:10b6:806:20:cafe::1d) by SA9PR03CA0027.outlook.office365.com
 (2603:10b6:806:20::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Wed,
 21 Jan 2026 22:32:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 22:32:55 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 21 Jan
 2026 16:32:54 -0600
Received: from aaurabin-tumbleweed.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Wed, 21 Jan 2026 14:32:53 -0800
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Charlene Liu <Charlene.Liu@amd.com>, Leo Chen
 <leo.chen@amd.com>
Subject: [PATCH 01/13] drm/amd/display: Enable vstateup hook for DCN401 to be
 reused
Date: Wed, 21 Jan 2026 17:31:37 -0500
Message-ID: <20260121223247.186241-2-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121223247.186241-1-aurabindo.pillai@amd.com>
References: <20260121223247.186241-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|PH7PR12MB9128:EE_
X-MS-Office365-Filtering-Correlation-Id: e84f54ca-6388-4873-5b77-08de593d056f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DRRtt7QCaeXhk62Q5xWTaMjthNu7Byk1O2kgWNGjbKHxuaQ6aLmq6y8kY5ul?=
 =?us-ascii?Q?2sqr7l8/V7gjl40oE5VmgyjVRaXFjojyPwloXuTMA0S7Qv80UdVHgif0d9+c?=
 =?us-ascii?Q?UnXdci482xgMjdgACJyXrBv2F+DnkS23Ya1ymj9FoEl67m3YornBpfuTuKFC?=
 =?us-ascii?Q?vla/XWfNWkx4m+aZdHUOjV9LrfrT/51VIiZkd2pSc6ltv+gC61qbzoBwEdcK?=
 =?us-ascii?Q?zrh6lMK7/E87gmXa1Giyv9ayJWJiIdTynCJjTBYOkTYCUoYlHkVMZVbIiyaK?=
 =?us-ascii?Q?Ir51Cv2J0YHqIC99pcAMxpMIc8tFvAZUyasrZt/OC/mbyhY06Wirld2MJycn?=
 =?us-ascii?Q?PMh3PV+wpnCThATiIU7tHZY/UGf7kDvD6lgl4EV6VAzjqK3wqJxQ8l34aBl+?=
 =?us-ascii?Q?zMS9PaEIQNxvpEso8n3RkiL+ur2hDBRG78KRrU58RulWIruGdOGH5/eU9oAS?=
 =?us-ascii?Q?ctMLU+NGh5WdgTFwI7WCvu6jAoXHCPdKksZokI+iuA+yv/75zE/7rGnzxvOM?=
 =?us-ascii?Q?+oBNTbYidsuMxXISh31vsHDQgsnjhx0CJp/MByEVRX86xMCIV3d4qzqmoaHf?=
 =?us-ascii?Q?J9fNnBBrSR+2087lDnTqc9gNsFvkb4UL/U0Ja1mHrQTKZFK0ge1Cxy3BuXV7?=
 =?us-ascii?Q?Eb8zRDGhVuRssYH8unx6WkvaxQueAHgMba1LNDAlaANM4i9y2khq3zFUb77h?=
 =?us-ascii?Q?5SRBtfMi6dSeyWv3mLmDxSxcESTCYwFyEFIGvnOeH5bZXihbU6DFBoxX1pnG?=
 =?us-ascii?Q?iRRT8rNQpOmSlT2TUJo6Dt2+D7R49PIQ1RJCFLwzkCyZWq5XF8sS0MVuDq+P?=
 =?us-ascii?Q?mkhIqq883Wd6YriuqpwxrwO6mosK0xXCu0ru1uxzp8gRP0ceBYzrSu3AowAf?=
 =?us-ascii?Q?gtG+3eeeBuCA73dMLM/TPfp6Z+Li2f7sqDCvZ00B27bpm+Gk9AhPOjKddPKv?=
 =?us-ascii?Q?ZO0BWYI8ucqyz0F9toYy/vGVq448oLDxoETapqt22HWUHenQUDu7APMvmCyg?=
 =?us-ascii?Q?GJDY/igRLZyRZ9919PV+fWL/xs8ggGidgMwElFq+dQqJxfNC9uIjx2rfI6WH?=
 =?us-ascii?Q?xMFivPhExFrA42nB61u7JJOY9+fzXgkzApk2PqGR90DgHF6DooRpG+lK0UaN?=
 =?us-ascii?Q?8ddKFOKJKApLfhFidkjcT8WZAhiEpnvMCL4lCY8wx8HKO0X36rMJaKIdq5hM?=
 =?us-ascii?Q?yuS18efCThmFGqk3WtteGxsMS5JafdaAHwPHxd/UbDqJJvjiZRcsQB9+mMCp?=
 =?us-ascii?Q?gsKGqTJnzrstke/7mto6LBilVQGoqg1pveQeD3zcY2wAqTguTc8yVlTkxRIg?=
 =?us-ascii?Q?X3RHt/kDf9W1ZtRgESMK3FdsQDkcm0hWG4uKZkxkfPOV4cF6VlyZlE1ci9e+?=
 =?us-ascii?Q?4RZQI0GVr36tFooQMhfsKRGvZQDLBp2qC/f85HdLYS5w4W0Ka90Jd17QSUyJ?=
 =?us-ascii?Q?/rPzIOy3tqTI43OWAlPDexFEvecINc2K3gLNkQOq/SbhFrQev5x2qVLXbzoQ?=
 =?us-ascii?Q?g6yLm15hFkrf9pCeZ1H2NismMY6+mAP7ZMNBxJGGbhJTZyxwp8E/ae19CehV?=
 =?us-ascii?Q?z9dH8LI/VJildmbJT8JKTqr4yQkX6H+XVli4kYRKvr8IdEdafd7g36/NF3xX?=
 =?us-ascii?Q?S85Wrs1G1U6MVwYlSAsGwnN2KP2tcTsY622pMAY0TW9ilKGxYnr+RgyxLe29?=
 =?us-ascii?Q?GwX6Ow=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 22:32:55.1603 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e84f54ca-6388-4873-5b77-08de593d056f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9128
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

From: Charlene Liu <Charlene.Liu@amd.com>

Add the hook to the DCN401 header file so that it can be reused in other
files

Reviewed-by: Leo Chen <leo.chen@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c    | 2 +-
 .../gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h    | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
index 875ae97489d3..1cdbb65da4a3 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
@@ -1772,7 +1772,7 @@ static int dcn401_get_power_profile(const struct dc_state *context)
 	return dpm_level;
 }
 
-static unsigned int dcn401_get_vstartup_for_pipe(struct pipe_ctx *pipe_ctx)
+unsigned int dcn401_get_vstartup_for_pipe(struct pipe_ctx *pipe_ctx)
 {
 	return pipe_ctx->global_sync.dcn4x.vstartup_lines;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h
index 406246a9867e..08bec1755617 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h
@@ -28,6 +28,8 @@ enum dc_status dcn401_validate_bandwidth(struct dc *dc,
 
 void dcn401_prepare_mcache_programming(struct dc *dc, struct dc_state *context);
 
+unsigned int dcn401_get_vstartup_for_pipe(struct pipe_ctx *pipe_ctx);
+
 /* Following are definitions for run time init of reg offsets */
 
 /* HUBP */
-- 
2.52.0

