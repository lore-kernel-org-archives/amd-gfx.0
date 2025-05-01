Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61B77C369DC
	for <amd-gfx@archiver.kernel.org>; Thu,  1 May 2025 18:13:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D667010E377;
	Thu,  1 May 2025 18:13:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="o80cY1Wu";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED4A010E0ED
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 May 2025 18:13:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iogfqzR2MCldr6AHadSCHurRZGn8YHiR5q33axUDtBpLwuQ6ipPd1h1L+8W0zfEC8+GU9+br+qdbtCtdAi8nuc2A9ELRGEkg+4b4X5lRrql+7aRCUyVV0RngPdjqCyC63978kqyq95UHyM0oREOoivDNagt3JzKqKN124ah/gMd4b+uz3k64S6TmC0cBHyV9g/RhaZ0PziJgsFWdIeRKSzDcmUqKJ/0Q1sJYI3C1hu0xMr40MG69nRgF8apgTBK2lqq39Y1TqZp04wH4Q8yTo5Up6tZkLxHFpmtgzbPtQ0JOd7LXwRdz0X8IMGc+/Uc5AwfVIKMPzt31cNJoGO4e3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oWcfVsITUyPRZXfJ6ZL+ogZfhpJlolzdhBu69b5Rjyc=;
 b=mSZbkCAcL2ncF2vv5ilromV9lCeR/BPSKd1jKY0HskZCu/uDjDZtRlaaJ+v9o8CUmL3zJLSc7qnrZw0M6PPREV+c6UCnI6hZmYBahlAXh7QJN6+dmhC6oryhL8aFWHNe6Jc09ZgcqvGp/kd1BhVOWhv+ZoZxmTF7OHkK92BKy8cLgPY3VPHIo8Z/nf4ANnVypJE7eN6gocwXuflQ+9tMGnsoxOYUkg32qc/nUsGKczmDqVoq1fQd6ZhqV9ULINDF845LCcLsFNJI8781fBPxUdPVN4N50+ae88nj4lcVD4hlUkjNAHEVulClaTuCR4Vwe65bIQnhHOWtz0EzKSx+yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oWcfVsITUyPRZXfJ6ZL+ogZfhpJlolzdhBu69b5Rjyc=;
 b=o80cY1Wuct7kgLRP9NSr46U1ZKlUwEEssB7KJAixoTHulp0JfdCaXJawodfOTz2894wfW0PhEwuRhRE8wlf/IThCCHcl9WDKeyMH5FCIVSRi0+KwaagV5MdM2QSmmujZz3nJHQpzQjUVGw5JP3XsWe7NIvsxob4CUTY4bR8xfrU=
Received: from DM6PR03CA0039.namprd03.prod.outlook.com (2603:10b6:5:100::16)
 by SJ2PR12MB9212.namprd12.prod.outlook.com (2603:10b6:a03:563::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Thu, 1 May
 2025 18:13:43 +0000
Received: from CH3PEPF00000016.namprd21.prod.outlook.com
 (2603:10b6:5:100:cafe::34) by DM6PR03CA0039.outlook.office365.com
 (2603:10b6:5:100::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.42 via Frontend Transport; Thu,
 1 May 2025 18:13:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000016.mail.protection.outlook.com (10.167.244.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.2 via Frontend Transport; Thu, 1 May 2025 18:13:42 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 1 May
 2025 13:13:41 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>
Subject: [PATCH 1/2] Revert "drm/amd: Stop evicting resources on APUs in
 suspend"
Date: Thu, 1 May 2025 14:13:27 -0400
Message-ID: <20250501181328.4107034-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000016:EE_|SJ2PR12MB9212:EE_
X-MS-Office365-Filtering-Correlation-Id: 64db0770-dc5b-4959-d83c-08dd88dbe7f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?L70XbzoAF4v+PMewSMn2P17R9hwvQlwT1NDv8KAoaROxQorfnNjdNTw66Mhn?=
 =?us-ascii?Q?Iru/QYpN5P59uh3AQlSP3PHXI5MGv9LyrA05UpgJh4SSS6zhc261Gqrejud+?=
 =?us-ascii?Q?Yba/XtNy4IoBdy3pT+a7kc7FPGKNquCi0ACRsQv4LjL8tUrXJRnqzMfZCvoP?=
 =?us-ascii?Q?Qqk8WrqMYkFd/4Q51kOCFDoWE4e4fMThEnC0FXniH+dI4Blie3uo7+T6CVSC?=
 =?us-ascii?Q?J56j9S9T1JO74Cts1VbiUhEp+CSz9p27o4TIVuvJNh+ToJ6yp4sKrE4ybqdu?=
 =?us-ascii?Q?VHjxCWIbJZi94Gf/iddnBfRNtuxpQeSyf6KznULRHWwCz/VXIzmt91ExYF5K?=
 =?us-ascii?Q?pNefHB0koTAjbktk+VmxjHgEC+JZN39dDXI/M1aevIHAV+m8h0dj6aQCn8TX?=
 =?us-ascii?Q?IAU1P+PYOJjDFDU3hl0fqwUX4zuVknQxmeUJfrhwvshzON2zWRrVgLCnyLgl?=
 =?us-ascii?Q?qLFJsTtG+FvKdLQ5AV9+92+EOBBoxf+lkJPwcPzrxgcDED0ptpc14mGhue83?=
 =?us-ascii?Q?FJWnS5E1QYGxC3IChpIljy0FhIBDM957CR5/aqEWNad2wo68ESCniUCRd3ER?=
 =?us-ascii?Q?ANjijeFOi5X5pjVOCObOETghu/IEKZnWMWRBXzlSwFIG91SCrQL4KxQ5mH9d?=
 =?us-ascii?Q?+akI2jeAWHbjxRce4shcbemuuXe5oaCfqw+RsjdYb2GRpVbwL0FlGp4/5Zt2?=
 =?us-ascii?Q?4RtXC2HLE6CnaMJxo1DaAWm0DOfVvxpgATaEAY0TqJV3P5fpxtXwgeOqnX20?=
 =?us-ascii?Q?tjIbW4BE0rafAiiozn01HxppTRNHC6DTSS1YBNfywc6tIPuesXdvB7m/Zxfj?=
 =?us-ascii?Q?5bSFDHAh8i8OXJjvxAY/79/jAN2Jl6q9mOTssWGalvdZYlaOQ3a/AfKSi8lT?=
 =?us-ascii?Q?tP1bdgFFu7U4FwkA3RlDAeWgYNXd5cOHc/aMWS2XBFG2tlfGIp613XA+NjOQ?=
 =?us-ascii?Q?a54lbmIglrcPGlz48YcEd2HhGntEWoA1kRUNvyAznL17nDR+jNbA2XgzXSyv?=
 =?us-ascii?Q?S9eoXVS3iJfM8kCLfR4+tr+EHuTgnsi9Pwf5mHA5iCw8YObmmsBEq69wJzg1?=
 =?us-ascii?Q?4us4E3cVlLz1TU86d18cqAEGkO0XbmNa0JJ2gbevMondz1c9FahYutR537m5?=
 =?us-ascii?Q?QOiXKhXlGwMC0nHYZGcuh4eAaVfc2PMbJ9cP6696inTmYj4VhETAYlIGZ6c5?=
 =?us-ascii?Q?aDzUeq07J1mX6g2q4osLWGQDDHe0mFfoVUeCO5x6jBAqwKYO98s0CaTmXWN7?=
 =?us-ascii?Q?mkaT6duSFUVPUZQwdKVHDQVdpzX6XwiBa3J4ygEPZLbN8yN/7PfdCSHHErH6?=
 =?us-ascii?Q?IjstSf6cr0hquziqbHDYpBT3rIyyAnEw0cmimhEohTIFOhMh8zKYHdMCe2a7?=
 =?us-ascii?Q?Rz7fYK2M3UF8zQaT8veTf38ZantqlxKsqzh7H4qfaXSmKyfOScU+qbacLhP4?=
 =?us-ascii?Q?lmDCDg4RKV+pAzy1fffQIAz6rIzRjdd/igzOR0qqe+xOdjYVc1lISQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 18:13:42.6603 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64db0770-dc5b-4959-d83c-08dd88dbe7f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000016.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9212
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

This reverts commit 3a9626c816db901def438dc2513622e281186d39.

This breaks S4 because we end up setting the s3/s0ix flags
even when we are entering s4 since prepare is used by both
flows.  The causes both the S3/s0ix and s4 flags to be set
which breaks several checks in the driver which assume they
are mutually exclusive.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3634
Cc: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c   | 18 ------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 11 ++---------
 3 files changed, 2 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index ef6e78224fdfa..c3641331d4de7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1614,11 +1614,9 @@ static inline void amdgpu_acpi_get_backlight_caps(struct amdgpu_dm_backlight_cap
 #if defined(CONFIG_ACPI) && defined(CONFIG_SUSPEND)
 bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev);
 bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev);
-void amdgpu_choose_low_power_state(struct amdgpu_device *adev);
 #else
 static inline bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev) { return false; }
 static inline bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev) { return false; }
-static inline void amdgpu_choose_low_power_state(struct amdgpu_device *adev) { }
 #endif
 
 void amdgpu_register_gpu_instance(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index b7f8f2ff143dd..707e131f89d23 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -1533,22 +1533,4 @@ bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev)
 #endif /* CONFIG_AMD_PMC */
 }
 
-/**
- * amdgpu_choose_low_power_state
- *
- * @adev: amdgpu_device_pointer
- *
- * Choose the target low power state for the GPU
- */
-void amdgpu_choose_low_power_state(struct amdgpu_device *adev)
-{
-	if (adev->in_runpm)
-		return;
-
-	if (amdgpu_acpi_is_s0ix_active(adev))
-		adev->in_s0ix = true;
-	else if (amdgpu_acpi_is_s3_active(adev))
-		adev->in_s3 = true;
-}
-
 #endif /* CONFIG_SUSPEND */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 7f354cd532dc1..5ac7bd5942d01 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4949,15 +4949,13 @@ int amdgpu_device_prepare(struct drm_device *dev)
 	struct amdgpu_device *adev = drm_to_adev(dev);
 	int i, r;
 
-	amdgpu_choose_low_power_state(adev);
-
 	if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
 		return 0;
 
 	/* Evict the majority of BOs before starting suspend sequence */
 	r = amdgpu_device_evict_resources(adev);
 	if (r)
-		goto unprepare;
+		return r;
 
 	flush_delayed_work(&adev->gfx.gfx_off_delay_work);
 
@@ -4968,15 +4966,10 @@ int amdgpu_device_prepare(struct drm_device *dev)
 			continue;
 		r = adev->ip_blocks[i].version->funcs->prepare_suspend(&adev->ip_blocks[i]);
 		if (r)
-			goto unprepare;
+			return r;
 	}
 
 	return 0;
-
-unprepare:
-	adev->in_s0ix = adev->in_s3 = adev->in_s4 = false;
-
-	return r;
 }
 
 /**
-- 
2.49.0

