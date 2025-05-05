Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BACAEC3ABAA
	for <amd-gfx@archiver.kernel.org>; Mon,  5 May 2025 15:30:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F26ED10E2FC;
	Mon,  5 May 2025 15:30:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Kym2njqW";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2084.outbound.protection.outlook.com [40.107.102.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2AD110E321
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 May 2025 15:30:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CO+eB9zbfIZVXVkxbmW7h9Wj1B/wvm/0qvSaCJukiRh42Y4rzvy07kL5XoGMUzmXbw8aOWvHUT1DvmBeigS2BIKMWLFV34e+oJSncTs1HP8VdQCwrwNS1bARHgHzegTpWi/2xbPovME5YYC9V2hY+VmX2sYd3tSEhakBvYm15h/hmvtWUWhueXwDOdH07fs3KXXaqDhy6/0qmSsYNp2kfz4EEcKTHjC4qheuDgtsIFT0JBfqLSaTqxpc7/PEwcjyUY38q6LUaZ8QSgbQMZR7RHiiEs2ec+eVm06FaZfXtxDAkZMjSkGTCKJFS01if1Mv15LgYEQccayVTmK94FWlBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QIDs+OhqxjwdnCci4/x9VWsZM+ClYKxYXUCKLCfLeWE=;
 b=qVjgTbW+50la0Ack6qmnnKkyzBpVW8OtL8dmNexRf4ETAZsf/OcnF59gPknMiSVUtAE4LT9tGU8syZB+42g4C5dOPImxSPPs7OAO/qR0NtD0vXwBJ01aRVP+O+Q+9U8u9Z8GlNDeOUlBXuVkxFh1WEC2DLh/2Ul8/JDz8qLh1eZo0qy0PtxmzA5KV3/2szjBdora/sZl+BPU/ZzJLRODqY6FBBd1qoz8wwRr5Gtpg5qv5mIdmLTDm6rDGENN6BT29gcSTTCWjtqAJoHTVqTkz+8jNkJ8mP4R/mZ7puk/3IzPEOcxhbgIBQWpWHCgjRNSf5xUdb+V/7rZoywnNxZsjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QIDs+OhqxjwdnCci4/x9VWsZM+ClYKxYXUCKLCfLeWE=;
 b=Kym2njqWWmd8YTVEKeirmJ6Foy6JO6rJ9evTKdz0NeKZH/iJaPhkJgMorGO8RWoxuarvgDEi2yQFYvwxir+3r3vtv6nv1zXMLfS+2emskxRtfLAH/MjL/hsA7c3NxDWKSnVDNwKVtw7FRGvxt058mszpYYrWNY6Is7/Iu642be8=
Received: from SA0PR11CA0062.namprd11.prod.outlook.com (2603:10b6:806:d2::7)
 by DS0PR12MB7948.namprd12.prod.outlook.com (2603:10b6:8:152::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Mon, 5 May
 2025 15:30:19 +0000
Received: from SA2PEPF00003AE4.namprd02.prod.outlook.com
 (2603:10b6:806:d2:cafe::35) by SA0PR11CA0062.outlook.office365.com
 (2603:10b6:806:d2::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.29 via Frontend Transport; Mon,
 5 May 2025 15:30:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE4.mail.protection.outlook.com (10.167.248.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Mon, 5 May 2025 15:30:18 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 5 May
 2025 10:30:17 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>
Subject: [PATCH 1/2] Revert "drm/amd: Stop evicting resources on APUs in
 suspend"
Date: Mon, 5 May 2025 11:30:02 -0400
Message-ID: <20250505153003.2047138-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE4:EE_|DS0PR12MB7948:EE_
X-MS-Office365-Filtering-Correlation-Id: a284740a-fab9-4028-5bd2-08dd8be9bd9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7z1f5Ak42Cy8lrxkAqn8mzf7N4tXyn8vIqJBgLTjcno6/XV77tMGjYl8VIpF?=
 =?us-ascii?Q?5KDlAr/xjdDg7v9yUFVmduf4nurL/fb8o3WHM2oOVjXW30Mdu7WISy6E9ryT?=
 =?us-ascii?Q?XGkisr4pNHm4WBK3RJLT1DqNbs3hg67gmpj2vOnBaVp7j7ZufaIZ6ErpHg/S?=
 =?us-ascii?Q?huRW3bnWb0hHQG7GRv5AeAbDgwTNxs4Z2za8bPbuKTZ2OPuZSR8R8iVwLDuW?=
 =?us-ascii?Q?uz5NsLzNC/wdfTWbn7lHHvchbx5WLcSv5ElMLKMulpy9NVhsV5MMGGjt+nII?=
 =?us-ascii?Q?k95PihvGRyOj6iXwcS53wUjU1u9fH0bfqYrjZbOpv+DvxaDFOSYGgvmbfwRV?=
 =?us-ascii?Q?8QJM9bUoeUztCO5NwBeiw48hxUWDbUq48JSo8+o85Bqv0B10eidKgcGHQMKA?=
 =?us-ascii?Q?9O/DnXfCKgMBvcgySJY9T0NsOnBQJ+A557cpflxpzhw7VeXeE811jKZqDKiH?=
 =?us-ascii?Q?xah9GlSEWE+z7fsrRDwdFMMdDqT2JIdadmNbzQXAZ6iRAhTJ+Ltj/1FxbWr0?=
 =?us-ascii?Q?qo9j9scA4bZ0gAWgey7gkNPPFYJa4Nn1cBbAGuTIm76XLzmwwtHza7EZPEJT?=
 =?us-ascii?Q?jiyzrzQKnSCOn9aypgutbMb/54bA+GfCAcob6aZtWU+bMGWnm5zsqHgSrCkS?=
 =?us-ascii?Q?eHk0sHajD8Ka9S/rcGpx8fALKg/OSuDn8CX9TkjuJGmTai8z7AMic4XFz1LR?=
 =?us-ascii?Q?YTAVPBVaWPgc3jHOiHIxi7sp6Ms5+auKt0FokgZ9qPQqiXDBAe8Jp7uFcumI?=
 =?us-ascii?Q?6EGwjW11T6P6Ds4vbNOQNAr0DUMyU7G6ARSzdS+E/3GY/+lLnUiSYhXdVfLT?=
 =?us-ascii?Q?N+kr4V93xHYXXrcOG3Xn19xoQxGKusLAFNMmzIrmL54IjoOr3XgccvKITO8n?=
 =?us-ascii?Q?EdR3OSvHgYQeYDvgi8AZ5FHGFXRbPIJwFnASzWEBQGmNbs3e5xp8KkbnlW7T?=
 =?us-ascii?Q?bDZONVOEA3DqciwlOmPZAHQ+5KnZmIa1XSNGhH3BFLpO9D9htPUdHOPLYNWF?=
 =?us-ascii?Q?HI5z5JZpC36pBwVJQr5d2bUzHH0hb+9yT++1X/9OSyu5Paz6YWmy4gkJUqwy?=
 =?us-ascii?Q?jE3hsyOvEtY2qEby9HnZHBX0YxdjgVc3cJBQe+a4bae35PnhcXzM3b2eDDl6?=
 =?us-ascii?Q?Q7qhRci1tsnHO2achwAOZKga2G+nEGCT/fsgP6r3cr/D0WhIXE+S8Q8Xlhrs?=
 =?us-ascii?Q?KVOqlJ8n4NAZlHXVamiYDvtNXf7w8JioBVTSIPoml9caMsG+1z4sKE5uqwMm?=
 =?us-ascii?Q?PD4b/ABKjVoTDLGGkM5TYE26+gUymeCoFZUKra7klzgQjZ+0pSaaMXSajMDu?=
 =?us-ascii?Q?y65mlEuZMllVFPZqqDXHl3ff0qzpU9k2MUK6NJ+xHEq/YwClfnC1Kq45CFxi?=
 =?us-ascii?Q?hxBtNdBEZb9PJE5/VS34wx/6JFikhCVtPzeoG4lIjfJ2eD8EpzNkTovZPzub?=
 =?us-ascii?Q?KA8sYgzUVx4pkRWjrZpA4XEEXVEikemUkT89UBNQpROszGDPTGsdrQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 15:30:18.1131 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a284740a-fab9-4028-5bd2-08dd8be9bd9f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7948
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
index de57ab032cc70..f59ba0960a776 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1707,11 +1707,9 @@ static inline void amdgpu_acpi_get_backlight_caps(struct amdgpu_dm_backlight_cap
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
index 32b395b43d372..368004b716ba8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5021,15 +5021,13 @@ int amdgpu_device_prepare(struct drm_device *dev)
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
 
@@ -5040,15 +5038,10 @@ int amdgpu_device_prepare(struct drm_device *dev)
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

