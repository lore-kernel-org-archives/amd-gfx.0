Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1301EC4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Apr 2024 13:49:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AFC510F423;
	Fri, 26 Apr 2024 13:49:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EFJxHZcN";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0EB2112415
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Apr 2024 13:49:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJcLlVM2GYJCerdGBJuL34CH6ASrYi/2IvaPGoU0Epqx3jm6u5DZxGXS08o4QyhIOTDW912BdSlDzJjk/9dkwZCn/lHJBDpuJDf1eV+wI+hj9Zi2HFYTJe8h+MW/4U+mo9h/EGFeRoxgbFybM73sg9a2vTSAKc/bdVgjyOqb7taTFVV+38W78oVc8k4kCriOOFCNCCumCeH61nSfzxCP8gNuiqMrRTQU6cpwrkBIY1Jqb20KFYSmxsKekvZ8V2ADVj8JEMTuSGeTHYtvqyUl6frREX2DSXvWUZqKQjTGZ8ohR36C3rsZ1c4oQLOqIQSLp/OGLmSpTvdPUtjW6RMMpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hz11V1eVvuCqmMe1nY2PVatLA46NZMYfLQ6yT0RG/hY=;
 b=E75rUgJPN6DQMKmKkXbDvkS2IJuwsiE+uiosy0sb7X71M+DObBNfHgV///xN3RR9R6vnilwyXkRw9GzqUeLqkA++y30nwF0kGNAV5TGixUGaAEiJVSShrxEJ4n2P9h1qQ4Dr5l1YZZ8LPi+qhidxDdTSk/sNW3EpQNZGqWHlNHmyJuuWW+VgTz5kdc3rwpkR0mk98fzo1hBmIVKPbj8CrF9//Cp8Qk/nRBRD6VNkOgcMm2/a0uJ7ZEISsVtwnr2PgegRxcAArWDoIggugkJ5SOmzYO77F8/Ke27pljbiiqKgJTnWCXL+RG9Rb+xxs7ZJAZEDAy2tUXPRI2++xu803w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hz11V1eVvuCqmMe1nY2PVatLA46NZMYfLQ6yT0RG/hY=;
 b=EFJxHZcNadzNDT1z7sKadXiwBG/SwSU9cBioq7SnBKHrA6s0yggkdBqjMWQpi6tMq9DISXZd7vgkGReYe2NdGcabxVzqzCHe+3tyTgZF/qISZ2rvayHYk4XmltjAUqRLFP+du7YqqWFUEzEN+9Dqssn5YIiPaYIAvhJHaj4tq/4=
Received: from CH0PR07CA0007.namprd07.prod.outlook.com (2603:10b6:610:32::12)
 by LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Fri, 26 Apr
 2024 13:48:58 +0000
Received: from CH1PEPF0000AD79.namprd04.prod.outlook.com
 (2603:10b6:610:32:cafe::b) by CH0PR07CA0007.outlook.office365.com
 (2603:10b6:610:32::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.29 via Frontend
 Transport; Fri, 26 Apr 2024 13:48:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD79.mail.protection.outlook.com (10.167.244.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Fri, 26 Apr 2024 13:48:58 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Apr
 2024 08:48:56 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Arvind Yadav <arvind.yadav@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>,
 Shashank Sharma <shashank.sharma@amd.com>
Subject: [PATCH v9 13/14] drm/amdgpu: enable compute/gfx usermode queue
Date: Fri, 26 Apr 2024 15:48:09 +0200
Message-ID: <20240426134810.1250-14-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20240426134810.1250-1-shashank.sharma@amd.com>
References: <20240426134810.1250-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD79:EE_|LV3PR12MB9411:EE_
X-MS-Office365-Filtering-Correlation-Id: 71cdbf98-a4ff-4c09-d5f8-08dc65f79f66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?g+HaLNpMW0cHhqKZ08kz+mQIMnTiXAEeuPW/GeqoaXJU2fuUKtzwef56eoi8?=
 =?us-ascii?Q?v4pMf06jCQzo4p/VD0YOtkjgEjbKlwO6cmvKwTGHh9JTqzX0jHTtDifwwcWu?=
 =?us-ascii?Q?nCohHWabQPeeofrqzgVWrxHzR49/fn0jpaRCZ4WKZnXq/WfPRHgu/NglbnQc?=
 =?us-ascii?Q?OW2kg0oyk92flU1IrYJoQXsGcfIySCxBjQyNrIbrpP3rjzQa4kZ65Nx8EeV1?=
 =?us-ascii?Q?Zqbw1zDn8/1rAoCKy/06GCr44WOAGmZR+m5C/3ayK5V0GBjCeZUBejMMJscZ?=
 =?us-ascii?Q?YcdNqTC+9m9iBgSwuMACv+8/L0LIp+1MkmQh6Q7NKbwSyDejA3WQDwsHSPZ0?=
 =?us-ascii?Q?/x/aMSEaRywkL/kX8dZM9AP/A9FD6qOQtoYiKtFAxAw5cYQGlYMHry2BRy62?=
 =?us-ascii?Q?f7mEXF9Kqs7yvpJx7463cc7ft0CBE6chh3/0PiWbug9pZ1/y2Tx7fowRo3kU?=
 =?us-ascii?Q?Q3Gva7WxUWMILcNK3jIMPBjATZ8kF2wmaDoRQi+R13y+k+psFTMbFSJPNLb+?=
 =?us-ascii?Q?x8lQv/VErglhZEnCRUDHTyBCgvWchKkzpFEKtLKjIFCHRubjB94ErcbWZm0x?=
 =?us-ascii?Q?Xp2Xt2wY/DRhvlL9H1q3MFi2YLWC9d9HgKMV1lbMeObWL9F/9yTKfp0xA5Nt?=
 =?us-ascii?Q?KvVhgVe26s/gp7JL+UEUuejw9fO8Hgyx7Np+Dw1PiMSAf3J2eSk6IjauOJwr?=
 =?us-ascii?Q?1Ne60GkXZ/2s1eyJUriIg6aRP4cKBYBCx4HnLruK1ypF1kkBDRWSwPZFdDKv?=
 =?us-ascii?Q?9zOGD41Vz6tIloD8f3Znrzau0HSpojdH4WyulY7hkdEgLaaM3qedHiW5OlIX?=
 =?us-ascii?Q?kqCdYJzJCFcMXx1fpwWK0F0BAlJvnOMCI+DYxm1JY9exAr3MzoYKMlDYXiGG?=
 =?us-ascii?Q?Gtcbir1YbDy5+PEijXT0Ddb+bf7pGizC6IRVQB5mG8LWfwQP9y1KgvMb1uwf?=
 =?us-ascii?Q?Xbok4SBeBACPMcMRCBUQB8x09CfQf7XEq+OFs6sRWMMyEeRyxdyDEuOuHPKV?=
 =?us-ascii?Q?V/Sj77swJ7UdsmbonuUoOQKJWQ+Tg/2ZoBwMkBb+LfFydlVC12KLbPBtXHIV?=
 =?us-ascii?Q?irucqrnDWJ7RlaFW633pWs+x19VqItFGZmuMobcLHpDg2l67W46NOmvlHOmv?=
 =?us-ascii?Q?cEo+2UrxjLDAWJD99d7H04acWZ4KATWQbll5puvXbAJZdPudq1T7RUdWiKXf?=
 =?us-ascii?Q?RGrx8dbsQG8/hkgcluRvoZKqSnpX5jcFjJziqdoPOYL0kHvCDW3wqtm3C4pG?=
 =?us-ascii?Q?t3WPUnJaXGk/6ZHDTbrg4YtVWMYRBzh2TKUGwmehOjCYdID6wxriZXNs4zbQ?=
 =?us-ascii?Q?lXgWhZe23EEtYu/BeNuK0M6DdGb7nlTOzC/LAibg02kc3KJ3JB4hULHd3ABa?=
 =?us-ascii?Q?XEb9LdCGDOHoBTtcd9nc1a0hhfVv?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 13:48:58.4318 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71cdbf98-a4ff-4c09-d5f8-08dc65f79f66
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD79.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9411
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

From: Arvind Yadav <arvind.yadav@amd.com>

This patch does the necessary changes required to
enable compute workload support using the existing
usermode queues infrastructure.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c    |  3 ++-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c           |  2 ++
 drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c | 10 +++++++++-
 include/uapi/drm/amdgpu_drm.h                    |  1 +
 4 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index e516487e8db9..78d34fa7a0b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -189,7 +189,8 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	int qid, r = 0;
 
 	/* Usermode queues are only supported for GFX/SDMA engines as of now */
-	if (args->in.ip_type != AMDGPU_HW_IP_GFX && args->in.ip_type != AMDGPU_HW_IP_DMA) {
+	if (args->in.ip_type != AMDGPU_HW_IP_GFX && args->in.ip_type != AMDGPU_HW_IP_DMA
+			&& args->in.ip_type != AMDGPU_HW_IP_COMPUTE) {
 		DRM_ERROR("Usermode queue doesn't support IP type %u\n", args->in.ip_type);
 		return -EINVAL;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 525bd0f4d3f7..27b86f7fe949 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1350,6 +1350,7 @@ static int gfx_v11_0_sw_init(void *handle)
 		adev->gfx.mec.num_pipe_per_mec = 4;
 		adev->gfx.mec.num_queue_per_pipe = 4;
 		adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_v11_0_funcs;
+		adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = &userq_mes_v11_0_funcs;
 		break;
 	case IP_VERSION(11, 0, 1):
 	case IP_VERSION(11, 0, 4):
@@ -1362,6 +1363,7 @@ static int gfx_v11_0_sw_init(void *handle)
 		adev->gfx.mec.num_pipe_per_mec = 4;
 		adev->gfx.mec.num_queue_per_pipe = 4;
 		adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_v11_0_funcs;
+		adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = &userq_mes_v11_0_funcs;
 		break;
 	default:
 		adev->gfx.me.num_me = 1;
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
index a5e270eda37b..d61d80f86003 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
@@ -183,7 +183,8 @@ static int mes_v11_0_userq_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
 	}
 
 	/* We don't need to set other FW objects for SDMA queues */
-	if (queue->queue_type == AMDGPU_HW_IP_DMA)
+	if ((queue->queue_type == AMDGPU_HW_IP_DMA) ||
+	    (queue->queue_type == AMDGPU_HW_IP_COMPUTE))
 		return 0;
 
 	/* Shadow and GDS objects come directly from userspace */
@@ -246,6 +247,13 @@ static int mes_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 	userq_props->use_doorbell = true;
 	userq_props->doorbell_index = queue->doorbell_index;
 
+	if (queue->queue_type == AMDGPU_HW_IP_COMPUTE) {
+		userq_props->eop_gpu_addr = mqd_user->eop_va;
+		userq_props->hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_NORMAL;
+		userq_props->hqd_queue_priority = AMDGPU_GFX_QUEUE_PRIORITY_MINIMUM;
+		userq_props->hqd_active = false;
+	}
+
 	queue->userq_prop = userq_props;
 
 	r = mqd_hw_default->init_mqd(adev, (void *)queue->mqd.cpu_ptr, userq_props);
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 22f56a30f7cb..676792ad3618 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -375,6 +375,7 @@ struct drm_amdgpu_userq_mqd {
 	 * sized.
 	 */
 	__u64   csa_va;
+	__u64   eop_va;
 };
 
 struct drm_amdgpu_userq_in {
-- 
2.43.2

