Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB853C04FFE
	for <amd-gfx@archiver.kernel.org>; Fri, 17 May 2024 17:11:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1938810E031;
	Fri, 17 May 2024 17:11:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FVP6qTSN";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFA7010E031
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 May 2024 17:11:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Krn0GiK86Jw1B1M77TjyVP5oefuviLfBRFAufGnAVGSWtBMDyujCpXO1oq7FMgwJOGTxt14uOZI5n5Cn4fal9nbYERHeO2Ed4f8OCkrbimIomn7ELahDc12IDZqhBrY85fnVRNXXp4ZdpqAKwxgUJbvA3EDw0HYI3YQc59kzKoe3WAoznWrK0XNAZOKjGZq/iW8kkUls+XxCuPljxvZlGH25O1MNVIypAnfLW2OdqR5yKVohzI0NKt82I8JAydSjEhAq3XwOGO8km6/b431p40taKdA4MrnsFYJuRtEt4mFiOaXTwlJorq5RO3Zqv05WgIssBQDkJAIQV2NJBRRwhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SIvXy3cl1zoUtYXYqRbkSUgo34YRwkrXAhfk/sq+jKA=;
 b=WwvjNuhtZ6Bxc4GrnPdVRsUtqIa79xyY7YtkEmCFSZES+uZugIn9dZSJPCcL4iQQB+be/JWRzlZy0krC3V78Nscw2VJ/VGe6iy8BxBlK+Q64ThlekGC/DSM5SANZhM3ujYZkN65vAG6W77BdT4d5TWibXg/UYe4hWw17r5aggdj1guuXOVOe+3yBnfTYFp0vFbJ9YnAwdacqBld3z7f6UUROUpB0/dQJvVpHuscm0DIcNJInxXKhJbPF4O+E8/uKPP7NdlaYY5dzx89uKEr7CeFZejt5DQhMDI5Km+THlQP2T7acWGIyRNSdeAtbkxkF54mwgC9Gz9GRfupmWoFCVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIvXy3cl1zoUtYXYqRbkSUgo34YRwkrXAhfk/sq+jKA=;
 b=FVP6qTSN6QOjgsdjXJ5ehjLNXQGbibgKRDnfCpYGCrD05GSvkRa/uq7PBY66JDDxd6yjknGCA9ldKfRHwedU2Hx1opUO0ejII2cYxEeC4GA3VCfpLnTJ2dNMAChDxgyzwiSTREXNvpCU9Agp+9Yb8Ma9ZDF2o1AY0+97Rh025T4=
Received: from BY5PR17CA0027.namprd17.prod.outlook.com (2603:10b6:a03:1b8::40)
 by DS0PR12MB8296.namprd12.prod.outlook.com (2603:10b6:8:f7::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.28; Fri, 17 May 2024 17:11:39 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::14) by BY5PR17CA0027.outlook.office365.com
 (2603:10b6:a03:1b8::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.29 via Frontend
 Transport; Fri, 17 May 2024 17:11:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Fri, 17 May 2024 17:11:39 +0000
Received: from mkmvskvorts01.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 17 May
 2024 12:11:38 -0500
From: Victor Skvortsov <victor.skvortsov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Victor Skvortsov <victor.skvortsov@amd.com>
Subject: [PATCH] drm/amdgpu: Remove wrong fini_data_exchange call
Date: Fri, 17 May 2024 13:11:19 -0400
Message-ID: <20240517171119.51967-1-victor.skvortsov@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|DS0PR12MB8296:EE_
X-MS-Office365-Filtering-Correlation-Id: c5a0ecc2-04ac-4fb7-227a-08dc76946a62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|36860700004|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XvqS84mT0hJZl/TPpq8uqb/n/h4Za2pKVAbHmHiolAhgZfnZQiUGXuNL1KY4?=
 =?us-ascii?Q?2vNTgFTFNQ5xmRlZB3l1JdQ10n0GqwmZubEmEKKKksKQbNpqPxe/M319IBZd?=
 =?us-ascii?Q?qPJfDJB2Xy3U7O9RwFhWE81Y0Qpi1gep2FQBHyEV38IsQCkaR3UJPipveBMV?=
 =?us-ascii?Q?bYZivKeq7ygAH8MiCCJBmk0+AUpGLq8evFoCskFas1MNf6U7v3Bfe6x1Oo8Y?=
 =?us-ascii?Q?nW4YiBngVe1ZV3/8ks+ejOUbLUUgNiy4cbL+JZI3aSp3254o+iCOuTRCYeVY?=
 =?us-ascii?Q?4PFKxwADtuHO55nF9yqWuMYRXhwgeV5fGQ2h2Ke40ekOWDvWnTcq7h1w/R/J?=
 =?us-ascii?Q?5zHNMfuJQWr8a9XST/bu1P7TmKtvLaAyhzcLfuuSQAlMRpZo3pOOCGKtn2WZ?=
 =?us-ascii?Q?0+WbafByzDrtgACWbdDkhOa79TAkI+5bh7POYCysOAT16ObnU7nUW1jbEZka?=
 =?us-ascii?Q?bZeoPCgHXB8KNdfE6YgdmhWG9kdcs+zXMyX3TdAtS//93dLrynuKLlKvS2Km?=
 =?us-ascii?Q?m75+orVWY8Go5hwlHrXBSrT/Ax2NSYXAp0sYoXw6LiIkI7XxvhBFnMZqK76p?=
 =?us-ascii?Q?48QQspyQckPezi6Ik+i/JNhD43CRUpJpkw7JA5/VFf13WS+t8NX3JGALndn6?=
 =?us-ascii?Q?E+u1urCr0bpS63ufiKCydYHmsLB7vSzDznPCYJ0SqJi3LWPT+1G3iGV5p6pF?=
 =?us-ascii?Q?6DrkZcUX2GM8wfgNrygw2EQ7WUNHlnIi4J3Ni6EfxlZRs9wnQ/PgO/BPJSyc?=
 =?us-ascii?Q?bjJDz7DIFRuVJmIRBymGZ8ok6LPBvNGQg35dbfLKn2RSoHjIWQ1UJ76l3xx8?=
 =?us-ascii?Q?bUeo6/vrLofxnMCT+iz+ni80BMtWT+1/B4yymVaaRazcQTjeFGmxetnV+ASs?=
 =?us-ascii?Q?WVSaIxVzTLByFdqYm0eqqo0EQs9ah4J7Abo4cr6D3yLM5cKoRRiCVMnkViNT?=
 =?us-ascii?Q?hfXqjdarlFU7ypDrQ7nsIDCkGv7dwwEW+XPNqWGmuUHupnrEzvDzvZOkJLym?=
 =?us-ascii?Q?K0gvDIhBCp4/9Zwg1/1UUEiMER5VIo3XsUXoPEjt9uAVK2CkLMereATo+IYQ?=
 =?us-ascii?Q?UHrTE+iU5Okkv8dbaodyTLXula5d3vOxRa4ODi0Go1vEDGFD2+ccMp+MvZTf?=
 =?us-ascii?Q?Vm8qUfnVAIFdtAJ6nJo1jB0kCxpk3vZKSNdY4SpULhnVJ1dhG3XlPBk5UnWm?=
 =?us-ascii?Q?UebodlFFIehlNn5CASggrB8gXsXRIl9f2zCtrdhyhV/DCJX+eaURZPVkTpbm?=
 =?us-ascii?Q?r68upZq0GRNrE1nj9nfQi7smsLSQgggWrPCuc/bIHd1aq4PKj9Ol0f5RwvQD?=
 =?us-ascii?Q?8eZFFHN/UZ9fyV4zwN8dMTmEL8nW73lxrM6Dr89cl6Ir8W5bHARm1g/0Q8PW?=
 =?us-ascii?Q?vEKfNUqmmhvtTkzC3nmkAk/Qm94P?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(36860700004)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 17:11:39.0258 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5a0ecc2-04ac-4fb7-227a-08dc76946a62
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8296
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

This call is already done inside amdgpu_device_pre_asic_reset.
If should_recover_gpu is false, then vf2pf worker thread is
permanently killed.

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c | 2 --
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
index f4c47492e0cd..8b07328a4b7a 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -264,8 +264,6 @@ static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
 
 	down_write(&adev->reset_domain->sem);
 
-	amdgpu_virt_fini_data_exchange(adev);
-
 	xgpu_ai_mailbox_trans_msg(adev, IDH_READY_TO_RESET, 0, 0, 0);
 
 	do {
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index 37b49a5ed2a1..8a2f2feb5130 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -297,8 +297,6 @@ static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
 
 	down_write(&adev->reset_domain->sem);
 
-	amdgpu_virt_fini_data_exchange(adev);
-
 	xgpu_nv_mailbox_trans_msg(adev, IDH_READY_TO_RESET, 0, 0, 0);
 
 	do {
-- 
2.34.1

