Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8365C5AE5D
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Feb 2026 19:23:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78AC510E834;
	Fri, 20 Feb 2026 19:23:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bjiEax3/";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012057.outbound.protection.outlook.com [40.107.209.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9875010E832
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Feb 2026 19:23:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DWjfMjCz+T9LXWzzX928AB1BG9XTdq3KFnJaxT0AMnlZMfmNM9eCX5CrRR5M32gTQ6RkbOVxHBSfUII7mo/2d/sJFdAoNBBch9lNPzbkN15Bd11mE4UFHhJc24L0iB2iE+8kZfb3qB8EkG2QHLwJVzsWGOiURlxTtoEhSfm4u1TFYNqhvhjMt8ERypmj/iVdNoYHAV3Pg21BMIHuUPPrLPFTuJbRKqKEu/ZDeHJqQVMWn6QFk25jWbNoQRnOV3ogJPqCXuyb1/Q/b16KrkBvBEQOvDXpei8bw4qCgmASOTp4FiDcvEUfZQNZs41Dlh0YUKXwHp//3dUypzzIH+QNaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V5uUzzlh0TYiy7zw4HyFhGkd3xoeidFhWsrIFo4yZeI=;
 b=vr4nPk7j9kbK9t66i+PdP6nGC5h4i7zetBBb2F4yNoUTadHdA6TTqgaxHMZOUhbdvAG7CGgR9ic/afOQEmkgBsPqQ8ILYNuOIQVV6azDxAFs81napRNpJZhWNLZLj0hoLhJHlG5ZVPzwmZv4L44YnleQvqHMomjgTQxSKoqc7eJYcoYgLamtCxxpqOc8NCYKpQx91mfChHZWB5kdTnEPlZsG0pYXHFgxwp0RPO+niiXJdnMhBQXi/HljJBptNI48i8+9WCEbMb7ig1JXoWTYod6uDrpDaaSgUuT1u6vZmdI5f5Dbx+r64cPg+EiHhpODwtJ7CuBgf2mZN0FdV3IL+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V5uUzzlh0TYiy7zw4HyFhGkd3xoeidFhWsrIFo4yZeI=;
 b=bjiEax3/dI5Z8U9ATcqN+bpHzS/dqnf9caCCIGrvp//dHTsNjcPY2Wkpr/HF4qd6Qo4eqh9B0sohmN41Dx49cG5tXRY2nURKlOwRSkfgDC7GnmaD8d8VnBhyAZulPKmwWL/91YSLHcR4tTaWFoo4HUfz21mnJfZzmNho2SOqnYM=
Received: from PH1PEPF00013314.namprd07.prod.outlook.com (2603:10b6:518:1::6)
 by PH8PR12MB7374.namprd12.prod.outlook.com (2603:10b6:510:216::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Fri, 20 Feb
 2026 19:23:09 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2a01:111:f403:f910::2) by PH1PEPF00013314.outlook.office365.com
 (2603:1036:903:47::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.16 via Frontend Transport; Fri,
 20 Feb 2026 19:23:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Fri, 20 Feb 2026 19:23:09 +0000
Received: from work-495456.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 20 Feb
 2026 13:22:56 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>
CC: <Bing.Ma@amd.com>, <jamesz@amd.com>
Subject: [PATCH 15/17] drm/amdgu: fix hw stall issue
Date: Fri, 20 Feb 2026 14:22:34 -0500
Message-ID: <20260220192236.3121556-15-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260220192236.3121556-1-James.Zhu@amd.com>
References: <20260220192236.3121556-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|PH8PR12MB7374:EE_
X-MS-Office365-Filtering-Correlation-Id: 777cd18f-c0e6-4633-07bc-08de70b57b3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UHlRJ5HMb4XVR3ZfzYgY4RV3Ax7AohOJcb9B4izZ7H4LmQhSfoiM1z+8Vouv?=
 =?us-ascii?Q?ISJtJ1cOpL2TbLg2JbwAa3wstzcsUslTxbupNSbUAmBjn5LOHHxqcg6iFfXF?=
 =?us-ascii?Q?9xu8FtPqn0wI8vIVVHfNsrXD8t5sifuRuidhmikwzr8k6Q6mDWCWn6SLm1Qb?=
 =?us-ascii?Q?29jcKlgS+rJytE9uxSvX9T2XJgA8EaZIE84Yu48jABpNQbV+8aizCUIXjEoo?=
 =?us-ascii?Q?e5q41Z4WilXFLge5p1xb864hv10YhtBDjIWeZfn8sjqrRWexpV1ytdeiplWJ?=
 =?us-ascii?Q?lTUBZzfxAaGOdQjA2re7ma0WivfHWQ7Wf3v+/3QQY1Pnk2ptYi3Gse+AiPKN?=
 =?us-ascii?Q?3qiuPkespvSZFjMPvYKZC07ekXl+lGSzOLmDdSGOLozXNnE2OUXH1toy0zD1?=
 =?us-ascii?Q?ZUeSznugkqaUK6OYjeqo4pTEcJoLx2YIgcNxt8ZpY3Vu3py1n/bV+95kV/TV?=
 =?us-ascii?Q?+U76pVoJp3iMwznLP6kjCt6lLkpXus3trVCdLVADw4Fm1QWOAxaYdEFfyVcE?=
 =?us-ascii?Q?ZppewwhT29gXs+i2gOf8ixoLh/axGjapmAZocTbHukAE5CuD+D6u8D0NVPOe?=
 =?us-ascii?Q?RcFaAWqEqdDO17/U8ZscWxfnLxZjMUG6L6yu0IZY5MBEmpg9KTlMNX4ZPNqb?=
 =?us-ascii?Q?mf0imtTwckQthokDCO87t9FL76lIYigY++BD7p5LrqfHlwM3s/Mv/HgpPkf2?=
 =?us-ascii?Q?c3SwZjZamyYcTNWQJ2X2r06ITrg7fuLyaE3V7SPAypAQe+mlyDQkkNu7h2pk?=
 =?us-ascii?Q?RjIdr608/9xyoNAPtgt49mRCobWDloWTwEPCKgvhXocMWkJXw5NmH0D3lDs8?=
 =?us-ascii?Q?2ab7s3dUqO60JAtJZOlevKfSACZ2G1e76iL2/h4sFKNHpPeX6d5vg/a9C7S3?=
 =?us-ascii?Q?6wUx2J43mGuNVYHJIAzVZhJqhcCq3CX51iplQoY3Sl1SzAlFdKh0As/lWPOY?=
 =?us-ascii?Q?5auUhbS/7pih8Rzv8RyelBl6FKs6khRuZUyR32CgX7I4AUdy+HA+UZN0Y2xo?=
 =?us-ascii?Q?U+fLdQSVsnDFRQj8q+9CCjJYzgHqsp2zrDcagJf1uUoeXXsz322N+67qwxu2?=
 =?us-ascii?Q?m9Noge/3cN2frWYA32gC2r4QnnYBGdRxPI76ZPPFV7UhnOR0CtPnoVLBfdLF?=
 =?us-ascii?Q?F/QzlkopQc3Vr8VLhJevd/qBQJb5HZUh+YjnRylV1s2WIZyxO7/ZKqABOKZf?=
 =?us-ascii?Q?p1eLhdybGYSAQaOZRvjHRCof4TzVOXL9qapo4MLgeLvcm+D/FZXs7KAu9OrC?=
 =?us-ascii?Q?an2Ycd5pfRM3vxXGV1DlVu+iH/ZIaLRQgyzRyDM/misQ7J4xeyuac9MSfpC/?=
 =?us-ascii?Q?tFCrk/S/Zue8/SHA806JNsoO2BpRpicUDBFEqnxUN8t3xyYASjd+/RWsc4ep?=
 =?us-ascii?Q?rpopzU8A8Di52zDmYisDC2eWqm6a0F0WQXkN62mVFPyIzrGOBFYOKHJW2qGu?=
 =?us-ascii?Q?TvPr/OOVODB/je/mAi3f80rJxd15cnlTy5KFaIOK1DV/SXRSWtVuP07U9Y3s?=
 =?us-ascii?Q?UjtPKa1UZwXPe1tSthfIhnELXqLwCe3GIchqjOJr3wXTwvHIgarYYnajHFWH?=
 =?us-ascii?Q?Q7Jm821vwXp8dPCdffvITtFzBMAVteZKa0dEuqmHiKy0btiH0ZNUEm3+kbzP?=
 =?us-ascii?Q?YGcxrs3jKdkMJe0J0qQppD5RO7fVxKrSAnlb6VGF+qj+?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uug78S2YdO88SajoZQRyxm+AtjNTJzbqRDBvFZQ+AiRnSDTLa7WVXT/p9GYuPtSfDCo24Gwa4LVtDqPqWGeo+EiW/uBuwk4lWYc8ms3mH0FhYEDb7rkPAcHbygzcdovEar+Mrj4IOCX8g9DGUbm6hZQnGFJqAIkBt5yAjzTP+QCgMOnpnVOTm5GLP46XpUcwUR2mX10jIS9Av5isr/LR1hnn+glRiBYhbPqwNkByWXewMVTYAOkly63ZPdRGGj58KzaxMsb/2/oPTmOXr2MXjDuMBaO7o20/fqiAEmyQcx+caB5xGZBNPvZhKhiWLsRchLvbAwdPast0cD/XqHeFOxDAC9M35eGh3b13LzffgR5yOvA5hYryvRrsi4iLTUdeurfno2YnhA+ERy4D7Cye3hnPTphBSWiQRTir0YdGFCb8BFl/hMUkp7oJ3KYtA/oe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 19:23:09.1177 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 777cd18f-c0e6-4633-07bc-08de70b57b3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7374
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

When register RLC_SPM_PERFMON_CNTL/PERFMON_RING_MODE is set to 0x11,SPM HW
fires warning interrupt when rptr reaches RLC_SPM_SEGMENT_THRESHOLD, and
stalls when rptr reaches the end of ring buffer. But the HW bug causes
that both stall and interrupt arise when rptr reaches
RLC_SPM_SEGMENT_THRESHOLD, and this means unexpecetd data loss with early
SPM HW stall arise when interrupt received. this fix uses polling mode
instead to avoid expected SPM HW early stall.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c | 88 ++++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h |  1 +
 2 files changed, 88 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
index f09c237cc8f7..4cfb3c49b9b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
@@ -49,6 +49,7 @@ struct amdgpu_spm_base {
 	bool   has_user_buf;
 	bool   is_user_buf_filled;
 	bool   is_spm_started;
+	u32    warned_ring_rptr;
 };
 
 struct amdgpu_spm_cntr {
@@ -66,6 +67,77 @@ struct amdgpu_spm_cntr {
 static int amdgpu_spm_release(struct amdgpu_spm_mgr *spm_mgr, struct drm_file *filp);
 static void _amdgpu_spm_release(struct amdgpu_spm_mgr *spm_mgr, int inst, struct drm_file *filp);
 
+static int amdgpu_spm_monitor_thread(void *param)
+{
+	struct amdgpu_spm_mgr *spm_mgr = param;
+	struct amdgpu_device *adev = mgr_to_adev(spm_mgr, spm_mgr);
+
+	allow_signal(SIGKILL);
+	while (!kthread_should_stop() &&
+			!signal_pending(spm_mgr->spm_monitor_thread) && spm_mgr->spm_cntr) {
+		bool need_schedule = false;
+		u32 inst;
+
+		usleep_range(1, 11);
+
+		if (!mutex_trylock(&spm_mgr->spm_cntr->spm_worker_mutex))
+			continue;
+
+		for_each_inst(inst, AMDGPU_XCC_MASK(adev)) {
+			struct amdgpu_spm_base *spm = &(spm_mgr->spm_cntr->spm[inst]);
+			u32 warned_ring_rptr;
+			u32 ring_size;
+			u32 ring_rptr;
+			u32 ring_wptr;
+
+			if (!spm->is_spm_started)
+				continue;
+
+			ring_size = spm->ring_size;
+			ring_rptr = spm->ring_rptr;
+			warned_ring_rptr = spm->warned_ring_rptr;
+			ring_wptr = READ_ONCE(spm->cpu_addr[0]);
+
+			if (need_schedule || (ring_rptr != warned_ring_rptr &&
+				(ring_size + ring_wptr - ring_rptr) % ring_size >
+					(ring_size >> 1))) {
+				spm->warned_ring_rptr = ring_rptr;
+				if (!need_schedule) {
+					dev_dbg(adev->dev,
+						"[SPM#%d] soft interrupt rptr:0x%08x--wptr:0x%08x",
+						 inst, ring_rptr, ring_wptr);
+					need_schedule = true;
+				}
+			}
+		}
+		mutex_unlock(&spm_mgr->spm_cntr->spm_worker_mutex);
+		if (need_schedule)
+			schedule_work(&spm_mgr->spm_work);
+	}
+	spm_mgr->spm_monitor_thread = NULL;
+	return 0;
+}
+
+static int amdgpu_spm_monitor_thread_start(struct amdgpu_spm_mgr *spm_mgr)
+{
+	struct amdgpu_device *adev = mgr_to_adev(spm_mgr, spm_mgr);
+	char thread_name[16];
+	int ret = 0;
+
+	snprintf(thread_name, 16, "spm_%d", adev->ddev.render->index);
+	spm_mgr->spm_monitor_thread =
+		kthread_run(amdgpu_spm_monitor_thread, spm_mgr, thread_name);
+
+	if (IS_ERR(spm_mgr->spm_monitor_thread)) {
+		ret = PTR_ERR(spm_mgr->spm_monitor_thread);
+		spm_mgr->spm_monitor_thread = NULL;
+		dev_dbg(adev->dev, "Failed to create spm monitor thread %s with ret = %d.",
+			thread_name, ret);
+	}
+
+	return ret;
+}
+
 static void amdgpu_spm_preset(struct amdgpu_spm_base *spm, u32 size)
 {
 	uint64_t *overflow_ptr, *overflow_end_ptr;
@@ -152,6 +224,7 @@ static int amdgpu_spm_read_ring_buffer(struct amdgpu_spm_mgr *spm_mgr, int inst)
 	if (spm->ring_rptr == ring_wptr)
 		goto exit;
 
+	spm->warned_ring_rptr = spm->ring_rptr;
 	if (ring_wptr > spm->ring_rptr) {
 		size_to_copy = ring_wptr - spm->ring_rptr;
 		ret = amdgpu_spm_data_copy(spm_mgr, size_to_copy, inst);
@@ -277,6 +350,7 @@ static int _amdgpu_spm_acquire(struct amdgpu_spm_mgr *spm_mgr, int inst, struct
 		goto rlc_spm_acquire_failure;
 
 	amdgpu_spm_preset(spm, spm_mgr->spm_overflow_reserved);
+	spm->warned_ring_rptr = ~0;
 	goto out;
 
 rlc_spm_acquire_failure:
@@ -320,6 +394,7 @@ static int amdgpu_spm_acquire(struct amdgpu_spm_mgr *spm_mgr, struct drm_file *f
 	INIT_WORK(&spm_mgr->spm_work, amdgpu_spm_work);
 
 	spin_lock_init(&spm_mgr->spm_irq_lock);
+	spm_mgr->spm_monitor_thread = NULL;
 	spm_mgr->file = filp;
 
 	goto out;
@@ -366,6 +441,9 @@ static int amdgpu_spm_release(struct amdgpu_spm_mgr *spm_mgr, struct drm_file *f
 		goto out;
 	}
 
+	if (spm_mgr->spm_monitor_thread)
+		kthread_stop(spm_mgr->spm_monitor_thread);
+
 	for_each_inst(inst, AMDGPU_XCC_MASK(adev)) {
 		spin_lock_irqsave(&spm_mgr->spm_irq_lock, flags);
 		spm_mgr->spm_cntr->spm[inst].is_spm_started = false;
@@ -551,7 +629,10 @@ static int amdgpu_set_dest_buffer(struct amdgpu_spm_mgr *spm_mgr, void __user *d
 				 * wptr will become 0, adjust rptr accordingly.
 				 */
 				spm->ring_rptr = 0;
+				spm->warned_ring_rptr = ~0;
 				spin_unlock_irqrestore(&spm_mgr->spm_irq_lock, flags);
+				if (!spm_mgr->spm_monitor_thread)
+					amdgpu_spm_monitor_thread_start(spm_mgr);
 			} else {
 				/* If SPM was already started, there may already
 				 * be data in the ring-buffer that needs to be read.
@@ -567,7 +648,10 @@ static int amdgpu_set_dest_buffer(struct amdgpu_spm_mgr *spm_mgr, void __user *d
 			 * Adjust rptr accordingly
 			 */
 			spm->ring_rptr = 0;
+			spm->warned_ring_rptr = ~0;
 			spin_unlock_irqrestore(&spm_mgr->spm_irq_lock, flags);
+			if (spm_mgr->spm_monitor_thread)
+				kthread_stop(spm_mgr->spm_monitor_thread);
 		}
 	}
 
@@ -638,6 +722,8 @@ void amdgpu_spm_interrupt(struct amdgpu_device *adev, int xcc_id)
 
 	spin_lock_irqsave(&spm_mgr->spm_irq_lock, flags);
 	if (spm_mgr->spm_cntr && spm_mgr->spm_cntr->spm[xcc_id].is_spm_started)
-		schedule_work(&spm_mgr->spm_work);
+		spm_mgr->spm_cntr->spm[xcc_id].has_data_loss = true;
 	spin_unlock_irqrestore(&spm_mgr->spm_irq_lock, flags);
+
+	dev_dbg(adev->dev, "[SPM#%d:%d] ring buffer stall.", xcp_id, xcc_id);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h
index f3d812fa4e2b..aca627b6c2de 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h
@@ -24,6 +24,7 @@
 #define AMDGPU_SPM_H_
 
 struct amdgpu_spm_mgr {
+	struct task_struct *spm_monitor_thread;
 	struct drm_file *file;
 
 	struct task_struct *lead_thread;
-- 
2.34.1

