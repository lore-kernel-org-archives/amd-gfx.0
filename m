Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 573A2C5321D
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Aug 2024 09:53:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F414B10E23A;
	Mon, 19 Aug 2024 09:53:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lkzkZrHk";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2064.outbound.protection.outlook.com [40.107.96.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A37B10E23A
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Aug 2024 09:53:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PB8WXtih0tLbW6rZd2zPu6JrFCI8vDBj3xFm+h0qleBtErbXad752uKnQApQKFFBtvUCl/bb1qq2lj+dDkVhRvE7lUAB1BU32Ppi3blArBDBqHf0S7SK45MIq8Pz+pCCaba/rxWfY9/mSk/mPcfsqVeFG8jT8NRGBoniL+TeLBrdtrlwmZ7Sz/A+Yy3jhHNHWIzuQhsdjVBLvZNk6ZFX2YqeXfbmbOfidAKEI5UL52yO+Cox3Ol9fWrav/xLT76v8ug1LmOeFcUtKGiY2FljbsnjB/MBPz5h18gJWJD0dblKlAu73l+zCXMktVho9qnbRv4s8SebiVbvr0pQNJxloA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KaaW9wvIoC8CRqpdOc3MM9ZQR72jaDflLD0/h/GMHpE=;
 b=qm7qs91a5RVsfNcopraZ30cx9iCAchaNcmlQmjLY1TCofnlKunZY5tGlkAZYyoIUm56OhqG66nS5gw47D+xiSHccYBD/mFbw4jzC26xxukf4dLSwRpSA+K/lC3kTCLIbkwFOylUB8sEXU+x03H1DqNYebFAdRPjvsfrBi9miF0d46D4eu3B19Vx+cEBJWqdzpmVSp/CMZLVW5aq3iybTwlsrDwfj7Uzrau02OIJsSiu0GKBnzZ6auQuqoDzCNwRODy8Gtiz/X6NPg/bJYipC8dAnCV+/xgjDfxzRzbefApqrQgaKl+9821opc741PnmCvkYbKTWL81gjp1MX0Lzqdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KaaW9wvIoC8CRqpdOc3MM9ZQR72jaDflLD0/h/GMHpE=;
 b=lkzkZrHkjSrPe4tOUJHcKp4AomvvUI4q0Xq1JYZs6gzFPKVOxeXu3of/s3HJOEQb1ECR+soVEqQD5aQYAm29KWICn/fK/FjZDsGH7LyA7p2ra8vSFf87wt8rISjXsAPOb9LCzFZYakx+5TNNT/IQ4SvcAl8L4XsWpFipERqL4UM=
Received: from DS7PR07CA0018.namprd07.prod.outlook.com (2603:10b6:5:3af::27)
 by DS0PR12MB8444.namprd12.prod.outlook.com (2603:10b6:8:128::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 09:53:49 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:5:3af:cafe::62) by DS7PR07CA0018.outlook.office365.com
 (2603:10b6:5:3af::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Mon, 19 Aug 2024 09:53:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Mon, 19 Aug 2024 09:53:49 +0000
Received: from lps-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 Aug 2024 04:53:47 -0500
From: <Trigger.Huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <sunil.khatri@amd.com>, <alexander.deucher@amd.com>, Trigger Huang
 <Trigger.Huang@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Do core dump immediately when job tmo
Date: Mon, 19 Aug 2024 17:53:31 +0800
Message-ID: <20240819095331.460721-3-Trigger.Huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240819095331.460721-1-Trigger.Huang@amd.com>
References: <20240819095331.460721-1-Trigger.Huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|DS0PR12MB8444:EE_
X-MS-Office365-Filtering-Correlation-Id: 31b6b108-f68d-4608-5468-08dcc034d374
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?o9Rb2ZTzX7n08ac2AC4JvkP//R1z1Y1kJ6Ly41+BlsfdjDHXdghPPW2iIQ6J?=
 =?us-ascii?Q?ajFyHBPJy93tYnwklNtckSfy5n32ozQ3sRfdFPZfrpNDbdW5uRcEr20tj/d2?=
 =?us-ascii?Q?p2jQwR2QwirxYtgJ2REGpV7y1BEYvnuV1fZGsN+RNkibddRw1hm3oxMlJN/N?=
 =?us-ascii?Q?ol6p1VWr455m+dsb2UmqnjC9DFRLaF0XjrhAdlj5d78Nw89QScJmqez6PD0S?=
 =?us-ascii?Q?Be4eWY1reLaEfYtOM5pC2612T4Jx6G5/qnzS18WCM2yeB2O9u0Kf4R8J4vJA?=
 =?us-ascii?Q?27xYPttXc2H2P0OfJtrsCFMfyRBaT6gfEAa8vl4GTmkOGljTf46SZHFZYx2K?=
 =?us-ascii?Q?f3pvqHr5Q87o1dJiUj93wc8YM6Kwe3hjYhrJ4c8lnyjRjUFDUfl2p44cpPXm?=
 =?us-ascii?Q?pvMCIFLR8QFHwq+CmZbifPyGUEQ4zHe392NRD2NpPz89hnIZOssOkxREkKFR?=
 =?us-ascii?Q?NGh4CSfpYCK3Sys5x+vRIYPA0Ne3bSWxeU2jQWsy55bXVnP6nZHAuEvBPaNL?=
 =?us-ascii?Q?njh31EGKzgll1PV98svzafdwMWYl5UD2KoaTD15EnM1WEWVNdqGdWvt18rJh?=
 =?us-ascii?Q?pj2+0fWTLH1Ni+OdMijx7hprhit8bt6oupY3CN+/VmN8g9BKQZyH6aoil05A?=
 =?us-ascii?Q?mjjvB5G4CR5jcoS3+ifB06tHBNaW0vdiv48SB3AKSJKSh9+uW1N3lnzGWiKB?=
 =?us-ascii?Q?aYZIiJ4uT3DJ/28I4xOu6TzFXVLuFKbkE8wCe1V+PUW07MeQhh88txA/u97Z?=
 =?us-ascii?Q?eDiIgV9NwNWOMltp2MHvcarNnGJy1Ts9ZtrvVSc6BlfUvfHJaU1uoqqEhTDl?=
 =?us-ascii?Q?jZEw36x7jUuL2zrKSMkoR2b2aBbnK0UIgiTn7qSwLr+bLLYKTYpFwfXkcsDl?=
 =?us-ascii?Q?AtuTwaQeTRg922Vw3pAGxJw3VAF+wivs0z/6zyY+A/m1S9LNFrtQMrenWuxZ?=
 =?us-ascii?Q?zuQ7btMrOD4e5JKfAH97giBj5JbnQ8KWJT1n6dSh/ALjpnCKUHwBrziKXnE1?=
 =?us-ascii?Q?yM8R+b+myTNbFgSr4GyL8MO1kzDWUHRIciP0QLhedcutdfiUcL3Q5KbEXXRO?=
 =?us-ascii?Q?VPK2K5/aWtrlNKxiIBjQJUiiYjEgLFpeMhsNgwq24se4SEGkl7N1bkV03T4y?=
 =?us-ascii?Q?cD017DYMa75+NnJcTHDF8n3+5D7ZT/Ji9KOAi3OYdfk8z50jbOD7LOAsydh8?=
 =?us-ascii?Q?BCqH+ri8RZAxXGFFPYyn68F2RT7GRXdTPA/Vrkmx7QF38Qn27LloO597cvpZ?=
 =?us-ascii?Q?fbsxD1rcMMvJjEThdEe4xkZubXxBs75vwXXtsLNEJdnYOHOupdocZYbA3BcY?=
 =?us-ascii?Q?lbVa6zNR44DvE10evR3Kiu/ui1qPjc9vNCmvoVy11hEmJbjt/17wpa/Pl26C?=
 =?us-ascii?Q?A/K5AKw948cnC7Q61qq5aIw8PmkG0n/JBmYn6JJCSCOIpNtk71gGMuvw+BAO?=
 =?us-ascii?Q?P181x7mqbX7f34cJvcN9Jd48kEY529YO?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 09:53:49.7122 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31b6b108-f68d-4608-5468-08dcc034d374
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8444
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

From: Trigger Huang <Trigger.Huang@amd.com>

Do the coredump immediately after a job timeout to get a closer
representation of GPU's error status.

V2: This will skip printing vram_lost as the GPU reset is not
happened yet (Alex)

V3: Unconditionally call the core dump as we care about all the reset
functions(soft-recovery and queue reset and full adapter reset, Alex)

Signed-off-by: Trigger Huang <Trigger.Huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 62 +++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index c6a1783fc9ef..ebbb1434073e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -30,6 +30,61 @@
 #include "amdgpu.h"
 #include "amdgpu_trace.h"
 #include "amdgpu_reset.h"
+#include "amdgpu_dev_coredump.h"
+#include "amdgpu_xgmi.h"
+
+static void amdgpu_job_do_core_dump(struct amdgpu_device *adev,
+				    struct amdgpu_job *job)
+{
+	int i;
+
+	dev_info(adev->dev, "Dumping IP State\n");
+	for (i = 0; i < adev->num_ip_blocks; i++) {
+		if (adev->ip_blocks[i].version->funcs->dump_ip_state)
+			adev->ip_blocks[i].version->funcs
+				->dump_ip_state((void *)adev);
+		dev_info(adev->dev, "Dumping IP State Completed\n");
+	}
+
+	amdgpu_coredump(adev, true, false, job);
+}
+
+static void amdgpu_job_core_dump(struct amdgpu_device *adev,
+				 struct amdgpu_job *job)
+{
+	struct list_head device_list, *device_list_handle =  NULL;
+	struct amdgpu_device *tmp_adev = NULL;
+	struct amdgpu_hive_info *hive = NULL;
+
+	if (!amdgpu_sriov_vf(adev))
+		hive = amdgpu_get_xgmi_hive(adev);
+	if (hive)
+		mutex_lock(&hive->hive_lock);
+	/*
+	 * Reuse the logic in amdgpu_device_gpu_recover() to build list of
+	 * devices for code dump
+	 */
+	INIT_LIST_HEAD(&device_list);
+	if (!amdgpu_sriov_vf(adev) && (adev->gmc.xgmi.num_physical_nodes > 1) && hive) {
+		list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head)
+			list_add_tail(&tmp_adev->reset_list, &device_list);
+		if (!list_is_first(&adev->reset_list, &device_list))
+			list_rotate_to_front(&adev->reset_list, &device_list);
+		device_list_handle = &device_list;
+	} else {
+		list_add_tail(&adev->reset_list, &device_list);
+		device_list_handle = &device_list;
+	}
+
+	/* Do the coredump for each device */
+	list_for_each_entry(tmp_adev, device_list_handle, reset_list)
+		amdgpu_job_do_core_dump(tmp_adev, job);
+
+	if (hive) {
+		mutex_unlock(&hive->hive_lock);
+		amdgpu_put_xgmi_hive(hive);
+	}
+}
 
 static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 {
@@ -48,6 +103,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 		return DRM_GPU_SCHED_STAT_ENODEV;
 	}
 
+	amdgpu_job_core_dump(adev, job);
 
 	adev->job_hang = true;
 
@@ -101,6 +157,12 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 		reset_context.src = AMDGPU_RESET_SRC_JOB;
 		clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
 
+		/*
+		 * To avoid an unnecessary extra coredump, as we have already
+		 * got the very close representation of GPU's error status
+		 */
+		set_bit(AMDGPU_SKIP_COREDUMP, &reset_context.flags);
+
 		r = amdgpu_device_gpu_recover(ring->adev, job, &reset_context);
 		if (r)
 			dev_err(adev->dev, "GPU Recovery Failed: %d\n", r);
-- 
2.34.1

