Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78194C25B5F
	for <amd-gfx@archiver.kernel.org>; Mon, 13 May 2024 04:14:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF7DA10E09E;
	Mon, 13 May 2024 04:14:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W8qC6X77";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A204C10E09E
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 May 2024 04:14:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BDrJoRfqZOjq0KEOnEy4UHdW3CZiuryo2GK+/LMqXpBNbwy8a2SA9YwKMftK+fVTEt1HAIUlq3tpQhJx6/oK1yJi1Z/8r8Bf/DjnWvr4yzx6UbLgodCfML2qg5mbz0VQy+kTVTMyl3SGbl2mnvh4i8DfMGybW3IoSirCtfouZD8IhnB1PeYiSfLBCkX6WYw6OZLmDg2JMJfPInL08nPvoRgO39yDY6kPe88KTOvX5ul3Pr4RkqBJs03yEo0+7WnyrrmJrQ+QmtHffvRaJ1fq3KOZqo5k46nu0M2SXvz09IKAd+Gkbnem40+DowmGJOuQTLjbdsFstDSJr94w+vzcuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JXTHjYXn5kGKgczqOdZQGpRT7JpETzC2djxAbdZ6Kwo=;
 b=XIbYDs63ZGXXw4YdpgBoIaIyaYXLufPkmabv+q3FTS+xs5DNt0z0TkU2VP1/CH6SlOPapnHhoNOwwB6UeyY67/E6Hh08gOBm+s4DJrs3gBoB9/d2wvDPlAOrBgAPlIZwNAR9zHoPyZbSyGIOGeL7YN5DPXou5BIloamh4lEsFhLCKmhcJ5kjg1fvpgRbK9MJfaVmVELZePKTQxrFDdQv1uqTmJW3kSd2gMX3yIT29Y41OVcndnBkWpphutzWCJUWx/SAOiD+Uy4XP1zDQ91cdleaiMmGGk0OnpgCf9FBemrB/v8WFOdg5Lziqh4iOZkjndzPyhLKjtEPhpzo1rnp+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JXTHjYXn5kGKgczqOdZQGpRT7JpETzC2djxAbdZ6Kwo=;
 b=W8qC6X77hyM+c8wP9+c0UK1CbhW+bgopYEXPl9d/PrCrNJvtNhOWufBKRbPsp+mhuEEcD3PomCivnRfDGqjveq77RR9C0e6fxYZSwUB2w08Obq2lEl+JJOcbPoUUBuydrjIfkSbkztwjI//yM9oZEqpGBd1smUolWkMjuMP6D3I=
Received: from BYAPR21CA0020.namprd21.prod.outlook.com (2603:10b6:a03:114::30)
 by SJ2PR12MB7865.namprd12.prod.outlook.com (2603:10b6:a03:4cc::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 13 May
 2024 04:14:34 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:a03:114:cafe::be) by BYAPR21CA0020.outlook.office365.com
 (2603:10b6:a03:114::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.4 via Frontend
 Transport; Mon, 13 May 2024 04:14:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Mon, 13 May 2024 04:14:33 +0000
Received: from OriUbuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sun, 12 May
 2024 23:14:32 -0500
From: Ori Messinger <Ori.Messinger@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Ori Messinger <Ori.Messinger@amd.com>
Subject: [PATCH v3] drm/amdgpu: Add Ring Hang Events
Date: Mon, 13 May 2024 00:14:14 -0400
Message-ID: <20240513041414.130959-1-Ori.Messinger@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|SJ2PR12MB7865:EE_
X-MS-Office365-Filtering-Correlation-Id: f21fcba4-56c1-445b-5cf9-08dc730331c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|82310400017|376005|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Yn+ybeG+qkiZguZ8EaXl4V9BAlKW9Mf+WqGa1443M0JVia80+34NA9fovUFh?=
 =?us-ascii?Q?I9neLHRjEI516bTIrbVzWFSyQgXgPsMFK+vuuMKWnpevUB0y5x1EQ0ZBdSa+?=
 =?us-ascii?Q?tWh6Ytu0+wdlmORjxeawVDcjCp8Q/GUBtpq1+uFAKMPL2+lpj03aE2Ts4OCf?=
 =?us-ascii?Q?BTbYZv9HXg+f+JEtBXz+xiXYD0JU1Zhix1kMmUMHSiHaqp1ldjFqXFIHPbiQ?=
 =?us-ascii?Q?A7y8ESsVAhHcuuYskne22syl1zoEpwC/hzYp9ZpbBIEdgLgkxweoIkAFDPiN?=
 =?us-ascii?Q?hKgpsKVefxKTht5vyscf/DhDIuRg947PA8ujkOoc9B8xCmX7xz+NpfrahZ0w?=
 =?us-ascii?Q?yM0iJW3WKkauAZQdka1ocK9pJ40F1JFdkzoFTeCyMU6+5ZTpqzWDB5jyjNQg?=
 =?us-ascii?Q?fkrG5abPzL5M9+fVPGGYt+bSiwtrm+r6R6cAG5LPMO0wWAl8yN2NxEXdXj7W?=
 =?us-ascii?Q?drndP39hjfT+1gEmPyg1cIJQGuBjpitidVkQlHFT0yzKDFVdGZiVwPD4x19H?=
 =?us-ascii?Q?LsVRHF2OC69gyPLXkhwvuUkMKQSdFckI9AnfjgcCMy+YZIXLlz5qXhKPncRB?=
 =?us-ascii?Q?yuNKx697U/w31hQ01G6fRgwG7I9kyNNJkScgv+PS31rWFzVXOI1HvPaLn5ME?=
 =?us-ascii?Q?Bqnd0k+0AvOB9Rt/HBjB1sP1nFU3sChrMlOEUpl6bCLKAG+ttC1ZQU1u0sYc?=
 =?us-ascii?Q?npgLAh5DZIdMlL/+MPpmVbABBmlC7SuOMQnyusHtflHPi6FPfKNyTPkopRgd?=
 =?us-ascii?Q?Sph/1C28NdUBrH2JGz//BSXAfS+Js4Dopz3Ka78gc5kWLhgdmTNsQie2mUPM?=
 =?us-ascii?Q?F8rwN6UAHrGCg31fXID/sfaId7KdBO7HetfrHO/8xcXMs0Mmp2zEDkZFJv+x?=
 =?us-ascii?Q?xUjvzqTUfjXhGA3UEVCZRcSl0q6V+eKfCRCfGWETVpk4E/ZqDleKgOg+ADkT?=
 =?us-ascii?Q?zhiO3iQwhuljLk+3MEk2GEKil4ec1Atk3mHEUskvBM5tT/kprf3lKUkW2hQT?=
 =?us-ascii?Q?h9QX7C8s5JlUpvbNkTS8Dml1Gcu8RA7eclWymQgjcLx253s7zwTBaLRv7kNq?=
 =?us-ascii?Q?5pfUj3m4AbQWkgZi/4U+8y/vvtYaExRpVesmkltqLKCqfzd1M5BX91tDyC3g?=
 =?us-ascii?Q?I2YLEbh2Hc+T9QdJNQk553b+7uSKaJRk01TCHct/yRgmjlQqa0ALHRFLYglP?=
 =?us-ascii?Q?60j4dvpYQJ4DSUaIz6w0kV95eTf9kC3f8V6sumXiha9TEEMNgzaOH9AjH8/7?=
 =?us-ascii?Q?pW0Rygk6+lwiyWrP/D7aatcGLFca6JjVjg3JlD6DJzHFkp0rubHPl7HCjW4B?=
 =?us-ascii?Q?HflSgJmP4lVUxcXENADcv6sPc/QnuYKqfqvTS6cYwBH+c21esQV52R9aY/qO?=
 =?us-ascii?Q?KxRnoFJGRzkTz7haOsapmsGSGtzJ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400017)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 04:14:33.5148 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f21fcba4-56c1-445b-5cf9-08dc730331c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7865
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

This patch adds 'ring hang' events to the driver.
This is done by adding a 'reset_ring_hang' bool variable to the
struct 'amdgpu_reset_context' in the amdgpu_reset.h file.
The purpose for this 'reset_ring_hang' variable is whenever a GPU
reset is initiated due to a ring hang, the reset_ring_hang should
be set to 'true'.

Additionally, the reset cause is passed into the kfd smi event as
a string, and is displayed in dmesg as an error.

This 'amdgpu_reset_context' struct is now also passed
through across all relevant functions, and another event type
"KFD_SMI_EVENT_RING_HANG" is added to the kfd_smi_event enum.

Signed-off-by: Ori Messinger <Ori.Messinger@amd.com>
Change-Id: I6af3022eb1b4514201c9430d635ff87f167ad6f7
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c  |  7 +++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h  |  9 ++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     | 16 ++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c     |  4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h   |  2 ++
 drivers/gpu/drm/amd/amdkfd/kfd_device.c     |  7 ++++---
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c |  7 ++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h |  5 ++++-
 include/uapi/linux/kfd_ioctl.h              | 15 ++++++++-------
 10 files changed, 56 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index e3738d417245..f1c6dc939cc3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -133,6 +133,9 @@ static void amdgpu_amdkfd_reset_work(struct work_struct *work)
 
 	reset_context.method = AMD_RESET_METHOD_NONE;
 	reset_context.reset_req_dev = adev;
+	reset_context.reset_ring_hang = true;
+	strscpy(reset_context.reset_cause, "hws_hang", sizeof(reset_context.reset_cause));
+	DRM_ERROR("Reset cause: %s\n", reset_context.reset_cause);
 	clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
 
 	amdgpu_device_gpu_recover(adev, NULL, &reset_context);
@@ -261,12 +264,12 @@ int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool run_pm)
 	return r;
 }
 
-int amdgpu_amdkfd_pre_reset(struct amdgpu_device *adev)
+int amdgpu_amdkfd_pre_reset(struct amdgpu_device *adev, struct amdgpu_reset_context *reset_context)
 {
 	int r = 0;
 
 	if (adev->kfd.dev)
-		r = kgd2kfd_pre_reset(adev->kfd.dev);
+		r = kgd2kfd_pre_reset(adev->kfd.dev, reset_context);
 
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 1de021ebdd46..c9030d8b8308 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -47,6 +47,7 @@ enum TLB_FLUSH_TYPE {
 };
 
 struct amdgpu_device;
+struct amdgpu_reset_context;
 
 enum kfd_mem_attachment_type {
 	KFD_MEM_ATT_SHARED,	/* Share kgd_mem->bo or another attachment's */
@@ -170,7 +171,8 @@ bool amdgpu_amdkfd_have_atomics_support(struct amdgpu_device *adev);
 
 bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32 vmid);
 
-int amdgpu_amdkfd_pre_reset(struct amdgpu_device *adev);
+int amdgpu_amdkfd_pre_reset(struct amdgpu_device *adev,
+			    struct amdgpu_reset_context *reset_context);
 
 int amdgpu_amdkfd_post_reset(struct amdgpu_device *adev);
 
@@ -416,7 +418,8 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 void kgd2kfd_device_exit(struct kfd_dev *kfd);
 void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm);
 int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm);
-int kgd2kfd_pre_reset(struct kfd_dev *kfd);
+int kgd2kfd_pre_reset(struct kfd_dev *kfd,
+		      struct amdgpu_reset_context *reset_context);
 int kgd2kfd_post_reset(struct kfd_dev *kfd);
 void kgd2kfd_interrupt(struct kfd_dev *kfd, const void *ih_ring_entry);
 void kgd2kfd_set_sram_ecc_flag(struct kfd_dev *kfd);
@@ -459,7 +462,7 @@ static inline int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
 	return 0;
 }
 
-static inline int kgd2kfd_pre_reset(struct kfd_dev *kfd)
+static inline int kgd2kfd_pre_reset(struct kfd_dev *kfd, struct amdgpu_reset_context *reset_context)
 {
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 00fe3c2d5431..b18f37426b5e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5772,7 +5772,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 
 		cancel_delayed_work_sync(&tmp_adev->delayed_init_work);
 
-		amdgpu_amdkfd_pre_reset(tmp_adev);
+		amdgpu_amdkfd_pre_reset(tmp_adev, reset_context);
 
 		/*
 		 * Mark these ASICs to be reseted as untracked first
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index e4742b65032d..c3e32f21aa49 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -77,6 +77,22 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 
 		reset_context.method = AMD_RESET_METHOD_NONE;
 		reset_context.reset_req_dev = adev;
+		reset_context.reset_ring_hang = true;
+		if (ring->name) {
+			/* Ensure buffer length of 64 is not exceeded during copy of ring->name  */
+			size_t name_length;
+
+			for (name_length = 0; name_length < sizeof(reset_context.reset_cause) - 6 &&
+			     ring->name[name_length] != '\0'; name_length++) {
+				reset_context.reset_cause[name_length] = ring->name[name_length];
+			}
+			strscpy(reset_context.reset_cause + name_length, "_hang",
+				sizeof(reset_context.reset_cause) - name_length);
+		} else {
+			strscpy(reset_context.reset_cause, "unknown_hang",
+				sizeof(reset_context.reset_cause));
+		}
+		DRM_ERROR("Reset cause: %s\n", reset_context.reset_cause);
 		clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
 
 		r = amdgpu_device_gpu_recover(ring->adev, job, &reset_context);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 1dd13ed3b7b5..e2d65c5c17c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2479,6 +2479,10 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
 		reset_context.method = AMD_RESET_METHOD_NONE;
 		reset_context.reset_req_dev = adev;
 
+		reset_context.reset_ring_hang = true;
+		strscpy(reset_context.reset_cause, "ras_hang", sizeof(reset_context.reset_cause));
+		DRM_ERROR("Reset cause: %s\n", reset_context.reset_cause);
+
 		/* Perform full reset in fatal error mode */
 		if (!amdgpu_ras_is_poison_mode_supported(ras->adev))
 			set_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
index 5a9cc043b858..757284ab36e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
@@ -43,6 +43,8 @@ struct amdgpu_reset_context {
 	struct amdgpu_hive_info *hive;
 	struct list_head *reset_device_list;
 	unsigned long flags;
+	bool reset_ring_hang;
+	char reset_cause[64];
 };
 
 struct amdgpu_reset_handler {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 6b15e55811b6..88171f24496b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -35,6 +35,7 @@
 #include "kfd_migrate.h"
 #include "amdgpu.h"
 #include "amdgpu_xcp.h"
+#include "amdgpu_reset.h"
 
 #define MQD_SIZE_ALIGNED 768
 
@@ -931,7 +932,7 @@ void kgd2kfd_device_exit(struct kfd_dev *kfd)
 	kfree(kfd);
 }
 
-int kgd2kfd_pre_reset(struct kfd_dev *kfd)
+int kgd2kfd_pre_reset(struct kfd_dev *kfd, struct amdgpu_reset_context *reset_context)
 {
 	struct kfd_node *node;
 	int i;
@@ -941,7 +942,7 @@ int kgd2kfd_pre_reset(struct kfd_dev *kfd)
 
 	for (i = 0; i < kfd->num_nodes; i++) {
 		node = kfd->nodes[i];
-		kfd_smi_event_update_gpu_reset(node, false);
+		kfd_smi_event_update_gpu_reset(node, false, reset_context);
 		node->dqm->ops.pre_reset(node->dqm);
 	}
 
@@ -981,7 +982,7 @@ int kgd2kfd_post_reset(struct kfd_dev *kfd)
 	for (i = 0; i < kfd->num_nodes; i++) {
 		node = kfd->nodes[i];
 		atomic_set(&node->sram_ecc_flag, 0);
-		kfd_smi_event_update_gpu_reset(node, true);
+		kfd_smi_event_update_gpu_reset(node, true, NULL);
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
index 06ac835190f9..3ffe4b61fe4f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -29,6 +29,7 @@
 #include "amdgpu_vm.h"
 #include "kfd_priv.h"
 #include "kfd_smi_events.h"
+#include "amdgpu_reset.h"
 
 struct kfd_smi_client {
 	struct list_head list;
@@ -215,7 +216,8 @@ static void kfd_smi_event_add(pid_t pid, struct kfd_node *dev,
 	add_event_to_kfifo(pid, dev, event, fifo_in, len);
 }
 
-void kfd_smi_event_update_gpu_reset(struct kfd_node *dev, bool post_reset)
+void kfd_smi_event_update_gpu_reset(struct kfd_node *dev, bool post_reset,
+				    struct amdgpu_reset_context *reset_context)
 {
 	unsigned int event;
 
@@ -224,6 +226,9 @@ void kfd_smi_event_update_gpu_reset(struct kfd_node *dev, bool post_reset)
 	} else {
 		event = KFD_SMI_EVENT_GPU_PRE_RESET;
 		++(dev->reset_seq_num);
+		if (reset_context && reset_context->reset_ring_hang)
+			kfd_smi_event_add(0, dev, KFD_SMI_EVENT_RING_HANG, "%s\n",
+					  reset_context->reset_cause);
 	}
 	kfd_smi_event_add(0, dev, event, "%x\n", dev->reset_seq_num);
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
index fa95c2dfd587..85010b8307f8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
@@ -24,11 +24,14 @@
 #ifndef KFD_SMI_EVENTS_H_INCLUDED
 #define KFD_SMI_EVENTS_H_INCLUDED
 
+struct amdgpu_reset_context;
+
 int kfd_smi_event_open(struct kfd_node *dev, uint32_t *fd);
 void kfd_smi_event_update_vmfault(struct kfd_node *dev, uint16_t pasid);
 void kfd_smi_event_update_thermal_throttling(struct kfd_node *dev,
 					     uint64_t throttle_bitmask);
-void kfd_smi_event_update_gpu_reset(struct kfd_node *dev, bool post_reset);
+void kfd_smi_event_update_gpu_reset(struct kfd_node *dev, bool post_reset,
+				    struct amdgpu_reset_context *reset_context);
 void kfd_smi_event_page_fault_start(struct kfd_node *node, pid_t pid,
 				    unsigned long address, bool write_fault,
 				    ktime_t ts);
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index 285a36601dc9..7c94d2c7da13 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -519,13 +519,14 @@ enum kfd_smi_event {
 	KFD_SMI_EVENT_THERMAL_THROTTLE = 2,
 	KFD_SMI_EVENT_GPU_PRE_RESET = 3,
 	KFD_SMI_EVENT_GPU_POST_RESET = 4,
-	KFD_SMI_EVENT_MIGRATE_START = 5,
-	KFD_SMI_EVENT_MIGRATE_END = 6,
-	KFD_SMI_EVENT_PAGE_FAULT_START = 7,
-	KFD_SMI_EVENT_PAGE_FAULT_END = 8,
-	KFD_SMI_EVENT_QUEUE_EVICTION = 9,
-	KFD_SMI_EVENT_QUEUE_RESTORE = 10,
-	KFD_SMI_EVENT_UNMAP_FROM_GPU = 11,
+	KFD_SMI_EVENT_RING_HANG = 5,
+	KFD_SMI_EVENT_MIGRATE_START = 6,
+	KFD_SMI_EVENT_MIGRATE_END = 7,
+	KFD_SMI_EVENT_PAGE_FAULT_START = 8,
+	KFD_SMI_EVENT_PAGE_FAULT_END = 9,
+	KFD_SMI_EVENT_QUEUE_EVICTION = 10,
+	KFD_SMI_EVENT_QUEUE_RESTORE = 11,
+	KFD_SMI_EVENT_UNMAP_FROM_GPU = 12,
 
 	/*
 	 * max event number, as a flag bit to get events from all processes,
-- 
2.25.1

