Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6AA3C021B5
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2025 08:17:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 794A310E036;
	Mon, 24 Feb 2025 08:17:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nWdIRhUv";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F61910E036
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Feb 2025 08:16:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sgzoTxKivQ6xL+5IVsa6+1vVbg4phTgnwaYy7q1xAN/cZAwfdiXF7/SAEJMZ/33ynujJlATl7v1J/gnDYlmpbMPcNVAW4roj8gHm3ZUdbwwCjkdM9znanaNNUK+Sw847DJz/VxL2kRese/JNY5Xb5Gap5WRZQNMcVaGEDBIfRJWn+rM5PXaa5MhdAFM2w0p/CzWTuBuvaUkvxTuoWFShWHp6ANf7m4xFFM0ekUqP9+OiqHE0uNcB9X9ystLpoQEUnUZ27qlLIefqMrbUD8d8+3rY0tOB2/ra/g8Svoa0PH8K8+3az1AXi2mENulOBl2r86Agpdk0Li9/zlfJ4CBYrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rS8mmg546aMJTMCl/TSR/HlXCZshtZFf67aeXbmoma4=;
 b=WJNHUpptFllk224Ue/NYG2y5JC4Tptx3Fu0lCY/BPOXs5enfrLLEBVKxkG+XYLvKOqCPiXJDKsTXkYTXyGtqP9SL1dCN3sX2HLXRAbuBYJjQUoBcGyoVAQykqXdr9+P/fKAE79wNiYidY40fXDHqj5zr8uEzrXlkyhPKjz3xl556dSjVyBdkuE5wX/QbN50oGRuaI0c2mngfVSxiFEUOYXHrINm2ZUU5IMBwSCxigQznN7aNX1FksbNR9VWvVlMUPhBNnXAM8bUmvO5oBKIG8IylRo0xMAnHtCvXNBzkDv9UzwTohNh8IbH54troHQn5pbSmyqaUBkhHeB1q0tLa1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rS8mmg546aMJTMCl/TSR/HlXCZshtZFf67aeXbmoma4=;
 b=nWdIRhUvwcTMy1Y5v8q6yrF7u+zN1/hgzqwN3dg9ADVw84FbFm3Hw3ZEQSZoHP3uNvO6IhrsQzBSY/JCenWNEpuAuvb4k7BvXfM7CoLNU74dbITDl3ijq8kQRIWXyoeTw1Tut9P6FaTLX3mCSOqVLXWSyVWr0CnnpAkwlVis4No=
Received: from PH7P221CA0019.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:32a::15)
 by IA1PR12MB7543.namprd12.prod.outlook.com (2603:10b6:208:42d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 08:16:52 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:510:32a:cafe::62) by PH7P221CA0019.outlook.office365.com
 (2603:10b6:510:32a::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.19 via Frontend Transport; Mon,
 24 Feb 2025 08:16:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Mon, 24 Feb 2025 08:16:51 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Feb
 2025 02:16:51 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Feb
 2025 02:16:50 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 24 Feb 2025 02:16:39 -0600
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>, Jesse Zhang
 <jesse.zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: drm/amdgpu/job: fix is_guilty logic change (v2)
Date: Mon, 24 Feb 2025 16:16:38 +0800
Message-ID: <20250224081638.4119472-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|IA1PR12MB7543:EE_
X-MS-Office365-Filtering-Correlation-Id: 7104eef8-8cfd-4850-cbde-08dd54ab9790
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?k2AIgZXr3IZTCO8X4eSQIfUVrrdFatgkSU9Uxgvlk9oEASwElOAWEF47CGWT?=
 =?us-ascii?Q?QSL8rk0OvDhGFPBlro0khA2dQEokPAYRJq0wJfQ16TiRLdwoU0wLpOoTN9rx?=
 =?us-ascii?Q?pAUCrjJEndZjZS/ernbNSciAHTlg10srtrKI+RnMETeCl3XbUiValA2Rvqlo?=
 =?us-ascii?Q?xrgWRff7A3THGWFg/ZqHHH45bO58XSldfIaaAMquatclQy7I7bHA76qMKKlg?=
 =?us-ascii?Q?ctCmI+h0LGEW22jf4i3ecXA+aDFSwDMw2k9Rf/R3lcELPCelAXd/5HBhLQMW?=
 =?us-ascii?Q?ZijANPlVyeRpAMr858jXmPm8l4lTFkcgPs9nzleC9rJfdT80sMhze+V9yWKg?=
 =?us-ascii?Q?28zBkFit9ZKC9C2OP4ey87KHoQzMgH5N8mxJ3XhvDEFITqoQjlIkBP7DLq6X?=
 =?us-ascii?Q?JTND3Y/gXLghzuRRCgDK/OP9dOygVFPxReH1sGAGRu5EWPooU3/h3tA0yksy?=
 =?us-ascii?Q?jYJDfkCKpDdjVcY+m4g7bz1Cq0TAq+EkYKG3wxlam7vQDcFMvbIW8l4Y701N?=
 =?us-ascii?Q?gl1ikFuw0hqIK0J5NaiSMPqK89hMAmXxKjoASSeywGYHphye/DjpZG9qjZch?=
 =?us-ascii?Q?okzwSIqzTuxFlJ3BPd6JP0hbuwjXUP2TjBFe0A6pPF79laNb16iV6J1tsRlP?=
 =?us-ascii?Q?PILYdRmqKlLc/LgZoFFqnXBo2S0v80YbjjaT6mIGP0Wl1K3KpTvZV8HsNN7/?=
 =?us-ascii?Q?jchd/0dmauXtjFWD633J68nA+wd2dSZrmGRPoWW431qExcJhUxrGNV08j/fZ?=
 =?us-ascii?Q?yV6JLI4vL5s48VD9QIpuLshU/4Uk3eB5CDngoF49TuGoyo9gcN07yYtyuvET?=
 =?us-ascii?Q?Cz+Jng4/a6RDBviZJJdZDiZ612u4RQPRPMUlj8z5g8U1cG18o+g9zLAKutGN?=
 =?us-ascii?Q?9BYfkLlCfvcp68Zgl9Lk+HsK/qoey1HtVVI1FfyyncajkkciDhbguQXy0TOx?=
 =?us-ascii?Q?tQFDrTA0/kfTsfU7DRt6kCYiu/BXzZodk844DAcab4XTdKCRSMRjaxo785az?=
 =?us-ascii?Q?2YJ1YPFxzQ87mQ/esk10PQOcsPWc/+4aaGJJDY1OYlYGEBaJlNPmhto75RNE?=
 =?us-ascii?Q?HiCjtmb3nQk0pkr0Sj5kH4ACytKulHrnhXOz0AWrs96jZ59XUfGcDo6a7re+?=
 =?us-ascii?Q?2lO9H1sOwpziAAY2mJ935c01WaoV7xQt7DyynWB3JbLMxhy+vZNPWsWUJet/?=
 =?us-ascii?Q?DJ2SxTgUkCxQH5G2xpn1MFGrigzs5+xWcXGXZrGYX4jXnxqu9uZxwRZQHmXg?=
 =?us-ascii?Q?dEH0H/eAFN0PwKGnY8Xs4v8+5FNeRCspTL/JeBq9DiSuFdadEaPGTm4nf2iB?=
 =?us-ascii?Q?rXOccTGx6TiTyGsiKSKm2kLEWman++HGQNd3bIzFio+mR+EsRBR3FjIMkkMU?=
 =?us-ascii?Q?XfWd9vJ3sGhehoZfWKtJUcEF67KzNrDioPSraelWcSvxpw0MGxbukGRI0ao4?=
 =?us-ascii?Q?6YL77FzEblf0LjwiZM8JhLN6WimHzFAw5rnEmzPZflWbGdqqB80LAHmJ1Sok?=
 =?us-ascii?Q?AbAXEJhhvLHRhdg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 08:16:51.4686 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7104eef8-8cfd-4850-cbde-08dd54ab9790
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7543
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

From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>

The is
Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>

Incrementing the gpu_reset counter needs to be in the is_guilty block.  Alos move the fence error before the reset to keep the original ordering.

Fixes: f447ba2bbd48 ("drm/amdgpu: Update amdgpu_job_timedout to check if the ring is guilty")
Cc: Jesse Zhang <jesse.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index efba509e2b5d1..c37bc683253a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -151,14 +151,16 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 		else
 			is_guilty = true;
 
+		if (is_guilty)
+			dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
+
 		r = amdgpu_ring_reset(ring, job->vmid);
 		if (!r) {
 			if (amdgpu_ring_sched_ready(ring))
 				drm_sched_stop(&ring->sched, s_job);
-			atomic_inc(&ring->adev->gpu_reset_counter);
 			if (is_guilty) {
+				atomic_inc(&ring->adev->gpu_reset_counter);
 				amdgpu_fence_driver_force_completion(ring);
-				dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
 			}
 			if (amdgpu_ring_sched_ready(ring))
 				drm_sched_start(&ring->sched, 0);
--
2.48.1


