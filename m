Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42AEDD3399B
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2024 16:51:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7DE610E510;
	Mon, 28 Oct 2024 16:51:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J/YqbMbb";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6742810E510
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 16:51:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qK11w4VhCkrBSY1IxY1f/xXL+H7VgJ+Q/mJ90TrCUqoYj4ZpmGErfIcBYFzmL1mLzRif43CyNEQ1Nt5Ajpi+yNaXy5jKLqYEpEsC9DSSOOFQVILHaxVbMZ7krN8urCljAyccMPRJD7CfEQajOby7HfE9JQGuUrq0bqe/7YOReL9/tU586KkdSZP+8seP9pJgd7Vx+fmUlHlJqa2r2XTd7btIwYabhHPrxdZLJF3Dml+pfa6ogAifahUbpi67pJH3UFEMQnFO6H7F1J7XGXLFzpwS+f8MCpKjxNqc52F40I/T2+8vws9GVtgRDVRo2kchhHKYe2S6+3WCDAjRi3qYBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+kpDz6BD59HeB27UdCDFOJ/Do9dF5FQEg6h9VufdXw8=;
 b=P/DhTieqVc05rGHZiAk6jte1xK3HaBZiIvbMN+b5Bdnvgsp4fSYEcwHs+zhOgLyrzxOOzhwj/QNuYhqrSNAiVDk9HwwkyjycnNe5Z/A78LnmnoTZyK0GnVi+6f0+Ysdr7skw9kN24rH4QhKT0pyUsPTKGVAjPPHlK+o7SGKFjonuLhKICCp0jVJPm9auLB0OODV66ZMukagePvWxs8khQrn/EgsmXGb05vxnncqeoUtCBDl/vyuOmWwdxDgEg47ve+bGD+m4f5SezJ66WGdzCBEhWNR/tf96MlZYZxDgQe4Aru1rKhxxJc6OhWXPbDHRSadaNENA+xH5HTTq9Q+rhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+kpDz6BD59HeB27UdCDFOJ/Do9dF5FQEg6h9VufdXw8=;
 b=J/YqbMbbD55XQBxTTJIa3YjaZM4TZPHRPE0xAAWMaJSxuKj0aAZixogZJvluQu0AVg6aFgBoYXqqx1U6gjQAJdMzK5pUY6sChYg/ubqFCz590sZeuU3lPDFcPfSwFhorw6fxiHvG9TnD7iZ65VOrVvLorMYYiBMm5qdqRpz07lA=
Received: from CH0PR03CA0310.namprd03.prod.outlook.com (2603:10b6:610:118::33)
 by CH3PR12MB9025.namprd12.prod.outlook.com (2603:10b6:610:129::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Mon, 28 Oct
 2024 16:51:50 +0000
Received: from CH1PEPF0000AD78.namprd04.prod.outlook.com
 (2603:10b6:610:118:cafe::a0) by CH0PR03CA0310.outlook.office365.com
 (2603:10b6:610:118::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25 via Frontend
 Transport; Mon, 28 Oct 2024 16:51:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD78.mail.protection.outlook.com (10.167.244.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Mon, 28 Oct 2024 16:51:50 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Oct
 2024 11:51:49 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Kent Russell
 <kent.russell@amd.com>
Subject: [PATCH] drm/amdgpu: add ring reset messages
Date: Mon, 28 Oct 2024 12:51:36 -0400
Message-ID: <20241028165136.4112276-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD78:EE_|CH3PR12MB9025:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e224298-dabf-43d3-4f85-08dcf770d164
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uGLGXR+U26P/GcPQaTFDRduJPMhQY+WE1kYDoa6OK4F9S1JkS8jUF+vXrBLD?=
 =?us-ascii?Q?8rpQlnP8Q+QAeKIt5DypiWQpkLyUkX7ob9mAin459NBA013UeAgnKnicYsYq?=
 =?us-ascii?Q?YmmUpevfKsXUfMFOzTCKaoUP+cgSspTbhGoV0io8D26IXtzRkhtk8XqhDThe?=
 =?us-ascii?Q?WU/B2jVY8asorN+HedZdFX5VO5k6/8XsVv+9tkK6D5fvrH/DcBsAwzaomEZf?=
 =?us-ascii?Q?EuYPzv5tw4NKaG8/YHOLd34e8xIwpj82sYlecAsNzeCNha4hkNYAwVUwcMxA?=
 =?us-ascii?Q?56jVGbyA5bsxzVAK7L6IbNOMVoogtA0MHQHETso0SNTEyh5uzqIwqI8CLVOh?=
 =?us-ascii?Q?NN+dzXZ8QoMSF5IJt7kskWpcVCPrkQIQpQGYEjlii/KdmK2RMiQlfPPepx2f?=
 =?us-ascii?Q?ikWp5wRhi6XcB2de45OadJmFYISQniadlpIo8t5vNMpueSXcrRky5IN6+/og?=
 =?us-ascii?Q?VL7N1gX8uVT7KfL8MnZTbbwXNPrtlYmPBu8TcIoTbN198V3DGpK5ZTiyz7zq?=
 =?us-ascii?Q?fToaWKZFmPo14FrY56NE9AokkKeKZkTeXQSCJgB8yJgoFcZ6YpdMoByoe4v7?=
 =?us-ascii?Q?X/j05a4MlAXm0dyc/XRRqXdcCpo7tu/Akb5VTga8VndIWx/qR1ACMceS0AFD?=
 =?us-ascii?Q?J/qLOAHQou3Fx3w2o0CF5fMmuJvArI6kDAxnX6l/E0YRfyPr3933GqHSPmre?=
 =?us-ascii?Q?AfGBIcnHezlpQXOkIzmT75voWhxBqbzvr+mAsVyJQqhjObvZjh941rioKEp2?=
 =?us-ascii?Q?lyb3LXcEWphW08+LBynj/fS7hgofrAnu6vikmYD9J/4USagdymnbw17HBALR?=
 =?us-ascii?Q?p76YgeUCtR1DA+8fSNDbEjshDVvupSC/xmDfGqhbNXzX6TGTra2irZ5y6yAd?=
 =?us-ascii?Q?oGmSQ60KSnaBin9fTcDGnT9mweo0xLscotQF6p4tiXHQNH61NiGknW4Zkr/w?=
 =?us-ascii?Q?iy9vQukpznakMr/lckoZO55hWdwfHDsmsu4mwseZz33uFpbW4qRkglDJeTWY?=
 =?us-ascii?Q?e1HYobWJ1C1N1xGAw9ooCrLDo6u8CNhYJDj8rJHEQdNiVg6mxKdBOXfZT+7v?=
 =?us-ascii?Q?y50r93L+sbp4Mslm4Fg6WR/XAieiDGEZPUhhuoaxI5j29IEl7FjwUTD7hCpN?=
 =?us-ascii?Q?n2n3DVHkM8Haytp5RODEi/9ZrLmTvb3L/mXPfurGgvuxOtTPm2Wxh7IN1xh4?=
 =?us-ascii?Q?ubmLcniaz/3fVUocqBFuUaihihj3XDAzatxsO+wPj2u133pdO39wUsWjIRLa?=
 =?us-ascii?Q?qNoiDaexUO6J7eh8OODbprgAtNHb+DruQs99S+EC81TiYLwr3rjIP6yFnwMy?=
 =?us-ascii?Q?12xideLIXhGqHyRBrWIjyvdfiFoM1rA6+ZiLr8CFRzPDW7jRMmFbWOXpPxnd?=
 =?us-ascii?Q?e2PYPjGA1RfbwtPp0VgGP8XrYU8cy/rkmszKHS1U9epxw9ymQw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 16:51:50.0240 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e224298-dabf-43d3-4f85-08dcf770d164
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD78.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9025
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

Add messages to make it clear when a per ring reset
happens.  This is helpful for debugging and aligns with
other reset methods.

v2: add ring name in success/fail messages (Lijo)

Reviewed-by: Kent Russell <kent.russell@amd.com> (v1)
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 717adcedf096..9b322569255e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -137,6 +137,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 	/* attempt a per ring reset */
 	if (amdgpu_gpu_recovery &&
 	    ring->funcs->reset) {
+		dev_err(adev->dev, "Starting %s ring reset\n", s_job->sched->name);
 		/* stop the scheduler, but don't mess with the
 		 * bad job yet because if ring reset fails
 		 * we'll fall back to full GPU reset.
@@ -150,8 +151,10 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 			amdgpu_fence_driver_force_completion(ring);
 			if (amdgpu_ring_sched_ready(ring))
 				drm_sched_start(&ring->sched, true);
+			dev_err(adev->dev, "Ring %s reset success\n", ring->sched.name);
 			goto exit;
 		}
+		dev_err(adev->dev, "Ring %s reset failure\n", ring->sched.name);
 	}
 
 	if (amdgpu_device_should_recover_gpu(ring->adev)) {
-- 
2.47.0

