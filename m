Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F4A7E77181
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2024 08:50:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C562310E82D;
	Tue, 10 Dec 2024 08:50:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oCyqpgug";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1299F10E82D
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2024 08:50:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UnuRVoxnCQW16Oy2K0NF2sl3cr7R9qF+sji4uxPlYuLmBmOYEyvtfLYPu0x5SVRNYQcW7z+n9DkrufGnymr/x9r4ajEadxwF4G+AhHhtTdA/LuNQsmo8ZxHoJ9aJEcHjLlzAQXadxsv1Y9T9hX2lbXWay1ByABcyQeIju4gD5SqhvAybUTL5oLOHHxN8vOsFtRsQ/F30u7CB8ji4eyV+YGqqJglNcWRU9Nin209Ci7t3o3zE5ijCF4Q2Igd7TN5/g0fKG7MjbuqBX3Mck3FqiqOYA85EYzt3zwRqw4S1JIspcQnwKe1PuVomYgCUYMRPMgZBmaXjK/vkoNx6IGfkRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pCXCmdqHKgdUj+hLlRqFoCVtKnkx7lnYc+OMzV/5iGU=;
 b=zVcZLnGJJUIJtpg1lS4Tn4EPubolFvGJqFbRNwGtd385HxSe7ZGQq0ewLVVJVql2lXd+Au1L2cUB/c39C+xapL3Z1YeBYPW3DgbsktXbgMRQJTYuvIsQhau59aqxyBVvh2F9AUjpQz+ADl5IK6JRntSQuricFHrRfY07TJxm37Wt1uv67OKl+lpT1S+yI8K2zj1FAidGW+bakRUEVLBcw3h/3LrNaWm2m3DhK1jzt31vJpUpTp4OoxD3vMM7PLeQ4UUYGnHOP0cIyw3bUq+kcctdLORJMN5qudktnIp/ZO4qeJrCXeZhxOuQCwjvh9QY3uprZpmFluJJdqri3TxAgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pCXCmdqHKgdUj+hLlRqFoCVtKnkx7lnYc+OMzV/5iGU=;
 b=oCyqpgugixCI9yvkMzRg3B2YNqGHP3F10XFvCB9tUR77+lbrE6mOtqDlWGCdxnszbvNRMDiU1QX4mAEu58J5MqKfy2Lg+LspdshWfhu26iwfKwo+TRYIO5F7JP2FUlaaKWLvO7SsKjQWRYv4EDh+fwDksNyhKXi9nXnoUW5I7s4=
Received: from BLAPR03CA0040.namprd03.prod.outlook.com (2603:10b6:208:32d::15)
 by DS7PR12MB6285.namprd12.prod.outlook.com (2603:10b6:8:96::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.11; Tue, 10 Dec 2024 08:50:38 +0000
Received: from BN1PEPF00004686.namprd03.prod.outlook.com
 (2603:10b6:208:32d:cafe::bb) by BLAPR03CA0040.outlook.office365.com
 (2603:10b6:208:32d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.19 via Frontend Transport; Tue,
 10 Dec 2024 08:50:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004686.mail.protection.outlook.com (10.167.243.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Tue, 10 Dec 2024 08:50:38 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Dec 2024 02:50:36 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH] drm/amdgpu: Update VM flush condition for 'enforce_isolation'
Date: Tue, 10 Dec 2024 14:20:22 +0530
Message-ID: <20241210085022.64465-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004686:EE_|DS7PR12MB6285:EE_
X-MS-Office365-Filtering-Correlation-Id: 44cec9e8-8801-47cc-8254-08dd18f7b815
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U0QrVm8wSkE0L04vN1pNMHV3MzlwckNaNW5yMHdYYTMwMVJoZjZMSmFMdTlh?=
 =?utf-8?B?cU5KcXJxUElJamUzMGVwSTVTRUhkenJRd2tLRDYxUW1xMlYya0tFbEs5WitX?=
 =?utf-8?B?dlVDbFYyZkNjTGlsVll0WXJEbnB2OTRkTlZLV2VUNUlCMnM2NHI5djBFckF6?=
 =?utf-8?B?MmxYd2hjb2w0SzVEWSsxQ2xNc1lHT3NCT0pIRmQwV1hBd3NMbjVwTDFRa2hV?=
 =?utf-8?B?cWtTajNsL2NFNzNZQnVWSXIxSzlTQmR5Rmh2eCthaUlzWVF5WDFHK3A4cGdQ?=
 =?utf-8?B?cVZnRjhwN3dEbDZlYUdqRExlSFZ5VWU2TEZsdGNwN1ZuOFhnRWRQdDd4VUZB?=
 =?utf-8?B?TVhZZjduQXRRS3B4L1FtUVo4Tjd5QjdjTWtmZGhCN3M2dUhTcHhUeXVab2RK?=
 =?utf-8?B?MVRlN0FtNE5GVWtSVVR2UEJFV1JVZy9QelY1ZURHb3g4REltZmZwc1NjcXh6?=
 =?utf-8?B?R2Y0ZlU1aWJLdFpiNjRHRS9OUFZEU2padVo4dmdQSS96U01ocncreVIyOTJE?=
 =?utf-8?B?cUFUREdjTGlDOU40bkFOSEg5VnNFdVpLV3JEL0FoWng1aVp5MktjUTRiRVpH?=
 =?utf-8?B?aFE5THBqOHVCaFB2ZUR6VjFLSC9PM0U5OUhjcndiU2VtOTRtOVZzekJtaUJy?=
 =?utf-8?B?Zm82ZUM3QWo5ZitPMlZYLyswTlM0bjJIeWY0RERwc1JEVkJNNXdpUTBISFpm?=
 =?utf-8?B?OUhKdHdxc0FLWmRxeHFzZkdnNy9nRERrQ2lJY0FqVlE5elBEM1Bpb1RiaHpm?=
 =?utf-8?B?dWhpT2ZOZlJ4N25wUzdnOVJOQnk5YmswTWJtSHhmZ3lnVFlGcmxvc2VtNXAz?=
 =?utf-8?B?aXhESktPSm9WUmhnYWhMKzNZajQvMTFURWFpeWxrVjIzRVh5cmcvMFZmdFRQ?=
 =?utf-8?B?SjdrRVdGWkExWVhabjUzdmZYYzVtWTdlbk45REtEbHUvUGFOMklOK1RPT01G?=
 =?utf-8?B?S3VmVjlZeFdBTmVjeDhJQkhIekpGdlhka1VpZVNmenlNM28wekk2SzhQazZa?=
 =?utf-8?B?Sm9JcFV1Ui95YjhERStJekJrOUxUM01VYmtVdFRSTFVqaHFnWkdSbENRRUc5?=
 =?utf-8?B?UkhrL0xFVGJPUVZZU1lVd2J1eDVUTUZKd1haYVlvc3NnYkRtcjVUN3dTOHZV?=
 =?utf-8?B?ZW1QcTNjdnB0dm10OE5TS3BYY3drS0tiVyt1cFNzWWlyVlRhQVdrWXRDSzh6?=
 =?utf-8?B?SUthdHVhTk5QN3c4WjBMOUpIaXViQk5oa0lKekpHMWdiaEdSKzBoZTdDWEpS?=
 =?utf-8?B?VDQzOG0yZ2FpYmdPL0pFajNGTnd5ZzIvRHA0TE1YaDBDZkdUQVlSbUpONTIr?=
 =?utf-8?B?YUdMeUVtUktQMzh2NUVmaDRKRFVvNmlyZUlhZ1BGclBweTZNd28vZ01pVmdX?=
 =?utf-8?B?WE4yS0dtUE5UT2R3N25sQkVETHNYeVBwWGFjM0s3VzdiNFRzVU1rN3NDdk5v?=
 =?utf-8?B?NFNZb0tGeW9yTEtsdEhYaEtHcmdtMWJaczJtUDJZbWpCUXB4U2JFQk5GdEN3?=
 =?utf-8?B?SlRPakRTWnI0OE5aeHQ3S3REczA4U3Axdzk5MFJBdlBwc2xxdHN6bC9NekxB?=
 =?utf-8?B?ckRHTitjYmQ0OEEvOUdKWEVZOEtFZFZscHhySFVKbEIyelRETWt0dmZyUXRK?=
 =?utf-8?B?RVltQlkxck5CYzJ2eklGRmtzRFhBakdSbDU3NGJzSWtzL05IVFFqRTJFb2dt?=
 =?utf-8?B?a213L1FtOThSVytIbGxRa0dQNmdwREU1TG55dWl0S2didlhhMjhCdWZ3bld0?=
 =?utf-8?B?cW9qQWZiam9HSVNGc3JZRmo3ZEcraG9NeE1Ha293d290MWtrQzFVTmZsbmkv?=
 =?utf-8?B?NmJMQ1JDNW1kYmVrdUF1M0krbU5hMWthUktEUUpmeU5HUU1pdXNUMjdQU3R5?=
 =?utf-8?B?REQyeFJVcDFhVFVKVzJXclhoQkVrakFkMzZSZjhxRFEydHFlZXBGeUNxQWVy?=
 =?utf-8?Q?bx2JxwZibEUJD+cJ0UTYdO1UVHuR+MiA?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 08:50:38.0103 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44cec9e8-8801-47cc-8254-08dd18f7b815
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004686.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6285
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

This patch updates the `amdgpu_vm_flush` function to ensure the cleaner
shader is emitted when `enforce_isolation` is true and `vmid` is not set
(ie., when job does not have a specific, unique memory space assigned to
it. Instead, it uses a shared or common memory space that is accessible
to multiple jobs or processes). Previously, the cleaner shader could be
skipped if no VM flush, GDS switch, or pipe sync was needed, causing
issues when manually triggering the cleaner shader.

The new condition includes a check for `!(job->enforce_isolation &&
!job->vmid)`, ensuring the cleaner shader is emitted when necessary in
scenarios requiring enforced isolation.

Fixes: 2feee98e6f2c ("drm/amdgpu: Update VM flush condition for 'enforce_isolation'")
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index db913d533898..77af9c389eae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -674,7 +674,8 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	pasid_mapping_needed &= adev->gmc.gmc_funcs->emit_pasid_mapping &&
 		ring->funcs->emit_wreg;
 
-	if (!vm_flush_needed && !gds_switch_needed && !need_pipe_sync)
+	if (!vm_flush_needed && !gds_switch_needed && !need_pipe_sync &&
+	    !(job->enforce_isolation && !job->vmid))
 		return 0;
 
 	amdgpu_ring_ib_begin(ring);
-- 
2.34.1

