Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC68EC2BB85
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jun 2024 15:30:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5979410E6E8;
	Tue, 18 Jun 2024 15:30:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0hVA3C/l";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77F9A10E6E8
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jun 2024 15:30:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ICV85J2TPg2qiBtL9XiABxL0ZRRWpmDcYdzWgaRhklrQKTT8E+7C2UdD3AqWeER1XrNobkvGmNXVLpaXup6SUGMHI4o3WmY04lAhor5SkGbCVPgUPzE5yI3y/xcxwLF3mwkijhoOLwT+ER8Aa/6HEksQEgR3TrwUHdvp+StwLJqSdE/SkLcDQvYNl+1qXTJ99LimbWCe1kAXabq5ie37CzWD+Bi8JiJKwBJ2mQja3tdMlbTTRgVJBIP787NjFaaFk756CRw76W54ER5Dv+Y2Zy2YCAkETtk3CdfrMOw4+jpncus4EVeca6KtUggi7P7pfffQIlFTmKwQ6hBswv3OpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=asI2GJGHjvx89vOfwXVJ99V/qdL8epUzMKVz9hAEIpY=;
 b=eCTtZ7RAm5/m2DVsLiQwyFBppTAsfu+lSh0Lp7ZJ4qhtx0DgpVXOEhDFldAoFi1Nu7miu483WCE/mdXwsdVFl0lJQLw4R2KRKmJsAojUoH8/G1KcmWOQgpHjv9PbT+5rbgk5vr14Vjw/W2hm9XndQAezAffV8WxwQN9gr0sP895MC6gxic4KiW3mS4cxZDsmPjsIqyUhTb5TIVyyDeFXmNa7jQoXf0TxXEPP1EifTjBOinpUkDbJQXF0F/mRvm1zDYqJxnMkf+Kx05uBE5NVaYuqRvob2tnKYuCgeLTF2E0t5MgghRaHJTRf4kHI8s0H4Vs0XSBFAFNnFW0hFKf6+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=asI2GJGHjvx89vOfwXVJ99V/qdL8epUzMKVz9hAEIpY=;
 b=0hVA3C/lJGDlMIQCdUMzKncnv3A31tsFophqzV8IxtE82DgnXJTSg1JEgXFnMaXRo1OKNn+g1bzgZf5agPSixg6Fvkqc0fDkYCrSIpAVDBsZzWZPs5olqFYSgt2Ds/UOCZpBCp1paW4GG1+sOf9jxq/rykx6oAPTFckCrZ6L8u8=
Received: from PH7P220CA0107.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::13)
 by SA1PR12MB8945.namprd12.prod.outlook.com (2603:10b6:806:375::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 15:30:53 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:510:32d:cafe::9) by PH7P220CA0107.outlook.office365.com
 (2603:10b6:510:32d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Tue, 18 Jun 2024 15:30:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 18 Jun 2024 15:30:52 +0000
Received: from patedamande.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Jun
 2024 10:30:50 -0500
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Subject: [PATCH 6/6] drm/amdgpu: resume the device from amdgpu_gem_fault
Date: Tue, 18 Jun 2024 17:23:27 +0200
Message-ID: <20240618153003.146168-7-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240618153003.146168-1-pierre-eric.pelloux-prayer@amd.com>
References: <20240618153003.146168-1-pierre-eric.pelloux-prayer@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|SA1PR12MB8945:EE_
X-MS-Office365-Filtering-Correlation-Id: f1bb13ea-276f-43b4-4beb-08dc8faba3ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|36860700010|1800799021|376011|82310400023; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TZQ8qYQMPBSNaQD9vaeh2NInnQG6/Lz7qB3sQkHB/SzeS5z/TUc13G6NI8iw?=
 =?us-ascii?Q?adKmJydG8iom1DXNL0zFA6dWV4vbtCQzcAVkxLe3MTDBv886KyqxtAuoKSwc?=
 =?us-ascii?Q?4ZetJaTdI8gyePlblRFFRk5b/GDmYtvB1+qSA0G4pfi2clPm3BuDxwprTkoG?=
 =?us-ascii?Q?NxyKxJp8MXNZYFkdETYwMICrviUCOywUMlFit9NxQlhdh+s4UwwFJgr+pxV5?=
 =?us-ascii?Q?w9cOWjAx8Bkn2s4N9czs/DV+BtJEfAS2+KYrYBW0q00INEnVJs2bikJtfRj2?=
 =?us-ascii?Q?blhgRpCwBR/t9TNIdrx3ef0UPfkbLiyu6XpN1oGpR+1rGDThxeK+5VNb2wgs?=
 =?us-ascii?Q?41WLxSZtZVJBHbPcsY5EeNKQv2ekl/nAWnRQiQTECAu2FQ7l83i65WozpotX?=
 =?us-ascii?Q?dDmzRlThkVEt+6vVIH0xF7raxUe/CRGNpsgR543LWUwUDJhVEne2lDugwRbF?=
 =?us-ascii?Q?bY+vc5erhPiyR2rQbuSRs8bjqfkYNR+2a0OagMdNWbDq3wqEJBpPUOX9iSnr?=
 =?us-ascii?Q?tJHS9lMVLqPhJJl4Arzzu9CBbYTGa83fZAKDaJ6XW0HbCdobxtQp0t34/+/h?=
 =?us-ascii?Q?4f47JA7HPYwdKAiq0DnM/m7oAJL0zyXrzlLzGY1UCORB2RcgKYbKWGKJSYzQ?=
 =?us-ascii?Q?Z3fRCOVXJ2lyjVQCWEQ9PdAE8MbTNwfpQ05u6JqSL2wzR8eFvCBokNtW51om?=
 =?us-ascii?Q?0KG01iZ+R7Vu2EDDozE6GCVElCBqJZ9OZp1VCGP+6w/yhRYMsCrZOzmlNI4G?=
 =?us-ascii?Q?Szj0brmiVOkgZXoxuL0JtGQXogj0jqRjbEFMMceqMFZmH/QG0njaRTXRT53U?=
 =?us-ascii?Q?Wq5d4l/LXBHG6C+zQiU2oIEDmb5x/AzlvGY00X7iePgCNPq3F+fKgTF6MssN?=
 =?us-ascii?Q?PhMH+aZZMkv43XYbegGrWfjx/sfT+GzB0rrQ8t8VrwLn+mYDcrje//LQu+vf?=
 =?us-ascii?Q?mOZ907/c+wz4lyZ6FUAjp3Qc3SFo5gBPo1qxYU107fv4LOOS/ezRgyze4xZl?=
 =?us-ascii?Q?CnLSTDlIMRoMTyYBznakh5XEgX2EfldxvDpTt8CjPNzQhd4h+UFpPbDXg2nj?=
 =?us-ascii?Q?Rm3hm+L+BUOXhTulnyK7TCvypSmOe/7YUe4p+Cg//M7Hqt1Lk/+CG+wFi6Ok?=
 =?us-ascii?Q?sVgTsGCZ+JDAtnQc+wiAIETAdK1h9XH35JE/eVVZN1JeK1jFAxxq6dUInce7?=
 =?us-ascii?Q?oy3Jcdof/ZxZi6nw0O0BPXfXbNCbpJPFPQKWy7ddRXlhNHJTFsTxlrYVxmpF?=
 =?us-ascii?Q?gP76CCun4zReYisoT6gfJOZw3MJ4frWp2qN8fN5iMxCzxwMv9fYzlYHFdgvQ?=
 =?us-ascii?Q?W+6cC5VdjbLFhiGxdm6sOoFc/ao1DnANU7wfX7vdmGMpVr+6kBdvVqdGMLR/?=
 =?us-ascii?Q?DuYS2NkWL12Wom0LsklRyGJn8sg6VVFKiKlCbPpwY7JmT+rbyA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(36860700010)(1800799021)(376011)(82310400023); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 15:30:52.7280 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1bb13ea-276f-43b4-4beb-08dc8faba3ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8945
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

The fault handler may push some work to the GPU through amdgpu_bo_move
so use the pm_runtime functions before that.

Since we're in an interrupt context, we can't use the sync version,
so pm_runtime_get is called.

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 1f22b4208729..ec120e33536d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -30,6 +30,7 @@
 #include <linux/pagemap.h>
 #include <linux/pci.h>
 #include <linux/dma-buf.h>
+#include <linux/pm_runtime.h>
 
 #include <drm/amdgpu_drm.h>
 #include <drm/drm_drv.h>
@@ -52,9 +53,13 @@ static vm_fault_t amdgpu_gem_fault(struct vm_fault *vmf)
 	vm_fault_t ret;
 	int idx;
 
+	ret = pm_runtime_get(ddev->dev);
+	if (ret < 0)
+		return ret;
+
 	ret = ttm_bo_vm_reserve(bo, vmf);
 	if (ret)
-		return ret;
+		goto put_pm;
 
 	if (drm_dev_enter(ddev, &idx)) {
 		ret = amdgpu_bo_fault_reserve_notify(bo);
@@ -71,10 +76,14 @@ static vm_fault_t amdgpu_gem_fault(struct vm_fault *vmf)
 		ret = ttm_bo_vm_dummy_page(vmf, vmf->vma->vm_page_prot);
 	}
 	if (ret == VM_FAULT_RETRY && !(vmf->flags & FAULT_FLAG_RETRY_NOWAIT))
-		return ret;
+		goto put_pm;
 
 unlock:
 	dma_resv_unlock(bo->base.resv);
+put_pm:
+	pm_runtime_mark_last_busy(ddev->dev);
+	pm_runtime_put_autosuspend(ddev->dev);
+
 	return ret;
 }
 
-- 
2.40.1

