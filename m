Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D9E3CD13D3
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2026 16:12:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20AB110F39F;
	Thu, 30 Apr 2026 16:12:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S1VdUrqE";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012052.outbound.protection.outlook.com [52.101.48.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6E1C10F39F
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2026 16:12:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=smT3zeVscyiaMCV2CTjbjP+fRc0Grw/rsw4JcmdK06zeKhu9IKLxYywdgmEuKDKCxt9Zl3XtL6weHEnVm7roPDS/lTjdEf3GKFh2uVRjO5Iio+OEVo0mNXkL9jOg+Z18dLtdWafidAPdjyCrd+AcVDNliF6y1ipp1iA0m3weDPu9yIiiZ7JS63VgFvpdpkp0/h/Lc83JqTf58HlJuaH6+EButCVrrq7tJnDx6enBOelUymvNcHmOgJFjBPLbZ5Zg/4uDL56WAp5reOhkztBYGYbHlWcznsZO6QXfruZTSj99ZdZ9NP/c3VmiZp+LtZgDH8US3HmxSdbO7Mhc+iAC4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SS1HUQ3qp9VzlcEo46lyY/6H0VZEWyavgS3xVnth6VM=;
 b=vCXBKbngZ+tACi+bU6LATxHdw6Yly6MCTraQK+aXY7rAMvchWyoW4kXd/RR7vwqS5axnrWTpeUhFFAPu8ZAJMfhv/nqqHacxqzHVKkfwDba3iJ4YTXZlUQjvTnCC77tWh7ZMUB3mYvAjcZ5fxgUlQDygXzDO8IFt1iCGV7d39LakhdJUyaBkdQP+3JSsIB8yTPL0Aaxz6LVCis90JA3FSOOfcM60/By0aNrlLo2ZjkQe+2bfakjMdx1ph3Yr9t7fu5FFj36GKFlDveZTmGtUi3Gz48HeFeW9KiWcTTh2WxD0NWrsMTpcM0RcXLRjE5K4oX63+shChWaQb3djkza1vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SS1HUQ3qp9VzlcEo46lyY/6H0VZEWyavgS3xVnth6VM=;
 b=S1VdUrqEBQgnw5zFQA6vRJYbGwnd7vzavIyJ1NMxUsUBad/4Y73TOzEJz4xG9EAG0XNTEnYiwY3pimZJ/iRPOA2VkVIlZx4N/ghwT8mu6S3cH6mSGnRegdpxzLTidtDoh9lTH0Isf3659bkaoaIdQjNw3FSIlDdQ9sod+M1KGtU=
Received: from CH5P220CA0023.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::20)
 by DS3PR12MB999215.namprd12.prod.outlook.com (2603:10b6:8:38f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 16:12:17 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:610:1ef:cafe::54) by CH5P220CA0023.outlook.office365.com
 (2603:10b6:610:1ef::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.21 via Frontend Transport; Thu,
 30 Apr 2026 16:12:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.22 via Frontend Transport; Thu, 30 Apr 2026 16:12:16 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 30 Apr
 2026 11:12:13 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 30 Apr
 2026 11:12:13 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 30 Apr 2026 11:12:07 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.zhang <Jesse.zhang@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v4 04/10] drm/amdgpu/mes_userqueue: mark SDMA UMQs as
 user-mode submission
Date: Fri, 1 May 2026 00:03:32 +0800
Message-ID: <20260430161146.2851078-4-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260430161146.2851078-1-Jesse.Zhang@amd.com>
References: <20260430161146.2851078-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="Y"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|DS3PR12MB999215:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b388ed4-c508-49a8-1e99-08dea6d33f34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: hcuEC6PVRUpPxduaNxg+0JeFqIFKSsBSzH26rdo6zprluosnrHuyyWHk/Oy1vXrX6mD3JUHbcxZ3o0AG2mAmEvqpudpN8b47+p+jB33mZXLMjOUbNKvIKLBsoNEKUgAQX6Omu/xhbA/ZbOYyJY6YSIEBdHdwFr4wjodXmVcc3Dn9Qfo4NxlsdnoFk9tFTt7mciX1ZaQbuqDqQlh83RO3Z3U0fyFeHF7kCX770d4B/K2/YLE3FAFH7YMMsPpKCvYlAC8Np2WISMDhjxCXVpuGWvrfk1ObJy2uQfLhR2mrDix4ihPJ1ykcrgbjchGdRemy4NPmYI14DS6KNdBnPtxF5n0gXj29+PMb2rT0UBwaANZXsUKKoyoDGURi2AgndhK0EOjIqYqtKjlv/Nf6jl2dS4uldk4YZkC1/rBkXIDSmAOvfO11rfBkMizRLvS3Q6EB56DBmSYxK3QjEzlB+d4DfpYlQx8lHufeVdCtjsnfGJXatcMCF1URKZX1EdDCvWOc3sN2yYzo67HovK1FN7+q/Yq7mvcAsEUQTZAP5fuAkW7/ioK8HwdJI1AirUR4q6LB2RkzxrS/HcY2fY2LrBM9EsSxt7BbVeQbYVIN6VGn+t/XhzB7/UA+tVEkAXpZZRdjr0ZNk9bsHyytNs3EncsdDGYIQCavFPXWpdNVgQ2TKdehQu4qJi1lRsGFvK8rk4gM544+A7nlH3zW3wSPPIdqsBokJwcfluLBMxuw/7AIL+VW8Q4W6dKTLYcCt+ccdkIaLwcZ1yg8qpaZXE18Cc2nkQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VktmCccQOK7K7Ahh3SA+6ctT4Uipvr+IAE0XjTm04xQdk1wZ3kRcs8TkNWzWTNdSOTeJI6tlBz2kl9bNy6QNeWTQDhuckjRQHasdjEbgW3KyL5i6Kigf45FZIvAOmyNfUed8ikWO7L6P8+uWO0fgsLcDoertUhGvPP2efZUnBZ6YeE4csz827U+R3QuywNoEVS7RSATouz4iZAN69y8nf3SXnWwyddLv7lOEp8SZrhhzf3VgJRV/7c+oug8V7BQnDdkmW4jjG3dZP2ddWlP2pLahOqgT+b1qu9JGVfZ6HmDg+D8PWQeShXdClev7CEqhWZsNAUMLTzl+Pw+3obX7oM1LQqSryumPMW146iI7AWsO3Fyaf3PMI/9Xg9efOvHil+3ph43dYRVbElPlPFH3e7Z/mOnZRltu6q+zEjMiOHZIyo6dNF1YpQQ3X2lexGVp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 16:12:16.1520 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b388ed4-c508-49a8-1e99-08dea6d33f34
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR12MB999215
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

From: "Jesse.zhang" <Jesse.zhang@amd.com>

For AMDGPU_HW_IP_DMA queues, set mes_add_queue_input.is_user_mode_submission
and a stable unmap_flag_addr (a kernel-owned dword in the MQD
object's tail padding).  This tells MES to use the new wptr_mc /
unmap_flag scheme so the PROTECTED_FENCE at the tail of every SDMA
IB no longer terminates the queue.  Combined with the
NOTIFY_WORK_ON_UNMAPPED_QUEUE wakeup added in a follow-up patch, this
lets multi-IB submissions on a single SDMA UMQ work end-to-end.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index d12cd1b7790b..3dbcddb46b24 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -165,6 +165,28 @@ static int mes_userq_map(struct amdgpu_usermode_queue *queue)
 	queue_input.doorbell_offset = userq_props->doorbell_index;
 	queue_input.page_table_base_addr = amdgpu_gmc_pd_addr(queue->vm->root.bo);
 	queue_input.wptr_mc_addr = queue->wptr_obj.gpu_addr;
+	/*
+	 * SDMA UMQs need is_user_mode_submission so MES treats them as user
+	 * queues (using the new wptr_mc_addr / unmap_flag_addr scheme).
+	 * Without this MES uses end-of-MQD for unmap_flag, sees PROTECTED_FENCE
+	 * as a "queue done" signal, and gangs the queue out forever.  Combined
+	 * with NOTIFY_WORK_ON_UNMAPPED_QUEUE poke from amdgpu_userq_signal_ioctl
+	 * this lets multi-IB submissions work.  Use queue->mqd.gpu_addr +
+	 * mqd_size as a stable kernel-owned location for unmap_flag — userspace
+	 * never reads it; the kernel just needs SOMETHING valid to give MES.
+	 */
+	if (queue->queue_type == AMDGPU_HW_IP_DMA) {
+		queue_input.is_user_mode_submission = 1;
+		/*
+		 * Same offset MES would derive in legacy mode
+		 * (get_unmap_flag_addr_from_end_of_mqd in MES src 12).  Lives
+		 * inside the allocated MQD object's tail padding so it's a
+		 * valid MC address; the kernel never reads it back — its only
+		 * purpose is to keep MES happy.
+		 */
+		queue_input.unmap_flag_addr = queue->mqd.gpu_addr +
+			adev->mqds[queue->queue_type].mqd_size + sizeof(u32);
+	}
 
 	amdgpu_mes_lock(&adev->mes);
 	r = adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
-- 
2.49.0

