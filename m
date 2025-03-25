Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39772C35FFC
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Mar 2025 15:36:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E3F210E5A7;
	Tue, 25 Mar 2025 15:36:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZAHWA6Ev";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 697DC10E593
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Mar 2025 15:36:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZVVfbNprpwZ0RJThXhXkE9y3rumHECZM7jaqDlz5N7DVFXL59i7tKVWNP/GWK2F8igG21TCgS3KlRENw93IxahVgkS9VyqDlFKw+4hWSMqsME/ZH0qnDd0YhpY2x3taRVIOU/nNRbGfXirowe9rkkZEMakSk859zlP7xrtfTw2kgLexdNJHxEs12ajT0BHLJE8nsG13JL6g2bDUef7Q1uWbQ6TPsVO9UXvcvYPBHSdy+n3rTnDp6hZAXRyzJGXKLnXaTuViSTayky2Byib4beq0fKOh+ZY+PW7n49rMclSV61w4MxPT5o2k4VPUyDJrCgjxIA04RV/BrkAqyI13r3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cdBwYJGesXlXp6ZKbT0CcaJCEa2Kw+FaKBE9HL9S7rM=;
 b=obdHg1NqFdPgtKxVSLNE5qDlcoVfFiUCJ8CccR03+aqM6MsV/GlHGUOyTDBdKEXYoP7HWD/5eUfbbG1F8gLK8rjAA2DaBnfQ9OmaU7+9E3nqdtg8l99uDDX2msnyjjquAvoE9u1M4ZT+25FHdPkTJ5ZTyxvcQA10ox+i5UqLMFYfzd+XAWgwCEGKpqXo5aVVfEAb9Ju8R5ly0vcKx8RZiqQyjCu93KnvkvfMfDRG5HNjWUcmR03+21NItYKFAKlBiHGIthvWYk9bK2q0pqfAPO5Pm7gBgPmdR0zgHfXLy1NyfMfwWKT+QUg7dRGwi5h7BeYLrGJl6vCbir/m+B6+LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cdBwYJGesXlXp6ZKbT0CcaJCEa2Kw+FaKBE9HL9S7rM=;
 b=ZAHWA6Ev/1toz+2NXT37QCJqMMIpxQB0w0Xage/V4Xfd9oPgn4zW0dr0+8Xxsmr53xyjiU0rGByFQFz2fu62Khpm86m090TRSm3x3qxmdfYskOfbJePL3bh/GFdRNHkA47uvoDN9sdQwNeMRCNOtGqSxaZz+A/gUSdCodJ0de08=
Received: from BN9PR03CA0423.namprd03.prod.outlook.com (2603:10b6:408:113::8)
 by MW6PR12MB8661.namprd12.prod.outlook.com (2603:10b6:303:23f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 15:36:47 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:408:113:cafe::87) by BN9PR03CA0423.outlook.office365.com
 (2603:10b6:408:113::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Tue,
 25 Mar 2025 15:36:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 25 Mar 2025 15:36:46 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Mar
 2025 10:36:46 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH V2 1/2] drm/amdgpu: store userq_managers in a list in adev
Date: Tue, 25 Mar 2025 11:36:31 -0400
Message-ID: <20250325153632.478700-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|MW6PR12MB8661:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c949c4d-0574-4c12-c03d-08dd6bb2da6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LT+8y6xEk08XaSJ+E0/TI/ZzGJvR9yj0KO3B3PYLQEo6auHasmJanaE/B6fY?=
 =?us-ascii?Q?AW/Q1/GovL7VwT5dk5obFgS111l1bztNsbSwknsXVX3EGOKLALGhXZBoXdga?=
 =?us-ascii?Q?VQQjsb7G2xf5Jo2lakihc6paA/7bLLFbsw905tSe8vgFHzOsatSw2XNkuFDD?=
 =?us-ascii?Q?SaPL0xj7JoepwKG/gSjEyXrkJ9Wc80V94/6zrGCHn1GXLapXLcsGzNR60p7c?=
 =?us-ascii?Q?rBTpgJIcdLjNNEtjgRKEwoIk5kXjngVV3O8mw2LKijQaj+lIjLQajCiq70fQ?=
 =?us-ascii?Q?egqK2dGxasqb/Ly2iUrZzNBwY9Hpm9OPqNi1hpnHu4JFJT+G8Flq/bRyd44T?=
 =?us-ascii?Q?eQ/Ou5QlvyDjNqDrPEwa94jCZ2cP2e9hWsj8ZyOn5ZL7XGwHd5/kv4qWZwtG?=
 =?us-ascii?Q?wd04YA3YZyyT6nP/xa4FjRpkYYKVXUiWBvzcaCGhV1TsoaVwna2gbDRpXUo8?=
 =?us-ascii?Q?AmPbps6EQK1Da4B2QtslUBzJyp9rzkgZi/x8xyxQ53XyWGLstb1tBARu1jWj?=
 =?us-ascii?Q?7zSATV9XuNvnANz1BflMQuDx2GupMHc1ZticG0WTRycw6n1Jij4X06wbk/Vc?=
 =?us-ascii?Q?PtIxvdDjG6hbHm4OBPdkF0f4lSGJ+N5SvWJxW5cbVQmsQF+so2LtWN5Djv+T?=
 =?us-ascii?Q?Motf7Wp/V2kOm5TD7WnpvdsKv9gszuYeVh1Ipb7EaANWCeneQMAtoz7qRO/o?=
 =?us-ascii?Q?ulxrQNfmVSztfuuI6+QIFD5qD4FT04soBo0FHpz3DYoVMLkAsbeKBweZzWI2?=
 =?us-ascii?Q?WI0XihwDVpAaXZIGGLFuOefecOqDWmFpl8AIsosVcfQvtgMVcv3VHIwbWTrM?=
 =?us-ascii?Q?kZnSbRtmruO8FTCZydNJvoRa1BRGjY81tIHh4S2FSpbl4n5VYOQVtzUMzyeX?=
 =?us-ascii?Q?ZsIXCRVYSZi0kng/G+C3ak+66Ea9kblqYtMi28zpMCt6y1SWGCbtX3Q4bh/T?=
 =?us-ascii?Q?5gjOFknPibIA3qf20azVuLRDZCUazFvc3E33JxPk46qVmzsIuYav28Qq45Qo?=
 =?us-ascii?Q?BrdAQUpzSGE3x2DpRujOA3DOozYebo3V5ZxOoPXVCZqZHrVwK978PcfbiuBs?=
 =?us-ascii?Q?m5cHHrrKsWgTSsSzFWGEj0fpnZhIRHW1yBrUohd+HZ7Cso/aYRniJOnb1fu6?=
 =?us-ascii?Q?rlFVT8ID5Yac1/12hIS36C4fl+WDygk/Be5jQ4/0YXP8FiFohcP9xDbl/Qoq?=
 =?us-ascii?Q?MaSZo34tx8ubORkiJTa2Uu/ZuzsRSkMHC/a31DTDmQtbBG4ll62AeU9xvAer?=
 =?us-ascii?Q?nq/7IRrZ+IhXs21l6GUFZd1gvKR71P+6eDSVVoNOxuFI1I+tIBLw/3/SpR3l?=
 =?us-ascii?Q?7xgTP/quN8lgHdX/EvWtUaiBuH2G/Dwi4CzCymE60KAMpgvvKcxdcA1RS41W?=
 =?us-ascii?Q?iND/0/lgLA/1by83UygitH7d2PwXicMCQlmVIWuBMOAodeZrLYLe9jZNz5Sr?=
 =?us-ascii?Q?XlKeoqStTOwGkDB4HNML5kvTq/L9IBu7qrgHRfGObQ6hECuEOqDDMBjWaq0q?=
 =?us-ascii?Q?llbu60ryqZK6Pe4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 15:36:46.8920 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c949c4d-0574-4c12-c03d-08dd6bb2da6c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8661
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

So we can iterate across them when we need to manage
all user queues.

v2: add uq_mgr to adev list in amdgpu_userq_mgr_init

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 16 +++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h |  1 +
 4 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index ffca74a476da9..6634c0a533f05 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1238,6 +1238,9 @@ struct amdgpu_device {
 	 * in KFD: VRAM or GTT.
 	 */
 	bool                            apu_prefer_gtt;
+
+	struct list_head		userq_mgr_list;
+	struct mutex                    userq_mutex;
 };
 
 static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 7c4a5d5c22fba..c2c2ca7922d5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4300,6 +4300,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	mutex_init(&adev->gfx.kfd_sch_mutex);
 	mutex_init(&adev->gfx.workload_profile_mutex);
 	mutex_init(&adev->vcn.workload_profile_mutex);
+	mutex_init(&adev->userq_mutex);
 
 	amdgpu_device_init_apu_flags(adev);
 
@@ -4327,6 +4328,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 
 	INIT_LIST_HEAD(&adev->pm.od_kobj_list);
 
+	INIT_LIST_HEAD(&adev->userq_mgr_list);
+
 	INIT_DELAYED_WORK(&adev->delayed_init_work,
 			  amdgpu_device_delayed_init_work_handler);
 	INIT_DELAYED_WORK(&adev->gfx.gfx_off_delay_work,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index beae931152a3c..ecd49cf15b2a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -658,20 +658,34 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_devi
 	idr_init_base(&userq_mgr->userq_idr, 1);
 	userq_mgr->adev = adev;
 
+	mutex_lock(&adev->userq_mutex);
+	list_add(&userq_mgr->list, &adev->userq_mgr_list);
+	mutex_unlock(&adev->userq_mutex);
+
 	INIT_DELAYED_WORK(&userq_mgr->resume_work, amdgpu_userqueue_resume_worker);
 	return 0;
 }
 
 void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
 {
-	uint32_t queue_id;
+	struct amdgpu_device *adev = userq_mgr->adev;
 	struct amdgpu_usermode_queue *queue;
+	struct amdgpu_userq_mgr *uqm, *tmp;
+	uint32_t queue_id;
 
 	cancel_delayed_work(&userq_mgr->resume_work);
 
 	mutex_lock(&userq_mgr->userq_mutex);
 	idr_for_each_entry(&userq_mgr->userq_idr, queue, queue_id)
 		amdgpu_userqueue_cleanup(userq_mgr, queue, queue_id);
+	mutex_lock(&adev->userq_mutex);
+	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
+		if (uqm == userq_mgr) {
+			list_del(&uqm->list);
+			break;
+		}
+	}
+	mutex_unlock(&adev->userq_mutex);
 	idr_destroy(&userq_mgr->userq_idr);
 	mutex_unlock(&userq_mgr->userq_mutex);
 	mutex_destroy(&userq_mgr->userq_mutex);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
index 0f358f77f2d9b..ec1a4ca6f6321 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
@@ -76,6 +76,7 @@ struct amdgpu_userq_mgr {
 	struct mutex			userq_mutex;
 	struct amdgpu_device		*adev;
 	struct delayed_work		resume_work;
+	struct list_head		list;
 };
 
 struct amdgpu_db_info {
-- 
2.49.0

