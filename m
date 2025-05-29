Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B643EC5B543
	for <amd-gfx@archiver.kernel.org>; Thu, 29 May 2025 20:08:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CB5510E779;
	Thu, 29 May 2025 20:08:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vsZXiNlM";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A871A10E25D
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 May 2025 20:08:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PrJp/agsUpbGWH+KGaejxBhSeg7Ron+xeJcqlZxZCTyp5mNPkvjDVdHppOgO+3Eqvf2a0j4somP+TVWlS6yyWd1RaouQttK3c6+V8h7Q6tJzrfSOZAQ7lFZbdLAKhrF6L+OcbqnkHZ1aReZFhpp3dvTAuxSZxysv7NpeN65QrYDdv3soKEC5nAHXf/4XJZDVIa9eDLNoQUGourMYI7SN+nk+5hpjZpJg8+YpGiBaSl6PsldhG4IpZgxt8YfudOeph75UsreKBLYEv4S8iXw2tDhz3pIf+15+3fW7xJrnCk1+TadmRin/A4VXM7xJMPrWZNVe6m9mDj+UZcj05Q8/lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jVffteqiTuaRT2haD9Hm/o4MkqNZowXl4nHe0YLMIH4=;
 b=ABIZ63LQs9KK+uWXvM1bUlo1QogchQjCIvf5RXT1y1ESmB2YfzzjGOxMaCBOhcRiMUuc+w+SIjt/BWcB8usCyRfFxf3xeJqIiMgh9QPJ1LHrL8vwFq8g8f8giLndgJX4cgQVEDrgtWUyk3EdsSOb1awIQ2PRlwKB7hkCLkraXTu5o3Upa6D0vByUXXHo6vFwj+yt7GttTCB4MMzXTdu2HBs2Ss2qMqsQFJk4OJn7XQkS2/ZjEmV7fZQTq+usWwU3xfgmmfGP9FTaUErqODvLu5aWt/nhp9u0OATTtH1NSWxZYYn2biAlgjtvwUST22WflD85yHUaLplw3RlYXAEAOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jVffteqiTuaRT2haD9Hm/o4MkqNZowXl4nHe0YLMIH4=;
 b=vsZXiNlMQONW4OD601yizHDR4TNlrDgRAIofLM1UYQB/GtTQZc6T5683q6YosB8cQPilXOHuHDDTgSahvA5NxhiCb07dqhX92suGwurNbIwmXOyE79FkqDUZCYZIbfEvNvFtQ1a712n1OXPZHEc4l2oTPYPnqC99H1w8H5RlFTc=
Received: from MW4P220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::26)
 by SA1PR12MB8119.namprd12.prod.outlook.com (2603:10b6:806:337::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Thu, 29 May
 2025 20:08:31 +0000
Received: from SJ1PEPF000026C6.namprd04.prod.outlook.com
 (2603:10b6:303:115:cafe::3a) by MW4P220CA0021.outlook.office365.com
 (2603:10b6:303:115::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.30 via Frontend Transport; Thu,
 29 May 2025 20:08:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000026C6.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 29 May 2025 20:08:30 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 May
 2025 15:08:26 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 18/28] drm/amdgpu/jpeg2.5: re-emit unprocessed state on ring
 reset
Date: Thu, 29 May 2025 16:07:48 -0400
Message-ID: <20250529200758.6326-19-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250529200758.6326-1-alexander.deucher@amd.com>
References: <20250529200758.6326-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C6:EE_|SA1PR12MB8119:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d60a794-f97a-4cf3-03d7-08dd9eec952e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?17UORHPxlwZUDak6N7MutxacWJPe/9y+mpVpHOz1ik1q5h1AlY7DI/8csodY?=
 =?us-ascii?Q?Yj86lEumRWjMZeGst34SJShYeEFySnQxwEI6TKbrDrnoxMSVzFne2eLtG8xH?=
 =?us-ascii?Q?+qQVZgRs1c2B8aI2w72f76sAtlRGqPm6ktqytDwG9cwpNmAlerHxPMID3QlI?=
 =?us-ascii?Q?M08BnQUeV1JB4XT/Mvxp7KS3d4akiyp/S+CMQjd5Rq/XFQ/hpeNgRQoiineU?=
 =?us-ascii?Q?HS7wvkMdIyiKe6hKX2EkAufHRNvSOgFklGfCYuZDCCiJNhX0eHtame4Is9Nd?=
 =?us-ascii?Q?7XDVeXV0i4rhg8kMyhNjTn9Rjr9ln9fL1SEJK9yC52EMBE9eL6e1RAHuc8Z2?=
 =?us-ascii?Q?xRIYK5IqS8XSC/7E75NzQc/OW+dERvGQhRz7KvyUFo3DvfqB+ZqyNFNjlQ5B?=
 =?us-ascii?Q?iA4Dl2B0GsE5xYZ/H5rOeJbuzIZp4Irf/ysuQ2IXVWejSvZGhAV13X2diWA8?=
 =?us-ascii?Q?p2wua9ieM/oxKSTLdqJEYGvgu2k7HuoCqEng4P5avT0rpbu68ChJoduIrLPG?=
 =?us-ascii?Q?Cfa7P4lUFSId2Op6wKk0v2Y2ldh6IvTzuWgaROcn5/mgHvF8k1kq9aJ/cPDB?=
 =?us-ascii?Q?+OkNzfCzxGL8IgJDnkiVzDGM9w+61Bxoo8Bu2tdaFLEd/8K3nHmNSeuZSoR2?=
 =?us-ascii?Q?NHdveY9WWjrAun2j7nOpo+6sUSLz414geowGDeNRVg3Q29mtxXCun0BhguMf?=
 =?us-ascii?Q?uE6tG6PVao3JCRlb9KsRLIbe9rhqGIJeX26Sy1blCJCQfMd+cWN3tIh4dKj/?=
 =?us-ascii?Q?wcwYnd9hvku1oYAo+53+kIsLdY7p1TE6mUYQ9pzTGwArK7WyjxSbIOYzlBx2?=
 =?us-ascii?Q?dmnla2sRfb+yMNNiasV26nGCYHIi5mZ4PADku0HhVI8cSmGiwhRgaGg6+UbJ?=
 =?us-ascii?Q?bRy06Jh8s+SCKRLWswOYtUu/KiRiV+7FIrSE11PB1SOOV275YOh1d5BRz0sC?=
 =?us-ascii?Q?89EbcqjmqHbsdDtBzVo/QfM9HJRuNsRtHgG2LI5oChPQGdkYAMKNtUHGNPiT?=
 =?us-ascii?Q?7GJjBnIE2QZiISz9v0/dI64yIUIRWltW/yxuQlD+2zwcKLzYfN8WkaJWvq+B?=
 =?us-ascii?Q?UmPaPRcuHOaKN9qV4AZIuIu73hdlDTV4PdChOQ6I4ouwJ9KRyURmKZCP59h5?=
 =?us-ascii?Q?WOaqZ4cSWl7WLZFoIhBARJ0iKLC71s5qotPJGWjLq8hohPkSj99LqsZBTWYx?=
 =?us-ascii?Q?ua70pmv8NlosXIpCrauumOLTUgyNFpZOcJ8PBZJHHv3zqewLxoVjEOGZrvyD?=
 =?us-ascii?Q?Iaj+Rk3wEmkUrJkoP7/CHFDu06/+I5Vc4HPyfDVpokgOO2WBiufG4sH8t4oI?=
 =?us-ascii?Q?OVn9H8HSTB6davNLfprWMuN71mgWjvUqaxr5wIOMxtl7omvOUQFz5apYIREw?=
 =?us-ascii?Q?PscwOIpLeFKG6ahqRqCiqCsOupxeTCvd2fwFKwmCzM+pGIu8acGZvVx/imt1?=
 =?us-ascii?Q?f6nmQTtMG5h/CRjFMDAYxFPQmig/7W3kn+X/ly1c2Ks9IuboAkj+QfK90gPp?=
 =?us-ascii?Q?T9gLqLPScCaNDGGGTJiFkq7FlVDhjKpH//8p?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 20:08:30.7495 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d60a794-f97a-4cf3-03d7-08dd9eec952e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8119
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

Re-emit the unprocessed state after resetting the queue.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index 72d739e38a8ae..7105c5b995275 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -647,8 +647,8 @@ static int jpeg_v2_5_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
 {
 	jpeg_v2_5_stop_inst(ring->adev, ring->me);
 	jpeg_v2_5_start_inst(ring->adev, ring->me);
-	amdgpu_fence_driver_force_completion(ring);
-	return amdgpu_ring_test_helper(ring);
+
+	return amdgpu_ring_reemit_unprocessed_jobs(ring);
 }
 
 static const struct amd_ip_funcs jpeg_v2_5_ip_funcs = {
-- 
2.49.0

