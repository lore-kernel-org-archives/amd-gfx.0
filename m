Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67819CD5BB1
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2026 00:22:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3BE210F48E;
	Fri, 22 May 2026 00:22:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="K5RoS1CF";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011068.outbound.protection.outlook.com [40.107.208.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2639810F48E
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2026 00:22:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V9Z/HhaLEnvGbBmS1yEVSdTvPe+ybwGZMTGUOgyhoaRLvgceGg04j1uDpIn0qMJiEuL1mMO9s5q6rFCUJysD9VZGIkDjk4JstCR6h3zvaxSkZcWb6dQFsO+4rREr4s9WAolPRysF9nypDKWfD5PK/RRdsMt5yJ1zg9Av6RXjEOi3k2NJwT8r4wfH1EsB/WvQ/6utUiHPezvOI9kE6vO52jeBpUFRgwb9QQ3nJ164L6cnSuff/tQxJIwj24MeDOD1leBRuqUHdqnRcVZ4e50o6W383hl1n9qxPm176omO/ktB90cQtQlDv7oViQDOAXd2amPek4O7IBMMGBcJH4ESFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GNCre0PJ9SOin5tjjh2nvyVTepnzgnUBXh2WF89j3wk=;
 b=QvmdHx/0Z0hdjKujuyqwr7JlsmJACs9i36sQ+xW6dc/or1NnG4vI4/EbMEbcz2Z0ajx4npujYeut2HfgrkevD7XviyBoYMlHsW7Px5tBk2MeDZJ68jkKyww/tpVCQ8RzK0tUEfK71vD7Q4K6xs9Johb8zhM4aAp0dsQzNzg2mQggFzFppCRSUF21k99w50jiUtqvUuZy941t/iK+SRHGw2MpuFhdXhao81amH2H8lia+rbdDlOdak8QDeZKUOdhsLWLJWpbiHmxxtmIjHPI1SQRIii06/YWzXgbSzmA4zDaKTEqKcVXhpQ658prqxfL+25ece7vDaE7SKjUn5UnyDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNCre0PJ9SOin5tjjh2nvyVTepnzgnUBXh2WF89j3wk=;
 b=K5RoS1CFGq7HOkYMgKuPUDo47Ran5vBSlXdIb/k7KR/F8O+1AT1LSozvm0V+PzqnfLgt1W6WXSKasNI/3WHt/DML6hWS3OjPayIP0iPCTcrlA62WZ2RA2VT/Bu5vtSrgFmPAktN/+4wiczbnJk7PetUa4zGK9EdBj7gm6B3oWhE=
Received: from DS7P220CA0055.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:224::7) by
 DM3PR12MB9327.namprd12.prod.outlook.com (2603:10b6:0:42::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.14; Fri, 22 May 2026 00:22:21 +0000
Received: from DM2PEPF00003FC4.namprd04.prod.outlook.com
 (2603:10b6:8:224:cafe::90) by DS7P220CA0055.outlook.office365.com
 (2603:10b6:8:224::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Fri, 22
 May 2026 00:22:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC4.mail.protection.outlook.com (10.167.23.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Fri, 22 May 2026 00:22:21 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 21 May
 2026 19:22:10 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 21 May
 2026 19:22:10 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 21 May 2026 19:22:09 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sunil.khatri@amd.com>, <Amber.Lin@amd.com>, <Jesse.Zhang@amd.com>,
 <Shaoyun.Liu@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 34/42] drm/amdkfd: split out mes queue reset sequence into
 standalone function
Date: Thu, 21 May 2026 20:20:40 -0400
Message-ID: <20260522002048.98506-35-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522002048.98506-1-alexander.deucher@amd.com>
References: <20260522002048.98506-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC4:EE_|DM3PR12MB9327:EE_
X-MS-Office365-Filtering-Correlation-Id: 83af93cf-39ac-4e7f-59f3-08deb79830df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|18002099003|56012099003|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info: JW1qxGpFGMTxzUUExKQsrU7BG+bN3Rx1ylwd4WbXjbQKniyweJiLYgZWqEdOh2U5nl3Yrv9WtN0jrRci/oDcYjSlwebmTwAQaK/YU8txsDuNF3S1PCxy/ntZpbStUMqYQwT3LAcOwOMm/2WWWR51KQdNNjL9KUOROwsvDCL+GHNJuCCuB5qzaywSA7+/2NjBMG979ujW4/z4d9eFWa5RVa/jsJsNrjyVeF8Zd3oaLogjX/R8c2qsCYQUwyvxbVbjbO/xeVFdsF0UgnwBC0B9FxIlLW4DqHyTZ8okYipeQfmqXwv+0FwpvlnrvdOSO+1QrhdpiOW0r9S2J2CsqphvvXUpIPEg3br10dvyWbgRv8qolAlSekN4T9ulE+ap7+/+IZEv49k0VYxvNMQMR8P8Qqx5vPbJvQB+NHcNrb+bIoRJl+efnV1g4xwQgJYRB/axSChaRLZy1RUgKO/yDvF4VwiqI55ivNjz4oGzXs6Q39n+0Qnhv8FueOVZ6CvUjZp7sW4QB6n85mELrkxP0oKHvxW8FgwH5DX/bkfB2FhWzEcl5PyC6+3g7ETn0wmXwu/NbG0S3TsmbPbdCAt0lOL1MY5h0TqKXgz/TsIc8Ryt3Wy+18ji41xml1MsLJDDIDeL+WhPlwektZYwi3Vl9ShdhVolRWUjkBmYRphsTOqop98vlPqUacWc0Eq03ggWwAeyT19wsMdp+uhv/HYz7iIKRpN8qt+dpNSXeXAhK8Zb6RA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(18002099003)(56012099003)(11063799006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jLLIns9M+4r0RtK1ZnS5bXfrmHxAKiKLxukPQ98fF2/KUetNwO+GWja/Ckz9kReMo4yTHjrx5DDUHTi+lzpFM5RAgz6Q59qKYja6P5hWPbOB+5Ylu9UNKxEAq8t7k/1gKgrrOiv5jRFavb7ePkTErGyAr+zbDomLH8XI6BiLUIdb6YXCFgFlB4CnTfRKTlmK9NnsIJIzXt5twRLVYLJhKB+HjO4QPKgNQpgCQgsvESBszdO0KshMpDESBO1tLOPL3ZqjH+O9Fy1vX7yEB72W6RJNK0iGwVY9hbNYdNhRJi+xtSu2XRe30ILzr4aq/SS+xQh+908swmJs3d3LQwmSJDAO4RSHhflNHaiDC676QRNDJiC/V3F3HwdGP/KIDiSgpiw/MC6oqVyWqU64a8ADb6UcgTQDmjwVFmDmerXz2G61IjX3kVn3i10B+T86aU11
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 00:22:21.5306 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83af93cf-39ac-4e7f-59f3-08deb79830df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9327
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

No intended functional change.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 48 ++++++++++++-------
 1 file changed, 31 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index e323658f972cd..0a59a79ee28be 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -407,6 +407,32 @@ static int add_all_kfd_queues_mes(struct device_queue_manager *dqm)
 	return retval;
 }
 
+static int reset_queue_mes(struct device_queue_manager *dqm, struct queue *q,
+			   int queue_type, int pipe, int queue, unsigned int db)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)dqm->dev->adev;
+	struct kfd_process_device *pdd;
+	bool use_mmio = false;
+	int r;
+
+	pdd = kfd_get_process_device_data(q->device, q->process);
+	if (!pdd)
+		return -ENODEV;
+
+	if (use_mmio)
+		r = amdgpu_mes_reset_queue_mmio(adev, queue_type, 0, 1, pipe, queue,
+						ffs(dqm->dev->xcc_mask) - 1);
+	else
+		r = amdgpu_mes_reset_user_queue(adev, queue_type, db,
+						ffs(dqm->dev->xcc_mask) - 1);
+	if (r)
+		return r;
+	/* Proceed remove_queue with reset=true */
+	remove_queue_mes_on_reset_option(dqm, q, &pdd->qpd, true, false);
+	set_queue_as_reset(dqm, q, &pdd->qpd);
+	return 0;
+}
+
 static int reset_queues_mes(struct device_queue_manager *dqm)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)dqm->dev->adev;
@@ -414,7 +440,6 @@ static int reset_queues_mes(struct device_queue_manager *dqm)
 	int num_hung = 0, r = 0, i, pipe, queue, queue_type;
 	u32 *hung_array = dqm->hung_db_array;
 	struct amdgpu_mes_hung_queue_hqd_info *hqd_info = dqm->hqd_info;
-	struct kfd_process_device *pdd;
 	struct queue *q;
 
 	if (!amdgpu_mes_queue_reset_by_mes_supported(adev)) {
@@ -468,24 +493,13 @@ static int reset_queues_mes(struct device_queue_manager *dqm)
 
 		q = find_queue_by_doorbell_offset(dqm, hung_array[i]);
 		/* skip queues not owned by KFD */
-		if (!q)
+		if (!q) {
 			continue;
-
-		pdd = kfd_get_process_device_data(q->device, q->process);
-		if (!pdd) {
-			r = -ENODEV;
-			goto fail;
+		} else {
+			r = reset_queue_mes(dqm, q, queue_type, pipe, queue, hung_array[i]);
+			if (r)
+				goto fail;
 		}
-
-		pr_warn("Hang detected doorbell %x pipe %d queue %d type %d\n",
-				hung_array[i], pipe, queue, queue_type);
-		r = amdgpu_mes_reset_user_queue(adev, queue_type, hung_array[i],
-						ffs(dqm->dev->xcc_mask) - 1);
-		if (r)
-			goto fail;
-		/* Proceed remove_queue with reset=true */
-		remove_queue_mes_on_reset_option(dqm, q, &pdd->qpd, true, false);
-		set_queue_as_reset(dqm, q, &pdd->qpd);
 	}
 
 	dqm->detect_hang_count = num_hung;
-- 
2.54.0

