Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2051EE91269
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Feb 2026 06:48:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 741E310E056;
	Thu,  5 Feb 2026 06:48:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VTv67k7d";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010035.outbound.protection.outlook.com
 [52.101.193.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33D2710E056
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Feb 2026 06:48:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FE1UJObNr/EF3xQCYG/4YwiUp9oaxsYAaRtRDApm2Am8W65sYkA9gNGuOCUMCSBrplYfxox3PKB8CMnl3+7+IYtdjR75A8BsyGUca2yz4JwPnOEsBwzijtmvXmBJkrda3G9pIcuCK3SDsh2df+CxqMfE9If3I1JUyDvRCuk5QTweb/bN5aumv6jUChbSnP1fJXwyFtNwgeohgntMB62xozX+IuTc5+UMyF+gy9LhEvaoelL+7Dv2ANEv626I6tVooi+z2LADsLTJMmEHfShtbrCf8dFglDrTWAHkby57z9+D2w94NQWdu+fOuCQIqSnJPmSEOkcTCjzaycfAak9i9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7BRIutIoJMcCZCLwIZ1cEAdAxzDgmm+yOZLLaKZSwi4=;
 b=MiDm0+d5ARH1hy5qsNFjc6KQwpjTzM4Wb5+JUmVce2I2yi+iEfdTWFtFnESnUZY+vkXcyB13A95zajYTAi7mRVcPYYJVnVwqw+NTe5POBNIrGBoVj/zgz001+dnXiuQ9dUBGS0oTkdgn2sGU7Ka/jb+tDPKIVhJMlNNNKLsVVJX+zndfSBgtXLAeb6XdfI5eEto0RNfPYGozNOXwCOTtnuBfCSEBq2mpMGLR011K6LVeUtY1Mv3rOyDCfn9N1rK0DhhacxmsodbWo3pTN+13T0ByeEIuOCTWqJWAy6xE0wZb+kqEd260kOB3miRIh6C93F5NMbKXm2TQwH9fMrzsCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7BRIutIoJMcCZCLwIZ1cEAdAxzDgmm+yOZLLaKZSwi4=;
 b=VTv67k7dIMjcNJ2W2w2sbqnK8Ne0475s4r00HM42WQUtBjUgqtcba08wARU4Nn+AsKjGQpW94TzYVLhvhfHYYbdZtTDUggYl9NhIOKWgx+A27sF3dCv/2M/0A3XjamjDE1j+sMtUClImOfDIPrB/YgidISPZlro2AYN8N1as8JY=
Received: from SJ0PR03CA0169.namprd03.prod.outlook.com (2603:10b6:a03:338::24)
 by DS2PR12MB9776.namprd12.prod.outlook.com (2603:10b6:8:2bd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 06:48:37 +0000
Received: from SJ1PEPF0000231B.namprd03.prod.outlook.com
 (2603:10b6:a03:338:cafe::36) by SJ0PR03CA0169.outlook.office365.com
 (2603:10b6:a03:338::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Thu,
 5 Feb 2026 06:48:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231B.mail.protection.outlook.com (10.167.242.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Thu, 5 Feb 2026 06:48:36 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 5 Feb 2026 00:48:34 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <alexander.deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <yifan1.zhang@amd.com>, <perry.yuan@amd.com>
Subject: [PATCH] Add kfd_ioctl_profiler to contain profiler kernel driver
 changes
Date: Thu, 5 Feb 2026 14:48:23 +0800
Message-ID: <20260205064823.646853-1-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231B:EE_|DS2PR12MB9776:EE_
X-MS-Office365-Filtering-Correlation-Id: 865475a7-4403-4c9f-0ed3-08de648296aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Py7yc7euaI3O3WTjkARgZypPICc0RKcR70s7LmAmM3daEN5+weHaDHGfa8b0?=
 =?us-ascii?Q?onkpaDR8W8veGYmoSthwau5nKRHtqC8COnidoF2t/JbDc3KPr2JQeFHqlPm8?=
 =?us-ascii?Q?Jevupexwv3SkZkSEi2QRs8rhMcqaQ8oyfCBa6I+lJdhPuFs1ENV96Aw3x6tI?=
 =?us-ascii?Q?qe3gFYSxhKpWZdJpiiVZgG3r4GhWQdO50C3WOmDgy8TmtVcEQCTMOhIO6XWv?=
 =?us-ascii?Q?Abn4oPBAul2wH6oB+zTVO7aSXCfuFpsMyRaZFG2pXWW4u3JwEPi0nx8KeDny?=
 =?us-ascii?Q?Xul6Tv8weV50yset8YpOJhWft6Kqd7WgmcgR3DqopCrf4B8XrGh4ZL9BN43f?=
 =?us-ascii?Q?z68L/YOJEurPfoxw99s+ktF0mH5f8eVzSI0yLp5WtjFMj1CXpY1Iv3ASao1T?=
 =?us-ascii?Q?f7qZzhHxF+nhiwR9ozzCTVPE9U1jDAoH7CZKTuF3B12tm/SLsZ5sozA7kLRI?=
 =?us-ascii?Q?hLCsGILFwsi3gsMo8egyyxjc4RQ+2fovb1sDlHBUmiP9wUvi0wnuuAl1DNwi?=
 =?us-ascii?Q?tV55WHoPm+dQe4+OiYrDy4t7aQ8x+cOhftsqazgJ1tYusp37B1xhgGIhasGp?=
 =?us-ascii?Q?HqyDpWc0Me6jTHZnTJU+izy/5NYLYwiCN5Sn7CVNG8FTG863afdgQczDdIK/?=
 =?us-ascii?Q?TjM/Ai/5vknYh27+3wSk05SXiAobkWFejBL5BS6Sz0AN0KJNpH3mVBslKgkj?=
 =?us-ascii?Q?HyDKHbzxr5eATUoft8HIEo61IRbhwkd6fmFXLLEehNKQ05hlmt3yVVdqV75E?=
 =?us-ascii?Q?MiZUVSAPDv+3uQQUEZEQpvhlprpc+mnoo3xuNA43xXchIh34lsIavkXZMzuI?=
 =?us-ascii?Q?cSMNFmRL7CRcg3oAsw0wDktPGvmEDRL9JrRUSRj7ZY075UESM0K3pDCRbZZJ?=
 =?us-ascii?Q?pZUuMfGrx4llDBR8Tef5s5DWhJ9L15y1MemFaL5HSIc8S45fXdJVwbT+Eq8x?=
 =?us-ascii?Q?f9qGgq+udwgYdkciHdUU7Snf/5cLCEVPKXU6oy/JsqU4uf09nkzcY7pIHTHf?=
 =?us-ascii?Q?g4oxdb096pVbJEK/bgeXeBBIPQCbcc/5y+KMqdqkxHEk09o7xmwJNfvWHev4?=
 =?us-ascii?Q?Hcc5bOop5eSX5WggSig1m7uFaBBt6tA3E9YA2llNcI4pmYX6jmH29TNcjGny?=
 =?us-ascii?Q?ytGgRz5LsyOmAI4JqhUB752uOjYZ+VT0Hch30kqeSJ5QuS6znaKd7oTrEKHr?=
 =?us-ascii?Q?07sn8p7jibWZmtaf6einTYL2+s9Lv/OQj6puqfEW5rcHg8Y2+tnL2TiU6GBC?=
 =?us-ascii?Q?ycnC/NATj/aVb0i9OVsW02RGW7oUy/LS618cgXgLz02mS+muYeljmUFlScjP?=
 =?us-ascii?Q?p5eBmLj5378+SOhiQyXPxL20IL/jIS0d93FHkEjvXV8BmvvrO+NfOQfnFOA8?=
 =?us-ascii?Q?LZOTuEJg21H3y+lysTwVQDLXjr9z4zwD/25bsFv1taQfAsUpnPtXxXrx6n4e?=
 =?us-ascii?Q?gJWBWJjPGjlFUH80zeRjGYW+IH7oveWBpDPS0Gclso8YIA5KeGUWwO3dhThu?=
 =?us-ascii?Q?TVFBlv5GrFv68vkwoZoyk9R1HC1jucBlava3CkeBszVSNb4Ue/HuRcwEzPfr?=
 =?us-ascii?Q?zY4lqIpOcr3gfEnbkmM4YxORCvofgdH8zarMpKlQnj/WLhMb6UgHUGdo0G8p?=
 =?us-ascii?Q?LWxAeWk7TE6IC/IAeH/+d2W/4ag0R+Q97DhGAlKUCuN/veNla63zxY31UnWZ?=
 =?us-ascii?Q?DOvBJA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DP1Kn5RiP6cirRBk1ZdbEHfVaDS+YFWUJ8PV8uuIgbJ4QAI00CkzXILrXXw86zpXEdI6xiAwMBjzjtjJIzy2NckPMqTHsDwMa3er33xzJU+CzMRIZ++mS1eVx79aNuqtYFNwr9egdeAX4ui2pClGV05mcfiqVbxMbMfbJKJ0bBQK16LdnRqdnW20Xzo5+IDx4hkJeulIq/x4tM9q38w2+vC5WYVULP4ayKJiQn6tC569OQv/SroDhxCDX89cxwGj+h+LV8N5Crde/oxrBNIl9TnO7FlqidEwkXNWlkWY1EVa9WASo6WkeL/9aPujZxlSvUCJyMDsWrAOHbNkJnovlF75GBTSGctZGk7K49Sf0JEGvFqbSWGISTc0sSzH+EyRNC/YWbPqdKIyvAFRKqTBs0RIrX/VLu0EuFDNjgXe0KqZU2OSgO9hQKVRCaGygOk2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 06:48:36.8337 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 865475a7-4403-4c9f-0ed3-08de648296aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9776
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

From: Benjamin Welton <bewelton@amd.com>

kfd_ioctl_profiler takes a similar approach to that of
kfd_ioctl_dbg_trap (which contains debugger related IOCTL
services) where kfd_ioctl_profiler will contain all profiler
related IOCTL services. The IOCTL is designed to be expanded
as needed to support additional profiler functionality.

The current functionality of the IOCTL is to allow for profilers
which need PMC counters from GPU devices to both signal to other
profilers that may be on the system that the device has active PMC
profiling taking place on it (multiple PMC profilers on the same
device can result in corrupted counter data) and to setup the device
to allow for the collection of SQ PMC data on all queues on the device.

For PMC data for the SQ block (such as SQ_WAVES) to be available
to a profiler, mmPERFCOUNT_ENABLE must be set on the queues. When
profiling a single process, the profiler can inject PM4 packets into
each queue to turn on PERFCOUNT_ENABLE. When profiling system wide,
the profiler does not have this option and must have a way to turn
on profiling for queues in which it cannot inject packets into directly.

Accomplishing this requires a few steps:

1. Checking if the user has the necessary permissions to profile system
   wide on the device. This check uses the same check that linux perf
   uses to determine if a user has the necessary permissions to profile
   at this scope (primarily if the process has CAP_SYS_PERFMON or is root).

2. Locking the device for profiling. This is done by setting a lock bit
   on the device struct and storing the process that locked the device.

3. Iterating all queues on the device and issuing an MQD Update to enable
   perfcounting on the queues.

4. Actions to cleanup if the process exits or releases the lock.

The IOCTL also contains a link to the existing PC Sampling IOCTL as well.
This is per a suggestion that we should potentially remove the PC Sampling
IOCTL to have it be a part of the profiler IOCTL. This is a future change.
In addition, we do expect to expand the profiler IOCTL to include
additional profiler functionality in the future (which necessitates the
use of a version number).

Signed-off-by: Benjamin Welton <benjamin.welton@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Acked-by: Kent Russell <kent.russell@amd.com>
Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 82 +++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  4 +
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 25 ++++++
 .../drm/amd/amdkfd/kfd_device_queue_manager.h |  2 +
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c  | 16 +++-
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c  | 14 +++-
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c  |  8 +-
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   | 15 +++-
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c   | 11 +++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  7 ++
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 11 +++
 include/uapi/linux/kfd_ioctl.h                | 30 +++++++
 12 files changed, 217 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 732ad1224a61..dbb111a33678 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -21,6 +21,7 @@
  * OTHER DEALINGS IN THE SOFTWARE.
  */
 
+#include <linux/capability.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/fs.h>
@@ -3204,6 +3205,84 @@ static int kfd_ioctl_create_process(struct file *filep, struct kfd_process *p, v
 	return 0;
 }
 
+static inline uint32_t profile_lock_device(struct kfd_process *p,
+					   uint32_t gpu_id, uint32_t op)
+{
+	struct kfd_process_device *pdd;
+	struct kfd_dev *kfd;
+	int status = -EINVAL;
+
+	if (!p)
+		return -EINVAL;
+
+	mutex_lock(&p->mutex);
+	pdd = kfd_process_device_data_by_id(p, gpu_id);
+	mutex_unlock(&p->mutex);
+
+	if (!pdd || !pdd->dev || !pdd->dev->kfd)
+		return -EINVAL;
+
+	kfd = pdd->dev->kfd;
+
+	mutex_lock(&kfd->profiler_lock);
+	if (op == 1) {
+		if (!kfd->profiler_process) {
+			kfd->profiler_process = p;
+			status = 0;
+		} else if (kfd->profiler_process == p) {
+			status = -EALREADY;
+		} else {
+			status = -EBUSY;
+		}
+	} else if (op == 0 && kfd->profiler_process == p) {
+		kfd->profiler_process = NULL;
+		status = 0;
+	}
+	mutex_unlock(&kfd->profiler_lock);
+
+	return status;
+}
+
+static inline int kfd_profiler_pmc(struct kfd_process *p,
+				   struct kfd_ioctl_pmc_settings *args)
+{
+	struct kfd_process_device *pdd;
+	struct device_queue_manager *dqm;
+	int status;
+
+	/* Check if we have the correct permissions. */
+	if (!perfmon_capable())
+		return -EPERM;
+
+	/* Lock/Unlock the device based on the parameter given in OP */
+	status = profile_lock_device(p, args->gpu_id, args->lock);
+	if (status != 0)
+		return status;
+
+	/* Enable/disable perfcount if requested */
+	mutex_lock(&p->mutex);
+	pdd = kfd_process_device_data_by_id(p, args->gpu_id);
+	dqm = pdd->dev->dqm;
+	mutex_unlock(&p->mutex);
+
+	dqm->ops.set_perfcount(dqm, args->perfcount_enable);
+	return status;
+}
+
+static int kfd_ioctl_profiler(struct file *filep, struct kfd_process *p, void *data)
+{
+	struct kfd_ioctl_profiler_args *args = data;
+
+	switch (args->op) {
+	case KFD_IOC_PROFILER_VERSION:
+		args->version = KFD_IOC_PROFILER_VERSION_NUM;
+		return 0;
+	case KFD_IOC_PROFILER_PMC:
+		return kfd_profiler_pmc(p, &args->pmc);
+	}
+	return -EINVAL;
+}
+
 #define AMDKFD_IOCTL_DEF(ioctl, _func, _flags) \
 	[_IOC_NR(ioctl)] = {.cmd = ioctl, .func = _func, .flags = _flags, \
 			    .cmd_drv = 0, .name = #ioctl}
@@ -3325,6 +3404,9 @@ static const struct amdkfd_ioctl_desc amdkfd_ioctls[] = {
 
 	AMDKFD_IOCTL_DEF(AMDKFD_IOC_CREATE_PROCESS,
 			kfd_ioctl_create_process, 0),
+
+	AMDKFD_IOCTL_DEF(AMDKFD_IOC_PROFILER,
+			kfd_ioctl_profiler, 0),
 };
 
 #define AMDKFD_CORE_IOCTL_COUNT	ARRAY_SIZE(amdkfd_ioctls)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 9a66ee661e57..f231e46e8528 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -936,6 +936,9 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 
 	svm_range_set_max_pages(kfd->adev);
 
+	kfd->profiler_process = NULL;
+	mutex_init(&kfd->profiler_lock);
+
 	kfd->init_complete = true;
 	dev_info(kfd_device, "added device %x:%x\n", kfd->adev->pdev->vendor,
 		 kfd->adev->pdev->device);
@@ -971,6 +974,7 @@ void kgd2kfd_device_exit(struct kfd_dev *kfd)
 		ida_destroy(&kfd->doorbell_ida);
 		kfd_gtt_sa_fini(kfd);
 		amdgpu_amdkfd_free_kernel_mem(kfd->adev, &kfd->gtt_mem);
+		mutex_destroy(&kfd->profiler_lock);
 	}
 
 	kfree(kfd);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 804851632c4c..4170a283db5b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -305,6 +305,29 @@ static int remove_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 	return r;
 }
 
+static void set_perfcount(struct device_queue_manager *dqm, int enable)
+{
+	struct device_process_node *cur;
+	struct qcm_process_device *qpd;
+	struct queue *q;
+	struct mqd_update_info minfo = { 0 };
+
+	if (!dqm)
+		return;
+
+	minfo.update_flag = (enable == 1 ? UPDATE_FLAG_PERFCOUNT_ENABLE :
+						 UPDATE_FLAG_PERFCOUNT_DISABLE);
+	dqm_lock(dqm);
+	list_for_each_entry(cur, &dqm->queues, list) {
+		qpd = cur->qpd;
+		list_for_each_entry(q, &qpd->queues_list, list) {
+			pqm_update_mqd(qpd->pqm, q->properties.queue_id,
+						&minfo);
+		}
+	}
+	dqm_unlock(dqm);
+}
+
 static int remove_all_kfd_queues_mes(struct device_queue_manager *dqm)
 {
 	struct device_process_node *cur;
@@ -2967,6 +2990,7 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_node *dev)
 		dqm->ops.reset_queues = reset_queues_cpsch;
 		dqm->ops.get_queue_checkpoint_info = get_queue_checkpoint_info;
 		dqm->ops.checkpoint_mqd = checkpoint_mqd;
+		dqm->ops.set_perfcount = set_perfcount;
 		break;
 	case KFD_SCHED_POLICY_NO_HWS:
 		/* initialize dqm for no cp scheduling */
@@ -2987,6 +3011,7 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_node *dev)
 		dqm->ops.get_wave_state = get_wave_state;
 		dqm->ops.get_queue_checkpoint_info = get_queue_checkpoint_info;
 		dqm->ops.checkpoint_mqd = checkpoint_mqd;
+		dqm->ops.set_perfcount = set_perfcount;
 		break;
 	default:
 		dev_err(dev->adev->dev, "Invalid scheduling policy %d\n", dqm->sched_policy);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index ef07e44916f8..74a3bcec3e4e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -200,6 +200,8 @@ struct device_queue_manager_ops {
 				  const struct queue *q,
 				  void *mqd,
 				  void *ctl_stack);
+	void	(*set_perfcount)(struct device_queue_manager *dqm,
+				  int enable);
 };
 
 struct device_queue_manager_asic_ops {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
index 97055f808d4a..993d60a24d50 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
@@ -124,10 +124,9 @@ static void init_mqd(struct mqd_manager *mm, void **mqd,
 	 */
 	m->cp_hqd_hq_scheduler0 = 1 << 14;
 
-	if (q->format == KFD_QUEUE_FORMAT_AQL) {
+	if (q->format == KFD_QUEUE_FORMAT_AQL)
 		m->cp_hqd_aql_control =
 			1 << CP_HQD_AQL_CONTROL__CONTROL0__SHIFT;
-	}
 
 	if (mm->dev->kfd->cwsr_enabled) {
 		m->cp_hqd_persistent_state |=
@@ -142,6 +141,12 @@ static void init_mqd(struct mqd_manager *mm, void **mqd,
 		m->cp_hqd_wg_state_offset = q->ctl_stack_size;
 	}
 
+	mutex_lock(&mm->dev->kfd->profiler_lock);
+	if (mm->dev->kfd->profiler_process != NULL)
+		m->compute_perfcount_enable = 1;
+
+	mutex_unlock(&mm->dev->kfd->profiler_lock);
+
 	*mqd = m;
 	if (gart_addr)
 		*gart_addr = addr;
@@ -221,6 +226,13 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
 	if (mm->dev->kfd->cwsr_enabled)
 		m->cp_hqd_ctx_save_control = 0;
 
+	if (minfo) {
+		if (minfo->update_flag == UPDATE_FLAG_PERFCOUNT_ENABLE)
+			m->compute_perfcount_enable = 1;
+		else if (minfo->update_flag == UPDATE_FLAG_PERFCOUNT_DISABLE)
+			m->compute_perfcount_enable = 0;
+	}
+
 	update_cu_mask(mm, mqd, minfo);
 	set_priority(m, q);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
index 7e5a7ab6d0c0..4a574bbb5f37 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
@@ -164,10 +164,9 @@ static void init_mqd(struct mqd_manager *mm, void **mqd,
 	if (amdgpu_amdkfd_have_atomics_support(mm->dev->adev))
 		m->cp_hqd_hq_status0 |= 1 << 29;
 
-	if (q->format == KFD_QUEUE_FORMAT_AQL) {
+	if (q->format == KFD_QUEUE_FORMAT_AQL)
 		m->cp_hqd_aql_control =
 			1 << CP_HQD_AQL_CONTROL__CONTROL0__SHIFT;
-	}
 
 	if (mm->dev->kfd->cwsr_enabled) {
 		m->cp_hqd_persistent_state |=
@@ -182,6 +181,11 @@ static void init_mqd(struct mqd_manager *mm, void **mqd,
 		m->cp_hqd_wg_state_offset = q->ctl_stack_size;
 	}
 
+	mutex_lock(&mm->dev->kfd->profiler_lock);
+	if (mm->dev->kfd->profiler_process != NULL)
+		m->compute_perfcount_enable = 1;
+	mutex_unlock(&mm->dev->kfd->profiler_lock);
+
 	*mqd = m;
 	if (gart_addr)
 		*gart_addr = addr;
@@ -259,6 +263,12 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
 	}
 	if (mm->dev->kfd->cwsr_enabled)
 		m->cp_hqd_ctx_save_control = 0;
+	if (minfo) {
+		if (minfo->update_flag == UPDATE_FLAG_PERFCOUNT_ENABLE)
+			m->compute_perfcount_enable = 1;
+		else if (minfo->update_flag == UPDATE_FLAG_PERFCOUNT_DISABLE)
+			m->compute_perfcount_enable = 0;
+	}
 
 	update_cu_mask(mm, mqd, minfo);
 	set_priority(m, q);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
index a51f217329db..7173f6470e5e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
@@ -139,10 +139,9 @@ static void init_mqd(struct mqd_manager *mm, void **mqd,
 	if (amdgpu_amdkfd_have_atomics_support(mm->dev->adev))
 		m->cp_hqd_hq_status0 |= 1 << 29;
 
-	if (q->format == KFD_QUEUE_FORMAT_AQL) {
+	if (q->format == KFD_QUEUE_FORMAT_AQL)
 		m->cp_hqd_aql_control =
 			1 << CP_HQD_AQL_CONTROL__CONTROL0__SHIFT;
-	}
 
 	if (mm->dev->kfd->cwsr_enabled) {
 		m->cp_hqd_persistent_state |=
@@ -157,6 +156,11 @@ static void init_mqd(struct mqd_manager *mm, void **mqd,
 		m->cp_hqd_wg_state_offset = q->ctl_stack_size;
 	}
 
+	mutex_lock(&mm->dev->kfd->profiler_lock);
+	if (mm->dev->kfd->profiler_process != NULL)
+		m->compute_perfcount_enable = 1;
+	mutex_unlock(&mm->dev->kfd->profiler_lock);
+
 	*mqd = m;
 	if (gart_addr)
 		*gart_addr = addr;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index dcf4bbfa641b..d4659a438be5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -218,10 +218,9 @@ static void init_mqd(struct mqd_manager *mm, void **mqd,
 		m->cp_hqd_aql_control =
 			1 << CP_HQD_AQL_CONTROL__CONTROL0__SHIFT;
 
-	if (q->tba_addr) {
+	if (q->tba_addr)
 		m->compute_pgm_rsrc2 |=
 			(1 << COMPUTE_PGM_RSRC2__TRAP_PRESENT__SHIFT);
-	}
 
 	if (mm->dev->kfd->cwsr_enabled && q->ctx_save_restore_area_address) {
 		m->cp_hqd_persistent_state |=
@@ -236,6 +235,11 @@ static void init_mqd(struct mqd_manager *mm, void **mqd,
 		m->cp_hqd_wg_state_offset = q->ctl_stack_size;
 	}
 
+	mutex_lock(&mm->dev->kfd->profiler_lock);
+	if (mm->dev->kfd->profiler_process != NULL)
+		m->compute_perfcount_enable = 1;
+	mutex_unlock(&mm->dev->kfd->profiler_lock);
+
 	*mqd = m;
 	if (gart_addr)
 		*gart_addr = addr;
@@ -318,6 +322,13 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
 	if (mm->dev->kfd->cwsr_enabled && q->ctx_save_restore_area_address)
 		m->cp_hqd_ctx_save_control = 0;
 
+	if (minfo) {
+		if (minfo->update_flag == UPDATE_FLAG_PERFCOUNT_ENABLE)
+			m->compute_perfcount_enable = 1;
+		else if (minfo->update_flag == UPDATE_FLAG_PERFCOUNT_DISABLE)
+			m->compute_perfcount_enable = 0;
+	}
+
 	if (KFD_GC_VERSION(mm->dev) != IP_VERSION(9, 4, 3) &&
 	    KFD_GC_VERSION(mm->dev) != IP_VERSION(9, 4, 4) &&
 	    KFD_GC_VERSION(mm->dev) != IP_VERSION(9, 5, 0))
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
index 09483f0862d4..e8967f5e3892 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
@@ -149,6 +149,11 @@ static void init_mqd(struct mqd_manager *mm, void **mqd,
 		m->cp_hqd_wg_state_offset = q->ctl_stack_size;
 	}
 
+	mutex_lock(&mm->dev->kfd->profiler_lock);
+	if (mm->dev->kfd->profiler_process != NULL)
+		m->compute_perfcount_enable = 1;
+	mutex_unlock(&mm->dev->kfd->profiler_lock);
+
 	*mqd = m;
 	if (gart_addr)
 		*gart_addr = addr;
@@ -231,6 +236,12 @@ static void __update_mqd(struct mqd_manager *mm, void *mqd,
 		m->cp_hqd_ctx_save_control =
 			atc_bit << CP_HQD_CTX_SAVE_CONTROL__ATC__SHIFT |
 			mtype << CP_HQD_CTX_SAVE_CONTROL__MTYPE__SHIFT;
+	if (minfo) {
+		if (minfo->update_flag == UPDATE_FLAG_PERFCOUNT_ENABLE)
+			m->compute_perfcount_enable = 1;
+		else if (minfo->update_flag == UPDATE_FLAG_PERFCOUNT_DISABLE)
+			m->compute_perfcount_enable = 0;
+	}
 
 	update_cu_mask(mm, mqd, minfo);
 	set_priority(m, q);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 9849b54f54ba..8983065645fa 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -384,6 +384,11 @@ struct kfd_dev {
 	int kfd_dev_lock;
 
 	atomic_t kfd_processes_count;
+
+	/* Lock for profiler process */
+	struct mutex profiler_lock;
+	/* Process currently holding the lock */
+	struct kfd_process *profiler_process;
 };
 
 enum kfd_mempool {
@@ -556,6 +561,8 @@ enum mqd_update_flag {
 	UPDATE_FLAG_DBG_WA_ENABLE = 1,
 	UPDATE_FLAG_DBG_WA_DISABLE = 2,
 	UPDATE_FLAG_IS_GWS = 4, /* quirk for gfx9 IP */
+	UPDATE_FLAG_PERFCOUNT_ENABLE = 5,
+	UPDATE_FLAG_PERFCOUNT_DISABLE = 6,
 };
 
 struct mqd_update_info {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 8511fbebf327..deca19b478d0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1110,6 +1110,16 @@ static void kfd_process_free_outstanding_kfd_bos(struct kfd_process *p)
 		kfd_process_device_free_bos(p->pdds[i]);
 }
 
+static void kfd_process_profiler_release(struct kfd_process *p, struct kfd_process_device *pdd)
+{
+	mutex_lock(&pdd->dev->kfd->profiler_lock);
+	if (pdd->dev->kfd->profiler_process == p) {
+		pdd->qpd.dqm->ops.set_perfcount(pdd->qpd.dqm, 0);
+		pdd->dev->kfd->profiler_process = NULL;
+	}
+	mutex_unlock(&pdd->dev->kfd->profiler_lock);
+}
+
 static void kfd_process_destroy_pdds(struct kfd_process *p)
 {
 	int i;
@@ -1121,6 +1131,7 @@ static void kfd_process_destroy_pdds(struct kfd_process *p)
 
 		pr_debug("Releasing pdd (topology id %d, for pid %d)\n",
 			pdd->dev->id, p->lead_thread->pid);
+		kfd_process_profiler_release(p, pdd);
 		kfd_process_device_destroy_cwsr_dgpu(pdd);
 		kfd_process_device_destroy_ib_mem(pdd);
 
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index e72359370857..abb526c915c3 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -1558,6 +1558,30 @@ struct kfd_ioctl_dbg_trap_args {
 	};
 };
 
+#define KFD_IOC_PROFILER_VERSION_NUM 1
+enum kfd_profiler_ops {
+	KFD_IOC_PROFILER_PMC = 0,
+	KFD_IOC_PROFILER_PC_SAMPLE = 1,
+	KFD_IOC_PROFILER_VERSION = 2,
+};
+
+/**
+ * Enables/Disables GPU Specific profiler settings
+ */
+struct kfd_ioctl_pmc_settings {
+	__u32 gpu_id;             /* This is the user_gpu_id */
+	__u32 lock;               /* Lock GPU for Profiling */
+	__u32 perfcount_enable;   /* Force Perfcount Enable for queues on GPU */
+};
+
+struct kfd_ioctl_profiler_args {
+	__u32 op;						/* kfd_profiler_op */
+	union {
+		struct kfd_ioctl_pmc_settings  pmc;
+		__u32 version;				/* KFD_IOC_PROFILER_VERSION_NUM */
+	};
+};
+
 #define AMDKFD_IOCTL_BASE 'K'
 #define AMDKFD_IO(nr)			_IO(AMDKFD_IOCTL_BASE, nr)
 #define AMDKFD_IOR(nr, type)		_IOR(AMDKFD_IOCTL_BASE, nr, type)
@@ -1684,4 +1708,10 @@ struct kfd_ioctl_dbg_trap_args {
 #define AMDKFD_COMMAND_START		0x01
 #define AMDKFD_COMMAND_END		0x28
 
+#define AMDKFD_IOC_PROFILER			\
+		AMDKFD_IOWR(0x86, struct kfd_ioctl_profiler_args)
+
+#define AMDKFD_COMMAND_START_2		0x80
+#define AMDKFD_COMMAND_END_2		0x87
+
 #endif
-- 
2.34.1

