Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BDFCC83F0A
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jul 2025 19:04:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0100D10E52E;
	Mon,  7 Jul 2025 19:04:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gq6ty81z";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21CED10E529
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jul 2025 19:04:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RzOl6ad62pZpxi4JrrrAszRzKNRnT1Bas8q8ZckTVtPGWt1V4uU6eOP3nkMXwWG1mPkN/1CZgKesfPzV4KFCflXTzxpeuxRqskPj+EtykZ8Tk9gAoA+G9lAw69+mOROrI4piDNA42AZh4SrKIgSCV8gfM3UyQuQOa5dFMegwO+bW7V5yFidiFSdhX3j9TmFlIwWiFxplZZTYhkRljWlmD6mv20Mtsh+S4mCQlRNJOG9AwCGkQfalHtgz5JUPVdfxhk25ZdpnaFB+SuGSIrg/qjnoaGBIw/9nzuA2KlQWBgtzyYhF7DKLiS3dzq6imSTgfYyuWLIakED3QQCOf3hpMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3hD6WSFDmuQtmBozHdNvZJix6XllG/VI2wDj2wlFOQ0=;
 b=Xqip15NVmZFYbnYqEY/ThYg2de3dL+d5ZnjYJ1I+mPBpq4FDlbIoR7jdn+U+6tUjoyvStwqC1XVpJe3B3mVQx4AVfIuGzlt+oQsJ/OCVFK3d5rYnzeD0DxBANjUjHZG1VKPSeULICNyJhe/ijI2tf4UMIcmpgFgpIpWVAWAp2omrPVuHAQu+1ZOhEvcbXZoHUocPnRv3VPkzexk7F223qe0KK8oquDyhylp1S+J5SoDJ8qlcMmw93xS4DhAH+0Sogo72kO1FMgNUWKrZ2WspMVKUxHS+Qzc3IknS8QjNPz8HOzhZvQTtoEvL4/1cTZCfPer8HgcLGz3yqAGDIenPyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3hD6WSFDmuQtmBozHdNvZJix6XllG/VI2wDj2wlFOQ0=;
 b=gq6ty81zFeBsrBKE0CwqSkGuQm5BoQdQW+/VB5GzWcDQfrtmj8bDxHm9h03Q3a8zpxgUHEk5WC0OKY0u9JSFJzQOFkGSiCbfhqo19lynW86jUIwdPY3RYYSnaCpv+9xPovv0rj9yl2w9IVayTQAGqNAINwPNmEgNfU+oGmwDCtc=
Received: from PH7P221CA0072.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::10)
 by CH3PR12MB8209.namprd12.prod.outlook.com (2603:10b6:610:123::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Mon, 7 Jul
 2025 19:04:19 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:510:328:cafe::d8) by PH7P221CA0072.outlook.office365.com
 (2603:10b6:510:328::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Mon,
 7 Jul 2025 19:04:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 7 Jul 2025 19:04:18 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Jul
 2025 14:04:15 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 12/36] drm/amdgpu/gfx9: re-emit unprocessed state on kcq reset
Date: Mon, 7 Jul 2025 15:03:31 -0400
Message-ID: <20250707190355.837891-13-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250707190355.837891-1-alexander.deucher@amd.com>
References: <20250707190355.837891-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|CH3PR12MB8209:EE_
X-MS-Office365-Filtering-Correlation-Id: f715dd3c-7cbf-43a9-ae23-08ddbd891347
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MWlRi/U2Z5JOKqJSGV0Z8PtBF6svlPaNoS4rFzu8AouWWuGIxttsAo04J61V?=
 =?us-ascii?Q?Iku/7tYnL2lBYdRod2LeUs90qaHKqfPpmT/3oJxpDeZP4IL1Pnrj9lYin3aW?=
 =?us-ascii?Q?hlGIe6Wk3jDluxWzp5glIA2DfF2dEC9euq/Gane6XUVoEfBH2gRm04ANuejK?=
 =?us-ascii?Q?8ncOx83dEA97bhmqtqWZRyufoGZcy9QzQEppy82aXoRnQVL3nmCYgceGg7XC?=
 =?us-ascii?Q?ccHaGNiRlg1mJcJKdrTVRZTgJc4lM6bKin8DJVIU9HfgC8QMfPcMjG6opcu3?=
 =?us-ascii?Q?IWQhhIxifk27mH6CG2vnoUG37ywB4jS1pS9/pE0p5MTnPKj7WiOL8Ju4k3M0?=
 =?us-ascii?Q?8siGxNr6ADY2Zaa9l3+uu/C+WN1OBO9vjuPBfhiPL54QTkW6DJZSBGR2a33C?=
 =?us-ascii?Q?4HatW8CMIwVo/v/oqjrq7Hvh3/YlOpByhUuFeelYqKM9ySIzJMQsbDgPQWcC?=
 =?us-ascii?Q?btKWnKInwi6e8kRnLjo2AVqU1Hxz7PFc8nt5qAh9076aMx2QdBycvmSZYN5k?=
 =?us-ascii?Q?HnfORhs81cvSDCkPQNtwbzth8coa/6wWuVJmWevKytO17G8KSv7RliFDOgjh?=
 =?us-ascii?Q?9mn8g1szFMdMKBkW1WZU0UQFc3l6R38SrzvFNkz0rrpgjXc2ysd8Ffz1zvYl?=
 =?us-ascii?Q?S251oW/isJcNZPMle9tg93nlsCQal5Il66I8mjLJffIlhWHRKyUtGKt3nUS3?=
 =?us-ascii?Q?2KjjnwbF6q+e2XPJNppFRsOLqrSYmeIyEjpmJ3rJzMJ1p3hBtWN4c+qTQL2h?=
 =?us-ascii?Q?1KmVm6NXYhH82V4uy2ryjns91++JUp7V3XJaule6TmVqs77eZi8ENZDmpXT7?=
 =?us-ascii?Q?2S8DixwCgrar5SL9MfuVpZ6wQa7BYTgcwl9sBZ3npXlMM7WBydq/CjUXMdNg?=
 =?us-ascii?Q?9r0qgOerW56/IXQkYI1Wn8QvfyifctcToFxYGKE/BumOSiXF/oOaRZWakLnO?=
 =?us-ascii?Q?lMdYSpz0OM/cR+qmr/waE2k07FKZOf2Twc3xdFjIa/QFJDZKcgYJW8GvpGHc?=
 =?us-ascii?Q?2R203BshwTuzGHYFMuO5WO8pWrVE5wWiMFyK9laUHu9yNbCv/BrDCcnQ/4u8?=
 =?us-ascii?Q?fe7aHDKPGIprDW8p97Ar0ZRZvLGM+YGAiDgwbIeL8y6FPIfB6imsj0YqEBMa?=
 =?us-ascii?Q?kl2QeOcK0TjqVUoQfuDUvoh0TfwYucxNEKUF2TZQ8RCpUk6YHWwXhIA1ms0/?=
 =?us-ascii?Q?CUKhTko2N+YhSuHOrMyKmnTgi4Knm0QhJC7WM+IoSS9/NZJ1eYc621CIJGKw?=
 =?us-ascii?Q?AX+J50GB6cu67adVM0mYATsOmB++TqUUwkslD5ybmTPTYrOOg994nR6yma6P?=
 =?us-ascii?Q?eckKqGAD1kmYARER7QYq8cmR9aj4S3n7+vDy7C6TOW3FuE9IGd4M6J8sXqKb?=
 =?us-ascii?Q?ENQkjIPQDSfOykC/K3IG2JQ9Jw1lGbwzcqU2TsFak/WSQ6WIzVqf92keYCJt?=
 =?us-ascii?Q?O3DAbraEeEsohUG/gYxdaHEceHFxrcsXKP9JU4SAQewdRfp4XBuja/HXlQfe?=
 =?us-ascii?Q?Axdz3WEVvnXc07BsUEYdHtm8ouwF9Lngy1hv?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 19:04:18.7224 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f715dd3c-7cbf-43a9-ae23-08ddbd891347
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8209
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

Reviewed-by: Jesse Zhang <Jesse.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 4c61157405b07..30f6b04cf82e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -7187,7 +7187,7 @@ static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
 	spin_lock_irqsave(&kiq->ring_lock, flags);
 
@@ -7244,13 +7244,7 @@ static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
 		DRM_ERROR("fail to remap queue\n");
 		return r;
 	}
-
-	r = amdgpu_ring_test_ring(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static void gfx_v9_ip_print(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
-- 
2.50.0

