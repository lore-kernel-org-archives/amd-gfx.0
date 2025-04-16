Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 055FDC369CC
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Apr 2025 22:21:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99FBE10E9D7;
	Wed, 16 Apr 2025 22:21:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QpS45Ujo";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CA8910E12C
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Apr 2025 22:21:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tMBR19YvnCb4wJ/hU9llTJ4LwmpIsu+8GU5gogFFuav2dYwnG3xhfiTp5YSpbolqbt5fRTELPH1eeiIHVmdGRf6LpyTfbVDnJAIdRKX+kmxoLpGTJrDGsGuqg1vVf3rUMpmzL2JnZR9qdkARJV3OI1byZ4cL9n1UbJ0ViF3KvApQ2ZmNcpSDwcLAw+wg4gAUy0vuomb3ei3OxR14clIniTbWBGVFuSL+ZMDDzRbdprpYdrrk6Yi0LEdRGy6ThXcyw1+PSewsNYosKv8tu7CPYjeosCztdUUoUweepZFo0a0vEK1rZjKrQ1LlgDVFiUXebg0PS6tv8BYz3+LiSwQOEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WBDkPbxLBTTnnQP5h9DzBYbekgVC9hFt7RqAiABeBYc=;
 b=OvSum30S9tXradP7ELCA+XxDKEqHreaGolDUf1byJbNNhkUVjh2wlcMn+Mh8LcZLZbIlCUQCJr7+Nc4/F5NmDzCgOfruUPtscuiUrlewOfcpzpOFgMH+49wOyKJ/7FCe70va2cx4bzATQ4JiSGHV4QfSi/wYkgRGZ22y6g893Llq2IuTgNNMddkfllB/orv7IwD4g6okmX7G4w88HG44e+Q9+5RKQlE7X/RWwaOrdMhvxgsplrxz6lTYVyzHudCpxpeTQvvMiWBT5l6xUSllxGrVgS2FYS279WugynZLQiXVPM7vNYfaN09CptzaLCcHZjPa1ZK8CqlAEr/KY0EjKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WBDkPbxLBTTnnQP5h9DzBYbekgVC9hFt7RqAiABeBYc=;
 b=QpS45UjoStMMYuZr7Z24daUtpa26c29aOczr+tCg1/FvvvojLcU/x20z2E0skOPdmu16JA6LlMx3piQ92tSeZtTLpt6NyBeakLmVgH12fQc0oRw3CgoE+k/BUz/WisWU+crbkLAA4Is8ztYDBXbvJt5xIsfkMDLoB9WosZhUu+U=
Received: from BN9PR03CA0273.namprd03.prod.outlook.com (2603:10b6:408:f5::8)
 by DS0PR12MB7948.namprd12.prod.outlook.com (2603:10b6:8:152::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.29; Wed, 16 Apr
 2025 22:21:02 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:408:f5:cafe::32) by BN9PR03CA0273.outlook.office365.com
 (2603:10b6:408:f5::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.22 via Frontend Transport; Wed,
 16 Apr 2025 22:21:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Wed, 16 Apr 2025 22:21:01 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Apr
 2025 17:21:00 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/7] drm/amdgpu/userq: optimize enforce isolation and s/r
Date: Wed, 16 Apr 2025 18:20:41 -0400
Message-ID: <20250416222046.1142257-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250416222046.1142257-1-alexander.deucher@amd.com>
References: <20250416222046.1142257-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|DS0PR12MB7948:EE_
X-MS-Office365-Filtering-Correlation-Id: a22cb9ea-4596-4454-d611-08dd7d34f87d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rrniwVhQZEawRPZJmJusKykrvUISemqfxI2H6VPVilTgCQZq6ldlwP4uPjuM?=
 =?us-ascii?Q?TMx5gB/yf3Rw/cdo29LfbWo433/k5GiwQATvnl4HIy45BSNL4ZlI7My0B9j9?=
 =?us-ascii?Q?QBMa/tWK1WbTdTQzZzGEzz7rC7H+l49XDiQnhQ1l5WHVcXwLVEPG3ZhXk2SO?=
 =?us-ascii?Q?SEfm1b+YHd6VHC4os3l7t/Y3Qt/tSumA8ectBiJ8z0HauOOFgvSaxWp8af/Y?=
 =?us-ascii?Q?V706x7o5TlyTisReG5D0EJPYYZP7od6ztCt2AgdHgEEepiRWejk6PWWnVSH8?=
 =?us-ascii?Q?S8MhR5uh9BsKj/EkjcLGapK57hkXVuMvKdDJSI1fP1OqKG5OhJV9zReWj0XP?=
 =?us-ascii?Q?YCkA3obKZCr07Bj9Pz0ANj1FikvUxqN9w31U8swfBvq71anI08YYrUHoVsN0?=
 =?us-ascii?Q?DDh0rh1V3w7du8Bw7ap3hjBjKeru8liHumiJWBRE7VwCXpwoSPvx1A/EQFJ3?=
 =?us-ascii?Q?vbHgxwwUnPKPx8HQpzL1Ub16PQ0896GMgUm6FQyJxla4cWAY+ycoEgu+ByED?=
 =?us-ascii?Q?tiWh3lOTNq3ijNnbFL77hGXJEMkdyXIrjwfOZbv94Vt3ZfEELZgMdo671dh4?=
 =?us-ascii?Q?gub5uMtNfPk6FAPSPNyOGjr7/816Sfx9opuvfxAOi8q4As14R95OmD6ImfMk?=
 =?us-ascii?Q?91/X9RtHeTyqLuUUD9N9odw+dbhzJa+HpwcbIJV2qrYcX7XjcYPNzpRK9CeM?=
 =?us-ascii?Q?DPsiEO0QxRSD+ilcbNf4xA5dFbK/HByGOzQJXn6+XYlw2TnCUzjBqN1FCYmQ?=
 =?us-ascii?Q?Hzgk84MiFkw1k7VcX5zV+VBwi3Ryoq/e99DKo5hn8CnNpV+YBysHgcETitYE?=
 =?us-ascii?Q?J67ASrRknK+knNYOvukK7VBiidNq5wVpp/+FC71bqq4snYXuV728JC6Jooxr?=
 =?us-ascii?Q?Q2YTCS/E1Gz2WhW7pcigYNbm3XbliFqybjWmNk59xgbplgGwqOacHo98nqHl?=
 =?us-ascii?Q?uCbIvFPEoJEb23LMnkx7pMc3w5x8+iNWMS107co/unVkDH0ZpJyGI2GT3nbl?=
 =?us-ascii?Q?ebp1mDgdE6V0MbhmNm1brHkgwZKWAHjUz2GFDuSBy9+ebA3mG6xj5myQQ4sD?=
 =?us-ascii?Q?yFifUN42Eefj6Lo+4yQHNx/bIs4YF1b/vrwrWYZGU/79lIsn/OGGdvTYsl1p?=
 =?us-ascii?Q?hufwdwbyod4Ui3mB8OkPlCYYcAe5/wkPVb+p76EoP3VBr6THgfmRRR/zF3P6?=
 =?us-ascii?Q?l7y249nNQHU7vbC+VNZlHaGVr/0Iurhe7P6LYpdjmg2ji7D4o79pp+tOL0TR?=
 =?us-ascii?Q?KbA4XcFgwdeZIXgLI5rJj4L9qJSrDbVgQsJwJMxvCaOvlMcRu66fY1E8TRoU?=
 =?us-ascii?Q?PEBH7GRb0/9kIFr5HvnDxARgyI7Af8rBaV8AbIGQmhsRv38YKgwQpLG3g5KC?=
 =?us-ascii?Q?l12g9MvtEKr2MWQaFmrECmEKtLBaWh97+G86aGt6S7hX6KJ+SnGRWfnaCA7I?=
 =?us-ascii?Q?v5XiNzMx8FK0dg5e6MgsVjILwqo81t6gyhaYkszcB4x/S/kKEcIgu39y+H+D?=
 =?us-ascii?Q?A+agUp9H4E+SHxVMHRYPR5DSfF1YfhWwA+v8?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 22:21:01.6933 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a22cb9ea-4596-4454-d611-08dd7d34f87d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7948
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

If user queues are disabled for all IPs in the case
of suspend and resume and for gfx/compute in the case
of enforce isolation, we can return early.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index dbc1fcdc0f73b..04583f9d134f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -758,12 +758,16 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
 
 int amdgpu_userq_suspend(struct amdgpu_device *adev)
 {
+	u32 ip_mask = amdgpu_userqueue_get_supported_ip_mask(adev);
 	const struct amdgpu_userq_funcs *userq_funcs;
 	struct amdgpu_usermode_queue *queue;
 	struct amdgpu_userq_mgr *uqm, *tmp;
 	int queue_id;
 	int ret = 0;
 
+	if (!ip_mask)
+		return 0;
+
 	mutex_lock(&adev->userq_mutex);
 	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
 		cancel_delayed_work_sync(&uqm->resume_work);
@@ -778,12 +782,16 @@ int amdgpu_userq_suspend(struct amdgpu_device *adev)
 
 int amdgpu_userq_resume(struct amdgpu_device *adev)
 {
+	u32 ip_mask = amdgpu_userqueue_get_supported_ip_mask(adev);
 	const struct amdgpu_userq_funcs *userq_funcs;
 	struct amdgpu_usermode_queue *queue;
 	struct amdgpu_userq_mgr *uqm, *tmp;
 	int queue_id;
 	int ret = 0;
 
+	if (!ip_mask)
+		return 0;
+
 	mutex_lock(&adev->userq_mutex);
 	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
 		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
@@ -798,12 +806,17 @@ int amdgpu_userq_resume(struct amdgpu_device *adev)
 int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
 						  u32 idx)
 {
+	u32 ip_mask = amdgpu_userqueue_get_supported_ip_mask(adev);
 	const struct amdgpu_userq_funcs *userq_funcs;
 	struct amdgpu_usermode_queue *queue;
 	struct amdgpu_userq_mgr *uqm, *tmp;
 	int queue_id;
 	int ret = 0;
 
+	/* only need to stop gfx/compute */
+	if (!(ip_mask & ((1 << AMDGPU_HW_IP_GFX) | (1 << AMDGPU_HW_IP_COMPUTE))))
+		return 0;
+
 	mutex_lock(&adev->userq_mutex);
 	if (adev->userq_halt_for_enforce_isolation)
 		dev_warn(adev->dev, "userq scheduling already stopped!\n");
@@ -826,12 +839,17 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
 int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
 						   u32 idx)
 {
+	u32 ip_mask = amdgpu_userqueue_get_supported_ip_mask(adev);
 	const struct amdgpu_userq_funcs *userq_funcs;
 	struct amdgpu_usermode_queue *queue;
 	struct amdgpu_userq_mgr *uqm, *tmp;
 	int queue_id;
 	int ret = 0;
 
+	/* only need to stop gfx/compute */
+	if (!(ip_mask & ((1 << AMDGPU_HW_IP_GFX) | (1 << AMDGPU_HW_IP_COMPUTE))))
+		return 0;
+
 	mutex_lock(&adev->userq_mutex);
 	if (!adev->userq_halt_for_enforce_isolation)
 		dev_warn(adev->dev, "userq scheduling already started!\n");
-- 
2.49.0

