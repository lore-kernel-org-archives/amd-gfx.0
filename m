Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F300CEF06EA
	for <amd-gfx@archiver.kernel.org>; Sun,  8 Feb 2026 16:43:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 808CE10E308;
	Sun,  8 Feb 2026 16:43:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LgRc0zfp";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012062.outbound.protection.outlook.com
 [40.107.200.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC51310E301
 for <amd-gfx@lists.freedesktop.org>; Sun,  8 Feb 2026 16:43:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iIkAyF7rDcYsqY60LczUEmEuukubznWyGNZVjZ+lH7ldjUjsJqdpDS2mBEnykKzrvHkx+UObWNI9K2f25AP3qB7aV5n7FlB8YBPXNM+Kj0nUrq1J6SOD7DXh1ZEAkrg0R5KqiR+Fsh8dWb+1ebQ492oa8RtThC2Fj2QWuAqYu6RL852l5qu9ARGAKlujQi73SG7q/RDYAwRqU2WTL7C/mTjRIZhyY2rj74FagpXsUdNW/yBSK0yLxMfRsaThaZevKakfhBfQYr+kZHpprAKF/D6ybAfQYvxgvUzW1LZHDWtzeLsUyUTIvQm6mC1noNGLvQ1Yk5q4Xn1Ea4cbXBMYNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+jA3Ju7JY1OjkSIdDSUIi2V+6cLXpydnYMIz8wLrjTk=;
 b=gXPlFVcJoWQvnKi/MQZ3Td6GMq10TC/982zKGf6RStw1FUbm1WtR2qMpSZNWHU2BIBIjfwag7dPnA8a7kx1DggOGuHTwsfUwX4fstMuGAnouCkQ58ZCQPIo+cIPQ20bBj69lMZQVy4PEv/XYBiehSoQuB5NAEPMl1IEIoh6DnKpwAaqNZs/g5s7dixPU1ntpdYwUcka5aksVuqHqwrpbqFui5VblPWI9yNgBUT8zsWYArlfVi+m6XPQnYMGpXCLGw4rDUQMELpORJ+CG0oJ9incgUh843A6lRxtxnVlqeyn/8oK6PUGIrx+oFXcPXBdpTD5VAYnUKes7SiX2ITTr9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+jA3Ju7JY1OjkSIdDSUIi2V+6cLXpydnYMIz8wLrjTk=;
 b=LgRc0zfppEyfVaYOTQ8t413aHDLx0GqKR5xPA/RYYmtJAPGJTuLDLFdnvUnVhfcdJRo9vMPNlQgCrdKusDV47503xzVxx7SSCHEeCN8OqIVnNIwUGX8TKD4PYbddjMuqDyeK32BCTKuoeQCemCP84f38mG/0bEDhdkX7zgz7dkY=
Received: from SJ0PR05CA0171.namprd05.prod.outlook.com (2603:10b6:a03:339::26)
 by DS0PR12MB7874.namprd12.prod.outlook.com (2603:10b6:8:141::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Sun, 8 Feb
 2026 16:43:45 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:a03:339:cafe::f3) by SJ0PR05CA0171.outlook.office365.com
 (2603:10b6:a03:339::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.5 via Frontend Transport; Sun, 8
 Feb 2026 16:43:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Sun, 8 Feb 2026 16:43:44 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 8 Feb 2026 10:43:43 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>
CC: <Yifan1.Zhang@amd.com>
Subject: [PATCH v2 08/13] drm/amdkfd: Add PTL control IOCTL Option and unify
 refcount logic
Date: Mon, 9 Feb 2026 00:42:07 +0800
Message-ID: <34cfa8a1dd439c0ece64416c17bd5b07715bddcf.1770568163.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1770568163.git.perry.yuan@amd.com>
References: <cover.1770568163.git.perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|DS0PR12MB7874:EE_
X-MS-Office365-Filtering-Correlation-Id: e35519de-d534-478a-c44b-08de67313991
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JhAHp1eQHS2GfDf2L6GJ/R6LqfXLE/hs5Q4FTuPWduvVHZsFX+JC0plnDyZM?=
 =?us-ascii?Q?aqS40t84vczu0iMy6fPSLqkRPvuwfyf+a63hIQaEUolDcw9jNoLqRSQE47IX?=
 =?us-ascii?Q?mfdqGuW7tFChbjT1OsWD4+2J1TOnDAKRvy//JrvW5kX9VxZ94I8hTKDLK2sP?=
 =?us-ascii?Q?rybStcKA1JNgmUJImuMRI8SukE+TBB92i2ksG4XXkhzF5W9IsR8IGtbrrfrX?=
 =?us-ascii?Q?sSyAdMT3WwDuBjq5DyC+RbDK3c4EhkE1HRbv3Df1/3E5b7EF2GVSKGrKXU+v?=
 =?us-ascii?Q?xkAc6qpq+9i/HLTxmr8M5SGw7E9jg/YlhtZrMp8zYiwiTWMaOi9F/I/br3LH?=
 =?us-ascii?Q?GPNd2UvJynISZTT1kCF0NcwPGCVUA85++1HV1KR+NRc1UwXzWN6PP13QkcAA?=
 =?us-ascii?Q?1LpXx2XROgNwZdoK8sJhRZ3k/qYz09V7A0rGGB+/TLY3vbPUGfq2t/F/e24f?=
 =?us-ascii?Q?UYGtt1irH/6HZop8CAv9LaMFiRjBRWSaV/4N+Y2iLsfZEG/Qlm2EEAgLCpKe?=
 =?us-ascii?Q?wJSHngDx5sluqHiporfYwDOQ2+n9joaVmhONjHlDEOT0FL5k9pZjdZ8Nbcqe?=
 =?us-ascii?Q?4+ztuBG2yq2djczfCaV686tP7JE9PEbDt4OOKF/er/tR118GO18kw+x74qdq?=
 =?us-ascii?Q?Rb5aAOhnAJZjAvkIwpthrm6wDo9eDkA4pBqpX+2IbkUg2MRhLzFARBU9lZtK?=
 =?us-ascii?Q?Hqeh7iieUkmn29so9/79k5NDThmxcLeESfgvUV0DYv5E7qMUaVst2RGq5qAv?=
 =?us-ascii?Q?LRNGj9QfyWWwkKe7JH8GHbxOf6caidbT5GjMEfTJSTHtOWGgz4cQCfo8cpc+?=
 =?us-ascii?Q?mL6yIki0n5Q94Xp5GmPtPuIQl+dHwMKEML0DjzVWREWdHXD+2phXhFuQ54EF?=
 =?us-ascii?Q?nnnfVT/J237Rohr5xkPJFAqnwJI2u0QCektMCxUoj2DZPYELp1KeH8IEGJc8?=
 =?us-ascii?Q?2hjsPJIB6kQvwcCk+FyOHsiGOZhFe/8pnUqLqQutfY+a3JQplkC8HdX8w4T3?=
 =?us-ascii?Q?jrmvrcvOlNF+v5K0oOMvDBQ7sWP0BG9GL6tYaghKMbgEetki46ovEmV5PV2x?=
 =?us-ascii?Q?KqJPHk4qCZ3MKZ/vmVrWD1FqSboTMNRvObFlCiJU/GV4lw63efzdKmxWAk46?=
 =?us-ascii?Q?7e9FEX7t6jAO7O+qV4DAnVxAiX0XYGEPSu1/ETZ4RMu6q2ivK6icwktb6wTt?=
 =?us-ascii?Q?IjQDP8zBPMfs7aSsmhlKfyDy167cOuRIZortluap3BiHQspgG/HmIxdCZXJD?=
 =?us-ascii?Q?OPL0zTU+kTuEHw+7buHS5RRlNgosTQ2my0a+e+97zcdFAx1VLfwA+LbjRDMC?=
 =?us-ascii?Q?1gV1gYEUnHdovROV/ftP7+pjs9du5ehZfwkOo9qQjK1m2erSVqrX5IMz+4eX?=
 =?us-ascii?Q?eBNU79j2pgOjnggMLrWU2PeL3B88WumNGZxm8nXs1wlMJvOHZFr9bApOinlf?=
 =?us-ascii?Q?Ifzvj4RZsnXcZH534tzPjPWwl4KKDWXYaeMk5WU9P3xCuoY9gyiD0vN9EWff?=
 =?us-ascii?Q?7i6MWGLK556fp+vGr6spODuOBTcx8RqOHqoc5OSbREgrWDjvQe5oGkNJ/7eV?=
 =?us-ascii?Q?dxG/L11j9O3I2Gc/UQ3ZmARxzRtUeUkJrgmK2G6yqCWtRH3v2K9fShxWXlg4?=
 =?us-ascii?Q?o2eB0ILmmW+cxG6cgxQu9/3cI7uvQKiGJa1IbNgS3Q54TvfgnvL9NxSZQASV?=
 =?us-ascii?Q?cuBlSQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uz7vqoC3ghdk2gq//8RZ7+aLqrYoTbWb+6Iy5DBV29KsSGcpzV91HEyJtD2J74okimboqcFjOV+IDyU6k5gUma45qG6dGwxM8xeFVFAugKvLcIKnktp3IdXY1i7TnHDT64KNeEbLj/xJ9YLvK1hzG5LxrLFgJrfUfnyeBiu/fojs+hRsYca81bkC9xt9emRYee1UcDbR0Y0lFGeGhzPa5XihJdlkxiBA44jNmn6r6g5KdKaiukZa8uXhTkBTycvrm10yKpVvjRj0a1FOr0U8tqd4eXFWp8KBVSJVJDqa5L3W8Erl9CPw5nnKZErCNOSVMNxjlZDSYTWiEAUPIMFrsDTarcDv9h0CW9rnDmAH0Raf6uVLYNZhzDiHCNF2KJGsWXib9ww0Lh63+pVeItm8KYzEVejbvIRoVOWd7jYAZ47R4MJTwvwRg0i8h0ohuGuw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 16:43:44.8781 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e35519de-d534-478a-c44b-08de67313991
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7874
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

Introduce a new IOCTL option to allow userspace explicit control over
the Peak Tops Limiter (PTL) state for profiling

Link: https://github.com/ROCm/rocm-systems/tree/develop/projects/rocprofiler-sdk
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c  |   2 +
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 102 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |   9 ++
 drivers/gpu/drm/amd/amdkfd/kfd_process.c |   4 +
 drivers/gpu/drm/amd/include/amdgpu_ptl.h |   2 +
 include/uapi/linux/kfd_ioctl.h           |   7 ++
 6 files changed, 126 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index aa9307d88fde..4e04eba9879a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -2396,6 +2396,8 @@ static int gfx_v9_4_3_perf_monitor_ptl_init(struct amdgpu_device *adev, bool ena
 
 	ptl->hw_supported = true;
 
+	atomic_set(&ptl->disable_ref, 0);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 9c37e8248540..9a23621542fa 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1765,6 +1765,104 @@ static int kfd_ioctl_svm(struct file *filep, struct kfd_process *p, void *data)
 }
 #endif
 
+static int kfd_ptl_control(struct kfd_process_device *pdd, bool enable)
+{
+	struct amdgpu_device *adev = pdd->dev->adev;
+	struct amdgpu_ptl *ptl = &adev->psp.ptl;
+	enum amdgpu_ptl_fmt pref_format1 = ptl->fmt1;
+	enum amdgpu_ptl_fmt pref_format2 = ptl->fmt2;
+	uint32_t ptl_state = enable ? 1 : 0;
+	int ret;
+
+	if (!ptl->hw_supported)
+		return -EOPNOTSUPP;
+
+	if (!pdd->dev->kfd2kgd || !pdd->dev->kfd2kgd->ptl_ctrl)
+		return -EOPNOTSUPP;
+
+	ret = pdd->dev->kfd2kgd->ptl_ctrl(adev, PSP_PTL_PERF_MON_SET,
+					  &ptl_state,
+					  &pref_format1,
+					  &pref_format2);
+	return ret;
+}
+
+int kfd_ptl_disable_request(struct kfd_process_device *pdd,
+		struct kfd_process *p)
+{
+	struct amdgpu_device *adev = pdd->dev->adev;
+	struct amdgpu_ptl *ptl = &adev->psp.ptl;
+	int ret = 0;
+
+	mutex_lock(&ptl->mutex);
+
+	if (pdd->ptl_disable_req)
+		goto out;
+
+	if (atomic_inc_return(&ptl->disable_ref) == 1) {
+		ret = kfd_ptl_control(pdd, false);
+		if (ret) {
+			atomic_dec(&ptl->disable_ref);
+			dev_warn(pdd->dev->adev->dev,
+					"failed to disable PTL\n");
+			goto out;
+		}
+	}
+	pdd->ptl_disable_req = true;
+
+out:
+	mutex_unlock(&ptl->mutex);
+	return ret;
+}
+
+int kfd_ptl_disable_release(struct kfd_process_device *pdd,
+		struct kfd_process *p)
+{
+	struct amdgpu_device *adev = pdd->dev->adev;
+	struct amdgpu_ptl *ptl = &adev->psp.ptl;
+	int ret = 0;
+
+	mutex_lock(&ptl->mutex);
+
+	if (!pdd->ptl_disable_req)
+		goto out;
+
+	if (atomic_dec_return(&ptl->disable_ref) == 0) {
+		ret = kfd_ptl_control(pdd, true);
+		if (ret) {
+			atomic_inc(&ptl->disable_ref);
+			dev_warn(adev->dev, "Failed to enable PTL on release: %d\n", ret);
+			goto out;
+		}
+	}
+	pdd->ptl_disable_req = false;
+
+out:
+	mutex_unlock(&ptl->mutex);
+	return ret;
+}
+
+static int kfd_profiler_ptl_control(struct kfd_process *p,
+		struct kfd_ioctl_ptl_control *args)
+{
+	struct kfd_process_device *pdd;
+	int ret;
+
+	mutex_lock(&p->mutex);
+	pdd = kfd_process_device_data_by_id(p, args->gpu_id);
+	mutex_unlock(&p->mutex);
+
+	if (!pdd || !pdd->dev || !pdd->dev->kfd)
+		return -EINVAL;
+
+	if (args->enable == 0)
+		ret = kfd_ptl_disable_request(pdd, p);
+	else
+		ret = kfd_ptl_disable_release(pdd, p);
+
+	return ret;
+}
+
 static int criu_checkpoint_process(struct kfd_process *p,
 			     uint8_t __user *user_priv_data,
 			     uint64_t *priv_offset)
@@ -3230,6 +3328,7 @@ static inline uint32_t profile_lock_device(struct kfd_process *p,
 		if (!kfd->profiler_process) {
 			kfd->profiler_process = p;
 			status = 0;
+			kfd_ptl_disable_request(pdd, p);
 		} else if (kfd->profiler_process == p) {
 			status = -EALREADY;
 		} else {
@@ -3238,6 +3337,7 @@ static inline uint32_t profile_lock_device(struct kfd_process *p,
 	} else if (op == 0 && kfd->profiler_process == p) {
 		kfd->profiler_process = NULL;
 		status = 0;
+		kfd_ptl_disable_release(pdd, p);
 	}
 	mutex_unlock(&kfd->profiler_lock);
 
@@ -3280,6 +3380,8 @@ static int kfd_ioctl_profiler(struct file *filep, struct kfd_process *p, void *d
 		return 0;
 	case KFD_IOC_PROFILER_PMC:
 		return kfd_profiler_pmc(p, &args->pmc);
+	case KFD_IOC_PROFILER_PTL_CONTROL:
+		return kfd_profiler_ptl_control(p, &args->ptl);
 	}
 	return -EINVAL;
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 8983065645fa..48347065b9cd 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -872,6 +872,8 @@ struct kfd_process_device {
 	bool has_reset_queue;
 
 	u32 pasid;
+	/* Indicates this process has requested PTL stay disabled */
+	bool ptl_disable_req;
 };
 
 #define qpd_to_pdd(x) container_of(x, struct kfd_process_device, qpd)
@@ -1607,6 +1609,13 @@ static inline bool kfd_is_first_node(struct kfd_node *node)
 	return (node == node->kfd->nodes[0]);
 }
 
+/* PTL support */
+int kfd_ptl_control(struct kfd_process_device *pdd, bool enable);
+int kfd_ptl_disable_request(struct kfd_process_device *pdd,
+		struct kfd_process *p);
+int kfd_ptl_disable_release(struct kfd_process_device *pdd,
+		struct kfd_process *p);
+
 /* Debugfs */
 #if defined(CONFIG_DEBUG_FS)
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index deca19b478d0..882080dc4925 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1132,6 +1132,10 @@ static void kfd_process_destroy_pdds(struct kfd_process *p)
 		pr_debug("Releasing pdd (topology id %d, for pid %d)\n",
 			pdd->dev->id, p->lead_thread->pid);
 		kfd_process_profiler_release(p, pdd);
+
+		if (pdd->ptl_disable_req)
+			kfd_ptl_disable_release(pdd, p);
+
 		kfd_process_device_destroy_cwsr_dgpu(pdd);
 		kfd_process_device_destroy_ib_mem(pdd);
 
diff --git a/drivers/gpu/drm/amd/include/amdgpu_ptl.h b/drivers/gpu/drm/amd/include/amdgpu_ptl.h
index e5ea1084bb09..f944ab45d1ea 100644
--- a/drivers/gpu/drm/amd/include/amdgpu_ptl.h
+++ b/drivers/gpu/drm/amd/include/amdgpu_ptl.h
@@ -39,6 +39,8 @@ struct amdgpu_ptl {
 	enum amdgpu_ptl_fmt		fmt2;
 	bool				enabled;
 	bool				hw_supported;
+	/* PTL disable reference counting */
+	atomic_t			disable_ref;
 	struct mutex			mutex;
 };
 
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index a8b2a18d07cf..da93daa3283c 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -1562,6 +1562,7 @@ struct kfd_ioctl_dbg_trap_args {
 enum kfd_profiler_ops {
 	KFD_IOC_PROFILER_PMC = 0,
 	KFD_IOC_PROFILER_VERSION = 2,
+	KFD_IOC_PROFILER_PTL_CONTROL = 3,
 };
 
 /**
@@ -1573,10 +1574,16 @@ struct kfd_ioctl_pmc_settings {
 	__u32 perfcount_enable;   /* Force Perfcount Enable for queues on GPU */
 };
 
+struct kfd_ioctl_ptl_control {
+	__u32 gpu_id; /* user_gpu_id */
+	__u32 enable; /* set 1 to enable PTL, set 0 to disable PTL */
+};
+
 struct kfd_ioctl_profiler_args {
 	__u32 op;						/* kfd_profiler_op */
 	union {
 		struct kfd_ioctl_pmc_settings  pmc;
+		struct kfd_ioctl_ptl_control   ptl;
 		__u32 version;				/* KFD_IOC_PROFILER_VERSION_NUM */
 	};
 };
-- 
2.34.1

