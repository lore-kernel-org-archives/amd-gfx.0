Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38FC9CCD1BE
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Oct 2025 21:14:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 711E610E84B;
	Wed, 22 Oct 2025 21:14:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IczgDIvf";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010055.outbound.protection.outlook.com [52.101.85.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F92310E84B
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 21:14:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FhPCKWs2sA8JBeu5CB9/mR6DpQNdTJguxR6KuIC3wB9ky+iyizjvrLYm4uh/b5QDLiUbDrr/YL/v4WRQ18xgw/UBpYuWEbPNSkzN/T8djXMU/dmURtmhY+f1t6QZmKybpKTfaPoNckDDsLKd4j55+ynYK0a5eLKPvnGP653iDecKFRJ4O2/+JCkTcC7iK1NcPWSSVM8IVa8wp/jhPxVr1TCtSitWGSyMnyLaqkfoSnudAq64ahupiaV6OClnYXSYj8fN3Qa2ymv7lxK7JyoSuZmb/jd9rjn8rtFEzn1T8pW6BPEKKKu3ObTNqKg3U/IrvE1eIypl8SPmO5axghAVng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OxcV4vflt3NljyU9N6vOPb9k4hRaTbnC2AgkoCxbmDI=;
 b=VGtaaLtRFi+WQ6fc/QR3pDMB7wHis/ZpHq67zxrx9Iyqs3In8Ee+cbOTqBT/GIOQkKW/xyRpCk925kP1TdUSvSgcIS5O8rSC2KWkpm8U5eEqCNMzz7jZAm72V3ZwxQzmqVutsV8E48xpHYKLIjqMNf6217hZwUUqkOIn7Mzl/eDiFaNRKen5DtXCy+HF8572U6KAwnnRopbSuD7JcjUzniS2Tt4Yvi3ks+TYwq5uHNYHwAA/GIoR/hMeiajv9jrcVKCKq0LDx2x4ze6pwcJaddnsoK6y9vMlYLucByxdM72M1HhYP3a1C8BNpjuBgDUEFV6Yrt6JhZ/+NtmiMzIRxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxcV4vflt3NljyU9N6vOPb9k4hRaTbnC2AgkoCxbmDI=;
 b=IczgDIvfnGiskGhxiSAQmsD0qmE+ZhNfM0py0q9nRbqIgROG8mrVfLusY7EN0ncVGdVdjdtZRZgfpFw2isKU71EZ1zHQADAO6kGvOdUB+ih/BDaI1RmJ5aNAX3VpK7VlvNFTy1Ws098oEaS4u6I8b5r2wSMo19xcdQJnE9+Ie5g=
Received: from BL0PR1501CA0008.namprd15.prod.outlook.com
 (2603:10b6:207:17::21) by DM6PR12MB4075.namprd12.prod.outlook.com
 (2603:10b6:5:21d::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Wed, 22 Oct
 2025 21:13:56 +0000
Received: from BN3PEPF0000B073.namprd04.prod.outlook.com
 (2603:10b6:207:17:cafe::b5) by BL0PR1501CA0008.outlook.office365.com
 (2603:10b6:207:17::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Wed,
 22 Oct 2025 21:13:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B073.mail.protection.outlook.com (10.167.243.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Wed, 22 Oct 2025 21:13:55 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Oct
 2025 14:13:54 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: fix leak when we don't use the vm_fence
Date: Wed, 22 Oct 2025 17:13:42 -0400
Message-ID: <20251022211342.1785797-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B073:EE_|DM6PR12MB4075:EE_
X-MS-Office365-Filtering-Correlation-Id: 94c5c237-3b6f-4a76-2b6f-08de11afe8bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cwdvwZ+z7Dualc882X9FNxYlmo2bRzM1PFZmpV7BNb8BHE3Z8Pr/Q4TwqdMu?=
 =?us-ascii?Q?Xy63QQeUvFMGkzCcIqtRz7jC2Fdtehc6/2Gq7CDbvTbzKYnDwNtNpRa/NQkj?=
 =?us-ascii?Q?Lxo6vcYHBOYXPSGX2tMY9q48IL+nah4NHBQu5qj1xG/6H5Z2+ZNfoIQx7IKo?=
 =?us-ascii?Q?RZW57rVK6Sg0atZ7nZ9X9wnTFAV9uEOw4Kzk1j0OB6SdnUZc+otF6vItgpG2?=
 =?us-ascii?Q?ARmlmEYV4nhqhUJ5VhhJqgDcSS26+HfQOAESf+YYdtgE5GvdJC9Ea6eCZc04?=
 =?us-ascii?Q?Gn+L/zJLD6n5r52UxxLsMFouNCTmNaCquj7ras015K6ZU6XZxsfB7XnCQo3D?=
 =?us-ascii?Q?9lb0HB+DI80y6rIpfLhEiF8inRdNv2TQ/GzZNlPsVai5Fdzn3/iiUskI+K23?=
 =?us-ascii?Q?kEnziInYIdTUznVfFSetuLhUVoFMtZFtkP6vy70zhU1kAPGAqWrCHkSAJxrr?=
 =?us-ascii?Q?VyA4pQXbP0BTRnKQXeJ4O0yWq3+Pb6D5XhjmuwIrbIUNlVjjXWGdtv4NfU/l?=
 =?us-ascii?Q?7tptsLcHbc513y1vefgtgRrLc32wfBSfmH8es/TfFKaV+XpEZeNBMv0o8EJH?=
 =?us-ascii?Q?fZN5wQHh2mljNr3ENoaR5yW80ABeaKklXL7s5DLf6DdRw3cUhgjyg6Y/4GyC?=
 =?us-ascii?Q?nUzAmdZXxBt3b0epmwxVnFFKjCSwlSHPbH6g4oJuNg5PRe6mWcy7iaPUXtsw?=
 =?us-ascii?Q?o+X3XE6GhfFqsDeS6JRA+LrXMxXagZT4cl8zYCLdbUnWilVTpN8kCsjjUd3M?=
 =?us-ascii?Q?m33FIV8QXKK7y6gkDZl5WylX0/bnfq4mBJoG5dE5/hDFFEz/4N5cUcw7XSLN?=
 =?us-ascii?Q?YKaA6ayVVEsdMJCCfSjvHUntdGe/aeEdApXy6yoemJC/WIQenz3+I4j9IYaW?=
 =?us-ascii?Q?UbQm4u13KWIoYQd9D69hc4Y/ZGHez38ONoTPH9um1w6QCPC8e8VHHGcf41mo?=
 =?us-ascii?Q?ArTqgeBPBlF1Pn4kJDUAX9B7hZh+LMcY8IbDmUyOmHdInl/DK+2DqDWh5yDe?=
 =?us-ascii?Q?/ClIzAt7WHN6s6sC05UdzNMD77+UiHKAKErlCJAs+DL4zmId2oyL+1z9/ez2?=
 =?us-ascii?Q?COv3cague3Sh5jTPSw99FPQpzaEHxc4y+tWdMf7PhNF82pReBa/zFIvzc2+6?=
 =?us-ascii?Q?9JjNcbJIDgShAhgWuTX9uT3v7RikceBcF4ZlpquYB9/AAVi4XDfH4Ps2Y9p8?=
 =?us-ascii?Q?Wpzzt4fafXeLB9y/Rif8ZsApFV8x9OcJFBdLrMXsuR3oxcrprvPy9T7yaNIb?=
 =?us-ascii?Q?ESYmIdJtfn6D9lFT4ERCaUFEmSH05Eyd1k5zngRu3TQ4MarMMSGmEHs/NsEQ?=
 =?us-ascii?Q?UhzqmKduTmE0DaKD4/rBLXPpOmBakI65NPvdjbTElxXbZR5JV8C34eBlSxq7?=
 =?us-ascii?Q?VbLJI6f6hIvn9OUtDBRoD7uHWCaQE4HDDdqQ6LvnZA2oS13JbYIQ2XKGF9VE?=
 =?us-ascii?Q?2YwCKGFnSNM1BhDFwdOjYtDU2CleJDIrw5t03Vb0VQLfK/GJbbCsLeYg4mNb?=
 =?us-ascii?Q?dKD0tMw4C0ubsXN1olX9ynpJpMHXhMHq6oPZOEHlgYs15E4A0MHaapBqYONS?=
 =?us-ascii?Q?/h44PV+j6LQgmuQzTJ0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 21:13:55.4298 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94c5c237-3b6f-4a76-2b6f-08de11afe8bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4075
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

If we don't end up using the vm fence, we never initialize it
so it never gets freed.  Free it in that case.

v2: handle this in the job callbacks.

Fixes: db36632ea51e ("drm/amdgpu: clean up and unify hw fence handling")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 3d396ab625f33..8ad8b16e96760 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -295,6 +295,11 @@ static void amdgpu_job_free_cb(struct drm_sched_job *s_job)
 
 	amdgpu_sync_free(&job->explicit_sync);
 
+	if (!job->hw_fence->base.ops)
+		kfree(job->hw_fence);
+	if (!job->hw_vm_fence->base.ops)
+		kfree(job->hw_vm_fence);
+
 	kfree(job);
 }
 
@@ -324,6 +329,11 @@ void amdgpu_job_free(struct amdgpu_job *job)
 	if (job->gang_submit != &job->base.s_fence->scheduled)
 		dma_fence_put(job->gang_submit);
 
+	if (!job->hw_fence->base.ops)
+		kfree(job->hw_fence);
+	if (!job->hw_vm_fence->base.ops)
+		kfree(job->hw_vm_fence);
+
 	kfree(job);
 }
 
-- 
2.51.0

