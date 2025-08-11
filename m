Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75A3DC87FDB
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Aug 2025 10:00:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B40210E40E;
	Mon, 11 Aug 2025 10:00:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uHvNCdwE";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BFA610E40E
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Aug 2025 10:00:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QEzjjY0TPvP12DGPPll/Z0sjOGA2U9WxSVGmlCnUtKtJ4ja90ZK+8wp7glPZbyFdrQ9LC0KdFEnheOl7C2LqmhU5/oPL35EbZFzXSDiuEkOz9DAwPspKREOwNxon2i1Sxg6Gwsxja3xeKqw+/IpATK+RzObhHs+m7rNjqzF5Cj55O9NJ6VQyB3eadhuCh5JoM1OnVUAshQtCDdMjqrYeMijQLYLDDm68Lam3QFyWOSd2VUjsBmDSXxyfQxqpyBvHTzNRg4844b1YXFDiBPu3DIi6NRsMlvomonz5rhB+F1YNH6kK+C4aZqLt834AGeXi9vGGoq7f9wwSPiCaVw6dqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x0kPzbWAe1gVTxMOucFfR6KfWoapfkMxFvxyCNZWkM8=;
 b=H9R6ZEGXIjoBNH/+wdyM1AOlcbXqqn4ryQo9RNyZTmeREyDx/b9MCGzJnowLF91EJzAuT7bQ9Znr5YfMwQotUIumDDwVVwzTzMutNbUK01ZOQMdop8KP06m+Su5qpyOHli8SEUhmeiVJ6IqW0qhPbV6DDntNdjzPR7RGCrTOPROaHbigo5QMHGPiumPeTi2c+iaP5/9J90y18cAwe1/sM5HPA6Vro60L0/b8zCkjpY4kHk7jEDHthnJm5PVqPL7x+8exAtfokO6kLa3MnCQ5s+O8dHvbXHE2RR7wNhGyt78IkRKdLcAdkY7H/+S3i2DaMl6JwqkRzTpyiVthNUFp0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0kPzbWAe1gVTxMOucFfR6KfWoapfkMxFvxyCNZWkM8=;
 b=uHvNCdwExjw7ZOsz47O6jf4YN17lYXJC1DAZNkz9cjAoVXkoktxhycddaDMOk5U6qsoj9uz/ao+rlg66zGOrh5zo9trf0vopMqRvGbT6f+PrQo3zq5RUMXprvGbpOhjZduiYh6DRrLkxxUBAtBOcQYDu5/LhDRRVYk6qnBxEO8Y=
Received: from MW4PR03CA0105.namprd03.prod.outlook.com (2603:10b6:303:b7::20)
 by LV5PR12MB9753.namprd12.prod.outlook.com (2603:10b6:408:2b6::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 10:00:48 +0000
Received: from MWH0EPF000A6730.namprd04.prod.outlook.com
 (2603:10b6:303:b7:cafe::d7) by MW4PR03CA0105.outlook.office365.com
 (2603:10b6:303:b7::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.22 via Frontend Transport; Mon,
 11 Aug 2025 10:00:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000A6730.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Mon, 11 Aug 2025 10:00:48 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Aug
 2025 05:00:46 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Aug
 2025 05:00:45 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 11 Aug 2025 05:00:39 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [v8 10/11] drm/amdgpu: Switch user queues to use preempt/restore for
 eviction
Date: Mon, 11 Aug 2025 17:56:57 +0800
Message-ID: <20250811095937.1978747-10-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250811095937.1978747-1-Jesse.Zhang@amd.com>
References: <20250811095937.1978747-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6730:EE_|LV5PR12MB9753:EE_
X-MS-Office365-Filtering-Correlation-Id: 4679a823-2d81-4304-802e-08ddd8bdf260
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lT1VR0K9EoOb8JdD+xKnpq/TBD8ZfFTbmGPDqj3Znlz75ns+5dolEJp77voj?=
 =?us-ascii?Q?ZHX/XNogniN/FS93ykC/fy9dZ8rbub4u1HVGjrzxm4vSW8gt9GcdhNE8uQr/?=
 =?us-ascii?Q?BfDwWzk91ZKH45IfEUG2qIR6dttKR/YfwKHphtjZTCjVE0/Agyghx838UzPs?=
 =?us-ascii?Q?ziGA1zKWmF2VEZCOxAgiXc9lMWrEp4qxHPVc89oG8DATD3Mvj61jAUjxU9Ee?=
 =?us-ascii?Q?XzVKdyS9f4X9Snvg6zKP8dP4MYZuIlY5K8QZSprAWG5JWGFTlyUa9qhK0+ex?=
 =?us-ascii?Q?ZJ1NJn0/CYGET1ftOFGYPi3ZriueHJJHrJXI6VOnYgJ1NcYeSug9O10HjRlC?=
 =?us-ascii?Q?HzhKGGSS77Gj/orJdMbS86q+L0dWKADuSpkmdZQK2fUR6CJNN22D0pTq+v3y?=
 =?us-ascii?Q?2wfLKt6Dudw3vkPkj9YwulnfaqgQyH4Sn8R6FxWN11en7hkE6/XF4eLK58qj?=
 =?us-ascii?Q?vy0LkanEuo49SvwFY/8VpMJRpnHCNckReeMlezTAUhniHyLPidLNc+bvPiC1?=
 =?us-ascii?Q?/V2c8dizxk/5E18/Zrcil/g/G78ZgZRQ/sXxFz6069cx9gpDTWEseOANv4B6?=
 =?us-ascii?Q?mekBRx5qSOS9aJ6ae0vUlG5CSy3zNPjBjX1Fogm63UZLeVkc6ozJnnNMN5kp?=
 =?us-ascii?Q?NsqG18u9a+3Xsfco2i8F5/8jup08+nmhS6RwkFL/1GT1+oJhANm75FPzRB1L?=
 =?us-ascii?Q?2xApq92k2D1/R8+sSr6yG8epZ8jXposBWVna8LocItC8pyxbclPBX5nKnf7o?=
 =?us-ascii?Q?TGrEKxS2ZWiCaEyh/AZd3COA04FAxrLSpOYfpp3NOLaeMGf7EYYpWUUVEogD?=
 =?us-ascii?Q?SXE+iTCpjgWNO267lD8yHYOgKzybvAywiglJPsmBWRd457tSxu7Vt2l3NiUF?=
 =?us-ascii?Q?h/Ssb5xa9nnbUw3eXbReDfHTH7+E4AXFpFyHSVIcLGut7gFJS/yCsqTY1ZG4?=
 =?us-ascii?Q?JwioXPNiSU/vmWPRjOUn55rqun7fWAjlwVn9l4Ombs4WG7EpDqxZcVvpQOyX?=
 =?us-ascii?Q?CpMZw01rWq0iZOYmXUnQWmBXCoxNYpbBECu+/eDvkQ2SB68lFkihyug4BlPJ?=
 =?us-ascii?Q?yzmtvc0bwQmSvzTwlCm81Vy3QQcE2CkmaPqkfPezkH714YsMsNadhNFa8xtl?=
 =?us-ascii?Q?wS85SAGW0ns+7f7zvGl2Cte6jAMOPLoKRnpmc+3OmOIaB44KgnO3nwlufDBu?=
 =?us-ascii?Q?na1fSyciMuIkcOP8znCbRxmOEIo/kKeSzHGxzH9gEXq8B31auOcpW+dfSqKA?=
 =?us-ascii?Q?xcM9S4X6QHfvC03KvoBIzVTQ/DOOTJVktfkg9HbqDEV/U51sAODeuODoh0Ez?=
 =?us-ascii?Q?uGXJMy5buv0X1zw2Z7dSZ5dpo0LkSfhB4OKjMtVWJQGZEFZIaq45HnvBnBhV?=
 =?us-ascii?Q?p3w+VNgahP809HTuuV0icCYkN8ME4XatYxv+Gj0hcYZtaNNJNt/4hsXGkHRc?=
 =?us-ascii?Q?1JVFCTEdAb/NNLgSNgnywJsi5UVJ+bhGdF4Y9ySEk7TNvQOAYfScuC5EOfZ7?=
 =?us-ascii?Q?8ZqnFCstPzFjvFPs/qw8J+wofAYATh4g5Lk7?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 10:00:48.1970 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4679a823-2d81-4304-802e-08ddd8bdf260
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6730.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9753
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

This patch modifies the user queue management to use preempt/restore
operations instead of full map/unmap for queue eviction scenarios where
applicable. The changes include:

1. Introduces new helper functions:
   - amdgpu_userqueue_preempt_helper()
   - amdgpu_userqueue_restore_helper()

2. Updates queue state management to track PREEMPTED state

3. Modifies eviction handling to use preempt instead of unmap:
   - amdgpu_userq_evict_all() now uses preempt_helper
   - amdgpu_userq_restore_all() now uses restore_helper

The preempt/restore approach provides better performance during queue
eviction by avoiding the overhead of full queue teardown and setup.
Full map/unmap operations are still used for initial setup/teardown
and system suspend scenarios.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 49 +++++++++++++++++++++--
 1 file changed, 46 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index aac0de86f3e8..decedf8057ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -45,7 +45,7 @@ u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
 }
 
 static int
-amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
+amdgpu_userqueue_preempt_helper(struct amdgpu_userq_mgr *uq_mgr,
 			  struct amdgpu_usermode_queue *queue)
 {
 	struct amdgpu_device *adev = uq_mgr->adev;
@@ -54,6 +54,49 @@ amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
 	int r = 0;
 
 	if (queue->state == AMDGPU_USERQ_STATE_MAPPED) {
+		r = userq_funcs->preempt(uq_mgr, queue);
+		if (r) {
+			queue->state = AMDGPU_USERQ_STATE_HUNG;
+		} else {
+			queue->state = AMDGPU_USERQ_STATE_PREEMPTED;
+		}
+	}
+
+	return r;
+}
+
+static int
+amdgpu_userqueue_restore_helper(struct amdgpu_userq_mgr *uq_mgr,
+			struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_device *adev = uq_mgr->adev;
+	const struct amdgpu_userq_funcs *userq_funcs =
+		adev->userq_funcs[queue->queue_type];
+	int r = 0;
+
+	if (queue->state == AMDGPU_USERQ_STATE_PREEMPTED) {
+		r = userq_funcs->restore(uq_mgr, queue);
+		if (r) {
+			queue->state = AMDGPU_USERQ_STATE_HUNG;
+		} else {
+			queue->state = AMDGPU_USERQ_STATE_MAPPED;
+		}
+	}
+
+	return r;
+}
+
+static int
+amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
+			  struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_device *adev = uq_mgr->adev;
+	const struct amdgpu_userq_funcs *userq_funcs =
+		adev->userq_funcs[queue->queue_type];
+	int r = 0;
+
+	if ((queue->state == AMDGPU_USERQ_STATE_MAPPED) ||
+		(queue->state == AMDGPU_USERQ_STATE_PREEMPTED)) {
 		r = userq_funcs->unmap(uq_mgr, queue);
 		if (r)
 			queue->state = AMDGPU_USERQ_STATE_HUNG;
@@ -536,7 +579,7 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
 
 	/* Resume all the queues for this process */
 	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
-		r = amdgpu_userq_map_helper(uq_mgr, queue);
+		r = amdgpu_userqueue_restore_helper(uq_mgr, queue);
 		if (r)
 			ret = r;
 	}
@@ -693,7 +736,7 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
 
 	/* Try to unmap all the queues in this process ctx */
 	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
-		r = amdgpu_userq_unmap_helper(uq_mgr, queue);
+		r = amdgpu_userqueue_preempt_helper(uq_mgr, queue);
 		if (r)
 			ret = r;
 	}
-- 
2.49.0

