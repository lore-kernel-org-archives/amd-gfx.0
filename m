Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEF18C3DA4A
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Aug 2024 20:25:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6895010E27D;
	Tue, 20 Aug 2024 20:25:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="G4psoFxu";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7659410E27D
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Aug 2024 20:25:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bdws5xwTZcp0bnyMeoJRPf0JazcDJ8yH5k8rYMQVjbtT4AHjpLSDEWxc0t7akrSzgmZbbMuiaetHXyfJk/MsTOBaoE3TLGU50bMrT+K4e74f/+/R/RB2uKOHeVImmMHLHc+eYWFTa3JTkk6VQHImGKz75816VFBjTtcvWq3QPr5fwd2OzRKHA9S4r5vR6TyaoT3hTOxwevWYioRJ/lWZxBUp8X8q62koGXUl2tvTtMI4U8/61HZXot+ZaLjUxg7pmN7y1eCNOoQeO/1RXwLSt/HTeEkFij3+vWl7pHfeMMvXKwRDONoktla/YnpcekE7blIzcwtZhrMkJyiT761V/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jff27jqYFHk5mV10OkLJoGqH3y5RKT6DaFB1REuP4Cg=;
 b=ycycdlQhlxFv3IqHN2kjRp8qZ9RdewO8dYtiV+TlmaObGS/Vis8e8F0kJmLggx1ZOm7n2ywcXhIkG3YbDtEyNGAGTtVIJfJ9BGVff0lH2zwuaBFV8Uq7lcEKxOjkjhvBYIKPF5N4O17uj/a0zZj3ySnXrNvTE7TjblN/5ezbn4VP16YUS3ROa6A4R53Y2gycceccAiCWuH6kFkW7rC2cFp2tS797ygoT4i9G49DJs1/HOsgiGn80qql6hVoCS4T95Zvxsvm99nYBKeeo2FOCI5q52dNdddw8+LFExdoVP/C43pabgLMEbTuVO/cWcSBvl2SeOtTl4tgEyv/nnz7Gdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jff27jqYFHk5mV10OkLJoGqH3y5RKT6DaFB1REuP4Cg=;
 b=G4psoFxuDpfax0go9haCiYUfWwRpDy19go0B+zMbl1bq4JOQpq/0Q2buf40xc6Z1f3uO/uLlrLgFK709a4PQ/Z7EZsEzu+ncATwGWcXjHCMwdProEauvwvQ0CnW9xRmTLJaHGgs8iGe3+VLETujzI94f6x8Kplu/F1icTvPhSY4=
Received: from MN2PR06CA0022.namprd06.prod.outlook.com (2603:10b6:208:23d::27)
 by MN2PR12MB4390.namprd12.prod.outlook.com (2603:10b6:208:26e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 20:25:32 +0000
Received: from BL02EPF0002992C.namprd02.prod.outlook.com
 (2603:10b6:208:23d:cafe::79) by MN2PR06CA0022.outlook.office365.com
 (2603:10b6:208:23d::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25 via Frontend
 Transport; Tue, 20 Aug 2024 20:25:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0002992C.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Tue, 20 Aug 2024 20:25:32 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 20 Aug
 2024 15:25:31 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/gfx9: put queue resets behind a debug option
Date: Tue, 20 Aug 2024 16:25:18 -0400
Message-ID: <20240820202518.2110483-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240820202518.2110483-1-alexander.deucher@amd.com>
References: <20240820202518.2110483-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992C:EE_|MN2PR12MB4390:EE_
X-MS-Office365-Filtering-Correlation-Id: 64d1e87f-8af4-4a95-5d5a-08dcc1563db5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sYETBDR+KDFM0h+6q6B1hdrxBtNF+hw1vdk/kV7YVjv3ok2zhxdLQnb1PP7g?=
 =?us-ascii?Q?DK9kqQnqZ9skmyY+gMtirEoZcUMGfTJ7Tgu90c8+H6440r04U0/TAbA7rAtq?=
 =?us-ascii?Q?kNxpQ0wMwbVOrpGUOZCzLzzslPtEO3pO2nihiLrMqnrZ2JuABRgvpU/j5YLH?=
 =?us-ascii?Q?2Yek+r/UKCdJppU/cgjmObEdlAGzFkNjADLNM03Qf+nadpnsbjwLdsSaU4RJ?=
 =?us-ascii?Q?DKnGZhFcDU9umWweyUWxlyPQ10ZjW417AOmeDykp6mHrEyzjPL47qMkoRl5t?=
 =?us-ascii?Q?q1GN0PFkXrL7Sy1FLDTDkikqZxiMvNM9G8ZjWh4H6C+plbtwJZbOFz9rOTRL?=
 =?us-ascii?Q?EoBRzkxa9R2JC8d6BFOTU8Sne7ZxDmANAGDVpk1aFfF4O0qo/FdVhqlD1Df9?=
 =?us-ascii?Q?X7fpMxZfnAie+9sFXauSYU/4qborWX0c8qzLJme03uYq5wIPFZXIezdQOxqc?=
 =?us-ascii?Q?qsbfJE6EkwsLhaOOyIae6cqzN4jXet86m9WxN8pvF8O5F3knSIUCbhJXbSaV?=
 =?us-ascii?Q?LpW/1IMJiMvA0FOmm2rocsLcfQd0hnSdKK0OWDYG2EtGefMps4G9Md1sLe0/?=
 =?us-ascii?Q?ZaLFKNU5bR5iUnDvmoG+ZU5IPZOrA57hy25qsAG0lRCDOt8S5ALz0py8f5HA?=
 =?us-ascii?Q?Bm4bLGggCSKsWVZs3fDKp3Kek6fPuowgBrr7NsKSUa9F/ps7vRZXqaTGKotr?=
 =?us-ascii?Q?IjgMcqURsw0JYhDa72JH0Lp6JqMPA8cxvwusrt4lBSmN0qk5xgB4etRWjdaP?=
 =?us-ascii?Q?u6noz3rxvzvb1QQi1YRkF7yjk3Z69Er8rWTDiqvnATiKIiHBpKZrwmxKTJy7?=
 =?us-ascii?Q?ZaAWAsB+zu6BGPIbzUNevb/QumvUktefYA8Y4hAxT7e074xYrbdlCV3hxh60?=
 =?us-ascii?Q?rBD8JI1H4DXce9fLQvCpMx3jcQxajwkXrEOkyNdJ9cch7B7q+YhEpffY1Xs9?=
 =?us-ascii?Q?tUid73xVmtoEXLdOa8r+bWasUgqVQN6teobfZzxsT52r5WjLk8zzxCb/7H2Z?=
 =?us-ascii?Q?uuYXtA0WABM942ufMd/SW679Y9bdGcNDZBh+qHQGjxyyD3fBUIss85erODlL?=
 =?us-ascii?Q?+UtgmVuHS2GeEQz4DuK8EuhHQIkntLd5R0dAdBRUedLlNYMTShz5xLbVHSq2?=
 =?us-ascii?Q?G6ZyeHM3HmQfrykq6YGNyf8+Zy3xHVOhHvUEpalpADEwaGmNdJI+e6R1Hpan?=
 =?us-ascii?Q?AHKbnExvsVmYZ4/XAZo3CQB8mcYt7hynCr0lnIqVzb3XalslQpjucBS/GKKY?=
 =?us-ascii?Q?4hcaZ/dnymRNmN9lTNwnGLk50rnx6dY+iXaRtMi792dJwYMvOzfhAxrwCFbJ?=
 =?us-ascii?Q?oGxlrm43Sp/g3D8Y8mUiyu3MKXp3xEPrRudSHitcgmFUcD40gGPtNyWoZLDL?=
 =?us-ascii?Q?76+8U8i9ZooKMUYd2jdUSpowEjCpFJkHd2+56Osv3Y2X7sVluk33Z5LAyj5e?=
 =?us-ascii?Q?zBwQgGeojUXskk6ZWmoS1kvXvelgrT7C?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 20:25:32.5787 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64d1e87f-8af4-4a95-5d5a-08dcc1563db5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4390
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

Pending extended validation.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 4 ++++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c             | 4 ++++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c           | 6 ++++++
 3 files changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index c63528a4e8941..1254a43ec96b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -1151,6 +1151,10 @@ uint64_t kgd_gfx_v9_hqd_get_pq_addr(struct amdgpu_device *adev,
 	uint32_t low, high;
 	uint64_t queue_addr = 0;
 
+	if (!adev->debug_exp_resets &&
+	    !adev->gfx.num_gfx_rings)
+		return 0;
+
 	kgd_gfx_v9_acquire_queue(adev, pipe_id, queue_id, inst);
 	amdgpu_gfx_rlc_enter_safe_mode(adev, inst);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 21089aadbb7b4..8cf5d7925b51c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -7233,6 +7233,10 @@ static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
 	unsigned long flags;
 	int i, r;
 
+	if (!adev->debug_exp_resets &&
+	    !adev->gfx.num_gfx_rings)
+		return -EINVAL;
+
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 2067f26d3a9d8..f8649546b9c4c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -3052,6 +3052,9 @@ static void gfx_v9_4_3_ring_soft_recovery(struct amdgpu_ring *ring,
 	struct amdgpu_device *adev = ring->adev;
 	uint32_t value = 0;
 
+	if (!adev->debug_exp_resets)
+		return;
+
 	value = REG_SET_FIELD(value, SQ_CMD, CMD, 0x03);
 	value = REG_SET_FIELD(value, SQ_CMD, MODE, 0x01);
 	value = REG_SET_FIELD(value, SQ_CMD, CHECK_VMID, 1);
@@ -3475,6 +3478,9 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
 	unsigned long flags;
 	int r, i;
 
+	if (!adev->debug_exp_resets)
+		return -EINVAL;
+
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
 
-- 
2.46.0

