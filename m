Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E397C35FFF
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Mar 2025 16:53:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACC6410E4DA;
	Thu, 20 Mar 2025 16:53:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e6R5QztS";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D571310E298
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Mar 2025 16:53:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dxX3gpUl3tRy8sWyU8kHm/hzwBJIT1HTvo36ZMludHDcWoUHzAXdelmuw3PEY+VRAqcBV67X3PczmUdpv6v11WGNq+dKYQIboTQp1at3UESWgo5S0T+wEvAmeUhhC4sMdUoR6RjAHkYntCVHNAtuuqgF23oEXhMM7zf1W/sfJgF2FS3Z71KeKLCrDzR7u9Phpf7vFo9N0jL56BC8qGqmcNp7In9CI7BabnwffZr1dhiSLBzg5I1sRLRJ0i88xJaOv3Zq2mJzJjDim1j408CVFdsngXm6xPPosUIgY+3zqM3lnabF6m5ZzVOeGTu93DVGdpQ/Kw4WNLlT9014V1AOiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WpWM3jRvj6HSrZSjpRif4k4NplyduWZsiHS6OIUyTdI=;
 b=AFHNNL5ZJbvfMnZxOuGpnUsF3laA+AELU3DDxUSs02GnZwxKn6BLQUmnvjqhYQbC3RpGQlzTARHAMrJpHuORuEpS/ZlTgtKVThnWVj+MkWiGJmVVYpwnSPE9cpBBQkUeuV2Iln4/aarxxVX0LywSnDhYsuzklz3VSSZEmOsCTXC/iLjSrPVU9mRFY+l/6mRdrJovD9tG51WoXPFJZGU3Jvbk40axMhlhomDF6q7YFTEB/rb6m6FxPa/xIPAoJ/SF9qBjEy4ruoEY7GNtimGuPY82jvM/FKYH6xyaZhlIACJ/YX3crxFusMU/VE7TqabGs9CcZzqUhen2x12TLDUDWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WpWM3jRvj6HSrZSjpRif4k4NplyduWZsiHS6OIUyTdI=;
 b=e6R5QztSFm08q/8Cy/XZkfDcQht/ItoKOfj6/yCwLVlNvLSK7pCpD+9VEeICG1aXkdkW8De+5RiE2MoGdVkB5qkGIqpLSbgwufuWuSB75ELURm091TL91i/2pn0JTeubUfjmA9nd7REuUrYXC4rpzvKvF26+uR1AcwMckcb1F1E=
Received: from BN9PR03CA0786.namprd03.prod.outlook.com (2603:10b6:408:13f::11)
 by CH3PR12MB8904.namprd12.prod.outlook.com (2603:10b6:610:167::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 16:53:05 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:408:13f:cafe::e4) by BN9PR03CA0786.outlook.office365.com
 (2603:10b6:408:13f::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Thu,
 20 Mar 2025 16:53:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 20 Mar 2025 16:53:04 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Mar
 2025 11:53:04 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Arunpravin.PaneerSelvam@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: store userq_managers in a list in adev
Date: Thu, 20 Mar 2025 12:52:48 -0400
Message-ID: <20250320165249.1238463-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|CH3PR12MB8904:EE_
X-MS-Office365-Filtering-Correlation-Id: da0ba157-44e1-4bb4-c8c1-08dd67cfaf11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cndr2xkW7rMw4yKHIpvgB44xXDjhMSlrRwzmrdGJsJs325osAD585yFD0cWP?=
 =?us-ascii?Q?fEceTgBbF1MCCdz2/phRbuIDGsD1xWpTTryT50/+ITQ/EMNPFI7lAocxJ1Zd?=
 =?us-ascii?Q?rITybgZhsHiNjh1XuKLnuXxgscjQqFI3dJXPnUttyinsabjCsZVPCVOT4AgK?=
 =?us-ascii?Q?6+0zYzhTm2hX8CYYwRY/fL7/JxzauIEClWZAvR9coVdap2J30wrs5h4KlFs0?=
 =?us-ascii?Q?LhDq6p6h98U7g9PRxJq7I+FP7gYTPE5pjzUmNfYs4XNtJrDpT2moiG2Oe4f+?=
 =?us-ascii?Q?u+GesN66lqdC3TTMAn8BjyUTo+qiiSMSSZr5Gywkiqc7XVI2/Pt8r5bh5uCj?=
 =?us-ascii?Q?yNHrKg5jAzR7IvL44PxDi741LIlvWCebhNCAOMNI20Jm+qOLHuzskbM5nqCF?=
 =?us-ascii?Q?tsEmOI15E3zvz2raoAZCvHWUsiJrq7b1XkiWFeZzJUkWECX1oxY7kBlOOTA/?=
 =?us-ascii?Q?vVfImakeFhmfvq62wHUzcXoPXs2a0vM7XW68sib+xD3n4fNstg8vmK1PKcKa?=
 =?us-ascii?Q?8AwUlnkLpoE9T71+1MpYzv8VVkuz+lTkNPS9e4/+7dB7iQk9P6aTxt01Smvl?=
 =?us-ascii?Q?WS/NErsyt67+pksG5DMOzoj7A1W6mZmqlvGN0Y3yiDycC0s3m3+ICpT6Namz?=
 =?us-ascii?Q?hvmGWezhPjC4vt8TY6th+O3gePTr/Xvi1EYq56GCZvVKFPL5nBLDC6I9Ejda?=
 =?us-ascii?Q?NJPoJQdhAPm6M3WFi+dISVPZ1ZulQJrDUjjFL48l/WQirL7gs8Mdp6vD33UG?=
 =?us-ascii?Q?9C6Gw2fa40n5RZbILoUAW7wvla1mYznDbKNtL6b35vBsx3kL9giN1rAc/d/c?=
 =?us-ascii?Q?4CtIAMiwXU0s9UGPlW1991JVSNlmxx0iypmsNc42dr8VcwKlTO3PHYPuYO7M?=
 =?us-ascii?Q?GuNKoKamS9scGGQT9fEX+uOVUv5G+bpM709P54a0lkSNQkoAGxl6/yuSghKC?=
 =?us-ascii?Q?k9qG9/CXXUz1zfpst6nIL/zvEUw/RqzFZ9+XaV7/QsZOYTdmuIl5LfdIK1Kg?=
 =?us-ascii?Q?yZwoRkGDWAChhkUh+NTjReWU/6RybS6vA7MFYb6b5zL+i3UWFt1mZEJddb8E?=
 =?us-ascii?Q?+EtYB37YE0MWE9l8gLURfL9FU+2X7YsBOcPeGzSOjjhJjppXFTMw12A93Int?=
 =?us-ascii?Q?vHgC3C+0ZM//Yd9ZSwzjG93AkuEMEFee5DE8klK2rS16kxiDzmvwinNC1pHD?=
 =?us-ascii?Q?XejTWtDDTWcTZP1aulF3bxjks9+WGnUGs1iklsOdS3eDhEAJOY7RnM2lmbb6?=
 =?us-ascii?Q?X0OnvLPP4+Oph4+7QbIhqEbuXtflVgQhId1oXo4q433Fvyi2hmhliAULxj3D?=
 =?us-ascii?Q?sqpmWTzq4ZfpKHErHHD5Ziwr9JBgzvU/T8HggKRn0LkhvCPd/zBUKwbG1agh?=
 =?us-ascii?Q?AGQPKIFB19GktjCOjh2QCag1Otm45GUquSYlF31FuUEueWGXgW8gi8XEMBnk?=
 =?us-ascii?Q?d55vEiQP6FnlLKsOeHCI+M9K8H72LaccD3mNZbtqLB0xnUCFKB/bA3BAkxuA?=
 =?us-ascii?Q?ubJvRgpZ5olRiyc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 16:53:04.9079 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da0ba157-44e1-4bb4-c8c1-08dd67cfaf11
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8904
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

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 15 ++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h |  1 +
 4 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 4f770a362048a..28cfa600b798f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1228,6 +1228,9 @@ struct amdgpu_device {
 	 * in KFD: VRAM or GTT.
 	 */
 	bool                            apu_prefer_gtt;
+
+	struct list_head		userq_mgr_list;
+	struct mutex                    userq_mutex;
 };
 
 static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 0396ac30c2a4f..526c5aa32825a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4299,6 +4299,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	mutex_init(&adev->gfx.kfd_sch_mutex);
 	mutex_init(&adev->gfx.workload_profile_mutex);
 	mutex_init(&adev->vcn.workload_profile_mutex);
+	mutex_init(&adev->userq_mutex);
 
 	amdgpu_device_init_apu_flags(adev);
 
@@ -4326,6 +4327,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 
 	INIT_LIST_HEAD(&adev->pm.od_kobj_list);
 
+	INIT_LIST_HEAD(&adev->userq_mgr_list);
+
 	INIT_DELAYED_WORK(&adev->delayed_init_work,
 			  amdgpu_device_delayed_init_work_handler);
 	INIT_DELAYED_WORK(&adev->gfx.gfx_off_delay_work,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index a02614cbda36e..b89bfad52abd5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -365,6 +365,9 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		goto unlock;
 	}
 	args->out.queue_id = qid;
+	mutex_lock(&adev->userq_mutex);
+	list_add(&uq_mgr->list, &adev->userq_mgr_list);
+	mutex_unlock(&adev->userq_mutex);
 
 unlock:
 	mutex_unlock(&uq_mgr->userq_mutex);
@@ -661,14 +664,24 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_devi
 
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

