Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CE4FC3ABBC
	for <amd-gfx@archiver.kernel.org>; Fri,  9 May 2025 10:10:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEFA110E9F9;
	Fri,  9 May 2025 10:10:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fqNvNo+M";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFF7B10E9F9
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 May 2025 10:10:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=My70SEPYqb2HHjoJEVlAyP77OgqVxufxhVLrpFfTzFGlzl2OEDRD97F9smbPNOlKkN96LeLVooSkxm6ibzaWKC6Zu/iUV4HwIPP3kMOg8ICAi3PzmSNyYJrWPakDKAQ2n0I6z7NSBLRlzvczI7CBEzLNwqi3LreH1Jc1e7o4f1DJE3F0LKHtDb8ffeO7E3EQe8bwQEQ+gIkZDyaXyxQ82JNMdfznX7MOCU+0o0BCYDsrAc3h7pygA6MOxh3mFQM1qVLKzvQxFdZHQ82tXEwPvhrcUWni/LMyWfzjtsqJiOrf/GHWGD5uG5dCRtcNfbMteOeUfvZAXV5Bf9AhWB83AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EBu/RcAMTbMS43eVE4It3mRIew58IGLzKimqsBn1ABo=;
 b=kYt9yV3G5OkGAN0j9V9ERpJLnH8KNxMbGN9+mA+M8BPcA0ewK9m2LLH8JohibbyOYzQoDIx+tQO0PbnHz+52KtcV7qIzvPDq9kB74EuRDM28PEQ49o4tMpPbZ0QtKF731tx3ipH5Wd0bQPAQRnOvP0C8vwDIsj9Mdj41J9h9RTOsTXah/rL2Fo1rlhudaOQLcONrE/QRIc5p6hOGzn2G6VT81395aJ81KBNeWlYvFBluxCb3YsKDSLRjTDZ1FYdEjNEZety0w9TmADsGiQl7C3vqtthfJUyYATbg7JvQhuNtYFno9UsKXdcim7pbh9lm4F6ayw6P6pf6X8aJqnN4MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EBu/RcAMTbMS43eVE4It3mRIew58IGLzKimqsBn1ABo=;
 b=fqNvNo+MZT5ZioK0rPO+gEl6ctkyowXxWmHXd/Ifu2cR0VCpwLJzRhlTxiUOvzhjBB6OaaTY31csAfZWYlP3VKuC6/9+SXymQhdzDXBedZhvK+4gZas7HKHFgItMs1n4fwH8G9hQuXgfTalOAXm6aT9ELLl58yyE7fl4mwJx8Dg=
Received: from SA1PR02CA0009.namprd02.prod.outlook.com (2603:10b6:806:2cf::14)
 by PH7PR12MB6609.namprd12.prod.outlook.com (2603:10b6:510:213::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Fri, 9 May
 2025 10:10:18 +0000
Received: from SA2PEPF00003AEA.namprd02.prod.outlook.com
 (2603:10b6:806:2cf:cafe::db) by SA1PR02CA0009.outlook.office365.com
 (2603:10b6:806:2cf::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.23 via Frontend Transport; Fri,
 9 May 2025 10:10:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AEA.mail.protection.outlook.com (10.167.248.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Fri, 9 May 2025 10:10:18 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 9 May
 2025 05:10:17 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 9 May 2025 05:10:16 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Fix TTM validation warnings in user queue
 doorbell handling
Date: Fri, 9 May 2025 18:10:07 +0800
Message-ID: <20250509101015.3678143-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEA:EE_|PH7PR12MB6609:EE_
X-MS-Office365-Filtering-Correlation-Id: c7e7e572-1a9c-4d4f-310d-08dd8ee1b336
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YZEQXLpvGfkQNTuQq4CCs8Y5o8m6XPw4Pm5nX+rKw/EkMdNatIy/qAlvus1M?=
 =?us-ascii?Q?44sH3x6g4XmsVTIyP7u8k8kI2LXS5adnbgj006apLS0/8lfupIj82CH+vo7l?=
 =?us-ascii?Q?dPJTXU+hTvJ5Yk5HBygEZ9/Tw3drE2FkZGW308evAcBgs6xSNZSBt2hZxdH0?=
 =?us-ascii?Q?wHnenS0FbGg7Pgvczxt5lCbuxz1IUJ31TAe4FTytC/wO3LbCIScT79FWFwuX?=
 =?us-ascii?Q?x+jRFqfRyitJ/Dy5WzgCvUhXtt8PdW84jq2czPC8oGKN5VD0LSVnFKd2MGB2?=
 =?us-ascii?Q?9f3wBAQXroT7V6BC732IwgEwLfelLtcePLPrCamL5kp5INdzbMWW2QnK1IvH?=
 =?us-ascii?Q?a5GMiMfgiEYgt7Bro1v9IWpT48a/Ut1N/ULGhvqAyxcscb7F1UTNRGNxBXHo?=
 =?us-ascii?Q?5yIkdu9rb6cqEjlZJn945xlusLhthDr26yyYCKyIC3DkVqLJscbImaswo/3/?=
 =?us-ascii?Q?bcnbBt4VXlko6NV13wmSmi6mb1hYzzXkPxmB9W2/O/Qh1N5zhtoofdlwfhZ0?=
 =?us-ascii?Q?RLVPK4nmcb8e6AGtOYke9j7DZq7QKvoL+pldECHxcWe5sLBJi5RZ+t3JV+Sz?=
 =?us-ascii?Q?+CVbUtsQxwkVOGxNIcwvQXw/WYlRRKWMO8ssoV/jJ0PlSqgJHw4GBf29i795?=
 =?us-ascii?Q?CkBZxmOxiGS4ZkKbEk//iE58F6O1EzSnaqmomr2VfcnoHNyed6RRgB74jNtS?=
 =?us-ascii?Q?mFCucuf+KXtnZzHI1XRV4gnkWGe8WymUM2KiZsP4EB6z6ot5sYdA/ft0AFw1?=
 =?us-ascii?Q?RglbCe1yxZOAhgh95UvA1vy7qOhMF/JRLNCYK/puiCjUxuf6zQY0htqNEoiA?=
 =?us-ascii?Q?nGmbEO+aR3/sMqGgKFcCW4MtBKm4twYgKc1wn2L5Z/CqUejfmsmD7DjQDYdt?=
 =?us-ascii?Q?vlEX+FmNK3fY3rnzhtrDXBcbZcMunSreGK/7qCpnvngU8+7/IKpKGo/pqqcS?=
 =?us-ascii?Q?+dNMuom1QvOKRmQhMS8qUDSg6ZjSLrskNP/mXASdFzJK+dBNJPTip6ZYLdgS?=
 =?us-ascii?Q?RjJtn2r5bMp8VpVCcHkv+mVR/9YZPbGKZvsrnS9nE6huZq7o4ru8RIFj3Eaw?=
 =?us-ascii?Q?0E1mNPgGzCfaqlaYx3ToEvbauwL9bnZCxlUieYLc8SYaVUloUmt2fZtQ5vtE?=
 =?us-ascii?Q?DcHH/FLFzl7PjQ2y3DczPtJGSlzonye8UadTJ6e8nUfLfGjeFAQlAT6QOPKr?=
 =?us-ascii?Q?4SYqg0OANa+BYSJk+uYhcNTSQEa7sdVsMpqwsuS4GlvzYL9MFXlYIQ/x/j7I?=
 =?us-ascii?Q?RZeoVsVdm0Ri3QqIFbBSE7V4GYxFx+ifA648vmMUKgYLyeqY2a6ojA9alfHZ?=
 =?us-ascii?Q?5Of1ABW0AmA4oqvcYuOLTGwZGHhBWpEnXoCjBML68eEXfWDuQSLjooaziWwr?=
 =?us-ascii?Q?pCH70sYCKDlSqU5xPtHMqdyQytNK7uHjw3jsjjxrTHLnK2Vw5OYlIg5sejyE?=
 =?us-ascii?Q?VwmGzjyv7YpVKL85QzAy2O/jY87ZRQhYpPhpOsNsFBWeqGTTROr2joFLusau?=
 =?us-ascii?Q?tv+qXruF61K8yZ7R+TIZNgxZDDRPFjhE6kh1?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 10:10:18.0985 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7e7e572-1a9c-4d4f-310d-08dd8ee1b336
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AEA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6609
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

This patch resolves a kernel warning that occurs during user queue initialization:

[  428.714241] WARNING: CPU: 23 PID: 1965 at drivers/gpu/drm/ttm/ttm_bo.c:823 ttm_bo_validate+0x15c/0x1a0 [ttm]
[  428.714758] Call Trace:
[  428.714758]  amdgpu_bo_pin+0x1b5/0x310 [amdgpu]
[  428.714915]  amdgpu_userq_get_doorbell_index+0x71/0x270 [amdgpu]

The warning occurs due to improper buffer object state management when
setting up doorbells for user queues. The key issues addressed are:

1. Incorrect locking sequence - pinning before reservation
2. Inadequate error handling paths
3. Race conditions during BO validation

Changes made:
1. Reordered operations to reserve BO before pinning
2. Added proper cleanup path for reservation failures
3. Improved error handling with separate unpin/unreserve paths

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 33 +++++++++++++----------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 0f1cb6bc63db..444a0f5d98ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -283,28 +283,31 @@ amdgpu_userq_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
 	uint64_t index;
 	struct drm_gem_object *gobj;
 	struct amdgpu_userq_obj *db_obj = db_info->db_obj;
+	struct amdgpu_bo *bo;
 	int r, db_size;
 
 	gobj = drm_gem_object_lookup(filp, db_info->doorbell_handle);
-	if (gobj == NULL) {
+	if (!gobj) {
 		drm_file_err(uq_mgr->file, "Can't find GEM object for doorbell\n");
 		return -EINVAL;
 	}
 
-	db_obj->obj = amdgpu_bo_ref(gem_to_amdgpu_bo(gobj));
+	bo = amdgpu_bo_ref(gem_to_amdgpu_bo(gobj));
 	drm_gem_object_put(gobj);
+	db_obj->obj = bo;
 
-	/* Pin the BO before generating the index, unpin in queue destroy */
-	r = amdgpu_bo_pin(db_obj->obj, AMDGPU_GEM_DOMAIN_DOORBELL);
+	/* First reserve the BO to ensure proper state */
+	r = amdgpu_bo_reserve(bo, true);
 	if (r) {
-		drm_file_err(uq_mgr->file, "[Usermode queues] Failed to pin doorbell object\n");
+		drm_file_err(uq_mgr->file, "[Usermode queues] Failed to reserve doorbell BO\n");
 		goto unref_bo;
 	}
 
-	r = amdgpu_bo_reserve(db_obj->obj, true);
+	/* Validate and pin the BO */
+	r = amdgpu_bo_pin(bo, AMDGPU_GEM_DOMAIN_DOORBELL);
 	if (r) {
-		drm_file_err(uq_mgr->file, "[Usermode queues] Failed to pin doorbell object\n");
-		goto unpin_bo;
+		drm_file_err(uq_mgr->file, "[Usermode queues] Failed to pin doorbell BO\n");
+		goto unreserve_bo;
 	}
 
 	switch (db_info->queue_type) {
@@ -325,24 +328,26 @@ amdgpu_userq_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
 		break;
 
 	default:
-		drm_file_err(uq_mgr->file, "[Usermode queues] IP %d not support\n",
+		drm_file_err(uq_mgr->file, "IP %d not supported\n",
 			     db_info->queue_type);
 		r = -EINVAL;
 		goto unpin_bo;
 	}
 
-	index = amdgpu_doorbell_index_on_bar(uq_mgr->adev, db_obj->obj,
+	index = amdgpu_doorbell_index_on_bar(uq_mgr->adev, bo,
 					     db_info->doorbell_offset, db_size);
 	drm_dbg_driver(adev_to_drm(uq_mgr->adev),
 		       "[Usermode queues] doorbell index=%lld\n", index);
-	amdgpu_bo_unreserve(db_obj->obj);
+
+	amdgpu_bo_unreserve(bo);
 	return index;
 
 unpin_bo:
-	amdgpu_bo_unpin(db_obj->obj);
-
+	amdgpu_bo_unpin(bo);
+unreserve_bo:
+	amdgpu_bo_unreserve(bo);
 unref_bo:
-	amdgpu_bo_unref(&db_obj->obj);
+	amdgpu_bo_unref(&bo);
 	return r;
 }
 
-- 
2.49.0

