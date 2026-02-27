Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C17CFD530D
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Feb 2026 08:13:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EB3B10EA53;
	Fri, 27 Feb 2026 08:13:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aJbHvBLr";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012031.outbound.protection.outlook.com
 [40.107.200.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C50310EA53
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Feb 2026 08:13:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MSYUY0HbZuy5Pmu8Kys3EH3zqsw90fG97G0Snpk6onqdcbZndxp+rMKnd3u2XKeAddYgvSikem7dzALm1BMdgmGeJxjrRsoQuBgAKRcv8e58wfSBTv1xHz7fWZEITUxh3g04d0Pc/wLD4bR0Kh5q4bLl69AoNcE/mYfqSfYT2pptELDogm+FoH+1UBgrsPQARXIDtkxFLwYi49DlZCZBFX4ud0uKGvhGoSCDHDdlLoxzC54FOIPpAK+9VzBwsv27nbIIFyejiGjTCCBrk+uT4yqO31Y17Od33Lmq/6T7HEpmDrDCptLu+TX6DuG9p2m3OCh6K5rzWUBPNB/7PiOB4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J/NtK0y/luHJhx4wwN9gE682X74hvi320bwUcnj++RI=;
 b=UPQxji3IdrEfc0p6S2KvVltdI0DEVopXCKIvlN/8xbUW38j/+LcgiAr9CjuPS5VfuAP1i4kmH1lDbKkAs0aS/EMbHJVnYKZovOzpmlQKMLWCWCxc+kD13c1MoaMa6RTTRF99lVkhHoxAJlxPxfnTqAHslxz1+bnC2mtf18lNZ6hCYgQNPrz3I6GirRD1YnuIM8ezfnWh+PP5QyeJq8hfgeJzo+8jgub0VZz4ROI6G8XgVltm1aKqWl9Lvsnm8zS11G2zOyYZ1RRwrzO3w1UQrDLrru1k/iOSNkAF1CWVtdlBW9bVRoW65b5F7Z8v6KdQQKoJSPYNMFwVqj82XK8Ovw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/NtK0y/luHJhx4wwN9gE682X74hvi320bwUcnj++RI=;
 b=aJbHvBLrnR2FEo+S5Nlq0Cq8azIIv/YFYFBeMShyHzcHZehhy+PSPsvhWZe7CijxB0GUNwpdCJxiFUhaD/EASXsUxcQclYafwSr9Nd8F54WNVv+iNG/3lXOFQDezQU6LtHl8BGg9a65ATJ4I+H/KwSbB4zNp7qgEySEorGbx+4M=
Received: from BYAPR06CA0055.namprd06.prod.outlook.com (2603:10b6:a03:14b::32)
 by DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 08:13:16 +0000
Received: from SJ1PEPF000026C3.namprd04.prod.outlook.com
 (2603:10b6:a03:14b:cafe::ef) by BYAPR06CA0055.outlook.office365.com
 (2603:10b6:a03:14b::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.24 via Frontend Transport; Fri,
 27 Feb 2026 08:13:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C3.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Fri, 27 Feb 2026 08:13:16 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 27 Feb
 2026 02:13:15 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 27 Feb
 2026 02:13:14 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 27 Feb 2026 02:13:08 -0600
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Fix null pointer access in
 amdgpu_userq_signal_ioctl
Date: Fri, 27 Feb 2026 16:12:28 +0800
Message-ID: <20260227081307.2861605-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C3:EE_|DS0PR12MB6486:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d525603-a511-4989-87b5-08de75d80f30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: d5ObqA8cpdlX0kJTrlNZY3JX7Mgo17vGAJl/Su0TnGRTNBT0XNdujTENJNwTYqowcAHlrn4C4TKv+O1goT1UiDtOTPusruagurec2xyCaYSFVTnLhRfJjGVIIwOki2ZSx0Pki3l1nV9KsNEDWd1FT770j22zQjWADe/FLJRo19q0+Cqqh8Ir2dfhp1sFtkA27Ln0+u78K+2PDzpGpOPnlmE4OIeaA8BeQKU8ZIcuyU6zVa89M7zmlkpW1UGyc0lA5tf+jHVUVMxSVtR2WyDqSAOljhxt9XyqCiICcCsdD5oS7jYiZmrgVjhRQ8LBegM1UXb7lqg68IRMB101ld9UDnX9D32N4kwB7oj90TRh4BfeoJvnXGQtMt8WjoCdSnMtwNo545MGjfUXHid6wvsQXpjO4+R3pKWeGnZOzNVYyqoJUNdSogCSxmRIgrYJtv5WKtApb1tuj4bAgepez5ovdcmBime0tH7qAP+7Rv1FwwTIVyj1CUUzY7p/RcMEYZIZOc15wt+ySQH7WDr3ToyOCZjxf09/QTw9s3xNkDEAi/Is5kTNlW6NHb2UUPZ2owP+/3lZk2qcYBYdBs9VdgXMmwQ3syt3q9LhUggGk9zP7jNWfPHZn8NDm5kHQtYOmLnR5nzObzvUuGo0PWs02A5uSxZDT+/k6fhOvNHlvVTpNRmOr2jhd711lgkJkWrXsgj/ipri+oOLQUd5Zi3mIUmXabNZZrAT1ZXcopphjEpTFNeT096uu9oRK5aRUk3oZjf2Nj7u0wEscR2zvFtHphxOQRwyK1o21qRMNwqljowuTJ6Mf0/ibyifydH0r9trXpG1mpdfol8fmhOn3UL1OtQTuA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SVQ+DcmTrLOiN/GHeSG7sYoO/6ME4Ro3xFefzqEmRtcqPw60oBeQP3Bym/rk2SjxhpSiSLrUwr286CM3D7MTSHGorShskpZ/bNhYDt0zsAclKeEGSnIaujzyk4/QoxTB7vef+1z1torPRzSZqZGFyrLNLeDBC3d8L5D+25qxqXDqN+i6fl0sfklKChOmDebuHxVRiQ3veChMS4yw5SoKNskGXI1fMKsxluNWicXg/18RYVDds9Vs8H71K3+CstKYeozOQuHLm/+g0mo0cLwLt3WHmKuZQdDSP9Oo+iX4+3NinzJJZ62kzAv2Li5yiuqCEHvjp800nvLnJcodUterbT8/UpT2ZmN0Y2cWyZ6ikQmSh6gzCSgX97cx/gbtdNZyIRmVArMwN963W2d8L8ut0x+a/0aTmYKUN35qzTHpN2eqY87RhGX7goFKcGGAF0Zy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 08:13:16.0033 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d525603-a511-4989-87b5-08de75d80f30
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6486
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

The amdgpu_userq_signal_ioctl function was triggering kernel page faults
due to missing null pointer checks when accessing gobj_read/gobj_write
arrays, and improper handling of memory allocation for these arrays.

The crash stack showed the failure originated from the ioctl path:
[   64.977695] Call Trace:
[   64.977696]  <TASK>
[   64.977700]  amdgpu_userq_signal_ioctl+0x8e4/0xda0 [amdgpu]
[   64.977830]  ? tty_ldisc_deref+0x1a/0x20
[   64.977834]  ? __pfx_amdgpu_userq_signal_ioctl+0x10/0x10 [amdgpu]
[   64.977934]  drm_ioctl_kernel+0xab/0x110 [drm]
[   64.977955]  ? __pfx_amdgpu_userq_signal_ioctl+0x10/0x10 [amdgpu]
[   64.978071]  drm_ioctl+0x2cb/0x5a0 [drm]
[   64.978088]  ? ttm_bo_vm_fault_reserved+0x1ef/0x410 [ttm]
[   64.978093]  amdgpu_drm_ioctl+0x4f/0x90 [amdgpu]
[   64.978179]  __x64_sys_ioctl+0x9e/0xf0
[   64.978182]  x64_sys_call+0x1274/0x2190
[   64.978185]  do_syscall_64+0x74/0x950
[   64.978189]  ? ___pte_offset_map+0x20/0x170
[   64.978191]  ? __handle_mm_fault+0x986/0xfb0
[   64.978194]  ? count_memcg_events+0xe7/0x1e0
[   64.978197]  ? handle_mm_fault+0x1cc/0x2b0
[   64.978199]  ? do_user_addr_fault+0x394/0x8a0
[   64.978202]  ? irqentry_exit_to_user_mode+0x2a/0x1e0
[   64.978205]  ? irqentry_exit+0x3f/0x50
[   64.978206]  ? exc_page_fault+0x97/0x190
[   64.978208]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   64.978210] RIP: 0033:0x7f3c08b24ded

Fixes: fd4fde1df18b ("drm/amdgpu/userq: Use drm_gem_objects_lookup in amdgpu_userq_signal_ioctl")

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 22 +++++++++++++------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 3c30512a6266..d795d01d9969 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -467,7 +467,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 	const unsigned int num_read_bo_handles = args->num_bo_read_handles;
 	struct amdgpu_fpriv *fpriv = filp->driver_priv;
 	struct amdgpu_userq_mgr *userq_mgr = &fpriv->userq_mgr;
-	struct drm_gem_object **gobj_write, **gobj_read;
+	struct drm_gem_object **gobj_write, **gobj_read = NULL;
 	u32 *syncobj_handles, num_syncobj_handles;
 	struct amdgpu_userq_fence *userq_fence;
 	struct amdgpu_usermode_queue *queue;
@@ -597,13 +597,21 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 exec_fini:
 	drm_exec_fini(&exec);
 put_gobj_write:
-	for (i = 0; i < num_write_bo_handles; i++)
-		drm_gem_object_put(gobj_write[i]);
-	kfree(gobj_write);
+	for (i = 0; i < num_write_bo_handles; i++) {
+		if (gobj_write)
+			drm_gem_object_put(gobj_write[i]);
+	}
+
+	if (gobj_write)
+		kfree(gobj_write);
 put_gobj_read:
-	for (i = 0; i < num_read_bo_handles; i++)
-		drm_gem_object_put(gobj_read[i]);
-	kfree(gobj_read);
+	for (i = 0; i < num_read_bo_handles; i++) {
+		if (gobj_read)
+			drm_gem_object_put(gobj_read[i]);
+	}
+
+	if (gobj_read)
+		kfree(gobj_read);
 free_syncobj:
 	while (entry-- > 0)
 		if (syncobj[entry])
-- 
2.49.0

