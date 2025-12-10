Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D2CFD3C928
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Dec 2025 16:33:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FEFA10E58E;
	Wed, 10 Dec 2025 16:33:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Xj2Jq6uT";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013064.outbound.protection.outlook.com
 [40.93.201.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E55A710E58E
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 16:33:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uiBgeRelCGPZMFi3BCWepIzRdfF/xUzBZIag97LgItu5M5ZjjXy0t2fggOH3E+aAuuY1y+das5LMIpM0kV0pOd0KnfR5PphAO6WuSx1bAuHj7/NBi3gZiLGkqvrESgz9tsePHbRqimxoFMD16QHR7PMwckW2l7+TYyBQOrGDbeEMvzJ7O44iL6/R5djVPKpJQW8GSP1cRJErEFpJR9Z1kr5YTguXvJCBFT9RlVfCUHOVxgqSH+PULz18faahPe5Qc5yPlyiKtxzxJ1LubxEnOJwpp4ke71HgFDR0AAN6O1yq8884f4NFn6KxrV6oEITrrSQML+XWyclt8bxXxGihfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tp6kQrp5IGGMMb5Z0nuVS+xVMyqOqJCprLs7Io/weN0=;
 b=fnkvUXgcpljP0NpBNyNkAmzT8mJbSShJM126OS+sVFAXyNlzMZxb4HYI8Eui7fx4f3VBqlIJkVWZFY4NyQTNoCZN6FhnzDJVxIN9G5VOgRJsEMXZ+2rcGD2zxDTFtD6d0xrdg+8xhirPDT+e44fGk8FwCyUC2u/BuSrdBWUkbYUdTg513R4hhhiYBK2QsmgTSMkWJRMQK56Vg+nEU1axjtFDkg0Yrswyr8CREkh6+hrCpzd477uI0OfacfcUPgSMJvzLq3hhU+T0ZCbx/IVDyf1cpohJqkC96Kc1ar8+cF4Eg7/04NMUUk8xpNzuDymylCecDGGFjE4VDwoKNEcdgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tp6kQrp5IGGMMb5Z0nuVS+xVMyqOqJCprLs7Io/weN0=;
 b=Xj2Jq6uTp7pynKkHfnkudVhLSwKEo1k40XCfch0iy5RLVurvdJ0Z98LQgacAJp6Q/he0YzJqI8bwbneXNKlim+68LqJlzwti1cVkrW/CugpkF+EjmIHodkRUBhUM00sv6DlTEs7OA33vfUFADKqks/g7BnHNZjy5e6LfwGIn6Wk=
Received: from CY5PR19CA0055.namprd19.prod.outlook.com (2603:10b6:930:1a::32)
 by IA1PR12MB6651.namprd12.prod.outlook.com (2603:10b6:208:3a0::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Wed, 10 Dec
 2025 16:33:09 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:930:1a:cafe::44) by CY5PR19CA0055.outlook.office365.com
 (2603:10b6:930:1a::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.8 via Frontend Transport; Wed,
 10 Dec 2025 16:33:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Wed, 10 Dec 2025 16:33:08 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 10 Dec
 2025 10:33:07 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, <SRINIVASAN.SHANMUGAM@amd.com>, 
 <vitaly.prosyak@amd.com>, <christian.koenig@amd.com>, Matthew Brost
 <matthew.brost@intel.com>
Subject: [PATCH] drm/amdgpu: fix a job->pasid access race in gpu recovery
Date: Wed, 10 Dec 2025 11:32:54 -0500
Message-ID: <20251210163254.45210-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|IA1PR12MB6651:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d04007a-e980-4550-92f2-08de3809cd64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+y7WJ8GS5KCIFR75LGcq5PAhaYWI/3IEA05auPuL+3uMIsn3uKYZ2N0qnH3y?=
 =?us-ascii?Q?5+TTi7RES4g19+EB7cXnBb2wuhEhOvFpwJzVd8icW5qBuGEnHZFg105OdAEq?=
 =?us-ascii?Q?s9S7UQ8M3+20nAcwJbl6tm+ARsAyhHErZu9CEO0L6Pqpg+pG65y3DsYKSutr?=
 =?us-ascii?Q?IUvVV2l2aHpkB++kHOZwTsJhfsi/ydgpBNC2NUKEhJST00Y0BCR3WA68di6W?=
 =?us-ascii?Q?6b6JlrtgOCvsam0xkVsf0FTbKD4HWolLfBkSl3PNCeTn1JQtylED+cvjKIdB?=
 =?us-ascii?Q?PumneQAeUM6dBkEuRd8NV7VG24rqnjWQZXk5MEDrlq/+3cHny00kYtG58S/3?=
 =?us-ascii?Q?eLn6XJ4TLWYOV/9PGmDAnUq81L7XlAvCWOx2lxuB2g+f+WAsUmb+beBYZZG2?=
 =?us-ascii?Q?xJVk513D4UJvAh6z9DEr+Tt+Ihws7TKVtvKdEKgFQBbwS2bE/J1JrtigzQz5?=
 =?us-ascii?Q?HHy0pouqdf1Nsv1OSvcdqycoh+KNvlyFrp3Ry+QOyNTZ+iVY5c37PCwcsQsd?=
 =?us-ascii?Q?6kcyoXurn5gLhY+83M5bmgDTZcvsqTWgoAczcCV27S3wiAn4MFb5ztD1QjCt?=
 =?us-ascii?Q?3fA8OPIq2Ccbf04+XJz9vf3FhFo5GhncIVvGYmiAkjqBQnamIRGv0+3orud6?=
 =?us-ascii?Q?ciJAbKtYlKKwd43zS6WX1dscxUHdQF1VBnIjB0MGs3ByIWLM9//ZXWkt9eIV?=
 =?us-ascii?Q?SVQNAXSFAjsNnu80kFiGP92Q9Yjj4M5+JDg1ZoHAtFX6mxQzg5r9C1+Hdzqh?=
 =?us-ascii?Q?WaXsgmLpGk+kZfrZFlWBtbPAGWq6TJuz3cXWNgqzac6dN12MI41swDGLka7e?=
 =?us-ascii?Q?sg+EFe7LaN5nBGJgKu9YngD++kFgcZF6cDhnAITJEyXws+K7Hp998LFWl4kC?=
 =?us-ascii?Q?LfKGgKYs29pom0tqPi3Qj1x2qe4Y4tmRKMlV25m1wZkbVuvA/eTP0i/pvnHn?=
 =?us-ascii?Q?itMNVr61Ju4/OlVC5PueDgPmhnpIsZnBvokG+GSnDnuzAKrLp6344Hxx2vcK?=
 =?us-ascii?Q?uhMPX2a9UBh0/Va57aLdTfThleqsYJ9qDBW56eanHRIg4p7xh2clJVtSZL8Z?=
 =?us-ascii?Q?Gsdqc6th20LBLaODXg5ScRde728QZoOvPYVNwpzAAqkgeE1WYoj1fajB+wKW?=
 =?us-ascii?Q?4djZgjRXzxjiKhPfjCKNbmysLxoX/tEaxRa+jJTIo1zZcu6nCaM/U7RPFxTq?=
 =?us-ascii?Q?sCIHWZKu5NGQfliPLWKhBdEpkoluAzJrkoRqpMP+Lu4HMXNHCrtqsZd8n7B4?=
 =?us-ascii?Q?OQ9RyTS1IcAr2fMgiaWT654wuDLnMpkXULuY44kinRYNxuK2A4Hp76KD2xt2?=
 =?us-ascii?Q?v7CJpgmCoNTkEoJnijXtpSqrhfkQkI3zlYTcKSompXisq96usXZJaT5cfDhG?=
 =?us-ascii?Q?sQfMbGVjlvyJ9gUSs0TSrfU5vJoYRRhHOI+SvotuznHUOSyUMpHiXCKU7ntG?=
 =?us-ascii?Q?BNJqSqqYFZNoy0Uq1q0Ou9EOdGfvGLfHPDMvJF/d5131aNTma02prap+qlM8?=
 =?us-ascii?Q?w8gA3oy4Nca5dbnef/xYJ/oaqDHnOi+GYoy1/CYamcSgX0a6bKr1j0Xksnq+?=
 =?us-ascii?Q?8wPql6Iwe2+/Lrgu3iw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 16:33:08.4064 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d04007a-e980-4550-92f2-08de3809cd64
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6651
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

Avoid a possible UAF in GPU recovery due to a race between
the sched timeout callback and the tdr work queue.

The gpu recovery function calls drm_sched_stop() and
later drm_sched_start().  drm_sched_start() restarts
the tdr queue which will eventually free the job.  If
the tdr queue frees the job before time out callback
completes, the job will be freed and we'll get a UAF
when accessing the pasid.  Cache it early to avoid the
UAF.

Cc: SRINIVASAN.SHANMUGAM@amd.com
Cc: vitaly.prosyak@amd.com
Cc: christian.koenig@amd.com
Suggested-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 8a851d7548c00..1adfa23db0981 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6634,6 +6634,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	struct amdgpu_hive_info *hive = NULL;
 	int r = 0;
 	bool need_emergency_restart = false;
+	/* save the pasid here as the job may be freed before the end of the reset */
+	unsigned int pasid = job ? job->pasid : 0;
 
 	/*
 	 * If it reaches here because of hang/timeout and a RAS error is
@@ -6734,8 +6736,12 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	if (!r) {
 		struct amdgpu_task_info *ti = NULL;
 
+		/*
+		 * The job may already be freed at this point via the sched tdr workqueue so
+		 * use the cached pasid.
+		 */
 		if (job)
-			ti = amdgpu_vm_get_task_info_pasid(adev, job->pasid);
+			ti = amdgpu_vm_get_task_info_pasid(adev, pasid);
 
 		drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE,
 				     ti ? &ti->task : NULL);
-- 
2.52.0

